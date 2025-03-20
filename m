Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3987C28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 16:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51EFC10E674;
	Thu, 20 Mar 2025 16:57:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p+o4aboc";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CA1610E3B1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 16:56:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ergMSqVRmkDJxTlaiHW0bTbrGCoNA5IBsuoebHXcXxyGRaLAYtHHMb5lBedzqzYGD979iJORhaRGedjOGV6i9YUcB580eI/dWJ2w8Xd0gSfWc8QlreXbwWOXNf+CtaJSa/Rjd2OMqNU8HjwU+iF4qTM0rC2TmGLZlp6j5whP6Yne+MhFPcJXEtlMB9oZgzRtiW6QzqVQF5pS+45dQQVFR9+6k1tWZ3KLsblWuoFPRHDHqik8PlKE8sSA4IYiUfzIOlEjUhwqHPNzsiEKjoxyAQ+nIORqpCRvgRVrK+jpEWJoRVjkxEnYetY9fFRkVijNIXXNiqIWu7arCgtzWlVgDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LApB+ZKSmFrg0/4WZdZclfBJq0axR7RBRj0W1nckcs=;
 b=w7l85/YKLAL1J1+w7nHJyCKlPuFF19+ptt5hddIiwGBMYzKUiWvBNb1FneDIofzCJVtLzRLm8DvsVMFMEXSoHGvAv1LHtm3M7WcivlfoFNY1Wh2sy5LeBUZZB5awCCWRipq17QD0y4vBQawdgVI/oO0QV23JSEsoKzONUrgwUgLtNgImejFkNF80tfYO76nVTMc5jpMG4fk8ISwDCvh6U1d2PSFznSHQq0HM7QSERhg1z3him0yLx7/3xoY0SBdZJtmim3A0zKBbotcaE7Mf/qRSt5rK0hsZl//sxIHcnHCiTOZoL9hUyWdHKImiYkW2nyX7h4fIKCzHkAtUX7Fhjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LApB+ZKSmFrg0/4WZdZclfBJq0axR7RBRj0W1nckcs=;
 b=p+o4abocsLjIyizmdm80vRydNwiUPJKBQKfSK1R9PdB7VRyw9AXRdelz2xHJMhF4hQ+Ps0TW6QvF4Q/ylIkBsXVmxk4UExzE+EfPc6vEU5ohkA4etjZo0UmSva3ZmUPPFk9Q15vVV2FFOprs6vJchilmj1VsSWS2uV5hZmB2xOY=
Received: from MN2PR18CA0020.namprd18.prod.outlook.com (2603:10b6:208:23c::25)
 by DM4PR12MB6230.namprd12.prod.outlook.com (2603:10b6:8:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 16:56:50 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::35) by MN2PR18CA0020.outlook.office365.com
 (2603:10b6:208:23c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 16:56:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 16:56:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 11:56:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/5] drm/amdgpu/gfx9.4.3: dump full CP packet header FIFOs
Date: Thu, 20 Mar 2025 12:56:31 -0400
Message-ID: <20250320165634.1245798-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320165634.1245798-1-alexander.deucher@amd.com>
References: <20250320165634.1245798-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|DM4PR12MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fcf7546-f519-4d7b-5c6d-08dd67d03492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hnrPvN8zikEHbpS6+LeDxoOcHIuM17uBxngYU32QtBAJu0Xm0OgDYnyJ5KNS?=
 =?us-ascii?Q?F6iFYQ1CBCrpBpxRezehlOG58trDyQSyVW8UZaUC4IdQIWIpSABeNUMHBWhs?=
 =?us-ascii?Q?ZRjzLhlUO1mjfXGDZlqjcbMqi5TTNv1mYUJL/j3wknlALJMXB3ykHyljcIDk?=
 =?us-ascii?Q?0lDRZ3VJ0gxvsZp+WCTUPWAk11IvMfy4BUGcyqtBhUM43UoznGUiWfRxbbcg?=
 =?us-ascii?Q?RSigYUDc8C92GCfP98+gWhVo05EjcGYC+TVVb/3ddJlNuN0LJdnv2QdD53gd?=
 =?us-ascii?Q?Y6ZwF4c4X5GiWUPnfpPN71kNOuvzmuoSK02Q50CAh5/qp3HtjiICj3K0NuZJ?=
 =?us-ascii?Q?71rvhvK+i8WcfQBnBWPzHpCDnNItboHCyY+T5OfbSKQS+LprqC17aItLzqj9?=
 =?us-ascii?Q?RH57ucXKyr8KEg3KX1XrUf87RNGHFb6JPu77Y+IlZcGbyWuUDiZkd2WTAneX?=
 =?us-ascii?Q?eh5C+LlVS3AkZpyO0tO9TkgMv/gfnJQiBYey91QEnX5ap/Z9ot72t6U4sxRX?=
 =?us-ascii?Q?fe+gxAn2tcF9/ZkzcJS3d30pDlMbswykxMjJXFOw28E7MWGLT7u4mTE5JYea?=
 =?us-ascii?Q?aY1Ax8/l5VrDuyRmR+LhycydvveVS0CxQuYV2AZXVA2oCT9iCasgaiatp1YR?=
 =?us-ascii?Q?U9ghINiLXR2NfKJgQ1e60UiE3fZzDX8k+sJFAtGRivmQt+kM5clFVOl7q/sM?=
 =?us-ascii?Q?2KgRTEQUln3XrtY0E7+9j7QGSG6EX4oobKKCYTtdilEcrIZ5KvDff1+ToaR+?=
 =?us-ascii?Q?Ay1zdup0oYNjFw8hkGnMjPP0R4a94sub678jhRh2ZurvHqNMrLSolLdwYtj3?=
 =?us-ascii?Q?ssPr8Zp+b2iQceB9vDhXlAaLM2KHR2kPaTTlkaydZG6xiOeShmUdHoQxgRs4?=
 =?us-ascii?Q?l5iKEAUc4uvQRWWfgXHwYKVCKplfYufhQS+m1rJivAqBv/KDk6TgBeXymDnC?=
 =?us-ascii?Q?/KuwKedRxkkiYJLyynnBK0PE8j2OetMrPgy6dZbBQ898I3KrvRH6fOgmFKoy?=
 =?us-ascii?Q?EkR8sC8f78bho1jZhqOB0eTm9N9cgI1WluoVBfXaM4t+8b5jfPkk7jMroVyb?=
 =?us-ascii?Q?aAbZ3urgTZ0trS3QU1rnYg70yFA6k2sUj4z588HZM/pZ2a8DJQl9DFui21ZR?=
 =?us-ascii?Q?O2DNMLA56y7ddK4AqVXNsDa6z0SLhBpzuFZ+WFmF3v5pv2AecRFf1Wk99QGA?=
 =?us-ascii?Q?WZm530ETgnxzjnotje96FpLfQEIqaFtrfisZ2VFIx2NfYP2B5CcuV+tLo5yQ?=
 =?us-ascii?Q?KSH0coZpE4gKEfzt7cKUPXNSnNQRUb+9ntUFLzg7XNLdOlCiK/FXmaiQoWf/?=
 =?us-ascii?Q?Ffc/IrT74QgqQ/Sr1FjXrX0AplpeTgq/8Qe8IW4DuX2/zZ2ZvmWRBDxti5KA?=
 =?us-ascii?Q?Rnl/l8NaNxaUEGZMZjuyPawO3Q6HufU++KztZVqk0MrNWJ8uMfVprXIfEMiH?=
 =?us-ascii?Q?9+Bak+hkHXg6f7zhYYt4CukAbMV/xyIVfQBHvpTfEC1x378Nq3+HIw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 16:56:48.8875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fcf7546-f519-4d7b-5c6d-08dd67d03492
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6230
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

