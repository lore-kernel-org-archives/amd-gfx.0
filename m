Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B8DC27C65
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 08:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8E7610E6FD;
	Wed,  5 Jun 2024 08:34:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vNkUSYjj";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 366A810E386
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 08:34:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnVE1Y1F2ofuD3jR9vWhOIAGg+XSOVJD4eUyeS3AEAxNnixnoltFX3tkacK75RHX58TnVbn1N22ItSA1tAn9CM31w0qv5Bb5l0LVzv0e6pi6GcfSe9R0NuQ/inlDsD0k8CLrhROMSjedQYoXW/IpANs8A++xH/Ukdu92YOrDWIsdBA08Q6GbUSgaMh+a9z08kdDLWzjy5D+hqCf5+EtBoVxBEFRGq//5s55UWy7ADDwwhw5bVSaKL/N3LKOjhssEm9gF/pwusCHQzEdsZVaLxrHkMvZ0xFVSa7cWXw2iS54o7McdIG0DkB58IbQycDV4YSya9d2aIufpwfcHw5hvmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nypryTHASJB1GL1x2NDkHVhLEKDyLTYr8WhIDO5eR4Q=;
 b=N7TOta3um7GMb1bWYKkl3LXTnJ8d5cWY6fFSe6FsXvKF8P0AE9PBywa+6MqJDzqAQEGkk6whP458O0siwN1ACeOGjNtGMjaQCgZDlo+t3HUeisohrshSixRUsnjO4iPP+mdjBTioG/aWu8Ge7UsOOwIUB9Z4Gr7nt6RNI6HTn2OrL7Epr9OiNco7teU79mFslatekF//8/ySRbXHmfToN7CFq70PqhlBjMbCBoQngebDMKhd05nQzIgZIbsn7PYBc6zxnC3qBmT+7tgbHpJrhL1vmyukfGiC+LHmUveOVSaZx77Wq64VklXaciVCx0J0ERXwmRdDeqvgapViiD1ffA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nypryTHASJB1GL1x2NDkHVhLEKDyLTYr8WhIDO5eR4Q=;
 b=vNkUSYjjYubi0b8OA/1oKwq2fdPFnPlM30/716MVDGpdYgmS5sy5OLNtG2biiHz8zBx3zCKukFm7xDCx0z4clJC3Z4WnjgYoRAK8oQymQlv/BbQ4Z6VkJ4L4TAD5/pxVI9C2NjigEb0TjFE03rmeLABu7iL2iCKJz9LuZ2wg1fg=
Received: from SA1PR05CA0019.namprd05.prod.outlook.com (2603:10b6:806:2d2::26)
 by MN0PR12MB6342.namprd12.prod.outlook.com (2603:10b6:208:3c1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 5 Jun
 2024 08:33:56 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:2d2:cafe::56) by SA1PR05CA0019.outlook.office365.com
 (2603:10b6:806:2d2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.16 via Frontend
 Transport; Wed, 5 Jun 2024 08:33:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 08:33:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 03:33:54 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 5 Jun 2024 03:33:48 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 1/12 V2] drm/amd/pm: remove dead code in
 si_convert_power_level_to_smc
