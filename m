Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45571C43460
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 069216138E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 069216138E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B3BC6ECE3;
	Thu,  1 Apr 2021 16:46:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DB3D6ECE3
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 16:46:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjfkJMsJiuLycbo+2p1d4xel3VrvYx+snrXvkdPw/7Ugn3601MWA55Bl89ERgGHf6l5deb9Og8ue0PuJU09zqRh4W1VfHJzXqThjggkmtcKzGTwqPu3d4MoxGnXePxXWWx82Bs0nj/izRMPux9598Ld+xLFu8HZaRhj04lhb1aMtpIvE8xOxkoLHuuEaBmlTFRnEwpttuRri17BPgauUEPNDjkw/qsqK1svHQbzggR5dX+ny/hQRyZIk7s1gJfQmuSF38rFVKvyHQ3acRUXC/9H2TSnAmIcofHb+G1S0E/5+IwiPQ0A8Qz6CHqz8SbX6vLJpEtSt/qLXKu7ymTAO7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5rziwZ8z0keUrNUQGpySfMk0IZKFegR/L18WkbWbZo=;
 b=fZ5e/pSdn401z6yiba5p+z/taWmrNJvC7yoA6TCfiUUE87u71zF4261k6Idx3CIBF4JpLCTgMBCchRrjC+UL0Bw5SktFdpPPL6HdAl8L3uVhNQemzzNytEL7MnbpgF2KwD0wd5sLa9EvSlXvUnO5d2Uy1RD/HJBe+Sb5b+FPfpknClqS2wiiotazEeaWDsKEIpXtYKUHbtRsYEN6hvYf1plZDsPhAf7/awcd3KWgEUf7tcsbxPR2+zJ4ZUtYspLXl7ybTkscLJNvLnHOxrloVv5XTc6ssSchYi3fym3QnxnCeP6OfWp4/nsI/WAsL2lmGVkni/m4agzAHBqwsNlUSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5rziwZ8z0keUrNUQGpySfMk0IZKFegR/L18WkbWbZo=;
 b=jU+PeVatbMjs4n3sM2dWZtj//i9V3oUhW5lzzeRqZCK+4Z0UiYRvYyuA/xqSJNZN9SXfxiWwzFjApo38jraPLF1w5Ad+FGdU4iM3q5VfPPCeUpKUrnWuAW00dfmVhlZSmYc3scbTc0oSrHf0gQQidz9OSX1LmKsJf8x+sj2/OGY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4619.namprd12.prod.outlook.com (2603:10b6:5:7c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 1 Apr
 2021 16:46:00 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 16:46:00 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/21] drm/amd/display: Move vupdate keepout programming from
 DCN20 to DCN10
