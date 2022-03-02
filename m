Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D36EC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Mar 2022 21:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EAE210E208;
	Wed,  2 Mar 2022 21:25:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1039010E208
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Mar 2022 21:25:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erXyxDGgX7s8uspINFiw4aCX+uLf2S7l9x/Wo1XQCMwkzvdfUT0Go27K4NhWw8dIsLJemxyWHLiWWd6Y/pTkfBblG8Uqd3dNgPm1pirJTzKEBtNM8SjXzrm3yA4Aw2eHzvOyd9tcsl5QjqwTbe8X97iOjRiDn1f9i3db9QwOBcbKNODIqXtyiYTmN0hoZsXefzFdoQ8uflxzZ1VzEU4drMqNns0VwoFh+WqjWJ6bHFxtjvKRcdvXrhF3YouH4lr+Tu6cUpO6IUsPkfHTXYt5f8apEFrakiURVD6P3e5bdVNC3QHKwEjoe/h29ukH/752CvcWB6o4PT6LL0e1FiG82g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ox4RKKXdPYn23zkgIa3vhGDrU68IyDhjEf7faUhCeY8=;
 b=TROPiHqqKyYpfTQOkLByyyRorJp7Gx9ikiHmYiZJrVx8zBnsemcA0KNLpfu+lhmaocUGMvjRvuYN5J9k53zjfKarK6m4ScLiat8bIcRu+5q9pR6qYExp4l2G/ySWY2pzB2HgHu1Z34fcxEaIee8hrYjoEYtVrjr/sMircdjY9ERLmCeK4A5G7NFWbL1nZwMNA2J6qpLNamQIqJGz1dM1uQ7GMWYmv5M9qoJ4nVvXFf9dsnHJ8qilPmgx8AQ+/j5wOfIiPakfSYMNgiGN5RxAIzYPkAKGdfJhpCII2XCCkZHd+Id/Mmkk2XgCAeDJ7T6SiVe6uQw43xYsy1rg8QqLUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ox4RKKXdPYn23zkgIa3vhGDrU68IyDhjEf7faUhCeY8=;
 b=d2Wkpqg8WX6L8vTUqPLoEimerFyQUZbH7nqjfSTuISa2/kNjkcKjMKE3l9a8+HkvgOW6lxu9YpBUXtFGY3+no5O2YG8CdSftelnKuOMJ0efjSE2Uqi7Dqi259crzehHRrwidFi6AqrJAdF7WNt5czqQgOq6NU+7PeSHT+rfrIGg=
Received: from DM5PR19CA0032.namprd19.prod.outlook.com (2603:10b6:3:9a::18) by
 BYAPR12MB4693.namprd12.prod.outlook.com (2603:10b6:a03:98::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.24; Wed, 2 Mar 2022 21:25:50 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::bf) by DM5PR19CA0032.outlook.office365.com
 (2603:10b6:3:9a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 2 Mar 2022 21:25:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 2 Mar 2022 21:25:50 +0000
Received: from ruijing-small-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 2 Mar
 2022 15:25:49 -0600
From: Ruijing Dong <ruijing.dong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/vcn: Update fw shared data structure
Date: Wed, 2 Mar 2022 16:25:09 -0500
Message-ID: <20220302212510.1743386-1-ruijing.dong@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09820d86-9d11-4241-78e3-08d9fc93396b
X-MS-TrafficTypeDiagnostic: BYAPR12MB4693:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4693B0D5804A14E1FA9F0F4A95039@BYAPR12MB4693.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zVjYyCsrXnrtkyKbWRWLv/U45BNC7IJl+sUULbm8CsmvARU2CyX736j+8QMSE1etbYgM/dOCYYnbPRSczbG6oO0ScxYHi0maxuPdTODHmYCfl5LDJeeBw7eQTx8t35JZpSFFj22GD3ckMarzf/qbMKfyUYXenjihj8vR58mTUpunuC/kh+ptuhxp31P0/yNYaQlNtLPWSkNb9Xy/MMpKQMRRd3HNMGr3DCfxjCK/LMqyDJstvTEI7XXjYFUslwVrPZr8XCFxs5TgT41dyQ0+MrUYXlv27bpxlC6o+9YQVIJY0IULcey1DX+MpeHhA+YjEqFgtTgGhqlc2sM7Zn6Mo6yuLmidp1htjkQh0siZPuPUzL6RCIQlwxCXSpsN/FBWB6wZ2mWUqCR8AM+iNgGIy4x7DQskWuc8hby9CxQjYjavaUiW7bZhTMbCd3skOKcG42vmxbwfP84A/dvxwcVZDPragqrusvITswnu44IGv1XXo6t4Z189waTn0J1jgDCEgeaVNkPX561Z1hKVsHhDPDz8WEvM15V6YJWykRfhpRCA5+fLaBf1knYpTVGWsu88VKw7rhzkTgm2VYvv+/IA8jEjul2rvk7ue32sqnVthVUQJOk/BnvgzXZABAO8H3LNqh0XtPuiR06sXsz7dEn+xk0g+jgZ/gqvbIyjJ7IGtXU4t5elW7jBoa1PqjxgrszYP2eRqCYBsy9eBs7u2LTUMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400004)(8676002)(70206006)(336012)(4326008)(1076003)(356005)(47076005)(70586007)(81166007)(26005)(186003)(426003)(316002)(16526019)(6916009)(36756003)(2616005)(54906003)(83380400001)(8936002)(30864003)(6666004)(86362001)(7696005)(44832011)(40460700003)(2906002)(508600001)(36860700001)(5660300002)(15650500001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 21:25:50.0716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09820d86-9d11-4241-78e3-08d9fc93396b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4693
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
Cc: alexander.deucher@amd.com, leo.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add fw log in fw shared data structure.

Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 14 ++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 26 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 18 ++++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 18 ++++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 20 +++++++++----------
 5 files changed, 61 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 5e0dbf54d561..6f3f55e39ab1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -79,6 +79,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	const char *fw_name;
 	const struct common_firmware_header *hdr;
 	unsigned char fw_check;
+	unsigned int fw_shared_size;
 	int i, r;
 
 	INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handler);
