Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBB3C0219A
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 18:41:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F175510E393;
	Wed,  5 Feb 2025 18:41:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K9jXtJYl";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D32A410E389
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 18:41:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDmX33NLriDINwOh+xEhxxHvtwkDvLvmlfmm4HYD9RaadHlYBNFF4a1vijejcZp7snqKZwS7EN3MH4si0QD42UiNK2rms4besm7utlmIqCLFjwWzthlADAXXjlxKljFza/3KIwH9MOKEMOq72SiAQFUCLb+GuDot9bfhgXwHPoI3koARVtN2Rkhu4EenTJkTaSJ2MIPVW60ETi04n9myPg+jrbLSDL1+ANouiHuKYUjPHyr6aMISvmWxQNmnjyEU83gLK3k9Nd/mx66uynoyDjH+nBfBWMavZg0orTrk4oqikbhL5xTX4s1j6wrnEVw6pm6A1OZwBRp2bq6/20T6Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qs/nSXik1jpk09ZcXtAK7GhggnBiNsqaD7W+mPjmgc8=;
 b=avvFRLjKgTVCKe3Se4cusBCEEMN5GjCo8mffTDDmNjOiVcrhNs3ok46a+ZKjb+lkqDZUjKS+TbqExczKLu/GtnIO41ZbZRzjXwtvi16N8OzAq7jp6hYsut6TMgumxXVjpKj5Ti8vuaxITraQg1WzA+LtONkM/w7PejBo2AK9vfeZiSikogceJgtzUMTwPq98YLYTeitdlU1eIidX+aH05uGk7zePCbfNPV9cPjAYsYbLZdZRfOP8aNlKu39Re5aa6cQSKu3s6qUVjDrmumFbvWC/rq2Ub7FypW4yLZILYrbZfTWfBXnnQDFBPFzzPGql89U7iSvdPcxdUTLptTYoQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qs/nSXik1jpk09ZcXtAK7GhggnBiNsqaD7W+mPjmgc8=;
 b=K9jXtJYlssleopiSGY81sW0u1DPMin0YVg4gj8vj7KPqZM63MNnbv+bGh92FqeXEgOoEripdXTkxzLpNqDUKsQQ5/NpOqL8cGfGeshKYc8KGbO+Et7AkhnLDT5PPd4Aqy5YQxTlsWKioySeMTqgW37ngYWxMQkxf28KEUNeLXM0=
