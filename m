Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF66C27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BC1B10EB0B;
	Thu,  6 Jun 2024 21:59:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3NjvDOmr";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BBA610EB0A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:59:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIn+bGIdZOHDXouVIHTfBplrFqnAwli2atv9akvKWQ6qck2n/7N/cTMboV+FFQ/ysZgbbTR3JfSXp1xwHDTrkWUqSx+5pmo/3YM9CapQ9DIAFlpLwB1c5KGs3xmNkx2yB8P9DS5LXkLViSEOKfqCK9RdYnoJBXiGOAsEy9uhGFD3AqRy8WQsS+BTxN/XsFRCbK8PKrR8u0kmNoGLyiXfgNAdIgil8jfiNZtta1jmJGW169lmZUJvlfD954MM+iuE97+BcQ7Rm2tEgoWMmvFdr3Robv2AYM2PS3UxMPVT8VEDT3yEh4vTUSm2w1vAtWDnU0e3iAVAYOzAv8FoTgH1Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UrK0NuDqBlwd+HUmkxdGBqGWzdqIyR5mmfXwjJJjaA=;
 b=hqeB1r+QzN1cn6YEgMuN2utPMvDaWKUI/oUqoUtSsFySD9IFBeo6VdyGZAITg67AYnWirOr8p9pOmVmvpzWF15vePcJ6AQYjvyrMDOID8IdazP5b/m0jT3HSUcFDqaK/5w4o9iNWDuueL2XEWjGS7IebSs5uqnA+rFdnNs6bbgDOiX8JJSax2I8R3LNb/YIZ64UUEKnLcGtf32+sZ8SgyEdI6LizA7a8FxfjS6B8SPoRxgl2DLpC89BKNOO8bvqMU9GGRFQrNGt7EodpQpF2p97kKBkB2bBZdjx9uHG10bgEVkE9zPgeFlm/00iOqQhwdB4DqHiS+1Q6Bm+tX5G3bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UrK0NuDqBlwd+HUmkxdGBqGWzdqIyR5mmfXwjJJjaA=;
 b=3NjvDOmr0oBRz9lYwKxOHtQM6R8mcPcNNK+rjUb6lGbpK/iDGv+lgZYMU/I88z36VsxZ2jQfYnF4ZXZ3PowUNM79jruTVO2zdCEcmJD9jX9w+7brhliQMfnDaYAWu87hgoFYV9PpEaje++ciEb09sAYiKWzF4iJKvLjBjvuhiV8=
Received: from MN2PR15CA0057.namprd15.prod.outlook.com (2603:10b6:208:237::26)
 by IA0PR12MB8893.namprd12.prod.outlook.com (2603:10b6:208:484::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 21:59:07 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::a4) by MN2PR15CA0057.outlook.office365.com
 (2603:10b6:208:237::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 21:59:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:59:07 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:59:04 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 58/67] drm/amd/display: Explicitly cast v_total to signed in a
 subtraction
