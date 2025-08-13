Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE02FCA0EE0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 23:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EA5210E7E5;
	Wed, 13 Aug 2025 23:27:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PkMo+ClR";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 058A210E7E4
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 23:27:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2vtJxrfJyFaoNdZUEmCZU/XskuMySqW0IpDa8b8bSj3dzXdJRi544/elETU/8AZLGL38l+iZiblvnRWwEIokKEi3HmzRMmRODHXEMdsgI6c0LNNmWbxXbVV14x3/TTX5YCEpK8qvoeIv4fHU8nslmDlPH5wWqhmyC57uUC0ZrddQX81Aae0tlQ28esRE4o+hyyIPNUaRlTrGaQlgvXu62gZLymEEzdcMLKX4UPvaEO2/iZhf3k7RI0RyfebJsHmCslI0XlVvrJOYubZIYsZtRlyO/Ek39Y8jA9BQ8uenZTGiMbbCCacshGp7fXY1JhkYhB0NixsIebUMD7YdFyEDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8DvEQYAwrzBgxs6z3k2cTaIY1sc6tzkMxELNnrKpUQ=;
 b=E8bk5gRe0XEL5binl1M823Gs6iO4MRji9I6HuFe9cO/C6hxEoSXG4+3eLa4Q/OLMjdt47+qAkr14G1s/7dnJAOn919MrFHACCao3EdEjZfRi9HJ60QaVsuaRdLhvx97qm0wFt+D3GJmP0PvkMunkdh17dkTQm97EPw+9T1SF9one0rdCn0A0HUH1j32+EfRKyw1DVaIMvIUBMhakZkw3xsIMQbZm8QyNDnIr0sRf3Zu+jOM1Y3mCbg/XipydKmO2OvI2KuY0tvFZdtHQvYamCBKFjYf1SBJlpyciy2daXC1GtAZNVccow2TyQqSRSCeQXgGEkITVjxr9WAb/e7+HCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8DvEQYAwrzBgxs6z3k2cTaIY1sc6tzkMxELNnrKpUQ=;
 b=PkMo+ClRXk80QQWI3ayia8BvI19tJ5CgFpNgkq3uQ+uWwMLIl1c0l3yy4O0ibHozefQXjpiWxVpxqM5vLPMN5nSneDh8KmzLsLZo5CCZ3A8LrPLKLbteH6iQXQ1xh1FVl3e1D9NbTrxyALbZLNKiP1VQu4R5V/4+SY/kF1VmkRQ=
