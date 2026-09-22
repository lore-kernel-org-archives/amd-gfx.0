Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305B1C982FA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 15:10:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE26A10ED42;
	Tue, 22 Sep 2026 15:10:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nrgt5trr";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011007.outbound.protection.outlook.com
 [40.93.194.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 111F810ED42
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 15:10:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfOc9gwaBdsojytMi+H6T4E3LLXX5ksxcnZdvivKcYWs/B15qNvPlbAxqIme/f7obVMsC2bPcZKWl73mibZjQmM4slTJianjSb6X4fMQuHpTx4/KrOafDYP/Ca062C9pRTXoUKBQVIy+y0cqt+p9DWwDd6x4NxgrmDMe41Y9nT2clcb8yYMFlQNFlKlG2q6ssDcDhRj/cEA/Mh2iWnkzfbNWmx4mHzGKIP017I932MqeAQcjGmdsnHnDdmuQT7dzFLcuIqDhZO7LESCTWPc5JlGeJ4aFO0kf0F2UF+qcTHtnmz7ASpbDwXnWr2sVjp2s/LVxqqJXglAjV99obN5Mng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9QLUI4vLiCvEaF67C8Td87i9F0r0L//AYY/HmDVcq8=;
 b=Wk4BvgWLVk/RFubvPF+/9UCvACamwdJzEPpXCe5P0rpRBHdt8odTzNBTgAho7d4FcWEp7as7hD8tuDYY5JOrEY5v1i9CpiAd5l/Sg+Dny4cNXHx5TU4pVRZ1klqJQECh9gZgriV6Loi0bspQ7FCvFKE+YziKaYSgd1zqxIlYTb8nQae8XaA/SC5dm4wBKxBmT15lCblDWR+/TDWe5EjFj+zpZRjmlREH6HKZZj1aRCz1DwCnDVnJTxEwJgFPT/TO1hDa0a1xjTY8HyvkYoxGlF8EMjbyU9YQ13eCiJiNvoj4Csv5Cmmk5tZIj0oRU1oYaIxnimIkRPkP0EiL6vwzaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9QLUI4vLiCvEaF67C8Td87i9F0r0L//AYY/HmDVcq8=;
 b=nrgt5trrjRPJeXgi6A0hg0elx+1mmGAslQ8v0YduMDDpHXxhaknoV3kNnOZYbRUXV0xObUB2CcMUcf1wGdb+XeGHYj4M4hl4EVZugUA1yje3wFGgimocVDMjGphPGbMripXu7dk03x3ebablqcSgSuG+iFH+uAdXW5z90rXl414=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Tue, 22 Sep
 2026 15:10:24 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422%3]) with mapi id 15.21.0406.007; Tue, 22 Sep 2026
 15:10:24 +0000
