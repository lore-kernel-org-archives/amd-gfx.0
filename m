Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212C1C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBBE2208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="InEakUW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBE2208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFC7D6E98A;
	Fri, 19 Jun 2020 20:13:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C0CA6E98A
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:12:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lfiw+2JAybtcYs1zKPlsQXrRDPRSVNnoYrcORO2BULkKso1ps8zCSjLppmtFyQ5YEgtdVRn2r4chnb4QcC0y2r2ngHjf9e4k2uh+nDQSgjMR0nRSzDdlNkFxGkkmR9gcSqfNg2BnP5gHZSgbiwqFGXrnrdMTPO9Iq6kQX3+rmuKfV8sRrLH8e8kygBxceD7CTUPyxXyXvFuYk03pV5bjBmTKACLZM2EFbZLlMyl5E7EV5+SS3WXGCT6wtTsu4SvDn5n6srP7tT/AAJQyxCm7NTSY7/pSJhh2StfwVnCfbtZ4I63TJdzh9/lGiTbCWAxoJUr24fpexMr5LhiU1jgYig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1WujV1H5ocZ8wmpJzVxxFXuMlIi9pExoKoQAaVnPLw=;
 b=n7Ftb/90cF9lhUhfyyWLxNypaLlpvMps721JwNFKGMmLcwLMG3JDhVlvUbo7UKRpUVJvvzayXD9zi8f9/ynLSUe1FLiO/kY4It/N0nvLsfN7wQ1xgDsr9Thp7SR3W/6JMNpk1t7ToSHgvUiQKGBMr1y213GZnuZaxkoaP5vq6jrPA7NuUnZ99sTpFB6c9EbTM3SRuXgVjruvb8qHpxUzNfG2k5tMQRlXIiCwH6wSyQuJlAaOEjIniUfqtfmn4xWsSBcv5XJD48nMYmqXPLj5Nnq6tV6yvxoZnfU/f5s+abZ0bjRKSCItfmjx1lkp/Yuiamxk+Bq8qxxYq2lVX+FIig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1WujV1H5ocZ8wmpJzVxxFXuMlIi9pExoKoQAaVnPLw=;
 b=InEakUW5maQqHQRCAlnrP9qzWMVO4C94Aw/cg8HxhbrzYMapB3l0FQSQxqyzCGKXj/zxAMNrU+HyIT727AU7sz/Z/B0aUQiB+xHrlWNvTU6UCJ/+P0qytUw767tTllLsDCMqlimJCE/T8YEPfzybINmFgN4BheyTXWVZYURmejE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:12:57 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:12:57 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/30] drm/amd/display: fine tune logic of edid max TMDS clock
 check
Date: Fri, 19 Jun 2020 16:12:06 -0400
Message-Id: <20200619201222.2916504-15-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
References: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:12:56 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6128a210-755f-470c-baf3-08d8148d2840
X-MS-TrafficTypeDiagnostic: CH2PR12MB4087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4087C76422A9853D7F4FA9A398980@CH2PR12MB4087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IUP98gVQ1qs/HiHS9fTAa25h5A0QhM3Tkhd4W3+HFG8IoZV0iJZLavw/CLH91owzXp44HbZQCje7vD/jEpY/d/sFCQFK1/Avev+zMQuxyXQxP7EuRsP41+zATJ7TUghTTBxyHC64lRO2L9ahHlpb/DRL3Y2Ow+y3FHN7xXJGeZHY+NNbpB8dTUYYPrFdv3j6sQg0xAAqpvi2ULtPpqoWurD1Tw/SQDpqeKHJtbF4Dsp+y1ywZQj4uvU/wt/V5ueOaxwsi5T9nbr7dyn4AoWA2CxETijWSCyzDUt1IybsxpW8mJIgIWMD6Ce4AeJTmuK4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(4326008)(36756003)(6486002)(83380400001)(86362001)(5660300002)(8676002)(2906002)(6666004)(2616005)(6916009)(8936002)(1076003)(6506007)(66946007)(52116002)(478600001)(186003)(316002)(6512007)(54906003)(66556008)(16526019)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: TC5H/i+OgD+yLyRZslSCf8NmY3TxaKzkNe/FLKLMjNFKuLZUbj0GPQNOUHUjsiWg3+RMygCm/k4YksS9KDE86n3ed7CYoXHtFJO6T1+n3SiKaN+0Gagh3rL/+V47bqIatR45Sdid16MapPmoq74YIBNMY/bzwgW/CtJwk2IeoJpqo+UiCrFNL44/1L5D4GwADRU0eQggQ+TrnuuFZ4obxAHF1pNyq4pInUUyMP8szoaAqtvFxau9vz9znotdn0n0wvsGnpNd6ht4/xZ0urJobjzFc7frdPz7A+EHHikbZxq/qef/dkee+UrutUZANmojKnr+mVUmXKToVl1962YO0pWzQOFo59myMpZc9Mae0Vx6RIADoWDQs51kgRR+oMJCzZnRpmN3cmW1HOecSxFpPYYhuTM9ph+kS+hS5vauNudBzbDTwrlZPJvdX2vdS33CYILlTyd/bwX+fkPcbPOmlj285s5SMnfzTsLyL892L1nXuXNM/jSnl8dqvBO22erHIYqjST1951ZFezNEHgGmTg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6128a210-755f-470c-baf3-08d8148d2840
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:12:57.2628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0c6HbPwPbztiLcl9Rabbw8ftJArpXBmaaAEFj3yAdBd+7jQcnFtPxPq+dqM+0dWN9SCmvsLMM5MEf+SO0L8DdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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
Cc: Chris Park <Chris.Park@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Dale Zhao <dale.zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dale Zhao <dale.zhao@amd.com>

[WHY]
Check max_tmds_clk_mhz firstly will restrict pixel clock under HDMI
1.4, thus HDMI2.0 port can't correctly support 4K 60Hz.

[HOW]
Fine tune the logic to check max_forum_tmds_clk_mhz firstly.

Signed-off-by: Dale Zhao <dale.zhao@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h                 | 5 ++---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c | 3 ---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index f51e5766d8f5..d64241433548 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -255,15 +255,14 @@ struct dc_edid_caps {
 	uint8_t qs_bit;
 	uint8_t qy_bit;
 
+	uint32_t max_tmds_clk_mhz;
+
 	/*HDMI 2.0 caps*/
 	bool lte_340mcsc_scramble;
 
 	bool edid_hdmi;
 	bool hdr_supported;
 
-	uint32_t max_tmds_clk_mhz;
-	uint32_t max_forum_tmds_clk_mhz;
-
 	struct dc_panel_patch panel_patch;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
index a9af3f6fd8ec..81db0179f7ea 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
@@ -629,9 +629,6 @@ static bool dcn10_link_encoder_validate_hdmi_output(
 	if (edid_caps->max_tmds_clk_mhz != 0 &&
 			adjusted_pix_clk_100hz > edid_caps->max_tmds_clk_mhz * 10000)
 		return false;
-	if (edid_caps->max_forum_tmds_clk_mhz != 0 &&
-			adjusted_pix_clk_100hz > edid_caps->max_forum_tmds_clk_mhz * 10000)
-		return false;
 
 	if (max_deep_color < crtc_timing->display_color_depth)
 		return false;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
