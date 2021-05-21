Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55396C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 02:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE84611AB
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 02:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE84611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D5766F5A8;
	Fri, 21 May 2021 02:23:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E82D26E46B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 02:23:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIRqICxzxbSjKkRHYB5joeZ/+2HUBgxa0wnpxkHMMgmxLygpz5w8dcSJEJb8scDmn/JQK03bFZgMMvbFfKZcJPFYx5VmUuHjcshUAJqqieb2CPlnJSVivz9kYKz9Vw4dUW3kRPCry9LSY/pFtGwzIIx6fPoK17GhVR1LQfMn/E09Rb0+erW1vhj5os35ljuyKqYQCrg5LkZGa743oHDvmKndZaK/iui2/o8RSJtFQa7f9S0k2sqL04MLds/PqZXAq1qseS/q8byImXsrMUBdcmSxY+lm5DSUHtp95luSOCFE6l/WhuxWCP5vPchc/LOk51iTt20G5Py/6/Xg1nloTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoKCZCa9I298a9KyCIv6uPgIBydF6GDqrur+bIPf7dw=;
 b=kQrMvMi51Ug4ensXUTQuVlrCWzQR+NwM0vxmwFnewM8eVimJktcVEb+Y8fp1mwWpU5P0v3Lob2O5TVTJukxaYaR9E2Yl7r8gn8/X7YH2cVaaqaa5dbhDUO/3QCYF7z4Tqp7wafrOfumvXM+7DZTvGtYn8zIUIZ3SCWqN7x6R4u/O5XWaSR2nyPfsrVyJJD2Qf467KVMfutYzTIWEXb4icCD3zBBWmVELfbcHGTJWWpTCXQqs9thlwfO9yqI0OAo+xpT2xIS1yjktWw/kzdFjmfvHL+L/gBTwy8ha2xLIRn1lW93YYGFheYhwoQ8io9K0dK+dJoygmmASiiw+OD/7Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoKCZCa9I298a9KyCIv6uPgIBydF6GDqrur+bIPf7dw=;
 b=t66IoMN3Va/ekKEBJvn2kbSXzSHOTcfIQa0AOQwRPBEHBzpTMokXfvGScsXTfppnIqsIg/z4N7BkXYZtJBKrHqP9pDjY1ax/EGLrK69SSADnEu6bxijvYYqfqaFRlTkCz6xFeJcEaHmSUsoqDFnKYYCf9kyerGm8on2Ab7CwpBU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5049.namprd12.prod.outlook.com (2603:10b6:408:132::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 02:23:13 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4129.034; Fri, 21 May 2021
 02:23:13 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 3/3] drm/amdgpu: Workaround IOMMU driver bug
Date: Thu, 20 May 2021 22:22:56 -0400
Message-Id: <20210521022256.14184-3-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521022256.14184-1-Felix.Kuehling@amd.com>
References: <20210521022256.14184-1-Felix.Kuehling@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::15) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Harpoon.amd.com (165.204.55.251) by
 YTOPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.30 via Frontend
 Transport; Fri, 21 May 2021 02:23:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5502a097-2e8a-44b1-fea9-08d91bff621f