Received: from DM6PR01CA0020.prod.exchangelabs.com (2603:10b6:5:296::25) by
 IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Wed, 13 Aug
 2025 23:27:41 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:296:cafe::a9) by DM6PR01CA0020.outlook.office365.com
 (2603:10b6:5:296::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Wed,
 13 Aug 2025 23:27:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 23:27:41 +0000
Received: from SATLEXMB03.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 18:27:38 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Rafal Ostrowski <rostrows@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 05/11] drm/amd/display: Align LSDMA commands fields
Date: Wed, 13 Aug 2025 17:18:13 -0600
Message-ID: <20250813232532.2661638-6-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813232532.2661638-1-alex.hung@amd.com>
References: <20250813232532.2661638-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|IA0PR12MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: 01468cfe-01f4-41cf-41b5-08dddac0ff7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UJ1fsDrnkE78sguJdsPBLF4XbgLHIMY0CLD08uHqyDc8JR+H1gTVRx5pTkYx?=
 =?us-ascii?Q?CQTXV4UwmSvvEC6V74VTtohCl1CBY4ey6g96fZUZ5T1+O+VNC8C6NkLWcVUm?=
 =?us-ascii?Q?LtpXU2HnpR/dUdyiBggiYtggpLMu1RtZVwNFhS2GZUpVKvumT7UnBJtBUvI9?=
 =?us-ascii?Q?dDQHNcGFA/YO0T1PaTSmPLqpqPxpG+TTvHyHYf6nQU0SBt4PRFJJyR5Il8u/?=
 =?us-ascii?Q?aG6nWuJZSW0hpCspKEvt/EhSz9LSDMQ66p3CHHvo10hwQIfJTWLzIxMgIUHC?=
 =?us-ascii?Q?mN2armnptWGPsBhGGGhTOwKFwfYQaI+LgL8jx20ElivWPZXc0fxOi+eRr2wZ?=
 =?us-ascii?Q?lbSGlA9l2LwKAcgcGuTEyUHlmISDBjOxGM/dUIp+LUJCe7jiXsTG4GNa0gRG?=
 =?us-ascii?Q?cH3YI/1HpGzHdvJDdb/yNJiRqY7uYeEFwca0xAbwpCkw13J5yWeVdW3XlIW+?=
 =?us-ascii?Q?ykCH50DOfrSWZS3IToBzEEAjP7iPtqHwyKRgnYQo/rxiLXgwrgV3gA/1kagg?=
 =?us-ascii?Q?uf9Go2cVVKpLmtC9NhVuzicENLOzbiOklaQbyX8Efc5Sd38DnxS7GkUki7O+?=
 =?us-ascii?Q?FMYyAWWPXh/snTJWwnHmXm3L5DetNjhv73LeQLsH0+W5eTfy+mFfjliP6zWJ?=
 =?us-ascii?Q?RPFzMOGdmX57z7u/A4ZNpdXGx97UbZuk6JhI/Tf2UXPZDjDjWrRC+rVdebz5?=
 =?us-ascii?Q?ac2JEZ4Rk7Lf1uvzI/f7e3vN2CM4jG8GpRtnDWCycNhcXYj/dYgcovF4o/Ob?=
 =?us-ascii?Q?3qgDbBeF1SkQZ6NwC+iP/Vlpb1TKFpmi5zqEdSjGeRWlcFwGtzFEwsdShWjI?=
 =?us-ascii?Q?oniZbyHmWMTK6WfVNcpMNe/X973AYu3Dnhy4T7jUcesDOv2mgXJWdKDbQpMJ?=
 =?us-ascii?Q?9N81EMy8kV1nkYx8HWx7nSuzvGZtasBLjg/8Fqc/o8e1QmXgs8LXYZ2Rrb5F?=
 =?us-ascii?Q?76AGgXcYb6nvpK8+bcRT5iJiMGCKO4qjA17yFGkouA6d9SOB2j6OLJUJISXc?=
 =?us-ascii?Q?qvBLhPkljiFb/kTgdqOLIE06lGPimg2NS26LQvPrSDCVxr1ab0Lu3e6bhD2/?=
 =?us-ascii?Q?rgge4iJ+4AqdBqtbXqh7P+e1h3/LWxsvPN1on4ceabvM+6GPlL+XbnTnNa+p?=
 =?us-ascii?Q?WYnuLuornCqNbyEW+s8QxFeZlPZPsmOuFSGCZsSJLEo6X7StMcIyt46qE2jX?=
 =?us-ascii?Q?Fbqk/ZSnvN1w+Y9FV7kca+GF1me8aYO27cYb7IPEjfY8lu6cdEGJoHmgRXuz?=
 =?us-ascii?Q?zzaNNt+WOV+VcDu3VchO8bbxQL+/s2EeEvA3WMD085JyqnSaW2SQ4eFAMkeK?=
 =?us-ascii?Q?4NfoxHDRM1y4vXALL/MZ9lh30YaO8VZsUj9Fja69muQrzWQ05xaScyuv2e6I?=
 =?us-ascii?Q?cX7/Fiz9Sm5/75WuyuifY86V3Mhi2iZLQ4Hh/gq4Yk1ftS76qMlL44/fxzCl?=
 =?us-ascii?Q?97rTb3koOmPgddEPCfjHX/9fnAmQKjcTfDDMKCK80tlknN5PLqKXvbVwWrcv?=
 =?us-ascii?Q?YDxJsSKaRS/OjxyRdy6VU3XT0JVBMArQE9Qp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:27:41.0581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01468cfe-01f4-41cf-41b5-08dddac0ff7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7601
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

From: Rafal Ostrowski <rostrows@amd.com>

[WHY]
DC LSDMA functions had to remember to extract 1 from several fields
to be compliant with DMUB LSDMA commands interface.
Now this logic is moved to DMUB.

