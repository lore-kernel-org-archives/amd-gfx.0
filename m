Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1265C35658
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9649A2067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IjzZkmrx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9649A2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A37E6F4AF;
	Fri, 21 Feb 2020 16:04:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B969B6F4A6
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:04:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWl8SO6pWwy/q2/8h95Zaw+PiqkJPXwdHPotils8HDSD9wi1RXEtlwJq8uUB1DsW8zufiAdLLf17SokyCCV1txcTPz3aUwRNRnPEtHiaFFefotKAZPe1I6CcKLneecrRZKtjGHtvWO5r6VWmNpouASP46e9O3ZIcIHtQ15lYkO4zEwuQXTat2o0oEnCJAK65EkFY4vovoybYtsq1zisXCC8EgOFmZ9Kyk4s+RBzGgTQi2IZtS5NPYCiK0x3oiHuLmrrYm5uY2kNAi3KjUCq6bwY2U5e4R/L4C0Q1za/ytymy7QLf/ER+a0usV2GhshsulQbwzByk14rKj6IDb8EZsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=socV50YO1J7SaXibEqsvEnVxJTrYAgyEdrpkp8h8Yek=;
 b=J9dLJu6Q+t48uWr2VYMpb3e9d09sfRwVUSSNE2nfd3HrCpEZeniSuGSgi7vL1yIgEyLa5kjWfKaNNovFxHEBp3Qx3/SOJ+bKMcWOqxOAZ7Ln0TfG9dmwgnBB/cVlK+eWFz1rO+mnu41Yj4mCq+BRK5Z/GMeGJR2G5IwcdTZyo9wt4rNj+AZOryKzgmddWVTJ33nWRp9IReZHhQJfAH94ZDoHu1IRxHKU1Z9fCfDAkR238nQ4ZwMh7/y1x7EA0R/hG/GipYNjyljuBqdWTTRCVc8n0mSCNcb2ITCc8lZ5sd3rbfoyHUG9zGVKIRzHiPW1KLEyNjEVa5VzS1UmLyBe+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=socV50YO1J7SaXibEqsvEnVxJTrYAgyEdrpkp8h8Yek=;
 b=IjzZkmrxaEteGVDKpQLIKJRb1gN2T0aqqdWb58zQ+eH4O8EhV99Mg+0Nr7paXziB3ldhRI209Asnhq4Bn1Os1zQnKs/BKzyYUv/VWLayeSnHJjhnjm5mEkog5V5fV3YBiPnxHG/OnTRPF4uxXBE6I5LA8uGrj24O6RhuHotFpQk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2409.namprd12.prod.outlook.com (2603:10b6:907:9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:04:02 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:04:02 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 19/35] drm/amd/display: Revert "DCN2.x Do not program DPPCLK
 if same value"
Date: Fri, 21 Feb 2020 11:03:08 -0500
Message-Id: <20200221160324.2969975-20-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:04:01 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 26da1ecd-dd93-42d6-4beb-08d7b6e7aaf5
X-MS-TrafficTypeDiagnostic: MW2PR12MB2409:|MW2PR12MB2409:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24093797C1E8AF549A9E094798120@MW2PR12MB2409.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:147;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(16526019)(36756003)(66946007)(66476007)(7696005)(66556008)(6916009)(26005)(52116002)(6486002)(1076003)(5660300002)(4326008)(8936002)(81166006)(2906002)(2616005)(956004)(81156014)(54906003)(186003)(316002)(478600001)(8676002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2409;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MGxpI/evU69xqGEXHkavMpJvZtubddm7IAdGWD0W3kOdP4vY3apGZE09OHPV9NQXP0xetM7HZZNIF94gNrsHHCpZtT6PH+7ShSPgXs0a+lrYJPfCWCCSciCJXkwBbZLujQSZzkCIVGZjJkyYpuNdHOQ+GbnuMHiiSrN52u2ig3jeO+Nivb+TUarlwx1HBflEEFfzjk8cPTxM3zsKkUls9bxueAbTijWjC2hjiTd8jDF2NxTt2fZuXqwQILzuFKotY1fUmkYNZgl+iOHuDbDOIZEy2R+WOwILvaunSV6+m1OC0bX/9FmmdQjO6ihy51VsgM+pjymiQs8mbX5Gg2J55kL8cW2OvbWTpTyXLthaXF4q+1Uhoi9VO8XtHvdXhZfNlUZqo+B9RAyevFdvtW6zO1SpucxIORPgdu0BkAsZiXEGye8rrMtNeLky6brbqf+K
X-MS-Exchange-AntiSpam-MessageData: B/7Wjwg16fzuH3Y7+tO4+2QVLE21BfJbEikjCCj/v6Y+y7/BwS9MECo7MhLejaw446U1fBAmVChqazZ2EhafAP7OXTOLKOVVosQVpnkFtHz4SfRgh2emImddgJlVmvhXmOcdM8SHHTYn2OLQI9kYVw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26da1ecd-dd93-42d6-4beb-08d7b6e7aaf5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:04:02.0936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtD+W67xEBK6zOuEDsS8wnjXp/AFGCcFhnZkaxIvVaRng93IdmuG9vVeSbp86N136YOqiVToMUvdqqmRGNvCEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2409
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
Cc: Sung Lee <sung.lee@amd.com>, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, Rodrigo.Siqueira@amd.com,
 Yongqiang Sun <yongqiang.sun@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY]
Not programming dto with same values causes test failures in DCN2 diags
DPP tests.

[HOW]
This reverts commit 6f4c8c3022bcdad362b89953a43644e943608f9f.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index 68a1120ff674..368d497bc64b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -117,7 +117,7 @@ void dcn20_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
 
 		prev_dppclk_khz = clk_mgr->base.ctx->dc->current_state->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz;
 
-		if ((prev_dppclk_khz > dppclk_khz && safe_to_lower) || prev_dppclk_khz < dppclk_khz) {
+		if (safe_to_lower || prev_dppclk_khz < dppclk_khz) {
 			clk_mgr->dccg->funcs->update_dpp_dto(
 							clk_mgr->dccg, dpp_inst, dppclk_khz);
 		}
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
