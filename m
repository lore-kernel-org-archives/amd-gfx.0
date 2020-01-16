Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D111BC33CAF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2522206D9
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HoFnFK9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2522206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA9436E2A8;
	Thu, 16 Jan 2020 20:14:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1097A6E282
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ns95j/UeBXK1bca7MqVGGO23bW6xFWj0gZtkfNn1tZ/1weQHMu/iqlPvobfN5YMsRra6JZkYxQ91LCPHUUHiOe6yZQ5r476CTHB3L2dokbRuUoe1SjZagDf0KtwiazURPyFuLGPH8r0E4TeF3bdOSwBvpbC0canD19qeR/zUBaR8dAo/z/riBQwwx1/EIwq6HGIXAkI3R9ctv/86osdZe6QDOkAYxgO8MtzbC48XVWoZMxgdbgueSycZ9YMcoBaaCxGRlPcun7iq8ffTkCra3uM8CXawQW1wEsqZR53tUVCmNSiJGcGSQFG1fus5c6RmRA2sCy0IdjxqJ9g/lJwiIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN/tX8jwrIhgWB1LhVOagSt7apLi3qUxZ32O/cV1ByQ=;
 b=VDhMgat6rLOQhJHYPGzjRdA31ncX2bl9JAMzbj/afyitI4M/5+jurUYKloQ3r7IvoNYlGdH3PDQu//tq8iMng0oq/Cu/PhIRII9fISBXTmSR82UhbNonAVbU5kUM13bZJ/7BrIOSpm4B3tSwrtRIelqvGgvtCNoV08veVooRoeqoLt2NucN7F+U4E/q7NANOwgrGykuZewb65smgUEczRD3fBdtYTK7d/E8+l2gn1jt0Rdsd3bDSKkP8OesJXVpmjw7YAX2dzAe7Ypok/cjqqUiZvAXDS4jdr4jwD/RQBTeg2qUpMeLx0n4BN5tA8FPU5SggP4CPbFseunzhMfSstQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN/tX8jwrIhgWB1LhVOagSt7apLi3qUxZ32O/cV1ByQ=;
 b=HoFnFK9luB5rIfur0ao9F5SRLu2IP4cMnrppsgP7ok5xq/eKdDv1HXptY6tAWRBM2vAjBQmeK+RD7OilAXjovv+dDwdo/zsfoHuKWIPSfmYFpKbOpem1ospM0e92bqwhFfXhiG1CNlpfzaGVRjcKQxu5DEck2+npN+rb58PcKxk=
Received: from DM5PR12CA0010.namprd12.prod.outlook.com (2603:10b6:4:1::20) by
 DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 16 Jan 2020 20:14:26 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::205) by DM5PR12CA0010.outlook.office365.com
 (2603:10b6:4:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Thu, 16 Jan 2020 20:14:26 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:14:26 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:25 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:14:24 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/22] drm/amd/display: check pipe_ctx is split pipe or not
Date: Thu, 16 Jan 2020 15:14:02 -0500
Message-ID: <20200116201418.2254-7-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
References: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(136003)(428003)(189003)(199004)(86362001)(54906003)(316002)(36756003)(26005)(81166006)(8676002)(186003)(7696005)(2906002)(81156014)(4326008)(8936002)(70586007)(5660300002)(2616005)(1076003)(70206006)(426003)(356004)(6666004)(478600001)(336012)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4283; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9329bbf5-d445-4457-76aa-08d79ac0afa0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4283:
X-Microsoft-Antispam-PRVS: <DM6PR12MB428331D8690AEBAD58D94887F9360@DM6PR12MB4283.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aLOkLsj8Am01FHXOol0GAeMqLteWToqbQauBY+I2VR9BAXruhwRhXc/+q2c42v6t4edGUSBLAGOkw7//bpiuSbA589pAVGrp4FrFFenI5Zn2OQ+r5toEzvV/4sKSTwJsryKENiQfUcZqX/AsfGqkPHkJ6PLflQrxVLZZewuEI38B0/hMK9arIKeXzfsUoA5ZMqi0X7akC5v2L95nVxXAPGikm4r3RxH5Khr7O73AW2x5eFmvT6dlJJy9pu8w1GUKc37+3kkaNlsue6gv+rn+d8jSburDZdYMdp+jPp9MBgd/eiPNqVXNeEWgQMIbjcNMmUsVhyNkT6dIuRMEdrhvCQPXXl4FzW7UVYPpAMYSH2cj/BbxQP+7K9coUQAX8eeW+KTc4DJ5M2uk1bSkN/ALExGnyYx4Xc/jG0/sktLzB47tJYa0eSMx3O+MExhvTkcC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:14:26.6101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9329bbf5-d445-4457-76aa-08d79ac0afa0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4283
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com,
 Paul Hsieh <paul.hsieh@amd.com>, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Paul Hsieh <paul.hsieh@amd.com>

[Why]
Driver use pipe_ctx to reallocate payload may cause allocate
payload twice on same sink with split pipe.

[How]
Drvier must to check pipe_ctx is split pipe or not to avoid
reallocate payload twice on same sink.

Signed-off-by: Paul Hsieh <paul.hsieh@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 260c0b62d37d..a50768a7ba68 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2882,7 +2882,16 @@ enum dc_status dc_link_reallocate_mst_payload(struct dc_link *link)
 	// Clear all of MST payload then reallocate
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream && pipe_ctx->stream->link == link &&
+
+		/* driver enable split pipe for external monitors
+		 * we have to check pipe_ctx is split pipe or not
+		 * If it's split pipe, driver using top pipe to
+		 * reaallocate.
+		 */
+		if (!pipe_ctx || pipe_ctx->top_pipe)
+			continue;
+
+		if (pipe_ctx->stream && pipe_ctx->stream->link == link &&
 				pipe_ctx->stream->dpms_off == false &&
 				pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
 			deallocate_mst_payload(pipe_ctx);
@@ -2891,7 +2900,11 @@ enum dc_status dc_link_reallocate_mst_payload(struct dc_link *link)
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream && pipe_ctx->stream->link == link &&
+
+		if (!pipe_ctx || pipe_ctx->top_pipe)
+			continue;
+
+		if (pipe_ctx->stream && pipe_ctx->stream->link == link &&
 				pipe_ctx->stream->dpms_off == false &&
 				pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
 			/* enable/disable PHY will clear connection between BE and FE
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
