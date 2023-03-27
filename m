Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3BEC6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F81B10E400;
	Mon, 27 Mar 2023 19:00:28 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56B6B10E400
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:00:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAme0CZnSDRVB/V6HzuFnqmCWPpcw2OCzBVtFZNHxNUMzmeOM+l2jjpva5nQ/UYLaje1j11ShPU2bfKzSL3KuwxDkegpe9Z087gKk2i6BLvCKJXyMTw631apURjHt6KOM45Uo387/O08RFyLcEYen2pXov46Dc2Fcz2QD4w+wCrHXLuMnAQdQXfrYDTatSqsXW3syiK7biCENmA0SR6Ix18DWRvLekJpYHDrBOovasrA3Sm5+8qs800umQ4gSncbsQA5Mv1GZz7ui+IeB+asKvcdZmBHFB+byf9PSiN1kIF+2CsM3KPT88ua2lzEeDg+q6A7lQob6digNjITmymahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHTxiuQefPZ3+5oSC1t6RPvXPBpfxcQxkDgJUT6Bhzw=;
 b=og8g67q/xDlTv/VBTCLq+irpkSdz7TfMfqCSfEjT0//rR2CDrwsYUY2b2lNBJYdzskxBb5z+Sb6vHRs+HIm6T8oTAD62JtCUAR+P59gN5xP+kjAbPM3nb/XcROV7qp6Q2S/7Flm28NlHGzFgCyMw08P+NvZ8wh+mCJDOrjxYYQEUX0UUMSY/NoYj98arHsrfDnGNxn7l7o1BLUD+SxTDjot3+LgWAL3sUYBZaKEiHHZWnWFJC/QHKywZyaSsI+l6L0FNVaiH0upn/2x0q2eFyEF+ZHjD7FNnEyAjdCk3uoCr8FMul2SNqZ4ArTqqgCYkjQv6VnPGrvpKO2yDaaKl5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHTxiuQefPZ3+5oSC1t6RPvXPBpfxcQxkDgJUT6Bhzw=;
 b=SvTmroYGSwWqZaf1jtwTPBlW4QmYh9igDUyuQm86tpOIfkKXetHL0KjP/znsKlPiEwKiOvywooUgEPLmXf2pfIoimCBnbYtbZjgVr4iSxw/qOdJ+GtcL2zlULrZB9433zuOi1OTPxV7/P2pdbSk8QhYHKd//alqQyj/GoUyr00Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.30; Mon, 27 Mar 2023 19:00:24 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::b877:9974:5a14:cc37]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::b877:9974:5a14:cc37%4]) with mapi id 15.20.6222.028; Mon, 27 Mar 2023
 19:00:24 +0000
