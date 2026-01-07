Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B46BD185FA
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 13:37:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1778210E72D;
	Thu,  8 Jan 2026 13:37:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="JhXvBhXX";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A07910E034
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 21:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767821397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ow7ejlnL76blgGovBd3isSBtOAsvSD2Rawb77QSvQFQ=;
 b=JhXvBhXXvEeTqPFU8p4O6qfXvdq46v72e6P68PpZKUlNUn6ic0ln20XqnZQY1UQQzePJuB
 6bDI8gXt/HibfqLri8JgwWFN8Vu4hi4I7HkF9eBHBT+DePsY5JJmHJHEr4LfbXNWlU/isX
 5HE2tE7ld6jGwq+g/ZFKerC5k9S+XTE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-ENzFtFryNKKpqRGMa8A-nA-1; Wed,
 07 Jan 2026 16:29:53 -0500
X-MC-Unique: ENzFtFryNKKpqRGMa8A-nA-1
X-Mimecast-MFC-AGG-ID: ENzFtFryNKKpqRGMa8A-nA_1767821391
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CC6E195608F; Wed,  7 Jan 2026 21:29:51 +0000 (UTC)
Received: from [10.44.33.27] (unknown [10.44.33.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7950919560A2; Wed,  7 Jan 2026 21:29:46 +0000 (UTC)
Date: Wed, 7 Jan 2026 22:29:44 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
cc: Andrew Morton <akpm@linux-foundation.org>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
 David Hildenbrand <david@redhat.com>, amd-gfx@lists.freedesktop.org, 
 linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] mm_take_all_locks: change -EINTR to
 -ERESTARTSYS
In-Reply-To: <aV7IO8-trMSI1twA@casper.infradead.org>
Message-ID: <d3d77df6-931a-b97c-d551-a69ee5ca9493@redhat.com>
References: <20260107203113.690118053@debian4.vm>
 <20260107203224.969740802@debian4.vm> <aV7IO8-trMSI1twA@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mailman-Approved-At: Thu, 08 Jan 2026 13:37:29 +0000
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



On Wed, 7 Jan 2026, Matthew Wilcox wrote:

> On Wed, Jan 07, 2026 at 09:31:14PM +0100, Mikulas Patocka wrote:
> > This commit changes -EINTR to -ERESTARTSYS, so that if the signal handler
> > was installed with the SA_RESTART flag, the operation is automatically
> > restarted.
> 
> No, this is bonkers.  If you get a signal, you return -EINTR.

Why?

fifo_open returns -ERESTARTSYS, so why not here?

Mikulas

