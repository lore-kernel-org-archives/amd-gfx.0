Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080F6C83F1D
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 06:53:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F4AB10E521;
	Tue, 15 Jul 2025 06:53:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HsG0QYNG";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 826BD10E523
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 06:53:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlj+pez4j2Ch/2105fGsoT8R8TeQn5dQFgliTZNd8eyVlHQx3AEvBdhMV5PYEAFUBQKYA60yblgkmjT2Xpp0lZ3jL+xXWQda7aBx+uy75M8fg64ZZQ9H15bmVy6X2fDZ2+3eeGGAyIZDTeUNARbdV511VyUKV3Mzj5Bpd/ONs5U2hOyBcfFgijGUmTZGTb+7+XVODEKzIgAs/hPU3IbTPbU5A1kxvRwd1wQw0UqYfwSqFOTxuX0EOgDPM6fo6lamGW2Ha9RPs0Jo4CsdvG6IP45GnCH1nwmxDTIfRUMFU4yVnGFGhNlgfIsabj9j55CI7Qetw+DKNqnL1/GO5NqpQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMblnFtXZe58Z267hpjehCtDRAaAW60508sE3a0eS6k=;
 b=GaWzQ4WCJouLqE/CwX7C6/iN74k76NDbVOgzqFbQy6iMDz3QmDZWvo0EDRf7Fxu+4zTNQ6zS00+mqmrCuAyFbsgBB379Q7xhAukB2ocBztwELqW8aZ9vceAoCQIdn+6unOleNlWs2cJ4H+Pqa7LKX+ZZeE4NA5Jby5fY9QMxTkXjI1iaTaIShX0yIzQETmiUNRFegcY9nts5DVaxrSdRKqBIff8A9HS4IYZ5pMEItXnyCsq1J4VYAycngpv/F3qi/lHCBzwyXu/wBkFH0z1tignhYQeyFeUSpisPCZD0p/5Q7nLVrBi6zEDdUNHcmt876whSSfMVRhOrQGLK4Imuew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMblnFtXZe58Z267hpjehCtDRAaAW60508sE3a0eS6k=;
 b=HsG0QYNGNUtSRFnbsc5cr5kbd6i1hNR0tvalDzwOoJX8NlzQ3oJgjMAm1vOiHoX1fafXb9iLB8LPfI5Fa7TweZCkrSuC5QBOhqlEavyK8YkRGZNe/ZL2Ldj8bbbDa3cYRQnOQHWFCMGIyzbRrETjOw6PlFJZ+gNDo50LaEK2MvE=
Received: from BN9PR03CA0796.namprd03.prod.outlook.com (2603:10b6:408:13f::21)
 by IA1PR12MB9521.namprd12.prod.outlook.com (2603:10b6:208:593::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Tue, 15 Jul
 2025 06:53:33 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:13f:cafe::c0) by BN9PR03CA0796.outlook.office365.com
 (2603:10b6:408:13f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Tue,
 15 Jul 2025 06:53:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.1 via Frontend Transport; Tue, 15 Jul 2025 06:53:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 01:53:27 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 01:53:26 -0500
Received: from 172.93.31.172.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 15 Jul 2025 01:53:22 -0500
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH 07/10] drm/amd/display: Drop unnecessary 'rc' variable in
 amdgpu_dm_backlight_get_level()
