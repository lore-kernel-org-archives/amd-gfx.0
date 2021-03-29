Return-Path: <SRS0=y/UM=I3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B1DC433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 16:34:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A86A961960
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 16:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86A961960
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A4E96E431;
	Mon, 29 Mar 2021 16:34:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78F3C6E431
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Mar 2021 16:34:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAvky/TsWNHa4msxfZXY4T5V/cRbJrf9WXLxKnOwkNatq9yYkObyE+UMHzNWt5VHQZRqQzGNJfh7kKfor3eoILNUdNoe5CdB0apzFuOA5ALUJJEA0wzFCceNJ4aNyktUgn6GUYcXStYHfW1s6aNXIylaRfDGRomASDfvtHwkObMUj+L59OXn8OuuvqGiwDWAMF3WZYv1oo0l6i7Jl465XmEotFZ62xKCiCH2k7BHSLKiCugHle77dvhSL5uA3k7rRvna0C+/vReeW68Xw6WFnE4lAKt4PLzyvEQz7XSM+YziB96/N01jTeeVEsSqcNL2zQyu0JCf/rRdniyD10Ahzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENWcsgS57MAKTWavUC11yK1p08K5OrhXmLBMo3yBaUw=;
 b=RaEdHWxddRUuAwijdrKQrpZP6p0v81M1Ls8FDcVkvWO8cyL0R/26rq/9d7Hg+bC0ZhIm1CA63knwoGi9VSIOW1nam2YX/5Rm59vA7B7o25lvVybuqrVqLD6+9Rhrx5Ky4t9QlnfAsYxIiJJdom13ez9KykiWZRTAfNAmgF23U9WwX3va1AX2mPoGCVDQwwhbFlLNi+57dNBTz9Vt/D8QbtozgxBj+sPhMnyGWkIRw2b0HQXQJd1jd8117MSKScruaI2fL+6nUMC3p9pvExqlwQj5dJGxbUGQ7LtaZeGMH2MtsaBlzYS5Z9w0+bd4ClVz5REO+kcMhp7rH0vYsJDwuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENWcsgS57MAKTWavUC11yK1p08K5OrhXmLBMo3yBaUw=;
 b=KeBQgclJa6RFojxIpBVMxYwoXiWXWybTObXeX3jUnQEXqty3K4j6K40f+rci8kzgzUFuAJL5pSEM6KrjA7Sv0kRsBUZ1uMKVUzHMTDcr5WzRV9zR43azyqyRLdm5/1iJsiFWqW+NCShMJylyLvtKuFs74JPA8H2Z3OhOZYPKPlI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2581.namprd12.prod.outlook.com (2603:10b6:4:b2::36) by
 DM5PR12MB2584.namprd12.prod.outlook.com (2603:10b6:4:b0::37) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.25; Mon, 29 Mar 2021 16:34:39 +0000
Received: from DM5PR12MB2581.namprd12.prod.outlook.com
 ([fe80::214f:4f87:d6f9:c481]) by DM5PR12MB2581.namprd12.prod.outlook.com
 ([fe80::214f:4f87:d6f9:c481%6]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 16:34:39 +0000
From: Mike Li <Tianxinmike.Li@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Update L1 and add L2/3 cache information
Date: Mon, 29 Mar 2021 12:33:27 -0400
Message-Id: <20210329163327.7172-1-Tianxinmike.Li@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [2607:fea8:a261:1030:c3bc:69e0:9cfc:56d8]
X-ClientProxiedBy: YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::32) To DM5PR12MB2581.namprd12.prod.outlook.com
 (2603:10b6:4:b2::36)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mikeli-target-machine.amd.com
 (2607:fea8:a261:1030:c3bc:69e0:9cfc:56d8) by
 YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.33 via Frontend
 Transport; Mon, 29 Mar 2021 16:34:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e7a0bb6-3df3-44a4-bc02-08d8f2d08c46
