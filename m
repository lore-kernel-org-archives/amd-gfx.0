Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4242FC021A4
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 21:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0CEB10E0CF;
	Wed, 12 Feb 2025 21:48:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nya8vkAv";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68B6910E99F
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 21:48:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y34KhbHiR4SaUolHozBtVneFb5LdnOMqgr5ihtgKpwu3Zf1nNdjAEpGQiaLEhfB8Zp5wMNil4zxe4TM7u8Xpi/gF4mU6e/zfRgaJo4WbWvm7f/qySY5MQhTQCWSHwNoFZhXf0Y+gMVJksLlu2XnklAbk2s885aSQhUwYL65YKep6zHlpGHO7gvg3lmRQGapQ4IZUwz8UwH3454/FazVxZo2+tomqtGctgWZJE4npWx+JUfdbMGNzOMpo4TVjC298Pu9tAGwyA5ms/6S29wEsRtGN4D8SdvqxoaMeZ18YGMXhAk0HKv2e1Us8MxAA+Ip/mqtE5cOjwcG0i2cqccdaeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGLpTdlM6VPqKaOefZAhsXqnT++3sFPW+wyCLo0LNaU=;
 b=chhtVDtMSV+9eEzpFLK4hneQcQRgkHVWPn0eeQJyHyilRcXfNM3eLtrNe+iZpfuTCegEK3jzfj2Ya2RJNgmGMKckFH1xgqaiKjHgzptG/BbDmQFETcOIsqWJXQbcTYw5/l37746zEUcNGC2Tng3228J4Ix9G4wuaXyFdpcSnA28VksBCaWMQXzOQP93HlM8fcVzptHqnLojlbBNXwO7TNfQrmM/DLGBS8+mw8p+WyffTy93hpNFxm8toXEQahwStTrLf9PXtHO6hfd3pku2JkYTiiJOTyOAVEfW7Y5ROC+8SXZ32J69tRzLuYvtwuDT44BsDdNpsMCu9U5hnqezwtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGLpTdlM6VPqKaOefZAhsXqnT++3sFPW+wyCLo0LNaU=;
 b=nya8vkAvz6HDgQjBNyxlCzxHL91Nq8b0EvqyTR67Cu9yF3t2tCHoUAeo5va9Dgyw6AG4wQdC4hfkseXLCT8XGgsqSLuBuFBr+6WYxOoQWtzDAXnDovLak3U6gH7bezbM5yh0QXRzao5iFMeiFaJr6oJAd2kaRN8lcWlUKaybodo=
