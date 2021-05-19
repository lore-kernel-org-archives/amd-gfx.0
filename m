Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318DBC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 05:45:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFD2F611BF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 05:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD2F611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 584D36E209;
	Wed, 19 May 2021 05:45:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CE526E215
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 05:45:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XChqq5ElA436TeXJ2PYV/Hosk+bTJKAoTe6lRsg/oNqrA5Ldw9pvfgt2nAPjhSMY+icC22jk0JfpvvQaVJXQo4ybBMZqTQgkvkoXin6FLiGChKXoFGCHZyyuCrkQgfqXdhAgdJN1hpb/uHlUu+0zZ2eZ1/x3coOEsswwyIliFJwQLTFn4T8HdBGwq+7ufJLh5xBiE9F9jMyILimWnsVQTfR/lg/y80S4C6KeUhYr+NHAtkrD7dRjsI8WRIhXW6GoTFLIaqe+C4n5R1/NpQdDfPe9FBFtRj3W6cFGAl0d5FdKIA2PtbNo7RaKmdOLnAHSHH3TZzsPbIFpGVpdYlstqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXSI7w+utcpxuIqbpNT7ybVTpHL19lPzT0O14+5091g=;
 b=BVn1Darz7KMg1iRM0xT6s4CXR/7srrxLqnC4S3NV9YmHEpM7oGjnm44i+BBrq2WlP/gXxEuSbbnWVAVanCJDkc12HWRtPMBTBeCusAUFpK0hQW1GQ4hqXdFiSx/5RJJYEGVm0sFEFxLbQJ/i2mZGPd7+crvNzpqvZxHJa3BpnsMyV/EYZRpJDuJniR2hJ9ym8vB/Wr2E4JKwyfCPJImrACt87dJ3l+qu+V3WCe2IiGUWnVvuOv3xO6tZwnhnrocM13Jhf2fkvTIeCBappirnCUCA+2hAifeOsojwvqZ349qXI3VM8bkIgiRu0JfYQ+Sk/WMXkCjUlEQJdTwdVZgAtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXSI7w+utcpxuIqbpNT7ybVTpHL19lPzT0O14+5091g=;
 b=SaARLgqpAICwrbUIQLKU08Z8QcyN5zX9VHOGUuVCup1sLFmPPMCkYcvvIB5o83g8EWgTdzSLhnBO0XHWP/cOOedj4zLxTbf/7bOrvdawC/2tk7StAqbLgUXIxqQvbXyhEhOGrsth81npYfyE3mA04j+d+ozQlvonwXBdM/zyRps=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 05:45:48 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 05:45:48 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: Workaround IOMMU driver bug
Date: Wed, 19 May 2021 01:45:36 -0400
Message-Id: <20210519054536.4690-3-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519054536.4690-1-Felix.Kuehling@amd.com>
References: <20210519054536.4690-1-Felix.Kuehling@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::28)
 To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Harpoon.amd.com (165.204.55.251) by
 YT1PR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Wed, 19 May 2021 05:45:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b478584-9474-49c3-c3d3-08d91a895aaa
