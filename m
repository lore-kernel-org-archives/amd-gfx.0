Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85342C98302
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 13:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 987AF10ECC5;
	Tue, 22 Sep 2026 13:36:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ESoBnlue";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013071.outbound.protection.outlook.com
 [40.93.196.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5723410ECBA
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 13:36:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JfYs3zyp17Ph64kgIbEWKbM6jECHYBt0ddu/8wjpq93GOmpdTA9OSJbU7fXn+GRCuExqMp18VFzdMMdsX0aRrCUCleM7F4aL//nfIdrG+HXllwT4gmwKwZlF3ibcehyT0DKkD72z25g2FXLKEy8kQTMmJMWo2pKPVt6Br6IO3ZC5pj8ymHkeDnSJG1EBI8NPFmIAf+w6BhS39ODQIkWIvwO6T6rTOL7nxeG1Ric8Q5YsC1STKCHyb0BjWZv/WdW2KeGoz7t1r7RRNuSr14IcDYqSNDZ0AyaXz1ssyhOcuUaIUnZ6Ock13kk9F5qVPKnprFa1To0/+d1LRUiCpnw80Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ak6YMO7xkRFPJRwFhcl6lf/nfSQCnVpIc9DBFommv9A=;
 b=eav4dPMZr5y2ryNVqsFZjv1R1aC1O60Nt47P9MR6dHinRtjkJCWYk4GZQ39VB3Ic0HiVMLIpS2uGH20LUycWvbaB6hCthgHVuyQPUXIDJ7dxkOBhe0v2XZcQTFqwXzK2n4LDOsJJtuZll/K3djt2019I1Azwl2O53fFAIO/4UTZVSQBj/tU5qHsGnqEafJzgVL9o+eRhOg2Y+i5jXMyMUvq8kKoZNwo73vhUWvlGSTjwLFPa06OJ1zW0wLKmlMX5A5fYuwZFn9HOV2gaBQnXQY0+zIsmZoks65RMcHV6Z0ZM9MybZzKUWLd1/Ufqv6cOPSRYyCqpBvP37KQXOX358g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ak6YMO7xkRFPJRwFhcl6lf/nfSQCnVpIc9DBFommv9A=;
 b=ESoBnluefTlzSBeWXXYd7Qc0H0EQMIFfPSDIje4lSf7LIOGxjVjcXwt8Wjzmf3SvoIqRlTNabumd1Y9oRHpM5+fkn4kdRk8w54JRg1AWsnEb8+zQpz4XNq9YJ/mEfr3T8XPBJxb5l4KXfatgZNui5FyqUPE4PKOizOtY1qT3tys=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Tue, 22 Sep
 2026 13:36:00 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422%3]) with mapi id 15.21.0406.007; Tue, 22 Sep 2026
 13:35:56 +0000
Content-Type: multipart/alternative;
 boundary="------------cdJnF7u8VTf68v4IeAWglwQF"
Message-ID: <ce3dbd30-31e6-4680-8618-2144fe44a928@amd.com>
Date: Tue, 22 Sep 2026 09:35:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] drm/amdgpu: add amdgpu_xcp_get_xcc_mask helper
To: "Lazar, Lijo" <lijo.lazar@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, Bing.Ma@amd.com
References: <20260921200313.865829-1-James.Zhu@amd.com>
 <20260921200313.865829-4-James.Zhu@amd.com>
 <8f06398f-e207-45b0-ab85-931ccac35b65@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <8f06398f-e207-45b0-ab85-931ccac35b65@amd.com>
