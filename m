Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79A9C3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DE9B21D56
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="e67JQ1/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE9B21D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 504896E5D2;
	Mon,  2 Mar 2020 16:48:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::603])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF3B36E5D2
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 16:48:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wun8jE/CyD9i8IH0iIa2QmOZ0VDZXo8F9sMqgauG9htc4kKQuF8cCJj7cGbb7/n15GupFCzutYXz+mXfGPLR2nd7eV+ic3v0ObYNHFtn6sMVNmlW5l0J0bE1d2pa/e10wzuvAXwSR8F16nGpoIkILSMsD0mrpChC7eFWni6XCtDzIq8Pps4Pjde4tOste40s7FZppd62zUdXSBPzr1Kx87Ysj9P9aKxobW/cLZs+N9CdYpzhC3asF4IUHFWkwgJYiUikXqG0aNMRvUGzTyC6fV5LnsUqRyVb0AI1ZiM8XOVljY+pe/s08Xs5UD8L40TlElAODjcEGxF7nQutTiLDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=114jpX7eSZjpIlELp/bsFWO9QzxjADSV1dc74YPJqCw=;
 b=cRMizVKPc2kucta3bOfuKnA2au/QUtbHqIinHX0aoy9MB2I2h5kj3MrtyHCfbunjU7jrvBVJy6Ng+IU9eBGicr5nzRMWJEMrmrzNPd1HuPEgRObdKw64TPpz/6xLFx5tFFaM83FjwMbcSP2Wk8dhy1PfGVtzYbcC/o4Vqm4vSAX6yjDkOwPxGKHlrnJriETDPGfRQZLTapDzBXkPBSoEZcQqKUAGZxqGX0H40qAOp9l3pAdTp4heUnJraHKvvSHGIW5PVYxgTk4Ae3OMHUXhBNLn8G/u43HfTaVz3Uu4OvX8J+K5HOUO5ckeuk9cytYrADenaZW1FTfbkEl7c+tzfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=114jpX7eSZjpIlELp/bsFWO9QzxjADSV1dc74YPJqCw=;
 b=e67JQ1/ket3UVWjY7viESx74a15lYIEbp0E6GVRpwI+TX2lov5Z+IslQrihGXBR2cwXR9FHGrBbmfK/AXt2Z6rxPrQaDQM0dwfaB1h5HGFOEe6cg243Y07qLdIjDwqfjblriQBklyFxdX9hYJ2RE6959uPA+wc+7yY3VWsFYUu4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2540.namprd12.prod.outlook.com (2603:10b6:907:7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 16:48:03 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:48:03 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/22] drm/amd/display: fix dcc swath size calculations on dcn1
Date: Mon,  2 Mar 2020 11:47:28 -0500
Message-Id: <20200302164736.89429-15-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
References: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::34) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 16:48:02 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e7a92188-d4e8-4e53-f44c-08d7bec97980
X-MS-TrafficTypeDiagnostic: MW2PR12MB2540:|MW2PR12MB2540:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2540ADE06C611D89E11CFBE798E70@MW2PR12MB2540.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(189003)(199004)(54906003)(316002)(7696005)(52116002)(8936002)(6486002)(86362001)(6666004)(36756003)(81166006)(81156014)(8676002)(1076003)(5660300002)(16526019)(2616005)(4326008)(2906002)(186003)(956004)(478600001)(6916009)(66556008)(66946007)(66476007)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2540;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D8COOCw5DW6hDw63819x3bmT/8Q4bTaTicCL4Ol5CprFcB2fLLKGt5/K/2366LyznlpYU9IYOgoVv/Kp4pRTTkwBFed03iCCt7FxLSdqBmRviOuct4vBvxwocRCFpogmCcBKgdNf9tcO6beaFN32Ra2zv9ipQ64DB5r6SlHyaRn5mXBjdX87LTFBAjkshnCcAVYAYP3YY7a5if6oqQ+YcXq85SWXvAb+cFN8vJ11iWTfOuJUR/nLqvH4Rw2F21Y3m1H/BXhT09bh8lIFtfzxpfWLLYP/EEZWlaReZLAh69sOtBBE2nWpWhKolX78fv0UkVI+faiERtShjOzE+PAIqrCSjHxxkMpa7JaU+5foP+8HZwrpyALrXduOshpbup/kjit1sCq9bow3w5LWQbg4Cg6Y79xhk+48HlfZLTvpKpFiAHq8zOvcX30y72QfmfYS
X-MS-Exchange-AntiSpam-MessageData: 3l1XzEonXfWg8rvvTl+MtIYVFSv/UhFCjcCYqM2GgdOg1Z668KCGG+GUididBln0LZ7Afd3CTcUKTydlhv9yPi9kckUtaTMAA6nW02qf4zoYJcqR6JSZAKHi8cHdzsGGej7SoR+cYGg8FTem+W7HQw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a92188-d4e8-4e53-f44c-08d7bec97980
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 16:48:03.4921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ypf6u45MLECgZmlSMrizD3vRhYAQ+DCDsoOnDXGQRfihltvh6o6/qu2Cth6A/E+C9YvY04Edgfv4PyvD1GcnPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2540
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Josip Pavic <Josip.Pavic@amd.com>, Rodrigo.Siqueira@amd.com,
 Harry.Wentland@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <Josip.Pavic@amd.com>

[Why]
Swath sizes are being calculated incorrectly. The horizontal swath size
should be the product of block height, viewport width, and bytes per
element, but the calculation uses viewport height instead of width. The
vertical swath size is similarly incorrectly calculated. The effect of
this is that we report the wrong DCC caps.

[How]
Use viewport width in the horizontal swath size calculation and viewport
height in the vertical swath size calculation.

Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
index e441c149ff40..deccab0228d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
@@ -830,8 +830,8 @@ static void hubbub1_det_request_size(
 
 	hubbub1_get_blk256_size(&blk256_width, &blk256_height, bpe);
 
-	swath_bytes_horz_wc = height * blk256_height * bpe;
-	swath_bytes_vert_wc = width * blk256_width * bpe;
+	swath_bytes_horz_wc = width * blk256_height * bpe;
+	swath_bytes_vert_wc = height * blk256_width * bpe;
 
 	*req128_horz_wc = (2 * swath_bytes_horz_wc <= detile_buf_size) ?
 			false : /* full 256B request */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
