Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E49C77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 05:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED26410E047;
	Wed, 17 May 2023 05:16:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75ECB10E047
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 05:16:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KynDE7sNC9hDtkXhbPLG7+VsQhT7ifXWsbyt3GIjZtIPieRGZ2o69NWSdkb76yOWCJ8q8ubKOleIxa9+XmU/ofTKhTtAxnOPAqblRTASE8HOoz+4rOPEqvgkuMKMU+VxRzLUd8uhUZcAlCcZaHDU1dapghj63FUd9D3y8W+RnQ7qUoqtgTV+sXmgRx1yVc39owEO2WO6eC/G6os7kzoZUrkHiJ/YjaEBBIlXlcuBDsYZxm2lZ16QHWFs2yMux2bUgnhhHUOAhRx1Z1Fxh7dgSAT1PHeJZx1qAPFRNuXBnDRpi4788t9S6ICXNbI1bkHREEmen5RMW0uXc0OhgpoJog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PssiAvG65zPiP3NyFgB4RK90YIH+aNdyiILxm62AV5U=;
 b=LZzpjMvJKwuaUp66SY2GuStCly8G5gnUFE/EerI7ty4pul21A3V7oQDd+juH/fNNR/uC+uzyMShf0xmfzmE6KEe+NcsrKePRHFpX6IYlXxlww9DBHtetvTdO3SDa9osXU+WOXjSzdTclMOICaeZok9crScDleBKqeCS4oWIW8ObRcOAhidQ9sqqmItrp3oZ6TbyCK+jeiQVtP4z52KoliK7iFfOcTZOPFw/BVNGcQpEngTwDqD5/na7RTqAFNzCq0ul1gK+6xbvERM9FaIfPSqaY780/DPmgnbkgLS5S69Ay2pXFYqjz/BQR3VvtIdV0JhQW3fBaVtfHltsJcRni5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PssiAvG65zPiP3NyFgB4RK90YIH+aNdyiILxm62AV5U=;
 b=OrIAl2M+Bk6jPycEHbSuUilXD3e4av8iOa8ag+1qBoim3dIuAx+37yZKHtBEyVSvZJVM+WlX+NzmNHd1A2LRrJIxjn9FbMTo9b4YRZLDv06ehrxZyX6SjROsRbMxFNLyylCX11X47GCn6lmSBqtS0o90TS3zwNDCLEGzmwRGbgc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB6353.namprd12.prod.outlook.com (2603:10b6:208:3e3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 05:16:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6387.030; Wed, 17 May 2023
 05:16:06 +0000
Message-ID: <f073ef0d-0204-dc1e-0165-991866897eb8@amd.com>
Date: Wed, 17 May 2023 00:16:03 -0500
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
From: "Limonciello, Mario" <mlimonci@amd.com>
In-Reply-To: <c4d8fe46-2a0e-9947-e96e-e30507725f9e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0980.namprd03.prod.outlook.com
 (2603:10b6:408:109::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a1827e-c639-43c1-0619-08db5695d0da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G84FC5/Dhn+z5OqswkIeZACucrBvkh2CbryIP/mM0ijuenn9hss3QGwc9TEvWTCGuf8IbyJVuQtIxn2NPi2zRXas59VoxDfa2RMwKLEgrpnkR5l4C536QB0UBVIKPksHBsoCPGN1OuK1ott7r9y4WAfjbMCuRLG1mxz+U0Dxq1kp0n7K3uwGzqS3OO7WGSc8hK7LEsMjf5QiFksJ6bg8QcIdoz83Ocy2cnDmV5qemRiEjEUP78Zx7dcUVOxrrq9oA3HrLK70iZdvi0UNHFlys8Ni7hxMhQzlnlNTqPYzPc4FjZ2B39USyiiREnFMwjyDwaHHUDoYH4wliEv+bYcrvtIirTS0Sf4fcDOYFdrIAz4yozuG0M9l9RNxY3CX0tjMhofyJjTqTL0qek+BJxLfjXOFc5oKUwnxftr8QASpa1+Z3SOWLP/KdsMrFYn4GZR8eGSHAekCfqWA+iLOAG04EdRgzmHlCyGjJ/MgH1FsPoBju8Rwa8stfXMA+zKW76ULBNck5Bz7UcSRIuqCwQO09039Jd+nyF8eZiHAxPGAox1+sD4xt8OQgWT9m3cqeIu7LRlS5Yx3fXzQ5nzsWAOvV10XMD/hOJAZ/hH5Q2DzcxpGrIm0ixAC020yaYwGONMaS0WvAr31j+QSWqoGy7gYKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(38100700002)(53546011)(478600001)(110136005)(36756003)(66556008)(316002)(4326008)(66946007)(66476007)(2906002)(83380400001)(26005)(8936002)(186003)(31696002)(8676002)(6512007)(31686004)(6666004)(41300700001)(6486002)(6506007)(2616005)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0Q0NVhFVnc0VkloRkVjOHRDNWNYUE0xRjdWRy9GOGNjQUdUZTVIM2VJazkv?=
 =?utf-8?B?RXV3ZU92Z0JDNVFINHFmUFl6STdRUjJ3Y285WlcvMUczejkvWVpGWlVVemVB?=
 =?utf-8?B?QXBLM0ZneDA5bXFWeThrNG83aVE2MWpkVHVXZXVIcUs4bGdhVEhHT0piNk1l?=
 =?utf-8?B?K2ZUTjc2aUo0ZVc1aWo3bDZGZk85QWFSY0FDVmJNbklFVVZ1ZUpqQ29jWkdy?=
 =?utf-8?B?RWt3NERkNlY3Yk9KeGVRUzR3YUZEaGlkak5JZGFJdkVCM1d0dHRWdE8vcFhw?=
 =?utf-8?B?b1Z6RHVQT2RhTGV1U28reWNTWjdtSjN0OUJuRUxDVEJnMkgxNG81b01WVXg5?=
 =?utf-8?B?cUxnTmZZRFN5WXhJL0RYYm52ZFNsdkZOWTJQRm4wWWx6bjkxWWV1NTh5Q00x?=
 =?utf-8?B?dnh6RG5QN2R3aG9yS1VNN1ZieTZ3SnFHY3hBWHpHUHhKT0hZcmZkYXJoRlZC?=
 =?utf-8?B?cHB5UTlDOEttbVczLzAwOU5jYlF0YjVYdmZvVG9TNVlhQ2g5NEI1L0JrMTJC?=
 =?utf-8?B?OEFTaEw5dy9NUEorZFBGU3ZlN3B2aFdHalRCL1NWaWNUTEVHS2d6S1NUaVNq?=
 =?utf-8?B?SlRRUGg4ZW9uT0Uvb2hMakdBVVM0dmQyV1Nob0U5WDB3QTJ0a2NhSkF3Ym51?=
 =?utf-8?B?YlN0R0RPV0N5YkdVakkzUld6MHN1NlAxWldXK1Q3SGhJTXlic05naERCUEQv?=
 =?utf-8?B?TXhIWlM1YS9Od3FqT2ZHNDJjeTBDRDVSYVk0anM2R00yelRFOHVKQVArekxr?=
 =?utf-8?B?aWkvaWdxWk5IQjFHRllHS0dIbDAwYjk1MWEraU5hQytCY0lEdFpTSk9JT29i?=
 =?utf-8?B?Wkg3c1d3VjlQWkRxRWV6TzFocTN4RUh2UTE4d0xHTDlIRmQxK09SVFJuMWRn?=
 =?utf-8?B?bE1hQUJWRnNXbDEzK1lkeXg0YS9hL0pEN1Z2ZXhKeTQ5WW5waUZEbzJMcHBx?=
 =?utf-8?B?ZXg2bnhBNXBjb3NCZGRici9LcVdzOXRnbGl6bmxQMElRM0l1WUUxTnR5R1V4?=
 =?utf-8?B?b1YxNUtjblhZNVB4MXlUNEpSSmt0SWkzM1Y2enZCMk5OOEIvOEVWa21pUHJs?=
 =?utf-8?B?S1VoTEdpVHZmendyRHhXN0l0QlNKcVYrVkdVOFROMnVTUXVaanN2R0NmYjR4?=
 =?utf-8?B?NUhuc1kwZ09SM295M0lSZzhPcFB0UW5URlU0em5pRkNDSThNSitabndDUEJv?=
 =?utf-8?B?cHFyaGZiTW5YMlZhd0tDUEFIQXFmVEdwSG9oWFJ1bEhsOUE4RWtRNzBOQXlm?=
 =?utf-8?B?dGFnTWZVVG1YRm0xc1VIZUpkN0htRHlMdk95TCs3Wkh2Y1Q4a0xvUi91OHBV?=
 =?utf-8?B?QUEzWFdDN0MwTzUvUWgrLzNQZ2FCb3lob3RBaWdTZzg3S09Ma3VqKzJhcVhV?=
 =?utf-8?B?eHR2UnFuYURZSWJQUmZldHFxclczNEdZR3VJTjlYYWRFMWZnWGNpRUsyaitJ?=
 =?utf-8?B?WGFFenFXWUFTN1VZcWlwL3ZrMmlSckhsUXhGUlplSklIWjlzbCszVitxTldy?=
 =?utf-8?B?NVJNRTc5eFZOMHN1dWJCZ3Zlcjk0ZFNPOGV5cXBrdWZUT2tTN1BWN0JTM3R5?=
 =?utf-8?B?RzQyY1Z3bGI5V1o4NE5nRTNCYTZ0RG5FTnlQMFRoVitxVWQxSTg1MzFjTkZT?=
 =?utf-8?B?cHk3NTBxQ0tBT2FLZ1JDSXJOZ1QzNE5jWGVvZDZMeDhwT3JDTzMzM2RrRTBj?=
 =?utf-8?B?dnM0bjhsYWc5T3BHeFljZS9aeGZoWWxRSnZYUUt4SnZaUVI4dVlCcFJRenZX?=
 =?utf-8?B?VGcrdlgyQ2hiUVl5UGJBRWpBcFdOTldhQzAvUVI4V0hhaEdTbjRsT0ZzbWxS?=
 =?utf-8?B?MGtueVpGTzV5YlZpeE9saHhMV1gyL1RCUWhFeFY4eHVaSEVBSDA3Q241a3RE?=
 =?utf-8?B?SmZsZFpKTDFnMWxwVG14RUI3ZjcvcE03Rnk2RHNIU2ZUZk9zdndacjVHVGlB?=
 =?utf-8?B?Q2RYZzVMSnVCZ0dadlJLaC92UkdOdE5hMXpVYlRHZkpZaUJ1WnRBU0c2STAx?=
 =?utf-8?B?MU5LS29XUmRJQlJkZ3NXbDVDT2ZXeFhONjBMUEE5RmhtbGs2bnZxTnQ1UTNp?=
 =?utf-8?B?S2IwRjAvRU5xeThQUTlDMm5GUmpPSWJJYUZRUWpVTGFGNGJSbmd5dnRiclZK?=
 =?utf-8?Q?35G5w9PXxuPRDZzX7Rp7PmWp9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a1827e-c639-43c1-0619-08db5695d0da
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 05:16:05.8668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIKRPUyzsUpAiUrRs2c1Jlt0uikTDHbNI5a9k9E+YK+z+vtAuX8cRtr6W8C1oMK/Ye72Z3vgXCCijCPHH9V6gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6353
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


On 5/17/2023 12:07 AM, Lazar, Lijo wrote:
>
>
> On 5/17/2023 10:25 AM, Limonciello, Mario wrote:
>>
>> On 5/16/2023 11:43 PM, Lazar, Lijo wrote:
>>>
>>>
>>> On 5/17/2023 5:04 AM, Mario Limonciello wrote:
>>>> DCN 3.1.4 s2idle entry will hang
>>>> occasionally on s2idle entry, but only if running Wayland and only
>>>> when using `systemctl suspend`, not `echo mem | tee /sys/power/state`.
>>>>
>>>> This happens because using `systemctl suspend` will cause the screen
>>>> to lock right before writing mem into /sys/power/state.
>>>>
>>>
>>> A couple of things on this since this mentions systemctl suspend -
>>>
>>> 1) If in s2idle, it's supposed to immediately signal and not 
>>> schedule delayed work
>>>
>>> 3964b0c2e843334858da99db881859faa4df241d drm/amdgpu: complete gfxoff 
>>> allow signal during suspend without delay
>>
>> It looks like dead code to me now actually.
>>
>> amdgpu_device_set_pg_state() skips GFX, so gfxoff control never gets 
>> called as part of suspend path.
>>
>
> Ok, that means schedule happened sometime before. 
To come up with these patches I had a test kernel with extra prints that 
showed the function call orders.

With systemctl suspend there is a call to 
gfx_v11_0_get_gpu_clock_counter() from userspace IOCTL that triggers all 
this behavior.  Here is the function calls with the patched kernel:

[   32.720456] amdgpu 0000:c2:00.0: amdgpu: set GFX off state to 
enabled, count:1
[   32.720457] amdgpu 0000:c2:00.0: amdgpu: broke gfx_off_mutex for 
gfx_v11_0_get_gpu_clock_counter+0xa8/0xf0 [amdgpu], 
adev->gfx.gfx_off_state is 0
[   32.760475] PM: suspend entry (s2idle)
[   32.768996] Filesystems sync: 0.008 seconds
[   32.769310] Freezing user space processes
[   32.776527] Freezing user space processes completed (elapsed 0.007 
seconds)
[   32.776530] OOM killer disabled.
[   32.776531] Freezing remaining freezable tasks
[   32.777528] Freezing remaining freezable tasks completed (elapsed 
0.000 seconds)
[   32.777531] printk: Suspending console(s) (use no_console_suspend to 
debug)
[   32.817853] amdgpu 0000:c2:00.0: amdgpu: Delayed work to enable gfxoff
[   32.817857] amdgpu 0000:c2:00.0: amdgpu: 
amdgpu_dpm_set_powergating_by_smu by 
amdgpu_device_delay_enable_gfx_off.cold+0x29/0x46 [amdgpu]
[   32.818142] amdgpu 0000:c2:00.0: amdgpu: broke pm.mutex for 
amdgpu_device_delay_enable_gfx_off.cold+0x29/0x46 [amdgpu]
[   32.852099] amdgpu 0000:c2:00.0: amdgpu: smu_suspend: suspend called
[   32.852101] amdgpu 0000:c2:00.0: amdgpu: smu_disable_dpms: called

Without patch 1 the delayed work doesn't get called on entry ever.

> Can we remove this code also as there is a flush anyway with patch 1?

Sure.  Do you think it should go into patch 1 or on it's own?

> Also, is there a need to call GFXOFF forcefully on S0ix suspend (any 
> chance that gfxoff is not scheduled)?
>
If using "echo mem | sudo tee /sys/power/state" I've confirmed that it's 
already in GFXOFF.  I don't think this case should happen.
>>> 2) RLC is never stopped on GFX 10 or greater.
>>>
>> System was hanging before this series.
>>
>> Patch 3 "alone" matches this behavior as described above to skip RLC 
>> suspend but two problems happen:
>>
>> 1) GFXOFF workqueue doesn't get flushed and so driver's request for 
>> GFXOFF can happen at wrong time.
>>
>> 2) If suspend entry happens before GFXOFF is really asserted lots of 
>> errors on resume. IE:
>>
>
> Is patch 3 really required?  Does it make any difference?
>
No; patch 3 isn't really required with patches 1 and 2.

