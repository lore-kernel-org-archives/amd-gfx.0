Return-Path: <SRS0=Ro4j=7H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC39C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6FAF2071C
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Swp8T34W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6FAF2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1370B89C13;
	Mon, 25 May 2020 18:13:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14F5289C13
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2020 18:13:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6rtoi+KStqP/62PpYsADsl3xCgjOPIGuLJu3EmsB4V1fsgT2wvXMiBPQ7r0AaW063XmVIcAtFhfpEiNp+sH+tI9sWZ6S5/1K0d95zwb4PlrtRpPwpEwnTb4H1MV95U5FQnSOPXpJk7A1o6p8rJ66MQArDc3/zhK3CBLEDBS2PLj2AdY8OkbVZadUG/5YcMm2QSBmDbE6Dstv74uKaXiby+0MaCUWnbCNnLcpqHKYwPz8GcXn+gnTvBxzYxJNNX4KzH/OVC5FlGpr49kt2WFuH0PlywHxVjvVnD2PeKr52PcA8Twv617/mCaG5Tg6jMFrZz7apjdDxia/tzHvdVcSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7ZdzepiscCS26ZblxQKgCzPxLGGVBU5DH7AyhvnEG8=;
 b=LeqiR5VjLeFupRpQAHxItCbq1DPIrKZWkiR7UPbYNfKtn7ILIOwmZfcp++9RonxfjDd8kXTg3O0XVM5tTMio/2H4ysdkH8hsAyn2qRbKKkJbFrKqH4z1fBys3wPdNW7YOI1n0ndrnG4pM3K3Pzf7RkSjDit2vj7BOayEUxBdEV1RgGhl0Ba67jSK120vKJqARBkG6I1PSC3MvHu57Lmu8Fwb9mrs0+ToQsW0+RtebaEwMoBULeOHEKrBGYt/NUit7bLSfzfifKMf+7/SZKmmts7Ci61lEwBUQxaZNqYXvbXutsM5HIxL9bdm4Kiz2Oi0XzO9C/uUeSf/OM6SSA77rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7ZdzepiscCS26ZblxQKgCzPxLGGVBU5DH7AyhvnEG8=;
 b=Swp8T34W3cYIZJ7dRiRVZiSNBNTr3R776i11b7VOWJWz5MSX0QDDhGPxdtvoETBQh4Zo/JtT6v6iOpqznTobX37lbuPtd3goCwmvd+HPoqAfRxuL6M1co1rIDviPOwXBwRzZiuArdluILFfsWa3U5BKW4dOYOE03d/iuyMo9lGk=
Received: from MWHPR22CA0034.namprd22.prod.outlook.com (2603:10b6:300:69::20)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Mon, 25 May
 2020 18:13:14 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::dd) by MWHPR22CA0034.outlook.office365.com
 (2603:10b6:300:69::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Mon, 25 May 2020 18:13:14 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 18:13:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 May
 2020 13:13:13 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 May
 2020 13:13:13 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 25 May 2020 13:13:12 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/16] drm/amd/display: Guard against invalid array access
Date: Mon, 25 May 2020 14:12:59 -0400
Message-ID: <20200525181306.3749-10-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525181306.3749-1-qingqing.zhuo@amd.com>
References: <20200525181306.3749-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(46966005)(81166007)(82310400002)(356005)(26005)(36756003)(86362001)(47076004)(2906002)(70206006)(70586007)(4326008)(6916009)(186003)(8676002)(54906003)(2616005)(336012)(478600001)(426003)(316002)(6666004)(82740400003)(1076003)(5660300002)(44832011)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc55ba6c-c52e-440a-ff25-08d800d74a70
X-MS-TrafficTypeDiagnostic: SA0PR12MB4382:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4382CA4192B0F1F58CC4C6E2FBB30@SA0PR12MB4382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f+1BDbK61nhMGCVPHmAS8AOj3T7tV6P9xGhDVqDxUkvsEKmqCJEsdCAtnG714zbVcpP9Hqg7+MZJCt1zCJ/3CQ/7jkrI3pCJagn68qXuosBFY/rl1/92lncAgvx15wOEK4iRFiik+yKJDFBuPEpMAg/Sj4MT871LlLaSEwahbwqUxDpMzkJiLwkfTckNRFZCceLhr3nvIc57CSvnzEXis5qyEuv0q+0SR0TqoUW8gFjEI1MmgtH3kTUOlW+UOb8+ksmZSZ4/qI7UdlP81NXKpdN7S16DnT3gI487XxQZpG90E2HSrAxzyISj6DGmPML363t1jH/U3R+gcVRVNRXEY5eCWFnDgnuh0tjI9Prpvrsqeb0KW2rLwiuZbXmw8cRE1qbpoXxkIwsCRIHwGvyllQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 18:13:13.8224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc55ba6c-c52e-440a-ff25-08d800d74a70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382
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
Cc: Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
There are scenarios where no OPP is assigned to an OTG so its value is
0xF which is outside the size of the OPP array causing a potential
driver crash.

[How]
Change the assert to an early return to guard against access.  If
there's no OPP assigned already, then OTG will be blank anyways so no
functionality should be lost.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Zhan Liu <Zhan.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 26cac587c56b..223e314d26b4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -291,12 +291,20 @@ void dcn20_init_blank(
 
 	/* get the OPTC source */
 	tg->funcs->get_optc_source(tg, &num_opps, &opp_id_src0, &opp_id_src1);
-	ASSERT(opp_id_src0 < dc->res_pool->res_cap->num_opp);
+
+	if (opp_id_src0 >= dc->res_pool->res_cap->num_opp) {
+		ASSERT(false);
+		return;
+	}
 	opp = dc->res_pool->opps[opp_id_src0];
 
 	if (num_opps == 2) {
 		otg_active_width = otg_active_width / 2;
-		ASSERT(opp_id_src1 < dc->res_pool->res_cap->num_opp);
+
+		if (opp_id_src1 >= dc->res_pool->res_cap->num_opp) {
+			ASSERT(false);
+			return;
+		}
 		bottom_opp = dc->res_pool->opps[opp_id_src1];
 	}
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
