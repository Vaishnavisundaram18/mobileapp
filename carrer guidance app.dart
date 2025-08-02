import { useState } from 'react'
import { Button } from "/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "/components/ui/card"
import { Input } from "/components/ui/input"
import { Label } from "/components/ui/label"
import { Textarea } from "@/components/ui/textarea"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { Badge } from "@/components/ui/badge"
import { Star, Users, Clock, Search, BookOpen, Briefcase, TrendingUp } from 'lucide-react'

interface Career {
  id: string
  title: string
  description: string
  skills: string[]
  interests: string[]
  education: string
  salary: string
  growth: string
  resources: string[]
}

const careers: Career[] = [
  {
    id: '1',
    title: 'Software Developer',
    description: 'Design, develop, and maintain software applications and systems.',
    skills: ['programming', 'problem-solving', 'analytical-thinking', 'teamwork'],
    interests: ['technology', 'computers', 'innovation', 'logic'],
    education: "Bachelor's in Computer Science",
    salary: '$70,000 - $150,000',
    growth: '22% (Much faster than average)',
    resources: ['freeCodeCamp.org', 'Codecademy', 'LeetCode', 'GitHub']
  },
  {
    id: '2',
    title: 'Data Scientist',
    description: 'Analyze complex data to help organizations make better decisions.',
    skills: ['statistics', 'python', 'machine-learning', 'data-analysis'],
    interests: ['math', 'patterns', 'research', 'technology'],
    education: "Bachelor's in Statistics, Math, or Computer Science",
    salary: '$95,000 - $165,000',
    growth: '35% (Much faster than average)',
    resources: ['Kaggle', 'Coursera Data Science', 'Towards Data Science', 'DataCamp']
  },
  {
    id: '3',
    title: 'UX Designer',
    description: 'Create user-friendly interfaces and experiences for digital products.',
    skills: ['design', 'user-research', 'prototyping', 'communication'],
    interests: ['creativity', 'psychology', 'technology', 'art'],
    education: "Bachelor's in Design, Psychology, or related field",
    salary: '$60,000 - $130,000',
    growth: '13% (Faster than average)',
    resources: ['UX Design Institute', 'Nielsen Norman Group', 'Figma Community', 'UX Collective']
  },
  {
    id: '4',
    title: 'Marketing Manager',
    description: 'Develop and execute marketing strategies to promote products or services.',
    skills: ['communication', 'creativity', 'analytics', 'leadership'],
    interests: ['business', 'psychology', 'social-media', 'strategy'],
    education: "Bachelor's in Marketing, Business, or Communications",
    salary: '$65,000 - $140,000',
    growth: '10% (Faster than average)',
    resources: ['HubSpot Academy', 'Google Digital Garage', 'Marketing Land', 'Adweek']
  },
  {
    id: '5',
    title: 'Teacher',
    description: 'Educate and inspire students in various subjects and grade levels.',
    skills: ['communication', 'patience', 'organization', 'leadership'],
    interests: ['helping-others', 'learning', 'children', 'education'],
    education: "Bachelor's in Education + Teaching Certificate",
    salary: '$40,000 - $80,000',
    growth: '5% (Average)',
    resources: ['Khan Academy', 'Teachers Pay Teachers', 'Edutopia', 'NEA.org']
  }
]

