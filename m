Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47047C3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 07:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F249110E435;
	Wed,  7 Aug 2024 07:56:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FlSJtcMi";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F184210E435
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 07:56:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dbb01IWhmofecl0a0kPHNojgMiretCb0quaPdT4wJ+HfN7D2YcHsdQG4yiLc8nN67GHFq0hUQnHK1S1V86URqeeAU9p5qKJupwr2X0YRHTCriCVMUAdBfYItx9oH6ybrU8s4Kla5riv/ykMn20MfQ7Cv071xbJIZlcLdp4NvcNDqe1hSyuZFFcA6pk0j/vhPqTblg9UFR028fVfpx5jXJvs74mbYtFQaE3NfiEUyyJFWiQKrWSsYA5D4u/URAE3he1ZocQ1ETJ3fl6m0qioo+G645uC4xWQCETNchMMwatyfp/55qZUIvCC32IPTQYP9TFjwHlWWCbEu7yFyN9GUvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFCDuNSvpGQ1zFz/ba7u0wEvWIDR6R4Z2UQzEYgn3WI=;
 b=esOTNFkUbwXyUEnxW3zaIm8NfTbOt2xNcHkghd8x+DgRwVgIjsO668veMVLm1nC6rCxJlm0dKWY5W0j7fjvrcQUztkDSAA/ENnDtzLTRfZ3OSbIZYH6mj10MW7oMfMBZjLZObuUvtCrrEcamyc/tXKqzZmk1MU6Hqi9dRQi5WkKi1Z+Ay0Ek6ruD2cIHxdF4sgeCKwV7qR1udlM02qTkdURAtvQPqAHQIB6ZbmqhWaAJ7K/aBQtNGfw6QaKUQQBGxaezBET3esXj87xdpdFEwrPDMOsjGY7yQqZksVnUWZGuj3XPEZcjiUmOmRM9YY6db+JDB62Gwky29QrUybJ2+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFCDuNSvpGQ1zFz/ba7u0wEvWIDR6R4Z2UQzEYgn3WI=;
 b=FlSJtcMik5aQbJYR+J/TkRGZHiI1es5RejyUrwnL6m80Wq/G4oRerCkkUd7YH9AvfivF+AusfG2v0BFRSwkrmWDeW66PHrSDGRbmqDBNJyG+lD+hIlnyiCb1cpDzCiINZY0hnk7s1xP16+7LXFVqifHBHF8WBj8tmUXsGU2GrQg=
Received: from BN9PR03CA0306.namprd03.prod.outlook.com (2603:10b6:408:112::11)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 07:56:31 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::46) by BN9PR03CA0306.outlook.office365.com
 (2603:10b6:408:112::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.28 via Frontend
 Transport; Wed, 7 Aug 2024 07:56:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 07:56:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:56:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:56:30 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 02:56:17 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 07/24] drm/amd/display: Add more logging for MALL static screen
