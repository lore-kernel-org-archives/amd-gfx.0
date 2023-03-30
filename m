Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9C9C761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 14:35:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2930610EE97;
	Thu, 30 Mar 2023 14:35:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C6FC10EE97
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:35:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZogOlyZYb/BauKVbBQLkhBG0YTrT86OTjh6MHkrW8SJxzTCOJZh0w99gd2XoPb43AWngnH92j+OqYFvaHo59cmwVgiN608cmZEnxS+vv1Ud9xO8ZFMeoYckesDSBSQpHSxagJUIG/0Vun55yZN5b6/91pfiZfjITedplpeya/6J0gmYxij0kFltdn80Ue8IRl5qJZAi6cQ/k/b4cJ6l6Ux5Ix0ALNA2YG/N+5EoSQCEQhPmZD+yKV1ztkdJOEM+WldoA7KNp1wjiP4lFFqsIxl5RtPK/l1TaGIy1sBlvzvy8FWR8jeGsf0fWMfJGw5fLo63VL+jnMgTFdYM9eorog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CN///OFhSRrr2sUgz+v7R1sxPLP6Z3oplE+Ah0paq5c=;
 b=jTriYI8vUK2Qol6ftUDcqV5/zubi7jj+vicGL/PTz4G1jzyS+oqYF1M7JvwesnATRC1XUI7tLy03UJ8JG6hhSNWwvECg/I+wrEODZunFPW7mgXURwld/HI5MjSjeFiBd6uYGlenYWMDxc85+n0FfT1Km5JbyvYCwLNZcgpEqbR1eg1Id9xDQSvLB6eaPhFg8EHYxRFgSVHlbQXEBHeg2iIeRQY25MhPDr7cpkXmwLuCcF96wGEi11r43BQ6TLhPORfplxF0RfxNygADLMuxfeGmBA1yUqCZOq3oo0+T20A79r1uy/bBLRKNZL0aeCcP6le6chBpVE6+9FLtaK8woDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CN///OFhSRrr2sUgz+v7R1sxPLP6Z3oplE+Ah0paq5c=;
 b=oLOZQvf634kqKc3p/e3guB54rkczKAA9Saax4vVodAM7EmkyYnBPstad061iI4zGNQteo7Z6BpHTFixXIYqApBBVWj8t6+qbS7f6aBhjJfXmsPryna+NKCtzUnz4X3yzfXytQvThF9AXe8qDIQuVtDJkPguFF1qHSWG73MWXfHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.22; Thu, 30 Mar 2023 14:35:01 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 14:35:01 +0000
