Return-Path: <SRS0=LN+i=D3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24975C4363A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 20:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8962722247
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 20:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWM+akb3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8962722247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C99E06E0EC;
	Tue, 20 Oct 2020 20:26:29 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8FF16E0D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2020 20:26:28 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id b11so1576292qvr.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2020 13:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0h88WxcdMgOGarBvNlacv0ZJfEeminu1q3JapFwla48=;
 b=NWM+akb3HOduFox3VWCyi+DBXcqRG27ugmQ0HzVL7omVw6J62Wn9Aj7qBgrnMJwHGw
 8Q4CuwVPK8uqUUxxTuARGGXTStl06qj5kJmrHyEWjBOQOwQgJxav9PNZqWlgbKEU3AEG
 MPrmyjJcXPk0HvCxpiAx87fuBrVBYHbPaixF1GwYBk4erWGRBkTlPSFfNsV6aZmQPMQb
 pWInEwoSnLGkfH5YoC6k9iF10O95aISHpcvW1LgFr9jTdtOVi7Ws7/Mijaujv6chIcgO
 +/8JKlgPBEZRNZfisucxpF33Nb/y9c86WPY0ixe7TWHYhunvlTYxsVNrY0AuhD2L/p7c
 bn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0h88WxcdMgOGarBvNlacv0ZJfEeminu1q3JapFwla48=;
 b=hdWIQ4IsGjaJ75DDbW+oeDATn2S2jna0loBEjU5EXlbp5yTtY62TcjAkF/BWfeAFaD
 Udoi8LQJ7SCn45KL2e/bXX7bs0XOlfqnTnCAc4EYyHDxGQpTp1Ro+GuaMUmkwoGsggak
 Ak2vqXrn+D3XsI3WgAq54Q2PoreTgTv4lC2RDbs5XtY/2CqAxjSKSTmFT9nRUkSKoJBj
 /HV289X44BjXPqUJ8cJDuEKH+QgjCeHU4F+deXp5BXXJFXwqZAUyqLfSc52U/RslGMRz
 lzuHV2O03yO9G6m67SPaQUIAYQwc5pvrj+2Ix/b1UFGhQcO5HVslQO3W9zEhNTwRrNwA
 ZoKg==
X-Gm-Message-State: AOAM5329vJa7j33MHGLaECNIxkjhR2SVfh/gOLoZNHPoXImYl9NhKdgB
 8mV62sDOXXGLNjGQBf+aisBK+2IBXq0=
X-Google-Smtp-Source: ABdhPJxmQsc56RLD4jX5OZ4wpuO+mFUiUxHS0ELvnBZUATrOxVCfYwU44/B8l1NKqE1I3ugDvNoEjQ==
X-Received: by 2002:a0c:b5c7:: with SMTP id o7mr5110213qvf.1.1603225587500;
 Tue, 20 Oct 2020 13:26:27 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id e39sm1366909qtk.32.2020.10.20.13.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 13:26:26 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: add GC 10.3 NOALLOC registers
Date: Tue, 20 Oct 2020 16:26:15 -0400
Message-Id: <20201020202617.2465215-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This adds the NOALLOC registers.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../include/asic_reg/gc/gc_10_3_0_default.h   |  1 +
 .../include/asic_reg/gc/gc_10_3_0_offset.h    |  2 ++
 .../include/asic_reg/gc/gc_10_3_0_sh_mask.h   | 33 +++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_default.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_default.h
index e245e912535e..21d2f7d1debc 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_default.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_default.h
@@ -1859,6 +1859,7 @@
 #define mmGCMC_SHARED_VIRT_RESET_REQ2_DEFAULT                                    0x00000000
 #define mmGCMC_VM_XGMI_LFB_CNTL_DEFAULT                                          0x00000000
 #define mmGCMC_VM_XGMI_LFB_SIZE_DEFAULT                                          0x00000000
+#define mmGCMC_VM_FB_NOALLOC_CNTL_DEFAULT                                        0x00000000
 #define mmGCUTCL2_HARVEST_BYPASS_GROUPS_DEFAULT                                  0x00000000
 
 
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
index 66a4151fa676..0102487a2c5f 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
@@ -3661,6 +3661,8 @@
 #define mmGCMC_VM_XGMI_LFB_CNTL_BASE_IDX                                                               0
 #define mmGCMC_VM_XGMI_LFB_SIZE                                                                        0x16f8
 #define mmGCMC_VM_XGMI_LFB_SIZE_BASE_IDX                                                               0
