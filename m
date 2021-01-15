Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE300C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:31:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B825F206D4
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B825F206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A94E89381;
	Fri, 15 Jan 2021 17:31:03 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750070.outbound.protection.outlook.com [40.107.75.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B47B989381
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 17:31:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpTr18RyfARl/L2oPVQ5iCq9wUvnMjM8f2w/71FVqB/xYBLpAZpOV3iXWhHHhwy6IK5Tc6YR6gX9T4w0xXGz36a4pbDT99QmjeL0IvwZMc7evjWd1d7EUzWSOF9JqadC4+QjO0Bgyv+kJnlceRth6zpw4Ac6klMg32xSqrfjqygq/0FOKFTUjLrMXLYzGOSz8tHU+nKVw9X0lXuyXKMm06B8ZBnR9U1BhCYCnmp4fl0bsyY4JDtH8EW8tr+vITCwpZYMTspAmrIaiZAgObwduOHQDN1r+YsTNC5ursdN/XtShXDR3nMx4Bkdgz1XBWWJ56PeS/b1Oa8DnAYczms1hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17IGuzHeTB27fw9A87B3riSjxIcvTht/dYXTc/s08pY=;
 b=T2tDBi+1MW+vJaTTnXd6wIkZ3F8s5hxKf1zDcYTCoCyUotOhTWt7wt0k1ilTVcQ6/cR3rGuxhNvz3fH/JpR47qWviRedpGSNjNCtVzxQs8yNFlvNYPEh3Zvya4nr9wIxrMcaNvRosv1V5CXE5xu9qyMRydBqopJAkHXJm435apsJ/hJ5Uxi+4kdOVdQw0cSNwfujzwtnvsenGqlUY9qKrq+Iy7gU1WBScwp8truZmqmHHbzdGMpgoSvpLR3mksEvF8lbfsyOEu8lzWA0y6sLz71S0MRUEmygZ0/6VCPVVyZ5LSqiaRU3K4DhCBK7/0itAJiEnrYIGrM7PGKuQTeGJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17IGuzHeTB27fw9A87B3riSjxIcvTht/dYXTc/s08pY=;
 b=LGER8nCUJlkRqytCd4uFNHC0CYE+LX/UnehdHxiO/Y9yEUORnQ8b+QPSCeYqYs2RHOhMUlTK97t4cxPManmwR84WpIPv1IGnvKabyBLgDsI2sxbzM+qoT/g0oJQHWzF3R/add3k6MMB2DIaT61pKHYciKueiMSUFLfZzFhe1KRo=
Received: from DM6PR02CA0106.namprd02.prod.outlook.com (2603:10b6:5:1f4::47)
 by MN2PR12MB3374.namprd12.prod.outlook.com (2603:10b6:208:c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Fri, 15 Jan
 2021 17:30:59 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::39) by DM6PR02CA0106.outlook.office365.com
 (2603:10b6:5:1f4::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend
 Transport; Fri, 15 Jan 2021 17:30:59 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Fri, 15 Jan 2021 17:30:58 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 11:30:55 -0600
Received: from ajacob-ThinkPad-X250.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 15 Jan 2021 11:30:49 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/16] drm/amd/display: Allow dmub srv hardware reset before
 HW init
Date: Fri, 15 Jan 2021 12:27:08 -0500
Message-ID: <20210115172714.126866-7-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115172714.126866-1-Anson.Jacob@amd.com>
References: <20210115172714.126866-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4ca621a-9dae-4bde-8826-08d8b97b5252
X-MS-TrafficTypeDiagnostic: MN2PR12MB3374:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3374FF7E8D1543A01363DE35EBA70@MN2PR12MB3374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lLqutnjq6k/RU5Blhj5e8kFBhJsYTkrsVojji8D8SlASejvs4Lu/xX7j+0hpZ46Pv790Qu3ZGX2yxenr181hsetyTHFS8F0dUxuzwHsZHr6o7LZum833U2d945Sb231liLRyi5MiYh8dHFtobaCL22GA1c1t+U+LDTIr2FwcymgTEXLtCA2UZOxzAoQPanBV0YBfo1rahUOpS2ZdJdZ2UXyo16EYhZ9MVP2BJ/uUfx+4iszyOfO70MS+tYJsXcamQxIlpM+U8rYRWlEzrQeyXKeBYBHvSAgZPfIdnKAnRwHHOU9hEbAK6gRF3wEnAw6R+VtY7ky5N+ISP3CMsce06odXBWvDaBNaSMTWm0Pe4K+GUOmI1D4ORcGlCehaQBKOV9yP84Ie8R1xhaz7Ygjj+ICvO6E72rJAUHLNkpd8x91w+qUZiCjovt7agdJHytq5GKGdHayjxVypYedalUiXxPvSneFs87g0MrV8xwFdXov8rsoxZi5wL3ncYkCo+y056vZTWtCUSN/qT1JgHgV7gVpaGj4ay9vcFYX8VsAW/1uLAprcIyMUVNb1ELKyIX/+wxEUTsv//C/hV3IAq/23ro4yfhH3OVDD0XKJXRhzxAipKMwDZ30SEN2ww6jLmsBw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(46966006)(26005)(336012)(8936002)(47076005)(82740400003)(5660300002)(6666004)(6916009)(426003)(4326008)(81166007)(186003)(36756003)(2906002)(70586007)(8676002)(34020700004)(86362001)(1076003)(478600001)(83380400001)(82310400003)(356005)(316002)(2616005)(54906003)(7696005)(70206006);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 17:30:58.5192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ca621a-9dae-4bde-8826-08d8b97b5252
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3374
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
Cc: Eric Yang <eric.yang2@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson Jacob <anson.jacob@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
We need hardware reset before hardware init for backdoor loading when
we're reusing the framebuffer memory.

[How]
This doesn't run if the hardware isn't already in reset from software
perspective. The reset function has register level checks so just
remove the software one here.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Anson Jacob <anson.jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index f388d36af0b6..d2588b7cd325 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -489,9 +489,6 @@ enum dmub_status dmub_srv_hw_reset(struct dmub_srv *dmub)
 	if (!dmub->sw_init)
 		return DMUB_STATUS_INVALID;
 
-	if (dmub->hw_init == false)
-		return DMUB_STATUS_OK;
-
 	if (dmub->hw_funcs.reset)
 		dmub->hw_funcs.reset(dmub);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
