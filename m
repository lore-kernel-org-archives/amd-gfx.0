Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA52BC47BC8
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 08:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E92B810E4B7;
	Tue,  6 Jan 2026 08:31:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JuG+BVVZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D331910E050
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jan 2026 23:21:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BB2886011E;
 Mon,  5 Jan 2026 23:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C88C116D0;
 Mon,  5 Jan 2026 23:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1767655271;
 bh=DJd1PYf9+LG+E2hOieXrVcjf2JpF41ohLEEqz7guBrY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=JuG+BVVZ0gVdEKKaoG4eLJTOXCsg/xg3b66moKxrPd0Ajya85cBeozZW8ti6dwSBf
 gwO/iQMv6oxg8JpIs0kCB+09Lfpw2J2PlDeX7pv4HvoLzGn402/HyLooJKQ15fXtVO
 835rHAkLjpTQ3yzTK3RYp+4JzPQ267sPsymUblUw=
Date: Mon, 5 Jan 2026 15:21:10 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, David Hildenbrand <david@redhat.com>,
 amd-gfx@lists.freedesktop.org, linux-mm@kvack.org, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn
 <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH v3 1/3] tools/testing/vma/vma_internal.h: provide
 fatal_signal_pending
Message-Id: <20260105152110.c3c90aae00096db3d472c02e@linux-foundation.org>
In-Reply-To: <18f7f4ff-67f8-4a39-b6c4-893bfbed4955@lucifer.local>
References: <45dd9b02-7867-6e5a-4a64-02c4d43c9b68@redhat.com>
 <18f7f4ff-67f8-4a39-b6c4-893bfbed4955@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 5 Jan 2026 12:18:59 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> On Sun, Jan 04, 2026 at 10:15:36PM +0100, Mikulas Patocka wrote:
> > Provide a dummy function fatal_signal_pending, because it will be used in
> > the following patch in the function mm_take_all_locks.
> >
> > This commit avoids a test failure when the following patch will be apllied.
> >
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > Cc: stable@vger.kernel.org
> 
> No, please don't cc stable. Also don't cc stable without a Fixes tag.
> 
> This isn't backportable given you now need to backport to 5.10, 5.15, 6.1, 6.6,
> 6.12, 6.17.
> 
> I'm not sure how Andrew deals with a mix of Cc: stable and not-cc-stable patches
> in a series, think he generally doesn't like,

Well they have different routes into mainline.  cc:stable stuff goes
into current -rc and non-cc:stable material goes into next -rc1.  They
land in different branches of mm.git.  So it's best to separate these
things.

otoh, if the fix isn't urgent (like this one) then it's OK to add
cc:stable material into next -rc1 - it'll get there eventually.

> but I'm not sure how exactly we
> are supposed to express order here otherwise. Andrew?

hm.  We could just fix the bug, then when that fix lands in mainline
and has a stable hash we could prepare selftests fixups with
Fixes:that.

I do feel that Fixes: is a bit of a misnomer.  I treat it as a message
from us to -stable maintainers:
Please-add-this-to-any-kernel-which-contains:
