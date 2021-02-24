Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D750C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE65364EDB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE65364EDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1106D6EB88;
	Wed, 24 Feb 2021 22:22:00 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770052.outbound.protection.outlook.com [40.107.77.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 968166EB88
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkM26ruil92OEsAX8ZfkVEaSHn0OHpW4lJYMFt6x7IwdJ4MbvYPmGeiHYTnEhoyX1Lzb6bnaoY1s5BVJ4bbtipZ8Xc/SLsZS6m3BhydoTC6eRAUbBUly9RoQzen/zPj2Fo5rUbipDzpDrmQ88e9PDF0J9G9FZ6Hisc9uK7AbHIxEDgEj7IKcm776BOTk4JqXgiuVKBjluvj6HSx5ZBgh5otgcM7RgOV8BRojj40M2TQG5R+I7QrMwcE1ByqmDHVBJbLdZmw3K+SlIG0FyNsBg9YqFSbvE3XZoD3UD+nFtkZSIfqScnAiJQp9Sy9cuPB/yLBx2zGFO16TKHFles9+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1VqBYGRj5/a/k3yi4EJLa8eozC6lOjiia4fiHY2Pyg=;
 b=RPcavI2HnJXH9P+CYTjaFgrOBpjdSUfeyXj40ZSCEqf06jNgsVTtnvvOdrRufmoT+KuCNJn0yrfNaj/A9wm4+LdhAbYxMziNNPHFiRq7BPE5SO7Qo+bocJ1dxRRhwLIEDBNeUJYAFC5L0v/71WUKl69t5Gsu4iNiYMHlfm+hFDPhGYQbqsdhAuvaSngekIPTGg4lcH5j4adTgelZSQpxvKnLmH5WOBLRXUjv3+cTfB2mwp01q0rqEXRZ3+Rpip3WHTE1NXedOcIJHiWPoZCID3z6RICmDFy9Bl3NU5T2YJ8p/zH0qTKHlw1SJC7P+ngwl/rD0qxyLSW1DVVVL782EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1VqBYGRj5/a/k3yi4EJLa8eozC6lOjiia4fiHY2Pyg=;
 b=Li2i21PnSdCdGLEYxN/WLm4qpqeRyOWF2mcFbFP+k0kptRnfpllUyBuRsQJkwGD+BFY/Fzlbq82RZEbJuhIXE8IVXW17I+jXKnBGbmCqEGCyHPkh+Mt0353aqj3LHoxXEG+u8etiAm8MB63EYN71hZRVUIybEOBKGlIUIlhzIYA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Wed, 24 Feb
 2021 22:21:52 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:52 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 122/159] drm/amd/pm: Fix power limit query on aldebaran
