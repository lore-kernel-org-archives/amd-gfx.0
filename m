Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B70C77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 05:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37D0C10E3A5;
	Wed, 17 May 2023 05:26:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC92210E3A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 05:26:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grWfOl1CfdQBRdWO/uIDIoIh6qipCpqYckLxbZsV/n9ZHtnGMHVzqr1UsItzYuo66tY46dkbHOG75Hzv7u9s+lQNpVle58kKuM4+DieBPXm3w9KPhvVkQP9vA3DtIdd+q9vmQDqrvimn/RSjyygOQGrrsULFGRVPvl51Eyn+W1vwqH9ppSaUv0gc32KVIQ5JyHD5Kb6bQS4tfsgFih70L9UKKaUqME44beEqbZicA2gsDhRW2XQaRow2wiXHRDGANK+rFz1ZHBGgE7/kXPy4fX6u6MVO1vBu5EkHlHPbf5YOcK4icqwnokUvkL8T2KtTUcC3Ze90a1FyLQuPARbNIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37pNWqze4jqllcbyqheD8x3YoiDEK7Ira/3nEmpELRI=;
 b=PX2eOhDXaagZSc/Py422QkGU+51rYgTgmdUokqVsvwVKC95uOQoo66Ia8jzFCdxh42fWzlin21ZE+0V1u3Jwm/Jp2dFCupxlOanFw4iBIAbCiQF17JohABaD9llezsl+CDjIpiy5u5/kqSL4Rb8b8UbNGn/Tu4Ezt44oP6+37Pab5mvcxoTUUbXC0B0wqNO80ENUiuEU8tSWgD7nlrBnzba5gKBiQQhGYPrJ8vixFmLLLGdsSy8XC3tS8Zh/OVDtE9lyL3VFzEyPz5IONvF9Z0fPHa28w3MvQ16V2TT1d7UqzB5sKtPIt/h3nbuseVHy+FHFnT0su+P2VisoXq2PXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37pNWqze4jqllcbyqheD8x3YoiDEK7Ira/3nEmpELRI=;
 b=QBpsgBcPKkFDwf+t40TDKEOQIWQe2R+tGgDg/THrACIApYuMVkzgx6TNErbOL9z3n2DmzDBc6sN87Qw0xJXDjc/GNWU2DHcsibpeeFHRnrDZj53/1C0RfGiAmISShQCgwO0it+zFXH3alttOSUdLECokMFVcWzH9CiPeWiY1FV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by IA1PR12MB8585.namprd12.prod.outlook.com (2603:10b6:208:451::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 05:26:19 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::db02:3271:73cf:2431]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::db02:3271:73cf:2431%6]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 05:26:19 +0000
