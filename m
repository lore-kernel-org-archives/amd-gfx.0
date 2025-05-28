Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465CCC54ED1
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 02:53:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D06E210E182;
	Wed, 28 May 2025 02:52:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ENjKWnAV";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10E7E10E182
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 02:52:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+og+8NDdIMse5OQDOreIuxfMm73TtEsBJkK34ba4niieblxT8LmVrLy6VggnS/I+7JXd8AQQJoylw+kJFpjCamm20S7ZWQ+CDJvX+cR+5E5XLv6WP6DNZk0BKQsZYoH22lqYmR9Oxg2nnencrS6eBsB0kb7rMZlManuFQQG8ePMeKzslvnFaJyz90TPMYbKYHmxtpLfrhlDQj03ppMCGy2tVRDFUdfHnJkXV5uw2tmzEvT68dRWXuJcGWtjKB3b6y+Bb8LVeBxdJKee69yF0hpzbsRHwxwTm8rRhS/XIe9K5IZwwcowrVOkVXUH+Ku7pEdv529+hjrCR6fW1/zU7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEq269Qy7Id5i0/m6FEc2GM+c3Bv1Cc1KSK8HaK4FfI=;
 b=NolJ9zZrCUp+G+VKsSBrs5Kip8m4uXQZ/Nwg5LbH/LREZC5IACVStzimlKt0Unl35eIUERisbwV6EveFyCmQax8u/lCo8C7MpI0KpKFWx7gmV05TXlYP2kxu73EnBzCJNGeLmoaIdpU3X5JWkvnDHVzoaTNmCxNFcL6s1xlSl/fU2D65Z/ZKq8t3nGGZnWI00u3IBEkFxmHhspgLJj7F0LD6mxvZRjuo4ni+E/IQyyBNiiAT2zplk2h4C5a8zrSmcA8Dve6A+/is/b4GrIFOKbhgGE8t6wPLnhuny/pUX0RBoOX22mnXlXrAfwkZr1OVVqLk3oMmNl5G0E8cym3tNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEq269Qy7Id5i0/m6FEc2GM+c3Bv1Cc1KSK8HaK4FfI=;
 b=ENjKWnAV3asovEje05NNbbuO1lklpZ7khQAlzcKAwFlBQxqJSJBRng8YX1IoqgENeh8XEqP+wAsgoQ8UUyrzaKHE92XHrHmejFhFFE9y3XCK4NOwnhLDISK3e+AQfrELg9NHJrj2YjE+57mA0sh4CleNIAg1z9nRNv/1ETkLAOo=
Received: from CH0PR04CA0033.namprd04.prod.outlook.com (2603:10b6:610:77::8)
 by SA1PR12MB8094.namprd12.prod.outlook.com (2603:10b6:806:336::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 02:52:53 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::e1) by CH0PR04CA0033.outlook.office365.com
 (2603:10b6:610:77::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.21 via Frontend Transport; Wed,
 28 May 2025 02:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 02:52:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:52:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:52:50 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 27 May 2025 21:52:46 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH 07/24] drm/amd/display: Drop unnecessary `amdgpu` prefix
