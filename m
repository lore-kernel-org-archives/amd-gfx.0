Return-Path: <SRS0=C/bZ=FX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1ACC2D0E4
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Dec 2020 00:49:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6F552343F
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Dec 2020 00:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F552343F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5215F89CE1;
	Sat, 19 Dec 2020 00:49:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5956A89CE0
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Dec 2020 00:49:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVma3pIiItTvbArA53/ZsKdZ7GzYHvDvkSuNwCHI1PStTanXD8q6rdvD5BhGBBq2v/rv38CXPZvjZVLiSFmD+dk8DVgkUyfsMV26Lp/FTqsN9sMUJibgbV3nQjoVQ0bmyzV5fzudAJEaunvGcvfBvbhwlO4RPyNYX0Wv8pYZG1Nz35ikvtVKeBfOaxmugyIGcjbJ/oVczOcFyzjL+hmjWGt0uSNOoIK86pcsOoDn2uXV/92mitGYDfGNiqEouXq6F0hsM/TzPwWJWNmzGepcdYlp7K6A7HiBPe+CA7BmZsJ9PqJb3aE4PA8uKKFShbNaKhZxqZrxewhxN4Jre7NhRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdxvheoD/jWC69t4sQkzB6ZHnFYIFgENPInWz9EJ+rA=;
 b=neGiL33gme9Xx3uti4AyYahpb6Efjdym2a9FHYflSpUVORRco4l1auRqpfA5BrooZ5JzpEiy04uVH+P5gdc5ELTtZP3wZ3/vCxfyWC64nqMVEM4K+tetsx/npoWkulh3Y/x/Uqnh6MGpV2AEU4TApSWCYlmbj2XjxDwhSvnY7x1nU0waIxRIMWxj565xNy8pnK7VXDsFoqsjxU+1WB9BsaVrsSB0/yGtJZYyfs9laFFxam/MD+S27Xb0oWgDbC+HZSXb7Qx+dwTxIYUGrnCeH8/nDfXE8KSwvh3DdE2GXi2Y/O4fmkdpue0wvCUrw0vHlRIhNUvaETUKmEQr/CRx0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdxvheoD/jWC69t4sQkzB6ZHnFYIFgENPInWz9EJ+rA=;
 b=uZkmI4Shs6cLfMUJO1UUSn5lnBHALMitfrcJErw33Gp44H/j3OaMrEiVq/oIZnOkZ6uRczA8cfHqJNWGiubEyRNSjwRIsdW9P6Jl2rBxr/WJQH5xYegRGqjpHo0d06rR4yznx3umijfeUz/NLLvmk/ctsvU+2Ahcikcl+k6qH0U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2959.namprd12.prod.outlook.com (2603:10b6:208:ae::29)
 by MN2PR12MB3279.namprd12.prod.outlook.com (2603:10b6:208:105::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Sat, 19 Dec
 2020 00:49:10 +0000
Received: from MN2PR12MB2959.namprd12.prod.outlook.com
 ([fe80::dd1e:ce4b:cd7e:2804]) by MN2PR12MB2959.namprd12.prod.outlook.com
 ([fe80::dd1e:ce4b:cd7e:2804%7]) with mapi id 15.20.3654.020; Sat, 19 Dec 2020
 00:49:10 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/8] amdgpu/pm: Powerplay API for smu ,
 changed 4 dpm functions to use API
Date: Fri, 18 Dec 2020 19:48:30 -0500
Message-Id: <20201219004831.13527-8-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201219004831.13527-1-darren.powell@amd.com>
References: <20201219004831.13527-1-darren.powell@amd.com>
X-Originating-IP: [142.126.168.115]
X-ClientProxiedBy: YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::23) To MN2PR12MB2959.namprd12.prod.outlook.com
 (2603:10b6:208:ae::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.168.115) by
 YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.28 via Frontend Transport; Sat, 19 Dec 2020 00:49:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a6651263-654a-4ffd-2a4f-08d8a3b7e5b3
