Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F37CCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 19:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A69210E8D2;
	Wed,  8 Oct 2025 19:12:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V5WP7fKS";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012028.outbound.protection.outlook.com [52.101.53.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AD0210E8D1
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 19:12:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpGuKpusC+6b8AdKWLKmH5eYFE80/LtyHWqx3hV8+I7+w8kMywc/Vup+o6W+yk044fjpcT8D81A3kzgD5sC5p/SM53rcntg6hfhcohf8FyZXf0zJKB1m/2PEoNv4KP7oYdMXTyYzie5Zo/xkU1ILjfGS1KQyEHRwvKnkvYOnXsEQJur9su046aZJv1U73yCKj5q7cRzVBmanMpAgn9Sbj6WlxOa2T1ZI0UNSpoeceNxeZcMiynWV1UlCXofOYNCYlNSW1ZdFPaZ4/loj5fGbuPvyXpAiVdT0OOZERy3ojZT+Wuo9U/5FMCQ6T3cLG7UnQ4juKBuz+/RFb/R/O1d0lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpYmqSqXaYjskV7cXxSHWIOr5CzDm9+1Fm5/xSMYjdk=;
 b=mMsiVo92/dpoQn3rgE3tNYKy1t280s02i68d1hg9ESM+IozYz5lQWCIWHl1rtsyVEu6Ed2JbxWyOeHE/Pu4ASqto7Qh35tfgDhbzYOQBD9lPYkP1JD78WLCuvWCtJp1H9OEUuWJ2hYFU9Vpl/93nRQIx3AoOfUpztoNDRIWdMVGjOgSIUJULRY5qEhNT718v8bhgPuagAz1V/kJIWXOB6xtPJ17w8zQ9tKBCCFtHcq07P3H+OjU7zKFgAAEJuzBq6QAJa4x64LT9KxnyU/LspdCmkvQfbUyDHPHghsuqmSwfEkODHu2t8QEBf9oQZ19KnDdOAH2s2xcfJqGFIM2nHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpYmqSqXaYjskV7cXxSHWIOr5CzDm9+1Fm5/xSMYjdk=;
 b=V5WP7fKS3pEevgVlA5Kv2UNXAg6nfXw8MjVghN2iil79bk1O+p++O8EOSMXXwkMWds8dD/h6ePBpM05aW3EOoIpt+DM+0keNA9UeBkhLvi/u0WL+rDINFm2PpagVvPExAVRlayCUZbUbz0TyPl1x1r1CHrZgDq6CsTeO5MVxtTU=
Received: from BN0PR08CA0008.namprd08.prod.outlook.com (2603:10b6:408:142::30)
 by SA3PR12MB9092.namprd12.prod.outlook.com (2603:10b6:806:37f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 19:12:33 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:408:142:cafe::de) by BN0PR08CA0008.outlook.office365.com
 (2603:10b6:408:142::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Wed, 8
 Oct 2025 19:12:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.3 via Frontend Transport; Wed, 8 Oct 2025 19:12:33 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Oct 2025 12:12:15 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Robert Beckett <bob.beckett@collabora.com>, Lijo Lazar
 <Lijo.Lazar@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v4 5/6] drm/amd: Drop calls to restore power limit and clock
 from smu_resume()
