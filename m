Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76854C02182
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 19:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 271B110E63A;
	Tue, 21 Jan 2025 19:40:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zd8Fp7WB";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D76510E636
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 19:40:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrzbPf2GKVGV5H0PpOE5+QKZog+5qmbcmyftP2/3mck32F2iLptbC3X/blQxhK4ELFlhC3GlAER2+Cn7QSeD2q9ec1lpVfXkmqii1jh8yrCiNanA7e9j052OzhurUmQDx89Jg86PPQD1FIDpWN/Vs97LTZRkpP5YMcC5nJl96biJTgim0LBJTPBPTDaK4xuimm5scMd9bh7vHtvPtQzRAmJkIqwHSl/FPnI5fQ+63DQPIwtP7efwJh0wDJHfy7oHarqE+qIWzLNwZ+hRo4bk0aJ1ragm3q/RZBfRZPux4MdtARbUGo9UnoiHTKJb4C6WeHN1+WERtK1hxuADmWH1/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ahf9cvAu94NpSP/xj6HCZh4xzOf0YtighQ6HRM9uYw4=;
 b=Y99who5FG8dYIIiN296Ld1w8ohU0mIrkjiXyOExmHawSkWaUZz/qSVVE9QEunATmyN+fpR6tVCh7lbqwXKPJ/KHkpAv4s3E+w3BZwc+Xa8U/HUtBqLZe9WCrYH2VZ/SfkBVE+E9vVqP8xxjmhMTYRxiCRcgA4VoVB2pnLMEmtf6MkCDbJom0/WsKrmLEbKe/8Er40yaiGGY5V2KL8P12pNSoWfXbnc5oFUt86RHxXIaCMaYjLVAiBqcBUlvhV2c3A4I0aC9fDmJqcYO48Fg6ZxvosMVBOFAzANL9OCXiroAWyCORj3p6Pr23j+JAgMZHXOc6LxpuXVKfQZ4vlbIdnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ahf9cvAu94NpSP/xj6HCZh4xzOf0YtighQ6HRM9uYw4=;
 b=Zd8Fp7WB8A0V8dpkAtszNp50H1/uYgt+/AgufuJ1zGqp5y9GS2stszO2xbw8/DBidY0/UC9XWyw0SZfHwCGlNngONbyb+tWRK7wMBh0sem0KymtmHu4Fy0Zd8q46lG2VxOjKvHHspwMV8FPHhcL2Ieqtn8o8I+w2kL4lYooHr68=
Received: from BN1PR12CA0022.namprd12.prod.outlook.com (2603:10b6:408:e1::27)
 by DM4PR12MB5721.namprd12.prod.outlook.com (2603:10b6:8:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Tue, 21 Jan
 2025 19:40:21 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::5) by BN1PR12CA0022.outlook.office365.com
 (2603:10b6:408:e1::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Tue,
 21 Jan 2025 19:40:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 19:40:21 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 13:40:18 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 14/14] drm/amd/display: 3.2.318
