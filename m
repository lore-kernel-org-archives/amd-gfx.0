Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E68AC77B73
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 08:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16BF010E491;
	Wed, 31 May 2023 08:33:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3242A896E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 08:33:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/TP7WdIWurSJhnOz5D6Ww5ltcyQZOuHb2Tz470u7mTVASdi0XeV64G6FTQend1+P6xIPzIcBlleRBMUVt5xxxeI+mKFqFISf9oturoaIQ3al1igPleTd+Yos2FMn8Tn+baejMpzxlru3h0M7xtXql00y2u8co7c9zl4jozMGmnV4tTLlN012L/UjYkTldp6CQMSlzEy8HtXxmY8vdY4V//WMRiu1E9OdpguAQ2EIWK47JJ4M/0C2gAsb03QxUK7Yh0T915PKdz067LxexrEsaolUv0Ilysl9n3VIqSOS5z7peYJsGgP0YaRs3iba1xiRp6xoBUX5WjlRtvf4VtWkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUncqMuAbch+NxBBPMx4/lGwNl7PIeclkiHSFrKFeOo=;
 b=nu2+8jWKfH4EIy/tFONsgKaf4nN83PIGSR/TuxfDfpS4aTHL3TIiKf0d6jf0ayhfofFi5QoiMh3rndAicGfVQ8wiIscu65spXRYVV6TCEiH5gowIcuKgRxPbsKit0Pd4vtem+3yN4/XOH5+pkjoWwNOr3ykC92jzFFZRnsIwN+dy6uzzs6rvWft43T1Kqy7bnAgOp9D59T0NK+smGUIBY9kf3XCJNe9EOtBGXcAJ2IchurN/wzkkEyBplVZqC7JgPwgAG679S2kBR2PCRXpvOS5p+rZwAcieMpQqkuKTfUB4S9wlRaZkiSHGxkW+7/hiMYUwrl4spoWhRep9OOHLSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUncqMuAbch+NxBBPMx4/lGwNl7PIeclkiHSFrKFeOo=;
 b=D0t2NSjcldHhJgflMKjfoAVY8F4VKeMPGCDeROIXMjNzeELOFzPDApE0XySSvskituI/6Wdu6HU8vpOmHTML/HW3/WuwOVfdS80ZGkJOEykEuezWA3MtkCyThhemRbpaStR1usggEvM7HDsFikDgkZhruAURwQPtZzIai2nkJP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH0PR12MB5450.namprd12.prod.outlook.com (2603:10b6:510:e8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 08:33:23 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::907f:26e2:673a:2ad2]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::907f:26e2:673a:2ad2%6]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 08:33:23 +0000
Message-ID: <265df874-9732-fca8-f66f-efc28140f43f@amd.com>
Date: Wed, 31 May 2023 10:33:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: skip force complete fences when ring is
 uninitialized
Content-Language: en-US
To: Bob Zhou <bob.zhou@amd.com>, amd-gfx@lists.freedesktop.org,
 Frank.Min@amd.com
