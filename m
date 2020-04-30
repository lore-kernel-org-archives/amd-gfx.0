Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C77DC4724C
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 18:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7329A20787
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 18:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBPJRvlN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7329A20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 369646E94E;
	Thu, 30 Apr 2020 18:37:44 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 112796E94B
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 18:37:41 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id s63so6813092qke.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 11:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TXla+xqjyc+z80y+A1GS3bvEJuC0PKkDk93s+orZbbQ=;
 b=hBPJRvlN/P23Zwn+lQIiuH9D90/BscAH+waB7AXuuqOJMUPdhgXnlMrKDzyQ1KyN35
 31iQP2B7BCBT2lEY30KbVzZKkRrLu069y+kN8lG0VBmdhxPeEzkeYXRyj8akjy/OwYIR
 AdWziP8qIm67IxP++nCb4FCNwTmTl3IdCW46GDV50B/me9wItc8f3jxJ7l3H0mB/kk0f
 Sb7V/ZIiuPdEI5XfXkVRvpXkzfbTd4Gr957ES0OgkrVoyM2hhNhOhNN9J4ZWccubYuIe
 aqVGpE1PmIJnOoRDCK8witvWdRrJAIJZ8+n3CAxgXaKzDH82j7tFE0JRzaTuoD1hguib
 AhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TXla+xqjyc+z80y+A1GS3bvEJuC0PKkDk93s+orZbbQ=;
 b=IObvpunDqzXbGBcSA0j7ih8ZKineD/564S7XUyvFNIQEuYKOlRHe6GAOoQI9zRBBTW
 F7ebuDws7qdB6gmWUZ6Khlu4wIs6SlEPTZoBXnJjoWUi3+4Q2CRF49uj9tArvxZs51KG
 SRxLt1WUAvBj2xQkI/S+kTETLU1LVWcpKlB69WD/a16VaYqYS2F6BBsBfbgBC8/YYm8x
 zk0FlYXHmg/PKscPBSkQziqD04c2sW2ffbxnMKh669BKia3KdZGYSoKC+m0cfoK8rQR+
 ee8i9ERCrDmOdkyLTKmiDKlT34jqbmdn9BycNx8kv0nno8PAA3OPPjHrLzxtsQZ5X7ps
 zMww==
X-Gm-Message-State: AGi0PuZVdvbHK9LgN1jH6cKqB5gZ1rQClDpJnvzoNffiBzhvdTvDgAP/
 TnKTQpnneNufC+5YUXroarITNRSc
X-Google-Smtp-Source: APiQypIKbf0x0fdkmdiaBoquz0EkGJ+W/Ce5IbofxQNemLIUWR0wGOoZUDg/McSw+SKZ1Pzz7GM16g==
X-Received: by 2002:a05:620a:1396:: with SMTP id
 k22mr4870519qki.424.1588271858442; 
 Thu, 30 Apr 2020 11:37:38 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id c139sm693510qkg.8.2020.04.30.11.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:37:37 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/8] drm/amdgpu: Rename amdgpu_gfx_kcq_queue_mask_transform()
Date: Thu, 30 Apr 2020 14:37:17 -0400
Message-Id: <20200430183719.419549-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200430183719.419549-1-alexander.deucher@amd.com>
References: <20200430183719.419549-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yong Zhao <Yong.Zhao@amd.com>

Rename it to amdgpu_queue_mask_bit_to_set_resource_bit() to be more
specific about its functionality. KFD will use it later.

Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 16 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index ed212c070e8e..d612033a23ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -48,7 +48,7 @@ int amdgpu_gfx_mec_queue_to_bit(struct amdgpu_device *adev, int mec,
 	return bit;
 }
 
-void amdgpu_gfx_bit_to_mec_queue(struct amdgpu_device *adev, int bit,
+void amdgpu_queue_mask_bit_to_mec_queue(struct amdgpu_device *adev, int bit,
 				 int *mec, int *pipe, int *queue)
 {
 	*queue = bit % adev->gfx.mec.num_queue_per_pipe;
@@ -274,7 +274,7 @@ static int amdgpu_gfx_kiq_acquire(struct amdgpu_device *adev,
 		if (test_bit(queue_bit, adev->gfx.mec.queue_bitmap))
 			continue;
 
-		amdgpu_gfx_bit_to_mec_queue(adev, queue_bit, &mec, &pipe, &queue);
+		amdgpu_queue_mask_bit_to_mec_queue(adev, queue_bit, &mec, &pipe, &queue);
 
 		/*
 		 * 1. Using pipes 2/3 from MEC 2 seems cause problems.
@@ -485,17 +485,17 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev)
 	return amdgpu_ring_test_helper(kiq_ring);
 }
 
-int amdgpu_gfx_kcq_queue_mask_transform(struct amdgpu_device *adev,
+int amdgpu_queue_mask_bit_to_set_resource_bit(struct amdgpu_device *adev,
 					int queue_bit)
 {
 	int mec, pipe, queue;
-	int queue_kcq_bit = 0;
+	int set_resource_bit = 0;
 
-	amdgpu_gfx_bit_to_mec_queue(adev, queue_bit, &mec, &pipe, &queue);
+	amdgpu_queue_mask_bit_to_mec_queue(adev, queue_bit, &mec, &pipe, &queue);
 
-	queue_kcq_bit = mec * 4 * 8 + pipe * 8 + queue;
+	set_resource_bit = mec * 4 * 8 + pipe * 8 + queue;
 
-	return queue_kcq_bit;
+	return set_resource_bit;
 }
 
 int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev)
@@ -520,7 +520,7 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev)
 			break;
 		}
 
-		queue_mask |= (1ull << amdgpu_gfx_kcq_queue_mask_transform(adev, i));
+		queue_mask |= (1ull << amdgpu_queue_mask_bit_to_set_resource_bit(adev, i));
 	}
 
 	DRM_INFO("kiq ring mec %d pipe %d q %d\n", kiq_ring->me, kiq_ring->pipe,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index ee698f0246d8..d43c11671a38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -364,7 +364,7 @@ void amdgpu_gfx_graphics_queue_acquire(struct amdgpu_device *adev);
 
 int amdgpu_gfx_mec_queue_to_bit(struct amdgpu_device *adev, int mec,
 				int pipe, int queue);
-void amdgpu_gfx_bit_to_mec_queue(struct amdgpu_device *adev, int bit,
+void amdgpu_queue_mask_bit_to_mec_queue(struct amdgpu_device *adev, int bit,
 				 int *mec, int *pipe, int *queue);
 bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *adev, int mec,
 				     int pipe, int queue);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
