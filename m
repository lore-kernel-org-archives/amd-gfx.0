Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB52C27C55
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jun 2024 11:38:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49ECF10E097;
	Fri,  7 Jun 2024 11:38:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gYIkLeTY";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E59C210E097
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jun 2024 11:38:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjW3AunLp/Sq4vAyWXrqCkDU/zgjSezCDVe/F0YzdG/4Rd8W4QG8kzA1Jcadcuz720gCfkk4WooZ+R8WewH/c+igu6Fxp3rlG7fXdPBD/gMkPVeyUC2nRD/aQNSztQdfIvckki1WPsDadMTYRHWBZ2O2mODH3wutjPhPUHrgMs+unCvAWpd/XAZlaETs4VJMOBaYfRa3RM7hINAUfzouH6+wbXpmI82mzk4nFOrKHWgd18L+Re4nsIFIYMLxpus3pOGT9XdgXwFatAOrRlZmaLB2j2WCV/S2CcDngBoW7QOqs3rgl+YjLHpaZL622vZJ97k0M4enNYWgSAPyzl5GTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOCxnzh9PL2B5iOx3WDErMEaUEXiU2xCiTAc0tadStU=;
 b=lsvVFh3wBk0XA8oUoCRDn8Hstm4hbANoPgLFIJxoIxwhzHETIg6vbLMgSTPaLkL5ExPegtfEJNGFnlAP9fQASyLmgQZeD43MQFdW4q91DIQTOBMOLa0hxlCqY4393EUXDCxqdPSevork8ZneOb5OwpXrjQGZvj0a/SBtc2OKtEb4XJ4Eg7F0oc8MxGDqyBPKRC41CS2Aef3Qv+k+Cexsn17gHahyVAI1dwsYvEQxBwcPFM3ltou+dkFvdYh5whjFidBil6mfm7D2FjBuVC7+gDZa/YseNoEso+eqjuhUWoJqTKRimMxufF6D+Ks+2NLFuhLYgms/XsnrhdgOo5+tFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOCxnzh9PL2B5iOx3WDErMEaUEXiU2xCiTAc0tadStU=;
 b=gYIkLeTY6I9YLuUDXn0bB2PGs7ntvrFCT19lG4S3ncPVHLlwe7/R4gv0JGxq/1M/3LC4pnhPi2bMsBOW6C0H/BFXR6JfKteU7JQXGFeGw/uWBPF+STErZwUXncqlOThLae1f35KhzxisueYgcLJpwBspx/0ehNYMNYFOJDnyyD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 11:38:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 11:38:52 +0000
Message-ID: <b25adc15-5b7b-401b-ab21-63b3554ff341@amd.com>
Date: Fri, 7 Jun 2024 13:38:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: fix overflowed constant warning in
 mmhub_set_clockgating()
To: Bob Zhou <bob.zhou@amd.com>, amd-gfx@lists.freedesktop.org,
 Tim.Huang@amd.com, jesse.zhang@amd.com
