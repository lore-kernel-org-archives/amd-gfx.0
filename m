Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F010DC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 09:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C258920809
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 09:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fCWroQXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C258920809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8704C6E8A4;
	Thu, 30 Jul 2020 09:15:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEF8A6E15E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 09:15:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8gRwdi0EEhAehBQgAG2GT4S2bfv3XlQ1W9sfQV5VyMAgw6cuprtyDo0b6VGGCXlgYubsnUIYynrDpXP9vUlAD2fezUUhUFuMKRHbsXsHFyPgRppmlNKixACNKnzmGEm++j6SRv9MITmdNs2tW3ez3tloFgLuXeqZCDitvcfnYwTI3cRGAxIA0/PuCFbIARmZwUpB1lKuNC4MAQWiExBv50zi8cnwl96IFwlzkZqQVyvl6yiObbRslrOLKy1/uZkHdVvKMh6vhysxR2Ca/gzf1pMEYaEe1IWMv7Gntbxv+dTFOXtX+UjjR9BHL9EFuZMyAUzZbALqnJFYIJF1khwng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WLvCo96CC2ks64BSAXV5lhQj0XCKh72+RKOpmPN6CY=;
 b=P4X1HZ84p3aZVx4UQl1330Dyv31SoeKMC3yof/nPwjI9q06TJs8+rc0RLQNGE+s6Ssm+b/A/6awmYaopjg94ZwGeskriqRyXspVDGF1DM6/hCI/XlvV3k/0Vv8Ks60wbKUntCycZqYWEt87Kqu1RTi4Q9zPLjDzcMeuMI7BXVglNb5lyOzLQbR6kWuH30q/ETiPXMByV0KS3R9tF+O2HzdxyobpVOfOXjqTuEZ2zKZ3DdsP1PsMIHl5mP5q9ienuPvJv3lwsuwYsBo2w+hVNJ4KE3mnkhIt2dguWuFolF11cOULKtTwHNJDkKVVnOHP3c8dBeyEClMPS/36nE1HI0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WLvCo96CC2ks64BSAXV5lhQj0XCKh72+RKOpmPN6CY=;
 b=fCWroQXvKLIaI+7q5DAQIc7zCAoHAnv9e+eiGRpnBgpOpoCoKK61lms8esoLRGdcq49ytE3ZEyE2OmAG7Mv2MrrqSoiyg4WTWIr2Feh/kIWP0zNj271zF2Zza7yDnQ13AFZ3rWcweXY/J2oLsM4vTvIBSFVy7l8VM6Kjpo2IgHA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0027.namprd12.prod.outlook.com (2603:10b6:4:59::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.24; Thu, 30 Jul 2020 09:15:08 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Thu, 30 Jul 2020
 09:15:08 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/9] drm/amd/powerplay: add Vega12 support for gpu metrics
 export
