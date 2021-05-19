Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC71C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 05:45:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A157060232
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 05:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A157060232
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42A466E203;
	Wed, 19 May 2021 05:45:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BEBA6E203
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 05:45:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NATdK4oh/PZkS08e/Svnn2gBR94J07bhPM/wvVncZjS7QnAnLveqqakXXQZaSfvCLnLDw2bjwOHUsk89LjVdaeVKEauV/AGuSWmWA8exMaRTLhOXRTVzLWO44Bl3FhEa71vdqYDgkrslsIpNYvYPdIAfX4eSjNnxPHl7zx3McwD7Gd9EQ+yLsOraJZdgzujaOEE2SFlykkqF52wcwxR5s92eHCF2PXbXFfCoLTqPov6ARANUvr/dhlO2LxRhA8IQ/U8TBeeI3zj5OoHyt+BqZeHT+WcfYZHa3d1VkB21knJ6GdPtpxEpVM3AwjntqrQABgdsHpj1eaK4X3UQEMtRoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BINfub+wvvTckwz+VjPd3RUX79tTwq5wOC3GfyDdiew=;
 b=NpeuXkugs03asjPcki7aPEOcfvGFse5KEIcU8nc3OXUjdn+wwm22WbjlJn7fqKXNU3/dDH/HsbGwq7P4VrS2neykLb3L5I0j3TFRfLYI2grPHaS5i22pUbaVbOiCGKo4U4fSmrlu+KQbh6mbq2jz49w/GVxb5aOPP9Haz+IA9/gWRvYTnl92EQtoLMe65J5rcnFQvzZdFhjxzv+ePiGk/nWrFjtT6fPdUyiYDG87qcoWrIwHXapm6gLCwONJUs7it/N9ltjx9QJracB9Um64r5c3mrYgV07+KXnpGFxzSjBbpeRe1hFc1IBvaXhtqXTfhkpVcHy+Bv6UF5kpmxTV2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BINfub+wvvTckwz+VjPd3RUX79tTwq5wOC3GfyDdiew=;
 b=RbtYO3AQfC3ucixiZTKLJCh+PCCnOjBPsxFoTRsDDNSF6Pu2eMS2SQBYQcpm4gRk3CGLLFnLYgLP8mpYUGgaWO3i+FL8F5PpbqjIfeuJyrAlYJ8w+dLzpeVnhEj+vHhSLyVum1HOIRLLNYVzfE6jX3psKqbJYwrZJrKU0OaykgU=
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
Subject: [PATCH 2/3] drm/amdgpu: Use preemptible domain for KFD
Date: Wed, 19 May 2021 01:45:35 -0400
Message-Id: <20210519054536.4690-2-Felix.Kuehling@amd.com>
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
 15.20.4108.31 via Frontend Transport; Wed, 19 May 2021 05:45:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20d20954-fe2d-4929-d1fa-08d91a895a6f
