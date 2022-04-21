Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F3BC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Apr 2022 20:17:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F82D10E02B;
	Thu, 21 Apr 2022 20:17:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97E8010E02B
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Apr 2022 20:17:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YM/pOQ6xHVyXwEer0FLySh/D72aKQq2nFxRe7Q8IevrF4Q/sTRMWlLsgL2mQ5EyUMS23TWwG895NLuZ/kI9U7qrFzpvG/wz+xkUpwTqCkuTKyJqqgS2XTlWSH3PniVHWe3jWL80UyfpYScsbegsOHd1JkdSLJtl3bE5nPgQSEhLve+hRH7A0ar+cfsJTFAqMHRxwK8xR+s0g9ehIMwJmmNUw3W/eolR/847nAMe5Y233S4DolzmYFxdPbfBr4oppw7PrcSS7HZt+PtVQbBGvTHaYE7pRTcuJMP2UO+9xLesxaRj0Yk/uuM577ONP2rpZ9wNwm+pShP6ElnU6RNL7VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSj5MOemvaoL+ggq3qYnijUluJLF7GpgBfeG8tlCr3M=;
 b=U6fT5Sch0rOYBSl9crYVkVAq+Aa03KSBryDFuG5a+s+CiEfQO5cVS7j8DwM5PtpvtFYcVlC7D4qnH8cZRJ5wbIAkQVuHo8mbCZOPQeq+fTLdhWdhLNUlUNffOsVlkh3VU9NcI8pgiaq0+xwYOYkRAFc+pK3gzNiJhmuJk+NN0Sw300DWOZFFhPcNhJuGrth/s64CiugvgyJLVZ1DyDjtBAXGiWM1aPjrBVIQsvtNzVaYSb3YIXb9rqCsfuK6rN30WIUnKG7oyALQOernf03rdEru7WZsfsWpRtJ1RH+lV85qElWOsSVYBrPlvNhLteyjpi4YoOtQpWVPLrnRQ6HXXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSj5MOemvaoL+ggq3qYnijUluJLF7GpgBfeG8tlCr3M=;
 b=DOI/Em2BM9FQh46aheAiSsSKdlBk8LgHkobp2VVCGGIab5H4pESi7ObjQ0E9EqrOtLB1Si2qoD+I4JBiJtnB8u+hOW66pXg5Mi8NbehOLWB66oUoKDou8+DvQ2CqG1G2EY7+zZDzh7QjDPT7qNvVy02KCwFtoBPKslzoi5PYpOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CO6PR12MB5460.namprd12.prod.outlook.com (2603:10b6:5:357::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 20:17:42 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%9]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 20:17:42 +0000
Message-ID: <8c272923-ddfa-9151-4efe-cf8127ea995f@amd.com>
Date: Thu, 21 Apr 2022 16:17:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] drm/amdkfd: Update mapping if range attributes changed
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220420004742.8780-1-Philip.Yang@amd.com>
 <20220420004742.8780-2-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220420004742.8780-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82743f55-1368-46bf-6a25-08da23d3fd5a
