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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9225C47255
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 18:37:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A476620836
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 18:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObM5K9tp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A476620836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31E826E941;
	Thu, 30 Apr 2020 18:37:35 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A4C86E941
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 18:37:34 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id g74so6762702qke.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 11:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Zigw6+WYw0oSbjw+jcghbiFGb2BvOKDGZzBSuQWDqmQ=;
 b=ObM5K9tppEfZSOSshc3Cy3z6C49TgZ7lhNlIkHYEDuLTT0XIVUR2Ns5EJWLeRcjglQ
 LgbwZTDbcXb91pb8bgZdDG35pnAaFoKKWsqeSIPCO903gjEbbSBDIrUDzKK0/PVT0E5r
 7kZXcYKhMlrzmz/oxTjxBHn2gJI5dzl2d2uGhXAeVLkB3GM8CP7lB2NpHtdvuEIKukbz
 UvOLYQ2nFh49/SEFUOuA/rk+HRuoJvgUjJelsyJDO6S5LSr1QUrzWPENznWoTkdEpUlC
 JS1C7blE1Y+cVsNyBDypw+oVrFFsjA21KMOGqr3jMmvKeE/FbINKG2JQqqxy0zq6I+Pw
 uomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Zigw6+WYw0oSbjw+jcghbiFGb2BvOKDGZzBSuQWDqmQ=;
 b=o17x1COHLANLScig88Pe21M8S0PQItH2yRoWtAihcET6HZnO3F5ZiwfgT0jjyAefyB
 pHloeT1wT8R/V6tw7h55GrPV0r8wMDOwDlEP/0dBkNhYNKJts6qIFIAQdQox9wovK9Ss
 ZcYL8zl53VBmG601gJ8ETbMqtR/RvCbU5ZErht7a9GZ4Im5m9AmvqBp8pxLhX+4aXfO2
 3k6HdjsFeoDJHaPIjLVJ2sEiQMsTj8qXSZvCPpWmhw4UogeiAEkmdHEBzebFaKoB1LQM
 yNhPP+9XwE0w8QTLUPCtRDqY5y7dyqEwrGFvfb0YvkWUsJxOVW4gu5iwB7gvo2Z4bX1X
 T3Ig==
X-Gm-Message-State: AGi0Pubj9+L7lLl0i7MUZNNGe0QAhGUMFH/XbfXPp7++6FslWaPVUv8e
 hZb6yjmd8Pg88Hv3XtNn4ZWyrQLM
X-Google-Smtp-Source: APiQypJ7SlpZjbMKm1cpjfvF0XvHYiJcvVf4rsiZ8IqXeHfo1bre79zYmThDopfKwt10zIyjxmTfUA==
X-Received: by 2002:a05:620a:949:: with SMTP id
 w9mr5008356qkw.217.1588271853430; 
 Thu, 30 Apr 2020 11:37:33 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id c139sm693510qkg.8.2020.04.30.11.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:37:32 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/8] drm/amdgpu: update the method to set kcq queue mask
Date: Thu, 30 Apr 2020 14:37:14 -0400
Message-Id: <20200430183719.419549-3-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Use a common method to set queue mask before set kiq resource.
The value of queue mask must suitablt for the designated form.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 0103acc57474..ed212c070e8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -485,6 +485,19 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev)
 	return amdgpu_ring_test_helper(kiq_ring);
 }
 
+int amdgpu_gfx_kcq_queue_mask_transform(struct amdgpu_device *adev,
+					int queue_bit)
+{
+	int mec, pipe, queue;
+	int queue_kcq_bit = 0;
+
+	amdgpu_gfx_bit_to_mec_queue(adev, queue_bit, &mec, &pipe, &queue);
+
+	queue_kcq_bit = mec * 4 * 8 + pipe * 8 + queue;
+
+	return queue_kcq_bit;
+}
+
 int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev)
 {
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
@@ -507,7 +520,7 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev)
 			break;
 		}
 
-		queue_mask |= (1ull << i);
+		queue_mask |= (1ull << amdgpu_gfx_kcq_queue_mask_transform(adev, i));
 	}
 
 	DRM_INFO("kiq ring mec %d pipe %d q %d\n", kiq_ring->me, kiq_ring->pipe,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
