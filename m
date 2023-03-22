Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477E7C6FD1C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Mar 2023 14:34:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDA4B10E965;
	Wed, 22 Mar 2023 14:34:21 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A293610E965
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 14:34:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcoyaS8eXuHzdtJfsvLhUbl0R9aO6m0Pj7azX8SSZCtDRtAjSIXJfg59fJJmfZjMv/snkbA8aH53h45pdlpRuc+LGcedT1NtXbRQLx/kc5VZZxqFH98bmc8vPjrCd0fv+c7ay7+7u36pX0H7rCwMg2oKVi9MSu35zP4o0aLiTWjjHUBb/phaW1iwc0iw55xKms+ACxFJ8UU5dizQDckVp/2jf6xVAVCde3CVX+NTH4apIE5pgOXwXSWHAiYSd31dEJMZKlxyLviDGgmNHl3MT6cS/nGD1+PLFwOJqncife3foxV7Iov3yzrMSuX/3C1oiJ0Pp+gfX79i4NBEwvd9QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDrn0IbCi4yly2QTs5C39clf5gNttzO2KkbbDjOxevs=;
 b=IBf4iu7MqODCbvKt506Z4yWab3vQfIL5T1Y6xCie1iYTLNYiMNj8gqL80p4oIFYvYT3nBXF2VuBshacugtxFmpiqn5UHF0QCURC9hcMQLw28NyOD2iQCXqYaGIYxOafwXWRJloD3udqGcJuM+Hv3Vem3rVcspTNj/AmZr7///jr50Ft86uiq6CpIE2eZvYQ5HBwqDO867Z/hoZdfXevK7MPfjMWWwYy5oteGSNpRVu2sTCq5VCHBKEpYHuHoVvoft7mGl5ZvMJMZ9x07PtW55XAYSfmQY2V/0qWXddJl3+1pj/oDcHd/u8FZuFmxGZM/F16MKyjH0XDT3wGhwnCdPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDrn0IbCi4yly2QTs5C39clf5gNttzO2KkbbDjOxevs=;
 b=D30U32OnqjyXE2QNrN3yn3AuDg1HKJYI+WdvkoXofY5rgfLhk/NbO43sFTxRDzDB2t8tuOkCTZKcPKmYa8tCZbnur0kifXiCv69i7J3iRq18h4repAKppDX+5OQOop4yp/xerxWjjEbY3CdedgDvFKoNl0vMKP5G6NLrfeUGDaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL0PR12MB4898.namprd12.prod.outlook.com (2603:10b6:208:1c7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 14:34:18 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e%5]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 14:34:17 +0000