> Thanks,
> Lijo
>
>> [   63.095227] [drm] Fence fallback timer expired on ring sdma0
>> [   63.098360] [drm] ring gfx_32772.1.1 was added
>> [   63.099439] [drm] ring compute_32772.2.2 was added
>> [   63.100460] [drm] ring sdma_32772.3.3 was added
>> [   63.100504] [drm] ring gfx_32772.1.1 test pass
>> [   63.607166] [drm] Fence fallback timer expired on ring gfx_32772.1.1
>> [   63.607234] [drm] ring gfx_32772.1.1 ib test pass
>> [   63.608964] [drm] ring compute_32772.2.2 test pass
>> [   64.119173] [drm] Fence fallback timer expired on ring 
>> compute_32772.2.2
>> [   64.119219] [drm] ring compute_32772.2.2 ib test pass
>> [   64.121364] [drm] ring sdma_32772.3.3 test pass
>> [   64.631422] [drm] Fence fallback timer expired on ring sdma_32772.3.3
>> [   64.631465] [drm] ring sdma_32772.3.3 ib test pass
>> [   65.143184] [drm] Fence fallback timer expired on ring sdma0
>>
>>> Wondering if the code hides something else because of the timing.
>>> Thanks,
>>> Lijo
>>>
>>>> This causes a delayed GFXOFF entry to be scheduled right before s2idle
>>>> entry.  If the workqueue doesn't get processed before the RLC is 
>>>> turned
>>>> off the system is hung. Even if the workqueue *does* get processed, 
>>>> there
>>>> is a race between the APU microcontrollers and driver for whether GFX
>>>> is actually powered off when RLC is turned off.
>>>>
>>>> To avoid this issue, flush the workqueue on s2idle entry and ensure 
>>>> that
>>>> GFX is really in GFXOFF before any sensitive register accesses occur.
>>>>
>>>> Mario Limonciello (3):
>>>>    drm/amd: Flush any delayed gfxoff on suspend entry
>>>>    drm/amd: Poll for GFX core to be off
>>>>    drm/amd: Skip RLC suspend for s0ix on PSP 13.0.4 and 13.0.11
>>>>
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 
>>>> ++++++++++++++++++++++
>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 18 ++++++++++++++++
>>>>   drivers/gpu/drm/amd/include/amd_shared.h   |  1 +
>>>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  |  4 ++--
>>>>   4 files changed, 46 insertions(+), 2 deletions(-)
>>>>
