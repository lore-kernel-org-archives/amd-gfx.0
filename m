Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26287C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 05:13:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3087225AC
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 05:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3087225AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 435E589C1E;
	Tue, 12 Jan 2021 05:13:33 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 890698979F
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 23:52:59 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id a109so640696otc.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 15:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YM2Uk6e3mps8uT+Dr1F5RXWG0CwKWb/iTuf6iKQh248=;
 b=tB8V+cMDJf7eW/IUBI23I/GEP6+hdqZjwjmkRux7mW2MafyAxrSJtjxk4EPLYudyxI
 W/lTWlZNjiaFzxRJEmNI/RImRbu3aIMZfbsDJYs7nGZYNvGmePhZiwpZQ7oAiFteTvcg
 +d5k3h+tp2yRBVz0i4FAELUapTDgJObsxkhN2dHevo1QvAwTpxgWLpJ8r9sumuGyP77A
 w2q1/3DNQ8CRlTGkTGtEh3tjahVZAl/zYHl9igoWyHgueyorVE7+nGtdvioNjEzf5pX7
 6ivBZDGXRCsp0mU572aYhoThg8ZZb0tVjlvO9WKe29gpi1K/iZgSQxuF2CZSfMFsAU3/
 ti8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YM2Uk6e3mps8uT+Dr1F5RXWG0CwKWb/iTuf6iKQh248=;
 b=OtvXId3XXYL77S81koB4vGZE6zsC7By/edhTSBfEHK+ht5rDLC/4CcokIftLxA5gTv
 swLUpAtMo4IS7LqUADoqVeFt/IW/ShbI5EtmbgrNVwkqC2SzIyEgG3VQ4ipMWf0Y/sjB
 kXELCa3Ko8rxhWugOHGGCZc0tCnpJo5qbH0sRpB2ByLSVR12XGXUEI02XhEDh/XLpUnR
 +V50Vx2QNDIOeudp6AaWxta082LO/NByy8CsFAc/msAWAbIb+fhNF/wKQkMkyX5JiPEb
 P30nuVSRDBERb/wN0JDsxI0PTEWX3lQcqD+M/FdWFsST1+JXvIc2ikUpHJjDkTmJEC7u
 zWAg==
X-Gm-Message-State: AOAM531l7o+vwmTl+luVfJNP/rVHqkRVvGss8BBpXNFu3kLoj+QMc0kS
 yhh4E/gBiacKfMiNIa3cKA==
X-Google-Smtp-Source: ABdhPJypWFwNNoroseRluFHH54417fMYBE72jYaL0rAHJTUsCio6bxugA1zYySYNkUO7PjFKqN+zOA==
X-Received: by 2002:a05:6830:19ca:: with SMTP id
 p10mr1022462otp.233.1610409178851; 
 Mon, 11 Jan 2021 15:52:58 -0800 (PST)
Received: from vali.hitronhub.home (64-251-141-144.fidnet.com.
 [64.251.141.144])
 by smtp.gmail.com with ESMTPSA id g12sm284949otg.10.2021.01.11.15.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 15:52:58 -0800 (PST)
From: Joseph Schulte <joeschulte.js@gmail.com>
To: alexander.deucher@amd.com
Subject: [PATCH] amdgpu: Fix several checkpatch warnings and errors
Date: Mon, 11 Jan 2021 17:54:10 -0600
Message-Id: <20210111235410.110316-1-joeschulte.js@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 12 Jan 2021 05:13:32 +0000
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
Cc: Joseph Schulte <joeschulte.js@gmail.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch fixes the following checkpatch.pl errors and warnings:

ERROR: open brace '{' following struct go on the same line
ERROR: Macros with complex values should be enclosed in parentheses
ERROR: "foo* bar" should be "foo *bar"
ERROR: space prohibited before that close parenthesis ')'
WARNING: macros should not use a trailing semicolon
WARNING: please, no spaces at the start of a line

This patch also aligned member names in structs

Signed-off-by: Joseph Schulte <joeschulte.js@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 68 ++++++++++++++---------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5993dd0fdd8e..ff767f8c4f96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -110,14 +110,12 @@
 
 #define MAX_GPU_INSTANCE		16
 
