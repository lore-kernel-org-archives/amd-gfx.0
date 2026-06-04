Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F47CD6E4A
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 14:55:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 114DB112850;
	Thu,  4 Jun 2026 14:55:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HPVIz/pg";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E83CB112853
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 14:55:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYxm0np2i0vkJ2wiDmAB4T6oZwCgGT7GuzsR5z81MMwaFypWVrAk6/UG+GALYZFvt1DB1N+N8YJZ2nc08C4WHbRyZ4tTeHrBJSXCwhE6EzZSucdm9sdrW4/juxlq9e+CaWHJfHpwOfdcMhxVGoqhKPoaKmYKvDejER7UAjMcFPJWTWq8WjnVBVFdyucpyF8uQXwC2PghjsiUqCII3ce2O2v6hlVbEDaHyFjY4PL93V4oS93izhFyZcxQb9wmJSzIdNG+LRV94GlmkbYzq6zdH6xC/CBTmKZ8xvGKy+1rhcNNGuAzVHgmm1IxtEAzoaVq5mlOtW08uGHRgGtKBkeypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqUsFaB/FKYyvgUC776Jii92AHGei/YD8bbbdMs67Ss=;
 b=h+EGs3yMPcWujxUeIe6m7fe0W8Od7yDisT2iENcgSw+MZBykTDXYMnN2szXuGiTvBZsYcd2UlfSrWhMLOA2yj4zkNO38rxHwDtmzH5wHOb7GdKk5Bd3iwIt/HzKXemTKqBAGNZwWNyGT9G9Dy8Jci3cK72mYsn0y/UgdmQlI70s27tigeXLEuDIVA08Kov3erIOo2Wq5wPjCtHUWNO4xWZRM5IDHcpRZUHJRbx/MpJqeKyjWtDZajt2KZ9CpLAhdXevlFesEjEt8imZXcfXaCLEgTMjHPNykaAVirdVmY7bD61WPlTyryDEg/yu+jDJFEnpv5DoZbk8PwQic7kVJEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqUsFaB/FKYyvgUC776Jii92AHGei/YD8bbbdMs67Ss=;
 b=HPVIz/pgqbH2J46lyvnPYMrswQhAhDdP243hHh+5wU3no2vLYs+4Xw1piAdfZNqJL0hfFpvJ3tLtWBk4+d6/aI4dImWgY1jusAKLV4SaYTzXmzNizm8S7nXjqJKTI5OLp5vP/ges+LsxqkRinG/w5aIctm3/mru+dPIsATk0atE=
