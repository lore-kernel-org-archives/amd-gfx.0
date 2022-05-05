Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BA2C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 15:07:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 615F410E655;
	Thu,  5 May 2022 15:07:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC9E810E652
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 15:07:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKtCjDmYlzhYvrpN3MCcuti5xvaO/riKXXCu5EKm4GQtPL8n4jPPCNtv1RGNPl9m+dxsf5uZ1mo3N30c+EC3+I6gTT4uJnUSOFqTmc45vZn6fwc+ScNen0tRpqAjK9pIt1q1Egv7PMIHCGl9gK2444d2H6NOi43TkKDK8ByV4IuLpPkhzhHRCkeQrftOlkmmuPMz+L4Wwq2XetKWydO5I+8CL3GjPVybn25Sqzte7t9RVGX4deW82ATTA/UjviDZp5BF/yMWX/Knw1D7336v7/40/0D6x9X0iAdPKIaafnK9J1GlC2FyC7cu0NFPdayAXeH0kOrcJoKmftNEDi/IWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7zDz4jWMt/KRkkJABaAaT37ycbEY1smzsIE4xQM9ls=;
 b=C8sCtPuggzwJndHtGSDKvaNMffnmXLLbMVADVLjGJfTt4FRVlrKGhM5Lwl+gv8HJoYHOJVGS4cF1sIGX3eAJhsL/goWe5U+XcMaEsB0EZD+PkYzUAzMK8I9j+R+xB3fzHDgRvDt/w7irjVpJp/xMzOCdFwSTHrG/CHInsaWenJOy/OUAfwR7MLmT7pHF0zZ2bLw8gXqnaUMefHwriNXOKc233GiLuqJ4tVbu7e99r5+krP8qZAMvggJo9UOO4ZHNrPF38ggID37JrLzuALGurAQwG851VjK6i+9T4DMVKQCtVNJHoNnU5gdLFlENInJFcns3fVrRmST0fWtfSgUxhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7zDz4jWMt/KRkkJABaAaT37ycbEY1smzsIE4xQM9ls=;
 b=s9+HPwnguS5RQ2TYpLHwaznK2cIUJ0oaiz45+xT1BnPQValrHNwnVXakrGY+bl3/zDgsQZqsAFW0Euj6oWRrse9+lD3G1jXLFqtw8a2/I/vGVjMliFer+ZZM78SYGPe4eiHT1lYdFDtoJGgAE2nV7sizd8hdO1OufYyb8USpVQg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN8PR12MB3153.namprd12.prod.outlook.com (2603:10b6:408:69::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 5 May
 2022 15:07:04 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::fdba:2c6c:b9ab:38f]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::fdba:2c6c:b9ab:38f%4]) with mapi id 15.20.5206.025; Thu, 5 May 2022
 15:07:04 +0000
Message-ID: <40baeccc-86c0-5fc2-c970-c0bf8b6b6943@amd.com>
Date: Thu, 5 May 2022 17:06:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: Fix multiple GPU resets in XGMI hive.
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220504161841.24669-1-andrey.grodzovsky@amd.com>
 <7e9f45be-41a0-0764-8f4d-2787319477fb@amd.com>
 <80f0a3d8-5b42-f1b3-5396-464c665361c7@amd.com>
 <aec08997-9565-a596-f143-eccf92653a84@amd.com>
 <8ea0a998-b056-8cbf-d666-5305fd124a5d@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <8ea0a998-b056-8cbf-d666-5305fd124a5d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR04CA0132.eurprd04.prod.outlook.com
 (2603:10a6:20b:531::27) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc7bd733-c40d-4c01-e65b-08da2ea8e9c2