X-ClientProxiedBy: YQBPR01CA0147.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::8) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|MW6PR12MB8898:EE_
X-MS-Office365-Filtering-Correlation-Id: 6988c268-5b40-46ca-10fb-08df18ae6e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|3023799007|56012099006|4143699003|10067099003|11063799006|8096899003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: p+7glEmozEuFI266w9T1seyAgF4Mhgas0kf7HKEkVFJoJz40L4S1WTyk9gUb2aGvCxzwVl/vfL66ZwvKVY891JNRBhvJQTR7NU3xqKx4crVDgep2fE8WtrwS7Vk87ZUSUbb0HNhlPn9UBExvPzcOvZpvoU2iUAAZTItW407P1sC42JEevv6EDBRAEn+lqX8IW/H/VkdqxzAq7dE+kSTNGd8RwVeKT7iNZx6yx7f58fDzGY6xvvlDwtYUJIH9Wr8f5RJL+bB6uVrZVpX0LNjyQpnpbRncdrSRQqDF8gu4JL+fYZgLTGYLf3+uPb97H9l8tYDJjjzc/kZUOSzbB4c8t87sUUQaYbViTkBdnfmx6dSjv/sE9K7gbVR6bnVJUyBgc5KVjPYgSbL+8jXqT6kRNy2smTbSUyc5DPMRQimzgVOelIyyZ99HGLLDp3dZdzho7oql2mQlxqpcHxH7n/VBXFPWFWm7rbMlV6hw5qpWleOvrMyvooRV33CTbx7/TDOOBrHh5YIvlFfP+zZxSiMEvbIjzXIrLDhI4lWU4+ixDWMG1woJEk5nezkEYh1LJwW3pj2+9ks8BS8GrEE7gnRiTvcGUtyTtQYySDq+OrvuYnY8Z49Z77ZyspgFetqF4TVpK6TyEKi5WZoeQziaEPg1aW7mEu6PIs8AK5pASNVeiP0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(3023799007)(56012099006)(4143699003)(10067099003)(11063799006)(8096899003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0NyNWp1eDdlZHUwVDhMSDFXNzRxdDdoRkswem01aDk0Q1JPelFzY08yRGxN?=
 =?utf-8?B?dnVBbWpsa0RRZUJCSXEyUzFuVU1vWWRlVmxkNnF2NndDTnB6MzFCWU4yblJs?=
 =?utf-8?B?Z0tTSVhVVTFaMmNHZXFLOENRckVyRmJvcW1jTUZONDhWY2NMRFJXVXlieFVX?=
 =?utf-8?B?RXY4ME8xUnhkaXk5RE9OZmNoaTJ1L3lZSjBHdEJmaFZQR2k4ejJWTExkcENY?=
 =?utf-8?B?dnlPUDFTdENGUmV6c0xDaHlta1M3bFIrUDFLNjlzVlJJdm54eVp0UWM4VWNi?=
 =?utf-8?B?eCt2Wjh1UVJLVHQ1SGlCTjFpVllxa1ZEWm9zSVAyNW51MDh6b0hIaXEzWHUy?=
 =?utf-8?B?TnYwYWVMKzdRaGQydkpsUFNoMldtMjZpbjB0YWtzcmVycFVEM2hWdmdFUzBu?=
 =?utf-8?B?VE95ZzJSZCtOMUQvMEVBQ1lsbGhlRnpONTNZTU9rZjVTUHdxQWU1Mzh5b21H?=
 =?utf-8?B?M2MxMGpaVUM4RENSVlJ1bmQ5bGdGUXVZdmZaUmNxWXZROXpmVVNzYnlrTlZJ?=
 =?utf-8?B?UlJmT3doWG5JSm1wNjRVRE1nekVHUklJUXozdGdUOXc1SWV1SEFuazZ1YjY2?=
 =?utf-8?B?VU9qK0djOHVqbVJKZE5NRmxNVjFUUkhIVkpVd29EWDFLNW9GeUxQaFAvYlNz?=
 =?utf-8?B?Ym9kbVgzeTNITENidkx6U29tdWFDSTRLN2w0OHJXcFQrWlV4NEFkbUVneEhR?=
 =?utf-8?B?MnhEd2k4SGptK3RRYkc3QUZMOUF6WEhXU2F0aWpUSmxDOGRxQnpnSWFCazAw?=
 =?utf-8?B?Y1pPd3RHa3FhK0Fpa0NDbkRQMWx3UnFMYmZyRjREVEdrYXdLQnZtazVTTVNz?=
 =?utf-8?B?K3BOMjljRmFnZmx4aTJYZlZhMEZxQ0QrSy81Tnk3Z1c0QWl5VzRKSDlxWUpZ?=
 =?utf-8?B?bzlMbkRlVzFCY2paSzM3ck9Ncm9NV3hWNlM4akZzMUgyajZXTGNka3U1UXBE?=
 =?utf-8?B?MzY1VHEvZHFvY2Ziem5jQkE3YjcrQlVZRHlLSCtDMG5RQW8yeTlzL1RYaTN6?=
 =?utf-8?B?MTVUUWVoam9TWWRYY2dENFF3QnhVRVR3TEJMWUlrMlI1dnZSVUdubXllZVRR?=
 =?utf-8?B?dEppYXREVDJVcUNqdHZTTjBIM2N4K3NaT3JzUkV0bFRUVHlmUS9PS2N5L2hN?=
 =?utf-8?B?ZWF2ZGRsRXp3VTZ1THJVUGI5OTNsU0lmVUpMZnBiaWpOUDFiSzV6MEtTcDRW?=
 =?utf-8?B?L0hTUUtORjZlV0RlbFZEdHRXbkppNTFtRFhQZ1FXd2Q1d1I2N3p5S0ZhTERF?=
 =?utf-8?B?Y0ZKMUVIc1ZVdXdyb3h2SU04MmRKRjFTMVkxVEZua2RTN2Z2c3d1RCs1WHdW?=
 =?utf-8?B?R3ZiaElTR05jNTE1WXJMT0ZUbG4yR055T2IzOVBWeGRTZjU5dDFURXRBZGRk?=
 =?utf-8?B?ZEoxcWRiZFNUaWM1QjllbzI3ZGMrVWlFTEgxMnUvdU8zU0Mvb1EzUHpRQ0RG?=
 =?utf-8?B?cHFJZHQwQXdOcE1mK2EyZWRIVHI4MnE3UVhNQjBLbUVaV05xdmY1M2lEdms1?=
 =?utf-8?B?emZxTE9vdjRSTDRFdzdRY0FYKzM0K0ZkLzJWdTVHRjNYdTlHMTRaYng0ZDB5?=
 =?utf-8?B?Y3ZMaUI0YWxmM1kvcWYyRTdiWEx2K1BJUlJiMWEyZzE1cnVVZFhkeXFmYWZH?=
 =?utf-8?B?VEVjcG5vdm5tajZBRmtDb2hUR3dWK01aZjhJcEJKakpyMWNsV1l1TlBrdnJF?=
 =?utf-8?B?eUNxbnFnVUk5RHRKVEdHbkNOZzl2VGk0R0VNbm91MG8yM2RKSllkSGk0ZGdF?=
 =?utf-8?B?MmhaUlRWMEJXTnFHWXE1ck1aT2lOZXM3Zyt3cGk2QUtDOHBLeXlTZisyVWtS?=
 =?utf-8?B?VytRQzZLOWw4dEIxZFpBNGdITlR4S3kzRW8rZjhoV2tlQWl2eXdrbk43OWhD?=
 =?utf-8?B?TUxVUXJQRTM3TjBnWmNkWEo1WVlXYW1TK283UWxySHA4dlFxenhMQlppMGFa?=
 =?utf-8?B?SFlLME45ZFljYzA2eWFhTGswSWVLcGNnRmJyMlRRS01TNHJsUFlPaXFhUVBD?=
 =?utf-8?B?UjQzY1E5RUdDaEc2dzBXVjRGVnV4dW0vVVh6Z0RTazZOVGc0NEM5YkdSUzdP?=
 =?utf-8?B?bzZId0l1bGQzMEt2MVhzVytjNmVzeTlJajJDNlc1WHZUbTZpMGgxVkFLdnZH?=
 =?utf-8?B?QXdpNjd5c3BHMmxEQnVGbzY2dXVMWlVvcmxMcG5LMmcydnlrQTNHY0l3cVNG?=
 =?utf-8?B?dnJxWm5WWXNIREJiUkNTNDMvM2d6UUhkNXgydXhyM3VBTGdEbmMrUWp2cDcx?=
 =?utf-8?B?dHNIZEJ1OEFXTGliL0t5blRoMnZ6Q1JidFlmcXo2RFFkVUVrT1l4STN2VFd2?=
 =?utf-8?Q?8XtloI5icDOh2Buevl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6988c268-5b40-46ca-10fb-08df18ae6e0c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 13:35:56.1690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmQ8np+KgJ64KC794P/cEfTh81hZtX3BzmewqNbvTso7+p5OCT/k0zoaBuh1OGOi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8898
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

--------------cdJnF7u8VTf68v4IeAWglwQF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026-09-22 01:22, Lazar, Lijo wrote:
>
>
> On 22-Sep-26 1:33 AM, James Zhu wrote:
>> Add amdgpu_xcp_get_xcc_mask() to return the XCC instance mask for a 
>> given
>> XCP partition. This is needed by upcoming SPM (Stream Performance 
>> Monitor)
>> support, which programs hardware per partition and must operate only on
>> the XCCs that belong to a given XCP.
>>
>> For partitioned systems the helper returns only the XCCs belonging to 
>> the
>> specified XCP. When @xcp_id is AMDGPU_XCP_NO_PARTITION (or the device is
>> not partitioned) it returns the device's full XCC mask (e.g. 0xFF for an
>> 8-XCC device). Note that the full device mask is returned even on a
>> partitioned device; callers that require partition isolation (e.g. SPM)
>> must reject AMDGPU_XCP_NO_PARTITION on a partitioned device themselves.
>>
>
> Could you clarifiy on this part - xcp_id = AMDGPU_XCP_NO_PARTITION 
> usage on 8-XCC device?
>
> The default state on a multi-XCC device after driver load is all XCCs 
> in a single partition called SPX. It should have at least one 
> partition valid.

