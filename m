Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B2BC3DA61
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 01:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60B7B10E0F8;
	Mon, 22 Jul 2024 01:48:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SvuZcSzw";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0608710E0F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 01:48:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ws7pP/RsHm6kEiOVZ+Pgip3Mvcjn4nKSCtrcSThzj7wPjq0Rdg5naUch63j3c5yy1WNWk5qGoNWYT7LivKq/zYjP3FCt8fFzMv1GQfzuhu8M7M6aPwDiygn4PxBfu3s4aD+FYFERXrLlh6GFqWxFoionwTKsuBoZhUOStxUU9bmD8Wi4wH/MerSovhk+GoO1yBfJnwHhAxZ7wKHBOfa32L/wFEgNFepXL1jLasiD1OO6cxsE/WLi3e3n8+2FRRPjffLTKoGkCkGf79/0OfJn2scvazoGpwYu+kgrfxs0q+OiNpbVAbPoP5vRH2XVqFnl5WjhwdsvCs6pqc7cEHsOkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v427OzYJR4V/mHePzaP7XdK0aakSsbD1J7u6+cBL03Q=;
 b=Iizb/B0+8VD75ii6pTfRUou4GS7/El3zlZ0myTIf4RnHoJdfunoQSDDy0JK84DyoTT8QY90N/9KOt8MER3lizGo06uMwbJgtvCynCDnl2GZS805yc9QVSR/zbo94pI01Ru7Y92xg1hhe2nenW8F7F5EukIeWbOjE82RJdPwNuPnjjdPR8w9S+y4j4Bhx45ClfXpCB2y33pZgcwmoodfux0Xi6NkJS95lWOmzr2yE7cJjoCNvVS0j3pg6Y9dDdrT+7pocWFCUtSS0zx6hpMRHhTNMuFaL9hd7xGpBUsa0MWpB1NAIQwigJufwI/LDrDnMC6jRLMvPBLH+otPX4V+JBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v427OzYJR4V/mHePzaP7XdK0aakSsbD1J7u6+cBL03Q=;
 b=SvuZcSzwDXjkma/ESv5aB0pgL0kKm7NYdZDrUGrPDtTIX6EO59y58Am8RVwoM8Lv0OEkKzcHC3pdQC02BsUzTfa13lVu0lcNxhKMWmJwxDCuF+nLdTS5iahpbeo6vyWPiUgXzjxNZsyz3S5r7qf2IvzoaVeHoL9bgPswbVH8D/o=
Received: from PH8PR22CA0001.namprd22.prod.outlook.com (2603:10b6:510:2d1::16)
 by IA0PR12MB8715.namprd12.prod.outlook.com (2603:10b6:208:487::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Mon, 22 Jul
 2024 01:48:02 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::ef) by PH8PR22CA0001.outlook.office365.com
 (2603:10b6:510:2d1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Mon, 22 Jul 2024 01:48:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 22 Jul 2024 01:48:01 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 21 Jul 2024 20:47:02 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 1/2] drm/amd/display: Add null check for head_pipe in
 dcn201_acquire_free_pipe_for_layer