References: <20230531044812.460358-1-bob.zhou@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230531044812.460358-1-bob.zhou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::9) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH0PR12MB5450:EE_
X-MS-Office365-Filtering-Correlation-Id: 701bcd39-737f-4d9d-7f3a-08db61b1b23d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EGaYIqrrdKNZjwrIpg+0Rm0n/aW0lokKu775TJ367wJbV8ZxBEe2jEhzfRb4zaIIeCbzgtBPY+z0HMtdsFQzXXRcOBUT40pSicc5C+tGjxSZQxO9FXLJ8KCHEWFzBN1ltiBcyM4O7qDbAkB1m+A/zBOJ2E5++AlGeN7xFT0HqkATwNALR5Ahk9HZ18Jhw0FBeAooh2wFjCRQc/Nzfob78FBYx3BIdnifzBTaCOEiorLsCry+14kxVmRcXlBv+I37eFo39tNLxIuLxuvlpOqD/i8P0wqlWch2qz0R//UOBKtVWFwgL3Q7bb2YbPyGQhY/2apu1JECQInvp9rYv/dUGs3060L9EMWu9iGfKsrJyfUzeIw8TCRmTaXaYykc3iXGTA4IXfpgT8y0S2elVq9oxFdm4c+BfKIYjmpJ2TvOXe79THo0phh91CUg0hoTZ5yzDnmUk3xbFxmh9T7zyZCyfAk1v6FhUybD21f1pWyOjs8ILcpjUfVlPAatSksYKviPdkUIhOGbkZTwEFy1SV5I+NxABG/GhQUJ7FMmDtID1LeQuPiGAbNrmRq6Vh8loVx9uTYD9BO6y21eNrKvNG2Stbf8T2zEnNPqJKuAy/2wpMT9PvgL+sYmwZ8OIqNDUC3HQ7byYALTKoiUpZPUxpgCYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199021)(186003)(2616005)(38100700002)(41300700001)(31686004)(83380400001)(6506007)(6512007)(6666004)(6486002)(478600001)(6636002)(66556008)(66946007)(66476007)(4326008)(316002)(5660300002)(31696002)(8936002)(8676002)(2906002)(86362001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzRHL3U1V0haUlVqS2IwQTdONXVkcVhDWUdRcElxOWJLc0gvU1Nxd0FYY3JW?=
 =?utf-8?B?VXAzRWJpbnB5RHB3MzhNY2ZNTnRsR0VtQzhETFJEazR0c2t1ZncyQW94UjU4?=
 =?utf-8?B?M3Zndzd2cXlsRmpPU2l2anRsNWpvL1M1azNLRzNoMjlackhoTUo4WU1Ed2t6?=
 =?utf-8?B?c2I2b1J3TFR2ZlVKdUd3bzZ2SjdaY2I5dG05bTdUdmRBWU84cFEyRGNLM2NI?=
 =?utf-8?B?OFlDV0Z4ckpzZW4vQ2RucU1JWmtBdEEzZWlpSkZmRkRZZytOdlphSEFrejFY?=
 =?utf-8?B?dFR0c0prWXg2dWxOL0NOK1RUMFUweEIxSHN6UEZEWXhIb2hUbmcwYTNBcDI3?=
 =?utf-8?B?T0tpQjcrQTdtRS80emRUNTBDbVZCRFIxRm5EMCtNRnY4Q0kyckVJSXpSNlRC?=
 =?utf-8?B?Q2RJZEFpdVBVcmlQSGxXWlcwWVJ2a3BaRDVwY2xNZ2libHpyOEVYTzV5Z1M2?=
 =?utf-8?B?RVNCN0hVM2dadTJEeUxlalFYMHVoajNrYm81SUFuREtreVR4VldmMzRLMytK?=
 =?utf-8?B?NVo3MHF0WS9EejZ2elM4SjlCekFQZXFDKzc2RDNmcmpOWTd0K2djbVMxZlJk?=
 =?utf-8?B?d3RjZlRrTFpyTng3eEM5RjFGM3pEaGpEK3dIcW9ZMmsvODQyS3RKMk9ubzBs?=
 =?utf-8?B?WmNoc3Qwa1o4cmp5dkZjaE4rcktieURKQ2VKLyt2V3NYT2RtalJQV2EzU253?=
 =?utf-8?B?dXRnT0htNis1eU10Z0oveldOdzRxajhJY2dQWHlueXZuMWZkcWhhUWVJUXFD?=
 =?utf-8?B?cDNrQzVSYnhJWTFFSmI5ZUplUEZRbzcwcVZhaXBhTnNxaHBjQlduMUE2UGU3?=
 =?utf-8?B?YmpSZkJWb0ViRUZtdi9pb0hWRjByd25UTHc4THIyYVNFSnJ0anYrcitmS0Y1?=
 =?utf-8?B?VFQ1K0Znd0JUWWNrRlZpV1UySUVubDBiaE12dGppZnA5OFlBYk9xWGpzaTla?=
 =?utf-8?B?TGJLSzZsbzNsY2xpK003YXN5cG1tVnNmWFFieHg3OGN3WXFKN3lGMXZLZVJR?=
 =?utf-8?B?M0wvYXpRSGh0Q1N2eWdGQ29FTFdWN3VIWFNFRmo5ekowazc4QXpLUWoxNkJs?=
 =?utf-8?B?NFVFQ2d5SHJkSzhVYnpub3VDUGtZS2s5eTI0Znk3UHN2OFRMK2NRMkhTMFdo?=
 =?utf-8?B?K0grWjh0Z2F4MzFpMXRKeTZERWh0WnB2RWVpd1BneW0yM0xBL0M5OUVEKy9M?=
 =?utf-8?B?STdLR2k1TDhrQ04xY2UxZXUyLzNPRWkyMElLUFBkcUhna0tDeDdpZE1DQld1?=
 =?utf-8?B?RGZUcUdodWc1SVVNQThWUzU1WTFrSjdpam9DTXBGSnQzMU9OK2tGUXdTVGVv?=
 =?utf-8?B?eFF6TlZrN21RLzA4dWtTcjhlMGRuc1g4Wlk3L3VKOUVQWlVlalRFOXduUE5v?=
 =?utf-8?B?R081YmsxbkNRaTJGYUYzdzl6dVRzQXVEZHZZSGhSZUtUd2JrbzQ5bmtockh5?=
 =?utf-8?B?VlJwc2JoNVdTME5nUzlXNDE2cm1DRDdmKy8rdU9rTWtVdkVDOFBxM3VWTDFX?=
 =?utf-8?B?ZHNpcWRlMHpVeDVZTTc0QnJkbWtOVU5PbnZSRUdDZzR4Tk12U2Z1d3JqanRa?=
 =?utf-8?B?c1FuK0lYS0hwa3Zpdi9rZlBoYjhaUkVIZ0V0VEhxeVhpcWxGNWw2VHk1UUlZ?=
 =?utf-8?B?Zi9SaklZS0ZUaGtBekNFTjJpNGNrNWsrSWltS0grb2E2cVJxbjIwU2xGS2RX?=
 =?utf-8?B?UjRQZmM2R0c5dXJ3eGM0YjhtUFlsOVBUYjZMclc5K00zNTNsMldnNVF5TEsz?=
 =?utf-8?B?MUJKMkZ6V1RMbnZIeGFkeHJJcU5tS3hRQjh4KzZINmw0d2NSZGgvaURVR2xo?=
 =?utf-8?B?YjRKL3ZLeHhEeVFwdHpVSDJuQ2pNKy9raU1pbHpyRXc2NGlCT1B4K0FDUXNN?=
 =?utf-8?B?SHoxNXRtNktqeTlFNFdlTzV3TG0rR2QzOWdyQU5RMGptZDExVHBSMTM1ZlZM?=
 =?utf-8?B?NTQwTDJWTjdDclhCZ2ppZEhFazdTZ0FjbUpjM1UwcnNVM1ArQ3NlU0Z5YjBx?=
 =?utf-8?B?Z2crVUxTL0hOcVNsV3ZEUDNtc3p6enBGMjRURE5VVlVuQzd0TmdoS1F1YmRE?=
 =?utf-8?B?a0Npd3ZWWUpZU3FVTVIrQWtLK0hOeVNaTForN1NDMEEwVTEzTzUvN09mS3h2?=
 =?utf-8?B?TVhkL2VzeU9adjNrb0tFV3FnYmZiV0dSK3FIcFFKUVNpQW1OU0dWS3NkVC9M?=
 =?utf-8?Q?dLbplLhN0/UoE82eDTvnyU+C7+emv5veaID807detXXa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 701bcd39-737f-4d9d-7f3a-08db61b1b23d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 08:33:23.3448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjCQDsBxFbKuciE3WDhkdNNWIUIlD8zgFT7Bqoi+N/NEZua2i/dIQtyed7wBS9Fp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5450
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 31.05.23 um 06:48 schrieb Bob Zhou:
> uvd ring in uvd_v7_0_sw_init only initializes ring in bare metal case,
> so when executing amdgpu_uvd_resume to restore fence seq in SRIOV,
> a null pointer dereference will occur. This patch correct this.

