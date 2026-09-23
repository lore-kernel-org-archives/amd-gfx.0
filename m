Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6525DC982FA
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 03:39:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE31010E7BC;
	Wed, 23 Sep 2026 03:39:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cgAY6pok";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010062.outbound.protection.outlook.com
 [40.93.198.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E23DA10E7BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 03:39:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZAzpEQQ442Dlxi+bxvtsco0KiUeVnPuHT/fhcEc19Hfcyr2AI2+LAWOVb0wlCIyDQ2pMUJOZktGaeZv6HwYu+eA1PbfAmPBn/1M+zC3rFGil/TXllzZfbNkVr+E/wSZiubqCq6QXgC94z3URThKYqDLvxIGmKx7Pg7LNbp0xsOvFBvOGpiwsOoAc0e3HA7waSC3k9dXoGa51103hVgc8n+6RlB85oCf3/Nn9P5HJnXvTTD7x0a5RgYW4JLC9iQQm/WeNnjvUKJo/ovRHOGCgO0UmeofDxMLxiVZ70eTH25zfAA5y9qFUB8P/4zVqMKV0ZG6+oSNqtNzC8WhGawnjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=And9gRokDjMTyanOBsFKiyhl2hCNrfkPEyHbQwtZH2Q=;
 b=Odjv9BA/BIW8YJyFKAV2pc+fH9RXD9YLZFbs+qtkebkClWWiKCOxXLG8ZOdcKHnzo+VbX6ZLFuoNd0fjQGq2ouBSrJlJ/nJenwYoS65D5K6VBY6TRlPiOAvkIuWEjaug+LB5D7YAT55WXWZcEIfNqgvl8z55D/Fx0+7QF/GEQkkkz+I/v/5RqUPkR31L98nWQWlX89kSJ0TFW1TG+M0pPyx1FaxieiXWA6lvYqMiEU/4JSZg4Nab5qZhSG+asN605d3XOyWpyG0zjmEJypWDHLvmzzW+08cCz7XwirDX54ulYGHR/Nkld7Hd6U1O5ga8u4vdZ2M9sBzTnb82O2y4OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=And9gRokDjMTyanOBsFKiyhl2hCNrfkPEyHbQwtZH2Q=;
 b=cgAY6pok1VCW9Fo71+DmXuhOq9/FOw9C9bhZLk/GQoOMMvwR1OH+8HwNIb+1UVqUNeh1xM7xy9j4EV6KRjPGivgnCvHQ1eLFMr8hCPutgjau5INirgeOV3fa8zMhzmciaUK5i/N2UMOAUd45Sm81kALASuW05aO364gb28Xa/yw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 03:39:31 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 03:39:31 +0000
Message-ID: <7633a664-dfeb-4796-8b84-c5f2bc5df0d5@amd.com>
Date: Wed, 23 Sep 2026 09:09:25 +0530
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
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <526f559b-cb01-425d-9ae6-831d8bd2c229@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::10) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MW4PR12MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: ea3530d7-0980-49e4-c86a-08df19244675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: OrWf7lywZFxy4pCpL3ki3uqaknNykozts3gJgo8rIACnsVo9uLSzjJKwqfhK0VnO/Uc1GvzexuSLa2tuP3SYnk6oQ1HbYYzCFLti4e+6WKEJscheCDxAl/K3wwRKMi7HdBE+RgSlMF6WzFq1kAr4VMw1z+kYtCR94dfys9/qT7yrP1sczW4PzMfbSOfovq++4HPJb3NimYSkLUpxF+L4qMU7EfeT2jBVd4n59zH4KgsDH4GNKtAGcSklp7ib1wLqabA/Hiv/dqdYQXiKHdv9uBpGPLJj7GLuaNstXrC20IjDBdDjxvUclDpj64UwqvCQZbDqK0GTlIfYRMpx4/xxgyxD0rm4wNr3wsg6sR2MUHu9wVICOhiHqKBFqVldPvOCn4asHJlX6ppHK684GOWETFMDvMOTlVMLoDRYbtO8o2/3tVH01BnsX6XI32OXsvHAlXRh0Ww3TD34rII1SrwqqdnSrdC0/iHIoBCuZc/P49YlQeZAh5q5tkH+7bsKsDElwYIy6VdJe4eBfXdV5hm6wnHG+262oiMEmiDmIcn+nFqwPiyTXxm/oN/JmGrQG/Rx9hUGUN9GukzfDdv/56qm0hyDCJEf00Mi10VzFy/aH45ecmHR6pLUXqyEIXfL0jivKX+bek0YMborqG8ZmCKD9eFSO/E8H0ySk2+j+Wa3Vck=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE9BSjBVbjRNdUUvcCtUb3hSbHd1WkRnY2dkRkNKR09oekdLd2RaSlBRV0RQ?=
 =?utf-8?B?RktoaEsyK1dtMC9kT0NmYWk1WU9zclNoSmZIbVYyYkxhWUo3MDA4Z2hleTJX?=
 =?utf-8?B?NXlIRTJDbkttT3pWa20vdXJLVEFxSVpDcDBhRDl2YkVxQ0RvZlZHVU4yZmdh?=
 =?utf-8?B?Y2d5Y2xyZzJiNVAvNGdIT2pPbEtvWjB2cHBzWWsrQUR3Q040Qi9XendzNHFN?=
 =?utf-8?B?dGRjcDRvZUhaelFuMTAzRHBpN2xONUhLZ04zb0E4ZlI3R2FrZGZLR1ZVdXB1?=
 =?utf-8?B?cUFLODlKcHdjalFqcWRiMUgzcDh5K0hIaWdsQk5EblpLUUptN0JxcXI3QVRz?=
 =?utf-8?B?QXcrdXdyNmZzaVZtcTdKVEJ6cE9HTUVwVWNYUjd3L1lFOW00UlMweWxwNEhK?=
 =?utf-8?B?TDdsRGdZZDgzVnc0bE1aZFB3NUlOV2lsbnQ4STdZU1YvWTkwVTdZdGJDYmVv?=
 =?utf-8?B?UWVldUJHdTgzK1JSbGFnbFYrZ3R2d0Z0ZHU4K3Myc2ZLS0JERng1ZWtKTFdF?=
 =?utf-8?B?V2xJSFI3TUcrOG44eUptUzRkQlRGRjM0Ulp6N2FwbjFwQkltSGlSTENOenli?=
 =?utf-8?B?VUFhbzJrK21PVHhPWTdIbTV0cExJaXY3L245NkRiUmdicjFBTWVOaGFZemZ3?=
 =?utf-8?B?U1ZVQWJjT3NJNW94WkxUbTFTWENRMGJWNDlTMmw0cHZhRHcxOFFsTFFPN0Ny?=
 =?utf-8?B?aEl2ZnAzSDVrNDBLMzJ1dDROcVpxWFJpeUNQdXBQaG55alhWZGNtdGpzYVJV?=
 =?utf-8?B?dTkyK1ovbFpPOE5sWGZXWWRKNldLOURFZC92dHE5Tmt6TVAvRTM2bFQ3MTE0?=
 =?utf-8?B?NWJJVzl5T1F1NDNCV1VhY0VrSnB2bEo3THZtU0tnLzU2aXJVYUhUc1UyWHNz?=
 =?utf-8?B?dVAzbzFqV2tIUmVBN1lwd2g5YXpnSnJhN05UcnhvSlVSNnExMmd4dzE1bEhV?=
 =?utf-8?B?Y29UVWpzaHhlMGsyd0ZjbUpIc29BY1pOL0lUdUNDYlZhSW9XdVRaWDRCU3hN?=
 =?utf-8?B?ajJtYzJ2c2FBUG5hNE5Wem5zdTQ1RE43RjA0WUxHT3ZtUGxtUVlhVzZpanF5?=
 =?utf-8?B?ZWZObG4wTDNWek1iVVNzR2ZpWCtvMTFjWU8rWmtZTldZQ3BzZnY2RW9NekxL?=
 =?utf-8?B?ckhWN1pkTkpLMkVCTmdsenJ6bmhYM252c2lHWUlGNmNoMHFjMW9MbXdjeE5L?=
 =?utf-8?B?eFVXc3VSL3dZYU1IQXJTc1pyWkUxd3dMeTQzSzM5ajFXUEswaS9hdE1WS0M0?=
 =?utf-8?B?bHZpUmJuZGZDL0J6NHVRSTBtdFR1Y3JJeStITnVIam9PU3hCUlh3b3JITTl1?=
 =?utf-8?B?Y3BNd1ZpTDYzdWlCKzViUHNaUEpXWWVTNFNFa0dpSzVxSnd6R0dDbW9YVlF0?=
 =?utf-8?B?ck9EK294UStBcVZqV1d3R2toa2s5Z3F1N3F0WGdLc2FxSENmdXJZTUVrYXFI?=
 =?utf-8?B?NEd6OU5GOTNjS2xXVnZ4S2dFaXN4TC9vbXRVc3pRUFJhVFhEYXNQcGhwejYr?=
 =?utf-8?B?VnptanpISzNySlRQR0MvTXZwVGU5VUZ1MnhNMHAyVGJnVldod1VVUEkybHpi?=
 =?utf-8?B?SWpQTkV6b3ZxM3M0dXlPa0Rmb203TXJXbWpjVlo0bUM4dkNPSEN0bTdTVTFZ?=
 =?utf-8?B?dVhGV2tydC9CWk5VWEpOazNXbHVJTFZSV2ROS1dXWDZWOTJ2cEVmdmdsK0Yy?=
 =?utf-8?B?TWl5SjFyZmtTcFlydUlaU0xqb0ZkZ0Z5U2VMK3pMQi9KZjJ6UVV4dzJQWnc4?=
 =?utf-8?B?V3k3cW1yRGk2K0tUT1kvbHI2d1hzdGZOOTV6ZVhTOHpTMXJISExzbXcxM1Ar?=
 =?utf-8?B?RmNGYUUrb0UvRHhGUlh1UGx3YUJqYXJiY21TMWdIbkZZbytmV28xYmxyY3FF?=
 =?utf-8?B?TmkzV0FpRElaV2NPSTdOdWltb2RxWEtFM3JUa2xVK0NBeGN0K3kvbWltUEdD?=
 =?utf-8?B?RVBudERNekJyTUM3djhrZDlpaHNqVWNqUWFMRjVmRUx0V0IxQ0Y5aW1SOC96?=
 =?utf-8?B?U1E1UjlMbjMxLzYydUlOQ01IZEZCZnhVa3JRNjlKRUFaOFV2Y2dyOGRYenN5?=
 =?utf-8?B?aDlGcGtlY3JUYW90bHEvVjFhUXRKZlBKbnhYMlZPNkJScFh5ejY2NDNaQTAw?=
 =?utf-8?B?RkNSOGNIaElGZHFNc3FFL2xkdWE0T3Y2eDlkSjBzWk9xQ0pNcWY3bVpWYjRH?=
 =?utf-8?B?V1RpaFloNlFaK2F2Q24rNDhqa1lDOVBtVTdIaW45OVpsOFlxK0JpUzBMVjZh?=
 =?utf-8?B?UmpnRHN2enZxRWp6ZXVxR2xydWpBUWIyV1BEdlRRUmlaTGNseUFmaHdzNk5V?=
 =?utf-8?Q?jDWXzYEYHdeFvILnXB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3530d7-0980-49e4-c86a-08df19244675
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 03:39:31.4648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNG+Ox6ruvuunr5p3qDEqD3r4lMBF3rrFat50AosBmmnev2BSeuY+nWJ34J3M4oc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949
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



