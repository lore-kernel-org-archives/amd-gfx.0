Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06694C4727E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9725E2399A
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYIG6zMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9725E2399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 254226ED63;
	Fri, 25 Sep 2020 20:11:29 +0000 (UTC)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C698D6ED69
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:27 +0000 (UTC)
Received: by mail-qv1-xf2e.google.com with SMTP id h1so2033820qvo.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v3mjAXG2q3+G6jZX2HGd15BkgF1I/Mx8kNnGQthEwQE=;
 b=LYIG6zMPMpk9buAZL13M1ZIqWmdYDWSAJ5oB5aqqUiTP5tEdsgTRMETsjsPtLU4w7h
 U54UdPxV0EODcUzsZLC6UEM6fV+wmWBdBudbbQ5sPzv6QEHD25aikqknkE1tSyVE1TCI
 VhJJBwhY29tcwXv9pVcQoHJpcnQJV6sPFAtFRGFbyjoaGwYDuVlla7A9m1IUYysJ7Io9
 rqtXd7PqhsJ1mR5cuYDZvxEMNuRaZtkIwJWCgvsSAPPWgstntWLbjPsyxdAKjCne1U2y
 WDJOJ1T/s/jqj8kc8NolxoAGU9j6lQ5lEycWVUFoCOgPT5nmCY9gqzeTnaSlYKeHEh2G
 5iWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v3mjAXG2q3+G6jZX2HGd15BkgF1I/Mx8kNnGQthEwQE=;
 b=s2/N9PMfqihNZH3dRjIDybLzA1Zs2mwpNVMw/C7SbiitbMS8agM4xWU97Qvpe4dMIu
 KsLha5A0IiNFFea0aEVnJH8yzPe6WPucagf4oPMFmlOGDM9AOSXOT2frwqwrqDvuy5+y
 7ZQggj4t2d2atVQmzE322Bh3DZUOlgL55LaRjG0fvWDdaHeAGa/OAYNiSwi5MLpE/wG9
 Dv9mEhgOj/dmwDtnrt89zq7Ko4SqyoMY9gCijBAF6cqkXBQf6lTZFDQdKqP5Gm2i7DSH
 TCYKokXSq03drK4Q5vub8mL0w9gZHlg2lYKO3xtKCtYeqN/P+7QzEip5v1RXKMeH0UmD
 /SvA==
X-Gm-Message-State: AOAM533fEMqWyyyi5BHULzWPqe7RiYfd/GyVEzi5svF780UH+K1G1xI2
 EeDWtCHUHEPdG/kvXpdCS8mTevy++ms=
X-Google-Smtp-Source: ABdhPJxxXAfjYYAq6nExJmxWjLWS/eu5uBIHkFWsKY2w7O9sVbTNWbZEPVW4yedLEvgGLSqKFQXc/w==
X-Received: by 2002:a05:6214:b2a:: with SMTP id
 w10mr329167qvj.33.1601064686623; 
 Fri, 25 Sep 2020 13:11:26 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:24 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 23/45] drm/amdgpu: enable vcn3.0 for van gogh
Date: Fri, 25 Sep 2020 16:10:07 -0400
Message-Id: <20200925201029.1738724-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200925201029.1738724-1-alexander.deucher@amd.com>
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Thong Thai <thong.thai@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Thong Thai <thong.thai@amd.com>

Same as other VCN 3.0 asics.

Signed-off-by: Thong Thai <thong.thai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/nv.c         | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 495c3d7bb2b2..81102598cde7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -44,6 +44,7 @@
 #define FIRMWARE_NAVI12 	"amdgpu/navi12_vcn.bin"
 #define FIRMWARE_SIENNA_CICHLID 	"amdgpu/sienna_cichlid_vcn.bin"
 #define FIRMWARE_NAVY_FLOUNDER 	"amdgpu/navy_flounder_vcn.bin"
+#define FIRMWARE_VANGOGH	"amdgpu/vangogh_vcn.bin"
 
 MODULE_FIRMWARE(FIRMWARE_RAVEN);
 MODULE_FIRMWARE(FIRMWARE_PICASSO);
@@ -55,6 +56,7 @@ MODULE_FIRMWARE(FIRMWARE_NAVI14);
 MODULE_FIRMWARE(FIRMWARE_NAVI12);
 MODULE_FIRMWARE(FIRMWARE_SIENNA_CICHLID);
 MODULE_FIRMWARE(FIRMWARE_NAVY_FLOUNDER);
+MODULE_FIRMWARE(FIRMWARE_VANGOGH);
 
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
 
@@ -123,6 +125,12 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 			adev->vcn.indirect_sram = true;
 		break;
+	case CHIP_VANGOGH:
+		fw_name = FIRMWARE_VANGOGH;
+		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
+		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
+			adev->vcn.indirect_sram = true;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index df94f72e017a..2711c5661a97 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -612,6 +612,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
+		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
 		break;
 	default:
 		return -EINVAL;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
