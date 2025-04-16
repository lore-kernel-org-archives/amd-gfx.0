Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8428C369BA
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 05:31:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B8D10E82A;
	Wed, 16 Apr 2025 05:31:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ScyU0KZm";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5371D10E82A
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 05:31:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQAbp56gM0pdBeaUxz0t0wB/mmiQ/cpA9t75Gm0NBqhZdyi1iwN5O5N6qvxJnwC+vOLl0abiwbgdWr0JR6DGR2fWNdKSn8guczo6Mm9u6q4ynsjPbnbaYGS9FZ51a2OCRE9tAbwz1OyDi+e0KDJ/H9GlD9IK4sUvSU6+c8H1RS6ZRgq24dPd9ElFW64C/N3+OoUyF8Yb/7RVNkWRyxHVdrOUAcT/SlvBCibHBj+7gvDIsuw88mwfzztbZwf/Dsyfolr28Eaw1YfJJ832ArMPh6e2ZdFCF/AJWyr+pQ0uOcCBffpR5PoMLhTxNOEUWqLnuFSFxRnMcYEOPEM1a7JBaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAOsWNGvlw+b0aaMjx7W6xFHByldyPi8hNmh5462IBw=;
 b=WvBYDCPj78w1qfefRxaKSTUaOx5s0H6WpTh1OUFtN/NS7HWCfCygxlwq1fjSAF7ZB7VUylLExDNReif/AV5MOg1B7JqEK9J26y1tCKvIecfT5Dexvlt2wbeR4DUEeSbKUaMifKhqGNCmExqw7Timctyo/1vie0BdCaSSBnpzKsJFNUy+4QSh2o5U2MDLHaVn1pA47k0dRjK2Enzcn7c0HwmSe+5wochCJvFkimdorDPtBcL3byDzwyyRGyvj897Moglz6FLrCvZxicXOWKpGCyt4biC+aX1bWZxhxx4VAoOhLMd1mbNR10/aUlB1BVR6C67MqDg+4CaQA7rI7PhAbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAOsWNGvlw+b0aaMjx7W6xFHByldyPi8hNmh5462IBw=;
 b=ScyU0KZmk+c61u3Fa1HOiThY5hm2aUxMR1o40d5Hl+3008fp3ZXhad/1IyNPoqcGHW455OOqA6FaYtsyyn+0R3RuOszWlJXfxxOx28osE7b1hInNny4u1kjmlXhgF+PVFol4J0zIRuA5+OMuwqvYV1ht6QJVn+7Hhm7h1VuGYtw=
Received: from BY5PR17CA0072.namprd17.prod.outlook.com (2603:10b6:a03:167::49)
 by CY5PR12MB6297.namprd12.prod.outlook.com (2603:10b6:930:22::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 05:31:49 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:167:cafe::9c) by BY5PR17CA0072.outlook.office365.com
 (2603:10b6:a03:167::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.31 via Frontend Transport; Wed,
 16 Apr 2025 05:31:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 05:31:48 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Apr
 2025 00:31:45 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH v2 3/7] drm/amd/pn: Fetch static metrics table
