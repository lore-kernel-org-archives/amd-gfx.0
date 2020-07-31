Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CB7C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:44:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A2BB2083E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PGVQXj0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2BB2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2CD26E998;
	Fri, 31 Jul 2020 02:44:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E69B6E998
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 02:44:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyZ1nYB0G76XEqk7zdkfiyhLEsMQVj7alUif0gJqPzo72RIQ4dSgb/S5AMIPKwl9bObcGuicPMNDKIpQnd16sSLFMKggRKr6sAZvNBekonq4l8LmQ4IrPgzXBGHeMlrk5bXQhBI0Rs7gZIPEXWt7fr9AynggIVi+6gLf3eSEh+yd7NvBRwTgB1BjKRjLBLY63oScKlz8X4ak8T4EoGeETbKLoZ9OIDVTDF88xUZxOHjqDnsCtOquzgY9Y4l7HLg9qqyiXy18yeRmrgkCP50mq6QlTnd9f73Tq/48qEiQC6O1HFN7k9gWMPyuMm0moQCLlfr4oOkEP2S0bsZYyZ+gag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScQhhERfiylCU430ZEXeDymAJS+qWMhTGKTCAjHCLWU=;
 b=mJnJ2uXfFplEmYyzfW1TZ68lKl+oY81TPcmgp13FPkPbmCiboo9gGaSpd80kQTI9PGuKJaxOObIJT0Fho7aI+UmsmKLQk66gaqvRDH+5OTgMMi7iDwUVy42AlDtOyZZg92QIUo1jmqVHnMCacXAcfwPZpfv9GGb3Ej+XIVcS5sA7E5tXzo50yEODp+0qbp4m7+fJO7hmizLdlnNLvf3noCS08R3ZLTafcY3KCZuZfPScn2vFEIRouyVXooDGJ8BcMbdqkIplszr5yon161FxMl42thKXKb48R2an4U7jAzpOnM4LqRETdgkL8BI/jJwI75yMk+HVklVUXeb3XkOG/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScQhhERfiylCU430ZEXeDymAJS+qWMhTGKTCAjHCLWU=;
 b=PGVQXj0VeyonMD94jRSB33LsLQ9wD/9KZs5pdqgSVu60bk3th87MGOm4Bye0Z4QfjOeEPCrNuZh3x9FOVHNqPQ1efnkYaL6jSA75/CLempzFOiVnTkux0Tp3I6JxC+9BDYu3apZ2XBarx1zFZiuxdkLUX1zLPDf0R2C/Ao9wybo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Fri, 31 Jul 2020 02:44:19 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Fri, 31 Jul 2020
 02:44:19 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/17] drm/amd/powerplay: add Vega20 support for gpu metrics
 export
