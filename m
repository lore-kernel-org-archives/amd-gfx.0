Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4E9CD3440
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Nov 2025 18:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9428D10E794;
	Wed, 12 Nov 2025 18:23:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tw/eJDx+";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7092A10E788
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 18:23:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5/ZnUaPFuLVR7dFTGw5qIFsDc404oogrkz4hoHzzGlO1iZPmen609eDhZfJTZoxzK/3Bcq+EdQ2QZMBbRH5maF2FN6OoHRYiQpdi9qK0+oPWy2OfaCu1gzKo728cBCTgJtlGHCICP1AMHNe8V93rhNnkzvk0Wdi4YE6a5KPF3vabSh/GrebcYwRYhD1vRLi27LoBaFowIBUti6T0w0WS8YrpE36jLSaUcON4tH3QZXoLBihRue/XGuQEUTQTF0Tqmwdz/Mh+JclikgAz3mxdV34Ti8LmT1euv0CCj7cEzNoEL+wiuDfw5+meFcCn4dNxm7ORAPH16Hul4VhG6ZQvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPFondEL+XBCeGpGvCLU7W9cOIDkMNaZi2Upx50IaJ4=;
 b=t9PllzCg7zZzUNWmRjinxyjN5PNB33/uOtSFv7Xve9dIIMzwrdHb3y7cELGmaxQ+RYq83hxZY5tZg4GpF2oRwp4S+OKnBvNaJnWGWoLUB6gvo9vtkAOyLWodBbF0ko2zVCJDOuQg9icuXO7BSqijoDgNKhlQh5moTk2HjnqukW45v84lKdLMi9lnpKRPP2p2/umpvN15EPphi7VtLA+dWlvwg85FA6iRVRAzCR6yacogPZTlUSy0oGsMrdHloiMgV6iSeRM+fCnwkDt5HGm4OX9NxMjNANg6nvGvv5dQaMOP9qSOQPfEnSqdSAonnMKRNsMQmyWWNbNGVo0rT4yGdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPFondEL+XBCeGpGvCLU7W9cOIDkMNaZi2Upx50IaJ4=;
 b=Tw/eJDx+9855m8TPZyomZ/iHDPvIplHThhmJhcn4Vz3xiUOv/rl12V9boyTXJ2eFrIUYSvixFCHr/MofIB4VUD2NMqe9HFcy2qZCIWCUWJ5iZp9VfhlkK0/F7c9tzzmDku1ZKNhtmRzj7hdbYXiqPR+j1Ii87SaqoiRw4A4TXKg=
