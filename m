Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FA0C36010
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 19:53:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68FFC10E78D;
	Wed, 26 Mar 2025 19:53:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="40vbPqtE";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD48B10E78D
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 19:53:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpZRydF9zWY25G6FFCk8F+mwkZXIo/UfP7X+B7khRsEz/fTwdHp6THcswS7r+Z3XdzMsBk7zGs2DVjQ1srPnT+CdgcutuBS+qI42q75TGQsMIexSCAhYb1LKvPSJr0J9KFH4Akx87eGSlXRZ380esa+S282cQ+aZ681P52sFnUgWvMMPi+8Ji5+qdI5LnKmKy9oTCuBzNt1DbYv/pwE3BzXyORR6jbyDNvHyJFyHzDEXoljZL6wK2zbFpTOWxnZ96e3hCtumbt4paLhq5P28S0OLVyN/xzoW3lwIt4se9MFTxZmp4kO72zE+/vlAvw37/NqfkhBzUUfMCTwXQ0DqNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wakuwvdxRLAD2C/KIzWGsowZ5cgsbatW1Odkc41yKvA=;
 b=t3dXx1+kzh7/GSnMfsP1dMrUV4pAFxOWIqZ7ta8CZmrdewWVnKcP4S7rtdaRqjuOX3qCW8PrpGLNeak/D3R4HRRph999i+Rga8fNj0m/wtJYSGSfcsEE2q5l5Z+CMZMlk5jlPXEs7Pjdk2SzzuGcoyGSrxuU9IZkSZuRhL2P+PM8hHaVFPgKb5yD1LEvwPIMUAim7dLvm0+lclTEJ0QQI+pbDZ/Lu4ogfqsyEO5BuSHwm3+rj8G5BRSRlNhiOsVRwf2JM7dOn/p+n6MoMu9gG9Q6hGzD+vKq1DAZttmbtsU6sCU1BW3sx+APSQBPXVEdsAdOqzWZ5A8Wr3teaMl1JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wakuwvdxRLAD2C/KIzWGsowZ5cgsbatW1Odkc41yKvA=;
 b=40vbPqtE2uomnu1n4C5jmpQHZgu9AYPQzqaF9XsLCABn45QJStTLovlHt3qJG/tFzOJ9GiyUMGHB9F3/I9UTYEspKL8NmgNepMO4sJ20X1XuPux9HwGBfX2eY07PfnPPc+LcKjVRVS6fhs/IDVx+AAoqkNu2OPgF1UdlleG4Szo=
Received: from SA1PR05CA0003.namprd05.prod.outlook.com (2603:10b6:806:2d2::14)
 by SN7PR12MB6767.namprd12.prod.outlook.com (2603:10b6:806:269::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 19:53:27 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:2d2:cafe::f) by SA1PR05CA0003.outlook.office365.com
 (2603:10b6:806:2d2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.26 via Frontend Transport; Wed,
 26 Mar 2025 19:53:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 19:53:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 14:53:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 14:53:20 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 26 Mar 2025 14:53:14 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH 13/17] drm/amd/display: Do Not Consider DSC if Valid Config
 Not Found
