Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B49D10F4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:29:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3A8F10E603;
	Wed, 26 Nov 2025 13:29:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="voUVhF/S";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AFA810E604
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:29:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0BcJn/ydN6+fHg3xZcVOitthi1CmfosjYURxP70mRYQPcf9phfz6vVyb9j5jiuDR9g1awV1VgJuYXMD/NZ7zYgN+txiSdc/c44/McdeucIrTeGanzYmna37M5NltUHljOoSZ1fLyOa+LsuzgU9T4NdbzO1Xnn6zEJ9m57pIY039cSrFk5Rwtanm5Fjan0aVy3BUyfigigHcEgsOaucv3L9cQY54subJUdjoXJ5buuTHjfxsro5bn8EElVcx3adZKSJYkAYXAMtLWqDen4trAklxcTfVil4NMJnxifjlJ8zSMrq6D7Vh8U+pqneVYA2X5HpqtEQliX2uQppiS4KVVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6PsB08bfSLnp2AVbrtIfcE5rU4a3KJ2ALbz9E4aWjo=;
 b=Bo3Nm0iwqdtKOSvdsa5h8cK2icLHKMXv511M15jHC9zxEz98ygH06BhO5t3GxDFR3vdtqNQcNX5YAs59yI6h31o1SLwq+WS6X0FgzzhvzxGeA2w4V3dDuquv+cKkA+rPAGWMrNMhdlsGfbL2Tpyn4upU/0gRI0Uu01QRUH0nZPrnl9xWTgEFiZSn430HefaZtg0t3gUWj0D7MDSb1ZBFQGYmomwUh5SwS7PawklGT9/WpeSWyYzAPi7M6BH7ttRUTbqjIXwzMS8YP/+RKzchl4r3qZLviqzbyr4fwZ1IXoXsjsNW3ciKNCJBcLXfKsWuwFMWehWIrsWNiHgV/38txg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6PsB08bfSLnp2AVbrtIfcE5rU4a3KJ2ALbz9E4aWjo=;
 b=voUVhF/SMuP9qk7R5JcMiPMYt1WTlGCxuMp7qI4GepI2OnYjuWA7LOR7ottmk+aA3lIwW3W9qiCnLQzXNkpPAPkbaJ5mABJvqBFAOOhY2jsSp/CvEPO7KVIxo1Yeqzi0d2/nDYsC4/8tuyVEsL++JBwjinhdJYy8XEsuBZxXbFI=
Received: from BY5PR13CA0008.namprd13.prod.outlook.com (2603:10b6:a03:180::21)
 by IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 13:29:13 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::2b) by BY5PR13CA0008.outlook.office365.com
 (2603:10b6:a03:180::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.3 via Frontend Transport; Wed,
 26 Nov 2025 13:29:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 13:29:12 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 07:29:10 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH 18/20] drm/amd/pm: Use emit_clock_levels in vega12
