Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A755C7EE32
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 14:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66A5710EA3E;
	Fri, 27 Jun 2025 14:34:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YyX+KfyS";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53D2510EA2B
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 14:34:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3sI+3EQFG3FLvr+zAalKzxZ5jDmnT+/kXuvqEHFI4v0/L4Ieq3CoY100LH2BugssEMYfzGb5RWKT0pN2Z2spmcTD7cyNph/RLZJ4bD4KoIBvM/mUJ0yhmqBfdP+shDQku+FwMDSbmKE5n5hpCIS+FpGrKEB9S8sLkPymVPCOrN/ie98niKgHTN0dBTzh40RxFpwkUSF77CIjVTHbFE9HRGo75pHqEuF+9PJBpzLj3ZTB3t4mEqLSBwWwe/5h82VZuFSk5x8X9q9iCrMtg/KKQF6Xc8Mz+s11cy6ZZr7eYG07mAiW2+coiOS2NVNqEVdOlG4vIsqPH7UAUKFD0UWdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NTGY9426WuZ3f9ENO3Mfaz21s0PdhgpvgjJarMsfLs=;
 b=psYppqqlw77Usbtxw3seukVRd58FDeKfVIYxGFlC4RdKTjaoRGV9Y6Vng8ZcnkX0SincbK6FtAG4ScCPGvZT7/7c7+2/djwV/x/blE/jhgEAYq97X93QTmF0AIcweqL80qqqw1tzUHSjP3zV9rusB/sE6G8omlt9/5x1TRwi9G1sw7k2ZODJmJVAv0NFS/BAXCFxJcDX0qu5w0paIZX/eh+o8l/8/VfJUYPCtsct8BhWwMskFThYnsOJLO6mW8oK8hsrpPfuNfwTWBIA9NV8ne0S3l04x8LwpQ5Q4dCmgGY/BR5xeInzaqHqONxVgtXJFYCdTbgzz9pL1e/AYqMz9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NTGY9426WuZ3f9ENO3Mfaz21s0PdhgpvgjJarMsfLs=;
 b=YyX+KfySygeX+aj/WU0u+EFnarYjxOcshDQr8bUfQhKt2noRbonUE15Sw7oh2ZFRSE+HzEoAxh3Dn7/Kfv8pxMixcpcdu1QyMEp25kupAtig3OfRijEDcG4zcY0wSWAXxmlL7HEp2QDVEUMkBVDX4guRYWM7rUMjNsvOAESjPrg=
Received: from BY5PR04CA0022.namprd04.prod.outlook.com (2603:10b6:a03:1d0::32)
 by DS7PR12MB6141.namprd12.prod.outlook.com (2603:10b6:8:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 27 Jun
 2025 14:34:08 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::1d) by BY5PR04CA0022.outlook.office365.com
 (2603:10b6:a03:1d0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Fri,
 27 Jun 2025 14:34:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 14:34:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Jun
 2025 09:34:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/6] drm/amd/display: add more cyan skillfish devices
