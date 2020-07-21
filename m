Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21567C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 16:52:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2E9F2073A
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 16:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmVcK5r0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E9F2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81C6B89C93;
	Tue, 21 Jul 2020 16:52:07 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3460089C93
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 16:52:06 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id g13so16663320qtv.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 09:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SGjgfi9fDS/QXvfqV5H0Wo7r5/4jqgMtbujDkPQs2bM=;
 b=JmVcK5r0CLRqEJYewNsTYawNWswNfB/GJDiMk1Xb7Z7iRrducv8Rnm4729sPPA+kDe
 Lyr/hP7BWl0K0RhwkiHigt0oInRQEdkcBl2i+2FlYBISZfZXMJWP6EleMuyywKtnUBgM
 LASVAur8Asm57qW7fFGrv1O0B6xIJsGRInXOzdiAPzJ8NwHho2bQEmjIdBecOl7ta388
 RCH3AuiSwNslzBKSKOo/Vf6OQHYzN6nq5F7PDpZC3R2d3crLg2n/TMJoVFdfWTN4fNr3
 pLYMNKhWb22+bwhuxXdaXgS5CfAuFFlIv4ouJAyN/WUkpdrFoAoT6hurkq4SSxWeOM+o
 V4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SGjgfi9fDS/QXvfqV5H0Wo7r5/4jqgMtbujDkPQs2bM=;
 b=CK81qMrXXQfFBnTvjEH7exC+hTvTjYazChqVrAEp9NfMecY7g+UvrHVlAuHsEftsqE
 KNV2ToJGv/WEfH+gGSRXyKDZqZKm2AttIw6Z8zJpRu5+KctEEpONPkJuiXB1H2krCEG6
 L8k/D2K6k2T7ZY8Jf6floXrjJp4hSn7Ot6fpqdHIpm/uSNTBMNZ5RQcEtmKLn7dABd7v
 +XU2G79ZMISBOb4UIuoo03GM10FE3ReQ8MrOceGn/pSp5jJRbbwa2+4nlMAiDsw8kYMK
 aNIhKCu39cqR4j/8+aKMExGS4XJUpIs2lhVaizkTWl+/+N9V2RCf89tQM52E6vVVJxPN
 xsSg==
X-Gm-Message-State: AOAM531MIS+7WD36qygd6KcHqCQQD1mAPn4fvlpqQhoznCAACQOFpzJu
 EhBqMBvZgcrIcZAuIqfz921ys8uR
X-Google-Smtp-Source: ABdhPJx+MfbOfe5oR5S80J8W3enrmqvdZycrniKeC3kW6Ux32Poxc5LJLpiEbik1zdgZZ5vGh5+lKg==
X-Received: by 2002:ac8:6644:: with SMTP id j4mr30850344qtp.295.1595350325071; 
 Tue, 21 Jul 2020 09:52:05 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id a25sm23486330qtk.40.2020.07.21.09.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 09:52:04 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/powerplay: add some documentation about memory
 clock
Date: Tue, 21 Jul 2020 12:51:56 -0400
Message-Id: <20200721165156.296200-1-alexander.deucher@amd.com>
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

We expose the actual memory controller clock rate in Linux,
not the effective memory clock of the DRAMs.  To translate
it, it follows the following formula:

Clock conversion (Mhz):
HBM: effective_memory_clock = memory_controller_clock * 1
G5:  effective_memory_clock = memory_controller_clock * 1
G6:  effective_memory_clock = memory_controller_clock * 2

DRAM data rate (MT/s):
HBM: effective_memory_clock * 2 = data_rate
G5:  effective_memory_clock * 4 = data_rate
G6:  effective_memory_clock * 8 = data_rate

Bandwidth (MB/s):
data_rate * vram_bit_width / 8 = memory_bandwidth

Some examples:
G5 on RX460:
memory_controller_clock = 1750 Mhz
effective_memory_clock = 1750 Mhz * 1 = 1750 Mhz
data rate = 1750 * 4 = 7000 MT/s
memory_bandwidth = 7000 * 128 bits / 8 = 112000 MB/s

G6 on RX5600:
memory_controller_clock = 900 Mhz
effective_memory_clock = 900 Mhz * 2 = 1800 Mhz
data rate = 1800 * 8 = 14400 MT/s
memory_bandwidth = 14400 * 192 bits / 8 = 345600 MB/s

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 46 ++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 20f39aa04fb9..dd05751f6b35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -694,6 +694,52 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
  * in each power level within a power state.  The pp_od_clk_voltage is used for
  * this.
  *
+ * Note that the actual memory controller clock rate are exposed, not
+ * the effective memory clock of the DRAMs. To translate it, use the
+ * following formula:
+ *
+ * Clock conversion (Mhz):
+ *
+ * HBM: effective_memory_clock = memory_controller_clock * 1
+ *
+ * G5: effective_memory_clock = memory_controller_clock * 1
+ *
+ * G6: effective_memory_clock = memory_controller_clock * 2
+ *
+ * DRAM data rate (MT/s):
+ *
+ * HBM: effective_memory_clock * 2 = data_rate
+ *
+ * G5: effective_memory_clock * 4 = data_rate
+ *
+ * G6: effective_memory_clock * 8 = data_rate
+ *
+ * Bandwidth (MB/s):
+ *
+ * data_rate * vram_bit_width / 8 = memory_bandwidth
+ *
+ * Some examples:
+ *
+ * G5 on RX460:
+ *
+ * memory_controller_clock = 1750 Mhz
+ *
+ * effective_memory_clock = 1750 Mhz * 1 = 1750 Mhz
+ *
+ * data rate = 1750 * 4 = 7000 MT/s
+ *
+ * memory_bandwidth = 7000 * 128 bits / 8 = 112000 MB/s
+ *
+ * G6 on RX5700:
+ *
+ * memory_controller_clock = 875 Mhz
+ *
+ * effective_memory_clock = 875 Mhz * 2 = 1750 Mhz
+ *
+ * data rate = 1750 * 8 = 14000 MT/s
+ *
+ * memory_bandwidth = 14000 * 256 bits / 8 = 448000 MB/s
+ *
  * < For Vega10 and previous ASICs >
  *
  * Reading the file will display:
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