X-MS-TrafficTypeDiagnostic: BN9PR12MB5211:
X-Microsoft-Antispam-PRVS: <BN9PR12MB52113D4AC97AAD6A28F5C3EE922B9@BN9PR12MB5211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dQtFGZEV83I50FQJb8fPiPxlvsgZenH0HG9Qzpv6eibqjBXpQpDFpHCy0Ay5h8L3vxZo459mWNC+YOUMcrefL3KCIrBWLcSL6UhMt+QZROvW0bFMtc7S6R5jGnHcAucX8oKqebETahpC3o47kzbhrLab4kXlb04bGwtSF221PNe8JSHbXFYhtocP1rxgDVXqNg3DeKVyrft6fFdItrDGQvwblGO7JmgBshBeJZrA8FBSQSBEdS2+xv6xdkyv7PkMI8bc7NYvNBpXQnUY9V3oncNcYhXmLCqsKwsvkJ7Ilgh6fsmUbxNjGP3eABvQvwmLgVw/bSAIEL2AvKSz+eaJAG3y9VxoVkQnvn2sITsiNRkT/VZhUa+X9PltmlpoEbh/5q3ixR4zXNxg41VX5CuSltGGQgtNV9l3jSdYRhyrFivj17ryH6XjEHQWN9PvGlQJfZjOqK1yA5r/e650zt0vP2+pv8EfMhOiSjYRKl0gI6c/DKuuHFDHvg8xUtGsFTmAGT+9lQqG2+Bp6nJ+E9qY2UUTL3yadZ6mxukK1mnbjfQYa2YzANqJXfBkt5dZKSFXZrB7xF4TvyyXS2y6azTKwCwm4i2uS9S7wRR2hPH2LY8ODsJj3LrWZeRE+sKBVZzMLjERFs0hf0gR541xBtpr3Uf7O1O2GR+AVUGso1zqaf4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(66556008)(52116002)(66946007)(6666004)(66476007)(6916009)(7696005)(83380400001)(38350700002)(478600001)(38100700002)(4744005)(5660300002)(6486002)(316002)(8936002)(2906002)(2616005)(956004)(1076003)(16526019)(36756003)(186003)(86362001)(8676002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Nj2lcw5caxHR+3wKhq0RUTrvBkSDdfevYJ3vHX5frGH6pMxmWNiiv5k+nGwa?=
 =?us-ascii?Q?0/tuij/8Spe40QF1FCUGhFGjqkaC/9VZmWJGo40XQPO5zNkQZ0acz2afe4ay?=
 =?us-ascii?Q?6mZnf8FQjjU3U6iAK3cgKsVIjYx4nGlPzHNNo6X52mFKk8lKXMl7fkNePtVU?=
 =?us-ascii?Q?lp3r4GFZATqBzlwuYYhdYykNrB/lwGsaKBIUonosxyaO70fdrVKJSR6+8Rnd?=
 =?us-ascii?Q?RX8fGu6Htb6oRO3zjtGabXdKlt2/dw0RDgfKMUx9g/FzYaKsNS42wg4g5uvF?=
 =?us-ascii?Q?RGyQxP/v48MLPH3IGOmMow+ucOJWNtzQLgJVAdTHosRZZ2XxmbgeWHC5OK4e?=
 =?us-ascii?Q?IA+LO8zRsH1iowUcKZJOkU4+6mFAku3UB+PYl6Tplje6gXK7AMOH++Nav0cv?=
 =?us-ascii?Q?3X4UlJSi1EMnBBAerbgXiBlniddN0PrPE3crVwoITWQz/BSIMjODuV+3hz1A?=
 =?us-ascii?Q?ut6SCF966c594MQNMKMIyfVvUMQSRZBzyVDSUn1jHrIoPrU1T0rRzRKcTMVU?=
 =?us-ascii?Q?zLABPU/aLjxv2oM8J+gpL2yJhXoax/8lC17uNsBGk4ZvilCwje3TQYqrlqxS?=
 =?us-ascii?Q?ABUPPPy462CELAxiJiUZZDzytU9haOBkrImYCjy11Pede5+rw7wIBtFEYjsP?=
 =?us-ascii?Q?RVBawDaW/HtDgiGbp4on1ZgK5JXyDnjOStLkeUmpN4ZRrbc0NT4ynwW/cpT6?=
 =?us-ascii?Q?8oUVtNZuM8+vyx0TnlB8eE6cQmUVZ0zOhNiE2+DZPmqQMWO2GT9csRNiLhBn?=
 =?us-ascii?Q?afJTlmcgkavegjtvmR6D0Q+WliPhQVApKd7rc/Bv2aTp/GD+a5l4Ybm+8i1I?=
 =?us-ascii?Q?F4nz+YyTovaAO9f2m+kvnQ6tBe7FByksGZHnJFZ/GBknzs/pErDhUk2sgLOg?=
 =?us-ascii?Q?ZrMYhBqDgz6qoLZWbl921AhNRGLau8rHTH43n6BAdv0H+DssPeR8dMrJwx80?=
 =?us-ascii?Q?Rscr7FFzdNtVPjXZYFQZsH1uWDSLUQ03AM2FFreIWxLspSse7bybx0tjehkf?=
 =?us-ascii?Q?Z/SHR195Fkqmg2HxUWoXyPCFqh2CaUCEIt6+QBED+0dUMROI6n64B5ZpyWtS?=
 =?us-ascii?Q?x6FrRjv6/Rrr1Jx/jhRefOjpYmHsQ6WNwZu6JWUXIVEHI+j0Y03FZKnPBpJA?=
 =?us-ascii?Q?3/WMOoYFfUkRaBELgW4OPT2sNdHQF50E9lE6qsyW2xlnpsG/RA8GuY6SxACY?=
 =?us-ascii?Q?JkE3r+mi3Z9++EqVSsvwODiOPBq5ABXjSrrsJI8bkHeKNT80G9Y5U09iZ8RI?=
 =?us-ascii?Q?tModIfA0WYmIaTC1C0QplYxD2YWipuYZyYsSSqoa3nFwLVU4K6rZpx12VsDG?=
 =?us-ascii?Q?JurlLhIybLPhtoHZbxef+zeJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b478584-9474-49c3-c3d3-08d91a895aaa
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 05:45:48.5639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sf9MSZKaorFM+WIqo15Ca1RuG7lbqZ/hC8/yKNaDroP9mt4ikV+X4NVX9X5++rXxG9vHS3vPB2ZpQlBBBxacNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5211
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
index 2856ca1032db..a82ca85a2d6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1408,6 +1408,9 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		domain = alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
 		alloc_flags = 0;
 	} else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
+		/* workaround IOMMU driver bug */
+		if (size >= (6ULL << 30))
+			return -ENOMEM;
 		domain = AMDGPU_GEM_DOMAIN_PREEMPT;
 		alloc_domain = AMDGPU_GEM_DOMAIN_CPU;
 		alloc_flags = 0;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
