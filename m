Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF9AC388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 22:08:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C4FD246C5
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 22:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="l6nYWS35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4FD246C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 548AC6E5A4;
	Wed, 28 Oct 2020 22:08:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76FB36E5A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 22:08:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JosIr9pkokLztnIAsBKUkseEwx7+ft7fsdzkJtofkZjsNtXWc3gqE0PHaIi9GnLn9wxkg5s4smZOrhmi8q10dSaursw29HNmkB9RsvSAZie0WNEhK6GHw7vxnTPyNmwHyc4ToP04pGc43b1n4pkA1L4rVvEvYcp69H4JSgxv6rr2bBO4DNIT4dTvb9ivBe3rdDYmyZa0VDDrJvfvUO7U6hBnjj8Pe4jltnl8vMaxdHxKjx7nUQL/MSa1HpOIWLeWmFoi/JBPHLEGOYmYAaLeqO6O1UxrZBZDvtnfxJre7luIvePlYHAn91jdVJf5kej5Z2/XlBVHUb1V8Kvy3cE9Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCXa7QEyxgj+w6nl9NPVvlBXVwhtvfy0p93e1i5ZxRU=;
 b=SqN4+Rsl6IL5b1plO+7tF0ZJWE7Eiu/1IKmySd7+wGTYKnFjeiIqgz1Bp52fYW3echFheQFj8d7r1cYURME8mQ9jQWFUnFzWEUYEe+lIwp9NwGnevjYsGvdD39ppss3mxRP1A6b5jshs4az+Xjr3N91PDFUwVdB+r/9VZHq9QOrpiGwrdJ3p4VaGsEPj0PjME2Kry3ktBnpeb/sTkNSXYQd6lTyXn4SLhLTt1uX0IgQz6Sl9pT5Ve9tofWStZAtoZizXlzsTSNLIHioD42QXOikOONgSzB9pHtr037kWi0DlbLwtHHa4hSDqYfRFBeyqK95nLbkvyvWCOgfxx3SV+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCXa7QEyxgj+w6nl9NPVvlBXVwhtvfy0p93e1i5ZxRU=;
 b=l6nYWS35czUKiLRrqD0uG2AroVSBC3knHfzEQKbZra7ajzmVSVQgSwjMbx08dyYIVFvH2E5Fx4g08zuuEyoNVEqBxgtUuvee1m3kjFaGHRR57CuvF/Mfx1OFfyTBnEanNpm2qGJlA307t4RefNt+g97YToSquAoZn2TDMs4bKRQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 28 Oct
 2020 22:07:59 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa%4]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 22:07:59 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: allow 18 bit dp output on DCN3
Date: Wed, 28 Oct 2020 18:07:35 -0400
Message-Id: <20201028220735.153525-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.29.1
X-Originating-IP: [2607:fea8:56e0:6d60::1205]
X-ClientProxiedBy: YTOPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::22) To CH2PR12MB3781.namprd12.prod.outlook.com
 (2603:10b6:610:27::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::1205) by
 YTOPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 28 Oct 2020 22:07:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0ce4eb16-bdb8-44a1-9500-08d87b8dee18
