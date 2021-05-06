Return-Path: <SRS0=uqaI=KB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB80DC433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 09:55:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 615C661157
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 09:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615C661157
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEE606E193;
	Thu,  6 May 2021 09:55:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E43F6E193
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 May 2021 09:55:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvfqM5VdRZrrDqsxBfaO4J/C0mPEZ9vd/Z/119ZtGKRDem0/2iYyvRItEhzeFEO/eg9Abesq3MjU9hhEbglmYnMSXiub9pjkhjxfXlwraWxUp/5K5u4Y73RnEEq6nIVS1hmPzTBzT61jDocsPSLro9XlkXvPMG0B4quAcJ8YuM+DtrYRqTTAyar5uMQKzRDnANoC4P9QFmvxOWIKefUyDF1L8Msd4Z0UNW/399BvYXU80bsFsFPoS7/eP/Ie8Imzx8WqjdXJzqJFwyNpZEwMdJSFYnZvyEhTkDqA5o8bBmj2lJ9/2Hhj9yF3xBTWFME7sul8a1/C8cS3F97F5AqvpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hX6DqTAHkeOviMnY3v9adUvqRGDxk1DqBl6ZQGxhXz0=;
 b=SGkBXoi1Bcdcjz8yRGQfR4uSfDMO4H1v+MiF5fA6fKocW6Qr6HY0wWLzBQ8EGPk9GJZYmPgwRnUIeR08URE+sdZOKCeai05dlAkXK+jda87PpWA2hORS4AaT4d8jnb9PR7Rr4YKZLe4JovZm2NqMQP65RoaYemTvNQlViHkONsX1HsyraQVv3z80nIn2pX9Wmb4MYnGh70jgE0lTbKSifM1UzaHCOxeCZNiI61BOQkWHa9RQ70/32MME7XLL38bSJnpMUIFAMCNIYK153BRTzxPl6KIzfV8sAf6sWOuAJRT4t1Fpvh21CnK2P4fukFyp5We/mnZOEaVhNG00eAKx2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hX6DqTAHkeOviMnY3v9adUvqRGDxk1DqBl6ZQGxhXz0=;
 b=ErVRfQnFNrX6ZNi0ewmxiIMS7ISP8znsYmvD/6b7srvTgKCv0+oih4UeY9uhbK4rPh33B8tY7yA93Lz/MYncG58jSftIBpA1nrGCF4n64wlDUcyHEU7ExrfFHXhVv+LwQZqdrMffGyyNhO5mXRcF7z/iRO/XKLwnojxw+yWha08=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1414.namprd12.prod.outlook.com (2603:10b6:903:3a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 09:55:27 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::50b1:6f8a:9b37:8835]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::50b1:6f8a:9b37:8835%4]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 09:55:27 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, lang.yu@amd.com, ray.huang@amd.com,
 asher.song@amd.com
Subject: [PATCH libdrm] Revert "tests/amdgpu: fix bo eviction test issue"
Date: Thu,  6 May 2021 17:55:09 +0800
Message-Id: <20210506095509.7815-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2P15301CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::21) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (180.167.199.189) by
 HK2P15301CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.1 via Frontend Transport; Thu, 6 May 2021 09:55:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edb589c4-3cf9-4fe3-96ec-08d910751345
