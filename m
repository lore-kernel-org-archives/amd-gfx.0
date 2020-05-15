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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D2AC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:31:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 511BE20727
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bN6md5VY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 511BE20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0100E6ECEF;
	Fri, 15 May 2020 18:31:48 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71AD36ECEF
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:31:46 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id r187so692050qkf.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 11:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PmEaW2hYWLq9ULlvL6PWrI/PGzmLpQFC0OB2m3TMy3I=;
 b=bN6md5VYjkMpQ/YbFzpSwc2zz50uoAKTdlKdlXbY2O5miMt68TF3t/vupkJnRBPNHX
 YVEKqwkfINGJ97sBU94zMM0t3UCUIPj3/IERr2igvQ3Vd/g39mrUo3CvdXai06bLfAtS
 DbpJ82vFk9oqYi1qQigTvTbYOKsMiymu5QQWzXSabAbatI33bBari9CIIBmO5XPfhgGu
 FBps+xGiiOK6Qk8IjqFtla2+P4jA6D4cfWRRGsAgOZs1ycnWMsc1g8IghoCZikeoKSez
 /+t/4Sg2YkG9x59YeGf4CUgKsRLGF6Xi0mvZ5n50hI1TEgYc+GNjweHK6QHvAqSCVyMi
 bXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PmEaW2hYWLq9ULlvL6PWrI/PGzmLpQFC0OB2m3TMy3I=;
 b=mD1QMikxeLAJ6hsSs9XNqqKd8o2NJxpO8n1t2+LTLU0KOvc7ysOL6kLI8AZTNDoM90
 xqpzkkwaKWVijSL0xDnayIlNfICdJDeGptNm0YAfJ19LNyjTT+looqxIj+YfP2ECT4eN
 fP4JMLPRNlU4rw49PgYx653hBGCPW9yaFvUW05sfMIMxLH4Rvy/8gbuJkmx/+ouoqaMU
 9UnY7KCdxquPBoVYIYSndbxTcOmvy5MHtiE8s8l0KOX6cz+AdKpT1eRf6JdXy+NRVXmQ
 24CTSNDUX9iF46q2ROPszFLYzAACH3ubuxhvfKXtiWAm11k6XZCPmTmyh9PiCvCrHWJ9
 vEug==
X-Gm-Message-State: AOAM531G0GWQV6yJiMNAuZ3Ey6s1O4cIybSu/7d/9Vtmvmh0c8Au1Kl8
 fBM8WnwG25cwCVugmtfN84iRopNF
X-Google-Smtp-Source: ABdhPJx51gShq0juV+3ahDU3ayf7fpw7cRR/iuSJN1/BlztSu8otdMIoCpRjqYwDgsxxmaG4riSz4g==
X-Received: by 2002:a37:5d3:: with SMTP id 202mr4241929qkf.324.1589567505404; 
 Fri, 15 May 2020 11:31:45 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id e28sm2155284qka.125.2020.05.15.11.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 11:31:44 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: move discovery gfx config fetching
Date: Fri, 15 May 2020 14:31:33 -0400
Message-Id: <20200515183135.626855-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move it into the fw_info function since it's logically part
of the same functionality.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index cc41e8f5ad14..bab1be7abdf0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1617,8 +1617,10 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 			(const struct gpu_info_firmware_v1_0 *)(adev->firmware.gpu_info_fw->data +
 								le32_to_cpu(hdr->header.ucode_array_offset_bytes));
 
-		if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10)
+		if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10) {
+			amdgpu_discovery_get_gfx_info(adev);
 			goto parse_soc_bounding_box;
+		}
 
 		adev->gfx.config.max_shader_engines = le32_to_cpu(gpu_info_fw->gc_num_se);
 		adev->gfx.config.max_cu_per_sh = le32_to_cpu(gpu_info_fw->gc_num_cu_per_sh);
@@ -1768,9 +1770,6 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10)
-		amdgpu_discovery_get_gfx_info(adev);
-
 	amdgpu_amdkfd_device_probe(adev);
 
 	if (amdgpu_sriov_vf(adev)) {
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
