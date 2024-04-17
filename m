Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1083EC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 03:37:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA73E10E2BB;
	Wed, 17 Apr 2024 03:37:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MiO3/ujU";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1598E1130C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 03:37:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lviZWPO30ioM/hpaCOsHHEyjYLaid74xvnbZ5c4bIQE2hNkBb8+dMAHxdaiPPE6he18j7FA0s1IpZ63bGUFZ5CvOmWRqWJ9hCjwIWvTaak/OMSWc1g/L4/CMtGDwuRyhPvU+x9EaHzc8oPex3fwxRd2+1755YSbSiZBef5N5bqoLHYsfUNaA78mssVhbe3BQIMHpWgXqEsgdkU1QhGtpd1vSzB0fVXdatlXAvLksfN4VlE/LsdW7m5zEL5LRv2SdRSDhzwZhdi0OckGlqjk87aea3WoADZ+/TmFjrbmWBKf0x8hE7OFQmEtGhpe3uoGN8p/csjGBPnjI7XI8glN70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSMVCHiMC49PhXJTs4QILCm/9eIDUwPpIjMyISkBJ9w=;
 b=PJzQ3BjG2BkHyElyUWWJucm3B9PWDcswDQxPqn/t+TtlX8klMR04xDgZ1RPrzkqffIW9AS7YQoM6CaPubHpR7UGcZm03pzqVOKuZAl3SJ6UJ6E9TALGsa6dUD2Zd/CJEM+daalqknnN9OvFTwNzsiJ+0vSCr8FGAzTlD5sHvKQ0gN7WStM8/VeatVevpqAYbo5+GxirlUfVK+mLnVBg1mbA4lO6FngWwiCMWJqLD4+AhDUxb+oxSZ25jHwGriMjUYIYmEc6fUEFMiyeDNOZ0n2E8TFXT2eQZqZauhSh9U1KJ3X3TK9YGAtrytyjNa8B0y3yg4nTBltzvd12GaGoygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSMVCHiMC49PhXJTs4QILCm/9eIDUwPpIjMyISkBJ9w=;
 b=MiO3/ujUW/jYEq8PNClQo9wJHglxrfMjZAhmWpMPmk8vHF3fmeTYUhW77ZwOgWjv0pZnb17eNPEg1pNVjEZbKKb53lbLIR8tp/4iDPg/xmijrlkvl5u1JiwZ4bHwFGOjQB3VHxEOmJVkTEGHc3cEIIS/9nx+S/I8p+K3xNrvd6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB6629.namprd12.prod.outlook.com (2603:10b6:8:d3::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Wed, 17 Apr 2024 03:37:18 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 03:37:18 +0000
Message-ID: <273c27ce-65b2-438c-a7ec-d884ea677750@amd.com>
Date: Wed, 17 Apr 2024 09:07:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Skip the coredump collection on reset during
 driver reload
To: Ahmad Rehman <Ahmad.Rehman@amd.com>, amd-gfx@lists.freedesktop.org
Cc: ahrehman@amd.com
References: <20240416183512.19660-1-Ahmad.Rehman@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240416183512.19660-1-Ahmad.Rehman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0254.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::20) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c9e18a0-f7e0-4e93-827c-08dc5e8fae9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WWKdVbcLp/73ymtqLSw+zkaqNUc2VlAc2GsV+cOyayXK+g0QRC/yyPSHcpjgfeTOlm1S+rZATORixwLfmP4OuaeUf0/AFluz5M1epUnG0nnTxgliEtLPI3r51my10TdHtQbF2HEGai2AaIW9LOTuKUYF1IrrfzS/fJZs2LxUmA8pgFw9fyPM/71Ozu81F2QmmEfKAPAkLf1blUZnLKLa5rQy9KO20YL++YXFfi4hJE9I5OvFTriEfr+AHZv9kbKyCSY+IDW2E5z2wxTwC5qOI6ZU/1tEZrpXAoIVXl5f4sWLX9H4mgzd2WjwNUW6xbmcjuM3sv3LFd721Vz/Ljec9VVZ2S16U7f/8jpj27FTeUWByIa5epQ4DxkV9OyF2Z43KVVhywkJ4x6VIfb/tBHE9MwUcbNUqzJp5LiURjV9ep5S3X67/akFInYmRqdYA8Ez1BymUXNsmex2H4tps244vx48Vjzo+R2YRY3YX9lhI4x/uXBB3QTflDQVRnYgf416TbQpxRFpbhvNAfXbGg3XHF97smDhXNDRpJMCJ5DU3FsykjZwvp3pdZzuiKH13Ocy8BRC59q1SeTf4eA3WnxEZIwFrBfMGi7P1HodYXkSELOXIgV38KTgb+GalpGGuZB2aE8NyWznrtx0VTKkdQiTt0nI4NyfevSwl4T6NWOF7PY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmcyQXd4TEJ6RGZCNFRULzVBWVNBK1JCTGtKZFVpQlBMQWdlQk1kVGVLK0hl?=
 =?utf-8?B?VjFWekZLNjRWeG9TbzlmQnpzaGdYMm84MkpQOFFDeWtPUFBoallXOHlyZ20r?=
 =?utf-8?B?RFo2UlZlNFhucVkrdEtGK2Jtd0IwY0ttN1hCaHdHS1k5VzVkRUcyQlNtL211?=
 =?utf-8?B?aXB5NFJKNnAweWhHZ1E0ZW9UWXh0empCWFJsTms2RHFEdERrVEFSYnhZODg4?=
 =?utf-8?B?cFpmYU9BTWRoUnZUVW1WN05SVGN0US9nNE12VlM5RGEzU3owMG5NWjZRNUtw?=
 =?utf-8?B?ZmkzcUNZU3phRmpweStxWllkQ28vZStnYW9yVUNERHd2MzhMVUFTN0lBS3U4?=
 =?utf-8?B?QW5obTc2VVFjcWtzL201QThrbUd0d0NMRmhnQjVwV1grNVdRNmFBRyttVEFG?=
 =?utf-8?B?dGxSNGIxTHM4NE8yWnFzZFpWMUdZeXdxayswSFA0NFVUVFd2SHhNczBsTENp?=
 =?utf-8?B?UWJiN0NsaUF0N09NMUtnWHpqS2g4ZFdaWnFQNW8rTVI1K3EybWo2Mnl5N3A2?=
 =?utf-8?B?MkZtbWF6SUhKa3FOLzlRUmc2bDdiK0pzd1BNSEtYY3dOcjJWbmFhUnJqQW5j?=
 =?utf-8?B?VzFkbjY2U3E4YkpOODBPMERLV1lXNEVGcU5EMytuRFllUXEvKzlFK2ErdTBT?=
 =?utf-8?B?M0wxYmFBN3JqQmVxZTNTTE9HclJWMlp3U2p1SWp2Z2xMY3lVM1lndk5DZllG?=
 =?utf-8?B?MXFBRW4zZGlrSCtoN2dkdTBlYjM4Y2wzcjZJdWM4T3BvbFBqVGdXeUFEQ3NI?=
 =?utf-8?B?cVkzKzg0a1NNRWxqcnViK3NtTk1tK3Y1aU9yaGNyUzFuWHF6cjNkVVhDbFNr?=
 =?utf-8?B?VEVBUnBmMVhjd0dHV3JtcE9meTM0VlZRR3dZWVo0cCtWeVB3U2gyWXkyaTZ5?=
 =?utf-8?B?V2xNa29qeVU4U2VNdUFmL2d1SkQvS3J1ODc3OUFpVHFMRjVEaVNZaGRjUTNW?=
 =?utf-8?B?Z0hiOWVRZjlTMDFkM1dYVzFDSUErZXA0VUJaZytIY3JnMVpjNzVYbmlKd3pQ?=
 =?utf-8?B?cUVnS3Jna3QwMkNyaWlTVjMxby9NYVVHbHY5V1BYWGdkZkh2K05jWVYxSGl4?=
 =?utf-8?B?Tjd0TlRMWFZwWmZQOXlVMTNQb01oaUFKaWFaUHl6NEJSd0VobFR6cndMU3dV?=
 =?utf-8?B?akZFUzNhSkp0MXh2c2cwaWVLcGE0ZzA1RVhPQmpMbVdSQy82WVR6bmRCc2pR?=
 =?utf-8?B?QUtjVlExMU5jK1RiYnlQMFEreXdrQXcvblF6c0xKbmlOY3dXOVg2VG9jQVRO?=
 =?utf-8?B?YlZ0T3poNG85ajFDckNMenZxYkcwREhHTXFOVkg3RmptaHhpVHpsQjRMRGNT?=
 =?utf-8?B?eWZEMitHNnllWEVDN3UrRFJoU0IzY1hHemlaNGp5c0dYdXdRTjFTbmpTUlRM?=
 =?utf-8?B?Nnd1dUpVZHlNQ3ZMOWhaTERxcFdmNGJLemlsQzhrSGg5MjZCbU1PRXZJZ25O?=
 =?utf-8?B?WnVVcDZnbzY1dVBBbVcvMGhZVFRLb2NGL2ltVGQ0OGdVQ0ZNU0tEdzBKMkNW?=
 =?utf-8?B?ajEvL2NhU1B4eHl6ZkVWbU9lV2plNW9jU3J3aXRRVEpPb3JQcmdkWUFoVWdC?=
 =?utf-8?B?NWRWUVp5UFN0MGx1NlMxMHZmOHEyejRJQXJkY3F1aE5kUEVRQml0bGpoMXF5?=
 =?utf-8?B?aU1XeHRYYzBmeS81TGgySzJlMDgvci8waWEvR000WS9pN25FUDlMOXVBbk5Q?=
 =?utf-8?B?ckhOSVpaYVYxOGtnamhFYzRPQXI2UzU5RThKT0JQMXk3T1JIRnRMSkZVMWUx?=
 =?utf-8?B?RjhGU3FsVmRLbTZpYVIxRnRSTUh5dk5PZDVHZWJZM1I2MTJLQjBvZkJpU0Nw?=
 =?utf-8?B?TDExOVMvRTJGWW55VzA5amgvSlVBd0Q5azNET0oyYWdqdnJ0b1M0U2VnSHhB?=
 =?utf-8?B?QmZMVGtSbEM5K001OU5Vb2VUeVZMVjNTQWpVWVU1aTNQdzhmOHR4ZW1GRmhh?=
 =?utf-8?B?SjRnQUYwUGh5NHFqczRaOUdvVTRBY2xNSVJtYTZ5UUpNc3pNbm9paWxjRjZs?=
 =?utf-8?B?NTUzQXBiVWxnTVNSRy91OVBoTHQ4M1BGWWtaOG42MkZ2bFJQcVhNbmdSWlhm?=
 =?utf-8?B?TnZ0MmZ1bWlpV0lnSmJzUGY3RlI3Ri9xeldGdHQrLy9KTzM1SUxTbndnamhy?=
 =?utf-8?Q?HPvYbHfjss+ZZJ85o77OTuV8S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9e18a0-f7e0-4e93-827c-08dc5e8fae9e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 03:37:18.6529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hys1ZUCPgaXx53vGdwclsSQ25EYFhS/Dwi7agCxY4+I1cHY/Xs5wxY1Z03Tmp3qJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6629
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