X-MS-TrafficTypeDiagnostic: CY4PR12MB1414:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB14144A92C56D1FD7DAF7060FF1589@CY4PR12MB1414.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:28;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: czsJT7iwy8s+DXSsNECEl4qlD569bFr6U8geiKoEg6jZJ5zo2/51wMUCWUE67tAGScoTTjpvTULX/l5wAH47y75k1llT28149LWq5u0Fspvg55BOByzQ7/Fyv6sU5ScJBwxgxUDA6WgHjgz66Vlt1suZK7TPG4qv0rlQJyxsDEyB5w2qK3u834O7Xc9ASyvnJn23DKvauILA/1cXtWILrBHOFNui4HL6O1xB+1EtC4NQH1j5hPqkvRbMGC9M42CFs2/Lc/6XJRGNb8eURLRxiPKhd0kUSch0GSB2BxBW/owMW1YxS00uwnyu3DBz/BTVXFDDGoSzzjvug0QfokJJCl0JTWd84WRZcvP5lwSDbpbSD39XmPbRpbwikFhOzwR5JSXclLefHHegSrPF2I9Vpl+ywUGLt4HQ1181PVHUaccZFM6w169lvxJAU5tNrs5Tu0oMZVbKXeg9GFjMGNP4b+ilkIUW4+k5cXTOMVqElX/QC8lWJ5O6usyFrOXfk2giPte97uyLGnhnrzaHrX6m3g8Tpzn7FQ/nJdRetkGjtLFoMiN7C96ieqo0qHh+KftZ15CghNP4tbt9iwOfq3lsYLpomdVUK2kcxZp5cfT/GuLQJjpSkGLzckbItCPiKt4xju4VS8f+V58e8YdiKEuW0Zy9fqkEvNPtgThpFTaBv4o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(4326008)(6666004)(956004)(6636002)(2906002)(44832011)(2616005)(66946007)(66476007)(478600001)(83380400001)(316002)(66556008)(52116002)(38350700002)(26005)(186003)(16526019)(7696005)(36756003)(5660300002)(86362001)(38100700002)(8676002)(6486002)(1076003)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?33mlz5EQsHyjiJLSz8oWkzKa6nLfGs7TCY3ZNojUcRxeL2cWy7o4BoDppmzf?=
 =?us-ascii?Q?yygJLJWG1gp6tYfF5PR4AMOdL0B0G0z8ayxtT7Ws5FWYI98BdxYsUGeXccwp?=
 =?us-ascii?Q?hk6Vkmpa1qenlOKnkaVcMTNbeZcn3kklOwmTdxl5F87dR1ibqHA0WLImgruM?=
 =?us-ascii?Q?KtKqFPhEWqTC227Y3KJrPPNCwev+pgjFPz3AKF61m7E4R1piUfz0l04X9EBV?=
 =?us-ascii?Q?9Qy1lb/eGSqJh5V7VRHwTIVZvoho+tpQbTbwnHAiouBiYqH2SikFLFbMy66x?=
 =?us-ascii?Q?ugS1f6wGIjqPv/nfMBeXXkBo41EhVRLeM+r4K7cRhIuVbgbetSe2KCDlyo22?=
 =?us-ascii?Q?ZV004chKunflFIT8zByK03zF+3yhq27vOXb34iU8FlY4hartH2dvGvWpX2iO?=
 =?us-ascii?Q?JYIoFPQdW6SsyAwKJ9dPnaCs25MVFxO9H8GWWRi3MgCwNLmTCVtDEZoDZb9Z?=
 =?us-ascii?Q?LNcQd9rRuidi0PyDyppJda4J/Frl40UIr6lUpQwU0KvWFrkqjaSPpa/5OuQh?=
 =?us-ascii?Q?CjrjFiwTMOX4Rtcb5+B2fRSvW8qmnjZp643nDINvr7CqZj+0h8liAnzlh7Pl?=
 =?us-ascii?Q?PNB0g23lAIyFRgNmbJmP+winSDkSAfVb7QVIE2xnpeST6/nsjCcsXs+bnbaM?=
 =?us-ascii?Q?kBs+HsOapkHrHpOSPEMi0B+9KTAVJI/I/sRFL+tTAUu5XTf7fu0gIILVR3lR?=
 =?us-ascii?Q?8xN+U9aoF0NGi96FPnNVUoE7aAEM4TMwnKAF2jQCmQwLGYuG+mF2/8zXVXjh?=
 =?us-ascii?Q?+nBDCQUx65Najz0VQJ8o4ndDnKrU1br2sxZm04jl97EPmbuugFV8LGd0oGgB?=
 =?us-ascii?Q?1f0aFerTiUYritzMPgAt1UXfONhXEz493oAJHl1cn2KRzHmC89j3E/SDS54E?=
 =?us-ascii?Q?0O1gyVFv+IVoFGWitpyq/jfrNEDyYBs1f5S/mXk+XsSa/RNB+v+M4AO6Mx08?=
 =?us-ascii?Q?OiGCUN3WvWanB3sGtEiKE0fjDWB1xmOxe9IPTLQTQyh2POyoKbDEAf4RPPNh?=
 =?us-ascii?Q?Dn3ekht8bACXCPGrzxXPEh2Kgkf8dZiL2TgibePRv2IFVliljURH85UKMyY0?=
 =?us-ascii?Q?Jsz/WHMxEjPGdZnXrS1hi2dZky5gHtd94izBqlvhsjJ6vTj4It8rrOr4ODLy?=
 =?us-ascii?Q?EwpG3YDzFVuasMNLKk/uOWaqNc7zkLK6WDQnGBbVXGoIgl5wXx+2Ay7p5L+U?=
 =?us-ascii?Q?3m6av4OODThUGyaqOwQv85AqEVTnwFaVizE6vBzYfEZeWg1TNuFLAAMY9XOg?=
 =?us-ascii?Q?7dUXeFTIwOtGtvERzOi+F5yX2DYQIU2wTdpVcepDfXecpGxdnf2PEKFs+tCN?=
 =?us-ascii?Q?cuxs3mYGzCR540CyhaZ41mybJ2CVqRApcGqKF1lsRoki0Q=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb589c4-3cf9-4fe3-96ec-08d910751345
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 09:55:27.1541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbjvjGxDclMq4DcJThTr2rJHFogXSTFXwigWJ112VN8M4viH9aHpmGwVTeT2FaF9J/698cBNJNqQ9v3sWZDGhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1414
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit a5a400c9581c3b91598623603067556b18084c5d.

