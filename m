Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF27C3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 22:58:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A30B10E857;
	Fri, 16 Aug 2024 22:58:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xj2PAzrB";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA8F310E857
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 22:58:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELeIAbIDAieD2BLLqTAFkctvAFtRJVtPsVEymQn4DeCFaaNqaBSBrJcvkIeNbq3/3+jyx9f5m77ljs3LmKEU+/3WErZSokf8m5+KBt3+pL5TdT6CtnyD3N8e3dBP2UfdqKHSANi/6SVms7Tu4L2tjUrMZv/qKlMgWp/Gx0P0vwpZuOEt4eWacPaPsLEPBWGVPEUe7S16d5OOwECDqkEGhe0QUVUzABF3mIZikodL5A+oBBJMqZV5CQws1hfGDkc8TZw0sb6rx2hQbGNghV0NOYQqcS4Ki9rVhC3eV/LQNasGY3f7bTlL6aXUEJq8aClad5W86xUridhFx6MooDc6fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55c1v1DljlIj34DhIftlPxyM7tQro7PGjoh2rZ9V66g=;
 b=jWzJmWK3JSMG2635yto9JA2caFCHc3d2bWsK2u8hhkiz6TVuvyAYV4soIysbZnEhlzdtemfVLjcGfHmGng9qm4VB7P4+RtfjSgZPxgM82CLF3KJEZg0686oO6B7tGrRrlly9967lMgqK4pgeLl2AHov76Obf8Fkf5LqjgGYluCEw6QKJM3U7VB437uUtkyu8SBZQhvuwa0QMY7B0cbkekBRydG68dKmbBoEQN/1s/uBMFACttFhbmq7p2rVeM53iia37UTyx9Msnf+Ct9ih+iaa60+TfeuBZrCE4DQiduoH7VjYAonEj7G8zSYMWXiLaLNdYktAJxbN+y0bdvZKQ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55c1v1DljlIj34DhIftlPxyM7tQro7PGjoh2rZ9V66g=;
 b=xj2PAzrBYAz3Th5naIukL6nh8SHQ2tV/EQnXH20sD5oqu8Dym5i+yiJdr94KcNBWAd60hIm8omtUcL+zP/K3Z+pgYQXeUvwd/OPrMxfqhz7wg2llLuirT8taLB24ps7BF1146qJNTRsTAamz1U+vgZGaYtsznYzBFf4RI4G+UZw=
Received: from PH7P220CA0160.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::18)
 by BL1PR12MB5994.namprd12.prod.outlook.com (2603:10b6:208:39a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 22:58:14 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::20) by PH7P220CA0160.outlook.office365.com
 (2603:10b6:510:33b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Fri, 16 Aug 2024 22:58:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 22:58:14 +0000
Received: from thonkpad.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 17:58:13 -0500
From: <sunpeng.li@amd.com>
To: <chiahsuan.chung@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <Harry.Wentland@amd.com>,
 <hamza.mahfooz@amd.com>, <roman.li@amd.com>, <aurabindo.pillai@amd.com>,
 <rodrigo.siqueira@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH 3/5] drm/amd/display: Go through dm for exit_ips_for_hw_access
