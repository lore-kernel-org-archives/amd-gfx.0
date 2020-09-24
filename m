Return-Path: <SRS0=YZDW=DB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B19C2D0E2
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2020 10:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB8621D24
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2020 10:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1nDiwBcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB8621D24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DE9F6E19A;
	Thu, 24 Sep 2020 10:10:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A17F46E19A
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2020 10:10:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9mIemfuhLwydNZNw65vfZTMYvBvPBM15JL8t1bxYvUvnsGts8oI1O44VPn1r2nWtDdjtzuaNMfU1plRnQ6JoJKPkBkt8VX1OijrEH6eAINPZoKNTzQMOB9kqUVvRZ0SDm60gxixpUS4v6XSO1g5rLmKsT8Y31tHZGTWNqoBNJLOLEYvWn7jZo6Z6pxbmPZ7m7UBN3p+AXikfwQ8zDfmvlEzqalEkOQ1bGQYLPz/2DiPGN6vyNUQ0X3PdSp6aw8CN+Ze8bTEIdIYWvE7CiOMBW2koMUBPY5Wwa6WmfxZQM6/Ihs7KDJly6r3cso5dN7qeKJjYnKc05Apbzu0fnuQ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqApS2lebHo/PXoktn66HVQMxdPqSJMzVtxifYaRvpA=;
 b=Nsgb+yFAfq0/knapSFhVQ1IwTfRoy8WqgmQbo8LEfxJPohncEymKlu6wXHsX6M67uvWha0pXltzRbJZ+afVYc+JjfaMyIU2DNZXPR0vAYSYfy3ArWDJ57qy1grsuBAIOcGPhWJZnid7yjb411LJPHv0UDdOcloo5l4I1d25iAWwIVoODscsVDAMbfZ+mSr0z8QlR4Af1ekAjvhgY/35A13os3AEBPESYUZ3BTB0saY8Vtm4gIf7ffWQjNmWZe8j1VgR9e8UaNGxams/HLitsTmH3/jSpuWtJwtxHoeCzKsWkXoS3NrPBmGj/k0tXHxBg3kw4wdM5bb4pEsYHXvjGTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqApS2lebHo/PXoktn66HVQMxdPqSJMzVtxifYaRvpA=;
 b=1nDiwBcWDgjYtWEeGT0+6D6P+hw0vrXxAmaqyUlBl+p3RRYhWM2xz2gYFuS6Y7gtdpzb6HLiTWaVT/SbEL4pdRxLzTG3l4G6HKut83oZtT/Z3ch+EHYwwCkDe9LKUxN4mhVg8/Jrl1VddUy6yccKwguwQAVRB6QoV0T0PoG+c54=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.15; Thu, 24 Sep 2020 10:10:32 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3391.027; Thu, 24 Sep 2020
 10:10:32 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: fix screen flicker seen on Navi14 with 2*4K
 monitors
