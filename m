Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B38C35240
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A94F42082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wZf+fNFf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94F42082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DD1E6FC46;
	Fri, 31 Jan 2020 22:17:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 630F66FC40
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Au4BY5g9sloMGsP9/Y96+SVyUMMwNgjHqvREI9jbKLevuwZ3CzFy/Ri04DetpPhf7D+5x8qOOpKmYiBUCHNBBbvqBGk+skPoK6ig8QX4JJWlf4MoeD6XzrWdPRMm6QiHKYGPy7sOBDA+JzEGfTv0n1UYXYJhZlOPbG3SLriuaNcz4J4yUpYG69nsxtkNJTe1ABFl3sver+UFA8DzksN74lx0nnBj44cRyW1KRv9on9wfp7PVGl97PQaAJCgM1+QPxX7h7QIkvhxb5hbLRF45M56B3X3yHH7M9jWdLKqVBVD+tlsJPCpOcR68GBrq7+A7xCVoTQfhgLw7uQ1WJlSDMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URAebmJuxQnBPlZW1D8RiU6geKlQ6+Pek/wFpx+XjJM=;
 b=mGardI6mn0wQsWyImex/Ztxq29OGb2z5XtE513pMjk28ABX4X6zGQURPaynstltIFltHI5e+ismwiHmiFDfJQr6sM+RvPAHGi+Doap5obIuSGri/ECGtI1SM/EKRv6pG+p5/8RdKILAZbTWqICx1G9ft9WJTA9kKvxf0mfV2XAfuDmidGyPmqB48Sgo/Xt23nEDhyxX5NFsTtXzLQaC5XPHk0G7ZpFisJ11BxJeUJntw+bFqU3/KJciJYyOMnOilQFe8Mn04rKfhGiQdW7JCtfNF3RbWb1Cj4y6E0p+1idnWQzHla6mSVKSJLJe2XyuzaV+LuCA+eRPmuKtPZLZ1BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URAebmJuxQnBPlZW1D8RiU6geKlQ6+Pek/wFpx+XjJM=;
 b=wZf+fNFf2SnPD0RrBDeY1Tzju2CrAcVDanqXvRZG6TOMxzQBeadLP/TbeHOWGUxYFf0Cl1CFykRuLjEDOdXpjvgjRSOWZHJO5hUKT6BIKL0Ro/yOtIm/srQIHpP+LmKp/tMt4CvbV6ROg/+7mn5y8qI3OklEmP5DOnTb/KX9TMk=
Received: from SN1PR12CA0095.namprd12.prod.outlook.com (2603:10b6:802:21::30)
 by BN8PR12MB3444.namprd12.prod.outlook.com (2603:10b6:408:47::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.26; Fri, 31 Jan
 2020 22:17:21 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::201) by SN1PR12CA0095.outlook.office365.com
 (2603:10b6:802:21::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.23 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:20 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:10 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:10 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:09 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/33] drm/amd/display: decouple global lock out of pipe
 control lock
Date: Fri, 31 Jan 2020 17:16:31 -0500
Message-ID: <20200131221643.10035-22-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(396003)(39860400002)(428003)(199004)(189003)(7696005)(5660300002)(2616005)(36756003)(4326008)(86362001)(316002)(54906003)(6916009)(2906002)(336012)(186003)(8676002)(81156014)(1076003)(356004)(70586007)(70206006)(81166006)(6666004)(26005)(426003)(478600001)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3444; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 787856bd-bd11-4a32-dfd8-08d7a69b56db
X-MS-TrafficTypeDiagnostic: BN8PR12MB3444:
X-Microsoft-Antispam-PRVS: <BN8PR12MB34447F154BFE1641221C35D4F9070@BN8PR12MB3444.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nVJ8j4wA/HjsjGDiaLMhuu4jT95RKUAV0xX+1ZVaTrtGjZt5IxPydhXVwimDSvvz5FocmYs0gFrL8HLyQjC9bYiFGag1Lkrw/78HMd00e5MQ6iFErkVtNzziZuPNeKdA5QFFV8dNF/up0C5j2EAB08i5LF2+3noWyCSbWFblB5XmkC2UGUcsLnEKSAewYzFOErKi3XCYacMglcx1ND2iJR9OOdFtM3GEgZM/bOv5nVzx08mWORXqmCjegWhKg8rmY13WUQA6BPyM7Z/+n61vfuyr+m2PrcWYGOBnpO68G/rhpxUT17izzV3eeeEuKToST2IMpZYPdeTNeZmo1uJtHQ/3tf3kQnrwfy7puP2aW2x5pc4ncTZHADJLh9eVcmxtHhGaIJWLGl4SFrQXRnsZls1HbsSf54X6dWA9zyT4eIPcxZDdUgT8fzFrkQ/OYRqA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:20.1985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 787856bd-bd11-4a32-dfd8-08d7a69b56db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3444
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <Wenjing.Liu@amd.com>

