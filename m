Return-Path: <SRS0=ixe6=GX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B5EC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 03:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8447522B42
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 03:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8447522B42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A02A56E11C;
	Wed, 20 Jan 2021 03:48:19 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700067.outbound.protection.outlook.com [40.107.70.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC9936E11C
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jan 2021 03:48:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E43y8Q4MuiDg+HE1SdXoOZ+jk4myiR2GENsr2VvTfq7jCeNXkrVEOF+r5mhBtQkUxzrLUsTM4jKMXO7yaCxv5+MjamVJIxJunZ/1LvVqBCJ7UGYoo9LjiXYaD1773vbQZYLhXspUissF+7rMofs2KxthDszRsAZq3AKUBD7hzgxgO2sM3Pw11lTJJGgCfn2xNTVaHr4pC7IHH5FSIjtjoQZka9vBXSKPHdNflpEMMdkpGecH8hjpxTWY4FH1EuL5EwlzcMH/O/4w807XJ6U18KQLHJkMecPkBLGKb3RGsJy4scwMBMiHVOYjWhPp25zSPPciRasWCBxuT8wUxcs51A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NP2mKUG8OZV+kisC5ZPdHqFZUQzNr/fbvQQUlALcRv4=;
 b=X+f9BtqEKxe6GtptzukU6gL5jfTXvzazScmF+A56g3s3AIRdyS47ZOGxMb+5pUwBX6dsqWcDA31N1bvD6GCRuPCVWJCBTHBLd8HVyQS/XFB982wRcmObK9W0a8+JIcAp/QnDOqfnX+INtpKcNo1RXZ+mR/yRgrF1qsM0anRy3cWMNSASZ99j9BIzhJTdmkw8AcpcfE53GkaRyjkG88Zl34JdLfT1Z4XKGmZ/i0qZ0DLwqcJgSidTmYqHLDkHX3hggFwvops0nzEjiqY0kmdw9TPvjw/6YvGFAnDPt2OCH522DS7kqa+6Zi3Xwh4xNrT5QqyV7U9q44SL5tNkGz/Ugg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NP2mKUG8OZV+kisC5ZPdHqFZUQzNr/fbvQQUlALcRv4=;
 b=kULfjesitXPRMlO1+dO84yjpQt72FFboBiYFIRPuf/M6/9fBqTys62JJyVJD+5MU17GKU4UNRaLYr4YxcjSiG/0K0lUM5W7K3kZ/TWp4MhiD3NgwqHGK0wVRw4D50fQINfYkthUEiaDWJhLSE4ZcpaOZ7oG7jtuXPpBLOzGWtVs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1124.namprd12.prod.outlook.com (2603:10b6:404:19::10)
 by BN6PR1201MB0146.namprd12.prod.outlook.com (2603:10b6:405:59::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Wed, 20 Jan
 2021 03:48:15 +0000
Received: from BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::d18a:2c9d:81bc:51bf]) by BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::d18a:2c9d:81bc:51bf%10]) with mapi id 15.20.3763.014; Wed, 20 Jan
 2021 03:48:15 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: make the error log more clear for fine grain
 tuning function