Date: Thu, 24 Sep 2020 18:10:12 +0800
Message-Id: <20200924101012.22845-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HK2P15301CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::29) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2P15301CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.2 via Frontend Transport; Thu, 24 Sep 2020 10:10:30 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f82cefdd-070c-40c1-05a8-08d860721225
X-MS-TrafficTypeDiagnostic: DM6PR12MB3962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB39629E546C3761E4B4B5FECAE4390@DM6PR12MB3962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W1s10mltKZ7uChiQ4Sd3Io7FTUfvK7Rnq6xlNmiQGjHKr2aU5hwZOT4vwT1VQtv0mx2OGWtnjLTk3Fq1TP9QGebzAGIgUpZRRznn2aa77/jHtxFuG4Iuw8LRoKn/URrRBROJ8dlqeiAbL7uUTXhVcsceD7r9XztfDgie13tshH9DIyZYd1fB13O1RjC2PZtwdqWqSeTezRp6ZGqH8fw1sU2hpTShiO0Ae5eU/P/3kosWqbZlaOlRZ2kbhhq2gqsMj6Lc5/c7vwpPz/16D7S3Pja1BhSmlO4vhdocymxjjx54k4kuO6Z+bpN67fJv/2ls2wDjplTk8filQlcL6X5T9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(6916009)(6666004)(44832011)(6486002)(8936002)(66476007)(1076003)(478600001)(2616005)(66946007)(52116002)(66556008)(7696005)(956004)(5660300002)(8676002)(186003)(316002)(26005)(36756003)(4326008)(83380400001)(86362001)(16526019)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: cG9rT2XVqxpP4f/uVE42Ri5z+yKJAaBiwIS0B6JnB5G8FjXDAxWVuQINLABehG/OBEIjk+EMRdT00SGMFeVicwPrMZ42wYnrXOCu963oU5Wr0/yyyIUm9LSfLjft40H3RJcCBypVP/5SV3I4xXPzWK8hxkT9MeVnePvlncLzMtpxMaN8Sgdxlo7ecLBg1D6+xUjinlulNgM/eSeN0GC3np4Q6imzYIpbiBRQsvSdTruJwVm+LpTaei8Sxfk31WiQeRNFgRHKdSYGY3FC0k6Atk31OlpDZuCeNPLk1rB85N7n5v4bqU4nPgPfOwL0kdHdhum6XoOG235VEF2+CrCRq2GsBvGahWGuX5+8ecjPXlfqs5JHBtckWzLtkO/QOc6MQD6ghoCmbIpqYpbam5opVVgdHoyXJKzu7u7A1wkaXkED46DJ9/QR4yPgpexes0GMw7pJ4NlrBq4/UNgOXlDqld1tp26+QkKxgi3qDGqNAot5agODJzG7kgeiH+DqdCssOvCvrIiqW6C/x9Sz55FGik8EozImbOFR21anK9a514MNirIvNFrVBWd42l46o7UJ+ji2J66qEZ7cbbPmfd5BS8zOn9Qh5pBEG5/oF0d5O12BZDDGdJ/sv31An1Ve+irxwC+PKFtx8UfokiCZE0MWOg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f82cefdd-070c-40c1-05a8-08d860721225
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 10:10:32.2138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LL1aXx/db2Y6VZXCBds8ye/kXf9BY75ph3QINUoYm51SOpKXx4oSWlPg487xlavc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3962
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Revert the guilty change introduced by the commit below:
drm/amd/pm: postpone SOCCLK/UCLK enablement after DAL initialization(V2)

Change-Id: I0cab619ffdf0f83b14ba5d2907e1b9c02a984e2f
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 43 ++++++-------------
 1 file changed, 12 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 1695b36dc23c..be44cb941e73 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -316,6 +316,18 @@ navi10_get_allowed_feature_mask(struct smu_context *smu,
 	if (smu->dc_controlled_by_gpio)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_ACDC_BIT);
 
+	if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
+
+	/* DPM UCLK enablement should be skipped for navi10 A0 secure board */
+	if (!(is_asic_secure(smu) &&
+	     (adev->asic_type == CHIP_NAVI10) &&
+	     (adev->rev_id == 0)) &&
+	    (adev->pm.pp_feature & PP_MCLK_DPM_MASK))
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
+				| FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_BIT)
+				| FEATURE_MASK(FEATURE_MEM_MVDD_SCALING_BIT);
+
 	/* DS SOCCLK enablement should be skipped for navi10 A0 secure board */
 	if (is_asic_secure(smu) &&
 	    (adev->asic_type == CHIP_NAVI10) &&
@@ -2629,43 +2641,12 @@ static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
 
 static int navi10_post_smu_init(struct smu_context *smu)
 {
-	struct smu_feature *feature = &smu->smu_feature;
 	struct amdgpu_device *adev = smu->adev;
-	uint64_t feature_mask = 0;
 	int ret = 0;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	/* For Naiv1x, enable these features only after DAL initialization */
-	if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
-		feature_mask |= FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
-
-	/* DPM UCLK enablement should be skipped for navi10 A0 secure board */
-	if (!(is_asic_secure(smu) &&
-	     (adev->asic_type == CHIP_NAVI10) &&
-	     (adev->rev_id == 0)) &&
-	    (adev->pm.pp_feature & PP_MCLK_DPM_MASK))
-		feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
-				| FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_BIT)
-				| FEATURE_MASK(FEATURE_MEM_MVDD_SCALING_BIT);
-
-	if (!feature_mask)
-		return 0;
-
-	bitmap_or(feature->allowed,
-		  feature->allowed,
-		  (unsigned long *)(&feature_mask),
-		  SMU_FEATURE_MAX);
-
-	ret = smu_cmn_feature_update_enable_state(smu,
-						  feature_mask,
-						  true);
-	if (ret) {
-		dev_err(adev->dev, "Failed to post uclk/socclk dpm enablement!\n");
-		return ret;
-	}
-
 	ret = navi10_run_umc_cdr_workaround(smu);
 	if (ret) {
 		dev_err(adev->dev, "Failed to apply umc cdr workaround!\n");
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
