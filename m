Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A49D606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kTfoOYYE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2AA610F8C9;
	Wed, 11 Nov 2026 01:41:56 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 695D310F8C2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:41:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ToFR4wkHbvVgRbji8X26e2FTqdQQJ9KqEBUmdBdPb94GGgYG8sQiwo9TcDE4YvE3vpYXFg4+1QYXH+20hZ8JgzUS9/gq5LxEcPFtrTdQM+9MoQtxcmf74y+AR0HrAtq1XnIWGZ820yLYA8AX91kFAjsZ+GZxaXyZL+RIQg7qL2xb79ulf25sYiON0SMhH0Q6gJHeAhWZDkfVoMvTJuZceSv+hy5Vi8Vgq/7VHSQ0X84eaWII8qiesEEv4CmeYmYbi1dxKB8CqtzdBmOtNyS0BEakUHvKIFc3CP0hU6SjLWXR8MDbgBtNqW3/uVd6G/BI2TsazkY3WJCH8W/tuKQ2+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJaKDcdzgwhYw/Z17X0k+wUlVkrTvKubIn/vhcSpuIE=;
 b=oVZEh4hUdlPCRy4j0LbH5G/Qqv6bc1rTxCCu0VP9Q7RtifwQJWAuMq9iIAntQ50OKVCjgavP6461hNc35s9nGS+1kb1q29j9cP3y0LLeoHRnCvTWIeK8vV8l1vsOelq1G2AbbbbBOyYP+LkBTTntcrcr6ipEWsIDxrj/gqbqeajgoj0sf0Flzi7cq/hifoSoeK8LBs+02KCsPxrHgDRDCB6H6ovgQC/bmctU1iDU/qtJ4ZEC2jjXG91ft44hbpUjbWhkPHSUJwsOpQ4wu9uyUcqTEDSGkNRdz9SSyymjfO0PXMKbmlNO9xG9omxFq+xgc5xtxTOM8q6iEElKvktqMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJaKDcdzgwhYw/Z17X0k+wUlVkrTvKubIn/vhcSpuIE=;
 b=kTfoOYYELe7V4uJ5UhsaTc/4+/2ToQSuPJgTptHlN687FAkVUDDijh+KXGuiT6GbwTvdny3X+nNIqiPYvWzudlgdA8rL+Z+ylWoxp8Bk4VeX9jt8LeTtKzIBisqEJg4HLmcrR31cmm7iMa9AA3QKZ72sh+fv2Jp6DVUmNALCJKI=