Date: Wed, 7 Aug 2024 15:55:29 +0800
Message-ID: <20240807075546.831208-8-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807075546.831208-1-chiahsuan.chung@amd.com>
References: <20240807075546.831208-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 20d8af56-8106-45a1-410d-08dcb6b6736d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pScpS0cWYJBzvNLHb0cuBuNVuso7SFgAmWMFUzMAqXQcQN795qlhFCLDqh2f?=
 =?us-ascii?Q?Cq0R9yXawBn+3DpvMbSM1O6GM8l7BNMjD6y8i87n2IEzL34rs4bVWhPH0Rht?=
 =?us-ascii?Q?pjXLcxEgLOIj+M5Y1zcV0WuD9Zjons/tzEUOseLOC1o8iI1UaWHKCONQJ27K?=
 =?us-ascii?Q?XT1HSHhP+6ROZnLAKJEwR0KeRbwFJX1MZd21A26RmpKyxfIMxta1wCoe4eFJ?=
 =?us-ascii?Q?txwvoT5c3A7QkQRgw7jGl4UUfHH2uUgeU48aBQJQjxdpSfvtL5LX3xTYgfiq?=
 =?us-ascii?Q?zyRaZitmWAk55/XCsGq0VXJCEYGx6nx59V8ZLBpQBeJBWDkFWaFatOzxW3rM?=
 =?us-ascii?Q?28YImv2VyG4dQEjtbxbeUCr7xemOZYdZn1I6RkO0D5QBF6rYTijXKcu20/4N?=
 =?us-ascii?Q?U0HQ0jJIjtM4g7Qecv+LdNcO5Yus/D6sKYLrN2ymWKC3yVRvzWJsAU7Crxdl?=
 =?us-ascii?Q?wQx3bceZLkMToo2UpT6/DlQZR6DHvtcPPpyWPGsanYPm1EEJ6bR2gl8VSzNb?=
 =?us-ascii?Q?gX8rl46yvo3Pqgx/VzWo/2+4eCpPw+YiPWMNcEWXbZo9dG6OjTZZNB91vnir?=
 =?us-ascii?Q?xfNeJ9Ttcf/l6/8eQfhUrMRDIaHPrr72i6UX3q4gfJ/QHzKY+mKq26a0u8ui?=
 =?us-ascii?Q?yg4pIronEPq+09PtLEDcsEPGbrMCZFz3Sspoa16QIBy9wHpNWKLXPeGWNI25?=
 =?us-ascii?Q?Po+Sdcd8PH7wUXAk2Yc6sqpsyqnwkpupsZP2x05dCBXHmtOFNXJYlA8pFbIH?=
 =?us-ascii?Q?E94Alr6EsaJfR/Tj2ZnnmThRQ9xuCIuEtjyKYcSkDpj3ApyPHsU4AlA+E08o?=
 =?us-ascii?Q?zUJctR+UflKg4RTFwKyrJH7i/OHuw6E6TJL0UUNPoxRv2M7gbd3H4Le4zSQN?=
 =?us-ascii?Q?5uNk/t2ccR1O4D1xJVcuO/0Gh9l6RpyKKJw0CBzzxejtNcWZb0H0k0K2X1RD?=
 =?us-ascii?Q?dYhoP54j2weFeNUfmkxEBM5Yp3ac5oF77AI703kidg+SPsyPB4Jr1li9+EjO?=
 =?us-ascii?Q?/syFg5HkzNq103ALxkjmBybchhj/ImWOuqCRKond+0APlPfsS+QZCS2jePuj?=
 =?us-ascii?Q?aBC1zO7vVTLYiwMV0ucHmoLnSULf5jzau025gRII++2cqAPl7KMLjK7QZTi/?=
 =?us-ascii?Q?Wf5nTjTJr9OZTBRfQq0DNBhJ1xwNlqnTTEM0kUrDK1cs7URq5Q4TfgVUwszx?=
 =?us-ascii?Q?1D60A6Ow20ox6ay0J81Et2VBo4XP71chLPDTkJmQV/G8tm10ginsPFEIaKYo?=
 =?us-ascii?Q?OY7TIepgCox6j3Ott/MnphKGktxR0Y4MMd78aIFnQdCidoct58N82hJ1MRD6?=
 =?us-ascii?Q?rADTOAl4TvJe11OUNzhe/gMlQbJLprFEZHHTxZoo5bdZL5IoJeXSoeJ9meUc?=
 =?us-ascii?Q?/mXwDQgFlV+kQNkMSQQNhSWkv3WYH++4M/DRC3um0yAejBuQ+Ec09IS5SFIx?=
 =?us-ascii?Q?NCfV3q3PsUw/7XowYF8b+tV5sI9f1qo9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 07:56:31.5204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d8af56-8106-45a1-410d-08dcb6b6736d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[why & how]
