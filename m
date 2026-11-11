Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A4F606A326
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zlMVUnjk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80BC810F8E9;
	Wed, 11 Nov 2026 01:44:06 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013048.outbound.protection.outlook.com
 [40.93.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 903FD10F8E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:44:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTFixTNlsiPhAYHgELftzXgPu1ykNFWa16kUzhinqz1kOezmgcBzF7bHQkiGVKRXyY+Yw07DWKoLCkYN+CoLFcLQZkS9IyLME3hnDzTmtPPiOMVMHmkWhg1ushPlEpaZQbAu6YD2xcrEGPTd0CCl6cshSsN7GcqRwCMR7cWKzGEcUE8yuNa8uZy9gnwOsCM1MqbKA/WKNm3HNC3Z10MP0+0Py37KBUNr4RGjyMQbg4m1jIiSkrrpPPpt4Sedw2MWCfHKzTfilN6Ju7zeJEEoprqxx8PihDDGG3ZUR3MeuRVr18RP8DYupSXm/LHYdUHoIx2lwWBsqlq/ftbe3+iUUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CVS/GNB6TGSQcfgYn2h497nihKJ9OTrlIpzlFRmzFI=;
 b=Y5oYdiE6ukM/sLJrahgd6punu2eyxrSZkpDyBkqfzsRTDECsuALWq7BsJraxx4y3DXoTVNKWVajMENWR8ObEVPzYSYCsZfRX+C2r6yCjTqwQei+WzerPfs41pweNq6mlHJ3AB8CRq8OLug26MncmDMLrbRxQ4NUdu9qjL5t3zxNPQ3NDnStaek0kcJvDGdCfDmTPokGikLIIfLDbglOTPvF0c4sIQUoK78+AMaMr0kTyALwOGcZmpAcyD+nluqfahlOLhxUs48wkrCUxHrlkGCrXZ9A6x3qz909Vg/g3FRJydjzhvc174NdCul4jZnPMxkYuhc4fjdXFWCcKMrlaQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CVS/GNB6TGSQcfgYn2h497nihKJ9OTrlIpzlFRmzFI=;
 b=zlMVUnjkaWZihtUaHSVEm9oBnrUA7sfbkzfBCwxXfWiuuEmMB/jZoYya3UypL+mGdoAaBvKpCWiT/+e4aiPOtNIch5WSQk2iKZXnfB5Ls9QvU5NV94yIJOpFYvJhttyd9PsCydat9f0NZi3D8/9/49pbjmUeaQuWpgTD8GkKAd4=
Received: from SJ0PR03CA0031.namprd03.prod.outlook.com (2603:10b6:a03:33e::6)
 by DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 11 Nov
 2026 01:43:55 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::52) by SJ0PR03CA0031.outlook.office365.com
 (2603:10b6:a03:33e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Wed,
 11 Nov 2026 01:43:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:43:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:43:54 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:43:53 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:43:50 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <tony.cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 54/74] drm/amd/display: Program DC2 commit stereo once
