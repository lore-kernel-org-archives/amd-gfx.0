Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C42C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 12:50:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC5BA10F22B;
	Tue, 24 May 2022 12:50:35 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2041.outbound.protection.outlook.com [40.107.95.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66CD410F22B
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 12:50:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYqtFYL+hvv6hPuesjguoDFrdc/wcGmLHnr0Rv5D0SwbeBeZIC8blDSSOVrRK6JLVnTKrfiS0EW8rna/CzUztKqzs0tzwVKWpEgnmwPrZUX/XMRjZcxG2976aunsuUJneZVUcLgSYv26RkwXv1UrTlO/dS0ZWonyvwhYx8QHMtsUxQuFwcLl7yka+vf53SWUszNaT6H9qRIohSNxIsz43JcLS2fVC/mIeWAyhA4leG0Vxex2OkTnm3ou4zjyf4e8YC75+SJyeOet5sykbypaKXrgm1fArMBq7krkw/8wV7+txLYyCde5xKbPSJtfmKzUFWsJ+WMRAwsUNqxF0haRwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOG/4XBG1w+YkjlgntjjoOW8hA2zT9WHP47Dr8WpU0s=;
 b=U8/QrHHB3yIOFDYxFYrXGGry3JOiWSEIFzOJ1sNHuReX9jDlPi/3DbYabwVxsjdAR/LpkuNT4sqQnuA4G1oQ2hOVNxlhQ1EZU9w5J1b+fgBjChpWHYI3VivRI8sNtNFsXZDGi90PkftjikaZE0XY4Fm99Savo1VR+c/ITtxby5EpSha4YckKQXLF/s9n9u0vvN1KKGdKlDhv7RAqLLvl9uqh6VWBE4Eh6aIfPgpSp9EC00POJykGVOZ5RZhkghF4xsf5kbCtJaNAYHw86J9n06duaT1+rFZA+MSUP8YfxzSl1U2vxKIFPz8SA8T6I6eQwmvQUL6ZGS+b8un7s3ABfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOG/4XBG1w+YkjlgntjjoOW8hA2zT9WHP47Dr8WpU0s=;
 b=fr1HQHgR1Mzoh9qkcvnEp0+hUMTpnKvs2hwStRl7Inc8QFOEH1ZGECqA63SNa5uxop1aJxLwlOe8bRdW0UWmTeppaNG07+OOHf1TAmnqFQHRLVBU523wG8n/rS2PSj6tXdNN3eieM6z/VQQ+4a+5a/AnwliAjH/h4YGpcnaDERo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DM6PR12MB2811.namprd12.prod.outlook.com (2603:10b6:5:45::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.21; Tue, 24 May
 2022 12:50:29 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::5149:1152:d389:81e3]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::5149:1152:d389:81e3%2]) with mapi id 15.20.5227.023; Tue, 24 May 2022
 12:50:29 +0000
Message-ID: <ae53629c-7922-6a17-c162-e9397386106b@amd.com>
Date: Tue, 24 May 2022 14:50:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1 2/2] drm/amdgpu: adding device coredump support
Content-Language: en-US
To: "Somalapuram, Amaranath" <asomalap@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220520134909.92781-1-Amaranath.Somalapuram@amd.com>
 <20220520134909.92781-2-Amaranath.Somalapuram@amd.com>
 <588a0599-7d0c-0041-9877-4429b416e7ed@amd.com>
 <18da952a-25d7-1d52-5d1b-016432066211@amd.com>
 <2e8b9ebe-3d1f-40e5-73e3-54607a8045cb@amd.com>
 <7cdad508-17b9-17b0-59f2-de0bf98ed780@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <7cdad508-17b9-17b0-59f2-de0bf98ed780@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0330.eurprd06.prod.outlook.com
 (2603:10a6:20b:45b::9) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28aa6248-c9f6-4bde-2eff-08da3d83fb3c
