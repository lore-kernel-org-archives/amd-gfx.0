Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A410C2BB55
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 19:23:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C964206E9
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 19:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mse3TBsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C964206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C45796E0D2;
	Thu, 16 Apr 2020 19:23:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 984B26E0D2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 19:23:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qv1qIjLAoHZUzsuKlltrGLjAH3AVs87uSZbW8jO01BcfYWgWNLk7n24xtdhU5oj5ystr6ixQOH258NwHTrwLZC0Nc4i2NQNmxZxyShWpiUVUQvpJkXO6BayuTXY7TcwWXmBabEz/4U01FD2kNFhqI2PZdrsXF6mjtn2/EZkbN1eD+uQT2719s1YEwq0XaYeR5K9PpY+hRuP3vsT8EEQ2rTkoywfHyUJT/gCxnmTKQI2QNMHcztWaxZTXwdUeEhyExkvKtW71VzA1InXkhOEu5PJepUeYbRD2f4S7fPLq2QDzWCgOlyplYxOb1WfOgfFqEtwHKb/3Y/gflxXbcBiNGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/oOdcNUn4Jh9Wm7ChL3Ih5DGNIMaWTpSVpZkCns9p8=;
 b=h0gNV97kYe2fN+S0W9164fYJkR/7bv/XYRyVz56X6eTqC2LhnooUyhruIZRSKXoA02thCpiguci1AbnAjkwD6N08qOe1CjczXWpnLIsyw9rdzKzl5lW+mKH1Ul89ixPY3uwM5OJRLgHvMHjphjNjmhTribi/bKoDBAkcXQA5mfSbjcj7Spis+aUzEZ0hhFGSFb0wahgVe159iwW43Qa84OQuarxv8Dl6LkGTaDYP1RxaJRhE2lAt4L1SE31blZ0UNR16vGKobwHFgwrNYEJeu7f8j59mZr+aDB1bqF6PeK3RVukCTaaxfp3MJhOc1E+qQ/erMptAikY0mi1v/KKPkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/oOdcNUn4Jh9Wm7ChL3Ih5DGNIMaWTpSVpZkCns9p8=;
 b=mse3TBsOza0AIb5W2DWebQ+KjIqw19jIK2sBcUTy2Mt4AldJGoXfVWFIrEVo11Q7lzdYd0Tm8WEQyYlHpLt+ZTFFyC0zwxGB9kznGZDqJiZkMIEPnqPrh+czG/0qBdO+PjLc6VQB2Mk0OcexDwI7XH5H/O9yArMRyDSrQPh4bEo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