Date: Mon, 22 Jul 2024 07:16:45 +0530
Message-ID: <20240722014646.3558293-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|IA0PR12MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d5a51e-274e-4aa5-0ddc-08dca9f051fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/Bvib93ol7w9SP4tKRfFNEI5+xZrtySMfQGdiHipuxddhnwO9uyYFQEzP4PD?=
 =?us-ascii?Q?pRFhJaeQ4x6eduZbuJPE3HudXwE32sJ9Zntkx3LxPOpK5/Flp2uOp7X165K5?=
 =?us-ascii?Q?FQzsaZAE9qHmg0hRpY/o+Qymn9a/znA+4xj6p44sa4yT4s9/y5bYj92EMyqO?=
 =?us-ascii?Q?CKbqLxZE3blTdyMD7dhiZhIfFnE9tRvndXMMffCAo7bcDVmdRiv3Q22vSzi6?=
 =?us-ascii?Q?VtvVyRKly/lN/zk+bzLOGIhWWhSG36M9X2w2Tqi8tnO6FeOeFd85ntNOl+cb?=
 =?us-ascii?Q?1HGUPWsIGf8uAAeYOUYj5Ah43b+TNQequZOeqFydAvzfYv3pVOHDGdmNeb11?=
 =?us-ascii?Q?4k7vK/CNqnZnL02Hyw2n2Y6MyCSNNRj23jJxfCefOEwVLTmyUhZBLOf90FBG?=
 =?us-ascii?Q?L/w/bxJshPebG1iD80BI/ALNTStOfSNyMjHM85eN8/Vt4IB1WZ68/QrCfrBk?=
 =?us-ascii?Q?WMPAiyagrxUFFhxCFI5BSRIJJWSgRIOBIWwyozaeOOdutF1QzJAVe2a1/I7Q?=
 =?us-ascii?Q?VTlYCDTvHEzJ9LC/8omBHmPHkvW2HwPhjdQowhGC0yDmQFugDSqJ3Zbu690w?=
 =?us-ascii?Q?SH9580WgD9QhO+7KSKGz5fsYcRzuxvQPswZNyryk1/HvL+rFgPrhr370uau1?=
 =?us-ascii?Q?MwN4HZu5AFJish/Wd/V5++4b16ZOhm83O7TOqYGRwAbl9BfOl6zVhT+ZAl3c?=
 =?us-ascii?Q?xafUVxy4avUlJ6mCjxdav+hFRM1gVs8OtchYuN0FqXSTODQhxN7qk61e1uM1?=
 =?us-ascii?Q?usbFsFQ0N5CtOYIMO7bJR+9s/EkUC95uic6qDZkTZqDUg4DmUdtcpC3tv7pK?=
 =?us-ascii?Q?Z1FsJfowPi5Vh2ijNW1hFFtfForDhGuKaaHfTBL9M3pP4qPYc4qgNelhXb3H?=
 =?us-ascii?Q?lon7p5pYuLL6t96Q6iRB1WdVrx/4Voc0E+2LJbqvv0sGP0HTqWYwzy4nLECG?=
 =?us-ascii?Q?vMEYrDxvx1YsU/wY86PMby3MUorhH4o6HOeTBpCJ9hEFUY2l3kEihznrrL3t?=
 =?us-ascii?Q?t1qnS2abbZbvTCQfNWiwnYiJzqtGEsI1GJ+peeJSU2rZJjdEKGPAu8A6WOfZ?=
 =?us-ascii?Q?Q9LkY938UrwLDgz5FdhnbZz3Au5RgGwW0ZgYyHtSoE2Dj5Fo6Z4bh5Ok5bln?=
 =?us-ascii?Q?J1JegQZdQXLTPJoKyNS8KFjz0z23oN40tQosJyEaN+rbGBIxU9dVcN9Eyd85?=
 =?us-ascii?Q?jy+/+CEFrtGDdtpmJOlselBRbG3kSvMKMFdur5Pm3WGp0Uf2gSwLWmlcRicn?=
 =?us-ascii?Q?4mlSGjo2U4+C+qiRO6uSLbdKlNTxf6Pe4SGE7ZfpxsRfbLDblRpP5XpZoTKk?=
 =?us-ascii?Q?YSBP96Pd//ioqfsLm8cVIBGSWmQiO96Sj9A/VXeqzu0r+COZZ1kpJB/G5AVL?=
 =?us-ascii?Q?Hh2MeeCWLCz91ZjFkRxANwDKLIZzMlQWZCKLRVpcQRzcmfKJSBNDDThoC3pW?=
 =?us-ascii?Q?9dpaRg0vdmr6GAmOfGV+Hxyfbn4HPQJV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 01:48:01.1236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d5a51e-274e-4aa5-0ddc-08dca9f051fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8715
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

This commit addresses a potential null pointer dereference issue in the
`dcn201_acquire_free_pipe_for_layer` function. The issue could occur
when `head_pipe` is null.

The fix adds a check to ensure `head_pipe` is not null before asserting
it. If `head_pipe` is null, the function returns NULL to prevent a
potential null pointer dereference.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn201/dcn201_resource.c:1016 dcn201_acquire_free_pipe_for_layer() error: we previously assumed 'head_pipe' could be null (see line 1010)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c  | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
index 131d98025bd4..fc54483b9104 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
@@ -1007,8 +1007,10 @@ static struct pipe_ctx *dcn201_acquire_free_pipe_for_layer(
 	struct pipe_ctx *head_pipe = resource_get_otg_master_for_stream(res_ctx, opp_head_pipe->stream);
 	struct pipe_ctx *idle_pipe = resource_find_free_secondary_pipe_legacy(res_ctx, pool, head_pipe);
 
-	if (!head_pipe)
+	if (!head_pipe) {
 		ASSERT(0);
+		return NULL;
+	}
 
 	if (!idle_pipe)
 		return NULL;
-- 
2.34.1

