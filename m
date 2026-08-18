Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FF0C5DF81
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C9BE10ECE0;
	Tue, 18 Aug 2026 20:23:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ITb9woCI";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012048.outbound.protection.outlook.com
 [40.93.195.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A509A10ECD1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMGl5RENyL+Pa7lMblDUS9BF22XYqfKGy1WOIQUDtBQIR2cGIykEjWdF9RHciAG3dI6taULV2BnrkXpE47N97Cbs1JIC9odAbCbGzZp+BVmFEPG5J2vifz19YiTj8LhzmWscS8u8r8FnAHiG8ZdLsqxzK6yzxdRv6UuhSpWIi8sy3yrt6ECf6sfuZTZm3ZG1XvuOLIAH7eUSb8UbOUIOJfGbvzgMEM3a8Tojs2vG32hk+eU/pmPOAiHGIMIimH+TR4h4TRd+06eHsXEoUJ7PUGlsmePa3CMaLRCPlXdI89EO4cua0SGz0B+8E/3ZRbkHM4W9JSayFW+9dj8CorU4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9h/c2mFA3XDrlaE0VijeYWbR0wbp9nLjfF4+pyQAk0=;
 b=Yv1TzanpJ7fNk28fAUZvZpOHDhV5fCCMseyfmdsLcvUBxNeul7RuqymDH5PgYDB9QVDSYGDOCYTSk5h40RGSN3Nixdd/AGqtxLh7DKrSxXAndtRmb3Z8Jc4l1YHueVVjs1gCo98cXEVXR9U2UtfiF43YJnb7UW8R0enhIkl2ugwm2QPaY1Fi+1GLRSPTCPlDWMynaNmN79wn6s53DxNZQgrlP7pPexwkfq/dZsvMItYaJSoT3wS9pIBT70FEd6R/qyiIdOS051/NXh+1LHheE1el04mrbQHpgvq1QUfh78Y8P0DQkNPE1TEaGiMbz0IOr1kp+qVGvqhZ8FTj5oHjng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9h/c2mFA3XDrlaE0VijeYWbR0wbp9nLjfF4+pyQAk0=;
 b=ITb9woCIYXR18ivd3eofMMkJQQ7SrICl/7PTE+gAQoXqcOBPVoIwVR7p4uXTnQCmx7slT9zxNoFm7WWE8BaW5IRsp6qtMADedd2VSRLhzL4AKkg5g/a08aBB3QVWayImbEO8N00HVLGMfHKQk4NkoPVELjZ1s+9AlUKhPDtBzHg=
Received: from BN9PR03CA0359.namprd03.prod.outlook.com (2603:10b6:408:f6::34)
 by BN7PPF3C1137D8A.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6cd) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:54 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:f6:cafe::61) by BN9PR03CA0359.outlook.office365.com
 (2603:10b6:408:f6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:54 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:54 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:53 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 80/82] drm/amd/display: Adjust vblank_nom policy for HW SDP
 tranmission reqs
