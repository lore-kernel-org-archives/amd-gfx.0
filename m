Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68A8F3382E
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 09:42:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72AAD10E291;
	Tue, 17 Mar 2026 09:42:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W1xAAWEQ";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A5C110E291
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 09:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flpm9Tt7dEtqK+2ME8V+rH/8Jpo1472K2wHeaJVkJjnZrn8GMd+Tz6sNZ3A+vWfcytmbIUWjAhCIesLVgdydtctvg6s/Aqk37e57SgLDyIASlG4+peuo7+N0YCgipxFo/8mzHgKkpF8coGKpUJcGN4m7pqPZRvrqX3HQ42z7SOabae6Ae9VjL+lHYvYdxq1Lj4cnYi58zo5EZyUHirlz7kSEGgWGMEiF6ypK1EklGEXQx47CmjfmE/XKnr0yiy3ySARk4XbJGPvw9tainIwEngJeh1UeoITNzMaOF5wtA3bwULlxHCcyrA4JM7dYO0hlUOZ/gDB56vio+CHbEKRklw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/BVQisbP7WEz4H+O7qMuKHMEegmb6zwuaDAcw7RiLk=;
 b=pP06vfeF7T4JYiyyS74hbVhx/FXcyXBUPrDzWvhcCr4o5c5+ZBQ2gep8P+C5d0hAJ8d4ituh9MTeXqFpehoVYgDIkgm4PzOOpEdPhaXDv/b/4CEEk+QDmEWniUyFTMK+gBT+rOcKl6fkXjCQRmjnThaO13UTcnU30aRx/yeJZDFhHSIffSs4Uz7wzcdLjGwCk3am8FZkHVBeyk8RTWkWQlAIJoPDiwiUCqG4cTwQqumbSSkMXV/B9l/uzjmHbnZzxCXHEJcyK+u2vh/sMFxMHnxT4YGH8NF0noQqfk7mzHuEYLI5zyDEgIYnXyekTSDcGc4COGTlK8xTutSaEh4B2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/BVQisbP7WEz4H+O7qMuKHMEegmb6zwuaDAcw7RiLk=;
 b=W1xAAWEQ/SKAkVJy/apxfStiSLPINSEXnkB0fElqOccxGW2IM0YOhRosLb9mERuRkRDV/u/8Rod9tyf9GpnDm0DgFt+ajA1/W31xsd2QZTnpbooAXCIJ+CYp2DDTo1RCmuujdBH7CDBXzHDEcnqR0/+pkBykTYah1i+h7By/clc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 09:41:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 09:41:57 +0000
Message-ID: <6f15a639-26de-4f8e-b527-62a4800b13be@amd.com>
Date: Tue, 17 Mar 2026 10:41:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] drm/amdgpu: completely rework eviction fence
 handling
