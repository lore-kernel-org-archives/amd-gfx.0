Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF3EC982FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 14:26:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E817110E4AC;
	Tue, 22 Sep 2026 14:26:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vqlJ7ZZi";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B78E10ED2E
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 14:26:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FONZUpWfMPW3j1wB5uJotLunF4Gzp1LrmVlCNFcI9QWmbIhu6wqZ95vqV2JVfVjplh0A/PDACbXzdpo7PUazWbIPfbRJ+fAEYLzgsqTHMNZVUbzvywkDEeMm8oDTUBsvAlSppmQ5j6vtArAKWAXz01BAiXWS8iH3gKXYTLMsub/CxiZzpckeIJH+Q0C6AL9msMz8DcSCplCkONw3NuBIyHrRHmZjEZFFCfJhM99ApG32ahBwWt063GcynnuKPFiIniw2z8RqLRXkOfnkuUXWdtsTPtarM7iNC/jX98oBO9eunYJrsrAJKV+uclNtCUbViXwu4J0Eos4jGwvDHHC0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGjS0fOR7dBDBTJ1cyOyxYDRkwVsK9Bnk92fIisoYFI=;
 b=bUYwfv8cmSfn/hY3hABIAs8DFbmYDNLTz6HdDKVujfVtgyPadmpAVQTGbrXQ2P+VK9brPjwT3iimjHuS5aYD9NHrvUKAyeRqqaAhaYB8SEfQbU+D+Hu7FWhlI3pSD0YfOJIgkGqnEswKEKVWkpM7LA77OYbC+++4/0UkVGX4pdgjwUAAaJallxbQ1ykGADBk/YReBFiRIuTqcsvQfVrB0Ba09usJYVh9YzEkMxCwa6QbvSJieuDwrHG+xwV3owmaLF+tZ39hsn9NXTE6xYbLhhc/6BZydvNwSBUPg+VNKfjl1Bi8te66CWKrftjpLPDYdodn+WMMdIo1kIJtqxwg3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGjS0fOR7dBDBTJ1cyOyxYDRkwVsK9Bnk92fIisoYFI=;
 b=vqlJ7ZZiKkXVNfjZ7Rs9kimL1qfE3aIFieJ9sjLOc5tsEvHvS+wDnzf8/rw1tjX29x/T5Tq3QKwo0lcPLBJiG5KSZuos/5WPxpBpI1E8G3RwBYsCyntTFzR45CuH3My1XTcw28zU/67x/G7Mwm3b3uAcRQiAGZJ1M5nLtE+IXEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by MW5PR12MB5650.namprd12.prod.outlook.com (2603:10b6:303:19e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 14:26:21 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%6]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 14:26:20 +0000
