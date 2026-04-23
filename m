Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F137BF589D4
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 13:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E2E710F135;
	Thu, 23 Apr 2026 13:32:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I0jIIbNb";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F1FA10F135
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 13:32:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQ/hxBbdfJA1u3HVItoMLWxGebL4ANVNl4lBcFyaO9RWTyRNZyZMg3/0oCx2r4FpyqPezamDJ85GUd1dQqbTH5qFeqIVWXrF32Hk7ig/1gGcilrK86PZLBzo0AOD5yztY4+XF2nlogDNpCgZEkq4UzrA9h7rhDbcC/nNiruNwam5ymTOS64Xm/Bih2cxJHxU+pfwhQWh6S5rAProbT0DnhT8mHVvTv19HSZcp1GdyHWbexVukf2gaFe9pz/UuUusF/0iPmxr4CELMZvRaNk+YoGHeF3pXDVAzkGOyrgKyxuK8bTlbVqtz3zOMf4uXyejd/QkBCBoECATactpXvJFmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+jAw9bf2K1zOlb0OT99RVvnKtfhAqe14fHlpVkRxvQ=;
 b=nV4H+KE4v6l6J+pvoSxjR9oYn9SmKdqz7ddcs9ALv77EyE/Bnu/19mj/F0NZFuHrtXf2fyUKMram9ZrcFZL+jt6GMyoreNdWkaQ7MZYldhOA4+o1nZLgZlkt2GdFO+ajrMT/VaPAq1W6Z+Lr4hTr+eRTBamWSlE2qMTYd+kl+KaiMvqmjQy8ysZJJJQuFZQpHDfnE0LwK/SRTlcI5YhoHKNvoMCqvLMRQ335b4Eceb3m02gUQUEf3t2jxo0N094+xE4tlasAmlkdAq0IusgB8y2vyQmKPzuBskVFP0bTr2FrF4+YeiwfLKsCtYpl/FjhoYo0ul7B/Es3NS8Z4y+JBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+jAw9bf2K1zOlb0OT99RVvnKtfhAqe14fHlpVkRxvQ=;
 b=I0jIIbNbPxBeZoZtBC9joQIkGoaTRusbQO7Mdk0ABtK3R1l9xD2EjJJK107ZGNpNiS9FvSjHZEs95wHrJnt64mjcKix1EliKnHwSblIO4XfPIA8GFTg4gTjdV4b8eFQLQraBnxzY53jdeM/0CDqnvYoHNIJADbqgMbIlGOTOZxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB7638.namprd12.prod.outlook.com (2603:10b6:208:426::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 13:32:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 13:32:32 +0000
Message-ID: <37d67935-477c-4212-ae1a-a648cf2a4021@amd.com>
Date: Thu, 23 Apr 2026 15:32:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] drm/amdgpu: Align amdgpu_gtt_mgr entries to TLB
 size on Tahiti
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 John Olender <john.olender@gmail.com>
References: <20260423011614.309180-1-timur.kristof@gmail.com>
 <20260423011614.309180-2-timur.kristof@gmail.com>
 <a3dc4b02-505a-4547-885a-ab585310e652@amd.com>
 <10056594.eNJFYEL58v@timur-hyperion>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <10056594.eNJFYEL58v@timur-hyperion>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:208:91::32) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: edffd665-fa1b-4223-bbc5-08dea13cc5c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: LfvV4MAdj0Q2zWMC6V5MHw+GR/ekb9liYqwRxlSwS9FYHpBxS8oGETLMvwEOKROfhpiSGVb9+1bs/OCWHkDu8irISAfLXY+W2Cmn9mI09yiRKRnwaV/4pH0hXax1WJlJU76vXSG0pT9oyYfvrNkz49JYStNaBrY21FHD1WpLl+S3/XQNFgyyMttylMOzQZH/nP8NzFFDHgS+OPfT7tki7AVfC3DkyNMIn3XskHIy+i5Tr4Q6WGa45UELHtbLbAtKBVuyimMsGMzzHdqDCZmLOV4zsSSw5m4pT8sIlLp3MssQm4NUPDKvWU9Ch9c0ftlh0vZAD+OonNoC9xT2xWql+kll9118tjM1bGNJUWuZBLWkB5xtCjYzjfbQ9yV9xSB6jCzyNOOSPy/kdE2cOh8/jM3iytgK58F329+nmYzLeKeYiGSHSIFnc8FLDYy7orYoE3myl4+/x4EKvJBDGWMpMfh1gxbOAEjYZH0T+YZqXy4IJhrCbKLqtWrzvdzDwLh3ZE/M36Sv2w++Gr6m7b1yzLF8RcraS5K8dB3aVkA3VG1/U2ipzszCL5FLxrskbbA2YKyAQPuQ+xaYj1esxob1mDVIQDVaE7eP6J+PNPvtKfsiH6QqxesuHE8Jyp3Q7GHtaeqHrnBr7ENALBwbrpgdi6SrEY0plqRbIDJ7qFc2qYu5MnQb1EtwjWG0Ol5fWYTMqWOdFCLVzzrJPfIul0orxEUpVQ2HxM6QRpQL8xH33JI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDFaZ0pZSFBjLzhaNzUvQmIzQUtobUY4YWNVQUkwdnhYNVhuSVdhYUJuMHl2?=
 =?utf-8?B?VFZFRnRQNjhtOVN3aHVtK3NOV1lRS25KQWxwTUxSZ3I1NG53YmpaVE5CVjR0?=
 =?utf-8?B?RWErNDlsVE1oZ3NFVVFOKzY5ZjU5dklFMHNIOXYxbnlaUWlJdkVHOURRN2pr?=
 =?utf-8?B?SUtpeDgyWHBSL1VpUXN1SzZjZW15YkFqSUhsOC9FMGNVd1MzNExxeE1rZ1F4?=
 =?utf-8?B?Q2NhLzhvSmtsYjJMc3JGMDdQRGNZeWtOV3NYeE5md0NrMFFUYXZuK3ZEL2ZZ?=
 =?utf-8?B?alU4QzlockZTUmk1UjkxRVQyUHM5WlR4MUlLRmZvRXNGTlkzdXFLY3oydGwr?=
 =?utf-8?B?OUR5NkxoTHZMYU9Zd2FONmdOWU0ycVlZeDBIRm0vMHl0RXpFRDVOL084dndq?=
 =?utf-8?B?R3BGVUsva3crRlVOUlBqTERwODZtaUYxcVEzcUpoQ1FpMG1iMngwQWlNYkV0?=
 =?utf-8?B?UmdJUjVMaEdGQW5JZG5udys4alk5MmZDbGZISGEya2owQ0MrdVplb3o1N3dj?=
 =?utf-8?B?ZHlMclVDZnFiSWFYcEJXR1daQzZNZEFhSVVEN1pWR0pFNUwyeVlRQlNtQWx0?=
 =?utf-8?B?TDQvak56TW8vM0lYcVNmQzU4WUZzai9mNFhsOTVjTEJBK1hiZXIwbnlLVHdw?=
 =?utf-8?B?cTBUaWwwY0E2TCtNaEhHUTd4c3BzQXh3L29WVHJIWVNRNlFzdzdNOFFkaUd1?=
 =?utf-8?B?dmYyVC83cTFvNHVmWUprL3J5OW5DRnZGaklRQnp2NVBmQ0tRMC9SQ0pFcmZt?=
 =?utf-8?B?U2tJN3pTR24xTDlkeGpCRzNDQXJVZjdXSmtKTndGakRLblV3UXZLVTVMa0o4?=
 =?utf-8?B?MzNaUGg5cFVheEEvQzUyQmF5SXhPYjVkdG41WERoZUhyMERFN1VUb2UrbWZp?=
 =?utf-8?B?aS9oSCs1MlN3SlRhL3U4QVBIVmNrY09kaTl6QllWUktOWUo3aGN3M0ZHdHRZ?=
 =?utf-8?B?TzZlZlBhK282aGd5T08yNUNpZkVjKzJtSGVpdXlYaDNPN2lGc01iOHp2V2JR?=
 =?utf-8?B?VE12UVY2TWtaOFNLTk54amJLcXRISjcvOUNKajRQYW1sZ1lqQXl3ZTFxem9V?=
 =?utf-8?B?bHNGQWZDUWFLRW16N3llT0RRbEI1L0FPNXVaSnJhd3ZndHJieUlEMkE2RjZE?=
 =?utf-8?B?N0p5aEtXVFpzOFRxa0NxWjBTVHJMVFltWjNDeGpYMkFucmhkeUlhWlZlZHdt?=
 =?utf-8?B?K0g4dURxMzBSaXVhWnlBY2pmVVUwbUJIVVdQeXJUaXhlNDM5ekFEb3JUTVdk?=
 =?utf-8?B?V0JZR3V5VEJVQTl2U3BGc1paZFNJak96eFVrVFdtK2JBbVNkeU9CL04rRWdZ?=
 =?utf-8?B?V1dsYXU5WjNmTXgyTk56RzF5TUN0akJWMnZjdGsrdHFBYnA3QTJhWGgxTUdk?=
 =?utf-8?B?aXFJTEU4RUJ6aHJPdFFLeC8rSjNucWNmRGNXMHpKbzRPSkpVa0twTHdnckVk?=
 =?utf-8?B?UGtES0gwbzVJcjBEQ2tnQ044UE50V1BQdWZGZVVaY0I5MExKeCtCVlhXeFlH?=
 =?utf-8?B?RllJQzA3dEdhbkRVQ0VFSFpkcUJEUk9rOU0vcHR6bTZZZGFsbU9QTm9DdWVI?=
 =?utf-8?B?T3FySW44S0JPK0JlY0JWOVg5dTVUaVU1MVJibGlNY2s5c01pd1dmNm5ucVlE?=
 =?utf-8?B?bk9RbmJSMG5XOFBIUUdlRFpqMEZLZVpLemttZm9QZ21NVCtMM2M0MkYycGVH?=
 =?utf-8?B?bzBlV3F1ako5M1p3NjVBd2FjQ0FNcVpVWjRaR2g2bGFBSmNYT0loeHZvaVl2?=
 =?utf-8?B?cEs2Y1hRc2hKS2M0UWsvYnZPdFlYem5PWmFxcm1XcmVmYXVWWTEralZTMlpE?=
 =?utf-8?B?Q1Izbkg4V3Fpc2xtVW9NMHVvL1dvSU9GdTMvaXZXSkpMZUY2QkdlZmg4M3JP?=
 =?utf-8?B?cHc0TDZUakJtWHBpQndFQUlrenNFZ1BXVS9VSEU2WVExM2tOcEtEOW8xckFV?=
 =?utf-8?B?d28wRVhNMGp0dkJOVE9yVHhyUU8yZjA1QzdxaTQ2WFRDcGhQUzdjaFlkNlMw?=
 =?utf-8?B?K1QvVSt2ZFlmd0plV0VCTXZDcE5KeHVmQWs4WDNMZXpzWFBrQnBMck8ySTBz?=
 =?utf-8?B?UGdKMTZERy9RR2h2VFNkR0M5ZWJWcjJQdVdZUVNXb3k2aVhkTnlhUE9jWE5X?=
 =?utf-8?B?OG9PSitBdTZJa0ZXbjdmdldnYkFEYS9lM2lVRGhBbWxJTEQ5VnJIQnR5Yi9N?=
 =?utf-8?B?MU9oRWd1M29sRGhSVitOejZOSzZ2OUhKVDhJaTI5UmJBWGd4OEhxa3RLTjdB?=
 =?utf-8?B?Nk9QUm5BY3Q5djd5Q0pqTW5SdWVmZmRQaENhS21LVDJqRXU2VU81OURJWm45?=
 =?utf-8?Q?IePkCmmzSXxEXn+3AM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edffd665-fa1b-4223-bbc5-08dea13cc5c8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 13:32:32.6746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQLegV+iCZUsOHq5+m4q8e4C+F1P2DgEe5I6OZL7EA7ZKY7DN1v3pfAGLjBIK9tT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7638
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