Date: Wed, 11 Nov 2026 09:29:00 +0800
Message-ID: <20261111014100.3596072-55-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|DM6PR12MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: 9885432a-6c17-4d84-212e-08df3f953eef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|22082099003|18002099003|10067099003|261021121427099003|261102123227099003|261028144727099003|261009223027099003|261021123027099003|56012099006|261026121527099003|261022105027099003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info: ag5+88zsZxZldwPt2BLqSLR9rEFwH2XPpoSna+f8Z24VYSPo//Twl2dwWz1AGumRKj3AKXbnw8dw5y0E7Z6Aa3E5MJWyX/uzmtFD7PhhznGqL3+hZUcUK3AoiCVED8qZDZ2VUTW9kDt4cVvwTKqHQXPw28AmQuY5K17MY6sRoRquBZBdMTlNSjHH+1tNAFg1XkZr+E9adq7m5MYoigaAHwilV3Ye1cOj3excj6vl+hzL6ITuLUXOVtS/f79aTSDFnaG3BQJqgl/w5YgsB9BOnTbILKNoDjxchbg9wR+DS9MN1LxavmXUz4Ili19efkimp3Q4lY8+Aamim6YLXUoXLRYL3rSn3AYSutA4ct3OvHp3I50EkDvIyMRhuhTZiVmc4S4MfKUjAlHiWxp45pYEIZAY3Wgy5Y4wjJ1HOjGwtRPtnsWtRTH9jO+QoTErDHRBYV++xP6xPmihOLNyrY0TpnglKt0kc+nVEhpWz6iiDgJhMXvEM7WZRHKuXtu3tojJNAqYMtMGF30lEC/UIRkAJDOTFv6OYVtmQsGtQ7HjD76UXv/vfF6TYwShNgKORfO8rivkZ8ow4QZ6s022EiLTX4Ij6ZsFW/La1asGTrAqt8usPc3HLcsAlT0N7X8AZVdR5gCUViUcq7CSyWF+hmrzql2GYSs60u6yFBOP4n37WOBg35b/+ar/bfwqvY4PJd/8Kprs/P3hOqz5R1KPVEkgFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(261021121427099003)(261102123227099003)(261028144727099003)(261009223027099003)(261021123027099003)(56012099006)(261026121527099003)(261022105027099003)(11063799006)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QrKV8HT+6oM5IJpkl6nmUVyQBQBhQLwAiCrj1efUNGBOh2wE0ZmOtNXsKUuaZ6fcadKQOBEejorlrB5DIncN+TjvY+xbdlPXqFiUeCnkvHfZLntVPPi0Zs+sJlF9dNzwF6wnHyM6eYOfE13E2y1tVQxJxNAAqNZgrkDQmcu/WOB1xj7yX3H3ABEwEt4AQar7objJMwTqkV5wPto4eAtPPb/wespGapcVYZDOOpS4GmOJq03zm0vvvBzDmz5e43An0sHd4Urbm4qJJqIrXmVC0Yq86e0u+yrpv1kcEjrA4rMEL2Fi71G6LhYJ+/fl7eZabLCvgwfAjyYOsL9x2xiX9S6Bi+sUB1S/PlTwDcMk0MzPe7bLBoj/UbIgq1gWgWiK207Yyhk6h5jNpreXQ2lNglqbye20+Oz2t/BQ9+VBtRePesDoIm2k1mquqjyWdSra
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:43:54.7154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9885432a-6c17-4d84-212e-08df3f953eef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4170
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

From: Tony Cheng <tony.cheng@amd.com>

[Why]
The DCN4 DC2 commit programs OPP and TG stereo twice in a row for a
stream whose mode changed. Both times use the same values.

[How]
Remove the first, mode-changed-only stereo steps. Remove the skip flag
that only these steps used.

Cc: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../dc/bls_builder/bls_builder_private_types.h        |  2 --
 .../dc/bls_builder/dcn401_non_seamless_builder.c      | 11 ++++-------
 .../display/dc/bls_builder/dcn401_seamless_builder.c  |  3 ---
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
index 0e6733eba83d..784a3cb4d311 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
@@ -107,8 +107,6 @@ struct dcn401_commit_step_meta {
 		} dc_ip_request_cntl;
 	};
 	struct {
-		/* The OTG master's stream has mode_changed clear. */
-		bool stream_mode_unchanged;
 		/* The new state has a stream. */
 		bool new_state_has_stream;
 		/* dc->optimized_required is clear. */
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
index e379793a8efd..d28e162a6632 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
@@ -318,9 +318,10 @@ static const struct dcn401_commit_step
 /*
  * Net effect: finish the head for the new OTG master. program_front_end
  * for a master with no plane, then stereo, then the waits that complete
- * the head's double buffering. legacy_commit_state_hw sets up stereo for
- * a mode-changed stream, then dc_enable_stereo sets it up again for every
- * stream; dcn10_setup_stereo with no 3D format is the two STEREO calls.
+ * the head's double buffering. DC1 sets up stereo twice for a
+ * mode-changed stream, in legacy_commit_state_hw and dc_enable_stereo,
+ * with the same result; one dcn10_setup_stereo with no 3D format, the two
+ * STEREO calls, matches it.
  * The bandwidth lower starts only after these waits.
  */
 static const struct dcn401_commit_step
@@ -335,10 +336,6 @@ static const struct dcn401_commit_step
 	{ .func = TG_LOCK, .meta.tg_lock.lock = false },
 	{ .func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL },
 
-	{ .func = OPP_PROGRAM_STEREO,
-	  .meta.skip_if.stream_mode_unchanged = true },
-	{ .func = TG_PROGRAM_STEREO,
-	  .meta.skip_if.stream_mode_unchanged = true },
 	{ .func = OPP_PROGRAM_STEREO },
 	{ .func = TG_PROGRAM_STEREO },
 
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
index b7f6909d69e0..23951ef4fe04 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
@@ -1944,9 +1944,6 @@ static void dcn401_add_step(struct block_sequence_state *sequence,
 static bool dcn401_skip_step(const struct dcn401_commit_step_args *args,
 		const struct dcn401_commit_step *step)
 {
-	if (step->meta.skip_if.stream_mode_unchanged &&
-			!args->pipe->stream->mode_changed)
-		return true;
 	if (step->meta.skip_if.new_state_has_stream &&
 			args->new_state->stream_count)
 		return true;
-- 
2.43.0

