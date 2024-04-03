Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7273ECD128A
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 19:52:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D76FB112E9B;
	Wed,  3 Apr 2024 19:52:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GiS7XRp/";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20444112E90
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 19:52:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5vDdcDJOZzb2t/ZjVb3docO04XyAHbgLDEjo/+WshrHAUSYmNCutqT3oOLer+C5j0OrR0c6rOxfZqEIpUg98VURs/mHonorvLFkM2FM7KB/6IkfpZwZgjowE3mFJFmpk9h10LcQRQnu5qjAQjnanBZNf+qX/P+6AFC6v/usCT0QIZoNTpoC4YXrWcDDOjF5Ohh50Oo2El1B6i5rexRGJ2KLwLOmrhXc9BXeuma1QU5TVuNoW5UrifqWwrriqJv5KdRMMiVuSHa/tuMjqPIigZxhmAv4fdrMSpvSHs05jXzatF2yQZYLULzFXxj3w51navJOgGV9sekY4ZVCrYtBtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fY1B3p91iOTlsjSKRTjPLXTxzW8SB2h9j2n8YR1TLtU=;
 b=jObiAl4fbXjwdMPHS2pOE9DmGRiggLinsrNg8xI9jiMjDjfYJuS2vtaYfY+61SoJK/gqMZnd2R92Ika7qg2brsmcvOZrqkZohZimsgyBY3tYeUKPopbH6i35nFQQ1XJPKM0A0AwOFyFyPu2UjcNlBIM0AaXibTCr/OpTmQ/PWdW3BoEU5wmCjNoORBSkquDif7ebRqx7PD6qM1xbjh7FmVm9cfTlDpNzLt+wQThpG+wFA2nfYGRiy+xYt8JoLIwlOVdAFvTXTys2grV0A1HSss4hXZCRHx0uWhM+9NyD4+QwvX6+OzQ01LCpkVdpNPyuuvTbmuXeCi5r2w1MbJtSGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fY1B3p91iOTlsjSKRTjPLXTxzW8SB2h9j2n8YR1TLtU=;
 b=GiS7XRp/miKevY1J6tDsEC97dMjhdxxh2qfTIbJnzDSSzvPwJX5TQj54vDzE6K7NaV4zVtet4oPMFea4fSc5aeJncffao3X8nSvXfmkMaIOcqtzsedKdbOg5Xl5NKyjNU1iKv+XF+XW5iSBz8xXeHustrRmNEuH26qg4nOmYavg=
Received: from CH0PR04CA0072.namprd04.prod.outlook.com (2603:10b6:610:74::17)
 by SN7PR12MB7811.namprd12.prod.outlook.com (2603:10b6:806:34f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:53 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::53) by CH0PR04CA0072.outlook.office365.com
 (2603:10b6:610:74::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:53 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:51 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>
Subject: [PATCH 24/28] drm/amd/display: Add fallback configuration when set DRR
Date: Wed, 3 Apr 2024 15:49:14 -0400
Message-ID: <20240403195116.25221-25-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403195116.25221-1-hamza.mahfooz@amd.com>
References: <20240403195116.25221-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|SN7PR12MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 17329b4a-14f4-4dac-c7df-08dc54178300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dcmLAVZOgHVDTDDOKZrlbcvo8bHVlCHtSpcFnLl8Te/JpQW1LwA1XOVgK4RwWq3n8DjuuKIL5qzWfeCtU/e4QGmS8IOTUT0+ZlpYtfZPzAdwai1V7BctegsJLWcfC9l4Io/gYWkuPprEC8J127BVvEi4rP09qUCpvEUaIh72EWNXXH0cPIermSVeCI7JI53ICncbt0uKtVST9dxF4RkQF3eWQHfNnWWBZFZni8OQ6n95u5/4glx5R8XUB/JZUh9U2u/T3viZvS0rIF/51uiovsgOW+CukjcwRruWU6uAtdxg7qiWuP4JgwNTuw5OOcTUt1uVfbZ/7cRzF19p06mErQp3NrTYpNlz+y5Ny0j4mGyo/NWaBl5p105pspGiWeYHA4zY8VGXNJdFs2IPdp5m6S6OVm7bOTrKnmnULv+bNpz8l8oNqZf5NScEn0UYTaiy0IdI9K53W3lroays7s+ZT+vP7l5aOp7astKrfEdRCnuw+yLlo1kEi2OyYb06hOYwwNe/JV33RZgAg9mwIB9NzvmDqNCwFgE/yJMxYxFa8D4UuqBH9dpbZKxIIiOGxsHSR4sLSGiXGSc/FSkgL0wtRpBdDcociS+uHu1rPiafi8itYC17g9QB+bXmbO3jcmgK65IVzezx1j82u7BEFxhJEdQwxYD5GXEfBwNIfzweznzNv4xiuF+nAG9kcrrtoA9t7pvHzYVkcl6aL/8YNb+lt1YJLrYk/nPlxdgWAkTZlotawD2v2gRtlQHVa9augV8p
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:53.7990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17329b4a-14f4-4dac-c7df-08dc54178300
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7811
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Set OTG/OPTC parameter to 0 if failed to set DRR.

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c    | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
index 52eab8fccb7f..c4f0e1951427 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
@@ -293,9 +293,16 @@ static void optc32_set_drr(
 		}
 
 		optc->funcs->set_vtotal_min_max(optc, params->vertical_total_min - 1, params->vertical_total_max - 1);
-	}
+		optc32_setup_manual_trigger(optc);
+	} else {
+		REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
+				OTG_SET_V_TOTAL_MIN_MASK, 0,
+				OTG_V_TOTAL_MIN_SEL, 0,
+				OTG_V_TOTAL_MAX_SEL, 0,
+				OTG_FORCE_LOCK_ON_EVENT, 0);
 
-	optc32_setup_manual_trigger(optc);
+		optc->funcs->set_vtotal_min_max(optc, 0, 0);
+	}
 }
 
 static struct timing_generator_funcs dcn32_tg_funcs = {
-- 
2.44.0

