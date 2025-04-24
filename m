Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24A8C369AB
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Apr 2025 11:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62D4310E7D6;
	Thu, 24 Apr 2025 11:40:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kCGGB/jR";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E73610E7D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Apr 2025 11:40:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRSd7TzY/x4QClx0gE//zJq1w+Ba8J3ci+OdITjKNzTHdwL0Spo5t5jvXD1d5IFnFDLiXJIECycnUNONjuoQMQVxwH1Lsk9E/okycTmtvToudO02zxr2bH/ew2idsfM0cxHR80r3TklYRS8+K1hDadJF+zib+rE/9J7llv8DxZooK7kvI5sDYJcN8eiU53CjU45+5EBTs+CWbTFghpmj9Y00L7NAOeBxcIY7Yw7uzbtwnhmayaheTUfLD6+tKS7EJRwKIxt9AwJnqqCshFdf9ixNphI37QvuaZ+POncSv/cktrbFGxrOJiguvttmKKnApNxfegZ/ynbNDLRjQ71hDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQv/EBtGkrG26ZLTGcQYohSuR08tkMgGJz4xpQVDPr4=;
 b=VyAhHDfDF0lhVGnWU8292wOGCF45+vkWxi34THAGNQo7SYR+g9YQznvkbmUoTRnT5cXoAMRFDcbGcD+LNTGdSlDndGVbBG21ENuXj6vpO9dI8C8NQl5WlA1Q06s/By+J+64uOrkcFWjWLJWAJX0eFfyKFBQTE/l8rilTTGqx6G29YH6BVAxEO4MiT5JlzM0rA52LUYyY002YmIwI+05xgF9gc8+j+y8aXIG2mavXnEHjoUPmIdi6JHQXQ4i/0DHYgJPgoGZGEOFT7iMNJemETfD3D5JYJtYguArA/Z3eAqePPONuag9SrVbSiUiOxuMZzu/PP0jkW3Zx+hia0MDrrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQv/EBtGkrG26ZLTGcQYohSuR08tkMgGJz4xpQVDPr4=;
 b=kCGGB/jRZ4A5aLYW55AMGX2jasrx8jfh8xlLIpUfykSTRFqzmIa5GL0ePJU4SOWmVHebOOxe4w6sgDEDS/dsPQv4RH1US0l9+eciuGO2lbxzavuLnivc0ZVm17DmNs33Ek6JuUGOJ25nk1r2yZ3ilGK7GkrU4s6UlGJoRPxDiLE=
Received: from BL6PEPF00013E07.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:8) by SA3PR12MB8811.namprd12.prod.outlook.com
 (2603:10b6:806:312::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Thu, 24 Apr
 2025 11:39:59 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2a01:111:f403:f901::3) by BL6PEPF00013E07.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Thu,
 24 Apr 2025 11:39:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 11:39:58 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 06:39:55 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.co>
