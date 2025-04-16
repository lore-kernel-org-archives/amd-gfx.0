Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85A6C369B1
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 05:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38F7C10E1FD;
	Wed, 16 Apr 2025 05:31:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xZRooVyI";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DE0410E1FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 05:31:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1QUDcAaYdACQKdGQztwPuEwWh5kSvaDa7UweLzv0Zx6mREHRwHfkYX1+/HREBeYsZ7wquuSGeWMxJZYGnGZH6H/bADdIN9THmXLMnFHQd9FJpFl66UBHzvs4J/P0PxNzv7ndVtsBMKydbLZjo6FxFHSH+LJv6TfZUmrt+ZnMIRVk3VD8dLH5FhTLS9yyQHMe88Wlf0VD0ocrt4yQmRlbqEh6DIEtp7LvBDmW6/Wcj+wVD5MxfLvp6zMsDPSI4xsD86+FuP9RkmXgkLPwy5LW1XKIMJGisyPcyrCa3LcgHN41SdKoSMixNswELMrQIdVQhlUe8xRnN54rLqSYp1tUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObdRtynHvGabNzBOQd2vfo1ScrlenwIGX+5qpSJh5oI=;
 b=Ces5giMRa0+urKYvwoO7vK9DeqhTMMWRUhHGuiYL50EfrWW8vNttNZPdWfYWe7iaYgCuq03NN+S84V45XT4BgnV50M4jFQAHjdCLVjgEn3JtYmc/PBbghFJZ21y/GLDh1PEymivS0BsBU3qQYRIpkT9SlsGjxM3jy15zykJ95IPg/76wlaDBKvAte09ujozwlQpOZw1JKn48XsneGsIIIESnKMBDzYmkKLRh/3EuqL1ntByCb1Ea+S7g6NOHaaCk3HbSSbMipDc/HtviCQnwd3+EkmJK7IBClveaNu07lGOX05i+TUuaKz0NFvIB8kWx1PtANLjPghjRnSH+RNNRAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObdRtynHvGabNzBOQd2vfo1ScrlenwIGX+5qpSJh5oI=;
 b=xZRooVyI0gMy+1VLERA6pLJqPZUJOZzkaRG8HtgnqlZpgvWl92oaAuM/ysrIm7ld+FeL94QRfKwSkabimuQLmMcIn/rN0n5Wt6rF2jfKnL0/5pcTCNOp21OHp/XKzkPPXQ/s5sMm+0QfmeouNxbeFMbgRrjEVieYlH7pJKG6PHw=
Received: from SJ0PR13CA0007.namprd13.prod.outlook.com (2603:10b6:a03:2c0::12)
 by MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Wed, 16 Apr
 2025 05:31:45 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::58) by SJ0PR13CA0007.outlook.office365.com
 (2603:10b6:a03:2c0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Wed,
 16 Apr 2025 05:31:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 05:31:44 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Apr
 2025 00:31:41 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH v2 1/7] drm/amd/pm: Add ip version check for smu_v13_0_12
 functions
