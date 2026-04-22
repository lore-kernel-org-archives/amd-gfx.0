Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EE3F94CC3
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 03:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A513C10E24F;
	Wed, 22 Apr 2026 03:57:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ev4NmX/l";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 532FB10E210
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 03:57:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qm/SN+bwM/GMvCYpMuAVxqP27xnnqmOHKMyeST8QZp0N24rh/epV339d4wN8UMvjjFvojN5PrfEux0MQKJSJkwPbegdqyekG0FnLauQBH/yvBBuFOVHW9KZGe4CezTc3naenxk45GsyxiYGaTZ+e2XsSpz4ztB+5DezWBpg1x5Fs+NW+2NjRaC3RD+ScqA2y6v+p6N/bj5rxm1iWF3QgRu0L/vLLv+Vx3LeZPSLs1hDe/gn63gmZlbrEtSCdrABUu22Cd2mwqR/k/5kAUJkejaX1kmXhepIhBOc4upY01bcrvRMxlV32Tm50Gf+MJr2nHH0MTO0RPo61oQIwJTTHVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJzLsP5BuKTlzbx9zTdg8koB5ZZk3WtcbibLu2XERnQ=;
 b=B2eVXn3plXHMbcxQ/U1xCLhFFD/BXtkREmFe/zgHozv93ZbjmjpqePCab6+76XKBt9uutmB8rwo8IFHSdzZZaeNeZ9AuyeZqiK67279ttgR4Jfap8yC3VQYZpbw6dTnQ1NJDPp4DT9Xe+gHTiFduBlkX0Xaq/un40i8YcwbXWxqdayyn/kZgPyHwKywMpMvD0kqS5mVtSwe7JKnXgJGX+Ot1r6q5ZKvmsYrGI/RiEWxBqWzomfQN14jaYFH8bv43UAGtQJ5rS/8xx0Umk2ajHq6agpZL9ds4MLskEqOI96umGTR+4GwM2w5EAfgHBPFDLHxDbID95DjfXC8FqJJj5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJzLsP5BuKTlzbx9zTdg8koB5ZZk3WtcbibLu2XERnQ=;
 b=ev4NmX/lb2D2YXiz4TWbdSlrgxdrM+yWDG553g7CICQr5bQWuUEbOMGS5bhV8WWcAsFoizXGISDOjEsvhTuxKbrn2GAgjIkurQZS33vw48QA8eH+dAAh5gHIxQbz5rURjkP7er53rj0bxhS4y+NgLIVbA+Qz/ChUV6weyfwGSnQ=
Received: from BN9PR03CA0370.namprd03.prod.outlook.com (2603:10b6:408:f7::15)
 by PH7PR12MB7260.namprd12.prod.outlook.com (2603:10b6:510:208::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 03:57:10 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:f7:cafe::fa) by BN9PR03CA0370.outlook.office365.com
 (2603:10b6:408:f7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 03:57:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 03:57:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 22:57:09 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 22:57:09 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 21 Apr 2026 22:57:05 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Jing Zhou
 <Jing.Zhou@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 12/14] drm/amd/display: fix root clock disabled when DSC power
 gate disabled for DCN314
