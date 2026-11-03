Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041F9606A326
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 22:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5MKiA0xd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C32D10E156;
	Tue,  3 Nov 2026 22:53:16 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF33A10E156
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 22:53:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtJu2UpXyqjxIGWJzGSphOXlJrGQgDp9RIUf3X+FjviYEyIjHFfHjRFZrCa+1COfXu6TSqUM0M+ovVvWQ550jxId4CxxMshH2drDUhLBzxXEuk4vGVolQlX5JyYO+U/nuI7zDn/ZjqeZfp042QvRmifQgAIZ7x5U6seqrKvsA7Xc1hhMXaKIRkjCJLUKVibaK4nICNSW/ESWrFz97mmJqdfOCeajtHLQZy1RYolkO/5Dv5qmXTlKRkZTrastEQHu6PyMHoCKgNHUezUtW7lrIat08CmlBoCR+N10bLBUEWSUR47pB65SV18xcVdKN542az8zrhgX3EDNmBdRoA/WJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fs1GUtT169jsdprvHdAoxrPJAumCEaw/7HV/IQKa12g=;
 b=tJJjvbQocZ2w/BHf2vTRSbvm0EvKtHLc4GqbuiFX1xyNKqs/RcTdcJRgN6nkELCNJ7HPi5EPWmfVIU2kPLzRa4MgBFAooj3Q7NwbvLZF1R+STdMDg46vjGjKOp8RtiFghItZpIDVPO/Rs8XD4z0m765fie/VpjyScOri4AgH4H7KwV6SHQRHiGwMgyzfQwD7FOHQGb/v4XR9kjlBCZdKkEcW8HYejh+lhp0+y+drMqHj/NQHm+QgSO5kXSYD8U+GzbaHS8e+XMSKHji+xY1OXpg2R0ynrD2jpEMC2mI7QOvG7S6+KxymOZ5C9xMS3SO0Mn/urv6HtYgEkzoZlldfqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fs1GUtT169jsdprvHdAoxrPJAumCEaw/7HV/IQKa12g=;
 b=5MKiA0xdnIjwd16IqJp9ZyL9R0fYWk0HVWz8f3CiDO4pTue9935rQq4jQzVON/UBWrRgJmUs9mV2IODgFA3+myz6uT2yV9Rwzti1k8OwbfRxsOwSWorP5gmiXjjes1QF8AlMYVU0SBRrErRIjFHjBc1gXvCDBnJAGg58n0wX8ZY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by SJ0PR12MB5611.namprd12.prod.outlook.com
 (2603:10b6:a03:426::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 22:51:02 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 22:51:01 +0000
Message-ID: <a153ce69-60df-4da4-9535-0ec06f89ecb6@amd.com>
Date: Tue, 3 Nov 2026 17:51:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 2/8] drm/amdgpu: Support VMID 0 GPUVA completion WB
 address for UALink
To: Philip Yang <yangp@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261102160125.2743750-1-mukul.joshi@amd.com>
 <20261102160125.2743750-3-mukul.joshi@amd.com>
 <125be237-9e6c-4690-9151-dbb535249f93@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <125be237-9e6c-4690-9151-dbb535249f93@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::16) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|SJ0PR12MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 57f14c87-f7a8-48fc-0788-08df39fcef1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|3023799007|10067099003|18002099003|6133799003|22082099003|261102123227099003|56012099006|261022105027099003|4143699003|11063799006|5023799004|261028144727099003|261021121427099003|261021123027099003|261026121527099003|261009223027099003|261026140227099003|261102130727099003;
