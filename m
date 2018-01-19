From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC] Per file OOM badness
Date: Fri, 19 Jan 2018 11:40:58 +0100
Message-ID: <20180119104058.GU6584@dhcp22.suse.cz>
References: <1516294072-17841-1-git-send-email-andrey.grodzovsky@amd.com>
 <20180118170006.GG6584@dhcp22.suse.cz>
 <20180118171355.GH6584@dhcp22.suse.cz>
 <87k1wfgcmb.fsf@anholt.net>
 <20180119082046.GL6584@dhcp22.suse.cz>
 <0cfaf256-928c-4cb8-8220-b8992592071b@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <0cfaf256-928c-4cb8-8220-b8992592071b@amd.com>
Sender: owner-linux-mm@kvack.org
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Eric Anholt <eric@anholt.net>, Andrey Grodzovsky <andrey.grodzovsky@amd.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

On Fri 19-01-18 09:39:03, Christian König wrote:
> Am 19.01.2018 um 09:20 schrieb Michal Hocko:
[...]
> > OK, in that case I would propose a different approach. We already
> > have rss_stat. So why do not we simply add a new counter there
> > MM_KERNELPAGES and consider those in oom_badness? The rule would be
> > that such a memory is bound to the process life time. I guess we will
> > find more users for this later.
> 
> I already tried that and the problem with that approach is that some buffers
> are not created by the application which actually uses them.
> 
> For example X/Wayland is creating and handing out render buffers to
> application which want to use OpenGL.
> 
> So the result is when you always account the application who created the
> buffer the OOM killer will certainly reap X/Wayland first. And that is
> exactly what we want to avoid here.

Then you have to find the target allocation context at the time of the
allocation and account it. As follow up emails show, implementations
might differ and any robust oom solution have to rely on the common
counters.
-- 
Michal Hocko
SUSE Labs

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
