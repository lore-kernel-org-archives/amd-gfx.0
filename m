Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E82D5CCAC
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 09:58:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4386A10E79B;
	Tue, 16 Dec 2025 09:58:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LPCK+gXK";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012006.outbound.protection.outlook.com
 [40.93.195.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7619310E79B
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 09:58:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6YNel3WSJOAxnWt1PkV3AJjzb/6yplN7Xjd5OQ6WjjAgDMVffCy4DuB3p1eOCZ5u9nR37+ulvuYHTgj886f0LY1sA3BI2O2Wp+Bj0IJYkybvITK1VGMzuownXKdXEQ6XWukX45yT4QH3fsPRA33RucEpLdXPXN4NjndoSXdWPh17X3QorXKsEszYSF8cBU8+kndtdhHTic85uPr1ZdGdJrbcXvbbdv1Xs2NDMinaIpnWmJhl7xN6zYSRquJFToP6L3AUPcO0QyZT/dvPUl4nQrJIzXUcvroyOYdofTZhinlA5PPb1z2C9ujM0AYR+3BnVxBZMKnjLO5fUqW02BZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKh6BED/LDqn9KiouMSxiV9YesJyOgF/pJdeBU37Px0=;
 b=Xyn/+HCluOVuUHCmIV3kiuiI9UDvMGTu9a83UrwjsFhYwl5oqMPDH4WU38S0i5zhNKU8Qe3x5Z9+6R0TQNRW+BO2G+dMBUwvbV7M5UBtQZzvf8fqSc4ZFuklK7/1iKesnmmG0YcwheXeEGYC3nldTY//xYs/5nRQKKqmyz2g5HVE2qm/baGX+ipiQpep0ERfn/5KmKJBMp7GZK/JD4ctaXqaEDfcFY0eZMH9wG7Ul9PcV1PVwSXGyv1+03wDhFYCvueEj+HA7pLter0ETk5+1ba31ItH5EnARC9QIASHzG2S42UnybeqhGpp35RfWsVQSR2LMyuC3uqGBbzYFD/oHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKh6BED/LDqn9KiouMSxiV9YesJyOgF/pJdeBU37Px0=;
 b=LPCK+gXKmQyvGLNwmZQYC/pl+Ms5ToiBb/OXSzuGtfBNJ2QshItV4U3do4l6LqWi/cMDaUdSOkzf6mDUB6qpUg29FDb3YsNA0mN4F3dHvy0YlFGoPTtnlC9kZHZUX95rUcADnoJa5SHdiDxB6GPygRWkCaBXzPi/s4LfSeRv1Yc=
Received: from DS7PR03CA0234.namprd03.prod.outlook.com (2603:10b6:5:3ba::29)
 by DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 09:58:09 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:5:3ba:cafe::92) by DS7PR03CA0234.outlook.office365.com
 (2603:10b6:5:3ba::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 09:58:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.0 via Frontend Transport; Tue, 16 Dec 2025 09:58:09 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 03:58:06 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Dec 2025 01:58:03 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Charlene Liu <charlene.liu@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 10/16] drm/amd/display: Add signal type check for dcn401
 get_phyd32clk_src
