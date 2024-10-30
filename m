Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37AA1D5B86D
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2024 09:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C243610E025;
	Wed, 30 Oct 2024 09:44:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XdJYStJK";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EB7310E025
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2024 09:44:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITFyeN5rM6/+idQ8nJHWYwyw1ubIXlkMd9trRTIRnmMbobu1Z0djs32lzOuba/ZCISmjJ4cpl+sUR0TmUsMBKYMD84MGGrYLiKlY6I7fqWfZKf+pkFkTOmbPV29byKTwkW/pjyc7AM19NZLaoWYUnKXstHrPWJSbpRCMm4ah6lTLoDcsqmCk01Flq8K1ZsjyZG/6MKevAqD/Z0bSWteN1Goiq7emx0TYbWjgoX5TQnLJO3KXWtnyp84gCviecoUavVkyVi+OMmFsL1OuL9n822KHErOXfFqPJ6al0xsu/DgmP1Jl1Fek4WXJ6yPLJzAXCZbRCy1lsn2JIo9HQvwhhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOWPu3PVULKLOZjK8aXIMYqrSSowsrPQoTUdt0Sgcas=;
 b=m7sKyJf5wfmhrXcdg4GPTONpJ03ZevGQpCVgHcao7h/xvBGZBbVmWroaaiS1PPQYFm1jvGKBuW1D4zxkWXOiqPXSfuB10g6IWfzwZULDFjcIWIEJO0Ci4FAhc5LkwidEqelV7169AfhXLeNYyn2GzXe1r/NxRAfz5kAGndeZtEgsKBveYr1ylSpeofxDV4x6Ss6lnbJnOqUaVHdhWn2H5gGC56wAbBuI2SOQ5FNSP53FsNIWTLCICw/UyE5szvpXYG50inP7xheVnCRCAvmEBFK2x4eQPDAOhju5Jj8iKFeFTwPvnmh8DE9aOiavHf4M6NrAhcTB6zc8MStOm+jXsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOWPu3PVULKLOZjK8aXIMYqrSSowsrPQoTUdt0Sgcas=;
 b=XdJYStJKVgwwKMuSCbV2eSdHukUOheBtm72JYJ9kzAaXramEldgMmkS41RB0sDppoqKCmzwZbtMAL8POamv93nKi5ZqHp+uAK4wxz3Nku8C1tGrWcAjKCRCufi7p+bucglbkFE53Oys3e9ySPmqNQRD9cMwlaTlAtXFfvAVMGt8=
