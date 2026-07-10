Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5901AC43458
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 11:05:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D13CF10F83E;
	Fri, 10 Jul 2026 11:05:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="piUnE2Ic";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9541310F83E
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 11:05:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCSG5bIDX74U6tRVPNkszCvGqLgTCcZY7fm3p+S8DFTez0SbUY+iCLY/ovDSQh//8o9i9mCnnGhvPHBMy5DO2cWCvJjFz5jTF6j1SGzCb9De4UVfOa278Qd/5YZWGF3GV5VGP9LHGCOY1Trp9PR5i1U/X+uc8Uy5yWzpvbv+MtExD82zHI32zUSI0DC/L4FxLLrJLkWs1C1YB9ncjLI+tMR4Y/d4NkyBNknfsLO+HzJg/kdnc34UNv1iyQtUUfXGIqtWdvWmKQ4ruTDhatfDGNO5h98iculpigaVPhnyOeMPp/tjr3NVEWeOE6cYBzFEGcKyyOXMK0YgcwZsvv+JKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Hx/wpWl/UEKLUJop1mzZsymTv8OHLlgYuowlq2D8mw=;
 b=PozbEHTpdpVnM0kMVjA+HoplVScryWZVmKlVw6Assz0AA1T5DaRJ8ex/xlsqQ2TENW6hnv/a86ndhwmXPMzBwSkqxzcfUytWDUkaS4S9aDt8s97sC4Iu6VxUBTJZ5LreFRIrE/TmJPQk4vGafPolzgyeWrXYd4L5/XuudDDzrlj35og7QqwpKTtMEqlKHmAhUY/iMxCgMy9cyqcdJQpoVIwfe5rVAOPWT9YN5nXjRDZbJKQVaRUdVJ8gDSlH2b1wtyDZ6VASV92ZBpFlpKHRGGqjy9F10IwgXE3oVmZAASdBDI8vzwX8VGB9J/4x57tw1Uh3HX9D+cZbJWinG3rNKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Hx/wpWl/UEKLUJop1mzZsymTv8OHLlgYuowlq2D8mw=;
 b=piUnE2Ic3m006JTjBplDWaxSS0DuIuXZCRcVC/iaJmMtKTwtCZ8IqJsCEJPD2nEx5SDONCiQzwHEXjpAAPBmVKw4lrgG8hBlCu93kvYlKU4lJFgZEjZIinOlhAxkZM+RdZCCMJxyH7zL/gu5OEv1L6Yeb/RSyxjTA/9y9Js79m4=
Received: from BY5PR04CA0005.namprd04.prod.outlook.com (2603:10b6:a03:1d0::15)
 by DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 10 Jul
 2026 11:05:47 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::7a) by BY5PR04CA0005.outlook.office365.com
 (2603:10b6:a03:1d0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Fri,
 10 Jul 2026 11:05:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 11:05:46 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 10 Jul 2026 06:05:44 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <error27@gmail.com>, "Kent
 Russell" <kent.russell@amd.com>
Subject: [PATCH] drm/amdgpu/gfx9.4.3: Fix MEC rollback loop in EOP IRQ setup
Date: Fri, 10 Jul 2026 16:35:31 +0530
Message-ID: <20260710110531.3222353-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|DM4PR12MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b811c4-ded0-487c-9250-08dede7331b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: hisAgVZQJdrkbjXbIToXvKpjsOCTMmxcDPPMNhmUvsqkGimt08qlMCKBluQDLwFRyOzoLcvUelO9v9te9MQPUZ0EmjpaOQKcq9p1vddM3ifaek0rctpeBGIDOvig6/GPSzLgpUBZZfm2yPdf9wWVi6VbsPkUlcDFYMTwodhDY1KNqR1H5O/MGylGui9DBmh/u2P2DLtgBzuU8FzBiUIBE+izSfNkPprYXsG+qKZYBe8fV5yiQp6IpImv1E+oRwpd47RWULvdQv+m/NoPx2HCUr8p2QTvBm0W90yWLMOiBtid7/QobjF9E0M8f+gt55JSQN4J29fka3V9izzlsV3+7Tpe1YYioHsBqPDyBS2wPSkE6RuYB/J51pqrwNtAmSnnmBTbtchyD63iFWoty2qeqouSJN29+MRFiW1QGRC98BvLip+OSYirrhs17rXDAKXcyzulcmLBjthyd0hmoDaWHEGKM+KH1SvSqDbT9YNlBNhqVfm2MfmRHWHXHXx9EjgWRUvgsDZQTUx1hJuueuoIpDP6HyUdW8pw7pxIhq5JJJ0yPDmxv/1sg6ATYjfSUhUFog7bUxs5113Fzv6hzjnT8kmEcFTxtK4M8erFFvs/RZ8BqZ+TpXOc3hdy4TtBD6pbHSqHDobnXhv53C7lmggihw6s2pbcp1Ce+lg8UH/3WSB5j/TNCVAP3HQx663ferIe3I4MB25CKXVkfWx7d4xayw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lrwWZyu3GNUwCJsteayHsVprk9C1OSL7pkCULstNqASaGkAxR2fR1HIAi2U4d9errt1RYbTVV7YfTFKHMtxRZovDWaTYtiLugaV7IF0ZveMtHFB8wq2b1P86O6uBi1/PaYx9q8G2GBL5kLiQpjTH/AN/RKGKt3YQNw4bCxgLHT12Cc77tnRA0KpBwexiF4EiJPTtuNRWdN3c9usaJBQ8caFGIqFg559kO15vlTSj5OIRLY0l1wmZEs0kAiI+SUGfnNEHbCLVgEAsaRLVNCluJ0+xNcTsr6IV+BXTOwtvdAccK3EifKSFWMkAHlJ1yBtUfDx+68cbr0LDI07rVz9OIhnHsOAbniDzhj7287FMzBLjWDkrsiERWYWQh2LxLeqfbMk/7qjzWjY74n2Dk5XjBb31gSyp06AdxGTOXIyCYEXcFd+I2sx1su0jrsj5mm7P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 11:05:46.9058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b811c4-ded0-487c-9250-08dede7331b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6109
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

Fix the error cleanup path in gfx_v9_4_3_set_userq_eop_interrupts() by
using the correct loop condition. This ensures all previously enabled
EOP IRQs are released if setup fails.

Fixes: 832f0aa050ff ("drm/amdgpu/gfx9.4.3: add support for disabling kernel queues")
Reported-by: Dan Carpenter <error27@gmail.com>
Cc: Kent Russell <kent.russell@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 44d38b76cb4f..9512fef81d84 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2331,7 +2331,7 @@ static int gfx_v9_4_3_set_userq_eop_interrupts(struct amdgpu_device *adev,
 		}
 	}
 	for (xcc_id--; xcc_id >= 0; xcc_id--) {
-		for (m = adev->gfx.mec.num_mec - 1; m <= 0; m--) {
+		for (m = adev->gfx.mec.num_mec - 1; m >= 0; m--) {
 			for (p = adev->gfx.mec.num_pipe_per_mec - 1; p >= 0; p--) {
 				irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
 					+ (m * adev->gfx.mec.num_pipe_per_mec) + p;
-- 
2.34.1

