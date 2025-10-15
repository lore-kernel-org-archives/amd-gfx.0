Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D87CCD18E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 02:59:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E4EC10E6DB;
	Wed, 15 Oct 2025 02:59:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rvDTcYuK";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67AE710E6D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 02:58:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpctGqAcm66Gxn4FGoGXUJXqjzDFO2NsLyst46fN6Qsca//LMwry7y/NIHO9gn1bnh2QR63XteHmpFBYm5OAb5U2MBlFWrV9Zft86q4FRdFOpWQbuLZFcl9w5rNtklFW/c9FVIYghmcGD81N3vyYGhQhoXcTNN0BA+xO7cWzLNDDtSujelWRlAogJh7f6MzrGsRtrlbHbDwI7w/KZ7AqAfYKIAIhcKZeBnlQaj4q4ZmrM5RkKUyXgLFuIBcSL9Uv/iXRTXQcHuBZJ1ujLZqQ5zT2fMGMtLECT0/EuCHyP+jQ39/UkoHCWt51DN/0uwvdIhimFpu5TcoYYMafzIdm5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMKnnYBKSONnmMwPx0YH3QRC35IE/MJkb3/rxvoaIJ4=;
 b=uQeh4a6qiGDehIsiBlag1B8fYo7813Kf8XVJmcPlzIEF15qIx/h7A5+jqdBoB0n0dbnVwpWrwO7oPar3h4w2cVJ6AOvWhhytxYGlkrhAJVwb4N30e+VO/dKX0qfD+ELNt/iGWpkQUiLVb4L0ZCFu94TonUxCLGxqNE/YHmNnjN3fNAqwOUgliiaZjy9zcQ03sFdiEl2Z2Y0AcgsffT1urzmujVdpiPs3Kn6xyr8nZV/fHRoz2iDc2AGCPeME+DG5/sBa+1XfguRjN6IkcoyfUFeqBqoT2xSNO+u+c6v1X3QuhxZWArm4kp1zdy/L4zCZhpca9R4WtTyy1iSKN/fdyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMKnnYBKSONnmMwPx0YH3QRC35IE/MJkb3/rxvoaIJ4=;
 b=rvDTcYuKOkrdMLGnNyieEoqAg29DmaHlf7SjeHKzBXDR7iimeEA6X6rom45wHrmMaOfufwUyB0H1psRBfxhgM/nZMLEftDgkRoWJYGVVi+VpOAQ4FCp0iyD/DRFMmTLDKXHiuuX0/TlwIBlIr0wyA1CGVoiZjrj/sih7Z4Y+cT8=
