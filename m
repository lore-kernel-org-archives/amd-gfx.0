Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979DECAC5B8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 18:02:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BF0F10EABA;
	Fri, 26 Sep 2025 18:02:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D6lodiIX";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD23210EABA
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 18:02:36 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-27ee41e0798so23302225ad.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758909756; x=1759514556; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L63zjG9QVh5B4LzTp5wOo0LLIPeq57EtaJDrYi0zS5U=;
 b=D6lodiIXtrr0b8wV8g51mrX/19yXHuYIRBSprcrboU15UpVeAkat9qcgX8yOrHXVD8
 Z9joRnlKtNbwYopdAlwkEQJVKsXJIciOCj6t8B+n6MPdPQyWkxLmUFwaSXs9vcKYsB1u
 V346ppXe2hdoUs/9AYOpYR+hkAyLGpJvonySOuzV29OhXZodT9ZK0TbtmXuFtNIML783
 d/8BKe2oJeeqFauOXT436M/4jrrIFfKA1Apa+5oqhwk0kljg8KucGqWX2gxj2OLLMST6
 HvVMbup3XPEDhDU5RdNhrP/2nGoCBZTyEglu/psou8NFDDg4quxIXKyBolHy908J7pLT
 Zb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758909756; x=1759514556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L63zjG9QVh5B4LzTp5wOo0LLIPeq57EtaJDrYi0zS5U=;
 b=C1NgMO7qOX4oWvb43sNwCxLzQxJRGBMoU7Rhrz1PzjLC1EpPmk3X8jWQvS9bRAN8Tc
 qhUOGfNg7qeqN53t3LdIMoLPDUeikE2zFwmmmgJZ7rqE9WjqT676W6y34gudoF36FWT9
 W1RR2+TFtJwyJcTB7AUoshVMKvLeebkv/nqSo2659U/a3pP4OVgORkvr82T7M47bQjQC
 fnFm2ry6XRYTBnW+vRlCcaYlE3sDMovv4vzv/DSIprQdr98Ud0Xx7wFws3lb/px26J2F
 uJp+sEwfChKaSE5zsHPIf6lHUYMigK1xUoX87LNKeb5YQNg4fIjm5MzZYmo6Qrq9N+ix
 HVaQ==
X-Gm-Message-State: AOJu0Yxv2g8BfIXtCOQOiP3DXoCjdpzyhaCo25tXoNbiem4R6wVFxx5T
 OfELqMuKkz//SwNwsavnHyJRhzSzctoa47mQH7LjI8U5aeVx7r5COwI6xI4W3A==
X-Gm-Gg: ASbGncvsT6eQv7Kb8HIUCu/Adnp3u3yPPHDFuQuUM5s8lGL7DQJ/B6IlV3OVDqZ4FT4
 TxEjhJK0cFAqi6IzTEZm3PxqmhiaZyXa6wMpfBO85Kpkbbh8GK8od+IHtiTn7EVN/xiwIUane46
 vR7kQL9Y1IiMtBETlxv/z3CjnB+Ym15HZltu8aFvp3aIRYSc36cMGgT5CnqjPIUtY78X+tf7YOi
 IeosAEvE0UiCquqYrn0DdJ+kfDv0OcEBWLlch3gMh7KZ7U7d0mgUeUbdFLHqP7VJ/htdWHAUGkF
 GPXev6VWuMcnh6cs7kQ3FgcUQ9eHy1EvTnXLfEKvQqBVLcKXNN8D1XtxPXF0w49AJw4zj9Wlf6M
 oHB6wa4R1Rai1ehS6hRcwRjylVwhpc5Ix7+ypv2Mf7DmyLQ/z0BR8sed25T03Cv2Bn7zOXDY325
 z4EcRbc6JTjqN2T94Jlpg=
X-Google-Smtp-Source: AGHT+IHbP6Jefb3+zJzR7T+OlirhgGRi+Js5TNu36bMu0xrmHMimr6xWzv+K5G4JuIpbnQpTE7/znA==
X-Received: by 2002:a17:903:78e:b0:269:9ae5:26af with SMTP id
 d9443c01a7336-27ed49d2c58mr57638235ad.13.1758909756197; 
 Fri, 26 Sep 2025 11:02:36 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27f1d2ef8c5sm22186835ad.151.2025.09.26.11.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:02:35 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 04/23] drm/amd/display: Hook up DAC to
 bios_parser_encoder_control
Date: Fri, 26 Sep 2025 20:01:44 +0200
Message-ID: <20250926180203.16690-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926180203.16690-1-timur.kristof@gmail.com>
References: <20250926180203.16690-1-timur.kristof@gmail.com>
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

Enable the codebase to use encoder_control()
when the encoder engine is one of the DACs.

The BIOS parser already supports calling the DAC1EncoderControl
function from the VBIOS, but it was not exposed anywhere.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/dc/bios/bios_parser.c    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 154fd2c18e88..318be0bb5549 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -742,6 +742,22 @@ static enum bp_result bios_parser_encoder_control(
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
2.51.0

