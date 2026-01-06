Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDE5CF6C1D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 09:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1169710E3F6;
	Wed,  7 Jan 2026 09:14:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="NKrxX570";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 709C410E54D
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 20:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767730815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1bW4Kxn2aWPyVZIZdur0x49cptxN6M7ZG3iagWVUS7E=;
 b=NKrxX570e1R2R/GtgKcxD0NDiB4cIt9JCbMSXEuqo6FSIy1HHstP+sdPL27N/ZfISefR77
 DKXIECYXxl96oEuZVrJoFYBOfMz0Te5lqiCSo939CkHrXj9CpaxGgdCQq5Lk0bKVFBZ//F
 fBgi6PX+1sWbyZvC9wsTFc1mAj2G1rg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-WhCe1Z4OPvytjcy9zbZx6Q-1; Tue,
 06 Jan 2026 15:20:10 -0500
X-MC-Unique: WhCe1Z4OPvytjcy9zbZx6Q-1
X-Mimecast-MFC-AGG-ID: WhCe1Z4OPvytjcy9zbZx6Q_1767730808
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E46EF195DE56; Tue,  6 Jan 2026 20:20:07 +0000 (UTC)
Received: from [10.44.33.27] (unknown [10.44.33.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B8D419560A7; Tue,  6 Jan 2026 20:20:04 +0000 (UTC)
Date: Tue, 6 Jan 2026 21:19:59 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, amd-gfx@lists.freedesktop.org, 
 linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH v3 2/3] mm: only interrupt taking all mm locks on fatal
 signal
In-Reply-To: <j3dy3g5mchtdzxldtnqu5nwaalbr6ec4ceim3nuu6nwcddmqjc@7dgzr4m7pli2>
Message-ID: <6633f8ed-f432-f4c4-3fe2-8c14248cadab@redhat.com>
References: <b672e17b-461d-16ae-e7d3-45d3c1aab142@redhat.com>
 <7whbqlfrwjr4z2d4bpny3rjyl5tetdyx7ccf52uvby7hgywoym@6l6m2xcytez7>
 <e60858c9-12a6-2b04-35ae-9d676f14db2a@redhat.com>
 <j3dy3g5mchtdzxldtnqu5nwaalbr6ec4ceim3nuu6nwcddmqjc@7dgzr4m7pli2>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Et8kC8-zlsDMlKQzlaySGeeColSnnd_hzdctdmQfpVo_1767730808
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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



On Tue, 6 Jan 2026, Liam R. Howlett wrote:

> * Mikulas Patocka <mpatocka@redhat.com> [260105 15:08]:
> > 
> > > If you only get the error message sometimes, does that mean there is
> > > another signal check that isn't covered by this change - or another call
> > > path?
> > 
> > This call path is also triggered by -EINTR from mm_take_all_locks: 
> > "init_user_pages -> amdgpu_hmm_register -> mmu_interval_notifier_insert -> 
> > mmu_notifier_register -> __mmu_notifier_register -> mm_take_all_locks -> 
> > return -EINTR". I am not expert in the GPU code, so I don't know how much 
> > serious it is.
> 
> Okay, so the other call paths also end up getting the -EINTR from this
> function?  Can you please add that detail to the commit message?

Yes. I'd like to ask the GPU people to look at it and say how much damage 
this -EINTR could do. I don't know - I just saw the messages "Failed to 
register MMU notifier: -4" in the syslog.

> This means that -EINTR can no longer be returned from open(), right?
> Otherwise you are just reducing a race condition between open() and a
> signal entering from your timer.

EINTR can be returned from open() in cases when it was historically 
behaving this way - such as opening a fifo when there is no matching 
process having it open.

But I think that opening /dev/kfd doesn't fall into this category.

NFS has an "intr" flag that makes the filesystem syscalls interruptible by 
signals. It is off by default, because many programs don't expect EINTR 
when opening, reading or writing plain files on a filesystem.

> Any other -EINTR system call will also cause you problems since you
> continuously send signals to your process, so we'll have to change them
> all for this to work?

I use SA_RESTART for the signals. And I retry all the syscalls on EINTR 
just in case SA_RESTART didn't work. So, I don't experience random 
failures in my code due to the periodic signal.

But there is code that I have no control over - such as the OpenCL shared 
library.

> This is the userspace ignoring what the error code means and just
> aborting on any error.  This is a change in behaviour on the kernel side
> to work around what they are doing.
> 
> It also sounds like it can be avoided by userspace not sending signals
> during the open process, or even to

So far, I worked around this issue by blocking all signals around 
clGetPlatformIDs and clGetDeviceIDs - but this is a hack.

> retry at a higher level if a recoverable error occurs.

If clGetDeviceIDs fails and I call clGetDeviceIDs again, it doesn't even 
attempt to open /dev/kfd again and fails right away. So, I can't work 
around it by retrying it.

> > Even if I disabled the periodic timer, the failure could be triggered by 
> > other signals, for example SIGWINCH when the user resizes the terminal, or 
> > SIGCHLD when a subprocess exits.
> 
> Those are also not random, they are expected signals caused by events.

From the process's point of view, they are random - the process doesn't 
know when the user will drag the corner of the terminal window and resize 
it. If the process spawns a subprocess, it cannot predict when will the 
subprocess exit and SIGCHLD will be delivered.

If we don't change it, we end up with unreliable software stack that can 
fail during rare events, such as dragging the corner of the window.

> I'm trying to say this git commit message is wrong and misleading.

OK, so I'll try to rewrite the commit message and submit version 4 of the 
patch.

Mikulas

