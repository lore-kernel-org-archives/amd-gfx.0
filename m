Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBA4C87FDA
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 08:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9882A10E426;
	Mon,  4 Aug 2025 08:40:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vH4/2Ryg";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C58EB10E420
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 08:40:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ey1hTnvlVFGpkZnLBfDUVtQj2VO5r7FL1JAa/GL0M0igvMPi5R8ZwAf9z5jJE0pswmvRE4CHE2weS2v9c6ge6Y9MdwrwmZ8SGZilf8opAH/bDZH30goGTnL9CfXPvIeHbmneB4lUeRELmXSIwtJG/D4prdb5JIO0HA3wsSyXJIfL5A3lokIAcTXhriRiDXu7Hb1c1sE5t5tb9nTVuT+duKTliyCqpjh9hrC3utGxgU9uBtJdTWargtzaDAwkSAuXh8QdJd4YgC/t5aCLB6Fam2+coTOKOlggs9CqRX0JYx3mBQGVpkq/lytdjHqTcuiS+TI06FMqQd0RSWdFjX1pZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lp7cGsLGdS2qLEUNMOJSfgrG9RSHriXBMHA7QzYMPXc=;
 b=eDuOrqQObHZSXG6XLNvwM6RWRAD2Io6SHflCwsT8nflXWBqWv78iwcOqlD5s5ISoP80Fy1Pxorb4R1HsPfhKTOZzOqAPyOV2/jqm8RDpbKzAv85LPpepiHO2Y2EY/CMsPRdJCekSjNLlQaGshLTuCTLi+oIetasvcgb9fhDC0skbM1E0wZEJJGghAuugVtkpnTQ6uU4G0RyhuZ4VlzxXGq6RCV+Yo+QOdp2jEa5gt2xMRQjvb0BQAMFRtgBk/qLC/WMx5Uvmlp02G3SixTj/9kT+7E5DZ+zL/WFYV0fkRy1Do4NHLODNfqdTpWouNyU7o1OrVcj/EKmlYijee7ALxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lp7cGsLGdS2qLEUNMOJSfgrG9RSHriXBMHA7QzYMPXc=;
 b=vH4/2Rygxe0uPSFlQhwXjE4tsYqnCoRreOl303SiQDNO+eIDBq+fNLPcvwmoJiHCCxRxwFtLldWlhhXSOlaF3qSr6KtZymPtKFHdOJ/V2vvFgFuF78KGY+RivnUbZqek/FzrNuHyRbznjKABUlRemj7oadSobeQ2Oqd2N+WBmRE=