Date: Thu,  1 Apr 2021 12:45:12 -0400
Message-Id: <20210401164527.26603-7-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210401164527.26603-1-qingqing.zhuo@amd.com>
References: <20210401164527.26603-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::19) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.32 via Frontend Transport; Thu, 1 Apr 2021 16:45:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6782a804-a4e0-418e-1220-08d8f52da112
X-MS-TrafficTypeDiagnostic: DM6PR12MB4619:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4619968D48DA88A87B4CAD27FB7B9@DM6PR12MB4619.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pS7ayyJ2P3p8HFMhuDPlO0jtpY89x7NOiJhraAZ+Na9Tr8CqtVyzR39X59QBOc4ZieCtjgmUQyZ+jO/DsRNKPvc7RsQKwQNI7TWXMbW4oc2zeTWj5z6HlPoGWjV3orKLVBiAQdXoXNU3OYos4AGHlAUAxcl48DpdAk55MvcnfDQ5Tfjyb4YoJh+B9tJOhJTTQeQJEAm6SPwRqKoZIph/3uQbhsT2IwQZVkCANvzbTO1eJ/h0T9ZG410nMqmNaojpIn8eyZK/Nux5jYpUNtKF0JJX7s6ZxEFR6grgQSM17oi6M5n86FpJJd6Ph46O6u4CtRB9hGogQlUrU7kpZ88v5G00wVElpjF+QI316j42mVGfYui27zzjriq8foORYkjsCOqZCgFhacx4jCaLBV9mw0BXDULMkO67fYTNLbbbVGt8e/AAmKtFa0sGCLadoKB4+99NzShyIPS5eBKy+1JuQ8nTf84oNUYi/6aGQsEez91iO/BSLPl+Jhkh8nXHADxRL0Ywk9plQwwo8AzKL7b1nnERuWLNKjrDyQ6m/+IaxlBCZzowCn6hOnzHa9aDciU5QVgUYHRjZbfvteQefwoGZawnUlbyiK7ysiWKzTTfRq067RACIrR8QfhAw3Vsit1QjjoJ7Htlh1re27tsb5MpeF9xU3x4eASJ+Oxv2HbgzyVb0U2VIU3bxDWuWx2h5f0s
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(36756003)(69590400012)(66476007)(6666004)(478600001)(6506007)(38100700001)(16526019)(26005)(83380400001)(8936002)(8676002)(2616005)(2906002)(66556008)(6916009)(6512007)(4326008)(316002)(1076003)(44832011)(52116002)(956004)(186003)(86362001)(5660300002)(66946007)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?smyQTnlN9no4gbfr/Nh/AmetbuTBONE88oMUd/kMPkhg11mU6ulbHq/dIDRI?=
 =?us-ascii?Q?J5DoLxKTaC/aJZQYtlnhIRpYuHpETuk/2EioOck/5/ZsBCv+BLxBwHKlE6Sm?=
 =?us-ascii?Q?lK9WV93VZJlnP2FednM6bjn5UFKdcjUL9InayRLQU5Thns72CPGw+7nB1ogG?=
 =?us-ascii?Q?yO+rngiGFfcq+Bire9RvHMsUTL0reufRpdR/WsS1MhhJgRsvNYvGIsZBDmS7?=
 =?us-ascii?Q?Yl4xyku9vJxYJKV5IP8Y9zTth8qtKf9kSEzRB5mjIpNS7bqZ+dpjusGEVkxr?=
 =?us-ascii?Q?p+C13zd7QA/SBM+1i5WprhhaqGqxphmAOCC3AEVAr/2Lc9eziVjKlv1ZkibS?=
 =?us-ascii?Q?qahuGFQKCOpEG3DFdmAjq/7qH+moVsynBb2ghdu/8D3XE8uCPsyKPgtagapU?=
 =?us-ascii?Q?vzWaKDWGl7Tugn7hSV7mKXq7tfivXC08O3HvTiVphsLiURjHkCwJ/sOr91rU?=
 =?us-ascii?Q?JPHOxsgVzQi16dsK4fyDQEcHYsl6yXN9FvIW5JWIfw37QIMjyRSvYaaq+KeK?=
 =?us-ascii?Q?Qeu2dKWaSG4SZIrhHE2vb4D+9hNNPb3oB9/6fr8Q0AuJeIH2QfOazlDm5ugR?=
 =?us-ascii?Q?/3kVeGU6RJnmNfL8LFrcyVwO1smBLPncvtSxVOvDlFyAxmlRiYX8pEIzWIV2?=
 =?us-ascii?Q?FKUMKxXTCM3+Xq+mJR2oedCYIZjGp4xGASDtgEPUI3i3rwLBOfpG2cFCSZYy?=
 =?us-ascii?Q?OrKFOxnCiaUzGZfyYFw2kU63Il3RYTeyzfS8qPsjDHuC4kCFnthCM6yJSrpD?=
 =?us-ascii?Q?ajcsEfXfkDMeFMvUp8ij97fVIKE8Exth0RdNT1VhYg86CEaFGV0qxQqCzOV+?=
 =?us-ascii?Q?+1PX5mu2DEAnbE8pjrwunxfBZeAiIpUyn1D6zyHdZmcm6LZbdtMPuvhA4hpr?=
 =?us-ascii?Q?uHFW6BFQqqu6W68lCnx2SXt8EctboOFl4HnRD1hcdVxu2jWKCycpnX+/rLjf?=
 =?us-ascii?Q?ANnmBRPQ41WkLDJ+JHLplABVwu9fybQL5oguLiEEAqnVyYYZUTdXrgQ6IPkw?=
 =?us-ascii?Q?YBcXqW1cd35s3HpLrgtVFmKwFGJDZkCdM7QrCT4J7hAszt+6/8fO868n0HUP?=
 =?us-ascii?Q?b+PXg+a2AEWw7itkJIiXr+k6GPqgjbUa8Ms3KfOjeUp4OSiZDF4fwDZcKvZW?=
 =?us-ascii?Q?4dIRPkIkbMl8Gelj+uopRyZOZYfD1SFQ/1ryQy7KX+ArcH1vUgzslvtCUyKg?=
 =?us-ascii?Q?+PiBpLbTqKraGUfSChImVaqNA0YVzrYwKOSxtuO4tYwDnIXndt1McoexEams?=
 =?us-ascii?Q?WqDezLUcjrM9dR6fnvFD6Z6m1oO6n8anfIonq8LRq8wAoFNiKUm9JvPN/lEw?=
 =?us-ascii?Q?MguuzNQMCl66a2mBucFYfrBj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6782a804-a4e0-418e-1220-08d8f52da112
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 16:46:00.0682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsLdz/LvoD5kZ3/w4WaE4l4XFYgIz45GllHJvyC7DnXChu6jf3BvBKKpyXSjknND
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4619
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
Cc: Eryk.Brol@amd.com, Leo Li <sunpeng.li@amd.com>, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Li <sunpeng.li@amd.com>

