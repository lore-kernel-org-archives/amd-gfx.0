Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EE2C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 17:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59F2810E6DD;
	Thu,  9 Dec 2021 16:55:06 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCB7589F8B
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 15:47:58 +0000 (UTC)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4J8z2Q3llKzDxXc;
 Thu,  9 Dec 2021 07:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1639064878; bh=VSfXyTmtYE07vjw1z9Cen9MapKtijUFXRD558mTnVGc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jsMczNCcKRIXYGVHmLnW0k+3b2olymRuSIj1rx0hGQu6clOHM23Ixe+8miJwcNJY+
 9TtozwZdYkJaAX9LAYk545aptBBGmz6FIemij+7UhzmBgHZevO1v3UkRNjI2J3JCb3
 Hr6OntvIvlSo2lYWMIDVj3ix9eVMdEDE62a7qDL8=
X-Riseup-User-ID: 474A486132F081783706C9E92F2DF816E00874C5236E507999C85449356FA78D
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews2.riseup.net (Postfix) with ESMTPSA id 4J8z2N1Cbnz1yT2;
 Thu,  9 Dec 2021 07:47:55 -0800 (PST)
From: Isabella Basso <isabbasso@riseup.net>
To: alexander.deucher@amd.com, christian.koenig@amd.com, daniel@ffwll.ch,
 harry.wentland@amd.com, Rodrigo.Siqueira@amd.com, Felix.Kuehling@amd.com
Subject: [PATCH v2 10/10] drm/amdgpu: re-format file header comments
Date: Thu,  9 Dec 2021 12:47:22 -0300
Message-Id: <20211209154722.4018279-5-isabbasso@riseup.net>
In-Reply-To: <20211209154722.4018279-1-isabbasso@riseup.net>
References: <20211209154722.4018279-1-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: ~lkcamp/patches@lists.sr.ht, Isabella Basso <isabbasso@riseup.net>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the warning below:

 warning: Cannot understand  * \file amdgpu_ioc32.c
 on line 2 - I thought it was a doc line

Changes since v1:
- As suggested by Alexander Deucher:
  1. Reduce diff to minimum as this DOC section doesn't provide much
     value.

Signed-off-by: Isabella Basso <isabbasso@riseup.net>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
index 5cf142e849bb..a7efca6354b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
@@ -1,4 +1,4 @@
-/**
+/*
  * \file amdgpu_ioc32.c
  *
  * 32-bit ioctl compatibility routines for the AMDGPU DRM.
-- 
2.34.1

