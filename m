Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D333C61DB9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 06:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE02210E03B;
	Fri, 28 Aug 2026 06:22:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3msYiLhR";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011071.outbound.protection.outlook.com [52.101.57.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A720910E03B
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 06:22:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7hz7dFfeDy9/lFFVvAHRI63qdHwLuVmsHRrVebFp7M5L6SlmYxxAWfeNfZMs+EdD88ZA7z7f25zQBO1WpnVfqQLG0xGmcHC+SfQM3czLtr5SVscqo4r6Z2kNr8i1CTItWSG8ZjwXOVYBbk7bF8AJyucsFkVcCsKcaR3qF7D6MerPjmsFWrecUWMdxPEXyUGapzbUTQMTKoU/DsU5eZfR8GT0WPXNApQX2toaT8iiHw6zyFza6coqLVE3Ex+OSWXEksOgdu39m6ACOFQoHgbE/h6xZ/f9CmnqtnM824l9AfKqs5FB+Gyokq96qBJwFt3nJSML5YWySQTgdZp9g78jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2IBQxw0iA3uhSzpzn+IdHEa7ckVDsXvPilME0MUSL0=;
 b=GKgc4dsz1TmlqJyp/UL4PFt2Qgb/HlIQjmyQN8aIlTpM48qA1MhiuVsAgpJod23wJlfU9Q5q59OIroCeQIPCGKK7MWrXLpbE9t0bIZ3a8Q/DAXjYfJk6xoEYm1UsR4SQU2oUiW545kNla9pfMhp4QNM035FHqFl/y9MUZiHrS9r99xSzKu2jiYdYAQdpCgDfH9nyJFO2CHSxrmsdsgBIHuQIU73vwMcG/42Px0xODWoLvwT5UJ30znOfdLnWtfPyr2KSQ/0d9W5lhi0sB8n0NJ4CK2Tqi3oZzVDTgVbEXU9EXdkI8fmtaFgzuO/bKjj5N74cGUSpEUJqLQO+AiMAFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2IBQxw0iA3uhSzpzn+IdHEa7ckVDsXvPilME0MUSL0=;
 b=3msYiLhRJ9j1VJpEFcMs+dXgU1mBVPBM1dI3AdqCZGBvWV6UdHJLAzjWEdGKKFLqvnjvJ5LcUcVC2y0oRsVlLsyQl2unTCVivk8TizwXjIruHelU6hv9sG6+2wAuGAfxiRCgDWJ2gIYWa0XWTtwDBomBEgGkyoSQWXFAdkagKko=
