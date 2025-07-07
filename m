Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6645EC83F0A
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0062F10E544;
	Mon,  7 Jul 2025 19:04:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XdDWEGzF";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C07EB10E538
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajaBLwYR0pDii7xJ18TW7hzVCUA7ES1dQPMMVenXx0xyT5V2XEiclyUCxAL3CBD/43P9DSMWaoJKpbLFGZSffWpx3n13xDjJHVkjnVQifTVbx+r+W+Q4+Fm17JDcpafbxihTc4TsS3rzxk+FWv/CqU/NRkINs1lBxyP4fOUZLk42ogojCRxWWrjxeph6d/ZZEkl2YHKX4xSK3fKWQeZ8pjSYqk5oVtvqLT0ImyDeuoNHEPosG0+oOp5DOPCNIYPFLwP7A4NmBlqluocfeCtKs0gGGtLSwNO/+/GDcdDSByoLuu02z2gs8PF+PBmBhyWjH9zxQcPQ8xrS+stwXvAbVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuJVtH0HCSrMVVGR7XeIFrb0S4hKKCsqze8IDwA3G60=;
 b=NyH5tKiq0gCzKBm2ce/9LvAFQQhouvX3XONMCKZeZqUfmDcQ1EO7Jq4ck7ye0DH2T4Dmt0LNBI2GzA1l1szDxll7n50nxoaUuQfXtkBVnSgrp1gZgp5IzFk6ZtIpV+kc8I6hcIfWg57qNzYt6+plLBTtePrnzRmRzja5SUirg31QEooo/2FT5MUBXYMCXOtWSYBjNKWg+BvFOli3kgvlu1hCFgbGaVHpTZWRC8lBpUd6beNkCD/J55hesAOLC+zEv4oNKj05Zniye8zCxz3Obxyd5chJ7oAb7YY9eVUq5aOSCP4OcaCLe4fmi2l5+wv3rJNPT/pKCNrbU8ZVgaxcMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuJVtH0HCSrMVVGR7XeIFrb0S4hKKCsqze8IDwA3G60=;
 b=XdDWEGzFIpiGSgz40v4EIl5Y7nSwmTvQ/aZEa4SvhcPSFAIwL+cPqcYQCYh9ftUKMMI/+gFTp6DMSiOrJzd5T/OSmZyBCrPbx4SFo75SjlqZA9jdvqdUatcybsp/mvTPaXfX0gQEfAFvjEBpuDCogteMc5bTdTuVjVnfP0cYTn0=
Received: from PH7P221CA0077.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::12)
 by CY3PR12MB9702.namprd12.prod.outlook.com (2603:10b6:930:103::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Mon, 7 Jul
 2025 19:04:36 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::16) by PH7P221CA0077.outlook.office365.com
 (2603:10b6:510:328::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 35/36] drm/amdgpu/vcn2.5: implement ring reset
