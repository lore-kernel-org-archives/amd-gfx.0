Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBBAC43334
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 15:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E03910F7A6;
	Thu,  7 Jul 2022 15:47:30 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2083.outbound.protection.outlook.com [40.107.212.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E65010F7A6
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 15:47:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7ukTfc+rTTfT+KUeegg0LZOF/NaiR7IspiJDjrfr6UJHDdiARLgYE4fZrniF8BBRoDCqVBy5Eqe93HLuGElhT9QMvJKyAiI7L7MftnUVKEJdPbgRqJu4MvzwBK1mrEep0B7Mune00zj4l01xLwrzoFcdEqmck4bqlVUoZ4P/Gb8rIKAAeo3CHsBg5cgNIGFGBeuwfq5+HZZbCXvB4c81M9FOg3pYRzDheFfQvrMFYi2S6X3khjhIZuIplvJZcN9EJJwGc0FSSuUvFCr0YrmZvrmjPOKUqJV8wjDZwW5IjC57sMrYJOmHecYuSmbKFs3a34ZCDuaGisE/AdzIW4xjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGdA5sNFFDRUr8WOPSQHmEgRgkNf33OOex+z41KfMnc=;
 b=Wo90AeDgC/jiL2p+GnvM+eoHrfjzsn+F8mz4L8Galz+TmzrViHkDWeR0VfdXQuOFCsopY7gHgd1WZR4NEF6DhMODObrA+VFIPVywfUXwO3Vl/MG5nRaRFWiKin4qMv3R4JOV0NyTNctPkV+Bd7h5pg9taRSbZ1INJfCAX6aLOJGBs+20MUbj7tBRmXc8tMoTAts9PJteSKC/dVzKLfcbQro0vvvW5VkAu4c8hRZXXxc+OWOf6n4E1xjPNV3tJB8uHEQtuLFCmdfPllTEQ1n2ilyJNY7TZVAFsRWtPVewdd90uG4k311Kee6H/1+NlgCAcuhSJ7GbnqGhuW49CdV6DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGdA5sNFFDRUr8WOPSQHmEgRgkNf33OOex+z41KfMnc=;
 b=r1H6R/L55Rr/nBUL7H+Zplzxvq+8xeJRUmE7ssmFdjeYAdm/OmiObTMIwF5/2NfXtTbKfcNBdfNzb3g8aNswWnp+NZOkUjCvyAk8Y/L6aI+HhFswNWT/bQdfkTlYhSB8AWH40dKlXv1Fe/ZyHWaN5H/1arsXnO0QxEKR6w91e5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MWHPR1201MB2542.namprd12.prod.outlook.com (2603:10b6:300:e8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Thu, 7 Jul
 2022 15:47:25 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa%6]) with mapi id 15.20.5395.022; Thu, 7 Jul 2022
 15:47:24 +0000