Received: from IA1P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::11)
 by CH3PR12MB9396.namprd12.prod.outlook.com (2603:10b6:610:1d0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 09:43:53 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:464:cafe::6) by IA1P220CA0022.outlook.office365.com
 (2603:10b6:208:464::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Wed, 30 Oct 2024 09:43:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 09:43:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 04:43:52 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Wed, 30 Oct 2024 04:43:51 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <Alexander.Deucher@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>
Subject: [PATCH v4] drm/amd/pm: correct the workload setting
Date: Wed, 30 Oct 2024 17:43:40 +0800
Message-ID: <20241030094340.49639-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|CH3PR12MB9396:EE_
X-MS-Office365-Filtering-Correlation-Id: ce901c56-9d61-4764-9c72-08dcf8c75dd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9fK9zlh2e5XJGWZjrv/sRBLafKR4ZOx1cUMRDBhLsLN9QqxlBDaZydr8ubHj?=
 =?us-ascii?Q?3JzJyhEabGBIY7O5utGu8JSTFxsznbjYQVYQVWtWEdnr+D5PXcJnImt1/Eby?=
 =?us-ascii?Q?ORGIErTDgQjFyXLepcWXM4IxKH/sMqq+bOY6f6zMvnU1xfvHUL1jsEcUUdrK?=
 =?us-ascii?Q?8jw2UjfEt7dh38diF7Xki1Gxa5ib+okcvIrvYQZwv11dtk2eR7gdabtLpnZw?=
 =?us-ascii?Q?SEcOmVbDDGP/De7gKLsnXtLj0VScarOUogb4Qu14ktchsYSDpn0PJG2n4IaV?=
 =?us-ascii?Q?7Y6I0Q8iDa2S5kUV3BGQGng/BuDWPB2w4PJWkaiN1Ci0NUUHdgnEibXm2HKK?=
 =?us-ascii?Q?YqzXnqM4TRSau3z6wDbDdkiGwPdB4aT44a3pNM0Sqzwiza3LZWze9oqcYJ8q?=
 =?us-ascii?Q?B2leg1YqY8C0LHwWgQDzej67gveBbTH26mbecxRkLhkksTu6qTE0b6cqwYX4?=
 =?us-ascii?Q?Zca0AEwluqHOOFheLhxqI3jaGBSjZuw3b4qCzlQmcbQN9hm03db9UvdxzHjZ?=
 =?us-ascii?Q?MG2t5JduFa5jB0qk35Fuhbzp/DUCf0P94/OrhoHnyUl4vK+X/c/daQJ+2/fU?=
 =?us-ascii?Q?Nu1gDfEFs06HVPVDST4ISSd3Oh6R6lN+0L1VL36SRQ4zeh8onasFcPAmllkL?=
 =?us-ascii?Q?XrPBN02lPzFRdu2fp9sH0WiW5sHcBjUFtmVhgNGixUQA/vZdv44ZaaIRZ17G?=
 =?us-ascii?Q?5b0Dku/5NBIm6l3CcEzFpr6IOV2v5VDrkuWAC+V8BoVO3wklcQy0R4qNs/mY?=
 =?us-ascii?Q?7n2NK/RR7ivJJWDbfdtBuFSZR29bnj9QAear82gVZEZnNZ6lpPRcP5aId9w/?=
 =?us-ascii?Q?N5MNukpOIo4Fk/P6DIahoBXCNdl6Osv8m6VkiY6OFBAmNeeG1R/3CIjIbuiu?=
 =?us-ascii?Q?ez/W1MpUo15LoJvrxyG33GkgCaTKyLsPwkx8ChzqODsInWDYwrUuUAFS8LSa?=
 =?us-ascii?Q?KG1TuL64dHPRfs0SNPFaXS+WtGx4Sa5j/roVyUswrexNXh5amk0bRadNCqcD?=
 =?us-ascii?Q?Akpsp6lZxxrFCQQ0ircubQMA3sTxXopAcUktE+0szFquJM06IFzS58u+BwRB?=
 =?us-ascii?Q?m8FcWGdMmZ6QgDbPFPtKIwto9M5/xB9nI4iMP9ZvLNXqc/x6gGHglAx06XIe?=
 =?us-ascii?Q?8Ygs9wBfjQfvBCWQ1b/+TSiY5z8IVR2QHQsXlD4CA3kXIp/dGMbje5K+Prf9?=
 =?us-ascii?Q?1dHGoHEeVuoEONXXadzgE8LSHkfKfNaXlH3A94rPH2YlHBe1YChqg0cFKdU6?=
 =?us-ascii?Q?cTOoTpUsW5zo0WbUThxi9cL95QyubnMn7AlYo5U6v2cQnPVJlHIx6+YfOT5Y?=
 =?us-ascii?Q?dMaxFOqsOuHspqu3zDNXTUyBAg5u6hTxIgrEi+aBTLNM66ODFmoN2SLTjOM9?=
 =?us-ascii?Q?f2AKSflqXnCzaqH4TwEWWbtgfYRc2RwSSgJpgd5dg80oJ/tMKQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 09:43:53.5865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce901c56-9d61-4764-9c72-08dcf8c75dd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9396
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

Correct the workload setting in order not to mix the setting
with the end user. Update the workload mask accordingly.

v2: changes as below:
1. the end user can not erase the workload from driver except default workload.
2. always shows the real highest priority workoad to the end user.
3. the real workload mask is combined with driver workload mask and end user workload mask.

v3: apply this to the other ASICs as well.
v4: simplify the code

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 39 ++++++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  4 +-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  8 ++--
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 10 ++++-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 10 ++++-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  7 +++-
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  7 +++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 23 ++++++++---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 12 ++++--
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 15 ++++---
 10 files changed, 97 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8d4aee4e2287..57cbc41f8457 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1261,26 +1261,30 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	smu->watermarks_bitmap = 0;
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
+	smu->user_dpm_profile.user_workload_mask = 0;
 
 	atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
 
-	smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_VR] = 4;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
+	smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
+	smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
+	smu->workload_priority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
+	smu->workload_priority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
+	smu->workload_priority[PP_SMC_POWER_PROFILE_VR] = 4;
+	smu->workload_priority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
+	smu->workload_priority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
 
 	if (smu->is_apu ||
-	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
-		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
-	else
-		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
+	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D)) {
+		smu->workload_mask = 1 << smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
+	} else {
+		smu->workload_mask = 1 << smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
+		smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
+	}
 