X-MS-TrafficTypeDiagnostic: DM6PR12MB2811:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB28113CFBC83FBA273A3A51DDF2D79@DM6PR12MB2811.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pn63s0RSfLM1ffgcuNjo4ERynra/t8iI1PzzM3f3mGISsT863q9fYg1mp5Cbqx4ni2HssD04zLdP2Cb6ardaY9xc6mT1sCEyn+LUxgLlLizDNpofSL8lwtgymOvVig5EAgOYnjqLYyZdJ2D18cN40esTxMRBXNRwxxUHHJ1II/l3dgPsDBtRDMg3lJBy21nWBPw3ENAUSP4qVQr0T6CGljx4/8t2P1x2/k3VFD50r/VBF7A64fBxehP6WNXBmcPZ1msNc0i4IsdhLvPSR08JZE/4khfLzQy9lXvXzpgyAlkJHkHWm/YLJ6bOfVqtWvx72C2qe/VitIKALjWj/wi7A4FmgJnbFfmg8akIduaR9x4bIgoDZnFuJfzarSwm9tYJZVULjSr3rqnUlrBpV6Yw92PrYvpw/Xkv5w73y2nhjXp+mv8vnOWrXWiUef7U1BpUZSo+ZeZQDF9A58hWpd2Uk/N5w17ACS6R93qFl1TUjmproDk74eyAteV8jzvGDPje7J+AYNHzmEGv7d2x0Fsq7PMm6kWsw+3zpKT/QENwNDHP/np2ZpQ4Z447dY4U/eW9E2lJXwcIEE+x2w9uxJPbVpI2mMmaOedQU+N4QZeOOSqJjr3cU7LcG1djUOou2jKAW1fOi7t9gfHsFayEVcWlbRshpglVKRXvVL2RmsGy6XRIUySzTokmp6OTpKaFzoyTws1RjNNfmmAsz/6lJLKfvhkNbPiReiM3nDSHVmkmsME=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(316002)(5660300002)(4326008)(53546011)(36756003)(31686004)(86362001)(31696002)(83380400001)(66476007)(66556008)(66946007)(8936002)(2906002)(6486002)(110136005)(186003)(2616005)(6506007)(6666004)(6512007)(38100700002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejBiYkM0Y1pTaVI3OVZMSHVaWlRjMzExWHNUWmx3dkFPSVoxRWtMT3IvUHRr?=
 =?utf-8?B?czhMaURuWWp0SVpKd1NMbTNEakVUcUhKbEE4WEhUNTh1MXV0M2JvWHhPR3RS?=
 =?utf-8?B?S1BvZUovNExpc2hLMlZxZ1JyMlFXTEVpUWNibFBnLytVM1ZpWjNnR2JzUnhX?=
 =?utf-8?B?MGJSUGRlbjBPd2tnaG1BN2NzQ3FhSVU2WkpiMjN1REw3Tkh4V1VjdytPcXVV?=
 =?utf-8?B?NzJIRWtPcmNrQ2tNRlY4OUxITC9uY09DSHdOaTdsYmNmeCtyd0RaeUwyWGth?=
 =?utf-8?B?QUJSb0IvN0VrdG01VjdZUHpPcG9tTndxRGhoTFoxcGtYQWJlalhSYTBKOCtp?=
 =?utf-8?B?UlRaUlMvZTVXUkJlaWpoMWpUVEs0QytUbHQ2VWh1ZUJ3TVN6WlY0TnhGVlJ1?=
 =?utf-8?B?bVY4dXIvZUJNUXAyZVdsMmF6NU9UWSt6MStOeW8wamF6UVFCOUozY1BMc2Rl?=
 =?utf-8?B?SEdjUVJpdC9hRzFpbGF2UENJUXRqNk85S1ZVMWtvVUYzN0JFRXF6bFRxRTRj?=
 =?utf-8?B?SnZncDk0ZTFuaXdkVFpmRzBIbDlYcDZZRENkMVpJTE11TFFlZkg5aVh0MGVl?=
 =?utf-8?B?czRDVWNhd2ljanJHWHE1MlY2d0h5K1IxVTArT09oSi9ySmd2cjdCbHpxQlpk?=
 =?utf-8?B?cEhNNktua0Y5MU5zeklCajB3blZHcSt1d2NkSmF4dnRYTzRZWjBucEhZRzJF?=
 =?utf-8?B?VzZTMHRaSzVreFd5R29yQ2w3YVZKR2lFZHNPZmY2b2wrbnc1N01kSmplMGJS?=
 =?utf-8?B?bCtsbW1yZC93OXcvSFdqS0pvOVhuV1B0N0hGWWtOMlJEdWNHOFlkcXM1VFNG?=
 =?utf-8?B?alNMdnpQSVNsME9SZVVhYktidjU4ZUlURzZpeFNGb0dyOXEzN2xyb2NRMVFq?=
 =?utf-8?B?UVZDUmRWWjM3NlFhakNLenIyczhuSWdwWlFDUStDdmRNNXRWNjQ5S1hGN3hH?=
 =?utf-8?B?Q1d0cjhNcldSU2VkK0RGT3pXSlg4TmZnMzhIRm01TklWQTVFdU5sRTFpRWZY?=
 =?utf-8?B?UjVJUTFyeWplR2l6Z3pValdjbTRDTWtYcHZuQnZzUWNSRzU2YjMybExHN2Ev?=
 =?utf-8?B?TDdRUW91SnR1REFRVjZjWkkyb3VzR0VlWmJzK1hDSndxM1FDelcrSHJ5NGFS?=
 =?utf-8?B?RGpTWEJYM0RVWG9KZDlvV25wT3ZQN01OSEdXSDhzSzliZTZjTWJUK0JvTm9D?=
 =?utf-8?B?SDNqOXFoSXloMTNHNkFKcmVUeUY1eDZyUFlzNVdRelhBbjlKQ2x3cDZiSzY0?=
 =?utf-8?B?c0t0dEhlckgweHZqbnF0cnpuVUdIRkNDd3l0OEcwM1RWeXduVE14S2V0WVQy?=
 =?utf-8?B?S25LQ0toS3ZqTG1TUUYyNUhTN2JCVk5OV3dyVjQrTHliaFFpRmdVMm5oNndN?=
 =?utf-8?B?TndWYzlFNG52KzhkeXVJZVhJQ0E1bW5mQlduUE0rN3RWMHVTd0c2ODhzaUtN?=
 =?utf-8?B?L3FkNFFuYlczMFVNL3NVeHR4OTJ1VDVOWDFqbWs3aEc2UzFUOXVNL1QwZlpP?=
 =?utf-8?B?LzVHdndZeitPRmJLVS9FbUtCdjM0dWdndW5uUVNvcnJYd2wwT3ZTNjdOMk90?=
 =?utf-8?B?QmRpcXNaUyt1VGV5eStFQ3RZZGNObGsxWTFNMDQ4MWxLTVkvS2U2dTJjUlB0?=
 =?utf-8?B?MjhFNzU2VVVyWnREWjhSekpXWVhYUWthWllZTENKc3pRUjdpekIzbjRSdlln?=
 =?utf-8?B?SjIyRUQvTjMrc2tKS0ovbTdwOG1MUVAweVhIR0FxR2pqQXprRzY2bEZ5TCtD?=
 =?utf-8?B?WXE0UDVpd1NEbFRnTTl5Z1RLQzNWTmVIanYvQ1prMXpyemQraU9kSE9zUStx?=
 =?utf-8?B?WHBkTTdjeHJ1SkpyUHpkekNXK04ycDNPRmtLQ25OeTZxbGpPZVpYdE5aRWZr?=
 =?utf-8?B?cS9HS3F3TlFxZTZyUEM2bXJUSUtJMXFHbEljaXJqWDl2dzJ3Kzh0ellwelFi?=
 =?utf-8?B?cHorWWd2N1hJNXdBMm83UXJHTFFhNVovc1NkTnV5bzlWdTBqdVhBbmJ3WVYx?=
 =?utf-8?B?TzRXblhkTjdSMEgraGR3L0dMSmdVWG96NkZ2QUFWbUcrMDVMWTZQM0x0ZjVy?=
 =?utf-8?B?akEvOGhKRHhKTlk4Zk41WFBVOTd3K1JWUi8zR2Z3amR1cDRDcUVUcnp2Mk1l?=
 =?utf-8?B?emdiN0RWa1lPeGcwNkQwV0p5MkR5VW12SU40WTV6am9CcHExUmx5V2RRWk5s?=
 =?utf-8?B?N0p3WnNuMnYybm5qOEJleEJ6b05uU1AxUGxuWGNBRktoQ0JIRG5qMXIwVVN5?=
 =?utf-8?B?dUtpOERCNDVnMzljZTJuZjV3NTJ2Y3g5c1Q3ZEJwY0N2Qjlya2VzbEl0VlI0?=
 =?utf-8?B?eVB4ZEhwNHBWOGVvaVNXOU9wTU9wQ0cvOWF3S0oxUVRZN0l2cTVGYmEvK2Vx?=
 =?utf-8?Q?0+MvKCY2WE/k+6X5WB5wyHUthjrIP+KWu5MjWrC0VNak9?=
X-MS-Exchange-AntiSpam-MessageData-1: 9LwMwmK2kOGvPQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28aa6248-c9f6-4bde-2eff-08da3d83fb3c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 12:50:29.4676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpvhGxh5IXW3T6kifFnOnYA/A2dPDj/51nMhwx7s+L10DPmoEJUNg8xZ3V6z3gg5i8jNiO7PRSHN0odZbkheSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2811
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/24/2022 2:10 PM, Somalapuram, Amaranath wrote:
> 
> On 5/24/2022 3:23 PM, Sharma, Shashank wrote:
>>
>>
>> On 5/24/2022 8:42 AM, Somalapuram, Amaranath wrote:
>>>
>>> On 5/20/2022 7:52 PM, Sharma, Shashank wrote:
>>>>
>>>>
>>>> On 5/20/2022 3:49 PM, Somalapuram Amaranath wrote:
>>>>> Added device coredump information:
>>>>> - Kernel version
>>>>> - Module
>>>>> - Time
>>>>> - VRAM status
>>>>> - Guilty process name and PID
>>>>> - GPU register dumps
>>>>>
>>>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 59 
>>>>> ++++++++++++++++++++++
>>>>>   2 files changed, 62 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> index c79d9992b113..f28d9c563f74 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> @@ -1044,6 +1044,9 @@ struct amdgpu_device {
>>>>>       uint32_t                        *reset_dump_reg_list;
>>>>>       uint32_t            *reset_dump_reg_value;
>>>>>       int                             num_regs;
>>>>> +    struct amdgpu_task_info reset_context_task_info;
>>>>> +    bool reset_context_vram_lost;
>>>>
>>>> How about drop the 'context' from name and just reset_task_info and 
>>>> reset_vram_lost ?
>>> OK.
>>>>
>>>>> +    struct timespec64 reset_time;
>>>>>         struct amdgpu_reset_domain    *reset_domain;
>>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index 963c897a76e6..f9b710e741a7 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -32,6 +32,8 @@
>>>>>   #include <linux/slab.h>
>>>>>   #include <linux/iommu.h>
>>>>>   #include <linux/pci.h>
>>>>> +#include <linux/devcoredump.h>
>>>>> +#include <generated/utsrelease.h>
>>>>>     #include <drm/drm_atomic_helper.h>
>>>>>   #include <drm/drm_probe_helper.h>
>>>>> @@ -4733,6 +4735,55 @@ static int amdgpu_reset_reg_dumps(struct 
>>>>> amdgpu_device *adev)
>>>>>       return 0;
>>>>>   }
>>>>>   +#ifdef CONFIG_DEV_COREDUMP
>>>>> +static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
>>>>> +        size_t count, void *data, size_t datalen)
>>>>> +{
>>>>> +    struct drm_printer p;
>>>>> +    struct amdgpu_device *adev = data;
>>>>> +    struct drm_print_iterator iter;
>>>>> +    int i;
>>>>> +
>>>>
>>>> A NULL check for 'buffer' here could prevent a segfault later.
>>>>
>>> Agreed.
>>>>> +    iter.data = buffer;
>>>>> +    iter.offset = 0;
>>>>> +    iter.start = offset;
>>>>> +    iter.remain = count;
>>>>> +
>>>>> +    p = drm_coredump_printer(&iter);
>>>>> +
>>>>> +    drm_printf(&p, "**** AMDGPU Device Coredump ****\n");
>>>>> +    drm_printf(&p, "kernel: " UTS_RELEASE "\n");
>>>>> +    drm_printf(&p, "module: " KBUILD_MODNAME "\n");
>>>>> +    drm_printf(&p, "time: %lld.%09ld\n", adev->reset_time.tv_sec, 
>>>>> adev->reset_time.tv_nsec);
>>>>> +    if (adev->reset_context_task_info.pid)
>>>>> +        drm_printf(&p, "process_name: %s PID: %d\n",
>>>>> + adev->reset_context_task_info.process_name,
>>>>> + adev->reset_context_task_info.pid);
>>>> Please fix the alignment of print variables.
>>>>
>>> I will cross check this.
>>>>> +
>>>>> +    if (adev->reset_context_vram_lost)
>>>>> +        drm_printf(&p, "VRAM is lost due to GPU reset!\n");
>>>>> +    if (adev->num_regs) {
>>>>> +        drm_printf(&p, "AMDGPU register dumps:\nOffset: Value:\n");
>>>>> +
>>>>> +        for (i = 0; i < adev->num_regs; i++)
>>>>> +            drm_printf(&p, "0x%08x: 0x%08x\n",
>>>>> +                    adev->reset_dump_reg_list[i],
>>>>> +                    adev->reset_dump_reg_value[i]);
>>>>> +    }
>>>>> +
>>>>> +    return count - iter.remain;
>>>>> +}
>>>>> +
>>>>> +static void amdgpu_reset_capture_coredumpm(struct amdgpu_device 
>>>>> *adev)
>>>>> +{
>>>>> +    struct drm_device *dev = adev_to_drm(adev);
>>>>> +
>>>>> +    ktime_get_ts64(&adev->reset_time);
>>>>> +    dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_KERNEL,
>>>>> +            amdgpu_devcoredump_read, NULL);
>>>> instead of registering NULL as free function, I would prefer you to 
>>>> have a dummy no_op free function registered, which we can consume if 
>>>> something changes.
>>> you mean something like this (function without any code):
>>> staticvoidamdgpu_devcoredump_free(void*data)
>>> {
>>> }
>>
>> Yes, precisely.
>>
>>>>> +}
>>>>> +#endif
>>>>> +
>>>>>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>>>                struct amdgpu_reset_context *reset_context)
>>>>>   {
>>>>> @@ -4817,6 +4868,14 @@ int amdgpu_do_asic_reset(struct list_head 
>>>>> *device_list_handle,
>>>>>                       goto out;
>>>>>                     vram_lost = 
>>>>> amdgpu_device_check_vram_lost(tmp_adev);
>>>>> +#ifdef CONFIG_DEV_COREDUMP
>>>>> +                tmp_adev->reset_context_vram_lost = vram_lost;
>>>>> +                tmp_adev->reset_context_task_info.pid = 0;
>>>> why is the PID hardcoded to 0 ?
>>> in case of reset context reset_context->job->vm  is null (possibility 
>>> that reset can be non VM related).
>>> If we don't set tmp_adev->reset_context_task_info.pid = 0, it will 
>>> show previous reset valid PID.
>>>
>>
>> But when the VM is not NULL, are we updating this PID somewhere ? I 
>> did not see that happening in this series.
> This is the only place where PID get updated.
> For example sequence of operation like:
> 1st reset:
> -valid VM and tmp_adev->reset_context_task_info.pid is set to some valid 
> PID
> 2nd reset:
> -invalid VM
> -tmp_adev context will remain same (adev context will be same after 
> successful  GPU reset sequence).
> -tmp_adev->reset_context_task_info.pid will be holding 1st reset PID value
> 
> if we don't set it 0, it can give wrong PID.
>

I get your point, and agree, that when the vm is invalid, PID is invalid 
so we should send pid=0. But where are you handling the case when VM is 
valid and pid is valid ?

- Shashank

> Regards,
> S.Amarnath
>>
>> - Shashank
>>
>>>
>>> Regards,
>>> S.Amarnath
>>>>> +                if (reset_context->job && reset_context->job->vm)
>>>>> +                    tmp_adev->reset_context_task_info =
>>>>> + reset_context->job->vm->task_info;
>>>>> +                amdgpu_reset_capture_coredumpm(tmp_adev);
>>>>> +#endif
>>>>>                   if (vram_lost) {
>>>>>                       DRM_INFO("VRAM is lost due to GPU reset!\n");
>>>>>
>>>> - Shashank
>>>>                      amdgpu_inc_vram_lost(tmp_adev);
