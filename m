Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FE0CA9ED2
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:17:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25FA010E7C6;
	Tue, 13 Oct 2026 11:17:19 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012068.outbound.protection.outlook.com [52.101.43.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEDD310E7C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:17:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqSPrzSp4R4AOSRwP1WGRmGku7Pf3gnMr6frrHDNsI1Y3UuI/+rTsX5DbHJIalxT2eQioK75tsyClkBzplCevAYKmGb3Z9dYCNpZimBgr4O14tQ/fJddEOyXQ/tTygP36T/qSRD5yxUKBxWjCqpUb+l0WWnQKYkoDdLUlDfv7w1iv+amXQWlFozuTrC9bO+e9dn/JZEs5gk9PyMEiQfjFhtMBSHwUFwK+Ws4PzMIBkGXDmlzR3bZ3HTb4mdeT1HEwxsmGCeUQE4HeNCFp3olegvMkONfu+udhub2PO6nvni1MOvoOUHvHIVwbm0/UdS9aq08nIBKbITmotHilO9uCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOBowp3lmGQ+RW1n+U0KBCiLCE1bQjgBIq4dCbJC4ss=;
 b=O7lo53aljQELO/aCVj0YzgWju7nsXP9DUnX7VzphUkG9Q7tp+eXIUgV0Nv5jg4Qb1rNmyLkQ1ZmXMxOmJ62dDUfbFoVZtv/ekMM7lk+I9+zm5A1YV6ZXZ36cdSe4hjStiNBratcN53f9EufUwvmu3i0ZmcpwtRxljddLK/ZbyoA9km/bI9CfjPzwbnRLkL5BCI14X7WjF32GrsYehytpr61qVBUF6sM8K515D0eMsQl1Kaf4q57CmsniaEXKps0GFovo49Lec4xTYpmZkkaQ5GEnXdZqNaX7bUaVIxuujOsrOJiZ919ziRx31UXCC1MyhWBM1rj6PtD1RkSigl9hKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOBowp3lmGQ+RW1n+U0KBCiLCE1bQjgBIq4dCbJC4ss=;
 b=NOL8d8FXyaUS4ncpnuwTdJB8+F2Yx/FycOrfvsFOHB2BUqU1j6PBeCjka0qHUrOzEKMj4P+Oce62T8FkdNYlpfDmhnacDqyIKC5ppeYtTj+uJFnZ9WIyeyKB/5SW8mKdS9vDPO3nKZdfUP6qS8YM48WvoxXkWU/jGhFLKD/pCqQ=
Received: from BY1P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::16)
 by DS7PR12MB8420.namprd12.prod.outlook.com (2603:10b6:8:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 11:17:07 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::ae) by BY1P220CA0021.outlook.office365.com
 (2603:10b6:a03:5c3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 11:17:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:17:05 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:16:45 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:16:36 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Kaier Hsueh <Kaier.Hsueh@amd.com>, Samson Tam
 <samson.tam@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 06/30] drm/amd/display: YUV422 Semi-Planar Images Show Color
 Blurring at Color Boundaries
