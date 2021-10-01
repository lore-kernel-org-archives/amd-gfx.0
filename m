Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33505C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C9A61381
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E4C9A61381
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FEF5890B9;
	Fri,  1 Oct 2021 14:41:44 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2048.outbound.protection.outlook.com [40.107.95.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 241CC890B9
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 14:41:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3mdZogaG5cbL49/VbNX+FaFLBlTHHO3sfmj59Zt0cfjtIOobYj9OXTgqtslRLL30kSQt6jaoIUvKHfJXkqi6jwyDgZBdZj8mst0guFHqMy9oGM9WYKYKKY+hwieEq2vv1szn01KaJAxmiRw6hmi42Mo7Ni8AgxEhhaIKOTshFtsswRbbMFAR7RsGd2u25pxBOAtS6qqJ2VaArSjyFrlgfLZMpTU8HqeqGzM1+6kzxm9r238ZjHQZEecizty4kgmXxTJTFS4FONBmVyP9LMSAaQOME0dpBsZUkZ2ngQF2juLJUdUcA/us1NuXuNdoD+g9REH7KWf42GlKArRwbT4hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taT9aqH3JjtMTRMrKV6/VIUjOoyh6HRXJHEsqdNAY3Q=;
 b=gm1Bc9EKz3NQDDL+32pko7xKRJcHdDgnW3rHa0AKXuoO6ajGGJ5QN2oB3N5FgJF1z1xl/k0t4Uub2h3uC0V7JZGTkuhdVD8i/QD4JZmNsSkHs/T+14VEquuQ2z7V44j2arVxPJFr/9ck5fBOzBhQNCt1szaKZJRMeORmEKGFPpxZf8fMJSzM9U8jJgUYaA5GudRVQ1ycfLuDhUUO49zd8873bb3yVwP9eLKpkOEilrb43KaWg06U+n8JwqWyhuyfopnahtH3VgGW/xuUpe1n8xL7s9QOOmFrNLEJo40E2kL3STaNlk03Bh3IS2+XR/QNMBHX4sPGPAvpX6ZRpyAZ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taT9aqH3JjtMTRMrKV6/VIUjOoyh6HRXJHEsqdNAY3Q=;
 b=PI7HOR4hHuWSL/J/BGEm2ReU8ducv6YjCJ4zp+Jvjtt4EYx6KKmDgz9UQNGJY1b+qnD3/Nl/4F37LM25WoCCrYjMuun4pwyVskNuIb1wMZgnPrTanaDnzKWDnXy1eXrvhUrWlZILZ2jrqCaF44lXOaApFSgY0ka//DdjCrNNGPE=
Received: from CO2PR06CA0076.namprd06.prod.outlook.com (2603:10b6:104:3::34)
 by MN2PR12MB4847.namprd12.prod.outlook.com (2603:10b6:208:1ba::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Fri, 1 Oct
 2021 14:41:38 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::df) by CO2PR06CA0076.outlook.office365.com
 (2603:10b6:104:3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Fri, 1 Oct 2021 14:41:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 14:41:37 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 1 Oct 2021
 09:41:32 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Nikola Cornij
 <nikola.cornij@amd.com>, Zhan Liu <Zhan.Liu@amd.com>
Subject: [PATCH 08/14] drm/amd/display: Limit display scaling to up to 4k for
 DCN 3.1
Date: Fri, 1 Oct 2021 22:36:14 +0800
Message-ID: <20211001143620.192679-9-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211001143620.192679-1-solomon.chiu@amd.com>
References: <20211001143620.192679-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f98c8920-b0ad-48c0-3ab7-08d984e9930f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4847:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4847A35A9CBA35F05220B0CA97AB9@MN2PR12MB4847.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W7lqoClDtKpNHlxRrTYYlQSM2j2P9T7wetGd/B6FMeytZHd3/92qC7mkGxjnJ1GO5re0uohUukB9mAJsO0176Lih6oNCQ66H9FnMUPggsTETNputz4DxyiJpg+7Ks7SP7ndwR0omkb/N7bPPWNbB2RRsKMicicOICbqosbRNxWRPoGyNE+9LeK7suPUtnBS4rsg0hhwE9UentHF5Ftq3kEKClUqDqcfgzSFjKE1co6zXPJnBoq8Grp8SAz/VMjdRvnfABXx4h17Ef+r+WxG3z4bSvixFiWe/icLK8PiGYsoiVStZMoZZeS8U3jh1cFJ416dprHL8730gD3gwQ7Au6XNHifT2Bk8yIii7s8INObuJxEwPUYH7qPrDETkNDCJqWVmduYX008DCjkskFBjFnx6c2RHMrsv2p1xG6BbyhexzGvIM+PmtvSLCR7WzCDZrGHL2fucYU7YTtDQzDE2gWZBmmhew2yM6Rvgbue2ZYjQrpoo3CxPGONp+AIZ2NJ4kbbTJfJq10IzR+x/i3yLuMm6/BZVqmKCMElq9g2IrSMgj3Uc0pbp6b8MT+qtfjvQYzz2ZfRIjn1d8FOQ0VPQKAkLKF9wHr/9HUjiM0dH9XM06oK3fmdQbiN5iM4mu64/cXedeKKuDMmBCRZKK9kL+8XLbI4YQaYxPgL+1kve2vOHvP8A9XJDSMXOJHJ5VB2VZT98eZmHV5r7IcGgzxGmGZrdJGLXSwLFwjI2rvFbwgrM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8676002)(82310400003)(508600001)(86362001)(36860700001)(336012)(81166007)(356005)(70206006)(6666004)(70586007)(26005)(2906002)(16526019)(1076003)(186003)(426003)(4744005)(6916009)(44832011)(47076005)(7696005)(316002)(5660300002)(4326008)(2616005)(8936002)(54906003)(83380400001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 14:41:37.7603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f98c8920-b0ad-48c0-3ab7-08d984e9930f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4847
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

From: Nikola Cornij <nikola.cornij@amd.com>

[why]
The existing limit was mistakenly bigger than 4k for DCN 3.1

Reviewed-by: Zhan Liu <Zhan.Liu@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 613d34bde7dd..d5b58025f0cc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -998,7 +998,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dcc = DCC_ENABLE,
 	.vsr_support = true,
 	.performance_trace = false,
-	.max_downscale_src_width = 7680,/*upto 8K*/
+	.max_downscale_src_width = 3840,/*upto 4K*/
 	.disable_pplib_wm_range = false,
 	.scl_reset_length10 = true,
 	.sanity_checks = false,
-- 
2.25.1

