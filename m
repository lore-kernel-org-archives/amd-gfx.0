Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2738EC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 12:55:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95F36135E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 12:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D95F36135E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86EF26E47B;
	Wed, 20 Oct 2021 12:55:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A62E6E47B
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 12:55:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndlfJcovtBytkIU3lWX+4gk59hpQFaDEd2/z3slMozniTlM9LI2yT/gYSTx5sYvxG+ktLQ/SCBb+/3bcX+I/0WfTJIrr7UTi2/sriZigff6mOImatXFKboAO/x3SHnSA6xNW1qb81Dtyw42ePw/4L7TEtuKQ313Ki3/YPSP20w+L7tKSTqSxQ6HIJK39WrmCaZm91ET5A2aIvJ/YG/OjbeAlmuPKnJHxclO95U3ATY7uVL7G4wubeo7ijQ2liLVpIpep2LAVxrbbx1PHV6/4QJESSvQOFMR0K5IV/J2kgmZ0JytRCl86+rArpfzI8y2s8k+oNIgCSYuTkIvDfDqj5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uO8Xwl363vBrZFmtOExyNI2eaTDQsnlM0rqkI0bsFU=;
 b=PpNFoNFenQuVPBftP7UQbYOWRJbn7YU+wA5V1LJXZ9QuyRKaFbhjsnNplT7q0N4L92DJiCiU3+tnKN/OWW2uZ1h9cJ3tGw4l9A13zpHyUeqVYleFVxHF8Fq1th7TMaYeUD21lxDubh2/e+mSCGHNjlW8bP8Q51MsiGWLnTKtkq20H+LMtniesLLlSaiOn6pEUAehYkqTRcm8zx1e1OlkJ3JOVNbQCTt+DQn8/uWrWBMD8kHK3O9gPVcWKjNThbQgFwdDgVH91ZhuIPzo7CfmmBZ2Q82zEP4ggsbB80bhpEH373AeGfcVOUOm2fKSt9SQa/ImKncelryTneaicmrGPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uO8Xwl363vBrZFmtOExyNI2eaTDQsnlM0rqkI0bsFU=;
 b=JsNJ30kQQOucIgqRe8qYV9Qg7Hjo+8eL7pGWUXLf+JnnKbiuTsDNMYbUHWGl45NoIbCJzRKTiKZ0fJQrLYczhmsxKx/zWoWmVEuOZGhgtnLcQfQ6YhR3PPU+GYHFkvWV3lS1lgHPR5rC5cnUNWzWupuhuK3x59T98ufCgRSgywc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5215.namprd12.prod.outlook.com (2603:10b6:5:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Wed, 20 Oct
 2021 12:55:30 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 12:55:29 +0000
Message-ID: <df7e2391-8169-7d2e-ebb5-87a97a999430@amd.com>
Date: Wed, 20 Oct 2021 14:55:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/1] drm/amdgpu: fix BO leak after successful move test
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, Alexander.Deucher@amd.com,
 zhang <botton_zhang@163.com>
References: <20211012121018.81693-1-nirmoy.das@amd.com>
 <20211013150902.6646-1-nirmoy.das@amd.com>
 <7f990838-a3e3-333e-3237-09f4595ee452@gmail.com>
 <b246a463-0774-b4f4-8d28-86c71e791f49@gmail.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
In-Reply-To: <b246a463-0774-b4f4-8d28-86c71e791f49@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P192CA0091.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::32) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [192.168.178.88] (217.86.117.49) by
 AM6P192CA0091.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:8d::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18 via Frontend Transport; Wed, 20 Oct 2021 12:55:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e71d96c-210e-4e0c-9605-08d993c8e51b
