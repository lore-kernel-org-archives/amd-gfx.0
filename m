Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ACAEC369B5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 14:36:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A045410E7B4;
	Tue, 15 Apr 2025 14:36:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BSZN/OoF";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03E3E10E7B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 14:35:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMaCIpFZD7pHhzLR67/aYSYymoZDJ3vCoWRf3tRpFUD3GQsim91FA803mXRihTVyGXbJELXLyNwOPmwOs/cpYlGZh9ergOgIvwrJpRTihVD8IKMX87v84EsfMnKtD4Jc+8OKr7gpVYoX4zhuxaB7zUqB+V6131x/KWRNHZT9CHnlTcr9J6IMQTp5g1VMF5j7bU//OZNnfjOH4te1X5/xh1YJ/n/esBtvfLGH78lUE+rqD1dzmbqpeAx7AoJ3LkkZ2RIBCXIE6qy5aQtYcYRHBpel6E8AAELTL3xRzWXYuZQnRZdshKFmbraIceqEv2eMZbwQt74Cffs944IrFBhqeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Z0HG/Fyfu9cz4RtGp0f75JL9bfoc7E2rzUutkhfGoU=;
 b=Slh34MbPfBL+1H3izsI7ocqmIqdlZ86iBLIkFTEZP1mlFXUvkOPy6Y0kW/1zcGVWZ8DiHZ6+gg7cSr6sF4uVEhj7sOwSb0sy0zyhUQP/3ER0KuDJUGt5CQ7+u2QqKrDiZSLq6uZ2gUUDRIj8jfnW6m/x/LbJWANv2a4KBIWOBmyGFB8AzxpvKc2ZNc2wIWIyp/+6CN1FxK1JH+aiYlw4lIry8hqt3GshJRg6wtH49um1l1N/TzuXc3iFhKu5s0aaOw1JlHOu+pRJ9lnClT2Z8O+VAjjs0C1YR25oUmZWTCy125r3JAAQZ1aH0of5bBmncOm6Jz0nv1B+h88Awu3itQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Z0HG/Fyfu9cz4RtGp0f75JL9bfoc7E2rzUutkhfGoU=;
 b=BSZN/OoF7pBmDgoVwrsQqcZ5JHl/KLqIIpKV0BUAjkWfnvT0DmN9ZD2S5W5VOSQUQ5zuu1y8RH5Xa1IeAr7kl0UCGh3LyCKeRRpqBFvqkdQvvYcoG1hlP7Vd2AqJzfidA/pYYo2U/QqkBVP/u9dLB6RR1f2XJh8+OTQ3VqSIVzQ=
Received: from SJ0PR13CA0016.namprd13.prod.outlook.com (2603:10b6:a03:2c0::21)
 by DS5PPFFF21E27DC.namprd12.prod.outlook.com (2603:10b6:f:fc00::66b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 14:35:52 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::71) by SJ0PR13CA0016.outlook.office365.com
 (2603:10b6:a03:2c0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Tue,
 15 Apr 2025 14:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:35:51 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:35:49 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 5/7] drm/amd/pm: Fill static metrics data
