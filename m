Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57555C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 16:58:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E53A610E5BF;
	Wed, 20 Dec 2023 16:58:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46B3610E5BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 16:58:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZK7wVBotE/scufRBvWpaQ8NiyzwKkwEr/8B3LJJRgB6jBeNx5CMXHxqjqEE+PzvGyNzv4TDfKV1C+7yFwEs6WMs05YwIBQB2NvVs7pcXsvQf+f2GKKrktqJ5OkwDN77UXDXCjbaKKlt/3feDjdJCydnkneF//6yms646nXHKdJBCoomBEWG1lPrjkKMxRP3AaT/xoKPTqRysZK1UCnsmhXlgstb4oFteHDLOazJ9vjCXRHUnLrBDOFs9S0VpS4vaCiD82BGLGTzW0mJbLRAQRg3zobCVt8QPeuMa1B4sdJs1jKF9c14xU+xPFz06gPxoyGITlaNR4iVCnxXocWkL1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4il+ajnZKpaFNQo1alIy223IKM/zXIqsGNj1u4T+0c=;
 b=kun5ZikFaWTrwjgEpb4LujbfgM9kzDehdBu3IPb0xbfIPwkG5wVp8yetgmFkX/rFxF9caWnNcZec1uENDAoMS5rwoakHfXIZ3kGNbcQbIT8zEbalXjG5LtBVaetJFV+Lfybre6Ax9/4Rgzduzeuv+6XXBd4Tw+LLjN1zQ2PxXSRID8JPOO7ZzXfk0OpERTd9/tb60OhObocgQ2o+c1XUgPtnoJlbXBH91OkHZFM4aLnD53W8DIA4akpeLTjoRwLOtfWk9z/uQ2wFCgIjvZKflfK9xLQblGXCZOMfTjAtgGavuUWCggYo0c+O3arUcuZzRCOBfzfL0zN9I8cw9q82RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4il+ajnZKpaFNQo1alIy223IKM/zXIqsGNj1u4T+0c=;
 b=jFLWUyEQUj1wCn6/OOGk2kgHpXJIEXG3O9z2neRljeCKPoRvd5C1P2CDOjrVcJDLUmeBaF+Zz2PlI85O8RH2Dm+EFw46IrM+VGxdc2U92zWJ8hwnJod1Hndls3m5BDgb6Rq8ymTe9+rlPkWg/i5RfOk4qpTMv7YpJsjFJEo4XWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB9147.namprd12.prod.outlook.com (2603:10b6:610:19a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 16:58:31 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 16:58:31 +0000
Content-Type: multipart/alternative;
 boundary="------------kyKS40pYdhyQbwE7EUIGXQx2"
Message-ID: <ef8c4273-d54d-42b6-ac60-fed5f8ed3848@amd.com>
Date: Wed, 20 Dec 2023 11:58:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix sparse __rcu annotation warnings
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
References: <20231205222026.2108094-1-Felix.Kuehling@amd.com>
 <e879ea47-4281-4830-a4db-5a144999198a@amd.com>
 <a6411c81-d0ea-4002-bfc6-a725a83eb9bf@gmail.com>
 <7b67d4f1-cfcd-47a9-a80e-f4c1eee235a1@amd.com>
In-Reply-To: <7b67d4f1-cfcd-47a9-a80e-f4c1eee235a1@amd.com>
X-ClientProxiedBy: YQZPR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::10) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB9147:EE_
X-MS-Office365-Filtering-Correlation-Id: d3446bdc-1f32-48b0-cdfe-08dc017ce528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pGhNysOGHVymfC+woacRUvvNBZmUF1cYtm8Z08Nc7Zad/jTsoKCc0KRZ6PxMngPfXN9CkdOXr4KNNzk3SGMItNCMk7QKWIxCIqL/YmU1fYkbruwUqpA6nyCWVXG3Rmvcg3ChlxIYM6v7V/JkNvIDc/vubQ1WSSLZ/vxs6HQJC3AJWv/JtnOCzYTxjsNgN0ebfBgjne1W9FNDGuR/bBT15lOyrLrdFsSjv5hWjstCjf7JQDj7ZEqFWeeXKjIKt81T1IxbkLa/AD90GxEgRuB2rgX+0oY7wTFafObpc6moaY1eYe2mDC7K+Mo7wHGlVfoaF+EWTr9AADlqLWXGe7tn9j+9DVdpYuik0uQrzHfBHUvx0NS+7/STzSV3hlHcGbT/H7pxTfkondJD6uqWZVJNXPGHaGMfESxcJvZmmQY7Zh6Ex1MxJ8zWXRD5pQMOo9d6TZ6qUib9NCJJawpS/Hlukp1VGWCSmHExY1gLzYsjuBs4zj7WmxTtqxDDeRosdxMIppOawQ4dKRKm9bUdnIZW7PkThC+pgs3g7ULb46OIwX1Jt8f2LIPQ8c5091h56M24+uQToaZudiI6cC+psTjQVehigb8IDIs0N7iLNId3BmRymjsTkY6JT8aCyu5/16am
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(38100700002)(2906002)(36756003)(4001150100001)(8936002)(166002)(8676002)(5660300002)(30864003)(44832011)(4326008)(478600001)(26005)(2616005)(6486002)(41300700001)(966005)(66574015)(6506007)(31686004)(53546011)(6512007)(6666004)(83380400001)(66946007)(31696002)(86362001)(66476007)(66556008)(33964004)(6636002)(316002)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c09OejdBN1NRSEIyNlNSUEU3Q3M4VWloREl1anNOTFVpZ3FaRE5CUnN5NFl4?=
 =?utf-8?B?Z2hNMzdJZzNjUEFWcUhvWTFPL2duMVd1R2dhWEFNY0ZndVNTcmZlVXFMa1FI?=
 =?utf-8?B?c3RUVXI3d0hhcHJXbHU1QTY4cHdWZEF6SHlqQkVTdGZPK1NZTmlONHZTeDFK?=
 =?utf-8?B?M1hodkFkNzN0Ky90SjhzSWZQQUZhMllTY0xGakJINVZ5OTRiZlZyMHRvRTdK?=
 =?utf-8?B?TFJOVmpmMWVSRXNPZ25sSEdkZWUrNFdZZ1JJNmlxZ0JpcEp1UG9TNmRlL0dT?=
 =?utf-8?B?aFdLUHVJbkZvams3TThQY3ZFbWthbklBc0w2dFNPSURiazZ0UEorTFA5Yk1x?=
 =?utf-8?B?cUsyYjRZekF0VnVyMVJ6RU9JRDhyUWVwendUR3RUdWRHSWFmT0hwNVhPdjlp?=
 =?utf-8?B?dkpQK244QldWZlBMa3dnVmVYdXpPVXFYUElhbEU1RXBCZlBwNUMwZmY3cXZF?=
 =?utf-8?B?VVJHU1l5VTBmUDR3YktIMGY5QXVSUHpyRTlLeDdlZWpZOVpLWERxQ0FrYXZZ?=
 =?utf-8?B?WWJFVzhLRGtCYTB6SHBIcy9GdmJqUGJvVS94WFZYZlNERjZ1TzRQb0h5V3dT?=
 =?utf-8?B?alpkZkhtQ2hUd0dCNHMvZnQrS3BUaXVMQzlLUXM4REF1NTB6c21vRzdLYzZo?=
 =?utf-8?B?N3JnU3RuNENvM1dEUTVrVjBHcHBReTJCNVhYWUU0bDEwbHd0bXRDM1VDSmNF?=
 =?utf-8?B?Z1hnOHhCMXFZOXhzenFDaVdYaHgzVDRSZlhFcUZTN1IrcjFKdHFUUi9MVWo3?=
 =?utf-8?B?cXpQUE5sNGdTQVcvUmZVWDJ6dVhjYTFsamNmUmlJSStQNVY0b1pVYUpab1ZP?=
 =?utf-8?B?Ky8zVDRaQTd2eXYrKzVwL2U5MkZ3UTJrNFhBclFOR2ZBYXlDN2R1eno3aHhE?=
 =?utf-8?B?VmMwR0draHhQM20wTUlnaWtWbmlERERwYmVCekd4c3RZZnN1WFlWdEd5QjNB?=
 =?utf-8?B?TlIwUE8xaC9odnNBYW1KaTFrWDZVZ01rNEhVQ21hdTl5alh0ZnNwcGkyM3pD?=
 =?utf-8?B?V0RVMHZHTURyMHgrdVlhNmsxUy9lRXRWdnpzbzBKUXpGMkxESGdaL0p4S2dR?=
 =?utf-8?B?NU9tblBpQnNuRzg0MitrRFh6MUVTK1F1QUVOR3d3ZCtCNFRia0YrL2M5RE95?=
 =?utf-8?B?ejJmelpudjVoTlB5R0hWVXlrRll0emtYd2dsVkRzTUI4Um1UZjJMRFRXb3lr?=
 =?utf-8?B?UjhVOElpN3ozQVdoazZzYUxDWVB5R2w5ODA0RFlJeUY3dW9XWnlJZVhCS0tm?=
 =?utf-8?B?dTNreCtYb01rWkFXYVpJdjRleWxmR0ZhdVgrbFd3MjVmQjRjRFUzL2d2aHVs?=
 =?utf-8?B?eHNvaHNwVFFHR3AyMFUvS0VIdXlpY2xBRXk3b0d1SGJPOU9raTFVZU5NakNo?=
 =?utf-8?B?Z09GV3hOZ0tnc1hBWUtwbzA4NDRrOG4yZ0xKakhPOXVYazd5Y2F3MzMweDNk?=
 =?utf-8?B?R3QwZTZnOHhnbkkrRlVVWHpxU1E0Vjc2dkJjNTFrbmlDbE5CMDlza3hadlRQ?=
 =?utf-8?B?RjBOSEJUcks0Z1RTREN0d0dDekl2ZUlhbXdmY2Y3L3VmR3VxWGxMaGpvalJR?=
 =?utf-8?B?NUh2Z2NXR2pESGx1UUpXbFVQOURvU2NXUzhRTkhaWEZpVk0rN3dvaVp1ekdp?=
 =?utf-8?B?VVlPWHVZajlmM2FGOUJ3K0VMbG93bTdWdzU3VFlnQm5Yais3WEJtNUtnZ293?=
 =?utf-8?B?MThXaE0yb1loVzNqWXlyVVhXejZ3THBqd2s2Z255dXJidnljZWNueXZTV3pa?=
 =?utf-8?B?b1RkTWJCSmNCQkJUL3BiVmxyMHFXcFNmTEtsdzZRUVc4VFNvRkVPWkV2VXQw?=
 =?utf-8?B?NVg3cjUvS2t1VUlHcnBaQW9xRVcxZzRYNG94c0RnbjJzb0RpSjJPdG5rbmV2?=
 =?utf-8?B?aVdvMmIyVmNHTTNBdDhvZmQzN3ZKTWZXdXN5WldSWlJ5bG9JSVpBZmVmVGtT?=
 =?utf-8?B?OE00cGhNWjlwOURvZkpvVHJvZjZZZTFiS2dUN1Y3OVNBRDBFVFA2MGg0akFK?=
 =?utf-8?B?U3dIZlEvOG1vcUNzTzVGbGRMdW9UbEp0RzR3UVoxcXZLUWJ5WUpnYWdORVls?=
 =?utf-8?B?bmxMOGF2VGxhR2JYajdka2U5VjQ4ZDdiZmFpUFk0OHBqYzNqQzhqeDU2bFcv?=
 =?utf-8?Q?ATvJ+YxObdbhr88W3BYgRN5fc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3446bdc-1f32-48b0-cdfe-08dc017ce528
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:58:31.3368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUPCOJMtUuiKG2AMj5dWMLms18tKh79oEHNlzMMgLhIpKxsTIB1Cg5BZnI0Ev0Ohn13m8KLxOq8whahZJ3Xa+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9147
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
Cc: linux-mm@kvack.org, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------kyKS40pYdhyQbwE7EUIGXQx2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023-12-11 10:56, Felix Kuehling wrote:
>
> On 2023-12-08 05:11, Christian König wrote:
>> Am 07.12.23 um 20:14 schrieb Felix Kuehling:
>>>
>>> On 2023-12-05 17:20, Felix Kuehling wrote:
>>>> Properly mark kfd_process->ef as __rcu and consistently access it with
>>>> rcu_dereference_protected.
>>>>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Closes: 
>>>> https://lore.kernel.org/oe-kbuild-all/202312052245.yFpBSgNH-lkp@intel.com/
>>>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>
>>> ping.
>>>
>>> Christian, would you review this patch, please?
>>
>> Looks a bit suspicious, especially the rcu_dereference_protected() use.
>>
>> What is the static checker complaining about in the first place?
> From 
> https://lore.kernel.org/oe-kbuild-all/202312052245.yFpBSgNH-lkp@intel.com/:
>
>>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:1671:9: sparse: 
>>> sparse: incompatible types in comparison expression (different 
>>> address spaces):  >> 
>>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:1671:9: sparse: 
> struct dma_fence [noderef] __rcu * >> 
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:1671:9: sparse: 
> struct dma_fence * ... >> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36: sparse: 
> sparse: incompatible types in comparison expression (different address 
> spaces): >> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36: 
> sparse: struct dma_fence [noderef] __rcu * >> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36: sparse: 
> struct dma_fence * >> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36: sparse: 
> sparse: incompatible types in comparison expression (different address 
> spaces): >> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36: 
> sparse: struct dma_fence [noderef] __rcu * >> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36: sparse: 
> struct dma_fence *
>
> As far as I can tell, the reason is, that I'm using 
> dma_fence_get_rcu_safe and rcu_replace_pointer to get and update 
> kfd_process->ef, without annotating the fence pointers with __rcu. 
> This patch fixes that by marking kfd_process->ef as an __rcu pointer. 
> The only place that was dereferencing it directly was 
> kfd_process_wq_release, where I added rcu_dereference_protected. The 
> condition I'm using here is, that the process ref count is 0 at that 
> point, which means nobody else is referencing the process or this 
> fence pointer at the time.

