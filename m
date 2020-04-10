Return-Path: <SRS0=F+/f=52=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E91C2BA2B
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 12:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37B8720769
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 12:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SE9i7u1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B8720769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03A6A6ECD7;
	Fri, 10 Apr 2020 12:49:07 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FA876ECD7
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2020 12:49:05 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id y3so1937259qky.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2020 05:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=62i642G32AoepjE2d/7vJclJfahRwn3gyW7q/317duY=;
 b=SE9i7u1JEHdZt31Soizhwq6nxdyKJcAwnqW/j6vJ+FsWUEOhRkLYhsVSbn8VMlMzKg
 Rt2MbvA4bd7JQkKMl+rSVFET6ukGDisGghUGapjdIR3XL32oj7Y6XtvuDuekD9CkPT5h
 5ild65qhI0cPDOKqXyDYRoyKJTfNgCx2fS1ShYA344BhnEj/cLOpvSo2qJxmMMXvS7Xf
 UnhEjqEyZX74xseaehMKqTj0/w5QkVRaBqBn8Lqd8WmB14vvBDx6ZdE04S0kypVp3gPr
 SD4vc3fDs4OOlwx63xbsdKj740zKEkNW8OpmABk/sukkLeqkGR84TY1wTJv4RmdUAkfq
 1bFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=62i642G32AoepjE2d/7vJclJfahRwn3gyW7q/317duY=;
 b=XgKBHpTEmaBR+PkFKZpMqhp22EIqKs1VISKwaLaUJEoENR0a4SvOzk7sG3GPF2w5kJ
 ftooimIJF/opTdeP6RXuwX//fquDh6RV421uA27YtUNgd7MNyZvzj2YsoydM5WnFqwaG
 WVukENIMP1CTCpUKYfDIpHHcHFIoNA/Oh7zPhmFerEq3s2h8kBexudXy9hfb3QMrCSpc
 J2MjfdMSMm15Pqx2Mxdn/xihnYVEwc/jAXNmFLdxXCFLvlJdpuQL+fl0VoRwNk81sqHR
 rS7Plz8392ZnTh0C5GeAXmTTLGmQpPlLbEbl1V+lJbVgpsYMfrBgWcxn5FxWBeyjbHjA
 FdSg==
X-Gm-Message-State: AGi0Puau3hE34SICmy40f45IfAulzCQV+L3ud4Z+FNdcfA6MN03oi+lu
 7gNPNpF96NW3PUfePU858T/wYT3j
X-Google-Smtp-Source: APiQypILoRci371qbXxMloouvUBf8Rzu3d9/P9IQZBbh1Ysa9Y+NlyjJMaAailZ1dDWukGOqb88ZYQ==
X-Received: by 2002:a05:620a:1676:: with SMTP id
 d22mr3900076qko.217.1586522944313; 
 Fri, 10 Apr 2020 05:49:04 -0700 (PDT)
Received: from localhost.localdomain ([71.219.40.23])
 by smtp.gmail.com with ESMTPSA id i18sm1446807qtp.8.2020.04.10.05.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2020 05:49:03 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/powerplay: get SMC FW size to a flexible way
Date: Fri, 10 Apr 2020 08:46:44 -0400
Message-Id: <20200410124644.1489253-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.2
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
 Evan Quan <evan.quan@amd.com>, Kenneth Feng <kenneth.feng@amd.com>,
 Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Get SMC fw size before backdoor loading instead of giving an
certain value, as it may different for different ASIC.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h | 1 -
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 4 +++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 674e426ed59b..10ad10b906bb 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -37,7 +37,6 @@
 #define MP0_SRAM			0x03900000
 #define MP1_Public			0x03b00000
 #define MP1_SRAM			0x03c00004
-#define MP1_SMC_SIZE		0x40000
 
 /* address block */
 #define smnMP1_FIRMWARE_FLAGS		0x3010024
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 655ba4fb05dc..205611b9d552 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -201,13 +201,15 @@ int smu_v11_0_load_microcode(struct smu_context *smu)
 	const struct smc_firmware_header_v1_0 *hdr;
 	uint32_t addr_start = MP1_SRAM;
 	uint32_t i;
+	uint32_t smc_fw_size;
 	uint32_t mp1_fw_flags;
 
 	hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
 	src = (const uint32_t *)(adev->pm.fw->data +
 		le32_to_cpu(hdr->header.ucode_array_offset_bytes));
+	smc_fw_size = hdr->header.ucode_size_bytes;
 
-	for (i = 1; i < MP1_SMC_SIZE/4 - 1; i++) {
+	for (i = 1; i < smc_fw_size/4 - 1; i++) {
 		WREG32_PCIE(addr_start, src[i]);
 		addr_start += 4;
 	}
-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