-struct amdgpu_gpu_instance
-{
+struct amdgpu_gpu_instance {
 	struct amdgpu_device		*adev;
 	int				mgpu_fan_enabled;
 };
 
-struct amdgpu_mgpu_info
-{
+struct amdgpu_mgpu_info {
 	struct amdgpu_gpu_instance	gpu_ins[MAX_GPU_INSTANCE];
 	struct mutex			mutex;
 	uint32_t			num_gpu;
@@ -488,8 +486,8 @@ struct amdgpu_cs_chunk {
 };
 
 struct amdgpu_cs_post_dep {
-	struct drm_syncobj *syncobj;
-	struct dma_fence_chain *chain;
+	struct drm_syncobj	*syncobj;
+	struct dma_fence_chain  *chain;
 	u64 point;
 };
 
@@ -964,7 +962,7 @@ struct amdgpu_device {
 	struct amdgpu_umc		umc;
 
 	/* display related functionality */
-	struct amdgpu_display_manager dm;
+	struct amdgpu_display_manager   dm;
 
 	/* mes */
 	bool                            enable_mes;
@@ -975,7 +973,7 @@ struct amdgpu_device {
 
 	struct amdgpu_ip_block          ip_blocks[AMDGPU_MAX_IP_NUM];
 	int				num_ip_blocks;
-	struct mutex	mn_lock;
+	struct mutex			mn_lock;
 	DECLARE_HASHTABLE(mn_hash, 7);
 
 	/* tracking pinned memory */
@@ -1005,8 +1003,8 @@ struct amdgpu_device {
 
 	atomic_t 			in_gpu_reset;
 	enum pp_mp1_state               mp1_state;
-	struct rw_semaphore reset_sem;
-	struct amdgpu_doorbell_index doorbell_index;
+	struct rw_semaphore		reset_sem;
+	struct amdgpu_doorbell_index	doorbell_index;
 
 	struct mutex			notifier_lock;
 
@@ -1100,7 +1098,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 /*
  * Registers read & write functions.
  */
-#define AMDGPU_REGS_NO_KIQ    (1<<1)
+#define AMDGPU_REGS_NO_KIQ (1<<1)
 
 #define RREG32_NO_KIQ(reg) amdgpu_device_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
 #define WREG32_NO_KIQ(reg, v) amdgpu_device_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
@@ -1189,38 +1187,38 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 /*
  * ASICs macro.
  */
-#define amdgpu_asic_set_vga_state(adev, state) (adev)->asic_funcs->set_vga_state((adev), (state))
-#define amdgpu_asic_reset(adev) (adev)->asic_funcs->reset((adev))
-#define amdgpu_asic_reset_method(adev) (adev)->asic_funcs->reset_method((adev))
-#define amdgpu_asic_get_xclk(adev) (adev)->asic_funcs->get_xclk((adev))
-#define amdgpu_asic_set_uvd_clocks(adev, v, d) (adev)->asic_funcs->set_uvd_clocks((adev), (v), (d))
-#define amdgpu_asic_set_vce_clocks(adev, ev, ec) (adev)->asic_funcs->set_vce_clocks((adev), (ev), (ec))
-#define amdgpu_get_pcie_lanes(adev) (adev)->asic_funcs->get_pcie_lanes((adev))
-#define amdgpu_set_pcie_lanes(adev, l) (adev)->asic_funcs->set_pcie_lanes((adev), (l))
-#define amdgpu_asic_get_gpu_clock_counter(adev) (adev)->asic_funcs->get_gpu_clock_counter((adev))
-#define amdgpu_asic_read_disabled_bios(adev) (adev)->asic_funcs->read_disabled_bios((adev))
-#define amdgpu_asic_read_bios_from_rom(adev, b, l) (adev)->asic_funcs->read_bios_from_rom((adev), (b), (l))
-#define amdgpu_asic_read_register(adev, se, sh, offset, v)((adev)->asic_funcs->read_register((adev), (se), (sh), (offset), (v)))
-#define amdgpu_asic_get_config_memsize(adev) (adev)->asic_funcs->get_config_memsize((adev))
-#define amdgpu_asic_flush_hdp(adev, r) (adev)->asic_funcs->flush_hdp((adev), (r))
-#define amdgpu_asic_invalidate_hdp(adev, r) (adev)->asic_funcs->invalidate_hdp((adev), (r))
-#define amdgpu_asic_need_full_reset(adev) (adev)->asic_funcs->need_full_reset((adev))
-#define amdgpu_asic_init_doorbell_index(adev) (adev)->asic_funcs->init_doorbell_index((adev))
+#define amdgpu_asic_set_vga_state(adev, state) ((adev)->asic_funcs->set_vga_state((adev), (state)))
+#define amdgpu_asic_reset(adev) ((adev)->asic_funcs->reset((adev)))
+#define amdgpu_asic_reset_method(adev) ((adev)->asic_funcs->reset_method((adev)))
+#define amdgpu_asic_get_xclk(adev) ((adev)->asic_funcs->get_xclk((adev)))
+#define amdgpu_asic_set_uvd_clocks(adev, v, d) ((adev)->asic_funcs->set_uvd_clocks((adev), (v), (d)))
+#define amdgpu_asic_set_vce_clocks(adev, ev, ec) ((adev)->asic_funcs->set_vce_clocks((adev), (ev), (ec)))
+#define amdgpu_get_pcie_lanes(adev) ((adev)->asic_funcs->get_pcie_lanes((adev)))
+#define amdgpu_set_pcie_lanes(adev, l) ((adev)->asic_funcs->set_pcie_lanes((adev), (l)))
+#define amdgpu_asic_get_gpu_clock_counter(adev) ((adev)->asic_funcs->get_gpu_clock_counter((adev)))
+#define amdgpu_asic_read_disabled_bios(adev) ((adev)->asic_funcs->read_disabled_bios((adev)))
+#define amdgpu_asic_read_bios_from_rom(adev, b, l) ((adev)->asic_funcs->read_bios_from_rom((adev), (b), (l)))
+#define amdgpu_asic_read_register(adev, se, sh, offset, v) (((adev)->asic_funcs->read_register((adev), (se), (sh), (offset), (v))))
+#define amdgpu_asic_get_config_memsize(adev) ((adev)->asic_funcs->get_config_memsize((adev)))
+#define amdgpu_asic_flush_hdp(adev, r) ((adev)->asic_funcs->flush_hdp((adev), (r)))
+#define amdgpu_asic_invalidate_hdp(adev, r) ((adev)->asic_funcs->invalidate_hdp((adev), (r)))
+#define amdgpu_asic_need_full_reset(adev) ((adev)->asic_funcs->need_full_reset((adev)))
+#define amdgpu_asic_init_doorbell_index(adev) ((adev)->asic_funcs->init_doorbell_index((adev)))
 #define amdgpu_asic_get_pcie_usage(adev, cnt0, cnt1) ((adev)->asic_funcs->get_pcie_usage((adev), (cnt0), (cnt1)))
-#define amdgpu_asic_need_reset_on_init(adev) (adev)->asic_funcs->need_reset_on_init((adev))
+#define amdgpu_asic_need_reset_on_init(adev) ((adev)->asic_funcs->need_reset_on_init((adev)))
 #define amdgpu_asic_get_pcie_replay_count(adev) ((adev)->asic_funcs->get_pcie_replay_count((adev)))
-#define amdgpu_asic_supports_baco(adev) (adev)->asic_funcs->supports_baco((adev))
-#define amdgpu_asic_pre_asic_init(adev) (adev)->asic_funcs->pre_asic_init((adev))
+#define amdgpu_asic_supports_baco(adev) ((adev)->asic_funcs->supports_baco((adev)))
+#define amdgpu_asic_pre_asic_init(adev) ((adev)->asic_funcs->pre_asic_init((adev)))
 #define amdgpu_asic_update_umd_stable_pstate(adev, enter) \
 	((adev)->asic_funcs->update_umd_stable_pstate ? (adev)->asic_funcs->update_umd_stable_pstate((adev), (enter)) : 0)
 
-#define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter));
+#define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter))
 
 /* Common functions */
 bool amdgpu_device_has_job_running(struct amdgpu_device *adev);
 bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev);
 int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
-			      struct amdgpu_job* job);
+			      struct amdgpu_job *job);
 void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
 bool amdgpu_device_need_post(struct amdgpu_device *adev);
 
@@ -1327,7 +1325,7 @@ int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
 			   struct amdgpu_bo_va_mapping **mapping);
 
 #if defined(CONFIG_DRM_AMD_DC)
-int amdgpu_dm_display_resume(struct amdgpu_device *adev );
+int amdgpu_dm_display_resume(struct amdgpu_device *adev);
 #else
 static inline int amdgpu_dm_display_resume(struct amdgpu_device *adev) { return 0; }
 #endif
@@ -1349,7 +1347,7 @@ bool amdgpu_device_load_pci_state(struct pci_dev *pdev);
 
 static inline bool amdgpu_is_tmz(struct amdgpu_device *adev)
 {
-       return adev->gmc.tmz_enabled;
+	return adev->gmc.tmz_enabled;
 }
 
 static inline int amdgpu_in_reset(struct amdgpu_device *adev)
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
