Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B99BEA811C
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 13:55:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D66A510E57C;
	Tue, 10 Feb 2026 13:55:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3OTEHbbp";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011037.outbound.protection.outlook.com [52.101.62.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69DBA10E57C
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 13:55:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Npx8H3CA7G1D4/DW2riN5zDl/4mHdoXhGN6OvGc80Dmf6NFIh679kOcud4PTH4jR63Pl5jG1JcEvWP5VdM8bOzNgrmNC0fsEMeaW2K3Xo1RKNZG69Gbcql0joMRjEhPfOr2DZT6LYuizmY6tJFZYNpv6BDZjCAaYfSnOM2B5e5zyrp8E1xT9TJFsB8H7J4PbpTGFO/5sm//dC2720vbvHkryci/7J6m/esMgmHWRza4kFQ3egTSsXCWppZVPCtt9lLY9rX7lrPFT0FpvxE9xXThCc6k4zQS3v0WwKrpEaiEONta+GBYcKddOhHcLoQE2oaEbP2lbyH198FkirL6gwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOsnhO/917tbFkFnsTRnfFcsoQlSfOHt1k3f7xWgeqs=;
 b=vDi/F1lBjCvfJnJ9+W5+IPn0J5xr+c5w0HOvHqW4z3qAIT49+4wBKT0xgEsfkf9eeBeZ4O7cWbWP1D+YmzxlMoUI8YLtPoxm51FsNPRvHegPE2dXk+hNSjPC4Ceb9SZuPfg9fjZMQL+6C2tU8j2t6sXHqqVIAlraNaHc9/qAMSkDsXoSH8Vi/NMwNEMIfdJOhsR11So6e3VqYhlVVRoDHCUxsVkEIICmNuyXgt4n8ivYPswleblEoyC+sMLNI3k/v9XOxjJ0Va8hiUdPXo88LgQwuXSiNw1YODZ0WLBaOXZHZa6g8wAtvGg0wIknIuCbAwKpkdAqEWaNdWVJdOh7yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOsnhO/917tbFkFnsTRnfFcsoQlSfOHt1k3f7xWgeqs=;
 b=3OTEHbbpRAEV/yy3hy47UPn4ZPz7CayLohg5bZF5UE0Mhp5YmxYlPOQJgSi9B0WhqopUzQSOdZb3J61y0glEPRpsVh5gCu5do2xLz4AIheoJhtnP8KeSq1nMurhgc+W05CCBtL2EYZkJ2h5cD9r0m3/rVZS0a1GmfOir/pA2mVg=
Received: from DM6PR02CA0130.namprd02.prod.outlook.com (2603:10b6:5:1b4::32)
 by DS0PR12MB8562.namprd12.prod.outlook.com (2603:10b6:8:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 13:55:19 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::41) by DM6PR02CA0130.outlook.office365.com
 (2603:10b6:5:1b4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Tue,
 10 Feb 2026 13:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 13:55:19 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 07:55:17 -0600
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Feb 2026 07:55:08 -0600
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Muaaz Nisar <muaaz.nisar@amd.com>, Aric Cyr
 <aric.cyr@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 07/18] drm/amd/display: Implementing ramless idle mouse trigger
