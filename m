Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D68C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 04:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4710A6113D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 04:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4710A6113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF8986E255;
	Tue,  9 Nov 2021 04:15:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A15F96E255
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 04:15:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wsfod64zOlCNbZeU1OE6leRVbbvKvGUvthcgiaIJHyS3dKk37YwAvDH/6Wh2h8gt4b5gdKkU9zzt/eh3UdUXHq5OPx+bg9cSDHfFgJ1Px1RgJF9ZLcbIDinLJiRAFBoQngvK83GjM2VhdAafZT5o7o2tL6ot+9/1L8FbRrl7WDzjH2r94/fmJ8IrhGXgSR+WZWlBoTvlREQbRvwgzNqi0uRicSeKjGZRBdUSFwFqfwEjA/OWEd9DDshIKpwOa8ctYfA+7+5FuKS4JX+o7CKQtsG41wfu1MF+V19TW0iVjnL14Jhl3rR0KglZc3HP8vlwBd/vcVg684LfPVdpmSYTMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKX1llVg9WgqIoVEYCxeIh8mAobCcIQItfwCQNm6JVY=;
 b=gPy0xsC3VyNrQJuShw3RlrCgwtHoDTUv5zct9V5XA1msx5y111QsA3FpDNduX9vSiClywHAvU6BAHF0MRb/MCHa3PZXzWVL+5oxbRcDShYuP/WCRbUmTisW47WlUikp4CZUyD9OTECxhVGzGaXnLAhf6nBIFQXURdq4OdbTbX7jIQJeBsZFDTjtd5po1e33tlcoyH2MYKoCePRWYxy8Pzv5p/yBdXLHN32d69WnVlr/PAmip1jU2t5eXDo5TIwLEKO9ScQKZcGmr0or+FS34ZxGevKTIjrBLYNMk/0peCnlfqzPIMQKmgvnzTGjIIuz5aLRdLnVmfFShqyeXfpx2iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKX1llVg9WgqIoVEYCxeIh8mAobCcIQItfwCQNm6JVY=;
 b=xxjbftMRidWmxJYINm7LsqPAbovDhGqvvL2HmIVp9E3+v4Cm0CL9zvfDlxKTNMY1UHh0Mnv4fWJokBwGF2PCDPuyLB11oW/ryZBsu+NwLYe2fBzPqEqnFJ8xFNQejn7jGnO4KptLZ5XCvXYHelYQGeC9WQA2GhVB8akjMRmf5HU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB2937.namprd12.prod.outlook.com (2603:10b6:5:181::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Tue, 9 Nov
 2021 04:15:29 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 04:15:29 +0000
Message-ID: <87848118-a230-1941-f97d-384158dc95d6@amd.com>
Date: Tue, 9 Nov 2021 09:45:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amd/pm: avoid duplicate powergate/ungate setting
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211108044723.54716-1-evan.quan@amd.com>
 <80a7b1d5-f57c-ef32-bd90-9e31554127e2@amd.com>
 <DM6PR12MB26198F33A0A6BC4C760ACD7AE4929@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB26198F33A0A6BC4C760ACD7AE4929@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0063.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::23) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [192.168.1.9] (103.160.194.6) by
 PN3PR01CA0063.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:99::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.15 via Frontend Transport; Tue, 9 Nov 2021 04:15:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 166bbe90-513d-45e2-9940-08d9a337901c