Received: from PH7P220CA0071.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::33)
 by IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 06:22:39 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::5f) by PH7P220CA0071.outlook.office365.com
 (2603:10b6:510:32c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Fri,
 28 Aug 2026 06:22:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 28 Aug 2026 06:22:38 +0000
Received: from amd-X570.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 28 Aug
 2026 01:22:35 -0500
From: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <sukhatri@amd.com>, <pierre-eric.pelloux-prayer@amd.com>, "Yogesh Mohan
 Marimuthu" <yogesh.mohanmarimuthu@amd.com>
Subject: [PATCH] drm/amdgpu/userq: fix struct drm_amdgpu_info_device padding
 for 32bit compile
Date: Fri, 28 Aug 2026 11:51:59 +0530
Message-ID: <20260828062159.34669-1-yogesh.mohanmarimuthu@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|IA1PR12MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fdb271c-a35c-4f28-f359-08df04ccc203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|3023799007|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 1lYUvObH4FgMTnRT+uTD+HLjYswLVAwui/5wFzkVEAwsD6yvqwIoFXjNek1rsGy4oR+l/A335DYHWWNNVOewi7z+/jmyiUEmQni+m3S28IbOw4A1+xn5MztFb0PvEVflEd51f2YmFMfJyePUUNQIxhjDEGDN6AHkxeGqMEW8tu5uX7UvI4Sc/lVDi7FYDLOL4yJ7wu8/A7B2cq4ABAgtAq+q/gxdRljMv0oOMcuKOD7Twvxv4H6AVi0wa14bs/OougXFYuL/HaNmdF5TmLzXpsta+Teby+Ud4o5WLNeZNJ6xCthK/hGBGpPTfRY9fnI7QRNzlD8L4SosqlSGT5biN+PJX7YRWfViXVkA6nVZ+H6qN1MwQ6KtCDn16qj5brrOcA/hJA/tZRnVj3pQ2WmnuvD/zLDcss/lqeGRsSxASwaQ1EVg6MIQPFlLUZSJT3wC126MlDEip7I0Xu8fUOgrIlwjeFoJWsKzsZTchNguApM72bte8tkkfjUKmX0zkmGgn7Kg5oFbloAtMWmOceoCjQI9LD7GbtjSU25Ixl1bSfwU3bJLqpzPKou0BL+/GHzqYDtUk8Y9kYIL25XSRTGwvKqQ7y/lmA53w9Dzxj1RVDWI0BZPXDTyK6f1ooF0lHj1l3Cf08dH8VR1qN92NXk2N/BmDT/9FR3vU+knCp/axxEcJfBWzkQ4HAbwZcroE6JJoG2krrdWNyWkE9PZ7EVKrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5Dcx83/fKVUIRw9SNd0nn13xg6kJJW8/IAuzZzWQQy3/UNU6LSPBGL1PnWeBD1wuXfNKaaswqrS1qThIyN1rsyr2tb3sETKvLoA/JNBvH+bfDPJW5KGnYRunklvNvTBDP7/OksgRvQggp1f11zaJCJ1zsSL9dtNGUMH5WvjtC9AiIKYuzQOhQlKmV1L8zqdsNeagnrcEhpMj0JNuEzpSUBONU13rwZDpnxijg9tXgXOaPFuAfEgmybVseaJoJnSsN01M5aoh5PRg3NM/b32bDOzGdAskjihWc4ZwGqemvKcatkD2ruNrZKgaN4Kuh0NczfuRbLVyWgj2EOTYK+fybXLz1X0uBs2qKf3mSFmKCudVcJC0Jz9R1+fRc9TFi1euklR3aSF9AyRtyWzsmpRuBQwjRmNfUl+dAB9CCvstq+U3B3Z+ESDKhk8pMsSKXUBS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 06:22:38.3887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdb271c-a35c-4f28-f359-08df04ccc203
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517
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

need to pad before __u64 tcc_disabled_mask variable.

This patch fixes 64bit Kernel + 32 bit mesa combination. But at the same
time it will break 32bit Kernel(using this patch) + older 32bit mesa(not
using this patch).

This issue was discussd with alexander.deucher@amd.com,
christian.koenig@amd.com and pierre-eric.pelloux-prayer@amd.com.
Currently today 32 bit kernel + 32 bit userspace and 64 bit kernel and
64 bit userspace work.  Mixed 64 bit kernel and 32 bit userspace is
currently broken.  Since 32 bit kernel and userspace is probably pretty
rare these days and the data affected by this is not critical, Hence
we can go ahead with this patch.

Signed-off-by: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 0a113529b..5beef3eaa 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1517,6 +1517,7 @@ struct drm_amdgpu_info_device {
 	__u64 high_va_max;
 	/* gfx10 pa_sc_tile_steering_override */
 	__u32 pa_sc_tile_steering_override;
+	__u32 pad;
 	/* disabled TCCs */
 	__u64 tcc_disabled_mask;
 	__u64 min_engine_clock;
@@ -1541,7 +1542,6 @@ struct drm_amdgpu_info_device {
 	__u32 csa_alignment;
 	/* Userq IP mask (1 << AMDGPU_HW_IP_*) */
 	__u32 userq_ip_mask;
-	__u32 pad;
 };
 
 struct drm_amdgpu_info_hw_ip {
-- 
2.43.0

