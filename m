Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041BDEB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 19:53:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EF3110E353;
	Wed, 21 Jun 2023 19:53:47 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBC0A10E353
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 19:53:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLMb1gMnE5ReFDJgeudOZTOfQtb2TIhmMrMpoCiBRXgcrNSU93pcWgz/utIFJZNWLpjC8Z2itn99tQZP0kGEDVYdZeXGafAvL3bv/XV+vZGRph3HA8jU7CsZNnbMeewoY3aAvtTWjC2VpGJdsbS6E5ohdQP2V/eBn1gagphQ1CKSN9hEP2aWgi6jgy/mYRFYuUM6KI4UOkPyntwyBTP7dzOnfycDqYfW7vryjSBW12odxBGLJ0WwRn0pokiJHZIJfVzukZvS/wkT7KQJrN+TrGhLsSQKz2r4fnTmarp+G3bJ6hnie3wsNxyhawHcpcnzgXMH6FhVx5D1QNzptsOHJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwypsEiQ9+nSQb/dD4OujUhynP1Lcu8hj3BQgWqexsY=;
 b=KeobG5Vf97j/alNVQwFNwvoqbwPGVqURKciRJMTObVFMgGdNZVgXROp5k66GgRWq5xVIlON70IgmE+OiV7thRX8rPlPqD6wM0w9jvm/KKYBQQ0NcLQt3jC4hAoP7esp8EHX9GYqms1vIbbSyyXICGTuPwhlZeE8VMzzarGWdKq8TqdHIoRFWfdjqTjth/zwLos6LkyryMFcLk+TZ0lrXnx2dawvmBm+io+W9CnT5NUtnIi5iVnlrdhTcjfhuLUeBdxRQav7c4j+QEz/cIBVTloDSgoJFcXAxO6lLuE6XVBOopPimnNSA1n9fsvlUlonFx0Flc6u9bjlqC5aEEEdNtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwypsEiQ9+nSQb/dD4OujUhynP1Lcu8hj3BQgWqexsY=;
 b=pzGRR16H1s0JnNg2AGtHMHWTJa2SsqSTqBkaXpbimRT1C4RTNdMbmKt1jA7z5WY7VrVw3rVdGUuwccIY87edeVPvCg2TSROJgdiZD0VrcpPo0C8/6fvGuLJbLEe98AzpaeHBozkA4lTfuYoU+g6njP0OZhkoxyl3AZb7IsC47ZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB8146.namprd12.prod.outlook.com (2603:10b6:806:323::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 19:53:42 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%7]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 19:53:42 +0000
Message-ID: <493c4797-da17-a58d-1c9b-5ad6f3e7c6d1@amd.com>
Date: Wed, 21 Jun 2023 15:53:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Access gpuvm_export_dmabuf() api
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org, 
 "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>
