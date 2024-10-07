Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16925CFB43F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Oct 2024 13:33:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2DFD10E397;
	Mon,  7 Oct 2024 13:33:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q5zpaCjU";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6240410E397
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Oct 2024 13:33:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIm3qsQi84CJPSRFpFAWopWEIcrukIzkQ0nCW6ShtWIbznFHdweKwvdzKKCHcn6N00ZPERB3TuEHKMNx6jDsUiIFHdGlkRJ9K7xGw9i9oFrB8xse9LrJPFI7NlXpuabzg5X1OZbqIlfAlhBXYeUhW1xTUiNhFLjr9dezKVPG0cDQOIdMGZ7ZW4v3GcF1R6gjD/VwOG+VhpKUGSpfEMgmwd6cPpaKBPfy/SoM3HDPnqVf6IYjSg1sWgZ+6SvPy0WfIs0xoef2hlPjnWAH0upqSU927dqkSQzGwv1PbTe0QsGknM5d6yXGp3O9/hofp8AlsTE9rAL3MKhmKCo2AqG04Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LW1ucYCXr5fNb+Ww6cNP1mIJ3dfrKOa/yNuWS5tEa2w=;
 b=c6xcR9QcRPxKRY+1OPaa/Q6fP0S9Pf+5gpBZo43/SPgI8Me2EjeSa/9UbF1Waf9JIaL/KjwfN2AcQfppUBQf8bCgvFSLzQZmwUcZlYGmbxt2ICtM0LLCj8qATE5WyCvuH9fsR81afDMa/+8dWsEYYBnBITzxyIkchPuj5dzsq2MJj+zt1WSy/0MrIER+0dMLsejslOT1S3vpp/k7fmHWioP/FT45D692MQbDmK9JXNnBYPNThTgCZLJ0M8/BPoZE+Twn0bdAClqmqVE0V8JIt6yYnnwJLDFaQ9chviVQnddMIuSLJf/hky+qfJe0pWl1DX30agEQQqMZz7bKL7SG7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LW1ucYCXr5fNb+Ww6cNP1mIJ3dfrKOa/yNuWS5tEa2w=;
 b=q5zpaCjU/ePhmBxf1guNLPrR8q1n+3HDAcHSmZ8b0pq8LsZcbBSDVP1+D7FIH4/KWCPpqnVR72AgdCoY2xT/QqbLsiXikrpTIfx2ngWUiow3O8OrOM4GbzTioHH3TYFIQpc67p9gZQEIlVpZ1I/5KU0PTpv8qxDyWoUS2qB2YzU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by DS0PR12MB6654.namprd12.prod.outlook.com (2603:10b6:8:d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 13:33:26 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 13:33:26 +0000
Message-ID: <2d260d2c-d052-4b07-9cbf-0e5fc4199f98@amd.com>
Date: Mon, 7 Oct 2024 09:33:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] drm/amdgpu: power vcn 2_5 by instance
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org,
 leo.liu@amd.com, christian.koenig@amd.com, alexander.deucher@amd.com,
 sunil.khatri@amd.com
