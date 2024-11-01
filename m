Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3DFE6B27C
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 13:50:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 379D610E9CC;
	Fri,  1 Nov 2024 13:50:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aFGKaPpK";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4805410E9CC
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 13:50:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNmulyiMLZsMXgCcNf40IYt2EYQBlVIlgZomYs1r3GRBgI/YMU/QS/CLbjX83tQq+JhPShqWqyx0CQm0G6EcgJdsBXM8adIc1C12tsT5JYuWvjc+opQQdMDm9OLc/0aUKvJD3k6EKhYtCjvuL1xkp2WXo3AbncMJu4tU8Vq54Fu8vUBF7TNOkObtRXDCqAMq8iGYPyXCCpg0xt75rIkJgdxkIvcnH30v9DUimxbIJS9qJzou8tvlcfZJJH1Zpef4zzeDsa7ikW5vWzMEB0CBQmx6BFei4JpK625VqEcQUqrogyu6zCI60nKh7Pu5JF3wcpmOt9mxdnFMuH1L6QjxEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeCO7MXZlFsxdKlK1RzQlx5s3GDdR2OVz14NwRcsEGM=;
 b=lWDwiRGx9og6l/2JNGo5ufOfLdgO8DFwxljeB0xmAP7k5H9jnHcx/5NkgtnfLnML1A6vXUgrKBNQi83Bb7og8bo08QCv2LuisTWiHvb4xoQjD8TN+6bEkjzMOxNsRDgh9xgJ/0707IVk8CMr+jDWttyuISoPBJJtneqy1JedWB3N7LXpe9kXUhJ3ZxizaIbb+pPxRw5aZvxt1RXckfHkOmuc8LrHh21a+ShSSXIUvJJ68hQnvoRIhix56lESlCtYJz7bIoEKxge2iddEWmBJuF6HWh96blOix8ecbBG1dNd05NitfR6UdRTDQ/sPl6zFFfVLn5G8TnSoUR1lhoxWcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeCO7MXZlFsxdKlK1RzQlx5s3GDdR2OVz14NwRcsEGM=;
 b=aFGKaPpKz5OY54xC7BvjXpsuAtYhB8hZQdJYCYSDfAIGJh7FqgzkTApekm9NX4oHVj6qKWJ15q1ODiYOYKlAxodaCd5vcRr5q6QprmXhqc3wGRvtkbewWR1Ekvg2e2WXu5mjujRljlcRVLraHv7FcV3GxYiKiV0TtTTHW4YROSA=
Received: from BN0PR02CA0020.namprd02.prod.outlook.com (2603:10b6:408:e4::25)
 by CH3PR12MB8329.namprd12.prod.outlook.com (2603:10b6:610:12e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.28; Fri, 1 Nov
 2024 13:50:23 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::c2) by BN0PR02CA0020.outlook.office365.com
 (2603:10b6:408:e4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.25 via Frontend
 Transport; Fri, 1 Nov 2024 13:50:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 13:50:23 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 08:50:20 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 13/17] drm/amd/display: Don't write DP_MSTM_CTRL after LT
