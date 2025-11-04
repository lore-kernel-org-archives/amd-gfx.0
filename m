Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF02CCF9E3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 16:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E1FB10E28F;
	Tue,  4 Nov 2025 16:33:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tMXqexOX";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DD6910E28F
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 16:33:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b59koW//lCxoZy3T2Y0VN8eaN2yGDjBseH8+i2jKfkg46V/tMbixHNfRa0FyxHKDYa+dg8hX6D/Z2IhbqMM569hHPThkvcrDoTjJCevO6boK0vRf+uXfvIhVfXkAvcoMG5ArTB6X+SRKzobHWBG9S8njCNBmHeI5UZbMTfye5R/AgglxyYFNZx8rSACT30c6CJ0CEhaSOlJD+45T3oX/V4JWOhuO8xZQBXx4waX7+/gydaV8jB43MD5k1scakv4mRfPdohlYgdCEAV+/Qxd30meC+PsG8iSg8NqnTKxzfSCY8u1zGfFhEsfeuzygztFMEZ5Y0dAGvcA7YJCI/dSp0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYWIcOdgCk5Y1ChGa8ckfzR/Hi8SPP6HMCd3V0iKsWw=;
 b=ggmrAeyELzeeLwZdTNoKn9AwVU9ErMCUWOFreA1Sjr2jzKOcLoi1I7MUmVoS8ZETQth1/mnDqTTuI0wtb7P/791flh5VdX0WMnCQ+Gg7GY/bKqEhhHwZoLq9y34kQ9Qy9F3ebG33AFfhIf42BsnQUZWudm1H8STD4GH79ZWfnbg4+vNm5sF2qMH08yJS2ieJQ+GQqpoDoUr249QVT5OE0DlOO7NKRvTfZftWVv47oOhsU6WvH3nnKKXoW0lmuwO1gdkuvveARzavq/ZGn3FFR3eEmzGqAZYUimbbQ9SoS2TypShPQhYE0YVTslvaNm2xkDcfdWhjdH+SErpg++yX7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYWIcOdgCk5Y1ChGa8ckfzR/Hi8SPP6HMCd3V0iKsWw=;
 b=tMXqexOXelL+LpmEEeN1B0ra9az6N6tY63rgGyv6LEl0/6z7CMXo9csAO4KCtnAyohH46nwYSdnLAAWSCfKwP2Wo1A/oIVK7L+pJlem9gY+2fBmS05X0TsUgP7k2IVKarkGUiv9vIUvjtmbmCJlNcnlzzqXJAvWwXBJLZZopodM=
