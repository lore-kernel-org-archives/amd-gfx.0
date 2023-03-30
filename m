Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F5BC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 14:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D958710EE96;
	Thu, 30 Mar 2023 14:49:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22DC010EE96
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:49:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJX5YdHUxhmBCN4qdL3rcYZ2IiEAE4J/ElXWR1AjPcSbXfkOUGmvIPh8rKmc3kfY9XM++TK4O9znH/FYo/1zM1ToNBngXhE7aSCAqWMQCtzp5yljOKVOav+LWlbOys7SCt2QCC1nv6WdNmMtH9KC3eyekcuZk+O62rPHWXiy2DFDk2P+yaAkOa6Tcpr/r9poakprWD/wFyCZjvdKaH/xV+AUzf7+bK7uphdssxjIX65FDGSYSaRzRvFOgarv4D+19BFroXs8UKe1FI49JwDQCcqwStsMfefmExRrSICGD1H1Jd0rYMagpdv2k1r8UEjGW5QFDEwuOsGFqm7eOFiwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLzcTUr9VnzdL/2G17SQmiF7RXDFCo3XbsGxLggPgSE=;
 b=bazssVCAPNY8+zpntYcAA9gJ5fA2E9OP8NYRQULwgRJENxJO4VBRsnBCI3f4bdfR8eIiAYGgMnjxevuhtzeSvKM0M46HtGY4cgZ8lpUa0O9GLz1+HdpHMZYXIhjPwnenT2qQ1Mo+NKqPUjcdfwKdc5YS9iaOiU0TEoC+vwzsCl0jGQQf/VAHIDxrO8ehPiFvJtVmPb/E5gYWbIRveimHyHI0gWnEViCtwS3kDJpiD41+oFfWq1yXBSBuJrOQ9AQLJpFYe870bZSkUJq27GeeQL340SdqeayAssq0F4joYtzmRyNmoG7/KoQbmY1rJQ/kvhgt5EWq9P/ebADjt+6crg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLzcTUr9VnzdL/2G17SQmiF7RXDFCo3XbsGxLggPgSE=;
 b=aQ9yquUalNcPYp6hSt3WckX37Ew/VkvyCkptVb3cYg6JJhc+mlCRmrcTfUpQdpjQ/IPz7nmqoPwQlgNXOQGvjCE7uDfustnSC9o/4pm6pfZkByngVkbYeXP7gqIGh7aD0kOkM/cHqg0ljHG17m7iRDBAOUJoJnjLCLyjKRWr2os=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 SN7PR12MB7811.namprd12.prod.outlook.com (2603:10b6:806:34f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20; Thu, 30 Mar
 2023 14:49:10 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 14:49:09 +0000
Message-ID: <5a83afd6-9e7f-5c1d-0b9a-77f49b213bd3@amd.com>
Date: Thu, 30 Mar 2023 10:49:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-11-shashank.sharma@amd.com>
 <de6368af-b16b-0794-6eda-465d5046c142@amd.com>
 <fabf0ef4-f668-43d1-78d6-e5baac3ab098@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH 10/16] drm/amdgpu: validate doorbell read/write
