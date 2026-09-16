Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAD7C88E5C
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 04:51:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31D5210E0B0;
	Wed, 16 Sep 2026 04:51:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5jvuk89+";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 812D510E051
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 04:51:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p960syRjA5OqmHpbYOiQAnrWtq2MXDWPFPuwql8VHiVonfsk1IFmZgGB4L5GXSAkEQmISaJe8Mwxc7CPDvIKezvlLF0P0jBzeyGtu8T/zZdQmLtGigbJSuSEycwl6XxCSYf/GG+Ls3f8UWJYMRkKIiWM6mtKrgXzGDdlvELI1CpuTG98RQn9daV47dCnvHMLa/0B1O+3FPJpQQUR1P3GBNZ/w9oJewpXhWFl0n4Q13MKVha1serh+uV2AM/nurLzLRAa8MzIl1M42U8z8BppGKG5svTrFzffl/djwsITtpXMbhLofnp14cYuqDQ6fMMIVdAl72fDq0Sj2VBzp3AKMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PJj0ig2bp1Z7/g6rxsBJ56wZjXg9ey08ekkncrid5A=;
 b=vqHjjMIsM7FQ9RLiJMeJNv1v120xyVJf7vXuTwzp5plHNr5nczcWSnO2v1tU4nh5B76RzLKeZcBKUAMy5ZOybq5+p6Z2mJ15BcDVl0jCdp8JnnbxSVj5psgh/24+CJuR8qYWfjveNVENs9XSbyhSUt4DBE5ufN86D3aKaPhIF73wzqx+C7zGNN8Em5fXWtYfQ7goAZJubkta2+wF06W4X6hCjXG+CibdLoCv63lCuemEvlKIHeVtBJTQuabs+4Jr1CSc7uhjKFsY752Or2y8VYgbibHr2EZtkiiIZvBbjnrlrX5PTc0fAV61rxKYOnwkAdkbshxCkyAFiBNOpKTyYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PJj0ig2bp1Z7/g6rxsBJ56wZjXg9ey08ekkncrid5A=;
 b=5jvuk89+/5ygk25vuIddYoTRwt5RXXfe0/9WpoFCDvt5IIw4eGXiyl5afp/UISag6ymBptAWy/nuWffUorsh6em2VOaH6a/5isy55yOPeOBwutMJGy6qwdxfFmS4mQQWvfSa+mEVLVxdtw+FiY0CMAGEOxHdbAuISwSENPJIDzQ=
Received: from BN9PR03CA0152.namprd03.prod.outlook.com (2603:10b6:408:f4::7)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 04:51:36 +0000
Received: from LV8PEPF00000068.namprd03.prod.outlook.com
 (2603:10b6:408:f4:cafe::1a) by BN9PR03CA0152.outlook.office365.com
 (2603:10b6:408:f4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Wed,
 16 Sep 2026 04:51:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF00000068.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 04:51:36 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 23:51:34 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: Fix SMUv14/15 power context allocation
Date: Wed, 16 Sep 2026 10:21:16 +0530
Message-ID: <20260916045117.1658211-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000068:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: a7af739f-2d54-4ad9-7a27-08df13ae3014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: rtygthZVbPqJUH67E90CptiPKBck3GnCdzPhNnnc+UuoLo7RxrVjxc/2JSd6QQCcipSClUE6o/vEchCiGaALGd3+GznBmQJwL+MlrRhkwyRghJwTtJT843J2yAcakWELkg0+C00JTu41z9EaKS6aJZVEOi8wpZWZIM6wio6QyQJqpVSkNWlpAyr2or/V6+n58zzFbpCvR/bGWxJnk6GGcLYcrQ+lhtb5vtGW7U41F5QbMqEsrId0E2kKYKkDS5IXOwX8uOg/GTK2yXr0H5nYRkOT01PMMwUXTASnO6tKe04PzXC/S5gzIibWEs0GhfUAv7IG/WMj4NDJIl/Kl/8MD9BKP1Tz/pj++pleB42h5JF9C6JDQYSC6vJgr6yImZpFi6kVvlzQxGqjGd9bQI3JMzQA1ApmIAHeOPDvS34MfuIjW3rY/t/IUDUXu9+iOq0cPpyxb2FxWXml5DPa1UV9k+DCDqXQZtR+i6DCiCor6oxXJ2BzuBu18ljLyyzrlROP4ttmxAnvmV8L+PU5zXd3mF5wWAMOm2e7WnjMmWdxYDflimUsdl6bgzVzrLBjmPQVESqKAZ0GbTRqfodOmZstbQIRql0bCeUu06nireMikf+sqkb6360iuGyQigejZ1tWr5lBaIYaG4N/kwRJWtHJykwjcvOLAiJEituiGobNBuCA8V1yxcwOE3+H4iZhyw9rXp4ENVhZlj2EynkFiHWXUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GekaT49GIQa7WIID58Vw/Z5233Yyi5u5u3xKLVlCs3UAN/ZLpDlsSV+3MNCRLzWj9p+ZbepQ2VBMYuV3AV5W2xFx2xDDS+LZ1RFQc3VPRXPtUqhx5rBDDnWGvUpIwlybrXR5LUcMwg3kySd0tJhDf8zAlTEYpj0QS3cFwcDgW0+O3qS0OkA67S51WeyV6+4WdPtwtpAmL1PbvypjuDrmyZfKtwGqooiVgDnUkIm/wRhgrcgoT2Vg/lydCavS6GngbyfpAOYEGT7F1s3LOmFFRvLU3sELVpFcX3pklsbnTcd2zx4EhBzmevaH5Opmp/5xkS2rAHWOKrTwrvJMLqllE7KGqsqNNXAYpmCTwtbptPGO3ycZ4DSf6fJo0WaKJp3OrbTY6MQVkLn321P4Mt5+NbJuwV9qGYRA49L1rMSdH+JPBIMUkxuBlwbeHqqhljba
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 04:51:36.1356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7af739f-2d54-4ad9-7a27-08df13ae3014
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000068.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642
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

Allocate the right power context objects in smu v14 and smu v15

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 80dac277d1ae..f2e6105b0d79 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -396,10 +396,10 @@ int smu_v14_0_init_power(struct smu_context *smu)
 	if (smu_power->power_context || smu_power->power_context_size != 0)
 		return -EINVAL;
 
-	smu_power->power_context = kzalloc_obj(struct smu_14_0_dpm_context);
+	smu_power->power_context = kzalloc_obj(struct smu_14_0_power_context);
 	if (!smu_power->power_context)
 		return -ENOMEM;
-	smu_power->power_context_size = sizeof(struct smu_14_0_dpm_context);
+	smu_power->power_context_size = sizeof(struct smu_14_0_power_context);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index 2269703869f9..dfc1022112d5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -338,10 +338,10 @@ int smu_v15_0_init_power(struct smu_context *smu)
 	if (smu_power->power_context || smu_power->power_context_size != 0)
 		return -EINVAL;
 
-	smu_power->power_context = kzalloc_obj(struct smu_15_0_dpm_context);
+	smu_power->power_context = kzalloc_obj(struct smu_15_0_power_context);
 	if (!smu_power->power_context)
 		return -ENOMEM;
-	smu_power->power_context_size = sizeof(struct smu_15_0_dpm_context);
+	smu_power->power_context_size = sizeof(struct smu_15_0_power_context);
 
 	return 0;
 }
-- 
2.49.0

