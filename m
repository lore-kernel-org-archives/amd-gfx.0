Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21D8C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:30:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8FCF2074B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjHIDJn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8FCF2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 766EB6E9DA;
	Mon,  1 Jun 2020 18:30:20 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84F886E9EE
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:30:19 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id w3so10020868qkb.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3wiEcsM4wCQChlA0CMHBpp8ZPYilEoUtifc+XNuncPE=;
 b=TjHIDJn8YvwoVdO53EuEIa7KuFLm+y8I0SBhnqL2L6TTf4n7U4Ri+6DlvST0/v98T3
 9WP2xwUeYCL84HhIqQDZUezcE5Cu5yLcQF4+k9azkIHm/3g/NfH+uZyrRy/tqTyO6+Vq
 a51YFUtfuzkZEzx+gS4g/WV7j9zrn1ur7Jgiod1EvVXOBtAu4rUx13857irwUujvU/6g
 I39iXCALu9K3YrsVTGsX+evBmm7kXbXgs0wO9CQ+MSKvLHH8I+5zKVAXaN1ExMvAA5XM
 yjuOC4AW8O//3eV15m1n+/9CJCLHe6ijOVQDBNdb0D+7JahtPZ7C7hKV3Pd2EVDbcMYB
 VP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3wiEcsM4wCQChlA0CMHBpp8ZPYilEoUtifc+XNuncPE=;
 b=MoVDrI0efzc1G5Qo9RkZM+sPeN+NF8GlMMyKKkJg3aSo1bHikDhXwti8GUqrrmVUMs
 9Dcwh0wKyRdMu8QdBGPWMZ5flrDec0g8O+20AWmtSTxv/FO9FAE7sosQLd7LtixzU/xl
 1Nsawex5ZdVIs1AjLI2TVvTo1GytDj+g9+q+Hi43UP6JfLCzzqCEAPvQ3V0JptBjID0S
 cxNRYxbvpxeFGoa5r5X5SB7hf7WpgaMNwAx29tbxttAp409OrxE5oW0virEJctVddSbA
 SnZ9Aw5Vh8gPTTnriq1IV7VxFsXZkW1TicWu5MGxZv448Ig7hz64q7hcGXRjP8Wc0oZx
 Vk0Q==
X-Gm-Message-State: AOAM531Hz1yv4ozEliNdZ2dBoGRCI9tDUHePVUYJNKxvThQ6YqxZOSu5
 z+F8m/dMp6IMEEG8JE4zQ8FBdCgq
X-Google-Smtp-Source: ABdhPJwdg1qlhrSIl+EKYrEvkUL7IAAKrsGt62Gg3ZiNh1ha8GIikWLJSBGlE7d5jVNHDp7GdvMQ/Q==
X-Received: by 2002:a37:aa92:: with SMTP id
 t140mr20756119qke.145.1591036218427; 
 Mon, 01 Jun 2020 11:30:18 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id z194sm8592qkb.73.2020.06.01.11.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:30:17 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 204/207] drm/amdgpu: Enable DM block for DCN3
Date: Mon,  1 Jun 2020 14:29:23 -0400
Message-Id: <20200601182926.1267958-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182926.1267958-1-alexander.deucher@amd.com>
References: <20200601182926.1267958-1-alexander.deucher@amd.com>
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index ef3f07dc89cd..a7cfe3ac7cb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -497,6 +497,10 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
+#if defined(CONFIG_DRM_AMD_DC)
+		else if (amdgpu_device_has_dc_support(adev))
+			amdgpu_device_ip_block_add(adev, &dm_ip_block);
+#endif
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
 		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