[JZ] Yes, 8-XCC device should not reach AMDGPU_XCP_NO_PARTITION case.

the if(!xcp_mgr ||xcp_id ==AMDGPU_XCP_NO_PARTITION) mainly covers non 
partition device, I can remove the above comments which don't reflect 
the source accurately.
> Thanks,
> Lioj
>
>> amdgpu_xcp_get_num_xcc() is reworked to take (adev, xcp_id) and 
>> derive the
>> count from this helper via hweight32(). The helper is defined out of 
>> line
>> in amdgpu_xcp.c so that the static inline in amdgpu_xcp.h never has to
>> dereference the (incomplete) struct amdgpu_device; it only passes the
>> pointer through.
>>
>> This is a user-visible change: amdgpu_xcp_get_num_xcc() previously
>> returned 1 for non-partitioned systems (and for 
>> AMDGPU_XCP_NO_PARTITION),
>> and now returns the actual XCC count (e.g. 8 for an 8-XCC device). CWSR
>> callers (amdgpu_kms.c, amdgpu_userq.c, mes_userqueue.c) scale the 
>> per-XCC
>> control-stack and debug-memory sizes by num_xcc, so the uAPI-visible
>> ctl_stack_size and dbg_mem_size values grow accordingly to match the
>> actual hardware resource requirements, which were previously undersized.
>>
>> Fixes: 4cd417bfec49 ("drm/amdgpu: Add helper function to get xcc count")
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> Reviewed-by: Bing Ma <bing.ma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 48 ++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    | 32 +++++++--------
>>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  3 +-
>>   5 files changed, 66 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index 57fa69c0382d..7782ccd4d28f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -1501,7 +1501,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, 
>> void *data, struct drm_file *filp)
>>           fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
>>           if (!amdgpu_trap_is_enabled(adev) || !fpriv->trap_obj)
>>               return -EOPNOTSUPP;
>> -        num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
>> +        num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>>           cwsr_info.ctl_stack_size =
>>               adev->trap_info->cwsr.xcc_ctl_stack_sz * num_xcc;
>>           cwsr_info.dbg_mem_size =
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index db09e879b85e..d19af9cb6ee1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -258,7 +258,7 @@ int 
>> amdgpu_userq_input_trap_params_validate(struct amdgpu_usermode_queue 
>> *queue,
>>       int num_xcc;
>>       int r;
>>   -    num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
>> +    num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>>       r = amdgpu_trap_validate_params(queue->userq_mgr->adev, 
>> trap_params,
>>                       num_xcc);
>>       if (r)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> index 2a56f5ec9c76..90846d55292b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> @@ -390,6 +390,54 @@ int amdgpu_xcp_get_inst_details(struct 
>> amdgpu_xcp *xcp,
>>       return 0;
>>   }
>>   +/**
>> + * amdgpu_xcp_get_xcc_mask - Get XCC instance mask for a partition
>> + * @adev: amdgpu device pointer
>> + * @xcp_id: XCP partition ID
>> + * @xcc_mask: output parameter for XCC instance mask
>> + *
>> + * Returns the XCC instance mask for the specified XCP partition.
>> + * For partitioned systems, returns only the XCCs belonging to this 
>> XCP.
>> + *
>> + * When @xcp_id is AMDGPU_XCP_NO_PARTITION (or the device is not
>> + * partitioned), the device's full XCC mask is returned (e.g. 0xFF 
>> for an
>> + * 8-XCC device). Note that the full device mask is returned even on a
>> + * partitioned device: callers that require partition isolation 
>> (e.g. SPM)
>> + * must reject AMDGPU_XCP_NO_PARTITION on a partitioned device 
>> themselves.
>> + *
>> + * Note: On error, xcc_mask is undefined. Callers must check return 
>> code
>> + * and only read xcc_mask when return == 0.
>> + *
>> + * Return: 0 on success (non-partitioned systems or valid XCP found),
>> + *         -EINVAL if xcc_mask is NULL, no matching XCP id is found, 
>> or the
>> + *         partition's GFX IP details are unavailable
>> + */
>> +int amdgpu_xcp_get_xcc_mask(struct amdgpu_device *adev, int xcp_id,
>> +                uint32_t *xcc_mask)
>> +{
>> +    struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
>> +    struct amdgpu_xcp *xcp;
>> +    int i;
>> +
>> +    if (!xcc_mask)
>> +        return -EINVAL;
>> +
>> +    if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION) {
>> +        /* Non-partitioned: return the device's full XCC mask. */
>> +        *xcc_mask = adev->gfx.xcc_mask;
>> +        return 0;
>> +    }
>> +
>> +    /* Partitioned system: get this XCP's XCCs */
>> +    for_each_xcp(xcp_mgr, xcp, i) {
>> +        if (xcp->id == xcp_id)
>> +            return amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX,
>> +                               xcc_mask);
>> +    }
>> +
>> +    return -EINVAL;
>> +}
>> +
>>   int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
>>               const struct pci_device_id *ent)
>>   {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>> index 692508be23fb..6eed82ad49b1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>> @@ -44,6 +44,7 @@
>>   #define XCP_INST_MASK(num_inst, xcp_id)        \
>>       (num_inst ? GENMASK(num_inst - 1, 0) << (xcp_id * num_inst) : 0)
>>   +struct amdgpu_device;
>>   struct amdgpu_fpriv;
>>     enum AMDGPU_XCP_IP_BLOCK {
>> @@ -219,26 +220,23 @@ amdgpu_get_next_xcp(struct amdgpu_xcp_mgr 
>> *xcp_mgr, int *from)
>>       for (i = 0, xcp = amdgpu_get_next_xcp(xcp_mgr, &i); xcp; \
>>            ++i, xcp = amdgpu_get_next_xcp(xcp_mgr, &i))
>>   -static inline int amdgpu_xcp_get_num_xcc(struct amdgpu_xcp_mgr 
>> *xcp_mgr,
>> -                     int xcp_id)
>> +int amdgpu_xcp_get_xcc_mask(struct amdgpu_device *adev, int xcp_id,
>> +                uint32_t *xcc_mask);
>> +
>> +static inline int amdgpu_xcp_get_num_xcc(struct amdgpu_device *adev, 
>> int xcp_id)
>>   {
>> -    struct amdgpu_xcp *xcp;
>>       uint32_t xcc_mask;
>> -    int i, r;
>> -
>> -    if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION)
>> +    int r, count;
>> +
>> +    /* Derive the XCC count from the partition's XCC mask (or the full
>> +     * device mask when not partitioned). amdgpu_xcp_get_xcc_mask()
>> +     * handles both partitioned and non-partitioned cases.
>> +     */
>> +    r = amdgpu_xcp_get_xcc_mask(adev, xcp_id, &xcc_mask);
>> +    if (unlikely(r))
>>           return 1;
>> -    for_each_xcp(xcp_mgr, xcp, i) {
>> -        if (xcp->id == xcp_id) {
>> -            r = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX,
>> -                            &xcc_mask);
>> -            if (unlikely(r))
>> -                return 1;
>> -            else
>> -                return hweight32(xcc_mask);
>> -        }
>> -    }
>>   -    return 1;
>> +    count = hweight32(xcc_mask);
>> +    return count ? count : 1;
>>   }
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c 
>> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> index 16aa22b25098..1c7b2f3227e5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> @@ -503,8 +503,7 @@ static int mes_userq_mqd_create(struct 
>> amdgpu_usermode_queue *queue,
>>                   uq_mgr_to_fpriv(queue->userq_mgr);
>>               int num_xcc;
>>   -            num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr,
>> -                             fpriv->xcp_id);
>> +            num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>>               trap_params.ctx_save_area_address =
>>                   compute_mqd->ctx_save_area_va;
>>               trap_params.cwsr_sz = compute_mqd->ctx_save_area_size;
>
--------------cdJnF7u8VTf68v4IeAWglwQF
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2026-09-22 01:22, Lazar, Lijo wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:8f06398f-e207-45b0-ab85-931ccac35b65@amd.com">
      <br>
      <br>
      On 22-Sep-26 1:33 AM, James Zhu wrote:
      <br>
      <blockquote type="cite">Add amdgpu_xcp_get_xcc_mask() to return
        the XCC instance mask for a given
        <br>
        XCP partition. This is needed by upcoming SPM (Stream
        Performance Monitor)
        <br>
        support, which programs hardware per partition and must operate
        only on
        <br>
        the XCCs that belong to a given XCP.
        <br>
        <br>
        For partitioned systems the helper returns only the XCCs
        belonging to the
        <br>
        specified XCP. When @xcp_id is AMDGPU_XCP_NO_PARTITION (or the
        device is
        <br>
        not partitioned) it returns the device's full XCC mask (e.g.
        0xFF for an
        <br>
        8-XCC device). Note that the full device mask is returned even
        on a
        <br>
        partitioned device; callers that require partition isolation
        (e.g. SPM)
        <br>
        must reject AMDGPU_XCP_NO_PARTITION on a partitioned device
        themselves.
        <br>
        <br>
      </blockquote>
      <br>
      Could you clarifiy on this part - xcp_id = AMDGPU_XCP_NO_PARTITION
      usage on 8-XCC device?
      <br>
      <br>
      The default state on a multi-XCC device after driver load is all
      XCCs in a single partition called SPX. It should have at least one
      partition valid.&nbsp;<br>
    </blockquote>
    <p>[JZ] Yes, 8-XCC device should not reach AMDGPU_XCP_NO_PARTITION
      case.</p>
    the&nbsp;<span class="kwd" style="box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(0, 0, 136); font-family: &quot;Roboto Mono&quot;, monospace; font-size: 13.3333px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">if</span><span class="pln" style="box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(0, 0, 0); font-family: &quot;Roboto Mono&quot;, monospace; font-size: 13.3333px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webk
 it-text-stroke-width: 0px; white-space: pre; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"> </span><span class="pun" style="box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(102, 102, 0); font-family: &quot;Roboto Mono&quot;, monospace; font-size: 13.3333px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">(!</span><span class="pln" style="box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(0, 0, 0); font-family: &quot;Roboto Mono&quot;, monospace; font-size: 13.3333px; font-style: normal; font-variant-ligatures: n
 ormal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">xcp_mgr </span><span class="pun" style="box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(102, 102, 0); font-family: &quot;Roboto Mono&quot;, monospace; font-size: 13.3333px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">||</span><span class="pln" style=
 "box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(0, 0, 0); font-family: &quot;Roboto Mono&quot;, monospace; font-size: 13.3333px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"> xcp_id </span><span class="pun" style="box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(102, 102, 0); font-family: &quot;Roboto Mono&quot;, monospace; font-size: 13.3333px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; w
 hite-space: pre; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">==</span><span class="pln" style="box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(0, 0, 0); font-family: &quot;Roboto Mono&quot;, monospace; font-size: 13.3333px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"> AMDGPU_XCP_NO_PARTITION</span><span class="pun" style="box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(102, 102, 0); font-family: &quot;Roboto Mono&quot;, monospace; font-size: 13.3333px; font-style: normal; font-variant-ligatures: normal
 ; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">) mainly covers non partition device,