References: <20241004184444.435356-1-boyuan.zhang@amd.com>
 <20241004184444.435356-12-boyuan.zhang@amd.com>
 <4a7b5736-f60b-433b-a021-fef2cf4f2338@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <4a7b5736-f60b-433b-a021-fef2cf4f2338@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0313.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::26) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|DS0PR12MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: bf57f5c5-164d-4aab-cd9f-08dce6d49f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEd2djUvTTRYNXpaQkJkQlRZa1Y2V0RNdmVBTFU0YlM1UFNDbmhRVU8xTmFM?=
 =?utf-8?B?d1Z0QVMrVWFxNkQzanQ5VjdjS2oyaEo3eGh2bU1WbDJhSWRMMk41a2ZiTlhU?=
 =?utf-8?B?eGN0L0hDcUlPeGVaNktsbTlMRzZHVXJGMkY2aThqV3I0dzU0VGNpbGNJSE5v?=
 =?utf-8?B?d2JhcTdLYVRtMk53SnJNelNXekllNER5R25QZkVkMEJNdkdHNURVMUJxU1FW?=
 =?utf-8?B?WldKcWhDb09vN2d6SjljNDZEdG9LYjJMa0JHdzdncVh3UUllbXZMNkk0UzF1?=
 =?utf-8?B?NVVKOWZPRXQrR05uVE5adzdsT25ldnN1NnVtaHBrczdYdGk2QUJDZlZvYXZ6?=
 =?utf-8?B?SFZLNGVKd3V4bnJPZThRZ0hQdUNNb1hFdWdyQ1hSNmZjVkdMOUEya3NzK0VB?=
 =?utf-8?B?OGQxalhTM3JSTm1wTXVsVXRjVVZueitQNnZrSFdnRWhwL0EreE5KSHZ4aTFO?=
 =?utf-8?B?TGw1aERVRUUzb0drYk80K1ZmTTVXS08waVQrOTh3S3J5Q2F3c0NCUWRzeDJ6?=
 =?utf-8?B?dlVBSWdGeElwWmhOTUp6U0NGb3ZVZHZleHM1WUova1F6eE1wSmJGNVJsY0hB?=
 =?utf-8?B?MTlpbVBxZ3FOMXZBbTBtNW5xdi9OZVFrc0hTc3I0L1pCVVU2ZWN5cllEYjRp?=
 =?utf-8?B?Wm9XNDdVdDZNWG5WeERxWkdrNzhUUmoxUWhmRGtGd3E2eVJBYWtFdStUZVBu?=
 =?utf-8?B?VjJOZ1dUNm9KZFJiOU9HYlBJYXcxWE41M3NDU09YdFlOYkJkKzZNZ1J1SU1C?=
 =?utf-8?B?cEp0aGMzQnVUeGJHS09IcUJWcTA5b0pmbU4yOXJleXhoMmh4d1Fvc2p4Y3Ba?=
 =?utf-8?B?Q1o0L0pNTTdFQzBUU2o5ejdETVdNaFE1T0g2NGZUZGZ0aHJqTStNM0s3Nmx3?=
 =?utf-8?B?dVVuS2xTMU54aWE5T3ZrZ1dLc29iN21vTzZsS1NYTVVRMzVpbXpqZHBTbU41?=
 =?utf-8?B?RWkxSzNwVENJcDB2WUVhUG00TS84WHFzcWlMNGpkaEF5NGhzZ1dFUUlhRzRR?=
 =?utf-8?B?a2NmaTg5RVlwRFhqN0VCanRibmxRaEtIUjAwR0JIOXU3ZjJqUFN6TURzdHVx?=
 =?utf-8?B?RjBpSzgxQllhWkt1dVNUT3JtVFpFYWJ5bjhDd2xGU0FrYkliOXhmOXZQRkJL?=
 =?utf-8?B?VVVmWStTQkJLVzdNWFdTdkxQSkxaNHJMTnM4SDdHanZFMWFlWXRWamlRMU9m?=
 =?utf-8?B?enh2b2kvM0N5Mkc0Sk00WDdYMGswSWRhSEJwaFF4WnZGWE9va216SUx2VVp3?=
 =?utf-8?B?MVdESUk2UGUwWVMrQ0U0N3hQc25Xc0Qyb1M4QWxrSUFQTlFMM3NyVXNHcTRW?=
 =?utf-8?B?b296ZjUwZnc0eXpkaEQrSkVYSlQ5RFdmY3pPMTdpakxSYTNuRXNSYTF0UW50?=
 =?utf-8?B?QVIwWXZCd0l1WVRhRFpyWGUvWHc4dGo4UDBsR3RqTXAxRkZDdEdzMjdkc2Z1?=
 =?utf-8?B?ZnJoQ0ZvVlVnZnFPQUdRaXEwTzZVM21hNWRxbjI3OFM0UUVVeGlZWDRDV3Iz?=
 =?utf-8?B?MlpwcFppWU5hT1lqc2JqRHhmc25yK3QrNGlzc0tOdDhlaDNVaFhnZ1prd1dp?=
 =?utf-8?B?Vm9kMUcvTVZMOVZqUVpDb01DTFBzak1PbExYSy9DWnIyUlBGRldIU1c0eXBP?=
 =?utf-8?B?U3dYY3pXcE85cE1zWjRnako0ejd2ZjM1VmRYTVRiOFczNkdDSHhTN1gzQlVa?=
 =?utf-8?B?K1V4WnhCNkpDOEljODZISmtYT2ZXeGdCSnNReHh0WExkRm1hc0RLTHZnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW5kVW5BZEl5YVBHdTFoMnNRamQxQ3R6cDBoZCtoZkVkTkNMd0RTQm5iRUFu?=
 =?utf-8?B?b1hXVHFnN1U1dTBkVGFidmV5WnFpWWQzb2lBQmdhUlNkeVZNNncyS01Uci82?=
 =?utf-8?B?ZVg5RG51NGl0U0p2dk5pY3llbUNLOUlMZVNGTjJROXF0TW44ZDQveHI3cGY3?=
 =?utf-8?B?SHI1SFUwajM4a3FtUTl2ZUVnT01ld3JKaW5oajhxOWtoRE1mTFlVQTN5YXAv?=
 =?utf-8?B?OHY2Kzd0QVlaVWpwKzBERFN4SW5HUzdpdXRwcVFaUW5RVU9pajR1M3g0N2Er?=
 =?utf-8?B?ZHBxTXV1YW9mVDBHVmZoUHF0TTVUc2tMbkRlUkFYcUtKY21YL0xWWkVQaTBi?=
 =?utf-8?B?Q21tZitjVnpjYjUwNlVMUkQvMmxzWWFRaFFxQ3A3d2NnbllTUmhtbG04SnJH?=
 =?utf-8?B?ZzJNTTRoWHNNNTc2Z2tvNU1HTGZ3eDAvSVJkemN3SWU0bkFzYnI5RUVZNXRI?=
 =?utf-8?B?QmkvclJZWVhqTzdQNDltZ2wybW5JQmhPR3luZWtDNE9McGZQdDZSWUtQaFU1?=
 =?utf-8?B?Yk04SFh2WGFFVXI3OXA4bm9Sc2tlL05XdXZyQWhCUW52bTEwcWNRcjU2ZlEv?=
 =?utf-8?B?K054NFdvdXNrZXp5dGFBdnlIbnZGTlRrN2dyT3IvSjF6SHV4UHk0R3p5aDhY?=
 =?utf-8?B?Tkk5dVllYWF4c3hvMWpxL1NCcXJqZW0xQ3EwWVVsUGFpOVo0WkhaRVVhczVD?=
 =?utf-8?B?aVRBY24xQ1hrWkVTSmpsNXlqaGZ5bTVjcUFFZTJWTitLN3Z0a2pJTUZ5RVla?=
 =?utf-8?B?TTZFeFFBRFJFcm44aHcxUWRTR3lnaTdPVmtITzBhcXJUcXZzUnhjVDQ0TzVY?=
 =?utf-8?B?NjV6bVpBdUlITm5XN3lDUkQrbjFDQjUrdGdyVFhIYkZwS291NS9wSlU2UEtE?=
 =?utf-8?B?OVIyejZNL0hGWHlOR2c5Z1BFTDgxMnB6THptU25rNnd5UTZEZ3BJZzI1dVFo?=
 =?utf-8?B?ekNldWloVUVVUWxMZUtLTFU0RzZNNDVMOHY4bHREd0xtY3AvNmRLMkxWeGFm?=
 =?utf-8?B?eFFDZEYxWlo2MC91U0J0NzZpV3VCOTQzd2VaZWgyRm5rNGsyemx2amhvVVZy?=
 =?utf-8?B?S1dzclhNdXkrZDVKdzFrd0hJL1lMbE5mSzBldjFOZEFnODdxTHB2RlZpZFVC?=
 =?utf-8?B?Y0RvYjFIVUpZMGJKR2h5ZytXSU9xWWRQUWcrckhrM0paUGdqbEViWjJGTklS?=
 =?utf-8?B?UFRVbmdUck5pYmN3VkdqY0E4cGV3V2ltNkM5OEVQTjEvait0UnkzRGpLRklI?=
 =?utf-8?B?Y1M1TFZUTUgvOFNZL0s5bzJHZjRYOFh0amJQL2orakM3UnRGZXlLTk5CQUkv?=
 =?utf-8?B?RVZOSXQxbmlQbzdzZmNvZ21NZk0xT1EyTmRiY1EyMDFsSWM4bGN5MFhaN0pk?=
 =?utf-8?B?Ylc3dmlldXdQNE5PTGJSNnhDaU1qbVl3UWlxbUpNOHpxVWZUVytQTXZJM0Fz?=
 =?utf-8?B?OWJjUEYrTFJRNUVyVzZLL0p3NzRJYm45WEQ2aHVZVWx0clFRbHhpZkljMzZh?=
 =?utf-8?B?Sytjekk1MWpsbkM2eWpmYTJ0Z0FsT3Q2RjlwUXFRQ3NUK3ltY0NoL0xPYThU?=
 =?utf-8?B?dGNxYlM4N2hmRmlZNmxuUHdVanM0clM5QXRnUkNTdXZlNkprZmh0VkRRUVoy?=
 =?utf-8?B?YXlKNWhIWURGbGNnZmZiVVR1U0hKUDVaWUltMXk2T2JYeWFXbURpdGpzZEx3?=
 =?utf-8?B?d3ZsbXJPQ3EzVmR1dEFHSWVNbHlwb05UVS9iQWEzVGJBckdvTlBVdW0zd2E5?=
 =?utf-8?B?dk1zNGIxaEtFODgwOU5aK3RpdWZ5bnhxWDVWWjJZcUlBZmI0OTNTTzNmTk51?=
 =?utf-8?B?WWZCcEkvU2dzV2ZHZkpvbUZGS0c5R2F6VWhIZG9uQ0toVHNxY3l4QXg1YjVt?=
 =?utf-8?B?bUVJL2lwREc1NHNXM09rdlVQclFrYStFdVpxTEdFa3RwQmhtZEhFMitwTGZW?=
 =?utf-8?B?MTZ5OVlwQmRGOU9MRlJZUnRuMjQ5MllDZnVmQ3FnQzc1ZWo5U0oycDNJWFNN?=
 =?utf-8?B?TzRTSzNSNVM4UTJqMm02aXJUVXJzTG1yVWU1MkZUNHpzWGpNWE1RSUZoNzBa?=
 =?utf-8?B?NnJCTHVkdGMxNFdqYkQ3S0QrZnI0ci9CNlBaRXl2Z3pBeUFyVEdnZ3BxU1Zh?=
 =?utf-8?Q?WZuZHUEBcGYW2VCfi+w6mKR34?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf57f5c5-164d-4aab-cd9f-08dce6d49f7e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 13:33:26.4949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IuhLE/UFWuhVXo5evV/F17dtQUk03e6aFXt4NRdi/hNF9CRA9FPEerQEBvWI+jSp5sgZYed4hYjBI2LfBn/Y3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6654
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


