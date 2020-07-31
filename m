Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29E5C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:43:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98C7C2083E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cHUVqBTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C7C2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 468AA6E995;
	Fri, 31 Jul 2020 02:43:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3C686E995
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 02:43:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOMeHO0SFwHBTAsNCbtbJFtUysk9AWHYM/L7avuopdSNv5yno2sA7jbMeKk7nJgJAfrqy5/xAfEOTJYX5lBmpYfvZgBvx2kNrPnlT2XnEqFFZSvbemhBVufagmsHb9qpu/sGufO/5QUXMYnQPzwZsWm+V50nQqCX/nKtWT/gQ7JkzqLWJ4A2QEHsR9axb++t+eJRXI5ba+5DUHCL0bUei1d4FFqEl3xGDFZIdYiCb+NT5KaOuMxeH5odK7mAXA8/o85NCT+KzZxn/mVV+d+tA01XFbUzfOcISLbU7wGppeX9+qFIb0oIbcM8/JKNR62F5c6IHj/4zlrCINOTncYKYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lcGJSjvhMjjl5vKQhqX5qm8kcOkwfo6wf080KlcJWc=;
 b=CohBSXIuggk2XKGc9y3409fZRc4UmmY6ggb8gbVyQdWgtkFuVMLhHHpycY2r1i9Om5XjE/s4yMw0KUcgcyyI4/1MX8NNbSjbXoofvIkhLnqmTKUC2y6TK9jv01zZpT0z3IOsMU808/o6MWeuteB9sqJnH58Ho7Iw5YIKgf/a/lDh2pb2e7k8LoE7c7np+5Ly3iZyYzd8c3XiYN2T388GcwG5sYi5pXdKh+8yUXDi6mlwBEO/2OIXfU3c79sQ8oImu+/GBtZfGrVf4oEZsm/bJ9/mk7m0Kx0xfFdrVNhQmC4vTP5yiXN4TTuAb5T1e+AZVK2pjBaXtTJF/hz0I0yIng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lcGJSjvhMjjl5vKQhqX5qm8kcOkwfo6wf080KlcJWc=;
 b=cHUVqBTKoUnVQ30bIQWidnKG6SO7ZEns4O705pHjbl2Dmso8ZNjaw33Gsp9cE+wVqdf+j4e8XjXcZslLaxiTjwIklMpXs33QA8nW7oRP5J4ZHu3U5Sw/kzkaFgeatUuJTX4e3UmKMkwFJ39cVUjnXuLTWoXVJOggJIX5buKTNFs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Fri, 31 Jul 2020 02:43:53 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Fri, 31 Jul 2020
 02:43:53 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/17] drm/amd/powerplay: add Arcturus support for gpu metrics
 export
Date: Fri, 31 Jul 2020 10:43:03 +0800
Message-Id: <20200731024316.28324-4-evan.quan@amd.com>
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
 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 02:43:51 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e05d3a22-2b29-4736-fba6-08d834fb9020
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4435D32E7DB495E2C744D87DE44E0@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4mqiuXya+YGYaK73YmFAnJFGOZoZzOKYmenqztRLDmgp4th9Zi6QmW29zeWOj3aCc2IybBEV0Z+DYyROrOuAkcoqorneotElKbRhmajASvVMGC6bQBooFEmm0J1yeYali+eudo83tmDsNeGXH4mzFUWhhTzdWKBoOmSeRLrASVWLgBCnk7o1vn3pFoF0J1gKqRMCJHkLkvjg1qTLMj8jCWmRAMWwC5d/+jPS+/svFqddwFxZrucidjEjEuJ5gt3ATVLZQ5TvHFMHhjX0phOei66bkmutYVF1vNq5N2hhGjlYE7QcOiiRhJZJ6GvISnDq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(16526019)(186003)(6666004)(6486002)(36756003)(6916009)(8676002)(44832011)(83380400001)(956004)(26005)(66946007)(1076003)(5660300002)(66556008)(66476007)(4326008)(7696005)(2616005)(86362001)(2906002)(478600001)(8936002)(52116002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: tb48Yv8YEQ3ls1ECx1G9TXHnDydkrCCXYFoxfmOs+IAuZWhZQZFrY4Xh/lu3h5DCfEXvTWX2L37Sb0qEVqGjJBkqJ9gZtpcTkj3U0yXsp3+/ey/jQrusi0Lj8GYS7xJl4FNusthUgSUZ8M1zJNbMedNZvK/m0olcw/GK8nWGc8Rc70VmhXkng/Knfk5aJeBBgP4E4AmNKnqI3PbrmH0mh4gTpZ2+rX/7FTpJxYAnBSzDidlikkPNwRYbSX5aZFYh/q1O1YQqeJW8YMsjXdGFT+lgsSSp7R6B4pCm6TAn32u3iApDhSjBY0vOxlqvxWCsszdeV6B6i5QOuNW+Si5flTAWW40L3QYS/cmfg7XehFZ1x74QGVAymUAmkaH1AVZHtGvreNJS7L/jFMQ2nqq3oU6gbgni2E1HS6lTGj0qN2c7VFXlW8aLmpiNu+iRuxV22japHe+BMbsYdpA/s8yq/Sd5ztLlpk0kE3dF0XxjpwjhpHyndW8lJXVlGhltd4VBfU2DUEno5v6dDGwb2n2uqsF/ekoAhgw56TQLLX4kOjzau7H3tbnitZO6r/PnXs9tSYt2aGZSQUk9YCbZ3HdtFz21jIXlLmTriF/4jyRX6YomLwwpKH8lYk+jPKRcfnxlJGM/uxte9IoyhGHzymuwDQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e05d3a22-2b29-4736-fba6-08d834fb9020
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 02:43:53.4130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wy9z46OI4seO44+c4Qdrewdu1eeXY7ZU+bZAaF3Dihqh5RHsGAQYw1KIfw0jKGcZ
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

Add Arcturus gpu metrics export interface.

Change-Id: I372337f31e2b7174d41fb4e3af180deb94b5ec06
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 92 +++++++++++++++++++
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  3 +
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  2 +
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 14 +++
 4 files changed, 111 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index f13979687b9e..39bfe0ebfea3 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -79,6 +79,8 @@
 /* possible frequency drift (1Mhz) */
 #define EPSILON				1
 
+#define smnPCIE_ESM_CTRL			0x111003D0
+
 static const struct cmn2asic_msg_mapping arcturus_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage,			0),
 	MSG_MAP(GetSmuVersion,			     PPSMC_MSG_GetSmuVersion,			1),
