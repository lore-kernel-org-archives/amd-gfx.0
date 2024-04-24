Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2500C07E8E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69D4010FE34;
	Wed, 24 Apr 2024 08:54:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nCATVkh8";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AE3010FE33
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:53:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k51dvhLLJwemLKjLoEIlRTPwiEKSJNna8ZzdM53Ja7Pwipw4fVjsaUUsTz3ydrZMWlmwXyVTA79I9jY9nkmquVeOLYSlJ2FSNLS84qfq1iitTTh52q8fKvkcZp78aYI9pF8ybyarIJYwli6SFd1KonfohRAH68kYl72JhGhe04+L5vnU90PexeygWyIuxUyoKhMg57qhxG4JB4BAeMaF7A1wHxnBJPMXFwRqMp/hQ/dX4WkxYfzp6+kzZC9h6e1y4NNXiwRS6KXbGp0xj0hq2UPsqkEe4tvqpzmv2PJoJtz3GMaYiWgzhvg/Ac3Pz9AJTwc8guY4qWjUY7GZ9oAE7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpLjqokHDPIHtbRPllDy815AT8DqKr/vO9+Btwx1EWw=;
 b=DMAgpJ1YX5ZFn4VdxLQNy1MxqbJ5krMEDdXln9yMwubNjpo8nKb/mIswlg916n54wh3Qfp5S5NrD4mt7emCEYl9nqTouTIPHy/Dd8ako8w4BPrkJt8kPuhYGHJK0xKO2WXUVchvfldANSBFe7SQgCpLfiotBMr/x5UPGDeyNSYOLODnJE0vlUpyPoEL6znleH9md1Gg/A380gUMrBZtWi45U3ffzk7e2sdMileU18BC1twVe31YyCO/VIAAETGnkrIr4cLoKZvwp+pFe/sLoHVq5IBr0lNZO2t8aYgzHaGWkMv8W9tks1WI6cEHk+bQjnaijwakJPTLfRgeBN1vyDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpLjqokHDPIHtbRPllDy815AT8DqKr/vO9+Btwx1EWw=;
 b=nCATVkh8yeUZUGZ2jbEm+7l3pCeMekno0Vfunlxo+/p6MplomRMd6fKj0mOjT3rbdNJkxY17LoJhmEN87Gxgn+lyOTBhA5eYuyjY4hQ2a/rxh4GK8LOREtpq5yZOT9EYC6jRju1/9hvMjCDLm4vQ49wWEunYAHY403NV+4DcEQc=
