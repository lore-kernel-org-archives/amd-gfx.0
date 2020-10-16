Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C2BC433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF9B2078A
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XvJ3dtqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF9B2078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B00236E9BD;
	Fri, 16 Oct 2020 03:29:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBB226E9BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:29:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJEPB7x1uDohZBtwQE1RG4bp4lyXdMQ2qpkOx5Ywj6rqMAMCLVAw6igq0vDbiiZpWRZCrs6RHMJhDcaBMOAYLQFs0Ji4B0G3zEcwInlGECLJhs4JXzlCaIhYKXKHnHURaRhCOPBWKJRQ0q9Xt9GZjegiY5viO2tRu60Ui/Ul/bsgZqxVpy5XGKwc77pXVunNvvJVvcvau6wFnBJSB8EPc8AZEBXw6byFAhwqXkVHi+YWyZ3Rhjte4L4gtq3xanDGG0I38VOd+eivT7yOa5BZUhqr3TvYaMumep590UcwXP8YvwqD/86Ir9I4KsuoBQ0LUCz6B4jf9Z/xII30abK8ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+h0g/skvqqeVCi0dLHsNnF+VPnbtn7Gvde/yQqhqb3g=;
 b=msEw/KbWDfI5CZ0pqo3p3yUU8C8AD3poOZkQZq9pRQOEYvEfDJ+yb4p9Mw0rLX3HFUg+LCsN8BuyiKiq9m8eWQtmIrOPYypHSQ5BwFtOfW316X1IoLKHypUB/yVuyHpjY2Tu4yXhydu8RXto01JNCPdzYOPkpqOC1kW08mLLpocN25UvQkSXM7vJhCCoZLYrQLIFMSh/PYvu5D7U9n7SwY7ZGNRcnWEgl9RyDBTM98Chdrv7BnuOifloyefQdubx00ZCXqRJP6V2CRFs/oUyZRgyWEyviC5vPAtXt56oAwBR0CI4/hVOn+gvTyLibU/7W5mv5hbb31FmI1mLQE4T+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+h0g/skvqqeVCi0dLHsNnF+VPnbtn7Gvde/yQqhqb3g=;
 b=XvJ3dtqNCMMfVofb3Rq3HB2J4vFGe7hzcs4XEdgSoPE+9D2OQbSYaNupuMVOmqb0UL/pmAf35YafuFdP15x17FNPr+b7QywtpIILUxZ3nVW4FjFJWKAs6lFXHzRXNOegHPOvVcY5TL4LG+4O+qE7WQha9s4Yc71C6MedvbeKF4k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:29:04 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:29:04 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 38/40] drm/amd/pm: correct the mclk switching setting