[HOW]
Moved extraction by 1 in several fields of LSDMA commands to DMUB.
Changed DC to not do it.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Rafal Ostrowski <rostrows@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 24 ++++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 55b362196612..53a088ebddef 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -2066,16 +2066,16 @@ bool dmub_lsdma_send_linear_sub_window_copy_command(
 	lsdma_data->u.linear_sub_window_copy_data.src_hi           = copy_data.src_hi;
 	lsdma_data->u.linear_sub_window_copy_data.src_x            = copy_data.src_x;
 	lsdma_data->u.linear_sub_window_copy_data.src_y            = copy_data.src_y;
-	lsdma_data->u.linear_sub_window_copy_data.src_pitch        = copy_data.src_pitch - 1;
-	lsdma_data->u.linear_sub_window_copy_data.src_slice_pitch  = copy_data.src_slice_pitch - 1;
+	lsdma_data->u.linear_sub_window_copy_data.src_pitch        = copy_data.src_pitch;
+	lsdma_data->u.linear_sub_window_copy_data.src_slice_pitch  = copy_data.src_slice_pitch;
 	lsdma_data->u.linear_sub_window_copy_data.dst_lo           = copy_data.dst_lo;
 	lsdma_data->u.linear_sub_window_copy_data.dst_hi           = copy_data.dst_hi;
 	lsdma_data->u.linear_sub_window_copy_data.dst_x            = copy_data.dst_x;
 	lsdma_data->u.linear_sub_window_copy_data.dst_y            = copy_data.dst_y;
-	lsdma_data->u.linear_sub_window_copy_data.dst_pitch        = copy_data.dst_pitch - 1;
-	lsdma_data->u.linear_sub_window_copy_data.dst_slice_pitch  = copy_data.dst_slice_pitch - 1;
-	lsdma_data->u.linear_sub_window_copy_data.rect_x           = copy_data.rect_x - 1;
-	lsdma_data->u.linear_sub_window_copy_data.rect_y           = copy_data.rect_y - 1;
+	lsdma_data->u.linear_sub_window_copy_data.dst_pitch        = copy_data.dst_pitch;
+	lsdma_data->u.linear_sub_window_copy_data.dst_slice_pitch  = copy_data.dst_slice_pitch;
+	lsdma_data->u.linear_sub_window_copy_data.rect_x           = copy_data.rect_x;
+	lsdma_data->u.linear_sub_window_copy_data.rect_y           = copy_data.rect_y;
 	lsdma_data->u.linear_sub_window_copy_data.src_cache_policy = copy_data.src_cache_policy;
 	lsdma_data->u.linear_sub_window_copy_data.dst_cache_policy = copy_data.dst_cache_policy;
 
@@ -2112,20 +2112,20 @@ bool dmub_lsdma_send_tiled_to_tiled_copy_command(
 	lsdma_data->u.tiled_copy_data.src_y            = params.src_y;
 	lsdma_data->u.tiled_copy_data.dst_x            = params.dst_x;
 	lsdma_data->u.tiled_copy_data.dst_y            = params.dst_y;
-	lsdma_data->u.tiled_copy_data.src_width        = params.src_width - 1; // LSDMA controller expects width -1
-	lsdma_data->u.tiled_copy_data.dst_width        = params.dst_width - 1; // LSDMA controller expects width -1
+	lsdma_data->u.tiled_copy_data.src_width        = params.src_width;
+	lsdma_data->u.tiled_copy_data.dst_width        = params.dst_width;
 	lsdma_data->u.tiled_copy_data.src_swizzle_mode = params.swizzle_mode;
 	lsdma_data->u.tiled_copy_data.dst_swizzle_mode = params.swizzle_mode;
 	lsdma_data->u.tiled_copy_data.src_element_size = params.element_size;
 	lsdma_data->u.tiled_copy_data.dst_element_size = params.element_size;
-	lsdma_data->u.tiled_copy_data.rect_x           = params.rect_x - 1;
-	lsdma_data->u.tiled_copy_data.rect_y           = params.rect_y - 1;
+	lsdma_data->u.tiled_copy_data.rect_x           = params.rect_x;
+	lsdma_data->u.tiled_copy_data.rect_y           = params.rect_y;
 	lsdma_data->u.tiled_copy_data.dcc              = params.dcc;
 	lsdma_data->u.tiled_copy_data.tmz              = params.tmz;
 	lsdma_data->u.tiled_copy_data.read_compress    = params.read_compress;
 	lsdma_data->u.tiled_copy_data.write_compress   = params.write_compress;
-	lsdma_data->u.tiled_copy_data.src_height       = params.src_height - 1; // LSDMA controller expects height -1
-	lsdma_data->u.tiled_copy_data.dst_height       = params.dst_height - 1; // LSDMA controller expects height -1
+	lsdma_data->u.tiled_copy_data.src_height       = params.src_height;
+	lsdma_data->u.tiled_copy_data.dst_height       = params.dst_height;
 	lsdma_data->u.tiled_copy_data.data_format      = params.data_format;
 	lsdma_data->u.tiled_copy_data.max_com          = params.max_com;
 	lsdma_data->u.tiled_copy_data.max_uncom        = params.max_uncom;
-- 
2.43.0

