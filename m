Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36D5EB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jun 2023 12:00:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B49D610E46A;
	Fri, 30 Jun 2023 12:00:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D206C10E47C
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 12:00:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUET4Cg6l+TXU7PWbP8J626vL08Sa41xgC1iyE2a/pOH1gmdiguPxKa4mWlFmDVo5ZBu7MK6vK1J69SLiHMeBzvUMc73OrZiDxOUnYV/egp1ZI21yVqXscQfydO+MBlqMw1D85INUOvtXIV/KuldKcVP5eO6XFpUr2edkFjXuvSnS0EQgT/ybpW4A5h+zDILpZfXH+ZAPg2KQ6KLm1TokQQwE5C7jVv35JLhT1VXGMmR/qhjKgLAtkUYdg7RTuyg/tJnNTIOQhXRmaboaTMUiXKDcevzJNc83ptqPW8HB3nwQYqiFmZZIcNQUwPGdtblET5dYOhK+T5NFlw4a3pgsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ax0eccQNsx9hGcsrRmInLFT7tNTaRGC73Ixwku8oNo=;
 b=auQeB6TJEm6+ACdCYSItEt/dJUOoieyxmpQjGe/xYqJA1klDCbkNFhwl4arF3oYtcYcgxZDDedl8Vx0FX6YbnZzIWiAEMEDO5MEksrDXCxwB7UwghsboLF2u39BJ42W+njFjDn+1qHB6f86Tg+zDBZbUQcjsfjoF3HLrqY4Eb/pEvudDLqALuwH3JNd5utwUk47t09Nma3JMpG5iy4ho9H7M4iWCCkSTWpTYYInOJXZ28/S8/iTJBxnBlM5HXuCAcqbKPtPmwratjJkUOjebnAWmqAUSHl/iT/zyTqWOyVCO9aH671Xj6cSPn7smDm8cvmYBTc9TqAEL6FyodHk07A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ax0eccQNsx9hGcsrRmInLFT7tNTaRGC73Ixwku8oNo=;
 b=aF1VTVv/W3kFZC+4UoAoqvPFnWCpneMj2PJIOBtrQUV68TWGPt/3DxgW5ub4Lnzs3CQtgjQ0hhNngoj8oa79fckpLU9trYypI9eiKOT+dQCUJv5XHtEvnbO6vVtB6XiEcEXY4JJDkMY25yeqkv6Vnb0/2g7TBH7WMGLQVa05dyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW6PR12MB8960.namprd12.prod.outlook.com (2603:10b6:303:23e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 30 Jun
 2023 12:00:02 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84%7]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 12:00:02 +0000
