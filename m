Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F8FC433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Nov 2022 08:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD08410E707;
	Fri,  4 Nov 2022 08:53:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5D8D10E707
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Nov 2022 08:53:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpFn2t7qE61KpEbp7Q3JOdzHTid/DeUEfg3HY9oOVRyJM7NI159R5ISdHRTkRewcrFyQz/6bfyhE73PmoYSbgTEobkpoOouLB5I22ce4VjLyRxyjTRRkXna2OfmglHxlr30IPltVRIIvpruy7Yp2mC8HNNR8eZlU3G6dXL5drqvejmh4LKmkiAnT5Ms+WoRkVEeUfl9Mg7WDtZT3bjAqyV5j6Yu+VGZkH6HHJYpgEw7kdbiGhVI3DMgP2Voys5N0EiSHK1l09s8fAXIoImZqxm/iofurieqUkUtSqgDxcC+9KSm2cbQduf8c62eCdevLgBJP9GaIi/ja6pNQCF2osA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krET5l9eD3C9ba+xBqQFY2PnbMFTY3CEosWIjcu806w=;
 b=VKFRZZYf/z3zV15NF3uvql2CCa+KvIWeoWyKwKrhE6hnYpnwTyDqReGKNCChJU721gnAuxlstpq38disybn+kgMXHXNwZL3UAXoktZG1V25WNwekDR2VmUcN5IKZx/bESQ5B6EIqQKX7oVRhtfZHBPPy9lEcs5euQpARrwa8tXiJJAmn2RLS36F7m8poT84WxmsYuCsnreBBgVmr8jiPtkG0SHOMp69oab/hZwOaoEhAwCp41wePpEQEJOlyAvzsdReIY7BRDKsjybcHWhKDo2foUkM6uDotE/8+9/gAilH92CqB9c1O2SWpTFtgO5DsMXsqdAccuT85Eot2xgL/JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krET5l9eD3C9ba+xBqQFY2PnbMFTY3CEosWIjcu806w=;
 b=YPkIzPTW3rMONBPyaI28iEg7vfvil9H2wDQz/PcldBzgCwgr3ZO7Wswr/jw2UIT7w/O+rTGRMXeRPDClzc3Xjut/a11ua+bZIgJ1z+6FH9trSC3AEXiAVxTIJtTGcDq4U2/7AkBQnrvwJ2saTaP7aytO6q6VtJcHG1UO0hNA/cA=
Received: from DM6PR03CA0046.namprd03.prod.outlook.com (2603:10b6:5:100::23)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.23; Fri, 4 Nov
 2022 08:52:59 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::90) by DM6PR03CA0046.outlook.office365.com
 (2603:10b6:5:100::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Fri, 4 Nov 2022 08:52:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Fri, 4 Nov 2022 08:52:59 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 03:52:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 01:52:48 -0700
Received: from amd-SYS-7048GR-TR.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31
 via Frontend Transport; Fri, 4 Nov 2022 03:52:45 -0500
From: Tong Liu01 <Tong.Liu01@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add vram reservation logic based on
 vram_usagebyfirmware_v2_2
Date: Fri, 4 Nov 2022 16:52:42 +0800
Message-ID: <20221104085242.11071-1-Tong.Liu01@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT096:EE_|DM4PR12MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: 46fe1db5-fc1a-46b9-6d38-08dabe41f9ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XqfE/Eeo9ZLHQ1bU3yz9xSijNp6uZBOgMzxNLSx/sV0s1MFV1A4QFXntuLaUpYF35rca+S+ksS0F2khoBOqNElnLzNNirok5cH2MRL6yKclvcdcaVIJzgOgU6JlwT13ppErm9aBosEwbnvyg6v3EEG8FdFd+yhmRrZjiqkEElvS2XFb3/N+h9hpgV8MDOPc82DT+0c0QAsJd44ekXc052O/v5KztRHj/UNhPEya7Ewp1nZsGh5E0thRa0MoN6axjDdLy9x/4o1l240uxb3q5dDlRAtK6Ri1spq7Z34tI44YP7cs+c1drr0ufT9N657PtFu1iKdldCvxiOwF1FcK9W8jH6QKwpiyospSBSSg4C7i3+5G+SJjHKiEn60cJUAMinus/t+pMubOG+cQC+W7T1RWAlyChoptemqk5Yi9UqMFKcyVP3uEWhbIrvpLRpnWOMg1OueDNddoxhjgPQVPQNBRDzPCvfiPc3H5yKDYOM95+scs00g4ZdyDx8VapVRbaE+GJ0lGhj7EBEriE3pKXglg1bqoiLLURsX2+FrpSMnBoPhkykvdb01pFS9jIC6vE17hbSNmFjfYe+82dPZoqMVLSAw/CBBq8scOnSeg150dJ9r5u+x6oQddYPUOvwvDtjF9xshyO1dUVx2+smxeVbi8PeGLWo+PtmNgxZhe75w3aRRYK6Ag5jmlGKmXAKqfvDvK2gZzZcYWbHCra4/3Cr6NPMIzL54ogHO1T/j5jZM9upSLLj+DtDK7WcGcbqs0/vUcBQjomzgl0re2dEayrbR8U9t1krlhf/XY4prSckjs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199015)(46966006)(36840700001)(40470700004)(336012)(47076005)(54906003)(83380400001)(86362001)(426003)(6916009)(6666004)(7696005)(26005)(186003)(2616005)(316002)(82740400003)(1076003)(478600001)(70206006)(8676002)(70586007)(36860700001)(4326008)(40460700003)(2906002)(30864003)(356005)(8936002)(81166007)(41300700001)(5660300002)(36756003)(82310400005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 08:52:59.6700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fe1db5-fc1a-46b9-6d38-08dabe41f9ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Tong Liu01 <Tong.Liu01@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move TMR region from top of FB to 2MB for FFBM, so we need to reserve TMR region
firstly to make sure TMR can be allocated at 2MB

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 84 ++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 52 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  6 ++
 drivers/gpu/drm/amd/include/atomfirmware.h    | 56 +++++++++++--
 4 files changed, 171 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index b81b77a9efa6..f577b1d151d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -106,34 +106,74 @@ int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)
 	struct atom_context *ctx = adev->mode_info.atom_context;
 	int index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 						vram_usagebyfirmware);
