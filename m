Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51FEC83F22
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 06:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 582E610E377;
	Tue, 15 Jul 2025 06:53:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vA4Cd3oI";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B5FE10E377
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 06:53:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHlR/OsBZAkKNWBl5s5RyHLeu1txeAYcXVMN+0XTmiLMyFlPUV8wAXNv9Qbx6QJX1hNp0jhZxwgTMbZdG588FCGPimJ4Px9/rSjZgdI1IS8Jf2/hZbQl5C9eepAUgjtjVZo2TlpM7w2BrD2oAPEbmIUuKDpY1U3BlQuhaPORlGkkQLpLmMO1H7b5GuGIl3DlnTaSZ3Mr2aD3fImZv0AJZWlhJ65HklTl8dfnKmzXXGsxsFDw0xyf4/mrAc2RvdLaZ4UuO9HE2/QAcRGraDQkGXI3J+ScUm5/DDHKc3M8aInHZfFwOJsx4B+lSEsPbkeDXBNknPogM3ld56OFAlG0Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AO+0H4EfxNaO1RsZRf8rB5akWe2C5zkyE0q8gQ4Q6i8=;
 b=SDVs6VimKaDM6VxFnmSp4ODo2zolgs9L/xKRVyb2dQZatH1mm5D3+eb6l3VmIhPUolIoQCy2Ln+Z/Oc9EQC7SdlhKcb0t1IZg6FT4SSBYnaoXv7XM3/FUVblsmOq00QQzrE6rej53L+6jKHhDa2X3RbvXA+CD4HtrSELQmgL8hhp0Bmrq9LlwV5DFPCQBLcBDLtCu0hjSYfWo9Sd7eHUfNyxsuHZA2c3FyWylu7DW6hM/+q4fVGDkBFG2RQYMCuabpQOhGYqBGeVgChRDe7kKO3cpmUKfTg98bBcoqKOJBpStDcOMenoRdoEfFak/MU1PFXm2hwK+1lKeQi4ceqwxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AO+0H4EfxNaO1RsZRf8rB5akWe2C5zkyE0q8gQ4Q6i8=;
 b=vA4Cd3oIWfTZSVprJnFX7upvYZFY8YLm0N7fw8CLETCJDY9QdKdj9Wkj5iyE8WtsqimF/gj5eUCuv0i8FJ9ut+lYlvOIDM0yImNC3toPNiEa2O1twpAkpWExC8EaYspT9ndh8fEaYqOD4z88JV9pcA1Clmz8Be5FKbeGzZSg0dM=
Received: from CH2PR16CA0016.namprd16.prod.outlook.com (2603:10b6:610:50::26)
 by BY5PR12MB4274.namprd12.prod.outlook.com (2603:10b6:a03:206::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Tue, 15 Jul
 2025 06:53:12 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::81) by CH2PR16CA0016.outlook.office365.com
 (2603:10b6:610:50::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 06:53:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 06:53:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 01:53:06 -0500
Received: from 172.93.31.172.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 15 Jul 2025 01:53:02 -0500
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Ostrowski Rafal
 <rostrows@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 03/10] drm/amd/display: Update tiled to tiled copy command