Received: from DM6PR12MB2971.namprd12.prod.outlook.com (2603:10b6:5:118::28)
 by DM6PR12MB3803.namprd12.prod.outlook.com (2603:10b6:5:1ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Thu, 16 Apr
 2020 19:23:44 +0000
Received: from DM6PR12MB2971.namprd12.prod.outlook.com
 ([fe80::20a0:763f:f871:29d7]) by DM6PR12MB2971.namprd12.prod.outlook.com
 ([fe80::20a0:763f:f871:29d7%7]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 19:23:44 +0000
From: Zhan Liu <zhan.liu@amd.com>
To: amd-gfx@lists.freedesktop.org,
	zhan.liu@amd.com
Subject: [PATCH] drm/amd/display: Remove aconnector condition check for dpcd
 read
Date: Thu, 16 Apr 2020 15:23:30 -0400
Message-Id: <20200416192330.22317-1-zhan.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::44) To DM6PR12MB2971.namprd12.prod.outlook.com
 (2603:10b6:5:118::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from a.amd.com (165.204.54.211) by
 YTOPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Thu, 16 Apr 2020 19:23:44 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5706573f-ebc1-4b2f-7b0d-08d7e23badde
X-MS-TrafficTypeDiagnostic: DM6PR12MB3803:|DM6PR12MB3803:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB38034E2BD40A14A109FA5BBD9ED80@DM6PR12MB3803.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2971.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(956004)(44832011)(2616005)(86362001)(2906002)(6486002)(5660300002)(1076003)(81156014)(16526019)(36756003)(26005)(66946007)(186003)(66556008)(66476007)(7696005)(52116002)(316002)(8936002)(478600001)(8676002)(6666004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pu8e8yrC5pge8eZA0lWLR2nV0fu2+GrfoPU7YUrln+/S7X0mUq3wm4two3JxcJYOrrsd5AojrBb2ck9Edgeh3RIghvuzLHtjQlfXcuCuIg7b1tVqR5J3kMh+JaXJuWZBWQGOhws2aMj2qtD5Rz0gnah01F6sbppxDSioeKaQeJWzzLoWbwCw/p9JNReRBJM11WxTRtEnEaoZLzg8itnOhiQQFHeYngAmHe2gCU+rvHLP+UMhZ4+yj7sKV0mjdK+zPcXiajaaAsHkQsFaYL/lnjZEYzkymlKAH4NKqnUV+JhwM7v54kmxQ/cH2inpYoSaJzyo/BfJful/Tkd/7wcUbHsw+CAntpzFRyTNvd/Gdzev86MgApoVTf1s2D7ZvYRH8oVSqLsgKFdBCqSw2EaiK0V1BHzhiGbsxbk+4EUZCxj6smXrUZ/AFmNI+omDzzNZ
X-MS-Exchange-AntiSpam-MessageData: Yq9Yuo7D0ZBw9RLZsrVjFM965ZaBw0XkStuyAzXootqDLylZJyMKhNAo9dw1GWEgl6tX5jWsrgkdbalJI49KviFQFEaCVjnaBhQEHtqP0ouvwja2c5n173gPfNrcgi8/vwq+e+9yvD76k3myMb5LqQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5706573f-ebc1-4b2f-7b0d-08d7e23badde
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 19:23:44.5690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gip64cRQGe2/GsWF74G5HVafEJP8VwpboG6eykz9oBTabB4cE/avBx4So80UUGkI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3803
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Aconnector is not necessary to be NULL in order to read dpcd
successfully.

Actually if we rely on checking aconnector here, we won't be able
to turn off all displays before doing display detection. That will
cause some MST hubs not able to light up.

[How]
Remove aconnector check when turning off all displays at
hardware initialization stage.

Signed-off-by: Zhan Liu <zhan.liu@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 36 ++++++++-----------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 9f41efddc9bc..6f33f3f0d023 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1332,31 +1332,23 @@ void dcn10_init_hw(struct dc *dc)
 			if (dc->links[i]->connector_signal != SIGNAL_TYPE_DISPLAY_PORT)
 				continue;
 
-			/*
-			 * core_link_read_dpcd() will invoke dm_helpers_dp_read_dpcd(),
-			 * which needs to read dpcd info with the help of aconnector.
-			 * If aconnector (dc->links[i]->prev) is NULL, then dpcd status
-			 * cannot be read.
-			 */
-			if (dc->links[i]->priv) {
-				/* if any of the displays are lit up turn them off */
-				status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
-								&dpcd_power_state, sizeof(dpcd_power_state));
-				if (status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0) {
-					/* blank dp stream before power off receiver*/
-					if (dc->links[i]->link_enc->funcs->get_dig_frontend) {
-						unsigned int fe = dc->links[i]->link_enc->funcs->get_dig_frontend(dc->links[i]->link_enc);
-
-						for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
-							if (fe == dc->res_pool->stream_enc[j]->id) {
-								dc->res_pool->stream_enc[j]->funcs->dp_blank(
-											dc->res_pool->stream_enc[j]);
-								break;
-							}
+			/* if any of the displays are lit up turn them off */
+			status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
+							&dpcd_power_state, sizeof(dpcd_power_state));
+			if (status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0) {
+				/* blank dp stream before power off receiver*/
+				if (dc->links[i]->link_enc->funcs->get_dig_frontend) {
+					unsigned int fe = dc->links[i]->link_enc->funcs->get_dig_frontend(dc->links[i]->link_enc);
+
+					for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
+						if (fe == dc->res_pool->stream_enc[j]->id) {
+							dc->res_pool->stream_enc[j]->funcs->dp_blank(
+										dc->res_pool->stream_enc[j]);
+							break;
 						}
 					}
-					dp_receiver_power_ctrl(dc->links[i], false);
 				}
+				dp_receiver_power_ctrl(dc->links[i], false);
 			}
 		}
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