[Why]

The OTG_VUPDATE_KEEPOUT register and fields is
available on DCN10, and named the same in DCN20.

[How]

Move register definition and programming function
to dcn10 optc.

There is no functional change.

Signed-off-by: Leo Li <sunpeng.li@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c    | 16 ++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h    |  3 +++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c    | 16 ----------------
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.h    |  3 ---
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index 6138f4887de7..677663cc7bff 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -131,6 +131,22 @@ void optc1_setup_vertical_interrupt2(
 			OTG_VERTICAL_INTERRUPT2_LINE_START, start_line);
 }
 
+/**
+ * Vupdate keepout can be set to a window to block the update lock for that pipe from changing.
+ * Start offset begins with vstartup and goes for x number of clocks,
+ * end offset starts from end of vupdate to x number of clocks.
+ */
+void optc1_set_vupdate_keepout(struct timing_generator *optc,
+			       struct vupdate_keepout_params *params)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+
+	REG_SET_3(OTG_VUPDATE_KEEPOUT, 0,
+		  MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_START_OFFSET, params->start_offset,
+		  MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET, params->end_offset,
+		  OTG_MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_EN, params->enable);
+}
+
 /**
  * program_timing_generator   used by mode timing set
  * Program CRTC Timing Registers - OTG_H_*, OTG_V_*, Pixel repetition.
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
index 2529723beeb1..cabfe83fd634 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
@@ -194,6 +194,9 @@ struct dcn_optc_registers {
 	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_UPDATE_PENDING, mask_sh),\
 	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_BLANK_DATA_DOUBLE_BUFFER_EN, mask_sh),\
 	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_RANGE_TIMING_DBUF_UPDATE_MODE, mask_sh),\
+	SF(OTG0_OTG_VUPDATE_KEEPOUT, OTG_MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_EN, mask_sh), \
+	SF(OTG0_OTG_VUPDATE_KEEPOUT, MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_START_OFFSET, mask_sh), \
+	SF(OTG0_OTG_VUPDATE_KEEPOUT, MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET, mask_sh), \
 	SF(OTG0_OTG_H_TOTAL, OTG_H_TOTAL, mask_sh),\
 	SF(OTG0_OTG_H_BLANK_START_END, OTG_H_BLANK_START, mask_sh),\
 	SF(OTG0_OTG_H_BLANK_START_END, OTG_H_BLANK_END, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
index ea7eaf7d755f..3139d90017ee 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
@@ -134,22 +134,6 @@ void optc2_set_gsl_window(struct timing_generator *optc,
 		OTG_GSL_WINDOW_END_Y, params->gsl_window_end_y);
 }
 
-/**
- * Vupdate keepout can be set to a window to block the update lock for that pipe from changing.
- * Start offset begins with vstartup and goes for x number of clocks,
- * end offset starts from end of vupdate to x number of clocks.
- */
-void optc2_set_vupdate_keepout(struct timing_generator *optc,
-		   const struct vupdate_keepout_params *params)
-{
-	struct optc *optc1 = DCN10TG_FROM_TG(optc);
-
-	REG_SET_3(OTG_VUPDATE_KEEPOUT, 0,
-		MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_START_OFFSET, params->start_offset,
-		MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET, params->end_offset,
-		OTG_MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_EN, params->enable);
-}
-
 void optc2_set_gsl_source_select(
 		struct timing_generator *optc,
 		int group_idx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h
index e0a0a8a8e2c6..3dee2ec2a1bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h
@@ -56,9 +56,6 @@
 	SF(OTG0_OTG_GSL_WINDOW_X, OTG_GSL_WINDOW_END_X, mask_sh), \
 	SF(OTG0_OTG_GSL_WINDOW_Y, OTG_GSL_WINDOW_START_Y, mask_sh),\
 	SF(OTG0_OTG_GSL_WINDOW_Y, OTG_GSL_WINDOW_END_Y, mask_sh),\
-	SF(OTG0_OTG_VUPDATE_KEEPOUT, OTG_MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_EN, mask_sh), \
-	SF(OTG0_OTG_VUPDATE_KEEPOUT, MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_START_OFFSET, mask_sh), \
-	SF(OTG0_OTG_VUPDATE_KEEPOUT, MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET, mask_sh), \
 	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_MASTER_MODE, mask_sh), \
 	SF(OTG0_OTG_GSL_CONTROL, OTG_MASTER_UPDATE_LOCK_GSL_EN, mask_sh), \
 	SF(OTG0_OTG_DSC_START_POSITION, OTG_DSC_START_POSITION_X, mask_sh), \
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
