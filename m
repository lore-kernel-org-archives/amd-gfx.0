Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0FEC43334
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 14:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACF6B8F9EB;
	Mon, 25 Jul 2022 14:34:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0710A8F9EB
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 14:34:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtkjAHMvWEpLjzcyiYwzeHG3nOz832oMrRti1m3IfmDkqJTvWCWGnWuRS1Jx6kOaZ+mqk/F27bbJwWoD4KG9shGvgvJVaoqZSZ70+3YxNZXEjh4TJ1eA8yzOu41JdR1jf1IVf8YUXw9AvuK3s5uZA0m8vTq02cFRGk5RQX75/0NNz9HLGMKUce7f+evQ5la7F8mUb5zoDvr5SLx4F6yF9zPi3iBaqBhtWisIw54Xsy1kl4IgsRo3WYfyusFtcKy80LDT0h085ZNsOmPd+pGU8yUVu+OBcxLuqjW/pGU664WnC6azoHSQhlpF+gzf6eANoP9Q0ckxMWW748AmZ6yqwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZzqqBR5nWRhKPAA7hTIi57cy6pwHUqsNGLfMMapHqg=;
 b=kevHcYRoTor43PDHKDlIQKzRiaMR42IHf6B8LVB84y4zX9vBYZ7a5icttOkgwk07fn3HUSD3o3To2yg8/zHge8d/9uyjLJdkzOIyA72yS/kgp8FQQpuUjrqY8bFb4OEaIrL7OjAaghbYCJMA+XNN5C2V0fadzeTvrt+Zv0sfdJIW264/fRuyOXSUnsoNamqCkxYGr5u7UfBTDRiMPcSWb2M0MhsaHbljmd0mHtgE8P4BRB1dqaLCZR2L0Y7zCZh/TadwyKnC5SJVFQM9DVPtosNm/tqhxvRNVzmx2VsIA5CvbGMgMb5Yj1KcXM6DqFFjZh/icCzE4eJ6gcQdJmIS+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZzqqBR5nWRhKPAA7hTIi57cy6pwHUqsNGLfMMapHqg=;
 b=Wdo856M6KD4b3MJ5Z1QSGGtciOaGGah65bItpgmrYetk9Ma9Sd6b3MHCa1336rb8ZTd47a5hH6/c46GfIM4OecnD27cSSH4dMEYDgP5C6khxdSLOej7dYdPuowf7ITjN+kKN9P0vA5Jv2bSNRGVzHX994G9i//iPOQx6X1a34S0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB2974.namprd12.prod.outlook.com (2603:10b6:208:c1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 14:34:45 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%5]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 14:34:44 +0000
Message-ID: <044e7f8e-9fa5-d78b-39f8-84bce155d4c6@amd.com>
Date: Mon, 25 Jul 2022 10:34:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] drm/amdkfd: Set svm range max pages
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220725122317.24606-1-Philip.Yang@amd.com>
 <20220725122317.24606-2-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220725122317.24606-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7004702e-366c-4696-5d7d-08da6e4ad176
