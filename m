Return-Path: <SRS0=khk6=AO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE192C433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CE3520826
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eGsYDHV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE3520826
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FCEA6E1D6;
	Fri,  3 Jul 2020 08:33:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 882F66E1F5
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2020 08:33:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrZ3uwZuooS1cfLnz3W3OQ5V1iR94SW/bFuBCXqHRaesYoYsmJXVq1ZHgIbJW+DIYnzYTthB9AhiELsbbxnz3yFlqPEPtrFJiRyaqglj96QpVGWqJoth4NCc3A+WgshxjAaRdswDrhXaF6AGXRLXMxvdYEyR8ckXeqkXxmG0mRrYAbETAK5po1KBZCd40VAHj6SrgrI34jPug63eYhakA7GbQYKGWWgFIgDWAMS/KE9jZoPTOLUdgGUgu/TZzsMAsg+cnRtWgvRefX0l/ZwvE6UU5kTV1thszYICFHJincYSwjSELnAEijEX7MHWxgF/H66cjWJ0B6QWRxrlkjv9SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CxaufBnvTBs/bZHk48ceZccloYtoaxeKlAUUFR5CSI=;
 b=PAWrnjZMQomiUmkFHnfCtNbhSeTtpI6G+SXRegrJ3wSicx1sUR8oRP41RxoiGUmB/cWSXJ/pndiu40VJtl65zhJdh7e8WLRjDSX1RBAi1ybgGIZUUO8E+4eQmQhHOytFVTAHKVPDgSbV2rWLITNgMlv89SuU/YWjDemMMTmU2vv6tnFmCwNBiufygQvQq9afPu9kscMO0wj6tCLQ/Xa3t5GogYnjWcIstocvWkdgl8PbMPmCcrI8RKPA02GRflCju2kluxpPgGUEM8VlEoTwaof06k/sAFRqWBmJsRATwd7ihn1IwQuRoRfb6RwhC7bPen7MxMJpefaiP+q0M5bWwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CxaufBnvTBs/bZHk48ceZccloYtoaxeKlAUUFR5CSI=;
 b=eGsYDHV3taUAWmlernj5sZF9KeWFKn2LWvBaOo1y3FZKnQs6j6ShgHHv321ZHkKPAKd0ASY7DjRLpSMKdql/V+g9Q4m9zM/u6pUlHDIjTnPtAZSMxCjUBGM7mPZjAfhjKrl7vQyoD85wmmOo2RgP1d0vJyCn/OL7eOcsoP7XZJg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.27; Fri, 3 Jul 2020 08:33:52 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 08:33:52 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/14] drm/amd/powerplay: update the common API for
 performance level setting