Message-ID: <526f559b-cb01-425d-9ae6-831d8bd2c229@amd.com>
Date: Tue, 22 Sep 2026 11:10:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] drm/amdgpu: add amdgpu_xcp_get_xcc_mask helper
To: "Lazar, Lijo" <lijo.lazar@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, Bing.Ma@amd.com
References: <20260921200313.865829-1-James.Zhu@amd.com>
 <20260921200313.865829-4-James.Zhu@amd.com>
 <8f06398f-e207-45b0-ab85-931ccac35b65@amd.com>
 <ce3dbd30-31e6-4680-8618-2144fe44a928@amd.com>
 <0e573608-7f9e-4f3e-ac58-cf375962ae2b@amd.com>
 <c9cd0934-25ca-4d14-99c1-cc7aa3d566c8@amd.com>
 <8fc9ee70-d284-4ef3-9e66-08d809fac293@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <8fc9ee70-d284-4ef3-9e66-08d809fac293@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::35) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|DM6PR12MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: 37d2d411-c6c2-4cf6-38f9-08df18bba061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|3023799007|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Z0IuYMwLcIB6FUr2D/M/7ZJ2I790BvgbLjWltTo1LkdUkWT7o6KWjv/nlIeeWDJzYL33taPYwO1/U1Mzqh0Iu9cPcp9/h5pYPM6Oiiba75Ip2H6Bt+VH9PBo6nj5R6pXPygQ6C+DWuOcDkdySlsqVngW2TLg4i8Y1MZTIHvvET6/WPaAsB5BwsIyPYd8ZlIHgSgC7HADhPs+LSa7znh4mwDX2jnA8ZHtz8I6t597bR30IXGbn0IWBoy6NgfmyDM/bMbGR6pOHvzCgJzCXnPabXRgr+z4Favem4RiQgIEQiMxjkuZmOaBtiWp9ylycBxlJ7vBQFy8hKMai2l3fmaw9MsX39F7JsQyOvnOhJTldQ1p1waSRCGZTUUMsn0T4Ss1+Nn49LsID9rRIs4H3VKUV5NH6Gxebof/1j9lVwaVx3HS0phWbGrtFutDah2iM/mVuwuuhx5HUgGsg7S4QhnvcFsfvue8kus9navfOGNtQsM4r+kKvQAEGyO0szrESf4CrhjD2UhVcOybHFyK01Ix4Uqw/q2qrhIauNu9emAOYNhmd06VjgYdqNcy9OYOwjwhIT9nncaPHjNwd1Sy2UHtauC20pZt60iTvai/GiqlR/Y5fE/9Wlmlf/baiyIf+DaJsNKE5rFAaq7ywSIM2SL50IKpTcUfwJT+yLccX1SWAAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(3023799007)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2ZrSDdub1ExM0dKZ21iSWwyS1FpRVV6cXFRWVlaZmtmc3VLU01uK2RHaWd5?=
 =?utf-8?B?VXVHdDIvWEVYUEU1OHg2Mm9nYm1Ebmxqb2ZkMTNTcUEyQldGNGdGd1RWR3dx?=
 =?utf-8?B?enBwZ1VMOHRLcDJGQ3FUWDNwbzAvQm5KOCs1UzNEVVUwdzhvWXpERkpac1k2?=
 =?utf-8?B?Y2RpWjZGTDdSa2ZhMDdpc1NzS3NNSE92bTROOUtlSjAvZHduajZ6QVFCQnc2?=
 =?utf-8?B?bHFXQmI2ekE5aUFlRVJNUGVnQm05Vk9zeXF0RnJFaUVBYmtnekFPUmdrNUhF?=
 =?utf-8?B?aDV6V1lZS2xnS25oSDRTTHl0bU5uYnBiMjlrUjJjS1N3QTdTUDdhdE94NjlQ?=
 =?utf-8?B?M1dSYjVNSDVPTGh3cUFrc3NFTElGNWhIdVp5VkdYdVpQeEFLRFBJVkJzZlVU?=
 =?utf-8?B?OUZQVEZtMVBLZkVINm44VThWYU1Ib3Y3c2Z1SGVEcmpZUUxMbWRuUUM0eUN1?=
 =?utf-8?B?ZHBRc1h4M3VjU1NPM290QzNVbC9rUm1vTFh5aVM3d1M2WUdoamRlY3IvWmJX?=
 =?utf-8?B?RG9pOWQxajZhWVFsUUFMaUdGODNOTm1pSVcycW82clp0RDFtNHlPV29rcFFu?=
 =?utf-8?B?MVRaa2I1QlBZS3hUYktobWRNdFFsRjl3VCt1R1JTbUswNWJJTXlFeWFZR2hI?=
 =?utf-8?B?d0kvZS9WWTdTTXpQU2NOTXMvSVpyK1hXRmhwQ1FjUjAvZWRzNFozRUVmRnor?=
 =?utf-8?B?VlgwamVIMWtPYTFjbC90cWd5UmZQOUUwZURhdi8zcTk5dFpJZVM4RkhyYStX?=
 =?utf-8?B?UjM3TWZQV04xRjhnMHVsMTdGZDZFM0RxdWJkUUJEL1gvTkhOVlNXYnhFeE1o?=
 =?utf-8?B?ZkhpOW93L0FjTHNHd21ObHdBNzlSaENNQVBLaVdJOTZoZjNKcnkvcXV5SmUw?=
 =?utf-8?B?OW9MRVlNb0VYMG1acXJLc3NUY2JteFZ3Nm1NeTFON1BYTUpxa2lJT25FblNQ?=
 =?utf-8?B?dFZSbzJrcUozUGZUbU9WczVDdU85dkVkYUJVRzdkRWc1UTgwRHdtaHN2aTQy?=
 =?utf-8?B?THptLzhTcXFCMVFTeVhFS1B2UnJXSjVMVFp2VWcyMmtPd0xUOXFKNHdTUHBX?=
 =?utf-8?B?aFdBQWpLS1VrNW9lMUdCeWNtNUhISzgyNjVZMmh2UEwzbnpPVGpzZXIxMTZm?=
 =?utf-8?B?enBuZzNTSTNZSXJCV0FxMkE4MkJYNUtLWDB0blN5MVVJZDlRYnRmaEhsZTVW?=
 =?utf-8?B?TlJQV0RxdDJtL214UWRFVjBlSEJJYytxNnJSYW9KUnR5b1pWSVdibTJDSVpD?=
 =?utf-8?B?Z0JINzNLRVI1NnV4S2FrdUJmMTRyMmEvdWhvSXREWWV3Q01MU0htUkRUNEl6?=
 =?utf-8?B?M1JuMUdRZ29wVTFPYXQyMjBRY05YcDRXMGtpcUJFTFpIOERVT04yaHRGenV2?=
 =?utf-8?B?bXNuaU13Nlk0RjF4Y0ZyOUtvNjdYaGlRVERrWTduc09meW5HaDNVcmN0NXN5?=
 =?utf-8?B?T2dnZEpxMnRJNU1JTGVBYy82Ly84bkp5Z3N0UXhld1hxaE9UVTlocHVza2xC?=
 =?utf-8?B?MkIzVHd3M0dUUUJjaFRaZTBBVEhXRlBZNWpKWWVmTy9KcEltaGx6MTZoYlZn?=
 =?utf-8?B?eUxXd3BNTnk1SnJEbGFWWVdBdldpOFBoU0J5a2tMQWRiVXk2QW9GdGFFQW5U?=
 =?utf-8?B?U3plaUZpVGxkT2FHaGdjaEVFYnJSeWx4NzBtZmV6dnNpNGtPTzAyQjhDZnQ3?=
 =?utf-8?B?L0h6SytzOGQzdU5mcElVd0h3NmtiVGlvblRwZmRlSVI2Y2RHUis0Y3lybXJa?=
 =?utf-8?B?NitXeTVYc0ZpMFVsS2tXTytmQmlGbDFZY0Vad0hVVGlONVMxaUVyVEwzbGF3?=
 =?utf-8?B?cGNaRU9Gb2F0VlFLN2JSeU9VL1ZUN1FEb1YvQmdUOFlNRGpRYUdmdm5qdmx0?=
 =?utf-8?B?QUlNUHVYa0dOdXFOdHB6NkkzWUVUVkpCVGI3RlpQNVkxUXBmd0xndnJqRDh0?=
 =?utf-8?B?RTZBbWg0eVh4Z21DSzF6RWdnWHFjcTIzNk5EcWpSWTJ4SkRNMXNRSXlFN1Zu?=
 =?utf-8?B?QzVkREJObEhNbGVoRlp6RlhBSUNhRzl6R1JjN2w4OVhZTnAzdUtjcG5OenhO?=
 =?utf-8?B?VytzZGxVSjdFT0wzbVM3WlVuMzNUdXd2UDhxMGZ3dmhRNTFSWFd4T3lZQWNN?=
 =?utf-8?B?M3FCdHB4YnNGNDlNNmZLZHJtNUFUV1hhbEZkVmdRMk5ZVXMwUnJHTHB3WlFk?=
 =?utf-8?B?U1EzcFZ4TFNFSGd6L1JRdFlrV1Y0cEIyK2NobnI2WnFEQUozN2JXT3daQ1Ru?=
 =?utf-8?B?cC9pY0FjQ3d2Qm9DaGJXeURmZTZ1RlNqeU9Xa2RtMjluemFLR21LR0VacS9O?=
 =?utf-8?Q?IDfn4jC2gUbUhyIZim?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d2d411-c6c2-4cf6-38f9-08df18bba061
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 15:10:24.1199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5wq88+feHy7tbQ0speFWvuS4bquDrLVjGdVbf/mjt2KWoRZBYZOCK8sf4Gl52p6w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043
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


