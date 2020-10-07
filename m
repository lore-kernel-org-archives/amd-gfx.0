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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDDFC47095
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96EC92064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ertEqP5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96EC92064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 392BD6E977;
	Wed,  7 Oct 2020 16:32:54 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 416C66E977
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:53 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id s47so2413826qth.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Uc+GPRonU9krE6cPl2TjSfglb8hB+dxdrkfqSSEOhYo=;
 b=ertEqP5IVFPgNZno8Dtq05Dp8Swf/x/x5pn4xS3UvLao56xihD8226SJchyJrZnvM3
 ShlNFSj6ADIsndhUv1SxSvgviLqNLpUZZRpNFGBiFRmk82YR8f4/uJzpIWNV7slxOEpD
 HIaQ9GIMb6mpandUxiMioQedMS/7CVLmHCMkcYmURyA8rlj9Imr5onqoJDoDEbbYFWJD
 L1GqhYB2Qax51qDSdwG6v4YyDAYzEWM2/7gNrpTF6zh/514K9Bv5o6FUaR1MgOFYfdin
 2LFaojjSXnkeJt7fTnTJU75DjL8m+2le23WhGRhwwlZfHC1c0upCqOSOf+fP2RhaSS8D
 bVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Uc+GPRonU9krE6cPl2TjSfglb8hB+dxdrkfqSSEOhYo=;
 b=MYY0nywBsY7/wjOCFKee7xnDfhptCUFfevaZisHAoEFFPWaLDW6aMtLNvbiC4wIxuE
 OsjA6nOJ3DqKlLZNX32OVfFjvKXTli5U8di3mDYDmeeG7A7Bvlw0fS0KzxsTO8ODN/3D
 huatP1lXuQ6iRVIHAtuejyosHcI5gsnxcFf1G4abkmP8+wzEDqLV9qgmhEHGGlvRowFN
 xqDeLEeXlBp+2M5VjES3PKuoGFQ/U9/syrE6OQEyBmuBl8rB3HUOEFy0zJq2BWAZaRdG
 3HuH8CYBu7VexNgkFj3KW5bALNwuRdGFgXBfPyWaNKWL4EkdBi3Z3SmdCq9NFL4VFttu
 KaEg==
X-Gm-Message-State: AOAM532jYESXjXKfgHc9hULcGyLUSJ956ei0OqGFKOVvr5fNqAnSxNlZ
 v7nU7+hm4YCsQdh3XeFPPmCXN8jsSw4=
X-Google-Smtp-Source: ABdhPJyIuyNG3i18b5yBBlE66UIKv5EwyH6vo4vJT7SvTfi3cfKMiXzcqjFF/RPKhdV/iG7Mr3GLlg==
X-Received: by 2002:ac8:c44:: with SMTP id l4mr4120077qti.2.1602088372099;
 Wed, 07 Oct 2020 09:32:52 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:51 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 47/50] drm/amdgpu: remove gpu_info fw support for
 dimgrey_cavefish
Date: Wed,  7 Oct 2020 12:31:32 -0400
Message-Id: <20201007163135.1944186-48-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Remove gpu_info fw support for dimgrey_cavefish, gpu info can be got
from ip discovery.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5de583295fe6..19d70e2445a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -81,7 +81,6 @@ MODULE_FIRMWARE("amdgpu/navi10_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi14_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/vangogh_gpu_info.bin");
-MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_gpu_info.bin");
 
 #define AMDGPU_RESUME_MS		2000
 
@@ -1785,6 +1784,7 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 	case CHIP_VEGA20:
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+	case CHIP_DIMGREY_CAVEFISH:
 	default:
 		return 0;
 	case CHIP_VEGA10:
@@ -1819,9 +1819,6 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 	case CHIP_VANGOGH:
 		chip_name = "vangogh";
 		break;
-	case CHIP_DIMGREY_CAVEFISH:
-		chip_name = "dimgrey_cavefish";
-		break;
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_gpu_info.bin", chip_name);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