Date: Tue, 10 Feb 2026 21:50:00 +0800
Message-ID: <20260210135353.848421-8-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135353.848421-1-ray.wu@amd.com>
References: <20260210135353.848421-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|DS0PR12MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc35465-85d7-4806-f1ff-08de68ac074a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GissDCt0zxYiH7sPYCMJwTs1GxOQpbDkFSiZkuL7Rt9HsCpF7/3HLnHhassq?=
 =?us-ascii?Q?NBWoT7xgTiiyGnjLpuz8zlpgyQTCNRIO+35yahunLmfOBI9e3JmU46cgABnN?=
 =?us-ascii?Q?W5n1ivUd5pK+ffX7vGSmY22Qz4oQwDQexoWhvX9Lf8qso465WmmAlqUQ2LY7?=
 =?us-ascii?Q?3SNl7+ytixHIaFeKsJmp6CBh9zvGoorH000PkDOujYXRBMc2F7XnnfX/SR0p?=
 =?us-ascii?Q?f2zv49wfx3yCqVsJQO7wC1GPNej1eOI9/nQFOWNRSFuLfnxfsKzzYL5eW14h?=
 =?us-ascii?Q?EiEwMm2BTZtWiAO0T+PUWi9FxfdzdliJgCpIq2Ei3ELl0FaNzFIDx6BAdNLB?=
 =?us-ascii?Q?vjGggLy78SSs4am0eUOAI4KJHXa7PFhLHh0nRprb0dCMFFXuRBeGfhQv/dqv?=
 =?us-ascii?Q?2VITG+EW51xI+SEyf43th9S5cC7fYD5UNawCJK70yk70AfX7rFSGbBMYl7oV?=
 =?us-ascii?Q?UvwEoqicjmnmdiQAAd4l9hb11Z9+33zDH4B6S7uBRZkNoJqpB6Ho/MgxNkFL?=
 =?us-ascii?Q?MzFsFsi9VbFxK8dGUjnMdxVgHaOAiiJ+jgNFte5hvNIs6fOtd2HLWF8V8VFZ?=
 =?us-ascii?Q?ZBqn2dw+/IeI3/nEWhPOFLe04vykqfT4RR8hza2XB+wigkvHMv0Gk78IPXlk?=
 =?us-ascii?Q?f36PNEFB0r46coSPdW8F6bfqF0FVpbb2w+FqHOcJjKY9tq/GHi+dpGKET6d2?=
 =?us-ascii?Q?flHSqBXTLQc+xKtpOigS8Xm30xvIsrqEJpio/SqkSRnl71HmVajIqKaY24BF?=
 =?us-ascii?Q?o3KIZjKjXseju2KfOKtzpB5VMviJCYxbc4u+xrVNefEGTom+ZWvTCdbmET53?=
 =?us-ascii?Q?hwodS3K+cuWsRMdCcuotnHkWCOXMEZfZfvv7EMwlTeqpdYoovvp+5TGpyF29?=
 =?us-ascii?Q?cTQPDaDPJNt+bZdPnzYlmZAQGyoafPDnwgRdCHSH7bukiPcOtLRVv2WfxjRM?=
 =?us-ascii?Q?gZ9zkaenNLaUaV5X31mi9F55wDXjHpnU2cAlgCEQXB5Fzl7AXfBXN4eN5e+S?=
 =?us-ascii?Q?E0BPYUBgedioDvfc3DXRRwjjzyzdea/TgeisYYl2s1QRH23P8UeXLvHS6tx2?=
 =?us-ascii?Q?mArOyuH+7zp4i8a+GHNX+OEYPOsqpJAq9Ud8BHtfoBUXZQXWomoyz24RFQtm?=
 =?us-ascii?Q?3PGUM7PmDHCjxrN8LgjisRTNNNedix7Ww6q/Nx4LAX8284c6816CArVFy2Ao?=
 =?us-ascii?Q?jRGj4TQ7e6Y1G8ibbL/T+abr/0E31/DYQRQPAojZk3vxJFIXFYw+0McpnyNz?=
 =?us-ascii?Q?kMcA9b8SWjtxx19RJ86Sv1Dl6o+ayvNqY8LTaBl+kK2feQWM8cNN+9xqalwo?=
 =?us-ascii?Q?RSY/CrZiZtZrZgf98LCB7h4MJfML4cVtnX7w/Ojf4x8X0V7GXyqUufTepqoV?=
 =?us-ascii?Q?Ylp3lbkCPRdAZ5W4w2HuKdM2gPm0gpqxlJGHo2pxSKBIp6Ucl+JNWB6ggJEz?=
 =?us-ascii?Q?rMpLyWcgjBVEDJQMu0pL7h1tyPsH82uf56ohX9ZvR0OSwkNyoG4rid2BF1Bo?=
 =?us-ascii?Q?LjMhe+I/+BOnYS2ke4GOOq6RX+PGyqyMe3sJWkX1uZp0mxuHmpDSJ8Mu6Ryq?=
 =?us-ascii?Q?rWH24tQhxw8qOJPKQ7m3LBqiJ2MqJMnLsv64MmxU7ROVmLbIhE1SfIACMCLq?=
 =?us-ascii?Q?J/WDgWibf3dYGuKGg3ehm4evR9Gh4BXMm7kueRS9zzlfMSfpT0h9fDL8eEwo?=
 =?us-ascii?Q?cake7Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xNXOCazSL1ZIz3rvD5OBqmO92n9WDdLeMd07RtUpADwzvTXmU92O94VgZlT7cT2uCMbijyYYy4YKpIw+rnEBWsP6YlrtdS+wSBBlEwK6/tabtqshQ/2p/aDFE5ZkK1qA8aakYGLFi+QyVJnccxkpkFziybpzligU8zALJq6zaNywRW/eTk09B+ZV5XGhloMKXpI/W428Ry4Y4ILbOWBICi73yme8YvZGdfqKHVWZPA99BiVihJJVqLKo3kPQiXocElKlvPDlI7DHvhBQWduJzyLPLzbjjSe5RXtcV0OyJXT8qV2twtMWXHMun3gc/wTEi52ynVl8Hr4E6tBYFhcOAWBbiC2XYrjEveGAaTOyuF7EHHhrk0Of6uFiHNXLOdyrjGIztCssEUm30j3f9msrgU1YnfFCSgtT5r8+McsYr8/GT6XeyqeoRTI1B8yeoEEW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:55:19.8825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc35465-85d7-4806-f1ff-08de68ac074a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8562
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

