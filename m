Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE19C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 13:51:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23DF6112295;
	Mon, 29 Apr 2024 13:51:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FQ040Uh3";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A204112295
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 13:51:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnxNrzoTs9EeWaQ81sO0eH6BFi1ebJJOQElWJo5X6epOUUG8BsRQp/5aKx7AK3Fi6vwjh2AQDY45XMAFLyW3Oky3fR20MHtsRys4Q0mLIO3eTQA+WPnKLortgeJzGftz//VEXR63/e+oizvAC6ASzhzgl/rM27KCAuOWZZvBZYmVEQLkGLockMynx11zFFTIP6xkSLQm4W50TJn63cHi3Vp6fY/n2uLVDzzihaDuPnc1KcSg89B0ipvgE1bAn+xVfeX4le4T7g4jGpTU8Gm7G/selDL7aZTqOr3VYddcgsl3JaN2lLTe+p/CAfdeciuhI9ggL0jDBj8ozubqwtyRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaPMBv1UNQJzOPdT3IBgvIQBmymQSUUMJWVOC1STtso=;
 b=fyZn7fX5YKTAKUEdyHpRNG8PUzOE/NQ2o1KCysihJOgQvQBBHaAE8wcQgIskSfMJ6zAPcooE8AJw2y4kDtIPLHkKqH2xBk+VJnz+Esb+NbwMFVaNKPohTjC9ExuDVHnOBMdFAsaMb3ec1g+5zGl4fy/tDUQoaCPjNMrW8u2K52CxPyrZN5eEkNxDizIL4M9zvNGudXusGJnFycWHiTszIPfOqS1o/MOgk72FREOBvSyJu/m/Yo9B5xECpDT7b5Z1xtuhqHYS2LnqwGEwD3V8xcxry0gkRv/sFk/DAC7WnuP+1S9+/PYePglpI13CjLLD2B3+loaAOIbUf05HnMXHXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaPMBv1UNQJzOPdT3IBgvIQBmymQSUUMJWVOC1STtso=;
 b=FQ040Uh3gEr0Lf8HNBJOq+EFp7qTWrSsP7Fax9lyh3cSOcO4uVngEm7zcU7IFvvRzpMEhpm8DxA1W34mq7T8D/VV6N0z+gMWiZWAv5G7KNBIC4fR7M4XRuKxOBLHdDigU5UC3yzPL/WszhlMYAO6OMUdcNlNp9Y5HJMJPlp0k0U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB8616.namprd12.prod.outlook.com (2603:10b6:a03:485::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 13:51:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 13:51:09 +0000
Message-ID: <597495b4-a366-40d7-99f2-655def5255a8@amd.com>
Date: Mon, 29 Apr 2024 15:51:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Add amdgpu_bo_is_vm_bo helper
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com
References: <20240426164355.1563-1-tursulin@igalia.com>
 <20240426164355.1563-2-tursulin@igalia.com>
 <e7ee1c2d-9c1c-456f-bee6-8971b9e4fb2f@gmail.com>
 <f450f423-2a37-4677-a961-5dfcec464e87@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <f450f423-2a37-4677-a961-5dfcec464e87@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB8616:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f33c2c-c632-4c65-3586-08dc68536c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWNadkwyQXR3OUlibGwxQ3RhcmRURS9YM1dOV1hWUjlFQWFyalErejBQcE13?=
 =?utf-8?B?c0lPU0o2eUhiZkp5clE2cEZYTHJGQUM1ZnlzWWpsYWxQeHhLbFU0eitTU09Q?=
 =?utf-8?B?UGhad2s3M0F1eUFUT2g0Q0VoMW1mUGRWVVBRRTB4Z0dzYzVMRkpDTVRRejZL?=
 =?utf-8?B?eTdxYURGU0JNc2lINGFXakcxRzFnSVAvTld3RzFVTGpnSGxuZTFPc3JzclIz?=
 =?utf-8?B?d05NUUFBTHJwQm1zUS94cnlMREFCMHZwem13TWl4RVdDZ05YZDNoc0t2MXY4?=
 =?utf-8?B?MW5XbEJlZWtETUtTaFgxWVgxZ1hKNHNaUExqT1NETEFDUTgzUlJaY21LV2pP?=
 =?utf-8?B?QS9MM0t3dWhEUTYwU3lDVFVFTDhDSFptbCtrdjkvZ3VLL0Q2SWlMNlpDT0t5?=
 =?utf-8?B?cE5ncjUzYlppb29UQ2VkblNoeGprLzZOditXSnlLL080V1EyaFFNYzdLZDBV?=
 =?utf-8?B?RmdyMUludnd2M2JwMGdtUVVLNW1VajdWaEg5c2Y4amp4WVg4M0QvMVMrTzZs?=
 =?utf-8?B?UERqTEtoZnVkbXFlaUo0WHpvT3NUWDVaRklIUkRwYXgzaTd6Q2hNT0pNWlZ4?=
 =?utf-8?B?ZkFsaUZObUU5dWpxamx1UlpZR1oweWhiSkdXU1RRVlppOXpYQU85bzN3cHFi?=
 =?utf-8?B?WFFzRStUakRoMVQxU0txVkFVTVhRVk5PMnUwcWlDVVY1Sk5QSmNWbE1yMkVO?=
 =?utf-8?B?SWxQQWRhcVZWY1pkNUtvTERHcnJBSGlSNi90VGlzR21wcVZNaVN5b2tUNFFN?=
 =?utf-8?B?N2VzdHlxdVh3aWk3NC8yemRkR1hiV1lZbVZ4RXRhUXBiUkJxL1gvcGtxYTdZ?=
 =?utf-8?B?dmd5NWJyV1FTZEhVeUJnU3hiRXJFdGNiMXdROWZzbGxNbXRyNUNYRCtEVENT?=
 =?utf-8?B?RDVtVXp3Y0dlT0NDMDFEdjNidUtScEpzWmJwWXBMSDR1STJGZkdOYnExVEhC?=
 =?utf-8?B?Nkp2MVowc1ppNjdCWmpiSVg1MkxhOE1adXk0dndpeDJ0bjUwUngrU2swMW5o?=
 =?utf-8?B?aXJSS0tkNTh5bXc2b3RtUnRYbHk4RE4rV1BqODNzWEQySTRGL2hNOW92R2hQ?=
 =?utf-8?B?OHJHZlQwd25UMlRoeGRGeWVXc1FYMnEwVTJnanIyd201cVBoVzc0ejY0ZDJx?=
 =?utf-8?B?SkFQc3NCOFZuc0VTVTM2amRyT0VuMkE4UDVqSlA4ZzB4OFcrMjNGcjRYc1ls?=
 =?utf-8?B?YXd2MW5Jdm15WjhVclE3RTdXelRBR2VmQXo2Y24zdHZrM3JRdWRKVVVsY21W?=
 =?utf-8?B?aU5leWVLaXM0eHlFM1lGTFpQTXdDY0IzT291MkdxVUpkNTJvZFhBV1c3QWVu?=
 =?utf-8?B?clNWRXIyRmZrYys4VVNNMTJXQjNzbTZCSFkwVnRxMzhLWGYyVDUrWnZSTzVz?=
 =?utf-8?B?dWthdWNtMzlaYlZUWTVaYXhndjVaKzZGcUFNYW1QL201Vzg2WjlmSHVuaHdu?=
 =?utf-8?B?bW05S0d0SU1YRVF4UldTS0xxbHdFakpjRlUzT1VaV0k4bkFLRTdqYUMxbUVE?=
 =?utf-8?B?ZSsvVXVyNW1lVGxXVWthOHdIWE56YmJjVnIvN3JrZHQ1RnFDcktIUGFWSGRn?=
 =?utf-8?B?SktTNEliV25iK3dTb1YwR0x2QnNZa3h1dFZXNXZ5Zk9TNmFSQlNjZUlMcmJQ?=
 =?utf-8?B?Sm54SUZYZm9md0d5c1dYVmVneHJBYzBrV29mR1VGeUFJT3NmTHhDUnQ2ajdL?=
 =?utf-8?B?U3R2LzMvbTl0cVhPeDVSY2lhcjMrYjFaY3duWnk1bFYxczdWZ0RYYlpBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjJxU1YvM2ErZS9XaytpV1o1R21hSmxvc1BWZTVhMEdCMWl3QXkydE5Ud2Zm?=
 =?utf-8?B?dXliQXVxTGNIQzcwSDZXdzd2bVYxaUVJUUtTK09uOS85RzZ3RGNhakhtWUVk?=
 =?utf-8?B?d3lvSzRuODdMRk1WS3hVZ2xJNitYYm9TSVZJaWFpczNBZWdWRllTdG10Mzdp?=
 =?utf-8?B?anFHL2JudTBWNGlSaDRBRWhGNXZqS0lNeVFGNy9jSUJtSkVERWNoVVJwczZB?=
 =?utf-8?B?bDQ2Yk5QZ2hZaEUwQUJ5aVRIWjhIZmZhVStOc3UxWDdZTjJZd3VsQnJLSEp0?=
 =?utf-8?B?Zlo4TWJBZVozSjdyU05RWTlQc2NYdHpST25vYS9UTDlQRnM2NkM5endNTE5S?=
 =?utf-8?B?UTJJR1B5N3V5RFNVRTlleExrMS95UkxWZzlPOC9WdmZrSE9ZRVd3ZjZQckVM?=
 =?utf-8?B?RzhIZGpQcW9TenNrV2ZqS0RRam1VdVVZYS8waVhyeTJxaDU5UVFUN05hekU0?=
 =?utf-8?B?SDFKVkpma1d1bkhmbmtKRHZXS0ZCamFuVkVWdjlpSzlUaFJXMFBTQ09sNDFY?=
 =?utf-8?B?UFVIdWN6aEtHc3lvVllVV3NtMXZXdmFhSVVOdWJOVmt4NEpiQ3U1aDAxTk81?=
 =?utf-8?B?V2l2QWVub2YrSklFdnJOcUhDbmVOWGY1L0s1SldQNnhCN2xjajA3U2NYNUFV?=
 =?utf-8?B?dHFaN2Z6eDBCZ3hnVzRYN3NLOVp6YUxubkYwSktFdzhVVDI2ZVJpTTZ3MDl3?=
 =?utf-8?B?RXNTSkd4K0FtMUpaRUN0cTA4dndkekIvZDRVUWRKdWpMai9Ha1RaaHY4b2Np?=
 =?utf-8?B?Vld6YUtWTStZTFZtZFRFQjU1blBhVk1XQVJSV1ExbU80Vm1ldkp4SnFXc25l?=
 =?utf-8?B?dElTbm5XVlV5V3hOeDVWM1d6K3gybDh3eDIzV0s2S2hLZFRtT0ZZYzdYWVR6?=
 =?utf-8?B?TVUxMzBxczRkOW55VVh5RVlwSTdzNloyVHI2Snd5WHBQL3RhcVVXa1hLTGJm?=
 =?utf-8?B?YzBmRTZwK2huYmJWMVJ4REpGTGh0ZkV2cGFCUHBKK2czUHJZT2xDL2R4NTha?=
 =?utf-8?B?VHFOSGZ3UDhHV1JaVGNCQnd4YTNINzdHQktlL2dlMWFCNEMxRmthc1dqZzVP?=
 =?utf-8?B?eTM4MFRGTkJNK0NmdjhrRGxXQjVsN243aTFUMy9mdmF1VzluTVVMVmhiMHVw?=
 =?utf-8?B?cFpJa0FyNGdpZnhSL0RuQ280TmNrM28zeVpQQUtVc2xpZWFyYk1Id2EwNmN6?=
 =?utf-8?B?Z2tYNzZvZ29ZRGpYZ3pTeFFqRlVGQTRFOTBZeWRRdEYvYUZRUmdManl3eHVL?=
 =?utf-8?B?YVBCWmkvQW1wOXhXWlNOakZuRnk3K2V3S3A0eTFWSTFicG1OMk1PM2t2ejVX?=
 =?utf-8?B?eXNyZ2doMVdPWS9hZGpDSm1pUzFmQ241eWtGWUQrZWZVUkwvM2lMWDM4Rk43?=
 =?utf-8?B?dkxpTEdGNEw1OVA1eE9pczBXYldLOXNubWY5dW4zQngwbkZrMTgydEk2eW51?=
 =?utf-8?B?WmtmVmtEQkZoS1V0ZnpPSEtRcmJ0cklUWjBjUUFZQzZvc2V3cWJ4eVB5UlNq?=
 =?utf-8?B?SVF2cjBGdEt2d1BtUEVtV1dvWEI2QndDVm42Z3NRcmlCeXYxVWdZTC9vQkI2?=
 =?utf-8?B?bXRvU2llUGNuYXBvSXVKcmx4ZTcxWDdJbHZaZWxhM3E5d2Exbi9BMkhESUdS?=
 =?utf-8?B?Q1hWZS96VWk3YXJsU1RicEs2NG9rS0FiaCszTnJGcUNvcEgxM0dnYSt1QVFl?=
 =?utf-8?B?b2N5a0QveDVLa0RER0hlTDRxN3VPVVNYbi9FQU1Fb2t6NnYyTDFGWnFMazhK?=
 =?utf-8?B?TGlHL2x1RXdwZnVDR3RrSm1jRWp4WXVWU0FqejRwTzBIbzdmTGtFcnpEZFE0?=
 =?utf-8?B?SGs3ZUNmUmdCaE9SdWhTWXQ5bDNoTW5hVkI4bkI2ZGFubUgxQS9vMEZQY1M0?=
 =?utf-8?B?M3B2aUhOcFFiY3hrZlNhR3VENC9UbDhxc3FBckJKR3o5azBYbUt0WTZHNm10?=
 =?utf-8?B?Q1A2NlJwS3U0Q2NWb01aQlcrSlZDK0FUcTd2SVFSVjJQbXY2UlovYTM1RXFt?=
 =?utf-8?B?SEtrREswNHZWTmZ2aFkwbDNCTHppanlGbXlGZGVhWnJtVWx4MTV3bDdhMThi?=
 =?utf-8?B?Y3cvQnJNVHpqYncxOXdtc3pucHcyM25XM2FnRDZramFmcDVIbGF0NlhxTEhW?=
 =?utf-8?Q?MH8o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f33c2c-c632-4c65-3586-08dc68536c6f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 13:51:09.3624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpSOBHJ5lsdxZPmL1DV09n9U6Wvz+ihqy694aj4lExP/KmVDqd8+yB801WPM7k56
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8616
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

Am 29.04.24 um 15:34 schrieb Tvrtko Ursulin:
>
> On 29/04/2024 12:02, Christian König wrote:
>> Am 26.04.24 um 18:43 schrieb Tvrtko Ursulin:
>>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>
>>> Help code readability by replacing a bunch of:
>>>
>>> bo->tbo.base.resv == vm->root.bo->tbo.base.resv
>>>
>>> With:
>>>
>>> amdgpu_bo_is_vm_bo(bo, vm)
>>>
>>> No functional changes.
>>
>> Ah,yes that was on my TODO list as well.
>>
>> But I would have rather added this to the VM instead. In other words 
>> move it to amdgpu_vm.h and call it amdgpu_vm_is_bo_always_valid() or 
>> something like that.
>
> I am happy to move it around as long as you are sure amdgpu_vm.h is 
> the location.
>
> For instance main API there it seems to be amdgpu_vm_bo's. At least 
> all the amdgpu_bo usages do not needing anything more that the struct 
> forward declared.
>
> So if I move the helper there I either need to make it include another 
> header, or move the helper out of line to amdgpu_vm.c.
>
> Thoughts?

amdgpu_vm.c is fine as well. I just though that something so simply 
could be an inline function in the header as well.

Regards,
Christian.

>
> Regards,
>
> Tvrtko
>
>>>
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 14 ++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 31 
>>> +++++++++-------------
>>>   3 files changed, 28 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> index 67c234bcf89f..32e4a9c6e805 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> @@ -174,7 +174,7 @@ static int amdgpu_gem_object_open(struct 
>>> drm_gem_object *obj,
>>>           return -EPERM;
>>>       if (abo->flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID &&
>>> -        abo->tbo.base.resv != vm->root.bo->tbo.base.resv)
>>> +        !amdgpu_bo_is_vm_bo(abo, vm))
>>>           return -EPERM;
>>>       r = amdgpu_bo_reserve(abo, false);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> index be679c42b0b8..f2bb6965cc77 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> @@ -307,6 +307,20 @@ static inline struct amdgpu_bo 
>>> *amdgpu_bo_shadowed(struct amdgpu_bo *bo)
>>>       return NULL;
>>>   }
>>> +/**
>>> + * amdgpu_bo_is_vm_bo - check if the BO is VM always valid
>>> + *
>>> + * @abo: BO to be tested.
>>> + * @vm: VM to test against.
>>> + *
>>> + * Returns true if the BO is VM always valid.
>>> + */
>>> +static inline bool amdgpu_bo_is_vm_bo(struct amdgpu_bo *bo,
>>> +                      struct amdgpu_vm *vm)
>>> +{
>>> +    return bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv;
>>> +}
>>> +
>>>   bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo);
>>>   void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 
>>> domain);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 8af3f0fd3073..6d6f0e325172 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -333,7 +333,7 @@ void amdgpu_vm_bo_base_init(struct 
>>> amdgpu_vm_bo_base *base,
>>>       base->next = bo->vm_bo;
>>>       bo->vm_bo = base;
>>> -    if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
>>> +    if (!amdgpu_bo_is_vm_bo(bo, vm))
>>>           return;
>>>       dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>> @@ -1101,13 +1101,12 @@ static void amdgpu_vm_bo_get_memory(struct 
>>> amdgpu_bo_va *bo_va,
>>>        * For now ignore BOs which are currently locked and potentially
>>>        * changing their location.
>>>        */
>>> -    if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv &&
>>> -        !dma_resv_trylock(bo->tbo.base.resv))
>>> +    if (!amdgpu_bo_is_vm_bo(bo, vm) && 
>>> !dma_resv_trylock(bo->tbo.base.resv))
>>>           return;
>>>       amdgpu_bo_get_memory(bo, stats);
>>> -    if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
>>> -        dma_resv_unlock(bo->tbo.base.resv);
>>> +    if (amdgpu_bo_is_vm_bo(bo, vm))
>>> +        dma_resv_unlock(bo->tbo.base.resv);
>>>   }
>>>   void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>>> @@ -1203,8 +1202,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>>> *adev, struct amdgpu_bo_va *bo_va,
>>>           uncached = false;
>>>       }
>>> -    if (clear || (bo && bo->tbo.base.resv ==
>>> -              vm->root.bo->tbo.base.resv))
>>> +    if (clear || amdgpu_bo_is_vm_bo(bo, vm))
>>>           last_update = &vm->last_update;
>>>       else
>>>           last_update = &bo_va->last_pt_update;
>>> @@ -1246,7 +1244,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>>> *adev, struct amdgpu_bo_va *bo_va,
>>>        * the evicted list so that it gets validated again on the
>>>        * next command submission.
>>>        */
>>> -    if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv) {
>>> +    if (amdgpu_bo_is_vm_bo(bo, vm)) {
>>>           uint32_t mem_type = bo->tbo.resource->mem_type;
>>>           if (!(bo->preferred_domains &
>>> @@ -1640,10 +1638,9 @@ static void amdgpu_vm_bo_insert_map(struct 
>>> amdgpu_device *adev,
>>>       if (mapping->flags & AMDGPU_PTE_PRT)
>>>           amdgpu_vm_prt_get(adev);
>>> -    if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
>>> -        !bo_va->base.moved) {
>>> +    if (amdgpu_bo_is_vm_bo(bo, vm) && !bo_va->base.moved)
>>>           amdgpu_vm_bo_moved(&bo_va->base);
>>> -    }
>>> +
>>>       trace_amdgpu_vm_bo_map(bo_va, mapping);
>>>   }
>>> @@ -1922,8 +1919,7 @@ int amdgpu_vm_bo_clear_mappings(struct 
>>> amdgpu_device *adev,
>>>           if (before->flags & AMDGPU_PTE_PRT)
>>>               amdgpu_vm_prt_get(adev);
>>> -        if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
>>> -            !before->bo_va->base.moved)
>>> +        if (amdgpu_bo_is_vm_bo(bo, vm) && !before->bo_va->base.moved)
>>> amdgpu_vm_bo_moved(&before->bo_va->base);
>>>       } else {
>>>           kfree(before);
>>> @@ -1937,8 +1933,7 @@ int amdgpu_vm_bo_clear_mappings(struct 
>>> amdgpu_device *adev,
>>>           if (after->flags & AMDGPU_PTE_PRT)
>>>               amdgpu_vm_prt_get(adev);
>>> -        if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
>>> -            !after->bo_va->base.moved)
>>> +        if (amdgpu_bo_is_vm_bo(bo, vm) && !after->bo_va->base.moved)
>>> amdgpu_vm_bo_moved(&after->bo_va->base);
>>>       } else {
>>>           kfree(after);
>>> @@ -2017,7 +2012,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>>>       if (bo) {
>>>           dma_resv_assert_held(bo->tbo.base.resv);
>>> -        if (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)
>>> +        if (amdgpu_bo_is_vm_bo(bo, vm))
>>>               ttm_bo_set_bulk_move(&bo->tbo, NULL);
>>>           for (base = &bo_va->base.bo->vm_bo; *base;
>>> @@ -2111,7 +2106,7 @@ void amdgpu_vm_bo_invalidate(struct 
>>> amdgpu_device *adev,
>>>       for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
>>>           struct amdgpu_vm *vm = bo_base->vm;
>>> -        if (evicted && bo->tbo.base.resv == 
>>> vm->root.bo->tbo.base.resv) {
>>> +        if (evicted && amdgpu_bo_is_vm_bo(bo, vm)) {
>>>               amdgpu_vm_bo_evicted(bo_base);
>>>               continue;
>>>           }
>>> @@ -2122,7 +2117,7 @@ void amdgpu_vm_bo_invalidate(struct 
>>> amdgpu_device *adev,
>>>           if (bo->tbo.type == ttm_bo_type_kernel)
>>>               amdgpu_vm_bo_relocated(bo_base);
>>> -        else if (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)
>>> +        else if (amdgpu_bo_is_vm_bo(bo, vm))
>>>               amdgpu_vm_bo_moved(bo_base);
>>>           else
>>>               amdgpu_vm_bo_invalidated(bo_base);
>>

