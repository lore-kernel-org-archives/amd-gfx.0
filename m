Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049C2CA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 13:36:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98DE710E711;
	Tue,  2 Sep 2025 13:36:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n/GzSQef";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5F6E10E711
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 13:36:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIPiSC6SvXWNBzdoZXAhjsxHJqaOUiZD92eqJ5B5aG2m+s9sWqU7PSTrlOIajeeM6nYLG+YiYYSajkF2K8DldINlucHsNFY7YP+nYqK5mxVPgKHxBZGuripvgQ4G8V7dHER0Ekj/PxnBeXvBeSGR00FUcGOmDYDpWrbb3l5n6LRGg7B916EdCk3anlGff8a9ppIIoRDLQb4S7sebBrF9gIXa1eZ03iXRl0ELCc8/oRABymkgj4VtTs7yo/95M2oedZDDMjEkRyPfwAnjTIhsRfYDFWMZrUWKDqtr8wYj1Tsp6+hPKh56NCP1ZcU2pxqqnE6+vAa6UvFMFv1B8jFndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3obT7bYTnJXEpMcMmEVaSrJw+bXTzumqa++2jBCfQb0=;
 b=m23BlXIKC/vH195kAlH40WhgNf5uMQiZGFbHPM603yQBnkfuIjZjOybtRZsV5xbiS5gkeuYlUDndTz8h5jzx7ATpiZTqmu5kuWUg9NmBEod0uHsxLZKFwLWSuz111RXnPe8SHcTbDKzoDhjbb1TAVo10tj4nt6pmgZ1PksrxQZFTg+0pbQNFoQAdwwO8qgm8Ony1ZsWmU3Nltsm56SyOONVdy72Zo4xxHpUNd5td+83BH2fj1AxXgBPCa8HUTxjK6//b7Oy/Vkkwo8wNxkUVYwhyoT8fto2CIYaFDcvpVi1guMnrQl0WloKM0al4bZ+jOGk/xARcWf3KhEItAvyhTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3obT7bYTnJXEpMcMmEVaSrJw+bXTzumqa++2jBCfQb0=;
 b=n/GzSQefTlLqXuTRNHoJrCfIM5wDmWb4hY+SkrtTyyuU3LSPnTl0NYi9kVPybb8E2vKuq3VxzHVbqNDH8JfvLpsE1xW8Zj104sA7o4V+D/EcmErwIMJ1QKNN7XyNnv2x1oBagUrzuLeIJXfQuild1pAgM3heGkGe6t/ZPM1tAYE=