+#define mmGCMC_VM_FB_NOALLOC_CNTL                                                                      0x16f9
+#define mmGCMC_VM_FB_NOALLOC_CNTL_BASE_IDX                                                             0
 #define mmGCUTCL2_HARVEST_BYPASS_GROUPS                                                                0x16fa
 #define mmGCUTCL2_HARVEST_BYPASS_GROUPS_BASE_IDX                                                       0
 
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
index aed799d9a0e8..4d2a1432c121 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
@@ -612,6 +612,7 @@
 #define SDMA0_UTCL1_PAGE__DMA_PAGE_SIZE__SHIFT                                                                0x10
 #define SDMA0_UTCL1_PAGE__USE_BC__SHIFT                                                                       0x16
 #define SDMA0_UTCL1_PAGE__ADDR_IS_PA__SHIFT                                                                   0x17
+#define SDMA0_UTCL1_PAGE__LLC_NOALLOC__SHIFT                                                                  0x18
 #define SDMA0_UTCL1_PAGE__VM_HOLE_MASK                                                                        0x00000001L
 #define SDMA0_UTCL1_PAGE__REQ_TYPE_MASK                                                                       0x0000001EL
 #define SDMA0_UTCL1_PAGE__USE_MTYPE_MASK                                                                      0x000003C0L
@@ -622,6 +623,7 @@
 #define SDMA0_UTCL1_PAGE__DMA_PAGE_SIZE_MASK                                                                  0x003F0000L
 #define SDMA0_UTCL1_PAGE__USE_BC_MASK                                                                         0x00400000L
 #define SDMA0_UTCL1_PAGE__ADDR_IS_PA_MASK                                                                     0x00800000L
+#define SDMA0_UTCL1_PAGE__LLC_NOALLOC_MASK                                                                    0x01000000L
 //SDMA0_RELAX_ORDERING_LUT
 #define SDMA0_RELAX_ORDERING_LUT__RESERVED0__SHIFT                                                            0x0
 #define SDMA0_RELAX_ORDERING_LUT__COPY__SHIFT                                                                 0x1
@@ -3484,6 +3486,7 @@
 #define SDMA1_UTCL1_PAGE__DMA_PAGE_SIZE__SHIFT                                                                0x10
 #define SDMA1_UTCL1_PAGE__USE_BC__SHIFT                                                                       0x16
 #define SDMA1_UTCL1_PAGE__ADDR_IS_PA__SHIFT                                                                   0x17
+#define SDMA1_UTCL1_PAGE__LLC_NOALLOC__SHIFT                                                                  0x18
 #define SDMA1_UTCL1_PAGE__VM_HOLE_MASK                                                                        0x00000001L
 #define SDMA1_UTCL1_PAGE__REQ_TYPE_MASK                                                                       0x0000001EL
 #define SDMA1_UTCL1_PAGE__USE_MTYPE_MASK                                                                      0x000003C0L
@@ -3494,6 +3497,7 @@
 #define SDMA1_UTCL1_PAGE__DMA_PAGE_SIZE_MASK                                                                  0x003F0000L
 #define SDMA1_UTCL1_PAGE__USE_BC_MASK                                                                         0x00400000L
 #define SDMA1_UTCL1_PAGE__ADDR_IS_PA_MASK                                                                     0x00800000L
+#define SDMA1_UTCL1_PAGE__LLC_NOALLOC_MASK                                                                    0x01000000L
 //SDMA1_RELAX_ORDERING_LUT
 #define SDMA1_RELAX_ORDERING_LUT__RESERVED0__SHIFT                                                            0x0
 #define SDMA1_RELAX_ORDERING_LUT__COPY__SHIFT                                                                 0x1
@@ -7284,6 +7288,7 @@
 #define WD_UTCL1_CNTL__FRAG_LIMIT_MODE__SHIFT                                                                 0x1b
 #define WD_UTCL1_CNTL__FORCE_SNOOP__SHIFT                                                                     0x1c
 #define WD_UTCL1_CNTL__MTYPE_OVERRIDE__SHIFT                                                                  0x1d
+#define WD_UTCL1_CNTL__LLC_NOALLOC_OVERRIDE__SHIFT                                                            0x1e
 #define WD_UTCL1_CNTL__XNACK_REDO_TIMER_CNT_MASK                                                              0x000FFFFFL
 #define WD_UTCL1_CNTL__VMID_RESET_MODE_MASK                                                                   0x00800000L
 #define WD_UTCL1_CNTL__DROP_MODE_MASK                                                                         0x01000000L