X-MS-TrafficTypeDiagnostic: CO6PR12MB5460:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5460B25A6A9C3D5D5E63C59092F49@CO6PR12MB5460.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Wm5j00WsSiu0brMjj6P22S9av1pnrw0EO+CncqGtdlAcqvMeKOsKrpkdUZ5bfJihz/Q/gBbUOEhvVc6LvZCgPQwleuvq7/6+qaBClIdzh/TQiFckKEomTQxYU+e1Es55MiRt2zvcq9H6VV+JWnlp/7rQxp8gGDhCxeRPlXQLRhkaUD3wM+pILq2fzo6CVtHB20sDvkNBMA20Hii+cCrYj29pWtt5wbfNMvkX8ndECwnJeRyq+5h3Ol0C4qgM9oV7CkjPnGGObuSnjRyQZIyjIvklWgH/PbNaX34paDgB73GgA39nHPIU8/ccAzx768HayWgNvyNPEAOVOFs3NWc7QR0q8XxbVz/jB2c7yAe3pAIjt8cEOb6dfjq3+/rEIA+4nuKOhydxK0UKSQUOVluwjw3Qdwrqbfigv9BwbI01jnDyJeL7D+W4V3rTfGHIXUC5rNGjAYYkNhpbArlImLE9ILu/xwyIO40+WD4HV9Wi4ebWi3T8kBf1CAwuNegSC6HO53xvacejcKuNXUHkZCWaK6ySa2j2FW0EuvwivmILqpvAlHi3JgiQ12L8CciZj7jLmFKj5XCHqvGCcU7500GRmcWmD2VsDxzOq0b06VM4ROQVNR5E64hb/egJHtwgl4Cj38o9KR26z1hfoy5xt0yL1PzjWlgH89n48s0Q8ZyHiyp2CAqx2BHgEbChcdCQZWSzM0/aD7GfeUrbbVrdxksqYujrhkU2mLTyoWIYPkzSXM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(8936002)(86362001)(8676002)(66476007)(6486002)(66946007)(83380400001)(508600001)(316002)(66556008)(38100700002)(31686004)(31696002)(15650500001)(186003)(36756003)(2616005)(2906002)(26005)(5660300002)(44832011)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVIva3luSjE4MmlpaDRvUTNpcnRMaE9CWTJWMTJpVzZLai9CbEErbnRVUDdo?=
 =?utf-8?B?emRMT2dZeUFuc2cyeWFmczFvTnRqRmIwdWdvNENvOEthR21PRlZOTXdwRUhW?=
 =?utf-8?B?Tm9iV2svNW4zQ2sxbmxHOWJ6cWhBcGdJUEVtNnM4S1A1MlRNbEs2eTBSeXl6?=
 =?utf-8?B?aGM4TnFGRlViNXV4S0w5YmFuUUZSSDhSU09ocjhHWmdweDk5S3RYdUgwakE0?=
 =?utf-8?B?b1dDc3l5ZVl3RUpRNTVqT0VOOGRUYTBDbnhlY1RhSDhBZ2JYUzRSMjE2aWYx?=
 =?utf-8?B?R0p4TDJ2aWNEdU5mU0YxVUEvMlhlZUVRUU9VdkQxN0hCTUl6WDl0aFJnNVds?=
 =?utf-8?B?b0pNN0diam1Gdi9DT1ZqQ3RQNURNRE1wdXk2WFlQMHhvdFdhQ081WGw1enJv?=
 =?utf-8?B?aHJwTmQ0SVdDREpNbHRveFdnUmZDVzYwMU5memlXaUFaQ1dzWFB2RDUwNVNs?=
 =?utf-8?B?bnEvZHdWQnNUMGhHVnhYNkNJY1UyMzdGV0NzOG1uczFDVWlIc295cEppVU9q?=
 =?utf-8?B?Rm5GK29rTTFjMExubnhDNGJ5REcxdHVNR1dOZ3J6QXVOUFlaVHc4VGR1Znpt?=
 =?utf-8?B?ZTM2SERRMEd6UmR5by9RanlCVEZ6aXArZ29kaXhOSENVTkpiRVVsVTZCeU5m?=
 =?utf-8?B?akRxby96dk9xNnYrbENuVG9QSHFqR1lDRHlkWlR6NEwvcC9uRjV4cVEySnlJ?=
 =?utf-8?B?TFYwMXZtcHB6STBMSHQrOVlvbkV2Y0kxWDBxWWpXWFRKY1Z3VTdUdWY1QUZM?=
 =?utf-8?B?MXhCWlhhWDVLUlZweVRFL2lMOTRxNURJQXRuOWhsNXdVbHpyN21aWnFqZ25W?=
 =?utf-8?B?NTRZYmRhUGEzYUJmeDQ1NEFxaUxlcEtlVzE3OGE3dEdGT040a09WN2dRVUFr?=
 =?utf-8?B?OExhVjV3V2V6ZEZlSmQ4S1ZrUjhOOTNXQUhnMmtTM3VFc1RrLyt4VEdCQ29X?=
 =?utf-8?B?dDlKb1V4a0FUWThRdGoyYWJpRmJ1OGFBVnNlMVhDY1U0dXpzSHpvZzN4Y2U0?=
 =?utf-8?B?RHJHT1k1QzI4SjlMM1ljd1NhZ1hUb0NBNGJmWitPNVoyYzBkK1p3ZkR6T2VO?=
 =?utf-8?B?THpzMVNPaFdKUGg5a2dzQjhsbUR1cXZaVVpJNlVjWWpZN3YxeWwxWU1EdlZK?=
 =?utf-8?B?UmE2bk1kY2FodXZFcjYzMUl6U1VVQ2FXRWlGMmdsN2JSeTQ4UExtN2dzSVI2?=
 =?utf-8?B?VDhFVUFqM1ZROWxzYmkxTnV6eHBySFROL3JESU1mODB5dnlZejNkZWtOZFV3?=
 =?utf-8?B?RzkyWElqVFdjMndPMXVGSkNtUGpXWmtOYkZYZlREQk9xWTl4S3MvcS9MTzgy?=
 =?utf-8?B?TVJ2RzY4Z2V0V0ZHc3NGOGNrWlVJVGlFZVhOcHphZlhuVWIvTnF6VGlMbjBG?=
 =?utf-8?B?Z3d5Z2U1NU5NcTlLZWFzUnFLK1FuRW1HRkhNTnFVSnAxTFJVVDhZNzhUUExo?=
 =?utf-8?B?NDFxZlJpK3VkT2ZkSGZFOVVadnRTZng4b1QrWVFPR0lIYnVGUWRuT3FEQXhx?=
 =?utf-8?B?eTV5anlZNmlqNEJVN2QxdnFvcUVmZHhON1NNRHdRdkR3VW4reUtPOTFSenRY?=
 =?utf-8?B?aVBvbVc5U1h3RGg1REZEZytBYkNtbU1ESmRGa0xpRkFDNWN1ZVpGNU5nbWRW?=
 =?utf-8?B?RmlEN2E1Q0xiYk44TUlOcHFSVUZodWFjK1NETVFVTE9VM2ZBUWFxU2ovUVEw?=
 =?utf-8?B?QkNrdys2b1ZFM1RxTi9RZUpkN1ZtU0NUanc1WE11UUtFaTdWTXhMS1A0WGxK?=
 =?utf-8?B?anJUUXZBelpDTHpCeWZpcjRXMGl4eEVJYnJpSUpselpFeWFNbkMvYVVVWHZ6?=
 =?utf-8?B?eU90RjEvcGJ1THFlK0gxMFRobllBUWFMYWZLZDVTMHlZbTFNWm96OEhick1Y?=
 =?utf-8?B?Z091ZkZITGh2Y1dkME5uVCt3dEhOWk5zSENrVGd6VjRrQzkvMHVEVlhlNzZZ?=
 =?utf-8?B?MUVuTHB1OHNZOTRzNTBkSXVXbHJtaTVjcU1pcHM4bUdWMjdXbjVNS3djYnBv?=
 =?utf-8?B?ZWlBVnQ3dGpmTEhaM202MTgzR3IyV1E4UU1WVExLTHdIWm1Td0lOQkd5MUE2?=
 =?utf-8?B?eklYZFQxZ1Ard2pXSmpPL2Z4YTlwb1JMd0FJTW9sOExGQWlKZFpCNXYwTngw?=
 =?utf-8?B?cTcwOWh0WFI2dW96dHRDNXZ3cS9ab09yNGlacVJBbDZ0dU5JeDUzM3BZOHcx?=
 =?utf-8?B?MWNkSVpoSzA1aThIOHYyWHB2RFlSZy9PYnN5eVFXSHRIa2hXdjhWbGQ4UVZF?=
 =?utf-8?B?MVF2aWs3MDNEWXJnVDBhR0ZEWGx6OEZtaXhIVHNQUHFZRlkxc3JINGNzc2dV?=
 =?utf-8?B?NkpJQUh4dmE3a1VubkNBakVhWHJGQWVKa0JQQlQyNE1HMkNFNWllZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82743f55-1368-46bf-6a25-08da23d3fd5a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 20:17:42.4166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bIZudHRQ+eV96QGJIptiD578OyhQloTHws8TsO186Gc8e3q9F3SA8ULnIWkOfBzeGmXQu7CgoXydQqn5rsL+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5460
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