Received: from MW2PR16CA0064.namprd16.prod.outlook.com (2603:10b6:907:1::41)
 by SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Wed, 5 Feb
 2025 18:41:17 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:907:1:cafe::23) by MW2PR16CA0064.outlook.office365.com
 (2603:10b6:907:1::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Wed,
 5 Feb 2025 18:41:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 18:41:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 12:41:14 -0600
Received: from aaurabin-cachy.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 5 Feb 2025 12:41:14 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Taimur
 Hassan" <Syed.Hassan@amd.com>
Subject: [PATCH 14/14] drm/amd/display: 3.2.320
Date: Wed, 5 Feb 2025 13:39:29 -0500
Message-ID: <20250205184036.2371098-15-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205184036.2371098-1-aurabindo.pillai@amd.com>
References: <20250205184036.2371098-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|SA1PR12MB5659:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c2feead-61b9-4681-263c-08dd4614ad38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SQu2mnRQKy7wXJBudKJ/u7TfwibrSPqwqyh7HA5l92lNWAFHh/1+XpMfqfDk?=
 =?us-ascii?Q?1tgoku8VIrILSh/nUrWdb8VRuWrtEgue+ZUw7tAq1SLM6MT4T6uYJrt3Mnl5?=
 =?us-ascii?Q?4BUhURzOhOUPaxD06WRaUmnyxTuZYeZECIaGle57S0vKlEm46Py+uHeGi4t6?=
 =?us-ascii?Q?7HGFT59WL7PGEuPYyuwWL0mkXM2XcHSQt0Pfc0c56R8wB/rJ6Dlq3gis0QcI?=
 =?us-ascii?Q?diGcYuHF/SmeEQA1bqAf3gLuQiPn1ZBU8QldFm1J64peEdELewu+z4K8x/d7?=
 =?us-ascii?Q?ZJkRZT4xZ4b5+1E8eTX9IdVh0cjWyhVpK1fNwFlh5kYDMjDggd90epzy45kh?=
 =?us-ascii?Q?OzC+lvUCYwNa6phXABgKD4XCiebpy4+HRCeMKzxF8ovTnoSjg3OCZ7gW2+Lq?=
 =?us-ascii?Q?f8uL61ilIfFkBEg7S7uP0xaiDlxflB8kgIMa3X+Fu9hxU09YBJtGuIKiZ8Ml?=
 =?us-ascii?Q?npkY0yltTp10FqtrWT/FAVBB+BOUG5SGoY0J/nVN4Hqw4PzQCtTw9dqfg8Oe?=
 =?us-ascii?Q?JSmcN3hnoTtuERheqrxC6twenpvbxAcusAvP6yfIpm1Np1RFXSU4C0EaFlE+?=
 =?us-ascii?Q?jTbiC3yNGrerN7kN6zlSDhAQa8W1hwHuGVKXsJir6xL+iBuhHRK0Ub3UaDMn?=
 =?us-ascii?Q?bGnh1yOAXd/xIWYLeMGJ3JMUfLR8drG9qO3xgnj1+ob3zNKWn7/mDBxeq4Sr?=
 =?us-ascii?Q?JwUO4DZsAXZVABO7REExKi/llcGYLZr8g9V5MNEO+xx+Li17/Q2WSET5l7Js?=
 =?us-ascii?Q?gBW5+28fqNwBV2vLn6IYaFND9WuO8oYoeCDKzDnFhIoQO8oFQpDf7sLbAnwk?=
 =?us-ascii?Q?3LnIpao1nhGBFw/5nmtNTa96HKJEMUjIPHom534xtONXPd1p/Th19L8g2500?=
 =?us-ascii?Q?zREsC1srjuH/ZajvV4AD3wLbwQ63oRwnJCmUpK8SpOnfick+29qE6Swr6VT5?=
 =?us-ascii?Q?LpdYERf1DByF95X+eQ3KaK1VL+csxj+ZnvoemQZsuP9GcfcFkWB6XX14MHdE?=
 =?us-ascii?Q?g8DWx+CFQYU0dwn5TtenzW8Rcdd9FJ3anBz+y7u0kBGErkuJzT4STdOFrmzQ?=
 =?us-ascii?Q?9pXoMDnQtVFIzCe0cRHEtfYSq6LEtsLXodZIyeBlTfMs/WmCyfEZXm3TtmGG?=
 =?us-ascii?Q?Yqr3zMlpzgrxI5DqzAQlhLJxgGgDU9HTQ35Pv0hBWKx4MZ6H7KpeJdduJ7ej?=
 =?us-ascii?Q?I+XmmCaqlhBTKH6OMSEz+9aQaMZL0EgfPzAhapetrLlyqYk6VW57DpmT9Wop?=
 =?us-ascii?Q?moiufcVsd7J6YSAXYzouxNsayuNFKdlKJhBAyV4eg1G6OQIjXe13OypNBMgn?=
 =?us-ascii?Q?P7ztKlEDd/APCgqI2u97+2v104XIfyZI5Z0bKSyiR4BBunsiknpCGDyZflF8?=
 =?us-ascii?Q?mRzL0NNhTUkcHLvM1Tu5JHkFzF1tgHxSG1eC5GgRfjn1hs8mVB8qbt0O60YR?=
 =?us-ascii?Q?3zMCcOBepxDpFcvp93MLBHXyVwizCFypxzNUasokvODXx95G77sZpeLNxsXK?=
 =?us-ascii?Q?huI005gokNyJHHU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 18:41:17.4344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2feead-61b9-4681-263c-08dd4614ad38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5659
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

Summary:

* Start enabling support for 4-plane MPO
* DML21 Updates
* SPL Updates
* Other minor fixes

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 16cd7833e931..ab88ce02893e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -53,7 +53,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.319"
+#define DC_VER "3.2.320"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.48.1

