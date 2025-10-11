Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618A8CCD18F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 07:35:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E26F510E3E5;
	Mon, 13 Oct 2025 07:35:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XyOL7CU3";
	dkim-atps=neutral
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62D3810E308
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Oct 2025 13:48:18 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-63a10267219so5001269a12.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Oct 2025 06:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760190497; x=1760795297; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pjqs9wgfMLcWCndiSjwHua4WA/TvCS8N/LIbzNyweH4=;
 b=XyOL7CU3/WCr4HV7ImXmgYLbzFYL9V5HkW92ylOgX6DhwNW9zWfnG11F3lHiZGg5M4
 yG934aIOFxRu7wdPBvN2CwvqIQIL8fGfCqhoh76oCfaNC0w0dVClhPWZNp2CbNJYdnTS
 ANygNUKpM3zARCesIFGgj+vWD2Rqwp4aui+h3WzDoUkPlIX89it9RZRPTBSvTY3JNhZI
 nf1YbykKgwz2OzBLFeCkxeLrRTx9uHYBC8nABBhcu5Zgk3tPNrxJPZRqVFgToM+VG1sJ
 jpluVy5FpMvJohU468lXxOPbTwN8ig9SYzJ/RWSz70Cfe0AkPzFAqKZcrurnsKfRUEwd
 mdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760190497; x=1760795297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pjqs9wgfMLcWCndiSjwHua4WA/TvCS8N/LIbzNyweH4=;
 b=QwgspTeLrXna/JcJ0yfEhsa/S81IISYF/w1JZwB/b5gvRtFS3vuFkLZ2YdMQcN1B1S
 S9bdjuX4Q3QZaM5FXSWD27dx5RuNmUQCrowzUlkkkhvpNAvh82WiilYF6YwoGqMe8QXA
 RFQfS05/fLGiDAnkLEKf7RC5nCwhBm7F74CBCGSAolntuJnNG5Zm2DPnVUs90Nwv/WbS
 aO0Gn1RKzfu2cgPd3Ww3W9+TxeuzDiMYH9C+y/5spl5hJ3BoIhgwjxxdkKagHHjy47Wr
 IkebTc8x34k/rVgdphum6q9l8+brtPDZyufaNLB0wR4bfiKaEHmFOu9O0rRHHO14Xf2p
 ybsg==
X-Gm-Message-State: AOJu0Yyqc79tVMUK1kbmrVfDTf/eyjR5oyj2AKajIRZfUM1bMBINCEkE
 PqqD6b1Qd5WxQ+Lu/dY/HABQ3aqIoSkt2oMeEsey+xTPaKLZrEeSQv7BMpN9nw==
X-Gm-Gg: ASbGncuNh80EaYhhB1Nloqz+e+S2bjOqzvvT04ejULkMQOUbOj0Bdrn9tG7raVwZeKd
 JPTqoyl/Q+LO1xyWD4D4H4iQy8qNk102ssj7rct+k+nMrPbI97ZeUEsN2V+3DPqz9MwfyCpcPu5
 BOB0A63ugBOLrwV2yIjunVuaqxg4BizKRmorSJlsSnRAn7GGOw8AXOps+6S4xF+LQwK9GNOY6Ny
 jC6B1AD6AMxcOaobh42vFYr+46uc7mqHxi/1g0bh8bs8tkZ0veHpM5h06yhUmTeFUFSQy5V+vhi
 QKhcufIctGmERAsJXJf2alLOeNjs4sfqkOxq/1UZpNoBIjPvVuecAcYXOCIqNHkNM2DCjV5m94P
 pcahejl2mglC7q53MdpuMk7ZZfwMs1rgFTDEc4Ij2UVlmk5FfmSrUxk0z6KHFiFEv95NG+oxDSy
 cI9UXEWO764ngyuwYta6M=
X-Google-Smtp-Source: AGHT+IH14oHAw0CalUuYIULI5L7U7H1/KBeQfoHEvrB9wZdb15C9h5IeZt9kELIaqkXoEVuE3vIm8A==
X-Received: by 2002:a05:6402:13d0:b0:639:f648:1093 with SMTP id
 4fb4d7f45d1cf-639f6481364mr10994493a12.4.1760190496172; 
 Sat, 11 Oct 2025 06:48:16 -0700 (PDT)
Received: from hyron-desktop (host-176-36-64-50.b024.la.net.ua. [176.36.64.50])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a52b0f358sm4788016a12.10.2025.10.11.06.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 06:48:15 -0700 (PDT)
From: Ilya Zlobintsev <ilya.zlobintsev@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Ilya Zlobintsev <ilya.zlobintsev@gmail.com>
Subject: [PATCH 1/2] drm/amd/pm: Avoid writing nulls into `pp_od_clk_voltage`
 (SMU11)
Date: Sat, 11 Oct 2025 16:47:15 +0300
Message-ID: <20251011134716.83214-2-ilya.zlobintsev@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251011134716.83214-1-ilya.zlobintsev@gmail.com>
References: <20251011134716.83214-1-ilya.zlobintsev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Oct 2025 07:35:45 +0000
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

Signed-off-by: Ilya Zlobintsev <ilya.zlobintsev@gmail.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 31c2c0386b1f..774283ac7827 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1281,7 +1281,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	struct smu_11_0_7_overdrive_table *od_settings = smu->od_settings;
 	OverDriveTable_t *od_table =
 		(OverDriveTable_t *)table_context->overdrive_table;
-	int i, size = 0, ret = 0;
+	int i, size = 0, ret = 0, start_offset = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t freq_values[3] = {0};
 	uint32_t mark_index = 0;
@@ -1289,6 +1289,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	uint32_t min_value, max_value;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
+	start_offset = size;
 
 	switch (clk_type) {
 	case SMU_GFXCLK:
@@ -1434,7 +1435,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	}
 
 print_clk_out:
-	return size;
+	return size - start_offset;
 }
 
 static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
-- 
2.51.0

