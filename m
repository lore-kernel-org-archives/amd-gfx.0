Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76667C44539
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2026 08:17:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D712310ECD8;
	Wed, 22 Jul 2026 08:17:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yUzU5hvd";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D35B310ECCA
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2026 08:17:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYiqnKwLETodTCVQIhtmKh3Eh2gDpnQekk4Fap6/4VEYn1BV5b8oirQkpMNhqhiUKmFXAIyrxFA2vNBgXSw9xucwKxnwjB6P4iVhAPhYvtTjNF5w1eXMWh3H7DCo6qw67FtJX2rCzXQgWCvQeVtiG3xXLCaeUEuxpjBGJCVt+3jtYSJsboFh5nRpwMGDhJcMK8uUEdAC7YdaZGVV3d1nElH0BW94VPEvMCrH6mGL9wOHxXb7R47ImuIaA/Qv/y4tLkdeWhUN/55aXT5Sdt9utvD4maxCwFUuBqp3ka3Qb7tLi2dcBy2zUeqv8SfudvHXrADkTRQwOqKZpjhH7em42w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDKd8EM/DxlVTSpSVWoHfOfUGKBY7a20XZ6ZZsTXbMo=;
 b=KtYKCW3dmotri8fy/mLUzc1qYsgK6PSOfinsxAdmMKGiZB79ey/P4cE2OmeB3ZoX6hrASHtR0npUBJT0e5mEWN0uFbKS9Qu3gtwnJi+/7k4OdMflTiipvK36toCkxk8l0pdAeKDDpVmeYSkVmOfQl1FC15PPchWwWI4XKD1jNhuN45jykX2nphBQgKgSPlMPXLLUTCHvkbMAS3Uv10J4w98qAJMinzHymp1vtd1bdc4iqJc7MN8xRzv2R33dI1Fhqdg8lQ+EXLDVOECGux0OS7IgvqY4KBnuzc8t0crRsqeZQ6ahlggHNuAAqLB4qMGYsMgJcuxrdLo0M/i6FmRoRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDKd8EM/DxlVTSpSVWoHfOfUGKBY7a20XZ6ZZsTXbMo=;
 b=yUzU5hvdui293K8dqtAk01PRz6AXDpI6BmHuLRjKbLyJ9bP5LyTYT/WAV3fLhr08J/zVmQTcyJvrIZ324s4tPR0CMBQOmjCPCZmla6q3Ff8jntUSZlNkQFSG23pkdgUPD+VggU28+YZ1t85Rq3ktQsqsdT2ajSFCf+2aP0R1m5g=
Received: from CH5P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::18)
 by SJ2PR12MB8941.namprd12.prod.outlook.com (2603:10b6:a03:542::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Wed, 22 Jul
 2026 08:17:46 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::1d) by CH5P222CA0022.outlook.office365.com
 (2603:10b6:610:1ee::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 08:17:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 08:17:45 +0000
Received: from shubhankar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 22 Jul 2026 03:17:42 -0500
From: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Mario.Limonciello@amd.com>,
 <Sunil.Khatri@amd.com>, <Arunpravin.PaneerSelvam@amd.com>
CC: <Veerabadhran.Gopalakrishnan@amd.com>, <Pratik.Vishwakarma@amd.com>,
 Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Enable support for PSP 15_0_5
Date: Wed, 22 Jul 2026 13:47:16 +0530
Message-ID: <20260722081727.1691277-1-Shubhankar.MilindSardeshpande@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|SJ2PR12MB8941:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e76811f-b85a-4551-ef93-08dee7c9b5e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|6133799003|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: Wy/sBkM2nWK1xM0VXL1XSUg+G/rvRjaLYr+H49T6/l/ULSXHT1XGe47J4aZs/YF7nj99uI1DBBbDaoI2xUZ07NZiD2YccfRicdb7eBdty4xxdEWKtyYv1kpCUj/Phxfz8TI+4YaOADY0x2x4ox13L+QPDFrT5IlB9a4X37w/Fno7aBCmI5HVASbt2jlYftJC3kuUVqDLSWiR/RSXWUXOLmSplnadwQlx7GiHzJ5bQQdpFHCChotZR/Osdefvk3JsxYzXjM+HABLZWVUMq6OQ9yb/hmHuJnXWnX3HZfbm2ubOo9pkmfPluHk98egUIHeiPkBkc6NS8lPdtGILCHBjGFafjgldVrANNLN/LamzQtZjyJTOh+fR0LhbkLjjT65FOgIpOuFo2mtfr5kInFZuRkjySSBpIIf9GNRcXUAc78eeB2cQvkuxn6JSZ0tDuycdOujCajhoUFBn+P8RQW6KFaBQEcTFcKj1pd05eMUBJFi8cXcdPIqK2O6Le3hq9MtiHj8Lt+Ihjas1p9vuLXXkbfKZqoXLXYh8R9uUfg38oItEMvr7qn6hNv0csaQBRC7SRHNfurUChSlDSiOmoQ2tWVLwgFN5UL9kp9y0k/paBakta1o6B5EjmvfdDSCIz5oSZ4WRQeDKVUczoxpQwGnTkw0suS5Pgdfbro5PqKHLmr1ZNTtgdjJ3+ipA/1ligHimm53aIVgdYLBcUxqXOfzIKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 724zmWHM/p9XDOMj4CbyuIbjeX0Oj9+jCfp1G+Pq9qJgoEaivy0hhD4yQd4QXq9O27wlo6lIy75JBnn67uv2LVchLPVGo6DS4USgfyNwozLwfktsCnHFJLIFKccj5Bc37mzmx/ELC72384d95LYb9nHtMNtI4nImamv8N0h9XHLqI5KXoNuKq7kKrsIv8Z13U7EGE5+07Ej09Jtb7YxK4R8n0ghwEdZ73Z1rYLrg22Zjvv6NV3TFtAaqNxsB622GNacS9wKGTEb+XlrkKdrCtG2317uKmnKlNXIGtrn4umCokeblohrWE1R6Yirb6eW/FAjOxpv5NQBcwTY38IgdoZ8k9tlghncswrSbPFlBhUzfMLcQL9EGdtUD0vKjFW1A/7curNQVDepeR7Nw1jqmr/33TQ6TtBrexSnx8ax/+FScJ+uUjPYeul+1pAJVx59L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 08:17:45.9035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e76811f-b85a-4551-ef93-08dee7c9b5e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8941
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
index 2a4d91368ac6..f4ace98171bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
@@ -31,8 +31,21 @@
 #include "mp/mp_15_0_0_offset.h"
 #include "mp/mp_15_0_0_sh_mask.h"
 
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
 MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_15_0_5_toc.bin");
+MODULE_FIRMWARE("amdgpu/psp_15_0_5_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta.bin");
 
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