Date: Thu, 6 Jun 2024 17:56:23 -0400
Message-ID: <20240606215632.4061204-59-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|IA0PR12MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 052674a5-0087-46a8-be93-08dc8673e33b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fwBemVO2R45YTF+RuzzeMTzCWm3B0cnmTaW6CFaqs3BR1n4y7C7+izyH/azm?=
 =?us-ascii?Q?SGfA/w4nY6oC3J2XHLp9FgOuCR8oVMFvvZ9Zozw3bts7FPXTB9ZSnHPrhkkq?=
 =?us-ascii?Q?5EVgVfpscx/c+GNbx6KrzIHMqzHR72e+p7QvaTvjQsRwc80QH+gnINFfgT5n?=
 =?us-ascii?Q?WTzFWmIq+i6lWzVIU+8OTgalxFpdHcLaNniKhLUUN1l+wYpzRE9+hRVXJetS?=
 =?us-ascii?Q?IKsewOhIJPN5hFECxWC6Ns70/WG20XZTa7B1DvXRIhdk9l6h/ZOCUZ3c4HVa?=
 =?us-ascii?Q?KTyVaVdCGjJVh6j6LatOLtaMxDOZ0dvNNLBR6jbjhHVG/GX0o3DsNGFQ/1PM?=
 =?us-ascii?Q?pZ0vDIbyo0EgbeMF8ZoTQl1F49qR8l61z4wXJd7dxNUaIRau/CFPTkjEf3NH?=
 =?us-ascii?Q?EG7RwSX94PSDtgyc7pTVdUN/G3MdAiviO0ft6qh8B/ig0qElynivMzrisDL5?=
 =?us-ascii?Q?uLNyQMR/2W9AmAGwPi0/HwcngjNozzOdKwNF42olijy9gtnfPVfNPUmlUIf3?=
 =?us-ascii?Q?kosez4kHRI3znOKhwM1zRLeCz9jsx+pLXx0HVaDVpz0FPXIGO98fc8+mMnSB?=
 =?us-ascii?Q?jZ7Z/3YBZApQvp1KeOigaS+MpmOr5ffvgQyThjnk3L4/lUQ6Pm7iHyvCzmWN?=
 =?us-ascii?Q?0APIS4/R6s1DqmhLZcgKR8o+r5KfpWDSSgXhfKdk4m5vwbFOMaKwg+1nBzYU?=
 =?us-ascii?Q?cy9/HT6lcpkaTaCCSNsKuMLTbwiax1OiryuCjTJ3zDYS3iMNE0Gtv3CXe+iB?=
 =?us-ascii?Q?gGN7R8d3pOtxg8iyKlEkKSyHuALMowy8+e1P7K2axRqYD22Sv8lPN3K1Gj7I?=
 =?us-ascii?Q?90rZQ+ysGe+CSYHVL58kISRkiKHysg8hQaeFy+2a8h3C9SnDIC650kzcmqVO?=
 =?us-ascii?Q?qtmeMrAD0urwD42cwMu0xYPREr9EAiOtGP1Dvx0weeKQMURV7V7kVUMJ1iV2?=
 =?us-ascii?Q?Kzpps1B90pSIoVzWqHSV9ICOdXkCP7wlHmJeDV2YYlXw429s/e8mOwsEh8wP?=
 =?us-ascii?Q?Wssz0/QG7OX6fhxKb0IWrjyJXYmhzhpKQssVr9B2eyTLEwwmB7k70e7qprPE?=
 =?us-ascii?Q?Q1dMKrDN/rFWFGpbKvbk0RMMQCoEDxxr1Gj4zfO/2mDv2FDNcW+WRcBYIsaC?=
 =?us-ascii?Q?dKGPstq2YC2GA1tBLcy7n1IkIRnxTsAkWlXqyoe2QyUb5wdy0tjZadd8tj06?=
 =?us-ascii?Q?XcvXj3TcWmFgKFy8xxUtVfn7GkWifaq/DxgSxMCqIjTWcfYGAU+32ymG4X8a?=
 =?us-ascii?Q?maHwIoHjsdSoosP+vUCe7bxQj6DGZF9ozIgj0VrUDeJqwGcLB0DkAPvHphiy?=
 =?us-ascii?Q?m4ntQ7Va0BsBTHXWkfntqY6PioRyJq1S8VnzkiCb3RqsGpLNnx4fLmUEzmB0?=
 =?us-ascii?Q?H/Gnuw7/7WLu7dOrPebIzAvX5LEGOfPNqYYgKaRu+FYWI0gQ6g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:59:07.0847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 052674a5-0087-46a8-be93-08dc8673e33b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8893
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

[WHY & HOW]
v_total is an uint32_t and subtracting an unsigned to a signed will
result in an unsigned which is always >= 0. As a result, the ternary
conditions are always true and thus has no effect.

This is fixed by casting v_total to signed explicitly. This also
avoids v_total subtraction to overflow.

This fixes 1 NO_EFFECT, 2 DEADCODE and 2 INTEGER_OVERFLOW issues reported
by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 55e1c19b97f1..9b24f448ce50 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -1006,9 +1006,9 @@ static unsigned int dc_stream_get_max_flickerless_instant_vtotal_delta(struct dc
 	int safe_refresh_v_total = (int)div64_s64((long long)stream->timing.pix_clk_100hz*100, safe_refresh_hz*stream->timing.h_total);
 
 	if (increase)
-		return ((stream->timing.v_total - safe_refresh_v_total) >= 0) ? (stream->timing.v_total - safe_refresh_v_total) : 0;
+		return (((int) stream->timing.v_total - safe_refresh_v_total) >= 0) ? (stream->timing.v_total - safe_refresh_v_total) : 0;
 
-	return ((safe_refresh_v_total - stream->timing.v_total) >= 0) ? (safe_refresh_v_total - stream->timing.v_total) : 0;
+	return ((safe_refresh_v_total - (int) stream->timing.v_total) >= 0) ? (safe_refresh_v_total - stream->timing.v_total) : 0;
 }
 
 /*
-- 
2.34.1