Received: from CH0PR03CA0423.namprd03.prod.outlook.com (2603:10b6:610:10e::6)
 by PH0PR12MB8174.namprd12.prod.outlook.com (2603:10b6:510:298::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 13:36:10 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::e9) by CH0PR03CA0423.outlook.office365.com
 (2603:10b6:610:10e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Tue,
 2 Sep 2025 13:36:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 13:36:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 08:36:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 08:36:01 -0500
Received: from jzuo-laptop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 08:36:01 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 8/8] drm/amd/display: Promote DC to 3.2.348
Date: Tue, 2 Sep 2025 09:33:37 -0400
Message-ID: <20250902133529.4144-9-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902133529.4144-1-Jerry.Zuo@amd.com>
References: <20250902133529.4144-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|PH0PR12MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: bd527f2c-3a14-4a6f-382a-08ddea25ad5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b1D6gackOej6U521iSOxSj1zGItVOLGA0nAGMZnb9E99CZmk9reeA6tB+kYu?=
 =?us-ascii?Q?vM5OxQ95SpBE7xEwaNSjlhvLx+GpIEAgyGRIcdol5Q2R4fLEf7Ok6emVGZ1K?=
 =?us-ascii?Q?qp6fPtY+zmux3Sg+bqOxdDO9XdrQw2suWE1iPFhHTB90SzjS1PlqbnKPrJZo?=
 =?us-ascii?Q?nEiqpLFzYeYnIKVv1pHJ53bQjohcbe3eVQTJUwujJLLCaTksNyXW5NR+Btzu?=
 =?us-ascii?Q?6BYaoHTy39iBXyU44TaiNPPZ8j5CUsuEo2AwLqOeciluNg8kMTC6C14DhhXs?=
 =?us-ascii?Q?yaJCY0wn1h2urQPD0nLkSXF//8n8arY4i4xv4pUx8nilNgZZ5Mu1nmseOKCx?=
 =?us-ascii?Q?BA6GJeqZwbVQIBshwL0k8E6hZrRtZWN2QsNGCNmyKBpmsRedop/Yixd4tDOC?=
 =?us-ascii?Q?NpOKsbjE+28bzWHvwawfKxixO5DC9E1ClA80qCrzUVVEe0308vNbhI2UWdkz?=
 =?us-ascii?Q?+8gGw7oJk3G96+Wd/uLnUk2B/lz3FEtzVWxZBpGlFZJvC+ZMUvAUuRORAp8/?=
 =?us-ascii?Q?OEYrtpITzp/4hUkzaIj0vufp7DnmuRbDVxrC96Ptj1NfNHq5yFuGr45a2DH0?=
 =?us-ascii?Q?P5lZ0C6uZ0K+bWN0POFGp/rjoP2xE2ECmpxz35Rpe5gmzzpfG7WJtwEmXmLI?=
 =?us-ascii?Q?Wp4jysLyoMl8zDees+NnJKPSQCCXF+uIBR4m5zbLH6vEErM6ZeRcWntFAdol?=
 =?us-ascii?Q?MnvfQzwu0B6U32t6XwV6R0DDkpAHHAtJEEP8X8fyl8iDiHY32jpMgsFU5URA?=
 =?us-ascii?Q?LEEigBizN7dQF/uJzLseizH29OGooi0cB20zwVRpIP2bpxdDC74YgDihGb3w?=
 =?us-ascii?Q?3HvTapY5kuPPhWCqo/4PvW9PtJk9+eVlu+CVUNg1Cq4U1bgixZk8UvCGvm8d?=
 =?us-ascii?Q?rdgv0DZygRvTmawv8Rr23vmRGCTpJ83NZ6DoJcl7S9CFZBdh4M9+pEk7CtLr?=
 =?us-ascii?Q?Pb13G7An4as5F976OvbXVxIC02UmEkYbun+WGSsZh3eteeDoXvNNcaF/34YM?=
 =?us-ascii?Q?+/AqTkCGgMdUgCWnUHTJzXIsBwX9jSxjfnz99lt+mANX/ti9ES5gmefTgI4u?=
 =?us-ascii?Q?eyqC/z6ZNXK3uMv4j9AIJxVWSc6x9veBiDDdi1bCBZBByEOoRit6WHJkUBxu?=
 =?us-ascii?Q?k/h9fXK4BOA3CVwrr054VmT5jF0hvshnk1l0tKY6krOKF5i52qpQn0ab9Ivx?=
 =?us-ascii?Q?ctnuFb7gB5rRwT2SAHhVEZuKJY9RyXy6AYy4kL17MApcn0+KbA3CPV6nSPuF?=
 =?us-ascii?Q?kTfNhDNlAvPiKvnpMQs97c1WuMKaUZAWu95TMC0q72eSyVvWKMp9RVFiXMDu?=
 =?us-ascii?Q?JQC5RX27CIlKTO22MQsQLHdDCHsGSMD+LlBlOH1k801yT/7BgeQPB4qTspVt?=
 =?us-ascii?Q?Z86VZm42/rFi+tstBl90dPVFdaIkBow5e45c/ATFR8XTd8xfuEwTZfGg4rF7?=
 =?us-ascii?Q?HAuideSteI9QxQQNT5g6D5fFaGlJUQ/XdUi3e0Xt8aM5Cc5rLMuXqLoj1B8f?=
 =?us-ascii?Q?iIVE/btfRzNeYOaD9sNuIWGj3ne5KMMJNtS0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:36:09.9111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd527f2c-3a14-4a6f-382a-08ddea25ad5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8174
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Summary:

* Refactor bounding box values handling
* Fix incorrect condition to fail dto clk calculation
* Skip check downlink setting for a certain MST branch device
* Fix double cursor issue on dcn314

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e81b488cd72d..b41e66c31e6a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.347"
+#define DC_VER "3.2.348"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

