Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E23CC83F17
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E30210E532;
	Mon,  7 Jul 2025 19:04:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o49QuWPf";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4006510E532
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfPeb0l53ChEeUAYp7RFFzlV4yCI4dbe4RgS4MTzDRQGlM1hbJMYUajjfVzNSfjE3zQV4S73n4djGlkmm7A2UCSuY30XdNgvelvp22rx83mOFnAid8FToqgnZq8KEqjTdV42r/idVf5NB9hWYXtS9TVgy+MvfJ62b6cb/R8HtYBhrH3dN5zwwmMzO44VqzW7U1aFc0GmeeUcghxIo4hFEqRX/IaeVp1NmI+26MGBHL1mB5NX/cYc1d4Rg4yJzCTRE3YbhfrVxbYGbM7oJLQobW9eD8NglBJ3r/GSt5DkxdQD9hac47i57e3xMW8rzSNXrLsiIuv58ZZKzNLunymA7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hxvv7R8xDG64acPrSbYbffTPy80bzAJkSBKfdPfUl3k=;
 b=HYS2oqcOQzI+jvGktbnLK/Qr+l0tIZ9/PIOIkfEavKqyFPbOpa9d4hgi6GVbxezy218BaX4G2zflk3h7SEK/9roR+BAq8HfxWAfj5xP4ZWAIVl6hQi20B4tC0jK+8t1VYSFzmSkE2Ke6SzKTySmJVUPqRZkcZy8Q+7NFAi8rGnzALPtP5eJ+G9Qnv1oNKCNMI0zgHw1qlGqEs9QJAUecKrp9HrxWTtUEcK02qtzCe7w6gaTPvYLHLmwb3fUDM6ssei31OJ1j/LenqcEumbYwA2TRSVQZbpjHWoC+CCMP79PClJf3EWfzGP4P6lNKBrqRysD+QUwVqsysFT3e1gj1KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hxvv7R8xDG64acPrSbYbffTPy80bzAJkSBKfdPfUl3k=;
 b=o49QuWPfAiIhoBBB9I52hFPaxtBomAju0Ekr7gdZ8XA20YYBfnivUUs3i4xEjmhrKjEgI4Ae2mqa2Nptcih9jRrE+kRH7TnKMIOrfrMOf7wv7LEEKfa1WdyjRgdB9ONvI0PyxBh610aaB3c17EzdHvML0OxlhBG0XeqY+NOG/QI=
Received: from PH8PR07CA0040.namprd07.prod.outlook.com (2603:10b6:510:2cf::26)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 19:04:26 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::62) by PH8PR07CA0040.outlook.office365.com
 (2603:10b6:510:2cf::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 23/36] drm/amdgpu/jpeg3: re-emit unprocessed state on ring
 reset
