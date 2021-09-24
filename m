Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA37FC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 987B161250
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 987B161250
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B1A56E217;
	Fri, 24 Sep 2021 19:10:18 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2063.outbound.protection.outlook.com [40.107.101.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DB856E218
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 19:10:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUiH+9fFfBk1jIVGsZQE9NlruKBKtqc0Jact7YjrHKnKzB3MyfDfKDxYjjUOjK5OghrVJmQlsOWseKn6s/VjJradVRE1TmSf1BIlHOGC7hwzmW819MgW+6tfb3ks5UiEJBIXhYL3ATp/xjknBlDdQM2bfz3kHgvHa71LNNPOsdBGQ1cbSdhQqXRsfUg8QA6ASc1kdp1DkYcHkCT8vrZ72rl7QjwI0rLtzsSg8il+pYRg4YvMx5Js5NW///IzIfYmx+On/Cw0Nb12UatUL/U+0523EtkTdWmPip/ySxYA9/HnBp6pUy2jM5qC+MgPCEf+xVhsKJiKqjn7fNlfiC8Htg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=pwrN4DR2MIVh7VHuNTRx6TvqOvLvIOsV1trrt7xr1vw=;
 b=ixQVW9+dk0g/OPnZHoRcZ07JACg/kO4Ie6EqTGvwnNP8ALnJFPmYNDAFXBY1GVEsgNW0LbTdpGMY2eLYpGIf3Ix/7SQ4V1RSLvqCyfx1+n6+1TZThJcu1SRpYX9UMsNnBATRCDKH84tr72zVfnHZLeJ0OOCB+juSeJDHFcI9gZUI9SZ8V/o74NBuaUvcxq+AQGT+aZLo03bUlISdh6LStIcq79TFP01dyPlWYBFBU+ZFftzvbGTubTTwCT9KkkMgD/Ai8HspKfEqex04BuZ/UcqFda9Al6x+P3J3zD8LhTnuNCxqCDl1ujrbJJPtI048IujGobQm45yblOXsUOytrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwrN4DR2MIVh7VHuNTRx6TvqOvLvIOsV1trrt7xr1vw=;
 b=w26mVWyTuq7jdId7dJcsa9+ATeibDOH2ZSWrvm6ERmEbLutqsXJfqAADIPfVUA1xJM3eaOhTgkGgTZWI7gno10im4G752W7rEy7erWgoCfxw8MA3/WZMATEYLwp3auK6XVetZfI3RWctMhpe6Q+wh2LcWvPOfhjTLcrhtlkBYg0=
Received: from CO2PR04CA0058.namprd04.prod.outlook.com (2603:10b6:102:1::26)
 by CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Fri, 24 Sep
 2021 19:10:12 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::6c) by CO2PR04CA0058.outlook.office365.com
 (2603:10b6:102:1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Fri, 24 Sep 2021 19:10:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 19:10:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:10:10 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Fri, 24 Sep 2021 14:10:08 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Jun Lei <Jun.Lei@amd.com>
Subject: [PATCH 13/24] drm/amd/display: Fix MST link encoder availability
 check.
Date: Fri, 24 Sep 2021 15:09:23 -0400
Message-ID: <20210924190934.1193379-14-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924190934.1193379-1-Anson.Jacob@amd.com>
References: <20210924190934.1193379-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6dc2454-ef5a-4979-c8e8-08d97f8eeeca
X-MS-TrafficTypeDiagnostic: CH2PR12MB4103:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4103E2DEE4A44043B2C2801DEBA49@CH2PR12MB4103.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nIi6vxg5g2/GIPJj7Ds6LcmqaxwnVy71S+GVenVcZvFoPKJsD1q9VeovZc7SLwPlZ65gLa+rRyGCJhoBc9ObhJtYpG9c0qi35KntlRvvBRr1eGi4j08A3IKkylf4zXIBfuWPDH83AFmhy/Hx6hF26hAarkMOhBMoDyrsv6UTpZQqZ+bUE/DqDaREadxsdj9Z+wQiZYQxL2iajP0YXCfulkgn5QEFPmXPFOjz6qqDClfz0QPxT8g8GAnoIs56N3ey2ylrRnZyR2/1dkE6VFzOo8NgrUhMI12Xyr18QHD9Ow46oZ859p2XiEeFyQv/loQUvVdJB1OVQ6/7m91419+RzA1D00BClSyU8gQCzZ4hxCsPAbnlKb89Ag/nKJVTvI2pBWhFRV8lNPRP6W47jxjBfFo2+DmiajshxMXJL9c+YKsgIlDS5S3JFbi9ggQFTqkPZrId3Z5xMgUxSnyMJe3TyswOJ/3nrk6pVncOr4EYxByI5htx0fIJDcQHyYtUJJr4JWXpYIM2Pb7rJ0N+GYuK+D+PCO8BPE80tnf7GiPMiERd3ppwM+A61fzm5gyD03GAt0mnJJlcW6CBLdQnLF4jm15iMCGMaTjOKYBZixNUBMOZJGhuuQnW4eNB/GzHmRpwpPWoKVAonRvRAjo3w7xlMjlMS9AMu5ottcNE4S5/68aLyQWTDeZrxX/DR3x7OACVBb3RJ9SQig4zJ6ajDdIsQ4pvB9gQst9kTJ7Rw3U8/rQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36860700001)(8936002)(356005)(7696005)(47076005)(70586007)(2616005)(86362001)(83380400001)(316002)(186003)(81166007)(8676002)(26005)(70206006)(426003)(4326008)(508600001)(54906003)(6916009)(336012)(2906002)(36756003)(82310400003)(5660300002)(1076003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 19:10:11.6477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6dc2454-ef5a-4979-c8e8-08d97f8eeeca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103
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

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
MST streams share the same link and should share the same encoder.
The current availability check may erroneously determine that an
encoder is unavailable for MST streams.

[How]
When checking for link encoder availability, check if an encoder
in use shares a link with the stream for which the availability
check is being conducted. If the link is shared, then the link
encoder should be shared too and will be deemed available.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index 4dce25c39b75..1cab4bf06abe 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -1,5 +1,4 @@
-/*
- * Copyright 2021 Advanced Micro Devices, Inc.
+/* Copyright 2021 Advanced Micro Devices, Inc. All rights reserved.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -177,13 +176,27 @@ static enum engine_id find_first_avail_link_enc(
 	return eng_id;
 }
 
-static bool is_avail_link_enc(struct dc_state *state, enum engine_id eng_id)
+/* Check for availability of link encoder eng_id. */
+static bool is_avail_link_enc(struct dc_state *state, enum engine_id eng_id, struct dc_stream_state *stream)
 {
 	bool is_avail = false;
 	int eng_idx = eng_id - ENGINE_ID_DIGA;
 
-	if (eng_id != ENGINE_ID_UNKNOWN && state->res_ctx.link_enc_cfg_ctx.link_enc_avail[eng_idx] != ENGINE_ID_UNKNOWN)
+	/* An encoder is available if it is still in the availability pool. */
+	if (eng_id != ENGINE_ID_UNKNOWN && state->res_ctx.link_enc_cfg_ctx.link_enc_avail[eng_idx] != ENGINE_ID_UNKNOWN) {
 		is_avail = true;
+	} else {
+		struct dc_stream_state *stream_assigned = NULL;
+
+		/* MST streams share the same link and should share the same encoder.
+		 * If a stream that has already been assigned a link encoder uses as the
+		 * same link as the stream checking for availability, it is an MST stream
+		 * and should use the same link encoder.
+		 */
+		stream_assigned = get_stream_using_link_enc(state, eng_id);
+		if (stream_assigned && stream != stream_assigned && stream->link == stream_assigned->link)
+			is_avail = true;
+	}
 
 	return is_avail;
 }
@@ -296,7 +309,7 @@ void link_enc_cfg_link_encs_assign(
 				if (stream == prev_stream && stream->link == prev_stream->link &&
 						prev_state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[j].valid) {
 					eng_id = prev_state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[j].eng_id;
-					if (is_avail_link_enc(state, eng_id))
+					if (is_avail_link_enc(state, eng_id, stream))
 						add_link_enc_assignment(state, stream, eng_id);
 				}
 			}
-- 
2.25.1

