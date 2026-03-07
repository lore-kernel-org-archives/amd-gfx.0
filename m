Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F602FC9EDF
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Mar 2026 14:14:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C1E110E460;
	Sun,  8 Mar 2026 14:14:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=sina.com header.i=@sina.com header.b="MVUKxSnp";
	dkim-atps=neutral
X-Greylist: delayed 574 seconds by postgrey-1.36 at gabe;
 Sat, 07 Mar 2026 01:27:08 UTC
Received: from r3-18.sinamail.sina.com.cn (r3-18.sinamail.sina.com.cn
 [202.108.3.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5791910E106
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 Mar 2026 01:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1772846828; bh=hl5Gx8ORpg4RhkGdyFFWdkjfTiswS1fYGPRgCUTRirg=;
 h=From:Subject:Date:Message-ID;
 b=MVUKxSnp9Jh2CSZmdcWXHh2X2g83pF1bnpbuaeWpl7wa/D71r9jT3XftxqWeZTzBy
 gImUtFJvQH8aj4zUc23WI7l7PsMpn+9cA4GZgcHJC16mgRjAkNQYeg2IcHdHiYmhw6
 vFYuGTnVm4WKsma0u6Qv3IXzjk/ZQdnim1YV6dxI=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
 by sina.com (10.54.253.32) with ESMTP
 id 69AB7CA700001F82; Sat, 7 Mar 2026 09:17:30 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=hdanton@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1019254456634
X-SMAIL-UIID: C83C79BFABAE416FB5C5AE7B220CC511-20260307-091730-1
From: Hillf Danton <hdanton@sina.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: Re: [PATCH v5 09/28] drm/sched: Add fair scheduling policy
Date: Sat,  7 Mar 2026 09:17:15 +0800
Message-ID: <20260307011717.712-1-hdanton@sina.com>
In-Reply-To: <b5b3461f-7434-42db-bad3-ae9187fdbfc1@igalia.com>
References: <20251219135351.25880-1-tvrtko.ursulin@igalia.com>
 <20251219135351.25880-10-tvrtko.ursulin@igalia.com>
 <DFONORJMB1ZM.1JHSIXB9ULHJV@kernel.org>
 <1fceb644-ff22-45c8-bd83-4a32786c35f2@igalia.com>
 <DFP4XVVKNIRC.2O817MGMKCQ3P@kernel.org>
 <7b1d848c-a0e3-4960-94da-4f9001c1d96f@igalia.com>
 <DFPK5HIP7G9C.2LJ6AOH2UPLEO@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 08 Mar 2026 14:14:10 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, 20 Jan 2026 09:51:48 +0000 Tvrtko Ursulin wrote:
> On 15/01/2026 23:39, Danilo Krummrich wrote:
> > On Thu Jan 15, 2026 at 2:00 PM CET, Tvrtko Ursulin wrote:
> 
> 8><
> 
> >> Okay but I am sure you know there are memory barriers, RCU, SPSC queue,
> >> completions, worker management, and at least two locks, and everything
> >> is interdependent.
> > 
> > I am, and I couldn't describe the maintainance burden of the scheduler any
> > better. :)
> > 
> >> This series at least removes a bunch of code without making things more
> >> complicated and so can be a good base for further rework. If you suggest to
> >> hold it until all of the above is resolved it will be a few more years easily.
> > 
> > Let me explain a bit where I'm coming from:
> > 
> >  From a maintainer perspective - without saying that things are either black or
> > white - I'm assessing contributors and contributions on whether the intention is
> > to improve the infrastructure in terms of design and maintainability or whether
> > the main intention is to "just" get a certain feature merged.
> > 
> > While both are valuable contributions that are appreciated, contributions that
> > have a tendency into the latter direction, have to be seen with more sceptisism.
> > 
> > Especially when the code base already has known design issues, bulding features
> > on top is very dangerous. Not necessarily because the resulting code might be
> > wrong or because of regressions, etc. But because it most likely increases the
> > difficulty resolving the existing issues -- in the worst case leading to a dead
> > end.
> > 
> > Having that said, I am not saying that you "just" try to get your feature merged
> > no matter what. Quite the opposite, I very much appreciate your contributions to
> > the scheduler and recognize the cleanup work you are doing.
> > 
> > However, for this series I require you to acknowledge that, even if correct,
> > some of this code introduces additional workarounds due to existing design
> > issues, locking and synchronization subtleties that should be solved in better
> > ways.
> > 
> > I have no objections going ahead with this series if we are on the same page
> > regarding this and you are willing to also help out fixing those underlying
> > design issues, locking and synchronization quirks, etc. subsequently.
> > 
> > But if you are more leaning in the direction of "I don't see an issue overall,
> > the code is correct!" I do have concerns.
> > 
> > Improving the situation with the scheduler is the fundamental reason why Philipp
> > and me were stepping up as maintainers, Philipp being more of the active part
> > (doing a great job) and me working more in the background, helping and mentoring
> > him.
> > 
> > Believe me when I say that we want this to move forward, but we also have to
> > ensure that we are not making a step into the direction of increasing the
> > difficulty to solve the underlying issues.
> > 
> > So, again, if we are on the same page with this, no objections from my side.
> 
> I thought it would have been obvious by now that I am trying to improve 
> and fix things across the board. I even mentioned I had attempted a more 
> ambitious rewrite already, which hit some stumbling blocks, so I settled 
> for this smaller step first.
> 
> I am also glad to hear there is desire to attempt more significant 
> refactors. Because in the past I was a bit concerned with a little bit 
> of "it's scary don't touch it" messaging.
> 
> So yes, I do plan to stick around to keep fixing and improving things.
>
After FIFO and RR are cut in the subsequent 12/28, you have a couple of options
1, forget priority once for all given vruntime, or
2, prio will not change once entity is created, or
3, move prio to entity->stats
