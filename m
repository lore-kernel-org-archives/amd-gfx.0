Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F42C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C70A410FE4B;
	Wed, 24 Apr 2024 08:53:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q3MHx/wK";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75C2010FE2E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:53:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pllro+lvGAMGxZCs9rAc8qyYDbZos5eQIP3KknK7kNwdbkgCteJzKgyPe7yZNKbwUjc+si9Q2E4TjgsJkTUk3LYNNDPWjmDPft6BDycqVJLOR2Rl0EHa31wiZBnwEjhvRzMJkQvS0WcyuCSuC7nlzSBBKLVrHkD1sUarkNTzq5xGn3/3o9Dwx5kqY7jj3zSdoF8lbhcNnFv+w0WXct9KsFzDOYtQa0CHyUuXaSzSahxJQbAxpnyfya3SG+MSYi8zcXw0O/MGBwTdMcsVK4LL+d4LEIIX45tyWAYMdUHDpgXU4iqxKZRle5cYESt5g5R/vOxgLI6FE50OD/8Ibhgvpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4ilDspI8+zs7iTMDYZYGaMaK/C2xofnU0E9HG8PtQI=;
 b=XiJ6Cha+Aktb5A7snXILvWkdaGzh2tXiypBWaBSSoxQFRitD5MX1fc1qLOS8h0qVL7qlt5p5NUdSMSKW4gQOx6pomc8G4ryoFDkLEfXpIVWkfSbAFlR/aY6v5xddbzdzlQxnzmslxECjphkEbcTFhJ6yJmTY7d7TuEoekrhJRF7gwDjcsujRFZXytK7MrFhZOTUL31ONXTJdS5Bseyv8pmkqRSYIVR6YxiUtkoxTeNGcwHJRLsQ1FC8Ock7yylP9QXyBPUg3ZGUemmLax/QZdF4S2xQg144qPiDsVezb0ubI6nrgt8SCaN6RKUqDFZw1NGDqCIEDrDjql7XkhMs2sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4ilDspI8+zs7iTMDYZYGaMaK/C2xofnU0E9HG8PtQI=;
 b=q3MHx/wKP8u3TvRLOaKo6l0pEyDiQzmT2TW/2ueh/t9VtHLp2EWOJHBPbGJDvRaqb0fyNblODXoeNOD00033138Pxv7/e3ghpfnQs9Bbj45xFsjG6JaLmetzJQWBmd/T/NT7C95qHiC8MRz2SDuIiuOlJhXGCNwUm1WUbwsvvf8=
Received: from BN9PR03CA0265.namprd03.prod.outlook.com (2603:10b6:408:ff::30)
 by SA3PR12MB9226.namprd12.prod.outlook.com (2603:10b6:806:396::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:53:11 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:ff:cafe::68) by BN9PR03CA0265.outlook.office365.com
 (2603:10b6:408:ff::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 08:53:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:53:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:53:10 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:53:10 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:53:06 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 31/46] drm/amd/display: Remove redundant include file
