Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B554FC2D0CC
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 836262173E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ySlYkfX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836262173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 383B06EB8F;
	Wed, 11 Dec 2019 15:33:46 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760087.outbound.protection.outlook.com [40.107.76.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 670BF6EB8A
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IznBFE7ab7hs/enc2QTLMHgmqiPpIcrOe+zGH5B2xHWFCQLqtMfpnWvbahlBM+WGY+94AUGsNHIcmN2W+vF64VHnXdz059boCuaObgOkeUqM611euJSzuNRPzli+XVIAecKpzz95VwW6D3YlNvJXa8mmczZx71mEcuyjwXroHAUDYG26iGLK3BeRg3u95o5h+B6jN779aj0xyIYnCCP9DzxbF6O26/9wvWeRCiuyYCLqY58D8UVvAUvA8yj/TbofLlodgSQjyAAxR9sScN8E7XBqhEB9GekEdAkLCvikIqC+0LVvgzXzSG0SA2fuJbWY3hIApha9JCTh09pHHFbsgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4PNUSOj/o4jU7FJvY5TGJw2dRu6zH4MqNZQ4V6dKbI=;
 b=PGki1UZsnraovHnDPOzQQLw0yICVRlomp82W4ggkIuxSa/qOf9K1xdLW4Ku5kj5oPp2oqjnQHgDm9Y+EviS6G5igkXw+PQ1acrwhDZO1sLBoI4Zc/hdjq5CEB8y6/kzx5ojmK+hxttvs3uY0XWChnpQ2YGHCoDL+gNn1k8/8VzLXA52FNtpQYM784NaDvYUuevDhf0/e/FMiLMi5YMTkTzAOy3G5yY+rg3oMLy8FhX6CrJyLvShmimkyVuigq7KBuw+e1tp3R0T/O1Yl+QPMqcNGArexHlyMveg2MWF0N+DA8uFHJPD7mkdkvfru6QqEI0Ji7dvGIVPYBo+o2nolSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4PNUSOj/o4jU7FJvY5TGJw2dRu6zH4MqNZQ4V6dKbI=;
 b=ySlYkfX3aZEVrg+oNHoE3VbasPXjs4DtNsQsb4KY+S1lSf/p/kNSKur+ciZOuDnJ0Ayey7poprfpO/rbnrVuAnLvT9ASUgVbGFCezuFL5QEbYEqsziDY5WWpZusWzMu5krajDeIEfHL449+10zWrShgN28rAqhfwpAER2O6JDKs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2491.namprd12.prod.outlook.com (52.132.183.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:35 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:35 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 21/39] drm/amd/display: Map ODM memory correctly when doing
 ODM combine
Date: Wed, 11 Dec 2019 10:32:35 -0500
Message-Id: <20191211153253.2291112-22-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5f161109-87fe-489e-b10c-08d77e4f7c73
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:|MW2PR12MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2491D4C4B5CD373D957EE843985A0@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(6512007)(6916009)(8936002)(5660300002)(2906002)(86362001)(52116002)(2616005)(478600001)(66476007)(316002)(186003)(8676002)(81156014)(81166006)(54906003)(36756003)(4326008)(1076003)(26005)(66946007)(66556008)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2491;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mOHv+2sN2dGk/SvoF5oEpvyudnOnDwzJoJBc5XEgc/UhLRghPuKudhloYcGPEO1l5c1WQEN1vIXyuNXB92E8Os6b1Qc6ALkco40M6TbmgZBvlxp2hm0nD/APwC2ZDlePRGvQVAczJGlBnjW7aNwaN8F2hZ2SacLGhWIDxy7P8oDkYydGN0QkbkPbdOXRMIsrzSH40AHG0K+jgMtQsGn5MsWi9OcIQCq/pGKdh1Cj8CacxPNGQoJkbf5/LKpMuENg1IAOkriamg74w1TID/lS2CPlNUFcfQ4R+D/ZFwxJD7qI9gNLmbJn8jPOZ7HFtqZkBMDBL7PGfs8AaYFNsi2KdYdXvVtqgYOZwdDSGU8ACQgFpQb6qHQNCUziwXQ2rZZXoDoOGIsKK3ETJntRQBkZyZ75qOJNiil4AiF+1IyMUH7ASlq2rMJZlFr+t9yjU6u/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f161109-87fe-489e-b10c-08d77e4f7c73
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:35.3376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pd0SnknC9OPLvZJ7NlyLcMEv2f7LcH+8BaeARkWcHprcxjXhVNgLUTk5xJ/jUhXjrw767anFHmRMK5Xkg031jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Harry.Wentland@amd.com, Nikola Cornij <nikola.cornij@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nikola Cornij <nikola.cornij@amd.com>

[why]
Up to 4 ODM memory pieces are required per ODM combine and cannot
overlap, i.e. each ODM "session" has to use its own memory pieces.
The ODM-memory mapping is currently broken for generic case.

The maximum number of memory pieces is ASIC-dependent, but it's always
big enough to satisfy maximum number of ODM combines. Memory pieces
are mapped as a bit-map, i.e. one memory piece corresponds to one bit.
The OPTC doing ODM needs to select memory pieces by setting the
corresponding bits, making sure there's no overlap with other OPTC
instances that might be doing ODM.

The current mapping works only for OPTC instance indexes smaller than
3. For instance indexes 3 and up it practically maps no ODM memory,
causing black, gray or white screen in display configs that include
ODM on OPTC instance 3 or up.

[how]
Statically map two unique ODM memory pieces for each OPTC instance
and piece them together when programming ODM combine mode.

Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c    | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
index 673c83e2afd4..9b36fec549d7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
@@ -236,12 +236,13 @@ void optc2_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_c
 		struct dc_crtc_timing *timing)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