Received: from BY3PR03CA0029.namprd03.prod.outlook.com (2603:10b6:a03:39a::34)
 by PH7PR12MB6978.namprd12.prod.outlook.com (2603:10b6:510:1b8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:53:57 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::5d) by BY3PR03CA0029.outlook.office365.com
 (2603:10b6:a03:39a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Wed, 24 Apr 2024 08:53:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:53:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:53:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:53:55 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:53:51 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Joan Lee <joan.lee@amd.com>,
 Robin Chen <robin.chen@amd.com>
Subject: [PATCH 40/46] drm/amd/display: Enable Replay for DCN315
Date: Wed, 24 Apr 2024 16:49:25 +0800
Message-ID: <20240424084931.2656128-41-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|PH7PR12MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0a31b2-3099-42b5-cc87-08dc643c138b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?td1YfMRYhxM6YXcrazadA5fxKpCXG//idx6IaWjxW3A7XcsLt6PwPm4FdJHe?=
 =?us-ascii?Q?c2Tk1bH1yPYGpe87lLaxcYmBH8URrAp0ZNz/AMICFEIj8Sdxyzid7aMDvqXh?=
 =?us-ascii?Q?85kxyRpLQNcdw0Lvb1s1FMx4yYQ1vpH1utg2MMJWWk1tG8T58dmgAskQTdgX?=
 =?us-ascii?Q?Bbt7TsW1GTbq97DrCeLFVClwuc29vVR5dG76s0EftFQSjVJ/PEiX6iEWyBKN?=
 =?us-ascii?Q?fkXf/dH9af8meM11qMb96zyEc39+F1m1PhIZh9MVTXnL9wlWGOXCdrm828Z8?=
 =?us-ascii?Q?TJW5GxJpF9DWYs1ET7YwGYkeLPHCM28yRC5vq+6NAnGA/2UySp3cyK5jSE40?=
 =?us-ascii?Q?Aa3Y2ln0yXqCSoN4ooIFeTIjC7ZmwBU0LO7H3GBCD/AZohS07xxZBn8fZvMb?=
 =?us-ascii?Q?Z3EQItYxMKiqXvh3CnL8IYxR5KbB3cQRxXQ9ESYb0tWc9h6mNrrycvw6NoPp?=
 =?us-ascii?Q?+jxPluhoZ7JYBX/yCVBd0nYdvXqBVfvKHuvdZUizIzJhn2B0RCp1ZoMbuQTd?=
 =?us-ascii?Q?CO9sTEDVYf7z9u3BezLj5mSBIejxxFAINarNaNCFIeBcsA/MkKakxtvw0KvS?=
 =?us-ascii?Q?k9KJKjqoYpF7t30TTVvhe8OmIvxHSso5gNqR+Rnnjcut4GJw7KqJ/P+TlXh+?=
 =?us-ascii?Q?kFDneotmZ10ahaqqWpcU/vHlyWMQjjLWYzTFKu5aKvWoPGjlVxAfEtT2XoLO?=
 =?us-ascii?Q?L4wWSV3LP2XWpW1v+y9qXD6N0c03mI0JpNGo6d0HMbW7VN4fQ+S7HwVYbgb0?=
 =?us-ascii?Q?/IbodBV9r6IMhTR1OcRsRD25LyiJyWmuhq4J2rdc2d995zVNN5Wmuf7iSqum?=
 =?us-ascii?Q?bNNY7IIr3t6XsKNd5AduVVndO+qR13Pm2HNQDom5P2F0jYMNI5VaNtycZy+T?=
 =?us-ascii?Q?5LoJZzZEs88B/uXlsi6kyQGGaRssztINY0hVLFJo2YY168rcNoiJhDkeWVcU?=
 =?us-ascii?Q?StHwjkoLdx86v/xHsCReAseaRvCG4yjuceDaEzS7ZUyHIbxlsRcA8P1mblcZ?=
 =?us-ascii?Q?sKNjcbu5NbqJ6AqHIk06GaFwxS63/U3F1g/A238vkHbdZFXx+60YYy4G58n4?=
 =?us-ascii?Q?QUbxW+rnhxmOwOItex/oVmdrcFh3xtE6SZpqDygrut0hvCZIxyMmyKeZasZz?=
 =?us-ascii?Q?4jiP86xGn0hZsAT07dFelmUomZImtMbtODphBtvJQnyNtIx1LyTugwKXwmq6?=
 =?us-ascii?Q?1EmY8DMHi0kDI0UDxxVQUx/h1s4buXHbyEKD+MESrsUVV2DFNnlRcizcnMzd?=
 =?us-ascii?Q?8BC2rCJrg3M6QwvECQ2qO9PM+ysz0kG8aFCeJng9LN1CTtYTBQBX+dZeKXn4?=
 =?us-ascii?Q?e0rUrq7SKT5bc8YO7TCvUZ5V/f+dAKOnRs2T2/4+twF4t4aZ3vEcxKRP3450?=
 =?us-ascii?Q?/vhTKQDBUzBG9EbCrs7CY1ctoE3H?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:53:56.6949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0a31b2-3099-42b5-cc87-08dc643c138b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6978
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

From: Joan Lee <joan.lee@amd.com>

[why & how]
Enable Replay for DCN315.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Joan Lee <joan.lee@amd.com>
---
 .../amd/display/dc/resource/dcn315/dcn315_resource.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 4ce0f4bf1d9b..ad40a657e173 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -125,6 +125,7 @@
 #include "reg_helper.h"
 #include "dce/dmub_abm.h"
 #include "dce/dmub_psr.h"
+#include "dce/dmub_replay.h"
 #include "dce/dce_aux.h"
 #include "dce/dce_i2c.h"
 
@@ -1484,6 +1485,9 @@ static void dcn315_resource_destruct(struct dcn315_resource_pool *pool)
 	if (pool->base.psr != NULL)
 		dmub_psr_destroy(&pool->base.psr);
 
+	if (pool->base.replay != NULL)
+		dmub_replay_destroy(&pool->base.replay);
+
 	if (pool->base.dccg != NULL)
 		dcn_dccg_destroy(&pool->base.dccg);
 }
@@ -2048,6 +2052,14 @@ static bool dcn315_resource_construct(
 		goto create_fail;
 	}
 
+	/* Replay */
+	pool->base.replay = dmub_replay_create(ctx);
+	if (pool->base.replay == NULL) {
+		dm_error("DC: failed to create replay obj!\n");
+		BREAK_TO_DEBUGGER();
+		goto create_fail;
+	}
+
 	/* ABM */
 	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
 		pool->base.multiple_abms[i] = dmub_abm_create(ctx,
-- 
2.37.3