Date: Fri, 16 Aug 2024 18:57:52 -0400
Message-ID: <20240816225754.156098-3-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240816225754.156098-1-sunpeng.li@amd.com>
References: <20240816225754.156098-1-sunpeng.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|BL1PR12MB5994:EE_
X-MS-Office365-Filtering-Correlation-Id: d228e83a-ce39-4b23-574c-08dcbe46e8eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZeaUMWPXVmWRevcHyf5EFq7X8fMoToeTkSG+ga6dzZadBvQz8eO+kyLpCzXU?=
 =?us-ascii?Q?TnREd+sY2QskBQuhjJF2SZXuoZGKHmiJMMYm2MhJa4Vv5EP2sZ/WILVo18wM?=
 =?us-ascii?Q?mzz7zcGtqrVjB+UYG9Rirx03y8ReSedYwmQtP+xmTDuR5Y2mzyigyVjooaF0?=
 =?us-ascii?Q?dE9N+945EiHa/kL6HB0Fp4eo+a0v2D+JOoboHAvyhzk+hDqZLPpTw4yAQgLn?=
 =?us-ascii?Q?RaLwLnec/z0ENtXTFATYbZRAmrKSs7Ax+SRn9A7zgi52bqRmLRV7vmo0nXwb?=
 =?us-ascii?Q?Rr6Q1dNUDvTJyynJmge0r3A4HQOurPyj/Pf1Mf+hVycvSHeWp1LkiJqJL6Qp?=
 =?us-ascii?Q?FvaK6MLBo0qROETp1vOuulHOvbhuM/XiEzjBr/0HD7/0/UNnzx/sQaa7us6/?=
 =?us-ascii?Q?MWn+cHnG/ObPlIBc+825OJFaYq7LhqA2IA5q1hvs3D/fJgDAt4VkGVVY5pdM?=
 =?us-ascii?Q?S9mUOngWfTuZYXAb1p4bqjgOr22RQv9ncm6no0l92DGPGmu3FLqTga+aIRv2?=
 =?us-ascii?Q?C9doRJluD6Ta6XocESxyr09xt7KKcZRg5PoBnMzx+84nQEXLt37WrBfEraKP?=
 =?us-ascii?Q?0+KFie+pbeCs6lPDEjbFf3w7T+6gib6bvkqClCyGwVCUyJJdYC35c/IszLjT?=
 =?us-ascii?Q?j5Vq2RHxzIrBZR+tP5ha6feMvw4p6y2ReZIlcGmQsWdJn7KynHI5OckO8sj1?=
 =?us-ascii?Q?aXgovJFrA0haD50C4QgHDRMv6vRc/bOjjEEpKY1bDXBu/fFCNZ7ceQANDB3S?=
 =?us-ascii?Q?OTw5zkO/qTI3qKqR287wfiKHuWpy/crYlVddhMxJHSzvXfxztmi0wM9BpIAb?=
 =?us-ascii?Q?OGQPHe6LwomKA1z7ds3t/aNkNCwXmYdLnF2nc3TDRDAwHGXJNgNnFT5lCQod?=
 =?us-ascii?Q?MAeUDaU9fcIhmh84/Ik+dygFkjCwQLmdXhHnY8YXyeL3Xx8hoZg+gd9igATe?=
 =?us-ascii?Q?k7EyB2t/2EOSbEZ23s0ZIsgoDoWvaP7awu5O7sIWVRWztFm+moHFtz1jzpSn?=
 =?us-ascii?Q?R+OU92qQD/vg/YG1RMF0TB1I1v33js1zpIkiSnHHPC6SThj171Hxt/4yed4Y?=
 =?us-ascii?Q?k7KuVxdD/fMFKsqeH9+cDHT4kD+7Mfig9on3O5we/9RJWF6RC2z6/Xd3q5ya?=
 =?us-ascii?Q?r6othqrZqQ1o0ntRoBD3SC6866N5yvA54LnKq2uxfOWXjvU+oIk18czj3fdg?=
 =?us-ascii?Q?UU/2kyJKfyn4TRqFrWD0sD6VfsOcoW3tNkio+FB1N/TJ7Q8JiTR2FXQXdD9g?=
 =?us-ascii?Q?GixHySAtkGR1hhfi0X9IowNN6Rm9aPk9m/g3bIhGjx/sGcpIm4gLAvBmBGrI?=
 =?us-ascii?Q?QYp1MRFFdBreEK7YXRdMZGbDOXwiJocwPhfN4BLeaXIFwZN8sziFACaxdgD7?=
 =?us-ascii?Q?lb+7r5dEvPAdA9c5RzNxPmFY3NogkGUIlNPqktOTXekzNFy7HLkxkv11SNNU?=
 =?us-ascii?Q?Hk0+7bSmvZc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 22:58:14.3243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d228e83a-ce39-4b23-574c-08dcbe46e8eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5994
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

From: Leo Li <sunpeng.li@amd.com>

[Why]

dc_exit_ips_for_hw_access() is the same as
dc_allow_idle_optimizations(), but with a check on whether IPS is
supported by the ASIC.

[How]

Let's also pipe it through the dm function introduced by the previous
change.

