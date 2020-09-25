Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D567C4727F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3C932399A
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJEt9+85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C932399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F374E6ED6C;
	Fri, 25 Sep 2020 20:11:24 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94A9D6ED5C
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:12 +0000 (UTC)
Received: by mail-qt1-x829.google.com with SMTP id n10so3093738qtv.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5K9ZKBs39iPDbx0opuWaMW/4iVJzB7B0v9irOsB9ea8=;
 b=uJEt9+85tVUcWE1v/J2wft6wFTolBPpNFBAgi+GyfG/VxNcIFUKYCZ9rKzJU9Q/GMK
 hNtFkzMgx/i1ouOO9X2clBGfr4GESIkHTRk8GBtVJIbCiQIB2GEbrnh3MrUAe8EXgG+x
 QgUfahjEMMLL30mt0dz2NgxBD/S4a2WGaOhJhOc8gpHBs4DlXErhQ2WW4FzAsWHAH7ai
 Y1XIppsqjs6Iq2d2GsJBv86ypofSfbHYlvrZk4OpfKJFmMAy8EZknRGOnzsEFY4quNT8
 w3Ol5ukJ7PqrXLx0RKCH8HlPVtRsPDQnU948kwEg21Igb9r3GFferyRMmQfuD6XPj/Bc
 eqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5K9ZKBs39iPDbx0opuWaMW/4iVJzB7B0v9irOsB9ea8=;
 b=IlwY+OmtzofweHidsTZ88BVub74Qg4ry3NS6TnPKhA0r3j46UdBDoqF6mQ1ZeDsPCJ
 jCoGvhhOm3gfDZaIlP7wit1NOvV2KIy8DOwnWXOQUbE8TujM7W4pIhkp79SuztBna+00
 zJL/V1KoDVGZi67y0eyVe1+6KtaxIo/5KHl9FGd3Z6PMER//vdfgf60a2qid0f76G5Bf
 1EpuKGDV6vsX1WNgRSlqmhJmBat9qKQ6M21E9TlDzEVjEGi1c/encOtHHEu54fkkWqoh
 KRFWNZDMNhUreMe27m6C/vOtlX9W0dM/stJEPyMwFRI9twku313wbPoZYO5GUS5wZSeD
 J6kw==
X-Gm-Message-State: AOAM531/eKnS7MpOAexKeVzOwdfgKH550xLpi/fp+N+qjeWzm8iV9saC
 ObOysz6E28eRewl3ZBdoROXn0SDkh/o=
X-Google-Smtp-Source: ABdhPJwlShmxgJx2a1awK6qNJJZ1gNNs000ktB29k9R8zzgCFqgoK/eg3o3uWSe99LiRilvnpt+jJA==
X-Received: by 2002:ac8:7208:: with SMTP id a8mr1517349qtp.22.1601064671533;
 Fri, 25 Sep 2020 13:11:11 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:11 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/45] drm/amdgpu/atomfirmware: Add edp and integrated info
 v2.1 tables
Date: Fri, 25 Sep 2020 16:09:56 -0400
Message-Id: <20200925201029.1738724-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200925201029.1738724-1-alexander.deucher@amd.com>
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
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
 Harry Wentland <harry.wentland@amd.com>, Roman Li <Roman.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <Roman.Li@amd.com>

Required for vangogh.

Signed-off-by: Roman Li <Roman.Li@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 62 +++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 0799a9ca0440..4eb578b1baef 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -1304,11 +1304,71 @@ struct atom_integrated_system_info_v1_12
   struct atom_hdmi_retimer_redriver_set dp3_retimer_set;   //for DP3
   struct atom_DCN_dpphy_dp_tuningset hbr_tuningset;    //hbr 2.7G dp tuning set
   struct atom_DCN_dpphy_dp_tuningset hbr2_tuningset;   //hbr2 5.4G dp turnig set
-  struct atom_DCN_dpphy_dp_tuningset edp_tunings;       //edp tuning set  
+  struct atom_DCN_dpphy_dp_tuningset edp_tunings;       //edp tuning set
   struct atom_DCN_dpphy_dvihdmi_tuningset  hdmiCLK6_tuningset;
   uint32_t  reserved[63];
 };
 