Date: Tue, 15 Jul 2025 14:49:31 +0800
Message-ID: <20250715065233.160043-8-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715065233.160043-1-Wayne.Lin@amd.com>
References: <20250715065233.160043-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|IA1PR12MB9521:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d68980c-3ee8-4755-092e-08ddc36c5048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K1NhyFqnAtij+LAG9TPXKquOpzCh0BePP32+d1vhW0R4vVfHX6EGJ9iDqGVi?=
 =?us-ascii?Q?cHssBAqdlC1JSs74GoChqmbEpavs5VcRc0Wv6r1F43T+hynDFBBBScdOeHMZ?=
 =?us-ascii?Q?BG46NBgsHb2IbU1GF6iJOH+nd1hZwKsqoVla1cWcb1rNzB3GhtKxehzcM49g?=
 =?us-ascii?Q?6npdgItcwBfK1+VRMbCmMa2JCAbltsTEwL6SOYiZ2LYZkRpZpaW+DC3bt7JB?=
 =?us-ascii?Q?4H5Vk7SU+3+fUY5EQYiJxImot16PGZFK/Ms8X17eTqkiG/zFjtX4R1di9zPv?=
 =?us-ascii?Q?In7yzDG0EljVk0CokuZFcW3b4wzqI7tx8pdAY/CXpeFqQjErfxLIBKkzBWTp?=
 =?us-ascii?Q?EusjOi5ojtozcs7D0R8gg/yOGR6KLcCRm8VgbJ+2YVFNpDCkRGhYqdP6qi0a?=
 =?us-ascii?Q?HinpOZE7P9W4RXpyt0Xxxg5olbX2lKibJS1Qsbdk6x/YMrFWrXwue3KVLxtr?=
 =?us-ascii?Q?l6wgwQ0NFEBPC3zZyDGOA5X+hCVlVp/+QpXLz8ikXvSUvMmdGQPoIqfzN58g?=
 =?us-ascii?Q?Ya4t5FKvSHnI/Qr/YI7Bul9+xWEYHOs72HTLjeF8ypCy250/JRpXuX+9WIwK?=
 =?us-ascii?Q?rujSh6pnaycTPCcU8gkEXE82nsCYnBGZ/Ue3uDKtcyhRJL7S6H0wcgyAQRu2?=
 =?us-ascii?Q?ldDYjRtVpDBLgrmb4SVYcQVtCqVPBFtS5+/7aXBAr92SgKPnPOPEjOJTS9ka?=
 =?us-ascii?Q?UyvdxQ9iCFTOE9G88sK+A9w3p3ED6pQWg1aqd7CA1aa6H8qBHk8p5PjRPvDr?=
 =?us-ascii?Q?71JJFBuER3pQWSJcevyUPTd2qJNSs08/IkzCKIEsQSprylU5d48IkunN84O1?=
 =?us-ascii?Q?idu5BBBUKyXJazsVi04kJ+T728M3TgTca8g2mreSf7Fee/iEXmVpItFtw+qi?=
 =?us-ascii?Q?Yt9t/aG3ZSFaOzlM/ID4u/zk54M2LAroaVqP1VoVHnqO1wXTkWPYwCR89dsY?=
 =?us-ascii?Q?7Vd4jFJZA0j2wdxiZfgVeasfVQ+/tBbMcKeO0+vAM9ics2LgxnooppkfFI7g?=
 =?us-ascii?Q?Exo1iMirNtWR9FtxZ1RoigAokQ8ij1hWy+O7VAC+atIHTF7UTjcw+NCi92NQ?=
 =?us-ascii?Q?lwZPc7rQ1Lj8bmfbJR1oXWUrv07FEoewV9qNI4EpPj88sIvwLnCQAoryKwnE?=
 =?us-ascii?Q?bjO+vltSeqC/plv64JksAAgZNe8JSlvUSTL6YrNnfPBHN6LIyvvmH06e9OZC?=
 =?us-ascii?Q?/IVhrI6WOXvy3idzvZv5IS2Wjmy46Qmi787aU6U6RIbA/06EPeA+iBUiXROH?=
 =?us-ascii?Q?moc7dfceMJCATJUWrd6yUJLYNFH5Fkcht+toZGsMUTXS1xNgACfBCdAYdK0H?=
 =?us-ascii?Q?BvfduDYSV246/Da1AXlSt5+bhzr3/8ZccKcVsJZQMG5A/119cXiZPUa0qYpA?=
 =?us-ascii?Q?WMno0tC7Vsw9eqB46RO9I01ENHJ+cLvR8wRJqDYgrkVj/xxnHnym0mX9t6fu?=
 =?us-ascii?Q?x6yFZTE1RmM4UO8bSAQ93ATmm0Azohb0tp1ZDPRgrJQjrqENaWgM7VN3RCRT?=
 =?us-ascii?Q?oYGe8JYZMco5Dw3dCWz/6at3K2AA3GllcFWZ2a5mgcMFhfmfZh5HFtKFuw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 06:53:32.6836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d68980c-3ee8-4755-092e-08ddc36c5048
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9521
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
amdgpu_dm_backlight_get_level() returns a boolean value but is assigned
to a variable named 'rc' which is generally used for return codes.

This can be confusing while looking at the code for other issues.

[How]
Drop the variable and just look directly at the return value of
amdgpu_dm_backlight_get_level() in the if statement.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 096b23ad4845..129476b6d5fa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4924,10 +4924,8 @@ static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
 
 	if (caps.aux_support) {
 		u32 avg, peak;
-		bool rc;
 
-		rc = dc_link_get_backlight_level_nits(link, &avg, &peak);
-		if (!rc)
+		if (!dc_link_get_backlight_level_nits(link, &avg, &peak))
 			return dm->brightness[bl_idx];
 		return convert_brightness_to_user(&caps, avg);
 	}
-- 
2.43.0