Date: Mon, 7 Jul 2025 15:03:42 -0400
Message-ID: <20250707190355.837891-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707190355.837891-1-alexander.deucher@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: b11323dc-c902-43f9-fdd1-08ddbd891737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YyCucv61p/Rj4loL4/YyGSq/vGT2bn2Lio3fnRFoY2UEMxW8p0FMEffwFlEF?=
 =?us-ascii?Q?8+oIdpAYP6NleN6OG3F/BdyFJKMglKBkWa1NzzdhRaKJTKdVDkS/tVlmHGV9?=
 =?us-ascii?Q?Khc5SKO20qHae7gShJYMgAZVETgXtAV/nXie7ZxLUX8Tyh/9cMcHqB5eSQO8?=
 =?us-ascii?Q?T/5vX02BerVZ22gqJFOwiCXquFRH9j+gWkUytaVOZaMvXAY5aXL+1T/s+bVK?=
 =?us-ascii?Q?Yj3gWeA8klIqWaCbF33k4ZuHwnJhn3TtXerrajLvi2Ro1Nv9WPakMChzEMtL?=
 =?us-ascii?Q?AR14K2td0qg8H3RlKXS6vORWbhPdNhbigIPkifJTKU4QbOxDYgraXqF400qE?=
 =?us-ascii?Q?E5ah6fHAdoUJPUe4v1ngFzF3yk00kvrDWsEHapV63YDGV6yRSBoZJ5g+dmdN?=
 =?us-ascii?Q?8PfhZtJNaZY++BNJyyW3C7+tllku1Jcv02hDKD8NkgEkpHFFttq6FPcuW2zz?=
 =?us-ascii?Q?BsPHyLCgm+HRfdfgEyjudbFM7HRhWRjEyCpASNa+zqlB0jtYuf0aSWTXKTjd?=
 =?us-ascii?Q?sLvAmqAIRBXzikJNoGgnfqnEmvAjgxshfkOD+OKuqmgsfl/7MfFApfMqTS2t?=
 =?us-ascii?Q?c5lX5LE4H5RzEF2d4o6/09KOM55yjNM78+5oZhPVzZpinOvacpkMFfc8HIOi?=
 =?us-ascii?Q?rctXNHAUkNFiBLo+vA9TkJut7Qi4aEgOdyAJyCf4Ydx3ceK7jDGQlet9IO1D?=
 =?us-ascii?Q?Um/QR/1Ze5Y1HGL/YLUN2M3am0bTiOZFK3wF4pJmqXcVms23E5vuqnJg6ZOw?=
 =?us-ascii?Q?Zj7T5800aGwcSsH9kx+Q9UxU76RCT14VPoH+wd3XzPdXzbZdV8xszKTVrHTH?=
 =?us-ascii?Q?4Xp0YvjpnMH9GlBXYfNbyDcigqzdpmwonZZWlYBfygPRlvBAUyanebbmOvGy?=
 =?us-ascii?Q?LsxI4kH3QlerFMqB6DoMdYw0ZBOxxoxo92chROSZ1SBXjhIwjrzvKrofNuEo?=
 =?us-ascii?Q?jGgNjN7m6wIkGw0FOz8+sIr2tvWoP0nKlu7oGgL2XfNMFlI5cO2PMVSZjl62?=
 =?us-ascii?Q?j46jPrB6ZdkMLIcjpwYO3v7QSCfiRAnXSnXZU2pzlTSesqG8pBfJjer8sksR?=
 =?us-ascii?Q?hvgcllNYwGFQyEwECsLliKxdxOFA7Wb4IUku30Z0CEOgfITWvEEP6EJcRpi7?=
 =?us-ascii?Q?Oxv4jQDdlKW2QYFTFoeAdW07whv7PfX6zdJLX1ZowghUmmjox9GP5JZecIQ5?=
 =?us-ascii?Q?yU8op/w9426wmVsVwKdXL3OdMhxI9XUfoa1ZnOwXjUjP3ddbcw+/rC8CDMGm?=
 =?us-ascii?Q?b4QRGekHYgbpniCbsc32jwdIQTQPud5X5vOz+grpWEbs33vSnhZNxNmJPwsi?=
 =?us-ascii?Q?X67ZKXZmzspKrPOh8LNydkODfnUxdna/WvBqLyL6A7WxMubkW18Qk1eKYVd7?=
 =?us-ascii?Q?R/3W2m1XAh+EV0A5hCnjVpxNg1nZpqdDM5j0WpCYWGpfKfCG2GxQD3Okq70y?=
 =?us-ascii?Q?QIemPw7TzUNpYEKQovLrxvsXZGtHUfFifoEYWkl0cB8hdxYVFQrTOWlIDgL6?=
 =?us-ascii?Q?0A4KGyYd5V1DOFfGGVdhssKswDz9jOWatH7n?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:25.3308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b11323dc-c902-43f9-fdd1-08ddbd891737
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
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

Re-emit the unprocessed state after resetting the queue.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 5428930eafa3e..941787a8160a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -561,19 +561,14 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = jpeg_v3_0_stop(ring->adev);
 	if (r)
 		return r;
 	r = jpeg_v3_0_start(ring->adev);
 	if (r)
 		return r;
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
-- 
2.50.0

