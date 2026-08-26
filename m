Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99D1C61DBE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7372510EE36;
	Wed, 26 Aug 2026 23:18:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MI+U/6Ig";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E61C610EE36
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:18:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEyb3GgqG1oLo0u5BFUmlVigwHSVsRJ7zkhJvVsrazeERrSGRciZynbqNEEvSqd2Aunls5/CSTST17dZazVlBmx6z1+ehfDncEh8+R4Bzf9Xe83IwEA9XAB7FRDSNzTQRzQkN3LR+gPW1b78w5/CTgkowA+z3NNgxW3W6fqRYcjgxqJ4oNt9ximgYkak7ezM16mKLnHrKaRRv0kacvzPh3PN+kQY9KstFYLVAE+hFBzOFF9QZqYdeyDbhgFQovx4GAyxBmzrmEH0h2DkR0nicWKvBbwXhfe6lNYvPaobm4r2vDc95kElGpn7mNblENTWuIa8sPZF6H8+ChTApLrZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTZQk8G7eID4hb+FIxGgqeCso2eUHfFl5M89mfc1Iv8=;
 b=yPzGeWG+ItDoHa56DfuEL6fJxmJ3KKYVR754Bv4kSidoBiWE/8LVTtjQzozVdxVeDjwiDvr0c6ZhI4+tvAPq/gUAvq/Q0azpStHEBdEV63hOk9dde8a1RLVPgQS6j70gxTEnGX4pyszFVe2uzYPXXC/G5qJgJ1XNovuygk7xbTujBfc5Mc2qlS4vr99dHkbKrxoC+ovMupdT8CVa8uRNqJaaCd5vqKNH6WLJP9We5IBwbYY9pUk7B8T0hwoo3PJacEEiMgR3lovIx9SBoTyfTLJBrtz8BsYhvwsgc6dAQcWXBIJxXsEYQrqRIG5doroCsq3HJR9ny8LPdoDuzGlJ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTZQk8G7eID4hb+FIxGgqeCso2eUHfFl5M89mfc1Iv8=;
 b=MI+U/6IgePothwTR+0w4UBaoV4wF7uNbak+6LZCZ+zQNadaMXKivcqHGyGukxA68/XUHgHNNDm9ucDDNUyBo7rvYt7zkNQW1B2qq3IxD/5yV9oHk6v4MabJrU3CyEyVuSoh73ukub9hBsfYxWw3dqb57M5EkrXyMoJ3TkEdMsdQ=
