Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059C0CA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A327710E856;
	Wed, 10 Sep 2025 05:33:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rGKSDPhh";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8EEC10E856
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:33:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNzcVBIF+tn9qkev8bRQ4TH3AJXP3VYegfC4T4nBwKj9qWwHZuinDK6EwDyBrj66XskM+ss782VJo8CU5SKfoBgKOHeSZ4mMrCLxYf3Db4BuiwN8FYSTEEgOQYkkGIXmHH8XDC6ZxkT1hmTg5fyrROzztMHu0iZTQ0BBne6pEL8wUDDHBh327R1phSev5XYahw1cTkPhBb9SHiJ8wRALBIRg3F4AWI5B+LhNikLApZbhe7+2KKb1mCNWS43O4O3YRuDiBhY4v3X3pqNhqqJeIXe7zhP67XhmioJd+jNkGIxqYss4oFP3p9TMH954Xz8jAxZA1XNhyWopUqUjE6pfgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HX2lzheraoOGwccS4AltJp50dUuWxR56J78j5ky/2E0=;
 b=hqBk0n9o3V5AsIqma9XSk1fBypKhc2TB6lHllJQWbOGgI8UyYF/if5EJ3FOFQQQ+NfIbJNol4qVJgzxSwhMW8emT6FqCrSTq4USVGPBcOkyUHAR09OiMwtoBgTI3j9n2PldWZI4Ciygcfxe6kRZvTYeUPffKXScZG+g886BozPf1QdLjqKx1qBfGc4ztVEmqh54XDkno680PGLjz7U6c93eaEDG1EAvJNwMMj0T28fpdwJvi+uAhmeR4eSnIg6k5oSXMkXm+XARqMJ173F08+HChDo+UA4B6Pts7855fjQx0UMH02ShDD0lWXTaAJpWY1R7C3hYdW4FGQ9CsLF3v+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HX2lzheraoOGwccS4AltJp50dUuWxR56J78j5ky/2E0=;
 b=rGKSDPhhOMX4l5/g33cog0vtk+/33zHgDKiRJcaBKF3ORIQJmXXirTkuh4iRJ8rASCofHYkls5IP4HrPvJiFgc+6dUXqiYMOiDmPYe2UCky/DflaYTvF512B7Vzzk+Wfq7juCMxstuUkwMBLTGWg5GxlmpwhtdFrC/UhWaUfrZY=
