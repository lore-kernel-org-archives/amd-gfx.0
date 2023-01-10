Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627C7C677F1
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E588310E60B;
	Tue, 10 Jan 2023 16:56:54 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C49F10E113
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:56:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9cmpw2Rw1OXDvAWMGS325erfoNcBBwodPYUhc677Gjb/ww8qqPU2+jrQQxEeTG5/dja1JBsJbhH7g0OyJAk8igO5wKUJdDKeD2JnBkNDn006LxHkNMEFfjhuNPTcsA7nxOZaKxky6VcigEnPM9z0bYi/oAx1+fjDL20WLzQ+q+aEtKea9/RjYHwNbOQj49qUo3PvAMlEKp46dvU7D9ImhV89CrOSAUJ19TfN3IHvpH3wOkthqP1k0C0hEPNbeSyVXqT/Rl+MrgI0IKK8tGBdpF13s4bI5xSA7doYrmszcFxQWvw4cqS5Li2HhbACNsdKcdfJOoEgYUwIFQE2Q30EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zi3Y+38CejXgMFRrrl90YoWIc10KrbTiEnsz9OQef5w=;
 b=mcBp2342JOu2ue0xDCjYWK1ulLeLQLdp7CA9nPtsfAYTDb+1w4jMutIvYquTfNEt/2cJrgRM3gcOlv1FE4WVaA1kUnPi0dNl+2PA/xOdkhal2pSRKje2Tc1F6JHjYwzwRjft/Anj7QEZJWW9xNt+D84HVyliu4impxLnHPjcJyQJ8J0hEqikjicmF0k/NMskkKVKyDdHoGBt9dmBcM5PH8U2dfCtltwQhzcRcDmYsftRsClHu+SUuTC1CYQF+xwTMc+HqmBAxapt7wMgksiQUTeg0sH+QY5zNbaSeJNVljIgf+IRYzcq1v6ivD5F+ahj0zjvyfmxAH+oIu7FroqOIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zi3Y+38CejXgMFRrrl90YoWIc10KrbTiEnsz9OQef5w=;
 b=W6/xMfezi8f2Jdc18/PRXdCMsKaCiXK6x/qor7ZgiDln0m2xvg3sr5/os944lgB2sunxc7yMMpuVYyr71GvcdXujI6c05qjRS1Ey/h79yRCz8XNuuIvzqzgpd7hGST0+5YzkUdMbF+zs7JF7MYusRV4VNyNifk0hzYdoP1F+AJ8=
Received: from MW4PR03CA0176.namprd03.prod.outlook.com (2603:10b6:303:8d::31)
 by DS7PR12MB5718.namprd12.prod.outlook.com (2603:10b6:8:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:56:47 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::35) by MW4PR03CA0176.outlook.office365.com
 (2603:10b6:303:8d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:56:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 16:56:47 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:56:45 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/37] drm/amd/display: Fix DPIA link encoder assignment issue
