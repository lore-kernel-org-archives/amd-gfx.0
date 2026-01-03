Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3ADC2A074
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Jan 2026 10:49:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9765110E02B;
	Sun,  4 Jan 2026 10:49:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bEETuQ7W";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DADD10E381
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Jan 2026 17:58:46 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A0F8743C76;
 Sat,  3 Jan 2026 17:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21176C113D0;
 Sat,  3 Jan 2026 17:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1767463126;
 bh=QuvPFMLdxqo8N9+t2kswBoVuQB3eyvBqkp9dBt09pK8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=bEETuQ7WcflAt5fJMYhPkfOZvZ/Ce8ULWcUYmfSEZ19XTpdC3NsncWN7vIk1758Fd
 YJHdc15C4KJGM/D2iVfMnj/xZpqrYNbV5HicFMD6la8+SqvWiCVy4w/KzImlU3Y2SV
 e8E91DrEgV6Iyk4oLWhBORv+8oybe9r6ivFFL0J8=
Date: Sat, 3 Jan 2026 09:58:45 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, David Hildenbrand <david@redhat.com>,
 amd-gfx@lists.freedesktop.org, linux-mm@kvack.org, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn
 <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH v2] fix AMDGPU failure with periodic signal
Message-Id: <20260103095845.152449636aaa60afb11f6c05@linux-foundation.org>
In-Reply-To: <b6a2a040-288e-4114-b85b-51740c608bb2@lucifer.local>
References: <6f16b618-26fc-3031-abe8-65c2090262e7@redhat.com>
 <0826eb09-216c-4d00-b4eb-ed1a2ba204bf@lucifer.local>
 <b6a2a040-288e-4114-b85b-51740c608bb2@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 04 Jan 2026 10:49:55 +0000
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

On Fri, 2 Jan 2026 19:08:37 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> On Fri, Jan 02, 2026 at 07:02:40PM +0000, Lorenzo Stoakes wrote:
> > +cc literally everyone you should have cc'd in mm :/
> >
> > Hi Mikulas,
> >
> > You really need to check MAINTAINERS, you've sent a patch that changes mm/vma.c
> > without cc'ing a single maintainer or reviewer of that file. I just happened to
> > notice this by chance, even lei seemed to mess up the file query for some
> > reason.
> 
> Ah yes, it's because this patch breaks the VMA userland tests.
> 
> You need to modify tools/testing/vma/vma_internal.h and rename signal_pending() to
> fatal_signal_pending().
> 
> You can check it by going to the tools/testing/vma directory running make and
> executing the vma executable.
> 
> This one I don't blame you for, there were meant to be CI tests for this in mm
> but for some reason that's just not been done.
> 
> But this needs fixing. If this is being backported to all human history you
> probably don't want to do that, but that leaves commits with broken tests in so
> an alternative would be to add a patch that gets added before this one that adds
> fatal_signal_pending() to vma_internal.h.
> 
> But not sure how feasible that is? Andrew?

Not understanding why it requires a separate patch.  Can we modify this
patch so it makes the necessary alterations to selftests?
