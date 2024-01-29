Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED125C47DDF
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 06:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DA35112465;
	Mon, 29 Jan 2024 06:48:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05914112462
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 06:48:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2znTFtNWUXUI1PHly0tW3As+gJySMcheFn7kNDaXGqzsj0WY6Qz4X6UsFosfv4UT4oTIGTmBwJZaA5YWjTlc0xClvSOQdNUYJotHdQYrHuWmlJ7bnSRKe+c1szZyXZ7Z6fBma1bpjI/iunudBt6ekgKrVxVo2Ssu/VxHFR+ilXnhXCea6bWNV979jlNR1StMC8EC23dhhIvJmetzm8MFrDHZ1U+DYRy1BNYwkgdV0V5y5Z0mVCj0XCmUEOSXQ7rV8iDT4syY08ldJbbnh7gz1YBmXrToMFW5nWee6wCZxNjH1i+eTWn7rJ/DeOAXHlBmRoC198dGyoOl9TIZ+sS0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VHyKoududwzgOq6iWUGh35Nj9zsqrtl0eRedXApuII=;
 b=gN2JEnoXC3Jwr2qSpqQuMf9topzAQ3sEU2hCNwuqbfrMxfF93INh2UzZjou52ESc0YvPc9Fv5KzB39HycO6u/9wE+KMSoxcQY9ZZxdXgNfrQexv4cSa/PrXEkdgsumSTc79gN9FM4f9X3f4ln5F687/BvXOItpefV5rGkr1e+beGGRImjCuEGK8W92n8SfAh2wxyltFLJSxyLCFTRzT/oe0ds2eUL9CJIAB6Z7+RVIIBFfT3E3wUFnlfFTYaE1VQAncmdfG+/0UKX2HCNawHV5aaIO6IxbmYgkmv0VnU5Qwwz+A6r6bj/KuGe6KuTnvkPnYkBqY0TGiuWAkk3m1+9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VHyKoududwzgOq6iWUGh35Nj9zsqrtl0eRedXApuII=;
 b=XNgIEJutZaED5+Ie2Q4kLeu1EPUKuTcWJzQhY7pAr30O6mGdk9HV2v8llqT1uMA7+VtUxjEMgf6FBV+RUq8qPYPsSdJRNqXjRWpNZcW2EVgmgv2REfhLQDf9UcTTgTzPFWGEaRnFbtKyQzyByUc5SXWM4KyZynngOwLPPjLWWkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH0PR12MB5041.namprd12.prod.outlook.com (2603:10b6:610:e0::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.32; Mon, 29 Jan 2024 06:48:24 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::3639:e4bf:a222:7dbe]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::3639:e4bf:a222:7dbe%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 06:48:24 +0000
Message-ID: <670a789a-c5d0-4064-96de-22c94e6910bd@amd.com>
Date: Mon, 29 Jan 2024 12:18:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: reset gpu for pm abort case
Content-Language: en-US
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240125032255.898308-1-Prike.Liang@amd.com>
 <20240125032255.898308-2-Prike.Liang@amd.com>
 <6faf2c64-fe90-484a-902a-66a59e9c3849@amd.com>
 <DS7PR12MB600523A9E24397369DFDFDE7FB792@DS7PR12MB6005.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DS7PR12MB600523A9E24397369DFDFDE7FB792@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH0PR12MB5041:EE_
