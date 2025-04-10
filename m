Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39E1C3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 18:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9684010E383;
	Thu, 10 Apr 2025 18:12:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c5vc4867";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9794F10E37E
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 18:12:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYksdenMSF2UoeWMIvOj1cWn7a/4FvNRof5Xrm4/gx5bDH8YcelwVDMB2m0M9yxypqcRU6X2U4/LhP3TeNyLoeV+OTtinRIR94kI30RLZcSH1mXieZuSu7NBIGBYdD8ouRVQdaosqR2mXsBWvgxdkYoWS2O5TNSQzTn95ZvStDEVjQYvdGRqMnvSemXKVCevuToxhYf7eapjDEikEO6lIgcEm/LNQXvHQfS/1CfrufzSaavrJ5r0mBIh0s4LvC3fZUbLDR3Dd2i4O1zCHTqf/yHzoccbFhFBEhGmT/RyAg/NHQXBs2oEB3bdqkczqV1SL3uK5+gcG/yfNPwcpGu1Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Z0Op3oajSq4XvZOslIU0HnLqNiEjssKur3eYcstM/Y=;
 b=ilArZIixxFZ3nfIYleeiiRBP81lIt6nji/ez4ABxJErPZBwnXMV6NDPiNp1LgSjaXrjmeJyL4NTG0T+oxT9xpp8B4ht4X56M3lVO5ZRvM1sTpwVsbweLoX0hreyX9TTpg87noqoMXP7NIo3X/EkagAUYs8b9fVrGWmensxMp/06Wa983HIpMHMMkFii773xw1n3bBOrrw2/3ZJLm690SLyjGbSsrVdkhhZOrUnnCNiRqGGvlCdlXoWNvuty3T48WrgfMY3hJSVgyy6aOKvNiOiIkJAN291Oq/9Ia0OsYQ/bIi84CdWVl0tA2P+S0m10wPA0TgKCI54+0agjw4VJC8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Z0Op3oajSq4XvZOslIU0HnLqNiEjssKur3eYcstM/Y=;
 b=c5vc4867aDYm/mx58o0Elk1x+y9YWr9IF0XwQkZQlLV3T/weCncnCGTgXlf0Y0NHfWXlPkcT/taAo1NniWyfBrPj1dr12tx9DDPDy3dJe8rGAKkPlLVykF0WcoVK/TEIA1YFvXl9L8ROAvRnpUg5ugFwq056pEQgXXpFRyY7AO0=
Received: from BN9PR03CA0349.namprd03.prod.outlook.com (2603:10b6:408:f6::24)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 18:11:58 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::d6) by BN9PR03CA0349.outlook.office365.com
 (2603:10b6:408:f6::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Thu,
 10 Apr 2025 18:11:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 18:11:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 13:11:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7/9] drm/amdgpu: don't swallow errors in
 amdgpu_userqueue_resume_all()
