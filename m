Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B7EC6FA83
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 14:48:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE14110E396;
	Tue, 27 Sep 2022 14:48:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B001010E396
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 14:48:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrSxEJhD03FqdRJsQ2jgzPe0afVUUNSrKv9jJ64hRon7gMzMGLk6CbKa4ZjICFi8UiqDC5XG3oe2zh9lV/ONijj3uDXIWTSmq+8xAdD0WvrMSqnot8HzBJtLZJFKlXMnuNHlHpMm5xYmKFRtM7Sjs6dB8lFT/s/Namx8FGyExMruJbtE+c97agEi0Ad2hwIeRdM1ixJt8BZY9Fe8J+GsShEtQqCjou1HF04u+eds1Mzjidmd7Gjm1woDqAs1AgVlQo9FlWH6kxKaEUY8GcJEnbWwQdyAfdkBYlOyVbRAy/cXhDLqWFv9Ud3+C/PgzDQfJzqtJJJaUwuPzMpUp7Farg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oivPQUg+5wGcj1Bc0fR4srU7H3Qzb6hoVARnJ++v6Ck=;
 b=JIRXi7/6FdfaOUEZNWI3bgQruw1xvJza/BAJklHI6u2XPOwzU5J96dKdjKyq7/ExQiGOgWUg+X48nLdKRK6ycqpZQfsWULrjWZi1of6Db0WFJjrZWWfm7H79DyhokGPBLDiojFTK2fFIpqeVh6AnxVGUlD23qRdAb4dIqanuJIko8tPJD3Cytk5uGAxHEhnFlDeVU/K8897dc2WIKBE6yZmSWb2Sc2FZELnDfAVAODtLDO73BTsGkdAC9RjUTycnhugVbcfmKnO90MsILCE4DRerAUfWDig0GQ4kJRICQqir7tqT5FFasWoKheSOhq20gU6af+uI3lsqW6dJw2vGhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oivPQUg+5wGcj1Bc0fR4srU7H3Qzb6hoVARnJ++v6Ck=;
 b=HE85tHDML1H+y0VTLQgqG3mX1xnp1wCxIMxjTsIqTmcJpKjEQItY+MeCKFuXbKNFwuJC5CQU14/fcyase55CvxjHjRJHbgvcLreHaLVPsu3pmJDvODj3WV5vfPS8E75gxGuMc7HYHb+RRAIvp1ERQL/glYV37aGyC2qbZKx3s44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4309.namprd12.prod.outlook.com (2603:10b6:610:a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 14:48:49 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5676.017; Tue, 27 Sep 2022
 14:48:49 +0000
Message-ID: <aa663a5a-3bc4-393e-ff4b-73e3247e79fa@amd.com>
Date: Tue, 27 Sep 2022 10:48:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 5/5] drm/amdgpu: switch workload context to/from compute
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-6-shashank.sharma@amd.com>
 <6a0d7dea-8c5e-701d-9231-d6f76df76706@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <6a0d7dea-8c5e-701d-9231-d6f76df76706@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB4309:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0fe220-e38f-4270-503f-08daa097633b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0HSFuM3MYPfEJ20G4WUGg5sa2Ot/aMJJIu+btvIa6jojA03M54dQB52l39wAWXIJ9etnTsZA9+bZ5rNmvzkwasMJmns6wXH7kUDrrIR0w1lFSf2P/VywRNdeRX2ui/ND1vcU6ycw5rR2yM+5KlS+0btoXLT/ofEBAijLgMBkN/m/PmRMpaBKU5ZwD81T2Ot/PX2bi1GymQqGyM1amMr4PX7pWwxjgzX5Ge8ls7GqL8lDiX8AX4QgNvPhQUuNZ0bXMrHfvaeWBOyuPwge7y1q6o6yL5jjXdN9ljgil749Sp7vD9eJ1HWwEj/0tjwPcG1PF/ZjhV23FR2VqI6t6JBHJCfZeeU4lS/PTYQhd+L9pvKSJgwLCBOVA+sfDVNXGW4Lpz4uz4+tXRpIoGZUc/dlbaYdVToKa05cPIZKhlGeZhshdsCjBKIHSnpkSdVEMTn60lEPssj0n5lNKRrA2DVTPU8p8o4evLQ3cHrSUaY+6/wZa+qATe8EyphekPrGhXpsaBXOd+q6WpHKMBqFMZRmcyGdliITlfo0rGVtGyeKHG8Ppy/zEGTlYFaWiCsnBcUnoLGdpWdv+lbz3TO1zvalJrE1AeCINdaq/n7U5hnsa0a84vK9N00Jp0MTxpDCcVDHc7C/y8ISReCl6+UYlHtSm3doEr2PElwKJAmPea/znmlzBbczO6IJr/xhvOrh4QJ7wLzH/lq458TVdzmjRxX2R/37aCTGOVZN8EnUScvydPmsQcgVEyCrxj6vu7/GKeEHYaJi89yhpz24XBoRoeexIGwDskprtsnCe1HSIhWwlsg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199015)(41300700001)(66476007)(4326008)(6512007)(86362001)(26005)(66556008)(44832011)(66946007)(31696002)(186003)(2616005)(5660300002)(8676002)(36756003)(2906002)(8936002)(6506007)(478600001)(38100700002)(6486002)(316002)(83380400001)(110136005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUhlYjA1ZXRMK25MN2huYmFlZ2g1cjdoOHZ3cm12cEJzdnJBeVNvYkZ1Kzli?=
 =?utf-8?B?S2hXUEhjSDBXSmtZRndKWGV0MUZCQ012SFRoYTJQaS9oU0hSTlFKcm1pSjE2?=
 =?utf-8?B?ejNReWY5WExXNTZ3YW0zaXQ5QzJCdld2OVJvMUQyYWx3QWl2dVY5dVdnQnhr?=
 =?utf-8?B?WmpaVmFPNVJ0ekZYVTZtY2FGdmIvd2FzMWV0STFvYWFZWEwyNjVTaXRzTzBC?=
 =?utf-8?B?YWMxcGhwSFIrb1pUalFQNG0zMG1xd2ZmWXZVOUM3YmZpN3JiaVpmdFdOYkhB?=
 =?utf-8?B?bkVxSWhSMHRETDhINDZ3U2NiL0hPeUtaSGEvenlFN25BL1dTWlhEZlFBREtq?=
 =?utf-8?B?dFB5ZG11Tjg0SktVRHBGL2RHbXJucDJJZUNTTVJJbmNqRXFqWWg4aS9iVmVo?=
 =?utf-8?B?Q0c3T2MzTVpyVm56ME5hSko1czJPamZzc05JQWNleDFBU1NBb2RvVHQzT0sv?=
 =?utf-8?B?ZVhsMVhPSmRiQTJzd3MzNVhJcThFSHVZNTh5a2N1VFJua3FCQ2NBRFBLTjFZ?=
 =?utf-8?B?R1pBTFFmc1VpMUs2QnJYSlJWUlFzUlFZY25VKzk1UWZVK1lsRVRUOUxtdjJs?=
 =?utf-8?B?dzNRcXlpbVdPaUhhb25kelNRUG00MUxLRjhjbTgyZTgzMW5UaDFjUm9Cdmg2?=
 =?utf-8?B?ZDVCYUowYjdESndSZHBIaGJtTEowd1pQZURZSHdwVGhVNjhxeXZUckhPN0hT?=
 =?utf-8?B?MlVnL2phci9oQzhrVkZSMC9vS0hxRUdhZEZxbG9ja0daMzMzZCs0d09LVVU0?=
 =?utf-8?B?ekUzcmV2cGwvYXY0emphRklzZDE5M3ZCN2NwYmw2L0FybmM0SmtXMlZNeEZz?=
 =?utf-8?B?U2ViZDdxTEVRbXQrNldtVHVnSmtnVjlVSC9mRjk3Rlp5MHh2dDE3bm9VVmNK?=
 =?utf-8?B?Q3o1TjhMd2ROc0tQZkNtY2dyNDRKVkhaQVR6ZEZzMWo4R3pRU2R3U0tQWHhJ?=
 =?utf-8?B?enJMd01ZWEJQanFxR1M3UGFnR1IvSGdhY2VZNDdTQ3dMSWdUMHRYQ0RXM1Bz?=
 =?utf-8?B?UDNFdW1naU9lK0Q4eVltaXdsRTFRM0h6S1B5R3ZOV2VNVE5wMHU3dWpEZXo5?=
 =?utf-8?B?WksybUdweVBqRVBvYW8xSHMxUlFtR3JJNmJpdGpnWm1CckZhTlltY1FtT2RB?=
 =?utf-8?B?cnhCd3JEdzg4QUJvRmExSEJoRW1Feml0V29OWjUzNkdGa1VRZ01DS0FIeDFC?=
 =?utf-8?B?V0RiYVJvWWQ5bUx6THgvK1Y4anV5ZG1KRjE3eVVrYUZnaXZ5Z1B3MS9sY2FL?=
 =?utf-8?B?S0FtTDY4VWd3RURSdG5QNVR3TnBPLzk4OU5tcEcvd0hEWWpURTNaaWU0Tm5Q?=
 =?utf-8?B?NllwalhxL3FQbXljNGx5V0YrbjNmNXpPSXFsbS82R1VJcy9laDQ1QjJuVVdM?=
 =?utf-8?B?Mlh4cEQwd2JtTG9VNEpvdTlobTZ3WnhRcS9DMXlVWm5IVGJBdW8yenZYanU4?=
 =?utf-8?B?STZveDQveVRaYVl2VTh0elhYVzNkaEM3ZFRYS3BQN3ZLNlphdWxFY0xpeHhR?=
 =?utf-8?B?MXVyNk1ObWMyVXB6cDJsaFBTYTA4aDhXdTAyNHozMDJRajBMYUxCTXBzckFm?=
 =?utf-8?B?NHlySWxhdUlhN0VnR0hpU1VUaVBlZWIxNDY1cHFnMTR4alZXUWVMMUdjTVZM?=
 =?utf-8?B?N2hVVXM1MmFvWHJUWFdzWlhWY0dCTTJlL1FBWXh0Wm00RjNVRU5uMVpEV2ps?=
 =?utf-8?B?SktwMU9sWDFYMTdZRklhb1orK1F6VmdKMjhEQkx5Y3pMbmw2dVY4cHBmMFdp?=
 =?utf-8?B?d21kUkU5VVNZbnYzOHplMjVyNWxFK2FPbEpWQ1ZWelRSeXpPOXFTSjdkeERP?=
 =?utf-8?B?Q1VZUGlES2hxM3A5RkJBeEFVNjRqNjJpdkl5TWUxcjdXeGdwdFVvUXNNODNm?=
 =?utf-8?B?dXpkTzZHOTdnUUo3MXBLb0VNTm4xYkxqbUEwMUh0THVrSzV5V0E5Q1hYQlg2?=
 =?utf-8?B?U0ZENnpraHA3QjBQYzFwUHhoZkp3anBTR3pDaVNXUlhQNlpsLzIxbmVzMjdC?=
 =?utf-8?B?ZWlDd2haSit3eVNOS1U2c0k4bnQ1ckF2TkZ1dGMzMXZHa2RzU3VpOWVWOWJz?=
 =?utf-8?B?aTJKTUp2UElDZER5TlYzS1g1cCtES25wM1orN1lyK1VPNk85MWJ4cXlLdUxB?=
 =?utf-8?Q?JxdnxqUQ/JY86efUxikU/Gr29?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0fe220-e38f-4270-503f-08daa097633b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 14:48:49.3089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/j75TBywRsbbxvrakSZ8h+Udb9u8SFaepm8HjwaNp5Sn0mqJfOwOBWy0YuQRVEwrVv4u7Jzx5/Cxv7u7hmArA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4309
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
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-09-27 um 02:12 schrieb Christian König:
> Am 26.09.22 um 23:40 schrieb Shashank Sharma:
>> This patch switches the GPU workload mode to/from
>> compute mode, while submitting compute workload.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>
> Feel free to add my acked-by, but Felix should probably take a look as 
> well.

This look OK purely from a compute perspective. But I'm concerned about 
the interaction of compute with graphics or multiple graphics contexts 
submitting work concurrently. They would constantly override or disable 
each other's workload hints.

For example, you have an amdgpu_ctx with 
AMDGPU_CTX_WORKLOAD_HINT_COMPUTE (maybe Vulkan compute) and a KFD 
process that also wants the compute profile. Those could be different 
processes belonging to different users. Say, KFD enables the compute 
profile first. Then the graphics context submits a job. At the start of 
the job, the compute profile is enabled. That's a no-op because KFD 
already enabled the compute profile. When the job finishes, it disables 
the compute profile for everyone, including KFD. That's unexpected.

Or you have multiple VCN contexts. When context1 finishes a job, it 
disables the VIDEO profile. But context2 still has a job on the other 
VCN engine and wants the VIDEO profile to still be enabled.

Regards,
   Felix


>
> Christian.
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index 5e53a5293935..1caed319a448 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -34,6 +34,7 @@
>>   #include "amdgpu_ras.h"
>>   #include "amdgpu_umc.h"
>>   #include "amdgpu_reset.h"
>> +#include "amdgpu_ctx_workload.h"
>>     /* Total memory size in system memory and all GPU VRAM. Used to
>>    * estimate worst case amount of memory to reserve for page tables
>> @@ -703,9 +704,16 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device 
>> *adev,
>>     void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, 
>> bool idle)
>>   {
>> -    amdgpu_dpm_switch_power_profile(adev,
>> -                    PP_SMC_POWER_PROFILE_COMPUTE,
>> -                    !idle);
>> +    int ret;
>> +
>> +    if (idle)
>> +        ret = amdgpu_clear_workload_profile(adev, 
>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
>> +    else
>> +        ret = amdgpu_set_workload_profile(adev, 
>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
>> +
>> +    if (ret)
>> +        drm_warn(&adev->ddev, "Failed to %s power profile to compute 
>> mode\n",
>> +             idle ? "reset" : "set");
>>   }
>>     bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
>
