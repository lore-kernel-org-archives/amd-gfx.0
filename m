Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34027C982FA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 13:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB3A10ED01;
	Tue, 22 Sep 2026 13:46:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bXB9qYOi";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010050.outbound.protection.outlook.com [52.101.46.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4651310ECFF
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 13:46:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYbaVK+unTED8UqnCyWPbDU2hL1C34oeDVYV4kjPKc0e6EzkLmo69Lyz2i5q55dZwDV6w9TeSNkbDr8zl85zMX1fSLfuoTpFsXe6mpoq3Xybsab51YzHqSR2cXcqM5ZYOFPJUFEWGQ5KqJcQmJ4NXuxYjGGgeZ1i27TvzxaK7Rqjqe3A6zL/3ZQQrgK4Jq9xyk+kssEyrOQNJggbiuNcBErCyiYPzgkt2JD/9HBklGmyFdYWNwINMtohgCYHReN6sC93iHx8TwMPf0AtPZHsJoAz1Gh+dIi9NHFY3jRcnuCiGbboOLyJNfKbxU93AsI0Fe76KzCiX+ZLokr+1nqx6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITha9AfjrtSOut96pVlaA5g0abdeZwOkO8oEQZAe7Xw=;
 b=wrKvcXhecEmTmL1K+XKxewgvo9Q/QX3JA5CNbZcBI8Nk48YAYaB4pBc+EzrZNtPjEjMWq9WhfFmW2zNbhXsBkq0HazWh57SmeT1xRWO2R9nuYpFs/IzpZ2xro12qhiReM84K1NutX3mARjlb1IP6OrJdUy4sgBKVe4lDJgIp4m13YxQoTz8VCYvoy5vhsSjnISbwe21SOBKrkDU3Uyemyo+HubbaS7pWG3FmrvPoRYrMhvIXo/ckgdl+40PgX3NlXwwid8bttzB4t89ohVrXSg3hxK97fkXvwU0UDu54IU1PQMVRCe+6tE5zwIM11+NB0s4exHsUYhJtsJ+o5Yt6fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITha9AfjrtSOut96pVlaA5g0abdeZwOkO8oEQZAe7Xw=;
 b=bXB9qYOiCybvB28wqVXQfz2VIY37WSeiYSDdoU84j269c/3dRdlZZJNezhJKGpNfUlw0k99d/cfA+YTPn6QcYFbyE5KmWmdDckULy1qC9CtC8fFbRcF+kfboim2tMYgBY41LdoG66+oy0l7zxUtmyw1zZ8mFZFGPkwQoMBLybqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by SA0PR12MB4494.namprd12.prod.outlook.com (2603:10b6:806:94::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 13:46:05 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%6]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 13:46:05 +0000
Message-ID: <0e573608-7f9e-4f3e-ac58-cf375962ae2b@amd.com>
Date: Tue, 22 Sep 2026 19:15:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] drm/amdgpu: add amdgpu_xcp_get_xcc_mask helper
To: James Zhu <jamesz@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, Bing.Ma@amd.com
References: <20260921200313.865829-1-James.Zhu@amd.com>
 <20260921200313.865829-4-James.Zhu@amd.com>
 <8f06398f-e207-45b0-ab85-931ccac35b65@amd.com>
 <ce3dbd30-31e6-4680-8618-2144fe44a928@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <ce3dbd30-31e6-4680-8618-2144fe44a928@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0324.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:222::19) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|SA0PR12MB4494:EE_
