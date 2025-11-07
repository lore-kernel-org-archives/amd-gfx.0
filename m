Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44246CCFA05
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 14:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9842210EAF0;
	Fri,  7 Nov 2025 14:29:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pd/QSaQy";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013019.outbound.protection.outlook.com
 [40.107.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A674710EAE9
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 14:29:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCbZjUGpOzoREKBRBlzDA/l8NChLKRpGHAzKGWYVtzAnwmKdnJdu3qRg3LtPxXaTSr6QpZPhisc73bh4f1V8ysugPjwX8hsTt+kCbqQmAaLl37OxdgmFblLUZ7B9DaInkOH1AQe/EtCyNGJk0boHosktV5mpTqnnzWhEkVPjpKDJ3FEIQ1Vv3nRrzgIkiuLeIgGMaEYmWnlpAbh48TfdySEotwJyute9kwyUnQNSPMFkD6C5k8DxxStNbkDAab7eLqjddMMUHniiZe5ypwHEQOK7X/E7cZcoK5DcQ8dEUwTIykMoLCP6Oc0g7MI4F/ujBcZzp8Wl+am+QadkYwxAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k00r0I0YSPvhtEhn6QeBlggp3BuK2g8njGgwEbJYUZc=;
 b=LVnqG/1jHULbH21IKwISc9+HIHZnyKcekLQmc+Ul8V/Si/hkgI8ES3uiR1CB2EB8DRz4ug4vpWoZ5s7oy57/xbWqnAHMEK0VSoL2Gp+dTDtwghJp1Azs+Xq9mevJ2K+30L8a6IAGYmNZMcwNBgLNx5e1mYC3MH959wkyiFq0CaWVXSn/Yxri2C4SQThMjFaqwK/OHnpJLXdIK20EL0AfXUTKMc3ANW1Mb9ZY3vJ6Jn3ypDuuWRIAijcWCZIgWjeb5VUQS1ik05+nwspw4GrIS1lfWKHOpnOQKluCQ+ERSGVWcHaGIeRkM20Ivgd3gangMXczqmddtIufNPJFrkoHpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k00r0I0YSPvhtEhn6QeBlggp3BuK2g8njGgwEbJYUZc=;
 b=Pd/QSaQyFujZYvxdll3NtrqLLLdjxZLFSlESsQQMAVezAB71wOU8WYoVovgi4+xY+p8lctBzmF+fHNUibHyG3MNX5yu4pDZUH7mdiZRMrQsJX8b2v6zWx772Da5Sf465rDqLeZkBTPzwB5yuucgKxh8k3onnlyPql9obzY8eVZI=
Received: from PH8PR07CA0032.namprd07.prod.outlook.com (2603:10b6:510:2cf::6)
 by IA0PR12MB8277.namprd12.prod.outlook.com (2603:10b6:208:3de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 14:29:51 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::f2) by PH8PR07CA0032.outlook.office365.com
 (2603:10b6:510:2cf::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.13 via Frontend Transport; Fri,
 7 Nov 2025 14:29:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 14:29:50 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 7 Nov 2025 06:29:47 -0800
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Harry Wentland <harry.wentland@amd.com>, "Tom
 Chung" <chiahsuan.chung@amd.com>
Subject: [PATCH] drm/amd/display: Add kdoc params/returns in dc/link detection
 helpers
Date: Fri, 7 Nov 2025 19:59:34 +0530
Message-ID: <20251107142934.3058349-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|IA0PR12MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: de3d7f45-e5c9-45e3-400e-08de1e0a1c18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u/LugsfXACjSosPg/LIMEHUYtEH1SEmHCUgQ6FpZwnS/3i8crkOfFhLiuSRM?=
 =?us-ascii?Q?ZP7yPUkXiIO4aZ9wWTUTyroiDDt09V/nuomj8kbOMVfwjFUCTk2ooPyOzsgq?=
 =?us-ascii?Q?W+kgAS2z/B9wb/vX8+XzFq3e3qpGsQ+mNoYoksCwe9yq83bgLaD+x54m3u5O?=
 =?us-ascii?Q?1WLxn3Z2ddEBRBgXTi2XLdFcp/D0PHpAcq19YaCsfAZsks1oWYIucMwQqf4G?=
 =?us-ascii?Q?y84EBV3owakNIm9yjztGjDDq5ESN9qbkxBPpfkZTurFIHVOMxrXKcj17WFha?=
 =?us-ascii?Q?TqMH5+WScfDS+f3caCJfVDynVizvnkt28r3EPMp9+oNlaj/Xrcm238Mqq/H+?=
 =?us-ascii?Q?94lHADtXToZrag3COAwZghjXdR11T/xY0WrfQcd4RYB65Ny0XzTNamP+gfje?=
 =?us-ascii?Q?HvBTpHeSIkI2nTcBw1koNx0B+Sozc8Vj2/NMlZ4rLc/JLTrO9n1KxzNIirP0?=
 =?us-ascii?Q?N3br8ho0MwgTvO5HxIpxDQyuvpqJx2337Pdb1zC0sjA1R0UQg3c0DKAPRreD?=
 =?us-ascii?Q?2+nbmHPykB/ZzUm/fnqHCI3MMA1EolyLyMkqMTl03clmrZ/csy4ZqIsBIxZ2?=
 =?us-ascii?Q?NuKuvKLZR4c8ZYWFbKFATdxUo21zq6973/KSkclSveUb8YqUa9zouSpQ5BGH?=
 =?us-ascii?Q?URuEjqhmeG4Cc6hJxNzmEUffqs3K+oeCuwUSvLPAWuhj94GL9BjXiOtgEapI?=
 =?us-ascii?Q?e1LZz/eNr5PqFd9uwOkFEcwiZgxALEExrgKgGAyHTmBtP8bgCRAJD9H07/xB?=
 =?us-ascii?Q?zG6C5iEzRDXL4ztOC3kZuVHlDmcDW3GCsJllfx6Pc/MLpNvCc9PnaKjRV42w?=
 =?us-ascii?Q?CXtTb0eSt73tEn0W/XLtVU7RM4Ra6QfYcP6z8O0TO6JRcvy8ovZfdKkj1fnt?=
 =?us-ascii?Q?Lc7qPJ7RRpUsz2e7A5+eqm/JdnEddZ8fQr2e4gxfPJLe6ss6uJx4aTLkxR1k?=
 =?us-ascii?Q?7Uks3uWOwd0+JwoSyuKmDELXJLSWqwVVY87oc97cuwdOvZXwLK57KuHrdsoq?=
 =?us-ascii?Q?7+D05tAu4kTg5ZCaR4oQk/nO4m9A7dzaCHRYga3zATJz94vqNY6HJFnG3O6q?=
 =?us-ascii?Q?YLtfJBTG12rpnEOIT87McdCgjySt33vcPIn9tq4ZoIo4d49X2PDlTVQjVXn+?=
 =?us-ascii?Q?q4jRk3fmNQlEVvfK2KJgzSmipYIGpbUl2FYfrWj44gkpnU0c6ukuSujKDFHx?=
 =?us-ascii?Q?i/mCabnk6Eaal/LJffUcQDhNbg8CX03h+qRu13sKIlCJx29UMAhBvfNSKW12?=
 =?us-ascii?Q?HMsedYHyIdWi3MjedNqf7BzG+NJcJpnzfg9kmb7Ehr3xPxVDBDeSBMmKGG2r?=
 =?us-ascii?Q?KWJAhet0OxwzIwYm1TTusM3dKz7m9A1nUuDZn2x60SYX7Zy1XTFPnHgO4K08?=
 =?us-ascii?Q?I4oh7QKItWxxRUz0JAs9XWCqBU4dj41cciHdxiUeBq3JAWJ0zih+jZiCrIel?=
 =?us-ascii?Q?hKUQ/TuwKfpwgkSU9yLQN3tC4vNBCkLiJEkiM8A4NqRAulHryF273yFGpfiG?=
 =?us-ascii?Q?siJ28u8G/Gl8eSr4P3QQkg4cFeCxDAEsewtKmtxYoP3K+qCFyY308ECgEfbQ?=
 =?us-ascii?Q?7M+jRa59sfr8MmmS/RI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 14:29:50.2174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de3d7f45-e5c9-45e3-400e-08de1e0a1c18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8277
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

The link detection helpers in dc/link/link_detection.c were missing
kdoc annotations for parameters and return values.

Fixes the below with gcc W=1:
...link_detection.c:872 parameter 'edid_header' not described
...link_detection.c:890 parameter 'link' not described
...link_detection.c:914 parameter 'link' not described
...link_detection.c:1355 parameter 'link' not described
...link_detection.c:1355 parameter 'type' not described

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../drm/amd/display/dc/link/link_detection.c  | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 5d287874c125..d163360a2bf6 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -868,6 +868,11 @@ static void verify_link_capability(struct dc_link *link, struct dc_sink *sink,
  * Evaluates an 8-byte EDID header to check if it's good enough
  * for the purpose of determining whether a display is connected
  * without reading the full EDID.
+ *
+ * @edid_header: The first 8 bytes of the EDID read from DDC.
+ *
+ * Return: true if the header looks valid (>= 6 of 8 bytes match the
+ *         expected 00/FF pattern), false otherwise.
  */
 static bool link_detect_evaluate_edid_header(uint8_t edid_header[8])
 {
@@ -886,6 +891,11 @@ static bool link_detect_evaluate_edid_header(uint8_t edid_header[8])
  * Detect whether a display is connected to DDC without reading full EDID.
  * Reads only the EDID header (the first 8 bytes of EDID) from DDC and
  * evaluates whether that matches.
+ *
+ * @link: DC link whose DDC/I2C is probed for the EDID header.
+ *
+ * Return: true if the EDID header was read and passes validation,
+ *         false otherwise.
  */
 static bool link_detect_ddc_probe(struct dc_link *link)
 {
@@ -910,6 +920,11 @@ static bool link_detect_ddc_probe(struct dc_link *link)
  * Load detection can be used to detect the presence of an
  * analog display when we can't read DDC. This causes a visible
  * visual glitch so it should be used sparingly.
+ *
+ * @link: DC link to test using the DAC load-detect path.
+ *
+ * Return: true if the VBIOS load-detect call reports OK, false
+ *         otherwise.
  */
 static bool link_detect_dac_load_detect(struct dc_link *link)
 {
@@ -1351,6 +1366,14 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 
 /**
  * link_detect_analog() - Determines if an analog sink is connected.
+ *
+ * @link: DC link to evaluate (must support analog signalling).
+ * @type: Updated with the detected connection type:
+ *        dc_connection_single (analog via DDC),
+ *        dc_connection_dac_load (via load-detect),
+ *        or dc_connection_none.
+ *
+ * Return: true if detection completed.
  */
 static bool link_detect_analog(struct dc_link *link, enum dc_connection_type *type)
 {
-- 
2.34.1

