Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9DBC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:29:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6901E20643
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6901E20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E732C6E0CA;
	Fri, 15 Jan 2021 17:29:52 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760070.outbound.protection.outlook.com [40.107.76.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F2066E45D
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 17:29:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTZ843/aIWzH74a2XHt+A80K/H7HdnSEeXG1Nspoo7Cb51AHoKLUXVfkGpaw7N3mMkjI/GSq7QnpZIrAJAXkFFI9Os2iK/T5hWt0sWHKyQxzlNp4d2aD8AwnSzcci9fOcZAdEKF/DTQ2/bcSlB9jD7hbbob5gp9M0RCiKJ9r4E9YUyq6ekc92doP3eZ1vtn9uCj1ERr6BMTVB5UPvxSHhUPW3ZXeawGBgZHOpS6boSsPo96YTGkClRKznpN4DKfLeZJWXdQxaKoYAtDleyiYtacl3vt3bPNu6M4LuFD/a3HSOgoh109LlBC2Vjz9VSR4h6iKnmex44eBayr1gHn27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9woU+Yb3RWUg3pQy8oxa4ornqZPRknDWKijKZHiiql8=;
 b=il9YskyzW0nqJ39jRJpffFIcSDnOcdHWrgwjr0F4lDRsGQ0NhjKWPkvog5uVt5Y2kLxT3X6Qi0bI/p8bDoiFm91qQf7WcTtWNTLAsnwx3+wSISVrtsOFe3Ta3NM5I/bU7J2yjxgAKDUu1rmmIb5zE1yNg7+zwOMzsa6LFVK5myQohoGDGZjwIU/LKNno9SI2biiJO09Gl13gsT1s80PfdKn20Qb1xZkedfjjV1BAc1bxjMWs6Ttzl+EbsnDhzhT5CfWPHOCtRPHchYaN+i61KZ8aRi8Rrth6Piinxn+hDm5baNXdVqOctr4Dcv2BvXqCBk2ZpLs2ZTmNJUdXAfJeVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9woU+Yb3RWUg3pQy8oxa4ornqZPRknDWKijKZHiiql8=;
 b=2ElYwcT7ISn0Wxd6vKyB3FslBW0M7sR+prFGHdDYUM2sZ3QN3Sa0Zof0r7DYdEHVqH9THdg7qiaULtTao2SdyF41/AkfFoJOOKw03wuDsy/zql6dcaXfmcoc2QKb2m0zQQR2Nm/W8e6CS215dLbsoFnk1VH36rLg0ixDiKkfNBA=
Received: from DS7PR03CA0176.namprd03.prod.outlook.com (2603:10b6:5:3b2::31)
 by BY5PR12MB4802.namprd12.prod.outlook.com (2603:10b6:a03:1fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Fri, 15 Jan
 2021 17:29:47 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::46) by DS7PR03CA0176.outlook.office365.com
 (2603:10b6:5:3b2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend
 Transport; Fri, 15 Jan 2021 17:29:47 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Fri, 15 Jan 2021 17:29:45 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 11:29:41 -0600
Received: from ajacob-ThinkPad-X250.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 15 Jan 2021 11:29:30 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/16] drm/amd/display: Fixed corruptions on HPDRX link loss
 restore
Date: Fri, 15 Jan 2021 12:27:01 -0500
Message-ID: <20210115172714.126866-2-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115172714.126866-1-Anson.Jacob@amd.com>
References: <20210115172714.126866-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf739d63-cff4-4b9d-3fae-08d8b97b2707
X-MS-TrafficTypeDiagnostic: BY5PR12MB4802:
X-Microsoft-Antispam-PRVS: <BY5PR12MB480212B52C1365D101EAFE85EBA70@BY5PR12MB4802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: isAEliWeLjPA4cCVPQBDzLkahEW5KM7Kc+D5GHfiTKc50doLfNWRf7TdxTA49c0lUF12gEB0XiNNlP1ijVnDHD54GNU8OfanFTjzUshfwdSh/bfmJcr7v+S3Q0vDD4fDczxqjyKPjn1iiv2KrHTwp5YioRUoJ+sLp9RIjVPoD7y6oKS1tvziVhT1KOoFvXyUVjXkQHeAEfgYOuNJ0KW45glZL5QKlBOBCdh5qlOJ+jVoi23/FtxhZnlxEtIae6f2xMrJRxo89Y5ura/4/BjEWC2stFO0BKP2dkR2tBk5cHgla6yZvnJG4LdvrhCf95Ur0XPT2Atc0lPxMa3UkvjrXNN6qj+p1VEfYu0JyMY666jKpwtXU77verxFkfL5ZmZKe3sOdBwoF2BdZ4YQ0XiHNsIKFLDdjKr9UPsZtbTWYibvxHeDoY/zd0TwvpHGWIhDgV3i566iDDTiTyvS5uoEtKQBzMOpq687bR9Y7diVCAWu4Jh/GvE2hLjiEHl3vmLG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(46966006)(70586007)(70206006)(336012)(1076003)(83380400001)(34020700004)(2616005)(186003)(86362001)(5660300002)(82740400003)(426003)(8936002)(26005)(2906002)(356005)(316002)(6666004)(36756003)(7696005)(47076005)(81166007)(54906003)(8676002)(4326008)(82310400003)(6916009)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 17:29:45.8908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf739d63-cff4-4b9d-3fae-08d8b97b2707
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4802
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
Cc: Vladimir Stempen <Vladimir.Stempen@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson Jacob <anson.jacob@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vladimir Stempen <vladimir.stempen@amd.com>

[why]
Heavy corruption or blank screen reported on wake,
with 6k display connected and FEC enabled

[how]
When Disable/Enable stream for display pipes on HPDRX,
DC should take into account ODM split pipes.

Signed-off-by: Vladimir Stempen <Vladimir.Stempen@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Anson Jacob <anson.jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index b2d859f32d54..5064c216b26a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3045,14 +3045,14 @@ bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd
 		for (i = 0; i < MAX_PIPES; i++) {
 			pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
 			if (pipe_ctx && pipe_ctx->stream && !pipe_ctx->stream->dpms_off &&
-					pipe_ctx->stream->link == link)
+					pipe_ctx->stream->link == link && !pipe_ctx->prev_odm_pipe)
 				core_link_disable_stream(pipe_ctx);
 		}
 
 		for (i = 0; i < MAX_PIPES; i++) {
 			pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
 			if (pipe_ctx && pipe_ctx->stream && !pipe_ctx->stream->dpms_off &&
-					pipe_ctx->stream->link == link)
+					pipe_ctx->stream->link == link && !pipe_ctx->prev_odm_pipe)
 				core_link_enable_stream(link->dc->current_state, pipe_ctx);
 		}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