Message-ID: <8fc9ee70-d284-4ef3-9e66-08d809fac293@amd.com>
Date: Tue, 22 Sep 2026 19:56:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] drm/amdgpu: add amdgpu_xcp_get_xcc_mask helper
To: James Zhu <jamesz@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, Bing.Ma@amd.com
References: <20260921200313.865829-1-James.Zhu@amd.com>
 <20260921200313.865829-4-James.Zhu@amd.com>
 <8f06398f-e207-45b0-ab85-931ccac35b65@amd.com>
 <ce3dbd30-31e6-4680-8618-2144fe44a928@amd.com>
 <0e573608-7f9e-4f3e-ac58-cf375962ae2b@amd.com>
 <c9cd0934-25ca-4d14-99c1-cc7aa3d566c8@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <c9cd0934-25ca-4d14-99c1-cc7aa3d566c8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0361.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:219::7) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|MW5PR12MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e15b00-0c2b-4a94-84df-08df18b5785b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|56012099006|3023799007|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: H32iRuWyIcJ2nzH36OX6BfVb5pso+O00T4Gjl9JAl64Lor+MYniPEVAFhvByGvuyqnae44Yb0Z/T6lUn92dfZV8Kp3pmJenrJQxOLdKT4GvR6HF+PJmXKyX1tVX4Bx9qc66KM1DQyGN82Pbmu+MVCFUnycvBpXBHIhtZCp6E3KL9Bn9uwRWEc52sYrAXUfcB/Pd0nDzfw1KBZ882wJyAofB20wK9oaPKgbwnTckzvDMB0jDEpyWdVUsmD5Ybj7/iZ2udabj7fSwXiuo5ZGtANLXCFa84OsOTl1rVlkhvp2Yw6sXip0LKeKekqY3clRmIDgGiwKGdDjrM++NssrO0Y77uMwkIESUtAcTtU402Nnhq9mCb/0j8KZ6LyHPAZ/KQFrBnF6frtD6ypdcdaySw7hR07EPzvHLqkI427+Lxk5vfiXxla9yMvQ54Us2V/Xr4hFPYCljELD2EW+Y5TCn2eRIlNtOq58aTDbyECkDNMzDoS5AIguK9ns9yXA5c6sPkfQLkC/saxa2YrqMYtZOkCppSV5LNJOyAZQnm4jjGRutBQuTBLzrMNrTr1YXDBNmwFmpkM5dAP5UNGlOmkdo8s7+wjLXs+gK9I6Fj6v8tFnT7wt4v52o6lLCrrWhsRZX6SM88eegIHX8yFmGuC8BOvUP7vJTBd39rx6uDSjPU9Fc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlNLelpGaTVXMHlFTXVhVDFPempvU0tFWFRkNDVxTEY4NWRUT21OakF2NEYr?=
 =?utf-8?B?TEsveW5UWTRLUTB0NGdPUElGU29xWlY1bmRubGxMRU1zOFU5ekFPSURFcDAy?=
 =?utf-8?B?b3ROUndoUy9iazB2YjZkeEI5T25pb3JnQTJzYStZcE1tRWxqNlB6TlYwZWdB?=
 =?utf-8?B?Z3cxVi9tVFNnMzIzYmFEVFpwT0RwQjc5QXdtU05hMWFyaG5OdVcvZXB2OXlG?=
 =?utf-8?B?Z3VaNVZpby9Pbklsb0dFRjNJQ1RocVZqL2F4ZnNUK28ybVhRRkVpb0xIdGU1?=
 =?utf-8?B?L2lKNEJ3dE51UlNmZmtVcXNwb0QzYit2RDlvdnRlRTRWUWYxdjV1RitmYTJz?=
 =?utf-8?B?aVg3QVJIOFA0SHd0SWZ2c3VwTkxob3pwQWozOXdrbzlLc3dzank3K1pSRFg4?=
 =?utf-8?B?b3hHWVdZc3RkZTJlb29GWkVIOUYxeXErSk90cnRKa1pEQUZNQ0pZcnVqR3VP?=
 =?utf-8?B?VkdmZTl2VHQyQzl0MG1ZL21IY1B1eG13V1JVNEVNNlFubWgvWmswQURRbWFp?=
 =?utf-8?B?ZG5WZUY5Ri91aGVMSlRKNytlWDB6NWNEZCtkNk4xcUVndWZSOXhmZkpJK0Vx?=
 =?utf-8?B?ck1ydUhYdDJBM3E5K1U4bDFQeTg1eXkvNG1DWDJvWXRFUWxjaWozUk5qZ2Ey?=
 =?utf-8?B?YUR1RS9YUGdsWUhlQVBVaDZQWEZTMGxTcHBBY1lXZWFUb25EYVFmRVo3NjBl?=
 =?utf-8?B?M3hvRk51UzNUR0VMdlFHTTBMNVB5NEtVUmtMVnNHNDR3U1ZPS3FpSWhoQW9w?=
 =?utf-8?B?S3ZnREY4Ty8zVHRKNEpsVGJZcElFOGlnSnVoQWs4Wkx6RGw1aTg4Nm5zSzNV?=
 =?utf-8?B?VzVCK1lQeHdkY042STkrT0QzZWUybmp2V1V6Y1cvVlRxTTNTMkcvb3NZcTdw?=
 =?utf-8?B?eFlubXZUREVxWkNRSURpWEtHR3NUbUhoUGhBb1NtY1NrUnRQQVgxc1RsK2xC?=
 =?utf-8?B?K2hSNmFyQ21ydldrVzl4NllrL1BQTHA1b2tPWDJiM2pvZXQ0MXVnVURLcCtu?=
 =?utf-8?B?YWVnM0NGS2puS2xBK3IxR21sNXBPRzN2eGZscnBLdiszU1ZSU1pHak9oUFlh?=
 =?utf-8?B?VXhDR09wSEJPSk5wdW5WbUw4VHNLaUQzd1JGQmdQT2Y3Z2d6Q0ZUaGQwbnFQ?=
 =?utf-8?B?cXh2OUo1c2szV1Q3VHpTdzROL0hBa2F1UHluMnJqam5oOWsxc3o5ZlBNMGV4?=
 =?utf-8?B?d1BhS2FUWVg5TUtxNmJNZGg3dTAxOW4xcENSci8rRld5dmFKUXh3eUd6dDZ0?=
 =?utf-8?B?UVlsNjdIN0E4UjBFNTB4TkJaR01menhmWlFmUmRhejVsamk5aTRxb3dGTlll?=
 =?utf-8?B?ZTFkT1NIUG14YlB5dVRpd3FreXk4djErT1JuRkxGS3o2clZrRG1LSnVRVjBU?=
 =?utf-8?B?eWQ1OFNMV2t3WkxPeGcySkZ2RnNYbmJ2ckI3Rk0ydGE0VjhZM1REcTB5MFRL?=
 =?utf-8?B?UFJpa2xIRUczdGY5elRUL2FiZy9OeXU4dW1vVkFvdWJ4dkQ2Nnp0WlJwbGlV?=
 =?utf-8?B?QlVkWGs4M1FRTEdVcTFtazZybkFoVndaeXlZSWhjYXVNeHJNVkN3aThTNFJI?=
 =?utf-8?B?d01sM0R6N09tN3RidlR6UVhuTDkzUGtSVE9UTFFreVJnVmE5Q1NxbnFoKzFq?=
 =?utf-8?B?bmtkemZxS2taUHR2VE4zK2VSZXhEUGw5R3pMWDBmcnFjdGNNc0xxZnI4ZDJO?=
 =?utf-8?B?NTBad2l3WFZTQ3E1RDQweVJ1ZW1OaXJ1NzY3ZFpRUjBEdGd0ajc5NVNFYmlx?=
 =?utf-8?B?c0toZGNFaHJ6cXBxdG1CcUcyeGwwNCtydUpBdzQ5WERaNnhpem5CNnowL0dK?=
 =?utf-8?B?ZHRSSHpjcDg4U1hSZkhNOFJQS044SStOeWZ5TkhreTg5MDdUSUFneGsvZit4?=
 =?utf-8?B?Q1BDYkJXVDRnaUIxZU5KaE55WXp5NStpT3MwalJIVGcraE00YkwwMnlLN0d2?=
 =?utf-8?B?ZkR1UGgyeEQ4bTRsWGNHYlF1aEJaN0c4cXdjd2VnRzZOckdwaVp4L3dRQUl3?=
 =?utf-8?B?dWs4TjNEeGRkNmZRQVZSYmpMc3Z3M2hxTHRpbTRpd2RhRnZ6TG9JNHZpSEYz?=
 =?utf-8?B?NE1EL1RiYkpIS0pZcVFybGZXdnFwUTZWRDgxNE5vdVZ3aWF3VHJlNU5KNnJE?=
 =?utf-8?B?azVGRXVXTVE0SHR5ZWU1T1lPcEI3NG1qbjd0d09Zd2p0SU5RRTluYjNWK2Nr?=
 =?utf-8?B?ak1aSXo4SzB1cXN3Tk9WTWVtTzUxZ3FIT3Q3bHVvRWhpeVNrOERpT3UrNnNn?=
 =?utf-8?B?TDc3RGxSaU5xY05ucUhvbEV6dlVTd3AvOFJtOG5UODBENk00WTJ1VHlHZGtS?=
 =?utf-8?Q?bTt39kV2FxXfzBGOI/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e15b00-0c2b-4a94-84df-08df18b5785b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 14:26:20.4621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bG/CoZAdKTyYkNQULwmoikOSV1Sf9ecCygafkP24AoTkUcIceyGDSPu0tALPjMGX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5650
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