From: Muaaz Nisar <muaaz.nisar@amd.com>

[Why & How]
Adding mouse trigger in dc_stream to
recover from low refresh rate idle state
upon mouse movement without vsync interrupts.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Muaaz Nisar <muaaz.nisar@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c        |  4 ++++
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 15 +++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h      |  9 +++++++++
 3 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 17ba7af0ddcd..6f3c283431d4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3369,6 +3369,10 @@ static void copy_stream_update_to_stream(struct dc *dc,
 		stream->scaler_sharpener_update = *update->scaler_sharpener_update;
 	if (update->sharpening_required)
 		stream->sharpening_required = *update->sharpening_required;
+
+	if (update->drr_trigger_mode) {
+		stream->drr_trigger_mode = *update->drr_trigger_mode;
+	}
 }
 
 static void backup_planes_and_stream_state(
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 9349cccc8438..191f6435e7c6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -515,6 +515,21 @@ bool dc_stream_program_cursor_position(
 			}
 		}
 
+		if (stream->drr_trigger_mode == DRR_TRIGGER_ON_FLIP_AND_CURSOR) {
+			/* apply manual trigger */
+			int i;
+
+			for (i = 0; i < dc->res_pool->pipe_count; i++) {
+				struct pipe_ctx *pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+
+				/* trigger event on first pipe with current stream */
+				if (stream == pipe_ctx->stream) {
+					pipe_ctx->stream_res.tg->funcs->program_manual_trigger(pipe_ctx->stream_res.tg);
+					break;
+				}
+			}
+		}
+
 		return true;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 9960494007ff..86394203cee7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -183,6 +183,11 @@ struct luminance_data {
 	int dm_max_decrease_from_nominal;
 };
 
+enum dc_drr_trigger_mode {
+	DRR_TRIGGER_ON_FLIP = 0,
+	DRR_TRIGGER_ON_FLIP_AND_CURSOR,
+};
+
 struct dc_stream_state {
 	// sink is deprecated, new code should not reference
 	// this pointer
@@ -316,6 +321,8 @@ struct dc_stream_state {
 	bool scaler_sharpener_update;
 	bool sharpening_required;
 
+	enum dc_drr_trigger_mode drr_trigger_mode;
+
 	struct dc_update_scratch_space *update_scratch;
 };
 
@@ -366,6 +373,8 @@ struct dc_stream_update {
 	bool *hw_cursor_req;
 	bool *scaler_sharpener_update;
 	bool *sharpening_required;
+
+	enum dc_drr_trigger_mode *drr_trigger_mode;
 };
 
 bool dc_is_stream_unchanged(
-- 
2.43.0

