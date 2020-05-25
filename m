Return-Path: <SRS0=Ro4j=7H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECDDC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56A8F2071C
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XqRm/Nrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A8F2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3298089C18;
	Mon, 25 May 2020 18:13:18 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690083.outbound.protection.outlook.com [40.107.69.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2BCC89C13
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2020 18:13:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+edNDl+znZ/Lrk7WCzI3X2S7995rs+eInChXZ1450f8GTO48d2oHDgD4Ak1ucwkmjOMqrmmehiVQhD6GicGzz63dTqsPUlx7Tafr/16XNCRVn11oZG6JKsLeMgWZglKKIM5u5usDrJ7M9/yKc4S9nfzhKVnxLZvMEZF2veO/gvxIq8yGFpeVg/CD6XQa1bpgZjf86Kmb9rXQZw9FU+G0d2AyR699WEzuwZ0yJqF/fl355YIHNnWnXsG9aDyoU952lD9DOXaBHNyoTyHzEmtc2IyUW5TYRNEA7xpbolz3EOuo+yBR65VKThJrzUuJuBbhuYxrXVQFYh9YX5WmMYVpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jN1GJ+8+p3L0LyYHMqn8DJALd+E/+S6q+MmpQ35QKW4=;
 b=D0aDmwNAbvF7t/0BC6tH7mbxzX8bmT+xtDb8ZSkRd+3MrpzLdqRbzkEMsJuPGS6SvDAXHE+9yOJF/19+c0ej77QgBWU7LQoQUBeI9K48vb5HgCoTMH96RmJJtnIN+utcrOwmegRSduPmEo9N9NRCimn9A6ocm3I0qdMgPPWnmkeSfF2ZlUdv7fUAOJFlMs5rvrcDIcca16l3B4rRBLL/X1KDPqACCgfqdOYWGow22S9mfdRebm5DNDXiqHLkeIyi3PvB7ZT86YG45OPgZ3hettvA4XJxgsxb131uVczgt7mTatGgxojHCw925CnnVhnD14LbM4trps6kRj09N9fs6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jN1GJ+8+p3L0LyYHMqn8DJALd+E/+S6q+MmpQ35QKW4=;
 b=XqRm/NrhudFZfPCv/AwT+kOerI5k7s1D5L0RjM4eEys6jFGc/UETQ3jShXQtaik2BqO/44diqxiis2kgEKDOc5zqPl4OqSW1rMbqW30sFUa093+JkuJMWWPxFbBu1RsLiWRNpZPHdtdEbTahojzcwOtjK1T3jVr7lXIc6BxNfqY=
Received: from DM6PR02CA0037.namprd02.prod.outlook.com (2603:10b6:5:177::14)
 by SA0PR12MB4414.namprd12.prod.outlook.com (2603:10b6:806:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Mon, 25 May
 2020 18:13:13 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::ed) by DM6PR02CA0037.outlook.office365.com
 (2603:10b6:5:177::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Mon, 25 May 2020 18:13:13 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 18:13:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 May
 2020 13:13:12 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 May
 2020 13:13:12 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 25 May 2020 13:13:12 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/16] drm/amd/display: Disable PG on NV12
Date: Mon, 25 May 2020 14:12:58 -0400
Message-ID: <20200525181306.3749-9-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525181306.3749-1-qingqing.zhuo@amd.com>
References: <20200525181306.3749-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(46966005)(36756003)(26005)(82310400002)(186003)(1076003)(2906002)(70206006)(356005)(70586007)(81166007)(44832011)(82740400003)(8936002)(8676002)(2616005)(6666004)(6916009)(47076004)(336012)(316002)(86362001)(54906003)(4326008)(5660300002)(426003)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4386aa13-10fc-4265-8380-08d800d74a06
X-MS-TrafficTypeDiagnostic: SA0PR12MB4414:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4414DC2AC9305BD2F236F1BDFBB30@SA0PR12MB4414.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xt9W1O/j3mNH431D/zztDOj0gkRFDKSQYXZ2QQVUoRJ2PxzSFVMKkF3vKMrNhSgQp2h9fYARAPK1go28HG1OERbtxMYQHTydjvyJkAJuNeFtTeo5zdixOLRMfr0+n5DDZMgPiuv2VbgxptHqeF37BSjlMq2/jIaMZvfkr/BazL7uubLbtpL5jSPGRA+pGzxE2u7gv/dI/uarK+vrwkynXrmWoPIE1jMJ9V8/1O7D479CgHBzdQp3E/ay0/7W8fpGnlMOP2q1Tpt0hBCVJMOy2/gu4cZm5wxqcL1FpNXiTsQZDs4TdDb6ITMQs1WwUbARWjoa2PH7WzP42LznXu6e1LPPGk5j2hZL085XLiJA98woGBOTLZ7Eq0Zxkqf4KqCYSQR0Yc8lknHgMJh41gGZaQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 18:13:13.1855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4386aa13-10fc-4265-8380-08d800d74a06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4414
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
HW team request to disable PG on NV12 (fixing missed cases)

[How]
Disable dpp and hubp PG

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 99925079a55d..4ffdbcbcdfd4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -4053,8 +4053,12 @@ static bool dcn20_resource_construct(
 	// to be consumed. We could have created dcn20_init_hw to get
 	// the same effect by checking ASIC rev, but there was a
 	// request at some point to not check ASIC rev on hw sequencer.
-	if (ASICREV_IS_NAVI12_P(dc->ctx->asic_id.hw_internal_rev))
+	if (ASICREV_IS_NAVI12_P(dc->ctx->asic_id.hw_internal_rev)) {
 		dc->hwseq->funcs.enable_power_gating_plane = NULL;
+		dc->debug.disable_dpp_power_gate = true;
+		dc->debug.disable_hubp_power_gate = true;
+	}
+
 
 	dc->caps.max_planes =  pool->base.pipe_count;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