Received: from BL1PR13CA0115.namprd13.prod.outlook.com (2603:10b6:208:2b9::30)
 by PH7PR12MB7379.namprd12.prod.outlook.com (2603:10b6:510:20e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 4 Aug
 2025 08:40:55 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:208:2b9:cafe::a0) by BL1PR13CA0115.outlook.office365.com
 (2603:10b6:208:2b9::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.13 via Frontend Transport; Mon,
 4 Aug 2025 08:40:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 08:40:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 03:40:53 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 4 Aug 2025 03:40:52 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, kyle-hai.chau <kyle-hai.chau@amd.com>
Subject: [v6 05/13] drm/amdgpu: Implement active VMID detection in MES12 queue
 reset for GFX
Date: Mon, 4 Aug 2025 16:38:23 +0800
Message-ID: <20250804084029.863138-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250804084029.863138-1-Jesse.Zhang@amd.com>
References: <20250804084029.863138-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|PH7PR12MB7379:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc14f6a-3027-41d4-fa86-08ddd332a03f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6P8GFxx2YnfjWl2HppFluAZYQ+4IviGUyxD8D5Lvkn73AOCNhPFp/OUt4Kqk?=
 =?us-ascii?Q?0tTpCNaxJDqJ0N1nup6mqp3qbIqcrcGyGJgHpVDyzzwCWt44GbIkqdH+tO5L?=
 =?us-ascii?Q?Qi4oX0sTJHtqdyDiRYxFsCk9dTNIF/o/BmW3xFBzss0SIVyL+fV+AaPpUd1q?=
 =?us-ascii?Q?qj/ux2kpGXpcltOeypFrR2TOzLWXgoowzXF0WpfKcAqEed4rQMeqDLJgulXc?=
 =?us-ascii?Q?VshlRrqKjURAl5+iWrC3TYyenVCA+5Spba9KLyy65d3BhmF4GNrlpoVBF2g9?=
 =?us-ascii?Q?9Hz2XcqkzfNDiDkOmhdhksa8KDAtekDZB/Qs0P2kTSUSvSet1AJ+u3XSomSh?=
 =?us-ascii?Q?1pck3KtUgNzlEHXFX4g3Hbh6rvq0SdHXD3EP1GvAnskr7z6KRiuHwSbgwVOQ?=
 =?us-ascii?Q?Z/pzqqlbRlRXSG0bAUmeuYuXvQfwJT2JWNQNKhWUhXHZHH8XWwwZYpNCQ6Pp?=
 =?us-ascii?Q?RbVVYxY2K87Q8u0aEa54E7OcTAEY1F5nb/pGmZ97wE/zyFgfUF4ddecFeB5t?=
 =?us-ascii?Q?1peyh/xfTMnoWS3Cwp7QvtKrd0ye2YODqYcKeOviouIC8+YZoRQf06VvP5Wu?=
 =?us-ascii?Q?/ok1mOGr/DN1YSnux5F73Hh0TTSUiXtXIiFz8NuxP2xIdCV6gdmrO9qBm5QU?=
 =?us-ascii?Q?5R4EWg4S33Nj3BKZKM1Q0Kcun65gagGU2+WSjJ4/gP5u30hS+Lbk1TV4JPm+?=
 =?us-ascii?Q?64b7MhGzKxA+TuHOEY1T7tYJSJH2wm5mjnTU5I7XRT35XH2eEnIMj6047jLj?=
 =?us-ascii?Q?KoNdEBPJaKrh0LPXwtKuI8EIeMkh/tE9KT/KAoVodi5ujVzgczMfvuzNL2VK?=
 =?us-ascii?Q?9qmvHnGtJ638RuxcAuxdwboE0QMz3JmA0f3DAoALqGeZGMH5B6XLvNC1G25s?=
 =?us-ascii?Q?o1heaaA7N0ybSoZIdQQnAqehhlrxJqNBc7fbnL2TcSQ1Fw1rQPkz1UYArf9t?=
 =?us-ascii?Q?68Nc2tmUNXU/FnGmAE3O0wS5a/J++RE3YtcXqOoZOc0dwXTbOHgFCBpzITtF?=
 =?us-ascii?Q?6M7Pr2hpRnq4i+iilALF0krnFH8fXXgydjOwTQ+jARRskNaIMDMegNg2cdLU?=
 =?us-ascii?Q?XLpAhqNrHg+hSYYuAVduwQATRe4PRFDfqoparrz/Ts8bxIURPsC7I9TLnOOA?=
 =?us-ascii?Q?p3zLLhSzgYX68BPM6HKSJRyUbQfc8bKxjY1qC6MLNWUX9TQnSo0iMANrahqH?=
 =?us-ascii?Q?mbJZSk+Zs2Cz2AcU6cAk1g269xAWJE9nNd4K5/a7tDI5mv0FVI75fr5rMJ8h?=
 =?us-ascii?Q?RCSmiZxkvxpqaucRKAc73JaboSCpImM4Sj6YlY/rUQHKZnnaf1h6L2P5QI2C?=
 =?us-ascii?Q?FicK5/4RmF8YkgcJVxyWpDeOV+9STcWjPuTwmJtVGb8a93KNJpDAyg7GLtxe?=
 =?us-ascii?Q?1ue4yXie0I8PU9Pb3mZ1eb0M94gmgGYYCD5GCNqUucynzAg+6LMo2gyLEQJx?=
 =?us-ascii?Q?3YvhUlmkGYf8+qZoNE/om2JZpuHDdusVp0BBJLT0uICMfqan8YhFilclnBvB?=
 =?us-ascii?Q?4S2XjeGnz+oMBlq2U54dDCzlti07yr2DAfXn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 08:40:54.6414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc14f6a-3027-41d4-fa86-08ddd332a03f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7379
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

Suggested-by: kyle-hai.chau <kyle-hai.chau@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 51 ++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 29d38aa1897e..579720695e9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -885,6 +885,12 @@ static int mes_v12_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
 						  struct mes_detect_and_reset_queue_input *input)
 {
 	union MESAPI__RESET mes_reset_queue_pkt;
+	struct amdgpu_device *adev = mes->adev;
+	uint32_t active_vmids = 0;
+	uint32_t connected_queue_index = 0;
+	uint32_t queue_status = 0;
+	uint32_t connected_queue_index_p1 = 0;
+	uint32_t queue_status_p1 = 0;
 	int pipe;
 
 	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
@@ -898,6 +904,51 @@ static int mes_v12_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
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
+				cp_vmid = RREG32_SOC15(GC, 0, regCP_CP_VMID);
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
-- 
2.49.0

