Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3897DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 11:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A5856E0DE;
	Mon, 22 Nov 2021 11:34:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66AC46E0EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 11:34:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzsKZNqRdLtu37IEe8nCoUcqkLS+p2ynKNVw8eBBJ+27/zQSkG8blPzFjzSd/qSgEVKBm//kR+q82agJKkdZRKG4i9+ZA1zgWzkx8fi1QkTuD8EoKW2YObNy0V4yxMTLlbJhW7Wb8j35O4yZzLH3glS5AHvoCDz9HsWH/7OTcX0wT5vn/TZDONuskQ7LdW6Kfa9Vk1lO663v8KaX26qTTaVIeYhXj/9fsopCO6hSQ6HVrE3kzwrF9K1tj0j9o0LEh2SWI4TAeM2ufNJE9hN13YXy7w/spbmNSMTpqGpuFj83wrsatX+wVIr1PbQVX5IbMGLveeRT/9uPX2dTZ0sHrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tP/M09iPHiveoRUFy5+BNIoXYZBhXX/AhLsFlB5piDo=;
 b=GNYfmINOdxCC3TXTun+X92g+z2DdPQ38vHMVfaEhRS3KsQcrgyyhkwWDOWNUqHsHupuXfi6UE6hQ0dNESDyO5Uf3hlW4r735tuXHOmjYiTqfRgrEak0CKv0V+taXe2VKeWLDL8REtrVQM+pkHJK5+ylZ9CbVn1EZweyWuj6ejBVoJ7JXREWop5kW6NMpFvGheqwoBzavKP+A6wLIjbqDQcoGJfsHJCBMej5L1EQT0cykD/Ou8udFw33AZqGptH96AdbIjfhw1fUrDl5brSELRGs+MYi2WRcH0oU/1Rbbl+hKzjz4bqC8G56W1A8LNNXPQh5vV2bsonib5nDP6nrSxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tP/M09iPHiveoRUFy5+BNIoXYZBhXX/AhLsFlB5piDo=;
 b=swbt/Xp9L2v/tNz+OKOX50X3SjkrB/ENDOktpDvL3RMwHQGRXGjaiffqCJhsBNA7mYcZ6ajmtxN7m3nVd2PrSjigIfbYlloQNwwnTahlvlM3Oh/uryWcQoW/9aVeGL3j5kKhevELsUo5nmjYLLd27hfftLuPq2I4T5R0RDkVs0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR1201MB2478.namprd12.prod.outlook.com
 (2603:10b6:300:e5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Mon, 22 Nov
 2021 11:34:24 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769%5]) with mapi id 15.20.4713.025; Mon, 22 Nov 2021
 11:34:17 +0000
Subject: Re: [PATCH v2] drm/amdkfd: handle IH ring1 overflow
To: philip yang <yangp@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211119202233.13486-1-Philip.Yang@amd.com>
 <2a610519-689f-c3d0-3675-59f7c64eaf4f@amd.com>
 <3d49a81d-793f-177f-606a-2c405685036e@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <64e46791-cbe5-1bcb-93e2-be52d2dcce0c@amd.com>
