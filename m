Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A0CC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 15:35:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D61A10EC6C;
	Tue, 31 May 2022 15:35:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C81C10EC6C
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 15:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OU6u0/C5w0545KaRJ0qucrfpi//eskhEOIKRs7bLMv2aOL7MoLMSiUEXMXSJXdsPa7VhKJ7/k4pYgFpmtaUYkGwj0XNA4l1P5kHexpsOCZvfLmo+MpHNEaTWL9S41+8cEKMwj+oYZSk8SeJfWjqGUdNzHp2zKaAHVMfNx6EoTOD2IKERT7DI7t52pNfv/PDoi56smgCkuO3kzXdcX0rO56gmBZ/BcOLIsYPUMZ+ni+RdTriX2TJYe8ZMQzJADOYGEJM00R7bxZEIRfw+uxLOY6AdEgZqZ2RwScvmlXmFUlriJaORwg61KQzMmkzB5CPBTsIvr7+AYcKD7PavHGAzcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YulIaPUTl7wKNKdDC8LWNf2vSBhCknGUjsKAvurkpI=;
 b=lwEVXf4xmdFEqr99d9vj0qmAItqlbfAdFFfV/tZGPc0E34WERmIOk7k5ox2Lzm4XNPcVu6buRxNt348XPPtZs4h0D8xG8Wb9PxMi85r/cBNX5WZCzy/5VdgWeW9mSSri62ri71RT3CXRIJ5Piix3M5KNRhTXpCNftmQQUYeFjk6TQ731wmqJ8Ck7BcXTr9FwNt0WWHnfATKcFvOvvL1brnnTJlmn90lyf7BBNQYG1YqgdZxIPpUM4mhSI7mQ13Ok09d9HYwreA6C7skiLJKZpaIo5N29wyM6qk8+ycXi1yDyShf5TFPOfUB0XYraAIQfnJVlVnPq+JlAgnPx84ux5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YulIaPUTl7wKNKdDC8LWNf2vSBhCknGUjsKAvurkpI=;
 b=ool5GPrhsAn4hSj0dzrXrDntplKUMcV7YYEHJa0hNY0qjGDq9QCjOEjupXhqkdRVaOLRW6XcLuQfuPbuLpL9xdJavRlWA6O0q4dPOUzxuNVTd8Mr5Xv4gpPjgJGhFdeIi40i5Ii4X0E7QbKyV9K0W0/5vjPTs8LcW9OqbfK1zNI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MWHPR12MB1229.namprd12.prod.outlook.com (2603:10b6:300:11::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 31 May
 2022 15:35:36 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 15:35:36 +0000
Message-ID: <c6e205f8-58fc-e131-e62b-42a05f9b8bc0@amd.com>
Date: Tue, 31 May 2022 11:35:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 7/7] drm/amdgpu: Stop any pending reset if another in
 progress.
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220525190447.239867-1-andrey.grodzovsky@amd.com>
 <20220525190447.239867-8-andrey.grodzovsky@amd.com>
 <e4616287-91df-9bec-9e92-3584b864acca@amd.com>
