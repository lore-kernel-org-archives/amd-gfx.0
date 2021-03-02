Return-Path: <SRS0=vakm=IA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B0BC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 03:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEDBF6148E
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 03:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEDBF6148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B93D6E120;
	Tue,  2 Mar 2021 03:18:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99D9B6E120
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Mar 2021 03:18:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2GaXWv1raRw/l8KnnyuSaCJakDFSzZZzTHcmfA2PFgVNNlt5siMwyD4hv6Ayb314z6CHAFME7XhqmsqEqiaHAF4HsobWbWDSOYgN4ERntGGDarva/cn5ftZMa5MXMvw7l6p7+iADQEkgTkTrm8hdgcWTF0oi4pD9/uH7qQ0zudZH67mtaztcQN1vvprP2C2Av9JqJ/AL9OzQVrukLNgYKHUH8Rs5rwzUOqDL2cPWPXhA8DnIqYp+n0GnX+VF2d87ZQNA89D8pABDTf/9Vl73+VKvMRlT1ycrCRT/ACduhX3Z72hynvmAdXSKYUTFnFtjIbFvde7uSI08OEM/Q8vhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYjjY37z3MadLgIyBQXdHfC4fYP2mDZHVzPqvwVREic=;
 b=FXTA16GDmSGxcZ1xNhcs6gARkrhb3XsSRt/422gI6PZHsVQoeqzLjXaPo83RuT+JEEYsej2Er58hLviTDwlEHq/DzwbPYRWziJ/jvsRf3zkBY8DsbtVxCFkbx26y+3yc8U7mQcZdGdldfglSTe1/lUFgOPEY9ZC8rkscR1AO8n+UJubmjJR1+op+KxfuSPRUU/UpSgrHiIFzcTsrTJ3jX7Yigfnx/2swqYxLVM7OJcaMfoNc5snlsOo+e1ATQ61+f/uBtptinckM9RmRyYg/Ad3eKhGUPgXKv9REV7BIMZyu+RwzO1IwetynFM9oeuByJ0TbDhvB2EEP4fo9e5dlDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYjjY37z3MadLgIyBQXdHfC4fYP2mDZHVzPqvwVREic=;
 b=VFPL2v1o9+xAqNKWD7l9k8BqlKq0BUAHQkWpoqvVlVdTSL8jtwU3X3NFiVXiOpa7bAi5gG2GtuKOE1EFZHecdRIFenWZgYQXDL9+QghLm2gja8/q4nWK21Lr8R/3uGCr7T9wRLoZpXdTgrAO1lXQirmqz3YEfBwdWJGsv5Js4lA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3467.namprd12.prod.outlook.com (2603:10b6:5:3c::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Tue, 2 Mar 2021 03:18:42 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 03:18:42 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/pm: update existing gpu_metrics interfaces V2
Date: Tue,  2 Mar 2021 11:18:16 +0800
Message-Id: <20210302031816.490689-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210302031816.490689-1-evan.quan@amd.com>
References: <20210302031816.490689-1-evan.quan@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR03CA0064.apcprd03.prod.outlook.com
 (2603:1096:202:17::34) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR03CA0064.apcprd03.prod.outlook.com (2603:1096:202:17::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.9 via Frontend Transport; Tue, 2 Mar 2021 03:18:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 63c64442-96eb-4db5-e17d-08d8dd29e0e4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3467:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3467FC9196CF6A0420FD84B5E4999@DM6PR12MB3467.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y1n+YWHXkGyN3Xfe+aXd8SYoZe41eup0bhUQbn9yK54Z8tkbHW/TkiM93V9FEveUafeaG/AsQNMWw3oPRBzklTmWXrrxjRKHlo+4wT6E8eGab3tBNAXWKF2PqHAA2mJiNXx/PcsDLQphownxBJaVlAKqIZ+hX8xt8ioyRnn4LBUJNs6alux+cXl1ef0wK/DoX74Keg3MDDtvwvFqqntzCVvm21Ogd04i/i772nBSICCJ6P1w6921V9hX6XjLlT+Y9GgM/t+2V43cXmLOIM0+ShIoVVKGfYBwkUM7crFZnlRz1fmncbRVE13SDo3/KzK6+Vp9g4euEHBPcVkE2sjy46oG80EslGktMJGuW7WiTikHL0A4c7BJU66in2du35J+tvPnqDofoSYmayjNvQTAhIj5byYmLB5mqjAYt0VPLse1JNqwY8q2FMt4lFHHUNf/YNuZAGbThfc/Jq0Ps0R2JnbrtwfswSYtwj5OmIWwjVr4lxekdK/CboqWuum74fVRz68SQJe3QwSndHc8vlwMKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(8936002)(44832011)(52116002)(4326008)(6916009)(26005)(36756003)(7696005)(6486002)(86362001)(478600001)(83380400001)(2616005)(2906002)(66946007)(6666004)(30864003)(15650500001)(66476007)(8676002)(66556008)(5660300002)(16526019)(956004)(1076003)(19627235002)(186003)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WTOVHMoWz39ahB1Op+R0DqrvmUm6mHYzALK2Fthwf/iHzZeKmJiViksTV1Xf?=
 =?us-ascii?Q?Pmfh5lx0KpfADUL979OZegPzUHIet3bb642h0ChLWb6sj5Y1o6WPYEYQzgSK?=
 =?us-ascii?Q?LA06eoSf73+VQMtEIc1PUt89awRLXleCZm8a0p4rFgdYEl90nuKOjqlp5p3Z?=
 =?us-ascii?Q?Kn9jtqcMwE3eU3YWiL9C3wED4OZYSz6Th9RfqgxujHS8PplrnPOQABeIhcAP?=
 =?us-ascii?Q?q0K+ua3YD37DgVDvm38RiWNaxDF9665u1ut0EaYPOR2G6GNVr4JIgUgOcwVd?=
 =?us-ascii?Q?5dQx29Dw6lEmadTa3uibDPI3jD7bSNXdT7QJ+p860KY/JwonD4Gr02hI8eYq?=
 =?us-ascii?Q?SGCFM2Mj8XYj8EHxp0AoQlfo4aM4lo1AA27GH/yYU1N05RBmP2P+VRgf0Gjw?=
 =?us-ascii?Q?hqYEuOfT0RHqmELzVVKx9h6rRsObQdn5I6hEdl/V/dT2HHbq6Hyvvl0g3EJI?=
 =?us-ascii?Q?SCfHlG3PSq1bphhsRRFvgsA7NR3pM4GKi3MZLwufQLVzg5SwcrhRoFiiWy9b?=
 =?us-ascii?Q?NAV6QM1W832f5q7aR2QCxiF5n+BLKgRNPVAnGriP0aypikaLOxEk1ku6mFAq?=
 =?us-ascii?Q?mJ6xno9dPzWPe05wfI2H15L8ARMMC05+l+SkPhBANtlJLIsvoS7Vgz7XpevP?=
 =?us-ascii?Q?N9kbFMHSy62Oe07twl345E9GE4AgRMVz/xcP+SgrrelWddUr4UX6jyZYbYgq?=
 =?us-ascii?Q?MhdVj2l23HfQOw2y4g4DW3MNltgHDnLOQbdoStAmHS8AO6Q4unmCpsD32ziJ?=
 =?us-ascii?Q?DxPACDCTZE2KxJDf1YUIF2BtKAZ+mpyHV0Vo5qdaE466DExv8JEHWqx/8wi1?=
 =?us-ascii?Q?Ssz2eyegrqjS9TxlU4DfxJ7hWNqVhSc/qXQqD6OQBrAfO6BVTdcGoVlckTii?=
 =?us-ascii?Q?Mx4SISXUoTHm6PxZrG0X4bU3ZXNfWMl5PhnHSsFJdPc2cnosYDEqrgicE0+r?=
 =?us-ascii?Q?7cDKPOTvAVSJBQgZQjQkpP/zCGJo1G3hWqYGCeLFn+uYOc/Nql12MMXvbInn?=
 =?us-ascii?Q?dCVjxkIlyyOFTOaIxRTFsh5hzzpdKzfZAYGHtOmD7eD7Uq87EbPDmEiNBxOk?=
 =?us-ascii?Q?qih67P7z09bKOi1l08UvDm9zrB/eyXcUdinkMsk//3K8edQFN96X8mb7jh51?=
 =?us-ascii?Q?NjXN6v9lxvJQAb1Rz+GAYoIZAY9Cxp5OI6wzak7GNPh6ITftPPRg6jSrMn3I?=
 =?us-ascii?Q?weoNw8oOMdQXWnCpog3A+spaU4sDn/p0IGRU5zW7Jc9GPNpUEnczUBhKSAOm?=
 =?us-ascii?Q?8CP4Y/1AZg8FcxPx6uvHmamIma2DRzoEJ6KqX+/zDcJfClJHvGb34hPABKy2?=
 =?us-ascii?Q?KGt20RibAcRZ5MQuEbZswsSJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c64442-96eb-4db5-e17d-08d8dd29e0e4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 03:18:42.7488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxzuZ+m6++VVwDj06JY76hdKOvU5eZavKkV667iceUo5RibLsaSWpsbiw2YRtDJv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3467
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update the gpu_metrics interface implementations to use the latest
upgraded data structures.

V2: fit the data type change of energy_accumulator

Change-Id: Ibdbb1c3386de12c53bea3b8c68bbeebd14787287
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  8 ++--
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 16 ++++----
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 40 +++++++++----------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 14 +++----
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  4 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 10 ++---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 10 ++---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  6 +++
 8 files changed, 57 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index d400f75e9202..b5c4aff501ee 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -61,8 +61,8 @@
 #define LINK_WIDTH_MAX			6
 #define LINK_SPEED_MAX			3
 
-static __maybe_unused uint8_t link_width[] = {0, 1, 2, 4, 8, 12, 16};
-static __maybe_unused uint8_t link_speed[] = {25, 50, 80, 160};
+static __maybe_unused uint16_t link_width[] = {0, 1, 2, 4, 8, 12, 16};
+static __maybe_unused uint16_t link_speed[] = {25, 50, 80, 160};
 
 static const
 struct smu_temperature_range __maybe_unused smu11_thermal_policy[] =
@@ -290,11 +290,11 @@ int smu_v11_0_get_dpm_level_range(struct smu_context *smu,
 
 int smu_v11_0_get_current_pcie_link_width_level(struct smu_context *smu);
 
-uint8_t smu_v11_0_get_current_pcie_link_width(struct smu_context *smu);
+uint16_t smu_v11_0_get_current_pcie_link_width(struct smu_context *smu);
 
 int smu_v11_0_get_current_pcie_link_speed_level(struct smu_context *smu);
 
-uint8_t smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu);
+uint16_t smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu);
 
 int smu_v11_0_gfx_ulv_control(struct smu_context *smu,
 			      bool enablement);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 50d5f2256480..5bedf0315d14 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -236,7 +236,7 @@ static int arcturus_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_0);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_1);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table) {
 		kfree(smu_table->metrics_table);
@@ -2211,7 +2211,7 @@ static void arcturus_log_thermal_throttling_event(struct smu_context *smu)
 	kgd2kfd_smi_event_throttle(smu->adev->kfd.dev, throttler_status);
 }
 
