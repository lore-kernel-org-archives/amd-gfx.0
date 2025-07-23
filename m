Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655A7C83F1A
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 15:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB1C210E802;
	Wed, 23 Jul 2025 15:58:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IZC0BBhB";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71DF210E7FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 15:58:25 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4560cdf235cso34771125e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 08:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753286304; x=1753891104; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EOWmoy+vx4d5AEqMkezujuonNasxAkIlbyPh5LiSr9A=;
 b=IZC0BBhBLoy1qlzJFYI7mxR4Ou/TK5bSRUFV9ufh/Nt/7ODh01/Az2BsUoUtKGNujJ
 B1ZvkZRsMC3hRsxOR66DumLp+WH00hwD73NmMI9ftbkpSIa0FgZ2T7lvSTdaQjFpGoQB
 2TsjPsdCCHBRleIeIjJSk+plxEWs+CQ3FiFqVsgZVQOHmHS+yRFTOC5glH/vH/bujnYG
 Q88tF4PDjSGP4CKf1jtET+hbpN8app7KPF8KjKfVmXw9pqTmuWQxmkEBfD7RY01PcVJM
 Sgj4nd0hiEaned664KszBs0v9i5qSpymnPTOSU+xEgd5f5Kf3f4j0T5oKQkd0KYbT0o7
 emyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286304; x=1753891104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EOWmoy+vx4d5AEqMkezujuonNasxAkIlbyPh5LiSr9A=;
 b=bEplpBl+IFCDaz1Y7XXIuAbQb9+RyIz2Jb8w0ns7WXfrZfiXtY0T81s01KsGd0KmyT
 nSbRR9QlLAoeoDm27Aay9ElCZxbvr01JH4Wta8KlY8Qnb1sB3IsS9zIrNEJblfHIspoj
 GvS4Xc3Wr8XI1sSbI5sGGvJQwymycBU2gkCQ2IpXtqgr2XZD9p00z8G3q8Qzrm5E7cEV
 b0/SuytZJEgfoKnmtwbZ64AiabqFAajN5VmABVvHpbK56aTA5kgIvTHp7+dvPUwyQqmM
 2QjXYq86rrNuDI9gs7gHog8f27yzwPZXnWFYgmJPWZlJWmUnrGxhiw6yIIopaDGYdf9N
 BWuA==
X-Gm-Message-State: AOJu0YwpplS5CQLYIE18ZDdg6Vo/8QS1QNHye2o97k1ItsHbWi8+v2bh
 PQbgYVbGPkbhycQFFnebvu7dymIVe189TkVPb5/wd8zYje0ovoRTn/hb3KH3NA==
X-Gm-Gg: ASbGnctIdhWANWO6fSHJ1CyO5h1/8yOt74T91xJdlNxjPN3g1g/rqqVb/D0vve3uRfC
 tHRORajMYpcF+QvmNqacpKw4+8D3jeiyn/6uop52CiZIO4UToEdd4ezXQHl0lEE7uJujys82oJM
 Ixc8S1Vq75u3wc6Ldl0vApc3cnw+kwL9sHnWFhTW4f481q3Sr4GKOiuhfllofwTP0faEtnwylYZ
 dUJQaR5Skq7L9DdhoKvCkf71APTObuELV2dKUBxEPcahwFwnnfMGMCN1EM27ABbuXGOo1+Zk0UI
 lORZJycTYpTHuu9WecNqF2gE/u2jmkBB6fGQKhRVxSgf3q6HQ5ASWIz5QTz1GWkQysyu9N8CkjC
 Wk89osaHatn1fjUXwITlk7+jHNiZOA9Ksy+1za6Ej0xBygzpxkI076VMfGA+WTNRJ+uBSqHaC6i
 lNNdwL37tlHMH7Jz1vqsq60pfZEA==
X-Google-Smtp-Source: AGHT+IFq9veeQaMBooNT2SnzF06G6m5bsbPeR1cUDAeMpZokUcdyDneiqiSrOngtrWEX2ol4hxeuIA==
X-Received: by 2002:a05:600c:35d4:b0:456:2379:c238 with SMTP id
 5b1f17b1804b1-4586a00c13fmr27754485e9.17.1753286303586; 
 Wed, 23 Jul 2025 08:58:23 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4D24D8FC008443E005DD6C3C62.dsl.pool.telekom.hu.
 [2001:4c4d:24d8:fc00:8443:e005:dd6c:3c62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2bf99sm16710468f8f.32.2025.07.23.08.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 08:58:23 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 04/20] drm/amd/display: Hook up DAC to
 bios_parser_encoder_control
Date: Wed, 23 Jul 2025 17:57:57 +0200
Message-ID: <20250723155813.9101-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723155813.9101-1-timur.kristof@gmail.com>
References: <20250723155813.9101-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The BIOS parser already supports calling the DAC1EncoderControl
function from the VBIOS, but it was not exposed anywhere.
This commit enables the codebase to use encoder_control()
when the encoder engine is one of the DACs.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/dc/bios/bios_parser.c    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 67f08495b7e6..6914dd6944b7 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -745,6 +745,22 @@ static enum bp_result bios_parser_encoder_control(
 {
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
 
+	if (cntl->engine_id == ENGINE_ID_DACA) {
+		if (!bp->cmd_tbl.dac1_encoder_control)
+			return BP_RESULT_FAILURE;
+
+		return bp->cmd_tbl.dac1_encoder_control(
+			bp, cntl->action == ENCODER_CONTROL_ENABLE,
+			cntl->pixel_clock, ATOM_DAC1_PS2);
+	} else if (cntl->engine_id == ENGINE_ID_DACB) {
+		if (!bp->cmd_tbl.dac2_encoder_control)
+			return BP_RESULT_FAILURE;
+
+		return bp->cmd_tbl.dac2_encoder_control(
+			bp, cntl->action == ENCODER_CONTROL_ENABLE,
+			cntl->pixel_clock, ATOM_DAC1_PS2);
+	}
+
 	if (!bp->cmd_tbl.dig_encoder_control)
 		return BP_RESULT_FAILURE;
 
-- 
2.50.1