Received: from BN1PR10CA0021.namprd10.prod.outlook.com (2603:10b6:408:e0::26)
 by EAYPR12MB141103.namprd12.prod.outlook.com (2603:10b6:303:300::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:41:44 +0000
Received: from BN2PEPF0000A802.namprd02.prod.outlook.com
 (2603:10b6:408:e0:cafe::a2) by BN1PR10CA0021.outlook.office365.com
 (2603:10b6:408:e0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:41:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A802.mail.protection.outlook.com (10.167.245.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:41:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:41:43 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:41:40 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 21/74] drm/amd/display: commit validated target when minimal
 transition cannot be built
Date: Wed, 11 Nov 2026 09:28:27 +0800
Message-ID: <20261111014100.3596072-22-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A802:EE_|EAYPR12MB141103:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ffef66-4479-4abf-8372-08df3f94f0b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|261009223027099003|10067099003|261028144727099003|261102123227099003|261026140227099003|261021123027099003|261021121427099003|261022105027099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +jFUzKqH4vI43H/VR501oMaclFTdZ2u6JDBRoZOP7K4zYrTOCdvCFpSvDh0YYWvVjL6w7Jubn6D4UxSy2pPuhlTqcmn0EpNXfQ2GIi6ZXY6lbI3AmZR5ylxDoPxRlixO9bD3U23fEaoRK9DL4JPz7+cD2EZP93gVjC7WwUHDUrVaVhxkoAFVnMrqgfvsxNlCJYq5ZzxvombeoFiQ5Ph8/V5Cc6q9eUlcb6mgcsCYeFb16L6lEbjlG4MLNep2Yz3Whg++ymLjOiWk6XA7ZXTM2ZpBmjjKamRHR/17hgPHKhEa2JN82FRYbmJOy4Gykl9k77CCkyHgSCCv2Pe+o56delquSTqAPAzolDfDpSJeZm06zC8nfQESdjl8OIsD5W5gEvgcChJJPWepn8dvAvKI978q3Ffs8IQPmecGB1Q0UaZxJ+nMacwU+B6eotVNB7+IqLUNAIv242JCWQ7k9RPPzI2306VJzto6p4Q3iVD0T6s7WfItL1UuCZJqRk4kXTzUDPdbXGGXTMWEMODEMIfinYKkH8Ps8D6vXKevnojIJzprMRRokkA9onInh/ielT1HcHo2nh00vhRLT2hwFAz+GH7DDPznRYBlS+wLW+yv+dhNjZNG/ElNDKOTFQWgXw4bX3kCEb7tkfr1OisVV98g2U4BGSrzVzRoD4qwaCJvg/lfDxl++yvkj5CctbKSQjn6dPRyJeeqyTCk/btRWgBMkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(261009223027099003)(10067099003)(261028144727099003)(261102123227099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022105027099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IQgr88Dl3qyNQz06oJPqbuIqA1jlBuuqNdPOlo9o0noSFFES3OKhXG9T8cdH0Cbgs4capSMvwWCYczZcen6GI9GMaazEVj3hGpuiZ+Re6GdaTymZimxeuA8SM32jwTY7GN3hR+1f9gzlKL+iqXu6rNXxV5dpNDe6nsDEJGB45jUe6O7O0R7zJijqnYhpRYtClPLYiFyadiugOOh0QlNsrFp6LW6igMDylH2sKplrFzznuz4dtKSRoucV4B88mzCUhJ/Kvgq2HmHBjjleir/Ie639M6B4tNKrbsYanxKdAqQOhmdLxnecP7Y/EWHaUnar1XzRNAx4ZSSuSYvIfgfYPEkRuQ8X+Tqvds0usSAu1zQN/T2huZTVfytTUkTXFjhuprrFayShrIPZ5zngpwk614iR4ThjgZU2bDJT3pYyZCfJzraxogiFPYfWs1XuaqPZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:41:43.5851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ffef66-4479-4abf-8372-08df3f94f0b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A802.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB141103
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: James Lin <PingLei.Lin@amd.com>

[why]
Before committing a non-seamless pipe-topology change,
dc_commit_streams() inserts a minimal (no-ODM) intermediate
transition so hardware can reach the target topology safely. A stream
that needs ODM combine to meet DISPCLK (e.g. 2560x1440@180 on
DCN4.0.1) cannot be validated under the minimal no-ODM pipe-split
policy, so commit_minimal_transition_state() cannot build that
intermediate state.

The call site then failed the whole commit and blanked the display,
even though the target context already passed full
MODE_AND_PROGRAMMING validation and is safe to program directly.
Because this runs in the atomic commit_tail after validation has
already succeeded, failing here leaves the display blank every time
the mode is set.

[how]
When the minimal transition cannot be built, log it and commit the
already-validated target context instead of failing the commit.

Cc: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: James Lin <PingLei.Lin@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 9d871a821c8d..464a5b7810d9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2711,11 +2711,16 @@ enum dc_status dc_commit_streams(struct dc *dc, struct dc_commit_streams_params
 	 */
 	if (dc->hwss.is_pipe_topology_transition_seamless &&
 			!dc->hwss.is_pipe_topology_transition_seamless(dc, dc->current_state, context)) {
-		res = commit_minimal_transition_state(dc, context);
-		if (res != DC_OK) {
-			BREAK_TO_DEBUGGER();
-			goto fail;
-		}
+		/*
+		 * A minimal (no-ODM) intermediate transition could not be built
+		 * for a stream that still passed full validation above, e.g. a
+		 * high pixel clock mode that needs ODM combine to meet DISPCLK.
+		 * In that case commit the validated target context directly
+		 * instead of failing the whole commit and blanking the display.
+		 */
+		if (!commit_minimal_transition_state(dc, context))
+			DC_LOG_WARNING("%s: minimal transition unavailable; committing target\n",
+				       __func__);
 	}
 
 	res = dc_commit_state_no_check(dc, context);
-- 
2.43.0

