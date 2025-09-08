Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80A9CAC589
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 23:22:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2567B10E5FC;
	Mon,  8 Sep 2025 23:22:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Q70ZUr1D";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B85D710E5FB
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 23:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rN3rdB0gNt5Oxm236XAEG6P10xPtDnI1SnTu2CEXSVE=; b=Q70ZUr1D7y0/4PAQ3ZzChcjIMI
 SXJh7AUAGGD5pkk/Ydplg7z/lFETWkVnpGtshpngrp8sffkfs14+IriCQyMejvG3rq7Wi0zC6UoVG
 QoBofP41jT502Z9ugM40t6KOxjoELDI1d4eitEyjiJLp/dHmZFttXbokCTKvKmIYT0QPMPeXQj9Bi
 /ywDVJtFHYBsj+VAsSa5/eLTSpi94WaBqU30q8/t+ToO1l+SRI7DMFIlGdTNxi/pmPdz+wbi9BRAu
 OdoI7YJsQYhbIJgRkxa6EFQ+/sOFUjPHDYQaCqx5e//ZqPOlEV1UBLm4dpxaTWUmTkUUyXG1hMi+o
 PxB7CZ8Q==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uvlBi-008iqD-M6; Tue, 09 Sep 2025 01:22:19 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 5/5] drm/amdgpu: Remove volatile references from VCN
