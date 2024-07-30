Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BA5C3DA61
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 07:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E72510E4CC;
	Tue, 30 Jul 2024 07:22:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FsXh0Urn";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 510BD10E4CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 07:22:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7UMH+/HqKprtn2WeTX7tLdTcXVQElc6p9Hid0DWEbA5zNzaemRRfkSAm3JaHNdhPcuHk3zued6gHGHJb9WfGL2jc9S0Wg8Frq4RnN6+wqXtrtUSf7eBRv+o0Re0YzRD7tv+Y3ftPibSGYAnBgZXQ/Sm/VPDMMQEYLtOUARiwwoaFB9UdqsvJ0XO45lwIuQgJVcrnnQQC027kGNhawsOTPHOyraRTggX45APZrHexW0zxo1F+ky9Bm5j/mGRdjF7vafQ35U6KLtwub4JWPoCtIu+QZ+9tOM1SHYqQS5hQyk0/94qbaRAsPtFwbYVMabum7JfyynD70Qmrv5rWEoyww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujaIcxqnOExEPSo5Fs2SLSSUeUL6SGcqRoOYGEYbN7o=;
 b=TAwo0UO2679lOeNa85WNx7xgwbMvu60tmd7N7rsvn/rHYWcy1VqZWoYlyf8Be6ahKSBSAFld+w7LIbeSyrOEWBdbXXHhbNi1p3knnHTD246mUx0GsEBzKQeT5ikSGoWJwRQyY5Yrcg3MAgDTOQdjnHefuTIESoiLfCEpZSGglNfytLzLxTVXiuz6nDCmAjIgCiHexvJyqJmi6+S6dE0+EbFf/G4Y1asJrK2ZVnlrBj/wBO2pP+4LIBEzqHQuwD6ewmW19bunAA90OUVQ+kpOP4otTbhvzGAH21OuBUhTW3BCk0nv4fSEeMxN93s8eTerRFY6xbuJ/eJuhhX/o4V5Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujaIcxqnOExEPSo5Fs2SLSSUeUL6SGcqRoOYGEYbN7o=;
 b=FsXh0Urn8eyL9I+N4zEJIvOYdoRElDMqpX6szgshvaw+9gyAYMlr/5ywcMW985js0k0EfaPFcUiH/lUUwzEWS2vsWeOaA4TZBxAdyU3zgMGfu/Q9BSPe9rnoUXzjGj1I06z9Z0pBypsjppEg9+DE1+5KnRAWptjAA7gRmATfO+s=
Received: from SN4PR0501CA0127.namprd05.prod.outlook.com
 (2603:10b6:803:42::44) by IA0PR12MB8227.namprd12.prod.outlook.com
 (2603:10b6:208:406::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 07:22:27 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:803:42:cafe::bc) by SN4PR0501CA0127.outlook.office365.com
 (2603:10b6:803:42::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Tue, 30 Jul 2024 07:22:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 07:22:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:22:25 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 30 Jul 2024 02:22:19 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 21/22] drm/amd/display: Add DML2.1 option to disable DRR
 clamped P-State Strategies
