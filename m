Return-Path: <SRS0=ju5j=AG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF8EC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 22:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6409820672
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 22:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYU3yZiu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6409820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D3256EC1E;
	Thu, 25 Jun 2020 22:05:06 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A0F46E878
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2020 22:05:03 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id f18so7045908qkh.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2020 15:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+zMh/F7SVSdEKneflasz+Yejq0fditu42SkLo2DFRV0=;
 b=EYU3yZiucIcOZBiH5NCzMYbkjNecgVa1XTiMdrL6M3DYlxzMWbn9mUw9N30EqffUHk
 X5q4U2ZpM8moZV9qXvIUOHxxSWd872mWggY0T0cUc5zMZ8/uVZS3GrELItuYRQYRubcl
 z7lVWwBRDSw2HzaYCJGWW7EYc3Z8n/jLDHlZ4WF3xFHqRtWcZAkfKDq52AbKuhAI71Ad
 JOkzMXLUIjyVvjB2d8YtP0dNpn2djxGP03xPOWHcWm+SQypbMrPIEuHe/1cD2Om1GCCN
 nfxJltLLETJk+MpZ9EBMP3FWDOCKm531o/8s4iSMgvuNIgq24iaZrgy6go1iYp2WMzVm
 sAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+zMh/F7SVSdEKneflasz+Yejq0fditu42SkLo2DFRV0=;
 b=DhUsccPiawxbX6LhB4JYuLPXCSriAupCzvfGqSylvGdxTzoxYgHeJ97DRZNse0k6lq
 3SUTdVfX++M7llYkg8rxxzkrPkMXMCdXt8EmtaCrwYDpOZkbXwlKZllQ8BCdsH7ow87i
 BtrXe8eTp4VdbBoa4f3FDc8bE22rOTxBvamoh0DA2KiawlP0mLLXzXtUxXvy4T9NYSnk
 PFGY4De/Z7SljxHvTItNILRHT0XmaBLCnM8PBKyCVnv35IYoVt4coqxxlFyF15mQFIkM
 X+uGk2XL1bBjYXpI3EzOiy/yf5EwusNU3lrfqmWnr3pkKh+c93oLS9v7lMB6zqPsOBBh
 mM6g==
X-Gm-Message-State: AOAM533ldeUlz9OM0j1EbM3+ntE+2wM4Zbc4oG5RURDdD+aWpNTS2hMo
 u4gPWlES1QFQEJGIV2LWov6hS5ni
X-Google-Smtp-Source: ABdhPJyKlmDvgS/Q9og7baoCCGBV4OEJCHdxbyO+0tlac9m/B+jj+pVPPW29CPwjVQCplX9BtSc1fg==
X-Received: by 2002:a37:6643:: with SMTP id a64mr10911885qkc.397.1593122702249; 
 Thu, 25 Jun 2020 15:05:02 -0700 (PDT)
Received: from localhost.localdomain ([71.219.51.205])
 by smtp.gmail.com with ESMTPSA id x197sm6670885qka.74.2020.06.25.15.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 15:05:01 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu/atomfirmware: update to latest
 integratedinfotable
Date: Thu, 25 Jun 2020 18:04:52 -0400
Message-Id: <20200625220453.1367084-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200625220453.1367084-1-alexander.deucher@amd.com>
References: <20200625220453.1367084-1-alexander.deucher@amd.com>
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

Used for renoir.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 78 ++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index b852248b2da8..c2544c81dfb2 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -1116,6 +1116,35 @@ struct atom_14nm_combphy_tmds_vs_set
   uint8_t margin_deemph_lane0__deemph_sel_val;         
 };
 
+struct atom_DCN_dpphy_dvihdmi_tuningset
+{
+  uint32_t max_symclk_in10khz;
+  uint8_t  encoder_mode;           //atom_encode_mode_def, =2: DVI, =3: HDMI mode
+  uint8_t  phy_sel;                //bit vector of phy, bit0= phya, bit1=phyb, ....bit5 = phyf 
+  uint8_t  tx_eq_main;             // map to RDPCSTX_PHY_FUSE0/1/2/3[5:0](EQ_MAIN)
+  uint8_t  tx_eq_pre;              // map to RDPCSTX_PHY_FUSE0/1/2/3[11:6](EQ_PRE)
+  uint8_t  tx_eq_post;             // map to RDPCSTX_PHY_FUSE0/1/2/3[17:12](EQ_POST)
+  uint8_t  reserved1;
+  uint8_t  tx_vboost_lvl;          // tx_vboost_lvl, map to RDPCSTX_PHY_CNTL0.RDPCS_PHY_TX_VBOOST_LVL
+  uint8_t  reserved2;
+};
+
+struct atom_DCN_dpphy_dp_setting{
+  uint8_t dp_vs_pemph_level;       //enum of atom_dp_vs_preemph_def
+  uint8_t tx_eq_main;             // map to RDPCSTX_PHY_FUSE0/1/2/3[5:0](EQ_MAIN)
+  uint8_t tx_eq_pre;              // map to RDPCSTX_PHY_FUSE0/1/2/3[11:6](EQ_PRE)
+  uint8_t tx_eq_post;             // map to RDPCSTX_PHY_FUSE0/1/2/3[17:12](EQ_POST)
+  uint8_t tx_vboost_lvl;          // tx_vboost_lvl, map to RDPCSTX_PHY_CNTL0.RDPCS_PHY_TX_VBOOST_LVL
+};
+
+struct atom_DCN_dpphy_dp_tuningset{
+  uint8_t phy_sel;                 // bit vector of phy, bit0= phya, bit1=phyb, ....bit5 = phyf 
+  uint8_t version;
+  uint16_t table_size;             // size of atom_14nm_dpphy_dp_setting
+  uint16_t reserved;
+  struct atom_DCN_dpphy_dp_setting dptunings[10];
+};
+
 struct atom_i2c_reg_info {
   uint8_t ucI2cRegIndex;
   uint8_t ucI2cRegVal;
@@ -1178,6 +1207,55 @@ struct atom_integrated_system_info_v1_11
   uint32_t  reserved[66];
 };
 
