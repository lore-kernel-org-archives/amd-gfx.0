Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D71BCD3424
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 07:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C1E610ECDE;
	Wed,  6 May 2026 07:04:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1uZOv5Ur";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011010.outbound.protection.outlook.com
 [40.93.194.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 569FA10ECDE
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 07:04:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fcp7rzHzhJbAPFdh+GSKU3AMiPFpQYcFYFMSKA1FZkMj0DNowB9xuPjLDk9YiO6kdj1fCXzGjYWrt8C45qzCosD0j1n8WpsqSO5MIam0Fgbp61jqFG27iI3DvsVU51nAqtD8/xoIxNElxLcFWSbLPSyH4a0sKwqFkRxB4oVMgwr+xA+gPnmP38+mjWUF5YIUDZ7ucIvFueK6ZLsUWj07BkgBE96ppDAyhZ3+A7fClDp5oF6v4g/fNW+RXil3G2T/WynMs+YaF6Qm/E3YfsAwNP7bxIqbev0irFjYaR3UQHolo7fUCHqRMzfBsoBYBWiwhQCF9JkXDWvAP51ASms8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0caNdV3bkIJXdpgpVqfCeCWkTEDKQaNE2yBz5BFygo=;
 b=WazgFpkiHIneLiifGxdJUWZPkpIZRGS7wKE6PD93LHCaP3tROJhD3R2dhHonEcSFX+SRaWHQYO7dbI3ZImgS99XfMKES2aNVQa1UHacuFyiqq/CR5MCI6TBWpRAmih0jybgH7nax5TG16HKUAmMWn+yfk/543RHe55nNqQlbg6G8InF4dnXir7f3+V5Y7yAmtLZ4euLHRc7vMYwAYJYuuVbUDNhKPitLLtLUuKFKptfiXoaVqawaJlpGR/GOXhvRhc76InPYvFEt9ZpaKeCLWfEShPDDlRw+d5QC2S3FTN73eNtFf1XyqK4gdHTKXmTGTwayjLZ3nKdvJk8TABS8yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0caNdV3bkIJXdpgpVqfCeCWkTEDKQaNE2yBz5BFygo=;
 b=1uZOv5UrZRgXmBPUvo0RVMpdng5VdvyR+PBRBE8vzKr7FqYiIw5gz/wBh4/EcGGm/aBHZ/aqdLOBrUnDMQOlrboNBpq4xMvM+fsaGAe08S6wW8NzEnk9WQZGXfjUxs44ozzxNsg+jRJ8SeQnm1IdjaSlvyihqDLfbRoXaxlC9no=
Received: from BLAPR03CA0004.namprd03.prod.outlook.com (2603:10b6:208:32b::9)
 by DM4PR12MB6375.namprd12.prod.outlook.com (2603:10b6:8:a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 07:04:39 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::bd) by BLAPR03CA0004.outlook.office365.com
 (2603:10b6:208:32b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Wed,
 6 May 2026 07:04:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 07:04:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 02:04:38 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 02:04:37 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Wed, 6 May 2026 02:04:29 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>, Aric
 Cyr <aric.cyr@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 10/20] drm/amd/display: always-true lower-bound assert
Date: Wed, 6 May 2026 12:31:08 +0800
Message-ID: <20260506043342.2164710-11-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506043342.2164710-1-PingLei.Lin@amd.com>
References: <20260506043342.2164710-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|DM4PR12MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: ba9fcc08-953f-431d-992f-08deab3dbd76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9wdPUrp0G3KVMrVCm+Od1YZb2B4yBpCqJ9WWGy28f68S9/GJ6XnAkClMX6JETlIFeCxZI5BvjP38JR8dzeoXvHpsBT9gcn2RkkvbnTkWV9QwN11IkvIfnh6owZ/EC8oGZeWdIZv2o1sjtpX+H02U4+hnG0xxCUumOGcB4CCJWX92riCjht4vRVMXdyTG5fIsRCy/Z15lJiGu4cY2NVZEWu6XfOv4GeJpiKo9uq3RTRpcBmEB6IUkVKr7hrl57+KcNiRjurEUKK9UJiVY70rYDyEt5IBzJ82hfhKsxpxXXwzuke02rNCGNKnIU7AOWQ3jY+eki2kiK05dkW3gJ7xeSuMyPbHIFDTZe5Mfe5NPJihX5OG+cZCZbEsf98Wtmit3PbBudsR8rtm5KjaiT7s6jO6mr5zEzayWaF2asXJCDFXSNX0I0nQELhND22McXenFAw8bdzup0Eo+lBdpEQvuylXrbkcqNWOJKaGwQfJet9h47VIx8vdN7WvuXiED5nMlntiRSpIuvK/2qK6mE8gg7xm9pPXfAMh0Dl4Uz8Ir83Qi5MsILdFEtDTM/RVaWb0mxOTAGxT/K+0V0fKDtiMmMRiiney2PGmRMZ5B7wOZ7cygaeBKpp6t1MTSfSgenUjY8hENkoSWqUFjiQ8fsaj2/D3wfLPTo2gzfCfqDo3p16RsHX3Ruirdo0z85S/xileJWQ3xiJr+DfKTC0OBjUUSenuejatw7oz0PVUqf8tu6TQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9PdUel50M/JIVITNBnmxzZSjeo8XlBF3VzyauUsNrDo9a5Te+25TOal4T6OPlKAn5pXX130hL/0VVl1f06m6Mdb/AW9S5UKKgsOMST/MQe4gIKGgePyGeIJUvQdgg5d1lYoS9Y8veNY/5NmO9lmWz7QG1m+Km5z5m0B68i9/kF+SEwjDSyQ077jn0yls9Fi/V3COF5WaD1R+9iTY00z/ewhFW3G/sH0/kr0Kcw4H33DekQfKXyGoL23RqG5NB3D1ztrRe0K+LLf4N9WfD/ht2W0lcos5ddihOltL6Tqv6rz0hqMwOiOyFnGlbTxdTsW8sxi2ij5KUib9dp01yaqCIaE3d2KExBhGS2GXC4U7vmTThq+nR1afFOAY6Egks2AAmElP6OLNdYDYBq+pWaXAXZsdsptcnTjYUvC77l/rInfhS/k38DT1U1b5EA4FYrRG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:04:39.2853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9fcc08-953f-431d-992f-08deab3dbd76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6375
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

[Why]
A recent type change made the lower-bound part of the OTG instance
assert redundant, which can trigger static-analysis noise and distract
from actionable diagnostics.

[How]
Kept the meaningful upper-bound range validation required for safe
narrowing to uint8_t. Removed the redundant non-negative portion of the
assert so the check matches current type semantics. Revalidated with the
latest debug build log: no warnings and no build-failure markers.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c
index 1bc81e26a11f..5ed14f694fb0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c
@@ -255,7 +255,7 @@ static void populate_pipe_ctx_dlg_params_from_dml(struct pipe_ctx *pipe_ctx, str
 	pipe_ctx->pipe_dlg_param.vupdate_width = dml_get_vupdate_width(mode_lib, pipe_idx);
 	pipe_ctx->pipe_dlg_param.vready_offset = dml_get_vready_offset(mode_lib, pipe_idx);
 
-	ASSERT(pipe_ctx->stream_res.tg->inst >= 0 && pipe_ctx->stream_res.tg->inst <= 0xFF);
+	ASSERT(pipe_ctx->stream_res.tg->inst <= 0xFF);
 	pipe_ctx->pipe_dlg_param.otg_inst = (unsigned char)pipe_ctx->stream_res.tg->inst;
 
 	pipe_ctx->pipe_dlg_param.hactive = hactive;
-- 
2.43.0

