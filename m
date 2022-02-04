Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CF5C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 18:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C90210E773;
	Fri,  4 Feb 2022 18:47:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E143C10E773
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 18:47:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MynI3nzJXTCqUE1jp1drgs7DY+thqAiHc2inIHXds5kH96Xab8lzShYyV+CO2rvi9HqQA33LrXN0Y6tWBZcb9L1cjPQdz1AWe9CUD4JdYb32c5QvaIYBDjtg0wPD365EfUpimDCe49c+AR+sgwcl8dRLsivN2qVFBVU72DkgY0Nobzk4JHOREWuCsWsM+2FZ2Nw7nlCgHFb8JUMgS8shLdR8LZoN5JF6Np4VUOoFJji9M7T0XJMeMUpj3yBERmPAjUUAPVtm8UVOymXdftAekvzPNTVwqXnjxITd8ePcgdX2/AqRVuPotdGIPWjYJsKOOFI7oJNNSfQUllVl0XcpkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9mXhpXNltkK65wMVnv5blhqe5uy2urVIC0WQGiG+5Y=;
 b=a8mg0VYTH/FAKuN9pwW2YNT1+TXDEj1BAwBOCEDxKFJ6AyXUmjcaWs5VVQQDK5OrX0nrNs59QPPrZo+caCX6xdR7vWZwOorzqwNXdYeknw2+0vpVvB6RznNEl9Ce+cioRWxW97Fnav8i8zKoMdvyvFWoD/zue/yf7jWNE4uYQSZvCH/tJFrba4uURiNtdB3G6Xcg0sztGqlUic3xGCz7TLYSIDURuaHt6P3cU83DPhGHhFc/HRMCNyVNhhsnRm0FyyE+rIhkUKoyjNc8oyf+7einJ0LmfgYUdnw5sdx0ff5txHYhtIubeX/hEfNlJbxDLUHJlWtNDbl2I409hymbUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9mXhpXNltkK65wMVnv5blhqe5uy2urVIC0WQGiG+5Y=;
 b=w1LsXPN6s3KeYPyblhDGhEEFN9U/8Y3bdc2NQvViQJxVH+Z8s7x7p3iyCnJOgFog/2l7Ofu3L5QMpf8j5LpatsFNO9DEZMSqqeV7Tyw4JBoKRpY76ssmua8BrnWETxXpt2kb5Hs78FTgm6blCTtZUeYYs5NN+iNcEPEuclKExr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1531.namprd12.prod.outlook.com (2603:10b6:4:f::8) by
 DM6PR12MB2874.namprd12.prod.outlook.com (2603:10b6:5:15e::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Fri, 4 Feb 2022 18:47:22 +0000
Received: from DM5PR12MB1531.namprd12.prod.outlook.com
 ([fe80::d01b:f78:ca43:12cb]) by DM5PR12MB1531.namprd12.prod.outlook.com
 ([fe80::d01b:f78:ca43:12cb%11]) with mapi id 15.20.4930.023; Fri, 4 Feb 2022
 18:47:22 +0000
Message-ID: <df73c8a3-0c85-0402-01e4-38e6bec5af17@amd.com>
Date: Fri, 4 Feb 2022 13:47:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amdgpu: move lockdep assert to the right place.
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20220204085201.30615-1-christian.koenig@amd.com>
 <32b9cdf2-3d71-4228-3471-38584575f41b@amd.com>
 <668b5be7-de6c-4c47-9756-6452f316cd7e@amd.com>
 <108a3c26-df8c-c7ea-2228-25ec69afe50a@gmail.com>
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
In-Reply-To: <108a3c26-df8c-c7ea-2228-25ec69afe50a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:208:239::30) To DM5PR12MB1531.namprd12.prod.outlook.com
 (2603:10b6:4:f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01ddfd3a-9ad0-4400-6dcf-08d9e80ec758
X-MS-TrafficTypeDiagnostic: DM6PR12MB2874:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB287496FD3543A389485B0AC4FE299@DM6PR12MB2874.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UN8FjzWe+rF6XeEY0X9zFPOU2xm8q8wtNqLWrgViyYA2wJGzhkWxpXTRmI7CQc0+OgzHZw7zq4C3yIKaVCCIkklOka2OM9RnLQ5WOSKXCSqpao1o/2MaJKVmVTEd0/+WL2zV/jzT0Vr/42okzsH5ZBqHI+Usmge6nm58EPuXYHvhDvNR0XxOTPhtIP8LL2f4YeMnTYZO/od9qhfS/YqZ8UKAXn1e2aWk+109trlguXxFW+faPW3OArTKtDI9bf/qS8SCg7XGP+gBVNW/46AWwXSIfk8p9PQ252ZrSXfetwg1nQN7tWrtGFVKH6eVE00ksgZqVB/835Q+VyxlA2J69m/ZI6JIj1PhQjF4FD6BILR2slvV6H4RYZzhJbOjmHvZJbq2fvM5M0JubCrRv7OGKc3f++iV+22EpGsNEiikAmBQqEBJEx+zUbum0q63X4RDb6spOjWAb5wqGFzRE4YglCmdA2SPDkU7hMLqfdOmmxsSRjqjiIH1XgusyyVBckXc5zJxyaJyuGGSUg6dvC/douoQJxGvQxom1xcrr+SuTK5nwlILqVK/acO63ccVBGStaZ4cQtLEELwaCtraw4yl+63gWSQOH4WHzWayKz0uxUT/XTnPac1hb0l64fdvncSvx4lBbDehSEFFA1bhUI922Wp/wSrCdPCmX8dsSO/UaPBsZVRUzpkLpmvdfRpWl8z1G1ZOTVoynnGWFym1EsMOKn4XY2S6W80q+/Rf65lpRX4ymZURqbNLLRA7MUjuw5us
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1531.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(66946007)(66476007)(66574015)(8676002)(36756003)(6666004)(6506007)(5660300002)(6512007)(31686004)(110136005)(8936002)(53546011)(66556008)(6636002)(26005)(186003)(6486002)(2906002)(2616005)(86362001)(316002)(38100700002)(508600001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ai9UTGNCVER1SWVxOGVBbDYvdnlGRVUxN1AraGlqb2lzaUdkZlFkZGU4TEJJ?=
 =?utf-8?B?N09ycUYveFhFU1EzUGk0bUN0QXVRYTRZSE4vbFRiVU1oRWwwNTB0a2g3M2Zl?=
 =?utf-8?B?L1UvNG84aTFTTW5qM1FCNGZXRk5PcmVtWTJVZ25vUWVoWWdZbzRsL1FwNGVx?=
 =?utf-8?B?amN2QTBDNEMveGlORnVrNzdrZ3NlcEV2LzBlSlhJWDlwM1pRbzB6bmFGVTg5?=
 =?utf-8?B?STc1SFNhOVh1MVhXekNYY3QyOTdkNkJEUzRENWw4eDJLTi8xNzZzeEJrZDhS?=
 =?utf-8?B?WStUaW1aZWhWbmRFb0RZZVNDbW5nNjc4Rmw1SmtPMFdCc21TbTVCaXhid21W?=
 =?utf-8?B?Vi9FVXpETUQxVWpCZEltSTFJL2psS1RnQmt2UEt4d2haVEk1TXlsaEFSVjZv?=
 =?utf-8?B?ek9oUnJ2SXlQaGh1UFN6Y3ZQVDB5amZwNUgzdEFmZ1dBcm5WTGRMUlVmWVRC?=
 =?utf-8?B?YTAydkpHbmJNQjVQekV1SzB1YTZFTURFc3V6NitMVWNrZ0VVdU9RT3RvQSth?=
 =?utf-8?B?WEFpT0lSdmM5UlVMS1V0cEJHSGFKWnhralYyUytSMjk0WVloaDlZa1IxeENC?=
 =?utf-8?B?ZXFIajB4WmtIRSs0UDlOSENDWUJ1RmZTcVlMK21BcmdDUVpDazJRK0FhVGtQ?=
 =?utf-8?B?WXlzN3AxQ1dBdEY2VjF2eWpKOVREN1FlQ0Jwa1lwZkVBMzJNL3FXRm42SzNO?=
 =?utf-8?B?aXg1USs4R3YrTTVPN2dZajFZZjJyMGFja2VLWUhDZGtJSjZGbW1OejJPSWFy?=
 =?utf-8?B?VitNaExzaWNRczNzRlNVV1ROUDZJREJZQjltMUNVMnFMWEpmL0lZbnBDQ1RF?=
 =?utf-8?B?c1hRZlp4TFQ0NEtIZzdIUWRvV3F3RGNPbUQwRzVUNTJNc1ZpUUpnbW1hbXVN?=
 =?utf-8?B?UzN5ZldNRDQ1SFNhNEV0MVhZOGRLWkN3QmRKOWhJelQ5cjhDZVdMTEhmcTd6?=
 =?utf-8?B?OXFJRWdBNWl1R0VLY0E0YVdHQTgycVRCTms0clVjM3dtVDc3clRpRFY1anRB?=
 =?utf-8?B?UC80UlZzaCtsWnZFRGJVa2xjN1RLZ1VIYkdnNDEvQUFHaUtUcS9hR2drZjhT?=
 =?utf-8?B?YUhkTjZ4Z2Q0UnRkZkdTZy94ZDVQRnFBc0YyczkxQS9HWjliV3ZRbW9IcXVV?=
 =?utf-8?B?MDN0dlREdVdwUkFvRm1oemlIakQrelk3MUZxKzZCc3c1aVFoTGpEVWZVWi9M?=
 =?utf-8?B?djh4cWhYTGszTWVRSU52NjRCT0c2UWE2SFh0cjUrcUF2bXZXSU9GeVhBREp5?=
 =?utf-8?B?YWw4c1JYZmw3dGtaN3E1cWlQcFZDTGdhYlJyNU94Zk04c3lDZHFQSVZpK002?=
 =?utf-8?B?alFjbk5KZXZFZ1lHektJVmFlc0diNC94b1BQWkZvYUtrUzVPTnJHQXB4V29s?=
 =?utf-8?B?b09FV0drOEJsZUlmRlBMNkh3aDUvd0lpWVV0TmxTWEx5Tk02SEV4bnlwYnRi?=
 =?utf-8?B?TXZ4bXF4NkgvN2ZQV2E3UU1OQmZVU3A5b1o3WFBIOGtuNStmU2pzNmNJR2x4?=
 =?utf-8?B?Z2Z5QzZwRVpFUHJWVkdhb2xES0w4U1NNUkhOcFJwSW1hcDBoQXRKMDRWNC9n?=
 =?utf-8?B?dWpMbzE4OWxKTlNSSDI3cU1nVStMNEhqRTFCejNpeTFacHpWZ0U5K0thQlpH?=
 =?utf-8?B?dFQxMzZvbURpNXg3US8yMnBnNitJSWlCY1hqV1REU1FiblJQMXY0TGFUSVA0?=
 =?utf-8?B?TDZYdW9SK3FhOWY3UERNMzVLemZOTmNRQlNEMTh6VHBrcXZyRXBaTTA5Uk13?=
 =?utf-8?B?VzhkSW82cDV4N3hiVmppeDR3b1lFSmFaK21MU0VFRXRCL1lCUmRTbXdDdHJZ?=
 =?utf-8?B?Z2I2a2o1Q3pWT25GMldBMjBoVWd2a0V3RjZDNlRSTEYrQ1hET2FxcFo0SVJP?=
 =?utf-8?B?SXBpckt6Q2hFM0g1Qm56MnUxd1FISVMxZi9VUTgrS0tCcENOMUYzVVE3QVRl?=
 =?utf-8?B?NDdFZk94bFRkTTVERTFKYVF5cXJUdGdZZ1ZpTnl0M1UzNFQ0MFd4bngvQ3B2?=
 =?utf-8?B?Qk5IbFd6YkFUTUVvL0hCWjl2aGtPK2QrMVpxY3FXVnFSNFgwZmJlUzVZV3l5?=
 =?utf-8?B?QllwR29rcEUzaXRweXRaL2ZMejE3Q25LeithWVpCdUlaajJXUklMREl0VStW?=
 =?utf-8?B?dGlMaUFvQStteFh1cWt2ZklGNi9USjZTMEtrellDOEoyMHR2QkRucUpZNFY4?=
 =?utf-8?Q?+1gxJ4DIL+Or0zKL0YZk2A0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ddfd3a-9ad0-4400-6dcf-08d9e80ec758
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1531.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 18:47:22.2689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5hG4RQiwZmf3FuS2jW7jfgfGzbbfxsVUw47AaRzyG9UYN3ls7qz1Kn8WeZ4iF9G6BZBbWiTjLZFMW0deywoT+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2874
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


On 2/4/2022 1:32 PM, Christian König wrote:
> Am 04.02.22 um 19:12 schrieb Bhardwaj, Rajneesh:
>> [Sorry for top posting]
>>
>> Hi Christian
>>
>> I think you forgot the below hunk, without which the issue is not 
>> fixed completely on a multi GPU system.
>
> No, that is perfectly intentional. While removing a bo_va structure it 
> can happen that there are still mappings attached to it (for example 
> because the application crashed).


OK. but for me, at boot time, I see flood of warning messages coming 
from  amdgpu_vm_bo_del so the previous patch doesn't help.


>
> Because of this locking the VM before the remove is mandatory. Only 
> while adding a bo_va structure we can avoid that.
>
> Regards,
> Christian.
>
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index dcc80d6e099e..6f68fc9da56a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2670,8 +2670,6 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>>         struct amdgpu_vm *vm = bo_va->base.vm;
>>         struct amdgpu_vm_bo_base **base;
>>
>> -       dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>> -
>>         if (bo) {
>>                 dma_resv_assert_held(bo->tbo.base.resv);
>>                 if (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)
>>
>>
>> If you chose to include the above hunk, please feel free to add
>>
>> Reviewed-and-tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>>
>> On 2/4/2022 11:27 AM, Felix Kuehling wrote:
>>>
>>> Am 2022-02-04 um 03:52 schrieb Christian König:
>>>> Since newly added BOs don't have any mappings it's ok to add them
>>>> without holding the VM lock. Only when we add per VM BOs the lock is
>>>> mandatory.
>>>>
>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>> Reported-by: Bhardwaj, Rajneesh <Rajneesh.Bhardwaj@amd.com>
>>>
>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>
>>>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> index fdc6a1fd74af..dcc80d6e099e 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> @@ -375,6 +375,8 @@ static void amdgpu_vm_bo_base_init(struct 
>>>> amdgpu_vm_bo_base *base,
>>>>       if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
>>>>           return;
>>>>   + dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>>> +
>>>>       vm->bulk_moveable = false;
>>>>       if (bo->tbo.type == ttm_bo_type_kernel && bo->parent)
>>>>           amdgpu_vm_bo_relocated(base);
>>>> @@ -2260,8 +2262,6 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct 
>>>> amdgpu_device *adev,
>>>>   {
>>>>       struct amdgpu_bo_va *bo_va;
>>>>   - dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>>> -
>>>>       bo_va = kzalloc(sizeof(struct amdgpu_bo_va), GFP_KERNEL);
>>>>       if (bo_va == NULL) {
>>>>           return NULL;
>
