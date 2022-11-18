Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414A4C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 02:57:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB8AA10E6E7;
	Fri, 18 Nov 2022 02:57:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB5E10E6E7
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 02:57:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBao9SlfQTnnauS9IQG5ioXHXIpKORTLHk7dD3Q0JRwYurFep2aqq/6RjkL0BQ+/RPTLcPVTbuG6aC7N0qhJPu/iXACg+YuBkf74T9NLQ6BJm9uIJRpRjoxM5DdoG6DqnFz9KcNap56737v05UIF5Qq4ITXHw4Dk18B5qv83QVR6MoPJFCh7C0b4DQnmhxyjRMc/jB8YkDbKA9KKAOis0NkGB0ufECBOzbunKZ0ilAwTF4R6xcLr6kovJxsE8enHj0Lj7r3pYyp+k3dp7isb36673oSGsUiDubBBU/hm+oqA6rmOI68RORfsgbdEWFj6Y5yF0rPASrQUe3kbucxuZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YF2Jtv9kOK4Os2y84zPrWKq7igsXWbuhUsJuBBUbexQ=;
 b=FCXle4uc4DCjrLNd6Qik0j1vOQa4gwNfJ9vp1PeAlcmm2DykGm2MjIg7y+jf41kHslxBGzlJMr92WjJQNTmLB5GdCHu4rOSiopiSwOKvzh9KsAIICbgM3qh7LgFID4UGdA/7cu5CHueqXJjzgl/XBwe5lx2BNE8eIgJN+XWvps/d54E84XyiC+3wonAk0wB3OvavXq4tGAgLJlLFUH/x6aJ0xOY7sli9i3EkHuaXrgE7yQVwfDe07k8gE+DHxbzxnZJihMBkgVr3pAAywoHe5HKC1tOAmG6wCsueH3R5K2u3vgN0dS/2xSES8nEHF6QjGFIBr0Gb2SHUxkzM7O+wkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YF2Jtv9kOK4Os2y84zPrWKq7igsXWbuhUsJuBBUbexQ=;
 b=aZzkxIhJ+1oKnnIL4TsqNg9BkD1TBsXC4Y1ufHJqNpybHN8iCm7apcjr2V1+cZTNGQA8h7POZqrp8wQDvsip211lHxnUi1Gw5vN+Ll/Msrh3tmH9tMhMQflySnZ6xqXOsDA6sdlN+pEIYqmChePXr0wUcQq7OJiJxwS2bkyQ33w=