@@ -7292,6 +7297,7 @@
 #define WD_UTCL1_CNTL__FRAG_LIMIT_MODE_MASK                                                                   0x08000000L
 #define WD_UTCL1_CNTL__FORCE_SNOOP_MASK                                                                       0x10000000L
 #define WD_UTCL1_CNTL__MTYPE_OVERRIDE_MASK                                                                    0x20000000L
+#define WD_UTCL1_CNTL__LLC_NOALLOC_OVERRIDE_MASK                                                              0x40000000L
 //WD_UTCL1_STATUS
 #define WD_UTCL1_STATUS__FAULT_DETECTED__SHIFT                                                                0x0
 #define WD_UTCL1_STATUS__RETRY_DETECTED__SHIFT                                                                0x1
@@ -7321,6 +7327,7 @@
 #define IA_UTCL1_CNTL__FRAG_LIMIT_MODE__SHIFT                                                                 0x1b
 #define IA_UTCL1_CNTL__FORCE_SNOOP__SHIFT                                                                     0x1c
 #define IA_UTCL1_CNTL__MTYPE_OVERRIDE__SHIFT                                                                  0x1d
+#define IA_UTCL1_CNTL__LLC_NOALLOC_OVERRIDE__SHIFT                                                            0x1e
 #define IA_UTCL1_CNTL__XNACK_REDO_TIMER_CNT_MASK                                                              0x000FFFFFL
 #define IA_UTCL1_CNTL__VMID_RESET_MODE_MASK                                                                   0x00800000L
 #define IA_UTCL1_CNTL__DROP_MODE_MASK                                                                         0x01000000L
@@ -7329,6 +7336,7 @@
 #define IA_UTCL1_CNTL__FRAG_LIMIT_MODE_MASK                                                                   0x08000000L
 #define IA_UTCL1_CNTL__FORCE_SNOOP_MASK                                                                       0x10000000L
 #define IA_UTCL1_CNTL__MTYPE_OVERRIDE_MASK                                                                    0x20000000L
+#define IA_UTCL1_CNTL__LLC_NOALLOC_OVERRIDE_MASK                                                              0x40000000L
 //IA_UTCL1_STATUS
 #define IA_UTCL1_STATUS__FAULT_DETECTED__SHIFT                                                                0x0
 #define IA_UTCL1_STATUS__RETRY_DETECTED__SHIFT                                                                0x1
@@ -13584,6 +13592,13 @@
 //GCMC_VM_XGMI_LFB_SIZE
 #define GCMC_VM_XGMI_LFB_SIZE__PF_LFB_SIZE__SHIFT                                                             0x0
 #define GCMC_VM_XGMI_LFB_SIZE__PF_LFB_SIZE_MASK                                                               0x0001FFFFL
+//GCMC_VM_FB_NOALLOC_CNTL
+#define GCMC_VM_FB_NOALLOC_CNTL__LOCAL_FB_NOALLOC_NOPTE__SHIFT                                                0x0
+#define GCMC_VM_FB_NOALLOC_CNTL__REMOTE_FB_NOALLOC_NOPTE__SHIFT                                               0x1
+#define GCMC_VM_FB_NOALLOC_CNTL__FB_NOALLOC_WALKER_FETCH__SHIFT                                               0x2
+#define GCMC_VM_FB_NOALLOC_CNTL__LOCAL_FB_NOALLOC_NOPTE_MASK                                                  0x00000001L
+#define GCMC_VM_FB_NOALLOC_CNTL__REMOTE_FB_NOALLOC_NOPTE_MASK                                                 0x00000002L
+#define GCMC_VM_FB_NOALLOC_CNTL__FB_NOALLOC_WALKER_FETCH_MASK                                                 0x00000004L
 //GCUTCL2_HARVEST_BYPASS_GROUPS
 #define GCUTCL2_HARVEST_BYPASS_GROUPS__BYPASS_GROUPS__SHIFT                                                   0x0
 #define GCUTCL2_HARVEST_BYPASS_GROUPS__BYPASS_GROUPS_MASK                                                     0xFFFFFFFFL
@@ -20063,6 +20078,10 @@
 #define DB_RMI_L2_CACHE_CONTROL__HTILE_RD_POLICY__SHIFT                                                       0x14
 #define DB_RMI_L2_CACHE_CONTROL__Z_BIG_PAGE__SHIFT                                                            0x18
 #define DB_RMI_L2_CACHE_CONTROL__S_BIG_PAGE__SHIFT                                                            0x19