X-MS-TrafficTypeDiagnostic: DM6PR12MB2937:
X-Microsoft-Antispam-PRVS: <DM6PR12MB29373027EBA55012CE1CC61497929@DM6PR12MB2937.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eg/mHdeE2zwh8VsjMkena67M6h5kyRG3tTgqSuU3at2apX/5JgAPuOccgAZvcbj+rTWIS3/2nqDs+StLBVkAs0aPwG/lWbNO3EF4xvEzB+bpjFvpHxnVBIQ43vyE/+QxlSYiKjkoeIyynykKVb3qvuU+UaVeHxjgSs8aYKQBOmhX7/zMWCNqLw/O0PIExXc08Kyv8mwN4eutTXeSZmL6CJI6ZJAVQEHAy6tlv5hsghknG+Qh8B5lX4JeQQH4BCdWXVjIRMn9Frw3W2J417qyGiSJUaaIXm/MjkPj1e6zx92lj3pSSkHi93+0q5dFpgdv7mwCzwlzOAuaVBTNjRibpzrheUHxcp+Kibtc6TjVd3RCDwTYW77Ll1p9KREqISinymZLJiiX1ldGu/y6qgKx2wEYXCdD+nz9At87MlvZV4mI7TQwH8FnlKMkXMnwMBRWT15EpGMDysX/LULqJEtTz8i8VxLUMuvlptXaWu2hyJH90a/jqoo1iYKiy4mbwP3RIPKn/fGHXb2Zrr842tjObZRMpDQrq8pV4DbGMbJf0khAtzaKuhfNZmEVkEPBsrXD2mb36dJ5s54lG5ovhYs4mlM4z4+qjXMS2RTLHZe+BRvNSc/jdPRKNdrNj3v3DD1a+z6ZGD/jjwQSlTQK+hyuOk+YEtB5wwaV2wHStK4+b3VKyhzyIVOR4jASfgmV1aERXsA35PfDkiTqEAzMJ/wucRuVdxqDDUTHhzAZZr9Ysn5HaJcZO6qbq7OCZ56wel//
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(16576012)(316002)(4326008)(5660300002)(508600001)(66946007)(53546011)(8676002)(86362001)(110136005)(6486002)(38100700002)(2616005)(26005)(36756003)(8936002)(54906003)(83380400001)(6666004)(31696002)(186003)(956004)(66476007)(31686004)(66556008)(43740500002)(45980500001)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGcxYnlOS3ZBQzRyeWZpbURCTjlUZ2dUNnFVZE5GSGhUUkwyUlVvc1RNUE51?=
 =?utf-8?B?NDhCUTJLb2NQUmNRdkZDV1BEekZZd2t4RmZBck0wTzY2Y0o1cStjS013NUtn?=
 =?utf-8?B?WVV1S1lJbnpZMzhESWl1Z2pZTWs1WndzZk8yaC9EMDlwS0lPQTBDVW5kUzha?=
 =?utf-8?B?MEZPOHJKYzFaZ0Y0T3d5eEhHcW1tTXlpOEFOUXdrTFVWNDlZdGpUbWQxeGdS?=
 =?utf-8?B?ai9LV3pUQ3pNRkQvVmVoTW5yelFlaGVBSFpXcWVBdCtMVTRTZktFWWF1bldG?=
 =?utf-8?B?OTI4cHdEOG1MNG9NdnpXNS96ZUVva2JwMHZPS2d3NGdKRVBLQnVrZk1sYU90?=
 =?utf-8?B?WUp3WU9YbDcvSTdrSzhwQ2szSTllZTI0VXJmRzlVN0luRis3VFBOU0VWZjYx?=
 =?utf-8?B?WDlvSUtBMTNUa0lIV1dISk9vU09OcHBWcEZndmYwRUNQandoSnM1ZnUrOGY1?=
 =?utf-8?B?L0JkeWhxS3QwaU1rWFhsMzE3U25uTEhubUNlUjRwUkwzYzIrNjI3Zi9aZU1o?=
 =?utf-8?B?MnpWa2tad05rSEdoUFVBZjIxZURDMEx1T2VZUDNzZGF6RTlOcnQ3WWtkS3B0?=
 =?utf-8?B?dmpZUzV2N1FjRWtPcnU4ZWRpcGxBNUNZSGlyZEdLYnJVZXh3WDNFRzhQV3lq?=
 =?utf-8?B?N29SNFVxcUcyTERxdGFBa0JZVHJ6amwrdVc2ak9vcUlEMGRSRWRVdlNnZS9R?=
 =?utf-8?B?N3NzNHh2azg3TkE5Z21MOUNIaENLUC8zbmh3RHRIUGFIQUZxN3FXdjhjMk5o?=
 =?utf-8?B?eDBXQjZ6Y1FVUFhNNWtxR1dVMXphSUo1VFZwblltMzBsTVBwK3ByTDhzRVQ3?=
 =?utf-8?B?MEdnaXRRMmtZQ3RYaTc5eDJDaFY2Y0trSzJOZnh4dGljRERsTG0vYjQ4dmE3?=
 =?utf-8?B?a20vKzllUiswRkJZYUxpU0JIQ2EwU0JBbE80K3cvV2Vsbm13dm5WZkkwdnBG?=
 =?utf-8?B?QjF2eTd3N3JiRkcwZFBNaXR1aEszQlIyWWhWK2Rrci9wT2NMbXVCUFRDQVNl?=
 =?utf-8?B?WDBocFN3Q3VDK2t2T1JpZ1IvT0FBb2hjc1FRdVhvNkhuRTVRTVZwclNGMWp4?=
 =?utf-8?B?cUtOQkRrKzREK0J3bE1XR2tnN0JaMlE5bXJLS0trT0h3QTB4d2w3M2UrNTNs?=
 =?utf-8?B?NjBab2pmblNUVys3RGh4aDJ5ZGw4UkRlMjl3ODM3V1YvM2xtQTV1dFdqQWd0?=
 =?utf-8?B?QjZOZ2FmUjUyNlNJbGNMZGJaNUN1OGlpVVRHdHIyTVNtT1dTTDNyOUNucVNu?=
 =?utf-8?B?dldqelBPTWVEL2pZSlFkTXI4bjZHeDR2VGZzQm5kNGQ2Y2MxNWoweFd1NWhT?=
 =?utf-8?B?Q2hqZEk0MS9hMjN3eGRDWnQyTkE0VTFwWlNsUTVKenlpYXFreFZOeVZ1bnc0?=
 =?utf-8?B?T2pQWW9mZ0lqc2xYa1hYbzZQN2RaSENSZmJ1Tlh6WWpRbkpHc3ZicVd3Yjhk?=
 =?utf-8?B?UDk1RWhyVEwwSGg0V3Ewenl5ZVBBc1oySnlTb2hKeDhONmRmc3hXTmhLcDBR?=
 =?utf-8?B?ZVlJa1k2UFcvV3ZzbG16SHRjRGFWVHIvdGVRRWFjMmduVVB2M3l1QWhGNGx0?=
 =?utf-8?B?cDRwS1gvZ3R4QWMxUXArbnJCWFpYZE9NQVdEbFdFVUZGdzdBeU00aWI4K3Bk?=
 =?utf-8?B?aWpMS0UxcTkyaG9wMXk1U0N2QUtaWkNlZUhJUDYxcjE2MERMVi9mdnRDVTZ2?=
 =?utf-8?B?cVNJNG1OMTYxK3VjZlBSUGpJS2RtUTVZcWFwZGVWOUxWeXJ2c0FJUExaOG1E?=
 =?utf-8?B?WDdSQ3hlRW5SRHZ4Vk0xWkp0RjZQcTJJbk13NmZMSEp4QUduMUdVS2h3S29G?=
 =?utf-8?B?MjJBVFhsUzFiTjY4V3crdEpKSjhDRjdpd3VNeWZTcVpveVZDNjJublNIZCtl?=
 =?utf-8?B?SlNObGlvU0I2emRoaHNRT1VwOG5pazBhNjFjSHRtdFdZU0VsRTBTNFA5VThP?=
 =?utf-8?B?LzQyWVVKazdyRG5qaEdFdmpSRFAzRUZNM1FDL01sanA3RWtBQmtrQ1RWT0J1?=
 =?utf-8?B?QkcrdDNHNlhXYWJ5UEE4SVhQeE5helV1aUVIVkIxTGZkb1NoVjR5R3owc1pT?=
 =?utf-8?B?RXcwSlBnR2xwWDlKbHhWZE5RWDM1TFFhREJJT04rRnF3c0l2MjYwSXdxNktK?=
 =?utf-8?Q?cTaU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 166bbe90-513d-45e2-9940-08d9a337901c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 04:15:28.9775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPrp5QJ+/tAa0xNdt7KMpWuuGwXRdjIqsZ/QtnEmeLqHVSAc0UDG0+DavoLIWO1z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2937
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Borislav Petkov <bp@suse.de>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/9/2021 9:10 AM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Monday, November 8, 2021 7:16 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Borislav Petkov
>> <bp@suse.de>
>> Subject: Re: [PATCH] drm/amd/pm: avoid duplicate powergate/ungate
>> setting
>>
>>
>>
>> On 11/8/2021 10:17 AM, Evan Quan wrote:
>>> Just bail out if the target IP block is already in the desired
>>> powergate/ungate state. This can avoid some duplicate settings which
>>> sometime may cause unexpected issues.
>>>
>>> Change-Id: I66346c69f121df0f5ee20182451313ae4fda2d04
>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>> Tested-by: Borislav Petkov <bp@suse.de>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h              |  7 +++++++
>>>    drivers/gpu/drm/amd/include/amd_shared.h         |  3 ++-
>>>    drivers/gpu/drm/amd/pm/amdgpu_dpm.c              | 13 ++++++++++++-
>>>    drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c |  3 +++
>>>    drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c        |  3 +++
>>>    drivers/gpu/drm/amd/pm/powerplay/si_dpm.c        |  3 +++
>>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        |  3 +++
>>>    7 files changed, 33 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index b85b67a88a3d..19fa21ad8a44 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -767,9 +767,16 @@ enum amd_hw_ip_block_type {
>>>    #define HW_ID_MAX		300
>>>    #define IP_VERSION(mj, mn, rv) (((mj) << 16) | ((mn) << 8) | (rv))
>>>
>>> +enum amd_ip_powergate_state {
>>> +	POWERGATE_STATE_INITIAL,
>>> +	POWERGATE_STATE_GATE,
>>> +	POWERGATE_STATE_UNGATE,
>>> +};
>>> +
>>
>> To reflect the current state, they could be named like
>> POWERGATE_STATE_UNKNOWN/ON/OFF.
> [Quan, Evan] This may be more confusing. POWERGATE_STATE_ON means "gfx on" or "gate on which means gfx off"?

What I meant is -
	PG_STATE_ON - Power gated
	PG_STATE_OFF - Not power gated
Thanks,
Lijo

>>
>>
>>>    struct amd_powerplay {
>>>    	void *pp_handle;
>>>    	const struct amd_pm_funcs *pp_funcs;
>>> +	atomic_t pg_state[AMD_IP_BLOCK_TYPE_NUM];
>>
>> Maybe add another field in amdgpu_ip_block_status? Downside is it won't
>> reflect the PG state achieved through paths other than PMFW control and
>> ipblock needs to be queried through amdgpu_device_ip_get_ip_block()
> [Quan, Evan] Yes, we will need to track pg state other than PMFW control then.
> That will need extra effort and seems unnecessary considering there is no such use case(need to know the PG state out of PMFW control).
> 
> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>>>    };
>>>
>>>    /* polaris10 kickers */
>>> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h
>> b/drivers/gpu/drm/amd/include/amd_shared.h
>>> index f1a46d16f7ea..4b9e68a79f06 100644
>>> --- a/drivers/gpu/drm/amd/include/amd_shared.h
>>> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
>>> @@ -98,7 +98,8 @@ enum amd_ip_block_type {
>>>    	AMD_IP_BLOCK_TYPE_ACP,
>>>    	AMD_IP_BLOCK_TYPE_VCN,
>>>    	AMD_IP_BLOCK_TYPE_MES,
>>> -	AMD_IP_BLOCK_TYPE_JPEG
>>> +	AMD_IP_BLOCK_TYPE_JPEG,
>>> +	AMD_IP_BLOCK_TYPE_NUM,
>>>    };
>>>
>>>    enum amd_clockgating_state {
>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> index 03581d5b1836..a6b337b6f4a9 100644
>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> @@ -927,6 +927,14 @@ int
>> amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
>> uint32_t block
>>>    {
>>>    	int ret = 0;
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +	enum amd_ip_powergate_state pg_state =
>>> +		gate ? POWERGATE_STATE_GATE :
>> POWERGATE_STATE_UNGATE;
>>> +
>>> +	if (atomic_read(&adev->powerplay.pg_state[block_type]) ==
>> pg_state) {
>>> +		dev_dbg(adev->dev, "IP block%d already in the target %s
>> state!",
>>> +				block_type, gate ? "gate" : "ungate");
>>> +		return 0;
>>> +	}
>>>
>>>    	switch (block_type) {
>>>    	case AMD_IP_BLOCK_TYPE_UVD:
>>> @@ -976,9 +984,12 @@ int
>> amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
>> uint32_t block
>>>    		}
>>>    		break;
>>>    	default:
>>> -		break;
>>> +		return -EINVAL;
>>>    	}
>>>
>>> +	if (!ret)
>>> +		atomic_set(&adev->powerplay.pg_state[block_type],
>> pg_state);
>>> +
>>>    	return ret;
>>>    }
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>> b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> index bba7479f6265..8d8a7cf615eb 100644
>>> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> @@ -38,6 +38,7 @@ static const struct amd_pm_funcs pp_dpm_funcs;
>>>    static int amd_powerplay_create(struct amdgpu_device *adev)
>>>    {
>>>    	struct pp_hwmgr *hwmgr;
>>> +	int i;
>>>
>>>    	if (adev == NULL)
>>>    		return -EINVAL;
>>> @@ -57,6 +58,8 @@ static int amd_powerplay_create(struct
>> amdgpu_device *adev)
>>>    	hwmgr->display_config = &adev->pm.pm_display_cfg;
>>>    	adev->powerplay.pp_handle = hwmgr;
>>>    	adev->powerplay.pp_funcs = &pp_dpm_funcs;
>>> +	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
>>> +		atomic_set(&adev->powerplay.pg_state[i],
>> POWERGATE_STATE_INITIAL);
>>>    	return 0;
>>>    }
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
>> b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
>>> index bcae42cef374..f84f56552fd0 100644
>>> --- a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
>>> @@ -2965,9 +2965,12 @@ static int kv_dpm_get_temp(void *handle)
>>>    static int kv_dpm_early_init(void *handle)
>>>    {
>>>    	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +	int i;
>>>
>>>    	adev->powerplay.pp_funcs = &kv_dpm_funcs;
>>>    	adev->powerplay.pp_handle = adev;
>>> +	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
>>> +		atomic_set(&adev->powerplay.pg_state[i],
>> POWERGATE_STATE_INITIAL);
>>>    	kv_dpm_set_irq_funcs(adev);
>>>
>>>    	return 0;
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
>> b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
>>> index 81f82aa05ec2..f1eb22c9bb59 100644
>>> --- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
>>> @@ -7916,9 +7916,12 @@ static int si_dpm_early_init(void *handle)
>>>    {
>>>
>>>    	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +	int i;
>>>
>>>    	adev->powerplay.pp_funcs = &si_dpm_funcs;
>>>    	adev->powerplay.pp_handle = adev;
>>> +	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
>>> +		atomic_set(&adev->powerplay.pg_state[i],
>> POWERGATE_STATE_INITIAL);
>>>    	si_dpm_set_irq_funcs(adev);
>>>    	return 0;
>>>    }
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> index 01168b8955bf..fdc25bae8237 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> @@ -627,6 +627,7 @@ static int smu_early_init(void *handle)
>>>    {
>>>    	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>    	struct smu_context *smu = &adev->smu;
>>> +	int i;
>>>
>>>    	smu->adev = adev;
>>>    	smu->pm_enabled = !!amdgpu_dpm;
>>> @@ -639,6 +640,8 @@ static int smu_early_init(void *handle)
>>>
>>>    	adev->powerplay.pp_handle = smu;
>>>    	adev->powerplay.pp_funcs = &swsmu_pm_funcs;
>>> +	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
>>> +		atomic_set(&adev->powerplay.pg_state[i],
>> POWERGATE_STATE_INITIAL);
>>>
>>>    	return smu_set_funcs(adev);
>>>    }
>>>