Date: Fri, 16 Oct 2020 11:26:50 +0800
Message-Id: <20201016032652.507-39-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:28:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c1d86898-8fd9-4df3-3321-08d871839381
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB135419FA4B44A55853B3ED28E4030@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9skw1wPqM8/LH9h9rxvjKuxBIJcdoRiIKXWScvxk1XklqhigJWFqmfuZOr7ZTs23XwWc2VG2VJ0CLEXbVE1EKvdKNaQu8/sskiaY0BsPtpOaTF22aMMBfulMnKRJodshI/j6b4jgkkrD1hFh48h02IcSS7FcptXF01E2ad0P0klnimmfRC8JAQYSy+Um23xmMUaxLe+xvb3QyrDtc3q6Ozusu7X2KAHFw/PikRgG+ZmWcSTfHPgxWz8SUCJes/T3H6HA2pYUIFFajjvhNYVT4T1eRY3u9VRrYBqVqkg/U4jJbocdRME6ClA7LB2/NQxb52PFDuErflsgGkBGmstkXOcGq5N+3+hmYyvsordIikO64RQ9otRBgvOFqZ2sm8n8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(66476007)(66946007)(83380400001)(1076003)(8676002)(6486002)(5660300002)(8936002)(66556008)(6916009)(86362001)(52116002)(36756003)(7696005)(4326008)(30864003)(2616005)(34490700002)(478600001)(316002)(6666004)(44832011)(16526019)(186003)(54906003)(2906002)(26005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 6YKFMpgGW9YYaMp7Wd0wn+KOy9uFO7mUjaXDwnPBaSiafvDqk4lWYG4MSMyVIe4F81GDyD2gsCoINJ7i+7M6jEkJxNlx9syQtBxs2tKjTEQvGOW08MS7w/m0Kq8WtpWF8S6jxujg3HE2/xyWGoD3B5H7dtS/iPfggJtiAJA4/wK+BjGX3Nhe1ztmDiXU8YyHD/eXiDoC6AYtH+s+g0nu9fcBjZzU7yhSZ9dE6IR+6wHSZle9aDURySUGDWrgr+M+O/i+q+ardg5rSFMRzJT1HBjTK5xc+WhL8q61DgTSRlh+kpwbONFHHwwZ3qJNG+SAQ8+imRBY1RDSBDWXcmX7XkQHV3EpYajKbpqqwNz+otBj+7RC/RT60RNlNL4hJCm9mtUL0ulR/xR9qpNMQEDcgVv8TO00dvrQEI5JWVwZVhYeCNcFBPAJfTsNgb6JWCXVjAHe7ntmYeSmTD4hUVmX04sqgJJsYy8lbU+Iu5sl70llM+lTfrHqY1YRKucfmu8adj2uNe/gYoMdLt41hnQDOTU2ayYAM4QAA+pYj3u6un0Zr1Xogi6FRD0FCwu0w+lrtgc4fuxcRZ2izFz5sP/KQEfIBZlhpw4kX9NIEPOrNfZ4MMED1faiVxjRtyy1vZ0BwFLinSsPA/F5GDlcH/ruGQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d86898-8fd9-4df3-3321-08d871839381
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:28:40.3966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fj6YTSEfw38Atd2GIKNoHqnLYJFPj2JR/8Tj8UvB8shiCii86tKGBnEKgJsDx5zI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct the mclk switching setting for multiple displays.

Change-Id: Ibec856430ef9f0d0a9dee7dc5142c3591f83366b
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 113 +++++++++++++++---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h   |  12 ++
 2 files changed, 108 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index ce8f368c0a8c..509136ea193c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -170,6 +170,7 @@ uint32_t DIDTEDCConfig_P12[] = {
 static const unsigned long PhwVIslands_Magic = (unsigned long)(PHM_VIslands_Magic);
 static int smu7_force_clock_level(struct pp_hwmgr *hwmgr,
 		enum pp_clock_type type, uint32_t mask);
+static int smu7_notify_has_display(struct pp_hwmgr *hwmgr);
 
 static struct smu7_power_state *cast_phw_smu7_power_state(
 				  struct pp_hw_power_state *hw_ps)
@@ -1506,7 +1507,14 @@ static int smu7_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 	PP_ASSERT_WITH_CODE((0 == tmp_result),
 			"Failed to enable VR hot GPIO interrupt!", result = tmp_result);
 
-	smum_send_msg_to_smc(hwmgr, (PPSMC_Msg)PPSMC_NoDisplay, NULL);
+	if (hwmgr->chip_id >= CHIP_POLARIS10 &&
+	    hwmgr->chip_id <= CHIP_VEGAM) {
+		tmp_result = smu7_notify_has_display(hwmgr);
+		PP_ASSERT_WITH_CODE((0 == tmp_result),
+				"Failed to enable display setting!", result = tmp_result);
+	} else {
+		smum_send_msg_to_smc(hwmgr, (PPSMC_Msg)PPSMC_NoDisplay, NULL);
+	}
 
 	if (hwmgr->chip_id >= CHIP_POLARIS10 &&
 	    hwmgr->chip_id <= CHIP_VEGAM) {
@@ -3162,7 +3170,7 @@ static int smu7_vblank_too_short(struct pp_hwmgr *hwmgr,
 	case CHIP_POLARIS10:
 	case CHIP_POLARIS11:
 	case CHIP_POLARIS12:
-		if (hwmgr->is_kicker)
+		if (hwmgr->is_kicker || (hwmgr->chip_id == CHIP_POLARIS12))
 			switch_limit_us = data->is_memory_gddr5 ? 450 : 150;
 		else
 			switch_limit_us = data->is_memory_gddr5 ? 200 : 150;
@@ -3193,6 +3201,7 @@ static int smu7_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 	struct PP_Clocks minimum_clocks = {0};
 	bool disable_mclk_switching;
 	bool disable_mclk_switching_for_frame_lock;
+	bool disable_mclk_switching_for_display;
 	const struct phm_clock_and_voltage_limits *max_limits;
 	uint32_t i;
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
@@ -3200,9 +3209,12 @@ static int smu7_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 			(struct phm_ppt_v1_information *)(hwmgr->pptable);
 	int32_t count;
 	int32_t stable_pstate_sclk = 0, stable_pstate_mclk = 0;
+	uint32_t latency;
+	bool latency_allowed = false;
 
 	data->battery_state = (PP_StateUILabel_Battery ==
 			request_ps->classification.ui_label);
+	data->mclk_ignore_signal = false;
 
 	PP_ASSERT_WITH_CODE(smu7_ps->performance_level_count == 2,
 				 "VI should always have 2 performance levels",
@@ -3253,19 +3265,26 @@ static int smu7_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 				    hwmgr->platform_descriptor.platformCaps,
 				    PHM_PlatformCaps_DisableMclkSwitchingForFrameLock);
 
+	disable_mclk_switching_for_display = ((1 < hwmgr->display_config->num_display) &&
+						!hwmgr->display_config->multi_monitor_in_sync) ||
+						smu7_vblank_too_short(hwmgr, hwmgr->display_config->min_vblank_time);
 
-	if (hwmgr->display_config->num_display == 0)
-		disable_mclk_switching = false;
-	else
-		disable_mclk_switching = ((1 < hwmgr->display_config->num_display) &&
-					  !hwmgr->display_config->multi_monitor_in_sync) ||
-			disable_mclk_switching_for_frame_lock ||
-			smu7_vblank_too_short(hwmgr, hwmgr->display_config->min_vblank_time);
+	disable_mclk_switching = disable_mclk_switching_for_frame_lock ||
+					 disable_mclk_switching_for_display;
+
+	if (hwmgr->display_config->num_display == 0) {
+		if (hwmgr->chip_id >= CHIP_POLARIS10 && hwmgr->chip_id <= CHIP_VEGAM)
+			data->mclk_ignore_signal = true;
+		else
+			disable_mclk_switching = false;
+	}
 
 	sclk = smu7_ps->performance_levels[0].engine_clock;
 	mclk = smu7_ps->performance_levels[0].memory_clock;
 
-	if (disable_mclk_switching)
+	if (disable_mclk_switching &&
+	    (!(hwmgr->chip_id >= CHIP_POLARIS10 &&
+	    hwmgr->chip_id <= CHIP_VEGAM)))
 		mclk = smu7_ps->performance_levels
 		[smu7_ps->performance_level_count - 1].memory_clock;
 
@@ -3290,8 +3309,41 @@ static int smu7_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 		if (mclk < smu7_ps->performance_levels[1].memory_clock)
 			mclk = smu7_ps->performance_levels[1].memory_clock;
 
+		if (hwmgr->chip_id >= CHIP_POLARIS10 && hwmgr->chip_id <= CHIP_VEGAM) {
+			if (disable_mclk_switching_for_display) {
+				/* Find the lowest MCLK frequency that is within
+				 * the tolerable latency defined in DAL
+				 */
+				latency = hwmgr->display_config->dce_tolerable_mclk_in_active_latency;
+				for (i = 0; i < data->mclk_latency_table.count; i++) {
+					if (data->mclk_latency_table.entries[i].latency <= latency) {
+						latency_allowed = true;
+
+						if ((data->mclk_latency_table.entries[i].frequency >=
+								smu7_ps->performance_levels[0].memory_clock) &&
+						    (data->mclk_latency_table.entries[i].frequency <=
+								smu7_ps->performance_levels[1].memory_clock)) {
+							mclk = data->mclk_latency_table.entries[i].frequency;
+							break;
+						}
+					}
+				}
+				if ((i >= data->mclk_latency_table.count - 1) && !latency_allowed) {
+					data->mclk_ignore_signal = true;
+				} else {
+					data->mclk_ignore_signal = false;
+				}
+			}
+
+			if (disable_mclk_switching_for_frame_lock)
+				mclk = smu7_ps->performance_levels[1].memory_clock;
+		}
+
 		smu7_ps->performance_levels[0].memory_clock = mclk;
-		smu7_ps->performance_levels[1].memory_clock = mclk;
+
+		if (!(hwmgr->chip_id >= CHIP_POLARIS10 &&
+		      hwmgr->chip_id <= CHIP_VEGAM))
+			smu7_ps->performance_levels[1].memory_clock = mclk;
 	} else {
 		if (smu7_ps->performance_levels[1].memory_clock <
 				smu7_ps->performance_levels[0].memory_clock)
@@ -4037,6 +4089,7 @@ static int smu7_freeze_sclk_mclk_dpm(struct pp_hwmgr *hwmgr)
 	}
 
 	if ((0 == data->mclk_dpm_key_disabled) &&
+		!data->mclk_ignore_signal &&
 		(data->need_update_smu7_dpm_table &
 		 DPMTABLE_OD_UPDATE_MCLK)) {
 		PP_ASSERT_WITH_CODE(true == smum_is_dpm_running(hwmgr),
@@ -4193,6 +4246,7 @@ static int smu7_unfreeze_sclk_mclk_dpm(struct pp_hwmgr *hwmgr)
 	}
 
 	if ((0 == data->mclk_dpm_key_disabled) &&
+		!data->mclk_ignore_signal &&
 		(data->need_update_smu7_dpm_table & DPMTABLE_OD_UPDATE_MCLK)) {
 
 		PP_ASSERT_WITH_CODE(true == smum_is_dpm_running(hwmgr),
@@ -4246,7 +4300,12 @@ static int smu7_notify_link_speed_change_after_state_change(
 	return 0;
 }
 
-static int smu7_notify_smc_display(struct pp_hwmgr *hwmgr)
+static int smu7_notify_no_display(struct pp_hwmgr *hwmgr)
+{
+	return (smum_send_msg_to_smc(hwmgr, (PPSMC_Msg)PPSMC_NoDisplay, NULL) == 0) ?  0 : -EINVAL;
+}
+
+static int smu7_notify_has_display(struct pp_hwmgr *hwmgr)
 {
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
 
@@ -4260,9 +4319,23 @@ static int smu7_notify_smc_display(struct pp_hwmgr *hwmgr)
 					(PPSMC_Msg)PPSMC_MSG_SetVBITimeout, data->frame_time_x2,
 					NULL);
 	}
+
 	return (smum_send_msg_to_smc(hwmgr, (PPSMC_Msg)PPSMC_HasDisplay, NULL) == 0) ?  0 : -EINVAL;
 }
 
+static int smu7_notify_smc_display(struct pp_hwmgr *hwmgr)
+{
+	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	int result = 0;
+
+	if (data->mclk_ignore_signal)
+		result = smu7_notify_no_display(hwmgr);
+	else
+		result = smu7_notify_has_display(hwmgr);
+
+	return result;
+}
+
 static int smu7_set_power_state_tasks(struct pp_hwmgr *hwmgr, const void *input)
 {
 	int tmp_result, result = 0;
@@ -4313,11 +4386,6 @@ static int smu7_set_power_state_tasks(struct pp_hwmgr *hwmgr, const void *input)
 			"Failed to update SCLK threshold!",
 			result = tmp_result);
 
-	tmp_result = smu7_notify_smc_display(hwmgr);
-	PP_ASSERT_WITH_CODE((0 == tmp_result),
-			"Failed to notify smc display settings!",
-			result = tmp_result);
-
 	tmp_result = smu7_unfreeze_sclk_mclk_dpm(hwmgr);
 	PP_ASSERT_WITH_CODE((0 == tmp_result),
 			"Failed to unfreeze SCLK MCLK DPM!",
@@ -4328,6 +4396,11 @@ static int smu7_set_power_state_tasks(struct pp_hwmgr *hwmgr, const void *input)
 			"Failed to upload DPM level enabled mask!",
 			result = tmp_result);
 
+	tmp_result = smu7_notify_smc_display(hwmgr);
+	PP_ASSERT_WITH_CODE((0 == tmp_result),
+			"Failed to notify smc display settings!",
+			result = tmp_result);
+
 	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
 			PHM_PlatformCaps_PCIEPerformanceRequest)) {
 		tmp_result =
@@ -5071,16 +5144,22 @@ static int smu7_get_mclks_with_latency(struct pp_hwmgr *hwmgr,
 			(struct phm_ppt_v1_information *)hwmgr->pptable;
 	struct phm_ppt_v1_clock_voltage_dependency_table *dep_mclk_table =
 			table_info->vdd_dep_on_mclk;
+	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
 	int i;
 
 	clocks->num_levels = 0;
+	data->mclk_latency_table.count = 0;
 	for (i = 0; i < dep_mclk_table->count; i++) {
 		if (dep_mclk_table->entries[i].clk) {
 			clocks->data[clocks->num_levels].clocks_in_khz =
 					dep_mclk_table->entries[i].clk * 10;
+			data->mclk_latency_table.entries[data->mclk_latency_table.count].frequency =
+					dep_mclk_table->entries[i].clk;
 			clocks->data[clocks->num_levels].latency_in_us =
+				data->mclk_latency_table.entries[data->mclk_latency_table.count].latency =
 					smu7_get_mem_latency(hwmgr, dep_mclk_table->entries[i].clk);
 			clocks->num_levels++;
+			data->mclk_latency_table.count++;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h
index c1ed6fe587f3..dbcba73fd750 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h
@@ -200,10 +200,21 @@ struct profile_mode_setting {
 	uint16_t mclk_activity;
 };
 
+struct smu7_mclk_latency_entries {
+	uint32_t  frequency;
+	uint32_t  latency;
+};
+
+struct smu7_mclk_latency_table {
+	uint32_t  count;
+	struct smu7_mclk_latency_entries  entries[MAX_REGULAR_DPM_NUMBER];
+};
+
 struct smu7_hwmgr {
 	struct smu7_dpm_table			dpm_table;
 	struct smu7_dpm_table			golden_dpm_table;
 	struct smu7_odn_dpm_table		odn_dpm_table;
+	struct smu7_mclk_latency_table		mclk_latency_table;
 
 	uint32_t						voting_rights_clients[8];
 	uint32_t						static_screen_threshold_unit;
@@ -239,6 +250,7 @@ struct smu7_hwmgr {
 
 	bool                           pcie_performance_request;
 	bool                           battery_state;
+	bool                           mclk_ignore_signal;
 	bool                           is_tlu_enabled;
 	bool                           disable_handshake;
 	bool                           smc_voltage_control_enabled;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
