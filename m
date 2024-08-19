Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29692C52D7C
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 19:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD53910E343;
	Mon, 19 Aug 2024 19:23:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OHLWSITb";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55BA810E343
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 19:23:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TdgknkHUr7fw3yI3urWUl6jiyF2nTbHnvclidGWgoIIs6tQOjI+NiTRCG9f9YQBxwt+UOYqSPOK+7FRgCJMuu0sma4S7/klJtsv4+exx5DAg6K3+hdi5XpEIjTXJYnIoyOPIb8R564ibcwq2KtAkmfQoy/cHJXmpN1u9n21wSbXEOKiVHkxI/joKJ6Sud04BFHVV5NKZrM/eG1LjPh7d5kkwSi7os0vnYmoCaXPgOpclldsGDfvviXjhHvfr14XhiekVAoNTUGAA7YB4IteeRdfD8eZpDusHOKDc1HnZ+vfIiQ+8LZ5ectNs73zvlqfotkAxTaiX60qpVngUAaaHOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55c1v1DljlIj34DhIftlPxyM7tQro7PGjoh2rZ9V66g=;
 b=C+XJmb5X+VyPlASv4DwAzEJHj4NJp+nslyxnJSOtH8OcwIPpD4Ypk0P2QRxkMq/7HQOpFB5n3H9FO2DRv8ng6Q2ecpIlWBI15No1k49qyRai0/3wTmRVUrkCgX2F3YtBGhzgdAUgVPhLaMJf90X4Zi7vyVvivkgiN2Ddd726eDECMuoq26WZrfbspnPlP+p+Qcqg6sGaA+GVYXnRqlzCVk/vEA0f2HHQmkdSLAHCGkYGApQkS6oyv9qVtq0TUIH4XGRv/2YcEoiqpnyAtAznLs4Y5E0+qGE/8ZlUaBpfki35+OjLa/PW/UMRfgXur38HlG23+Jy/VlNxbo+C/i7FQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55c1v1DljlIj34DhIftlPxyM7tQro7PGjoh2rZ9V66g=;
 b=OHLWSITbANdwTX8EUlhXuHNC3STyqTWDrrZO7VdmlDwb23dTvLHJUwXf2ZMkERryzx98yIuGYWVBnGsNCklrdCEdnDkDT5R9NiIyrktY8oCZMj3kJ5m7jB4QYs2PiVfQFSzrek41b91AQOytTmGEQ8RXcD8FTm/i++5i+0POvYw=
Received: from MW4PR03CA0167.namprd03.prod.outlook.com (2603:10b6:303:8d::22)
 by DM4PR12MB6568.namprd12.prod.outlook.com (2603:10b6:8:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 19:23:09 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::17) by MW4PR03CA0167.outlook.office365.com
 (2603:10b6:303:8d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Mon, 19 Aug 2024 19:23:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 19:23:08 +0000
Received: from thonkpad.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 Aug
 2024 14:23:02 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <chiahsuan.chung@amd.com>,
 <hamza.mahfooz@amd.com>, <roman.li@amd.com>, <aurabindo.pillai@amd.com>,
 <rodrigo.siqueira@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH v2 3/5] drm/amd/display: Go through dm for
 exit_ips_for_hw_access