Date: Thu, 10 Apr 2025 14:11:36 -0400
Message-ID: <20250410181138.2287932-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410181138.2287932-1-alexander.deucher@amd.com>
References: <20250410181138.2287932-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: 8321a42e-6af6-4f84-bf4b-08dd785b2ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rX+9dmBqKr3NeEiUJgPpaBif/KuI2h74IZuhXmwOkIadvv7EE+YDsRDeowCp?=
 =?us-ascii?Q?ErPiyMGw22X7mfPDQC91LGDYszvJhBTjOXSUNZDPau65PtiqCwu3j/JMZdp7?=
 =?us-ascii?Q?kMBqcPNnCawsl+gUCt06ijJmMe7DyIX90O6CE0Ro9XiYIe4GcrqU6WT4/2hd?=
 =?us-ascii?Q?GKcu8CcEpjYcvxgCHePGgYSi5R+NVlbsvDvAw+jX1atNaf3zVOvv+2YKK8gy?=
 =?us-ascii?Q?yagoD7ro260wI0kOWktzOalIuOmi7o70czLGwQbuusGw08hqNjsKj5XC7J/4?=
 =?us-ascii?Q?4bFl1qqe5ZYCL4XN0QxcWLDyGSDLo6Z7QOVjhQPC8XLn2s1w3F66YfVweEIM?=
 =?us-ascii?Q?FJqcSfBWvf+MYKIne1GK5arWGA9w/sHuE5Squ+P89RPing9xLyN/Az+wqJ5K?=
 =?us-ascii?Q?fEYkwSx9vRCINy4PYX/3zU4tt1OV6J3pN3jx3tGoPdXyd79iMpRJ0RqbWJCW?=
 =?us-ascii?Q?1Wp6csusoWvS37eXsIWn4RUDXNsB3KKEl5s/hT/cP1kgxU86rjMUFsi7J+ZP?=
 =?us-ascii?Q?S2ohE1XlGCn9x2ggdUPxExEYZxuel1qCculn4gM0xI6T5NeoCeUWak5+3u7b?=
 =?us-ascii?Q?ao1w4Da8VG23ts0ZmQW232YNY5affd0xmhlr9n1gyNOvcpgbZf6G++ooC0mT?=
 =?us-ascii?Q?faITbxNebnKPu02zwXeDwh5q2BuDc4ABZ36ep0DbUm+3j7sqVbDSVHDGCLu6?=
 =?us-ascii?Q?S2vLRfaBR67sFhtwZxOr3IpZAU1CCGyMTNsOtAjAncMFBXxlDrGSbwiW1q71?=
 =?us-ascii?Q?pq89s/Xd4+0inrodZApHLZwfHRRe4WpiwXp78LpMJCXpafqKFC/oFHz74Jkq?=
 =?us-ascii?Q?iv2dg0wA8YwSHdT+Qpof+iA45AzNrDPK0atIUeSC4Dj/+Tq8IAlaHkfpnUNT?=
 =?us-ascii?Q?ttd5L6Pj4EwJaZOVfWcx45Y0a7LLeNk4t63WkvYVsnbiHTaFGfqfJZQks213?=
 =?us-ascii?Q?CfNZ0VcAZOOFkAehw7tqwl2RAs2jYv+tOi4bP8vLSSfCAc8swxBdt2/jDxXM?=
 =?us-ascii?Q?1/a4SXuVmQqkMhsYPJlWBRbOtT+aefSMAVnie8PevKcQYVyHVyelfG7kkYUc?=
 =?us-ascii?Q?SVUvEEWLSWxiuWCd1SA/FRY7Ug8Kd1Xi/riEldAQo80XTvXj1lLE/22tCagH?=
 =?us-ascii?Q?sVpztc0sg5Mox43YjeDkl+RC803F/WryvNkfLuWAhJxp0iR9OGJcd8QCaMc0?=
 =?us-ascii?Q?XUfyzvGO2LAXFGRlawdA0l96x6lfZs4hBi0LBkffgECpJW+b1Da0WlrYr2Zt?=
 =?us-ascii?Q?h816nV5Y0SITD7bVZcItX67RqfXnKfLOqAoArDXVD10vDRiZuEJGgsAWc8F+?=
 =?us-ascii?Q?ig6bu3d5Bqk+218Xtuj5VLCJM0Mzv4feT4OO/G2P8ti2qsHnvK7fGlU/QbRi?=
 =?us-ascii?Q?41yK8mw4ZpQFnjB8cFYc/SDXfQyOJqC/V6FvXMOkl5ADTRBGcfyTqdqG3tGO?=
 =?us-ascii?Q?6hmxbdPg27y+4aSmDUGUrVn7d3fxOzVOgVjjxctoccyQ5EL+R+R/bo0hJlws?=
 =?us-ascii?Q?gcR2myLXF1laXhk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:11:57.8471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8321a42e-6af6-4f84-bf4b-08dd785b2ecb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106
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

since we loop through the queues |= the errors.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 48e2df6bdf63f..09c2b01955c58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -422,7 +422,7 @@ amdgpu_userqueue_resume_all(struct amdgpu_userq_mgr *uq_mgr)
 	/* Resume all the queues for this process */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
 		userq_funcs = adev->userq_funcs[queue->queue_type];
-		ret = userq_funcs->map(uq_mgr, queue);
+		ret |= userq_funcs->map(uq_mgr, queue);
 	}
 
 	if (ret)
-- 
2.49.0