X-MS-TrafficTypeDiagnostic: BN8PR12MB3153:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3153FAE1A8D24092F269290283C29@BN8PR12MB3153.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t7Vm5aBtM/Zq0GN7hAtkkkEUBy2vedkwiJT7wdY/mvO33OarER9cIC5r3JEenHKdwvyrPfPmJM9KBaAozMd3Q8gaXtX+S9syG6dwyCHPBa2Wr0pzpWkGZAjIqLY8RkPevscc7Uj9plw1W7Vqxcgwc4SXzk9APn4yg1+WvGacVwO1EZlWzXOmKFos9ImYAEiItTaFKgR7C/foD1P6V2RIKfTTCnAtqaZ+Cl8OZwsQ8POaF6VBbNzFbp+vSzZ85e5PlfrEL2whufgWrG16bmO491urM5GQ3HskYlMrQjkqp5YOPZNBwNCM+VypixXXzaBbOjfNbretelhmKmE1r65UjRcjMSg4iCYtP135vaTiA1Mz2qZqK/6PQy4s3bj+JKB/WD/H5XfEskFI8Umchdm1u+Kt2lH4or1C/GAzvfkQ+gGpfSEGGicJ0injKvpi0h8/KgtjfinXOnV+jdekLwYi41B1dWEw88huaSDeYfx3Ww2C1zCeJVLJ5+sMP46SxbCh23wNazXq2ISEPdoIW+ZhMpbJ4+Ajo/iyc2vdbHPTvzaExbcCC1hTp6C1B8fNgR6NIXrxIQBsS2Lv4QkRgqKDSJfjzV9WhODtyRC9aDMcxUudVSTS3rbnyXg500iWveDzZ36ihG+Gp800uhz7zcTgkAbO4LoT+dEU78WOdWtwtFITbdgAAghZBKY8gT43EWicg4AP9zwYo67sS2pGn2NmV0RnFzsPqkNPqLkcF862j6Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(6506007)(30864003)(6486002)(8936002)(5660300002)(186003)(31686004)(36756003)(6512007)(2616005)(316002)(66574015)(83380400001)(38100700002)(86362001)(31696002)(8676002)(6666004)(66946007)(2906002)(66556008)(66476007)(4326008)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGErRWZ6anFCSmVNeW9sajRCTkllVjNXZndYYlB4bUZEeGJFWjNFUXkvbVNJ?=
 =?utf-8?B?cjl3aEtPLy9tSXJIM3FiaDlCamt3Tjcyc1YvT0xUN29BT0RCNWRqOGgrOHRP?=
 =?utf-8?B?aXVJYjZjQlNsVEtmV01RTzdxRkdCcWRBMUI2WFo0OWpUaVNmV1NJUkJkTk5s?=
 =?utf-8?B?ajJPVVM5WjlhbTFZTGZCaDlVOTNGUUpWWnN2b1RZODgxZFBLN3BBSHY4dHho?=
 =?utf-8?B?dWFKak15cU50ajhlbXprWHRDL01jdGJUSDFZdnpVVXBBcGhVa2JSK1IrOHlM?=
 =?utf-8?B?TTFlUDJzUWJNaE1OdUZxOVkxYy9GQXhEYXBHY05kT2x3QXpZOXEwSDhCYnZH?=
 =?utf-8?B?OWhiczIvNC9CMXcyTDA5RFFsSSs4UzcwaWY3cnlVOG1OcWN1QjZFNmlHTkpI?=
 =?utf-8?B?TzREcDBSNTk1VmZkSzVGMkhoUHJsNUowNVo2YUNLNVUwbmQxbHJ6TytQQUsy?=
 =?utf-8?B?by9MeEg0anpwa3dWWGlEdEhXTENMZWFwdmVBUnpncThmUHRNTEV3MnFtZ1BN?=
 =?utf-8?B?UXVFMVV4OHhzZ05GRDNXMmhHYWFucUFKQTNVTENWOHUxVUVrYjJ1R0UzYzNa?=
 =?utf-8?B?eStlcFk3ZjRwbVN2STg5T2RqTzF6SFV4NGNqemF0Q1p6eGF1UXFtdldWd0Ew?=
 =?utf-8?B?d1A0NTAvS0JGdnRwSmExVUNNckJETnVpWitiVFRMVG52Q01QY3ZLM0hXRVhB?=
 =?utf-8?B?eERTSGhOUVd1L1k0MmtqWUZYU0NTZWdldDEyNWd3bTY5dkszc1hDQTBRY21p?=
 =?utf-8?B?aG9KWFQrMkR1Y1cwNnNpcTJUQ3JRdUNBQXIybit2aFo2OVJ6Wm9EajltZ1g5?=
 =?utf-8?B?QzNNSkxpUUpZcWMvMDZJekpkbHVFUURuWkl2UXNYTCtteGdDN0N2U2RmUXZr?=
 =?utf-8?B?ajZiQ2JsWkVuRE9EcG93UnBaTWpxYzMzSmJ3WDBJY3E5RHI3SmFtNXpIdXNt?=
 =?utf-8?B?NG1TUmZaVkRCb0JUYmwrWkpJV05wd2hjQWpYNzcwWEw4SzBKaHl6RGZrNnd4?=
 =?utf-8?B?Y08zOFl2Yi9OOHBrVk1DNkVDU2ZlVDJzQTFjRmVyaDNPSHdublZpVTN0bzd6?=
 =?utf-8?B?RjVjQlJlMHEwdGc2UWRBU1pTSlNxM2p6RndVVlUrOXoyYjg3SFA5T2Y1azZW?=
 =?utf-8?B?VUZJdnN2aVVEY3Z6WlpaY1JycklyRVJXNVFaUzZqUDFJWjZrNXAzOEE1NGhi?=
 =?utf-8?B?LzVhanlmWEpmQkI0aFFJUDdGNTU3ZkVUOExCUHNmdDh0Vlpoc1dSSUcrQlo4?=
 =?utf-8?B?TEVYMGQxYU5CT3NRVzlVVHRSaW1DdTlEeEIzek4xSGpTVWkyT1lSaGJEb2pz?=
 =?utf-8?B?dTJrMnFZN3IyRTQ3R1hqQzFnN1RjckFLd2xhKzVySHdBMTZLSlhBY1hpN1Uw?=
 =?utf-8?B?VEtmNTAwenMwcW1NWUdNNHVkUzQvRDJsK1RYbEhiczBWaStubEJIa2pacVZK?=
 =?utf-8?B?TktrbkZyZUNuekFDT1FKZVBCNlFqR1lrakl0cTYzVTJCakNDU3NKbVE1U2xl?=
 =?utf-8?B?YU1hSXUxYk5WSFhEMW05Ym5IMmJUZFlzYi9JaFgyTFphTmNzWDZrMDcyN21t?=
 =?utf-8?B?NUtNZDIwRm8rc1ZXdmloajJKbkJ0UHF2dTJXUHpLMi9VU3ZML1F1dUN2Yno5?=
 =?utf-8?B?c0FsNkIxZTQ0ZGF1N0VpRUtFSFZUN2FFQTM1cXlVY1NDWjNEc0w2YVFHNGkr?=
 =?utf-8?B?MG00OTBzVDZwcG5nZ1dKQVVrdzVDMHBxVHVYZkZxZ3BjZzZFcVhwYm9CWFpE?=
 =?utf-8?B?bURyYktiY242bER3ZlVXRk0vU2JEUE9PWEpKT0ZmT2lmd0JUcWtibWZvYkxy?=
 =?utf-8?B?Q3ZEYzYzaUpMZnk5K0dRbUFXQUNiTUR4alpqenprZmdSMVZ3NGV5SlRtRS9D?=
 =?utf-8?B?ZERwbUhKc1JMVGJJeUYvbFptL2hybU1YVXdGd2VteUdXSE5tRzk1a3N6b3d5?=
 =?utf-8?B?czRKT3RpT3J2LzN4ZGM1Y0x1YzNkd1hXeHBucU1FY1ZKeGkvM2RHUmlJenpw?=
 =?utf-8?B?SXQybG1vb3YrUWQxVm44OWhYTVkwRUVSMjh4d3BJY09lbk5vRzZpcDNSWFc4?=
 =?utf-8?B?eGFMVUdDaThxWW91S0FaOG9SVjBkRllvV29EL1JMSjNxQ3hkK1JOanVjTkJY?=
 =?utf-8?B?ZzhWQTBqbTBQa3VsOXk5TXZ5cjA4QUlnSko2VWFYb0RLTm5ZVXZKTlVWRndQ?=
 =?utf-8?B?YVB6SjFaQUF6VytkK2gvUkRFODdiNkVidVV2dnpzazZ0VWl4WHNzcHpYQmtF?=
 =?utf-8?B?SUx2MkJiakMyYnZYdi94NnFQTVFBcklVOWd5bFVKTUZ6RXJGKzZmTXdiUzlo?=
 =?utf-8?B?aUFHcDJpb2VMQnAyZHlpSU9ISjlOUUZiY29MN0dEUHl0RjhjcDl3N21pb2VZ?=
 =?utf-8?Q?reD5KqjPyk1ng98Sdv26wPyykqujA5Wk1SfE4JvWeqevm?=
