Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6D9CA9ED0
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 09:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4F4310EFAA;
	Mon, 12 Oct 2026 09:51:31 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010013.outbound.protection.outlook.com [52.101.46.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83A8410EFB5
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 09:51:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arZmZcNVl/OfOTv1gfRFPBBILATV6dvRBPvj1e/h1ntAU4ual1TiAtpMcxEhzCuaHCWLwRYVo0XmrqpfSbHe+c9ZnLQkqJnnSrTq1Eob1R+2HWu0yUSc5jzQ1knME+HVg8oOB/LroPryyQMem7Pd/Gn7Ojb+3j8+jKC37buvQQEl4e/B0XI0/NDzWnNSJ8+riqnbaFLlWP0X1qsHycfNVifqcqRa6AIRh90j7IGRgF2o4SGy6kvBMM9WikFf0DHer59c7thhLF1IOSJYbP3GOKH2zIVWS4MeUwEpRHqc9QCBEZg5F0KWJlGxyy7qBCYtqp1E/JbP/rzXrk7CYkT9zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoTxwJFyYEZCkXqxd66ECdEBbtotD28aM/xmZZPpjvI=;
 b=oQYe69X260A5WIMRjQRfGKZtLe9B5VQxmOfvflX9rYenBZsjmW6SZdGPx2S1z5Zgk24mCH7zfV4cevRs2vbMkqGN8e+Svvr4MvkXbafmQ0VfB83QZNqMoBip4tbt/43jUFwQg46ajX2ZUBY+N1k0xn++uWnv7SGQc73/pX7bInrM64ZFqSpK5hAK5rpGJudydSl/AWrKxUIsGf/ZoEwKp6FVSvcPeMrIIcqUVXSP9scLW8dTOtzStjA8hBsA7vek9ixIz/1jCmmu+7vzblkxr8YTIXrr5ybplXoZ1pwFbTxOYFkX7d0SAs2rMThxRskVyQmeUXFhL8OyZpBWTHElpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoTxwJFyYEZCkXqxd66ECdEBbtotD28aM/xmZZPpjvI=;
 b=4ISSiGih5GLu2RHUYePcfTVtnHzLZDDx01hZb7epfIHIsNExRh8zAeuV2wePEWkrwJGU2+ik2kaq9qrrKHPAKjPs+I8Gub90LQlbYQAC8hr98mi2+BwLtvNQpjPc/Uws+96SSbmdQrjJqflBZOkB3edbxnByQ2sDihupxG5zDsM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB7497.namprd12.prod.outlook.com (2603:10b6:610:153::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Mon, 12 Oct
 2026 09:51:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 09:51:22 +0000
Message-ID: <17c80565-2e84-4815-a4fa-4e947a0f0234@amd.com>
Date: Mon, 12 Oct 2026 11:51:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/amdgpu: report the BO alignment in bytes in
 GEM_LIST_HANDLES
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, prike.liang@amd.com, sukhatri@amd.com
References: <20261012094754.1685828-1-Jesse.Zhang@amd.com>
 <20261012094754.1685828-2-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261012094754.1685828-2-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: 9572bed1-65d9-4195-d53b-08df28465f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|10067099003|18002099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: UL7QL2GAtvrJK4xX/CoIahOzhN3iZ0nPih7N9M274rLY5SV3O3UEqnQqUNcbMGKceJgyV9oSiPKCIIM8h449tpEbsEZPY5P71IXBwP0lXl2xfrDDaqF1vDKJ0/yOtPblH/pbynXVsbkqukm+KQkoRvPih/WaP9HYT5oscTbr0niEtTRFW2mUW4L9fxZzj/TxfsOOMZ251fXk/+jb3Vr/MewDyLPTemKGC+jvZhhfFqZzJRU1Vo8wF7IMVYp4tI6VWmOSsAcHlnshu494Mz+6wGYu30k5l7QfgB/58Fgt8Gy1bINCx/UpIi5FnU7f87BKwIFYzE1RK3sHCexwa8YAI41Kv+KPSmXXfX1qWKck0bYveuPsmV3c1hLTEVygxMng85wzSqo1xonSvgYA7NXKvswb9K1FIZHwtilHQoIzeghfshWuDSXBdUxLs6y7hVOS3XXhnfZl4RdZXVhbYvnXwttd75t0nsS2+fszn7nANOs0C5TbQKcl2okvrNx5+FjXZHlXjAkvYgYMn+Yl84EtoqmCD/GVFH8ayOayMHNAiUSjroIGRWmf9osOuKfG/eJhEEakUegjQwyXTODxcVXaAGg03UPtG2RrzmXV6chgDcHhKsWFthnn8jyuwYTQWPZJp9JPuvjo5SOgQzG2SY1NrY5Q4B8JKGQHQoFgUxntxf8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(10067099003)(18002099003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFdyTHlDOVBJdmJxREp0TEdGTWQ0dkFnbEVzY09zOTc5ZEhnTkRoclgxQUhx?=
 =?utf-8?B?RzI0YWxRSk9rUkJ4MW1ueUcxVEdkOCtKck42d3YxelpZVkRyZWtSaGNnWGtO?=
 =?utf-8?B?TDVVRXYvb0tMWHd5QjlUWVpTKys2UnRiN0NQVXRyVkxhUU8wVXhCMGF0b3No?=
 =?utf-8?B?Y1BMbE13TE1CNmRBUmhJNlBjQVNvSG1SYjdackpNNDRQNkNuMVNnRXlHb0p5?=
 =?utf-8?B?SjhRVTljYjQ4dkM1djNQblp6aUZzak5EUThHT0dOVTkwOE51R2JWMmprSTM4?=
 =?utf-8?B?R2JXb1FkOVVkWW15azBtZUEwSWpRSUZJN0hHYkpaYVdQSXNCUmZSUUdlY3RP?=
 =?utf-8?B?MG1jYWg3Z2U3OFczTTY5WURBZWdWcFlnWHpTRWl5Z2k4bU1TaEZXSFVCbjNm?=
 =?utf-8?B?aFNId21RSi9Sb3M5b3lVbnQ5MmZEbUtGN1J4R1FsWFRnUmFWcGNDQ0s1ejZL?=
 =?utf-8?B?ZVZPamhCdFV4eDk5Z0x1bW5rT3BMa2szd1dFbUJmUXJMdXlMM2ovSkJuZVlI?=
 =?utf-8?B?VGV1c3UyRjdrcHZaSC8zZlhrSUJKaENXWnlKQXpXcWdaSzl4ajZwUkNneTJV?=
 =?utf-8?B?Wmo5MnkzRFJJUWtTU28zQUhnbUNSYy9CMDJGVExiOHJDQ2dYelkrRzNqd0dU?=
 =?utf-8?B?bFo0ZkFQbUtVRFBYeXpwOG5WaWM2ZWNRdHFKNFRUYXdNcFNtcGJyZHlHOFlV?=
 =?utf-8?B?amF5QjlKOC9EMmhHWHhQaFNvRmtqRnduQ0FJL3Z3aXJaZXFPZnlDdHFtYWNY?=
 =?utf-8?B?aGprN1ErYlp1MFY3SjNPc1AwbW80NjFsVmpsK3dJdXIzZmJPZUdJdSs4R3FG?=
 =?utf-8?B?WUdLM2duVTZwcituSlJFdlcyMUJTSnl6d3lQTVQxSStPQjVNVUpwb0dYcGxw?=
 =?utf-8?B?WnhmRngzeXhDb3MxWTZYZGpiMHMvU1d5Tk9nUWg3TWY2QWd6TlpYcFcxNFBW?=
 =?utf-8?B?bmhVVGxSYmVjK0FCZjdYalJLUVBFRnJDRHBmamRzS1VuaUZIdW12UmlvNUFT?=
 =?utf-8?B?WGhUN1pLRSthUXVkNFZrNnNMSm5nUVR3L0d4RHBwTzU5dXZ5aWw3NnNMT3M0?=
 =?utf-8?B?ajAxMERkWVVDNnN5ajg1NTNNZWZYa2ZqdlArWTRHSVhTdkVxa0p3bGdOTUJJ?=
 =?utf-8?B?MW9OdnA4Y2NzVFVFTGpTazg2QjJSaGUzczlMa3NFVDN4T3F0dTdxbE0vQWgw?=
 =?utf-8?B?WWpyMHU4RzhSR3krM3dFZm9GT3dReXFWZ3daSTIvMjZldEdBa3FMOG01VEpK?=
 =?utf-8?B?bWFmYUozbXhiSnR3a0NWajR6WlZnUXpZSU5KNVV3WW4rbksxVk9NZWl6dXkv?=
 =?utf-8?B?dlBLUUxHb1JON1o1SmhtL0p6Z0FrMjdCNC9yM2h0Ulp3M242Mkg5aVhncWJH?=
 =?utf-8?B?aUJqTTZSSGZEUHpmMUo3WjVFTmZYK1djZElabm8rK0doOUs4Y1VlUCthV2JQ?=
 =?utf-8?B?OEtCcXcxR1AyVXZkY1pHR01BU2VSWGttdVZJVVpiZTAvV0c1V0FPQWkxRDdU?=
 =?utf-8?B?OE8vL2NFN1NDUmdybmU4blpka1lUMjBVS3lEVm9zTFBMZ3p6QVVvVHVVMGVE?=
 =?utf-8?B?RDhLbTBvUWpKWTZ3T0YrdXZpdklCeHFFelVsOHc0NmxnS3Nac1gwOHBpemtu?=
 =?utf-8?B?NDQxVVhKT1FYS0dyV0IyQUVYZzNWQThrbU5pekFEUi9qai9qM2pkTFFjd3Jr?=
 =?utf-8?B?ZFFWN3lHVEt5OGMwUXJ0ckhIY2xheVNwbjJDSk5FRjdNZ0FlR3ZtWE42SlpC?=
 =?utf-8?B?Z1ZSenZsa08wVThqMGdrNU92alorWFM2NDlmRnNwdDRhQlliUnN6MmhiZzk2?=
 =?utf-8?B?bWJRWTd4YStwU2puaTVKalhyendpZ1M2Z0I1SlF0L1llUFdPbnhmQ2hlT3l0?=
 =?utf-8?B?NjlzZmZMSHhEdjh6dkNndXZybzBpRFZ2V29JTlNYSDhDcXNrQlZheFNoYVg0?=
 =?utf-8?B?eWNMQ0paZ3V6K1VEYjdiYzhLQnlFQUZFa1VJOXdSbWlLRDlKZ2h5N0ZjSVZ4?=
 =?utf-8?B?akpLV3M4TVNlT09Fb1NkMG1zbnlnU2Y1NUZrM2xOa1VZb2dGUE9qellnODE2?=
 =?utf-8?B?TGdNUUZLa0NYSTRnTWl0czh1eXl5VVlwbm9VbHVycEhmNW95c1hYQ1pObHVY?=
 =?utf-8?B?K21GZ1h2RWpkQStLUUtuRjNQUnZNc0NNbWNPenV2Y2gwbC9WM0h4d2lIQWlm?=
 =?utf-8?B?ODl1aTd4bDVxMVY4azdpUGkyZzBHakF3dFd6SWJ2eWJ4dGlqVDdtVGIvVTBY?=
 =?utf-8?B?a2o2a2ppeDd6U2xTbzdtaDY2MmttcVFXbnY1RElGaDZsY2g5QkhMQThVWnIy?=
 =?utf-8?Q?IvS0Tnv7fhKrhj33rz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9572bed1-65d9-4195-d53b-08df28465f20
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 09:51:22.0365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBiKqIsVAmTZ7MBdD/hFQgOz+Gajkzq8DRPe/qZ6uOsjekqqrYCBg+HFRNmyvekV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7497
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



On 10/12/26 11:47, Jesse Zhang wrote:
> The uapi documents drm_amdgpu_gem_list_handles_entry.alignment as
> "physical start_addr alignment in bytes", and GEM_OP
> GET_GEM_CREATE_INFO returns the same value in bytes, but
> GEM_LIST_HANDLES returns tbo.page_alignment, which is in pages. For a BO
> created with a 64 KiB alignment on navi31:
> 
>   GET_GEM_CREATE_INFO: alignment=65536
>   GEM_LIST_HANDLES:    alignment=16
> 
> so a user such as CRIU that recreates BOs from this list uses the wrong
> alignment. Convert it to bytes.
> 
> Fixes: f9db1fc52ceb ("drm/amdgpu: Add ioctl to get all gem handles for a process")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index e791d066fd47..8dbd7bb77305 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1281,7 +1281,7 @@ int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
>  		bo_entry->alloc_flags = bo->flags & AMDGPU_GEM_CREATE_SETTABLE_MASK;
>  		bo_entry->preferred_domains = bo->preferred_domains;
>  		bo_entry->gem_handle = id;
> -		bo_entry->alignment = bo->tbo.page_alignment;
> +		bo_entry->alignment = (u64)bo->tbo.page_alignment << PAGE_SHIFT;
>  
>  		if (bo->tbo.base.import_attach)
>  			bo_entry->flags |= AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT;

