Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3460AC5B572
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 15:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD46910EC81;
	Tue, 11 Aug 2026 15:48:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BQUXXV/S";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DD1710EC81
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 15:48:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gp7xKK8Ipo3HidAeCK3qdNvTNqTDl235JjmaphRYLWhv7RyW+dAF0ZOEEggyU/dLXoQ3Vgimvd2sc1lcSGH+Q3E/P5lDc835FHYuRQp0QQWT28yUvMMoeoH2QTJCl3tsNjA/H7/CJ9IcEfxy+iw8j3z3TjXffId5CUCXfqz8peryT5zbcisDQ3xIG/P0zpy3L4svFSTrgp1uD/sONBnXJpnfL/NFFz4Vfxr6a4tySKuPX6bCuBxPqfi7jmj0ot2c//T0HVmsYIp/9K1Ynay9To2CVle4ikPXogqkcXWJsJWXxAi77GEpuYcEwU2fY9tzOihV1qFosNuI7hoFbtKK4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2p0H1kkhz8aMKQhp7HxnZKS50zEIVlexQx54+P6opA=;
 b=ZzLIREqeAn3R3xpiebQ3bK/VeJoqxbsc2a2Wa/qJ6uKB2iqd/S2tjzWl/NkgKF6x6IwJzj/OPkLl5mEVqVDaOKfsuQTP5/oQa/zwOUOfPY7zV1X4A05bkd9NWXaSs0Rtlphnh75Um4C3MXCsVv2JbYjQgKT0/W751DHTAWtaL85r5xM/3EP8dflpAYzPLAlNCnkd549tHx4JGrKebjb568is9vkWBJGv4tUcPyEdXWCULyi/pxoFIfxkbaC5mduwiL0tIxAgx2JYtefK5HH3BIDDsnjsGonWw3ZaijPXco2q5R+zyJMaVeueiaBan4WGWUTs9tyHWDDckOLuamrrZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2p0H1kkhz8aMKQhp7HxnZKS50zEIVlexQx54+P6opA=;
 b=BQUXXV/Sw4uxgRGs7PJAcn0bwUduOW8o79n553iQm/ZylZVUVH92MiyvQteg2jBPdlOjev+7LDdRkCl0N0Tt67bP6bkIDYyOxF/q1ILviwLznpCy5O9gHPs3/NJRByZ+IgCHkp03kO50IkLSXRjfrGOxWvmMBH6VSfcN34mitvo=
Received: from CH0PR03CA0385.namprd03.prod.outlook.com (2603:10b6:610:119::20)
 by SA1PR12MB999083.namprd12.prod.outlook.com (2603:10b6:806:49e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 15:48:38 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::6c) by CH0PR03CA0385.outlook.office365.com
 (2603:10b6:610:119::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 15:48:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 15:48:38 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:48:37 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via
 Frontend Transport; Tue, 11 Aug 2026 10:48:28 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 03/24] drm/amd/display: Add missing prototype for
 amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags
Date: Tue, 11 Aug 2026 05:28:37 +0800
Message-ID: <20260810213010.1703162-4-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810213010.1703162-1-PingLei.Lin@amd.com>
References: <20260810213010.1703162-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|SA1PR12MB999083:EE_
X-MS-Office365-Filtering-Correlation-Id: d12a3a05-b1ac-4922-2b8e-08def7c0029a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: dvt5oaiaA5MMUYjTlnuoYH/ouv9NYxjhKOLYXV2dnM+zgpbCk4kIKFtSwTxucMxdPUqyN54fWG7kq7kJw2HpuJIRUshPMSXhfKnxp83ISmGOOjipixqihXljmG4qMX6V9wLHNMoykEsHb14LtVAEUeBLYLhmwVNCejNWNZRlF0yoD901CRB1byiffsXjuN9uD5TL02/Ua9H4li+gK97EEctmB0n0dg/x9wJGGFHx9oYtIBhk++bphzEyLRlgHgEHatW4dvwk/5r2/9uuQCjFdrgRtN/s8d5ZTa41525yD04Jx3/snSBlFi1BkJ0eauI5rGWDZeoELUtF3bZ9U4UIug29FoOrQv1upj33O5bLORK6L/KzooRLLjfDBNNiGNYMB7Y0r08IYfjc9yMM5RIo2nX9h6SnDxMnVEl6K7BRQ8BPTiCoRRcNsfvl40e6eZy4lOJFoma1jGeISyBtwWKD470TxH2hAPYwi7F4GnVcNRcsvcN2AdOXiveTX5prhNcj9kWLfxcppiRtB6j61GQW/BmLF9Z2TUDco6cCL66D0AXyMlpvtq7yCs9M643hWwjgZP3QHtKXOQg8gU7lP7ot9DgAqKI5k58hriqPOa0bgpKdNCvzksdV7yoIAHLJAOTwAuwWUzlUrZFKhhWKczkHZ9jlWDzwu0xRrZMy8RdbxzHnNLXUZEeJFHN+4qMmSusPQZ/iwSVbyW2jJ8eOLWyURw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: POh2gkJ6/Kh7SBpx83miluJyVJuhjrpzbwmH1urScJMi8Oy/ctzy912hjDm4zW5ncFRZ0sr0O8mpbo0gPhAAiDlbFM4KxsYOqRJ3JgznIgOvoIfN3yplwu768M7xF9GmAAdfhev9QaBLgMbMbTPA4mGImNPr/9NseN3CHyr7k/xyp74L2RO/08snDgSuQ8AzA8simByWZpj85Is7LNzbILdHNLpFl78i8HJQIDeitV9M53SbzKtGh48DoF+Ms0vTDhUV3MZQxq3g56RMps+tXWSLFZccXVE/R27rHTpSQADq2xKC1DH7Ul+Sl9P5hUDR4L1vrFBzUuo3b5d6vVRsId5P97E7KXqiwmjuSFcHVEoOArOlLvzW72VJGoCnmyuQ4LJlsB3Ez9kYA3d1Idh+fEV2tOcVqzNyMd8HBLkN7ZFb1bHAIKUkJ1U4drBakodO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:48:38.2070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d12a3a05-b1ac-4922-2b8e-08def7c0029a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999083
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

From: James Lin <pinglei.lin@amd.com>

[Why]
amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags was introduced
without a forward declaration in amdgpu_dm_plane.h, causing a
-Werror=missing-prototypes build failure.

[How]
Add the missing prototype to amdgpu_dm_plane.h alongside the
already-present declaration for
amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier.

Fixes: 4ff8ab874a6a ("drm/amd/display: Support DRM format modifiers on GFX6-8")
Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
index 092ade738ce9..323872d984ee 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
@@ -123,6 +123,8 @@ void amdgpu_dm_plane_drm_plane_destroy_state(struct drm_plane *plane,
 					     struct drm_plane_state *state);
 void amdgpu_dm_plane_add_modifier_dedup(uint64_t **mods, uint64_t *size,
 					uint64_t *cap, uint64_t mod);
+void amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(struct dc_tiling_info *tiling_info,
+						      uint64_t tiling_flags);
 int amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier(struct dc_tiling_info *tiling_info,
 							uint64_t modifier);
 #endif
-- 
2.43.0

