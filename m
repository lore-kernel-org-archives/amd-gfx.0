Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3ABD6CFD5
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 05:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C104210E1AD;
	Fri, 23 Jan 2026 05:57:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KgfBjLep";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010049.outbound.protection.outlook.com [52.101.85.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 695AA10E1AD
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 05:57:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdVn+0sOaALEl12HpY+Xy/6URAYDcOWv+7LS+HogTpGIiSl5UZUWX3Ij4Q+jwdWh29/ytxe6l+cCUAhe9tKOYEsznQP6DChjBrvWs003KLGaFILLF36RxxlGkrlod0SQ+udEv3MpGaxZOwk6d2vLKTR2yF95knvbNOn6YGdsnoHW01aDdKZrLp6rIEoiJ5EQp/vV2uhKxE6VeoM3j06NlgheHNVXPPJZoA8cbFbJ6wuxWqxg3qBsj5l+ZrA+bNYI2KNfMHao6K8D7Y4VG+rh4Y/MK/xSn2WscrsTDf/efDAv9xBjP1bDHix4AWjE6W+ODAw667vqRjUiypvJWk3zyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OpwygRBHkGL+qdLTE90lTl7lbTqFWDhj/YEScNeTQg=;
 b=I7Kmy9CLrCEcW9UIylFk9Dx9C4n53nuOSa6XFLy4WZeHRkJ/O3N64g0t4Zq/w9fub72A9/mwVRpy44m5qISdfSPxzH6H1co3/ZwZBrzPvmPXbr8Ci8yQsmO5MLdpq1cgMbIeyfX4HfWlwvRKOw1/CYgTvpeCQU4OkX0O5zCiJJF68jVeM2nUwVnG+tB5KbHZdhdLXd+vD1yxwGzL9Zg5gVAslN0Paw46UYxm0Vfb3bTJGgVny7n/1A6tjvJM7ku+4djK7XNctI14Byl7vfKMoFiDTKjhUPcDRw/nCx6S77Ne1dUQEQC+LMtIURybSwmfOVd8ggicVai+rk8sS8PDZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OpwygRBHkGL+qdLTE90lTl7lbTqFWDhj/YEScNeTQg=;
 b=KgfBjLepEgvji7qNK4jX1KVgjY1v01MG8OnOyJIoy8D4fuXX+K2IixB//U/B9H9D1TYvPmE8YldNX4sBQKI9PJLhH0MfMFz38M64/Z55BcY8IU18hH3+lyxLOl6Sjt0TOt5Tg/4tdeV4E7D/yoVe2v7iB82enjRjdR191Q/VY28=