export default function CareerGuidanceApp() {
  const [userSkills, setUserSkills] = useState<string[]>([])
  const [userInterests, setUserInterests] = useState<string[]>([])
  const [skillInput, setSkillInput] = useState('')
  const [interestInput, setInterestInput] = useState('')
  const [educationLevel, setEducationLevel] = useState('')
  const [recommendedCareers, setRecommendedCareers] = useState<Career[]>([])
  const [selectedCareer, setSelectedCareer] = useState<Career | null>(null)

  const addSkill = () => {
    if (skillInput.trim() && !userSkills.includes(skillInput.trim().toLowerCase())) {
      setUserSkills([...userSkills, skillInput.trim().toLowerCase()])
      setSkillInput('')
    }
  }

  const addInterest = () => {
    if (interestInput.trim() && !userInterests.includes(interestInput.trim().toLowerCase())) {
      setUserInterests([...userInterests, interestInput.trim().toLowerCase()])
      setInterestInput('')
    }
  }

  const removeSkill = (skill: string) => {
    setUserSkills(userSkills.filter(s => s !== skill))
  }

  const removeInterest = (interest: string) => {
    setUserInterests(userInterests.filter(i => i !== interest))
  }

  const findCareers = () => {
    const matches = careers.map(career => {
      const skillMatches = career.skills.filter(skill => 
        userSkills.some(userSkill => skill.includes(userSkill))
      ).length
      const interestMatches = career.interests.filter(interest => 
        userInterests.some(userInterest => interest.includes(userInterest))
      ).length
      return { career, score: skillMatches + interestMatches }
    })
    
    const sortedMatches = matches
      .filter(match => match.score > 0)
      .sort((a, b) => b.score - a.score)
      .map(match => match.career)
    
    setRecommendedCareers(sortedMatches)
    setSelectedCareer(null)
  }

  const resetForm = () => {
    setUserSkills([])
    setUserInterests([])
    setSkillInput('')
    setInterestInput('')
    setEducationLevel('')
    setRecommendedCareers([])
    setSelectedCareer(null)
  }

  return (
    <div className="min-h-screen bg-gray-50 py-8 px-4">
      <div className="max-w-6xl mx-auto">
        <Card className="mb-8">
          <CardHeader>
            <CardTitle className="text-3xl font-bold text-center">Career Guidance Assistant</CardTitle>
            <CardDescription className="text-center text-lg">
              Discover your ideal career path based on your skills and interests
            </CardDescription>
          </CardHeader>
        </Card>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
          {/* Input Section */}
          <Card>
            <CardHeader>
              <CardTitle>Tell Us About Yourself</CardTitle>
            </CardHeader>
            <CardContent className="space-y-6">
              {/* Skills Input */}
              <div>
                <Label htmlFor="skills">Your Skills</Label>
                <div className="flex gap-2 mt-2">
                  <Input
                    id="skills"
                    value={skillInput}
                    onChange={(e) => setSkillInput(e.target.value)}
                    onKeyPress={(e) => e.key === 'Enter' && addSkill()}
                    placeholder="e.g., programming, design, communication"
                  />
                  <Button onClick={addSkill} size="sm">Add</Button>
                </div>
                <div className="flex flex-wrap gap-2 mt-2">
                  {userSkills.map(skill => (
                    <Badge key={skill} variant="secondary" className="cursor-pointer" onClick={() => removeSkill(skill)}>
                      {skill} ×
                    </Badge>
                  ))}
                </div>
              </div>

              {/* Interests Input */}
              <div>
                <Label htmlFor="interests">Your Interests</Label>
                <div className="flex gap-2 mt-2">
                  <Input
                    id="interests"
                    value={interestInput}
                    onChange={(e) => setInterestInput(e.target.value)}
                    onKeyPress={(e) => e.key === 'Enter' && addInterest()}
                    placeholder="e.g., technology, helping others, creativity"
                  />
                  <Button onClick={addInterest} size="sm">Add</Button>
                </div>
                <div className="flex flex-wrap gap-2 mt-2">
                  {userInterests.map(interest => (
                    <Badge key={interest} variant="secondary" className="cursor-pointer" onClick={() => removeInterest(interest)}>
                      {interest} ×
                    </Badge>
                  ))}
                </div>
              </div>

              {/* Education Level */}
              <div>
                <Label htmlFor="education">Current Education Level</Label>
                <Select value={educationLevel} onValueChange={setEducationLevel}>
                  <SelectTrigger className="mt-2">
                    <SelectValue placeholder="Select your education level" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="high-school">High School</SelectItem>
                    <SelectItem value="bachelors">Bachelor's Degree</SelectItem>
                    <SelectItem value="masters">Master's Degree</SelectItem>
                    <SelectItem value="phd">PhD</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <div className="flex gap-2">
                <Button onClick={findCareers} className="flex-1">
                  <Search className="w-4 h-4 mr-2" />
                  Find Careers
                </Button>
                <Button onClick={resetForm} variant="outline">
                  Reset
                </Button>
              </div>
            </CardContent>
          </Card>

          {/* Results Section */}
          <Card>
            <CardHeader>
              <CardTitle>Recommended Careers</CardTitle>
            </CardHeader>
            <CardContent>
              {recommendedCareers.length === 0 && (
                <p className="text-center text-gray-500 py-8">
                  Add your skills and interests to see career recommendations
                </p>
              )}
              
              {recommendedCareers.length > 0 && !selectedCareer && (
                <div className="space-y-4">
                  {recommendedCareers.map(career => (
                    <Card 
                      key={career.id} 
                      className="cursor-pointer hover:shadow-md transition-shadow"
                      onClick={() => setSelectedCareer(career)}
                    >
                      <CardContent className="pt-4">
                        <h3 className="font-semibold text-lg">{career.title}</h3>
                        <p className="text-sm text-gray-600 mt-1">{career.description}</p>
                        <div className="flex items-center gap-4 mt-2 text-sm text-gray-500">
                          <span className="flex items-center gap-1">
                            <Briefcase className="w-4 h-4" />
                            {career.salary}
                          </span>
                          <span className="flex items-center gap-1">
                            <TrendingUp className="w-4 h-4" />
                            {career.growth}
                          </span>
                        </div>
                      </CardContent>
                    </Card>
                  ))}
                </div>
              )}

              {selectedCareer && (
                <div className="space-y-4">
                  <Button 
                    variant="ghost" 
                    onClick={() => setSelectedCareer(null)}
                    className="mb-2"
                  >
                    ← Back to recommendations
                  </Button>
                  
                  <div>
                    <h3 className="text-2xl font-bold mb-2">{selectedCareer.title}</h3>
                    <p className="text-gray-600 mb-4">{selectedCareer.description}</p>
                    
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
                      <div>
                        <h4 className="font-semibold mb-2 flex items-center gap-2">
                          <Users className="w-4 h-4" />
                          Required Skills
                        </h4>
                        <div className="flex flex-wrap gap-1">
                          {selectedCareer.skills.map(skill => (
                            <Badge key={skill} variant="outline">{skill}</Badge>
                          ))}
                        </div>
                      </div>
                      
                      <div>
                        <h4 className="font-semibold mb-2 flex items-center gap-2">
                          <Star className="w-4 h-4" />
                          Interests Match
                        </h4>
                        <div className="flex flex-wrap gap-1">
                          {selectedCareer.interests.map(interest => (
                            <Badge key={interest} variant="outline">{interest}</Badge>
                          ))}
                        </div>
                      </div>
                    </div>

                    <div className="space-y-2 mb-4">
                      <div className="flex items-center gap-2">
                        <BookOpen className="w-4 h-4 text-gray-500" />
                        <span className="font-semibold">Education Required:</span>
                        <span>{selectedCareer.education}</span>
                      </div>
                      <div className="flex items-center gap-2">
                        <Briefcase className="w-4 h-4 text-gray-500" />
                        <span className="font-semibold">Salary Range:</span>
                        <span>{selectedCareer.salary}</span>
                      </div>
                      <div className="flex items-center gap-2">
                        <TrendingUp className="w-4 h-4 text-gray-500" />
                        <span className="font-semibold">Job Growth:</span>
                        <span>{selectedCareer.growth}</span>
                      </div>
                    </div>

                    <div>
                      <h4 className="font-semibold mb-2">Learning Resources</h4>
                      <ul className="space-y-1">
                        {selectedCareer.resources.map(resource => (
                          <li key={resource} className="text-sm text-blue-600 hover:underline cursor-pointer">
                            {resource}
                          </li>
                        ))}
                      </ul>
                    </div>
                  </div>
                </div>
              )}
            </CardContent>
          </Card>
        </div>
      </div>
    </div>
  )
}