Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5972C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 12:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 546A410EF1F;
	Tue, 18 Oct 2022 12:28:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6064410EF1F
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 12:28:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GT/6cO8A0IeUdfVgvSSzk8T0k16+bcEf9AIJ2xU5lnozN2Z2IzHrtfckrHabE7pLGVzwuJvKnmZnFKjAUQb/uScNeLUN5rL7QC5XPO8X+lxGZpnpjV8SRNGYVRsTEruLYVThPahEP0UWdvPKm2Bi6DCQvkh0Eqs4w/Z00sl4iJf+ehjGUkc1i0IMGhKga2mg06WM+OeEigOqtEcFKRtN3iGng5U4nwAdRIWUhFgXPlsuY/rZwXQi/S255hzEfeO1hC3ewLC+KtGWYSU+/QOiR6uUiZnbr9XYo3Alrb815WMT8UpbzzSdAF2E7PqmP4tlgDJpWJgUpmcUiBH9ub1Tpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdiGA67CqvpeTfH1wdn8vA01AMPrI5Hfjk9t5b7Ehdo=;
 b=GF5yprBjP2CiJg11Ajs4UXRPEphQtkFBuj5PdlqOf4Ja4IaaKIF5zH33Y47Hmt+NI0o0SkaaJ06tKbQpoqyEWLh7uPnXbTHpjj4H6hT6Au2iL7HEt9yinLRBbr1qJ+ooupkoysM0hzy8rHZZgp8cKmWTU6E7hdmZK53BZNTTYqmTrt13nLaa9l7stH55/GEB6hLAwYhcvGkH/Y+nKa6VoOj4nlYvx8nOAeFSCV32f9u7fDct4hosiB+1/C0RKdjLT6rOCZwgRF43rZCiU9YC6qjToKmDyr7Gf0v7m8FrggKHL24w8R4AKXa0f2hfduTRhsn5WbL0w2VqJJk/yEVyZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdiGA67CqvpeTfH1wdn8vA01AMPrI5Hfjk9t5b7Ehdo=;
 b=I+kEKHRr5OI8rm4XpV4z0fV65MKTCnq96Pt1mgsClek3jJAjkM8nqbtWTi7X/reU2L41CaI3zJ48vvIm2ny2tzvLr89TndKdY/bMxvHzdvqtyKMLOyTypPf8ZiRlXkJVjWBMwF8NcH1WEgJJJ30Ec2ayTPvKfji+cYK/w8tKKVY=
Received: from DM6PR06CA0025.namprd06.prod.outlook.com (2603:10b6:5:120::38)
 by SJ0PR12MB6782.namprd12.prod.outlook.com (2603:10b6:a03:44d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Tue, 18 Oct
 2022 12:27:58 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::60) by DM6PR06CA0025.outlook.office365.com
 (2603:10b6:5:120::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Tue, 18 Oct 2022 12:27:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 12:27:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 07:27:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 07:27:57 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via
 Frontend Transport; Tue, 18 Oct 2022 07:27:52 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 02/12] drm/amd/display: Rework context change check
Date: Tue, 18 Oct 2022 08:28:16 -0400
Message-ID: <20221018122826.1790114-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
References: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT067:EE_|SJ0PR12MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: 973c55a5-c43b-4a95-486b-08dab10430e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tRcQs6EYD8swAYWILosRrfqei3qKFkTxgs9znZX1fVdFIDeGVcOBiRWSXuKTq6BbzbBePoV9SDzVdUwmV/nVaIqYYjNWJkHG7nhs/iV1h52RvWl1tuOl9rDMP2ul6xB4Xkt/JpW2pYvcW5WxPaWLXizqMzrgS4D38gUI9bXnUDqeBfKN9xVgdAkEhnXmpddA2ZX3t2DMAb7woM46HfdSgm3xUN61JQlQM/kBsL1WVMBRTt+wfG/uJE+eMJR9OxojHDnVKK6Y5SYCWKJHIRXIP5It9HQYcHyUTffhla/MIR+HYideFu0KdHZS1vwOrI6G3InRjWDkUKdOc+YaR2cQ/vphOs62Nj/7OqaAjPztIQQZL4ujbWA9Gxw23q2xoVYO/7qwl00mcKB4b/4eFGA0eVWcLnGQfGnUIHEUgWtRf4SXfSCto5X43sz+OaROnVjQ6tiLJttcUt80YgC1AYVtLOH1aR7M1rs7RokZb6648hcmQoNKgCuXUohIkaeOn4Af2bmhT1AAgkwYxbWFqmCFoFqI9nrYBwkvFcg5iDTs6h3uNlempvh7Rg3XJr72ZjkasGFFl09b9BtEB58jcoetBKr3dkXBnHHBRxM/3zqdoc6mdSanhQDOoZuz2v2ThNFJAPldklk3nHn48FTHGZoZAUsbWGAojb1gPm51SadQm8hXX2ed8akO+UfLSETSGZfQlfmQz3Hw9kUrRpaF55JFyiwGlhjPyMbAFX+VBTlJVprkqd3WVQQDhxGp+aBUPiaVN9YwoEhWrTpBuu7blI8CYGeIW4KcBx+3JZ8LJs1zYZAFgtZFesN93ekfIyjnR3Hg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(83380400001)(41300700001)(47076005)(8936002)(8676002)(2616005)(70206006)(6916009)(336012)(54906003)(86362001)(40480700001)(1076003)(426003)(36756003)(26005)(82740400003)(4326008)(2906002)(186003)(316002)(356005)(81166007)(40460700003)(70586007)(5660300002)(6666004)(478600001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 12:27:58.3949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 973c55a5-c43b-4a95-486b-08dab10430e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6782
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Context change is all about streams; for this reason, this commit
renames context_changed to streams_changed. Additionally, to make this
function more flexible, this commit changes the function signature to
receive the stream array and the stream count as a parameter.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7b576bd24cb5..9219d1efde2a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1488,19 +1488,19 @@ static void program_timing_sync(
 	}
 }
 
-static bool context_changed(
-		struct dc *dc,
-		struct dc_state *context)
+static bool streams_changed(struct dc *dc,
+			    struct dc_stream_state *streams[],
+			    uint8_t stream_count)
 {
 	uint8_t i;
 
-	if (context->stream_count != dc->current_state->stream_count)
+	if (stream_count != dc->current_state->stream_count)
 		return true;
 
 	for (i = 0; i < dc->current_state->stream_count; i++) {
-		if (dc->current_state->streams[i] != context->streams[i])
+		if (dc->current_state->streams[i] != streams[i])
 			return true;
-		if (!context->streams[i]->link->link_state_valid)
+		if (!streams[i]->link->link_state_valid)
 			return true;
 	}
 
@@ -1895,7 +1895,7 @@ bool dc_commit_state(struct dc *dc, struct dc_state *context)
 	enum dc_status result = DC_ERROR_UNEXPECTED;
 	int i;
 
-	if (!context_changed(dc, context))
+	if (!streams_changed(dc, context->streams, context->stream_count))
 		return DC_OK;
 
 	DC_LOG_DC("%s: %d streams\n",
-- 
2.38.0