On 2026-09-22 10:26, Lazar, Lijo wrote:
>
>
> On 22-Sep-26 7:41 PM, James Zhu wrote:
>>
>> On 2026-09-22 09:45, Lazar, Lijo wrote:
>>>
>>>
>>> On 22-Sep-26 7:05 PM, James Zhu wrote:
>>>>
>>>> On 2026-09-22 01:22, Lazar, Lijo wrote:
>>>>>
>>>>>
>>>>> On 22-Sep-26 1:33 AM, James Zhu wrote:
>>>>>> Add amdgpu_xcp_get_xcc_mask() to return the XCC instance mask for 
>>>>>> a given
>>>>>> XCP partition. This is needed by upcoming SPM (Stream Performance 
>>>>>> Monitor)
>>>>>> support, which programs hardware per partition and must operate 
>>>>>> only on
>>>>>> the XCCs that belong to a given XCP.
>>>>>>
>>>>>> For partitioned systems the helper returns only the XCCs 
>>>>>> belonging to the
>>>>>> specified XCP. When @xcp_id is AMDGPU_XCP_NO_PARTITION (or the 
>>>>>> device is
>>>>>> not partitioned) it returns the device's full XCC mask (e.g. 0xFF 
>>>>>> for an
>>>>>> 8-XCC device). Note that the full device mask is returned even on a
>>>>>> partitioned device; callers that require partition isolation 
>>>>>> (e.g. SPM)
>>>>>> must reject AMDGPU_XCP_NO_PARTITION on a partitioned device 
>>>>>> themselves.
>>>>>>
>>>>>
>>>>> Could you clarifiy on this part - xcp_id = AMDGPU_XCP_NO_PARTITION 
>>>>> usage on 8-XCC device?
>>>>>
>>>>> The default state on a multi-XCC device after driver load is all 
>>>>> XCCs in a single partition called SPX. It should have at least one 
>>>>> partition valid.
>>>>
>>>> [JZ] Yes, 8-XCC device should not reach AMDGPU_XCP_NO_PARTITION case.
>>>>
>>>> the if(!xcp_mgr ||xcp_id ==AMDGPU_XCP_NO_PARTITION) mainly covers 
>>>> non partition device, I can remove the above comments which don't 
>>>> reflect the source accurately.
>>>
>>> Then I'm not sure what issue this is fixing.
>>>
>>> Multi-xcc devices will be in SPX mode and will return a mask with 
>>> all the XCCs. Non-multi xcc devices are expected to have this set to 
>>> 1 anyway to reflect that a single GC is present always.
>> [JZ] Just realized a Fixes tag is added. I think somehow AI review 
>> added it, and I did not check properly, is should be removed also. 
>> Sorry for this confusing!
>
> I see that it also added an external function like this -
>
> amdgpu_xcp_get_xcc_mask
>
> The expectation is any IP instance mask within a partition needs to 
> obtained through - amdgpu_xcp_get_inst_details
>
> Also, amdgpu_xcp_get_xcc_mask provides this which is not correct -
>
> *xcc_mask = adev->gfx.xcc_mask
>
> xcp instance mask operates only return logical mask of instances 
> present (xcc_mask could include disabled ones also).
[JZ] Here is only for non-partition device. I think adev->gfx.xcc_mask=0x1.
I can change it to below code to clear the confusing