To: "Khatri, Sunil" <sukhatri@amd.com>, tursulin@ursulin.net,
 Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20260310191327.2279-1-christian.koenig@amd.com>
 <20260310191327.2279-4-christian.koenig@amd.com>
 <8cae20bf-4ff5-4a03-8137-36096197364f@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <8cae20bf-4ff5-4a03-8137-36096197364f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0372.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: a11f3671-9e10-4b9d-bc2d-08de84096e02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: EYQugX3HfH3z797PXRSdHjw2yInGPzj4nuP78D2fgmNsVrHvErqGxVjOO2anRsXVrvh1D6E8zOBNgZVUSZAHy4e5cGrtGbqG3W7uowD8aGLPrSo2F8+rLApkCAC60r4An2QYWUzhvpNhxVkrdf3CzDKGccjNSk4c5a3eB1KOOsBpVsjGbtlEBF1JbtEgU76tAyjKjMo3TSDlk0dUj0i8/HrpLRH8exIwmzr+tj34Er4MGXw10DLxxNY/u3JWSmRIqpuF2Tk1afaskvS/dixEofZCK3k1e4QaY16Edk6f2JeCwc4SuFwUY3XxltU4/arM3oViU2nTKiUUXLmYqp2e1/PLOpMZAjraHiMpfChNf77JZE6FvcURy6J00ZTT9tmwvg/6SmEDgpuRfwo/7ZEdDckt2k7BX0G31IldYuDRQEQTvTiaJmvp6WqokT2ib3x84bjbyJv/ZSVXiTDQQL/m/2uTPa38jnNV/yLEyXgeydJfi7+H3YzwlLVr8XfNMXxF3IjO0pIjFhqL+euYP6yBRlg9Xjf7GTjLDL36sfwSDgJ+1hhNSygJyebLO5OKRbWl5D3ForddB2oP5fkpqLKn4LNN4FHuvgh2RVJ8M+PnhaJch7jWj6rvkg6fSLHt9PweFmlryR0oWMvHU28N+r34v+jmxsVYpHIQ+XE4tM5NMlTY8LYvLfw+qyYMQdzqCa8XrNQlBcFfNdOHpUAxHc0Jwjwn0rf3A7Uj1zNbFWtXvMc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3kvVjVXMnFpNW0yS0pOandZcUZvbzJ2aENDcWV2SVZFU2h2d0pEbG5hQ0Fl?=
 =?utf-8?B?RUJ4elVKUjRYSmZEcGZiRDN1ZEwwbnk1d1BlaWM5aGQ0RTZxYnNxSTBWakxJ?=
 =?utf-8?B?RVFRcUxjaWdHTDJITEFmVW1aNTBTQTFPM3hFWURFa2xYV3VOSTkxblgxV3hq?=
 =?utf-8?B?SEJBUEx1aDUxeGpRZUR5Vi9yeTh2NER4b2tuVUxsM3luaWpNN21lQi9xeUJD?=
 =?utf-8?B?eTFjMnRNdnNmM1ZBTmVSb3hzU0V1VnRmcE9LUExFMGdYeWtSY3BDeXBYb3hK?=
 =?utf-8?B?OHdaNkxQUVBBRjJ2cldLUE9FUjhlL1Y0MWpkMlJ0eVFJRWVtdWdUN3pqamc3?=
 =?utf-8?B?VnJyRzlJbFRkWHE5bDNzU3dWQmFrZ0N3RHZscmlHRVVPc09ob08vUnhFVHZJ?=
 =?utf-8?B?NDBPOUlsVGlTR0QrZU9QTkp6NWFNV2I3M2Y2UVpGTU80a0xFQ2hHSk85WHAr?=
 =?utf-8?B?dDVsU0JLTHpCUGN2N3huYmQzVjZteEtPcmQ5Y1ZDeXpPOTRXaSswUFB1OUJ0?=
 =?utf-8?B?OTdhSFJJQ3pINUt1NlBLU29TRVNNejdIM0tSdWplYVAvUlNUYnJCMURoelJw?=
 =?utf-8?B?QnFqM290SEhQNVFCWjhBS2pld0xTNFpsMU5vTlZBeHJBMU1JcWdabi91WTRW?=
 =?utf-8?B?dElJbmpjZmk3YllSU08wK0tKakVyZGQ1T05nK0pjc2diUWtkZnlQS3YzMXMr?=
 =?utf-8?B?b09NS0gvTlg3Sll2YlE1NXFPTENzb3NyWitNMnowQm83Q1R0Zm9PYm95cnlX?=
 =?utf-8?B?L0lENXk3NnhETUxTUnl0MWwyZERxWDI5cTFySjdpdWM2NVlTWU50TWZsck42?=
 =?utf-8?B?ZDlFT3hGQ29aK09JTWtoVi8rWkZnWjkzdVVuUW1uTm9ucXlvWDlEVlFSWFJl?=
 =?utf-8?B?dHhIQWVrTk5XeVM2NWpYbkVNSjg3ODgxQjArWlhsOThYSVd5QUN1NjFsMkh2?=
 =?utf-8?B?WGNuaENBTXJGZ3RXdnVMZHlwekFTVFNtRTIva2FMWnV2U3Jacjlmc1hTUWsy?=
 =?utf-8?B?bXdUKzhuMVROaFJGSHQ1aVR5YXFLV2NVaFM5WWdzeUdyeFFYN0xkdE4rOEZP?=
 =?utf-8?B?WFIxaGlqcnlOSXN0ODJkQUVTaEZoeklMdE0yUlBtK25IMnBZZE5pdzh2RC9F?=
 =?utf-8?B?TVQxRW1UNEVGYW9BcnRzS1IrTlUzbjhwY1I2Um9NSDZRWHBEZTc2b3dYNUE4?=
 =?utf-8?B?WDk4V29DS2dZcjB6KzFZR1RIVjZ0K0sydXc2Y0dTTUNZMHpSZmplSW9Vamdy?=
 =?utf-8?B?eHdHcnpsait6UVRRRVZULytLdmMvWkRlb1BWZ29FUWF6d1BjdWJuUWlvVGR6?=
 =?utf-8?B?a0tEWlBvVUh2ejkyTlpqS3g2TGZwbGliOFlQeVd2WmdoK3d3MWZWKzRHclh1?=
 =?utf-8?B?UEJiWEZQVUJxY1J3aGhzRW5vUUVaalVBSTJIZWMvUlFIWUVrMWhhR00ycFpi?=
 =?utf-8?B?SVpkelo1VHR0U2ZsQjlLQzFvYzl5aXJqeVlBMUcwVzVsb3BvTDE5MHVjOVln?=
 =?utf-8?B?VDZ0TXNwS2tQOUJQbS91a3h1TjE0dWVTY3ZXQUw0eDhNK0JWMmJpVDY2cGhK?=
 =?utf-8?B?WTBNVzVXbEJMbTI4MmdmVGd1NWhDZHZBVXQvT29LS2wxMEF2Q1g4blE3VVo4?=
 =?utf-8?B?RHdZUmlXU1hsWDJSUkErZnR6d09VTy9ab1ovVmFYVlVlQlVTRGRaL2ZONFd2?=
 =?utf-8?B?ZXFtTnhUYmh2R0JNMThLRWV4aEpCYmV6YmRVRXNBLzNXYXZJSncxTzJSL3d4?=
 =?utf-8?B?OHNJR2cxV3lKM1lsZmd6ZE9HKzN4MUVnRSsrc21LS3lJYnU0U3ZoemFpUits?=
 =?utf-8?B?UVZqdXlZVitFOTkrcHdrWDFOc2VJdHJ3eE0xeGhPMWJkdUZKOHdvcW9idW1J?=
 =?utf-8?B?QXc5dGt3YTdod1hWZnJBWnVIQ3NkUmxaM0xGdGZCTldFQjlDaWdXQWxZV1Vk?=
 =?utf-8?B?RnBtU283SkVFREhwS1doTHdjVmZVSCtPQUxIRWdhYTV1cGZBbXNDWEExWWpV?=
 =?utf-8?B?MFN3VWZicWw0alBUblFtaWs2UWsyZ0svczF4U05EMmxLaDJNRkZIV2wyK2hZ?=
 =?utf-8?B?L25TaXhzZjlNSWFWZWFJRDQ2dVlnRnFiSXkzek9meGI1N1NPM1B0NUMxVG9C?=
 =?utf-8?B?QndSRkovaTFYcDIyYkprSkdhQmtjY2lCRy9vcVhaOWI5SEx3ZjJwQ1E3Z0Y4?=
 =?utf-8?B?M1BlR0V3TVdyOGpLcE5NNGNrSXZFT1pScVdUNWpRMVVZcENTc3ZibktyQm5R?=
 =?utf-8?B?dnlIbEhoQnk2MkloUE5iOVdoU1l2bkdDOFdyR09mdVRRZmI3WTIwNUQwLzJ5?=
 =?utf-8?Q?h8tfEiVm+EX0Y6bxjo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a11f3671-9e10-4b9d-bc2d-08de84096e02
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 09:41:57.1953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6uMvvD7BMSxwmrPO6RUEZSJUtUr9krjmxKHNHeqA/G3VoJCzmpLb1qlgL1+ALT3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301
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

