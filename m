Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59158C61DB9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 11:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA6BB10F34D;
	Fri, 28 Aug 2026 11:41:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dlt9mOGm";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 883D310F365
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 11:41:34 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c252c7270faso155350166b.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 04:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787917293; x=1788522093; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fZrZqhoFV6TidBRsV2AHIIYmq6WMAbgL4B5Dlacd0L4=;
 b=dlt9mOGm+IeRF4NEOndV/Mu7frZlTKPA+Ncefb1WlwHbvVCbfE5+gLjYtz0JnXjh3K
 Srqa+CNySQhqPeMUsmMjnEP1LCdcXjM/0zOfMp0ppdv53vd8IviwJIUstX5U7g8LxkAH
 MZfOoQ7FSXq6S3zN64em3nszc9/MQ7bSS7cFD7YtLi9zoZjXDXhm93ygvQ+8qItVjypm
 MXV+z7Y2sF32RLzwAtRu0gzFr/KlGmgyigxNKzOWMeKNvuzsZEnFbARhMZCnEoc7/C2e
 qbLq9m5xq2AtYjJA0BymBSSGpyRQv2PhzPyZ9X6PfPPkZF4ilKkKBs9FQFyzwhMsym4J
 ZWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787917293; x=1788522093;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fZrZqhoFV6TidBRsV2AHIIYmq6WMAbgL4B5Dlacd0L4=;
 b=NX4dsLKWT1fhbh3pTgirlt/Q0L+jBqovvulctGqcikJtnWy8PrN1q4DJn6JKoLXotq
 cgEwV40+GnUta3iEYhBElOQxGQtomnYbwTNjj21fxMn2eV77v4JbBS8huu6x3HEHeR+k
 6k5ABQrpI+4crtLjcI43EbI3MBPqzwGKuwAjfCQNQgRyWUKHlNO5AOw/pGt0AEHJthMj
 7tX85dQwC9b6O3Ii6DAV7BgMYzmcKCtMpwOmwFn4NZk9fmiJmJcxNn+P8BIngZ30qu26
 AvOf/nbc5Du9nFu7iUYKTDP61XnJE5J9fYcfaFg8B728pUZf3GBPIxUjhD2+H0qq1LzY
 WNmg==
X-Gm-Message-State: AFuF++m8oKgUXFGr+Ca9bOgSys2NVUNewRhRiO5mYQDviG2dxzVG1twn
 7P452NjrpiRhGs7lnlYmYxeKfaAzBCCxQ4p6xcrlkWkVaVZlFmqXOhKLq9oeH5SV
X-Gm-Gg: AR+sD1206NMptuYeJEA5KtNBzk1VbOBG4+ycIyNGX96bp0dYWo5xMUV3CY+1Lqq4N99
 QQGf9ISTHvcz+lDYaFGC0DD8bRvpAVF5jtPnIiyVzL7CIoyx0QSuDy/+2ZaH6EzGUoFTFQWEvtL
 CMIic5+9LMvROhnbTyXtXDVfKX4XQ5ZGXRdgLlN187TJfR+S3Pap8+kH9+jj4AVSsKsAnNad9ke
 /DqPfcDTgwd1o9WkED9k3sTSK/D5d8ypKSbZIGo0VstPuxE1HFAJWN+NnAARvIgM/3mKqRJm3hg
 DF+j9Llwece3Oq1olGYCkGfp+VCwBtaBvSedMKR4lE9ndSAt7WxvDkJyQg4vlxuscLS3NrZq5Ly
 3OrhSX75P9kxPMDucPKlxmLVy3lQavW1K9pDeAEJHt8IJOZbFpUNxh6xulRsfOJkpGg55f1BWOR
 pg0uMs20457xc7d6tKNxF7xcjl8YZ9nfIQ+LyWWUqYsF3lj5WfOd/Uuir/o9WiyByVQ79kGGACK
 9j/L+gSfGnx0oCMUShNrDyc
X-Received: by 2002:a17:906:9fc4:b0:c25:2ec9:db91 with SMTP id
 a640c23a62f3a-c255701839emr415351966b.14.1787917292975; 
 Fri, 28 Aug 2026 04:41:32 -0700 (PDT)
Received: from Timur-Hyperion (5E1B9A5E.dsl.pool.telekom.hu. [94.27.154.94])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee288a4sm72549566b.16.2026.08.28.04.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:41:32 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 11/11] drm/amdgpu/ih7.0: Enable retry CAM on Navi 4 dGPUs
Date: Fri, 28 Aug 2026 13:41:13 +0200
Message-ID: <20260828114113.13523-12-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828114113.13523-1-timur.kristof@gmail.com>
References: <20260828114113.13523-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The retry CAM can filter interrupts which occur repeatedly,
such as page fault interrupts when retry faults are enabled.
This makes processing those interrupts much more efficient,
because the CPU won't have to deal with processing the same
interrupt repeatedly.

Also change the doorbell range to actually enable the
doorbell for the retry CAM.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c     | 3 ++-
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index 741fcef3cfa1..58d5156a44db 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -395,7 +395,8 @@ static int ih_v7_0_irq_init(struct amdgpu_device *adev)
 
 	pci_set_master(adev->pdev);
 
-	if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(7, 1, 0)) {
+	if (!(adev->flags & AMD_IS_APU) ||
+	    amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(7, 1, 0)) {
 		/* Allocate the doorbell for IH Retry CAM */
 		adev->irq.retry_cam_doorbell_index = (adev->doorbell_index.ih + 2) << 1;
 		WREG32_SOC15(OSSSYS, 0, regIH_DOORBELL_RETRY_CAM,
diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
index cea08134d4c2..a74b17a47fd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
@@ -300,7 +300,7 @@ static void nbif_v6_3_1_ih_doorbell_range(struct amdgpu_device *adev,
 		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
 						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
 						  S2A_DOORBELL_PORT1_RANGE_SIZE,
-						  2);
+						  8);
 		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
 						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
 						  S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
-- 
2.55.0