Date: Wed, 5 Jun 2024 16:33:47 +0800
Message-ID: <20240605083347.3216852-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|MN0PR12MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: b29960db-21e2-4a31-0440-08dc853a3d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kieo0gQFNaYtt0q+UF98S3Bc1C3YLJBxP64tJGtAOjGwwyvvOehP5pleM8Vb?=
 =?us-ascii?Q?75SLIH8KCXAKeMMOq0WDFSBhK4QTmDs7gn+g3b7k1YocgQA8QPb+PCHABKP1?=
 =?us-ascii?Q?Baingg5LHbCA+fvp84tGxJF0fwk0wmZ+FxDZSP1aryWcY9dkEfdpzklNuhWp?=
 =?us-ascii?Q?Cji89aIAatS0w2NdpXz/IqLq594OCsG2Wwc83RcFEWk5AS8COELBvZjhn7G4?=
 =?us-ascii?Q?BCRP4YwZq5NZd+mB36tSFq3U+KiwcoUS+V6gt56x2U9L26ITuRcJdAHt+2sp?=
 =?us-ascii?Q?ASrnRSsWNy4ZBdYXW/X4v1vEauL9SneF5JWZ7U9xLjuIfr3qzZKn3Z9l8HDp?=
 =?us-ascii?Q?T6sJFwj5R4C/2wDmUgit5C1gCzP6hikI6zVk+bIDmqEQJN26SOndjGUwMkLA?=
 =?us-ascii?Q?wTSMs8rTIxeLPgBkPtZ12NIkUqmmP5W4gJ/mmNLkvYgJHwFVDv/CaUEq+Rlp?=
 =?us-ascii?Q?Yig5yz8osbyHCOhkpXGKeAbTg953MfPkMYBLZPBxUeo3G5LJLd1k9xn3nk84?=
 =?us-ascii?Q?iVUdPBNaNpi90/k/rDOl7tCbl6YU2k3RTTM3p8SqTPRQke3xU6yzKzrFB68W?=
 =?us-ascii?Q?BCitu6KBeiwErKmIYVNGwu8uIx+inaQxuQU2sCy0XcGIqyVlaBF51x/Xy/ws?=
 =?us-ascii?Q?TXoF/rH/illkbDp9hxz87syie7hbskoyViajGO6tRxUY1NMn8KdmuGDMExzF?=
 =?us-ascii?Q?Ak+WCxsZhwiUj+phRfGPsENvyRei+fFAtd+fENA3A74RjgDrmHu5Py9TMU7n?=
 =?us-ascii?Q?ywESGdwooWDzx0TbOuyUqPCzDJpKc2Qu0T2+o/Hp2xv9Y9Gx0Tz+lx+AC1hu?=
 =?us-ascii?Q?C6PsWeAc2D2t1XPHt7TkYCzW2E3/HNOaxbwxIkjec3IeqHDDOUZybfsDHfHc?=
 =?us-ascii?Q?mqgdPMjBlSF0tZ4GI4SABhnFsY8UlE+beCwSwITuUAz1MbhGviz3sh4qVYyC?=
 =?us-ascii?Q?YXogMKmBj8VAM7TF0PKenAJnGKqCtbtt8XMDUudIeRY7SDqBltDD5BxFJUaR?=
 =?us-ascii?Q?+Vw1vZPTD/6lLNG6M8jFNTnuA7h6IDzvrw8DNZdwXKEBiaRoNG10EJ9v6wn7?=
 =?us-ascii?Q?yaEci3FvKTz2CtAeYn+W66qW4e40VfXEULuXbsry8S9LgV3p2UbQU36damz6?=
 =?us-ascii?Q?7FM6W35FDTc57dSpEnRhRcceN4388nAZLpwrtvepNUZ00NUNAfS8LomhW4v8?=
 =?us-ascii?Q?TN3P2d6WW57DyZeCjpb34xMrh4dHO4DHmuosucZyZiGf2KPDOekA5axirZsg?=
 =?us-ascii?Q?W8IGJqeZprNut8OvunRdKn+YkG2495b6/xc9jBf+rfHyLTQAvUtTzZoVNRXY?=
 =?us-ascii?Q?etPoa4mQuvWsoRuGem+PljhVunj00jiak1VOhQUROZPmkAmkfoZ5A9yvdZuj?=
 =?us-ascii?Q?1fsr0ohdMlOL0ksMwmgju+q8JoK8IsQ1nfP4cuggPTwzndEAIg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 08:33:56.1638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b29960db-21e2-4a31-0440-08dc853a3d4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6342
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

Since gmc_pg is false, setting mcFlags with SISLANDS_SMC_MC_PG_EN  cannot be reach.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 68ac01a8bc3a..f324a8ef8032 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -5467,7 +5467,6 @@ static int si_convert_power_level_to_smc(struct amdgpu_device *adev,
 	int ret;
 	bool dll_state_on;
 	u16 std_vddc;
-	bool gmc_pg = false;
 
 	if (eg_pi->pcie_performance_request &&
 	    (si_pi->force_pcie_gen != SI_PCIE_GEN_INVALID))
@@ -5487,9 +5486,6 @@ static int si_convert_power_level_to_smc(struct amdgpu_device *adev,
 	    (RREG32(DPG_PIPE_STUTTER_CONTROL) & STUTTER_ENABLE) &&
 	    (adev->pm.dpm.new_active_crtc_count <= 2)) {
 		level->mcFlags |= SISLANDS_SMC_MC_STUTTER_EN;
-
-		if (gmc_pg)
-			level->mcFlags |= SISLANDS_SMC_MC_PG_EN;
 	}
 
 	if (adev->gmc.vram_type == AMDGPU_VRAM_TYPE_GDDR5) {
-- 
2.25.1

