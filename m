Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2662FC4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 09:52:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6F7110E25F;
	Fri,  8 Dec 2023 09:52:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D4EB10E25F
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 09:52:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Us/eBG9SI3i71udB7WqZjn7pKeGNVVeWI5XG0rQQngvRJLTHBBzswHXcGZPu82KJcsqfWHvezpkuAO8T/KszkKGHsNVhZdR3dn6lPi8CV9eGHIj7iXq+j5v23oUrEUKnv6Qcv8fGTJ0Wj4vIZV1If/hKVokFXmYj+uuhvdHK4HXkuCqQapFOckfYa5EXQVqIKa0iVRsLL5E5rPMlmJCv1Tyw46KK7TKhVFNPCjfh8c1Qq06qCOWb97sBJKJdcCV+egTBjhfb7kScmE8cHwMXSfgiNXoS6ZG2E3iRvulJr8+aNTWwDteMz9ZPZnaHkZ+49Vnqfx/SYuUPVWz732LylA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmAoiPmgATjdnwpMOGAs2ByKLqw36Nw4gZfngqTeTG8=;
 b=IBI7w5QjYdIA55OWNiJuu3NxRtJ9C8ktTokQeYbZLPOEBmznsg8B2+IxJKKorJ56wT2fZJDPYDDylkNTh/4wA6RGOOoon1PWRD6nJbUgPhAZP+9bN4GixUKqlKjMhUhd0psOl9GRl5TFpWiUfmXAvf/jw5Geo/FLyKlcNgYz98fRgm84MY/y7IVYKKtBPgy5RY9cF15q2nTORU83y9gcUKMrzLd2Qxwv1qz1VT495rKdhESt9Jc9hTWrgV19WVshuGk+mXZYFdPkYOZFBFwvaeOtAjjyM6l5hWJb1lNkDbi+VtHnOY6aWjsUk6TP4Tk80B+e7/xdJYURbW9GPfSBSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmAoiPmgATjdnwpMOGAs2ByKLqw36Nw4gZfngqTeTG8=;
 b=zUAIdFPhR+3CrHupQRC8udkkXm6tHe29G66VRSzKyvtwAomy45bx2Y7go0UArefjS5M4DafQUENqH3TOn7ygg4GQAhUNvb0d/iHbkRPMq2sxEcoXrkukxBv6TJ8pSE3GIeMXh8RPLoIDMFZcF+WBB8hCELeNU6bzO0+HSzU8bm8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BY5PR12MB4323.namprd12.prod.outlook.com (2603:10b6:a03:211::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Fri, 8 Dec
 2023 09:51:58 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3%7]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 09:51:58 +0000
Message-ID: <3cf226b8-c80b-43f6-9f6c-9610d224717a@amd.com>
Date: Fri, 8 Dec 2023 10:51:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Enable tunneling on high-priority compute
 queues
Content-Language: en-US
To: Friedrich Vock <friedrich.vock@gmx.de>, amd-gfx@lists.freedesktop.org
References: <20231202001740.120840-1-friedrich.vock@gmx.de>
 <3525f437-9537-4fb4-80d0-65acd9d55d2f@gmx.de>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <3525f437-9537-4fb4-80d0-65acd9d55d2f@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::7) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BY5PR12MB4323:EE_