Received: from SJ0PR03CA0360.namprd03.prod.outlook.com (2603:10b6:a03:39c::35)
 by IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 05:57:11 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::9c) by SJ0PR03CA0360.outlook.office365.com
 (2603:10b6:a03:39c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 05:56:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 05:57:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 23:57:10 -0600
Received: from kenneth-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 22 Jan 2026 23:57:08 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <KevinYang.Wang@amd.com>, <Alexander.Deucher@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: send unload command to smu during modprobe -r
 amdgpu
Date: Fri, 23 Jan 2026 13:56:54 +0800
Message-ID: <20260123055654.3776-2-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123055654.3776-1-kenneth.feng@amd.com>
References: <20260123055654.3776-1-kenneth.feng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|IA0PR12MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b2b256f-da97-41bf-56ed-08de5a44400f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pi2ciIK1gKTXbzijyqN6eRdLoTvg3U53Z1c4d3kQgCKle6Pje1JTaheXQZai?=
 =?us-ascii?Q?VmMQVhLywccAdzWgCvLnPz6Sgaib0OiAynnZKiOpfvxVNr/HPQu3Tpp+KTaR?=
 =?us-ascii?Q?5YacndJJ7K3S7/w8d8PoT4r3xrurH78HPLzV4ja4Valedj88DA/DYc0R3DSX?=
 =?us-ascii?Q?xuAB4yy/xxfwszn4xTceUGOWWjqlyixcEDqTiLHUg4Y1TeXDChpj3ezZirg7?=
 =?us-ascii?Q?xYBSvqBEdd1N66/v+i4rxz0m6+b2KiPHjZU3qi0j7kXtq4r5SR6h7tGVfPNY?=
 =?us-ascii?Q?EIArJodxKLmn2MR+RiDl0KczBZOpsuVCG24ZT1wTXPvNvb1bDpTLxi0oihOJ?=
 =?us-ascii?Q?gPYgOaGvAN19GKhRXDR0ZZND8MPPems9/35Qxy7Z18zADKOqMG+VrJbQsjPv?=
 =?us-ascii?Q?5jXRQuZZFwpDBFT7C/RonTjkbzpf+fYl5ddyIf9yZoiuq/mmsKIbx3eDXcy3?=
 =?us-ascii?Q?SQzJsyyigAD9KpzBtKbSJ7kfvTatfQGJEHkVZA4aFUNwPdlk4C0ltOTIFQX9?=
 =?us-ascii?Q?XiSMg+j6dlF/m3iQ7aizU74B3a/6+2QEVtk1xTWGqfmUT6VID+v/6jRw+GiX?=
 =?us-ascii?Q?EyEnFhZIKz+/wcQ5utAATbcuT5m/Hi/WmdmqYqaHGLXpvxoAzGB17ortGb5o?=
 =?us-ascii?Q?Tz2b6H7TvJGJ46RodZ1VtI8fkjVsSwF88wdOWItTkcCekx1ykG3LZOrTQPii?=
 =?us-ascii?Q?zbfRmq1JUvg63cXJJvKZ2NPVjQWcQAnsIC9TQ4vots/o3WOUwuHz3ARwgFVw?=
 =?us-ascii?Q?IIqX3nNmaUxIYQN9ahdnzdV8U2Cz/NVIdxFJqF9F4x7kom9jmGq9bkr2V2jR?=
 =?us-ascii?Q?a69uBn3EN4UQeUATKgyw2xPobPbu7B6jHkdvpldH995aYvX6DkPv3NVChroV?=
 =?us-ascii?Q?3HJY2WUhCMoZC/rIKGkMxe4ijhTN+1zyWWIVJP5LrPs0KD2Civn0bm3u1CNK?=
 =?us-ascii?Q?kzs4/Z4rOEKSCQrWNbEDe3SI8BE3qNR0ByHh8VDqRWpoX0kwZ7L7IkRGQ2JT?=
 =?us-ascii?Q?JVLmGrxDWtNfU0WuPTrg3UNgwtL6Myft3RCc81tQvJGhbdnkhVCTinZ9etPt?=
 =?us-ascii?Q?HNcy9mCDr7eOmMmivEWt4RvCU4tuTWRccvRNVnHeXWBrzTyBTvazSHtGpIAc?=
 =?us-ascii?Q?acXlieBHlpV5sN2PI2HeYAT4ei37UL7GIzwcgBxJb6NW24KOQkusg8sQdovJ?=
 =?us-ascii?Q?40j9+y0XExB99v/46GK1nIZcgBhiC8uoElc0CBIPi5N5Vbv1nV6Y6Pemn73l?=
 =?us-ascii?Q?v4u7F67ASUFtCni01RimI8crZ+vJ4de5z/e93h8T+vArLO4pSBRn/5iXixx1?=
 =?us-ascii?Q?+k83SBQZHfB8KWpVW1sI+VgRe51wzgog2yLFYt14J51whs0eXa/qDzWRtqF9?=
 =?us-ascii?Q?kUCems1W8szfoRBG6oau6nIpNiF/4trkA7iSPBDM/uN+mwJCRliHsuM1rsqO?=
 =?us-ascii?Q?wOGCEmNRP7F8d+cVu7LFQ142gWv9pR9DQgezXhJqqcz02F8yk8q/jA3d9mhv?=
 =?us-ascii?Q?L45QOSYwGWsp2CqG+Ti33Cft+LqcIzpWhJtBbb+JI6ug/dvnmGkGG1H1DnQs?=
 =?us-ascii?Q?6ryIzuNvJwo1WU/fBj7uhSzdTGeKkr6x3eh/kKsvybS3yemAGmKY1hqUXduL?=
 =?us-ascii?Q?dtqSClTZ6lc7Dl5qWLVKvvBlx4xZU0A4DiSQy131bpU9CXyPc0Us8eB+yAC6?=
 =?us-ascii?Q?/2cDmw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 05:57:11.0865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2b256f-da97-41bf-56ed-08de5a44400f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554
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

Send unload command to smu during modprobe -r amdgpu for smu 13/14.
1. This can fix the high voltage/temperatue issue after driver is unloaded.
2. Reloading driver could fail but with the debug port based mode1 reset
during driver is reloaded, it is good and safe.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           | 3 ---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 7 +++----
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h        | 1 -
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 8 +-------
 4 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 362ab2b34498..de1fa1c4d48d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4657,9 +4657,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 			dev_info(adev->dev, "Pending hive reset.\n");
 			amdgpu_set_init_level(adev,
 					      AMDGPU_INIT_LEVEL_MINIMAL_XGMI);
-		} else if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 10) &&
-				   !amdgpu_device_has_display_hardware(adev)) {
-					r = psp_gpu_reset(adev);
 		} else {
 				tmp = amdgpu_reset_method;
 				/* It should do a default reset when loading or reloading the driver,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 6b6b05e8f736..666d2bdd08d9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -820,7 +820,7 @@ static int smu_early_init(struct amdgpu_ip_block *ip_block)
 	smu->adev = adev;
 	smu->pm_enabled = !!amdgpu_dpm;
 	smu->is_apu = false;
-	smu->smu_baco.state = SMU_BACO_STATE_NONE;
+	smu->smu_baco.state = SMU_BACO_STATE_EXIT;
 	smu->smu_baco.platform_support = false;
 	smu->smu_baco.maco_support = false;
 	smu->user_dpm_profile.fan_mode = -1;
@@ -2134,9 +2134,8 @@ static int smu_reset_mp1_state(struct smu_context *smu)
 	int ret = 0;
 
 	if ((!adev->in_runpm) && (!adev->in_suspend) &&
-		(!amdgpu_in_reset(adev)) && amdgpu_ip_version(adev, MP1_HWIP, 0) ==
-									IP_VERSION(13, 0, 10) &&
-		!amdgpu_device_has_display_hardware(adev))
+		(!amdgpu_in_reset(adev)) && !smu->is_apu &&
+			amdgpu_ip_version(adev, MP1_HWIP, 0) >= IP_VERSION(13, 0, 0))
 		ret = smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 1def04826f10..6bd104b7187f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -508,7 +508,6 @@ enum smu_reset_mode {
 enum smu_baco_state {
 	SMU_BACO_STATE_ENTER = 0,
 	SMU_BACO_STATE_EXIT,
-	SMU_BACO_STATE_NONE,
 };
 
 struct smu_baco_context {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index d216db3b804b..5a871c9bf43c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2770,13 +2770,7 @@ static int smu_v13_0_0_set_mp1_state(struct smu_context *smu,
 
 	switch (mp1_state) {
 	case PP_MP1_STATE_UNLOAD:
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-											  SMU_MSG_PrepareMp1ForUnload,
-											  0x55, NULL);
-
-		if (!ret && smu->smu_baco.state == SMU_BACO_STATE_EXIT)
-			ret = smu_v13_0_disable_pmfw_state(smu);
-
+		ret = smu_cmn_set_mp1_state(smu, mp1_state);
 		break;
 	default:
 		/* Ignore others */
-- 
2.34.1