Date: Mon, 22 Nov 2021 12:34:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <3d49a81d-793f-177f-606a-2c405685036e@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM5PR0201CA0022.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::32) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:d8e9:8c9d:bf39:6d9a]
 (2a02:908:1252:fb60:d8e9:8c9d:bf39:6d9a) by
 AM5PR0201CA0022.eurprd02.prod.outlook.com (2603:10a6:203:3d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Mon, 22 Nov 2021 11:34:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 704e894d-b036-4e28-1877-08d9adac0428
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2478:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2478D393689670EBBD462BF9839F9@MWHPR1201MB2478.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DOtEu6vMGElAQq1/PZE1K6vfH8lmgbBlfoJpVb5+3pHgJSD7oJoNambEyRB1IufmNgtDlKxXy9cZyc1vB+q8e9DuzdGG38shljsdf8z2RRJc9uhe2hcnsooIDEQ3PaTelV8ULEgwctznbMFfUc68haPAbdNVZVihLIxLP+9oxEpSTrQlD7Q+sJoeotzpx/RwNwept2sWSl6Wn8fpvWooIKN4zBpTHbo3dCdm1gK9HFXv1dismblolXbwH8r3U7+jhcklbaUcbcysOtYrEDQfuhQqpCg7wFMNwHn0aM3GqOVnuwBrXAbImY9MfOttk+t/i/2vHjBkDmUVz1o8XHYmVl0ZOD91g1RpbII9WXwbgtvBImUj5xY0PS8ZMAjfWWssAO0rW5GCRDBdc1hVxSAmooolszMNd1QZ5R+p5b6LTa+yPvj2zV6sWJSBg7Nz5Hvl7J7zUnCMJI+M92dy104JicQD6cv5Rl40l+vptL6LNHSZvdnECwEEt8QB2G1ojVHBAiazBJuCjnGP//bn6FOTAnKR21vh5V4p7TU6C592jL2gKRZcBVaWnbD1MuDABx7ZSPeRT2ACdeL4k/RrF0H71qbVmaxu3f8YPOM5/hMfSpTITtxAdf41m1G9yXZpBZpQkJwB0j3zeTzOKMavY5kkPMz0scGh4Ty086UB7cS1upYuMFODG1Pdtl+/eMUCTi3ki7VTweGTsHEfRvBzJWtNc4v2EA666wDx5jjfFkf645MEgHGhTUzX7Qe4nmz4T2ek
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(2906002)(66476007)(5660300002)(6666004)(8676002)(508600001)(83380400001)(31696002)(110136005)(4001150100001)(316002)(53546011)(66556008)(8936002)(31686004)(66946007)(30864003)(38100700002)(6486002)(186003)(86362001)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RC9lSGxTMDlmeHhSRWRGYnlDRWhjdnJTOUhEWE5mMUJQNDVSQWFLZlcxMmFy?=
 =?utf-8?B?bTBMS0E2eUs4dTZ5Y3FSWWJhYVdsYXgvaDZJRjRkZE01U05ldlM3b3V3dnlJ?=
 =?utf-8?B?MENwWDdrVFFOeEp1RmVYMGlLQnhzWTJjb3MvaG9pV2R6MmJ1NlBCaktVdVBZ?=
 =?utf-8?B?RDlnTFJqekNTdC9jU3hzVTRJT1F0L0hzN0xMQVZmWms1YStjNGszWjBKejB1?=
 =?utf-8?B?dk5BYnRLRENNQmVjRHdtVXNvc0hlVU5Gdjh1QWozOVRndGRYMnVZZ2c0U0Jx?=
 =?utf-8?B?U1YyalhaU2U3eUk2Wi9uYmZBYURHM0Q1ZWhKZmdLM3pGTU9PWVJyUEZyMFpp?=
 =?utf-8?B?UTRVTVNIU0ZqQmJyQStrNDl4R2NRQkx5aHdZelpDeE9hSFNya21mMGFtY0Fn?=
 =?utf-8?B?U2xMU1RSZWZ5b2lEaGtPVjlTaFZ2RithTVBGbGZNTG5zYUFFZmsyRGY1VUs4?=
 =?utf-8?B?VjRSTGVUbkNYeGJ0SFprdmlqTzU0bGJjakUyRW1NRHlIN1VDLys3T2JnSWJZ?=
 =?utf-8?B?enQ2Q3pVNExXRWVXcnFNVnFVVjBjWGFMTlVqKzBRZ0VFMDByYTA4bmJhN3V2?=
 =?utf-8?B?dVJuYlFHRWxrUDcwc1hHaUZyVlVsQ2tXbkpZNVoxenJXV1pIdEhabTkvS25N?=
 =?utf-8?B?T1dZVTVrTGJVb2E2dElwcTEvMGpxSUVaSlFxdTdCVmJXcTNlL3c4WUUrd0hF?=
 =?utf-8?B?WW5JQWVidlFHWVFpa1FPcS9yVWdTN2xtV1hFYVlJYnBPdTh3cWFRbkdTcVB2?=
 =?utf-8?B?ME1OME1VdVdJaFVseS9pK0NKMS84bXdZYXAxTUVKa2k3bDRjLy81bm1MdW9J?=
 =?utf-8?B?STVQWXNzcXVCVWRCN0RLMVJJUEJjZGgycWxGYm96dWduaVBxdUozRDJORTNi?=
 =?utf-8?B?UE1Ecnd4dm9FSWtud2YyRzhGdVg4eENhTWlrdHdabkhwZXlSWE9BOXAwVk1q?=
 =?utf-8?B?WlRsZzlYcXduZ0tZWWxaMFRVcEMzcjlPUk4rOUloc2NpZWNzRWF6ZW43bXVV?=
 =?utf-8?B?MmV6MDNEYmtZUWduc3daMEJlc2tNcXh5VWZ3a1hLcTJvdWlvWXl1ZkhuUlU2?=
 =?utf-8?B?cEFBcEloZkVxekxDb1FNZHh5OGlaakxqY3IveHBWOGt6djY2UWhPVUQrbm9U?=
 =?utf-8?B?Qmd1bmtRbkNZU2llRXJkWm9VSzF4aSs4OFN4S1pSV0xxYy9FUnVNYjU3ZGt1?=
 =?utf-8?B?eG9URE5LNVI1ZU03bnJhdWxuSm1BRlE4SFkxdWF0REpaNEd6YjlnK3dQZWRh?=
 =?utf-8?B?Njc5VmMyN0pXVERIdjVMSUV1dzRoaUJGd1FabzF5eDdEa1VKdzk1VDlRK0JJ?=
 =?utf-8?B?My9OQ0RyaTJ6eE8vVWtvQzBhR3ExWWI4WmtyckxTR3JGOEwwNDVUK0tMc0V4?=
 =?utf-8?B?R1Y0VTVrNmd1czRyN2YwVUtSQmZFT1RBVDNIQlFvRStYa2k2TGlwKys4M0d5?=
 =?utf-8?B?WDJyVWNLWWVIRE5JUVF0Y25iTm9Yb3BucVlPZHBMSk0yMTNtTlVBdkFVQUc4?=
 =?utf-8?B?cUoxZVgyR0Vyb2FzVEdLTExpbFFDYXE2bDdDdmJOVWRHMkRqNDdWd1NMWis1?=
 =?utf-8?B?RVZyenRBU1RIME1zaFFOdXVCUGpKc2ZPdVUrUUlaY2hDQ1ZaT1d3a2RFeXhq?=
 =?utf-8?B?SVY3dGZRcnJ2dkFqTHZWRzhZb0VvUWk3MXpJb283NjBkYlRUSkhINk9WR2xi?=
 =?utf-8?B?QnNPakZDeEptL2NTeWlkV2N0QUlHMjY1a0Nnc3U1Z2RzNGZkeThxejQ3OTVI?=
 =?utf-8?B?ZEZLQlpXTjBkS2FHemQ1TWZiS09PZ2c3S3UvUUN5VXFkS2swbkxiUW9odVdS?=
 =?utf-8?B?eFRzUEo0cExmdjFWbERaTkJ0eXhwclpLdkIvUnY3WE9FOGJCMXZDcGlVVU56?=
 =?utf-8?B?QkIrVVduc3hZWnRCWVJkaGxqK1cvWjZ2Z0hiS0JBak41d0RZMTZ6YzZkTFY4?=
 =?utf-8?B?OGFTc3N2Tkp3TUVrSktndHNIbEdkN0x2VmpqdDFXY2Jkb092UHNSbG9iRHlK?=
 =?utf-8?B?YVc0NHM0UW9xUXlvVnFGcEJnbG53UzRYK3NtNFhWbnpLTVJZMlVxSTk5NGps?=
 =?utf-8?B?bUlCMjNueDF2L1plaHZ4a3hUdTJobzFYNk9YbTZnak93cUh2YUFTbWJEYjUw?=
 =?utf-8?B?RGhMT3pvdTNqZGhxN0puUEV0OHhGc3QwTkZHdHZ3V0lJZll3L3phRkxCcEhE?=
 =?utf-8?Q?8YoVTJrsw7HsoGqZAS9OVpg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 704e894d-b036-4e28-1877-08d9adac0428
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 11:34:16.7721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UuUFJOq8vEdRWSSGC6S78U6XU6kzvohJTjsCTAql8PPvG5DKDE+N02UwjjCGBhvO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2478
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

Am 21.11.21 um 03:13 schrieb philip yang:
>
> On 2021-11-19 5:59 p.m., Felix Kuehling wrote:
>
>> On 2021-11-19 3:22 p.m., Philip Yang wrote:
>>> IH ring1 is used to process GPU retry fault, overflow is enabled to
>>> drain retry fault because we want receive other interrupts while
>>> handling retry fault to recover range. There is no overflow flag set
>>> when wptr pass rptr. Use timestamp of rptr and wptr to handle overflow
>>> and drain retry fault.
>>>
>>> Add helper function amdgpu_ih_decode_iv_ts to get 48bit timestamp from
>>> IV entry. drain retry fault check timestamp of rptr is larger than
>>> timestamp of (checkpoint_wptr - 32).
>>>
>>> Add function amdgpu_ih_process1 to process IH ring1 until timestamp of
>>> rptr is larger then timestamp of (rptr + 32).
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 98 
>>> +++++++++++++++++++------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  |  6 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c |  2 +-
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c    |  2 +-
>>>   4 files changed, 80 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>>> index f3d62e196901..ad12f9d5d86a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>>> @@ -165,51 +165,41 @@ void amdgpu_ih_ring_write(struct 
>>> amdgpu_ih_ring *ih, const uint32_t *iv,
>>>   }
>>>     /* Waiter helper that checks current rptr matches or passes 
>>> checkpoint wptr */
>>> -static bool amdgpu_ih_has_checkpoint_processed(struct amdgpu_device 
>>> *adev,
>>> +static bool amdgpu_ih_has_checkpoint_processed_ts(struct 
>>> amdgpu_device *adev,
>>>                       struct amdgpu_ih_ring *ih,
>>> -                    uint32_t checkpoint_wptr,
>>> -                    uint32_t *prev_rptr)
>>> +                    uint64_t checkpoint_ts)
>>>   {
>>> -    uint32_t cur_rptr = ih->rptr | (*prev_rptr & ~ih->ptr_mask);
>>> -
>>> -    /* rptr has wrapped. */
>>> -    if (cur_rptr < *prev_rptr)
>>> -        cur_rptr += ih->ptr_mask + 1;
>>> -    *prev_rptr = cur_rptr;
>>> -
>>> -    /* check ring is empty to workaround missing wptr overflow flag */
>>> -    return cur_rptr >= checkpoint_wptr ||
>>> -           (cur_rptr & ih->ptr_mask) == amdgpu_ih_get_wptr(adev, ih);
>>> +    /* After wakeup, ih->rptr is the entry which is being 
>>> processed, check
>>> +     * the timestamp of previous entry which is processed.
>>> +     */
>>> +    return checkpoint_ts <= amdgpu_ih_decode_iv_ts(ih, ih->rptr - 32);
>>
>> This assumes a IV size of 32 bytes, which is not true for all ASICs. 
>> On GFXv8 and older GPUs it's on 16. OTOH, those chips don't have a 
>> ring1 and may not have a timestamp in the IV at all.
>>
> ring1 process is enabled for vega10/20, navi10, not for older GPUs, as 
> it is scheduled from self-irq.

I think we should try to avoid accessing the IH ring buffer outside of 
the handler anyway.

So instead of that here we should probably just always update the last 
decoded timestamp after a call to amdgpu_ih_decode_iv_helper().

>> And I think you need to be better at handling when the time stamps 
>> wrap. Keep in mind that the number of valid bits may vary between ASICs.
>>
> yes, 48bit time stamp will wrap around after 1 year, add function 
> amdgpu_ih_ts_after to compare time stamp with wrap around case.

Yeah, I think we need to handle that gracefully.

Regards,
Christian.

>>
>>>   }
>>>     /**
>>> - * amdgpu_ih_wait_on_checkpoint_process - wait to process IVs up to 
>>> checkpoint
>>> + * amdgpu_ih_wait_on_checkpoint_process_ts - wait to process IVs up 
>>> to checkpoint
>>>    *
>>>    * @adev: amdgpu_device pointer
>>>    * @ih: ih ring to process
>>>    *
>>>    * Used to ensure ring has processed IVs up to the checkpoint 
>>> write pointer.
>>>    */
>>> -int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
>>> +int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device 
>>> *adev,
>>>                       struct amdgpu_ih_ring *ih)
>>
>> If this function is only meant to work on ring1 now, we should 
>> probably ensure that by checking that ih is really ring1.
>>
> Add dev_WARN_ONCE(adev->dev, ih != &adev->irq.ih1, "not ring1")) to 
> ensure this is only for ring1.
>
>> Do we need to keep the old solution for Vega20, which doesn't reroute 
>> interrupts to ring1?
>>
> Vega20 is not changed, because Vega20 retry fault delegate to ih_soft, 
> and wptr overflow is not enabled on ih_soft, no stale retry fault 
> issue, keep old interrupt handler for ih_soft.
>>
>>>   {
>>> -    uint32_t checkpoint_wptr, rptr;
>>> +    uint32_t checkpoint_wptr;
>>> +    uint64_t checkpoint_ts;
>>>         if (!ih->enabled || adev->shutdown)
>>>           return -ENODEV;
>>>         checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
>>> -    /* Order wptr with rptr. */
>>> +    /* Order wptr with ring data. */
>>>       rmb();
>>> -    rptr = READ_ONCE(ih->rptr);
>>> -
>>> -    /* wptr has wrapped. */
>>> -    if (rptr > checkpoint_wptr)
>>> -        checkpoint_wptr += ih->ptr_mask + 1;
>>> +    checkpoint_ts = amdgpu_ih_decode_iv_ts(ih, checkpoint_wptr - 32);
>>
>> Same as above.
> done in v3
>>
>>
>>>         return wait_event_interruptible(ih->wait_process,
>>> -                amdgpu_ih_has_checkpoint_processed(adev, ih,
>>> -                        checkpoint_wptr, &rptr));
>>> +                amdgpu_ih_has_checkpoint_processed_ts(adev, ih,
>>> +                        checkpoint_ts));
>>>   }
>>>     /**
>>> @@ -253,6 +243,56 @@ int amdgpu_ih_process(struct amdgpu_device 
>>> *adev, struct amdgpu_ih_ring *ih)
>>>       return IRQ_HANDLED;
>>>   }
>>>   +/**
>>> + * amdgpu_ih_process1 - interrupt handler work for IH ring1
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + * @ih: ih ring to process
>>> + *
>>> + * Interrupt handler of IH ring1, walk the IH ring1.
>>> + * Returns irq process return code.
>>> + */
>>> +int amdgpu_ih_process1(struct amdgpu_device *adev, struct 
>>> amdgpu_ih_ring *ih)
>>> +{
>>> +    uint64_t ts, ts_next;
>>> +    unsigned int count;
>>> +    u32 wptr;
>>> +
>>> +    if (!ih->enabled || adev->shutdown)
>>> +        return IRQ_NONE;
>>> +
>>> +    wptr = amdgpu_ih_get_wptr(adev, ih);
>>> +    if (ih->rptr == wptr)
>>> +        return 0;
>>> +
>>> +restart_ih:
>>> +    count = AMDGPU_IH_MAX_NUM_IVS;
>>> +
>>> +    ts = amdgpu_ih_decode_iv_ts(ih, ih->rptr);
>>> +    ts_next = amdgpu_ih_decode_iv_ts(ih, ih->rptr + 32);
>>
>> Same as above.
>>
> Done in v3
>>
>>> +    while (ts < ts_next && --count) {
>>> +        amdgpu_irq_dispatch(adev, ih);
>>> +        ih->rptr &= ih->ptr_mask;
>>> +        ts = ts_next;
>>> +        ts_next = amdgpu_ih_decode_iv_ts(ih, ih->rptr + 32);
>>> +    }
>>> +    /*
>>> +     * Process the last timestamp updated entry or one more entry
>>> +     * if count = 0, ts is timestamp of the entry.
>>> +     */
>>> +    amdgpu_irq_dispatch(adev, ih);
>>> +    amdgpu_ih_set_rptr(adev, ih);
>>> +    wake_up_all(&ih->wait_process);
>>> +
>>> +    wptr = amdgpu_ih_get_wptr(adev, ih);
>>> +    /* Order reading of wptr vs. reading of IH ring data */
>>> +    rmb();
>>> +    if (ts < amdgpu_ih_decode_iv_ts(ih, wptr - 32))
>>> +        goto restart_ih;
>>> +
>>> +    return IRQ_HANDLED;
>>> +}
>>> +
>>>   /**
>>>    * amdgpu_ih_decode_iv_helper - decode an interrupt vector
>>>    *
>>> @@ -298,3 +338,13 @@ void amdgpu_ih_decode_iv_helper(struct 
>>> amdgpu_device *adev,
>>>       /* wptr/rptr are in bytes! */
>>>       ih->rptr += 32;
>>>   }
>>> +
>>> +uint64_t amdgpu_ih_decode_iv_ts(struct amdgpu_ih_ring *ih, u32 rptr)
>>
>> This function needs to be in IP-version-specific code. Maybe add an 
>> offset parameter, that way you can handle different IV sizes in 
>> different ASIC generations.
>>
> Add decode_iv_ts function interface to amdgpu_ih_function, this will 
> be used for different ASICs, to handle different IV size and time 
> stamp offset. vega*, navi* ASICs use this as helper function.
>
> Regards,
>
> Philip
>
>>
>>> +{
>>> +    uint32_t index = (rptr & ih->ptr_mask) >> 2;
>>> +    uint32_t dw1, dw2;
>>> +
>>> +    dw1 = ih->ring[index + 1];
>>> +    dw2 = ih->ring[index + 2];
>>> +    return dw1 | ((u64)(dw2 & 0xffff) << 32);
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>>> index 0649b59830a5..15e8fe0e5e40 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>>> @@ -89,10 +89,12 @@ int amdgpu_ih_ring_init(struct amdgpu_device 
>>> *adev, struct amdgpu_ih_ring *ih,
>>>   void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct 
>>> amdgpu_ih_ring *ih);
>>>   void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const 
>>> uint32_t *iv,
>>>                 unsigned int num_dw);
>>> -int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
>>> -                    struct amdgpu_ih_ring *ih);
>>> +int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device 
>>> *adev,
>>> +                        struct amdgpu_ih_ring *ih);
>>>   int amdgpu_ih_process(struct amdgpu_device *adev, struct 
>>> amdgpu_ih_ring *ih);
>>> +int amdgpu_ih_process1(struct amdgpu_device *adev, struct 
>>> amdgpu_ih_ring *ih);
>>>   void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
>>>                   struct amdgpu_ih_ring *ih,
>>>                   struct amdgpu_iv_entry *entry);
>>> +uint64_t amdgpu_ih_decode_iv_ts(struct amdgpu_ih_ring *ih, u32 rptr);
>>>   #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> index e9023687dc9a..891486cca94b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> @@ -224,7 +224,7 @@ static void amdgpu_irq_handle_ih1(struct 
>>> work_struct *work)
>>>       struct amdgpu_device *adev = container_of(work, struct 
>>> amdgpu_device,
>>>                             irq.ih1_work);
>>>   -    amdgpu_ih_process(adev, &adev->irq.ih1);
>>> +    amdgpu_ih_process1(adev, &adev->irq.ih1);
>>>   }
>>>     /**
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 88360f23eb61..9e566ec54cf5 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -1968,7 +1968,7 @@ static void svm_range_drain_retry_fault(struct 
>>> svm_range_list *svms)
>>>             pr_debug("drain retry fault gpu %d svms %p\n", i, svms);
>>>   - amdgpu_ih_wait_on_checkpoint_process(pdd->dev->adev,
>>> + amdgpu_ih_wait_on_checkpoint_process_ts(pdd->dev->adev,
>>> &pdd->dev->adev->irq.ih1);
>>>           pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, 
>>> svms);
>>>       }