On 2024-10-07 01:22, Lazar, Lijo wrote:
>
> On 10/5/2024 12:14 AM, boyuan.zhang@amd.com wrote:
>> From: Boyuan Zhang <boyuan.zhang@amd.com>
>>
>> For vcn 2_5, add ip_block for each vcn instance during discovery stage.
>>
>> And only powering on/off one of the vcn instance using the
>> instance value stored in ip_block, instead of powering on/off all
>> vcn instances. Modify the existing functions to use the instance value
>> in ip_block, and remove the original for loop for all vcn instances.
>>
>> v2: rename "i"/"j" to "inst" for instance value.
>>
>> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +-
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 565 +++++++++---------
>>   2 files changed, 280 insertions(+), 289 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> index 9f9a1867da72..de1053cc2a2b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> @@ -2278,6 +2278,7 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
>>   
>>   static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>>   {
>> +	int i;
>>   	if (amdgpu_ip_version(adev, VCE_HWIP, 0)) {
>>   		switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {
>>   		case IP_VERSION(7, 0, 0):
>> @@ -2321,7 +2322,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>>   		case IP_VERSION(2, 0, 3):
>>   			break;
>>   		case IP_VERSION(2, 5, 0):
>> -			amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
>> +			for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
>> +				amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
>
> This introduces a totally confusing design now. At a higher level an IP
> block type manages multiple instances and their power states. Now there
> is a mix where no definition can be attributed to an IP block. Or, if
> this were to be done uniformly for other IPs, then for some SOCs there
> could be 16 SDMA blocks, 8 GFX blocks and so forth.
>
> What is the reason to do this way? Can't VCN IP block maintain the state
> of multiple instances within itself?
>
> Thanks,
> Lijo
This is part of the fundamental design change for separating IP block 
per instance, in order to
handle each instance separately within same IP block (e.g. separate 
power/clock management).

Part 1, Change all adev ptr handle to amdgpu_ip_block ptr in all 
callbacks (hw_init/fini, sw_init/fini,
suspend, etc...) for all IP blocks, so that each IP knows which IP_block 
(and which instance) the
callback is for. Most parts of this changes have been submitted by Sunil.

Part 2, Separate IP block per instance.

Part 3, Since callbacks can pass in IP_block now after Part 1 change and 
instance value can be
obtained from each IP block in Part 2, IP can then choose to handle 
callbacks ONLY for the given
instance of a given IP block (or still handling for all instances as 
before).
For VCN, all callbacks will be handled only for the given one instance, 
instead of the original for-
loop for all instance. As a result, each VCN instance can be 
start/stop/int/fini/suspend separately.

Part 4, Change all VCN helper functions to handle only the given 
instance, instead of the original
for-loop for all instance.

Each instance can have its own states, so we think it makes more sense 
to separate them on IP
block level to handle each of them separately.

Thanks,
Boyuan
>
>>   			amdgpu_device_ip_block_add(adev, &jpeg_v2_5_ip_block);
>>   			break;
>>   		case IP_VERSION(2, 6, 0):
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> index d00df51bc400..1f8738ae360a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> @@ -158,35 +158,34 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
>>   static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>>   {
>>   	struct amdgpu_ring *ring;
>> -	int i, j, r;
>> +	int i, r;
>>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
>>   	uint32_t *ptr;
>>   	struct amdgpu_device *adev = ip_block->adev;
>> +	int inst = ip_block->instance;
>>   
>> -	for (j = 0; j < adev->vcn.num_vcn_inst; j++) {
>> -		if (adev->vcn.harvest_config & (1 << j))
>> -			continue;
>> -		/* VCN DEC TRAP */
>> -		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
>> -				VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT, &adev->vcn.inst[j].irq);
>> -		if (r)
>> -			return r;
>> -
>> -		/* VCN ENC TRAP */
>> -		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>> -			r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
>> -				i + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[j].irq);
>> -			if (r)
>> -				return r;
>> -		}
>> +	if (adev->vcn.harvest_config & (1 << inst))
>> +		goto sw_init;
>> +	/* VCN DEC TRAP */
>> +	r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
>> +			VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT, &adev->vcn.inst[inst].irq);
>> +	if (r)
>> +		return r;
>>   
>> -		/* VCN POISON TRAP */
>> -		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
>> -			VCN_2_6__SRCID_UVD_POISON, &adev->vcn.inst[j].ras_poison_irq);
>> +	/* VCN ENC TRAP */
>> +	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>> +		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
>> +			i + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[inst].irq);
>>   		if (r)
>>   			return r;
>>   	}
>>   
>> +	/* VCN POISON TRAP */
>> +	r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
>> +		VCN_2_6__SRCID_UVD_POISON, &adev->vcn.inst[inst].ras_poison_irq);
>> +	if (r)
>> +		return r;
>> +sw_init:
>>   	r = amdgpu_vcn_sw_init(adev);
>>   	if (r)
>>   		return r;
>> @@ -197,76 +196,74 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>>   	if (r)
>>   		return r;
>>   
>> -	for (j = 0; j < adev->vcn.num_vcn_inst; j++) {
>> -		volatile struct amdgpu_fw_shared *fw_shared;
>> +	volatile struct amdgpu_fw_shared *fw_shared;
>>   
>> -		if (adev->vcn.harvest_config & (1 << j))
>> -			continue;
>> -		adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
>> -		adev->vcn.internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
>> -		adev->vcn.internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
>> -		adev->vcn.internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
>> -		adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
>> -		adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
>> -
>> -		adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
>> -		adev->vcn.inst[j].external.scratch9 = SOC15_REG_OFFSET(VCN, j, mmUVD_SCRATCH9);
>> -		adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
>> -		adev->vcn.inst[j].external.data0 = SOC15_REG_OFFSET(VCN, j, mmUVD_GPCOM_VCPU_DATA0);
>> -		adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
>> -		adev->vcn.inst[j].external.data1 = SOC15_REG_OFFSET(VCN, j, mmUVD_GPCOM_VCPU_DATA1);
>> -		adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
>> -		adev->vcn.inst[j].external.cmd = SOC15_REG_OFFSET(VCN, j, mmUVD_GPCOM_VCPU_CMD);
>> -		adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
>> -		adev->vcn.inst[j].external.nop = SOC15_REG_OFFSET(VCN, j, mmUVD_NO_OP);
>> -
>> -		ring = &adev->vcn.inst[j].ring_dec;
>> +	if (adev->vcn.harvest_config & (1 << inst))
>> +		goto done;
>> +	adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
>> +	adev->vcn.internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
>> +	adev->vcn.internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
>> +	adev->vcn.internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
>> +	adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
>> +	adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
>> +
>> +	adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
>> +	adev->vcn.inst[inst].external.scratch9 = SOC15_REG_OFFSET(VCN, inst, mmUVD_SCRATCH9);
>> +	adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
>> +	adev->vcn.inst[inst].external.data0 = SOC15_REG_OFFSET(VCN, inst, mmUVD_GPCOM_VCPU_DATA0);
>> +	adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
>> +	adev->vcn.inst[inst].external.data1 = SOC15_REG_OFFSET(VCN, inst, mmUVD_GPCOM_VCPU_DATA1);
>> +	adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
>> +	adev->vcn.inst[inst].external.cmd = SOC15_REG_OFFSET(VCN, inst, mmUVD_GPCOM_VCPU_CMD);
>> +	adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
>> +	adev->vcn.inst[inst].external.nop = SOC15_REG_OFFSET(VCN, inst, mmUVD_NO_OP);
>> +
>> +	ring = &adev->vcn.inst[inst].ring_dec;
>> +	ring->use_doorbell = true;
>> +
>> +	ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
>> +			(amdgpu_sriov_vf(adev) ? 2*inst : 8*inst);
>> +
>> +	if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(2, 5, 0))
>> +		ring->vm_hub = AMDGPU_MMHUB1(0);
>> +	else
>> +		ring->vm_hub = AMDGPU_MMHUB0(0);
>> +
>> +	sprintf(ring->name, "vcn_dec_%d", inst);
>> +	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq,
>> +				 0, AMDGPU_RING_PRIO_DEFAULT, NULL);
>> +	if (r)
>> +		return r;
>> +
>> +	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>> +		enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(i);
>> +
>> +		ring = &adev->vcn.inst[inst].ring_enc[i];
>>   		ring->use_doorbell = true;
>>   
>>   		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
>> -				(amdgpu_sriov_vf(adev) ? 2*j : 8*j);
>> +				(amdgpu_sriov_vf(adev) ? (1 + i + 2*inst) : (2 + i + 8*inst));
>>   
>> -		if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(2, 5, 0))
>> +		if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
>> +			IP_VERSION(2, 5, 0))
>>   			ring->vm_hub = AMDGPU_MMHUB1(0);
>>   		else
>>   			ring->vm_hub = AMDGPU_MMHUB0(0);
>>   
>> -		sprintf(ring->name, "vcn_dec_%d", j);
>> -		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[j].irq,
>> -				     0, AMDGPU_RING_PRIO_DEFAULT, NULL);
>> +		sprintf(ring->name, "vcn_enc_%d.%d", inst, i);
>> +		r = amdgpu_ring_init(adev, ring, 512,
>> +					 &adev->vcn.inst[inst].irq, 0,
>> +					 hw_prio, NULL);
>>   		if (r)
>>   			return r;
>> -
>> -		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>> -			enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(i);
>> -
>> -			ring = &adev->vcn.inst[j].ring_enc[i];
>> -			ring->use_doorbell = true;
>> -
>> -			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
>> -					(amdgpu_sriov_vf(adev) ? (1 + i + 2*j) : (2 + i + 8*j));
>> -
>> -			if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
>> -			    IP_VERSION(2, 5, 0))
>> -				ring->vm_hub = AMDGPU_MMHUB1(0);
>> -			else
>> -				ring->vm_hub = AMDGPU_MMHUB0(0);
>> -
>> -			sprintf(ring->name, "vcn_enc_%d.%d", j, i);
>> -			r = amdgpu_ring_init(adev, ring, 512,
>> -					     &adev->vcn.inst[j].irq, 0,
>> -					     hw_prio, NULL);
>> -			if (r)
>> -				return r;
>> -		}
>> -
>> -		fw_shared = adev->vcn.inst[j].fw_shared.cpu_addr;
>> -		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
>> -
>> -		if (amdgpu_vcnfw_log)
>> -			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
>>   	}
>>   
>> +	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
>> +	fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
>> +
>> +	if (amdgpu_vcnfw_log)
>> +		amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
>> +done:
>>   	if (amdgpu_sriov_vf(adev)) {
>>   		r = amdgpu_virt_alloc_mm_table(adev);
>>   		if (r)
>> @@ -1005,197 +1002,192 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>>   	return 0;
>>   }
>>   
>> -static int vcn_v2_5_start(struct amdgpu_device *adev)
>> +static int vcn_v2_5_start(struct amdgpu_device *adev, unsigned int inst)
>>   {
>>   	struct amdgpu_ring *ring;
>>   	uint32_t rb_bufsz, tmp;
>> -	int i, j, k, r;
>> +	int j, k, r;
>>   
>> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> -		if (adev->pm.dpm_enabled)
>> -			amdgpu_dpm_enable_vcn(adev, true, i);
>> -	}
>> -
>> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> -		if (adev->vcn.harvest_config & (1 << i))
>> -			continue;
>> -		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>> -			r = vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
>> -			continue;
>> -		}
>> +	if (adev->pm.dpm_enabled)
>> +		amdgpu_dpm_enable_vcn(adev, true, inst);
>>   
>> -		/* disable register anti-hang mechanism */
>> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
>> -			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>> +	if (adev->vcn.harvest_config & (1 << inst))
>> +		return 0;
>>   
>> -		/* set uvd status busy */
>> -		tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
>> -		WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
>> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>> +		r = vcn_v2_5_start_dpg_mode(adev, inst, adev->vcn.indirect_sram);
>> +		return r;
>>   	}
>>   
>> +	/* disable register anti-hang mechanism */
>> +	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_POWER_STATUS), 0,
>> +		~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>> +
>> +	/* set uvd status busy */
>> +	tmp = RREG32_SOC15(VCN, inst, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
>> +	WREG32_SOC15(VCN, inst, mmUVD_STATUS, tmp);
>> +
>>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
>>   		return 0;
>>   
>>   	/*SW clock gating */
>>   	vcn_v2_5_disable_clock_gating(adev);
>>   
>> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> -		if (adev->vcn.harvest_config & (1 << i))
>> -			continue;
>> -		/* enable VCPU clock */
>> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
>> -			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
>> -
>> -		/* disable master interrupt */
>> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
>> -			~UVD_MASTINT_EN__VCPU_EN_MASK);
>> -
>> -		/* setup mmUVD_LMI_CTRL */
>> -		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
>> -		tmp &= ~0xff;
>> -		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp | 0x8|
>> -			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
>> -			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
>> -			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
>> -			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
>> -
>> -		/* setup mmUVD_MPC_CNTL */
>> -		tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
>> -		tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
>> -		tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
>> -		WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
>> -
>> -		/* setup UVD_MPC_SET_MUXA0 */
>> -		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
>> -			((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
>> -			(0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
>> -			(0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
>> -			(0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
>> -
>> -		/* setup UVD_MPC_SET_MUXB0 */
>> -		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
>> -			((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
>> -			(0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
>> -			(0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
>> -			(0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
>> -
>> -		/* setup mmUVD_MPC_SET_MUX */
>> -		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
>> -			((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
>> -			(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>> -			(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
>> -	}
>> +	if (adev->vcn.harvest_config & (1 << inst))
>> +		return 0;
>> +
>> +	/* enable VCPU clock */
>> +	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
>> +		UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
>> +
>> +	/* disable master interrupt */
>> +	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN), 0,
>> +		~UVD_MASTINT_EN__VCPU_EN_MASK);
>> +
>> +	/* setup mmUVD_LMI_CTRL */
>> +	tmp = RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL);
>> +	tmp &= ~0xff;
>> +	WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL, tmp | 0x8|
>> +		UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
>> +		UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
>> +		UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
>> +		UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
>> +
>> +	/* setup mmUVD_MPC_CNTL */
>> +	tmp = RREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL);
>> +	tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
>> +	tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
>> +	WREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL, tmp);
>> +
>> +	/* setup UVD_MPC_SET_MUXA0 */
>> +	WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXA0,
>> +		((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
>> +		(0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
>> +		(0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
>> +		(0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
>> +
>> +	/* setup UVD_MPC_SET_MUXB0 */
>> +	WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXB0,
>> +		((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
>> +		(0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
>> +		(0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
>> +		(0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
>> +
>> +	/* setup mmUVD_MPC_SET_MUX */
>> +	WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUX,
>> +		((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
>> +		(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>> +		(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
>>   
>>   	vcn_v2_5_mc_resume(adev);
>>   
>> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> -		volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>> -		if (adev->vcn.harvest_config & (1 << i))
>> -			continue;
>> -		/* VCN global tiling registers */
>> -		WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
>> -			adev->gfx.config.gb_addr_config);
>> -		WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
>> -			adev->gfx.config.gb_addr_config);
>> +	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
>> +	if (adev->vcn.harvest_config & (1 << inst))
>> +		return 0;
>> +
>> +	/* VCN global tiling registers */
>> +	WREG32_SOC15(VCN, inst, mmUVD_GFX8_ADDR_CONFIG,
>> +		adev->gfx.config.gb_addr_config);
>> +	WREG32_SOC15(VCN, inst, mmUVD_GFX8_ADDR_CONFIG,
>> +		adev->gfx.config.gb_addr_config);
>>   
>> -		/* enable LMI MC and UMC channels */
>> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
>> -			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
>> +	/* enable LMI MC and UMC channels */
>> +	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_LMI_CTRL2), 0,
>> +		~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
>>   
>> -		/* unblock VCPU register access */
>> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
>> -			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>> +	/* unblock VCPU register access */
>> +	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL), 0,
>> +		~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>>   
>> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
>> -			~UVD_VCPU_CNTL__BLK_RST_MASK);
>> +	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
>> +		~UVD_VCPU_CNTL__BLK_RST_MASK);
>>   
>> -		for (k = 0; k < 10; ++k) {
>> -			uint32_t status;
>> -
>> -			for (j = 0; j < 100; ++j) {
>> -				status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
>> -				if (status & 2)
>> -					break;
>> -				if (amdgpu_emu_mode == 1)
>> -					msleep(500);
>> -				else
>> -					mdelay(10);
>> -			}
>> -			r = 0;
>> +	for (k = 0; k < 10; ++k) {
>> +		uint32_t status;
>> +
>> +		for (j = 0; j < 100; ++j) {
>> +			status = RREG32_SOC15(VCN, inst, mmUVD_STATUS);
>>   			if (status & 2)
>>   				break;
>> +			if (amdgpu_emu_mode == 1)
>> +				msleep(500);
>> +			else
>> +				mdelay(10);
>> +		}
>> +		r = 0;
>> +		if (status & 2)
>> +			break;
>>   
>> -			DRM_ERROR("VCN decode not responding, trying to reset the VCPU!!!\n");
>> -			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
>> -				UVD_VCPU_CNTL__BLK_RST_MASK,
>> -				~UVD_VCPU_CNTL__BLK_RST_MASK);
>> -			mdelay(10);
>> -			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
>> -				~UVD_VCPU_CNTL__BLK_RST_MASK);
>> +		DRM_ERROR("VCN decode not responding, trying to reset the VCPU!!!\n");
>> +		WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
>> +			UVD_VCPU_CNTL__BLK_RST_MASK,
>> +			~UVD_VCPU_CNTL__BLK_RST_MASK);
>> +		mdelay(10);
>> +		WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
>> +			~UVD_VCPU_CNTL__BLK_RST_MASK);
>>   
>> -			mdelay(10);
>> -			r = -1;
>> -		}
>> +		mdelay(10);
>> +		r = -1;
>> +	}
>>   
>> -		if (r) {
>> -			DRM_ERROR("VCN decode not responding, giving up!!!\n");
>> -			return r;
>> -		}
>> +	if (r) {
>> +		DRM_ERROR("VCN decode not responding, giving up!!!\n");
>> +		return r;
>> +	}
>>   
>> -		/* enable master interrupt */
>> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
>> -			UVD_MASTINT_EN__VCPU_EN_MASK,
>> -			~UVD_MASTINT_EN__VCPU_EN_MASK);
>> +	/* enable master interrupt */
>> +	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN),
>> +		UVD_MASTINT_EN__VCPU_EN_MASK,
>> +		~UVD_MASTINT_EN__VCPU_EN_MASK);
>>   
>> -		/* clear the busy bit of VCN_STATUS */
>> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
>> -			~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
>> +	/* clear the busy bit of VCN_STATUS */
>> +	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_STATUS), 0,
>> +		~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
>>   
>> -		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
>> +	WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_VMID, 0);
>>   
>> -		ring = &adev->vcn.inst[i].ring_dec;
>> -		/* force RBC into idle state */
>> -		rb_bufsz = order_base_2(ring->ring_size);
>> -		tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
>> -		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
>> -		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
>> -		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
>> -		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
>> -		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
>> +	ring = &adev->vcn.inst[inst].ring_dec;
>> +	/* force RBC into idle state */
>> +	rb_bufsz = order_base_2(ring->ring_size);
>> +	tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
>> +	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
>> +	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
>> +	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
>> +	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
>> +	WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_CNTL, tmp);
>>   
>> -		fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
>> -		/* program the RB_BASE for ring buffer */
>> -		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
>> -			lower_32_bits(ring->gpu_addr));
>> -		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
>> -			upper_32_bits(ring->gpu_addr));
>> +	fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
>> +	/* program the RB_BASE for ring buffer */
>> +	WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
>> +		lower_32_bits(ring->gpu_addr));
>> +	WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
>> +		upper_32_bits(ring->gpu_addr));
>>   
>> -		/* Initialize the ring buffer's read and write pointers */
>> -		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
>> +	/* Initialize the ring buffer's read and write pointers */
>> +	WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR, 0);
>>   
>> -		ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
>> -		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
>> -				lower_32_bits(ring->wptr));
>> -		fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
>> +	ring->wptr = RREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR);
>> +	WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_WPTR,
>> +			lower_32_bits(ring->wptr));
>> +	fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
>>   
>> -		fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
>> -		ring = &adev->vcn.inst[i].ring_enc[0];
>> -		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
>> -		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
>> -		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
>> -		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
>> -		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
>> -		fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
>> -
>> -		fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
>> -		ring = &adev->vcn.inst[i].ring_enc[1];
>> -		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
>> -		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
>> -		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
>> -		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
>> -		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
>> -		fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
>> -	}
>> +	fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
>> +	ring = &adev->vcn.inst[inst].ring_enc[0];
>> +	WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
>> +	WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
>> +	WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO, ring->gpu_addr);
>> +	WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
>> +	WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE, ring->ring_size / 4);
>> +	fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
>> +
>> +	fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
>> +	ring = &adev->vcn.inst[inst].ring_enc[1];
>> +	WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
>> +	WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
>> +	WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO2, ring->gpu_addr);
>> +	WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
>> +	WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE2, ring->ring_size / 4);
>> +	fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
>>   
>>   	return 0;
>>   }
>> @@ -1424,72 +1416,69 @@ static int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>>   	return 0;
>>   }
>>   
>> -static int vcn_v2_5_stop(struct amdgpu_device *adev)
>> +static int vcn_v2_5_stop(struct amdgpu_device *adev, unsigned int inst)
>>   {
>>   	uint32_t tmp;
>> -	int i, r = 0;
>> +	int r = 0;
>>   
>> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> -		if (adev->vcn.harvest_config & (1 << i))
>> -			continue;
>> -		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>> -			r = vcn_v2_5_stop_dpg_mode(adev, i);
>> -			continue;
>> -		}
>> +	if (adev->vcn.harvest_config & (1 << inst))
>> +		goto done;
>>   
>> -		/* wait for vcn idle */
>> -		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
>> -		if (r)
>> -			return r;
>> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>> +		r = vcn_v2_5_stop_dpg_mode(adev, inst);
>> +		goto done;
>> +	}
>>   
>> -		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
>> -			UVD_LMI_STATUS__READ_CLEAN_MASK |
>> -			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
>> -			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
>> -		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
>> -		if (r)
>> -			return r;
>> +	/* wait for vcn idle */
>> +	r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
>> +	if (r)
>> +		return r;
>>   
>> -		/* block LMI UMC channel */
>> -		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
>> -		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
>> -		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
>> +	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
>> +		UVD_LMI_STATUS__READ_CLEAN_MASK |
>> +		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
>> +		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
>> +	r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp, tmp);
>> +	if (r)
>> +		return r;
>>   
>> -		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
>> -			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
>> -		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
>> -		if (r)
>> -			return r;
>> +	/* block LMI UMC channel */
>> +	tmp = RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2);
>> +	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
>> +	WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2, tmp);
>>   
>> -		/* block VCPU register access */
>> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
>> -			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
>> -			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>> +	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
>> +		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
>> +	r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp, tmp);
>> +	if (r)
>> +		return r;
>>   
>> -		/* reset VCPU */
>> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
>> -			UVD_VCPU_CNTL__BLK_RST_MASK,
>> -			~UVD_VCPU_CNTL__BLK_RST_MASK);
>> +	/* block VCPU register access */
>> +	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL),
>> +		UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
>> +		~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>>   
>> -		/* disable VCPU clock */
>> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
>> -			~(UVD_VCPU_CNTL__CLK_EN_MASK));
>> +	/* reset VCPU */
>> +	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
>> +		UVD_VCPU_CNTL__BLK_RST_MASK,
>> +		~UVD_VCPU_CNTL__BLK_RST_MASK);
>>   
>> -		/* clear status */
>> -		WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
>> +	/* disable VCPU clock */
>> +	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
>> +		~(UVD_VCPU_CNTL__CLK_EN_MASK));
>>   
>> -		vcn_v2_5_enable_clock_gating(adev);
>> +	/* clear status */
>> +	WREG32_SOC15(VCN, inst, mmUVD_STATUS, 0);
>>   
>> -		/* enable register anti-hang mechanism */
>> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS),
>> -			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
>> -			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>> -	}
>> +	vcn_v2_5_enable_clock_gating(adev);
>>   
>> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> -		if (adev->pm.dpm_enabled)
>> -			amdgpu_dpm_enable_vcn(adev, false, i);
>> -	}
>> +	/* enable register anti-hang mechanism */
>> +	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_POWER_STATUS),
>> +		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
>> +		~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>> +done:
>> +	if (adev->pm.dpm_enabled)
>> +		amdgpu_dpm_enable_vcn(adev, false, inst);
>>   
>>   	return 0;
>>   }
>> @@ -1838,9 +1827,9 @@ static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
>>   		return 0;
>>   
>>   	if (state == AMD_PG_STATE_GATE)
>> -		ret = vcn_v2_5_stop(adev);
>> +		ret = vcn_v2_5_stop(adev, inst);
>>   	else
>> -		ret = vcn_v2_5_start(adev);
>> +		ret = vcn_v2_5_start(adev, inst);
>>   
>>   	if (!ret)
>>   		adev->vcn.cur_state[inst] = state;