On 4/17/2024 12:05 AM, Ahmad Rehman wrote:
> In passthrough environment, the driver triggers the mode-1 reset on
> reload. The reset causes the core dump collection which is delayed task
> and prevents driver from unloading until it is completed. Since we do
> not need to collect data on "reset on reload" case, we can skip core
> dump collection.
> 
> Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 1 +
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1b2e177bc2d6..b4a41f075512 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5430,7 +5430,8 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>  
>  				vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
>  
> -				amdgpu_coredump(tmp_adev, vram_lost, reset_context);
> +				if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags))

In addition, use this flag earlier and avoid calling
"amdgpu_reset_reg_dumps" based on the flag.

Thanks,
Lijo

> +					amdgpu_coredump(tmp_adev, vram_lost, reset_context);
>  
>  				if (vram_lost) {
>  					DRM_INFO("VRAM is lost due to GPU reset!\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 6ea893ad9a36..c512f70b8272 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2481,6 +2481,7 @@ static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
>  
>  	/* Use a common context, just need to make sure full reset is done */
>  	set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
> +	set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
>  	r = amdgpu_do_asic_reset(&device_list, &reset_context);
>  
>  	if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> index 66125d43cf21..b11d190ece53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -32,6 +32,7 @@ enum AMDGPU_RESET_FLAGS {
>  
>  	AMDGPU_NEED_FULL_RESET = 0,
>  	AMDGPU_SKIP_HW_RESET = 1,
> +	AMDGPU_SKIP_COREDUMP = 2,
>  };
>  
>  struct amdgpu_reset_context {
