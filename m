Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F6C606A31E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 03:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=perh+33N
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B31510E072;
	Tue, 24 Nov 2026 03:27:03 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013048.outbound.protection.outlook.com
 [40.93.196.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B198310E072
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 03:26:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEk4lKzes8e7GFdeGoQLaD6iJalrmIefcp5LfC/C1EBt4FRm/meBwLxBrCLbCFyA9qnrvGm49rfLAcjV5GUI1HxY1rXmnVmTDpuW9XVLur0M9wf/7bpNB4uRVJMQXrLAkPGiKRk2BXDGIn9cSpOVw8ar3l72P0n/uKK+79VkhIBBxN7nbIpyh7t3/usNgP9JgY5bvGpVHJ1uWKyPl2HcxKdQeObMdfF5oa1KTgLqZgIvZBU55ElHuftTsD+/M2xBHvRJjekpVO91IjE7MpPnObikmmsAY48BJj75MOjOOoco0ewF7nbXBUDrZUFtbSLzZyVMH//hXVAAT32iyEKhOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqXxkL0I9NeiBzd8rMbI8OREyea5MF3JQJrDupHuZog=;
 b=lS3ZuEuJbPGMaGXae8q/LgjcNPyf9zM9GetZFTXjgrq3Pzg2jrFYW8HhF9K5QTOOul4YGpO9AV4ZXaDYOhVGZr45ociN2LRzwLvdZzojY/Bva4siRsmwhaKviytjYoD72pJn5GvPBCugRfjDdLCB07EEtBrMbi2lmvNRjq/K79qJM/2Xw35bn/S7h3BJ5lhDSK2Itq4pPMhGfr7T1Wb54Gn0GGfl4Fx2ORa0LCLD8Q4jUiZsQY6QVOFsf1P1PlD6L9aN6M9M+49UXih7VamxqpW04+BWYGI/rMFvSTLdWSPARgdvN7p4fFDzAqYeJQ79BnOuLtS6MQCuWInvsLM+9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqXxkL0I9NeiBzd8rMbI8OREyea5MF3JQJrDupHuZog=;
 b=perh+33Nq1hkVFLVoauwJoWC0MPmvYSUd44Eoz981SKxiGRg3qJflDh3gx43/6/2NGWFeT1fcOkvqz9QkvYXvABM3krj/h4z6OEFP+AV7JCG15Z44O4Ks1aXOi/f95AWcvyJQPvV4WepJXfrVhCjGjzbd12hRYyZmfEgZd2teOE=
Received: from CH0PR13CA0010.namprd13.prod.outlook.com (2603:10b6:610:b1::15)
 by DM4PR12MB6567.namprd12.prod.outlook.com (2603:10b6:8:8e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 03:26:52 +0000
Received: from CH2PEPF00016D4C.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::8d) by CH0PR13CA0010.outlook.office365.com
 (2603:10b6:610:b1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Tue, 24
 Nov 2026 03:26:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00016D4C.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 03:26:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 21:26:51 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 21:26:50 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Mon, 23 Nov 2026 21:26:49 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: enable traps for kernel queue VMIDs on GFX9
Date: Tue, 24 Nov 2026 11:26:30 +0800
Message-ID: <20261124032648.1977968-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00016D4C:EE_|DM4PR12MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ebaca76-4f6b-4016-60e1-08df49dac7fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|261026121527099003|261021123027099003|261021121427099003|10067099003|261102123227099003|11063799006|56012099006|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: Ki+MBL6it0rwpReqOgpgdj7UufiW6VkSA+VEvldL/CpDRiGCoigsiOKnEHhPXPte3q7LH3JAyziYeqL+PNx2qLsxr+1ZUPii4FYRA3zFFo3oA2DC4zprTPHWe+vlFsiMc/DcMjJJEIemE63WV/r4EiZuGuo8lnOV4AI3TZ5roqCAoXhJoWHnX++93mOhnlMYMXspunf3NOVL30pIrwgYu+Z+G5VRNWIfG5OHu01upA+K8KSrlEJUkNFggEqM+qCo3qVpDHLAz35ENml9LNCyafm8oQcYqOzNK3U6UYZtn/Cld93oY4ONPIpwXFjLSBMSEhbEq3PGe49Bgkz1g0hcG0q1PVfTFRrRq05zz/SXtq9fnpOXvNG9u/j7da/ip3fHImbR+lzEksDTj9PitblhoWrvl9MzI9aZaYp64e0vJg2nSa37Ox42U8Dtmt9QUncdTTN09vPW6ML6PLh4bRJXjR2Ofdm3BNcWPfUyyWzYih7ZYxPU53kt+uImF7ng8wCPM+MQeYptK+98fJefph+lUvWgzgUvAfi0FarUM1S4f5mPJ8fitkwYagKB4derbbLm2AoYHPcFy+lHtd2g4UGrxdMtf882G/IpaqvgdVSdS4+yrPXGrpYAboxjbpUcexy51ywcqh1lGJKbPaDF/hq1T4prPm+fXAKIl0TvDg/C5/Pm1DLgaZPpFpmYeruOYBGC3CW1TPLrCqYmBsUmFSHmIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(261026121527099003)(261021123027099003)(261021121427099003)(10067099003)(261102123227099003)(11063799006)(56012099006)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VEHZore+h30zZjPw5/tqjw0lzTVb/xJpIGKoYKRB1PDySWt4vWt0tpsm5Oc5YMwkeYn8kVDKXTefcL9lUOQpIy7izPnX3bE6Q/GhFaPfWBYjvoCZHRVu75W10ebm3vwoSw0VFfNSyj6cTiIevYDulq1/NrZPbZ50ZHp7MS/LddCEqVO9janMbejDS3p59V0eCMHzyawX4MuXeF3TYcM9ule7pmzQZ3NvEIS2GOFwMqH5Prm71eEvwfhwgTH3+O2f4elftEhOB0Y7OETcZxqweH/leMgyZDvN7sMkXDrsvLHkTIY19qpfNHQmtU0qSX7JEtZrnikyLwp2XYetl0znf7XXFu/L/dkHXpZSWfeNXEdRW2k6jFxnJKcT6G4+eyu0i8Wkm2sZdQgYFCMWWDs2nnE4SwPE6VMjUkxv2w4MGlLbBf6ksSAHwpK6nDuDg00d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 03:26:51.6179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebaca76-4f6b-4016-60e1-08df49dac7fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00016D4C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6567
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

GFX9 enables traps per VMID in SPI_GDBG_TRAP_CONFIG.VMID_SEL (or
SPI_GDBG_PER_VMID_CNTL on GFX 9.4.2), but only the user queue VMIDs are
enabled. So kernel queue jobs never enter the trap handler and an L2
trap handler set with AMDGPU_VM_OP_SET_L2_TRAP doesn't run for them.

Enable traps for every VMID except VMID 0, like GFX 9.4.3 already does.

Fixes: e259fae224e7 ("drm/amdgpu: Program trap TBA/TMA for kernel-managed VMIDs")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Change-Id: I40175d1fea21fccb42a4db54be86e5e7458c6ed9
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 15 +++++++++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c |  5 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h |  3 ++-
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index f8a5e9151483..3d8fd62fa269 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4064,11 +4064,17 @@ static int gfx_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	if (amdgpu_trap_is_supported(adev)) {
+		/*
+		 * Kernel queue VMIDs get the first-level TBA/TMA from the
+		 * gfxhub, enable traps for them as well as for the user queue
+		 * VMIDs.
+		 */
+		unsigned long vmid_mask = GENMASK(AMDGPU_NUM_VMID - 1, 1);
+
 		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
-			gfx_v9_4_2_debug_trap_config_init(adev);
+			gfx_v9_4_2_debug_trap_config_init(adev, vmid_mask);
 		else
-			gfx_v9_0_debug_trap_config_init(adev,
-							adev->vm_manager.vmid_uq_mask_gfxhub);
+			gfx_v9_0_debug_trap_config_init(adev, vmid_mask);
 	}
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) &&
@@ -4952,7 +4958,8 @@ static int gfx_v9_0_late_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
-		gfx_v9_4_2_debug_trap_config_init(adev);
+		gfx_v9_4_2_debug_trap_config_init(adev,
+			adev->vm_manager.vmid_uq_mask_gfxhub);
 	else
 		gfx_v9_0_debug_trap_config_init(adev,
 			adev->vm_manager.vmid_uq_mask_gfxhub);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index f54f54fe535e..612ced9754bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -836,14 +836,15 @@ void gfx_v9_4_2_init_sq(struct amdgpu_device *adev)
 	}
 }
 
-void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev)
+void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
+				       unsigned long vmid_mask)
 {
 	uint32_t data;
 	int i;
 
 	mutex_lock(&adev->srbm_mutex);
 
-	for_each_uq_gfx_vmid(i, adev) {
+	for_each_set_bit(i, &vmid_mask, AMDGPU_NUM_VMID) {
 		data = 0;
 		soc15_grbm_select(adev, 0, 0, 0, i, 0);
 		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
index ca240f4298da..c4d5055f01e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
@@ -24,7 +24,8 @@
 #ifndef __GFX_V9_4_2_H__
 #define __GFX_V9_4_2_H__
 
-void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev);
+void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
+				       unsigned long vmid_mask);
 void gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
 				      uint32_t die_id);
 void gfx_v9_4_2_init_sq(struct amdgpu_device *adev);
-- 
2.50.1