In dev core dump, dump the full header fifo for
each queue. Each FIFO has 8 entries.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 52 ++++++++++++++++++-------
 1 file changed, 37 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index efe45e4edfd70..0157c96efc06b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -105,9 +105,6 @@ static const struct amdgpu_hwip_reg_entry gc_reg_list_9_4_3[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, regRLC_SMU_SAFE_MODE),
 	SOC15_REG_ENTRY_STR(GC, 0, regRLC_INT_STAT),
 	SOC15_REG_ENTRY_STR(GC, 0, regRLC_GPM_GENERAL_6),
-	/* cp header registers */
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME2_HEADER_DUMP),
 	/* SE status registers */
 	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE0),
 	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE1),
@@ -154,6 +151,14 @@ static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_9_4_3[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_LO),
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_HI),
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_GFX_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
 };
 
 struct amdgpu_gfx_ras gfx_v9_4_3_ras;
@@ -4599,12 +4604,21 @@ static void gfx_v9_4_3_ip_print(struct amdgpu_ip_block *ip_block, struct drm_pri
 						   "\nxcc:%d mec:%d, pipe:%d, queue:%d\n",
 						    xcc_id, i, j, k);
 					for (reg = 0; reg < reg_count; reg++) {
-						drm_printf(p,
-							   "%-50s \t 0x%08x\n",
-							   gc_cp_reg_list_9_4_3[reg].reg_name,
-							   adev->gfx.ip_dump_compute_queues
-								[xcc_offset + inst_offset +
-								reg]);
+						if (i && gc_cp_reg_list_9_4_3[reg].reg_offset ==
+						    regCP_MEC_ME1_HEADER_DUMP)
+							drm_printf(p,
+								   "%-50s \t 0x%08x\n",
+								   "regCP_MEC_ME2_HEADER_DUMP",
+								   adev->gfx.ip_dump_compute_queues
+								   [xcc_offset + inst_offset +
+								    reg]);
+						else
+							drm_printf(p,
+								   "%-50s \t 0x%08x\n",
+								   gc_cp_reg_list_9_4_3[reg].reg_name,
+								   adev->gfx.ip_dump_compute_queues
+								   [xcc_offset + inst_offset +
+								    reg]);
 					}
 					inst_offset += reg_count;
 				}
@@ -4653,12 +4667,20 @@ static void gfx_v9_4_3_ip_dump(struct amdgpu_ip_block *ip_block)
 							  GET_INST(GC, xcc_id));
 
 					for (reg = 0; reg < reg_count; reg++) {
-						adev->gfx.ip_dump_compute_queues
-							[xcc_offset +
-							 inst_offset + reg] =
-							RREG32(SOC15_REG_ENTRY_OFFSET_INST(
-								gc_cp_reg_list_9_4_3[reg],
-								GET_INST(GC, xcc_id)));
+						if (i && gc_cp_reg_list_9_4_3[reg].reg_offset ==
+						    regCP_MEC_ME1_HEADER_DUMP)
+							adev->gfx.ip_dump_compute_queues
+								[xcc_offset +
+								 inst_offset + reg] =
+								RREG32(SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id),
+											regCP_MEC_ME2_HEADER_DUMP));
+						else
+							adev->gfx.ip_dump_compute_queues
+								[xcc_offset +
+								 inst_offset + reg] =
+								RREG32(SOC15_REG_ENTRY_OFFSET_INST(
+									       gc_cp_reg_list_9_4_3[reg],
+									       GET_INST(GC, xcc_id)));
 					}
 					inst_offset += reg_count;
 				}
-- 
2.49.0

