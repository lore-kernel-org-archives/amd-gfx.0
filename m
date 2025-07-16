Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4FE4C83F1B
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 11:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 756B210E79E;
	Wed, 16 Jul 2025 11:00:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bXGuluDx";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD2EE10E79E
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 11:00:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KG+kLve6c5PG0Th9reG/IUH1lXu0VLIpVVz4BHkqIBeuLM2YFb+fEFylAtqiNbpUgDT0BXwmtOxLf8kKAbEuTrpSOLRba+gOlDqrrhptrhlkAG/mZ+HHD3hQlnDs2cX/RgQJVF6z96s28nWVEcruYMkQeAmfuVcFv4uIm6M7Fx0hQWlRNbFF3K1i3rboi+cqf/xoeGqOBA9TIO3pOh+xR81cZaogWXqKZoJUhjlhA7QNtbgiUNrjaZpw9ezJSqyNkabiKTYBK0lVmIOD3GD89LSoVolmkTcHXHMibxrLi57GmI1pOJgnc0S046xqcVG36ULgJhzlg7oK0m95c61XdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8PcL9LhQFYUbu+j5KW3kyRHCqzH+TuiaSn5x5Djes4=;
 b=e3xGcQTrqz+x5CFguyFiCTO8XZOJJ6euWjgglSqShP9qRsJV5UZorRcNv9O7ngdrJQl+iu0qRlGYemnI0N7WRp9L4p25W6TeawuRpYtaBbAMlOFpq88XGOcVsh6EqtdaErG1iKirWlypGWOt+tknN10WBinEGVF2xC+tKqxSRe5Ga3Bidr623RabXWMiMPYGXULV+KQ0uO9dFwpfcen83wjFKT50+lf5vGVGfZ2jvVUgibil4sEUmIU1XA5WJbrHXPcSdDiSG3R9J9iNAd9hHBwfas+IfXFTZ8rCTUFgjb0zSl+L4+0HWNyaD0p2dPGi9bYATnsPQfeBkrRCQsRNwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8PcL9LhQFYUbu+j5KW3kyRHCqzH+TuiaSn5x5Djes4=;
 b=bXGuluDxkZblYKTQNLonvni+BF7Oj3IsuzW8h0Cg4TbYkyIMfZlMVf9yPcouLcMTxWDbjVLSxILnk9Ej+b7gis6Ml1I9QXBS+CtTmzOpHJChHZSZoA4Ntga3TU0DuNCaoSt2pDBXoW+XutrQC9MSjYSPc0m079dDFNuH2rYDbRY=