Received: from DS7PR05CA0057.namprd05.prod.outlook.com (2603:10b6:8:2f::21) by
 PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:33:49 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::b8) by DS7PR05CA0057.outlook.office365.com
 (2603:10b6:8:2f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.14 via Frontend Transport; Wed,
 10 Sep 2025 05:33:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:33:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 9 Sep
 2025 22:33:49 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Sep
 2025 00:33:48 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:33:40 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Taimur
 Hassan" <Syed.Hassan@amd.com>, Wayne Lin <Wayne.Lin@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 15/15] drm/amd/display: Promote DC to 3.2.350
Date: Wed, 10 Sep 2025 13:30:38 +0800
Message-ID: <20250910053222.2884632-16-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910053222.2884632-1-ray.wu@amd.com>
References: <20250910053222.2884632-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|PH7PR12MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d7be861-6e8c-4a45-eedd-08ddf02b9ee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s/V5wL9vJ0j/B6lM604xRXFCJzIn7zF2QJbCiKx6SVVvA74RH+q20XemZqla?=
 =?us-ascii?Q?E0r8pJNZc/ykMn8zWSIC0BJo5iffbniqKDUiKciSNl4rLIzU6D5z3ly7R2M3?=
 =?us-ascii?Q?TNFSDIF9MfOhb69fcvHKe/PWpCo/KkRi90Dq38iyv/qlaXWIfsYRcSCqG6FH?=
 =?us-ascii?Q?patS6XpGbvRiM2T+P8BTgu4qIM6SlaBj3P2cwMgn2EEdYNf38O91nHz5Gzqx?=
 =?us-ascii?Q?6AdxM+W/y77eYhZmibuftJQZLLYZAtuI+MC5qXxl0lzfdh0HF/LgWTxVrWCH?=
 =?us-ascii?Q?IiiYFFdSz/uUdFHoWY561UePI8InXRBQ49hcimXrLOq3Uu5l2vZWPr7BD+QT?=
 =?us-ascii?Q?DyphXZKTfN+la4tzK53SAF+mRk4p2VpqUaxCY0Ylyg+FbScGZvVLWRSG3nQm?=
 =?us-ascii?Q?HON1X+cXTt+zYf9tSZVr8+sY7SEYnJrSbuGrDQ6j0C7ZmNMCbFKR/CJrLvqh?=
 =?us-ascii?Q?OQMgRfYTpuCOk0n1aWgIVLdfKwl1h13haGypYJDOSb1sEk8shLqDW0/hwteK?=
 =?us-ascii?Q?0Lfbo/OSXLUNnfqhXtFBOvSYOoNye1etmppf/LQvLPIqwLkLFPwDKHCwrvSG?=
 =?us-ascii?Q?OkDMGo6o0/gE9Jb+FhQc5P0PN/iD5Ryi2bwBZKGkP6tk6NFafZmLqfORQg8F?=
 =?us-ascii?Q?rM3NRWgirG46YlwuybqftB0XhzBRqYvMuAlNBEYly2IHeRyynYjGHITdNLg+?=
 =?us-ascii?Q?E51vqVrmHchKMthuJXUbFJVzqsEgSs2nWNGjGtMUS7GqyIh/C98+Fc8V/NJI?=
 =?us-ascii?Q?xiiNwTedcLWSZBoKBHVqJQGoc/yDeQ0wReEcnPyeDjikzOrRsavjwZ35RSNq?=
 =?us-ascii?Q?Ggv3C64Y7w+FSa/EoZdFGcgdi9YpzN/aKlhf/R3800n5hmmu+tYYGphS+CZm?=
 =?us-ascii?Q?EihVhn9HYga367+icnbalhXFQDpPDxBRr+Zigoqj7ClzrYhTb/TpQlbP9x+i?=
 =?us-ascii?Q?d7CmPdjSsw4p4frbbjhdYdQYDZOTgK+9ThYo0mhM+WvBQT+qGxW76ttpLXYR?=
 =?us-ascii?Q?LAo4XN18FwQoBGPwTdiAKuUFVr/DGz/KI9Z/ph0O7Izmv1NvQXULDAFlgOXD?=
 =?us-ascii?Q?MoGRYlLraOpdiN+NoaXjBcJeJrBKDEScWk586hxDc7P3KRdZ0jwKBsae6XPb?=
 =?us-ascii?Q?hDPLgKw8BnoVQtGODwjpGKeTBfGL08PZJmZcCabEEIH0iFvzcFaPiXxv5CDx?=
 =?us-ascii?Q?igicdbeCZbdywKgvo+drrttCzRYs9WEO3iLgovZEZHQqOTdMuWXMFZX0y8yQ?=
 =?us-ascii?Q?jmXYMpYuLopsXBSlUkSA92nCV+a6fIdQQYHOuGBC2sbRvq8Ia8BvR6z5sWI1?=
 =?us-ascii?Q?KDKuDrXNf/e01E896sL8c1iXUZDqIUyfV6snGWuovYDIgovxwYBw69bfywhJ?=
 =?us-ascii?Q?HUzA07GV2nrgTrKTEnitellR9iAofKCH5hAKOHickQqEDoQAfA+POu2PUSLy?=
 =?us-ascii?Q?Bo6uLrQw2/JAhLKNR/pBusn9ANxqqEG7S9V6YArhEOc3H5dZQ/tMaE8s8S9R?=
 =?us-ascii?Q?Z77EUoSAuEe0Rhscykdmhgs1DQr6ld0buTD7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:33:49.5479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7be861-6e8c-4a45-eedd-08ddf02b9ee0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594
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

This version brings along following updates:
- Add DSC padding for OVT support
- Setup pixel encoding for YCBCR422
- Fix dml ms order
- Rename header file link.h to link_service.h
- Fix DMUB loading sequence
- Modify link training policy

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index fec056d43535..19c74f56aa5e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.349"
+#define DC_VER "3.2.350"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

