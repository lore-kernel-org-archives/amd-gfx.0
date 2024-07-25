Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F9AC3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE46B10E8A3;
	Thu, 25 Jul 2024 18:03:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ouPOJWKC";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4992A10E8A0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:03:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTVkOEHZXrlRMbeucximFU40hU5rLGi5kBtmVCXcz+7VS+XG9Jn8XBsAJk020c+8KMvDqfCjGiR/vdkzDrTYe/kOzsazsR4Of+85z9JVu5jZyllBzeNfDK5J19/Lh3wfRXb0p6/jLhqnDFAMlZBX8OM/An+P4Odkxmp+uOjaG+zrxaqrh9VuzHk1mhccdvjRMCwsu5++ZioVxXZaqnkASvwvygqsSnPn7SRDwWN6oBSPsPPGU/ZappoPs9Dq8b7OCyYT2gLsvcGpHR2ClgqglU+vEoAN5ob2KJEBe+JEQEeLLHiI5994I1mGXAS5HScMv/sbk/CRMgAHJGxdDrRYlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfnXrGwIlRluGkr0XNS+gVwor1/8Egxb/E6/GvldDyo=;
 b=WrfA5X+SktVfxhPWxK6z+AnahIl8/Wkhu2OLo7NKskx9vvtWWd299stoBjCBbzzZcrqJYQYYybFnODr5AXkDuqsLafmZL0nltfhIa4+y/ATkbX8AbffxXzN8KUtEkWJ6/aAj4qMj+XUnPVjc5d0dz6zpr5gLu2gKvBedgEBlWk3n34B1HoF4BG3dP/6Rwt7tEoSNORzp4vr1L1bWxaPapOb7GgE1YNRZeRclHSFPdbf0XBKraQ7G47v+H4YJ/wyGaN9kls9Q6a1L28Kb3z84qTmjPDVo+7Uxc7PQnyRZ8EuOfmFhcHe2UudGUbBUnTzCr/CCzLtkpRXSNeKwbIJEqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfnXrGwIlRluGkr0XNS+gVwor1/8Egxb/E6/GvldDyo=;
 b=ouPOJWKCKSh7ka9jJKTKeCdum7UgnplxWZksUJD9xF1rstXrxEBHYFFpEtjStKgsDGT6xkvUIFU666QrRCQaWBX4JYMc7Ma5eAEB9Qf30w0kv+uwUH8EW4FrYgeEy3ceW+2XvwzoU4s9jEUsxtoCGdlxUcMv4WALoNZ4OxxaL6I=
Received: from CH0PR13CA0019.namprd13.prod.outlook.com (2603:10b6:610:b1::24)
 by CY8PR12MB7362.namprd12.prod.outlook.com (2603:10b6:930:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Thu, 25 Jul
 2024 18:03:53 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::a1) by CH0PR13CA0019.outlook.office365.com
 (2603:10b6:610:b1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Thu, 25 Jul 2024 18:03:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:03:53 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:03:51 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 10/39] drm/amd/display: Check stream_status before it is used
