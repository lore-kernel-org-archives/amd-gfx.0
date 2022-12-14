Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9AAC001B2
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 15:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D23B810E427;
	Wed, 14 Dec 2022 15:52:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3124D10E427
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 15:52:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0GlYaW/p6VUqs2M7plvWTu4jKNvndZFhChWP4KmpHLsE7jlEJfeIXaVndWMg09qka4L4+jJw1erxo6AVtADfyiMYl7dQbnsUNWcMTpxzH+DqWlsw6IAAgC0TwQ8CgPWEG9rkYWW88nnSxxO6PuRBFHrAoE/EEL5Xqmb6cFD+GxffKtiX9DmmQoQMSa9uYEXW1CJkY69F+3UALqkRqn7yxPnYpS+aHoZHJ8f5MXHlflTzHNKv/PkgSKwokIk/W2nJ6VAKS5m21uFr4VN9aY+55jYA2l2Xvrg1MWAiR4laVOfzNksbPP/ui4SFgCtt5Zh15Z7e6RHBjtOn4CYWJLRxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkfJWnRCH63x+/77sQu9LwwxhwuWcfALrMx6sOl4soo=;
 b=Hq6UvIWukrekDhm06HsF+dII8oyMU4vjtQjG6fXyb+lqtvK6Rj47yL6X4B8MWVSJHJmwYEGnMekhmwdabZPT6ITk/fJUkczFaxKdAz++wDe/TH8NFnosWskRaDrM3j+IwkATMCBPd6VDmbgcCW5dTSInI/ARZ2Y9YQvp2Q6SDPyH9snVAQ253t17ZSkYvYnNMuXMB6p1rlZRYnIAhqQ5qrEfSXY8aRvZLQ3Bi/EggNHRn6ckC6+Pqt4rbE054Pga0BczRyCuMA3ysh4UWTD9GnjiBFBDzamBtsMLDjVVvxBUyEBmjG5oviJhxAQAEPxGplTgqiOOB7ehxmqALh23pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkfJWnRCH63x+/77sQu9LwwxhwuWcfALrMx6sOl4soo=;
 b=bB8Onx3wof/rIOYrHGZAiCsCx8QiQC6pIXMKSjI69cKf9GdJhvptAAvHSG7qCr7ieqcqhNeSh/mFyqo1Qp4FLKua4/PRpBX8Y3Acoi9PtNtGG1yOhiadbIWkDwPgXvA/UuEAqzjvO8rMqXyLXUXzjr4XGuwaM31Z1tjmPyrzVwM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5145.namprd12.prod.outlook.com (2603:10b6:408:136::20)
 by CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 15:52:21 +0000
