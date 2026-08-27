Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FD1C5DF9D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 03:52:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D9C610E29A;
	Thu, 27 Aug 2026 03:52:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j3EfrjRP";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013051.outbound.protection.outlook.com
 [40.93.196.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48F8410E29A
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 03:52:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMuuNhVIOQmwAXXx2NVNqs1VANmpGY8c7eEmng6Sa6L9LcX3n/euboUGrb43Evf+6s7KUsoA+73Nd7Lj6J7fiIPP/L5qPLmU801zhKoA6iMczUhKU8GsngqJZCTpSfMtIOuFxQEb7NI2InSdOF85dbC2a05IvCM9scdaY6MBuJVlD3suRmwPsfwffdl+UPdhMok2//gEF6jv0rTSaE1LUCW922ZCMjWsvRQAk3/hckLe0uGaaz+pcxJY8RK9nGW8A13Sn1hi3gFKc5hFA12WCqsgHXPvuVRMLrflGYD2GBidTpVdpkaro1P1Uq4PTaZ9olQk4B65Pga88iWHC6VLdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PKO507E78UFvqvgbo5s0/nOhLyyeDpv4NuqPc7XrxA=;
 b=I9TcJqTFlFofwA2FoZppg1bLY8N9obG7ZEXWmHRB2/kdKRKLms0Y3yW+2FJlAnf+VB+wg8Tg0JGwPsHLl30qQTvm5RrAZXvlol7KIcBGQx+u2wdeSt1JWi3ab+Uq9JBsKZGrwA4qtxwYmff3LSXY5a2AMVAmX5gI46UemkI4ffW5G6etdYBmgqU+28dQnRGUZRnrZjUOJdWjRcJ7ESrEDp3dzrgTauk3WrYVUr1B4BwbJF9OlZrgee0pJvN1NyYuw+BUdVz1VRszl6db6YuaR/ZYVcW0jR+ZAIXwjqamuPerzl4JjYo9dVWBWHE4Q2ba1C996faXF83OQy3UCW4Pug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PKO507E78UFvqvgbo5s0/nOhLyyeDpv4NuqPc7XrxA=;
 b=j3EfrjRP0ZAisfCVz3de0liV8il+FODlFm+WXZBf3dmyk2uU6e5tN1qtP4YkVcxq/9tCocN5tE/jvDQEe5BVGoEdgeJYdhRe5mqUE8h6MQknRMb894B4rda1myFzXXekviF6fKo7xljfI+yoMUN2FYG3XkFBPrMayU0Gi5I6X84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by CY1PR12MB9558.namprd12.prod.outlook.com (2603:10b6:930:fe::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 03:52:46 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.21.0360.006; Thu, 27 Aug 2026
 03:52:45 +0000
Message-ID: <bb7ed28f-acaf-4594-83a5-369fba3e3421@amd.com>
Date: Thu, 27 Aug 2026 09:22:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu/userq: use fence_val instead or rptr
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260826175841.559992-1-sunil.khatri@amd.com>
 <BN9PR12MB5146CB372B4E0F11B496BCCCF7AE2@BN9PR12MB5146.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <BN9PR12MB5146CB372B4E0F11B496BCCCF7AE2@BN9PR12MB5146.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0278.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f2::9) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|CY1PR12MB9558:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d06e58-a5fe-409c-da2b-08df03eea757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: bKr5k2ZyVrHLaJjo3Dvsl2WArHZ48i+BbjYZHoEP1ZASuIt1TmuOmRNcpm8WcbjC8MQ066oEV40woOKMkOpN9PrNNHFiuokQiuZW6bMiDu8bCZYlS1/40iNmdgFhvakLiANBSj2Xx8aJaDRT+ZPtf8KJgYltW4SxNYYFPhITdOcWVY3dSa9UFBwFVzj9texvgUrQblufWW65Xp4YxfELiXX9Brye66EWNeop4dQwUYar/yvm/5f2F0cubbxdprUD0ZpzhAO4xa4znz3d3k1Ds3hriv0ogRx3XqH7hfc+zNLOy7eOFFphEJ9Dz8ItuAkzcG7Pta5jV7XmVwS6bdivATyQ3Mk5nVivgWUyzBNVnTNjkeUixoP88ZtAp2Xo399kXesnqjiWAgFTmj/R4/FvJ1sflxbVqTCSBUNzUBq8tcY8pAOgRQPHaqLPZRcgDkXYqW99kQY7oAWw39qccJZFoCyPHTLhqRQe7lL4SF1/rHOL2EUFJju+tPdMaAhlo2O2Wo/J9UyB4KDFmiSynl0u3shShqJpE5S7ajXKUKSfhpyXn4dVeWOJcDmzwYdImBp4WP419hMluKo4rz+XGz7UXdUWK7p/t4e77XhHMQde+rbV2q8Fl1euenpB5uHzsgknOLp4V50bDZTYhqLrUWRG76qmNpogSFD9TWChhSE5rok=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm8vQTl3MFVSbnJ5cTdmc3ZBcUh5Zk94T0hHRWJ0RVZWd050NHFxL3loRmxV?=
 =?utf-8?B?YmVxL1ZqMEhXV01kNkJWU2pGQXNmQ1Fpa2c1MjBtTE1xYVIvK1kyVURpNUtX?=
 =?utf-8?B?WFR3Sit5WnJnWVFiS1ZpcGo1d1RQMDR0NGJLUENGdTBnRW1KMXg4cGhOa2hC?=
 =?utf-8?B?ZUxna09SNXAwQkt1R2NFUk9TYllTbUJRNHV3OGkyZUFNSmpWTlhscEh4TE52?=
 =?utf-8?B?dURNZkJGampCbWZoa3JyclFwRUhKdFJZZG84MWJPZzhwR0w0OU11aU9Nallu?=
 =?utf-8?B?cVVMOW83TkVNUm9CSVViYlVqRHlkMXplU1FDY09MdjZlTG54RkIrdjBVcHUr?=
 =?utf-8?B?NWJTZW9xczl1eG5MMkxSVUplUGFSaFBkZ2RzSWk0RjBjaXhMSzlNNS9iY210?=
 =?utf-8?B?UU9vdzRGNUxBS0krNU9NTzdUaWE0VDVPaEhnZUE0WitadWNXZWpTMm1XUXU2?=
 =?utf-8?B?N0Y0dzVCL0dLRWJ6bDRGaC9KcTNDYnhISlI5S09ZZ244UVI3SVFSME1VRm5H?=
 =?utf-8?B?SEpsVktucEpISVJBTTNhd0NSM05xTE9xbDdoUTV4aHl2UHRVdU4rOHZ2OGpH?=
 =?utf-8?B?U2F5ZUYyaEdPcFZMZHAzOHVxd2ExaWc5akNrTVI2NTgvUFhseE92QXBNWWVw?=
 =?utf-8?B?RHNWUlJxNTYzcWwyNWU2c3BwcU03NDRJeVdXVGk0S1Q1dysveWFCWC9sYXFw?=
 =?utf-8?B?MnlHMEJIT1B3RnVZVHAzTEtjZE44TW9LQXJhUUVqblpHM3hleHVpWTM2ZFhi?=
 =?utf-8?B?cTBTZkhOQ0FIMHFoVVFJUXhtZDA0VkFkalEzaUpJSVZnVlhoWnhoMkZpWDRH?=
 =?utf-8?B?MFIwTGRHbWhuQkwxSERJZUtzeFJOak1PK0lxVXJWTUJ3N0ZYVFlRM0FMaU5U?=
 =?utf-8?B?TEc3WDZoZUZvS0llVTlJRTdiT2dMcXZNOUZ0eitpRHd3OXhUc1lyKzAvT1NJ?=
 =?utf-8?B?cDY5dHRNMEpRZGhuenBYSTJVTEM2NkVZZzVOb1NMUkhaZWpmaVJlQ29xbElp?=
 =?utf-8?B?N2p4MUdFN2Y2cWJCdm9nM1JsR201Z2YzQndBSVJ3bHVxUU5SRCt6UDd6Ujhi?=
 =?utf-8?B?RkZPZ3Z4aUp5SzNRYjZlazZRaS93U2QyY3BrNnB0NC9OM1JrdHBUNTJsd1NF?=
 =?utf-8?B?alpWWG10aVJxRnlxcWxQTFVLOHNsbnV6c3lrK08rUFpqcGl0TFRzZ1ZZWFZ4?=
 =?utf-8?B?OVVlZzBIaWZwcVh0OGs0QzNsVEFPS29WWEN4YnZISHYveW1iUFl3dFFjQVh6?=
 =?utf-8?B?L0pKQzJlLzdubDFrckhUNjBLZnNOSDhNTy9YRXN2QTdhbCtBSmVIejlYVU9h?=
 =?utf-8?B?YldYMFVCRjh5bkU5VlAyeW9QTnBIK3VadjhPUkJpeDZ6b1QrQlVHUllQRTE1?=
 =?utf-8?B?NXFXbDhrTElwVkFCMDRaMEJLZ0loSTFySm13MGZISkNLWWp4M2RaTVdHakhw?=
 =?utf-8?B?SUViNjBsbHNLNE5VOG9od3k1L3hNS3VyK2lqUlRValZZSWFnUk9ldmtSS3U0?=
 =?utf-8?B?NjVVZjdJWjRwaTRwSjVZQXNseFVhMHJVazJIT0lQMVZGU3BlQzJreUFXTUhk?=
 =?utf-8?B?VHZta2djZ3Q4UW1oTVJCWTA0dE9VR2ErVGc2U3hYZWpHWVUzQ0hWYS9FT2dW?=
 =?utf-8?B?OEdYeEN6cm8wWlJrbk9vR3VQbkJFdW9neTltc0NjVGEwSDB0TUNNVGtYdUJG?=
 =?utf-8?B?ZkZGUGwyVDB4U0lkZlhubjlOY1NhbXZnTHQ2N3Q2anVGRGg5S3FYSnJhK01u?=
 =?utf-8?B?TXFmNGg0RkhBcEIzMDFEUlVwQVJRRHFUZVN4VjJBeGtiN1BCYVhCY1NELzdo?=
 =?utf-8?B?N3djQmpxZUN6ckk0VVdMWXhrZEFrcnBCRC9KdGNmcHlVYzRyYktPZkFhcXc0?=
 =?utf-8?B?TktaWlFvRy9SZHpnVGVCVGNxSEZyT3JKL2wrSTM4QXVZMHpSaU0vSHh5UEc0?=
 =?utf-8?B?bGpEQUk0ZTcrRlVXNVFTeVh0WjcvSXlmbUgrWjFZVDJabENrYzM5TEVHR0Jw?=
 =?utf-8?B?NWF5aVY4WHNGQ1BQSFBZaTZseERvWjNEblpBeXdQMk5BNThvdkxVeGpieDhO?=
 =?utf-8?B?ek5oR3R6Z2tYRCt2Um1uRUtlYU1qM3lxU2J1V3ZrUDFkdHNQaHZRbmJRdm4r?=
 =?utf-8?B?R0JQT2NBUmF2VE9lekVxdkZ4eHVsZ0xKNmtURzAraURLeTFkeFZMbmF2cGxD?=
 =?utf-8?B?dWo3blVmTGlzYUtwWlRIRVZPMUs1OEEwNDcva2h5VElmbHFrRGg1ZktpTTd6?=
 =?utf-8?B?eEtQNHRPQ01GOHZaRXdzRGNBZUZoaWlTb1hnbWlyQ21aSXhJRFBRVlh0TUZ5?=
 =?utf-8?B?RTZYQkk5M040MGFPMkFBa1RGNWtSNG44UU83QlI2ZmJMSU1uM1dkUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d06e58-a5fe-409c-da2b-08df03eea757
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 03:52:45.7827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEPO/WwmvWxB9eMPkOZpSLn8iBiAufWHIXIqvpEyqJZvO7joIqzvJrow9skDelTBu/3uf5hJFFZC6wGYSojFaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9558
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


On 26-08-2026 11:34 pm, Deucher, Alexander wrote:
> AMD General
>
>> -----Original Message-----
>> From: Sunil Khatri <sunil.khatri@amd.com>
>> Sent: Wednesday, August 26, 2026 1:59 PM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Khatri, Sunil <Sunil.Khatri@amd.com>
>> Subject: [PATCH v2 1/2] drm/amdgpu/userq: use fence_val instead or rptr
>>
>> rptr is a confusing variable name as it is a fence value written by the cp in the
>> fence address and no where related to the rptr.
> For a little history, the fence value is the actually wptr written by the application when it submits the protected fence packet.  The firmware writes the rptr that is aligned to that wptr as the fence value.  But in this case, I agree that it is confusing, especially for someone without the history.  Patches are:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Totally agree with that. I knew its the wptr value that is written in 
the fence address but i was confused so many times while debugging the 
sdma issue.
Thanks for the quick review on these.

Regards
Sunil Khatri

>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index 09e2079cfdbd..e862b65f5366 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -148,13 +148,13 @@ amdgpu_userq_fence_driver_process(struct
>> amdgpu_userq_fence_driver *fence_drv)
>>        LIST_HEAD(to_be_signaled);
>>        struct dma_fence *fence;
>>        unsigned long flags;
>> -     u64 rptr;
>> +     u64 fence_val;
>>
>>        spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
>> -     rptr = amdgpu_userq_fence_read(fence_drv);
>> +     fence_val = amdgpu_userq_fence_read(fence_drv);
>>
>>        list_for_each_entry(userq_fence, &fence_drv->fences, link) {
>> -             if (rptr < userq_fence->base.seqno)
>> +             if (fence_val < userq_fence->base.seqno)
>>                        break;
>>        }
>>
>> --
>> 2.34.1
