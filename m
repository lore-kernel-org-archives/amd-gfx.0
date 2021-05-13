Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60998C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 16:59:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F786141B
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 16:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F786141B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD64E6ED7D;
	Thu, 13 May 2021 16:59:13 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2068.outbound.protection.outlook.com [40.107.212.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74E236ED7D
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 16:59:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jj/G7m/KHnnhZiUgkciOifS7G7uspmpkU0/k/rGIp6KzTBIV6SCUT7PKQtlCHAjuEQh4i6QowcFGJFxnFwfw361U3LtbIND2zhlcpFicn81SkhPBEXVBilxBxwHJKl0F4UuoFmynemCYuwxa1YtkAx16W3aBCOf2cB9wdYVhWM4hZxl8cSNKxP+5Ty+qsSj+CShXl1INR/dcZJAcD+e4v90oK4wnD0eZrChsFlz8YdShAgrfs4QmOnF489iY9bgfFxS3ipTb7bvqmCJMnFD1Vuv2a/5daGkRVqGwtJPbTfWOxCX3BN3H0QmVDl45uKM+HVGGXp8fVx0lnMDglatR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmpczZNPXkLw29PiyXbn612Lxjjg2GRN0xRHB/qi3QE=;
 b=nqNRmIQ5e4b3MiAcSXR7SiJB9E0+PJHwpZk9OPZpnJKV1Wb7rv9oCF9wYnZhAiu2XBT/2VdjSFTdvCBBT+RaDuMhpOxd6B6hgRZvdc4KbHMn+OPSQ6sg7yj6jdd+KyMqYnTPa0pvGvkS6bG6W6Y1i9/AWHqop+5O+J50nhJ2eRG825R5NyqD6TXsC0K7IOsfkHgm0VX+1aQgSLTruN4ikbL9pufrszOB1NH22/uHmPizu/CwwTA76qrAxuqL9FEJN8efZyh0xaehyP7bTDe5GwmnG2Gf/dWkETXl2beXWuFNAQaifOoCNtvMYZQ+tUaFYWrW53OH689PewckGPx7Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmpczZNPXkLw29PiyXbn612Lxjjg2GRN0xRHB/qi3QE=;
 b=rq3rEEyEeu0xY34p3QE5/4WyEZ0+hD/yXs8mApitoT7tvW35zCBPTn7B19IL2/pOVnEQYsfz/BWdX1TRWIFsSW50f8HdwfsUaSLjt/celYMRnEOox5xyxQVKlnAK7Ft9NDIKhsb5qM96kszkh6QW6Bu/pVr3FQR4h9DFaQJbm/k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM5PR12MB2438.namprd12.prod.outlook.com (2603:10b6:4:b5::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.27; Thu, 13 May 2021 16:59:10 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4108.032; Thu, 13 May 2021
 16:59:10 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdkfd: heavy-weight flush TLB after unmap
Date: Thu, 13 May 2021 12:58:55 -0400
Message-Id: <20210513165855.16395-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210513165855.16395-1-Philip.Yang@amd.com>
References: <20210513165855.16395-1-Philip.Yang@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::49) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YTXPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Thu, 13 May 2021 16:59:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9c452a9-c08b-408c-5ad8-08d916306d3a
X-MS-TrafficTypeDiagnostic: DM5PR12MB2438:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2438461B8A3F76A1DF3D519FE6519@DM5PR12MB2438.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UJKJhYEj3K/aSiaqlIN1Fn9yl4AooKjLN3vlUWuKehXnMQ8CRP1PuE/noQgv4X9mH92HJqS+uRcIY7llO5snz8J200gVaeVtz6cVo/l2XgqilIVgrJ9VNJUfGJrFOZrA/Wr3lVDPDiy5gq1bdfl8RHcsYWISoA7Vu3XqYVcyyAcxlSh0k8u77qePGK96MY/m2h07c33ognj0U6Ke3eUhDF7RlWnXLfg/XC6uIEZcg208BaGomQ4nL2UdBxLpBL/qRp2QS77fwxNCJCTauZfXscr8sKbJSCw3ZXsdLQ4mwMAtBXcI/e/F83UHVRNeFXiv0BGW3Dt+StnjKTQ047GAiv62puJTqWBeAwJQY62nnqIUUW0XI+cAeOIYxaC6/QfvCayNU6vfoddP5MZ0JOZ7J/jLiX/xgn7SnqbKbwwaBr2NrxLEy5s4pxJxaWQ865wSvcUUmfTj6pk5wlS57T7INSOUvnWL53cRBVv7pkkmt83MeopE7XHcfpEUEjpM4IokAy0OCpBKDImQrXdpHuTpEUrIOtsGUtZqVoD74xgOp+hPCPfNdkFN9pF3iOwFUecqc7pQaQmWQOLB6zBvfFTp8ORw5HWmr/UdlmJZzLV8JckD7uw7KIZzG9ZI5SljdCB7jiqLjzbg6/L/gLpB0H/l5GiiHjhnxarJw/RFrkJtYvsuz/8H3Ie4ecCh0gGOxVEv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(1076003)(2616005)(5660300002)(4326008)(8936002)(83380400001)(6666004)(6916009)(956004)(38350700002)(38100700002)(8676002)(186003)(16526019)(2906002)(66476007)(498600001)(6486002)(66556008)(52116002)(66946007)(36756003)(7696005)(26005)(86362001)(16393002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?EH2xKOzWlvNEf+GE0nT6sm0nWaYahOU/x+XU8u5jH8yFSzgXTBB+KcWO68QY?=
 =?us-ascii?Q?7x6dF4B2/b3Ll8kzE85lOGnkwNye0hK88IhPdtxnzPIUsxM43pPxdkYwMB+n?=
 =?us-ascii?Q?v9/WqT6YTP5zEGhSsECqqZos/H2/tkrbsODrQZYu1z7+fNJm6aji8YYeytcE?=
 =?us-ascii?Q?K0I52svZqg7HZv+wq2k2634BUpvq260pj0a1NYyw1+nmal0/YjpFcOR8nFAf?=
 =?us-ascii?Q?Wgq3lTj8GdjuqdmgRhY5R0n+kqsKnSy/evIXVGY3gWhxX5ajNNPFB6SNUdzD?=
 =?us-ascii?Q?ABbnlBqqsHgcfJaubjdDjIbRvtRBN8AyT7SK8WA89GhXy1qXLAQJ18/UCYgy?=
 =?us-ascii?Q?g1vK5cpPsMadbVvymeoSjLMEt5/liTFEDXfL8yVu1fcWodMx8c65U+QwwkSa?=
 =?us-ascii?Q?p4FzuEnuF8tka406kN208LRZjmnxngmUyJUHUBnbCMNLwj8kCap/Kub6XBwu?=
 =?us-ascii?Q?UbtMLKCMs70RJSwHx8J5l2r75rg0UyAuEUCDwwU7SYrpzFj0veCAvEj9nhNA?=
 =?us-ascii?Q?VdAkgk+8ke1ieOb/DT5XCwYBbNASciaoEtwIbaf5PGiK899gXHspGuRUQ1F0?=
 =?us-ascii?Q?pBG0sIW+iHewIzGxgh8CFgCw+zmw2eWe+0+9fv2iwN7if7ZuuWB1xS7qsp2N?=
 =?us-ascii?Q?oGiu2iwxoLIsVkmR0lhHasnNCpffOPQQ26bSBdVglawOVvfXpoSsAplfb6gO?=
 =?us-ascii?Q?hvf4Jx3uZvvpr/q5oSUdCCY1qlP7tRDDq+rRsOypbRP///DKi7y5W7Cj0Sjj?=
 =?us-ascii?Q?rTxbyICzMiTy4q8/gU+pkGTD4MUTgadBJ1AaBWQfU/E3eihxoESJ5uFVO3ly?=
 =?us-ascii?Q?Z4yxWdAGmTjRjodRHv7Kn5taqc7B6TstvLIZajzYFPr11IGq1VNl9sSBPXBA?=
 =?us-ascii?Q?aVrvpHNWp0Qk90aA3k8S9f6ozAj+Wm9h+swvQ3TQ5WC1GGqLus2m2OPDjS8a?=
 =?us-ascii?Q?LoA6zqNBsP4MrZx85g+0QEegDWcJJqN2mLUMC1eOALLEnHlFAPMZnSPHt6hk?=
 =?us-ascii?Q?1hnIGEUwvIxtjEs1aXfVp7yvWARxJcUMRMzpRTSRaSxYvemzxBTOFOhfkBUP?=
 =?us-ascii?Q?jw5yK5NXEpZ6uIqmH2PYFLmfNRuc/iMyX2VcprIpMj2obMwRy1HBED51nEMD?=
 =?us-ascii?Q?G3pKc2nrGrXW5WTq2am4ynZAc+ubr36IgzGRJBNpkL+kbFx4Z7qKlXHattaC?=
 =?us-ascii?Q?udCswf0ndW42pPYwIYyRblQyFTR2c347S3B9DYZoT1R1bmwE9qZZBGBeVBTE?=
 =?us-ascii?Q?ZUr4Mp3IaclYBWC6utw6VyirvgzAoZv2gORSufuMOW5NfRz5cEV3/u2bT3iv?=
 =?us-ascii?Q?33y19jHgSStqm73hilwA7/Mx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c452a9-c08b-408c-5ad8-08d916306d3a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 16:59:09.8346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AIUdgmcs1svHZ+FoskO7PRBWm75gJeVcJAnXCAmA7x+3yawXLyCHSs0gMXzZfdap
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2438
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Need do a heavy-weight TLB flush to make sure we have no more dirty data
in the cache for the unmapped pages.

Add flush_type parameter to amdgpu_amdkfd_flush_gpu_tlb_pasid.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c       | 4 ++--
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 5f6696a3c778..0be9a6695b2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -670,10 +670,10 @@ int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct kgd_dev *kgd, uint16_t vmid)
 	return 0;
 }
 
