Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12A7C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 22:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 694D461279
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 22:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 694D461279
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E49D06E0E1;
	Wed, 17 Nov 2021 22:33:45 +0000 (UTC)
Received: from ubuntu2004-NV21-clean.amd.com (unknown [165.204.54.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C84AB6E0E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 22:33:44 +0000 (UTC)
Received: by ubuntu2004-NV21-clean.amd.com (Postfix, from userid 0)
 id 626BC161C31; Wed, 17 Nov 2021 17:33:42 -0500 (EST)
From: Surbhi Kakarya <surbhi.kakarya@amd.com>
To: amd-gfx@lists.freedesktop.org, Bokun.Zhang@amd.com, HaiJun.Chang@amd.com,
 Monk.Liu@amd.com, Alexander.Deucher@amd.com
Subject: [PATCH] drm/amd/pm: add new fields for Navi21.
Date: Wed, 17 Nov 2021 17:33:39 -0500
Message-Id: <20211117223339.29822-1-surbhi.kakarya@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Surbhi Kakarya <Surbhi.Kakarya@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fill voltage fields in metrics table. This patch is
based on an existing patch I9e15971919b88e54fe5fbee5b784293eaf18025c.

Signed-off-by: Surbhi Kakarya <Surbhi.Kakarya@amd.com>
Change-Id: I701110d78a85c092f5dda167a52350cc6dda7557
---
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 3b1bf270ebc6..97d18e764665 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3619,6 +3619,16 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->energy_accumulator =
 		use_metrics_v2 ? metrics_v2->EnergyAccumulator : metrics->EnergyAccumulator;
 
+	if (metrics->CurrGfxVoltageOffset)
+		gpu_metrics->voltage_gfx =
+			(155000 - 625 * metrics->CurrGfxVoltageOffset) / 100;
+	if (metrics->CurrMemVidOffset)
+		gpu_metrics->voltage_mem =
+			(155000 - 625 * metrics->CurrMemVidOffset) / 100;
+	if (metrics->CurrSocVoltageOffset)
+		gpu_metrics->voltage_soc =
+			(155000 - 625 * metrics->CurrSocVoltageOffset) / 100;
+
 	average_gfx_activity = use_metrics_v2 ? metrics_v2->AverageGfxActivity : metrics->AverageGfxActivity;
 	if (average_gfx_activity <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
 		gpu_metrics->average_gfxclk_frequency =
-- 
2.25.1