-	/* 2 pieces of memory required for up to 5120 displays, 4 for up to 8192 */
 	int mpcc_hactive = (timing->h_addressable + timing->h_border_left + timing->h_border_right)
 			/ opp_cnt;
-	int memory_mask = mpcc_hactive <= 2560 ? 0x3 : 0xf;
+	uint32_t memory_mask;
 	uint32_t data_fmt = 0;
 
+	ASSERT(opp_cnt == 2);
+
 	/* TODO: In pseudocode but does not affect maximus, delete comment if we dont need on asic
 	 * REG_SET(OTG_GLOBAL_CONTROL2, 0, GLOBAL_UPDATE_LOCK_EN, 1);
 	 * Program OTG register MASTER_UPDATE_LOCK_DB_X/Y to the position before DP frame start
@@ -249,9 +250,17 @@ void optc2_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_c
 	 *		MASTER_UPDATE_LOCK_DB_X, 160,
 	 *		MASTER_UPDATE_LOCK_DB_Y, 240);
 	 */
+
+	/* 2 pieces of memory required for up to 5120 displays, 4 for up to 8192,
+	 * however, for ODM combine we can simplify by always using 4.
+	 * To make sure there's no overlap, each instance "reserves" 2 memories and
+	 * they are uniquely combined here.
+	 */
+	memory_mask = 0x3 << (opp_id[0] * 2) | 0x3 << (opp_id[1] * 2);
+
 	if (REG(OPTC_MEMORY_CONFIG))
 		REG_SET(OPTC_MEMORY_CONFIG, 0,
-			OPTC_MEM_SEL, memory_mask << (optc->inst * 4));
+			OPTC_MEM_SEL, memory_mask);
 
 	if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR422)
 		data_fmt = 1;
@@ -260,7 +269,6 @@ void optc2_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_c
 
 	REG_UPDATE(OPTC_DATA_FORMAT_CONTROL, OPTC_DATA_FORMAT, data_fmt);
 
-	ASSERT(opp_cnt == 2);
 	REG_SET_3(OPTC_DATA_SOURCE_SELECT, 0,
 			OPTC_NUM_OF_INPUT_SEGMENT, 1,
 			OPTC_SEG0_SRC_SEL, opp_id[0],
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