Date: Wed, 28 May 2025 10:49:02 +0800
Message-ID: <20250528025204.79578-8-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528025204.79578-1-Wayne.Lin@amd.com>
References: <20250528025204.79578-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|SA1PR12MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: 41eda608-af3f-4f43-acba-08dd9d92bd74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g+gmcQo5ksUvDMr1vl5CxFDU0P+U2ZsA4oLU6JW6qxduJsTpOenw95avmu88?=
 =?us-ascii?Q?OHrHjmU+gU7s2AJrgGkYhVH2pwe2ByxOGGGn6WHTeEnxyyXhkMRCQQuR3yE0?=
 =?us-ascii?Q?EEQITfaShHCdFwGb7xaInjuc0SagETpArvMVGEa9+5AAuV4BiXVvY0jf6Son?=
 =?us-ascii?Q?Pv11jFUpYyrlK5lZhzETIT4NnUIiqlqAlc4KPMTf4KUudCzvmLm2tl6cNLOW?=
 =?us-ascii?Q?cXd50djRRkHTfCfcC/qy89PynYRwvlh2yKR4xt4DMtVPyrPm4j2XRe3+grWd?=
 =?us-ascii?Q?66RB/xueIUgQJOlnrlo5LvkcoeN4bPxpBwkoOJnbwtJQI3qHv8RjzEtRH3pM?=
 =?us-ascii?Q?Pn4A2ISxVhDiFFOa166wGjIPkO7LbC6sYWWbR2Xf5XzIChno3ecWIix5B/xs?=
 =?us-ascii?Q?jSHIo2hi/mswVQdZp6wEXlXYksKdQAls8G/e+pf1d4zLJvFczwyLtf3xuzw+?=
 =?us-ascii?Q?79FqqXkvK7s/nARhD3JHWxHfu58Bn3yS7jcEQnBrVkqegAmiDCoIzyfT56JI?=
 =?us-ascii?Q?ZpZncmnKqR3yvJUlM4jPKJlg23mCxDKM4o/RwQGdY3OICflVqHNHVAbD9MK5?=
 =?us-ascii?Q?1gVK25JMMasAmFVTncdwSU/8FaYFpA98rZQfyjwhLHcygesUp78SERVFrzbD?=
 =?us-ascii?Q?cGCraY/bEsonu9h+QRbpSA4/NczHau+FCU2dE6sXxppp8zoU3pji5RtLvY8G?=
 =?us-ascii?Q?HB0gsZt7KtopPc04OHVLwWbiTfuRoku/y3OEXlYJIquhQvNIavN/pYDgzQnF?=
 =?us-ascii?Q?LVG4hnDHtWjtcP6ODYnNMJYldZmiVUSshWITKuRMpafTps7jGKUz85fyRNfE?=
 =?us-ascii?Q?wnHzdReAaS5yUzuxklc+w+iYqssTHjXbX740WSGGAR7AW8vaJbcMTvB7WzdJ?=
 =?us-ascii?Q?Rx/8/yf1WNCHBGr/Bxra0+NjvOQPNoV55/NaqS9Je5Z7MvjTnL93EAerf/sY?=
 =?us-ascii?Q?cJ/gQGNEvsacOqVlcs28+/5JyNysN6iI4oDSyxdVu43Dos31U2blmvWBiz3O?=
 =?us-ascii?Q?Mau5fuj/4szouvdhrDVumol9RZA+cutJfDJBe7tIb7qRsjDIor9QFxxNJ/Hf?=
 =?us-ascii?Q?CwcW3Qm3WL6Za13BvexcIJ299DCc/+wCk2cUvZUapKYGedV4ojPPqfDFleMA?=
 =?us-ascii?Q?Z6XaVZrapB3FCuSUV31DYhRrSVObtp7rE4lnFaCMk3YRu0DtzYbKk8Y0jWKt?=
 =?us-ascii?Q?B66EEbVN28/FNdJZcoO7z5ZPWqp9FcEP8Uw4o4MTNqGK8dVfFfg9unD3rlbC?=
 =?us-ascii?Q?W7809yL1AqzmUtWOew1rsbEw8hMb++4uDJVo6ExorvnlNNcONoOqpxQmXzge?=
 =?us-ascii?Q?W69laD4MUf541FS0B4iDMRu6gg0KK8FZzWznTZbL+thaxqKrytTyLDo2WaSQ?=
 =?us-ascii?Q?e7sj61dzXhSCkalsnti0sGCmRZ3gpb9c/UAf3t1kGZ8eouU7KhvHhIeP3OPK?=
 =?us-ascii?Q?ZyFDCHclAAN6MTG37xlN7yNTOagu4JS2WFbV4PN+CYztAApj6v/eup+nBA3s?=
 =?us-ascii?Q?//VgeU9wDw5eNIEfzjdoS1xP+RGh8ZWiO8iI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 02:52:52.5251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41eda608-af3f-4f43-acba-08dd9d92bd74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8094
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
The `drm_*()` print macros will handle including the driver in the print
already.  The extra print of the word `amdgpu` is unnecessary.