Message-ID: <de6368af-b16b-0794-6eda-465d5046c142@amd.com>
Date: Thu, 30 Mar 2023 10:34:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-11-shashank.sharma@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH 10/16] drm/amdgpu: validate doorbell read/write
In-Reply-To: <20230329154753.1261-11-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::25) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|SA1PR12MB5659:EE_
X-MS-Office365-Filtering-Correlation-Id: 70abf844-ca3b-4640-bbf2-08db312bf1a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3u5MDVs9J4ctq3sFIvgZJ+AfvxOnNc9ogGFUm6JzBQsLyEt5f6e1U+NWyAvTUpUjbGsawlQMemymCoqmsQrNnJnUu7K/km/uDe/xD481oENt6DmcjEcP+VZ2kdA//qG8iUfbAYDcDuIZ1KaYUKACLOgbzJ4zLLlMt3A5/0DQlHdAApeTMHnrdT9s/SFXHeWwMVTeE1x1pvOt/JpLz0Y0vSauwvJiXGXJNzan6u6rWzb2IdEAjYJdm+O8xs/Q0g3xXZgNPjwjDqhypK2wBV4JcPU+HScfQvBVM0jaZL74DOhb4T2pzn71gJhk9I/iQFl1RF3rc8UGHPxWdgmzPipXXbADXCCR1mdqS0vwowlwafA/KFfA/Kcna6zvX/3APmeFUwkBHpUal2t5mHgmSdgd3e/Psm2EwfEmjEIZEKMX8ubknU8OayEy/r7eLgHGH3lOxKWaTqMuzpt59AuNIGltlqJ/ywLOlvcAAsaaAcGfBBrDzKBbUc7ImAB66W3Jh+G6hZcjoDVcrm2k/dZC1PJFNaN9C+MpN3Tm+MpSwZH8hzJt3WO808Wd9ujyXC6XgPG2qil+5j5cquS2MAoZjplSchd2uiUlJIovels15yDsnUxRy7ox9eBEhhW2C8CcXZ1tMEQvpXfaQpQ0I9n5N9UWWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199021)(31686004)(36756003)(44832011)(38100700002)(5660300002)(8936002)(4326008)(86362001)(66946007)(41300700001)(66556008)(66476007)(31696002)(8676002)(15650500001)(6486002)(54906003)(2616005)(83380400001)(53546011)(6666004)(6512007)(2906002)(6506007)(26005)(478600001)(186003)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2Zzank5YXFtdGRPNUovRXR0d0MwLzA2aHBEKzd5Q3BEbmc1K1h0QWZERnpq?=
 =?utf-8?B?ekxwbmRqSGlSWWpqNExrMWljZDY3bXliL2xWTm1aV2xmaG5GNXZsb1ZJRUJy?=
 =?utf-8?B?U1ZBbC9xaDlLQzF0WlVoVHdESUpKWW5FdXRLTkZ6Si92bWhMeFhHR3ZyZ1lz?=
 =?utf-8?B?eGlYcWlkM3Z3S0o1OTlyeW9EV3g4RTk5TjlsVXpMU1pncVpqOGIvQ2lRck5Q?=
 =?utf-8?B?elViNmgxNjhaUUUrOU5WUU03TWpBSExxcWhFTWxpc0NjVlU1NGZsL0pRU0Fp?=
 =?utf-8?B?eGRKN3ZlYTM1M3BPTC9Yb3NsalJGT2E4TXlhc3JjcHJ2RXBSOFV0Q2ZRbjlS?=
 =?utf-8?B?RTBwd2daMExJY2hhTUVRSCs4c1dtMjlyYXZ3YUk0UDdJVzRuOTZpWUpHRS9S?=
 =?utf-8?B?VzNTNENMSHRGb1VtSkhmNHlsOHh5MmJFd0JNZmtwTnlHSVpZK0svVk5BVitp?=
 =?utf-8?B?TXNJWStZaVZldkVOYm9wVFZhVUtqOHIrVmJnUnk1SnMyNlRaRXFjT2tlTHhV?=
 =?utf-8?B?SU5FdzRqNXBXMlpuVXJReVJtZWVHUUJsU2d2UjRXSE9iVEdlanF1Q0RwMzdS?=
 =?utf-8?B?T0dDSnlYcVBZWG04U1NSbGVIV3BraDg4anluRlAvL3RVS1JSV2NSL2xpL3l3?=
 =?utf-8?B?RTI0ZEVRU0R2NFJYVWNwQW1wRG52TlIyOUIxNVNkb0lUR21HUXdyNnpSd2VK?=
 =?utf-8?B?YWV5Q3JpdkdhLzhEd3FxRHBCbHdqbVNac2d6MWEyTE9VYWJYbzl4MU15V05r?=
 =?utf-8?B?MDhaQkxRdXIvWEhJNkhub29vT3B6eHVTQ2QvSzExcWJ1MHlyaVljRVVzYnNy?=
 =?utf-8?B?NUdZcVAxUEI5WEx6TXhBZ1Exc3Q4YXB6U21mZUNrUkNxSkF0TWZzODZqTmNN?=
 =?utf-8?B?S3pMOGlaK01Tc3dCNVFWY3NjeGRzNzN5SHozU0ZEMUd4VUJEa1lRRFJxREhp?=
 =?utf-8?B?THZSeS9YMitYc0VDR1NPaUc4eTFDblViY2RBUDNKRnhvK3VEZ0pZYjM1byt6?=
 =?utf-8?B?UVFzTkpac0U5d24vY2ZkY1lYaWRobWVxNWlEeHp5M2twd0dWcWdEMVdZREg4?=
 =?utf-8?B?Q2tqNEVuenlCQU85aW1FdU0yNWtBYnpvVVEvTHBpZU1iVm41cTFpOTJGNjFk?=
 =?utf-8?B?RWJhSTc2NmljSzdUM1FHYlF4dTIydnZFajVNbW5rcXdvempBUjZtNUErVE9l?=
 =?utf-8?B?MWQvZXUydEE2RVFzL3dyMGNOT0tPVjhXOG9TYmRodHU4elI1TDJmNU8ySUZv?=
 =?utf-8?B?MnVZbXNEQXQ2VEdVNnJ2UjdlbDVncWxXU1czK3BDOEtqYSthaGh4WDFrUTk2?=
 =?utf-8?B?aXZyajNxaEpmL3RtRDNaS2dLZzlwWXlyNHQwTm5pSDZoQVUzdm5VcUN1bWp1?=
 =?utf-8?B?dGVnaGVMK0V4cDZOZXhjRTJzSStXajBJVEZSazdranZDS1pTRHdvemRQM3lW?=
 =?utf-8?B?Y2FXV2o4eGxZZ1R6d1R4Um1HR0hwTjl6RW1lSnZkbmgrMDN1VGZVd3NGTldQ?=
 =?utf-8?B?R0I0M3dJU0t1S1VIS3pNZXA5YzZVcmtJQXFvekp4Mm5sS1ZWWG1oSVhiZm1O?=
 =?utf-8?B?eExrTzgremcrM2Zvc0ppUmVvMFllY1pVOGREZ3FSYU5ZUTdXMklIRGRsVHBB?=
 =?utf-8?B?T3UySVYwTG1pT0Zhajk5MzZibUhYcDVwK2o5WnRQU2hCeHI1eUhtMk5BbFhM?=
 =?utf-8?B?WFQrZDBWaXpyajI3SUh3anRDNEJYYStwMUthMXBJeDFTWnRiaWJLT0U1MmpO?=
 =?utf-8?B?U3EvOFk5aWFsYmpuRTNKc1FMQ0poUTBPeXZxRkh6MHQzdFBBRFRvU0QwbFUz?=
 =?utf-8?B?QTlZK2JnblBDMWRheEFnVVNKQ0VETFhuTXBEamtRTUIrWXhQdldjVVJjOVpR?=
 =?utf-8?B?UWlybVpDU21EcmlWZE54aXhQQmJWWmhaMjVta3N4WFFQZDR0emVnME9jMjdY?=
 =?utf-8?B?Z2JRNDFYQnJ4S3lUZS9VdzFGb0JsaEwyT09ZWStQam0zMVM0Vm1JdmJuZ2s0?=
 =?utf-8?B?TE5YNDFWOHo0UDRpOURobGkwQngvSE9LbnQ2NnNrY2xRRWpaN2gzenVmUlZr?=
 =?utf-8?B?cmtsaTIrb1lZeDlaVGh4UmR6d2M4N2dTQmloZVIxZExJWDNVNmtzV2pNTndu?=
 =?utf-8?Q?EMghSsb0IymnaKuqHVKIfPdHD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70abf844-ca3b-4640-bbf2-08db312bf1a0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:35:01.1759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLM/2A51MJOhGyXNA+btgbJ+nSSKfXYzTym2CNIbKJuhaQDXJyCLwXFug9q5WYKO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5659
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 =?UTF-8?B?77+8QXJ2aW5kIFlhZGF2?= <arvind.yadav@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-03-29 11:47, Shashank Sharma wrote:
> This patch:
> - updates start/end values for each of the doorbell object
>   created.
> - adds a function which validates that the kernel doorbell read/write
>   is within this range.
> - uses this function during doorbell writes from kernel.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: ￼Arvind Yadav <arvind.yadav@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 29 ++++++++++++++++---
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> index b46fe8b1378d..81713b2c28e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> @@ -22,6 +22,25 @@
>   */
>  
>  #include "amdgpu.h"
> +#include "kfd_priv.h"
> +
> +static inline
> +bool amdgpu_doorbell_valid(struct amdgpu_device *adev, u32 index)
> +{
> +	if (index >= adev->doorbell.kernel_doorbells.start &&
> +	    index < adev->doorbell.kernel_doorbells.end)
> +		return true;
> +
> +	if (index >= adev->mes.kernel_doorbells.start &&
> +	    index < adev->mes.kernel_doorbells.end)
> +		return true;
> +
> +	if (index >= adev->kfd.dev->kernel_doorbells.start &&
> +	    index < adev->kfd.dev->kernel_doorbells.end)
> +		return true;
> +
> +	return false;
> +}

