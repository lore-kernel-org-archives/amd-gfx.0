Return-Path: <SRS0=7Qtl=77=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA5FC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 13:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF6C2073E
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 13:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTsfc1P6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF6C2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67D546E426;
	Thu, 18 Jun 2020 13:16:14 +0000 (UTC)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 632C96E426
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 13:16:13 +0000 (UTC)
Received: by mail-qt1-x832.google.com with SMTP id k22so4327873qtm.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 06:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=32syDi2BWsM2d1/PSj5xALIqi5K5Y5/Ds9A3rDuQ5wE=;
 b=tTsfc1P6M8ojmsMJHKEXfh8x3MpuR2XzHh5/j5JIFGbRd3hjYJz9o8TybIqQFbD3pw
 FiDrarogSnCyAsi0H37FEsm0+LsiWeA1uQF5CSvsbxnpuk8E5Uo9qq+J8FSA7Cay9o9Y
 oGQT/rQ7jPJDykCboMXK9PA0DlAfaJowczNXXmtY2Siy1ca2p7AB+5EkMv8YWrCh1BLB
 JHFZxUScGiO+iyZp3LPCIGj8XSO+y0LB+rj1RiHIrSXbkRlcmOiNizZ+h8craOHyyk59
 Yp8Y7iiKLv7n3kYz6geDsYNvIa9Ystg1tcknZnma5SsYx/X6FgLp/xBGHRMLdMHpY6YR
 ztZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=32syDi2BWsM2d1/PSj5xALIqi5K5Y5/Ds9A3rDuQ5wE=;
 b=XPzk3E3cO1wkPhzIghUWpYN+VloJRVw4tDMXV2bukHBByeiVBlQo9mXI/zA258yz/e
 0bukWJpGMsmrFfJjWuDiNXzxDGoxvANcXTdTRNP0i6Tk6MFMdJWMaE20tN3aM6doGD+r
 hAaXUQfxgJWES3kgWXKvzDPcT49QngZOwlmSmDSgdwYmgCBQCNAsjWWO+O7W7V7Oqw4n
 X5IIVGBGWR0RWoAW/yk29/AO1176RZ2s3WnOGmCRmhrHyg6HNrOvk52w010UZHFjN/MM
 GhZtdsh0tVY8Pd6ShUnptKI6Y+TecES6G76JobE8LEtW8fUOjUrTdmZMhrrj3y85idt/
 AxmQ==
X-Gm-Message-State: AOAM530HJgD56p2bi7rnhVoDu3yqqmnKbEYuEsa8ZyQFeS5bqsbiMfrR
 5l7uuR99eK+XXm9Q8S6SelqZ12os2DA=
X-Google-Smtp-Source: ABdhPJzzq/v1jhJH+DAytJ+Eqpr2BwKZttJHu8NKJAIudNNmY2uvfjNXwyRVtLR2KLE3NCu8YXAY1g==
X-Received: by 2002:ac8:4742:: with SMTP id k2mr4404587qtp.304.1592486171902; 
 Thu, 18 Jun 2020 06:16:11 -0700 (PDT)
Received: from brihaspati.amd.com
 (p200300c58f2304001ed633024609edb3.dip0.t-ipconnect.de.
 [2003:c5:8f23:400:1ed6:3302:4609:edb3])
 by smtp.gmail.com with ESMTPSA id v189sm3021933qkb.64.2020.06.18.06.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 06:16:11 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: label internally used symbols as static
Date: Thu, 18 Jun 2020 15:17:09 +0200
Message-Id: <20200618131712.90389-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.27.0
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
Cc: nirmoy.das@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Used sparse(make C=1) to find these loose ends.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c        | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c        | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c       | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c          | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c          | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c          | 2 +-
 9 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index b5d6274952a5..4ef38c2411ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -32,7 +32,7 @@
 #define mmMM_DATA		0x1
 #define HW_ID_MAX		300
 