Date: Tue, 15 Apr 2025 22:35:19 +0800
Message-ID: <20250415143521.367895-5-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250415143521.367895-1-asad.kamal@amd.com>
References: <20250415143521.367895-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|DS5PPFFF21E27DC:EE_
X-MS-Office365-Filtering-Correlation-Id: 307861d1-97ef-4ab4-1d53-08dd7c2ad2a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XTMVDEg+VTT10pCE3Q06CdvgNAMV8gUnGpZv0o2cA4TTbRi5Ixi+PbQx38TM?=
 =?us-ascii?Q?3xqVl4SNeihwfV6sAWkBPcLSprm33i8KqQDeOhYIGW79EHEDMhNrU4olDqiM?=
 =?us-ascii?Q?ZCjdc39eJIujqA8ckQmCvhcSAMnCFK6c2l02rLYV6GisV/ZO6ko+dnMlJo21?=
 =?us-ascii?Q?4nP1+IqSt4WjL/zfKRimXgnSymkDeR+b4TeU3L1mmjTOdVGWiJyP53GitpPI?=
 =?us-ascii?Q?j6CQAjqhq4b2ygL15FqJDH3Z3+jxmU7CYclp7zomR/jRFD4hGS/AY5pviMkH?=
 =?us-ascii?Q?O/uAoflyi/b7Dz4sfMkDnxQOjrRWDrELTlalid3x3yQJOb7BI6k0exo3fvO2?=
 =?us-ascii?Q?UN7l4DuBjxz/kPd5Xx0LMaZXZdzgY5fPMhk6pL3RibdF2ss5qYH9WGoJ3SXW?=
 =?us-ascii?Q?7lza+tbV639JxO6bm6eckIqAK6/4CZkt0BN3Y/JzqBrszFd2wyuENg7iEjqK?=
 =?us-ascii?Q?1aRHkimnKL1/yGkHHs/7dObhWTKHOiGScXn6/vGLo31x65/xWINloqQun2Mp?=
 =?us-ascii?Q?LkakOZBfPxH7xuhHgjzi6re6CJFCKInLHsVhnnDLhu2N8LQlJKzzKLN4H1sd?=
 =?us-ascii?Q?182SUSXC+70kpQU5CskXfpWpDj4zp8r9+Cqn0hhJJaNoPzIOqy13tLipyiqS?=
 =?us-ascii?Q?4y8Of4m1MU6EIB9+Yv6NbsGLIpSh/xy/DPLy6YH9GoIF9Pb1zM9Jxjmd1zqc?=
 =?us-ascii?Q?8o6ALTbg/kT/T8Igq/kvqKJjE7nWDUlALpmEzL7zjeiyUg2/oQ4QGV+mL9nx?=
 =?us-ascii?Q?a9qPw2QHXGmBpRGQjT8tC0IfI3JfEVIY9VKA3ppUCrJtcMxbzBVQIlgszoHy?=
 =?us-ascii?Q?LDdxxvr1hwUEGqhXX+P/5edGQYizf1k+gVXkvPVfo+Ssl2EMhtCNSMb0W3XJ?=
 =?us-ascii?Q?Hmb2g40VYoE4fT9qOKu5im7a5GbPXyUvvb7Nfb0DjqvEDbd/IORs258SWrgJ?=
 =?us-ascii?Q?r3LrFvyaw/KstkbHzMjBVfNI8C9qRLoSLEn/ZylWKF5jcQNCK1etPXcOyu+5?=
 =?us-ascii?Q?GgzKr4XIVxqBr16yBJVebfr39PbnIvEmiOZ7oHvMOV/dlc6QcJocwxzFjRS1?=
 =?us-ascii?Q?nM3SIeT4cIDDoRiGQnOCFoShE0ZO+i7kUHmTibbW9SETrV5CvCr5DJ16fE9x?=
 =?us-ascii?Q?iLxdpU3yq8Z/mAqbBwdAQnicMt08m5qZ1PfMNh/DzWWfLJnQkacpOsNAYewI?=
 =?us-ascii?Q?osSRMva9qA7fSn0q0HWeDLg58+29TpGRLYZ8hqI9uH3tLZl5TXTw6gn+DHPF?=
 =?us-ascii?Q?shwXjDMAod8LWp/kWSRo1Vq6CcZIHNrecrc1RHux57J7c1o9z50nTogB2+bW?=
 =?us-ascii?Q?qm9mmmPHIXm8pCJ2LLIhbgSa9XK8h6n5glrAqo0GHVThIXKY1aY6Kyjm291O?=
 =?us-ascii?Q?AH1TPPdxi9TYTVcYmpp1vGLpug+840tRGFBobIAe6bGQoDVdlG6C48zrXT6v?=
 =?us-ascii?Q?kUHIyy50Nz/GeBoLAHGqw5ETUMw3X4PoWKjTMh5mdbOmF7u7HjwB2whY6ect?=
 =?us-ascii?Q?7aeB5W4t9Op3296nYgktEAzUqYK4xly556Rn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:35:51.9775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 307861d1-97ef-4ab4-1d53-08dd7c2ad2a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFFF21E27DC
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

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

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
index 3fef50df85e7..a6df07890f8c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -739,6 +739,21 @@ static ssize_t smu_v13_0_6_get_pm_metrics(struct smu_context *smu,
 	return pm_metrics->common_header.structure_size;
 }
 
+static int smu_v13_0_6_fill_static_metrics_table(struct smu_context *smu,
+						 StaticMetricsTable_t *static_metrics)
+{
+	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+
+	if (!static_metrics->InputTelemetryVoltageInmV) {
+		dev_warn(smu->adev->dev, "Invalid board voltage %d\n",
+				static_metrics->InputTelemetryVoltageInmV);
+		return -EINVAL;
+	}
+
+	dpm_context->board_volt = static_metrics->InputTelemetryVoltageInmV;
+	return 0;
+}
+
 int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -762,6 +777,7 @@ int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu)
 static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
+	StaticMetricsTable_t *static_metrics = (StaticMetricsTable_t *)smu_table->metrics_table;
 	MetricsTableV0_t *metrics_v0 = (MetricsTableV0_t *)smu_table->metrics_table;
 	MetricsTableV1_t *metrics_v1 = (MetricsTableV1_t *)smu_table->metrics_table;
 	MetricsTableV2_t *metrics_v2 = (MetricsTableV2_t *)smu_table->metrics_table;
@@ -830,6 +846,9 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 			ret = smu_v13_0_6_get_static_metrics_table(smu);
 			if (ret)
 				return ret;
+			ret = smu_v13_0_6_fill_static_metrics_table(smu, static_metrics);
+			if (ret)
+				return ret;
 		}
 	}
 
-- 
2.46.0

