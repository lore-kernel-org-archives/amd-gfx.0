From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC] Per file OOM badness
Date: Fri, 19 Jan 2018 09:25:17 +0100
Message-ID: <20180119082517.GM6584@dhcp22.suse.cz>
References: <1516294072-17841-1-git-send-email-andrey.grodzovsky@amd.com>
 <20180118170006.GG6584@dhcp22.suse.cz>
 <20180118171355.GH6584@dhcp22.suse.cz>
 <DM5PR1201MB01216B72BEF121DD25AB7247FDEF0@DM5PR1201MB0121.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <DM5PR1201MB01216B72BEF121DD25AB7247FDEF0@DM5PR1201MB0121.namprd12.prod.outlook.com>
Sender: owner-linux-mm@kvack.org
To: "He, Roger" <Hongbo.He@amd.com>
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Koenig, Christian" <Christian.Koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

[removed the broken quoting - please try to use an email client which
doesn't mess up the qouted text]

On Fri 19-01-18 06:01:26, He, Roger wrote:
[...]
> I think you are misunderstanding here.
> Actually for now, the memory in TTM Pools already has mm_shrink which is implemented in ttm_pool_mm_shrink_init.
> And here the memory we want to make it contribute to OOM badness is not in TTM Pools.
> Because when TTM buffer allocation success, the memory already is removed from TTM Pools.  

I have no idea what TTM buffers are. But this smells like something
rather specific to the particular subsytem. And my main objection here
is that struct file is not a proper vehicle to carry such an
information. So whatever the TTM subsystem does it should contribute to
generic counters rather than abuse fd because it happens to use it to
communicate with userspace.
-- 
Michal Hocko
SUSE Labs

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
