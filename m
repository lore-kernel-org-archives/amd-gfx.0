Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E472FC2BABC
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7C2C20644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DKuFCaMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C2C20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FBBB6E2AF;
	Sun,  5 Apr 2020 20:41:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 921E46E2AF
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:41:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPAWUFPKf1C2SR1/rpAvqaI9mFesQIwFubhmiob9u+2S7Il07+nDjvHucQ7XmVErbHIWiOZ3cajNJtQU1+KucBHYwoZP5ufGdjTPkFRv571xh8vvIhnCh2v1ChTj4Fy5ZcWhiMzPpiM63AutNj/TtlgWtQpq/Pw99xRP4b1txF6XEI1zPxYhF8SrvG8WYsGRsVICmTPZmeqFiJk5ZyQ4KCtfW++RJ/6XfkpXDEVV+vIhfFAkATg9ZmfhWl2fkloHE8sfXBBpMVgci51dbaZqBIwVXG05K1EZP7ktBrET1MK07vcv4SHetymYW7Y42cBkjkCTBkeCVoNuEMhV3VYRng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yezMiLRYgR/B3OmOUEvHOE06xvqqsaKrMh5XZYK1Huo=;
 b=kBMGmzVxKazgCiGpvpu4tyLFLIp8TgBiLBeG/FMuLNKjxd73BN6JcTWlNT5M1+Xs77McZOrF1zT72d1vBYs6Lm5EXY1gIMd2RjHT2DcE6NVKulttP6r5wWbDD0aCFuZ6bv1lp6hultWxcm4WwT5d+apsv34WHgJNb1SkAfusiayIYBNMqG1ICWVhuZA18vpK7iV6HdrboALchfhpxTRNxwS9yjzCNExJhOdOCv7wQa3thwekqDCF1gq1/DQvsTSxYhkqcPc1n+tXK59M0dXG7eDCVgWylrV7mB2MYRoSWyTp44xZGUXCAOVN34icthGolGMZPpMrMwI8q6fRDMR0sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yezMiLRYgR/B3OmOUEvHOE06xvqqsaKrMh5XZYK1Huo=;
 b=DKuFCaMNp8IhLVOWXl6fXlukNpTkJgEWk59cUVALZqd0zxaGLuehUtbKpPIIZiazc9Q3IadmQPO9vKMxc/9Oth1KAY2iToSkEppHp3N9bStmcQAlKLYTiwlRgzxV6jD873WxplDbp2Zhu4I71bzgBXUHc61Xd4VmVbskEUfKtt8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:41:56 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:41:56 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/36] drm/amd/display: Program viewport when source pos
 changes for DCN20 hw seq
Date: Sun,  5 Apr 2020 16:40:56 -0400
Message-Id: <20200405204115.683559-18-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Sun, 5 Apr 2020 20:41:55 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: de4a8d95-7925-43d5-85cc-08d7d9a1c784
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25554A7C9B9E6E405608EBA398C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(8676002)(6916009)(8936002)(6486002)(81156014)(81166006)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AwlNW7HDJKxKA6TmJHje80ClLKW3ZeSmtjH3aZGedvzFjpb8ZEJcRgvn09IhoDpOO78xGu96m4FYOjtFp3vW6zODe+Nsx2fd6bL8vDtMt21LDGu5yIz6vV7/UUFUxo/Zk2zKBoCKzfqfCGYxHqrH8M+OcFGLstK/q1ZBE2VcdNTCfOoJjZI/EpgsOM43ZGsuVC1yIOS7u4fN+6tpO8wMxV5MQFMjytKJlLwN+TYA6LqAwmnl4CUF6UgWuRYtAnAasf8D5YBqxXTm+aPfU5WsM0ujkBMGEI+69P81S5SyyXcn6pV5LmhTUiVTi3Sez1X6TSL6XW+zSK4NNO++PlaBvyUfXlQGaWCu/AUodSRu0A7pHF8/XDP/NdburCTegAsRQZGp01cVtfT/rxcrn7CiL6mNzNHidbEoUNZSNN4/RwHwP3WpIjShDj4NuIBiKl99
X-MS-Exchange-AntiSpam-MessageData: 4KAn0iqRnr7W0zhPcCEWATh5D670z9EfTtACF8xxqeQ/cXgLxH4xIl+J2q3hL6L/dWc8KncYa9gX9fA7RtIWo8uFe4OxinXQ7lFqPt3shwSfIaeT5gFEp1fGM1S3oyUcwzjhIJL4PPod/KyzjxYvuo8XBVDGmUsDT27wLXioPBo=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de4a8d95-7925-43d5-85cc-08d7d9a1c784
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:41:55.8636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JjTraKAO56+E32aV4NR41n4Njv617ipKhK7uKvVqKYy2K1Qe24KwR4YqVH2Bo8J0zQ4QI9Xseia0dPzjK+nz9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Zhan Liu <Zhan.Liu@amd.com>,
 Harry.Wentland@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
For medium updates that change nothing but the source rect position
the viewport doesn't change on DCN20.

We're missing the check for the position update bit that was there in
the DCN10 hardware sequencer.

[How]
Check the position bit along with the scaling bit like we were doing
with DCN20.

We shouldn't actually hit a case where context != current_state in
our programming/commit model but guard against it anyway since it was
guarded for the other bits.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Zhan Liu <Zhan.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 674e4b8abdfb..7e65c774c800 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1373,6 +1373,7 @@ static void dcn20_update_dchubp_dpp(
 	}
 
 	if (pipe_ctx->update_flags.bits.viewport ||
+			(context == dc->current_state && plane_state->update_flags.bits.position_change) ||
 			(context == dc->current_state && plane_state->update_flags.bits.scaling_change) ||
 			(context == dc->current_state && pipe_ctx->stream->update_flags.bits.scaling)) {
 
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
