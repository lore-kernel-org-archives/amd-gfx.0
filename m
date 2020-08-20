Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC01C433E3
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 21:05:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 720E720748
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 21:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgx3cA2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720E720748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0343E6EA67;
	Thu, 20 Aug 2020 21:05:18 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 677B96EA67
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 21:05:16 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id x6so1605499qvr.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 14:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ca/AkDCC7a9Vi3rt04Vmd5UTqLmIKzQG5LHrugwDIXo=;
 b=sgx3cA2sWvaJuI4ATAQSjGRM9imR1eJuhzr4l9JDGRIi5AYMutcVscPs8o1SKtKoas
 Frq1VOPyQqbRsKIl+asY00Mop95NcAGGZWksbQRRDltmx9TCjKGop1KlTrhpjZCrptQz
 x2Brx1xceLNUSS0flsJjs60QEpwylZB3GWdLFu1fnc9TZ4AhM3yu3Zsu8N0zAcF6MEZX
 5oBcl7xXFH/DcACeyK4KAQ37KgT89euhrVxQGlrdHxN2tuYyaKuLl3L/p5iE7ZT7iUnD
 NhHHDYQG50Zh6AL+urPv2PgolWqhJfJN4wra7IDthLfBKcpOpHknEPHEMDkip78obuHx
 4xZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ca/AkDCC7a9Vi3rt04Vmd5UTqLmIKzQG5LHrugwDIXo=;
 b=tks/qhA95L/C9/Jfkf8w9tIINm4/LTMzjWJjNEBlze/Iw6hUBjasRixUI85iDRWg+Y
 lSnwv/CDCEBSjYLCKkT4hpRiWcfmnlZXS7aru4JQn9MUj9WermNU7OFTuFCMyOCgaK+p
 79YM4X59Y6D3bZXVcAQoAYh02ewe/EYj6Q7FuV2QDNkN1eFRkQdzPcSId5Ic8mYqPGbY
 yOyHmDoELveY50AWXSS9HLjUgN2raQw8Ufu6JjdKdzJalNj/qdwX5XqLG/pcMtwC7Ris
 b5TVHRcZsIu+Mba+xXPxAsZKtjPDeCbcF4L3aUh3H5/qocfiGy5hMVeN+NIEDvL920oD
 fpHA==
X-Gm-Message-State: AOAM530ULjgEJHcY90muSNttb7r22GbxVP8fTZqXZjXVMFRYzMubulgY
 m365mTrOr364Sl2oGfuXOZqTz8gtrt8=
X-Google-Smtp-Source: ABdhPJzP5DWPZrh0hp89t9r1GzBL0q8OntDr6BKsuDA1wYIGJ4yrcQkZaD09MoeFAvXRAwPfhtckyQ==
X-Received: by 2002:a05:6214:11a8:: with SMTP id
 u8mr771059qvv.88.1597957515309; 
 Thu, 20 Aug 2020 14:05:15 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h23sm3161747qkl.38.2020.08.20.14.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 14:05:14 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: enable HDP clock gatting
Date: Thu, 20 Aug 2020 17:05:04 -0400
Message-Id: <20200820210504.1311186-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200820210504.1311186-1-alexander.deucher@amd.com>
References: <20200820210504.1311186-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 "Prike.Liang" <Prike.Liang@amd.com>, Evan Quan <evan.quan@amd.com>,
 Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Prike.Liang" <Prike.Liang@amd.com>

Enabe HDP SD/DS clock gatting in Renoir series.

Signed-off-by: Prike.Liang <Prike.Liang@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 3cd98c144bc6..3c3a7adad024 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1452,7 +1452,8 @@ static void soc15_update_hdp_light_sleep(struct amdgpu_device *adev, bool enable
 	uint32_t def, data;
 
 	if (adev->asic_type == CHIP_VEGA20 ||
-		adev->asic_type == CHIP_ARCTURUS) {
+		adev->asic_type == CHIP_ARCTURUS ||
+		adev->asic_type == CHIP_RENOIR) {
 		def = data = RREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_CTRL));
 
 		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS))
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