X-MS-TrafficTypeDiagnostic: BN9PR12MB5049:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5049942FF6902D1847E30CA192299@BN9PR12MB5049.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6M2lP2dsuTgJn9DShBV8X57iPCHweixTI2u0dZyOHPf2EHl3HyIZ1ryfIJ0ZcmVdOatLP7EL9lsB6Y+K1Q6Saa41Q+gAaoxbXCw5BV2heiTINPcFsGP4ZLiTTFp7XBlxCYMVYmqkD8TWyOoejXYQDZDFwRZjNVuV8paminPin4bDauQesR0x12SMhVmIcLFFkD/vR/2cDCCTEXtipLWpdG3qbMcHq2Mn9V3gCj+h0yCfTuheG1Tdwqkl8BdDvXJh3pEv+b7snr5SPfNAG3+BgsDfzxexaBXv7ZsZZPBAyyQA4llrDY+XNXB7XBOlvfbnCSc1L/GMaWhBDIvhiq+v8iq1e4kl/L0cjBDslM6SV4roA/lPjxx/GlUQmaVnO+S4MSIIyte7hKA3v85mDd7cyNvXktVZBnv7CiX+EKq01n7drY0YVbHpwkwWURqkBY6QRd9Eg3Hazxcbn1lPtxQwR0FIZnllCRf1sdpWQJPR7Gybdo0953SuTSNVw9R7cOZY+vRMNQoQcIpbM8lsTeq8+jKllX3vigdy7qnXEMwjU4MZiOgrRcDFPcvZMF/0+viIl8V4PXZmSEpw4/jUwUPAH4XN+8ScfoWvVJoPepBCOQMJDoQvcm7+jFesegPTt71Krk8+CQ/rX6opqXPgxViVBQdUGlJj1E3u1ksy8Au7xXM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(38100700002)(36756003)(8676002)(2616005)(316002)(38350700002)(956004)(8936002)(4744005)(26005)(5660300002)(2906002)(6666004)(6486002)(1076003)(478600001)(66556008)(16526019)(66476007)(86362001)(6916009)(52116002)(7696005)(186003)(83380400001)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MMy/Ab2xR3S8+H7jJrKaJOIL6b5D8dewq0lVNeDCCfFyJi53cL5oLnWEJkF/?=
 =?us-ascii?Q?xhhBWOtnF6a8aCbspFA2KKLya9XLg65irseANcDjEc0PJdDNojEiaBbd2teI?=
 =?us-ascii?Q?xYLjbrC38v71PCNU5RwwkMF3tuZCZmg3ovMoeAR+O4oQugJzSxQKrAdHgpH2?=
 =?us-ascii?Q?/4WOYMaKj9TffEL4RQgrQEjJ2WtrNNRNCtMca8B+oQdwfaSNYIiuCG/GiQuW?=
 =?us-ascii?Q?tBz6cCRS7Qqgwwp2lfe/rtJgUEWSv0w2ULZVhxe7kzwBBrOIsBtozhq/1BjL?=
 =?us-ascii?Q?//lqdiYpIjJPucvzcHNjwpLP0AyA5U/6aTGytKnEGuM/OLynPbecyMJo2WPz?=
 =?us-ascii?Q?Q+hhKOagmzAt/wgGvI1hwuflgB7GdD41QJ3FkDO7lUppyaofDDF+QOuaQDB/?=
 =?us-ascii?Q?CLX4hIsyEjRFucXvHxDwbSbS3SrJwTr7s7JKnnjbC02fq2uGbVJPuI4BDbIG?=
 =?us-ascii?Q?Uzjt/KvnfWZyVx7jp4LWAeLQCXgVhCCdQ+BJllLVfjj+wPl1IpFUTHc98ejb?=
 =?us-ascii?Q?brpttXxFHmzrEfj+MFU5F3ikWkJ9Y7f3EVdhPSTuz5OB/9QIl1LAiYDVLyFm?=
 =?us-ascii?Q?nJDhBds7mC5lHyrzQrr4wbpPcVzXw03IWqkyOB8F9C7euRTMYZiOZJ6ITpi1?=
 =?us-ascii?Q?QG3J3St3xI6HvMmjlUXSOGRFOjsT/tL18bokBCQnTXzm6zJOQtRoACnCrqE1?=
 =?us-ascii?Q?/2Xn5aCzWaJKq8kMioJY3HMJHwIxRPK5/mv7XF7Jt06IMUIOe56MTjKX4D6E?=
 =?us-ascii?Q?Qu1MptMaZnHFJElQ5dc1l+dWFm2UE8dgx6XbseQJLiwza7M14SGd+y4QYzum?=
 =?us-ascii?Q?erHGbeTijI7Arkn+qCdtFgvFlN1pheQBVilbTbaUmuNqwqBOQhIuo/Wmyzbs?=
 =?us-ascii?Q?KtpIf37UB4KwgiXTvhkNRNJBA8FhuqS2+NXDzQBYT6hSYvY4kqE+67IvVH5Z?=
 =?us-ascii?Q?+KMa+p+iJhvS8/WVhFheZDZN3LHql9WXQ/pUj46jblsnjkELB1sKeAjEnd1J?=
 =?us-ascii?Q?R4aqVmR+ULDKZSbwnuXVre7lLcqfGc7IRAo4yLrml5m2phbKSe1eHXtlNvN/?=
 =?us-ascii?Q?GRnKp+g4/3zy8sS+W8PTmbb5u/oTYmZUufFecE+/NXYDxYW5TDzSkbjx7StW?=
 =?us-ascii?Q?NtpLARXzRFkjLqVGN+raI2tm7OvS/0/1gENIKYy66aOYaHntuCcBOdKxkYHX?=
 =?us-ascii?Q?H9RHMQudebyGoNW8PrXDIYuB85kBt9hmJif+nuWZiKMbPJh40S4FW64cXW0q?=
 =?us-ascii?Q?bTql4RuBdcM6RheJUdbY6iDxEPFfSmQuIBSyxB36cOoTbLCU8vftOQIF54Rm?=
 =?us-ascii?Q?CfwEUQt0LGVUp2q8hXS4ZaIQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5502a097-2e8a-44b1-fea9-08d91bff621f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 02:23:12.8023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubYMXdUJWf8k0NtYATAk/VVF6DmKA/wWNrO8Ya9u241kJvQRYl7C0gp4Ej2zpQI/QWCF9jtiLlzT7PiKM+6p+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5049
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The intel IOMMU driver causes kernel oopses or internal errors flooding
kernel log when mapping larger SG tables. Limiting the size of userptr BOs
to 6GB seems to avoid this.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 2b8b89535198..3becf9d9f8fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1409,6 +1409,9 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		domain = alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
 		alloc_flags = 0;
 	} else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
+		/* workaround IOMMU driver bug */
+		if (size >= (6ULL << 30))
+			return -ENOMEM;
 		domain = AMDGPU_GEM_DOMAIN_GTT;
 		alloc_domain = AMDGPU_GEM_DOMAIN_CPU;
 		alloc_flags = AMDGPU_GEM_CREATE_PREEMPTIBLE;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
