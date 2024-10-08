Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DF7CF0428
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 21:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8934B10E5C1;
	Tue,  8 Oct 2024 21:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J/R2Du1/";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEE4210E25B
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 21:16:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4n85Y32JlyB4347mBNUIUmXmwpRvVmhX4R/V4viswiSIaPE093jZzBUCivTHKNT+Rp9Al9q590fT7RP1QhLuiQELvq4kVDY0MtExi/Rasn3Hs0XbTl/pXj9+Qc/jofehSWfQW4dKdk/rzssobUatDDeOpkGK4u1XiWlPvOGhP2o4KF0G1V3ror/m2UavaVijqXF9yikVWF4cFYlVFshwlyf/WK6A9pC1P8K6bMs2rFpNnrF6cURDYy7/LBGxFZ40Y6C7jiorzVQaCAoTHcE6gN+1JSwcoa2pVNTLD6WxYtEzMpiNhp6MC+VViV/KJhYauQeVZ8KMRw7BGIJHFu1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oW90LzQkb9V+79WFx0DjynAAhVbLDLQ4GvbARVrHd8=;
 b=zSDa5EmtteCrGA0zu67+lKFlsmPcZBeflFJNFAnPaBQwwJx34z9yenCvE4hXgoCXWxKLrR/jO60jGsqxB7R8/uAqahVJa417x/lesO2q2wf/B8FnciRgQ0ftJfXdxRJuEA3OPYzXZJqzvqzTy+T4hTy651nR38iAXXVDXkqGojwvsN9V+Su3+rESyA7Uu+5gjH2CMhsOjudzs2+u6khCm3HcNKU2TBx19aGSQpte1YcA5yKFW0PyhWXt2caY2BEu6tf1U5DlOfgMlbSOfA+HQcX6s6HVcrh9DNfNRaVvw5uAhkq/zx7mDT30FSJsEoOny3clV/WIX/9qxMXPGQIZKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oW90LzQkb9V+79WFx0DjynAAhVbLDLQ4GvbARVrHd8=;
 b=J/R2Du1/lcFG6YkHFCIyTW7lvetbDb4xfID9PmpH6El5Gz/MwcBi63f7QhjkjT7qPgyCbLoDOvPzStnsOBouYFluIpsncs/ht/XO+JaaTfVPgFJVd2ndLVsywCU/6BUt6MiBxUzr+if/qXTYFdCHSs2ZRnYjMH1NyVo7zV7xRCQ=
Received: from CH0PR03CA0417.namprd03.prod.outlook.com (2603:10b6:610:11b::6)
 by DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 21:16:21 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::76) by CH0PR03CA0417.outlook.office365.com
 (2603:10b6:610:11b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 21:16:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 21:16:21 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 16:16:18 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 03/32] drm/amd/pm: add inst to smu_dpm_set_vcn_enable