X-MS-Exchange-AntiSpam-MessageData-1: us693D/Y8pYMTA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7bd733-c40d-4c01-e65b-08da2ea8e9c2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 15:07:04.0875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIsZ5epY/8skp6Tv2Stq20ns9UHzPtaa70Udz7slRb/X87/otmFBXqxMr9DFwViN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3153
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
Cc: Bai Zoy <Zoy.Bai@amd.com>, lijo.lazar@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 05.05.22 um 15:54 schrieb Andrey Grodzovsky:
>
> On 2022-05-05 09:23, Christian König wrote:
>> Am 05.05.22 um 15:15 schrieb Andrey Grodzovsky:
>>> On 2022-05-05 06:09, Christian König wrote:
>>>
>>>> Am 04.05.22 um 18:18 schrieb Andrey Grodzovsky:
>>>>> Problem:
>>>>> During hive reset caused by command timing out on a ring
>>>>> extra resets are generated by triggered by KFD which is
>>>>> unable to accesses registers on the resetting ASIC.
>>>>>
>>>>> Fix: Rework GPU reset to use a list of pending reset jobs
>>>>> such that the first reset jobs that actaully resets the entire
>>>>> reset domain will cancel all those pending redundant resets.
>>>>>
>>>>> This is in line with what we already do for redundant TDRs
>>>>> in scheduler code.
>>>>
>>>> Mhm, why exactly do you need the extra linked list then?
>>>>
>>>> Let's talk about that on our call today.
>>>
>>>
>>> Going to miss it as you know, and also this is the place to discuss 
>>> technical questions anyway so -
>>
>> Good point.
>>
>>> It's needed because those other resets are not time out handlers 
>>> that are governed by the scheduler
>>> but rather external resets that are triggered by such clients as 
>>> KFD, RAS and sysfs. Scheduler has no
>>> knowledge of them (and should not have) but they are serialized into 
>>> same wq as the TO handlers
>>> from the scheduler. It just happens that TO triggered reset causes 
>>> in turn another reset (from KFD in
>>> this case) and we want to prevent this second reset from taking 
>>> place just as we want to avoid multiple
>>> TO resets to take place in scheduler code.
>>
>> Yeah, but why do you need multiple workers?
>>
>> You have a single worker for the GPU reset not triggered by the 
>> scheduler in you adev and cancel that at the end of the reset procedure.
>>
>> If anybody things it needs to trigger another reset while in reset 
>> (which is actually a small design bug separately) the reset will just 
>> be canceled in the same way we cancel the scheduler resets.
>>
>> Christian.
>
>
> Had this in mind at first but then I realized that each client (RAS, 
> KFD and sysfs) will want to fill his own data for the work (see 
> amdgpu_device_gpu_recover) - for XGMI hive each will want to set his 
> own adev (which is fine if you set a work per adev as you suggest) but 
> also each client might want (they all put NULL there but in theory in 
> the future) also set his own bad job value and here you might have a 
> collision.

