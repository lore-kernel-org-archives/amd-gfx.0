Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6042DC83F05
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A587410E635;
	Tue,  1 Jul 2025 18:45:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="umbElwN/";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2EDD10E635
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 18:45:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZqRAGcMWE44E2ya6erGkzNP4UqXhxmoAMQAKg/6Iv3JnIgc7kOT1w8rL9jA2WWYhGDlNVGbBsjoIgMijTwkRRWUjTw7pw4cm3dnyWRB4AY4bDStWk/21V8bnfFL6He5GRHJnzGWrKrvfKi7fe9JG7lvflgc5NuU4vDKy+tXPAxxl78JypBAZgPMLQq9CARQlAXYgtf0G8wSh5hRnbeIVBuxtiz0KlZURYwGM3kogdvaqgQmwMLSEUBpX+FmIWNKmDvSK3iewfFRMpRlaM66DavnNvbvobhgNOC3ekjOA4Xi2vjt2pldOfD+V86fXbZmeTbxegizkb3vVvWw0Z3d5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJQr3O1XrRhTErH+ycjps79272+j6UfM33GnB1s4WEk=;
 b=P5pQ9LGn69SZ2S1Jw9G0P8wB+Vw/zrs4n66Z0maM6nni+YqWX70jEQeQ/p6KCLu435Agued+4Kx6IBZUamL04dVGr16aJB6zlMUD2p5YlRP5jUXvJIBMe6SjpwOkmWUpeNWvcgi2KCjn/4ejI/8kebE8YzPvI/31LjiuyFsWZ0kXtLxB+dUGLt+WZwJlF81xpUFM7hTexZMsndK7hF51lZqbaGFAA0jqFD/49lVndaivtcGtYT1/pFgpqSM72Wf5BNRwUHOtyml1a/HSMdjzbJKHpURV8O7cI7ZngRl9CTU4+Nz8glQMfc90rvjbRPXtrya4UxQF9OxogfYgNrOu0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJQr3O1XrRhTErH+ycjps79272+j6UfM33GnB1s4WEk=;
 b=umbElwN/+tW/QtR4DelC8+OLxpt2YR94TjAgDJcY2uSJ41UffVYDMNfZNYeVwvOmK/VgjBVYp/vl5V1wIuWlBIX7/QrdelQPVkKqFZSPeGqL5P1qVEv9/Wi+NIzjWPFLy4xw9B0qYWK1nTlqCBSsZ7QKd6WGoy03NCm1UJVb+kk=
Received: from SJ0PR03CA0129.namprd03.prod.outlook.com (2603:10b6:a03:33c::14)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.28; Tue, 1 Jul
 2025 18:45:21 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::51) by SJ0PR03CA0129.outlook.office365.com
 (2603:10b6:a03:33c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.31 via Frontend Transport; Tue,
 1 Jul 2025 18:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:45:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 13:45:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 26/28] drm/amdgpu/vcn2: implement ring reset