@@ -226,7 +227,8 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	bo_size = AMDGPU_VCN_STACK_SIZE + AMDGPU_VCN_CONTEXT_SIZE;
 	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
 		bo_size += AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
-	bo_size += AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared));
+	fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared));
+	bo_size += fw_shared_size;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -240,10 +242,12 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 			return r;
 		}
 
-		adev->vcn.inst[i].fw_shared_cpu_addr = adev->vcn.inst[i].cpu_addr +
-				bo_size - AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared));
-		adev->vcn.inst[i].fw_shared_gpu_addr = adev->vcn.inst[i].gpu_addr +
-				bo_size - AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared));
+		adev->vcn.inst[i].fw_shared.cpu_addr = adev->vcn.inst[i].cpu_addr +
+				bo_size - fw_shared_size;
+		adev->vcn.inst[i].fw_shared.gpu_addr = adev->vcn.inst[i].gpu_addr +
+				bo_size - fw_shared_size;
+
+		adev->vcn.inst[i].fw_shared.mem_size = fw_shared_size;
 
 		if (adev->vcn.indirect_sram) {
 			r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 5d3728b027d3..f6569a7d6fdb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -205,6 +205,13 @@ struct amdgpu_vcn_reg{
 	unsigned	scratch9;
 };
 
+struct amdgpu_vcn_fw_shared {
+	void        *cpu_addr;
+	uint64_t    gpu_addr;
+	uint32_t    mem_size;
+	uint32_t    log_offset;
+};
+
 struct amdgpu_vcn_inst {
 	struct amdgpu_bo	*vcpu_bo;
 	void			*cpu_addr;
@@ -221,8 +228,7 @@ struct amdgpu_vcn_inst {
 	uint64_t		dpg_sram_gpu_addr;
 	uint32_t		*dpg_sram_curr_addr;
 	atomic_t		dpg_enc_submission_cnt;
-	void			*fw_shared_cpu_addr;
-	uint64_t		fw_shared_gpu_addr;
+	struct amdgpu_vcn_fw_shared fw_shared;
 };
 
 struct amdgpu_vcn {
@@ -265,6 +271,13 @@ struct amdgpu_fw_shared_sw_ring {
 	uint8_t padding[3];
 };
 
+struct amdgpu_fw_shared_fw_logging {
+	uint8_t is_enabled;
+	uint32_t addr_lo;
+	uint32_t addr_hi;
+	uint32_t size;
+};
+
 struct amdgpu_fw_shared {
 	uint32_t present_flag_0;
 	uint8_t pad[44];
@@ -272,6 +285,15 @@ struct amdgpu_fw_shared {
 	uint8_t pad1[1];
 	struct amdgpu_fw_shared_multi_queue multi_queue;
 	struct amdgpu_fw_shared_sw_ring sw_ring;
+	struct amdgpu_fw_shared_fw_logging fw_log;
+};
+
+struct amdgpu_vcn_fwlog {
+	uint32_t rptr;
+	uint32_t wptr;
+	uint32_t buffer_size;
+	uint32_t header_size;
+	uint8_t wrapped;
 };
 
 struct amdgpu_vcn_decode_buffer {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 313fc1b53999..36ec877a2a55 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -172,7 +172,7 @@ static int vcn_v2_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	fw_shared = adev->vcn.inst->fw_shared_cpu_addr;
+	fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
 	fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
 	return 0;
 }
@@ -188,7 +188,7 @@ static int vcn_v2_0_sw_fini(void *handle)
 {
 	int r, idx;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared_cpu_addr;
+	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 		fw_shared->present_flag_0 = 0;
@@ -364,9 +364,9 @@ static void vcn_v2_0_mc_resume(struct amdgpu_device *adev)
 
 	/* non-cache window */
 	WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW,
-		lower_32_bits(adev->vcn.inst->fw_shared_gpu_addr));
+		lower_32_bits(adev->vcn.inst->fw_shared.gpu_addr));
 	WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH,
-		upper_32_bits(adev->vcn.inst->fw_shared_gpu_addr));
+		upper_32_bits(adev->vcn.inst->fw_shared.gpu_addr));
 	WREG32_SOC15(UVD, 0, mmUVD_VCPU_NONCACHE_OFFSET0, 0);
 	WREG32_SOC15(UVD, 0, mmUVD_VCPU_NONCACHE_SIZE0,
 		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)));