Message-ID: <aff27f2a-a878-be69-fb06-74f2063997f9@amd.com>
Date: Mon, 27 Mar 2023 15:00:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To: Alan Liu <HaoPing.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230327152028.2939908-1-HaoPing.Liu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix desktop freezed after gpu-reset
In-Reply-To: <20230327152028.2939908-1-HaoPing.Liu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::16) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|MW6PR12MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: 79adcdd6-9f74-41c9-e63f-08db2ef58559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jc/QkthXRHEqxcGfHsItLc4ptBTGREMDmbTraMvmAl6bG7HzmYkTmgmMJh+uXzwqwxxbnLCCRWV9rmSskmH6tCMxHaQyUY9fO17ysrW969n/vbkdUDGh276r1A4HnBVzmZY4bVOIeZgs32/3U9QgWXb9j8KhpqTPnKyUiSoEW8TCjGwj4aAo8BlIYrB3U0BCOXl1uamfwmcfv2NcJCbj9HrGMOzjPrlWcgrW61v3T99NO3oKRKXEYbXG2Twf16GEBgSFl0glxnKw3PFhdkk1tkzg+WH33aKGsWxM7LRvFVWGLvZ4FcVsg+dpyeD1ezpXmhNBzjqVb3sc5xQc8GqJJB8TbteqiAzT+q6aA19kBBwlppwZuj3hT2uf330mUV8Sapn3Y/3DFPGNgacLVQ3KTfgNiwEjGj5MKtGKWa0F+Bx/LLiiU9zJboV5SfPI0WFVg0Ane5lPa8dCooNetS5g16oAkzfOufHuvRzLXsdamRyT/pDNyJkww0kFbtpXi7wb5/ib6h5kuDHirCf2vsLfZv10HJ+JWtyqjhlIVDw1grtQbUmQSMgfgdQby7+f+jg6dnNYHqsEq6kLYb3v+MT+IlvjfjKXKh25tgefu6NDD18jSHMmfK95KtaUpPSl0DiA9EgpeXzTrApbBwCWJxhUxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(6512007)(6506007)(26005)(6486002)(316002)(6666004)(4326008)(186003)(53546011)(66476007)(66556008)(66946007)(8676002)(478600001)(31686004)(41300700001)(86362001)(5660300002)(44832011)(38100700002)(2906002)(83380400001)(36756003)(2616005)(31696002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cndybmVTdy9oZ01MbmRpZTRkeVliaW5oNnc1bWtla1REQUk5QUh4MUpEbmV2?=
 =?utf-8?B?MWFrNTN2Z0g2R0dyUmV4ck04cmVoWDJNY3ZzRHB4SkN5NGxCZkQ1MHlSeSs2?=
 =?utf-8?B?Qms4VnRtbS9HR0FpbHd0YjN2N2YwNlBUaXhaQ3I5eTZIb3FRVzQxZXZXeU56?=
 =?utf-8?B?ZHYyalIwbGtWT1ZwWHNncXJYRm45bFFTY05BYjNVMWQxWlpyY3V1Q0NoSUxy?=
 =?utf-8?B?TUpzNjFKeElFdEpUUU93Uk1ncUVOMjVnNWViazBzc2cxT091dHozcXc1cnJX?=
 =?utf-8?B?SC9ocFFtc2xzOU9KaUp2dng4Qkk0dW8rbVRTSTg0OHQ0QzIxVm1DTC90MTRz?=
 =?utf-8?B?cEpTUTA4Q3dOZXZqbFdJb0hmZFA3bHY3L3hUTjRRN3BaUzg1QmoxMElrdSt1?=
 =?utf-8?B?MzZ3UVFTRmp1dXRnTEUwQlAzdlhyTEM1bU13V1lDQjVPdmozVGFYbXZKUnpR?=
 =?utf-8?B?cmx0ay90VjdjZTJjRi9IU2YwSWdwcE94QmhGdWZxUE5laXRMYVEyRjZHZnE0?=
 =?utf-8?B?V29BK1VjWVhhcURxdVNKTlBPeEQ5M1loU2RiaHBkYjZZTit2cmovT1JlajBQ?=
 =?utf-8?B?Y3JxSWs3eUs3ZGlLMzIvN3E2dDVDUlVNN1BzTUpKTlhESTZ4SU91dnJQamZF?=
 =?utf-8?B?VFdXT0hsblQ1cEsxV2ZZOXZrcURndmdpVFg2MmNmN0ZsejRKODdtclpJQVha?=
 =?utf-8?B?WU1JelRtV0d0dzAzaUl6L1VxMjlqODhTQXd5ek9vQTAyK1dVcnhnZTR0ZllO?=
 =?utf-8?B?eldqOVZoQ01weExscFBlb3Bkd3ZDdENGYmxhTDNPZnVJMGlwRzkzSmY1aTFK?=
 =?utf-8?B?aFo3aEFNWE0wdGkwa1hjSjlQQzF1UjQ1WlZhM1NVQ2NiSmNlVUt0SXpVSHVj?=
 =?utf-8?B?TG91eDFPeUF1NEY3K3U1cVhWV2laMC9XWGF3M2dHQ3lRelRYRys2ZDdoYjRZ?=
 =?utf-8?B?cHpYVlpaWSs3eHdDeTZzS0haQnRWOGoyRmFBVkFhbnlaMlZDYnI5Y3lzTUFa?=
 =?utf-8?B?QWZ4R0tBeE0wakMvcGlzOFowb29LcWpsT00xbmllRXNFYW05RVBEY0tGcy9k?=
 =?utf-8?B?T2ZESFN1M1lzaWIvSW1ZTVMzQk5IYjZHOTJNcDF0Lzlia3pKYWxmOGVCYlFK?=
 =?utf-8?B?STJVYk9TZzJpaXRqTkFPL1Fuckg2ZVR6TWljdWlWOW1XaG1Tai96dlBFSjBV?=
 =?utf-8?B?dDNXakMyWGxDY2w1Y0Nmb001aURHcUtCdWxCcW1lQzFKeDdBM044Y2RLcE9N?=
 =?utf-8?B?eVU0R05lL0w2T015c1M1bXJvR0hFNkJ0NGd6NkkzRFJFd2EveWhid01CRk91?=
 =?utf-8?B?Wk5GZzRpeWZRQzVibUwwNzgxeFlaMmtYRVJzWUtmVEhVVDM5Uk9JaWRlUzZV?=
 =?utf-8?B?cms5VXRrV3BHVS9ML2J2cWhwWXZsY0FMTUYrbU1PdE5MM25POVNUbTIrcHEr?=
 =?utf-8?B?QVdiSTdGS0ZRSUd4YzNQWVJhUmxDZ3k3anl0ZWpCZXVOSmQvRXJlYWR3UVYz?=
 =?utf-8?B?djVKbXNzYTBWL2NCK1FaWHhvMStnc0daRkNOY2FmeFZmTUV5UUNKdE9WNFFl?=
 =?utf-8?B?YStxSkFIclplbkpLQTg5b1k4TndtbURlcExCMVREVld3MmEralJ5N3ZvOElM?=
 =?utf-8?B?ZjJHZTZLSXFSUDVDL1dQZE8ya3VtdDE4dWMxOFM2QnVHSHRGNk9YVjFmQ2lY?=
 =?utf-8?B?Vk5GUmxxeVIzcm9ubzdLanliRFN4alZZL25oRjY0MkFWYTRXZmtSNFVCL25w?=
 =?utf-8?B?NUU1THBLbXAxS2NtTDY1SjhuZTl0dzZBeEZURXp5QnlURTE2LzhGMkEvN2p2?=
 =?utf-8?B?dmIxVUhadkxKZHJuaWx5UEEvbHIzaHdzSmRrdzR6RHZrL2Z1NkcxK0ZaYkx0?=
 =?utf-8?B?d2dGQmwwUkdOTjJwS2I4UTkxUkt5MFFoUzlsd0V3VmhBMS9xckdYRDVyYktT?=
 =?utf-8?B?NndUMVhjQjg2VTBaVk9wTFhzSzlHSWc4R3BRMktxVHdOZ2t3S2NYa1hIRlN6?=
 =?utf-8?B?NHJRSkl4MVVuUnNraWUrb1puSGZnTGRnL0pVUU5XeXdIRGNyRml0RXZ5aXRD?=
 =?utf-8?B?ODU4eVo0NFo3UUh1YUxraStzcTlHbFdpaHRWaFQ0Q0hMWmNNVWg1UVlMZDJC?=
 =?utf-8?Q?tylLQol2UanL0HJtIPF1G9XU1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79adcdd6-9f74-41c9-e63f-08db2ef58559
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:00:24.4247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+97PO5HFdLHoQJErjw3hsyQvipoh/T9w4JRM5wY5UtYJexE9/nrhCPej4jmHZHg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8733
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
Cc: bhawanpreet.lakha@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

That's a good fix. Some questions and comments below:

On 2023-03-27 11:20, Alan Liu wrote:
> [Why]
> After gpu-reset, sometimes the driver would fail to enable vblank irq,
> causing flip_done timed out and the desktop freezed.
> 
> During gpu-reset, we will disable and enable vblank irq in dm_suspend()
> and dm_resume(). Later on in amdgpu_irq_gpu_reset_resume_helper(), we
> will check irqs' refcount and decide to enable or disable the irqs again.
> 
> However, we have 2 sets of API for controling vblank irq, one is
> dm_vblank_get/put() and another is amdgpu_irq_get/put(). Each API has
> its own refcount and flag to store the state of vblank irq, and they
> are not synchronized.

Is it possible to reconcile controlling VBlank IRQ to a single refcount?

> 
> In drm we use the first API to control vblank irq but in
> amdgpu_irq_gpu_reset_resume_helper() we use the second set of API.
> 
> The failure happens when vblank irq was enabled by dm_vblank_get() before
> gpu-reset, we have vblank->enabled true. However, during gpu-reset, in
> amdgpu_irq_gpu_reset_resume_helper(), vblank irq's state checked from
> amdgpu_irq_update() is DISABLED. So finally it will disable vblank irq
> again. After gpu-reset, if there is a cursor plane commit, the driver
> will try to enable vblank irq by calling drm_vblank_enable(), but the
> vblank->enabled is still true, so it fails to turn on vblank irq and
> causes flip_done can't be completed in vblank irq handler and desktop
> become freezed.
> 
> [How]
> Combining the 2 vblank control APIs by letting drm's API finally calls
> amdgpu_irq's API, so the irq's refcount and state of both APIs can be
> synchronized. Also add a check to prevent refcount from being less then
> 0 in amdgpu_irq_put().
> 
> Signed-off-by: Alan Liu <HaoPing.Liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |  3 +++
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 14 ++++++++++----
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index a6aef488a822..1b66003657e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -597,6 +597,9 @@ int amdgpu_irq_put(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
>  	if (!src->enabled_types || !src->funcs->set)
>  		return -EINVAL;
>  
> +	if (!amdgpu_irq_enabled(adev, src, type))
> +		return 0;
> +
>  	if (atomic_dec_and_test(&src->enabled_types[type]))
>  		return amdgpu_irq_update(adev, src, type);
>  
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index dc4f37240beb..e04f846b0b19 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -146,7 +146,7 @@ static void vblank_control_worker(struct work_struct *work)
>  
>  static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>  {
> -	enum dc_irq_source irq_source;
> +	int irq_type;
>  	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
>  	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
>  	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
> @@ -169,10 +169,16 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>  	if (rc)
>  		return rc;
>  
> -	irq_source = IRQ_TYPE_VBLANK + acrtc->otg_inst;
> +	irq_type = amdgpu_display_crtc_idx_to_irq_type(adev, acrtc->crtc_id);
> +
> +	if (enable)
> +		rc = amdgpu_irq_get(adev, &adev->crtc_irq, irq_type);
> +
> +	else

There's an unnecessary empty line before the "else". It's a good idea
to run patches through scripts/checkpatch.pl.

> +		rc = amdgpu_irq_put(adev, &adev->crtc_irq, irq_type);
>  
> -	if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
> -		return -EBUSY;
> +	if (rc)
> +		return rc;
>  
>  skip:
>  	if (amdgpu_in_reset(adev))

-- 
Regards,
Luben