Date: Wed, 16 Apr 2025 13:31:21 +0800
Message-ID: <20250416053127.377955-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|MN2PR12MB4094:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c343d12-4712-4873-164f-08dd7ca7f97e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4dm1wOBHrUHw6/lxvTZSSadQ0zYx2riEnTxCBMxHvJW7d1s50+XRyhm5+75n?=
 =?us-ascii?Q?5yqfwcbjJSlzL0C0LJUwBPcDLmHzCAOyigZV4abqMgZEDMJz2FDeJgt8KvRC?=
 =?us-ascii?Q?bD+hd6lHWm4iyNQymbrFgg6SobAthWqYcPUfYbZIhV9NpH0KY2GgCgjb8jCY?=
 =?us-ascii?Q?AdWJ7DPtCk9PCAnDjTu96BSUD56N5Mwn2LrsIDl57rgJYC6q5QJmTTbpuWp8?=
 =?us-ascii?Q?wyPwPae+yIQr5fJ8xyttITlEFEayo4/SBkT7kRwKcTG/0aM6QvL9zl0Juefc?=
 =?us-ascii?Q?QqAO++SVC6k8CcvjeCESvgZilh0QSiPaWdso+M1teltKl+nQSktiY8gNqv4C?=
 =?us-ascii?Q?Gjr1FyC1LmseBhVyufpfp7LKJrckXwdkzpOeQTzwc7lQXPhJ7/MJoEO5z39t?=
 =?us-ascii?Q?+ROeuqOUUW8+Wf3eZn8HV1tC0PuoypCmtaJEDKoSPYcSXOPlfQLKOip8IRQc?=
 =?us-ascii?Q?l9Tcrp5BjORlp+ZjRdrkgT46sVfqie/Mco+ChqIdc6dgQQ0P1PrulS08asBl?=
 =?us-ascii?Q?u+Xdvue/Pp9ovifpbpUs/mqVxn6DYVggj8kj3YoAVe1Xnc4dMX0de7KxOafk?=
 =?us-ascii?Q?/NPychzKcy0V6cWkTgYwiSkf7fuiHa8VOYgsHaRn0sUfBEjjf07Uy3jCedWm?=
 =?us-ascii?Q?lRYcFs3d9slmWsM3OICccvVo9rBHsoxxOmio9HH39Afstr876+1bkRBAc22H?=
 =?us-ascii?Q?yNf0RS1rF6nkNseIg9jLpGfxer5cn0qQZUKmI3DO45egR6jwQjwYJfkol+Vx?=
 =?us-ascii?Q?WUxtT4/AXIhXigQF7RapuWn+1wXeL4cwHIGLs59jVOd/uzdYMDaiGxih2UWR?=
 =?us-ascii?Q?Ho8sQzEIjMQafeMU8WAGWTx60TuO7qelzFxH36quSPtjXJWcEpNDwICWHuHb?=
 =?us-ascii?Q?uYyyKnLT3dT9XYIWbVZMBUT0fzwQykrHqaCgnCm60sPDmBflM4QRwQE1dkGX?=
 =?us-ascii?Q?dkOjJM7GBsTP9gBLbMWmYkysPQodMq3vtM502FMLRVJixn/5YSkS6v7Ttgp+?=
 =?us-ascii?Q?CUZcMglnhBauY5mpeVu61FMSGwn60uU5CcBE1809mKwVWfLxHZzE8DwAHqIV?=
 =?us-ascii?Q?htDTUn6s+weIhhLHDU4itNtZejr5VoGWIe2Clr38sjeBuOjc80rbQXNBls9M?=
 =?us-ascii?Q?GVSYaXyhch9ImXKj0mWJm1eKDxBTQ6rzPOM5mWK/SazY4xW7ad6vdwcQt8LI?=
 =?us-ascii?Q?oIN6HfOOWn9N+viCVlOJzDcAzlMYR593HlDwhVxBRq3G7/KgRZmS71+fy//B?=
 =?us-ascii?Q?15PL4ON9Y4b/gDDANDSAvqZp3RiLT7ipq1vjdR0lqwnxSrlQjSf3LNWcIXmN?=
 =?us-ascii?Q?5qaHpLROoiqFXeqnazTwBdqau4LPT8JpGfh/BUcbzT+51ws9fvohEdXD5wjJ?=
 =?us-ascii?Q?Y3cbPn1d1l200ovgKjqC/+ikNPXW5XZMb9W3Kxv5/h6i0Zo14FIZbaYm8dNA?=
 =?us-ascii?Q?bNrzEOM8jeRrMCbQjiO6urmiGSz1ukyrt2nvzrF9ZcXz4rotoZpSgm1H4Dor?=
 =?us-ascii?Q?s3la1qwaW0JvdJbbDUcyd9sUKpufkxNNACKE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 05:31:44.2401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c343d12-4712-4873-164f-08dd7ca7f97e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094
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