[why]
hwss should not guess what type of pipe lock is needed.
The caller of the lock function should know
the right type of pipe lock.
Decouple the setup of global lock outside of pipe control lock
logic.

Signed-off-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 20 ++++++++++++++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 27 -------------------
 2 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7fdd82b7708a..40878b86a05d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2220,6 +2220,11 @@ static void commit_planes_for_stream(struct dc *dc,
 		}
 	}
 
+	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
+		if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable)
+			top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable(
+					top_pipe_to_program->stream_res.tg);
+
 	if ((update_type != UPDATE_TYPE_FAST) && dc->hwss.interdependent_update_lock)
 		dc->hwss.interdependent_update_lock(dc, context, true);
 	else
@@ -2377,6 +2382,21 @@ static void commit_planes_for_stream(struct dc *dc,
 	else
 		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
 
+	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
+		if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
+			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
+					top_pipe_to_program->stream_res.tg,
+					CRTC_STATE_VACTIVE);
+			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
+					top_pipe_to_program->stream_res.tg,
+					CRTC_STATE_VBLANK);
+			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
+					top_pipe_to_program->stream_res.tg,
+					CRTC_STATE_VACTIVE);
+			top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_disable(
+					top_pipe_to_program->stream_res.tg);
+		}
+
 	if (update_type != UPDATE_TYPE_FAST)
 		dc->hwss.post_unlock_program_front_end(dc, context);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 9713f452debf..52ef4d333112 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1094,7 +1094,6 @@ void dcn20_pipe_control_lock(
 	bool lock)
 {
 	bool flip_immediate = false;
-	bool dig_update_required = false;
 
 	/* use TG master update lock to lock everything on the TG
 	 * therefore only top pipe need to lock
@@ -1132,19 +1131,6 @@ void dcn20_pipe_control_lock(
 		    (!flip_immediate && pipe->stream_res.gsl_group > 0))
 			dcn20_setup_gsl_group_as_lock(dc, pipe, flip_immediate);
 
-	if (pipe->stream && pipe->stream->update_flags.bits.dsc_changed)
-		dig_update_required = true;
-
-	/* Need double buffer lock mode in order to synchronize front end pipe
-	 * updates with dig updates.
-	 */
-	if (dig_update_required) {
-		if (lock) {
-			pipe->stream_res.tg->funcs->lock_doublebuffer_enable(
-					pipe->stream_res.tg);
-		}
-	}
-
 	if (pipe->plane_state != NULL && pipe->plane_state->triplebuffer_flips) {
 		if (lock)
 			pipe->stream_res.tg->funcs->triplebuffer_lock(pipe->stream_res.tg);
@@ -1156,19 +1142,6 @@ void dcn20_pipe_control_lock(
 		else
 			pipe->stream_res.tg->funcs->unlock(pipe->stream_res.tg);
 	}
-
-	if (dig_update_required) {
-		if (!lock) {
-			pipe->stream_res.tg->funcs->wait_for_state(pipe->stream_res.tg,
-					CRTC_STATE_VACTIVE);
-			pipe->stream_res.tg->funcs->wait_for_state(pipe->stream_res.tg,
-					CRTC_STATE_VBLANK);
-			pipe->stream_res.tg->funcs->wait_for_state(pipe->stream_res.tg,
-					CRTC_STATE_VACTIVE);
-			pipe->stream_res.tg->funcs->lock_doublebuffer_disable(
-					pipe->stream_res.tg);
-		}
-	}
 }
 
 static void dcn20_detect_pipe_changes(struct pipe_ctx *old_pipe, struct pipe_ctx *new_pipe)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