Message-ID: <213443b2-5caa-5c50-128c-cc50021dd451@amd.com>
Date: Wed, 22 Mar 2023 10:34:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] drm/amdgpu: track MQD size for gfx and compute
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20230321193922.2029808-1-alexander.deucher@amd.com>
 <07b35e4b-c574-0ad8-9c71-591dc5457979@gmail.com>
 <CADnq5_OAZZ-SYLprOFzzJgsQBxs15FdxTWc28MpUQ-abM4ZLHA@mail.gmail.com>
 <22ef9485-11e1-1e23-34d1-f8a40698b226@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <22ef9485-11e1-1e23-34d1-f8a40698b226@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0298.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL0PR12MB4898:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e1c6f5-5770-46b3-19ca-08db2ae2845e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Phda2jaBZBTLOg12JMLZZvrgC0CngaVsOzdFiocT76NrMHlBH0EqFwalu/RPlqmjbT+yIiX1OY6xXkw5HLU1EFiNbgienyr931/O4pj0qK9oV1HKcrtqssAwdH3iYNMkBzlAE3qV48hIGMLpdIsysXOxTqXYN7BnzKhlx7H4+XBfVI3ePOqct6AE/Pebd6gHMhTBkVc2sRXEM7NtubQ9/cfKGGZLk+iOPrV8UijZSXjfRQnoFNfLMf00z2GcftPgeuBJyeiz8uT3T6Xs6GRcLN5ojaHjotw+DwmwDbRVg25z+Q1+IsgEThZfQwr4DDPteNjnAVemyHdO4MbkX5OsQg5ZwzScmykNC43TuMisiW1cAWOk2UKqtURFai6u74RX0vtiGNvjh4EemIx3rOfT0sjpu72upDb0tHY4+D6XyxidajJnaKN7k+bqqoyxlxzhd6GS9hw/bw0fhN6t95X3H9H7TfGeOLHVHz8t1kaHQrxySohO9Oh4t8I1QBKoMpIyqiVuMj8EtvUD5eR91boAloSrh8PSjzvm/nNtB9aqBPndQj874fvVz4ypqpOMdgKSl7K/K+zARWUMIsUiTeA0HTJVOJGTTDgwvr8I2UR/dLkylUicjDMwxphJrSRyCMfvQ9UyYQ08CW8iVzhlujnIuovNWZ6bYrZrLaJGwkKKlNGZT9rHLCyCMISOcHGlfdoe+9/pfgJZt9GrA6Xz3YHHfgxUEcc1w0fp8kV3wkhTCn4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199018)(6666004)(186003)(478600001)(26005)(6486002)(6506007)(8676002)(6512007)(31686004)(53546011)(110136005)(2616005)(316002)(66899018)(66556008)(66476007)(66946007)(8936002)(5660300002)(41300700001)(4326008)(2906002)(38100700002)(86362001)(31696002)(36756003)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzJuTVlIZ1ROSlVYS0FjMjU0TlcwNFBRSzQ5TWNoMVJ3VVA3a3UrRWJmbk5G?=
 =?utf-8?B?c1kyU0xZTjludzZXNEhzSWhxNDlZMCtCRTBVNExTemZDOW5BMUg0ODRZS3oy?=
 =?utf-8?B?QmNJVXRsVDlXaTEvSFhscEFQRWFLUHZDcXcyRW9EL2M3QUtIa21SM1NqeXJy?=
 =?utf-8?B?VHdFeDM4VXp2NzB6RDBncG9VVzg4clM3cHFtQ3pKNW5vUFBoMkpOSVp3MEhy?=
 =?utf-8?B?TDcwN290cVc2WVRHc1NZSXNXbFdoYXZjaDhKZkRMMEMyU2M0SHdVU3lGbnVi?=
 =?utf-8?B?bVErdWp6SlU4Q1A1K0prbUZZb1Vad0xYTkJObG96cjgzZlVZeXIxejhNVHNJ?=
 =?utf-8?B?LzdxejU4K1FxdzFXS21tQWRTY0ltUVdET2MveG4xN0VyVUNMdlF5eFRWWWQ5?=
 =?utf-8?B?a0xyc3FpUkFpQkZvOWk1NlQrbjcveDhOZ3VMLzFsekdSMjdKVXRZdVB6NWZZ?=
 =?utf-8?B?TGszcDZjRUFoR2pIZkhpaDlMc3ZYVFNqd3pLcUxNWlplbmFnOGJ6dUhqSjVH?=
 =?utf-8?B?Q1JvVUVra0x6emZRSDQ2K0w4dkU4ZVRRVzZaTFV0QzBKODIxcUhGY3doNXJs?=
 =?utf-8?B?czF5Q0E3Zyt0TDJWcGZTLzBpdXhTY3RoWFRMRUl4cTRkbWgvcXhVV2xaUmFt?=
 =?utf-8?B?KytpMWhweDl3VEQzNHo1Mklhc3dvMVJtbXFBYkN2dmtkeGpRcXhKaFhjeS9D?=
 =?utf-8?B?dkQzanpndmRmM01JZmpQQURwNHJRN1FuUjNTRjVmK3kxMTUzMloxZDBlUU44?=
 =?utf-8?B?M1ZBMStUTk9XODZXMjZhREtJL2JrMlE0Y0pKYlZUazd5Y3AyNnBJL2c5NWZI?=
 =?utf-8?B?V1Y0WHE5cmdjWEJjV1psYXR5S3g1RHNkR3BZVEJzYmNKQ1Q3bEhuV2pYQi9L?=
 =?utf-8?B?NFVuWFh0R2FNK3o4NmdLdVNwcHQ0Umt5L21WNEdwUWtHVkRXaFZFQlF6cnhm?=
 =?utf-8?B?VmwvbWVQWmxteGtHeE1sZFQ1ZjBidGxJa29SNlUxUHNTSkxwUHo4aTBiMkxP?=
 =?utf-8?B?YkJ3SFpEVUJsam1vdGU5UTlhVWZXbUJkN3BHa1ZkbmhhOTdyVlhWRUNROWVV?=
 =?utf-8?B?NkJuZDBUQTdGZk15TUZOVm5tQUhjRk9FcUxvLy9yTk5ndFJ0VWsrOXAyaGVq?=
 =?utf-8?B?LzdwcjRaZERzMnFsYUlDSHR0aHhRdnRheDhlMW4zb0hTcXNlTDFpSEtPKzAr?=
 =?utf-8?B?STA0NkdLTnY3YStvMmZFb2tFOVUydkdrNTJDTUN0T21sUkFxQWVsNjFPdVUx?=
 =?utf-8?B?dUdWRGY0dzRmTklFOW9sUkZLSGRVKzNuUGFEbzZ2bTJPYWYzOTJ5OVBERXdv?=
 =?utf-8?B?M1A4OE1McE42TDZ6a1lyRTQwQWhJMnpoMERJSzNtQm8vQzNoa3FSdkVpeC9h?=
 =?utf-8?B?YUozaGdkeGFTaFdMMzFCZ3AzQ2oxRnc3MDdnclVHQ2kzcHVsTk0xY0hhZnhp?=
 =?utf-8?B?dnZRQm5ROUFlYldJV1pnWlRsdmd0UFp0ZkFhY0I3ZGlRdkJ6cTN0QXU4MHdS?=
 =?utf-8?B?ZUVRc2pGR0wycjlPWHNnbWJNU2Zzb0N0WDYwekpPajY0WEFxM0x1Uzh3YVdj?=
 =?utf-8?B?Ym5ndTF5b2VzUFFZbzYxSE9FdGNZVnZTMy93dHlhMkk0TmNRbEViQVE0ejlT?=
 =?utf-8?B?T09QNUN1RGlhamNqMUZTcnFmZGxwMUEyaHp3MkhIN1cvM2ZYZHQ2Z3liSnJj?=
 =?utf-8?B?K0FKNzNRV3Z0QVlsVTIrZWJQZEIxUjVEMExhS0ZnVnBhYVNlaWFleG5naVRK?=
 =?utf-8?B?aXJnNDZuRmJQZVcxSDJRZlVPYkRFSXF6TFBON09rNEMvU3lMV1Q2ekloOEo0?=
 =?utf-8?B?dTI2bkNoQUVzSVJnY0ZadCtWanFrMGNlUUFtVkJQRnlUMVNaaU5WSlJYZHBR?=
 =?utf-8?B?ZU5YQmNlNlBWVngxRVI1OEJnM0h4NmM5RllJOVFiVHV4SjZQRmJscDdvUStL?=
 =?utf-8?B?YVk3L01iWXBWU0h3LzlSaXZvY2RjNWZPUEJUVUZVVFZ4ZGdVTUVBUzRKT3dI?=
 =?utf-8?B?dEZRMmhrWjYxT2QrNzhCUnMyTldOcE9MVmtCSU5ZNGs1QngvbTY0SDZaK2dO?=
 =?utf-8?B?Mnp4OEY2dUtYeFgxdHFhY3ZMdXdsNHYrYXRJN1kzUHlDSnlGa1ZuV3FoMHlK?=
 =?utf-8?Q?jp8GhvCYnSq+J3lUQaMa6VSip?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e1c6f5-5770-46b3-19ca-08db2ae2845e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 14:34:17.7148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zy7s3Ybxw5HnwCSFg/wuXXJIOZSEAIcFyPldFlHvqWv+lHcNBY0O4Bh6R2BvAmNoCA/NXW1LFmllTO+faYXBhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4898
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MQDs are smaller than a page. The BO size will always be exactly be one 
page.

