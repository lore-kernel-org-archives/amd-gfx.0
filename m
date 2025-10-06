Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0954FCAC5B8
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Oct 2025 16:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9953F10E413;
	Mon,  6 Oct 2025 16:32:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4tjRfsZo";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012057.outbound.protection.outlook.com
 [40.107.200.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BA2410E41D
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Oct 2025 16:32:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXDvjcz4SPVjexGWQQnqGoLErt9a9YU6kVnaZ/ArkAKdYBNdy1/NYMPwQrbmKuOBRbMh7fYRrtyTgsIhlMA7q4mieStBgPuv84/NgkHNV2fJVSR3DJa57P+2HLxurZ1VvanZTZIIPO+VByFz+rzjGAO1zJWxucLhMGPSnnT0Ec2GE+dFolWP3Q5boVeYH/TykXJb+j/UgeCok1zGQpk61Ztu4leAB6rRkArqOt5/oZemcQrFKq87/AiSbRtWLvSyZy4X3XX2oZBWCgXjJnZYLM5pPVO0+lQ1Aia95wgeD24fnNxDbuiq71EK3IJzIRWOSwph79HFK3qcI7jt5YKfZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ns9Vp/rpzEDevkiixrWbee2y43b15Vw8zjuoDJ8Wr/4=;
 b=xRKP828/fPaPR+wScRbUGUji2My5nw6PKWy8KVXvHNCXV3qKgGQUS+1SKBXGwGbRUzBGT/i3CJy1v7GLm6CHeoZRlS7DfGBjy7xyiyOnvCBElUJ5BZSAYNgAo5nQgLHPKUxmHcUxmlP+qvgxuIVLgkO6hg0iFmJVx6UQE+uEq83fD83ahPveLILr97wW2T2jHS9m5kf/G1chl3W89KFAaswH9CseomL/WcOdffw8Dbz4B/wJQ9QKaBUGquhaS6k3lD3ZsX6ZDnLDBkl3+7MoCDvZYz2G8yiyuObndGnA2ngDsRJnUqCYNvvGDPaUr5Jlxb06kgERE8iDyV+t3l9tDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ns9Vp/rpzEDevkiixrWbee2y43b15Vw8zjuoDJ8Wr/4=;
 b=4tjRfsZonfHsXWrvmINQ10LFOkHsoabbP8LAT32gxW/8qG6wz/HKkR0ywGrA9mYovuIEYgw1XJvZbeaXIR93ZEmk3xMbxIyKW2AFiki6dT8EvhjML9jZfU59mMKGNaZ6Do6nEatHlkM0HwJhHtbOrdhaA9BIEgrJ0cIWAprL8RE=
Received: from PH7PR03CA0009.namprd03.prod.outlook.com (2603:10b6:510:339::33)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 16:31:56 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::87) by PH7PR03CA0009.outlook.office365.com
 (2603:10b6:510:339::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 16:31:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 16:31:55 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 6 Oct 2025 09:31:54 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <Lijo.Lazar@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v2 4/5] drm/amd: Drop calls to restore power limit and clock
 from smu_resume()
