Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807E9CD5BB4
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:16:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E7D210E4EE;
	Tue, 26 May 2026 07:16:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KLohUsGA";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010058.outbound.protection.outlook.com
 [40.93.198.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C740F10E4EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:16:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Da185/m893Rote3lK20+vd3V0ZHebS25vgMqjXrU6/+H2AMgwS+Sk7dLkFry7vE1SvG63ao8hiYVQwZXB0s0gciDJg1X/FzcWPoPIw9Qaf76015o0NAjmpDdxVR82YpHP03O7PWIZaxP7KjVjjVHrCRnD9ZJl6tyN6hToPP78kDWXW0vPAFm9zNcln6vi4DjS6YyGgaCupPVYR4MdF4YDcY9ryt8c4XuVUT6LImmLYN8Bjy342WZ8jrLLq0+0e4x4Eb9FVg4m2L1ZS1uoFgAGIw+xpuqCz40NdztdxlktcZuVIDRNq6nt9ViZBqysWzqB74Zi9osSqZZkHbeDMJC4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3JEqhrN8zAJmz4VVwpAd4GoOWWDOVtiTnU4piI8yaM=;
 b=E2bpYHiAbXj4qZYU55U364qpSTWIzsPaqzhPzKHiIbPjKvlFS1Sy/3B3+BoCaTH6Dwd5GmmG5NOeXLFCBlo6jBqh3UvFjHt2mJ6g6+5hLNgP7LV1cVbPqvFkO4ZF0nTK77Xzg+eJOGdRq39RW+WoYsJnrKaZKFs0zfGsfJSR/U8nkbCM/0HZcfHA535+ZFpEABL5nQW85Y8YsSosdV8qupN1CxS3br2RTU+A3oPUzm222Lx/nIt/6nE5D32vd5Rsk4b+GhfUcFXj6sMiFSKVpbvhJGsiVerGbGLUK5Nm/LdtYv+WXATHiWFDC7jVqEAG7tzmU0pVaI5y9gBOTD2UIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3JEqhrN8zAJmz4VVwpAd4GoOWWDOVtiTnU4piI8yaM=;
 b=KLohUsGAzNJmmp/tamNJempBxXmx0qs7bFKl0Z+0TwMzxj76XCnCb+oWIFjFHpOk9igdpwYT2TIJDvu4JVEzxoSuYSe+zeIPDgrcCcJCvXUMbpx9+lgYa90wEQyAWcUyNjk+HCysQEfWdogySu1Df9LNhB7LB1TbuIjnHAKE1Vs=
Received: from PH7PR17CA0038.namprd17.prod.outlook.com (2603:10b6:510:323::17)
 by MW4PR12MB5603.namprd12.prod.outlook.com (2603:10b6:303:16a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 07:16:41 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::5f) by PH7PR17CA0038.outlook.office365.com
 (2603:10b6:510:323::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 07:16:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:16:40 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:16:39 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:16:31 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, <stable@vger.kernel.org>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 16/41] drm/amd/display: Reject gpio_bitshift >= 32 in
 bios_parser_get_gpio_pin_info()
Date: Tue, 26 May 2026 15:01:39 +0800
Message-ID: <20260526071413.2181251-17-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|MW4PR12MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: d7599983-5136-4975-bf81-08debaf6bb7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|22082099003|56012099003|18002099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 8f7b8DRF4ObYPY61M5zytB4AVJG0YWB0sXo7GsMHA2E1MdptFN9JIryyqx2HtybkgrFcFG4ZFhe64kKrt/7h0ZKx2uQ2XV2QxDZynw0lbLqnBC6qh9fCUWFJSGBrfun47CWMwElKhz3V/sNZtLyxUSP6zuzNX5HKw2fMVFOFolHbHA1xoLwQYJFCaIzLtBya4Ye6ag9NlWmeIHeBO3QnT14AejNPOb9U/LcoaUq5kat/kIAA4Zye2PvqQD0HIoLdASXAn4BmI0iWgdhZzzhd/Y+3z3Y31SMRwN7qi6YUkPkkXlDNGlCaEHHOFG+A15xhDSAc5w98d9ucyfw9IJkGLIi0Lo11wo4oSa8rAvooB7Kw3IGC8mhhLK4UkNuuCPyNigCqF+zhTN9jsXEJsHyjbrZipuOr+Mwye3O35gu1ckuCNhcqX4CUAO8t+lFzO6+CQwuknIIK5U9CrX7aFdzyLcJtMKIRCvF1CSVYvUlGikYWWuX8P1o3j3FQZpEUUB3kykHxKrreSyPaA7sXuWoksamAqvVJmIlF73Vk+LtLLXLA2QdHj1F/L7isn/487l+SsO+3Lart4TuUBUS108gdcDg1adm7IygGTcZ5vuXqKa86DCpygOdoUJvdQEDkgVje5YgkpMhH3/YjxKC5rdiMZVYFKXIN/IXt7MfQfkonyPVNX0XhcIv24vuufHb8/tOpjce2J0GptFf2wdvrrk4uqb+9ii4W5DBQ2h6RAnqER80=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(56012099003)(18002099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6C+Ij5A9ATkW4ts+FT7pLF1I7TkCMyHDlUTj2X6eh90pIBN2AGiRZNq5fgrD5Eu4Q7Xkl3I0uwIRqK39CybMGgpKBQiv5Bj9XFP4CER4oaUQJlMVFtzpYrQB30Yyl/nBrQgtnbAEwioyaNtR4PuMnM5wbmRUcw6VIlY0clRkB4kZem3qqKSfVPZsS36vNggRF/tSF5bM4md9PL0gintnasKpOsNsJMFKryOj4+R2SWejj+96pwGJZ4hEziQSOx/phvOWoP86srrUiaSQV0Xz6QSxQGwcBg4Cj8dsVVq3Z22Xfeqwg59cY++84u1ncQMf7h7YFlFz2WLNHyX+fk5i+RuQ+VFwRUlXAAPK10MK3rJklbcmVeQsfDRMgs2CxvvpsvJJBSHAIGFEY6EZOzQqgkGfBMzMP9yl9zdczmLs2HTg6y44+/D4YdP+08DzRXEo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:16:40.2955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7599983-5136-4975-bf81-08debaf6bb7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5603
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

From: Harry Wentland <harry.wentland@amd.com>

[Why & How]
gpio_bitshift is a uint8_t read directly from the VBIOS GPIO pin table.
If the value is >= 32, the expression "1 << gpio_bitshift" triggers
undefined behaviour in C (shift count exceeds type width). On x86 the
shift is silently masked to 5 bits, producing an incorrect GPIO mask
that may cause wrong MMIO register bits to be toggled.

Validate gpio_bitshift before use and return BP_RESULT_BADBIOSTABLE for
out-of-range values.

Fixes: ae79c310b1a6 ("drm/amd/display: Add DCE12 bios parser support")
Cc: stable@vger.kernel.org
Assisted-by: Copilot:claude-opus-4.6

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 6cbdf356b1cd..9fb19f75e934 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -701,8 +701,10 @@ static enum bp_result bios_parser_get_gpio_pin_info(
 		info->offset_en = info->offset + 1;
 		info->offset_mask = info->offset - 1;
 
-		info->mask = (uint32_t) (1 <<
-			header->gpio_pin[i].gpio_bitshift);
+		if (header->gpio_pin[i].gpio_bitshift >= 32)
+			return BP_RESULT_BADBIOSTABLE;
+
+		info->mask = 1u << header->gpio_pin[i].gpio_bitshift;
 		info->mask_y = info->mask + 2;
 		info->mask_en = info->mask + 1;
 		info->mask_mask = info->mask - 1;
-- 
2.43.0

