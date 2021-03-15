Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6722AC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 215C864DDF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215C864DDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF5DB89DE5;
	Mon, 15 Mar 2021 11:23:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3212589DE5
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 11:23:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbGhE/YTPWTauWMerxtrOFx2BOOWqkICbNx6a8n7dK+Ji+5tD4jyS3Lg2GoJg4c5BW/I5Ise6uQn5cvsvzbHXvBWbwvqjOeXAsaEV71jNsfB5bu3byztqzsEXNrD4wWZy/72wsgTEUOUYVAFWgSt3RqCMTdmjJbLDgv13GR9ruBJ5mc2nzCsAzm1xZYrgwGh6ppy0ObBANxotEB443B9towoNMiPrgYoAjAEaR+FkdfwLrKy683CRSStAmh7XM60bv28j52j1DOOcqxY6btqY1nrf78JwiK4IcIWT4lXt0M5DCLkwGNgJjwDV+oVJi+PjjZMJ7eGrz3sqU2NkuGo7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICB3uscLnpIRfdMycCb49exfMyph28WgkjBBw5Ao0dY=;
 b=C/8Hdp1J2vRMJ6YeOmACKiqXhWGlDAZFWYgEcX4XUvwSoNXZdc9Y/VwpnCG9MDVikd/kcMeNVDDYtphU2GrM6BNtDjBpaQ1H9iZuMyAfBycR42da1K4YT5NcV7JhZDPNDzsy5XOnvM+/cRBTaOPzTuVor94qApHn6XrcE82EjYvPqLX7cmXNGNtQiwO6bqufrZQDHVb0v2k/+DXq9vu57015T8+xuc6wwREV1oEvrERqbq21H8g3zXzrtSHHHrb+KqY78rh3ozxSjb5uM5g0Tf3A5l2YBws8KVnBuhOEcQXB5u0WUU3NqIJlm5zel/+aKmxycOpg1nYW7cgZtqyQig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICB3uscLnpIRfdMycCb49exfMyph28WgkjBBw5Ao0dY=;
 b=kPgFarAaFDjJcklso/qKINe+b8yULcvTf1mBmfxeiajyiH2I0X5D0uxjXP5A1mt531JDOp58kAF0ZLYQyv8PJJuKjr+57YiXAoTFyK5w3EKTAVT0lNoJlBNJWI7ixp2fndejQ8PHfDFiIGGAOvh7ohiyd6ung3zmfpSuzpYLypA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) by
 DM6PR12MB3740.namprd12.prod.outlook.com (2603:10b6:5:1c3::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 11:23:04 +0000
Received: from DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7]) by DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 11:23:04 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/23] drm/amd/display: Remove MPC gamut remap logic for DCN30
Date: Mon, 15 Mar 2021 09:39:58 +0800
Message-Id: <20210315014010.16238-12-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210315014010.16238-1-solomon.chiu@amd.com>
References: <20210315014010.16238-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::12) To DM6PR12MB2604.namprd12.prod.outlook.com
 (2603:10b6:5:4d::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.2 via Frontend Transport; Mon, 15 Mar 2021 11:22:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 64738332-e6ab-4bc3-8758-08d8e7a4b30c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3740DA83FD62008F8E5FB0B4976C9@DM6PR12MB3740.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UnoX5Oy81O30zngkqHQ4LtHRRyZ58GTXmqftMZiOqm5SaJ4gcij/Z1wlrPKj8gp3Z/Y+Zat71LJHZe69m9rWsc5O4k+VyMarHxBjpyxcy98Z4B+BebO/IQIIpYOO0mDFIsmt1RaxFW4s5+aK9xbyv/hKX2eJu+8wnRedb6K4N86ploNTICq0NRMu41IIXF0ptAQUuV+v3naHQHHOaSqGCueWOWn7aYRfEHCksZPns+QIMebbalJXo14fR01fmY/829Xmt010Ig5z3pMRhDE62nyxgU5HdzlCZjVRU3lz8THTqiwXW01Jhkq21G6utkoOeSlIj8TYVMmU0ceuU/0189UcliadGIJVxxXf+3Uc9izX4AP9qA6oB6WkkB0M/+/pWvjg24sYgJju5V/n/jrZYSK1oP6fOy2f+/APgf8eqhOdy4QQAM++Oa/rBzLboA5N9U5evairhHgh2Ns8tpi1skyrVy5qkVWt9XwBVk4sIuzoKV/oI5yjs5nGDB3tldpNJJAaFqkoW/TX1TRGF7TdK3sKgzHCJs5pEisETwI/x75d82pKn1Sz5Xu0wco02WJB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2604.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(186003)(6486002)(6512007)(36756003)(6506007)(86362001)(4326008)(66946007)(16526019)(66476007)(66556008)(6916009)(26005)(8676002)(478600001)(956004)(5660300002)(54906003)(2906002)(316002)(83380400001)(44832011)(52116002)(1076003)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BLYUI5pmNXAgBqibLQpuNOTkCmgHw+pUhnrHzd+QxAD/TZSN41cgutys49uT?=
 =?us-ascii?Q?qw/SvNoqO4cP9x38b7sY+TX7yucIAIfiWgEoEY/G9FaxnwwvzV78U/DEy5ib?=
 =?us-ascii?Q?lEKJ4vodSBXGVontC/cL5/jz7m5NTcl2QSggbWoLP7wwBs4KNjH5vs3CvLFl?=
 =?us-ascii?Q?nGDiOCRxkXvw80rXc1dk1bvdHx+nKB0TLHh80MAC9cvtOGMaN9rkOP+F5oZ2?=
 =?us-ascii?Q?6+PG5cFEfrzYigwKgn6cNprYnJVaVT6f3AXhd8RDCk54vVMyhvGVTmja5tHR?=
 =?us-ascii?Q?PLdCu/3OmmcJHxWNvDTyXGKf2KekfwTH8DypQL5QzWjmwlnKKX2FQCmj+Kau?=
 =?us-ascii?Q?LYSnDQ+QdcU5gt7qNXSBzbIOy+CogklStEkAwTfwHRTWd3fy/bPgL8630Fy0?=
 =?us-ascii?Q?CsdLyWCWPoNLSRYx4l+qZqwGDnvFkarmXMlCr8FE7EJgGWvCDK9RPdIUp4nf?=
 =?us-ascii?Q?lh0U6aaZuF7gOGIFi0vFywXN/hql1YSQFk/DWubz24hheT1VsqRlRK78OJdu?=
 =?us-ascii?Q?NTM6CwVZTYhxEmIVq+AOL6NnvuFiXTsRXT4/wbKJkDeQZfosyrk5cHotTbfz?=
 =?us-ascii?Q?0gsMh+XND8HF1PSwwmd2SFtmbGyviCymTDXXNjWuWg9M0V1txImLjn7X/Xkw?=
 =?us-ascii?Q?SaKzwQDNIEurRnRpVmXOcL9dG2MIxKaoC2/aRvbYhQOSH0uPrYNuSSMgQQnd?=
 =?us-ascii?Q?Hq9zZ047Zwaz3yaprxumRjrFSzpGVAknyv+hAR9zZikkacSlREWOcKp7djT7?=
 =?us-ascii?Q?A7W79DA7Z6ubU8RyaN93v5DSaKsv6iXtGt5Su2GJ3rpkznHS7zupWa1J78kN?=
 =?us-ascii?Q?TQrlKaozZeiv0pJDRhvnyupnTqH/NRqad9H8+UtEAv4u7I17T9FjbXl1Cpsm?=
 =?us-ascii?Q?7KRgNBVPx/o3AOi0whL2gw7KI+1bsySw32DQNjLU6TOJOvcIPbwdOz+xKLBf?=
 =?us-ascii?Q?ZdWnpky47H4s0CeaPfZNTiS5rxU/rKitdAmC3ksKmKc50Qrwc3filcvdUJC+?=
 =?us-ascii?Q?Vm4uxxV/38xC7dADvxCdXLEKjkHznMbmtLc1Z0KHzelJTtB/eNE0mW9IbADW?=
 =?us-ascii?Q?YD6eqR9rk2RgjY3K5bywHBaIeQmhPWzSGo3nNB41XIJCQ4euJT8fXBBN45oa?=
 =?us-ascii?Q?PgeQ0vuZhbK7QYlETOCP+P7WJ6Dh1E9UUs4yaEQkBkwPz/fgpMHq4niLpWf5?=
 =?us-ascii?Q?pjW3uVTDdRKoT0YXFZXxaxZCKws6HAMm/lASdIfom6Ib04ZGYdaPZ0QurQtD?=
 =?us-ascii?Q?Xw+s7s74/0QPLgNXo6mLZHr2THL6qz2BN8tpuFeE8iCKr5JTxfXwKY1cSAzN?=
 =?us-ascii?Q?41MzfU5LwjcNMHlUYTVMekc+A3Sc0RHKlxAOTm6I7kMTrg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64738332-e6ab-4bc3-8758-08d8e7a4b30c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 11:23:03.9929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n40FVNWBAnnQQq3eUF/fkc+QAQbfD/mWWCVBEsPMX8o51FCKr//Y0R5DdaleOPj+klfvSw00Dm4bcSapEtykTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3740
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Dillon Varone <dillon.varone@amd.com>,
 Eryk.Brol@amd.com, Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Krunoslav Kovac <Krunoslav.Kovac@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <dillon.varone@amd.com>

[Why?]
Should only reroute gamut remap to mpc unless 3D LUT is not used and all
planes are using the same src->dest.

[How?]
Remove DCN30 specific logic for rerouting gamut remap to mpc.

Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Reviewed-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Acked-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 34 ++-----------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 0d3c7e42204f..6a10daec15cc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1507,38 +1507,8 @@ static void dcn20_update_dchubp_dpp(
 	if (pipe_ctx->update_flags.bits.enable || pipe_ctx->update_flags.bits.opp_changed
 			|| pipe_ctx->stream->update_flags.bits.gamut_remap
 			|| pipe_ctx->stream->update_flags.bits.out_csc) {
-		struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
-
-		if (mpc->funcs->set_gamut_remap) {
-			int i;
-			int mpcc_id = hubp->inst;
-			struct mpc_grph_gamut_adjustment adjust;
-			bool enable_remap_dpp = false;
-
-			memset(&adjust, 0, sizeof(adjust));
-			adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_BYPASS;
-
-			/* save the enablement of gamut remap for dpp */
-			enable_remap_dpp = pipe_ctx->stream->gamut_remap_matrix.enable_remap;
-
-			/* force bypass gamut remap for dpp/cm */
-			pipe_ctx->stream->gamut_remap_matrix.enable_remap = false;
-			dc->hwss.program_gamut_remap(pipe_ctx);
-
-			/* restore gamut remap flag and use this remap into mpc */
-			pipe_ctx->stream->gamut_remap_matrix.enable_remap = enable_remap_dpp;
-
-			/* build remap matrix for top plane if enabled */
-			if (enable_remap_dpp && pipe_ctx->top_pipe == NULL) {
-					adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_SW;
-					for (i = 0; i < CSC_TEMPERATURE_MATRIX_SIZE; i++)
-						adjust.temperature_matrix[i] =
-								pipe_ctx->stream->gamut_remap_matrix.matrix[i];
-			}
-			mpc->funcs->set_gamut_remap(mpc, mpcc_id, &adjust);
-		} else
-			/* dpp/cm gamut remap*/
-			dc->hwss.program_gamut_remap(pipe_ctx);
+		/* dpp/cm gamut remap*/
+		dc->hwss.program_gamut_remap(pipe_ctx);
 
 		/*call the dcn2 method which uses mpc csc*/
 		dc->hwss.program_output_csc(dc,
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