X-MS-Office365-Filtering-Correlation-Id: 147a41cd-b59b-404f-7b01-08dbf7d35182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N7UwA7ueF3fu95HU7YpoKKInzwXFytPDDfoy8o1697QjsNM41CiY/sw4mxD6XgdGeaMhZtEGkcJPsBUPfV8hXbVRRNXNVasEYw6Ie1DwNm3GuH8HBnXy5WLr+lf9zEYPjvdsttnzkF+cEZhdhq7kSiibZifS0VRbTsN2IWmyF/tdFXiLoUVfmldyaW44Rzp/X+SJURArsOdDX2c8VRbRVjx+PzCwk6uyJyQMkC0VftGMA6ZbR/uyCH7jxji9DQFo9Q5tl3WeTlU+1iElZhaCWIAvLtwO73nAHSbHW5bpa0w/Uju+uYAkduq6KOmahSM04jqqjo7YYpjoG+q5FwRC5eTwlmpl5+DOGyB4QV7E+Z7SVGsheQ6tNB+MT2MV+bMxZM7tplE2IcKZ7DmiW5OLKC2uCth6t365Qki3pO9ttgCeiOE7kTBNLwq0AWq7kuAVG1nL8+o0qw+vAx2Ier5YDPpFmEzEX1HnnQ4wTHPz23Kj1QSZlEFgl7QAI36RuxESORYtKhtKh94ucapJ6xUupC/6DunSfZ01wMOlSWf2/MaBqcFRZ+YD9HpberHa6JpfkkVnXzz+ktm7k5ivFBIppm7gDK+8Ey2jJV1U0Nqy5AiIcu3cCUTrOPi2StVs9HrYVgyCN4WOIF3rOmevJ5/qIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(366004)(136003)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(31696002)(2906002)(5660300002)(36756003)(86362001)(41300700001)(6486002)(966005)(6506007)(6666004)(6512007)(478600001)(53546011)(38100700002)(83380400001)(2616005)(26005)(31686004)(8676002)(8936002)(4326008)(66556008)(66946007)(66476007)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHpjaXBUWWMwczQxQUpqc0h2N1c3VHVJZ1oyWEVhMVZNbnVacG45YStEL2Y5?=
 =?utf-8?B?aVFQYndESGllZGk3YXFyL1F6Q29KK01iZEg1dWdudThhcFNGZXQ3SlRkRWYw?=
 =?utf-8?B?Zjl1eHZUY25DUkNTcVFEOVpES1F1QitZSDZqTmdvSW9DR0FsOGxkOU1mdE9i?=
 =?utf-8?B?NUZyUkJsNUFYNkc1U2ZaSmE1VHVzcTRSaDdhdHdVZnpLLzBkM2FKS2FqZmth?=
 =?utf-8?B?NTBzTTdMdnV2azVJK25SaEQvZ0lYZVNVSG5xV0ZyQStFeVB6cjNGU3R1Wmcr?=
 =?utf-8?B?ckUxY1ZlSkkySkg5Snp5NFY3YzNpZnJobDJIY2I4K2RrV0Q3VVBCL011dy9o?=
 =?utf-8?B?bG81MEExOVF1Q3Uya1FpVU8wSloybUNLYXc1b1NlZ0ZURnJocnhOMjIxb0VX?=
 =?utf-8?B?eG1xZWNaaTlDeW1PdmFvOUIwL2Vna0EzNk1FZjVrS1pIOU5MYVdrWEZpVmwz?=
 =?utf-8?B?aUp2MWlPa1M2T1BSLy9uQitkQmxTcnJ5cFVQRENZSEQ5eEhNQXJ3VmllSzQz?=
 =?utf-8?B?dHhPODJYYXdoMDc4LzBwa09TeWVVN0w1T2srKzZnT21RWXdiUVlFajlsSC9T?=
 =?utf-8?B?QXZtNGg5UGJlYm9Hd0psNFR6akVkRmdleE5RWnJjaGlUcXZ0NzNrRThFTGpL?=
 =?utf-8?B?NlE1aFlJRUZNdUpuNkN4Q0doN1JyN1h5b093amM1Z1lXZ0ZsOFR2TE5ZQTBV?=
 =?utf-8?B?WG5PZXZubzBpaEVPVmM5UUpQZHVtek5oeDJQQkRUYmFqem9wMXNQSWszVGh6?=
 =?utf-8?B?U1Q0Y2FQdnVjZDRSZ21aNXlOZmNRcFdGRDhsbllSZWk2c3NURUlCQXduSmt4?=
 =?utf-8?B?SXZaR29BZGw0QTJ4bXdVVWwzaURER3FlT3ZTYzQ0d283aHN0bDl2dUJoaUxw?=
 =?utf-8?B?Q3NDY1NGK3hCK0I0anBiV05ZRldTUnk0UU5CVEt6UUpMSEV6V3hQbDQwNzFG?=
 =?utf-8?B?THRMSThMVmIxbDhoODB2OVRuYkl3M2ZUTHQ4SkVtNFJEQjltOVd3YjJZSmdS?=
 =?utf-8?B?TTh4TlVVdkU4ZTZ5VFZNbUFob2tuU0NUaG4wUnZtbFVjTURFNExVVTFYbllB?=
 =?utf-8?B?UWVrc2luZzNEWDcvOHBQQzhWVWRQMnkyVzVsbU10NDAvdEI2VFdRTmlML0ww?=
 =?utf-8?B?bjdyK1JXVlY4MlhTcFhuZ0pNWFlnU1Qzb2dOUEdveHpicy9IVnVSc3k3clZu?=
 =?utf-8?B?N1RERCtiN0VSTVhCYWo5TXpYZ2F3QmEwRCtCamkvOGxQcFFSY05JWmFNWWcx?=
 =?utf-8?B?UGpkU2pTNWxOb0lSSEk4MjBmOURwMUxaVFVnOWVKd0FmOGpKMTRNK1NIb3hE?=
 =?utf-8?B?ck4zaEtNMjJnY1VXWVUzUVJRdnFvSUhldWEydmovQ3pGeUNmd0ZJNk1KN2s0?=
 =?utf-8?B?dW9MK1JNLzBwbUxPYmJjaDZOS3JobVFuRk0rbXhYZXMyZFdZRVUrQ3pKZ1pE?=
 =?utf-8?B?TkJnaXd1ZzIwTXFFUU10dkdYMjBLM2JER3JLS1F1VjZiL0lxK096eVd5cGN1?=
 =?utf-8?B?ek1IRFBINXlKQm11V0VyWXJ3bE1TbTJwMFpZSWJncVpwUzBGUm5iQ29tTm55?=
 =?utf-8?B?UWoyWG12SVZ4RnliWk14TGprbGVBZ3N5UlAvYWlEc0puUUhQTzM0eHI4bjAr?=
 =?utf-8?B?VWdIaVFRbUt5bVZBaHdOMytBaXVTQmpRMC94TnhZM0ttZ0NUbjNyd1VIQXpl?=
 =?utf-8?B?QkptQXVvUzBab2ErbnI2ckdoaHpGQzNneHIrRHZlbjNZV05hRlVudlRkRGxM?=
 =?utf-8?B?akRER2JnK3FPOFYrcEFxaWRIUTVXRjRUZjNUdXJIcVJndStOUTZPVWtMb3N0?=
 =?utf-8?B?TGl0WmtLWWF6TG9sL09hUHd0U2YxckNaMDBiYjdacjBNenNTbFBjYTdsay9l?=
 =?utf-8?B?TEZFYjZOeHJIRFlvcU0reHc3NGJnRlJkdEpJNjNJU2hZSi9WTkI1UVhhOE5U?=
 =?utf-8?B?aXkvRU9TdjZUbzk3akJRcEM3S00wS0p2SkZ0eGJ4OFlkYmVzazdXbUxGMGxR?=
 =?utf-8?B?ek91WkFMUkVLYmZPcm1PeDFMM1FhODlxVm93WkNrblkxbVdXWW0yS1hLU1lB?=
 =?utf-8?B?S1pFMXNLRGRHOGl3WEN0YkxCM2JqOEZXeWRnU1VLR1Zyd1MvTmZ1MDU3L3Bl?=
 =?utf-8?Q?wmMhMlPKEuzaH3snxGEcygzyL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 147a41cd-b59b-404f-7b01-08dbf7d35182
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 09:51:58.2451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bt+NuKUlU+xge20HnQ0aVbAsL4m8P2uT8kvNeqShTlLhKKclo1eAyai6G0eVz8U/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4323
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Well longer story short Alex and I have been digging up the 
documentation for this and as far as we can tell this isn't correct.