Yeah, but that is intentional. See when we have a job that needs to be 
consumed by the reset handler and not overwritten or something.

Additional to that keep in mind that you can't allocate any memory 
before or during the GPU reset nor wait for the reset to complete (so 
you can't allocate anything on the stack either).

I don't think that concept you try here will work.

Regards,
Christian.

> Also in general seems to me it's cleaner approach where this logic 
> (the work items) are held and handled in reset_domain and are not 
> split in each adev or any other entity. We might want in the future to 
> even move the scheduler handling into reset domain since reset domain 
> is supposed to be a generic things and not only or AMD.
>
> Andrey
>
>
>>
>>>
>>> Andrey
>>>
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>> Tested-by: Bai Zoy <Zoy.Bai@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 11 +---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 +++--
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  |  3 +
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 73 
>>>>> +++++++++++++++++++++-
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  3 +-
>>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  7 ++-
>>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  7 ++-
>>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  7 ++-
>>>>>   8 files changed, 104 insertions(+), 24 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> index 4264abc5604d..99efd8317547 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> @@ -109,6 +109,7 @@
>>>>>   #include "amdgpu_fdinfo.h"
>>>>>   #include "amdgpu_mca.h"
>>>>>   #include "amdgpu_ras.h"
>>>>> +#include "amdgpu_reset.h"
>>>>>     #define MAX_GPU_INSTANCE        16
>>>>>   @@ -509,16 +510,6 @@ struct amdgpu_allowed_register_entry {
>>>>>       bool grbm_indexed;
>>>>>   };
>>>>>   -enum amd_reset_method {
>>>>> -    AMD_RESET_METHOD_NONE = -1,
>>>>> -    AMD_RESET_METHOD_LEGACY = 0,
>>>>> -    AMD_RESET_METHOD_MODE0,
>>>>> -    AMD_RESET_METHOD_MODE1,
>>>>> -    AMD_RESET_METHOD_MODE2,
>>>>> -    AMD_RESET_METHOD_BACO,
>>>>> -    AMD_RESET_METHOD_PCI,
>>>>> -};
>>>>> -
>>>>>   struct amdgpu_video_codec_info {
>>>>>       u32 codec_type;
>>>>>       u32 max_width;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index e582f1044c0f..7fa82269c30f 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -5201,6 +5201,12 @@ int amdgpu_device_gpu_recover_imp(struct 
>>>>> amdgpu_device *adev,
>>>>>       }
>>>>>         tmp_vram_lost_counter = 
>>>>> atomic_read(&((adev)->vram_lost_counter));
>>>>> +
>>>>> +    /* Drop all pending resets since we will reset now anyway */
>>>>> +    tmp_adev = list_first_entry(device_list_handle, struct 
>>>>> amdgpu_device,
>>>>> +                        reset_list);
>>>>> +    amdgpu_reset_pending_list(tmp_adev->reset_domain);
>>>>> +
>>>>>       /* Actual ASIC resets if needed.*/
>>>>>       /* Host driver will handle XGMI hive reset for SRIOV */
>>>>>       if (amdgpu_sriov_vf(adev)) {
>>>>> @@ -5296,7 +5302,7 @@ int amdgpu_device_gpu_recover_imp(struct 
>>>>> amdgpu_device *adev,
>>>>>   }
>>>>>     struct amdgpu_recover_work_struct {
>>>>> -    struct work_struct base;
>>>>> +    struct amdgpu_reset_work_struct base;
>>>>>       struct amdgpu_device *adev;
>>>>>       struct amdgpu_job *job;
>>>>>       int ret;
>>>>> @@ -5304,7 +5310,7 @@ struct amdgpu_recover_work_struct {
>>>>>     static void amdgpu_device_queue_gpu_recover_work(struct 
>>>>> work_struct *work)
>>>>>   {
>>>>> -    struct amdgpu_recover_work_struct *recover_work = 
>>>>> container_of(work, struct amdgpu_recover_work_struct, base);
>>>>> +    struct amdgpu_recover_work_struct *recover_work = 
>>>>> container_of(work, struct amdgpu_recover_work_struct, 
>>>>> base.base.work);
>>>>>         recover_work->ret = 
>>>>> amdgpu_device_gpu_recover_imp(recover_work->adev, recover_work->job);
>>>>>   }
>>>>> @@ -5316,12 +5322,15 @@ int amdgpu_device_gpu_recover(struct 
>>>>> amdgpu_device *adev,
>>>>>   {
>>>>>       struct amdgpu_recover_work_struct work = {.adev = adev, .job 
>>>>> = job};
>>>>>   -    INIT_WORK(&work.base, amdgpu_device_queue_gpu_recover_work);
>>>>> +    INIT_DELAYED_WORK(&work.base.base, 
>>>>> amdgpu_device_queue_gpu_recover_work);
>>>>> +    INIT_LIST_HEAD(&work.base.node);
>>>>>         if (!amdgpu_reset_domain_schedule(adev->reset_domain, 
>>>>> &work.base))
>>>>>           return -EAGAIN;
>>>>>   -    flush_work(&work.base);
>>>>> +    flush_delayed_work(&work.base.base);
>>>>> +
>>>>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>> &work.base);
>>>>>         return work.ret;
>>>>>   }
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>> index c80af0889773..ffddd419c351 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>> @@ -134,6 +134,9 @@ struct amdgpu_reset_domain 
>>>>> *amdgpu_reset_create_reset_domain(enum amdgpu_reset_d
>>>>>       atomic_set(&reset_domain->in_gpu_reset, 0);
>>>>>       init_rwsem(&reset_domain->sem);
>>>>>   + INIT_LIST_HEAD(&reset_domain->pending_works);
>>>>> +    mutex_init(&reset_domain->reset_lock);
>>>>> +
>>>>>       return reset_domain;
>>>>>   }
>>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>> index 1949dbe28a86..863ec5720fc1 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>> @@ -24,7 +24,18 @@
>>>>>   #ifndef __AMDGPU_RESET_H__
>>>>>   #define __AMDGPU_RESET_H__
>>>>>   -#include "amdgpu.h"
>>>>> +
>>>>> +#include <linux/atomic.h>
>>>>> +#include <linux/mutex.h>
>>>>> +#include <linux/list.h>
>>>>> +#include <linux/kref.h>
>>>>> +#include <linux/rwsem.h>
>>>>> +#include <linux/workqueue.h>
>>>>> +
>>>>> +struct amdgpu_device;
>>>>> +struct amdgpu_job;
>>>>> +struct amdgpu_hive_info;
>>>>> +
>>>>>     enum AMDGPU_RESET_FLAGS {
>>>>>   @@ -32,6 +43,17 @@ enum AMDGPU_RESET_FLAGS {
>>>>>       AMDGPU_SKIP_HW_RESET = 1,
>>>>>   };
>>>>>   +
>>>>> +enum amd_reset_method {
>>>>> +    AMD_RESET_METHOD_NONE = -1,
>>>>> +    AMD_RESET_METHOD_LEGACY = 0,
>>>>> +    AMD_RESET_METHOD_MODE0,
>>>>> +    AMD_RESET_METHOD_MODE1,
>>>>> +    AMD_RESET_METHOD_MODE2,
>>>>> +    AMD_RESET_METHOD_BACO,
>>>>> +    AMD_RESET_METHOD_PCI,
>>>>> +};
>>>>> +
>>>>>   struct amdgpu_reset_context {
>>>>>       enum amd_reset_method method;
>>>>>       struct amdgpu_device *reset_req_dev;
>>>>> @@ -40,6 +62,8 @@ struct amdgpu_reset_context {
>>>>>       unsigned long flags;
>>>>>   };
>>>>>   +struct amdgpu_reset_control;
>>>>> +
>>>>>   struct amdgpu_reset_handler {
>>>>>       enum amd_reset_method reset_method;
>>>>>       struct list_head handler_list;
>>>>> @@ -76,12 +100,21 @@ enum amdgpu_reset_domain_type {
>>>>>       XGMI_HIVE
>>>>>   };
>>>>>   +
>>>>> +struct amdgpu_reset_work_struct {
>>>>> +    struct delayed_work base;
>>>>> +    struct list_head node;
>>>>> +};
>>>>> +
>>>>>   struct amdgpu_reset_domain {
>>>>>       struct kref refcount;
>>>>>       struct workqueue_struct *wq;
>>>>>       enum amdgpu_reset_domain_type type;
>>>>>       struct rw_semaphore sem;
>>>>>       atomic_t in_gpu_reset;
>>>>> +
>>>>> +    struct list_head pending_works;
>>>>> +    struct mutex reset_lock;
>>>>>   };
>>>>>     @@ -113,9 +146,43 @@ static inline void 
>>>>> amdgpu_reset_put_reset_domain(struct amdgpu_reset_domain *dom
>>>>>   }
>>>>>     static inline bool amdgpu_reset_domain_schedule(struct 
>>>>> amdgpu_reset_domain *domain,
>>>>> -                        struct work_struct *work)
>>>>> +                        struct amdgpu_reset_work_struct *work)
>>>>>   {
>>>>> -    return queue_work(domain->wq, work);
>>>>> +    mutex_lock(&domain->reset_lock);
>>>>> +
>>>>> +    if (!queue_delayed_work(domain->wq, &work->base, 0)) {
>>>>> +        mutex_unlock(&domain->reset_lock);
>>>>> +        return false;
>>>>> +    }
>>>>> +
>>>>> +    list_add_tail(&work->node, &domain->pending_works);
>>>>> +    mutex_unlock(&domain->reset_lock);
>>>>> +
>>>>> +    return true;
>>>>> +}
>>>>> +
>>>>> +static inline void amdgpu_reset_domain_del_pendning_work(struct 
>>>>> amdgpu_reset_domain *domain,
>>>>> +                  struct amdgpu_reset_work_struct *work)
>>>>> +{
>>>>> +    mutex_lock(&domain->reset_lock);
>>>>> +    list_del_init(&work->node);
>>>>> +    mutex_unlock(&domain->reset_lock);
>>>>> +}
>>>>> +
>>>>> +static inline void amdgpu_reset_pending_list(struct 
>>>>> amdgpu_reset_domain *domain)
>>>>> +{
>>>>> +    struct amdgpu_reset_work_struct *entry, *tmp;
>>>>> +
>>>>> +    mutex_lock(&domain->reset_lock);
>>>>> +    list_for_each_entry_safe(entry, tmp, &domain->pending_works, 
>>>>> node) {
>>>>> +
>>>>> +        list_del_init(&entry->node);
>>>>> +
>>>>> +        /* Stop any other related pending resets */
>>>>> +        cancel_delayed_work(&entry->base);
>>>>> +    }
>>>>> +
>>>>> +    mutex_unlock(&domain->reset_lock);
>>>>>   }
>>>>>     void amdgpu_device_lock_reset_domain(struct 
>>>>> amdgpu_reset_domain *reset_domain);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>> index 239f232f9c02..574e870d3064 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>> @@ -25,6 +25,7 @@
>>>>>   #define AMDGPU_VIRT_H
>>>>>     #include "amdgv_sriovmsg.h"
>>>>> +#include "amdgpu_reset.h"
>>>>>     #define AMDGPU_SRIOV_CAPS_SRIOV_VBIOS  (1 << 0) /* vBIOS is 
>>>>> sr-iov ready */
>>>>>   #define AMDGPU_SRIOV_CAPS_ENABLE_IOV   (1 << 1) /* sr-iov is 
>>>>> enabled on this GPU */
>>>>> @@ -230,7 +231,7 @@ struct amdgpu_virt {
>>>>>       uint32_t            reg_val_offs;
>>>>>       struct amdgpu_irq_src        ack_irq;
>>>>>       struct amdgpu_irq_src        rcv_irq;
>>>>> -    struct work_struct        flr_work;
>>>>> +    struct amdgpu_reset_work_struct flr_work;
>>>>>       struct amdgpu_mm_table        mm_table;
>>>>>       const struct amdgpu_virt_ops    *ops;
>>>>>       struct amdgpu_vf_error_buffer    vf_errors;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>> index b81acf59870c..f3d1c2be9292 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>> @@ -251,7 +251,7 @@ static int xgpu_ai_set_mailbox_ack_irq(struct 
>>>>> amdgpu_device *adev,
>>>>>     static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
>>>>>   {
>>>>> -    struct amdgpu_virt *virt = container_of(work, struct 
>>>>> amdgpu_virt, flr_work);
>>>>> +    struct amdgpu_virt *virt = container_of(work, struct 
>>>>> amdgpu_virt, flr_work.base.work);
>>>>>       struct amdgpu_device *adev = container_of(virt, struct 
>>>>> amdgpu_device, virt);
>>>>>       int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
>>>>>   @@ -380,7 +380,8 @@ int xgpu_ai_mailbox_get_irq(struct 
>>>>> amdgpu_device *adev)
>>>>>           return r;
>>>>>       }
>>>>>   -    INIT_WORK(&adev->virt.flr_work, xgpu_ai_mailbox_flr_work);
>>>>> +    INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>> xgpu_ai_mailbox_flr_work);
>>>>> +    INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>         return 0;
>>>>>   }
>>>>> @@ -389,6 +390,8 @@ void xgpu_ai_mailbox_put_irq(struct 
>>>>> amdgpu_device *adev)
>>>>>   {
>>>>>       amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>       amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>> +
>>>>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>> &adev->virt.flr_work);
>>>>>   }
>>>>>     static int xgpu_ai_request_init_data(struct amdgpu_device *adev)
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>> index 22c10b97ea81..927b3d5bb1d0 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>> @@ -275,7 +275,7 @@ static int xgpu_nv_set_mailbox_ack_irq(struct 
>>>>> amdgpu_device *adev,
>>>>>     static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
>>>>>   {
>>>>> -    struct amdgpu_virt *virt = container_of(work, struct 
>>>>> amdgpu_virt, flr_work);
>>>>> +    struct amdgpu_virt *virt = container_of(work, struct 
>>>>> amdgpu_virt, flr_work.base.work);
>>>>>       struct amdgpu_device *adev = container_of(virt, struct 
>>>>> amdgpu_device, virt);
>>>>>       int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
>>>>>   @@ -407,7 +407,8 @@ int xgpu_nv_mailbox_get_irq(struct 
>>>>> amdgpu_device *adev)
>>>>>           return r;
>>>>>       }
>>>>>   -    INIT_WORK(&adev->virt.flr_work, xgpu_nv_mailbox_flr_work);
>>>>> +    INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>> xgpu_nv_mailbox_flr_work);
>>>>> +    INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>         return 0;
>>>>>   }
>>>>> @@ -416,6 +417,8 @@ void xgpu_nv_mailbox_put_irq(struct 
>>>>> amdgpu_device *adev)
>>>>>   {
>>>>>       amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>       amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>> +
>>>>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>> &adev->virt.flr_work);
>>>>>   }
>>>>>     const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>> index 7b63d30b9b79..1d4ef5c70730 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>> @@ -512,7 +512,7 @@ static int xgpu_vi_set_mailbox_ack_irq(struct 
>>>>> amdgpu_device *adev,
>>>>>     static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
>>>>>   {
>>>>> -    struct amdgpu_virt *virt = container_of(work, struct 
>>>>> amdgpu_virt, flr_work);
>>>>> +    struct amdgpu_virt *virt = container_of(work, struct 
>>>>> amdgpu_virt, flr_work.base.work);
>>>>>       struct amdgpu_device *adev = container_of(virt, struct 
>>>>> amdgpu_device, virt);
>>>>>         /* wait until RCV_MSG become 3 */
>>>>> @@ -610,7 +610,8 @@ int xgpu_vi_mailbox_get_irq(struct 
>>>>> amdgpu_device *adev)
>>>>>           return r;
>>>>>       }
>>>>>   -    INIT_WORK(&adev->virt.flr_work, xgpu_vi_mailbox_flr_work);
>>>>> +    INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>> xgpu_vi_mailbox_flr_work);
>>>>> +    INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>         return 0;
>>>>>   }
>>>>> @@ -619,6 +620,8 @@ void xgpu_vi_mailbox_put_irq(struct 
>>>>> amdgpu_device *adev)
>>>>>   {
>>>>>       amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>       amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>> +
>>>>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>> &adev->virt.flr_work);
>>>>>   }
>>>>>     const struct amdgpu_virt_ops xgpu_vi_virt_ops = {
>>>>
>>