-int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd, uint16_t pasid)
+int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd, uint16_t pasid,
+				      uint32_t flush_type)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
-	const uint32_t flush_type = 0;
 	bool all_hub = false;
 
 	if (adev->family == AMDGPU_FAMILY_AI)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 313ee49b9f17..e8ce851c6f29 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -135,7 +135,8 @@ int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum kgd_engine_type engine,
 void amdgpu_amdkfd_set_compute_idle(struct kgd_dev *kgd, bool idle);
 bool amdgpu_amdkfd_have_atomics_support(struct kgd_dev *kgd);
 int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct kgd_dev *kgd, uint16_t vmid);
-int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd, uint16_t pasid);
+int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd, uint16_t pasid,
+				      uint32_t flush_type);
 
 bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 9d4f527bda7c..1d8a593edd3f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1853,7 +1853,7 @@ void kfd_flush_tlb(struct kfd_process_device *pdd)
 							pdd->qpd.vmid);
 	} else {
 		amdgpu_amdkfd_flush_gpu_tlb_pasid(dev->kgd,
-						pdd->process->pasid);
+						pdd->process->pasid, 0);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 50da0d1fb9c1..e57a8e405efd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1125,7 +1125,7 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 				break;
 		}
 		amdgpu_amdkfd_flush_gpu_tlb_pasid((struct kgd_dev *)adev,
-						  p->pasid);
+						  p->pasid, 2);
 	}
 
 	return r;
@@ -1182,7 +1182,7 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 		p = container_of(prange->svms, struct kfd_process, svms);
 		amdgpu_amdkfd_flush_gpu_tlb_pasid((struct kgd_dev *)adev,
-						  p->pasid);
+						  p->pasid, 0);
 	}
 out:
 	prange->mapping.bo_va = NULL;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