Message-ID: <516512b4-c24d-c042-cd31-1266fc8cf8d8@amd.com>
Date: Fri, 30 Jun 2023 13:59:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/6] drm/amdgpu: Fix warnings in gfxhub_ v1_0, v1_2.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230630115618.2855618-1-srinivasan.shanmugam@amd.com>
 <20230630115618.2855618-2-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230630115618.2855618-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::7) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MW6PR12MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f9ff7c8-c210-44a8-308b-08db79618907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kf8rUqo4ZOHYHaubjZrYXp3/DiU+GN5INGvMl+43ot47wHPIhnZaCag02di53uvcaK6ULwU56ypckkhvBxWeHq4NDnciQZUlc2v3A9DW4PX9Fd/TXS/mXXa3GTm34v9PSiKU0u6f6XRceO1uKGMgMaWtVlrk3JAaB1YnuFmUdZS4gbO7l17QPDglvqSHz6a1A1WKYV3E79y+6edyTCFkPZVv9px4dMnwWxIiKMHKWou88hbr1WRWNCowK0Q+B/tULceY1fr0U3xSxRzUkzbyz9quvYguo1jZUc5NB2gF7wsJCHcyrz8aH8LscGTpJ8vtLQbvNI3UR3vtq0tjpIgsgczVIY4ldRMyY8yMwLAlCfzt6LrCDyn3Usl381bNzI2XUxkZsFqtmczFJPk9jfOGt95UQxlliVJp47PGI6uBZgzWksQGIYfsUGHCKE/6ou7bM7Bg/88r3bufJ8N7ul5tz40i3d2ZyPwGnI+D+hdt8vY0PNg/qOAzPyRwzJQkBIQd+ixFQLgBAsMZc/1ZhjnvVyZ2JGUhMPf2fTGmK0/jqHSTBdIAVDIYte10MCW7KZKPABl90zkiIvz0ZvbwJBTV04FtYUfLpaOrzeoQXB0z3LLZLJaEHdVOQV1Da92Qi+jF99MkHbNnf1DM/e5+IWZyeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199021)(478600001)(38100700002)(83380400001)(66574015)(36756003)(31696002)(31686004)(86362001)(110136005)(2616005)(6486002)(6666004)(8936002)(66556008)(316002)(8676002)(66946007)(4326008)(6512007)(6636002)(186003)(41300700001)(6506007)(66476007)(5660300002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wmh2a1RoL1QxS0pSeXNlNUgxditDQitLSGpseWw3am5FQ0JjV1pXUWUvcHZ6?=
 =?utf-8?B?ZUwrcXZkbXd0RENIWUFlQVhMTUpXOFo5VFNHcFh0bDJkMWZqN3JUc2VidWhN?=
 =?utf-8?B?UGc3dm9lcWptODI3ZjEzQlI0cjZ0eE5pMHZ3S0MwK0xKNmdlOVBvcVgxQ0po?=
 =?utf-8?B?ZHlQOHBjci9tdUVSNVVzU1FtNS8xOGU2VGZKZG9PZitHdmtqZnJSVTJFcUtK?=
 =?utf-8?B?NnhUWTg4MGdiRlBmRUI3RWR0enIzT0syUmRwVWluanJnMFNEMjlIYWc4bnh5?=
 =?utf-8?B?Y2RXMFk0VmFsRG41N3pDV1pjajNHeS85RUlLSFE3eko0UzN6VWEyRW9UQ3pO?=
 =?utf-8?B?UktZaVRaTG8wS1U2b2R2R2p3WGtUbFVLUmtqWWlqL2VDQSt3dUcrMzV1NzA3?=
 =?utf-8?B?Nys0YnZOaXdBNDQwRm1McklIeUhpYVBrckhTN2JHbURidHZubk82TmpCaEM1?=
 =?utf-8?B?anhtVjA4aDZ6azJxTE4xU3VOMVMzK0kzejVvUUNTajgxdHc2TzFzMFZWTlNX?=
 =?utf-8?B?WWU3Lzk4VnJDQmhtdFZQczlwamwyQlQ1dUo2MmcyMEhhRVI2ZXlQdU1na0l3?=
 =?utf-8?B?VzFLbWFwQWVSY3Q5blRvYjhCOXN5Um8rZy9TNGJGOVZPTUp4d3JXNlJUNWdJ?=
 =?utf-8?B?L2FleWVkWHVmSzE5QjVySjljY1lUYk9ycXV2YlZTQlBsR1R5TU9hK3duYVVk?=
 =?utf-8?B?a1k1eDBqRFJTRlNVSklBWlV1SytERjRUdnFGL3poNUluWTJ6TUpWZFFWV1hD?=
 =?utf-8?B?RXpCdG5oTHNSd0x5ajJvWnpnK0ZGS2hCS3RaTGcycTcwU2p3a3pSNHFrRUNS?=
 =?utf-8?B?TDhZbjhrR3c4SkNwNFZ3dGFaVXdRZ0F0OHp2RUV2T1FYUnhRVmtCOU8yY012?=
 =?utf-8?B?VkNKR3BuOExEdWl2TExVRU9mVlN2T0hXQ0ZyVTVnNEo1V21mQSt0TXhqaHRY?=
 =?utf-8?B?QnlaeFZweU5vNlRMZ0g0RzhXMjlBUDh2MWZNWFFWVjNMTmtRc0IwdTVyVFZW?=
 =?utf-8?B?a0JNdUVLTjZYT2RyK0loZ2R5Nm1XS3ZzV1JtWVJja0RxMnZUaEFaeFBRYzVL?=
 =?utf-8?B?SGkyaThScmVvRkFHRExrTTVvZDZFY2FQYnBBNExoN2ZZL25waHlkRjBkcHpz?=
 =?utf-8?B?NHZGb2NCNGlpYVl3TTNyZXlLcExaQzBucUYzZ1BkckVuNFZsd05xREJSeitD?=
 =?utf-8?B?dWxOdmROeFlSZVJvdWpIUWxkMXZ4eWE4RnVKbUM5blY0QWdSWDY1c3lYdWR4?=
 =?utf-8?B?S3JMOWZjYjRNalBhaVIzZXJjN2tjOEF2djhPTDkveml4YjhOd0dWMkdOUmJo?=
 =?utf-8?B?cjBzM2RHSGR5N1pHcGlLazBsRDlscTBNK0J2MllHWGdydUNNMzNqTXdpdzNw?=
 =?utf-8?B?bW9aV2YwRG5TdDdEaUR6bFVqVGNVQ2c2dG52bnRNRE9oOFdrQ2JhVk5kVDRE?=
 =?utf-8?B?aUViVURiVWdRMC8xTmg2bHRNa2RLK0RCOC9GbXZLZXRUZFFTTXZBbTRIbHRP?=
 =?utf-8?B?V3kyUkxFS29iNHNMNVhYSlF5YW9nU005LzNJQk5nLzdieHNseFhRb3EyanUy?=
 =?utf-8?B?ZEE4dm90ZkMvVzUvUGpHdDd5ckwveC95QVl1V1pVOXBEUFMwajhsSVpGTVpD?=
 =?utf-8?B?ckNvUFV3cU13eWprdS9jQnFHWlJRNTFWMlFTbldnaGVPWmFhQUpqbVp5RklB?=
 =?utf-8?B?TjBXeUVFc0ZSOW9mN3puWmZHY2g2Uk1NTTFTT3owZUFobTkvcEQycUtwWGdX?=
 =?utf-8?B?djlOWHhYeDAycDIvL20vMHg5aWpRblQzOEtBRHg2dEt0aFRmQ0VYL2Z3WEti?=
 =?utf-8?B?WHR6TVZMZmlmenN0WlZweHB1MGhENCtPWnVLRTduNHJtN3hSS2xjTlhjSDZ6?=
 =?utf-8?B?amZkOVhrQitLUHkyTU0rMGJSbmZBWkcwbHlURXBQM0kwelFiOW1SbzdNYktu?=
 =?utf-8?B?VTIyTWRWNlVUbFRDVkEzaEN1OW5QangyWVM2TG9ndU1CMWFZaEI1Zlkyemdy?=
 =?utf-8?B?MzhVTHN6ZDRZUDZ6YzNtWmtZbzZHejE5aTBsQk1BOHhUbWNubm91MEpSMmJi?=
 =?utf-8?B?MFhMZmVzSVRZNU40cVdmUnJPZTdPUTJlbDNwSEZyY2kxMlpPQzNEMjF0aGk2?=
 =?utf-8?B?OGdYUXhKSXZ0WjAydDNsWmVVTUE0SjdpRzI0NDVWTkdJQjh4UVY2clovQlE0?=
 =?utf-8?Q?bYpHxBJPviMP2Y+cA/zueRYRL9XMaLwo3iCkot7hwKuk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9ff7c8-c210-44a8-308b-08db79618907
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 12:00:02.2543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2trnQlpeL5JgwAPomv8uwh+9LIh21Yff2WwldhN7AGtmrxo+jyFwLYWe1DAKfTJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8960
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 30.06.23 um 13:56 schrieb Srinivasan Shanmugam:
> Fix the below checkpatch warnings:
>
> WARNING: Block comments should align the * on each line
> +                       /*
> +                       * Raven2 has a HW issue that it is unable to use the
>
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> +       unsigned num_level, block_size;
>
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> +       unsigned i;
>
> WARNING: Missing a blank line after declarations
> +       u32 tmp;
> +       tmp = RREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL);
>
> WARNING: Block comments should align the * on each line
> +                               /*
> +                               * Raven2 has a HW issue that it is unable to use the
>
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> +       unsigned num_level, block_size;
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Acked-by: Christian König <christian.koenig@amd.com> for the series.

> ---
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 7 ++++---
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 4 ++--
>   2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> index d94cc1ec7242..cdc290a474a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> @@ -103,7 +103,7 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
>   			min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
>   
>   		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
> -			/*
> +		       /*
>   			* Raven2 has a HW issue that it is unable to use the
>   			* vram which is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR.
>   			* So here is the workaround that increase system
> @@ -248,7 +248,7 @@ static void gfxhub_v1_0_disable_identity_aperture(struct amdgpu_device *adev)
>   static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
> -	unsigned num_level, block_size;
> +	unsigned int num_level, block_size;
>   	uint32_t tmp;
>   	int i;
>   
> @@ -308,7 +308,7 @@ static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
>   static void gfxhub_v1_0_program_invalidation(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
> -	unsigned i;
> +	unsigned int i;
>   
>   	for (i = 0 ; i < 18; ++i) {
>   		WREG32_SOC15_OFFSET(GC, 0, mmVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
> @@ -375,6 +375,7 @@ static void gfxhub_v1_0_set_fault_enable_default(struct amdgpu_device *adev,
>   						 bool value)
>   {
>   	u32 tmp;
> +
>   	tmp = RREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL);
>   	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
>   			RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> index 4dabf910334b..47f95ec218a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> @@ -140,7 +140,7 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct amdgpu_device *adev,
>   				min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
>   
>   			if (adev->apu_flags & AMD_APU_IS_RAVEN2)
> -				/*
> +			       /*
>   				* Raven2 has a HW issue that it is unable to use the
>   				* vram which is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR.
>   				* So here is the workaround that increase system
> @@ -315,7 +315,7 @@ static void gfxhub_v1_2_xcc_setup_vmid_config(struct amdgpu_device *adev,
>   					      uint32_t xcc_mask)
>   {
>   	struct amdgpu_vmhub *hub;
> -	unsigned num_level, block_size;
> +	unsigned int num_level, block_size;
>   	uint32_t tmp;
>   	int i, j;
>   

