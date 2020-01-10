Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FADC33CA3
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CA152082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wyCi3thr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA152082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7112A6EA39;
	Fri, 10 Jan 2020 14:47:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8E816EA2C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:47:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YM4tbSFRaEbEE0HCwQtnVYhXcB0RHHvTGKCNJvaG4+XbnB1zSjxMidbCAMMn3E4hmxhDpEULSbVPi2MWiRMgY26pc3i1dLRHy5BvgxJgqDFSiRC+RvEES/vrplTtT411YOuqUMRZnHmvcvy3k1AmHTr2L8AnydSSgGTh2V07/hsEX8vB1GOCUdrG35zLIpbBkPbu+EDmJk4ya9gUqYPMJj3ya8nNJfUF37l3+vB+jo2BzGUDDyPfu6JVnBJ5ATfH1MSmaPA7+ip+HqNDoh8DmFEMuwcEVD1LKIjdBVkHpUDXvY+dSk3WpFsC31irAL25j4KSbRSwks9dgwiGKuvstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBOva6aVbr+/a/SQ6OsulcUSiY5kyAh7d4huFCirMEI=;
 b=BSW9IFt75hM2dBN+bCIhQ9jOxcmgXHbWD1rj8/FzW2ASRj4y6hfr2FFd5sC9au0zCFC6ASoH5CUVOw1dCQBTIdaU4kvgNmEpOphmAkC7SuzW7V6CoXD7VBqo++5J/b8ntmGnbOcl09cW+aY7i2Av4RJR2RLrf8hJBH8zHhTGPnX/eS86vVMGptWen555/oxeJnLY1Dr92fo8agww8HEJq18HMsMvtKxIcPKsckchXWBhmIzB1e+BpTT4ntXEu95ihSQP/puj62k0JIickz5lEHO+fLdsJ9gI1IKGWRez7JAavXVlbroBjOJNJ4LIel9DPBSQuPffJ0ua9CWJlzLjeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBOva6aVbr+/a/SQ6OsulcUSiY5kyAh7d4huFCirMEI=;
 b=wyCi3thr78xkj4qQ9CWdVDh8Wpmvf9s5SjP5LEIfloQ+c2Bp3SoyO6SgxIlZwFpbvMygbUeUomEO1b0YJrBO5z9pEn5sRcnwpEes8LLm/PT8XaARvNnSnqlnL8o6YL5g5CrLsgFrtDU6wNRa/OpPwrvkObTB0r5cDoNXhfygiS8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Fri, 10 Jan 2020 14:47:27 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:47:27 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/43] drm/amd/display: Adding forgotten hubbub func
Date: Fri, 10 Jan 2020 09:46:19 -0500
Message-Id: <20200110144655.55845-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:26 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 73eeb9f4-a3de-4a3d-7229-08d795dc02a9
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:|MW2PR12MB2524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2524E6432A1BF5047212E40398380@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(8936002)(5660300002)(6916009)(54906003)(81156014)(6486002)(81166006)(36756003)(316002)(1076003)(2906002)(6666004)(45080400002)(956004)(7696005)(52116002)(478600001)(186003)(2616005)(86362001)(26005)(16526019)(66556008)(8676002)(66476007)(4326008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2524;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EOxBflBZiTjI/yvwBpPB9npto9QdTota5FYYkI+cy4KRaJ7WHS8fYz5DZ7fcthwBuyGE8U4c5FUdU/o7DBlffJG0pzq8Ak0lE2ZYwZDTJJ9memPGkRAsmKzjEXY/h0Cmo+WR8OKQf3h55FfWYczrA2DAyacmMmIJDjZA6QC+d0ByNFJ5Dvw54jid2MBGLt9EDnjTwQKxafBCFK8cEaxufmmACECgL2f/lzZ3Hwgh4r+gCzbHciRcicL6opZXEzkBiiGhfWEvPftk5USvNRaa57f4229z2/RU+LPfgYTjUvnqNTOO1Rn2MV3DR8nQqvkZ67e0PbajTLglxlKo7jbiksh9isSFBpYHaFWbuDj+sQkOu6hs737BC58x2DjzCa+XoOeAENU8L1CVuT9CixXgVNySr5oOMub+RaZUJ5kGvq51gPmoLULqzw4VWMosu/Sm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73eeb9f4-a3de-4a3d-7229-08d795dc02a9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:26.8516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lsvRvzOeXqHWFop7hiXIwF+GUX+YP6ZmlCIWxwA8MusZLhjYuSV/mpAwM1toF/dva9NG8l8zT4P/zZzvdighw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2524
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
Cc: Sunpeng.Li@amd.com, Harry Wentland <harry.wentland@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, Martin Leung <martin.leung@amd.com>,
 Bhawanpreet.Lakha@amd.com, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <martin.leung@amd.com>

[why]
While doing seamless boot I made some changes
to dcn2 hubbub functions, missed a link

[how]
link hubbub1 func to hubbub2 usage. It has already
been successfully linked in dcn1 and 3.

Signed-off-by: Martin Leung <martin.leung@amd.com>
Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
index 8b8438566101..836af0f2bbda 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
@@ -601,7 +601,8 @@ static const struct hubbub_funcs hubbub2_funcs = {
 	.wm_read_state = hubbub2_wm_read_state,
 	.get_dchub_ref_freq = hubbub2_get_dchub_ref_freq,
 	.program_watermarks = hubbub2_program_watermarks,
-	.allow_self_refresh_control = hubbub1_allow_self_refresh_control
+	.is_allow_self_refresh_enabled = hubbub1_is_allow_self_refresh_enabled,
+	.allow_self_refresh_control = hubbub1_allow_self_refresh_control,
 };
 
 void hubbub2_construct(struct dcn20_hubbub *hubbub,
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