Received: from SJ0PR05CA0027.namprd05.prod.outlook.com (2603:10b6:a03:33b::32)
 by CH8PR12MB9765.namprd12.prod.outlook.com (2603:10b6:610:264::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 02:58:46 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:33b:cafe::3c) by SJ0PR05CA0027.outlook.office365.com
 (2603:10b6:a03:33b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.9 via Frontend Transport; Wed,
 15 Oct 2025 02:58:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 02:58:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 14 Oct
 2025 19:58:42 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Oct
 2025 21:58:41 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Oct 2025 19:58:38 -0700
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 1/8] drm/amd/display: Fix GFP_ATOMIC abuse
Date: Wed, 15 Oct 2025 10:57:02 +0800
Message-ID: <20251015025816.1542507-2-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015025816.1542507-1-chiahsuan.chung@amd.com>
References: <20251015025816.1542507-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|CH8PR12MB9765:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f18483-9b39-401e-1c8b-08de0b96c11e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W53uKUDbBhHAw/NZTTRQ3WVNvJnHrEGay3QYdVcRcjabXumnI/e6IRDW2FRZ?=
 =?us-ascii?Q?+rSWN1ymtD6F/gNFgHRjKFzmltWLKPIV5F4mRKayXLQKGvALFsOnMwzFgl/I?=
 =?us-ascii?Q?BxZ9z6LIfQ3a8xL7QuGG2nMMmIqfDpc5UxWCbv6m2o4W1yHYhXK7piq4kxkf?=
 =?us-ascii?Q?HFkkPI+sG4TUPhDBAjYlZmPZK4iH0pSySywSRDQ5wUT8uP8FWMXXKMsBngzf?=
 =?us-ascii?Q?D3KAg3CrA5MDxQcY2LgR2XIham3GFtWuSfFsWYxLNtNN1ablD6F+beRuFSZt?=
 =?us-ascii?Q?J9IbhGT0/CRCItI2YLcTjf67LeE/r6uPMJAJbW+miQRi1zTsKczUS3y5wsae?=
 =?us-ascii?Q?/cbk0Rb/vn79aYobxrtWU4QOhy91X0CK+pig2bRxqbHm9ysOhNsa0hNFtPjn?=
 =?us-ascii?Q?6suDtZjbo/xrMB41OAnFTeKScQSGY3DStac9H8I5zKcJHLr7kFbjZF5BmLsz?=
 =?us-ascii?Q?/EBlxu+c6043E8NRiYS/kTNk/UBuuJOcHQ5gddCyEpVvr4+Uw9swUH799PF4?=
 =?us-ascii?Q?qpdPU6PtMEExaHu4KFml5FIirWfA2QZUbeXs0AgEovxfs0jiiT3JDIrVP9uU?=
 =?us-ascii?Q?K9Bu2tBYmIzgihRhdP2wP9ZmMmCstSe//qknHabMLWRC/4TyActmLP3ijbAo?=
 =?us-ascii?Q?Ebbfa/rCbzr9IcXofItpPvBDHXCyz94qYsmkMBTNjo9XodcPvo7C4DHJIm6X?=
 =?us-ascii?Q?+8DtXowdQJyiIL3ztQkty5wWaskU/KoXET4hRVozU/4lSUAEP++Z1qz3okpb?=
 =?us-ascii?Q?Gu4IhmLII/fj2nkJteHBmlaErPmmFdRYSCz5yvFC/+APmas//DFXD5PnrYda?=
 =?us-ascii?Q?R1WaA49dZ0386hdY2OtjtywAgCkOxbis6pRrimYpvxotBVIhe8L4eyD49dn9?=
 =?us-ascii?Q?sMl14YBowgtsa468tGk/axz+3M8x7cLueKaHgZ/Ks4w8PeCuZOqGDMhQbXz+?=
 =?us-ascii?Q?5Ejfjv96ycs+WfqxdYjhGK7WZfI9m5/VkMRxFhLZm+MwxnJWE4nxmHIXwjVe?=
 =?us-ascii?Q?EaUA/h0RHW2AKlYQ8OmQHkntLuNVSFGZlYL6/rIwSKSyGgeHl/ml0l+3J+l3?=
 =?us-ascii?Q?2swbVohXDhCyNhw/Q9qo1qcc24L+hHvMZfNgScbHAqSChm+zA4gXKPMyvsgz?=
 =?us-ascii?Q?lVIEesnve+XQW2WQsxeupUOyHbh+xkmASP1Extd7/QzrrPAggjNMFSc38S5/?=
 =?us-ascii?Q?bu8vqrCxOd82MCGOnWMf6hlYqznxk0WlfUOwF6saUIE+qRzBTY6bIjtv1Vvt?=
 =?us-ascii?Q?et4Osy5A5G/hPBqVkZ4xui54oFTg+xm+5rP8d4k666c+Bh/VgAZTHA0WTRxN?=
 =?us-ascii?Q?4afH23jWrs0vr/kfWHcXF2P04xCfYUYDlGrLaP+rvTxAAgN0xkre2LI28IT1?=
 =?us-ascii?Q?HaD5SFofOCjDH3fM4usDXSb1JNJKornM9Ong7VRadcTVvKKiAhYdEn+RO5PZ?=
 =?us-ascii?Q?kyvuPzPx6K0nOcMfHIPmXnyiU54PdufF5A30BNTbxZbKgVukJVfCFMNwrzhK?=
 =?us-ascii?Q?QAbVMyGyyG3++R25ooA2hHfdyE0OQ962CJVs6ouVZmEo8jSqBLYs2AS5yKKP?=
 =?us-ascii?Q?nxH1iEft03YPW7k1Sj8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 02:58:44.4792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f18483-9b39-401e-1c8b-08de0b96c11e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9765
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

