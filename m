Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBBEC433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 06:54:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F49A64F6B
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 06:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F49A64F6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D130B6E98F;
	Fri, 19 Mar 2021 06:54:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6C2A6E98F
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 06:54:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRQohZxGcaQcpr6DTSxvzAiL1Fz9440RIRZ0TaovA4cWvhqOivu3wPX/6LWCxDxZZF+883Xae90Qigfy9PLjUSYciNnhT1ObHmyd+hlLg++Jvfbcp/rN8iajj20Qz3LePblt4b+CzLekw7EFO4gujEtIbHJQHV8ggkRQ7JYdNERcNir7It5myxfOQrjqyXrmaSSLWnQ9yhsKMieBPkSxwL3ltCfOqUPr5WCOwrHR8RogkJ2hPtE7vDvaOXZqzAx6j3I08szm9YxsLdcZbDhPefIro+CoaxO9hDdEUXSUK6QdBp6fQx+NuGZ/WDjFYJRqo2L/SOrA1JoPTA2BvqTFlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgTMlWAfWJFPzxOR+LpmfmxY8VYVSBJ0iexY0QNvftM=;
 b=HklL1NGV0Lv2sZkGB/4IMcC0OGTe3h5xKNdZx7pj8u4GN7Eamepd/MtlB6sgCh3G8tKK8AqPmKELQsFPujrhQdTUC3NuUfT3iRwIjYYr2MWHz/+gBQXgcrfrQSnpdAb4rhkfQmIkumCHf8i8+jAYlyD9ktmBn1b/EDVfgKfc8Zr0/fKsiYcTq29/HOker0uXtLpzZMxcF62PDaUQOGGDNM0nUfC3LpplJgg8gu3EmYa0+k2w9jng69pDFqYJ1sjSMg2YF/Tj+nFbnVLxCZ04xk5fOQ6UysdP1lf0YMWFLoOIYWpFbM9rm4o7GimM3YbGkryrcyp/UdxZpXtlXypiyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgTMlWAfWJFPzxOR+LpmfmxY8VYVSBJ0iexY0QNvftM=;
 b=ttWNVr+m+QfFAbMCChVLKREXFVonnn1ldUFLZArESoIY76h6RgHs7fU+/VvbreFkfWnjCrpyJvlX6UmJNeZZBM+61Memtygj+HkL5rbEgwyZ6UhBUK3yMbC7oIGWFU+UwoTK8wO8LW6OEu5DtslUh+5JWQqgtu4pj5LJroPycV4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2988.namprd12.prod.outlook.com (2603:10b6:5:3d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.23; Fri, 19 Mar 2021 06:54:07 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3933.032; Fri, 19 Mar 2021
 06:54:07 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: make DAL communicate with SMU through unified
 interfaces
Date: Fri, 19 Mar 2021 14:53:43 +0800
Message-Id: <20210319065344.511157-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0179.apcprd02.prod.outlook.com
 (2603:1096:201:21::15) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR02CA0179.apcprd02.prod.outlook.com (2603:1096:201:21::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 06:54:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ff3c7554-292e-448c-7889-08d8eaa3ca1d
X-MS-TrafficTypeDiagnostic: DM6PR12MB2988:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB298863ED7CCF115A2715030BE4689@DM6PR12MB2988.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aEdrMaSBYSanxDS3PxpU+sn1gckzuPzeqKfB67Q8YeMQueEGOv0eiVODA+Bbdw4m+Bzbp+Z2SVVPChTLt2LW+wzWjBspfJ79i4n7oGMjydrmKJJLirvQJoWmZroWcUMwEfGp6hFMmUO9LcpT8VSM7/0wcsC4YZtk4+1BRGQXN1WZdBYHgvjyt8hB24KpibLKsRpiDIWrITX1xEL4W6uguxv/Ifzdriy+dBYgqRLbkTYWAQPkwyywavIGn4A8uY6dqojk/ZPk8zQAJfGAbAdiXXb3NiBgYumcv27tKNv0x5UyauMC0mfztn0M4kAkM0zmSL63R4WwRoJsI6CAWmOYAKy3+KgNMTBU+CiyKC9kQIHK5QOMdqFAvPkdjINwADcCU8xCdeA51Giw087KXK3yLvm793e63iNdLgOkaWAYRd6vDc9mLaWkGV8CLD70ol9X/g9iblNNwAMmhccYZSppWmLiEPVQ5Jl6k7XxomUbGkgGApgi4gnGuneoA7WPG91AjSJpIjgOeNdemMOPNS1ERd2sXCTY+ISsCI5u2J/5AhmYDlYuGnfsbB64rKWsHLraYG78H9BXRWiYecrwJzCvtqlub0Dqgnr7maPIG3LrSPYOrk/BFgFeBCtK61DLcgRv/nx8FXyTo2LWjUtB7OHs9Z5c2vUrFQe6vlGRSrAowvU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(186003)(956004)(2616005)(16526019)(83380400001)(38100700001)(66556008)(66946007)(316002)(2906002)(5660300002)(86362001)(8936002)(30864003)(52116002)(1076003)(7696005)(6916009)(6666004)(478600001)(44832011)(26005)(4326008)(66476007)(8676002)(36756003)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?15i6rXNKCzr5E2pwj5JUKytH7HEkhQ3rIJRf97G6MalDn3RwRE7ScXyO546Z?=
 =?us-ascii?Q?SU9Z3ObQ3ItTnGeIX4It2xRnojgm5UprRM/4s4/p8lkRDxfzKXFl8Yxb5TVv?=
 =?us-ascii?Q?EpAD8zEeyFGXwtL5ELDvnkbUXOGoCsyFS5eg9pirLqpngNq1EjjrE9R7GAUu?=
 =?us-ascii?Q?E1KOBj7AqJu+r8oit6+VtyQHay6Kfex73plsIf/WHT7SdsGtxkDFyt7+fg6j?=
 =?us-ascii?Q?+f2GV06/WCfdfgLt2x5lMxi+KuL9WIevBbKNzxZskr6UtreUm6D2l/rVR4Iq?=
 =?us-ascii?Q?FTIIcRh+i1K2kuVaplxggs2QfYkRCk6JEQGg/JZutsDscEtXxmHCeKULjc45?=
 =?us-ascii?Q?fgXAQWfncvT27w85zdxfXoL1rhLvzlc/x3MF4RAzcdueM96SmX/Es7kkHlIf?=
 =?us-ascii?Q?v1lKfzpNrftKGrER4CQl8/tIkrEe9YgQVzY7oOJEICm+b8dGBHaVSGmGqDvy?=
 =?us-ascii?Q?VxhvuJeC8cT/XgpASB60O2YmXLKukSLMM5+3sxJvpUaguQ8w4pKHNCvsxd1+?=
 =?us-ascii?Q?wVVjEN2gtvi71lhG5dBEt+Evaj2lW5gLrzQoEzdcIkUYUnGpmElT92tPl+/j?=
 =?us-ascii?Q?71l0O4hHy/DELrOXpEziCJqKvKOR/Uuto/qAOcpn1KFlws7aIO0y+TVO8z56?=
 =?us-ascii?Q?78MJfJz040TYyeASmYS58G2qDTyQOTQ5D+p82ybOJsvxQpZK6z0ZgGnysovp?=
 =?us-ascii?Q?z4ge//Ab1WFcigX1lMnQ51er9QmWdTBaNZyP0nFXRbncSwTQjIZIQ85cDP0u?=
 =?us-ascii?Q?WKiaepzKiWP0+ze3co0Ec/XNM3MCfsPDyCIoNP7WefYpVU0Qxwa8ve0RLWWu?=
 =?us-ascii?Q?DcdcFuwrz/uyu7yibPOGmX8vWxpnG+sxLTQq4S3WJXyNdKG1rO+b6nelrJMB?=
 =?us-ascii?Q?Lc1RM9qh1nCwnfpGAgzx5/m6XuB9TKZy3jKCWLuq6RK4ljFgW2/ISyfb0GI6?=
 =?us-ascii?Q?fNViTlNc9NqIOIDo+XDner34BkUECZp759k43ws826Biu97aV2Nhu0RSuFLb?=
 =?us-ascii?Q?VKsZNfVioqNkCAAr0ToXSzh/yLLe0nfm2R2v+SZuO9BdiCw2xwO1RJNUQAbf?=
 =?us-ascii?Q?JhAEgN1o8wVnpqX5iSxsL6JMZyAB0HZO1r7E6QL96uoMvXQ5lLNJPbSXZoqf?=
 =?us-ascii?Q?cJCDgKz03bu5cImW1uSG2pc8PAl4tpJf36HSScfNnmvRC5KSdYDNNC1f/oy6?=
 =?us-ascii?Q?ZzMJ7UXHNsLHCSmi4chQNESRJajGWgasecNiuGUqxRRxssFZ+rwG0togGZxj?=
 =?us-ascii?Q?ficGANytIxRk64nAgmroRpwAsy/P8jcPVMmVzzsIW/cqDuV5Rjra/3HW9BK/?=
 =?us-ascii?Q?bjPCodBG2FtmbCk23tKebjqs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3c7554-292e-448c-7889-08d8eaa3ca1d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 06:54:06.9360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWo1tZaIPBfJMI8BrjNMguLGDcCBtOIn8MmVT8LqzCyRYu8sSpplIQ4jupZou5I7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2988
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No need to have special handlings for swSMU supported ASICs.

Change-Id: I1ec552c6a2a4283cf6ab3acfe6c0753bfcca57a9
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  | 134 +++++++-----------
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  14 ++
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  27 ----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  68 +++++++--
 4 files changed, 118 insertions(+), 125 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index 607ec0999445..eba270121698 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -32,15 +32,12 @@
 #include "amdgpu_dm_irq.h"
 #include "amdgpu_pm.h"
 #include "dm_pp_smu.h"
-#include "amdgpu_smu.h"
-
 
 bool dm_pp_apply_display_requirements(
 		const struct dc_context *ctx,
 		const struct dm_pp_display_configuration *pp_display_cfg)
 {
 	struct amdgpu_device *adev = ctx->driver_context;
-	struct smu_context *smu = &adev->smu;
 	int i;
 
 	if (adev->pm.dpm_enabled) {
@@ -106,9 +103,6 @@ bool dm_pp_apply_display_requirements(
 			adev->powerplay.pp_funcs->display_configuration_change(
 				adev->powerplay.pp_handle,
 				&adev->pm.pm_display_cfg);
-		else if (adev->smu.ppt_funcs)
-			smu_display_configuration_change(smu,
-							 &adev->pm.pm_display_cfg);
 
 		amdgpu_pm_compute_clocks(adev);
 	}
@@ -148,36 +142,6 @@ static void get_default_clock_levels(
 	}
 }
 
-static enum smu_clk_type dc_to_smu_clock_type(
-		enum dm_pp_clock_type dm_pp_clk_type)
-{
-	enum smu_clk_type smu_clk_type = SMU_CLK_COUNT;
-
-	switch (dm_pp_clk_type) {
-	case DM_PP_CLOCK_TYPE_DISPLAY_CLK:
-		smu_clk_type = SMU_DISPCLK;
-		break;
-	case DM_PP_CLOCK_TYPE_ENGINE_CLK:
-		smu_clk_type = SMU_GFXCLK;
-		break;
-	case DM_PP_CLOCK_TYPE_MEMORY_CLK:
-		smu_clk_type = SMU_MCLK;
-		break;
-	case DM_PP_CLOCK_TYPE_DCEFCLK:
-		smu_clk_type = SMU_DCEFCLK;
-		break;
-	case DM_PP_CLOCK_TYPE_SOCCLK:
-		smu_clk_type = SMU_SOCCLK;
-		break;
-	default:
-		DRM_ERROR("DM_PPLIB: invalid clock type: %d!\n",
-			  dm_pp_clk_type);
-		break;
-	}
-
-	return smu_clk_type;
-}
-
 static enum amd_pp_clock_type dc_to_pp_clock_type(
 		enum dm_pp_clock_type dm_pp_clk_type)
 {
@@ -417,14 +381,8 @@ bool dm_pp_get_clock_levels_by_type_with_latency(
 						&pp_clks);
 		if (ret)
 			return false;
-	} else if (adev->smu.ppt_funcs && adev->smu.ppt_funcs->get_clock_by_type_with_latency) {
-		if (smu_get_clock_by_type_with_latency(&adev->smu,
-						       dc_to_smu_clock_type(clk_type),
-						       &pp_clks))
-			return false;
 	}
 
-
 	pp_to_dc_clock_levels_with_latency(&pp_clks, clk_level_info, clk_type);
 
 	return true;
@@ -502,10 +460,6 @@ bool dm_pp_apply_clock_for_voltage_request(
 		ret = adev->powerplay.pp_funcs->display_clock_voltage_request(
 			adev->powerplay.pp_handle,
 			&pp_clock_request);
-	else if (adev->smu.ppt_funcs &&
-		 adev->smu.ppt_funcs->display_clock_voltage_request)
-		ret = smu_display_clock_voltage_request(&adev->smu,
-							&pp_clock_request);
 	if (ret)
 		return false;
 	return true;
@@ -655,8 +609,11 @@ static enum pp_smu_status pp_nv_set_wm_ranges(struct pp_smu *pp,
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
+	void *pp_handle = adev->powerplay.pp_handle;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	smu_set_watermarks_for_clock_ranges(&adev->smu, ranges);
+	if (pp_funcs && pp_funcs->set_watermarks_for_clocks_ranges)
+		pp_funcs->set_watermarks_for_clocks_ranges(pp_handle, ranges);
 
 	return PP_SMU_RESULT_OK;
 }
@@ -665,13 +622,14 @@ static enum pp_smu_status pp_nv_set_display_count(struct pp_smu *pp, int count)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-	struct smu_context *smu = &adev->smu;
+	void *pp_handle = adev->powerplay.pp_handle;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	if (!smu->ppt_funcs)
+	if (!pp_funcs || !pp_funcs->set_active_display_count)
 		return PP_SMU_RESULT_UNSUPPORTED;
 
 	/* 0: successful or smu.ppt_funcs->set_display_count = NULL;  1: fail */
-	if (smu_set_display_count(smu, count))
+	if (pp_funcs->set_active_display_count(pp_handle, count))
 		return PP_SMU_RESULT_FAIL;
 
 	return PP_SMU_RESULT_OK;
@@ -682,13 +640,14 @@ pp_nv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int mhz)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-	struct smu_context *smu = &adev->smu;
+	void *pp_handle = adev->powerplay.pp_handle;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	if (!smu->ppt_funcs)
+	if (!pp_funcs || !pp_funcs->set_min_deep_sleep_dcefclk)
 		return PP_SMU_RESULT_UNSUPPORTED;
 
 	/* 0: successful or smu.ppt_funcs->set_deep_sleep_dcefclk = NULL;1: fail */
-	if (smu_set_deep_sleep_dcefclk(smu, mhz))
+	if (pp_funcs->set_min_deep_sleep_dcefclk(pp_handle, mhz))
 		return PP_SMU_RESULT_FAIL;
 
 	return PP_SMU_RESULT_OK;
@@ -699,10 +658,11 @@ static enum pp_smu_status pp_nv_set_hard_min_dcefclk_by_freq(
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-	struct smu_context *smu = &adev->smu;
+	void *pp_handle = adev->powerplay.pp_handle;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	struct pp_display_clock_request clock_req;
 
-	if (!smu->ppt_funcs)
+	if (!pp_funcs || !pp_funcs->display_clock_voltage_request)
 		return PP_SMU_RESULT_UNSUPPORTED;
 
 	clock_req.clock_type = amd_pp_dcef_clock;
@@ -711,7 +671,7 @@ static enum pp_smu_status pp_nv_set_hard_min_dcefclk_by_freq(
 	/* 0: successful or smu.ppt_funcs->display_clock_voltage_request = NULL
 	 * 1: fail
 	 */
-	if (smu_display_clock_voltage_request(smu, &clock_req))
+	if (pp_funcs->display_clock_voltage_request(pp_handle, &clock_req))
 		return PP_SMU_RESULT_FAIL;
 
 	return PP_SMU_RESULT_OK;
@@ -722,10 +682,11 @@ pp_nv_set_hard_min_uclk_by_freq(struct pp_smu *pp, int mhz)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-	struct smu_context *smu = &adev->smu;
+	void *pp_handle = adev->powerplay.pp_handle;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	struct pp_display_clock_request clock_req;
 
-	if (!smu->ppt_funcs)
+	if (!pp_funcs || !pp_funcs->display_clock_voltage_request)
 		return PP_SMU_RESULT_UNSUPPORTED;
 
 	clock_req.clock_type = amd_pp_mem_clock;
@@ -734,7 +695,7 @@ pp_nv_set_hard_min_uclk_by_freq(struct pp_smu *pp, int mhz)
 	/* 0: successful or smu.ppt_funcs->display_clock_voltage_request = NULL
 	 * 1: fail
 	 */
-	if (smu_display_clock_voltage_request(smu, &clock_req))
+	if (pp_funcs->display_clock_voltage_request(pp_handle, &clock_req))
 		return PP_SMU_RESULT_FAIL;
 
 	return PP_SMU_RESULT_OK;
@@ -745,10 +706,14 @@ static enum pp_smu_status pp_nv_set_pstate_handshake_support(
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-	struct smu_context *smu = &adev->smu;
+	void *pp_handle = adev->powerplay.pp_handle;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	if (smu_display_disable_memory_clock_switch(smu, !pstate_handshake_supported))
-		return PP_SMU_RESULT_FAIL;
+	if (pp_funcs && pp_funcs->display_disable_memory_clock_switch) {
+		if (pp_funcs->display_disable_memory_clock_switch(pp_handle,
+								  !pstate_handshake_supported))
+			return PP_SMU_RESULT_FAIL;
+	}
 
 	return PP_SMU_RESULT_OK;
 }
@@ -758,10 +723,11 @@ static enum pp_smu_status pp_nv_set_voltage_by_freq(struct pp_smu *pp,
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-	struct smu_context *smu = &adev->smu;
+	void *pp_handle = adev->powerplay.pp_handle;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	struct pp_display_clock_request clock_req;
 
-	if (!smu->ppt_funcs)
+	if (!pp_funcs || !pp_funcs->display_clock_voltage_request)
 		return PP_SMU_RESULT_UNSUPPORTED;
 
 	switch (clock_id) {
@@ -782,7 +748,7 @@ static enum pp_smu_status pp_nv_set_voltage_by_freq(struct pp_smu *pp,
 	/* 0: successful or smu.ppt_funcs->display_clock_voltage_request = NULL
 	 * 1: fail
 	 */
-	if (smu_display_clock_voltage_request(smu, &clock_req))
+	if (pp_funcs->display_clock_voltage_request(pp_handle, &clock_req))
 		return PP_SMU_RESULT_FAIL;
 
 	return PP_SMU_RESULT_OK;
@@ -793,15 +759,13 @@ static enum pp_smu_status pp_nv_get_maximum_sustainable_clocks(
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-	struct smu_context *smu = &adev->smu;
-
-	if (!smu->ppt_funcs)
-		return PP_SMU_RESULT_UNSUPPORTED;
+	void *pp_handle = adev->powerplay.pp_handle;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	if (!smu->ppt_funcs->get_max_sustainable_clocks_by_dc)
+	if (!pp_funcs || !pp_funcs->get_max_sustainable_clocks_by_dc)
 		return PP_SMU_RESULT_UNSUPPORTED;
 
-	if (!smu_get_max_sustainable_clocks_by_dc(smu, max_clocks))
+	if (!pp_funcs->get_max_sustainable_clocks_by_dc(pp_handle, max_clocks))
 		return PP_SMU_RESULT_OK;
 
 	return PP_SMU_RESULT_FAIL;
@@ -812,16 +776,15 @@ static enum pp_smu_status pp_nv_get_uclk_dpm_states(struct pp_smu *pp,
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-	struct smu_context *smu = &adev->smu;
-
-	if (!smu->ppt_funcs)
-		return PP_SMU_RESULT_UNSUPPORTED;
+	void *pp_handle = adev->powerplay.pp_handle;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	if (!smu->ppt_funcs->get_uclk_dpm_states)
+	if (!pp_funcs || !pp_funcs->get_uclk_dpm_states)
 		return PP_SMU_RESULT_UNSUPPORTED;
 
-	if (!smu_get_uclk_dpm_states(smu,
-			clock_values_in_khz, num_states))
+	if (!pp_funcs->get_uclk_dpm_states(pp_handle,
+					   clock_values_in_khz,
+					   num_states))
 		return PP_SMU_RESULT_OK;
 
 	return PP_SMU_RESULT_FAIL;
@@ -832,15 +795,13 @@ static enum pp_smu_status pp_rn_get_dpm_clock_table(
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-	struct smu_context *smu = &adev->smu;
-
-	if (!smu->ppt_funcs)
-		return PP_SMU_RESULT_UNSUPPORTED;
+	void *pp_handle = adev->powerplay.pp_handle;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	if (!smu->ppt_funcs->get_dpm_clock_table)
+	if (!pp_funcs || !pp_funcs->get_dpm_clock_table)
 		return PP_SMU_RESULT_UNSUPPORTED;
 
-	if (!smu_get_dpm_clock_table(smu, clock_table))
+	if (!pp_funcs->get_dpm_clock_table(pp_handle, clock_table))
 		return PP_SMU_RESULT_OK;
 
 	return PP_SMU_RESULT_FAIL;
@@ -851,8 +812,11 @@ static enum pp_smu_status pp_rn_set_wm_ranges(struct pp_smu *pp,
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
+	void *pp_handle = adev->powerplay.pp_handle;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	smu_set_watermarks_for_clock_ranges(&adev->smu, ranges);
+	if (pp_funcs && pp_funcs->set_watermarks_for_clocks_ranges)
+		pp_funcs->set_watermarks_for_clocks_ranges(pp_handle, ranges);
 
 	return PP_SMU_RESULT_OK;
 }
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 56303c9a4036..71018a5fb0b0 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -243,6 +243,9 @@ struct pp_display_clock_request;
 struct pp_clock_levels_with_voltage;
 struct pp_clock_levels_with_latency;
 struct amd_pp_clocks;
+struct pp_smu_wm_range_sets;
+struct pp_smu_nv_clock_table;
+struct dpm_clocks;
 
 struct amd_pm_funcs {
 /* export for dpm on ci and si */
@@ -337,6 +340,17 @@ struct amd_pm_funcs {
 	int (*set_df_cstate)(void *handle, enum pp_df_cstate state);
 	int (*set_xgmi_pstate)(void *handle, uint32_t pstate);
 	ssize_t (*get_gpu_metrics)(void *handle, void **table);
+	int (*set_watermarks_for_clock_ranges)(void *handle,
+					       struct pp_smu_wm_range_sets *ranges);
+	int (*display_disable_memory_clock_switch)(void *handle,
+						   bool disable_memory_clock_switch);
+	int (*get_max_sustainable_clocks_by_dc)(void *handle,
+						struct pp_smu_nv_clock_table *max_clocks);
+	int (*get_uclk_dpm_states)(void *handle,
+				   unsigned int *clock_values_in_khz,
+				   unsigned int *num_states);
+	int (*get_dpm_clock_table)(void *handle,
+				   struct dpm_clocks *clock_table);
 };
 
 struct metrics_table_header {
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 21c3c149614c..ca5a0a436cad 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1306,16 +1306,6 @@ int smu_get_fan_speed_percent(void *handle, u32 *speed);
 int smu_set_fan_speed_percent(void *handle, u32 speed);
 int smu_get_fan_speed_rpm(void *handle, uint32_t *speed);
 
-int smu_set_deep_sleep_dcefclk(struct smu_context *smu, int clk);
-
-int smu_get_clock_by_type_with_latency(struct smu_context *smu,
-				       enum smu_clk_type clk_type,
-				       struct pp_clock_levels_with_latency *clocks);
-
-int smu_display_clock_voltage_request(struct smu_context *smu,
-				      struct pp_display_clock_request *clock_req);
-int smu_display_disable_memory_clock_switch(struct smu_context *smu, bool disable_memory_clock_switch);
-
 int smu_set_xgmi_pstate(void *handle,
 			uint32_t pstate);
 
@@ -1350,14 +1340,8 @@ int smu_sys_set_pp_table(void *handle, const char *buf, size_t size);
 int smu_get_power_num_states(void *handle, struct pp_states_info *state_info);
 enum amd_pm_state_type smu_get_current_power_state(void *handle);
 int smu_write_watermarks_table(struct smu_context *smu);
-int smu_set_watermarks_for_clock_ranges(
-		struct smu_context *smu,
-		struct pp_smu_wm_range_sets *clock_ranges);
 
 /* smu to display interface */
-extern int smu_display_configuration_change(struct smu_context *smu, const
-					    struct amd_pp_display_configuration
-					    *display_config);
 extern int smu_dpm_set_power_gate(void *handle, uint32_t block_type, bool gate);
 extern int smu_handle_task(struct smu_context *smu,
 			   enum amd_dpm_forced_level level,
@@ -1377,7 +1361,6 @@ int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			    uint32_t min, uint32_t max);
 enum amd_dpm_forced_level smu_get_performance_level(void *handle);
 int smu_force_performance_level(void *handle, enum amd_dpm_forced_level level);
-int smu_set_display_count(struct smu_context *smu, uint32_t count);
 int smu_set_ac_dc(struct smu_context *smu);
 int smu_sys_get_pp_feature_mask(void *handle, char *buf);
 int smu_sys_set_pp_feature_mask(void *handle, uint64_t new_mask);
@@ -1388,16 +1371,6 @@ int smu_set_df_cstate(void *handle,
 		      enum pp_df_cstate state);
 int smu_allow_xgmi_power_down(struct smu_context *smu, bool en);
 
-int smu_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
-					 struct pp_smu_nv_clock_table *max_clocks);
-
-int smu_get_uclk_dpm_states(struct smu_context *smu,
-			    unsigned int *clock_values_in_khz,
-			    unsigned int *num_states);
-
-int smu_get_dpm_clock_table(struct smu_context *smu,
-			    struct dpm_clocks *clock_table);
-
 int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);
 
 ssize_t smu_sys_get_gpu_metrics(void *handle, void **table);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 470ca4e5d4d7..db56cb3693a3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1538,9 +1538,10 @@ static int smu_resume(void *handle)
 	return 0;
 }
 
-int smu_display_configuration_change(struct smu_context *smu,
+int smu_display_configuration_change(void *handle,
 				     const struct amd_pp_display_configuration *display_config)
 {
+	struct smu_context *smu = handle;
 	int index = 0;
 	int num_of_active_display = 0;
 
@@ -1835,8 +1836,9 @@ int smu_force_performance_level(void *handle, enum amd_dpm_forced_level level)
 	return ret;
 }
 
-int smu_set_display_count(struct smu_context *smu, uint32_t count)
+int smu_set_display_count(void *handle, uint32_t count)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2003,9 +2005,10 @@ int smu_write_watermarks_table(struct smu_context *smu)
 	return ret;
 }
 
-int smu_set_watermarks_for_clock_ranges(struct smu_context *smu,
-		struct pp_smu_wm_range_sets *clock_ranges)
+int smu_set_watermarks_for_clock_ranges(void *handle,
+					struct pp_smu_wm_range_sets *clock_ranges)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2532,8 +2535,9 @@ int smu_get_fan_speed_rpm(void *handle, uint32_t *speed)
 	return ret;
 }
 
-int smu_set_deep_sleep_dcefclk(struct smu_context *smu, int clk)
+int smu_set_deep_sleep_dcefclk(void *handle, uint32_t clk)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2548,10 +2552,12 @@ int smu_set_deep_sleep_dcefclk(struct smu_context *smu, int clk)
 	return ret;
 }
 
-int smu_get_clock_by_type_with_latency(struct smu_context *smu,
-				       enum smu_clk_type clk_type,
+int smu_get_clock_by_type_with_latency(void *handle,
+				       enum amd_pp_clock_type type,
 				       struct pp_clock_levels_with_latency *clocks)
 {
+	struct smu_context *smu = handle;
+	enum smu_clk_type clk_type;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2559,17 +2565,38 @@ int smu_get_clock_by_type_with_latency(struct smu_context *smu,
 
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->get_clock_by_type_with_latency)
+	if (smu->ppt_funcs->get_clock_by_type_with_latency) {
+		switch (type) {
+		case amd_pp_sys_clock:
+			clk_type = SMU_GFXCLK;
+			break;
+		case amd_pp_mem_clock:
+			clk_type = SMU_MCLK;
+			break;
+		case amd_pp_dcef_clock:
+			clk_type = SMU_DCEFCLK;
+			break;
+		case amd_pp_disp_clock:
+			clk_type = SMU_DISPCLK;
+			break;
+		default:
+			dev_err(smu->adev->dev, "Invalid clock type!\n");
+			mutex_unlock(&smu->mutex);
+			return -EINVAL;
+		}
+
 		ret = smu->ppt_funcs->get_clock_by_type_with_latency(smu, clk_type, clocks);
+	}
 
 	mutex_unlock(&smu->mutex);
 
 	return ret;
 }
 
-int smu_display_clock_voltage_request(struct smu_context *smu,
+int smu_display_clock_voltage_request(void *handle,
 				      struct pp_display_clock_request *clock_req)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2586,8 +2613,10 @@ int smu_display_clock_voltage_request(struct smu_context *smu,
 }
 
 
-int smu_display_disable_memory_clock_switch(struct smu_context *smu, bool disable_memory_clock_switch)
+int smu_display_disable_memory_clock_switch(void *handle,
+					    bool disable_memory_clock_switch)
 {
+	struct smu_context *smu = handle;
 	int ret = -EINVAL;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2846,9 +2875,10 @@ int smu_mode2_reset(void *handle)
 	return ret;
 }
 
-int smu_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
+int smu_get_max_sustainable_clocks_by_dc(void *handle,
 					 struct pp_smu_nv_clock_table *max_clocks)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2864,10 +2894,11 @@ int smu_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
 	return ret;
 }
 
-int smu_get_uclk_dpm_states(struct smu_context *smu,
+int smu_get_uclk_dpm_states(void *handle,
 			    unsigned int *clock_values_in_khz,
 			    unsigned int *num_states)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2901,9 +2932,10 @@ enum amd_pm_state_type smu_get_current_power_state(void *handle)
 	return pm_state;
 }
 
-int smu_get_dpm_clock_table(struct smu_context *smu,
+int smu_get_dpm_clock_table(void *handle,
 			    struct dpm_clocks *clock_table)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -3020,4 +3052,14 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.get_power_profile_mode  = smu_get_power_profile_mode,
 	.force_clock_level       = smu_force_ppclk_levels,
 	.print_clock_levels      = smu_print_ppclk_levels,
+	.get_uclk_dpm_states     = smu_get_uclk_dpm_states,
+	.get_dpm_clock_table     = smu_get_dpm_clock_table,
+	.display_configuration_change        = smu_display_configuration_change,
+	.get_clock_by_type_with_latency      = smu_get_clock_by_type_with_latency,
+	.display_clock_voltage_request       = smu_display_clock_voltage_request,
+	.set_active_display_count            = smu_set_display_count,
+	.set_min_deep_sleep_dcefclk          = smu_set_deep_sleep_dcefclk,
+	.set_watermarks_for_clock_ranges     = smu_set_watermarks_for_clock_ranges,
+	.display_disable_memory_clock_switch = smu_display_disable_memory_clock_switch,
+	.get_max_sustainable_clocks_by_dc    = smu_get_max_sustainable_clocks_by_dc,
 };
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