Date: Tue, 18 Aug 2026 16:16:12 -0400
Message-ID: <20260818202139.4172592-81-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|BN7PPF3C1137D8A:EE_
X-MS-Office365-Filtering-Correlation-Id: 485ae025-d26e-421d-2661-08defd667c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|56012099006|10067099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: NwsTy6n+6g05GTM7OC8SMql+RMBymOA0ZmsHNZr10cMqXaMJEF4+K9yIh8uEOS45BGMnVpKsYWqpZYJ+pmqrXrIpWPJSJaxIB5TeTRjAJ260f1H4Gb+h5HNLMwpC/a4UhsK4tVOPov3Ky+57sf3UNoOYqmyqqP0Ao8jGY8/2PeQGfyOA67BcvvPrlWqyFp3O9EGZqAQu9v9lXwLKlBxVfuoOCNxbvrhR6A4IV1FZTkPVToVQxXSSsJROzWw4bERIijFv+uUbypkjqZD5pqUFiwoIx2MIxvEtW0tTCXEYb6UxJbEXYOS6PRKfJR0h1Dbb9o9SKbDrKbhVJmTkEg8oYVrfHEdMb59xlhdW5IBQ345c/UVKISyBCkyBmiHNZudf2Mq5EGvuzm+a3XlHBWZ0bQ2BfWndTNvGQwRPqPidXZ7ZA1PTsEPJs1Wvh0PEDjCfx5ZeRlsJ6t17/Bp0LU4yREhZ5xvXOgzdIOYLc6epiKxlH8+VZFYVMgZBMcbgK2YHq/kLQBfgtsEzRy61FvaEWnNQks1GWWprGxNPRe5FqX8+3TDJFSq5ZPZD5qZfrpXqb9wVJgw8vbi5/RDxdgcUC8pjD8ddaVrMwJD747XEbHo0/F3BuJGeK6Yz8vYSMQSDH5BqtrfGRlguC0/Pyb0pKI5ZxsY292RnQ0dsp8dvGZiVuO1ri0AkBCSBjydnENeZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ccepVPzGnsIxFwmzmN8qBY9BFTFDys6h0VdFTMmvsb16f632Ex+iLmnxfg/UhPDQwsXF04x1A4FT0gQOp0TUVPOm4FPMaD3krEb7pjEFBSgneZuWDAQhveJoz7cTQQX+Gsh+gyfNVjEAHiIkDbLNTqph3F07lkZjdrG8qi4zUmcwKMhvJ4jWTyAeSULXYc36AqsRjfnNV2U4tOS1m9gfFb0thvRdubFoRHZenmhT39r7FRbgWHYEq4/nXCVt1EfiO94JaCyRwh7qc803IjB4n10PSGIjfcq8Q8L8lPIhLkR5FRVhzmiZiSw66DEko/4H+LOSYrCsEJFBTPR1jB9vJZ2p8nfWR/TGMM/lc9A/QD1HrA9yHp2C2tiQMDbmGRlQBumzC31thHImbr9rAkBfCw3v2EEbVwcJvwpV9ugZgEH1uy+nBaAB9VM8R1rZLtku
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:54.8645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 485ae025-d26e-421d-2661-08defd667c6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF3C1137D8A
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The requirement is that VSTARTUP has to come before vsync, line 0.
This means that the VSTARTUP has to be in the blank front porch.

The current implementation in DML2.1 does meet this requirement by
adjusting vblank_nom to the full vblank_avail but this has two
undesirable side effects:

1. When vblank is nominal this pushes VUPDATE on the line after VBLANK
   start. For Replay this gives only 1 line worth of time to program the
   SDP and blank the DPG. If we miss this window then we have to wait
   an entire frame before we can retry IPX entry. Residency is impacted.

2. The prefetch schedule is suboptimal. Instead of leveraging a very
   long vblank for power we wake early and block c-state earlier.

[How]
Use the same policy as prior ASIC - clamp the vblank_nom adjustment to
be the maximum of vblank_nom or the size of the back porch + 2 lines.
The back porch includes the vsync width in it in the calculation.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../dml2_0/dml21/dml21_translation_helper.c   | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
index db78810f2b906..79da467ddb5d6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
@@ -101,10 +101,22 @@ static unsigned int calc_vblank_nom_lines(const struct dc_stream_state *stream,
 	unsigned int vblank_nom = (unsigned int)div64_u64((uint64_t)default_vblank_nom_us * 1000ULL, // vblank_nom_ns
 			div64_u64((uint64_t)stream->timing.h_total * 10000000ULL, (uint64_t)stream->timing.pix_clk_100hz)); // line_time_ns
 
-	if (vblank_avail < vblank_nom ||
-			stream->adaptive_sync_infopacket.valid ||
-			(stream->link && stream->link->replay_settings.config.replay_supported))
-		vblank_nom = vblank_avail;
+	/*
+	 * HW requirement for SDP to be in FP ahead of vsync (line 0).
+	 * TODO: Move this out of the translation layer into DC core as per-ASIC policy.
+	 */
+	if (stream->adaptive_sync_infopacket.valid ||
+			(stream->link && stream->link->replay_settings.config.replay_supported)) {
+		const unsigned int v_active = stream->timing.v_border_top + stream->timing.v_addressable +
+					      stream->timing.v_border_bottom;
+		const unsigned int blank_lines = stream->timing.v_total - v_active;
+		const unsigned int bp_lines = blank_lines - stream->timing.v_front_porch;
+		const unsigned int min_vblank_nom = bp_lines + 2;
+
+		vblank_nom = max(vblank_nom, min_vblank_nom);
+	}
+
+	vblank_nom = min(vblank_nom, vblank_avail);
 
 	return vblank_nom;
 }
-- 
2.43.0