There is a lot GFP_ATOMIC allocations which are not in interrupt
context. Change them to use GFP_KERNEL instead.

Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c |  6 ++--
 .../dc/resource/dcn20/dcn20_resource.c        | 28 ++++++++---------
 .../dc/resource/dcn201/dcn201_resource.c      | 30 +++++++++----------
 6 files changed, 33 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3b28e453ea7d..9ab97f51f67b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10571,7 +10571,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		 * Here we create an empty update on each plane.
 		 * To fix this, DC should permit updating only stream properties.
 		 */
-		dummy_updates = kzalloc(sizeof(struct dc_surface_update) * MAX_SURFACES, GFP_ATOMIC);
+		dummy_updates = kzalloc(sizeof(struct dc_surface_update) * MAX_SURFACES, GFP_KERNEL);
 		if (!dummy_updates) {
 			drm_err(adev_to_drm(adev), "Failed to allocate memory for dummy_updates.\n");
 			continue;
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c
index 5999b2da3a01..33d8bd91cb01 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c
@@ -148,7 +148,7 @@ struct dccg *dccg2_create(
 	const struct dccg_shift *dccg_shift,
 	const struct dccg_mask *dccg_mask)
 {
-	struct dcn_dccg *dccg_dcn = kzalloc(sizeof(*dccg_dcn), GFP_ATOMIC);
+	struct dcn_dccg *dccg_dcn = kzalloc(sizeof(*dccg_dcn), GFP_KERNEL);
 	struct dccg *base;
 
 	if (dccg_dcn == NULL) {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
index a6006776333d..2dcf394edf22 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
@@ -283,7 +283,7 @@ struct abm *dce_abm_create(
 	const struct dce_abm_shift *abm_shift,
 	const struct dce_abm_mask *abm_mask)
 {
-	struct dce_abm *abm_dce = kzalloc(sizeof(*abm_dce), GFP_ATOMIC);
+	struct dce_abm *abm_dce = kzalloc(sizeof(*abm_dce), GFP_KERNEL);
 
 	if (abm_dce == NULL) {
 		BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
index a8e79104b684..5f8fba45d98d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
@@ -1126,7 +1126,7 @@ struct dmcu *dcn10_dmcu_create(
 	const struct dce_dmcu_shift *dmcu_shift,
 	const struct dce_dmcu_mask *dmcu_mask)
 {
-	struct dce_dmcu *dmcu_dce = kzalloc(sizeof(*dmcu_dce), GFP_ATOMIC);
+	struct dce_dmcu *dmcu_dce = kzalloc(sizeof(*dmcu_dce), GFP_KERNEL);
 
 	if (dmcu_dce == NULL) {
 		BREAK_TO_DEBUGGER();
@@ -1147,7 +1147,7 @@ struct dmcu *dcn20_dmcu_create(
 	const struct dce_dmcu_shift *dmcu_shift,
 	const struct dce_dmcu_mask *dmcu_mask)
 {
-	struct dce_dmcu *dmcu_dce = kzalloc(sizeof(*dmcu_dce), GFP_ATOMIC);
+	struct dce_dmcu *dmcu_dce = kzalloc(sizeof(*dmcu_dce), GFP_KERNEL);
 
 	if (dmcu_dce == NULL) {
 		BREAK_TO_DEBUGGER();
@@ -1168,7 +1168,7 @@ struct dmcu *dcn21_dmcu_create(
 	const struct dce_dmcu_shift *dmcu_shift,
 	const struct dce_dmcu_mask *dmcu_mask)
 {
-	struct dce_dmcu *dmcu_dce = kzalloc(sizeof(*dmcu_dce), GFP_ATOMIC);
+	struct dce_dmcu *dmcu_dce = kzalloc(sizeof(*dmcu_dce), GFP_KERNEL);
 
 	if (dmcu_dce == NULL) {
 		BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index f4d3ff79717f..30f155dc54e5 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -733,7 +733,7 @@ struct dpp *dcn20_dpp_create(
 	uint32_t inst)
 {
 	struct dcn20_dpp *dpp =
-		kzalloc(sizeof(struct dcn20_dpp), GFP_ATOMIC);
+		kzalloc(sizeof(struct dcn20_dpp), GFP_KERNEL);
 
 	if (!dpp)
 		return NULL;
@@ -751,7 +751,7 @@ struct input_pixel_processor *dcn20_ipp_create(
 	struct dc_context *ctx, uint32_t inst)
 {
 	struct dcn10_ipp *ipp =
-		kzalloc(sizeof(struct dcn10_ipp), GFP_ATOMIC);
+		kzalloc(sizeof(struct dcn10_ipp), GFP_KERNEL);
 
 	if (!ipp) {
 		BREAK_TO_DEBUGGER();
@@ -768,7 +768,7 @@ struct output_pixel_processor *dcn20_opp_create(
 	struct dc_context *ctx, uint32_t inst)
 {
 	struct dcn20_opp *opp =
-		kzalloc(sizeof(struct dcn20_opp), GFP_ATOMIC);
+		kzalloc(sizeof(struct dcn20_opp), GFP_KERNEL);
 
 	if (!opp) {
 		BREAK_TO_DEBUGGER();
@@ -785,7 +785,7 @@ struct dce_aux *dcn20_aux_engine_create(
 	uint32_t inst)
 {
 	struct aux_engine_dce110 *aux_engine =
-		kzalloc(sizeof(struct aux_engine_dce110), GFP_ATOMIC);
+		kzalloc(sizeof(struct aux_engine_dce110), GFP_KERNEL);
 
 	if (!aux_engine)
 		return NULL;
@@ -823,7 +823,7 @@ struct dce_i2c_hw *dcn20_i2c_hw_create(
 	uint32_t inst)
 {
 	struct dce_i2c_hw *dce_i2c_hw =
-		kzalloc(sizeof(struct dce_i2c_hw), GFP_ATOMIC);
+		kzalloc(sizeof(struct dce_i2c_hw), GFP_KERNEL);
 
 	if (!dce_i2c_hw)
 		return NULL;
@@ -835,8 +835,7 @@ struct dce_i2c_hw *dcn20_i2c_hw_create(
 }
 struct mpc *dcn20_mpc_create(struct dc_context *ctx)
 {
-	struct dcn20_mpc *mpc20 = kzalloc(sizeof(struct dcn20_mpc),
-					  GFP_ATOMIC);
+	struct dcn20_mpc *mpc20 = kzalloc(sizeof(struct dcn20_mpc), GFP_KERNEL);
 
 	if (!mpc20)
 		return NULL;
@@ -853,8 +852,7 @@ struct mpc *dcn20_mpc_create(struct dc_context *ctx)
 struct hubbub *dcn20_hubbub_create(struct dc_context *ctx)
 {
 	int i;
-	struct dcn20_hubbub *hubbub = kzalloc(sizeof(struct dcn20_hubbub),
-					  GFP_ATOMIC);
+	struct dcn20_hubbub *hubbub = kzalloc(sizeof(struct dcn20_hubbub), GFP_KERNEL);
 
 	if (!hubbub)
 		return NULL;
@@ -882,7 +880,7 @@ struct timing_generator *dcn20_timing_generator_create(
 		uint32_t instance)
 {
 	struct optc *tgn10 =
-		kzalloc(sizeof(struct optc), GFP_ATOMIC);
+		kzalloc(sizeof(struct optc), GFP_KERNEL);
 
 	if (!tgn10)
 		return NULL;
@@ -962,7 +960,7 @@ static struct clock_source *dcn20_clock_source_create(
 	bool dp_clk_src)
 {
 	struct dce110_clk_src *clk_src =
-		kzalloc(sizeof(struct dce110_clk_src), GFP_ATOMIC);
+		kzalloc(sizeof(struct dce110_clk_src), GFP_KERNEL);
 
 	if (!clk_src)
 		return NULL;
@@ -1061,7 +1059,7 @@ struct display_stream_compressor *dcn20_dsc_create(
 	struct dc_context *ctx, uint32_t inst)
 {
 	struct dcn20_dsc *dsc =
-		kzalloc(sizeof(struct dcn20_dsc), GFP_ATOMIC);
+		kzalloc(sizeof(struct dcn20_dsc), GFP_KERNEL);
 
 	if (!dsc) {
 		BREAK_TO_DEBUGGER();
@@ -1198,7 +1196,7 @@ struct hubp *dcn20_hubp_create(
 	uint32_t inst)
 {
 	struct dcn20_hubp *hubp2 =
-		kzalloc(sizeof(struct dcn20_hubp), GFP_ATOMIC);
+		kzalloc(sizeof(struct dcn20_hubp), GFP_KERNEL);
 
 	if (!hubp2)
 		return NULL;
@@ -2287,7 +2285,7 @@ bool dcn20_mmhubbub_create(struct dc_context *ctx, struct resource_pool *pool)
 
 static struct pp_smu_funcs *dcn20_pp_smu_create(struct dc_context *ctx)
 {
-	struct pp_smu_funcs *pp_smu = kzalloc(sizeof(*pp_smu), GFP_ATOMIC);
+	struct pp_smu_funcs *pp_smu = kzalloc(sizeof(*pp_smu), GFP_KERNEL);
 
 	if (!pp_smu)
 		return pp_smu;
@@ -2766,7 +2764,7 @@ struct resource_pool *dcn20_create_resource_pool(
 		struct dc *dc)
 {
 	struct dcn20_resource_pool *pool =
-		kzalloc(sizeof(struct dcn20_resource_pool), GFP_ATOMIC);
+		kzalloc(sizeof(struct dcn20_resource_pool), GFP_KERNEL);
 
 	if (!pool)
 		return NULL;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
index e4a1338d21e0..9a80bebcee48 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
@@ -629,7 +629,7 @@ static struct dpp *dcn201_dpp_create(
 	uint32_t inst)
 {
 	struct dcn201_dpp *dpp =
-		kzalloc(sizeof(struct dcn201_dpp), GFP_ATOMIC);
+		kzalloc(sizeof(struct dcn201_dpp), GFP_KERNEL);
 
 	if (!dpp)
 		return NULL;
@@ -646,7 +646,7 @@ static struct input_pixel_processor *dcn201_ipp_create(
 	struct dc_context *ctx, uint32_t inst)
 {
 	struct dcn10_ipp *ipp =
-		kzalloc(sizeof(struct dcn10_ipp), GFP_ATOMIC);
+		kzalloc(sizeof(struct dcn10_ipp), GFP_KERNEL);
 
 	if (!ipp) {
 		return NULL;
@@ -662,7 +662,7 @@ static struct output_pixel_processor *dcn201_opp_create(
 	struct dc_context *ctx, uint32_t inst)
 {
 	struct dcn201_opp *opp =
-		kzalloc(sizeof(struct dcn201_opp), GFP_ATOMIC);
+		kzalloc(sizeof(struct dcn201_opp), GFP_KERNEL);
 
 	if (!opp) {
 		return NULL;
@@ -677,7 +677,7 @@ static struct dce_aux *dcn201_aux_engine_create(struct dc_context *ctx,
 						uint32_t inst)
 {
 	struct aux_engine_dce110 *aux_engine =
-		kzalloc(sizeof(struct aux_engine_dce110), GFP_ATOMIC);
+		kzalloc(sizeof(struct aux_engine_dce110), GFP_KERNEL);
 
 	if (!aux_engine)
 		return NULL;
@@ -710,7 +710,7 @@ static struct dce_i2c_hw *dcn201_i2c_hw_create(struct dc_context *ctx,
 					       uint32_t inst)
 {
 	struct dce_i2c_hw *dce_i2c_hw =
-		kzalloc(sizeof(struct dce_i2c_hw), GFP_ATOMIC);
+		kzalloc(sizeof(struct dce_i2c_hw), GFP_KERNEL);
 
 	if (!dce_i2c_hw)
 		return NULL;
@@ -723,8 +723,7 @@ static struct dce_i2c_hw *dcn201_i2c_hw_create(struct dc_context *ctx,
 
 static struct mpc *dcn201_mpc_create(struct dc_context *ctx, uint32_t num_mpcc)
 {
-	struct dcn201_mpc *mpc201 = kzalloc(sizeof(struct dcn201_mpc),
-					    GFP_ATOMIC);
+	struct dcn201_mpc *mpc201 = kzalloc(sizeof(struct dcn201_mpc), GFP_KERNEL);
 
 	if (!mpc201)
 		return NULL;
@@ -740,8 +739,7 @@ static struct mpc *dcn201_mpc_create(struct dc_context *ctx, uint32_t num_mpcc)
 
 static struct hubbub *dcn201_hubbub_create(struct dc_context *ctx)
 {
-	struct dcn20_hubbub *hubbub = kzalloc(sizeof(struct dcn20_hubbub),
-					  GFP_ATOMIC);
+	struct dcn20_hubbub *hubbub = kzalloc(sizeof(struct dcn20_hubbub), GFP_KERNEL);
 
 	if (!hubbub)
 		return NULL;
@@ -759,7 +757,7 @@ static struct timing_generator *dcn201_timing_generator_create(
 		uint32_t instance)
 {
 	struct optc *tgn10 =
-		kzalloc(sizeof(struct optc), GFP_ATOMIC);
+		kzalloc(sizeof(struct optc), GFP_KERNEL);
 
 	if (!tgn10)
 		return NULL;
@@ -793,7 +791,7 @@ static struct link_encoder *dcn201_link_encoder_create(
 	const struct encoder_init_data *enc_init_data)
 {
 	struct dcn20_link_encoder *enc20 =
-		kzalloc(sizeof(struct dcn20_link_encoder), GFP_ATOMIC);
+		kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
 	struct dcn10_link_encoder *enc10;
 
 	if (!enc20 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
@@ -821,7 +819,7 @@ static struct clock_source *dcn201_clock_source_create(
 	bool dp_clk_src)
 {
 	struct dce110_clk_src *clk_src =
-		kzalloc(sizeof(struct dce110_clk_src), GFP_ATOMIC);
+		kzalloc(sizeof(struct dce110_clk_src), GFP_KERNEL);
 
 	if (!clk_src)
 		return NULL;
@@ -856,7 +854,7 @@ static struct stream_encoder *dcn201_stream_encoder_create(
 	struct dc_context *ctx)
 {
 	struct dcn10_stream_encoder *enc1 =
-		kzalloc(sizeof(struct dcn10_stream_encoder), GFP_ATOMIC);
+		kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
 
 	if (!enc1)
 		return NULL;
@@ -883,7 +881,7 @@ static const struct dce_hwseq_mask hwseq_mask = {
 static struct dce_hwseq *dcn201_hwseq_create(
 	struct dc_context *ctx)
 {
-	struct dce_hwseq *hws = kzalloc(sizeof(struct dce_hwseq), GFP_ATOMIC);
+	struct dce_hwseq *hws = kzalloc(sizeof(struct dce_hwseq), GFP_KERNEL);
 
 	if (hws) {
 		hws->ctx = ctx;
@@ -983,7 +981,7 @@ static struct hubp *dcn201_hubp_create(
 	uint32_t inst)
 {
 	struct dcn201_hubp *hubp201 =
-		kzalloc(sizeof(struct dcn201_hubp), GFP_ATOMIC);
+		kzalloc(sizeof(struct dcn201_hubp), GFP_KERNEL);
 
 	if (!hubp201)
 		return NULL;
@@ -1303,7 +1301,7 @@ struct resource_pool *dcn201_create_resource_pool(
 		struct dc *dc)
 {
 	struct dcn201_resource_pool *pool =
-		kzalloc(sizeof(struct dcn201_resource_pool), GFP_ATOMIC);
+		kzalloc(sizeof(struct dcn201_resource_pool), GFP_KERNEL);
 
 	if (!pool)
 		return NULL;
-- 
2.43.0

