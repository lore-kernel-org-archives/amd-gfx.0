Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B61C2D0CD
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 06:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C10010E00D;
	Wed, 21 May 2025 06:39:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KN7oMUev";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7FCF10E00D
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 06:39:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXmH2ltEmtckhiIo4T4SzUVph9Ulc5hHEpxEVI6eR7mIe0UDPmKQ+4wjHLrC6ZgqVZMpI7dAkXI+1DM85NIWXk/wUOGm5bf7jcwcnO+pQA+SCvWsJxkWhXmc+WdZTo745o1dHqbs6SGo1mw4tVky7Sl7Ttk6I9lBo+pciBiM+NLluiII3p4saVAgw35i4aZl1oM81EaZBMkTa/7/1BAEa4syPxvBilz9xWXSjqSZbuuRrQrfLV4GyMF2SkIybnQ2SBubVQ6O36Cw0MjicJFVSWTmxMpMwETuYkCU/YDOIGaj0OzWBiII1wBoPjEDQV0Os3gwoYHrtGwtGrAKYx1ieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZpHv0g6kRvsKWC+JcG2Cp+cqIMjJ61WicGZCtTMFNo=;
 b=qZTuyFdLJhg+oWk0a+Nr6cK/bFKIz+MYLy6pMl54ICPeX2fGx9/r5MRKGJoj8wb/k5Z5LmG8t2MesuGXHDxYCrhPGRj6ol2CzAb1SUvm6zDMNatXJw6/fI/Iws19BE0mSTkC5kxaAg/R85zydmPpgwSxIXsegJ5y1s57LkTiBKhhkQo4Mlhyxtll7KyyNZeFJ0XtWfC3bTYLcfCrKdV8wMqR5MS1iUv0ckzn+91nVeYBAWi/BeuEy4CBX4FwKPamXmSy426nzsv9RPeahKnJ1wKUdwISPD/L22Q9KtdNc0zUBUPirwqPm+7N9c6xTCpVT6VrS3/Q9JgUy9gi22hQKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZpHv0g6kRvsKWC+JcG2Cp+cqIMjJ61WicGZCtTMFNo=;
 b=KN7oMUevItIFeblOGByLTs8M689QQwWx1enq0/oHXOqibw1It/g37teZKhZOi6ToO5/ZSmkbW0HEKi80qtVbJLIzitmNEIqJsJDAf909mhmopIpC/jrgrivuPcnS4Nts5DUCLEmA8/SO+AFI+jPgpgBCSgOrWs3mwEBL6FZygfY=
Received: from BN9PR03CA0048.namprd03.prod.outlook.com (2603:10b6:408:fb::23)
 by DS0PR12MB7631.namprd12.prod.outlook.com (2603:10b6:8:11e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 06:39:40 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:fb:cafe::3f) by BN9PR03CA0048.outlook.office365.com
 (2603:10b6:408:fb::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 21 May 2025 06:39:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.4 via Frontend Transport; Wed, 21 May 2025 06:39:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 01:39:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 01:39:39 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 21 May 2025 01:39:36 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Leo Li <sunpeng.li@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Alex Hung <alex.hung@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH] drm/amd/display: Add a new dcdebugmask to allow skip
 detection LT