Date: Mon, 6 Oct 2025 11:31:37 -0500
Message-ID: <20251006163138.17489-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006163138.17489-1-mario.limonciello@amd.com>
References: <20251006163138.17489-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SJ0PR12MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 361566fd-3a92-4589-6dca-08de04f5dd1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fu7W5y5mYEzRc6AcU3K7mFQjy8K3LO4d1r/41Gf1mYK0UTY6qNZJz2lXbxGi?=
 =?us-ascii?Q?jJnAzD+8uqED1FlQPlbKaYA3jCQdRjHub5SUetSPMqHpqNJJh+VtwHp+h+vg?=
 =?us-ascii?Q?wblnq/ka+SYIXfWf5C5ULxYXDoE+fhs4sb2U42P3+8P+eMIHg/srJh++3OES?=
 =?us-ascii?Q?PDNkJKJSzmyY5v4bFnrz9iC2gK0ll3ywO7A3QpIbfJFwdiZFxG+C9EXtxH1c?=
 =?us-ascii?Q?PuLK1Rjyy6gAMV46bdBHsbGePWah3p2WDMBGRmTuuvdcozg2VjWMAEUS4amj?=
 =?us-ascii?Q?GH4uRBgSq6siRyrnyVU2pDrl1/Xavmr7O1EXT17EiB38IKnK0vWVZKjKH7BO?=
 =?us-ascii?Q?cyUPUmCtamrNi1iApLGR/Sf4imY6qhEIV0c/XqkufJIHfWpBlmAYGi9m9WKV?=
 =?us-ascii?Q?mskvCrpBP+BfUmeifbRgVR3yIhesPksXNzUULb23C6D6olL/cTZWqdt/7TFL?=
 =?us-ascii?Q?+LntlBnmO+Eqh7oSqjne7MqUdVWbD3fN66+6WbwvsdTpgIBWZXCPml+cQx1/?=
 =?us-ascii?Q?Orm0maWtF/px2m1y5YvfxPX63q3oTkKm5jbg/TdWydICeRjRRf4f/1/oXnT8?=
 =?us-ascii?Q?50ymY/0OEy1hcrgfRT9+8Tlsb1xMSCvivDzpfju+7+MmtiOviwVuGVdfbUwm?=
 =?us-ascii?Q?hOSuQEMVaTsFU4PBeJ2XOHTEHqJqCPE1JxX1tY8bA6dF8ckhXR3vC/MedX5u?=
 =?us-ascii?Q?xH9e2mhlyNMsuTJ1Vuq85GWUkb4/AjelMA274WyPa4FO5/ti/b2XZnVEvvQr?=
 =?us-ascii?Q?pkox1xToNoEVTvybG36y13G7Yx2HJd6fzdf3st6AeCX41ts5V+pXwwK25D9y?=
 =?us-ascii?Q?VjTybSCK0Kgk/4fxRa/NpCo70+OdOSSqKpgW53BP3t4+n+jyJLYAeXFQxw/B?=
 =?us-ascii?Q?y52KhHXFtBGjI5r2Gy5LDVZWpeFRYECkKVg/Em+sxtT6vERD+G35pAR5hmyY?=
 =?us-ascii?Q?TvUEBMV1fWsC20etkLOkCMtBWz781Q69fxtzFsbAxapkZ72ZFO9Qb/sk06Fr?=
 =?us-ascii?Q?Y8UvzUgh3ie9YEXTs5qujLbpR+K3kN6mV06Zhwef9On1GzF62vg708Mc4Q+x?=
 =?us-ascii?Q?liXfKUROH4Ds8NSDn4FxTHO5+cC1b8C4fAu6/szdtIT+nn4P0Nc/fOR/D6Cq?=
 =?us-ascii?Q?eg7q1dKP7nfZgkYBr++xTHd7xRJK1KrvJl7rfXIlaVmyaVOsr088qWSGMYBI?=
 =?us-ascii?Q?K70XLnpNHJ/XsazYOfPuzIvH3tFvF0MiYoxeDnXKAf+L5D6A4ZL06wDEdXn8?=
 =?us-ascii?Q?VFjom3gplj26z90MNu0QQina8x0S4BDO+YS3RoC7ALB28/50a9a3K8VguJrl?=
 =?us-ascii?Q?Piphocnupy3HEGVwmElv50c1ttJ+a58mC41NeXhBGgsapug/4ER0Jf1PO/CY?=
 =?us-ascii?Q?pkJR9VtkLcYfT1HcNgPddwcU71rHd/N8NFTiBAfDSKJFev6JPZ7IITP1nFZb?=
 =?us-ascii?Q?0kUD05NXamiGL+c8otqZtmgKXNydgsshNJJX9yzSWb6vQffZftafHZi3XVFM?=
 =?us-ascii?Q?vcOhKTu0QZSc3HhdyfpHOpjImGNVFCbN5lOLN3bPAx5omVnAAp2vmTeD8+7T?=
 =?us-ascii?Q?/2SszB53oYi9oKrqN+A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 16:31:55.5628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 361566fd-3a92-4589-6dca-08de04f5dd1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458
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
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index e87e729b230b..5ec42de1d91d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2230,7 +2230,6 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 	int ret;
 	struct amdgpu_device *adev = ip_block->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 
 	if (amdgpu_sriov_multi_vf_mode(adev))
 		return 0;
@@ -2262,18 +2261,6 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 
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

