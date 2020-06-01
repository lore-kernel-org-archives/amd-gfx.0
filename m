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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3443EC433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE952073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Af0IchUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE952073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C083F6E2E8;
	Mon,  1 Jun 2020 18:21:13 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A263B6E2E8
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:21:12 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id c14so8975521qka.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ae99j0YGVa2q/SM95E1jL1RDf+Q/EQoSuYowrNA0erc=;
 b=Af0IchUyikJ1Plb/3mQAw1RnaQ5t5oM7PGz+sWKl10zXYhXZD2J/S1psmGb0ohAbIA
 5Q3wR+VpGYQEizV83ugP8sw1DU5JhX9+Ljrsuo8fsAMmiaFBhEjYgLbC3yWmH6Ee6SsB
 FRDXCWvV4tEHRSi1hDyYY9gYpRW7QkBTIa9Jw7FtOjGxJentJQB1Op7kzZ0l3l0DBlh2
 3cov37RiVSJ1CLGOJHIUueo0aRh6nsK+rDsMyBcGGghMCkRX3sW1T0+brLg6DeG91GxS
 sK74bHkDIvftqWZKv4L8N/vlES/Nd7hd3pMVCcs3+HQQPBhUW5jmNE6+/CUGkhz2Ouke
 XAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ae99j0YGVa2q/SM95E1jL1RDf+Q/EQoSuYowrNA0erc=;
 b=FkS713ynUL2IQtNJZh792/l3KmWufZRU9zFIrvk/3UDhjY/L6JCPtLEAfD1kRWUzug
 uFPmLAvd9vdXOtWdoV78QWfcg2XGkkn5AIU+POSeL3z+nwrzTDewqB8y7zZt2m+lYaGx
 fL4WrmACKVeLJVd2nfjGKr2hIoo3I8a8x1/kVAKFCJPHIR0Y716JFhZOdFb1rLxhW4KF
 vKInVFlwulsxh49D21zMTtKcKvxpbDPa9EwzBvNHr+Yoj3M4S7ODX+0dGsuTJkUcy2hz
 nDk+86lc/Dn1SHLhRSxBsYYdC5/6yU2YMQcbQqpgsXJFLa6kO8bb2tjSmbuGoBmamaEU
 lrCA==
X-Gm-Message-State: AOAM5314XIvUkNP4u5m1PAZEZ3/pdfgxWk7RNcnxcsbMFlakDsJ/xIhs
 vEp68VjPrSEkM+/qUWo4Qezc4cNh
X-Google-Smtp-Source: ABdhPJwUbh9iNGvv8SIDYFFmL9row7RKeLMQM8ajv0SsGmrWIil53UyBO1sZOB5n6QK8leOX4WnJsg==
X-Received: by 2002:a37:6851:: with SMTP id d78mr20954857qkc.86.1591035671543; 
 Mon, 01 Jun 2020 11:21:11 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:21:11 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 095/207] drm/amdgpu: add vram_info v2_5 in atomfirmware header
Date: Mon,  1 Jun 2020 14:19:02 -0400
Message-Id: <20200601182054.1267858-6-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

vram_info v2_5 was introduced to support sienna_cichlid

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 124 +++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index b36ea8340afa..2c3c73f1e6ee 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -2313,6 +2313,130 @@ struct atom_vram_info_header_v2_4 {
   struct   atom_vram_module_v10  vram_module[16];        // just for allocation, real number of blocks is in ucNumOfVRAMModule;
 };
 