Date: Tue, 21 Jan 2025 14:39:19 -0500
Message-ID: <20250121193919.3342348-15-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
References: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|DM4PR12MB5721:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc4dde2-9c61-47b8-3f9d-08dd3a537120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TDEfPs+oKyOiSO81Aw/85sLhFbpM4s6MjDQlSz2VpqSjU3e8FDngPz6wH5SH?=
 =?us-ascii?Q?dI5EQ4ccDvw8itRZ+UPBZCf4qn0g9mScWo+9G/I6bBljCrQpB8+e6g9VlC5n?=
 =?us-ascii?Q?Kt+1qjfCujYXWqSPt8LcisQ80Iug19s5eoRLnKfh7km5hYO5uinjonNjEk/b?=
 =?us-ascii?Q?SlHTOrrHpJLiU9BpkFHb477rPFUKWQQyYdjdIOKOwtq4ycK5gB8Ctq/QAqRD?=
 =?us-ascii?Q?aWNqWn2JolEJtvx5ofFtxroHR3DYnZb4C9dFKNtaSRdz+KCb5aH8nTA8MVf4?=
 =?us-ascii?Q?YtBmQf9Pt/+XKMKdbs+o53xnP/Tn1Hf9isaaNA44omqPoLArmIq5uzY6+G5M?=
 =?us-ascii?Q?IhcK9ICunKkddI78Qz70GuAoWJUIx4pmcLqfkrh+6b0lJ/7qmvDLQtDy/Q11?=
 =?us-ascii?Q?rTfVyJcjR1NeFYlRf9DQr+AX9bT4Ap8caJYVz42qfiLtAWEXs6EnEpWITz9/?=
 =?us-ascii?Q?yu0H9cwvGuYtxe3so7w7UCl5C/zbVNjxedwOzVc1xk7muvbDKuqx6gOOkY7j?=
 =?us-ascii?Q?ukOysY5BAnU7cD1i6/g5tyrN89sYz7FPtqfy5IU8LQSB8OyaNZe4bD9DrtsY?=
 =?us-ascii?Q?WPDwl998FrGb6h0724nbSJvtl8U0J73ctBQ+MhtoVoYr5KumSQidROLyuqRR?=
 =?us-ascii?Q?HXMkaBzV2cZwmjY+LQa0bPozAKfnoPXZe4BOGpmem4wnvNqj3qWOJM5c95Nl?=
 =?us-ascii?Q?ldKuwxxjMcusyUWxv6+5Eb0Q3TVmFN7f+0KxmG51OST5Emnn+9Rh4S0dnnoc?=
 =?us-ascii?Q?2Emfjj0FBHoO/GFNuI+H71y55rw81/byLT64mju2E3/N57ucRf2V1Z94W7GM?=
 =?us-ascii?Q?vJx5Hg3EaECfyrL6HBY4pbghy5znMi3AhHNKUaED/GLRrl2RsnKOFx70aNUM?=
 =?us-ascii?Q?1dkRG+ioigsmyatCVJhH9G0+nHoKPzyTvpmTG7W8LLRZYqHt2hl9dS1Bl2pB?=
 =?us-ascii?Q?RdnkGXlCTE/2CRloBIb+GDzmE4RnLbFvmEIGpj6Nub0dzi09QUJcVoKJc3pj?=
 =?us-ascii?Q?9IBsq23NUWHwuZLXBLfWBx60pT4AM/HSG82g2j95lXClCNExkxZMS4PBJu0h?=
 =?us-ascii?Q?7dNWqAJowbtB5FBgooMJHPfj8zjAS0SCorgsGE+cMXhpyizJBJ8ppqfnBVJV?=
 =?us-ascii?Q?KkeV0Mj/Diu3NIrlNm+VxyJGlHZW7+1ewBfcUq1eu8a1GJMB2hcWQdA9TWQI?=
 =?us-ascii?Q?MYTwMNGY884JsdCebbf06xkXos+XX2GkydRUze7r1+c35Wsf8IDE73zlizGH?=
 =?us-ascii?Q?n/iD5hixNJyBQdQhYmtSLitz7V8HpMw9Xplmx77hvt/LNxcE+60wRAyEVqW5?=
 =?us-ascii?Q?mx+6MZ3Un+bR69gs2O4taJBJURQ59kwfx+T5N/4nf+kV+PP78MlPNupq+ETi?=
 =?us-ascii?Q?EXB06H/AOUoM9LrAsNDoC6LAcg5xRn0dghyOHaa1DNMKeU6zYABpX0+vBUXX?=
 =?us-ascii?Q?hl9YrIGoyA2YUl/axjPZAhhBI0xqvBQvCpeT8/YilkQ+wEaUN2TJc3ZZtvVe?=
 =?us-ascii?Q?Uhi03DCMM3lWgRg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 19:40:21.0488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc4dde2-9c61-47b8-3f9d-08dd3a537120
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5721
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

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 06d9cf0a7edc..559446dcd431 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.317"
+#define DC_VER "3.2.318"
 
 #define MAX_SURFACES 4
 #define MAX_PLANES 6
-- 
2.34.1