Date: Fri,  3 Jul 2020 16:32:56 +0800
Message-Id: <20200703083303.478-7-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200703083303.478-1-evan.quan@amd.com>
References: <20200703083303.478-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0139.apcprd02.prod.outlook.com
 (2603:1096:202:16::23) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0139.apcprd02.prod.outlook.com (2603:1096:202:16::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.22 via Frontend Transport; Fri, 3 Jul 2020 08:33:50 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 956de28a-c8e9-4c1f-fd2a-08d81f2bd0b1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB39627F096D6ABBC4EBA34CBEE46A0@DM6PR12MB3962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWoGsNTz5J8eldBAgETA39AHAaqBdtJSVquiQiae9Yqahl2GrAS+28JMgUOHahiHS2APuzGUCn5tRuY31LKYFyGb1uuAqSyvfevu4M6XexbYwDY+zVnamKmzb8wb/JcTLhG1/1HijbFmi+lc/UpsJnMCOpS0Sw+amWVmCfjHzahE42dlI9HJPDBYbLwE5YPGVrS4MmOkTdM9L5R0ypWQWaBqGGm80MEcYixyDBvCJiFRmrCSYe4d3VwCwIMYmiZYSqbuf8WIRoY+yMTKvX4GWtu7a0Hh7RfuA97fCfLHmQSouEDNuhD8SPL7KjlHbe/szp26CfHxeCcCxSKZk3TQAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(83380400001)(44832011)(4326008)(36756003)(8936002)(7696005)(956004)(2616005)(6486002)(52116002)(478600001)(66946007)(16526019)(26005)(186003)(66476007)(5660300002)(1076003)(66556008)(8676002)(316002)(86362001)(6916009)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: mb8Vsw6JpZmDyvX/gIvWfhR5irwSFXZ17VqIOK9YPFkMwcsLlRL5huw40exf9yg92j1LeTkudf4n0C1jktFlOwX1YVLDTsNFjiDFB43YCYkPWd5x05pj/sN3lBS3E/s0M2abdl5R6p5450LaxOaepUDjJhNyO1xTHzGCp+/kjjPigMUAAFq/9M+EhUeQ06BH5r99SNqRZVc9LyfP3yd/6ygNhh9eya1hnRtmbiqyqO8EDwBF113v+enGg/hfMsYypPlMLZDQdrgXTYmd3kSAAoiI5bFvnzGhM3cCh1rXMSoYF/m1+Ceo8iwG/sh2CjXOGPyp/dP5SQ79vtNCKx9tinVbkqRrA83FjvMsHEHcVXWat2I3N4UBM9lsg4/OgiYjJZan5tFB63iMnNGHqFia8Cyk780s27H4kMYuJjf1b5FfKnqj/MmvutDobM8k1h0t0ZtAvbO+SW3u1bk0qSUJidTf031gan3mJ1yJBM5ouw3SKaswPxTi69HvGix1yYnv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 956de28a-c8e9-4c1f-fd2a-08d81f2bd0b1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 08:33:52.4592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hPS+e1H7RZ1sLWSiRvknR6S3b+yrhpGClMs7rjFtw0a30iP/FUJJzqmtUDOD5J/V
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

So that it can be more widely shared around SMU v11 ASICs.

Change-Id: Ie110edf2ec519699448d3ff3215188ba243d2415
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 91 +++++++++++++++++++----
 1 file changed, 77 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 8f6e0291d560..c2564df304f7 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1855,38 +1855,101 @@ int smu_v11_0_override_pcie_parameters(struct smu_context *smu)
 int smu_v11_0_set_performance_level(struct smu_context *smu,
 				    enum amd_dpm_forced_level level)
 {
+	struct smu_11_0_dpm_context *dpm_context =
+				smu->smu_dpm.dpm_context;
+	struct smu_11_0_dpm_table *gfx_table =
+				&dpm_context->dpm_tables.gfx_table;
+	struct smu_11_0_dpm_table *mem_table =
+				&dpm_context->dpm_tables.uclk_table;
+	struct smu_11_0_dpm_table *soc_table =
+				&dpm_context->dpm_tables.soc_table;
+	struct smu_umd_pstate_table *pstate_table =
+				&smu->pstate_table;
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t sclk_min = 0, sclk_max = 0;
+	uint32_t mclk_min = 0, mclk_max = 0;
+	uint32_t socclk_min = 0, socclk_max = 0;
 	int ret = 0;
-	uint32_t sclk_mask, mclk_mask, soc_mask;
 
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
-		ret = smu_force_dpm_limit_value(smu, true);
+		sclk_min = sclk_max = gfx_table->max;
+		mclk_min = mclk_max = mem_table->max;
+		socclk_min = socclk_max = soc_table->max;
 		break;
 	case AMD_DPM_FORCED_LEVEL_LOW:
-		ret = smu_force_dpm_limit_value(smu, false);
+		sclk_min = sclk_max = gfx_table->min;
+		mclk_min = mclk_max = mem_table->min;
+		socclk_min = socclk_max = soc_table->min;
 		break;
 	case AMD_DPM_FORCED_LEVEL_AUTO:
+		sclk_min = gfx_table->min;
+		sclk_max = gfx_table->max;
+		mclk_min = mem_table->min;
+		mclk_max = mem_table->max;
+		socclk_min = soc_table->min;
+		socclk_max = soc_table->max;
+		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
-		ret = smu_unforce_dpm_levels(smu);
+		sclk_min = sclk_max = pstate_table->gfxclk_pstate.standard;
+		mclk_min = mclk_max = pstate_table->uclk_pstate.standard;
+		socclk_min = socclk_max = pstate_table->socclk_pstate.standard;
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
+		sclk_min = sclk_max = pstate_table->gfxclk_pstate.min;
+		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
+		mclk_min = mclk_max = pstate_table->uclk_pstate.min;
+		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
-		ret = smu_get_profiling_clk_mask(smu, level,
-						 &sclk_mask,
-						 &mclk_mask,
-						 &soc_mask);
-		if (ret)
-			return ret;
-		smu_force_clk_levels(smu, SMU_SCLK, 1 << sclk_mask, false);
-		smu_force_clk_levels(smu, SMU_MCLK, 1 << mclk_mask, false);
-		smu_force_clk_levels(smu, SMU_SOCCLK, 1 << soc_mask, false);
+		sclk_min = sclk_max = pstate_table->gfxclk_pstate.peak;
+		mclk_min = mclk_max = pstate_table->uclk_pstate.peak;
+		socclk_min = socclk_max = pstate_table->socclk_pstate.peak;
 		break;
 	case AMD_DPM_FORCED_LEVEL_MANUAL:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
+		return 0;
 	default:
-		break;
+		dev_err(adev->dev, "Invalid performance level %d\n", level);
+		return -EINVAL;
+	}
+
+	/*
+	 * Separate MCLK and SOCCLK soft min/max settings are not allowed
+	 * on Arcturus.
+	 */
+	if (adev->asic_type == CHIP_ARCTURUS) {
+		mclk_min = mclk_max = 0;
+		socclk_min = socclk_max = 0;
 	}
+
+	if (sclk_min && sclk_max) {
+		ret = smu_v11_0_set_soft_freq_limited_range(smu,
+							    SMU_GFXCLK,
+							    sclk_min,
+							    sclk_max);
+		if (ret)
+			return ret;
+	}
+
+	if (mclk_min && mclk_max) {
+		ret = smu_v11_0_set_soft_freq_limited_range(smu,
+							    SMU_MCLK,
+							    mclk_min,
+							    mclk_max);
+		if (ret)
+			return ret;
+	}
+
+	if (socclk_min && socclk_max) {
+		ret = smu_v11_0_set_soft_freq_limited_range(smu,
+							    SMU_SOCCLK,
+							    socclk_min,
+							    socclk_max);
+		if (ret)
+			return ret;
+	}
+
 	return ret;
 }
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