X-MS-TrafficTypeDiagnostic: MN2PR12MB2974:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zdb/nS3B6I2ogfnLuRsFtpgZcOxWR0kSlbhqL3Wbr9Qh6jqttFYaTiCVwhrT/OKBKynN7v9wDJ6rlqz+77Viggcsc07a9kjE2GEg+Vy3KFNVN3ewYSQHSZsoyXUfQyEhfCVCT0vXa19X+Tzjyzv+CNX0yf+M8FTJoIWZ+Stazszy+S2eQkjYxWemz8lW35lNM1aaVS/Xq+LCqAo1nDfAY0/YQ7L9vRxzQHAMX3kXVRLE87dn441mNjzfiC2Zkq6GtwD7IS1rAclvBM5lF2L9epW39KcQaewj2Ma0RbJHOnE5V0YYMkuYlpDhkQ3sCioJcJEtHGOos6YDBzHJOgeRmqh/RGld5c7H3TBXEn/nsrAz8ekCNGR2kF4BYffIAdtciSx1l3WlNB7HrFdep/slLkIBSl4nwmvqb3C5NET9ko5pIA+i9Wp+hYYOa8A88QEm/0q3TlQhiWkUKig0TaCTkjPDqlnY0qSP668AicclKwAFvEY3qi4vdcHPtadd3ruWf0IBtrmle8SiDih9SzNsNCwThnUzjpRqjqkJ7lAYRKU3dti2Qja5VFiawTTFP8wjStdxX4jsoksDo8zFRjLek158VwvG58h3RC7tIHE25ggB3BVeL8F+8hj03vvN/ozxJ7QIt4PRAHASnl1M71Nt62JUAxXZHzRDwCogvxnGF9ieBIVtHJa5yKJD9hWNFS04YnpvLq46YY8Y7fptSlRLVyiEHUL33Wrv0/61WMCuUfUEiZexwMxIiCmnNyjdCl7JMMWpQFhJQ99Zrgt4XlyMcun3ItSAymEIhGifp1XRDn5fOZ4VI2UgT0ReEd0sRxbZnMPiyZPpvNQcQsfoKu9Qfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(478600001)(26005)(31686004)(31696002)(6486002)(86362001)(6666004)(6506007)(6512007)(316002)(186003)(2616005)(66946007)(8676002)(66556008)(66476007)(8936002)(2906002)(5660300002)(41300700001)(36756003)(83380400001)(44832011)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TklqR0FkVlFabHoxOWNKK1E0aXRyOWIvdk9WNTkrcjlKVnlUWXNha3R3VmhJ?=
 =?utf-8?B?dzZKRU9MMmZhOFRxRUhodkhFQ1RWV3Vubmx1cmd3N2N6THNRWnNnT3VxTVg0?=
 =?utf-8?B?cGUyRVpEWTRveEQzNHZmSDQ3RWxXaHlGSzRCMmVkL2NaOUNFS2xlcG80UTNl?=
 =?utf-8?B?MU1BdEtPUDQzaXhlRVdITHFJZEJMOUxwblJiRzVYRVJFWjk0SGxCM1dUd2NZ?=
 =?utf-8?B?UWlhMmhVRTlRRGR0WW1ia1BpS0lpVk9od2lXZ3MxbHF3eVBjU1EzNWp6TDlh?=
 =?utf-8?B?YTdvWFdaZWVsZVpBVU9lNWFmS0lmTmIxZ2pUcnNrQVQzWm5IaFVQeStvVmJL?=
 =?utf-8?B?M2VMTjVRbkJsTlpXamNRelNlWFMvU2diVjFtbkpsLzlTa2JiK1o5cHhKUDFu?=
 =?utf-8?B?NEZTejZaYlMxVE9MNndNSFB0bUdIeWRQMmNXUzA0RHRqVUxmZ0VwSVRaRzd6?=
 =?utf-8?B?NTY5eHNPcUxQcFUvbG9pNUVQK081RVgwT2UwbVpLVEZVeFhRS25vQ0VXYU5X?=
 =?utf-8?B?RnNqbDlJaGZiakZJdEFUN3QzSnFwMm84MGRUS3FCbE51SFkybUYzbk1GNC8y?=
 =?utf-8?B?Nnc2TGwxMmtFSWNWK2RJUmE3MUZxTHM0cU8reEZhNlVkeS9mZEhWbVpvL3B1?=
 =?utf-8?B?UDZ4dmZ4R1p1aXZvNk05UU9xUzdTRmdnSGZiZWZwN3FqNHU4c1JSRGVSa0Y4?=
 =?utf-8?B?Y3dZNk9tK1JmS0FJQmVZMzZiRWYwRThlaDFHNVJnSlhMVGgyQW9FNGFjenRW?=
 =?utf-8?B?bGhCZUNOWjZhY0Z2RUZTZjR2Q2V2OGFZajZqVXBBWUY1WTR1QTBhTDdSVlhs?=
 =?utf-8?B?eHl6SFc3ZkljT1JjQnUxWmJlVFllRko2eUU0eHAzWHgyTloyQzhjQUFVMmZJ?=
 =?utf-8?B?WTN1VlpyQngrUXRyYnRnUnpSUjlKNWR5M0M1bnZQSi9DRi8yTjR1NXdIWnVN?=
 =?utf-8?B?ekJYTWg1a0xkL2JVRytvaWxFY1l5RzhVMU9TaHF3dVRJTlh3TEF2eVRYeVJm?=
 =?utf-8?B?c0lTNEYrYXNodXcwdWYvTG5CemRVUGFsWUlxb293UU5pMnpTN0VXbmlIVGlK?=
 =?utf-8?B?Y24vVDUyQW9iSndZeGdNMkg5V3d3STVUd3U4L016Qk90UHVDRHp3ZVZQdi90?=
 =?utf-8?B?UmlPZXZ4TFhLYXpZWDlmT3NwVU5OQU5nOWtmZkNCWnUxR24rVXNNenhoUi9P?=
 =?utf-8?B?S3ozaVlyRHVJb25MR2xlUG5pNHNrZVBEeUFOdjZCaGRaWjkwc3orS01ldDEz?=
 =?utf-8?B?dWRSWTAranJGNGdGTlNjNTV6ZGpiWGh0dnZJRXdMbXYzUEIvVjZIMkd1Smh4?=
 =?utf-8?B?UEh6Sndwa0lvR2pQZE5QOU1jME0yYlZZZ2ZnN3o2alA3a0UzRjVGcnM5RnlK?=
 =?utf-8?B?WC9qN2cxdTc1SkJaMEVZdU9zSndleGhrNzQ1UmxnMVdGZjUxNmk5MEM2TFBN?=
 =?utf-8?B?aDhBYXFGMEh6VFRHcU5Lb3ZPVEhtTHdwZU1NdUxYQmpqblNWd0JwcUExMUw4?=
 =?utf-8?B?Vk15RlBlM2NMNStMVVdRS2svank3Z0ZuTUJhQzZISEpvak9aM2VRdnJ1WnJz?=
 =?utf-8?B?M01nVUk0U1orQW84Y0tBQ3BTNUh3ZEFYTE15YmpMRzJvQ253M04xTDMzVC90?=
 =?utf-8?B?L1pTaUJFNnZieXRZZmM3VVBPc0M4THIrMDZLaGFZSmhBRkR4Sjg1Y0ZrZWRM?=
 =?utf-8?B?cW9SRy9VN3dCVWs4aEUzakYwS1Z5Q1piVkgvZlo2UGx2S1F6a1FGUXphdjYv?=
 =?utf-8?B?cVBpSy9UQ1hDMzAxL0FRc3VzTlRMUTcyU3JnMVFaVDBiTFNDam1JUHlnd1NK?=
 =?utf-8?B?NFBBYytJWlpXdE1QSnZHM2pVbWhuQ0RxdXpjbVJseHJnZ3Rlc0crN0Uyc3RS?=
 =?utf-8?B?ZXMrZnRnT2hFR0MvM1VUWVNqRGFGRHU4NExQRlVhdVpmeUN4TWVXbWIzV2VN?=
 =?utf-8?B?d3djNUNDMXpkbDJDeFlWSlRGYjh0S2lWajdGeGd4Y0FaWlN0ZjdkTGpUVHVM?=
 =?utf-8?B?QXNRRDZZT0hzWFhTbk1wNlVpTHc0N2N2VU5EcGF3b2xIZ2tERDVOU3YwOGRO?=
 =?utf-8?B?aDJscElUVTNrbHI1YmQxR2dkZGRFYkdIdWpkc3JlUmVPWW12NXYrS29wTmF6?=
 =?utf-8?Q?aAT6imjpnQsaOzGajyyYYdjAV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7004702e-366c-4696-5d7d-08da6e4ad176
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 14:34:44.8752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DbnvIL5rc2XbxjNGka3KKUDgxQNOhVZgBwSl04ZnzCaeoLzjWVJZQm7jk1ck8Uwweyt6l68fUOyXnXWo+DAAZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2974
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-07-25 um 08:23 schrieb Philip Yang:
> This will be used to split giant svm range into smaller ranges, to
> support VRAM overcommitment by giant range and improve GPU retry fault
> recover on giant range.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  2 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 15 +++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  3 +++
>   3 files changed, 20 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 9667015a6cbc..b1f87aa6138b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -1019,6 +1019,8 @@ int svm_migrate_init(struct amdgpu_device *adev)
>   
>   	amdgpu_amdkfd_reserve_system_mem(SVM_HMM_PAGE_STRUCT_SIZE(size));
>   
> +	svm_range_set_max_pages(adev);
> +
>   	pr_info("HMM registered %ldMB device memory\n", size >> 20);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index b592aee6d9d6..cf9565ddddf8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -46,6 +46,11 @@
>    */
>   #define AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING	(2UL * NSEC_PER_MSEC)
>   
> +/* Giant svm range split into smaller ranges based on this, it is decided using
> + * minimum of all dGPU/APU 1/32 VRAM size, between 2MB to 1GB and align to 2MB.
> + */
> +uint64_t max_svm_range_pages;
> +
>   struct criu_svm_metadata {
>   	struct list_head list;
>   	struct kfd_criu_svm_range_priv_data data;
> @@ -1869,6 +1874,16 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
>   
>   	return new;
>   }
> +__init void svm_range_set_max_pages(struct amdgpu_device *adev)

Why is this marked as __init? This can run much later than module init.


> +{
> +	uint64_t pages;
> +
> +	/* 1/32 VRAM size in pages */
> +	pages = adev->gmc.real_vram_size >> 17;
> +	pages = clamp(pages, 1ULL << 9, 1ULL << 18);
> +	max_svm_range_pages = min_not_zero(max_svm_range_pages, pages);
> +	max_svm_range_pages = ALIGN(max_svm_range_pages, 1ULL << 9);

I'd recommend updating max_svm_range_pages with a single WRITE_ONCE to 
avoid race conditions with GPU hot-plug.

Regards,
   Felix


> +}
>   
>   /**
>    * svm_range_add - add svm range and handle overlap
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index eab7f6d3b13c..346a41bf8dbf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -204,6 +204,9 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
>   #define KFD_IS_SVM_API_SUPPORTED(dev) ((dev)->pgmap.type != 0)
>   
>   void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
> +
> +__init void svm_range_set_max_pages(struct amdgpu_device *adev);
> +
>   #else
>   
>   struct kfd_process;
