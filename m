Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7847FC369CA
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Apr 2025 14:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6928210E211;
	Fri, 18 Apr 2025 14:07:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WMaLEOGO";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80B5E10E211
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Apr 2025 14:06:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMOrylUN15/VV1s8VNhXPDbsWbKtZK/HSow13korN4MPhv87jnjY3OFUYEOFLcwtrd2E4SZZcxIYqD8VM5ZRMcSKznYFJ4ZmjHKOp0xALub+OcKSKn9TBHLmjjKppBRyJFZqwuMFZYNxjIUoStzVtu6HVBTWuUzoIMKXFpGLX4IkDtZEtbdWc6gM84NHFkredYovRaiffV88Bxp9m1l85ZKGpOS9yRJpzQYZpW5ldu5akdXd/nYVoCVOcJlj/3EfUQGSnrppMcY5bSkmadpsC5w3ziXxqpIQVni2K9Q3zkfVgGTyNvYkU5E9ntZl4HwTUmI+t5fZoYYu0U1ZedxGtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObdRtynHvGabNzBOQd2vfo1ScrlenwIGX+5qpSJh5oI=;
 b=k6eIENFdhLz6LmSBPnvo82MYxHPHXpvN5hhpo97EGLssWBiwwD9BfXqR4l7J6zSjQRtmTGzXrszjp0RNUGxl93Hm/x01lzeBlJMxNbhbuoGYOokoaZBvBwjCFo0/iSYA3SM5NFs53BhUlAB+HiP7dD3ulTK/g3Z62oJ/HAKQVEBreWn1KQczqhRgDA7uw8m82Lr9BNGilrAEMEzPOs5KOvT+RsXBGFS9HecSkCEQh3U6iz3opju2lkm21AJdb+wQKqZsCYIb3w6YkIwz9A2rM40kOdAIYp5E9LkK1B3PePNKydX/tP7/ejK85cFtBoeHHVFo/qhAzee25EPiyDmZjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObdRtynHvGabNzBOQd2vfo1ScrlenwIGX+5qpSJh5oI=;
 b=WMaLEOGO6736qcKdbKlz1lV+iLnlb5Ddy2zRp1o1GFqVpQJs4441IaJho52zt4P+dccRPgg5sjmNkRDZ177UsyRtJwDGg5WsJDavnTiGoGAz6PjJiWJ4PB9dWgMP1qkL7rHvjwf5DJ7bPHAgXCs0pfyQGcssjcIdUxvqcL5ec48=
Received: from BY5PR17CA0004.namprd17.prod.outlook.com (2603:10b6:a03:1b8::17)
 by BL4PR12MB9480.namprd12.prod.outlook.com (2603:10b6:208:58d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 14:06:49 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::2d) by BY5PR17CA0004.outlook.office365.com
 (2603:10b6:a03:1b8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Fri,
 18 Apr 2025 14:06:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 18 Apr 2025 14:06:48 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Apr
 2025 09:06:45 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH v3 1/7] drm/amd/pm: Add ip version check for smu_v13_0_12
 functions
