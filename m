Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAB7C2A072
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jan 2026 08:27:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C36510E162;
	Mon,  5 Jan 2026 08:27:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="YMPRJflG";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D3FC10E042
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Jan 2026 21:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767561184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AgBgb313oQaNyn46BLjjQCZGKM9zlTYGWXVQQUu4odU=;
 b=YMPRJflGXNhI06skwoW/K5RYjpujLbqKIIcXjqBas84pULkQ4mR+SUT9tew5mEAf9UC+SD
 3XZfG64JgJ5UDgQUFF5Tz1vZSBV770FTtxvFy4V7ZZLrTCtKvbhpPk8WijR4ZkqeQ6OYxa
 th62jg5HXujeS1gqZp3cqpz4fhSVT4s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-iCFXWwhrN_q5gaWNTOzuZw-1; Sun,
 04 Jan 2026 16:13:01 -0500
X-MC-Unique: iCFXWwhrN_q5gaWNTOzuZw-1
X-Mimecast-MFC-AGG-ID: iCFXWwhrN_q5gaWNTOzuZw_1767561179
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8FA91956053; Sun,  4 Jan 2026 21:12:58 +0000 (UTC)
Received: from [10.44.33.27] (unknown [10.44.33.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B688180049F; Sun,  4 Jan 2026 21:12:55 +0000 (UTC)
Date: Sun, 4 Jan 2026 22:12:50 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, amd-gfx@lists.freedesktop.org, 
 linux-mm@kvack.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH v2] fix AMDGPU failure with periodic signal
In-Reply-To: <0826eb09-216c-4d00-b4eb-ed1a2ba204bf@lucifer.local>
Message-ID: <4e45bbf5-29ce-7cd6-8b01-8fb1331ac758@redhat.com>
References: <6f16b618-26fc-3031-abe8-65c2090262e7@redhat.com>
 <0826eb09-216c-4d00-b4eb-ed1a2ba204bf@lucifer.local>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OD5hRIRQhkV31x9w6HPXAg9CEdGfs2oCg6fdyWaROho_1767561179
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
X-Mailman-Approved-At: Mon, 05 Jan 2026 08:27:08 +0000
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



On Fri, 2 Jan 2026, Lorenzo Stoakes wrote:

> +cc literally everyone you should have cc'd in mm :/
> 
> Hi Mikulas,
> 
> You really need to check MAINTAINERS, you've sent a patch that changes mm/vma.c
> without cc'ing a single maintainer or reviewer of that file. I just happened to
> notice this by chance, even lei seemed to mess up the file query for some
> reason.

I saw

MEMORY MANAGEMENT
M:      Andrew Morton <akpm@linux-foundation.org>
L:      linux-mm@kvack.org
S:      Maintained

in the MAINTAINERS file, so I sent the patch to Andrew and to 
linux-mm@kvack.org. I should have sent it also to people on the "MEMORY 
MANAGEMENT - CORE" section, but I missed it.

> I'm confused in general about this patch, you sent it on 7th Nov? And it's been
> ignored until now and then taken without review to the hotfixes queue?

I'm developing code that translates parallelizable loops written in the 
Ajla programming language (www.ajla-lang.cz) into OpenCL and runs them on 
the graphics card. Ajla sets up a periodic timer that sends a signal for 
scheduling purposes and this signal interferes with OpenCL, causing the 
-EINTR failures.

So far, I worked around this bug by blocking all signals around the 
functions clGetPlatformIDs and clGetDeviceIDs - but it would be better to 
fix it in the Linux kernel and remove the signal-blocking hacks.

Mikulas

