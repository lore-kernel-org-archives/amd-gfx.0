Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8935EC01B1
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 10:08:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89A5D10E4BC;
	Mon, 23 Mar 2026 10:08:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3RXdos5+";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A6B810E4BF
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 10:08:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvu1MQSPMnkCjxIDU8voxSd/5Byy84Puqko+U2MGU7L1SYJIgC0Db88p5BkWdmInOZcY8VmTJnoF6WZArjk3F3Q3vDyFrHHTyLGFUkmUbIHv08PkvyPNLkx86FDJYRAI0oTsoxBLQ1mqxgHc02Cr8WfIclhl0BazYm0ikGDr3D82q5rtIVVYoeCD2ljEOQI7hXnMXhn53ehr8Mu/UCDhGVDmdPfMUDNaZyVNnUorD3F2+bjjZBo/CGRbkG4T31QQ1xh7Mkzz7Y2adG31b/u0tnrXxzpX1yamjA5ukqOGZJZckEolHXyjNF7zSqcltpaSOM+ZOjMX88qUfluFqEUOcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5qSabVGGp/ah/EcraMnhJ0ciY1R93d/Cwv3SB4cav8=;
 b=AqzPkFQqh0kkgcVAU7Hn2SLmm5ZfRZW1dLNEZFkWG7Ma+tUYI35nAgtS6tASE2l1IdarOALagr5DR2CGlG/+us07fQQA9QhamMDi6DTzzI0kVQboTfN/O+0nD6E2cp5hkbDRqYgwYuOSMOp4qzCm2rg2B/p6p5BoKa13SFuQ7o2Kr//mn7kpK3paF72HzNLyT5KP7yKjVb/gE75/nW9DiR39hIPa3+zSPnXq8tdhA26VmQGyRPvprHRtKZm+HogGFpefciMQjYjzJngzUYd1RwmKILbsrUjQuNx+lSiQ35DvYDbwSnj32KMF0U2oBImMu/2cAM+HR73kfatdaMHbaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5qSabVGGp/ah/EcraMnhJ0ciY1R93d/Cwv3SB4cav8=;
 b=3RXdos5+MIGCLwXWtIAIFd+WtDyG7RPriijaTwLHibMEvG2svNZuL5y26rq0ygr6MRz3JzTTKNHGSO/ZG4tWdnfAqr0awEY/8nSI9LOH20jwxOniXhkWs6XTyMFL61eIVmpwW6RIMhhqQvEhV83gbb85IOkG4nPyU28Eyb3Xg40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB6240.namprd12.prod.outlook.com (2603:10b6:8:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.19; Mon, 23 Mar
 2026 10:08:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 10:08:21 +0000
Message-ID: <6b64daab-ddf7-4818-bd52-e0fa258b358d@amd.com>
Date: Mon, 23 Mar 2026 11:08:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: fix the old userq fence dereference
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260320084140.3329888-1-Prike.Liang@amd.com>
 <a4e7335b-1488-4d06-b1c9-329e5bbdd889@amd.com>
 <PH7PR12MB6000613B66D410B2B58350E4FB4BA@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <PH7PR12MB6000613B66D410B2B58350E4FB4BA@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::16) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a4b23d-297d-4407-71a7-08de88c41ca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: qlOo2XF0gtoNxvtCt5mbRLcjTe35YUr5PbibLCE5g48NIDtKlTh61erWFaeQW1Pz5NSuZ1Lb1ThN81s5dvbDqHcjknguLr4Lo0uFd4JAzSGxiPwfDZVor73AWqRo2iQC+eoYV6kDTraC5Q7xUI1orimlztAqD5yd8+T1PdMyhxPKCDcW+Y2BsaFqzDLsZw0UoVwAj0C9n9+ZlT6hAfYMFUl8xczdChuS9XQjEcZtDku/ZvkMVKr2lkBuJG+bx0anhg57zn0oDZjUt7rp34pL2E6xpaZVffm2JhCQ+sTLAhj9lfMk6h+p8kdkybFsu4vH9mUt2YHSxNOppBsryXP7/c8eWgkTz/x+Q1Rtj2jZwixKESvfPeHG4g+Oi6dbS+9BkL7fhUqN4CW21b+c5qeWyxr0uxw80rOdmC3pe3PfH2GKmM0JxoAdf73spIZ3sI0dMoEiyTxIVS40N0BCDp6YocEUPU65SC9WVrmydKQlLSfZ1qxxn00FItV0mlrFpxruhKFTBYWTJsC7qlCJRu4Mby+shAfYN8gYUYOw3+0GuwnY8VWp1n8IiIGp1ORdRlr+rAgemCdR/+lPkcT/684eU08FnKH+3SOnWJR9j0TR+9m2VNpC5s8eaAfeHSbf0B2QBn2uHRzsOLiJJ2CO82Tkg4zEzMbqm3tJ5tzttybpuRCgSihR3l07ZvYFufW6LZO0CFWSUAvROCtWlqTZUhp1+F/MBmPFMjCEAr8sPGjvHXU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVJpN3pYR3orSmRUcko2RHBVV3lFYno4bTZGS0VySVE3NU9OSERRTnpMYW5s?=
 =?utf-8?B?Q25ma1E1Mjd0RVZhczlHOWt6WTQ5MDgwK1dmRnYrc1hoNXBUZEw5Z1ViQURl?=
 =?utf-8?B?bGcwOVVEZDlLeFhqck1XQ2dOWjRxbFdiUXFtc254SWxwNklZc1gyeVZDWkZP?=
 =?utf-8?B?djllbHBWQndUdDEvT2lxUGJtWDNOZVpmcjFpWU0yUnZ3bTcvOW5tblprQzdI?=
 =?utf-8?B?ZVZaVFdQT1BkL0JtUjIvcFEwRnlwNUFtTFlBT1hLd0NQL2pWN25XNVJzTy9N?=
 =?utf-8?B?cFhVSjIxVTVUalVoTTVGc0cvY2I4aXR1MmIzR0hDZjFubE5EK3I3cDF4NXBn?=
 =?utf-8?B?MG9KcmhwenZQK2JUZFlMOUdDeklSc2NmWXZuS0pkbmlhS0F5OHpHNlUxK1Zl?=
 =?utf-8?B?TWV5ZkxwTWRCTlNLWXZvNDJRd21rYk5vbjVNcGRiUzJqWkN3Y3ZXT1FKUjFD?=
 =?utf-8?B?Y0tMNzErOERDQjRvcFZsMVFLdGh0Y0c1UWxCYzg4M3RSQU1OVkcrUkwydHlm?=
 =?utf-8?B?UDRTa3Vwc2Q1R3JSdnUvOXN1OWd5OXlUK3RCTXFCMVFlSmhhR21NVXU1azM4?=
 =?utf-8?B?ZTRGUjNkS2hwMnZ3VU8yd0tZbGZDR3h3RVhmbXdTYVdwMVpoRGNnYUlEQ3pr?=
 =?utf-8?B?WG5WSDkySEdBQVpvNWxiTzViZDdyODY1aFBMc3luVDhydmwxeEVNT2tQMmpC?=
 =?utf-8?B?Z2Q0WjdNRVRGcmo4Yi9hSVByUlljQ0xkU0dVaCtlWEJZaFpiT2x2b1I2OUd4?=
 =?utf-8?B?UUs3SkI3VEgySnpiWUNHNE5wZkNwM3NuWHpmUTFHU012a1dpNXFVTTY5bTFp?=
 =?utf-8?B?MTF6WEgzZXdNbW1hTUV2WStuM2tjYjEzbzBpQitmSWZvekMzSk9RRVRiTUh1?=
 =?utf-8?B?dXNRNmdtckl4TC9YMUZndnBtT1BzZjJ4YzdsZU1WQlhPakNVbVhkczdreFM0?=
 =?utf-8?B?ZWMrdHdJQmJXS0srdm9MVEt5cHk4eVRBcC9UN1psMkJyS0p2SWpyclNrU1dh?=
 =?utf-8?B?endMNmRScDVySkprU1R0L3VpTTNEUUxVVjVPcU9ONlFabkk2US9CVmF0QlhH?=
 =?utf-8?B?L0NXSWF5NXQxSm41SmwvZFdEVnorbzlZaHRSbExBdTVSaEJRbkovTlluSWda?=
 =?utf-8?B?K1QzSURlMkJzWmhMRHhGdGp3cHZZL0ZRZnlGbVZjMk5Zd2I0elJBT3NNRG9h?=
 =?utf-8?B?Vzl5S0NqQnM1VmsvWHQvY3pHUGc2R2xvVVBINmpoMCtFRVBVUlo4M2QyeHB6?=
 =?utf-8?B?YXlILzdnSW9xcmhEYTVzOEJYY1M0YVBCQU1xeStvbXp3WGwwRFYvdmg1Mk92?=
 =?utf-8?B?V2RGcVd6c1NXK2Y3NmFCQ3phNEVXOUY4K29IeXBTemtoYzl3MytzaHRKLy9Y?=
 =?utf-8?B?WFFvdEltRmxZYVhRU1BjbTlmaGVvZFVuSU1wQmxxMEY2MnNrTTR2bytJdUpt?=
 =?utf-8?B?RDBSMlpGVGJzL1k3elJ0cDBTYWhpbDU0NGRSYW1mRjRtRzdpVEpZYlVsKzgx?=
 =?utf-8?B?bzJ5ME9JdkpFRUtHa3JJM09PK0NZaXlKZTdaT0xwbHVGeGRNemFUOXNlbUp5?=
 =?utf-8?B?Q1dKOGk3RkJEWE9hWnlDNzBVb1ZJT014U2R3aFFlWWtCVnlzYzViZytsdjla?=
 =?utf-8?B?R2s5bkl5Nnpta0tIRmNxM3NuSHFndzYvdFcxcXhlY0hOT1BNWGRmNEZhMnJu?=
 =?utf-8?B?R2dRNUhQTlVPajZlaURrL2JsWU1sQlRJc3BJUjBqbDJxTHhGZk9LVkhNdUVp?=
 =?utf-8?B?bVVMN2NpUDFTeVhkT0YyM0JKS0NmblozWm45UmJCUnFNM3VDUWErYzk4ckFM?=
 =?utf-8?B?bDNpaXUrbnk2S1hrdDJsVXhRdWticE8vSWlzbkc5ZXMyZWhSQVNGNGZHTmNv?=
 =?utf-8?B?bWNxUGxWRkRtSFU2bEo3VjN4SzhnN1M2N0RuYkhDZC9jVlNlMW9BSjYxMlhp?=
 =?utf-8?B?OUgyWkFHRlZqc1M1SzJTbk50RHR4TnJucy9CZWk5T0JhQVYrZmxFd0VSK2pJ?=
 =?utf-8?B?NTY0ZWtVdjV4MXlaamxhN0tMTTZUOVkxTGRjOWpha1ZFRDVCMXhJanFuS3N2?=
 =?utf-8?B?aEdNRXp2c1Z3TDkycnFrNmdDMi9Fd0UySTc2SWQ0WHE1T1hiUEFCaEFTM2g2?=
 =?utf-8?B?dkpPMHRMY0s0RENZREhPZ0NvaHJGUS9pYnhCSlkxaUs1RUxUcWJZQ054eXJZ?=
 =?utf-8?B?N0lEYWErcjdFNHVPaEF1QXd5ak5lb0RubEgxem1vVy95dDdsYVJTaWtCZXBj?=
 =?utf-8?B?cmxZWlhzWU5kY1VWam1XZnpMbXBiZ2NuVFZSWmsrQ1lCelc2dHdkMFNrTm43?=
 =?utf-8?Q?hjAh6druxtyluCkMGc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a4b23d-297d-4407-71a7-08de88c41ca3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 10:08:21.5392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hv4+yzWnIwlr2d9iYBUoAWYq+dnq2GXjhkNfOp8pT8T4349sgfZXBSruw72ofc3Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6240
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

