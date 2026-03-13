Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36C7106FD9A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 08:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C6EC10EB39;
	Fri, 13 Mar 2026 08:45:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qvyLMM5d";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B12D610EB40
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 08:45:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpDdQx23R67Swl33u6fluqPhA6bDKeYxxtS5MoSrsoYRZgz9JWxNUI5o2CbniYKOiPk51qmaFjJNWVyaKlCMQsRg/1RHh7SZI8YgWzz5b+Ui94L6/mvYs/wj+I5E8Z/54TccvoCeE8ga5ivUXZrLX5VPOCD31wnX0mQnXycWUhHkw0qx0e9/rfU/w1AKx34NdDR/CQZ5keK/EI5J9SsJMcx4Kx8WyE4kCKlNY7b7pwNHYVLbTCWM8kdzgZWGrzDWXp7FmJSHwTxJkO11F7SlZRw/p67DoYfoFSSrIDRAGL/T8L2ZFbv9yqMbWQLNiW9ISi0HMaLOneFj3teJ33hTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vizVXqjlPuys1mTn4Wy5dTyh/by4DhAQLcF695knmyA=;
 b=FNDc32/gO0qvYc534wSIqbQIXkSCz4NvSlQQn1+jq2V8n1RFRszyaccrfaIfTBD3RK/Hl63XNQF0eGRQgoSdlXwtEfKRhkCu3szc3IP7MgjsAXTBTYBo3CR7UhJZOfIc06Z9D1Bz3bbabdnMajMs8EQkdyFTt64KThTYEYzhb+sonSlclCLqOnchFmV5TRuF2jpfgDyWbCn/rOi82NASV96pcqOncNfD/Ebh73lG80jgjCq830tNAFZm+xG6H+rQoy0GVUp/hnsTTF3j9kiZsHBq65b9Szs81aqH9LcwCEZ21RrS3LsFD8YxJVKYXg23ULGYz1kQVVL/mOcJZVe2oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vizVXqjlPuys1mTn4Wy5dTyh/by4DhAQLcF695knmyA=;
 b=qvyLMM5dUQmMiQhsIYlkDP0V5dEymu3qmVaz+7Prf7Ocv5wRSNNlst5iopCesaRMcwhBLJ4bNhNWzwckls8BL+6UlC9ZpDPzHHSf3sB3qE5OXw8r32OFFySDojDURYR5RbM6SUfVamu7ejOUS0GSXY37HYPySu/+NHxNSb8faxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by IA0PR12MB8085.namprd12.prod.outlook.com (2603:10b6:208:400::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 08:45:36 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9700.009; Fri, 13 Mar 2026
 08:45:36 +0000
Message-ID: <563d4978-6e84-4059-80bf-5b5d6d5699e5@amd.com>
Date: Fri, 13 Mar 2026 14:15:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu/userq: Only look up for gem objects
 when count is non zero
To: Tvrtko Ursulin <tursulin@ursulin.net>, Sunil Khatri
 <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260310135531.3954691-1-sunil.khatri@amd.com>
 <3d80b2b5-4d1d-4435-8418-f59e2b905ed7@ursulin.net>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <3d80b2b5-4d1d-4435-8418-f59e2b905ed7@ursulin.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0106.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::6) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|IA0PR12MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: c2216350-7f05-4e72-9d68-08de80dce52b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: NFFeHYLw5WacfE4sDJzlIEY1TUca+tQ/HrDLcmdHifNSvyn1OjNDJm46ygc5Y+SUJ9Ka3YFb/L0yqYV1PcvaAuppSHN3zpiy9zrSIgUtC0m8Er//KEXTL3li59cKL5ALcKaLPThTJjLuLSFlEYLQSnzEqAbbUsXh8aYEzQjfJiY/yzv3sqHbO48xq4RtjUytxWuVTkXtvs+zwBlqcRKg9OnzvUbmeE1z22twOrRSEVg517aha67vx+lBEM0lZwp8MHGKSEveE6aNaYBKOIBlfEi3c/8apNYuZG0Z4fVou0Vvz+YpW0XYpw6paILB3+eMSvu3wlvzPWE7Fh0YvdVA0nKWRPU2daWKyoI9cJRPDgFKn7MXbj6rGhNlsPE5jIlFULCxfwjcIE0vTk57eiWdwSxEZD/h0rZiPEP/l37gkenAIij1Vu3j1aQ6KHdc+Kcg2GH89nL8zMXQyV7z+c2mZ0YaEvjAdz7tkTTMcjrM1i5g6MmUjDayo84lCFvbuieQIgiDwnfoAu9q/w+wOX0bpy5cHOnx8j5m4JS0cz6bcBGyJogXREOxNvmoM1oIMi4UuW9F0TLEnbi5aOtOLCEOnDwrC0rZ+hDl/Rnpo2MVU7oiUWS7lWVIHxTGGypUsgUY1qm2xaOzU4SUYepJ26Yp7j1HaQoijV/r3ii5YZ67U5MkaeOdef4mAZ58rdv8v9OYpPe3SyIRCWR0BfWzr2qXo1p4YmgmrsII7N220umQKRI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkUzenhFdndVVUlPRSttVGJzYXMvc01WdEZkQkp2d3R5S0FLNW10NUVLd1Rv?=
 =?utf-8?B?TVNMUjE5dDRvaktKN3MxOTQwb2FDbExPb2grbzRZY01nODBEbEEvaHgzN1RU?=
 =?utf-8?B?QjJReERhWHNRQTZ0Z3I2UlZQcTVTdHRqS21QbnNza1lUb0NXa1hyTDNLaVl2?=
 =?utf-8?B?WE9OQS9CQ1JKd1hhWHVaUU1OejhZaFJDbmlyWUlpeWh1QjJDM0xVMFVYN3hB?=
 =?utf-8?B?a1ZkNU5PaXRuYmxtYUM3NFdCcldFQWdYOUZJaTlqR0dYZlJpSmpjcXhuVENy?=
 =?utf-8?B?aUVkMndYcjNHUkJMMmJweEoyQytBNmdSNWl3QWh3Y2E3TlBKa1dvMG1tc1JB?=
 =?utf-8?B?WXFicmJBVk8wWnFSemNBNWZGOEdVd2twOUFyOTlCUDJ3Wmg5V1IrTWdXeVJp?=
 =?utf-8?B?NDk4Lzl1UzFMcTB6WVNZamxzSkkxeUl6M0NPZy9zcERlYm4xWDFCYVBCMGVY?=
 =?utf-8?B?QnA4T0ZxdnI2Z1Zsc1NzUVhETmdqeVUwSjYvVDQ3aStrYmpqcXR5TXlYYjVL?=
 =?utf-8?B?ZmkxQ0VqWkNTbFFvY1lzRVlndk4wRkZLSEdCc1p5VVdheS8xdWREaFFycUJL?=
 =?utf-8?B?WXhrQzNESHBtNFlZTzFCUHA5VkN2aUFSQnpkSlQ4TXgwVjhPdUN2QUROZ05B?=
 =?utf-8?B?eURGem5FVWtTUkwveUErcFpsaGZJUWtUM25JZ3JRZXQwL1dKaGZCRGYvWHpM?=
 =?utf-8?B?R3JDZDc3M2xkM1pjR0RqOWZoUTh0aS81SjIwY0pjTVkyY0lnc3hMb2hqMWJM?=
 =?utf-8?B?STE4Z1pXTGhObWU5WVB2bU1sMStFTUZsNC9iYzdaQTh4QXROaGlJdzRGSDJX?=
 =?utf-8?B?UFZVeElWaUxtRnFMWGtscnlIcUlPck9IVEIrc29KanNyVUVEMDI1dk05OW5s?=
 =?utf-8?B?aGFNWkx6KzFsSWtKamVOcVRTVkdLV0FwNzBNandNWnVZMGo1RVpiSE5sOWdO?=
 =?utf-8?B?WWd6d09EbDZqckhKY0RGZlc4VEc2aC9wb2pqamsrN09HSml5SmE5TTliKzBn?=
 =?utf-8?B?THJVT1Azb2NISWtQU0FydENwRXhpUVAwMjdwbjV3TXBzMDZrUUIzaXdqeCt1?=
 =?utf-8?B?VmNGOTdvUURpTUcxbUVUU3VBVlRnL1RRVGhDQ0JtRWZNNXpwSEoxQzlMWUNL?=
 =?utf-8?B?S2VmbjZyQ1hLSHQ1Q0xzcmdIYmw3OGp6OTdRVnhFUElPU0M1QTBjVExyNmRW?=
 =?utf-8?B?bG9iTDJBK2hnUStjc3NsVHhmdHE2cGNSQXhOVGdMTlY5YkVFNEFBWFplc04z?=
 =?utf-8?B?TngvbHE1ei9Na1BvaHpZNHB3VzNPQldMSkVSQ3RORjBvYUJNdzFNUjYzTENv?=
 =?utf-8?B?MWtEa0l2NjF6MjM4THpNS0d4RWI4N09NbGJRbUoyaVhHR0V2QjFRcXhsUWFq?=
 =?utf-8?B?enlibkdoMU9Md3VMd25qcW5xS3hYSUR4aHU0U0F1Q2ZqZTc0TVQrdnVOeUVs?=
 =?utf-8?B?aDlxVDZLUzI0RnRQbVdWYm1na0YyOGRwaUYranBhalg1cW1WdmNucU9OWnRr?=
 =?utf-8?B?UkVyQ2xENHlPRTJaU2d2c0Z2Ny9NbzFEMjVYYkpMTlZHMW5HMVJzSU9DeGU0?=
 =?utf-8?B?RktOUkNRK2IzUUhwNWN5ZG4xSmdpYmZEQzFTZW91WVJGb3ZsNmdmbGt0N1ZR?=
 =?utf-8?B?Y2JMcTJXc2NDeUJ3SEp0YXY5K2dDYy90b0lMQ1VNTHp1dzB4WjNmSER2ck83?=
 =?utf-8?B?bEY0blhqcnhLUDAyd2Z6S2lPRHlRdndJYWFzN2hMRzgvRVpMcTU2MWM0YnFX?=
 =?utf-8?B?bVRsQldPVCt4NHZORTZlSDJSZG1OQUlwdXE0b2JOSW8weitBLytWVVlTMHZl?=
 =?utf-8?B?cFdmL2RlNEZFNlA4SCtjNHdIOWNvd1I1eEFCYzk3QkNqanRFd0szVHM2QTA1?=
 =?utf-8?B?azBaa0ZVdFY3WlFWRlJTQ3VUcG80U1lycGE4QkZFV0wyV1BVU3k5ZTBBSHBC?=
 =?utf-8?B?Zk91dDllVHNKWkk2NzRoREYxMUxyWUhUbVRmZFdwTExGV1grL2pZZ3pPT3ZM?=
 =?utf-8?B?b1duTVY0UHZNR3pzbmpQTWN0WGtMYVRvanE2R0YzYjkrcVJvRG1BZWZxb3Vh?=
 =?utf-8?B?dGMwVjZ0V1ZNVE1Ua2lhSHkrdTVPc3VPYlAxM2c4MDBjOS9tZXdnUFc3dnVP?=
 =?utf-8?B?aDY4TW1WL2o4QXdmN3I1c2UvdlNvc01TNmU0UVlVaWEwcEszelZkSkozRkJa?=
 =?utf-8?B?SWdjZmYyTk1hRW1ld0FaRXozUXlKTmUza1BDWm9mcVJhemdXeTB2clNOc29U?=
 =?utf-8?B?TUxUYTFtb000U0hnYmpmbWFteEhPWjFMZURCMFdrUCt5cC85MjdPaGNqZTlF?=
 =?utf-8?B?OVlKUjgxcTAwbkxQTGgraVphemNMSjJraWY0aUpZV3Rpa0R3cFhsUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2216350-7f05-4e72-9d68-08de80dce52b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 08:45:36.0329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omuHZBKRcfI3zoVnQDDziDc40BaPuJcbDEgpeROlZm3gxzALLJVlp4QON4/kLVL/zicGXC+JcPb8QKVEjXM1lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8085
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


