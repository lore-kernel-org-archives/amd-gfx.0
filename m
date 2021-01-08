Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F5FC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02B722388B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B722388B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B060A6E8CA;
	Fri,  8 Jan 2021 21:01:56 +0000 (UTC)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68FFF6E8CA
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 21:01:55 +0000 (UTC)
Received: by mail-io1-xd2c.google.com with SMTP id d9so11102939iob.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 13:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9c3+dKMTKGwZPG4Po38oIk2MmvnqYLU5pbMjjuLfIVA=;
 b=hynUjX+Ep1ZQwoR1GyIJ5tzmd74f4VzEv2uJ7dP2G/HRgN6vJyoKBf9dvZyxnxfSCK
 FGm7/2jwFX30HEMZkN/0g1KD8XpaYqf3GfeRisKztpb+ieoMuS2LAOafHSqzbW/651it
 298SlEH1UWx+UQ9FR+Ay6Hf6b6URYJuh4JXzETKly2Zf+Pyhx/fnVAIcm2EDugb5+F71
 cNh5UooYeiIlk30/APAsMm//Wo5w3REsAc7+3TUjtIlbX3ZUIomkZGASbAw05VJUE6/X
 pD3lK4mo5BnyEMDGuIdD2lXYVZLuBxuEuIGGYt2YVQJzvKA5ZgbCfJac/x9JUzph0fRc
 kQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9c3+dKMTKGwZPG4Po38oIk2MmvnqYLU5pbMjjuLfIVA=;
 b=SLpG70pthK1ACnO8rNmFaLLrAdcVApA85HS05kmEZRAWxRb5Ni+83LvUClYSPDWuf2
 /OyiKOHDjlnfBNJDZPX4fwSIUVSlBwYJXb/9XH3Zf+eQUlMeQ4SEX/YfJfxg5n8xOkEx
 20pEoHth3Wq9ZlEYfJ+7Qz8cGCuQlhN4hZAdNzmRY0TWXoA5Gel48S02k1bdh2FrxNqw
 iqe85cxJotHRSiehR565FUJT3dcs48HPhFMpJubvj8UGNOtXMy8v/nHl9cLHRzpkiCcc
 dykRFBfuHHb6Vc1wEsMGp8tCaiq46ImwqQnDiy23PhpgqXvbmhjO2S6fOi3zNE5kxL4y
 mpWw==
X-Gm-Message-State: AOAM53118r6lXyMPvtK7xUv7l7rqPc1d4aU4AAsmc4imfTbNWaR/3IZP
 38zT2JdZ+TJlKTpFe+pu/de8V9tDrsA=
X-Google-Smtp-Source: ABdhPJzickNY9njnUA6GS3RJGpisZ1CvV6L481OsSnINwQVbdHnnD1ov/w9ptEOvxZNn/03KZGjqXA==
X-Received: by 2002:a5d:8405:: with SMTP id i5mr6825372ion.164.1610139714588; 
 Fri, 08 Jan 2021 13:01:54 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.241])
 by smtp.gmail.com with ESMTPSA id z63sm8363240ilk.72.2021.01.08.13.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 13:01:54 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: actually execute the atom command table
 in adjust_display_pll_v2
Date: Fri,  8 Jan 2021 16:01:43 -0500
Message-Id: <20210108210143.1056817-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
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

We should execute the table to see if we need to adjust the pixel clock.
That said, I'm not sure this version of the atom table is actually
in use on any asics supported by amdgpu.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/display/dc/bios/command_table.c   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
index 070459e3e407..41999223903d 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
@@ -1470,6 +1470,30 @@ static enum bp_result adjust_display_pll_v2(
 	params.ucEncodeMode =
 			(uint8_t)bp->cmd_helper->encoder_mode_bp_to_atom(
 					bp_params->signal_type, false);
+
+	if (bp_params->ss_enable == true)
+		params.ucConfig |= DISPPLL_CONFIG_SS_ENABLE;
+
+	if (EXEC_BIOS_CMD_TABLE(AdjustDisplayPll, params)) {
+		/* Convert output pixel clock back 10KHz-->KHz: multiply
+		 * original pixel clock in KHz by ratio
+		 * [output pxlClk/input pxlClk] */
+		uint64_t pixel_clk_10_khz_out =
+				(uint64_t)le16_to_cpu(params.usPixelClock);
+		uint64_t pixel_clk = (uint64_t)bp_params->pixel_clock;
+
+		if (pixel_clock_10KHz_in != 0) {
+			bp_params->adjusted_pixel_clock =
+					div_u64(pixel_clk * pixel_clk_10_khz_out,
+						pixel_clock_10KHz_in);
+		} else {
+			bp_params->adjusted_pixel_clock = 0;
+			BREAK_TO_DEBUGGER();
+		}
+
+		result = BP_RESULT_OK;
+	}
+
 	return result;
 }
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
