Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43ED5C61CE8
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jun 2025 08:01:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC76610E78B;
	Thu, 12 Jun 2025 08:01:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sCUrEXFO";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 383DB10E78C
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jun 2025 08:01:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7UywRYU7KChmW7h4UYsRjTyDGtKAQ+5CwXzfY3SRUxwNn0y1BPChBpmX2XDS7vlSBH9Z/JL7urNiqfMipK0kWgbkjhrE0t6aIoYotBZl55QbP31zlHNuo1ouwhUDZ5pJ/CRBvtTo1VVxHX/u+e8iovm24zLXFrFzg1unctYgw54uV9NAcVSLcEUHV/ne4LAqurEBXh4tgMTIM4t13ZqpzkCoWPR/+9qpdkK+5kL1EJfQoPBWb8oioY6wFzbhP/UBsXIme4TR21SGdDb6mhM++xQWqGVGXZKrOqUwEOR5R+q6yM1KmQGRA731ChjrbKW2XTP0UxqYndUjwPhSSVfIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQeImhvChIxl7xRMA3Eam4HttgptrbzXNWyFIh0ykZs=;
 b=S18NUPbOFHiqMgfcuLjJSdIRudgETGY7mE2e0O8KzZu+AFiAQilC6TAdZZa5Tk8WxKERSTWSeZmJ3PruPHyxY60dj30W1raku6e72EMVtHjNEL6U66p3ZEl5d6HzxRUzcb0LjA65UQvyi0kMSl17T4gBGzM+cq+ma9/p2Orvju4wpoSyXv2ep/2aJ49eb8rbfSqZ315q2TSrQXu88ZVn8b6s1WeGNx29z3cmOQf2EkKLJmVOjSWbAUfYOuYpb8H9cf+dk2gXCnCrVIDkDfzU4Uf2y3Ihan51mtkytHSPknt2KKSkXHRf1SgaFqleG5izWygJejGhD9qhqHuQtusO7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQeImhvChIxl7xRMA3Eam4HttgptrbzXNWyFIh0ykZs=;
 b=sCUrEXFORSz3VbzZy3aj/Bq6NwtbwelZd1yLiPcv75ZWVJjgyaqSU3WCy3Jkv2h86DuRiHrCPoM1Bg3hpdmrfS7vrohf0ib0pQTPa/iP2wrEX92BHA17lVlxkKa7cAgYagWdGzRerF8x3YdFK5vrWbwVY34ZGX4RO3LrkbZW7Co=