-static int arcturus_get_current_pcie_link_speed(struct smu_context *smu)
+static uint16_t arcturus_get_current_pcie_link_speed(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t esm_ctrl;
@@ -2219,7 +2219,7 @@ static int arcturus_get_current_pcie_link_speed(struct smu_context *smu)
 	/* TODO: confirm this on real target */
 	esm_ctrl = RREG32_PCIE(smnPCIE_ESM_CTRL);
 	if ((esm_ctrl >> 15) & 0x1FFFF)
-		return (((esm_ctrl >> 8) & 0x3F) + 128);
+		return (uint16_t)(((esm_ctrl >> 8) & 0x3F) + 128);
 
 	return smu_v11_0_get_current_pcie_link_speed(smu);
 }
@@ -2228,8 +2228,8 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 					void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_0 *gpu_metrics =
-		(struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_1 *gpu_metrics =
+		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -2239,7 +2239,7 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 0);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2253,7 +2253,7 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->average_mm_activity = metrics.VcnActivityPercentage;
 
 	gpu_metrics->average_socket_power = metrics.AverageSocketPower;
-	gpu_metrics->energy_accumulator = metrics.EnergyAccumulator;
+	gpu_metrics->energy_accumulator = (uint64_t)metrics.EnergyAccumulator;
 
 	gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequency;
 	gpu_metrics->average_socclk_frequency = metrics.AverageSocclkFrequency;