Date: Tue, 1 Jul 2025 14:44:49 -0400
Message-ID: <20250701184451.11868-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701184451.11868-1-alexander.deucher@amd.com>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|DM6PR12MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: 64016dd7-2db5-4335-dc6d-08ddb8cf6ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n4hBbosRbzqeQK4mI0T8lzMMRMKIXSOwzMOVJezsAy0srzANAkfM73vjoaUE?=
 =?us-ascii?Q?ID95/xU7LR7pEmpNtihg1nhdElic5uVluax3cBpDRjMPbF3Ubnwzjengd039?=
 =?us-ascii?Q?LvPLdMQyGDJGuYwbT1ARNoNZOJnhDyhJicX2dwxnvyqemCc5A8VXbQ5Ik3YY?=
 =?us-ascii?Q?WQHnUklpE9DGGo4fWnY2/3TAShMdEIjiXEYQwjup5lhSl96yGV4ZS73wdUXB?=
 =?us-ascii?Q?iltYxfjJ21k3wgBZXon7asQsyBVi2d1CeKIa85C0Iyi2lTZLYdaktYMmtlUT?=
 =?us-ascii?Q?xD4wpuAOppb4r3FtlNPCGB1wu+yka52hzOC2/HGRtsky+R50cJiAzXXV8rh7?=
 =?us-ascii?Q?iHa4lLNH9XeXgb9n/zozt5WJRt/KQHIpd7o/LlGR10wV4FVD66whiEfuGvs+?=
 =?us-ascii?Q?72cpCXZVVUSG5NXP9KniHQregZZIH/kKfaFf4K7JgXE48Q2b2NgMulqwN5s4?=
 =?us-ascii?Q?zYCxtVM7Ng4NDAe1TLEuLczIpdTJVjc54DmkjSwTIyv9nsoMsUdpYN7alsxh?=
 =?us-ascii?Q?wgR5cqoWcchTz6s4sLfsjodoo8KFTJhuWLi8pGBdT2H78eFaWbdfEyTLeVPa?=
 =?us-ascii?Q?C5W3ldD/rEndCrObITw0gS5n7oRn+vxUuYA3NUPf7IDeiDnCcsvy8HLnetlq?=
 =?us-ascii?Q?SOu6dpzYPdaY8/R8hVRAivV9axQuD/o6CEXmWN1Kx5mBEtM4zyLp2PZxLHEL?=
 =?us-ascii?Q?cf0nf3ifb57MWM0ybvZaED9SyvWaAuhyy+sAPFMvAGa88aa715HgUMF8K14m?=
 =?us-ascii?Q?oIeNbRmFV6vP1kwIvottfyysD6E1NXULj9Ylt22GXITYpk0lR5HBoNWPr3bX?=
 =?us-ascii?Q?nxQYSakdgh9hR48OjQz6ZxaMX5ktpHqZlASSpBFeW13htayt+yN9ABl9yPoD?=
 =?us-ascii?Q?xf9g1WBrBCkTTI9jChtX6X6YxixYrHKqa/7+KHNC/l5i+EBIksniKvRtUM+Z?=
 =?us-ascii?Q?4piIq4u37r6eWhDuTKBf51JAAITk104mnL3ySoJ5e/uUcqptgRqRGb/eYvrM?=
 =?us-ascii?Q?I6V8EAjipTOD70F/DqbvEG/aOHmbU4pMekpUEIvjne3eRd7INZ7ge9Jx1aKb?=
 =?us-ascii?Q?qy2bREY7H2AizRDqYrQ6PJQS1i7Ieiqa4CCtaTHMUMn7cnQPdx2TUW7pUFK6?=
 =?us-ascii?Q?CsIK/YCL7WLm/K5XTdw5pr5tW2dOadqb0ZG2tl16PBb+7BOPtdc5Z3SdsZd+?=
 =?us-ascii?Q?wIV6Tzi7r3VDQ8RiAnN4ZBw3Pc4KUmGAeYgWu/d9hre9a6w9UxTrXvG9zgVP?=
 =?us-ascii?Q?smCp2yTYv3vQZQB/LJ81EdB7ubJyVqIQo/1pRPnIv3mfZmRwMGpapMFw7GCS?=
 =?us-ascii?Q?WajcTCyColja7ka7XBx/Ad/juvTdV16slK1Fn4GT9jEeJK/g2zbx9uBfo4sY?=
 =?us-ascii?Q?ciSycP8U16+I4148c5+knEAO3898xcgWyaUUfYjeuUVOSZW05WMTU9K/DIjG?=
 =?us-ascii?Q?+2/t0hjdhrHrU6udAgjIzGCGm386i6EwZr71qEbwNMH2o5ElMX2CKFIH5TUK?=
 =?us-ascii?Q?e0roLkOuuTWcJOKOjkN+Ete37Pksiot6FgdO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:45:21.4547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64016dd7-2db5-4335-dc6d-08ddb8cf6ef6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
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
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 148b651be7ca7..33d210a61483f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -98,6 +98,8 @@ static int vcn_v2_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 static int vcn_v2_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				   struct dpg_pause_state *new_state);
 static int vcn_v2_0_start_sriov(struct amdgpu_device *adev);
+static int vcn_v2_0_reset(struct amdgpu_vcn_inst *vinst);
+
 /**
  * vcn_v2_0_early_init - set function pointers and load microcode
  *
@@ -213,6 +215,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	adev->vcn.inst[0].pause_dpg_mode = vcn_v2_0_pause_dpg_mode;
+	adev->vcn.inst[0].reset = vcn_v2_0_reset;
 
 	r = amdgpu_virt_alloc_mm_table(adev);
 	if (r)
@@ -1355,6 +1358,13 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	return 0;
 }
 
+static int vcn_v2_0_reset(struct amdgpu_vcn_inst *vinst)
+{
+	vcn_v2_0_stop(vinst);
+	vcn_v2_0_start(vinst);
+	return 0;
+}
+
 static bool vcn_v2_0_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -2176,6 +2186,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_dec_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 static const struct amdgpu_ring_funcs vcn_v2_0_enc_ring_vm_funcs = {
@@ -2205,6 +2216,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_enc_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 static void vcn_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.50.0

