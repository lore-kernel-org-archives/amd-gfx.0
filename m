Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED59EC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Nov 2022 16:23:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5589010E0AB;
	Thu, 24 Nov 2022 16:23:58 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58B5610E0AB
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Nov 2022 16:23:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2GYymo0/FktIblYGIMWwQV8FB/ut/GLUI8JJOJHzT77sXPTW8ccebK9IXCExyVu5Kez0mlguvETr4GPGFAXfnSmJvLTb+09g4x4vXwoPGPSuKAy9a61YGIQoTFQJ4EOrE9gzC0HTwzc0h/TTN+6mjDkrdhjYmnhYC/kInjeu8i1MDRQDhG1JFT5O59jQ/2d/VW6DRiIaFBxdyIb4DeJlKwUKxF3ZYeBPndsjVZ6MXlC2n+m5Hl8qg+cjkfiLSBbninUUzqWJLxFEOUqkYDK0x6MIMH2goueldxyU6yIafCQeo7NX3OfItnRNcU9f88wmGh1bVWIW6NleQOocLW7yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9xf+RL8IuV9fP7nGptb3eUVPvDbQbPtM37CFZ1VZN8=;
 b=B9I41JgnU+fU8gqYifwk+usDm9kf8fxECQdIPnQ9xYfKS96xJI0AJVcaDbIvb8WGvVcuHmbXziKmgtLSIlU9dDADLnKFl8m3jqzjWstu15F3lM8V+ALAyPEwMnVis4xbx3JD7EKxn7t1QPh2VSqqJFAj2ioXVXiV8yLM1sV0XPH8cAfHbAL/buMPfxcDNEkHYslMwYPxai86GpiovfsmMRTUBuwtPMs6ehhiJGFsLNrTkrKHEpbP2Uu3D131OOp6C3HiXS52lj7Xjpgx4mxEzfvG0YXZ5Ggb4rcYrY6DSNP5FEI2RVCP7PfIq1NGMaUmQc6kF3wbnqhdN4WYEx88xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9xf+RL8IuV9fP7nGptb3eUVPvDbQbPtM37CFZ1VZN8=;
 b=ttBQpeDDcmd/PFpGLcxz69mRkXQG1M0xegWePpxMH72uvTVLApddj8/KeHyuljrNWfQ7/x0GHfuKppMkvaMtbZv1n7wXja7hjPzlXIpawk/TkbKskEvE7Lmz5hXWV6lTTqmzCJrZgp+UBKKtQ4KxOJ9vSXhNccMUXyXRRDUI21c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB7916.namprd12.prod.outlook.com (2603:10b6:510:26a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 16:23:51 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5857.019; Thu, 24 Nov 2022
 16:23:50 +0000
Message-ID: <33720c70-4d99-1c6e-0ab9-8b48b6e8238e@amd.com>
Date: Thu, 24 Nov 2022 11:23:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 17/29] drm/amdkfd: Add debug trap enabled flag to TMA
Content-Language: en-US
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20221031162359.445805-1-jonathan.kim@amd.com>
 <20221031162359.445805-17-jonathan.kim@amd.com>
 <31f90d88-1db5-756f-02f7-456f721e9899@amd.com>
 <CY8PR12MB7435CEDE4322CDF570C3C2E8850F9@CY8PR12MB7435.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <CY8PR12MB7435CEDE4322CDF570C3C2E8850F9@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1P288CA0002.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::15)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: 6823346d-f840-487e-bdae-08dace384575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qnFKzg00c0KiH9OSi2jUoZHBzHm9rdxS93R/BgF9QagsEpJTPSEDUqqmWoJ+ynrNeuTV9Hc0jxoJcVb5hI3IkfcFGI7yK/qWiufMXKzZj2W3O9xvZr4fuDzWGnwq05+P5UlsH+Tt599ZUrkZhAX8LLqMal58HuwHGaS1M1ajZc+fEKKS7vjtH01Pdlqeran4xeVrvbhourpAdeDXmgs948TE/7aJisbnGAjejBobK0CGmIyDreMz3Z05MIlSLnqptZ0NypvPm1MU16KwLhvUqYw4ImMt1hTQAeVLpp8NFXimIhqALIif1hJe9bealAs2XKA2tsqS+2QBD7gPc8Vq2vUtI1Oz9aaIls4i6Hw2PB+M7CUy5vvmd1FCW2exJqhlZ3/C2Sxd6J4/OItFpooqEybXkzlaCj35/UBhD0S6oyK1s3SYHBBzp9gSvff7tgLlphf/G41Y1HJmxDIYQRdeFTLZvkCCci9D6HEPbHcxpPL+kGFebBO0zOA9nZ8q4GmpORk0ws147DJ7mF2K+VCCiqSApndBKY979IVt4j5B3KLVWgKFimpeeBaGcu613T+Btkk6KO+IxlNMwyGzHhq2I5TbuPEpbq/bi/pneU0GZMfNAl3zUSIkYdrnpzYXFBeGjA5TB3Andj/wtQAazwYoFhOTa7jkeipOUMjFMzHP3vXMMN/Aud06+ORgUfSXWWFaM7c6NNC6/41sIJtJFdBPpHTayjCqepqcqWVDKSsytHU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199015)(6512007)(26005)(36756003)(31686004)(110136005)(38100700002)(41300700001)(8676002)(66556008)(66476007)(66946007)(86362001)(31696002)(6506007)(186003)(2616005)(53546011)(478600001)(6486002)(44832011)(8936002)(316002)(4001150100001)(2906002)(83380400001)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUZJaXN5TlRIT0p5Uk9MQlg3bmlHSkNBMFdUWkVHeFd5S0tzOHc4Vnc3dEIz?=
 =?utf-8?B?RnRGdFhYNHJCc1JuYW96OWlxcHkrd0hYcFBXN1ovc3VYQ0gwWVpiK1BHWExk?=
 =?utf-8?B?d3g4TXBvSC9hLzBNSC9BRitYQlQ4eGp3cHFGaW1TQTcwWXNqOTBhdTRFcXRL?=
 =?utf-8?B?WjBHTnFmTHdBcE5IdXYxWVVyWnN4ZU4zZ25nSkJpU3pqbGIvZExrcmpTdStC?=
 =?utf-8?B?QlpPYm1XVmJWWE9XbVlzL3czSTBNK0pnTDNtQ1ZSU2pHSGZ2dVZkcU1pSVFV?=
 =?utf-8?B?MGdiNUNvRWJJYnZISUVXa0xTRGZLNWFJZ0Z4YU04MEVOdGZEVzJXZUMxUEgv?=
 =?utf-8?B?ZHFMSEt5cmE2TzZmeDAxeE16WTRudlZUNkxQWWRNZkpvOWtacjdjelVVWjVr?=
 =?utf-8?B?bElWbzJFek11aVB3cGozQVFzUmpCTjhEOWhiVXRTenUrVVhBbkNqcFllR1V4?=
 =?utf-8?B?S2g1SzZTWFpvNFNzeWRsVDZIcytiVUMwY2VOQmtBaHRNMkVxYXZCRjcvQ05P?=
 =?utf-8?B?TGhkMWdqWEIxd3RwbUcrcVQ0YkpMSmZKTklmTG9TZ1hsalpjUkFuMVpUeS83?=
 =?utf-8?B?RjJCVkJwU3NHNFZ0cS9iVDNWaTZJZm9oNU1CdjBxRzlEOHVyVSs5aGdhTzcx?=
 =?utf-8?B?N0xtbk5qanYyY0paRkZIMFVWL1N3c0FLZHlHTFhOMzFTb3RGYnY2dC8vb2Z6?=
 =?utf-8?B?cVQxc1dGSGI0Wlh4R2c3QzhZUzk5eFlwUHE2NzB0cS9ROWlJaTcralcvTDR6?=
 =?utf-8?B?RFVaM0pKaS96YnlNZnEzSlpkMDluMy9wUDlINk56VTVhekhaQzhkdzVMQUha?=
 =?utf-8?B?MDFBd3hnNHBLWFErWmRwTHRyUjhTNGgveEw0aGozTS95SWNZOE1ROUF6c1FU?=
 =?utf-8?B?Z0ExMGdTRkFQYUJZK2tqdStoRDdIU1N1K3BHUU4ydHpVZDIvTFk4c3hHaFlB?=
 =?utf-8?B?UlF4U3VMMTU0WFBsaGNNcmNnNkNYR3pSWkFlUXRRRXpzV1FUSmlHMXJ5aGNQ?=
 =?utf-8?B?YTVZMHJFMDRjSmpnTmc3YTlBUGR6eTI0NmFhb3M5RStWVjd3MzZPNDNQbllW?=
 =?utf-8?B?S2tJT3FOdnlRajQ1Yng4M3l6dW54R1g2RndUNXl3SUNzcDlVbllXNmVndkRp?=
 =?utf-8?B?QjlVYnN2Z2tSUGllcWNiaGY2THpKTkNSWm5xU2UrSlF5LzAzLzNGZnUwQmlK?=
 =?utf-8?B?eWF6d21sUEtjWi90dmh4THYzNW92RG91NDhHcFB6TnkvVnliMzJvWUh3K2V2?=
 =?utf-8?B?MUVaUlhUU3piL1ZXaTdjR2IwaklJWWpqK25ja0xJc3RqS3ZaRTc1UFRvVWIz?=
 =?utf-8?B?eXBOYjZtbERVbm93SGRLM1ZLeWU1elpGTVJWN1E1aWN5bzArbmVrdnRWSHFy?=
 =?utf-8?B?TXlISHhjTGFkQ2gyZUgyeG82Q1pRbXNHQURZYTA0b25yckpvbVJaY00rWEk2?=
 =?utf-8?B?M0I2a3dVenh5NGw0ZzJ1WHlxbU1uMXlUZ2Rhd25ERTVXd1h0WHd1VjJrb1Zv?=
 =?utf-8?B?ZlNMb1ZBWW9sYlhCWTcveDFWSHdkd1hLNVB6bFNjeGY4cmMvMDcybDE4UUpy?=
 =?utf-8?B?SzJ1d3RhWmJvZXJGY0dzUmxMOE5xT3lSOStyZ2ZwQWd0b08yRHV1UU9EMStQ?=
 =?utf-8?B?L0hodVB2OXJueVA5eUVSSjRseC8vUGpENlVkMUxiTmFyMWN2eTVkWnExR2ps?=
 =?utf-8?B?OWJZMnhDeFMzakxZV2xYQ0xmUGZML2xNRjgzMlU0SEhvOFkreVkzZE5lVHhV?=
 =?utf-8?B?bDZBRldEZzRUb3Rib2M3T3Q5dVRENEpESzBuaTRPZXV1SlpQbXIwZlRaZWFZ?=
 =?utf-8?B?c1ZMRlhwUVVNeDRZWVNSNjZwdmxtTnMwRHNHS3BiaGowM3JhNWR0NXNxeTZu?=
 =?utf-8?B?UEJ5dUVsdEZiTjFmcXdpeDlZRE55VTdHK084R3lhcTVpcDM5VGwzMFUxc0V2?=
 =?utf-8?B?UHQ5UGFTNk5IcnFXdW1oWENDNHNGL01PZ3JEK24xQ1NtdWNhcTRobEsxd1BC?=
 =?utf-8?B?SHA3NjVVcFdQSEJnR3V5cWdpM2VxVWFveThsQXcvQ2tyOGt4Q3lJMlZ4eGdY?=
 =?utf-8?B?alFWM1pxcVpEY1ZnNlFjMU9kRE1WaXRrZlptZVBkb3VSTTFXUmwvZmR5UlRN?=
 =?utf-8?Q?9zek27EX5qzC0A7NN5viLI8z8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6823346d-f840-487e-bdae-08dace384575
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 16:23:50.6743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOzddvzIqtSvEZQ8GAjSChXq4XmeKyql63qwmBQYC0BlBU0wNLjrcu7DxN6vRU/V5McNu9zDl6DmgLVrWd00Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7916
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