X-MS-TrafficTypeDiagnostic: BN9PR12MB5211:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5211621646A931847A019013922B9@BN9PR12MB5211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mz+8AIaNHTk81WGTTesu1hUH9kM9GVeBVXG18hkqstOq/7dLIbASDRuSQ8cLk/+l/Men4naWbMCqQhS1hkBQANVhMDEP7XpBoIt8dLWGwq745b5QQOtvrMHJjy1gsipLlKtC8Ie+IabOKxgR9TRQxgCc0IT4Gh7hzra8joX7n79BMmg8ywG2LKJMYUdU98/Oz3qT6mR3NuhNtLhLlepN1Gf3iY6ntU4O7mIXk70xZ8z/zzgeIlZ1aFoChq7affo2f6vPa5ZcswcQNNPN/xcBbgzuyCx3idKstSmFDJRugbAlzyx2U6uYQ6uCLbGbfuCMO4QV1j/EaJxBh1fMgYd17Kqyk6RErJFnPPtfXXR8uSUzdXPArxEcVVumB7IMYpYmq+I7D2in2Pz9FR5KnTJRov4y6C91cHV2UpW5gk87kelaZyKzGeJ0od11wjPr26RokQrqFkljie5y7wEU8Hw4ynbvuhGzHVa5kuF2mdScKEjjcp1QvL0A9zYfC1V7xox+/q/7Htio9h4HH2aFA5lSz+cm4HTvxs6wyZqGKNfAdjmdp4Amdofa8DEcqgviXAgmiyFCWT6xsq6gAm3c6uzdZyuR2Z4E47ETF1u9uKN1yXQgLFHMo4eQ4iukfuUweyE2rZeQHUrRoH4BwpY3ypEcQv3PVudHhKoAc9mOWfnY9mo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(66556008)(52116002)(66946007)(6666004)(66476007)(6916009)(7696005)(83380400001)(38350700002)(478600001)(38100700002)(5660300002)(6486002)(316002)(8936002)(2906002)(2616005)(956004)(1076003)(16526019)(36756003)(186003)(86362001)(8676002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6UvOdflLP1oVs0Si4NigirGIEbCYW4ozfffMdG8XuxPL3MESEJIl+K3At62v?=
 =?us-ascii?Q?TMd4ZCLN+iyTp/gp064D9WB3LnOAMqYhoCZNYTXMknTz3DukjuK6DTpu33aU?=
 =?us-ascii?Q?AXTGblH0QKs3ZQj+4dLiTQahH3naFdxbBwK/zRnGA4GJ+jewvru4mnJNmDdg?=
 =?us-ascii?Q?y+6I7e/8NCYWVjcdiHPHnSwfTTyMW7z5f5+pQoorcCf6Hz18kWZLxbpG0Cwu?=
 =?us-ascii?Q?BEi0atVhBFYitveAWGESfV0hEB165jz4bTqCKW8q/fuxvjsnTwjMAtUWDKmV?=
 =?us-ascii?Q?efEz0ll2kjCNwbpm9BpzNken4l0BrYpK5Wsq/G78jrtCt0lBtkU72CjV3Ojc?=
 =?us-ascii?Q?1ebfqYsC0/sv45vOdwOtLjx7I8uYYNVUU2qrm7HtgjQm/G220OcV4orWO1HS?=
 =?us-ascii?Q?Ojzah1hIZcg7CKm2CNz+QfYxYqQDr6LeO1bqK3laKdYewsnT5E7BAaQX6juB?=
 =?us-ascii?Q?BiK0phr2onb+J5c+Ll4XEO8B1Vwq8Ira2iVoFnHL+k0sL9FTAzsokC7ufppr?=
 =?us-ascii?Q?KF80sVdkP2vAesrAV482/Wgr2HfRmjQLg0q8RK+DTOkSX1+Nylk2+B3geBIV?=
 =?us-ascii?Q?271J+LEvAa70dE5nEZdDwnOLLiO5V4KvqLM8vXVeyDvx/OZbOPrNemL9s0W3?=
 =?us-ascii?Q?JglrnfA08YPmTP0maUCN4SnLsuyBnWC9FQ8Nfx/XDHyzJ/rk56OZYXU4mV6a?=
 =?us-ascii?Q?pztqACdXZ4okn8I2dKCS32nxLHxpIN5/7K0DnD6S3ULkMDyv+GIV2AIgLWa+?=
 =?us-ascii?Q?5eiuIqx7AJp6U7Nkhf7AjUwAeWn2XpQV51TQEEOpjSJTqHxnfKTT51Jn8ckf?=
 =?us-ascii?Q?CMDI0GzjIwV8YMSoSQKR7T5ljoa+/4706WpaJq67Jsj95/nMPsNxGVKCvVSL?=
 =?us-ascii?Q?dvqe5/3PdJlx6t+atOms5L2ynoiYbVAV3aFphOgTy4hmH3CmGJogMEp8Tet4?=
 =?us-ascii?Q?JXzeBAoGDbNaFWBpV4qcvJEp6UAXJousEq2nkql5ZlTtKbBL3YQ+0Y+B/JO6?=
 =?us-ascii?Q?CICHRDi9v0bESJRKgwG8FqPfymgsKd9XVqvuP7IDkogSBhFf436T0EOpJhvQ?=
 =?us-ascii?Q?B6R6vXyY+6Wdu7cH1fKYpp1QBt0iIBeDQLcokC3NhcGUXNbMweSCDD+OV+AS?=
 =?us-ascii?Q?m4S0DtDVbde8unFavVcJ///FZXRTAHAeJKcALObF4F36y+oGO89eA2e29Vhi?=
 =?us-ascii?Q?xfwFU8KYJIe8EPCB0u0i8wZSCGDIpFho5wSMAP7LZFXz/RJ2lhA+KEA54rY4?=
 =?us-ascii?Q?WlOO1qhv4Y/HSiQnGk2Czuiw55lFXhjAGsS2tR7EwUH5wgugrIMXqmZy6pBt?=
 =?us-ascii?Q?STYMy9GwS1e/utw6a3a6nlK3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d20954-fe2d-4929-d1fa-08d91a895a6f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 05:45:48.1149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qb5K1GWI5GzxDi/UiFt5at6UzW1LolfiNjMvusNPndieJQ+Ssup5uYu1EytO1ln2cwdFrmcf1z+3D0Rd7wg4yg==
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

KFD userptr BOs and SG BOs used for DMA mappings can be preempted with
CWSR. Therefore we can place them in the preemptible domain and avoid
unwanted evictions.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 928e8d57cd08..2856ca1032db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -511,7 +511,7 @@ kfd_mem_dmamap_userptr(struct kgd_mem *mem,
 	drm_prime_sg_to_dma_addr_array(ttm->sg, ttm->dma_address,
 				       ttm->num_pages);
 
-	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
+	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_PREEMPT);
 	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 	if (ret)
 		goto unmap_sg;
@@ -535,7 +535,7 @@ kfd_mem_dmamap_dmabuf(struct kfd_mem_attachment *attachment)
 	struct ttm_operation_ctx ctx = {.interruptible = true};
 	struct amdgpu_bo *bo = attachment->bo_va->base.bo;
 
-	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
+	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_PREEMPT);
 	return ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 }
 
@@ -1408,7 +1408,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		domain = alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
 		alloc_flags = 0;
 	} else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
-		domain = AMDGPU_GEM_DOMAIN_GTT;
+		domain = AMDGPU_GEM_DOMAIN_PREEMPT;
 		alloc_domain = AMDGPU_GEM_DOMAIN_CPU;
 		alloc_flags = 0;
 		if (!offset || !*offset)
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
