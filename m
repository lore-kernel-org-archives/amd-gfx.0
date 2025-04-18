Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3A6C369D0
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Apr 2025 14:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64F6B10E142;
	Fri, 18 Apr 2025 14:07:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oKLXPy71";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC1F610E05B
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Apr 2025 14:06:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f216drPnqNyOMjwR5pPy1yZHSUq04eaadCWWlLfwdZ2cj+jINjoWIWewMRlyRuL2lQPx69vonoWtEwDNv5Y72Mek63mlf0lauuU4ZfCiFAVgbsX+JmCbNaExBDMHaIFay9F0uZJGVeNRxJAmhi0VtX5PATaICM4QIvctyE5MR0+D2Xf6w+RVsIX4lh5hcE1Y20ZEgIMH8T2Tf1wZd448P2FrVXDq6zyrBd+OPeiDYg6dyDCDD2w5LzQSQkXAdg8CprNINHKobPGXsP16NrdKDm0buUffNXShhHH9mEjDUtd6EU3s2ke+tiisjnKBeGjTB+ftt+wxJqW9XGS5f7AYAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hMFLubt4lYHAKz6xUAIh0k2HqiA+Wvu50zzrwzPNiw=;
 b=xxCMzChMQAbN7mzwGcpM/wrmR928XymA8bGjdshMcZz34EfsYxBB290r28/us4Qtarx3n2LMBgyhmY7qFPhmVOY+pwX4f1cM3wz0D3vf49kT4CjAfxuYWbvQs1cJMKvK/QUndu9WWAi7ryvQhr/tDj3w30t3pb6mseNpcFdqRDQ59noTgsLaCp2SYWkXwlApgH/9GdWir1hZ40UN/eLJavewM3LDXUNQQcR0jitFqWIhj+JZSbIR5cA/ychE9q1vkIhmSiek9coVVUw0RwPH8Zv25M7eJg+r7l9BmYnLVtpswoJFm0oqI29k7iA8i6ybbGwFf4KGN5dRR5CgVpE3/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hMFLubt4lYHAKz6xUAIh0k2HqiA+Wvu50zzrwzPNiw=;
 b=oKLXPy71KHm6U5ld0jgFYZwMzKlDnKcGOsWPSxuMEz4u5biN7gFphLmALXgIXacfDZqCpdcFw0Mopjt0UtK8tkfMu3Iu8eAnA+n3smFZrruELW3wJkazrA6IIG0fE7hJm0YdIGftVVg1cTRblbelqe0mfdtDOubfTr4ZCCxPpEQ=
Received: from BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40)
 by SJ0PR12MB5674.namprd12.prod.outlook.com (2603:10b6:a03:42c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 14:06:53 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::ae) by BYAPR11CA0099.outlook.office365.com
 (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Fri,
 18 Apr 2025 14:06:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 18 Apr 2025 14:06:53 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Apr
 2025 09:06:50 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH v3 3/7] drm/amd/pn: Fetch static metrics table