Am 2022-04-19 um 20:47 schrieb Philip Yang:
> Change SVM range mapping flags or access attributes don't trigger
> migration, if range is already mapped on GPUs we should update GPU
> mapping, and pass flush_tlb flag to amdgpu vm.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 41 ++++++++++++++++++----------
>   1 file changed, 27 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 6be1695f3a09..0a9bdadf875e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -686,7 +686,8 @@ svm_range_check_attr(struct kfd_process *p,
>   
>   static void
>   svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
> -		      uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs)
> +		      uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
> +		      bool *update_mapping)
>   {
>   	uint32_t i;
>   	int gpuidx;
> @@ -702,6 +703,7 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
>   		case KFD_IOCTL_SVM_ATTR_ACCESS:
>   		case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
>   		case KFD_IOCTL_SVM_ATTR_NO_ACCESS:
> +			*update_mapping = true;
>   			gpuidx = kfd_process_gpuidx_from_gpuid(p,
>   							       attrs[i].value);
>   			if (attrs[i].type == KFD_IOCTL_SVM_ATTR_NO_ACCESS) {
> @@ -716,9 +718,11 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
>   			}
>   			break;
>   		case KFD_IOCTL_SVM_ATTR_SET_FLAGS:
> +			*update_mapping = true;
>   			prange->flags |= attrs[i].value;
>   			break;
>   		case KFD_IOCTL_SVM_ATTR_CLR_FLAGS:
> +			*update_mapping = true;
>   			prange->flags &= ~attrs[i].value;
>   			break;
>   		case KFD_IOCTL_SVM_ATTR_GRANULARITY:
> @@ -1253,7 +1257,7 @@ static int
>   svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   		     unsigned long offset, unsigned long npages, bool readonly,
>   		     dma_addr_t *dma_addr, struct amdgpu_device *bo_adev,
> -		     struct dma_fence **fence)
> +		     struct dma_fence **fence, bool flush_tlb)
>   {
>   	struct amdgpu_device *adev = pdd->dev->adev;
>   	struct amdgpu_vm *vm = drm_priv_to_vm(pdd->drm_priv);
> @@ -1291,7 +1295,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   			 (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
>   			 pte_flags);
>   
> -		r = amdgpu_vm_update_range(adev, vm, false, false, false, NULL,
> +		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, NULL,
>   					   last_start, prange->start + i,
>   					   pte_flags,
>   					   last_start - prange->start,
> @@ -1325,7 +1329,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   static int
>   svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
>   		      unsigned long npages, bool readonly,
> -		      unsigned long *bitmap, bool wait)
> +		      unsigned long *bitmap, bool wait, bool flush_tlb)
>   {
>   	struct kfd_process_device *pdd;
>   	struct amdgpu_device *bo_adev;
> @@ -1360,7 +1364,8 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
>   
>   		r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
>   					 prange->dma_addr[gpuidx],
> -					 bo_adev, wait ? &fence : NULL);
> +					 bo_adev, wait ? &fence : NULL,
> +					 flush_tlb);
>   		if (r)
>   			break;
>   
> @@ -1481,8 +1486,8 @@ static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)
>    * 5. Release page table (and SVM BO) reservation
>    */
>   static int svm_range_validate_and_map(struct mm_struct *mm,
> -				      struct svm_range *prange,
> -				      int32_t gpuidx, bool intr, bool wait)
> +				      struct svm_range *prange, int32_t gpuidx,
> +				      bool intr, bool wait, bool flush_tlb)
>   {
>   	struct svm_validate_context ctx;
>   	unsigned long start, end, addr;
> @@ -1521,8 +1526,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   			  prange->bitmap_aip, MAX_GPU_INSTANCE);
>   	}
>   
> -	if (bitmap_empty(ctx.bitmap, MAX_GPU_INSTANCE))
> -		return 0;
> +	if (bitmap_empty(ctx.bitmap, MAX_GPU_INSTANCE)) {
> +		if (!prange->mapped_to_gpu)
> +			return 0;
> +
> +		bitmap_copy(ctx.bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
> +	}
>   
>   	if (prange->actual_loc && !prange->ttm_res) {
>   		/* This should never happen. actual_loc gets set by
> @@ -1594,7 +1603,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		}
>   
>   		r = svm_range_map_to_gpus(prange, offset, npages, readonly,
> -					  ctx.bitmap, wait);
> +					  ctx.bitmap, wait, flush_tlb);
>   
>   unlock_out:
>   		svm_range_unlock(prange);
> @@ -1690,7 +1699,7 @@ static void svm_range_restore_work(struct work_struct *work)
>   		mutex_lock(&prange->migrate_mutex);
>   
>   		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
> -					       false, true);
> +					       false, true, false);
>   		if (r)
>   			pr_debug("failed %d to map 0x%lx to gpus\n", r,
>   				 prange->start);
> @@ -2828,7 +2837,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   		}
>   	}
>   
> -	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false);
> +	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false, false);
>   	if (r)
>   		pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
>   			 r, svms, prange->start, prange->last);
> @@ -3241,6 +3250,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   	struct svm_range_list *svms;
>   	struct svm_range *prange;
>   	struct svm_range *next;
> +	bool update_mapping = false;
> +	bool flush_tlb;
>   	int r = 0;
>   
>   	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] pages 0x%llx\n",
> @@ -3279,7 +3290,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   		svm_range_add_notifier_locked(mm, prange);
>   	}
>   	list_for_each_entry(prange, &update_list, update_list) {
> -		svm_range_apply_attrs(p, prange, nattr, attrs);
> +		svm_range_apply_attrs(p, prange, nattr, attrs, &update_mapping);
>   		/* TODO: unmap ranges from GPU that lost access */
>   	}
>   	list_for_each_entry_safe(prange, next, &remove_list, update_list) {
> @@ -3312,8 +3323,10 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   			continue;
>   		}
>   
> +		flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
> +

Can we skip the validate_and_map if update_mapping is false?

Other than that, the series looks good to me.

Regards,
   Felix


>   		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
> -					       true, true);
> +					       true, true, flush_tlb);
>   		if (r)
>   			pr_debug("failed %d to map svm range\n", r);
>   