I can remove the above comments which don't reflect the source accurately.</span>
    <blockquote type="cite" cite="mid:8f06398f-e207-45b0-ab85-931ccac35b65@amd.com">Thanks,
      <br>
      Lioj
      <br>
      <br>
      <blockquote type="cite">amdgpu_xcp_get_num_xcc() is reworked to
        take (adev, xcp_id) and derive the
        <br>
        count from this helper via hweight32(). The helper is defined
        out of line
        <br>
        in amdgpu_xcp.c so that the static inline in amdgpu_xcp.h never
        has to
        <br>
        dereference the (incomplete) struct amdgpu_device; it only
        passes the
        <br>
        pointer through.
        <br>
        <br>
        This is a user-visible change: amdgpu_xcp_get_num_xcc()
        previously
        <br>
        returned 1 for non-partitioned systems (and for
        AMDGPU_XCP_NO_PARTITION),
        <br>
        and now returns the actual XCC count (e.g. 8 for an 8-XCC
        device). CWSR
        <br>
        callers (amdgpu_kms.c, amdgpu_userq.c, mes_userqueue.c) scale
        the per-XCC
        <br>
        control-stack and debug-memory sizes by num_xcc, so the
        uAPI-visible
        <br>
        ctl_stack_size and dbg_mem_size values grow accordingly to match
        the
        <br>
        actual hardware resource requirements, which were previously
        undersized.
        <br>
        <br>
        Fixes: 4cd417bfec49 (&quot;drm/amdgpu: Add helper function to get xcc
        count&quot;)
        <br>
        Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
        <br>
        Reviewed-by: Bing Ma <a class="moz-txt-link-rfc2396E" href="mailto:bing.ma@amd.com">&lt;bing.ma@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c&nbsp; |&nbsp; 2 +-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c&nbsp;&nbsp;&nbsp; | 48
        ++++++++++++++++++++++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h&nbsp;&nbsp;&nbsp; | 32
        +++++++--------
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |&nbsp; 3 +-
        <br>
        &nbsp; 5 files changed, 66 insertions(+), 21 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
        <br>
        index 57fa69c0382d..7782ccd4d28f 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
        <br>
        @@ -1501,7 +1501,7 @@ int amdgpu_info_ioctl(struct drm_device
        *dev, void *data, struct drm_file *filp)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fpriv = (struct amdgpu_fpriv *)filp-&gt;driver_priv;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_trap_is_enabled(adev) ||
        !fpriv-&gt;trap_obj)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_xcc = amdgpu_xcp_get_num_xcc(adev-&gt;xcp_mgr,
        fpriv-&gt;xcp_id);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_xcc = amdgpu_xcp_get_num_xcc(adev,
        fpriv-&gt;xcp_id);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cwsr_info.ctl_stack_size =
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;trap_info-&gt;cwsr.xcc_ctl_stack_sz *
        num_xcc;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cwsr_info.dbg_mem_size =
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
        <br>
        index db09e879b85e..d19af9cb6ee1 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
        <br>
        @@ -258,7 +258,7 @@ int
        amdgpu_userq_input_trap_params_validate(struct
        amdgpu_usermode_queue *queue,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int num_xcc;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; num_xcc = amdgpu_xcp_get_num_xcc(adev-&gt;xcp_mgr,
        fpriv-&gt;xcp_id);
        <br>
        +&nbsp;&nbsp;&nbsp; num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv-&gt;xcp_id);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
        amdgpu_trap_validate_params(queue-&gt;userq_mgr-&gt;adev,
        trap_params,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_xcc);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
        <br>
        index 2a56f5ec9c76..90846d55292b 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
        <br>
        @@ -390,6 +390,54 @@ int amdgpu_xcp_get_inst_details(struct
        amdgpu_xcp *xcp,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        &nbsp; }
        <br>
        &nbsp; +/**
        <br>
        + * amdgpu_xcp_get_xcc_mask - Get XCC instance mask for a
        partition
        <br>
        + * @adev: amdgpu device pointer
        <br>
        + * @xcp_id: XCP partition ID
        <br>
        + * @xcc_mask: output parameter for XCC instance mask
        <br>
        + *
        <br>
        + * Returns the XCC instance mask for the specified XCP
        partition.
        <br>
        + * For partitioned systems, returns only the XCCs belonging to
        this XCP.
        <br>
        + *
        <br>
        + * When @xcp_id is AMDGPU_XCP_NO_PARTITION (or the device is
        not
        <br>
        + * partitioned), the device's full XCC mask is returned (e.g.
        0xFF for an
        <br>
        + * 8-XCC device). Note that the full device mask is returned
        even on a
        <br>
        + * partitioned device: callers that require partition isolation
        (e.g. SPM)
        <br>
        + * must reject AMDGPU_XCP_NO_PARTITION on a partitioned device
        themselves.
        <br>
        + *
        <br>
        + * Note: On error, xcc_mask is undefined. Callers must check
        return code
        <br>
        + * and only read xcc_mask when return == 0.
        <br>
        + *
        <br>
        + * Return: 0 on success (non-partitioned systems or valid XCP
        found),
        <br>
        + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -EINVAL if xcc_mask is NULL, no matching XCP id is
        found, or the
        <br>
        + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; partition's GFX IP details are unavailable
        <br>
        + */
        <br>
        +int amdgpu_xcp_get_xcc_mask(struct amdgpu_device *adev, int
        xcp_id,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *xcc_mask)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_xcp_mgr *xcp_mgr = adev-&gt;xcp_mgr;
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_xcp *xcp;
        <br>
        +&nbsp;&nbsp;&nbsp; int i;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (!xcc_mask)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Non-partitioned: return the device's full XCC mask.
        */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *xcc_mask = adev-&gt;gfx.xcc_mask;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* Partitioned system: get this XCP's XCCs */
        <br>
        +&nbsp;&nbsp;&nbsp; for_each_xcp(xcp_mgr, xcp, i) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (xcp-&gt;id == xcp_id)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_xcp_get_inst_details(xcp,
        AMDGPU_XCP_GFX,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xcc_mask);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return -EINVAL;
        <br>
        +}
        <br>
        +
        <br>
        &nbsp; int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct pci_device_id *ent)
        <br>
        &nbsp; {
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
        <br>
        index 692508be23fb..6eed82ad49b1 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
        <br>
        @@ -44,6 +44,7 @@
        <br>
        &nbsp; #define XCP_INST_MASK(num_inst, xcp_id)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (num_inst ? GENMASK(num_inst - 1, 0) &lt;&lt; (xcp_id *
        num_inst) : 0)
        <br>
        &nbsp; +struct amdgpu_device;
        <br>
        &nbsp; struct amdgpu_fpriv;
        <br>
        &nbsp; &nbsp; enum AMDGPU_XCP_IP_BLOCK {
        <br>
        @@ -219,26 +220,23 @@ amdgpu_get_next_xcp(struct amdgpu_xcp_mgr
        *xcp_mgr, int *from)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0, xcp = amdgpu_get_next_xcp(xcp_mgr, &amp;i);
        xcp; \
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ++i, xcp = amdgpu_get_next_xcp(xcp_mgr, &amp;i))
        <br>
        &nbsp; -static inline int amdgpu_xcp_get_num_xcc(struct
        amdgpu_xcp_mgr *xcp_mgr,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int xcp_id)
        <br>
        +int amdgpu_xcp_get_xcc_mask(struct amdgpu_device *adev, int
        xcp_id,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *xcc_mask);
        <br>
        +
        <br>
        +static inline int amdgpu_xcp_get_num_xcc(struct amdgpu_device
        *adev, int xcp_id)
        <br>
        &nbsp; {
        <br>
        -&nbsp;&nbsp;&nbsp; struct amdgpu_xcp *xcp;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t xcc_mask;
        <br>
        -&nbsp;&nbsp;&nbsp; int i, r;
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp; if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION)
        <br>
        +&nbsp;&nbsp;&nbsp; int r, count;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* Derive the XCC count from the partition's XCC mask (or
        the full
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * device mask when not partitioned).
        amdgpu_xcp_get_xcc_mask()
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * handles both partitioned and non-partitioned cases.
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp; r = amdgpu_xcp_get_xcc_mask(adev, xcp_id, &amp;xcc_mask);
        <br>
        +&nbsp;&nbsp;&nbsp; if (unlikely(r))
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 1;
        <br>
        -&nbsp;&nbsp;&nbsp; for_each_xcp(xcp_mgr, xcp, i) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (xcp-&gt;id == xcp_id) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_xcp_get_inst_details(xcp,
        AMDGPU_XCP_GFX,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;xcc_mask);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(r))
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 1;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hweight32(xcc_mask);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; return 1;
        <br>
        +&nbsp;&nbsp;&nbsp; count = hweight32(xcc_mask);
        <br>
        +&nbsp;&nbsp;&nbsp; return count ? count : 1;
        <br>
        &nbsp; }
        <br>
        &nbsp; #endif
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
        b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
        <br>
        index 16aa22b25098..1c7b2f3227e5 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
        <br>
        @@ -503,8 +503,7 @@ static int mes_userq_mqd_create(struct
        amdgpu_usermode_queue *queue,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uq_mgr_to_fpriv(queue-&gt;userq_mgr);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int num_xcc;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_xcc =
        amdgpu_xcp_get_num_xcc(adev-&gt;xcp_mgr,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fpriv-&gt;xcp_id);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_xcc = amdgpu_xcp_get_num_xcc(adev,
        fpriv-&gt;xcp_id);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trap_params.ctx_save_area_address =
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compute_mqd-&gt;ctx_save_area_va;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trap_params.cwsr_sz =
        compute_mqd-&gt;ctx_save_area_size;
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------cdJnF7u8VTf68v4IeAWglwQF--
