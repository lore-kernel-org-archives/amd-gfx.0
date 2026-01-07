Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDAFCFD65B
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 15:58:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17B2210E63E;
	Wed,  7 Jan 2026 15:58:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3EsgAB63";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3291F10E63E
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 15:58:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFLiB8VX1PP5qMPOeJEILCwQBAs0kzWz0mj2Roieb9mhEf29EV2QiYK2DLOdFoa2uFn8DPVHMFHWL69aPXLLegftBfuQYXx7Pdzt4SwW02zjc2fiZf5CrYlgEhB4M2EYF9iHuxbxZAQZyA3buGr443LOD0zC1+DstD5HEY8RfKcDHpjg20Md4E5Kl3b0nUEzCrEvK83jSnX+FZhCKrnM1ptr0f8YN+EPm7e7iDdy72+XcoMF2v7DvrwA5arfm23i8fuLGWREcub6PRiLnxL2ihF77qVbXe8Jm71AHyCquo2w1IPtEw7Nt3IPnFlSKJ2Yq+7fOt5bAn/HFtpD6VpEow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQ3B0XkuAchavZRf5QQk2X89S1nBrlM+IR9q41kVLb4=;
 b=OtHyLuamSOAHBn7sjwyVFWkoVdAo1cbKi+F9pM9rnYMddZnnM9EnhfxzXU728YAMUwbQV1bfyLhKj9P7eQ+fA/1JO1Xf9qXRa8BTEGejJMYxR5xQX926ecvwlh8vvlzEeAm1x/T6hzoruIWn7zhDcG3yJTPYPydhIqhBQSmNY5TQqfEd5tfLZ8/ZRTuh5/VA3AVvs/BvzsQQv3YL0J6ka9LZJsmqKCdfxwmOfYeyjnVrwmTD5I5TXBLb4r6dHzDlPwUP7k3FgBEWHsQ8xpokkIVq3M+7//Tk6A+L2JHAHGvEExRQpWUXt5VtLIGe4gh4uvudWX90xlr4kekPgWwOOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQ3B0XkuAchavZRf5QQk2X89S1nBrlM+IR9q41kVLb4=;
 b=3EsgAB63PLRGexqVkL1bKdJjh6kAPMfm6JkMo+kVJy9TUzJvnkVqyx3lm8Uke5cwQGEDr5Niov5tIdjxfF1FxoJ2BvUCvt91ATFzq1hTfjD/xC805OlfIGibTkg+sApJDdxjrIKm6PN9dnkg6DXkzMBeuBnkkcax3RiUZWRYikQ=