Date: Wed, 20 Jan 2021 11:48:21 +0800
Message-Id: <20210120034821.15400-1-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2P15301CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::14) To BN6PR12MB1124.namprd12.prod.outlook.com
 (2603:10b6:404:19::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-MyrtleD.amd.com (58.247.170.245) by
 HK2P15301CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.0 via Frontend Transport; Wed, 20 Jan 2021 03:48:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fb1c4a88-4bed-432a-d752-08d8bcf63772
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0146:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0146720D44DD849D80E83EC9F1A20@BN6PR1201MB0146.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FrrJKRtJLMM7SO8M/RoHUCWOB7tcmKLM7oEBv5+wHaP+rdCHzMWT+u5qEy3G6F+xmBn2gUiBo7WA+z94QYee/84c4fuJEJyAn2EmqlAph4kR9ld3HxL27kwHu9wIeNW6u6GmpFLPVpWVv5uh+sG7qK33/0ko0agRNvavMJjGU7HhRhFhngFRvjsC0AKRWyDFPGFo7ntm6dqVPFk2hCA+ANPadhUSvyCrJSQWIkkS+waN+WBYyD6ilIKTRlH8sc0nqErz2UI+hzc03kwIKcS1+9vJQgvBPVmfPGdTOE0KqYOfVwCsaoXlzRsffNwiY+Ruo2ebGmK/e2yyB/b7gFtmZgJyWPxM9vajCSvc2MuCleqEWy5OroI6oCS7F/qC6YEVtWYsIU7iXgFtXo+aIQlL7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(66946007)(66556008)(26005)(4326008)(36756003)(8676002)(6666004)(186003)(8936002)(16526019)(86362001)(1076003)(2906002)(52116002)(5660300002)(19627235002)(316002)(956004)(478600001)(6486002)(66476007)(83380400001)(2616005)(54906003)(6916009)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iS7287lXJ3Enqcid5dQ6gW9ci0y6FEIBof8JyQ1FDopiNyT2kX9frDnK1qPz?=
 =?us-ascii?Q?7qdJi2TX5LLD83hEXraEMyUqI+YCaxb/ENgz0ftWBcpxcijlD6ykNeI/BmIu?=
 =?us-ascii?Q?K94TIhMTjrR87RppQd0E5xNxljbzuS4RybQMwg1EAO+BIleGQndk1Losq+61?=
 =?us-ascii?Q?sIXJxowc72c2n/tPDWu6haXO8K6kboXvrZBJ+/sMiNHZ+AD+IOF0mDfZpmIu?=
 =?us-ascii?Q?fbd+Alp2T1NjtwZLMn7S3IpvNHC8LdbWNPXiZlhfcVmMSfyDbtAFWH1oA5az?=
 =?us-ascii?Q?nMQi7dMxUMYaFlqjmeW5iPJMAKCJquWRbkay+ZpMwPh/FURN66fXsZKLXlKJ?=
 =?us-ascii?Q?gaf9vg4OHL6+hStdWWB5LdRrJQfqjQDNU5j6S0jEtSXeyb65VDUFeIi62IJr?=
 =?us-ascii?Q?rjC9w72ypSP8d/u+chTU3/OgI/IxxZk6yJIYDrSqXd7x83VYq0FVYEpz7wft?=
 =?us-ascii?Q?LIl/LVylCAcN1LkEBC0xGnhnJE/1JDFKQGrpffdEo5d990hF4TdZH1f5Pvr2?=
 =?us-ascii?Q?AFHTaC6cR3RzB3LBasBFR/oD8fpytyZcAWcd7MAYajvUEODPZVu33hCjWDSu?=
 =?us-ascii?Q?VYAHk68BbYKGiLaDn50oQMO5CsWjwPfpT3PbNlePTubu/fvPBLukumwsu86B?=
 =?us-ascii?Q?d06h2Go85nWNmzJvej68NKh/tEBEr8sn3Cm4UGWUhk8zApCGjxz4DBqBFFrU?=
 =?us-ascii?Q?RKCxhSFJ9Eand4cJ77L6j0kSzaXAz8jqmBCj92qe8+aARDWSqTdlxpJfLsx5?=
 =?us-ascii?Q?4GYuMdMe6ebR5Lc/D7DzYs+c7qUZ76oKNzpun2o5SmSVrOQUNRRcvxV/sleV?=
 =?us-ascii?Q?zLkbddHP7MiIH8TlrTw6IJK0otvgLxFCDmMRjWmATzWD0KbFg7dURxTOzuq+?=
 =?us-ascii?Q?3GKDE9e9HXeh8rDQLzoKGz9POLOkoaRNf0LhtJsLuGS/MWyG/Ta8JR1eEU0O?=
 =?us-ascii?Q?A9iZQsPQjfTMpelMT+tit68il+Pb/vKXeHZOS9bVgtiEKFNHiK/rL9xV+Hu2?=
 =?us-ascii?Q?NFRk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1c4a88-4bed-432a-d752-08d8bcf63772
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 03:48:15.4413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXP6HL87kvjVbnkD87xGkNI0vQFAVJXu8L+b+1KPpL8hMngWO0HS4UluTeWNkyif6LotBe+08iwBdmtPFOp9Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0146
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
Cc: lijo.lazar@amd.com, kevin1.wang@amd.com, ray.huang@amd.com,
 Xiaojian Du <Xiaojian.Du@amd.com>, evan.quan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaojian Du <xiaojian.du@amd.com>

From: Xiaojian Du <Xiaojian.Du@amd.com>

This patch is to make the error log more clear for fine grian tuning
function, it covers Raven/Raven2/Picasso/Renoir/Vangogh.
The fine grain tuning function uses the sysfs file -- pp_od_clk_voltage,
but only when another sysfs file -- power_dpm_force_performance_level is
switched to "manual" mode, it is allowd to access "pp_od_clk_voltage".

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c     | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c      | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 88322781e447..ed05a30d1139 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1487,7 +1487,7 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
 	}
 
 	if (!smu10_data->fine_grain_enabled) {
-		pr_err("Fine grain not started\n");
+		pr_err("pp_od_clk_voltage is not accessible if power_dpm_force_perfomance_level is not in manual mode!\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 6d3c556dbe6b..a847fa66797e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1452,7 +1452,8 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 
 	if (!(smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL)) {
-		dev_warn(smu->adev->dev, "Fine grain is not enabled!\n");
+		dev_warn(smu->adev->dev,
+			"pp_od_clk_voltage is not accessible if power_dpm_force_perfomance_level is not in manual mode!\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index ab15570305f7..4ce8fb1d5ce9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -350,7 +350,8 @@ static int renoir_od_edit_dpm_table(struct smu_context *smu,
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 
 	if (!(smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL)) {
-		dev_warn(smu->adev->dev, "Fine grain is not enabled!\n");
+		dev_warn(smu->adev->dev,
+			"pp_od_clk_voltage is not accessible if power_dpm_force_perfomance_level is not in manual mode!\n");
 		return -EINVAL;
 	}
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
