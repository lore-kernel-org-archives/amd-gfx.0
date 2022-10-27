Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBE4ECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 11:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77CEC10E5DF;
	Thu, 27 Oct 2022 11:33:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21AE410E06D
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 11:33:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQNutp78nV3Ky9nXWXlpOp8aEY9DpmPR4BjcvwR9myUXnc/vgmNftQT0TWCW/zoaD4bNgZ+HtknZyh78RVE5A4wgSCxAR+LlcHNfV5Eh5Y8qTB0dGBeRgnsiP/89aeBzpdeYjcWMN3jvwrgdctFxMh0l2XhQsXE69HuM0v5qf/LRvUNEBicwXJnntdtcod1ZG6hIsvf0JGAymybQU00BAlo/X6T/qnXT6DL4348iYsSEObyKDS4F3Xv25+Ui0+D9ebavN49pJghVklSjJ+9EO5fPP0F8O6JIPaZln1AKc5KoeoVZS++us5bzZNj37tdjWi22MAxIkSamVX9jixLngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mf0hQuPqMbOvZGeKdRNkyTpEUjLfVyZz1t3MtYEBIUc=;
 b=LPlQQS8BxrRvfBpW66N8C1RXcT5Wn2LVg3Ru0vtLuxn4frhohoaNI+c4acGssK0Io69jdWUz65dHQmo6YCInrZXPNW/xbQOEb6HaKMuxNfKFOMLhH/RtvrICBGEOwfcJCikupyIPHum120C7hDLztVglzXaht2LT3AWchamDX9KzlDSGgev4LQ6Q3MUyjRNgDIpm70DjcPFYc3PtbUqECUx9Kr6Kc/NNtMEaWfd+qSNe242zzoP893itT1uy5mMb9LX8J219BKSS4YAmCQEpdEWKEVKd9SQ70ldsTKuppN/9oTLAk/ITCrcnZ9VqpRtvYgDtIQBgVOKZ7m79aDCH7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mf0hQuPqMbOvZGeKdRNkyTpEUjLfVyZz1t3MtYEBIUc=;
 b=egkOLsQLPEXDoo3xPyUriZ5rfJ/pRwvANAYnTHd6r53gbq/cfga5US8ciOOQ7fghZq0cq2J67s5UCp2GOZqM13fp48D3czzKlmmJluXsbYbNGzmzUEJAotK/iP3JkFoGnwAUSzaIkp6BSV8kB9o9O9P3TzylX8wutoptdCfXj0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 11:33:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c%3]) with mapi id 15.20.5769.015; Thu, 27 Oct 2022
 11:33:01 +0000
