Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EEBC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2919F2077D
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3G/M8MK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2919F2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFBDC6E2BD;
	Mon,  1 Jun 2020 18:04:22 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C69336E2BD
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:21 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id 205so9962347qkg.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MaCE7ql3DwE69xY5D02jZsu+v4PXBPWKnWhPpqBga6w=;
 b=q3G/M8MKRO88KJdgfBZkjKsJDPSxDqBxuSNdY9ufQBTQqKWrAaaHrufpjLzEJ9+JKh
 8XC5VDaE4l+mhcrSNdjq4J/Vc4KbX/HR8XOMkrMAy+7Iu2eXK79d9ghhxJeITFWWhFJV
 DHx23o5iqMTziwm1vM3YnkQb/NoVIb9UspfPff01k842f3qA778Rjtnf0+6dlRXgXjk+
 inD9BopFbKb4jKi/aK7P/vNNYEYCEpcNayiRZALS/22qGzlE5KkpKZtGRZypWI8qtWqP
 mNHabdcY9RdgOWLZcMj5Z1GjQTjl0s2b0wGoalF8oAiK83l2vQfR09qAoCEZQgWVd8+v
 jaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MaCE7ql3DwE69xY5D02jZsu+v4PXBPWKnWhPpqBga6w=;
 b=BjujW7DUrS0P2HFvU16dP/Vm/2G9RTVi5Q/gbwOB2D+mpr0X958UJiG+HubglFxW43
 v8ZA5hG2Uo7Z6IfkvmZGbxAKqq45Q7WiI5kT9qyj0CWmxId7q7O+Ynv1IQ+avIYYvx51
 giTEUz9J4vAwMUg2Z5vHt8DTR15+gU8sgn7Spv6JPVTETfA2yESXMxo5z7btbDU/rHB7
 PmhMbtaBfTEuY3TtMA+zb6nYFwayG+V/h9tlej+heI9dNvIerIex8DoJlsYot0wPCBS1
 Rjb6RAGm4iGXOjr1+IcuUXdEDtBkb33igpdD1VD3W4eoYSjUYxhl1QgCxr/UGlVxvRuO
 y4dQ==
X-Gm-Message-State: AOAM531hdYBe4r6fnXc/krMCuuw73QXPv3TTbOZ3U+hqSFhUn0VdYZKh
 PgB3kDtjuFAqp7NLRrJmP7HWXO81
X-Google-Smtp-Source: ABdhPJws8qbag3RzuNj15EHfi6f5+rPHpItk/Zm2IhT53+HdX6ZEMKrYs+6+hH1hey9Yk4vE+mwMCg==
X-Received: by 2002:a37:7105:: with SMTP id m5mr22228993qkc.370.1591034660788; 
 Mon, 01 Jun 2020 11:04:20 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:20 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 066/207] drm/amdgpu/mes10.1: enable the mes ring during
 initialization
Date: Mon,  1 Jun 2020 14:00:18 -0400
Message-Id: <20200601180239.1267430-63-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Enable the mes ring during mes block initialization.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 31e8e7120640..36a92bf2c4ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -32,6 +32,8 @@
 
 MODULE_FIRMWARE("amdgpu/navi10_mes.bin");
 
+static int mes_v10_1_hw_fini(void *handle);
+
 #define MES_EOP_SIZE   2048
 
 static void mes_v10_1_ring_set_wptr(struct amdgpu_ring *ring)
@@ -569,6 +571,25 @@ static int mes_v10_1_kiq_enable_queue(struct amdgpu_device *adev)
 }
 #endif
 
+static int mes_v10_1_queue_init(struct amdgpu_device *adev)
+{
+	int r;
+
+	r = mes_v10_1_mqd_init(&adev->mes.ring);
+	if (r)
+		return r;
+
+#if 0
+	r = mes_v10_1_kiq_enable_queue(adev);
+	if (r)
+		return r;
+#else
+	mes_v10_1_queue_init_register(&adev->mes.ring);
+#endif
+
+	return 0;
+}
+
 static int mes_v10_1_ring_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring;
@@ -640,6 +661,10 @@ static int mes_v10_1_sw_init(void *handle)
 	if (r)
 		return r;
 
+	r = mes_v10_1_ring_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -680,6 +705,12 @@ static int mes_v10_1_hw_init(void *handle)
 
 	mes_v10_1_enable(adev, true);
 
+	r = mes_v10_1_queue_init(adev);
+	if (r) {
+		mes_v10_1_hw_fini(adev);
+		return r;
+	}
+
 	return 0;
 }
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
