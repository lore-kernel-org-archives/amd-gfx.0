Return-Path: <SRS0=9SYE=DH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDD0C2D0A8
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 04:08:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0F202087D
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 04:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FB2dM6Kn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F202087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64B4A6E0C8;
	Wed, 30 Sep 2020 04:08:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08A186E0C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2020 04:08:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUrtDdfRLwZXUeFKJzuNW5QOBjGVzH9aVmvV0EvQ4YlLcDK2hOcKwBzXgomGSEmtZ1Fesvjb5WneTCFAhzgma5NjJj7HrgEnjlIOZT/OeRUjSvOR5FlZqrstqd3d3rDCZFsIobBsw4Qm+GMFMDcmk7pLcj369Opbhl0+5v3QxQM5gfPqGblP1G8sedpLGC9EgjvACDSXB0pyXbBzsJMFKoPIFquLmRRGTmDpMnNlEqCgphva8tcs9DNAibqtRsC+m79C36p3KbHzvgCvBPWHUaIWoWQG/AieIZEU+cjnAzcxJ+5Qtbbg4M1HMMDG3q6zmy7HGrXpsyNDLNob36w1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9bD5WEb5GcDbIqkLjDbSxsLtnWWmdrNa29yCnFpYm8=;
 b=WRrDgaMSQUZREKHNnFYPi9XGuLpDtFa2/3EptCwpq63UhWi48uAWlUkyzm/vwSOwKQHB0pIl7oxS+WzdX1TwO/kdI2a42pNRAgqRoD9Dys4Q5PHSCfM/tB1MrAWu0mpG3jq+I/m4v5NnVq6KBlV6uocObQbjYZKKgg8Rcmft2boDCQnZLOzDkx/mYvfJQreZMT1GRH2k0B64buA0ObP4oplUDzUysbYcPTOJkBUzTg2O4U3ANb+9b0qW/dAqqme5qFl449pVrHHraw8BhpbC5DqANYvQXNVJH85D3JqzqReRg1MWu50lRwKSNvXxg3KgQeVza+KGBg7/uE5eYQwEMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9bD5WEb5GcDbIqkLjDbSxsLtnWWmdrNa29yCnFpYm8=;
 b=FB2dM6Kn8rp89D1H8kiOw6IUNGWxWo+bDhY4hqg6K/poAy2lKXp9ZslY7G0MbOJ2u/03j8F15iAoW3Lis4DjeSE57GkQzoHW9lnjFXC2NmARWHaOZHYlhuAXdqq8ocb9EzBBaJ4n9hfbDzrFNb5l2emtQ4mP2wq+36fdtaz+9mc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3178.namprd12.prod.outlook.com (2603:10b6:5:18d::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20; Wed, 30 Sep 2020 04:08:20 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 04:08:20 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: setup APU dpm clock table in SMU HW initialization
Date: Wed, 30 Sep 2020 12:07:56 +0800
Message-Id: <20200930040756.23559-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR02CA0149.apcprd02.prod.outlook.com
 (2603:1096:202:16::33) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0149.apcprd02.prod.outlook.com (2603:1096:202:16::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.21 via Frontend Transport; Wed, 30 Sep 2020 04:08:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ded59fda-2d27-4249-036c-08d864f67780
X-MS-TrafficTypeDiagnostic: DM6PR12MB3178:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3178879E0C65D82B6EFED1C3E4330@DM6PR12MB3178.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WAMPEcTWUl3XazDZvy6qQRHbZCqm7+RL8/yT8FilQ4T4t0nrnPE/LGRDwTyZrRwLDVisLaM6yt8C8HnS2kRO5fFKaTHnjp6qm7D436eZDHhNZ54UPNJsWyKv97fPAuCqKKU8XuRxqfPue5vg6xpqloPFk9HSuTfuQmadJ7w8pcjUCaX5ilI4Dn+PRHr2UQcyvD5+dVAPUxVH8tkqPQgNgJBHVBUagBEo9rlkODx9nmiOEMaSRca4YTzyNkqFugvl0iqIbgyhncKKnjEG2Rl0CgjN4xwkl4pD0/J7UFKnokIhLBg+v5TpNX2rPpU1G67imt9peTFItuwgro+q/pCcLD3Csl1OlDQ2pyLp99gfmS5q176D+93goJxI5roA0+Ic
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39850400004)(376002)(346002)(136003)(16526019)(186003)(52116002)(8676002)(86362001)(36756003)(44832011)(7696005)(4326008)(1076003)(8936002)(316002)(83380400001)(956004)(6666004)(6916009)(5660300002)(2616005)(478600001)(66476007)(66946007)(2906002)(26005)(66556008)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 3F6mYVxP4mkRmv/qs3gp2gRybQPQ1gXEV2QrXGLYEBqTqDFcUGfKkXvdolSSYXpT4QPe0o/4Q92WTIbvdHaqmx3sNUzZq0NGxwx52JA2MfkmhssCL8+zTQw2EH/mcselzgrt7RtZ0cqT4KSM7VGI9OPqE5H1mgpEzjBYtMMuZ3PojW+iR+qaWDDDrsbWBImRc5vj/YHwd2zbs6oLnh7DvF7FoaoQ72CQgs4NDQcSoXO/bx9NaG7MlLR/T5gSMl4uWuksu9jy/zc/arNxxbZnxmth+MwLuJbXJRtgN67JacODWJE0QDhFciNBwfjh8pxZY4su/RviIfa07iFaafMerbrTIaPmOt+f38cLP3jH8Q62gUbsTdm910XltNF9oOo00txd8BJLh1cngSir7mZplL7g9tqaIXyYiBj3Vcv07PbBRzkcjYV3FsyqRCVB8MrfoNWLA1iJsSfPHGucOlOdY9/atTnctz0HaF/sx5RXnU2Uts04jCZG5RLMuZ//8lH7Mn5ysPzyEZ9w4Gx+3MituycCo3Iexh68LbPeX+7xSipDZ8V8/iSAQzikC7veQ7JoRLCNFFQcyuWV3sP4+vHBe4HDQOEUXXeoZaGFhr+ANuhwvS/TnF5bVfV6sbcB4atYHGYK7XGGDsHEHJYeppmI2w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded59fda-2d27-4249-036c-08d864f67780
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2020 04:08:20.5084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+ef4Xz7UVitT1ju/Haw/VsbtJ6F6S8+aBfiz6zPZ7QYwG49EwR/wMuKTzW+1/lh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3178
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
Cc: Alexander.Deucher@amd.com, dirk@gouders.net, Ray.Huang@amd.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As the dpm clock table is needed during DC HW initialization.
And that (DC HW initialization) comes before smu_late_init()
where current APU dpm clock table setup is performed. So, NULL
pointer dereference will be triggered. By moving APU dpm clock
table setup to smu_hw_init(), this can be avoided.

Change-Id: I2bb1f9ba26f9c8820c08241da62f7be64ab75840
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reported-by: Dirk Gouders <dirk@gouders.net>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f46cf9ea355e..8f6045def272 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -482,17 +482,6 @@ static int smu_late_init(void *handle)
 		return ret;
 	}
 
-	/*
-	 * Set initialized values (get from vbios) to dpm tables context such as
-	 * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
-	 * type of clks.
-	 */
-	ret = smu_set_default_dpm_table(smu);
-	if (ret) {
-		dev_err(adev->dev, "Failed to setup default dpm clock tables!\n");
-		return ret;
-	}
-
 	ret = smu_populate_umd_state_clk(smu);
 	if (ret) {
 		dev_err(adev->dev, "Failed to populate UMD state clocks!\n");
@@ -1021,6 +1010,17 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		return ret;
 	}
 
+	/*
+	 * Set initialized values (get from vbios) to dpm tables context such as
+	 * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
+	 * type of clks.
+	 */
+	ret = smu_set_default_dpm_table(smu);
+	if (ret) {
+		dev_err(adev->dev, "Failed to setup default dpm clock tables!\n");
+		return ret;
+	}
+
 	ret = smu_notify_display_change(smu);
 	if (ret)
 		return ret;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
