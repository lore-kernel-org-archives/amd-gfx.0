Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43689CD4F26
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 13:32:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF2C110F5E6;
	Fri, 19 Jun 2026 13:32:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z6Cfp4f8";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F47110F5E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 13:32:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIICj4DNPNgzNpDE9O9/+HEj99kyUmp5fm1bGqY+6S6qNzzeuCKg3+/UU72NYM18e/Zw4bsB/CSwIDa5aTEvlysP+7dlSz5wrJWlqRd76MnKcyGicuiccnYpRRGzC9OH2UjpqPsGugFQvkCvqDIkC7t0d+O9f2tLwlLtFYbfX7Yq+T4HhRaqRvHk+xn1jGqJhXKMm/DfRaLtdFHWdL+61+811W36Q6VE7J3zkJoeUkcU2QpFwlybkZ9BgIAp/yO9+GytFIYd+iDsZKCamB2t9aQMpZyYUU1EdRn2ME6TWqkh4879l8/IBjP+ZS28lqe30kVjWw1YSWfIZLSNg6mgTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=du3nCOuIGLA8XGvOLWtMdM97PkAiFkltaZvGzRKfIZ8=;
 b=dfI4XqLZEhhDjEMplSYUk/zW2Igy5LbuE6m7eQdfbF/h6MgyeK37iGESkl+hK9S9w0wMqn83Mqxcv6VUaYeeyL/pVoyK4SgMJ67M2oBlGP1DmTXQVR4+9hCW3oGCDeu3WW/zcKIBoWDikpXb4cBGufiXBqVbZXq5DLcIJG/DpAOUUmNgNEdmYQKs1YOPwuEtbbOMaz+lWig3J7bnJTTMQQIG2/LuY46PUo4PPv1lIz6wnHFDEwV+f5SYP1oArXKgngwmosW4tx3xG27IuufC183OiuNYI/CwU6Mbr+yFR9H+tyKH+xmI4eet2kqxYwTTD8/HnyX0oy52dnZX5X4dUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=du3nCOuIGLA8XGvOLWtMdM97PkAiFkltaZvGzRKfIZ8=;
 b=z6Cfp4f8TKvUTmuAdeZfBDkxdaJqrwYRutd9u0qT9g3+EamzTe+mLDZdIFUmFOJldjnLD1Zk5eJTHcnw3/1rdaMxcH3jRgj0n0pM/+iD/qQ8f89n+wHF8Zz5MNtUdqbZp+58BFWFEyvgfiA+gxwD01lsGHhQNdJ288iMuCfqsco=
