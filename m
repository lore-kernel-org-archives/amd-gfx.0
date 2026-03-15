Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DEA5D58B2B
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Mar 2026 13:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDF8210E1EE;
	Sun, 15 Mar 2026 13:03:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kUE+QGiJ";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2241A10E1EE
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Mar 2026 13:03:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/z9wr37/661uM2PdpyRLAJwhvLkDyA4CsiHHcYVVx+JS07ITqJS9loCrPTi8lkRYUh9sO2Mkn4/WBBPdGMJtIhqaAuLhHeIqVyL0cJE1aUPid1wmrOT/ELd3tS6PBanInarKnQ8xJ087k7A8B4N/l6Lejm49AD8sXDlq0VP8MuKvFh45VqgBdOw0vTWiWJz8Kp0/XyuTmcR1+ZQELyzmTuikGpUCP7xkERIZ4FtjQ/AifMQ/oogBT2Mk8VzuKW3SQpGSV7BB2WSMcAiGQv6HVqjqpFI7OSg54v39eVp9C5Fd/RQ7UQu4q57ywjHHK6J5PXXNVQrbYl8SurU2ha1Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUywdW0QzXoixx9e6NkAZ6KfZqR2GKUgxlpunj6wT8w=;
 b=KU41Y47l9VeYjdeX28NiEHWR3PLl366HpwbEdrOyXdvI7om6uhnr1ehAqRLdD9MsMTI36k5oyO+V2ix1xpzKm5Pr/KYTLG38iUsl/dvHW4xYboeOLLr7gpmmEKMYFp8yMBdXR+da1+FmBDorj6h9Wu96gRKmfGKQLe69s0oDsVMIoInYAgUoGC4a902nG97JZUv01Q9ZvU5AnuC3m2TtyssrPwtdCBhriD9aVjyI7U6ZxJB4Aai3mU+dGgywQdZWTFB5fJ6mw0pEn4qdFOGLrxGslcqmwElYZUP6e6Px1DLFbtErtZNZIhHlT2NgDkJ8mrbfdI0Q9fpTmLMJV2dV+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUywdW0QzXoixx9e6NkAZ6KfZqR2GKUgxlpunj6wT8w=;
 b=kUE+QGiJs5MJN3J2J8EEzlBgzPuX15xvaVh3u3XnoiNG1QO8QLPot8uh1mw6evstE/AaD8LidMc+R8n6rx+prkf3BFpl0KS5ouHulkaArXiRvXh9pdLWhEEh6WKrr9upHXiZgLcvbH0ARHn1y1UTkJ9p5Twes9kqSQfYrYe14QY=
Received: from BL0PR0102CA0069.prod.exchangelabs.com (2603:10b6:208:25::46) by
 SJ2PR12MB8133.namprd12.prod.outlook.com (2603:10b6:a03:4af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Sun, 15 Mar
 2026 13:02:59 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:25:cafe::3) by BL0PR0102CA0069.outlook.office365.com
 (2603:10b6:208:25::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.21 via Frontend Transport; Sun,
 15 Mar 2026 13:02:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Sun, 15 Mar 2026 13:02:58 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 15 Mar 2026 08:02:55 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Roman Li <roman.li@amd.com>, Jerry Zuo
 <jerry.zuo@amd.com>, Sun peng Li <sunpeng.li@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] drm/amd/display: Fix DisplayID not-found handling in
 parse_edid_displayid_vrr()