X-MS-Office365-Filtering-Correlation-Id: d3279f68-0e02-4978-19be-08df18afd888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|3023799007|11063799006|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: SrI/IBHOAb6cVpXFFu0ixDHQ1G0GwbBCSHZtLnr1H5BnHqyXX423PiyYjcer58fvnxUSjqvXZjVCGeMJmBWWIk9m7+66r70yAh8+wUgS1emBiODTQ6u6JVk5qlNaYPtBHiS3KqXfiCAaYJVKFkmNijeafYrT72AbJ8HB4uw+Y94c3jMDPegbrtTjhmLR/9ANk0z74xGU+xT8WRaxGYgX3u4ryQILV9LDUyaKFEX0ESUPUBh5MRNBRHdgPvrhX+JmIQoHdtcrsWdjoh5RnOEoozvN9cq54+rQX+xOp934+bGvWBjzEn1ogd98AXFYWWKQnplnTE7OWm4K5j/aMP5vcXcC9I8vyU45svLbX8hTQZ09pp8loon/E4eeFsQMOVOe9Rn2Wh2h9DAy2mNLZ+SWGousj9grYMKZrDGOroyx+OoubaEY8Ikd5t0Dmq0Z9yR3fgmIZAL5ESwxYg3qyJ5IsQNjnSTIZNK70Z3WRUa8IVl9wUFAEXI9jfFnCPskTpcn2/+Sei2dapozkXmA094TErAo3Jdnvz4w+dxD5H0AWbAAbefi/aUUwV4I1HDHkUtueGTyKqSgeVJ326Xwx79b/8TXXsrrHr9IwEo8RS+PrWBIrjoRgNjevZ4WTxgo4W0pXtkQL38DxSCpuyyLoSzccWr/4ahPTBWi2s5LvqPgO2U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(3023799007)(11063799006)(10067099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2xMKy9NSXYzaHJlSGZjYitwSWZpVUtmUkdKYStPMFJjUndBK0Q4WThkNk4x?=
 =?utf-8?B?aDhHdDhEaGVGNFcxSUNEUjF0V3Y5WC9mWFIwVFBvK1dDK3VUSzFEL2lWM0xx?=
 =?utf-8?B?Tjg5RDVMNURNYWZnc3JQTXRKYWFReG1kampLeGk0NDF6V3Y5U0ZMdElZQVND?=
 =?utf-8?B?QWRuVWtmclBFZW9taXZENHNTRVBDeGM4UDg2TnFIbFU2L1YzeForaTNZUEQ5?=
 =?utf-8?B?NVg4ZTJVdFQvbGlTK3IraWRzK3Q4eFYrOWxQcnBuSENHSnZyY1hnQTRYaUVT?=
 =?utf-8?B?c0JaR1lWNUR1Y21xOE5ycWlhdmVvaEE4QWVzbjBuNXVTQWlyc1ZQWlVrWkt1?=
 =?utf-8?B?emxuMjNaSWVRYlVaRUd6MnkwK0JNNVJ1TDRtckNXQ0pYenRVVnNsTlYvS28x?=
 =?utf-8?B?TjVjL0ZwQlBtaEs5L29tN1VkUXhNbUFCMFFHS2E0YS92b2hDOG4ydW1VUFFY?=
 =?utf-8?B?NDlpVU8wb0owTUF5ek5NOXcrQkhLQ0NIK0lOU1ZWaXB6Zm90WFBsa0ZwWXQr?=
 =?utf-8?B?b0F6WWhUM01VdnMwN2cwV0VoMzdMM0JHNXAyVHlNa1VzdmpkQ0NHNmZETWVS?=
 =?utf-8?B?TEhCTnA4VmtQYWlSUWNRNEFQazZlS0NVdG1mMHRJRmFZT0pTSXZlaXpCVDRK?=
 =?utf-8?B?bTNsVy9xNmdQcjI2UHNZbkJHMzBiV245RzA3Vk9UcXg1V0I5YmQ2RERDZ1lp?=
 =?utf-8?B?Vy9TMUdTMWdXYTBlSjczUHR4OWN2TEcydGx2d1dPcGVzUUJPTnN3ZVRQd1NS?=
 =?utf-8?B?WVVsT3RhZ3AxclUwSzNtZkd0RHExQSs0STZ4aUJhRG5yRUFXQ0Q4TWZ1bzRk?=
 =?utf-8?B?WXBhZThiYTIrcU5pcFRsVmkxamQ5U2VNU1UvQytBclhzUFBwZWZ0ckUyRWFa?=
 =?utf-8?B?c25kbEtWOXlrckxDZnBCdHlSZHF0YlRsM2xYQTY5L1Z6dTBtTE82Nko4cDB0?=
 =?utf-8?B?ekxxZnNLTFMxRVpBeVV4ZzN2dGdvcXBTaTJEWk5FN2dRM0plL05vSkY0cU1I?=
 =?utf-8?B?a3N6MFZQWkNaNWplcHhsdEZ5UWdDT2tlR1F2aVh1T25Icms3NFUySmlSRjNO?=
 =?utf-8?B?VWI4TGFUeGJhTUdvUUNYYzRXclNDbGdBU3FGYS9JZVlQVG1ZNlJobUZ3VjFK?=
 =?utf-8?B?NXBBcDErSi8wazJ4VFFkU0QydEVxdjFqR3YxL2JhTzZndGg3RzYzTWZadllv?=
 =?utf-8?B?T2NqbXN6dFJLMkxwOWdSbTB6bytFM096Qjc1bHAyaHA3TjBFNkJicjhpL3BI?=
 =?utf-8?B?OHhCVXBCWk5XSHFBTmQ2UHU1THJGekhSbzhjODczekFXQ0lGTk5vTXBXd3JK?=
 =?utf-8?B?RDgvTUtqRWFtMW45ZnRFRXp0by9ORC9rWGlmYkJCV095WEpFdlR3OGYxY3pn?=
 =?utf-8?B?V2xRaTZmRXFDTmVOWm5xRnRkdy9IN09VTjd4SW1PYWd6bEFqK0s1V0c1VW1p?=
 =?utf-8?B?UG9aMEt2U3FmVFJBTm5aTjlSOWp5YW5oL2ZnODlOVExRaTFwY0k4K0tQVXZI?=
 =?utf-8?B?dVJFMDY5WWhtSnpRNDRkcVh6WlpZNSsrQ1BLM2FkL2pNN3cwc05xcS9DWGdW?=
 =?utf-8?B?Wmp1ekR4UXIrSTY2UWFzcHRPNnUxSFo2ZGw3OC8vOEIzMy9uRFZTNzZ2anVu?=
 =?utf-8?B?YTIxbElMS1VTV0xWbVRMb28yd3U5OE9TRVB0VU96eTVldThTY3F4M0VOTGUx?=
 =?utf-8?B?ajlSM2lhZVp3L1diUVlOVVNJdjBWdjdBWFBCWnFNVGFlbUlTdExLMHlvNmtD?=
 =?utf-8?B?ZlAvY3JqcnVGRkdmZ1BFTmlDa3V5L2RFa21jaTNaTjJlbTdBWFRmZmdMVkNy?=
 =?utf-8?B?TjIvbDNuWm51ZFdlOTRreWFBL0RkbzlzRWtrZ3puaTUwR2tVYmN3OE5nbXhW?=
 =?utf-8?B?bzdQanRoRWE3REp6alZaUE9Gdm51WU9LenRxQWtLNitnSXpiU2dDeUJZUEFy?=
 =?utf-8?B?MUJ3bjFqK0VHYzR5ZVUwTTVPcGg5M1dobFNYZzRXRytOUUFtQ2pEM3V4eHdL?=
 =?utf-8?B?UktTU05YcFlBaFJPU2pocWdsZFhYaE8vVVJidndybE1IdHVVWEhVaFlhdVZH?=
 =?utf-8?B?VVhPa3FRZlVRUnd4YmFuQmx1Q3YybytoOUlRaWhCSUlBeTVhRWF0cWxHSi9X?=
 =?utf-8?B?SXBUWWk0TzBsUGhieTVrVnJySm0yZEJRZVd1ZGZEc0ZDcHE2ZE9FWFBzL01k?=
 =?utf-8?B?aUE3azF6QmVyV3FSQnZ3R2NpZHhTVkt6TGJxT2tDd1haZ2JKN0c1bWxxTk1N?=
 =?utf-8?B?cGlwSEMxTkFQUE5URnBvQ2MxSUR4b09YREJhdHNRVkpCYlh0M3FrV25QclVZ?=
 =?utf-8?Q?dVcgOJAejhx+Odq6cn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3279f68-0e02-4978-19be-08df18afd888
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 13:46:04.7753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bjs3N67gLigAK9++ddQadky6slVGt4SrPY7Qjvjv0lCkbDLP6Wvu3MxSf8auMFzV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4494
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



On 22-Sep-26 7:05 PM, James Zhu wrote:
> 
> On 2026-09-22 01:22, Lazar, Lijo wrote:
>>
>>
>> On 22-Sep-26 1:33 AM, James Zhu wrote:
>>> Add amdgpu_xcp_get_xcc_mask() to return the XCC instance mask for a 
>>> given
>>> XCP partition. This is needed by upcoming SPM (Stream Performance 
>>> Monitor)
>>> support, which programs hardware per partition and must operate only on
>>> the XCCs that belong to a given XCP.
>>>
>>> For partitioned systems the helper returns only the XCCs belonging to 
>>> the
>>> specified XCP. When @xcp_id is AMDGPU_XCP_NO_PARTITION (or the device is
>>> not partitioned) it returns the device's full XCC mask (e.g. 0xFF for an
>>> 8-XCC device). Note that the full device mask is returned even on a
>>> partitioned device; callers that require partition isolation (e.g. SPM)
>>> must reject AMDGPU_XCP_NO_PARTITION on a partitioned device themselves.
>>>
>>
>> Could you clarifiy on this part - xcp_id = AMDGPU_XCP_NO_PARTITION 
>> usage on 8-XCC device?
>>
>> The default state on a multi-XCC device after driver load is all XCCs 
>> in a single partition called SPX. It should have at least one 
>> partition valid.
> 
> [JZ] Yes, 8-XCC device should not reach AMDGPU_XCP_NO_PARTITION case.
> 
> the if(!xcp_mgr ||xcp_id ==AMDGPU_XCP_NO_PARTITION) mainly covers non 
> partition device, I can remove the above comments which don't reflect 
> the source accurately.

