Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3F4C18E5B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE392051A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OFKixCCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE392051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D5276E454;
	Mon, 16 Mar 2020 13:50:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88A766E454
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 13:49:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsKODpeZd3OKYmOAHnKXTCbl10RunhYTfcw4n7gm4et+KxOZmrtUPvyF43CFllixWriVpbQLI0oTNhzpdYNTHa593GhkK42iQV2nVazCnhQhz2sXzj780zLpvE7buTLkGsUhmZdAlHpPEl+ycKgIGV01kYdccVURvNKftkPlu5vglLi15f6MN16lLJbd6aq1r/DU9bZZvi4e4cDCWd4KVOGemk+WTlo5Resk7RRhpOjekGTK5NoIUfsR2fq97PwG8eCpwwhkWyh2g5cTev4I+JTDsreAoVo5YTRy/GV6Syyrvj8/GB6sakTZGcAIbZHxgBO5cbQjhjnkMUdSjDbvOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjNyrsoQpWtVwt4CmjBeMtyuDQNHtvkCbrzdoKOqeNQ=;
 b=ehClyEo2kDA0LpCfYGohIEdVVOqCuDO/zT7Xdu6agLSyCmMeWInqjOKz0csR+h/t6kvhyNAGwCs43SKP5NlaWFdS23Or2uOXL19lzwJEpYg91BckTqlc5s5c6pzSy54GTbJNkaBVSFHEkdlkK9CrRDMazm80SbJVv5qShzhNIhw7JK6rS4EkS41Vat7KaDBf6nKwJILiKQqlZLhmjgvT/3npfv1eitRl/FlYmoh4ZKxPx1p1uAqMhaK/aKVAj1yKtuxMJWf5WhzXFCqWH2IjKvomrvEMBhTI7Bd0DTTrmuEumWsG9SPmI1oX9l/bM/VKRn3MfbmtkxyE4Wv5HFHm8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjNyrsoQpWtVwt4CmjBeMtyuDQNHtvkCbrzdoKOqeNQ=;
 b=OFKixCCfJC29hVfVRCQqANwV3n+pVoq+Gp9fJqqQm5mVxmSJqkDy1dxtHWwVW5oLbIcc2uTMKVzQ0vgXVUerPMibV4uSHBZB1kAR8hrKUjNJzymAfXYhPU9iER2/I5k0MSuet4k1RDjO0S/SaXxiU3FIen3Tf5/Bsa/Jop9BO50=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2363.namprd12.prod.outlook.com (2603:10b6:907:f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Mon, 16 Mar
 2020 13:49:57 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 13:49:57 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/19] drm/amd/display: fix split threshold w/a to work with
 mpo
Date: Mon, 16 Mar 2020 09:49:06 -0400
Message-Id: <20200316134920.2526155-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
References: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Mon, 16 Mar 2020 13:49:56 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b0022c34-1aee-4c67-99ed-08d7c9b0e9ba
X-MS-TrafficTypeDiagnostic: MW2PR12MB2363:|MW2PR12MB2363:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB23637318806E06E4C740295598F90@MW2PR12MB2363.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(199004)(8936002)(16526019)(478600001)(8676002)(7696005)(52116002)(186003)(81156014)(81166006)(6666004)(26005)(6916009)(54906003)(316002)(5660300002)(36756003)(66556008)(66476007)(86362001)(66946007)(2616005)(956004)(2906002)(6486002)(1076003)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2363;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VCl6sq/E81a3w8sR9onjEKTPFIizeBybjtIZZq+xOgd+qx2I3rSS/6Dcg3sc2eyn0Ks1kBOSL5izVl7mus2ZPxhCpMP3tEKNGSov2zUH3C/9vvsbQM+9lx/zAQ0HUGizFDRTifPmwcZ6jEdLXOzs9/F2Zaqn1Nkk/iv1Svfyr8Ve3THKY32b9OsD9VDu8vnEjpCtA7xbtdeOGcaVGx5RE+rzTppl+vyw0yvB4scrdsv9RFErfgayRYG0CKgWHMCdORBz3P7IzZF542XNvCunje1aTk0jIa/OBdxtLeO5e8zcip2CAe4ZYJC4lF9BjJ7gKipoN8H83OFnaoEuF9OowDjsd/uEtF+AkALgFfI8r+3xo+fC9oqOkvMQAV3GjA9Jr2dK79GIdI2WFZ5lePzcZ8p45Bg0iZ2N1IWMnfoN5BOsF0LOXvA+8x5OZ0ay7V4A
X-MS-Exchange-AntiSpam-MessageData: 1NMJPPj4Lwp/MaB1nPdRzHF92Gy8kSekTRkb9hnuPZjiTWTHji2yNTIQtgmg4NqLcTbIrKLkTNzbqR5B2supMeaYQdu9KKKKEZbQEC9wv5QlygfpKYn+sfQdAIIDTUpH9klHaURi4mfviYbKAyq7kQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0022c34-1aee-4c67-99ed-08d7c9b0e9ba
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 13:49:57.2410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMtOK2ooCEk/LFmOYJTLPPpxWVlK38vOba2OImpkVFUrThPN8vc1Xx3j3UyS3j0FGTJW5nCaVrXFX95SWXGUpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2363
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Right now only stream count is used to avoid split.  This change updates
the W/A to check plane count instead.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 39 +++++++------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index de7b12520d72..faf4f5ef1795 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2568,38 +2568,25 @@ int dcn20_validate_apply_pipe_split_flags(
 		bool *split)
 {
 	int i, pipe_idx, vlevel_split;
+	int plane_count = 0;
 	bool force_split = false;
-	bool avoid_split = dc->debug.pipe_split_policy != MPC_SPLIT_DYNAMIC;
+	bool avoid_split = dc->debug.pipe_split_policy == MPC_SPLIT_AVOID;
 
-	/* Single display loop, exits if there is more than one display */
+	if (context->stream_count > 1) {
+		if (dc->debug.pipe_split_policy == MPC_SPLIT_AVOID_MULT_DISP)
+			avoid_split = true;
+	} else if (dc->debug.force_single_disp_pipe_split)
+			force_split = true;
+
+	/* TODO: fix dc bugs and remove this split threshold thing */
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-		bool exit_loop = false;
-
-		if (!pipe->stream || pipe->top_pipe)
-			continue;
 
-		if (dc->debug.force_single_disp_pipe_split) {
-			if (!force_split)
-				force_split = true;
-			else {
-				force_split = false;
-				exit_loop = true;
-			}
-		}
-		if (dc->debug.pipe_split_policy == MPC_SPLIT_AVOID_MULT_DISP) {
-			if (avoid_split)
-				avoid_split = false;
-			else {
-				avoid_split = true;
-				exit_loop = true;
-			}
-		}
-		if (exit_loop)
-			break;
+		if (pipe->stream && !pipe->prev_odm_pipe &&
+				(!pipe->top_pipe || pipe->top_pipe->plane_state != pipe->plane_state))
+			++plane_count;
 	}
-	/* TODO: fix dc bugs and remove this split threshold thing */
-	if (context->stream_count > dc->res_pool->pipe_count / 2)
+	if (plane_count > dc->res_pool->pipe_count / 2)
 		avoid_split = true;
 
 	/* Avoid split loop looks for lowest voltage level that allows most unsplit pipes possible */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