Date: Mon, 19 Aug 2024 15:22:15 -0400
Message-ID: <20240819192217.18799-3-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240819192217.18799-1-sunpeng.li@amd.com>
References: <20240819192217.18799-1-sunpeng.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|DM4PR12MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d667e2e-5272-46f6-b5b7-08dcc0845bad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lb063P4BdqWTbHj9yK4FtscSbfMSDd4sdYRibC2I90fM0s/0YstfY++pOhU3?=
 =?us-ascii?Q?a46wp/A8ZO80lf9rYPs4HpXjMyYYS7jsqjBWxTfuLQipMujrn4bw6UZ+kOx9?=
 =?us-ascii?Q?TkX+Gd+TdGQ8uTtLK71QmLyduc+rlJ8KhRqZyDCw/UU/ZHDNRgzzFmf1awJ7?=
 =?us-ascii?Q?ml0ANoyKkliNgOYjTb+lt3XJM3VBC1yWhszVuNQ1k6vopWj+1EgwOS4wQFrk?=
 =?us-ascii?Q?2RQkfTDExyYM4NxbQr2EAuAzRGTfnoKPreAYsD3gaZoQRm4TiI3dxvn82YVY?=
 =?us-ascii?Q?eJIDgjLlKgWEfBON7Ha4RjqYYS2qzDKjV2UmoO4lBFbZx2oL0/nfQgKnwWLb?=
 =?us-ascii?Q?j7lRIkatreJXTf0PzXdU9gbX+fVFp+l2bzdhOuPTXsCrrB0aboYoEtpYrYvR?=
 =?us-ascii?Q?6ORZQbBy9LhUzzgvtiG3Ef0EhIYecK9cqMMdfWcTCUGrks6FmtxmNwtzjFNA?=
 =?us-ascii?Q?4RDeYe88Rlq8WFDfFvFq7ePwTxMZ6S9c+u9IN+hN0aAE7dDRJmp6PvyY+Y9e?=
 =?us-ascii?Q?YqK4NaS8BfWRry9wSKugQp1qJK6GEWOLUihVPTfTKcDlUlobmNYqILy+Qiij?=
 =?us-ascii?Q?1s5Myh3JZxfNRc6nZ0pzcS6KFWbdX7EYHkIYra0rWk7KvBdHkz6pMob5+ci3?=
 =?us-ascii?Q?kLkbv1nVPp4Aj5Vj1+tVAqPZ064tzMCHA1jutaq3KOf782b0kHl7UZGL7TtY?=
 =?us-ascii?Q?P330BcKahOj1p8uwRRjPzTEkdDvOpZlIzZsBfEIQkrnTrAtfdM+E9oEvPX0t?=
 =?us-ascii?Q?3UOFayB1eXdu9ISMgu1tj3V8ZO5IdLZY6nUEn709rEuuPer0yMH/ACq6JSA2?=
 =?us-ascii?Q?3wNfgbbP3iYz6ffyb/ptrAwjnQ1AFW1aNuYGfkbCO2ynP1c/tx/A96CVfdHX?=
 =?us-ascii?Q?1lle5E7smYz26DZ9Mh/tVzlPFKvNGX6J/+BriboNNrdOsrWsezPe3DYnGM8s?=
 =?us-ascii?Q?2n9FDw8IPWCLizwPylk7q3B1nMIqhi/Dv/M1EKaI1qwmivIC5blK8JtjwCFX?=
 =?us-ascii?Q?jcnZRpOoKmMO21H3zTbRx7kBFBI0pASVoZOwyawDI8VeBs2JDBAzNIrxi9FB?=
 =?us-ascii?Q?d7TCqn8lD2jubCwZ9yJnILRwusoXWpwxqyc2EIroOp9sH9dTZChbDCzknFu4?=
 =?us-ascii?Q?PcQgRKE8ZNmZtOfbz7wRKHOAkPCuS9ayltZysen7y4sEENfZtxgrnATiZP26?=
 =?us-ascii?Q?KW8OMs1RkCrh9eOsjWDCcMC40aaBkIShbcpYl5KQ+RbvGXPQngCM1U8z1AQn?=
 =?us-ascii?Q?i33hc3E9PHmQTdNH90o/hBe5rSQmWEAPsZM7ziIAfCzH0GFgj/H5M+17doiy?=
 =?us-ascii?Q?7OuiNgWNbVPSmIwHDz0aakUxgCtF7JGSveLcwEbN8k5n2uXS3MY9X/HGLFtL?=
 =?us-ascii?Q?eWQf/r2ZhIYc0yCKe9czeICsVT6NEUDWidQbtAVDnFYjJDZytZax90Lntpw9?=
 =?us-ascii?Q?yrbFBhJesrk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 19:23:08.5313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d667e2e-5272-46f6-b5b7-08dcc0845bad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6568
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