Date: Tue, 15 Jul 2025 14:49:27 +0800
Message-ID: <20250715065233.160043-4-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715065233.160043-1-Wayne.Lin@amd.com>
References: <20250715065233.160043-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|BY5PR12MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: b78ecbfb-fcb1-4a7f-f17d-08ddc36c43eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QMSaJOSWv67ZzxsnoBiTeDFN+FFkxVGD+o2LKbgSLy/wp6/T/y7hADahq3Kz?=
 =?us-ascii?Q?2gZ/6Ma6wiQokywpJG0fm7eTUZgTIoy1dXnKFe03kLvZNQ/VdGuKFs8Y8J3B?=
 =?us-ascii?Q?oUgUXFnD8awWOXJKppbll4hVnplpZH7cHQe1w9+CSu/kIF4mL/YiyNv0R9li?=
 =?us-ascii?Q?c+F7LqFOeSq1GHHubpXZNCN+Fa3pTbUrW8Rej+E5io+O3g5ea2f6W3zZZTdE?=
 =?us-ascii?Q?Tq5Cqk7W1pOmoodFQgBJTKQ5TA9dAWNxpI19+qKMxygeTiMMJYUuLj7VzJJn?=
 =?us-ascii?Q?RzwKrahrEGUIOpXEhnfs4Vlnhlom1QQ34E+4IW11YWBXrhBawDb3wCO1wNNQ?=
 =?us-ascii?Q?ngywi9CJCmK6JmhpUkUDqEKsXNMceHIvJ/JwSfFWKE7OZzptLj1ijAov1s/e?=
 =?us-ascii?Q?eBWo62sUN4I/blM8a36SQUvYOyua6D8/gRTLZCKIjz8sLrXXjRT+PUOIGGkh?=
 =?us-ascii?Q?18b+FE/poHQw+/XISNUymqoGkA49UtEnPS6VNqHNJNKYaZX0D7mzhUItPTjk?=
 =?us-ascii?Q?xJ2w6Wn7LvQuV9zUSIbQmxgqubhLKyUOsOEYC3ViMmGvbgxrmaGdWcGrCn/0?=
 =?us-ascii?Q?++S0PhTsRWGGbIFnqYMzFepKOo6Uu2df3/rIZDzVn+LKkPGROluWgXPO1j4h?=
 =?us-ascii?Q?hnd1B4xuucfvWYSPoErfqsQaGRE4lwEbEQpT1fCfDY84x6fVB33D8/sSMhNq?=
 =?us-ascii?Q?yA5ibqlUwiF+U/5JmHHye0zNh2Tst1z03jWpqicDIuFHMgzqQWI4OzyowlI3?=
 =?us-ascii?Q?QMlqZjPRyK/5dRYGlQyLuT7T7ONj/h5H5dlPSW9VwZmZWamTS4jaWSzwuqnY?=
 =?us-ascii?Q?6UGm/kqBhaYzCARbzL83RZbkIi6/ydDWCbmriHCz4XmTHClyILYu4dEd4bEk?=
 =?us-ascii?Q?tqCbgaq26z421f5bQDSUP5t1fRC6UzxlVWqb8B87o4Mqy/9SAZ125Eog71Rp?=
 =?us-ascii?Q?sv2bV9oXdfxwAVB4N8u6xYclkzrvmhDf3TAiV1614iHEP/R18zU+Lw3d/eg/?=
 =?us-ascii?Q?TntiO5pmLiRbl/aPow/qPDOKJerVVoG4fx+FYeX3xOJZzZTlZWKmbGQHEwke?=
 =?us-ascii?Q?r1HgtLnsf3KFcm1MM72HwvnCskjDNgQmTviwSv5Cr2p8tZlUFChEKq14e1pC?=
 =?us-ascii?Q?sqDMh+4eLCR4jKfDgQfmkXXkI9Q5AQjb5Fwy3R9zNLi+BJduD9aHKeiRRyJS?=
 =?us-ascii?Q?uN7T2Cf+oA49Ylj/4k84i7ZntWlB4tJtp96otVz4YXASh8mIb2Qq/bYg9m6b?=
 =?us-ascii?Q?YljlwDcKaGNxLRyeayYh6Qa4Uu1IIXSVqXMGA2VbodoJvsLRAwSAFD//ofiG?=
 =?us-ascii?Q?PHOOqnGuu27kiGOZRZzuOZCW2EF94FHhk56o5SVPHddIxL7UmtgMZriSujUe?=
 =?us-ascii?Q?7yx7Lw/ePrR4HY32bDzpEkQ2pG/OS/CI5oLMp6MCFesSTKEGgKNjANOsZ+lt?=
 =?us-ascii?Q?uYMOPv1Sia+/foVD62tMp0s5xgsdETf9zoW+yFgYb2euL+qSQLipa0s6jytX?=
 =?us-ascii?Q?HGg4I8oULiBL6CSvrb1/z9FdOhXhuFp6fvTksP093Jw/WbMvFaUCfafv4g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 06:53:11.9268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b78ecbfb-fcb1-4a7f-f17d-08ddc36c43eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4274
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

From: Ostrowski Rafal <rostrows@amd.com>

[Why & How]
Tiled command rect dimensions is 1 based, do rect_x/y - 1 internally

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Ostrowski Rafal <rostrows@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index f5ef1a07078e..714c468c010d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -2072,8 +2072,8 @@ bool dmub_lsdma_send_tiled_to_tiled_copy_command(
 	lsdma_data->u.tiled_copy_data.dst_swizzle_mode = params.swizzle_mode;
 	lsdma_data->u.tiled_copy_data.src_element_size = params.element_size;
 	lsdma_data->u.tiled_copy_data.dst_element_size = params.element_size;
-	lsdma_data->u.tiled_copy_data.rect_x           = params.rect_x;
-	lsdma_data->u.tiled_copy_data.rect_y           = params.rect_y;
+	lsdma_data->u.tiled_copy_data.rect_x           = params.rect_x - 1;
+	lsdma_data->u.tiled_copy_data.rect_y           = params.rect_y - 1;
 	lsdma_data->u.tiled_copy_data.dcc              = params.dcc;
 	lsdma_data->u.tiled_copy_data.tmz              = params.tmz;
 	lsdma_data->u.tiled_copy_data.read_compress    = params.read_compress;
-- 
2.43.0

