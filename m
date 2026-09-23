Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C9CC982FA
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 12:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1D7110E8BF;
	Wed, 23 Sep 2026 12:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qGZtnWSp";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012002.outbound.protection.outlook.com
 [40.93.195.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 832EE10E8BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 12:36:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WpiDPbiGfnlP1bJUbDAJRRnjvMAwcJQWXKSmYIBwf1b6uQffCpsc8CAUxhkeNlu/ToFbfTECY29bGx8KEw6hW49j/kMLqL6N+5oDXCHSpHr/VFbw9ioQksc8uSdRsSYGniVnxt7/7GJtGsFSHP9awziAS3ZPTj3v9g9lTM2qZiTlvDORQoP95BG5PL/nk0p+xU+ASdXnnayj9WqX9aDrzkAEdEugJF4Uf56dDgYHt2d+2iBizB0NL2CGlnvjMiHLt9nO/748A7wCvIjr4o8QbS0gsm8npALWbpvjS0woPqRk3Rrj2hOFCtcXQH+PPZwEZDGnT2OWnutl5OGW035kGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJp4XSgph/2ixgCT1Um4dJgS29XrLLxFZVBFh4X/nuc=;
 b=lElhI/hj5n/HQ9mYPfOhblgPbvRvt3SbsXZsg9QrZPaVPFTc5eAQqodzp7q61gD4n200Taw8SFkpF1bGYaWmfYrGne/2H3v/IF4vqxtiHqUlQlPVXaaej/LV//sGzIwdotzWhP3OlLbSKTME+tY58gOr0ryIwqLvHaHlG2IwStR6dO7IHnjjd5mWclvsqsASqUev27reUx/fKg0uF+4QNYcCbz6wFloGWI7NSPQ/YZF/GKEElO7bRV/epAzr/SWhK7nS98bOiO5ZqR0RATmMgdJETLAhDQ97VyRKQ1nM6vfIJWDnue6j5FGHLtifd5YgcgRgHRUd+slnNNAUTO7lgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJp4XSgph/2ixgCT1Um4dJgS29XrLLxFZVBFh4X/nuc=;
 b=qGZtnWSpoUqLFuhF3yd0WxZNe7y5ysMochfY7jqjja/5PfwdQWho7PRap3BMyS7b+trpUvH3wgQqZq79XPdaxS3pwEDUAC11P+Fo0JEHrtIYED1ze5zkZPS6uROsGysnQbhUlH8FevsGcRnj5jUrQq1RC5PXCU3mckau7HW/miI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by BY5PR12MB4257.namprd12.prod.outlook.com (2603:10b6:a03:20f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 12:36:49 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 12:36:48 +0000
Message-ID: <8a01cbe9-edad-4bf6-8519-569375fd93bf@amd.com>
Date: Wed, 23 Sep 2026 08:36:47 -0400
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
 <526f559b-cb01-425d-9ae6-831d8bd2c229@amd.com>
 <7633a664-dfeb-4796-8b84-c5f2bc5df0d5@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <7633a664-dfeb-4796-8b84-c5f2bc5df0d5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0120.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::13) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|BY5PR12MB4257:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff4a531-a5cc-43a3-168e-08df196f55f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|11063799006|22082099003|18002099003|56012099006|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info: 40Sb8rgWg0SLsRITKdLQ/WdPnq4LHmEEc/gc/7Cgul9MeeDTih8VpE3sGFSWurj0Hs0vLF678Qz4t35hilxLegIZVEetkh3PrBZaJS6hQVowfn8N90iSB+lfbR0I1bWlmpqVDGW0uDM3/MzMaGa1RT5ZV72J3++AhUg8dQ65eGMnlDesjRvxZI7DU7gROHGg3Fb1JuqE1R7rdL2BnDweHAIk5vx5hDD2Tp+KN36mKpWKEz2sL540ULNgR57IjCxdCo5aInkkIHz0o0b9Icevnj4PUu8RcH+JohdSImXQ3gxfUg3+bKJBMZs87+MwYggDnURfgE2qDnd034EjqW2tSz3CPTR15btnVZyGJuhtNQBz0LVM7RAR7iYmUM6iEV4SGdmGL4LaGZ2D1YGt3CLpdxlsKNgVvNK1GHzW3Rp37mQ7/pZ/r7a1ctcqT0mCWtEmZkj14bcyKOkXucP91E+M+7W7YZDRLdqYPif+R95asi3VQ7b3GkWINR+abMYgn/buvsUgsb/nT8fLs9mfi53BPrptPmwnzyVDlrzmgmgOkNa5fL4r8O+vjM4A7MS9xaWkLeEHQTajBD4YXrpMSA1WV7gxidPNzpzOZ5wste3ibZVqjDw+W+BefmjtvOHYcU5PQyqIAnac2muFqxkTQN+T20JWbIqHSYac4dqxjAm8Iuk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006)(4143699003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGpFSVd4SnJmZ1NzTVZ4WVNmT2czMVlqN3FFeXl2UXZGdm95aGhNb1lmdkth?=
 =?utf-8?B?OGZYYUdHWkF1TzJTVE93cVJtUlFRT294SWZTMFBxL2pXL2VvQmpRNGUxZ3pS?=
 =?utf-8?B?UHY0bDJXb1A0aUZxOUZ3Z2toUGZWK3BwZ3QyN0M3NlYyalZuUytlRTZtZm1C?=
 =?utf-8?B?YnVtTUlGSzBIOUxwOWJHZFhRczlXWStNV2M3SDRyOEdPOHZjQ2NRWEJQenJ4?=
 =?utf-8?B?bTdtL211bDBYWmNhSU5LUDVYMk1tKzVDSDJ1RXk0Unoyam5veEJUS29nR0pR?=
 =?utf-8?B?VDhvRnlxSm1QdlRVeURrdlhnR1M1QU42ZEhOTE1SY0dqSXhQV2JFUE9LRTR3?=
 =?utf-8?B?ekJ3TUNhZERYYnZXZTB3S0ZjZHgrWGlKcDh3ZG5kd2ZvMHRwWXltbDZraEp0?=
 =?utf-8?B?WkFUY1haekUrZmx5VlNkbHk2bVZpRlRzTWtnMGp0RW9aNWk1ZEFwWTU3aE1G?=
 =?utf-8?B?ejZDZU5oNU9weFpYak9QT05nMi9Wb2VTQkVDVTBoWnNJbGJRd1g1SGhIL2xC?=
 =?utf-8?B?V0lDQzhaLytzN2M3bk5zK0RkUDVVZC9iT3FMNkdDRDJJWElZcVlBM1E5dEI3?=
 =?utf-8?B?UjA5ODM0Y1V4T2MxTmJaUUo3cUtWbDVYVVlZUU5BVGY2SWZ2MVVrQS9XZzRT?=
 =?utf-8?B?RXV0NnplSU1ZendmdVBKNHVsazlTUXdNWE5pQ2g4ZDI5MnYrTXYrQWhBOXNL?=
 =?utf-8?B?WlB2M1hocURzMHZnZi82SmJvSjRLcm9EMXJZTDgzaktjZGh0dXB4ZzNSMmNY?=
 =?utf-8?B?TXJCRGVGSG5NRlB0NEdqaWdxRWRjTWhERklwZHFnZTZxTUxEdXd6eUxCSXJn?=
 =?utf-8?B?TS81dDdhVTBaTlFIVlFBTjM3Y2sycUhFYzRqa2FxNVdOMnBtN3JyU0J4SzZj?=
 =?utf-8?B?NVB4bGg5SmJnSVZ6STBYaHFZYUl3cFpmZEFCbHNZMFlqSktYRXlNUnc1UkRz?=
 =?utf-8?B?bkZROHdFdnN6ckk2bXJKUk5SVDJOdVFaRUhadVpHMWpTVGUvdTlPbVBZRWVH?=
 =?utf-8?B?V2FyU3pSMVhFTU9FNGdWZG1MTFpKaXJkdDF0RmhrRXdjOWRwcVkzQ2ZFQk5z?=
 =?utf-8?B?N3FDL0dqWWhVRGpvS2k5YnoyeTF5RVBMYXpRaVhsRjlKTUovcko2OEs1MHN2?=
 =?utf-8?B?Z2tJWlVHRWVvV0ZpeDZ1UzdmZXZaY05Ed0x1aFpmbHNuOEdPVDNDNEpPMThw?=
 =?utf-8?B?NkhZNmp1MVQwcnNURlJONldNampPeU92ZGVQZ1NXcWJ2NmRsdjlGcVBhR3Zj?=
 =?utf-8?B?dTBYVlNGSk5BeHRZVGRySk01bjRSRjUxWUtubkpjdzVKZXdBTk1hQTg3dUlk?=
 =?utf-8?B?eWlFUFhEUHJhOGxIcm9MQTMyS0N0SjVaQjVzTkFyd2xsaHR6b3drSWZNRk5o?=
 =?utf-8?B?dnhhdHRKSUZNdHphS25JRWZTWk5QNTk5alNmZVc3N0xXVFpUL0s3KzF6KzhQ?=
 =?utf-8?B?S2E4RHhpcnd3ZzhkZ0xkd2hqcGhsMFFiYXB0TURnSG5PS3NzSWx2Y082WW9Z?=
 =?utf-8?B?YzhubGJpT0F0eVBMK3grMTJiOFNSTzRKVldpemUyVXpySnVMelBQb2JTT2Zj?=
 =?utf-8?B?VVBKbXk0Q2NPVG54Q3NxdW9heDVZUU10eGUvQTdXTWpLOVdwVWsxKzE1UElq?=
 =?utf-8?B?VzRGMmsxQlpxNDBQT092RkZ0OEYxU01BNENQeTZTTlpWUDNKN3hBVzZCQlJX?=
 =?utf-8?B?NmUvOWJYcnMwcWNVNzY5aGdRM1c2QjIxUkZhVy9oRURSZGtRdDVLdHdjemxP?=
 =?utf-8?B?MHUyQUlzK0tCYVlMRjJ1LytUYWtyYlltdS9XWnk3QXZJamJtM0wzK1FxN2JG?=
 =?utf-8?B?MGYwOXZSUm9JUTZUQkhPSXRKRERPTURRQXJlUVdnWWh2SFYySUhJQ3N4OHRZ?=
 =?utf-8?B?RHhJWmE5eFZ6bzZZbFFuK1V1TXhBa3Q4Skp3dTVMcXdub1RTWU15ZDB2SjlB?=
 =?utf-8?B?ZHVLNGlmVllIckZLOG1FdkcyMWoyekNvRk9WMllGblViOWoxVDJseGZuamln?=
 =?utf-8?B?OGVoSy94a3U0dUp6TG4rK1UwTFNvajNtZmRFbGZEMExHWU51aWpLWWZJLy9v?=
 =?utf-8?B?TnZDTC9DS3VhU3FVMk80SFgrdHFFMGRkbloyakdxejFQcTZqZzNESmQxUS9G?=
 =?utf-8?B?aW9EOEZ6S2RBVEM1VEZWRXQ5Yk1lcmN5YkpzWmlJb1kreHpqVDAxQklhMzZp?=
 =?utf-8?B?eHpxbW5vbU9yMjdEaHFnTyt1UE9qNlBVeVNGQWlzTGppd1M3eEpjOWgyZEU3?=
 =?utf-8?B?eFY1S3lGNWlobGNlMllRSFpMWWtGUWFuQnhxdEZhRFE5Y21ZMnhkQjVxRGd4?=
 =?utf-8?Q?NmaE5Ui+0wzlyQHGdE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff4a531-a5cc-43a3-168e-08df196f55f5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 12:36:48.6387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WGRtlRHhJ7YjTrWTn7BVgxlj62ZqBcPXIFxvr1gJxBg0bk64HkIG8HOSOzTRWzth
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4257
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


On 2026-09-22 23:39, Lazar, Lijo wrote:
>
>
> On 22-Sep-26 8:40 PM, James Zhu wrote:
>>
>> On 2026-09-22 10:26, Lazar, Lijo wrote:
>>>
>>>
>>> On 22-Sep-26 7:41 PM, James Zhu wrote:
>>>>
>>>> On 2026-09-22 09:45, Lazar, Lijo wrote:
>>>>>
>>>>>
>>>>> On 22-Sep-26 7:05 PM, James Zhu wrote:
>>>>>>
>>>>>> On 2026-09-22 01:22, Lazar, Lijo wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 22-Sep-26 1:33 AM, James Zhu wrote:
>>>>>>>> Add amdgpu_xcp_get_xcc_mask() to return the XCC instance mask 
>>>>>>>> for a given
>>>>>>>> XCP partition. This is needed by upcoming SPM (Stream 
>>>>>>>> Performance Monitor)
>>>>>>>> support, which programs hardware per partition and must operate 
>>>>>>>> only on
>>>>>>>> the XCCs that belong to a given XCP.
>>>>>>>>
>>>>>>>> For partitioned systems the helper returns only the XCCs 
>>>>>>>> belonging to the
>>>>>>>> specified XCP. When @xcp_id is AMDGPU_XCP_NO_PARTITION (or the 
>>>>>>>> device is
>>>>>>>> not partitioned) it returns the device's full XCC mask (e.g. 
>>>>>>>> 0xFF for an
>>>>>>>> 8-XCC device). Note that the full device mask is returned even 
>>>>>>>> on a
>>>>>>>> partitioned device; callers that require partition isolation 
>>>>>>>> (e.g. SPM)
>>>>>>>> must reject AMDGPU_XCP_NO_PARTITION on a partitioned device 
>>>>>>>> themselves.
>>>>>>>>
>>>>>>>
>>>>>>> Could you clarifiy on this part - xcp_id = 
>>>>>>> AMDGPU_XCP_NO_PARTITION usage on 8-XCC device?
>>>>>>>
>>>>>>> The default state on a multi-XCC device after driver load is all 
>>>>>>> XCCs in a single partition called SPX. It should have at least 
>>>>>>> one partition valid.
>>>>>>
>>>>>> [JZ] Yes, 8-XCC device should not reach AMDGPU_XCP_NO_PARTITION 
>>>>>> case.
>>>>>>
>>>>>> the if(!xcp_mgr ||xcp_id ==AMDGPU_XCP_NO_PARTITION) mainly covers 
>>>>>> non partition device, I can remove the above comments which don't 
>>>>>> reflect the source accurately.
>>>>>
>>>>> Then I'm not sure what issue this is fixing.
>>>>>
>>>>> Multi-xcc devices will be in SPX mode and will return a mask with 
>>>>> all the XCCs. Non-multi xcc devices are expected to have this set 
>>>>> to 1 anyway to reflect that a single GC is present always.
>>>> [JZ] Just realized a Fixes tag is added. I think somehow AI review 
>>>> added it, and I did not check properly, is should be removed also. 
>>>> Sorry for this confusing!
>>>
>>> I see that it also added an external function like this -
>>>
>>> amdgpu_xcp_get_xcc_mask
>>>
>>> The expectation is any IP instance mask within a partition needs to 
>>> obtained through - amdgpu_xcp_get_inst_details
>>>
>>> Also, amdgpu_xcp_get_xcc_mask provides this which is not correct -
>>>
>>> *xcc_mask = adev->gfx.xcc_mask
>>>
>>> xcp instance mask operates only return logical mask of instances 
>>> present (xcc_mask could include disabled ones also).
>> [JZ] Here is only for non-partition device. I think 
>> adev->gfx.xcc_mask=0x1.
>> I can change it to below code to clear the confusing
>>
>> *xcc_mask = BIT(0);
>>
>> How Do you think?
>> Thanks!
>>
>
> Once that is done, it's the same as what exists now (without the extra 
> function).
>
> Also, why do you need get_xcc_mask function? If the difficulty is in 
> getting amdgpu_xcp* pointer from xcp_id, then a wrapper could be added 
> and used like
>
> xcp = amdgpu_xcp_get_obj(adev, xcp_id);
> amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &xcc_mask);
[JZ] Basically, amdgpu_xcp_get_xcc_mask is the above two's combination.
>
> Thanks,
> Lijo
>
>> James
>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>>> Thanks,
>>>>>>> Lioj
>>>>>>>
>>>>>>>> amdgpu_xcp_get_num_xcc() is reworked to take (adev, xcp_id) and 
>>>>>>>> derive the
>>>>>>>> count from this helper via hweight32(). The helper is defined 
>>>>>>>> out of line
>>>>>>>> in amdgpu_xcp.c so that the static inline in amdgpu_xcp.h never 
>>>>>>>> has to
>>>>>>>> dereference the (incomplete) struct amdgpu_device; it only 
>>>>>>>> passes the
>>>>>>>> pointer through.
>>>>>>>>
>>>>>>>> This is a user-visible change: amdgpu_xcp_get_num_xcc() previously
>>>>>>>> returned 1 for non-partitioned systems (and for 
>>>>>>>> AMDGPU_XCP_NO_PARTITION),
>>>>>>>> and now returns the actual XCC count (e.g. 8 for an 8-XCC 
>>>>>>>> device). CWSR
>>>>>>>> callers (amdgpu_kms.c, amdgpu_userq.c, mes_userqueue.c) scale 
>>>>>>>> the per-XCC
>>>>>>>> control-stack and debug-memory sizes by num_xcc, so the 
>>>>>>>> uAPI-visible
>>>>>>>> ctl_stack_size and dbg_mem_size values grow accordingly to 
>>>>>>>> match the
>>>>>>>> actual hardware resource requirements, which were previously 
>>>>>>>> undersized.
>>>>>>>>
>>>>>>>> Fixes: 4cd417bfec49 ("drm/amdgpu: Add helper function to get 
>>>>>>>> xcc count")
>>>>>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>>>>>> Reviewed-by: Bing Ma <bing.ma@amd.com>
>>>>>>>> ---
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  2 +-
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  2 +-
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 48 
>>>>>>>> +++++++++++++++ ++ +++++
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    | 32 +++++++--------
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  3 +-
>>>>>>>>   5 files changed, 66 insertions(+), 21 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/ 
>>>>>>>> gpu/ drm/amd/amdgpu/amdgpu_kms.c
>>>>>>>> index 57fa69c0382d..7782ccd4d28f 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>>>>>> @@ -1501,7 +1501,7 @@ int amdgpu_info_ioctl(struct drm_device 
>>>>>>>> *dev, void *data, struct drm_file *filp)
>>>>>>>>           fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
>>>>>>>>           if (!amdgpu_trap_is_enabled(adev) || !fpriv->trap_obj)
>>>>>>>>               return -EOPNOTSUPP;
>>>>>>>> -        num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv- 
>>>>>>>> >xcp_id);
>>>>>>>> +        num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>>>>>>>>           cwsr_info.ctl_stack_size =
>>>>>>>> adev->trap_info->cwsr.xcc_ctl_stack_sz * num_xcc;
>>>>>>>>           cwsr_info.dbg_mem_size =
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c 
>>>>>>>> b/drivers/ gpu/ drm/amd/amdgpu/amdgpu_userq.c
>>>>>>>> index db09e879b85e..d19af9cb6ee1 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>>>> @@ -258,7 +258,7 @@ int 
>>>>>>>> amdgpu_userq_input_trap_params_validate(struct 
>>>>>>>> amdgpu_usermode_queue *queue,
>>>>>>>>       int num_xcc;
>>>>>>>>       int r;
>>>>>>>>   -    num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv- 
>>>>>>>> >xcp_id);
>>>>>>>> +    num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>>>>>>>>       r = amdgpu_trap_validate_params(queue->userq_mgr->adev, 
>>>>>>>> trap_params,
>>>>>>>>                       num_xcc);
>>>>>>>>       if (r)
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/ 
>>>>>>>> gpu/ drm/amd/amdgpu/amdgpu_xcp.c
>>>>>>>> index 2a56f5ec9c76..90846d55292b 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>>>>>>> @@ -390,6 +390,54 @@ int amdgpu_xcp_get_inst_details(struct 
>>>>>>>> amdgpu_xcp *xcp,
>>>>>>>>       return 0;
>>>>>>>>   }
>>>>>>>>   +/**
>>>>>>>> + * amdgpu_xcp_get_xcc_mask - Get XCC instance mask for a 
>>>>>>>> partition
>>>>>>>> + * @adev: amdgpu device pointer
>>>>>>>> + * @xcp_id: XCP partition ID
>>>>>>>> + * @xcc_mask: output parameter for XCC instance mask
>>>>>>>> + *
>>>>>>>> + * Returns the XCC instance mask for the specified XCP partition.
>>>>>>>> + * For partitioned systems, returns only the XCCs belonging to 
>>>>>>>> this XCP.
>>>>>>>> + *
>>>>>>>> + * When @xcp_id is AMDGPU_XCP_NO_PARTITION (or the device is not
>>>>>>>> + * partitioned), the device's full XCC mask is returned (e.g. 
>>>>>>>> 0xFF for an
>>>>>>>> + * 8-XCC device). Note that the full device mask is returned 
>>>>>>>> even on a
>>>>>>>> + * partitioned device: callers that require partition 
>>>>>>>> isolation (e.g. SPM)
>>>>>>>> + * must reject AMDGPU_XCP_NO_PARTITION on a partitioned device 
>>>>>>>> themselves.
>>>>>>>> + *
>>>>>>>> + * Note: On error, xcc_mask is undefined. Callers must check 
>>>>>>>> return code
>>>>>>>> + * and only read xcc_mask when return == 0.
>>>>>>>> + *
>>>>>>>> + * Return: 0 on success (non-partitioned systems or valid XCP 
>>>>>>>> found),
>>>>>>>> + *         -EINVAL if xcc_mask is NULL, no matching XCP id is 
>>>>>>>> found, or the
>>>>>>>> + *         partition's GFX IP details are unavailable
>>>>>>>> + */
>>>>>>>> +int amdgpu_xcp_get_xcc_mask(struct amdgpu_device *adev, int 
>>>>>>>> xcp_id,
>>>>>>>> +                uint32_t *xcc_mask)
>>>>>>>> +{
>>>>>>>> +    struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
>>>>>>>> +    struct amdgpu_xcp *xcp;
>>>>>>>> +    int i;
>>>>>>>> +
>>>>>>>> +    if (!xcc_mask)
>>>>>>>> +        return -EINVAL;
>>>>>>>> +
>>>>>>>> +    if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION) {
>>>>>>>> +        /* Non-partitioned: return the device's full XCC mask. */
>>>>>>>> +        *xcc_mask = adev->gfx.xcc_mask;
>>>>>>>> +        return 0;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    /* Partitioned system: get this XCP's XCCs */
>>>>>>>> +    for_each_xcp(xcp_mgr, xcp, i) {
>>>>>>>> +        if (xcp->id == xcp_id)
>>>>>>>> +            return amdgpu_xcp_get_inst_details(xcp, 
>>>>>>>> AMDGPU_XCP_GFX,
>>>>>>>> +                               xcc_mask);
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    return -EINVAL;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>   int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
>>>>>>>>               const struct pci_device_id *ent)
>>>>>>>>   {
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/ 
>>>>>>>> gpu/ drm/amd/amdgpu/amdgpu_xcp.h
>>>>>>>> index 692508be23fb..6eed82ad49b1 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>>>>>>>> @@ -44,6 +44,7 @@
>>>>>>>>   #define XCP_INST_MASK(num_inst, xcp_id)        \
>>>>>>>>       (num_inst ? GENMASK(num_inst - 1, 0) << (xcp_id * 
>>>>>>>> num_inst) : 0)
>>>>>>>>   +struct amdgpu_device;
>>>>>>>>   struct amdgpu_fpriv;
>>>>>>>>     enum AMDGPU_XCP_IP_BLOCK {
>>>>>>>> @@ -219,26 +220,23 @@ amdgpu_get_next_xcp(struct amdgpu_xcp_mgr 
>>>>>>>> *xcp_mgr, int *from)
>>>>>>>>       for (i = 0, xcp = amdgpu_get_next_xcp(xcp_mgr, &i); xcp; \
>>>>>>>>            ++i, xcp = amdgpu_get_next_xcp(xcp_mgr, &i))
>>>>>>>>   -static inline int amdgpu_xcp_get_num_xcc(struct 
>>>>>>>> amdgpu_xcp_mgr *xcp_mgr,
>>>>>>>> -                     int xcp_id)
>>>>>>>> +int amdgpu_xcp_get_xcc_mask(struct amdgpu_device *adev, int 
>>>>>>>> xcp_id,
>>>>>>>> +                uint32_t *xcc_mask);
>>>>>>>> +
>>>>>>>> +static inline int amdgpu_xcp_get_num_xcc(struct amdgpu_device 
>>>>>>>> *adev, int xcp_id)
>>>>>>>>   {
>>>>>>>> -    struct amdgpu_xcp *xcp;
>>>>>>>>       uint32_t xcc_mask;
>>>>>>>> -    int i, r;
>>>>>>>> -
>>>>>>>> -    if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION)
>>>>>>>> +    int r, count;
>>>>>>>> +
>>>>>>>> +    /* Derive the XCC count from the partition's XCC mask (or 
>>>>>>>> the full
>>>>>>>> +     * device mask when not partitioned). 
>>>>>>>> amdgpu_xcp_get_xcc_mask()
>>>>>>>> +     * handles both partitioned and non-partitioned cases.
>>>>>>>> +     */
>>>>>>>> +    r = amdgpu_xcp_get_xcc_mask(adev, xcp_id, &xcc_mask);
>>>>>>>> +    if (unlikely(r))
>>>>>>>>           return 1;
>>>>>>>> -    for_each_xcp(xcp_mgr, xcp, i) {
>>>>>>>> -        if (xcp->id == xcp_id) {
>>>>>>>> -            r = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX,
>>>>>>>> -                            &xcc_mask);
>>>>>>>> -            if (unlikely(r))
>>>>>>>> -                return 1;
>>>>>>>> -            else
>>>>>>>> -                return hweight32(xcc_mask);
>>>>>>>> -        }
>>>>>>>> -    }
>>>>>>>>   -    return 1;
>>>>>>>> +    count = hweight32(xcc_mask);
>>>>>>>> +    return count ? count : 1;
>>>>>>>>   }
>>>>>>>>   #endif
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/ 
>>>>>>>> drivers/ gpu/drm/amd/amdgpu/mes_userqueue.c
>>>>>>>> index 16aa22b25098..1c7b2f3227e5 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>>>>>>> @@ -503,8 +503,7 @@ static int mes_userq_mqd_create(struct 
>>>>>>>> amdgpu_usermode_queue *queue,
>>>>>>>> uq_mgr_to_fpriv(queue->userq_mgr);
>>>>>>>>               int num_xcc;
>>>>>>>>   -            num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr,
>>>>>>>> -                             fpriv->xcp_id);
>>>>>>>> +            num_xcc = amdgpu_xcp_get_num_xcc(adev, 
>>>>>>>> fpriv->xcp_id);
>>>>>>>>               trap_params.ctx_save_area_address =
>>>>>>>>                   compute_mqd->ctx_save_area_va;
>>>>>>>>               trap_params.cwsr_sz = 
>>>>>>>> compute_mqd->ctx_save_area_size;
>>>>>>>
>>>>>
>>>
>
