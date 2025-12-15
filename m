Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CAED5B864
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 18:16:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB2CA10E4D6;
	Mon, 15 Dec 2025 18:16:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hXi7+lu0";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010001.outbound.protection.outlook.com [52.101.56.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DB6910E4BF
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 18:16:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZn9615Ssuf03v09gDn1qgWFRJr64hPwF+6suTdVEQouuBRUcRCXAJGZUS4clLnHXTvURixNfjDE2+Y/EkUxacHbA6p54aBDXyDPyzr+ZonDkESqXW/Vvqhfb19QrRQNGyERr/QC6u3577RjX0QUs5dv6GanXB1QOCu8u8SlRyto6SvOxWVmp25NgWa9uxYmKq7goyqIskPtpEWJjTr/5uiaoNSOLlR7eQhK+Xuc8biWVkssoqytZvTZAzXztW6RLY5yh/ZM44RB6a5O1YfJHl+oa70uUen+Hv4XjjvRKrOiYOEdlrNe4Zzi4Vvr+C/UrBQbdTMcKXysVwEXWVExlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g74wlFIWybMJPY+XSwnuLIuwfLY4eFm4MmbxXK1wQzQ=;
 b=LjLUI77ZX63sim46MXs/2qveSInBg7+uYXIsQHozPm4nlaPBw17Fknh35BpY5aB0AzqRtoH8P6voJhWOXKBxF84jMMYXKuy3iFisLjclcjNr+GwsEvaTAR3se5Gsr/RgHo4yTJvj5OX/MkE3tn3zQzZjnWO/95K0k8IOHMlwhJQQKyvU6M61vkfjlIzAv8VkpztdO02pjD76VSMZ5J7moMLOin5MjxmD+qMzDTupsN5+Cizq3PQWk4y4sgBCUzDsaC0iRVxr6aE8OInsn9KRVlOvA4VlJiCQak9xw6xMjSbQiWOmi7/ZRVXVu9zHmN8F6hxXlrU7RgDRB/zoM/qGxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g74wlFIWybMJPY+XSwnuLIuwfLY4eFm4MmbxXK1wQzQ=;
 b=hXi7+lu0y0ZN2pUTKL71bW9Q+kInzkp5mIi5S9Q8FM1IRhVdIUaiTEOkRyExnlEI+VISLnKqcBcERhbb/ZqF2GcE2eNoBa8qmz5vD4TFUIO07NEavarNDbxauuIsPCl9C1n/wSnv6G30DBWbqVR5TJIn5zKzCDq9mMFGSMtnG0c=
