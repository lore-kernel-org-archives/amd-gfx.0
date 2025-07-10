Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A502EC83F1A
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jul 2025 21:30:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47E8A10E965;
	Thu, 10 Jul 2025 21:30:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mEe/vDuC";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F67610E965
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jul 2025 21:30:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpcKrueU1oV4r2stkkOk0E7wRVFb6ubJDamqR7knEXWma8VEvvVE6HNWJYcyz1pclRGYt5iBpb/XK08NwiJnTKCdpvY0b7fao00l6OXXnBPHnXsH7FO//sPJYO5GlrUWy3hkDCDa10+goLI3NegzSmJPj8aUt1qkijZn970nIvF4lJe2ovvc3/lASIeKhQzSCfXhRW5j3SFUxwCKs2uG5oLwrGv+ac9Z2PYLASYoYDPzJKJOwsMn7utFjlAZ79uVQsq6yYECjsv32CFmlpjcAyk1yfDpOXBwCW9SaPY/rOGpF17qUaK/A8xsIrHd+ADNZ04K3Jf/HzAO3VlJG77V7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nR7tIUPhwO88n/93x22LlUSUCzQt2bWG9RCgyJH16sE=;
 b=qgVss3N9mzsxOvaBygyZLuyBVaiMq2ZdE/Ggt26GAQ2mCpbD29V/bMPoMv1mJOJkpglo4oRWntGnByGpWyoR8XC3snuuzLfIanryjVV9O0eosjz3ADbgS/EeU4ap1U44DnTEjJ5Eiizf1WxcLPP+m6WsaY5FiaIraE9MyyW0McnVeHY1sm7Gtgi00gqDFAeGkJPlwp1tsgocM6S7GjI7dv+dFpH9A0P7YVotkb6xIFWUnWqtFC/Z4YRt3g+1vddnWRX0zgA4o9FdY2GS3Xf4VLIRI1COjCF5YlsC37bxEIXGyhsW28XQSuDET6fizUw3Dig+N/nMp+qbQ/5rkYVA4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nR7tIUPhwO88n/93x22LlUSUCzQt2bWG9RCgyJH16sE=;
 b=mEe/vDuC6svhT4Laryikvt/QlZd43JYdy4Ud9Ei7TDLtF4JtOlQ6X45GJoMUmV1VrIQqemNJ3M/HasjuWBvH4XsWuw9ZNF8puFq+wFQ8XCCx5rXUebkxOrWJR6LldiZB9Y/vpaEsz51VLaZ4wXlwnWkYzzHfg0fvYhtdCNxg7cM=