Date: Mon,  8 Sep 2025 17:15:40 -0600
Message-ID: <20250908232134.2223198-6-siqueira@igalia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250908232134.2223198-1-siqueira@igalia.com>
References: <20250908232134.2223198-1-siqueira@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 14 +++++++-------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 12 ++++++------
 10 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index ad415203d245..67f29dc19f19 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1159,7 +1159,7 @@ static ssize_t amdgpu_debugfs_vcn_fwlog_read(struct file *f, char __user *buf,
 {
 	struct amdgpu_vcn_inst *vcn;
 	void *log_buf;
-	volatile struct amdgpu_vcn_fwlog *plog;
+	struct amdgpu_vcn_fwlog *plog;
 	unsigned int read_pos, write_pos, available, i, read_bytes = 0;
 	unsigned int read_num[2] = {0};
 
@@ -1172,7 +1172,7 @@ static ssize_t amdgpu_debugfs_vcn_fwlog_read(struct file *f, char __user *buf,
 
 	log_buf = vcn->fw_shared.cpu_addr + vcn->fw_shared.mem_size;
 
-	plog = (volatile struct amdgpu_vcn_fwlog *)log_buf;
+	plog = (struct amdgpu_vcn_fwlog *)log_buf;
 	read_pos = plog->rptr;
 	write_pos = plog->wptr;
 
@@ -1239,11 +1239,11 @@ void amdgpu_debugfs_vcn_fwlog_init(struct amdgpu_device *adev, uint8_t i,
 void amdgpu_vcn_fwlog_init(struct amdgpu_vcn_inst *vcn)
 {
 #if defined(CONFIG_DEBUG_FS)
-	volatile uint32_t *flag = vcn->fw_shared.cpu_addr;
+	uint32_t *flag = vcn->fw_shared.cpu_addr;
 	void *fw_log_cpu_addr = vcn->fw_shared.cpu_addr + vcn->fw_shared.mem_size;
 	uint64_t fw_log_gpu_addr = vcn->fw_shared.gpu_addr + vcn->fw_shared.mem_size;
-	volatile struct amdgpu_vcn_fwlog *log_buf = fw_log_cpu_addr;
-	volatile struct amdgpu_fw_shared_fw_logging *fw_log = vcn->fw_shared.cpu_addr
+	struct amdgpu_vcn_fwlog *log_buf = fw_log_cpu_addr;
+	struct amdgpu_fw_shared_fw_logging *fw_log = vcn->fw_shared.cpu_addr
 							 + vcn->fw_shared.log_offset;
 	*flag |= cpu_to_le32(AMDGPU_VCN_FW_LOGGING_FLAG);
 	fw_log->is_enabled = 1;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 1e89ba153d9d..e3a5d61274d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -193,7 +193,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->vcn.inst[0].pause_dpg_mode = vcn_v1_0_pause_dpg_mode;
 
 	if (amdgpu_vcnfw_log) {
-		volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
+		struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
 
 		fw_shared->present_flag_0 = 0;
 		amdgpu_vcn_fwlog_init(adev->vcn.inst);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index b115137ab2d6..2961d7c3fe1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -137,7 +137,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_ring *ring;
 	int i, r;
 	struct amdgpu_device *adev = ip_block->adev;
-	volatile struct amdgpu_fw_shared *fw_shared;
+	struct amdgpu_fw_shared *fw_shared;
 
 	/* VCN DEC TRAP */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
@@ -252,7 +252,7 @@ static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	int r, idx;
 	struct amdgpu_device *adev = ip_block->adev;
-	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
+	struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 		fw_shared->present_flag_0 = 0;
@@ -853,7 +853,7 @@ static void vcn_v2_0_enable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 static int vcn_v2_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 {
 	struct amdgpu_device *adev = vinst->adev;
-	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
+	struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
 	struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
 	uint32_t rb_bufsz, tmp;
 	int ret;
@@ -1001,7 +1001,7 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 static int vcn_v2_0_start(struct amdgpu_vcn_inst *vinst)
 {
 	struct amdgpu_device *adev = vinst->adev;
-	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
+	struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
 	struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
 	uint32_t rb_bufsz, tmp;
 	uint32_t lmi_swap_cntl;
@@ -1308,7 +1308,7 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 
 			if (!ret_code) {
-				volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
+				struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
 				/* pause DPG */
 				reg_data |= UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
 				WREG32_SOC15(UVD, 0, mmUVD_DPG_PAUSE, reg_data);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 904b94bc8693..778fe3d1bc97 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -277,7 +277,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	for (j = 0; j < adev->vcn.num_vcn_inst; j++) {
-		volatile struct amdgpu_fw_shared *fw_shared;
+		struct amdgpu_fw_shared *fw_shared;
 
 		if (adev->vcn.harvest_config & (1 << j))
 			continue;
@@ -420,7 +420,7 @@ static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	int i, r, idx;
 	struct amdgpu_device *adev = ip_block->adev;
-	volatile struct amdgpu_fw_shared *fw_shared;
+	struct amdgpu_fw_shared *fw_shared;
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
@@ -1000,7 +1000,7 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 {
 	struct amdgpu_device *adev = vinst->adev;
 	int inst_idx = vinst->inst;
-	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
+	struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
 	int ret;
@@ -1157,7 +1157,7 @@ static int vcn_v2_5_start(struct amdgpu_vcn_inst *vinst)
 {
 	struct amdgpu_device *adev = vinst->adev;
 	int i = vinst->inst;
-	volatile struct amdgpu_fw_shared *fw_shared =
+	struct amdgpu_fw_shared *fw_shared =
 		adev->vcn.inst[i].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
@@ -1669,7 +1669,7 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 
 			if (!ret_code) {
-				volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
+				struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 
 				/* pause DPG */
 				reg_data |= UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 95173156f956..ee717303d1b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -191,7 +191,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		volatile struct amdgpu_fw_shared *fw_shared;
+		struct amdgpu_fw_shared *fw_shared;
 
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
@@ -327,7 +327,7 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			volatile struct amdgpu_fw_shared *fw_shared;
+			struct amdgpu_fw_shared *fw_shared;
 
 			if (adev->vcn.harvest_config & (1 << i))
 				continue;
@@ -1031,7 +1031,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 {
 	struct amdgpu_device *adev = vinst->adev;
 	int inst_idx = vinst->inst;
-	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
+	struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
 	int ret;
@@ -1196,7 +1196,7 @@ static int vcn_v3_0_start(struct amdgpu_vcn_inst *vinst)
 {
 	struct amdgpu_device *adev = vinst->adev;
 	int i = vinst->inst;
-	volatile struct amdgpu_fw_shared *fw_shared;
+	struct amdgpu_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
 	int j, k, r;
@@ -1717,7 +1717,7 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 {
 	struct amdgpu_device *adev = vinst->adev;
 	int inst_idx = vinst->inst;
-	volatile struct amdgpu_fw_shared *fw_shared;
+	struct amdgpu_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t reg_data = 0;
 	int ret_code;
@@ -1836,7 +1836,7 @@ static uint64_t vcn_v3_0_dec_ring_get_wptr(struct amdgpu_ring *ring)
 static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	volatile struct amdgpu_fw_shared *fw_shared;
+	struct amdgpu_fw_shared *fw_shared;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
 		/*whenever update RBC_RB_WPTR, we save the wptr in shared rb.wptr and scratch2 */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index d0d27790b73b..61307c6d1bb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -148,7 +148,7 @@ static int vcn_v4_0_early_init(struct amdgpu_ip_block *ip_block)
 
 static int vcn_v4_0_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
 {
-	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+	struct amdgpu_vcn4_fw_shared *fw_shared;
 
 	fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
@@ -278,7 +278,7 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+			struct amdgpu_vcn4_fw_shared *fw_shared;
 
 			if (adev->vcn.harvest_config & (1 << i))
 				continue;
@@ -1000,7 +1000,7 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 {
 	struct amdgpu_device *adev = vinst->adev;
 	int inst_idx = vinst->inst;
-	volatile struct amdgpu_vcn4_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
+	struct amdgpu_vcn4_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
 	int ret;
@@ -1140,7 +1140,7 @@ static int vcn_v4_0_start(struct amdgpu_vcn_inst *vinst)
 {
 	struct amdgpu_device *adev = vinst->adev;
 	int i = vinst->inst;
-	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+	struct amdgpu_vcn4_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
 	int j, k, r;
@@ -1357,8 +1357,8 @@ static int vcn_v4_0_start_sriov(struct amdgpu_device *adev)
 	struct mmsch_v4_0_cmd_end end = { {0} };
 	struct mmsch_v4_0_init_header header;
 
-	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
-	volatile struct amdgpu_fw_shared_rb_setup *rb_setup;
+	struct amdgpu_vcn4_fw_shared *fw_shared;
+	struct amdgpu_fw_shared_rb_setup *rb_setup;
 
 	direct_wt.cmd_header.command_type =
 		MMSCH_COMMAND__DIRECT_REG_WRITE;
@@ -1609,7 +1609,7 @@ static int vcn_v4_0_stop(struct amdgpu_vcn_inst *vinst)
 {
 	struct amdgpu_device *adev = vinst->adev;
 	int i = vinst->inst;
-	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+	struct amdgpu_vcn4_fw_shared *fw_shared;
 	uint32_t tmp;
 	int r = 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 7b93a275ec4f..ee9e173e1ad6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -259,7 +259,7 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	if (drm_dev_enter(&adev->ddev, &idx)) {
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+			struct amdgpu_vcn4_fw_shared *fw_shared;
 
 			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 			fw_shared->present_flag_0 = 0;
@@ -844,7 +844,7 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 {
 	struct amdgpu_device *adev = vinst->adev;
 	int inst_idx = vinst->inst;
-	volatile struct amdgpu_vcn4_fw_shared *fw_shared =
+	struct amdgpu_vcn4_fw_shared *fw_shared =
 						adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	int vcn_inst, ret;
@@ -1011,8 +1011,8 @@ static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev)
 	struct mmsch_v4_0_cmd_end end = { {0} };
 	struct mmsch_v4_0_3_init_header header;
 
-	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
-	volatile struct amdgpu_fw_shared_rb_setup *rb_setup;
+	struct amdgpu_vcn4_fw_shared *fw_shared;
+	struct amdgpu_fw_shared_rb_setup *rb_setup;
 
 	direct_wt.cmd_header.command_type =
 		MMSCH_COMMAND__DIRECT_REG_WRITE;
@@ -1186,7 +1186,7 @@ static int vcn_v4_0_3_start(struct amdgpu_vcn_inst *vinst)
 {
 	struct amdgpu_device *adev = vinst->adev;
 	int i = vinst->inst;
-	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+	struct amdgpu_vcn4_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	int j, k, r, vcn_inst;
 	uint32_t tmp;
@@ -1396,7 +1396,7 @@ static int vcn_v4_0_3_stop(struct amdgpu_vcn_inst *vinst)
 {
 	struct amdgpu_device *adev = vinst->adev;
 	int i = vinst->inst;
-	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+	struct amdgpu_vcn4_fw_shared *fw_shared;
 	int r = 0, vcn_inst;
 	uint32_t tmp;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 6dbf33b26ee2..aaf71f1fd74a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -149,7 +149,7 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 	int i, r;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+		struct amdgpu_vcn4_fw_shared *fw_shared;
 
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
@@ -249,7 +249,7 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+			struct amdgpu_vcn4_fw_shared *fw_shared;
 
 			if (adev->vcn.harvest_config & (1 << i))
 				continue;
@@ -912,7 +912,7 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 {
 	struct amdgpu_device *adev = vinst->adev;
 	int inst_idx = vinst->inst;
-	volatile struct amdgpu_vcn4_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
+	struct amdgpu_vcn4_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
 	int ret;
@@ -1049,7 +1049,7 @@ static int vcn_v4_0_5_start(struct amdgpu_vcn_inst *vinst)
 {
 	struct amdgpu_device *adev = vinst->adev;
 	int i = vinst->inst;
-	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+	struct amdgpu_vcn4_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
 	int j, k, r;
@@ -1268,7 +1268,7 @@ static int vcn_v4_0_5_stop(struct amdgpu_vcn_inst *vinst)
 {
 	struct amdgpu_device *adev = vinst->adev;
 	int i = vinst->inst;
-	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+	struct amdgpu_vcn4_fw_shared *fw_shared;
 	uint32_t tmp;
 	int r = 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 536f06b81706..db3d6aa7d567 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -129,7 +129,7 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 	int i, r;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		volatile struct amdgpu_vcn5_fw_shared *fw_shared;
+		struct amdgpu_vcn5_fw_shared *fw_shared;
 
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
@@ -211,7 +211,7 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			volatile struct amdgpu_vcn5_fw_shared *fw_shared;
+			struct amdgpu_vcn5_fw_shared *fw_shared;
 
 			if (adev->vcn.harvest_config & (1 << i))
 				continue;
@@ -695,7 +695,7 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 {
 	struct amdgpu_device *adev = vinst->adev;
 	int inst_idx = vinst->inst;
-	volatile struct amdgpu_vcn5_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
+	struct amdgpu_vcn5_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
 	int ret;
@@ -805,7 +805,7 @@ static int vcn_v5_0_0_start(struct amdgpu_vcn_inst *vinst)
 {
 	struct amdgpu_device *adev = vinst->adev;
 	int i = vinst->inst;
-	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
+	struct amdgpu_vcn5_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
 	int j, k, r;
@@ -998,7 +998,7 @@ static int vcn_v5_0_0_stop(struct amdgpu_vcn_inst *vinst)
 {
 	struct amdgpu_device *adev = vinst->adev;
 	int i = vinst->inst;
-	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
+	struct amdgpu_vcn5_fw_shared *fw_shared;
 	uint32_t tmp;
 	int r = 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 4b01e35ad7ef..e5c34eb71d85 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -226,7 +226,7 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			volatile struct amdgpu_vcn5_fw_shared *fw_shared;
+			struct amdgpu_vcn5_fw_shared *fw_shared;
 
 			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 			fw_shared->present_flag_0 = 0;
@@ -643,7 +643,7 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 {
 	struct amdgpu_device *adev = vinst->adev;
 	int inst_idx = vinst->inst;
-	volatile struct amdgpu_vcn5_fw_shared *fw_shared =
+	struct amdgpu_vcn5_fw_shared *fw_shared =
 		adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__PAUSE};
@@ -779,8 +779,8 @@ static int vcn_v5_0_1_start_sriov(struct amdgpu_device *adev)
 	struct mmsch_v5_0_cmd_end end = { {0} };
 	struct mmsch_v5_0_init_header header;
 
-	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
-	volatile struct amdgpu_fw_shared_rb_setup *rb_setup;
+	struct amdgpu_vcn5_fw_shared *fw_shared;
+	struct amdgpu_fw_shared_rb_setup *rb_setup;
 
 	direct_wt.cmd_header.command_type =
 		MMSCH_COMMAND__DIRECT_REG_WRITE;
@@ -954,7 +954,7 @@ static int vcn_v5_0_1_start(struct amdgpu_vcn_inst *vinst)
 {
 	struct amdgpu_device *adev = vinst->adev;
 	int i = vinst->inst;
-	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
+	struct amdgpu_vcn5_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
 	int j, k, r, vcn_inst;
@@ -1146,7 +1146,7 @@ static int vcn_v5_0_1_stop(struct amdgpu_vcn_inst *vinst)
 {
 	struct amdgpu_device *adev = vinst->adev;
 	int i = vinst->inst;
-	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
+	struct amdgpu_vcn5_fw_shared *fw_shared;
 	uint32_t tmp;
 	int r = 0, vcn_inst;
 
-- 
2.50.1

