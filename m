Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0E0C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83F03223C6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWwuKsEw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F03223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52E2E6E84C;
	Tue, 14 Jul 2020 18:24:42 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D9F46E84C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:24:41 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id d27so13590160qtg.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kKRza7tQNVekkdlxf8wR1cP0Pmb4CSUpX6PfCdsF8vc=;
 b=mWwuKsEwKEokMgi3WQ8lHxlGqtW9ozVzXnYqhmcrsQfEXrISP0y/FzftZyUcCgrQES
 wfBdqV62z9hy6wxFW25k3OhoMdK8uguqQeWjcxQkc5HhBybt2XzcOoscdXxwx9B6pUHO
 Sz7zoqQkIx05gfK9BKcnVQZbVYPQtQaIZj1VaZQ8wHIU0ZmDmRTIBn2oMF/fn95C2eS2
 vhu4vm8th8xMVyayU3R+09cRAdL5/MduuN+HIy+VhOrWBSXMkpAyHz2f4CLjE2XlWQD7
 r01cj2fA0Ck93bX7xuto+/ig45IYx1cSYHcctV3fZlsyWu6YWw0REpT0oUx3kxN2bWXF
 uCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kKRza7tQNVekkdlxf8wR1cP0Pmb4CSUpX6PfCdsF8vc=;
 b=O4OfH5ED801LyngejLyiSMuvvnu3PGCwRPD3p9Y1xBzeJV5oUMqBukLy/auxZ2dGbB
 u8YAQvhbeRqxA/m2DplDU/Mnh71khfQXJGvaHaZPFfxFNXueNzB0IrNHj+Gw0oI5qz2U
 yerZ1UBY3W5E/xQYh9VTNiSCWtJOtOhZsqUAlFqBokcftiyxSe9po7eKRTvee8mXHsMG
 VmSMotwz/7+UhzN4wWgXeL6r8HPSLe7K9FvD6Cx/nlPqgm57dTPtWOxldba35J1v3btH
 tPDx/PbGqS/CM5COpt4tckSlr+BrP3sQEQYVQ5XnM9w6PAT8fK6309zetmZDMEVfLRXe
 FkFw==
X-Gm-Message-State: AOAM5307yPrci8ZkbyN4XyPOyYqW38ORJocZ02om1GXL1BB67E7Pa3A7
 WqWXIdmturpBkxHQnt9R1/M5IepM
X-Google-Smtp-Source: ABdhPJw3cD+qvM9el8diTvwY7xejcNt5eqHsARn4Ow8OzW35lwoBXaMq9Rjyb0rAbNHKnLIApbEXyw==
X-Received: by 2002:ac8:4d5d:: with SMTP id x29mr6116899qtv.358.1594751080372; 
 Tue, 14 Jul 2020 11:24:40 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:24:39 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 24/42] drm/amdgpu: add psp block for navy_flounder
Date: Tue, 14 Jul 2020 14:23:35 -0400
Message-Id: <20200714182353.2164930-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714182353.2164930-1-alexander.deucher@amd.com>
References: <20200714182353.2164930-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiansong Chen <Jiansong.Chen@amd.com>

Add psp and smu block for navy_flounder with
psp firmware load type.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 383db88f4995..e62426a2a929 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -512,6 +512,11 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
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