Ah! I was already wondering how this bug reports came to be.

In this case please fix the UVD code to not call 
amdgpu_fence_driver_force_completion() in the first place instead of 
hacking around that in the fence code.

Regards,
Christian.

>
> Fixes: 043f2271e2d0a ("drm/amdgpu: mark force completed fences with -ECANCELED")
>
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> Oops: 0000 [#1] PREEMPT SMP PTI
> RIP: 0010:amdgpu_fence_driver_set_error+0x3f/0xc0 [amdgpu]
> Call Trace:
>   <TASK>
>   amdgpu_fence_driver_force_completion+0x18/0x50 [amdgpu]
>   amdgpu_uvd_resume+0x1b2/0x380 [amdgpu]
>   ? amdgpu_ring_init+0x73c/0x820 [amdgpu]
>   uvd_v7_0_sw_init+0x358/0x450 [amdgpu]
>   amdgpu_device_init.cold+0x198c/0x1fdf [amdgpu]
>   ? pci_bus_read_config_byte+0x40/0x80
>   ? pci_read_config_byte+0x27/0x50
>   amdgpu_driver_load_kms+0x1a/0x160 [amdgpu]
>   amdgpu_pci_probe+0x186/0x3c0 [amdgpu]
>
> Signed-off-by: Bob Zhou <bob.zhou@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index c694b41f6461..d2c5484309a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -723,6 +723,8 @@ void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error)
>    */
>   void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
>   {
> +	if (ring->fence_drv.irq_src)
> +		return;
>   	amdgpu_fence_driver_set_error(ring, -ECANCELED);
>   	amdgpu_fence_write(ring, ring->fence_drv.sync_seq);
>   	amdgpu_fence_process(ring);