Date: Mon, 7 Jul 2025 15:03:54 -0400
Message-ID: <20250707190355.837891-36-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707190355.837891-1-alexander.deucher@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|CY3PR12MB9702:EE_
X-MS-Office365-Filtering-Correlation-Id: bf02af5a-ba0b-4351-475a-08ddbd891d49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fwjshPXMdvTQaBlr4LHLH79a3rSc29G4bY8yW4aFZfY+zcjB4n1nh66TXfxw?=
 =?us-ascii?Q?Mrvf1F0kYRvF5V0cv/uOVh4CXz4esuof8fzzbUVAaHELgjEZ2DCqujBOTXIe?=
 =?us-ascii?Q?CyLhoaYqoDexf8eJz7iput/JP/Es9gbQUDyh+33n3SkgwllNGvYcmdhfPZhg?=
 =?us-ascii?Q?Vu7+pSwLSvWMeGHSGGqCq70PBk6PWUJ65xdeXkb3gQKg70AToZv666qaAujm?=
 =?us-ascii?Q?O2R0581Jc6rKIVo4YiIwc6xl+BBFqS0/sEO05biEl2DlSVEeWXK4hsSA2nDV?=
 =?us-ascii?Q?cNLxKSZlRLumUQ7ScNJTtAyOBIaMA5kXCjAkcm7GJRyUvwGN1GP2zx7sUX0w?=
 =?us-ascii?Q?smgrj5kkHpY/PRXeJH1LfUDTKjhHdjiKRxZJvBjLQ9bdZpmeF+5GR0ZpFx/k?=
 =?us-ascii?Q?brpk/y/nBXrhGfzV3B+iMGpg44R58DcvEiryCaHEBMFErLTA/72SeitlofEo?=
 =?us-ascii?Q?6b5JpCS0govpj/9cj1nDpX8q+BRIKTHcyMypulGudfuBkVG/EfrSp+F4zxF/?=
 =?us-ascii?Q?R+T8Ub0HiMzHF8/rqVUYBaQp/PSdIWSaVYaldr6eJPu1tRVi6pqykduhrfeL?=
 =?us-ascii?Q?OTYNzdVbz3x4Le77ytYqENFm9lDYINsjRoeaTkl/T7xqiMuRkh2L4msNpPte?=
 =?us-ascii?Q?HnmMfm97hV+uP+bl5f5gfJlGvNxmqHMnUeWlkeoXnvyLrOpiv2sVhE2OMqGx?=
 =?us-ascii?Q?MTtePkzKhB0DNAnyGvXF1sUXNAPPkKw3wYOU77dHAT07ni5R4etOWR+Gg3h0?=
 =?us-ascii?Q?bZFv/FyMpLDYGmOKUdiQmwJtR+juPyNWeiMsW5nhmKWf2kltuqRvs5V5jq7q?=
 =?us-ascii?Q?Ess10Ycf4oVnU4B6grdPgBwS/yt555DNZVo7Zh8Y4JOwVef/bBCS/3LiOG8x?=
 =?us-ascii?Q?oV2daj0FWKpgWobQtAuRDK9i5vexQhIz/+pfHE7XXBvCuRuqyDAU09MkbIy/?=
 =?us-ascii?Q?3Os0ueRH6mVuALu22engFh9ngSr+JBy/dn8xElf5j2Aj6Q9TBjFh696IXORb?=
 =?us-ascii?Q?/YijxqhJJgXNEll1qEVMUc0JGn9sl2HghV6iKstQ+nEH4ZTaDV2sTlNwxfv2?=
 =?us-ascii?Q?s8V1aWftfXetkPlSnGILkOq5yRZKhHe8kbya6Ud26udsK7ODQdn/c+D82oY1?=
 =?us-ascii?Q?U6UOOxo6bwntbvXhAgsKZyXOoX3mct4WBl4y4oiY0R9e4bbQLwsDrdEhQ8L0?=
 =?us-ascii?Q?bxxH3gvFRXUbKjkfHTwa3lfaaoqMf1Z4TNq1WYe4Q/SWh++A0Yi3MAy8aPKL?=
 =?us-ascii?Q?bQ53oRI2fQGkD7efVJ7Yva711x9TSLBHuW615xWUDIJ+z00htobrDUUca1/C?=
 =?us-ascii?Q?TN18NjSDWQM9Ka5cYrtLjPBbtvfkVqFjFwnBL6nWToPAqaW3ac9kdcU+OvSM?=
 =?us-ascii?Q?GKZZprH9r5HZKKg7q3RQl0Nx+eKz39oH2WlAr2md7fJuJ/x3F90JpDqlq+SB?=
 =?us-ascii?Q?6TEQ1fZpx8jH2hnDgsO5oW2Haos6Q/6P+I525tgE+r4qbsFLMJnyHpqqbSqC?=
 =?us-ascii?Q?NSzQLnw36uRde58fSTAbV1NhN4W/KJdGXVe3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:35.5095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf02af5a-ba0b-4351-475a-08ddbd891d49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9702
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

Use the new helpers to handle engine resets for VCN.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 58b527a6b795f..56f61d4e30892 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -102,6 +102,7 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				   struct dpg_pause_state *new_state);
 static int vcn_v2_5_sriov_start(struct amdgpu_device *adev);
 static void vcn_v2_5_set_ras_funcs(struct amdgpu_device *adev);
+static int vcn_v2_5_reset(struct amdgpu_vcn_inst *vinst);
 
 static int amdgpu_ih_clientid_vcns[] = {
 	SOC15_IH_CLIENTID_VCN,
@@ -404,6 +405,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 			adev->vcn.inst[j].pause_dpg_mode = vcn_v2_5_pause_dpg_mode;
+		adev->vcn.inst[j].reset = vcn_v2_5_reset;
 	}
 
 	if (amdgpu_sriov_vf(adev)) {
@@ -1816,6 +1818,7 @@ static const struct amdgpu_ring_funcs vcn_v2_5_dec_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 /**
@@ -1914,6 +1917,7 @@ static const struct amdgpu_ring_funcs vcn_v2_5_enc_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev)
@@ -1942,6 +1946,16 @@ static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev)
 	}
 }
 
+static int vcn_v2_5_reset(struct amdgpu_vcn_inst *vinst)
+{
+	int r;
+
+	r = vcn_v2_5_stop(vinst);
+	if (r)
+		return r;
+	return vcn_v2_5_start(vinst);
+}
+
 static bool vcn_v2_5_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-- 
2.50.0

