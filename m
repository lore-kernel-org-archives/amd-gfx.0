Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB8CC07548
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1EFD21D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KYCUqnmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1EFD21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75BAB6E945;
	Thu, 10 Sep 2020 13:47:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C3236E94E
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLVw144yMU/GtNygzW0L/r+gWZZ56N6BrghHg6Zk6GTTfAQrrM0maFBhPbXkwOcIB+3MvK7VgNB+RqO+tkn9sPUDGta7eXKTOZb3aOhtU+aKTve4LgB4pp+aqFU+zfotRpmmPsUNx1yaeC/wt3PbNqkHrXJA91HDDjzmsHgBvKxyzgFrOVMd2+1DrLuSZHZYvt+T8FdxG2A++vqqHTbG0Xd98jiJo2SazlwyeVUStBL1cCsZKCgqCuRVMGQ3b8mS9j8YoSml1V0GHXwJ7/He9kQytVlxcJNJ9v7K0pUU1E3EWXpLbRHiz6pqkJLYcSRb5IpHLx/7shAp0vhOSknsBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e871HDvl6z5f65D3e4RLkRj7wRQ18i4x49MMcCKM0d8=;
 b=F1ftAVYqUzF2UVGJo0VlEHwfVkjQG8L5KuReFF0i929imocCJCkOUa/v5N194HO3vbiiEt9yhDN63nct/+KSQljtVzw19YnoTG/WANxLMP7zEnW1NuLttpEn7a3hHisetajoKgsDHzW7Hq1AjDtwDUQoMNj5ZV/IGsU6i6G7mSJ4IQ2m2TTCUiGeTjRuV/rQHXyu9/l9QXr0js6AiNgSjsSxJNmQeB62+F4OSxklrRIGGtBiVQAAfy2oTZhMomsUjQRngTtwInMJPbqqGtGN857e8ge7gXi7tTUU3JMgUUKp8DoUdrRUiJ2RGNXqhGv02TnPzljkP+QvPR07i4chfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e871HDvl6z5f65D3e4RLkRj7wRQ18i4x49MMcCKM0d8=;
 b=KYCUqnmJXM2I5aNI8aaZ/e2/VDGGBTA6lD6SofzSE9gWOohAhjphvBsTu4Ho3c4FwTXRMrouaPhGsy4tAkjyvv28D58RCGE/xhGZdomaeZY9EYKRrr0K9aWD7Rr4K+EuHEMv10YNKRRmCj+7PZcvd2XPbTN1hUDW8tglLZrQGcs=
Received: from BN6PR11CA0037.namprd11.prod.outlook.com (2603:10b6:404:4b::23)
 by SN6PR12MB2719.namprd12.prod.outlook.com (2603:10b6:805:6c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 13:47:41 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:4b:cafe::b1) by BN6PR11CA0037.outlook.office365.com
 (2603:10b6:404:4b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:41 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:41 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:40 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:40 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/42] drm/amd/display: make dcn20 stream_gating use a pointer
 for dsc_pg_control
Date: Thu, 10 Sep 2020 09:47:06 -0400
Message-ID: <20200910134723.27410-26-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f163c1e-d2e0-4d32-dd25-08d855901698
X-MS-TrafficTypeDiagnostic: SN6PR12MB2719:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2719454CE142FA16B22062048B270@SN6PR12MB2719.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bgJqCYzCxxefLja1p8utRxFPr6+yyjmLHxlAkwGRXU9lvAUodiLNApAj5KiKz91TxcDorr3xa2pyR/cbaoHIkfhLWN+9avS3ItFZq1U2d/wf5/VkZEt5RxGygiggA7yLhfcuuViwrIQnFQbRDOdV1KxIRFyWxJAcOi/SGUJgp5Ymp5Pz5sqRD9s2jIAdtHK7FUkdCPMT9NwfFxL4Ud65gFLIpj7e1ToSeoSufDvmnO964rmfX+SGJdxUCH2swXTRQ4bW9krDSazrnHSl50WlC2ubZMxGzRcoUDWIWupVgNhsmLfxJW2YlD8VEDMnt9VvOqtlhkh1tlHni+0es+QISxS4wVDEvDbHtE7MaPEyIyiwAUs6oZvpSjTJdtnSNKxHfUkJJclxnFQXRnRkKXB3Qw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(46966005)(47076004)(6666004)(2906002)(70206006)(26005)(82310400003)(83380400001)(8936002)(70586007)(2616005)(5660300002)(44832011)(7696005)(356005)(1076003)(316002)(6916009)(86362001)(81166007)(186003)(82740400003)(336012)(4326008)(54906003)(426003)(36756003)(8676002)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:41.5273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f163c1e-d2e0-4d32-dd25-08d855901698
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2719
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

This allows us to reuse these on different asics.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index ee56060943f1..5720b6e5d321 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1918,9 +1918,9 @@ void dcn20_disable_stream_gating(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	if (pipe_ctx->stream_res.dsc) {
 		struct pipe_ctx *odm_pipe = pipe_ctx->next_odm_pipe;
 
-		dcn20_dsc_pg_control(hws, pipe_ctx->stream_res.dsc->inst, true);
+		hws->funcs.dsc_pg_control(hws, pipe_ctx->stream_res.dsc->inst, true);
 		while (odm_pipe) {
-			dcn20_dsc_pg_control(hws, odm_pipe->stream_res.dsc->inst, true);
+			hws->funcs.dsc_pg_control(hws, odm_pipe->stream_res.dsc->inst, true);
 			odm_pipe = odm_pipe->next_odm_pipe;
 		}
 	}
@@ -1933,9 +1933,9 @@ void dcn20_enable_stream_gating(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	if (pipe_ctx->stream_res.dsc) {
 		struct pipe_ctx *odm_pipe = pipe_ctx->next_odm_pipe;
 
-		dcn20_dsc_pg_control(hws, pipe_ctx->stream_res.dsc->inst, false);
+		hws->funcs.dsc_pg_control(hws, pipe_ctx->stream_res.dsc->inst, false);
 		while (odm_pipe) {
-			dcn20_dsc_pg_control(hws, odm_pipe->stream_res.dsc->inst, false);
+			hws->funcs.dsc_pg_control(hws, odm_pipe->stream_res.dsc->inst, false);
 			odm_pipe = odm_pipe->next_odm_pipe;
 		}
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