Message-ID: <4b60ece6-afa5-62ca-afa6-bb800cdba982@amd.com>
Date: Thu, 7 Jul 2022 11:47:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu: Fix a NULL pointer of fence
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220707095053.6755-1-xinhui.pan@amd.com>
 <92f468dc-2fad-5135-4aeb-c8ce2a680c69@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <92f468dc-2fad-5135-4aeb-c8ce2a680c69@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bbe93cd-6cf5-4613-1c6d-08da602ffca4
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2542:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aNmyYjm6U0dWXJeWw0wqzQY4u+NCwER+nB81PdnPyWxuBE4/ma3fW5ZVY6ALHQW5aSBafkJDDxXPKs92/ppJH+4ks4j6waVZXVGYm95TPz/S5hJW94tBSr0yAWtSKUrfJREnzsvCQzOQwaxUJYDS8/JwQxsavtPAuN3BCR7G1whaHTdQnWLBz/vRSRo8OU9A6zjBcgRZ5QfSoqI5fq5ZWUfWfzr3HOPM9YAHtfWYECHwMvPVFQajWUqKQRPTSqRlxBfHFnbqwjqL5+nAFTYUSvo6UZ1G9NAxCjsVMNQZmJJgmfeMe/KBRZ55H9YjOGmbzPt5Mxg0G0qBi2ksdVd+mCSNrqS369QUoa+y7MM5ZQL5y0WtFlgernMJLeY7KiQTtTb+51i0tJkSlDJrn2ezUucTuxe59XL3vL4varYefQIHwETSu+Ed2pQhn2emk6Ed1Cqjx3Po7rfNrbvfcrijnPfkTnbuEGt9X/xZD4UTQbfYwuNBKvaGONVVauUCn+wdSiX4Gln9aJiulaLtP5sIzZT8djuGdqO2Bh7F1IKPLbXG+JjCBOrp3i0SxpP5qJoJsWETBTChWUB4Sokil/Su8QJFozh6zuokx3nH5DwVKpy8NZ6Fv2FElBvs2D7f1ao10nNeW8Gv/E7am6vdyfCGkbDLINgdZpsHrsbJzPmRQJO2D8S0oHq7BYznzhAzQ5g3it1EIl8qSQe3nd+lK7k2ImInf2g5ErsWRLC9u3pqXUlO4rAh+Z/5loWWd90Bkt3RqJNfoT8Dj51y5oPj6B3qaXn04fvEK4fx44cSluNggUXsymoCjb8+OCcDfVKw3HkZrSicPLAzdkw6PFX1V62bct96xhLFY1TLUbTU7zLAd00=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(83380400001)(6486002)(478600001)(316002)(2616005)(31686004)(86362001)(41300700001)(36756003)(6512007)(6506007)(26005)(31696002)(186003)(66574015)(110136005)(8936002)(2906002)(66476007)(5660300002)(44832011)(66556008)(66946007)(4326008)(8676002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmpUTUN4WlE4TUhvVTRDQnlVeTJKR3NYNkZxK3R6dVVZOWxMTUpIOWw0OURH?=
 =?utf-8?B?YStIeDdoNnUwaDg4VzVRNXhFUmY4Z1ZpYW9YelQxRUpFNEVUYThZdzJJVHBB?=
 =?utf-8?B?TTEwVitXUGNpVmtxdEVpR0Qray9WenJCemlnYmN2MHp5aVFvMWgzR2dQWGE5?=
 =?utf-8?B?b01yOVNDd1lqNU1wSXFGY2Q2YlBkeHZrazJJY011elZBc2dLQklwbkxKYk9o?=
 =?utf-8?B?azFrdzNTMU9hb1JpV3BOaVNQYmVsQmFZNkIrUnpZZkRFN1gzSXNCcTNUaCtn?=
 =?utf-8?B?TzlEV2JCV3lwcVkySmpiWkRTTGpWSnRWQUNZZEQ3eS9admpnSm1QZWdsc2NS?=
 =?utf-8?B?Q3ZkSzVPNjM1MGhzL0pGUjBuUUc5NVN0YTdRSXE5d1UwUTdNT3IxWXk1NjRw?=
 =?utf-8?B?ZXp2TktzMmF4dnQ3L3FXTVcvcVphMUIrMnFSL1FFRjVsSFRZUmxKWm1KTGM3?=
 =?utf-8?B?bGRvMDk3U3hPWDdFWnJ2b0ZPdnlZQk41bEFuOWNwbVEvVGdndGtyUTNmQzE5?=
 =?utf-8?B?aGVZWFRkclcwRTc0bHovL0llSFV2TGFqVERKMGtFRGhVUGZOMWtzLzhiOWN4?=
 =?utf-8?B?V2t2eS8vV3VDRFMzVFdUcVJ3Z0dFZ2xOVVJteFpJbUhib2xrdGd3dzNPTy9i?=
 =?utf-8?B?dWdRMC9qZGUrZ1BLWFpZUk5wWGVYRkswaEJ0dXF4TXV6MHBEc0lVVnJWUlFN?=
 =?utf-8?B?aU9OVkdzaHBOV2p3ZktBQXNQcnVHeTB5Qzgva0tOOFU0RlJTbXF3a3YyU01D?=
 =?utf-8?B?QkowNFJXdG9TKzVzZ2YzREpwTjNnYkNoakRrdFhta0hiT3FPYzlzdjZoWSt2?=
 =?utf-8?B?UUtNNGVPcmY4K3ArZjRiUXZnd1VIUkRycVNRR0E0VURXWVAzK0ZndmJ1ckRE?=
 =?utf-8?B?bGlVbTFPdkZGK0ZNVU5JLzUzOEZGZUhJSnV5NW0zYTRDczJVZFpmVzVQZmdD?=
 =?utf-8?B?eng1cmFiOGtKd2c5ckhCSVRLbFV0NXR6djFqcFpBZ1V0Z2FiTkdyRFNaUnJD?=
 =?utf-8?B?OTdNK01BRmdnVXZNeW9NV0lNYm5LaDI3RFlXd1FoaUJ3ZTlDMEhxdDRYaXJX?=
 =?utf-8?B?UndOZmx0QWlGdGoydWYweEZMY0xCOExlN1VsVHBzRE9pemFYcGFZQjltTUxL?=
 =?utf-8?B?NUtUS2l2TG5iY1U0bzdBMWtGZTBpYzE5bTU2MWp1cXduM3lXUDlNUzAwR3I0?=
 =?utf-8?B?b1FsaEVaU0dRNTZaeW5JR3V1UkpsSnZxSlVnNGl0N2xDZEE4Q2c1TGJsZ3JD?=
 =?utf-8?B?ZFl2TjA4UElZaUdQa1BLOVpRMUJscVdWTUNHWmQrR3Nwak5JT2thdzRWME4w?=
 =?utf-8?B?Wk5WQXFSVE13ZVpoVkgzYzhUV1FTS2xOU1hCZ3N5aDZsbGk3ZFpWVHlwZ0J5?=
 =?utf-8?B?TkRPZ05OcEtIcyt4aEJ5MkRCR3hMWSt1SEYvd2xoalM0MEo1QWU5eVM5a3lV?=
 =?utf-8?B?SEVVN2ZOaTFEZjYyQTZnRURDNTI5TzdYb3BVQ0NUcjJyczY2aGhUTkJxTHY2?=
 =?utf-8?B?aTRDVzZaclZ1enhYQS9NVHBPcDNackdENDBtY3FjS1oyaWdJaE83SW1aRFow?=
 =?utf-8?B?RkxvSmZ2aGNCVW12djdrK1Vieit0M3FWTnZCUk5tbnZwUGxzVnpQQkVPczdv?=
 =?utf-8?B?OUhLK0pUVmpMM0RLM3dWOFZOMWUxb1prZVBiQjFSRHRMTUpkbHcxZytQNjQ0?=
 =?utf-8?B?YmN4M2RxL3d0cnA1dURNaTMrWFdFLzVqbnBtUFFVZVU1cWtHWTJpbDJuM2lW?=
 =?utf-8?B?dUlXTURVYWdydWtQczJhN3RxZXorWFcrWWY5b1I0QnNuQU1QcE0wcmdmOEY1?=
 =?utf-8?B?OTgzWGtYaHRjczBaYmlMK3loTk1WMnkrRDEySWYrSDJaTzhqM1hFNXlSMEdt?=
 =?utf-8?B?NExWeUcvbzJPdFRKSW9WRXNVb3FNVmxKZFNFS3pEN2o0dXZDWXJOQmNIelJi?=
 =?utf-8?B?a2xpT21GQ2hZaFUvdStDSGhHZTllU1ZDd0ZxbnhoS1l0SFlENGtLSFVkSStQ?=
 =?utf-8?B?cnlFM2Y2RU1rSHVPTWN2VlJRTERsb1MyUGRrbm5mTUV1QTh1MSthaTFVYUlS?=
 =?utf-8?B?LzFjVnVRczdsbnZhak5RS0VxYk1HSVYxTytHZWZuT09LQkNHT0R2bGcrNC9W?=
 =?utf-8?Q?D/C+oCGBzDMYwjiIGTIaeLCo0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbe93cd-6cf5-4613-1c6d-08da602ffca4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 15:47:24.5470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5+Aa1Hw6iCj1MpozEHk5bcfLZ82EkIOy+ij/17xZY8CKXna7WJSnbAsNG1iWSau5JlXS7KwFanyA/BW1aZjzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2542
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-07-07 um 05:54 schrieb Christian König:
> Am 07.07.22 um 11:50 schrieb xinhui pan:
>> Fence is accessed by dma_resv_add_fence() now.
>> Use amdgpu_amdkfd_remove_eviction_fence instead.
>>
>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 0036c9e405af..1e25c400ce4f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -1558,10 +1558,10 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct 
>> amdgpu_device *adev,
>>         if (!process_info)
>>           return;
>> -
>>       /* Release eviction fence from PD */
>>       amdgpu_bo_reserve(pd, false);
>> -    amdgpu_bo_fence(pd, NULL, false);
>> +    amdgpu_amdkfd_remove_eviction_fence(pd,
>> +                    process_info->eviction_fence);
>
> Good catch as well, but Felix needs to take a look at this.

This is weird. We used amdgpu_bo_fence(pd, NULL, false) here, which 
would have removed an exclusive fence. But as far as I can tell we added 
the fence as a shared fence in init_kfd_vm and 
amdgpu_amdkfd_gpuvm_restore_process_bos. So this probably never worked 
as intended.

You could try if this is really needed. Just remove the eviction fence 
removal. Then enable eviction debugging with

     echo Y > /sys/module/amdgpu/parameters/debug_evictions

Run some simple tests and check the kernel log to see if process 
termination is causing any unexpected evictions.

Regards,
   Felix


>
> Regards,
> Christian.
>
>>       amdgpu_bo_unreserve(pd);
>>         /* Update process info */
>