+struct atom_integrated_system_info_v1_12
+{
+  struct  atom_common_table_header  table_header;
+  uint32_t  vbios_misc;                       //enum of atom_system_vbiosmisc_def
+  uint32_t  gpucapinfo;                       //enum of atom_system_gpucapinf_def   
+  uint32_t  system_config;                    
+  uint32_t  cpucapinfo;
+  uint16_t  gpuclk_ss_percentage;             //unit of 0.001%,   1000 mean 1% 
+  uint16_t  gpuclk_ss_type;
+  uint16_t  lvds_ss_percentage;               //unit of 0.001%,   1000 mean 1%
+  uint16_t  lvds_ss_rate_10hz;
+  uint16_t  hdmi_ss_percentage;               //unit of 0.001%,   1000 mean 1%
+  uint16_t  hdmi_ss_rate_10hz;
+  uint16_t  dvi_ss_percentage;                //unit of 0.001%,   1000 mean 1%
+  uint16_t  dvi_ss_rate_10hz;
+  uint16_t  dpphy_override;                   // bit vector, enum of atom_sysinfo_dpphy_override_def
+  uint16_t  lvds_misc;                        // enum of atom_sys_info_lvds_misc_def
+  uint16_t  backlight_pwm_hz;                 // pwm frequency in hz
+  uint8_t   memorytype;                       // enum of atom_dmi_t17_mem_type_def, APU memory type indication.
+  uint8_t   umachannelnumber;                 // number of memory channels
+  uint8_t   pwr_on_digon_to_de;               // all pwr sequence numbers below are in uint of 4ms //
+  uint8_t   pwr_on_de_to_vary_bl;
+  uint8_t   pwr_down_vary_bloff_to_de;
+  uint8_t   pwr_down_de_to_digoff;
+  uint8_t   pwr_off_delay;
+  uint8_t   pwr_on_vary_bl_to_blon;
+  uint8_t   pwr_down_bloff_to_vary_bloff;
+  uint8_t   min_allowed_bl_level;
+  uint8_t   htc_hyst_limit;
+  uint8_t   htc_tmp_limit;
+  uint8_t   reserved1;
+  uint8_t   reserved2;
+  struct atom_external_display_connection_info extdispconninfo;
+  struct atom_DCN_dpphy_dvihdmi_tuningset  TMDS_tuningset;
+  struct atom_DCN_dpphy_dvihdmi_tuningset  hdmiCLK5_tuningset;
+  struct atom_DCN_dpphy_dvihdmi_tuningset  hdmiCLK8_tuningset;
+  struct atom_DCN_dpphy_dp_tuningset rbr_tuningset;        // rbr 1.62G dp tuning set
+  struct atom_DCN_dpphy_dp_tuningset hbr3_tuningset;   // HBR3 dp tuning set  
+  struct atom_camera_data  camera_info;
+  struct atom_hdmi_retimer_redriver_set dp0_retimer_set;   //for DP0
+  struct atom_hdmi_retimer_redriver_set dp1_retimer_set;   //for DP1
+  struct atom_hdmi_retimer_redriver_set dp2_retimer_set;   //for DP2
+  struct atom_hdmi_retimer_redriver_set dp3_retimer_set;   //for DP3
+  struct atom_DCN_dpphy_dp_tuningset hbr_tuningset;    //hbr 2.7G dp tuning set
+  struct atom_DCN_dpphy_dp_tuningset hbr2_tuningset;   //hbr2 5.4G dp turnig set
+  struct atom_DCN_dpphy_dp_tuningset edp_tunings;       //edp tuning set  
+  struct atom_DCN_dpphy_dvihdmi_tuningset  hdmiCLK6_tuningset;
+  uint32_t  reserved[63];
+};
 
 // system_config
 enum atom_system_vbiosmisc_def{
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
