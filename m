Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB45C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1155E20727
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVM8g9XO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1155E20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0EF66ECFF;
	Fri, 15 May 2020 18:31:49 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F64A6ECFF
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:31:48 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id p12so2758891qtn.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 11:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W6rV8MrePHIcsthH5cSznVuYDXFlRnPg+E5Z/tif588=;
 b=NVM8g9XO9jAcHtlHPg2CVxCpjuKJdKycKZ6/F6JzVeGMrW7heO/3L/nUBbEdwYvaau
 zVrtu1oWMCMN4dFNytQMfTtfspiN+JgIJZmzJ2XibhrQOeK8ljon6tcR4mTcvKIi1u6M
 qEi4plTPMUqnS69qPfzVcYXQL0b76HSAsC3XMoaZzY2QmS7DW8Byw5U3LygQaKDfvE5B
 hJ40ro9Va3xXkNGxWkO20wQ+vGr2hvIdb72/4+mJtwyNY5TSVNxJ8vDWsIRUFPvbMrkc
 iCPSgESbZKRlpRgOKcjl2qbtEqQJB14KIb0wX28DO84sKDL1g9q2NyrjuPbJ8lwUQDGq
 a8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W6rV8MrePHIcsthH5cSznVuYDXFlRnPg+E5Z/tif588=;
 b=gIgwMObuY3ydmrU34h05alULBD6JuNvwBAQKnNQ/fuuXryqmTOoUoxM0E5fIcI+++s
 HfcjYkmEzyReLtRg9dC6ukN2kIGDUIp/esLtBw3woRI8X8p3+Sm1OKMeeF8G3HDkXPVE
 /YtTqdvYULuv4M3cn2zmf+zHHOs2TdT6it/Gqudh6RxQTGtnhV3oZMqRAj10iH4kY6As
 Ly6OiczBRGirok2g9xz+S3Q3v5k3UkCWeBB1pCDPW6YmAJ5zHptSSuuedmz3AtDS6UeP
 zDYi/u3EB6REkrp1YaVUG4TX0ojnKFT5A7dDbSbES2/zyhg4BK9Lnk+rZEVQdBvS33yl
 joKg==
X-Gm-Message-State: AOAM533iZTLsCah0hjsXWBtrm+67TNThr5dXJICDEHgp2hZBZvVEN2fV
 pV1NW3idwy1W8HmqcJkNLaLjDICr
X-Google-Smtp-Source: ABdhPJysmSgyCvbvooGjheNMELCAAesrFrGDinSZImCQin1Dr+c6wS8X7ftFM1w5eQ6xgWmxpFSfYQ==
X-Received: by 2002:ac8:5482:: with SMTP id h2mr5102695qtq.9.1589567506691;
 Fri, 15 May 2020 11:31:46 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id e28sm2155284qka.125.2020.05.15.11.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 11:31:45 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: move gpu_info parsing after common early init
Date: Fri, 15 May 2020 14:31:34 -0400
Message-Id: <20200515183135.626855-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200515183135.626855-1-alexander.deucher@amd.com>
References: <20200515183135.626855-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We need to get the silicon revision id before we parse
the firmware in order to load the correct gpu info firmware
for raven2 variants.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1103
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bab1be7abdf0..a3a58e9f9e9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1766,10 +1766,6 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	r = amdgpu_device_parse_gpu_info_fw(adev);
-	if (r)
-		return r;
-
 	amdgpu_amdkfd_device_probe(adev);
 
 	if (amdgpu_sriov_vf(adev)) {
@@ -1824,6 +1820,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		}
 		/* get the vbios after the asic_funcs are set up */
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON) {
+			r = amdgpu_device_parse_gpu_info_fw(adev);
+			if (r)
+				return r;
+
 			/* skip vbios handling for new handshake */
 			if (amdgpu_sriov_vf(adev) && adev->virt.req_init_data_ver == 1)
 				continue;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
