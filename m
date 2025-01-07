Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB10BE77199
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 15:30:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C40710EB11;
	Tue,  7 Jan 2025 15:30:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4yJSVXre";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 065C810EB0F
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 15:30:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DW9jeaOujJr4B3ZHTWl3PNu2fLPw1XvX8qBN1SKjDmY9lxzTN5/Ta7tzZyrU7yUKkZj7xKSo+jYH70wLv8E70IKXNlI82ryo8u9GsfuSvDuDRmx7Eo+iVtT/xJU27XB2kGYGnnraNAuGwet9ArZ+KlbWMFNQIhzBgP+qtK1y9WxkdSNWdbVQGEVjO8eTmN47IuqkEIPBsP3SMBPj0NdGPln6e2COfKWjO14ReNfJ2kWqcyi2taAfjoIeyU5mZv4RC5dLGBfNl3Mu7HTZiSFfG2S47zR5lhet9I6MqEkCIy8y2g3Jc/kgjTEr3Y4n9kE0MADKr+2WWfXm6lBlUrwMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4lyzG9WvSzmYv9VOYXqCbKB4mfXuC/1XF26gyyskVg=;
 b=d0ynOKkWItFthAVWqU6sNAJPF3sSSddlWKvoFQzq4W31ywLMIUcUIsA5XTQEn/sCMnZvhkCyf4i8gwt3sWgIdca1iOzTAl1OkHQUGwJmoFP7WENObEIkAR1mCqrPG9Oo8Gzmo5j1nhfWPMqIlbLM57GTb4Lk20ePYM0jMUjFMrv5wRr4gfEMerkcFq+yaWVU/LcU30Sx6OK7R8+jOqM8e5kTC4ZUvs0VSYpTrord8E+5Gfy61365s2OaOxplNWr8gc6YbfCdGvTRHr4Qa+SRB+0QtqCNqSCoDGRPR8WO9GlLG1yOGOW9NKO5IZf2NKHq64OMvD4xfaT1xcY+iIJv2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4lyzG9WvSzmYv9VOYXqCbKB4mfXuC/1XF26gyyskVg=;
 b=4yJSVXreJESL98P+rWTODu94IjOtrM6JDAXn8Vm17b5b/WymSIL8I9qONSkd4wy1/aRn9TPYdSrF5A7mxxHjRTT0qKZRR0TwPpp+SPN3wWg3TlTkT9wTxxuVSIP5K7ZA0CQfcf6R6RRLrWe17yw/AkIBrmeCDNadV8wHfCKwR7U=
