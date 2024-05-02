Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448E2C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 12:42:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A977B10F2C9;
	Thu,  2 May 2024 12:42:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZFjzXZ6o";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EF0110F2C9
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 12:42:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Se91UkxY9RalT74+4nDYISSAyDsOJx8XFMC+t7tuQ2tK9+mR5B63Q0KXNcJ64dUWQfqGha7zVcFUt2i9xaNss12i5xqfpRNI/dYEd+kqVnSNCbBo7jb7nKeE+5+D1mKfT5K8Fi7hQz5o9L1HH/ZsccMe/TPdqms61sHpNpSorx0Py0dQAttlW+BcVMs92ItMhwaJG7m4YdrDsiNlJdiHQ049Fok7/suPkDhX0p5zt/iGIp37A9L7ikk1GV0J0PJIduUz0OZocGjnhJH8dcJ+s+7XgvBWuHkHi9rxp57pBRFIxRy/vsxqZAEGjBLpZ9i8WJ4V9ln21NWIVLziXIH57Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxdpNJfFwXhQl5CjiZGadKeZiMWkymQ1KF3AW6I2dvM=;
 b=UTJF+ENtmjZRgDlVz+x6hhdwSQRV6u9+VpezqqxVjHewchOA+LGsLuLkrj41Cc6quubGozIMXQ7Okub20YUkqnblwfWKXj93tymQaxDpG9tCELlYuCx7RUjBP/kgW4iGh15vowZ7rXB1+lS02vamUvEsN96xeJfqzEsEg70IL83DnB7DI1zRRzAQHbK8n0Mfvv8CFqnZ9yFzRAQn0YY6RNFPf0+AEa6CkwXWVuyh5+9MnW3ngRmS/6Q2iqVLINl42W/Crv8GncjRR14+bZ6hg2YY9U2UHXA8DBCaBAhEPKdAiXxS/Om4BqwtxJxrRf21IjZJtXKn1eDzg1iSiIRKIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxdpNJfFwXhQl5CjiZGadKeZiMWkymQ1KF3AW6I2dvM=;
 b=ZFjzXZ6oavdTC+gfA1pscReRfM51/omj11nMqrD5sGSb4XSoTtZxqoz/tlCVpoan5sCqOHZ9NXAOrizSeKNMezhQuck/AHUx0lGcw4memQSe1etaE08nbYXaoZ0HAqzjVU0D3CR4ay0E5A2g4x/eZAYI4VkjTD/DIUzIwA5Av/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by DM3PR12MB9325.namprd12.prod.outlook.com (2603:10b6:0:46::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Thu, 2 May
 2024 12:42:07 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::48fa:5dc8:b306:363b]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::48fa:5dc8:b306:363b%5]) with mapi id 15.20.7544.023; Thu, 2 May 2024
 12:42:07 +0000