Date: Fri, 27 Jun 2025 10:33:38 -0400
Message-ID: <20250627143342.23856-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627143342.23856-1-alexander.deucher@amd.com>
References: <20250627143342.23856-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|DS7PR12MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: ea62df27-e8ec-410b-07df-08ddb587accb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PtL5DIuKpGKcCteZZQOOuQEBy+njbmTGV8DuJ4Vw50MZn/qNn+KLybUJQHGE?=
 =?us-ascii?Q?rEukmxzk/qmcmLqRuJ7l70nKVmJvAFJh29FUeyGxvp9u90uirNQ+RiFDlk+R?=
 =?us-ascii?Q?VEZYnsGPtosRRDqbjM7hzm1go1xIs8Dzi2D4VUCCTV/JczBnBqhc7hxy42ee?=
 =?us-ascii?Q?SPjMJfPM6jqKonO/hVm9ySIL9E4iKZk4FPYFQWWy5Dxp0cHHMx5pMKTpgGFV?=
 =?us-ascii?Q?bLXW5JI+QJuXsedsn3UioH/VShHYu/ZU6N5cHNa+9mr03fCq7keSn+80BFG7?=
 =?us-ascii?Q?5OcrvZS9Rc4DzG0pTFpVOWzVHu5jOvV+c060FGlCu3IKuyROTuj6/Kb2JK6m?=
 =?us-ascii?Q?oQT2q3j7T6LTGb58zNxevY6nb6kFw+uQ7H7eoFJR+3zmAWm7IzV2k8m4HmRI?=
 =?us-ascii?Q?Irj5WbhKdNf3MwWFjOgbf8Twu6B0gk9hqd/LHFlt/IzjKxV53Nv55V3H3JsN?=
 =?us-ascii?Q?j+F7Hol8ddDpoH56+jmbAgFDSHxldHhU54zuvSPu81sPANRmnfyl7VhY7b6d?=
 =?us-ascii?Q?h7ClycEoIQ72Bnge4ja1ZyM09xuoOCbyYhESXsft1FFRUHec317bZrQH6BkR?=
 =?us-ascii?Q?wCIL7KVhWP4/ctj5dgrmgU7QSa8RliWY1LKzUYbeQJG7S2RIBxb/gryq51UV?=
 =?us-ascii?Q?aG3cWPYab1GKgToj9fAIPQG922xuU70g5ntM1O5Qkg3urzdWUABHjwPvn3ji?=
 =?us-ascii?Q?uW8wb258mgRF+YG0NtU0KwdOT4u/0dCgdeGGfHc8ueUgmHXh52IaSxKaJt0/?=
 =?us-ascii?Q?sBw5kNoHbVsJZZNoQG/bzeJNMxHDFj32nWtmcQa6k3MTVqBZ90K15uMmvs7C?=
 =?us-ascii?Q?6zLacfGK3vxZCqzV0OethUxI/vn9Xx303krFFFeJgLq9GeFPLzacs5qXvJgc?=
 =?us-ascii?Q?As0mL1sBmj+6ha0fobvIV2ohram7Wz3iXjRMtQ+HezprsF+BVG1R6Ff6Ux8m?=
 =?us-ascii?Q?hyKxpokRoYesYV8uJxyMFnYtJGV9YL4V+QnLK4QhSSbi09YkB8bWgvwmDar2?=
 =?us-ascii?Q?FQ9p4KRjZG2QL86/Fiz+Tyrdnsd94mm6aKFndCjQ939l7eHsEm8CUzL4sH0l?=
 =?us-ascii?Q?h/+nKZIop6EAzJ9ESEC2gxh6a1zjC0CG2nd4ywOc9ILRaKYffcaZMR2LbM2+?=
 =?us-ascii?Q?8wmHO1G0ZIlrB7O61ItTsjbGEOqaT93zHVBt6GHS1aiOo72qStx+rO2b9O5G?=
 =?us-ascii?Q?KI05LglidfSEs06c3W/UFm5r3dHkE+cANveMQFnkXLDEAeYtfX80kBNOqJYN?=
 =?us-ascii?Q?pZOZj8I5GmZ66ju7VfXn5J9wpWHa9O+3jHzxTDT5LkHS5yYCc8QnNwfWMAGm?=
 =?us-ascii?Q?amPvtTCDdMpIM7U+k/H26U/VSWXviIiTYpa2jwjPm/cS85Y+j9c/gmtqmYiF?=
 =?us-ascii?Q?pnkUJTKNJgdUxPatbfiPTsTEetP/4j4cO4zXpeaiveqc+WVurMCpmzP6uLlL?=
 =?us-ascii?Q?EIXfkoR2jvzK6KFaohNKKFhlcNxSGEL/o97+wplFybSL2gm8rjSEMS7iJ9HS?=
 =?us-ascii?Q?yuRzhtPq1blIRkCA04w5y/XymxK5S4sfZeg+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 14:34:07.9317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea62df27-e8ec-410b-07df-08ddb587accb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141
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

Add PCI IDs to support display probe for cyan skillfish
family of SOCs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 8 +++++++-
 drivers/gpu/drm/amd/display/include/dal_asic_id.h | 5 +++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 854fc51f159c1..133b76bc74a9c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -165,7 +165,13 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 
 	case FAMILY_NV:
 		dc_version = DCN_VERSION_2_0;
-		if (asic_id.chip_id == DEVICE_ID_NV_13FE || asic_id.chip_id == DEVICE_ID_NV_143F) {
+		if (asic_id.chip_id == DEVICE_ID_NV_13FE ||
+		    asic_id.chip_id == DEVICE_ID_NV_143F ||
+		    asic_id.chip_id == DEVICE_ID_NV_13F9 ||
+		    asic_id.chip_id == DEVICE_ID_NV_13FA ||
+		    asic_id.chip_id == DEVICE_ID_NV_13FB ||
+		    asic_id.chip_id == DEVICE_ID_NV_13FC ||
+		    asic_id.chip_id == DEVICE_ID_NV_13DB) {
 			dc_version = DCN_VERSION_2_01;
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index 5fc29164e4b45..8aea50aa95330 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -213,6 +213,11 @@ enum {
 #endif
 #define DEVICE_ID_NV_13FE 0x13FE  // CYAN_SKILLFISH
 #define DEVICE_ID_NV_143F 0x143F
+#define DEVICE_ID_NV_13F9 0x13F9
+#define DEVICE_ID_NV_13FA 0x13FA
+#define DEVICE_ID_NV_13FB 0x13FB
+#define DEVICE_ID_NV_13FC 0x13FC
+#define DEVICE_ID_NV_13DB 0x13DB
 #define FAMILY_VGH 144
 #define DEVICE_ID_VGH_163F 0x163F
 #define DEVICE_ID_VGH_1435 0x1435
-- 
2.50.0