Received: from MN2PR03CA0029.namprd03.prod.outlook.com (2603:10b6:208:23a::34)
 by SJ1PR12MB6097.namprd12.prod.outlook.com (2603:10b6:a03:488::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Tue, 7 Jan
 2025 15:30:30 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::9) by MN2PR03CA0029.outlook.office365.com
 (2603:10b6:208:23a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Tue,
 7 Jan 2025 15:30:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 15:30:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:30:29 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:30:28 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 7 Jan 2025 09:30:25 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Karthi
 Kandasamy" <karthi.kandasamy@amd.com>, Martin Leung <martin.leung@amd.com>
Subject: [PATCH 17/24] drm/amd/display: Remove unused read_ono_state function
 from Hwss module
Date: Tue, 7 Jan 2025 23:28:48 +0800
Message-ID: <20250107152855.2953302-18-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
References: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|SJ1PR12MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: c66a4789-cb6f-4a2e-8bd7-08dd2f3037d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?95QTamhTZdLHJNm/Q6+4eNITCrIFuzIye2H4K1arT3cxFpv/bPflCDZ/fJ8C?=
 =?us-ascii?Q?LTWgAIB6IgMYW9MldJ0KpnZhSiFuPqkeurSrWvlQVISc39ZRJeErCUhZCRPH?=
 =?us-ascii?Q?6CsITalWcVl83IWP/ZKvnL+0oTgVSixjClNId4C/uId3T3jiqZ2SfjYI0ARC?=
 =?us-ascii?Q?S57SK1SltHVYxnx2+RK5K8GQB4bah8w1PRXfEj2fEZRq6DUNYnVY7+fzOlvg?=
 =?us-ascii?Q?RWazmjZMs/x1WntjxRvEl6wR2x8JufIaFNyVCEmFwJowS6yXjD2KzRAGUc+7?=
 =?us-ascii?Q?Sz5k1TPIgxV+Q1ojyA5pFoTKKeFvyu0QNA59HupKVSbPpDS+jBVIozYSh2x0?=
 =?us-ascii?Q?HAzMNfpjj2I0KxNsUUxBALkcqKbwUvwWw//AEYs73gAvJGGylQZUMMiqwSDb?=
 =?us-ascii?Q?gO05zWXe54qcV/D0d7mH8fmtwZDw4BU2NLp3MgSIID4ta16TnWAfZXcwyFqR?=
 =?us-ascii?Q?faDHvjUxD4bLD2Y8tK+E//si4vqjpkOWTM3bJlqSWV8upxR1mDizHBmMLm9v?=
 =?us-ascii?Q?h3LzbhQg4R2NbdRjvR05ijzI3VEPD0MeD1idfwq9gjZgygwRNpjnF5oSx17r?=
 =?us-ascii?Q?ej0Hq1rqzDC+/0383YNNGgduOxLk8O4CaMC/LjoIqIM5WTAE/ySlgAVIOWNT?=
 =?us-ascii?Q?4LXs139AyR+mBCjLq+9HbSG+ycDewTGG3DuiG2BRLaEKP5a1lo7cCEhSCWIa?=
 =?us-ascii?Q?xHHESWpBfuQrQKCyYBz0rmE3wKcNrNNRtSk+TZJqF/7p9L4ir1+RmE4dy7ZA?=
 =?us-ascii?Q?dxZSMUoV7fn175KqHkfPCYV0ICot0J3LF4Lta2lAb26KhwsgSiYQuQrLURTo?=
 =?us-ascii?Q?jsnMGpd6PgRGaH7GBt3bfTqxRloJ1cxAyxZJqpo3z3RzVkUisU1cOPq41e4X?=
 =?us-ascii?Q?hZQ/df7BSLAhibbi9reThCPrabAdUE4W7qmHmR9BaTE4vNQLOgdV0Fr1Utkj?=
 =?us-ascii?Q?skoSeZJhRY6vLaOkXGNf22t8CQNLntCXypr7W5T+6sxWN54sPuwyQ0SoBKMA?=
 =?us-ascii?Q?bll+1G32E+Cz48sjAnJy7odZbM0Eqy5fGnH31COdZbsrpAE3iGUNRPSuzXsQ?=
 =?us-ascii?Q?Tj8TmhbpTs2O+0loX/9gjeGZAjM3IOa4wku/B9w3IWbqHbAeDRtLvrJ2b/zk?=
 =?us-ascii?Q?UXJJOcTBstJgcqQYB/ySXX74RKzNgQZz1EsKR161W34OXy+k7dY2zSB1+//b?=
 =?us-ascii?Q?1C5qLnf38Bm/Atv1NbO/jDTTcb3kqVz06vbcsgQHSLgAFbhh1Z0ihih8nrwj?=
 =?us-ascii?Q?mqnsgtYKqoqdY1QKsCHCiDwTRbegYjzPPsuYKfaV/PZm6BlKPEdq3Eb0PgDR?=
 =?us-ascii?Q?bXK1d6iJICX6AIr6/D6+e7SfjorPYgCr5XFRtappuAhKmUALv4BNo5CyVxJE?=
 =?us-ascii?Q?etU1jDII38eWPrzPExcCrr3vAuCMfy/zlYqi6JPrGqgbhFzIXhFUTx4YZ0Nr?=
 =?us-ascii?Q?asJbe09gw9g9sNGqq5Dtayz92F+j2XsXlZIv9VKQ0V9r4J2EHDDA9qnP/Qz1?=
 =?us-ascii?Q?pQ+wagw4B2MdX8s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:30:29.7571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c66a4789-cb6f-4a2e-8bd7-08dd2f3037d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6097
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

From: Karthi Kandasamy <karthi.kandasamy@amd.com>

[Why]
The functions read_ono_state are no longer in use and have been identified
as redundant.
Removing them helps streamline the codebase and improve maintainability by
eliminating unnecessary code.

[How]
These unused functions were removed from Hwss module, ensuring that no
functionality is affected, and the code is simplified.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Karthi Kandasamy <karthi.kandasamy@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 85 -------------------
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |  2 -
 2 files changed, 87 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index d5bbd3531c61..555a9f590cd7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -127,91 +127,6 @@ void dcn401_program_gamut_remap(struct pipe_ctx *pipe_ctx)
 	mpc->funcs->set_gamut_remap(mpc, mpcc_id, &mpc_adjust);
 }
 
