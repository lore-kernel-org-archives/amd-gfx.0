Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A3AC87FD2
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 06:26:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E9D210E3B3;
	Fri,  1 Aug 2025 06:26:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BziG5vja";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 614E510E2F6
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 06:26:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hto+xWkJEnsAyGzv2L70raapibc8tC8AxwnBe9PllXQreqhc+sXoFxY5NTQwj0clJrtMAjmYJYZ8D3b7UkFAguxVwoy3bem9HE9q+prK42ump7202Msh3d2k7AFQaxsRtx54CFG3gSkuuq3JZg0wuhVgzZo1tIVtmyds8is0XFM1LyK9QruleFBl8nUwgCpk5phdLnO2/7m8LAgPNScFJgu5cvTy6JN4jqSpmtyRIjHy9kPY7vr2b5y0d1ZI9QRzlaIirlBeHudAb0YbR76aUbAfMSKa+7MKEsNXVm2bJmvpAdHqlorJ/h5HYqeBbIcchiVUhb/5fFXKOTuIsI6wEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Avc5iehga3GfKxPy8xZY3ZtDAMus3yiaEAMe4Ap+Zos=;
 b=Eieu69K/y/76n7vnvleDnQI3Xle8w23KEjownyPQ3z/8MwcLde9biikBH/csmx1CeOQCGLvZn7STrgxi0dmx1rRor5mCukgIpbli1WM7fY5pbpdlkz/ZrL/lX9wj9yV2+MdGYgIA0vx9IABTtr4V5QHHn/mBe6HmbBUUHyLg4Ad0XbXJ22ccxSQ+MhwA7Qq4rOYkLh9onRAOa44Oj9yJIgTEKtvTGrpiWc+HTapc4RzWpubxz1bdmCRG1H8jFIU5FUmhdyQMeXIqrmtuAJiT2CDQcb7xc9Y78yOptlzUCPMwMLkYzpjjIUFk1F/O9y2/NKzz5Rv5/E9Fayl2TSQnwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Avc5iehga3GfKxPy8xZY3ZtDAMus3yiaEAMe4Ap+Zos=;
 b=BziG5vjaREljAoM+NQkP1hbY1CHjMTKnsGbfP+f9wbrNywsVipLo5PTFn2DrdgguBy2WQK0+CpZNvi5wC3ByXyIISeaNd2aXeEeF7j+epGf3iKR8GF5qa1C4ngOmHJ2aJUk+Dm9yCZKu4YXbmsJ48yu1kxVRBPE4FbkJ/42cmeQ=
