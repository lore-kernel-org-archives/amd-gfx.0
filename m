Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD8DC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:44:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A592083E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="V16h2ABq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A592083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A211C6E996;
	Fri, 31 Jul 2020 02:44:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23C416E996
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 02:44:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZysfPb+peuJALfMXS14Qum5ITD4XovykjgAupeu4Vnw1hpHrdmZF8jZmnIhjdiJw5HGPJ9TbUZDQUc2vhA+bPUq9I3bq+ctOH+DqWKpoCprH7UaWH7xeBMqc5kpTPRfr//Ow/8mpxpT9VrFPGG2uurhfbXkK8bD2nanwnfOaA6OEBH+SmZmSQOmX2gfeKce0WOvBRAoq/dCfF6jrxLevmTnmNrkrv5rOIG/o6W+aLFtzDcc39WTBlxlMbNYKrAFhXSJSZGBRsGpftbLL/mH7WXOi/TMOiNoiPi/OLCcM5VQVwZzeH6Gy+5oznEqyMN6KsGLt/u+9wimQ7KMzEc8Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AxblzIaHTJ13+F7ErsoNsBshT4Gdzl9lvXLEdoiwEg=;
 b=ofL722dpoWjj1pXNKtoC4N/pc45wvltdAuNU9Qh8pck4R2GmisoW/9QRI0jMZgMx8pHaPzugOuX7e2RPkSPO9lIPlknR9lEIInUp0XRX9gSl6NCM/W4MJd8Sj7+WvfRmnrx/3bg3260Rncq1RMxWgH05u1/lmQ3+7Ee1BUIXkjAf30b/WxC5CHybUAGS23w9xWCEu0ngB/S4Hv3i+V59XAm+g7t8iyn0gM95XasPah+3OVkUnjpk1mqvatc7XYG/WsuBNo1wJGkQkeavgZ4bHm7XuZiFGjpVfXsQB0MoHKCAVDy7KJGfTYL4opVe5HppBFnCBWzVZMaNaYDgeqbfkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AxblzIaHTJ13+F7ErsoNsBshT4Gdzl9lvXLEdoiwEg=;
 b=V16h2ABq9XNFbbmF+LxUiv/8eXazG8CowLYeAIEthi+AQULMIJkUbVLxsNToCcpRr8iq5QqDgtdmOkIvJD49t9jit5P2dwH9V8ttfo/AggqpgS0oaiCaum8Nv4J0VrmKsDC+ogWI5AGNSNep/9HdlAdQj586pM/6aDIicQQl07k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Fri, 31 Jul 2020 02:44:03 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Fri, 31 Jul 2020
 02:44:03 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/17] drm/amd/powerplay: add Navi1x support for gpu metrics
 export
Date: Fri, 31 Jul 2020 10:43:05 +0800
Message-Id: <20200731024316.28324-6-evan.quan@amd.com>
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
 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 02:44:01 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f9a5acea-a08c-4b17-a94e-08d834fb9644
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4435463E01B6E6EF78811E38E44E0@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+XGAHo4qwAezg21uSNWvAag66c/OXqOqiJ6X0ZG87MeWkF34HBIkg4+J7KusWnXhVSFa7Ulso8LHf/gdGJJbLeBSo/GumvigttD0yLl0RtEDMm5ZWPuZsuqwYdSeLS5LE6FDmFODvI9bdocp4cEyui+k0bnJwE7FNO7YEOBECqcQdxjWQcH9lWmneUOn8HIfcZz+D5ZNxfB1C0rlVYscfHXoCXv+LQiwgmVxATn59UgQF85O1NxqLDvgvVBMCbAK4QV3b4+KWG0A9P2MfI74V40DkEX5xo+KrU+JLoV/db0Sf4xc1jSw/o8y4W8oe7ugx2LHEAim+cNcQUz5xpIdx9v/0PwZOr8tMbm9zmAf7BepNKonuV68lQ7Sz1gbQlo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(16526019)(186003)(6486002)(36756003)(6916009)(8676002)(44832011)(83380400001)(956004)(26005)(66946007)(1076003)(5660300002)(66556008)(66476007)(4326008)(7696005)(2616005)(86362001)(2906002)(478600001)(8936002)(52116002)(316002)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: rSX+V/nvVaHGyzPotILRa/b+/XxbpHeENp8CEohUWvAEqN6T0sW+1/bsY9tHyhTe3XCoI2ljx5XXYifuxFnMc9xIP+IeTKkpLXbC2CLUK2AFgUbFUsqILi3R9sAvUKpVzYBLknqJekq8Tj2K1/BAtpHivJwD03rHcQH2nF01sQziXHg0yqy06DMIIcGbmmZmg2vZNtVIR6VMIUYCLhZFX1JprwyigtCO0FausY/8ry62QxlZ7EywBCmpw06PMTjm0MDAzRsuH79qnsfO6gTI7tZI24exHCq7XbR8DPUukemh0ZE8qkTMWQXUQk24HpEOSAYPw5+zxqeeq0IKjjWb5pQgDwRR4nTnip6GYEpLSOKfNKEU/QG7if3GggfhQYB+75ZvUhVU4nBrqJREJFOx4l0upNz+uXacf4rEPC27dvcCgL6BCu5KfbgxXTMbBGnXsLW3rnm6aiz6H1LzXdFqTDVibStoP0ROKqrLpdHf+UdqK0LyWl/JYxr630qY/X0mqkjN+GDrvKtywbM7WlbbcpOAwm77B4RHioOQF+8450dgsK4fk87HKb3SyWkWGmwtTK1QorlFuqqGY6N6O27DZLZkKdfngQeBbRrBNw+I6HVFHHXvOekWyyxGT5AzUQX6DnhaoC90nyTOSc9+5QiGJw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a5acea-a08c-4b17-a94e-08d834fb9644
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 02:44:03.6932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FlpoRS+j94QLKiRGZ4JJL0yZeEqfWxTxdDFNWSc0TUKboFTzTpgGstJ9xcFhvwkH
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

