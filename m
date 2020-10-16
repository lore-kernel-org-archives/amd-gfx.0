Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A6DC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78C85206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3eMXU+Ji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C85206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1337A6E9B0;
	Fri, 16 Oct 2020 03:28:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 405A46EA86
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:28:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iue0WmRlEBWq2/vACBoMiTsIWyaDEo7GTgoReLCgR3/HaJRIMqsvz2ymljzqFODmS4dKo55g/7cZD4qUIg0tksUeyM3ApHljrHOgAiVlpENEZnJuSX0YZ+r5Y/H8V+UEj0TnhlQKcn70Ul5mXgqjyMHJZWM2+3vdKICcdicWHMdc2eTUA7CePPChDZAMTg9LhFg0bEcHmRHf8Iq9o3WDg1Q9gxfO3Pl1aHmr40GfjtMT8zTE9QEx1FlOvuMgG7U6vXsbiJ90PZp9nRzcIL4sJ1r80Q2iQElYWfO8Oz6Tp7kkoCMlhWLH9bEXYr+51qEPTFb8fyi22NhYk/xt2eFjBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XdWCKp3tOAA8dIPrFRLz35OS+975YtexmWD+0Oe31o=;
 b=XLfYV1JquZsJpGrhVbckrr/lmUuChf4f0samm0Eb5LyUWvgqn53H0IlWrM/p07duRF4ivENdq0fa1NLiPm/iEeGK8KLUN+K1EPksa4QlUdUTBpAbGROL3D1Qmy9DLboZ77JVTk7Q00QMe+keSNeQYqL0Mu/ZUgzTg99zBSDiYk1R+Y/Dgb/f0ypjvfnHjLI9dMGv17SvzBBccU92rt56HdmpfL3Q2SMuS/15NS8pICmTAqAyc91hUOFg1XfGcovT+pqxuEG8hdlolULyfrDqFqm69zvtW7QhNylI4XyJ5fJQs/gUka9MHIMGl7A7GeUMu6tRWNX4HQaRUxbU8J6c1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XdWCKp3tOAA8dIPrFRLz35OS+975YtexmWD+0Oe31o=;
 b=3eMXU+JiUm67HV2HGD/rpkqNyqEpJJSEsK8qnwanhLnRXDMRJ6oEinLsodi5uNKLUxHJgzzxMb6gkyN9biKhFojm7Kav2/8QUAHITNCFmKHqeAkLgJjLABlj+oPVo4qW23nSx0gbX2Sa8WjevJ58dfWkoE4fXH/g5xF+4DvZ0z8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:28:22 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:28:21 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 28/40] drm/amd/pm: correct platformcaps setup
