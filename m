Return-Path: <SRS0=uqaI=KB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BD2C43460
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 22:38:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386CA61041
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 22:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386CA61041
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F342D6ECFF;
	Thu,  6 May 2021 22:38:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3164B6ECFC
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 May 2021 22:38:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TD4e6bpmejknK953ioaCbYzAhZEIxeNc5y9ehRsxgv2w5bMJZg739WMqgbT3lU7tFvUWoddLyesOVKeevNrqng+TDaQnhHz6DqfchieKTlVt/KHpQBkuMNxFAX1vplAb87oEPyRnbaHRj3yas8HiyDWbMI5Ut0mXaaOaGV7QnkgtCSj5pe7XyWLKb6+Hk226S7KYgnjHFW9O8qSaQwQucpKwhmmNbCZlA0VLwalKdG4ASCV8tq0KcmwAhAYAk9GSVY+wxoGQhrVozI2/G+9Pw8Q4u3WL5a6zO+o473OTrCaS3zQbvNdzcntAl4zdkKbhHTY0tSOB03QiStSucAHNHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLQ0HXPTCGL/S8+DMNwLHi5J/8EBqtSASWgYscdo26M=;
 b=Q3pSiiJx1nJmfZ0wn9j5KU6EymEgF5lBbz/rUIEDOgpY8vPu+Y+3O0l1N7SJCGnrElVlVSGTHpVSUsLBRbSDdVEdEh3DDGC9quj3VHvU77B2RE+bJyEfR53fGScssakmoeQVd+Fn/T8GVw8uW/GxPhqjoMQi29NniyEz1nta1/DhRjujQLJ+oXdCcT8B67vRYVU3aRceuJwsLTIJmdwRpLbVPUvkVVW2qoooj4dIJzeUdWZ+UNveMXZSdlmE9n3+aC1LbrmA+X7oBtH/i6e0/xvsEQrEQ1dJtzFyh51vBgAKcvlVd+QH9eZFZ9XrI4Cqmj2TWygNHV68UiT/eNrdvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLQ0HXPTCGL/S8+DMNwLHi5J/8EBqtSASWgYscdo26M=;
 b=wGXW36r2Z4GjuHR3NaOD63gI0SrhxV0C3EIDkGYXd9i7n4fvEy+0e3HPQQn7NU7l2RulQqhWDNR95OI0V2XIZ7YKDhxPntiFmF+7DuOf0kVVR0v9SeyBvOt/A/s/5ccP3Bbj6N8Gti/KWtnb4gxMhENU/HIcDmwDJjfBfYqVeMk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BY5PR12MB4034.namprd12.prod.outlook.com (2603:10b6:a03:205::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Thu, 6 May
 2021 22:38:03 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4108.027; Thu, 6 May 2021
 22:38:03 +0000
From: David M Nieto <david.nieto@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: fix fence calculation
Date: Thu,  6 May 2021 15:37:33 -0700
Message-Id: <20210506223733.28058-3-david.nieto@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210506223733.28058-1-david.nieto@amd.com>
References: <20210506223733.28058-1-david.nieto@amd.com>
X-Originating-IP: [165.204.53.123]
X-ClientProxiedBy: SJ0PR03CA0290.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::25) To BYAPR12MB2840.namprd12.prod.outlook.com
 (2603:10b6:a03:62::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loud-cracker.amd.com (165.204.53.123) by
 SJ0PR03CA0290.namprd03.prod.outlook.com (2603:10b6:a03:39e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend
 Transport; Thu, 6 May 2021 22:38:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ce06573-7bb6-49bb-5d90-08d910df9c5b
X-MS-TrafficTypeDiagnostic: BY5PR12MB4034:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4034CEFEE7B725FB87EA260AF4589@BY5PR12MB4034.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nHg096v7ZIlXbfBecKcy9Mo+pNKRamQhQ8c9FaiaVN1jSfiUSmCz3T4WaivnJGav4y1N5Dq0+paHHR7vZkCjJ1CKgn0Bxruf0AAz6JKHKmllIz5yMBdlpJ4kBIRCbawmgLWooSkBTcQKK0myHAQGbjzIKDhYOTKYy7mh8RnNazLCAvwKpPMlQ/W5kyNlz7vjj4w0aCPL7GFwJX/rSacAQ7svVyFERiKuIkAWOFTjXgODr2dR+BRSDsgGDJR0QdD1IxV3WAIP8ZXk3UqiFUyhuunKrNwRQy7gFvYaEXzsj/ix7joQnKV56ewLIdWlM3y59bSNbaVht1jNw3Txp7nfisE05AZsxJMfD8cP1augMuDR0ZfaPlqB8cBywhGugeN5YYhfeDXkYt2VaVosI1dKZDtplFmgYeiteRytIdJtBjEeE/auGcPair/hcAdJXYtFIAcBlB/bGGFbk/7mR3JbkkaiIBOXgasvmOwjQ8v5W+1Ev015f3yLgvfEJYupECUpyK5WbYsB2Bl/wz1wDXNEiVtzcyLcuS12aHsljGuaChl7/Dzfj5e7wHkiNjAjPRQjK20yoATKDRhFY7bSte8m/947qEK6/ef6JLvt52wjDkTFYWYRp11d4DggkuJWQMNwnySc5Lt4q1/Zr8WyvjhmGiZHQDeHVS2CrXhuuTu+9is=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(38350700002)(38100700002)(6486002)(16526019)(8676002)(86362001)(478600001)(8936002)(6916009)(52116002)(7696005)(83380400001)(2906002)(5660300002)(66946007)(66556008)(66476007)(4326008)(186003)(956004)(26005)(2616005)(1076003)(6666004)(36756003)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sgmPYYK3gllnPpz8oI/Sw4nwedhVBJYxubrJ3ZaSRpFAcMoYMMW6NUCMGwH5?=
 =?us-ascii?Q?5sx+y97NAo+bWIRXgo4EWejY5cKM6nHKnZ+BLk7L8N18CZYgwzpaa+d1LXj4?=
 =?us-ascii?Q?/xCqwA+MFXmxXd/Rc9dvv5vgNRCeGBkzEW7REUUdbGGzGtjy3n8PQ2eY4nnd?=
 =?us-ascii?Q?6ss8PQNsAPfVVHddJlwpqp8+RQUrjoh9/j/aqwRgCf6CcHgDfzK0f5Lw2l7W?=
 =?us-ascii?Q?Nh5spS5ofM6yxCDd0eOu41rnri/U1VPAxWS5rGvUYuAHk1l+ilzvuYd5v/Tb?=
 =?us-ascii?Q?cO/GUidgiTCcZJLLGZdyX2K3cFzyOYh1oNeAGoDerhjWUMff0dgZvBbUcJyZ?=
 =?us-ascii?Q?cS6oFCL9C72V6cedigeQxy35bpQnqtEvUGD5NtpOEcRRTNVtDZHy1IyoQ+HI?=
 =?us-ascii?Q?HdzZwCv0ESA8ZJSN7c3SduRTd6r0Q2oo+vqdB9p1EQ1bWbFqa8yokv2+yW85?=
 =?us-ascii?Q?r5tBeU9ryhts/1xz8bsZ4I2IkKwFtxsGJkY3IRQTW3ScZ+1ioWxxtFvQcSUD?=
 =?us-ascii?Q?QM6D6ecqiAIRdh/wDdGVK9VGQLeW35tw5CuW1YOi4jiYt7HtlqMNHf4wiVPf?=
 =?us-ascii?Q?3jEMYNBvJkgYXUzEQLdQ2IDfVy6zl5+CrqILV2UJ9bULTTBD1VCbHTzBn7CU?=
 =?us-ascii?Q?BonKZCisUjKH7rMRV6QbqkIlxD9CxABWZE4tKM+i2O7K0oCLgtJIiXth07uk?=
 =?us-ascii?Q?qAooQw5wwXOBekLEcyeZXvZLYoLs0Oat7fcEI85Lyo7Bnr58ikjPmpSYiys4?=
 =?us-ascii?Q?8LQbp7A/PgmniVCNo5fAZvoNTdvucHBDh09cofoWwNP0+oltwwu7timhrBfe?=
 =?us-ascii?Q?K9RWssj2ileYSMIIRShjyCZ9zDjYSsPg+tzdTiMax6/ZHxpUh9ch+jXHFvCS?=
 =?us-ascii?Q?mwBORIGysCHzBHWYu31GW+nTaELXWxmxdRQxKtck10F1uyPqYRO7/hH0mZaL?=
 =?us-ascii?Q?RGxDk40POGX+Jblt02/sdoRT5ChzjhPJ0YhfwKTUGF/HBRrMPB7OQzB53P8Y?=
 =?us-ascii?Q?jBxxro/xZ2/q8w58PoH0KiJeJq7sHz3psv/BL8y+M+NpfqWYSyWbNUsnRASg?=
 =?us-ascii?Q?/s6Khu/oSv1WvRvz5C0NxCLDBLOhJ5ODXkOncAjbZzM0fkFPSohdhtE42UGI?=
 =?us-ascii?Q?+J2HLODaWkamJDsQYkQ6Thk4DHwAX6uhM5weDUVsozQGEeXhba9QLiWRGOs7?=
 =?us-ascii?Q?SoNZHM6VQnMZOLp6nkeo9npXhAPDoXNR6hhiFSufa5Z9DoYjlW4Cs4b3N2nI?=
 =?us-ascii?Q?rGMtBsNynEKzY7jpuXImFXb261nRRUYy7IDeYr9+Eept/CvK5Xfxk2nKtr2V?=
 =?us-ascii?Q?db0zJ2EDRijrfLD+ZYAf8OuR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce06573-7bb6-49bb-5d90-08d910df9c5b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 22:38:03.7410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4hI1Wg2xnNUfR4nMVhYLYz+l7Q09t8akePnZ/qk/fpa14PIZQ2MjcsUzv/u/BKb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4034
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
Cc: David M Nieto <david.nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The proper metric for fence utilization over several
contexts is an harmonic mean, but such calculation is
prohibitive in kernel space, so the code approximates it.

Because the approximation diverges when one context has a
very small ratio compared with the other context, this change
filter out ratios smaller that 0.01%

Signed-off-by: David M Nieto <david.nieto@amd.com>
Change-Id: I5b6e0ce5f489a5f55855d35354a6a3653e9d613b
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 9036c93b4a0c..a26496735080 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -689,6 +689,8 @@ void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct amdgpu_ctx_entity *cen
 	}
 }
 
