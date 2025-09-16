Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9EACAC59B
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 19:12:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D4E610E3D0;
	Tue, 16 Sep 2025 19:12:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x+bq1sS5";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011023.outbound.protection.outlook.com [52.101.57.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C081D10E3D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 19:12:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkM6w5icQbADM7B9DX4wEJX9g9ldLTeP5sV3vfE4QgS6+tGZ9ibzV3Uxycdb+MsyyX3cHqXA6uMjwneK3d8CwJLaArkgKgr93cipubovxpxiTFSs5kuHKXwCZS2jZa6tCuAO1ZlmakyDB9p9fY6SU0Zmi3wM3LMRr2MPViveZreIfPsOY5eSHHMsIxWqx8ym6XDPCk/hsAHX49WhlX++4j4TfOQpz133NHhrA9RyZoyOKKVX1kXpX71oueLC1opA8XTeD44JrdZWeRvcuZinXhQ0+YBMqsLIkDPrxHqL5vE8A/TNxw+2G9zFo+/g19I8gaf+wSsdhpg+JqGzeZ7fBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=in2cN2TcFdJXCVeolHCH0h4Zw7EHsmI7d5XkvcTwC4k=;
 b=GGYKh8jGVrt6r6pZGMMjSbalihTPOhigkcRaP53oO4iJpmvT2ghtkZYKjfZSJQcFK6pNPOwDBDfdZ5nYNuOFJDv67OVreVrW0Ado0fkD1m0V9tkAeHbx4Gp4AJuWBuiqIBnSF00aIIauak7OccdfezhJM6f+Y1gIbT0yc+9uuR/49RhN43W57zgOdSleghTKp7nPAGCY39Jl2YlBAjJNM66mTu5R8MD/Xx/ij8e+QuVkW9/wq+CHNlDJkTVIcoU82J42ny406rA87HH+40HStLT7p3bbR5p+1RcHISxxXN9dSqdsNAeBvPbfknCdSxltHeK7x+EDGIOppuDvMX0DWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=in2cN2TcFdJXCVeolHCH0h4Zw7EHsmI7d5XkvcTwC4k=;
 b=x+bq1sS5CxYDYgQkqamNFN7DghkDHRXljP5Dfm1bHNGCDXGHptoHNbia287WGTE7ICqvCbv4HIFW4BMZywWEmA6Di8q+s5wnoKnYUtRRsNXqzNhdhgu8JHfLStcLb76xoI1hWJVn+hUdQKN0PJj9PHYQJ9sWKZu5OQDe0iNPoW0=