Received: from BN9PR12MB5145.namprd12.prod.outlook.com
 ([fe80::5d16:eb99:9e38:31eb]) by BN9PR12MB5145.namprd12.prod.outlook.com
 ([fe80::5d16:eb99:9e38:31eb%7]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 15:52:21 +0000
Message-ID: <dec49e3e-5efd-d63d-2c22-1f12de5192fd@amd.com>
Date: Wed, 14 Dec 2022 10:52:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] drm/amdgpu: Fix double release KFD pasid
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221213154910.705-1-Philip.Yang@amd.com>
 <ddd80a3a-b393-41c2-c259-e4f9ec8facb5@gmail.com>
 <ebac34f8-50be-82eb-85e1-c097d57f9991@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <ebac34f8-50be-82eb-85e1-c097d57f9991@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::27) To BN9PR12MB5145.namprd12.prod.outlook.com
 (2603:10b6:408:136::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5145:EE_|CH2PR12MB4277:EE_
X-MS-Office365-Filtering-Correlation-Id: fbea1d59-f3aa-483f-b530-08daddeb2fa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j3PM+fV0xfXOB9GL88Qv/gvYPrjFHntSKjaUJARDVdUCQzO9rxFrj8FJa0IqFm9L0QVrGNK0aw3y8KaGGHyMljrr3OlOh9L5BCiRAYqvLPHDqpVqR2ZBxGks2GiBrpAYxQcpnXvzw7Nbcvb48TiYJhULHu8PguqaokoToXlyMdhdDQVcPkR25cfwUkRdnKHNPl6DPnaMg37pYBrUJVYDQEqBGpLcU7cAgIuNNcbsPhxoBaOtmDuheSu/UJFjVyozBK2hBGTyPFRd1aLkW55n17xMoh2b0TR9k2AoB7nB25P2xgITsQBf/YeF35pEWx38Rg581bgk1ocfjwjtZS+tPsyidoexVCFAP8aebnNQqs6yzPAsEWsaC9v4RnHOEEPtkeMCY1gDCpu8tcNk8LyvR9CCK6yPBsv6k0Nx70BjTGKW+c6b1Ila2HYllrnvuWBuuL1BShLHvOMbmn0a6qF4oUjTfr2uCP5LwTe6qLJTZqc6BCW8M5ttofxJxgbVrBKSHF3Gi9mIT9eb6d0wAjhYF0i14gYJE2iWUkfL/ewtu03hbI46RZAmzwqk8tGd0OgcF+gB8Znomwe7bdKFVu/tJuyu7CMTeA1clVd/byvVUhPOqR9F7whi3qydyWrGSILZQB/pjVkALN4NZJulid83Q10/rnRLD5fUo/W8finYlip05TwMKKobAfvi8tlAlbLdnnE64xXtdI9dsC1kqqoO1538g8/t2ue1MsgfLsjxvjo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5145.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199015)(6486002)(66574015)(6512007)(478600001)(6506007)(186003)(53546011)(83380400001)(26005)(2616005)(38100700002)(66476007)(66556008)(8676002)(66946007)(4326008)(5660300002)(41300700001)(4001150100001)(2906002)(110136005)(8936002)(316002)(31686004)(31696002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkhDWU1VT3NkVEFNeFZFK0FPd0l6MXhSWmgrbHVabjFCZERyd3U4V2FMekJH?=
 =?utf-8?B?bVJRVzlyYWlkcDBLemJiRUo0eVV2NkhLNjZtdWZ1TlQxL3FmOGtpNnIvNWRm?=
 =?utf-8?B?R3RhamFyd1ZGU3cxZ2wxcW04VmNYakJleGtOZy84bGJBRjd1NVd6MGhmWkg3?=
 =?utf-8?B?Y2h1czhzU1NicDhwTTlUQWF1bFJMbEEwOG9BSWtYY1J4NzlVYWFTUFRxbjlp?=
 =?utf-8?B?bGNFVjIyMnhyZzBocUNmM1dzbGxZUHIwZGVxV1MreWQ3Y1pWQlczREc2djZq?=
 =?utf-8?B?SGZEczdrNGU4ZGxLUFJHODZZRXhvZ1Y2SUdEblZRSWhTbldMdlJUbzZ1c2hT?=
 =?utf-8?B?bkhGV0czSXZRS3liTHZLUm5HMnR2blVac1F5ajdHM1Y5NEJZWVlqU2l5RjJw?=
 =?utf-8?B?OUFKZ0pXV3B2Kys5UzF1cTc3ZDgxYmxYWkZmOUJ2N1k1d0s1ZmJ1U2NQamRQ?=
 =?utf-8?B?ZVczVjNwdkFkandOMVR0V1JRYlNXaXEyaUVVWnAxT09VMms0RXB2Z2V1UEp3?=
 =?utf-8?B?aVIvRGgwU3dpaTVYMUVaZkR2a2xoMnI4VTk0NXJoNEpZVDQ3c2FjQ1o4dXlP?=
 =?utf-8?B?MzBLWlBDZnUzZFJlem5STEpFUDc4WEo4T1RiYXNXWmJPNitoa0VydHJ2bkFu?=
 =?utf-8?B?N1pGcEpZN3NicGQ1VDc3VkNYUHpoaVR3eFV2NzJnMHNPSVdjcjFJREdqYTl5?=
 =?utf-8?B?NEdGQWQ3M2wvOHVITWlnNmgrb1laeTVxOU9VU2lBYTF4R3NzR3M3QjBkSXZu?=
 =?utf-8?B?RExiNDFKQUUwamJXQkhXdUVacVM0aGYxZHp2d0ZWZ1hzTzBiN1hvTXVqRmJF?=
 =?utf-8?B?bFI2eUVpRUZWanNvd3dXWS9kakJFOGw2OEowT1J5a0NlK0JzYUpkWkZQTHdT?=
 =?utf-8?B?ZHFpRlZOWEFGclIwZDF6OEZyTTlsQlBsT1lYRlg2UDNhMW51NzN6OVRtQXVR?=
 =?utf-8?B?YVU4eFpRcWNRTzBSd0djR0pvUUhqTm1naWJnMCt2VEJIMTNFVTlWTGlnQUxK?=
 =?utf-8?B?TzBudkJUS3FuUERULzhPU1czZEVhbFhJTmhId05RYXhkNm9OZVVFVVZOdTdX?=
 =?utf-8?B?VFZVUUdOYmhGRi9ycmV6c1lMZCt6aGNrRkUzY2VGVUJVaVp5ekJRVWdXUGRl?=
 =?utf-8?B?aUVsTENydjR0bnhITjgyUlFVQktiWFR2NCtNWEtORVp1VldIRHhzUW5DZytT?=
 =?utf-8?B?RzRhR1hDaEpkTHYxamE1M2tMeUpuMEw0dndSbysxRldTdm9FdHpBVHFIMEpF?=
 =?utf-8?B?YWtIVVZqWVJ3VzhUZVErei9QUEY5VHFzeXhmbTN0YXovVmNlMmhRZncrVnhU?=
 =?utf-8?B?Q21yK0VtbnZ5OTRValVMRm0xNmRBc3NheWNmRWdqVUFpQzYveHgweXRFOS9H?=
 =?utf-8?B?UUF1WnpNcWRZRDMzcVNhZk9QdE1KZkZpRHVWUzJuSjZ3QnB6OXVOdk5acmYv?=
 =?utf-8?B?ZUpZeWNDYXFVNlNqRjU0MUh1RjZIN2R0bHMyY2dBc1cyVzk0SjBldEduSE9o?=
 =?utf-8?B?b2ordkoyZENndzZKbEdSR3FnL2F2bUExOURVMnZOMUl6VlRVQXNyaWE2dTFq?=
 =?utf-8?B?YWZBWDREL1dxSHBRRk5EMzFyZlVZL1RzYXNjRng4Y3R5bTZYVHJ3aEsxcm9n?=
 =?utf-8?B?bmlaYkhYdm1mSDNTdjFsd2huaWhyZGpNYjZqVzgzNmhMNWxQbk5hNitscko4?=
 =?utf-8?B?bVUwWkVxTDVWVE42dWh5a3Bib09zV2h0NWthR05vQmRkQ0g0SEl0NHJ6WkVI?=
 =?utf-8?B?NVRuQ29FNzFWVDQybVZESVBVTVhFWHVxZ2tTVlJqaHRnLzBaUDFVZkU4b0hn?=
 =?utf-8?B?NWRBZElYRDF0YjArOE1hYVg5TEhPMy9Pa0Rkc3BEak1BRTdNazN2VzlHOVNv?=
 =?utf-8?B?aWZRMm43V2F2OXRvOEF3ZXBVUUZONW8yVDBWZGdwOTdHdmorU2ladTExdG1R?=
 =?utf-8?B?K2lUTnVYSEpDVFk2cXdwM3FzWk9tRzRJVDVxdS9icm83TE9vRjJiVXNNcEhj?=
 =?utf-8?B?RFNST1hrVmpBY2RoRUNTdUtLRStBampjQWtIemQ2djJWTmEvZ2h5ODg5QWhB?=
 =?utf-8?B?dGMwV1U5RGs3NVloYiswQTRKWWd5K1VuU09NZXVNOURNb2k3aGlkVnE4d01i?=
 =?utf-8?Q?dnLY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbea1d59-f3aa-483f-b530-08daddeb2fa3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5145.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 15:52:21.5000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KG1hHtAg65XDwdv6ipvOzCpzUVnNguzpvEJanh9wzKzGOs/MhX3h3SaiTsTVPlr5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4277
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
Cc: kent.russell@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-12-13 12:58, Felix Kuehling wrote:
> On 2022-12-13 10:57, Christian König wrote:
>> Am 13.12.22 um 16:49 schrieb Philip Yang:
>>> If amdgpu_amdkfd_gpuvm_acquire_process_vm returns failed after vm is
>>> converted to KFD vm and vm->pasid set to KFD pasid, KFD will not
>>> take pdd->drm_file reference, as a result, drm close file handler maybe
>>> called to release the KFD pasid before KFD process destroy to release
>>> the same pasid and set vm->pasid to zero, this generates below WARNING
>>> backtrace and NULL pointer access.
>>
>> Well NAK. If you fail after making the VM a compute VM the correct 
>> approach would be to drop this in the error handling again.
>>
>> Since we don't need to reallocate anything that should also never fail.
>
> I don't understand this comment.
>
> The fundamental issue, as I understand it, is that compute VMs don't 
> own their PASID. Multiple compute VMs on different GPUs share the same 
> PASID. Therefore, freeing the PASID when the compute VM is destroyed 
> is wrong. The PASID is freed by KFD when its process structure is 
> destroyed.

Just sent out another patch, to update vm pasid to compute pasid at the 
last step of acquiring and init compute vm, then drm close handler path 
don't need change, to free the original pasid or pasid is 0 if it is 
compute vm.

Regards,

Philip

>
> Regards,
>   Felix
>
>
>>
>> Christian.
>>
>>>
>>> For compute process, KFD manage pasid and drm close file handler should
>>> not release KFD pasid to avoid double release.
>>>
>>>   amdgpu: Failed to create process VM object
>>>
>>>   ida_free called for id=32770 which is not allocated.
>>>   WARNING: CPU: 57 PID: 72542 at ../lib/idr.c:522 ida_free+0x96/0x140
>>>   RIP: 0010:ida_free+0x96/0x140
>>>   Call Trace:
>>>    amdgpu_pasid_free_delayed+0xe1/0x2a0 [amdgpu]
>>>    amdgpu_driver_postclose_kms+0x2d8/0x340 [amdgpu]
>>>    drm_file_free.part.13+0x216/0x270 [drm]
>>>    drm_close_helper.isra.14+0x60/0x70 [drm]
>>>    drm_release+0x6e/0xf0 [drm]
>>>    __fput+0xcc/0x280
>>>    ____fput+0xe/0x20
>>>    task_work_run+0x96/0xc0
>>>    do_exit+0x3d0/0xc10
>>>
>>>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>>>   RIP: 0010:ida_free+0x76/0x140
>>>   Call Trace:
>>>    amdgpu_pasid_free_delayed+0xe1/0x2a0 [amdgpu]
>>>    amdgpu_driver_postclose_kms+0x2d8/0x340 [amdgpu]
>>>    drm_file_free.part.13+0x216/0x270 [drm]
>>>    drm_close_helper.isra.14+0x60/0x70 [drm]
>>>    drm_release+0x6e/0xf0 [drm]
>>>    __fput+0xcc/0x280
>>>    ____fput+0xe/0x20
>>>    task_work_run+0x96/0xc0
>>>    do_exit+0x3d0/0xc10
>>>
>>> Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 8 +++++++-
>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> index efc0a13e9aea..bf444c3f6656 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> @@ -1244,8 +1244,14 @@ void amdgpu_driver_postclose_kms(struct 
>>> drm_device *dev,
>>>           amdgpu_bo_unreserve(adev->virt.csa_obj);
>>>       }
>>>   -    pasid = fpriv->vm.pasid;
>>> +    if (fpriv->vm.is_compute_context)
>>> +        /* pasid managed by KFD is released when process is 
>>> destroyed */
>>> +        pasid = 0;
>>> +    else
>>> +        pasid = fpriv->vm.pasid;
>>> +
>>>       pd = amdgpu_bo_ref(fpriv->vm.root.bo);
>>> +
>>>       if (!WARN_ON(amdgpu_bo_reserve(pd, true))) {
>>>           amdgpu_vm_bo_del(adev, fpriv->prt_va);
>>>           amdgpu_bo_unreserve(pd);
>>