Hi Christian,

We discussed offline that you think rcu_dereference_protected is not 
needed in the teardown function. After reading over rcupdate.h, I think 
a simpler alternative would be to use rcu_access_pointer, after a grace 
period to ensure there can be no more readers. Based on this comment in 
rcupdate.h:

  * It is also permissible to use rcu_access_pointer() when read-side
  * access to the pointer was removed at least one grace period ago, as is
  * the case in the context of the RCU callback that is freeing up the data,
  * or after a synchronize_rcu() returns.  This can be useful when tearing
  * down multi-linked structures after a grace period has elapsed.  However,
  * rcu_dereference_protected() is normally preferred for this use case.

The last sentence sounds like rcu_dereference_protected should also be 
OK, though. Either way, it sounds like I need to add a synchronize_rcu 
call in any case, before freeing the fence. Do you agree with this proposal?

Regards,
   Felix


>
> Regards,
>   Felix
>
>
>>
>> Regards,
>> Christian.
>>
>>>
>>> Thanks,
>>>   Felix
>>>
>>>
>>>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 +-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h            | 2 +-
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c         | 6 ++++--
>>>>   4 files changed, 8 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> index f2e920734c98..20cb266dcedd 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> @@ -314,7 +314,7 @@ void 
>>>> amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
>>>>   int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, 
>>>> struct amdgpu_bo *bo);
>>>>     int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
>>>> -                        struct dma_fence **ef);
>>>> +                        struct dma_fence __rcu **ef);
>>>>   int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device 
>>>> *adev,
>>>>                             struct kfd_vm_fault_info *info);
>>>>   int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device 
>>>> *adev, int fd,
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> index 7d91f99acb59..8ba6f6c8363d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> @@ -2806,7 +2806,7 @@ static void 
>>>> amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>>>>       put_task_struct(usertask);
>>>>   }
>>>>   -static void replace_eviction_fence(struct dma_fence **ef,
>>>> +static void replace_eviction_fence(struct dma_fence __rcu **ef,
>>>>                      struct dma_fence *new_ef)
>>>>   {
>>>>       struct dma_fence *old_ef = rcu_replace_pointer(*ef, new_ef, true
>>>> @@ -2841,7 +2841,7 @@ static void replace_eviction_fence(struct 
>>>> dma_fence **ef,
>>>>    * 7.  Add fence to all PD and PT BOs.
>>>>    * 8.  Unreserve all BOs
>>>>    */
>>>> -int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct 
>>>> dma_fence **ef)
>>>> +int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct 
>>>> dma_fence __rcu **ef)
>>>>   {
>>>>       struct amdkfd_process_info *process_info = info;
>>>>       struct amdgpu_vm *peer_vm;
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> index 45366b4ca976..5a24097a9f28 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> @@ -917,7 +917,7 @@ struct kfd_process {
>>>>        * fence will be triggered during eviction and new one will 
>>>> be created
>>>>        * during restore
>>>>        */
>>>> -    struct dma_fence *ef;
>>>> +    struct dma_fence __rcu *ef;
>>>>         /* Work items for evicting and restoring BOs */
>>>>       struct delayed_work eviction_work;
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> index 71df51fcc1b0..14b11d61f8dd 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> @@ -1110,6 +1110,8 @@ static void kfd_process_wq_release(struct 
>>>> work_struct *work)
>>>>   {
>>>>       struct kfd_process *p = container_of(work, struct kfd_process,
>>>>                            release_work);
>>>> +    struct dma_fence *ef = rcu_dereference_protected(p->ef,
>>>> +        kref_read(&p->ref) == 0);
>>>>         kfd_process_dequeue_from_all_devices(p);
>>>>       pqm_uninit(&p->pqm);
>>>> @@ -1118,7 +1120,7 @@ static void kfd_process_wq_release(struct 
>>>> work_struct *work)
>>>>        * destroyed. This allows any BOs to be freed without
>>>>        * triggering pointless evictions or waiting for fences.
>>>>        */
>>>> -    dma_fence_signal(p->ef);
>>>> +    dma_fence_signal(ef);
>>>>         kfd_process_remove_sysfs(p);
>>>>   @@ -1127,7 +1129,7 @@ static void kfd_process_wq_release(struct 
>>>> work_struct *work)
>>>>       svm_range_list_fini(p);
>>>>         kfd_process_destroy_pdds(p);
>>>> -    dma_fence_put(p->ef);
>>>> +    dma_fence_put(ef);
>>>>         kfd_event_free_process(p);
>>
>
--------------kyKS40pYdhyQbwE7EUIGXQx2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2023-12-11 10:56, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:7b67d4f1-cfcd-47a9-a80e-f4c1eee235a1@amd.com">
      <br>
      On 2023-12-08 05:11, Christian König wrote:
      <br>
      <blockquote type="cite">Am 07.12.23 um 20:14 schrieb Felix
        Kuehling:
        <br>
        <blockquote type="cite">
          <br>
          On 2023-12-05 17:20, Felix Kuehling wrote:
          <br>
          <blockquote type="cite">Properly mark kfd_process-&gt;ef as
            __rcu and consistently access it with
            <br>
            rcu_dereference_protected.
            <br>
            <br>
            Reported-by: kernel test robot <a class="moz-txt-link-rfc2396E" href="mailto:lkp@intel.com">&lt;lkp@intel.com&gt;</a>
            <br>
            Closes:
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/oe-kbuild-all/202312052245.yFpBSgNH-lkp@intel.com/">https://lore.kernel.org/oe-kbuild-all/202312052245.yFpBSgNH-lkp@intel.com/</a><br>
            Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
            <br>
          </blockquote>
          <br>
          ping.
          <br>
          <br>
          Christian, would you review this patch, please?
          <br>
        </blockquote>
        <br>
        Looks a bit suspicious, especially the
        rcu_dereference_protected() use.
        <br>
        <br>
        What is the static checker complaining about in the first place?
        <br>
      </blockquote>
      From
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/oe-kbuild-all/202312052245.yFpBSgNH-lkp@intel.com/">https://lore.kernel.org/oe-kbuild-all/202312052245.yFpBSgNH-lkp@intel.com/</a>:<br>
      <br>
      <blockquote type="cite">
        <blockquote type="cite">drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:1671:9:
          sparse: sparse: incompatible types in comparison expression
          (different address spaces):&nbsp; &gt;&gt;
          drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:1671:9:
          sparse: </blockquote>
      </blockquote>
      struct dma_fence [noderef] __rcu * &gt;&gt;
      drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:1671:9: sparse:
      struct dma_fence * ... &gt;&gt;
      drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36: sparse:
      sparse: incompatible types in comparison expression (different
      address spaces): &gt;&gt;
      drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36: sparse:
      struct dma_fence [noderef] __rcu * &gt;&gt;
      drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36: sparse:
      struct dma_fence * &gt;&gt;
      drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36: sparse:
      sparse: incompatible types in comparison expression (different
      address spaces): &gt;&gt;
      drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36: sparse:
      struct dma_fence [noderef] __rcu * &gt;&gt;
      drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36: sparse:
      struct dma_fence *
      <br>
      <br>
      As far as I can tell, the reason is, that I'm using
      dma_fence_get_rcu_safe and rcu_replace_pointer to get and update
      kfd_process-&gt;ef, without annotating the fence pointers with
      __rcu. This patch fixes that by marking kfd_process-&gt;ef as an
      __rcu pointer. The only place that was dereferencing it directly
      was kfd_process_wq_release, where I added
      rcu_dereference_protected. The condition I'm using here is, that
      the process ref count is 0 at that point, which means nobody else
      is referencing the process or this fence pointer at the time.
      <br>
    </blockquote>
    <p>Hi Christian,</p>
    <p>We discussed offline that you think rcu_dereference_protected is
      not needed in the teardown function. After reading over
      rcupdate.h, I think a simpler alternative would be to use
      rcu_access_pointer, after a grace period to ensure there can be no
      more readers. Based on this comment in rcupdate.h:</p>
    <pre> * It is also permissible to use rcu_access_pointer() when read-side
 * access to the pointer was removed at least one grace period ago, as is
 * the case in the context of the RCU callback that is freeing up the data,
 * or after a synchronize_rcu() returns.  This can be useful when tearing
 * down multi-linked structures after a grace period has elapsed.  However,
 * rcu_dereference_protected() is normally preferred for this use case.
</pre>
    <p>The last sentence sounds like rcu_dereference_protected should
      also be OK, though. Either way, it sounds like I need to add a
      synchronize_rcu call in any case, before freeing the fence. Do you
      agree with this proposal?</p>
    <p>Regards,<br>
      &nbsp; Felix<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:7b67d4f1-cfcd-47a9-a80e-f4c1eee235a1@amd.com">
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Regards,
        <br>
        Christian.
        <br>
        <br>
        <blockquote type="cite">
          <br>
          Thanks,
          <br>
          &nbsp; Felix
          <br>
          <br>
          <br>
          <br>
          <blockquote type="cite">---
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 +-
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
            <br>
            &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 +-
            <br>
            &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 6
            ++++--
            <br>
            &nbsp; 4 files changed, 8 insertions(+), 6 deletions(-)
            <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
            <br>
            index f2e920734c98..20cb266dcedd 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
            <br>
            @@ -314,7 +314,7 @@ void
            amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem
            *mem);
            <br>
            &nbsp; int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device
            *adev, struct amdgpu_bo *bo);
            <br>
            &nbsp; &nbsp; int amdgpu_amdkfd_gpuvm_restore_process_bos(void
            *process_info,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **ef);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence __rcu **ef);
            <br>
            &nbsp; int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct
            amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_vm_fault_info *info);
            <br>
            &nbsp; int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct
            amdgpu_device *adev, int fd,
            <br>
            diff --git
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
            <br>
            index 7d91f99acb59..8ba6f6c8363d 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
            <br>
            @@ -2806,7 +2806,7 @@ static void
            amdgpu_amdkfd_restore_userptr_worker(struct work_struct
            *work)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; put_task_struct(usertask);
            <br>
            &nbsp; }
            <br>
            &nbsp; -static void replace_eviction_fence(struct dma_fence **ef,
            <br>
            +static void replace_eviction_fence(struct dma_fence __rcu
            **ef,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *new_ef)
            <br>
            &nbsp; {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *old_ef = rcu_replace_pointer(*ef,
            new_ef, true
            <br>
            @@ -2841,7 +2841,7 @@ static void
            replace_eviction_fence(struct dma_fence **ef,
            <br>
            &nbsp;&nbsp; * 7.&nbsp; Add fence to all PD and PT BOs.
            <br>
            &nbsp;&nbsp; * 8.&nbsp; Unreserve all BOs
            <br>
            &nbsp;&nbsp; */
            <br>
            -int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info,
            struct dma_fence **ef)
            <br>
            +int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info,
            struct dma_fence __rcu **ef)
            <br>
            &nbsp; {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdkfd_process_info *process_info = info;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *peer_vm;
            <br>
            diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
            b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
            <br>
            index 45366b4ca976..5a24097a9f28 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
            <br>
            +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
            <br>
            @@ -917,7 +917,7 @@ struct kfd_process {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * fence will be triggered during eviction and new one
            will be created
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * during restore
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
            <br>
            -&nbsp;&nbsp;&nbsp; struct dma_fence *ef;
            <br>
            +&nbsp;&nbsp;&nbsp; struct dma_fence __rcu *ef;
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Work items for evicting and restoring BOs */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct delayed_work eviction_work;
            <br>
            diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
            b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
            <br>
            index 71df51fcc1b0..14b11d61f8dd 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
            <br>
            @@ -1110,6 +1110,8 @@ static void
            kfd_process_wq_release(struct work_struct *work)
            <br>
            &nbsp; {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *p = container_of(work, struct
            kfd_process,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_work);
            <br>
            +&nbsp;&nbsp;&nbsp; struct dma_fence *ef =
            rcu_dereference_protected(p-&gt;ef,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kref_read(&amp;p-&gt;ref) == 0);
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_process_dequeue_from_all_devices(p);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pqm_uninit(&amp;p-&gt;pqm);
            <br>
            @@ -1118,7 +1120,7 @@ static void
            kfd_process_wq_release(struct work_struct *work)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * destroyed. This allows any BOs to be freed without
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * triggering pointless evictions or waiting for
            fences.
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
            <br>
            -&nbsp;&nbsp;&nbsp; dma_fence_signal(p-&gt;ef);
            <br>
            +&nbsp;&nbsp;&nbsp; dma_fence_signal(ef);
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_process_remove_sysfs(p);
            <br>
            &nbsp; @@ -1127,7 +1129,7 @@ static void
            kfd_process_wq_release(struct work_struct *work)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_list_fini(p);
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_process_destroy_pdds(p);
            <br>
            -&nbsp;&nbsp;&nbsp; dma_fence_put(p-&gt;ef);
            <br>
            +&nbsp;&nbsp;&nbsp; dma_fence_put(ef);
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_event_free_process(p);
            <br>
          </blockquote>
        </blockquote>
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------kyKS40pYdhyQbwE7EUIGXQx2--
