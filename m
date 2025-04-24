Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5374C369D1
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Apr 2025 11:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0DF910E33D;
	Thu, 24 Apr 2025 11:39:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uAvatWNt";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72E5F10E309
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Apr 2025 11:39:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y17JnJ3da+uvY7UpDXdSNNcHp9NEBsUsy1uws5RQzUZBh0wvfM8BD5UEU7S2kKZ1mFQuej2qhJnHw9YFa90zIAJbiJbdGKGVA6c5mVIX9MNUTanuRXcbIryooOgT3vJozPvu8yyYHHVavvr0xkghvw8lNcjDXPhRw8yLRmq2l8TCdxrHKoItuxdvTJGmUFEyPoL0/Bt9lnEUvq1dRFzSaeo2TAly9v1Bxa4T1+94JgsmKq762hF/CrhyjzOBNOhgWAoSeM5jjhidUbGn2/1EYJcZq/6hZxsouZR7yy6qWxyLXbtaTCQpWAtJRcknmeUITzKrJ3TE090RwhoEvujfnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCWoerH78I3FEZ5j36DXaWXoRh1wVl6rAm0rRT7dkOw=;
 b=Jc9ikpKcziScC5F2tQrs6h0okqm2Tcy7HJYL1ohemY+ll2ba9BXpAgnB9N/l58S2yrgoO8EZnbCt7XAS69B5hAN2XyXinMxW1zUbMFXwQUc+R08NHAtkMLHgIDmrRRArrUC68mJVyxl9hiskMDr2dr/kqjEVcvDZJZc0+i9QvvtEp1RnihU0nt7N+aUjAjBLXnk+IwiDZ86Z+BVdQVlHc7Sikbp8cmkvYGOSnk/ZuALXnrYvoqjA0IqAi6MO8kfBKq0lK+hAR84wnc2gBh4x+u3yD7jMbWvCPC8aZIUcTIanv6ZwGSDrdQUZGLCeT67XVCe4eiYG5jDmKlmWm6v9YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCWoerH78I3FEZ5j36DXaWXoRh1wVl6rAm0rRT7dkOw=;
 b=uAvatWNtVz6zGCDSJhvQC+oLzgGgc5I9LYwg/6FCojT0NjDLK/JmIKIdLOcudZAJYVyGOB4slopm1zo4S8vm3s+YE/6BJdrb08Z1B8E8oObNOoepCBaqWWtDKfZT3K6ddykhenovgRgLrZqEPMH+oiyH54zcCtvcF6aYYFY/9dU=
