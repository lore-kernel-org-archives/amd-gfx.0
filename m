Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6346EE77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 22:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 135FB10ECAD;
	Wed,  8 Jan 2025 22:56:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M33HY07r";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A51810ECAD
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 22:56:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IT15N6TjTtHWTrZ9/ltpxSwgb6+s8Fwne/puXwxjnlgy4/nbMQ45t7g1nrbLEGNoXRLJ8c5jSVmqrIdt129+YDe7ob5KFaMGrRS+DFLTaAw7d0Tf+05WC9iwl7cptxVuE6y3K2/uXOcLuYcwD3M6SZlOEz0f8UDVNFyPdsDlvUOpnsHFmhpZ++FPVSraD8eJ+LgsooMBLHYMv8eDwm0cXfPdiquQYXTaKw6j/xrS02H6NVAHwoV8GrfJvDoW62bPtfu9oYQHMZPKLzrj1qfC0+sTSeZ5P7Ltt0jAnuDiZONYy7tSUMxArGQ22Pn0lpSU0zxxO+UeSjbPl0cJVE2F8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxNJWhzMygi7PHH7lRyFIkNaM+pzIf4JV8kKlaTDS88=;
 b=jG6RyltE8csn4KEFYUB/MDo5BAQ7wmJtOFixB4sHizPF3MK/LEmWG+SjDBpcFDuDUSzbnRzR4rTp0Vgzabn5/I4lrHvheyYp2MZspIP61FQeOmym42nkkQWoDWhs13OzorO9uxoEqVmMM0kUWw7Bo2zKXlT3l7W9uUdNclwIq1Se6kK2TN/wBnTo3oM9zrq9V3YiTRJtepJbGBobp8CTtVLU6oLiIupAhf7qC04YRcGBJ5F0dVow1M9crHU0DvFzBC4lM9vds5PmB0ywYpu4ZgWt9NPUgcPQoqxkEgPwT/wXzk4N7BvmIlWeJ5zejn+KjZ0DmH5pIlGDA00KXFQXUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxNJWhzMygi7PHH7lRyFIkNaM+pzIf4JV8kKlaTDS88=;
 b=M33HY07rJIbRA6chjMv3daLFx+liAOLLWKc4FPjtcTJrVjJElmCnMahRe3kknxNCp1OGA655g1IYZ7Zlha6PNXmlObMn4saHENlex9FLZU5ZpSvInUHnKx2BhMJbXim59D7uV5MPCFzbPTtx5SPeqgrptIjyaV2xvRVlw8ZsjFc=
Received: from PH3PEPF0000409C.namprd05.prod.outlook.com (2603:10b6:518:1::48)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Wed, 8 Jan
 2025 22:56:49 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2a01:111:f403:f910::2) by PH3PEPF0000409C.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Wed,
 8 Jan 2025 22:56:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Wed, 8 Jan 2025 22:56:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Jan
 2025 16:56:46 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <aurabindo.pillai@amd.com>, <kenneth.feng@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 5/5] drm/amdgpu/swsmu: set workload profile to bootup default
