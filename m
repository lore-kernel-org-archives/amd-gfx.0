Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B004CAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Oct 2025 18:04:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D343710E73C;
	Wed,  1 Oct 2025 18:03:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aIjx9QQh";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011007.outbound.protection.outlook.com
 [40.93.194.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C12BB10E73C
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Oct 2025 18:03:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=er/+4XILQgL7NHqFsQVjcSMAgIMO7VGbthWf2zAg9dq8gBOzWEqj6CHDCUyj/uSzD3OMjb7MXDeot6Vn7TYU91pJe4yVR+U8JuufzvSDZ1g6gHal6nZyITyRpjEBqaBiIm6l1ikeYmCareot21sd8+Y96DEFTDtYr6JdRj1goJlRVLWX7H8GbvmvPM4WlsUWVaGDu+Z0pdb4Pprxms8VIpgWylhY/SBxM7OukYHYBG0QSPfS1OIwGqjtilxbFxMvs5ny/3LYQAr+qUiQofbiQkQIsfxLDdQxn9VOogGA3/IgQ6dZjyF+phQJNBHnCrmGMEiNjCtsNlwmBKPvQGes1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyLR/imPeExtREQTWxLZul7W9LhNNrKksoYK5/NLgSc=;
 b=DbA28dcF3tlSDZdmA7YAlcDd9FYfqr6Nbsy4q/WxDAyUIviUFZUqzC14YkKTe89IhAUKE41rDy1X1Q9yUAYnkzlNJ2zWDdfAGzs7JdMqY25dibnWyPIOk9WuZT9nc57bOen713l6VC7IKvpfC56OaZvtvGjIxGkytQJG7SRfJnKjEHnuW8zjLB2DN9zIjdq0zivVTPr9TkzveJwbxU7/h/qO98Qdy9rfaDXfu+67JtUgsz94uy+9l/zckHLcEnWEEQp6lSzWh1mWmzMZ+mjW6RleS+FhspMCY7QN1N+gg6rGVhQ/0IyijKeyhaaQnhFuqat9xgaX9jLHrn0ehqk1qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyLR/imPeExtREQTWxLZul7W9LhNNrKksoYK5/NLgSc=;
 b=aIjx9QQhV+7DWl3UbLZeTNWc8ClI7konYNI+nwdW4J6BmFACD9SHXQHS7ie2fVveZJ0304yUc8EGJiPcRZ8hKDp1pyMPlAvNQSADgmuT1TXyQBpU3R1i6onGrbLnIhBdVmaZ8a9xa+5+hATXJELNU/rlioAasZdxgPS8hrl/EdQ=
Received: from DS7PR06CA0027.namprd06.prod.outlook.com (2603:10b6:8:54::6) by
 DS2PR12MB9663.namprd12.prod.outlook.com (2603:10b6:8:27a::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.14; Wed, 1 Oct 2025 18:03:54 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:8:54:cafe::ee) by DS7PR06CA0027.outlook.office365.com
 (2603:10b6:8:54::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Wed,
 1 Oct 2025 18:03:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 18:03:54 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 1 Oct 2025 11:03:53 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <Lijo.Lazar@amd.com>
Subject: [PATCH 3/3] drm/amd: Drop calls to restore power limit and clock from
 smu_resume()
Date: Wed, 1 Oct 2025 13:03:35 -0500
Message-ID: <20251001180335.625453-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001180335.625453-1-mario.limonciello@amd.com>
References: <20251001180335.625453-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|DS2PR12MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a2e23e6-b916-42eb-2c58-08de0114e251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IypS2Di+oyk3FDuc0Fl1LGYu3OPbz1gs7EvXdUpl4JdoktfmwxWSNf5NyAPD?=
 =?us-ascii?Q?FiJjXXJ0hSatLAz1WaqKUBG4pQz9jRcUj1WyHhTviCz8mPjEW48rcZGvrX6d?=
 =?us-ascii?Q?bZrK0P5tAHnIFGLOcsH/jPgNjXFNCCmCiNe/so6/pG6mEdzAJgP3pKM/oflk?=
 =?us-ascii?Q?30s3ZLoCp/tb6O1NzuUw3SHX7NCB2D8zfSGEsVWPM8/740qeyM0+M5GWoxcK?=
 =?us-ascii?Q?9hlZXzMPq0jM7G27iQeij29beUfWI5jQIS0gSs3CofyOel4X2cbJxMBM6ooM?=
 =?us-ascii?Q?+HGhJkNS9vRRhr7iV2dZ21J82rcDPm/UkbFV6voNMreKvucT2br0wNMGWFOr?=
 =?us-ascii?Q?ZSHHespsTtKM1l04clBu9YVvSqhrp4wryrLP2vecAugkA9532+D0nsxUADhc?=
 =?us-ascii?Q?VpmMgE4wDEHLQsO1HJDWjdi1JUSH51EJ8Pt0CL4HstQpqWIJxjDJGrrsVjex?=
 =?us-ascii?Q?lHngG77Sh94OxwKdeP55MkXDJBo9IaMOe6C8F0LMbJeRJfvVleRtPLMryL2n?=
 =?us-ascii?Q?sPd1tyI7e0RKIH8/otMc38QidBI5EITHT8jwFDRjfGdessQzrjJhQdKUXzbQ?=
 =?us-ascii?Q?AHnFfn8m7eQpwM7N/p6z0EO7g7lj43rO2dYsF2+38ZDIymsSPsAPJAGPc3yl?=
 =?us-ascii?Q?xTfLGCGX6+DtJChpq43gTpQfdlTbfTwYd3sOR8uAogyQ5X67rl8qwA6yQCun?=
 =?us-ascii?Q?RDDZ7Y5cKU6X1+4fybbMVhwc46pMS3NPALgw4ulXdDLHd4HoudOkZM94a8sb?=
 =?us-ascii?Q?DB4Ehtf3Qa5oN4Og7WTRuuxILir0dU6i0YOeSb77J2J6Uo5I01prmA/7dvX9?=
 =?us-ascii?Q?BWFqyAKtngIx8fQdtvmdq9vBhHECCGuGdlbUtY9TUVfsp541YR23zqPC8XfV?=
 =?us-ascii?Q?mdQQcAFru2C2URg129rIRCHccd6lWZ4fXcFhiQVj/c21PZpHcawzL1D2/1us?=
 =?us-ascii?Q?Q/A3YsVCZ0BANvVsww9zr/H3DY6UXsIrziCkGkB4YV0zel2K0kznh8Js3m3J?=
 =?us-ascii?Q?CYJ7Y6W5qWhWaxIEhdEoLN3eXGD0LCUICFgy3w/QOTjjcU1xrP7i5xqdUZTv?=
 =?us-ascii?Q?9jPomcRH3BfTLFEkfd3X0SHSvVPlzZFqCMBmfZRjQyx96EzjTP1K4RjHQWy1?=
 =?us-ascii?Q?q2TnYtFPbN6GGRA1p+rPl67IbB1W2MoIV8y8pL+0StEEbjVfd/Sb9/B/sKFl?=
 =?us-ascii?Q?Bxa6crdMusgDYlNwnpciC9vX9dyDKQE+GUNnPl8EE9CYfiscjKPa8NY3zT6X?=
 =?us-ascii?Q?6lhA/peY6bXWLcmClGvBwx29RuecRfNi7oVBRAhp64mP8Ro167NWMiucAjL+?=
 =?us-ascii?Q?xWO/2AmZfFANxsnnx8VAhcOM7oc1rKKz5a8cmHpXkji0PNcmqazGw2jPbcVJ?=
 =?us-ascii?Q?JdzMfrXszFq4Br6eH+MqQrnsTqon2chT1GAApbZ+jYoTJGiSTBJjlquVEamC?=
 =?us-ascii?Q?CuzYCug92oUH5JQXjFWyD1/TPl8VOTHCyoBkiRX8U2DEgXlm7jdo4RHipt79?=
 =?us-ascii?Q?wFOw7hMFPrHxKgTA1yUd8Z0C/Sk6UZlqjY5gF2P6SgSS2MDsFWuZp2Dceuy+?=
 =?us-ascii?Q?4FHYg6ZuGzAcAJ7k4uM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 18:03:54.0235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2e23e6-b916-42eb-2c58-08de0114e251
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9663
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

User requested power limits and clock settings are already restored as
part of smu_restore_dpm_user_profile(). It's unnecessary to call the
same restore as part of smu_resume().

Revert the following commits to drop that extra restore:
commit ed4efe426a49 ("drm/amd: Restore cached power limit during resume")
commit 796ff8a7e01b ("drm/amd: Restore cached manual clock settings during resume")
commit f9b80514a722 ("drm/amd: Only restore cached manual clock settings in restore if OD enabled")

Suggested-by: Lijo Lazar <Lijo.Lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index a5f40503b0b6..ba4b8a39a2ff 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2203,7 +2203,6 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 	int ret;
 	struct amdgpu_device *adev = ip_block->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 
 	if (amdgpu_sriov_multi_vf_mode(adev))
 		return 0;
@@ -2235,18 +2234,6 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 
 	adev->pm.dpm_enabled = true;
 
-	if (smu->current_power_limit) {
-		ret = smu_set_power_limit(smu, SMU_DEFAULT_PPT_LIMIT, smu->current_power_limit);
-		if (ret && ret != -EOPNOTSUPP)
-			return ret;
-	}
-
-	if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL && smu->od_enabled) {
-		ret = smu_od_edit_dpm_table(smu, PP_OD_COMMIT_DPM_TABLE, NULL, 0);
-		if (ret)
-			return ret;
-	}
-
 	dev_info(adev->dev, "SMU is resumed successfully!\n");
 
 	return 0;
-- 
2.51.0