Date: Wed, 22 Apr 2026 11:52:50 +0800
Message-ID: <20260422035611.1870316-13-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
References: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|PH7PR12MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff429df-e435-43ee-affa-08dea0233a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 4dFoX0eFKx+gYLeGkptyMLv+VY3vdgpdwtd5tO4fiGIQPfsZarHsZhIWn7uoLyBdXhoKPvmWs3yyLljJ5eCTazTzU3VyBu+Kiy1MqmrFAvCHGH8AjnjQCkeaLnMlW83zAQXvReRrDK2GaPL9fOq+93AdUSrs4JDDdCV7gCJZKOAPpQ7cnXXH6gaWpjDR9BbrnRPxVJTNaB6p9ocoDFejemOSIw+SOY0QFS+qA6C+aIW0nbiXX+sBTzbnmwmYEFDLdcGzI4Q6ISiGbeaLR2YvoNQlthvHCUQQsRePjwV85DnuHlhsY91weMuzB7ymh0JXDRlKaanr/VOXsH5o0XAR0MTzzvPVjbf6dfFx5nF1/V2pd0zSnkzFtatLSPxv3/pHRVU7gCfMlxmGQL8iYAo73gtABuTIJ5DHZX2bc6yYjfD8lAFgljMuJDDHiHRKtH6AlzKK0yKYwhl+SoSeSzxU6KVJza4ktIZj/g2KTmWyqkYD8QQClpXBgCcq2ux6l1Rmewjh0IQwrnPLOAdjMB8YOmxAGvpg27RHJzXn1ikbMiHUsro7WPWlnIFuqJjUNFbPkUO0iKw/YVpcGrcuo96TkwRUTrFcUtbwJoGG2lZ8712n2yJtB9fKECpS9KUJdsufg5XVzitObLHB+XUG+x8ucmpBJUTQFpAHYtoCictCdGLG6eNlU1PdoPEf9xHwZ5tQ40sKS8WvJnnRFfuKdoWoiqyT7y1aRnNtAbtH5jGuaKmAdewDoC3IZfeRTz+sg1hkhTWkZ79i15Ym/paNq4unsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UgdaghwyrH43kopuXUXcqHF5XkTf5D88KlQIxN+1uz9c5+mnf/Pia2v3vxHPX5XTVGybpdBLQfnjJmXPn01IhaiGQAyKFXZwgMBUiqExYrugog0Vz1mEG1MOUMbtTZqo+UB5N7e8MC+/JppKgLJdzc5554NaucN4O1rJszoKmQrfTYNmG29EtKUiwGvAviiKVOnlBwHF3MoQKjkd1YZiSH/spF8J1aNQZhA4lsAvCYpCKg1JZFPAeemwxWEht2zFo4yGZfVHb9JHn2gRRXtxMN/FWNVfrd4b2Li/fulcnhczssO1RYVPtVKFKh+X3fMmXE++2AZssFaU1UYirtUzLa1VtWChQsaieGpS79KrJqE/T8lgCZerKXOS6H3xMUmhfCkFtkgI6EzJ6TxWNQljA7tqUOj6BYdq6mYo5rQVIpaxXyH/JfkKKjX0TC1Vdvvy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 03:57:09.8180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff429df-e435-43ee-affa-08dea0233a7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7260
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

From: Jing Zhou <Jing.Zhou@amd.com>

[Why]
When set debug.disable_dsc_power_gate = true, the original code
uses an early return to skip the power gate sequence and root
clock enable and disable.

For this case, install new driver without uninstall old driver.
The sequence like below:
1. On the power-off path, the old driver will power gate dsc and
   disable_dsc() (root clock disable) due to
   debug.disable_dsc_power_gate = false.
2. On the power-on path, the new driver will force power on dsc but skip
   enable_dsc() (root clock enable) due to
   debug.disable_dsc_power_gate = true.

Finally, when mode needs DSC but the root clock is disabled, underflow
happened.

[How]
- Moving enable_dsc() before the disable_dsc_power_gate check so the
  root clock is always enabled on the power-on path.