Received: from BN0PR04CA0192.namprd04.prod.outlook.com (2603:10b6:408:e9::17)
 by SA3PR12MB9228.namprd12.prod.outlook.com (2603:10b6:806:39c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 13:32:27 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::5) by BN0PR04CA0192.outlook.office365.com
 (2603:10b6:408:e9::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Fri,
 19 Jun 2026 13:32:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 13:32:26 +0000
Received: from georzhanmkm (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 08:32:25 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 10/24] drm/amd/display: drop redundant colorop type and TF
 checks
Date: Fri, 19 Jun 2026 09:21:25 -0400
Message-ID: <20260619133154.116746-11-george.zhang@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619133154.116746-1-george.zhang@amd.com>
References: <20260619133154.116746-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|SA3PR12MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cd48617-763d-4731-7aa2-08dece07342a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: NMbuPSBBo2+oBRc4OMJ+nq9FByQA/8nT02zcu/kFWAg2otJgsMOMTj7dSVpVXzH2oKR8cn3ATKsZCEqDNec7X7zjyBibuG3uAGQHmu0FmkWHVgIV3aR7NqVZ6pCxt2MFIa0p1lBee8qi60bCm+IJbgp8VUN/qp4KVZW+qtNe8RjyVXnYebidQoYaA2GLC0dnj8subry4cAuHBrQQYbkkYLapvCPtqBPF5TKGMhmEzRThDYbJHmqG/PqggMUM/rhiPv4esJXsq/n65v2vK6EKnjdSoo4hkh+olDkF+6HZuCyqcadkwm2TN4K1AE83Uil1rxqyAihVtki0ksaUFkWXN6WzbcbIe/fsReBjQjoBJKTmch2hWnj4vb4VbjtnOKMq/PAKES4qAOV9SKFz6f4lfpzOdIitXVsDE9YhnHvCkSOi1LRFs28g3YyYqTfZTexvEtQnEhEOI6YBrxWGohsvhNGSgGgm6FXahEC+zEuG5iwH2xYD7ppAKEkmPxGh44S2MDrF6OHauvYXaL3XzYpNO11B93HDbjbgqKcU7MRvzxGzFoBnE+8cKQLqt4ePRw05EJAb+Q9mLA15xIeqtCnzEHKNU1KyjqsHMbzeo6vM/5/twLaNZfLlqLr/CNtIRR211PV1BgbzQ3RWK/wTe1sCgZomcwL0YSqmiRqA6V+5vjMte0I9QXdC5YTWE1bNLWY4bKILBt6eR6TJn1IeYueLfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AnTbLjT+jFtGLvGaios6eapVrJPD4tQ/TO8Pzm61mPpxXm8KeDbFYJScxpaIcCFFYFZQMKJmAturQtNF6AMVk8aask1pu+0C7AV5TBoR2x5cxkxAFWummiO8fY0NWnjs8JWp7JEtN5KsnyOQQ0D+WjYC827P1gB7wAgxsScxBWqFfivVAOH8gUkGzfE7q9XDh9ta3TlXhI2fEJ6nxPTKjtEu5rtAY3qOnKlKm9IVOIRZEBaIlaxv7CRYw/H6DE8NtPni4OenywvKDN+eRO4F+JkGUud8K1zpZrwbi93GbIP9Y8FpIQ6ibw+cN9E6HDRpR/KRZrH4zMDi03yyhOwg3YTsGfUsdmkPs73zB8dvR06+9Gf0zhavKkKxkwPTWG+NALwrsaiJfCM0WclnIGk6LekCDxBDlMi0WeM8nSLm2SU/8PpPlB2PT64LNa10+Uz8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:32:26.8089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd48617-763d-4731-7aa2-08dece07342a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9228
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

From: Harry Wentland <harry.wentland@amd.com>

DRM core builds the curve_1d_type enum property with only the supported
TF values, so any curve_1d_type that reaches atomic_commit is already
guaranteed to be in the supported set.  The per-colorop type field is
immutable — it cannot change between the loop that finds colorop_state
and the if block that uses it, so re-checking colorop->type there is
dead code.

Remove the redundant checks:
- colorop->type == DRM_COLOROP_1D_CURVE in the shaper TF if block
- colorop->type == DRM_COLOROP_1D_LUT in the shaper LUT if block
- colorop->type == DRM_COLOROP_1D_CURVE in the blend TF if block
- colorop->type == DRM_COLOROP_1D_LUT in the blend LUT if block
- BIT(colorop_state->curve_1d_type) & supported_blnd_tfs in the blend
  TF if block (already guaranteed by the loop filter)
- BIT(colorop_state->curve_1d_type) & supported_blnd_tfs in the blend
  LUT if block (nonsensical: a 1D_LUT colorop has no curve_1d_type)

No functional change.

Assisted-by: Copilot:claude-opus-4.8

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index a9a741c21663..724b7729f342 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1660,7 +1660,7 @@ __set_dm_plane_colorop_shaper(struct drm_plane_state *plane_state,
 		}
 	}

-	if (colorop_state && !colorop_state->bypass && colorop->type == DRM_COLOROP_1D_CURVE) {
+	if (colorop_state && !colorop_state->bypass) {
 		drm_dbg(dev, "Shaper TF colorop with ID: %d\n", colorop->base.id);
 		tf->type = TF_TYPE_DISTRIBUTED_POINTS;
 		tf->tf = default_tf = amdgpu_colorop_tf_to_dc_tf(colorop_state->curve_1d_type);
@@ -1687,7 +1687,7 @@ __set_dm_plane_colorop_shaper(struct drm_plane_state *plane_state,
 		}
 	}

-	if (colorop_state && !colorop_state->bypass && colorop->type == DRM_COLOROP_1D_LUT) {
+	if (colorop_state && !colorop_state->bypass) {
 		drm_dbg(dev, "Shaper LUT colorop with ID: %d\n", colorop->base.id);
 		tf->type = TF_TYPE_DISTRIBUTED_POINTS;
 		tf->tf = default_tf;
@@ -1833,8 +1833,7 @@ __set_dm_plane_colorop_blend(struct drm_plane_state *plane_state,
 		}
 	}

-	if (colorop_state && !colorop_state->bypass && colorop->type == DRM_COLOROP_1D_CURVE &&
-	    (BIT(colorop_state->curve_1d_type) & amdgpu_dm_supported_blnd_tfs)) {
+	if (colorop_state && !colorop_state->bypass) {
 		drm_dbg(dev, "Blend TF colorop with ID: %d\n", colorop->base.id);
 		tf->type = TF_TYPE_DISTRIBUTED_POINTS;
 		tf->tf = default_tf = amdgpu_colorop_tf_to_dc_tf(colorop_state->curve_1d_type);
@@ -1859,8 +1858,7 @@ __set_dm_plane_colorop_blend(struct drm_plane_state *plane_state,
 		}
 	}

-	if (colorop_state && !colorop_state->bypass && colorop->type == DRM_COLOROP_1D_LUT &&
-	    (BIT(colorop_state->curve_1d_type) & amdgpu_dm_supported_blnd_tfs)) {
+	if (colorop_state && !colorop_state->bypass) {
 		drm_dbg(dev, "Blend LUT colorop with ID: %d\n", colorop->base.id);
 		tf->type = TF_TYPE_DISTRIBUTED_POINTS;
 		tf->tf = default_tf;
--
2.54.0

