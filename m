Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611CACF3962
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 18:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 073F710E767;
	Thu, 19 Sep 2024 18:35:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="giHj9Y/s";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66FBC10E758
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 18:35:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTktaGq10m4eK2YPNNi0Ry45O0EzbzVPVmAHQVhR0JQn1C91aPMbG0QGtvlxth2RDOJSRBSEKIDAR8CKeN2ys5iWkf8FIxcURnmqoNcYApb8cgqxFJMZf/+JCNhkGd7J4aGLPIxLcaV4J5u8GI1adCsfQjvTGmOAZEtv3Rc+RAC78vVi8JHPYesITr4Qa4NmY8a6Uwicgd0auRym+D5iUepH9zg9Jw1y3cluRfq1CiAIKrpl2vDc/auRQj3LJflUInd0vLrEo26stN4+/Z4VEl7Qs4pciLsL+8j+G8m9bKFmlMvD5NidjVJY4bmhK6+vmysNV+vuV8Z7oF1Y9n0qZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bf1pxvblU+WHg2vKYQpvyL8OBXzlQbz32FSt2yJvah0=;
 b=g9W1mnKmwPSqFcorS7g4M+ly5Cnb1JFTNlM+u+DpdEriYABPcRxG01ov/ldg+zBE4Og5Q1HRKB46ZrTjW6C18AiGzMje8Ypk8/QuUXOUMkkrvdD1io+smngv/fMGjE68V1KkmCxW8Qaqp6HX9HAjIPsYgtMNQ9p3TbxwiXhs3RQhkIseeu7/+OKGfx1x1j1exF5pP6lMWlkvhW09OHItaMPDP6a8f2g843y2NwJ/+JwzUbd3ykt+mDL084chJELgGVDte6mQjuppTao1BHbdGnR03VADSamAQRSrLCuUdl4yU+CWyBOebbOu/e193eiioiYa4sbfZRWA5zrG6rcNxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bf1pxvblU+WHg2vKYQpvyL8OBXzlQbz32FSt2yJvah0=;
 b=giHj9Y/sMxJJoSd61TQbq9DdPbqzZshxXKQhb4POinkVFgqDvgXt7XG0IM0JxC82CRQHoY80bQz5AAtaU3k6votbuDJuOnqBmE5bWc3iiktqr0SAdzIRrCjzle+RhRoqlk32oCHD6Bh5+tdlF7SgUc+AgFiJFORfC0oK3hWxBjw=
Received: from MN0PR05CA0015.namprd05.prod.outlook.com (2603:10b6:208:52c::28)
 by DS7PR12MB8290.namprd12.prod.outlook.com (2603:10b6:8:d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Thu, 19 Sep
 2024 18:35:10 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:52c:cafe::8d) by MN0PR05CA0015.outlook.office365.com
 (2603:10b6:208:52c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16 via Frontend
 Transport; Thu, 19 Sep 2024 18:35:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 18:35:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:35:05 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 13:35:04 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 19/21] drm/amd/display: Wait For DET Update Should Use Current
 State
Date: Thu, 19 Sep 2024 14:33:37 -0400
Message-ID: <20240919183435.1896209-20-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
References: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|DS7PR12MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: 8efef7dd-6e8c-478a-9e1a-08dcd8d9ca8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yia4KRqKt/iN5JApihLqCU6mly0eTyeQU6cwidyQinRZ4IuVaqnw7azwsl5N?=
 =?us-ascii?Q?jqZ1AFjnBw7Xn6G1T+1HzAbPFNhTd+OLHG4U0GitMZYJ29y5dmlNvQ/gQKYG?=
 =?us-ascii?Q?Yx0GfeOLP9jkez6Vuq/hnDHb+UpInQMVmb4NnCW6JqdVzr3wLn3HVrKBNnMV?=
 =?us-ascii?Q?7lk8icW12ijVBSp1956X4c4C+lD1OQsIXQmPF8Lpa3URplRKkp0wfqhyF0xV?=
 =?us-ascii?Q?JZsQSQuPycrtD/4YCMN9anCnMYsJt5nPoU779MnK5GiA7MeT25pcEqin4tOa?=
 =?us-ascii?Q?wg+66/hodOBeFrP6Bj+VA63T8J4/u53AqoIsPr0PEb/9KI9kp5FKgLVeOJ4L?=
 =?us-ascii?Q?O2QPcl0W7rgjABu2Zd/TZUXwku80ZdrJRSA1GL0hRRUY1aKhbrc+ykRMAjmt?=
 =?us-ascii?Q?QuNFx92v7/lb75bGQzwwRFLTIoamCiLfcjMaJmam1kQcTcEZsTYFLBZqe1Tr?=
 =?us-ascii?Q?CuiHwfXlPEaXkmcDoiFHMBRcuml+iiqEX4ipOFsZx68c3KsCN9OFqzIV87a9?=
 =?us-ascii?Q?LKnJziBtBEd433KV5FUAmq1TwTIJSCz3hvKXtGmE7u2EwIIclqa3+L7FFnHM?=
 =?us-ascii?Q?Ew0VMYZZ7OM5W6iOpw5YtgvCjLIm77NAg41kOHkOk9PUB3jd8OI2FQ9Tx2gC?=
 =?us-ascii?Q?HFnYmJdvYY5rpDMPpPFFovGr7CMM0yJvSpHUmjN++YghVu85tH03J7slf4EE?=
 =?us-ascii?Q?K6ES/tToPUh29PLkgfXjPYYgz0Kx2psw3+Of+pqnc6ffOVAzs+GX22cQYMIc?=
 =?us-ascii?Q?HY3a81JWdfbqHsxIiQUL64M/8YSjtWd04mXoLoH8fGAmTS039Onj4kvw6j4R?=
 =?us-ascii?Q?sjQ/b3HS3at+YYVimTRefZS+RxtVYejIzmyFesPzOe5CWLZhCKdbCj2SQemn?=
 =?us-ascii?Q?enCdd2c8isfx8byyl0utMoW96heaLZQ6prW7dWTQHmRpFI88pRN2vyfsq6XD?=
 =?us-ascii?Q?oz7/eH5N1vEOiJyyuEjs0387NYYcDkjbcQvqs4jpHoOio0JbHSQ0wrGXYzj9?=
 =?us-ascii?Q?R9UwdSmf5CpTCjLKCuEotongVpE5FBIibZ4mvWvcEEhO1tn1SGC/ey97G+bS?=
 =?us-ascii?Q?ssrkMg2yDiKAxY0CvsMVorV/kg67YO6ju4+yw1w07FCiR1gj0bIdRcgd0GaY?=
 =?us-ascii?Q?llfCxInJb7nN+rqliMKIsCPYlA18cYOExKUWMEw9RBfNaC/pOAF+iHDWs9wN?=
 =?us-ascii?Q?erMmrnIHmL+0OruVxEeG2kfEpPQky3jRZTSzPVzEZGTBKQvfFpHzuZ09dRcD?=
 =?us-ascii?Q?EYEXNZisNULc0epnX30TPH27zi8UNJeO0ARVSZsYbqLPlW/NQ6NEzIDT4ibb?=
 =?us-ascii?Q?UnaPlxAoJeMYTT4fS48k5kbZ69ZqLL8gRPxEhnjTYnCfdj4zUpTKuSY71Rbt?=
 =?us-ascii?Q?L92ipOjGY95qhsCtmLNlUoddqsAAgS0Icc1PKCzXCpzFMFYULADJJr14f0NX?=
 =?us-ascii?Q?TMk43UGQKePejkPrliF/I0OQGKsG2aZQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 18:35:09.6989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efef7dd-6e8c-478a-9e1a-08dcd8d9ca8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8290
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