Received: from PH7P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::21)
 by MW3PR12MB4489.namprd12.prod.outlook.com (2603:10b6:303:5e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 21:48:38 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:510:32a:cafe::39) by PH7P221CA0026.outlook.office365.com
 (2603:10b6:510:32a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Wed,
 12 Feb 2025 21:48:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 21:48:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 15:48:36 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/umsch: declare umsch firmware
Date: Wed, 12 Feb 2025 16:48:19 -0500
Message-ID: <20250212214821.2871419-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|MW3PR12MB4489:EE_
X-MS-Office365-Filtering-Correlation-Id: 7062c7d1-b425-400e-8c05-08dd4baf01bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O6q5hg3gUKM7zftu3RFk/V343lSq6bUhQoDwtU0Bb6XCV9uCGiaFiOP5nCmf?=
 =?us-ascii?Q?JN7VlMSGok847z2NfitPC3Zz+HUQ0X4czlliDzEx5whakesurgSWhOQfiOhC?=
 =?us-ascii?Q?4gspIvw34GA/MHb8BRWJhX5eS/JLAqKE9j/PWr/wlbmBe70bBVCsiL9Yc7er?=
 =?us-ascii?Q?MYBdWHWOdrb/HRpM/KJOr8lPaJGne9hIw8Yu/A9o8b5enFZSGsaBc7NqSKRm?=
 =?us-ascii?Q?R6R19F/hUlbPgvvPHdlxlobbi6aHItvbKIsk/Wqu0lKy0geAnrwJIbNIyCMw?=
 =?us-ascii?Q?Nh4/45hj6FVkdhK3TrudTTkVPwooRJuh/yWnjjhH1cgjI67twk42JkoilkvN?=
 =?us-ascii?Q?SyjRXBGtvF4tDB3X5Vm2gBgsDwrkP6Do1/suGbDba6/ts4vqekpQGL95XCSq?=
 =?us-ascii?Q?PsUq6qrL3skPgMuOW3xqNjNqyrUA1AXYrnWLsxH39w4XiGhZ+5S2jqqA0Qdh?=
 =?us-ascii?Q?E+xc4uik3SjgwsIVL5IDN6jA6PiTy3Czxkz3Q4gOz6kmjkOUNz267CcMlgXr?=
 =?us-ascii?Q?bkxRY4DCL418ssuT3X0m3ZKKcJzlqoqbbUW2ursI4YVOgMzDsGj+mADsVm0T?=
 =?us-ascii?Q?krAxNKRT2wpEWsnjW5Yc2kZeuuM8E+UXVE/bWABIfNbp6wEc22qxVpfg8oQJ?=
 =?us-ascii?Q?WtLqLwGhisS0S3G6u7gXaxv4g4ieGq2QTjYEUtTonSdR9U0rZ4OiY0Il6pH1?=
 =?us-ascii?Q?6GbB7GX++QGJUD0JuHsGJm8/AXPC3bQlfE0Bd6or/BOBl4YnMgGfRh+A7T2l?=
 =?us-ascii?Q?tTzu+CAx+6RCAGo5olHzUhEMnIQ9wMoZqaSa9z19MHDBYQwGJvnXps0neSpb?=
 =?us-ascii?Q?CGbnlpw7LpvJf9F7V34TfyspT0Wq/PkP+26ncwoOPjyjO4OWLM+luCVIXo18?=
 =?us-ascii?Q?sb+P427N1cdhi1XAsWVr+dDXm/yhbLvS0DNTcryB+kKF7OSfCrqPRJNvmgI+?=
 =?us-ascii?Q?AtthwHxraNeYANFCjvowTgTYVfhqxrILlRS320H6MM7ktTMbiY3Uew4Y9UWQ?=
 =?us-ascii?Q?y7vrmMD/oMDW32hPwMN1MATSk2CLffVpPlCYCyHW8w8f8g8MEAAlQ5cYv0dL?=
 =?us-ascii?Q?vE0NjDECBbGS2MjWsOCXAogGAo/4T6HhGf3e+cK0nDwaPa9LqsZmTeKP/NL/?=
 =?us-ascii?Q?skGbd7HURkITdAobIxSXtRSbZm1toQLMopGpDLrJFj4P02/60p5mt68ulMBc?=
 =?us-ascii?Q?olbIO4xIkEdgnpVHxMzbZvIzU468NPsRuW5st4/snXvfpxGMKGr/wprUF4Ae?=
 =?us-ascii?Q?RJXx3jIXdwfgpMHToCveT2G532aHY5U8KH/ndVHD8jp/dL+Y04Hz59V96JPS?=
 =?us-ascii?Q?3eZYhlqm953dcJ77HtTwD26CSSYOQEBSvyUevzDoCOQ7tVv/yDkTa+kNJZAw?=
 =?us-ascii?Q?VfiXNjcQHLqXIO04THnJRD2vrhftqGwKFLy1qts1WCdhK/RZKTWIrhFhKHEo?=
 =?us-ascii?Q?tdguKDMS4kv07JmUiNsoDcpnIQoCOsoTpEoG52WKZP7JPq8kYP4Pi5lsKMcz?=
 =?us-ascii?Q?cHIQKNws/3CK2Jc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 21:48:37.5630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7062c7d1-b425-400e-8c05-08dd4baf01bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4489
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

Needed to be properly picked up for the initrd, etc.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index ba550c7e2118e..bbf16e7b5ab9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -32,6 +32,8 @@
 #include "amdgpu_umsch_mm.h"
 #include "umsch_mm_v4_0.h"
 
+MODULE_FIRMWARE("amdgpu/umsch_mm_4_0_0.bin");
+
 struct umsch_mm_test_ctx_data {
 	uint8_t process_csa[PAGE_SIZE];
 	uint8_t vpe_ctx_csa[PAGE_SIZE];
-- 
2.48.1

