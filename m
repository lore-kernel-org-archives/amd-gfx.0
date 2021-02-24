Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E98C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54AD064E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54AD064E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 979F66EBA0;
	Wed, 24 Feb 2021 22:22:37 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770054.outbound.protection.outlook.com [40.107.77.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3BA26EB98
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SA8QRiJjIIBYRNIeTnC7yRfkB8oW959IF5Lw5+/+ZTPQDsKHU1W3wd6ShdxIcuAWecqyD92amP2H9DrViSZbAjvUzXo+x2oNzzLnLvLdN6tTEpjgdd+uWQMqFl8Wzd54QuHuUnuNM8aH5UHbDqkK0oY995QCEfk5stCTzwnMbMzQIjRkCuNn+couT7VqpkcI5J0J0s8Wq1jX/EGwWz4FhK2UbS6a/K3ZC1A5DtbvGRtPifer8FaOqlFTGgvbRMgIudVf9AzZPKpMwEkgnbulhaQBViRCq2divp0E3fD2wU3XyO1lY0nvbsE5N7ROHhojujf4tmIw4FmREav1J/MjRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xVWkHqcM87xY1ZFcgz/QcS/pSKRxnhZ14xitLyJUDk=;
 b=bZmFi70WnWKkAUBZXwHY1EwUxgR83LrZlbLPnzlnkwWJ1GbhmFGBfxdetk9A03ivZZ19Y7JselOJDFx5GFhhA4pEsjjuIlLuVLq6nuMmY+dgnz9txHoaWNY2SJ/ECoQ3GrepaN0m5SL/ljWryco3BgMTah85fe83NAXQCJ09gaWNoT54ZTdIfqTiA/ZbIDTkxNDS1Io/Pa49Sz+1AlXo8MwnoBGgetZcRPKzMVk9C8ZEljf4C0uyCJ4/p6joktWD22YL4l/c3MUJdGy+v2wTipGVD2auAvjqMW4OqolCWYmUzTKXgry8DeDUeU0rg91k9ZFUI/wzLGn8WY4tFQSE6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xVWkHqcM87xY1ZFcgz/QcS/pSKRxnhZ14xitLyJUDk=;
 b=MbndzG0pFWyZDGDZNRE9ZWxvseQXKEooTCxWog8QQqc0o+kKrBvcHMnDx7/etVRmC+V48TeK/n5Lo9jL9FbjGyQfeNw5KNDptQ6TsjvEHxVD3HVuj9S8EyBNAAp+6KMeDU+l5r4333xXmrU4MFOGHyH04cM6B4oPkSOaq5wmI1c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Wed, 24 Feb
 2021 22:22:31 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:31 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 137/159] drm/amdgpu: update mmhub client ids for Aldebaran