@@ -2280,7 +2280,7 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_0);
+	return sizeof(struct gpu_metrics_v1_1);
 }
 
 static const struct pptable_funcs arcturus_ppt_funcs = {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 97038e027b39..4a3962fa364f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -481,7 +481,7 @@ static int navi10_tables_init(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_0);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_1);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err1_out;
@@ -2602,8 +2602,8 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 					     void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_0 *gpu_metrics =
-		(struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_1 *gpu_metrics =
+		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
 	SmuMetrics_legacy_t metrics;
 	int ret = 0;
 
@@ -2621,7 +2621,7 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 0);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2658,15 +2658,15 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_0);
+	return sizeof(struct gpu_metrics_v1_1);
 }
 
 static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_0 *gpu_metrics =
-		(struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_1 *gpu_metrics =
+		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -2684,7 +2684,7 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 0);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2716,22 +2716,22 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
-	gpu_metrics->pcie_link_width = metrics.PcieWidth;
+	gpu_metrics->pcie_link_width = (uint16_t)metrics.PcieWidth;
 	gpu_metrics->pcie_link_speed = link_speed[metrics.PcieRate];
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_0);
+	return sizeof(struct gpu_metrics_v1_1);
 }
 
 static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 					     void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_0 *gpu_metrics =
-		(struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_1 *gpu_metrics =
+		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
 	SmuMetrics_NV12_legacy_t metrics;
 	int ret = 0;
 
@@ -2749,7 +2749,7 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 0);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2767,7 +2767,7 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->average_socclk_frequency = metrics.AverageSocclkFrequency;
 	gpu_metrics->average_uclk_frequency = metrics.AverageUclkFrequency;
 
