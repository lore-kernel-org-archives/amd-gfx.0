Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C695C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 15:57:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 265642177B
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 15:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehQ36jRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 265642177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DACFF6E10F;
	Mon, 10 Aug 2020 15:57:07 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA50D6E10F
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 15:57:06 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id 77so8784631qkm.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 08:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=j/gOGQyu79YqV12Onp139BXtL/j2GGssidhmxMnFT40=;
 b=ehQ36jRtFvcHNE2/ytZ4aZQ2thfxnYQgM88qVkvhuZSDviighKS2652c6XpDv/svqD
 9OQUQKFegectLP771FtsAYzqaMymFWENWtC1X1k3lsCiYaMaRKUszWM+Z18OmM4s+hqA
 713mrwsSxRbR7bUCorTaxHW6HTpb5ml6is9yGPeggN/UCky50vE7sKvGepu6H/YcmeYF
 cOEHwaQ4Xa1XaNuHKQjJMYKxZmd84aqaqGIv8h4cY0zRJaYdrW8OF4fjJu5/O+0hNDpw
 l4SoJ4qYppz7EtVD/Kwbj0CTVMDeAthSsnJA+xoBWO/zyoUnsACqTq3xPIZGbGPdWace
 D0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=j/gOGQyu79YqV12Onp139BXtL/j2GGssidhmxMnFT40=;
 b=JUzkDt0sJBi4qn4pfdXb+h1J98H+HVREuU9iRJOK8d5oa9EVqZat2vIyBwmC6pNPqq
 tWwaGcmufeNqPMOMlgNSEX0TXG4GIv4Fdwg2MydkKZgAt0x4FfWEAG+f21YBEMvuTU2+
 Aq81ewKgEyUXT6IqsV2CEsDDEqCOqAIA4AjKgKAXZUeZvqU/bfmyTV45X36Gwkby0wQZ
 YsBmSC4/LV2KVD3vZuCrNeOYgjiAjzY/qLkCFuRutrXTRE3RbUl+WPFrCIFVAJgdi7E1
 5WhGm5ESnjrM+J8WDVq8xlkiPk0CaZJbR0BswUgMvzXCNIUe0laQcyig/zn3QNESFj6q
 BVZA==
X-Gm-Message-State: AOAM532ZA2IloV8BtziV2l831ZM3Wmive/PsrRsg1TdRAglLyCr8g4RV
 UH9ydOGRpXsbBowgknktAtKZ10QJ
X-Google-Smtp-Source: ABdhPJwX7lcokaYpsqvnqiljSk3jE5GGnGxsmAOrtPbQpAJFGy+hGS+4tc8Drz48a+cWFJ7EjvqiJw==
X-Received: by 2002:a05:620a:62f:: with SMTP id
 15mr25997528qkv.483.1597075025759; 
 Mon, 10 Aug 2020 08:57:05 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id j31sm17030009qtb.63.2020.08.10.08.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 08:57:05 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: drop unused function
Date: Mon, 10 Aug 2020 11:56:58 -0400
Message-Id: <20200810155658.287244-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Alex Deucher <alexander.deucher@amd.com>, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is not longer used as of the latest rework of this
code so drop it to avoid a unused function warning.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0f9d87773fa3..ff5f7f7ceec6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2827,24 +2827,6 @@ dm_atomic_get_new_state(struct drm_atomic_state *state)
 	return NULL;
 }
 
-static struct dm_atomic_state *
-dm_atomic_get_old_state(struct drm_atomic_state *state)
-{
-	struct drm_device *dev = state->dev;
-	struct amdgpu_device *adev = dev->dev_private;
-	struct amdgpu_display_manager *dm = &adev->dm;
-	struct drm_private_obj *obj;
-	struct drm_private_state *old_obj_state;
-	int i;
-
-	for_each_old_private_obj_in_state(state, obj, old_obj_state, i) {
-		if (obj->funcs == dm->atomic_obj.funcs)
-			return to_dm_atomic_state(old_obj_state);
-	}
-
-	return NULL;
-}
-
 static struct drm_private_state *
 dm_atomic_duplicate_state(struct drm_private_obj *obj)
 {
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