In-Reply-To: <fabf0ef4-f668-43d1-78d6-e5baac3ab098@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1P288CA0035.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::48)
 To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|SN7PR12MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fed0d8d-9a1c-4e6d-9533-08db312deb2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UsX0tn2oX9b1tQBwWy2OPYGKkrPJwxnWHQkxrDcRUZXJT/boDOWyy8e0L0tCENNMSVDL4ftaTcd9FtBdOX9q4I9vA1hnHXi5X8+69Fr1OzfgPgLSKnQAV2Trqfe0aQo1OgsdjqToTJI4ntN2tVcTApAdVzDCJ0ncz7vChC6S8DDedctTfZHR7PSldw3v0yTmCSQ1ApraGF3rYnmBPcgz1E11qhbSKZF8uBJU3bR7zZ2+gttVcT++i+gfbqqqclexn6fwKiICnjyFBrkiUHmrCbUy59VrQFMe2/zEGjs5kFuxN/DPJWnsQcFCCQwJzt+/CymbZw2BznTZUqNo6GOPUSEGFA/LUQr/uxtFm5OubQOyrhgma21EVuGOVfiDM6GvG11qRLSuuJU4U868Vce8kTrXzrNPPPmKtAnv2irAHW4EVEhxmRzVR6KvAdOfFvXTyypd/OiobGsuusUL8yIHmV4J9u1BxEGcAvyTj1e8MC93l+T6EjPjXOBVTmZkYwTl3dyGxEhNoYBjlpuZY+XbhA72vBqUzfTaREqgLrC9cRk5opI7f5iigXhUZVh8U4HIQEKs+OMeM8rxzxm4u5V5lPalcvQsU7dnZhFb4TreGVe06EWEqvwKQzyTJlK2/MYYtSMDuq22rTTzVuadyRzJJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(451199021)(54906003)(4326008)(8676002)(66946007)(66556008)(316002)(66476007)(41300700001)(6512007)(26005)(186003)(6506007)(53546011)(83380400001)(2616005)(31686004)(6666004)(6486002)(478600001)(31696002)(86362001)(36756003)(44832011)(38100700002)(5660300002)(2906002)(15650500001)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wjk4a1hSZUlta3Uzc0I1NTZ1Tk1rZnFvVkRBc3FIbEFkaDBvUE41dWVDWlNN?=
 =?utf-8?B?U050Sm9tOG5XTGlMUVM3SW9ERXVxdDRXck44ODBub0F3ZTdNa2lGMGg1K2RE?=
 =?utf-8?B?ZWVxV3lpSkl6OGZkUitrY0g3NVQ4bExHN2dwOCtPcDZKZVRnSnZoaER0RHV0?=
 =?utf-8?B?anc3elB6MldxZXdBcTFhSEJSSXhIT1lLQXEyUE9aelM2ZEhCSXhrV01YcTVq?=
 =?utf-8?B?aHVmUzI5ZFZpVDlBTFpvL1RveVZyR1FZOWdCVk5NVVhGbW5XcjF2Zzk2aWZ5?=
 =?utf-8?B?bjNheVFHZnMva3hoUHQyNUova3haQ1ROVllvZkNNVDBaRjFxM094c01qRlRD?=
 =?utf-8?B?Z1ppT2FWdll1SDhGdWdrVU5EQjNNVzE3WHRhVVBUdXR1UFo3b1N1blNvVDlv?=
 =?utf-8?B?cGRCakhuRXBhTEJJenZncHRkdnhWb2pvNERmN3UyK2cyVTh3U09BeEdWUEgw?=
 =?utf-8?B?WCt6MDFEWmFxQXlsd1JtczhFeHlZcCtVcWlJQkgvNWM2NUJ1Z0Zid1crRHFO?=
 =?utf-8?B?ODRBM2NxdWdJNXZndStLTFpCSXhvQzJaTzNXNWcrTHR3aGFSb3hCcllNQnlZ?=
 =?utf-8?B?cHduYWJhNkdLcTVTWjZobUdDdzlxQkxXL2ZIblZtRHY3Z2Faci9YUXJGcUFL?=
 =?utf-8?B?MUkxNUk4c2kvMDY4ZzkwNTRLWVFoTUwyRVpOS3pjZEFPZHpLdXhsdGZmeVdl?=
 =?utf-8?B?bDEvUi9GUnlVcWdzUVFNVUxwUnhDa2Y4UG5ROEQvMmhVaVpmcjNFdjRoY2t5?=
 =?utf-8?B?Q2srN0hKOXE4Q1VVa0xMOU9PSk0vRm9Kck5CbkQvelVIQk14enljdlRPOTM3?=
 =?utf-8?B?WWxVeDFxVFE3V29rL3pNY09vNkJvWVBud1lSektzd2UwZ3RHOEVwdzlIRitx?=
 =?utf-8?B?WWkvakNpUlZjRU9Fb2VZUUJhR3pRRTcvY2U5bysrSHRVV3dQeWYwZENEeFY3?=
 =?utf-8?B?NWVjdGlYVzNJVjNiemFWZDFhWWlXbXlJZWZoeEdlUjIzWU5FRGxQb0FKL25v?=
 =?utf-8?B?amxDVGIzajcxMEdwejZzUVQwRlZSZEp1V05hUWdPMDJGTUV3N3EzY2UzWGhZ?=
 =?utf-8?B?M1R3enJIYXdkcytXOUdnRjZia1JFS29kTGx4Q0lHK291cEU3Y1gzSUJPQkwx?=
 =?utf-8?B?WTZjRHZIM2swWWhmcVpXTVpxNDhKNkhySStGQzlnT3p1YzQrWnNjcEJJdFNT?=
 =?utf-8?B?L25RRU9DRzF2blJLQmhYckw5Tnd4Nkt6Z3BrOXlyVTllVHBDVWt3Nis4dWcw?=
 =?utf-8?B?RTVBSTZuZGs3c0I2T0Z5bFlYdVFvR3BWZUpKdHVNT0h2ZFpKVzZaS3JWZ28r?=
 =?utf-8?B?QUx1cjJvMFYvRXEyRitCZVRCQlRUTXVMbFFuaVphWEVQK0tldmR1QjRWekdX?=
 =?utf-8?B?MUNUck0zdGdmYjU1U2x5dzJzT2tZYmthUHBxUVlRRm9YM2wzSU8rbUp6NWp2?=
 =?utf-8?B?dzhabmNsakhySzJ5QTFYWVNBS0J2a1c5SXNPNlkwblVkNHNTWWFBZUQwS0lq?=
 =?utf-8?B?NE5QdXZhOVI3eUZHVEhabzVodmRzWGpETXpVVmtvSSs5ZnhQZEpYN0cwUHdu?=
 =?utf-8?B?a3FhVzdvZnZqU3JMVDRaRVZUTldSVTlLa05JQmZ3b3NHY3FDYytOZ0k2Yzg3?=
 =?utf-8?B?bXhMTTZPUllnam84ZTRET0h6V1ZmVEtrUlZJUTVKQk9CQ0xSaG1yZEo1dGxn?=
 =?utf-8?B?UGlMWFdUN0JLbGk5VngvS2dqeVUxdUR3R3NWYmhTKzRML1FVcFRXdFM4dytD?=
 =?utf-8?B?VmJQT1hzYzJ6VWpYTllsakZZalczb3plczF4VDlrU2sxTEtjTEtwT1MzaVM1?=
 =?utf-8?B?STZoUGtRdzZmOWVLTzNSWHBqcmlRNzA4eVZFMGxjVXlDcmRiZTRzRjVzekla?=
 =?utf-8?B?eVdLMjMwR3ZkTWttR2p5MUk5Zm9zNExZcWppemRYUG9ndEFFQVpJeEVkdEx1?=
 =?utf-8?B?UlJDSFkyVEx0bDdVWDlpbEdsbGtqb25kMzR6S214K3ROa2hUUzBrRzhBalZC?=
 =?utf-8?B?bUE0R2pMS2ppZ2JORDMxeUdkNTVMVk52OXJwK3l5WHZhVXFoUnBOQ3dKTXdM?=
 =?utf-8?B?dFBUMmhHMkVMY2tIQU1MdVY0Zmh2bUFPTWFyOHY1SUJIZ0kvaEVXSi9HVXZq?=
 =?utf-8?Q?fklSn0Q/nYFTMFF+DK+fnVpZD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fed0d8d-9a1c-4e6d-9533-08db312deb2f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:49:09.4071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2F7n2SE31gZ5nKRpmgSFysGpjHIWu/m2NWBhjsUhcU4noEnTltHV0HXpvPMOXnYy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7811
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 =?UTF-8?B?77+8QXJ2aW5kIFlhZGF2?= <arvind.yadav@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-03-30 10:37, Shashank Sharma wrote:
> 
> On 30/03/2023 16:34, Luben Tuikov wrote:
>> On 2023-03-29 11:47, Shashank Sharma wrote:
>>> This patch:
>>> - updates start/end values for each of the doorbell object
>>>    created.
>>> - adds a function which validates that the kernel doorbell read/write
>>>    is within this range.
>>> - uses this function during doorbell writes from kernel.
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> Signed-off-by: ￼Arvind Yadav <arvind.yadav@amd.com>
>>> ---
>>>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 29 ++++++++++++++++---
>>>   1 file changed, 25 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>> index b46fe8b1378d..81713b2c28e1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>> @@ -22,6 +22,25 @@
>>>    */
>>>   
>>>   #include "amdgpu.h"
>>> +#include "kfd_priv.h"
>>> +
>>> +static inline
>>> +bool amdgpu_doorbell_valid(struct amdgpu_device *adev, u32 index)
>>> +{
>>> +	if (index >= adev->doorbell.kernel_doorbells.start &&
>>> +	    index < adev->doorbell.kernel_doorbells.end)
>>> +		return true;
>>> +
>>> +	if (index >= adev->mes.kernel_doorbells.start &&
>>> +	    index < adev->mes.kernel_doorbells.end)
>>> +		return true;
>>> +
>>> +	if (index >= adev->kfd.dev->kernel_doorbells.start &&
>>> +	    index < adev->kfd.dev->kernel_doorbells.end)
>>> +		return true;
>>> +
>>> +	return false;
>>> +}
>> Here you're excluding "end".
>>
>> In patch 7 we see this:
>>> +	/* Last index in this object */
>>> +	uint32_t end;
>> Which implies that "end" is included, but in this patch, the code excludes it.
>> Perhaps you intended to use "index <= ...end" here?
> 
> No, this is intended, same as array object calculation.
> 
> end = start + size;
> 
> max = start + size - 1