-	gpu_metrics->energy_accumulator = metrics.EnergyAccumulator;
+	gpu_metrics->energy_accumulator = (uint64_t)metrics.EnergyAccumulator;
 	gpu_metrics->average_vclk0_frequency = metrics.AverageVclkFrequency;
 	gpu_metrics->average_dclk0_frequency = metrics.AverageDclkFrequency;
 	gpu_metrics->average_mm_activity = metrics.VcnActivityPercentage;
@@ -2791,15 +2791,15 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_0);
+	return sizeof(struct gpu_metrics_v1_1);
 }
 
 static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_0 *gpu_metrics =
-		(struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_1 *gpu_metrics =
+		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
 	SmuMetrics_NV12_t metrics;
 	int ret = 0;
 
@@ -2817,7 +2817,7 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 0);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2854,14 +2854,14 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
-	gpu_metrics->pcie_link_width = metrics.PcieWidth;
+	gpu_metrics->pcie_link_width = (uint16_t)metrics.PcieWidth;
 	gpu_metrics->pcie_link_speed = link_speed[metrics.PcieRate];
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_0);
+	return sizeof(struct gpu_metrics_v1_1);
 }
 
 static ssize_t navi1x_get_gpu_metrics(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index fba741060000..5e533748449c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -543,7 +543,7 @@ static int sienna_cichlid_tables_init(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_0);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_1);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err1_out;
@@ -3119,8 +3119,8 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 					      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_0 *gpu_metrics =
-		(struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_1 *gpu_metrics =
+		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
 	SmuMetricsExternal_t metrics_external;
 	SmuMetrics_t *metrics =
 		&(metrics_external.SmuMetrics);
@@ -3134,7 +3134,7 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 0);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
 
 	gpu_metrics->temperature_edge = metrics->TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics->TemperatureHotspot;
