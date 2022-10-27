Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD80BC67871
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 06:31:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BF3C10E013;
	Thu, 27 Oct 2022 06:31:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44DE610E013
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 06:30:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gozITgJlhKGwZfl0Fr0POhKRvEtQz2a4hjWdAuX3XPMaNnW9ptrrkea9wJncYGN9M6XBg4Am3y7pDqbZpWYHdSr3A1EUbWFKFcOvHGlhgdbnL/JYYJ6YKtA/lHIUk1INcZkE9cwWPO643NAryzysjB8J7nzJeI9wfUmMoa3RsKy+76FGxM88AFcCZzknSsaime8WDC7U+JDPvaGSyGIMt9y5y3IDRucw5q1BNUCnuG+e9QktQGlpJxo1ECtJY+gd+FOY0QzTdSm8MlsOaGsyl+d2y2AbTSI0bsIsIE3cS5wQnU8JVS9V6O9xQ6pyW4P5jYfD3GsgmXCNVwjTWd/efQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1m03ge8xug9owfKR/dckt3GZ2KCyyX54Nqw7oJrFo5E=;
 b=gDELmKccilX5e08mdrHiORTCrTdwbTS9XZTaDfLeMMAPgVEMv7Qj2oA5XQdRB72goHSRMWpP2DEvblKvo533HeckmpZ51R0ZUtNpTC+CBhGpNYUkrdXrKTTFdD4R1YQtD+s9PlJs5P7vOy3ySdRyftLKBn8eWCabMnBfMP101MXu568SqnvhwYpWQGcf4lJ11lpaedMRUQeX1fd4Cv6S0sbSgQFrXkNEo70T6/hBnLk0bb7vSaj/9bxSgHO3LUAcXE0cXlyeQpfij3NrggtzElhGIoW5VbWuygS/3o5MuuJueKBPqn/R87Tt8jf4ONGl/seQliE+WvOe5E+ZUZ77tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1m03ge8xug9owfKR/dckt3GZ2KCyyX54Nqw7oJrFo5E=;
 b=O4YF1h2EeCLsv9/e7Mg9kCWOCTEn8Kf0mhMQqPuMIxmPeIGS69/sAqUMrzZQPjNWtkwWnnkvlUJpjqhCpX0+TfUHTCMt53JIBDLCfnr1RxSxIvrcWAyhVroq3ZM4aPLIlKd/YIG9/sJZDutCfu+o3plLGsNngca4bxcuiLHUkvg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 06:30:53 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a350:f29a:f287:7279]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a350:f29a:f287:7279%4]) with mapi id 15.20.5746.023; Thu, 27 Oct 2022
 06:30:53 +0000