Received: from DS7PR03CA0213.namprd03.prod.outlook.com (2603:10b6:5:3ba::8) by
 SN7PR12MB6715.namprd12.prod.outlook.com (2603:10b6:806:271::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Fri, 18 Nov
 2022 02:56:55 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::7e) by DS7PR03CA0213.outlook.office365.com
 (2603:10b6:5:3ba::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Fri, 18 Nov 2022 02:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 02:56:55 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 17 Nov
 2022 20:56:51 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 17 Nov
 2022 18:56:19 -0800
Received: from amd-SYS-7048GR-TR.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Thu, 17 Nov 2022 20:56:11 -0600
From: Tong Liu01 <Tong.Liu01@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add drv_vram_usage_va for virt data exchange
Date: Fri, 18 Nov 2022 10:56:08 +0800
Message-ID: <20221118025608.612986-1-Tong.Liu01@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT060:EE_|SN7PR12MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: 128291b9-7ccb-451e-9a99-08dac9108d29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sMjRkhFQd4w8PROCuMcFQCtu/Qqh8fZXFG6ALofI5aTH9qLDbB0+NHjJ939VLVTZYwKA8pA+xX6JK5Vr6YQ0VUYVNBYybcRr2k8MHkhV0H6TOVcK4HfER37YH6ZSTnxDfMRwSmj72Zd+AyoyUp4634Nt3nY9Fq0LUfRuGBUrd8oBH2ND6DJS/d9VNOYGgHaH6H6JKJr0bw1GX8N5L9yeQIvtvUHtdUlZ4Ssu13cUaBgCvas/YAKQ1O53TondXINrBxOyD+auq3LbYiaVApPRiLJ7lbPIj8TlzFMofPaz54gRC6PMoaTqC8DZW/UtB2nrvE1ckhG0o9CQiHDd73QUcfsO1WwqpUhhh2F2SCKxhanlj2BrYkQVan2sZqZNP5ZOLKOUexY4z77iPTBgFXbeRDbheBnM1Sn+PF4gp0ciT10BDmUI5Qg45hmr5bxiqmfusATONkYX2l5RqLZAXThjrW6VaPXf6IXibGVW1GvSMtXXcjePOAthbqKYPTS/CGGLETe5kUh8WikhSsTqCJcU8OdlRTIe28Tv/3ex6qZGWc6oXV7gT6lBsa8HBp3wpq75AIaK68/Ync1Z5yZFS5ELzdEhtm9ArBqIgpIuQSbxIqZ52i4L5hnGUsoXHy16RH2za0ZnYchtzzoQVANInLNJtvZCP50GJPM0/PNpZ3+7jLdeQ7NKie7w6yrm0UKAdCaW+b5d4Ql32fjXCgNXGgmZb9Xt717ieONBE95OVXtkOa0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199015)(36840700001)(40470700004)(46966006)(26005)(82740400003)(82310400005)(356005)(36860700001)(83380400001)(81166007)(86362001)(40480700001)(478600001)(7696005)(4326008)(316002)(6916009)(8676002)(70206006)(6666004)(41300700001)(8936002)(54906003)(70586007)(5660300002)(40460700003)(426003)(2906002)(336012)(47076005)(2616005)(186003)(1076003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 02:56:55.0539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 128291b9-7ccb-451e-9a99-08dac9108d29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6715
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
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 16 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 59 +++++++++++++------
 4 files changed, 54 insertions(+), 29 deletions(-)

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
index 52f2282411cb..dd8b6a11db9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1570,7 +1570,7 @@ static void amdgpu_ttm_drv_reserve_vram_fini(struct amdgpu_device *adev)
 {
 	amdgpu_bo_free_kernel(&adev->mman.drv_vram_usage_reserved_bo,
 						  NULL,
-						  NULL);
+						  &adev->mman.drv_vram_usage_va);
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
index a226a6c48fb7..e80033e24d48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -428,11 +428,18 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
 	struct eeprom_table_record bp;
 	uint64_t retired_page;
 	uint32_t bp_idx, bp_cnt;
+	void *vram_usage_va = NULL;
+
+	if (adev->mman.fw_vram_usage_va != NULL) {
+		vram_usage_va = adev->mman.fw_vram_usage_va;
+	} else {
+		vram_usage_va = adev->mman.drv_vram_usage_va;
+	}
 
 	if (bp_block_size) {
 		bp_cnt = bp_block_size / sizeof(uint64_t);
 		for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
-			retired_page = *(uint64_t *)(adev->mman.fw_vram_usage_va +
+			retired_page = *(uint64_t *)(vram_usage_va +
 					bp_block_offset + bp_idx * sizeof(uint64_t));
 			bp.retired_page = retired_page;
 
@@ -643,7 +650,11 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 	adev->virt.fw_reserve.p_vf2pf = NULL;
 	adev->virt.vf2pf_update_interval_ms = 0;
 
-	if (adev->mman.fw_vram_usage_va != NULL) {
+	if (adev->mman.fw_vram_usage_va != NULL &&
+		adev->mman.drv_vram_usage_va != NULL) {
+		DRM_WARN("Currently fw_vram and drv_vram should not have values at the same time!");
+	} else if (adev->mman.fw_vram_usage_va != NULL ||
+		adev->mman.drv_vram_usage_va != NULL) {
 		/* go through this logic in ip_init and reset to init workqueue*/
 		amdgpu_virt_exchange_data(adev);
 
@@ -666,32 +677,42 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
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
+	if (adev->mman.fw_vram_usage_va != NULL ||
+		adev->mman.drv_vram_usage_va != NULL) {
+
+		if (adev->mman.fw_vram_usage_va != NULL) {
+			adev->virt.fw_reserve.p_pf2vf =
+				(struct amd_sriov_msg_pf2vf_info_header *)
+				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
+			adev->virt.fw_reserve.p_vf2pf =
+				(struct amd_sriov_msg_vf2pf_info_header *)
+				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
+		} else if (adev->mman.drv_vram_usage_va != NULL) {
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

