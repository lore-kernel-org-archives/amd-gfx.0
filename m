Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63EBC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 22:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6144310E4BB;
	Wed, 14 Dec 2022 22:42:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C039210E4BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 22:42:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=New8M3OJJTxs1c6cB0rUflkNd2KhOLkLhLsYAiVSRfmb4XbunjmH1DC/ywvkOiDVANrAq+WZw7SLLcwEQYANRtA6p7DTY0ac4bAjI0OemxwBlwtbmCVOzk38IInjBymOm946wKt7Dfl4g6OO7sMEtK7wj/If51SxVATBdcoSwjcMu5WdSze39ohM+72glI3Tz9WOFQKMOgr7KT0D+5GW6vTZO1Ul9ylEeh3MzWF3w7px/OfkfjBS8ItI1R1xt8IuplpHHSl4lJyjuhCtX3IiDRsrPDDJOEDFqcy9Zk19iOoTq104OpY3r3SDV13fOChq+O79k/SB22JOcQbMjrZVSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9ZF7DFVqAWduNDG/rGU1rfbrBXYRh/gNB6YuRfklw4=;
 b=XsL/9IfpgYOWH+fJzSpGjeuhbwjOkEIiBT/QZShi3bc+z5O3q8qrxfpEUu0Kcev3jPm9xrz78QNqL1lZykeFVhvd7IgIDLWgB7eTP+VmBpO/0cEhKnyLGjt0weC1gKEkHbPkm0tvk5PPtVhCJZAjBlkkeyJnDpDhnf4UQDNZm85Y3eqs4AX5IWXLkUGMi+odLWSE3UpmBbwKpbPfMXz8qLs5TgDlS+G3HmYMwoZGERjbb3HKan4T0V+HGcx7JityFoJjzDrNxej+uoOiWIcKSLo3QeYDyulTtfKyueF0c/bNkUaMdK0evIuMbDzhkGMKVCAO++LOfAK0wRb9pn+6lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9ZF7DFVqAWduNDG/rGU1rfbrBXYRh/gNB6YuRfklw4=;
 b=K/Z8uO8IsClAc+TJKfL4gGRs+10gJS87FpJXCvXgw1rLtQaOM8tZxVKsTTYIq3+RJubcPwg/f2wcjoK3TpcwrI6O9ORQ853E5HwLJFETC0h+58JljxBqD5JZNKGXIYUT5i3Hyd59vYMkfTQCQ5a/ZEMAt8D0s+1fqvC7xIOYmJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL1PR12MB5110.namprd12.prod.outlook.com (2603:10b6:208:312::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 22:42:43 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5924.011; Wed, 14 Dec 2022
 22:42:42 +0000
Message-ID: <6670fefb-7ae9-c33e-6af0-c65b19763cc6@amd.com>
Date: Wed, 14 Dec 2022 17:42:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] drm/amdkfd: Fix double release compute pasid
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221214154249.2981-1-Philip.Yang@amd.com>
 <20221214154249.2981-2-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20221214154249.2981-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL1PR12MB5110:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c6a4cb-21eb-44a3-280c-08dade248332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BegnuCeaE68V2D7IDQYNGLpS+2xfI833aPrKV+8Sqr/1H2ZZOIzuJI8/Gbx2ltM8xbg8iFsEzaOGJM7eaxvLeUx5E9ctNIqvfRsh3pksFqPrdsTDSnZaJEGeT7nIOYS7jDkUlhQ4iaZXY8GHuEYuRA/+ct6dP+jmGQDyvEcsq7xnac8fTUEMyIfMnYSxAMJk2JS7rUIj5XnvHdXVbweo8GhC9kzxnXy9noY5MUXY43YrzM1BumSoGENbUa4fumkmqQzDQ7kqtNk/TxHgkHhGko7ph/d9L34DnsFYYLCFI8YiAG2iiPKQgbHhcXIkg8/GyQQ5tJ3Ns6aWAkeF8mrfCRNHL626Y1jBnrEAU+S4hzifiqG7c2YMm//BvVSaYUkmnv/VKdT+QSpRlP6AHFVbS2LHB5zhQ0bypdowFvvG5kItOQLYGU6UxcBga/MYx76VUSFrv7/RTjQsmUrAPSotgiaDorEUe9/KaXdtPgQ2oNmkDsCG2+TJWDOsSaWidIvCGeDH/EklDuFSqrSjk1NWvulKbD8PU6fMlEehxIyWbbU7ohv82Thb4CtUlN4MmXTx6YAt2HbZyqFCvsT1i3xfiQ66yL595Qly6R1sCWk1FsLMrp+HH4XTrZosUiM7rwVmgDsYQ/aHVYs46W8zB+hrHU75em+qrE2hjEWzIOBemlqBB7GjIrDmRhHt994PqemCpP1eXq2zh5nTPc307IyNtxTfq/Mhw+lY94PASn5i6ww=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199015)(316002)(26005)(8936002)(5660300002)(8676002)(66946007)(66556008)(41300700001)(4326008)(86362001)(6512007)(53546011)(6506007)(66476007)(83380400001)(2616005)(478600001)(186003)(6486002)(36916002)(36756003)(31696002)(2906002)(4001150100001)(44832011)(31686004)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eENpSlB4c1dYVkE3OTQ4SHBDLzk0K2F3SkZaS1RmdVpRNG5lQXZSNExQeEpC?=
 =?utf-8?B?VDRuNzZrbGdJTk9sQWlRWDQrV2ZwZUNGTUVleVZ5cFIveFJ6cmtyT3JiMSs4?=
 =?utf-8?B?dE9KcDBTZDEzSjJxenR3UGpRYjczNU5DSmpNcXZwUXZScGtOWi93c2xHUzMr?=
 =?utf-8?B?Z2lENVQzK3lRc2llUkovSFVBUnVyRE12WEhReTF0QUhHOTFQUFZqSE9JUTVG?=
 =?utf-8?B?T0Yxek5RdjBIMTNJcXpOY09CK2tpTlhrMzBDNWpMY1RZeWdDVXNtTEl3bkYz?=
 =?utf-8?B?Z0toZkJJR0dYY2JXa2o5ZjNOMWowYXNCUXdvZ0VFZHdyYjE1eXhLTWFhcTNo?=
 =?utf-8?B?RFY5alpuUDBDcGpXd2t6Q1VXbFRRYTVXTzArT2swamNZOFczSGw3Y3JuNm1O?=
 =?utf-8?B?ck9oNkF5N3hYN0wyOHZWMjlQeGRuYzV1TURjM0YzeUp3T2hqZk5DR0JzakFl?=
 =?utf-8?B?WXFLcTl4N1ZCRHMzOHFTbUErNVE2UmFTek05UGFZbmQyNVJsREpVSnNLbUFw?=
 =?utf-8?B?dUs3ZHdqcVROalk0WjJSNlhJbXpYMnlKWGlKZGJnMGY0U0pvVy9QeUVlS3Yx?=
 =?utf-8?B?R2FrRDVsVklKeXJUeWhFSW5jTSs2YUlDWHl1MnFQd3MxeHJIWkJ4UGpvN3RM?=
 =?utf-8?B?QUhZY0NsSVZqT04vSlZMS3pydmY2ZDg0U2pUYlc3RVN6OG1JbjJpT2hBdm9Y?=
 =?utf-8?B?VjlROXNNZkJ0NVZ3UDhLckJwRzI2TThtUmRZZ1VTQ1RkODZoeGVaK2RpNlo0?=
 =?utf-8?B?eTc3blp1Zm9oK04xRXRYVjVZU21QejlpK1dnWDNNL0FVQWNzekNaQWNYZ2dU?=
 =?utf-8?B?dkZRWW1rNWZEbmdIOVZVNTVVb2tVR2ozY3BZT0RaaCs1ZWwxTXFmRE55OGFG?=
 =?utf-8?B?dmVsVGJNWmdaK0Uzb0RSaW1tY25HR1pwZFFOOUNsSVFScWd1TVhLelRDZ2cr?=
 =?utf-8?B?eTdRVm96eWJZWGo4UCtNRWFQbjFnditOUFUzTlJOS3BBT1BKUnBkcEcxVFhN?=
 =?utf-8?B?L2pucFNEZEVqdW9uaWVydWtyMjhaYytGaUZGTUpqdUNDSDRIL2VhSFcxN014?=
 =?utf-8?B?L3dyb20zNEl1SHRyc1R6M1J5S2NYM0QyVEI2MjZYUXVoQm5XNDlzY0pCd0o5?=
 =?utf-8?B?NzVVaXg5OXBHN2hzR2pTOXZWVU13bmhUUEpnWUMxSHQrMmQvMnNNQU9odlFp?=
 =?utf-8?B?MGZKay8xWVl5WkxFM3c4MFl3bFF4S0R1U2NoSUhzWHZWSU1tem1UbllacUxW?=
 =?utf-8?B?YTBPcFBabFczVW9ON1VYdi84VHp5Rm9BTTR2S0E2aHUwR3U5TXVFMFVyNHAv?=
 =?utf-8?B?VkJjalp1L1hUeUZYSXNKeU1DcHhUbzlGZXJQc0pvWTJjM1JmRkloNEVPcjBm?=
 =?utf-8?B?cWN0aU1ZUTByUGVoOWpnWFJ4N0FkWXkvdEJqYkxzeXN4anlsZTZXRjkxNTk4?=
 =?utf-8?B?WE1MMXdTOGorNVg2WE4vU3hLdnpFNEJqZzhPa1NXRGxFYURoU3NJeWt5bFpG?=
 =?utf-8?B?UlJpZjdCWWhLbWNObVNaeEx6ZWJaS2krcjZJNkFVeGlIaDhVZVE0aFp0ZWtr?=
 =?utf-8?B?Nm9mVjFpY1N2YXdJUHdPZ2pCV3I3UFJKM0ZZMWgzcisxK0NKSUhwbWNUU3o4?=
 =?utf-8?B?dWdlbmRybjVzYmVXb3UxQXVNNDFaVmdRaHhpRko4ZUsvSWR2b0YxV0tnZTVK?=
 =?utf-8?B?blR1SkxKeExLMklWSWUvOFBOYm1uWjRLazNhblU0WXFhR045OWRHT3dtNWxn?=
 =?utf-8?B?VXlsd3g3dzhaMElLMW93U2xweXRSMGt5QTAwVzgvVzhNeGdwTmk1Zm4wNDNT?=
 =?utf-8?B?V3NITTZVQWJ2Z3Jsait0ZmVIMlY0QlRyUnBoNDZGa09ZdkR3SThYc1BqL29F?=
 =?utf-8?B?WTc4bjliR3R1TFk0aW5wNEFHelRXTmVmTzdpeGR1WGJqMThEVnZUaGJIbzY3?=
 =?utf-8?B?ZDUxMlNwcU1RUUQ2eUUzM1U3MkFXSzFPdUJqZ3dwK1BLTDJVVHRKMG03THNO?=
 =?utf-8?B?OUtWbjY3ejdZTTVLWklJK012Y1JOZmt0VHZtaUJ5MjRmT1BEa1JJRDV0OERI?=
 =?utf-8?B?cTJ6Z3l0SkVTN3dPMUw5a29XRTRkbEliZ2dDZ05XMXVZZ1pkME1EUHAwZE5v?=
 =?utf-8?Q?piz/Lz8HtJybtbKuzpf0izffl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c6a4cb-21eb-44a3-280c-08dade248332
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 22:42:42.8888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4YIfcIHlBAjFRZAQFGFmskJcYNXzsgffAWvUlNYxB+qhqPwzOuqbmz6jLcOndJgILwoPqDGH9HrwUgp6DgbuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5110
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-12-14 10:42, Philip Yang wrote:
> If kfd_process_device_init_vm returns failure after vm is converted to
> compute vm and vm->pasid set to compute pasid, KFD will not take
> pdd->drm_file reference. As a result, drm close file handler maybe
> called to release the compute pasid before KFD process destroy worker to
> release the same pasid and set vm->pasid to zero, this generates below
> WARNING backtrace and NULL pointer access.
>
> Add helper amdgpu_amdkfd_gpuvm_set_vm_pasid and call it at the last step
> of kfd_process_device_init_vm, to ensure vm pasid is the original pasid
> if acquiring vm failed or is the compute pasid with pdd->drm_file
> reference taken to avoid double release same pasid.
>
>   amdgpu: Failed to create process VM object
>   ida_free called for id=32770 which is not allocated.
>   WARNING: CPU: 57 PID: 72542 at ../lib/idr.c:522 ida_free+0x96/0x140
>   RIP: 0010:ida_free+0x96/0x140
>   Call Trace:
>    amdgpu_pasid_free_delayed+0xe1/0x2a0 [amdgpu]
>    amdgpu_driver_postclose_kms+0x2d8/0x340 [amdgpu]
>    drm_file_free.part.13+0x216/0x270 [drm]
>    drm_close_helper.isra.14+0x60/0x70 [drm]
>    drm_release+0x6e/0xf0 [drm]
>    __fput+0xcc/0x280
>    ____fput+0xe/0x20
>    task_work_run+0x96/0xc0
>    do_exit+0x3d0/0xc10
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   RIP: 0010:ida_free+0x76/0x140
>   Call Trace:
>    amdgpu_pasid_free_delayed+0xe1/0x2a0 [amdgpu]
>    amdgpu_driver_postclose_kms+0x2d8/0x340 [amdgpu]
>    drm_file_free.part.13+0x216/0x270 [drm]
>    drm_close_helper.isra.14+0x60/0x70 [drm]
>    drm_release+0x6e/0xf0 [drm]
>    __fput+0xcc/0x280
>    ____fput+0xe/0x20
>    task_work_run+0x96/0xc0
>    do_exit+0x3d0/0xc10
>
> Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>