X-MS-TrafficTypeDiagnostic: CH2PR12MB4133:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4133E98E6FD588CE8026898B98170@CH2PR12MB4133.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O5I7eUh6CP6rISaUMZ+5vJFryXAvLgSqe3/u7fmAR4lJcQiRD6epJapi5I4CpVQnRDfAr/bLsLcV+fTdUbLsIs5xRK7jj3MeRH7+awsELuVMKRnogpwNKbwPLk87TI4SzvCdD3qeKYJMkBXGPY+mDRXjPcUHlwgnnLXPImPKGxKo7Jm7krEaBbsVWs4wPB5w4L3uhdqyyeKbv9Iclo6dWTzpGxy7dssBVOTFuzHhqIkklLFKg1GXH+Uf1ovl/r7BD1fjFtRSr7RdPjnkty24ZFRin7Ig/1BUv/2V+/ZmT8vA/GpO5G1BQSOBhuPyq6CMgWqPy4G9FNoqqklihV1Iig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3781.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(316002)(66946007)(2616005)(66556008)(66476007)(2906002)(86362001)(1076003)(6506007)(36756003)(8676002)(52116002)(4326008)(478600001)(8936002)(6512007)(186003)(6666004)(83380400001)(6916009)(54906003)(16526019)(6486002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: BOHL0OtHO4GP6IOnW5/Vn7cSFwn6azHpuZ02mKbvnYCbEXqYUMRZ8pFeGXikrWIPjYG6G8bF/5STOLzZmILz5rKXvlRaWyKTWiR+fnx8LGg0vgnSqQocXYBTA6POKQYpSKQuVpASIWXQALR3ysigJYKNQM2oHaz9c5U9yr/U4S7Xdvk2R7pevldcQSl+HUMKgjpCccClZ0Y8416EPmpDNEZO3+WSO3jQnQyNSZUYkORzqCRckHTaaB05a7CE//qUb9+tCmm8hIbATfT59DcARYqpkNDg+2V0KQSc4Kwa+oLTpCtBg+VtrYEKkz9jnz+nsAtzNRi3vOpjgH4PEB87oesI7MZS6CeSTiy74zVYogTQKJWwd9bAFOfBv12dpcQvDEicKFKItZ7+M1pv+AMgZ8lrDFQg31kBhE/bvZEVqkwcDBkJVLi75lO7AKp2ooGYnRPUxv7CIYm+VJmoo4mYJy6SYsimGllot15Zd031aSeF7VKzczhNswlGFuyGPADCNpEVtvGnI3eXrUr0gOZQUYidqqR6G/fCcPkLA7TFT9yP4AtAxENQzjQssm90sgNLp4hvvVEHxxsHTqPmEQHsw8R7d62lwjHOFkSDHWuSta8Lewgav3cyoYK1Iws38zh5aIa1flJHTjxEq7TqC3dgihntcu9LnSH1t4LehNDQwLs=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce4eb16-bdb8-44a1-9500-08d87b8dee18
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 22:07:59.0197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upfLDhaUrrAtyNHsT56XWtUQH3bvWwvVO10bZtgnLuEzXlEFwtCJfrpEWVaP/3aTo+7nM0Rm1MgLPiuZ9xLrmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4133
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
Cc: Chris Park <Chris.Park@amd.com>, harry.wentland@amd.com,
 Zhan Liu <Zhan.Liu@amd.com>, Nikola Cornij <Nikola.Cornij@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

We need this to pass dp compliance.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.c  | 14 --------------
 .../amd/display/dc/dml/dcn30/display_mode_vba_30.c |  2 +-
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index d1ed2a99bf65..d65496917e93 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2020,20 +2020,6 @@ static bool dcn30_internal_validate_bw(
 
 	dml_log_mode_support_params(&context->bw_ctx.dml);
 
-	/* TODO: Need to check calculated vlevel why that fails validation of below resolutions */
-	if (context->res_ctx.pipe_ctx[0].stream != NULL) {
-		if (context->res_ctx.pipe_ctx[0].stream->timing.h_addressable == 640  && context->res_ctx.pipe_ctx[0].stream->timing.v_addressable == 480)
-			vlevel = 0;
-		if (context->res_ctx.pipe_ctx[0].stream->timing.h_addressable == 1280 && context->res_ctx.pipe_ctx[0].stream->timing.v_addressable == 800)
-			vlevel = 0;
-		if (context->res_ctx.pipe_ctx[0].stream->timing.h_addressable == 1280 && context->res_ctx.pipe_ctx[0].stream->timing.v_addressable == 768)
-			vlevel = 0;
-		if (context->res_ctx.pipe_ctx[0].stream->timing.h_addressable == 1280 && context->res_ctx.pipe_ctx[0].stream->timing.v_addressable == 1024)
-			vlevel = 0;
-		if (context->res_ctx.pipe_ctx[0].stream->timing.h_addressable == 2048 && context->res_ctx.pipe_ctx[0].stream->timing.v_addressable == 1536)
-			vlevel = 0;
-	}
-
 	if (vlevel == context->bw_ctx.dml.soc.num_states)
 		goto validate_fail;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 9e0ae18e71fa..0f668699809d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -3628,7 +3628,7 @@ static double TruncToValidBPP(
 			}
 		}
 	} else {
-		if (!((DSCEnable == false && (DesiredBPP == NonDSCBPP2 || DesiredBPP == NonDSCBPP1 || DesiredBPP == NonDSCBPP0)) ||
+		if (!((DSCEnable == false && (DesiredBPP == NonDSCBPP2 || DesiredBPP == NonDSCBPP1 || DesiredBPP == NonDSCBPP0 || DesiredBPP == 18)) ||
 				(DSCEnable && DesiredBPP >= MinDSCBPP && DesiredBPP <= MaxDSCBPP))) {
 			return BPP_INVALID;
 		} else {
-- 
2.29.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