Date: Wed, 26 Mar 2025 15:49:10 -0400
Message-ID: <20250326195202.17343-14-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326195202.17343-1-Jerry.Zuo@amd.com>
References: <20250326195202.17343-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|SN7PR12MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: b558bdb1-74b8-4407-bac1-08dd6c9fdcba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fJ2uO2w5jGDkcyNKcS8AW4AuTyneB7SDQ0ewcE2Z2aj4E+Gvw0jjmVqQ+Bf0?=
 =?us-ascii?Q?Pm24oYS3jZd5LMeEcbnwD4mQ45V6wlNK/9kZpaSSdoQDUBc43nNwMDE73oNi?=
 =?us-ascii?Q?smglxaS0h3VtRj2dnhp1Vtqy271LDfP8NHjlLSBymNUythNVeZBzJZ51LwyN?=
 =?us-ascii?Q?j3p+GzNRxmmTkFU7TL1hxuOJ3REPOiPuyl7OaVGvjatYU5dvRPLQB5geunKB?=
 =?us-ascii?Q?zMo0sDjqI3eJfNVF32OyTFcqKrjC/20sO90rspFBtW7Yi9UWV1FY2c3TzT2t?=
 =?us-ascii?Q?vCAmdhR1xdLnt4wUc7XH4tVPgdKHsdyjvhtXi6MOFX1fIc+n9KrFgbQIgMLT?=
 =?us-ascii?Q?/CnBst2XMvKgJFiEeMqX8saFn12KDqvBiDM1whAAHfepzt1uY4i2JWVgWNgU?=
 =?us-ascii?Q?nhUp8B1EFqzhTwJIk+lu0lHBVegfFarWEQYQQJ1Cto5klCdJQRbcMZfDnxTx?=
 =?us-ascii?Q?nhWORhJFm+Waa7v6dHGNy4JqsQ3WDnPXDZNbbWNUzJSSHEi6eVfeLYFXs82L?=
 =?us-ascii?Q?mAww0igYA+5jwYhJnSGG+bedJ2EQsHVBANHN1MGq5/IMkiU5ffNcU1ncQKFF?=
 =?us-ascii?Q?fyliXKrL8Qh8Px1PmsXFDPXBEYObXfELp0jzGwcdqf2P20qxYlE4/qHjfIoe?=
 =?us-ascii?Q?PCnqHxfwxAOWa8GuA5fbmMpM/lEQdJErySDwDKjGWGNd9XsmAnwMAPFbmWWQ?=
 =?us-ascii?Q?9e9zw4O2tLjYtz0bUaqfqmcW9+xnaHhqpb88sBCZ0H1EqBe2TzSZeWL+WT8z?=
 =?us-ascii?Q?1AvoyeU6SZHgll3ObmpA6hCqEC2OZdxjxo6HN74Qy6EGZHUwL5Fv7VyLMuPe?=
 =?us-ascii?Q?UTLR4ttntjGa/Ls2Le9irbYE13ZcnSvoAeH8AFxecGd3hECDXkBJXrT978kN?=
 =?us-ascii?Q?JsFsNSP+TvXatF5KrDSzyb8KDo6pwvUui/Z9pEyQqoQsD6dlhJdu8d8nAbP+?=
 =?us-ascii?Q?bdWTur22+fKwePkPlmjUgt/ryVGgJ0YztbV0Q5Sz5exILvxKyaPNhwAoRKsW?=
 =?us-ascii?Q?c3jdClQ86CWUBMptAjqoYrb4sQQJ3EypLPC1ad8HqD0Gxil8yswkRUwrV9LO?=
 =?us-ascii?Q?am5toIe1MjdW6AXh2KoGyjtWuPrPMDVET7ryT6Z5SPUfasz/AG0sbH1lFFBi?=
 =?us-ascii?Q?ZTSiFzBlaTmvOVQ+5FvRocByeK4ErfRYatNna/SsffSHldqSGPwSxG8L6nAh?=
 =?us-ascii?Q?JS0cpTgwobPi81qrPNzCJ3voIhZd9ZvEhC5cAZO8f5s2ChDJbBgsrxukr/Rf?=
 =?us-ascii?Q?Ffe1Om56aGqKy5jiS2ZQ1GQacNUJd1y6cin/3V+fS+JDCG9kmV7IklwlMALm?=
 =?us-ascii?Q?xuZxOoGGnazugkDFqZtm8ALUk07u0DgkyAURChw2RguR711OwTQ2/UlK3dKM?=
 =?us-ascii?Q?1m++uFFsf4H0h33PUwi99StqF4E3zf/8zDpgLYgN9F+lcRjl/KEqdpu3vEU4?=
 =?us-ascii?Q?ZQ/2ckt1q0t1ky7GLTH0PSAMH/Bp4tZxMZ71kDP++1oFX0tWhBUEIrbmiQiv?=
 =?us-ascii?Q?QxanvMIoWy4GF3o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 19:53:21.3897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b558bdb1-74b8-4407-bac1-08dd6c9fdcba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6767
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

[why]
In the mode validation, mst dsc is considered for bw calculation after
common dsc config is determined. Currently it considered common dsc config
is found if max and min target bpp are non zero which is not accurate. Invalid
max and min target bpp values would not get max_kbps and min_kbps calculated,
leading to falsefully pass a mode that does not have valid dsc parameters
available.

[how]
Use the return value of decide_dsc_bandwidth_range() to determine whether valid
dsc common config is found or not. Prune out modes that do not have valid common
dsc config determined.

Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 5c956b9962dc..075e8a5be47c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1712,16 +1712,17 @@ static bool is_dsc_common_config_possible(struct dc_stream_state *stream,
 					  struct dc_dsc_bw_range *bw_range)
 {
 	struct dc_dsc_policy dsc_policy = {0};
+	bool is_dsc_possible;
 
 	dc_dsc_get_policy_for_timing(&stream->timing, 0, &dsc_policy, dc_link_get_highest_encoding_format(stream->link));
-	dc_dsc_compute_bandwidth_range(stream->sink->ctx->dc->res_pool->dscs[0],
-				       stream->sink->ctx->dc->debug.dsc_min_slice_height_override,
-				       dsc_policy.min_target_bpp * 16,
-				       dsc_policy.max_target_bpp * 16,
-				       &stream->sink->dsc_caps.dsc_dec_caps,
-				       &stream->timing, dc_link_get_highest_encoding_format(stream->link), bw_range);
-
-	return bw_range->max_target_bpp_x16 && bw_range->min_target_bpp_x16;
+	is_dsc_possible = dc_dsc_compute_bandwidth_range(stream->sink->ctx->dc->res_pool->dscs[0],
+							 stream->sink->ctx->dc->debug.dsc_min_slice_height_override,
+							 dsc_policy.min_target_bpp * 16,
+							 dsc_policy.max_target_bpp * 16,
+							 &stream->sink->dsc_caps.dsc_dec_caps,
+							 &stream->timing, dc_link_get_highest_encoding_format(stream->link), bw_range);
+
+	return is_dsc_possible;
 }
 #endif
 
-- 
2.43.0

