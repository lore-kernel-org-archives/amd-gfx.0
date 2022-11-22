Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70027C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 05:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 924EF10E37B;
	Tue, 22 Nov 2022 05:52:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A3F010E37A
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 05:52:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMa8AJwvxlyzYcJovUS1WgXP3ELi5xc6VdafrteuLAS/fQa7nLw6wwAFhFhb77cKLUW/MDsSVtWGyeScf9CcmbD33i47t0Atim3De6Mzc9J68C5R+97eisuiC16/ClP+1OMacPGLJwPH84dL4QNaGwblQVtJo8jNQPXy1KSHBKk29sEtsEJy+dje3WExgmO4YX8x2wZBTnQ8KUDzJlcvaOisQlOvvkTvtyIwZxua2AMmJj0ORTHHkocr6Ge/ih3E7xLc3f1nxV8qKKZ4M/3KPU49rgnXUu+fNFw2PwnvbCVDpIxjla5eKtQ7UBMpxtZaM9NZoA2WN94LxdS3/mLsKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSo83EpOO3boyXG4s6eUimqW44KpBRkGD2Zdb+1K9cc=;
 b=ZulQHgIaM5E69MzPDazoespWnnpYILEwfvw4ZuZlAxHnTcbAWXkR25O613O8aBbCj+ngsF402SMrv1zx2mTSPVHUS/i2uyBUZYW1UG/NijKiWrX0sMg29SRIN7g+p614EnxQm+PLjRPkCJUAH+X1O8rbguoEylM4HommYUNyeJhoSQQUALMJ5KvPtEmYKspSFcvUhQ4+3lGkIDvL9UdqDwv1nmJJnmpsAOjNJJDHXfK7beKb071mpUciCBRvCRm+3BbaMZCivTvpmhgzNAWB6TxOweHBMt4Y/mCIrpNb7Z+OoHpvk+WSvDmG97qRIX7kHexbMwiFtBA2SAy2YKGjiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSo83EpOO3boyXG4s6eUimqW44KpBRkGD2Zdb+1K9cc=;
 b=exCGDMklbNa+NgeXMKHvP3Lqgess38z42V/wb1KvrjbOzeic13+5udAHjnbo9DoUKTr/i+hvEg6dkrEZvkEEnoO+qAWPP945MdDKGyCmvn+Dfnt1Jnu3HcMRDF/qA3CnSGIuZvs/UcLXx6wgwKsz79YcYmVhydWsdFre3AwyjhU=