Received: from MN2PR15CA0044.namprd15.prod.outlook.com (2603:10b6:208:237::13)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 11:39:48 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::ff) by MN2PR15CA0044.outlook.office365.com
 (2603:10b6:208:237::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Thu,
 24 Apr 2025 11:39:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 11:39:47 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 06:39:43 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.co>
Subject: [PATCH v3 1/7] drm/amd/pm: Add ip version check for smu_v13_0_12
 functions
Date: Thu, 24 Apr 2025 19:39:24 +0800
Message-ID: <20250424113930.464303-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: bca65b85-f53c-426f-aa35-08dd8324b785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c75hO0znbXqC6JobYO1m83KtALVhFuJWFQ1VgboASG1d3svAIKGBSHWKCvVz?=
 =?us-ascii?Q?b+K38H2Q87gWwM36RBUIhyhPJ4sk7LUw9oyAwav/IEPlwnv360NREvDrwyzr?=
 =?us-ascii?Q?JPft84GuUckV1xTXR8E8eVEQ8OFIajMJYM8dYxHU3NHCI8cDbwcUmRC60H6N?=
 =?us-ascii?Q?SnT0UdBtf0Ikji9zhMuQGFLmVeoQmgvCortApbwe6I3D2E11Q/H3uzwfZ0a3?=
 =?us-ascii?Q?taIMusiZLV8bId/6PPL1C6m/Y0lr7UpTSFyq4A4Ir9AswHR2Kuk1Js7IPgvO?=
 =?us-ascii?Q?5O1FaGRe5fbGjY6FwIr3wOL/C/q9mLqQL3SGCAdLKSyYzOLTfr1F36j/jDxH?=
 =?us-ascii?Q?2+E5eEdjYl5SSit0BHm7aE+yPnuYQv5neACNWpur+Z1RCg9oL4iZretOW9Hy?=
 =?us-ascii?Q?0AoDD2vvMR7NjjAmI2t/r3nETGBMW2DMWRwcVWzvBQJgxJmfkhDLDNZka0YF?=
 =?us-ascii?Q?0LgN0xaMMxozyOUN9iETqcNRyR1aT6ZZSfindDnkLCNGJNsuecf7Z3J5d7NC?=
 =?us-ascii?Q?29BTF91AfUYLu9hSKDXQC66yrIvOlAHGEDM4qWASgS5EGUm8uPfE2WdiPmss?=
 =?us-ascii?Q?ITL/pQ+6/84werP84H7vF9HnNKkutihDf6EbIfJzjl7eoS4lRuGKF04FpWqy?=
 =?us-ascii?Q?lk6XlY7ltULg/C81FA5+SMvU5nrMTO1FdqqeVoDXaqiHqWvyfKzypN1yh81O?=
 =?us-ascii?Q?9b/HsipS8RS+KMYG6+1FWK+BMai1K4oIrdoW0DOSSaWj7ZNAsIg87XTSbdfR?=
 =?us-ascii?Q?zjz+RA31VD2zTP89Vpw1NED9Tu7uJobrQJ3SxOMOLowRulBTp3IMSrCjqRxW?=
 =?us-ascii?Q?qQuOhBU8Go7ZkhsNZdEM/pXdMXDvmQbuH0Rbn/jgftvE+EWXh7d/iEChfMTx?=
 =?us-ascii?Q?tVFc1+coVFCQoDj00x4FEhugte55hJYx1SqhayIAEYHR3OgyeqM9qKiB31No?=
 =?us-ascii?Q?iB7/IcYirLL8S/TJ6tThk+fox5XqD8Hg2r7pHZ1bb3OFhzPf+kkjI+lvosbQ?=
 =?us-ascii?Q?oWBpX42KgN36jSov/yo114moGags5LTWovDZZyWFsiyw51P37kkrTIpi+jkY?=
 =?us-ascii?Q?4t8eb1Duw06hzGPRlA5To0uklptFDMmmvql2/lW35gFf4a7YOtUo2xopr4yR?=
 =?us-ascii?Q?RuuchF3CO0M1xZf7/WiHcjTIEl8Ch+kYShC77v5MxIZXPbgVk7n9N789BDQz?=
 =?us-ascii?Q?OAaLusoi8BO1f5yajRPUr6bts/zDL0xxPFcTsYPfxgSMs+mE5ri6f0MAFiDl?=
 =?us-ascii?Q?LRKQPzgNnzL8Lde+0TwnLdiQ84ORlqWnfnJj3ZJNYhCRlNLWIISQk1T7V90/?=
 =?us-ascii?Q?nP3oi9W2WQvFtcX1J9sn+OYU56+iL6wW+bK7CIWM61/ZbnsmP4PjjeLRMIYp?=
 =?us-ascii?Q?gNh0F5LM5KBd1MT3tG8obx0iW4QqDb3fZqwOBxwQrrpFYBTugYcqhMxr2WbY?=
 =?us-ascii?Q?a0uwBNylWGQDX3MRirSt81NZ9cfuT84Blmq/7aNwxp0SwkLifI8i601jZY7A?=
 =?us-ascii?Q?7rmjYAcpYwpq3aInNMucOD8gATSAOTx9sGSB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 11:39:47.7095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bca65b85-f53c-426f-aa35-08dd8324b785
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237
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
index 8d845b5912c5..96fb6c111ea5 100644
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

