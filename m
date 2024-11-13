Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A9CD637CC
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 21:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7F1910E712;
	Wed, 13 Nov 2024 21:45:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kp62z7LD";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E8E110E711
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 21:45:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stkuto26QcLkEK8Pc6VAhsXB6YGEigyv8MxVKiHjXxBsZxvEmJBVgt0+8zehKbyIamkcFrHJseeMzDlhKQsPQ5aPRChjdATpZvG+9+/T90umtmxrD4Ya/v7EPd3sfgVlS/I2xtKwN86B0DFW+t8UiX0pGa4ZAb+Wme+87OqKb547cZJm1ytaE9NAyB7kOdJwe2hy2WF9IIDl5fcHxDF4TAVgJZT/stFEXl9656slA1izxziHfvCNb57nEaYERmk8RUxWmKye2vcRG4KNRu7b9nnkKfDBeUkntrI84osw2zsQHSVos4CN4axhgnZuyBuRfnd26RNJHTXcalSNnDoDdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZxHpaYG0qBVAIclXniVwWgxm94O1FcMKoY0Cx/TdFY=;
 b=REjf+W1RUHVwW8qme0jCMV1sHLFoYD+JY926RqzUGN4w4JYHVPkFfis7g1cxqJgl5SCmVvojDTC33XFSJhigKFntmQlTUWic/2W2T0W/3Gaz5F2AgnW120lRJ514BCWLvcvkgPWWyns49XTH2edl8MHfeWUyeIWQTIhBW74hxl2oC7VRaWT5Fz0EeTaUA9ZC8avvC0c4wfotK4JyPsB9XmpWaWjs7cSsO8YfE608SFi6i+7vkNZMCVcPuuO475zJICURaPvxAV/w1l4l1Nqp159lj2mziiGreah5OMFqffV3bUR9jDp9Sgr8pm/qThLmql4sT95HetUJGkbIFk2M+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZxHpaYG0qBVAIclXniVwWgxm94O1FcMKoY0Cx/TdFY=;
 b=Kp62z7LDdi8TrWXMHccEggvT3xDh6YlMEmLzuD8se4gDsjz4+OypJ7mdhK3i0s1TsfaDeqDrqKzdxbnbP0iDDGeNdctSBKGpSyWqgHwnsJw4W27ve2C0h7fi7k+SsFVIv2LU0M445s2xfP7wvdeitnuWTDRSDZKJF3ndMSsd7z4=
Received: from MW4PR04CA0274.namprd04.prod.outlook.com (2603:10b6:303:89::9)
 by PH7PR12MB6634.namprd12.prod.outlook.com (2603:10b6:510:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 21:45:14 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:303:89:cafe::b5) by MW4PR04CA0274.outlook.office365.com
 (2603:10b6:303:89::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Wed, 13 Nov 2024 21:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 21:45:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:45:08 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/15] drm/amdgpu/jpeg: cancel the jpeg worker
