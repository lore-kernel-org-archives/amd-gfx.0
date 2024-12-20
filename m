Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C4FE7718B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 21:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D5D110F07E;
	Fri, 20 Dec 2024 21:51:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Twj6z25q";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E116810F076
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 21:51:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTbiZ/Cx8CM4OQEFi6x9cUOXvPun6yMaVEBvOmruh8pCmyCVT6f0SLefv4iO+iaczb1LZ1nSDJjXPdzB5lZYEpkrGQNBT7KA4oDdtgYIBOOcO2h4cWT8HW6DJS+mbD8o+BbhlEh0wGPL73PfRWjDe1b+/0fad8xxzwLNBKHrQ5uqnsZZ/bo0PAElV+TuYgeBXJeV4hXxqgCnWjlzNJX3J5xANqimhTSs1CnzPwbjDolk1CLR3uSQULTBvI/Ef0//Xg5F29Knhfq4zlITaSGcRVeipz45/feAosyV7LnJUebI55WmSZxbhylt2kfKj9FnXO3SqeNSvDf3ODt4TJh+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sP2YIRoBXJZQJFCPWAOKy68uKN+aMCsGL47djCVdl1Y=;
 b=xYD2gWNOhaxyQkuhJRX+lGByJM5sFiNlEGXn1/XhQOtLmGlWgZfKVZl12dS2M4uMTtLZ17hoKQ8f088EHK7EcozH9ndtW414WoOlY7EHpV1N2anvYApH34uTCPNXpNGqEPNP1Xk3O/IJyzAzxhmRd29EyHaKRCrx0qjHk1bkdihOcds3wvlBM/T4Rq4bfmgUlR4brbOtuD/nQJFayFCGm4Wmi/szMNlJcLRX/55TD7si+V1by5wgJxNON50SET6QTxiDG99WOz+0lkHcMzschlY3jTaIzNfLTzoStAbylZUtt52Cv8Mkh7niJjCbI+aqedgTPD6CgtHU2saH7g/how==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP2YIRoBXJZQJFCPWAOKy68uKN+aMCsGL47djCVdl1Y=;
 b=Twj6z25qNZWYFeGx8pdAeXRv5zLalNQFsqplTLC1j64h+pMZpg8otmx+xJGbgawNyQRX5TZoyg+XcqUSuBh8nKt8J9hlEHwDHd6eeTW5M57iimBN3hB0Dqd3PrEcDCudUKKnogbonFFOhRGj7qxFfhSzoA+6a1zaH2JS1N606uE=
Received: from MW4PR02CA0001.namprd02.prod.outlook.com (2603:10b6:303:16d::21)
 by LV8PR12MB9231.namprd12.prod.outlook.com (2603:10b6:408:192::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 21:51:22 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:303:16d:cafe::d6) by MW4PR02CA0001.outlook.office365.com
 (2603:10b6:303:16d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.16 via Frontend Transport; Fri,
 20 Dec 2024 21:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:51:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:21 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:21 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:51:20 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 22/28] drm/amd/display: Disable replay and psr while VRR is
 enabled
Date: Fri, 20 Dec 2024 16:48:49 -0500
Message-ID: <20241220214855.2608618-23-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|LV8PR12MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f8db00-ec89-46f3-401a-08dd214071c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5rOseve4p4jPVrfX8LSg9jcw2O9TjPtw/x0Dry5pgfDQacwtpJ7jlS/9wBTM?=
 =?us-ascii?Q?PCyVGs8CyoVm6Jk56XDb0VNhn95Vm/9JIMkrlBQoTxr0Og8stSpY9Ow1nzYp?=
 =?us-ascii?Q?OR0kL8rWghkCP+oMdWeSuKMkn2lpBQTJo2Y+bjM+poLKq/Uc3chFoOiFmg6Y?=
 =?us-ascii?Q?49na5KB19EiCLeGj05+Rcc0wjPuGs9GXnaVA7tY20ounpDpz10B5JUJhufMi?=
 =?us-ascii?Q?h3DzgcuHYvWA0bss9xyQs9Z1+rPey/67LzVVwToA4+Q1aPSyrKvUF1VglynE?=
 =?us-ascii?Q?2qLFIJuKP20yEKhuGdUdoWXwFrjUEslEaMQn6ln1U7QcTqMa4WK5r3PbFm9k?=
 =?us-ascii?Q?7elzd1E5aA4FwuuQOtRsAvhVftHBQhmzAWx5GINAxVGl6iIStrPOybplZ6uu?=
 =?us-ascii?Q?3zKuBgHFEBj7HNzBQR+DT3d+/XbfMFPWtCaKUyKPSD3VHNM/2x5vpHQK6FTd?=
 =?us-ascii?Q?KrlV46ShjD8GLZgpw7gPxZjxq558F74gyi9/AjNMHfTKiYlrbBLGD2SC6JIr?=
 =?us-ascii?Q?8m66n+ksm4XxLXEGbQmKHil301lIBGlVH+PM6ayZevbFD/5WtJvutZwwr+R0?=
 =?us-ascii?Q?aEM0VfVvQZDysBgcr7qBDv9RrgjQSzJ4HtU/RtQmahG0TJpfqhuXbadF9CNu?=
 =?us-ascii?Q?UiN4YNkjTEWwTP+fXJp/o9xSVRFYYbRVhP8qVMUNSzZnok9LRYiIy68aHKYe?=
 =?us-ascii?Q?P8gsGHeyaE1Dd9Zx9N/JCoui/7PPJYBZ0Ndkc+7YFN4En/YjRfYXFfTs9mwk?=
 =?us-ascii?Q?zX/xnxYp2KoI8Zec/0kNhUNiyih5Xenj5kw8CeedfePlbN+yPo2T3918uXO8?=
 =?us-ascii?Q?DYfsK8IzneXUmqbxL3+lbfeQ0c7+qfSFTyxsesJItl4uX2JGoF0nUIeLksFx?=
 =?us-ascii?Q?EHbkDuwrRACQ3GTqjScz96XtjLTxCRY5Lwmr4eAJQy5+e5FLsu4FXUKuA0hk?=
 =?us-ascii?Q?9yYtxqZf9AwY7xkK8/kXHYsRORAcNLp6xg1yxjStwzC3vjk380jFqpfx/XpO?=
 =?us-ascii?Q?uVTXEsl4heDsF4CVF9MKYzd8H68pJ6FrB6lMs7IX2/Ng5JvuymIJ+vUf5tzn?=
 =?us-ascii?Q?MPppxkUTkCD1pnRlrrktnNSBI5eiavOAdm8I3VbbCt56aF2O6ZNPjuYE2k6P?=
 =?us-ascii?Q?H88Hf5kYQSZowuNJHaToggkMpjWQmo3j63M+EHBXP/zRWxW8xTL9ZofMIG6V?=
 =?us-ascii?Q?Z9UJnUVA7yaIsR8d7oYvi2UvVYZ/CmlkgSv6LJ3f+IdNj29VnTtjJQ1tNklI?=
 =?us-ascii?Q?sEOQLZFmaeeLiyNebGQb6dN2wgIKw6lC4yAqcCv4vZTc8zMDNPideMUzzy44?=
 =?us-ascii?Q?SQehIXVwgRe7dp2xKmIIqiXxApd/Zg/arka/HozY2bbcmIYhjQ9ISAoV9Rsb?=
 =?us-ascii?Q?7O6K/XopFBCLetDfvSKSTTbZ19x7/BdbSdbF6lb8+wOvR0HzOr/02KH16FPy?=
 =?us-ascii?Q?evrmtgVCt3D+SNAoA8bRKuUaPCveOif9F4WsbfJRiLwnqcHRXIteqQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:51:22.5070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f8db00-ec89-46f3-401a-08dd214071c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9231
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