Date: Fri, 16 Oct 2020 11:26:40 +0800
Message-Id: <20201016032652.507-29-evan.quan@amd.com>
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
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:28:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 13bdb0bd-36bb-4e71-3429-08d87183887c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13547D766B42374D9837FCAAE4030@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ivmsB9w4ET5+WLFwQlvtfSUwDPsXKFixUIpsId0y5vBiIhnDuugLIvWOMstc5OEmjOmF3xMhyPaSk0scbotk/nwGQFqsAoObcVd2yrOXmIokU9jTDoYUPnzyBvUha2vGFekbO+Lnco29Vro0+blI3y2q5zyyEvKZgEryi2MngTSnqk1r6DPmQVEwOxyrufzOShcziVp9avZgv2v1xFwbYWeRTMkzQ9S2uDbPyobUWZvhJBdwzRcR7SFgetPuYhgDuQuGNDBXDBe6IOn1DjCqHkF0DoFLJIKWk/l41C7GifxXWu6pbmLJVZKFKzg9o6ss33VwURHnwnE4gxjlWBBJR8n+Zw6r1I8pQ+nizZpCbW6SJDUTQRGoWJGREcjRi9wL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(66476007)(66946007)(83380400001)(1076003)(8676002)(6486002)(5660300002)(8936002)(66556008)(6916009)(86362001)(52116002)(36756003)(7696005)(4326008)(2616005)(34490700002)(478600001)(316002)(6666004)(44832011)(16526019)(186003)(54906003)(2906002)(26005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 2t9AhvKl57qEnNoraSc23gFVUvAgnk7tkwKyClgChk11B04IRHAODmJ4P53s4WfvNDDI8cQUrRApZkgCG70ofV90SbawP4Dvn31X0ejZZRzhyfCFIGb25pfCi0PzVDd1f9BabD/ut371vsevkEK9z5u7K7hPC3jAtS4i815s8KV8h+ZiXdIMtExIfszN4dl7BipdyzmXARaj+wGzhPtYWn049IEuCg4rb2l6dQZhpxj9HtIqPSFhvPC+kdpfanFKaLWx76gKMaloRBk5seQSzgBvIfIpKdV085btVqE6xTPVkVpVAoJQL3nRyna3kEI7hAPO+11ZHc8P84vSH8LIRkvjQdUhLEMyeV2nyMzAJSBuRasvYE4SeD3z4d5Gnlc6jrCfXFXNwZtefZZPFbsXaoJSNM2NN4EEcwGOjrFTbLsxDgiz5Z1HgwNMaC8mb57anP9zn8d0V6UbqyBldhk7UzW1b1DehRlmXxuUOIwxnm/6yR4+0YeAemGtzUngZgOMN1UMamAxV+rnU96D6qi5k3Inw+RHjrJwQqku44Y+uMLZi4VP2a8y8Up2+5oh1K6VLTH0+vKWUM0+8arPHiDYVQHkEBO0TZzcUhwoPBFWaQjb53MNHmTBWm+PFihMuD0wXCdhbONOMvk2wa4LY/iu2A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bdb0bd-36bb-4e71-3429-08d87183887c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:28:21.8900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ydg29JCCnQleQg+hyndPNzqdIx0UgF0o7klYHowOG5c4c/ihDcxeVswhQhHMGZg6
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

Correct Polaris10 platformcaps setup.

Change-Id: I59f305fa072585f0df7314bda4cdd0ef083307ff
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c        |  5 +++--
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 11 +++++++++++
 .../drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c    |  7 +++++--
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
index 68a7aed16196..739e215ec8b7 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
@@ -486,9 +486,10 @@ int polaris_set_asic_special_caps(struct pp_hwmgr *hwmgr)
 	phm_cap_set(hwmgr->platform_descriptor.platformCaps,
 					PHM_PlatformCaps_AutomaticDCTransition);
 
-	if (hwmgr->chip_id != CHIP_POLARIS10)
+	if (((hwmgr->chip_id == CHIP_POLARIS11) && !hwmgr->is_kicker) ||
+	    (hwmgr->chip_id == CHIP_POLARIS12))
 		phm_cap_set(hwmgr->platform_descriptor.platformCaps,
-					PHM_PlatformCaps_SPLLShutdownSupport);
+				PHM_PlatformCaps_SPLLShutdownSupport);
 
 	if (hwmgr->chip_id != CHIP_POLARIS11) {
 		phm_cap_set(hwmgr->platform_descriptor.platformCaps,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 79dea9329b2a..122b15dc76e1 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -1823,6 +1823,17 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 		phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
 			PHM_PlatformCaps_EngineSpreadSpectrumSupport);
 	}
+
+	if ((adev->pdev->device == 0x699F) &&
+	    (adev->pdev->revision == 0xCF)) {
+		phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
+				PHM_PlatformCaps_PowerContainment);
+		data->enable_tdc_limit_feature = false;
+		data->enable_pkg_pwr_tracking_feature = false;
+		data->disable_edc_leakage_controller = true;
+		phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
+					PHM_PlatformCaps_ClockStretcher);
+	}
 }
 
 static int smu7_calculate_ro_range(struct pp_hwmgr *hwmgr)
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
index 997b996b25bf..8176b855b9df 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
@@ -2041,8 +2041,11 @@ static int polaris10_init_smc_table(struct pp_hwmgr *hwmgr)
 	if (atomctrl_get_pp_assign_pin(hwmgr, PP_AC_DC_SWITCH_GPIO_PINID,
 			&gpio_pin)) {
 		table->AcDcGpio = gpio_pin.uc_gpio_pin_bit_shift;
-		phm_cap_set(hwmgr->platform_descriptor.platformCaps,
-				PHM_PlatformCaps_AutomaticDCTransition);
+		if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
+				PHM_PlatformCaps_AutomaticDCTransition) &&
+		    !smum_send_msg_to_smc(hwmgr, PPSMC_MSG_UseNewGPIOScheme, NULL))
+			phm_cap_set(hwmgr->platform_descriptor.platformCaps,
+					PHM_PlatformCaps_SMCtoPPLIBAcdcGpioScheme);
 	} else {
 		table->AcDcGpio = SMU7_UNUSED_GPIO_PIN;
 		phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