Date: Tue, 8 Oct 2024 17:15:24 -0400
Message-ID: <20241008211553.36264-4-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008211553.36264-1-boyuan.zhang@amd.com>
References: <20241008211553.36264-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|DS0PR12MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: c759f0ca-1bc3-4c5c-0994-08dce7de753d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UEp66zUrN6ag4M+A448dIrX8YyQLmhi1w6gCmw0ow5b0Cwh5Jy59xUPgDyOX?=
 =?us-ascii?Q?j590AcRxR26p4uPcNPhG27GFiyCAcGj8bibjxRZsdc2MsmgnzL3B4/P/JYAS?=
 =?us-ascii?Q?YnV6fJz+xRQhdMsaeJWH+WFaZMAoa9Q4WjJ77dID4Ej5z5OtRsIXKY6U6zzi?=
 =?us-ascii?Q?acEX2weW1rIEbbNmLyYLn3BB8qBaJhd0CpR+SG0OctUA42FmXpLNt49w6MRv?=
 =?us-ascii?Q?aRwsezcB8bNdYwWarQ/wqR74gE4y/GX2vZxenwUBpNJh0NElPqYnPHFxWSi1?=
 =?us-ascii?Q?EY3S99JKMx0KnNFj9ibA6/IICbVPRAgPpDONuEY7onj6i/Z/SEkMnCvWS1eR?=
 =?us-ascii?Q?0L0KjIxOEtDHO49lZxgpLqAQWvTeTRH53Xs+4CthgBP8lVytWVM/kNu9GHXy?=
 =?us-ascii?Q?LpvGwCFmAlVq7Cx9m9lxHSzEml4lLZcwQo3/FXTeIniK6Em000SHdA9VO/OP?=
 =?us-ascii?Q?dgn2/wHY/2Axooad2w41vi5xkwK0g/KZjLeTIgqWX+uLFlp2PgzACuLxv3EQ?=
 =?us-ascii?Q?rAjUmbee9Nr2wmtUpPAWgvcAcYsW4zCASkxP8SOSW7DmpREX2vULKoPJOE2c?=
 =?us-ascii?Q?9wTpb3C3RcYLErzEmzjmumHlgT1aDdI9mfxQXiOhhilsb8wYsFyPFQQrQ3Sh?=
 =?us-ascii?Q?/CqxhwECM1UERPEXvSRAQABIJ3cKlxySYGXIopD9E0vUs0JNuUabGKmf4qUY?=
 =?us-ascii?Q?y/6J9bMAOE1MZikYj0pjpk/taODAYOnWgPp6IQf75MmhCZguq1fybLZWqdb8?=
 =?us-ascii?Q?gO9oovcmW00rC1idrBoSCTVA6ofZzP/t6uM+5MSyEq+/djTRMKV9mbK9ZPHM?=
 =?us-ascii?Q?IdycZNgOm4IFKJMhmMEZY+q2Fb3RyknrezvwknY6Bo3JVmVclIGLaIa1efyr?=
 =?us-ascii?Q?gNLYSuvQOX9KoXJ+msvFYKrsHWo9ANE5gyZrqlIwDOi6cmVDhD11wPWXJSto?=
 =?us-ascii?Q?bbNpZmIRbG4AifBf3Wn4kp72o0Bhr5DOUkV6KIB0soaL7QHO3Nuk7Iki6rl5?=
 =?us-ascii?Q?t+3YAtyjpqj0iRDOPJYqLfOEeeln3CTCpUPh5voJEqtrB8P8v2MOJNV5EXfs?=
 =?us-ascii?Q?glSbMqdKnvmXL2HuBkPgp+SngMaq2bSTAJ5iyHa28fwZ6Pozpnkn4kHFx6hy?=
 =?us-ascii?Q?yDGKgtaZJAclXMIA2QIXZdge5/hqKznl1gAfMEy8kJkDnUTxLbrKzDuhxFeZ?=
 =?us-ascii?Q?rSe3h02n098Se0bsLT4GbOTGngpnhLJd4BmMTQg4mLw9IkbQ7OylFqAi9+Vc?=
 =?us-ascii?Q?Q8zZa5f7kYUpgK8Kqlb0pDTi2I5xHM/Caz5cANYj3PgvvkirblPFFrQOp6zQ?=
 =?us-ascii?Q?mv1H7dnQmV045LpDr6SunDfdk49STSunbWqV0aj/9zfXPK4PE1Ze5MUBfNVK?=
 =?us-ascii?Q?H0gXPug=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 21:16:21.3583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c759f0ca-1bc3-4c5c-0994-08dce7de753d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629
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
 2 files changed, 41 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 410d5baedfbc..639bc6d97b27 100644
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
@@ -249,16 +249,12 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
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
 	if (!ret)
-		atomic_set(&power_gate->vcn_gated, !enable);
+		atomic_set(&power_gate->vcn_gated[inst], !enable);
 
 	return ret;
 }
@@ -360,6 +356,7 @@ static int smu_dpm_set_power_gate(void *handle,
 				  bool gate)
 {
 	struct smu_context *smu = handle;
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
@@ -376,10 +373,12 @@ static int smu_dpm_set_power_gate(void *handle,
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
@@ -781,21 +780,25 @@ static int smu_set_default_dpm_table(struct smu_context *smu)
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
@@ -812,8 +815,10 @@ static int smu_set_default_dpm_table(struct smu_context *smu)
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
@@ -1258,7 +1263,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 
-	atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
+	for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
+		atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
 	atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
@@ -1820,7 +1826,8 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_block)
 		ret = smu_set_gfx_imu_enable(smu);
 		if (ret)
 			return ret;
-		smu_dpm_set_vcn_enable(smu, true);
+		for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
+			smu_dpm_set_vcn_enable(smu, true, i);
 		smu_dpm_set_jpeg_enable(smu, true);
 		smu_dpm_set_vpe_enable(smu, true);
 		smu_dpm_set_umsch_mm_enable(smu, true);
@@ -2023,7 +2030,8 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
 		return 0;
 
-	smu_dpm_set_vcn_enable(smu, false);
+	for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
+		smu_dpm_set_vcn_enable(smu, false, i);
 	smu_dpm_set_jpeg_enable(smu, false);
 	smu_dpm_set_vpe_enable(smu, false);
 	smu_dpm_set_umsch_mm_enable(smu, false);
@@ -2937,6 +2945,7 @@ static int smu_read_sensor(void *handle,
 			   int *size_arg)
 {
 	struct smu_context *smu = handle;
+	struct amdgpu_device *adev = smu->adev;
 	struct smu_umd_pstate_table *pstate_table =
 				&smu->pstate_table;
 	int ret = 0;
@@ -2985,7 +2994,13 @@ static int smu_read_sensor(void *handle,
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

