From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC] Per file OOM badness
Date: Wed, 24 Jan 2018 12:01:41 +0100
Message-ID: <20180124110141.GA28465@dhcp22.suse.cz>
References: <1516294072-17841-1-git-send-email-andrey.grodzovsky@amd.com>
 <20180118170006.GG6584@dhcp22.suse.cz>
 <20180123152659.GA21817@castle.DHCP.thefacebook.com>
 <20180123153631.GR1526@dhcp22.suse.cz>
 <ccac4870-ced3-f169-17df-2ab5da468bf0@daenzer.net>
 <20180124092847.GI1526@dhcp22.suse.cz>
 <583f328e-ff46-c6a4-8548-064259995766@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <583f328e-ff46-c6a4-8548-064259995766@daenzer.net>
Sender: owner-linux-mm@kvack.org
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Christian.Koenig@amd.com, linux-mm@kvack.org, amd-gfx@lists.freedesktop.org, Roman Gushchin <guro@fb.com>
List-Id: amd-gfx.lists.freedesktop.org

On Wed 24-01-18 11:27:15, Michel Dänzer wrote:
> On 2018-01-24 10:28 AM, Michal Hocko wrote:
[...]
> > So how exactly then helps to kill one of those processes? The memory
> > stays pinned behind or do I still misunderstand?
> 
> Fundamentally, the memory is only released once all references to the
> BOs are dropped. That's true no matter how the memory is accounted for
> between the processes referencing the BO.
> 
> 
> In practice, this should be fine:
> 
> 1. The amount of memory used for shared BOs is normally small compared
> to the amount of memory used for non-shared BOs (and other things). So
> regardless of how shared BOs are accounted for, the OOM killer should
> first target the process which is responsible for more memory overall.

OK. So this is essentially the same as with the normal shared memory
which is a part of the RSS in general.

> 2. If the OOM killer kills a process which is sharing BOs with another
> process, this should result in the other process dropping its references
> to the BOs as well, at which point the memory is released.

OK. How exactly are those BOs mapped to the userspace?
-- 
Michal Hocko
SUSE Labs

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
