Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2F5CA0FFE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 13:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB98E10E70B;
	Tue,  2 Sep 2025 13:35:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wik3dTzY";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3863C10E708
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 13:35:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLKe0CnfZ6jxZjU38jXFlKZ47LnyHI3w1F6rSs1h+k0aFSd1AER3/Of/Gl9T5MlkNMRpo5cgK1V/bsLC8BFpRLwGoXyEjcXjWMU9S8slRo1qiOUsVM/jHEEtHMpTgrOg27lXQK0EqLPEkvNybLHzrW5irALzBYJgQJDCFcatAL0bB3hjWf4dg1pbaNtIGrHE4BLUrw8jT6Q+rdhEan/GMI0r9J0gDnzCPq1QU3ooqvD1kwcNZqGyV9mdhd5qbLFf5RqbZy/FijszVdgNjykwvYJwr4+fm3ScTNfK81aZSEYAIjZJ1LzHSI8gf/qtUD6ZiLLWlrEJpOCJvGVxZXYh5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQnkqE6wSTBO0VU7oCRZmwZUriLGiR6HNxHob+x/wjU=;
 b=CJ5uDEUHz4x/5unqH8t9xl3Ck2C2aeNa+ssW2z1gmRwvMx0PNFWo968tfu0ALUhkoXLMM8yR6MIl1UGLFdSmgVYwFD92vsiSPKwiXFoy8NC0aQToDtEDD+4viapTM2a92YztZS/GAG0thZi7TtNsXa1NDoYr7KmysnrWS8unYQWf6Z2ezdINGh54CQBLGYfMTDkWOKpd1+QkwZnZKmr4UEcKKtGCJd2Db6WJYpwl+FnIOLu3YmgRp3/E1+Ey8ncQowpJCY4fPUdgIz3w1CpFVl194i2te2OQpcTazSbSMvqmRrnYguYbuTHerSAeEvDmHvTbvGxPl+F//lf7dolFbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQnkqE6wSTBO0VU7oCRZmwZUriLGiR6HNxHob+x/wjU=;
 b=wik3dTzYHN1uFeT4a6eqWiX04vMd2xnrPAe9KcuxZpjLLXhUO9boBJ0qUiBCA6hweR5Ip/bXr2SNAYE5/4URTx7K7/MXtQ24OOerjseFkweE8iuau5VvLs6d25H+Mfb8YEWaR+k08u13Ge5SbesokYXrwRfkMcHJ5kBFXR2HDPg=
Received: from CH0PR03CA0254.namprd03.prod.outlook.com (2603:10b6:610:e5::19)
 by MN6PR12MB8490.namprd12.prod.outlook.com (2603:10b6:208:470::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 13:35:54 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::6b) by CH0PR03CA0254.outlook.office365.com
 (2603:10b6:610:e5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 13:35:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 13:35:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 08:35:53 -0500
Received: from jzuo-laptop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 08:35:53 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Clay King <clayking@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 4/8] drm/amd/display: incorrect conditions for failing dto
 calculations