+struct atom_vram_module_v11 {
+	// Design Specific Values
+	uint32_t  memory_size;                   // Total memory size in unit of MB for CONFIG_MEMSIZE zeros
+	uint32_t  channel_enable;                // bit vector, each bit indicate specific channel enable or not
+	uint16_t  mem_voltage;                   // mem_voltage
+	uint16_t  vram_module_size;              // Size of atom_vram_module_v9
+	uint8_t   ext_memory_id;                 // Current memory module ID
+	uint8_t   memory_type;                   // enum of atom_dgpu_vram_type
+	uint8_t   channel_num;                   // Number of mem. channels supported in this module
+	uint8_t   channel_width;                 // CHANNEL_16BIT/CHANNEL_32BIT/CHANNEL_64BIT
+	uint8_t   density;                       // _8Mx32, _16Mx32, _16Mx16, _32Mx16
+	uint8_t   tunningset_id;                 // MC phy registers set per.
+	uint16_t  reserved[4];                   // reserved
+	uint8_t   vender_rev_id;                 // [7:4] Revision, [3:0] Vendor code
+	uint8_t   refreshrate;			 // [1:0]=RefreshFactor (00=8ms, 01=16ms, 10=32ms,11=64ms)
+	uint8_t   vram_flags;			 // bit0= bankgroup enable
+	uint8_t   vram_rsd2;			 // reserved
+	uint16_t  gddr6_mr10;                    // gddr6 mode register10 value
+	uint16_t  gddr6_mr0;                     // gddr6 mode register0 value
+	uint16_t  gddr6_mr1;                     // gddr6 mode register1 value
+	uint16_t  gddr6_mr2;                     // gddr6 mode register2 value
+	uint16_t  gddr6_mr4;                     // gddr6 mode register4 value
+	uint16_t  gddr6_mr7;                     // gddr6 mode register7 value
+	uint16_t  gddr6_mr8;                     // gddr6 mode register8 value
+	char    dram_pnstring[40];               // part number end with '0'.
+};
+
+struct atom_gddr6_ac_timing_v2_5 {
+	uint32_t  u32umc_id_access;
+	uint8_t  RL;
+	uint8_t  WL;
+	uint8_t  tRAS;
+	uint8_t  tRC;
+
+	uint16_t  tREFI;
+	uint8_t  tRFC;
+	uint8_t  tRFCpb;
+
+	uint8_t  tRREFD;
+	uint8_t  tRCDRD;
+	uint8_t  tRCDWR;
+	uint8_t  tRP;
+
+	uint8_t  tRRDS;
+	uint8_t  tRRDL;
+	uint8_t  tWR;
+	uint8_t  tWTRS;
+
+	uint8_t  tWTRL;
+	uint8_t  tFAW;
+	uint8_t  tCCDS;
+	uint8_t  tCCDL;
+
+	uint8_t  tCRCRL;
+	uint8_t  tCRCWL;
+	uint8_t  tCKE;
+	uint8_t  tCKSRE;
+
+	uint8_t  tCKSRX;
+	uint8_t  tRTPS;
+	uint8_t  tRTPL;
+	uint8_t  tMRD;
+
+	uint8_t  tMOD;
+	uint8_t  tXS;
+	uint8_t  tXHP;
+	uint8_t  tXSMRS;
+
+	uint32_t  tXSH;
+
+	uint8_t  tPD;
+	uint8_t  tXP;
+	uint8_t  tCPDED;
+	uint8_t  tACTPDE;
+
+	uint8_t  tPREPDE;
+	uint8_t  tREFPDE;
+	uint8_t  tMRSPDEN;
+	uint8_t  tRDSRE;
+
+	uint8_t  tWRSRE;
+	uint8_t  tPPD;
+	uint8_t  tCCDMW;
+	uint8_t  tWTRTR;
+
+	uint8_t  tLTLTR;
+	uint8_t  tREFTR;
+	uint8_t  VNDR;
+	uint8_t  reserved[9];
+};
+
+struct atom_gddr6_bit_byte_remap {
+	uint32_t dphy_byteremap;    //mmUMC_DPHY_ByteRemap
+	uint32_t dphy_bitremap0;    //mmUMC_DPHY_BitRemap0
+	uint32_t dphy_bitremap1;    //mmUMC_DPHY_BitRemap1
+	uint32_t dphy_bitremap2;    //mmUMC_DPHY_BitRemap2
+	uint32_t aphy_bitremap0;    //mmUMC_APHY_BitRemap0
+	uint32_t aphy_bitremap1;    //mmUMC_APHY_BitRemap1
+	uint32_t phy_dram;          //mmUMC_PHY_DRAM
+};
+
+struct atom_gddr6_dram_data_remap {
+	uint32_t table_size;
+	uint8_t phyintf_ck_inverted[8];     //UMC_PHY_PHYINTF_CNTL.INV_CK
+	struct atom_gddr6_bit_byte_remap bit_byte_remap[16];
+};
+
+struct atom_vram_info_header_v2_5 {
+	struct   atom_common_table_header table_header;
+	uint16_t mem_adjust_tbloffset;                         // offset of atom_umc_init_reg_block structure for memory vendor specific UMC adjust settings
+	uint16_t gddr6_ac_timing_offset;                     // offset of atom_gddr6_ac_timing_v2_5 structure for memory clock specific UMC settings
+	uint16_t mc_adjust_pertile_tbloffset;                  // offset of atom_umc_init_reg_block structure for Per Byte Offset Preset Settings
+	uint16_t mc_phyinit_tbloffset;                         // offset of atom_umc_init_reg_block structure for MC phy init set
+	uint16_t dram_data_remap_tbloffset;                    // offset of atom_gddr6_dram_data_remap array to indicate DRAM data lane to GPU mapping
+	uint16_t reserved;                                     // offset of reserved
+	uint16_t post_ucode_init_offset;                       // offset of atom_umc_init_reg_block structure for MC phy init after MC uCode complete umc init
+	uint16_t strobe_mode_patch_tbloffset;                  // offset of atom_umc_init_reg_block structure for Strobe Mode memory clock specific UMC settings
+	uint8_t  vram_module_num;                              // indicate number of VRAM module
+	uint8_t  umcip_min_ver;
+	uint8_t  umcip_max_ver;
+	uint8_t  mc_phy_tile_num;                              // indicate the MCD tile number which use in DramDataRemapTbl and usMcAdjustPerTileTblOffset
+	struct   atom_vram_module_v11  vram_module[16];        // just for allocation, real number of blocks is in ucNumOfVRAMModule;
+};
+
 /* 
   ***************************************************************************
     Data Table voltageobject_info  structure
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