+	smu->driver_workload_mask = smu->workload_mask;
 	smu->workload_setting[0] = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->workload_setting[1] = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
 	smu->workload_setting[2] = PP_SMC_POWER_PROFILE_POWERSAVING;
@@ -2354,12 +2358,14 @@ static int smu_switch_power_profile(void *handle,
 		return -EINVAL;
 
 	if (!en) {
-		smu->workload_mask &= ~(1 << smu->workload_prority[type]);
+		smu->workload_mask &= ~(1 << smu->workload_priority[type]);
+		smu->driver_workload_mask &= ~(1 << smu->workload_priority[type]);
 		index = fls(smu->workload_mask);
 		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
 		workload[0] = smu->workload_setting[index];
 	} else {
-		smu->workload_mask |= (1 << smu->workload_prority[type]);
+		smu->workload_mask |= (1 << smu->workload_priority[type]);
+		smu->driver_workload_mask |= (1 << smu->workload_priority[type]);
 		index = fls(smu->workload_mask);
 		index = index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
 		workload[0] = smu->workload_setting[index];
@@ -3054,12 +3060,17 @@ static int smu_set_power_profile_mode(void *handle,
 				      uint32_t param_size)
 {
 	struct smu_context *smu = handle;
+	int ret;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
 	    !smu->ppt_funcs->set_power_profile_mode)
 		return -EOPNOTSUPP;
 
-	return smu_bump_power_profile_mode(smu, param, param_size);
+	smu->user_dpm_profile.user_workload_mask = (1 << smu->workload_priority[param[param_size]]);
+	smu->workload_mask = smu->user_dpm_profile.user_workload_mask | smu->driver_workload_mask;
+	ret = smu_bump_power_profile_mode(smu, param, param_size);
+
+	return ret;
 }
 
 static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 8bb32b3f0d9c..4ffed49ebb4b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -240,6 +240,7 @@ struct smu_user_dpm_profile {
 	/* user clock state information */
 	uint32_t clk_mask[SMU_CLK_COUNT];
 	uint32_t clk_dependency;
+	uint32_t user_workload_mask;
 };
 
 #define SMU_TABLE_INIT(tables, table_id, s, a, d)	\
@@ -557,7 +558,8 @@ struct smu_context {
 	bool disable_uclk_switch;
 
 	uint32_t workload_mask;
-	uint32_t workload_prority[WORKLOAD_POLICY_MAX];
+	uint32_t driver_workload_mask;
+	uint32_t workload_priority[WORKLOAD_POLICY_MAX];
 	uint32_t workload_setting[WORKLOAD_POLICY_MAX];
 	uint32_t power_profile_mode;
 	uint32_t default_power_profile_mode;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 5ad09323a29d..f1e271e4f470 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1449,13 +1449,13 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 	int workload_type = 0;
 	uint32_t profile_mode = input[size];
 	int ret = 0;
+	uint32_t index;
 
 	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
 		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
 		return -EINVAL;
 	}
 
-
 	if ((profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
 	     (smu->smc_fw_version >= 0x360d00)) {
 		if (size != 10)
@@ -1523,14 +1523,16 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 
 	ret = smu_cmn_send_smc_msg_with_param(smu,
 					  SMU_MSG_SetWorkloadMask,
-					  1 << workload_type,
+					  smu->workload_mask,
 					  NULL);
 	if (ret) {
 		dev_err(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
 		return ret;
 	}
 
-	smu->power_profile_mode = profile_mode;
+	index = fls(smu->workload_mask);
+	index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
+	smu->power_profile_mode = smu->workload_setting[index];
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 9fa305ba6422..df158d789ced 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2008,6 +2008,7 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
 {
 	DpmActivityMonitorCoeffInt_t activity_monitor;
 	int workload_type, ret = 0;
+	uint32_t index;
 
 	smu->power_profile_mode = input[size];
 
@@ -2081,11 +2082,18 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
 						       smu->power_profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
+
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    1 << workload_type, NULL);
+				    smu->workload_mask, NULL);
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
 
+	if (!ret) {
+		index = fls(smu->workload_mask);
+		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
+		smu->power_profile_mode = smu->workload_setting[index];
+	}
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 77e58eb46328..7263e53eafe1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1713,6 +1713,7 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
 	int workload_type, ret = 0;
+	uint32_t index;
 
 	smu->power_profile_mode = input[size];
 
@@ -1786,11 +1787,18 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
 						       smu->power_profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
+
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    1 << workload_type, NULL);
+				    smu->workload_mask, NULL);
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
 
+	if (!ret) {
+		index = fls(smu->workload_mask);
+		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
+		smu->power_profile_mode = smu->workload_setting[index];
+	}
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 6c43724c01dd..fa7b45208777 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1058,6 +1058,7 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
 {
 	int workload_type, ret;
 	uint32_t profile_mode = input[size];
+	uint32_t index;
 
 	if (profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
 		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
@@ -1079,7 +1080,7 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
 	}
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
-				    1 << workload_type,
+				    smu->workload_mask,
 				    NULL);
 	if (ret) {
 		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n",
@@ -1087,7 +1088,9 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
 		return ret;
 	}
 
-	smu->power_profile_mode = profile_mode;
+	index = fls(smu->workload_mask);
+	index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
+	smu->power_profile_mode = smu->workload_setting[index];
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 0b210b1f2628..4aa3bf005850 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -866,6 +866,7 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
 {
 	int workload_type, ret;
 	uint32_t profile_mode = input[size];
+	uint32_t index;
 
 	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
 		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
@@ -890,14 +891,16 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
 	}
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
-				    1 << workload_type,
+				    smu->workload_mask,
 				    NULL);
 	if (ret) {
 		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
 		return ret;
 	}
 