Add Navi1x gpu metrics export interface.

Change-Id: I9028fb925e70c36fb2a0b00968c462c0bbc822db
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 93 +++++++++++++++++++++-
 1 file changed, 91 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index a34beb27849e..a4ab1ace38fe 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -482,14 +482,26 @@ static int navi10_tables_init(struct smu_context *smu)
 					   sizeof(SmuMetrics_NV12_t) :
 					   sizeof(SmuMetrics_t), GFP_KERNEL);
 	if (!smu_table->metrics_table)
-		return -ENOMEM;
+		goto err0_out;
 	smu_table->metrics_time = 0;
 
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_0);
+	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
+	if (!smu_table->gpu_metrics_table)
+		goto err1_out;
+
 	smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t), GFP_KERNEL);
 	if (!smu_table->watermarks_table)
-		return -ENOMEM;
+		goto err2_out;
 
 	return 0;
+
+err2_out:
+	kfree(smu_table->gpu_metrics_table);
+err1_out:
+	kfree(smu_table->metrics_table);
+err0_out:
+	return -ENOMEM;
 }
 
 static int navi10_get_smu_metrics_data(struct smu_context *smu,
@@ -2501,6 +2513,82 @@ static void navi10_i2c_control_fini(struct smu_context *smu, struct i2c_adapter
 	i2c_del_adapter(control);
 }
 
+static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
+				      void **table)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct gpu_metrics_v1_0 *gpu_metrics =
+		(struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
+	struct amdgpu_device *adev = smu->adev;
+	SmuMetrics_NV12_t nv12_metrics = { 0 };
+	SmuMetrics_t metrics;
+	int ret = 0;
+
+	mutex_lock(&smu->metrics_lock);
+
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_SMU_METRICS,
+				   0,
+				   smu_table->metrics_table,
+				   false);
+	if (ret) {
+		dev_info(smu->adev->dev, "Failed to export SMU metrics table!\n");
+		mutex_unlock(&smu->metrics_lock);
+		return ret;
+	}
+	smu_table->metrics_time = jiffies;
+
+	memcpy(&metrics, smu_table->metrics_table, sizeof(SmuMetrics_t));
+
+	if (adev->asic_type == CHIP_NAVI12)
+		memcpy(&nv12_metrics, smu_table->metrics_table, sizeof(SmuMetrics_NV12_t));
+
+	mutex_unlock(&smu->metrics_lock);
+
+	smu_v11_0_init_gpu_metrics_v1_0(gpu_metrics);
+
+	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
+	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
+	gpu_metrics->temperature_mem = metrics.TemperatureMem;
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
+	if (adev->asic_type == CHIP_NAVI12) {
+		gpu_metrics->energy_accumulator = nv12_metrics.EnergyAccumulator;
+		gpu_metrics->average_vclk0_frequency = nv12_metrics.AverageVclkFrequency;
+		gpu_metrics->average_dclk0_frequency = nv12_metrics.AverageDclkFrequency;
+		gpu_metrics->average_mm_activity = nv12_metrics.VcnActivityPercentage;
+	}
+
+	gpu_metrics->current_gfxclk = metrics.CurrClock[PPCLK_GFXCLK];
+	gpu_metrics->current_socclk = metrics.CurrClock[PPCLK_SOCCLK];
+	gpu_metrics->current_uclk = metrics.CurrClock[PPCLK_UCLK];
+	gpu_metrics->current_vclk0 = metrics.CurrClock[PPCLK_VCLK];
+	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
+
+	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+
+	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
+
+	gpu_metrics->pcie_link_width =
+			smu_v11_0_get_current_pcie_link_width(smu);
+	gpu_metrics->pcie_link_speed =
+			smu_v11_0_get_current_pcie_link_speed(smu);
+
+	*table = (void *)gpu_metrics;
+
+	return sizeof(struct gpu_metrics_v1_0);
+}
 
 static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_allowed_feature_mask = navi10_get_allowed_feature_mask,
@@ -2582,6 +2670,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.set_power_source = smu_v11_0_set_power_source,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
+	.get_gpu_metrics = navi10_get_gpu_metrics,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