-const char *hw_id_names[HW_ID_MAX] = {
+static const char *hw_id_names[HW_ID_MAX] = {
 	[MP1_HWID]		= "MP1",
 	[MP2_HWID]		= "MP2",
 	[THM_HWID]		= "THM",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 6ae80b33182c..e811fecc540f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -32,7 +32,7 @@
 #define I2C_PRODUCT_INFO_ADDR_SIZE	0x2
 #define I2C_PRODUCT_INFO_OFFSET		0xC0
 
-bool is_fru_eeprom_supported(struct amdgpu_device *adev)
+static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 {
 	/* TODO: Gaming SKUs don't have the FRU EEPROM.
 	 * Use this hack to address hangs on modprobe on gaming SKUs
@@ -48,7 +48,7 @@ bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 	return false;
 }
 
-int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
+static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
 			   unsigned char *buff)
 {
 	int ret, size;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 60558497f054..0723dee2958b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -583,7 +583,7 @@ static void psp_prep_ta_invoke_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 	cmd->cmd.cmd_invoke_cmd.ta_cmd_id 	= ta_cmd_id;
 }
 
-int psp_ta_invoke(struct psp_context *psp,
+static int psp_ta_invoke(struct psp_context *psp,
 		  uint32_t ta_cmd_id,
 		  uint32_t session_id)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 9bfe59b70030..ab8e7c91c645 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -86,7 +86,7 @@ void amdgpu_ras_set_error_query_ready(struct amdgpu_device *adev, bool ready)
 		amdgpu_ras_get_context(adev)->error_query_ready = ready;
 }
 
-bool amdgpu_ras_get_error_query_ready(struct amdgpu_device *adev)
+static bool amdgpu_ras_get_error_query_ready(struct amdgpu_device *adev)
 {
 	if (adev && amdgpu_ras_get_context(adev))
 		return amdgpu_ras_get_context(adev)->error_query_ready;
@@ -505,7 +505,7 @@ struct ras_manager *amdgpu_ras_find_obj(struct amdgpu_device *adev,
 }
 /* obj end */
 
-void amdgpu_ras_parse_status_code(struct amdgpu_device* adev,
+static void amdgpu_ras_parse_status_code(struct amdgpu_device *adev,
 				  const char* 		invoke_type,
 				  const char* 		block_name,
 				  enum ta_ras_status 	ret)
@@ -815,7 +815,7 @@ int amdgpu_ras_error_query(struct amdgpu_device *adev,
 }
 
 /* Trigger XGMI/WAFL error */
-int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
+static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
 				 struct ta_ras_trigger_error_input *block_info)
 {
 	int ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 5b42c50366c9..64b572307104 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1113,7 +1113,7 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm_tt *ttm)
 #endif
 }
 
-int amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
+static int amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
 				struct ttm_buffer_object *tbo,
 				uint64_t flags)
 {
@@ -1835,7 +1835,7 @@ static void amdgpu_ttm_training_data_block_init(struct amdgpu_device *adev)
 		(adev->gmc.mc_vram_size - GDDR6_MEM_TRAINING_OFFSET);
 	ctx->train_data_size =
 		GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;
-	
+
 	DRM_DEBUG("train_data_size:%llx,p2c_train_data_offset:%llx,c2p_train_data_offset:%llx.\n",
 			ctx->train_data_size,
 			ctx->p2c_train_data_offset,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 0891f27ba166..da233a9e429d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -515,12 +515,12 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
 	}
 }
 
-bool amdgpu_virt_access_debugfs_is_mmio(struct amdgpu_device *adev)
+static bool amdgpu_virt_access_debugfs_is_mmio(struct amdgpu_device *adev)
 {
 	return amdgpu_sriov_is_debug(adev) ? true : false;
 }
 
-bool amdgpu_virt_access_debugfs_is_kiq(struct amdgpu_device *adev)
+static bool amdgpu_virt_access_debugfs_is_kiq(struct amdgpu_device *adev)
 {
 	return amdgpu_sriov_is_normal(adev) ? true : false;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 0cc011f9190d..4aec76049a60 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3039,7 +3039,7 @@ static void gfx_v7_0_mqd_init(struct amdgpu_device *adev,
 	mqd->cp_hqd_active = 1;
 }
 
-int gfx_v7_0_mqd_commit(struct amdgpu_device *adev, struct cik_mqd *mqd)
+static int gfx_v7_0_mqd_commit(struct amdgpu_device *adev, struct cik_mqd *mqd)
 {
 	uint32_t tmp;
 	uint32_t mqd_reg;
@@ -5209,7 +5209,7 @@ static void gfx_v7_0_get_cu_info(struct amdgpu_device *adev)
 	cu_info->lds_size = 64;
 }
 
-const struct amdgpu_ip_block_version gfx_v7_0_ip_block =
+static const struct amdgpu_ip_block_version gfx_v7_0_ip_block =
 {
 	.type = AMD_IP_BLOCK_TYPE_GFX,
 	.major = 7,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 1d4128227ffd..efb759b62d21 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4589,7 +4589,7 @@ static int gfx_v8_0_mqd_init(struct amdgpu_ring *ring)
 	return 0;
 }
 
-int gfx_v8_0_mqd_commit(struct amdgpu_device *adev,
+static int gfx_v8_0_mqd_commit(struct amdgpu_device *adev,
 			struct vi_mqd *mqd)
 {
 	uint32_t mqd_reg;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index c3e59b765268..99ffc3e1fddc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -722,7 +722,7 @@ static const u32 GFX_RLC_SRM_INDEX_CNTL_DATA_OFFSETS[] =
 	mmRLC_SRM_INDEX_CNTL_DATA_7 - mmRLC_SRM_INDEX_CNTL_DATA_0,
 };
 
-void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)
+static void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)
 {
 	static void *scratch_reg0;
 	static void *scratch_reg1;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