Date: Thu, 25 Jul 2024 12:00:54 -0600
Message-ID: <20240725180309.105968-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|CY8PR12MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: 95bcffae-73d7-4dd3-6092-08dcacd424f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ErQdLzs8mhoWlAwQYVKtlQw7OAwo3g5UapENpWcCu6dvb3zwJ/bT1z1Bxu/g?=
 =?us-ascii?Q?QNRPE1gmmM4xyd/N7712ZwDc6/LzKwrUXCAvejDRDTdJNPDLtI9yVhFlDWRq?=
 =?us-ascii?Q?n1NaKSLBU90TXjFOhRDmcmFxz9/ILEOJhrYXRRo5+ldFIBdKiKnXwm+fZ5x7?=
 =?us-ascii?Q?DUwLAZVOm+ApD4XBmID084tWANskKFS7ueV89dbKtIGLD2R1sAbbphMU0BKE?=
 =?us-ascii?Q?9/KziUA0u1/5biML2tucEF1dsClu5aiSyV/e+lp8l9bFuT+4WBG+r2fpHI7w?=
 =?us-ascii?Q?VPhWFxsgnQyNYrtGE1LtzfgKF3dZnmU+l/dPjxu72pbbBLDW90TKLxdf+KG3?=
 =?us-ascii?Q?DyTwnTq+SaH4v0XHJsYPkj3/+/1f7OvGb7YFdznIRz/QJ7+tzUx11U+HfzSO?=
 =?us-ascii?Q?mV0z1dDbh7mF6OEAQcRkbulL/FK0fZSdmbgh7V9VSQ7h12/Gq0odffw160Ak?=
 =?us-ascii?Q?zy+G2PH+WvjwLoI6SG405ODkNMrFUrS5flHec+EimvpBE3psHlYLszGA3a5m?=
 =?us-ascii?Q?qgSSJ2EGQ2TAzY31Kj2c10eO2ADh4uEJU6mlUbNWN/KlsSw699in+6eHa5dT?=
 =?us-ascii?Q?uHJXPj6HlkMlnA9wlr+tw1fBoWIQXaOYGZfTN3mc6spTWjuy73L6dLmvJGcT?=
 =?us-ascii?Q?bzj7bVkWCBe8cieOvn7Kr6xvjDxDxk66Gm/glOFs6PHxaOcXRxBYFRepFSj3?=
 =?us-ascii?Q?1J7yF2AfkulptIeLfDsAJrOeCZUEqwcSv097Tt8iDk/Bq8JcA1BYzXzoHQhu?=
 =?us-ascii?Q?wcCJWf1fKrKRv08kqC4WIxGMYl3tqNDzOVK2Z8tRZsd8EQoUNDkzrpfBHOkj?=
 =?us-ascii?Q?oNgXFb92JfOMrhzB7k+AeT5N0tsldy1goBnNpv9Fv/hqvgybubZC8UWOF5kq?=
 =?us-ascii?Q?Lmdc6L/jHHDtbycbuQhJwkz8nvKtKQSc/2ckBvFHmm7Sj50ZkbzlIY69fwhb?=
 =?us-ascii?Q?8cKoVzLiZWshVL7hHKGKcAYL4vZh804mS7SGucCFhtKsylTqYp/zX39M8ey2?=
 =?us-ascii?Q?TIDvJnJfIko2GDY9OFNPhb2v5woXSr5PFXJfrddgvfXCX+YV0V+oNBNmx+Gr?=
 =?us-ascii?Q?tuCgkF7xgNm7UnZmJ+F0b0uC+lpJzr0eu6OeDertxZV9oSc0fBrNnFPi4PWg?=
 =?us-ascii?Q?tVmB810y0ulW5pXopNGzGd8VgvhtkLa2E5eQYgsn81Zu1kbnTQtPhjtO9MKO?=
 =?us-ascii?Q?ium4ydofHT5OeMYQWHi+Lbrne2NYizltew2feRI6+BLl4WYu+zziMWIxHkBd?=
 =?us-ascii?Q?TGRqj5TX+6P1pQR9pvxpw35E79h7REIfqPd4JKylbmbhdAhMBkNakSYUg4xD?=
 =?us-ascii?Q?FTQxn4m2ScdjCmGz4FsIN2VR9P45V0grX5nb5NM4PHJUbMUlHAIWl89zgXQ6?=
 =?us-ascii?Q?kyoNOufWQ93kep5yu69U3yDmU7bqrumJ5ORHD6venB22+TgGeReK/utQDj2/?=
 =?us-ascii?Q?ubhpsZFH0ubOLh8VUgu9ga0moCtEaMQZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:03:53.0866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bcffae-73d7-4dd3-6092-08dcacd424f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7362
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

[WHAT & HOW]
dc_state_get_stream_status can return null, and therefore null must be
checked before stream_status is used.

This fixes 1 NULL_RETURNS issue reported by Coverity.

Signed-off-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index b8a6c062426d..ed811352506e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3748,7 +3748,7 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 				surface_count,
 				stream,
 				context);
-	} else {
+	} else if (stream_status) {
 		build_dmub_cmd_list(dc,
 				srf_updates,
 				surface_count,
-- 
2.43.0

