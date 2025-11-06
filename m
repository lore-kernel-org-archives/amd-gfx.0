Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C484ECCFA03
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 09:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E13010E86E;
	Thu,  6 Nov 2025 09:55:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LkHDgS9m";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011005.outbound.protection.outlook.com
 [40.93.194.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84BC310E866
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 09:55:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yd8MYbqvUSKmu4qnMe6P/p0hCC0k53+lfARpntGi0tLksget66lkUOMi1AtDTupv+hn37K95tdFbzoQiezdN38QviOOWJPo6537DBPbQcRU0B0OkvEXoNYwQbcDhKVGz7Sk5pXFGByR4ZWdMk8ZvTB1gCdn9h21uTdIIXM1d4HY+li81yzNhvBvGv6KnTR2HPyGQnch75jJhGJpNEVQo7VjeYW3RHt92UddZm+g4Q50babJSsor/YG/724ALW7zEB0PztbwNBtsTZommQJjkncODREdTvWAgjY+aGtm9AjJRFvfB7WZBpg5jR9/kN63+oDR93knqKpow+pPj9oDcqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfAHUyYTwArzzNK8DO19s9DsgzQrjraFD+3nf7vvW4Y=;
 b=ZpAoqDo6HrEX3aDQARDmDEo7iEzmH6ZTapOG5IM7VTTukxEEz+r5TOPLnVu0abofpoOfOeV8SZ0XFdUh/jkzSHM599IfeoKBhT1ni3LqEPWuVIuB9n2+ps6FxYKDIU0QPNl4Alv2pDKhNXOTbd5TivLjrXuIvEOKZDOuOVZbywxbf7SpY/ojf47xasneEO9ZROB95GEfAOxeLUxrv03vEc/4E2PqMDIfqCWcM1rfs2qdT3ytxj8DRjilFmsPlictlk3G1gbEuGwRz0acb4Lz/eKH9dP2RbklApG4EYbo22Rza80ViMWwJtS6w4jbWPUEnoE0JXM7U3FX5kFb7dQeeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfAHUyYTwArzzNK8DO19s9DsgzQrjraFD+3nf7vvW4Y=;
 b=LkHDgS9mBufKnu/cG6r61OCvWxNIOQ3C9rrL/VKhGBPW3HjQnoMXMtsL73JGCuZEwbhym52OU/L2z9FArDFBox3QcJlYCqCV1qMYwOF1NpBbDj0nq2B1esHb64qu1TDZskYqmGVkFLK6Q13M2k/ruFQB8kBNGj0TnHn/rguppTc=
Received: from DM6PR07CA0043.namprd07.prod.outlook.com (2603:10b6:5:74::20) by
 PH0PR12MB999113.namprd12.prod.outlook.com (2603:10b6:510:38f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 09:55:15 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:74:cafe::c) by DM6PR07CA0043.outlook.office365.com
 (2603:10b6:5:74::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 09:55:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 6 Nov 2025 09:55:14 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 01:55:04 -0800
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 6 Nov 2025 01:55:03 -0800
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Aurabindo Pillai <aurabindo.pillai@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, <chiahsuan.chung@amd.com>
Subject: [PATCH v2] drm/amd/display: Enable mst when it's detected but yet to
 be initialized
Date: Thu, 6 Nov 2025 17:54:56 +0800
Message-ID: <20251106095507.490618-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|PH0PR12MB999113:EE_
X-MS-Office365-Filtering-Correlation-Id: 6befb218-9614-4da5-ecab-08de1d1a956d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pJvzkHSg5N/2ia2HnK0D2RKMYrmlYIOxjEgYQtq8roIFEGvva5WWJkpk9JpJ?=
 =?us-ascii?Q?S0FFtwe6notBSqHIeUkXbEQ0cQO7z1MRrCcIBLYplRih1UMuoYzwiVPI8mwD?=
 =?us-ascii?Q?foGTsy5nebtuRM7/qIH4r3+7Y01P9i51mnLEwG8o4NrglOQcmrPuPyadLyM9?=
 =?us-ascii?Q?RkcOm0EqlTC8Pe0ROF3RH+ycULb1418JqsMTc46y2MnjgaXGXKVeuA3G/cQI?=
 =?us-ascii?Q?uTOqEyXweM6ZYu3re70EnkC/ld8NbzHhjRwVVHsIUkvd7WTsmnsZzlbQXsdm?=
 =?us-ascii?Q?dVvQ0Wm0yhDktZ4y5FlyciWq6bagUqMbQmBPIsaV+HKYILSXHB0FfK4eY+S9?=
 =?us-ascii?Q?CsjCHFGpGo8X5KPq9epPJj/wod4MUrgdhFqDAL3uupd+XX6apSrw/n5u3D/8?=
 =?us-ascii?Q?aux9cmzTvu43p9Wx8DKdbn5k5J0RlJfl5Hiucl6cjZGp8j5Ooz8Z+rugJDSe?=
 =?us-ascii?Q?jzqZ4LttPDYL7QTA1og9/bZ6ABGLSz4kz27PWvXW3PeTjtZ39KjFjQOMe/Je?=
 =?us-ascii?Q?0EEKeeXsyeAxm5cPmIQKsqpUb2owRqYtmtsgzSN5hsfXLNTmICp22ppJHs/G?=
 =?us-ascii?Q?aIolbkhjKC6QwR7jk3Tamdf8WP1T8vduBEU5o48t7JFRG8VlYU9Z9/cW+F84?=
 =?us-ascii?Q?PNjwrtE1kNepkMCtqECib81QlSVBPXXyLc3bHylSV/PxRxrAG61E1dfsdx0U?=
 =?us-ascii?Q?1Lo2NavclkuzeD3q0qINmHBWzY4LbMSj54Zpq03aTEkLwz7yTuTyKlCsqyes?=
 =?us-ascii?Q?8hB5X2IbAfc0CJqpu05SK1gZO5t7xTrOwvuu6zh5MpM+GMwdgQwwNbiI/q18?=
 =?us-ascii?Q?tz43WmBz8iFon3fqSu3DcLzHYgbrfwD2biT1AaGZ/xA/wmVcxMSgEDmRE3vJ?=
 =?us-ascii?Q?y4oFLc9G0oc0svBSgsPWOUHNauE+DedP2m2JtoN/xr7AZyQfzez9YDJyJqOJ?=
 =?us-ascii?Q?3D8c3vzUhVLn+EBjxpdZbgPohWsX74hvD+m0W1iY7mm2btrsztNAGmPRbDL9?=
 =?us-ascii?Q?QiRd3hHk3RDOzvdMVmFSRiJ5acJlhx9c/RVPUQqi0qyAJpbdeMh7psXglHrL?=
 =?us-ascii?Q?cke9ZWUd3xzaZOjGPgY+QXWwvWxnKejiKRZE/Nf8WExlNshGsh7viB+NXGsh?=
 =?us-ascii?Q?z/IfCUooCYzNn7YkrWw4samoFlqkxIkxArRJLMQgAzELvfjxHhsmiqcwjvko?=
 =?us-ascii?Q?0OD/ef84oI4Sdwz68e5jiVKUQjS3dbAbRspEez5sCsAlWxw6WmytAI20iDjL?=
 =?us-ascii?Q?Umj8K9fDX1fFgikEal2ugW40gbUBHdKIqgFTCyqARB81M0a/qLl6nOjYzQui?=
 =?us-ascii?Q?yf2oS1XVQE59tDH86yQwJjvYZDP7O4sZFaPv94P7drMdZUoz9s9Ir7EI8eO2?=
 =?us-ascii?Q?pYYrt3lBOCQWNdrnciPouymnjF1KM/HNOYf2eIj8xfirFb17RbFHSr4VvaPO?=
 =?us-ascii?Q?kz4cGXR/jTLCIR+cT6kWkU1x1AxVhKJ88Ui8KDBYG35iozJpn9wQPNnxXz+z?=
 =?us-ascii?Q?ceyRrISR5dXkC5OyuBRXmgtKqh06EDJppGAbYYgfVIH7+RDs5n3MOtZ+xQfW?=
 =?us-ascii?Q?/GLY8cJWSwesSzUwgrw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 09:55:14.5753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6befb218-9614-4da5-ecab-08de1d1a956d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999113
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
drm_dp_mst_topology_queue_probe() is used under the assumption that
mst is already initialized. If we connect system with SST first
then switch to the mst branch during suspend, we will fail probing
topology by calling the wrong API since the mst manager is yet to
be initialized.

[How]
At dm_resume(), once it's detected as mst branc connected, check if
the mst is initialized already. If not, call
dm_helpers_dp_mst_start_top_mgr() instead to initialize mst

V2: Adjust the commit msg a bit

Fixes: bc068194f548 ("drm/amd/display: Don't write DP_MSTM_CTRL after LT")
Cc: Fangzhi Zuo <jerry.zuo@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 35566ac9232e..ba11421332da 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3624,6 +3624,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 	/* Do mst topology probing after resuming cached state*/
 	drm_connector_list_iter_begin(ddev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
+		bool init = false;
 
 		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
 			continue;
@@ -3633,7 +3634,14 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 		    aconnector->mst_root)
 			continue;
 
-		drm_dp_mst_topology_queue_probe(&aconnector->mst_mgr);
+		scoped_guard(mutex, &aconnector->mst_mgr.lock) {
+			init = !aconnector->mst_mgr.mst_primary;
+		}
+		if (init)
+			dm_helpers_dp_mst_start_top_mgr(aconnector->dc_link->ctx,
+				aconnector->dc_link, false);
+		else
+			drm_dp_mst_topology_queue_probe(&aconnector->mst_mgr);
 	}
 	drm_connector_list_iter_end(&iter);
 
-- 
2.43.0

