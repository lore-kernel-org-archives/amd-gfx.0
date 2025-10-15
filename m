Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBEFCCD184
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 02:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4445710E6D5;
	Wed, 15 Oct 2025 02:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rCncNoMP";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011015.outbound.protection.outlook.com [52.101.52.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2F4410E6D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 02:58:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2Jk3UpSztIUU6eJouYNJFt9Jr85ijb/cHvNyJ95kC6OcHDDXghNBlJopR9zkANXpMsYxBgDE8ve9zYqi9hOjWrExSGrKhQAZoqgAp7oHjUalf8RtyuRrwRbRqvIvcKCD5vpQuw2T1f5L4PiMeJ2/iZSIFZ2+HSXIYUDtBb/dn7mmf7OxrkVfKoCGIySFL0oJ3D2V04W99tYi/PsNhqez0HQqt0ubkbZG6jd0EPkWkq/+OZ1nVk0i1iUsn7H88TdnRyBXznQdQzeSjhpjD7lYuLgEWnAXMrRGhdmePpWAI6A6mt1+T9Rvj1jeCSGQfS+6BlkwGi+tHKKjqCceYJFjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4bzxLz6d4S7DO53nus1o3/1P8XMSNhDbvMpyl4Fzdk=;
 b=Nze33HanZwaQ2YOJjy9SiSxq1f79TD5R+H+l/RjfZBwy5jTdcBJnnYNdPihlSa6ttDFQfMjyRhcjzbn1cfv7EIegig6Bb/626KNKmdfz1956sp5au2rnVoqRubO0XRPHGYXSq7eETVLKtiuNATkrOEu5Jady5i+pZVDEQtPwGMfT516FbWUX7A1+Nb/mqWeRRJJ4tXO0PQOiLXMkozDxkMtcKxAgH1b4Ji58W+NgyB6iSqiCx2+joYI8leYxNITrrToack5NOYkK3eopdzeTl8BgGKfmea1Mup9AxgxV8vxDBvgKJZbZGLqA4/v6gm35ENMFKsjHAqyGlym873k/og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4bzxLz6d4S7DO53nus1o3/1P8XMSNhDbvMpyl4Fzdk=;
 b=rCncNoMPx7kWlqo2T5jrOaXsQl1hxExyr70++RfQT3C1KP5XaHVCEp6xMFq2kYlsR27I2G+PLTdsCBFeUvl72pFDSQ4wruvQ2vKdsFShY4EqKwNQ2D06Q41u2a9/DskmEHn3R1MsRnlZxw684GsX8cW4P6te2/wTsxRHHlPXyOM=