Date: Wed, 16 Apr 2025 13:31:23 +0800
Message-ID: <20250416053127.377955-3-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250416053127.377955-1-asad.kamal@amd.com>
References: <20250416053127.377955-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|CY5PR12MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e52f7c2-73ef-4a0e-6fa2-08dd7ca7fc25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s+KSxcCfoeZGg3AP+cheEywLe0OeIGTRtdgNZDQ/JuZaOogvtCLEyXIHy+AC?=
 =?us-ascii?Q?eMhTVhMTINmwDP6ZaR0Z5PVUwgogBgTnDxwrTZR+2D7+M2KA3bnuJHjAMouH?=
 =?us-ascii?Q?Xot6Ro4UH3D8I1vx8yUpCY2LeutplzRm11cNCwkU81TwunL0WrRE9R/MPrLb?=
 =?us-ascii?Q?KZNCE3SadWv3ZxoNOQmsmhUx93P6fcSHv42JhgLRW58g8YqQC+PMc7WRg7RM?=
 =?us-ascii?Q?MyMjIi54jIABjtX8/NpyJn2fAvJrnDNCeqIDrL1nA0rLeQ60aX2dLR3TmDJA?=
 =?us-ascii?Q?KkTmNy0P5JSBlj8H+GoxNg/dO8sTClvVzK20fSEI3x9nm0ISEWrmQukQF6aA?=
 =?us-ascii?Q?WKRPen0E/4OhGq9h9J6+J3gfpeEciHpDTLdElOmNLxqs8k8TFoA9kdNHeFvO?=
 =?us-ascii?Q?dZO39yu1bsr+XlgZ7q+KQgUuwd2glJNCqnm16fj2tdPm5AAp/gsaA9IzO82k?=
 =?us-ascii?Q?3TfZ3UQH8bdHw/UHYs0BRtxWc5OJ09KIkGVDbTJjsrutns42mQX7uEIQn0sz?=
 =?us-ascii?Q?/KIbeKB/Ta2En6qCrixUdIZuTd7Z8IKijQ4H5CjS7R7tEln0er0Pryl224OL?=
 =?us-ascii?Q?2qxf7F8Zekd4sdEB2wR+58s9q/N+Hcnhe/fhEkUWzEnSOkuLDC+Bw/MO3pBm?=
 =?us-ascii?Q?sT/nhFvuoLIZOWjLJEWocd87OTLIfYUE1GoCywV9dXNBikA/20lySZjJDwbE?=
 =?us-ascii?Q?BlqOonq0SFlKoTDqZpF5/DZHwQCAabe8Mj2EqHN3HvmwTpmb3+GEvAO0HQPw?=
 =?us-ascii?Q?KTUeofCXXRvOYftOiCAM/kUwiv0MRlYwj7dpIb5ouIUn9EuLPCDGAJOGHmVQ?=
 =?us-ascii?Q?83O4nATBcxhdw3IMT0JEVmM03Zaj9v4leaz6st55B0ctVH+sUh+BIMn9K/y7?=
 =?us-ascii?Q?RIwwX+tC36GcLu82rHZdxTlunyJsDbmTgacZcvQrL9YYeFOJa3pkv1n6dR2L?=
 =?us-ascii?Q?GmpmUnNIWkSg1mFejnFkgp1mwON6XbYALJlWFXgWhYMD37IMHAJnaTHMwdtX?=
 =?us-ascii?Q?R4UAhudWKctoiiNoekUxE3r0QSBObjEt9GWjF2xXXtFs+79+sNYIEAhu6Y7S?=
 =?us-ascii?Q?PTJZPVsGj6YObxlHSUfNcmqCRU+bgkwvdBXnoeZp3wbxRxl6NMlvbwaZM27b?=
 =?us-ascii?Q?dhL4rFCLoV6JbMtsfaHSC0Bpwy7xZfGVpziTdaP3co9IzPzIkJmD3ZrdJcbk?=
 =?us-ascii?Q?tBF1yGBOWfUEia9mp7x8I8qfF5ureRzKKOT9Rk30Rghg2R/e6BFWOnS/o0/E?=
 =?us-ascii?Q?ndMuBZz+hUkXjxdBKjwS3nzVbcKmF4Cyx8om60/SCF/8HR1chBsGJow9t480?=
 =?us-ascii?Q?qQ8Np5w238GXoajhX31n2dD9AyuL8O6ISpk9lF0AdOzdAtmjg9zMF8AwtUCu?=
 =?us-ascii?Q?ruVwMpETfLu7tMEqH1E05TAApVm2ASxzm15ffkrsOnx/RZQ7nTNrHCtWQKcr?=
 =?us-ascii?Q?qeW+NJbP2FZ46jps3IAR3dl0NUNiQAnNM7RtvIB9LBfQL8tfVkSaav2j9NBJ?=
 =?us-ascii?Q?e4OHzIxxrvctziOuefrIR+cgbHuFDZXsCxEM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 05:31:48.6766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e52f7c2-73ef-4a0e-6fa2-08dd7ca7fc25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6297
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fetch static metrics table for smu_v13_0_6

v2: Add static metrics caps check to fetch static metrics table

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 177c55f457f4..94fa31fc5eba 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -177,6 +177,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(SetThrottlingPolicy,                 PPSMC_MSG_SetThrottlingPolicy,             0),
 	MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,                       0),
 	MSG_MAP(ResetVCN,                            PPSMC_MSG_ResetVCN,                       0),
+	MSG_MAP(GetStaticMetricsTable,               PPSMC_MSG_GetStaticMetricsTable,           0),
 };
 
 // clang-format on
@@ -391,6 +392,8 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
 		if ((pgm == 7 && fw_ver >= 0x7550E00) ||
 		    (pgm == 0 && fw_ver >= 0x00557E00))
 			smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS));
+		if (fw_ver >= 0x00557E00)
+			smu_v13_0_6_cap_set(smu, SMU_CAP(STATIC_METRICS));
 	}
 	if (((pgm == 7) && (fw_ver >= 0x7550700)) ||
 	    ((pgm == 0) && (fw_ver >= 0x00557900)) ||
@@ -736,6 +739,26 @@ static ssize_t smu_v13_0_6_get_pm_metrics(struct smu_context *smu,
 	return pm_metrics->common_header.structure_size;
 }
 
+static int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	uint32_t table_size = smu_table->tables[SMU_TABLE_SMU_METRICS].size;
+	struct smu_table *table = &smu_table->driver_table;
+	int ret;
+
+	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetStaticMetricsTable, NULL);
+	if (ret) {
+		dev_info(smu->adev->dev,
+				"Failed to export static metrics table!\n");
+		return ret;
+	}
+
+	amdgpu_asic_invalidate_hdp(smu->adev, NULL);
+	memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
+
+	return 0;
+}
+
 static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -803,6 +826,11 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 			GET_METRIC_FIELD(PublicSerialNumber_AID, version)[0];
 
 		pptable->Init = true;
+		if (smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS))) {
+			ret = smu_v13_0_6_get_static_metrics_table(smu);
+			if (ret)
+				return ret;
+		}
 	}
 
 	return 0;
-- 
2.46.0

