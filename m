Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842B4C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5699220768
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Y+VF6auO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5699220768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AF8F6E264;
	Thu, 13 Aug 2020 21:35:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E527F6E261
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 21:35:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWqTvADibeIa+6EIvuqsvD2uY0kqP7o0w8dAJdN/qr1oHshR95ZJHtpYrSRSZQtDgw7R4dbPjzMFhJNBH7iPJrKybacVal/ITk0vfHE/Zm4MosVvWg2V4ZzuSowgtdvTlNOFfMwPZadU16Xr9FHj18ED4369XOduFMBmIdYhIHOqF8ndWM2XKA2kvqAMFjHJxQMfcMPENmcUhU2pIg4rwyDskliBv1YkHKRo6ujsZv0qt1wxelhsVssGTO0E+OZh2x0wHP1SgNa0jDiG98OmXAogwZ5o/3YLVzkEZpRMVdW5dtf5GZCSSz84XYF26VDsN3W0Nn9zuoAuNH87cZ8KOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/iop1sG8i3A7spUx4fMvHSrEeDDKEULLWYTzKF5Ybk=;
 b=iE1nJwDGBTCr9W+PHIPwQKn1L2bZI1vvZpN6Yd97vxBZ+d+L9OaAQUlogCsipM8eBa+rcgqjFxtnlyqDDqqjXtzukcC9JlvSVvZEj/oIov9Wfcw0nGe0C+1VnCD+0B+7bmjtVzlVtbZGOiMOYMHMeNZ4tVNgdFR2r8qeQTpDN83x7uTJG9JjFASlajZFAFR1S/8bp3wgdzEy6/AMff43uQFexWw2q4tft3NYtOrXMvV3+cSCNfxr2E3a5BR1VR+3vbUI/vIfKP8M/AHKxlr6kof8lcZGW7SxvuwHdeDojQQwl2uQJMS4C0oVXc8CSLiumyXuMST8JWvYHHJcW6pL+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/iop1sG8i3A7spUx4fMvHSrEeDDKEULLWYTzKF5Ybk=;
 b=Y+VF6auOhxAZFkmztFqlYXrsc8E8c030n4jWuWtnpOaSiROs+vPMgZHlwYzsmZBQampuvQmFwkgfHxXbVA1LaMvH5NzysW9/So6mtgpcA0LtljE+fEvkCN5EcJVBVZOtKwHeLXdAVuhVy20W32+aOu29UZSZTVnry7DqWB1ol94=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Thu, 13 Aug 2020 21:35:35 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7%9]) with mapi id 15.20.3283.016; Thu, 13 Aug 2020
 21:35:35 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/17] drm/amd/display: fix pow() crashing when given base 0
Date: Thu, 13 Aug 2020 17:33:54 -0400
Message-Id: <20200813213356.1606886-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813213356.1606886-1-Rodrigo.Siqueira@amd.com>
References: <20200813213356.1606886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::18) To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::2db6) by
 YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Thu, 13 Aug 2020 21:35:34 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2607:fea8:56e0:6d60::2db6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a7ebcac0-0201-4fe1-6d2a-08d83fd0d02b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13555D0AE90E327A60A0DC6898430@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:612;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hBA7rdo7xQ2TkpVKGoBWrXDhz4lfHF1gs4Z6iaOYz65cig7NCHEtpNt7JjQyAkmGqCMI1dcpbOCxciGdjdiczM4KsVDD7ehdm8H7s1FjDAJqDX8xt7j4HmBLHXcudLWU0B3LSzpZ673roSvCSctKiJcDFvMUO6cWMbwJio1xSrD5fBmN7F2nk7W4c7cUjzVtX7zn4wxuDfoP5ilnEW/FpUOPrzEX3WDP5Jop2obEWwrQzyVNwZj9dxOVJEB49GyWQa0UflTPV1/XoWk8KlBo+cbhjoUPMy/2MCtOjsXl1oxfjP3Pz6dboizDaBVbj+XvqvBeQm4YWKdWgDDARElcGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(2616005)(6512007)(6486002)(4326008)(316002)(478600001)(1076003)(6916009)(66476007)(66556008)(36756003)(52116002)(66946007)(2906002)(6506007)(8676002)(6666004)(54906003)(16526019)(8936002)(5660300002)(186003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: KdKcm6hDbgva4CmPIQ4CvR4TlKKlheNZ9zoKj0TJTztEgtKZtRFRmBNqZEZpXgSNsCJ0iJcmzg7a9h6Vxgu9FYFmY1YCTcilpshj+S1cKy7NoBZFKdq/GAtNSiQZ3NpdmbXzO1Dfzipl09u2eVeofezYhjePMuk2P/R5A+4oRLK1WRwakTWux2yDvhfq6/5W7WlMBIkuhNphd1U7lf2qybcxiEJSnXz6leMIdeRdmLoJLauX+0cooaEfMdqxgTSvGcJy7+albFDD2einKVYT7aIbIx6Xry84XDtBQfrULAgdX3UcySODZEWjiQguXAfE3hwMhPAxWPEbMeD5o8Ik8xizgBMtqLlh9nQdzv+ZsvPp3Lpyw2TYwpL7ZKleVONyoxQKd+nWtHKSd1waZCPBTy8bAs4gvzWgMViVrUKJZXsINJtyQjYN+vAV4JMyB/9y14/dgqFsHPHPmUYKAIy+K4sjphxZ5FMwYqyEdOFYqWIObRm15eb2CW/DyUQTIIOCC4xJyC+8FjMhdYHsNWDOZfDADYJBf0rmNiZvCwU60hioZlku0fNbJX5AVBPWX4qOwH7tfuuWb+Mqv0G1I/B5APku+Tv+lrDp9O30M87Sypz0Q0bmfbNlOrO5o2oyO+bYPnYdeww9ngISs/PxgMl1jJEx4AwcDGENCyhyCzD4pm8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ebcac0-0201-4fe1-6d2a-08d83fd0d02b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 21:35:35.3439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0eQkM+nz88N4rbGt1CBWa5cSLwYtYKLwW2WXKPdP9+BGUrHnn1bP89bekT+2GE5a8jGhlBYU6+bZWSRM5KofqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
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
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, stable@vger.kernel.org, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Krunoslav Kovac <Krunoslav.Kovac@amd.com>

[Why&How]
pow(a,x) is implemented as exp(x*log(a)). log(0) will crash.
So return 0^x = 0, unless x=0, convention seems to be 0^0 = 1.

Cc: stable@vger.kernel.org
Signed-off-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/include/fixed31_32.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/include/fixed31_32.h b/drivers/gpu/drm/amd/display/include/fixed31_32.h
index 89ef9f6860e5..16df2a485dd0 100644
--- a/drivers/gpu/drm/amd/display/include/fixed31_32.h
+++ b/drivers/gpu/drm/amd/display/include/fixed31_32.h
@@ -431,6 +431,9 @@ struct fixed31_32 dc_fixpt_log(struct fixed31_32 arg);
  */
 static inline struct fixed31_32 dc_fixpt_pow(struct fixed31_32 arg1, struct fixed31_32 arg2)
 {
+	if (arg1.value == 0)
+		return arg2.value == 0 ? dc_fixpt_one : dc_fixpt_zero;
+
 	return dc_fixpt_exp(
 		dc_fixpt_mul(
 			dc_fixpt_log(arg1),
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
