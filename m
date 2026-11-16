Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9CF606A32A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Qop+5pnG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE4C810F837;
	Tue, 17 Nov 2026 17:16:39 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D832110F840
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:16:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X87zC/J7v1N4dWNcuOQ6cjYcD/ebMq6bbLkc+lJ/NbF93dr6cigOClFEESc9VEx+J/SoeQeBgJT1WdKdAU7PqDDVmGBOjTpjcto9poSUVaJPscURQkgIjPJyYezbKxHr/nJWySu9JM3d3NpWYWfzXjH1VQMNPPMcNOdyVrMxmXZ3iSUAwJxsFYTHTmBnDJPrkW+r759AW1KO+/liRpoB2dgFiyC88ZZUc1ziW2ctGWEoa6OtZgYHUwmq2OdG4iyVTp49+fbxYNatzb/ubNnU8W8/be6AnRb5QfWL6BgRyYRek1DVb5oQTAvPhVLibkzQKyNW8CSmqGxwr10BkjO89A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRGt8cBu6KDs7zoHi+pq7wpL2+r9oRvmklTJdBeYgPs=;
 b=W3WG3NQYIHBa3v7O/fB+32CKd88YDiJUkrbWppk1qB3bJrpwHqWbx7Yr67Z+fx4046K+rzqQUpAeIazZTAvFYb2vdxPOVcpWw2wObhWCfezdjKv0UqVcsDjuGhknX/UyRMV9H/vPUVfr1KQfqRyZRAIPmRb6k+s1EsoOIf5qhLhL7/157xijwUA6Nj0DmE6aBG0z79/URnrTDKQ+tTHpJMMFoNFLUpPCjKhYfeZWFwm2WQMtNLMum1e+HM4F9SiyLxdz/4cJ+Rg0vFHhkacOrRf7kwx6Ndm5CJ4xBclAxJB2eLaY9PxdURM3hdohvKfSwm0Wz4cA62Edmje4mSLbMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRGt8cBu6KDs7zoHi+pq7wpL2+r9oRvmklTJdBeYgPs=;
 b=Qop+5pnGqak093HJy1myjRRByouBdV8iN0vjWa5uQdv5V/2UNcpIfyNZZq0a8s4qod2h1feOfMaarv+sdabyR094TYWhXSfqNmWda7w733kFFv0EwlauOqitfqR4EI4X1h2hq0hvnoGDKOXnnA7/aTENSM9PLYCqDYwdpM/9cKI=
