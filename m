Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312ABC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:31:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D38206D4
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D38206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88BCB897D0;
	Fri, 15 Jan 2021 17:31:21 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680045.outbound.protection.outlook.com [40.107.68.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAEA189728
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 17:31:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mh35CTi/VcyLhwdlqv6RbdOgmv8aWbqj0bCC9S8W9iQ2i+Fc/7FBoyTTMoArSPk5YphKg9iIR5LWAszDRnhMF9F3QyxW2oKI06YiMm4nb2drKm/LYyzZbbiq1ox9DKuBdSWkmbdTeNQNEUF4Yo7Wl8Mv9sNfTRpGF1Lxvj6N7JKdyeTPh4rub9wiGZ33hlsoJw0CqXsRdMnzfzGzeean92BzUg0yjh4wgZuqladtvns01GPrjyey1bWTh4UpiOZU35tKIc5zDbJA94RuEaCBb1aFrAWaRDDJGPiuyXfzQiV0ee1tZgRsIcEA0SOxGtgprhe6cgHBW9VICXvGikjrMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nj4XEC7GKTWvhKY7/yz5c25ZUBxa0BI1YkoIG1DcQpI=;
 b=GZfBQlRjpeOW/VjrufAyWlL+cwe0j9xTioufntjS0Zt90I9vEyYzegirqZiyJJo3HOsY5FD0RR8wA06FHkM0d1+9nttML1l/rusLzTjv94NaQG9xwaD/mqu8qGH086dN9j6TDh3noLKZOX78syQtQZWgsf1xv/UcuxS2x454mtU/XLjfrNJKOsdQ5RD2NzBrWi0ZMkG1iZfARVjCmroFQJBZS3fqqWMdFn6SjM2w6IiZo00PtLQs/+00+KxYfkYb2XEglkHEwEd7ejBzXqTW7rnKgUupvJd/VkJKcNCwhCrRKEXWMFRojqU54XzT6A78JGn8AnKxzrMYjyVzSJST+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nj4XEC7GKTWvhKY7/yz5c25ZUBxa0BI1YkoIG1DcQpI=;
 b=256hyR+S04DRrB2iCi9IFEv6RyNLQyTKcpljYCB/VWGSh37P786dko0qRwdZYaV/sGCau81dR0vsuG9rqP/GOH+WDwofohcIoWNYJRR+rSaqE6wDspk7T8PRAWkW0aO89VkS0uDvN6vObJuL0UzpPRZ7uaO6pkLHgf14obdj9m4=
Received: from BN4PR10CA0007.namprd10.prod.outlook.com (2603:10b6:403::17) by
 CH2PR12MB4906.namprd12.prod.outlook.com (2603:10b6:610:6a::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9; Fri, 15 Jan 2021 17:31:17 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:403:0:cafe::40) by BN4PR10CA0007.outlook.office365.com
 (2603:10b6:403::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend
 Transport; Fri, 15 Jan 2021 17:31:17 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Fri, 15 Jan 2021 17:31:16 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 11:31:14 -0600
Received: from ajacob-ThinkPad-X250.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 15 Jan 2021 11:31:08 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/16] drm/amd/display: Change function
 decide_dp_link_settings to avoid infinite looping
Date: Fri, 15 Jan 2021 12:27:11 -0500
Message-ID: <20210115172714.126866-10-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115172714.126866-1-Anson.Jacob@amd.com>
References: <20210115172714.126866-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e45ad3fa-3d0c-4cc8-f75b-08d8b97b5cde
X-MS-TrafficTypeDiagnostic: CH2PR12MB4906:
X-Microsoft-Antispam-PRVS: <CH2PR12MB490645D25D856BE09CDC0AE3EBA70@CH2PR12MB4906.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r/51qPQY3ZuIAtd5QaJGRAjwE086Rne/nNQfFQaSehKFOpePEg8KoNml3BybDiW95jnyWKCHyrY7bIM1N5U4pN14LZ89oXqBfJCdzy0muqQQFRJuSBbE826Frf29d9rTmdcT7Q88/7vLjBxCd9FH+ktjHf9HDeJ5sXlb585cWcYGhZb0qNkQcaHKwaEmHmulEVf7OhhyRRsFi+mOtLU1znPPZLvyc2oNcb6f/1aLUThu5ykcea69hbtPBGgCuqGP0NJQ0ifO8tdeSYHew66s8W7Wa4C0KjIDaZ+LBZSmAwnsh2/4PHFlOCBnNZ7mRwXtcO0MhZZLJYlTzHOgmq0aniNFnTnIgoRCobtz3YRG7fBwx7vOmySc8Vsb8nlfza4w/nyb2En9mrGg32VAXPED5RLBTyuqNfwFU/nD2+I9lhgYV/WuX9D0MzTjVT0+vSlUomi0WxLaM5ECteKRGqNA/2bmXckJfSdGAD6MrjdORFzuLj5udmCM90I4QDHRtLcK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(46966006)(8676002)(316002)(34020700004)(82310400003)(54906003)(7696005)(1076003)(186003)(83380400001)(86362001)(6666004)(81166007)(356005)(5660300002)(47076005)(8936002)(2616005)(336012)(2906002)(36756003)(426003)(4326008)(26005)(478600001)(6916009)(70586007)(82740400003)(70206006);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 17:31:16.2677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e45ad3fa-3d0c-4cc8-f75b-08d8b97b5cde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4906
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson Jacob <anson.jacob@amd.com>, Aurabindo.Pillai@amd.com,
 Bing Guo <bing.guo@amd.com>, Jun
 Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bing Guo <bing.guo@amd.com>

Why:
Function decide_dp_link_settings() loops infinitely when required bandwidth
can't be supported.

How:
Check the required bandwidth against verified_link_cap before trying to
find a link setting for it.

Signed-off-by: Bing Guo <bing.guo@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <anson.jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 5064c216b26a..9e464f4ac95f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2399,6 +2399,9 @@ static bool decide_dp_link_settings(struct dc_link *link, struct dc_link_setting
 			initial_link_setting;
 	uint32_t link_bw;
 
+	if (req_bw > dc_link_bandwidth_kbps(link, &link->verified_link_cap))
+		return false;
+
 	/* search for the minimum link setting that:
 	 * 1. is supported according to the link training result
 	 * 2. could support the b/w requested by the timing
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
