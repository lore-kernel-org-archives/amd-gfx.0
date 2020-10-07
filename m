Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D072C47095
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B6F22064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsN8l7l2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6F22064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBD836E962;
	Wed,  7 Oct 2020 16:32:50 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6EE96E979
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:49 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id q10so1488759qvs.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nEC5veO5AkwwItjqrwgqancPfN+vx6BPLVjus7Bqv1w=;
 b=dsN8l7l2pUtBrAcuodF9OKOspmBmABUrEloHH9Q1ekIN0utaIhQ2sviG9nCC8Fh3J0
 Mm4lMLwvCCW42yjFMTz9KEjlVXA/NibY2ubtHw0tfobf9hZjfWFRywbbRP6xo5bbMcml
 5Mx8J9Vp7eSSB7eYIXZUN6VYGJfIO8SKucCXj+u8nURX4yqnkHH25HIWKnavAe4y0H9v
 W3flIGDuLGMpxh9Jjij63k+Z/HXHjSnaqshn3IIuwYXzWa5bXRy3mlK8AO6aNPH8g51i
 5h4wPauuYsLnxtsJb1SnHsPMUptI8OVvohdqW7oJQbeaL9H+Iw4SNq7w4x7jiI2FfDF5
 isCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nEC5veO5AkwwItjqrwgqancPfN+vx6BPLVjus7Bqv1w=;
 b=QEF6KEvfXHCSILPnD5kjIZgEXKgMGHyobWyxlnlkdNptaNDr5tmvFQxLhinkDD86yu
 Y1BvH3xdEv1tW9agxhusyljKhpeeHj/1xE3Kgx9PLvBxyxQZk502F2C+XEYrMJoSSjq7
 NW+/dNQ05YK9ZG0K62XeRkhs+xupWwFmNtjy/bABI63eLUWZkm/5JTQf5gxxVtvVx2ns
 SWi3mcTTx2cEgyoZspbHJqldkq5shBLAkCMt3kJaYNn85/5anNcVXuahnOJd0weufpUw
 dmNdNx38XGFA8mpDMsOOSvXoDfXIXQPqPB52MKJJeUIod0WO76aRA9pX77jWeVaThhqv
 pPAA==
X-Gm-Message-State: AOAM533OhvTYtW+83AI2TRFH/g5A1kb242jo1J6ENBROjnW0yUZMNm3V
 bKqXbgjL+V/HN1iYUgX1/cG5xsVC3Gg=
X-Google-Smtp-Source: ABdhPJyV76IQ2/LMl1pOYm8kJzxDd/LlMqH1J7S8eS6sC0nZyAyAZ/K4Kdv76WboIGf6LNYK2mpJMQ==
X-Received: by 2002:a0c:b741:: with SMTP id q1mr3910878qve.37.1602088368829;
 Wed, 07 Oct 2020 09:32:48 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:48 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 44/50] drm/amdgpu: add psp and smu block for dimgrey_cavefish
Date: Wed,  7 Oct 2020 12:31:29 -0400
Message-Id: <20201007163135.1944186-45-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201007163135.1944186-1-alexander.deucher@amd.com>
References: <20201007163135.1944186-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Add psp and smu block for dimgrey_cavefish with psp firmware load type.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by:Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 9e567a34b94b..b8b9ac722b6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -630,6 +630,11 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+		if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
+			amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
+		    is_support_sw_smu(adev))
+			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
