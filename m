Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C446CD39016
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 20:24:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E27710E678;
	Wed, 14 Jan 2026 20:24:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xBatoYAd";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03F1510E672
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 20:24:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFJCpatHmi/V+DkupEFBBeeHtFjJ9/fdmjEQmpbvsHseddLEBkyMTuRIpvLXPn9/bKR5eom7c9eQa6Cj6QoleYuZ5vr0M7lJJcypxsHRycRskBJPwy//tbH8vOuTDBIb5HHNpUxdZ5pI8SOruYL8XtNNEMD+iKGi8Y8ddYW0T6/aVVlC9hm9Gc5rTd2nfwWH4jzbJBU2pzGwzyy7yGmmzP5EJFwJlu2DqDxRTpx8Q3riS7Gk47s8reZqSpRLScSwegkxGAraZQAzKu8f0cG6e/bcw9lUu1J7g47L6JRsYHsOUDzkv4fa1rygoyPiG7zKQVQ2ASpXbCCo8OZGjV0HUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OX5hEQQVHgDZHIJwilJwNpjQgnpjm4urrB8HYAoEk5k=;
 b=yfuu3xQDg5DYTrmdoAz4ZIlEP9lw3OT+FThVQm/1iL9a7ComT/ykevDjq/Mp8csSdnc2QZY9tTKlig2OhuxsVQOKDOFsgL/z41zTLAtSFAvOSOQPHx67VkcMkiSTv2IfKaihxLlMJeVtJ3hHtL3y/p6gI/OE5ZKpAkwEtnJ881PWJWf57/qsbXbXPri4pclwZPpfTP+QiQ7ODLqRyb8Ma2nUTyVdtnGl1Y0dNTBAb6/b7sCkLLuBkwChoDuF7BiXqk0WXAS/ItM3OKsS205RpHVgpkzj6QNZtwtVRufRwOVB9yewJ4KqxLI5PvfbYB0JVHTMylsXwTuQpr4NYq6GWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OX5hEQQVHgDZHIJwilJwNpjQgnpjm4urrB8HYAoEk5k=;
 b=xBatoYAdfjE7nPZUeviT3k5YMQIqWUm9XuCZzrdIjKKWQcp7v5FK5OawArlHQBgHtWjjElppSDCijAdJpwteHiIoWZLUV7B0kOlShThohWbV67003SqV7vRZYafD/n6QlokpQ27iE/IVSmIdvA1WaEIzK1d+xa1nu3vBV16NzIM=
