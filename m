Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB26C433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E2A64F03
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E2A64F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 287D489EEB;
	Wed, 24 Feb 2021 22:19:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4181689DB9
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeKcfj22B5yMmshBrFO2iMNsUw6YMH4LETrScDG6gb8FSWyaF8/0O8ZqSzdxkln8dAU1H6EdTMq9lXoXClb7dTF0VqhUTRG0tnLjj88JirwGpPOuzbTNjQH8EOVkkrKQWEbRSiOMaJwIhksMTPKFqHiDpZPyoJk72VvbXKH494JnP/w1UcSu0EiYKmoVLXkWeWqD0wSu/N0cCiDTXWQShZ0vjuYffoOX4uccAyWyZCkAhmJfShfc35QIkMHfDZk2KNRz0nUqfuw6Un0/NYMaaA/D1aeFENnTs2okp5PpTx31qtPr+KQ1i1FHWVvJWAozg0nzc0O/kFrQ/CIFZNj5JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQjHlzCEpAXMuxTphOA8NTgnH6+k/7l/rCiM/3234ag=;
 b=hfvdy7s/ABMAUUGE4Q7ygf7E4ddYSw+0DtGiWAimMV5lInnNkD5HP1OFOpOOc6nFB/ZEYhs2tZS5bh7lSk2ivrG35WH3OCbL4bPg7/eZDjJqLUWnxpYSM/w1N3g57qI5R6Uk2AbPhmTFY1cA0tTivc1+yivZXaer27633oC0T4nvriRQOg4t8CZMPfwH/W1v0BddjaZvpy90xBxqbsq1IscZmcmYlyoX9gsCX9hHT20YaQKbextkw4r7WRdoEED0z7rUq7jb/GpvTB1KZWBlT7lUe8rpIQO2bDFUrmBfV/MQ1Ul0JviM5zyU3HpbbWFLvjOXX7jUCgIdBhXodFuZGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQjHlzCEpAXMuxTphOA8NTgnH6+k/7l/rCiM/3234ag=;
 b=urWbvf8kclx85ojs++xV8D4nDRc1waZD4J/AuiGezI0XcpPt/V+LnBfZHv80e2SkxXc6f9wJwfr4MAfs9QWhP6LozpRXvoRF4u/C8lITG8DV772hie9IswGhodMppd49FjQl6pPFORraKgYi0gxfc31/+iF+LtGjOp/e4v37iOg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4174.namprd12.prod.outlook.com (2603:10b6:208:15f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 24 Feb
 2021 22:19:29 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:29 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 015/159] drm/amdgpu: add gmc v9 block support for Aldebaran