Message-ID: <80f4ad3f-d297-f97b-3647-4358ba2e687d@amd.com>
Date: Wed, 17 May 2023 10:56:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 0/3] Fix DCN 3.1.4 hangs on s2idle entry
Content-Language: en-US
To: "Limonciello, Mario" <mlimonci@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230516233420.2087-1-mario.limonciello@amd.com>
 <89d0c8be-d118-1b02-0406-835557d712b1@amd.com>
 <55fbad92-010a-f7bd-6a90-ac105acb38eb@amd.com>
 <c4d8fe46-2a0e-9947-e96e-e30507725f9e@amd.com>
 <f073ef0d-0204-dc1e-0165-991866897eb8@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <f073ef0d-0204-dc1e-0165-991866897eb8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::15) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|IA1PR12MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cffdc8b-df8b-4675-540c-08db56973e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ajDpS1S/cFGD96sJHOnkazbVgAOE4KP5ygqO4S0dFUSzY7+fX8qUACv8m9TL80jO8I5CThxjqHfZAOTCdo3DZIDuV1rLz6YANgA53knUE09350iAd3KyrQ3fGByhuS6lEIFh6MSkjxun1/+nrT+JvRXz4eNt0DtE8pItRgZW2PzGXydYz2t3a3wpO1kUj+TRGLW37F7VP+s1jg683qgZcBDO27FQlu0dfMOs6HVMezLMoLrAg2CdLHX20hzMFXtSyKFAn8y5Zl518PZflvrpLduX9rnqvdDW1kKRzrFuq50CGwImTuYDmGs9bNhB6WDmBMOWK4ow+8UOiP7gRwnndT75Up9EoNz/+gUnZ9RHCk5jNjSgSh25JlI3liK49QwMkjqUumRzzegvPvXoS5EF4IertZgFpxa9CPhMxN3j/rXfP48M8aGdW6LESz3kUpqExf2zW5wOMl2moN2EiJIhIbhr4b1LYyHSbA4J5ycmDaGobsyeWxmXsxasYCdohYCiXl3lMN+/4z4Xl8inH9ln5IEzFS5jMPv/GwBLtUkWsHWWMgQs8EJzt9nhedMzqHayzLkxA3d0O6kl20jmCSdm+D/eOUY0W+/PbTIp1wuQ851Y8umpR9apRh2FtUDCNrjBeeV9t8aFEn/cTbUA5ZesQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199021)(5660300002)(41300700001)(36756003)(2906002)(2616005)(83380400001)(86362001)(31696002)(38100700002)(26005)(186003)(6512007)(6506007)(8676002)(8936002)(53546011)(66556008)(66476007)(66946007)(31686004)(6486002)(6666004)(478600001)(110136005)(316002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1V3YXZkZTk2eTZZMlB0YzZDTTlsNVEzWkdTTmZVZ2ViSE4wdjVxZTJIVGk4?=
 =?utf-8?B?THM0NXJXdlZBaHJhWHdIYlFYVHJKMHNZbitZbU1LVmZPUFZ3VENRc3lIb1Az?=
 =?utf-8?B?RWtWYnpiZ2dYb21oUnppU0gxMTVPTnVqZ3NzbExtZWYyMFNBWTZ5bFkvOWxV?=
 =?utf-8?B?NmhZK1NtdGc0Q1JjbnM5Q3FMZmErZGVGNythVjM4dlVZNm41WG83ZlVHWWdQ?=
 =?utf-8?B?TTBQckhjOHo2bnZQdzltWUY2MTRJc2FtaVkvN2R3NUtJQ2xJS1JPWjZBU1FX?=
 =?utf-8?B?bTJaZ2RkRXc5T3BxTTM3dndwcHI5SEtURU9WYmlsRHZ3NTlVTlFsL0JGK0ZC?=
 =?utf-8?B?OUY3djEzbWRTVmkzVUJTbmd6UmZWUCswUUFGdDRzU2NMemVrdDZqYXh2Z0w4?=
 =?utf-8?B?RzNybE1tSmR4MjNKZXVqUTJUOEkva2hWUFhWcEVmd29NVmJXMTlucUtXSUZE?=
 =?utf-8?B?RlovTXAxcWxxNXJ5bGU2QW5HMSs4bXZlbVpiV21IRlVIMkl2bFVxVWcyaGsr?=
 =?utf-8?B?UkJmZjdYNmRxVS9OeTAzWDV3dlRVdVpFOUJqaW9TbHRkay9UTXBVMUR2NTRX?=
 =?utf-8?B?K0dMeW5MbklTWEdyZ1ZWbUlGS2pvNlNNNEJGNzZzaWFjUVBOdnhPMkhoVGxU?=
 =?utf-8?B?TkZuUndxdWo5b05FN1FCeEpEMWVCcCtNbndKRXBKdEVMTkV0S0VIKzlkNm9p?=
 =?utf-8?B?ZlBQSEljYWlGUzZ6aTJLRm1xWE9ONTVaS0wwYS9YajNHaGNGQlYrYkpjY0p3?=
 =?utf-8?B?MHV5OStVNFdsdVhQbjdxWHI4RExYR2JxTzNlVVdFQU10My9SVFZIeFJ1d3Bw?=
 =?utf-8?B?aVY5aXdmNzVPd2Zwc1hISi85czdINk9qeXYwaXR3WnJBdlg3eFg1M2FmeDFw?=
 =?utf-8?B?ZFVzaTVoaWxJbU5HaSswR3BoMFI5TmMxdGorMmZUQklydEZ0cTVOKzM2WU5P?=
 =?utf-8?B?VGdkNjRRdGJDU2RqSVZFWmlUZ0pxa25mSVB6R1IyN1JKekpJQ3I1V0FQS1c3?=
 =?utf-8?B?ak9pcU1ZNXJOT2lTUUJqUEs0WVpqVEdzMFBWV1hLMEl4THRJVExOY0srQUdk?=
 =?utf-8?B?V1orL0xPT0N6RmJFMHZsLzJyckRlZDJZb0ZMeE1rQzJnNUtBUnJ0TVRlWE9r?=
 =?utf-8?B?SGNQbU8rRXdCZ1Ywek93bTRyVHg4WHFLNVkrRlNmanQ2aHFKeXVEVmtlQUdU?=
 =?utf-8?B?QkhiQk1LM1NaRWw3c0pFMTc1RHljSCtqb3hmQ1pSZWp5YUdKQnhGMmFEOHFG?=
 =?utf-8?B?clVvSC9QUU1jRzdLU01Yam1DYzQ0ZTN5RkVHc2lwNGJMcUl3akN4aVVBTUlv?=
 =?utf-8?B?dVhrcG1MSUJYcUdLdTNQM2xxU2ZWMFNRS3pzSTZMVDlNWmd5SkRSUmRUY1pw?=
 =?utf-8?B?NEc0eEdYWXZzQlExUXptWlJVN00xdEtQWEdxTnpZeGVRT3NlSzYvb1VvSlR5?=
 =?utf-8?B?WFpCUWNJVTZteEE3THc4N1NKSlNYN3VzcFVKUlpUcWJaZUJISnFRUUR4bzRj?=
 =?utf-8?B?OFl2Z3JJQ2tvQWRVTHVrRk5qVXliaEYwd2xGeTREYWhTcFFvdW9VckNFSG9x?=
 =?utf-8?B?NDVUcXRzQkxvMlVXTVcyK3NjMHNjNXVMMlJ4ZmJ3LzdaY2lza3lTUHRCMDQ3?=
 =?utf-8?B?dEQvYkFHazdEbjhzd2dOOU1RbTB1K0E0UjBNUDg5dDg1NG4yZ21JRDh2SFhP?=
 =?utf-8?B?QnFRT3hNaUtzc3JrdTcwYUdDMWs0RGZQZkt2UTlrSDQ1ajA1blBmK3ZZUnpv?=
 =?utf-8?B?KzFzMzE3UjdpNVpwNEl6QUVvYkh1cU1saWRaSExGNVBnVExzTzA2YzJpVGh6?=
 =?utf-8?B?TS82TjBPdXllZ3BQM0dSaGFzZU16RTVldFczdnhyNmg1K3EwYjY5MUlwWHNY?=
 =?utf-8?B?NmNBMDNNWG5lUFBuRlJSOXR2OHFyaWp3Y29GcElXTG9LZm9sdnNlOTBXZmZI?=
 =?utf-8?B?WTdRNWZ3dUlEV0Zibk43dzE5RlAzYWZmcTRsS1N3K1h6WDZpc2V3SWR1Uk94?=
 =?utf-8?B?ZXhYMUdSbWhaN09pQjN4cE5FUmM1d2lnVzRZK0lyWGwzQU9jS3dWNkhySVU1?=
 =?utf-8?B?Rjlsc3VEd0NPb3J5WDlpOVh6d0VJdjUvejQvNE1UcFh5Z3NpMmJRMlRtZ3Fp?=
 =?utf-8?Q?M4J6jr50ECXT5k48H2a7gS8eY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cffdc8b-df8b-4675-540c-08db56973e8a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 05:26:19.4350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKJnJAAJ/GEWhl9TLrAFMWKSftffZMj46QllVPyXqA/Vhd/Hfj26hukYWIzpBwg9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8585
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
Cc: anson.tsao@amd.com, Juan.Martinez@amd.com, richard.gong@amd.com,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/17/2023 10:46 AM, Limonciello, Mario wrote:
> 
> On 5/17/2023 12:07 AM, Lazar, Lijo wrote:
>>
>>
>> On 5/17/2023 10:25 AM, Limonciello, Mario wrote:
>>>
>>> On 5/16/2023 11:43 PM, Lazar, Lijo wrote:
>>>>
>>>>
>>>> On 5/17/2023 5:04 AM, Mario Limonciello wrote:
>>>>> DCN 3.1.4 s2idle entry will hang
>>>>> occasionally on s2idle entry, but only if running Wayland and only
>>>>> when using `systemctl suspend`, not `echo mem | tee /sys/power/state`.
>>>>>
>>>>> This happens because using `systemctl suspend` will cause the screen
>>>>> to lock right before writing mem into /sys/power/state.
>>>>>
>>>>
>>>> A couple of things on this since this mentions systemctl suspend -
>>>>
>>>> 1) If in s2idle, it's supposed to immediately signal and not 
>>>> schedule delayed work
>>>>
>>>> 3964b0c2e843334858da99db881859faa4df241d drm/amdgpu: complete gfxoff 
>>>> allow signal during suspend without delay
>>>
>>> It looks like dead code to me now actually.
>>>
>>> amdgpu_device_set_pg_state() skips GFX, so gfxoff control never gets 
>>> called as part of suspend path.
>>>
>>
>> Ok, that means schedule happened sometime before. 
> To come up with these patches I had a test kernel with extra prints that 
> showed the function call orders.
> 
> With systemctl suspend there is a call to 
> gfx_v11_0_get_gpu_clock_counter() from userspace IOCTL that triggers all 
> this behavior. 

