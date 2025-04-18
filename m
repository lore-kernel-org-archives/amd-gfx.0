Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A58C369AB
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Apr 2025 14:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7348710E039;
	Fri, 18 Apr 2025 14:07:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="235WFoxZ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D51D10E115
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Apr 2025 14:07:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mr+g7JNEXyoKsV8WBpje0/CNR/tADTApxe3CumY/eB9Yd4TP3dYegHc0xTc8erWiqxoHkS5FM6zvGE0gdI9SNMzA23EzVVXuLKqzBpEO4HjDJmIHtP35IpbfaZbgHQA90FHp0eUMzrURYTF+gjjz07JpF4o31thzc3T1LIQwDLQE+edA+nvG9uz0EkVbT+0b1rJA6xhU39VaYkDBwyI61mZcelontmR4lrCHbhTJKgSPazypM+NcGRmSQnx2A9nb6UZQGG9gvK48/ItItL4RC+k5ElksQJUtIL+pvpRyvFhrX9K00snTDFSD0Myp2RvVt9xa1MG2Y1Jdpmzj5/2seQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/naO1q4gqULKipc74Iyp8jz2CmKabEhihcnuLrwt6A=;
 b=l5DYR2gDN+cwlZ9EQWerEvSQ9J7eA+67P9lEI0nyDDmgGFhKsSTp8sUNTL9UTygHjpX0SmWWEwth9xC0GgBU3G5qQJ6iBOSH+82f+0QSQtR2/CyA3FihqS49JZ9RXhqaZojrC7i8A7WRutNGNhZLqFd1oJCTWYWAZRpXA7blOqMyq2eCWNJCyz8/FrqX6dISv6CCBL1hkhMIlqwBCrtrdJJvpAprbLY+2UqWd2h8XgCWP1TNrF2abmLT+DfsroRh6I5NXt8lrYoSdqePYmrowa+VObPA1+Ivwvl3EuLuB6o85sNCSxg21ab7rytbnaNwQCjR7IxIbBhz0KFLeDbDpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/naO1q4gqULKipc74Iyp8jz2CmKabEhihcnuLrwt6A=;
 b=235WFoxZEmqGqo3XoVTrWKHUnVVw6c17nFhIjAp2bcXz84d84KU2KCVx55Tu6FmuFj+LavldyzeaVrKKEksNYGBUziR/Yg9GdTMXcQujOVXJFOsMAhnMZOume+eDsvK6FYcK19fb5d1JDt1iG+KvL3Vh3zqCI/9RgsQqNuXR0ag=
Received: from PH8P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::8)
 by DM4PR12MB5987.namprd12.prod.outlook.com (2603:10b6:8:6a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.26; Fri, 18 Apr
 2025 14:06:57 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::61) by PH8P221CA0019.outlook.office365.com
 (2603:10b6:510:2d8::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Fri,
 18 Apr 2025 14:06:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 18 Apr 2025 14:06:57 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Apr
 2025 09:06:54 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH v3 5/7] drm/amd/pm: Fill static metrics data