Received: from DS7PR03CA0343.namprd03.prod.outlook.com (2603:10b6:8:55::17) by
 LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 19:12:08 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::8e) by DS7PR03CA0343.outlook.office365.com
 (2603:10b6:8:55::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Tue,
 16 Sep 2025 19:12:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 19:12:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:07 -0700
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 12:12:07 -0700
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <Dillon.Varone@amd.com>
Subject: [PATCH 02/20] drm/amd/display: Add missing post flip calls
Date: Tue, 16 Sep 2025 15:09:22 -0400
Message-ID: <20250916191142.3504643-3-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
References: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d50c92-6029-4685-11a8-08ddf554ee61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ug8aElYQGxEsADMooDQ0vxhbDucZmg26T/M8/K05eGwq4/zdtIQJEYWjskNs?=
 =?us-ascii?Q?t6uYQF3QT99Cncr5tglDNw41wWYbjxn2ncMD3oRPR9+kXgTgd7E5XIs6UyDc?=
 =?us-ascii?Q?JV35/VCcq4ImAvaTNrnSVdZA6ok+1Cf6KE2zFpN0TifTsZ4DrVukju67bfK6?=
 =?us-ascii?Q?OJk+c4I4ON9bZNHe6g1+b0cHoM3RDVu3uqlBRxnMbqsjjpe+7t9CPMSQtWZb?=
 =?us-ascii?Q?P/rwOwI9vVj/NCRNVDfxf/m+cOoRUqEe6lU9qsffhEbjJOeESY9dkIstpjtW?=
 =?us-ascii?Q?NwlM99D2dG1sOAM83ydgC6nSDxIrOot/g+RsmtT5eOJ/FC0U2JBnzQdJ/uI+?=
 =?us-ascii?Q?h1E7UvzMb9Gub6LlYXo61IICymQzZd2+WrokzZ21d5JuLmDJ/n+ielCJcR5y?=
 =?us-ascii?Q?AWsLIgaRuPIcQ3q8jQAS9Sjn+uuyrEIx4S6n4fr++K7xxt5P1qHbFjl81DfD?=
 =?us-ascii?Q?ckxKlhEyc8bIG9bi0+4yHJFKuhldd/x1FC4pwzyDyPJGKX79HmoKCpsI2Zqq?=
 =?us-ascii?Q?mVPkNXjffyOFljVo7kal2IJiKJEp/4DtspcORT7QoKR5v1EpQyHhLVyI+WwZ?=
 =?us-ascii?Q?zL73k7WR1E5lb7bAiGyRcpXk6UfyE5ID8cOnueQAN28IgIWZNGd4PbPz8Erd?=
 =?us-ascii?Q?aUdF79pxcbkjJa8PbW1T04rz96tlwC57R4WbuyfBUZUn2TqGwFjQWSD5DsK+?=
 =?us-ascii?Q?R18sS/yFJIOUE4XR6060GYK4E8wjKvKkZkUJc0IL7F55RJmcs0f7YOGWTOut?=
 =?us-ascii?Q?Qy03/VcFhiNmOtS/bUVtQTUGjHVLqVeuFCge1caFw8BhKYV98ysC2tnK4nlE?=
 =?us-ascii?Q?moj69XzMfBdogJb64eCoeIdx9KVtLaFCgnh/YwJdafkySXpUXreHMzIwRQ+F?=
 =?us-ascii?Q?uyIYAY78E/CeBp9fZhHun7mhPzVfpb7yFvh8wmK5Q8Q8OwMQk8Bo8bOIAiE6?=
 =?us-ascii?Q?AeBCUO4Ym7CEaIFCDKKh+eEsZecSbqs7JRauU6+mgaVBX2YQZtxzHSWd0B9v?=
 =?us-ascii?Q?3k5SBTh3GpxWPVt8Vnb/CsSQRutPQlJQRBVbjlHuYa0XdEwhm500vmPi7KQV?=
 =?us-ascii?Q?lhMc+LH/RQIPI7DX5ow9m9OEoVEUBtCAVRd/4yuZrQERzrUySf//ASdf4PuA?=
 =?us-ascii?Q?Kc60eeAnHZhcKjNQ9VCFQYmW2J9SBb2dXpSxCFyyQs+/C2uv5/pRXdxPIaMY?=
 =?us-ascii?Q?59O/YSbHfDYUmu1N6c6qRzZBg/4HNm5Zp7/Tg+t7KmRi0qc+q5pwWH28jyq8?=
 =?us-ascii?Q?l5CnLNAwDXFu3VYvYBtvdcfmyQaUzVnSN/XI7nCO9C0r2CGh0qEa6C933j0M?=
 =?us-ascii?Q?wDoagyLRvntJv1sxQXH8pWuB4ZBmm+XkeONh9Tna5zPCvQrUOdAlabEyrmxe?=
 =?us-ascii?Q?4urBenoF3EHn5N/tN5vS5aPI6soMm3JyWiMOerNog2r6wqTKVA+J7SdO+Ts5?=
 =?us-ascii?Q?Yk6BRS8wuZBN9s43osmeZb8/wyOzEmqWgxXyl3Fgncdr69ivbarz9lBySEiH?=
 =?us-ascii?Q?VfMwFSxCqopbqvzDXsusT69uVVJ2mJ4kuo5u?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 19:12:08.1076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d50c92-6029-4685-11a8-08ddf554ee61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
dc_post_update_surfaces_to_stream needs to be called after a full update
completes in order to optimize clocks and watermarks for power. Add
missing calls before idle entry is requested to ensure optimal power.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      | 3 +--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 8 ++++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9dd2d1ed674d..b7b933a33316 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -417,8 +417,7 @@ static inline bool update_planes_and_stream_adapter(struct dc *dc,
 	/*
 	 * Previous frame finished and HW is ready for optimization.
 	 */
-	if (update_type == UPDATE_TYPE_FAST)
-		dc_post_update_surfaces_to_stream(dc);
+	dc_post_update_surfaces_to_stream(dc);
 
 	return dc_update_planes_and_stream(dc,
 					   array_of_surface_update,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 466dccb355d7..1ec9d03ad747 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -218,8 +218,10 @@ static void amdgpu_dm_idle_worker(struct work_struct *work)
 			break;
 		}
 
-		if (idle_work->enable)
+		if (idle_work->enable) {
+			dc_post_update_surfaces_to_stream(idle_work->dm->dc);
 			dc_allow_idle_optimizations(idle_work->dm->dc, true);
+		}
 		mutex_unlock(&idle_work->dm->dc_lock);
 	}
 	idle_work->dm->idle_workqueue->running = false;
@@ -273,8 +275,10 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 			vblank_work->acrtc->dm_irq_params.allow_sr_entry);
 	}
 
-	if (dm->active_vblank_irq_count == 0)
+	if (dm->active_vblank_irq_count == 0) {
+		dc_post_update_surfaces_to_stream(dm->dc);
 		dc_allow_idle_optimizations(dm->dc, true);
+	}
 
 	mutex_unlock(&dm->dc_lock);
 
-- 
2.43.0