Date: Wed, 8 Oct 2025 14:11:52 -0500
Message-ID: <20251008191153.3145554-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008191153.3145554-1-mario.limonciello@amd.com>
References: <20251008191153.3145554-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|SA3PR12MB9092:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a0ecef-6472-4f57-d8c5-08de069ea24b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ClmHi3lefBZsSTc2/+kGJjDXmPTWngCgxo/0W5WWsSIRCg8a08DzaRpvsgTO?=
 =?us-ascii?Q?BvFxzlRlpDJlXxFNOvRwzN/5aVaXNm+99kK+1B1LJGBFHMHk8OlgbHfFNFXb?=
 =?us-ascii?Q?W6daa557IWP/Yb+pnVmby/Odsm8jJD5iMN29bRCVkaUrICnb7DqB/xvr3g5w?=
 =?us-ascii?Q?egtBgrv8vKi4vgeg9384S8JlwcOIMt0opdK/0jSzGmDclLodafO+fB/jhEdk?=
 =?us-ascii?Q?HtevLyxbp62PHh98kiaprs0rjhChYhi3vp4BX+juJGGNFfI/n+LD8ffx0Wgi?=
 =?us-ascii?Q?M0lV3BI/bJOp7WRSB0iedUe0a344RAv0e2bYpJ9tfj9p7BLpC/YpvhXH9KrD?=
 =?us-ascii?Q?7nLcrJW5wAwt/t7WooG+L71GuFSh1L7jxDGvLP8lAZlUuCrP3GQyelZidaqy?=
 =?us-ascii?Q?PcdvBJZ7XLIb7VkSn+W+HQa35uXzP8TTk6aDnMr66KvMQgfWmGrDD+ncwdqE?=
 =?us-ascii?Q?WWqqfl/aJ7Fd5WNcLZOLK/Uty8C37MfvUE/sHyWxRY3n6WFarcQ+Uwus4nHM?=
 =?us-ascii?Q?IvL3KLbvthxCMOGPD99nA4CCzPbq6m4B3uvklmbMLuv2qz9Uh0HsRFExwHWQ?=
 =?us-ascii?Q?z0nof2raL9tpPLsdZVGTwPsNP7SlB/SFGZ1Dp6SCAD09By+xDUfWUaEFp8kF?=
 =?us-ascii?Q?yBt3gdglLw7Wr9OmzdFFwYTg07aq4MQk7/B1EIvxwn3aQx4ssSPhWXX2WpPt?=
 =?us-ascii?Q?2evzTiHUf8mbkThXRXwVRhVysEfUQAmObNlJF1RWWESrwwqB4srof2MuAxtW?=
 =?us-ascii?Q?TgRbq0N8SWS4sr3Z9vqVb/y1N2Mw7Hbx0QHS58/wEjXWoW045mlP5qkIO6OD?=
 =?us-ascii?Q?AAZWy/re4PhW0x2kzwRLO+Yc7zixkugVowXeG4ywfsG+rdPtGviVS0hWAWrV?=
 =?us-ascii?Q?NvHXGMLWosHKP2/Fin8dVYnKjw0Jn01Zkcs96DUe2F3VjISbAxBuL7OWPTBa?=
 =?us-ascii?Q?wMyhu6nojudkBbSfV88Mu2/POo4JyaxG0f5KFqZc669XK4ZGmBeAXXJ0hTJU?=
 =?us-ascii?Q?Vfw8dT1eICIeueFjVcGlI3Gw7K5LZiJXnJa0Te5khGfNaDQ/w3vSyz6bHvoT?=
 =?us-ascii?Q?+HRPNDOY/nxdNC6q6Eba5Qs2hMPRCgvSDkPvnPeL+Vf1jqgOdUuAkrb97xEA?=
 =?us-ascii?Q?ndFL/FhAcL9ZhatAnX0vQNUqC+lniEQcLlhGM/jYY0C9lskxyXG4aczp9hpS?=
 =?us-ascii?Q?vIoR6bJqtTWriAy8P4GKowfDSwG9xSykKg2O17NHu8R3W1c1GpqRowr3qHW3?=
 =?us-ascii?Q?OwtZXYNE/atzPxYn02QF1nxR43fznU0j3fCq+anVE3BJhYxur/TDfh/avM8G?=
 =?us-ascii?Q?Z6bqITNsrKAaaq6TeQgh4hxIZUI8vRFD5xAC6N8Zouqs8R1ppTLASo2V5+9B?=
 =?us-ascii?Q?RkXJerqVmDw7Skj/alNbtmAol+MYRjEbNI6xWi3v305dWuZKIGpQQLGzYpuW?=
 =?us-ascii?Q?hIofH81xs03RbTKqlqjNUKixAsWUczlNw6njRU7EVI3xYS5sYNzKizcr0Gk8?=
 =?us-ascii?Q?A8R0p4PcYZJBGEfd6mbOydJiFIDxsk1Eg9ho1hdu+tMCcS09/fB1psVYtjvJ?=
 =?us-ascii?Q?jSAOtNtQvfRFUWC6ZTM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 19:12:33.0247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a0ecef-6472-4f57-d8c5-08de069ea24b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9092
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
index e0006fb4c94d..5b9aec7ad338 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2228,7 +2228,6 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 	int ret;
 	struct amdgpu_device *adev = ip_block->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 
 	if (amdgpu_sriov_multi_vf_mode(adev))
 		return 0;
@@ -2260,18 +2259,6 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 
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