Date: Tue, 30 Jul 2024 15:18:42 +0800
Message-ID: <20240730071843.880430-22-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240730071843.880430-1-Wayne.Lin@amd.com>
References: <20240730071843.880430-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|IA0PR12MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: 567dacda-7917-466b-73be-08dcb0685d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XgEW0g2zJi9u6ENzIzSt+5wpeGG5woLz4KVVZnLb/kRYAFVX4wYWXm0Xovfu?=
 =?us-ascii?Q?7FZo9GBGGcgyooPlU2k3rvJRIU1pFvtfLPvL42WVDnMZUJVLSJ2n8OqgZh/Z?=
 =?us-ascii?Q?NfsS4gMAhfW9SMxRvZSF73YtdvPWpGP/IdVk11j+gO8WtZEOKBIwjnr1b/B5?=
 =?us-ascii?Q?uMTqYQVqdJK7TQovNDzXH0SJMgPoXfIlA+EMRlLtknKkdA+qYG/0kbcArUGV?=
 =?us-ascii?Q?a6iMK9C8wvMPSo82L8AfuL3goHvqDZrI6olCN3Z1EgU/kKVrNGNSxXMHaMzq?=
 =?us-ascii?Q?ujPkto0Me+TKT1/Vy24LMZ8kbyvbxbXxcy0BJbx/uJ7xFVqqPWxb+q4EpN+p?=
 =?us-ascii?Q?zAh0UeemQKpMhJCRZGxlEkRaG6wrPXBCDVm9cIJSpPE3MTIQJKk/BOED8KEW?=
 =?us-ascii?Q?pJqWCP/YU12qTP3wDuhbGFSzN43UAW2kE3AdcqSaSMBTFHNIQZ0fBzUBKSf9?=
 =?us-ascii?Q?Rd4kPm45YJS9F8aCiNIOXSfa+cSEwk71ZIB3UHju0NpSuKHUrQozrlUD2OIx?=
 =?us-ascii?Q?Y6YJLw4xNx0cWJ54PBnSszENMAwZizsqwmVVxwmEyLSDCF0fgtkpRPVuSa+g?=
 =?us-ascii?Q?e8BpFUxPnUUktRf8ODEFamEBsNtwL43io2/0zc5uyWnCbwKfIbFA9bzx09nG?=
 =?us-ascii?Q?6AlM/jbYnnmBeGxwf7/ldLWAzmn32Q42228wstEJneuePB859w/wigkOka6Q?=
 =?us-ascii?Q?9N3qmZ8VJ5Ppr4NWEX9/LRZaEAp7IlJGgKMaYuCG5G4nNJCJ3gym1gnD/W67?=
 =?us-ascii?Q?J2rG7UXBLtU95hw8BMJMSZ2hHYAV+B+ogKm5CZingTvOsP8YeaAbcd7z68yF?=
 =?us-ascii?Q?YqKStxvu0ELog8fsiVklpSbr5Scu8HtoYAqCsFssl6/in6n2lw5ZE85DTVcB?=
 =?us-ascii?Q?lNQpQW1NsALDJedeyCKrS3bpZ892B0eQM2nkaHtGGNY64PI9g+51rCkDztFF?=
 =?us-ascii?Q?O2lFVmIKi8MxUar4l8a6VlRyoc0I8ptsJORQtI1AZ6ZCzBAaVmxDP88AYqRc?=
 =?us-ascii?Q?SuEzIYBwnxsbnjtTiewg1Id+Eu6OPsOR1CsOji68IDrLSjhBjD/zUUVt2fAv?=
 =?us-ascii?Q?HNw2r6jL+itNmoymh561tp2Paxq7gxUXx/Rsxj/gdxSDytKHJ/SK6+dese+v?=
 =?us-ascii?Q?Mq5qmyftmoFttkoNlzhFhuTi7nkc/DsVZD6DGm6xfM4Eeiu2PA/x/WnInPa8?=
 =?us-ascii?Q?V9nBzFe1FzHKal/UZsE8Yq8rsT/M1pFQsf3D76QbfXHosvEq3+QOY/qjDVRJ?=
 =?us-ascii?Q?HCsCY9+M2dPLpnX60udH1AKemKlJ/OOIYQm8DXCrYhqZDR7Lf2PkQT9cmU6N?=
 =?us-ascii?Q?N576PLt7blz0vEVJeC4u8LKrOZ7c2KumywiQadfHTPV+2aDxVRu2ZfuPCqN1?=
 =?us-ascii?Q?IiHjjLZh8WVLCIdDA8gQHTRbyG8vqF0j1GKNf/Q6artSqD2lYjRYWcJ1Az7G?=
 =?us-ascii?Q?EdYMXXSoi38dFt8LAZb8Tt1x3GARC/CW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:22:26.7340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 567dacda-7917-466b-73be-08dcb0685d4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8227
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY & HOW]
When DRR is active with variable refresh rate, add the ability to block DRR
clamped P-State strategies (such as SubVP).

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                        | 1 +
 drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c  | 4 +++-
 .../gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h  | 1 +
 .../dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c       | 7 +++++--
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b6a5ea93fd45..49725f06a2d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -511,6 +511,7 @@ enum in_game_fams_config {
 	INGAME_FAMS_SINGLE_DISP_ENABLE, // enable in-game fams
 	INGAME_FAMS_DISABLE, // disable in-game fams
 	INGAME_FAMS_MULTI_DISP_ENABLE, //enable in-game fams for multi-display
+	INGAME_FAMS_MULTI_DISP_CLAMPED_ONLY, //enable in-game fams for multi-display only for clamped RR strategies
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
index 41ecf00ed196..d35dd507cb9f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
@@ -66,7 +66,9 @@ static void dml21_apply_debug_options(const struct dc *in_dc, struct dml2_contex
 			disable_fams2;
 	pmo_options->disable_fams2 = disable_fams2;
 
-	pmo_options->disable_drr_var_when_var_active = in_dc->debug.disable_fams_gaming;
+	pmo_options->disable_drr_var_when_var_active = in_dc->debug.disable_fams_gaming == INGAME_FAMS_DISABLE ||
+			in_dc->debug.disable_fams_gaming == INGAME_FAMS_MULTI_DISP_CLAMPED_ONLY;
+	pmo_options->disable_drr_clamped_when_var_active = in_dc->debug.disable_fams_gaming == INGAME_FAMS_DISABLE;
 }
 
 static void dml21_init(const struct dc *in_dc, struct dml2_context **dml_ctx, const struct dml2_configuration_options *config)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
index a824ce56c54e..1c773bbb9992 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
@@ -74,6 +74,7 @@ struct dml2_pmo_options {
 	bool disable_drr_var;
 	bool disable_drr_clamped;
 	bool disable_drr_var_when_var_active;
+	bool disable_drr_clamped_when_var_active;
 	bool disable_fams2;
 	bool disable_vactive_det_fill_bw_pad; /* dml2_project_dcn4x_stage2_auto_drr_svp and above only */
 	bool disable_dyn_odm;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index 9c6397aafd38..06e786995390 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -1441,8 +1441,11 @@ static bool stream_matches_drr_policy(struct dml2_pmo_instance *pmo,
 		strategy_matches_drr_requirements = false;
 	} else if (is_bit_set_in_bitfield(PMO_DRR_CLAMPED_STRATEGY_MASK, stream_pstate_method) &&
 			(pmo->options->disable_drr_clamped ||
-			!stream_descriptor->timing.drr_config.enabled ||
-			(!stream_descriptor->timing.drr_config.drr_active_fixed && !stream_descriptor->timing.drr_config.drr_active_variable))) {
+			(!stream_descriptor->timing.drr_config.enabled ||
+			(!stream_descriptor->timing.drr_config.drr_active_fixed && !stream_descriptor->timing.drr_config.drr_active_variable)) ||
+			(pmo->options->disable_drr_clamped_when_var_active &&
+			stream_descriptor->timing.drr_config.enabled &&
+			stream_descriptor->timing.drr_config.drr_active_variable))) {
 		/* DRR fixed strategies are disallowed due to settings or policy */
 		strategy_matches_drr_requirements = false;
 	} else if (is_bit_set_in_bitfield(PMO_FW_STRATEGY_MASK, stream_pstate_method) &&
-- 
2.37.3

