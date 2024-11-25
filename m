Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F223D3B7DA
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2024 05:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC0FC10E2C4;
	Mon, 25 Nov 2024 05:35:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vhZ9CdKD";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A241A10E2C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2024 05:35:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoHXvIjNvH2v6AF1Qkfczmma5lW1eaZN1uywecRfRy8EttIHWJssisnb6pdAbXaFFPZ1/GOvG2PxZ7E+iXXnWhcNkcg+SCSrSFPoiAE8boqnYDWR+LZ5p+LpkjxaAe84G+2kBwsISo+dGe6pJPNsay89IBOOPu6zkeVxYIxNkitu+aDDEPwCye/8xoJthDyOkEV7ISQud2HgiiU+91wx0+2omOfI2NrglGnihMOWMkFJdYIjwY25xz8LRmbV97kb6eUyeTUnXWFPFjJ3Ud2yfvGp4bUTNd1QNuOC+KEWdyK/3yrM6r88zHUu6FBu13M6KJSs4L2G6iujiQFbW5s3+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBoOyLUwLXg5bKkOFMkSHsVs23DjVNgeqp6pHi+86XU=;
 b=ax6xdm1CKgvT10p8wEV6n8CyTcAae7dpoQJWhzUUErdKB8vnKnUzNzTOT6vfc4gcWfM5rXknKTWZ+pnGF4P4u1S9v8Jddzo5VVlqNRP6ialOICaClHF0Vki/w/Fh4YzuIH4/nukj/txWbjnVVaAct4dGkye7Zm6tTKCTAiAT8DtIfCB3eqSp4xRv/R8MH2nT8z16vJDurob0yg2xoROKwTQ6wkGMIS9XabvQgTFK80Sc6XlQL/JXcX+g5WKtkjH4LGNUXscCIoYIKMHE9pzSuzz+gxqtO3JbH8xlKpEZsPTA3IwCrvvX53GDRNQohkq9s1j2t0R8SZqUl7LQS3kAfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBoOyLUwLXg5bKkOFMkSHsVs23DjVNgeqp6pHi+86XU=;
 b=vhZ9CdKDjLKC13HDIeLfvta3Nvc1LIZzA45TfIHppmb07EIajjbBoikV8lW3DXFGiVYj6oH4i2fEmLfCkrDkN1IFcVOY8eP8QOdCr7G9obaN/+JS8OvnxWrPIq2tdD7k/3MsGPSKK4VWilDcI+BV15SMypzrwMMjAXM5OHEeefs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by DM4PR12MB7720.namprd12.prod.outlook.com (2603:10b6:8:100::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Mon, 25 Nov
 2024 05:35:23 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%6]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 05:35:23 +0000