Date: Fri, 31 Jul 2020 10:43:09 +0800
Message-Id: <20200731024316.28324-10-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200731024316.28324-1-evan.quan@amd.com>
References: <20200731024316.28324-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0206.apcprd02.prod.outlook.com
 (2603:1096:201:20::18) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0206.apcprd02.prod.outlook.com (2603:1096:201:20::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 02:44:17 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7ba36e74-2640-40c8-7aa4-08d834fb9f8c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44350095B4FE3DE185F82E47E44E0@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j2IJZ2pmy88/VVjFLDhNxSJ7nO3CzLjxLyM9RsxvtfJMMyxkxJfV6vlR+0v1dxAI3dqgM6ehUeYzFqb4KtwzqZ5exj8U0PA6PcPO+AuY8ad5brrHaHJs1io6koxA0tdKYID8bJBxyJH8MwWO5HcDpgFsgo0wHTTX2U4lUrVby8VFMkefCPj7WXdOo5nvfeCbp/6MJ+P8/uFsvWh/1dhpH2Ow6E2pcQLBVqA52VhnFEWtX28NbPdhhpK+4+27cxux6baqoCiPc/yR/yDTdF04aqPn66zNaDbKM2wAuorv+AEMZQO/NoeQOk4gcxMDmEhJ/9xPeqV6ckJ0Ct5UAUlnyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(16526019)(186003)(6666004)(6486002)(36756003)(6916009)(8676002)(44832011)(83380400001)(956004)(26005)(66946007)(1076003)(5660300002)(66556008)(66476007)(4326008)(7696005)(2616005)(86362001)(2906002)(478600001)(8936002)(52116002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: UpBXzCrBiWpL6KMYLYhotzYmpT5pgCMpVfVeHkdNfaeEEaNomj4gn7G5pC+iaKDnWImt9As1rJxYm1coKtb8EJrI38ayKpT+gFBwBv5qi+ZhHdhDcVTYsIhIqViXlnPiM65fhrfx/10OS5s2GUEKutrCttz/jU/7YNwij7ntmokxVf5bhNr95D0pkInvAzuJzW8bcJ5o03LS5sRYwbXCxhBJTgMul5lqaLffiMmSkLgmBmaEis23FMoFkrn3J8IgR0/bhl8pYGb82k3lp79zTWhd66STiUKqWjKw3FSUD6ft7gqZDlkIYWQOJ0Ti8PcbKM+7ojhxGGFp0HrFUlCotNvEpO3K1yN0dr7yh+tdOVhwR3VhAOCbMkjH65wN8xLAKKFsfyny98CM7jLgSckTDltpoe5+ZVqdlFb5cRdkVM1hWTTJlfXM371e0twjQ/2I0hpirsbWW2A0KGaMQPH7wj6qUN1ScgINnEYRVZQAKCvcuUYfOAv4JiKh4PBQNwLqL0VORXzptZHXCWDTvgHxuGO2g68MZKPGnC1Zoyd/shh/+5MB/DodOxiQKQ73mgnVnmpVmEM/AN4Y5w54JqS9Jusy/UJgIJDTMOXcjKR2CKEppQDVO6tepPjtGlncO1c/2MCmsDaE1k2Tjafv6eshFw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba36e74-2640-40c8-7aa4-08d834fb9f8c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 02:44:19.2533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAPbd4mmkQ380FLgRF/MGiXgryZqpgT6SV3SC9EpBbrHVnU7Vb9haWEFr0lUh+ui
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 Evan Quan <evan.quan@amd.com>, Harish.Kasiviswanathan@amd.com,
 nirmodas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add Vega20 gpu metrics export interface.

Change-Id: I7b4ab850358cc6d7455889d9031a7111cba35ebd
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/powerplay/hwmgr/vega20_hwmgr.c    | 123 +++++++++++++++++-
 .../drm/amd/powerplay/hwmgr/vega20_hwmgr.h    |   1 +
 2 files changed, 117 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
index bacbe2fa1f9a..037bebda2eae 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
@@ -55,6 +55,11 @@
 #define smnPCIE_LC_SPEED_CNTL			0x11140290
 #define smnPCIE_LC_LINK_WIDTH_CNTL		0x11140288
 
+#define LINK_WIDTH_MAX				6
+#define LINK_SPEED_MAX				3
+static int link_width[] = {0, 1, 2, 4, 8, 12, 16};
+static int link_speed[] = {25, 50, 80, 160};
+
 static void vega20_set_default_registry_data(struct pp_hwmgr *hwmgr)
 {
 	struct vega20_hwmgr *data =
@@ -3265,6 +3270,46 @@ static int vega20_set_ppfeature_status(struct pp_hwmgr *hwmgr, uint64_t new_ppfe
 	return 0;
 }
 
+static int vega20_get_current_pcie_link_width_level(struct pp_hwmgr *hwmgr)
+{
+	struct amdgpu_device *adev = hwmgr->adev;
+
+	return (RREG32_PCIE(smnPCIE_LC_LINK_WIDTH_CNTL) &
+		PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK)
+		>> PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
+}
+
+static int vega20_get_current_pcie_link_width(struct pp_hwmgr *hwmgr)
+{
+	uint32_t width_level;
+
+	width_level = vega20_get_current_pcie_link_width_level(hwmgr);
+	if (width_level > LINK_WIDTH_MAX)
+		width_level = 0;
+
+	return link_width[width_level];
+}
+
+static int vega20_get_current_pcie_link_speed_level(struct pp_hwmgr *hwmgr)
+{
+	struct amdgpu_device *adev = hwmgr->adev;
+
+	return (RREG32_PCIE(smnPCIE_LC_SPEED_CNTL) &
+		PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK)
+		>> PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
+}
+
+static int vega20_get_current_pcie_link_speed(struct pp_hwmgr *hwmgr)
+{
+	uint32_t speed_level;
+
+	speed_level = vega20_get_current_pcie_link_speed_level(hwmgr);
+	if (speed_level > LINK_SPEED_MAX)
+		speed_level = 0;
+
+	return link_speed[speed_level];
+}
+
 static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 		enum pp_clock_type type, char *buf)
 {
@@ -3277,7 +3322,6 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 	struct phm_ppt_v3_information *pptable_information =
 		(struct phm_ppt_v3_information *)hwmgr->pptable;
 	PPTable_t *pptable = (PPTable_t *)pptable_information->smc_pptable;
-	struct amdgpu_device *adev = hwmgr->adev;
 	struct pp_clock_levels_with_latency clocks;
 	struct vega20_single_dpm_table *fclk_dpm_table =
 			&(data->dpm_table.fclk_table);
@@ -3371,12 +3415,10 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 		break;
 
 	case PP_PCIE:
-		current_gen_speed = (RREG32_PCIE(smnPCIE_LC_SPEED_CNTL) &
-			     PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK)
-			    >> PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
-		current_lane_width = (RREG32_PCIE(smnPCIE_LC_LINK_WIDTH_CNTL) &
-			      PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK)
-			    >> PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
+		current_gen_speed =
+			vega20_get_current_pcie_link_speed_level(hwmgr);
+		current_lane_width =
+			vega20_get_current_pcie_link_width_level(hwmgr);
 		for (i = 0; i < NUM_LINK_LEVELS; i++) {
 			if (i == 1 && data->pcie_parameters_override) {
 				gen_speed = data->pcie_gen_level1;
@@ -4218,6 +4260,72 @@ static int vega20_set_xgmi_pstate(struct pp_hwmgr *hwmgr,
 	return ret;
 }
 
+static void vega20_init_gpu_metrics_v1_0(struct gpu_metrics_v1_0 *gpu_metrics)
+{
+	memset(gpu_metrics, 0xFF, sizeof(struct gpu_metrics_v1_0));
+
+	gpu_metrics->common_header.structure_size =
+				sizeof(struct gpu_metrics_v1_0);
+	gpu_metrics->common_header.format_revision = 1;
+	gpu_metrics->common_header.content_revision = 0;
+
+	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
+}
+
+static ssize_t vega20_get_gpu_metrics(struct pp_hwmgr *hwmgr,
+				      void **table)
+{
+	struct vega20_hwmgr *data =
+			(struct vega20_hwmgr *)(hwmgr->backend);
+	struct gpu_metrics_v1_0 *gpu_metrics =
+			&data->gpu_metrics_table;
+	SmuMetrics_t metrics;
+	uint32_t fan_speed_rpm;
+	int ret;
+
+	ret = vega20_get_metrics_table(hwmgr, &metrics);
+	if (ret)
+		return ret;
+
+	vega20_init_gpu_metrics_v1_0(gpu_metrics);
+
+	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
+	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
+	gpu_metrics->temperature_mem = metrics.TemperatureHBM;
+	gpu_metrics->temperature_vrgfx = metrics.TemperatureVrGfx;
+	gpu_metrics->temperature_vrsoc = metrics.TemperatureVrSoc;
+	gpu_metrics->temperature_vrmem = metrics.TemperatureVrMem0;
+
+	gpu_metrics->average_gfx_activity = metrics.AverageGfxActivity;
+	gpu_metrics->average_umc_activity = metrics.AverageUclkActivity;
+
+	gpu_metrics->average_socket_power = metrics.AverageSocketPower;
+
+	gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequency;
+	gpu_metrics->average_socclk_frequency = metrics.AverageSocclkFrequency;
+	gpu_metrics->average_uclk_frequency = metrics.AverageUclkFrequency;
+
+	gpu_metrics->current_gfxclk = metrics.CurrClock[PPCLK_GFXCLK];
+	gpu_metrics->current_socclk = metrics.CurrClock[PPCLK_SOCCLK];
+	gpu_metrics->current_uclk = metrics.CurrClock[PPCLK_UCLK];
+	gpu_metrics->current_vclk0 = metrics.CurrClock[PPCLK_VCLK];
+	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
+
+	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+
+	vega20_fan_ctrl_get_fan_speed_rpm(hwmgr, &fan_speed_rpm);
+	gpu_metrics->current_fan_speed = (uint16_t)fan_speed_rpm;
+
+	gpu_metrics->pcie_link_width =
+			vega20_get_current_pcie_link_width(hwmgr);
+	gpu_metrics->pcie_link_speed =
+			vega20_get_current_pcie_link_speed(hwmgr);
+
+	*table = (void *)gpu_metrics;
+
+	return sizeof(struct gpu_metrics_v1_0);
+}
+
 static const struct pp_hwmgr_func vega20_hwmgr_funcs = {
 	/* init/fini related */
 	.backend_init = vega20_hwmgr_backend_init,
@@ -4288,6 +4396,7 @@ static const struct pp_hwmgr_func vega20_hwmgr_funcs = {
 	.smu_i2c_bus_access = vega20_smu_i2c_bus_access,
 	.set_df_cstate = vega20_set_df_cstate,
 	.set_xgmi_pstate = vega20_set_xgmi_pstate,
+	.get_gpu_metrics = vega20_get_gpu_metrics,
 };
 
 int vega20_hwmgr_init(struct pp_hwmgr *hwmgr)
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.h b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.h
index 2c3125f82b24..075c0094da9c 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.h
@@ -527,6 +527,7 @@ struct vega20_hwmgr {
 
 	unsigned long                  metrics_time;
 	SmuMetrics_t                   metrics_table;
+	struct gpu_metrics_v1_0        gpu_metrics_table;
 
 	bool                           pcie_parameters_override;
 	uint32_t                       pcie_gen_level1;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