On 22-Sep-26 7:41 PM, James Zhu wrote:
> 
> On 2026-09-22 09:45, Lazar, Lijo wrote:
>>
>>
>> On 22-Sep-26 7:05 PM, James Zhu wrote:
>>>
>>> On 2026-09-22 01:22, Lazar, Lijo wrote:
>>>>
>>>>
>>>> On 22-Sep-26 1:33 AM, James Zhu wrote:
>>>>> Add amdgpu_xcp_get_xcc_mask() to return the XCC instance mask for a 
>>>>> given
>>>>> XCP partition. This is needed by upcoming SPM (Stream Performance 
>>>>> Monitor)
>>>>> support, which programs hardware per partition and must operate 
>>>>> only on
>>>>> the XCCs that belong to a given XCP.
>>>>>
>>>>> For partitioned systems the helper returns only the XCCs belonging 
>>>>> to the
>>>>> specified XCP. When @xcp_id is AMDGPU_XCP_NO_PARTITION (or the 
>>>>> device is
>>>>> not partitioned) it returns the device's full XCC mask (e.g. 0xFF 
>>>>> for an
>>>>> 8-XCC device). Note that the full device mask is returned even on a
>>>>> partitioned device; callers that require partition isolation (e.g. 
>>>>> SPM)
>>>>> must reject AMDGPU_XCP_NO_PARTITION on a partitioned device 
>>>>> themselves.
>>>>>
>>>>
>>>> Could you clarifiy on this part - xcp_id = AMDGPU_XCP_NO_PARTITION 
>>>> usage on 8-XCC device?
>>>>
>>>> The default state on a multi-XCC device after driver load is all 
>>>> XCCs in a single partition called SPX. It should have at least one 
>>>> partition valid.
>>>
>>> [JZ] Yes, 8-XCC device should not reach AMDGPU_XCP_NO_PARTITION case.
>>>
>>> the if(!xcp_mgr ||xcp_id ==AMDGPU_XCP_NO_PARTITION) mainly covers non 
>>> partition device, I can remove the above comments which don't reflect 
>>> the source accurately.
>>
>> Then I'm not sure what issue this is fixing.
>>
>> Multi-xcc devices will be in SPX mode and will return a mask with all 
>> the XCCs. Non-multi xcc devices are expected to have this set to 1 
>> anyway to reflect that a single GC is present always.
> [JZ] Just realized a Fixes tag is added. I think somehow AI review added 
> it, and I did not check properly, is should be removed also. Sorry for 
> this confusing!

