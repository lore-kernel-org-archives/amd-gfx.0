From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Subject: Re: [RFC] Per file OOM badness
Date: Fri, 19 Jan 2018 09:35:47 +0100
Message-ID: <47fd8d6f-1c0e-388c-8c3d-a8784f8090ca@amd.com>
References: <1516294072-17841-1-git-send-email-andrey.grodzovsky@amd.com>
 <20180118170006.GG6584@dhcp22.suse.cz> <20180118171355.GH6584@dhcp22.suse.cz>
 <87k1wfgcmb.fsf@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <87k1wfgcmb.fsf@anholt.net>
Content-Language: en-US
Sender: owner-linux-mm@kvack.org
To: Eric Anholt <eric@anholt.net>, Michal Hocko <mhocko@kernel.org>, Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

Am 18.01.2018 um 21:01 schrieb Eric Anholt:
> Michal Hocko <mhocko@kernel.org> writes:
>
>> [SNIP]
>> But files are not killable, they can be shared... In other words this
>> doesn't help the oom killer to make an educated guess at all.
> Maybe some more context would help the discussion?

Thanks for doing this. Wanted to reply yesterday with that information 
as well, but was unfortunately on sick leave.

>
> The struct file in patch 3 is the DRM fd.  That's effectively "my
> process's interface to talking to the GPU" not "a single GPU resource".
> Once that file is closed, all of the process's private, idle GPU buffers
> will be immediately freed (this will be most of their allocations), and
> some will be freed once the GPU completes some work (this will be most
> of the rest of their allocations).
>
> Some GEM BOs won't be freed just by closing the fd, if they've been
> shared between processes.  Those are usually about 8-24MB total in a
> process, rather than the GBs that modern apps use (or that our testcases
> like to allocate and thus trigger oomkilling of the test harness instead
> of the offending testcase...)
>
> Even if we just had the private+idle buffers being accounted in OOM
> badness, that would be a huge step forward in system reliability.

Yes, and that's exactly the intention here because currently the OOM 
killer usually kills X when a graphics related application allocates to 
much memory and that is highly undesirable.

>>> : So question at every one: What do you think about this approach?
>> I thing is just just wrong semantically. Non-reclaimable memory is a
>> pain, especially when there is way too much of it. If you can free that
>> memory somehow then you can hook into slab shrinker API and react on the
>> memory pressure. If you can account such a memory to a particular
>> process and make sure that the consumption is bound by the process life
>> time then we can think of an accounting that oom_badness can consider
>> when selecting a victim.
> For graphics, we can't free most of our memory without also effectively
> killing the process.  i915 and vc4 have "purgeable" interfaces for
> userspace (on i915 this is exposed all the way to GL applications and is
> hooked into shrinker, and on vc4 this is so far just used for
> userspace-internal buffer caches to be purged when a CMA allocation
> fails).  However, those purgeable pools are expected to be a tiny
> fraction of the GPU allocations by the process.

Same thing with TTM and amdgpu/radeon. We already have a shrinker hock 
as well and make room as much as we can when needed.

But I think Michal's concerns are valid as well and I thought about them 
when I created the initial patch.

One possible solution which came to my mind is that (IIRC) we not only 
store the usual reference count per GEM object, but also how many 
handles where created for it.

So what we could do is to iterate over all GEM handles of a client and 
account only size/num_handles as badness for the client.

The end result would be that X and the client application would both get 
1/2 of the GEM objects size accounted for.

Regards,
Christian.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
