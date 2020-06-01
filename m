Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1432C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 687082073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0n3yyZz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687082073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 130816E2F0;
	Mon,  1 Jun 2020 18:21:19 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4C946E2F0
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:21:17 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id c185so10005388qke.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MCSJFeebQsfd3Al8qtTc+uwGBWk2f0VJhcqJ60kTZq8=;
 b=A0n3yyZzTx+JFAWo/e7QpOCw8uCab1Qib+XgIrWERrR/J7fUuz2DXM410/P+MRRGcZ
 AT+m0hY8OrLDBXvnmu970X4lz/119f4JG7ieL0Mu6AP5IbxHK5m9488C0SFt27Gc6iCO
 7GiaUalT4uvXRRaFuc2ScDwCsUlqLfF3e1Fj6GrIDciGvwoA/6O5a/Fs/0yuJJonGIxX
 5IhwDztcn7M1cmYk5wUA8KEvDoWJWPV7FB8EIzyUd8wrWaUobqPAT3uGVRZWvvEFRei5
 XM2IZ2NgMl5FuKlV9PyHyEKWglzORLXfVjhLCQnpjDaTiWpt8509kJK6yKZrNIS246qf
 K7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MCSJFeebQsfd3Al8qtTc+uwGBWk2f0VJhcqJ60kTZq8=;
 b=Ugf2pn2xuAjZQqFBPaiehbkOEXNaJfaIG2AU+xbwDyZ3Xd7H5D4Ff0k3NmrZm5WvdO
 cIjTU+d0HSCHiC3ovEDdFNZvzACc4Ogyc6c/setFzmjb32e8ECDBfYzSvl0tUAAGAgeI
 DRXwxfFCAGxr4hsXK8elIa8htZaifmRuC7ZF8800NIrg8V3ipgBtssy3XE6y11IkOY9g
 TKSVU+SXWQF+vqGuMNkSlIKp3XGCIPX663PNheMFhJsbLJIbvtu6E2NDWnjMNaNqdw7V
 UxvS0lN9hBN879L492WK0tFpLdsBneFYyAr9udbclCEGmcNfs8UsbdifrTdwSOndHIDl
 ImUg==
X-Gm-Message-State: AOAM531+KI9Bx+aIJVVkiXr5xpQBV1NKT39HRptiKtIumhg5pF5dwd7W
 dbDGcBYYfjR6nIc9Qc8YG2N4e90x
X-Google-Smtp-Source: ABdhPJxzfve6FxprbSYHnfj4Tsb9gh09MyedACv20J9ICDZoyrDTFxQ8wBj8vuPIP4uwpmnMulYL2g==
X-Received: by 2002:a05:620a:8d4:: with SMTP id
 z20mr19920030qkz.441.1591035676885; 
 Mon, 01 Jun 2020 11:21:16 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:21:16 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 099/207] drm/amdgpu: add firmware_info v3_4 structure for
 Sienna_Cichlid
Date: Mon,  1 Jun 2020 14:19:06 -0400
Message-Id: <20200601182054.1267858-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

firmware_info v3_4 strucure will be used by kernel driver
to query various parameters set by VBIOS for Sienna_Cichlid

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 2c3c73f1e6ee..f7e98855cac7 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -562,6 +562,42 @@ struct atom_firmware_info_v3_3
   uint32_t reserved2[2];
 };
 
+struct atom_firmware_info_v3_4 {
+	struct atom_common_table_header table_header;
+	uint32_t firmware_revision;
+	uint32_t bootup_sclk_in10khz;
+	uint32_t bootup_mclk_in10khz;
+	uint32_t firmware_capability;             // enum atombios_firmware_capability
+	uint32_t main_call_parser_entry;          /* direct address of main parser call in VBIOS binary. */
+	uint32_t bios_scratch_reg_startaddr;      // 1st bios scratch register dword address
+	uint16_t bootup_vddc_mv;
+	uint16_t bootup_vddci_mv;
+	uint16_t bootup_mvddc_mv;
+	uint16_t bootup_vddgfx_mv;
+	uint8_t  mem_module_id;
+	uint8_t  coolingsolution_id;              /*0: Air cooling; 1: Liquid cooling ... */
+	uint8_t  reserved1[2];
+	uint32_t mc_baseaddr_high;
+	uint32_t mc_baseaddr_low;
+	uint8_t  board_i2c_feature_id;            // enum of atom_board_i2c_feature_id_def
+	uint8_t  board_i2c_feature_gpio_id;       // i2c id find in gpio_lut data table gpio_id
+	uint8_t  board_i2c_feature_slave_addr;
+	uint8_t  reserved3;
+	uint16_t bootup_mvddq_mv;
+	uint16_t bootup_mvpp_mv;
+	uint32_t zfbstartaddrin16mb;
+	uint32_t pplib_pptable_id;                // if pplib_pptable_id!=0, pplib get powerplay table inside driver instead of from VBIOS
+	uint32_t mvdd_ratio;                      // mvdd_raio = (real mvdd in power rail)*1000/(mvdd_output_from_svi2)
+	uint16_t hw_bootup_vddgfx_mv;             // hw default vddgfx voltage level decide by board strap
+	uint16_t hw_bootup_vddc_mv;               // hw default vddc voltage level decide by board strap
+	uint16_t hw_bootup_mvddc_mv;              // hw default mvddc voltage level decide by board strap
+	uint16_t hw_bootup_vddci_mv;              // hw default vddci voltage level decide by board strap
+	uint32_t maco_pwrlimit_mw;                // bomaco mode power limit in unit of m-watt
+	uint32_t usb_pwrlimit_mw;                 // power limit when USB is enable in unit of m-watt
+	uint32_t fw_reserved_size_in_kb;          // VBIOS reserved extra fw size in unit of kb.
+	uint32_t reserved[5];
+};
+
 /* 
   ***************************************************************************
     Data Table lcd_info  structure
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
