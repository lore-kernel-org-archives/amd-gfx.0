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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2C8C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 14:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1612A207E8
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 14:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBEPMZot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1612A207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2FD86E46C;
	Thu, 18 Jun 2020 14:24:32 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 788EE6E46C
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 14:24:31 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id dp10so2808594qvb.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 07:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XxZArUpA/hm9BcAnJ1cFVKH7Cl6zMr5gxzvEtjMoUZo=;
 b=pBEPMZotdSseMH2wSkVWa9W2whTLGhVAToNuqZWU9cZObxWKtI4Vz6JuOKkHUM6umw
 jmu/S0wHhIDW2rhnq6wKbBzmdJ4EQFBFvvN1/clde7bQbs4dcF9j/gyPoCkE+fbH5u4S
 BMCVTEEuTtwA+BIVB4TFhnqnLeCiP7o0iZJXZIzPYg5BOeR2ZQZARGuVRnPizzyTpWvl
 tYuz8roFu+eJIvyI3CsFwHex8HopJ5WcxzJ+6xvtlsBRvEJRdZGI0TCvUpJuKE8terOb
 6Agy+Cv4vZvQ5cNwraiw0jwzXTShl4umFXLTFqkieSYYnadphPVfeJ5xWyP9N0uakoCV
 HxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XxZArUpA/hm9BcAnJ1cFVKH7Cl6zMr5gxzvEtjMoUZo=;
 b=P8i2Cns3/IuZlbwHW67FX6Yg68N05oyaGFV/BGIusz6IB5/oUrjrv7eO9kxQVZPvxM
 uEYtrvvVXRPASkyn47R7Bg0f9/IrzKurC//dmWTMVAMSY7yCrrQPHPQuDqR2bRba/vmC
 UJ6UofnwLh5QosRgAsz9ZcdUiAOCLqytGP8Nwtjzv+Xea2kQppt94vOiq+iig5eSMyHe
 dkMVn1Dg6nEvmYFDYFK1o5bgQVLfo4YCNqLOfQWxoVvQBhxqWCfa47lsGgGPaUXiPTb3
 /1xDFEiIjDS5eXCSm8dB+jmPm+FsYbjL2AbFDJx0e96CI6hQSZwrYpWgBk0annoYgPvH
 jofg==
X-Gm-Message-State: AOAM533sCPp7yH8vIbP17fVMf/8fOnmWeEb+me1A2kH1zbIs4L/6KOZR
 lmIrUmQtqpj2e73GY6K/U14hvXAGbUTp7w==
X-Google-Smtp-Source: ABdhPJx/V1rxY+u0cALSC8Mgxy9ebNI3MI/lQMrKmOMK90XJPc2bmaHAYLcvFYYq6eqhPgOw0gCJfQ==
X-Received: by 2002:a0c:b35a:: with SMTP id a26mr3793698qvf.114.1592490269802; 
 Thu, 18 Jun 2020 07:24:29 -0700 (PDT)
Received: from brihaspati.amd.com
 (p200300c58f2304001ed633024609edb3.dip0.t-ipconnect.de.
 [2003:c5:8f23:400:1ed6:3302:4609:edb3])
 by smtp.gmail.com with ESMTPSA id g4sm3028529qka.97.2020.06.18.07.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 07:24:29 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4 v2] drm/amdgpu: label internally used symbols as static
Date: Thu, 18 Jun 2020 16:25:39 +0200
Message-Id: <20200618142542.77714-1-nirmoy.das@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, nirmoy.das@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Used sparse(make C=1) to find these loose ends.

v2:
removed unwanted extra line

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c        | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c        | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c       | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c          | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c          | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c          | 2 +-
 9 files changed, 14 insertions(+), 14 deletions(-)

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
index 5b42c50366c9..f1855a8323b2 100644
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