Date: Wed, 24 Apr 2024 16:49:16 +0800
Message-ID: <20240424084931.2656128-32-Wayne.Lin@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|SA3PR12MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: 148c9530-df7c-4b7f-3094-08dc643bf859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZE7HrEm6OJW0sSYsghktogYwDTLEP1SY9Vi+QSrApm+tgIzaLWPRnfu0ASu0?=
 =?us-ascii?Q?8mpph9FqnzDAXx1aIrNquw6q4qjF4uzucz/wy9JIVajtXpHPCYV1nK+R/9we?=
 =?us-ascii?Q?BpevQUOQ+YRqTZd/SC2Ye5sQV4Ry5R8NsCkYTy409haZBnLW3aGGyBzv7WGL?=
 =?us-ascii?Q?J6zUHQrwqQwk1+qrKzDA0Xxfz6Wuhej/cxnj0R/f1ISdE/Ras+s5S3dNOESe?=
 =?us-ascii?Q?K/KNrnEOmoEcSIHHR0DOzP06ss9GgCUmO3faEwxZfTpv1FXFwWVhj5QCFV/S?=
 =?us-ascii?Q?K49xW304/Y9RxR/pgiquPmY3evfjYnzaSa0WpPKA0/J2UtKF5uDA2rqBD+hu?=
 =?us-ascii?Q?poHZTipoUFQortjg61FCj9kFva57RQ215wECTC8C6Uk0GuDPjOtbsPS9F6y2?=
 =?us-ascii?Q?IS3vzCCUScglK4+pVZ2gcBBU5+bZOBgGtCDTaC2DAGJcgcW+fqcZDA0U8EKU?=
 =?us-ascii?Q?nMkmgMxKv0O4/ccglGrHqv7CqxMkMnKZlhm8d/SCuzE/rAFj/NKxL9i9R9oF?=
 =?us-ascii?Q?ckewJiQYvx5GR1gsKdjHN3J7RHyowdjAHox9A4SFea3jNJxMuV+i/oZpH6VO?=
 =?us-ascii?Q?lFY+wN1YtnIOR0IXqLCz3iLBknlrEDEGlKY4AL5cD+//G/e4ME1cBoTBiXam?=
 =?us-ascii?Q?uyleNDsqMZD4zMIRPPrjXhdTfRw36s2ydxEaic/cc4Fuj6nFukIybv1PCp4B?=
 =?us-ascii?Q?ESR0MDFVbgP7u3clu9C4IK0yrQWzcWDFYETiBDU7QMlVnXhsJmWr9pdGe0O5?=
 =?us-ascii?Q?IyWYPMEjv7bOnjah1FbdQf1R/6YR8D8CPz2lsd5VEhUgslm+DaM0eU1Cd3Yv?=
 =?us-ascii?Q?YrmGCy1eLLgpza7srGyhuo0/ZnvCrVeSCOOcWXXilGV867qHaDohq8X59Nu+?=
 =?us-ascii?Q?x2pTSSSgeNJ9KNRVvkZot0URsc3/XHONeqRTEYIfYuK7u3cbht+FEJ4TL5iJ?=
 =?us-ascii?Q?Nrx/ZTonp17y4IK4Gw/BUZK4MxnuY7vMkgMo3xGvB5xdubsKVBLC/sIXyg9T?=
 =?us-ascii?Q?31gV5a/RtgBO1UiouqSbKZSf4MMHFzZO63fN9Lna4qQRAVGzOGU0VUkMs3Tr?=
 =?us-ascii?Q?K1nGSBkpiDB3vmqyE+2BGnJhbIzwaz2v+szld+uIvENspnqSxBz7OL2mfBhB?=
 =?us-ascii?Q?wpeExrv//tQW5vxrRFr5abEd6qdJvwXH6BtbysCIeKVhbt8/0rlDNvIGWoxN?=
 =?us-ascii?Q?asseKZAbLNMHKlZClxTgRbNQBRtLuWvf0dmSOIW2tzElwDoTZgY7Fc4U1F11?=
 =?us-ascii?Q?kdkcqdwzzK6izHSYmN0RbyVu6R8fzoR1KNNdAbNDX/Op9+xAV8YfNYzt+f2S?=
 =?us-ascii?Q?OawFxt864hj8G4eQv0tJLkGL99Cml6SwtZzi2VTv+yXOhHGjn4dDiAJah5Ob?=
 =?us-ascii?Q?SONKlhIFi4fBGyypVISZbXV51mD+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:53:11.1741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 148c9530-df7c-4b7f-3094-08dc643bf859
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9226
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

This fixes 1 PW.INCLUDE_RECURSION reported by Coverity.

"./drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h"
includes itself: dc_types.h -> dal_types.h -> dc_types.h

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/include/dal_types.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/include/dal_types.h b/drivers/gpu/drm/amd/display/include/dal_types.h
index e9591d4aded5..654387cf057f 100644
--- a/drivers/gpu/drm/amd/display/include/dal_types.h
+++ b/drivers/gpu/drm/amd/display/include/dal_types.h
@@ -27,7 +27,6 @@
 #define __DAL_TYPES_H__
 
 #include "signal_types.h"
-#include "dc_types.h"
 
 struct dal_logger;
 struct dc_bios;
-- 
2.37.3

