Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13ADC9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 14:56:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B3FA10F0D6;
	Wed, 23 Sep 2026 14:56:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xk/34bbd";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B82B10F0DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 14:56:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6/KReimukBC3ABX0CneCliXEizhNWZoOxV4fUg6QucwO+T1BAiPrfs8OBL/F1DmkqhfBBdzJhzmBzGl4Pn7hcXNRvTDmpiVd0eKL2oGfC+9Nwmo8OYbSEpFYbT1nhvcuP0WiQ+KCqw5OQkj4jPrS/zGunVnY3qw5KU78+mQPZxbHDG9bPneg1j299l4XhZ8ojVeACdVJe+39CBlDhbfMDZDu1xFMCPdTmpQnHZ8z0+jt4bo4LW8nzVX/Tn3DcQtxZeR1+zfC76O8DiThuPPwu2wrRIFDu2w62cASvFsaZunqINB4+shaLmI3jNcT4BWzp8qrWWIERHLoCkZlf/Ypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgM2CTYXpWu8biTDMVQwa9Gf9MIU+1OJX2ty36LpqEM=;
 b=QLfc3aQmDp9mBvhPxZYeFgwrQBM6eZQFXeAKh9OMYJd2yJ7nxUVIw46e2Q9GfB3Mnfxn+qGazHr/p4GVKaamUvbMtdrhxYNBDi1qiaSn0wOLY0cat90cUuGaRUMwh++2yjqFA/B9Zo5X9W1sfXbVFe0S3YBzOPOvLfXzP70RQLkrWS9ezkWxaDynQyQl//TTerKvB5wpPEBtK7V2JLlMG01PlawYORGwPr+hyk1cWxMweE8c6kPHLyLAwNtQnX3kBd2TMTPNz62eIivxXxd1yUfy38rGjk7a4+e0SWk/ECks9fAkv4kFvXK3yGZekx1/TfRCWtoWTknlH4+uPLmdew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgM2CTYXpWu8biTDMVQwa9Gf9MIU+1OJX2ty36LpqEM=;
 b=Xk/34bbdXlj7sNoFZuImQsyyqox38w4/A1r6YNSoeTQs6ktPKo42G4Nc3D+ew0yrrpvwXbWbsTmnIYNrB30PiMTQ5Z2NGTaz4oB/g5YOZiRMX7zjOKal8eHuYKMfkRIKw4x8SGhCcwPZfnfmcdXMAk4p68UmWeuEJmn2dD3p+dY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by LV8PR12MB9417.namprd12.prod.outlook.com (2603:10b6:408:204::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Wed, 23 Sep
 2026 14:55:57 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 14:55:57 +0000
Message-ID: <7e3e84e5-7203-4871-b5be-a99d16071afd@amd.com>
Date: Wed, 23 Sep 2026 20:25:50 +0530
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
 <8fc9ee70-d284-4ef3-9e66-08d809fac293@amd.com>
 <526f559b-cb01-425d-9ae6-831d8bd2c229@amd.com>
 <7633a664-dfeb-4796-8b84-c5f2bc5df0d5@amd.com>
 <8a01cbe9-edad-4bf6-8519-569375fd93bf@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <8a01cbe9-edad-4bf6-8519-569375fd93bf@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::19) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|LV8PR12MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ef2b39-67eb-4d0e-7a6d-08df1982c60e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|4143699003|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4ULZUmvDeHAXOvpJposPFp27l3wZQGf5Ulv94XZb8914z2ubAiIcfjJnkDbO1VMR11szPk6lcRNPTlqRjZ22A0mOwk7jhxkpsWEKFX3YQkXr7SFIa5XLUrUlZvixa3SeNPI1R/sI7o3IF50gLTYOwudK+OQhUUCUb2LtHwW5pqApGdOBSBcrEzHCPqRTzd8Dgfo+UdAZh/Mu/dcgJFxr+J04meXO4KO2m53g+IV25CT+9g0s91eYpW9J34IwJLd3gCudMGnkjqupA/4wQ7ODQWurLqF8Gi6iO9pTEa4X/mmA8bASKQmO8Sb+nEZd+I0h7H6xa2m0ECQCgKH/hSLCpWM4tP38Ow6Blh3OdEOpdUjjkijsYlFJ/jkylYRiYn7saSwx60MayVjXR5vI+qRhQpuT1U0y4iDoRUmMd6145eY88IfJcHqJidQFzmppb1aQD6fWICfJXQomFud35ohev/lHVT3BSccx6ThAT0pcb9LYg3s+crYspcE4FaAHp59dYXmabn/wKewWrtH8LVkdZytoubnCnWf+DnmirhSrhi2OZ4b6Fw6LWZzInwOeKxUHzjcpomJg18WBXc8pMZ1rXqrd5kwAyWn+Tk95rOPpTW1hbvORuxhhUA7/ox+dU81gS0SJzgITn9tOqa1Eh6rHkGUgJFGuvedJScw8XEtZT20=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEw4V0VSaXFIcFE3eHpzSC9KRG9ORjJpeEVZNEJJM0lPVzlmS0xDNWwycHh5?=
 =?utf-8?B?NWZMQ2ZUa3RXTWRtRmkvb3pNMytHWWpCMnV1SVZKdStVUGkyS0NBdm0rTmp2?=
 =?utf-8?B?U1dOZURQWkh5TS80ajJmOHdDanZmRWFMQ0cxTWk4Sy9MUlIrK0xJWUJITmZh?=
 =?utf-8?B?ODRFYW1TZmRuTzYvaFVtMDJHTTh2NGtWWWkyOVcyZ1UxNmpUYThaVWp0bWNQ?=
 =?utf-8?B?VTJFSXZmQmE0Y3l6NGtMRWttZjdZbGJxalpZUEo1OWxFMjA5c2N3KzB5UjY3?=
 =?utf-8?B?V3NjTXJ1a0xRSHY1WHh1akVEU1QwSktTMVlINlZjd0pUQXdOSVRsMFM0Rmo3?=
 =?utf-8?B?UldXUE53QmJFblZTUmdJMkNWTmZucWdoOFlDem8rVWQvamVZYkVTZDFXQTJF?=
 =?utf-8?B?dWNZT2tKQXp6eWxHdkVZYWU1TVkxc0t2TThOVkkzUUZERjJ5Ry93QVBjemVL?=
 =?utf-8?B?TExVeGJ0TEc2WmxqckZkU2UvSlAyMFdiV0xqTE0rMjZpYUw2SmV2RjFBMmth?=
 =?utf-8?B?bXhPU3dRM29tZWt1anliQmZUS2dKRGFqMmt5Z3lzQjc0M2ltME9pVEp4Smp4?=
 =?utf-8?B?anN1ODR6cVJuenF6RnFpd0kxV1dTcWdPeGMyU21Dc1VFeTNlYjljVWtLU0F6?=
 =?utf-8?B?bjZGSkdlbzMvRkNrTjVBWSsrUVlCQ0FUMkgrbnFMYlBiOTJLQU54U3dkN1BK?=
 =?utf-8?B?NWZYbTNUM3VSbXN2dlVOVUVJSmQvRnZkMmFjMkVSdzZ0ZEowOU9DMUhFdUtI?=
 =?utf-8?B?Qk9hYnBHdi9wSEw0dVBhajJpWTdEbVNua3o5RzBQQ1Z4T01hN3RadXJSN3lJ?=
 =?utf-8?B?QlV6a2xHREFsMjFqQ3NmVHdYUzkzY2pmNXZkYWM0Y2NxazRMYjY1NXltZWd4?=
 =?utf-8?B?Ui8yUFhzU3VQdnFMSWdxd3JkamxyMWZReHhLQjliWDhtTmxqcGdaOVdoNTlv?=
 =?utf-8?B?MW12TEcyenU1eDZUbmZaelBXcFNQRVU1QUx1WlRmb1dFbUtORnozbFJuaHpt?=
 =?utf-8?B?RzJpT1AvdVNEbmFRaU91NzQ4RXFaL29ZNVNNVDZxYTVGdlljdUFXQUpuOGZH?=
 =?utf-8?B?N0dqUUlRUmJiOXNKWjAyWWpLekU1d2ZFM0RLQnBwbDBudVJKUmNFSkhhRGIx?=
 =?utf-8?B?RVZmYkI2Y3VycitjZmdGQVFEeVFzSVBGK0JYMmQ1ZkJ0dVlkZ0hiRDUvODUv?=
 =?utf-8?B?eUF1N3dJNzBLUTRLaWYxcXJHZFNGc0ZJdlZweEg3c0VkSlNIOVdqQmJ1aFk0?=
 =?utf-8?B?cVAvRW8wTjNsZXpkYnZsMDFyVSsrU0NQSllhMmNSY0hiZk9EUG1YclEzTk1h?=
 =?utf-8?B?VXhBbXQyNFZ3bitDbFlyUkFJS2oxOUk3V0oyb1ZXRzVqNzRPTmh1bXFrVEdP?=
 =?utf-8?B?SlJrQnlDeXNMMGZJeHkxSWp2em85RyswRzU1TkVZVWorcjBRa1Nma0djTkVK?=
 =?utf-8?B?ZmhXcitxZlFab21NS0NHSTBvUDRBU0FFTXY3bTNXc1g5MS9lL2lGQ1lUV1E5?=
 =?utf-8?B?MDhVUGc1bktzSjdjMXpmQUloekdvQ3llcWk1aWxYUUl2dDdNN2o2VHQ3SEVP?=
 =?utf-8?B?amp0amxDSnd6QWRmQ2NhdU5uZkkzd0FDNzZVa0VqVWtSYW0wOFE3ZVpsa0x5?=
 =?utf-8?B?OHY0QzhXZVdwVTZXL0lIb3FLOWJMaCtjNkltMFIxczNDeHBvdk5neWNEQnJ2?=
 =?utf-8?B?a0t5c1FYVjVxR003UDZ4anRNQUdaNndpa3U4V1N1YlE1UW96UU1OemdjMkts?=
 =?utf-8?B?cFM0YldVaFZldGc3WFo5RHBDSktsc3phTEVrdHhTeXRRNjkyWFU5U0FkUngy?=
 =?utf-8?B?dWQ4YW5zWTBycXJWd2x2Y0xTNVVrd0hpWktHQmRtbnE2Y01BeXZRVTRRUFpp?=
 =?utf-8?B?SHFRMHdocGUyckVhMnBqNmNOUEtpM1RIOTVuVDlrUWJhNlI0YXhKemRxaTd3?=
 =?utf-8?B?R3d0UVJaWFlsaVNpTkxGdnpZL3NVVlhISlF5aUF0NDFiZ1dwNzgwMDlQKzZR?=
 =?utf-8?B?cXVsQ2N0MkMxQVNBU1dXSmZ2UUlQQm9JajR3QXUzbWVGNDhvTXlwOThnZm9w?=
 =?utf-8?B?RWQ1YVAzWTBESlVVb2h2ZUtCUGJ1YU16NW82WTM5L2hzenBBNnVhT01FNmha?=
 =?utf-8?B?N3I0QU8vaHVJNTRLbUZWM2lFeU95OGs1bHhNYzIyZlFJRmFzb2k3OEQ4Z1Ja?=
 =?utf-8?B?WFZuV2Z2T1ZRRDVlQUQwVFJ0K29aWU5BS3VjK1prL3lIWmtXV3BzLzY1R24w?=
 =?utf-8?B?ekZvSUhUU3phRWFmZk9yUWs3NmRFVmJPcHcxTWlxU1FrRmpqMkhKRWtxSzZ3?=
 =?utf-8?Q?pC8VOXvrw493ZFIGXd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ef2b39-67eb-4d0e-7a6d-08df1982c60e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 14:55:57.1131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pj+eMYSkFQ4jE7U7lwaXk7YodeXw7VnuWJrbKsEajXE8H2XPpdUmrTcDv4NIlQDz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9417
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