Message-ID: <e76a1944-2038-4016-9a10-b8f313cf520b@amd.com>
Date: Mon, 25 Nov 2024 11:05:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Fix dmesg warning from xarray
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241120092611.177202-1-Arunpravin.PaneerSelvam@amd.com>
 <20241120092611.177202-3-Arunpravin.PaneerSelvam@amd.com>
 <9fb8c1a6-985b-4cf7-a5b9-fe1e33fbe538@amd.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <9fb8c1a6-985b-4cf7-a5b9-fe1e33fbe538@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::17) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|DM4PR12MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b3bb100-4701-4331-840d-08dd0d12f56f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0xuV3A4c0hDMEpuSlROL2JGMEVDWTlkeEdWcXdGRU1OL2NvY3F0WENhUldX?=
 =?utf-8?B?ZG04dmUyNnRHdHhnQzRHcEtVMDMxVlJ4Y3Z1REhBWHB5KzVWREF4K012Zzg1?=
 =?utf-8?B?azRra040MTdYOGhNQm5WUHdNdVBLMmJPVjRyMTZUbjhXUVJWTmR5KzJsNUNq?=
 =?utf-8?B?c01hR3FEbkhWcVk2NXJtRmpZL1ExZmlKdFR1YnU1UWM0VDB0N2wyWVdoejJB?=
 =?utf-8?B?c2FLbFdublNaVkxtMm1lNmNCbEt4d1hLYXlPQ0xEbzdvZExVZ0VuejAxY1Bw?=
 =?utf-8?B?S2xydWl2VTlBQmhtMlJtYm9FWGxNTEc3U2F0WUt0dGRrU3REOUw1L2w5TnRI?=
 =?utf-8?B?R25rbmZsZWJMeUZsUVBWOW94UmRFZUpwWDJab2lhemdGc2pGdkVER2ZjekQ1?=
 =?utf-8?B?eDdiTlRHcmU1bjkrWUIzL0l2Y1BFQk9XMGtQZTJwZEcvSnBweUhoUEhVMjVU?=
 =?utf-8?B?Uk1RNUJIY2JWWmxvaklLWDhwUVF1aGNDbzBYNEN4KzBkOWJKdEVLUE04QlN5?=
 =?utf-8?B?eTY5bjNSNVJaMm5WWk52eFIzeVlYU3hxd2VwV0hoaHZBU0N2TlAwNjhMSGxM?=
 =?utf-8?B?NmpwZWxyNzhjS1BObkxJL0VYZnMvVnZ6bWJ1VlpidTZFS0t2Rk5PcWpNMkFh?=
 =?utf-8?B?YUlocHhTSGVZY0R0YTh2ZU9ERzU3eGJOcFlDYWd3TFFNa0pSRVRFMVZwR2tV?=
 =?utf-8?B?aFVIK1FLNks3TVFxb3QydDdMaVVDUkFLY1dudmlGV2kwOU83a0VVdTN6eFVF?=
 =?utf-8?B?NUtVU2RjcStlb0Q1VWduTDVDTHc0MWZqcXhnM1ZWT043NGFCVHBtSGVQb296?=
 =?utf-8?B?K2NzYnRuRlVnQzNUQjQ5c0RzRlhaNmxhd2RKWm1JMVRZME85RjB2RExHdUM4?=
 =?utf-8?B?MHZydzBVMnJMeU5ERDlkTVZPRXBOclBKNDN0WlJWT2JlY05CNWdkb0FUNVd6?=
 =?utf-8?B?Q0FsRTUvMTB2ZGFTbE5ObmNpejZWRjFUSi9pd2VFYTdXcldVTXhoeW4yN1pt?=
 =?utf-8?B?QUJVcGxHbDJEYWdUUWlhM0htU1pBdUY4cWtHSm1lS3p6S1Y3dE9pWEFaNW1t?=
 =?utf-8?B?Rk1GdS9BZ0dGa1M0dVAvZkY2Y1ZZekt5b2J0RW5DMTlZaWt2S0R0L1ZBc255?=
 =?utf-8?B?Z1hzREpsWFdpMVV6NnB1YndxRVlKaTk5eURsT21CNkk0empULzdwanpkeXFa?=
 =?utf-8?B?VGxENHAyTHJOY0t5eGppc1ZmRWpwd2tnVnpqdElzeDl5S3ZuTFdmNytadTBl?=
 =?utf-8?B?NkFxdDBoUTBxdGxwQTFvbXdQZ2lOTUNQY3hRVnovRUNQc0o3NnhXZ0QrZ2lK?=
 =?utf-8?B?QlFkcEROUHdGSWdWYlY2NGEwbEtxRE1qRklJTW81QnpXSDNidHg4Nk5GL3Fa?=
 =?utf-8?B?d1h6cE9OcCtycG1lSklzWjYzamNBY2NVYkkyVkcrYnFxZ3ZxSHk1MVNyM3R4?=
 =?utf-8?B?VUcwcTZPSW5Za2F6OWYyRDVKd0VhQjBURWlKVFYzeDNLajdDUVFCTGNLdU80?=
 =?utf-8?B?c2ZHOVZJTlpTbVJBZGlEVjZXTDV6SHlqTkQ5a0x0dllVYjlSeE1YL2xwbDZx?=
 =?utf-8?B?UUhiRGpOWGpEQ1JZc2dQa0k1bDAvVnNQbmJoR080dWVXTkpLMTV2bTlJUXNo?=
 =?utf-8?B?aEF6MkMwMVdneW1QdWFpdTVmd1BhcVpmTEZwRTZIMzNJdWVuaWdmelAvYy8y?=
 =?utf-8?B?OFk1ZFg4bU9qcnhOTTFFeitJd1VzeTNRUHlUQ2FDUEE2djNkM3RLQi9DdDV4?=
 =?utf-8?B?cm4wZzBPd0VHbUNxYzBCcCt0REsrUy9YMlRNdGVHQzZtd1l0aThCSkFSZXRW?=
 =?utf-8?B?ckhLMVVoSVMreFJDQm5IZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWNSbEEwVEppTk8wZ0tMbUNZdFFjcS9DcUVBZHozS2VNeGhidWFRZlByN3k4?=
 =?utf-8?B?Zzd4Skluak1JQWVIcUtEZWlSd0Yva2F5c25RdFpMNHlJRjUrSVczTXJqRFZJ?=
 =?utf-8?B?WkZjd0xWUlp0aXY3SW5UZ2hzRlBqV0xkQUFOUFpZZVZYQlpiNXVrd1lNZ0RR?=
 =?utf-8?B?czJHN1J1N2J2TE5sR2t6Qmh3cGNVT2hxL3lEZmVJVmwxN1o5RTRKSFVyZEc3?=
 =?utf-8?B?ZStRSUxoUGVPdHVTaUltUHdpVkJOSVU2Z0Z4NS9YOUlCYlRtUS81MCtCM2NO?=
 =?utf-8?B?eWFKT0dCZndINTRGbktMMncrejAvdlE1alVoQnd1WEhET0hTYU50ZmJEVnUz?=
 =?utf-8?B?NmZ2Z3BSbWp3TVAvQXJuWFJOL25lQ0FTaTNBRFlwdkVtQjBVbVk2YnJXTkNL?=
 =?utf-8?B?bUt2OFVhRjByejl5QmV5b09PNzNpbncrSnVTSkVNSVRlYlNpVTMzd2h6aThO?=
 =?utf-8?B?dGNNWmQrUWRFZXFYZlRDWXVKT09aMUhhY090UnA0NHRxT0E1b0F0RDRkUk5R?=
 =?utf-8?B?K25pK1ZFQ2xCUXFDNnd5WXBURjFZOUNCYzBhdlpGRVBJSnhzeHlCOXlYcnRq?=
 =?utf-8?B?NzBWdVdkUE94dk8zUWRSbkR3WENqdU1uUUFyZjFjUU9Sd3JPZkMwb051dFgx?=
 =?utf-8?B?bmtqc3hzclN3SEpWdlRENU9rRTRjMWFPSk9ud0h1azAySVlsem9wQ3RGRDNt?=
 =?utf-8?B?d1M0Yi9xYTd6L0xRTStJS2ljL1RNY0xzMmZ1QVovUVV4VkRmU0dHY2UxSkJL?=
 =?utf-8?B?VFJBM0hWbjZnOHYvSi81MnRNZ0wxNW44S2RDQllTcUowbFY3S0doVDREcHcr?=
 =?utf-8?B?L0hrTHcyS25NR0FNaWdNeTBHMmJYV250Q3lQemU2NHJnWjBOSG40NUQ5cVFw?=
 =?utf-8?B?SkwyTjZPMXdobnhNVTU4dnFBNm16Zm1KRHFOZUkrN1FnRHRtNktJbFJvdk0w?=
 =?utf-8?B?YWFlSUNZWjdrbGJINmw0ODBwalZjdmlCUWxuVGwxUndKaVBqWk8xaVkybWpp?=
 =?utf-8?B?YnhrUFBoYTJ6N3c1Q2xTMllvelBJM0c0bmJtNWN4eE9iZWRpZlNEUVJzaUV4?=
 =?utf-8?B?bUJaWDlUVkFTYVBMMFhIM3dmTWlFdXB5bjdSd1RzRHFZRXcvOG1DU29wazhn?=
 =?utf-8?B?Y1V2aVZaMFNFWEJ6OFF6UjQxSlMrV2kvZmxqdTZWRUNxb3BETkVmNXhCUFhn?=
 =?utf-8?B?M1RJRnE4K2pTbjFrc0wxd3RpTWo2anJXSE45b2d3NHpJanhJdnZmelRvUjNN?=
 =?utf-8?B?Wm1aZk5CSzVkY0twZ2dsMTdaT2hVaTBPcW0xdEN3M0hCQ2xtWmtMSFNhU2Iy?=
 =?utf-8?B?TGlETVFQNlRhL0U2RnQzMzExTTRtYmM5Y0g2NVN1MmluZStoc2lVa3BiNnFl?=
 =?utf-8?B?K1pVclFORXk5ZGQ1c0JURGhoWENWNGVDOG5QZkY3aTdtNndzdmthczNYdW5q?=
 =?utf-8?B?bTkybFFSVFRwYUltcUk0QTA4MEorR2lTSk83TFNIQ1d1ZmVRdkhyWS9qYW1a?=
 =?utf-8?B?VHVmTU1JeFZKSk4rSysvVFlTMHlud0Z1c1NSZFhtWkVyaUhiUXBFcU95SWk1?=
 =?utf-8?B?cGYxTUpyVHZCWjhyQXFDRVY0Yzl3V0hlVm1uL1RveE9XTWc2dmJxTXdVRDN1?=
 =?utf-8?B?R1VXRVJnNWZjRnFYQWMzNzdOSURXVkJpSXpJeUxwY1V4ZmFPOGVPejZUTkx0?=
 =?utf-8?B?RVdtQkp4aXRWVndMTnhsdG9BOE51RXFiREQxbnRPMUd0N1FwbzdMSHVXNW1u?=
 =?utf-8?B?c1VlSjJoYzdXN0M0ZmZzT1FZYUVNTkhLSVdxL3AyQXRJcnRSWGNFQW40NVVW?=
 =?utf-8?B?VlRqQzdPTHE5WUxKUkNpTURNcEpxVDlldmdQY2VyWUM2cG54OUtXMjNva1dV?=
 =?utf-8?B?aGxnbXlpbysvcTVubnRRc2krSmtrZTl6QzNsSTArcWRsM2xoSDYxM1REUUJU?=
 =?utf-8?B?TnhuRmJMay9UYzAxTDZJWi9vSEpjdGJwNHNqSHZXeWJ0dkh1ejdiSUozVkow?=
 =?utf-8?B?Ly9pbDFydnllYkF0czF4QWJvVjhRUGdCeTJlWWxmMUczWUgwZm1yaktRcjZj?=
 =?utf-8?B?MjV6U0dJZ3hndy8wbHZBc01za2ZQbitXbm5rUmpaeGhuSkJNYWtDQnJHZVdo?=
 =?utf-8?Q?7/QJzqRj9+sw1EMZZ5+9LNaWN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3bb100-4701-4331-840d-08dd0d12f56f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 05:35:23.6116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfYYGWYJZYuGYn/Qf4xyUOsv1yYcLVOtcilsQ1gVfRtg/jGcCTfiz1vNrFVIzy+EZciwQnzj1l3TKlqgGt2gTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7720
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

