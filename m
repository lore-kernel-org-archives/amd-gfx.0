Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53B0C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 11:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94EA9229C7
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 11:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94EA9229C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 356C36E0CF;
	Tue,  8 Dec 2020 11:20:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 016DD6E0CF
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 11:20:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OW5TikInUxWRxxtiP3wWTePNWqrDCCtJTQdb7+5pZnc3bKEtqSeWEHrKKeSQipvQ1/stQAXOxr6czukwXR9pO60arEntX3lewtoHp1SrRFz3kMaWcJVES5lPxL7KAEhG5aoYulVrbTjzEk5fgOh7m9mRgq9E1Y6J8/FBOj3Pp5KZA5vclzaWUuFu4vnlNme/6Kfvk50z1lN9R4w8/y6+LvoOZbmX8vn6vR76mR2cw7u0LAF7HBUiKnL6Jkg45xtAli5L5GfZ30HD0kSn8tV7yJuvM08ykScNCdGXdaLWs41jX7WJLbZIRI7uoqtB1cHKMof8FdnwyyZ5AdLpgvSWMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QWFFYZkOMOS6N6uwLIGOMhQRlfe+lHpem6ITbC25tM=;
 b=Yz5zU/mHNNGwDC9He5nnE8LG1maeVF+kiVpr+xnhqCJOLsyerojt3GGCxbAadDcN6ED1+dMpOfCGWNMRSGE73WnxXeaXliqH5LpNb1RTShbpm7GdQFq0WLz7PMjXztoQNbasgcZDjIxEr5EAIJXyYrNuNpx7jwwZhGpQaCePsm47LBlT+fhZRPBAPri6c69+2ETpUqqDaaBG417YF2RUl5esTIZHBXoQ+fRlWADUb6EQyHVOa9nT77ymtA0LJkxvWLMeJsXg7+ng3uQzgI3n4L0Fb9+C0xqy8aNnz5WzaUC9oCXdgm33uTVKaR0ac/astS0AtSoJhxMl+RE7dv2qJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QWFFYZkOMOS6N6uwLIGOMhQRlfe+lHpem6ITbC25tM=;
 b=WICMX501yYVKqIQ3w7r8EA2siOThex0VS+jCA1gn246lF4d9/zxrLVTYm2TAg+sTZink1Cu4km2qaHkqWqQMK9BJAOa9uUgnCv/wqEdeJ4opf5gINbICeqolbn7WruIYx+CbW+l19WFVKyvAHwE+sxu1fe0fgmJVwWPCUG1MD+Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Tue, 8 Dec
 2020 11:20:27 +0000
Received: from MN2PR12MB3807.namprd12.prod.outlook.com
 ([fe80::40bf:bffc:e8b3:2067]) by MN2PR12MB3807.namprd12.prod.outlook.com
 ([fe80::40bf:bffc:e8b3:2067%7]) with mapi id 15.20.3632.018; Tue, 8 Dec 2020
 11:20:27 +0000
