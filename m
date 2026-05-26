Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED64ACD5BCF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:18:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C00C10E4FE;
	Tue, 26 May 2026 07:18:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1zP9LqGr";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010012.outbound.protection.outlook.com
 [52.101.193.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E89810E4FE
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:18:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9NdKeKvMyji2RHRJMUcSBpGf7YqTdCsxG/mCzeuTtf31an11vlIomzzu18RmxnT6/o3f2MUFrJ6o9ONUi+i3KvLjp/3WTIX23OBObE5IzP17y8/ue4uACgR0cYajDTS9pPkUJqAoYUkp3A+XGS4FG2XvRAj2TLhmBLRIg1JZpIyMwvrBIYybNm2XWZPbgTghaPHRJ/+npF7QCeZk+JvThiW2bEDGL5hJzqk1B96nxi09OmY92OIu4mph/84dSRCkUTqv/KMaEDEDslfgO4uBjyabNApBCJJW2+mcuqA137KQII22XvWpzpZobUVpFDJJhl7nZPi/yRGSWL2XAXoeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18DhhwVj29ZfM43NF4AqPp3JyI/QA0MNnZpWZrUPF64=;
 b=QGNw4u0QH4JjG9k1PjNxNaDoA9ZbXsnzOGYgPTkqVIh57sklP6oZTppE22TXwtm4cNwF/Au6khV1Cvq1tJP8wVxhJKVoQvnBAFwC+JW9FhqJTJAZJgMsmtC1GhitWMKLjHfklZzoDUDqGvsdBAaMnEqUXlFIPby4n5h+XTKdCbKJcwpjmkYAB99KEKain3oxQpr84ULpxtSnz6EfIv9yhBg7N65LVMeTPb4fG7C1S6R/jMhZRBOXZaSSez36ZNxQ4vlJAgvDuNDHEOEK69UT6xYFjhcLenT4HturoZRHe4tHqmTcwBiQQ7YR27zNCEpm+OkPNG60dvKXvgMEOVI/tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18DhhwVj29ZfM43NF4AqPp3JyI/QA0MNnZpWZrUPF64=;
 b=1zP9LqGrs1SJ+mrMQ69cDJsPX/TwcHnI0JAQbLW5PYGkO6q4gxRgufX1DtJ164ggJZgiM4QZ2bov5+60ek+W91t3hBEn6TMKHZo8CPaCrwQ+V2opbTx3ztgdRd2HzQ1JGeuEP3ugaZ/LiFwkL0Ecyv/M41PJ0X1Ar+bH7j0L2aQ=
Received: from PH7PR17CA0019.namprd17.prod.outlook.com (2603:10b6:510:324::16)
 by PH0PR12MB8006.namprd12.prod.outlook.com (2603:10b6:510:28d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 07:18:18 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::92) by PH7PR17CA0019.outlook.office365.com
 (2603:10b6:510:324::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 07:18:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:18:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 26 May
 2026 02:18:16 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 May
 2026 02:18:16 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:18:08 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 27/41] drm/amd/display: Extract dm_ism_dispatch_next_event
Date: Tue, 26 May 2026 15:01:50 +0800
Message-ID: <20260526071413.2181251-28-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|PH0PR12MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ecbb2c5-a835-4e58-a988-08debaf6f545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|22082099003|56012099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: HY1l99mXI8UvGxs649Keb6y91/aLfAqslE6wyWHMxwzeR5R/VPm0vY9M6x4A28SGXz1VtPRVdEgsgWCTHEyv2akwTiFh39ZwkGUcL2l6aMsoa/TZkwB3Ldr9R0wyltvHd/yfzV/e7VkzAdFlYricnx4NPH1NbDlZK9LysuANtGGFH5amjx0CwXvOkZH7vwPb/SJdrfSJ2s+U1oOsKvNv6PRfgL7TJyGuG7Z5xcsM/go1xuaw2t0BUlF6cq6mGYgFckx1is1gIq9gsS1sRhRnEAuUfSLv/wEtxuvQ1W8e2kvu/+L5MmwyWbzapqLJxk2/A3sZt4ru6EvVYBtmqrP2lDcB0LDDAzQkCadxJWAWAb8u0G/4OQdt5OySFTsprWHfVFeNQ3njFhQtMfd6g95gAjmNDdS8OHfd2niHgOEULhyaGAbddt+hm0LkKHeWStIxPbzrdz041ENJ23e+FM1HYdofAWZFpT3D0ffS89z7iwvdeC6A83ijV8yHdH7/Kut0vOmFYulA7nskvwGdzy6xkgMVK7w89UvOlyCH0ot5yjCvyk2RBuofVMuuNqwDKWU0pa1CyTxRiH5y6XE6/GjByVkUEQ7CpvV0DAmFTr2TnvhBIZiD1szAEqsNjoB5oLIjcJ9fnM6zo1RLEIRWfX9iDdDjVgWHIjJz+UMPhSPjHu5DPQUbZ7gXc6d6JM9eOlZ/M9u0V3a180qgKLBxN2QUGuNQ3MUcdG+wcTy42DSKWtg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(22082099003)(56012099003)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2UlFZqLsoTJggHUYaqCOEnPIAa+8WpfQJix5/wnYdUrIzZho7U7e37/4yPDfZ47S/DK1lfR1wLcLUpVeN/NzF09m8YkTLIAYbzoevG2jNTbrI9ItZaeq4V6u0r/SnwuNaHzUaxPLVSRnYERkXqMCnk/DoetuiwiaVjlfLK98qu30lnFeBNoKefPsZoq3+o8/LLantYEEeb65OAxl4RgPEmFd12SDg/MNrOVRMvg+3qLPVb25CZxp5+sy1JeO0wYELDK6qIStBagFeRhxJa0kcHqxui23zT2KH73CxFYhnlIKcNmJ4pyyAwjCoZb1adm1FidkO11hmRrEtz5sx0sjieCMV3XC3u6b441fUH5f0GQwEtR50ekruPt0WFRxmeDDjpaAY6XZFRSdcpSuC4iDPYAJ2ZdpWlTRX3OOPw0t7/BHKozwdUgXDYJUpNLgzrEs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:18:17.2168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ecbb2c5-a835-4e58-a988-08debaf6f545
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8006
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

From: Alex Hung <alex.hung@amd.com>

[Why & How]
Separate the "should we emit IMMEDIATE?" decision into a pure,
side-effect-free helper so it can be tested in isolation without a
full DRM context.

- dm_ism_dispatch_next_event(current_state, delay_ns, sso_delay_ns)
  returns DM_ISM_EVENT_IMMEDIATE when the state requires an immediate
  follow-up (HYSTERESIS_WAITING with zero delay, OPTIMIZED_IDLE with
  zero SSO delay, or TIMER_ABORTED), and DM_ISM_NUM_EVENTS otherwise.

- Removes the passthrough event parameter that was always
  DM_ISM_NUM_EVENTS at the call site, making the sentinel explicit.

- Drops the now-unused event parameter from dm_ism_dispatch_power_state.

Assisted-by: Copilot:Claude-Sonnet-4.6

Reviewed-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c | 71 ++++++++++---------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h |  3 +
 2 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
index 0a010802540d..5c0841728671 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
@@ -332,15 +332,36 @@ static void dm_ism_commit_idle_optimization_state(struct amdgpu_dm_ism *ism,
 	}
 }
 