I think we replaced this with golden timestamp value which doesn't 
require GFX register access.

  Here is the function calls with the patched kernel:
> 
> [   32.720456] amdgpu 0000:c2:00.0: amdgpu: set GFX off state to 
> enabled, count:1
> [   32.720457] amdgpu 0000:c2:00.0: amdgpu: broke gfx_off_mutex for 
> gfx_v11_0_get_gpu_clock_counter+0xa8/0xf0 [amdgpu], 
> adev->gfx.gfx_off_state is 0
> [   32.760475] PM: suspend entry (s2idle)
> [   32.768996] Filesystems sync: 0.008 seconds
> [   32.769310] Freezing user space processes
> [   32.776527] Freezing user space processes completed (elapsed 0.007 
> seconds)
> [   32.776530] OOM killer disabled.
> [   32.776531] Freezing remaining freezable tasks
> [   32.777528] Freezing remaining freezable tasks completed (elapsed 
> 0.000 seconds)
> [   32.777531] printk: Suspending console(s) (use no_console_suspend to 
> debug)
> [   32.817853] amdgpu 0000:c2:00.0: amdgpu: Delayed work to enable gfxoff
> [   32.817857] amdgpu 0000:c2:00.0: amdgpu: 
> amdgpu_dpm_set_powergating_by_smu by 
> amdgpu_device_delay_enable_gfx_off.cold+0x29/0x46 [amdgpu]
> [   32.818142] amdgpu 0000:c2:00.0: amdgpu: broke pm.mutex for 
> amdgpu_device_delay_enable_gfx_off.cold+0x29/0x46 [amdgpu]
> [   32.852099] amdgpu 0000:c2:00.0: amdgpu: smu_suspend: suspend called
> [   32.852101] amdgpu 0000:c2:00.0: amdgpu: smu_disable_dpms: called
> 
> Without patch 1 the delayed work doesn't get called on entry ever.
> 
>> Can we remove this code also as there is a flush anyway with patch 1?
> 
> Sure.  Do you think it should go into patch 1 or on it's own?
> 