X-MS-TrafficTypeDiagnostic: DM4PR12MB5215:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5215F14366DDA304C6BF43048BBE9@DM4PR12MB5215.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ybxXf2fJOxhxDAdudDUTWrHelDol5cK2ZTFVjCE9r7Xxu18McCgKJ6SBVlh6rr7SlHlPE5W2UBzfBwEm7r71IPGwXe5XNpYuhmeIEGQYkVbO8i48nRzyOlVJbPQnqizYEVZg4jsIIglgZnXGkcy6FRYnFlRXwv7Sbeq4iofCHWTKbl6kgagD6iRFBWmfnMOtcHBfZ0HnnDsr7Y30KXBFbtgYt337gMA/8H0lpfy0XRLBu/jyTWJCaPMgV/AGYhp8t221iR2QXPtwopi0IDp4/N49D/l0ilaIS7fVRNEkwEDDrGNFgo9ruXJMzs1zKviLb/YfglXE6k5J2r6Ye1J5wFVScNPIfjafYqGG/JyfMIPieDTQkPoSmLv6wdYozdqRtrVPHSLILMPTIwkzgNtVTchKzW43iwuJjcGc4PVRRw4wdg3RqJjoFQCJpsGiqifO2E1+YsbL8MnRhgu3FKiiNmsNdq0OAl2Fyp48pyHKX/J9FEt6HB2XJcN2eh4SL2/5wflqXNBJ4huRPwSLiOFFMksPDvIaQORHgj4kaI0jZqtZ0DTvDxMf06pgosmUnPjp2FI5aE9wMt5FqJE9tmF8NbgLznPBPZu7xrYX2eiVJIBB67DmUAcJNLvKc7wZA25hAr+adQfbfHoWftX22SUYxUoGyrDl/bdVaYA6VgAEmwLC9bjW9vOki3E0HBblRPsedOdjoivIgNfUHeRdKESbHk2csk0CCiqQ0otnDaxAJUA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(31686004)(6666004)(2906002)(83380400001)(956004)(2616005)(66946007)(66476007)(66556008)(508600001)(16576012)(5660300002)(38100700002)(6486002)(53546011)(86362001)(8676002)(26005)(31696002)(4326008)(8936002)(186003)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTkxTW5WQnZVaHliWUZxY0szL2t5azhLZHJVTXB1RThDd0x4Q3ZRZ0lGRDlV?=
 =?utf-8?B?cFZlYWFyNlI3bmY0UzV2Z2twY3RtZi9CNlREb3NBNTk2NXNPZmtYNDBHb3pG?=
 =?utf-8?B?bmVFK1VoMExPZndqZ3dRaWlGTGcxU3JiMnU1SjBJaEtWMWVTZWRDa2hseUVj?=
 =?utf-8?B?ZUZCKzV2bzNyR0JHWERqMzJxd1dLVXZzM2FydDhmYUFrTkF4MUhULzBMVzFy?=
 =?utf-8?B?WEJXdk1XOE11SWlEbW5YcmRrZkFhWmU4Vm8zZXZXd2N0WHNZVTZSN2p6a0xP?=
 =?utf-8?B?MTZYOWdyNHV6bjFkdDh2d1JkV1NPc2c4ZWt2TkYyYnVqT0VwenhGSVJKbW1k?=
 =?utf-8?B?SEQvdmRuYW95NnpRWFdnWGRRbGVJYTRBaTU5bFhhWnoyQUFFUFh3N2tqUy9u?=
 =?utf-8?B?Y1dsK2RRRzFaYU5zWE9NbkU3NmZXR2t3KzJza1VlWlBTTHEwbG9hMXNGQS95?=
 =?utf-8?B?ajJOU1U0d0FxMmxjcVozQXBaZ0NVc3pZcm8zRHphWTRpUVJPRkEycW9GY3Vz?=
 =?utf-8?B?SDZRYVBNdmJrS2NKRlNFSzB6ZWlUT1FERW1tTUNjbTlMK3JOWEIvS2psWEd3?=
 =?utf-8?B?K2VEUjhycDV2NmJObXA3YktxZys1ODhMYlRic1hKQXNwbXBIMG5Yc0RIeHJs?=
 =?utf-8?B?SXlvNytLb2Y0ajBMVmFYREhKVVovaWZveUxRWFJwdkljQThCQlQ0dUxtSmRa?=
 =?utf-8?B?ZXJjcndkd2hXSTBScFc2OStLaXpDOUt5Z293UFMzK2JjRmIycHdBdG9USFpa?=
 =?utf-8?B?K0RYZEt5RHN2WFg5UEE0dkN6eXc1Q3RhMlQ1OTA3MjVsWWVuMUlnb09MSXlE?=
 =?utf-8?B?T2FIL1M5SEJoWGRCY3dkL1MzaTNiZElQaWZHeFVmQ2FSR3FXVUw3MnNPaFBN?=
 =?utf-8?B?eHZLQ2M5TlByL2RwVGhVZXlYWEF5cXZ3eDJhMFhHSWlmWmpDdkdBcVRMSElU?=
 =?utf-8?B?aW1nekxXVEFIVTh6bjNTNEZISWUzUHA3QWpuZGRudm1naGhJYUdPS1FGczYx?=
 =?utf-8?B?Q0hmMEhqK0FCaVZsQzdtNktXc3gwdTVRYXRUQnduMWZ5UWdiRkZENzhIcVo4?=
 =?utf-8?B?anhEaGxpVFFKQ3ZOc1hlRWN0UkU0Rlk2Z0sva0poZU8xZjlFRkFmSHRucmdU?=
 =?utf-8?B?RUZadGROZStqUzM1TVZKSVBXYlZSZjlnSEFKOW4yMTRrZUdLV0Y1aS9mN3VS?=
 =?utf-8?B?dEVWZ1czNWJvLzVpbGt2Z1RLUmJRcmk4N1NZK3JTRVJkb2RhLzhJK2RvNkJz?=
 =?utf-8?B?eFk0RU9Gcjc0eW5QSmdaWWkwY3l2eC9ZenQyelV3azIwU3RxSy8zNmRDRWtq?=
 =?utf-8?B?UUNqZWxrTGZUZTNheis4ZVM5YXcrOVk5QmxLM0dsYVFqSWxkRUNzWkd2NFJi?=
 =?utf-8?B?SFpVWDByVU9LWFpZZ1BPWEpaeFFaK3dMNitteHRQNUNSdis5bDljUiswdUhh?=
 =?utf-8?B?V3JCNS9oY242K284TlBvclZuQm10YWljOEIyNis1Tm8yRHVWeWFEKzFSK3hq?=
 =?utf-8?B?V1ZIN3JDd1ZtTWc4cWhLOE5iRE5yV2lEWlYvMzN5ZmZFMDlIVnZxNjJUZXcr?=
 =?utf-8?B?VGwzTkcvV0VCalY5ZDRLdkRncnU3Q3R4OXVhVVhYdTNocXN4QXZpd1FkcW1h?=
 =?utf-8?B?NkVOdW5naVBxcXhyOVRBTk40eElEekJxV0daZHBseGVnQ2RlL0xVNzJEUXdv?=
 =?utf-8?B?WHNZQ0lxYzkrNTNpOUVYeTVTUE5KSEVOSFpwWmZQYVYrOWxKQXFzWmkrOXNi?=
 =?utf-8?Q?v6FfxzkN90b+7WAChxbeSCnGm7g3bUs783hXDc0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e71d96c-210e-4e0c-9605-08d993c8e51b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 12:55:29.7950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2Vzgnc13g7U0oDDA6emRsLtR2D3TjMttyM8+/TuVlnPwsa/kVe2hip+JgYA6sIT+CEbiq5YoBec03zwMZSYDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5215
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