Date: Sun, 15 Mar 2026 18:32:37 +0530
Message-ID: <20260315130237.1933993-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|SJ2PR12MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 912cc0fd-0814-4a3d-552b-08de82932e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: euSE4I0gZOYI/nYf3y27TKzClrXvgXrtm8D4Ej9MOwpqhmUN7OLQ8EZBG2kXr4D6Xb6e9J9DvRC8AQbKWorV5y3Sw6AE/DcFjp4GHR5roKJmuc+VfQYPa+31g4lB2IoQn6arWoxIqG/O9rVwtGIDMbOhqXjY9i1CuVGaEIVDcoy68qYIW+YMSq7oPm2vDoleqe8DlS5mx296ztEEZGTjI7W7y9ERyFU5UcbuL5m1zPdzo7ySz5tEx405xze8u71E3swXnFsq+rk08UtrLFgN8kKFuwWnKZ0+INDMEBJI/8L8ucK6FaAwKqiFtJnyYXnGXqLQ4kLerXO5ZduZSYff1gDIUeTn2QS5PKD/Qh2nWPEpcfDxcTD2EA3i28X+ciK81OZvt1Ur7XwtosLgeCAwXZLXhOVJ+Q5XmpILtEAyiPBrwwkzDwg1BPC2GZXAATd4n/pVeoKAK0PGCtVJkeMGHDh5PYugHCmXudvZoYuAYTPsc+t5raajlMsO96GhXdmLbFCCDgnomZlBNx9Nk6fxGFlogXLLulcylH+cJDl8Hwc1gGT69lsY2WQUEbYX5kq4/xWT5/Ju/XkPzIvLMNPzs7+8YSVuWYz3DoeGtyw/f1JtPtSeT6o/bflKXFWxu0ZtAZQUO8OQC3PDfIPizyNS9Dm+roTm32L/DUiiHuYMNf7oB3+wAz7XgKOI5gdfC/841nCZe9k+I8ZT4Gwt9Ym3+ul8d6AiervptlzdPQFUfisJnKVPZl/7T2m6xyuhl0VB4yXwrMUELl2PsceZFLDBRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5Xf6TIsM+tORKPFx4nO/uiCqyEdQKGYFNB/nqunENkpn/gixecwSOTeoYlcJgi3aCIZqb6qYTrmg4V2IwFGnTf4OHX4kQhepAkUwaBvkefMbRR4RU17dRBh/PW8fPq6hOsrOFF/ZCbde1SZkGKaQM3mh20z1PaGPky2frtY4jayXZzhpau0R0ka+ANV4QJF3fA1ctb4ziggRD7IJIGYOoMClf+nTLIbMiF8wRawTbkA6T0wJfs5PDIYBmEokvlkdfKAzPPG89uD9mZJb+rb479YdO2YqCQdjLSlc8NjN4DqU8muabkKyfMrti5rzAGR42R9izgodCPJ5I8c8gYqKtFlwcOwO+AHU6QgQoPGAZh3D3rqW/tSxYURd+kXcNnNN4ekE95XyFV6pFZBF2IhwsfbyeFGIZIgkqY2jcXRluM4SooBuefeuejrwlNwukvxF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 13:02:58.3457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 912cc0fd-0814-4a3d-552b-08de82932e6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8133
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

parse_edid_displayid_vrr() searches the EDID extension blocks for a
DisplayID extension before parsing the dynamic video timing range.

The code previously checked whether edid_ext was NULL after the search
loop. However, edid_ext is assigned during each iteration of the loop,
so it will never be NULL once the loop has executed. If no DisplayID
extension is found, edid_ext ends up pointing to the last extension
block, and the NULL check does not correctly detect the failure case.

Instead, check whether the loop completed without finding a matching
DisplayID block by testing "i == edid->extensions". This ensures the
function exits early when no DisplayID extension is present and avoids
parsing an unrelated EDID extension block.

Also simplify the EDID validation check using "!edid ||
!edid->extensions".

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:13079 parse_edid_displayid_vrr() warn: variable dereferenced before check 'edid_ext' (see line 13075)

Fixes: a638b837d0e6 ("drm/amd/display: Fix refresh rate range for some panel")
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Jerry Zuo <jerry.zuo@amd.com>
Cc: Sun peng Li <sunpeng.li@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5323843c718d..acdc4abbdddc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13124,7 +13124,7 @@ static void parse_edid_displayid_vrr(struct drm_connector *connector,
 	u16 min_vfreq;
 	u16 max_vfreq;
 
-	if (edid == NULL || edid->extensions == 0)
+	if (!edid || !edid->extensions)
 		return;
 
 	/* Find DisplayID extension */
@@ -13134,7 +13134,7 @@ static void parse_edid_displayid_vrr(struct drm_connector *connector,
 			break;
 	}
 
-	if (edid_ext == NULL)
+	if (i == edid->extensions)
 		return;
 
 	while (j < EDID_LENGTH) {
-- 
2.34.1