Preferably in patch 1 itself as it explains why it was removed.

>> Also, is there a need to call GFXOFF forcefully on S0ix suspend (any 
>> chance that gfxoff is not scheduled)?
>>
> If using "echo mem | sudo tee /sys/power/state" I've confirmed that it's 
> already in GFXOFF.  I don't think this case should happen.
>>>> 2) RLC is never stopped on GFX 10 or greater.
>>>>
>>> System was hanging before this series.
>>>
>>> Patch 3 "alone" matches this behavior as described above to skip RLC 
>>> suspend but two problems happen:
>>>
>>> 1) GFXOFF workqueue doesn't get flushed and so driver's request for 
>>> GFXOFF can happen at wrong time.
>>>
>>> 2) If suspend entry happens before GFXOFF is really asserted lots of 
>>> errors on resume. IE:
>>>
>>
>> Is patch 3 really required?  Does it make any difference?
>>
> No; patch 3 isn't really required with patches 1 and 2.
> 

My preference is to drop patch 3 and not to have an additional place of 
in_s0ix check.

Thanks,
Lijo

>> Thanks,
>> Lijo
>>
>>> [   63.095227] [drm] Fence fallback timer expired on ring sdma0
>>> [   63.098360] [drm] ring gfx_32772.1.1 was added
>>> [   63.099439] [drm] ring compute_32772.2.2 was added
>>> [   63.100460] [drm] ring sdma_32772.3.3 was added
>>> [   63.100504] [drm] ring gfx_32772.1.1 test pass
>>> [   63.607166] [drm] Fence fallback timer expired on ring gfx_32772.1.1
>>> [   63.607234] [drm] ring gfx_32772.1.1 ib test pass
>>> [   63.608964] [drm] ring compute_32772.2.2 test pass
>>> [   64.119173] [drm] Fence fallback timer expired on ring 
>>> compute_32772.2.2
>>> [   64.119219] [drm] ring compute_32772.2.2 ib test pass
>>> [   64.121364] [drm] ring sdma_32772.3.3 test pass
>>> [   64.631422] [drm] Fence fallback timer expired on ring sdma_32772.3.3
>>> [   64.631465] [drm] ring sdma_32772.3.3 ib test pass
>>> [   65.143184] [drm] Fence fallback timer expired on ring sdma0
>>>
>>>> Wondering if the code hides something else because of the timing.
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> This causes a delayed GFXOFF entry to be scheduled right before s2idle
>>>>> entry.  If the workqueue doesn't get processed before the RLC is 
>>>>> turned
>>>>> off the system is hung. Even if the workqueue *does* get processed, 
>>>>> there
>>>>> is a race between the APU microcontrollers and driver for whether GFX
>>>>> is actually powered off when RLC is turned off.
>>>>>
>>>>> To avoid this issue, flush the workqueue on s2idle entry and ensure 
>>>>> that
>>>>> GFX is really in GFXOFF before any sensitive register accesses occur.
>>>>>
>>>>> Mario Limonciello (3):
>>>>>    drm/amd: Flush any delayed gfxoff on suspend entry
>>>>>    drm/amd: Poll for GFX core to be off
>>>>>    drm/amd: Skip RLC suspend for s0ix on PSP 13.0.4 and 13.0.11
>>>>>
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 
>>>>> ++++++++++++++++++++++
>>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 18 ++++++++++++++++
>>>>>   drivers/gpu/drm/amd/include/amd_shared.h   |  1 +
>>>>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  |  4 ++--
>>>>>   4 files changed, 46 insertions(+), 2 deletions(-)
>>>>>