Date: Tue, 2 Sep 2025 09:33:33 -0400
Message-ID: <20250902133529.4144-5-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902133529.4144-1-Jerry.Zuo@amd.com>
References: <20250902133529.4144-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|MN6PR12MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: edeec443-284e-4d08-c15a-08ddea25a41f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XIGnmZZEvzQnkJGnNbXkiM0EgjDbcttJ4voVFPMn+E6SYJae8de/nexdbqL+?=
 =?us-ascii?Q?4HEAeg8S91yEgvzEDSI+y7UFiJoqINnTUaItluQu5mNOZ9jO7pPoe0qO58in?=
 =?us-ascii?Q?MB9TR+IH/nsUCZM5z0MNcAMnLTIwY92oL7LqFxh26aOb7pZpNWFchoHMAPh3?=
 =?us-ascii?Q?Qm0RthiIdy+IP1YRK3h3wBWkWtoI56Q+vtntIcYeFTTewKQaw4eViXm9TjaO?=
 =?us-ascii?Q?AuwE0hb8P97hibWRP6BGicADtXtf2JKK4GQElwMwGwEJ4ExGeWn4gZUT+nCK?=
 =?us-ascii?Q?6XQj+4xaQVOZx6hF7fjdpr2GL0nKujYZxA6WGEnBS0EN/CdLH9kUhFie1VO4?=
 =?us-ascii?Q?LUxBqQCbCyfNBQXdl/1ku1xqrROn3UqhOgr+IUyc+TYxUYhmjIdIFCgEXGFg?=
 =?us-ascii?Q?iPCIRnspsF3XstWATi5uIJx9FqlzrxIpN9yib49r4pamvuqg8gaBg5crUEma?=
 =?us-ascii?Q?eC0C8C0mj4mGZAf43vha6T5H8pYzfY8pcQhZFMrNWWeQM3mgLV2V3efgB0k+?=
 =?us-ascii?Q?0vAEAOChx2DdTGidBZjHMyI+/KUpZ9tyW7ONpJmYsAThzaYs2qNdvgqt8i5a?=
 =?us-ascii?Q?SH7Ras/7Z4jljQP067B47fAyJNu3CDEUPp+Ko2toAXJf5504h5JEICLmOlEm?=
 =?us-ascii?Q?AxsqJAFM6GKctt2G/mLAd9ce6XOo98rH8o3h+Vhh5UFjAaqSfQtWm1d/mK4K?=
 =?us-ascii?Q?71R4EDtr2TeJe52cxFPsxqhVzowX7b/XBjrDfDiRlCd4WSgBcESbcZlcpsy4?=
 =?us-ascii?Q?BOL+0poEYL3eOxGq/M2XIWjr62Br6uZjtLjEWtpREqAx2QHVVMKgewO7nNBy?=
 =?us-ascii?Q?RmZpRoQYqn+3xx1C8CoLcp1sWl+S0XqHnnvXVddeAqzxMaPD9tkBRbbR34Hk?=
 =?us-ascii?Q?5qyjBmVDHHhg6rh5Zvmvr3MppgwCxzqjeBCoX4UvaufGutTeOMJsPYDNKh7t?=
 =?us-ascii?Q?T8DUvTlW3eoBWxDDNMML9ZAr9yrak5EEd8pP5ZFPhUX8aafj2Gk3HLk6LyJQ?=
 =?us-ascii?Q?rsJJ0sj1wQX8shGAXpZmOi1Du/dY0oEOUdVz8TR58AcmPIcC6eF66fNapBSR?=
 =?us-ascii?Q?DPTq0mnL+u9R4WP3EsURaXWCM07ffqUsmx9JMFHkqi9i0g1QoYcpuFGMAFq5?=
 =?us-ascii?Q?at4wGWqEiQH8U7qM6MhPVLYM8g0ihwo59ua3AgP4xKvtM8oI8igPEFTeD/Im?=
 =?us-ascii?Q?GC2ZUEEz4sQxq9NC6StwF+a+/6QOjI8utFL0CoK8lGplWKkNwdCDtSTtx2Om?=
 =?us-ascii?Q?1erYwnLU+ZZ2GubNFlzv8MM5I6W01KmWugmbQB+YITzkw4J0K97ZGjlld+z+?=
 =?us-ascii?Q?bAhyA62jLGfh+R+SFZf/5AxqjVn/7qEasezxqrs3L1TB3upi9pnILgPwRGv2?=
 =?us-ascii?Q?vtvw839TyLn85oPEux64twlVvn3bF+TiEpTRocxkA+xhMOiGb9zuXba0W9pn?=
 =?us-ascii?Q?Y8ii9IWq6PREftTzzGcQ0hV98SfHv8TVQi+q68V37VJ02Js0g1EpSMySLy2s?=
 =?us-ascii?Q?psRLxw63fk+bPPP90bKGi0iuLKWRPYzr6/Ae?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:35:54.4153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edeec443-284e-4d08-c15a-08ddea25a41f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8490
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

From: Clay King <clayking@amd.com>

[Why & How]
Previously, when calculating dto phase, we would incorrectly fail when phase
<=0 without additionally checking for the integer value. This meant that
calculations would incorrectly fail when the desired pixel clock was an exact
multiple of the reference clock.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Clay King <clayking@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
index 668ee2d405fd..0b8ed9b94d3c 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
@@ -619,7 +619,7 @@ void dccg401_set_dp_dto(
 		dto_integer = div_u64(params->pixclk_hz, dto_modulo_hz);
 		dto_phase_hz = params->pixclk_hz - dto_integer * dto_modulo_hz;
 
-		if (dto_phase_hz <= 0) {
+		if (dto_phase_hz <= 0 && dto_integer <= 0) {
 			/* negative pixel rate should never happen */
 			BREAK_TO_DEBUGGER();
 			return;
-- 
2.43.0