On 4/23/26 14:18, Timur Kristóf wrote:
> On Thursday, April 23, 2026 1:04:53 PM Central European Summer Time Christian 
> König wrote:
>> On 4/23/26 03:16, Timur Kristóf wrote:
>>> The TLB is organized in groups of 8 entries, each one is 4K.
>>> On Tahiti, the HW requires these GART entries to be 32K-aligned.
>>>
>>> This fixes a VCE 1 firmware validation failure that can happen
>>> after suspend/resume since we use amdgpu_gtt_mgr for VCE 1.
>>>
>>> Fixes: 698fa62f56aa ("drm/amdgpu: Add helper to alloc GART entries")
>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>> ---
>>>
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c index
>>> 9b0bcf6aca445..673e9e08c66a0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>>> @@ -198,12 +198,19 @@ int amdgpu_gtt_mgr_alloc_entries(struct
>>> amdgpu_gtt_mgr *mgr,> 
>>>  				 u64 num_pages,
>>>  				 enum drm_mm_insert_mode mode)
>>>  
>>>  {
>>>
>>> +	u32 alignment = 0;
>>>
>>>  	struct amdgpu_device *adev = container_of(mgr, typeof(*adev),
>>>  	mman.gtt_mgr); int r;
>>
>> Only a nit, but reverse xmas tree order please for variable declarations.
> 
> I haven't found this in the Linux coding style guide, can you elaborate what 
> you are referring to exactly?

It's not general coding style rule, but some subsystem maintainers usually suggest to have longer lines with constant initializers (e.g. like adev in this example) first. Then variables with longer names like "alignment" and finally temporary variables like "i", "r", etc...

I think it keeps code a bit more readable sometimes.

Regards,
Christian.

> 
>>
>>> +	/* Align to TLB size on Tahiti */
>>
>> Oh that needs improvement.
>>
>> Maybe something like /* Align to TLB L2 cache entry size to work around V
>> bit HW bug */
>>
>> Mostly nobody will know what that "V bit HW bug" is, but at least AMD people
>> can search for that in the HW docs.
> 
> Sounds good, will add those details to the comments (and commit message)
> in the next version of the series.
> 
>>
>> With that fixed Reviewed-by: Christian König <christian.koenig@amd.com>.
>>
>> Thanks,
>> Christian.
> 
> Thanks!
> 
>>
>>> +	if (adev->asic_type == CHIP_TAHITI) {
>>> +		alignment = 32 * 1024 / AMDGPU_GPU_PAGE_SIZE;
>>> +		num_pages = ALIGN(num_pages, alignment);
>>> +	}
>>> +
>>>
>>>  	spin_lock(&mgr->lock);
>>>  	r = drm_mm_insert_node_in_range(&mgr->mm, mm_node, num_pages,
>>>
>>> -					0, 
> GART_ENTRY_WITHOUT_BO_COLOR, 0,
>>> +					alignment, 
> GART_ENTRY_WITHOUT_BO_COLOR, 0,
>>>
>>>  					adev->gmc.gart_size >> 
> PAGE_SHIFT,
>>>  					mode);
>>>  	
>>>  	spin_unlock(&mgr->lock);
> 
> 
> 
> 

