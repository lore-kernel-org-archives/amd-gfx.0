Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F29C47BEB
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 09:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C6C610E56D;
	Wed,  7 Jan 2026 09:14:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M90BQAfj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C2C710E3FC
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 20:59:14 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D937443C19;
 Tue,  6 Jan 2026 20:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D739C116C6;
 Tue,  6 Jan 2026 20:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1767733153;
 bh=s8JI4AVlsCOv4ICnt24mH5HiGOEafgKJaj9Y+ffuZNU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=M90BQAfjWTj/KzZmq+K81A45dxfsHv9/1iVIGzvsbARktXCStO6+lsrcr4YtC7rdk
 nGKlxUxiSEqxTjbX4CqDH72MgCAo+HoVCL6GPpNCqh8lC4GzkBUqRUwZ5p0cTnoKV3
 ANz1NdRwS3hmq1B0O7jGws/IMbqxlBplqyx63Xwk=
Date: Tue, 6 Jan 2026 12:59:12 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Mikulas Patocka
 <mpatocka@redhat.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, David Hildenbrand <david@redhat.com>,
 amd-gfx@lists.freedesktop.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] fix AMDGPU failure with periodic signal
Message-Id: <20260106125912.a4975dd1919c913c22fd5101@linux-foundation.org>
In-Reply-To: <52bffed4-d9b0-4ec9-85a6-ba70e22106f3@lucifer.local>
References: <6f16b618-26fc-3031-abe8-65c2090262e7@redhat.com>
 <61c3d41d-602d-4dfc-872a-873acf653b6d@lucifer.local>
 <20260106101249.be7514e75c09a928c6fa71ef@linux-foundation.org>
 <52bffed4-d9b0-4ec9-85a6-ba70e22106f3@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 07 Jan 2026 09:14:38 +0000
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

On Tue, 6 Jan 2026 18:24:10 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> On Tue, Jan 06, 2026 at 10:12:49AM -0800, Andrew Morton wrote:
> > On Tue, 6 Jan 2026 11:51:49 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> >
> > > I'm not sure if the git repos are lagging vs. quilt, but as reported this
> > > patch breaks the VMA tests, and the tests are _still_ broken.
> > >
> > > Yet it's still in mm-new, mm-unstable, and even mm-hotfixes-unstable.
> > >
> > > This is interfering with my work, can we please drop this.
> > >
> > > Also the v3 is currently being debated, so surely should have been dropped
> > > until we have this resolved?
> >
> > Well.  I don't drop fixes unless it's decided to be a non-issue or
> > unless a better fix is available.
> 
> Even if it breaks the build and that's been reported on-list?

I addressed that.

> >
> > I've done this for ever - I've held onto "wrong" fixes for *years*.
> > View this as a weird issue-tracking system for a project which has no
> > issue-tracking system.  It's to prevent issues from falling through
> > cracks and getting lost.
> 
> I think a lot of the issue is these processes seem to work to you but those
> on the ground are finding them not to work.
> 
> The kernel today is not the same as the kernel X years ago, esp. in terms
> of sheer volume.
> 
> Having a patch that none of the relevant maintainers/reviewers have seen
> land in an -rc out of the blue is a really serious problem.

It isn't in -rc.  It's in mm-hotfixes-unstable and it's marked "acks?",
which means not to go upstream without further consideration.

> Also it was taken 2 months after it was submitted, so nobody could have
> _possibly_ picked this up by reading the list. This is why I am really
> underlining this case.

That's why I grabbed it.  Had I not done so, this issue would have been
lost.  What I do *worked*.

> >
> > It's unfortunate that this one causes disruption so I guess I'll loudly
> > comment it out and track the issue that way.
> >
> 
> I think we need a better approach, yes.
> 
> We in mm are really very responsive compared to most, I think asking people
> to wait and resend if somehow it got missed is considerably saner than
> 'well I'll take any patch purporting to be a fix from anyone so we keep
> track of stuff'.

If someone wants to step up and be MM issue tracking person then great.
I don't want to be that person.

And let me reiterate: had I not done this, the issue Mikulas identified
would have remained unaddressed.