Date: Wed, 8 Jan 2025 17:56:27 -0500
Message-ID: <20250108225627.14063-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108225627.14063-1-alexander.deucher@amd.com>
References: <20250108225627.14063-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|DM6PR12MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ff11191-9e6f-4c62-5fd1-08dd3037bc33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DfmjzRiKUfaLE8u5weu0TkRIrnIEsLRKF7sC61/HANP78zShDMsBJ27bifNK?=
 =?us-ascii?Q?mab28OG6uTpgwWD18HkmPPNuhjbB0U+ImMOY6FR4bm3N5pbKdyfVpDkEIscW?=
 =?us-ascii?Q?8oRahwniiRPQWwre+izXkj37kaGwsyPriW0YISk3GIDUWUVgDhHrQ0IDAHVO?=
 =?us-ascii?Q?+bvPDc2Antz9NpmtVJGsIZN1g5gf/iiSwpZYcU/fdDgbislQrdVsDusD4BO5?=
 =?us-ascii?Q?Va1mdc43EBAWF2VCKRAx5h9EIqoNc3Su/Womh07ZglSfpHZWlgKR3NauM1+e?=
 =?us-ascii?Q?RcUnskebU+6NeAaxSy2eX8nX6fN76pgMSPyZwUmCCLmD21HFUEQtcJMZw02R?=
 =?us-ascii?Q?MvZSnSbyY1m/kee/Rwi4aw/KZiCH+V7fnAhEr61/iaUDTtYmUcy4njddQi8j?=
 =?us-ascii?Q?4hgI8GIZtXQkz1W0/PYVxq9LuxcYWVX2+gvgXr4V60TMe9Sdxp7zTZjJrNPO?=
 =?us-ascii?Q?6gopmdozb7UYCcm1zZPinf1UlvOKv5VWUnTznFtZtMf5iJDiNce3HTyD9mra?=
 =?us-ascii?Q?oVytTURJmS+C5Y6ME/00NDNdwUEvwi1jJ8YPKh8qeVd+oFX6DcaoquJfNJR1?=
 =?us-ascii?Q?YRc7GG6LI2IYjRLyydcZvEYfhLBXAbZpLb9M31EY/p9VN2C4v2AKKiRsmBGG?=
 =?us-ascii?Q?kUqfdcRyc5rJmuDkkHlQHohRhT5I19B3b6KDyhW+2e7IqIfrNUfvy+sp2Ojm?=
 =?us-ascii?Q?r7mMwT3INlGRBJvRBIPz8nWjwFvz+E3WnAa2RIalpYCdrvWzYNn4mNB+5rvQ?=
 =?us-ascii?Q?Ya8kI/uAlcKgBST2V8dl8Awyg+zaIgJOhFvH/c+Q0bIi5xxzgk1zPylOFlBF?=
 =?us-ascii?Q?3l1yDlO23et1JjpeyLTr4/m/So5LVBxChLvPGv2Pnc/ePKpgdiETKuFz4gXk?=
 =?us-ascii?Q?PxWzDvuRAPx8YcGQGbMPcl5t7b9Li9CDRmZnQRnllJPpAc+TPq8Nu3U4A0t/?=
 =?us-ascii?Q?xRFxkF2uwzTEU+B1uZT52Cm5gEjxp/M+IANWyVJ+fAFJVU5GBoirAbX+uhQA?=
 =?us-ascii?Q?0V44bUCwCmIjYC2UeHQj3vgaodrQ9yrggyq4ABktA2xGseXlth/5PG29AOID?=
 =?us-ascii?Q?dx/TDPwRZBqYzNbCID6W6SuKLr1p2lzpYNr9YQbO1tGqfJnEPNuEfqslUi32?=
 =?us-ascii?Q?kVtfGri1fxYo9x0nRZuaVhjUUCUKDIQCt27h2rGw9gpzVBbvzPV7aasW0tq7?=
 =?us-ascii?Q?fZqcM3de0tWw9i29JCCjjPv32MihMNuJiiC7eUHgTheQ62UYdGVX+LkH0/Q/?=
 =?us-ascii?Q?ZJAqZrO/YWpLUeke01jYX35aLZBILofC6D9qmugO1m6bUtkNQ7ZVADMpvWPC?=
 =?us-ascii?Q?ODATLkM2lXOKFtjfcY/DVIbwWltMpMvHoRma+InG6dJkQejkGpERHphrEDXY?=
 =?us-ascii?Q?plo+itWi+kDcsjmvTTNBf+9eQLNR03soWmVfpT6NVw7jawaUcksR2MWct+eM?=
 =?us-ascii?Q?1gaheNLCdJQw7qklKcGQWR//rSvDLSmzPLz3Xnl4P3+drU/jqc951CLf7fqb?=
 =?us-ascii?Q?WPAIJJSUxX46Cz0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 22:56:49.3577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff11191-9e6f-4c62-5fd1-08dd3037bc33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121
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

Now that we can select a workload profile dynamically when
we submit work, it's best to default to the bootup
default workload profile.  Defaulting to other profiles
prevents some power management features from kicking in
during idle periods.  Once all jobs have finished, the
workload profile will automatically move back to default
bootup for max power savings.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 21 +++----------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  1 -
 2 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8ca793c222ff2..671a44bf5ba56 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1251,26 +1251,11 @@ static void smu_init_xgmi_plpd_mode(struct smu_context *smu)
 	}
 }
 
-static bool smu_is_workload_profile_available(struct smu_context *smu,
-					      u32 profile)
-{
-	if (profile >= PP_SMC_POWER_PROFILE_COUNT)
-		return false;
-	return smu->workload_map && smu->workload_map[profile].valid_mapping;
-}
-
 static void smu_init_power_profile(struct smu_context *smu)
 {
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_UNKNOWN) {
-		if (smu->is_apu ||
-		    !smu_is_workload_profile_available(
-			    smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
-			smu->power_profile_mode =
-				PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-		else
-			smu->power_profile_mode =
-				PP_SMC_POWER_PROFILE_FULLSCREEN3D;
-	}
+	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_UNKNOWN)
+		smu->power_profile_mode =
+			PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu_power_profile_mode_get(smu, smu->power_profile_mode);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 55ef18517b0fc..19f47811f6db2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2811,5 +2811,4 @@ void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
 	smu->workload_map = smu_v13_0_7_workload_map;
 	smu->smc_driver_if_version = SMU13_0_7_DRIVER_IF_VERSION;
 	smu_v13_0_set_smu_mailbox_registers(smu);
-	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 }
-- 
2.47.1