Message-ID: <bd562d26-56cb-4b02-1fad-ba19eaac0b41@amd.com>
Date: Thu, 27 Oct 2022 08:30:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amd: Fail the suspend if resources can't be evicted
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <Alexander.Deucher@amd.com>
References: <20221026190355.18166-1-mario.limonciello@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221026190355.18166-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR08CA0036.eurprd08.prod.outlook.com
 (2603:10a6:20b:c0::24) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CH2PR12MB5001:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f392394-763f-4e4d-b285-08dab7e4cc3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xvjypBGUtAf6TQrYJ1mK/Gee8Y8hM5Td9smzk7D2XRwEX+jDaK6bf4IwyFZ5j01Qyb/Js8VjpLj8awdbZpyQKNNw7tSTGtiuO5hOg0ZDHVpIX7YhI1aDFnU0yjA4hqFPXBf8myEJ72HCBFkYTGmXguBh1GrhaV1EaLqFM+4qlrrKsHagx39DtIVDjHmwEMpG5uzPvaBmG1igyh6LzHo9Jnhvc0A0wQYByS9OzC32pYJ4m6fvrtQJ6rzrCiOkOvQxcs5ST3YzagjNfdu3yALTv7w2fuHH205PSXgg8UgVUpQpRIbQOKxWdPw9LH9G53cht2eb67jXxl3VS9nOJAGmFzNPMviCWPoPy1tl+77f7y1osU1JaAOpxIFk8GhfFbcSQfWQDop6XSysxwhpPNC9Y8ItKNGqbQ1yFgxGtUNdbuAUXuCJ3FOsLTYY1UhlOQ3rxJw4bFoqRRKrqW3wjGmzqdJYzo+19p6axDdYH3TF0h3fpR3ip6RY0CANKz+Xt9n3ejeiQK4wGOiEQ65EfJyfIeklQB6OvSRAzTihBGT9SbuqBPXU/1XRX1olP60zTAtpvU9nd2eWwkj7N/s0NxpjxsYy3gwXPmcXm1bEOTs2SJvSDP+F3JWsDEOnDcDNMQ/UXUYDQrCs8ZC1f47cuATX0NOsu2Q0fNNUauj+nValIzcBrGKllvgc0NrQqmtVlvfi7Sr6U5jB8bWfJGrkSbZEKPBfnMipCIWk9SQF54TONZ46726M76AJmi380vEeKN7I
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199015)(86362001)(31696002)(966005)(6486002)(478600001)(31686004)(316002)(110136005)(6636002)(6666004)(83380400001)(66946007)(15650500001)(186003)(36756003)(66556008)(66476007)(2906002)(6512007)(2616005)(26005)(6506007)(8676002)(4326008)(41300700001)(38100700002)(5660300002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTFRZ3dZTlZhd0V2am45Wk9xV3N2RkF4MGMwbEJGc2NjKy9KcDg1dGt2VjJl?=
 =?utf-8?B?ZEV2U3BPMWJKOURYdUdaVG8rN0ZWbzhtejhnc2JHTythdFJTN3ovWkdWNHVQ?=
 =?utf-8?B?YVJMbER1NnZCaUFoSjZtbk1MdFRmZ1lOb2dXNCtObi8yazNGdWdndElCUExn?=
 =?utf-8?B?UVZhbVF5M2JzRmNlY29oZW1INUs4ckVRSzB2SFgwQVJCbzh2aEx3VUxEQk9R?=
 =?utf-8?B?ZFBzNVlLOG9qV3hVMGoyQmRKQVpNVGI0ZUk3WmhJeEx0MUd6UTFqT0ZyeVBU?=
 =?utf-8?B?UGFzNlA3TllmNXBaRkFtVmVLelo0ck8xekxRbXpHbEFrUWtPUU85S3habU8w?=
 =?utf-8?B?MHZWeWpRTkdSMVphalNpdjAwMlhDMVBidkhIRWdaNDdCZUY2VVQ4SlA1M1Bw?=
 =?utf-8?B?ODBKclhZM2ZyNXF5ek5ybXpZb0NOM2NFVDQ2WjNwMWt0ZzRqKzFwa0RueVpr?=
 =?utf-8?B?VnMxQXFTY2sxMHFtclg5aDYrN0ZYV2l3WE5DSHZGMjAwU2FVMU9PZlowVnlx?=
 =?utf-8?B?K0JScWZ2ZzlsbmJQMmVTOW9KbVNPNWpLTmxiVElDZlJVak8wc0FUUVZ2YUlh?=
 =?utf-8?B?K3RDOEtkQVlPNDFERW1NOFo4VDRIdmFZaXNsM1UvK3p3WGIwQjZkeThuR0J6?=
 =?utf-8?B?U1pTaWNBaytKUW81NjBzdElBbzdjRHRyQUZiNktiT2I4elRwYzIrZ2xFYVpo?=
 =?utf-8?B?MnNKd2lmUTU5Y0tRbzFsQmhMMHUrQVB1c0d6RnZjTGlrUlppVXBxNmxNU0hV?=
 =?utf-8?B?M2tIV3dXSm1kVEo4SmpUVWtTejRwaC9RRE8vVmp0MUxORk1ZdjBPaEtwaXYy?=
 =?utf-8?B?N0N1M1JrVFJGaUh0UU9lb0hCVXBVb1RodFhNT2o1eklJem9YUHNVUUZxN0xY?=
 =?utf-8?B?Wnl3TmEvTWM5UzB0WFBic0piSGRqcGErZWY2SGFYTUhCZUhvUkVjVUxTT0hk?=
 =?utf-8?B?MVFHTlhSdUNBNkJKRWM2OSt2SGtPNG5CaEQ2V1pWRnl5d1U4UXNLc0J6cFcy?=
 =?utf-8?B?YVhxZjBiSGJUY0JiaSs3dXhPTnc4MHJDekhLN0x1L3J2U2pHKzJ6WGFFeWtv?=
 =?utf-8?B?WjBnTDJDUU1xdGM4VkpYL3JOUGg2V0Q0cnc5U0d5Y2FUNnZNUmladmlNcmt1?=
 =?utf-8?B?cHJFZ0lpNGx4QU11eklXUm1nZkRiZVNsdjd3VVFDU0NCcEFtaHJRKzR6OFBt?=
 =?utf-8?B?TWhQSEpOencrOFNKWTd0NElIQzRrQ083a1UvMU5oemsxc1RseHVRWEFnOUlX?=
 =?utf-8?B?dnJMYkR4VDJzYnRlZSsyRjRqS1dkdUttajZVdjBpcnNkK0lBNXNJVGhOT01H?=
 =?utf-8?B?VnBtOEUza3k4UVdrcGJRMnZ1UkU4dGZNNmYzdXo4Y1VIYlk5RnFlcmdDc0Vv?=
 =?utf-8?B?SC85ek5XV1BPbU5FRDNyeXFaSlBUNFE0MEh3cktTRU14L0FCS3ZjUGtLcDZ5?=
 =?utf-8?B?MkYyWVNXYlhJV2ExeGRiWWxMeW5acnRCVnY2RGNOSGZWenArRFB3UTZ6cEd4?=
 =?utf-8?B?bEdIYTdTTHExTGcwb1N4ajQ5d3UxMEk4RWM1NEp5dnBtZzh6UHZhR3lqNXJB?=
 =?utf-8?B?cUd1TGpzZjkzZ1VObzdNdDJ3UENaVnNYWHg1cTE4YnJ0SXo2dXJjNjA1YzI4?=
 =?utf-8?B?TStEZ21CZ2RiRkYyVndiT0JsdGZKWjdJWm1SWkVYMmZMbWU5aHNoNC9wcXdy?=
 =?utf-8?B?MkI3cUtDWS8vNGsvZGxQbFEzdlc2K0RidTAyck1YYkZqT1NKeXJnMG5ZOEh3?=
 =?utf-8?B?ZnhoVWkreTd2c0dSRUNOdy9tbTdUWmF0dzVwOGY4TWdxOEtnVjNsWUM4eEUz?=
 =?utf-8?B?eGtqZjBHTndvaE1aNHVTVk1PbDM5bmJ0elp4SjFESGVxNlpYR0RMNlU0L1JV?=
 =?utf-8?B?MEN3MUt1dGtXVkFQMHpQQnFJb3R6VHMvRExNajc1Q3VEd2hJN3YyVHYvVUVZ?=
 =?utf-8?B?OGhrbzdTOFZ1bzZQSVBMeVJiTWFPc3l1MlBvMGR2NmprZTJvRS9sUWZsVlZv?=
 =?utf-8?B?dU0vSnhtY1pwSUlnbkFlVGpTOVhyOHArTkd4ZWp2WEF4c0pWSmNsUkQvclB5?=
 =?utf-8?B?SWhwL1lNMy9zcnZBbnZKYWthWUhlUFVCaU5udUU3YVJPYkl1V2tYbm14Qlgr?=
 =?utf-8?Q?116yEaBydAuqnHqxMWoY+oA7S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f392394-763f-4e4d-b285-08dab7e4cc3c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 06:30:53.7521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGWvx6r3063u8j1B9Lgxa0SuDsOUxudCzMH4XfI+Amskvkn7x4ESQdemvdkq2ROa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5001
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
Cc: post@davidak.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.10.22 um 21:03 schrieb Mario Limonciello:
> If a system does not have swap and memory is under 100% usage,
> amdgpu will fail to evict resources.  Currently the suspend
> carries on proceeding to reset the GPU:
>
> ```
> [drm] evicting device resources failed
> [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of IP block <vcn_v3_0> failed -12
> [drm] free PSP TMR buffer
> [TTM] Failed allocating page table
> [drm] evicting device resources failed
> amdgpu 0000:03:00.0: amdgpu: MODE1 reset
> amdgpu 0000:03:00.0: amdgpu: GPU mode1 reset
> amdgpu 0000:03:00.0: amdgpu: GPU smu mode1 reset
> ```
>
> At this point if the suspend actually succeeded I think that amdgpu
> would have recovered because the GPU would have power cut off and
> restored.  However the kernel fails to continue the suspend from the
> memory pressure and amdgpu fails to run the "resume" from the aborted
> suspend.
>
> ```
> ACPI: PM: Preparing to enter system sleep state S3
> SLUB: Unable to allocate memory on node -1, gfp=0xdc0(GFP_KERNEL|__GFP_ZERO)
>    cache: Acpi-State, object size: 80, buffer size: 80, default order: 0, min order: 0
>    node 0: slabs: 22, objs: 1122, free: 0
> ACPI Error: AE_NO_MEMORY, Could not update object reference count (20210730/utdelete-651)
>
> [drm:psp_hw_start [amdgpu]] *ERROR* PSP load kdb failed!
> [drm:psp_resume [amdgpu]] *ERROR* PSP resume failed
> [drm:amdgpu_device_fw_loading [amdgpu]] *ERROR* resume of IP block <psp> failed -62
> amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_resume failed (-62).
> PM: dpm_run_callback(): pci_pm_resume+0x0/0x100 returns -62
> amdgpu 0000:03:00.0: PM: failed to resume async: error -62
> ```
>
> To avoid this series of unfortunate events, fail amdgpu's suspend
> when the memory eviction fails.  This will let the system gracefully
> recover and the user can try suspend again when the memory pressure
> is relieved.

Yeah, I've been thinking about that handling for a while now as well.

Failing to suspend when we are OOM is certainly the right thing to do 
from a technical perspective.

But it also means that when users close their laptop it can happen that 
it keeps running and draining the battery.

On the other hand when you don't have swap configured it's your fault 
and not the drivers.

It's a trade off and I'm not sure what's better. Alex any comment here?

Thanks,
Christian.

>
> Reported-by: post@davidak.de
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2223
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 6f958603c8cc2..ae10acede495e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4060,15 +4060,18 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>    * at suspend time.
>    *
>    */
> -static void amdgpu_device_evict_resources(struct amdgpu_device *adev)
> +static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
>   {
> +	int ret;
> +
>   	/* No need to evict vram on APUs for suspend to ram or s2idle */
>   	if ((adev->in_s3 || adev->in_s0ix) && (adev->flags & AMD_IS_APU))
> -		return;
> +		return 0;
>   
> -	if (amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM))
> +	ret = amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM);
> +	if (ret)
>   		DRM_WARN("evicting device resources failed\n");
> -
> +	return ret;
>   }
>   
>   /*
> @@ -4118,7 +4121,9 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>   	if (!adev->in_s0ix)
>   		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
>   
> -	amdgpu_device_evict_resources(adev);
> +	r = amdgpu_device_evict_resources(adev);
> +	if (r)
> +		return r;
>   
>   	amdgpu_fence_driver_hw_fini(adev);
>   