On 13-03-2026 02:09 pm, Tvrtko Ursulin wrote:
>
> On 10/03/2026 13:55, Sunil Khatri wrote:
>> In function amdgpu_userq_wait_ioctl, call function 
>> drm_gem_objects_lookup
>> only if the count is valid i.e non zero.
>>
>> In case of object count is 0 set the pointer to NULL for proper clean
>> up.
>
> Hasn't this been discussed already with the conclusion that nothing is 
> broken? Or I am missing something?
> Regards,
>
> Tvrtko
Issue was seen again since Alex pulled 6.19 fixes from DRM and the 
drm_gem_objects_lookup again got reverted to old and we started to see 
the issue. With that in mind Alex too suggested that nothing wrong if we 
explicitly check in driver too. Also i thought its only when handles are 
Zero case when the problem is actually seen and why not that have a 
check targeting that and not to invoke the function 
drm_gem_objects_lookup itself for that specific case.

Regards
Sunil Khatri
>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 32 ++++++++++++-------
>>   1 file changed, 20 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index 76f32fd768fb..a4fff90b190a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -665,19 +665,27 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>> *dev, void *data,
>>           goto free_timeline_handles;
>>       }
>>   -    r = drm_gem_objects_lookup(filp,
>> - u64_to_user_ptr(wait_info->bo_read_handles),
>> -                   num_read_bo_handles,
>> -                   &gobj_read);
>> -    if (r)
>> -        goto free_timeline_points;
>> +    if (num_read_bo_handles) {
>> +        r = drm_gem_objects_lookup(filp,
>> + u64_to_user_ptr(wait_info->bo_read_handles),
>> +                       num_read_bo_handles,
>> +                       &gobj_read);
>> +        if (r)
>> +            goto free_timeline_points;
>> +    } else {
>> +        gobj_read = NULL;
>> +    }
>>   -    r = drm_gem_objects_lookup(filp,
>> - u64_to_user_ptr(wait_info->bo_write_handles),
>> -                   num_write_bo_handles,
>> -                   &gobj_write);
>> -    if (r)
>> -        goto put_gobj_read;
>> +    if (num_write_bo_handles) {
>> +        r = drm_gem_objects_lookup(filp,
>> + u64_to_user_ptr(wait_info->bo_write_handles),
>> +                       num_write_bo_handles,
>> +                       &gobj_write);
>> +        if (r)
>> +            goto put_gobj_read;
>> +    } else {
>> +        gobj_write = NULL;
>> +    }
>>         drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
>>                 (num_read_bo_handles + num_write_bo_handles));
>