Message-ID: <aa897a6a-c8eb-bd54-2ca6-a0188efc54fa@amd.com>
Date: Thu, 27 Oct 2022 06:32:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amd: Fail the suspend if resources can't be evicted
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <Alexander.Deucher@amd.com>
References: <20221026190355.18166-1-mario.limonciello@amd.com>
 <bd562d26-56cb-4b02-1fad-ba19eaac0b41@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <bd562d26-56cb-4b02-1fad-ba19eaac0b41@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR01CA0014.prod.exchangelabs.com (2603:10b6:805:b6::27)
 To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b2690ca-ddf1-493c-940f-08dab80f0192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K4hSf/A79X+tLQsJL4lr+wE9wcaesnEg0eUYEoGiAUbgWhshcAyeHP4ld8cmkEMiNFiwSmMQWUJPsloJ2s9CbaXta4C+/909jajfSD8maMn6kAlZCmg1yC/fmrdC+Zk8tD3IzaVxf7cP1vT+buslkrpgkCxTTlfJ2npaTv1as/Bgjp66m4+fYiDGgQsNAqftx2UpGadktCN+kYvGHm+V8LePpxZ45aBU1RIMURUOoo7CwK6TJYnr8ifZ9QdTmwr/qxzD9kKTY81clAIMPtUSo5p7tlUYCJ0vl7lGs8XBKC93RpKDaR8eFMGelHX1QV2o8q1ndpCcs12cYmInzK8PYO3tHq9xf2e2KechtQ/VOb/1yGTjgrpJxRHH/uvVMXESOTSuQSRfsSigoH4yTUI2r0jquj3EDtx6V2RMAnltqXxMEbfdKQ/UFIbxMykKDGEbqPxWbhcQTGBNcPcp6NtqHRTqpOy2SaCqFjWCJOlnm+UtCV2+/Fqexftwr3Is6R5gf0oY6+1iSjuLcLAzhRM3FtcU3VA5yWpxwwALqqn+Axh0wDWx+wtXzCsHjsyx9XVv1js3EqGWIyYxTx+yctJOdL0Ky59kanXkaV+aiKl9g5MJ/8DyvRZyEHszFmAVEgAL6qDSVxzZRXfdG2f2K2n4rSApMMzXKqi1mF22v0fi62UsEaVzwdIhHe/MrK+0h3m+jwW5LdCosz2u2G4SAcugV/NSfK96bfU35GvhNvWasVnf6oFy3KNsWjlLLv595EN3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199015)(2616005)(966005)(478600001)(6512007)(6666004)(6506007)(83380400001)(66574015)(186003)(15650500001)(44832011)(2906002)(53546011)(110136005)(316002)(4326008)(6636002)(6486002)(66556008)(8936002)(41300700001)(5660300002)(66476007)(8676002)(66946007)(86362001)(31696002)(36756003)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkZ2VGFMWGRETFZPbnZUcXZ4WTBRQkhhL0FQNGpiRk9HM2R5S2VZRnpaVmtu?=
 =?utf-8?B?anZITnFzQ1RmQnIvbkh1aEN3VmtMQXJWKzl1TFc5WEdZVzE2WmtpODIxQ29Y?=
 =?utf-8?B?amdZckVaelJDdVkycE41dkFCM0RJcmxGYUxLMUtWVU9panFXZ3JNRWo4UXk1?=
 =?utf-8?B?WGNLaERkRHQ3Z0dieHZBRXBGZ1JxdnhlUVArZVhqWkJBQnV6QjdHWTkrYmtE?=
 =?utf-8?B?dm42OXBVdGYxUS9JVktEOGoyaXkrcUN4ejIrUnFaaXJDRVlEQ2hwWUZ1SzB5?=
 =?utf-8?B?RDIyWFI2eEFwb00vT3o0VnNBMGtlcFg0czkvZVc3OEtzWmw5WG8waUFtZ3Av?=
 =?utf-8?B?TVB5dGtEVkdYTGJZL1JvOW5WRG1oWnRaUm9YRmVtTnduWGU5Mnlqamo1NGR2?=
 =?utf-8?B?VUd4MFRqeGlBZ1VhSjhDbTI0MXV0RzJJVUp0RkZtWFhSejFvNno5YzdKMWVY?=
 =?utf-8?B?ZUZ2K3FodWRHeTQzZ0x4QVR5dlg3Z0Q0TEZSb1llZjRpZ2hCNWJKakR4S29w?=
 =?utf-8?B?dFQ0eGJldDh1T3JMM2tDeCtOZ2Y0U3JaaEJFZ0U1YjN3UXQxbUttUStjN09r?=
 =?utf-8?B?ZW1Vdlo2aVRrSFFtaXJMOFpBT3g2OGxmMmhIeXV3MlB5U1V0K0JDclhRT2t5?=
 =?utf-8?B?d3ZXWVBPbXIrRzRmVVRqRVRhUXR6WUNZSG12MHpwSFJrM0FQNng0VFI5V0Ja?=
 =?utf-8?B?STlhMmRuTlJubVVSYUxBcEkyOVRGcmMrQVBudUhrZEVEc0R5QkZ0MkdLZzNa?=
 =?utf-8?B?czM3STJBNmVPaVJuNU9xeEYrVzhWVkJFUkJnYlZPN2VTZ3pjRGZja1VFc3E1?=
 =?utf-8?B?cUx6WENZdVV6cVlwNGpCVjdtS3hsYnBvWGdWbzljWmlXRHRHSFpMVjc2S0c2?=
 =?utf-8?B?emtvMjNzaStSRlZyRVFZdFBJOEZLV3lpaGNFek02R09FY2Z6dzQxMk9CSWZ3?=
 =?utf-8?B?Q2U2WFlWcVZpMDBtZEdTbDVscThVWjRTYTdjakxxeVg1RG5lNjhZQ2JPZGdt?=
 =?utf-8?B?aW80eVhBVGtiSUQvVEQxRGphZS9CaVhzdy85OW1nQmJSZUpHM0JkeGNuVFVI?=
 =?utf-8?B?b3N3MnlFS2ZhbThvTy9mWDJyLzlPSUhldjVWS0x1ZVFtUUZXN2VqeHd4dnJv?=
 =?utf-8?B?aXMyMVVVV1lEQUNMeGRyVkxpTmVYa2dzcW1hVndrN3pkSmZtV1NHdVNXWWdx?=
 =?utf-8?B?VVJ0UHNYenlSek01UlFjSlUybHJXMk11Yy9IRFlsL0Q4TFhEQ1pRUWZZaTgw?=
 =?utf-8?B?WjBzNVdSZytORS9QYWpjcVBtanVKbExMY3lCWnBmdGhhR0xsZkJUM2xBcUN0?=
 =?utf-8?B?UitVMytDNFAxK0EySjA4RlVnRi9abXFmSFhYVFQ5OVRHdWtaQTUxR3k5bG05?=
 =?utf-8?B?VkhCWXMrTFhaSklKeVFINmZ4azBzUG1oWENSQlZmVTQ4U2Z5Q0U4dGhhcklu?=
 =?utf-8?B?bkxoSmNMbHNtVithUXJxM2NxWGh3dVJVS1RHeGdhbi9IMXhLMGpvZmFGRDlQ?=
 =?utf-8?B?Snl1L01JSC85eU4xZWhSZjBpbmhoQVRWSkhBcHkwMFdrK1Q1UlhCSmlIcGEx?=
 =?utf-8?B?dEZPdHJHdk80aVdBYXJLSG1MUTN2aDg2YWp6Szk4R09OZklDSnZ3UDJRWlcv?=
 =?utf-8?B?aE9MNGNJeC8xYjNMN1N1Rm1SYjI5ZjdtR2xNd3V5dUpiT3ZNY1F5MTgwQ1Fh?=
 =?utf-8?B?Z1hEQ2MybXV1Tlk3WWs3UzJrdWZGNEVTeXVwM1lWWXlBNVBjRm1tZzd1NUpF?=
 =?utf-8?B?c0UzYTBhcWFjMlB3MnVKRmM0SDRGRVJLdnRyRWpKYi9iZWdxL01BQlIwbVRW?=
 =?utf-8?B?YWJJdS9YYWFnNkVFM28rOTBLb1JJcFlCSVBDVFh4WU1FNFhpY1JRY2ViTUdJ?=
 =?utf-8?B?NkM0N21PSlQwb2NPWmZaYldqbWMrNDk2aDZSbnMxbU9VcGhMQVVsaW15WGNz?=
 =?utf-8?B?QjBEekVuVUh2UWlWZWlGWkV1S2tzOEpVTU40VlA3L2dLWHpPVzdyMTlPb1Fy?=
 =?utf-8?B?bzZLS3Zib2U3UHVGbUZjSjRtbDY0VUd3cWpLRE9jTk42SzlQNXlRWVdrL1Ji?=
 =?utf-8?B?NEtReFBZK2pMcXRsbUVEVWZ0OHhxbkNleUJuODYyL0RNRkYvenhRN0IrWjdM?=
 =?utf-8?B?UkxGR2hqby93ZFUrc3RSTk5Hd01HYkxaamxOV2pHRlVLUXkzL1EzWDFtbnl4?=
 =?utf-8?Q?pPtrkAPaIIUDsRalzRsZm4EXw6TrxplDSZPAmNlyLq56?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2690ca-ddf1-493c-940f-08dab80f0192
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 11:33:01.7999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2N+acaR+CI9ZoV3AHUctqCEbFvZGkg2lCK2tPVYD0DbGvg2yxTBJkbbaGOjntFBKWNhJL0/3UcoAzMJ1xdekYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
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
Cc: post@davidak.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/27/22 01:30, Christian König wrote:
> Am 26.10.22 um 21:03 schrieb Mario Limonciello:
>> If a system does not have swap and memory is under 100% usage,
>> amdgpu will fail to evict resources.  Currently the suspend
>> carries on proceeding to reset the GPU:
>>
>> ```
>> [drm] evicting device resources failed
>> [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of IP 
>> block <vcn_v3_0> failed -12
>> [drm] free PSP TMR buffer
>> [TTM] Failed allocating page table
>> [drm] evicting device resources failed
>> amdgpu 0000:03:00.0: amdgpu: MODE1 reset
>> amdgpu 0000:03:00.0: amdgpu: GPU mode1 reset
>> amdgpu 0000:03:00.0: amdgpu: GPU smu mode1 reset
>> ```
>>
>> At this point if the suspend actually succeeded I think that amdgpu
>> would have recovered because the GPU would have power cut off and
>> restored.  However the kernel fails to continue the suspend from the
>> memory pressure and amdgpu fails to run the "resume" from the aborted
>> suspend.
>>
>> ```
>> ACPI: PM: Preparing to enter system sleep state S3
>> SLUB: Unable to allocate memory on node -1, 
>> gfp=0xdc0(GFP_KERNEL|__GFP_ZERO)
>>    cache: Acpi-State, object size: 80, buffer size: 80, default order: 
>> 0, min order: 0
>>    node 0: slabs: 22, objs: 1122, free: 0
>> ACPI Error: AE_NO_MEMORY, Could not update object reference count 
>> (20210730/utdelete-651)
>>
>> [drm:psp_hw_start [amdgpu]] *ERROR* PSP load kdb failed!
>> [drm:psp_resume [amdgpu]] *ERROR* PSP resume failed
>> [drm:amdgpu_device_fw_loading [amdgpu]] *ERROR* resume of IP block 
>> <psp> failed -62
>> amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_resume failed (-62).
>> PM: dpm_run_callback(): pci_pm_resume+0x0/0x100 returns -62
>> amdgpu 0000:03:00.0: PM: failed to resume async: error -62
>> ```
>>
>> To avoid this series of unfortunate events, fail amdgpu's suspend
>> when the memory eviction fails.  This will let the system gracefully
>> recover and the user can try suspend again when the memory pressure
>> is relieved.
> 
> Yeah, I've been thinking about that handling for a while now as well.
> 
> Failing to suspend when we are OOM is certainly the right thing to do 
> from a technical perspective.
> 
> But it also means that when users close their laptop it can happen that 
> it keeps running and draining the battery.
> 
> On the other hand when you don't have swap configured it's your fault 
> and not the drivers. >
> It's a trade off and I'm not sure what's better. Alex any comment here?

