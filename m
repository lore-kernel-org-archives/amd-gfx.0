Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C173C021B5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 16:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0234310EAF1;
	Fri, 21 Feb 2025 16:02:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qxaBzpqM";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D118710EAF0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 16:02:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujUb1Qto6qnKoPJANa5wyyHx3WTKHXzQwqE5p8IupZz8lWmt0uWBcFFf/OS2obNpnd6bir21Rmh8dRpqE1vKBTXHlmPJQl2qM9JOA983xGdDXL/xZdOkDiawk6Kx7T3az0iQ60d1ZUkqu2pTOFSFMsdcv3OyHQH/2c5LNdBrfuaEDjBdt6gYjSgYHkqbYvXhb+m3X7kz/eCtK6hHiisy0CEyokBn2UGh43wrzAUDS+CGvzlnwLTgTLYC5OhXJ84VsIpDP/BaobKFttfAgPV6XOd9PkF+1KMqHZJmYHGe5wc/X+sXN9esg1sq8YzOBEeeIPNM0sdAYcsus+uQ+q+TLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyccGBEjLIiruD7/zA+c9i+z8hzPZGY11snEsrhKRJE=;
 b=JHpHMdVjEU1Hyhbxzd+X1VDdUE2C6E8exYwHp4CA3BbeuG3jF32i28y15N7ztBcAo0NVZWrse03B8GXkQX6r1ZdLNiCZImcMUmT/bskLp64UlV5sAmwXUcOTrivrHr7HRuZgw06XXDDWkjzJi0kciMQJ6R1TGu32hh8nCge5kVH+lRmmZzsF8zIWg6stxgMSDqq1eiBcbi0azFHCDQzT+8a2E66y+dfiMcWQQOBdnL1QFhe1SWZAIAhNbHX3z3LZg9Vly/7B64vO03pEqZsrZ8nU/y7TCixogFxv7er18IMP/UPVYkmJrJfw4+nNcUw43fYnjlwI2E5xV5FizDOFyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyccGBEjLIiruD7/zA+c9i+z8hzPZGY11snEsrhKRJE=;
 b=qxaBzpqMyKce8q1mBxAKNq/3WWMRymjssrX8ZWVXJhkYuSYgvmNITwTsCbTyQOmTmb3BQ6Ama0D4+dwimBcMSjxEXGSOo8SHRoCWVSy4eTiGJjR+KvwZ9F9vPP7+oNB9Lxrm7fAOPZ2K+q66xBstESNSG7Nix35PfhXHGcu8V7Y=
Received: from PH7PR17CA0053.namprd17.prod.outlook.com (2603:10b6:510:325::8)
 by SJ0PR12MB6805.namprd12.prod.outlook.com (2603:10b6:a03:44f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Fri, 21 Feb
 2025 16:02:44 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::8c) by PH7PR17CA0053.outlook.office365.com
 (2603:10b6:510:325::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 16:02:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 16:02:44 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 10:02:32 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 24/24] drm/amd/display: Promote DAL to 3.2.322