From: Austin Zheng <Austin.Zheng@amd.com>

[Why]
Current state should be used when waiting for DET update
instead of new context.
For any streams decreasing in DET, pipes used in the current state
should be checked since those pipes need to free their DET before
DET can be reallocated.

[How]
Pass in current_state instead of context.
Use pipe from current_state instead of context. This assumes that
pipe in the current_state is an OTG_MASTER pipe if the pipe in the context is an OTG_MASTER pipe.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c    | 9 +++++++--
 .../gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h    | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 29fcb4ed6646..805e7b52df29 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1669,7 +1669,7 @@ void dcn401_hardware_release(struct dc *dc)
 	}
 }
 
-void dcn401_wait_for_det_buffer_update(struct dc *dc, struct dc_state *context, struct pipe_ctx *otg_master)
+void dcn401_wait_for_det_buffer_update_under_otg_master(struct dc *dc, struct dc_state *context, struct pipe_ctx *otg_master)
 {
 	struct pipe_ctx *opp_heads[MAX_PIPES];
 	struct pipe_ctx *dpp_pipes[MAX_PIPES];
@@ -1695,6 +1695,9 @@ void dcn401_wait_for_det_buffer_update(struct dc *dc, struct dc_state *context,
 						hubbub->funcs->wait_for_det_update)
 						hubbub->funcs->wait_for_det_update(hubbub, dpp_pipe->plane_res.hubp->inst);
 			}
+		} else {
+			if (hubbub && opp_heads[slice_idx]->plane_res.hubp && hubbub->funcs->wait_for_det_update)
+				hubbub->funcs->wait_for_det_update(hubbub, opp_heads[slice_idx]->plane_res.hubp->inst);
 		}
 	}
 }
@@ -1730,8 +1733,10 @@ void dcn401_interdependent_update_lock(struct dc *dc,
 			}
 
 			if (dc->scratch.pipes_to_unlock_first[i]) {
+				struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 				dc->hwss.pipe_control_lock(dc, pipe, false);
-				dcn401_wait_for_det_buffer_update(dc, context, pipe);
+				/* Assumes pipe of the same index in current_state is also an OTG_MASTER pipe*/
+				dcn401_wait_for_det_buffer_update_under_otg_master(dc, dc->current_state, old_pipe);
 			}
 		}
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index a27e62081685..1e8189bb447e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -81,7 +81,7 @@ void dcn401_hardware_release(struct dc *dc);
 void dcn401_update_odm(struct dc *dc, struct dc_state *context,
 		struct pipe_ctx *otg_master);
 void adjust_hotspot_between_slices_for_2x_magnify(uint32_t cursor_width, struct dc_cursor_position *pos_cpy);
-void dcn401_wait_for_det_buffer_update(struct dc *dc, struct dc_state *context, struct pipe_ctx *otg_master);
+void dcn401_wait_for_det_buffer_update_under_otg_master(struct dc *dc, struct dc_state *context, struct pipe_ctx *otg_master);
 void dcn401_interdependent_update_lock(struct dc *dc, struct dc_state *context, bool lock);
 void dcn401_program_outstanding_updates(struct dc *dc, struct dc_state *context);
 #endif /* __DC_HWSS_DCN401_H__ */
-- 
2.46.0

