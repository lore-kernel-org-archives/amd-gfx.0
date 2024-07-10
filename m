Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79655C3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:39:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3239D10E8B7;
	Wed, 10 Jul 2024 19:39:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3++M7Tul";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB70B10E8B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:39:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hkqm+k0yKsI4+iP5cquyGI7kYBRfEJeEV3wvIwbHQUmr4YQJzI2q4/rJD1VZrkp+bDCRtmGrp/L+87pbnlkONNGbpgGlg7qgUFudZVrc3eBUwLnwQDg1xauV0ubWzpBFnIoNR90UDKiy1x80DoQCFOc9H4QUgYnqqO6EKGmW69zIKt4nywfk8HcKXa+B+TLxfP57BA6qCRJK0WsP+XGypr+/rvIXYBJjFyxlpElS1euTMCFb28bC3waZbj1p+ohCOG4rTMAmdSmXveSd20enrKH5W6MIWMCcz3JsSamNgbXl7M3akGsKu8id/GucJyIf2O3Ia+KlofGaVXYiRAt6mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8hNjob5qQpyfXQ5WWiIlcE/fpqAxNBAEejR9p7tpQQ=;
 b=GqwCDChv5xQbU4Sy5Af0iYiNn1wyTXAsPkfviiaAbYxdiVSl+ZUMkTGDkYlO3plii6VfcCLKL6bhe4V03VDovPoo8i/NLBO9GYjpbTdxlASgvRkFYRhN/JsHhGMU77IsO6LNqkEOExiYGW1lbUuoAGONiE5b/D4rxUgVSMjzTVTFkpQJNuHpftk+pRKvPlixV5Z33Z1BxUEtQyJCM1XbMZdHcpfKD5OldLnuY7H7R4FbtGtMOZxareOV/hta/blKI8KdQRTgrXJNfn+p2i19NIT2z6pkyseCACTFWXI2ts0pAVD+eSA8QkfcdFV87audRMbS3VmAqmEK8fTblFiLKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8hNjob5qQpyfXQ5WWiIlcE/fpqAxNBAEejR9p7tpQQ=;
 b=3++M7TulUMRCZGeLjh1ujnmHwHka9aIUa0nF3YzqRI0IDKVF/Ou4vKzlSg0QvVeraBSRR51oNkQBTukx5O3I2zFD7pUvz+o0YL7/g1fl5kFMLB/XNwLJ+W1GbT4BWaJawzoxqQ3Yo/RbjQY+NMnpjpI0r+Kx/ouXMz5vbcNQnaY=