Received: from PH8P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::11)
 by IA1PR12MB6187.namprd12.prod.outlook.com (2603:10b6:208:3e5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 23:18:47 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:2db:cafe::9b) by PH8P223CA0023.outlook.office365.com
 (2603:10b6:510:2db::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 23:18:46 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:18:46 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:18:40 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tomasz Siemek <tomasz.siemek@amd.com>
Subject: [PATCH 09/59] drm/amd/display: Avoid NULL hubp deref for remaining
 mpcc_id assignment
Date: Wed, 26 Aug 2026 17:04:40 -0600
Message-ID: <20260826231519.881949-10-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|IA1PR12MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bec1055-0618-4abe-6b07-08df03c860bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bWaFDCgK6YVNALF3syuVzGcv57TrWtSFPyD8jKCTL9g/DLRuD/NSiXflPubOqZlBdrnH8I7GMK4fV5dRP2vbIijMC5xWkth/CZoUGziY5cDEkuomYBZgVYlbbsX49CUQ2vnXFkzxHQpFUau2b7DkzlluNDr/BiAx8ExxZ+AHqAScuInrx5WzC8LuRieP7mFdNFlDjB1sd1QrS0J9VoEX4J8g5u3jZVVZzFci8N8OmeYGpEjrRSdPMkEfx8SXr8IEET/0p7ImnHXBYpr1KzTshhF7vmVhmqiIw+ZwkuJqaCCBJ1MQEkVE5MXAp1eJ3eCX90z+LFbOsAa1Bp7vc6w7eEe9GH8i/iXNBsWlFRWpnnT9NWzITHx7H9HtJUfasOEKWHzs/ZYrTEHrgNkECddDXCPcOn4B6LmnNRTD2QdSKBglzk5iBoF3wEqG5wQZp+eD7U7hfBcAyFQZggrAUXdjsBxIIPHlzRUpzqxHP2P65ZYPDLtgJT6WrhKZ4pcQ1DitJTL+4UtvR3F7sOQKNmlJBK9SVAvJp6jO4Zx23+WRfajKXt0K0M5XaA5MDtHHZZv1x8mKf2Mh7GkpnxHUe4uR4UeVspw+oQ+zqvQmVeAp2Qh8I2TgvTdfZD3tWakneSOb8FxAoPWlCH6vPRITeP8lMA9iycdrXUYlcnvDulcIeze3t3oFC0+6sRn1bvkKBqaOGrV9Utm5EprehxOBaqrsFA==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TH85xbwXAqyVoeF6T6jw3T10YLjxuJlYm2JM8QTN8NPeL8jUBLzz9/L+gKCuBJFFvHx7PvqBbFPIx4bo93cECpSK/6/DNvyHNDYqvI5n3kr37hYYB1MnQ1tQAuud8L0Ye8xO/cXz7KNaQC+qZZG0IxkgFoTO/rOPnNcdIqepHhO2HErSqf2Z/Kxf26zvKzw763F9y4TRAYhLtbB+KTutnffHqXqGNsXjIevTMceqPjuj68hqkZICXUyMxov7AuOrRcq7cuHKq9228dT5VrrSMDercNjD4003j2AuG74HPU574P5oXS4LtiMhI2rV4DikunJ1AWKJQ3+nngfEWGYBclO8MMk/SeSN1ajN9V/Y8TEwo6uW8rWe9YbMxaSg/nU6/xZKux7PHUkYU+SO69YqCKYK5tL61+Fp8brQDK9mKJaFHbD2iPywFAlSyJwi0GVI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:18:46.0476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bec1055-0618-4abe-6b07-08df03c860bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6187
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

From: James Lin <PingLei.Lin@amd.com>

Previous fix converted most mpcc_id assignments in dc_hw_sequencer.c
from pipe_ctx->plane_res.hubp->inst to plane_res.mpcc_inst, but missed
the update_visual_confirm and power_on_mpc_mem_pwr paths in
hwss_build_fast_sequence(). On DCE ASICs the pipe owns no HUBP, so those
two remaining hubp->inst reads can NULL-deref.

Use mpcc_inst for the remaining two assignments, matching the rest of
the function and avoiding the NULL pointer dereference (same issue
addressed upstream by "avoid NULL hubp deref when filling mpcc_id on
DCE").

Fixes: f0b207067bb3 ("drm/amd/display: Use mpcc_id instead of hubp instance")
Reviewed-by: Tomasz Siemek <tomasz.siemek@amd.com>
Signed-off-by: James Lin <PingLei.Lin@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 8b723c3ca933..47320ac01711 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1610,13 +1610,13 @@ void hwss_build_fast_sequence(struct dc *dc,
 				dc->hwss.update_visual_confirm_color) {
 				block_sequence[*num_steps].params.update_visual_confirm_params.dc = dc;
 				block_sequence[*num_steps].params.update_visual_confirm_params.pipe_ctx = current_mpc_pipe;
-				block_sequence[*num_steps].params.update_visual_confirm_params.mpcc_id = current_mpc_pipe->plane_res.hubp->inst;
+				block_sequence[*num_steps].params.update_visual_confirm_params.mpcc_id = current_mpc_pipe->plane_res.mpcc_inst;
 				block_sequence[*num_steps].func = MPC_UPDATE_VISUAL_CONFIRM;
 				(*num_steps)++;
 			}
 			if (current_mpc_pipe->stream->update_flags.bits.out_csc) {
 				block_sequence[*num_steps].params.power_on_mpc_mem_pwr_params.mpc = dc->res_pool->mpc;
-				block_sequence[*num_steps].params.power_on_mpc_mem_pwr_params.mpcc_id = current_mpc_pipe->plane_res.hubp->inst;
+				block_sequence[*num_steps].params.power_on_mpc_mem_pwr_params.mpcc_id = current_mpc_pipe->plane_res.mpcc_inst;
 				block_sequence[*num_steps].params.power_on_mpc_mem_pwr_params.power_on = true;
 				block_sequence[*num_steps].func = MPC_POWER_ON_MPC_MEM_PWR;
 				(*num_steps)++;
-- 
2.43.0

