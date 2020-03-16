Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF05C18E5B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:49:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E39C2051A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DciNIGIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E39C2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AEF46E451;
	Mon, 16 Mar 2020 13:49:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BD7B6E44F
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 13:49:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1k9y3WnfJlJ/7oejqZyEbVqh8YEaU3mwmmg/TiVAwE8t3eawkNZ7bHeBH21mo2V5fTJGIGMAnz8xVR8JEoICfjo0s/wbhFbOEoS+bka+ZcOAd+8pNn+y4JiDcBmWIpLrieQ4f7/i5IQR8wq3zoTb/xVEJdmB0YVKvFeZrChoOLyTd5OT/kXY/Gf5x1775PKpGRSDazFLg5SvMvr6tfE46c2S9Nqhq6ju6Yjviq5WZ4L4s840hfveVG+Qx2j0Oo+OMS3j1crN+lA6Ddl+hKs6uputBno3Rv8pvy1BMXrAn6QKrsft+UbzR7i009ERsW9hPIlUxKRDbHwVF5n8JEu+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFLNqg05ZRdF07375UA4z7gxj6zPoazCE4NN/pV+F/w=;
 b=jKoaNXvSY4FVgQCvCwoTq52IcXF+yMw7cxC1oXaKLVYK1gzzF8xvSB2ADEp0XLeF/FMYsRuMcy88akZMVYM+o+9E2PbOCzmcigKHZfPlYshrFgKZwStYE8yvdpsX2np+zVJ/MEu0Qmw/f7a9PPVMi7Zab6RDglfF7t7BF2cqbnoqq/tItmZ/0hEGq3cK1LQlhbjQccQ366yt/W+GKCfg3IV7x+hxLc/cQ34FST3S+WldPakE+c5ZJ5GFtZ0JzDVdqsDnsjEKujFrn8KPOyaARXRo2RPeUL+lCp6l+/zC3EK34tdmJ5Wkb/rES/v5VS+KeokkhylBwSWGPJBQw19XZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFLNqg05ZRdF07375UA4z7gxj6zPoazCE4NN/pV+F/w=;
 b=DciNIGIhAMJ/LuDXjFWGlfDJcmNgfBOcjrfgLBgmKl4P4CU9eOgBV4pZs5Y1hCcF8koWNrXBh47dyVmVGR4WEKayfqseUBae2p2GkYmwMPp2mC66+Urzg36QnzraLWdNaUE/9xvJJEmXCaO1+ysJVsWXXOAF27ubpM92lL7cRTs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2363.namprd12.prod.outlook.com (2603:10b6:907:f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Mon, 16 Mar
 2020 13:49:54 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 13:49:54 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/19] drm/amd/display: Fix test pattern color space
 inconsistency for Linux
Date: Mon, 16 Mar 2020 09:49:03 -0400
Message-Id: <20200316134920.2526155-3-Rodrigo.Siqueira@amd.com>
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
 15.20.2814.14 via Frontend Transport; Mon, 16 Mar 2020 13:49:53 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fad0857b-edc3-4083-e793-08d7c9b0e7d2
X-MS-TrafficTypeDiagnostic: MW2PR12MB2363:|MW2PR12MB2363:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2363486C792FFFE1873F358A98F90@MW2PR12MB2363.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
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
X-Microsoft-Antispam-Message-Info: eW5z3Lmh//PJ447yBNbou8jbu6JLvE6mXMt1O70aEbfvkgVIzTY6G3d9YjLHdbcz27RDhMbaBuPMTskDvwc4TUs/yAsEvCVNAlI9m7nNnjRycNBZkQ0L5yAtfWJ+29nq0IbwIWVe4J9b8T5Xu5K2aVeBgJrrpb5f8VMoUQx+ZzLvm6Cz/kSi0moMz27eekrWHMdztRzD/bD10bPsFlfPGB56GiWHACSBNaDo3r5Q5wyScH6SDmfOMxmriOQYjNUTE2Yz0L1asnQieTANA3w6tQQyPeAhLz+8FGv76pDiW7iMVzgEeG92AU1x7K3wOFVT0eiUXDJ6cRPNzF83Uf237lQ7OMDmJGJ2TZ0YlJ+l0tKQZYc+FlvgFiyuoL5WB3QqybBrrJ0FiMhP+oLQgivVk9pxvyUdO0jL9cpYja8zA2Smue8C3feTzVaoYzv/frnn
X-MS-Exchange-AntiSpam-MessageData: kH0UzLZt4b9ebA71BQmYPryY96F2LXH4gXS3tcXHR1ZUkopZvxK10nnWVXC+YYaJfuQACyISShy+jGrgPVc9TUBGf6h4qVhWzmZOUtPuwS+94IVRW3WsfZra17YjrF1qNbN42KcsLZMZVcTuMKGO1w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad0857b-edc3-4083-e793-08d7c9b0e7d2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 13:49:54.1577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7WezYvD/2VmEd8wxdOzbZDvnrl4ElrZmZ43HnikIFlzwGDoEFuqFKc+eAyVZBqBuCXwBoD6zvvtc50s/VYel8A==
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 "Jerry \(Fangzhi\) Zuo" <Jerry.Zuo@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>

[why]
When reprogram MSA with updated color space, the test color space shows
inconsistency. Linux has separate routine to set up test pattern color
space, but it fails to configure RGB.

[How]
Add RGB to test pattern.

Fixes: 282243fab ("dc: update MSA and VSC SDP on video test pattern request")
Signed-off-by: Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index f822049cc590..7cbb1efb4f68 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2674,9 +2674,12 @@ static void dp_test_send_link_test_pattern(struct dc_link *link)
 	break;
 	}
 
-	test_pattern_color_space = dpcd_test_params.bits.YCBCR_COEFS ?
-			DP_TEST_PATTERN_COLOR_SPACE_YCBCR709 :
-			DP_TEST_PATTERN_COLOR_SPACE_YCBCR601;
+	if (dpcd_test_params.bits.CLR_FORMAT == 0)
+		test_pattern_color_space = DP_TEST_PATTERN_COLOR_SPACE_RGB;
+	else
+		test_pattern_color_space = dpcd_test_params.bits.YCBCR_COEFS ?
+				DP_TEST_PATTERN_COLOR_SPACE_YCBCR709 :
+				DP_TEST_PATTERN_COLOR_SPACE_YCBCR601;
 
 	dc_link_dp_set_test_pattern(
 			link,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