Date: Wed, 24 Feb 2021 17:18:22 -0500
Message-Id: <20210224221859.3068810-115-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 74fc601b-7acc-423e-1402-08d8d9126ecd
X-MS-TrafficTypeDiagnostic: MN2PR12MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3807B5143AF4D09DECB0EB3FF79F9@MN2PR12MB3807.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58uyJT7Zhmut6zEL2Zo7AESGvqpAkVrhs6lNeOJeOb1zNbdlwBE+R6W4AzrZhTue9XcHbeF2PyV1vsJKyMtkm17smm7QXY1PVJWIecNqsLvJG2cfizpvt/qjOvZQc6sn9Qh0N14V7o8u3fhWc5krN247TevzOfzZYuiN+q3gaLv9gA14jHRbER+DUoH20vFvMy+8NfeS4HR50lmpuWI7S0LY8IiTNApUQSOHPKEqEQ8Y3M9XRdkwjiFXneqqN5V/N5VL1ZEsWqSuCb1+i3VoUkigBCX1l65NGm4VVVeOz4yaLgltc+j35sie7mb4EsMj6fDu1UCgchuNpyieopptimFsQMyOKa03e01TVteIlCuOfnfcKN7XOBKyZfQKvwR05Ccfr2AjB0di3ncN6kiYb7ex6c6ol2u1vv/gH1KXZFXNFQVJOVs6NJaGdE87m2kD04ciFzzTlwwwWUUSXNS6P6/WrKHAFUxCiONqB27wzWDioMGYu+gZcU/AbKNeUXQuqnrXCXp+tGw4EfDKmNd10H6wl0MAdwtUBtVkCgAnye0yofaXZr1YYpz6SJ9kw6nYQMWiS6pmUic3MWkNtvtvJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(54906003)(478600001)(4326008)(86362001)(83380400001)(16526019)(2616005)(186003)(36756003)(66476007)(1076003)(6506007)(6666004)(66946007)(69590400012)(6916009)(8936002)(6486002)(6512007)(52116002)(5660300002)(956004)(316002)(2906002)(26005)(66556008)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1MLAT+UEYNksc/oOj06TVuf8GwPtiLuUrR1ZpJfEi1AWCNMFrR84GiXo9FJI?=
 =?us-ascii?Q?op6R+3ifYQ6jiDpeUkP6v8+qKhQcaY1jrnFZ23+KcVrsFIGuiENxhChAl8Me?=
 =?us-ascii?Q?4HZabfsJPjhtw8nx4ZQw74cKXaVc+QBxODmKR/sr+c7XgtXd9LJCO6SvzqWP?=
 =?us-ascii?Q?euwIkXwSmT/PYlSllFSPuT0gxVWlFO7NFwXmq5f+hIOwaY4TPMH5eRcW0EW3?=
 =?us-ascii?Q?e/WvutZ7LvgyuNedl6HlRcu961rmVMnhTdFKEwFEjFv4kjKaWiQwg+GJhIYG?=
 =?us-ascii?Q?Wy9HXBrDEqn8yjkiELe0w0+5ngCUyXp3l3liYU7zksjT423oyQ/lCz2sHApu?=
 =?us-ascii?Q?IXBfITycEFRZLcbBXa639fmV3qqIXYYO4yWiCjAdgYRV+98Et/8zlGSxgj6P?=
 =?us-ascii?Q?OZWhzXnWIZroQHQO0T/1VhJs0teyQXz1y7bzDWZ0ZOzrzhPtT675uS2TCYkk?=
 =?us-ascii?Q?KSXLf19tUXZwJjNBU+BJGwMObFJpznveGTYw9TVhDGGt7nz8YH53rIBS+fKn?=
 =?us-ascii?Q?D7mHMZYuxSFvPxGz1WD0UBBUn+UdSUr4sDx8ep6gi22u/Ro6U2eU1OAFFqzk?=
 =?us-ascii?Q?DWaFCvSHfPj8hpNblLj/iq8tK+duIE8W8DH0nHpLuoZBWCWA2g/QB/K6eeon?=
 =?us-ascii?Q?L9I8p1q+fwhi8RqpCR9nE33mNC2tNUNlqm8C/+LKPcd9WtG/Hc5/5pF714nm?=
 =?us-ascii?Q?gC41T7+qbH+Mebm8XrqTZ23K/0/3m2ebDxqBGLdKq7TCT07AK3txZI2mI9p0?=
 =?us-ascii?Q?woNrwQ3UMMHNvXFFzO1DKnLhIL58samKOK+C+9ISaPsl2lISrCs/PzKoKotb?=
 =?us-ascii?Q?/luO9vry5NQlTIoyCk98BmhyGiivWENq4MkLk3CHTd5pgKcgjgofOLr6xxPp?=
 =?us-ascii?Q?JMSoNLzcNw9BhTDcn6qBs4EjtPHf0vVYN9FdyTqP1qIKXCjCXg1ayZSNOnF9?=
 =?us-ascii?Q?AJuvwLKJy7dOdq+d1A6W6tDgaodc2ETYRbQXfxYBUF9LwL8QdcESVgNfJ3cl?=
 =?us-ascii?Q?GVPt5MV1+RhXGH5hpAkcPPMAJElfkJwzODfN3oZqygxAqAREk4FbsYciXneG?=
 =?us-ascii?Q?Dx5EV/P/fWt62o/qAKTPkU8agVklNNpypClIxvHu9h0aUoZcs8mJ+3+ffIzg?=
 =?us-ascii?Q?njBYNVA6lMNkPHog/UOV4QmFi079zYrPR6dsfMew/2JbXnF+KjwlYHJ1RA/e?=
 =?us-ascii?Q?YZ998V3QnUseJ3V7jKv+w6LhTh5l9SLEy51Qg0A+mNz6snIlmBTLMXcfWQsx?=
 =?us-ascii?Q?TidKNa9mADrzeK50mkO8lVC0szp3qeWpd0+HG9xditTluu/DKA1vYteIqRFM?=
 =?us-ascii?Q?M7sqsIlogFXUwxi5n4SwPLDY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74fc601b-7acc-423e-1402-08d8d9126ecd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:46.6210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PW4DI+yRTOMRCmB4PxdxxxduX20ZLzmvhHZsI2WqTIZFp+LrElMsdQ/PNFooQxJuVxQP21bLzhG35+RmbGJuag==
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Aldebaran doesn't have AC/DC power limits. Separate the implementation
from SMU13. Max power limit is queried from PPTable.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 28 +++++++++----------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 2810cc0a958c..e08df4da57a8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1066,30 +1066,28 @@ static int aldebaran_read_sensor(struct smu_context *smu,
 
 static int aldebaran_get_power_limit(struct smu_context *smu)
 {
-	struct smu_13_0_powerplay_table *powerplay_table =
-		(struct smu_13_0_powerplay_table *)smu->smu_table.power_play_table;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
-	uint32_t power_limit, od_percent;
+	uint32_t power_limit = 0;
+	int ret;
+
+	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT))
+		return -EINVAL;
+
+	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetPptLimit, &power_limit);
 
-	if (smu_v13_0_get_current_power_limit(smu, &power_limit)) {
+	if (!ret) {
 		/* the last hope to figure out the ppt limit */
 		if (!pptable) {
 			dev_err(smu->adev->dev, "Cannot get PPT limit due to pptable missing!");
 			return -EINVAL;
 		}
-	}
-	smu->current_power_limit = power_limit;
-
-	if (smu->od_enabled) {
-		od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_ODSETTING_POWERPERCENTAGE]);
-
 
-		dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_percent, power_limit);
-
-		power_limit *= (100 + od_percent);
-		power_limit /= 100;
+		power_limit = pptable->PptLimit;
 	}
-	smu->max_power_limit = power_limit;
+
+	smu->current_power_limit = power_limit;
+	if (pptable)
+		smu->max_power_limit = pptable->PptLimit;
 
 	return 0;
 }
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