I don't think I suggested this fix. I didn't realize that the problem 
only affected the case where kfd_process_device_init_vm fails. Anyway, 
the series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  4 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 39 +++++++++++++------
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 12 ++++--
>   3 files changed, 40 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 589939631ed4..0040deaf8a83 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -270,8 +270,10 @@ int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bool is_
>   	(&((struct amdgpu_fpriv *)					\
>   		((struct drm_file *)(drm_priv))->driver_priv)->vm)
>   
> +int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
> +				     struct file *filp, u32 pasid);
>   int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
> -					struct file *filp, u32 pasid,
> +					struct file *filp,
>   					void **process_info,
>   					struct dma_fence **ef);
>   void amdgpu_amdkfd_gpuvm_release_process_vm(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 0a854bb8b47e..b15091d8310d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1429,10 +1429,9 @@ static void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
>   	amdgpu_bo_unreserve(bo);
>   }
>   
> -int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
> -					   struct file *filp, u32 pasid,
> -					   void **process_info,
> -					   struct dma_fence **ef)
> +int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
> +				     struct file *filp, u32 pasid)
> +
>   {
>   	struct amdgpu_fpriv *drv_priv;
>   	struct amdgpu_vm *avm;
> @@ -1443,10 +1442,6 @@ int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>   		return ret;
>   	avm = &drv_priv->vm;
>   
> -	/* Already a compute VM? */
> -	if (avm->process_info)
> -		return -EINVAL;
> -
>   	/* Free the original amdgpu allocated pasid,
>   	 * will be replaced with kfd allocated pasid.
>   	 */
> @@ -1455,14 +1450,36 @@ int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>   		amdgpu_vm_set_pasid(adev, avm, 0);
>   	}
>   
> -	/* Convert VM into a compute VM */
> -	ret = amdgpu_vm_make_compute(adev, avm);
> +	ret = amdgpu_vm_set_pasid(adev, avm, pasid);
>   	if (ret)
>   		return ret;
>   
> -	ret = amdgpu_vm_set_pasid(adev, avm, pasid);
> +	return 0;
> +}
> +
> +int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
> +					   struct file *filp,
> +					   void **process_info,
> +					   struct dma_fence **ef)
> +{
> +	struct amdgpu_fpriv *drv_priv;
> +	struct amdgpu_vm *avm;
> +	int ret;
> +
> +	ret = amdgpu_file_to_fpriv(filp, &drv_priv);
>   	if (ret)
>   		return ret;
> +	avm = &drv_priv->vm;
> +
> +	/* Already a compute VM? */
> +	if (avm->process_info)
> +		return -EINVAL;
> +
> +	/* Convert VM into a compute VM */
> +	ret = amdgpu_vm_make_compute(adev, avm);
> +	if (ret)
> +		return ret;
> +
>   	/* Initialize KFD part of the VM and process info */
>   	ret = init_kfd_vm(avm, process_info, ef);
>   	if (ret)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 6caa9dd57ff1..51b1683ac5c1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1576,9 +1576,9 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
>   	p = pdd->process;
>   	dev = pdd->dev;
>   
> -	ret = amdgpu_amdkfd_gpuvm_acquire_process_vm(
> -		dev->adev, drm_file, p->pasid,
> -		&p->kgd_process_info, &p->ef);
> +	ret = amdgpu_amdkfd_gpuvm_acquire_process_vm(dev->adev, drm_file,
> +						     &p->kgd_process_info,
> +						     &p->ef);
>   	if (ret) {
>   		pr_err("Failed to create process VM object\n");
>   		return ret;
> @@ -1593,10 +1593,16 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
>   	if (ret)
>   		goto err_init_cwsr;
>   
> +	ret = amdgpu_amdkfd_gpuvm_set_vm_pasid(dev->adev, drm_file, p->pasid);
> +	if (ret)
> +		goto err_set_pasid;
> +
>   	pdd->drm_file = drm_file;
>   
>   	return 0;
>   
> +err_set_pasid:
> +	kfd_process_device_destroy_cwsr_dgpu(pdd);
>   err_init_cwsr:
>   	kfd_process_device_destroy_ib_mem(pdd);
>   err_reserve_ib_mem:
