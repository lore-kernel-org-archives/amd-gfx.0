Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75426C4453A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2026 10:16:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DD1810E415;
	Wed, 22 Jul 2026 10:16:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ia/bVyJq";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011059.outbound.protection.outlook.com [52.101.62.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBCAD10E415
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2026 10:16:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvZmehGpyXGPXZJzALZPbU1LNVHmmwCzBFqR11jp/Ok4W3yyKdV0QaXJM3IEYj/6cnVtBVp7ZDEc/Uu0IKM3lxKEJkKAW99rK7KXjcecO0Vo1Vk1ZIrZKYagGhsJh8kmisOL6gA9pQSs6XeDs/yz10sHwxxVNkyHOehKGh3W5sdnqmE9O13orAGBsAOl5Y3JTm4pe1XTOkpGTGp/Qq/VF33ds9zfvZn2YQyGXn7m6wngKmzT6Zi3O0gVswNNN2VZt32TiFm8JHX0ShMPMQWqGfUQrKxKsIao4gewvATJha6K6GM0/LW9OVtzIl2oFXQ5VULRVyjlxf2bh9+PWF+4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzwnWbPHBf2+dQPDwK2XFg7xaeHcHTp6QmcGE4yMPiY=;
 b=C09LaRc3KUu+GM8lTkRdAv1QI7X1fNRt2FBoFP31CB5FxEiFY1rKJNW/pbtuzZJEbGgzuttPBXBfDy5GMehFVjLPnDqg7dp4IXEWg5UOYRNA2LIyeiE3AkqZHmcE7aE1Qm1uv/X275LasCTUuOyA2O6R9qShMHB2DbCROlHcyH6peg0CibLsLJuEcKRI1l/+X3cCs0t+OZ3dB0qK+CQk9DbpdSaa2esQhnNLF9XvNmG8votf1oqTvzSV5xatZBLeHX9gy5F5nOOOCcIEcPXxqury/IqlfXaMq7BHpcBV67Tt51waMCyxVtmj46YU/AhXA8xXGkiNrfqz6HhUFzsEmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzwnWbPHBf2+dQPDwK2XFg7xaeHcHTp6QmcGE4yMPiY=;
 b=ia/bVyJqKEmyGZIV1Z6bTzyo2v0ur4iRCarkRgDxHZ62vcH1525DBX3VM3Gfqsyu6iTh83Zt02ve9fVs48aRXBrbgrw7MdqucZYf81RDRrCWWiS6lFi4eULZLOrOxW9iST/JUNi7HOYU1WPu8d6yW41He9syLDA5hkdg9mBADfk=
Received: from MN2PR22CA0004.namprd22.prod.outlook.com (2603:10b6:208:238::9)
 by MW6PR12MB8757.namprd12.prod.outlook.com (2603:10b6:303:239::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 10:16:40 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::37) by MN2PR22CA0004.outlook.office365.com
 (2603:10b6:208:238::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 10:16:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 10:16:39 +0000
Received: from shubhankar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 22 Jul 2026 05:16:36 -0500
From: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
To: <Alexander.Deucher@amd.com>, <Mario.Limonciello@amd.com>,
 <Christian.Koenig@amd.com>, <Sunil.Khatri@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
Subject: [PATCH V2 1/2] drm/amdgpu: Enable support for PSP 15_0_5
Date: Wed, 22 Jul 2026 15:44:04 +0530
Message-ID: <20260722101555.2092421-1-Shubhankar.MilindSardeshpande@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|MW6PR12MB8757:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c0f0fe2-10aa-4993-1f9d-08dee7da51df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|6133799003|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: zO1CUW/d0kQ+1MlJr7459w5miwiHEVKc6T71SOTfP8hfTLH7LYyXiQLXPOjyPf1abiPtbG6XzSX2QS7pUu2j+iu/3DKE5otNhNLkTw2s7Hq/p7ZedTxYrybuevMos0UGiqMAt+s4cff4KawGqb0kwn/dDys0QPJ0LsF2wC3kI3ykInzZoLmDAypUnZ+SeZ04aNGhfIOpD9SksFXI38uNGqJEGMAVW9hL5Ww994VXRK1aAToO4m4IISKaxp3y8X6z2/08KoNtILtdPUJ/UGbQbItNraHPFlL3l5eBji9qe/gxMwNCD7KzPNrYGGoIYMqCflVp5GfHp6jbuUXmaBogpBfW6F8zRiWVilHgg4v04KirWMx4rPPrnIdk9nIWrf/DyNjAB7ZV8//n7xlDcfK0ehdpIhKg+oLuZQH+Jws3d46gheqHKcyd4MM9PxAb4G1hGLDKMlvmVCKo/dSIk/rIu1OnCZ9IAxj4S3dE5Ug8eVVfSMjjxdfDloRq31TpQYFZuq7LdmHJZkCzQXV/zibA4vo8nk3A8qFoQl8vIO0t0GH35y3OzeTlbNNd8JbrxMgJNc4DFiO1ObltmZnvH/zg3j9PWOb83WkaacICn1SGQP+T8vun9QC1Yl8rQU6bY9bNtx08Wo6KQsma4evjC9dVDpgRQ/VcN7PdXTAi5NhW011/xXCt0SXyln5PvSie0cddeZsCZOYUJroXzuJCqyqnww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UrZ7wVQsQNSWgO9xlNnXYrSimyuoUmZ3ZgCQ+Y2nbMbWzL1VKBpiAII+kpWjWIOK8hMzLl+tuBNa2BIKN0oEqmvqgCrZpNmHatkQuxJI2OEFC1JGLobKRW1zlALDsAcIjL+W27M7F4h/aIg2FQa5rEXNoipr3ZpetiA7y6PkSApjBp3aGIYX+/3z/fcHwQ7fiMAglzWIjaoqVmU84IKXzMD8bf/v7htBh6hFKenMpNeDzc6721MTsmm1nZeH99VENORURfRazpJZ/wB/U8Pj56f9OXyl/UCVXJBHAaE8bOjnVt65G5qmaMQr+s2TxoF0mGXZXBlIKO0SaLQoWdm0NDbBxloj2ceoKAguJaNHwPFnlZH+2vYpxiijh8gL4ARAEngp7O5px37CJAJJHQFr/+kxpmgDoxgLDmUTIgEsaDjgBVYAVfrt45oUvMnutzcp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 10:16:39.5163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0f0fe2-10aa-4993-1f9d-08dee7da51df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8757
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

Add PSP 15.0.5 related offsets for GFX to KMD interface
and enable support for it.

Co-developed-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Signed-off-by: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  5 +-
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c        | 93 ++++++++++++++++---
 3 files changed, 83 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 44e7d2e3e6df..f9f3e5ddcbe7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2530,6 +2530,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(15, 0, 0):
 	case IP_VERSION(15, 0, 9):
+	case IP_VERSION(15, 0, 5):
 		amdgpu_device_ip_block_add(adev, &psp_v15_0_ip_block);
 		break;
 	case IP_VERSION(15, 0, 8):
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index fdcba94ec0d1..3e49af8414ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -276,6 +276,7 @@ static int psp_early_init(struct amdgpu_ip_block *ip_block)
 		break;
 	case IP_VERSION(15, 0, 0):
 	case IP_VERSION(15, 0, 9):
+	case IP_VERSION(15, 0, 5):
 		psp_v15_0_0_set_psp_funcs(psp);
 		psp->boot_time_tmr = false;
 		break;
@@ -3509,7 +3510,9 @@ static int psp_load_non_psp_fw(struct psp_context *psp)
 		     amdgpu_ip_version(adev, MP0_HWIP, 0) ==
 			     IP_VERSION(15, 0, 8) ||
 		     amdgpu_ip_version(adev, MP0_HWIP, 0) ==
-			     IP_VERSION(15, 0, 9)) &&
+			     IP_VERSION(15, 0, 9) ||
+			amdgpu_ip_version(adev, MP0_HWIP, 0) ==
+			     IP_VERSION(15, 0, 5)) &&
 		    (ucode->ucode_id == AMDGPU_UCODE_ID_SDMA1 ||
 		     ucode->ucode_id == AMDGPU_UCODE_ID_SDMA2 ||
 		     ucode->ucode_id == AMDGPU_UCODE_ID_SDMA3))
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
index 2a4d91368ac6..abaa40b6def9 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
@@ -33,9 +33,22 @@
 
 MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_15_0_5_toc.bin");
+MODULE_FIRMWARE("amdgpu/psp_15_0_5_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta.bin");
 
