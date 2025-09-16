Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EACCAC59D
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 19:12:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A97A10E3FA;
	Tue, 16 Sep 2025 19:12:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q1wtNElg";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010003.outbound.protection.outlook.com
 [52.101.193.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6B9610E3EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 19:12:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsy+ooNAHEXw6HvnoH5ZkvbSewb9l3WcK8LmUKZJDbovEUr2CkfYDmqnoo+xmsWuTaQji+yNpR5h7jFlL++4JzR14T6FL7JfpdsKUURM+2wiFC2qXtNBn+pM37ri/m4ulK/14Lh0S+oycY9viP/nwrMKmSufF5iR/+HyiGhZQd5SWMkc+VacpCS8TyRJrnnhOzt1ct+ty4Lfw28S/p6atrN0k6ouJyxZm9xg3qQkPLSqygggnUNi167L7REO6grE7OhIDOa6ep7CGCydoutXmOKWT10uEDFv8qyZ6LnxV7xLWNnndauzRHj2TPOs63dS9PNnFRPijhE4gA9d8C4kPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgCUc8i+F68P7FU23fXck1X5rYq5uNBfoTchd2/9jr4=;
 b=K6imiOs3oPcsBfwUsK9jdn2wx+TPPCgPGrwlCmVq4am1e4R6xVlo0NMMc8N3nzzaG09ENOkdE74EnhTNLCLVXZaFngTlkwRmUJuXKeVzigjqM/nATKl1QLLZFS9sBhET7GKs9NuI21AbOdX9r9f/1+EXWu/WkM8hlepMFNfM4xd1sQ1G50mMxwuoSGM0OFexpmEqVxXWBBlLDoExa/yf1R7kO7ewRQHsGXtWwVMLCCrVKpjKKVZASEwuVgftBXfVQBv4DEDBX02Gwhv0SRQ3IkDcjGcNOh91m+DaHkaweNu4jHqd0/0WYBpY3PRDKW3p18bfRUtdTlIqLG+k9Tq/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgCUc8i+F68P7FU23fXck1X5rYq5uNBfoTchd2/9jr4=;
 b=Q1wtNElghnSyhOVH3cjbRzzXXtJO+cygXzxBae6OjWsFL5I0IBU5spCKP+0IcM7xlpvPuH3rO5aAvDrKbw77rINKonESk5t+Zp4Y53fv/lau4fR5BeqWpeW/BEeRZYz1xHnLu9acnClOl42WGOX8h8t1d9cElQAXbibT9dM7Mb0=
Received: from BN9PR03CA0129.namprd03.prod.outlook.com (2603:10b6:408:fe::14)
 by MW4PR12MB5604.namprd12.prod.outlook.com (2603:10b6:303:18d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 19:12:17 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:408:fe:cafe::ce) by BN9PR03CA0129.outlook.office365.com
 (2603:10b6:408:fe::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Tue,
 16 Sep 2025 19:12:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 19:12:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:09 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:09 -0700
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 12:12:09 -0700
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 05/20] drm/amd/display: Handle interpolation for first data
 point
Date: Tue, 16 Sep 2025 15:09:25 -0400
Message-ID: <20250916191142.3504643-6-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
References: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|MW4PR12MB5604:EE_
X-MS-Office365-Filtering-Correlation-Id: 606ef077-e09e-4ca8-fbaf-08ddf554f39d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4RKOcAkkT0ZONTA7kENSg3U8WhsXWjoOhjL71uZZhgyAwEjiblX60jopCcbx?=
 =?us-ascii?Q?8GFTd/Bh3uxnHxDz4SP/lj1d5pXDZdaNn+M3+LZ/HKYdTAmir1FG+N4h3hwF?=
 =?us-ascii?Q?38//8wCyRFeVKpwOKzKYtEdf5yl8lXz0Yl2OVJgOvhfnadiDy7atEnrYFJVw?=
 =?us-ascii?Q?+XlEeFq1L9wANjeAQ8LyhpgveNlLdYpnYSJEtBmLmjPCT0T9klyVsy2bqY11?=
 =?us-ascii?Q?wU1YTkdIZZtN0VkPBlM8lczzJxy949Ftc9eaygiKIfgyCXblk/Y9hpddtLLY?=
 =?us-ascii?Q?yBdLEZBXe6GNszaiSp98Y8hZlgsFxjWMldpKoWgsdPtxMCGSqX+bW1AFD9Br?=
 =?us-ascii?Q?2fTp3vLEjz9HgWpsRXou/Wy4ivI0BIzgM39cErdM2Ouyv4gdJjdfTjToDShB?=
 =?us-ascii?Q?L4pEct4aP0+hxFeAOjx2kdvtfOTD0h4w+K5sOHG3CB/X90AjAUfKpFEApcHE?=
 =?us-ascii?Q?egjik0zb7qvp6yxb9EcZyGI1WUrsbV6iTl6S76BqXR+B0XYX9no5AMD0HCB2?=
 =?us-ascii?Q?+sZsZqBSr6cI//q77+FAbnFBzMwiJBBa/Bu9b6rHNd1TLGRV7ukjh/bZPbUW?=
 =?us-ascii?Q?kZePnFqvKiPGctU4vm64XQ3LhRrrNHjEiHUn4r6PpC2tTccT4OAg+G15OyVn?=
 =?us-ascii?Q?TGxFSWhcBmN+kTTJI1+HVtLKSlPFjo45NRT3kd5RIwdhQmhpqHe8zH0hBK80?=
 =?us-ascii?Q?M1jNy+w+5PUR0t/ZYYWUzCQEnwFORuvMq+RgIQv3/D3ALpbis0z5WP1bP39D?=
 =?us-ascii?Q?jgVgCV23i+8USXmItJIyLekGPnnb55wieyyR08u1BicuoZhI4MrE+GX2wHns?=
 =?us-ascii?Q?0WLVOVFNv3mlxU0ig2Sp3TuXNA3Z3ckyrYifNh/wNUOoRM0k9DU/8LslxvZ1?=
 =?us-ascii?Q?14jF+FTnoP1HpF0SNTQyJl35dqWPPQl6Si6vKRTFud6xN31mIG2VLS7PWdJa?=
 =?us-ascii?Q?oTTOa0PWZMUbJ082y8kxFLYk8IcmBST3HL+arGTs+vkkwsSMRZPJghEGOC++?=
 =?us-ascii?Q?jpeX1VzIzZgGYxih9PPUBKHwTIKse5nUfjCVNEis2FSUH/DWt3IDjShLIGBr?=
 =?us-ascii?Q?ypNMQ1+18kSYnt7jy0fX7Zuh7ZQfiJ63mk9D16xu4Y58bCazLWQGdX7N4XkK?=
 =?us-ascii?Q?0rY6mMp1YtNrnsFvRAteSwYGhGo/WHkxt7YNZW9z6uixtp8CaY9yQR350rBM?=
 =?us-ascii?Q?RLbB/bxvb5iEVyLWCWkyfenq1xXV1Elm+AM/wre1NQSiDAA3zFxyx+EA60Oj?=
 =?us-ascii?Q?6hoewUAHHXWOA1I5dFgACF8FbssgrrDQIX6lMJ0dX5hlsa3F7RtyTk4Q0gtU?=
 =?us-ascii?Q?yCR2U7JwHWl7PQqHudX+LUOEsPkAfAxL6eUJIB0E2jqlL3QVyrajVxqw0WkT?=
 =?us-ascii?Q?F9uqx2J8jHuv8bVRy4fx4axufwQJcz1v+EY3hg8td3wuwY0rGSO1zVmzBB0s?=
 =?us-ascii?Q?Qk+0zTZykbWP6FABcJW3sZQIo4TlP3gTaRYIp4/r1v4pE8xWRZWFO9k4rxrX?=
 =?us-ascii?Q?BGYXSLoRiXtP+vxiijN1zxAiPOIFhNgu+8jd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 19:12:16.9314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 606ef077-e09e-4ca8-fbaf-08ddf554f39d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5604
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

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
If the first data point for a custom brightness curve is not 0% luminance
then the first few luminance values will be ignored.

[How]
Check signal is below first data point and if so do linear interpolation to
0 instead.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b7b933a33316..2f856ed99b63 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4821,6 +4821,16 @@ static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *cap
 	if (!caps->data_points)
 		return;
 
+	/*
+	 * Handle the case where brightness is below the first data point
+	 * Interpolate between (0,0) and (first_signal, first_lum)
+	 */
+	if (brightness < caps->luminance_data[0].input_signal) {
+		lum = DIV_ROUND_CLOSEST(caps->luminance_data[0].luminance * brightness,
+					caps->luminance_data[0].input_signal);
+		goto scale;
+	}
+
 	left = 0;
 	right = caps->data_points - 1;
 	while (left <= right) {
-- 
2.43.0