In-Reply-To: <e4616287-91df-9bec-9e92-3584b864acca@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0139.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d7b5cb1-efdc-470d-5238-08da431b350f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1229:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1229F24F2EF6264AEAF3E4B992DC9@MWHPR12MB1229.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VygmC9l/ZregNIoxSa8rbKf0mOJBAoQln1BNGLqG+hJhaJ359rTry0VHgtofOtFMyp/6cZjnH4nTpej3tg4qXWagYts4Qp6fdzpfms5/2KdrV+1RIccvpNw0NZ95Rf2vm6fyovMnUZvdlLVLdUfjAMRFzRSWKnW1q0gLIfO2mtjcxSjyKm4pCqqTQRI/DxpyDk2mdqptcNh0/5IFi4KH/o+odM5j9H8hNaVwAUmpKALZed4Bhh9GeoAgdtVmMjbSuzblYBMITFixrPXenH9gs4zRMCHgfgDAB6yoIfZVDfAHmIRxzzMdRgSe8ztbTxIZvtSqAsXuOFsmTBGsHKZdkneuXKabMROmpfDfOH6a0bMy94lMx7jLb7nsfS8KA/5oWVE1oUq/8dN3cHJF+tOXJeuDqy2UTNhUXArIFSrz60V7y+Q5L8kUX//mByjb58A2W3G3JhwSQiXslfbBn76KyTWCIOWuFARmOOerKdfHcC2WQGaY+6QfdnWyPnyTB691WY3GMU3lmNiyPkVCha92HcwX6s5eLq3QxAfSjyiSBX96Y/ajrdgXPECoGHISLznd2Ef2iK79C3v0jdA8izPgd7LytFYMnajto85s/x7a9MRjt60kYn1GlhLH1b62njjuudzr8B873BfoDAvI2hodmRt0JnyKYuvIfepqOxwNJijaAlNJkmIUDoHNWTXlf6ZmSufGxRqwmihhlJHZlYjl8/ewHUpelbF4gHMSk4hEVkQLE0XCas9lU0DIfBzpDnfU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(316002)(31686004)(6512007)(26005)(6506007)(36756003)(8936002)(31696002)(83380400001)(4326008)(2616005)(86362001)(66946007)(5660300002)(38100700002)(66476007)(8676002)(66556008)(44832011)(508600001)(6486002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUxDbWN5aEpjaWxwbHU2TWFBNjY3MUpSVXRicTBxVjNhRU9IVGtzRGhuRTQr?=
 =?utf-8?B?UC9zUjZaN3ZGMUpFQS9jMi9DVEU3a0ZQc2JZVGsrV3VqRFp1c1hpbTdDMkNm?=
 =?utf-8?B?UXRUbWFOcjJEQTkvbVVVVncyKzhLRHpoMUdjWGJtUE9ZWXduQlAwQWg2K0Rn?=
 =?utf-8?B?MGl1U1Uwd1BhendqTHZkRzVhcGE1Wm52YkNVWDdBcEM5NTlOQ25Jc3ppZGJk?=
 =?utf-8?B?NWdyNFJzaHBOZFFDYlpZQ3p0U2tHWkpoWitrRG5aTVg2Nk5uVTdjbU9jZHZ0?=
 =?utf-8?B?MXhreWl3aHp3c2VIUFdwRWxYczlFOElYSi9FTUtsM21oZGVnckVaK1F1d0Mw?=
 =?utf-8?B?MWx3US9lYUpVZzE4MVNIckFjdHNMdllqWlhNdUNucGNiakpDVHZTeFlQQlNv?=
 =?utf-8?B?SHZPbXZXUjhCd2tjbVhPb0UyNHlaeFZoK0Q3eWcyUUxvdEk2aXJxTlFLbkRz?=
 =?utf-8?B?R3lHZU1KM2lKS0l3cnA5NTFRdXVjdkJpMDRZbXhWZUVTM3ArTURzWkNCdUhr?=
 =?utf-8?B?cGNYQ2FBaDhDYXR0Y3RxSk1OS0NtRkd2azR1eStFaktac3Q1QlpucnFkdDNG?=
 =?utf-8?B?SHN1UStTUWd6SVp0S0VKK2tGNWRsSkJ3MWdCNFJYVkZVTkYxNzU4M1hhTVpK?=
 =?utf-8?B?QVVHSEx2UWd3OHBWWnAvNE1mb0ZadjdiaE4xN1lGakp1SzJ5UkprWXUvMGJT?=
 =?utf-8?B?amU2c1NLTG5lbUczKy8rUkZOcmF6UTRkKytvcHZrdXZSQzR0Nk1mRCtLY1Rp?=
 =?utf-8?B?b3UzRVovZm42TmZaZDA0RVhkQTUzSTZaY3NWYlRJRXo2ejFpeFVUV200VXdF?=
 =?utf-8?B?dGlwbjZka2xIY09zZDFlSnJwSVhLZzlENTVWbXNneXozS0tDenBvTFg2YmQr?=
 =?utf-8?B?cnZTalNtZHlZWVV2NityV1BIR2IrZmEzNlFoNlZVWlc0UDEyc253VW9CVXlD?=
 =?utf-8?B?UTVoT09qcXp4VmtZQ3FuejZpL1h3d3hNYXJiZUV4cXVsY2NmM281K3pDUEIv?=
 =?utf-8?B?bjJobE1Ec3pYc1BMa09yMHNMVjlhQXI1RzR6eFY3S2FxNEdWSDZBc243ZU5J?=
 =?utf-8?B?UFFrc2RiaXllbFdRdmVWVmRVaXJEWlZrOVJxdmRSelg1d0dDVGRLQkNLWktL?=
 =?utf-8?B?eFFjTlZBSmR1RUZRMG1ISlBZYUZSYXN3TXk3NEpZeGJOdXdXVmZlVzNua0po?=
 =?utf-8?B?QnI1b3RhWkVtb2VvQmtoNWExclN1WHNPQ2d6RURpQ0dEYmZmRk40L3ZzelEv?=
 =?utf-8?B?NE0rS2FjaENqN1UvMG51YWo1VTJsVDl5YzQ5L2J2QlJOT3BUYzBKSFMyVDVH?=
 =?utf-8?B?Z0lNZXRpRnI4NUVubjNEMlI2VjNITTgzN2xieXNLV3lwbXFKaHY2VnpUdEZR?=
 =?utf-8?B?NEMzTTZQMzlSRnIzYlJWN1RoNVFLRTBxL2U4aWtOSmF4UG1RN3d4eHVkRkI3?=
 =?utf-8?B?a3FxeHJ2dW9PWFA1NDRKQ2UzMTBSOUpGcVpGbU04VVFsVWhqQm50Y2FQaUFh?=
 =?utf-8?B?d3R1dFp1US9rTnorKzBJL1J2L0daQlVpYUN0U01Ic2NEbzg0T2ZOUDcyeDJD?=
 =?utf-8?B?ZWsxbm5YRXVDSHdqRFF0SGFIcytlM1o0Q3V1dkRIK3ZRVWQreWpqT0dvTEZK?=
 =?utf-8?B?QjU2UW8xUU42Q01TcVVuR080K2NQaE5jRS9tcHJmUVM3bzRtR2xEQjIxWWN2?=
 =?utf-8?B?ZGtaT1Z6WlBzRk9TTlRVTTZDVzdTZzNyN3dRZytZejltbUhFaTVLQU5YVm5z?=
 =?utf-8?B?SXRGVkRVZ0E3UE1jdHlUaFBXdEZQZUpXT05KSjBPZHlzVVJ6Qi9ySmRpTklF?=
 =?utf-8?B?WGN5MDZ5VjJaU09pWmsvRXVqZVhiT1JYUG1nN0RxSUVIdkJOeUhJOWVLOVdh?=
 =?utf-8?B?UXBBdjhEaG82bGVGbVZIc1dUZGFvWURrT2szbjc5UlFVMWV5cnZvNmthNWly?=
 =?utf-8?B?OHFMUzZSNUlENXFsckdkTEVqVHN4UXBaUWJvUldGTGlQMytzWUlndU0rcXIx?=
 =?utf-8?B?L25QelVVbzIrZGhTVXRzV1prekJ2aS9zc3pRd29BR1lzTzZhczF1d0lQMFJw?=
 =?utf-8?B?aUpKdTgwSzBRaWN3M0ZoV0pleFEwYVBBeVpPV2R3eEFuNzhJRlpmTHdOSExK?=
 =?utf-8?B?Q1hMK1ZldHBKakdvVGZSME1kcmNSbXFSRUJWZWNOS0NOUWs2bkdGYnh5TmZi?=
 =?utf-8?B?Yms3KzVZY0hNSXcwNkliZTdUaE5xTGpGbUVFMFVTNys4WW9UdWQwTnhUZy9H?=
 =?utf-8?B?Umx2RktVeEh3UnAvWlZyR2RHK2VJR3dHdDcwWWcvNUZvRjFkQzIwcUFVaVVy?=
 =?utf-8?B?WXorUXVZU0pwclRGcDZNRkhuT1kreUUvS3N3RFNmcklPblg3ZFFVUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7b5cb1-efdc-470d-5238-08da431b350f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 15:35:36.1283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHPWfG/k7Sd3FH6K5JT28PRhGpXID6yIxo33z6qTILuyTXkfqOw9M5VaTBo9kS4RI/X5f1DS1y7cvPTCxSYhHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1229
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
Cc: Zoy.Bai@amd.com, lijo.lazar@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-05-31 um 11:31 schrieb Felix Kuehling:
> Am 2022-05-25 um 15:04 schrieb Andrey Grodzovsky:
>> We skip rest requests if another one is already in progress.
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 27 ++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 424571e46cf5..e1f7ee604ea4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5054,6 +5054,27 @@ static void amdgpu_device_recheck_guilty_jobs(
>>       }
>>   }
>>   +static inline void amdggpu_device_stop_pedning_resets(struct 
>> amdgpu_device* adev)
>
> Typo: pedning -> pending
>
>
>> +{
>> +    struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>> +
>> +#if defined(CONFIG_DEBUG_FS)
>> +    if (!amdgpu_sriov_vf(adev))
>> +        cancel_work(&adev->reset_work);
>> +#endif
>> +
>> +    if (adev->kfd.dev)
>> +        cancel_work(&adev->kfd.reset_work);
>
> Do you also need to cancel resets from other GPUs in the same hive?

Never mind. I see this is called in a loop over the GPUs in 
amdgpu_device_gpu_recover.

Other than the typo, this patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> Regards,
>   Felix
>
>
>> +
>> +    if (amdgpu_sriov_vf(adev))
>> +        cancel_work(&adev->virt.flr_work);
>> +
>> +    if (con && adev->ras_enabled)
>> +        cancel_work(&con->recovery_work);
>> +
>> +}
>> +
>> +
>>   /**
>>    * amdgpu_device_gpu_recover - reset the asic and recover scheduler
>>    *
>> @@ -5209,6 +5230,12 @@ int amdgpu_device_gpu_recover(struct 
>> amdgpu_device *adev,
>>                     r, adev_to_drm(tmp_adev)->unique);
>>               tmp_adev->asic_reset_res = r;
>>           }
>> +
>> +        /*
>> +         * Drop all pending non scheduler resets. Scheduler resets
>> +         * were already dropped during drm_sched_stop
>> +         */
>> +        amdggpu_device_stop_pedning_resets(tmp_adev);
>>       }
>>         tmp_vram_lost_counter = 
>> atomic_read(&((adev)->vram_lost_counter));