Cc: alexander.deucher@amd.com
References: <20240607083336.65752-1-bob.zhou@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240607083336.65752-1-bob.zhou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c7e2ca7-d171-4c7d-b09e-08dc86e667a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eU9ITFBvYTFaUVFuZ1VtR3Z1RE1QNkx6WUozbWlOY254NEtUMk80UE9SczJZ?=
 =?utf-8?B?Smtwejl5VnVSazM4MTNLaTlqb2ZXN1AyUmlQYWxlWWJuckpzaG9SUVJhd1dV?=
 =?utf-8?B?aXRia3o4akhwNllKRjN1cldmZko5M0F1VkpZRWRVeVVTSjNLR1A3bitid1RO?=
 =?utf-8?B?Mm1Bc2xnRGdFNm1qdkJwZXg2bUl0ZHh1cUFHOGZTbnFQSWlIdWI5WWx3Nnlx?=
 =?utf-8?B?TFhsUngzRTlZemNuU2FhaGpORDZDTjNoMnZlK3A4NklML1dvOE50Slh6U1ph?=
 =?utf-8?B?VHFBL0lUQXZla2QzeXVCeVlSZmNTMGJ1cWExUWF2UkRQVkRxSDZFN0NtUDF4?=
 =?utf-8?B?NUFFbmZDeDIzRkNtZjZlTHE0ak5ZNFV2Vm91aFY1emhIenVSZEZQbndmWDVk?=
 =?utf-8?B?eFlrcTF5WVRFT2VWY2ovOFhlOHY3L0kxM2R2ZXZOZU1jNTZpM25mU09JM2gy?=
 =?utf-8?B?VFg4MzBiK3Y5UytQSkM0WWcwM1c5ZU0raVkxUUJYMWJRaStZVkpyWjZlUy9n?=
 =?utf-8?B?U0VnQTcxWTIxTnpNeVNtdEdTTUNjSkJ5SWFtWXlPeEo1bi95MGFOQ3J3QkV4?=
 =?utf-8?B?eEh4M0h0amN4QkYxWVpYQSs2QndJdU0rQit5N0E1TWRFWlZhUlUzekwwUWNi?=
 =?utf-8?B?QkVDMW9tSTJSQUtqMmwzOTZqK2RVUjJZK0t0NWJIVmMyVmt5SSt1ZndxdjIw?=
 =?utf-8?B?LzNiQW1JMHhSWlNLa0hteUpDSmVjSnBNL1k5ZkVJV2h1NjdiWGxXY1didkVX?=
 =?utf-8?B?cnM0cnMwWUNIRlZHWlhWZWFvd3Q2T01pRGgxd2s2Tks4N3FYUjJMMy8yTGNs?=
 =?utf-8?B?aHZxUGZwNHNkT0hFNGNCaG5mVHI1U3lCRnVNTy9wS213d1NHcWY5aFJpNXFW?=
 =?utf-8?B?UGdBd1IzT0J0b3FRdVM2MUkvdDIvL29Fd3BsRUgreVhHaXg3a3JOQnJpZ2tE?=
 =?utf-8?B?S0Z5MkhBQkU3YXUzaUxFb1p6Tis4a1BpOVlyVkJxaXIySm9qdTdHRm1CMFVi?=
 =?utf-8?B?YkpWTENLeHpSd0kzTDhranhHcjRSYWtoSmQwc2ZTckV3T1M1MGpqbk9tbjlx?=
 =?utf-8?B?Qkszc1RlNXB4Y05TMXVLVkN2UjN2K0tJdU8zdDcrRDdnSEpOak0vbVJMMFNP?=
 =?utf-8?B?eWZHK3hNNkNTaDFPay9zWkdZeTBqWGhRdVF5VFd3aHJJWkxBYzhRUGJ6MkZw?=
 =?utf-8?B?a1VlT20yTnNjdkRWSDFLUFRBdzlTVmxBcitVQ2NjYTlkZTFJQWR2Z0RGcU1L?=
 =?utf-8?B?RjhIM0wwSWlIcHZLNTVmWTgxdW14VzRZeEZDc0wxWmlmUUdhc0duQmdwcnlw?=
 =?utf-8?B?S0lhbzJpYlVlR2UyWmlTc0FvMUpyVjU3Z1RJYy9HbzB3TWsxTFRSNmJ3NHhJ?=
 =?utf-8?B?RDh4SUErN1JBOTVzU2doeVNCUDFvVzh5bW1oL2FnZXp3eGFsaVdMQjNxejRC?=
 =?utf-8?B?ckNtK3g2Z3AzWnczZlFBNWZ3cjFDdmlZTXF4eFNpWnh5UVVOM3dQbHdremNo?=
 =?utf-8?B?UHh3YUVYeTd1VE5rR3Ruc2VjeUhRVytUb0tidXZFcm5LTTZvV3ZNVmxIVW5H?=
 =?utf-8?B?cmlZcTVoakVFQndGdm5Ja2pVUWp5VlhOcjlPd0k5WHZBdG1pV0w3QmF2MUN6?=
 =?utf-8?B?NW9xQmJrV2dybytmK2x6QWNSdXJ5eDdMbzhxZ3kydUpmeE5WYm5KZ1JxOE8r?=
 =?utf-8?B?SWxKV253R1FKYzZZRCt2cFZoY2tFVUZ3cFVZTEZZcjhMZk51S1dGQ1h2TWpu?=
 =?utf-8?Q?qs2iPfiuTp0YU6wejL4jNznZ2aA/90z8wS+8K9S?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFZiRGM3MlZ6WEkyQzQ0TGcxMlBZS0tXSnlIT1RVUHF6c3JWckNCKzNRRkxD?=
 =?utf-8?B?N3MwNDdvbkFxaDY0V3ovaXNGdmhMOWRCZkdDL004T29mRUhDaEN0UWZHTmY2?=
 =?utf-8?B?c1FTS2tFb05qRVg4ajl5YUcwMHY1VWJQWlg3NmVENUZvcjJ4NU1sWGFnZExJ?=
 =?utf-8?B?Rk9IVno1OHhWeUo4YVJhYTlwSmh4dEg4bGkxa2hIaS9QcHlYaC9jaG55QW9s?=
 =?utf-8?B?bk5HSlVJdFhOcGd0VURWVXJDNklrbHpDYVFzSFpXRzNIUVpxRzVKc1U3Q2hu?=
 =?utf-8?B?R1prcFJ0cCswVEtVeEFQYWh3dktWSW9uckROS0dSd0dEQVlEZWlySkJFYjc5?=
 =?utf-8?B?Q25yMDdJaVZodE90SkdGeXFvR1NiMTNTTFRURE1VdnBucW1jZWxWTHZRTWdl?=
 =?utf-8?B?SkgrOVdmdDVpYlkxVzBPYy9SSkRRT0xscUZsTzhWbEVQdDdGUE11dDc1Vlkv?=
 =?utf-8?B?VUVYRzlPdzRyVXROT0ZabllFbmc1YW0zRnd0c3BUU3VWZUU5N2dkNTRwSkt2?=
 =?utf-8?B?cDRuWlpaNG5EYlhPUXJERXJVeXlDSDBPenFCZ1dLNUpHRzNOaU52SjZsZVNt?=
 =?utf-8?B?VVd1OTdIS0MxZmc3ZDM0L1IvUUJpYnN6SEsxY2xJTXMvRWM3RkNHTk9KT3BD?=
 =?utf-8?B?WmxLTE9pV0VlZ1lxT1UzeThJQjIyQkIzMUVhYTE1RVJwTko5d1cxRGw4Wi9z?=
 =?utf-8?B?Kzh4aEpacDlDWEZqQzhXWTljdVplZ1lFVnMrRXlKZG9jNHJiOHdhb2pWV3p5?=
 =?utf-8?B?bXN6NEFPbk9ZUFc1d2RTZkVWVStZVkVDRFdzblVjR3RvY1NzODVhVGE4R2Iz?=
 =?utf-8?B?c2syVTRDK3RjMHR1OXJNK21RMk5Wa28zVWlURGQxcG9vR2RVdWFTWTJURkk2?=
 =?utf-8?B?WTQ1Yyt4Tjh1Rk9nT2pDRkIrdmo2dUNkUjNhaG5QRE1VbXE0SU1VZ05SQ3FM?=
 =?utf-8?B?Q1d6OWtNbmdEeEdhSnZDVkNGTW5QOWxvQkVtbVJVdWo2bERmQTlESVFIaXRz?=
 =?utf-8?B?NUJyeGpPTXh3bTdtNnZad3NFV25US1VpLzMxeVlmQzBqVVBXUHFOMWZaSC9L?=
 =?utf-8?B?bmUyZFUrNmoxL085ekxqRko0dlFXcXlwT3ovS0xTM3ZzM29IdEtKZ2pVQ2R1?=
 =?utf-8?B?ZGN4RzFyRGJLVjRraE1TeFNwdDdvemRtaXhSQ3ppNlA4WENjOVp5dzdVUlJT?=
 =?utf-8?B?R0FMYnVGWWhMN1VZTUNRTjVrOTkrU1lxNU9ka3ZTZ1dWR2JMR25MOXl1V1Ja?=
 =?utf-8?B?bCt6WXh1ODQxdW9aZW93OHh1N3dVdFZyOUQ5RmVmcW0yUytMaFo1RHo2M2ZO?=
 =?utf-8?B?eHMzZlhWVHZaQUlkK2pMS3hHRXRBRUpibWFnVk1JSmt4MGh0aW1ONFMvd0tB?=
 =?utf-8?B?bTFIcHpIQytVdGVFR3VCMDhEclNvQmdzNExnMC9XSWZBL0UwZnNSRkw0M0Nx?=
 =?utf-8?B?TGZyYkZHNFp5UkFJRVk0bDZNd0xXanRUVmN6QVRoUW9WbWJwS0NEdlNJR2JH?=
 =?utf-8?B?UjhTOUplbHN2cHdEZ3VlMUVNdytlakZ3VlRvRFZ2dE5YNk5HZndXc0hjL0pW?=
 =?utf-8?B?MU1kTUV5N2g4dGNuRjB4MUhWcHE5M04rbWxUQnltRTBJYlRMcCtaQ25HeTZ0?=
 =?utf-8?B?SjNQZVBGQTh5Z2tQS0xBRUNtNW5FMDRQYTFwTWNud2xSZ0tCYjJLSlM3MklT?=
 =?utf-8?B?bkJ5NU1aT2N4MGVMWmVoM3lENlRoclM2NzJKOFNlMkowbnE4bWpyR3hCWCtI?=
 =?utf-8?B?WGUrTDMzN1pJSzJXbklBM2llRldLQzNLczdaelZwL3BSZjdJTWhUOTdZRU9H?=
 =?utf-8?B?MmF0YytxcUl5Ky9wN3NVU0FGeVdUeDltRFpEekkrYW8rMm1HeGFrcXNIT1RC?=
 =?utf-8?B?bGhJWkpyN0xuSlNnQm91T1psdVFIZ1NTd2hOZUZRaDJxaWkwQnpPQ2dON0hV?=
 =?utf-8?B?Z0grUklYeGxxZVh4a3p0ZlAxS29mbk9LSlFhdW54UW5Na2N4VnFLenRHZGpa?=
 =?utf-8?B?enlKcDlpczhVMWlNTFM1cy9SRkFnMVFTV3c2TC9iK21CM0doYm95VUxiWnMv?=
 =?utf-8?B?b3NFZ2JOTzVkWmpScDE1M3UrZ0x2YWxHQlY1SnZFeEw0bWp5cXlGVVZUb1M3?=
 =?utf-8?Q?6Jc5U6tKPZJdv5c7oQsmWI5bz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7e2ca7-d171-4c7d-b09e-08dc86e667a5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 11:38:52.1730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSbMHEuEaurWd/8+aHbk0v9v3KRNOSnoEFySlUkfiKVEZ8AbciW3k7JNFc2JujSF
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