Received: from CH0PR03CA0262.namprd03.prod.outlook.com (2603:10b6:610:e5::27)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 20:24:06 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::44) by CH0PR03CA0262.outlook.office365.com
 (2603:10b6:610:e5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 20:24:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 20:24:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 14 Jan
 2026 14:24:04 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Jan
 2026 14:24:04 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 14:24:03 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Matthew Stewart <matthew.stewart2@amd.com>
Subject: [PATCH 05/14] drm/amd/display: Check NULL before accessing a variable
Date: Wed, 14 Jan 2026 15:21:46 -0500
Message-ID: <20260114202421.3654137-6-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
References: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Matthew.Stewart2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 10abfda6-c263-4795-7060-08de53aadde4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sV6RMfrzcCs+mxVovg3hhzx11jvYerHNelkWcsmu4RDSzjUJ2OxKb6a8ssey?=
 =?us-ascii?Q?G9l6VHnICMjyfwtwzqnC+UI4sVQqTkTW3MGpiafnile6TtxnzlfkVTqm0JbM?=
 =?us-ascii?Q?GFRkuv+YFb4ZEgGB5cosH21/kOwF6WvrT6hhKnv2BQlIptcm9rLNNSAvNEEY?=
 =?us-ascii?Q?yIrGS59/seNY1d7MPXCyTBpmJDbB9mQbnGGqS8yEkeAhEJZsq8csk60/xTJD?=
 =?us-ascii?Q?/q8PabfKAyVqMpX+HFJl1eHZd1gAw7iSqmIRTXPGlu1JuV+OylINt4F/16Uk?=
 =?us-ascii?Q?6yoHTuz6rxzbHFF8S7QoBnSc9IFhfI+tJ9BVkxPM0TVFYi1jYjkMXQRjb4So?=
 =?us-ascii?Q?amrVw1ZU0YT4Y/uEfto/AzC5fmfk5m6TASYX0aBueJkiLUZa8MZ0uSMNRi9U?=
 =?us-ascii?Q?BNWkwJSACyOiHEti65HrZMIP9o7Q47hz1jHfXNAYW6Du7UJ/6oenHbB9HexD?=
 =?us-ascii?Q?3GNPcyX1lHXkS6NnAstj/UQgvUyANMGsba+QkZsCe2QtGU6nUMejbXxxqmlw?=
 =?us-ascii?Q?y3z6QzeE/IzZU08u6dtzhpAEBFbMRCj3D1mS4Igqg3u+RE72s8qpDgtV/E7H?=
 =?us-ascii?Q?J4q5pRPdwvfacpN5paJKWlOM6GkccyKeA8CTbXc5OXV4PRQbP45HoUUv0FSp?=
 =?us-ascii?Q?+8BQBv+GBOkdBdnQEwTLTY4qYBDmRr/N6bQnkTZwrvm8yViEH29EoK4OKuCh?=
 =?us-ascii?Q?Kqfc34zduPpoMsSdzyTz8chF6dRYRVhjCamLlqUxbBCn/3xdbQj0JQa3BigF?=
 =?us-ascii?Q?eSDE3csYJCGGTJ+xRnjs3Nopg844KjeCdZX3vUBeFbmPu/68zFW5ZuhdEDu7?=
 =?us-ascii?Q?zcGRUs0/JeMJ6IFOReBLF4z4HA/zp+p0a5rYHJP5WRu3itqBsaoUXMnT6Pyw?=
 =?us-ascii?Q?y1JIUyJXI1uYdQCy1MBU6M8UkhxGC7Ncmv45ZOu2+0YKcjlQE4wFu7pq/xsz?=
 =?us-ascii?Q?pSNNWwTO2IpURXlsRRLfbLPf1FrllT6f/wHFb89MwNxW6g0+3pCVYdrS5AQh?=
 =?us-ascii?Q?dTI4L08D38/EMV4rhRUWjoBtC6mz2ac4os8pNfCkMsefB1gf5VyCbvm7UjI8?=
 =?us-ascii?Q?u0dJp335Kvps7ZKxN8xp2x+pQ5BtfmrJ5OZ/P1EF1/3xam/v0ziYYwXnw2yK?=
 =?us-ascii?Q?ewdyt165sisv8cGlD18RUNEiMbBgqNjRhhKHcQxfgWB6wq6qnIOArJHH0aQK?=
 =?us-ascii?Q?BE6+MVpdSMwUNdBrjWhqihaZctFCd6pcPEChiPVxNMl6ZJv7kWRtPjpTHPv/?=
 =?us-ascii?Q?v33KmQjqo8mWIgWMh1JDyTSPRyp0LgN8K5U6CnLoS1iHkBYC+fQ7cQHJEO1C?=
 =?us-ascii?Q?cK+rTdjB8ox4bqRvzIsFkHSeoDKqBRJpE9xyg2k1fwCyh9gmgNkX+gCjmmry?=
 =?us-ascii?Q?3Sl3Z8K+TyWLJjuzrWc95T4B8WoDLVZuc0H9D/UfHHK5rVJ7UsGXiwyy1xgq?=
 =?us-ascii?Q?uTeVrSCymuDkU3Q5Flb1OzYQTsCMPLM8zITDLtAiIo0R/ptxyCLAI0QMoGTx?=
 =?us-ascii?Q?AYH5hXL+R2+JcY0HzRxwfEXMmtNpYtIvsXXOp62aphFTFdx8Jq3iT5B3su2K?=
 =?us-ascii?Q?maYfv0Xzltq0GVt57pTy9cZf+hbvtvQQ0WsQ2rGHJVVZFQyitenRB17IitCv?=
 =?us-ascii?Q?ox0BMLaEyGkZkPmhh2r1rO75REa32XGV0CQSgi3lIpZgXLoEN1zSiZHayQ8Z?=
 =?us-ascii?Q?dYobeg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 20:24:06.4933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10abfda6-c263-4795-7060-08de53aadde4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Check NULL before accessing link, not after.

This is reported as a REVERSE_INULL error by Coverity.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 864002b63716..df3b8383b06d 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -984,10 +984,13 @@ void set_replay_frame_skip_number(struct dc_link *link,
 	uint32_t *frame_skip_number_array = NULL;
 	uint32_t frame_skip_number = 0;
 
+	if (link == NULL)
+		return;
+
 	if (false == link->replay_settings.config.frame_skip_supported)
 		return;
 
-	if (link == NULL || flicker_free_refresh_rate_mhz == 0 || coasting_vtotal_refresh_rate_mhz == 0)
+	if (flicker_free_refresh_rate_mhz == 0 || coasting_vtotal_refresh_rate_mhz == 0)
 		return;
 
 	if (is_defer)
-- 
2.52.0