On 3/11/26 13:27, Khatri, Sunil wrote:
>>   static bool amdgpu_eviction_fence_enable_signaling(struct dma_fence *f)
>>   {
>>       struct amdgpu_eviction_fence_mgr *evf_mgr;
>>       struct amdgpu_eviction_fence *ev_fence;
>>   -    if (!f)
>> -        return true;
> Isn't there a possibility of the fence being signaled or f to be NULL?

No, I have no idea why everybody things adding such checks is a good idea.

The function is called through the function table of f, so a NULL pointer would have crashed long before calling that here.

Additional to that such NULL checks should only be used in combination with a WARN_ON() since that is clearly incorrect use of the function.

Regards,
Christian.

>> -
>>       ev_fence = to_ev_fence(f);
>>       evf_mgr = ev_fence->evf_mgr;
>> -
>> -    schedule_delayed_work(&evf_mgr->suspend_work, 0);
>> +    schedule_work(&evf_mgr->suspend_work);
> 
> We can avoid to use evf_mgr instead directly use ev_fence->evf_mgr as it is only one time usage.
> 
> Regards
> Sunil Khatri
> 
>>       return true;
>>   }
>>   @@ -148,22 +57,52 @@ static const struct dma_fence_ops amdgpu_eviction_fence_ops = {
>>       .enable_signaling = amdgpu_eviction_fence_enable_signaling,
>>   };
>>   -void amdgpu_eviction_fence_signal(struct amdgpu_eviction_fence_mgr *evf_mgr,
>> -                  struct amdgpu_eviction_fence *ev_fence)
>> +static void
>> +amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>>   {
>> -    spin_lock(&evf_mgr->ev_fence_lock);
>> -    dma_fence_signal(&ev_fence->base);
>> -    spin_unlock(&evf_mgr->ev_fence_lock);
>> +    struct amdgpu_eviction_fence_mgr *evf_mgr =
>> +        container_of(work, struct amdgpu_eviction_fence_mgr,
>> +                 suspend_work);
>> +    struct amdgpu_fpriv *fpriv =
>> +        container_of(evf_mgr, struct amdgpu_fpriv, evf_mgr);
>> +    struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>> +    struct dma_fence *ev_fence;
>> +
>> +    mutex_lock(&uq_mgr->userq_mutex);
>> +    ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
>> +    amdgpu_userq_evict(uq_mgr, !evf_mgr->shutdown);
>> +
>> +    /*
>> +     * Signaling the eviction fence must be done while holding the
>> +     * userq_mutex. Otherwise we won't resume the queues before issuing the
>> +     * next fence.
>> +     */
>> +    dma_fence_signal(ev_fence);
>> +    dma_fence_put(ev_fence);
>> +    mutex_unlock(&uq_mgr->userq_mutex);
>> +}
>> +
>> +void amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
>> +                 struct amdgpu_bo *bo)
>> +{
>> +    struct dma_fence *ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
>> +    struct dma_resv *resv = bo->tbo.base.resv;
>> +
>> +    dma_resv_add_fence(resv, ev_fence, DMA_RESV_USAGE_BOOKKEEP);
>> +    dma_fence_put(ev_fence);
>>   }
>>   -struct amdgpu_eviction_fence *
>> -amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr)
>> +int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
>> +             struct drm_exec *exec)
>>   {
>>       struct amdgpu_eviction_fence *ev_fence;
>> +    struct drm_gem_object *obj;
>> +    unsigned long index;
>>   +    /* Create and initialize a new eviction fence */
>>       ev_fence = kzalloc(sizeof(*ev_fence), GFP_KERNEL);
>>       if (!ev_fence)
>> -        return NULL;
>> +        return -ENOMEM;
>>         ev_fence->evf_mgr = evf_mgr;
>>       get_task_comm(ev_fence->timeline_name, current);
>> @@ -171,56 +110,22 @@ amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr)
>>       dma_fence_init64(&ev_fence->base, &amdgpu_eviction_fence_ops,
>>                &ev_fence->lock, evf_mgr->ev_fence_ctx,
>>                atomic_inc_return(&evf_mgr->ev_fence_seq));
>> -    return ev_fence;
>> -}
>> -
>> -void amdgpu_eviction_fence_destroy(struct amdgpu_eviction_fence_mgr *evf_mgr)
>> -{
>> -    struct amdgpu_eviction_fence *ev_fence;
>> -
>> -    /* Wait for any pending work to execute */
>> -    flush_delayed_work(&evf_mgr->suspend_work);
>> -
>> -    spin_lock(&evf_mgr->ev_fence_lock);
>> -    ev_fence = evf_mgr->ev_fence;
>> -    spin_unlock(&evf_mgr->ev_fence_lock);
>> -
>> -    if (!ev_fence)
>> -        return;
>> -
>> -    dma_fence_wait(&ev_fence->base, false);
>>   -    /* Last unref of ev_fence */
>> -    dma_fence_put(&ev_fence->base);
>> -}
>> -
>> -int amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
>> -                 struct amdgpu_bo *bo)
>> -{
>> -    struct amdgpu_eviction_fence *ev_fence;
>> -    struct dma_resv *resv = bo->tbo.base.resv;
>> -    int ret;
>> +    /* Remember it for newly added BOs */
>> +    dma_fence_put(evf_mgr->ev_fence);
>> +    evf_mgr->ev_fence = &ev_fence->base;
>>   -    if (!resv)
>> -        return 0;
>> +    /* And add it to all existing BOs */
>> +    drm_exec_for_each_locked_object(exec, index, obj) {
>> +        struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
>>   -    ret = dma_resv_reserve_fences(resv, 1);
>> -    if (ret) {
>> -        DRM_DEBUG_DRIVER("Failed to resv fence space\n");
>> -        return ret;
>> +        amdgpu_evf_mgr_attach_fence(evf_mgr, bo);
>>       }
>> -
>> -    spin_lock(&evf_mgr->ev_fence_lock);
>> -    ev_fence = evf_mgr->ev_fence;
>> -    if (ev_fence)
>> -        dma_resv_add_fence(resv, &ev_fence->base, DMA_RESV_USAGE_BOOKKEEP);
>> -    spin_unlock(&evf_mgr->ev_fence_lock);
>> -
>>       return 0;
>>   }
>>   -void amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
>> -                  struct amdgpu_bo *bo)
>> +void amdgpu_evf_mgr_detach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
>> +                 struct amdgpu_bo *bo)
>>   {
>>       struct dma_fence *stub = dma_fence_get_stub();
>>   @@ -229,13 +134,25 @@ void amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
>>       dma_fence_put(stub);
>>   }
>>   -int amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr *evf_mgr)
>> +void amdgpu_evf_mgr_init(struct amdgpu_eviction_fence_mgr *evf_mgr)
>>   {
>> -    /* This needs to be done one time per open */
>>       atomic_set(&evf_mgr->ev_fence_seq, 0);
>>       evf_mgr->ev_fence_ctx = dma_fence_context_alloc(1);
>> -    spin_lock_init(&evf_mgr->ev_fence_lock);
>> +    evf_mgr->ev_fence = dma_fence_get_stub();
>>   -    INIT_DELAYED_WORK(&evf_mgr->suspend_work, amdgpu_eviction_fence_suspend_worker);
>> -    return 0;
>> +    INIT_WORK(&evf_mgr->suspend_work, amdgpu_eviction_fence_suspend_worker);
>> +}
>> +
>> +void amdgpu_evf_mgr_shutdown(struct amdgpu_eviction_fence_mgr *evf_mgr)
>> +{
>> +    evf_mgr->shutdown = true;
>> +    flush_work(&evf_mgr->suspend_work);
>> +}
>> +
>> +void amdgpu_evf_mgr_fini(struct amdgpu_eviction_fence_mgr *evf_mgr)
>> +{
>> +    dma_fence_wait(rcu_dereference_protected(evf_mgr->ev_fence, true),
>> +               false);
>> +    flush_work(&evf_mgr->suspend_work);
>> +    dma_fence_put(evf_mgr->ev_fence);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>> index fcd867b7147d..527de3a23583 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>> @@ -25,6 +25,8 @@
>>   #ifndef AMDGPU_EV_FENCE_H_
>>   #define AMDGPU_EV_FENCE_H_
>>   +#include <linux/dma-fence.h>
>> +
>>   struct amdgpu_eviction_fence {
>>       struct dma_fence base;
>>       spinlock_t     lock;
>> @@ -35,35 +37,35 @@ struct amdgpu_eviction_fence {
>>   struct amdgpu_eviction_fence_mgr {
>>       u64            ev_fence_ctx;
>>       atomic_t        ev_fence_seq;
>> -    spinlock_t        ev_fence_lock;
>> -    struct amdgpu_eviction_fence *ev_fence;
>> -    struct delayed_work    suspend_work;
>> -    uint8_t fd_closing;
>> -};
>> -
>> -/* Eviction fence helper functions */
>> -struct amdgpu_eviction_fence *
>> -amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr);
>>   -void
>> -amdgpu_eviction_fence_destroy(struct amdgpu_eviction_fence_mgr *evf_mgr);
>> -
>> -int
>> -amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
>> -                 struct amdgpu_bo *bo);
>> +    /*
>> +     * Only updated while holding the VM resv lock.
>> +     * Only signaled while holding the userq mutex.
>> +     */
>> +    struct dma_fence __rcu    *ev_fence;
>> +    struct work_struct    suspend_work;
>> +    bool            shutdown;
>> +};
>>   -void
>> -amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
>> -                 struct amdgpu_bo *bo);
>> +static inline struct dma_fence *
>> +amdgpu_evf_mgr_get_fence(struct amdgpu_eviction_fence_mgr *evf_mgr)
>> +{
>> +    struct dma_fence *ev_fence;
>>   -int
>> -amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr *evf_mgr);
>> +    rcu_read_lock();
>> +    ev_fence = dma_fence_get_rcu_safe(&evf_mgr->ev_fence);
>> +    rcu_read_unlock();
>> +    return ev_fence;
>> +}
>>   -void
>> -amdgpu_eviction_fence_signal(struct amdgpu_eviction_fence_mgr *evf_mgr,
>> -                 struct amdgpu_eviction_fence *ev_fence);
>> +void amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
>> +                 struct amdgpu_bo *bo);
>> +int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
>> +             struct drm_exec *exec);
>> +void amdgpu_evf_mgr_detach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
>> +                 struct amdgpu_bo *bo);
>> +void amdgpu_evf_mgr_init(struct amdgpu_eviction_fence_mgr *evf_mgr);
>> +void amdgpu_evf_mgr_shutdown(struct amdgpu_eviction_fence_mgr *evf_mgr);
>> +void amdgpu_evf_mgr_fini(struct amdgpu_eviction_fence_mgr *evf_mgr);
>>   -int
>> -amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
>> -                    struct drm_exec *exec);
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 5c90de58cc28..e28abfd04867 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -263,13 +263,7 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>>       else
>>           ++bo_va->ref_count;
>>   -    /* attach gfx eviction fence */
>> -    r = amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
>> -    if (r) {
>> -        DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n");
>> -        amdgpu_bo_unreserve(abo);
>> -        return r;
>> -    }
>> +    amdgpu_evf_mgr_attach_fence(&fpriv->evf_mgr, abo);
>>       drm_exec_fini(&exec);
>>         /* Validate and add eviction fence to DMABuf imports with dynamic
>> @@ -337,7 +331,7 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>>       }
>>         if (!amdgpu_vm_is_bo_always_valid(vm, bo))
>> -        amdgpu_eviction_fence_detach(&fpriv->evf_mgr, bo);
>> +        amdgpu_evf_mgr_detach_fence(&fpriv->evf_mgr, bo);
>>         bo_va = amdgpu_vm_bo_find(vm, bo);
>>       if (!bo_va || --bo_va->ref_count)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index f69332eed051..f512b6ec6c53 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -1522,10 +1522,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>>                "Failed to init usermode queue manager (%d), use legacy workload submission only\n",
>>                r);
>>   -    r = amdgpu_eviction_fence_init(&fpriv->evf_mgr);
>> -    if (r)
>> -        goto error_vm;
>> -
>> +    amdgpu_evf_mgr_init(&fpriv->evf_mgr);
>>       amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
>>         file_priv->driver_priv = fpriv;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 85adc53eb523..67ba46851c2b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -472,17 +472,16 @@ void
>>   amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
>>                    struct amdgpu_eviction_fence_mgr *evf_mgr)
>>   {
>> -    struct amdgpu_eviction_fence *ev_fence;
>> +    struct dma_fence *ev_fence;
>>     retry:
>>       /* Flush any pending resume work to create ev_fence */
>>       flush_delayed_work(&uq_mgr->resume_work);
>>         mutex_lock(&uq_mgr->userq_mutex);
>> -    spin_lock(&evf_mgr->ev_fence_lock);
>> -    ev_fence = evf_mgr->ev_fence;
>> -    spin_unlock(&evf_mgr->ev_fence_lock);
>> -    if (!ev_fence || dma_fence_is_signaled(&ev_fence->base)) {
>> +    ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
>> +    if (dma_fence_is_signaled(ev_fence)) {
>> +        dma_fence_put(ev_fence);
>>           mutex_unlock(&uq_mgr->userq_mutex);
>>           /*
>>            * Looks like there was no pending resume work,
>> @@ -491,6 +490,7 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
>>           schedule_delayed_work(&uq_mgr->resume_work, 0);
>>           goto retry;
>>       }
>> +    dma_fence_put(ev_fence);
>>   }
>>     int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
>> @@ -1196,7 +1196,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>>           dma_fence_wait(bo_va->last_pt_update, false);
>>       dma_fence_wait(vm->last_update, false);
>>   -    ret = amdgpu_eviction_fence_replace_fence(&fpriv->evf_mgr, &exec);
>> +    ret = amdgpu_evf_mgr_rearm(&fpriv->evf_mgr, &exec);
>>       if (ret)
>>           drm_file_err(uq_mgr->file, "Failed to replace eviction fence\n");
>>   @@ -1216,11 +1216,13 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
>>   {
>>       struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, resume_work.work);
>>       struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>> +    struct dma_fence *ev_fence;
>>       int ret;
>>   -    flush_delayed_work(&fpriv->evf_mgr.suspend_work);
>> -
>>       mutex_lock(&uq_mgr->userq_mutex);
>> +    ev_fence = amdgpu_evf_mgr_get_fence(&fpriv->evf_mgr);
>> +    if (!dma_fence_is_signaled(ev_fence))
>> +        goto unlock;
>>         ret = amdgpu_userq_vm_validate(uq_mgr);
>>       if (ret) {
>> @@ -1236,6 +1238,7 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
>>     unlock:
>>       mutex_unlock(&uq_mgr->userq_mutex);
>> +    dma_fence_put(ev_fence);
>>   }
>>     static int
>> @@ -1311,11 +1314,8 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>>   }
>>     void
>> -amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
>> -           struct amdgpu_eviction_fence *ev_fence)
>> +amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr, bool schedule_resume)
>>   {
>> -    struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>> -    struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
>>       struct amdgpu_device *adev = uq_mgr->adev;
>>       int ret;
>>   @@ -1328,10 +1328,7 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
>>       if (ret)
>>           dev_err(adev->dev, "Failed to evict userqueue\n");
>>   -    /* Signal current eviction fence */
>> -    amdgpu_eviction_fence_signal(evf_mgr, ev_fence);
>> -
>> -    if (!evf_mgr->fd_closing)
>> +    if (schedule_resume)
>>           schedule_delayed_work(&uq_mgr->resume_work, 0);
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> index 54e1997b3cc0..82306d489064 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> @@ -133,7 +133,7 @@ void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
>>                    struct amdgpu_userq_obj *userq_obj);
>>     void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
>> -            struct amdgpu_eviction_fence *ev_fence);
>> +            bool schedule_resume);
>>     void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
>>                     struct amdgpu_eviction_fence_mgr *evf_mgr);

