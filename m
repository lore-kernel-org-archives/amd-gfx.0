Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A52C56201
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 16:21:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39FCD2067C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 16:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjNKj9rf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FCD2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D12EB6EA15;
	Wed, 25 Nov 2020 16:21:41 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0741A6EA15
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 16:21:41 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id n132so5241211qke.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 08:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=O2S+QVRNbNhKlLFakm4SYj4qqznoM6gpGAreHxDcz10=;
 b=VjNKj9rfeG+k8eiNJCjJica0qvQkkRQfL3Z/TTIhYTetajb0ARKe7ShK9yWsUrLxzU
 4NSpMc40U0mz5rG3lv2pn/3cBu6VbvsRgItWbGI4IovgDa6SzJElxEEqm1w4AkCPXlpM
 qK6kXTwGWcYWBKOP7zCXGBGa9qgQprGMgEAIpBFFzXJg+3OC9cplEcZ56R0CPBkFVUo2
 TQofN31QjlQWIJPfuTdCGQBN02I0SutqrhOIUhCZDv0vWztuTasloP+ad2CmsmpRCgN1
 QT+XKYlxv05c3MML3wb5ZrE2kfDbWNlNYuVdksCAVMdxAH50vmB4Tm1+GaMM3xni9XA+
 ZJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=O2S+QVRNbNhKlLFakm4SYj4qqznoM6gpGAreHxDcz10=;
 b=iLA71UDCp8fscrug6tHGayV7yffPhNcJ8amFgsoBS3hj+TDc5rFsQtXQGVsBRtFeRs
 9q8t6SmryC8C+gjLLnOPSvB7cnlGvOhp0e2QDK+vX3kzaAUuvW3d9DEWCG4WiTeDmN1I
 a1QNFB+FOzFk5XpweUipPjlBt3F8cRIAJODsMlARK9h3HUyoOjO56Z8KQXDo3bfZNR8d
 L0lYK1wTBAx5t/I1xlJy5enOzIfegDU5xN6uXcKqe6jd+IriGRKQzaNLXT1VQPW7qWru
 RX1oYzKGpTZ5IOPU/1Oq45i9x7/UHlVwufVxTKm20gdCFU8rsqsLAYkb9qzsEaBkrDEn
 icuA==
X-Gm-Message-State: AOAM530AsMZUNnowGcQFpugnH9a1voEHPNxEiIn3dyk6vYin79VDvZ9n
 IfxB1f3Xmv0+XViVFwbHZNEM2kCN8nk=
X-Google-Smtp-Source: ABdhPJwXFU/QVdKMSK/hoSdV8Qn+oLUylRg70QGHT/RajPf2hn9UJG/ZD/iIAHR/6UknJyNkLZxxbA==
X-Received: by 2002:ae9:ed81:: with SMTP id c123mr4040964qkg.349.1606321299920; 
 Wed, 25 Nov 2020 08:21:39 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id u24sm3093367qtb.33.2020.11.25.08.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2020 08:21:38 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: add mode2 reset support for vangogh
Date: Wed, 25 Nov 2020 11:21:29 -0500
Message-Id: <20201125162132.237264-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GPU reset is handled via SMU similar to previous APUs.

Acked-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 1c1af7483dfe..3d4d27a304e9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -780,6 +780,11 @@ static int vangogh_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
 	return 0;
 }
 
+static int vangogh_mode2_reset(struct smu_context *smu)
+{
+	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset, SMU_RESET_MODE_2, NULL);
+}
+
 static const struct pptable_funcs vangogh_ppt_funcs = {
 
 	.check_fw_status = smu_v11_0_check_fw_status,
@@ -808,6 +813,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.print_clk_levels = vangogh_print_fine_grain_clk,
 	.set_default_dpm_table = vangogh_set_default_dpm_tables,
 	.set_fine_grain_gfx_freq_parameters = vangogh_set_fine_grain_gfx_freq_parameters,
+	.mode2_reset = vangogh_mode2_reset,
 };
 
 void vangogh_set_ppt_funcs(struct smu_context *smu)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
