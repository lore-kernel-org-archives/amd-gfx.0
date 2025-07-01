Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2EEC8303C
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 20:15:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38BA210E607;
	Tue,  1 Jul 2025 20:15:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fscRVooP";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F85810E60B
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 20:14:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DA6toEQJ65KRoj30UlVGoAR8xQZw5UY8SqEoV5HQ4KW2DoknCK4q2GKq6catiZJ3By7Gq6Ccty7rYnpNhvHNEsYafvGYhUjBihltgPBXshYhhC0MuoV6iywttVs8fS0j66xb/pFBg3Nh4SM27ecYstP5S1MKLI62oREd/3PzJhFtph+bBchbslpM9NeeD+bqCP1Zg6S37HAXGd8xP/KTuccg9mPgkryIy6F54st17ejryupvnozeffHkGFCB8qxxzM3UFx/6I2o94tRTp7W3qZ+oQciTl7vpmSFgF7yvXhPVhNjr9NyrKRAELAuLP17MsNWFehBttrQk0fysFciD+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwIIHow6Za3et7oFsl9W0h4LB++5vkx9ZyccaSTxI3o=;
 b=xfjrSq5JJWk5c8ye+WYKD3a4c9j5jpONitDrHAId8v1IsNg1Ia9LNTWWnemjWlyumdxcOvevIfKdDzaozRw1K/fmwemR68zzkMUMJrq8/Axvb1btZsx/kBQ9HCDfa0xC2kxoIoC5JodUhwMAfwpAyZcA6uznTVZU65vutX2mp37RRh+DEngpRsYVOsbmKlRKmSbRWwge/q0YPmttt5IYn26P0xYgp77LPwi52BT5wQVlGpQOzoJybGjUn1CLZX3ap0e0f2939HsPwTjUKI6Sibg8ccJ2s0aQiJt/x2kUoC5TO1lV3s66mlsplSaycOxAG8r1/PU4OP3txyJfpSfYkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwIIHow6Za3et7oFsl9W0h4LB++5vkx9ZyccaSTxI3o=;
 b=fscRVooPWBHQ1FHhVc5Qx5qmjFYFZyk76eWU2JAbPl/JUQuK8+7EiKv73YOxQgr7ODyYg/gJ+oI4+ZLVRgTJH366GslIAQJnIanKUrt1s+ebZfVP+85hzGS/xFK1Qw4d4YIlGFExqKk4crtja79cQkiz5GYQHBnzMr8XGbiEQiM=