Message-ID: <a28dddff-5eae-4856-8f87-26d534163a6d@amd.com>
Date: Thu, 2 May 2024 08:42:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Remove arbitrary timeout for hmm_range_fault
To: amd-gfx@lists.freedesktop.org
References: <20240501225655.5215-1-Philip.Yang@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20240501225655.5215-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::26) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|DM3PR12MB9325:EE_
X-MS-Office365-Filtering-Correlation-Id: 05fcaa6d-8976-4d3f-2822-08dc6aa5470a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlBrQVdsVzBHaW5HNmNBU2VMTnJIU2F3ZlZhM0V1KzI5d0oyczJhNkNzZ09E?=
 =?utf-8?B?Tzl6bHZMK0c3R2xPYmp6ck1tRTlENHczSVdFMmtuMGFRQW5QZkY2L25BS0VO?=
 =?utf-8?B?T2tDd1B4b3VRMENHb3pRUFZDV1BBYlIwb3N2amtwLzNMUFdYcTVjcXl2ZEU0?=
 =?utf-8?B?T0RNaWM0dHJmeTkzYjRPMXRCMkVSQzFrVUdqMWNFVndkZTg0M0tYYlJCd1U5?=
 =?utf-8?B?VG9oRWZCdnk0RmpZUTA5aWNqTnp0ZFpYSExyVVpVVGI5TlQ3K0ZtZEhOelBT?=
 =?utf-8?B?QzBaOVFwS1NobmUvcCtoMUhpbmo4QXJjZVJEYmdYSDBFcUkwaDQwVWJ1dFJ1?=
 =?utf-8?B?MzV2NVYvRTJlSGZWK1RiNnM5TnRBR094dHNaaHJEN2YyWC92MXBudlhKMklx?=
 =?utf-8?B?d1psbHVhT3NNbFhXU2xjWHRmTWpZWlhjaVRnb292L3FQdFhzN0c0dHozV0lh?=
 =?utf-8?B?RW52YTZvY2lTTXl4a21jaG9LRFZKSjUxcGE5SHVtVnJONXhMeUJ1SmI3Qi9J?=
 =?utf-8?B?T0tDQnBBZTUvRmY5V2ZseDg5ZlRxTVc2UTNsalBtTEx3UDNlRGhBSE16TC9w?=
 =?utf-8?B?amU0elFrdC9zNHBPdzZEbk4yODhNcXhYSWhLL0JYZFRUU2RHQngxc3VmUG5R?=
 =?utf-8?B?RThXcTh4aUpyazNnakttVjJZU2JSVDNWV2twWjJ1VWJ3VTVVUlkwdXNYajdR?=
 =?utf-8?B?U0VBTkZxVm5rOHk2MVVPUmVSbG1mRk1FV3NPOXY4dWJ2V084OWVvSXFYODVG?=
 =?utf-8?B?MC9ickJHS0J1V201TVdwK28rV3IyM1p0OUxCR2drNU1FemZoTGx3dVQ2b2tn?=
 =?utf-8?B?cGFyTDNlYmZzU3B3dWM5aWp0QXBtM2ZxUlYyeXplTEhvdXUzRUEyOXpVV0Vs?=
 =?utf-8?B?ZVJNS2diK3kwTDN4dmJrU3EvSEtRdVlMYVJlSWhHelhWemJtMDNUK0RqNC9Q?=
 =?utf-8?B?c0FGMXVWNFdDZElpRVpkMVFWTGliNmg2MEJzbmwzRldlWXNLMlgyTC9YOWt0?=
 =?utf-8?B?M255ei9YamNIS0pxK0xkOTBvNnlXNFgvUWxqR00yZUNvRXEwRHY0emJWVS9r?=
 =?utf-8?B?SnZrWFB0ZEx6TVlMcEJDM01UM0prSGNTSGpmLzVya3AwS1kxZUt5TDVLcVVP?=
 =?utf-8?B?amQ4WXVXNHdqMTYzZXZWTzlEb1hjVzNFaFRESm4yQzdLSTFtWFd3cGx5Y1RH?=
 =?utf-8?B?YjF4aDZpQ3UyL0RJUVZsZnZLWmVpendjTkRYNUFmTXBwSG9YQ3NRTEdxaUor?=
 =?utf-8?B?R1JsV0tjLzlDRnJ2Z0cxQnZWcW5vRTlhazFqRTFES003RTBPWHUrdE5YQmRp?=
 =?utf-8?B?UmNWQWJ3NVVIUnQ0R3grN2NUQjBmeUtvRDMydnB2djkxMC9PVGxkVnhZcUhF?=
 =?utf-8?B?MWVQT21HelVWRjBZY1JKQUEwdzNXa0R2U2hYT280T1FnVEgvY2R5SlFzSk9Q?=
 =?utf-8?B?V2VMY3FFSDczRE5DSExvZExjajVFaWNLdkJkRlVNOVgzVTlhSUpMQWtKMDc1?=
 =?utf-8?B?S3g4NS8vTDV0SWI0N0oyVWdZNUpYWkVwaENvazBSZHRVb2ErcXVuQTFkdHVm?=
 =?utf-8?B?Q0UwTms2eTBLN3VLcENMRzdGQmxGaWxsajNnSG1nbzZ3RkJkWGdjL0I1UThH?=
 =?utf-8?B?T0NKUWpxQ2UvaFVVWGF1dnF2YlZQQStTQ2F2bS8xL1VVUFNFK0lkckJMblhx?=
 =?utf-8?B?WFhiL3p6TUtXdHNURkxoeVo1MGlUdlFyVTYvMzVpbnZVK0NRL3pFR3pRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXphUkt2Nll2Q0pidEVEZjlzYjh6ZnV6TG5pMnJIZ25MYlFNZ0pMRG43ZFhk?=
 =?utf-8?B?RUVuR2Q1Vjl2OUxsZktMMzBDdnlCQWZXRW9vY1lqYWwzaG1qNFA4WUpyYURm?=
 =?utf-8?B?czFmQXhKNnB0Ui9EeUFUbitvNHpFdFJyRHFVZXpodWYvTlBLL2FCNlpDY21w?=
 =?utf-8?B?UjNCdmQzSWVxUXF6MUNUbXVvVEZGRGF2MktaTFMybGhGWHZWcVM3Rzl3d0RE?=
 =?utf-8?B?TTl1RThMK2QwQVMzbVh5WUFROG9nNHN6OVNEdUZNV1UySW5nalhTWnJCUzJV?=
 =?utf-8?B?VnYwTTh6VUpOaDIxUWxJd2tCaml5Z3FGTDVQYmxlNkJkNFl4L3JQbk5PSnQ5?=
 =?utf-8?B?emJxR1M1b3RTNUp1TFVPTEk3Wk9rNzMvYXJuajBGMVBOVnhRLzRSOVRiMmRK?=
 =?utf-8?B?cmFtbUo5ZEh1Ri9od05PT3JkRnFITXJvbzFkMmZLbFQwVjFydEJ4ZldiS0dl?=
 =?utf-8?B?UHEyWkJKTFZqbXhWQkhvanpyckJtZFVZdElkNnVIR3ExUy9zdjdZUWZYWjd3?=
 =?utf-8?B?bGNGUWtNNktSc21YMGhRdVFXdHB6M1UwT3VUdzZaRVJWZ2IxSURHOFJBbWdj?=
 =?utf-8?B?OXlOUDg1a0Uvb0V1RUZwbE4ybmFMVlVLd3pXdUpRSDFreldkWjJUZWtsM1Yr?=
 =?utf-8?B?S0s5NVlrRkNQZXkwM09uWllnZ3owaUJXbUxmUlYvUkt6am5HaFMvTk5KaTBz?=
 =?utf-8?B?c3ZxQXB1b3ZtMEc5OFQ2QXlOaW9raG4wQjB2UUF6OUVud3E0TXVqUXJ4QW82?=
 =?utf-8?B?OGJQdm5LdGZjT2toT2RQY2drRmZ5RjY3aXBxeU05Wnd3VmVVMEp2MVVpeEZn?=
 =?utf-8?B?c2lCdUpZUTBKeVc3SmNmME5aamVXenUwREtQYjVWa1MrQ0x0MEN3UjE1c0h1?=
 =?utf-8?B?ejF1aXFrc056S0grdTNkblFiMlpiWXk1QXFITUdBcEg1c3MxRXJHeGNrenlJ?=
 =?utf-8?B?RnpKMjlzc2JUSjV6bzU2cmpSSjdaLzliR1VkSG5qc28ySG1kSjUydXNSMExY?=
 =?utf-8?B?S2NPUStsbWg4MkQyZ0ZHWTZ5bzMyYUhXNjVKOVB4RUw1OTQ5RkdzbU5Rb1Vn?=
 =?utf-8?B?ek1zTEFzZDNyMHN1ZitsUkNmU01ocDRiVDdMN0VGQkhVczVJMmo3WHpMeElz?=
 =?utf-8?B?ODEwSWNIaXpJQm5nNmxmQlFvSWtyZ2JPUUNUY0hPVTZ6MG1INHBuY1pveENz?=
 =?utf-8?B?aDdxYUptQzNEOFUvZ3lsQVFnR0sxa1ZrZXFTaEk1cFlmT3JTck1US200VS9W?=
 =?utf-8?B?VkF0R3A5dlVXbzRod3ArWXBCY2tDWHdrVWFWZllTL3o0OE9wZmpFNnRaeTBJ?=
 =?utf-8?B?TDF4d1Jpeko5RTdKNFZFTjRSTUNqMlB4Y0k2OFI0Sk5BVG53dFFYNmRMUUQ3?=
 =?utf-8?B?SEJQS3RQeGUvZkg4VmRNS1F0amRQcEpwSGRFcjJUcTBhQ01yU3hJdUtmenA4?=
 =?utf-8?B?TjBvd0ZyR3ljS2NQOEt0Z21yM1lnWHZ1ZjVsTGJHVytLdXBFQlV2WXdqTThT?=
 =?utf-8?B?QzZGdVdYT0JIUFdTVXVCZ0l5eE51bnczK1pxRTAwMmxqYVRwYittNDBiK1ho?=
 =?utf-8?B?K2RTVURXSlVrQjNyOTBzUjNqMU5uM2wxUklSUEN5S213NVVDR1R4VHNZYW9w?=
 =?utf-8?B?emM1SCtuYnNYbmVWdkpQOFZoOVVhQkpWVVNPZVNOMGZ6amRhMGxkVSszWUpl?=
 =?utf-8?B?WjdLL1YyZkpqN2F5Y0tRQTh3Vks2RENtRjBFdTIwN2ZISzdOaXdvTk1sUHV4?=
 =?utf-8?B?VWI1ZmxDNGFkbmdhZnpTWThwRTFVck00VDZIUjB6N2hONWdwaUZqdVZPR0M4?=
 =?utf-8?B?ckNGUmozMzRxc2cvSHYvWGRZU1BmY1Q2WlBzdE85L3RaK2lGMUNNTFdzdng1?=
 =?utf-8?B?eC8rN2MvVXFDNGZKemFlN2pvQXE2VzBFZHlyWllPd200cWtpdGRkaU9KNFF0?=
 =?utf-8?B?UkFTbjdWTVY2SjBuaDAwOEppMEhlZ1cwSGJwTWFXU2hidUc2VHBEZlg5VEpy?=
 =?utf-8?B?WEJkcHhVcVJNaTBGdWNWdWliWGlTWkVXelBnUnJYYkt2UmRJajFGMy8yNE55?=
 =?utf-8?B?NUt1RXNrcWY5WEdoWmRJdTVjZHNwWFAzbHVRa3lFblhjYkRjK3h6clVrR2Uw?=
 =?utf-8?Q?Zf6p+a+yNLAjtonCtD1ps2/h7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05fcaa6d-8976-4d3f-2822-08dc6aa5470a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 12:42:07.5427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOQYZe+UAr6S9j8qAJi3WNmF+YMLjIOsY2V1YGt3UjeMIBhlEW4Bnan49tpq3jVs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9325
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