Received: from PH8PR07CA0043.namprd07.prod.outlook.com (2603:10b6:510:2cf::28)
 by MN0PR12MB5834.namprd12.prod.outlook.com (2603:10b6:208:379::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.40; Thu, 12 Jun
 2025 08:01:40 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:510:2cf:cafe::ff) by PH8PR07CA0043.outlook.office365.com
 (2603:10b6:510:2cf::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Thu,
 12 Jun 2025 08:01:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 08:01:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Jun
 2025 03:01:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Jun
 2025 03:01:38 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Thu, 12 Jun 2025 03:01:37 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <KevinYang.Wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: update pcie dpm parameters before smu feature
 enablement
Date: Thu, 12 Jun 2025 16:01:32 +0800
Message-ID: <20250612080132.433434-2-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612080132.433434-1-kenneth.feng@amd.com>
References: <20250612080132.433434-1-kenneth.feng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|MN0PR12MB5834:EE_
X-MS-Office365-Filtering-Correlation-Id: 32db63c2-9f60-40d0-7238-08dda9875ca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jUIGwbLIgHU3tmiEmYJNRzExsspwr/fQYFfb+heVy8qa3DTNQfGNn0URvfZb?=
 =?us-ascii?Q?A53JJwojoP+Qso64/sBdxSGT0GQG5jbHga9DRSXDQR2K6GUx5X7MKwJLwuEj?=
 =?us-ascii?Q?3NSFtzWH75xbN7oxcSFDeyoAc0AApZcKYb5ygws5HiYsc8/6aPyT5yXVqCdO?=
 =?us-ascii?Q?1x5EeovIRxiGyp9FyLGHeOKVn6dzribPGSukCW30IFsi80OLT3YXP07rwFhT?=
 =?us-ascii?Q?36bi152A3ndM6p5+ABtgSxwTWDnpjEQbyc5E8Voa64uO3D4Hra1E/yYeDmS4?=
 =?us-ascii?Q?EW6JjMJB8cDBFDR1fbNxKzPH51yVsEcjIEA8R4zxCPapjeszGGYzLueFyc5z?=
 =?us-ascii?Q?qcg7k3Kh9ulB/HwSpNQCMhW5ry7WPbuQWmhm3DM/gdoff0oMBTp6DFNRu2Kg?=
 =?us-ascii?Q?KFCroa/5B51FlcFZ5Ua4PpMvCaUfBBWdpQR3WrYmlhVjvm6rBMvu8QhHogRI?=
 =?us-ascii?Q?Njjb4n+cJHCMLWQlgZhfctFImuyi4baW7jZd8lznTizT6Z2iUqetA1HORwh3?=
 =?us-ascii?Q?EI0QQaWSXze0I3w2Fqj5t5UJ496j1BFvu0I5WSnIPVZNgBIik1YqwM0F0G5z?=
 =?us-ascii?Q?8YLBOzuc+2osqQIjR90cIOkeeAFOjEJHxr4t27CWT0l9HUcrslJYZQWqLiTv?=
 =?us-ascii?Q?yM4z1FqnnNuOkQ10oiC8EBR3g813GgTqSPWRFZM8d40NKKdSJuMybYRlpAY/?=
 =?us-ascii?Q?MYiKzff/21iAxr/RFw9MQhRXQw62vs/Owp6jjkv/XmE/+DYdY/D8ms1FuVnl?=
 =?us-ascii?Q?Vcq8wdmKVS5cXeBnH/dD/WfWlGGekqKD2SG8FHaH8Iy8cm7lkugdmwBHGuIg?=
 =?us-ascii?Q?gF8Dncaru6P1I4xya1JYehWGHJQP+KaJrxqli7Q1xs/BIyWqo9+zIWPAP+WP?=
 =?us-ascii?Q?U0qI74c1qeT1cSp/ohWURmQZo0ceCcoLarTfL01TzGhZu4dGzgG7IkJ8Y9e8?=
 =?us-ascii?Q?aFsPpiLxA74R7gXbF/Ix2XOD/vdwAiv0PFz7XwNVI9/cgRGiuuoMdhqunK95?=
 =?us-ascii?Q?muHFU0JZKP5sVeLm3uZ3TNdIVXJE14k79kZSkdST1u/PZNGPCZXOEeriUc2M?=
 =?us-ascii?Q?gxXcVavvF+LWyWHjZcp/BGC2jgZi0PSpKNJ693QQV1PCOAZOtDv4w7vtawtM?=
 =?us-ascii?Q?4+yxRaRKrYdypFUpcB/qdF0hg0o1tE94q4MMdF5y+QcQRV4THyRvd82PaWZJ?=
 =?us-ascii?Q?1m8lH6b6X3xYavvpoQGZV+ZMFcIfLO6fAJB6zfZ+moVsZjmB1h0m+Yhz6xxm?=
 =?us-ascii?Q?ldh5v2rZ9N4td2qDh/C5dU1p7+1jUnnT1KRiDjWFpvlfKWCJ/2bgnt2APGd+?=
 =?us-ascii?Q?hYkYV5c9WgqUqBlDTq3Be4CTa6RI1aV74N1sK4vXvEnqqUsEpCOgYD7LyE+O?=
 =?us-ascii?Q?7eYvL8XqJcL4RB+6bXjphM7q1g9U82KZr1fhidi552/lrEQgV3THfqJxjPfH?=
 =?us-ascii?Q?hhh89qKpBS4nokuKU6eCAiZxdA+z4LDSNL+Bv0scT5xzpvvB/kDt1Nbkg3o7?=
 =?us-ascii?Q?zqBG27LMSkX4XK+5prmssdgq08xwIVFj3Imd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 08:01:39.5178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32db63c2-9f60-40d0-7238-08dda9875ca7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5834
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

update pcie dpm parameters before smu feature enablement

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 40 +++++++++++------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index aedb209c75da..824fcc6dd32a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1687,26 +1687,6 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		}
 	}
 
-	ret = smu_system_features_control(smu, true);
-	if (ret) {
-		dev_err(adev->dev, "Failed to enable requested dpm features!\n");
-		return ret;
-	}
-
-	smu_init_xgmi_plpd_mode(smu);
-
-	ret = smu_feature_get_enabled_mask(smu, &features_supported);
-	if (ret) {
-		dev_err(adev->dev, "Failed to retrieve supported dpm features!\n");
-		return ret;
-	}
-	bitmap_copy(feature->supported,
-		    (unsigned long *)&features_supported,
-		    feature->feature_num);
-
-	if (!smu_is_dpm_running(smu))
-		dev_info(adev->dev, "dpm has been disabled\n");
-
 	/*
 	 * Set initialized values (get from vbios) to dpm tables context such as
 	 * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
@@ -1753,6 +1733,26 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		return ret;
 	}
 
+	ret = smu_system_features_control(smu, true);
+	if (ret) {
+		dev_err(adev->dev, "Failed to enable requested dpm features!\n");
+		return ret;
+	}
+
+	smu_init_xgmi_plpd_mode(smu);
+
+	ret = smu_feature_get_enabled_mask(smu, &features_supported);
+	if (ret) {
+		dev_err(adev->dev, "Failed to retrieve supported dpm features!\n");
+		return ret;
+	}
+	bitmap_copy(feature->supported,
+		    (unsigned long *)&features_supported,
+		    feature->feature_num);
+
+	if (!smu_is_dpm_running(smu))
+		dev_info(adev->dev, "dpm has been disabled\n");
+
 	ret = smu_get_thermal_temperature_range(smu);
 	if (ret) {
 		dev_err(adev->dev, "Failed to get thermal temperature ranges!\n");
-- 
2.34.1