No functional changes are intended.

Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 31 ++++++++++++-------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2efa9f6e23015..c99cff3650f14 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3092,7 +3092,7 @@ static int dm_resume(void *handle)
 	struct dc_commit_streams_params commit_params = {};
 
 	if (dm->dc->caps.ips_support) {
-		dc_dmub_srv_apply_idle_power_optimizations(dm->dc, false);
+		dm_allow_idle_optimizations(dm->dc, false);
 	}
 
 	if (amdgpu_in_reset(adev)) {
@@ -3141,7 +3141,8 @@ static int dm_resume(void *handle)
 
 		commit_params.streams = dc_state->streams;
 		commit_params.stream_count = dc_state->stream_count;
-		dc_exit_ips_for_hw_access(dm->dc);
+		if (dm->dc->caps.ips_support)
+			dm_allow_idle_optimizations(dm->dc, false);
 		WARN_ON(!dc_commit_streams(dm->dc, &commit_params));
 
 		dm_gpureset_commit_state(dm->cached_dc_state, dm);
@@ -3214,7 +3215,8 @@ static int dm_resume(void *handle)
 			emulated_link_detect(aconnector->dc_link);
 		} else {
 			mutex_lock(&dm->dc_lock);
-			dc_exit_ips_for_hw_access(dm->dc);
+			if (dm->dc->caps.ips_support)
+				dm_allow_idle_optimizations(dm->dc, false);
 			dc_link_detect(aconnector->dc_link, DETECT_REASON_RESUMEFROMS3S4);
 			mutex_unlock(&dm->dc_lock);
 		}
@@ -3589,7 +3591,8 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 			drm_kms_helper_connector_hotplug_event(connector);
 	} else {
 		mutex_lock(&adev->dm.dc_lock);
-		dc_exit_ips_for_hw_access(dc);
+		if (dc->caps.ips_support)
+			dm_allow_idle_optimizations(dc, false);
 		ret = dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
 		mutex_unlock(&adev->dm.dc_lock);
 		if (ret) {
@@ -3739,7 +3742,8 @@ static void handle_hpd_rx_irq(void *param)
 			bool ret = false;
 
 			mutex_lock(&adev->dm.dc_lock);
-			dc_exit_ips_for_hw_access(dc);
+			if (dc->caps.ips_support)
+				dm_allow_idle_optimizations(dc, false);
 			ret = dc_link_detect(dc_link, DETECT_REASON_HPDRX);
 			mutex_unlock(&adev->dm.dc_lock);
 
@@ -4946,7 +4950,8 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 			bool ret = false;
 
 			mutex_lock(&dm->dc_lock);
-			dc_exit_ips_for_hw_access(dm->dc);
+			if (dm->dc->caps.ips_support)
+				dm_allow_idle_optimizations(dm->dc, false);
 			ret = dc_link_detect(link, DETECT_REASON_BOOT);
 			mutex_unlock(&dm->dc_lock);
 
@@ -9349,7 +9354,8 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 
 			memset(&position, 0, sizeof(position));
 			mutex_lock(&dm->dc_lock);
-			dc_exit_ips_for_hw_access(dm->dc);
+			if (dm->dc->caps.ips_support)
+				dm_allow_idle_optimizations(dm->dc, false);
 			dc_stream_program_cursor_position(dm_old_crtc_state->stream, &position);
 			mutex_unlock(&dm->dc_lock);
 		}
@@ -9424,7 +9430,8 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 
 	dm_enable_per_frame_crtc_master_sync(dc_state);
 	mutex_lock(&dm->dc_lock);
-	dc_exit_ips_for_hw_access(dm->dc);
+	if (dm->dc->caps.ips_support)
+		dm_allow_idle_optimizations(dm->dc, false);
 	WARN_ON(!dc_commit_streams(dm->dc, &params));
 
 	/* Allow idle optimization when vblank count is 0 for display off */
@@ -9793,7 +9800,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		     sizeof(*dummy_updates), dm_plane_layer_index_cmp, NULL);
 
 		mutex_lock(&dm->dc_lock);
-		dc_exit_ips_for_hw_access(dm->dc);
+		if (dm->dc->caps.ips_support)
+			dm_allow_idle_optimizations(dm->dc, false);
 		dc_update_planes_and_stream(dm->dc,
 					    dummy_updates,
 					    status->plane_count,
@@ -12159,8 +12167,9 @@ void amdgpu_dm_trigger_timing_sync(struct drm_device *dev)
 
 static inline void amdgpu_dm_exit_ips_for_hw_access(struct dc *dc)
 {
-	if (dc->ctx->dmub_srv && !dc->ctx->dmub_srv->idle_exit_counter)
-		dc_exit_ips_for_hw_access(dc);
+	if (dc->ctx->dmub_srv && dc->caps.ips_support &&
+	    !dc->ctx->dmub_srv->idle_exit_counter)
+		dm_allow_idle_optimizations(dc, false);
 }
 
 void dm_write_reg_func(const struct dc_context *ctx, uint32_t address,
-- 
2.46.0