+#define DB_RMI_L2_CACHE_CONTROL__Z_NOALLOC__SHIFT                                                             0x1a
+#define DB_RMI_L2_CACHE_CONTROL__S_NOALLOC__SHIFT                                                             0x1b
+#define DB_RMI_L2_CACHE_CONTROL__HTILE_NOALLOC__SHIFT                                                         0x1c
+#define DB_RMI_L2_CACHE_CONTROL__ZPCPSD_NOALLOC__SHIFT                                                        0x1d
 #define DB_RMI_L2_CACHE_CONTROL__Z_WR_POLICY_MASK                                                             0x00000003L
 #define DB_RMI_L2_CACHE_CONTROL__S_WR_POLICY_MASK                                                             0x0000000CL
 #define DB_RMI_L2_CACHE_CONTROL__HTILE_WR_POLICY_MASK                                                         0x00000030L
@@ -20072,6 +20091,10 @@
 #define DB_RMI_L2_CACHE_CONTROL__HTILE_RD_POLICY_MASK                                                         0x00300000L
 #define DB_RMI_L2_CACHE_CONTROL__Z_BIG_PAGE_MASK                                                              0x01000000L
 #define DB_RMI_L2_CACHE_CONTROL__S_BIG_PAGE_MASK                                                              0x02000000L
+#define DB_RMI_L2_CACHE_CONTROL__Z_NOALLOC_MASK                                                               0x04000000L
+#define DB_RMI_L2_CACHE_CONTROL__S_NOALLOC_MASK                                                               0x08000000L
+#define DB_RMI_L2_CACHE_CONTROL__HTILE_NOALLOC_MASK                                                           0x10000000L
+#define DB_RMI_L2_CACHE_CONTROL__ZPCPSD_NOALLOC_MASK                                                          0x20000000L
 //TA_BC_BASE_ADDR
 #define TA_BC_BASE_ADDR__ADDRESS__SHIFT                                                                       0x0
 #define TA_BC_BASE_ADDR__ADDRESS_MASK                                                                         0xFFFFFFFFL
@@ -32705,6 +32728,8 @@
 #define RLC_SPM_MC_CNTL__RLC_SPM_VOL__SHIFT                                                                   0xe
 #define RLC_SPM_MC_CNTL__RLC_SPM_NOFILL__SHIFT                                                                0xf
 #define RLC_SPM_MC_CNTL__RESERVED_3__SHIFT                                                                    0x10
+#define RLC_SPM_MC_CNTL__RLC_SPM_LLC_NOALLOC__SHIFT                                                           0x12
+#define RLC_SPM_MC_CNTL__RLC_SPM_LLC_NOALLOC_OVER__SHIFT                                                      0x13
 #define RLC_SPM_MC_CNTL__RESERVED__SHIFT                                                                      0x14
 #define RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK                                                                    0x0000000FL
 #define RLC_SPM_MC_CNTL__RLC_SPM_POLICY_MASK                                                                  0x00000030L
@@ -32717,6 +32742,8 @@
 #define RLC_SPM_MC_CNTL__RLC_SPM_VOL_MASK                                                                     0x00004000L
 #define RLC_SPM_MC_CNTL__RLC_SPM_NOFILL_MASK                                                                  0x00008000L
 #define RLC_SPM_MC_CNTL__RESERVED_3_MASK                                                                      0x00030000L
+#define RLC_SPM_MC_CNTL__RLC_SPM_LLC_NOALLOC_MASK                                                             0x00040000L
+#define RLC_SPM_MC_CNTL__RLC_SPM_LLC_NOALLOC_OVER_MASK                                                        0x00080000L
 #define RLC_SPM_MC_CNTL__RESERVED_MASK                                                                        0xFFF00000L
 //RLC_SPM_INT_CNTL
 #define RLC_SPM_INT_CNTL__RLC_SPM_INT_CNTL__SHIFT                                                             0x0
@@ -37158,6 +37185,7 @@
 #define GCUTC_GPUVA_VMID_TRANSLATION_ASSIST_RESPONSE_HI__MTYPE__SHIFT                                         0x12
 #define GCUTC_GPUVA_VMID_TRANSLATION_ASSIST_RESPONSE_HI__MEMLOG__SHIFT                                        0x15
 #define GCUTC_GPUVA_VMID_TRANSLATION_ASSIST_RESPONSE_HI__NACK__SHIFT                                          0x16