Date: Wed, 13 Nov 2024 16:44:40 -0500
Message-ID: <20241113214453.17081-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113214453.17081-1-alexander.deucher@amd.com>
References: <20241113214453.17081-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|PH7PR12MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: ddaf891d-3710-4a39-a868-08dd042c74e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nrqb6+bs0p7Ri5j17cHFn0DFUhg0QkHlX+ldww8ZkFaQPUXaa7e+ZxwbWJAX?=
 =?us-ascii?Q?vTvGmj8Y+0goaBmjypXNFvQLmTtaf8NVEZWCJEt0x1FetmALlY27DMn+dl1J?=
 =?us-ascii?Q?IWEVD1Gu0y8lXEKkESr/xKB2D29mWd4tP04WertMUSC+W3a8VIr/m4iYPL5B?=
 =?us-ascii?Q?1E/VmGr3d2ct7hI9bJlecPs/TIKgd5fa2KvDi/+SneLPC9IGRQaW/7fqbtOX?=
 =?us-ascii?Q?kawOUMidegPwrfrV0SnYGin1R3mOs67/wS1Tis6eOA3OIU9pUMKf7oW7fpth?=
 =?us-ascii?Q?T2YmBans47j5QDVGSLMX6J/ZZn039r5nxGX6W7EglEZgjoXhyjdsPOgjvftX?=
 =?us-ascii?Q?meWCmzbdgP38T5t+H66dzpxeekZobY40Dmc4bh3UpANCx423hyfSdLdNQAcV?=
 =?us-ascii?Q?QHt2hYC7Tqiz4k91iTz4QMbi7y53BB4Aj9wqSvVGUpQZc9fe1/Xx9KHmYQeS?=
 =?us-ascii?Q?ACgTFvuF4S33MBSyvwWmIhYn3XOKeuz4SXeezwl/+mRNN4FtR6hSak85ZRdB?=
 =?us-ascii?Q?urbEl3OFHZHttLdwZQbC4lXERbZrJ+I0p7XmKCSVdx5//5RQtLCt3X3ccpVu?=
 =?us-ascii?Q?xdXWTFXNFoSJ6QmDUzxNn7Rc8gsLNV1eoyUnfbGYlz7Q6El3rYTOKXglxBtp?=
 =?us-ascii?Q?OXnR7JJmWiwsB00SxMTUI35dGEWOZr+GfNAvK82HgBAs2keYeAbS+fGcDM1F?=
 =?us-ascii?Q?7AekpmLCJGUoMDAG/uVPKSJFkEcjFgX6Q+IWVfeyoOPWMJJ1ZGRUhh9L9J0w?=
 =?us-ascii?Q?u6pY51JKY7Rwll9PB+rKFb5DFmzflzjCEi02cJkH2SOXhePlLuAYQgmo0Mzn?=
 =?us-ascii?Q?f/8uL2yxw/OpRWzXIAOWGj3WZzVt5ggqwz3lQ5Z3mho4OgpRThVIyZDbhkZy?=
 =?us-ascii?Q?kKDFfFoZSzrrgiv04fwEqH065lbTnoYZLarYLaTBk04Tc3/yDVi7pYrotEu0?=
 =?us-ascii?Q?mIRp5D7gJLHoH+wk8I5EKk+pydjQ2+PFqEh6OoD3zC4cSFyHilMkhUYhi0zu?=
 =?us-ascii?Q?9hLN4cM5LGvbJGBeEjUzIKHLm5ej1EPsW0mUqxipcLRoS3JKc3wjXWt8uvVu?=
 =?us-ascii?Q?sAAup0XvZtuSZFi7GeBCJ8qQoeyv+lRTI/PdlzZLIRd6qDXavgAVi2GnlpEh?=
 =?us-ascii?Q?UDW0NaYQMALhA1DwFdjevo29wLy57MFiUsqDgU/6NMR4e2yGwcjeHg2YNKOf?=
 =?us-ascii?Q?iV2KiVl11MacSq1stv38SDjQlcLnEMXi4ZhLYhABXdd6fZz6TK8IxiZKIzOM?=
 =?us-ascii?Q?bdumgONLM+ZfGr8a8O7lWfFpQbaZF3go1Gf5tLhGkqL00oW/bosjWKfqHD0a?=
 =?us-ascii?Q?iaDqgISQyl9mJewuW0qOUthiBCznSgZvUPznVEM/eEg05Nf4GlYwsyiThMnw?=
 =?us-ascii?Q?VHq8Vf4sAC0AMTzU8StwWG4m87ohuOTG3CdoWO+V3ezpDevT1A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 21:45:14.0011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddaf891d-3710-4a39-a868-08dd042c74e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6634
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

Looks like these got missed when jpeg was split from vcn.
Cancel the jpeg workers rather than vcn workers.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
index 03b8b7cd5229..7319299f25ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -604,7 +604,7 @@ static void jpeg_v1_0_set_irq_funcs(struct amdgpu_device *adev)
 static void jpeg_v1_0_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct	amdgpu_device *adev = ring->adev;
-	bool	set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
+	bool	set_clocks = !cancel_delayed_work_sync(&adev->jpeg.idle_work);
 	int		cnt = 0;
 
 	mutex_lock(&adev->vcn.vcn1_jpeg1_workaround);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 1100d832abfc..7c9251c03815 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -150,7 +150,7 @@ static int jpeg_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 3d72e383b7df..11f6af2646e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -211,7 +211,7 @@ static int jpeg_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 200403a07d34..4eca65ea9053 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -164,7 +164,7 @@ static int jpeg_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index afba0eaa1500..0aef1f64afd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -202,7 +202,7 @@ static int jpeg_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
 	if (!amdgpu_sriov_vf(adev)) {
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 			RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index e05ca131c1e6..6b3656984957 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -227,7 +227,7 @@ static int jpeg_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 8a14108361d4..87b3f91440e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -168,7 +168,7 @@ static int jpeg_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
-- 
2.47.0

