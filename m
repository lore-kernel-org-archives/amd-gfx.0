Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432A4C55177
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:15:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3B0E10F405;
	Fri, 31 Jul 2026 21:15:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CEAoEbv5";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B39C10F408
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:15:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUxkDgPybWibQO2sUp8BkHg/oKPIjbEcPTU3EkwvA/VGF1HjU6y/eC0mPLpQdj0uRvcv0RCx8e40hgvHZ+8K08xa6GhokuId8qMEf6HLIvzalACdXwDpKuUScWB5RavPIrlKFS2YgKnQfgQ3c3DAxllig33SVPEQ4LNb8AQpxw/ZzV9S4ViGU+1diWxdXL3Wa7B/D/Q2lLY8gPc2DrgF1v2iLA5lJCVEg+kZWK2yL7a063/EllpfYVfeIsRuM5nxYH0JsR1DBtPGMmjkrSMrtXJ3MINnog2Y+dSglX5c7GhLaMU7OznDxGztmNvXdvo6TrpL5WomJA+W/sJXFvF/7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElTpzbT9X4clgjhxLvWfl5UZsR5IBwPfoyX/hJT6QuE=;
 b=symyXIgmYFAp/cr/9FrPQ2ODTue9Xn6qd91hQB6a+MCRZWefthKLRsHKfRfJPfhmXtffyQ/zvqdrhlfAhh/gxoDu/Enq7NJv19HMB4PDYVXoNUj7rIzXXbyjzsS/74O7EcAkggp+khSWc8gxBCB5wxqvvuUc4fYGOuiOTA00Mc6UcBdaZuvHSsRzl89s2Y+53m0ktpEYa+En2enwdbHCY9voPG/xp1u4GHY/x2lT8jetryXGTxYOB1x/AYSj6Gj7HyaGVYi6fgXAoQSYFLxR2wnuG13oCx0SoVIghMLIpXjM/Ll7gU+YC6hi8+4P8SlQmU7CfHpWZKOBMe4eWukb8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElTpzbT9X4clgjhxLvWfl5UZsR5IBwPfoyX/hJT6QuE=;
 b=CEAoEbv5PhA/5ROqhNyIIyULNaimwdNZEimFiH1XenpmHMrn0ngUTWKyedsuQu+CEnR8tFjwcfpv01js2+DyOvF3QIyUQjzRVBSYD1QQBUGnFcGhq9PnfZFgAQhpYSFwgNj4u4ZyNzMVNYD9+ecIVxFmzNud6RVdBH38Mgf1hiA=
Received: from BN9PR03CA0254.namprd03.prod.outlook.com (2603:10b6:408:ff::19)
 by BL1PR12MB5900.namprd12.prod.outlook.com (2603:10b6:208:398::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 21:15:37 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:ff:cafe::54) by BN9PR03CA0254.outlook.office365.com
 (2603:10b6:408:ff::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Fri,
 31 Jul 2026 21:15:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:15:36 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:36 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:36 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:34 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 08/41] drm/amd/display: Bounds-check connector->index in
 dm_dp_mst_get_modes
Date: Fri, 31 Jul 2026 17:12:29 -0400
Message-ID: <20260731211302.3040343-9-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|BL1PR12MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b6c4ea-8640-407f-9b90-08deef48dda2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: YIglvbZIIdpZ73mEnMu/l4QPMAqqsWZ2B8uOAUM4raRhwt7/ggmm1RKGCiktQDUseI+jnHQIrrl+e6eXwSizJmXsdZCKfU1B+m/8xB3pggFeRPjlhgn2WK1oK8g0XW/VV2BxKYoKO0Sb+Sy2E20HPbeOBOnK9y1RnCwNT6YWUXwWxB+WZBuQ/JV2tzA14oKRZpnhbeDx19W6p37p3Nbe111720MhRf7LxEY5AEpG8v9jmcJRZaDQGuD6IGDvPcpkw2cxnEEw97836fY2dJoVfx8G3E/8id0sQfaKSfpvWO2k22CI/5MD7E8+4+oHA4tOSa1iPyxBWO1ztQdGxD1zf5zLOqbmui8pYA6Wv2dKw+E/59zqyHtTvn7bUhp+ZgheGfqO0d4ojK49tr7HwyLtFePyn7YWANSZFc8yXx4eRuus9nCV+APNCrieLBxfmNMa4e/pMA0+CQDhgpy9VtX0ekzbQMepA++bZnvE6ppay7G4PMNb7kIVm/LYmZKqocBd2s/BKkE0llcOIo16a3JiB4QEec3CPkP2X6faVlsWZx5bGOzauBNv0OqDE4MENn/7jtSHkbm8/Se4DGrgJ1+VVFo0gm1nAY8un4ykn8rRMWeucT1GiTUWzQWtx/sLC1ktwEN86d0fUdx3AnHbpzgCuQh1OmLKo97eU/cYCIyOSZgpzg0mgbRL02vVroN2ekcGEvLfDfWWRlTEM7PITV/MAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MytJmfYM30AuhYu8/Teh2qPGF92dLwAw7dVWXLAGNZQundXR+eWYEAWt/KMjmnltLcgC+CWuLsU7D/ERB4IApxA5W1kw0FdK9cay9ZA5j6NyhefntsBfxN9YEm1HpLfNYtBe4M6EBFXI53sR2cVNSYU+iKiliw+Ao6KMLpBQknEOpqjipEvQDpqEt/FoSCjoknLH4RI9KgOKq5dTI2UJeuyVKu5eL3doMidc7I+3kVT3POT33QVsp3QPVnGkSz3i0FiRs+jqDOQdCSJfE+blEEfpunGeFcexO45iYAWosRwxsO2yWn+T8WYhKFYLVMavPBSVp3V5eLuFMIGfQvPcYBaVFNtNktrjyrf29A7tL5Zoc3OtjvxoyDcFPeSTs2ZmOY7hTeTjzsXPhpgA3voUVSsPgqLzdryuue487Qqij+ozVSFIuxtMyxVWbU8397Ph
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:36.7851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b6c4ea-8640-407f-9b90-08deef48dda2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5900
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

dm_dp_mst_get_modes() uses drm_connector->index to index the
per-connector HDCP arrays in struct hdcp_workqueue. Those arrays are
sized to AMDGPU_DM_MAX_DISPLAY_COUNT, which matches the DRM connector
index range (0..31). Add a defensive bounds check so that, should the
DRM connector index range ever grow beyond the array size, the access
is skipped instead of reading and writing out of bounds.

Assisted-by: Copilot:claude-opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index e001d868db80..045a7f88b754 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -485,7 +485,8 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 			struct drm_device *dev = connector->dev;
 			struct amdgpu_device *adev = drm_to_adev(dev);
 
-			if (adev->dm.hdcp_workqueue) {
+			if (adev->dm.hdcp_workqueue &&
+			    connector->index < AMDGPU_DM_MAX_DISPLAY_COUNT) {
 				struct hdcp_workqueue *hdcp_work = adev->dm.hdcp_workqueue;
 				struct hdcp_workqueue *hdcp_w =
 					&hdcp_work[aconnector->dc_link->link_index];
-- 
2.34.1

