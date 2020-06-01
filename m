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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800DDC433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5673E2074B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUa7uLdM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5673E2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 176746E2B1;
	Mon,  1 Jun 2020 18:04:13 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAAAA6E2AF
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:11 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id j32so8407846qte.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=he5B4a76WNpZx+229udey+f5R0ttO3EcoIT75AIXI8Q=;
 b=pUa7uLdM3rrVjS4yHYae0NQ1x2P1iqafdra/aBvwtOqSlLU+7DlMeS7dzkhYSnC+gc
 PL1ldBBF3CGBhCmEUwbPNV8czy4eEDTVyHuZjMpqWBia1sHT5bObuxdacjYQGAIaGWXQ
 mKzoeqKza4lmQi1RXBVDna9Su562jZT1pLeUdCno3e7pC2aU++MgnLdpa5AvLzmcQ5TX
 C2OwEDiZ4NKpLSpd9cqWZiqKtboACrKXEl0Qrk7dHZYqF4zAilraoRJ9MABBvgpQv3Os
 AbU9FeLh9NJDMJXtGZex0U/WMg4ihBQzv9kkCkah73hCmYzgwILRFFvP6gjmM8e8B6R8
 638A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=he5B4a76WNpZx+229udey+f5R0ttO3EcoIT75AIXI8Q=;
 b=IU10YXFbDsXcEpWkUZ8a35E4pIAKnrxHFgi4Q+r24RO7lhSlVDkY0IVKKCljpG6mMH
 td+laMvj9ZX5hpnurdpYZTYjgAP2V0BRplcN0cJwr5JK7nxXjFP0jjG4DbeOREUh+1wj
 /ungbwvRo/TfDsgOUrHzDlF2hwXkZw2ai8e39npfn6GQOl73roD0Zz03NJ8H/5lQ1rPs
 NrQBQEvAsd3usJBXA1zEeOPN1Y+6TWuEpp1AryyKCqSvoQnQZt84cp4MKjKvWXXDsYhG
 XzIIZK0DfjkmcuNYPtxG7BRFxFHN+wiVM1M5zbr5tPNli8SxuoMt2nbTyauFGT+tfuwn
 +ceA==
X-Gm-Message-State: AOAM5328ZbgftNm+8p+rTzG7scvw53RQLO7XGFR6fJZgAydy1lqIIHzj
 PcO7zUSv/WSyLsB/x1vy1QI0zUaD
X-Google-Smtp-Source: ABdhPJwtgksF6cRNokClOZg72jxI4bzTd85sImtp02pK+6loPILrbZtcLBCeWSv5uDUFYAFw5w979w==
X-Received: by 2002:ac8:3267:: with SMTP id y36mr24333389qta.241.1591034650743; 
 Mon, 01 Jun 2020 11:04:10 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:10 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 059/207] drm/amdgpu/mes10.1: allocate the eop buffer
Date: Mon,  1 Jun 2020 14:00:11 -0400
Message-Id: <20200601180239.1267430-56-alexander.deucher@amd.com>
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

eop buffer will be used for mes queue setup.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 29fab7984855..7970107be532 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -31,6 +31,8 @@
 
 MODULE_FIRMWARE("amdgpu/navi10_mes.bin");
 
+#define MES_EOP_SIZE   2048
+
 static int mes_v10_1_add_hw_queue(struct amdgpu_mes *mes,
 				  struct mes_add_queue_input *input)
 {
@@ -283,6 +285,29 @@ static int mes_v10_1_load_microcode(struct amdgpu_device *adev)
 	return 0;
 }
 
+static int mes_v10_1_allocate_eop_buf(struct amdgpu_device *adev)
+{
+	int r;
+	u32 *eop;
+
+	r = amdgpu_bo_create_reserved(adev, MES_EOP_SIZE, PAGE_SIZE,
+				      AMDGPU_GEM_DOMAIN_GTT,
+				      &adev->mes.eop_gpu_obj,
+				      &adev->mes.eop_gpu_addr,
+				      (void **)&eop);
+	if (r) {
+		dev_warn(adev->dev, "(%d) create EOP bo failed\n", r);
+		return r;
+	}
+
+	memset(eop, 0, adev->mes.eop_gpu_obj->tbo.mem.size);
+
+	amdgpu_bo_kunmap(adev->mes.eop_gpu_obj);
+	amdgpu_bo_unreserve(adev->mes.eop_gpu_obj);
+
+	return 0;
+}
+
 static int mes_v10_1_sw_init(void *handle)
 {
 	int r;
@@ -292,6 +317,10 @@ static int mes_v10_1_sw_init(void *handle)
 	if (r)
 		return r;
 
+	r = mes_v10_1_allocate_eop_buf(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -299,6 +328,10 @@ static int mes_v10_1_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	amdgpu_bo_free_kernel(&adev->mes.eop_gpu_obj,
+			      &adev->mes.eop_gpu_addr,
+			      NULL);
+
 	mes_v10_1_free_microcode(adev);
 
 	return 0;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
