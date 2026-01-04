Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15248C2A072
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jan 2026 08:27:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89A5910E100;
	Mon,  5 Jan 2026 08:27:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="TDxm+nQm";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DBE889CAD
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Jan 2026 21:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767561485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=hyp27LAQdCOuI+jR+Ub383o9Ghg3Zj0WM9a7WADb1iQ=;
 b=TDxm+nQms4xTUMzQiFhtZOHXJwB7ppevGvYhICqnitB0lVfuB5jMLF+4y9HmVBCmtrZ3tB
 qcAGi/fNA/CS7Bp2RclfyfBQd+ofd1kVxqfXrdQEfCupejT9wvXloAHAHW1BZEj3svqHpX
 TViXDnmfK+mYHMYHyzXXSx4eOSuJzYM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-HxZuzOLBMp-yB29UdILreA-1; Sun,
 04 Jan 2026 16:17:59 -0500
X-MC-Unique: HxZuzOLBMp-yB29UdILreA-1
X-Mimecast-MFC-AGG-ID: HxZuzOLBMp-yB29UdILreA_1767561478
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0607918002C9; Sun,  4 Jan 2026 21:17:58 +0000 (UTC)
Received: from [10.44.33.27] (unknown [10.44.33.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B463D19560AB; Sun,  4 Jan 2026 21:17:54 +0000 (UTC)
Date: Sun, 4 Jan 2026 22:17:52 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, amd-gfx@lists.freedesktop.org, 
 linux-mm@kvack.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH v3 3/3] amdgpu: don't report an error if the process was killed
Message-ID: <aca0147f-61be-30a3-eff5-cb981222aacc@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mvTYYxw7s_XES0DU7uD8yJmQUNAcH0y6rYtXVek_d0Y_1767561478
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

If the process was killed by a fatal signal, amdgpu_hmm_register could
return -EINTR (the -EINTR comes from mm_take_all_locks).

Don't log the error in this case, because no error happened.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Index: mm/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
===================================================================
--- mm.orig/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c	2026-01-04 21:19:14.000000000 +0100
+++ mm/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c	2026-01-04 21:19:14.000000000 +0100
@@ -1070,8 +1070,13 @@ static int init_user_pages(struct kgd_me
 
 	ret = amdgpu_hmm_register(bo, user_addr);
 	if (ret) {
-		pr_err("%s: Failed to register MMU notifier: %d\n",
-		       __func__, ret);
+		/*
+		 * If we got EINTR because the process was killed, don't report
+		 * it, because no error happened.
+		 */
+		if (!(fatal_signal_pending(current) && ret == -EINTR))
+			pr_err("%s: Failed to register MMU notifier: %d\n",
+			       __func__, ret);
 		goto out;
 	}
 