Here you're excluding "end".

In patch 7 we see this:
> +	/* Last index in this object */
> +	uint32_t end;

Which implies that "end" is included, but in this patch, the code excludes it.
Perhaps you intended to use "index <= ...end" here?

Since this isn't RTL, wouldn't it be better to describe the doorbell instance,
with a "start" and "size"? This is traditionally used in memory management,
and it makes comparisons and checks easy.

Regards,
Luben


>  
>  /**
>   * amdgpu_mm_rdoorbell - read a doorbell dword
> @@ -37,7 +56,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>  	if (amdgpu_device_skip_hw_access(adev))
>  		return 0;
>  
> -	if (index < adev->doorbell.num_kernel_doorbells) {
> +	if (amdgpu_doorbell_valid(adev, index)) {
>  		return readl(adev->doorbell.ptr + index);
>  	} else {
>  		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
> @@ -60,7 +79,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>  	if (amdgpu_device_skip_hw_access(adev))
>  		return;
>  
> -	if (index < adev->doorbell.num_kernel_doorbells) {
> +	if (amdgpu_doorbell_valid(adev, index)) {
>  		writel(v, adev->doorbell.ptr + index);
>  	} else {
>  		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
> @@ -81,7 +100,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>  	if (amdgpu_device_skip_hw_access(adev))
>  		return 0;
>  
> -	if (index < adev->doorbell.num_kernel_doorbells) {
> +	if (amdgpu_doorbell_valid(adev, index)) {
>  		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
>  	} else {
>  		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
> @@ -104,7 +123,7 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>  	if (amdgpu_device_skip_hw_access(adev))
>  		return;
>  
> -	if (index < adev->doorbell.num_kernel_doorbells) {
> +	if (amdgpu_doorbell_valid(adev, index)) {
>  		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
>  	} else {
>  		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
> @@ -157,6 +176,8 @@ int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>  		return r;
>  	}
>  
> +	db_obj->start = amdgpu_doorbell_index_on_bar(adev, db_obj->bo, 0);
> +	db_obj->end = db_obj->start + db_obj->size / sizeof(u32);
>  	return 0;
>  }
>  