On 22-Sep-26 8:40 PM, James Zhu wrote:
> 
> On 2026-09-22 10:26, Lazar, Lijo wrote:
>>
>>
>> On 22-Sep-26 7:41 PM, James Zhu wrote:
>>>
>>> On 2026-09-22 09:45, Lazar, Lijo wrote:
>>>>
>>>>
>>>> On 22-Sep-26 7:05 PM, James Zhu wrote:
>>>>>
>>>>> On 2026-09-22 01:22, Lazar, Lijo wrote:
>>>>>>
>>>>>>
>>>>>> On 22-Sep-26 1:33 AM, James Zhu wrote:
>>>>>>> Add amdgpu_xcp_get_xcc_mask() to return the XCC instance mask for 
>>>>>>> a given
>>>>>>> XCP partition. This is needed by upcoming SPM (Stream Performance 
>>>>>>> Monitor)
>>>>>>> support, which programs hardware per partition and must operate 
>>>>>>> only on
>>>>>>> the XCCs that belong to a given XCP.
>>>>>>>
>>>>>>> For partitioned systems the helper returns only the XCCs 
>>>>>>> belonging to the
>>>>>>> specified XCP. When @xcp_id is AMDGPU_XCP_NO_PARTITION (or the 
>>>>>>> device is
>>>>>>> not partitioned) it returns the device's full XCC mask (e.g. 0xFF 
>>>>>>> for an
>>>>>>> 8-XCC device). Note that the full device mask is returned even on a
>>>>>>> partitioned device; callers that require partition isolation 
>>>>>>> (e.g. SPM)
>>>>>>> must reject AMDGPU_XCP_NO_PARTITION on a partitioned device 
>>>>>>> themselves.
>>>>>>>
>>>>>>
>>>>>> Could you clarifiy on this part - xcp_id = AMDGPU_XCP_NO_PARTITION 
>>>>>> usage on 8-XCC device?
>>>>>>
>>>>>> The default state on a multi-XCC device after driver load is all 
>>>>>> XCCs in a single partition called SPX. It should have at least one 
>>>>>> partition valid.
>>>>>
>>>>> [JZ] Yes, 8-XCC device should not reach AMDGPU_XCP_NO_PARTITION case.
>>>>>
>>>>> the if(!xcp_mgr ||xcp_id ==AMDGPU_XCP_NO_PARTITION) mainly covers 
>>>>> non partition device, I can remove the above comments which don't 
>>>>> reflect the source accurately.
>>>>
>>>> Then I'm not sure what issue this is fixing.
>>>>
>>>> Multi-xcc devices will be in SPX mode and will return a mask with 
>>>> all the XCCs. Non-multi xcc devices are expected to have this set to 
>>>> 1 anyway to reflect that a single GC is present always.
>>> [JZ] Just realized a Fixes tag is added. I think somehow AI review 
>>> added it, and I did not check properly, is should be removed also. 
>>> Sorry for this confusing!
>>
>> I see that it also added an external function like this -
>>
>> amdgpu_xcp_get_xcc_mask
>>
>> The expectation is any IP instance mask within a partition needs to 
>> obtained through - amdgpu_xcp_get_inst_details
>>
>> Also, amdgpu_xcp_get_xcc_mask provides this which is not correct -
>>
>> *xcc_mask = adev->gfx.xcc_mask
>>
>> xcp instance mask operates only return logical mask of instances 
>> present (xcc_mask could include disabled ones also).
> [JZ] Here is only for non-partition device. I think adev->gfx.xcc_mask=0x1.
> I can change it to below code to clear the confusing
> 
> *xcc_mask = BIT(0);
> 
> How Do you think?
> Thanks!
> 

