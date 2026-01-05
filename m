Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640F1C47BCA
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 08:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B38910E4BA;
	Tue,  6 Jan 2026 08:31:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Lwa7vYDT";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D226410E3FE
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jan 2026 20:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767643728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x1ZcAIFOT5mxP5vaJAvukk3jC9gJDPl4VXGONGHnwtM=;
 b=Lwa7vYDTlJu+sEmTeyEkk2QXmXq1Wupjg470XRNeoyy98x7Y4DBXx6IJUqMNerhbwyLrmR
 eK0UetW9jngtXEE6xmZP8+UZcxB8n/G4aSu0PQ1bLsQYyXgQwBd49Mxf8gt0D85siKaecv
 dXqjtLaQbYQYU15y3d8hWGpVbtWoVrQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-gh-iiXJZMPS5P_csMAIj0g-1; Mon,
 05 Jan 2026 15:08:43 -0500
X-MC-Unique: gh-iiXJZMPS5P_csMAIj0g-1
X-Mimecast-MFC-AGG-ID: gh-iiXJZMPS5P_csMAIj0g_1767643721
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 897791956046; Mon,  5 Jan 2026 20:08:41 +0000 (UTC)
Received: from [10.44.33.27] (unknown [10.44.33.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51E4018004D8; Mon,  5 Jan 2026 20:08:38 +0000 (UTC)
Date: Mon, 5 Jan 2026 21:08:31 +0100 (CET)
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
In-Reply-To: <7whbqlfrwjr4z2d4bpny3rjyl5tetdyx7ccf52uvby7hgywoym@6l6m2xcytez7>
Message-ID: <e60858c9-12a6-2b04-35ae-9d676f14db2a@redhat.com>
References: <b672e17b-461d-16ae-e7d3-45d3c1aab142@redhat.com>
 <7whbqlfrwjr4z2d4bpny3rjyl5tetdyx7ccf52uvby7hgywoym@6l6m2xcytez7>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MMr3Z78KAh--AKEOWT1C765H8Xhi8A9vCIJw18dQBGc_1767643721
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
X-Mailman-Approved-At: Tue, 06 Jan 2026 08:31:34 +0000
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



On Mon, 5 Jan 2026, Liam R. Howlett wrote:

> I may be missing context because I didn't get 1/3 of this patch set,
> nor can I find it in my ML searching.  Nor did I get the cover letter,
> or find it.  Is this series threaded?

You can ignore the patch 1/3, it just changes memory management test 
suite.

> What you are doing is changing a really horrible loop across all VMAs,
> that happens 4 times, to a less interruptible method.
> 
> I'm not sure I'm okay with this.  Everyone else does seem fine with it,
> because userspace basically never checks error codes for a retry (or
> really anything, and sometimes not even for an error at all).

Everyone else does seem fine because they don't use periodic signals :-)

OpenCL is not the first thing that got broken by periodic signals. In the 
past, I found bugs in Linux/alpha, Linux/hppa, Cygwin, Intel Software 
Developer's Emulator regarding periodic signals. fork() was also buggy and 
it was fixed by c3ad2c3b02e953ead2b8d52a0c9e70312930c3d0.

> But this could potentially have larger consequences for those
> applications that register signal handlers, couldn't it?  That is, they
> expect to get a return based on some existing code but now it won't
> return and the application is forced to wait for all locks to be taken
> regardless of how long it takes - or to force kill the application?

Do you have any userspace application that expects open("/dev/kfd") to be 
interrupted with -EINTR and breaks when it isn't?

> We regularly get people requesting the default number of vmas be
> increased.  This means that processes that approach max_map_count will
> wait until 4 loops through the vmas before they can be interrupted, or
> they have to kill the process.
> 
> > 
> > For example, this bug happens when using OpenCL on AMDGPU. Sometimes,
> > probing the OpenCL device fails (strace shows that open("/dev/kfd")
> > failed with -EINTR). Sometimes we get the message "amdgpu:
> > init_user_pages: Failed to register MMU notifier: -4" in the syslog.
> 
> If you only get the error message sometimes, does that mean there is
> another signal check that isn't covered by this change - or another call
> path?

This call path is also triggered by -EINTR from mm_take_all_locks: 
"init_user_pages -> amdgpu_hmm_register -> mmu_interval_notifier_insert -> 
mmu_notifier_register -> __mmu_notifier_register -> mm_take_all_locks -> 
return -EINTR". I am not expert in the GPU code, so I don't know how much 
serious it is.

> > The bug can be reproduced with the following program.
> > 
> > To run this program, you need AMD graphics card and the package
> > "rocm-opencl" installed. You must not have the package "mesa-opencl-icd"
> > installed, because it redirects the default OpenCL implementation to
> > itself.
> 
> I'm not saying it's wrong to change the signal handling, but this is
> very much working around a bug in userspace constantly hammering a task
> with signals and then is surprised there is a response that the kernel
> was interrupted.
> 
> This seems to imply that all signal handling should only happen on fatal
> signals?

No - the kernel should do what applications expect. open is (according to 
the man page) supposed to be interrupted when opening slow devices (for 
example fifo). I'm wondering whether /dev/kfd should be considered a slow 
device or not.

> ...
> > 
> > I'm submitting this patch for the stable kernels, because this bug may
> > cause random failures in any code that calls mm_take_all_locks.
> 
> They aren't random failures, they are a response to a signal sent to the
> process that may be taking a very long time to do something.
> 
> I really don't see how continuously sending signals at a short interval
> interrupting system calls can be considered random failures, especially
> when the return is -EINTR which literally means "Interrupted system
> call".  How else would you interrupt a system call, if not a signal?

The AMDGPU OpenCL implementation attempts to open /dev/kfd and if it gets 
-EINTR, it behaves as if OpenCL were unavailable - it won't report itself 
in clGetPlatformIDs and it will make clGetDeviceIDs fail.

So, we are dealing with random failures - any single signal received at 
wrong time can make OpenCL fail.

Even if I disabled the periodic timer, the failure could be triggered by 
other signals, for example SIGWINCH when the user resizes the terminal, or 
SIGCHLD when a subprocess exits.

> I feel like we are making the code less versatile to work around the
> fact that userspace didn't realise that system calls could be
> interrupted without a fatal signal.
> 
> And from that view, I consider this a functional change and not a bug
> fix.
> 
> Thanks,
> Liam

In practice, I use 10ms timer and I get occasional OpenCL failures. In the 
test example, I used 50us timer, so that it is reproduced reliably - but 
decreasing the timer frequency doesn't fix the failure, it just makes it 
happen less often.

Mikulas

