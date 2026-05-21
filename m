Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE67CD343F
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 06:03:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC38B10F20B;
	Thu, 21 May 2026 06:03:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NIDQUR3e";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012029.outbound.protection.outlook.com [52.101.43.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F7AE10F20B
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 06:03:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+Q2gd3k2U7JGLUpa+l9c2i+aYgjvgLL9/WCVkQppRXwMVf+YujtI6QzBrgaepJrkF4ol0VbWqQImTFYGWahMiiiemAp3hvHqNJPTQK31cGqzzfce/MAeg6UbX6zUh5cyfWn552Q4lQAh3TM8RuwZ9xUc15P2Gp6hADiNpBwHyCUIrKAxm9eOOks4VPotH1yZAKL8WyKrCYmaXYEqpk4ekT/tNCS3UTHut9WJOwy+iwDFIT9GWvOmRqWgIThgXBPPuN9Ro+n/gnqErp8ekgzQjcjAoa91W2rHWtZIpAcrKvRNC7PGgfvUsfqAUSonsZMUGeQQfibFnVMtcAHE8rLXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VS/A5eEl1T3SwZ0DMi11pOe7dzWBFlz1WuEEjXwE16k=;
 b=iLS3WN8lYs2GAhzcreo5xc8ltseuEuQCtMIRfpJyJC2JfhcuU5Feq946CkOJtESHsiaqFMeYbY2O/qNTaUWSOgwNilxlGyJa3huCVKIIvceQakgA2W75cMkjA+T7KfRaV/nLhoWqMmIHqMLR5dTKmPHYT+3NuXICgDVBw6ex6c8VQqAg5EuD3MDSuZ1RhS7xrJm2WentrQY9dbGHzKunhVb24x1/ukpLUe5PDekLUnf0zWsbdTeC1ovBW1JwhHqCjYrPfK95P05ovDyiGIL7rgmegNUE3DkzaCl2Uo4NXLe1d9a95X3ZQQJ+hEEhAkyabwX+CQGWXGW7nu5MJu+A6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VS/A5eEl1T3SwZ0DMi11pOe7dzWBFlz1WuEEjXwE16k=;
 b=NIDQUR3e1e3Yq1ZBGWPtBA4/wiyhgvouGUwfiecHWvIjEA4ea+6x1OYypAF9SadMObCoHX9fXLPAy533qCSp1GkwNTT+xGE3mhIhaxMtdAifnEfZics5y80LS824Eiee5puI06wJuJACf8D+yEybhGoXqe1K7U2Cy0Z1PiNZzTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 06:03:15 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 06:03:15 +0000
Message-ID: <f88a7428-0296-4493-a8e6-45592e910f0b@amd.com>
Date: Thu, 21 May 2026 11:33:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: add ioctl to handle RAS poison error
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Yat Sin, David" <David.YatSin@amd.com>, "Russell, Kent"
 <Kent.Russell@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>