Then I'm not sure what issue this is fixing.

Multi-xcc devices will be in SPX mode and will return a mask with all 
the XCCs. Non-multi xcc devices are expected to have this set to 1 
anyway to reflect that a single GC is present always.

Thanks,
Lijo

>> Thanks,
>> Lioj
>>
>>> amdgpu_xcp_get_num_xcc() is reworked to take (adev, xcp_id) and 
>>> derive the
>>> count from this helper via hweight32(). The helper is defined out of 
>>> line
>>> in amdgpu_xcp.c so that the static inline in amdgpu_xcp.h never has to
>>> dereference the (incomplete) struct amdgpu_device; it only passes the
>>> pointer through.
>>>
>>> This is a user-visible change: amdgpu_xcp_get_num_xcc() previously
>>> returned 1 for non-partitioned systems (and for 
>>> AMDGPU_XCP_NO_PARTITION),
>>> and now returns the actual XCC count (e.g. 8 for an 8-XCC device). CWSR
>>> callers (amdgpu_kms.c, amdgpu_userq.c, mes_userqueue.c) scale the 
>>> per-XCC
>>> control-stack and debug-memory sizes by num_xcc, so the uAPI-visible
>>> ctl_stack_size and dbg_mem_size values grow accordingly to match the
>>> actual hardware resource requirements, which were previously undersized.
>>>
>>> Fixes: 4cd417bfec49 ("drm/amdgpu: Add helper function to get xcc count")
>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>> Reviewed-by: Bing Ma <bing.ma@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 48 ++++++++++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    | 32 +++++++--------
>>>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  3 +-
>>>   5 files changed, 66 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/ 
>>> drm/amd/amdgpu/amdgpu_kms.c
>>> index 57fa69c0382d..7782ccd4d28f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> @@ -1501,7 +1501,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, 
>>> void *data, struct drm_file *filp)
>>>           fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
>>>           if (!amdgpu_trap_is_enabled(adev) || !fpriv->trap_obj)
>>>               return -EOPNOTSUPP;
>>> -        num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
>>> +        num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>>>           cwsr_info.ctl_stack_size =
>>>               adev->trap_info->cwsr.xcc_ctl_stack_sz * num_xcc;
>>>           cwsr_info.dbg_mem_size =
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/ 
>>> drm/amd/amdgpu/amdgpu_userq.c
>>> index db09e879b85e..d19af9cb6ee1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -258,7 +258,7 @@ int 
>>> amdgpu_userq_input_trap_params_validate(struct amdgpu_usermode_queue 
>>> *queue,
>>>       int num_xcc;
>>>       int r;
>>>   -    num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
>>> +    num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>>>       r = amdgpu_trap_validate_params(queue->userq_mgr->adev, 
>>> trap_params,
>>>                       num_xcc);
>>>       if (r)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/ 
>>> drm/amd/amdgpu/amdgpu_xcp.c
>>> index 2a56f5ec9c76..90846d55292b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>> @@ -390,6 +390,54 @@ int amdgpu_xcp_get_inst_details(struct 
>>> amdgpu_xcp *xcp,
>>>       return 0;
>>>   }
>>>   +/**
>>> + * amdgpu_xcp_get_xcc_mask - Get XCC instance mask for a partition
>>> + * @adev: amdgpu device pointer
>>> + * @xcp_id: XCP partition ID
>>> + * @xcc_mask: output parameter for XCC instance mask
>>> + *
>>> + * Returns the XCC instance mask for the specified XCP partition.
>>> + * For partitioned systems, returns only the XCCs belonging to this 
>>> XCP.
>>> + *
>>> + * When @xcp_id is AMDGPU_XCP_NO_PARTITION (or the device is not
>>> + * partitioned), the device's full XCC mask is returned (e.g. 0xFF 
>>> for an
>>> + * 8-XCC device). Note that the full device mask is returned even on a
>>> + * partitioned device: callers that require partition isolation 
>>> (e.g. SPM)
>>> + * must reject AMDGPU_XCP_NO_PARTITION on a partitioned device 
>>> themselves.
>>> + *
>>> + * Note: On error, xcc_mask is undefined. Callers must check return 
>>> code
>>> + * and only read xcc_mask when return == 0.
>>> + *
>>> + * Return: 0 on success (non-partitioned systems or valid XCP found),
>>> + *         -EINVAL if xcc_mask is NULL, no matching XCP id is found, 
>>> or the
>>> + *         partition's GFX IP details are unavailable
>>> + */
>>> +int amdgpu_xcp_get_xcc_mask(struct amdgpu_device *adev, int xcp_id,
>>> +                uint32_t *xcc_mask)
>>> +{
>>> +    struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
>>> +    struct amdgpu_xcp *xcp;
>>> +    int i;
>>> +
>>> +    if (!xcc_mask)
>>> +        return -EINVAL;
>>> +
>>> +    if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION) {
>>> +        /* Non-partitioned: return the device's full XCC mask. */
>>> +        *xcc_mask = adev->gfx.xcc_mask;
>>> +        return 0;
>>> +    }
>>> +
>>> +    /* Partitioned system: get this XCP's XCCs */
>>> +    for_each_xcp(xcp_mgr, xcp, i) {
>>> +        if (xcp->id == xcp_id)
>>> +            return amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX,
>>> +                               xcc_mask);
>>> +    }
>>> +
>>> +    return -EINVAL;
>>> +}
>>> +
>>>   int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
>>>               const struct pci_device_id *ent)
>>>   {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/ 
>>> drm/amd/amdgpu/amdgpu_xcp.h
>>> index 692508be23fb..6eed82ad49b1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>>> @@ -44,6 +44,7 @@
>>>   #define XCP_INST_MASK(num_inst, xcp_id)        \
>>>       (num_inst ? GENMASK(num_inst - 1, 0) << (xcp_id * num_inst) : 0)
>>>   +struct amdgpu_device;
>>>   struct amdgpu_fpriv;
>>>     enum AMDGPU_XCP_IP_BLOCK {
>>> @@ -219,26 +220,23 @@ amdgpu_get_next_xcp(struct amdgpu_xcp_mgr 
>>> *xcp_mgr, int *from)
>>>       for (i = 0, xcp = amdgpu_get_next_xcp(xcp_mgr, &i); xcp; \
>>>            ++i, xcp = amdgpu_get_next_xcp(xcp_mgr, &i))
>>>   -static inline int amdgpu_xcp_get_num_xcc(struct amdgpu_xcp_mgr 
>>> *xcp_mgr,
>>> -                     int xcp_id)
>>> +int amdgpu_xcp_get_xcc_mask(struct amdgpu_device *adev, int xcp_id,
>>> +                uint32_t *xcc_mask);
>>> +
>>> +static inline int amdgpu_xcp_get_num_xcc(struct amdgpu_device *adev, 
>>> int xcp_id)
>>>   {
>>> -    struct amdgpu_xcp *xcp;
>>>       uint32_t xcc_mask;
>>> -    int i, r;
>>> -
>>> -    if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION)
>>> +    int r, count;
>>> +
>>> +    /* Derive the XCC count from the partition's XCC mask (or the full
>>> +     * device mask when not partitioned). amdgpu_xcp_get_xcc_mask()
>>> +     * handles both partitioned and non-partitioned cases.
>>> +     */
>>> +    r = amdgpu_xcp_get_xcc_mask(adev, xcp_id, &xcc_mask);
>>> +    if (unlikely(r))
>>>           return 1;
>>> -    for_each_xcp(xcp_mgr, xcp, i) {
>>> -        if (xcp->id == xcp_id) {
>>> -            r = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX,
>>> -                            &xcc_mask);
>>> -            if (unlikely(r))
>>> -                return 1;
>>> -            else
>>> -                return hweight32(xcc_mask);
>>> -        }
>>> -    }
>>>   -    return 1;
>>> +    count = hweight32(xcc_mask);
>>> +    return count ? count : 1;
>>>   }
>>>   #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/ 
>>> gpu/drm/amd/amdgpu/mes_userqueue.c
>>> index 16aa22b25098..1c7b2f3227e5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> @@ -503,8 +503,7 @@ static int mes_userq_mqd_create(struct 
>>> amdgpu_usermode_queue *queue,
>>>                   uq_mgr_to_fpriv(queue->userq_mgr);
>>>               int num_xcc;
>>>   -            num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr,
>>> -                             fpriv->xcp_id);
>>> +            num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>>>               trap_params.ctx_save_area_address =
>>>                   compute_mqd->ctx_save_area_va;
>>>               trap_params.cwsr_sz = compute_mqd->ctx_save_area_size;
>>

