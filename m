Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F05FD3748B
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 13:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E9C910E81F;
	Thu, 17 Oct 2024 13:21:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LCN2Hez1";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CA7A10E81F
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 13:21:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAn85dwd3QcOq4i5hPyzI6G8m9lAKpXyzE0EdXr3Z3ab7akSNF5n3glk95RwqA6/2E4wg851L4nfufxnJlnwMfNCLQ1BVAaO/K9rT0wTIPp8QxkYJ5WayFCvCaF2ZgyhGkbuAAi16//wJzP2jzqy9iOu12oXPqft73vcqEPTz7VAe6vZPK3G60PCEpeNwxMlHcq1OdALkh14bMhAL2szQ7NJ9fOYEy+CMvimECM8Uaz8Y9VqQkfKMHtrAaDxAk3DXo1gWjyfqEJm+C11n3fs2p8cbnethHG+2MnD/H/wO7v8pkNLBc1XHsL/VhMtyv78GMe9nRzbd5M+5E59qDZTqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfJvpjwVVObpUNEqwzn0JP8oVB7heHLbq1TvGlkWppc=;
 b=L/beK+030nP5auGP/sSt/aQRxsTfaFslbSQ7JFZmpnGUTrYPZ+krjlwuHdxxtb2PCJPjNdq6a6g+S//mZBuLB9E3XTEBVST8u8ziUxDFgWfTJ6c7uZ0bnoIFdLMnRgGVbBDer3CNwWAK0ZBND7xJpawgNLcJN8hF+kmTBthhOFvsXHZFub4DtpzPxLVdyjzgZMnVgRqHGo8lzH9/f3TmgM1fvVMyEWrpfXW322UKPZnEcHgfm3yp5DccUoEIZ467Rg0lCR4zVUGQ0RYx/YDZVi9IKR1VTwf5MEmEwo98E/Px3wvG9etFj7KW4xd1XYvEydQbIA+DN9XYyYx592HLsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfJvpjwVVObpUNEqwzn0JP8oVB7heHLbq1TvGlkWppc=;
 b=LCN2Hez1dvUMgB2w9RT0ulwdqTv61XfBFKcrBepSU/wflJV3uiQsEoc2/hFa02UhihWqNS9QSLIri51cFrqaP4PupvS25FwJqfAiUpgskko5p9EHvEoVKDLNOzjvGT6CcP7fdZH4DuZdX1RqggJlokpmbzyD2VwA5JcTq0dOkJQ=
Received: from BN9PR03CA0156.namprd03.prod.outlook.com (2603:10b6:408:f4::11)
 by PH8PR12MB7256.namprd12.prod.outlook.com (2603:10b6:510:223::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 13:21:19 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::3d) by BN9PR03CA0156.outlook.office365.com
 (2603:10b6:408:f4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21 via Frontend
 Transport; Thu, 17 Oct 2024 13:21:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 13:21:18 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 08:21:17 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 03/32] drm/amd/pm: add inst to smu_dpm_set_vcn_enable