There are userspace means to handle this (such as systemd-oomd).  If we 
actually fail the suspend and can signal an out of memory error code all 
the way back up then it can work with the oomd processor to make some 
room and try again.

> 
> Thanks,
> Christian.
> 
>>
>> Reported-by: post@davidak.de
>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2223
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 6f958603c8cc2..ae10acede495e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4060,15 +4060,18 @@ void amdgpu_device_fini_sw(struct 
>> amdgpu_device *adev)
>>    * at suspend time.
>>    *
>>    */
>> -static void amdgpu_device_evict_resources(struct amdgpu_device *adev)
>> +static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
>>   {
>> +    int ret;
>> +
>>       /* No need to evict vram on APUs for suspend to ram or s2idle */
>>       if ((adev->in_s3 || adev->in_s0ix) && (adev->flags & AMD_IS_APU))
>> -        return;
>> +        return 0;
>> -    if (amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM))
>> +    ret = amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM);
>> +    if (ret)
>>           DRM_WARN("evicting device resources failed\n");
>> -
>> +    return ret;
>>   }
>>   /*
>> @@ -4118,7 +4121,9 @@ int amdgpu_device_suspend(struct drm_device 
>> *dev, bool fbcon)
>>       if (!adev->in_s0ix)
>>           amdgpu_amdkfd_suspend(adev, adev->in_runpm);
>> -    amdgpu_device_evict_resources(adev);
>> +    r = amdgpu_device_evict_resources(adev);
>> +    if (r)
>> +        return r;
>>       amdgpu_fence_driver_hw_fini(adev);
> 