Received: from BL1PR13CA0097.namprd13.prod.outlook.com (2603:10b6:208:2b9::12)
 by CYXPR12MB9441.namprd12.prod.outlook.com (2603:10b6:930:dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 15:58:08 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::5d) by BL1PR13CA0097.outlook.office365.com
 (2603:10b6:208:2b9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.0 via Frontend Transport; Wed, 7
 Jan 2026 15:58:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 15:58:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 7 Jan
 2026 09:58:07 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Jan
 2026 09:58:06 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 7 Jan 2026 09:58:01 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ray Wu <ray.wu@amd.com>, Matthew Stewart
 <matthew.stewart2@amd.com>
Subject: [PATCH 13/21] drm/amd/display: disable replay when crc source is
 enabled
Date: Wed, 7 Jan 2026 10:48:05 -0500
Message-ID: <20260107155421.1999951-14-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
References: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Matthew.Stewart2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|CYXPR12MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: ef7ce4c8-d9e7-4d7c-ff04-08de4e058ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O05TJIfryffEbP3XTGKA9p3Aczn0+RwX3nsfTSVa6zinsD2VcqGGUcxJ77QC?=
 =?us-ascii?Q?fdl7jU6DBMrV4UVNFRjvODEJUIJ8mskIS5j/bOgrouKzrgMPEJ2rM0ZABPkz?=
 =?us-ascii?Q?w7EJo4G8TvM00p4UKbXE575oL6Jqi9Ar8hK613DfYIQB7O5XRKGfqgGEMS/N?=
 =?us-ascii?Q?abJiM46LfjaJV+FpM+ba6WdI3HdIDvdZOe+lL4tx+BWG5PEejOi4+ee/48FS?=
 =?us-ascii?Q?pSceyxLcyOWrG2K5PdCaY5kyh06RCzatMPVAD+i7OSCtT5uK/y7pk48AkXMc?=
 =?us-ascii?Q?RuIwTmdXPo98sLLsNg7UAyIdXDNmARUr0mPFWLCOFoGw12Phec76YU62ZnL2?=
 =?us-ascii?Q?v6U3t5zkeU05wpC4fQUj/QZ/5oanioTQwYUbV4p86JutXmHsiDi/7eVBiRbf?=
 =?us-ascii?Q?yEetoJyzW0m0Zl2qerk8zMJylErckW4t9D1nTCJpc9bblhIItfXEqdQym09x?=
 =?us-ascii?Q?7l7Eea6btxFieimzz9TxdS1FXt//vwOZPQLc+F04ZMm5vpMBpdwEXEO0aBS2?=
 =?us-ascii?Q?r7u8hz4rtvv+GP7wdOeMbFw1DUFhkO8WT+F1YZzJhr7pHIhvgXrucFbeQXpX?=
 =?us-ascii?Q?SF53T1+FQ4DWdmZfwcSXCBGSbBmxEt6YB+/Kr7KAnK4FTQULMdRMmd5t6HzZ?=
 =?us-ascii?Q?YnarcuoFTNYIxPMr4cMfjvjzFG18q789LjzXaxJCZn0dHSaanyyuOtpgUBMG?=
 =?us-ascii?Q?HKbqq21mj+jnP33+zyIGV0+avH1DDiSadHP/z31NZM5Jv3rj14ZkKRl4EmSM?=
 =?us-ascii?Q?3zz7ib4LGO2V98p3+xoutD0GzwviLpq1H4TVfteSx30kDmv9BGuavLBgK6nW?=
 =?us-ascii?Q?GIkYb0tNNUxJvNB8O3OXLDV1m5zQrNNl1r3GZdGpovTRY+n78EKPEN0DOF+K?=
 =?us-ascii?Q?2wk3l8xEJlUiNOLon8twWOlU0rcX9laCZ66SvPO7QuFmqdUrXl37DM6+9fe5?=
 =?us-ascii?Q?ES9J5tV7W15wb5/4zunSglFZm2SHtNRD9+X5xQusdNegrVAQm1Olo9++pIuW?=
 =?us-ascii?Q?wBbZX9w1rbEWqEtpSYGAoOwkbFcw1ftb3K4uBBxYvWm4q9AN/guO126Zp81B?=
 =?us-ascii?Q?wY8/yKNqqHH5FScrFzCntHgB6iDMhaRgB06XjX+vrQhdH5jGz6XJj4x2wxr1?=
 =?us-ascii?Q?0t/mAwYeomi4NGS8Wyke3xLWa1vH4WhctxdUp1MrIP1se16ZiJQWtSmpXj76?=
 =?us-ascii?Q?zfh2F0CkPTLFlI8GCiXWZEf/jq7AXko284wrjs0CIB2EynbYwNuuNV0Ahmgs?=
 =?us-ascii?Q?P9RElP0JuCzJnJuSrOUXOP40K6U2XKozfj+boVcCVYc1UcRljpng+3IQbjSY?=
 =?us-ascii?Q?7rhfKhCOIems84kjPUuXpHvMoSYONMFDNzHx69ZZHUW8i8WXqYrWW0MTYWa9?=
 =?us-ascii?Q?zfwLmw0h0MlCzK84KJrcJkWtiisZGYfhoynKsVSh0kuL+bSVpXdrfq3tXuC+?=
 =?us-ascii?Q?l+zTF+9Ma8wNSpuZeZN8oQWyUQ/d4dEkO2fTBb0ASkrl1vfqOITs/+FyZ/IT?=
 =?us-ascii?Q?y5nUR1LwG0oNuG465MrNPsuwLe2e0R9lWK8dHfbm8nXrdJ5efLXA719qkBwG?=
 =?us-ascii?Q?9K7SG6doV8wb1JoYcE8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 15:58:07.4319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7ce4c8-d9e7-4d7c-ff04-08de4e058ca6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441
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

From: Ray Wu <ray.wu@amd.com>

[Why]
IGT CRC tests fail on replay panels due to invalid CRC values
captured when replay is active.

[How]
- Disable replay when CRC source is enabled; set flag to
  prevent unexpected re-enable
- Reset flag when CRC source is disabled to allow replay

Reviewed-by: ChiaHsuan (Tom) Chung <chiahsuan.chung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 25 ++++++++++++++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  |  7 ++++++
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 7065b20aa2e6..5775c722dd92 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -810,6 +810,7 @@ struct amdgpu_dm_connector {
 
 	int sr_skip_count;
 	bool disallow_edp_enter_psr;
+	bool disallow_edp_enter_replay;
 
 	/* Record progress status of mst*/
 	uint8_t mst_status;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 327b20055729..5851f2d55dde 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -32,6 +32,7 @@
 #include "dc.h"
 #include "amdgpu_securedisplay.h"
 #include "amdgpu_dm_psr.h"
+#include "amdgpu_dm_replay.h"
 
 static const char *const pipe_crc_sources[] = {
 	"none",
@@ -502,6 +503,7 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 {
 	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
 	struct dc_stream_state *stream_state = dm_crtc_state->stream;
+	struct amdgpu_dm_connector *aconnector = NULL;
 	bool enable = amdgpu_dm_is_valid_crc_source(source);
 	int ret = 0;
 
@@ -509,11 +511,22 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 	if (!stream_state)
 		return -EINVAL;
 
+	/* Get connector from stream */
+	aconnector = (struct amdgpu_dm_connector *)stream_state->dm_stream_context;
+
 	mutex_lock(&adev->dm.dc_lock);
 
-	/* For PSR1, check that the panel has exited PSR */
-	if (stream_state->link->psr_settings.psr_version < DC_PSR_VERSION_SU_1)
-		amdgpu_dm_psr_wait_disable(stream_state);
+
+	if (enable) {
+		/* For PSR1, check that the panel has exited PSR */
+		if (stream_state->link->psr_settings.psr_version < DC_PSR_VERSION_SU_1)
+			amdgpu_dm_psr_wait_disable(stream_state);
+
+		/* Set flag to disallow enter replay when CRC source is enabled */
+		if (aconnector)
+			aconnector->disallow_edp_enter_replay = true;
+		amdgpu_dm_replay_disable(stream_state);
+	}
 
 	/* Enable or disable CRTC CRC generation */
 	if (dm_is_crc_source_crtc(source) || source == AMDGPU_DM_PIPE_CRC_SOURCE_NONE) {
@@ -536,6 +549,12 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 					    DYN_EXPANSION_AUTO);
 	}
 
+	if (!enable) {
+		/* Clear flag to allow enter replay when CRC source is disabled */
+		if (aconnector)
+			aconnector->disallow_edp_enter_replay = false;
+	}
+
 unlock:
 	mutex_unlock(&adev->dm.dc_lock);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
index fb619a3336b7..8c150b001105 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
@@ -154,10 +154,17 @@ bool amdgpu_dm_replay_enable(struct dc_stream_state *stream, bool wait)
 {
 	bool replay_active = true;
 	struct dc_link *link = NULL;
+	struct amdgpu_dm_connector *aconnector = NULL;
 
 	if (stream == NULL)
 		return false;
 
+	/* Check if replay is disabled by connector flag */
+	aconnector = (struct amdgpu_dm_connector *)stream->dm_stream_context;
+	if (!aconnector || aconnector->disallow_edp_enter_replay) {
+		return false;
+	}
+
 	link = stream->link;
 
 	if (link) {
-- 
2.52.0

