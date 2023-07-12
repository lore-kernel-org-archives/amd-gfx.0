Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31EEC001DC
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 16:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 332F410E58A;
	Wed, 12 Jul 2023 16:01:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA7A310E58A
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 16:01:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/vn7sXu2nvB0qS4U7xm/EdNLPve6PodaUmK3Bxt8EF2ca0LxvOzXg4AjfLexaslMeLIRiDH44DRDFvXXRvmNHCh7ubDHnjTRfJZeKI2mx1slS7KVxZ1/33kmjUjUrDenTj8SVLS1ReP44wxmHMucAhCw6JQRXKXGN8VRLmINUAi2nUZU28lX2DVRGcrQ6BVsjnvaj3OLXmwWDcNuiDiDi3zERK4Y2j/WSdA6WczwCZMCIRLXgZ6Ov35wXowKdlz7T1CNXoJuduZ5Dcfv6ivKv7+2R1gfTC3upPUKXDWqJzp65b+0R4VadII5eQOWhFmFEQwhURGqwTI4EK9yDE7tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1+kxWY5Uf47qyWdBVn9QX4XKXL3AkOQgmCqpH3lK1w=;
 b=KLNYR+T5sncYywJF5AG8qSPcGgAkBKtjOdf97Mq3rF7Ulja/rw9uVZdu+ySfjhF7F6Ml2ALHkZP1+xNWd5WdFT/VgUllxa7RYyhAekRF7FkBvvtrjdxA35cYZhq6iDPJA82J4SkD8YGpo8oPAiid1W04mh2mPGCBy3Y0lM+LGacIoP+KhUS0aS6I6OAZ3BuHGxiHPdvjgtzFMgQA5KaTmIATmSThrPvXDSWyoBiTG5/76mjKS4ELtWGZ/RvwEt4jVEGDR2/UE1HxUYWcevF053RidmWwkbQYyQrwJS16ixdny6RXEY0BO2rbVsb3H7d0gFBNu18iUMu6e+H7Ilb0wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1+kxWY5Uf47qyWdBVn9QX4XKXL3AkOQgmCqpH3lK1w=;
 b=0tatUqIlMdA3wfu3UkqqhsUy144T5RX/EQmUpoq0ynZ1Y+pQeoWyrLuthXvSkPxuBniKkktYA/81l2OzmkeeJCxwaCv+YsnJhM4qDTF+vq7mSnwAevNb0MUxTOA+qjB52NPNiUOtLc6WClSAER0q+/2UJcv0gqjh84zom9gOBC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB9073.namprd12.prod.outlook.com (2603:10b6:510:2eb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 16:01:30 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%7]) with mapi id 15.20.6588.022; Wed, 12 Jul 2023
 16:01:30 +0000
Message-ID: <de08d8c9-dd29-48a0-1316-f7a0bd9cb69d@amd.com>
Date: Wed, 12 Jul 2023 12:01:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 04/10] drm/amdgpu: create GFX-gen11 usermode queue
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-5-shashank.sharma@amd.com>
 <56fbaa22-285f-1030-1822-36d542de4ecd@amd.com>
 <c87cd5f9-b940-0bad-6cfe-c8640693b426@amd.com>
 <e669c8cd-9fc2-73c6-c8f0-140695f17156@amd.com>
 <435820e9-1680-3687-4930-bf7ea5967568@amd.com>
 <9cac0523-8596-c64b-93be-9d3425ca3c25@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <9cac0523-8596-c64b-93be-9d3425ca3c25@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::46) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB9073:EE_