Date: Wed, 24 Feb 2021 17:18:37 -0500
Message-Id: <20210224221859.3068810-130-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5ffa554f-9864-4a99-bf69-08d8d9127436
X-MS-TrafficTypeDiagnostic: MN2PR12MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3807F9DDA28A1B919073BBB5F79F9@MN2PR12MB3807.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KANTG8xrRUmYQ1Nv5MhNF8k5iq7ajUJffH3h1XqVY8cbHHYRlFBP9sku8NRWSWBPU8MctqqJdo7lmCFbUwcKX74W4S2usuiiuIbv/vnCnxyoJdOJFZVJS9KvMRTbzpHwWnL05bvBT+Gj6xddxxyMCNxy92lZvxemf09SJ5Kv355D0n7dNIvWCAwp96o5oWf0hCqwFz5CgoQkQDS/0TaMnrLnwgw3q0daYjEcU7cLuOCCOCMvqzA+kH6UWRwaJsE6tF1L1fBEzVEbcvEbLCXrGcCrxAARLW4yTT+Z5JM/eW/6wDLsPNo/ks5zpeA8bKndcZeldshy9SJKSrqKDxvc0N8zXLFROJ8Ovc+q4AvJv7E9OyRdkdXmFAQfGtB5QFfJ0VmfbzdnO1xasaoLznmZvtrS1u51xSHDOyhtz/IoAHf2MpNN4gHgmNbFFOrlT9Mo96WwrosQ9hIrgdQbCIqnKwas0rtne2bgV0a+OxgRqmKR+BoYh2hwS7WD5kn58C5frQq5UGbYkcRNTTgknu/MpfRzIpNYayr/cvF13j7f/+PWG0VVpDmtr79eeDfTNRLMdJ5jHpN0UQqa13a9WRIDhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(54906003)(478600001)(4326008)(86362001)(83380400001)(16526019)(2616005)(186003)(36756003)(66476007)(1076003)(6506007)(6666004)(66946007)(69590400012)(6916009)(8936002)(6486002)(6512007)(15650500001)(52116002)(5660300002)(956004)(316002)(2906002)(26005)(66556008)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iX56XSaPIj+0gjIO88O2qnaH2BQRrdPKlMfDrMx1R34Z2ZcT0gVbahz9BZfS?=
 =?us-ascii?Q?F0Wcx+tzwkZrpcvGB49eyYzLcQ77pEwwzH5LJ5JnHtmWVtyZNIgIEDU6C52I?=
 =?us-ascii?Q?g5sR6A9IRD65yEYvZVFmibTTZrlHkgbvcV05I7C7fUMo3//mmEIaP+FHehkL?=
 =?us-ascii?Q?45lWy445MIhow9c4O84F9Uhccs4ITlw/P3a9cMLkMmL77YKb05BmQiGuAdcf?=
 =?us-ascii?Q?cv5jNnhU1CsMbuMFuXntnf1GsLzTkOe2UxuyK8S/74vXSAQ+P6mqIIyf/Jyv?=
 =?us-ascii?Q?7csR/5Zq/wQrSIW5ebIuOE2AEGtw07+n9Ho+t/CrEbYVCSAzl0DDlH5M5Dij?=
 =?us-ascii?Q?j7qnkvEoguYFyFcFhed+x4dhw4rFfE9cHkfYezkdGIEjovo10V+4+FUJUsqF?=
 =?us-ascii?Q?F4c7UeCpMCL/Pl37KQ5TV2BZWl5AGWHKgvNml6evN9o1hMRSzkSx1g/LSQ+z?=
 =?us-ascii?Q?8WqcL21h3CjNStcVokAo11VtxN1+3umTG0B5hsf2OYg58t8hQhNrAOBNkshZ?=
 =?us-ascii?Q?t5Jceg6W4zfPhAOPCKHDcyiSfGnawuqVSnx/ZFzF/KrgK3ipKXjyKNI47K1U?=
 =?us-ascii?Q?GVGS4/eb5btgBGEYQsTd2Je29NTxCr3DQ7uWJ+xp1zcfqmx7gfAFItsseFhW?=
 =?us-ascii?Q?wyz4OqSEzXV/e4NfTBD08PjyAxKDCO8o7+SD2mYYpgPdsayhxCjRCMtgiBWc?=
 =?us-ascii?Q?3bhB9s4aXt20Y0FYPDRAKoACM/35taErFl63j4zB3O4SDU91Ymcb6dEE15aI?=
 =?us-ascii?Q?+bjeuTA9Yzf2K2i3+e+/0TC2v2WhYETpzF0kl/8iD86Qgs34W1N8JqiCh/sv?=
 =?us-ascii?Q?5SXdkp+NQ6ESbkicOC6BcEyXsYu3j4FBJ2y0V8BWL186hHjLGe3SJu3KraS4?=
 =?us-ascii?Q?AF6CpRPmZi2zTom+atxvfUflCIl10uJExkceIz71bhP5gfLI234pNF4eBGB8?=
 =?us-ascii?Q?dAO4c9JbDzPT9M62YmGxZSpBhvgpICnER2YSPAYJegLKvcRuHJXYifKWaO47?=
 =?us-ascii?Q?W04rb7Q1bxUkKfYQlfVbfAuk/xeG0LbMYd+ykFQ/RkAvK2i+7Q/eZeOHnTie?=
 =?us-ascii?Q?r2nfVbrsanKDPfyB1xJDXt3sS3bbee8bIX7A56r+L5tkGaO4CpOdy4xllGrp?=
 =?us-ascii?Q?ZwdAkNXTftaiYylshmdolLpNJBHrJBnkwbvNmG2VgtbJD/dsk6gDid3rZWqQ?=
 =?us-ascii?Q?eIG/nfR3NAMxt0YgnLyxOmI8pCpp0RCDNxNtqp/nlrsjH7hq6NOl0oP1Kb6F?=
 =?us-ascii?Q?m+9Z/CU4CwXZK0QE3CfzXVVva6lqjq+xu3m/QJ8rJcdjnrif41hVsB3eUKmC?=
 =?us-ascii?Q?Dd54KmhkJd4skdLN5CzISclb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffa554f-9864-4a99-bf69-08d8d9127436
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:55.7290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljocCdECMYIhAOb+9J2ZjUo3kJCYtLoqdrcJOyRZb0CJxJT+yK8wmMK3Jo56YVPNZM8rYMlR4xnZWfEUXwW23w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3807
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
Cc: Alex Sierra <alex.sierra@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Sierra <alex.sierra@amd.com>