Date: Tue, 16 Dec 2025 17:56:10 +0800
Message-ID: <20251216095723.39018-11-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216095723.39018-1-chen-yu.chen@amd.com>
References: <20251216095723.39018-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: e79eb852-6f18-45a2-988b-08de3c899df2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4ODkP2oa3jtI1n0eCtZ1M2KfSTEMToSn55oAbtymFh7vjDL8Q6YCL3M5dtzD?=
 =?us-ascii?Q?3V0/C71FWCtLtJMzDep2t01GT/zl+sRovYfyZJO7/q5VuIKySOaWcXysqWZR?=
 =?us-ascii?Q?iK/iduFbm4dhEr0b96KdrWdjPxS0SxjgONKib9Q0BY+mntdyUefYWCZdvwZ1?=
 =?us-ascii?Q?SJN9GukNpV6IMCoseiAjRxN8EDPkomX7biwrNESuU8AtSIZbqRAHL9GGZoIb?=
 =?us-ascii?Q?lmM5YYP8MqTPCCtzpIstLKyIAjonN5iFB6pdT3k+mAgyKR23QC7loB/S+PM8?=
 =?us-ascii?Q?Hip/y742JcL+PT7yz0m6/iVRc5mHUdtxwcCX7oxJGKaMYfBfUA0/mxeNGTmr?=
 =?us-ascii?Q?jv/QQbvN3lxbSD50aHjig352631y6M7CpZvKVTYHVIze7rOQZd9g65AhKeA4?=
 =?us-ascii?Q?Db5kyIj8ZYJI67SqAegzGM4oCVZhwiRSISm+FCMu7CALguH7ISc2vxx80e/B?=
 =?us-ascii?Q?eYp3/rI9wMYi94L4hdSs0GS8n9/dysFDz0FR9Jpx2/kdjw6jAPhjYIyNOb/f?=
 =?us-ascii?Q?R6iudRLvcbmyHEnEQdfEZSB/TD4OtpQO16THHrGRcaDJ5asAf/JxJ0YXUzZP?=
 =?us-ascii?Q?ZzgmlalhVRg6W5rlcmaXHR7YEz34t1+9tgTAAhUanV6hDbpPexx1MZhPKxc5?=
 =?us-ascii?Q?5F9ajsTqrzsZAnmdg1zq96GqeqWq7zhC7Zvn8GI/hE4InHW0xibGWgtwt2pI?=
 =?us-ascii?Q?kcDS8n96y73Pfc1VU94KUuNNYH4TJI/S8ym1UQ3HKCR9J9lTuN+TLc0bF1rK?=
 =?us-ascii?Q?pst1FuE9iEqdZX3uSItLcDOZdXtaKumv9uPneB1212/OJ7weDa2Ql7Q758M2?=
 =?us-ascii?Q?7RUEE2rEOThDb0eR8OlCCWqRS/cDX+W3plVvdNMyPJazcC5se0L0Uqt9Mk/w?=
 =?us-ascii?Q?FBWTv8Y366l7lOQP5Z4vL9IK+u0dSRP3F1nUgWCge97IoizZbfyTSqsND3YV?=
 =?us-ascii?Q?KmOx5AK7/elQhxU1w+zDc8/frbpIWRXGcOFvnliT95+PhJoUcQNRXhu3WoE2?=
 =?us-ascii?Q?vHfEBzpimeHUbFnvA0zhHv7eA+wIDt9koeU6ZsnBbUY0SjGeKHWuMcjbX9BG?=
 =?us-ascii?Q?kbrSSthzeXlBZtjaapOHuN01gqUqIVSwEU/TfYHLrOBkt0PoD94rj8WWpS4D?=
 =?us-ascii?Q?WqCrK4ODJLJuhVYWqS3Y6zEsKSQpO9LX0GzI8wolzPbRyPk/mWravXMUFkOI?=
 =?us-ascii?Q?pdSWvZDJHM7URacMz+GySF7M0pcGkjv0pwKc5a0xV5/QLb2QFpW1oRhxEu/2?=
 =?us-ascii?Q?gqwNOugVPMwpjMzzUmLNKT+kWq8RRy8flLZ+gXn1meqKr/jFG0ITgUrR8SSt?=
 =?us-ascii?Q?z9G8Id3Ai9u6uxp740lN6ivoAtSneur7LBhtlg7xwYPQ+GqQqKQoLu0P2Q+E?=
 =?us-ascii?Q?exZGH7A93ATznGoMypVLRe37H+PBUfHJUM438kvUmmKfpXIRyqspHxuAjvT1?=
 =?us-ascii?Q?XqWUBwWT0i17WFkRxedo36fcjhWxmuExX/HdmnF6BwFE6bcWmJLvFSPHcAjM?=
 =?us-ascii?Q?8nkA5GqdtW77f607AuH99XNBMJrKkO2E+MLm+SHRVdMKwt8WRfmOQNnxV9h3?=
 =?us-ascii?Q?FWXxS/N1eZbe9ohBFhA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:58:09.0974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e79eb852-6f18-45a2-988b-08de3c899df2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995
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

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

Trying to access link enc on a dpia link will cause a crash otherwise

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 63cd13d4617a..b7593b886dc6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -914,10 +914,10 @@ static void dcn401_enable_stream_calc(
 			pipe_ctx->stream->link->cur_link_settings.lane_count;
 	uint32_t active_total_with_borders;
 
-	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx))
+	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
 		*dp_hpo_inst = pipe_ctx->stream_res.hpo_dp_stream_enc->inst;
-
-	*phyd32clk = get_phyd32clk_src(pipe_ctx->stream->link);
+		*phyd32clk = get_phyd32clk_src(pipe_ctx->stream->link);
+	}
 
 	if (dc_is_tmds_signal(pipe_ctx->stream->signal))
 		dcn401_calculate_dccg_tmds_div_value(pipe_ctx, tmds_div);
-- 
2.43.0