Received: from MW4P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::8) by
 DM4PR12MB6445.namprd12.prod.outlook.com (2603:10b6:8:bd::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.16; Fri, 1 Aug 2025 06:26:11 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::13) by MW4P221CA0003.outlook.office365.com
 (2603:10b6:303:8b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.14 via Frontend Transport; Fri,
 1 Aug 2025 06:26:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 06:26:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 01:26:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 01:26:09 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 1 Aug 2025 01:26:08 -0500
From: <Alexander.Deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, kyle-hai.chau <kyle-hai.chau@amd.com>
Subject: [v6 04/12] drm/amdgpu: Implement active VMID detection in MES11 queue
 reset for GFX
Date: Fri, 1 Aug 2025 14:21:02 +0800
Message-ID: <20250801062547.4085580-4-Alexander.Deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250801062547.4085580-1-Alexander.Deucher@amd.com>
References: <20250801062547.4085580-1-Alexander.Deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DM4PR12MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: c43ee4c7-6190-4a26-8be6-08ddd0c44ebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?18F+3kBU2a/jNNTvOBJm9+V97Ap8mOmij4qZ0dpzrs41gqeiJ3Oga+q+fbcF?=
 =?us-ascii?Q?3ISfYtra10nDSVeZ/hgPuYvQMdBAbzzWf6KhIPdgJHPa375GtDTCFMLd6AZa?=
 =?us-ascii?Q?243rMfdphOJByhR/AuE77yHfgcNWbHmTUhGOSwoZWYY2QzBLrjfkJ7s82Gvq?=
 =?us-ascii?Q?RO+MIQhB5Qlxv796O61JzBDZyOOZYNT0i5VbYoz8UiUmaKZiPIVHldT99iza?=
 =?us-ascii?Q?Xks5fRnHwjyFg3WWP8V0g+ML0yz5AAm5WcjlJaPyuRTYNUVFTtCxHwx1RQ6Q?=
 =?us-ascii?Q?w8+j+abmtTtB8Yc3E+iksPSveXepvvLFwg7TYMjvaLTM6Zri32PCopo8vv//?=
 =?us-ascii?Q?dhx/IuYXB7IbtA4Px5icXljjLnlQgXtsbRVnrTRZt6LoVTWnrI9AzMXdqG8r?=
 =?us-ascii?Q?bRgM6yYXW0UtHkg28S8InusXA1SeknhPTUcAOchjMVrKwYNBSqsptepKbjbw?=
 =?us-ascii?Q?cxnwIzHcUCrTvi6WrOxwDEZW1d9GQ3Z3OllCIO8lPTliNAMbjGL2gHqSBJE8?=
 =?us-ascii?Q?aL6fd9KzY2oQ+sSRM2PpfPp0WyFMRVenF6ZzJzlcMC5X1062ot/cIb9uIlqX?=
 =?us-ascii?Q?q4KUR13uyE8wfOvU7Iack3maPkqKtA6zozrkIJ0ynoQeC0Tzi3/qxbt0tf/z?=
 =?us-ascii?Q?W1kCFStNM2RNj5HvEo7HPthRjZ6W3ToxyUstyTmh/AKP5I8pLDZTJcelybR2?=
 =?us-ascii?Q?dmKmPyUh9JAGy5B/o2dukaLbIjV3NDwfMAej5TVuf9zfFpZzi8+ovEcmzWjK?=
 =?us-ascii?Q?KPVnvAYP694pagBpHdW8kvKRV+avdtm9iJpsmmeeS6MMCzhR3++ZfUkbBo0I?=
 =?us-ascii?Q?tabv1xAahRgRTnBpW+kfH9ypahag6BnqYzfeAjfKkblnUBHxhaEEg0Kzla0U?=
 =?us-ascii?Q?Q7XXnqtBlyZLc+VlsbxM1/ipKz8kiOGQ3t6Uj8dxzMFuJjx1QJycFqf7h5ZA?=
 =?us-ascii?Q?AsfiZF8Sp9Mw9LLfLkIKIc+tV8mXP5ffFdcNfVHbaiUp6kUc7oYwrB1cQ1hZ?=
 =?us-ascii?Q?tf2ulopk4eMs+NOZ/KNKUHC5Peu8phU+xwNoHtN5Oc3Vo74FC9ifDRq0GLZu?=
 =?us-ascii?Q?OcGIiUSLEy2XqCJWvUBccSvxwjxKCiI+rQSAHx3MWv4r00G3X3cF1I0RgvC9?=
 =?us-ascii?Q?uhPcJgzJawWc5IZU3XPBM78TS3Q80lBrxThxTGVWri10Yf9q2/YC6lLdnIkh?=
 =?us-ascii?Q?hdrhvhX8JvLphi9S8+We0BD9JNK/3eRBnBgZb3gFk4guwmNyneux9OZ/SNgH?=
 =?us-ascii?Q?aDH0Gkf+RP3jxi8bv/UsPyt6LnLTgWn6A6wOBfqWKig5Uu746nDg61hSywek?=
 =?us-ascii?Q?nFhoZ4tOXHMO8X5VOtKAiu0SGGC6L58+yLsQfLr8uuvHxL/gcPnUAoHuERBV?=
 =?us-ascii?Q?DD5K3PfvplY93J4jvcwcXlXQFSqO/RJFXVExAq9twvTu4Tq9EZMatlzLAiYr?=
 =?us-ascii?Q?DGxoX03lWwZVUhuEtlYKZNvyD4lRwKm/9rhgkM2TaRCZSqItMr7IK1OFAgdJ?=
 =?us-ascii?Q?r42IbP1hKxp8nYRtcHcBcaQBSfVA9kZFHYuN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 06:26:10.8223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c43ee4c7-6190-4a26-8be6-08ddd0c44ebb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6445
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

From: "Jesse.Zhang" <Jesse.Zhang@amd.com>

MES queue reset functionality for GFX queues. The changes include:

1. Added detection of active VMIDs by reading CP_CNTX_STAT and CP_VMID
   registers to properly identify contexts that need resetting

2. Implemented fallback to HPD status method when no active VMIDs are
   found, checking both pipe 0 and pipe 1 queues

3. Extended the MES reset packet with:
   - active_vmids bitmap
   - connected_queue_index for pipe 0
   - connected_queue_index_p1 for pipe 1

Suggested-by: kyle-hai.chau <kyle-hai.chau@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 51 +++++++++++++++++++
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 13 ++++-
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index ed6a7f8af544..1422bc59cd40 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -789,6 +789,12 @@ static int mes_v11_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
 						  struct mes_detect_and_reset_queue_input *input)
 {
 	union MESAPI__RESET mes_reset_queue_pkt;
+	struct amdgpu_device *adev = mes->adev;
+	uint32_t active_vmids = 0;
+	uint32_t connected_queue_index = 0;
+	uint32_t queue_status = 0;
+	uint32_t connected_queue_index_p1 = 0;
+	uint32_t queue_status_p1 = 0;
 
 	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
 
@@ -801,6 +807,51 @@ static int mes_v11_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
 	mes_reset_queue_pkt.doorbell_offset_addr =
 		mes->hung_queue_db_array_gpu_addr;
 
+	/* Add VMID detection for GFX queues */
+	if (input->queue_type == AMDGPU_RING_TYPE_GFX) {
+		uint32_t cp_cntx_stat = RREG32_SOC15(GC, 0, regCP_CNTX_STAT);
+		uint32_t cp_vmid, grbm_gfx_cntl;
+
+		/* Check active contexts in CP_CNTX_STAT */
+		for (uint32_t i = 0; i < 8; i++) {
+			if ((cp_cntx_stat >> (0x14 + i)) & 0x1) {
+				grbm_gfx_cntl = (i << 11);
+				WREG32_SOC15(GC, 0, regGRBM_GFX_CNTL, grbm_gfx_cntl);
+				cp_vmid = RREG32_SOC15(GC, 0, regCP_VMID);
+				active_vmids |= (1 << cp_vmid);
+			}
+		}
+
+		/* Fallback to HPD status if no active VMIDs found */
+		if (active_vmids == 0) {
+			uint32_t hpd_status;
+
+			/* Pipe 0 */
+			WREG32_SOC15(GC, 0, regGRBM_GFX_CNTL, 0);
+			hpd_status = RREG32_SOC15(GC, 0, regCP_GFX_HPD_STATUS0);
+			queue_status = hpd_status & 0x1F;
+			connected_queue_index = (hpd_status & 0xE0) >> 5;
+
+			/* Pipe 1 */
+			WREG32_SOC15(GC, 0, regGRBM_GFX_CNTL, (1 << 6));
+			hpd_status = RREG32_SOC15(GC, 0, regCP_GFX_HPD_STATUS0);
+			queue_status_p1 = hpd_status & 0x1F;
+			connected_queue_index_p1 = (hpd_status & 0xE0) >> 5;
+		}
+
+		mes_reset_queue_pkt.active_vmids = active_vmids;
+		if (active_vmids == 0) {
+			if (queue_status != 0) {
+				mes_reset_queue_pkt.use_connected_queue_index = 1;
+				mes_reset_queue_pkt.connected_queue_index = connected_queue_index;
+			}
+			if (queue_status_p1 != 0) {
+				mes_reset_queue_pkt.use_connected_queue_index_p1 = 1;
+				mes_reset_queue_pkt.connected_queue_index_p1 = connected_queue_index_p1;
+			}
+		}
+	}
+
 	if (input->detect_only)
 		mes_reset_queue_pkt.hang_detect_only = 1;
 	else
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index 15680c3f4970..62ad4f0337eb 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -460,7 +460,11 @@ union MESAPI__RESET {
 			uint32_t                hang_detect_only : 1;
 			/* Rest HP and LP kernel queues not managed by MES */
 			uint32_t                reset_legacy_gfx : 1;
-			uint32_t                reserved : 28;
+			/* Fallback to use conneceted queue index when CP_CNTX_STAT method fails (gfx pipe 0) */
+			uint32_t		use_connected_queue_index : 1;
+			/* For gfx pipe 1 */
+			uint32_t		use_connected_queue_index_p1 : 1;
+			uint32_t                reserved : 26;
 		};
 
 		uint64_t			gang_context_addr;
@@ -488,6 +492,13 @@ union MESAPI__RESET {
 		uint64_t			wptr_addr_hp;
 
 		struct MES_API_STATUS		api_status;
+		uint32_t			active_vmids;
+		uint64_t			timestamp;
+
+		uint32_t			gang_context_array_index;
+
+		uint32_t			connected_queue_index;
+		uint32_t			connected_queue_index_p1;
 	};
 
 	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
-- 
2.49.0