Date: Fri, 18 Apr 2025 22:06:27 +0800
Message-ID: <20250418140633.420887-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|BL4PR12MB9480:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e393df8-cf56-4ca5-dead-08dd7e824293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KfATCz6tZgBWqwP6t7FgHR+sUnQcDOgKsI16RmkikSXcesenmdV2ai2RUuYg?=
 =?us-ascii?Q?OSgnr6oB4+DTRLJIOHPN075TZNdoUDJM+TVC4o+3+3G+YGMVFuW3D8gEv7vv?=
 =?us-ascii?Q?fgY37pO8nOJ4zfpP9s59bIu3hpfLFEFdQNX7QtxbT+4g8JSHhEfRHYzOK45h?=
 =?us-ascii?Q?pq5Sxh3/zp3WzLqGOD1l8LZ4YKH0yhD1LOGVeEB/K514xyqUenzIjmnzyQgh?=
 =?us-ascii?Q?3dqe6GIarSLryImNQ7HauKIC/25Mvl6wA7uW4QfKbra1Tq+FXUsLiUQjpS7V?=
 =?us-ascii?Q?+twXOASM8/n8JEMRms4BEdT1BlV1WqDm1L5SThNiHFNhoby7PpskANpQWsz7?=
 =?us-ascii?Q?LpfifEYtB3pUrZ2GnK4ktzMkTb4RqnbOX7godRgHkShOneur/+feW8SeSGc3?=
 =?us-ascii?Q?B5/V6TawbGYxpRDwkt6NLBkJZiIeiuhRncF1Sh36RaeGiKsT1sle+uoCweHI?=
 =?us-ascii?Q?YBtF1pUK6c13Mo1sA2XeAbwwdI9MiSEaNWHIwC0PnLyxBk1M1TdoSYU6ko6G?=
 =?us-ascii?Q?W+OKituXFIY3BJuD5i2vqVNxKw03joYqyUe0KCFKDQJlgMebYIXQodl7yoPe?=
 =?us-ascii?Q?NSqjH1I1uGeNx85MR6x2n4DVJGVjyQCsq6m8mSZr1eI19cbJg9FyIuH/Guj0?=
 =?us-ascii?Q?hGLfsrPbqIDOrgYE0AjA97+e0qYGLaGuLCUILWdnxg6XAaS11yPNRg6gmBLH?=
 =?us-ascii?Q?lsvsbaUYxHMnhXfAtU3xe//2KOeqFeyGXmfQp4N2QxyBCwHPPZ33/waVIobM?=
 =?us-ascii?Q?SkxmD12EWuypAnSykIxHbyi1rwGP2x5KHmt6YeITXuJrL8Zp93HxMrztUdfs?=
 =?us-ascii?Q?qGNXLG40PFgCGVzzwiLv6WakmVKBiwz7fQX76Kt/AOywYQEqayEZi0lkpP4x?=
 =?us-ascii?Q?fslAmIH9nE2Z5lDbm76jcV8v8NZdYRoiyp1YAlO554VfhQQLTmFf0YjLKCJY?=
 =?us-ascii?Q?OuxfA7xyuI4+Lcgj34g4u0phvAb+EmwMhh6GgBMzw4frd2zacykOXP1QAD96?=
 =?us-ascii?Q?kH0+ym2ps306V5g02K8wj+iMZxeTirFlRv9iuACACOAGRYram4E38hX+zkoq?=
 =?us-ascii?Q?xy7s1FabAnp0nswTiMntUa8P1exsn5dRK9V5prVg2jV4GHMLGmpFK0zjgyI6?=
 =?us-ascii?Q?jhGAHoiaSSuNkelj11hXB3AAGsvCHfkfHOXm9/HWp9EXCm0iHKOP2ZWeNRvT?=
 =?us-ascii?Q?NBtTGzysBjSni1e84s4dGgd99fOKSTsYb1Yd0lnDrDB9jjAZzk4yb4qc623V?=
 =?us-ascii?Q?ziCmm5lfIOMwRWa22JCwqKTCreIdPVXp0kgQI20rYnuUGWAvz3nGCAfyASSV?=
 =?us-ascii?Q?n+EEmo6r+qHpAeGF6OlopqMZBGXC8GGuUMzCrju/dkbkmz7PWcfXEBIg1MtH?=
 =?us-ascii?Q?jkDYdPVgSZnSQn5MKi/S1PLbyOVttTMB1pPQ1leL2pYY2zpm5w9I6lQ/nyQ7?=
 =?us-ascii?Q?W9wl16i2ciglWX0st0MclZY87wGfkQgsP40u0wz2Cu6EKKb0DUmGiC8cxbH2?=
 =?us-ascii?Q?raLBbWXrPn2HBLqH1u1tUa5Gc2RnBF5uRKig?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 14:06:48.3063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e393df8-cf56-4ca5-dead-08dd7e824293
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9480
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

Add ip version check to use smu_v13_0_12 specific functions

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 6d84257b5301..177c55f457f4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -748,7 +748,8 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 	int ret, i, retry = 100;
 	uint32_t table_version;
 
-	if (smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12) &&
+	    smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
 		return smu_v13_0_12_setup_driver_pptable(smu);
 
 	/* Store one-time values in driver PPTable */
@@ -1131,7 +1132,8 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	if (smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12) &&
+	    smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
 		return smu_v13_0_12_get_smu_metrics_data(smu, member, value);
 
 	/* For clocks with multiple instances, only report the first one */
@@ -2496,7 +2498,8 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 		return ret;
 	}
 
-	if (smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12) &&
+	    smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
 		return smu_v13_0_12_get_gpu_metrics(smu, table);
 
 	metrics_v1 = (MetricsTableV1_t *)metrics_v0;
-- 
2.46.0