update mmhub client id table for Aldebaran.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 29 +++++++++++++++------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index adc910a6dd19..00c8ec80f19e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -283,39 +283,42 @@ static const char *mmhub_client_ids_arcturus[][2] = {
 static const char *mmhub_client_ids_aldebaran[][2] = {
 	[2][0] = "MP1",
 	[3][0] = "MP0",
-	[15][0] = "SDMA0",
-	[32+0][0] = "UTCL2",
+	[32+1][0] = "DBGU_IO0",
+	[32+2][0] = "DBGU_IO2",
 	[32+4][0] = "MPIO",
-	[32+13][0] = "OSS",
-	[32+15][0] = "SDMA1",
-	[64+15][0] = "SDMA2",
 	[96+11][0] = "JPEG0",
 	[96+12][0] = "VCN0",
 	[96+13][0] = "VCNU0",
-	[96+15][0] = "SDMA3",
 	[128+11][0] = "JPEG1",
 	[128+12][0] = "VCN1",
 	[128+13][0] = "VCNU1",
-	[128+15][0] = "SDMA4",
+	[160+1][0] = "XDP",
 	[160+14][0] = "HDP",
+	[256+0][0] = "SDMA0",
+	[256+1][0] = "SDMA1",
+	[256+2][0] = "SDMA2",
+	[256+3][0] = "SDMA3",
+	[256+4][0] = "SDMA4",
+	[384+0][0] = "OSS",
 	[2][1] = "MP1",
 	[3][1] = "MP0",
-	[15][1] = "SDMA0",
 	[32+1][1] = "DBGU_IO0",
 	[32+2][1] = "DBGU_IO2",
 	[32+4][1] = "MPIO",
-	[32+13][1] = "OSS",
-	[32+15][1] = "SDMA1",
-	[64+15][1] = "SDMA2",
 	[96+11][1] = "JPEG0",
 	[96+12][1] = "VCN0",
 	[96+13][1] = "VCNU0",
-	[96+15][1] = "SDMA3",
 	[128+11][1] = "JPEG1",
 	[128+12][1] = "VCN1",
 	[128+13][1] = "VCNU1",
-	[128+15][1] = "SDMA4",
+	[160+1][1] = "XDP",
 	[160+14][1] = "HDP",
+	[256+0][1] = "SDMA0",
+	[256+1][1] = "SDMA1",
+	[256+2][1] = "SDMA2",
+	[256+3][1] = "SDMA3",
+	[256+4][1] = "SDMA4",
+	[384+0][1] = "OSS",
 };
 
 static const struct soc15_reg_golden golden_settings_mmhub_1_0_0[] =
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