Date: Wed, 21 May 2025 14:39:06 +0800
Message-ID: <20250521063934.2111323-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|DS0PR12MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: 553fae2a-2e03-4ccc-b360-08dd98324365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WcZQ1km9ZoQugGe+94w92PgaX9T8LpAQnPiyiWe+j48Gd19EQwh2a6NxMvp2?=
 =?us-ascii?Q?NswObuEb7PcvPAgTE7ySasvvsMU1OINgGUc8te7um2xYryZjK1YDroOri0ER?=
 =?us-ascii?Q?xnxthXHS8ChlhI7lc2cX8A64oMgfIyryrg/YPXfjG4I/oHSlp+h4ydbVl9QC?=
 =?us-ascii?Q?XzfxA4kiiDUKXxgTGk8VYQk0jdQyZ5075zrRx1Y2baeDqtozTD50PmAgYtQD?=
 =?us-ascii?Q?9vunSl+CIVNgY6KG9+v/kjbEyBAdA42qlHGGK6ahvPoY4QjIW3UoLlZWZ9Mj?=
 =?us-ascii?Q?ObW0FTlRVn6rg2/rO7XeP3PjRguYLamSpX1CFGEyttKyhQA/ZG9TsRvu8UxO?=
 =?us-ascii?Q?J5q1Sl+tinFS7gS6Krh0bFZVmWir7SHsy+YbjdOQZHO5MH6sk1Yl/w4sWVnR?=
 =?us-ascii?Q?W0s2538KIGYbLFNElh0aP47AV8FgtxEgQxBkIr6ZCRnYJ9VZov0sYWHBH9D6?=
 =?us-ascii?Q?ed7ihIfnFK/rrhgmPdKXdJ7kbXo0lpiFc5h27DGHEbUHyyr9akyeAjlgSRf1?=
 =?us-ascii?Q?QmpB7SjOeaL7bhNuwYKGV0iN28MBShcp8Zh0N4gjD0UX9/ehX6FADT3kY8cn?=
 =?us-ascii?Q?R5QTw4ym01lkz1mN6OOnhxzdc0T0VsSG4coVdUf57MatF28wQaaf4QI4txU+?=
 =?us-ascii?Q?DSRlTdaVFLR+tI4BZMJmmmJ+EZf1woNMCxVVljQ9WoZpl2nTkE7zKJQlm1Ws?=
 =?us-ascii?Q?ALGj9LF3MV50YhSzOBE+Kh4JzStOB44PiLH0NiTHX32x1cRWGTj1eJTfc7fi?=
 =?us-ascii?Q?pZlqcOiFHbourGFZaOyzDPMNQjDusvnk//Sudv82SOuRjhjgWIeytggYsFy1?=
 =?us-ascii?Q?p8jDQS/BZJAPH2kfZ0moK0NiGlCzVLF8qHTCVZjUN/UdQ59t3gCZkaKjRQdM?=
 =?us-ascii?Q?KllKN42K4VB0rP6e6DSdJLWj6udAotj/52IQWhIEAvG80TCFT7Ei9OMjKG9z?=
 =?us-ascii?Q?H5wb69c5fp7Hq+SquDRL4NqYCGHKOWNEjAG0yOXswbljh489kNjaEbahO6dC?=
 =?us-ascii?Q?I/SHo14Mw10e599icVNfu+bdgsPrIVGM1TIDVh/LmdW6qOHTVSLwNdOPq5bm?=
 =?us-ascii?Q?rkFUNXMM/VP8CmmH0/2UWwjPjtjhpoglu34+OoO2R/vBGq/jT+oVSdyK+5Wm?=
 =?us-ascii?Q?yUqBoOufeJgoUFWyu2KDxbCGMqigQIboy5meSmcSXm3XdxdQwWdoqIw1uel/?=
 =?us-ascii?Q?qZVG2DjAmgx/WAK0n1tx7sYcs1wQ65K9RCJlsJ2MHj7DNfF2m+NDWd+45mdz?=
 =?us-ascii?Q?HC591xbjIZ9DXTpfYOnV/wOXqUzQRJYHOVAIYrxrh8EG3BLhOaKoo5XjgMiR?=
 =?us-ascii?Q?a0JsNJdkYTDBXw0daShQyVpTNQ/gttHBek+4WUVOfMzLRqIzRhQWzBIDFRCx?=
 =?us-ascii?Q?Y1dHpnM+CGo4bzAa9Q3zdQn9X8zYOyrKnAoHPEYPJKGmXHtOrQlhBUaUv9Wb?=
 =?us-ascii?Q?FgfO/vp6ygoafZRuHbo235JnypmmbdTk/M+tlrcJNsnodU97l+7Bfs27GQPW?=
 =?us-ascii?Q?ZtrvwQLo+pWgxHMvI7qizLGfriMFlTHxIsth?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 06:39:40.2580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 553fae2a-2e03-4ccc-b360-08dd98324365
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7631
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

Under specific embedded scenarios, we might still use DP interface
rather than eDP interface. Under such case, detection link training
is unnecessary.

Add a new dcdebugmas value that can be used to skip the detection LT

Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 drivers/gpu/drm/amd/include/amd_shared.h          | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4b4e9241619f..2bb347771aa1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2020,6 +2020,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_dc_debug_mask & DC_HDCP_LC_ENABLE_SW_FALLBACK)
 		adev->dm.dc->debug.hdcp_lc_enable_sw_fallback = true;
 
+	if (amdgpu_dc_debug_mask & DC_SKIP_DETECTION_LT)
+		adev->dm.dc->debug.skip_detection_link_training = true;
+
 	adev->dm.dc->debug.visual_confirm = amdgpu_dc_visual_confirm;
 
 	/* TODO: Remove after DP2 receiver gets proper support of Cable ID feature */
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index c8eccee9b023..31de36c9156f 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -370,6 +370,11 @@ enum DC_DEBUG_MASK {
 	 * path failure, retry using legacy SW path.
 	 */
 	DC_HDCP_LC_ENABLE_SW_FALLBACK = 0x100000,
+
+	/**
+	 * @DC_SKIP_DETECTION_LT: If set, skip detection link training
+	 */
+	DC_SKIP_DETECTION_LT = 0x200000,
 };
 
 enum amd_dpm_forced_level;
-- 
2.43.0