-	struct vram_usagebyfirmware_v2_1 *firmware_usage;
-	uint32_t start_addr, size;
+	struct vram_usagebyfirmware_v2_1 *firmware_usage_v2_1;
+	struct vram_usagebyfirmware_v2_2 *firmware_usage_v2_2;
+	uint32_t start_addr, size, fw_start_addr, fw_size, drv_addr, drv_size;
 	uint16_t data_offset;
+	uint8_t frev, crev;
 	int usage_bytes = 0;
 
-	if (amdgpu_atom_parse_data_header(ctx, index, NULL, NULL, NULL, &data_offset)) {
-		firmware_usage = (struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
-		DRM_DEBUG("atom firmware requested %08x %dkb fw %dkb drv\n",
-			  le32_to_cpu(firmware_usage->start_address_in_kb),
-			  le16_to_cpu(firmware_usage->used_by_firmware_in_kb),
-			  le16_to_cpu(firmware_usage->used_by_driver_in_kb));
-
-		start_addr = le32_to_cpu(firmware_usage->start_address_in_kb);
-		size = le16_to_cpu(firmware_usage->used_by_firmware_in_kb);
-
-		if ((uint32_t)(start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
-			(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
-			ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
-			/* Firmware request VRAM reservation for SR-IOV */
-			adev->mman.fw_vram_usage_start_offset = (start_addr &
-				(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
-			adev->mman.fw_vram_usage_size = size << 10;
-			/* Use the default scratch size */
+	if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_offset)) {
+		if (frev == 2 && crev == 1) {
+			firmware_usage_v2_1 =
+				(struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
+			DRM_DEBUG("atom firmware v2_1 requested %08x %dkb fw %dkb drv\n",
+			  le32_to_cpu(firmware_usage_v2_1->start_address_in_kb),
+			  le16_to_cpu(firmware_usage_v2_1->used_by_firmware_in_kb),
+			  le16_to_cpu(firmware_usage_v2_1->used_by_driver_in_kb));
+
+			start_addr = le32_to_cpu(firmware_usage_v2_1->start_address_in_kb);
+			size = le16_to_cpu(firmware_usage_v2_1->used_by_firmware_in_kb);
+
+			if ((uint32_t)(start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
+				(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
+				ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
+				/* Firmware request VRAM reservation for SR-IOV */
+				adev->mman.fw_vram_usage_start_offset = (start_addr &
+					(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
+				adev->mman.fw_vram_usage_size = size << 10;
+				/* Use the default scratch size */
+				usage_bytes = 0;
+			} else {
+				usage_bytes =
+					le16_to_cpu(firmware_usage_v2_1->used_by_driver_in_kb) << 10;
+			}
+		} else if (frev >= 2 && crev >= 2) {
+			firmware_usage_v2_2 =
+				(struct vram_usagebyfirmware_v2_2 *)(ctx->bios + data_offset);
+			DRM_DEBUG("atom requested fw start at %08x %dkb and drv start at %08x %dkb\n",
+			  le32_to_cpu(firmware_usage_v2_2->fw_region_start_address_in_kb),
+			  le16_to_cpu(firmware_usage_v2_2->used_by_firmware_in_kb),
+			  le32_to_cpu(firmware_usage_v2_2->driver_region0_start_address_in_kb),
+			  le32_to_cpu(firmware_usage_v2_2->used_by_driver_region0_in_kb));
+
+			if ((uint32_t)((le32_to_cpu(firmware_usage_v2_2->fw_region_start_address_in_kb))
+				& (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
+				fw_start_addr = (le32_to_cpu(firmware_usage_v2_2->fw_region_start_address_in_kb))
+					& (~ATOM_VRAM_OPERATION_FLAGS_MASK);
+				fw_size = le16_to_cpu(firmware_usage_v2_2->used_by_firmware_in_kb);
+
+				/* Firmware request VRAM reservation for SR-IOV */
+				adev->mman.fw_vram_usage_start_offset = fw_start_addr << 10;
+				adev->mman.fw_vram_usage_size = fw_size << 10;
+			}
+
+			if ((uint32_t)((ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)
+				& (le32_to_cpu(firmware_usage_v2_2->driver_region0_start_address_in_kb))) == 0) {
+				drv_addr = (le32_to_cpu(firmware_usage_v2_2->driver_region0_start_address_in_kb))
+					& (~ATOM_VRAM_OPERATION_FLAGS_MASK);
+				drv_size = le32_to_cpu(firmware_usage_v2_2->used_by_driver_region0_in_kb);
+
+				/* driver request VRAM reservation for SR-IOV */
+				adev->mman.drv_vram_usage_start_offset = drv_addr << 10;
+				adev->mman.drv_vram_usage_size = drv_size << 10;
+			}
+
 			usage_bytes = 0;
-		} else {
-			usage_bytes = le16_to_cpu(firmware_usage->used_by_driver_in_kb) << 10;
+
 		}
 	}
+
 	ctx->scratch_size_bytes = 0;
 	if (usage_bytes == 0)
 		usage_bytes = 20 * 1024;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 585460ab8dfd..099605380b06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1578,6 +1578,22 @@ static void amdgpu_ttm_fw_reserve_vram_fini(struct amdgpu_device *adev)
 		NULL, &adev->mman.fw_vram_usage_va);
 }
 
+/*
+ * Driver Reservation functions
+ */
+/**
+ * amdgpu_ttm_drv_reserve_vram_fini - free drv reserved vram
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * free drv reserved vram if it has been reserved.
+ */
+static void amdgpu_ttm_drv_reserve_vram_fini(struct amdgpu_device *adev)
+{
+	amdgpu_bo_free_kernel(&adev->mman.drv_vram_usage_reserved_bo,
+		NULL, &adev->mman.drv_vram_usage_va);
+}
+
 /**
  * amdgpu_ttm_fw_reserve_vram_init - create bo vram reservation from fw
  *
@@ -1604,6 +1620,32 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
 					  &adev->mman.fw_vram_usage_va);
 }
 
+/**
+ * amdgpu_ttm_drv_reserve_vram_init - create bo vram reservation from driver
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * create bo vram reservation from drv.
+ */
+static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
+{
+	uint64_t vram_size = adev->gmc.visible_vram_size;
+
+	adev->mman.drv_vram_usage_va = NULL;
+	adev->mman.drv_vram_usage_reserved_bo = NULL;
+
+	if (adev->mman.drv_vram_usage_size == 0 ||
+	    adev->mman.drv_vram_usage_size > vram_size)
+		return 0;
+
+	return amdgpu_bo_create_kernel_at(adev,
+					  adev->mman.drv_vram_usage_start_offset,
+					  adev->mman.drv_vram_usage_size,
+					  AMDGPU_GEM_DOMAIN_VRAM,
+					  &adev->mman.drv_vram_usage_reserved_bo,
+					  &adev->mman.drv_vram_usage_va);
+}
+
 /*
  * Memoy training reservation functions
  */
@@ -1771,6 +1813,15 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	/*
+	 *The reserved vram for driver must be pinned to the specified
+	 *place on the VRAM, so reserve it early.
+	 */
+	r = amdgpu_ttm_drv_reserve_vram_init(adev);
+	if (r) {
+		return r;
+	}
+
 	/*
 	 * only NAVI10 and onwards ASIC support for IP discovery.
 	 * If IP discovery enabled, a block of memory should be
@@ -1896,6 +1947,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
 					&adev->mman.sdma_access_ptr);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
+	amdgpu_ttm_drv_reserve_vram_fini(adev);
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 9120ae80ef52..c60246f32f98 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -92,6 +92,12 @@ struct amdgpu_mman {
 	struct amdgpu_bo	*fw_vram_usage_reserved_bo;
 	void		*fw_vram_usage_va;
 
+	/* driver VRAM reservation */
+	u64		drv_vram_usage_start_offset;
+	u64		drv_vram_usage_size;
+	struct amdgpu_bo	*drv_vram_usage_reserved_bo;
+	void		*drv_vram_usage_va;
+
 	/* PAGE_SIZE'd BO for process memory r/w over SDMA. */
 	struct amdgpu_bo	*sdma_access_bo;
 	void			*sdma_access_ptr;
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index ff855cb21d3f..9f8761407099 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -705,10 +705,47 @@ struct atom_gpio_pin_lut_v2_1
 };
 
 
-/* 
-  ***************************************************************************
-    Data Table vram_usagebyfirmware  structure
-  ***************************************************************************
+/*
+  VBIOS/PRE-OS always reserve a FB region at the top of frame buffer. driver should not write access that region.
+  driver can allocate their own reservation region as long as it does not overlap firwmare's reservation region.
+  if( atom data table firmwareInfoTable version < 3.3) { //( pre-NV1X )
+    in this case, atom data table vram_usagebyfirmwareTable version always <= 2.1
+    if( VBIOS/UEFI GOP is posted ) {
+      VBIOS/UEFIGOP update used_by_firmware_in_kb = total reserved size by VBIOS
+      update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;  ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10)
+      driver can allocate driver reservation region under firmware reservation,
+      used_by_driver_in_kb = driver reservation size
+      driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
+    Comment1[hchan]: There is only one reservation at the beginning of the FB reserved by Host driver.
+    Host driver would overwrite the table with the following
+    used_by_firmware_in_kb = total reserved size for pf-vf info exchange and
+    set SRIOV_MSG_SHARE_RESERVATION mask start_address_in_kb = 0
+    } else {
+      there is no VBIOS reservation region
+      driver must allocate driver reservation region at top of FB.
+      driver set used_by_driver_in_kb = driver reservation size
+      driver reservation start address =  (total_mem_size_in_kb - used_by_driver_in_kb)
+      same as Comment1
+    }
+  } else { //( NV1X and after)
+    if( VBIOS/UEFI GOP is posted ) {
+      VBIOS/UEFIGOP update used_by_firmware_in_kb = atom_firmware_Info_v3_3.fw_reserved_size_in_kb;
+      update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;  ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10  )
+    }
+    if( vram_usagebyfirmwareTable version <= 2.1 ) {
+      driver can allocate driver reservation region under firmware reservation,
+      driver set used_by_driver_in_kb = driver reservation size
+      driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
+      same as Comment1
+    } else {
+      dirver can allocate it reservation any place as long as it does overlap pre-OS FW reservation area
+      driver set used_by_driver_region0_in_kb = driver reservation size
+      driver set driver_region0_start_address_in_kb =  driver reservation region start address
+      Comment2[hchan]: Host driver can set used_by_firmware_in_kb and start_address_in_kb to zero
+      as the reservation for VF as it doesn’t exist.  And Host driver should also
+      update atom_firmware_Info table to remove the same VBIOS reservation as well.
+    }
+  }
 */
 
 struct vram_usagebyfirmware_v2_1
@@ -716,9 +753,18 @@ struct vram_usagebyfirmware_v2_1
   struct  atom_common_table_header  table_header;
   uint32_t  start_address_in_kb;
   uint16_t  used_by_firmware_in_kb;
-  uint16_t  used_by_driver_in_kb; 
+  uint16_t  used_by_driver_in_kb;
 };
 
+struct vram_usagebyfirmware_v2_2{
+  struct  atom_common_table_header  table_header;
+  uint32_t  fw_region_start_address_in_kb;
+  uint16_t  used_by_firmware_in_kb;
+  uint16_t  reserved;
+  uint32_t  driver_region0_start_address_in_kb;
+  uint32_t  used_by_driver_region0_in_kb;
+  uint32_t  reserved32[7];
+};
 
 /* 
   ***************************************************************************
-- 
2.25.1

