Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21E7D185FE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 13:37:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70E5110E733;
	Thu,  8 Jan 2026 13:37:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="SeoIaVvT";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3915610E086
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 20:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767817952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=6Z/DC7J64s4KlGEnHSLqfo5LhZ9RyxEue8T0Qz9lgFU=;
 b=SeoIaVvTlvESCmhVIGq0uNwdAFahxqtvZqouSSmXOFC1sPSRaxU/yzbv2xCsKsSNLwQNpb
 WoNzB6NA49EBEMmBe1J7MJS14wgXBLPoBWYNGDEIUAlagzDcfNbpty4gyFdaQpIJ5QkR7U
 QvOC8Ue7tU7+HFxDjRlzlkWHPqvr+0E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-8zKjdq5iOC-JakvDRE8z5Q-1; Wed,
 07 Jan 2026 15:32:26 -0500
X-MC-Unique: 8zKjdq5iOC-JakvDRE8z5Q-1
X-Mimecast-MFC-AGG-ID: 8zKjdq5iOC-JakvDRE8z5Q_1767817945
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B33871956053; Wed,  7 Jan 2026 20:32:24 +0000 (UTC)
Received: from debian4.vm (unknown [10.44.33.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP
 id B7F6F1956048; Wed,  7 Jan 2026 20:32:20 +0000 (UTC)
Received: by debian4.vm (sSMTP sendmail emulation);
 Wed, 07 Jan 2026 21:32:19 +0100
Message-ID: <20260107203113.690118053@debian4.vm>
User-Agent: quilt/0.68
Date: Wed, 07 Jan 2026 21:31:13 +0100
From: Mikulas Patocka <mpatocka@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pedro Falcato <pfalcato@suse.de>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Hildenbrand <david@redhat.com>, amd-gfx@lists.freedesktop.org,
 linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>
Subject: [PATCH v4 0/2] Fix failures with signals and AMD OpenCL
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ICmcYfGPlqyOoTQavWeCanaeYJREn3hVlhvIUy4HhTw_1767817945
X-Mimecast-Originator: redhat.com
content-type: text/plain; charset="US-ASCII"; x-default=true
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

This patch set fixes failures with AMD OpenCL and signals.

The first patch makes the kernel return -ERESTARTSYS instead of -EINTR,
so that the syscall is restarted if the signal has the SA_RESTART flag.

The second patch removes a spurious error message.

Mikulas