Date: Thu, 17 Oct 2024 09:20:24 -0400
Message-ID: <20241017132053.53214-4-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017132053.53214-1-boyuan.zhang@amd.com>
References: <20241017132053.53214-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|PH8PR12MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f8152d-a279-468b-88a9-08dceeae95ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qMWbQ/a/KqcSMBFtKdBySzOhCbpF/yt4JBB/n/+QjgGou6JapCD5IcsN21tG?=
 =?us-ascii?Q?nwQw830CPptDEmM7jDbmclJzXcWbmTZwEnddGj1wa+AYJQMkA+CCmvKOD7U0?=
 =?us-ascii?Q?eO3F862iU6SOmfiJDHT3tJH5R9w1XbwkZYuqyC7cq7BeIXjI6Xeuiyd3g7Vz?=
 =?us-ascii?Q?9SlQIC2YnQVzWFGF4Y/FbnDJstiNBs3GUsuTN5/D/iBkWxjqGQY2Zbl6qeGm?=
 =?us-ascii?Q?b5/cRzH/gQ0FLYut0ojrqMly9EzoATS6/kbQ6YmThxTX8NnntB9KIGlv9Cqa?=
 =?us-ascii?Q?g4sT4bAPPrOLXcg6rpVjLZzd48fMmUKjwRe9PTwu68/pMoWcfv8xz5O3ujE8?=
 =?us-ascii?Q?R/8pXOLPfnvSbgacIlHWppPotivYru05lBaP/Pl6v9EnEkVdr8/Lf6ot1ZHt?=
 =?us-ascii?Q?kmXcvPZAAf6OVRY8rG8+PcO7Rzrw01o99oiPtqGEVyVeRTr0CZxeeZgRW3Bm?=
 =?us-ascii?Q?r6f9kBU23MmfZwe1Ds52P/A+Km5yVTSGJLniNxHBY9oVTQDAm80nH1v8UMrR?=
 =?us-ascii?Q?uzE3CQZKXYLIdEiHojnZdZ9Qw5hS13puhwZ209hhpsm3d+9n/637pQa2gDGK?=
 =?us-ascii?Q?WnZLE0ZPGSgVoOe4C+X2TYfrkT2zFwQpisxTdiK5KPIYoREHymgJ9KwyOgic?=
 =?us-ascii?Q?JbuDpHz/XgxBkQym8SKwCSBUnIi8+uJbekN2Y1Vj0cpOyjjbIytawop5GQSp?=
 =?us-ascii?Q?yM7Nhf4/LW62MaUGQWc+3Fk+NaQXhOa51XbqBLexfonAMbiLmsrgRZucBzVf?=
 =?us-ascii?Q?rEWakOQqMnZP98+Pyj6VXjd45gfHGm1XXl498AgyyeHbykqg9mLZmvjzlxkk?=
 =?us-ascii?Q?PHJNT5P8WvW97LVUm/Ryf1m0WKxa0482Cz4OjSCxFIKsWEiLot1jb6j4AsBR?=
 =?us-ascii?Q?rC4Hx55/rr0ZpSNvKzYmUTWUYxUMkfDX6zROSoMU7LVnIVVg4kzwPGRQRq4k?=
 =?us-ascii?Q?OxyeWH0Sz5Bjq6NmCirJ2bys02LjMfKn7O9sGRFUqF0ynxfTzQ/WATQZJABo?=
 =?us-ascii?Q?I1sT7K58IAxBygL7oMgkP5G4UXEboOgc1gRnVa+tqsQ0ATQzftOycSeay3xK?=
 =?us-ascii?Q?CBHfVzVbY07gNmtifEVFIcmQxzRRnp5MlZ86cJOiqVGGGmVb9VfSY7TC2157?=
 =?us-ascii?Q?GGp2dGrwXXxbNGylcZq1BGhx1u8eZmyb8YRL64q8KdZM++JnKx3C/JyJGj35?=
 =?us-ascii?Q?JzftpEd6itpm8kacIS9kcAvxhmENAEd1u6Cbr9C/S2fNkifzv/HcJkgE4or4?=
 =?us-ascii?Q?/9bgS72n2hgWolnITbthhnZNnbMb9/N0+NV03P6XBg2huI9tbV8D44TJRMcp?=
 =?us-ascii?Q?lFwbJtxOgzJUEifLJfM03zFVp054kuiPrV5Swkn/RRKT4wkTuGfnWXt0fu1k?=
 =?us-ascii?Q?TbHsLz85XQnaIL3ytbv5YydNedwcDAj4ZpMe0MgqfdqLKPuXLw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 13:21:18.6235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f8152d-a279-468b-88a9-08dceeae95ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7256
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

First, add an instance parameter to smu_dpm_set_vcn_enable() function,
and calling dpm_set_vcn_enable() with this given instance.

Second, modify vcn_gated to be an array, to track the gating status
for each vcn instance separately.

With these 2 changes, smu_dpm_set_vcn_enable() will check and set the
gating status for the given vcn instance ONLY.

v2: remove duplicated functions.

remove for-loop in dpm_set_vcn_enable(), and temporarily move it to
to smu_dpm_set_power_gate(), in order to keep the exact same logic as
before, until further separation in next patch.

v3: add instance number in error message.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 65 ++++++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +-
 2 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 246f81d73bd2..639bc6d97b27 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -233,11 +233,11 @@ static bool is_vcn_enabled(struct amdgpu_device *adev)
 }
 
 static int smu_dpm_set_vcn_enable(struct smu_context *smu,
-				  bool enable)
+				   bool enable,
+				   int inst)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
 	/*
@@ -249,14 +249,12 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
 	if (!smu->ppt_funcs->dpm_set_vcn_enable)
 		return 0;
 
-	if (atomic_read(&power_gate->vcn_gated) ^ enable)
+	if (atomic_read(&power_gate->vcn_gated[inst]) ^ enable)
 		return 0;
 
-	for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable, i);
-		if (ret)
-			return ret;
-	}
+	ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable, inst);
+	if (!ret)
+		atomic_set(&power_gate->vcn_gated[inst], !enable);
 
 	return ret;
 }
@@ -358,6 +356,7 @@ static int smu_dpm_set_power_gate(void *handle,
 				  bool gate)
 {
 	struct smu_context *smu = handle;
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
@@ -374,10 +373,12 @@ static int smu_dpm_set_power_gate(void *handle,
 	 */
 	case AMD_IP_BLOCK_TYPE_UVD:
 	case AMD_IP_BLOCK_TYPE_VCN:
-		ret = smu_dpm_set_vcn_enable(smu, !gate);
-		if (ret)
-			dev_err(smu->adev->dev, "Failed to power %s VCN!\n",
-				gate ? "gate" : "ungate");
+		for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
+			ret = smu_dpm_set_vcn_enable(smu, !gate, i);
+			if (ret)
+				dev_err(smu->adev->dev, "Failed to power %s VCN instance %d!\n",
+					gate ? "gate" : "ungate", i);
+		}
 		break;
 	case AMD_IP_BLOCK_TYPE_GFX:
 		ret = smu_gfx_off_control(smu, gate);
@@ -779,21 +780,25 @@ static int smu_set_default_dpm_table(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	struct smu_power_context *smu_power = &smu->smu_power;
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
-	int vcn_gate, jpeg_gate;
+	int vcn_gate[AMDGPU_MAX_VCN_INSTANCES], jpeg_gate, i;
 	int ret = 0;
 
 	if (!smu->ppt_funcs->set_default_dpm_table)
 		return 0;
 
-	if (adev->pg_flags & AMD_PG_SUPPORT_VCN)
-		vcn_gate = atomic_read(&power_gate->vcn_gated);
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+			vcn_gate[i] = atomic_read(&power_gate->vcn_gated[i]);
+	}
 	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG)
 		jpeg_gate = atomic_read(&power_gate->jpeg_gated);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
-		ret = smu_dpm_set_vcn_enable(smu, true);
-		if (ret)
-			return ret;
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+			ret = smu_dpm_set_vcn_enable(smu, true, i);
+			if (ret)
+				return ret;
+		}
 	}
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG) {
@@ -810,8 +815,10 @@ static int smu_set_default_dpm_table(struct smu_context *smu)
 	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG)
 		smu_dpm_set_jpeg_enable(smu, !jpeg_gate);
 err_out:
-	if (adev->pg_flags & AMD_PG_SUPPORT_VCN)
-		smu_dpm_set_vcn_enable(smu, !vcn_gate);
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+			smu_dpm_set_vcn_enable(smu, !vcn_gate[i], i);
+	}
 
 	return ret;
 }
@@ -1256,7 +1263,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 
-	atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
+	for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
+		atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
 	atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
@@ -1818,7 +1826,8 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_block)
 		ret = smu_set_gfx_imu_enable(smu);
 		if (ret)
 			return ret;
-		smu_dpm_set_vcn_enable(smu, true);
+		for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
+			smu_dpm_set_vcn_enable(smu, true, i);
 		smu_dpm_set_jpeg_enable(smu, true);
 		smu_dpm_set_vpe_enable(smu, true);
 		smu_dpm_set_umsch_mm_enable(smu, true);
@@ -2021,7 +2030,8 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
 		return 0;
 
-	smu_dpm_set_vcn_enable(smu, false);
+	for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
+		smu_dpm_set_vcn_enable(smu, false, i);
 	smu_dpm_set_jpeg_enable(smu, false);
 	smu_dpm_set_vpe_enable(smu, false);
 	smu_dpm_set_umsch_mm_enable(smu, false);
@@ -2935,6 +2945,7 @@ static int smu_read_sensor(void *handle,
 			   int *size_arg)
 {
 	struct smu_context *smu = handle;
+	struct amdgpu_device *adev = smu->adev;
 	struct smu_umd_pstate_table *pstate_table =
 				&smu->pstate_table;
 	int ret = 0;
@@ -2983,7 +2994,13 @@ static int smu_read_sensor(void *handle,
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_VCN_POWER_STATE:
-		*(uint32_t *)data = atomic_read(&smu->smu_power.power_gate.vcn_gated) ? 0 : 1;
+		*(uint32_t *)data = 0;
+		for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
+			if (!atomic_read(&smu->smu_power.power_gate.vcn_gated[i])) {
+				*(uint32_t *)data = 1;
+				break;
+			}
+		}
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_MIN_FAN_RPM:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 0f074b6c8b58..427441b469e0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -399,7 +399,7 @@ struct smu_dpm_context {
 struct smu_power_gate {
 	bool uvd_gated;
 	bool vce_gated;
-	atomic_t vcn_gated;
+	atomic_t vcn_gated[AMDGPU_MAX_VCN_INSTANCES];
 	atomic_t jpeg_gated;
 	atomic_t vpe_gated;
 	atomic_t umsch_mm_gated;
-- 
2.34.1