Hi Christian,


On 11/20/2024 4:06 PM, Christian König wrote:
> Am 20.11.24 um 10:26 schrieb Arunpravin Paneer Selvam:
>> Fix the warning issue generated at lib/xarray.c:1849.
>>
>> v2: keep the error handling same as before when the
>>      xalloc() call fails to store the fence_drv ref.
>>
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index 76f7babd7a54..bfe7d1d139d1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -842,8 +842,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>> *dev, void *data,
>>                * have any more space left and crash.
>>                */
>>               if (fence_drv->fence_drv_xa_ptr) {
>> -                r = xa_alloc(fence_drv->fence_drv_xa_ptr, &index, 
>> fence_drv,
>> -                         xa_limit_32b, GFP_KERNEL);
>> +                xa_lock(fence_drv->fence_drv_xa_ptr);
>> +                r = __xa_alloc(fence_drv->fence_drv_xa_ptr, &index, 
>> fence_drv,
>> +                           xa_limit_32b, GFP_KERNEL);
>> +                xa_unlock(fence_drv->fence_drv_xa_ptr);
>
> Why should that fix anything? That code looks identical, just with 
> explicit locking.
The flag XA_FLAGS_TRACK_FREE is cleared for unknown reason and a warning 
is generated when we
run the libdrm fence synchronization test case continuously with just 
xa_alloc function (this function has implicit locking).
The warnings are coming from lib/xarray.c, in __xa_alloc() function, we 
have a WARN_ON_ONCE to check the
XA_FLAGS_TRACK_FREE flag enablement.

This particular warning is not triggered when we do a explicit locking, 
this could be a bug in xa_alloc implementation?
>
> Regards,
> Christian.
>
>>                   if (r)
>>                       goto free_fences;

