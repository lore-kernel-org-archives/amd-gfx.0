Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCEAD185F8
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 13:37:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3872010E72F;
	Thu,  8 Jan 2026 13:37:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="PCnx/vpd";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39B3E10E086
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 20:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767817959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=w4w0YXsQ4tHqn86Cdn9lgCFQXlRLiJdMmnLM/2nY/7I=;
 b=PCnx/vpdvOjgyeMVF+zt2KYXURKesjFMg6/nWEljA8ensombAyIk2NMJWS3KNO/wPstGSL
 Y1Mxaj7bsxf6cAcRXVHud1rBgTxTRQX7P8gd56anB/Dfp5tPrLUQ4U+lYYV7EFD3V1QNud
 I+66IUq/H9XkdDrU39M4qxq3AuirNS8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-tOaLPL9DOgKv2Mj1GCj-kA-1; Wed,
 07 Jan 2026 15:32:38 -0500
X-MC-Unique: tOaLPL9DOgKv2Mj1GCj-kA-1
X-Mimecast-MFC-AGG-ID: tOaLPL9DOgKv2Mj1GCj-kA_1767817956
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56EAF1955F34; Wed,  7 Jan 2026 20:32:36 +0000 (UTC)
Received: from debian4.vm (unknown [10.44.33.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP
 id 5091F18007D2; Wed,  7 Jan 2026 20:32:32 +0000 (UTC)
Received: by debian4.vm (sSMTP sendmail emulation);
 Wed, 07 Jan 2026 21:32:30 +0100
Message-ID: <20260107203230.880324802@debian4.vm>
User-Agent: quilt/0.68
Date: Wed, 07 Jan 2026 21:31:15 +0100
From: Mikulas Patocka <mpatocka@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pedro Falcato <pfalcato@suse.de>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Hildenbrand <david@redhat.com>, amd-gfx@lists.freedesktop.org,
 linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>, Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v4 2/2] amdgpu: delete the "Failed to register MMU notifier"
 message
References: <20260107203113.690118053@debian4.vm>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H-ETFC7hQhwaHfqzKZogDuT59EFAwpb8K3sIelwA8wY_1767817956
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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

This error may happen if mm_take_all_locks was interrupted by a signal -
the userspace will retry an ioctl that returned -EINTR, so there is no
need to report it to the syslog.

Christian König suggested to remove this message at all, so let's do it.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Index: mm/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
===================================================================
--- mm.orig/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c	2026-01-07 20:09:51.000000000 +0100
+++ mm/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c	2026-01-07 20:12:11.000000000 +0100
@@ -1069,11 +1069,8 @@ static int init_user_pages(struct kgd_me
 	}
 
 	ret = amdgpu_hmm_register(bo, user_addr);
-	if (ret) {
-		pr_err("%s: Failed to register MMU notifier: %d\n",
-		       __func__, ret);
+	if (ret)
 		goto out;
-	}
 
 	if (criu_resume) {
 		/*