Received: from SJ0PR13CA0048.namprd13.prod.outlook.com (2603:10b6:a03:2c2::23)
 by SJ5PPFEB07C8E34.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 10 Jul
 2025 21:30:48 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::33) by SJ0PR13CA0048.outlook.office365.com
 (2603:10b6:a03:2c2::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.6 via Frontend Transport; Thu,
 10 Jul 2025 21:30:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 21:30:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:30:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:30:43 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Jul 2025 16:30:42 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Ilya Bakoulin
 <Ilya.Bakoulin@amd.com>, Aric Cyr <aric.cyr@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>
Subject: [PATCH 04/18] drm/amd/display: Add definitions to support DID Type5
 descriptors
Date: Thu, 10 Jul 2025 17:25:37 -0400
Message-ID: <20250710212941.630259-5-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
References: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|SJ5PPFEB07C8E34:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe646d3-f890-48a5-5e30-08ddbff9096f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kl994y0EAiK2JrnE7jmHXu7Rx7+aIBlMlPLk3e5nGnaG5tunF8BuJLScbdP7?=
 =?us-ascii?Q?wZwxYtqhEzFWrVc02JAgko+jpFIpShkmzUxWBVLATllQRL02F5IZBUM4Qhp4?=
 =?us-ascii?Q?ZQFRQfW6jnvjlD0x8wm/1MjE5Rp/UKn7BirztjQf8jIysWKQPLa/IeZQdB4q?=
 =?us-ascii?Q?uY2L9fxIiHKxxIjTIUMGkvII7ZXI33ZjtiRHbPADeedOdwTQk0n1W8iJEfpj?=
 =?us-ascii?Q?JwvZVv1PDQfhhD5CEMmKX2v3TWsi0FTogxKYIaTKs0jUBttKJ1XvtuBQjp1K?=
 =?us-ascii?Q?7RJFec4TfvCM4KVOD9m0nA1khQinuJD2DrYp0nGGNT2DeRU0AeBZyet4PyTE?=
 =?us-ascii?Q?S+0AUJaXk62WUYZ2vPXZPL9az0bJzqOA5HVZGhnKAGfRRAo8MV7mOHf/eBlV?=
 =?us-ascii?Q?RpZeOWF7cz3X6iaxkKFSXNMMpBxv+g/L8dcuqpOBNPhIn1oYcgjIgCu3gI23?=
 =?us-ascii?Q?OBu9Mpl/BtJyfIdDWs3XXzvyyZW5DZMTYDtTgXWGnucjkbHpY8+/q3lx16M3?=
 =?us-ascii?Q?iPHGB5AWWRz5YmyJqn/x/bPbPO8/AB6NnDf6q8spnzQL+s95b5KrU+DhH2MT?=
 =?us-ascii?Q?1I8mstpH6QKyC6m2X5OnML9bVxEKbtH9YCDvFvvgvlyFsA47ZK5pEGrIMuti?=
 =?us-ascii?Q?4cTC7r5+r3+7U9r4BUyw0yLMti6uqIgsoxh7TGm/8nGqdsEqvY1rh5uIS0ZW?=
 =?us-ascii?Q?wgq7rEQX6agHLuCMr6vRzBglSawKst7dslgB3Im3i0OF7Zl7Q//9J3DDHBgf?=
 =?us-ascii?Q?IeHubxBMfwDuoIhN4S/Nvn0YZiiMs/mhEIwfORwCFBO5IfxUHzixFodXtVdM?=
 =?us-ascii?Q?mAJSN5mYC4KHxP7/bm8n5awbK+YxWyQ5ebCwi/9A2zrjKzi9tTnbipLLmQwN?=
 =?us-ascii?Q?2T+dd/IDvWYdr3hByu+QWk4oMRl/J/x0Yx2uVPiZgUHZvgVT0FGgVGj8pQOo?=
 =?us-ascii?Q?9qx8TXWcOpzS0NqzUWVrT+NzBDGSp3y9lPfSCPwJuxf8lzLcU8L6nVPS5Jzq?=
 =?us-ascii?Q?+OfoiTnNJSjoLa3OVviywaIjeV4aotzRYdierGKoYW2Nmh+E44V+3PzB59qU?=
 =?us-ascii?Q?1xPGTGJ1cvAUJTcutR03gpEl2ozIN7opUbGRk/th07GmlrsEQKXXwGH18Q+7?=
 =?us-ascii?Q?kV09WuALKbIvXwKO9B7L9DhynICMMXeFjMkL05vDT4pszZpEYHj+7yTEThjW?=
 =?us-ascii?Q?0aBVLmTY9MMHXT3HzqYekJHoDW/Pwq/trNbAy0k0BWLae7c9afpYYJsDJ91E?=
 =?us-ascii?Q?ntAqBrGOtZgdRK6EZ9WdJMoix2/+Dxv5TzDp3gUoKWaj0ZZnEgDwmDT5vEAM?=
 =?us-ascii?Q?C1mZ2VFJPphKG7fxJWyvdJYDklxfK1hxxgWG+9MP7K8UJQTcIf2WOO89H8DK?=
 =?us-ascii?Q?HjctBntnDUAeKOBTlZbztwVsOPJokPeDDMRtN4WizDGHrUMWMLfbWTwBkFIM?=
 =?us-ascii?Q?4QOtMljf3EoqtiEodhQI/JoSP8oQQppUX/jeGIBpSCxoWrqNHyvIHa/C3sk7?=
 =?us-ascii?Q?7IuYmpn2wo2WbwQVsmsnDJKAQ895VXSd8/x9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 21:30:48.1235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe646d3-f890-48a5-5e30-08ddbff9096f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFEB07C8E34
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

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why/How]
Add the timing source needed to support DID Type5.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index a0829bc0708a..229a754b7b6e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -263,6 +263,7 @@ enum dc_timing_source {
 	TIMING_SOURCE_EDID_4BYTE,
 	TIMING_SOURCE_EDID_CEA_DISPLAYID_VTDB,
 	TIMING_SOURCE_EDID_CEA_RID,
+	TIMING_SOURCE_EDID_DISPLAYID_TYPE5,
 	TIMING_SOURCE_VBIOS,
 	TIMING_SOURCE_CV,
 	TIMING_SOURCE_TV,
-- 
2.43.0