X-MS-Office365-Filtering-Correlation-Id: be56ab86-bb95-4533-04a7-08db82f14168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cUhDdUsOaQPcL99MlLwqQrjIktlD2AaFSsaDQXDu0NDVclfUDueO2jrglYc4UQBeF8taoNzpOkccKbzuWpocaGFIAxw3Dz3167hY3SLCSzcTxaSM/o14N39Vz/e5I+GeKJGz13bZpMRqVqng5fT9SV0thzceQyJiTTly7WOtHrdvuNOSDGmccKoKLa+/6eA8wtLzqsvGJIdD69mgaMFRVDp/0v8jbziVPa0FpYuyNQJ0UHtwGBi0CfuM4LoeVb54ONvN3qkFbPjyAZuyal4iGmfGggGo+ibcHHU6zxTEsxS3YUR9tLWUW0ShIhz8FC63dT7BG8JRrEuy4AlK4JQBLPGKVPkDhMZSqNRimnjpAPxs4/7lsYsNTGLnz9X6oQuXU4jegGln/9PmWEKd70TBfkrCEvlrG8EyM2FFhsbX2tCHjl9ht5OrR1nBRaApCRFR8ynTUxe9776vONdsY14C8oiOBk7tOJJtT9pCfbdMbacDTO54UPAIxwT/PY5XnF9jKDqH9LNrap3vS5b6zD8HDAg49fxGJD+dp5nWj/XtKjtmM0QUSet7CjZ42D7W4motFvwLLLDtJk8VE28eRDz2t3RwtQm7mOUexOjurMx9fmIk4K9BZi041BMhz/GALeQagoXj/61EfDeIlTe2qr+Lfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199021)(66556008)(6512007)(26005)(66946007)(66476007)(53546011)(6506007)(316002)(110136005)(36756003)(478600001)(6666004)(4326008)(86362001)(31696002)(6486002)(31686004)(2906002)(8676002)(2616005)(83380400001)(66574015)(44832011)(5660300002)(8936002)(186003)(38100700002)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDBvbjdKWE1QQWVXclMyTDA5bC84OTQvRnk3aGFSQkcvU1IzT0dhcS9nQUJB?=
 =?utf-8?B?Z0s0NlI5NXJNQnpGb1lBQVhrWkV3TlJjSXRsK1RMcHgrY1l3eEE0bmdwd2RT?=
 =?utf-8?B?STBYSGdWb1ZMY0RKQ3lmRGpOWEs5bFpYMkVSOExMcjlqTHlxU2QzZjNPdDIr?=
 =?utf-8?B?a1JIMVZiUDZxN21JZExsUjlUQTZlMy9NNjdtQlpXRzVodUZwMVBxcFZYUWta?=
 =?utf-8?B?aC8wQUdiWStPZ2JrdWFTU2VscGpCbGJvSWVLcDJmWVEzQ1dYbE5ZUHBZZlAy?=
 =?utf-8?B?NFArTWVMVnVVM04xQ3dxM25lMWIya09QUlY5cTFhekRKakJieWRJTlBnbWpq?=
 =?utf-8?B?UWdncmU5K29FODk0ck9YbDlrbWdDSElGT1JrbGQyNHlDREI5N3dUM3ZuaDlT?=
 =?utf-8?B?eWxwbUJsbVlJVEpiVmVjaEJCeC8vQ3NkeTEwOGxkWUg5TnNzMXluREFWM2kz?=
 =?utf-8?B?Wk1weklWMWkzWVIwdGtCZW85alpXTyt1RVJ0Q0YvcXNKMFcrZStPcEx5Mm9a?=
 =?utf-8?B?elYwdXozN1FYQmcxZnF6eWhvb1MrWk96L1Y3NFNsZXZDUm1zN1M0ZU9Ea3FX?=
 =?utf-8?B?b014QlpuemswQWhOMWJ1VUtYdE9NZDA3MExOSWd5MGVKdjdNZWxxSi9VSUpZ?=
 =?utf-8?B?Vi9IT2MxQXJPREpxaUVrTkV3SitjSzRnYWswcHNuYlZUaUZMQzdQdmUzT0Rl?=
 =?utf-8?B?VEM2QzI0UEE0ZmlDSHZqWjhOa2pnaHFqMGdzQ0JVRWRyTDVSUjNubkJVTTZy?=
 =?utf-8?B?dmR4TmZwQnV3UG1FeUNKR2R3R2xWbGJsVFEzLzNYLzcvKzhFUTBhZWJzb0FN?=
 =?utf-8?B?bVBYZ2h5UWc2SVc1UmxhOGRwZmY1RjdpSkZLNlQxM3RFRW1Cb2ZhS3NxYzVk?=
 =?utf-8?B?VER3dFNVWjduNWhxYU9lZkdndGZqT3FMN2pZOGdGVGFIVjIxRkt2V0lBSmdw?=
 =?utf-8?B?QVlRdTQvZjM1UkdxVzBrOS9yNWZkMk1LZ0JiSFgwaE9xTkhZOE5TU21NOEZX?=
 =?utf-8?B?QU5zSEtNUjdaaHJkejk1eldJdEJuZDJtVkNTMzV2dHl4SHBSQ05hOXM1a0h3?=
 =?utf-8?B?aFkvVFNVR0JROHVnWFpKY3V1ZGtZbFNhZkdvS3Q0MkZuYWVzVkhqMzhJd05M?=
 =?utf-8?B?Zk9HNkNzVlZ4RmFRVkcvbElST255VCtkMGRqU3BHS1dpZ0MrMHVNWHBkMWd0?=
 =?utf-8?B?RnBqUzVYOWhLUDRrMGx1K0FOemQwS1BXbVhMRkZTRHZsbWJjb3ZEcjlvZWt2?=
 =?utf-8?B?akl3MFdZRnJrWmU2SFhFZmJsblRnSnJTVWZxMnBrSXk0UzdiZ2Z2c1FUb3Yx?=
 =?utf-8?B?akhJSHhPS3pHNCtYOVVBdXlWc01IRjB0M3ZoVU5VeUJnREl4TU05aXRTaWlN?=
 =?utf-8?B?RHdIQ2RBeGVGU3JlRmVQNFBrVTZ3aklRdWwzcE5nTnFNSkhPNm9XdzJMejNZ?=
 =?utf-8?B?M045N21jMjRNRjQ1OW9aYnR5VGIvbjdkTkNQNGVxR2xGM0F3Y3NKQWlBRkps?=
 =?utf-8?B?NG1GQngrZlNNUWhoaGFzaXMwNW9HUVFnWFJxYTBPbzR0bzBIMW1EU0NTVnI1?=
 =?utf-8?B?S25CenVNbVY3Qlp4bUlxSGRaQk5zR0FvQ0RWSmJaSUJ4TllhcndFRDVrMGtO?=
 =?utf-8?B?dVZkWXNrd0ZpT3hmcHk5aXhWbHA5eHFZQVVXNS9OemdLNHpLRW56SGhaczc3?=
 =?utf-8?B?ZW5QMmFHR2VlTSszNUpTVGtieE9FR0JQci9jTHlHTk91Q3RSOVFNcHJaUGZr?=
 =?utf-8?B?SEVha05ISVJKYmJtUlZleTJrMVFsOHg2UTl5VW96NWNmRUg2dytzN3hrUHM5?=
 =?utf-8?B?OTRzbUZqLy9PRStPSnc1RUlZaGg2czJJNlR2UlVqQUQyMnp0aEZBcTJLajB6?=
 =?utf-8?B?NWdOVStlUnp2Q3BpRStSbUgyMGdJaXNxNFhIQjVhQTFESkRXeWQxcldQb1lH?=
 =?utf-8?B?NlFJR2NjcEU5RVJlMmgxYXl3akZIRXdCRkozTGJHZVM4bWg5U3BHN290d1BP?=
 =?utf-8?B?L0t3YlluZVBFQlhmU1BQajFDamltdi82ZFVadWxIUEdNeWZLSUlFY3dUNmdC?=
 =?utf-8?B?SW4zRUZoYjVtUjhTakhIaTJuUDVkWndhZVF6R05pY2J2bVlUNmsyakhGZ2NM?=
 =?utf-8?Q?NACNRIqM9aaoKbgWRBL2ZUfzM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be56ab86-bb95-4533-04a7-08db82f14168
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:01:30.0531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jz8z2mCIkvfmSlnuKysxmAp+0zMp0HJVnv9YePuqqo6MJ58BLVpu/TI8eqn19LiThbgPYQjLJ/aGbQ2Mbu125g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9073
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2023-07-12 um 11:55 schrieb Shashank Sharma:
>
> On 11/07/2023 21:51, Felix Kuehling wrote:
>>
>> On 2023-07-06 09:39, Christian König wrote:
>>> Am 06.07.23 um 15:37 schrieb Shashank Sharma:
>>>>
>>>> On 06/07/2023 15:22, Christian König wrote:
>>>>> Am 06.07.23 um 14:35 schrieb Shashank Sharma:
>>>>>> A Memory queue descriptor (MQD) of a userqueue defines it in
>>>>>> the hw's context. As MQD format can vary between different
>>>>>> graphics IPs, we need gfx GEN specific handlers to create MQDs.
>>>>>>
>>>>>> This patch:
>>>>>> - Introduces MQD handler functions for the usermode queues.
>>>>>> - Adds new functions to create and destroy userqueue MQD for
>>>>>>    GFX-GEN-11 IP
>>>>>>
>>>>>> V1: Worked on review comments from Alex:
>>>>>>      - Make MQD functions GEN and IP specific
>>>>>>
>>>>>> V2: Worked on review comments from Alex:
>>>>>>      - Reuse the existing adev->mqd[ip] for MQD creation
>>>>>>      - Formatting and arrangement of code
>>>>>>
>>>>>> V3:
>>>>>>      - Integration with doorbell manager
>>>>>>
>>>>>> V4: Review comments addressed:
>>>>>>      - Do not create a new file for userq, reuse gfx_v11_0.c (Alex)
>>>>>>      - Align name of structure members (Luben)
>>>>>>      - Don't break up the Cc tag list and the Sob tag list in commit
>>>>>>        message (Luben)
>>>>>> V5:
>>>>>>     - No need to reserve the bo for MQD (Christian).
>>>>>>     - Some more changes to support IP specific MQD creation.
>>>>>>
>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 16 ++++
>>>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 73 
>>>>>> +++++++++++++++++++
>>>>>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
>>>>>>   3 files changed, 96 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>> index e37b5da5a0d0..bb774144c372 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>> @@ -134,12 +134,28 @@ int amdgpu_userq_ioctl(struct drm_device 
>>>>>> *dev, void *data,
>>>>>>       return r;
>>>>>>   }
>>>>>>   +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
>>>>>> +
>>>>>> +static void
>>>>>> +amdgpu_userqueue_setup_gfx(struct amdgpu_userq_mgr *uq_mgr)
>>>>>> +{
>>>>>> +    int maj;
>>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>>>> +    uint32_t version = adev->ip_versions[GC_HWIP][0];
>>>>>> +
>>>>>> +    /* We support usermode queue only for GFX V11 as of now */
>>>>>> +    maj = IP_VERSION_MAJ(version);
>>>>>> +    if (maj == 11)
>>>>>> +        uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = 
>>>>>> &userq_gfx_v11_funcs;
>>>>>> +}
>>>>>> +
>>>>>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, 
>>>>>> struct amdgpu_device *adev)
>>>>>>   {
>>>>>>       mutex_init(&userq_mgr->userq_mutex);
>>>>>>       idr_init_base(&userq_mgr->userq_idr, 1);
>>>>>>       userq_mgr->adev = adev;
>>>>>>   +    amdgpu_userqueue_setup_gfx(userq_mgr);
>>>>>>       return 0;
>>>>>>   }
>>>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>>> index c4940b6ea1c4..e76e1b86b434 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>>> @@ -30,6 +30,7 @@
>>>>>>   #include "amdgpu_psp.h"
>>>>>>   #include "amdgpu_smu.h"
>>>>>>   #include "amdgpu_atomfirmware.h"
>>>>>> +#include "amdgpu_userqueue.h"
>>>>>>   #include "imu_v11_0.h"
>>>>>>   #include "soc21.h"
>>>>>>   #include "nvd.h"
>>>>>> @@ -6486,3 +6487,75 @@ const struct amdgpu_ip_block_version 
>>>>>> gfx_v11_0_ip_block =
>>>>>>       .rev = 0,
>>>>>>       .funcs = &gfx_v11_0_ip_funcs,
>>>>>>   };
>>>>>> +
>>>>>> +static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr 
>>>>>> *uq_mgr,
>>>>>> +                      struct drm_amdgpu_userq_in *args_in,
>>>>>> +                      struct amdgpu_usermode_queue *queue)
>>>>>> +{
>>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>>>> +    struct amdgpu_mqd *mqd_gfx_generic = 
>>>>>> &adev->mqds[AMDGPU_HW_IP_GFX];
>>>>>> +    struct drm_amdgpu_userq_mqd_gfx_v11_0 mqd_user;
>>>>>> +    struct amdgpu_mqd_prop userq_props;
>>>>>> +    int r;
>>>>>> +
>>>>>> +    /* Incoming MQD parameters from userspace to be saved here */
>>>>>> +    memset(&mqd_user, 0, sizeof(mqd_user));
>>>>>> +
>>>>>> +    /* Structure to initialize MQD for userqueue using generic 
>>>>>> MQD init function */
>>>>>> +    memset(&userq_props, 0, sizeof(userq_props));
>>>>>> +
>>>>>> +    if (args_in->mqd_size != sizeof(struct 
>>>>>> drm_amdgpu_userq_mqd_gfx_v11_0)) {
>>>>>> +        DRM_ERROR("MQD size mismatch\n");
>>>>>> +        return -EINVAL;
>>>>>> +    }
>>>>>> +
>>>>>> +    if (copy_from_user(&mqd_user, u64_to_user_ptr(args_in->mqd), 
>>>>>> args_in->mqd_size)) {
>>>>>> +        DRM_ERROR("Failed to get user MQD\n");
>>>>>> +        return -EFAULT;
>>>>>> +    }
>>>>>> +
>>>>>> +    /* Create BO for actual Userqueue MQD now */
>>>>>> +    r = amdgpu_bo_create_kernel(adev, mqd_gfx_generic->mqd_size, 
>>>>>> PAGE_SIZE,
>>>>>> +                    AMDGPU_GEM_DOMAIN_GTT,
>>>>>> +                    &queue->mqd.obj,
>>>>>> +                    &queue->mqd.gpu_addr,
>>>>>> +                    &queue->mqd.cpu_ptr);
>>>>>> +    if (r) {
>>>>>> +        DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
>>>>>> +        return -ENOMEM;
>>>>>> +    }
>>>>>
>>>>> Using amdgpu_bo_create_kernel() for the MQD is most likely not a 
>>>>> good idea in the long term, but should work for now.
>>>>>
>>>> I was a bit curious about this, the scope of this MQD object is 
>>>> kernel internal and used for queue mapping only, userspace doesn't 
>>>> know much about it. Do you still think we should not create a 
>>>> kernel object for it ?
>>>
>>>
>>> Well we should use a kernel BO. But amdgpu_bo_create_kernel() not 
>>> only creates a kernel BO but also pins it! And that is problematic 
>>> because it allows userspace to do a deny of service attach on the 
>>> kernel module.
>>>
>>> What we need is an eviction fence, e.g. what KFD is already using. 
>>> Then the BO is created similar to how VM page tables are created, 
>>> maybe even using the same reservation object.
>>
>> KFD doesn't currently use eviction fences on MQDs. Those are pinned. 
>> I guess you could treat the MQDs more like we treat page tables. They 
>> are allocated in kernel mode but protected with fences rather than 
>> pinning.
>>
>> I'm not sure if MES needs to be able to access MQDs while queues are 
>> not mapped. If that's the case, pinning can't be avoided.
>>
> I was planning to do something like this keep userqueue objects from 
> eviction:
>
> - Add a new mutex in queue struct (say userq_eviction_fence)
>
> - lock this while mapping the queue, and unlock it while unmapping of 
> the queue
>
> - add checks in amdgpu_vm_evictable() to add a 
> mutex_trylock(userq_eviction_fence)
>
> Does it sound like what we want to do here or should I need something 
> else ?

A mutex is not a fence. The eviction fences we have in KFD are 
dma_fences. They interact with TTM's memory eviction logic, which allows 
us to stop user mode queues before TTM moves memory. A mutex cannot do that.

Regards,
   Felix


>
>> Regards,
>>   Felix
>>
>>
>>>
>>> But for a test this here is probably ok.
>>>
>>> Christian.
>>>
>>>>
>>>> - Shashank
>>>>
>>>>> Probably best to add a comment here that this needs to be improved.
>>>>>
>>>>> Apart from that looks good to me,
>>>>> Christian.
>>>>>
>>>>>> +    memset(queue->mqd.cpu_ptr, 0, mqd_gfx_generic->mqd_size);
>>>>>> +
>>>>>> +    /* Initialize the MQD BO with user given values */
>>>>>> +    userq_props.wptr_gpu_addr = mqd_user.wptr_va;
>>>>>> +    userq_props.rptr_gpu_addr = mqd_user.rptr_va;
>>>>>> +    userq_props.queue_size = mqd_user.queue_size;
>>>>>> +    userq_props.hqd_base_gpu_addr = mqd_user.queue_va;
>>>>>> +    userq_props.mqd_gpu_addr = queue->mqd.gpu_addr;
>>>>>> +    userq_props.use_doorbell = true;
>>>>>> +
>>>>>> +    r = mqd_gfx_generic->init_mqd(adev, (void 
>>>>>> *)queue->mqd.cpu_ptr, &userq_props);
>>>>>> +    if (r) {
>>>>>> +        DRM_ERROR("Failed to initialize MQD for userqueue\n");
>>>>>> +        goto free_mqd;
>>>>>> +    }
>>>>>> +
>>>>>> +    return 0;
>>>>>> +
>>>>>> +free_mqd:
>>>>>> +    amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr, 
>>>>>> &queue->mqd.cpu_ptr);
>>>>>> +    return r;
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, 
>>>>>> struct amdgpu_usermode_queue *queue)
>>>>>> +{
>>>>>> +    struct amdgpu_userq_obj *mqd = &queue->mqd;
>>>>>> +
>>>>>> +    amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, 
>>>>>> &mqd->cpu_ptr);
>>>>>> +}
>>>>>> +
>>>>>> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
>>>>>> +    .mqd_create = gfx_v11_0_userq_mqd_create,
>>>>>> +    .mqd_destroy = gfx_v11_0_userq_mqd_destroy,
>>>>>> +};
>>>>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>>>>>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>>> index 55ed6512a565..240f92796f00 100644
>>>>>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>>> @@ -29,6 +29,12 @@
>>>>>>     struct amdgpu_mqd_prop;
>>>>>>   +struct amdgpu_userq_obj {
>>>>>> +    void         *cpu_ptr;
>>>>>> +    uint64_t     gpu_addr;
>>>>>> +    struct amdgpu_bo *obj;
>>>>>> +};
>>>>>> +
>>>>>>   struct amdgpu_usermode_queue {
>>>>>>       int            queue_type;
>>>>>>       uint64_t        doorbell_handle;
>>>>>> @@ -37,6 +43,7 @@ struct amdgpu_usermode_queue {
>>>>>>       struct amdgpu_mqd_prop    *userq_prop;
>>>>>>       struct amdgpu_userq_mgr *userq_mgr;
>>>>>>       struct amdgpu_vm    *vm;
>>>>>> +    struct amdgpu_userq_obj mqd;
>>>>>>   };
>>>>>>     struct amdgpu_userq_funcs {
>>>>>
>>>