+STATIC_IFN_KUNIT
+enum amdgpu_dm_ism_event dm_ism_dispatch_next_event(
+	enum amdgpu_dm_ism_state current_state,
+	uint64_t delay_ns,
+	uint64_t sso_delay_ns)
+{
+	switch (current_state) {
+	case DM_ISM_STATE_HYSTERESIS_WAITING:
+		if (delay_ns == 0)
+			return DM_ISM_EVENT_IMMEDIATE;
+		break;
+	case DM_ISM_STATE_OPTIMIZED_IDLE:
+		if (sso_delay_ns == 0)
+			return DM_ISM_EVENT_IMMEDIATE;
+		break;
+	case DM_ISM_STATE_TIMER_ABORTED:
+		return DM_ISM_EVENT_IMMEDIATE;
+	default:
+		break;
+	}
+	return DM_ISM_NUM_EVENTS;
+}
+EXPORT_IF_KUNIT(dm_ism_dispatch_next_event);
 
 static enum amdgpu_dm_ism_event dm_ism_dispatch_power_state(
 	struct amdgpu_dm_ism *ism,
-	struct dm_crtc_state *acrtc_state,
-	enum amdgpu_dm_ism_event event)
+	struct dm_crtc_state *acrtc_state)
 {
-	enum amdgpu_dm_ism_event ret = event;
 	const struct amdgpu_dm_ism_config *config = &ism->config;
-	uint64_t delay_ns, sso_delay_ns;
+	uint64_t delay_ns = 0, sso_delay_ns = 0;
 
 	switch (ism->previous_state) {
 	case DM_ISM_STATE_HYSTERESIS_WAITING:
@@ -374,30 +395,15 @@ static enum amdgpu_dm_ism_event dm_ism_dispatch_power_state(
 	switch (ism->current_state) {
 	case DM_ISM_STATE_HYSTERESIS_WAITING:
 		dm_ism_set_last_idle_ts(ism);
-
-		/* CRTC can be disabled; allow immediate idle */
-		if (!acrtc_state->stream) {
-			ret = DM_ISM_EVENT_IMMEDIATE;
-			break;
-		}
-
-		delay_ns = dm_ism_get_idle_allow_delay(ism,
-						       acrtc_state->stream);
-		if (delay_ns == 0) {
-			ret = DM_ISM_EVENT_IMMEDIATE;
-			break;
-		}
-
+		delay_ns = dm_ism_get_idle_allow_delay(ism, acrtc_state->stream);
 		/* Schedule worker */
-		mod_delayed_work(system_dfl_wq, &ism->delayed_work,
-				 nsecs_to_jiffies(delay_ns));
-
+		if (delay_ns > 0)
+			mod_delayed_work(system_dfl_wq, &ism->delayed_work,
+					 nsecs_to_jiffies(delay_ns));
 		break;
 	case DM_ISM_STATE_OPTIMIZED_IDLE:
 		sso_delay_ns = dm_ism_get_sso_delay(ism, acrtc_state->stream);
-		if (sso_delay_ns == 0)
-			ret = DM_ISM_EVENT_IMMEDIATE;
-		else if (config->sso_num_frames < config->filter_num_frames) {
+		if (sso_delay_ns > 0) {
 			/*
 			 * If sso_num_frames is less than hysteresis frames, it
 			 * indicates that allowing idle here, then disallowing
@@ -405,13 +411,10 @@ static enum amdgpu_dm_ism_event dm_ism_dispatch_power_state(
 			 * have a negative power impact. Skip idle allow here,
 			 * and let the sso_delayed_work handle it.
 			 */
-			mod_delayed_work(system_dfl_wq,
-					 &ism->sso_delayed_work,
-					 nsecs_to_jiffies(sso_delay_ns));
-		} else {
-			/* Enable idle optimization without SSO */
-			dm_ism_commit_idle_optimization_state(
-				ism, acrtc_state->stream, false, false);
+			if (config->sso_num_frames >= config->filter_num_frames)
+				dm_ism_commit_idle_optimization_state(ism, acrtc_state->stream,
+								      false, false);
+
 			mod_delayed_work(system_dfl_wq,
 					 &ism->sso_delayed_work,
 					 nsecs_to_jiffies(sso_delay_ns));
@@ -426,13 +429,12 @@ static enum amdgpu_dm_ism_event dm_ism_dispatch_power_state(
 		dm_ism_insert_record(ism);
 		dm_ism_commit_idle_optimization_state(ism, acrtc_state->stream,
 						      true, false);
-		ret = DM_ISM_EVENT_IMMEDIATE;
 		break;
 	default:
 		break;
 	}
 
-	return ret;
+	return dm_ism_dispatch_next_event(ism->current_state, delay_ns, sso_delay_ns);
 }
 
 static char *dm_ism_events_str[DM_ISM_NUM_EVENTS] = {
@@ -487,8 +489,7 @@ void amdgpu_dm_ism_commit_event(struct amdgpu_dm_ism *ism,
 				dm_ism_states_str[ism->previous_state],
 				dm_ism_states_str[ism->current_state],
 				dm_ism_events_str[event]);
-			next_event = dm_ism_dispatch_power_state(
-				ism, acrtc_state, next_event);
+			next_event = dm_ism_dispatch_power_state(ism, acrtc_state);
 		} else {
 			trace_amdgpu_dm_ism_event(
 				acrtc->crtc_id,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h
index da3e192e8d25..afce16f7085a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h
@@ -161,6 +161,9 @@ void dm_ism_insert_record(struct amdgpu_dm_ism *ism);
 void dm_ism_set_last_idle_ts(struct amdgpu_dm_ism *ism);
 bool dm_ism_trigger_event(struct amdgpu_dm_ism *ism,
 			  enum amdgpu_dm_ism_event event);
+enum amdgpu_dm_ism_event dm_ism_dispatch_next_event(enum amdgpu_dm_ism_state current_state,
+						    uint64_t delay_ns,
+						    uint64_t sso_delay_ns);
 #endif
 
 #endif
-- 
2.43.0