References: <20230621021131.2449890-1-Ramesh.Errabolu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230621021131.2449890-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e50523-a270-4554-755b-08db729136c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sXvkNJDiB6AugZebiZpAOlOD/9y9jCAQ4ufDbpq7xX8OPP+pV2fXaDW1bb3BRJvJLcxzHOfHYMAbZIOm0T0gL/X5Knu+eY7IaeScI8egJ9mMG+Na0+wmx2e3d+IHoEnMJXIX5vrhsYaeTj6nAoYEehYg4NugGPBiYqNJPnvtdkS5kbg54VBzVnRF0sAs96qFRB6mFlZWj4QjIOWw7YC75qwgVClT2SnDW0n1lCuD6jJZ6V2KwTW+zCjVXaL3xIA5kg1727S70+vmPWFd1Yejk228GUK/Ie/nZESpA1rSGGSncPMEltLW6LU3vEanyHYghDPQPvviQmc15gAzoKmhZQp4tsjr4jIoeq0SsYMJIRV2s5cVSkqE/BZ9DoPesv/FOy1HzHCFKqdRU1fORg0jbwENK9jD4QHg7T8yfzavM9jKun9xgRUhOQyFoZYKOzNo8ivdrFGK5O4X5YT/BUFaqXbdA3vpdzDnHU3p744K4wu/fyRkBWwHvSlHzmBoGi1wJz604SbCUeMQhhTRv8AB/GoYmR5J1CIfvmMAZylgd8YrJbioXkBndx1YmTULeEtZ8rWnbMbofX9BKIvrAr+/8GAED0Jz/5PhtXPt33nwxieUPyKUuM0HLDIfLfI2T5KQ0U2qvJN3UHSYk494mEPeMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199021)(31686004)(36756003)(44832011)(5660300002)(38100700002)(8676002)(41300700001)(8936002)(66476007)(31696002)(66556008)(6636002)(66946007)(316002)(86362001)(6486002)(2616005)(6512007)(186003)(6506007)(2906002)(26005)(6666004)(478600001)(83380400001)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QngrcmJDNTREaE94elp3UnVpT3NZQ1Y4NjMvZEhtU1RWMVMxV1hkc2ZGVlE1?=
 =?utf-8?B?d3p1UTliM1NMSURNK3NHQ1F0NGxnSjNHYi9Qa1d4bXZLSDA2cmIyWGFuNFl2?=
 =?utf-8?B?ZWJjQnhaQVBsQmNuR3BGTkd0UDBuWXJWc2ZIeWIzQWREN0kxcWw0a0FlajNx?=
 =?utf-8?B?Qi8zSWxVeGh6eDN3SDMxaFU5T1lLMzdQNjlEelowdU52dno2M0NyU1JscDhT?=
 =?utf-8?B?RFU5N3BYZEFFK2hQMEhBdTU4M2FocEUwRFZQTUxST1F0VldwZCtQQ2tGSlFE?=
 =?utf-8?B?YVZ4ckNmSHZqc0N6blVDV3FXNnV4dGNLRVd2L1E3RE0rWDZzRUw5NmNZWHNl?=
 =?utf-8?B?cmVaZWhrL1FSdWczT0JuMDZuZmMzME1HcXVtRGNlWlB3TzNITm1wa3IxQXlX?=
 =?utf-8?B?UHFoMThtOFpQYzNSYWREaGxGb0J2bjdpN0lPUW93NzgzcHZmUXN1Q3NMK29T?=
 =?utf-8?B?MFYwa3UwTjNDZkorK01MaW9iS1hPdFpmRktaRWFObWx2SGU5amhSWWJFWisw?=
 =?utf-8?B?WHFVb0R3NlpYTlNFdkNzS01QMms1a2hHbnVGNHF6SWpIUkZGZG15ZWVJQWpa?=
 =?utf-8?B?WE1WT1Z3YnZicUZUamNLWkNyVElLQkQwTVk0U3N3SzdEM0J2MHI5UnpTTy9G?=
 =?utf-8?B?cUZpQWpBeWJraUhHd1AzVm9uUUNVbVA2MWZDbjFYajhJYTJYcEVYR24zMlo5?=
 =?utf-8?B?eElXSjUxeFhxN3A2cUNmdENaSEFTYW5hUWFEbk9MY0VDcnV0b29IVkdJOEVv?=
 =?utf-8?B?WVM5TUYzcTFoNDhkYnFHVlBkdjRKLzdodkhFbUVKcmJuYVFiK1Bzb2o5T0wv?=
 =?utf-8?B?ZkhZeEVueXoxbHJoUXkxMDVZSllYL1lPaHBEWFZFQ3pKVTR4VFdXMy9sTUts?=
 =?utf-8?B?MWhaNkFkQ0pPR2RZbVljanJKUkxpRmRKV1NGdXorUEUwOGxlVlF4Q3E2aG04?=
 =?utf-8?B?VG9SeHpFR3dDKy9XUVJqZkVxcklyaUhyeHk2VUIwaERZenF5ZlZiNkVDNm0y?=
 =?utf-8?B?SS9PSjVINytPUFlzNlFuSjRLTytPZDlZSGV3ZVJiYm9zR2FGaXcybkNPMFhJ?=
 =?utf-8?B?MEkxcDVvVFRYY05DcFErVCtmMHBHUkk5blRHbTFWak16cVFmYmYzaVltanhy?=
 =?utf-8?B?bkk5Z2hmSCs0VkdvQ1dMdy80NGJ6dm9qSUlpMmhaOSs2Z1JYWi9HNjVvLzN2?=
 =?utf-8?B?OU5JdXJ4NUlJN0U1Qnl1K1ZQVVhSWHUxUks2dENPNjBCaEhzNGwwZTRiV1ow?=
 =?utf-8?B?eFlzcVQzMVhoZkE5Y2gvMXpDczdnb0dWRkU5UVdqaktlOW0zR21nRVdrTGRa?=
 =?utf-8?B?dHJMSlBHSFZicDY3RFRRcncxUGlGYVMvWGJrblljR2kyYmF0SnFrTWNJM29j?=
 =?utf-8?B?a1hJV1VGYlFJMVA0YjNvSktyMVZJNGJSTEpDTlE2T2VndnJuOEc1dWd0NFU5?=
 =?utf-8?B?bVkwcjIwa1lZNTBzcXdya05sQ0VrVVZIRkc2OFAycElINWhCcFAralJTN2px?=
 =?utf-8?B?d0tOTHZTTEZ4VVQ4M1M0YkVuRHRGK2RKMk9tV1ArNjhBaC9RSHlpbXVKdkxY?=
 =?utf-8?B?VDBRbkJUNnFZVTJrOGVUU3VYZWREMlZkUUNtQ2hOcXZrRWVPNThrSmdDbXRX?=
 =?utf-8?B?R1BrRllCYUN4aktsK0g4VFAzdUFwWENDQ2E1YlBWYk9Ic2Mvd2s2bkdWQTFZ?=
 =?utf-8?B?Q0hLUDJGYlgyRy9jblZ4SWw1dnRpeU1ObXB5TDJRcDMzeDNNTGdDWlZYMGli?=
 =?utf-8?B?bjlzUmlQQlUrVDRkdmQ0a1hKWWRhWmZLT2c5NFNxZDBISGdkM1RYNkg1Mmtz?=
 =?utf-8?B?OHZRVVAxTVRPbSsyem9maFpnbjFTUHVDSjZ5WGtkSzY0RG1sM21rcW5FLzZp?=
 =?utf-8?B?ZnpwZzFheDY0MDBBcXNPc2JNQS95cktJTDhOMEpSQWFxaEhGY2l3aVBOcVZ0?=
 =?utf-8?B?RzNheTM5NmFlcmUzQ1hrWkM2aFVub0E0OHBiZzRPM29YTFEzbUVwWS9CVGtw?=
 =?utf-8?B?bHJGYXlhZ24xNW8vemp5ZjBiNkd2NFIzcXpiejh1WGl3SzRnZjNyUk5zb3Av?=
 =?utf-8?B?Tk4vWnpkdG8yWFh1THZOSFlucHRsbWxUY2lTZDYvZVNsQlppNlJwQ2J6cFBk?=
 =?utf-8?Q?NWOhL6O43OQ4yLWOK3w4yW4xE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e50523-a270-4554-755b-08db729136c2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 19:53:42.2533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wxOR/5tSwCi/8an8nyEElZyL1qfj6ToRJxYZ4c28cgef1/E4NR3gOJhtixyP1J8llIBoHpwwMfsROr0luhLtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8146
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