Received: from MW4PR03CA0151.namprd03.prod.outlook.com (2603:10b6:303:8d::6)
 by PH0PR12MB8776.namprd12.prod.outlook.com (2603:10b6:510:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Tue, 1 Jul
 2025 20:14:54 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:303:8d:cafe::4c) by MW4PR03CA0151.outlook.office365.com
 (2603:10b6:303:8d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Tue,
 1 Jul 2025 20:14:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 20:14:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 15:14:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amd/display: Use scaling for non-native resolutions
 on LVDS
Date: Tue, 1 Jul 2025 16:14:38 -0400
Message-ID: <20250701201438.424760-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701201438.424760-1-alexander.deucher@amd.com>
References: <20250701201438.424760-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|PH0PR12MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f35f3aa-0dfa-490c-40fa-08ddb8dbf139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/w4Vp6wfOfk1BGfzFroPFTvdvRTC12IQU+AwPGtmvkRK0gKml4hJZEPxubD6?=
 =?us-ascii?Q?gQw55dN5ajhgCYFAQBQb9sSTgjvD7s5QkjjxaEnfm75OJAzLicbgUe3OikzX?=
 =?us-ascii?Q?qPbfjkk+nHJ8EZYYgrtGF1MMZ5M8+3m4xMtsqXUGZXKK8okINmCdBgvDw8x0?=
 =?us-ascii?Q?ADwaeHZdBwSaHQocSVCROVn1/5LK7ZPLDra75D+hwXIkzNJwczDA17X9PyY9?=
 =?us-ascii?Q?4txze732jZLg/3AMxNEKi6sJr7Clg0M5OHPyM+R+Q1Sbet7UGxas7jROxgry?=
 =?us-ascii?Q?gcel0PGc/XootI8wgsP6V+XHlgN8Ax45jgvZhN+pG4txNdnnpSgUZ3hNTJDh?=
 =?us-ascii?Q?5kpL6VOCISYH5ARQWgTuLtNwcPjQQlSOfYEuaDfnZrEjPrQf1451DSKyVpCT?=
 =?us-ascii?Q?L+Yive0WsJ4uLnR/4urRb5tp+ZKvdH1ucBKEw/1ECUP7trosX9Kj+P7yBu0E?=
 =?us-ascii?Q?bZ9zkHOm4IxBGxxYNbNtS/adh68+fUfofBR0lKf3i1qzAShVH1ruLITZMcmm?=
 =?us-ascii?Q?e30fvCbGGxBjKeN9Bmr9hZ5Wu+bxk1t2TmGA53q2KGcVMLXoGek0OZ4jzZTa?=
 =?us-ascii?Q?UMhKS7J/4rRaELad5NnQJA5JbmiXLV14WCsWUtR9ADHjXkFi5wBmavA0+dwU?=
 =?us-ascii?Q?Z7Wj9JIQPG3Tdcx9iVnVGvomAKG5cIoawjlXUt913M79tH6uIZCwkvLVSYpo?=
 =?us-ascii?Q?LYtcziA/MHFn82ZRm+AlOTVod6Y3eMmRbT4q0ty7q6q2RUQDzJd1KcHUUfj/?=
 =?us-ascii?Q?G7bzThI1QI1MEPEFZKf2VFamwH6Ed6csUWrEWkAf8E1Mp4UUaIpheymUyOXH?=
 =?us-ascii?Q?hFhdMschZajGha3F4PYbhpEu36xvj4qHiRh7jAVs/6JClF2XZEKdOKl7OD5+?=
 =?us-ascii?Q?EoAW2qh2o7tVSjJCLHtCeg1ON2NvY0aMKSrgxlm3Pnp2jTkr8h0Wf/8oRLRP?=
 =?us-ascii?Q?8HMLYoC5AMKgsps68VcKe/LVu536YAThny6h2yISyIVFOY8gEZwX4DSvpowi?=
 =?us-ascii?Q?CtXZxpPaJVk/u53Kx0JQGZB0wQUcs5TRPTT5bqcIQmSjLB0kYrXIZpfN8KFn?=
 =?us-ascii?Q?Rhpkbr6hHTJ728cJ0JyPqlF7CRX81U2EV3mltnsvBV391Kae+dwMmrDedFx0?=
 =?us-ascii?Q?aFK1IBV1iDl0CH/ytrqXSXT5o9P/SiV4dYFU3d8WWNk7+SO8qPweaudGdn/G?=
 =?us-ascii?Q?aNQM0GzlUGFzp+Wn1yvvJa4WReBMi/X7xQGHr8WB5zK1IbA9AupIw82l15NX?=
 =?us-ascii?Q?7VzFrW8xpkxUwWdr9qWgSXNaHNs6l9D14I/eHSMbAECs5eWjk34Yqdzns+ZS?=
 =?us-ascii?Q?mo2fvuj8U5XVtG8wl6eCmnbpHhHm9/pEjnhUhE6qacjSRmD+G0RuCiWMtRKw?=
 =?us-ascii?Q?LrhkkABNBa8b8T6e7IuSP4w5PZxSNu5NUbLpqBM4Oi+FqDgV84hQXMSQauhO?=
 =?us-ascii?Q?mtnxWG2umyaXerR2eUvu3nbEpWzEY3MT8uIREO5m+GzMNOx5YYAKsbwZ8Tne?=
 =?us-ascii?Q?ItNNATU47hgSY/FGQ/XqgSTk7WtJIA1cTTSL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 20:14:53.9543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f35f3aa-0dfa-490c-40fa-08ddb8dbf139
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8776
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

[Why]
Common resolutions are added to supported modes to enable compatibility
scenarios that compositors may use to do things like clone displays. There
is no guarantee however that the panel will natively support these modes.

[How]
If the compositor hasn't enabled scaling but a non-native resolution has
been picked for an LVDS panel turn the scaler on anyway.  This will ensure
compatibility.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7a4fca9a61bbe..096b23ad4845d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7901,7 +7901,8 @@ static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
 	int clock, bpp = 0;
 	bool is_y420 = false;
 
-	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP) {
+	if ((connector->connector_type == DRM_MODE_CONNECTOR_eDP) ||
+	    (connector->connector_type == DRM_MODE_CONNECTOR_LVDS)) {
 		struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 		struct drm_display_mode *native_mode = &amdgpu_encoder->native_mode;
 		enum drm_mode_status result;
-- 
2.50.0

