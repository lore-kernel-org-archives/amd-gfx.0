Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02646C433B4
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 15:40:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83393610E6
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 15:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83393610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECF106E8B9;
	Mon,  3 May 2021 15:40:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A29AB6E8B8
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 May 2021 15:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620055507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=R6xAkxyUaMSa9LYs8ZpMfNo4IEah8W9PTR5ypcGWPi0=;
 b=BFiBQSj9gh5M3k6xWp811yb/VJoiOrwkYbJj7Ya5pmuxrSWhpz3S5UMswnPYYl/RKeV3gZ
 nPYw9G0ZkIOLLmBV7IyVWSlDfa4y47FO4meUWIYgk36IlLcA4cgyILEQWI7gRlXCOP9WUa
 BWHdWPYQYIWvC330NgUxB+s1RE2Ao/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-elFNznPqM-SQ6Wx__tzZgQ-1; Mon, 03 May 2021 11:25:05 -0400
X-MC-Unique: elFNznPqM-SQ6Wx__tzZgQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D3D291298;
 Mon,  3 May 2021 15:25:04 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com
 (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E6ED61156;
 Mon,  3 May 2021 15:25:04 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
 by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id
 143FP3vX004163; Mon, 3 May 2021 11:25:03 -0400
Received: from localhost (mpatocka@localhost)
 by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP
 id 143FP3GJ004159; Mon, 3 May 2021 11:25:03 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka
 owned process doing -bs
Date: Mon, 3 May 2021 11:25:03 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Alex Deucher <alexander.deucher@amd.com>
Subject: A hotplug bug in AMDGPU
Message-ID: <alpine.LRH.2.02.2105031023580.29348@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mpatocka@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Mailman-Approved-At: Mon, 03 May 2021 15:40:40 +0000
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
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org,
 =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi

There's a bug with monitor hotplug starting with the kernel 5.7.

I have Radeon RX 570. If I boot the system with the monitor unplugged and 
then plug the monitor via DVI, the kernel 5.6 and below will properly 
initialized graphics; the kernels 5.7+ will not initialize it - and the 
monitor reports no signal.

I bisected the issue and it is caused by the patch 
4fdda2e66de0b7d37aa27af3c1bbe25ecb2d5408 ("drm/amdgpu/runpm: enable runpm 
on baco capable VI+ asics")

When I remove the code that sets adev->runpm on the kernel 5.12, monitor 
hotplug works correctly.

Mikulas


Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |    2 --
 1 file changed, 2 deletions(-)

Index: linux-5.12/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
===================================================================
--- linux-5.12.orig/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c	2021-04-26 14:50:53.000000000 +0200
+++ linux-5.12/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c	2021-05-03 16:19:54.000000000 +0200
@@ -183,8 +183,6 @@ int amdgpu_driver_load_kms(struct amdgpu
 				adev->runpm = true;
 			break;
 		default:
-			/* enable runpm on CI+ */
-			adev->runpm = true;
 			break;
 		}
 		if (adev->runpm)

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