print additional info for MALL related calculations and DMCUB messaging
to aid debugging.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  | 10 ++++++++--
 drivers/gpu/drm/amd/display/include/logger_types.h     |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 22c7afbcfc4e..b604c8886ef4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1309,8 +1309,10 @@ bool dcn401_apply_idle_power_optimizations(struct dc *dc, bool enable)
 	for (i = 0; i < dc->current_state->stream_count; i++) {
 		/* MALL SS messaging is not supported with PSR at this time */
 		if (dc->current_state->streams[i] != NULL &&
-				dc->current_state->streams[i]->link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED)
+				dc->current_state->streams[i]->link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED) {
+			DC_LOG_MALL("MALL SS not supported with PSR at this time\n");
 			return false;
+		}
 	}
 
 	memset(&cmd, 0, sizeof(cmd));
@@ -1320,8 +1322,9 @@ bool dcn401_apply_idle_power_optimizations(struct dc *dc, bool enable)
 	if (enable) {
 		if (dcn401_check_no_memory_request_for_cab(dc)) {
 			/* 1. Check no memory request case for CAB.
-			 * If no memory request case, send CAB_ACTION NO_DF_REQ DMUB message
+			 * If no memory request case, send CAB_ACTION NO_DCN_REQ DMUB message
 			 */
+			DC_LOG_MALL("sending CAB action NO_DCN_REQ\n");
 			cmd.cab.header.sub_type = DMUB_CMD__CAB_NO_DCN_REQ;
 		} else {
 			/* 2. Check if all surfaces can fit in CAB.
@@ -1349,13 +1352,16 @@ bool dcn401_apply_idle_power_optimizations(struct dc *dc, bool enable)
 			if (ways <= dc->caps.cache_num_ways && !mall_ss_unsupported) {
 				cmd.cab.header.sub_type = DMUB_CMD__CAB_DCN_SS_FIT_IN_CAB;
 				cmd.cab.cab_alloc_ways = ways;
+				DC_LOG_MALL("cab allocation: %d ways. CAB action: DCN_SS_FIT_IN_CAB\n", ways);
 			} else {
 				cmd.cab.header.sub_type = DMUB_CMD__CAB_DCN_SS_NOT_FIT_IN_CAB;
+				DC_LOG_MALL("frame does not fit in CAB: %d ways required. CAB action: DCN_SS_NOT_FIT_IN_CAB\n", ways);
 			}
 		}
 	} else {
 		/* Disable CAB */
 		cmd.cab.header.sub_type = DMUB_CMD__CAB_NO_IDLE_OPTIMIZATION;
+		DC_LOG_MALL("idle optimization disabled\n");
 	}
 
 	dm_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
diff --git a/drivers/gpu/drm/amd/display/include/logger_types.h b/drivers/gpu/drm/amd/display/include/logger_types.h
index 83479951732a..a48d564d1660 100644
--- a/drivers/gpu/drm/amd/display/include/logger_types.h
+++ b/drivers/gpu/drm/amd/display/include/logger_types.h
@@ -61,6 +61,7 @@
 #define DC_LOG_ALL_TF_CHANNELS(...) pr_debug("[GAMMA]:"__VA_ARGS__)
 #define DC_LOG_DSC(...) drm_dbg_dp((DC_LOGGER)->dev, __VA_ARGS__)
 #define DC_LOG_SMU(...) pr_debug("[SMU_MSG]:"__VA_ARGS__)
+#define DC_LOG_MALL(...) pr_debug("[MALL]:"__VA_ARGS__)
 #define DC_LOG_DWB(...) drm_dbg((DC_LOGGER)->dev, __VA_ARGS__)
 #define DC_LOG_DP2(...) drm_dbg_dp((DC_LOGGER)->dev, __VA_ARGS__)
 #define DC_LOG_AUTO_DPM_TEST(...) pr_debug("[AutoDPMTest]: "__VA_ARGS__)
-- 
2.34.1