From: Tom Chung <chiahsuan.chung@amd.com>

[Why]
Replay and PSR will cause some video corruption while VRR is enabled.

[How]
1. Disable the Replay and PSR while VRR is enabled.
2. Change the amdgpu_dm_crtc_vrr_active() parameter to const.
   Because the function will only read data from dm_crtc_state.

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      | 6 ++++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a579c11b4324..7020ca524412 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8929,6 +8929,7 @@ static void amdgpu_dm_enable_self_refresh(struct amdgpu_crtc *acrtc_attach,
 	struct replay_settings *pr = &acrtc_state->stream->link->replay_settings;
 	struct amdgpu_dm_connector *aconn =
 		(struct amdgpu_dm_connector *)acrtc_state->stream->dm_stream_context;
+	bool vrr_active = amdgpu_dm_crtc_vrr_active(acrtc_state);
 
 	if (acrtc_state->update_type > UPDATE_TYPE_FAST) {
 		if (pr->config.replay_supported && !pr->replay_feature_enabled)
@@ -8955,7 +8956,8 @@ static void amdgpu_dm_enable_self_refresh(struct amdgpu_crtc *acrtc_attach,
 		 * adequate number of fast atomic commits to notify KMD
 		 * of update events. See `vblank_control_worker()`.
 		 */
-		if (acrtc_attach->dm_irq_params.allow_sr_entry &&
+		if (!vrr_active &&
+		    acrtc_attach->dm_irq_params.allow_sr_entry &&
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
 		    !amdgpu_dm_crc_window_is_activated(acrtc_state->base.crtc) &&
 #endif
@@ -9299,7 +9301,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			bundle->stream_update.abm_level = &acrtc_state->abm_level;
 
 		mutex_lock(&dm->dc_lock);
-		if (acrtc_state->update_type > UPDATE_TYPE_FAST) {
+		if ((acrtc_state->update_type > UPDATE_TYPE_FAST) || vrr_active) {
 			if (acrtc_state->stream->link->replay_settings.replay_allow_active)
 				amdgpu_dm_replay_disable(acrtc_state->stream);
 			if (acrtc_state->stream->link->psr_settings.psr_allow_active)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 64a041c2af05..8bc73922e3a6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -93,7 +93,7 @@ int amdgpu_dm_crtc_set_vupdate_irq(struct drm_crtc *crtc, bool enable)
 	return rc;
 }
 
-bool amdgpu_dm_crtc_vrr_active(struct dm_crtc_state *dm_state)
+bool amdgpu_dm_crtc_vrr_active(const struct dm_crtc_state *dm_state)
 {
 	return dm_state->freesync_config.state == VRR_STATE_ACTIVE_VARIABLE ||
 	       dm_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
index 17e948753f59..c1212947a77b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
@@ -37,7 +37,7 @@ int amdgpu_dm_crtc_set_vupdate_irq(struct drm_crtc *crtc, bool enable);
 
 bool amdgpu_dm_crtc_vrr_active_irq(struct amdgpu_crtc *acrtc);
 
-bool amdgpu_dm_crtc_vrr_active(struct dm_crtc_state *dm_state);
+bool amdgpu_dm_crtc_vrr_active(const struct dm_crtc_state *dm_state);
 
 int amdgpu_dm_crtc_enable_vblank(struct drm_crtc *crtc);
 
-- 
2.34.1

