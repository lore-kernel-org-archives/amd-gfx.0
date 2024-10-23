Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F10CF5389
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 13:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59F8810E194;
	Wed, 23 Oct 2024 13:23:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qXaevFz3";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C9DA10E7D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 13:23:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fz0EoGuB7L31f8tpR+hmlSJ+iJzDmmnkbDX0VIIiv1cIpJrOffdfHvaeJzIxx6tdNENE5pkFySetzSHn5Fre2OKTak/bLrZ5BEGSlf56w44qMWAT5UUdSXykaNmvPhuyN68sCdFwwubvv2xmj1xfeA2Io8zXqx/l0sRS8dCTFVCV6+az9jk4PDM7UWPBOX1IS+rHOXsn1toP/W7QAO4YpQ8ojR+SBOFttwkQCNy+gcxw3V1DFDgIt+OqmRJAmhYU8wu4M91YZCsvaVYb+TpxlIVVyi4/SaX+63/u4FWQLvn9vzR+DVYi8OBujRd/VtA5FWeljFeuygsRWMnf9Sj4RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcexUbZ6PRyZd2ipd83kokWn5IPH3MWAo15uqtPy9L8=;
 b=TLpHD8LJ2fLX3/7LGFqL+O9doWFSvi48nz82F1OzsGhUagb7Q4Ksq48zbjwChx/hU+78Xj69r0nNoaFzQjRhHu9m7UwXrEPLdacQXRt5YNK/tmCk8/VZiVToJD4hfemiKOTsaheKy5mdwZE4pBRIOslMtw8dCo+vu1BAOc3uqOayLBZ+vRc9XFrbLEce2FSyTZDpn7NLf1YzQxTNAgh93Lxqblh0Dw/1upjlc1B4Tc0ntraZ994aumdXPi9NKp7tARN94sEPDGaVGHRvkjqrs5UkqDdiHmbvxPg/+GtW8q4RWW98r2cqAt9eQGMfd5scdvMu1WL+DAcc++iSWUlSFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcexUbZ6PRyZd2ipd83kokWn5IPH3MWAo15uqtPy9L8=;
 b=qXaevFz32fTjEVU7azW4BLav5sPcNz2W9NINwI545/G9VAAB6btwrmCFWmCdCCWr7ClOu9kyfPHJieOTlbEUHWesMiFrIyozxRCLVHz0I9FnUX3fNMkFSjQHsWxloZ7brGzF0TIbxpbFgv9zM0f4uqxZ8rtM4VF4zGOsJqxSpxc=