@@ -234,6 +236,13 @@ static int arcturus_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_0);
+	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
+	if (!smu_table->gpu_metrics_table) {
+		kfree(smu_table->metrics_table);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
@@ -2254,6 +2263,88 @@ static void arcturus_log_thermal_throttling_event(struct smu_context *smu)
 	kgd2kfd_smi_event_throttle(smu->adev->kfd.dev, throttler_status);
 }
 
+static int arcturus_get_current_pcie_link_speed(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t esm_ctrl;
+
+	/* TODO: confirm this on real target */
+	esm_ctrl = RREG32_PCIE(smnPCIE_ESM_CTRL);
+	if ((esm_ctrl >> 15) & 0x1FFFF)
+		return (((esm_ctrl >> 8) & 0x3F) + 128);
+
+	return smu_v11_0_get_current_pcie_link_speed(smu);
+}
+
+static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
+					void **table)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct gpu_metrics_v1_0 *gpu_metrics =
+		(struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
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
+	mutex_unlock(&smu->metrics_lock);
+
+	smu_v11_0_init_gpu_metrics_v1_0(gpu_metrics);
+
+	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
+	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
+	gpu_metrics->temperature_mem = metrics.TemperatureHBM;
+	gpu_metrics->temperature_vrgfx = metrics.TemperatureVrGfx;
+	gpu_metrics->temperature_vrsoc = metrics.TemperatureVrSoc;
+	gpu_metrics->temperature_vrmem = metrics.TemperatureVrMem;
+
+	gpu_metrics->average_gfx_activity = metrics.AverageGfxActivity;
+	gpu_metrics->average_umc_activity = metrics.AverageUclkActivity;
+	gpu_metrics->average_mm_activity = metrics.VcnActivityPercentage;
+
+	gpu_metrics->average_socket_power = metrics.AverageSocketPower;
+	gpu_metrics->energy_accumulator = metrics.EnergyAccumulator;
+
+	gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequency;
+	gpu_metrics->average_socclk_frequency = metrics.AverageSocclkFrequency;
+	gpu_metrics->average_uclk_frequency = metrics.AverageUclkFrequency;
+	gpu_metrics->average_vclk0_frequency = metrics.AverageVclkFrequency;
+	gpu_metrics->average_dclk0_frequency = metrics.AverageDclkFrequency;
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
+			arcturus_get_current_pcie_link_speed(smu);
+
+	*table = (void *)gpu_metrics;
+
+	return sizeof(struct gpu_metrics_v1_0);
+}
+
 static const struct pptable_funcs arcturus_ppt_funcs = {
 	/* init dpm */
 	.get_allowed_feature_mask = arcturus_get_allowed_feature_mask,
@@ -2331,6 +2422,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.log_thermal_throttling_event = arcturus_log_thermal_throttling_event,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
+	.get_gpu_metrics = arcturus_get_gpu_metrics,
 };
 
 void arcturus_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index a08155b83289..ec2d2aa7f4ec 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -274,6 +274,9 @@ struct smu_table_context
 
 	void				*overdrive_table;
 	void                            *boot_overdrive_table;
+
+	uint32_t			gpu_metrics_table_size;
+	void				*gpu_metrics_table;
 };
 
 struct smu_dpm_context {
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index aeb12654257e..f2a522176ca0 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -272,5 +272,7 @@ int smu_v11_0_get_current_pcie_link_speed_level(struct smu_context *smu);
 
 int smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu);
 
+void smu_v11_0_init_gpu_metrics_v1_0(struct gpu_metrics_v1_0 *gpu_metrics);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 7f1229a0e8db..98b6085d4c8b 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -417,10 +417,12 @@ int smu_v11_0_fini_smc_tables(struct smu_context *smu)
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 
+	kfree(smu_table->gpu_metrics_table);
 	kfree(smu_table->boot_overdrive_table);
 	kfree(smu_table->overdrive_table);
 	kfree(smu_table->max_sustainable_clocks);
 	kfree(smu_table->driver_pptable);
+	smu_table->gpu_metrics_table = NULL;
 	smu_table->boot_overdrive_table = NULL;
 	smu_table->overdrive_table = NULL;
 	smu_table->max_sustainable_clocks = NULL;
@@ -1970,3 +1972,15 @@ int smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu)
 
 	return link_speed[speed_level];
 }
+
+void smu_v11_0_init_gpu_metrics_v1_0(struct gpu_metrics_v1_0 *gpu_metrics)
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
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
