Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7A5C52D71
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 16:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DED5810E3AE;
	Tue,  6 Aug 2024 16:00:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IIAfxuuD";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A68DF10E3A7
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 16:00:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kzl2R0MUeFW40Lu4i5o0oRtBBMPWlDF9UNTilP9cMZ9JTzkJiULyYm+8P0/fW0OMW7zTvxAJR9lj4UXOg5lcMCydzTTJZg8BqnLtzv/hTG3Gk32qkIKRf9STBCTkfja4K+NOIo0bMVudms+C7wmp2mlkd7XZylYzOlKuOZDXQRCP6WvW1zsKD+uw4jy1gHdVd+LGlXbuy/FlKE+vVUzi4LtLYVbM1Bn+7R7nMyZeWMk9HJliMWCQdnEPnBiatzq2nLUgGTrdGNg/h+jgZfOStiEaIRyXFv4mSgIBaep8QpYz5j87LXJtVAFPZYrEr+HdQFE1PA8AyPEW2qVm/6cuJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MzT9UfocEv8CPUklwKdw3kfSs5P7gzcJotzqJW6ks8=;
 b=sGmeeSpq14j/Nq3fgIWNlBqdbyx3UYaKjgIe4NZ8lNzOWwB5pRodIMnChFD1He6Kggrc12ccPIEWRAG/Dyvm+G5gQH8LVgY2FLJjO+ntKLvSBmQxh4JFQDoEMReB/jaUPWgR9DfabB8KhMxY340ExoU7TEt0fJ2pB5T7SXMU8O7dX6RSZWeHc/i9JnJkaIcl1dz6GaKYUcLWvdfyPXmBSPY9lgT31f2M8CBJc6XN5NTeQ2tePKDXShRZ+q+VyMxaUsmgT5raC2lL3aLboN7O/EoNRL0u8aHU+8flIUXNtXi32qtIBMuj3We52hJ3hCk3QXI7hkmxtSPBexnWb6bLgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MzT9UfocEv8CPUklwKdw3kfSs5P7gzcJotzqJW6ks8=;
 b=IIAfxuuDzDr+7qsQDZeVlL4ytF4t9qKy+/jgB4zW4H4MulGwuZZywlmd0ctKzRmYCGzCD3ntlk993VDUQo8vhrIfYPyE0mxjoVmXkbRgik4s6V7iSSx7ZWT6lNNHLkzmQfPVrqKFm+gb9iPjSkOqr49HPr4vaB3WW9o/0y7d8yI=
