Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDAAC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 500D02083E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3ZdeYOSQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500D02083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F93F6E99B;
	Fri, 31 Jul 2020 02:44:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7683B6E99B
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 02:44:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laWTSwhPYqfKBS1N34AcGsnhBj42Xa4BAKoTU8Y92nsX5d+kJxd5ejVvoCOJ+60j/4sxr1kkUUarrARsjRqs/+zlm/ZjR2LHVQ4tsjdH2P28j8gsDeV05HRLam6rLutOx90MR800xDRb4t1sQUBnIGnwoj8Y6lTIh661xbKjf1dAJY+bNmkn4VLzUTGpulOvD8I6ZS41aO8hCEcLi7qaprUNsYpyEk0/hn1pGI5zj8rbCzt9PXZLcUaFyKBxD0JuipMQw0pzWcbst7H4rUqvz7V7TcB2dwa2fG3V66KChad1GgsM1iezbkr2YTQhdyS5sskYCl5FDlzdo+pBKAhzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlZRBRNZ+jWeIUuAaMOW9OC7rxSdhA2yGpUFJ0V2BOw=;
 b=E3HoZphHbJrF6LbZB4eB6+jJfCVqSOOZwbP5bCIt/CttShr15M/WFDWhHgYlMnK5rruX4ShYX1kZRjoJ0JOHacdwf2YcpMaxOfzchzPEgfCjtyI+PPqRGMKKuct8876AmxDzH5riaIwb22QsytDh/3ybQb+e+DDOxcCAZlHXodFCWFy61h15FgO7eSYc9Bmv8q6/2THzjZMp6PrB2BwCHe/c2vyVg6/pceSRoTk8ic/NVtP4MFCl6A31bxuPPDv6OSDQ9ZGZk0VKlRgFokOZ4/uUrIqOqRDB/3R5wHRAHKi9d7oJ910TSs0uBE6/BMi9PLWH/ADfD9TMfkZ3Mj5gIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlZRBRNZ+jWeIUuAaMOW9OC7rxSdhA2yGpUFJ0V2BOw=;
 b=3ZdeYOSQjel7b3nRIEwi3i1vv0Yi3R6+YaIOYY58HZtnHTcH28ulBzAzHT3NRrYybmuaxnEwazIEkDmbFHGmmLu8Ern345oOO3nCcJSPCTuwUzyn1ZqEqDQ0D2AoPs0ZbJjOLTDGbiMOFL1NEgiUuWZo3t/WK663Aoy/ibmviD4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Fri, 31 Jul 2020 02:44:22 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Fri, 31 Jul 2020
 02:44:22 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/17] drm/amd/powerplay: add Vega12 support for gpu metrics
 export
Date: Fri, 31 Jul 2020 10:43:10 +0800
Message-Id: <20200731024316.28324-11-evan.quan@amd.com>
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
 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 02:44:20 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 32606d77-7037-4bcc-84c7-08d834fba1ad
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB443592B7798AF5396B7E6312E44E0@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FT6I5OiQs+neWX3QnlNUiqBlhMj6JO3kIWRwnONCGVKAxdmIEbnSndgCE558aWmTw3RQXfJ6f9clWd2YIxPcyhMY+/AljL12gHTqC1zSO7CBWHy/Wsp750HztqG2jFy1EAdTNoYUVldPvHblztQyGU00QpRq48NKdFtd0GRUoEmkcfKPKy4p2sdV0hI/6R4VO9266D5GCGjG0ZLW8ADnK5f9qSHuyUhmGR+3N6nAkerkl/odKxrnhQHWRzW8BHJ6lBiLrDewvNK7VJRUrnESCYaaWB3rk2lMBbK47bXOBLipszU5wW2o8eAz13+7qxDqeai6cxbBLnSp9iwhkeXTyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(16526019)(186003)(6666004)(6486002)(36756003)(6916009)(8676002)(44832011)(83380400001)(956004)(26005)(66946007)(1076003)(5660300002)(66556008)(66476007)(4326008)(7696005)(2616005)(86362001)(2906002)(478600001)(8936002)(52116002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: +0hzvwTLKtU3OgBKRfxS6yG9Tibzm8GR+IHZId0NlmuV5+ldY0X+0GWenX3kq/dnRupQkDHOB9V64Agzy7GaIsDkiEvI/3Gr9VaqSgD+KcGnZkxiPsLk1Mm+dOkvl978owbxTGq9BZsuuHOuJ9dEnWCOBrQ4/kkA8b6BzjXNR4Px6BQJ0UuO9oY8An69dhU+EQ1PJQnJ0RiZsqx2Lv/9DHjCTEmc463yDVHpANTuLTqw68EFzj16h5DvbflINQvjaJd01Nb7aTrvVV1uGgqEsDIvMWF6W0opHPbXvzDtNQrwMA4SDjkrVnz7/Wiy9SuSkE/O3pHWe4Qttj2TnQyVRvlFzD0iM+4xrZs/39DF6f3XPiYYmNZdK9z8+onrCWHpFF4H797IQWxiF07dU9D6pE+c0I3PYjOOZVK8jBJPbdmf15WLfV8mFLgtJU7VVKJZ7UnAN4qwQuZPEsJPHBn6ZSjXbtG3wxz9s1Fz6lzlgE/Hms3kY8EEjROpZn7HtPGi0L2427Q+1QeSwWHKKH+qlqmMSSzfFk13Z6e4B9fk1ibzvJLT+vIdP2Wsb58NkdYj0UkLj03ow7nozFVPcrZT4VYxbNXHZ+Ge+x1BYz/oX79ixqOayLYJ7YY+EG02I+hIQmpbv7is6oShnNPTLaB1Rw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32606d77-7037-4bcc-84c7-08d834fba1ad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 02:44:22.8043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yc4xK40l84CP1kFzna7WNErOXycT5jSuwYufRJPeXBJ9vHkhimIuX90fVlBey1jv
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

Add Vega12 gpu metrics export interface.

Change-Id: I2c910f523049f0f90eecb8d74cb73ebb39a22bd9
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/powerplay/hwmgr/vega12_hwmgr.c    | 111 ++++++++++++++++++
 .../drm/amd/powerplay/hwmgr/vega12_hwmgr.h    |   1 +
 2 files changed, 112 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
index a678a67f1c0d..40bb0c2e4e8c 100644
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
@@ -2682,6 +2729,69 @@ static int vega12_set_mp1_state(struct pp_hwmgr *hwmgr,
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
+
+	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
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
@@ -2739,6 +2849,7 @@ static const struct pp_hwmgr_func vega12_hwmgr_funcs = {
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