Received: from BY3PR04CA0020.namprd04.prod.outlook.com (2603:10b6:a03:217::25)
 by CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Wed, 23 Oct
 2024 13:23:12 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::b8) by BY3PR04CA0020.outlook.office365.com
 (2603:10b6:a03:217::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Wed, 23 Oct 2024 13:23:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 13:23:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 08:23:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/smu13: fix profile reporting
Date: Wed, 23 Oct 2024 09:22:54 -0400
Message-ID: <20241023132254.329135-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d68549-499c-4f6f-af6e-08dcf365d786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xGanUQSrjisNqp4i8VmOzUwRCCwYnGEzonlpiTAMgASBULYfSLIUF4SpzQVm?=
 =?us-ascii?Q?FITf6+pmkuV/X+IbNOHgRA3RHSvr2jgFewzQObTJoDJmAyBPZt24dFW41+1C?=
 =?us-ascii?Q?BxJK2ULCjlqNSGh1AWJSEavwjz/XehZXfFX258XupLcFNFb8QgdSgcQog1Z5?=
 =?us-ascii?Q?IudawANuEdpcnOKkUrdh9uawMStrzLTSCLFqgjNCw27LgTS3fVQmyFK5bPHO?=
 =?us-ascii?Q?rYpFO3IPqDOVyLqDGFQOxPZhexcU73I5kAXGnUeSUsQg7WdyeQocYRpXeIo5?=
 =?us-ascii?Q?zSWNVXV8uy9Vg1TZz7cinx1AyW1hcBZ03hWI+ebAHoKizxUGPAyu/JB98gLu?=
 =?us-ascii?Q?zNHpPxJtBzMIWHHvt+NRz7VCyjkfd46SvLk8RjnOkb0JbY644AImIweALs3n?=
 =?us-ascii?Q?nQKfWghS9CkjnPLY7INRyPefeHoHA+olJ111JOMslG6YSw3j12X1gciGT9Nq?=
 =?us-ascii?Q?Ujg+L9LyI6bu+5GrykAQPSfe7QZtJkc0SoTqN+sy2bh01Jp043DcxBR4QwsE?=
 =?us-ascii?Q?opzf4pEaNGi64U0w2cYw200hJPG736/juSW0wDm5FGuk/vNTfwg3rv+ZP2p9?=
 =?us-ascii?Q?M2E9SWtUyWKSjO0azFc+QCqNpUr4xuPJFc1/FZQPoCNKkGr2nplYXy7/1Jgi?=
 =?us-ascii?Q?Iu8v2BP1rFh0FvOVrCJpownmfVR4jH1Bo1UnbhF1bnXQIbszR5msDzLndo3u?=
 =?us-ascii?Q?lT35Rj+aUoW0kasIaks55xfxGG35bS4XlWSPVRjkIGAM5hOp7r/m5Nr+IAu5?=
 =?us-ascii?Q?R0ebcsT8ynSDitmQcNTwm5b16tEKk8rK6GPO17oOU5fM1HSGc0HpE/jm6tjB?=
 =?us-ascii?Q?pwFzT7U6ImkPMAX7LoFXZ20SRJVooloXEgySZRt4Dx47ezVffYan6p9iEOca?=
 =?us-ascii?Q?hQtNVcYDEl3L84F3buBI1UqrpmDt/KWxZtEb7IMSwpFfoU8Holi7GvVuV95K?=
 =?us-ascii?Q?TruwV2Xnaj90B9fykjLuXPutoX99jl0lHx0Iar759326Pu30jt7ZYWAu09w5?=
 =?us-ascii?Q?BCM7zPhW4+xN+HHqqkJ0tIvIkSfIf/X5qlLf/QoK9jOcAJG/nhJ8RkTQH7ss?=
 =?us-ascii?Q?me9OsQfklh6rZglmAUuaU+lK+1gNDZa9Erxa6fSpJHfF9q9FYICkHSOX6W2i?=
 =?us-ascii?Q?t19wDHDW+zar2tHck66y6gZSyQVFO+wcVf8wiPbn3thwTRLZhgV7COVKDYf0?=
 =?us-ascii?Q?SwSSiXqkAEwBoVhsnY2KnSlsBUaW8RcNfuPpnC1lLRYbtH4RtkO0hOvIVEgP?=
 =?us-ascii?Q?bOUCuuY4vIovLGulN79YyElUMMmAw9yg78QisZpKCY5ApnwBWya0+GWVANCO?=
 =?us-ascii?Q?J9B5ex89xQmtx9tD9tuiHaTHXxZDOPE4ZdPmzYIXt5V4kTUQHyyikkTGxu/Y?=
 =?us-ascii?Q?fxUoZ2h9q1EK9gItVliWnLvRnS6BflaBT1A3QYWuZaFfHWb87A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 13:23:11.1067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d68549-499c-4f6f-af6e-08dcf365d786
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593
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

The following 3 commits landed in parallel:
commit d7d2688bf4ea ("drm/amd/pm: update workload mask after the setting")
commit 7a1613e47e65 ("drm/amdgpu/smu13: always apply the powersave optimization")
commit 7c210ca5a2d7 ("drm/amdgpu: handle default profile on on devices without fullscreen 3D")
While everything is set correctly, this caused the profile to be
reported incorrectly because both the powersave and fullscreen3d bits
were set in the mask and when the driver prints the profile, it looks
for the first bit set.

Fixes: d7d2688bf4ea ("drm/amd/pm: update workload mask after the setting")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index cb923e33fd6f..d53e162dcd8d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2485,7 +2485,7 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
 	int workload_type, ret = 0;
-	u32 workload_mask;
+	u32 workload_mask, selected_workload_mask;
 
 	smu->power_profile_mode = input[size];
 
@@ -2552,7 +2552,7 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 	if (workload_type < 0)
 		return -EINVAL;
 
-	workload_mask = 1 << workload_type;
+	selected_workload_mask = workload_mask = 1 << workload_type;
 
 	/* Add optimizations for SMU13.0.0/10.  Reuse the power saving profile */
 	if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0) &&
@@ -2572,7 +2572,7 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 					       workload_mask,
 					       NULL);
 	if (!ret)
-		smu->workload_mask = workload_mask;
+		smu->workload_mask = selected_workload_mask;
 
 	return ret;
 }
-- 
2.46.2