Date: Tue, 13 Oct 2026 19:07:53 +0800
Message-ID: <20261013111616.2267344-7-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|DS7PR12MB8420:EE_
X-MS-Office365-Filtering-Correlation-Id: 82cceb17-8f3c-408d-29c5-08df291b837e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|18002099003|22082099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: G+rbV6Wz+GmxIc/XjFSGUfY8I0DzXzDazC7VVKTwY+KzKr7YYfbWuBbnhyyUuvb2rjRKpLVfRd8bG8GR521BJTh0Lx+dpOPRLG85XDVxwIJBTDVcY99TztaT/cccc2ZLGXgyBy4FVmL+omEdVaaD0tR7iznJ5moSXgFkZy1n3sx/jEBJyw/4NrcfFS39ExYB3ogEGnQ1KcFNCOJSKTOmvX0+3KcczNf3dClglR6YiGO/phYsEVhcTHIXXVZ8ThcOqN9XGTmf9NbBMjYNG3QD4EMdQOUanAlPUTJyIeO+7QBvX9tkeMShqiGD3leJcDPINSiCjRaPaGc0ybLEv+5IV4EjcpFW9RBdUJrTs9PoVyWNlvvuAfr6K5C7bwOMyQRjiYGYI0B+NwI1lxjDgC1uhd6wRnNWKMGXjMS2yvBRoUXTaAK5afwH74rVymPp7Y7mGLChd1wzgQWiyqWwZ1GRD4aVH8OAJ9hRVITw/BeuuOGA7o9G/4ED6XLK6PSxyzlRmpBaQR6KTTM1RXLzcQZ8DtIJy1viAWQiAeRwAGFkdDF2GRY/czQh+uO4mLDlPwROjP2LP7M2kUTbKQyN4/QsQmctRRAPIl3lkLuRAVi5gRJH6nRU8cl4Qb30Yv4xsvCtVCnzUqZbFQeF5CQIk9QSoGSXw07ZQp28ZnY5yft968AjnEW4ODC1jKWCzgzKBy3M34eDslvS6iBxvkyBV7tSlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GtttYlCcCasGoTPcDuhRsOp54PypYgQEn4S1fWElSAQrnsoOEOvzcSr6YkVM0AbC0I6NDbrgpvE6GlrT2+dEHIs0tbQtptHfeZB+xHxHjS/5uRNU+ZYyYCtMpsKqeD0o2EFwIsgr00nMmFUavcuK6ZzvB+OfVU5NCuE+qNWmaPfTJwhdMWRVz/4fSUgR2qXmvePziTv/FqlZRBJAwf77O7R4KP2juLZq8IlgPxfCj68323jXSbZaCp1aiX+pyeDar6QUu2cUxWqZHgpepPaST+MLlmTi/GcXFKTR4kgcirL9wAKo0VI0fgU4IYo4xEmrewCadhKcuNnxVFo8sFIZ3y4tnXFU9KuZu+Nr9Irz5gkEG0Pp0uttJyw6QbYgubUOgdHBJ6O001BveCX/FfvST7cg1DN3Uqk0sOPVyBdVtBnCxQiT0kfn5y/SohgCORoU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:17:05.5580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82cceb17-8f3c-408d-29c5-08df291b837e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8420
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

From: Kaier Hsueh <Kaier.Hsueh@amd.com>

[Why & How]
Handle 90/270 degree rotation with YUV422 format by swapping the
subsampling axis since rotation swaps the orientation. For 4:2:2
subsampling, when the image is rotated 90/270 degrees, the subsampling
axis changes, so we need to update our tracking of which axis is
subsampled.

Reviewed-by: Samson Tam <samson.tam@amd.com>
Signed-off-by: Kaier Hsueh <Kaier.Hsueh@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
index 1b7ce1a8c59d..1eaf039e2023 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
@@ -1018,6 +1018,13 @@ static bool spl_get_optimal_number_of_taps(
 	bool is_horz_subsampled = (spl_is_subsampled_format(spl_in->basic_in.format) && !spl_in->upsp_mode);
 	bool is_vert_subsampled = (spl_is_yuv420(spl_in->basic_in.format) && !spl_in->upsp_mode);
 
+	/* Only 4:2:2 subsamples a single axis; 90/270 rotates that axis from horizontal to vertical
+	 * (like the ratio/cositing swaps above) so the now-full-res axis gets the 1-tap sharp bypass */
+	if ((spl_in->basic_in.rotation == SPL_ROTATION_ANGLE_90 ||
+		spl_in->basic_in.rotation == SPL_ROTATION_ANGLE_270) &&
+		spl_is_yuv422(spl_in->basic_in.format))
+		spl_swap(is_horz_subsampled, is_vert_subsampled);
+
 	if (spl_scratch->scl_data.viewport.width > spl_scratch->scl_data.h_active &&
 		max_downscale_src_width != 0 &&
 		spl_scratch->scl_data.viewport.width > max_downscale_src_width) {
-- 
2.43.0