Am 2023-06-20 um 22:11 schrieb Ramesh Errabolu:
> Call KFD api to get Dmabuf instead of calling GEM Prime API
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index cf1db0ab3471..c37d82b35372 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1852,13 +1852,13 @@ static uint32_t get_process_num_bos(struct kfd_process *p)
>   	return num_of_bos;
>   }
>   
> -static int criu_get_prime_handle(struct drm_gem_object *gobj, int flags,
> +static int criu_get_prime_handle(struct kgd_mem *mem, int flags,
>   				      u32 *shared_fd)
>   {
>   	struct dma_buf *dmabuf;
>   	int ret;
>   
> -	dmabuf = amdgpu_gem_prime_export(gobj, flags);
> +	ret = amdgpu_amdkfd_gpuvm_export_dmabuf(mem, &dmabuf);
>   	if (IS_ERR(dmabuf)) {

I think you need to check ret here instead of IS_ERR(dmabuf). Please 
also check with Rajneesh. I think he ran into this before and I 
discussed this fix with him.

Otherwise the patch looks reasonable to me.

Thanks,
   Felix


>   		ret = PTR_ERR(dmabuf);
>   		pr_err("dmabuf export failed for the BO\n");
> @@ -1940,7 +1940,7 @@ static int criu_checkpoint_bos(struct kfd_process *p,
>   			}
>   			if (bo_bucket->alloc_flags
>   			    & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT)) {
> -				ret = criu_get_prime_handle(&dumper_bo->tbo.base,
> +				ret = criu_get_prime_handle(kgd_mem,
>   						bo_bucket->alloc_flags &
>   						KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ? DRM_RDWR : 0,
>   						&bo_bucket->dmabuf_fd);
> @@ -2402,7 +2402,7 @@ static int criu_restore_bo(struct kfd_process *p,
>   	/* create the dmabuf object and export the bo */
>   	if (bo_bucket->alloc_flags
>   	    & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT)) {
> -		ret = criu_get_prime_handle(&kgd_mem->bo->tbo.base, DRM_RDWR,
> +		ret = criu_get_prime_handle(kgd_mem, DRM_RDWR,
>   					    &bo_bucket->dmabuf_fd);
>   		if (ret)
>   			return ret;