References: <20260515132702.1494187-1-yifan1.zhang@amd.com>
 <adc4600a-1d3c-4e79-9b6e-2e433bb3223e@amd.com>
 <CY5PR12MB63696C68EA513F50DD4C1226C10E2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <d706a70d-8b8d-4076-9bcb-e29c770c5c35@amd.com>
 <CY5PR12MB6369F10CC121FE8FBB7975B9C10E2@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CY5PR12MB6369F10CC121FE8FBB7975B9C10E2@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: 860f6f00-7666-407c-6e56-08deb6fea588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003|4143699003|11063799006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: Jxeov1jx9RKkcPBu1R7GiRuqQmgAZ3eSEWc7AoI6cW+iaiWTRn5Y1ZuPOiZxc41nLoH/ExRpnCQQtq4eDADvM7irFd7iwn62TYagy3tCgDLSQH9rli7nsg/laBFi2njWtyq0Lv+WrXetlbuuT+d8Hun7xxAE3/vEm7YJHMaAh7JfsS8eCIe4kgMgOMF5XDn530wXZnpGZF/6OSa0p6eC5ltvwxi4c1vbV4U0/2p1Qf2ajPIqWYtQQ0nfEMf3ld6ztaPU+URF0ARdmLwyECIMO9GftvLrP8BQ0uqsQXvjyBIVfanKnl7e92RqZiU5nYVH+Ed2YAgncQf9nun22If6m+m6QGODCZav3lAdaMAw+IGnycG5U5vwY4wceMZkFSQuJy7q5sI2SfM24c3WS4wWVk7r+87M1nDOi09eYWU/TA5/upqRkxlxQ5eiK002O98pVt6Ubg13ZkLO2Ce202CG42XBRGPMWdPkXXSarUVD4ClLAStoA4j6YfmbRFll/jzNPTbz0mM2IiuQtzTzn1+gUT8tRIU/w20cbpTa4/+s6dw/3NXtQ618WaEVKxvwTEgXXNpqrY7CX9QSR7BkJf/dDlfAkP3+QJ6fdORhOkN7siajfRPNyMIC96R35hWQJrJjZzkTp9WzOAqFriQAiE208UYDbfp6Wh3YryKgfbyndwYAfO5Z/HdW9spiyDTUQtc9NWOtr1uuX4Ggh/b8z7Xk8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(4143699003)(11063799006)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bndydmN1b1Q4Vk5GV2FEaE14N2JnNlVRR1Q3NG1tNGVMMGdYKy94UkpXbzBY?=
 =?utf-8?B?emE1TzUyZ2hHUnB1QTYzY05jYklldGIrWDBURVgzSFVINE9xRnlENEdGcUw2?=
 =?utf-8?B?bzB6OUJDd2k3aDVld0dhZGdiVG14cmhXaTJ0aGMxOTlPREo4TTlydzZPZDNJ?=
 =?utf-8?B?V3dxdFIvNnM5UWhwRk5MUmNkTXZSdGxoVEZTZmt4aFcya3djUXptWUpYdERl?=
 =?utf-8?B?TkJVOGU2WVRIbEdUemZKbW9vOWQ1RnNSWlEwMFlqZldVbkNYdlJnTXBXOEdS?=
 =?utf-8?B?WG1pQWFnRU9vZmMrajRFQUpKdFY0ZS9oM3drMm9qUkQ3MGdsUzg5cHVoNUhu?=
 =?utf-8?B?QW9sL2tZU3lwZ2RhdjZKTWVuSGl0Qm9pQmUvZFhXdXd3WHpjdC9oVlRVZmh3?=
 =?utf-8?B?dlhYZUYwa21JMlpvajlqSHE4alZhZnhlbEo0MDJySERZOUd2UFBtK25WVGpr?=
 =?utf-8?B?QWRpZzFzbFhER0RKa0RxbHpVaGJWaVpYNElCSFNNVS9sU1BtTmpwN0pPVFZU?=
 =?utf-8?B?czMwa2lveGdJeGZFNFpkUGwybjRkSWRxYjZZdU9wN1p3TU05YUNxSUIvVE1h?=
 =?utf-8?B?ZVZEbnRnNDFNUzlxNUZrOThkU3BMSEpRVk5xMWN2YTRBOE9TSHpnZzVHUGt1?=
 =?utf-8?B?eThtZldtbnhkTkxEeExrWmY2TFhrZ3BWaWJHcWQyNjgydEk3ckpRdHkwNnRH?=
 =?utf-8?B?a2Q5cWJlL1RWVnR3YnI0MXlMWVFuL1dmVUZMeFVrZVBFc1BBRWxqb0x0bStK?=
 =?utf-8?B?K0FkeWg4eGZhVUR6SHppT0lMcHR2K1dVSlFNVnIrRVpLdVNPVTlLT2x1NHl6?=
 =?utf-8?B?dkh5RmRMQ1dFSmJ2am44R1JlVUJpOXA1eVloUjQxdm1DWVcxNjBONXVKQ1do?=
 =?utf-8?B?bzJzaUtxdnQ2K0NIUGJtT2Qzc1NKRWZXdVZSSkhnMmszMVU1NEMrOFlHb0I1?=
 =?utf-8?B?T3RKVGRrd1k0RklTdWoreURoemlJYit4dFd3eHkybU91blhQQ3A0UlVTNUlM?=
 =?utf-8?B?dTU0cmlJek5JekNmWGZwWDNENEE4dlQvejIrRTd5K1JLUUFWNzl1WHVCVERL?=
 =?utf-8?B?S2ZBV0NiTEdUdTdCUWlrSmZRR0JvSkdQeDdLR3JwR3kzdmh0VCtleDcvd21O?=
 =?utf-8?B?ZnVHQ0JHOGZBdEY4T2JlMlhXWHJDcFFYUzFlSTZFcGRUMG1xZ1ZUVjJMMTZ6?=
 =?utf-8?B?OXVzUUJWNUh1K3lIei96VWsxb25pb1JSM2NWN09ZcmhxWDZLS25QZGZxWDZX?=
 =?utf-8?B?YU1EQjg5dWZ3eDM2dGVQZ0wwQzRVeUF4Rk5raEVpVmNvLzhkS1NYc0ZqczdQ?=
 =?utf-8?B?RFFaWDNacVJvTFJEOTJJRzdSRWlybXowN25MMUdlallkVzI4Z25GSGNYZkMv?=
 =?utf-8?B?OVljOEg3NTlnc2hkR1VpbTN0aS84ZkNYUE1iTnBZZ2N1a3BiQ0xhREhRM1pS?=
 =?utf-8?B?a1JIdWVCejlGOTVRMnArbU1pcWNsV2E3b3NIS01zZlVRRml4UHFMa2owSUpB?=
 =?utf-8?B?SzBGMFowWUEydTJqRkxmdUpQdmpzRUdWcTR6VHlpV3hhejdiYU1DYlB4TWg2?=
 =?utf-8?B?VmdBZ3Zod2RzRmI3ZUJKVlpUc0J2ME9rQm5GSlNhOWwzbUNYUFJFQ0F1blBy?=
 =?utf-8?B?dlg5L2NNc1VkR2J4eEV6TVk3d1Z1aXFVNHdRK3VtYXVRRmk1NUppdzhzKy8w?=
 =?utf-8?B?MHI5RjM0M0dudk1mRjc4MjFzcmFCOTN0dzJQQjFVV0kzcHExdnZ5M2xvdXlG?=
 =?utf-8?B?U1diZzd1S0l2eEl3cGZtSjdsTUU3U0pUWHdzZ1p2K0RFVUh0ZjdSajZ1cGNw?=
 =?utf-8?B?aTB2bjQydzFVZ2JLUlFZM0gwbG54Rng1SXM1bHlaM3h3V3pPNFdvRTkzeDA5?=
 =?utf-8?B?YlJKdmp6T3UrNy9NalR4SDN5ZU9TNU5waitSa0cyYVBJdG9YQUxDc2RpREZV?=
 =?utf-8?B?VHkxaGZqZmhZMGhFZWdrV0RLMWJSYm5vM0kyMGxuc3FsR2xaaXREY3RtbU9v?=
 =?utf-8?B?VXZWS1cyQTJVMkdreEtPNnlmTWxkbEFuYmJ4c1RQeWZTSFY4RWxiSlVEcS92?=
 =?utf-8?B?a2t1ZW9WMmJrV1lyVCt6S1N4REpBQW5Tb2x6WmQ1OTdLQjExUzQ1RU5WRXMr?=
 =?utf-8?B?Yzl6cnYrUmpEOWNtZUhlTy9XYVlZeVlhM2ZwY1V5THlscUpwNmNTdU5aM0NJ?=
 =?utf-8?B?a0xGOTlUUVZTYUJyNVlGNjVtUmZmWndleXFDSWFZbjV5VDdMM0Rsdk1LcVdX?=
 =?utf-8?B?VGtoVGRNeWF2bmRKRVhqWGtuVmI1STBoaE8xSDVhZ2ttb29FT015N2tmR3lo?=
 =?utf-8?Q?TbkG7qn9TdkpWaNWbe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 860f6f00-7666-407c-6e56-08deb6fea588
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 06:03:15.0606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G577uTigifv2h0TcHDIcGClPUP3LRzWDL5VbLKbmgJo4HY8zfIqHJFFbmQawbYba
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723
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



