Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A96C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 15:35:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8511F610CF
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 15:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8511F610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D0866E5B2;
	Wed, 10 Nov 2021 15:35:45 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2055.outbound.protection.outlook.com [40.107.102.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C95716E5B2
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 15:35:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diAG4blbtpZ6adkaP9S+rqKYgbvmIp4xyw4ykavjMSqfgCGuvK1ZvVZ/FcDm1fdSAMXZJW8K8nWQ9A6gqZ3khFrBCngdkljBTk466BZbi4duy76pbE9tU9lj8aEHzjoawO9j0RmodybLNjjr6MG1dFR2i+sQ18W0rJ+BVG1oWr8fRA+5Q2jV/z2SVHtGYGmh4sJjvps0mZ+HWzmCc0IgjTddBw3dkllc32H08gB8zrK/fH6wYDYGxzUdGezuo9EC4p2ZvV21aqPz2Vspb6/bj8xKi7iCQ3vK4DxjD6LNj3ez+sk7KKwlCel+S1lBJlJhjPefxoZ1RUoiMygpB0aOVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iza8LaVRBlQ0waf7zwG2ueBxH29DzqrOeE77JSsYtf4=;
 b=RYHbhf5RFdF3rPcYjr5uh+m5ExofX/q9y8ITBOFcYU8R3rXGLF+QoQKM1jkd6tnv+HMflJPdKpYzHJUr2xidvEzO6uUd9BVy9Y5rOb3ZLVUR4YUfib4sK8apMn1WyyIYShq6CfH4+4Kb2bWtrBGllqwhma8v7amTXoCaQ62jCs9wTXWyCxhFUX8hbNmsZRtzjolx4FCb9aCJgbZKH3jRTczUv1cPsa/uEKt3JmKFXELOOLuTsonHUVVnCQdUG1X+FeZA8nA3/Tmwgpm7KgdVqY3xkbiMMRHrY0QuOCM3QMrfTHbZ2UHKiEeqiPDNznEgIZPbnPIsBkavtdbrX383mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iza8LaVRBlQ0waf7zwG2ueBxH29DzqrOeE77JSsYtf4=;
 b=ZuUi4O3LYdq10OIzU/dza+DuzgXSbFFazzLjVkuGBqaDuq9aOcNFS6e8cRAjzOAXKDGlln41EI2Quyc+6GvlCsK6fGNFsrIiexGj77Xdcl1T2S7lhBJC4t7X396KRdGaWw6VoADZPbdToHbvWmAbWjZd8wSNSS1uIn9Au1wiglY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Wed, 10 Nov
 2021 15:35:41 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d095:131a:b99a:9975]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d095:131a:b99a:9975%3]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 15:35:41 +0000