@@ -3148,7 +3148,7 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->average_mm_activity = metrics->VcnActivityPercentage;
 
 	gpu_metrics->average_socket_power = metrics->AverageSocketPower;
-	gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
+	gpu_metrics->energy_accumulator = (uint64_t)metrics->EnergyAccumulator;
 
 	if (metrics->AverageGfxActivity <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
 		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPostDs;
@@ -3178,7 +3178,7 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 
 	if (((adev->asic_type == CHIP_SIENNA_CICHLID) && smu_version > 0x003A1E00) ||
 	      ((adev->asic_type == CHIP_NAVY_FLOUNDER) && smu_version > 0x00410400)) {
-		gpu_metrics->pcie_link_width = metrics->PcieWidth;
+		gpu_metrics->pcie_link_width = (uint16_t)metrics->PcieWidth;
 		gpu_metrics->pcie_link_speed = link_speed[metrics->PcieRate];
 	} else {
 		gpu_metrics->pcie_link_width =
@@ -3191,7 +3191,7 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_0);
+	return sizeof(struct gpu_metrics_v1_1);
 }
 
 static int sienna_cichlid_enable_mgpu_fan_boost(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 7efb7af51013..9ba4e5980cb0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -2128,7 +2128,7 @@ int smu_v11_0_get_current_pcie_link_width_level(struct smu_context *smu)
 		>> PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
 }
 
-uint8_t smu_v11_0_get_current_pcie_link_width(struct smu_context *smu)
+uint16_t smu_v11_0_get_current_pcie_link_width(struct smu_context *smu)
 {
 	uint32_t width_level;
 
@@ -2148,7 +2148,7 @@ int smu_v11_0_get_current_pcie_link_speed_level(struct smu_context *smu)
 		>> PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
 }
 
-uint8_t smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu)
+uint16_t smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu)
 {
 	uint32_t speed_level;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 3f815430e67f..95167ff59388 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -210,7 +210,7 @@ static int vangogh_tables_init(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_0);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_1);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err1_out;
@@ -1401,8 +1401,8 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v2_0 *gpu_metrics =
-		(struct gpu_metrics_v2_0 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v2_1 *gpu_metrics =
+		(struct gpu_metrics_v2_1 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -1410,7 +1410,7 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 0);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
 
 	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
 	gpu_metrics->temperature_soc = metrics.SocTemperature;
@@ -1450,7 +1450,7 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v2_0);
+	return sizeof(struct gpu_metrics_v2_1);
 }
 
 static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABLE_COMMAND type,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index c9f766cbe227..e3232295f2bf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -151,7 +151,7 @@ static int renoir_init_smc_tables(struct smu_context *smu)
 	if (!smu_table->watermarks_table)
 		goto err2_out;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_0);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_1);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err3_out;
@@ -1231,8 +1231,8 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v2_0 *gpu_metrics =
-		(struct gpu_metrics_v2_0 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v2_1 *gpu_metrics =
+		(struct gpu_metrics_v2_1 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -1240,7 +1240,7 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 0);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
 
 	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
 	gpu_metrics->temperature_soc = metrics.SocTemperature;
@@ -1285,7 +1285,7 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v2_0);
+	return sizeof(struct gpu_metrics_v2_1);
 }
 
 static int renoir_gfx_state_change_set(struct smu_context *smu, uint32_t state)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index aaaf9588d921..80555013ccbb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -760,9 +760,15 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
 	case METRICS_VERSION(1, 0):
 		structure_size = sizeof(struct gpu_metrics_v1_0);
 		break;
+	case METRICS_VERSION(1, 1):
+		structure_size = sizeof(struct gpu_metrics_v1_1);
+		break;
 	case METRICS_VERSION(2, 0):
 		structure_size = sizeof(struct gpu_metrics_v2_0);
 		break;
+	case METRICS_VERSION(2, 1):
+		structure_size = sizeof(struct gpu_metrics_v2_1);
+		break;
 	default:
 		return;
 	}
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