Received: from BN0PR04CA0190.namprd04.prod.outlook.com (2603:10b6:408:e9::15)
 by SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 02:58:50 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:408:e9:cafe::f0) by BN0PR04CA0190.outlook.office365.com
 (2603:10b6:408:e9::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Wed,
 15 Oct 2025 02:58:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 02:58:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 14 Oct
 2025 19:58:49 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Oct
 2025 21:58:48 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Oct 2025 19:58:45 -0700
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Carbones <Nicholas.Carbones@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>
Subject: [PATCH 3/8] drm/amd/display: Set DCN32 to use update planes and
 stream version 3
Date: Wed, 15 Oct 2025 10:57:04 +0800
Message-ID: <20251015025816.1542507-4-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015025816.1542507-1-chiahsuan.chung@amd.com>
References: <20251015025816.1542507-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|SJ1PR12MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 961c8cf0-dc8c-4039-3fe7-08de0b96c3fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wWBoeRK8Sk0gHuAkU4mJFOM8MBHmKSG1BWLk1Tu/H9h1dF/VTqmLnWZGyuVw?=
 =?us-ascii?Q?i+5ERfGFF5o/4aqOon9ZlmdKJA/CrUu8v0LVVvVQ6ad7IBrmpPCHN0bhVenj?=
 =?us-ascii?Q?jnvYxB8XUuBQnvbQ8fwFC9/zPkFu1ToZxj4TxKk0MJ1jJ5Zm0I+hLt3UqTtN?=
 =?us-ascii?Q?+ioKh+5F8T38p2wVfaJQZzT91FRTo2iVFbPDosJdJKezHfNAhlb4RcK1CVCv?=
 =?us-ascii?Q?w5gcHtHezgxRE3v5dLa2KaDLTXF38P9+1F2hofuxSLid8jx9JjOaMgjbh3tF?=
 =?us-ascii?Q?TeQgi45gTcMsXFDHuCFRXi4CfY0Lb0JVuUgSHdklEaUK55PPyjk6vbfazp6n?=
 =?us-ascii?Q?kKg98q0etsBo2+WsqSem0hiqG50Go76Hhbkq/BAU4b2ydfwOdbvebgHMX+Cn?=
 =?us-ascii?Q?aQIO3WUIZt5L8RvD0Xn6rDI7FUzZPAT4hcjw9/Zs4zs+tN+l6RpGXCYDxohh?=
 =?us-ascii?Q?JM7OCqen/9lQgylaBSX7U8jsjidWkvhnavLg1pw0axea6tGnRy72t1XRBXpG?=
 =?us-ascii?Q?fuGfO88o8f6yRaoV2DHEEPaGe4rYG/mg6pFULgetFkeQyWI+oZQef1nm5EEv?=
 =?us-ascii?Q?FDDLwdLV8v1UAvsWIajPkxf5HVbWvya6seMeG1FKxxudVJbttDaiZ5qk42Vr?=
 =?us-ascii?Q?sweSGWqm2YUX1j5ORhO5olmEjzMaIu9aoQCvIwXy+0w+RTvYIS/qnbigBCir?=
 =?us-ascii?Q?kqPKNhIkwSdWt1uWUM8Ixj+jISHdAFe4M2HSidJZmrfNjqaaPMvBPrXuL/1R?=
 =?us-ascii?Q?xfo8nqXKatexAMKyg2YJPvWVdZO4hv7gBEUm+BlI2RJX7jIrhgbSVZEXB2sN?=
 =?us-ascii?Q?Z5v93aAzzU46KZTn/WhC9ZMnpIzIzRTZMTBU62HNUf4ko832M7O/DroKdwXA?=
 =?us-ascii?Q?4owPS3vCS/NnBQK+OZ71IKSpvBSI73eOctluZpxNqPhw/nm4J04sIN0ZEkAy?=
 =?us-ascii?Q?4vSRadhKqSI9hFPwRV2Hi4/Op18epxDj3vJDq71rCMlvNqZO/pr4wlqvY1tH?=
 =?us-ascii?Q?54RnIEztbdMsFu56R3ZWgrQQC3QfM5cFivH8W88IRZrHTc2LGHWjBncdjXdP?=
 =?us-ascii?Q?VaialzySXXExLY8zuAShwZrwt5mejhsPKWQA4R05dgSb9SUzyswnh2AgyTdE?=
 =?us-ascii?Q?DJS4e4KNtE7An/+OReJbskrusLfhfxKlb7yBZcldH/24f07j+rSk0ZDIs5Wo?=
 =?us-ascii?Q?9Ua/fvoGSIBqccd5d3AJ2DF2+xk3U6EYiAC8kPrE29XX3KJGuY9sGa1JMzGI?=
 =?us-ascii?Q?kFo9S1JN60wZQu+9FFWy/lX5e1X5e46hz1310jqEQz3b1RxrGFynl1LFqFUf?=
 =?us-ascii?Q?2t8XOKgnFgkGHInfLCUXWPPvMoQcQUgWt1NY3lzX6X0vrYEl1qaizC9cwXSD?=
 =?us-ascii?Q?bnWWxK/Zlm4ZjTziyIlVLErSCxoL065H09AsWM91+rTAno7J6N1EhjSOEZkz?=
 =?us-ascii?Q?DU6p6CBAW4AaVHq4rOl8mRszrvumnslJB25zeOf2whBTVJlrChOY2mBO/v6C?=
 =?us-ascii?Q?qWo0f1/yrhqeCFdC/6M1RDkEdecS8F2jldO4qrOsZT5VwJTPjY81KKFgYQIV?=
 =?us-ascii?Q?F9wlKdU38SF/BRdm7Ck=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 02:58:49.3781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 961c8cf0-dc8c-4039-3fe7-08de0b96c3fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075
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

From: Nicholas Carbones <Nicholas.Carbones@amd.com>

[Why]
Old minimal transition does not always wait for updates to complete
before proceeding, which can lead to corruption in multi display
scenarios for DCN32.

[How]
Set DCN32 to use update_planes_and_stream_v3 for better pipe transition
handling.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Nicholas Carbones <Nicholas.Carbones@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 36b046611d02..4c964cf28f68 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5376,7 +5376,8 @@ bool dc_update_planes_and_stream(struct dc *dc,
 	 * specially handle compatibility problems with transitions among those
 	 * features as they are now transparent to the new sequence.
 	 */
-	if (dc->ctx->dce_version >= DCN_VERSION_4_01)
+	if (dc->ctx->dce_version >= DCN_VERSION_4_01 || dc->ctx->dce_version == DCN_VERSION_3_2 ||
+			dc->ctx->dce_version == DCN_VERSION_3_21)
 		ret = update_planes_and_stream_v3(dc, srf_updates,
 				surface_count, stream, stream_update);
 	else
-- 
2.43.0