Date: Wed, 26 Nov 2025 18:54:05 +0530
Message-ID: <20251126132822.3266730-19-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251126132822.3266730-1-lijo.lazar@amd.com>
References: <20251126132822.3266730-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|IA1PR12MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: c574a9f2-801e-4aa9-c07c-08de2cefc9f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TFWgLPJ2XHGbDkbUCTTmR0VWN2ilWcmOrEt+6kIyzNCiKD2SMWmE48feqMpr?=
 =?us-ascii?Q?2ukahpxeqCIiwWWOucLQfsMjABPYqvJcdYjHfMgaOXyySUbHvENRm+/1SbMw?=
 =?us-ascii?Q?21O+d5f2hcCOJlcbP8ROOteGHGNqI9csPeKtEKVTJxMz3uUvt3TFk3sq/UfE?=
 =?us-ascii?Q?EAAZh4EbPCliv7w6HGV3s74UmS3awDQBVNHjMnJKoJzfjjZEsf0AMnw3kvkK?=
 =?us-ascii?Q?SzhH4SQUI1IQLo3skv1t+7H98el+Q3JDSgKK5Ka/DhFkPonwWKd7FnRs/TO3?=
 =?us-ascii?Q?y07pnRAH015LrdWTmlAevFSuYGF3WUspGhcNHoe1DbciLgIhDTiH5baVzlp3?=
 =?us-ascii?Q?yK+iLPMZxxtQbeWmWUw/GdgyQHQyCQaJuOJNz/aCXvGoTTerIiGdBvCPh4Md?=
 =?us-ascii?Q?qDAvO9pqmLmpVdvgSvoXLQbXyY08jdJy3DuCghLbsR/5jyiI8TmrgsdF9ctV?=
 =?us-ascii?Q?g+B1nNbVXFbav/XO0RxiHVMTubGIFI+d/XB8Gl9LGwBpMEX48pirfM5fQ4Qz?=
 =?us-ascii?Q?TbsS++3h7xG21w6NNK8HZE9nGxhvq8iHAENzSba0ZQUr0HpbMDkraGBH/SPw?=
 =?us-ascii?Q?+Syw7MAq7guPZVOt5rt4ZD8EmrwTKuxBJjka8Yhao83NZTCra6JxwpALWRpn?=
 =?us-ascii?Q?0/hEzSXOKCkzS33Oy5S0IHL2mT60wYH+EOpra7Ilq5UU20VlpPByLaSRP8YE?=
 =?us-ascii?Q?sxMrRWGxr79uvylUNJxtxS/463anmtZtlJXx7USOAmwScmTQkrTK3sgsqiYv?=
 =?us-ascii?Q?y4GIpe4pzK7ShwteJmUdD0qoyUPbKD2uv40UFf80t23cqMkmKfbFiucOSQnc?=
 =?us-ascii?Q?6mBAyPL9fEvVmH2veeAtsTXuXVJBdKzy25TOrhFFGn9DukbKW/fTUUEtj4bx?=
 =?us-ascii?Q?g8t80Rqv/zTI5isGf4vAabgonOOgloyeobm0/BnO5GiOLAZnG4Yk4+0V2b3Y?=
 =?us-ascii?Q?7zhADvtC33IA+J+IDVkOiW7DjALzTe6x4KVXp3S6Z8JQt8OYgv64TVPmp609?=
 =?us-ascii?Q?P+z6vPJBsLP8RTCpNudnnOQxPZzidif8qq/mQO9qROb84htVnN4F6yang1fh?=
 =?us-ascii?Q?3WnXcyI2KiR0vdNRLuIG8m6a8aTdYanBC2gJE28pFhFQQguHZIkHjOr6Xo5M?=
 =?us-ascii?Q?dSdQ23jKHCY2B2kkdhAkdMyGFUQv9fjh4I5b4xN4s+msWeCf5TghUYTJsDJj?=
 =?us-ascii?Q?dZ84RU5wRSy0BGBdHPdrebZv8wAQ4zH7hG5RmC7oX8CZe3NVSF7uU41mCiOd?=
 =?us-ascii?Q?Jn38rA/mRcRiHLP12Aped/2pc2TviJkcMh0xiF53aOuEFqSeS8bR/n5de2lm?=
 =?us-ascii?Q?TMUdsXpo4be6BVCFQMbhKO8Y4O9Cw+onJFRfwVo60wRegmIXBtzO6bHXqohE?=
 =?us-ascii?Q?Dw3fTc/x2hNdszzkj/k4doiAo9iqEot+eDUfG/vFoB6zo26TMyXiNmFYRtNw?=
 =?us-ascii?Q?4ZeibioJgGUaRsmDGFZchTLMYJO/NMJsgexUEa8OuDrXCPHrRlH+5tNqTJh2?=
 =?us-ascii?Q?pD42ZGayscHFD7uIPjE6z7gNK/g0tnV/xU7zsB/STovLDgYmBY1PjVUthEx/?=
 =?us-ascii?Q?Qye6mFnJSLkinh5ha98=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 13:29:12.8672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c574a9f2-801e-4aa9-c07c-08de2cefc9f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6235
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

Move to emit_clock_levels from print_clock_levels

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 52 +++++++++++++------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index 10fd4e9f016c..5a987a535e73 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -2271,11 +2271,12 @@ static int vega12_get_current_pcie_link_speed(struct pp_hwmgr *hwmgr)
 	return link_speed[speed_level];
 }
 
