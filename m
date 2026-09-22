Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DE6C98302
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 22:25:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D980910E769;
	Tue, 22 Sep 2026 22:25:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FaNBF/hU";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011001.outbound.protection.outlook.com [52.101.62.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20C9B10EEA6
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 22:25:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XN/wYsfXCsd+6paopjunhVRMVrTT9euDseMmSp4b1x9qbqheS7/kUdzZeKlMwhIBa7TjENTnKR98asI5zBQPFi4pXuRubLRUmLx1iAb0iMicimKQXpl2mvYb1pQkvraEmNdCVpzGw36vKtcxDK/0CLY61mB7oiUU/iQ1xwAHWbDS/DvAicdIepzx0Q7jZykPt5ORklWgdeLx5U4fVI15cVsi2AJgtPSHTmFWG9zLE7gVfpLK1u0PxQ0fhv7ETa0gJhK6OvnfkUa3CtvcTGcYqEUE6I39HrvsLVEwjykDdmMvv+chU7CiVSNujEV3KnQnZmM7qT2qsygxEbVdum+/nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwGoT3Kcs1SERWbh0tJlJaxR42uDFBxsVlt5TDKmLxw=;
 b=O2RPx9y6yrrQjUJlKzUiLOS610bhtEbuqf2e9QnF/18b9w8dV5KA5MUHapXz+aK1rwaLbforPTp7c+cUUGNb3zcjMCuHSwWx50EgZLos6Mu214O2JLW/nfZj5S47KOS99x+I5Z5gmgxdiEJ+GYGT/mBFXfsZNYW2TgBmylMNjINsSwkHrkBDHEu0UaP7MVSppwUahI2S7/VlB+L+DzTo0I4ozxAG2YlmATxX5OAkZt/yRkwa5Il7xzVtZr3syBRD3XRGM7xgNN9GiU+GrP2dlRXXiGcXO3kXj4wk4nmUnlTSBtydcWGd1pbPYtl+kkJTuQajrUHFmhwLk+eaQA6XXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwGoT3Kcs1SERWbh0tJlJaxR42uDFBxsVlt5TDKmLxw=;
 b=FaNBF/hUbHxT8Gq8oGAaNXG7Lyzs+Xx0fd5ebFteFOqDrR27LMPGcAHhWNrkvkjP72LvWZQtTu++Cq/GjXvIzaXt7TAlHKvKUxGbxrNAFZKrtCq0hCSP2WNW1BQ6Sv0emO95Mo1JgNBg8PXMF/W6h8RsNdteoUy1ZpbBw5SXIE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by SJ5PPF1C7838BF6.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 22:24:22 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 22:24:22 +0000
Content-Type: multipart/alternative;
 boundary="------------anUqlFU4Z3OhcGoe9oWgP6GE"
Message-ID: <bdc3ffbb-4c65-4db1-9103-bce2cb20f807@amd.com>
Date: Tue, 22 Sep 2026 18:24:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Fix always mapped range mapping to all
 ACCESS GPUs