Date: Tue, 10 Jan 2023 11:55:02 -0500
Message-ID: <20230110165535.3358492-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT020:EE_|DS7PR12MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cc3298a-001b-4173-3ca0-08daf32ba950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qZYg/a9Z7w4sPAlgN6q5j9CC1rlVTIbo3B3WhetpgONzNn8xgHF0Q6r79TvwGBhrQ2EBOOYXxQ6RLlKxu0XvfPFFaPWOlwxBkNRfiSUjqsLSe7kDjJJFnCccRWzJT3Oe5uleC+/UKx14xviP3bpm7IZSYciY6UgDs8ZkwVw6zOISzZLAjWguWIdrGyMNkOSxKn+hDBnidapAY9/fVgyWmMgd5PzfyIL9tPEFOqU8X7u93e65aGImE8sKvt2j8aInp/vWHpQxwxZLfLQ94xHKBhcXXsHrGMPvnNvbo5ajxc1ELyTXjN3wgWHmxSwJWUSTW9VMHshWnCe9sgLbpN2F9w5896J5uNE2rXmYGC7rUMd89gbF+gTs6ujVVhBVA6K8W+cXEk2L2zcTfy5fzl6cOBV8WSfaK6zAZLQC4tBU067UqJUDrokr1z3nc1tQevUDFicqGhDQAns+IdecWagijFZBbmh/xX+BLvEWgsl1MyL1atlo1kv/JM7O2ny0HaGjmbgywz4FzFyH0j6+++FPp6Cwe/roMCoPNetuAiPSVu1sKFa82CcGqDcsw/Xh7Rv9KUKx84EvB7mLtSW2sCj+yJdn3pCftBz0Dj2h0+oMvlDocaf/9sYl7giln6VqKokVL/eh1zCKRsMoYpYc0ZlH+a8i+lTW3/eDw0tzkTfPdjRuHEcmBOYkJX7XPbAyIvi15gZERVTBN9UOxq39U52skEX/8MuL+siy2nzwgu+UAO0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(6916009)(8676002)(70586007)(7696005)(316002)(70206006)(4326008)(54906003)(356005)(5660300002)(2906002)(40460700003)(8936002)(47076005)(81166007)(426003)(41300700001)(36756003)(36860700001)(83380400001)(6666004)(478600001)(40480700001)(2616005)(1076003)(336012)(82740400003)(26005)(16526019)(86362001)(186003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:56:47.4691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc3298a-001b-4173-3ca0-08daf32ba950
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5718
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, Cruise Hung <Cruise.Hung@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Cruise Hung <Cruise.Hung@amd.com>

[Why]
The DPIA link encoder (DIG) was not released when a Display XDR 6K
monitor was disconnected. That's because the DPIA link encoder logic
checked the BW when it removed the link encoder for it. And the timing
BW was less than DP link BW.  So, it failed to release the link encoder.
And that caused the DIG was occupied and can't be used.  The reason it
checked the BW is it wants to identify whether this link was using DIG
or HPO. It skips if it's not DIG.

[How]
Not to check the BW when it removes the link encoder because it's
already in the assignment table, it must be the DIG.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Cruise Hung <Cruise.Hung@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c | 57 ++++++++++---------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index 614f022d1cff..049e755792e6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -305,15 +305,17 @@ void link_enc_cfg_link_encs_assign(
 	for (i = 0; i < stream_count; i++) {
 		struct dc_stream_state *stream = streams[i];
 
+		/* skip it if the link is mappable endpoint. */
+		if (stream->link->is_dig_mapping_flexible)
+			continue;
+
 		/* Skip stream if not supported by DIG link encoder. */
 		if (!is_dig_link_enc_stream(stream))
 			continue;
 
 		/* Physical endpoints have a fixed mapping to DIG link encoders. */
-		if (!stream->link->is_dig_mapping_flexible) {
-			eng_id = stream->link->eng_id;
-			add_link_enc_assignment(state, stream, eng_id);
-		}
+		eng_id = stream->link->eng_id;
+		add_link_enc_assignment(state, stream, eng_id);
 	}
 
 	/* (b) Retain previous assignments for mappable endpoints if encoders still available. */
@@ -325,11 +327,12 @@ void link_enc_cfg_link_encs_assign(
 		for (i = 0; i < stream_count; i++) {
 			struct dc_stream_state *stream = state->streams[i];
 
-			/* Skip stream if not supported by DIG link encoder. */
-			if (!is_dig_link_enc_stream(stream))
+			/* Skip it if the link is NOT mappable endpoint. */
+			if (!stream->link->is_dig_mapping_flexible)
 				continue;
 
-			if (!stream->link->is_dig_mapping_flexible)
+			/* Skip stream if not supported by DIG link encoder. */
+			if (!is_dig_link_enc_stream(stream))
 				continue;
 
 			for (j = 0; j < prev_state->stream_count; j++) {
@@ -338,6 +341,7 @@ void link_enc_cfg_link_encs_assign(
 				if (stream == prev_stream && stream->link == prev_stream->link &&
 						prev_state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[j].valid) {
 					eng_id = prev_state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[j].eng_id;
+
 					if (is_avail_link_enc(state, eng_id, stream))
 						add_link_enc_assignment(state, stream, eng_id);
 				}
@@ -350,6 +354,15 @@ void link_enc_cfg_link_encs_assign(
 
 	for (i = 0; i < stream_count; i++) {
 		struct dc_stream_state *stream = streams[i];
+		struct link_encoder *link_enc = NULL;
+
+		/* Skip it if the link is NOT mappable endpoint. */
+		if (!stream->link->is_dig_mapping_flexible)
+			continue;
+
+		/* Skip if encoder assignment retained in step (b) above. */
+		if (stream->link_enc)
+			continue;
 
 		/* Skip stream if not supported by DIG link encoder. */
 		if (!is_dig_link_enc_stream(stream)) {
@@ -358,24 +371,18 @@ void link_enc_cfg_link_encs_assign(
 		}
 
 		/* Mappable endpoints have a flexible mapping to DIG link encoders. */
-		if (stream->link->is_dig_mapping_flexible) {
-			struct link_encoder *link_enc = NULL;
 
-			/* Skip if encoder assignment retained in step (b) above. */
-			if (stream->link_enc)
-				continue;
+		/* For MST, multiple streams will share the same link / display
+		 * endpoint. These streams should use the same link encoder
+		 * assigned to that endpoint.
+		 */
+		link_enc = get_link_enc_used_by_link(state, stream->link);
+		if (link_enc == NULL)
+			eng_id = find_first_avail_link_enc(stream->ctx, state);
+		else
+			eng_id =  link_enc->preferred_engine;
 
-			/* For MST, multiple streams will share the same link / display
-			 * endpoint. These streams should use the same link encoder
-			 * assigned to that endpoint.
-			 */
-			link_enc = get_link_enc_used_by_link(state, stream->link);
-			if (link_enc == NULL)
-				eng_id = find_first_avail_link_enc(stream->ctx, state);
-			else
-				eng_id =  link_enc->preferred_engine;
-			add_link_enc_assignment(state, stream, eng_id);
-		}
+		add_link_enc_assignment(state, stream, eng_id);
 	}
 
 	link_enc_cfg_validate(dc, state);
@@ -420,10 +427,6 @@ void link_enc_cfg_link_enc_unassign(
 {
 	enum engine_id eng_id = ENGINE_ID_UNKNOWN;
 
-	/* Only DIG link encoders. */
-	if (!is_dig_link_enc_stream(stream))
-		return;
-
 	if (stream->link_enc)
 		eng_id = stream->link_enc->preferred_engine;
 
-- 
2.39.0