-static int vega12_print_clock_levels(struct pp_hwmgr *hwmgr,
-		enum pp_clock_type type, char *buf)
+static int vega12_emit_clock_levels(struct pp_hwmgr *hwmgr,
+				    enum pp_clock_type type, char *buf,
+				    int *offset)
 {
-	int i, now, size = 0;
 	struct pp_clock_levels_with_latency clocks;
+	int i, now, size = *offset;
 
 	switch (type) {
 	case PP_SCLK:
@@ -2289,9 +2290,13 @@ static int vega12_print_clock_levels(struct pp_hwmgr *hwmgr,
 				"Attempt to get gfx clk levels Failed!",
 				return -1);
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
-				i, clocks.data[i].clocks_in_khz / 1000,
-				(clocks.data[i].clocks_in_khz / 1000 == now / 100) ? "*" : "");
+			size += sysfs_emit_at(
+				buf, size, "%d: %uMhz %s\n", i,
+				clocks.data[i].clocks_in_khz / 1000,
+				(clocks.data[i].clocks_in_khz / 1000 ==
+				 now / 100) ?
+					"*" :
+					"");
 		break;
 
 	case PP_MCLK:
@@ -2305,9 +2310,13 @@ static int vega12_print_clock_levels(struct pp_hwmgr *hwmgr,
 				"Attempt to get memory clk levels Failed!",
 				return -1);
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
-				i, clocks.data[i].clocks_in_khz / 1000,
-				(clocks.data[i].clocks_in_khz / 1000 == now / 100) ? "*" : "");
+			size += sysfs_emit_at(
+				buf, size, "%d: %uMhz %s\n", i,
+				clocks.data[i].clocks_in_khz / 1000,
+				(clocks.data[i].clocks_in_khz / 1000 ==
+				 now / 100) ?
+					"*" :
+					"");
 		break;
 
 	case PP_SOCCLK:
@@ -2323,9 +2332,12 @@ static int vega12_print_clock_levels(struct pp_hwmgr *hwmgr,
 				"Attempt to get soc clk levels Failed!",
 				return -1);
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
-				i, clocks.data[i].clocks_in_khz / 1000,
-				(clocks.data[i].clocks_in_khz / 1000 == now) ? "*" : "");
+			size += sysfs_emit_at(
+				buf, size, "%d: %uMhz %s\n", i,
+				clocks.data[i].clocks_in_khz / 1000,
+				(clocks.data[i].clocks_in_khz / 1000 == now) ?
+					"*" :
+					"");
 		break;
 
 	case PP_DCEFCLK:
@@ -2341,9 +2353,12 @@ static int vega12_print_clock_levels(struct pp_hwmgr *hwmgr,
 				"Attempt to get dcef clk levels Failed!",
 				return -1);
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
-				i, clocks.data[i].clocks_in_khz / 1000,
-				(clocks.data[i].clocks_in_khz / 1000 == now) ? "*" : "");
+			size += sysfs_emit_at(
+				buf, size, "%d: %uMhz %s\n", i,
+				clocks.data[i].clocks_in_khz / 1000,
+				(clocks.data[i].clocks_in_khz / 1000 == now) ?
+					"*" :
+					"");
 		break;
 
 	case PP_PCIE:
@@ -2352,7 +2367,10 @@ static int vega12_print_clock_levels(struct pp_hwmgr *hwmgr,
 	default:
 		break;
 	}
-	return size;
+
+	*offset = size;
+
+	return 0;
 }
 
 static int vega12_apply_clocks_adjust_rules(struct pp_hwmgr *hwmgr)
@@ -2951,7 +2969,7 @@ static const struct pp_hwmgr_func vega12_hwmgr_funcs = {
 	.set_watermarks_for_clocks_ranges = vega12_set_watermarks_for_clocks_ranges,
 	.display_clock_voltage_request = vega12_display_clock_voltage_request,
 	.force_clock_level = vega12_force_clock_level,
-	.print_clock_levels = vega12_print_clock_levels,
+	.emit_clock_levels = vega12_emit_clock_levels,
 	.apply_clocks_adjust_rules =
 		vega12_apply_clocks_adjust_rules,
 	.pre_display_config_changed =
-- 
2.49.0