Date: Thu, 30 Jul 2020 17:14:30 +0800
Message-Id: <20200730091436.4551-3-evan.quan@amd.com>
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
 Transport; Thu, 30 Jul 2020 09:15:06 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 189ea52e-3da9-421c-fb81-08d834690ddb
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0027:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0027F979F35BF256171F9C56E4710@DM5PR1201MB0027.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1HkqXGcBrYZ4NGIEjk1W0jPEeXvHqh3hKntc9iP+se1glv2EVvmK0jbLNdrvJtcVZAnCpK+qm0HPmH/V4LaYVW5gy/IrDlT6H7npA6tgGSGC0+ZorJXAmBI+eIEGl8MDstNp4Z0S2QMGnEv/fv1PoRqwBQ5JMI/+wED6ma+KI33aMeFNheBtBrLchAxZOwDI6v8p+syg1ruj2DvU7Ca4ef/nmaFivslWA9f8JzKeVt0r5pVOxOXTsUGzEPLmwFQyWuwL+xeMmnnGwjvxSgIHEOtzpuKLREs/drJCRI5ZW53EAjhf4qqX/PMiHESVsfFVbEOT9HhC6iHF7ujBnUX1Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(6486002)(4326008)(2906002)(66556008)(5660300002)(66946007)(6666004)(66476007)(1076003)(83380400001)(26005)(2616005)(956004)(36756003)(44832011)(86362001)(8936002)(186003)(16526019)(6916009)(478600001)(52116002)(7696005)(316002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0QOd2QKZJ5HRhn+g4OmcSkl9jzRqEl3L4B994T/HWaxQRhJRIOiCITjx0yPDNWJggBF/c3zA7Xu3PnatK6UuKn8im7Tv1FmCV/KZ1lt4lDb6rmNVX3a6QiK1wjmkDY5FVt3eLOd+JP72GFnwJveuuMQ+FBNHDYvzzJ4Wzs/I0/stfKCGDoMEpncgjoEXrKotfw5bxlE0EK1zcKOFkakMtSNTmdqmNsC6K8iVSkgrnCPfLMkVBX2RICFnNoTYhI8mo4YwSNI3BJia3HFrZUjMxMEdmRChlvkn3vEE2tIRllOJ1eGzVcZpY+cPRzZuUKYi51FwB57IevEptm9pZiezTv1EXUSoahdTnVYtFYqdgN6ZihL8S4XCO5Kff9sDH+C7Kj87UDejxQyiUgqTFXyeRQJ81ZQtBQe/18JBiDT+uoDXJ2uHdi9h+rfXi6mspBvAmLNNJFNcclsdeLY+YOs34XDW4oVPVdInzTJ/pTBe547hSfgvDuXG2iTuDmuLr991
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 189ea52e-3da9-421c-fb81-08d834690ddb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 09:15:08.3854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9t2j2SJxLjJmadxllEFKn3LA8+okD2l/squ3MdzchR/UR8MjP6pTku4l4OM60+Yn
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

Add Vega12 gpu metrics export interface.

Change-Id: I2c910f523049f0f90eecb8d74cb73ebb39a22bd9
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/powerplay/hwmgr/vega12_hwmgr.c    | 109 ++++++++++++++++++
 .../drm/amd/powerplay/hwmgr/vega12_hwmgr.h    |   1 +
 2 files changed, 110 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
index a678a67f1c0d..67e6a0521699 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
@@ -47,6 +47,13 @@
 #include "pp_thermal.h"
 #include "vega12_baco.h"
 
+#define smnPCIE_LC_SPEED_CNTL			0x11140290
+#define smnPCIE_LC_LINK_WIDTH_CNTL		0x11140288
+
+#define LINK_WIDTH_MAX				6
+#define LINK_SPEED_MAX				3
+static int link_width[] = {0, 1, 2, 4, 8, 12, 16};
+static int link_speed[] = {25, 50, 80, 160};
 
 static int vega12_force_clock_level(struct pp_hwmgr *hwmgr,
 		enum pp_clock_type type, uint32_t mask);
@@ -2095,6 +2102,46 @@ static int vega12_set_ppfeature_status(struct pp_hwmgr *hwmgr, uint64_t new_ppfe
 	return 0;
 }
 
+static int vega12_get_current_pcie_link_width_level(struct pp_hwmgr *hwmgr)
+{
+	struct amdgpu_device *adev = hwmgr->adev;
+
+	return (RREG32_PCIE(smnPCIE_LC_LINK_WIDTH_CNTL) &
+		PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK)
+		>> PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
+}
+
+static int vega12_get_current_pcie_link_width(struct pp_hwmgr *hwmgr)
+{
+	uint32_t width_level;
+
+	width_level = vega12_get_current_pcie_link_width_level(hwmgr);
+	if (width_level > LINK_WIDTH_MAX)
+		width_level = 0;
+
+	return link_width[width_level];
+}
+
+static int vega12_get_current_pcie_link_speed_level(struct pp_hwmgr *hwmgr)
+{
+	struct amdgpu_device *adev = hwmgr->adev;
+
+	return (RREG32_PCIE(smnPCIE_LC_SPEED_CNTL) &
+		PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK)
+		>> PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
+}
+
+static int vega12_get_current_pcie_link_speed(struct pp_hwmgr *hwmgr)
+{
+	uint32_t speed_level;
+
+	speed_level = vega12_get_current_pcie_link_speed_level(hwmgr);
+	if (speed_level > LINK_SPEED_MAX)
+		speed_level = 0;
+
+	return link_speed[speed_level];
+}
+
 static int vega12_print_clock_levels(struct pp_hwmgr *hwmgr,
 		enum pp_clock_type type, char *buf)
 {
@@ -2682,6 +2729,67 @@ static int vega12_set_mp1_state(struct pp_hwmgr *hwmgr,
 	return 0;
 }
 
+static void vega12_init_gpu_metrics_v1_0(struct gpu_metrics_v1_0 *gpu_metrics)
+{
+	memset(gpu_metrics, 0xFF, sizeof(struct gpu_metrics_v1_0));
+
+	gpu_metrics->common_header.structure_size =
+				sizeof(struct gpu_metrics_v1_0);
+	gpu_metrics->common_header.format_revision = 1;
+	gpu_metrics->common_header.content_revision = 0;
+}
+
+static ssize_t vega12_get_gpu_metrics(struct pp_hwmgr *hwmgr,
+				      void **table)
+{
+	struct vega12_hwmgr *data =
+			(struct vega12_hwmgr *)(hwmgr->backend);
+	struct gpu_metrics_v1_0 *gpu_metrics =
+			&data->gpu_metrics_table;
+	SmuMetrics_t metrics;
+	uint32_t fan_speed_rpm;
+	int ret;
+
+	ret = vega12_get_metrics_table(hwmgr, &metrics);
+	if (ret)
+		return ret;
+
+	vega12_init_gpu_metrics_v1_0(gpu_metrics);
+
+	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
+	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
+	gpu_metrics->temperature_mem = metrics.TemperatureHBM;
+	gpu_metrics->temperature_vrgfx = metrics.TemperatureVrGfx;
+	gpu_metrics->temperature_vrmem = metrics.TemperatureVrMem;
+
+	gpu_metrics->average_gfx_activity = metrics.AverageGfxActivity;
+	gpu_metrics->average_umc_activity = metrics.AverageUclkActivity;
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
+	vega12_fan_ctrl_get_fan_speed_rpm(hwmgr, &fan_speed_rpm);
+	gpu_metrics->current_fan_speed = (uint16_t)fan_speed_rpm;
+
+	gpu_metrics->pcie_link_width =
+			vega12_get_current_pcie_link_width(hwmgr);
+	gpu_metrics->pcie_link_speed =
+			vega12_get_current_pcie_link_speed(hwmgr);
+
+	*table = (void *)gpu_metrics;
+
+	return sizeof(struct gpu_metrics_v1_0);
+}
+
 static const struct pp_hwmgr_func vega12_hwmgr_funcs = {
 	.backend_init = vega12_hwmgr_backend_init,
 	.backend_fini = vega12_hwmgr_backend_fini,
@@ -2739,6 +2847,7 @@ static const struct pp_hwmgr_func vega12_hwmgr_funcs = {
 	.get_ppfeature_status = vega12_get_ppfeature_status,
 	.set_ppfeature_status = vega12_set_ppfeature_status,
 	.set_mp1_state = vega12_set_mp1_state,
+	.get_gpu_metrics = vega12_get_gpu_metrics,
 };
 
 int vega12_hwmgr_init(struct pp_hwmgr *hwmgr)
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h
index 73875399666a..aa63ae41942d 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h
@@ -399,6 +399,7 @@ struct vega12_hwmgr {
 
 	unsigned long                  metrics_time;
 	SmuMetrics_t                   metrics_table;
+	struct gpu_metrics_v1_0        gpu_metrics_table;
 };
 
 #define VEGA12_DPM2_NEAR_TDP_DEC                      10
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