On 21-May-26 11:12 AM, Zhang, Yifan wrote:
> AMD General
> 
> Yes,  the mux of per device delay time happens in kfd_get_sigbus_delay_ms.  But we still need some per device storage to store all the delay times.
> 

Which is why I said it doesn't make any sense as the signal is sent to 
the process and not at a device level. Also, in XGMI systems, a poison 
error could affect all of the devices and the intention of the signal is 
to prevent propagation/consumption of bad data.

Thanks,
Lijo

>>> +/*
>>> + * Resolve the per-process SIGBUS opt-in setting by scanning all of
>>> +the
>>> + * process' KFD pdds (each backed by an amdgpu render fd). Returns
>>> +the
>>> + * "most lenient" value across all fds, in this priority:
>>> + *   DISABLED (no SIGBUS)  >  any non-zero timeout  >  0 (immediate)
>>> + *
>>> + * Rationale: if the app has explicitly opted in on any GPU it uses,
>>> +it
>>> + * wants the chance to handle the error in userspace.
>>> + */
>>> +static u32 kfd_get_sigbus_delay_ms(struct kfd_process *p) {
>>> +     u32 result = 0;
>>> +     int i;
>>> +
>>> +     for (i = 0; i < p->n_pdds; i++) {
>>> +             struct kfd_process_device *pdd = p->pdds[i];
>>> +             struct amdgpu_fpriv *drv_priv;
>>> +             u32 v;
>>> +
>>> +             if (!pdd || !pdd->drm_file)
>>> +                     continue;
>>> +             if (amdgpu_file_to_fpriv(pdd->drm_file, &drv_priv))
>>> +                     continue;
>>> +
>>> +             v = atomic_read(&drv_priv->kfd_sigbus_delay_ms);
>>> +             if (v == AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED)
>>> +                     return v;
>>> +             if (v > result)
>>> +                     result = v;
>>> +     }
>>> +
>>> +     return result;
>>> +}
> 
> Best Regards,
> Yifan
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, May 21, 2026 1:31 PM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Yat Sin, David <David.YatSin@amd.com>; Russell, Kent <Kent.Russell@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>
> Subject: Re: [PATCH v2] drm/amdgpu: add ioctl to handle RAS poison error
> 
> 
> 
> On 21-May-26 10:53 AM, Zhang, Yifan wrote:
>> AMD General
>>
>> The signal itself is indeed process-scoped, but the policy is naturally per-device, because the poison event has a dev associated with it. ROCr already holds one amdgpu render fd per device, so attaching the option to amdgpu_fpriv lets the app configure each device independently with the handle it already has.
>>
>> E.g.
>>
>> Device A is driven by a worker that has its own RAS handler: set DISABLED on fd(A).
>> Device B has no special handling: leave default / use a 10s safety timeout on fd(B).
>>
>> Storing a single process-wide value would force the app to pick one policy for all GPUs it has open, which doesn't match how ROCr layers per-device handlers.
>>
> 
>   From a process's perspective, what it wants to do - isn't it to delay the signal if any of the devices it uses gets into poison error situation and buy some time to clean up?
> 
> Thanks,
> Lijo
> 
>>
>> Best Regards,
>> Yifan
>>
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, May 21, 2026 12:35 PM
>> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;
>> Yat Sin, David <David.YatSin@amd.com>; Russell, Kent
>> <Kent.Russell@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>
>> Subject: Re: [PATCH v2] drm/amdgpu: add ioctl to handle RAS poison
>> error
>>
>>
>>
>> On 15-May-26 6:57 PM, Yifan Zhang wrote:
>>> Add a new DRM_IOCTL_AMDGPU_USER_OPTIONS ioctl with the
>>> AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY option, allowing userspace
>>> (ROCr) to control per-process SIGBUS delivery.
>>>
>>> Userspace for this can be found at:
>>> https://github.com/ROCm/rocm-systems/pull/6148
>>>
>>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>>> ---
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  12 +++
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   1 +
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  29 ++++++
>>>     drivers/gpu/drm/amd/amdkfd/kfd_events.c | 114 +++++++++++++++++++++++-
>>>     include/uapi/drm/amdgpu_drm.h           |  25 ++++++
>>>     5 files changed, 179 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index 5d7bfa59424a..6a5459b59af2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -455,6 +455,16 @@ struct amdgpu_fpriv {
>>>
>>>         /** GPU partition selection */
>>>         uint32_t                xcp_id;
>>> +
>>> +     /**
>>> +      * @kfd_sigbus_delay_ms: Per-fd KFD SIGBUS delivery option (set via
>>> +      * DRM_IOCTL_AMDGPU_USER_OPTIONS / AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY).
>>> +      *
>>> +      *   0          - send SIGBUS immediately (default)
>>> +      *   0xFFFFFFFF - suppress SIGBUS delivery
>>> +      *   other      - delay SIGBUS delivery by this many milliseconds
>>> +      */
>>> +     atomic_t                kfd_sigbus_delay_ms;
>>>     };
>>>
>>>     int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv
>>> **fpriv); @@ -1467,6 +1477,8 @@ int amdgpu_enable_vblank_kms(struct drm_crtc *crtc);
>>>     void amdgpu_disable_vblank_kms(struct drm_crtc *crtc);
>>>     int amdgpu_info_ioctl(struct drm_device *dev, void *data,
>>>                       struct drm_file *filp);
>>> +int amdgpu_user_options_ioctl(struct drm_device *dev, void *data,
>>> +                           struct drm_file *filp);
>>>
>>>     /*
>>>      * functions used by amdgpu_encoder.c diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index 99688391e70b..cad18bd6f8b3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -3078,6 +3078,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>>>         DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>         DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>         DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES,
>>> amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>> +     DRM_IOCTL_DEF_DRV(AMDGPU_USER_OPTIONS,
>>> +amdgpu_user_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>     };
>>>
>>>     static const struct drm_driver amdgpu_kms_driver = { diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> index 24526e92f9b8..7903587b8bbb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> @@ -1423,6 +1423,35 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>>         return 0;
>>>     }
>>>
>>> +/**
>>> + * amdgpu_user_options_ioctl - set per-fd user options
>>> + *
>>> + * @dev: drm dev pointer
>>> + * @data: pointer to struct drm_amdgpu_user_options
>>> + * @filp: drm file
>>> + *
>>> + * Sets options stored on the per-file amdgpu_fpriv. Currently the
>>> +only
>>> + * supported option is %AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
>>> +which
>>> + * controls how KFD delivers SIGBUS for poison/RAS events to the
>>> +calling
>>> + * process (immediate, suppressed, or delayed by N milliseconds).
>>> + */
>>> +int amdgpu_user_options_ioctl(struct drm_device *dev, void *data,
>>> +                           struct drm_file *filp) {
>>> +     struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>> +     struct drm_amdgpu_user_options *args = data;
>>> +
>>> +     switch (args->op) {
>>> +     case AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY:
>>> +             atomic_set(&fpriv->kfd_sigbus_delay_ms,
>>> +                        args->kfd_sigbus_delay.value);
>>
>> Why this is stored at device level? A signal is process specific. I think the delay should be associated with the process regardless of multi-dev scenario.
>>
>> Thanks,
>> Lijo
>>
>>> +             return 0;
>>> +     default:
>>> +             DRM_DEBUG_KMS("Invalid user option op %u\n", args->op);
>>> +             return -EINVAL;
>>> +     }
>>> +}
>>> +
>>>     /**
>>>      * amdgpu_driver_open_kms - drm callback for open
>>>      *
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>> index e9be798c0a2b..2ff6348105b7 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>> @@ -29,10 +29,12 @@
>>>     #include <linux/uaccess.h>
>>>     #include <linux/mman.h>
>>>     #include <linux/memory.h>
>>> +#include <linux/workqueue.h>
>>>     #include "kfd_priv.h"
>>>     #include "kfd_events.h"
>>>     #include "kfd_device_queue_manager.h"
>>>     #include <linux/device.h>
>>> +#include <uapi/drm/amdgpu_drm.h>
>>>
>>>     /*
>>>      * Wrapper around wait_queue_entry_t @@ -1337,6 +1339,115 @@ void
>>> kfd_signal_reset_event(struct kfd_node *dev)
>>>         srcu_read_unlock(&kfd_processes_srcu, idx);
>>>     }
>>>
>>> +/*
>>> + * Per-process opt-in for poison-consumption SIGBUS handling.
>>> + *
>>> + * Default: kernel sends SIGBUS to the process immediately when
>>> +poison is
>>> + * consumed, in addition to delivering the KFD HW/MEMORY exception events.
>>> + *
>>> + * Userspace (ROCr) can opt-in per-process via the
>>> + * DRM_IOCTL_AMDGPU_USER_OPTIONS /
>>> +AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
>>> + * option. This lets the app's registered system-event callback
>>> +handle the
>>> + * RAS error first, instead of being killed by SIGBUS.
>>> + *
>>> + * Encoded value (set on any of the process' amdgpu render fds):
>>> + *   0          - default: SIGBUS immediately (no opt-in)
>>> + *   0xFFFFFFFF - opt-in, never escalate to SIGBUS
>>> + *   N (other)  - opt-in, escalate to SIGBUS after N ms if app does not
>>> + *                handle the error in time (safety timeout)
>>> + *
>>> + * Per-process scope: the option is honored if ANY of the process'
>>> +amdgpu
>>> + * fds has been configured. This matches the slide deck's
>>> +"Per-process,
>>> + * App set at init" semantics, while keeping the UAPI on amdgpu
>>> +where ROCr
>>> + * sets it.
>>> + */
>>> +struct kfd_sigbus_delayed_work {
>>> +     struct delayed_work work;
>>> +     struct kfd_process *p;
>>> +};
>>> +
>>> +static void kfd_signal_sigbus_delayed_fn(struct work_struct *work) {
>>> +     struct kfd_sigbus_delayed_work *dw = container_of(to_delayed_work(work),
>>> +                             struct kfd_sigbus_delayed_work, work);
>>> +     struct kfd_process *p = dw->p;
>>> +
>>> +     if (p->lead_thread)
>>> +             send_sig(SIGBUS, p->lead_thread, 0);
>>> +
>>> +     kfd_unref_process(p);
>>> +     kfree(dw);
>>> +}
>>> +
>>> +/*
>>> + * Resolve the per-process SIGBUS opt-in setting by scanning all of
>>> +the
>>> + * process' KFD pdds (each backed by an amdgpu render fd). Returns
>>> +the
>>> + * "most lenient" value across all fds, in this priority:
>>> + *   DISABLED (no SIGBUS)  >  any non-zero timeout  >  0 (immediate)
>>> + *
>>> + * Rationale: if the app has explicitly opted in on any GPU it uses,
>>> +it
>>> + * wants the chance to handle the error in userspace.
>>> + */
>>> +static u32 kfd_get_sigbus_delay_ms(struct kfd_process *p) {
>>> +     u32 result = 0;
>>> +     int i;
>>> +
>>> +     for (i = 0; i < p->n_pdds; i++) {
>>> +             struct kfd_process_device *pdd = p->pdds[i];
>>> +             struct amdgpu_fpriv *drv_priv;
>>> +             u32 v;
>>> +
>>> +             if (!pdd || !pdd->drm_file)
>>> +                     continue;
>>> +             if (amdgpu_file_to_fpriv(pdd->drm_file, &drv_priv))
>>> +                     continue;
>>> +
>>> +             v = atomic_read(&drv_priv->kfd_sigbus_delay_ms);
>>> +             if (v == AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED)
>>> +                     return v;
>>> +             if (v > result)
>>> +                     result = v;
>>> +     }
>>> +
>>> +     return result;
>>> +}
>>> +
>>> +static void kfd_signal_sigbus_with_delay(struct kfd_node *dev,
>>> +                                      struct kfd_process *p) {
>>> +     u32 delay_ms = kfd_get_sigbus_delay_ms(p);
>>> +     struct kfd_sigbus_delayed_work *dw;
>>> +
>>> +     if (delay_ms == AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED) {
>>> +             dev_info(dev->adev->dev,
>>> +                      "SIGBUS suppressed for process %s(pid:%d): app opted in to handle RAS error\n",
>>> +                      p->lead_thread->comm, p->lead_thread->pid);
>>> +             return;
>>> +     }
>>> +
>>> +     if (delay_ms == 0)
>>> +             goto send_now;
>>> +
>>> +     dw = kzalloc(sizeof(*dw), GFP_ATOMIC);
>>> +     if (!dw)
>>> +             goto send_now;
>>> +
>>> +     /* Take an extra reference for the delayed worker. */
>>> +     kref_get(&p->ref);
>>> +     dw->p = p;
>>> +     INIT_DELAYED_WORK(&dw->work, kfd_signal_sigbus_delayed_fn);
>>> +
>>> +     dev_info(dev->adev->dev,
>>> +              "Deferring SIGBUS to process %s(pid:%d) by %u ms (RAS error opt-in safety timeout)\n",
>>> +              p->lead_thread->comm, p->lead_thread->pid, delay_ms);
>>> +     schedule_delayed_work(&dw->work, msecs_to_jiffies(delay_ms));
>>> +     return;
>>> +
>>> +send_now:
>>> +     send_sig(SIGBUS, p->lead_thread, 0); }
>>> +
>>>     void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
>>>     {
>>>         struct kfd_process *p = kfd_lookup_process_by_pasid(pasid,
>>> NULL); @@ -1345,7 +1456,6 @@ void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
>>>         struct kfd_event *ev;
>>>         uint32_t id = KFD_FIRST_NONSIGNAL_EVENT_ID;
>>>         int user_gpu_id;
>>> -
>>>         if (!p) {
>>>                 dev_warn(dev->adev->dev, "Not find process with pasid:%d\n", pasid);
>>>                 return; /* Presumably process exited. */ @@ -1391,7
>>> +1501,7 @@ void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
>>>         rcu_read_unlock();
>>>
>>>         /* user application will handle SIGBUS signal */
>>> -     send_sig(SIGBUS, p->lead_thread, 0);
>>> +     kfd_signal_sigbus_with_delay(dev, p);
>>>
>>>         kfd_unref_process(p);
>>>     }
>>> diff --git a/include/uapi/drm/amdgpu_drm.h
>>> b/include/uapi/drm/amdgpu_drm.h index 9f3090db2f16..dfc91d25c80d
>>> 100644
>>> --- a/include/uapi/drm/amdgpu_drm.h
>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>> @@ -58,6 +58,7 @@ extern "C" {
>>>     #define DRM_AMDGPU_USERQ_SIGNAL             0x17
>>>     #define DRM_AMDGPU_USERQ_WAIT               0x18
>>>     #define DRM_AMDGPU_GEM_LIST_HANDLES 0x19
>>> +#define DRM_AMDGPU_USER_OPTIONS              0x1A
>>>
>>>     #define DRM_IOCTL_AMDGPU_GEM_CREATE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>>     #define DRM_IOCTL_AMDGPU_GEM_MMAP   DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>> @@ -79,6 +80,7 @@ extern "C" {
>>>     #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL       DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>>>     #define DRM_IOCTL_AMDGPU_USERQ_WAIT DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>>>     #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES
>>> DRM_IOWR(DRM_COMMAND_BASE
>>> + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>>> +#define DRM_IOCTL_AMDGPU_USER_OPTIONS        DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USER_OPTIONS, struct drm_amdgpu_user_options)
>>>
>>>     /**
>>>      * DOC: memory domains
>>> @@ -1673,6 +1675,29 @@ struct drm_amdgpu_info_uq_metadata {
>>>     #define AMDGPU_FAMILY_GC_11_5_4                     154 /* GC 11.5.4 */
>>>     #define AMDGPU_FAMILY_GC_12_0_0                     152 /* GC 12.0.0 */
>>>
>>> +/*
>>> + * Definition of user options
>>> + *
>>> + * option: AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
>>> + *    0:          Disable sigbus delay - SIGBUS will be raised immediately
>>> + *    0xFFFFFFFF: SIGBUS will not be raised
>>> + *    other:      Set the sigbus delay in milliseconds
>>> + */
>>> +#define AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY              0
>>> +
>>> +#define AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED        0xFFFFFFFFu
>>> +
>>> +struct drm_amdgpu_user_options {
>>> +     __u32 op;
>>> +     union {
>>> +             struct {
>>> +                     __u16 value;
>>> +                     __u16 _pad;
>>> +             } kfd_sigbus_delay;
>>> +             __u32 _pad;
>>> +     };
>>> +};
>>> +
>>>     #if defined(__cplusplus)
>>>     }
>>>     #endif
>>
> 

