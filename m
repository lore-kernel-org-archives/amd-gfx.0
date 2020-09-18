Return-Path: <SRS0=nko/=C3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964A9C43464
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 17:32:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA5321734
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 17:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FE/cpyap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA5321734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A43276ED5C;
	Fri, 18 Sep 2020 17:32:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D4B56ED5C
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2020 17:31:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLI/QutgQhTIYeupRUyIi6QyAUuxmTyDXvDsjeTVtTxZpLUe08Y/oO5S0wFbYVFWa3xUJMmFLsodGlilgKvgvb/alZRTD/vo7Pf72K+o+ucVj/KOBcMxxCHMUQsHetrOwwIG4oEWD+Xi+4x8YAaIJMSHgi/8WhBNOZJIV/+8SiVA5kiYnBK+bVEX3PjQTZ+G5qvIpjTc473uGA/lbv6F0goyp1WA2JEhoxhkiA9z5r6g0OZtxIQ/YeVucVp7cFtgp2JGYnGMFCPLXKIGgcB3RAKzIxtzsdl93c5eUvIE6S6Ncxn0lWqjxPd8oM+8URNnO5s1/8QzrL/2SvLtymk0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E27JEHlJM+tepMM+iXOR+EC5BAjfnd7FPZEgoM/6yeA=;
 b=RRdi7NqV7nBxjp6fO2lK89I0jAT30auwPLNC1NzycyLUFNdA+r3RqDUbRylTTMQdFIhKoM+RDFfVnt0Tj2i/Bs0+AzG9kHsrG97r+tk+1/tXLfyTtS4lxRbZ5WJ3zcPO/eBiuCNJMFSUbhFaXBFf2s8o7EFcG/c6zkSSRedZyfo5fvblMCgmVnebUfbLnruf3UwmT7qnzJDkwQoboXvsJMgLLEV3aeJ4wrTlWmD/oMpifiOD6+OyO6y4WG2j+G3keYeHLPnfVh1Ow6t502O//KQs76QX70vjaju11TswqwkFaFmMDzQPSwiiq0wqxFGlzPZ8z3Slo1izmNyGDVOaxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E27JEHlJM+tepMM+iXOR+EC5BAjfnd7FPZEgoM/6yeA=;
 b=FE/cpyapHLz2orvqUJVEU73kQ1K9GheJDyz38ZrVLXoxaT81x9tWfiLSimS2077uHYvqjrlxIXTZ2XbHeWsh8pf6C4ae7lfeYSECca2B9k1YaN+HhlFmHxnNCsefpCgjCwgtZUY0zxm8Q25IHr+0PcX3oCqdp6Xx0IGApaVjBcs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM5PR12MB1676.namprd12.prod.outlook.com (2603:10b6:4:8::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Fri, 18 Sep 2020 17:31:56 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1%4]) with mapi id 15.20.3391.014; Fri, 18 Sep 2020
 17:31:56 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Calculate CPU VCRAT size dynamically
Date: Fri, 18 Sep 2020 13:31:42 -0400
Message-Id: <20200918173142.11287-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::33) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YTXPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Fri, 18 Sep 2020 17:31:56 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e9d5a9e0-c21b-4dbb-9eb3-08d85bf8bd85
X-MS-TrafficTypeDiagnostic: DM5PR12MB1676:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1676480883E7F8B019CC4952853F0@DM5PR12MB1676.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wsyu9a02JncFRPB9rnfj4HC57+l17tYy3Jvo8s/4LuAuuIENsnVwlWzz+md95Ywo/6g4TKY8Ft/E80PIEtfBtREVUAyPYBtmfia+rxTKEKvs90wT24Nqd3YbgKD851PA1Omy2aetqlpLj/TUPeNrzz8b4UKEOpN6IMx0SuJakoL8d2dpf3HrNw+lkOw9gyVCUc2zOOeNRgT/bCN38e8O6YzsdSz7ENvVSgfFZjGwIciUyaGNOWfVpHGbQERxdUp+x6tnKK+aAsC7KhXAxIuxN4m2DpSxX/W0ZiRBjJI2csA24bYGECjxZp/0YQJXX+AoFQHENHHbrbPzk/AWm5ZPoEbSqFRCE5wNXo2bPIgUFds7vXrp11ST+uMPT11vRb+a
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(5660300002)(16526019)(86362001)(8936002)(7696005)(6486002)(52116002)(186003)(8676002)(316002)(478600001)(2616005)(2906002)(66946007)(956004)(66556008)(66476007)(44832011)(6916009)(1076003)(36756003)(26005)(83380400001)(6666004)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: cavlj0EruD9MIm1GHUJoyi1qAq2HWx6UrgyaTWRecq3BMQnD39iYKwGJVtCssx7JL1J/SO2tkSLUOgp0N6Zics7UcIymzPt8YYOaci1XuOn88AC3/PBYnOQP8uY/al//2/c8m3wIN07nsGVsUDfNpjRWmMo4LGTS1eFVMEXGRH/bYcM+l90ghcExDxjIQqeKw21F6SX9Kdf3dzPOqX4ukt6S01qxAJ7a3U3D3ydSruzCrJNYX9ZkSqPSS4cDDDX25KTGA1ywtTyx0se9Y5hTxdmGDTV1e863BnxP+/8Rcfyh6wRDxt1v8GLwfK+APb+j+HQEavkgrcRjAykahmntUgDyD3JU9T27gO4nxT+lCqERabPFAkceVM92okjqscj2HYc6Z7rkKE9hfBN9MgHjTJ17EOGFX4TH5ugnFmXyyfDhJulT5mGhGottwIFbZofK0p4U87vDxbfC+xf3kx9tMYm1sDEwLO/1e3ee5hz+GTIDp7WeKuxL4t25raEbDwJKpHwyb3YcEI6lRW8MhtrrES0KmcrMc36Cfy5WUs912dbrmGdhxfs+26XSTour+acf0VLs9qQ7roX9nbSntDRGHoopIKz9qYjt7sXznTMuYcUHtplsz4KOjLCqhmiRIHUvutFeR2Ni7XSdRNaDv4mDzw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d5a9e0-c21b-4dbb-9eb3-08d85bf8bd85
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 17:31:56.5091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h52wLNJstnkP/2NoixIkWFrxnjHyHj+wyPbhZ7n1eU8mgPt8SwlHdRHJhyTGerJzeO13KPRFfKkGuIwzslHSSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1676
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of guessing at a sufficient size for the CPU VCRAT, base the
size on the number of online NUMA nodes.