Received: from DM6PR02CA0089.namprd02.prod.outlook.com (2603:10b6:5:1f4::30)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 05:52:37 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::d2) by DM6PR02CA0089.outlook.office365.com
 (2603:10b6:5:1f4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Tue, 22 Nov 2022 05:52:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Tue, 22 Nov 2022 05:52:37 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 23:52:36 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 21:52:08 -0800
Received: from amd-SYS-7048GR-TR.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 21 Nov 2022 23:52:05 -0600
From: Tong Liu01 <Tong.Liu01@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add drv_vram_usage_va for virt data exchange
Date: Tue, 22 Nov 2022 13:52:02 +0800
Message-ID: <20221122055202.5110-1-Tong.Liu01@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT039:EE_|BY5PR12MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: d7cf4002-6abb-4b75-acc9-08dacc4dc26c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KKUf3NlKNJkHg+FO7k40/v33TCfdS7QYRa8QgJM5xKaj+yT4YPHX/Jtxa5ZognqPxJI104vpnA3dQh5npOXLpcHQxdmMk6ESqdsFDGr10lWM8P5TM99r0uVgYTZ72dCxXjVqhmrEGl/Rf6xGd/7YPoujMRFLMfjnlFEenkLgjiNhoYLZs9Kwwn15b0qLIehfBOXjWbHYKq6HWebcw8eGEZLDxlMtKLcJZVtzLxK56IQhqT+VTdCIRfgOy0tP1hihn+R0VAtXJ0oxFk3mIEO9Hdx8GYPAwEjgwQralsh5m3lzMZquivMyLeixcWWNQAT4Jn2GThETWqWSiNiZTjNRz8IOppC9mErXMCIfnTtaO7u8CydaibZUibvGKq9cmTwYJtXbaUW9FuOc2mExfHrPwVszd1pqzFP7OIAUzNhSY+ZuIGf9839iT/0ajT6nR1GH8UxLGVHusI0/ZVu1bJSumyziSW+VSZrtT0KPMNZ0WHD5ERHKdgzQhRKWbjZDJx7Z21OtvUj4jsQiBmcrqnWyKuBXwZGN4eLmv0G34OklzvWMECWXQQ+sD0QLIySwaWqRdPXbZIjOsn80kTR6vRHzLh4adsAREuMgd6xsyVJZnHchUiu+9T+7Q/z21t7fuswDQyCD/M9RilOFqkZvy+p+tSgjT/97qEYLJ2Kb6jNyI+1RFx+RVuietAPGLuAlFqpQdGMbgD68BRE6SahxBndBkFIjvUofwyoVJs05kVGIdaY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(36756003)(86362001)(82310400005)(40460700003)(2616005)(82740400003)(1076003)(40480700001)(70586007)(41300700001)(70206006)(8676002)(426003)(336012)(8936002)(6666004)(478600001)(316002)(26005)(5660300002)(186003)(6916009)(7696005)(47076005)(81166007)(4326008)(83380400001)(54906003)(356005)(2906002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 05:52:37.2015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7cf4002-6abb-4b75-acc9-08dacc4dc26c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Tong Liu01 <Tong.Liu01@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, yifan.zha@amd.com,
 Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For vram_usagebyfirmware_v2_2, fw_vram_reserve is not used. So
fw_vram_usage_va is NULL, and cannot do virt data exchange
anymore. Should add drv_vram_usage_va to do virt data exchange
in vram_usagebyfirmware_v2_2 case. And refine some code style
checks in pre add vram reservation logic patch

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 16 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  9 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 54 ++++++++++++-------
 4 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 9b97fa39d47a..e40df72c138a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -104,7 +104,7 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev)
 static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
 	struct vram_usagebyfirmware_v2_1 *fw_usage, int *usage_bytes)
 {
-	uint32_t start_addr, fw_size, drv_size;
+	u32 start_addr, fw_size, drv_size;
 
 	start_addr = le32_to_cpu(fw_usage->start_address_in_kb);
 	fw_size = le16_to_cpu(fw_usage->used_by_firmware_in_kb);
@@ -116,7 +116,7 @@ static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
 			  drv_size);
 
 	if ((start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
-		(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
+		(u32)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
 		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
 		/* Firmware request VRAM reservation for SR-IOV */
 		adev->mman.fw_vram_usage_start_offset = (start_addr &
@@ -133,7 +133,7 @@ static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
 static int amdgpu_atomfirmware_allocate_fb_v2_2(struct amdgpu_device *adev,
 		struct vram_usagebyfirmware_v2_2 *fw_usage, int *usage_bytes)
 {
-	uint32_t fw_start_addr, fw_size, drv_start_addr, drv_size;
+	u32 fw_start_addr, fw_size, drv_start_addr, drv_size;
 
 	fw_start_addr = le32_to_cpu(fw_usage->fw_region_start_address_in_kb);
 	fw_size = le16_to_cpu(fw_usage->used_by_firmware_in_kb);
@@ -147,14 +147,16 @@ static int amdgpu_atomfirmware_allocate_fb_v2_2(struct amdgpu_device *adev,
 			  drv_start_addr,
 			  drv_size);
 
-	if ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
+	if ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION <<
+		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) == 0) {
 		/* Firmware request VRAM reservation for SR-IOV */
 		adev->mman.fw_vram_usage_start_offset = (fw_start_addr &
 			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
 		adev->mman.fw_vram_usage_size = fw_size << 10;
 	}
 
-	if ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
+	if ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION <<
+		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) == 0) {
 		/* driver request VRAM reservation for SR-IOV */
 		adev->mman.drv_vram_usage_start_offset = (drv_start_addr &
 			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
@@ -172,8 +174,8 @@ int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)
 						vram_usagebyfirmware);
 	struct vram_usagebyfirmware_v2_1 *fw_usage_v2_1;
 	struct vram_usagebyfirmware_v2_2 *fw_usage_v2_2;
-	uint16_t data_offset;
-	uint8_t frev, crev;
+	u16 data_offset;
+	u8 frev, crev;
 	int usage_bytes = 0;
 
 	if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_offset)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 52f2282411cb..5922f94241a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1569,8 +1569,8 @@ static void amdgpu_ttm_fw_reserve_vram_fini(struct amdgpu_device *adev)
 static void amdgpu_ttm_drv_reserve_vram_fini(struct amdgpu_device *adev)
 {
 	amdgpu_bo_free_kernel(&adev->mman.drv_vram_usage_reserved_bo,
-						  NULL,
-						  NULL);
+						 NULL,
+						 &adev->mman.drv_vram_usage_va);
 }
 
 /**
@@ -1608,8 +1608,9 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
  */
 static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
 {
-	uint64_t vram_size = adev->gmc.visible_vram_size;
+	u64 vram_size = adev->gmc.visible_vram_size;
 
+	adev->mman.drv_vram_usage_va = NULL;
 	adev->mman.drv_vram_usage_reserved_bo = NULL;
 
 	if (adev->mman.drv_vram_usage_size == 0 ||
@@ -1621,7 +1622,7 @@ static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
 					  adev->mman.drv_vram_usage_size,
 					  AMDGPU_GEM_DOMAIN_VRAM,
 					  &adev->mman.drv_vram_usage_reserved_bo,
-					  NULL);
+					  &adev->mman.drv_vram_usage_va);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index b391c8d076ff..b4d8ba2789f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -90,6 +90,7 @@ struct amdgpu_mman {
 	u64		drv_vram_usage_start_offset;
 	u64		drv_vram_usage_size;
 	struct amdgpu_bo	*drv_vram_usage_reserved_bo;
+	void		*drv_vram_usage_va;
 
 	/* PAGE_SIZE'd BO for process memory r/w over SDMA. */
 	struct amdgpu_bo	*sdma_access_bo;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index a226a6c48fb7..15544f262ec1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -428,11 +428,17 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
 	struct eeprom_table_record bp;
 	uint64_t retired_page;
 	uint32_t bp_idx, bp_cnt;
+	void *vram_usage_va = NULL;
+
+	if (adev->mman.fw_vram_usage_va)
+		vram_usage_va = adev->mman.fw_vram_usage_va;
+	else
+		vram_usage_va = adev->mman.drv_vram_usage_va;
 
 	if (bp_block_size) {
 		bp_cnt = bp_block_size / sizeof(uint64_t);
 		for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
-			retired_page = *(uint64_t *)(adev->mman.fw_vram_usage_va +
+			retired_page = *(uint64_t *)(vram_usage_va +
 					bp_block_offset + bp_idx * sizeof(uint64_t));
 			bp.retired_page = retired_page;
 
@@ -643,7 +649,9 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 	adev->virt.fw_reserve.p_vf2pf = NULL;
 	adev->virt.vf2pf_update_interval_ms = 0;
 
-	if (adev->mman.fw_vram_usage_va != NULL) {
+	if (adev->mman.fw_vram_usage_va && adev->mman.drv_vram_usage_va) {
+		DRM_WARN("Currently fw_vram and drv_vram should not have values at the same time!");
+	} else if (adev->mman.fw_vram_usage_va || adev->mman.drv_vram_usage_va) {
 		/* go through this logic in ip_init and reset to init workqueue*/
 		amdgpu_virt_exchange_data(adev);
 
@@ -666,32 +674,40 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
 	uint32_t bp_block_size = 0;
 	struct amd_sriov_msg_pf2vf_info *pf2vf_v2 = NULL;
 
-	if (adev->mman.fw_vram_usage_va != NULL) {
-
-		adev->virt.fw_reserve.p_pf2vf =
-			(struct amd_sriov_msg_pf2vf_info_header *)
-			(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
-		adev->virt.fw_reserve.p_vf2pf =
-			(struct amd_sriov_msg_vf2pf_info_header *)
-			(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
+	if (adev->mman.fw_vram_usage_va || adev->mman.drv_vram_usage_va) {
+		if (adev->mman.fw_vram_usage_va) {
+			adev->virt.fw_reserve.p_pf2vf =
+				(struct amd_sriov_msg_pf2vf_info_header *)
+				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
+			adev->virt.fw_reserve.p_vf2pf =
+				(struct amd_sriov_msg_vf2pf_info_header *)
+				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
+		} else if (adev->mman.drv_vram_usage_va) {
+			adev->virt.fw_reserve.p_pf2vf =
+				(struct amd_sriov_msg_pf2vf_info_header *)
+				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
+			adev->virt.fw_reserve.p_vf2pf =
+				(struct amd_sriov_msg_vf2pf_info_header *)
+				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
+		}
 
 		amdgpu_virt_read_pf2vf_data(adev);
 		amdgpu_virt_write_vf2pf_data(adev);
 
 		/* bad page handling for version 2 */
 		if (adev->virt.fw_reserve.p_pf2vf->version == 2) {
-				pf2vf_v2 = (struct amd_sriov_msg_pf2vf_info *)adev->virt.fw_reserve.p_pf2vf;
+			pf2vf_v2 = (struct amd_sriov_msg_pf2vf_info *)adev->virt.fw_reserve.p_pf2vf;
 
-				bp_block_offset = ((uint64_t)pf2vf_v2->bp_block_offset_low & 0xFFFFFFFF) |
-						((((uint64_t)pf2vf_v2->bp_block_offset_high) << 32) & 0xFFFFFFFF00000000);
-				bp_block_size = pf2vf_v2->bp_block_size;
+			bp_block_offset = ((uint64_t)pf2vf_v2->bp_block_offset_low & 0xFFFFFFFF) |
+				((((uint64_t)pf2vf_v2->bp_block_offset_high) << 32) & 0xFFFFFFFF00000000);
+			bp_block_size = pf2vf_v2->bp_block_size;
 
-				if (bp_block_size && !adev->virt.ras_init_done)
-					amdgpu_virt_init_ras_err_handler_data(adev);
+			if (bp_block_size && !adev->virt.ras_init_done)
+				amdgpu_virt_init_ras_err_handler_data(adev);
 
-				if (adev->virt.ras_init_done)
-					amdgpu_virt_add_bad_page(adev, bp_block_offset, bp_block_size);
-			}
+			if (adev->virt.ras_init_done)
+				amdgpu_virt_add_bad_page(adev, bp_block_offset, bp_block_size);
+		}
 	}
 }
 
-- 
2.25.1