*xcc_mask = BIT(0);

How Do you think?
Thanks!

James

>
> Thanks,
> Lijo
>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>>> Thanks,
>>>>> Lioj
>>>>>
>>>>>> amdgpu_xcp_get_num_xcc() is reworked to take (adev, xcp_id) and 
>>>>>> derive the
>>>>>> count from this helper via hweight32(). The helper is defined out 
>>>>>> of line
>>>>>> in amdgpu_xcp.c so that the static inline in amdgpu_xcp.h never 
>>>>>> has to
>>>>>> dereference the (incomplete) struct amdgpu_device; it only passes 
>>>>>> the
>>>>>> pointer through.
>>>>>>
>>>>>> This is a user-visible change: amdgpu_xcp_get_num_xcc() previously
>>>>>> returned 1 for non-partitioned systems (and for 
>>>>>> AMDGPU_XCP_NO_PARTITION),
>>>>>> and now returns the actual XCC count (e.g. 8 for an 8-XCC 
>>>>>> device). CWSR
>>>>>> callers (amdgpu_kms.c, amdgpu_userq.c, mes_userqueue.c) scale the 
>>>>>> per-XCC
>>>>>> control-stack and debug-memory sizes by num_xcc, so the uAPI-visible
>>>>>> ctl_stack_size and dbg_mem_size values grow accordingly to match the
>>>>>> actual hardware resource requirements, which were previously 
>>>>>> undersized.
>>>>>>
>>>>>> Fixes: 4cd417bfec49 ("drm/amdgpu: Add helper function to get xcc 
>>>>>> count")
>>>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>>>> Reviewed-by: Bing Ma <bing.ma@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  2 +-
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  2 +-
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 48 
>>>>>> +++++++++++++++++ +++++
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    | 32 +++++++--------
>>>>>>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  3 +-
>>>>>>   5 files changed, 66 insertions(+), 21 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c 
>>>>>> b/drivers/gpu/ drm/amd/amdgpu/amdgpu_kms.c
>>>>>> index 57fa69c0382d..7782ccd4d28f 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>>>> @@ -1501,7 +1501,7 @@ int amdgpu_info_ioctl(struct drm_device 
>>>>>> *dev, void *data, struct drm_file *filp)
>>>>>>           fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
>>>>>>           if (!amdgpu_trap_is_enabled(adev) || !fpriv->trap_obj)
>>>>>>               return -EOPNOTSUPP;
>>>>>> -        num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv- 
>>>>>> >xcp_id);
>>>>>> +        num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>>>>>>           cwsr_info.ctl_stack_size =
>>>>>> adev->trap_info->cwsr.xcc_ctl_stack_sz * num_xcc;
>>>>>>           cwsr_info.dbg_mem_size =
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/ 
>>>>>> gpu/ drm/amd/amdgpu/amdgpu_userq.c
>>>>>> index db09e879b85e..d19af9cb6ee1 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>> @@ -258,7 +258,7 @@ int 
>>>>>> amdgpu_userq_input_trap_params_validate(struct 
>>>>>> amdgpu_usermode_queue *queue,
>>>>>>       int num_xcc;
>>>>>>       int r;
>>>>>>   -    num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, 
>>>>>> fpriv->xcp_id);
>>>>>> +    num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>>>>>>       r = amdgpu_trap_validate_params(queue->userq_mgr->adev, 
>>>>>> trap_params,
>>>>>>                       num_xcc);
>>>>>>       if (r)
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c 
>>>>>> b/drivers/gpu/ drm/amd/amdgpu/amdgpu_xcp.c
>>>>>> index 2a56f5ec9c76..90846d55292b 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>>>>> @@ -390,6 +390,54 @@ int amdgpu_xcp_get_inst_details(struct 
>>>>>> amdgpu_xcp *xcp,
>>>>>>       return 0;
>>>>>>   }
>>>>>>   +/**
>>>>>> + * amdgpu_xcp_get_xcc_mask - Get XCC instance mask for a partition
>>>>>> + * @adev: amdgpu device pointer
>>>>>> + * @xcp_id: XCP partition ID
>>>>>> + * @xcc_mask: output parameter for XCC instance mask
>>>>>> + *
>>>>>> + * Returns the XCC instance mask for the specified XCP partition.
>>>>>> + * For partitioned systems, returns only the XCCs belonging to 
>>>>>> this XCP.
>>>>>> + *
>>>>>> + * When @xcp_id is AMDGPU_XCP_NO_PARTITION (or the device is not
>>>>>> + * partitioned), the device's full XCC mask is returned (e.g. 
>>>>>> 0xFF for an
>>>>>> + * 8-XCC device). Note that the full device mask is returned 
>>>>>> even on a
>>>>>> + * partitioned device: callers that require partition isolation 
>>>>>> (e.g. SPM)
>>>>>> + * must reject AMDGPU_XCP_NO_PARTITION on a partitioned device 
>>>>>> themselves.
>>>>>> + *
>>>>>> + * Note: On error, xcc_mask is undefined. Callers must check 
>>>>>> return code
>>>>>> + * and only read xcc_mask when return == 0.
>>>>>> + *
>>>>>> + * Return: 0 on success (non-partitioned systems or valid XCP 
>>>>>> found),
>>>>>> + *         -EINVAL if xcc_mask is NULL, no matching XCP id is 
>>>>>> found, or the
>>>>>> + *         partition's GFX IP details are unavailable
>>>>>> + */
>>>>>> +int amdgpu_xcp_get_xcc_mask(struct amdgpu_device *adev, int xcp_id,
>>>>>> +                uint32_t *xcc_mask)
>>>>>> +{
>>>>>> +    struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
>>>>>> +    struct amdgpu_xcp *xcp;
>>>>>> +    int i;
>>>>>> +
>>>>>> +    if (!xcc_mask)
>>>>>> +        return -EINVAL;
>>>>>> +
>>>>>> +    if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION) {
>>>>>> +        /* Non-partitioned: return the device's full XCC mask. */
>>>>>> +        *xcc_mask = adev->gfx.xcc_mask;
>>>>>> +        return 0;
>>>>>> +    }
>>>>>> +
>>>>>> +    /* Partitioned system: get this XCP's XCCs */
>>>>>> +    for_each_xcp(xcp_mgr, xcp, i) {
>>>>>> +        if (xcp->id == xcp_id)
>>>>>> +            return amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX,
>>>>>> +                               xcc_mask);
>>>>>> +    }
>>>>>> +
>>>>>> +    return -EINVAL;
>>>>>> +}
>>>>>> +
>>>>>>   int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
>>>>>>               const struct pci_device_id *ent)
>>>>>>   {
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h 
>>>>>> b/drivers/gpu/ drm/amd/amdgpu/amdgpu_xcp.h
>>>>>> index 692508be23fb..6eed82ad49b1 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>>>>>> @@ -44,6 +44,7 @@
>>>>>>   #define XCP_INST_MASK(num_inst, xcp_id)        \
>>>>>>       (num_inst ? GENMASK(num_inst - 1, 0) << (xcp_id * num_inst) 
>>>>>> : 0)
>>>>>>   +struct amdgpu_device;
>>>>>>   struct amdgpu_fpriv;
>>>>>>     enum AMDGPU_XCP_IP_BLOCK {
>>>>>> @@ -219,26 +220,23 @@ amdgpu_get_next_xcp(struct amdgpu_xcp_mgr 
>>>>>> *xcp_mgr, int *from)
>>>>>>       for (i = 0, xcp = amdgpu_get_next_xcp(xcp_mgr, &i); xcp; \
>>>>>>            ++i, xcp = amdgpu_get_next_xcp(xcp_mgr, &i))
>>>>>>   -static inline int amdgpu_xcp_get_num_xcc(struct amdgpu_xcp_mgr 
>>>>>> *xcp_mgr,
>>>>>> -                     int xcp_id)
>>>>>> +int amdgpu_xcp_get_xcc_mask(struct amdgpu_device *adev, int xcp_id,
>>>>>> +                uint32_t *xcc_mask);
>>>>>> +
>>>>>> +static inline int amdgpu_xcp_get_num_xcc(struct amdgpu_device 
>>>>>> *adev, int xcp_id)
>>>>>>   {
>>>>>> -    struct amdgpu_xcp *xcp;
>>>>>>       uint32_t xcc_mask;
>>>>>> -    int i, r;
>>>>>> -
>>>>>> -    if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION)
>>>>>> +    int r, count;
>>>>>> +
>>>>>> +    /* Derive the XCC count from the partition's XCC mask (or 
>>>>>> the full
>>>>>> +     * device mask when not partitioned). amdgpu_xcp_get_xcc_mask()
>>>>>> +     * handles both partitioned and non-partitioned cases.
>>>>>> +     */
>>>>>> +    r = amdgpu_xcp_get_xcc_mask(adev, xcp_id, &xcc_mask);
>>>>>> +    if (unlikely(r))
>>>>>>           return 1;
>>>>>> -    for_each_xcp(xcp_mgr, xcp, i) {
>>>>>> -        if (xcp->id == xcp_id) {
>>>>>> -            r = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX,
>>>>>> -                            &xcc_mask);
>>>>>> -            if (unlikely(r))
>>>>>> -                return 1;
>>>>>> -            else
>>>>>> -                return hweight32(xcc_mask);
>>>>>> -        }
>>>>>> -    }
>>>>>>   -    return 1;
>>>>>> +    count = hweight32(xcc_mask);
>>>>>> +    return count ? count : 1;
>>>>>>   }
>>>>>>   #endif
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c 
>>>>>> b/drivers/ gpu/drm/amd/amdgpu/mes_userqueue.c
>>>>>> index 16aa22b25098..1c7b2f3227e5 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>>>>> @@ -503,8 +503,7 @@ static int mes_userq_mqd_create(struct 
>>>>>> amdgpu_usermode_queue *queue,
>>>>>>                   uq_mgr_to_fpriv(queue->userq_mgr);
>>>>>>               int num_xcc;
>>>>>>   -            num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr,
>>>>>> -                             fpriv->xcp_id);
>>>>>> +            num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>>>>>>               trap_params.ctx_save_area_address =
>>>>>>                   compute_mqd->ctx_save_area_va;
>>>>>>               trap_params.cwsr_sz = compute_mqd->ctx_save_area_size;
>>>>>
>>>
>