This I understand, but "end" is NEVER "start + size" in all
code written since 1969. "end" is outside the bounds and thus
never used like that.

"start" and "end" usage comes from RTL and is always inclusive,
and "end" always fits in the same sized register as that of "start".
But if you use "size" and add, it may overflow. So, enough history.

"end" is inclusive. If this is not the case in your implementation,
then please use "size".

> 
> so (< end) not (<= end)
> 
> end says last index in this doorbell range;

This I don't understand.

This isn't how "start" and "end" are being used.
Their usage comes from RTL, and is always inclusive.

Either use "start" and "size" or make "end" be inclusive.

I'd prefer using "start" and "size" as this is traditionally
what is done in memory management in software (not RTL).

However using "end" in software makes it tricky to calculate
size, and one always does "end-start+1", and this could lead
to bugs and errors.

Please use "start" and "size", then.

Regards,
Luben


> 
> - Shashank
> 
>>
>> Since this isn't RTL, wouldn't it be better to describe the doorbell instance,
>> with a "start" and "size"? This is traditionally used in memory management,
>> and it makes comparisons and checks easy.
>>
>> Regards,
>> Luben
>>
>>
>>>   
>>>   /**
>>>    * amdgpu_mm_rdoorbell - read a doorbell dword
>>> @@ -37,7 +56,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>>>   	if (amdgpu_device_skip_hw_access(adev))
>>>   		return 0;
>>>   
>>> -	if (index < adev->doorbell.num_kernel_doorbells) {
>>> +	if (amdgpu_doorbell_valid(adev, index)) {
>>>   		return readl(adev->doorbell.ptr + index);
>>>   	} else {
>>>   		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>>> @@ -60,7 +79,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>>>   	if (amdgpu_device_skip_hw_access(adev))
>>>   		return;
>>>   
>>> -	if (index < adev->doorbell.num_kernel_doorbells) {
>>> +	if (amdgpu_doorbell_valid(adev, index)) {
>>>   		writel(v, adev->doorbell.ptr + index);
>>>   	} else {
>>>   		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>>> @@ -81,7 +100,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>>>   	if (amdgpu_device_skip_hw_access(adev))
>>>   		return 0;
>>>   
>>> -	if (index < adev->doorbell.num_kernel_doorbells) {
>>> +	if (amdgpu_doorbell_valid(adev, index)) {
>>>   		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
>>>   	} else {
>>>   		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>>> @@ -104,7 +123,7 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>>>   	if (amdgpu_device_skip_hw_access(adev))
>>>   		return;
>>>   
>>> -	if (index < adev->doorbell.num_kernel_doorbells) {
>>> +	if (amdgpu_doorbell_valid(adev, index)) {
>>>   		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
>>>   	} else {
>>>   		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>>> @@ -157,6 +176,8 @@ int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>>>   		return r;
>>>   	}
>>>   
>>> +	db_obj->start = amdgpu_doorbell_index_on_bar(adev, db_obj->bo, 0);
>>> +	db_obj->end = db_obj->start + db_obj->size / sizeof(u32);
>>>   	return 0;
>>>   }
>>>   