From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amd/pm: update the smu v11.5 smc header for vangogh
Date: Tue,  8 Dec 2020 19:19:40 +0800
Message-Id: <20201208111942.6292-1-Xiaomeng.Hou@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK0PR03CA0119.apcprd03.prod.outlook.com
 (2603:1096:203:b0::35) To MN2PR12MB3807.namprd12.prod.outlook.com
 (2603:10b6:208:16c::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from code-machine.amd.com (180.167.199.189) by
 HK0PR03CA0119.apcprd03.prod.outlook.com (2603:1096:203:b0::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Tue, 8 Dec 2020 11:20:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3251faa5-1557-4e1a-66aa-08d89b6b43d5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4270:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4270679114FE8EB982C7E75D9FCD0@MN2PR12MB4270.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cDsLKV+DgytqfqDpE5LlCS21++aaNtQgWlT42bTMT+k2Gc1+YL/OhR42j0HSemnf9rBInhfOl/GswDAgEstDmWSnZvRVYNcXtkc/EMwiGyW0MeIgCZYk/hHM6B55kx0qhNytVeKZ2jsqRVD4ax7p9Ru0uV/3T7L1Xl+YweAvMQXyGTc4oP4qEkFtW2cHbmGi5IVIfgeJNigaWSK3eVnQeuGY+2g5BV1/l7i+SLolKkm8T+rS1eLTH6zdpKuKUInL+6VL3L7pRezJOpS3zp4pfdRNaVSnNSPq/8LmTP6QtE4FnQNJsbLjw1cz3agAQ/R2L52NCixdtkhYZtki8opoYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3807.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(316002)(1076003)(26005)(6666004)(186003)(8936002)(2616005)(7696005)(15650500001)(66556008)(66476007)(66946007)(86362001)(6916009)(5660300002)(2906002)(52116002)(6486002)(36756003)(8676002)(956004)(4326008)(83380400001)(478600001)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tYH24hP5ImnC/1jT5q05jy7h27e0W/99BDhXcNSpqhTluIu+y39F3JWFemD/?=
 =?us-ascii?Q?zla9LRzrEDj6GbM5SyysnmKimMSy/raMniL95YU6MMtjEh0dj9xll/6MQJWP?=
 =?us-ascii?Q?j2T8X9k9TNK/hiGWbqVeBxEANb2gRUpJSu9USoqUyUaNMOU15vbipDtNQj/I?=
 =?us-ascii?Q?kWzc4G+9NINZiJ8KF9piP111hNoHX7vf7UhwYvjdQJhDseogSNn0lSJXWPyD?=
 =?us-ascii?Q?QCt4FXRfqVFCj+8SEW4LGveBxQ0DhNEd/83VMLFEfYXGlXHYqKkvdxoPaJYT?=
 =?us-ascii?Q?b9NBUNESBL+QjFMGYoM5tNUWShbZjBktbYgQzUf2i8NjsXp0mxjTj6QLHgSt?=
 =?us-ascii?Q?n1+D72TPL5uBVbN1ESefKYYxXE8ocXXs+emv9mgOy2sq9RbICA1dByfN4MFm?=
 =?us-ascii?Q?CaGIZdZnlimUT919k7tWr5ffS+CsfaLJWZWAD7MZFKszEmG69SP9Yx84SAmj?=
 =?us-ascii?Q?yU0lKAJgnT6bDA7nksO6Ja9kJF6TZYQrtox9J4ijqBRy92FPzsZYT/3wF7WA?=
 =?us-ascii?Q?mUpcsYGwPSqhdjd078RDFYiNm/emzuUy3kciI12oENFFr6qnsKb/xyXVsAaE?=
 =?us-ascii?Q?YzYshrXRWV0Tl2kB+Mm87Vu5KD729sZBssQmQFY06/ITVjH19SJZRy1EK3Bv?=
 =?us-ascii?Q?CxnhKUws5i0H00eEb9DVjCY4yo0hBAMLsG56AhCy8iaaLm4843deEl+7VJrO?=
 =?us-ascii?Q?GxJpGINW52rrqASIdGoj+TDTGZeW8+eWQBJpATo77vLCdb4VnxGpSqtfjbv/?=
 =?us-ascii?Q?IzbIBRfcf4PEUw2FYUZDcD7x2YnSqhngpjmABjF6lfFjjiHF37A2xBj0/qo5?=
 =?us-ascii?Q?xvQsvz+KOzL+xPo2hSocs1MEoAAHTGl/JP5n3pYm2FXcmaT4Z/IAVjvzZrMJ?=
 =?us-ascii?Q?x9g4jGwjobvsQ+meW8x+NSJQ9DAHUtyLR9ToyeS/DjFhM5Zbb000nWK3FWUw?=
 =?us-ascii?Q?Fz/DNN8ZIUjwiU7Z6JoSQZHWPYRKNNC+lNnN6tVB9uPzK41jFEPhzF43woFX?=
 =?us-ascii?Q?U+/0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3807.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 11:20:27.4080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 3251faa5-1557-4e1a-66aa-08d89b6b43d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0lDnxcyPCIlwYu/VPfmHaGmVdSCY4QAA28LDdzneoXkZuY4tBaibihnTDV0Pc4wPcRxiSKrUPzDW8qvQV5n9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
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
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com,
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Evan.Quan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add new PMFW message to notify RLC engine status.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Change-Id: I7d714f8f245835cacb25e7cc4b248ddf183aebc1
---
 drivers/gpu/drm/amd/pm/inc/smu_types.h       | 2 +-
 drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index 4a6d1381df16..41a49c1c0302 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -178,7 +178,7 @@
 	__SMU_DUMMY_MAP(SET_DRIVER_DUMMY_TABLE_DRAM_ADDR_LOW), \
 	__SMU_DUMMY_MAP(GET_UMC_FW_WA), \
 	__SMU_DUMMY_MAP(Mode1Reset), \
-	__SMU_DUMMY_MAP(Spare),                          \
+	__SMU_DUMMY_MAP(RlcPowerNotify),                 \
 	__SMU_DUMMY_MAP(SetHardMinIspiclkByFreq),        \
 	__SMU_DUMMY_MAP(SetHardMinIspxclkByFreq),        \
 	__SMU_DUMMY_MAP(SetSoftMinSocclkByFreq),         \
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
index 7e69b3bd311b..55d7892e4e0e 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
@@ -41,7 +41,7 @@
 #define PPSMC_MSG_PowerUpIspByTile                     0x7
 #define PPSMC_MSG_PowerDownVcn                         0x8 // VCN is power gated by default
 #define PPSMC_MSG_PowerUpVcn                           0x9
-#define PPSMC_MSG_spare                                0xA
+#define PPSMC_MSG_RlcPowerNotify                       0xA
 #define PPSMC_MSG_SetHardMinVcn                        0xB // For wireless display
 #define PPSMC_MSG_SetSoftMinGfxclk                     0xC //Sets SoftMin for GFXCLK. Arg is in MHz
 #define PPSMC_MSG_ActiveProcessNotify                  0xD
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