You need to do quite a bit more before you can turn on this feature. 
What userspace side do you refer to?

Regards,
Christian.

Am 08.12.23 um 09:19 schrieb Friedrich Vock:
> Friendly ping on this one.
> Userspace side got merged, so would be great to land this patch too :)
>
> On 02.12.23 01:17, Friedrich Vock wrote:
>> This improves latency if the GPU is already busy with other work.
>> This is useful for VR compositors that submit highly latency-sensitive
>> compositing work on high-priority compute queues while the GPU is busy
>> rendering the next frame.
>>
>> Userspace merge request:
>> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/26462
>>
>> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 10 ++++++----
>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  3 ++-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  3 ++-
>>   4 files changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 9505dc8f9d69..4b923a156c4e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -790,6 +790,7 @@ struct amdgpu_mqd_prop {
>>       uint64_t eop_gpu_addr;
>>       uint32_t hqd_pipe_priority;
>>       uint32_t hqd_queue_priority;
>> +    bool allow_tunneling;
>>       bool hqd_active;
>>   };
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> index 231d49132a56..4d98e8879be8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> @@ -620,6 +620,10 @@ static void amdgpu_ring_to_mqd_prop(struct 
>> amdgpu_ring *ring,
>>                       struct amdgpu_mqd_prop *prop)
>>   {
>>       struct amdgpu_device *adev = ring->adev;
>> +    bool is_high_prio_compute = ring->funcs->type == 
>> AMDGPU_RING_TYPE_COMPUTE &&
>> + amdgpu_gfx_is_high_priority_compute_queue(adev, ring);
>> +    bool is_high_prio_gfx = ring->funcs->type == 
>> AMDGPU_RING_TYPE_GFX &&
>> + amdgpu_gfx_is_high_priority_graphics_queue(adev, ring);
>>
>>       memset(prop, 0, sizeof(*prop));
>>
>> @@ -637,10 +641,8 @@ static void amdgpu_ring_to_mqd_prop(struct 
>> amdgpu_ring *ring,
>>        */
>>       prop->hqd_active = ring->funcs->type == AMDGPU_RING_TYPE_KIQ;
>>
>> -    if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE &&
>> -         amdgpu_gfx_is_high_priority_compute_queue(adev, ring)) ||
>> -        (ring->funcs->type == AMDGPU_RING_TYPE_GFX &&
>> -         amdgpu_gfx_is_high_priority_graphics_queue(adev, ring))) {
>> +    prop->allow_tunneling = is_high_prio_compute;
>> +    if (is_high_prio_compute || is_high_prio_gfx) {
>>           prop->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
>>           prop->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
>>       }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index c8a3bf01743f..73f6d7e72c73 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -6593,7 +6593,8 @@ static int gfx_v10_0_compute_mqd_init(struct 
>> amdgpu_device *adev, void *m,
>>       tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
>>   #endif
>>       tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
>> -    tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
>> +    tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
>> +                prop->allow_tunneling);
>>       tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
>>       tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
>>       mqd->cp_hqd_pq_control = tmp;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index c659ef0f47ce..bdcf96df69e6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -3847,7 +3847,8 @@ static int gfx_v11_0_compute_mqd_init(struct 
>> amdgpu_device *adev, void *m,
>>       tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
>>                   (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
>>       tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
>> -    tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
>> +    tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
>> +                prop->allow_tunneling);
>>       tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
>>       tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
>>       mqd->cp_hqd_pq_control = tmp;
>> -- 
>> 2.43.0
>>