Date: Wed, 24 Feb 2021 17:16:35 -0500
Message-Id: <20210224221859.3068810-8-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:19:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3da4b793-3bcc-4167-aa4d-08d8d9124074
X-MS-TrafficTypeDiagnostic: MN2PR12MB4174:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41745EF2791B1F5BADC4E8C2F79F9@MN2PR12MB4174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mDBrktC1h3A3bUhN5piC+/HYK7fHxj9JHjIc4PrlHx13DkCSAVZ58Ffm7jj3vlWXj/QFBxWrlrtxMT8NQzEg7/6S8JZtsmzOmtqwUIcN11+Jxl5UwoM9BGM5J3J0GZf7CxTNWpUoFPhsaE52xoicI5XXvlYDJ5PwOtZ0tP3vJL6C/QJP86tngiVICQYZviw8qSz1ZzsJf82HnXcgQq9mwv9r81jpChgkdKSG5T7HEXAY3KoFMkQlPpCnVWcmNa02tN1lnbypugHFTeyl7/OlhZvKvylt/VI/FZByvh0bXl9Hj5Yg26nNYFJx3fzh+Nt9W4TeSZ4pAoci7u9SaqKdvxhuBjG37QzM6iAAJFULQoin8y/CrXV9/kRqpQGog707woEj3GjBWenJSm5v58ra2OE2ugujd4DueKX86kI+CZBwqVqRn9wYBLrj3uVHtF3o5lu+2660Nnv+tIagN7LbYZNuSqgbFOEhZKejkeeTykPxTvrs2o5xKSJtCvtt6TAbqKdTARBJrl7rtGjneAwhICXqYCQ6YagKmQLZldPS+pal7KY4cMI1nWeLeq1X3NaprY+WptiW+RGP/Cm4HhJNqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(8936002)(52116002)(4326008)(186003)(2616005)(1076003)(956004)(6506007)(26005)(6486002)(6512007)(54906003)(66556008)(316002)(2906002)(86362001)(66476007)(66946007)(6916009)(16526019)(6666004)(69590400012)(36756003)(5660300002)(478600001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RgG+WWSjDysC3UFi1fgAt4ymdMkX0Vy0K0Bz2KDDFiJKGokApxZNoj4sktby?=
 =?us-ascii?Q?uCj/GEVTeBBQaIXA0gc51mFm6DA5OCDarSMJVUj6qPKln4fEHUF0mUVtnyJH?=
 =?us-ascii?Q?fHRF+t7W5LITZ9/goKIndEXLVP2Dwz5xTwLUh34Aqr0WF+FmbR1cGYpz1/24?=
 =?us-ascii?Q?7Ir5myK4NyDGCmOA+0D4urnJjVjAWi4oPBS5Q/pLiH+uPC78f6nNsnc5woq/?=
 =?us-ascii?Q?qGRz7Fopnrl1Run1sbovhUOQHfyfOS8y0aie9DspL41m/R56yCKfmfUTCngw?=
 =?us-ascii?Q?0lhA2DP0kGzt4fytjjTxPozbN+u+TDSo4+W2NeSxfJwAphjNZriIas/KPL7C?=
 =?us-ascii?Q?HCk0GsgLYh9FspxO90RA6dUxzIpy33HV13Rf8q55FKr0j6XWcO4U0CfzKR1C?=
 =?us-ascii?Q?azWCY9DHZ8RrTmXI8U5+xterBXJV/AAetLRqMD6ULO7vK9vJz8Bsis7JZxcE?=
 =?us-ascii?Q?10CSI52ab3rjRdnkV+m5a2XIpYoPKju8FXZP82uJKB8qqRC2dGpaDvyM4LvI?=
 =?us-ascii?Q?Qo5P7urro1r+KS1/eFh5JUdtAzs/IjXjJAP4NpMW6TIYREZJoCHGNpg7lH8X?=
 =?us-ascii?Q?erWc871KEh6ZTAva2XFyRGFhoywDnIuoHvN48wkoDc2Z/7/qW2WKemcBjdRk?=
 =?us-ascii?Q?YB2hoWFqVK5LISHsU9IfeLwP0Uw9uTtEkW5E5kpyzj/KiD7y0LRuWKSmGJZq?=
 =?us-ascii?Q?izEH9/92Z3rauNQDc8aFwU5bq34V82Ll77+G0lCGoNHpiWCiFXlS4yZgwKZG?=
 =?us-ascii?Q?bFT0egdWhUBx+GM8lwWaA1p62mXTXNv3AsIKb8SoR0bQZ9kSYxoqjaL1ZRcB?=
 =?us-ascii?Q?O5N8cr4tdYJUKNzgiSKyf1nTEXBHg2lSy96cBV+R+GEaGkqOXSTLr1jXHJ0R?=
 =?us-ascii?Q?7etKBa/OYi6u/vs/C/tXy9ErwaNK3J8+fWTGuce6Rrjr6fPdDm8sg5cFgN+R?=
 =?us-ascii?Q?SV7KkXqYcG7eHh/WSNBafXeQd3LVOfi6RDDofB0KM6Q1NqKsDjvNENyWT2mE?=
 =?us-ascii?Q?1DqOqCXl9/3qPIUCuimBaD3jhciAHRbrAr9efsyZUHsvuqFtpn+tlzOo8oUb?=
 =?us-ascii?Q?TTWSsMh/NXTNjsoq6b7agwCjl0ZDKijhW2M8wAx667Alw5Ez9swnAvrekVu+?=
 =?us-ascii?Q?alOGOAPC2CQI8jWohznbDHsmJCv7WGnqfFLsP3zchb9wS1iu1jCrRgdKh3ce?=
 =?us-ascii?Q?adktyOtacwX4+z7sk1ixauLjxoeBOGczDAPn971bKjCB3ixbc7vhUH4SejIF?=
 =?us-ascii?Q?C9YlBKy7mU/68uXEws9A+KBNYn3O9ytFJ9hElgv5G7QaJZOeDFydm3c7wny9?=
 =?us-ascii?Q?+2RmvTvtUABbho+gELUG6HHy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da4b793-3bcc-4167-aa4d-08d8d9124074
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:28.9131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0uaw4Red7SjMEouJJI5y1YtvHxjzwcmt61kl6y5itio0Bbk1/K+qHmgoIgnYHG8UVeLKd2x7Q677PukpRB4MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4174
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Evan Quan <evan.quan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Add gfx memory controller support

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3686e777c76c..d9f4955f293c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -50,6 +50,7 @@
 #include "athub_v1_0.h"
 #include "gfxhub_v1_1.h"
 #include "mmhub_v9_4.h"
+#include "mmhub_v1_7.h"
 #include "umc_v6_1.h"
 #include "umc_v6_0.h"
 
@@ -1249,6 +1250,7 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
 		case CHIP_VEGA12:  /* all engines support GPUVM */
 		case CHIP_VEGA20:
 		case CHIP_ARCTURUS:
+		case CHIP_ALDEBARAN:
 		default:
 			adev->gmc.gart_size = 512ULL << 20;
 			break;
@@ -1352,6 +1354,7 @@ static int gmc_v9_0_sw_init(void *handle)
 	case CHIP_VEGA12:
 	case CHIP_VEGA20:
 	case CHIP_RENOIR:
+	case CHIP_ALDEBARAN:
 		adev->num_vmhubs = 2;
 
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