On 3/23/26 10:44, Liang, Prike wrote:
> [Public]
> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Friday, March 20, 2026 5:45 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu/userq: fix the old userq fence dereference
>>
>>
>>
>> On 3/20/26 09:41, Prike Liang wrote:
>>> It needs to drop the old userq fence dereference, otherwise it can't
>>> be walked during freeing the queue.
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 16 ++++++++++++++--
>>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index 9df62f71f27c..f1acd785c27d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -105,9 +105,21 @@ int amdgpu_userq_fence_driver_alloc(struct
>> amdgpu_device *adev,
>>>     get_task_comm(fence_drv->timeline_name, current);
>>>
>>>     xa_lock_irqsave(&adev->userq_xa, flags);
>>> -   r = xa_err(__xa_store(&adev->userq_xa, userq->doorbell_index,
>>> -                         fence_drv, GFP_KERNEL));
>>> +   struct amdgpu_userq_fence_driver *old;
>>> +
>>> +   old = __xa_store(&adev->userq_xa, userq->doorbell_index,
>>> +                         fence_drv, GFP_KERNEL);
>>>     xa_unlock_irqrestore(&adev->userq_xa, flags);
>>> +
>>> +   if (xa_is_err(old)) {
>>> +           r = xa_err(old);
>>> +   } else if (old) {
>>> +           /* Doorbell index was reused: drop the replaced driver's ref */
>>> +           amdgpu_userq_fence_driver_put(old);
>>
>> What? Why is a doorbell index re-used while there is still an userq fence driver for it
>> around?
> As to the current userq doorbell index calculation there sometimes can have a same doorbell index for the two different userq during each queue creation process. There may need to handle the old fence which hasn't been signaled when a new fence stored at the same doorbell index.

Ah, I see the problem.

The issue is that amdgpu_userq_fence_driver_alloc() and amdgpu_userq_fence_driver_destroy() registers with the adev->userq_xa.

That is not only really inefficient, but also leads to this bug here.

Instead amdgpu_userq_create() and amdgpu_userq_destroy() needs to do that.

Additional to those problems the reference counting for userq->fence_drv seems to be completely messed up. It should be inside amdgpu_userq_destroy(), but I can't see were that one is currently dropped.

Thanks,
Christian.

> 
>> That doesn't make to much sense.
>>
>> Regards,
>> Christian.
>>
>>> +           r = 0;
>>> +   } else {
>>> +           r = 0;
>>> +   }
>>>     if (r)
>>>             goto free_seq64;
>>>
> 

