Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C664C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 09:15:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8C6220809
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 09:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cMDEnq4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C6220809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88C0C6E157;
	Thu, 30 Jul 2020 09:15:06 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750045.outbound.protection.outlook.com [40.107.75.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 946696E157
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 09:15:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6L7jsHPE7IBuJIYiQj7/vJ4lg0FCcTdbFzO6ObbsxUsio02SqkU+uJ8BpNsJjOn7DsNnwFKLbVbWH6rJwi9Tp8sqbFMKp0JVFwDqDA2cEBpPMBPLCar3wMgJ5xjXBqHyFW/+W5lExtUUniVRL53lKiExjrm70F9Y90Qfp/fhjMXksHyouOOTxUhR1aU1jzPNnu/Niz9xs7Rl1EiJ83MmZtulZvBJFPu0t3o8jx50jAUmSDac+eiImB7JcGGJfFkfCvGfgmQnGZqpDf+sShSAQZWNNvxwTlDlH9RsERERK8hiezQwpXbqpToaxYFmXS+4hO8ija6RllEKjJcItvg7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5whkjM5v7tVX/Xvhxfohp1hSzMoKWHyLnQZP9uON+SA=;
 b=X8OcP2btDlTrAYdJCva0MuoMZZqnCF7LdHp6VqUkKMWXO5lnD3G0WGoiXeB7XA7ujO8YtUPwE71f7Ua4akwu8ULg8g9zdxe/i+Hn1o8nxj58A1vNViS0vMgL4CHf5xu6N8tB6Nq1/6z0ruF/q1uG8adrqeelIuKSIhw/o6VPpMp8ihV4r5+D2uV6TE1JVvFs0yvRvpPX9jazkq/Av85sUanKEvrD7UDS59IwzpCuBitdi3ilrTiqQfBheAGlqTH0tciwONLpf9wHsmMX6dI+pz9zUawmTsbw7Jivs6v94Fso9XrwOwG9nCu7wYYAwNqUbdhE+cu00kvHtI2plG0eFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5whkjM5v7tVX/Xvhxfohp1hSzMoKWHyLnQZP9uON+SA=;
 b=cMDEnq4M5bWx3eDPBYrmy8rBveEBL81rZu+WbRIEn440lrMl0/Wamcj2s65m9RI0Ff+vjZoG1UdiMKec/rtSy4biE7mgeq2AmdsmD4vG6pXqnIrv1fNqZzC6GUIZi2cdhsVjz4Ld96/8btcIdtgdtmsyZShoMwiluQ+iWmuLR9I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0027.namprd12.prod.outlook.com (2603:10b6:4:59::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.24; Thu, 30 Jul 2020 09:15:04 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Thu, 30 Jul 2020
 09:15:04 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/9] drm/amd/powerplay: add Vega20 support for gpu metrics
 export
Date: Thu, 30 Jul 2020 17:14:29 +0800
Message-Id: <20200730091436.4551-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730091436.4551-1-evan.quan@amd.com>
References: <20200730091436.4551-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::16) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR01CA0052.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Thu, 30 Jul 2020 09:15:02 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ee4359c-b0d3-46a6-2907-08d834690b54
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0027:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0027CCFB375FD811DE82D008E4710@DM5PR1201MB0027.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FGiD7Uvr+WEVZi9yrikmu8MoXEGLUM4i3/SvvG2uYB8Or+WLdJ42Fg1t9pjmhzHZhGZ8uDBk+9SsIpxuUVLVs5xxuA/IN7nlVZh7RgY05AusPLA/LYLZDnOks5iRtAX+6MTujkAMyJ0dTF7EteM4SCz/wCgLnE+zAj738OcJmEe3qpuTiVAGhdZ4g0GUGjiZjxadb2qknynpm9Ns+R3R/sDEIt10o+SVJ7ef1Sx+jwE8ODU0uLsWuo/dR0SIJmEgM3DBdYYowHAXUBJ3BvyaQeT/Kw3TM0xRgpnJcHYiesnAIBHgK/pungY6NKFZobLb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(6486002)(4326008)(2906002)(66556008)(5660300002)(66946007)(6666004)(66476007)(1076003)(83380400001)(26005)(2616005)(956004)(36756003)(44832011)(86362001)(8936002)(186003)(16526019)(6916009)(478600001)(52116002)(7696005)(316002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: PkqiqP+od9p5741Yovazb5QelHfqUMUe+M7W2tckHBHBR/mrCQWwb6qxc2J2S5GvLzdYwqZTX6A20qW/0qs8KKH+0iRpu2MPPYySXeNo/uD18PYGkZaoPdw6+ftWvVMnm5BABy3hdNRoPFIGcB9K2BPeJMXl4WNAViHepYh6ltZqkAJTSQOXG/s190ChZMkwyfsNN8YTUyKSH+v2KixCnuSPYncxGblFhj8RAHwOsfDvCJWetrmPPBnlOeK3B/EAjjyZHHq6wtCRdfIKOv5VER3uRxj6oDE+74oz16EKgiBQDW8n+DRTboQ3K2XPJ5Em5oSHcSGaNvUS5k9isuR36c4KtWJVLDM6tX1jKjp67L+RcsMS69h6dxs2kZ68htS5gsaqaSl5ILO9l3C7eO3B707bh+tod3711kSKz1PnkeMTa6DC2ddWCdgyKZ/yODduYmXZCGfLcrYp+0mTvds0f8JgMFbQj2sDowSAbhxPWb6n7Boy6BIjVkegwYY/ZYSt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee4359c-b0d3-46a6-2907-08d834690b54
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 09:15:04.1729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpqzqT0qUSV0My+C0ZDWX5BuTjIeWbhyVHBBXvLFdfZVREnZWmd8jA+7TNSMBAdj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0027
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add Vega20 gpu metrics export interface.

Change-Id: I7b4ab850358cc6d7455889d9031a7111cba35ebd
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/powerplay/hwmgr/vega20_hwmgr.c    | 121 +++++++++++++++++-
 .../drm/amd/powerplay/hwmgr/vega20_hwmgr.h    |   1 +
 2 files changed, 115 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
index bacbe2fa1f9a..77de8d88ae3a 100644
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
@@ -4218,6 +4260,70 @@ static int vega20_set_xgmi_pstate(struct pp_hwmgr *hwmgr,
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
@@ -4288,6 +4394,7 @@ static const struct pp_hwmgr_func vega20_hwmgr_funcs = {
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