Received: from SJ0PR03CA0280.namprd03.prod.outlook.com (2603:10b6:a03:39e::15)
 by CY5PR12MB6528.namprd12.prod.outlook.com (2603:10b6:930:43::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 19:39:12 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::9a) by SJ0PR03CA0280.outlook.office365.com
 (2603:10b6:a03:39e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Wed, 10 Jul 2024 19:39:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:39:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:39:09 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:39:09 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:39:09 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Sung Joon Kim <sungjoon.kim@amd.com>, Swapnil Patel
 <swapnil.patel@amd.com>
Subject: [PATCH 25/50] drm/amd/display: Do 1-to-1 mapping between OPP and DSC
 in DML2
Date: Wed, 10 Jul 2024 15:36:42 -0400
Message-ID: <20240710193707.43754-26-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|CY5PR12MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: ac37794a-d80b-4ac0-e442-08dca117f943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dibDIVzYQOgkasd4nHmUUouxEEFKVLWq1HHJrT7BoQGdHNDlnyDLPVW+44u0?=
 =?us-ascii?Q?Z3040gMislsGMITi4/aVtnPH3jV71ScvSCQDJggll0kkQhoiAtd1LYoRPDZ0?=
 =?us-ascii?Q?YTR8qkfvPoz2NB5OU40W/rdjWKqczfdZWl9/ZYIabxx7t34R23nqVG2L8kXz?=
 =?us-ascii?Q?40z69WP6ls3vLzaz7m8ZQwdc8UF4qEXDMH0770eSLPPcCSa5hTNyXmLwiuTq?=
 =?us-ascii?Q?bcsZ2LFViQxdftXrTcPEE2FnKlWJnWCQuzO62tFD+Q81dM1XZbYxicev+v6Z?=
 =?us-ascii?Q?TYc7nXhIZ1/yxgJ6mlNgdm7cXwKhpBodnVyNeQe88X5KZyGypDy/ka7rxWXD?=
 =?us-ascii?Q?7oesPVSei0EwvPn6rKYFmbgzJToYpOJPPt6VBoIMRkR12dPU1ZT8USduQ2Pn?=
 =?us-ascii?Q?zZAoQNvOv/H3CWqO/W85KqZray239Mrnwz8OapCX5FMrxUgdN/JH9k/pWNdW?=
 =?us-ascii?Q?hMVL770/CacBnUEX/fuhH1vbwZkT+k9/QZ4lxZ2Tyhm2AyCWfUgtkxWwPs0p?=
 =?us-ascii?Q?1wLGlxTQ9eUIou+jb+mDvzB0XQ5qFmdXOBWj8f0Xq7wNGsl9DdDC1NE+AWAR?=
 =?us-ascii?Q?0tMMbhOFnmijlyBz8motEZbmHwDgOO/FrI7GkHRJeYxet37xdSsKy7xugqhd?=
 =?us-ascii?Q?P2OBlSn9uMu21T7hdDU505JHlFfldO27TSNTQ0oomTNRhwXO6e/hfo9vt/YN?=
 =?us-ascii?Q?sOsyFKgRQOKra18fu6mQ3uNcXA+BSBNU4PKqQc1hiKnneMCGW2GuCBel0M36?=
 =?us-ascii?Q?iDh6vWljrkykLs6ufHZe+cvT67IQjqK/Sa9i3sK4htWwk3y3tMExU3YrG36s?=
 =?us-ascii?Q?/2IoQIded5jNfu1CMxHcH44UkzoLrdxroSqpY/Z9inWu+LDm4n60xtKmV//Z?=
 =?us-ascii?Q?jgPJpDdzEBWpVzgvHM1f9d1pZ2a2wmntVW5s3An71JZAjmDIVTmUUvcGprK5?=
 =?us-ascii?Q?j/MCtGYNrgW9E8p/2Nc1G2NUhe+mrsASp0L4KdodPS4bZvhzMn4gR9l4ADfj?=
 =?us-ascii?Q?gJ5s+sVW/ymkLmxhXlotIax3MM/aih17BSDMPtYja9k2rjwXvD28F3KHv+pP?=
 =?us-ascii?Q?lytRqAE+doNNffjFUaAJf63uKYMk3gmhZIsQKVH2MXQ5QT0SptAXTKX9ocSL?=
 =?us-ascii?Q?E70SwuLIzXLr/YX/GNDx5e0Tj7YKJuzYi+TikiUk3gSVcdtuYhqx3VXt5epo?=
 =?us-ascii?Q?mSsbThJ92FepGk/60/UZxi4TJXImLMyNkTcxnrj1LfqRHb4paDzAACyjWKRa?=
 =?us-ascii?Q?vjjifWCzZdsmt/NEefl6bdb6sfE0tZYeMOhGz4idpLMa9E9mehetcOLso4rk?=
 =?us-ascii?Q?oy7FGFsseiXsw5Q0AKxEZNWT53L+xo9WhFGmp5GWIo5mrehzvv1PgYG4OgJb?=
 =?us-ascii?Q?wUy3v8J4Gq8k6M0Q1w2Nn3HyHrwfBHdrmfKLFgBdfPSQug1yZlfGjCX3kPvF?=
 =?us-ascii?Q?T+/p7WqZcKD0Q+gEo7nZwcxWj3gpGoZE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:39:11.4469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac37794a-d80b-4ac0-e442-08dca117f943
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6528
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

From: Sung Joon Kim <sungjoon.kim@amd.com>

[why]
To determine which block instance to power-gate,
we look at the available pipe resource for both plane
and stream. On MPO, DSC3 was falsely powered on even
though only 1 stream path was enabled because
the resource mapping was not done correctly.

[how]
Acquire the correct DSC instance to power on / off based
on the instance of OPP which determines the backend
pipe index.

Reviewed-by: Swapnil Patel <swapnil.patel@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Sung Joon Kim <sungjoon.kim@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 83aa3d8a997a..4f5b23520365 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -5166,7 +5166,7 @@ bool dc_resource_acquire_secondary_pipe_for_mpc_odm_legacy(
 			sec_pipe->stream_res.opp = sec_pipe->top_pipe->stream_res.opp;
 		if (sec_pipe->stream->timing.flags.DSC == 1) {
 #if defined(CONFIG_DRM_AMD_DC_FP)
-			dcn20_acquire_dsc(dc, &state->res_ctx, &sec_pipe->stream_res.dsc, pipe_idx);
+			dcn20_acquire_dsc(dc, &state->res_ctx, &sec_pipe->stream_res.dsc, sec_pipe->stream_res.opp->inst);
 #endif
 			ASSERT(sec_pipe->stream_res.dsc);
 			if (sec_pipe->stream_res.dsc == NULL)
-- 
2.34.1

