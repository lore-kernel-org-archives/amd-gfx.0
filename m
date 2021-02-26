Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6801CC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 07:43:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E5D64ED3
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 07:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E5D64ED3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8696C6ED8F;
	Fri, 26 Feb 2021 07:43:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 407CE6ED8F
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 07:43:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3A7gDFx7l8zUmjnjHhgnpwRfjgXgBSjfw8XuBDkJMSSkrjTCzdHS6WUuILxCrq9yMfleR/ciK0IhME9q/klpgJILGkRno//QfDiN4H/jhE2a/xtiNBwdM9jhnQux8Q1CIX4ljH2KBQUbvODEeueqsCj/i1ljtg87eoF/Qvi4m23KCnIViU6N3IhIZH3jNsot8iMyWZrrl/NWQ+wXOP0PsDdN7o5D4rjDSR3ZVntuNFdi/j7xC8j8bIsiTUdaxMfVGaw/GAuQgQIGmXp9v8rWdbeOXCPNo72aYtV0SHTQTqIaDJkhuNL++8W/Q6vGrj/SlhGM1OMQtdPJVBXmz0Ikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADP2K7d3tamOoRwVayiVCOqGN1oB4S6BhahumROq4OI=;
 b=MbRzU1zkaJysUygGKsXsiB2NWlfa5rCVdZ7ZmPFUi4m1z2YUoMPMoY0linUaOrXXPwWwQh0fWawglJ3DjUSYkgOqmShs5qZT0OEZ5KdBHn23H4KnAUDGgq+ITrTC1/uq5RfsydIE9iFTIynnun42COEUqQc68BM+XZRhPJwiZ8UelbXCBcv/FzJ16+0XRCghWCjuIrD8Yxr4Xt2r4ZZt5vsfrG1A3XooUV3529Wu6xWmPWqZ8SjAqNJfSa+3PalN/sNf7Ir5UforRylmzWVj09ZdnEG4ha+ZEdLlSIfIip4WwWj7XofZTz8TE1qu+q9J8/B26Rlnd3A+J0Ge6+9yeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADP2K7d3tamOoRwVayiVCOqGN1oB4S6BhahumROq4OI=;
 b=nuI6at5fbdZKYiGtsyQCT+r5xrSkVkEBrJgCeki6fqYvG+2VHVCid8dVs9Slc40TRkbg48IvGdwm7JdTRO3bKGfWz7L3YIPzNdLOIZqQyuLr1k6tNKLEXd7+qQkwZSQW4mOf8GZnkETLUjE3NG7Jjb5gemetptgLfXe3X57QMaw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1451.namprd12.prod.outlook.com (2603:10b6:4:d::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.29; Fri, 26 Feb 2021 07:43:20 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3868.032; Fri, 26 Feb 2021
 07:43:20 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: optimize the link width/speed retrieving V2
Date: Fri, 26 Feb 2021 15:43:01 +0800
Message-Id: <20210226074301.89869-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR06CA0020.apcprd06.prod.outlook.com
 (2603:1096:202:2e::32) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR06CA0020.apcprd06.prod.outlook.com (2603:1096:202:2e::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19 via Frontend Transport; Fri, 26 Feb 2021 07:43:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1ba049fa-2ee0-498e-b4d6-08d8da2a2fd0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1451BF96940329C3419F77FFE49D9@DM5PR12MB1451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r8wR8WKOu6un9niq8nUoFj6k4OZSzQ844r4/YpBaS1N0+LcgMjsEv8QASRMVj/kxz6zmSRDwjx/H+Mqv6MIDGpo1YXGcnlkt15ZUwRPlSHYAwQ2qsBzdGmKywTNqLvtDhWvtWjYgEB+KVYf9LwJ+Pzj7HhDyXj0zxUUPsO1reOkIRYTmMXJ1pwUhetDQIEbwxFxCsadaF86pntfmpQdyATpAiceGL94B3CUqpSaP/a78Xo8Es67h1XWmdtvTRErEn6oUCw+7QPHvCutMyB8G/5FdLv6ZfcS4NtstcNcC11d1MzotSsUM5XUoztf84fFJTodYrF4cBgvEp1dgGFbWM8ZaErMjhTSxFjTi00VrtZ4nEIr8P18YaSuLN1qliifcLNarqHYLCu2Ai2rcnNVN5CR8jPdcbjybojJKGA/i9zo0Ucy3wvvuXHN/mvhnxdTWAB49QaZzAn/qwfKda9FsxSI81rqft6gLx6YtD+88HYkltnmvVI9jv7nm6U/i2YZ0EczCkVqvYdWcwqcgbVE9ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(8936002)(4326008)(44832011)(1076003)(7696005)(6486002)(956004)(2906002)(52116002)(83380400001)(36756003)(54906003)(66476007)(6666004)(186003)(8676002)(316002)(66556008)(66946007)(86362001)(2616005)(26005)(6916009)(5660300002)(478600001)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FfhuBNC4dZlVM/yqHV0FEMq0OB87nwQzC6VrvZJxvX4EPPLY4W1Wr83FaiEE?=
 =?us-ascii?Q?RmSTmGhXaFGToeztmabuvCbRHTC06Wt9cK+ilmEmblnvhB/ZCls3OtJaGirJ?=
 =?us-ascii?Q?9KlOEuLvVCmI3DlyhH2icVYuBNKoiujin8YPuvLX4CucW2uodjcYTFXKyLcU?=
 =?us-ascii?Q?3Uv4GEM7BHMBET8Aw/qGYxqLb4jPnloaYpuC5yUz2GcICHMuj9Y/KUmqTMzS?=
 =?us-ascii?Q?cteZ9jFuyt7F4ZUdLbNX4jqi0P3+JoGFG78Pi7AaLzc29kiMTlT2otp3WwwZ?=
 =?us-ascii?Q?eFAqog/zzUYTT0MEn/FL6ZPSt1xv0G4Phq5EmCgTLBEa3wlNQVw9R3KCzwKf?=
 =?us-ascii?Q?uPt2Xih3gMv3xdIoUmwEbwGz3uJbXYaIGUdgDmsBqEmDyn+ZZtwuzdmvaKo/?=
 =?us-ascii?Q?f8F5uAnixzmZQVaHOMbsDyTKDFT1yJtLBImW+gEUeqeotA8957BFhotUMtEA?=
 =?us-ascii?Q?XCAMRg9lscsltVtifqBlB2Eu1//v7h5tuh63G/y3gN6wWcTW+i2HxRzNZqwb?=
 =?us-ascii?Q?gONGxAQ4l1FEL6u2hCMwalxn+Ck3xVTbm64F9KJMWkK/55L3zLtJ0VbDP4Zw?=
 =?us-ascii?Q?uE0HqxjKO2POZ5MzMgRuPSoYdb+kIijZ6OEcczXrvSLgRw1JEaX6OLwKYTAJ?=
 =?us-ascii?Q?ECM4TTn38fh5+o55C4MmL8a86Eg9JHTbM14S1JAQBTwGbbr+biLaDjaacUGV?=
 =?us-ascii?Q?FoCySpMo3dY7KLtmwheYXBtmfqJNPJT3hKYtsZxlGAtehnI7+R/FrIY/2hKu?=
 =?us-ascii?Q?poYqp0cmG/lPx2/AHjPnUsVvu9tbvesr0u0VzXFAeLF2i70Ce4b4zX62ClBV?=
 =?us-ascii?Q?ZQ/Wm3RAphJspAG7PQWMZRoz+kxR8JxkB+BT91k059xhzVXFwq/gDM1Whbrn?=
 =?us-ascii?Q?B0wsHvQ2M79hv1et9PZr+yroMxjoYTfe85sGrIpbK5SC1T7Olq5BfAdSaIN0?=
 =?us-ascii?Q?KtmucxVVtVrH8Ul7vfbBSzwxuyIH7fWYAFXq25Pa5QY9ReAF5YZjsRClFTkS?=
 =?us-ascii?Q?n4Uf49qDLhq8MthbpBq6aqW6RWmJcQ7MvX8upl5KawAL7QzyY7QGhSrWfzli?=
 =?us-ascii?Q?JRwTdJKekoqFq0GR5hVeZ5Me1+RAJA02HRIqLOy2vpmMnku78IfbtUtTfrfg?=
 =?us-ascii?Q?E/lyeguAkLtWplwv3/sbOkLNLtm36Yet8mNJWm0u0mqIw//rlpeXNU9lotpm?=
 =?us-ascii?Q?M3GFA1qtFvcVYGmNHJj72bIQ64Hr48vyOaPvPPjG1FapuK/SZJ/l2/XAUlQN?=
 =?us-ascii?Q?6FIfEVCWGHCicuaaG3Z0rcBVPCRBJGRKrRKUCk3R8l+QIZ5py7bUYoNEx9/K?=
 =?us-ascii?Q?e+gIWJEISefWl19dtC6DZ7EC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba049fa-2ee0-498e-b4d6-08d8da2a2fd0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 07:43:20.2251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02yK+tal0meYMtMHyih4bdMebWma48GFM4dIybzBHoflFrtDbgMJuY+fCJk2MZbD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1451
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

By using the information provided by PMFW when available.

V2: put those structures shared around SMU V11 ASICs in
    smu_v11_0.h

Change-Id: I1afec4cd07ac9608861ee07c449e320e3f36a932
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        | 10 ++++++++--
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 12 ++++-------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 20 +++++++++++++++----
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 10 ++--------
 4 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 50dd1529b994..d400f75e9202 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -58,6 +58,12 @@
 #define CTF_OFFSET_HOTSPOT		5
 #define CTF_OFFSET_MEM			5
 
+#define LINK_WIDTH_MAX			6
+#define LINK_SPEED_MAX			3
+
+static __maybe_unused uint8_t link_width[] = {0, 1, 2, 4, 8, 12, 16};
+static __maybe_unused uint8_t link_speed[] = {25, 50, 80, 160};
+
 static const
 struct smu_temperature_range __maybe_unused smu11_thermal_policy[] =
 {
@@ -284,11 +290,11 @@ int smu_v11_0_get_dpm_level_range(struct smu_context *smu,
 
 int smu_v11_0_get_current_pcie_link_width_level(struct smu_context *smu);
 
-int smu_v11_0_get_current_pcie_link_width(struct smu_context *smu);
+uint8_t smu_v11_0_get_current_pcie_link_width(struct smu_context *smu);
 
 int smu_v11_0_get_current_pcie_link_speed_level(struct smu_context *smu);
 
-int smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu);
+uint8_t smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu);
 
 int smu_v11_0_gfx_ulv_control(struct smu_context *smu,
 			      bool enablement);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index ffd37b8a3882..f71723c345a8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2716,10 +2716,8 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
-	gpu_metrics->pcie_link_width =
-			smu_v11_0_get_current_pcie_link_width(smu);
-	gpu_metrics->pcie_link_speed =
-			smu_v11_0_get_current_pcie_link_speed(smu);
+	gpu_metrics->pcie_link_width = metrics.PcieWidth;
+	gpu_metrics->pcie_link_speed = link_speed[metrics.PcieRate];
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
@@ -2856,10 +2854,8 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
-	gpu_metrics->pcie_link_width =
-			smu_v11_0_get_current_pcie_link_width(smu);
-	gpu_metrics->pcie_link_speed =
-			smu_v11_0_get_current_pcie_link_speed(smu);
+	gpu_metrics->pcie_link_width = metrics.PcieWidth;
+	gpu_metrics->pcie_link_speed = link_speed[metrics.PcieRate];
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index e74299da1739..527e02b578af 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3124,6 +3124,8 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 	SmuMetricsExternal_t metrics_external;
 	SmuMetrics_t *metrics =
 		&(metrics_external.SmuMetrics);
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t smu_version;
 	int ret = 0;
 
 	ret = smu_cmn_get_metrics_table(smu,
@@ -3170,10 +3172,20 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->current_fan_speed = metrics->CurrFanSpeed;
 
-	gpu_metrics->pcie_link_width =
-			smu_v11_0_get_current_pcie_link_width(smu);
-	gpu_metrics->pcie_link_speed =
-			smu_v11_0_get_current_pcie_link_speed(smu);
+	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
+	if (ret)
+		return ret;
+
+	if (((adev->asic_type == CHIP_SIENNA_CICHLID) && smu_version > 0x003A1E00) ||
+	      ((adev->asic_type == CHIP_NAVY_FLOUNDER) && smu_version > 0x00410400)) {
+		gpu_metrics->pcie_link_width = metrics->PcieWidth;
+		gpu_metrics->pcie_link_speed = link_speed[metrics->PcieRate];
+	} else {
+		gpu_metrics->pcie_link_width =
+				smu_v11_0_get_current_pcie_link_width(smu);
+		gpu_metrics->pcie_link_speed =
+				smu_v11_0_get_current_pcie_link_speed(smu);
+	}
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 60ef63073ad4..7efb7af51013 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -68,9 +68,6 @@ MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_smc.bin");
 
 #define SMU11_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
 
-#define LINK_WIDTH_MAX				6
-#define LINK_SPEED_MAX				3
-
 #define smnPCIE_LC_LINK_WIDTH_CNTL		0x11140288
 #define PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK 0x00000070L
 #define PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT 0x4
@@ -99,9 +96,6 @@ MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_smc.bin");
 #define mmCG_THERMAL_STATUS_ARCT		0x90
 #define mmCG_THERMAL_STATUS_ARCT_BASE_IDX	0
 
-static int link_width[] = {0, 1, 2, 4, 8, 12, 16};
-static int link_speed[] = {25, 50, 80, 160};
-
 int smu_v11_0_init_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -2134,7 +2128,7 @@ int smu_v11_0_get_current_pcie_link_width_level(struct smu_context *smu)
 		>> PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
 }
 
-int smu_v11_0_get_current_pcie_link_width(struct smu_context *smu)
+uint8_t smu_v11_0_get_current_pcie_link_width(struct smu_context *smu)
 {
 	uint32_t width_level;
 
@@ -2154,7 +2148,7 @@ int smu_v11_0_get_current_pcie_link_speed_level(struct smu_context *smu)
 		>> PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
 }
 
-int smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu)
+uint8_t smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu)
 {
 	uint32_t speed_level;
 
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