- Replacing the early return with a goto that skips only the power gate
  register writes, allowing disable_dsc() to still execute on the
  power-off path.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Jing Zhou <Jing.Zhou@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c | 90 +++++++++----------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index 1e856ee508f1..408d417318c2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -232,60 +232,60 @@ void dcn314_dsc_pg_control(
 	uint32_t pwr_status = power_on ? 0 : 2;
 	uint32_t org_ip_request_cntl = 0;
 
-	if (hws->ctx->dc->debug.disable_dsc_power_gate)
-		return;
-
 	if (hws->ctx->dc->debug.root_clock_optimization.bits.dsc &&
 		hws->ctx->dc->res_pool->dccg->funcs->enable_dsc &&
 		power_on)
 		hws->ctx->dc->res_pool->dccg->funcs->enable_dsc(
 			hws->ctx->dc->res_pool->dccg, dsc_inst);
 
-	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
-	if (org_ip_request_cntl == 0)
-		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);
-
-	switch (dsc_inst) {
-	case 0: /* DSC0 */
-		REG_UPDATE(DOMAIN16_PG_CONFIG,
-				DOMAIN_POWER_GATE, power_gate);
-
-		REG_WAIT(DOMAIN16_PG_STATUS,
-				DOMAIN_PGFSM_PWR_STATUS, pwr_status,
-				1, 1000);
-		break;
-	case 1: /* DSC1 */
-		REG_UPDATE(DOMAIN17_PG_CONFIG,
-				DOMAIN_POWER_GATE, power_gate);
-
-		REG_WAIT(DOMAIN17_PG_STATUS,
-				DOMAIN_PGFSM_PWR_STATUS, pwr_status,
-				1, 1000);
-		break;
-	case 2: /* DSC2 */
-		REG_UPDATE(DOMAIN18_PG_CONFIG,
-				DOMAIN_POWER_GATE, power_gate);
-
-		REG_WAIT(DOMAIN18_PG_STATUS,
-				DOMAIN_PGFSM_PWR_STATUS, pwr_status,
-				1, 1000);
-		break;
-	case 3: /* DSC3 */
-		REG_UPDATE(DOMAIN19_PG_CONFIG,
-				DOMAIN_POWER_GATE, power_gate);
+	if (!hws->ctx->dc->debug.disable_dsc_power_gate) {
+
+		REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
+		if (org_ip_request_cntl == 0)
+			REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);
+
+		switch (dsc_inst) {
+		case 0: /* DSC0 */
+			REG_UPDATE(DOMAIN16_PG_CONFIG,
+					DOMAIN_POWER_GATE, power_gate);
+
+			REG_WAIT(DOMAIN16_PG_STATUS,
+					DOMAIN_PGFSM_PWR_STATUS, pwr_status,
+					1, 1000);
+			break;
+		case 1: /* DSC1 */
+			REG_UPDATE(DOMAIN17_PG_CONFIG,
+					DOMAIN_POWER_GATE, power_gate);
+
+			REG_WAIT(DOMAIN17_PG_STATUS,
+					DOMAIN_PGFSM_PWR_STATUS, pwr_status,
+					1, 1000);
+			break;
+		case 2: /* DSC2 */
+			REG_UPDATE(DOMAIN18_PG_CONFIG,
+					DOMAIN_POWER_GATE, power_gate);
+
+			REG_WAIT(DOMAIN18_PG_STATUS,
+					DOMAIN_PGFSM_PWR_STATUS, pwr_status,
+					1, 1000);
+			break;
+		case 3: /* DSC3 */
+			REG_UPDATE(DOMAIN19_PG_CONFIG,
+					DOMAIN_POWER_GATE, power_gate);
+
+			REG_WAIT(DOMAIN19_PG_STATUS,
+					DOMAIN_PGFSM_PWR_STATUS, pwr_status,
+					1, 1000);
+			break;
+		default:
+			BREAK_TO_DEBUGGER();
+			break;
+		}
 
-		REG_WAIT(DOMAIN19_PG_STATUS,
-				DOMAIN_PGFSM_PWR_STATUS, pwr_status,
-				1, 1000);
-		break;
-	default:
-		BREAK_TO_DEBUGGER();
-		break;
+		if (org_ip_request_cntl == 0)
+			REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 0);
 	}
 
-	if (org_ip_request_cntl == 0)
-		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 0);
-
 	if (hws->ctx->dc->debug.root_clock_optimization.bits.dsc) {
 		if (hws->ctx->dc->res_pool->dccg->funcs->disable_dsc && !power_on)
 			hws->ctx->dc->res_pool->dccg->funcs->disable_dsc(
-- 
2.43.0