X-MS-Office365-Filtering-Correlation-Id: d14ca01e-aa44-44d2-5edd-08dc209649fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ErkL5w5lXPikHy2a51huugePzEwXrIGDxua6t2J9vY9ZQInLRoIHRKL/S0M6kF1ZcZs9O6d69As6DqazYiwFRA2K7mc7jVQ5Qwr2CVbzT668Fpk8emDVJwAEPnuY5/EnLMkOgYa3NwKoUK+/jpbs5AkUaR+BmjakXNAuvsDP4xSepUwRwmN+U93J/f4q7pKraZgr6Z7Ax9HU5whW3SUM+5NLp4lls8Ja9s83StDWEAo3nHriTyX6rxsm7gUM8o1RPSDVpyRAI8rBw/jjrdCcvISQT/F57QayU5y/TmM1XLNGfyXMs1cVN5/il02wq1bcmOXgFVN7ia7rK4QOcVSJHCWw17G+Wgp/A2XJjrw215sisGT6yC0TF4F4JqlZzKaNP5RwJAo4fqzZFYNtWExRD8zrYx7HCxMwMs66MsiJf3TFsWlEIoWLVMrxMmD4nh+8fsMIAnNUQ0C1/1oRbB+sy/qfJCYZP05/eMuEPQg3PJjS5BnolXbR0d0L0t6WHoPwEgghuZE9DOxSAz89h8TFRyog3w2iz1gjCZtgOBS2hy0DFPMqJbqMVi9lYXwGDGEdkHhYZYlu9OTKk/hS8b6jEjEmkN7GDkdFzyD08Qg0eqH1Wmc1/PcL1JX8mnBkoCgozPUW2bUXMpZANGNhBBoNeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(53546011)(6666004)(6506007)(2616005)(6512007)(38100700002)(5660300002)(4326008)(8676002)(8936002)(41300700001)(2906002)(6486002)(478600001)(316002)(110136005)(54906003)(66476007)(66556008)(66946007)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXc0dStWM3NiRUw5MmtnMGJuS3dFZnZOeE1scWxQTVdvL3Y3MXZKWkg2MEJi?=
 =?utf-8?B?cEFxY0oxZUxlb0pJUG1SNDU5d1ZtUTVGQmh6RStVSGNSay9TcGRUSHUxS0do?=
 =?utf-8?B?bFJjU1N3UjhFU0Z0S2V5VTc4MEkzV1JqaVJsS3dDcnNiTWhuSlJVNXZLbnhq?=
 =?utf-8?B?dkVhRG5ObDQ0eWdZMFh3elZFalgyMTNqdEl1T3phcVA1ZnI2dm9KcW1HekI0?=
 =?utf-8?B?c1JHTUV0WWVBU2h6ZUZtUkNmWUhZR0lLQkR6SHB0cHB3UEtOTGhJd3FFSERE?=
 =?utf-8?B?cHQxc2NCUC9nQ2NNalQvOGdmZEFSVDdEeThDWko3ekZpdkYrU0d6WGJ2M05D?=
 =?utf-8?B?QWNVMzM0LzdCOHROUzBKOEVPbmJZRnd0TWJJZkdTdDlSOWVyYm1rSEM4WGVC?=
 =?utf-8?B?b1FKOW5jSTBmSkNuOXgxN0FBZjJnQUtVMDkyRmF6SEsyRmRDcm5TZ05ObmFI?=
 =?utf-8?B?elhCQitqa2MxWkZmbDIzOFRhUkRMYzU0MWVSVWxla1laTnEzaVErWlBKdzZh?=
 =?utf-8?B?WnhTVHRnV0JmVUdlalp5ZXF2eVJKeXQzdjFIQmxyM29wWTdscE5kYlU1RWVB?=
 =?utf-8?B?V21wN1hDS2NRcFROOHJ2SXh5b1FoWDNSR0xHbWFxZXlJZHFMekpCOFRndnB4?=
 =?utf-8?B?ais3VTdqcE9TaDNvSEVPMnhXZUV3ejE1VEkweER1amMxUS9uM0t0ZHgraHFy?=
 =?utf-8?B?Uk01K0srQmc5a2V6S2NRMnp4YnVtRVp2OGVkN1ZMYnphcExPUGtoSXZPMDJr?=
 =?utf-8?B?bWdPRys4ckxPa2pIclp1cmNZZGE4UVUyR3BjUCs3ZEVGVGd0WXFoY0FPbGRr?=
 =?utf-8?B?Y2lQd2EwcUV2eFYwdXZMRzNZS213UjZKVWtPNG5pUDEwd2RCbFpuRjN0ZzVE?=
 =?utf-8?B?Q1NzL1RnQmVoai85aDMxeXZBVncweDZXU0xyNVNyNnVMTGFyZUdyQ2M1WDZC?=
 =?utf-8?B?ZUZGekJwK09ad1ZpbDZjeVlRVHRZZFNINkhwYVRKcWlmd1IwYVh6MFpQZmVz?=
 =?utf-8?B?ZjVkVWwyc2xsUFNJb2VYb05DdlVFRExpdWpjK0d6ZXBUWlR6V1V5djAxa0RQ?=
 =?utf-8?B?RmNObm5PTFJNYXZFVGtwcis1TjBpU0FTWlZNT2lzSG9pKzIzeWRRZG9laFZn?=
 =?utf-8?B?R3llZ3QrcXdGbEROcjRtN3VBUi82ckhBMjVGNGlQaUpJV2toSStHeG1kYlE1?=
 =?utf-8?B?QWJCNUkyaW5HTnhFKzNGZnZVd05xd29GNDJiUDkvWjQvcVM1MzV6eXpFMFo0?=
 =?utf-8?B?RS9LYWd6aG81ZE1ES3VhWEd4bnpYdmhmT005RWp1M2pKRmFRZUpyNGxlQWR6?=
 =?utf-8?B?Q2ZIalZmZkl4cnM0VTYwbVBzTmU5eTFKaGthTnVhTUh3OFFTMUFqOXF3cnkw?=
 =?utf-8?B?ajRMK3ZTMTBTSXlMYUxjR0FRUzJBSzQzamgvWGoralIrb0swRmRudmU4Q1Y2?=
 =?utf-8?B?RDZ6VU40c2w4UmJHaVlhSFlmTkpsY2FSOHNlQ1RLdHFKSFNWbWJTcE5iOUJz?=
 =?utf-8?B?ekNub29BckpOK1RHcXFqYmYzUUs3cUFWZm9uL0NGN3dSK3JvOSsyNWdPdUlW?=
 =?utf-8?B?ZEdXTUpad3p1Nko0ZndjME1tWUhQT1Rra0xmN2ZJUlNKTTJHb1NzS20vN201?=
 =?utf-8?B?ankyK3hpaEZEKzhDcmpzRFVWNlljK3owMThnamhidTV4WHQvdVErRGRkZmNV?=
 =?utf-8?B?M0RiUkN3U1hHU1ZRcUNmdU80RC9aNml6T1h2UUNPNThDSzAxWHBIQUx0RjJo?=
 =?utf-8?B?NUpaNFJjV09OZDJDbzJnMkFwVWF4Sk9KSk1KSE80emJOQzdRMmY1YjhiZFha?=
 =?utf-8?B?TjE5UmpUb2pmZWd4RzBOcU0zaCtHL1RkaDI4eFVFNDUwejBiOTNyQTlUdWpO?=
 =?utf-8?B?eXM1ajh3V3BiT0Foa0huSzh3bzhGZ1R6bGJ4VVN1MGdGQ2ZRVk1MRE5TVmFV?=
 =?utf-8?B?TG4veW9pcnlCVGVLb2wyMFZzQUVybWk0cENJaThnTEZ1bUljUHBCWFFsMjh4?=
 =?utf-8?B?Z3M0TlZvVGZoUzBPMVNmY0RERDdaMzNmU3dpWGwxbHBNUE4xYjJHUlVEUnkx?=
 =?utf-8?B?Und3Y0haUkk1MWljdzlDWktoVmYwMGwxRVVMZjk4VlJRZnF5UlFBZktxM1F6?=
 =?utf-8?Q?rYaIFPp52g+thw+Va2xHPNaHK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d14ca01e-aa44-44d2-5edd-08dc209649fd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 06:48:24.2544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDVedkDKqPwhkc4yS4XCrUq1OnurtZAe2110ykYPCHNwofZyvgxkiXQQioD6WUYf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5041
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Sharma,
 Deepak" <Deepak.Sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/26/2024 2:30 PM, Liang, Prike wrote:
> [AMD Official Use Only - General]
> 
>>
>> On 1/25/2024 8:52 AM, Prike Liang wrote:
>>> In the pm abort case the gfx power rail not turn off from FCH side and
>>> this will lead to the gfx reinitialized failed base on the unknown gfx
>>> HW status, so let's reset the gpu to a known good power state.
>>>
>>
>> From the description, this an APU only problem (or this patch could only
>> resolve APU abort sequence). However, there is no check for APU in the patch
>> below.
>>
> [Prike]  IIRC, there also has a similar problem on the dGPU side when suspend abort and
> now this patch is only drafted for a hot issue on the RV series. If need we can add a TODO
> item for drafting a more generic solution.
> 

If this addresses a specific issue, then better to check the specific IP
revision before presenting this as a generic one. Presently the patch
logic considers this as a generic for all soc15 asics.

>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
>>>  drivers/gpu/drm/amd/amdgpu/soc15.c         | 8 +++++++-
>>>  2 files changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 56d9dfa61290..4c40ffaaa5c2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -4627,6 +4627,11 @@ int amdgpu_device_resume(struct drm_device
>> *dev, bool fbcon)
>>>                     return r;
>>>     }
>>>
>>> +   if(amdgpu_asic_need_reset_on_init(adev)) {
>>> +           DRM_INFO("PM abort case and let's reset asic \n");
>>> +           amdgpu_asic_reset(adev);
>>> +   }
>>> +
>>
>> suspend_noirq is specific for suspend scenarios and not valid for freeze/thaw.
>> I guess this could trigger reset for successful restore on APUs.
>>
> [Prike] If doesn't run into noirq_suspend then still need further check whether the PSP TOS is still alive before gpu reset.
> 

AFAIU, for a successful resume from hibernate on APUs, TOS will still be
running. The patch will trigger a reset in such cases also.

Thanks,
Lijo

>>>     if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>>>             return 0;
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>> b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>> index 15033efec2ba..9329a00b6abc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>> @@ -804,9 +804,16 @@ static bool soc15_need_reset_on_init(struct
>> amdgpu_device *adev)
>>>     if (adev->asic_type == CHIP_RENOIR)
>>>             return true;
>>>
>>> +   sol_reg = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
>>> +
>>>     /* Just return false for soc15 GPUs.  Reset does not seem to
>>>      * be necessary.
>>>      */
>>
>> The comment now doesn't make sense.
>>
>> Thanks,
>> Lijo
>>
>>> +   if (adev->in_suspend && !adev->in_s0ix &&
>>> +                   !adev->pm_complete &&
>>> +                   sol_reg)
>>> +           return true;
>>> +
>>>     if (!amdgpu_passthrough(adev))
>>>             return false;
>>>
>>> @@ -816,7 +823,6 @@ static bool soc15_need_reset_on_init(struct
>> amdgpu_device *adev)
>>>     /* Check sOS sign of life register to confirm sys driver and sOS
>>>      * are already been loaded.
>>>      */
>>> -   sol_reg = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
>>>     if (sol_reg)
>>>             return true;
>>>