X-MS-TrafficTypeDiagnostic: DM5PR12MB2584:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB25843EB8BC342E2604812486917E9@DM5PR12MB2584.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lCavXIWAfjHa3dGD6tki9pYeu3sZ3U9XzeCuY7Ar7PBQh9FlElZpgmjP/pB9Okknw5CzT1sZ6cV+v+gLi1mnjC6hVa79XGjtHjZ79aFVX9rRigktpbeRgTiWkAvThlqsIXcpEskpyXzK0WRy7nkzyyO0WbLTZxfBGUDmSmpRxcv57AbkSnZCwsYRrop/hq3zQO7/DtbEgvwGTRRzN3/ZHZaq+fhZypPnhfyMgXp4lzxjUFvsY7oKGqTBSKH9pPJ3BO8TEvC/cvuHi5ZpYq9qaNXlMOsV4kZIvQbDjN94buxyupd7LXPxVW/rR3p99lTyNhbul7An6JcgHeT6/7sgMNQAUODaKA40PSYgdN1F9yGH8w92VPKBfeDK57+5Uj+OYec9PaA/ADik2Mx2XGeBV92VHjSXHE/dH4RLSbDY67wLB2117ik7PjjdQdANyIQDNiE2bKHBVmHsjECf8Fn26hRDI4p8pYsLqMQC8rAheFud5XuBjFlk9oxXAEIdcVirKVksEvhURz13sWs8v5BnXb3Gw+Dhmx99WwsqyG2tuFHsgXBTofT/LYOBVHUcS8j/GhDa7AlVOFMLbc0/uzzS6I/B7rILnb0DKoHEiJ/VkjYOWkUvUDQt3i02YpWofCdTZY8Dxd1NZzP28DsOC4ruZm2OviUZgX+/7wtW5K8nRgo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2581.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(66476007)(2616005)(5660300002)(1076003)(66556008)(66946007)(6916009)(38100700001)(83380400001)(2906002)(4326008)(30864003)(186003)(16526019)(36756003)(478600001)(6666004)(8936002)(86362001)(7696005)(15650500001)(8676002)(52116002)(316002)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?y3g5O6gfdiZsXhrwZoUMUEiDvM+eEuX05J340I8+k9YcDCGH3WpLMmN6JwLC?=
 =?us-ascii?Q?rWKkQhnifdpUKGV4cunIQoouRY8Am5hif/ncjkomDgqLgn5cqDa1wxWjD93N?=
 =?us-ascii?Q?Mto3BZkUwp7qKAlAB8XxTdp14v3tUBHTaMTchLzvdDnFaBXPfifPUldOthyP?=
 =?us-ascii?Q?HakBaOnhPcGRfwTuy2x8Gknk9XHi0Y/adpYm0oGlEOmkq1IQOUKn3MO3pB/y?=
 =?us-ascii?Q?ZfQZBDyrKkVNaQ4qfWYOSOitjrLkwCgQAGL1FDbGhCejyQkEg3vp5hYK/hkz?=
 =?us-ascii?Q?H84z2OgdgKz91t0Un/N5f6kaFSR9MCyfCmI3BLj4l8leKNjaTQptFIHHp1C0?=
 =?us-ascii?Q?lcBAAMcEFrPRa7CL+Y8hwu33qQ0u4F/z475rRbvJBRXJH5H70KvBsX2MYUtf?=
 =?us-ascii?Q?YEzRao/jh+0Tku1a1FP5mlHEQCza1AH8J30mmWAqKjFJU3+2RXOuRpE30JaJ?=
 =?us-ascii?Q?XQ68ClgqCDMdAfcPtto6ygcrBKxyMcg7d8lHlYKmNx1rkcnKqxMiInPtN4LB?=
 =?us-ascii?Q?BuYBHdq2LVJ6e2c8jiklt/XdvwPUjaWUWIYqHnyoZrn/wvyqHFqb3LmUMYLf?=
 =?us-ascii?Q?hDlzkUG17j14AIWV/zNijAyVNOYDGQMdGnOakvUqlXSgiy0FCxv4fkGitN0f?=
 =?us-ascii?Q?5G9d6uN0sIXhI8IrjL1kCH/myFy8AntPeHTofItG9lhouUpC6MBZRNLoeO76?=
 =?us-ascii?Q?23mrmIR6dJNCJPmXeKjxDtMelu8H6DEdnWmsp8oOjaVxepg3lxI6l8wXEUnK?=
 =?us-ascii?Q?bLgpfhRnNFX7gN36bIhvAa1y2+l7VXUH3P5KT/zUpJ/TnkgDoh1s9EyIKBhX?=
 =?us-ascii?Q?9T2CdrL3JMgA/U7uD8wcnBzZaRgVLAl9bLcgKgxUWQgbcvz8DiTa0ETEKa9E?=
 =?us-ascii?Q?fLXsDeBSzyhfZ7Ra+MyFe+P/zJ6YncXgYZrf4kT4j1dzzH3xps6ZXOEmEfvX?=
 =?us-ascii?Q?HOG+neQ3TcmLwEVF/TP4N1JIgqscK6ugD0FC2ZpDIhQY7U8QLnVkmRERlhGC?=
 =?us-ascii?Q?CZzAcYlDzjf/iQOoX6T8XtV142K4b2nhrqdKiPmjczOWIyv7lg7m6lDiqYRv?=
 =?us-ascii?Q?YZPCgGXdEShEIl5rD2oVcrWJ+XdkNzNx2wGxtbMoNUh8g8RkTlepBypl0wth?=
 =?us-ascii?Q?C22+IYZdUucqhjcGDjJpVx1QrNmxW1eTis4syvQv+Mx02W2HAtykOmGFIru1?=
 =?us-ascii?Q?CRK4d+7u/ulkXQxesLHcha/F1seATngTxgC2qvifaZh+Q3omxf6t1Ay5W30M?=
 =?us-ascii?Q?/smM8RFRSLkuBXOPnpPkchgJfowJ6EJInYmIqnf8W82cPyyWN/3atC9n8TXB?=
 =?us-ascii?Q?KG0A8WS5gtz4bfQa0IY/evdooBmHz+AvfHq4nAsFaRswXpmuBTtMnAGOs6X9?=
 =?us-ascii?Q?Z66z3gmxE58uZ0k/cgORAYagW0a3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7a0bb6-3df3-44a4-bc02-08d8f2d08c46
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2581.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 16:34:39.6488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3nEblwYwoXzaaGkdAix2aN7CmkrJWKMJu5dXXJyA3YpZ0koH7Qk1YPPKS9E+8a07
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2584
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
Cc: felix.kuehling@amd.com, lijo.lazar@amd.com,
 Mike Li <Tianxinmike.Li@amd.com>, christian.koenig@amd.com,
 hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The L1 cache information has been updated and the L2/L3
