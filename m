Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78F6C77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 05:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B2C110E3AC;
	Wed, 17 May 2023 05:35:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40C6510E3AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 05:35:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTm0H6wufVG401h3qm8Yiimd0uMr34kd+SzbJUYKcvDOYUCXa/qbILWrUmDgJ8WQaXN6gYwuN4GgkVu+mb/9eft57c8W2PfsnMwsjd7XfJRXcF9gFTIXKCA/HXaD80aV3AD4lYeNFgIShi6ZUMsDvt1esNO6WKPA9Vh4TgIwCIWwLhlEUQnZMFgtEWSFEYcQ5R406NSIN+RkMeUxhh6B+btGVI9BXyn2+wiBDmJaJMzDE9pvWEH5fxFxpOJuTTGTh5beHoyYWvrAzCOzUXcliMiUZ09ME1ISNd3pmYzYKA3lBwAC8KT8SZZ5NWv80VAq92B+qAZz3HT8xHShaKcjBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZhRHpI+IQBd39+FeKCCd+0EcA4yl2W4LtSfUmo3hns=;
 b=Xon4jgzvVxmtYodUsNfXsEvHxN2hsfGm8OZWAq5TmKsxlAQTOJEXQ8bo7ZASFv7FuO/56EzoI678HBSXiNmIu8pVSdEWceKJVcaeVwIb7TSrKxL7vjd47/FBe3sP0qDhoI3+QR0Bejhk2YgHsc1jshssvWY4TZ3OwJ4L0iYdqZ2aSEszywYNk5+OONSJdzgt6RUpY1zrUzWQq/MwIX2lB0BOvEq7dCoAosiPqN1mn2D9LBpxJLhnRLE6HAjf0d+kgixV9rXfJhbD2mtqp6HcJurpBMk8RIwo9h5ntn8z47qsyZFGdhOO4Cbana4W82OWEtqIPpp/eClRkU1WDINwHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZhRHpI+IQBd39+FeKCCd+0EcA4yl2W4LtSfUmo3hns=;
 b=M8ezsbjsmDYZ1wpctBKSo8j+O3rFrc08E1cn0f1KEBV23CENpR683Qi6avN1LvYNi1v9j2cw7jaxQEAKZPjyudm+FeV55M005GCHEgnrReIF1jVbOn6oJ5Ne/cQ2iMflOGC2ecfvoIbdAZFDjL+7qJeDP1Duluzk3ZIM/RN84G8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5342.namprd12.prod.outlook.com (2603:10b6:5:39f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 05:35:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6387.030; Wed, 17 May 2023
 05:35:54 +0000
Message-ID: <f95fda88-518d-f8a6-f8a8-3b8930cb7364@amd.com>
Date: Wed, 17 May 2023 00:35:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 0/3] Fix DCN 3.1.4 hangs on s2idle entry
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230516233420.2087-1-mario.limonciello@amd.com>
 <89d0c8be-d118-1b02-0406-835557d712b1@amd.com>
 <55fbad92-010a-f7bd-6a90-ac105acb38eb@amd.com>
 <c4d8fe46-2a0e-9947-e96e-e30507725f9e@amd.com>
 <f073ef0d-0204-dc1e-0165-991866897eb8@amd.com>
 <80f4ad3f-d297-f97b-3647-4358ba2e687d@amd.com>