Am 2022-11-24 um 09:51 schrieb Kim, Jonathan:
> [Public]
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: November 22, 2022 7:45 PM
>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 17/29] drm/amdkfd: Add debug trap enabled flag to
>> TMA
>>
>>
>> On 2022-10-31 12:23, Jonathan Kim wrote:
>>> From: Jay Cornwall <jay.cornwall@amd.com>
>>>
>>> Trap handler behavior will differ when a debugger is attached.
>>>
>>> Make the debug trap flag available in the trap handler TMA.
>>> Update it when the debug trap ioctl is invoked.
>>>
>>> v3: Rebase for upstream
>>>
>>> v2:
>>> Add missing debug flag setup on APUs
>>>
>>> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdkfd/kfd_debug.c   |  4 ++++
>>>    drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  2 ++
>>>    drivers/gpu/drm/amd/amdkfd/kfd_process.c | 16 ++++++++++++++++
>>>    3 files changed, 22 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>>> index ae6e701a2656..d4f87f2adada 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>>> @@ -193,6 +193,8 @@ void kfd_dbg_trap_deactivate(struct kfd_process
>> *target, bool unwind, int unwind
>>>              if (unwind && count == unwind_count)
>>>                      break;
>>>
>>> +           kfd_process_set_trap_debug_flag(&pdd->qpd, false);
>>> +
>>>              /* GFX off is already disabled by debug activate if not RLC
>> restore supported. */
>>>              if (kfd_dbg_is_rlc_restore_supported(pdd->dev))
>>>                      amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
>>> @@ -278,6 +280,8 @@ int kfd_dbg_trap_activate(struct kfd_process
>> *target)
>>>              if (kfd_dbg_is_rlc_restore_supported(pdd->dev))
>>>                      amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
>>>
>>> +           kfd_process_set_trap_debug_flag(&pdd->qpd, true);
>>> +
>>>              r = debug_refresh_runlist(pdd->dev->dqm);
>>>              if (r) {
>>>                      target->runtime_info.runtime_state =
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index 9690a2adb9ed..82b28588ab72 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -1101,6 +1101,8 @@ int kfd_init_apertures(struct kfd_process
>> *process);
>>>    void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
>>>                                uint64_t tba_addr,
>>>                                uint64_t tma_addr);
>>> +void kfd_process_set_trap_debug_flag(struct qcm_process_device
>> *qpd,
>>> +                                bool enabled);
>>>
>>>    /* CWSR initialization */
>>>    int kfd_process_init_cwsr_apu(struct kfd_process *process, struct file
>> *filep);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index 59c4c38833b6..d62e0c62df76 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -1252,6 +1252,8 @@ int kfd_process_init_cwsr_apu(struct
>> kfd_process *p, struct file *filep)
>>>              memcpy(qpd->cwsr_kaddr, dev->cwsr_isa, dev-
>>> cwsr_isa_size);
>>>
>>> +           kfd_process_set_trap_debug_flag(qpd, p-
>>> debug_trap_enabled);
>>> +
>>>              qpd->tma_addr = qpd->tba_addr +
>> KFD_CWSR_TMA_OFFSET;
>>>              pr_debug("set tba :0x%llx, tma:0x%llx, cwsr_kaddr:%p for
>> pqm.\n",
>>>                      qpd->tba_addr, qpd->tma_addr, qpd->cwsr_kaddr);
>>> @@ -1288,6 +1290,9 @@ static int
>> kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
>>>      memcpy(qpd->cwsr_kaddr, dev->cwsr_isa, dev->cwsr_isa_size);
>>>
>>> +   kfd_process_set_trap_debug_flag(&pdd->qpd,
>>> +                                   pdd->process-
>>> debug_trap_enabled);
>>> +
>>>      qpd->tma_addr = qpd->tba_addr + KFD_CWSR_TMA_OFFSET;
>>>      pr_debug("set tba :0x%llx, tma:0x%llx, cwsr_kaddr:%p for pqm.\n",
>>>               qpd->tba_addr, qpd->tma_addr, qpd->cwsr_kaddr);
>>> @@ -1374,6 +1379,17 @@ bool kfd_process_xnack_mode(struct
>> kfd_process *p, bool supported)
>>>      return true;
>>>    }
>>>
>>> +void kfd_process_set_trap_debug_flag(struct qcm_process_device
>> *qpd,
>>> +                                bool enabled)
>>> +{
>>> +   /* If TMA doesn't exist then flag will be set during allocation. */
>> I would expect a change to the TMA allocation function, but that isn't
>> in this patch?
> The TMA is allocated under kfd_process_init_cwsr_* and CWSR enabled is a pre-condition for the 1st level trap handler loading.
> The lack of context in the patch for those functions may be hiding that fact.
> Is the placement of this comment misleading?  Maybe it should go in kfd_dbg_trap_activate when kfd_process_set_trap_debug_flag is called?
> Or should it just be removed since the combined calls within initialization of CWSR + debug enable seem complete for enablement?

I think the comment is fine. I was sort of expecting to see the 
corresponding change in the TMA allocation in the same patch. So my 
question is just lack of context. If that change in the TMA allocation 
got squashed into another patch in the series, maybe it would make sense 
to move it into this patch instead.

Regards,
   Felix


>
> Thanks,
>
> Jon
>
>> Regards,
>>     Felix
>>
>>> +   if (qpd->cwsr_kaddr) {
>>> +           uint64_t *tma =
>>> +                   (uint64_t *)(qpd->cwsr_kaddr +
>> KFD_CWSR_TMA_OFFSET);
>>> +           tma[2] = enabled;
>>> +   }
>>> +}
>>> +
>>>    /*
>>>     * On return the kfd_process is fully operational and will be freed when
>> the
>>>     * mm is released