@@ -455,10 +455,10 @@ static void vcn_v2_0_mc_resume_dpg_mode(struct amdgpu_device *adev, bool indirec
 	/* non-cache window */
 	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
-		lower_32_bits(adev->vcn.inst->fw_shared_gpu_addr), 0, indirect);
+		lower_32_bits(adev->vcn.inst->fw_shared.gpu_addr), 0, indirect);
 	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
-		upper_32_bits(adev->vcn.inst->fw_shared_gpu_addr), 0, indirect);
+		upper_32_bits(adev->vcn.inst->fw_shared.gpu_addr), 0, indirect);
 	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
 	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
@@ -784,7 +784,7 @@ static void vcn_v2_0_enable_static_power_gating(struct amdgpu_device *adev)
 
 static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 {
-	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared_cpu_addr;
+	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
 	struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
 	uint32_t rb_bufsz, tmp;
 
@@ -921,7 +921,7 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 
 static int vcn_v2_0_start(struct amdgpu_device *adev)
 {
-	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared_cpu_addr;
+	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
 	struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
 	uint32_t rb_bufsz, tmp;
 	uint32_t lmi_swap_cntl;
@@ -1207,7 +1207,7 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
 				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 
 			if (!ret_code) {
-				volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared_cpu_addr;
+				volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
 				/* pause DPG */
 				reg_data |= UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
 				WREG32_SOC15(UVD, 0, mmUVD_DPG_PAUSE, reg_data);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 44fc4c218433..e656a6747f0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -196,7 +196,7 @@ static int vcn_v2_5_sw_init(void *handle)
 				return r;
 		}
 
-		fw_shared = adev->vcn.inst[j].fw_shared_cpu_addr;
+		fw_shared = adev->vcn.inst[j].fw_shared.cpu_addr;
 		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
 	}
 
@@ -229,7 +229,7 @@ static int vcn_v2_5_sw_fini(void *handle)
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 			if (adev->vcn.harvest_config & (1 << i))
 				continue;
-			fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
+			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 			fw_shared->present_flag_0 = 0;
 		}
 		drm_dev_exit(idx);
@@ -423,9 +423,9 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device *adev)
 
 		/* non-cache window */
 		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW,
-			lower_32_bits(adev->vcn.inst[i].fw_shared_gpu_addr));
+			lower_32_bits(adev->vcn.inst[i].fw_shared.gpu_addr));
 		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH,
-			upper_32_bits(adev->vcn.inst[i].fw_shared_gpu_addr));
+			upper_32_bits(adev->vcn.inst[i].fw_shared.gpu_addr));
 		WREG32_SOC15(VCN, i, mmUVD_VCPU_NONCACHE_OFFSET0, 0);
 		WREG32_SOC15(VCN, i, mmUVD_VCPU_NONCACHE_SIZE0,
 			AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)));