Received: from BN9P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::31)
 by IA1PR12MB7518.namprd12.prod.outlook.com (2603:10b6:208:419::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 17:16:29 +0000
Received: from BN1PEPF0001806F.namprd04.prod.outlook.com
 (2603:10b6:408:10b:cafe::1) by BN9P223CA0026.outlook.office365.com
 (2603:10b6:408:10b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Tue,
 17 Nov 2026 17:16:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001806F.mail.protection.outlook.com (10.167.245.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:16:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:16:15 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:16:07 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <tony.cheng@amd.com>, James Lin
 <pinglei.lin@amd.com>
Subject: [PATCH 24/33] drm/amd/display: Let the DC2 commit replace or keep a
 stream
Date: Tue, 17 Nov 2026 05:51:01 +0800
Message-ID: <20261116215641.2800595-25-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001806F:EE_|IA1PR12MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: f0dc1005-cbf9-4ad0-80b9-08df44ce84de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|22082099003|18002099003|11063799006|56012099006|261028144727099003|261021121427099003|10067099003|261021123027099003|261026140227099003|261009223027099003|261102123227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: 4tz0/398oMquiEN2/l1LHNOz8YZ8K22yE8lmr/AGcFNam/ze2K3/bdIQ1bILfpzqy4h6zzrPX1y/llmBnKkAaUaBiFNyanyDxn85YTTBp42cTZd0DuKl1t1W7PqlwanCy/bTPej80Dm/gKnl2yJU2CtCvw7tFqSXr0viNa0fTSGenlC2Gh3QV5UBYbVEm/G4OMpWCdecK+zDrNNOjqMFe7BQx2OIc+Pcx8CS9OAO/iWflh7mtaAJL2tErV8eP9cYNG+1Q1A3JkrViNJPSrtOLx9L4wNZHsN8NxyOxxOplj4yBgecXk2Is0mFGZgNDHvrcUkcXUQIb6anpvYrehCwlMT4pw4W0/KMEXhRLVmXFhXNCu1E5nEonPZr5Pufi3wVnelbw19E4O8SBIsbZH6NTNpB9hemGnjR/EJz99dftWMEgg2aYF/gvnOtlLBhlCWo5U97WFdhdNOK0RUdJfxPXTw0kQbnPHIJF3NLuMRQfzic26cSNVhbUpbJeTx/LLekA7A3/vvXuPXSu9CH0nwCrqPGwhHrMYfeNWWfYXnqDOZtde0QEeodof1+Qp2u1P4mJrBhD/XlKgOjpIn9UjNcvPYlWmWzDvyIuWASZ0+jnOGNXv1acHjNz5uAgOW0ies1HO+xs8qvTydnxUy7YzxvbJkbl01ljzSFiSjnY7U64ql1lhE7rBpj8wOwGUbxd8JJXDOllMhBN97sAsGL/rqwNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(261028144727099003)(261021121427099003)(10067099003)(261021123027099003)(261026140227099003)(261009223027099003)(261102123227099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HIkewmio7HfLJ4F9z/iGKeThdqYy16e/lybOsaRAw3AYVTwQtydd0utLoFz+i2+kzlzILmRnYfdQYGhnS6UUH0miB3ruvJ7vvLH7sD30KiHgwHSIOHIiXGrgrKOTFUkGY3yoi0PmS+NuiuNGNVY4WLfjXV0dDMdbWiNiwG+5lcz/bhhqsG4pn2k8GN/NoCjWe5s7GkYlsdk2OPMkNXRapHrpX+WUOg+j0S2J/1lgD+CEMUzowleq730dkQTF1PTs9eolz0m5mZIClLqmNDqxX2/ajEQ5SrNddshQ94EXDsM8Z/yjZNFZaeoDz9u6Ng2HAHdQEn8GEKEB2oJXiAqikdVmpxDNBO4fZ/EEIQfWR1CXjjReOZONvvzbi/Rn/G/L711xLPUvEDbCUi1EzveSftYaa8PERKyOEPuWeVjx9fJz6DVjORO/qW/Ri3+4s1x5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:16:29.2499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0dc1005-cbf9-4ad0-80b9-08df44ce84de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001806F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tony Cheng <tony.cheng@amd.com>

[Why]
The dcn401 non-seamless commit builder rejects a commit when both
states have a stream, or when the link of the new stream is active.
A commit that replaces a stream on the same link fails.

[How]
Remove the check that rejects a stream in both states. The builder
disables the current stream before it enables the new stream, so it
programs all pipes of the new stream again. Accept an active link when
the current stream uses that link.

Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../bls_builder/dcn401_non_seamless_builder.c | 24 +++++++++----------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
index f9aa8f0b9b1e..d5adbef8a6f1 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
@@ -139,24 +139,23 @@ static enum bls_builder_result dcn401_check_commit_state_support(
 	return BLS_BUILD_SUCCESS;
 }
 
-static bool check_stream_not_kept(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
-{
-	(void)dc;
-	/* A stream is either removed or added, never kept. */
-	return !current_state->stream_count || !new_state->stream_count;
-}
-
+/*
+ * The current stream is disabled before the new one is enabled, so the
+ * link may be active when it carries the current stream.
+ */
 static bool check_link_not_active(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
+	const struct dc_link *link;
+
 	(void)dc;
-	(void)current_state;
 	if (!new_state->stream_count)
 		return true;
-	return !new_state->streams[0]->link->link_status.link_active;
+	link = new_state->streams[0]->link;
+	return !link->link_status.link_active ||
+			(current_state->stream_count &&
+			current_state->streams[0]->link == link);
 }
 
 static enum bls_builder_result dcn401_check_non_seamless_commit_support(
@@ -180,8 +179,7 @@ static enum bls_builder_result dcn401_check_non_seamless_commit_support(
 	if (result != BLS_BUILD_SUCCESS)
 		return result;
 
-	CHECK_CONDITION(stream_not_kept, "stream is kept across the commit");
-	CHECK_CONDITION(link_not_active, "link is already active");
+	CHECK_CONDITION(link_not_active, "link is active on another stream");
 	return BLS_BUILD_SUCCESS;
 }
 
-- 
2.43.0