On 23-Sep-26 6:06 PM, James Zhu wrote:
> 
> On 2026-09-22 23:39, Lazar, Lijo wrote:
>>
>>
>> On 22-Sep-26 8:40 PM, James Zhu wrote:
>>>
>>> On 2026-09-22 10:26, Lazar, Lijo wrote:
>>>>
>>>>
>>>> On 22-Sep-26 7:41 PM, James Zhu wrote:
>>>>>
>>>>> On 2026-09-22 09:45, Lazar, Lijo wrote:
>>>>>>
>>>>>>
>>>>>> On 22-Sep-26 7:05 PM, James Zhu wrote:
>>>>>>>
>>>>>>> On 2026-09-22 01:22, Lazar, Lijo wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 22-Sep-26 1:33 AM, James Zhu wrote:
>>>>>>>>> Add amdgpu_xcp_get_xcc_mask() to return the XCC instance mask 
>>>>>>>>> for a given
>>>>>>>>> XCP partition. This is needed by upcoming SPM (Stream 
>>>>>>>>> Performance Monitor)
>>>>>>>>> support, which programs hardware per partition and must operate 
>>>>>>>>> only on
>>>>>>>>> the XCCs that belong to a given XCP.
>>>>>>>>>
>>>>>>>>> For partitioned systems the helper returns only the XCCs 
>>>>>>>>> belonging to the
>>>>>>>>> specified XCP. When @xcp_id is AMDGPU_XCP_NO_PARTITION (or the 
>>>>>>>>> device is
>>>>>>>>> not partitioned) it returns the device's full XCC mask (e.g. 
>>>>>>>>> 0xFF for an
>>>>>>>>> 8-XCC device). Note that the full device mask is returned even 
>>>>>>>>> on a
>>>>>>>>> partitioned device; callers that require partition isolation 
>>>>>>>>> (e.g. SPM)
>>>>>>>>> must reject AMDGPU_XCP_NO_PARTITION on a partitioned device 
>>>>>>>>> themselves.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Could you clarifiy on this part - xcp_id = 
>>>>>>>> AMDGPU_XCP_NO_PARTITION usage on 8-XCC device?
>>>>>>>>
>>>>>>>> The default state on a multi-XCC device after driver load is all 
>>>>>>>> XCCs in a single partition called SPX. It should have at least 
>>>>>>>> one partition valid.
>>>>>>>
>>>>>>> [JZ] Yes, 8-XCC device should not reach AMDGPU_XCP_NO_PARTITION 
>>>>>>> case.
>>>>>>>
>>>>>>> the if(!xcp_mgr ||xcp_id ==AMDGPU_XCP_NO_PARTITION) mainly covers 
>>>>>>> non partition device, I can remove the above comments which don't 
>>>>>>> reflect the source accurately.
>>>>>>
>>>>>> Then I'm not sure what issue this is fixing.
>>>>>>
>>>>>> Multi-xcc devices will be in SPX mode and will return a mask with 
>>>>>> all the XCCs. Non-multi xcc devices are expected to have this set 
>>>>>> to 1 anyway to reflect that a single GC is present always.
>>>>> [JZ] Just realized a Fixes tag is added. I think somehow AI review 
>>>>> added it, and I did not check properly, is should be removed also. 
>>>>> Sorry for this confusing!
>>>>
>>>> I see that it also added an external function like this -
>>>>
>>>> amdgpu_xcp_get_xcc_mask
>>>>
>>>> The expectation is any IP instance mask within a partition needs to 
>>>> obtained through - amdgpu_xcp_get_inst_details
>>>>
>>>> Also, amdgpu_xcp_get_xcc_mask provides this which is not correct -
>>>>
>>>> *xcc_mask = adev->gfx.xcc_mask
>>>>
>>>> xcp instance mask operates only return logical mask of instances 
>>>> present (xcc_mask could include disabled ones also).
>>> [JZ] Here is only for non-partition device. I think adev- 
>>> >gfx.xcc_mask=0x1.
>>> I can change it to below code to clear the confusing
>>>
>>> *xcc_mask = BIT(0);
>>>
>>> How Do you think?
>>> Thanks!
>>>
>>
>> Once that is done, it's the same as what exists now (without the extra 
>> function).
>>
>> Also, why do you need get_xcc_mask function? If the difficulty is in 
>> getting amdgpu_xcp* pointer from xcp_id, then a wrapper could be added 
>> and used like
>>
>> xcp = amdgpu_xcp_get_obj(adev, xcp_id);
>> amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &xcc_mask);
> [JZ] Basically, amdgpu_xcp_get_xcc_mask is the above two's combination.