Received: from BN9PR03CA0334.namprd03.prod.outlook.com (2603:10b6:408:f6::9)
 by SJ0PR12MB6712.namprd12.prod.outlook.com (2603:10b6:a03:44e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 14:55:26 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::31) by BN9PR03CA0334.outlook.office365.com
 (2603:10b6:408:f6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 14:55:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 14:55:22 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:55:08 -0500
Received: from aaurabin-tumbleweed.king-squeaker.ts.net (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 4 Jun 2026 09:55:08 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>
Subject: [PATCH 20/24] drm/amd/display: Always create delayed HPD work queue
Date: Thu, 4 Jun 2026 10:52:14 -0400
Message-ID: <20260604145428.809959-21-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604145428.809959-1-aurabindo.pillai@amd.com>
References: <20260604145428.809959-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|SJ0PR12MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b3f269-eaea-48ea-8ea3-08dec2494d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: A7k7dnSSJZmdiYos9a5QTQ4q1/saVtD80zVJWJ2rqoFyECob7/9PWHpvCrxYtjhDasg0Hg2/fP9sketxq02BNsxv3HliagffIp+pP85aIc5IBcxtFkcmq4T0LOIy2ErnOR4J2rY/g42N91Zre9jIlNEl841hN7PPQ7sZtn7Ol0jSUFyXC+vj0JfefSr90Xj2dOt99a3zSBOPCknTkFsVva1SSt/OSIsE3Zm40B3DNbVGXvA456EWFODr0KGfWsgw79Txt1x3rVkOGkDIHc1dsb5sVXRl3QshXIm8lSp0kMWYI2qSa5WOwVT1+JM+Poua/RrLZfdBap9bjACeho7u5j5ZWSSGZDY9L/hDnDht+GncVf0IluAtmRqlBGOIM78msEhAxTEwgQCGwRRTeGRegWTjghHuh0vJC9x2+QnJbEL4Zz8uZ+QiiyxTHHCTm+H08lTdI5cxCZC0hvR5FGbAvp1Qmzyq8CffU//Rsrwtwr/2wRzSM3mEctIRrvMupRK1AlVG+cNz1qD8FirsMZXJCjkNdDz1cMMYcG/2pBy36Rau6lCGzgb7T7SBvQBaLqGb/1buD9R3dS97HLMrySgm3rKb4ivO4YkGuXrPmSMBhWsdNVqFXVKstOLF6+HFIamyLNJ5YS4ODkVjjV0WaRauMnJq9MnZM2wrj7MmTS0jXtAt0PEzwKmtvUZI4kDfaZGmCxvSYsX0fsCsCVPTK+E50LOef+kmyZ2wcG/LjUOqZgE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hYgEyNzDiyOZZ4EQ0Y1oWZI8OJ993DyGh3JktHrcSI46jMPY+HLwFjsHb/0bPDZua+/Wp/EPs7ScZx0yN3YTgw9lWohzAb6oIClr24itwseU7PA7VyAdsH9KD7C8KR3RYIhCB5xFG1AP+4/55FTMO+8lLUD0XECJ7OXgWviNZ8bGYeb/R7TmEdh8PFzv/0LdvgJWjQGfqZbmXmoyKOu3vQAKq3ZiduPJYI9+913anIl8VVDPd/2GaBhfHZAataSmfH3FbrTeIEfiXvyfv/Jw5P4aym+Vf+y301pSJYzoyXLatKU9O0EpCcaBnfOsRc5K0GDPLGlwSiAbyiDG3xT/vw3TPz0qiCa6tw2owUOfJTcSJZa7yD/lvdkRhfXhWKVHhjLa1fBRdYDnQbekYMtZQW1eVFkVokG79Q3xSVQOA1QG+hT1Z1rE+vEr2jts3QuT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 14:55:22.2209 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b3f269-eaea-48ea-8ea3-08dec2494d8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6712
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

From: Timur Kristóf <timur.kristof@gmail.com>

Not just when DMUB outbox is supported.
It will be used for normal HPD events too.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e1d23dd3c2a7..d1b1eb67d937 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2240,6 +2240,12 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 			create_singlethread_workqueue("dm_vblank_control_workqueue");
 		if (!adev->dm.vblank_control_workqueue)
 			drm_err(adev_to_drm(adev), "failed to initialize vblank_workqueue.\n");
+
+		adev->dm.delayed_hpd_wq = create_singlethread_workqueue("amdgpu_dm_hpd_wq");
+		if (!adev->dm.delayed_hpd_wq) {
+			drm_err(adev_to_drm(adev), "failed to create hpd offload workqueue.\n");
+			goto error;
+		}
 	}
 
 	if (adev->dm.dc->caps.ips_support &&
@@ -2274,12 +2280,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 			goto error;
 		}
 
-		adev->dm.delayed_hpd_wq = create_singlethread_workqueue("amdgpu_dm_hpd_wq");
-		if (!adev->dm.delayed_hpd_wq) {
-			drm_err(adev_to_drm(adev), "failed to create hpd offload workqueue.\n");
-			goto error;
-		}
-
 		amdgpu_dm_outbox_init(adev);
 		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_AUX_REPLY,
 			dmub_aux_setconfig_callback, false)) {
-- 
2.54.0