+#define regMPASP_PCRU0_MPASP_C2PMSG_64                                         0x4280
+#define regMPASP_PCRU0_MPASP_C2PMSG_64_BASE_IDX                                2
+#define regMPASP_PCRU0_MPASP_C2PMSG_67                                         0x4283
+#define regMPASP_PCRU0_MPASP_C2PMSG_67_BASE_IDX                                2
+#define regMPASP_PCRU0_MPASP_C2PMSG_69                                         0x4285
+#define regMPASP_PCRU0_MPASP_C2PMSG_69_BASE_IDX                                2
+#define regMPASP_PCRU0_MPASP_C2PMSG_70                                         0x4286
+#define regMPASP_PCRU0_MPASP_C2PMSG_70_BASE_IDX                                2
+#define regMPASP_PCRU0_MPASP_C2PMSG_71                                         0x4287
+#define regMPASP_PCRU0_MPASP_C2PMSG_71_BASE_IDX                                2
+
 static int psp_v15_0_0_init_microcode(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
@@ -71,14 +84,25 @@ static int psp_v15_0_0_ring_stop(struct psp_context *psp,
 		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_101),
 				   0x80000000, 0x80000000, false);
 	} else {
-		/* Write the ring destroy command*/
-		WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64,
-			     GFX_CTRL_CMD_ID_DESTROY_RINGS);
-		/* there might be handshake issue with hardware which needs delay */
-		mdelay(20);
-		/* Wait for response flag (bit 31) */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64),
-				   0x80000000, 0x80000000, false);
+		if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(15, 0, 5)) {
+				/* Write the ring destroy command*/
+			WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_64,
+					GFX_CTRL_CMD_ID_DESTROY_RINGS);
+			/* there might be handshake issue with hardware which needs delay */
+			mdelay(20);
+			/* Wait for response flag (bit 31) */
+			ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_64),
+					0x80000000, 0x80000000, false);
+			} else {
+				/* Write the ring destroy command*/
+				WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64,
+						GFX_CTRL_CMD_ID_DESTROY_RINGS);
+				/* there might be handshake issue with hardware which needs delay */
+				mdelay(20);
+				/* Wait for response flag (bit 31) */
+				ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64),
+						0x80000000, 0x80000000, false);
+		}
 	}
 
 	return ret;
@@ -118,14 +142,44 @@ static int psp_v15_0_0_ring_create(struct psp_context *psp,
 				   0x80000000, 0x8000FFFF, false);
 
 	} else {
-		/* Wait for sOS ready for ring creation */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64),
-				   0x80000000, 0x80000000, false);
+		if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(15, 0, 5)) {
+			/* Wait for sOS ready for ring creation */
+			ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_64),
+					0x80000000, 0x80000000, false);
 		if (ret) {
 			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
 			return ret;
 		}
 
+		/* Write low address of the ring to C2PMSG_69 */
+		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_69, psp_ring_reg);
+		/* Write high address of the ring to C2PMSG_70 */
+		psp_ring_reg = upper_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_70, psp_ring_reg);
+		/* Write size of ring to C2PMSG_71 */
+		psp_ring_reg = ring->ring_size;
+		WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_71, psp_ring_reg);
+		/* Write the ring initialization command to C2PMSG_64 */
+		psp_ring_reg = ring_type;
+		psp_ring_reg = psp_ring_reg << 16;
+		WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_64, psp_ring_reg);
+
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+
+		/* Wait for response flag (bit 31) in C2PMSG_64 */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_64),
+				   0x80000000, 0x8000FFFF, false);
+		} else {
+			/* Wait for sOS ready for ring creation */
+			ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64),
+					   0x80000000, 0x80000000, false);
+			if (ret) {
+				DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
+				return ret;
+			}
+
 		/* Write low address of the ring to C2PMSG_69 */
 		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
 		WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_69, psp_ring_reg);
@@ -146,6 +200,7 @@ static int psp_v15_0_0_ring_create(struct psp_context *psp,
 		/* Wait for response flag (bit 31) in C2PMSG_64 */
 		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64),
 				   0x80000000, 0x8000FFFF, false);
+		}
 	}
 
 	return ret;
@@ -176,8 +231,12 @@ static uint32_t psp_v15_0_0_ring_get_wptr(struct psp_context *psp)
 
 	if (amdgpu_sriov_vf(adev))
 		data = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_102);
-	else
-		data = RREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_67);
+	else {
+		if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(15, 0, 5))
+			data = RREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_67);
+		else
+			data = RREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_67);
+		}
 
 	return data;
 }
@@ -190,8 +249,12 @@ static void psp_v15_0_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
 		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_102, value);
 		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_101,
 			     GFX_CTRL_CMD_ID_CONSUME_CMD);
-	} else
-		WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_67, value);
+	} else {
+		if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(15, 0, 5))
+			WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_67, value);
+		else
+			WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_67, value);
+	}
 }
 
 static const struct psp_funcs psp_v15_0_0_funcs = {
-- 
2.43.0

