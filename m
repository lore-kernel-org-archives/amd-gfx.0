Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D18C83F22
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 11:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA54E10E79B;
	Wed, 16 Jul 2025 11:00:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cVNoOCft";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0318610E79B
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 11:00:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/t+XuRwpyUIi/qEGLXFlsSJc+ebYtlA0Q7eq48jxK8qF7Nb3IKiO3utWKwRO0tyHeKAoRHvubjJLtT1gzeXaDanSmNBag6q2+e/WTtghNz1iq/IInny+UTW/frx5o3S5n7ntRpHQneY3pAx5CgDpYfhNrv8PMxar3lR7ulezrEaStregOW2p6iOYOMW8bGULlonDibNTmc38r1h9EpBCJiwcsxZlFBP7XcBG7Ecv1tgKy0yAkVDX3VPGEJ4Z2jR6KLQ7rxNCTuHLZYmg6VlTrOZ+wrAQfZGZ64hp9yKpodUfxP9sX9qUwgqAn/xvD8kYefPga7dGHQJu/C/n/h6zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChFbpPaHafsSYmivFYgmM93rrgXM1qRzoF9S2bgBeG0=;
 b=oFKR4xf7BEWvIJsXJrhDsLoAUlytJFh4mRKR1II3rbgrKvzVzU0RC+GHOn0garr3OtBQ99kyYR0BEp06d7gPm7dFMvB2EfNpmCXzNY8lH6eqOOkzWLWnC473rv2fvKwTT8B21d6ovFs8ckMEVYDu6n1gwIF00AFGbhfhrygc9dQ+9eMExs1n1T+Zo4ZJSwE2RUdeUnDu7H6bOlOciCIkAMfFPd9+4YBrT1zM6qoITWjxoq2HpQySY6VzH5/RSFDgxKJ5aHjf1serx6cP2hVrbTJiJLWrl7zND1KUekC7nFWrJr2rZziri+iPs56JhNmSqHYmd98GfbduFEoHVAmLIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChFbpPaHafsSYmivFYgmM93rrgXM1qRzoF9S2bgBeG0=;
 b=cVNoOCft4KTkGVg7VDP2EMNOFG1oImW0X5hKpixj8bM9d2Y8sj1rKhHQfX1EJJEGX01qXmFZaHqyyCr4+IfUoFS3hDyXCxak9P4NZLIU4dEHphlXY9EidbCaCEvdewb2+xmpmfC/0CvSvP/DKX4OZ4thZXaEyl47TfPkGkYCOeo=