Date: Fri, 18 Apr 2025 22:06:29 +0800
Message-ID: <20250418140633.420887-3-asad.kamal@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|SJ0PR12MB5674:EE_
X-MS-Office365-Filtering-Correlation-Id: c28785f3-ef4c-41d1-fc59-08dd7e8245aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sqm8HRqgRMmYYCkk3ln+zkQ4UmHy5+fNKpEEnk7qCf9B6mjyVsOzDzV8xT1S?=
 =?us-ascii?Q?2sXH3KUPLXw0bSuiDw1+8iA6o7ylEmWwxd29xSvxyXKtq+9mYrehY3FiM/NP?=
 =?us-ascii?Q?Ksn5YyHO/JCkM1DAnycvvikXqE+d5lGfqrDoHv+4Tohr/gkCFSwpS7o3z6EH?=
 =?us-ascii?Q?05Kuffmt3OF7t+l1qc7Hy3OfNOjloJAUShiTeXowLy+tqjpacEd1GsI0//IR?=
 =?us-ascii?Q?JZnaQv05WyiLDxQrRfB2A5lrGixL9oyPrAtfQ7UR0vMH4++3OVdpT+kCaWb5?=
 =?us-ascii?Q?rirVppjQfatRegATyG1UgBtarSQq3YYGlyGfFWDZMzAIcDk+FKQJxPFdkwzK?=
 =?us-ascii?Q?LMAmyirmHmNVq4tzf2o/ncVvBkbeMspYT3Cwn5mQ4d8DTE7GyE87o6v9hgaI?=
 =?us-ascii?Q?2SahSeMmM6PydQPAnTEVQzbNqB8D8+EyubA65fKKbIjlEuM5q+Awel4Y3sGo?=
 =?us-ascii?Q?+dT/6pxES4fr5I+M3zzYoh+rjDy2tmcSiJD2/UyN9I3sAQtXkVL0YE6NDCKl?=
 =?us-ascii?Q?M84VXgzCafv8EzDdMyA1MRL8uR3InzFgZ2Q1k+knf5IReZIgVhyYbqMsgjkQ?=
 =?us-ascii?Q?U5gQQlW1bzSzI9AWdNSXMjusvkWctJbK91QSCVZygQMn+b1cCM/Lx4E2V9lP?=
 =?us-ascii?Q?aPkI9Sy4V7Km9zni36OVOV2RrnAlQCIvou/Rnzwk9IWKwTLdS9n1eNeXGEKx?=
 =?us-ascii?Q?d2rDH4pP87El4d2pVh4t2fJe4tSj9Y3w+j6liO2jZclXvQxh18YJf83EenMO?=
 =?us-ascii?Q?Re8xkOMSXkyflXhtYwLhSSoP8zhlzESSX1JjQHLIUPdBzIhQE4qK1PR5cKSn?=
 =?us-ascii?Q?3yzqDJqgnLJh8qsJGeEyUXOREzUQ2a1/dtQBneEdhP8LlZyMTrgaq63Z8LIU?=
 =?us-ascii?Q?Zi/cBnoC5FG9p73+rD0q2rluHdzFoakCZPUAF26TOjuvwgLCLJe8V6gPx+dN?=
 =?us-ascii?Q?RkEHlgKeo9HtxuXFofG5+2LPWxvtqgzD1VyMaSYJiizxKuSPUvzTSGFAmMYl?=
 =?us-ascii?Q?v5bbVnCOvIGUQanqAQ6ix4fjlkxKDNGdpj6crilwn1OTKDOh8hFsch9/V/3H?=
 =?us-ascii?Q?kmx/go+G7F1YfRyZLI/feAL/0Hvvw2lBLmJW+OSbzhogsnThEy/cYyjyZ8xL?=
 =?us-ascii?Q?Vn67ID4NPquhWdPcxTRlEvxRjcR1jbehjsIUdsfHGIM9ynb0VVBhbZ5fm+k9?=
 =?us-ascii?Q?cZLcsMAbLFMNkHp2Wkw3ini4AHK2/SF5CvCk5NryObV+8lewSib15IkrSxlS?=
 =?us-ascii?Q?FDR17wM3Xf+J07JvfAs9ChJvucvl6Jhsdpaza29HPsqOgZVC5tYRVC4JRdPi?=
 =?us-ascii?Q?H78QuPod0dlMob+GorD64wuY5U4aFfToe2vIzW2BR9wM94PkRNTCIj1X2M2N?=
 =?us-ascii?Q?c4Ff2YVVoKo7dYV6Ql85EjINC7tyr7YYE0xHiOdisgJ4FHJxPTAg+nfaYa5H?=
 =?us-ascii?Q?iiyI33Zko73IYUCwz9PTfBdEiW1dWDz4/eo+IlfeJFEfb0dDvJH1677tAmVp?=
 =?us-ascii?Q?CFB4u54vzD9H+EzzFmSP0CG24MzRUpMfoWj/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 14:06:53.4754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c28785f3-ef4c-41d1-fc59-08dd7e8245aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5674
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

v3: Update version having all fixes for static metrics support

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 177c55f457f4..06bfe2488d4e 100644
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
+		if (fw_ver >= 0x00557F00)
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