+
+#if defined(CONFIG_DRM_AMD_DC_DCN3_01)
+
+struct edp_info_table
+{
+        uint16_t edp_backlight_pwm_hz;
+        uint16_t edp_ss_percentage;
+        uint16_t edp_ss_rate_10hz;
+        uint16_t reserved1;
+        uint32_t reserved2;
+        uint8_t  edp_pwr_on_off_delay;
+        uint8_t  edp_pwr_on_vary_bl_to_blon;
+        uint8_t  edp_pwr_down_bloff_to_vary_bloff;
+        uint8_t  edp_panel_bpc;
+        uint8_t  edp_bootup_bl_level;
+        uint8_t  reserved3[3];
+        uint32_t reserved4[3];
+};
+
+struct atom_integrated_system_info_v2_1
+{
+        struct  atom_common_table_header  table_header;
+        uint32_t  vbios_misc;                       //enum of atom_system_vbiosmisc_def
+        uint32_t  gpucapinfo;                       //enum of atom_system_gpucapinf_def
+        uint32_t  system_config;
+        uint32_t  cpucapinfo;
+        uint16_t  gpuclk_ss_percentage;             //unit of 0.001%,   1000 mean 1%
+        uint16_t  gpuclk_ss_type;
+        uint16_t  dpphy_override;                   // bit vector, enum of atom_sysinfo_dpphy_override_def
+        uint8_t   memorytype;                       // enum of atom_dmi_t17_mem_type_def, APU memory type indication.
+        uint8_t   umachannelnumber;                 // number of memory channels
+        uint8_t   htc_hyst_limit;
+        uint8_t   htc_tmp_limit;
+        uint8_t   reserved1;
+        uint8_t   reserved2;
+        struct edp_info_table edp1_info;
+        struct edp_info_table edp2_info;
+        uint32_t  reserved3[8];
+        struct atom_external_display_connection_info extdispconninfo;
+        struct atom_DCN_dpphy_dvihdmi_tuningset  TMDS_tuningset;
+        struct atom_DCN_dpphy_dvihdmi_tuningset  hdmiCLK5_tuningset; //add clk6
+        struct atom_DCN_dpphy_dvihdmi_tuningset  hdmiCLK6_tuningset;
+        struct atom_DCN_dpphy_dvihdmi_tuningset  hdmiCLK8_tuningset;
+        uint32_t reserved4[6];//reserve 2*sizeof(atom_DCN_dpphy_dvihdmi_tuningset)
+        struct atom_DCN_dpphy_dp_tuningset rbr_tuningset;        // rbr 1.62G dp tuning set
+        struct atom_DCN_dpphy_dp_tuningset hbr_tuningset;    //hbr 2.7G dp tuning set
+        struct atom_DCN_dpphy_dp_tuningset hbr2_tuningset;   //hbr2 5.4G dp turnig set
+        struct atom_DCN_dpphy_dp_tuningset hbr3_tuningset;   // HBR3 dp tuning set
+        struct atom_DCN_dpphy_dp_tuningset edp_tunings;       //edp tuning set
+        uint32_t reserved5[28];//reserve 2*sizeof(atom_DCN_dpphy_dp_tuningset)
+        struct atom_hdmi_retimer_redriver_set dp0_retimer_set;   //for DP0
+        struct atom_hdmi_retimer_redriver_set dp1_retimer_set;   //for DP1
+        struct atom_hdmi_retimer_redriver_set dp2_retimer_set;   //for DP2
+        struct atom_hdmi_retimer_redriver_set dp3_retimer_set;   //for DP3
+        uint32_t reserved6[30];// reserve size of(atom_camera_data) for camera_info
+        uint32_t reserved7[32];
+
+};
+#endif
+
 // system_config
 enum atom_system_vbiosmisc_def{
   INTEGRATED_SYSTEM_INFO__GET_EDID_CALLBACK_FUNC_SUPPORT = 0x01,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