Received: from BY5PR17CA0001.namprd17.prod.outlook.com (2603:10b6:a03:1b8::14)
 by SA1PR12MB8966.namprd12.prod.outlook.com (2603:10b6:806:385::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 11:00:25 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::71) by BY5PR17CA0001.outlook.office365.com
 (2603:10b6:a03:1b8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 11:00:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 11:00:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 06:00:23 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 06:00:23 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 06:00:22 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>,
 Chau Kyle-haiChau <Kyle-hai.Chau@amd.com>
Subject: [v4 04/11] drm/amdgpu: Implement active VMID detection in MES queue
 reset for GFX11
Date: Wed, 16 Jul 2025 18:59:24 +0800
Message-ID: <20250716110011.1670654-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250716110011.1670654-1-Jesse.Zhang@amd.com>
References: <20250716110011.1670654-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|SA1PR12MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f5c489e-dba4-49bf-2d42-08ddc457f79c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wQ/FkH4LkEKlE6rgIPylEHaZztNNNv2FDxstUcoaLiW2b6F2JIl2DFUbJf1O?=
 =?us-ascii?Q?hd8skjGPjfuWnp2WLCfdxjvZs09lKMCsjlCMnXrHNH/EGMIAWxgo3802V7/E?=
 =?us-ascii?Q?FKUsUi5gAtCnl5r0Jy5ZDdglBtgX+L4GiFPD75ATdyADMJ5LUyR+wYmCkzy+?=
 =?us-ascii?Q?t7di+EvW6ylOdd2EUuF1BfazxZMPggQ8EjnLlBNmWpn7Oh+LMwzEBUlgceKm?=
 =?us-ascii?Q?1hY4Dxk9qBWYmsCyv4vORETwF8SLtwrP8nP1LxaN0ZuCTB/vG03mjhL6OjZK?=
 =?us-ascii?Q?ZfKS/qTRrrVTMggZBNmK2mt5dsqp7UJneEw61R5qEZAL3hDNf6M6Hk6NVsvd?=
 =?us-ascii?Q?RdV5EeC7J3eqQtKPkYmYNYRxtS2kiPrBw4NrdKrtGY0QNNfvxcaW/h+uJQB9?=
 =?us-ascii?Q?ueEKBTqcjRVVWW9smYlnCOEwRIb7CQ+xFgSHv/gPgDfwhOtW/QU3i4B60nk4?=
 =?us-ascii?Q?8P0HrcZwSYmT4RlqRQRA7/DEgZiiBvB4RbvaUZsAMW45ts3d1smBSvRYxbE1?=
 =?us-ascii?Q?927jDkRfGMeGR5bKbvDxEeAY8PfJ9o2rV4dOikFc9Dwu8pRMX5UgpC2FhbLz?=
 =?us-ascii?Q?Mb8Rf/q74GR6YaCoTHi4i8nw/O7Fwm1WUZFWM98P79yP/TW47Ej/Ycxlhwyu?=
 =?us-ascii?Q?pZAT/ITaYrzsZTVN+rzNv0utJoe/mHJYuA/5vDcn2Onj8x6M2Y7D7WFnll4I?=
 =?us-ascii?Q?g0UmGjY7cNqt/i0/Mji44KidqO8q3LiNMWi8hELDdTqf5miHAkYbZNPmPSWs?=
 =?us-ascii?Q?DCLnQhtVJeNEXjzfEagihTfwER0fFV/bNyG7JAXSfoqm1KJDK8tiMCtlTXrD?=
 =?us-ascii?Q?9QFvfSFxnCN0F4AiMuScL4F+8Z837ad2NndllhCIQarlfq1gP2yosOjDSNtS?=
 =?us-ascii?Q?HxiHsG6TJBPlGYQW2nwQ70jNgFOC3DFKsEovLdZw1YikRp2jQWEz5BJwmcI/?=
 =?us-ascii?Q?C9SewDIu7O768vE202goWpPjcrm7Dea84Nqc9gT10EVtO9szYmFEhyJtEOFI?=
 =?us-ascii?Q?bzMACTF0AQRz9KZF21/Kc1wRzNEYd74H4iJ/rbPVBSdGWZvWdyx61SBzaDIe?=
 =?us-ascii?Q?ZgyYS7hk0BOWe5cAF8YXd64GDXVBkwuVVJBwCqkTJhJSJA0PPwFwXTrCMbvh?=
 =?us-ascii?Q?r8iBhXM0G+K5+8PSTeLIB2QO/i0jFs57QoCE6y8Fj34I0yxWxE97gGgMbfks?=
 =?us-ascii?Q?vTTtrCyIsZO8uxae83q+mPOmo2brm9y7qaDbs0GSarPg6YjF2hapVNRacBGi?=
 =?us-ascii?Q?bTjmNux501hPDmyEosQI+V9NLN2C6FoYXy0nhcX6YSynJK9snlIHj5884jAe?=
 =?us-ascii?Q?Spu2xlH/zPHQNVvshXi6t86XCMEqVZcjCPgoHj1yTPTC3CkT9Z4yL4wAMcVQ?=
 =?us-ascii?Q?IP3EQzGtrnDUIaIXebLblmS7mR032HkB7oYmYH6kHdDKicsjOQ3X51pGJFJz?=
 =?us-ascii?Q?oGG4echmlyAPsW1oNVD4WXrfUbhvGSI4f3y3oSZa2ch2rdjcrnP4Rb5/yAzB?=
 =?us-ascii?Q?s79qVAWnHREaVd6EgeanStg+tW4qIV3OEKpO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 11:00:25.1237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5c489e-dba4-49bf-2d42-08ddc457f79c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8966
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

MES queue reset functionality for GFX queues. The changes include:

1. Added detection of active VMIDs by reading CP_CNTX_STAT and CP_VMID
   registers to properly identify contexts that need resetting

2. Implemented fallback to HPD status method when no active VMIDs are
   found, checking both pipe 0 and pipe 1 queues

3. Extended the MES reset packet with:
   - active_vmids bitmap
   - connected_queue_index for pipe 0
   - connected_queue_index_p1 for pipe 1

Suggested-by: Chau Kyle-haiChau <Kyle-hai.Chau@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 50 +++++++++++++++++++
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 13 ++++-
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 28eb846280dd..517fc821de47 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -750,6 +750,12 @@ static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
 				    struct mes_reset_queue_input *input)
 {
 	union MESAPI__RESET mes_reset_queue_pkt;
+	struct amdgpu_device *adev = mes->adev;
+	uint32_t active_vmids = 0;
+	uint32_t connected_queue_index = 0;
+	uint32_t queue_status = 0;
+	uint32_t connected_queue_index_p1 = 0;
+	uint32_t queue_status_p1 = 0;
 
 	if (input->use_mmio)
 		return mes_v11_0_reset_queue_mmio(mes, input->queue_type,
@@ -757,6 +763,50 @@ static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
 						  input->queue_id, input->vmid);
 
 	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
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
 
 	mes_reset_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
 	mes_reset_queue_pkt.header.opcode = MES_SCH_API_RESET;
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