From: "Limonciello, Mario" <mlimonci@amd.com>
In-Reply-To: <80f4ad3f-d297-f97b-3647-4358ba2e687d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN8PR15CA0005.namprd15.prod.outlook.com
 (2603:10b6:408:c0::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB5342:EE_
X-MS-Office365-Filtering-Correlation-Id: a3740a0f-4040-449e-c7fd-08db56989562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FNt/zYc9gbxZec4i2626HJbtvdP/UD9i3N7Z14h03t3WSXZ/5KdQwR/sTjkfbu2ebuWUSeGWBu5ZcsjLsq0ihCw+BjYIJNtMC/uJNnXC63SuryxnYhx6NNwVqMHZT+OnuVwZqQgSIoEvfGuHgKlPWWgUZgMelkNDvXuJ6fCLYPx3f8cAa2qULxkezxsVa4NSu+1/GfxiPC3DCKTErjzBmDGP8eLuFxl6j8L3ndUtTojAQDoQKY/w9Ifvj3Dss4gGAIQGsAKEYItkdQtauquSwTV6JyJCR5GkKssnL6gUWznj4dbQUWjjg+klnMrx+ajScAfJeugl2tyCL/JMHgdrq3r6tiyFafi5eDNtCxACVmXbxRMgdO4X0u47SG9A3Hw+2ycwl0Uw81/mR8ZQEXmDIZ69cEfIcW+6+hUPRsWneNaAyPq9LHWapY5eGSjQf5eb7hW63+WAal6zBxQ/UFLhXWcY4mv9aqzPBi5J8cEP4mmAE4RPszhGwnS6VhT1LVZsFqbAGCfdCyEpkvTCYPoP5c8/HosxOPI6OMT4YGVyuGq1jUgLb8Q1AzR6Lks6YQYpBeSQdzwsGGI66S3NlpInYuDu0ulTXNYgRDFS33YdgdH5vLLpusG7xTx1VRzjvBDW2JH9UgtNB11uey6opyj97A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199021)(53546011)(66946007)(31686004)(66556008)(66476007)(110136005)(4326008)(316002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(26005)(186003)(8676002)(8936002)(6512007)(6506007)(2616005)(83380400001)(36756003)(2906002)(38100700002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGoyUEJEQVdKNEdZNnN5UnJOOFo2SU8wYjE4UTAzKzk0SUwreVJJaEZDcWoy?=
 =?utf-8?B?QmhzYXBOMUNRT1JDSW1aMEFyUzBzdnZmdzNrdWdSbEExYW9aY0t4T2hKZlU2?=
 =?utf-8?B?TldGa2kvUVJsNUJrRnFMQUVzNWhabmtKQUZhbFFDOUc0WVYwN3k3QWdEbEpi?=
 =?utf-8?B?RlhrRmlQOStRMjBTUms0cURUZ0RpSTV3VHp2dW1iMkE0TmNvZGpWbnNRQVNH?=
 =?utf-8?B?dHk3elR0em4xaUgzVVpNcm90UW5Eajh0cC9QOEdLVWlGVkgwUUtudUlBTEV1?=
 =?utf-8?B?am9xMWN1dEJrQlNmdU1rOVUzUEpkcXc4blRQcEJmbVJwU3ZDNkkyelJkTGNX?=
 =?utf-8?B?SmJPVlY4azJhRVJzekFmVnhmWFNKaE5vc3RsK2dwdjV0VGhYOS9BU205c3dX?=
 =?utf-8?B?TzMzRFZHc3M2OEJvUGlWVyttd3RuVU15UGEyUDN5MHVSak5xdTB4bTMvbzVy?=
 =?utf-8?B?RGhUUzE4WDVFSUUwTUx0S2dsWUVkS1o5bmMwd2lQckFyU3FsOStvSHd1RTJN?=
 =?utf-8?B?ckVsT2psUHVuc1Vna0JCRW1USzZvVkRLejlzZk1DU0ZPTWZtYlNEOUdJWXZh?=
 =?utf-8?B?K0p6R1EzK1RqcGF1N2k4a3YrZkVOMUpyaXl2M0hjc1BqMUlHRkR3WTRTV0RL?=
 =?utf-8?B?Um9KZE5NTGhLNVQzUHJONVprVnVVSk0wNnRMTEJrSWI3RzNtaml4OWdKTHlw?=
 =?utf-8?B?ZHp6NTFHd2lYVlRCWGMrVDU0MlZneVF6Q2poNjA4blJQWEdNalBYZXJuRFFa?=
 =?utf-8?B?QzJiMmxqOW9HT1BOc1FnZGgzeWtnbEJ6alc4L2NLdEpwWE5ZMzZrSFhhaitG?=
 =?utf-8?B?RXF6bEptdXRkNURQeHdpV1FUSmxXci82OUpqSGRuMlExVkg2NnlrNTBXNDE2?=
 =?utf-8?B?ZW4vVVBCZDlFcGJzaG53bXg4LzN4dk1RZE9jWURxZ2VqN0hiSFFvQnBoandn?=
 =?utf-8?B?ZUI3U3k2MFd1Z0l3MjV5b291UTQwNEJocGV2Um8vajk0S0hZOUFEdVQ3UEZC?=
 =?utf-8?B?T0YvUXRNN01rTkU3MUMzaStMbEpRTFNpcXRaeUl1cWhEbEJtSUk1TWd4TGhF?=
 =?utf-8?B?ZHlESGwzczNuU0FpVVprUnkvNisxUUZiS2kxRTBVaHl3WHhFdWRZOW5XU21y?=
 =?utf-8?B?eFo4anBOamwvSy9ZeXlUbSthNWNDSTFHZGxZR29LaHE2RmFBak1pZmJja2h2?=
 =?utf-8?B?Wm1vNkNQYVFIVE1EejY0ZjNCcndWNDlzZk1kNWRzQ2lsTURnU1hDRGE3YVRu?=
 =?utf-8?B?R3dHRzMwYnk5b3plK2N3ck1OWG1QbTR2em43TVo1RWRJWStTYlVFVWdSZlVE?=
 =?utf-8?B?bk9NZkRxRU5WUGp3Z3FGWGNzMUI2dGY1MlhqRlRsbDJOTVc4OVg5UU95cU81?=
 =?utf-8?B?MGtHc1hCN21rQzlUNmJLVXVIYXBXejJadXovM09YdlRQbmRsVldYcVlwRHhI?=
 =?utf-8?B?MEJLRFE3NHR2bmtJSGVERkRxcHVucGt6eU5sNVhTRU4waFhiTmFlWVVQa3Av?=
 =?utf-8?B?eFh2QWhLbmwvY3lLMWZ1MzRmWUtLb0ZxeThOSGdaV2xyb2h3NGJ0UzVPWWJu?=
 =?utf-8?B?TXJKSDhva25Yc1Fuem5XdHg1bURRK3U3aHc5cUxCNWM3dnhnRlBqYmJ6OEl4?=
 =?utf-8?B?ck44L2w0dGs5ZXJkMFlUc1p3dXoyK2w3cWVvYlY4dm9vem91emdaUklHcEt1?=
 =?utf-8?B?L3g3NHdxTExOSXlBNjBRL3dITWRISk1GQmh2UDlpVVpMeFVYekdYQTFlTlJS?=
 =?utf-8?B?RlNEL1IyMXp0SHY3bjR3SWEyOUM2MFl6MVFUYTlmbENJMW52dXRSdW1lem02?=
 =?utf-8?B?V25Yek5OL3BUbGNQVWg0clBucU5JMjJKMURsLzV6YmtYTlQyTmZRdUdoMi9v?=
 =?utf-8?B?REtIWkVQQWJ3RVpyZ2V4V2RBemVpN2pFUmdMTkhNRU04YnhXdVF6cnNtM2VF?=
 =?utf-8?B?amlXVUtCTFRMQ1Qza1k2bG9MU2J5bkQ3dW1zazM5MXE0NnAxUkVVMitoZ2hQ?=
 =?utf-8?B?bWtvM1pyT3RqNnBzTTQ4TFFVcU1rUHNxQ0FaK3ZsMlUydzgrazBtTktvYi9T?=
 =?utf-8?B?Snh3dDRMZThrY0VKOEp1NzhmVlJBRXA4QnRNN3hPVlJUSWxYeWQrOWE1SGQw?=
 =?utf-8?Q?w8KySC8SQD9UaZyLLr4BvvGg2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3740a0f-4040-449e-c7fd-08db56989562
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 05:35:54.5978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A21vUkMOLlcsiU9F8d0S7wHvv9nK9dClfsfrE/qMZCHfnPIOXfN7GUkjKYM5gxGSPPeVWxm6xksMEY+A6GSyfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5342
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


On 5/17/2023 12:26 AM, Lazar, Lijo wrote:
>
>
> On 5/17/2023 10:46 AM, Limonciello, Mario wrote:
>>
>> On 5/17/2023 12:07 AM, Lazar, Lijo wrote:
>>>
>>>
>>> On 5/17/2023 10:25 AM, Limonciello, Mario wrote:
>>>>
>>>> On 5/16/2023 11:43 PM, Lazar, Lijo wrote:
>>>>>
>>>>>
>>>>> On 5/17/2023 5:04 AM, Mario Limonciello wrote:
>>>>>> DCN 3.1.4 s2idle entry will hang
>>>>>> occasionally on s2idle entry, but only if running Wayland and only
>>>>>> when using `systemctl suspend`, not `echo mem | tee 
>>>>>> /sys/power/state`.
>>>>>>
>>>>>> This happens because using `systemctl suspend` will cause the screen
>>>>>> to lock right before writing mem into /sys/power/state.
>>>>>>
>>>>>
>>>>> A couple of things on this since this mentions systemctl suspend -
>>>>>
>>>>> 1) If in s2idle, it's supposed to immediately signal and not 
>>>>> schedule delayed work
>>>>>
>>>>> 3964b0c2e843334858da99db881859faa4df241d drm/amdgpu: complete 
>>>>> gfxoff allow signal during suspend without delay
>>>>
>>>> It looks like dead code to me now actually.
>>>>
>>>> amdgpu_device_set_pg_state() skips GFX, so gfxoff control never 
>>>> gets called as part of suspend path.
>>>>
>>>
>>> Ok, that means schedule happened sometime before. 
>> To come up with these patches I had a test kernel with extra prints 
>> that showed the function call orders.
>>
>> With systemctl suspend there is a call to 
>> gfx_v11_0_get_gpu_clock_counter() from userspace IOCTL that triggers 
>> all this behavior. 
>
> I think we replaced this with golden timestamp value which doesn't 
> require GFX register access.

Ah yes; through

5591a051b86b ("drm/amdgpu: refine get gpu clock counter method")

This wasn't part of the kernel this was originally reported on.

I suspect this would significantly decrease the likelihood of it 
occurring.  I'll confirm it.
I do think that patches 1/2 still make sense though because gfxoff can 
be triggered other ways too.

>
>  Here is the function calls with the patched kernel:
>>
>> [   32.720456] amdgpu 0000:c2:00.0: amdgpu: set GFX off state to 
>> enabled, count:1
>> [   32.720457] amdgpu 0000:c2:00.0: amdgpu: broke gfx_off_mutex for 
>> gfx_v11_0_get_gpu_clock_counter+0xa8/0xf0 [amdgpu], 
>> adev->gfx.gfx_off_state is 0
>> [   32.760475] PM: suspend entry (s2idle)
>> [   32.768996] Filesystems sync: 0.008 seconds
>> [   32.769310] Freezing user space processes
>> [   32.776527] Freezing user space processes completed (elapsed 0.007 
>> seconds)
>> [   32.776530] OOM killer disabled.
>> [   32.776531] Freezing remaining freezable tasks
>> [   32.777528] Freezing remaining freezable tasks completed (elapsed 
>> 0.000 seconds)
>> [   32.777531] printk: Suspending console(s) (use no_console_suspend 
>> to debug)
>> [   32.817853] amdgpu 0000:c2:00.0: amdgpu: Delayed work to enable 
>> gfxoff
>> [   32.817857] amdgpu 0000:c2:00.0: amdgpu: 
>> amdgpu_dpm_set_powergating_by_smu by 
>> amdgpu_device_delay_enable_gfx_off.cold+0x29/0x46 [amdgpu]
>> [   32.818142] amdgpu 0000:c2:00.0: amdgpu: broke pm.mutex for 
>> amdgpu_device_delay_enable_gfx_off.cold+0x29/0x46 [amdgpu]
>> [   32.852099] amdgpu 0000:c2:00.0: amdgpu: smu_suspend: suspend called
>> [   32.852101] amdgpu 0000:c2:00.0: amdgpu: smu_disable_dpms: called
>>
>> Without patch 1 the delayed work doesn't get called on entry ever.
>>
>>> Can we remove this code also as there is a flush anyway with patch 1?
>>
>> Sure.  Do you think it should go into patch 1 or on it's own?
>>
>
> Preferably in patch 1 itself as it explains why it was removed.
OK.
>
>>> Also, is there a need to call GFXOFF forcefully on S0ix suspend (any 
>>> chance that gfxoff is not scheduled)?
>>>
>> If using "echo mem | sudo tee /sys/power/state" I've confirmed that 
>> it's already in GFXOFF.  I don't think this case should happen.
>>>>> 2) RLC is never stopped on GFX 10 or greater.
>>>>>
>>>> System was hanging before this series.
>>>>
>>>> Patch 3 "alone" matches this behavior as described above to skip 
>>>> RLC suspend but two problems happen:
>>>>
>>>> 1) GFXOFF workqueue doesn't get flushed and so driver's request for 
>>>> GFXOFF can happen at wrong time.
>>>>
>>>> 2) If suspend entry happens before GFXOFF is really asserted lots 
>>>> of errors on resume. IE:
>>>>
>>>
>>> Is patch 3 really required?  Does it make any difference?
>>>
>> No; patch 3 isn't really required with patches 1 and 2.
>>
>
> My preference is to drop patch 3 and not to have an additional place 
> of in_s0ix check.
OK.
>
> Thanks,
> Lijo
>
