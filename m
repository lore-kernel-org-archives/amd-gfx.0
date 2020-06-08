Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30642C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC25D20801
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="m+/QrOk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC25D20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A67196E45E;
	Mon,  8 Jun 2020 04:59:33 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700068.outbound.protection.outlook.com [40.107.70.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DA916E45E
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 04:59:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P28JXuzLCgTZoL+0E+EWbdGbN20syfSPB92ruTQGRJQ6dt4Ufs6ObVUAE866s4EFLhsCeOhUB14f5VuzWHmL+YCan2Mrcothnv8O+R/nopE+tVZc2aZ2qmsiFEN4mX/3ieDTzPAyZi3Mkq3AfyhLXboqOSej1n1lAPloNzNNUGb1KAhKbqmZQnQ/NEZvy0p1H3cx3FAIT2wTvo4OzCNpEkCpXxaMRk6AiyyybW/KD/bTd9DO8do0gaPDeJVkLK60frIRyiHSqWZ9bfXh6JjfKtrZj3xqMCl7qHfEiuibo8uLO0X1Au9DEl99XVL+nrKqQkad7rpGBt2GlLiDE+GAJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPDseY1Vbrq2Ij7LRFV8S3SxTxyvyRlXqB4Wr13Hh7s=;
 b=UhOQAIhfQdlRuzgJmjucD5QJ4A3cIIP03HE4szF66Tg3NGjgUxjoIxQirHerUWgEZSlJGYZFpaMkR7e8NyOJhQTOPhygFnkXe6Mx4XTgJ6rTC2FeSoENMcqfvJJK7OzrH1mc6kOXDsTH7bY85WFALeqEJwg4H7tnQfiaasJtGzZfFXM/jP4uctFEiMd4NssTSXhLHxkF3HjTGYDnQZaZn9AJQLB6gdmaVVwsNX7cGzT42SbccVYZknobnFaA7Itmd9fE5X/HxaJWH2j/uOxseGiLjSXRWuGVlSno/zpCf5qBnRxwmCNdVWFH9wwONWnWs+Py6Wto18n/g9r5boAQZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPDseY1Vbrq2Ij7LRFV8S3SxTxyvyRlXqB4Wr13Hh7s=;
 b=m+/QrOk+AeT0/UYY1eF23+bcAKsOX4OMjQqzjLyfJUwDXlZRWCRQnoB59W9lYNj5ljuFvmCQX4iLU+FNXTLd0oKKSTsmBfqrvHkZ3WCuvY4QeqkLvBeqkbwheM6M0XBqA+YBArQ+iqdEyzQHu78p7CcJzE9hhRcrJoM9yeuF4Zc=
Received: from DM6PR01CA0015.prod.exchangelabs.com (2603:10b6:5:296::20) by
 MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 04:59:29 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::7a) by DM6PR01CA0015.outlook.office365.com
 (2603:10b6:5:296::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19 via Frontend
 Transport; Mon, 8 Jun 2020 04:59:29 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 04:59:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:28 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:28 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 7 Jun 2020 23:59:28 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/28] drm/amd/display: correct alpha_en programming for new
 pixel format
Date: Mon, 8 Jun 2020 00:58:59 -0400
Message-ID: <20200608045926.17197-2-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608045926.17197-1-qingqing.zhuo@amd.com>
References: <20200608045926.17197-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(46966005)(4326008)(186003)(26005)(336012)(478600001)(426003)(54906003)(44832011)(6916009)(316002)(2906002)(8936002)(70586007)(70206006)(356005)(82310400002)(81166007)(86362001)(2616005)(8676002)(82740400003)(36756003)(1076003)(5660300002)(47076004)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 744f9580-f8a9-4686-3381-08d80b68b9dc
X-MS-TrafficTypeDiagnostic: MN2PR12MB4341:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4341B261E9875FE4F95524E4FB850@MN2PR12MB4341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xRqSAypVWZOfvxzhkhrtpY+FWma7F+9aMGn/krgPXweNZF03TtoadkhtMwea1und10drH5CWKOkTzdHbjWwIDu5te5caa5mbClLnPjdGtJIJzh8r8Mb7A+8tbfXbDZ0L4c6gR72PvT3JBDg0eIHujdBsRQZvHj7d6MZ4ZYURUiVGe4ZIjM4KItELiYcvjy+fSXYV7KWN5GQ0e2a67sjYhurgWbTPVOzIpBMP0kyKh11oq2ExRP3ZB0U+dy0XwSAb8tXeM6CzRjPcEJCHKqugIS3zvdjd7YX8NuFyMVVJs2tLa8NOub7Z7AgCtmWt+U/9hsfVFY0bEWZkl6ZCpNyUPOoRHmv2z0v8WYK+HomPj7UhMt94MHo86LvmZcKpTBBXGOjwMkfUD1ZF/Mu4Yqxcbg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 04:59:29.4806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 744f9580-f8a9-4686-3381-08d80b68b9dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341
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
Cc: Charlene Liu <Charlene.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
for following new format, no alpha
       SURFACE_PIXEL_FORMAT_GRPH_RGB111110_FLOAT/_FIX:
       SURFACE_PIXEL_FORMAT_GRPH_BGR101111_FLOAT/_FIX
       same as case SURFACE_PIXEL_FORMAT_GRPH_ARGB1555:

Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
index 42bba7c9548b..4af96cc5d9d6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
@@ -181,9 +181,11 @@ static void dpp2_cnv_setup (
 		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_RGB111110_FIX:
 		pixel_format = 112;
+		alpha_en = 0;
 		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_BGR101111_FIX:
 		pixel_format = 113;
+		alpha_en = 0;
 		break;
 	case SURFACE_PIXEL_FORMAT_VIDEO_ACrYCb2101010:
 		pixel_format = 114;
@@ -199,9 +201,11 @@ static void dpp2_cnv_setup (
 		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_RGB111110_FLOAT:
 		pixel_format = 118;
+		alpha_en = 0;
 		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_BGR101111_FLOAT:
 		pixel_format = 119;
+		alpha_en = 0;
 		break;
 	default:
 		break;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