KFD can allocate MQDs with a suballocator. On some GPUs we allocate MQDs 
together with the queue's control stack in a single BO. And on some GPUs 
we allocate SDMA "MQDs" in bulk together with the HIQ MQD. So relying on 
the BO size would not work for us.

Regards,
   Felix


Am 2023-03-22 um 09:58 schrieb Christian König:
> Am 22.03.23 um 14:26 schrieb Alex Deucher:
>> On Wed, Mar 22, 2023 at 4:48 AM Christian König
>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>> Am 21.03.23 um 20:39 schrieb Alex Deucher:
>>>> It varies by generation and we need to know the size
>>>> to expose this via debugfs.
>>> I suspect we can't just use the BO size for this?
>> We could, but it may be larger than the actual MQD.  Maybe that's not
>> a big deal?
>
> I don't really know either. Maybe just go ahead with this approach 
> here, but I usually try to avoid stuff like that because it can be an 
> additional source of errors when the allocation size is not correct.
>
> Christian.
>
>>
>> Alex
>>
>>
>>> If yes the series is Reviewed-by: Christian König 
>>> <christian.koenig@amd.com>
>>>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  | 2 ++
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 1 +
>>>>    2 files changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>>> index c50d59855011..5435f41a3b7f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>>> @@ -404,6 +404,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device 
>>>> *adev,
>>>>                                        return r;
>>>>                                }
>>>>
>>>> +                             ring->mqd_size = mqd_size;
>>>>                                /* prepare MQD backup */
>>>>                                adev->gfx.me.mqd_backup[i] = 
>>>> kmalloc(mqd_size, GFP_KERNEL);
>>>>                                if (!adev->gfx.me.mqd_backup[i])
>>>> @@ -424,6 +425,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device 
>>>> *adev,
>>>>                                return r;
>>>>                        }
>>>>
>>>> +                     ring->mqd_size = mqd_size;
>>>>                        /* prepare MQD backup */
>>>>                        adev->gfx.mec.mqd_backup[i] = 
>>>> kmalloc(mqd_size, GFP_KERNEL);
>>>>                        if (!adev->gfx.mec.mqd_backup[i])
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> index 7942cb62e52c..deb9f7bead02 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> @@ -257,6 +257,7 @@ struct amdgpu_ring {
>>>>        struct amdgpu_bo        *mqd_obj;
>>>>        uint64_t                mqd_gpu_addr;
>>>>        void                    *mqd_ptr;
>>>> +     unsigned                mqd_size;
>>>>        uint64_t                eop_gpu_addr;
>>>>        u32                     doorbell_index;
>>>>        bool                    use_doorbell;
>