On 2024-05-01 18:56, Philip Yang wrote:
> On system with khugepaged enabled and user cases with THP buffer, the
> hmm_range_fault may takes > 15 seconds to return -EBUSY, the arbitrary
> timeout value is not accurate, cause memory allocation failure.
>
> Remove the arbitrary timeout value, return EAGAIN to application if
> hmm_range_fault return EBUSY, then userspace libdrm and Thunk will call
> ioctl again.
>
> Change EAGAIN to debug message as this is not error.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  5 ++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c          | 12 +++---------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c             |  5 +----
>   3 files changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 54198c3928c7..02696c2102f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1087,7 +1087,10 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>   
>   	ret = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages, &range);
>   	if (ret) {
> -		pr_err("%s: Failed to get user pages: %d\n", __func__, ret);
> +		if (ret == -EAGAIN)
> +			pr_debug("Failed to get user pages, try again\n");
> +		else
> +			pr_err("%s: Failed to get user pages: %d\n", __func__, ret);
>   		goto unregister_out;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index 431ec72655ec..e36fede7f74c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -202,20 +202,12 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   		pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
>   			hmm_range->start, hmm_range->end);
>   
> -		/* Assuming 64MB takes maximum 1 second to fault page address */
> -		timeout = max((hmm_range->end - hmm_range->start) >> 26, 1UL);
> -		timeout *= HMM_RANGE_DEFAULT_TIMEOUT;
> -		timeout = jiffies + msecs_to_jiffies(timeout);
> +		timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
[JZ] should we reduce MAX_WALK_BYTE to 64M in the meantime?
>   
>   retry:
>   		hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
>   		r = hmm_range_fault(hmm_range);
>   		if (unlikely(r)) {
> -			schedule();
[JZ] the above is for CPU stall WA, we may still need keep it.
> -			/*
> -			 * FIXME: This timeout should encompass the retry from
> -			 * mmu_interval_read_retry() as well.
> -			 */
>   			if (r == -EBUSY && !time_after(jiffies, timeout))
>   				goto retry;
>   			goto out_free_pfns;
> @@ -247,6 +239,8 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   out_free_range:
>   	kfree(hmm_range);
>   
> +	if (r == -EBUSY)
> +		r = -EAGAIN;
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 94f83be2232d..e7040f809f33 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1670,11 +1670,8 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   						       readonly, owner, NULL,
>   						       &hmm_range);
>   			WRITE_ONCE(p->svms.faulting_task, NULL);
> -			if (r) {
> +			if (r)
>   				pr_debug("failed %d to get svm range pages\n", r);
> -				if (r == -EBUSY)
> -					r = -EAGAIN;
> -			}
>   		} else {
>   			r = -EFAULT;
>   		}