Received: from CH0PR03CA0363.namprd03.prod.outlook.com (2603:10b6:610:119::32)
 by MN0PR12MB5955.namprd12.prod.outlook.com (2603:10b6:208:37e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 16:33:18 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::3f) by CH0PR03CA0363.outlook.office365.com
 (2603:10b6:610:119::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 16:33:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 16:33:17 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 08:33:17 -0800
From: Shaoyun Liu <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amd/include : Update MES v12 comments on RESET API
Date: Tue, 4 Nov 2025 11:33:00 -0500
Message-ID: <20251104163300.545619-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|MN0PR12MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: f4205f3f-930a-4b19-0fc5-08de1bbfdc2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m7A5W3nE/ocxvqVLhGZevcFauhy1gBu/AB4XaV0sA0MIcFucogfeLXTRKBsZ?=
 =?us-ascii?Q?MGqI1ifRAs6TLeS3JVd2CdQK4l/KpDtpYvQopRkUxIh2BIlKF9D0Fcq7U7I3?=
 =?us-ascii?Q?VNhM4ikGhHJhGMxA4CPuz7qXRXSkjlG7dIHxItAmqP70lI5BiFVFGC8voN7Z?=
 =?us-ascii?Q?fgWvp6YxZgy6bifjM3Y3Vksc3631rgxTDV9Dickl7Kcrkg8yIjKCJldORYgE?=
 =?us-ascii?Q?WkrbCUXMnCp6ed7At5gBN46wBk8YgBGXt+i0xmZM/UoQZ9gT8IVd9Y4PgPnE?=
 =?us-ascii?Q?IFwAe9MsjwjyxFIYofXJmLDaegtlJmHzmBESL7YJ2nPHbtEKA9aZTbz9Xt6D?=
 =?us-ascii?Q?la7+vGn1/8qlsd5iI0lth5ZLYgvY+FRZKoCRHcVp/N3w4ERtT2e4/N73NZYf?=
 =?us-ascii?Q?p5iiu/dvBzpW9bP+O2+ZWC4OQbK1hJ2UFMEpQtjVuUa0BVNqUz/nj61Z0BcX?=
 =?us-ascii?Q?/bskPLEuvuUJmKJ5AurLuQOshM3HoxqgTty0iDgNLw6P4n+UACmtosnKjoEp?=
 =?us-ascii?Q?pnWbzhdIfmwNlfhMYzAdbtSRmro/HHVvH2ixywsNvXqTPmyTG1bsyPjYmCrN?=
 =?us-ascii?Q?B2Z9nOHZ8FAB1p9xe2pZw3ZI4urhaVGMFci5DiZIpkbTv4R3J6rT8iuzuPua?=
 =?us-ascii?Q?j3V8LWc/v3IPtWEHymvxmrx20fwOxhqKcK0IpX9VPciww5+Iz8hX3rEetjam?=
 =?us-ascii?Q?CvB3tjlujxTYFRRPHLs78fm2TmZU+Erv3yRTsuVli/zdB5p6bOl/E0W2UKLj?=
 =?us-ascii?Q?vUj4Ip9d4NDf1x2udh8JXlUZ7Z+/wmfgZSK2Scjeyjv23c08UQT0sfrCD0bI?=
 =?us-ascii?Q?4hlOEHd7RvkfEvDp9+Hl7+GZu26fD5xQ5d8afc/JWetEGZ2SZGfTr1gCFihz?=
 =?us-ascii?Q?gitr1HOFCrLUoFmb1/4MdI0CzETyZz3fSp+wIk1ogRfIY02mHTqTVZt+kcf8?=
 =?us-ascii?Q?EShfhp4YWdnJatVfeoW7oy5U0Zeo8FUoS41C7kZYx0KBzWNaiPw3h/Xh+fhh?=
 =?us-ascii?Q?KivyYw5axDj8bbeVllRHA5nn6yBW/dI3bPruQOZmd8dawkhJzWCt3J95DXYI?=
 =?us-ascii?Q?kpUIZDI3EZ3FIeTXJ9CnzfLOlFUUjVMzCWuIXYdX6TOhz7Mdf2pBSFh88zr5?=
 =?us-ascii?Q?B8mcU6hE3IEN6KKq8TtQMnPTfy9fgXlcw/KUeOar3cLwOjItswM8Fv4yN9Cj?=
 =?us-ascii?Q?YWFXmzg+4uN4ZIXVOHODenXvml1nxPXEoZapNpf+aWBpuq5oRwgJ5bJGJstM?=
 =?us-ascii?Q?Ysy3X8d9vx+G7RmVn7udlIVuCm2FQrgjXyoo168iD1YrQckDju+uRtvpdCo+?=
 =?us-ascii?Q?jONDvTGR4JTjkzEqxgcaf5wOL8gbRzry62XSXgIbK48xTpJHzz1Pv7FdX47j?=
 =?us-ascii?Q?ztsOOLnxvpQ80OILDa++sSix5463GyBDVqGd/piRrk0VH7zaf64Y3NZXMdwO?=
 =?us-ascii?Q?JZdMwHxIm2xDJtFRFMWRGh56LOFURo3Q5xaIucE/c5lILDGVB1yOyf7jVzc+?=
 =?us-ascii?Q?At/stAnMtpFYy+GFJ5vKaMqlI2woJpHjtbqrjAUI9iZlB5/jjanIqrLpjdaa?=
 =?us-ascii?Q?dOnDH47dclJXw+oCs80=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 16:33:17.9371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4205f3f-930a-4b19-0fc5-08de1bbfdc2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5955
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

Added comments for the layout of contents that addressed by doorbell_offset_addr
in RESET API

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/include/mes_v12_api_def.h | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index 2f12cba4eb66..39aee6b4aaa5 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -553,7 +553,26 @@ union MESAPI__RESET {
 		/* valid only if reset_queue_only = true */
 		uint32_t			doorbell_offset;
 
-		/* valid only if hang_detect_then_reset = true */
+		/*
+		 * valid only if hang_detect_then_reset or hang_detect_only = true
+		 * doorbell_offset_addr will store the structure as follows
+		 * struct
+		 * {
+		 *	uint32_t db_offset[list_size];
+		 *	uint32_t hqd_id[list_size];
+		 * }
+		 * The hqd_id has following defines :
+		 * struct
+		 * {
+		 *	uint32 queue_type : 3;  Type of the queue
+		 *	uint32 pipe_index : 4;  pipe Index
+		 *	uint32 hqd_index  : 8;  This is queue_index within the pipe
+		 *	uint32 reserved   : 17;
+		 * };
+		 * The list_size is the total queue numbers that been managed by mes.
+		 * It can be calculated from all hqd_masks(including gfX, compute and sdma)
+		 * on set_hw_resource API
+	         */
 		uint64_t			doorbell_offset_addr;
 		enum MES_QUEUE_TYPE		queue_type;
 
-- 
2.34.1

