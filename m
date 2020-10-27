Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F36C55178
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:52:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E80A218AC
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="b5IKTkvr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E80A218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C95596EC50;
	Tue, 27 Oct 2020 20:52:53 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700048.outbound.protection.outlook.com [40.107.70.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D81E6EC50
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 20:52:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqbNgZ7YGI/KLYcW4xBXfAHyZOKGn0AYOpCfQF4YtbZu9lieHaRmjFlyeMOv0UKolULcBhopAy1jdF1j0vmyGpYB886bUuO0rEypHMZjlgGleYEHTRLnWktKCiymJcKcS1lWvQigmFfh3Vp8/ChQrW7DlAAhdvMIaw2qf7Ng6rWr6+UoMn7bWL86+fBctmlYBiKNceV8yEBQzQX2FcV/nsGVJViVNJuog4YyV77OCcsXZpdVoeArYCXnJYl5W7Jbb86MCicj2wWaXzaWPYIUPvugiXhhHqj5GQCjJ0shqgPInGgCnqoijVn7N7yQq3H/lP5qQ1b/V5DwWtLjCnqsYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIJuwPw/kwLmq6ekU6KTykUcwroI3f15BurMXIh9BWs=;
 b=ogVI6A9zpof182gf5QE0jRREwqc+GWqMSCx47bMzfER9UsZBgkKRINLu1GrRMQC0RBVC2aZxT+NgRyCJv6/E3jtfrgo2KWGb1XSfARuWe3Pg1ZZ8m3+yERADiOMRzKevXxg3ngMWd4U8FussRgA3D6/e5I6bG0Vvb9/UzUndxqfBv7gi4Tbr+pDSQ/VNblozLatT8jIa5udF79xi27edwau+iHN55XSURJo9V29cseL9yyM+0bHaoBBcgX1yo0tneZxifrh8Gv1PYWCZUV633TU8253QIi3dsZUy3wo+jVzzO0MgptsylcMz5iEd3ntg++rC542RcLqoaKWrToyVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIJuwPw/kwLmq6ekU6KTykUcwroI3f15BurMXIh9BWs=;
 b=b5IKTkvr8CJZQjmLwfKh1N6nMLW4icWl6JF09Wer+vPbb8f5u1I0eE2CrBFqAQ1NngMTBr4R2hZw983c5I096PzTCGIiYYl001g/4LwqoghYYHAp94D0yrlbQsb/Lu/iMZUjAw0FPpYo//nWdNrt00UByqGMD7ya4/AQuUX9QLE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 20:52:48 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 20:52:48 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/25] drm/amd/display: Fix compilation error
Date: Tue, 27 Oct 2020 16:52:10 -0400
Message-Id: <20201027205234.8239-2-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027205234.8239-1-qingqing.zhuo@amd.com>
References: <20201027205234.8239-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To DM5PR12MB1884.namprd12.prod.outlook.com
 (2603:10b6:3:10d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 20:52:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 33afcdd3-39aa-4079-b942-08d87aba419c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB359512BFA526380E028C3E83FB160@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pj/AZIY1wiWpk7UaYZdvLMj5RiTot3uqaJpuyA/Jf64vlcPv/EsqG9rDkha1PMPMuqhNF/R8TWP6cQStvPmOeDaWxlKYDP9Mc9wdVQGAa3ZZ9fakBKJUTHqC5rU0ZlojoQG7UzBFCOgI4nZKv7CoRMVT1tO+R0sYPmxuRGPEm71ksHnC0OomN6ybLMtpe6jShCPJNMNwUqZzD/Xj2IRlwHca3Q7jah5VA6D1JpEFYOx27J4mNWVaWHZxKdfSJRbLFqJyYgdQs7Kk+vzW9OBK2DXjobVIN6rD3BSI5vYBjO+9tAiuoCm2UvwZcP+Vub7kKnxmcUvpvCC/5VObnmGdULemgqaNMViSRWUzukhgQQcnaogyJwaixIxVkm7wuyTs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(6506007)(2906002)(26005)(66556008)(16526019)(186003)(6666004)(2616005)(6916009)(52116002)(956004)(66946007)(316002)(1076003)(69590400008)(54906003)(44832011)(8676002)(478600001)(66476007)(5660300002)(4326008)(86362001)(36756003)(6512007)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /AXHe6zwNdlEWUeI0F/b/IK6+V143IqlZwTFp4fv7vZjMsQmNHNpirkxvF+UsHwGYwj/UkrNMZxyA5FC6gTTBQMDJFp57T0aFtXsaOQCpJw5ShB8ZUe2iDSLxlR2Jv0UvSwGhFqY0e+w0JWGbwCXs0jWz4vNiISCndvrxXp1sC9EoLonqbkPOdg8p6yTACd8kag/lf0TVNLOLnJ6beiBv1gufXXwC28ZDaWR/uPLiBBsyiC0kp73GQvsDIj1/BbZO+u2dTmymlKTD/VbHwUcLCmkQLACaCm/aogvZEGxUxXYRSc1YZMV68iPhU7rqFZsfWEZzrVFz3e5dQUMtrlABJVoOrnxuxT8e+4RH3KaG2V+fdztHhhMXE6uvUyP8WgWxiKd+jiKdXjZjncgVzuIFxi2Ln2GXXM0zPBeEAhpNrLYBr7vwnFMzav8AMcGJEraH5+JiiC/iVuA0gr6vr78Dtyt4FuH1zCepq3i0MrCSfK9EewFLHQ0O3FwGZXrp9/53xVg++aa6PYL2o7wWje0IRmGez42BtNhO3WfTtze+25eLPli8V6vg/TMYWy7YGWOn/m9SNneg18IAVyHCm1VfjXiudt6tKsfnh63PzWMRkkaYPpAFWRMaVw/oP+CDTYpT/1Iu4rZ6J+YoGFDWnzG0A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33afcdd3-39aa-4079-b942-08d87aba419c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 20:52:45.9639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CWGbpR5mXGBKt+IOopH6SkEpjeRu7iQJtFJ/awlyTDmQ1AGOXZ9nEUUrIq5i+pr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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
Cc: Florin Iucha <florin.iucha@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 "Tao.Huang" <Tao.Huang@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tao.Huang" <Tao.Huang@amd.com>

[Why]
The C standard does not specify whether an enum is signed or unsigned.
In the function prototype, one of the argument is defined as an enum
but its declaration was unit32_t. Fix this by changing the function
argument to enum in the declaration.

Signed-off-by: Tao.Huang <Tao.Huang@amd.com>
Signed-off-by: Florin Iucha <florin.iucha@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h | 2 +-
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c     | 6 +++---
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h     | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h
index 7f6bedbc1ff1..81bf2ecc2831 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h
@@ -585,7 +585,7 @@ void dpp3_cm_set_gamut_remap(
 		const struct dpp_grph_csc_adjustment *adjust);
 
 void dpp3_set_pre_degam(struct dpp *dpp_base,
-		uint32_t degamma_lut_selection);
+		enum dc_transfer_func_predefined tr);
 
 void dpp3_set_cursor_attributes(
 		struct dpp *dpp_base,
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
index 4da21966ddce..c6a1cd80aeae 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
@@ -51,7 +51,7 @@ static void get_qp_set(qp_set qps, enum colour_mode cm, enum bits_per_comp bpc,
 	const struct qp_entry *table = 0L;
 
 	// alias enum
-	enum { min = MM_MIN, max = MM_MAX };
+	enum { min = DAL_MM_MIN, max = DAL_MM_MAX };
 	switch (sel) {
 		TABLE_CASE(444,  8, max);
 		TABLE_CASE(444,  8, min);
@@ -233,8 +233,8 @@ static void _do_calc_rc_params(struct rc_params *rc, enum colour_mode cm,
 	rc->flatness_max_qp     = ((bpc == BPC_8) ? (12) : ((bpc == BPC_10) ? (16) : (20))) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
 	rc->flatness_det_thresh = 2 << (bpc - 8);
 
-	get_qp_set(rc->qp_min, cm, bpc, MM_MIN, bpp);
-	get_qp_set(rc->qp_max, cm, bpc, MM_MAX, bpp);
+	get_qp_set(rc->qp_min, cm, bpc, DAL_MM_MIN, bpp);
+	get_qp_set(rc->qp_max, cm, bpc, DAL_MM_MAX, bpp);
 	if (cm == CM_444 && minor_version == 1) {
 		for (i = 0; i < QP_SET_SIZE; ++i) {
 			rc->qp_min[i] = rc->qp_min[i] > 0 ? rc->qp_min[i] - 1 : 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h
index 21723fa6561e..8123827840c5 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h
+++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h
@@ -66,8 +66,8 @@ enum bits_per_comp {
 };
 
 enum max_min {
-	MM_MIN = 0,
-	MM_MAX = 1
+	DAL_MM_MIN = 0,
+	DAL_MM_MAX = 1
 };
 
 struct qp_entry {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
