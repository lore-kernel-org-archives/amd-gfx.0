Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E09C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3488821D81
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wCajlwhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3488821D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 135AE6E93F;
	Thu, 10 Sep 2020 13:47:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D19296E93E
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YddLNa+HYeYL2rjfFgOWqMDH+GCn9uF4K00/Ixb+xqpOMTgoL0EyA98v0YeMNBdGi2Thu8x1Zm0qI8VCNxECQV3Is6PB3xuguWeGSGS9zXuYPhpTBEaaaeB5YgB8o/WcSCtGEPku9WuqxrJFTFc8mQmCiYjJrv+v+Wxvn4DDyegZTsarblLPUUH1K7Qsyu5fQMyi/MISo7cc4Q9i0unb4vVwCWubLpC4NCNnuWDYeu/2rLboEfoM3GbgOI5b6573JSi17bnFFEz5QyiJbtiyh8CGAiHeretw63NDdBqKHE6vNQOuhj2LD5j2PqH7qmojk5W4d7xDgqGKc7Yz4yv4Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBPchVjbLjOrukdMElLHb791KDSfCeN9kMvaXKB2q/4=;
 b=Y+aREbSZsRonl0pmcBIPgKEiCbXqEN9K30lxKRQZCzWTjMeOgIfhWQvvgPJgdVgdpgUp6L7rnK+Bw90HKFSxUrzgCvIN3aXktba7wisYqPbpe5/fMVn/1V5Bq4f9U8pcoj6iy9AvN3kFBkQeUqMjrqYTm19ugTTmDU+H8R/KFoIAz9L7KhETsRctx/FJOlUTNPJb3e6dQYDD/KEIPauzexuyfBqAL9UboRVxzADvkFGrJp7GBwEBrJxDxMkIqWxTG9EwEmDCiJJBlZP0lydOIMTqqWLY3jWa/0cDz0pe5zuJw3AUrVk9q9BIeC8C98ispnSFloWz+D5rCCorWHZXKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBPchVjbLjOrukdMElLHb791KDSfCeN9kMvaXKB2q/4=;
 b=wCajlwhr3k0vBecWtRG4iPe7KXmQlh7Q/Em3y+6dVOOhiHg/pMNsXl/gwEm4WScR62pPzrbVNyNz89zSzL7+/jys8ZQ2rRFfMqsd82BlEAC/L9KkLENh7hUgez+LPWrTDNgjGEwv20QTjTQQ0r5cqPJ4uOi1ujcaPlCV1B0ezwQ=
Received: from BN6PR04CA0084.namprd04.prod.outlook.com (2603:10b6:404:8d::34)
 by MW3PR12MB4345.namprd12.prod.outlook.com (2603:10b6:303:59::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 13:47:32 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:8d:cafe::16) by BN6PR04CA0084.outlook.office365.com
 (2603:10b6:404:8d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:32 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:32 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:32 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:31 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/42] drm/amd/display: always use 100us for cr aux rd interval
Date: Thu, 10 Sep 2020 09:46:53 -0400
Message-ID: <20200910134723.27410-13-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72febab2-ab1a-411b-63d5-08d855901142
X-MS-TrafficTypeDiagnostic: MW3PR12MB4345:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4345F71ABE4EB03E04F9A3428B270@MW3PR12MB4345.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tj2vJEr1QetcDd+Cb7sIGerqIKC3nr3O//jDtjA7Uly6ChgM+WE0DQEAEQNwQOH79DOuZeJyW0vlFizKQ/w/55GfWahHTnA00OzxSOgxdSR1UprFDtqbKZ+MHWVjYHw8XXAS6tx3XFROW7HOxdbw8w6aEXde2YlPlkhNvo812xbpHnX5Rg15dnrgUplj1R+g8lVfhbkUZcuY+TIK9cySTgxwFjiC5OpmvhcNkUOHoDMyk98Edu2iil7xKlLthiOahb7Rkqmk5StXZirf5s7MBQuzzyIqXSLv2T7GuFqpiGjLwJjmJFBsm+qt4T06bvyRrNIx+qRO8+6lYoLzONQ66dkuOeCSExspbMTzycVdp1E3LPhj37hWr2SGxPA3L3VhCIrv0wSwuQXwxjOpCEwYcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(46966005)(44832011)(7696005)(6916009)(316002)(83380400001)(26005)(54906003)(336012)(478600001)(70206006)(186003)(356005)(70586007)(8676002)(36756003)(81166007)(4326008)(426003)(2906002)(5660300002)(1076003)(86362001)(82310400003)(82740400003)(6666004)(8936002)(2616005)(47076004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:32.5700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72febab2-ab1a-411b-63d5-08d855901142
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4345
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
It is a regression caused by below commit.
I1654c11ba3e229e17483959e0f66319d7de9e320
In this commit the cr training aux rd interval is
modified without following specs requirements.
According to the commit message the change was not intended to modify the value.
Therefore it looks like it is caused by a typo in the change.

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 2334ec428098..e4b3b71dad03 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -49,14 +49,14 @@ static struct dc_link_settings get_common_supported_link_settings(
 		struct dc_link_settings link_setting_a,
 		struct dc_link_settings link_setting_b);
 
-static uint32_t get_training_aux_rd_interval(
+static uint32_t get_eq_training_aux_rd_interval(
 	struct dc_link *link,
-	uint32_t default_wait_in_micro_secs)
+	const struct dc_link_settings *link_settings)
 {
 	union training_aux_rd_interval training_rd_interval;
+	uint32_t wait_in_micro_secs = 400;
 
 	memset(&training_rd_interval, 0, sizeof(training_rd_interval));
-
 	/* overwrite the delay if rev > 1.1*/
 	if (link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_12) {
 		/* DP 1.2 or later - retrieve delay through
@@ -68,10 +68,10 @@ static uint32_t get_training_aux_rd_interval(
 			sizeof(training_rd_interval));
 
 		if (training_rd_interval.bits.TRAINIG_AUX_RD_INTERVAL)
-			default_wait_in_micro_secs = training_rd_interval.bits.TRAINIG_AUX_RD_INTERVAL * 4000;
+			wait_in_micro_secs = training_rd_interval.bits.TRAINIG_AUX_RD_INTERVAL * 4000;
 	}
 
-	return default_wait_in_micro_secs;
+	return wait_in_micro_secs;
 }
 
 static void wait_for_training_aux_rd_interval(
@@ -1251,12 +1251,12 @@ static void initialize_training_settings(
 	if (overrides->cr_pattern_time != NULL)
 		lt_settings->cr_pattern_time = *overrides->cr_pattern_time;
 	else
-		lt_settings->cr_pattern_time = get_training_aux_rd_interval(link, 100);
+		lt_settings->cr_pattern_time = 100;
 
 	if (overrides->eq_pattern_time != NULL)
 		lt_settings->eq_pattern_time = *overrides->eq_pattern_time;
 	else
-		lt_settings->eq_pattern_time = get_training_aux_rd_interval(link, 400);
+		lt_settings->eq_pattern_time = get_eq_training_aux_rd_interval(link, link_setting);
 
 	if (overrides->pattern_for_cr != NULL)
 		lt_settings->pattern_for_cr = *overrides->pattern_for_cr;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