Date: Fri, 1 Nov 2024 09:49:36 -0400
Message-ID: <20241101134940.1426653-14-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
References: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|CH3PR12MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: 86158e83-8c68-426b-e972-08dcfa7c2201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8kkWDu5MG1JzHtcvBg6b24Z3stFpSDqPA0mgxbNnV2mhir8ors9l0bU1yoZY?=
 =?us-ascii?Q?nl7vBx7LekVXguY8V77eGAr0+PBSmUe0AlOqTvxenwa6UDUy5bGX+iFLefxI?=
 =?us-ascii?Q?+IT+C7dbUKywMWi1EnPqyNVnfxICMHZ3TqLBhQJVnL4r7GIytVTY336M4NDM?=
 =?us-ascii?Q?48v/M9Kom41adkOvwR3wTV1aqZIt/k/Nt9Cq2Tyv8B3txTTGHRYHdLCVgMhT?=
 =?us-ascii?Q?Ama4GjRpmcJQUc9l7AP2greGne+knYoX9o2JdMI0GDZm35b+zSWz6kcTlHUK?=
 =?us-ascii?Q?nP1KWTqney5KlI/9YE0iPxakDcWIObYSWsxBoruHDhvT8DO2WFhENl8kRcT0?=
 =?us-ascii?Q?E0id8q5OHTA5DtZmqMlCEZyUQC1eVVsjzgDrcbDsgB9gpXnvSK5GlJk9Tm0h?=
 =?us-ascii?Q?AYcOzVul46ZeckTjkqXQvXXdzQ/ZMANfkCOnLg+Q7K1bxfezylogkKVSyF5b?=
 =?us-ascii?Q?KKMK/BjIF6uIzbnpakrtxnYNO2XwRIXW3PW0d1b3sXjlSvGe/gPzQq7EHiLD?=
 =?us-ascii?Q?CLkck/040NyO42wvKH/yiu59/8Uw+42+2pot5Ezlwh8k9/+nlAoeg2OR1Epn?=
 =?us-ascii?Q?8BNpVc9mSqeGZWq2wTVLylKjzKtJ86jHVrNMn51vZwSfx5qVh218r/dRJvJI?=
 =?us-ascii?Q?M3KzNnTd/UwOp6SSFFJKR3eOJ5iQucNC0F88q2aQ02kWD/syujzQGMW+hrl8?=
 =?us-ascii?Q?F5/8+3KL9MxhEaf3IDCOE26ZosHzJaADhrXQRhPTLcTG95qbthMDW02PrJlP?=
 =?us-ascii?Q?xQSL9ZfwbZ6Mte+LTYBu5PSTV5PoB6QdcCR+o4Z/oSPSQX+kLklfZwkjwxjZ?=
 =?us-ascii?Q?kRDqI/Tq5CNfqLmEtQTbZQIyvWmE/5xXXdBZPhG4qFFKp5OC2qhTUMKREdl4?=
 =?us-ascii?Q?9TkaH/ZgU+38FlRirTr1qF8kbBLzPLgqBeswbCvvaWvl1oE+pzAK+1Wofbwd?=
 =?us-ascii?Q?IerK02lOOum2qlfzUUcSiWxkpTiXEghHOf4myaJj22kJUeR07jdxvQkQcVyB?=
 =?us-ascii?Q?qQ6zfoqJaipTUomXyFTxBrg/GPmQIBfnLAjMFU/RTEjrbIFJozUTdze054YV?=
 =?us-ascii?Q?3g8MSBJkntrpAWLi7gCFfXPM2JvGBTCV7byqZQtCmVDwUpf9B4gKN/0MYRmm?=
 =?us-ascii?Q?ZFbPZce5XXyv6+aMmS6Yedq8jotRhQe7DeRIV5zDJTmJ97lylzp529YEoQCj?=
 =?us-ascii?Q?1YrmoBzKG17Z1+dYHjx+lF3rrveE+dwPu63JD3L6QSOdR+N3mKdlJEYR4J+k?=
 =?us-ascii?Q?RBBlie1MnETpd41HI9lm1TK/Klbly5Exvhey+FQ8t+YMkaiLnFv2QvpkVFcZ?=
 =?us-ascii?Q?HGdSm8GHayb5SeCC1YaSIVhEoGwRcrKG6ry41L7yS6Y2sJjaKF8JWaCB3c9D?=
 =?us-ascii?Q?StHytBACmsWlDOedK+VIbFIGNDgo0VD59ayvDsBHSNCstENtmg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 13:50:23.2582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86158e83-8c68-426b-e972-08dcfa7c2201
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8329
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

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
Observe after suspend/resme, we can't light up mst monitors under specific
mst hub. The reason is that driver still writes DPCD DP_MSTM_CTRL after LT.
It's forbidden even we write the same value for that dpcd register.

[How]
We already resume the mst branch device dpcd settings during
resume_mst_branch_status(). Leverage drm_dp_mst_topology_queue_probe() to
only probe the topology, not calling drm_dp_mst_topology_mgr_resume() which
will set DP_MSTM_CTRL as well.

Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2599a99509de..f3e8975cb2fa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3170,8 +3170,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 	struct dm_atomic_state *dm_state = to_dm_atomic_state(dm->atomic_obj.state);
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	struct dc_state *dc_state;
-	int i, r, j, ret;
-	bool need_hotplug = false;
+	int i, r, j;
 	struct dc_commit_streams_params commit_params = {};
 
 	if (dm->dc->caps.ips_support) {
@@ -3360,23 +3359,16 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 		    aconnector->mst_root)
 			continue;
 
-		ret = drm_dp_mst_topology_mgr_resume(&aconnector->mst_mgr, true);
-
-		if (ret < 0) {
-			dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
-					aconnector->dc_link);
-			need_hotplug = true;
-		}
+		drm_dp_mst_topology_queue_probe(&aconnector->mst_mgr);
 	}
 	drm_connector_list_iter_end(&iter);
 
-	if (need_hotplug)
-		drm_kms_helper_hotplug_event(ddev);
-
 	amdgpu_dm_irq_resume_late(adev);
 
 	amdgpu_dm_smu_write_watermarks_table(adev);
 
+	drm_kms_helper_hotplug_event(ddev);
+
 	return 0;
 }
 
-- 
2.34.1