[How]
Modify all prints to drop `amdgpu: `.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 +++++++++----------
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  6 ++--
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8b32e6c1ec6c..afaa98e8ca15 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1847,7 +1847,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	mutex_init(&adev->dm.audio_lock);
 
 	if (amdgpu_dm_irq_init(adev)) {
-		drm_err(adev_to_drm(adev), "amdgpu: failed to initialize DM IRQ support.\n");
+		drm_err(adev_to_drm(adev), "failed to initialize DM IRQ support.\n");
 		goto error;
 	}
 
@@ -2037,7 +2037,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	adev->dm.hpd_rx_offload_wq = hpd_rx_irq_create_workqueue(adev);
 	if (!adev->dm.hpd_rx_offload_wq) {
-		drm_err(adev_to_drm(adev), "amdgpu: failed to create hpd rx offload workqueue.\n");
+		drm_err(adev_to_drm(adev), "failed to create hpd rx offload workqueue.\n");
 		goto error;
 	}
 
@@ -2053,7 +2053,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	adev->dm.freesync_module = mod_freesync_create(adev->dm.dc);
 	if (!adev->dm.freesync_module) {
 		drm_err(adev_to_drm(adev),
-		"amdgpu: failed to initialize freesync_module.\n");
+		"failed to initialize freesync_module.\n");
 	} else
 		drm_dbg_driver(adev_to_drm(adev), "amdgpu: freesync_module init done %p.\n",
 				adev->dm.freesync_module);
@@ -2064,7 +2064,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		adev->dm.vblank_control_workqueue =
 			create_singlethread_workqueue("dm_vblank_control_workqueue");
 		if (!adev->dm.vblank_control_workqueue)
-			drm_err(adev_to_drm(adev), "amdgpu: failed to initialize vblank_workqueue.\n");
+			drm_err(adev_to_drm(adev), "failed to initialize vblank_workqueue.\n");
 	}
 
 	if (adev->dm.dc->caps.ips_support &&
@@ -2075,7 +2075,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		adev->dm.hdcp_workqueue = hdcp_create_workqueue(adev, &init_params.cp_psp, adev->dm.dc);
 
 		if (!adev->dm.hdcp_workqueue)
-			drm_err(adev_to_drm(adev), "amdgpu: failed to initialize hdcp_workqueue.\n");
+			drm_err(adev_to_drm(adev), "failed to initialize hdcp_workqueue.\n");
 		else
 			drm_dbg_driver(adev_to_drm(adev), "amdgpu: hdcp_workqueue init done %p.\n", adev->dm.hdcp_workqueue);
 
@@ -2085,20 +2085,20 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		init_completion(&adev->dm.dmub_aux_transfer_done);
 		adev->dm.dmub_notify = kzalloc(sizeof(struct dmub_notification), GFP_KERNEL);
 		if (!adev->dm.dmub_notify) {
-			drm_info(adev_to_drm(adev), "amdgpu: fail to allocate adev->dm.dmub_notify");
+			drm_info(adev_to_drm(adev), "fail to allocate adev->dm.dmub_notify");
 			goto error;
 		}
 
 		adev->dm.delayed_hpd_wq = create_singlethread_workqueue("amdgpu_dm_hpd_wq");
 		if (!adev->dm.delayed_hpd_wq) {
-			drm_err(adev_to_drm(adev), "amdgpu: failed to create hpd offload workqueue.\n");
+			drm_err(adev_to_drm(adev), "failed to create hpd offload workqueue.\n");
 			goto error;
 		}
 
 		amdgpu_dm_outbox_init(adev);
 		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_AUX_REPLY,
 			dmub_aux_setconfig_callback, false)) {
-			drm_err(adev_to_drm(adev), "amdgpu: fail to register dmub aux callback");
+			drm_err(adev_to_drm(adev), "fail to register dmub aux callback");
 			goto error;
 		}
 