Message-ID: <74630248-e569-792d-7474-4fd31cd5af32@amd.com>
Date: Wed, 10 Nov 2021 10:35:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amdgpu/display: set vblank_disable_immediate for DC
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211110152652.2245569-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211110152652.2245569-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0068.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::40) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQBPR01CA0068.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 15:35:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa2c6e52-10c1-4ad9-5e3c-08d9a45fc0eb
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5427789AFF273BE242B39D548C939@CO6PR12MB5427.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lv5xZ3WVAUY+x6LkDCMHrMkQ4lL8HdQjdeEPCO/wu330KHbrRIO5/e4kwHBwzCZukyV0kDlO77/cOqZY6jfKLU3WfeclCn/bBZsFEqcw+iPA8KiBNEfT764W3Pg5WX80DPIa7nB99tdx3XqwTzPPcap15qPbrJa6H4e60T2YYPBwDO3E+kqtDZMlg1ZST1Xv8aSf9aAsjMDlXBKmViKHbuTSqrJxPAg0mlzaD2214GghlXwC5mrV/OshAqifaxHfWQD9lzw6gxohC34maPykej8QUIupxD+q1KzcduNevwBa0LsMOqTp9xvPv5fNXCBAK6AnHggdKKKnaA+iIDxOeEdbxWv7UUSpQ1RqvbkyRgoHVkC1se5dgtS6gJ87lqhw5237TwAlAYmjOi7NyMNnm1aX5AAwGDCSHaGTj/kG/0KZzGfxYA/d7sb7c7AeXKSPpe2z+eOEUF2osmf+3/WBITTd5VkPvMfsE7zyJEZ9psda891BZzH99oSwhds7bK8g2rgHObhXwHRk+mQwLQmPsOqoRCtMB6oCCOkKbjvgpvM4mjyS8Ixz9HQ/LOyzNiCrwIYuh3SKDz2hbhU0P0/XsnOsZU2P00+RDviFP8ijLAgUZDK/ZiHWgIlAL6CS7rQJgDz0YU6NxGZ4BoDOr2isW8HayKbSOi6jcwdYrRruOj1kAI6BYwxLmkLtKXtadcljoS/MxKcjDBp91p8BH0Dh35u+jFSpwXKncoLHGNuFtVBEr7GlZJygUKCfryMvGfrF9ZIdrlOcohu0HoIBTCPhDQFG9Pcdox9WQwBa5ejf2e0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(83380400001)(66556008)(26005)(2616005)(66476007)(5660300002)(6486002)(36756003)(53546011)(44832011)(6666004)(16576012)(8936002)(966005)(31686004)(316002)(956004)(186003)(8676002)(31696002)(508600001)(66946007)(4001150100001)(2906002)(38100700002)(14773001)(21314003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1NLTmZIWkR3TFdpRDhpM3JTaUpWU2RlZUh6NXdWYXJDa2VFaVNZUDRaUVBW?=
 =?utf-8?B?OFZDQ25MdUg4bzZWNC9haWduWnFSTjB1UWQ0VnozbHFGcFpFcms5YXZyKytC?=
 =?utf-8?B?UTUrdVJkSmlYZWZTSGNMdmNKYU9EaEV2WDB5SWpCVFRrMnlQdFFTSWlEUU4r?=
 =?utf-8?B?RXFQQ29SY214WXBWS2tLNmVKOWVERjJ1QlFKS25jY3RQNDR1Z1NXZDlsK2ky?=
 =?utf-8?B?RGxrMmJsd0dFRzR5SnFwbjlCL0dwRkhkcjF3M2RKZklyV2diMkRFR2N2Ykdy?=
 =?utf-8?B?OXEzalBlZGZDZlhLRzYvWVpPN01TL0dqUHhKSGI5UWNXbjMyT1U5YzNXTEp2?=
 =?utf-8?B?YTlwY3B1bGxkL0lLb0svcWtUdjJOTFFVRkVCb212M1dzM0t1MmNTVGNUN2VC?=
 =?utf-8?B?anl1UFRjcnF2d2JHWTVHYmIzOTBRTlZLN1BRak5TNk9hTzd4YkxQa0FWaGxC?=
 =?utf-8?B?Ky9sZGdtV3AwaTk0OFlESy9meFBpbVJFazlVKytSNndIeWlOelNEUm92djdV?=
 =?utf-8?B?eGM0cmxHWU1MMTI1eUExL254eW9TOXZCUDFTbVl4OHorTGJEcUJ3R0Y4Tm9I?=
 =?utf-8?B?bk5OUjY3aVBRMVhuenBBVEZHRkhEU0ZjRjNPM1RKTXdkdjRKOXNvOEswa2tE?=
 =?utf-8?B?S0lwc0hVTlhLMVFGSzQ0UHg3d2VZTmw3Ni9LNXRkSTF2R29BZ2g0V2x0Nlkv?=
 =?utf-8?B?Y0JSN3dETlRwQkcrUXdpSDUzUjJZVGg1eVh2WGxmdFNaeFVQWXRSM2lIajRz?=
 =?utf-8?B?Wmt1MytUeWZ0S0FpazViMkx4bHI5Z0NKZy9GWHVvcnMraGtmMWp6cWVKRTJL?=
 =?utf-8?B?cDJ0cDR3VlI3VXNZdnQ5Umt1bEtnUHlYemlNVURTbWxmQjdDMmJHdnNjNGhX?=
 =?utf-8?B?RVpvN3dhTVg1R3JaSXJVQkVLNkZTbTNqbyt2SWl0WlU4R2d4TGE3M05scUIx?=
 =?utf-8?B?UmFDeHZ4S1AyT1lLN09FOFBXRXErbERVNHhpVUxrK0s5YlgvNUpaaW5hdGQ1?=
 =?utf-8?B?UU10RS80WUJYeXdkYnh0U2FWTmc3UUxGUDl1b0V2dEVIc09mSUtpTlBZanRz?=
 =?utf-8?B?ME4zZHUyNDYyMUhvT1ZVVWwxUE5pOGVtZjYrZHZxdVZQRXZkcUZQR05DRld0?=
 =?utf-8?B?Q09GWjlkbXNpTUZHNHZya1JBeGd5a21lMkJLVzlqd0J2ZUl0V1VPbGpRalVt?=
 =?utf-8?B?SzhYZTB2S1p6SzdQbXoyeUd5dEtESmZLZ2JnRmoydmhRM1BBRmh3Q25oYlNX?=
 =?utf-8?B?cDhLQ0g0bE1UalBZaERjWXZob2Y4L0RudENyVVNIaEZMZ2krc0tHTHRneXVE?=
 =?utf-8?B?WWJreWFYQmdhcDhkclJRSWJXajEwK2ZmRUljem5Remk5YjVNdUsvQWVMRk15?=
 =?utf-8?B?SU4zSDZubUpEcjhQTlU0NEpYQ3luVDYzU1JPanpiRVlNUWs2WmZqWDM5YUY0?=
 =?utf-8?B?bEYycGFsS1BhU0M3eVhIdlFnYmYyby9SVDBWbmYzUFdmaHJqcGtSVEtxUUJL?=
 =?utf-8?B?aUozQXl2Z3pMSFpRSm5xR2VBTTMvRFJ2NTZQT2ZOQjdKOXVhVmFjeUNoVFMr?=
 =?utf-8?B?ZXhiTTNiMCtRSlpUaWpqaXA5RXdlK0RCMW9WTnUwZ05qZ3kxcEFOM1E5VlpX?=
 =?utf-8?B?eHVZekFpelJqNk5oTjBVSktVTEp6Tk5rRUxDNG9obHZsOVlaMzdaL1lNTDhY?=
 =?utf-8?B?WEhnL1RsVkwxblJpWlJLVDQ3bzNpVUpnUEJ1RnZXK213aTR3dEQxODk1Mmxq?=
 =?utf-8?B?a1N2bzlDb25hZ0RHWmhhbzM1TWhySEdUemhzRkVKOU10TUhFa1lETG5DQk42?=
 =?utf-8?B?aDdwZFVGTjdxb0FSTlp4bnZQOVVnYVQvQU9ZZVp0azdTQlhHOFY1anFxMUVF?=
 =?utf-8?B?blhFR1lxSGhKTFdnWnl0cENqWTdDaFZIa1F0QWdPV2liYklCNFNjQS9wa3p3?=
 =?utf-8?B?anF6NmFrUDA1SHdVOUV1UzEvNHdlcENqeE1EM2dKdE9KYzlqSUg1RHF3Y3Fj?=
 =?utf-8?B?NmgwZTZoV2JTR2diZllZUnA5cE1EcU1tL2xMZHVnWlZnTjl6LzBPbXpoM2U2?=
 =?utf-8?B?MDMrNXpnOE5pZmlBNXN0Z09NSjUrMlAwZ29ETDhlWEZvL1VvT3pvd0l0eFZQ?=
 =?utf-8?B?M1BHZWVpMTQ5V3RtZVpMaHVKY25qOENaWWtJVitNSWZaaDR0UmR2cFM3dldD?=
 =?utf-8?Q?7UiFpDAYOS6Isbx8TmFgUZ0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2c6e52-10c1-4ad9-5e3c-08d9a45fc0eb
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 15:35:41.7803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwR9BOHTvF0568DyV8PYITa3p7jKTOFicEUyEjXXUMn1nr/oGgVZlMU/l6KQUbEqDgjHAZb8vpMS11YNE0c9vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5427
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

On 2021-11-10 10:26, Alex Deucher wrote:
> Disable vblanks immediately to save power.  I think this was
> missed when we merged DC support.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1781
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c           | 1 -
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index cc2e0c9cfe0a..4f3c62adccbd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -333,7 +333,6 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>  	if (!amdgpu_device_has_dc_support(adev)) {
>  		if (!adev->enable_virtual_display)
>  			/* Disable vblank IRQs aggressively for power-saving */
> -			/* XXX: can this be enabled for DC? */
>  			adev_to_drm(adev)->vblank_disable_immediate = true;
>  
>  		r = drm_vblank_init(adev_to_drm(adev), adev->mode_info.num_crtc);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1371432c8f11..652c973e6daa 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1590,6 +1590,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  	adev_to_drm(adev)->mode_config.cursor_width = adev->dm.dc->caps.max_cursor_size;
>  	adev_to_drm(adev)->mode_config.cursor_height = adev->dm.dc->caps.max_cursor_size;
>  
> +	/* Disable vblank IRQs aggressively for power-saving */
> +	adev_to_drm(adev)->vblank_disable_immediate = true;
> +
>  	if (drm_vblank_init(adev_to_drm(adev), adev->dm.display_indexes_num)) {
>  		DRM_ERROR(
>  		"amdgpu: failed to initialize sw for display support.\n");
> 