X-MS-TrafficTypeDiagnostic: MN2PR12MB3279:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3279E466387E33718D08669DF0C20@MN2PR12MB3279.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nHaRzx3AqxlzJI1yHTHA1Br49Zn64nZGHmOMuZhiMuSaftHkPjlxW1ND1YG5URfyhKwcIHPULk+3t2tm4hB4VMt29R9WhbuLmir67oe842B5M+vrwtwg/CHuOa2pkfPKmRkDeC5YDiDhWH2jvEiMKaGaH/v+QnVe9DH4ktsvrDM83zm9kFS369IXijTOLz7PAjTEXgnflBAU30xdgk90+Pg04ueNXmwvtVLEO/o66nsZ+WZds9uVSkSggQifnZIeeAoS6W9EySdWgYwNUzPY199KyX3Nnp3iTCXyorQVWW/0x8cZMNRPAWy1PqnZ1FCW4TzTEueAzobK2c9FkuJpRJOUQo0FUoC95UzYk3s3/0FpH1Ofi8mNj/rP4+2hZF2k
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2959.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(956004)(2616005)(44832011)(26005)(66476007)(66946007)(6506007)(6666004)(86362001)(66556008)(5660300002)(69590400008)(36756003)(1076003)(83380400001)(186003)(30864003)(316002)(16526019)(52116002)(6916009)(2906002)(4326008)(8936002)(6512007)(8676002)(6486002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YM5yECQG97pcL4LI4gjiEI6Z4NiUgLjPgbgyqJtoA/lgyUZZ4hvb0Wi4mtzj?=
 =?us-ascii?Q?D5IZ32Bxrufi3gvoI1e0EhOLcCoSfBdrBrZFJihSE++xaHwR6okD6h7nJ4+k?=
 =?us-ascii?Q?k8FX9GiG3UQiu1UGlF0C7MS0gKZlqR3eaW6rWyGmQaOzpO8E+VgWB3TU2Sob?=
 =?us-ascii?Q?9y95RgMCLuuQWoecGwGBFk0XAccpQLdpHCKLARL68kkfDgs1VuecvwBKmqBY?=
 =?us-ascii?Q?U13q/cODNi16GPzhv8enn1GFOZ91+wiveqxta0hZsZneThymoEMwZjOQOKvT?=
 =?us-ascii?Q?k2GHdrzEABqQOnJo2EUVqbWsmL4yz5jdvwV/R5nBQUipJD633CORdXIowfOw?=
 =?us-ascii?Q?8DuhcdW/hFoQPZybxVgsy6luTbKBEesMj8Hd+GI13q/POfgZUGjVzi+GF23+?=
 =?us-ascii?Q?v7ZZmEW+ZCgAAxqgZsicRG9A7Gsc1y0G8Tkz7UR8l+xWQ8nyQDhq/I1qBBc2?=
 =?us-ascii?Q?HGaiPI26SLLZN4DpJVIGD7Xa46nQ6+9sHvp5bMWhW21kGMIlq1jzyyXl9D1c?=
 =?us-ascii?Q?8i1uFKGD0RoH19ZkMPw6tG+IrOQKqN5ygUVaZp3TASnxfagA39gWJbf+RtOF?=
 =?us-ascii?Q?UyoFAfpPq2dw01AfkXlXNe4aq9vt9AZxisxCpAhc40QNvD4aNh6B450IUUAy?=
 =?us-ascii?Q?f9WB3OsTsV1B7GOhgYd1Oc45M1mXjGkj4bDKyzI0WseSULlbFdSMKLLBU8pZ?=
 =?us-ascii?Q?SpaURIeKgUFVIk0+Mtfhqv6V6enx/Rq8GbbTj7YRAdDjgNqKQLRojAaSZivv?=
 =?us-ascii?Q?ua13fl6OlixoOSCIyS4JAOj64xsTtRoZyQXUZDZWm9mjEE7WZnYhtydtPcIb?=
 =?us-ascii?Q?0767zoGKFNvbGoekVp1pF2ThSeuSPOaUFYNZMjFQssPbMJYVk5mdi8UAdPrn?=
 =?us-ascii?Q?oC+z2iQKOBNwPvVFZty2VTopZaBUNMcxMyOIIAmFw38TqzSTfQy3qLp70OXS?=
 =?us-ascii?Q?HX1oIBMrMXM1TwAm1Nive85wzI6w3AYLwastfhANN5ERuOYTpmTPSaINLrK5?=
 =?us-ascii?Q?ICWa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2959.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2020 00:49:10.0052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: a6651263-654a-4ffd-2a4f-08d8a3b7e5b3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LfdsX8ktPVln73jxU2O8qk4qTFynX33K/HbrrZva4oDr4htGrO5d/E85JumRNiuM6IkNO0TxulAi8fbWCoIzTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3279
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
Cc: Darren Powell <darren.powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

New Functions
  smu_get_mclk        - implementation of the Powerplay API function get_mclk
  smu_get_sclk        - implementation of the Powerplay API function get_sclk
  smu_handle_dpm_task - implementation of the Powerplay API function dispatch_tasks

Modified Functions
  smu_dpm_set_power_gate - - modifed arg0 to match Powerplay API set_powergating_by_smu

Other Changes
  removed special smu handling in dpm functions and called through Powerplay API
  call to smu_dpm_set_power_gate via Powerplay API now locks mutex for UVD and VCE

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c       | 94 ++++++++---------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  7 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 47 +++++++++++-
 3 files changed, 82 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 8ae2df82addc..296879ba99c7 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -911,50 +911,28 @@ amdgpu_get_vce_clock_state(void *handle, u32 idx)
 
 int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, bool low)
 {
-	uint32_t clk_freq;
-	int ret = 0;
-	if (is_support_sw_smu(adev)) {
-		ret = smu_get_dpm_freq_range(&adev->smu, SMU_GFXCLK,
-					     low ? &clk_freq : NULL,
-					     !low ? &clk_freq : NULL);
-		if (ret)
-			return 0;
-		return clk_freq * 100;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	} else {
-		return (adev)->powerplay.pp_funcs->get_sclk((adev)->powerplay.pp_handle, (low));
-	}
+	return pp_funcs->get_sclk((adev)->powerplay.pp_handle, (low));
 }
 
 int amdgpu_dpm_get_mclk(struct amdgpu_device *adev, bool low)
 {
-	uint32_t clk_freq;
-	int ret = 0;
-	if (is_support_sw_smu(adev)) {
-		ret = smu_get_dpm_freq_range(&adev->smu, SMU_UCLK,
-					     low ? &clk_freq : NULL,
-					     !low ? &clk_freq : NULL);
-		if (ret)
-			return 0;
-		return clk_freq * 100;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	} else {
-		return (adev)->powerplay.pp_funcs->get_mclk((adev)->powerplay.pp_handle, (low));
-	}
+	return pp_funcs->get_mclk((adev)->powerplay.pp_handle, (low));
 }
 
 int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block_type, bool gate)
 {
 	int ret = 0;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	bool swsmu = is_support_sw_smu(adev);
 
 	switch (block_type) {
 	case AMD_IP_BLOCK_TYPE_UVD:
 	case AMD_IP_BLOCK_TYPE_VCE:
-		if (swsmu) {
-			ret = smu_dpm_set_power_gate(&adev->smu, block_type, gate);
-		} else if (adev->powerplay.pp_funcs &&
-			   adev->powerplay.pp_funcs->set_powergating_by_smu) {
+		if (pp_funcs && pp_funcs->set_powergating_by_smu) {
 			/*
 			 * TODO: need a better lock mechanism
 			 *
@@ -982,7 +960,7 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 			 *     amdgpu_set_dpm_forced_performance_level+0x129/0x330 [amdgpu]
 			 */
 			mutex_lock(&adev->pm.mutex);
-			ret = ((adev)->powerplay.pp_funcs->set_powergating_by_smu(
+			ret = (pp_funcs->set_powergating_by_smu(
 				(adev)->powerplay.pp_handle, block_type, gate));
 			mutex_unlock(&adev->pm.mutex);
 		}
@@ -990,12 +968,10 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 	case AMD_IP_BLOCK_TYPE_GFX:
 	case AMD_IP_BLOCK_TYPE_VCN:
 	case AMD_IP_BLOCK_TYPE_SDMA:
-		if (swsmu)
-			ret = smu_dpm_set_power_gate(&adev->smu, block_type, gate);
-		else if (adev->powerplay.pp_funcs &&
-			 adev->powerplay.pp_funcs->set_powergating_by_smu)
-			ret = ((adev)->powerplay.pp_funcs->set_powergating_by_smu(
+		if (pp_funcs && pp_funcs->set_powergating_by_smu) {
+			ret = (pp_funcs->set_powergating_by_smu(
 				(adev)->powerplay.pp_handle, block_type, gate));
+		}
 		break;
 	case AMD_IP_BLOCK_TYPE_JPEG:
 		if (swsmu)
@@ -1003,10 +979,10 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 		break;
 	case AMD_IP_BLOCK_TYPE_GMC:
 	case AMD_IP_BLOCK_TYPE_ACP:
-		if (adev->powerplay.pp_funcs &&
-		    adev->powerplay.pp_funcs->set_powergating_by_smu)
-			ret = ((adev)->powerplay.pp_funcs->set_powergating_by_smu(
+		if (pp_funcs && pp_funcs->set_powergating_by_smu) {
+			ret = (pp_funcs->set_powergating_by_smu(
 				(adev)->powerplay.pp_handle, block_type, gate));
+		}
 		break;
 	default:
 		break;
@@ -1512,36 +1488,28 @@ void amdgpu_pm_compute_clocks(struct amdgpu_device *adev)
 			amdgpu_fence_wait_empty(ring);
 	}
 
-	if (is_support_sw_smu(adev)) {
-		struct smu_dpm_context *smu_dpm = &adev->smu.smu_dpm;
-		smu_handle_task(&adev->smu,
-				smu_dpm->dpm_level,
-				AMD_PP_TASK_DISPLAY_CONFIG_CHANGE,
-				true);
-	} else {
-		if (adev->powerplay.pp_funcs->dispatch_tasks) {
-			if (!amdgpu_device_has_dc_support(adev)) {
-				mutex_lock(&adev->pm.mutex);
-				amdgpu_dpm_get_active_displays(adev);
-				adev->pm.pm_display_cfg.num_display = adev->pm.dpm.new_active_crtc_count;
-				adev->pm.pm_display_cfg.vrefresh = amdgpu_dpm_get_vrefresh(adev);
-				adev->pm.pm_display_cfg.min_vblank_time = amdgpu_dpm_get_vblank_time(adev);
-				/* we have issues with mclk switching with refresh rates over 120 hz on the non-DC code. */
-				if (adev->pm.pm_display_cfg.vrefresh > 120)
-					adev->pm.pm_display_cfg.min_vblank_time = 0;
-				if (adev->powerplay.pp_funcs->display_configuration_change)
-					adev->powerplay.pp_funcs->display_configuration_change(
-									adev->powerplay.pp_handle,
-									&adev->pm.pm_display_cfg);
-				mutex_unlock(&adev->pm.mutex);
-			}
-			amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_DISPLAY_CONFIG_CHANGE, NULL);
-		} else {
+	if (adev->powerplay.pp_funcs->dispatch_tasks) {
+		if (!amdgpu_device_has_dc_support(adev)) {
 			mutex_lock(&adev->pm.mutex);
 			amdgpu_dpm_get_active_displays(adev);
-			amdgpu_dpm_change_power_state_locked(adev);
+			adev->pm.pm_display_cfg.num_display = adev->pm.dpm.new_active_crtc_count;
+			adev->pm.pm_display_cfg.vrefresh = amdgpu_dpm_get_vrefresh(adev);
+			adev->pm.pm_display_cfg.min_vblank_time = amdgpu_dpm_get_vblank_time(adev);
+			/* we have issues with mclk switching with refresh rates over 120 hz on the non-DC code. */
+			if (adev->pm.pm_display_cfg.vrefresh > 120)
+				adev->pm.pm_display_cfg.min_vblank_time = 0;
+			if (adev->powerplay.pp_funcs->display_configuration_change)
+				adev->powerplay.pp_funcs->display_configuration_change(
+							adev->powerplay.pp_handle,
+							&adev->pm.pm_display_cfg);
 			mutex_unlock(&adev->pm.mutex);
 		}
+		amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_DISPLAY_CONFIG_CHANGE, NULL);
+	} else {
+		mutex_lock(&adev->pm.mutex);
+		amdgpu_dpm_get_active_displays(adev);
+		amdgpu_dpm_change_power_state_locked(adev);
+		mutex_unlock(&adev->pm.mutex);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 3c0b6209ab6a..edd911ac8e5a 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -727,16 +727,21 @@ int smu_set_watermarks_for_clock_ranges(
 extern int smu_display_configuration_change(struct smu_context *smu, const
 					    struct amd_pp_display_configuration
 					    *display_config);
-extern int smu_dpm_set_power_gate(struct smu_context *smu,uint32_t block_type, bool gate);
+extern int smu_dpm_set_power_gate(void *handle, uint32_t block_type, bool gate);
 extern int smu_handle_task(struct smu_context *smu,
 			   enum amd_dpm_forced_level level,
 			   enum amd_pp_task task_id,
 			   bool lock_needed);
+extern int smu_handle_dpm_task(void *handle,
+			       enum amd_pp_task task_id,
+			       enum amd_pm_state_type *user_state);
 int smu_switch_power_profile(void *handle,
 			     enum PP_SMC_POWER_PROFILE type,
 			     bool en);
 int smu_get_dpm_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			   uint32_t *min, uint32_t *max);
+u32 smu_get_mclk(void *handle, bool low);
+u32 smu_get_sclk(void *handle, bool low);
 int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			    uint32_t min, uint32_t max);
 enum amd_dpm_forced_level smu_get_performance_level(void *handle);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 2a7330cebeb7..2f5a5b2b1f2b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -138,6 +138,32 @@ int smu_get_dpm_freq_range(struct smu_context *smu,
 	return ret;
 }
 
+u32 smu_get_mclk(void *handle, bool low){
+	struct smu_context *smu = handle;
+	uint32_t clk_freq;
+	int ret = 0;
+
+	ret = smu_get_dpm_freq_range(smu, SMU_UCLK,
+				     low ? &clk_freq : NULL,
+				     !low ? &clk_freq : NULL);
+	if (ret)
+		return 0;
+	return clk_freq * 100;
+}
+
+u32 smu_get_sclk(void *handle, bool low){
+	struct smu_context *smu = handle;
+	uint32_t clk_freq;
+	int ret = 0;
+
+	ret = smu_get_dpm_freq_range(smu, SMU_GFXCLK,
+				     low ? &clk_freq : NULL,
+				     !low ? &clk_freq : NULL);
+	if (ret)
+		return 0;
+	return clk_freq * 100;
+}
+
 static int smu_dpm_set_vcn_enable_locked(struct smu_context *smu,
 					 bool enable)
 {
@@ -213,7 +239,7 @@ static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
 /**
  * smu_dpm_set_power_gate - power gate/ungate the specific IP block
  *
- * @smu:        smu_context pointer
+ * @handle:        smu_context pointer
  * @block_type: the IP block to power gate/ungate
  * @gate:       to power gate if true, ungate otherwise
  *
@@ -224,9 +250,10 @@ static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
  *    Under this case, the smu->mutex lock protection is already enforced on
  *    the parent API smu_force_performance_level of the call path.
  */
-int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
+int smu_dpm_set_power_gate(void *handle, uint32_t block_type,
 			   bool gate)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -1553,6 +1580,18 @@ int smu_handle_task(struct smu_context *smu,
 	return ret;
 }
 
+int smu_handle_dpm_task(void *handle,
+			enum amd_pp_task task_id,
+			enum amd_pm_state_type *user_state)
+{
+	struct smu_context *smu = handle;
+	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+
+	return smu_handle_task(smu, smu_dpm->dpm_level, task_id, true);
+
+}
+
+
 int smu_switch_power_profile(void *handle,
 			     enum PP_SMC_POWER_PROFILE type,
 			     bool en)
@@ -2701,10 +2740,14 @@ static const struct amd_pm_funcs swsmu_dpm_funcs = {
 	.get_pp_table            = smu_sys_get_pp_table,
 	.switch_power_profile    = smu_switch_power_profile,
 	/* export to amdgpu */
+	.dispatch_tasks          = smu_handle_dpm_task,
+	.set_powergating_by_smu  = smu_dpm_set_power_gate,
 	.set_power_limit         = smu_set_power_limit,
 	.get_power_limit         = smu_get_power_limit,
 	.set_mp1_state           = smu_set_mp1_state,
 	/* export to DC */
+	.get_sclk                = smu_get_sclk,
+	.get_mclk                = smu_get_mclk,
 	.enable_mgpu_fan_boost   = smu_enable_mgpu_fan_boost,
 	.get_asic_baco_capability = smu_get_baco_capability,
 	.set_asic_baco_state     = smu_baco_set_state,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