-struct ips_ono_region_state dcn401_read_ono_state(struct dc *dc, uint8_t region)
-{
-	struct dce_hwseq *hws = dc->hwseq;
-	struct ips_ono_region_state state = {0, 0};
-
-	switch (region) {
-	case 0:
-		/* dccg, dio, dcio */
-		REG_GET_2(DOMAIN22_PG_STATUS,
-			DOMAIN_DESIRED_PWR_STATE, &state.desire_pwr_state,
-			DOMAIN_PGFSM_PWR_STATUS, &state.current_pwr_state);
-		break;
-	case 1:
-		/* dchubbub, dchvm, dchubbubmem */
-		REG_GET_2(DOMAIN23_PG_STATUS,
-			DOMAIN_DESIRED_PWR_STATE, &state.desire_pwr_state,
-			DOMAIN_PGFSM_PWR_STATUS, &state.current_pwr_state);
-		break;
-	case 2:
-		/* mpc, opp, optc, dwb */
-		REG_GET_2(DOMAIN24_PG_STATUS,
-			DOMAIN_DESIRED_PWR_STATE, &state.desire_pwr_state,
-			DOMAIN_PGFSM_PWR_STATUS, &state.current_pwr_state);
-		break;
-	case 3:
-		/* hpo */
-		REG_GET_2(DOMAIN25_PG_STATUS,
-			DOMAIN_DESIRED_PWR_STATE, &state.desire_pwr_state,
-			DOMAIN_PGFSM_PWR_STATUS, &state.current_pwr_state);
-		break;
-	case 4:
-		/* dchubp0, dpp0 */
-		REG_GET_2(DOMAIN0_PG_STATUS,
-			DOMAIN_DESIRED_PWR_STATE, &state.desire_pwr_state,
-			DOMAIN_PGFSM_PWR_STATUS, &state.current_pwr_state);
-		break;
-	case 5:
-		/* dsc0 */
-		REG_GET_2(DOMAIN16_PG_STATUS,
-			DOMAIN_DESIRED_PWR_STATE, &state.desire_pwr_state,
-			DOMAIN_PGFSM_PWR_STATUS, &state.current_pwr_state);
-		break;
-	case 6:
-		/* dchubp1, dpp1 */
-		REG_GET_2(DOMAIN1_PG_STATUS,
-			DOMAIN_DESIRED_PWR_STATE, &state.desire_pwr_state,
-			DOMAIN_PGFSM_PWR_STATUS, &state.current_pwr_state);
-		break;
-	case 7:
-		/* dsc1 */
-		REG_GET_2(DOMAIN17_PG_STATUS,
-			DOMAIN_DESIRED_PWR_STATE, &state.desire_pwr_state,
-			DOMAIN_PGFSM_PWR_STATUS, &state.current_pwr_state);
-		break;
-	case 8:
-		/* dchubp2, dpp2 */
-		REG_GET_2(DOMAIN2_PG_STATUS,
-			DOMAIN_DESIRED_PWR_STATE, &state.desire_pwr_state,
-			DOMAIN_PGFSM_PWR_STATUS, &state.current_pwr_state);
-		break;
-	case 9:
-		/* dsc2 */
-		REG_GET_2(DOMAIN18_PG_STATUS,
-			DOMAIN_DESIRED_PWR_STATE, &state.desire_pwr_state,
-			DOMAIN_PGFSM_PWR_STATUS, &state.current_pwr_state);
-		break;
-	case 10:
-		/* dchubp3, dpp3 */
-		REG_GET_2(DOMAIN3_PG_STATUS,
-			DOMAIN_DESIRED_PWR_STATE, &state.desire_pwr_state,
-			DOMAIN_PGFSM_PWR_STATUS, &state.current_pwr_state);
-		break;
-	case 11:
-		/* dsc3 */
-		REG_GET_2(DOMAIN19_PG_STATUS,
-			DOMAIN_DESIRED_PWR_STATE, &state.desire_pwr_state,
-			DOMAIN_PGFSM_PWR_STATUS, &state.current_pwr_state);
-		break;
-	default:
-		break;
-	}
-
-	return state;
-}
-
 void dcn401_init_hw(struct dc *dc)
 {
 	struct abm **abms = dc->res_pool->multiple_abms;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index 17a06f299b68..17cea748789e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -63,8 +63,6 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx);
 
 bool dcn401_apply_idle_power_optimizations(struct dc *dc, bool enable);
 
-struct ips_ono_region_state dcn401_read_ono_state(struct dc *dc,
-						  uint8_t region);
 void dcn401_wait_for_dcc_meta_propagation(const struct dc *dc,
 		const struct pipe_ctx *top_pipe_to_program);
 
-- 
2.34.1