Received: from BL1PR13CA0229.namprd13.prod.outlook.com (2603:10b6:208:2bf::24)
 by PH7PR12MB6762.namprd12.prod.outlook.com (2603:10b6:510:1ac::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 18:16:28 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::85) by BL1PR13CA0229.outlook.office365.com
 (2603:10b6:208:2bf::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Mon,
 15 Dec 2025 18:15:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 18:16:27 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 12:16:25 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 Michael Chen <michael.chen@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Rework MES initialization on GFX 12.1
Date: Mon, 15 Dec 2025 13:15:58 -0500
Message-ID: <20251215181607.29132-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215181607.29132-1-alexander.deucher@amd.com>
References: <20251215181607.29132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|PH7PR12MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a4c32f9-a8df-4152-5ba2-08de3c061089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8aXfMDKYMffiL4oRdfBtQCnwaJ/KA4x0rNW4hjy4gNn5UtBXun+qZ1LGcFc6?=
 =?us-ascii?Q?Gmgn3yPZKYU+xlhQlbq2CrRXs9vZ6b4F9v5pND0L/coCCBKflTQMpdB+UeVY?=
 =?us-ascii?Q?+TsmO6RnJ2qceZDtQLZcXB+vIh4RdyfgsyGV5uLWut6MtH9bZFTokYsNRala?=
 =?us-ascii?Q?UWq0H+TektBDgtrNCnTDSHa9ogaNPqOqg4mzSv3HdoKrO44bZvCShLtoiPCb?=
 =?us-ascii?Q?6k236bGvVdKq/4cMdquH+YCGC7nEMMDn7r6069K7EFP5Kv95KpHnObdKjILu?=
 =?us-ascii?Q?gWReoqv/y+dkiYupuzuydl2a2rLTh4CQtkbiPwAum9lHxDW+8ZwixeajjPJH?=
 =?us-ascii?Q?11B68HxwBFOvOH08/kcc1uCtM1xgnByGAiNVtpHvymATy47RdxgQ0l1Wwz85?=
 =?us-ascii?Q?sQu6CEm6sLFsDAURimcUwCd3yIY4+5QndPnskkdhi17e/kQG4H23Hbv++li5?=
 =?us-ascii?Q?YZX+q0BUolyBrtrk7Vixo/PHL2V0sJlc55SLvd9ncvZOigcbAHxERQpo92KU?=
 =?us-ascii?Q?8ZyqphQRN4Zy9IKenyxs09GEc2OIlyy+P2eokjRWtbRUUn82g7uV3bZVmgA7?=
 =?us-ascii?Q?1z/HZ/hMw4aPY98h3aNzQwdOl49lU3cOlTIamrQan19Xqjojak/F9pc9QjLU?=
 =?us-ascii?Q?Eoo4YbccLeXrq+kxJSqe/nZqRXe2nz+GG9R/BEgXXPKEKqIGL1eaKRgLDBAU?=
 =?us-ascii?Q?83IhRarAbE0erDEfPBFOpM22B2uVtHYSDJIFEomqNLjJUMtE2zNaa4UpsA6j?=
 =?us-ascii?Q?r2Yyiy+YZSOStyUcEbzTfySGin4IL+D5+ptPnR2y+vhzwj7du48lWr5/PxLF?=
 =?us-ascii?Q?y7jq2iKs57Vi8soTY2eexbfnYC3Hl5Av5h8FhznjKTcN22kD6f095udnRHCZ?=
 =?us-ascii?Q?lRnzK/g/CcQVe+HhRFjhVju6nBP7AfhWpI+QFBcFFTM/QLPSFFAy743Bcb+p?=
 =?us-ascii?Q?RoDkgrfgwjPMG5ZDzQ9vc30XgynterGOkER7ld5hTrAqzMEAAXoWwrLwfWJ4?=
 =?us-ascii?Q?jFo6idXN+USphwiCURvtkWzWE6kTmqODj1p4/+p+1H5SatQdUUyl5QmMhiUv?=
 =?us-ascii?Q?H1DZBKot5WQ/jtsyWJCMRXMzM6qVETg40mK3Pi3bjz79A8wxUeIztfVLiB+w?=
 =?us-ascii?Q?1HkQVZKAzkpPlGtzv9C5kfvxwOMDCAnJg1FMQ03c1JehtSNJddq8OCFTROb2?=
 =?us-ascii?Q?6NllbcBMTkURVGGpYNap6MR+qnBDMpD26eTdWUT9Au4eM9E4eYTfEyB4n8Xm?=
 =?us-ascii?Q?aq70nsvPUuOUdtj8l3l5XMy8hmH7dnqIBcRB2QG+8Qw45ELB/EaOQ4amF/5f?=
 =?us-ascii?Q?BKJYTeTaJlAjShWQ9nLfC/kkFPiGAtSse2is92F3tVJIedIj3Gp7MtH5OXir?=
 =?us-ascii?Q?pLiY/1uFygrM/n/SaHlrBwep68V+vRNWTQDRNs4Yubiru3NOb2JVxT7TX3Un?=
 =?us-ascii?Q?9tJY/zA9Hd7UsNAFFgQaoKZJKDPa2vy0tI/NDSHGKxuavqo1Qd6IAXaSnH5n?=
 =?us-ascii?Q?Ayhed6M4Pfn2PtkphFkzqwsuw8Hl9P2HGFmjVo4O2A50X6+nl6S88hAIEetM?=
 =?us-ascii?Q?+MDBl1OJhsmjPGCqpyE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 18:16:27.7645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4c32f9-a8df-4152-5ba2-08de3c061089
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6762
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

From: Mukul Joshi <mukul.joshi@amd.com>

Currently, only SPX mode works on GFX 12.1. This patch reworks
the MES initialization to get other non-SPX modes working. For example,
for CPX mode, coop_enable bit needs to be set to 0. The shared command
buffer initialization is also not needed in CPX mode.
The shared command buffer initialization needs further improvements which
will be handled in later patches.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Michael Chen <michael.chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 56 +++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index b0b1df5f1d4b9..16e9dd56b0c86 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -591,6 +591,7 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 		mes_v12_1_get_rrmt(input->wrm_reg.reg1,
 				   GET_INST(GC, input->xcc_id),
 				   &misc_pkt.wait_reg_mem.rrmt_opt2);
+
 		if (misc_pkt.wait_reg_mem.rrmt_opt1.mode != MES_RRMT_MODE_REMOTE_MID) {
 			misc_pkt.wait_reg_mem.reg_offset1 =
 				NORMALIZE_XCC_REG_OFFSET(misc_pkt.wait_reg_mem.reg_offset1);
@@ -1508,9 +1509,6 @@ static int mes_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int pipe, r, xcc_id, num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 
-	if (adev->enable_uni_mes && num_xcc > 1)
-		adev->mes.enable_coop_mode = true;
-
 	adev->mes.funcs = &mes_v12_1_funcs;
 	adev->mes.kiq_hw_init = &mes_v12_1_kiq_hw_init;
 	adev->mes.kiq_hw_fini = &mes_v12_1_kiq_hw_fini;
@@ -1541,7 +1539,7 @@ static int mes_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 			if (r)
 				return r;
 
-			if (adev->mes.enable_coop_mode) {
+			if (adev->enable_uni_mes && num_xcc > 1) {
 				r = mes_v12_1_allocate_shared_cmd_buf(adev,
 							      pipe, xcc_id);
 				if (r)
@@ -1741,6 +1739,45 @@ static int mes_v12_1_kiq_hw_fini(struct amdgpu_device *adev, uint32_t xcc_id)
 	return 0;
 }
 
+static int mes_v12_1_setup_coop_mode(struct amdgpu_device *adev, int xcc_id)
+{
+	u32 num_xcc_per_xcp, num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	int r = 0;
+
+	if (num_xcc == 1)
+		return r;
+
+	if (adev->gfx.funcs &&
+	    adev->gfx.funcs->get_xccs_per_xcp)
+		num_xcc_per_xcp = adev->gfx.funcs->get_xccs_per_xcp(adev);
+	else
+		return -EINVAL;
+
+	switch (adev->xcp_mgr->mode) {
+	case AMDGPU_SPX_PARTITION_MODE:
+		adev->mes.enable_coop_mode = 1;
+		adev->mes.master_xcc_ids[xcc_id] = 0;
+		break;
+	case AMDGPU_DPX_PARTITION_MODE:
+		adev->mes.enable_coop_mode = 1;
+		adev->mes.master_xcc_ids[xcc_id] =
+			(xcc_id/num_xcc_per_xcp) * (num_xcc / 2);
+		break;
+	case AMDGPU_QPX_PARTITION_MODE:
+		adev->mes.enable_coop_mode = 1;
+		adev->mes.master_xcc_ids[xcc_id] =
+			(xcc_id/num_xcc_per_xcp) * (num_xcc / 4);
+		break;
+	case AMDGPU_CPX_PARTITION_MODE:
+		adev->mes.enable_coop_mode = 0;
+		break;
+	default:
+		r = -EINVAL;
+		break;
+	}
+	return r;
+}
+
 static int mes_v12_1_xcc_hw_init(struct amdgpu_ip_block *ip_block, int xcc_id)
 {
 	int r;
@@ -1781,10 +1818,13 @@ static int mes_v12_1_xcc_hw_init(struct amdgpu_ip_block *ip_block, int xcc_id)
 	if (r)
 		goto failure;
 
-	if (adev->enable_uni_mes)
+	if (adev->enable_uni_mes) {
+		r = mes_v12_1_setup_coop_mode(adev, xcc_id);
+		if (r)
+			goto failure;
 		mes_v12_1_set_hw_resources_1(&adev->mes,
 					       AMDGPU_MES_SCHED_PIPE, xcc_id);
-
+	}
 	mes_v12_1_init_aggregated_doorbell(&adev->mes, xcc_id);
 
 	r = mes_v12_1_query_sched_status(&adev->mes,
@@ -1816,10 +1856,6 @@ static int mes_v12_1_hw_init(struct amdgpu_ip_block *ip_block)
 	int r, xcc_id, num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 
 	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
-		/* for SPX mode, all master xcc ids are set to 0 */
-		if (adev->mes.enable_coop_mode)
-			adev->mes.master_xcc_ids[xcc_id] = 0;
-
 		r = mes_v12_1_xcc_hw_init(ip_block, xcc_id);
 		if (r)
 			return r;
-- 
2.52.0