On 10/20/2021 1:51 PM, Christian König wrote:
> Am 20.10.21 um 13:50 schrieb Christian König:
>>
>>
>> Am 13.10.21 um 17:09 schrieb Nirmoy Das:
>>> GTT BO cleanup code is with in the test for loop and
>>> we would skip cleaning up GTT BO on success.
>>>
>>> Reported-by: zhang <botton_zhang@163.com>
>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_test.c | 25 
>>> ++++++++++++------------
>>>   1 file changed, 12 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
>>> index 909d830b513e..5fe7ff680c29 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
>>> @@ -35,6 +35,7 @@ static void amdgpu_do_test_moves(struct 
>>> amdgpu_device *adev)
>>>       struct amdgpu_bo *vram_obj = NULL;
>>>       struct amdgpu_bo **gtt_obj = NULL;
>>>       struct amdgpu_bo_param bp;
>>> +    struct dma_fence *fence = NULL;
>>>       uint64_t gart_addr, vram_addr;
>>>       unsigned n, size;
>>>       int i, r;
>>> @@ -82,7 +83,6 @@ static void amdgpu_do_test_moves(struct 
>>> amdgpu_device *adev)
>>>           void *gtt_map, *vram_map;
>>>           void **gart_start, **gart_end;
>>>           void **vram_start, **vram_end;
>>> -        struct dma_fence *fence = NULL;
>>>             bp.domain = AMDGPU_GEM_DOMAIN_GTT;
>>>           r = amdgpu_bo_create(adev, &bp, gtt_obj + i);
>>> @@ -212,24 +212,23 @@ static void amdgpu_do_test_moves(struct 
>>> amdgpu_device *adev)
>>>             DRM_INFO("Tested GTT->VRAM and VRAM->GTT copy for GTT 
>>> offset 0x%llx\n",
>>>                gart_addr - adev->gmc.gart_start);
>>> -        continue;
>>> +    }
>>>   +    --i;
>>>   out_lclean_unpin:
>>> -        amdgpu_bo_unpin(gtt_obj[i]);
>>> +    amdgpu_bo_unpin(gtt_obj[i]);
>>>   out_lclean_unres:
>>> -        amdgpu_bo_unreserve(gtt_obj[i]);
>>> +    amdgpu_bo_unreserve(gtt_obj[i]);
>>>   out_lclean_unref:
>>> -        amdgpu_bo_unref(&gtt_obj[i]);
>>> +    amdgpu_bo_unref(&gtt_obj[i]);
>>>   out_lclean:
>>> -        for (--i; i >= 0; --i) {
>>> -            amdgpu_bo_unpin(gtt_obj[i]);
>>> -            amdgpu_bo_unreserve(gtt_obj[i]);
>>> -            amdgpu_bo_unref(&gtt_obj[i]);
>>> -        }
>>> -        if (fence)
>>> -            dma_fence_put(fence);
>>> -        break;
>>> +    for (--i; i >= 0; --i) {
>>
>> The usual idiom for cleanups like that is "while (i--)..." because 
>> that also works with an unsigned i.
>>
>> Apart from that looks good to me.
>
> But I'm not sure that we would want to keep the in kernel tests around 
> anyway.
>
> We now have my amdgpu_stress tool to test memory bandwidth and mesa 
> has an option for that for a long time as well.


Shall I then remove amdgpu_test.c ?


Nirmoy


>
> Christian.
>
>>
>> Christian.
>>
>>> +        amdgpu_bo_unpin(gtt_obj[i]);
>>> +        amdgpu_bo_unreserve(gtt_obj[i]);
>>> +        amdgpu_bo_unref(&gtt_obj[i]);
>>>       }
>>> +    if (fence)
>>> +        dma_fence_put(fence);
>>>         amdgpu_bo_unpin(vram_obj);
>>>   out_unres:
>>
>