Ok, then suggest to use the two-step route instead of adding specific 
wrapper per IP.

Adding the first one (get xcp from xcp_id) could be helpful for other 
scenarios also.

Thanks,
Lijo

>>
>> Thanks,
>> Lijo
>>
>>> James
>>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Lioj
>>>>>>>>
>>>>>>>>> amdgpu_xcp_get_num_xcc() is reworked to take (adev, xcp_id) and 
>>>>>>>>> derive the
>>>>>>>>> count from this helper via hweight32(). The helper is defined 
>>>>>>>>> out of line
>>>>>>>>> in amdgpu_xcp.c so that the static inline in amdgpu_xcp.h never 
>>>>>>>>> has to
>>>>>>>>> dereference the (incomplete) struct amdgpu_device; it only 
>>>>>>>>> passes the
>>>>>>>>> pointer through.
>>>>>>>>>
>>>>>>>>> This is a user-visible change: amdgpu_xcp_get_num_xcc() previously
>>>>>>>>> returned 1 for non-partitioned systems (and for 
>>>>>>>>> AMDGPU_XCP_NO_PARTITION),
>>>>>>>>> and now returns the actual XCC count (e.g. 8 for an 8-XCC 
>>>>>>>>> device). CWSR
>>>>>>>>> callers (amdgpu_kms.c, amdgpu_userq.c, mes_userqueue.c) scale 
>>>>>>>>> the per-XCC
>>>>>>>>> control-stack and debug-memory sizes by num_xcc, so the uAPI- 
>>>>>>>>> visible
>>>>>>>>> ctl_stack_size and dbg_mem_size values grow accordingly to 
>>>>>>>>> match the
>>>>>>>>> actual hardware resource requirements, which were previously 
>>>>>>>>> undersized.
>>>>>>>>>
>>>>>>>>> Fixes: 4cd417bfec49 ("drm/amdgpu: Add helper function to get 
>>>>>>>>> xcc count")
>>>>>>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>>>>>>> Reviewed-by: Bing Ma <bing.ma@amd.com>
>>>>>>>>> ---
>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  2 +-
>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  2 +-
>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 48 +++++++++++++ 
>>>>>>>>> ++ ++ +++++
>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    | 32 +++++++--------
>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  3 +-
>>>>>>>>>   5 files changed, 66 insertions(+), 21 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/ 
>>>>>>>>> gpu/ drm/amd/amdgpu/amdgpu_kms.c
>>>>>>>>> index 57fa69c0382d..7782ccd4d28f 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>>>>>>> @@ -1501,7 +1501,7 @@ int amdgpu_info_ioctl(struct drm_device 
>>>>>>>>> *dev, void *data, struct drm_file *filp)
>>>>>>>>>           fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
>>>>>>>>>           if (!amdgpu_trap_is_enabled(adev) || !fpriv->trap_obj)
>>>>>>>>>               return -EOPNOTSUPP;
>>>>>>>>> -        num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv- 
>>>>>>>>> >xcp_id);
>>>>>>>>> +        num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>>>>>>>>>           cwsr_info.ctl_stack_size =
>>>>>>>>> adev->trap_info->cwsr.xcc_ctl_stack_sz * num_xcc;
>>>>>>>>>           cwsr_info.dbg_mem_size =
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/ 
>>>>>>>>> drivers/ gpu/ drm/amd/amdgpu/amdgpu_userq.c
>>>>>>>>> index db09e879b85e..d19af9cb6ee1 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>>>>> @@ -258,7 +258,7 @@ int 
>>>>>>>>> amdgpu_userq_input_trap_params_validate(struct 
>>>>>>>>> amdgpu_usermode_queue *queue,
>>>>>>>>>       int num_xcc;
>>>>>>>>>       int r;
>>>>>>>>>   -    num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv- 
>>>>>>>>> >xcp_id);
>>>>>>>>> +    num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>>>>>>>>>       r = amdgpu_trap_validate_params(queue->userq_mgr->adev, 
>>>>>>>>> trap_params,
>>>>>>>>>                       num_xcc);
>>>>>>>>>       if (r)
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/ 
>>>>>>>>> gpu/ drm/amd/amdgpu/amdgpu_xcp.c
>>>>>>>>> index 2a56f5ec9c76..90846d55292b 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>>>>>>>> @@ -390,6 +390,54 @@ int amdgpu_xcp_get_inst_details(struct 
>>>>>>>>> amdgpu_xcp *xcp,
>>>>>>>>>       return 0;
>>>>>>>>>   }
>>>>>>>>>   +/**
>>>>>>>>> + * amdgpu_xcp_get_xcc_mask - Get XCC instance mask for a 
>>>>>>>>> partition
>>>>>>>>> + * @adev: amdgpu device pointer
>>>>>>>>> + * @xcp_id: XCP partition ID
>>>>>>>>> + * @xcc_mask: output parameter for XCC instance mask
>>>>>>>>> + *
>>>>>>>>> + * Returns the XCC instance mask for the specified XCP partition.
>>>>>>>>> + * For partitioned systems, returns only the XCCs belonging to 
>>>>>>>>> this XCP.
>>>>>>>>> + *
>>>>>>>>> + * When @xcp_id is AMDGPU_XCP_NO_PARTITION (or the device is not
>>>>>>>>> + * partitioned), the device's full XCC mask is returned (e.g. 
>>>>>>>>> 0xFF for an
>>>>>>>>> + * 8-XCC device). Note that the full device mask is returned 
>>>>>>>>> even on a
>>>>>>>>> + * partitioned device: callers that require partition 
>>>>>>>>> isolation (e.g. SPM)
>>>>>>>>> + * must reject AMDGPU_XCP_NO_PARTITION on a partitioned device 
>>>>>>>>> themselves.
>>>>>>>>> + *
>>>>>>>>> + * Note: On error, xcc_mask is undefined. Callers must check 
>>>>>>>>> return code
>>>>>>>>> + * and only read xcc_mask when return == 0.
>>>>>>>>> + *
>>>>>>>>> + * Return: 0 on success (non-partitioned systems or valid XCP 
>>>>>>>>> found),
>>>>>>>>> + *         -EINVAL if xcc_mask is NULL, no matching XCP id is 
>>>>>>>>> found, or the
>>>>>>>>> + *         partition's GFX IP details are unavailable
>>>>>>>>> + */
>>>>>>>>> +int amdgpu_xcp_get_xcc_mask(struct amdgpu_device *adev, int 
>>>>>>>>> xcp_id,
>>>>>>>>> +                uint32_t *xcc_mask)
>>>>>>>>> +{
>>>>>>>>> +    struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
>>>>>>>>> +    struct amdgpu_xcp *xcp;
>>>>>>>>> +    int i;
>>>>>>>>> +
>>>>>>>>> +    if (!xcc_mask)
>>>>>>>>> +        return -EINVAL;
>>>>>>>>> +
>>>>>>>>> +    if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION) {
>>>>>>>>> +        /* Non-partitioned: return the device's full XCC mask. */
>>>>>>>>> +        *xcc_mask = adev->gfx.xcc_mask;
>>>>>>>>> +        return 0;
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    /* Partitioned system: get this XCP's XCCs */
>>>>>>>>> +    for_each_xcp(xcp_mgr, xcp, i) {
>>>>>>>>> +        if (xcp->id == xcp_id)
>>>>>>>>> +            return amdgpu_xcp_get_inst_details(xcp, 
>>>>>>>>> AMDGPU_XCP_GFX,
>>>>>>>>> +                               xcc_mask);
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    return -EINVAL;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>>   int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
>>>>>>>>>               const struct pci_device_id *ent)
>>>>>>>>>   {
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/ 
>>>>>>>>> gpu/ drm/amd/amdgpu/amdgpu_xcp.h
>>>>>>>>> index 692508be23fb..6eed82ad49b1 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>>>>>>>>> @@ -44,6 +44,7 @@
>>>>>>>>>   #define XCP_INST_MASK(num_inst, xcp_id)        \
>>>>>>>>>       (num_inst ? GENMASK(num_inst - 1, 0) << (xcp_id * 
>>>>>>>>> num_inst) : 0)
>>>>>>>>>   +struct amdgpu_device;
>>>>>>>>>   struct amdgpu_fpriv;
>>>>>>>>>     enum AMDGPU_XCP_IP_BLOCK {
>>>>>>>>> @@ -219,26 +220,23 @@ amdgpu_get_next_xcp(struct amdgpu_xcp_mgr 
>>>>>>>>> *xcp_mgr, int *from)
>>>>>>>>>       for (i = 0, xcp = amdgpu_get_next_xcp(xcp_mgr, &i); xcp; \
>>>>>>>>>            ++i, xcp = amdgpu_get_next_xcp(xcp_mgr, &i))
>>>>>>>>>   -static inline int amdgpu_xcp_get_num_xcc(struct 
>>>>>>>>> amdgpu_xcp_mgr *xcp_mgr,
>>>>>>>>> -                     int xcp_id)
>>>>>>>>> +int amdgpu_xcp_get_xcc_mask(struct amdgpu_device *adev, int 
>>>>>>>>> xcp_id,
>>>>>>>>> +                uint32_t *xcc_mask);
>>>>>>>>> +
>>>>>>>>> +static inline int amdgpu_xcp_get_num_xcc(struct amdgpu_device 
>>>>>>>>> *adev, int xcp_id)
>>>>>>>>>   {
>>>>>>>>> -    struct amdgpu_xcp *xcp;
>>>>>>>>>       uint32_t xcc_mask;
>>>>>>>>> -    int i, r;
>>>>>>>>> -
>>>>>>>>> -    if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION)
>>>>>>>>> +    int r, count;
>>>>>>>>> +
>>>>>>>>> +    /* Derive the XCC count from the partition's XCC mask (or 
>>>>>>>>> the full
>>>>>>>>> +     * device mask when not partitioned). 
>>>>>>>>> amdgpu_xcp_get_xcc_mask()
>>>>>>>>> +     * handles both partitioned and non-partitioned cases.
>>>>>>>>> +     */
>>>>>>>>> +    r = amdgpu_xcp_get_xcc_mask(adev, xcp_id, &xcc_mask);
>>>>>>>>> +    if (unlikely(r))
>>>>>>>>>           return 1;
>>>>>>>>> -    for_each_xcp(xcp_mgr, xcp, i) {
>>>>>>>>> -        if (xcp->id == xcp_id) {
>>>>>>>>> -            r = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX,
>>>>>>>>> -                            &xcc_mask);
>>>>>>>>> -            if (unlikely(r))
>>>>>>>>> -                return 1;
>>>>>>>>> -            else
>>>>>>>>> -                return hweight32(xcc_mask);
>>>>>>>>> -        }
>>>>>>>>> -    }
>>>>>>>>>   -    return 1;
>>>>>>>>> +    count = hweight32(xcc_mask);
>>>>>>>>> +    return count ? count : 1;
>>>>>>>>>   }
>>>>>>>>>   #endif
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/ 
>>>>>>>>> drivers/ gpu/drm/amd/amdgpu/mes_userqueue.c
>>>>>>>>> index 16aa22b25098..1c7b2f3227e5 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>>>>>>>> @@ -503,8 +503,7 @@ static int mes_userq_mqd_create(struct 
>>>>>>>>> amdgpu_usermode_queue *queue,
>>>>>>>>> uq_mgr_to_fpriv(queue->userq_mgr);
>>>>>>>>>               int num_xcc;
>>>>>>>>>   -            num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr,
>>>>>>>>> -                             fpriv->xcp_id);
>>>>>>>>> +            num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv- 
>>>>>>>>> >xcp_id);
>>>>>>>>>               trap_params.ctx_save_area_address =
>>>>>>>>>                   compute_mqd->ctx_save_area_va;
>>>>>>>>>               trap_params.cwsr_sz = compute_mqd- 
>>>>>>>>> >ctx_save_area_size;
>>>>>>>>
>>>>>>
>>>>
>>