+#define GCUTC_GPUVA_VMID_TRANSLATION_ASSIST_RESPONSE_HI__LLC_NOALLOC__SHIFT                                   0x18
 #define GCUTC_GPUVA_VMID_TRANSLATION_ASSIST_RESPONSE_HI__ACK__SHIFT                                           0x1f
 #define GCUTC_GPUVA_VMID_TRANSLATION_ASSIST_RESPONSE_HI__ADDR_MASK                                            0x0000000FL
 #define GCUTC_GPUVA_VMID_TRANSLATION_ASSIST_RESPONSE_HI__PERMS_MASK                                           0x00000070L
@@ -37169,6 +37197,7 @@
 #define GCUTC_GPUVA_VMID_TRANSLATION_ASSIST_RESPONSE_HI__MTYPE_MASK                                           0x001C0000L
 #define GCUTC_GPUVA_VMID_TRANSLATION_ASSIST_RESPONSE_HI__MEMLOG_MASK                                          0x00200000L
 #define GCUTC_GPUVA_VMID_TRANSLATION_ASSIST_RESPONSE_HI__NACK_MASK                                            0x00C00000L
+#define GCUTC_GPUVA_VMID_TRANSLATION_ASSIST_RESPONSE_HI__LLC_NOALLOC_MASK                                     0x01000000L
 #define GCUTC_GPUVA_VMID_TRANSLATION_ASSIST_RESPONSE_HI__ACK_MASK                                             0x80000000L
 
 
@@ -37761,6 +37790,7 @@
 #define SDMA2_UTCL1_PAGE__DMA_PAGE_SIZE__SHIFT                                                                0x10
 #define SDMA2_UTCL1_PAGE__USE_BC__SHIFT                                                                       0x16
 #define SDMA2_UTCL1_PAGE__ADDR_IS_PA__SHIFT                                                                   0x17
+#define SDMA2_UTCL1_PAGE__LLC_NOALLOC__SHIFT                                                                  0x18
 #define SDMA2_UTCL1_PAGE__VM_HOLE_MASK                                                                        0x00000001L
 #define SDMA2_UTCL1_PAGE__REQ_TYPE_MASK                                                                       0x0000001EL
 #define SDMA2_UTCL1_PAGE__USE_MTYPE_MASK                                                                      0x000003C0L
@@ -37771,6 +37801,7 @@
 #define SDMA2_UTCL1_PAGE__DMA_PAGE_SIZE_MASK                                                                  0x003F0000L
 #define SDMA2_UTCL1_PAGE__USE_BC_MASK                                                                         0x00400000L
 #define SDMA2_UTCL1_PAGE__ADDR_IS_PA_MASK                                                                     0x00800000L
+#define SDMA2_UTCL1_PAGE__LLC_NOALLOC_MASK                                                                    0x01000000L
 //SDMA2_RELAX_ORDERING_LUT
 #define SDMA2_RELAX_ORDERING_LUT__RESERVED0__SHIFT                                                            0x0
 #define SDMA2_RELAX_ORDERING_LUT__COPY__SHIFT                                                                 0x1
@@ -40633,6 +40664,7 @@
 #define SDMA3_UTCL1_PAGE__DMA_PAGE_SIZE__SHIFT                                                                0x10
 #define SDMA3_UTCL1_PAGE__USE_BC__SHIFT                                                                       0x16
 #define SDMA3_UTCL1_PAGE__ADDR_IS_PA__SHIFT                                                                   0x17
+#define SDMA3_UTCL1_PAGE__LLC_NOALLOC__SHIFT                                                                  0x18
 #define SDMA3_UTCL1_PAGE__VM_HOLE_MASK                                                                        0x00000001L
 #define SDMA3_UTCL1_PAGE__REQ_TYPE_MASK                                                                       0x0000001EL
 #define SDMA3_UTCL1_PAGE__USE_MTYPE_MASK                                                                      0x000003C0L
@@ -40643,6 +40675,7 @@
 #define SDMA3_UTCL1_PAGE__DMA_PAGE_SIZE_MASK                                                                  0x003F0000L
 #define SDMA3_UTCL1_PAGE__USE_BC_MASK                                                                         0x00400000L
 #define SDMA3_UTCL1_PAGE__ADDR_IS_PA_MASK                                                                     0x00800000L
+#define SDMA3_UTCL1_PAGE__LLC_NOALLOC_MASK                                                                    0x01000000L
 //SDMA3_RELAX_ORDERING_LUT
 #define SDMA3_RELAX_ORDERING_LUT__RESERVED0__SHIFT                                                            0x0
 #define SDMA3_RELAX_ORDERING_LUT__COPY__SHIFT                                                                 0x1
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