+#define FENCE_USAGE_MIN_RATIO(max, total) (max > 16384ULL*total)
+
 ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
 		uint32_t idx, uint64_t *elapsed)
 {
@@ -697,17 +699,29 @@ ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
 	uint32_t id;
 	struct amdgpu_ctx_entity *centity;
 	ktime_t total = 0, max = 0;
+	ktime_t ttotal = 0, tmax = 0;
+
 
 	if (idx >= AMDGPU_MAX_ENTITY_NUM)
 		return 0;
 	idp = &mgr->ctx_handles;
 	mutex_lock(&mgr->lock);
 	idr_for_each_entry(idp, ctx, id) {
+		ttotal = tmax = ktime_set(0, 0);
 		if (!ctx->entities[hwip][idx])
 			continue;
 
 		centity = ctx->entities[hwip][idx];
-		amdgpu_ctx_fence_time(ctx, centity, &total, &max);
+		amdgpu_ctx_fence_time(ctx, centity, &ttotal, &tmax);
+
+		/* Harmonic mean approximation diverges for very small
+		 * values. If ratio < 0.01% ignore
+		 */
+		if (FENCE_USAGE_MIN_RATIO(tmax, ttotal))
+			continue;
+
+		total = ktime_add(total, ttotal);
+		max = ktime_after(tmax, max) ? tmax : max;
 	}
 
 	mutex_unlock(&mgr->lock);
@@ -716,3 +730,5 @@ ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
 
 	return total;
 }
+
+#undef FENCE_USAGE_MIN_RATIO
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