Am 07.06.24 um 10:33 schrieb Bob Zhou:
> To fix potential overflowed constant warning, modify the variables to u32
> for getting the return value of RREG32_SOC15().
>
> Signed-off-by: Bob Zhou <bob.zhou@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> index 92432cd2c0c7..9689e2b5d4e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> @@ -544,7 +544,7 @@ static int mmhub_v1_7_set_clockgating(struct amdgpu_device *adev,
>   
>   static void mmhub_v1_7_get_clockgating(struct amdgpu_device *adev, u64 *flags)
>   {
> -	int data, data1;
> +	u32 data, data1;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		*flags = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> index 02fd45261399..a0cc8e218ca1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> @@ -671,7 +671,7 @@ static int mmhub_v2_0_set_clockgating(struct amdgpu_device *adev,
>   
>   static void mmhub_v2_0_get_clockgating(struct amdgpu_device *adev, u64 *flags)
>   {
> -	int data, data1;
> +	u32 data, data1;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		*flags = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
> index 8928f9160822..b4ce3375d3fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
> @@ -613,7 +613,7 @@ static int mmhub_v3_3_set_clockgating(struct amdgpu_device *adev,
>   
>   static void mmhub_v3_3_get_clockgating(struct amdgpu_device *adev, u64 *flags)
>   {
> -	int data;
> +	u32 data;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		*flags = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> index 1b7da4aff2b8..ff1b58e44689 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> @@ -657,7 +657,7 @@ static int mmhub_v9_4_set_clockgating(struct amdgpu_device *adev,
>   
>   static void mmhub_v9_4_get_clockgating(struct amdgpu_device *adev, u64 *flags)
>   {
> -	int data, data1;
> +	u32 data, data1;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		*flags = 0;