X-Microsoft-Antispam-Message-Info: cij+YDw/xojPaY7b7B1iJebOWabnRGctJs9rVASjBs9mUEFIbRg3y3ZZsBE+B8mlHfd7VvpjxxMZqzhXCePpg5CXpyazzc2b4T8blan4SPzEE9ckfsBhWH9pf0q0l1vS0eWHv+27OOXuPVxCwAWjR+RtRUKahuDzOelKOHlPXo9VCSrTAjpsB4UbJpFOZqDTb2k3LOLTW2Vkeq/uV3/yb7JLvmEYrYf28jrBqKyPZKmqzgg6NlsyTJZfb7Pa8/2ofBUY/UIS8Iv7U5/pLwNfpWbJyrpabtNJ415zkIlfuAuRczmp1TQ8RBbkro2SsJaaqsmBpC/icy5VzeBkeZ8U1LNjFKGgkcy+avUmUbw5DIDvJhB9NrthPGL641HuzwA/KVmIjeNMx9tEVRljVmZPTyyq4E+ACVWxVeW84/Q60FdgtdpWhjqWl5izVd0OZ7XCJiSUzbWJC+F8hfa666NXgUGBAEZNrb8jy2jThdXDf6hfKeb2uvPJKSsTIk3v1XQUPL+CkmHet+0kWGnE4akFWucs5LdRQmVqWibBlZbvPNJIoXd06+/0t6eHUQ2EOM9iHQfw74e+HRvFU3Ibz65T1gHCly+3IyoSb7l1eCVg+0QaRrFACu0qZAif/zzFZrfTHeXdx4ZXI8gyp1xPjmyoVElgE5myXHKXNiCndlVCxG4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(3023799007)(10067099003)(18002099003)(6133799003)(22082099003)(261102123227099003)(56012099006)(261022105027099003)(4143699003)(11063799006)(5023799004)(261028144727099003)(261021121427099003)(261021123027099003)(261026121527099003)(261009223027099003)(261026140227099003)(261102130727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0REZWhjYmVXaHBRaGs2ZkU3V2I5ajBwbmZBYXhHRFpiV3FadGFPQ0Y5SHFD?=
 =?utf-8?B?VkVOaVpOL1ZTQTNMNzhpVDJBeWxlc2t6QmdSTDhZU1AwZDcrNlk4cE9mL3Rq?=
 =?utf-8?B?RFdzbDNzL0RkeXlSZktNTFgrZ3Bna0JBTm5qOGU2RVQxdWk1ckpNK2NscnN3?=
 =?utf-8?B?Q0ZsR05hSkcxL2tRY2JpQmNCZ2pUbmdNL1NqejlCelQ0cDlsMnk3TnI0UFNZ?=
 =?utf-8?B?aXM5N1BFR1hBcVVFY3NhQWhKcGNuMWRHVlZKT2ppeHdpeHpKT04xTDZkRHll?=
 =?utf-8?B?dGpDUmtMWVZJc3F3bEJKblZvNnd6YkRBbzlPNnVDZW1yRjJCc1JiZnQ5VzFR?=
 =?utf-8?B?YmwzRDdyS3lvamtjOEM3VXdHMDFRWVppQWNEZWFscHRpTWZSZUI4STBiZDAv?=
 =?utf-8?B?RCtjYUhIQWVCREtneDZpMG1YR1VITjJKdFYvYlZkWFRCRDREREFKNld2VTN4?=
 =?utf-8?B?WHBpUk9FVnNqVXR3Q29uL1FaY1R5dnliN21LY0xRQ3IwZjJxSmM4RkFsTmJM?=
 =?utf-8?B?dUZVYncrYkI2QXE3a1QvKytQMDZjSUZKdnJONkRyeWJ1aVEyekVhck85ZzlP?=
 =?utf-8?B?UVFpYmxlYlhtMU9HdU1QdUgwa2gxNHJOMm5yRS90NWxkSm8zOG4razFHdk1Z?=
 =?utf-8?B?bzVpYkpKS1dnTW84UHpMSjNoQ3h3QTRESE1Lay85NXJISHpYdXEyVjVoaXpN?=
 =?utf-8?B?WXM3UzBFTFZCMUFVNDBYOTIvRWlWYkI5cXhYazlIUW41bG9QZXBWUndZQnQ0?=
 =?utf-8?B?bEZRT21oN0tRbzV3TTllcnh4QS9WdGU4Wk9HM0V3eUE2aDlrMzZ3SG9JR0JG?=
 =?utf-8?B?VmVYQjdUaWpWaXlWRmJ2SnBYblpNWFV5eW9RVWxkRVd4RHBNeEpRaFIzN1cv?=
 =?utf-8?B?dEluelNSODhuOE5zb3gvODZWb1VpSGdSQkNFSlYxcXVDb3VjOFlDNGI1REto?=
 =?utf-8?B?UkJ5UlFXeUdJendHYkhrNnJWZzd3M1l6bXlKVnNLYTVZTHpjY09yMklTL01h?=
 =?utf-8?B?WGdHbTNIZXM1R0k4SGlBcFRKQnJoVEY0azZIVlkzU0VuUVJXVE8zQmRoM0ta?=
 =?utf-8?B?UjZTbW9lTG4zMmhXd09hVHBVMzRMNVovazFycTBGVG9KS0FFaHZvNVEvWC95?=
 =?utf-8?B?bzVhaVV2Z2tuVmpsOXZ2eTJQVFR1YkNSUTl0eU9qeElvendNc3lkZmNsQ3JR?=
 =?utf-8?B?TFMzbmsxZ0gvcmxNT2FTbHI1T3FOS1pCOE1pd1V0RFBDTkh2QitWWW1UK3NM?=
 =?utf-8?B?L1lGTzd0T2k3dDNXRVhTNTB0TDZwcEVJaXRubDdYK1lwdTdsdjVkaEdwN0xC?=
 =?utf-8?B?MVZkdnBtSGJwb1pVQlZldnQwUkRVZVI5MW5lSTZubE42c2Z4ZGxsWVBlTkRB?=
 =?utf-8?B?ZEhVSkNaMkhwaUt6RG9YOFp0bmUwUCswT1o1UlBKMGFyZDlqQWlvNFZETkll?=
 =?utf-8?B?WW0yTUxoSFRuMk1rT1IrZUNMbzhlUFhpSk1VM0Q3NzNlY2t0SkhTQzhDckdK?=
 =?utf-8?B?Y1Jua3Bmbk5EVHo2TDR1S3ZHTWNGK2hIUmsxYnBBd2MrYXBiNWZBdHFGUHFN?=
 =?utf-8?B?WWNMVkU4SW5qWWlXK1NBYklWZU5kM2NtQnU2VG5iTWRDZTlCQ0FpV1JyTjZt?=
 =?utf-8?B?OGVpMklaT0tzN3F0QVZsdTFmQUYwVmxyTVpXcDl2cnNETTh3ZUtnalAvcHNx?=
 =?utf-8?B?RUdUR3J1QTRLMGVOYXd4akhyYlluczFRSnNYZ3dHZzF5KzMxRHljbTg2R0Jq?=
 =?utf-8?B?aS9oUlU1SjVvUWZsbzJnSGhIUFlhUGhHNkk2VlhPMmF6T3dNOFNBWVg4Uk55?=
 =?utf-8?B?eDNxSDJtOFBkNHZXQjNqckRvMjNFdmF6eS9UZUJCenpzWEhEaTFualZqOU5k?=
 =?utf-8?B?dWRaZVk4TWNDL0tDYUVqRTJyekFqSUNGL3graGtlMjQyaW5wYjlHQTUxSEc1?=
 =?utf-8?B?ZlgzcXlPa29yTDRvaERFdklWMkpFRzB5S2VnNWE1a080cXZVLzVGNEV0QnRS?=
 =?utf-8?B?Y2RTMlFId2l6Y3ZHYmQ1aTFVMWRMd0t2NlpHM3lxQU1yWStsemFmTEVxamo0?=
 =?utf-8?B?MXh4ZERoRXkyUCtpazBRdjYrT2w0czdYWm12MkxUczZuLzVJNFpQY0s1QS9a?=
 =?utf-8?B?b0R0S1JKR2ZSNFBDM0ZKbnVTbkxZd2xHVWZLYXpGeVM3WWhqdlJlektKMUxi?=
 =?utf-8?B?Wjhva3R3MWt2ZmlNaFdGZEpDUTJ6S3l4WUpmL2N4ajZvcE1wVk5oNk9jeDY4?=
 =?utf-8?B?MXJkSmFudi80enVJYjBVMzJnbnNWc0MwNlppTERmVnpsZGZmb1hlbXcxb3M0?=
 =?utf-8?B?c3A0dmtnY05pUWZZMGpKR0NoWkxwU29LUStocHpwQlFSdDFsY3dlQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f14c87-f7a8-48fc-0788-08df39fcef1f
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 22:51:01.8206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXwQwTSd5+T9RaJg/XdvrxxoCKByzqk/ZFxVpHisg6psJ2o4kQvYnpy346XF5Cpa6QNo19jdIm4mSlsbceIfYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 2026-11-03 17:07, Philip Yang wrote:
>
>
> On 2026-11-02 10:47, Mukul Joshi wrote:
>> The UPDATE_WB_ADDR remote command hands the MP nHT FW the address it
>> writes command completions back to. So far that has always been an NPA.
>>
>> The FW can also take a VMID 0 GPUVA, selected by setting DW4 of the
>> command to 1. Return the VMID 0 GPUVA of the writeback slot from
>> amdgpu_ualink_get_wb_addr() alongside the NPA, and use it in
>> UALink loopback mode. There the HW only carries importer -> exporter
>> traffic, so the FW cannot write the completion back over NPA.
>>
>> Outside loopback the NPA is still used and DW4 stays 0.
>>
>> Signed-off-by: Mukul Joshi<mukul.joshi@amd.com>
>> Reviewed-by: Felix Kuehling<felix.kuehling@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 48 +++++++++++++++-------
>>   1 file changed, 34 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> index a98d5bbf0622..29a787979af2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> @@ -5652,9 +5652,9 @@ static void amdgpu_ualink_emit_update_wb_addr(u32 **cpu_addr_p, u32 wb_data,
>>   
>>   	*cpu_addr++ = cmd;
>>   	*cpu_addr++ = wb_data;
>> -	*cpu_addr++ = dw1 & 0xFFFFFFFC;	/* lower32 wb_npa */
>> -	*cpu_addr++ = dw0 & 0xFFFFF;	/* upper32 wb_npa */
>> -	*cpu_addr++ = 0;
>> +	*cpu_addr++ = dw1 & 0xFFFFFFFC;	/* lower32 wb address */
>> +	*cpu_addr++ = dw0 & 0xFFFFF;	/* upper32 wb address */
>> +	*cpu_addr++ = dw2;		/* 1: wb address is VMID 0 GPUVA, 0: NPA */
> dw0 and dw1 shouldn't have changed — I don't see any difference. Am I 
> missing something?

The comment changed. The address may now be an NPA address or a VMID 
GPUVA. Thus the comment shouldn't say that it's an NPA.


>>   	*cpu_addr++ = 0;
>>   	*cpu_addr++ = 0; /* metadata */
>>   	*cpu_addr++ = 0; /* metadata */
>> @@ -5868,7 +5868,7 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
>>   static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
>>   				      u32 remote_accel_id,
>>   				      struct amdgpu_ualink_wb **wb_cpu,
>> -				      u64 *wb_npa, u32 type)
>> +				      u64 *wb_npa, u64 *wb_gpu, u32 type)
>>   {
> Since wb_npa and wb_gpu are mutually exclusive, this function returns 
> one or the other, never both. I'd prefer to keep the interface as is 
> and check whether loopback is enabled inside it, returning the 
> corresponding wb address.
>>   	struct amdgpu_ualink_remote *remote = to_remote(adev);
>>   	/* The GPUID encoded in the write-back NPA address is the routing target
>> @@ -5881,15 +5881,17 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
>>   	u32 accel_id = ualink_exp_accel_id(adev);
>>   	u32 rb_size = AMDGPU_GPU_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);
>>   	uintptr_t wb;
>> -	u64 npa;
>> +	u64 gpu, npa;
>>   	u32 offset = 0;
>>   
>>   	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT) {
>>   		wb = (uintptr_t)remote->rb_cpu_addr + rb_size * remote->num_accel;
>> +		gpu = remote->rb_gpu_addr + rb_size * remote->num_accel;
>>   		npa = amdgpu_ualink_npa_addr(adev, RB_TYPE_TAILPTR,
>>   					     remote_accel_id, accel_id);
>>   	} else {
>>   		wb = (uintptr_t)remote->rptr_cpu_addr;
>> +		gpu = remote->rptr_gpu_addr;
>>   		npa = remote->rptr_npa;
>>   		npa |= (u64)accel_id << AMDGPU_UALINK_GART_NPA_ADDR_GPUID_SHIFT;
>>   	}
>> @@ -5902,9 +5904,11 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
>>   	*wb_cpu = (struct amdgpu_ualink_wb *)(wb + offset);
>>   	if (wb_npa)
>>   		*wb_npa = npa + offset;
> *wb_npa = adev->ualink.loopback.enabled ? gpu : npa + offset;
>> +	if (wb_gpu)
>> +		*wb_gpu = gpu + offset;
>>   
>> -	dev_dbg(adev->dev, "source %d remote %d wb npa 0x%llx\n", accel_id,
>> -		remote_accel_id, npa + offset);
>> +	dev_dbg(adev->dev, "source %d remote %d wb npa 0x%llx gpu 0x%llx\n", accel_id,
>> +		remote_accel_id, npa + offset, gpu + offset);
>>   }
>>   
>>   struct amdgpu_ualink_wptr_fence_cb {
>> @@ -6068,9 +6072,9 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>>   		ualink_exp_accel_id(adev), peer->interrupt.wptr, peer->shootdown.wptr,
>>   		remote_accel_id, int_wptr, tlb_wptr);
>>   
>> -	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &int_wb, NULL,
>> +	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &int_wb, NULL, NULL,
>>   				  RB_TYPE_REMOTE_INTERRUPT);
>> -	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &tlb_wb, NULL,
>> +	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &tlb_wb, NULL, NULL,
>>   				  RB_TYPE_TLB_INV);
>>   
>>   	peer->interrupt.wptr = int_wptr;
>> @@ -6104,7 +6108,8 @@ static int amdgpu_ualink_update_wb_address(struct amdgpu_device *adev,
>>   	struct amdgpu_ualink_peer *peer;
>>   	struct amdgpu_ualink_ring *ring;
>>   	struct amdgpu_ualink_wb *wb_cpu;
>> -	u64 wb_npa;
>> +	u64 wb_npa, wb_gpu, wb_addr;
>> +	u32 wb_vmid0;
>>   	int r;
>>   
>>   	peer = &remote->peer[remote_accel_id];
>> @@ -6116,13 +6121,28 @@ static int amdgpu_ualink_update_wb_address(struct amdgpu_device *adev,
>>   		return -EINVAL;
>>   
>>   	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &wb_cpu, &wb_npa,
>> -				  ring_type);
>> +				  &wb_gpu, ring_type);
>> +
>> +	/* UALink loopback: HW only carries importer -> exporter traffic, so the
>> +	 * MPNHT FW cannot write the completion back over NPA. Hand it the VMID 0
>> +	 * GPUVA of the writeback instead and flag it in DW4 of the command.
>> +	 */
>> +	if (adev->ualink.loopback.enabled) {
>> +		wb_addr = wb_gpu;
>> +		wb_vmid0 = 1;
>> +	} else {
>> +		wb_addr = wb_npa;
>> +		wb_vmid0 = 0;
>> +	}
>> +
> then wb_vmid0, wb_gpu and wb_addr aren't needed here.

We still need to tell MP nHT what type of address we are providing. I 
guess you could just replace wb_vmid0 below with 
adev->ualink.loopback.enabled. But that makes the code harder to read 
and maintain because you have conditions or assumptions about the 
address type in both amdgpu_ualink_update_wb_address and 
amdgpu_ualink_get_wb_addr. If they get out of sync, things break. I 
prefer the explicit version that Mukul wrote, where 
amdgpu_ualink_get_wb_addr returns both addresses, and the choice of 
which one to use is made in only one place.

Regards,
   Felix


>
>> +	dev_dbg(adev->dev, "remote %u ring type %u wb %s 0x%llx\n",
>> +		remote_accel_id, ring_type, wb_vmid0 ? "gpuva" : "npa", wb_addr);
>>   
>>   	r = amdgpu_ualink_send_command(adev, remote_accel_id, ring, wb_cpu,
>>   				       amdgpu_ualink_emit_update_wb_addr,
>> -				       upper_32_bits(wb_npa),
>> -				       lower_32_bits(wb_npa),
>> -				       0, 0);
>> +				       upper_32_bits(wb_addr),
>> +				       lower_32_bits(wb_addr),
>> +				       wb_vmid0, 0);
>
>                       adev->ualink.loopback.enabled, 0);
>
> Regards,
> Philip
>>   	if (!r) {
>>   		ring->wb_cpu = wb_cpu;
>>   		ring->ready = true;
>
