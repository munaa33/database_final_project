# African Authors Library Database

A comprehensive MySQL database designed to catalog and preserve information about Africa's greatest literary figures and their contributions to world literature.

## Overview

This database serves as a digital repository for African literary heritage, documenting authors, their works, literary movements, themes, and critical reception. The system enables researchers, educators, students, and literature enthusiasts to explore the rich tapestry of African literature through multiple interconnected dimensions.

## Database Structure

The database consists of 15 tables that capture different aspects of African literary history:

1. **authors** - Biographical information about prominent African writers
2. **countries** - Data about African nations and their literary traditions
3. **books** - Details about published works by African authors
4. **publishers** - Information about publishing houses focused on African literature
5. **genres** - Literary categories and styles prevalent in African writing
6. **book_genres** - Linking books to their respective genres
7. **awards** - Literary prizes and recognitions in the African context
8. **author_awards** - Records of awards received by authors
9. **literary_movements** - African literary movements and their historical context
10. **author_movements** - Authors' associations with literary movements
11. **themes** - Common themes explored in African literature
12. **book_themes** - Themes addressed in specific books
13. **adaptations** - Adaptations of African literary works to other media
14. **reviews** - Critical reception and ratings of African literary works
15. **academic_citations** - Scholarly references to African authors and works

## Features

- **Comprehensive Author Profiles**: Store detailed biographical information about authors including nationality, birth/death dates, and complete biographies
- **Literary Context**: Track literary movements, themes, and genres to understand African literature in its cultural and historical context
- **Critical Reception**: Document awards, reviews, and academic citations to gauge impact and recognition
- **Media Adaptations**: Record film, TV, theater, and other adaptations of literary works
- **Relational Structure**: Explore connections between authors, works, movements, and themes through a robust relational design

## Usage Examples

- Track the evolution of post-colonial literature across different African regions
- Compare thematic elements in works by authors from different generations
- Research the influence and recognition of female African writers over time
- Analyze the relationship between literary movements and historical events
- Explore how specific works have been received by critics and scholars

## Technical Details

- **Database System**: MySQL
- **Character Set**: UTF-8 (to properly handle names and texts in various African languages)
- **Database Diagram**: Available in dbdiagram.io format

## Future Extensions

Potential enhancements for the database include:

- Adding tables for literary characters and motifs
- Incorporating text analysis results and linguistic features
- Expanding to include multimedia content (recordings of readings, interviews)
- Adding support for translations and different editions
- Implementing a geographic information component to visualize literary landscapes

---

This project aims to contribute to the preservation and accessibility of Africa's literary heritage while facilitating research and appreciation of the continent's rich literary traditions.