To: Andrew Martin <andrew.martin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com
References: <20260922214227.71213-1-andrew.martin@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20260922214227.71213-1-andrew.martin@amd.com>
X-ClientProxiedBy: YT4PR01CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::15) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|SJ5PPF1C7838BF6:EE_
X-MS-Office365-Filtering-Correlation-Id: 4badd3c2-8736-4316-256a-08df18f84069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|22082099003|18002099003|8096899003|11063799006;
X-Microsoft-Antispam-Message-Info: WF5NURUKniTvbZdMcF10xVjSnwpA6MWmOeP0lrEoZ5YpX8BJtI14nS9fdUgveQODQcEPPuu5Jb/QcR1Z0NctzQnR2ZzgsmtjNOgslXOQT0DfIvN1MHJt35FwQtm6HftYDwjaGQvMQrgaRW6csVR8uzGVuutcDM1RchR5a+4eylN39rJWVGW4iWa96QJXmHu0acbmpWk+m2GdzuLI3kXqj0C6q9PAN8mjhLRuWYk2Nm12mTtK6P4mQpY7xMy/J3oGOS5AiBQm2L9oubWqub/ToUs8K6iwhaDrN9HHmDGa1umnTYWV6YrrCtOwWn7+GUnty7smJuPwd30zo49pjkKOOUfHt7CTC8evOIL+JFdOyqyb/H9zAumQsJMLXfrkDot57ZJjkAvlWyvX9gU5vaCi5BYNpk2WoYX3d6IrQsy/dr2U4jZora/utVhNZf5hexAOa4OWx8jaRTSTRRlOsY5SceyQpcIv5vnnwmgvmbHNQEbzHZe64Xd3+YBBRBZEW/1Et4N7ktGbU7bht9HP80A7x8dvwGKEVDrTI30P1J+967PxdOUVphwA2LlSWYtccTQljKoPiIKbF52IDl+k2tzqudNynoYIYNz51bf1+2GLGYEAF4l8O+EJzY8lEmh0z3Yk3XutXnRLav/z+N4QX3ackhdHgmE4KL/YM1kBSnhX708=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(22082099003)(18002099003)(8096899003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFVrYWtxb3laTVlLSE9Vclg5Z0JmaGwzS1JnZVdMQ01uWnd0R2IvcTN6cTRU?=
 =?utf-8?B?M21ZdGptOFpDaG9JcHc2UnhMT094aEV5emVzaVBja2V1K3NSTnk1am0zbldH?=
 =?utf-8?B?aGtTVTI1TEhwWmF3NDQ4enFGc0VhUDlGR0dkVVIvMUNEWGU3NlA0T2RPMEJB?=
 =?utf-8?B?YnRqcFNwUTFJVDhpVXUvR2xVbGVjdm9kZFBlb2hoT3B3WnVtcVVmd2N4d2pQ?=
 =?utf-8?B?OTR5VXJRU1UvYXpLNzVrTnBCZ3V4QVhZd2ROeEhndk5qbGtEMlcweGlzQWpS?=
 =?utf-8?B?ZUdLMnpyRzl0KzBMc1dwbUhXdWVYcUszcG03UVFtT1BRL0FXaXorZFhGdXBt?=
 =?utf-8?B?U0hDREErMGF1Zms4dVAwUGVFczB1N25SOEZyRG9MckZRbDc5V2l6aG1OL2Y5?=
 =?utf-8?B?aHdhQktCMUkveUdxdjR3VlB4WGhEYU5KWkhOb0xiN2FkekxDZDkrbG9ZcTY3?=
 =?utf-8?B?QjFGMHVNcHBnQkxhbDcwZlV6QnJibTgrOUwyb3pJRDdnOWMvRmhnVFNTUVk0?=
 =?utf-8?B?U3ZhS2E2bkxiS1paRDEvREhtSGo5TWNpTExZTzZRMkcvRko1WVNIV2hhNWxu?=
 =?utf-8?B?R25rMjN5SjRuR1c5ZUxER0ljazBVZHRMVGo1UkVvam55WGh3cFpKSC9PVFUz?=
 =?utf-8?B?SjVPNjdJWkJjbEF5TU1ENHlleG1ZV2JtMFpXK044K1lVU21QRmtkMXBNR3VI?=
 =?utf-8?B?ejZ0SVYyd0wzQTV3REoxWUltVmJKbC9ockVra0kwNExDSmhWQjVvamJ2R05V?=
 =?utf-8?B?ZW1kdkhLNDQweE5mOHRnb2NiZkVJTWtIdmpVdjJkejdKSGp6RTFYUEcwQ3c3?=
 =?utf-8?B?bC9WaFRmRE51UTE2VHF6SHdBWlM5MXFlK2ViWms3RlEyMjVsT0Yzdy92RjRS?=
 =?utf-8?B?RUgvZjN5aTNCaUUrV213KzRLR3UzaERsaW5DRG42WThZSXdpL1d1UUJONW0z?=
 =?utf-8?B?TUVEU1BpWmFDZGFWeGkydThYc2R2S2I3a1FnMkdGd0VNc0ZQeXdlMzVEa0xI?=
 =?utf-8?B?a1djQSs4eStNMkFIZ2R0Unp2YXk0RTRpTDlUeUdWWUhUUC95ZkZJOW9JY2tk?=
 =?utf-8?B?T3VYRnZIUjJSK0dZbGJ4ZDFOMDhEUWsvZVYzZnFucDJVTS94eHhPVml4U3NY?=
 =?utf-8?B?NFFyOEpSUEJ3TlNMRFpTcCtjVTZyZjFiMCtyL2hMZUdIeTZSRXJNN2hoaGZP?=
 =?utf-8?B?SmhVWXo4VWpqV2VzZll4a3RaNkVYbXZONDVlZEtuNVVJZHhtVnYvaEEySTEv?=
 =?utf-8?B?NDJkc21FUzJ0bTJHd1ZGc2xhcmdKUVF6cnVqQlhhWEQzSHpMNmhya0xjUmor?=
 =?utf-8?B?L0xLN0VmSjVPS2M1d0lRQkUwZC9ya2RCUm5pUlBUbHc5SktrTmUrV0t4WVVN?=
 =?utf-8?B?UkxzZG0xRUc0RWdBR0k4QVJiNndSRjRVWTFiMnNLTDk3OTVYSEdrQ1pObExy?=
 =?utf-8?B?Vnd0ZlQ1MFk4MUx4bDlYUVg5SmI3TExnZVMydGVYUFh2Wm94OUczV3RsMzRl?=
 =?utf-8?B?M0FIRS9TTDN0QTRPUDJSdm9LSlYvWmpnMVVUaVVuNG5Zbk8wd0V3dTBWMnFk?=
 =?utf-8?B?cWl3UHBEOTdKTXZrTUYyS3lDUEpyaGFnd0V4Z2owWFl3SW5Na21XTjNmTFdT?=
 =?utf-8?B?amRyL2c0a2FNYVgvK09CWS85UE4wcE1tMFBReDVVNlFMRStLNTVYRWYxMlkv?=
 =?utf-8?B?TVc3L3g5dEZ3M1lXVFhTY2xHZWhDRjNiZHplajJ2RzBmUTNKWGIrK1NQVmh2?=
 =?utf-8?B?ekdINjZPMk53S3FCay9DNWJoQnh2aHo2aFhSZXIvQ0VGZWxOeWlzVEFrblZV?=
 =?utf-8?B?Y05jNVFzYmdYekZEUW1UMzZmQ2FXZ0RMOTRDbUM4LzcyYmtleStiUDB0YmYw?=
 =?utf-8?B?ZmlrTElCWklKL0pYSEtrNFN0b0RKR3NUR2M5NHJoS3E3c3QvcEdFWHV0YVZx?=
 =?utf-8?B?ZlBLcWJ3RndTZ1VDelJYandoZForQTZiT0FmTkNZOEU3Tnl3dDN0c3NNcWF1?=
 =?utf-8?B?eEJEMWNSdmxNc3JqY1RJc3g3a2k3TU5zaFlEZXBmdDdtejZFMDAvcUJ2eE1N?=
 =?utf-8?B?N1lyWXdSVk1DSkZ4cUJMTGp0c2tHSUVISE5kUUdkdWJTOGYyWDJJbXVnTysx?=
 =?utf-8?B?d2lOK3V5WEZJMHl0TysxT2U0dG03MWJDa1NDRmhFRzVLR2xVNzVJelJsRFlZ?=
 =?utf-8?B?RTJVelIxRzNhRUZxaCs2YVZIeGxKdnZXV1hESVlzRWsrcTFKN0FhR0dYNk1r?=
 =?utf-8?B?VUt1NVJ6UVVvcDZHYU9NK3NoZHg0ZmE4NHp3Z1JjdDdkelVFTHNDd25qS1ZR?=
 =?utf-8?Q?Drn4JsKLENpqBl2WCU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4badd3c2-8736-4316-256a-08df18f84069
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 22:24:22.3523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bo3c1XH/iHXm27bTVybyM4DPDwYoqp0u8vsKt12vl62FrRFt2Pwg1Rrn3mqjgr4o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1C7838BF6
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

--------------anUqlFU4Z3OhcGoe9oWgP6GE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026-09-22 17:42, Andrew Martin wrote:
> CWSR ranges use the always mapped flag and only need a mapping on the
> GPU running the queue. However, svm_range_validate_and_map now updates
> the mapping on every GPU with the ACCESS attribute, which is all
> supported GPUs when XNACK is on. After the range is prefetched to VRAM,
> those GPUs may span different XGMI hives, so the page owner mismatches
> and is set to NULL. hmm_range_fault then tries to migrate the VRAM
> pages back to system memory, but svm_migrate_to_ram skips it because
> migrating pages back to system memory is not allowed while the GPU
> mapping is being updated, so the CPU page fault is never resolved.
>
> Only map to the ACCESS GPUs if the range is not mapped to any GPU and
> is not in VRAM.
Reviewed-by: Philip Yang <philip.yang@amd.com>
>
> Fixes: 6b2969831f7e ("drm/amdkfd: Unmap svm range from GPU set to no-access")
> Signed-off-by: Andrew Martin<andrew.martin@amd.com>
> Assisted-by: Claude:claude-opus-5
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index c521ec07bf3c..a99dbedf3cd4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1757,12 +1757,15 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		}
>   
>   		/*
> -		 * If prange with always mapped flag, update mapping on GPUs with
> -		 * ACCESS attribute
> +		 * If prange with always mapped flag is not mapped or migrated
> +		 * yet, update mapping on GPUs with ACCESS attribute. Don't add
> +		 * them otherwise, ACCESS GPUs may be on different XGMI hives,
> +		 * that would force hmm_range_fault to migrate VRAM back to ram.
>   		 */
> -		if (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
> -			bitmap_or(ctx->bitmap, ctx->bitmap, prange->bitmap_access,
> -				  MAX_GPU_INSTANCE);
> +		if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE) &&
> +		    prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
> +			bitmap_copy(ctx->bitmap, prange->bitmap_access,
> +				    MAX_GPU_INSTANCE);
>   	} else {
>   		bitmap_or(ctx->bitmap, prange->bitmap_access,
>   			  prange->bitmap_aip, MAX_GPU_INSTANCE);

--------------anUqlFU4Z3OhcGoe9oWgP6GE
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-09-22 17:42, Andrew Martin
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260922214227.71213-1-andrew.martin@amd.com">
      <pre wrap="" class="moz-quote-pre">CWSR ranges use the always mapped flag and only need a mapping on the
GPU running the queue. However, svm_range_validate_and_map now updates
the mapping on every GPU with the ACCESS attribute, which is all
supported GPUs when XNACK is on. After the range is prefetched to VRAM,
those GPUs may span different XGMI hives, so the page owner mismatches
and is set to NULL. hmm_range_fault then tries to migrate the VRAM
pages back to system memory, but svm_migrate_to_ram skips it because
migrating pages back to system memory is not allowed while the GPU
mapping is being updated, so the CPU page fault is never resolved.

Only map to the ACCESS GPUs if the range is not mapped to any GPU and
is not in VRAM.</pre>
    </blockquote>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a>
    <blockquote type="cite" cite="mid:20260922214227.71213-1-andrew.martin@amd.com">
      <pre wrap="" class="moz-quote-pre">

Fixes: 6b2969831f7e (&quot;drm/amdkfd: Unmap svm range from GPU set to no-access&quot;)
Signed-off-by: Andrew Martin <a class="moz-txt-link-rfc2396E" href="mailto:andrew.martin@amd.com">&lt;andrew.martin@amd.com&gt;</a>
Assisted-by: Claude:claude-opus-5
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c521ec07bf3c..a99dbedf3cd4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1757,12 +1757,15 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 
 		/*
-		 * If prange with always mapped flag, update mapping on GPUs with
-		 * ACCESS attribute
+		 * If prange with always mapped flag is not mapped or migrated
+		 * yet, update mapping on GPUs with ACCESS attribute. Don't add
+		 * them otherwise, ACCESS GPUs may be on different XGMI hives,
+		 * that would force hmm_range_fault to migrate VRAM back to ram.
 		 */
-		if (prange-&gt;flags &amp; KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
-			bitmap_or(ctx-&gt;bitmap, ctx-&gt;bitmap, prange-&gt;bitmap_access,
-				  MAX_GPU_INSTANCE);
+		if (bitmap_empty(ctx-&gt;bitmap, MAX_GPU_INSTANCE) &amp;&amp;
+		    prange-&gt;flags &amp; KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
+			bitmap_copy(ctx-&gt;bitmap, prange-&gt;bitmap_access,
+				    MAX_GPU_INSTANCE);
 	} else {
 		bitmap_or(ctx-&gt;bitmap, prange-&gt;bitmap_access,
 			  prange-&gt;bitmap_aip, MAX_GPU_INSTANCE);
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------anUqlFU4Z3OhcGoe9oWgP6GE--
