Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D7CC4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 19:59:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D5296113E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 19:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5296113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 599E86E079;
	Mon, 21 Jun 2021 19:59:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F12556E079
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 19:59:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwWJVMnt7fSKHqlKH8ELvKmqHC3G+o1WC7HHPehg5DRscHRhKJyVI/AgH1kOiZkSvLeMI04GL3YoXyz74b2y6Pk4Hnb62OHBSXFY0cJWgU3hyfJ+ujrqTZlYiJs+SearTF+8NAENODfKid/NhiCFJtCXWp7vTLFDyE1BZFnHt4+MmCBpnbMzBOwE1IZhTaNn2drPDXAwxNKOF8QLOe3MMoT+hUNtqrIUlXE+HZDudQ//+QRIzkswSDf/aNirqrX8Qp3IbKlP27+rbYL11CH13/JIxaSZkpR9HoD1+m2LOyj0yVmBXZK8GPVaTKmVf49vSm6jwFXjVuIwLSninhDq0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WC2g/iye2MxbcXl8V89Imm4Ab/QU1E1Cmt8tH+TsckI=;
 b=CnUESTnpHU/gFJm3IpuIDpbnDuQwXXjuREVJkZuYAAaWo3AYfatrh2Ud4FcRSut2t+L+Ne5YNLoZfYXS+qNCYQ4Eahc0aGoHDqKFvHOeFt9rPljpeGXDc17UOeUxOGNaIFWRusxXyChTed2HJbCwnuM3xDeW0yJcVW+iq+A/5fTiDdRFLhEYu3mioav2TMOldYjitulzNnRl9BWVzHqJGxYk3kc/KpvHg0/eUDDaZ2FalSv5SFxxsEdpXADo+NK8HDR6slIerEcRb8H3/61Ozs3oHCzdFLovVqvQfrmZ1H7n0oO9OOoczZ8Uc8SgOOa21SIy9JHAEVhWZWMe3PAZ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WC2g/iye2MxbcXl8V89Imm4Ab/QU1E1Cmt8tH+TsckI=;
 b=DXGceq+lCqVKvxkX2LKPkWE7HQBrlw1B1kXGriNSw79oUG9OvpX4GcEa58/K18yxlsdhZ9djdgddvKoTO40b5sAgiKDG8atFCU9PgUHyRkqKU0d5UXWO+N4D8B/F3CntKLM5V8jDG2GPenhA2DVDEEBBfj+CrCA4oCbk02+jze4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5194.namprd12.prod.outlook.com (2603:10b6:408:11b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Mon, 21 Jun
 2021 19:59:19 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 19:59:19 +0000
Subject: Re: [PATCH 01/10] drm/amdkfd: device pgmap owner at the svm migrate
 init
To: amd-gfx@lists.freedesktop.org,
 "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>
References: <20210621160423.3517-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <99703421-5f07-edaf-a9e9-537d13864f1b@amd.com>
Date: Mon, 21 Jun 2021 15:59:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210621160423.3517-1-alex.sierra@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::34) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YT1PR01CA0155.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.19 via Frontend Transport; Mon, 21 Jun 2021 19:59:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55e5465d-6a54-4515-87b0-08d934ef0e0f
X-MS-TrafficTypeDiagnostic: BN9PR12MB5194:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5194DC0AAC474747796E8DC3920A9@BN9PR12MB5194.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ee40OLF1pnkCYAh7yqcZOJqNCpElwJwkWJ6im1GyZmvlfIVfNpFoTxPoyyepA3GQ6X308lji8QwjinKPW0wnb3BCE7g47bPXUjBW0iNzQRJkzRYlgSXzYCab++w488FWYRZZDAPqt6wLu3RcEF5pDwIdC771gZcAqkeAT5FVgibGwH4j6dfNHBHj+zn7h/X/z054GY3Ly3JuupFvrQj9brK36zDTkUA/i/bg79yxof1zvhkARvSbcUm6ZVP1tmizLLmCbaUctMFmtn06Y2z0LoUCfHOQDI6t3KjyAyF/wDnZnPjucYCxp1PE2+XGrNB+UkGUk3sj0oAPxaPfyxkH46Y+uBEKFm6VcqeGLcJUhbQfXkGS1nMioUxfmGVdLbw9g8ifmBK4oiwMl2OnWkYH0HK4DMqRp4uHJ8SzlrWQ2l7aSIkDofJ390mxoOeCTIe+TZjbCHr1AFYLx0t9w9tsE+dkOrLxaPuH5VbSxrWnficHsXZnvF7rOeXRwtAQShFgpkeRb6dspcCOvwkIKGFh1HP+TkX38s0CNweAaPPa45zVQ/lLIi1lwAyTIJ9SkMt96Mnr8Qoh48pjggfKzloDvNjt2ms7AzXW1VfYcWj0XdWSmTXgahRyH0c4sGNQS/s4qZmJCM9cFUaA6OTY61I+FjNPp+eNYeeXfXrLzRkO8NG4PUUNvAcr6+Fp+V8AOJLx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(16576012)(316002)(44832011)(36916002)(6636002)(478600001)(37006003)(83380400001)(2906002)(36756003)(16526019)(31686004)(53546011)(66476007)(66556008)(26005)(5660300002)(66946007)(31696002)(956004)(38100700002)(8936002)(2616005)(6862004)(86362001)(6486002)(8676002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enhmNVlMNGNPQ041OVNITkFSM2MzQzJoT0dxT254RnBsV3ZCOXlDd0VNc1Iw?=
 =?utf-8?B?UVdrVmtFQUdMd3FEZnREaGhiZkpEZktGRFZ2aDg5YlRtNnQyZ2IzR0d2RERw?=
 =?utf-8?B?L1F2aGkwd2FjTlhnbjZGRDlUZlV1bUxXUloreStpd1JJSGM2TnZBRDdmalZt?=
 =?utf-8?B?UjliZmVQVnYwdU9wblkrTXJ5Rnl4OU1ScVR2dU8ySnhsR0h3bkozaEJMNWFT?=
 =?utf-8?B?V0YxVGRiM0x3dThGZGFtalJ5eE5acWMvUVJsdHBTMjBIUWszQzR1MmVINC9z?=
 =?utf-8?B?K2xiUE42emttNmNhcURGWkNUS0pVUjQ1MzZMM2V6YWtPbUxuZXJMTmxmcXI5?=
 =?utf-8?B?dStnNmpOdHl5T28wM3pFa3lMS2F0MllaK3NCN3cvRnV1UzZnbVZaQXRVYnFw?=
 =?utf-8?B?VXE5eWdSRm1lbmg2Z2l3c3Jkd0V6Vy9lZ0x4aE9icDlCSEZ2ZHR3Vm1qdU56?=
 =?utf-8?B?Ylh2dzFMT0RZQTRjUzVGcXg0S2hybzhhbE5ST0tTa052WnBEUlE5Qnh4TDJj?=
 =?utf-8?B?UG9FZVlGTGJWdGRienZmWmJsNldRY1JvTWg1ZmJ6S2IzRDZVOVVBams1cWZE?=
 =?utf-8?B?RHlGN2NHR1hiOWIrWmlTbXdSV2NiZG4xYzdnaVFKVVE5L1JlVzdHMUdLaXpi?=
 =?utf-8?B?L0dYVGxlNkViS0JsZlowd3BFM28xYmdGTStqRWkrM3F5ZmhpZm0xdm1SeEk5?=
 =?utf-8?B?VndQaGZqRDlmdk9hdHRaN083WWFNbVlGT2hWTHRFR21RMW85UHhQZFhzeGdV?=
 =?utf-8?B?Z2dldDhwRFJZNStpcDlqNDdZMDlXSCtaVXE4b1RhUlRXTXNhWmF4NkdYWkJ5?=
 =?utf-8?B?QnhIREtaS2RWU3dmN0JQTy9jbFVHYUxWNUE4TDlZU204U2tyOEsvM2w3WUM2?=
 =?utf-8?B?dlFSQktFV3JPaTdhbnNaNzZ4U0NaSm96NjV2dE5hdXdxakppMkI5Zy9qZ1Fu?=
 =?utf-8?B?NnVHejlCa2NLY2NzVVFLa0xjTWJDalc1SC9LdTMxWktqd3lRUjlUZE9YN1Fa?=
 =?utf-8?B?cWFhcG1rRjdLQmpLNk03aXI4Yjh6Y2pDQllONSsvWkVXUDJVVitMamhmM2N5?=
 =?utf-8?B?MXdIRlhHbVErUGYrRldUT3c1WDZEZ1RXRkd1dTNEa29NeTlvclFpZzN5UXdz?=
 =?utf-8?B?Lyt3N21lQ21WRkNyaGY3bkFReWVveVJuWVBLVkNHeGRNN25Qei9KRTU0WWtT?=
 =?utf-8?B?b0t6Y1JsR0RyQVVsd2VYaTZ3QWxLWmJuU1dJM0ZjNDBkTGFCdEZrT3JCcjlP?=
 =?utf-8?B?aDVlR2pnNFpnZGVpa2hZMVpmSC9EYUtYaHcvT29ldTY1aVJXV2FmcDlOQTND?=
 =?utf-8?B?WFE4UTRmbFVMUGl2SWxMSk5VSWo3c1dDbk1sZkxFM2tGZEV2dzV4WGR6bWZn?=
 =?utf-8?B?aVlTNEg1Sk1nbEU4c1E2V2MwVEtnYm9mdVZQTzRGQTY3WFF4TU1nSEJRaWxJ?=
 =?utf-8?B?cnFySmJOZzN4STJ5Q0JEemZuSEQ1TUJlekN4N0cydzY2Rkt2NG5WZUlLQ2Fw?=
 =?utf-8?B?OUdpQi9iSGRWR2ZsLzFlYmVHWXRPcHBCL1QrbDYwZHI5ZGVVZXMveDdsYk9p?=
 =?utf-8?B?VVBuQjI5QnZ1RTFoK25Ycll6N2hET055VktrT21qaGV1ay9GWWQweXo0QXJT?=
 =?utf-8?B?MXQ4aXV5QWVSeC84Rm5HSkxON1g4ZnM5WHFrM2VERXU0WUkzcEs2ZVN3OEFT?=
 =?utf-8?B?bWlhV0t0NWtrNVBWVFNXVzlETVFaSnY1TW8zMDY4dFVsclBHaGJlVlRZYXE0?=
 =?utf-8?Q?d4z18KVxuOFx36E9tFnuM/j1YXs5IWEcJR7uap9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e5465d-6a54-4515-87b0-08d934ef0e0f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 19:59:18.9224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDKhzq9DoI2xgX0NNd06DaVNvsRahAu4YcuXVSqAbGWBDfaIrlAbA4eRUKWsFOWZBDZEsBJkO087ei5FHrPuIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5194
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-06-21 12:04 p.m., Alex Sierra wrote:
> pgmap owner member at the svm migrate init could be referenced
> to either adev or hive, depending on device topology.

The reasoning for this change is, that GPUs in the same XGMI hive have 
direct access to all members' VRAM. When mapping memory to a GPU, we 
don't need hmm_range_fault to fault device-private pages in the same 
hive back to the host. Identifying the page owner as the hive, rather 
than the individual GPU, accomplishes this.

With this explanation in the commit description, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 6 +++---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     | 3 +++
>   2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index fd8f544f0de2..11f7f590c6ec 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -426,7 +426,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   	migrate.start = start;
>   	migrate.end = end;
>   	migrate.flags = MIGRATE_VMA_SELECT_SYSTEM;
> -	migrate.pgmap_owner = adev;
> +	migrate.pgmap_owner = SVM_ADEV_PGMAP_OWNER(adev);
>   
>   	size = 2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_addr_t);
>   	size *= npages;
> @@ -641,7 +641,7 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   	migrate.start = start;
>   	migrate.end = end;
>   	migrate.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
> -	migrate.pgmap_owner = adev;
> +	migrate.pgmap_owner = SVM_ADEV_PGMAP_OWNER(adev);
>   
>   	size = 2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_addr_t);
>   	size *= npages;
> @@ -907,7 +907,7 @@ int svm_migrate_init(struct amdgpu_device *adev)
>   	pgmap->range.start = res->start;
>   	pgmap->range.end = res->end;
>   	pgmap->ops = &svm_migrate_pgmap_ops;
> -	pgmap->owner = adev;
> +	pgmap->owner = SVM_ADEV_PGMAP_OWNER(adev);
>   	pgmap->flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
>   	r = devm_memremap_pages(adev->dev, pgmap);
>   	if (IS_ERR(r)) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 573f984b81fe..4297250f259d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -35,6 +35,9 @@
>   #include "amdgpu.h"
>   #include "kfd_priv.h"
>   
> +#define SVM_ADEV_PGMAP_OWNER(adev)\
> +			((adev)->hive ? (void *)(adev)->hive : (void *)(adev))
> +
>   struct svm_range_bo {
>   	struct amdgpu_bo		*bo;
>   	struct kref			kref;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