Date: Fri, 18 Apr 2025 22:06:31 +0800
Message-ID: <20250418140633.420887-5-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250418140633.420887-1-asad.kamal@amd.com>
References: <20250418140633.420887-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|DM4PR12MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a14cd9-d64e-4cf7-497c-08dd7e8247d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z3W2J6iuSayAkgk86vrrHe0foYUNi9rwxQOQHc/HvoTos4Ezquu5GDVWfnYp?=
 =?us-ascii?Q?pHopZt1bjOxhS/Qp03vlafEMddRKxwhqPS+ENcPaI2n7PUYq/eR6B3i/ywkp?=
 =?us-ascii?Q?M4m9pagWMnhHNsfNTydG9qzgJKA/+CPrcRV1AAG5E743xvk0+B0W2zmUUfEt?=
 =?us-ascii?Q?BrJiO7JD9Ef3O08NEWY5OJEedEaPYuwgtu3IhSzOW3hE0rkwwmqrQcNd6R4O?=
 =?us-ascii?Q?xdlfMD0GMMJ7LAGwzAXLL9tOrqYn6Yq1N4Ak05Vn1mpr4EJxh6RzwqLoEazw?=
 =?us-ascii?Q?V6FN7rjcjz3p8myrFDUL/8sBUatPd3GPYuhHUbrK6EOWSZHQxTshFazFl3qV?=
 =?us-ascii?Q?j8oXEZeF46zrC0ZWdztVRgCQ+32LJ13Hf3xGKOidWA2aLK5UVETUgQZNiUer?=
 =?us-ascii?Q?LHzZQleut89znyH0yYDcgVkqzHCXtNRMdB/8XEVZDJFeNVn6VW098VslS64r?=
 =?us-ascii?Q?+a1tp+0uEx0kDIt2utq7WH+HVeUwReKzmsFv7epfpUEFdq0TS/nV+7CxyNYx?=
 =?us-ascii?Q?xSHF1rzC/QaG3+/+XohdDlNcS+KZkdZN82t4/Upv6HElAQN9zpbu9UYcEPcV?=
 =?us-ascii?Q?10mnw/tmc0hnzTuWgcDl5xO0PqstWtIr+CAFjjh3xcCgYXLKAl2KDSGII/o1?=
 =?us-ascii?Q?3u+rWm+QLBjmq13JMpnaad4BHgJggxRD3rVsAOOZYQr9T9IiS//t1aENegL0?=
 =?us-ascii?Q?W0Ln7ZzevmKmwX27Uyq4n23rqxECnR9Kc3VKu2Wv7ko9ep225QXVcY8rKhd8?=
 =?us-ascii?Q?y83GFBo3U+ElgynqXthrCEE2zdjAWNi0+kXJll5tD3Lzncu275jOC5lpTdIV?=
 =?us-ascii?Q?bI/s8EvnDsCqxz+0jucPKCuj223C/CB1tsXkh33074x1HTPg48E9Kqf4m0M2?=
 =?us-ascii?Q?8efvQRggko8Jp5RDHx2VOZMYc+3NThrzE3yuXAAD9ZyqLB3rpw5mz2m/j8Fs?=
 =?us-ascii?Q?nklltCEC6WP7m5yWB1FHDDvCLJrWD77PigRGpt9qNJCaOmLwLS1pS4dI0J27?=
 =?us-ascii?Q?C4qgzHKLB3Bnc14DbYLu0ExYsuczXc2JCqJqebvNfy8pppLYn9CybXpby1yy?=
 =?us-ascii?Q?LrVUY8/nhB6S9Zj2YiQCQsWIxUjdQ0WpbDmWLtB6zjs9aWaVGeYYJNkbbono?=
 =?us-ascii?Q?V0AGLBvvvlb1EzEcVhWTN/1EtN3wCgtWBQUnn10/xt8yu11Bk/OZ2+iJtLUl?=
 =?us-ascii?Q?X9rjpZ7gLZhmk0iwXAx+dEhLW/PDKDdmz8iUveMiXDQXLbUZHXhkRdxCybw1?=
 =?us-ascii?Q?XuxOGqDnKVGzaGmaKhVZXoVSgMftUwASSdrqFnH+9kSloJM9JIe21ITDSIAA?=
 =?us-ascii?Q?7UbrkoCvz5PoC+8mPtcFavb7uMXJZf6suMyms7ejZWL/jvGnRRRDhAKtM9mv?=
 =?us-ascii?Q?De4w7Tz01qCItEy6UWfZemQpYJUq0OGOQh29CsLu6uOlXM8sHswrpg+6Rvfy?=
 =?us-ascii?Q?YhDNsVJyXkrLxwfF3wrGppLeJ59JOTUvhkQSPXPy4wkzT1m5WkokI4j73IAP?=
 =?us-ascii?Q?pHp3uw5RdnQB7Ei3aWPxcX8yMbnHZUouWgoP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 14:06:57.0818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a14cd9-d64e-4cf7-497c-08dd7e8247d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5987
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

v3: Use multiplier to convert volt to millivolt as new fw reports
voltage in volt

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h      |  1 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index cd03caffe317..ce3d042de5db 100644
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
index 8d1bef169812..469cf0800a5a 100644
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
+	if (!static_metrics->InputTelemetryVoltageInV) {
+		dev_warn(smu->adev->dev, "Invalid board voltage %d\n",
+				static_metrics->InputTelemetryVoltageInV);
+	}
+
+	dpm_context->board_volt = static_metrics->InputTelemetryVoltageInV * 1000;
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