Subject: [PATCH v3 5/7] drm/amd/pm: Fill static metrics data
Date: Thu, 24 Apr 2025 19:39:28 +0800
Message-ID: <20250424113930.464303-5-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250424113930.464303-1-asad.kamal@amd.com>
References: <20250424113930.464303-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|SA3PR12MB8811:EE_
X-MS-Office365-Filtering-Correlation-Id: 13c56185-f2d5-49b8-52c8-08dd8324bde6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GEiXLm8XFa+rXY+yWeCec3LqFJoGYwomQSBttG08zANqDeOIlulT0HYuyuhf?=
 =?us-ascii?Q?yiTCubwvkYG2hyaATVeiDcDHt1Z260EW6TwH4+NvZ1yEgpdPW/8V0ibX64bB?=
 =?us-ascii?Q?FSNKSNh5tKGGQKm6ky+rtnjKuTkxvDFybs1ExCoPDLAyV/qRIqeI0dhEw25k?=
 =?us-ascii?Q?nOxezi8e7siLZMh0eMyMG4U6xhPV4jkq2TngYWPy6Yk2UDr38QlJteCKUSQ/?=
 =?us-ascii?Q?T3Qr9GYTil2e2a6vl/3KEuCAwVT2Cvro+L6j1PcQJ68yvoKt6H7aJZ12Yw7X?=
 =?us-ascii?Q?9/SZoSXH5kzVJyURZi9Cqkj8+qU77dHVJRsyd6l0j1UMzYWiEMiN4/RiFpWQ?=
 =?us-ascii?Q?XU20Bh9O2x4SqZHjlVvJaSKzvQ1iFSkY25g36/5B/qeTHmzOhHX3sByLzsxT?=
 =?us-ascii?Q?KbNGhbsr2/OzZcrUjtHO9uyvCYqtt/L00jS7URX2dEKa1FKjZkEl61Ou3WKV?=
 =?us-ascii?Q?FJLIHthSB5dwVfMfKqzVMPKGh31ka+SdDKog3q7uScFK5wS7qL0Sg6ZjEQyU?=
 =?us-ascii?Q?+tVvEPDpPMAJCFERHTvmANTmWUgiZeDp8Nb3hb3/cUjTfEhVdbKZFQVWqOWl?=
 =?us-ascii?Q?2I2qoWQ/qmbeIAe7jsAoCFJP+05gRoP3UYJWt9yVVBFy7G+pDNOAm2iiY8AH?=
 =?us-ascii?Q?dHbQQLDE6Qdrkhg+5DJ3sFl5prOh+CdjyNDAIsckUKsFuwqLdVqMQjQrQQ9O?=
 =?us-ascii?Q?kBhrr+zY7rPxmp7suUcy4v2iR+q+34PiH2ocPsmps4cW/yjGAmaszSxypJnF?=
 =?us-ascii?Q?wN9eq+g9YnJAhOFTpaAW8bbASlM+EqQmdX+rwDcMeUImun5V5MbmJPG/ey1q?=
 =?us-ascii?Q?aMKBR/fu/67oypqxvttguZyaXPW0IG3RHtj0R+57RIxkKOlohghLT06fMyll?=
 =?us-ascii?Q?9MQETtjB6xDC4maI43xDCzq4/BqxVvt84PcqUy9y4cVAODdlyPZhz0bKUCwK?=
 =?us-ascii?Q?xoXm6j8+SDjuDtaN33BBCSNsr2+hyRs6wAp6kOsVlY9EHhoCkftjfLNh0PRZ?=
 =?us-ascii?Q?J+j+L7Za+MLWa//fRmKbKW+2UnGzePqq2Tj0KHAcDdlHBs1wErVmGIEviUyC?=
 =?us-ascii?Q?Gh3Feai6TGbQGZNrg5+QPVIuu2d/sWpbGzjuOr72poYN5kCEdjRCzsyA54F/?=
 =?us-ascii?Q?4z6VHgDTE6ngDxpzjCvZuMkNSwfwN1i4NjeMlInw4vwGBJSA4Q+yrHJZwiIx?=
 =?us-ascii?Q?G6Ov/OsIB/P4CY7OHMRitx04aft0rygiZJZiD3hh833bQmKdUlQZUCVDLLTS?=
 =?us-ascii?Q?eoptsT87WXbmHX6sjuAs/7mCUlFZw/6Kf+kAumJ9bc9A53rrA31pCd8gmWgN?=
 =?us-ascii?Q?Y8zNGNspMaC4CtQAaz3JntrFsOvSwOG1cTdjaHV4DwYIZVitIwNz6kNOpnQ6?=
 =?us-ascii?Q?DX3eUq6hOpckq/pOcYz71H82dOmKAbBMF8PHtRMGNsvXf05eE+NS/9Nq4Ohj?=
 =?us-ascii?Q?GN1+D6xkhC5dO6pZeGSNqraZg+wYHmoGX3iPsEto2q9QVWi1YNhtf7+y64mH?=
 =?us-ascii?Q?XjqChSw+2KvpiAp+jWxqcyBJ2wjkQs0Xt7ON?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 11:39:58.4091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c56185-f2d5-49b8-52c8-08dd8324bde6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8811
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

Fill static metrics data for smu_v13_0_6

v2: Proceed with driver load just with warning even if board
voltage reads invalid value

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h      |  1 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 21589c4583e6..9678d2593f8f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -112,6 +112,7 @@ struct smu_13_0_dpm_context {
 	uint32_t                    workload_policy_mask;
 	uint32_t                    dcef_min_ds_clk;
 	uint64_t                    caps;
+	uint32_t                    board_volt;
 };
 
 enum smu_13_0_power_state {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index b4bea0881ac9..41a9829215b8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -739,6 +739,19 @@ static ssize_t smu_v13_0_6_get_pm_metrics(struct smu_context *smu,
 	return pm_metrics->common_header.structure_size;
 }
 
+static void smu_v13_0_6_fill_static_metrics_table(struct smu_context *smu,
+						  StaticMetricsTable_t *static_metrics)
+{
+	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+
+	if (!static_metrics->InputTelemetryVoltageInmV) {
+		dev_warn(smu->adev->dev, "Invalid board voltage %d\n",
+				static_metrics->InputTelemetryVoltageInmV);
+	}
+
+	dpm_context->board_volt = static_metrics->InputTelemetryVoltageInmV;
+}
+
 int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -762,6 +775,7 @@ int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu)
 static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
+	StaticMetricsTable_t *static_metrics = (StaticMetricsTable_t *)smu_table->metrics_table;
 	MetricsTableV0_t *metrics_v0 = (MetricsTableV0_t *)smu_table->metrics_table;
 	MetricsTableV1_t *metrics_v1 = (MetricsTableV1_t *)smu_table->metrics_table;
 	MetricsTableV2_t *metrics_v2 = (MetricsTableV2_t *)smu_table->metrics_table;
@@ -830,6 +844,7 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 			ret = smu_v13_0_6_get_static_metrics_table(smu);
 			if (ret)
 				return ret;
+			smu_v13_0_6_fill_static_metrics_table(smu, static_metrics);
 		}
 	}
 
-- 
2.46.0

