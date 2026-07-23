Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A23C531D0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5068D10E623;
	Thu, 23 Jul 2026 20:19:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P1IywO4q";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99BAD10E623
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3Nm31AXc01IJCSfK8964Tll/eXWOdeS8bsZ/82L/OmXbVo8Hxq/NVubYD2hi9mb8jzfcwtc6GKvPG4VfscV/R7+IgdtSDjXkL9blZXUGglSHAdbDxt0ZzJG4kvszmJoohwPCvFLlT84B1FT6H3TfWbOYJoNrB9j2eFYLmanGEuK8i+l88utBwePGuaYCguTlHLcdwJltks336BdRysq5Ba9MD1Oo67RSgC7J5ebh/nIG+FguN+PSUeR50HIwfpt8/3lcVd4ATZvRPJfxCvlz/GnJ++uqSm2OFSswl35Hw4W3CQZcKlfV8C4ay8MjSuuEEdwTnISI+9lXXBvR0SoPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdEO12Wa7OnEtkQkpf+Pc9JEhSWfd4z/hJleTDwLR6A=;
 b=vLbx2GTEnaMKTlCxI4SZaBVqLP81LmIMPRIth+AXPbCfHATYg21WNw5kGDFPFvSUN8jUAJHRSrotglFo+Fvs4mvasPt99JeU7KCxe+Y2UQR1bg9FzrlX40C/pmQXvzFP/pSTV4/22fkpNwTEvwIdELWYTCzQJ7O82+7I35OXUSn0Q1aV90s9A7x9T0JRYUr9OB7MyzPQ6FPmQJjSXpioDtnQZklFkRiLUNVdGabMghai6QDNBT5CvwsENn5f/9CUeKmP/kWS1PRebnU+VIugqazHVdDWgaAwd9dq6kJkZUTC8uoysMbBFqeMJEBHarCrwU5chvUZ8ZgGsnVRUqi5DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdEO12Wa7OnEtkQkpf+Pc9JEhSWfd4z/hJleTDwLR6A=;
 b=P1IywO4qKWRb9eqim+8vbIWqqWR08UG19LBNGRi9os/pKeSHcLF74gk/weBKP4CC0mfRR5ip3fj/0BpJLbS/w0Dz8JYVAB/dvpQcLC67/wCBcdx6uzSdaIwl9Q8k/oVE4Ynz9Nm282puP0NGzDl3PDtdSmKkp7SMNtrsKiDRS9M=
Received: from BN9PR03CA0668.namprd03.prod.outlook.com (2603:10b6:408:10e::13)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 20:19:14 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:10e:cafe::5d) by BN9PR03CA0668.outlook.office365.com
 (2603:10b6:408:10e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:19:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:14 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:03 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tomasz Siemek <tomasz.siemek@amd.com>, Martin Leung
 <martin.leung@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 20/49] drm/amd/display: Use current mpc pipe in set output
 transfer func
Date: Thu, 23 Jul 2026 16:13:28 -0400
Message-ID: <20260723201908.373300-21-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ba5e32b-1cd9-4d87-e13e-08dee8f7aa28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: cz+b6fliTr9qEByVRBiAMMzeGV0n2VhWmRqKmTtSN9G8ppOY2YZxN21HjjK+bUCr+Yzc37NAYExA7oJHhQyJsFrX8btnPxsuK1hDdFPkvaleT4ece3mbuUq+Ul4eNg4YlhSRNOahkUX0JvMzkDv/BgGlIcTQPwaOuSiVjx7Hw7LDaq3dEi7agHyS3mSW6yH5nruTp1QSHRrBntbxT21w9cOPdXN3qDIWuS1Z4j2dWo3mMTCgAV3hyAv69jZNahsUvZrJmiLUPhK+OtH30DgKnI0tTJtPuE3QdPCbXvVWYnFFuKdjUiez3RRcdfdkh1fF9gpXkRnCes164ABBnq9LDYzs+Zt7jRs8TfDzsHFhwjmFkg69cFudp+zp6Njio4DCnCk2ehrMPOuPj1MzBezO7X0fjR1lIT4FilX0lAwxqGWN/34YM64leTVzLqEmfO2JOlNK6PKyRUkl47K2CBiWf0JLtdWka9ActPBwQDNdKPi+9ClzZYmMlsAi0f+0t+lda8+emxqHaHi939RGCx37C9ZQu92EtK8cyLTMbb9+t/vegDghSIjXdHpKgmIkIcBVkS8dmkYa6bCjOQcRwcdcOlpMysXki2BgmDC3Cbr+MCrhjN+TiranPy5YqbkLrrlfShjVCZh19MvR8TcAtzdSEra3u0fvi5ONDdEWWd2kaEvT20zXHCIWOSurYaPDbrATTIheqETIfGvUr2H8BZGQ5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /+GeKhy2IwcFGJN1pO0baFdVmRHh0wXeCmD6acjtYY+cDuuWno8/pIgLT2kLalJ0sOr0ocWgaQQp2El2X3bLVK6EvWXQT2j9+vNWSpr95l8nrupZYiGxTi/tjBVauki3PYt7FNERNf+dtb5VQe4WNP/k911h9RXBhBQgphpaJLDdqjFJLuVV/fjX3renLWURDi9DCLu4memIeu4M6ijvd5bLjxjz0H3QhhCsDlgMy11PCWNIzy9HNoTph/vFiBDRN7cb26rpJQO4JtdiNeAU6GYFAY51YzDPJXeVHeESjccj5Q2oQDZ5ZpX0Ftd7qFnZaghXncgUP/sniyrn29aMNv+OpShRyHnoluulNgFZQG/2FvrnB7Wh4fsopSWaMglm3CISIIOTnClCuK2Jx+DiDXhy14ZknpS4ALUVhmn2PAzFODn/D2nrjVW7QLBU01Ka
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:14.2108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba5e32b-1cd9-4d87-e13e-08dee8f7aa28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446
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

From: Tomasz Siemek <tomasz.siemek@amd.com>

[why]
Only the top pipe had the output transfer function programmed.

[how]
Program the current pipe from the MPC chain during fast sequence build.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Tomasz Siemek <tomasz.siemek@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 8b54bab98283..11411fa94665 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1111,7 +1111,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 					(*num_steps)++;
 				}
 			}
-			if (current_mpc_pipe->stream->update_flags.bits.out_tf) {
+			if (hws->funcs.set_output_transfer_func && current_mpc_pipe->stream->update_flags.bits.out_tf) {
 				struct set_output_transfer_func_params *otf_params =
 					&block_sequence[*num_steps].params.set_output_transfer_func_params;
 
@@ -1119,7 +1119,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 				otf_params->xfm = current_mpc_pipe->plane_res.xfm;
 				otf_params->mpc = dc->res_pool->mpc;
 				otf_params->mpcc_id = current_mpc_pipe->plane_res.hubp->inst;
-				otf_params->is_top_pipe = resource_is_pipe_type(pipe_ctx, OPP_HEAD);
+				otf_params->is_top_pipe = resource_is_pipe_type(current_mpc_pipe, OPP_HEAD);
 				otf_params->stream = current_mpc_pipe->stream;
 				block_sequence[*num_steps].func = DPP_SET_OUTPUT_TRANSFER_FUNC;
 				(*num_steps)++;
-- 
2.53.0