information has been added. The changes have been made
for Vega10 and newer ASICs. There are no changes
for the older ASICs before Vega10.

BUG: SWDEV-260249

Signed-off-by: Mike Li <Tianxinmike.Li@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 749 ++++++++++++++++++++++++--
 1 file changed, 699 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index c60e82697385..eb30324393a8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -55,7 +55,7 @@ struct kfd_gpu_cache_info {
 	uint32_t	cache_level;
 	uint32_t	flags;
 	/* Indicates how many Compute Units share this cache
-	 * Value = 1 indicates the cache is not shared
+	 * within a SA. Value = 1 indicates the cache is not shared
 	 */
 	uint32_t	num_cu_shared;
 };
@@ -69,7 +69,6 @@ static struct kfd_gpu_cache_info kaveri_cache_info[] = {
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
 		.num_cu_shared = 1,
-
 	},
 	{
 		/* Scalar L1 Instruction Cache (in SQC module) per bank */
@@ -126,9 +125,6 @@ static struct kfd_gpu_cache_info carrizo_cache_info[] = {
 	/* TODO: Add L2 Cache information */
 };
 
-/* NOTE: In future if more information is added to struct kfd_gpu_cache_info
- * the following ASICs may need a separate table.
- */
 #define hawaii_cache_info kaveri_cache_info
 #define tonga_cache_info carrizo_cache_info
 #define fiji_cache_info  carrizo_cache_info
@@ -136,13 +132,562 @@ static struct kfd_gpu_cache_info carrizo_cache_info[] = {
 #define polaris11_cache_info carrizo_cache_info
 #define polaris12_cache_info carrizo_cache_info
 #define vegam_cache_info carrizo_cache_info
-/* TODO - check & update Vega10 cache details */
-#define vega10_cache_info carrizo_cache_info
-#define raven_cache_info carrizo_cache_info
-#define renoir_cache_info carrizo_cache_info
-/* TODO - check & update Navi10 cache details */
-#define navi10_cache_info carrizo_cache_info
-#define vangogh_cache_info carrizo_cache_info
+
+/* NOTE: L1 cache information has been updated and L2/L3
+ * cache information has been added for Vega10 and
+ * newer ASICs. The unit for cache_size is KiB.
+ * In future,  check & update cache details
+ * for every new ASIC is required.
+ */
+
+static struct kfd_gpu_cache_info vega10_cache_info[] = {
+	{
+		/* TCP L1 Cache per CU */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 1,
+	},
+	{
+		/* Scalar L1 Instruction Cache per SQC */
+		.cache_size = 32,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_INST_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 3,
+	},
+	{
+		/* Scalar L1 Data Cache per SQC */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 3,
+	},
+	{
+		/* L2 Data Cache per GPU (Total Tex Cache) */
+		.cache_size = 4096,
+		.cache_level = 2,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 16,
+	},
+};
+
+static struct kfd_gpu_cache_info raven_cache_info[] = {
+	{
+		/* TCP L1 Cache per CU */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 1,
+	},
+	{
+		/* Scalar L1 Instruction Cache per SQC */
+		.cache_size = 32,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_INST_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 3,
+	},
+	{
+		/* Scalar L1 Data Cache per SQC */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 3,
+	},
+	{
+		/* L2 Data Cache per GPU (Total Tex Cache) */
+		.cache_size = 1024,
+		.cache_level = 2,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 11,
+	},
+};
+
+static struct kfd_gpu_cache_info renoir_cache_info[] = {
+	{
+		/* TCP L1 Cache per CU */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 1,
+	},
+	{
+		/* Scalar L1 Instruction Cache per SQC */
+		.cache_size = 32,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_INST_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 3,
+	},
+	{
+		/* Scalar L1 Data Cache per SQC */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 3,
+	},
+	{
+		/* L2 Data Cache per GPU (Total Tex Cache) */
+		.cache_size = 1024,
+		.cache_level = 2,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 8,
+	},
+};
+
+static struct kfd_gpu_cache_info vega12_cache_info[] = {
+	{
+		/* TCP L1 Cache per CU */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 1,
+	},
+	{
+		/* Scalar L1 Instruction Cache per SQC */
+		.cache_size = 32,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_INST_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 3,
+	},
+	{
+		/* Scalar L1 Data Cache per SQC */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 3,
+	},
+	{
+		/* L2 Data Cache per GPU (Total Tex Cache) */
+		.cache_size = 2048,
+		.cache_level = 2,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 5,
+	},
+};
+
+static struct kfd_gpu_cache_info vega20_cache_info[] = {
+	{
+		/* TCP L1 Cache per CU */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 1,
+	},
+	{
+		/* Scalar L1 Instruction Cache per SQC */
+		.cache_size = 32,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_INST_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 3,
+	},
+	{
+		/* Scalar L1 Data Cache per SQC */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 3,
+	},
+	{
+		/* L2 Data Cache per GPU (Total Tex Cache) */
+		.cache_size = 8192,
+		.cache_level = 2,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 16,
+	},
+};
+
+static struct kfd_gpu_cache_info aldebaran_cache_info[] = {
+	{
+		/* TCP L1 Cache per CU */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 1,
+	},
+	{
+		/* Scalar L1 Instruction Cache per SQC */
+		.cache_size = 32,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_INST_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 2,
+	},
+	{
+		/* Scalar L1 Data Cache per SQC */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 2,
+	},
+	{
+		/* L2 Data Cache per GPU (Total Tex Cache) */
+		.cache_size = 8192,
+		.cache_level = 2,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 14,
+	},
+};
+
+static struct kfd_gpu_cache_info navi10_cache_info[] = {
+	{
+		/* TCP L1 Cache per CU */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 1,
+	},
+	{
+		/* Scalar L1 Instruction Cache per SQC */
+		.cache_size = 32,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_INST_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 2,
+	},
+	{
+		/* Scalar L1 Data Cache per SQC */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 2,
+	},
+	{
+		/* GL1 Data Cache per SA */
+		.cache_size = 128,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 10,
+	},
+	{
+		/* L2 Data Cache per GPU (Total Tex Cache) */
+		.cache_size = 4096,
+		.cache_level = 2,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 10,
+	},
+};
+
+static struct kfd_gpu_cache_info vangogh_cache_info[] = {
+	{
+		/* TCP L1 Cache per CU */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 1,
+	},
+	{
+		/* Scalar L1 Instruction Cache per SQC */
+		.cache_size = 32,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_INST_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 2,
+	},
+	{
+		/* Scalar L1 Data Cache per SQC */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 2,
+	},
+	{
+		/* GL1 Data Cache per SA */
+		.cache_size = 128,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 8,
+	},
+	{
+		/* L2 Data Cache per GPU (Total Tex Cache) */
+		.cache_size = 1024,
+		.cache_level = 2,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 8,
+	},
+};
+
+static struct kfd_gpu_cache_info navi14_cache_info[] = {
+	{
+		/* TCP L1 Cache per CU */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 1,
+	},
+	{
+		/* Scalar L1 Instruction Cache per SQC */
+		.cache_size = 32,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_INST_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 2,
+	},
+	{
+		/* Scalar L1 Data Cache per SQC */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 2,
+	},
+	{
+		/* GL1 Data Cache per SA */
+		.cache_size = 128,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 12,
+	},
+	{
+		/* L2 Data Cache per GPU (Total Tex Cache) */
+		.cache_size = 2048,
+		.cache_level = 2,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 12,
+	},
+};
+
+static struct kfd_gpu_cache_info sienna_cichlid_cache_info[] = {
+	{
+		/* TCP L1 Cache per CU */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 1,
+	},
+	{
+		/* Scalar L1 Instruction Cache per SQC */
+		.cache_size = 32,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_INST_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 2,
+	},
+	{
+		/* Scalar L1 Data Cache per SQC */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 2,
+	},
+	{
+		/* GL1 Data Cache per SA */
+		.cache_size = 128,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 10,
+	},
+	{
+		/* L2 Data Cache per GPU (Total Tex Cache) */
+		.cache_size = 4096,
+		.cache_level = 2,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 10,
+	},
+	{
+		/* L3 Data Cache per GPU */
+		.cache_size = 128*1024,
+		.cache_level = 3,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 10,
+	},
+};
+
+static struct kfd_gpu_cache_info navy_flounder_cache_info[] = {
+	{
+		/* TCP L1 Cache per CU */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 1,
+	},
+	{
+		/* Scalar L1 Instruction Cache per SQC */
+		.cache_size = 32,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_INST_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 2,
+	},
+	{
+		/* Scalar L1 Data Cache per SQC */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 2,
+	},
+	{
+		/* GL1 Data Cache per SA */
+		.cache_size = 128,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 10,
+	},
+	{
+		/* L2 Data Cache per GPU (Total Tex Cache) */
+		.cache_size = 3072,
+		.cache_level = 2,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 10,
+	},
+	{
+		/* L3 Data Cache per GPU */
+		.cache_size = 96*1024,
+		.cache_level = 3,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 10,
+	},
+};
+
+static struct kfd_gpu_cache_info dimgrey_cavefish_cache_info[] = {
+	{
+		/* TCP L1 Cache per CU */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 1,
+	},
+	{
+		/* Scalar L1 Instruction Cache per SQC */
+		.cache_size = 32,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_INST_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 2,
+	},
+	{
+		/* Scalar L1 Data Cache per SQC */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 2,
+	},
+	{
+		/* GL1 Data Cache per SA */
+		.cache_size = 128,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 8,
+	},
+	{
+		/* L2 Data Cache per GPU (Total Tex Cache) */
+		.cache_size = 2048,
+		.cache_level = 2,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 8,
+	},
+	{
+		/* L3 Data Cache per GPU */
+		.cache_size = 32*1024,
+		.cache_level = 3,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 8,
+	},
+};
 
 static void kfd_populated_cu_info_cpu(struct kfd_topology_device *dev,
 		struct crat_subtype_computeunit *cu)
@@ -544,7 +1089,7 @@ int kfd_parse_crat_table(void *crat_image, struct list_head *device_list,
 }
 
 /* Helper function. See kfd_fill_gpu_cache_info for parameter description */
-static int fill_in_pcache(struct crat_subtype_cache *pcache,
+static int fill_in_l1_pcache(struct crat_subtype_cache *pcache,
 				struct kfd_gpu_cache_info *pcache_info,
 				struct kfd_cu_info *cu_info,
 				int mem_available,
@@ -597,6 +1142,70 @@ static int fill_in_pcache(struct crat_subtype_cache *pcache,
 	return 1;
 }
 
+/* Helper function. See kfd_fill_gpu_cache_info for parameter description */
+static int fill_in_l2_l3_pcache(struct crat_subtype_cache *pcache,
+				struct kfd_gpu_cache_info *pcache_info,
+				struct kfd_cu_info *cu_info,
+				int mem_available,
+				int cache_type, unsigned int cu_processor_id)
+{
+	unsigned int cu_sibling_map_mask;
+	int first_active_cu;
+	int i, j, k;
+
+	/* First check if enough memory is available */
+	if (sizeof(struct crat_subtype_cache) > mem_available)
+		return -ENOMEM;
+
+	cu_sibling_map_mask = cu_info->cu_bitmap[0][0];
+	cu_sibling_map_mask &=
+		((1 << pcache_info[cache_type].num_cu_shared) - 1);
+	first_active_cu = ffs(cu_sibling_map_mask);
+
+	/* CU could be inactive. In case of shared cache find the first active
+	 * CU. and incase of non-shared cache check if the CU is inactive. If
+	 * inactive active skip it
+	 */
+	if (first_active_cu) {
+		memset(pcache, 0, sizeof(struct crat_subtype_cache));
+		pcache->type = CRAT_SUBTYPE_CACHE_AFFINITY;
+		pcache->length = sizeof(struct crat_subtype_cache);
+		pcache->flags = pcache_info[cache_type].flags;
+		pcache->processor_id_low = cu_processor_id
+					 + (first_active_cu - 1);
+		pcache->cache_level = pcache_info[cache_type].cache_level;
+		pcache->cache_size = pcache_info[cache_type].cache_size;
+
+		/* Sibling map is w.r.t processor_id_low, so shift out
+		 * inactive CU
+		 */
+		cu_sibling_map_mask =
+			cu_sibling_map_mask >> (first_active_cu - 1);
+		k = 0;
+		for (i = 0; i < cu_info->num_shader_engines; i++) {
+			for (j = 0; j < cu_info->num_shader_arrays_per_engine;
+				j++) {
+				pcache->sibling_map[k] =
+				 (uint8_t)(cu_sibling_map_mask & 0xFF);
+				pcache->sibling_map[k+1] =
+				 (uint8_t)((cu_sibling_map_mask >> 8) & 0xFF);
+				pcache->sibling_map[k+2] =
+				 (uint8_t)((cu_sibling_map_mask >> 16) & 0xFF);
+				pcache->sibling_map[k+3] =
+				 (uint8_t)((cu_sibling_map_mask >> 24) & 0xFF);
+				k += 4;
+				cu_sibling_map_mask =
+					cu_info->cu_bitmap[i % 4][j + i / 4];
+				cu_sibling_map_mask &= (
+				 (1 << pcache_info[cache_type].num_cu_shared)
+				 - 1);
+			}
+		}
+		return 0;
+	}
+	return 1;
+}
+
 /* kfd_fill_gpu_cache_info - Fill GPU cache info using kfd_gpu_cache_info
  * tables
  *
@@ -624,6 +1233,7 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
 	int mem_available = available_size;
 	unsigned int cu_processor_id;
 	int ret;
+	unsigned int num_cu_shared;
 
 	switch (kdev->device_info->asic_family) {
 	case CHIP_KAVERI:
@@ -663,12 +1273,21 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
 		num_of_cache_types = ARRAY_SIZE(vegam_cache_info);
 		break;
 	case CHIP_VEGA10:
+		pcache_info = vega10_cache_info;
+		num_of_cache_types = ARRAY_SIZE(vega10_cache_info);
+		break;
 	case CHIP_VEGA12:
+		pcache_info = vega12_cache_info;
+		num_of_cache_types = ARRAY_SIZE(vega12_cache_info);
+		break;
 	case CHIP_VEGA20:
 	case CHIP_ARCTURUS:
+		pcache_info = vega20_cache_info;
+		num_of_cache_types = ARRAY_SIZE(vega20_cache_info);
+		break;
 	case CHIP_ALDEBARAN:
-		pcache_info = vega10_cache_info;
-		num_of_cache_types = ARRAY_SIZE(vega10_cache_info);
+		pcache_info = aldebaran_cache_info;
+		num_of_cache_types = ARRAY_SIZE(aldebaran_cache_info);
 		break;
 	case CHIP_RAVEN:
 		pcache_info = raven_cache_info;
@@ -680,12 +1299,24 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
 		break;
 	case CHIP_NAVI10:
 	case CHIP_NAVI12:
+		pcache_info = navi10_cache_info;
+		num_of_cache_types = ARRAY_SIZE(navi10_cache_info);
+		break;
 	case CHIP_NAVI14:
+		pcache_info = navi14_cache_info;
+		num_of_cache_types = ARRAY_SIZE(navi14_cache_info);
+		break;
 	case CHIP_SIENNA_CICHLID:
+		pcache_info = sienna_cichlid_cache_info;
+		num_of_cache_types = ARRAY_SIZE(sienna_cichlid_cache_info);
+		break;
 	case CHIP_NAVY_FLOUNDER:
+		pcache_info = navy_flounder_cache_info;
+		num_of_cache_types = ARRAY_SIZE(navy_flounder_cache_info);
+		break;
 	case CHIP_DIMGREY_CAVEFISH:
-		pcache_info = navi10_cache_info;
-		num_of_cache_types = ARRAY_SIZE(navi10_cache_info);
+		pcache_info = dimgrey_cavefish_cache_info;
+		num_of_cache_types = ARRAY_SIZE(dimgrey_cavefish_cache_info);
 		break;
 	case CHIP_VANGOGH:
 		pcache_info = vangogh_cache_info;
@@ -709,40 +1340,58 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
 	 */
 
 	for (ct = 0; ct < num_of_cache_types; ct++) {
-		cu_processor_id = gpu_processor_id;
-		for (i = 0; i < cu_info->num_shader_engines; i++) {
-			for (j = 0; j < cu_info->num_shader_arrays_per_engine;
-				j++) {
-				for (k = 0; k < cu_info->num_cu_per_sh;
-					k += pcache_info[ct].num_cu_shared) {
-
-					ret = fill_in_pcache(pcache,
-						pcache_info,
-						cu_info,
-						mem_available,
-						cu_info->cu_bitmap[i % 4][j + i / 4],
-						ct,
-						cu_processor_id,
-						k);
-
-					if (ret < 0)
-						break;
-
-					if (!ret) {
-						pcache++;
-						(*num_of_entries)++;
-						mem_available -=
-							sizeof(*pcache);
-						(*size_filled) +=
-							sizeof(*pcache);
-					}
-
-					/* Move to next CU block */
-					cu_processor_id +=
-						pcache_info[ct].num_cu_shared;
-				}
-			}
+	  cu_processor_id = gpu_processor_id;
+	  if (pcache_info[ct].cache_level == 1) {
+	    for (i = 0; i < cu_info->num_shader_engines; i++) {
+	      for (j = 0; j < cu_info->num_shader_arrays_per_engine; j++) {
+	        for (k = 0; k < cu_info->num_cu_per_sh;
+		  k += pcache_info[ct].num_cu_shared) {
+		  ret = fill_in_l1_pcache(pcache,
+					pcache_info,
+					cu_info,
+					mem_available,
+					cu_info->cu_bitmap[i % 4][j + i / 4],
+					ct,
+					cu_processor_id,
+					k);
+
+		  if (ret < 0)
+			break;
+
+		  if (!ret) {
+				pcache++;
+				(*num_of_entries)++;
+				mem_available -= sizeof(*pcache);
+				(*size_filled) += sizeof(*pcache);
+		  }
+
+		  /* Move to next CU block */
+		  num_cu_shared = ((k + pcache_info[ct].num_cu_shared) <=
+					cu_info->num_cu_per_sh) ?
+					pcache_info[ct].num_cu_shared :
+					(cu_info->num_cu_per_sh - k);
+		  cu_processor_id += num_cu_shared;
 		}
+	      }
+	    }
+	  } else {
+			ret = fill_in_l2_l3_pcache(pcache,
+				pcache_info,
+				cu_info,
+				mem_available,
+				ct,
+				cu_processor_id);
+
+			if (ret < 0)
+				break;
+
+			if (!ret) {
+				pcache++;
+				(*num_of_entries)++;
+				mem_available -= sizeof(*pcache);
+				(*size_filled) += sizeof(*pcache);
+			}
+	  }
 	}
 
 	pr_debug("Added [%d] GPU cache entries\n", *num_of_entries);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