Received: from BN9PR03CA0652.namprd03.prod.outlook.com (2603:10b6:408:13b::27)
 by DS0PR12MB7945.namprd12.prod.outlook.com (2603:10b6:8:153::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 18:22:57 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::50) by BN9PR03CA0652.outlook.office365.com
 (2603:10b6:408:13b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 18:22:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:22:57 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 10:22:53 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 10:22:53 -0800
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 12 Nov 2025 10:22:52 -0800
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Harold Sun
 <harold.sun@amd.com>, Ethan Cheung <ethan.cheung@amd.com>
Subject: [PATCH 12/16] drm/amd/display: Add null pointer check in link_dpms
Date: Wed, 12 Nov 2025 13:20:30 -0500
Message-ID: <20251112182212.559007-13-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
References: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|DS0PR12MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c086b52-3261-4990-5aa9-08de2218812e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DN7jqsBsjB4fGrwML18X+2crzSlXE/JiQXEh2vQ9afUvjboPChZB4vTIve3q?=
 =?us-ascii?Q?+Zb/KBQVl9xWD9vywqVpKbKJDxII7/0Z/uu+Js8eJofs57dmULMLREy7mdWB?=
 =?us-ascii?Q?3lDGmYcRzgrrMfmwjAo2QxkV9zmjpc8C143CP/jvhJCiSs7yX3v4BPFjJsp3?=
 =?us-ascii?Q?lokNKy5Sn1Pkx9HCvHHCJHa1r3tDSK890yAhY3tFjO1nfUVG1rcroQxZaHf+?=
 =?us-ascii?Q?IanWV/xVNnrqlLLCdukolkCcSf/AIIIxW+fAisFomwzTafyi39h9yoELJDi1?=
 =?us-ascii?Q?XlK8xYYOp6jVkvmLMseE1cGWtoipRc/Le4lBKVQkqOxw5iQo41ZOAT332Hiy?=
 =?us-ascii?Q?GlxGTvH8h7+ZYUmWcJEY2z6ZE4oyWlNbO9FNNeEXCQwuWu445Yk4+0Oe76vV?=
 =?us-ascii?Q?/jZpG5BvgebSxntmZ7dcIXZbTd1MwbAYYv0f/ZdrNnl3UVjzn+IkKv9AuhGV?=
 =?us-ascii?Q?bupofwlPV60jXluRIsM6zlBAr3Vd2V3X8g5SEOYkHAzZDRKr7GhwTM5Lxvk3?=
 =?us-ascii?Q?KC1UjFC3WfYjHWTc7G7+E/AHpYUJeyYgJdH/lYEjtr8pwcj0VLpmbCq+za+W?=
 =?us-ascii?Q?B5aCNZmRYfmuN30212pSAFzhmxDy0a47SCPNCVNZRE3hYHkzIxwcdxHmO/50?=
 =?us-ascii?Q?yBGvf0e7v3uYMC8XY912EpQkdv9ANbqYznqS4xeZCF4bmUsjMY0S9ktRLmMD?=
 =?us-ascii?Q?nfFYcXjf0DTCwIqdm+u94NwcQk1LYXCV3MPvqsKEykxjYRnP2Rw51kchYsae?=
 =?us-ascii?Q?fKRRTNg1YGSJFSKJ60jv8arv8iUAotCqi3Ejl2mcEsMldIIk7caYGHYmdVbw?=
 =?us-ascii?Q?Kx+s3XgkvjKIBHj+Av/JuVHwslSxGp+9tBljtpHYIbYj/72GMi//rh94DLG0?=
 =?us-ascii?Q?cFxFQUVNRdwJ+HNOhHVW01maSEZuduqGVULzNWYt8Nya1scmEBHatE+aJ0KG?=
 =?us-ascii?Q?aQSsdyHKoLjPX+9GkdgSFtt4PO2GLp1rXWmUerdaFAUT5+xTcHcaVFmhfezW?=
 =?us-ascii?Q?hXDw2l9tkxnjNTEigHFIcE0V5mn5esGg+oWhU+jU/N7hQovXuK+M95USZEAF?=
 =?us-ascii?Q?7hFoIuHgClv0LvGzzJH3RAeKZJSbe6KYMQew8wKIRVOAGSPlsvQWepB5In3V?=
 =?us-ascii?Q?YaFqiWHkiREOVPfq9vLO9mxEDc2DSqCXpmnRZhwOrKNpo0VxY5I1VlikLvUS?=
 =?us-ascii?Q?H+0uHaTBesD9bfdZy4B86Cb/UqTiPxeGq7YnfOgRFDuRhjgWRRkl/N7/HaEV?=
 =?us-ascii?Q?GFjaWETyVU+Bdcetq7ZihL+7R3AapTxvM7jE8tYfwEXBg8JKbLKAhjgxkJyA?=
 =?us-ascii?Q?dESwvTnzEYzIFq/wiweD6iTiLuiij1dGqH66LQikwosW6MconVaF2KEFRLVM?=
 =?us-ascii?Q?RpBnngGZcFjSWcQaDP5YEgQc+01+zKZsPTruCVvTekTIK65uk84yBzFlSzew?=
 =?us-ascii?Q?fcpONG+SpybLVISjMYM7djvYsuJUcESvk59fjJZMaKZpy+n32xBdWmrx5kPB?=
 =?us-ascii?Q?7Fc3buutpMtyDyXg37ePVe2SppSrU/+H1ryPqy7EhpoSLWUdLboY1/TYx88B?=
 =?us-ascii?Q?l15iN1H2paKAYJ6dU34=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:22:57.4605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c086b52-3261-4990-5aa9-08de2218812e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7945
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
Check that the stream exists to add link->local_sink null pointer access
protection.

Reviewed-by: Harold Sun <harold.sun@amd.com>
Reviewed-by: Ethan Cheung <ethan.cheung@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 4ddcdc222913..2a70dcdd2e47 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2226,7 +2226,11 @@ static enum dc_status enable_link(
 {
 	enum dc_status status = DC_ERROR_UNEXPECTED;
 	struct dc_stream_state *stream = pipe_ctx->stream;
-	struct dc_link *link = stream->link;
+	struct dc_link *link = NULL;
+
+	if (stream == NULL)
+		return DC_ERROR_UNEXPECTED;
+	link = stream->link;
 
 	/* There's some scenarios where driver is unloaded with display
 	 * still enabled. When driver is reloaded, it may cause a display
-- 
2.43.0