bo evict test was disabled by default per below commit. So still keep it
as disabled.

1f6a85cc test/amdgpu: disable bo eviction test by default

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 tests/amdgpu/amdgpu_test.c |  3 +++
 tests/amdgpu/basic_tests.c | 13 ++++---------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/tests/amdgpu/amdgpu_test.c b/tests/amdgpu/amdgpu_test.c
index 60f3a508..77bbfbcc 100644
--- a/tests/amdgpu/amdgpu_test.c
+++ b/tests/amdgpu/amdgpu_test.c
@@ -496,6 +496,9 @@ static void amdgpu_disable_suites()
 				"gfx ring slow bad draw test (set amdgpu.lockup_timeout=50)", CU_FALSE))
 			fprintf(stderr, "test deactivation failed - %s\n", CU_get_error_msg());
 
+	if (amdgpu_set_test_active(BASIC_TESTS_STR, "bo eviction Test", CU_FALSE))
+		fprintf(stderr, "test deactivation failed - %s\n", CU_get_error_msg());
+
 	/* This test was ran on GFX8 and GFX9 only */
 	if (family_id < AMDGPU_FAMILY_VI || family_id > AMDGPU_FAMILY_RV)
 		if (amdgpu_set_test_active(BASIC_TESTS_STR, "Sync dependency Test", CU_FALSE))
diff --git a/tests/amdgpu/basic_tests.c b/tests/amdgpu/basic_tests.c
index 8e7c4916..3a4214f5 100644
--- a/tests/amdgpu/basic_tests.c
+++ b/tests/amdgpu/basic_tests.c
@@ -928,15 +928,6 @@ static void amdgpu_bo_eviction_test(void)
 				   0, &vram_info);
 	CU_ASSERT_EQUAL(r, 0);
 
-	r = amdgpu_query_heap_info(device_handle, AMDGPU_GEM_DOMAIN_GTT,
-				   0, &gtt_info);
-	CU_ASSERT_EQUAL(r, 0);
-
-	if (vram_info.max_allocation > gtt_info.heap_size/3) {
-		vram_info.max_allocation = gtt_info.heap_size/3;
-		gtt_info.max_allocation = vram_info.max_allocation;
-	}
-
 	r = amdgpu_bo_alloc_wrap(device_handle, vram_info.max_allocation, 4096,
 				 AMDGPU_GEM_DOMAIN_VRAM, 0, &vram_max[0]);
 	CU_ASSERT_EQUAL(r, 0);
@@ -944,6 +935,10 @@ static void amdgpu_bo_eviction_test(void)
 				 AMDGPU_GEM_DOMAIN_VRAM, 0, &vram_max[1]);
 	CU_ASSERT_EQUAL(r, 0);
 
+	r = amdgpu_query_heap_info(device_handle, AMDGPU_GEM_DOMAIN_GTT,
+				   0, &gtt_info);
+	CU_ASSERT_EQUAL(r, 0);
+
 	r = amdgpu_bo_alloc_wrap(device_handle, gtt_info.max_allocation, 4096,
 				 AMDGPU_GEM_DOMAIN_GTT, 0, &gtt_max[0]);
 	CU_ASSERT_EQUAL(r, 0);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