Received: from BYAPR07CA0071.namprd07.prod.outlook.com (2603:10b6:a03:60::48)
 by CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 11:00:27 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:60:cafe::18) by BYAPR07CA0071.outlook.office365.com
 (2603:10b6:a03:60::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 11:00:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.1 via Frontend Transport; Wed, 16 Jul 2025 11:00:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 06:00:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 06:00:25 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 06:00:23 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>,
 Chau Kyle-haiChau <Kyle-hai.Chau@amd.com>
Subject: [v4 05/11] drm/amdgpu: Implement active VMID detection in MES queue
 reset for GFX12
Date: Wed, 16 Jul 2025 18:59:25 +0800
Message-ID: <20250716110011.1670654-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250716110011.1670654-1-Jesse.Zhang@amd.com>
References: <20250716110011.1670654-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|CY8PR12MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bee2526-3375-4f37-5d93-08ddc457f83a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eapPK0BgLK2+tf3sUuonokPHHbFO/s4/UoXMeX5bnFV+shlUmgnWvTFjORXY?=
 =?us-ascii?Q?TARlTKDf1BX6qnh5FdJfQs7n++5OS6TdHsPC6wxZUfVoGUyxTuIK66MV+teY?=
 =?us-ascii?Q?qqQCbfoGe1E+ZGVrRCqzwLEFrVIm6Sv+SppGOHa9hO2DlLU4bApnUyohS+L0?=
 =?us-ascii?Q?+Jf0s0lVwtGJHCAggWcYMKdQozQypNT9jqFKytRX1iRT8fmA7C8UZRxeHCeB?=
 =?us-ascii?Q?jKXwLsJK25dDPaLwlIU4zZ1RanBA/Fw4AWjnOiO7CL3c/nJ1U0Stp8+lAbgK?=
 =?us-ascii?Q?u9gl1P3V1O1Mj7iRg+B1b/VsNitWQHin9i4uQuGxTMtQ+X6B3GSwsEpywaq4?=
 =?us-ascii?Q?ItPBnhNLfzSqMfpyhaHJsJcAL5WpbccZI4cN5XZTpIsjV2B6DgN10NgUiQal?=
 =?us-ascii?Q?ObltHlifLG/rkx0+6cQRUVWAh2iiROV69gvXr7x/oQ20g4i5XoqQ3fas6JB6?=
 =?us-ascii?Q?mtkHfwWFeKdmMdmSuLUepReIosOb16lx0SU5gv8WH8yeYughkreCxheAfcZL?=
 =?us-ascii?Q?3rxKHZwofCHP5N1wUlQjPSZropVikSsSvSXf6SoD2/V7hoIRip7UQ1WCf1JV?=
 =?us-ascii?Q?uzlnCQIXfge/bX1AWuDrv3YQjJwC3WiRjK3V+ejrM8EUiScM7vp0rr4QgKwk?=
 =?us-ascii?Q?8Pzi+bImtYaSL0Y35GhbOCPCfUQV1xO1lvu7o+tq9foDI0Fbfdb+sR3G0lF7?=
 =?us-ascii?Q?o2xj7TzT2QJUuhP/JZV8heHvpkYxsEkBRQ4ytSREUvdpE/4jL647mSs2F5jn?=
 =?us-ascii?Q?6qy37Te5ZzxtMDaB3Bke2DirH2u3lsg5sSIk7mDDTitkllsGbwQM1vde5cis?=
 =?us-ascii?Q?SIH9FRnlCbxcxRcckRodVNcBJd8zS1QEV8pipsXT87vWh0ygCd076kntFn7c?=
 =?us-ascii?Q?s8TkpAtD4DGjkVhR1mJRwNvnJRlhdCbOVIWQpRcKINyHvKha3S+/Anm4N2Ck?=
 =?us-ascii?Q?iGN8OP2xvD2aBJUlZKk5yjfrqA1Vr96nld/piwhLh5kOuDwUG3l2vZXNcEwv?=
 =?us-ascii?Q?Lu7icAcIUQb+FmbcKB4eUJ8TLq2TjRdfRzUNnzY2XpiDfxk1aYtou4EF032+?=
 =?us-ascii?Q?55rW94zJurOGZsTqjnFXXyFFKz9EGXdKew8P8Fu+H1cI+CIWHXqwweblyiBe?=
 =?us-ascii?Q?8Pszj52xx/D2H+02nH1Uut33NsI0uOL0wSJ7XPwqGh1zDlQFI8WLZc/8DY+j?=
 =?us-ascii?Q?EWdZEqv+zVkpRyufCS0utxrqY7oT1HwehplTp4Cbfu81fkIgvRc0SykRle59?=
 =?us-ascii?Q?kM7XtFOoZ0b/WuMHHL2QSRQhHeMiREAsru/lHnnn+Xs08ethXkw+ScEbnjGq?=
 =?us-ascii?Q?9dCdTXBBy6s9eHqjQgjCMwc8cHdcXi+Fc8cmOf/aChAS168nAiWVFC0EOg9I?=
 =?us-ascii?Q?tqbeCivjuaOQbqhv2DrFNOaQbhJUoEIy0Ft5Id/KRcIdxuF6pF0DF/EshALd?=
 =?us-ascii?Q?dNv2AY40seHWiIDuoiiL4mWaBVGxRkgIKIgS8Yz1JyW12kmfFG9/HveBz374?=
 =?us-ascii?Q?WYyPH/iRvaHKoyHpnvsFN0wc2jNUGYKfR9fa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 11:00:26.0903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bee2526-3375-4f37-5d93-08ddc457f83a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8065
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
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 50 ++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 6b222630f3fa..273c2f68050a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -840,6 +840,12 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 				    struct mes_reset_queue_input *input)
 {
 	union MESAPI__RESET mes_reset_queue_pkt;
+	struct amdgpu_device *adev = mes->adev;
+	uint32_t active_vmids = 0;
+	uint32_t connected_queue_index = 0;
+	uint32_t queue_status = 0;
+	uint32_t connected_queue_index_p1 = 0;
+	uint32_t queue_status_p1 = 0;
 	int pipe;
 
 	if (input->use_mmio)
@@ -855,6 +861,50 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 
 	mes_reset_queue_pkt.queue_type =
 		convert_to_mes_queue_type(input->queue_type);
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
 
 	if (input->legacy_gfx) {
 		mes_reset_queue_pkt.reset_legacy_gfx = 1;
-- 
2.49.0