Once that is done, it's the same as what exists now (without the extra 
function).

Also, why do you need get_xcc_mask function? If the difficulty is in 
getting amdgpu_xcp* pointer from xcp_id, then a wrapper could be added 
and used like

xcp = amdgpu_xcp_get_obj(adev, xcp_id);
amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, 
&xcc_mask);

Thanks,
Lijo

> James
> 
>>
>> Thanks,
>> Lijo
>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>>> Thanks,
>>>>>> Lioj
>>>>>>
>>>>>>> amdgpu_xcp_get_num_xcc() is reworked to take (adev, xcp_id) and 
>>>>>>> derive the
>>>>>>> count from this helper via hweight32(). The helper is defined out 
>>>>>>> of line
>>>>>>> in amdgpu_xcp.c so that the static inline in amdgpu_xcp.h never 
>>>>>>> has to
>>>>>>> dereference the (incomplete) struct amdgpu_device; it only passes 
>>>>>>> the
>>>>>>> pointer through.
>>>>>>>
>>>>>>> This is a user-visible change: amdgpu_xcp_get_num_xcc() previously
>>>>>>> returned 1 for non-partitioned systems (and for 
>>>>>>> AMDGPU_XCP_NO_PARTITION),
>>>>>>> and now returns the actual XCC count (e.g. 8 for an 8-XCC 
>>>>>>> device). CWSR
>>>>>>> callers (amdgpu_kms.c, amdgpu_userq.c, mes_userqueue.c) scale the 
>>>>>>> per-XCC
>>>>>>> control-stack and debug-memory sizes by num_xcc, so the uAPI-visible
>>>>>>> ctl_stack_size and dbg_mem_size values grow accordingly to match the
>>>>>>> actual hardware resource requirements, which were previously 
>>>>>>> undersized.
>>>>>>>
>>>>>>> Fixes: 4cd417bfec49 ("drm/amdgpu: Add helper function to get xcc 
>>>>>>> count")
>>>>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>>>>> Reviewed-by: Bing Ma <bing.ma@amd.com>
>>>>>>> ---
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  2 +-
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  2 +-
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 48 +++++++++++++++ 
>>>>>>> ++ +++++
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    | 32 +++++++--------
>>>>>>>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  3 +-
>>>>>>>   5 files changed, 66 insertions(+), 21 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/ 
>>>>>>> gpu/ drm/amd/amdgpu/amdgpu_kms.c
>>>>>>> index 57fa69c0382d..7782ccd4d28f 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>>>>> @@ -1501,7 +1501,7 @@ int amdgpu_info_ioctl(struct drm_device 
>>>>>>> *dev, void *data, struct drm_file *filp)
>>>>>>>           fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
>>>>>>>           if (!amdgpu_trap_is_enabled(adev) || !fpriv->trap_obj)
>>>>>>>               return -EOPNOTSUPP;
>>>>>>> -        num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv- 
>>>>>>> >xcp_id);
>>>>>>> +        num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>>>>>>>           cwsr_info.ctl_stack_size =
>>>>>>> adev->trap_info->cwsr.xcc_ctl_stack_sz * num_xcc;
>>>>>>>           cwsr_info.dbg_mem_size =
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/ 
>>>>>>> gpu/ drm/amd/amdgpu/amdgpu_userq.c
>>>>>>> index db09e879b85e..d19af9cb6ee1 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>>> @@ -258,7 +258,7 @@ int 
>>>>>>> amdgpu_userq_input_trap_params_validate(struct 
>>>>>>> amdgpu_usermode_queue *queue,
>>>>>>>       int num_xcc;
>>>>>>>       int r;
>>>>>>>   -    num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv- 
>>>>>>> >xcp_id);
>>>>>>> +    num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>>>>>>>       r = amdgpu_trap_validate_params(queue->userq_mgr->adev, 
>>>>>>> trap_params,
>>>>>>>                       num_xcc);
>>>>>>>       if (r)
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/ 
>>>>>>> gpu/ drm/amd/amdgpu/amdgpu_xcp.c
>>>>>>> index 2a56f5ec9c76..90846d55292b 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>>>>>> @@ -390,6 +390,54 @@ int amdgpu_xcp_get_inst_details(struct 
>>>>>>> amdgpu_xcp *xcp,
>>>>>>>       return 0;
>>>>>>>   }
>>>>>>>   +/**
>>>>>>> + * amdgpu_xcp_get_xcc_mask - Get XCC instance mask for a partition
>>>>>>> + * @adev: amdgpu device pointer
>>>>>>> + * @xcp_id: XCP partition ID
>>>>>>> + * @xcc_mask: output parameter for XCC instance mask
>>>>>>> + *
>>>>>>> + * Returns the XCC instance mask for the specified XCP partition.
>>>>>>> + * For partitioned systems, returns only the XCCs belonging to 
>>>>>>> this XCP.
>>>>>>> + *
>>>>>>> + * When @xcp_id is AMDGPU_XCP_NO_PARTITION (or the device is not
>>>>>>> + * partitioned), the device's full XCC mask is returned (e.g. 
>>>>>>> 0xFF for an
>>>>>>> + * 8-XCC device). Note that the full device mask is returned 
>>>>>>> even on a
>>>>>>> + * partitioned device: callers that require partition isolation 
>>>>>>> (e.g. SPM)
>>>>>>> + * must reject AMDGPU_XCP_NO_PARTITION on a partitioned device 
>>>>>>> themselves.
>>>>>>> + *
>>>>>>> + * Note: On error, xcc_mask is undefined. Callers must check 
>>>>>>> return code
>>>>>>> + * and only read xcc_mask when return == 0.
>>>>>>> + *
>>>>>>> + * Return: 0 on success (non-partitioned systems or valid XCP 
>>>>>>> found),
>>>>>>> + *         -EINVAL if xcc_mask is NULL, no matching XCP id is 
>>>>>>> found, or the
>>>>>>> + *         partition's GFX IP details are unavailable
>>>>>>> + */
>>>>>>> +int amdgpu_xcp_get_xcc_mask(struct amdgpu_device *adev, int xcp_id,
>>>>>>> +                uint32_t *xcc_mask)
>>>>>>> +{
>>>>>>> +    struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
>>>>>>> +    struct amdgpu_xcp *xcp;
>>>>>>> +    int i;
>>>>>>> +
>>>>>>> +    if (!xcc_mask)
>>>>>>> +        return -EINVAL;
>>>>>>> +
>>>>>>> +    if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION) {
>>>>>>> +        /* Non-partitioned: return the device's full XCC mask. */
>>>>>>> +        *xcc_mask = adev->gfx.xcc_mask;
>>>>>>> +        return 0;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    /* Partitioned system: get this XCP's XCCs */
>>>>>>> +    for_each_xcp(xcp_mgr, xcp, i) {
>>>>>>> +        if (xcp->id == xcp_id)
>>>>>>> +            return amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX,
>>>>>>> +                               xcc_mask);
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    return -EINVAL;
>>>>>>> +}
>>>>>>> +
>>>>>>>   int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
>>>>>>>               const struct pci_device_id *ent)
>>>>>>>   {
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/ 
>>>>>>> gpu/ drm/amd/amdgpu/amdgpu_xcp.h
>>>>>>> index 692508be23fb..6eed82ad49b1 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>>>>>>> @@ -44,6 +44,7 @@
>>>>>>>   #define XCP_INST_MASK(num_inst, xcp_id)        \
>>>>>>>       (num_inst ? GENMASK(num_inst - 1, 0) << (xcp_id * 
>>>>>>> num_inst) : 0)
>>>>>>>   +struct amdgpu_device;
>>>>>>>   struct amdgpu_fpriv;
>>>>>>>     enum AMDGPU_XCP_IP_BLOCK {
>>>>>>> @@ -219,26 +220,23 @@ amdgpu_get_next_xcp(struct amdgpu_xcp_mgr 
>>>>>>> *xcp_mgr, int *from)
>>>>>>>       for (i = 0, xcp = amdgpu_get_next_xcp(xcp_mgr, &i); xcp; \
>>>>>>>            ++i, xcp = amdgpu_get_next_xcp(xcp_mgr, &i))
>>>>>>>   -static inline int amdgpu_xcp_get_num_xcc(struct amdgpu_xcp_mgr 
>>>>>>> *xcp_mgr,
>>>>>>> -                     int xcp_id)
>>>>>>> +int amdgpu_xcp_get_xcc_mask(struct amdgpu_device *adev, int xcp_id,
>>>>>>> +                uint32_t *xcc_mask);
>>>>>>> +
>>>>>>> +static inline int amdgpu_xcp_get_num_xcc(struct amdgpu_device 
>>>>>>> *adev, int xcp_id)
>>>>>>>   {
>>>>>>> -    struct amdgpu_xcp *xcp;
>>>>>>>       uint32_t xcc_mask;
>>>>>>> -    int i, r;
>>>>>>> -
>>>>>>> -    if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION)
>>>>>>> +    int r, count;
>>>>>>> +
>>>>>>> +    /* Derive the XCC count from the partition's XCC mask (or 
>>>>>>> the full
>>>>>>> +     * device mask when not partitioned). amdgpu_xcp_get_xcc_mask()
>>>>>>> +     * handles both partitioned and non-partitioned cases.
>>>>>>> +     */
>>>>>>> +    r = amdgpu_xcp_get_xcc_mask(adev, xcp_id, &xcc_mask);
>>>>>>> +    if (unlikely(r))
>>>>>>>           return 1;
>>>>>>> -    for_each_xcp(xcp_mgr, xcp, i) {
>>>>>>> -        if (xcp->id == xcp_id) {
>>>>>>> -            r = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX,
>>>>>>> -                            &xcc_mask);
>>>>>>> -            if (unlikely(r))
>>>>>>> -                return 1;
>>>>>>> -            else
>>>>>>> -                return hweight32(xcc_mask);
>>>>>>> -        }
>>>>>>> -    }
>>>>>>>   -    return 1;
>>>>>>> +    count = hweight32(xcc_mask);
>>>>>>> +    return count ? count : 1;
>>>>>>>   }
>>>>>>>   #endif
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/ 
>>>>>>> drivers/ gpu/drm/amd/amdgpu/mes_userqueue.c
>>>>>>> index 16aa22b25098..1c7b2f3227e5 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>>>>>> @@ -503,8 +503,7 @@ static int mes_userq_mqd_create(struct 
>>>>>>> amdgpu_usermode_queue *queue,
>>>>>>>                   uq_mgr_to_fpriv(queue->userq_mgr);
>>>>>>>               int num_xcc;
>>>>>>>   -            num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr,
>>>>>>> -                             fpriv->xcp_id);
>>>>>>> +            num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>>>>>>>               trap_params.ctx_save_area_address =
>>>>>>>                   compute_mqd->ctx_save_area_va;
>>>>>>>               trap_params.cwsr_sz = compute_mqd->ctx_save_area_size;
>>>>>>
>>>>
>>