@@ -2107,7 +2107,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_FUSED_IO,
 			dmub_aux_fused_io_callback, false)) {
-			drm_err(adev_to_drm(adev), "amdgpu: fail to register dmub fused io callback");
+			drm_err(adev_to_drm(adev), "fail to register dmub fused io callback");
 			goto error;
 		}
 		/* Enable outbox notification only after IRQ handlers are registered and DMUB is alive.
@@ -2125,7 +2125,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	if (amdgpu_dm_initialize_drm_device(adev)) {
 		drm_err(adev_to_drm(adev),
-		"amdgpu: failed to initialize sw for display support.\n");
+		"failed to initialize sw for display support.\n");
 		goto error;
 	}
 
@@ -2140,14 +2140,14 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	if (drm_vblank_init(adev_to_drm(adev), adev->dm.display_indexes_num)) {
 		drm_err(adev_to_drm(adev),
-		"amdgpu: failed to initialize sw for display support.\n");
+		"failed to initialize sw for display support.\n");
 		goto error;
 	}
 
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 	amdgpu_dm_crtc_secure_display_create_contexts(adev);
 	if (!adev->dm.secure_display_ctx.crtc_ctx)
-		drm_err(adev_to_drm(adev), "amdgpu: failed to initialize secure display contexts.\n");
+		drm_err(adev_to_drm(adev), "failed to initialize secure display contexts.\n");
 
 	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(4, 0, 1))
 		adev->dm.secure_display_ctx.support_mul_roi = true;
@@ -2571,7 +2571,7 @@ static int dm_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->dm.cgs_device = amdgpu_cgs_create_device(adev);
 
 	if (!adev->dm.cgs_device) {
-		drm_err(adev_to_drm(adev), "amdgpu: failed to create cgs device.\n");
+		drm_err(adev_to_drm(adev), "failed to create cgs device.\n");
 		return -EINVAL;
 	}
 
@@ -4002,19 +4002,19 @@ static int register_hpd_handlers(struct amdgpu_device *adev)
 	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
 		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD,
 			dmub_hpd_callback, true)) {
-			drm_err(adev_to_drm(adev), "amdgpu: fail to register dmub hpd callback");
+			drm_err(adev_to_drm(adev), "fail to register dmub hpd callback");
 			return -EINVAL;
 		}
 
 		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD_IRQ,
 			dmub_hpd_callback, true)) {
-			drm_err(adev_to_drm(adev), "amdgpu: fail to register dmub hpd callback");
+			drm_err(adev_to_drm(adev), "fail to register dmub hpd callback");
 			return -EINVAL;
 		}
 
 		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD_SENSE_NOTIFY,
 			dmub_hpd_sense_callback, true)) {
-			drm_err(adev_to_drm(adev), "amdgpu: fail to register dmub hpd sense callback");
+			drm_err(adev_to_drm(adev), "fail to register dmub hpd sense callback");
 			return -EINVAL;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 25e8befbcc47..7187d5aedf0a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -107,7 +107,7 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 	if (payload.write && result >= 0) {
 		if (result) {
 			/*one byte indicating partially written bytes*/
-			drm_dbg_dp(adev_to_drm(adev), "amdgpu: AUX partially written\n");
+			drm_dbg_dp(adev_to_drm(adev), "AUX partially written\n");
 			result = payload.data[0];
 		} else if (!payload.reply[0])
 			/*I2C_ACK|AUX_ACK*/
@@ -133,11 +133,11 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 			break;
 		}
 
-		drm_dbg_dp(adev_to_drm(adev), "amdgpu: DP AUX transfer fail:%d\n", operation_result);
+		drm_dbg_dp(adev_to_drm(adev), "DP AUX transfer fail:%d\n", operation_result);
 	}
 
 	if (payload.reply[0])
-		drm_dbg_dp(adev_to_drm(adev), "amdgpu: AUX reply command not ACK: 0x%02x.",
+		drm_dbg_dp(adev_to_drm(adev), "AUX reply command not ACK: 0x%02x.",
 			payload.reply[0]);
 
 	return result;
-- 
2.43.0