I see that it also added an external function like this -

amdgpu_xcp_get_xcc_mask

The expectation is any IP instance mask within a partition needs to 
obtained through - amdgpu_xcp_get_inst_details

Also, amdgpu_xcp_get_xcc_mask provides this which is not correct -

*xcc_mask = adev->gfx.xcc_mask

xcp instance mask operates only return logical mask of instances present 
(xcc_mask could include disabled ones also).

Thanks,
Lijo

>>
>> Thanks,
>> Lijo
>>
>>>> Thanks,
>>>> Lioj
>>>>
>>>>> amdgpu_xcp_get_num_xcc() is reworked to take (adev, xcp_id) and 
>>>>> derive the
>>>>> count from this helper via hweight32(). The helper is defined out 
>>>>> of line
>>>>> in amdgpu_xcp.c so that the static inline in amdgpu_xcp.h never has to
>>>>> dereference the (incomplete) struct amdgpu_device; it only passes the
>>>>> pointer through.
>>>>>
>>>>> This is a user-visible change: amdgpu_xcp_get_num_xcc() previously
>>>>> returned 1 for non-partitioned systems (and for 
>>>>> AMDGPU_XCP_NO_PARTITION),
>>>>> and now returns the actual XCC count (e.g. 8 for an 8-XCC device). 
>>>>> CWSR
>>>>> callers (amdgpu_kms.c, amdgpu_userq.c, mes_userqueue.c) scale the 
>>>>> per-XCC
>>>>> control-stack and debug-memory sizes by num_xcc, so the uAPI-visible
>>>>> ctl_stack_size and dbg_mem_size values grow accordingly to match the
>>>>> actual hardware resource requirements, which were previously 
>>>>> undersized.
>>>>>
>>>>> Fixes: 4cd417bfec49 ("drm/amdgpu: Add helper function to get xcc 
>>>>> count")
>>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>>> Reviewed-by: Bing Ma <bing.ma@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  2 +-
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  2 +-
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 48 +++++++++++++++++ 
>>>>> +++++
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    | 32 +++++++--------
>>>>>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  3 +-
>>>>>   5 files changed, 66 insertions(+), 21 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/ 
>>>>> drm/amd/amdgpu/amdgpu_kms.c
>>>>> index 57fa69c0382d..7782ccd4d28f 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>>> @@ -1501,7 +1501,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, 
>>>>> void *data, struct drm_file *filp)
>>>>>           fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
>>>>>           if (!amdgpu_trap_is_enabled(adev) || !fpriv->trap_obj)
>>>>>               return -EOPNOTSUPP;
>>>>> -        num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv- 
>>>>> >xcp_id);
>>>>> +        num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>>>>>           cwsr_info.ctl_stack_size =
>>>>>               adev->trap_info->cwsr.xcc_ctl_stack_sz * num_xcc;
>>>>>           cwsr_info.dbg_mem_size =
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/ 
>>>>> gpu/ drm/amd/amdgpu/amdgpu_userq.c
>>>>> index db09e879b85e..d19af9cb6ee1 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>> @@ -258,7 +258,7 @@ int 
>>>>> amdgpu_userq_input_trap_params_validate(struct 
>>>>> amdgpu_usermode_queue *queue,
>>>>>       int num_xcc;
>>>>>       int r;
>>>>>   -    num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
>>>>> +    num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>>>>>       r = amdgpu_trap_validate_params(queue->userq_mgr->adev, 
>>>>> trap_params,
>>>>>                       num_xcc);
>>>>>       if (r)
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/ 
>>>>> drm/amd/amdgpu/amdgpu_xcp.c
>>>>> index 2a56f5ec9c76..90846d55292b 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>>>> @@ -390,6 +390,54 @@ int amdgpu_xcp_get_inst_details(struct 
>>>>> amdgpu_xcp *xcp,
>>>>>       return 0;
>>>>>   }
>>>>>   +/**
>>>>> + * amdgpu_xcp_get_xcc_mask - Get XCC instance mask for a partition
>>>>> + * @adev: amdgpu device pointer
>>>>> + * @xcp_id: XCP partition ID
>>>>> + * @xcc_mask: output parameter for XCC instance mask
>>>>> + *
>>>>> + * Returns the XCC instance mask for the specified XCP partition.
>>>>> + * For partitioned systems, returns only the XCCs belonging to 
>>>>> this XCP.
>>>>> + *
>>>>> + * When @xcp_id is AMDGPU_XCP_NO_PARTITION (or the device is not
>>>>> + * partitioned), the device's full XCC mask is returned (e.g. 0xFF 
>>>>> for an
>>>>> + * 8-XCC device). Note that the full device mask is returned even 
>>>>> on a
>>>>> + * partitioned device: callers that require partition isolation 
>>>>> (e.g. SPM)
>>>>> + * must reject AMDGPU_XCP_NO_PARTITION on a partitioned device 
>>>>> themselves.
>>>>> + *
>>>>> + * Note: On error, xcc_mask is undefined. Callers must check 
>>>>> return code
>>>>> + * and only read xcc_mask when return == 0.
>>>>> + *
>>>>> + * Return: 0 on success (non-partitioned systems or valid XCP found),
>>>>> + *         -EINVAL if xcc_mask is NULL, no matching XCP id is 
>>>>> found, or the
>>>>> + *         partition's GFX IP details are unavailable
>>>>> + */
>>>>> +int amdgpu_xcp_get_xcc_mask(struct amdgpu_device *adev, int xcp_id,
>>>>> +                uint32_t *xcc_mask)
>>>>> +{
>>>>> +    struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
>>>>> +    struct amdgpu_xcp *xcp;
>>>>> +    int i;
>>>>> +
>>>>> +    if (!xcc_mask)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION) {
>>>>> +        /* Non-partitioned: return the device's full XCC mask. */
>>>>> +        *xcc_mask = adev->gfx.xcc_mask;
>>>>> +        return 0;
>>>>> +    }
>>>>> +
>>>>> +    /* Partitioned system: get this XCP's XCCs */
>>>>> +    for_each_xcp(xcp_mgr, xcp, i) {
>>>>> +        if (xcp->id == xcp_id)
>>>>> +            return amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX,
>>>>> +                               xcc_mask);
>>>>> +    }
>>>>> +
>>>>> +    return -EINVAL;
>>>>> +}
>>>>> +
>>>>>   int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
>>>>>               const struct pci_device_id *ent)
>>>>>   {
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/ 
>>>>> drm/amd/amdgpu/amdgpu_xcp.h
>>>>> index 692508be23fb..6eed82ad49b1 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>>>>> @@ -44,6 +44,7 @@
>>>>>   #define XCP_INST_MASK(num_inst, xcp_id)        \
>>>>>       (num_inst ? GENMASK(num_inst - 1, 0) << (xcp_id * num_inst) : 0)
>>>>>   +struct amdgpu_device;
>>>>>   struct amdgpu_fpriv;
>>>>>     enum AMDGPU_XCP_IP_BLOCK {
>>>>> @@ -219,26 +220,23 @@ amdgpu_get_next_xcp(struct amdgpu_xcp_mgr 
>>>>> *xcp_mgr, int *from)
>>>>>       for (i = 0, xcp = amdgpu_get_next_xcp(xcp_mgr, &i); xcp; \
>>>>>            ++i, xcp = amdgpu_get_next_xcp(xcp_mgr, &i))
>>>>>   -static inline int amdgpu_xcp_get_num_xcc(struct amdgpu_xcp_mgr 
>>>>> *xcp_mgr,
>>>>> -                     int xcp_id)
>>>>> +int amdgpu_xcp_get_xcc_mask(struct amdgpu_device *adev, int xcp_id,
>>>>> +                uint32_t *xcc_mask);
>>>>> +
>>>>> +static inline int amdgpu_xcp_get_num_xcc(struct amdgpu_device 
>>>>> *adev, int xcp_id)
>>>>>   {
>>>>> -    struct amdgpu_xcp *xcp;
>>>>>       uint32_t xcc_mask;
>>>>> -    int i, r;
>>>>> -
>>>>> -    if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION)
>>>>> +    int r, count;
>>>>> +
>>>>> +    /* Derive the XCC count from the partition's XCC mask (or the 
>>>>> full
>>>>> +     * device mask when not partitioned). amdgpu_xcp_get_xcc_mask()
>>>>> +     * handles both partitioned and non-partitioned cases.
>>>>> +     */
>>>>> +    r = amdgpu_xcp_get_xcc_mask(adev, xcp_id, &xcc_mask);
>>>>> +    if (unlikely(r))
>>>>>           return 1;
>>>>> -    for_each_xcp(xcp_mgr, xcp, i) {
>>>>> -        if (xcp->id == xcp_id) {
>>>>> -            r = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX,
>>>>> -                            &xcc_mask);
>>>>> -            if (unlikely(r))
>>>>> -                return 1;
>>>>> -            else
>>>>> -                return hweight32(xcc_mask);
>>>>> -        }
>>>>> -    }
>>>>>   -    return 1;
>>>>> +    count = hweight32(xcc_mask);
>>>>> +    return count ? count : 1;
>>>>>   }
>>>>>   #endif
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/ 
>>>>> gpu/drm/amd/amdgpu/mes_userqueue.c
>>>>> index 16aa22b25098..1c7b2f3227e5 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>>>> @@ -503,8 +503,7 @@ static int mes_userq_mqd_create(struct 
>>>>> amdgpu_usermode_queue *queue,
>>>>>                   uq_mgr_to_fpriv(queue->userq_mgr);
>>>>>               int num_xcc;
>>>>>   -            num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr,
>>>>> -                             fpriv->xcp_id);
>>>>> +            num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>>>>>               trap_params.ctx_save_area_address =
>>>>>                   compute_mqd->ctx_save_area_va;
>>>>>               trap_params.cwsr_sz = compute_mqd->ctx_save_area_size;
>>>>
>>