Date: Fri, 21 Feb 2025 11:01:45 -0500
Message-ID: <20250221160145.1730752-25-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
References: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SJ0PR12MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: d49cf0a5-0f38-40d3-ccc2-08dd52912da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cs4N7HFGRK874zGvd+TVClkg0R2kaAuvrQ51q6DL2wEUtK2T9t3M0JiuF3KU?=
 =?us-ascii?Q?f59RCtr3+f2WCmlOSPUJzGh1caEJosEZPv5oYEsQH2/NPnJU115xabPKcAKc?=
 =?us-ascii?Q?xhRhQbtevEzXuLg6E0mVe1MAjQwwfCpwoxGAXIlUTMVxQBzHL0DTVQeEJJmB?=
 =?us-ascii?Q?AM2ubGvv0eKB/nVGAMqKtNr53JmHIPPDUi3c+2c46epwlXxrQW/huxmXgg5p?=
 =?us-ascii?Q?3pOM0GHZ/bTZO5s/29fwp0y9lYIAdaiU567SL90Cgw3u1ZKD2bmaktZO0RSL?=
 =?us-ascii?Q?TP9up4bNsOMa/gFqE0zjLr4pzbfBe+tHGN1+P9hTR98E79zXynWCtV6bZMLK?=
 =?us-ascii?Q?8rqLo9DzxLv9vmvX66Us+LwULdoeEwSeXoulP9CH0cf6mT8PZTSREffVJDDu?=
 =?us-ascii?Q?9RBJldH6QsqnzLdbfHbK3nH7LUnTa9ZzezTVZ44rQm8uBmA6j39ZaNq6m1aR?=
 =?us-ascii?Q?xzXt1b4D3q3fF466bu1xRnwFq+ktf+ETIvjxuhryRIRAYFo6qOYlOH1AtQww?=
 =?us-ascii?Q?oepg5O49E9CCsfi6OHnIIOhcM7altNflzvIbEc2+mWJnO1FBRgyzxoqa0/zX?=
 =?us-ascii?Q?kv60pfQEYHVhXO//GT4MbQkUudWWpbZHaXzthUblEHnuB7AIBYv/MQ9x416X?=
 =?us-ascii?Q?UmDbipoO2kbyNPMyP/l7xZoCgHpVbjBEsMekc2FK9kGzieCaCbuWZ9hjjdxC?=
 =?us-ascii?Q?GYvJYZ9jnu/Ckh7LbeDOeOnaQjklQIp7zGkmFJqsiPYkMWb+Kg1C85l58fQj?=
 =?us-ascii?Q?s6jTIo5c+IbudHw3nCULmlr5V7zuAiPikEYWTVYYb3+rJid9qBR79SwE0AMj?=
 =?us-ascii?Q?hOxfpFNxELdwbqwfCaE0uNma0FGYodpArrj74PiP8Azxdun+xdNDeaie8j/C?=
 =?us-ascii?Q?cROnBVLBKehps127aRUck4v826HPIzDQjB3yj2Co9amSZnzewVKsrpineoV3?=
 =?us-ascii?Q?9Tzq/AeEP/kJ6MqWm3HVfmBb1QAnB9sUz0bHbMA/WgaAiIcCtsdwTrtiVLZt?=
 =?us-ascii?Q?H2UT3B1ekUX0pa01rVbQGi1yue6hja4YHj1KYfnU1ljV6Bu+mY0k7X7kbvcD?=
 =?us-ascii?Q?n7eBRLzVHqajpCFIxYPoZ4JYWlSeajixA5eFyrZbpCHfIt/Zd0zJ/9yC6zAQ?=
 =?us-ascii?Q?Wbjfx54VG+vvuz1tuuQ+0TEII77uXm6uzKA2D5b2rJI5H7GdZFcaGcTkVyIA?=
 =?us-ascii?Q?VB3eNhbh81PTHPwCutHqUMDeuhq26uuF0s7mjXO/QEPpcK2NUFeNVZ1JPTg+?=
 =?us-ascii?Q?8AjTXlUo+tROWmtOe8Y+kO7xfrxekVCZXhteumFJo6FH7FNnw1hAqprX5APV?=
 =?us-ascii?Q?d4ugjdm7rBdpBUBmSpkH0ANXQi2aaSPEAxbqtxPTB6T8jTlV1xBoo4iPEIlD?=
 =?us-ascii?Q?iZtP7RWhFVzQmxdiAdRzGhw3MHq0hJY/r7+7uBKW2UVyPCN9Lv02HI0k0gZe?=
 =?us-ascii?Q?ILkutSJNBUjRrUz26GdUeWp5swXCLeu/y5v5zJm6cdlPotI0342ODIdxal1Z?=
 =?us-ascii?Q?eon/1Nx/gxbThwM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:02:44.4598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d49cf0a5-0f38-40d3-ccc2-08dd52912da9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6805
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f76884fe86e3..f646f537a3dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -53,7 +53,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.321"
+#define DC_VER "3.2.322"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.34.1

