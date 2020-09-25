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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85232C4741F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F7152399A
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtVloWJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7152399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 815C16ED1E;
	Fri, 25 Sep 2020 20:11:04 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 353EF6ED1E
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:03 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id a4so3104018qth.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HgtkzZflLeRYbceYifSJwrDM3cxCuFdhJs4Hqs+WkNk=;
 b=FtVloWJ//3ek2ExbBOEoOmpSG/Thtsf5EIIA8m5isq9YfHSxxH1C5OfwRbFh3aaVSe
 IsvVs8xgGjlPCVhEiYAnLD0/tu9FoRkkVien0oDMlJNHdTCri3ib7/eaUfr25B5XVKen
 7XhbMliTKGUuo9DGovjmxMeCmQnWVTVcHP5yoVj4shw04KMZ2O279EPZ28rrJ+E4qIZt
 tPSCtU6zie1sbRJ/XACvqPJdcghakgpcxgX5xms0bGNEsVKIuVskwg97DLK+7t6OqO70
 nhDXukuLMmR7sgdcT9j9Jk8RSmuaOQEedPlUfvoLg8SopVHKvcF6yZoIAhKvNO4GphNq
 twvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HgtkzZflLeRYbceYifSJwrDM3cxCuFdhJs4Hqs+WkNk=;
 b=IHRvhgs26P8XJdQ5s7ijOYiiqeu02KtrDy7UDby6om00uT3lCnAI97OkcnrC5Vg+lu
 mq2lxavioMi3qvDKpFdXxf4sEXqf8X8e2bOL5kPkEnYzEzXr9Z/uUmLExlK4jYZCyyXU
 dWRayEq/zzNB9wC+jY8Ua0a8j/QAA7cwUVpDlbr92+DdCCxOoobgguCr96CnV+t2JoXp
 lC1uUxVv5UDS414lT9K+BJcZOHeJosbtl0sNdUZXWQQyjyR6xOTQk2vw/J+y2Qnjh06F
 MHzw71IVKYrLMaQ4g2nsytGrZLwSb/oVTGQnZxzdmfPVm3jfibbAxD6L7E1qlNV10lvT
 BpeA==
X-Gm-Message-State: AOAM5313CRo8PCQqYCVJHrjhTmyRuBW1m0VVdD9Uy4L4hwlq5BbNIIiS
 MeU+TGzpAu7t8IHhxaaw/UDMESDJWUM=
X-Google-Smtp-Source: ABdhPJxmGiXbahD+iteV+7GM4dM0NxL3e+yYc5YB5MckUK+Om/FM39PjFQWkD6stJFscSqKMqYpyUw==
X-Received: by 2002:ac8:581:: with SMTP id a1mr1374620qth.161.1601064662193;
 Fri, 25 Sep 2020 13:11:02 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:01 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/45] drm/amdgpu: add van gogh support for gpu_info and ip
 block setting
Date: Fri, 25 Sep 2020 16:09:48 -0400
Message-Id: <20200925201029.1738724-4-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

This patch adds van gogh support for gpu_info firmware and ip block setting.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ecaa35ada79c..191d86c6c551 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -80,6 +80,7 @@ MODULE_FIRMWARE("amdgpu/renoir_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi10_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi14_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
+MODULE_FIRMWARE("amdgpu/vangogh_gpu_info.bin");
 
 #define AMDGPU_RESUME_MS		2000
 
@@ -1703,6 +1704,9 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 	case CHIP_NAVI12:
 		chip_name = "navi12";
 		break;
+	case CHIP_VANGOGH:
+		chip_name = "vangogh";
+		break;
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_gpu_info.bin", chip_name);
@@ -1877,7 +1881,11 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	case  CHIP_NAVI12:
 	case  CHIP_SIENNA_CICHLID:
 	case  CHIP_NAVY_FLOUNDER:
-		adev->family = AMDGPU_FAMILY_NV;
+	case CHIP_VANGOGH:
+		if (adev->asic_type == CHIP_VANGOGH)
+			adev->family = AMDGPU_FAMILY_VGH;
+		else
+			adev->family = AMDGPU_FAMILY_NV;
 
 		r = nv_set_ip_blocks(adev);
 		if (r)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
