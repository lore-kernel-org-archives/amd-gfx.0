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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC33C433E3
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7749208A9
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4ypQLth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7749208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 647176E0D4;
	Mon,  1 Jun 2020 18:03:10 +0000 (UTC)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 892376E261
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:09 +0000 (UTC)
Received: by mail-qv1-xf35.google.com with SMTP id e20so472765qvu.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=344f917Pzm9eUaS7lm24wwOWzG+7u3j27cmn0tA5UKE=;
 b=J4ypQLthbcR3lqI/sWFXepicBMCSnFqsoBScyDuMXmiR71ZK8KVqiCzvcnxVWuuTt3
 6Kn51rojl9BaLJVjJslJtOrv2zaMt9uG0SOdEDZOjZ95APF4TxokaWjTRE1z0sK40imv
 9tSTtVNmT4i+v4BPRDGEgcefNBpO3k2KG+uy9DSSg/O5RhXC92tHubzyaTGFb16Fts5A
 VsE6SNrBCEy4sOj3X9k/neOzwX2NCkG6NXJO4dNGOGH+WmjN+6NnqoTmgIyQ6DHbTG6q
 GLurxV/E2oYk93x1Jb8i14VJJ3V9qy5Dzm/GD7oRRRGsZrLUFiN7hwcVaQMGJHkE6Egl
 S+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=344f917Pzm9eUaS7lm24wwOWzG+7u3j27cmn0tA5UKE=;
 b=orMDdEaeVuyt2IuDy0ONB2Ndq0u4CduvWHimbLQeKT2TD6gLeQ80C1Fe0xUv4KWuS1
 Z7CkWkt40xeNlrWuNOsbVFTMF7PjRRwnpHotL8Fci+mrJnD3Do5C0TQNXGcwGKFw8sdP
 AnXbDBCz2exnQbGsxXB0YCgPnr5EnjX6hsdouv4q6U+uxFesPVxJPmrF7fxIE0k21PQa
 +nlNxvJv1EGCdNhM0AZTq434dHOrPptgjKTzpQTiLBt4WkF5GARmwiJS5DJCsrY4iG/L
 mrdov/fVD37QSyDquoBG/oJ0FCfzd77XjBQklc/evyOz2D6Kc66k0G8cITW/ZDWGbrRt
 VXnw==
X-Gm-Message-State: AOAM532jdPAGYXi6oC8Pd5zuKY9TdDiVK6AaEajIqMCP4e06A41fQpq5
 qH6T77GsY5RpJBETAuhDMN+arC78
X-Google-Smtp-Source: ABdhPJz/6+ntsVtpfxWdjg0QYjnnwVewBkLgMR0CeVTVjlSNPCpYiUSJ8nT5eYA1k6ahlDjrj/CHlA==
X-Received: by 2002:a0c:e385:: with SMTP id a5mr22523783qvl.81.1591034588480; 
 Mon, 01 Jun 2020 11:03:08 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:07 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 018/207] drm/amdgpu: add ih ip block for sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:30 -0400
Message-Id: <20200601180239.1267430-15-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Update IH handling for sienna_cichlid

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 21 +++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/nv.c        |  1 +
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index f97857ed3c7e..471dc82fd1aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -34,6 +34,9 @@
 
 #define MAX_REARM_RETRY 10
 
+#define mmIH_CHICKEN_Sienna_Cichlid                 0x018d
+#define mmIH_CHICKEN_Sienna_Cichlid_BASE_IDX        0
+
 static void navi10_ih_set_interrupt_funcs(struct amdgpu_device *adev);
 
 /**
@@ -265,10 +268,20 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 
 	if (unlikely(adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT)) {
 		if (ih->use_bus_addr) {
-			ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN);
-			ih_chicken = REG_SET_FIELD(ih_chicken,
-					IH_CHICKEN, MC_SPACE_GPA_ENABLE, 1);
-			WREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN, ih_chicken);
+			switch (adev->asic_type) {
+			case CHIP_SIENNA_CICHLID:
+				ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN_Sienna_Cichlid);
+				ih_chicken = REG_SET_FIELD(ih_chicken,
+						IH_CHICKEN, MC_SPACE_GPA_ENABLE, 1);
+				WREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN_Sienna_Cichlid, ih_chicken);
+				break;
+			default:
+				ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN);
+				ih_chicken = REG_SET_FIELD(ih_chicken,
+						IH_CHICKEN, MC_SPACE_GPA_ENABLE, 1);
+				WREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN, ih_chicken);
+				break;
+			}
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index e6fc244d42aa..7600f42ba3e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -486,6 +486,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 	case CHIP_SIENNA_CICHLID:
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		break;
 	default:
 		return -EINVAL;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