Received: from BL1PR13CA0015.namprd13.prod.outlook.com (2603:10b6:208:256::20)
 by PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 6 Aug
 2024 16:00:36 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::84) by BL1PR13CA0015.outlook.office365.com
 (2603:10b6:208:256::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.11 via Frontend
 Transport; Tue, 6 Aug 2024 16:00:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Tue, 6 Aug 2024 16:00:35 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 11:00:34 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>
Subject: [PATCH 2/2] drm/amd/amdgpu: cleanup parse_cs callbacks
Date: Tue, 6 Aug 2024 12:00:12 -0400
Message-ID: <20240806160012.234633-2-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806160012.234633-1-David.Wu3@amd.com>
References: <20240806160012.234633-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|PH7PR12MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: 73455bb6-8155-49bc-a02f-08dcb630e8bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I4sMwyG2o4r1ZtAN35qhQ/cSbS/7ER187UK9XqbgyP2b37c3vlnTD7rfcrR6?=
 =?us-ascii?Q?dIOs5AMqaoyYfhdCwXkXDMbshD1EF0HBtgvHaJlMI4FukKBlVXT/11tyhlgX?=
 =?us-ascii?Q?RRzEyZJj3TW9KdHmSlce0hCUpviYMVJynFEg5QfpgTtR7ZvE4vpmTwyEMa9k?=
 =?us-ascii?Q?RqAvhLRtJwJI1JcVw/QrgJP9lXij9ZEj0qFuL038Mwnn2URHQ4GTlT8gQg6V?=
 =?us-ascii?Q?9ID0dAfkcJDRanV5sNtQd6LDn+aZLF31WqJEQ+a49MYP0U2OI4Y9xngq6Ndi?=
 =?us-ascii?Q?p6/RwgRgCFLhO2tUf3dbsH412+wpCoTI5rNdNXoZ8fVui2vckrAQTE86YzMy?=
 =?us-ascii?Q?ikpikpt59KD/rnls95+sSXuCzq5YT0LgtzIuiipNDyF6+1LV8aK3zAft+oHl?=
 =?us-ascii?Q?nfFoXSs3YYXvuQ/lOf7kDfPOHyyQJOGMmv2Cza6YGYC7u9GNK1+ShToeLIiN?=
 =?us-ascii?Q?PbrCkKdE4YxDG2P3Vabj68h8+e/VXiDpMICnC58cgF0DREAh3JUnBIeEGj+k?=
 =?us-ascii?Q?B+mfIz89D6Jwuu8pbvPDyq0JAB7WA1peWLNSorWbbdgfy1VtlYqVUphxIrai?=
 =?us-ascii?Q?A4cgQSl9VrKAsN4fDSgNkaVaKU0/YXDSYtvke55SN0PGTkDGZI2wIlxGWpPw?=
 =?us-ascii?Q?eJM2tMXwmITu4CfSuIXtdQgRPmR5ZR06CFtFDr6deDw7c9vSyksNYRi6T4NN?=
 =?us-ascii?Q?p8e682nuF3TQT8k2VrNmomCklSPmbytJKaF4KA0hMD3BSFkVDp8Hwue5RLV8?=
 =?us-ascii?Q?jBW9EWuv/x6K3iamOSKX9uu4e18rSbbCpcu2NciM8Q6gmJQ4/6c49dQIGRO0?=
 =?us-ascii?Q?csML5PqMHSAcqFFDLf0Xdnguj6+FcuNMchqeH/y+C6V2d9Y0cAFgGTSk7pkY?=
 =?us-ascii?Q?9I1GB58B6srB/NcTrRE/Jlc/SNX/hf40CYqW1cD2ywVW6pMIqY+V3NZvphnC?=
 =?us-ascii?Q?7YZSDG5QQrEAtaAFacGS1XsxMO7VvOdj2PwSaOYUGQ45xjLqHT7EWuCSSYMx?=
 =?us-ascii?Q?lnoo3iKFMOJEcCpuBa8dp6qOai7tP60bJoOjbVsbtrmZC2c2wrQUoAbPPao5?=
 =?us-ascii?Q?xLi0uAhCmipddzyiSXwRlsq2Z+789np71M1q7Qz/8HwMWZP4Z+uchdyzi6cA?=
 =?us-ascii?Q?rhVqiYQKJ786q7GXIV3OPA2Vaq3b6wc0l5kbF7kcph/APATUCOZbVBm9dPNl?=
 =?us-ascii?Q?l49a/n5I7FdeV5v1XaVybXnOBcVhg3Lp3zsnqlG9uPelwsOKfdKkMKw37uYh?=
 =?us-ascii?Q?858Es3A1Pgbr/naWN6h2DzJyg5cIYUEDqnm0wAFGm9YCzuOWBefPJHAR8QB1?=
 =?us-ascii?Q?s61sKBhLX36dnyMyCLkcN2RUJt2RhTJGlaw8BJNSgOgf42rrxecMjULINqZH?=
 =?us-ascii?Q?egp6yG+wJLBs68PTr2+lAJ2xI8tK8rZL9duTI6KyZ0zXp75hZah7VXibuENd?=
 =?us-ascii?Q?d4HWCkr33slI/JbWKnFR1KnV8Ru3HdJw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 16:00:35.8438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73455bb6-8155-49bc-a02f-08dcb630e8bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6657
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

Because gpu_addr is updated in the calling routine
(amdgpu_cs_patch_ibs()),it is removed in the callback.

Use .patch_cs_in_place instead of .parse_cs for
amdgpu_vce_ring_parse_cs_vm() as there is no need for keeping
a temporary IB, therefore ib->sa_bo is NULL and amdgpu_ib_free()
is removed.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 2 --
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c   | 2 +-
 4 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 07d930339b07..98863e920e00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1088,7 +1088,6 @@ int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser *parser,
 	int r;
 
 	job->vm = NULL;
-	ib->gpu_addr = amdgpu_sa_bo_gpu_addr(ib->sa_bo);
 
 	if (ib->length_dw % 16) {
 		DRM_ERROR("UVD IB length (%d) not 16 dwords aligned!\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 968ca2c84ef7..6efb15c5fa1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -749,7 +749,6 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
 	int i, r = 0;
 
 	job->vm = NULL;
-	ib->gpu_addr = amdgpu_sa_bo_gpu_addr(ib->sa_bo);
 
 	for (idx = 0; idx < ib->length_dw;) {
 		uint32_t len = amdgpu_ib_get_value(ib, idx);
@@ -1044,7 +1043,6 @@ int amdgpu_vce_ring_parse_cs_vm(struct amdgpu_cs_parser *p,
 	if (!r) {
 		/* No error, free all destroyed handle slots */
 		tmp = destroyed;
-		amdgpu_ib_free(p->adev, ib, NULL);
 	} else {
 		/* Error during parsing, free all allocated handle slots */
 		tmp = allocated;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 32517c364cf7..4bfba2931b08 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -950,7 +950,7 @@ static const struct amdgpu_ring_funcs vce_v3_0_ring_vm_funcs = {
 	.get_rptr = vce_v3_0_ring_get_rptr,
 	.get_wptr = vce_v3_0_ring_get_wptr,
 	.set_wptr = vce_v3_0_ring_set_wptr,
-	.parse_cs = amdgpu_vce_ring_parse_cs_vm,
+	.patch_cs_in_place = amdgpu_vce_ring_parse_cs_vm,
 	.emit_frame_size =
 		6 + /* vce_v3_0_emit_vm_flush */
 		4 + /* vce_v3_0_emit_pipeline_sync */
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 06d787385ad4..0748bf44c880 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -1102,7 +1102,7 @@ static const struct amdgpu_ring_funcs vce_v4_0_ring_vm_funcs = {
 	.get_rptr = vce_v4_0_ring_get_rptr,
 	.get_wptr = vce_v4_0_ring_get_wptr,
 	.set_wptr = vce_v4_0_ring_set_wptr,
-	.parse_cs = amdgpu_vce_ring_parse_cs_vm,
+	.patch_cs_in_place = amdgpu_vce_ring_parse_cs_vm,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +
-- 
2.34.1

