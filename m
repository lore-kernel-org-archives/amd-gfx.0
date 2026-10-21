Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE02B606A31B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MgPZEthc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6659610F94E;
	Wed, 21 Oct 2026 06:26:32 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013004.outbound.protection.outlook.com
 [40.93.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A09A10F94C
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:26:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKUerx5HPzwRIwLX+ZGgwBST48XW6Mc/4xwVo8Nr3xlOMdK7qK1H4EG+fdMu5ku2r0xRuFwXnI6I8Jkvf2Y6Vtwp9f8wxUeNJrFA/pQpiUzoyU7nw94yCAlonESVAXjPVFNOLBsk8HZXp/yYfdu89EnKllZcdNDzYLQ939pN0yGMa+CezgwFt9+PlI4T4uFcDcQFobhiPVb6MIgPWKYJUDmlU3B7NeiGmOCm2Sr/bSv4huZ970t3leOz0WVNWxlOizqLPOME0Lg3WC5KzGUwpuuzotohMJhnFXwsaS3c0N/qHplLSpCNJC1UXEHBgDWs7knDBO+nz0YGrWYuGA3EGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4/+QZQErV6Iwb1vIL+VE18tGaXWQoOcIbKhG0Vkyag=;
 b=Yb/4rLvlBZ4KF0AdoGQjFBT7msp7taOHjwNKbr6aXO29Zy6fpSyVueTx2OBYbJFOT22LJ2zvgHukPq/6b47/p8GEBursg6YvhKLw5MlbIMiTRDW+mypZ0TX0EJVc0CaMGPv1hlmgphCY8kE1CIstRX2j9ctL0WBJmYBR4EDqaEp+yh1Ad462J8tmu2Sdaq+FDJI2lVIAu+BZXieeq90OKnFr0nimsDpTVpO5CClzu9T6yjcWOQDp7qcSl63pOFXtduCsD8wKJTFMtl7vQsLjwAJA8Xpq5CU1TO5UGS+XxRGBPXY6DAhZpHIHc8ohIZx1B5V/p8Nn1EQ1QIETTA+RWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4/+QZQErV6Iwb1vIL+VE18tGaXWQoOcIbKhG0Vkyag=;
 b=MgPZEthcVdIvUI4T4RZI/dFIBcLWWf2enadlVPFc/0s9RiSSesvrtfX7HwYKap5KUZd3O4dSRDgGCXm/5hRNoDy4Qw897FqnC3J3TdJrS/utzXHT4ggO/zXHWCjCNGKgbrXFfKf0/Atj/xl1TL8buZFY8x4PErYLEKBk9+53WZQ=
Received: from SJ0PR03CA0346.namprd03.prod.outlook.com (2603:10b6:a03:39c::21)
 by CH9PR12MB234974.namprd12.prod.outlook.com (2603:10b6:610:315::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:26:22 +0000
Received: from SJ1PEPF000037A9.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::42) by SJ0PR03CA0346.outlook.office365.com
 (2603:10b6:a03:39c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 06:26:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037A9.mail.protection.outlook.com (10.167.244.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:26:22 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:26:21 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:26:21 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:26:17 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 16/49] drm/amd/display: Fix CRTC init cleanup
Date: Wed, 21 Oct 2026 14:22:22 +0800
Message-ID: <20261021062519.674697-17-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A9:EE_|CH9PR12MB234974:EE_
X-MS-Office365-Filtering-Correlation-Id: 8beff691-cfaf-4a80-a483-08df2f3c39a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|6133799003|22082099003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: M23SK6VPwlOwjRthh6xDCDJsfxG89c97R4o7F9+16nmKjcD00nomf3Qyf19v4dAYo5btS5TiWmgQ3mwuylH8eOy643RjdV9g3VxJNOcqKXzvwNS3StxkWNehBYZ1Pu1mpaZJ7Fib/5hOzV8RV5Zu7JGTA7Ru3wubrNiJ3OGXOKlsTRChMe/U2IInkv8SVUZvxtZxJdugdE8e6jxL4s1QR91M5qDYkoe1iFoHBGwTAo/+/0ejCfcJfBbAHYjSh3r48qm/H2Gd9WMdmp3KUAE2FQZQKzmsZXQHWd5Kt+oiWICUzI15c93+kBd7LxXjZ+bendIUyStro7fcrTYxpAzJiP6EtfYk9MsuTrmnCxRAk3+JUJA18Osx15MKEuGjKerxlHsu0dKt/ohoUvli2cPBiVkuU6AVp5lQWbKGY/P00MJFBL/5SC8X4r7GUrjDhjb3KAcNPksUM7lSOeEtvxVhfCekmBQ+uZLzVGEWvL89IlwCvBqVtcN3+wK7myfNJ11fn78PPwmiv9Ph1ILBof/dIQM8Jx5bJdypVt7/VXnNXXZJHXi3ltbp9BtHX9cKeVX9GWtce3RG7Ql9N8Xy8t9Wo4l2JaamwFEMBooRVYemzBoO6avVNH+vhhPo+gX656I6SrbRj9Byd5y7PdsK7itaZRB0v3OMfV1swgg//6as/k2CaYkzXkm6b1YihRa0301iV1IXLXIn0h+c563Gwvourw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7sfb+p1BATABJXvYVYYeyMqJSr6pXj7r/tx5TfZwUbxYsH5v2ZPtoFz37h6dKnPXMqHPHKYITVep/XbbaGDmEgF3F3szM1hxJab0gaq7uD9HalI+gL8vZqE0IKhsJZF6Y3m/kjL75Zy2kILDoRq5NMAAg0JYeKpggS9Yg1aKMYnppFSH9VWbrOQ0DjBMzAxt8CFw+GkKbRVpRW7VzG67WqJvqmSVcwpP4r1mLCnunCp8VJF5Al/6DutQQh2pNqzHdqJrYkM4ccxQxCHToo9NEZGzdilQLb8HIlWc/ZEZQ3t8fwml5GfqDt5wpnEZ/yPefoVtdiGWlPiA69EhxKPA9t+xtpMiiAZKsZ0F/2NdQDM9ytfRO8nBRnIclRpiWu0nrXoaeiKlhhKD8mTrhUxbvZmbg0RTKOPEySzhbpi2YDymCr565EY8dxJ4gC65pij3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:26:22.0163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8beff691-cfaf-4a80-a483-08df2f3c39a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB234974
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alex Hung <alex.hung@amd.com>

[WHAT]
CRTC allocation failure frees an already registered cursor plane
and returns success, leaving DRM with a dangling pointer.

[HOW]
Allocate both objects before registering the cursor plane. Propagate
plane initialization errors and clean up the registered plane when
CRTC initialization fails.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c   | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index fa6a481c8765..8d31c673817c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -778,13 +778,15 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
 	if (!cursor_plane)
 		goto fail;
 
-	cursor_plane->type = DRM_PLANE_TYPE_CURSOR;
-	res = amdgpu_dm_plane_init(dm, cursor_plane, 0, NULL);
-
 	acrtc = kzalloc_obj(struct amdgpu_crtc);
 	if (!acrtc)
 		goto fail;
 
+	cursor_plane->type = DRM_PLANE_TYPE_CURSOR;
+	res = amdgpu_dm_plane_init(dm, cursor_plane, 0, NULL);
+	if (res)
+		goto fail;
+
 	res = drm_crtc_init_with_planes(
 			dm->ddev,
 			&acrtc->base,
@@ -793,7 +795,7 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
 			&amdgpu_dm_crtc_funcs, NULL);
 
 	if (res)
-		goto fail;
+		goto fail_crtc_init;
 
 	amdgpu_dm_ism_init(&acrtc->ism, &default_ism_config);
 
@@ -833,6 +835,8 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
 #endif
 	return 0;
 
+fail_crtc_init:
+	drm_plane_cleanup(cursor_plane);
 fail:
 	kfree(acrtc);
 	kfree(cursor_plane);
-- 
2.43.0