@@ -513,10 +513,10 @@ static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 	/* non-cache window */
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
-		lower_32_bits(adev->vcn.inst[inst_idx].fw_shared_gpu_addr), 0, indirect);
+		lower_32_bits(adev->vcn.inst[inst_idx].fw_shared.gpu_addr), 0, indirect);
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
-		upper_32_bits(adev->vcn.inst[inst_idx].fw_shared_gpu_addr), 0, indirect);
+		upper_32_bits(adev->vcn.inst[inst_idx].fw_shared.gpu_addr), 0, indirect);
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
@@ -757,7 +757,7 @@ static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev)
 
 static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
 {
-	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared_cpu_addr;
+	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
 
@@ -981,7 +981,7 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
 	vcn_v2_5_mc_resume(adev);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
+		volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 		/* VCN global tiling registers */
@@ -1403,7 +1403,7 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 
 			if (!ret_code) {
-				volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared_cpu_addr;
+				volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 
 				/* pause DPG */
 				reg_data |= UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index da11ceba0698..ae9dfb29621f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -213,7 +213,7 @@ static int vcn_v3_0_sw_init(void *handle)
 				return r;
 		}
 
-		fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
+		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SW_RING_FLAG) |
 					     cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG) |
 					     cpu_to_le32(AMDGPU_VCN_FW_SHARED_FLAG_0_RB);
@@ -249,7 +249,7 @@ static int vcn_v3_0_sw_fini(void *handle)
 
 			if (adev->vcn.harvest_config & (1 << i))
 				continue;
-			fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
+			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 			fw_shared->present_flag_0 = 0;
 			fw_shared->sw_ring.is_enabled = false;
 		}
@@ -469,9 +469,9 @@ static void vcn_v3_0_mc_resume(struct amdgpu_device *adev, int inst)
 
 	/* non-cache window */
 	WREG32_SOC15(VCN, inst, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW,
-		lower_32_bits(adev->vcn.inst[inst].fw_shared_gpu_addr));
+		lower_32_bits(adev->vcn.inst[inst].fw_shared.gpu_addr));
 	WREG32_SOC15(VCN, inst, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH,
-		upper_32_bits(adev->vcn.inst[inst].fw_shared_gpu_addr));
+		upper_32_bits(adev->vcn.inst[inst].fw_shared.gpu_addr));
 	WREG32_SOC15(VCN, inst, mmUVD_VCPU_NONCACHE_OFFSET0, 0);
 	WREG32_SOC15(VCN, inst, mmUVD_VCPU_NONCACHE_SIZE0,
 		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)));
@@ -558,10 +558,10 @@ static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 	/* non-cache window */
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, inst_idx, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
-			lower_32_bits(adev->vcn.inst[inst_idx].fw_shared_gpu_addr), 0, indirect);
+			lower_32_bits(adev->vcn.inst[inst_idx].fw_shared.gpu_addr), 0, indirect);
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, inst_idx, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
-			upper_32_bits(adev->vcn.inst[inst_idx].fw_shared_gpu_addr), 0, indirect);
+			upper_32_bits(adev->vcn.inst[inst_idx].fw_shared.gpu_addr), 0, indirect);
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, inst_idx, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
@@ -923,7 +923,7 @@ static void vcn_v3_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
 
 static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
 {
-	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared_cpu_addr;
+	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
 
@@ -1220,7 +1220,7 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
 		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
 
-		fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
+		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 		fw_shared->multi_queue.decode_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
 
 		/* programm the RB_BASE for ring buffer */
@@ -1611,7 +1611,7 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 
 				if (adev->ip_versions[UVD_HWIP][0] != IP_VERSION(3, 0, 33)) {
 					/* Restore */
-					fw_shared = adev->vcn.inst[inst_idx].fw_shared_cpu_addr;
+					fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 					fw_shared->multi_queue.encode_generalpurpose_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
 					ring = &adev->vcn.inst[inst_idx].ring_enc[0];
 					ring->wptr = 0;
@@ -1700,7 +1700,7 @@ static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
 		/*whenever update RBC_RB_WPTR, we save the wptr in shared rb.wptr and scratch2 */
-		fw_shared = adev->vcn.inst[ring->me].fw_shared_cpu_addr;
+		fw_shared = adev->vcn.inst[ring->me].fw_shared.cpu_addr;
 		fw_shared->rb.wptr = lower_32_bits(ring->wptr);
 		WREG32_SOC15(VCN, ring->me, mmUVD_SCRATCH2,
 			lower_32_bits(ring->wptr));
-- 
2.25.1