Signed-off-by: Kent Russell <kent.russell@amd.com>
Change-Id: I5fb6e60f1410ad696ab78d780d0b40d01a4f829b
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 3fac06b281ce..99182b8e9152 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -809,11 +809,10 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
 
 /* Memory required to create Virtual CRAT.
  * Since there is no easy way to predict the amount of memory required, the
- * following amount are allocated for CPU and GPU Virtual CRAT. This is
+ * following amount is allocated for GPU Virtual CRAT. This is
  * expected to cover all known conditions. But to be safe additional check
  * is put in the code to ensure we don't overwrite.
  */
-#define VCRAT_SIZE_FOR_CPU	(2 * PAGE_SIZE)
 #define VCRAT_SIZE_FOR_GPU	(4 * PAGE_SIZE)
 
 /* kfd_fill_cu_for_cpu - Fill in Compute info for the given CPU NUMA node
@@ -964,7 +963,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 #endif
 	int ret = 0;
 
-	if (!pcrat_image || avail_size < VCRAT_SIZE_FOR_CPU)
+	if (!pcrat_image)
 		return -EINVAL;
 
 	/* Fill in CRAT Header.
@@ -1364,24 +1363,31 @@ int kfd_create_crat_image_virtual(void **crat_image, size_t *size,
 				  uint32_t proximity_domain)
 {
 	void *pcrat_image = NULL;
-	int ret = 0;
+	int ret = 0, num_nodes;
+	size_t dyn_size;
 
 	if (!crat_image)
 		return -EINVAL;
 
 	*crat_image = NULL;
 
-	/* Allocate one VCRAT_SIZE_FOR_CPU for CPU virtual CRAT image and
-	 * VCRAT_SIZE_FOR_GPU for GPU virtual CRAT image. This should cover
-	 * all the current conditions. A check is put not to overwrite beyond
-	 * allocated size
+	/* Allocate the CPU Virtual CRAT size based on the number of online
+	 * nodes. Allocate VCRAT_SIZE_FOR_GPU for GPU virtual CRAT image.
+	 * This should cover all the current conditions. A check is put not
+	 * to overwrite beyond allocated size for GPUs
 	 */
 	switch (flags) {
 	case COMPUTE_UNIT_CPU:
-		pcrat_image = kmalloc(VCRAT_SIZE_FOR_CPU, GFP_KERNEL);
+		num_nodes = num_online_nodes();
+		dyn_size = sizeof(struct crat_header) +
+			num_nodes * (sizeof(struct crat_subtype_computeunit) +
+			sizeof(struct crat_subtype_memory) +
+			(num_nodes - 1) * sizeof(struct crat_subtype_iolink));
+		pcrat_image = kmalloc(dyn_size, GFP_KERNEL);
 		if (!pcrat_image)
 			return -ENOMEM;
-		*size = VCRAT_SIZE_FOR_CPU;
+		*size = dyn_size;
+		pr_debug("CRAT size is %d", dyn_size);
 		ret = kfd_create_vcrat_image_cpu(pcrat_image, size);
 		break;
 	case COMPUTE_UNIT_GPU:
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