-	smu->power_profile_mode = profile_mode;
+	index = fls(smu->workload_mask);
+	index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
+	smu->power_profile_mode = smu->workload_setting[index];
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 8d25cc1f218f..1023b39ac995 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2473,7 +2473,8 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
 	int workload_type, ret = 0;
-	u32 workload_mask, selected_workload_mask;
+	u32 workload_mask;
+	uint32_t index;
 
 	smu->power_profile_mode = input[size];
 
@@ -2540,7 +2541,7 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 	if (workload_type < 0)
 		return -EINVAL;
 
-	selected_workload_mask = workload_mask = 1 << workload_type;
+	workload_mask = 1 << workload_type;
 
 	/* Add optimizations for SMU13.0.0/10.  Reuse the power saving profile */
 	if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0) &&
@@ -2555,12 +2556,24 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 			workload_mask |= 1 << workload_type;
 	}
 
+	smu->workload_mask |= workload_mask;
 	ret = smu_cmn_send_smc_msg_with_param(smu,
 					       SMU_MSG_SetWorkloadMask,
-					       workload_mask,
+					       smu->workload_mask,
 					       NULL);
-	if (!ret)
-		smu->workload_mask = selected_workload_mask;
+	if (!ret) {
+		index = fls(smu->workload_mask);
+		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
+		smu->power_profile_mode = smu->workload_setting[index];
+		if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING) {
+			workload_type = smu_cmn_to_asic_specific_index(smu,
+							       CMN2ASIC_MAPPING_WORKLOAD,
+							       PP_SMC_POWER_PROFILE_FULLSCREEN3D);
+			smu->power_profile_mode = smu->workload_mask & (1 << workload_type)
+										? PP_SMC_POWER_PROFILE_FULLSCREEN3D
+										: PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
+		}
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 23f13388455f..056c45453a36 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2429,6 +2429,7 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
 	int workload_type, ret = 0;
+	uint32_t index;
 
 	smu->power_profile_mode = input[size];
 
@@ -2487,13 +2488,18 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
 						       smu->power_profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
+
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    1 << workload_type, NULL);
+				    smu->workload_mask, NULL);
 
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
-	else
-		smu->workload_mask = (1 << workload_type);
+
+	if (!ret) {
+		index = fls(smu->workload_mask);
+		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
+		smu->power_profile_mode = smu->workload_setting[index];
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index cefe10b95d8e..f139c338e822 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1787,6 +1787,7 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
 	int workload_type, ret = 0;
+	uint32_t index;
 	uint32_t current_profile_mode = smu->power_profile_mode;
 	smu->power_profile_mode = input[size];
 
@@ -1857,12 +1858,14 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
 	if (workload_type < 0)
 		return -EINVAL;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_SetWorkloadMask,
-					       1 << workload_type,
-					       NULL);
-	if (!ret)
-		smu->workload_mask = 1 << workload_type;
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
+										  smu->workload_mask, NULL);
+
+	if (!ret) {
+		index = fls(smu->workload_mask);
+		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
+		smu->power_profile_mode = smu->workload_setting[index];
+	}
 
 	return ret;
 }
-- 
2.34.1

