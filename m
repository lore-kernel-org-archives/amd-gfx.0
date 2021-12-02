Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E78EC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 15:09:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7D9F6E3B2;
	Thu,  2 Dec 2021 15:09:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0F206E3B2
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 15:09:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgLX7IJH+fnzTwQ9pSf0DasVHZ61iaGhWqiMdGmOzAjC1v/74+KxnDpi61ISNIWQYwqsNADtjbCFewRrccy9bR0tAl1u2r08PYiB445pK+Rp6YqJiJNlfSNNcaJrjj6AZwdq2oTWpgshAVGWvZDu0tGNvsOEkbTRUpJdGNcY7B3jcPh1CCCLchfdlf3W5UTrfTtIsWQoWhPaz8NC15pZYgrP0qlVzLs52Teb3yP5HIkijjVdqsGvHOU7/fdUWBx9wf5F8leU/6dkeshVvYEwJJj3aNbjAOGRxZtOhQxqICf1MgQRGDXjqrwRRfvzH8H1pK0LPpQuEe6KhDok+fge/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUFVoiLich4THgkoLWgo+UiJDeBfz4agP4EYhuI2XwI=;
 b=Pb9CWi63mSiwX+GBNDUK8VDmxSjARKaQ6v2WcsuwmbZ1x8e/G6SYAKfWiJ9PRbagkMwH++J3E8SPp8LxAGHZq5bu8Yw2tKhm1pVl0s7H3JdIcQG/RetUJZUoEkTYuO9KhMRhUvU6oVNXnxQg8jkKdtBjvo3fqKdizUOIDzP8i7ZYpfztNe6g8tc4pM+d7ktJLXdfQv19qyJrBvBqjUAxUt/75j4yI75LeHJepB5+1qgWu7Ksd9g0lrGZhRCTAmgOljzK/YP8jgKzwTSfB2LQYoeFmJ6MDH2NPAX2c/1NLDdaF8MM3YOv/vPMKT08gQjfNgMRKg+N9CO3e8TeiImxLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUFVoiLich4THgkoLWgo+UiJDeBfz4agP4EYhuI2XwI=;
 b=yR2GcvXXT5+yEOiHuWNH2DhhrgLSp6ZbiQmaWVWNUygtadAlGOZM1cloGOZPLn3ogDSno5UhfHrI9ZN8gnSBUh9S1JsWOGYTmowNzJis0+Jjfg3iRUZFZzIFqwaOSPtmisuYMrmG/t4iPJG+Xj6ouo2Ak58pI43LkdM4HQNDR58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM4PR12MB5279.namprd12.prod.outlook.com (2603:10b6:5:39f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 14:54:05 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::98fd:4e9b:b4d6:64a3]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::98fd:4e9b:b4d6:64a3%5]) with mapi id 15.20.4734.024; Thu, 2 Dec 2021
 14:54:05 +0000
Message-ID: <c2560a82-a4c6-6913-dc67-d11478f46afd@amd.com>
Date: Thu, 2 Dec 2021 09:54:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] drm/amd/display: Use oriented source size when
 checking cursor scaling
Content-Language: en-US
To: Vlad Zahorodnii <vlad.zahorodnii@kde.org>, amd-gfx@lists.freedesktop.org
References: <20211202121650.2265-1-vlad.zahorodnii@kde.org>
 <20211202125215.25307-1-vlad.zahorodnii@kde.org>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
In-Reply-To: <20211202125215.25307-1-vlad.zahorodnii@kde.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0135.namprd02.prod.outlook.com
 (2603:10b6:208:35::40) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
Received: from [172.31.16.161] (165.204.54.211) by
 BL0PR02CA0135.namprd02.prod.outlook.com (2603:10b6:208:35::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.17 via Frontend Transport; Thu, 2 Dec 2021 14:54:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c6382b9-4262-42c9-7c3e-08d9b5a39628
X-MS-TrafficTypeDiagnostic: DM4PR12MB5279:
X-Microsoft-Antispam-PRVS: <DM4PR12MB52793014098C6FD506579B73EC699@DM4PR12MB5279.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UTq2cQlQ9jECgZaglroCY/cVp+cANYcCZk14qBh1tFa7B0j0W1cuFHK+zqT2/yvHd96c0kQrFN1HUlLyIFofcKcXtAzhU9fmPhJpcRE41RMcMQq6smD1zYi5FXjtzQeykZCjZr/clzQV+uCGJH/dx01FRebnta76zumJ+hi07WZe1IwQ9Vbyzg6HasetxgKvJuPI6QeJdXsZHgPqBdohUSSp1ZbO6oKXI0HRKQAPV8v1gP4IwGBCoQ9tAgn9S6XhSNXOADhfHpOHsXsXwd2R5f6TnKcQnwfRHynmmqXdC9evj7gFjywgPBP5t+CskhPx1l/M5DXrPpqAb+yU3qjLgfiSmpIEfca75LF+KLAEmdVbUrZzOxehI6G9Mbw/UxlQ43AcL0lLlAEuPMC7vLQGCaZ/rfEMc0kvWWUiEFC7EirwV9OSj2bVMc32yUwKCHtqvUdu2G/ax8ALpuYCymr/j3D33SxVf7iXWJHBR3RsvtbqoJ4a3AHXKQ6Kc22b/CFXBbC5G5ZD3wLDC3jtA3yydreJZ4omBiAVSbQ2KR58MM286s8wHM0PgrEEZdOa3LJ2PP8IHvr6kO0A3id8X+EdZVRQQAaRQyXHNZf926Y8Dhfms4q2EU1bH1BxBSV+ubm3eymsnZTUKM1/bolYDV/0d3x2E2wJpaVHOnozd5U3Nrvu8QUfRVkihaCw7w9gKY56ydGuOJL4sljDmcO8hMasORh6RmmzegIISlzJrUq1AHk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(53546011)(956004)(5660300002)(31696002)(66476007)(6666004)(4326008)(186003)(8676002)(508600001)(86362001)(8936002)(36756003)(38100700002)(66556008)(16576012)(316002)(31686004)(26005)(2906002)(6486002)(66946007)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TElYRFRyQy92Tzg3SE5kR2p5RWowQ3R1NUNLcnloZE8wRHdadGlodVpqS1RP?=
 =?utf-8?B?Q01ORGpIaTYxS1ZGSlFibW90VHNUVi95NlY1dDJrV0RqeTdtazY4cCtZdCt5?=
 =?utf-8?B?TzYraCtOQXUxTGpWd0dEU1JmNVJpTnlwQ3VWU0RZajJTZXlZVzkzYkxWUk1z?=
 =?utf-8?B?V1U2akwwNmJSdlMyQnRtNEYzN3VPVU1vQm9kNGIvSnVrcklsazZ5SmpKNWFp?=
 =?utf-8?B?aXhJZC8rbndZUGE4SWtwZjErUjE2MjhqWEQ3TnVYZk1jdUNINTdqbEMvY2dr?=
 =?utf-8?B?Q1p2OTZYYkhTWEo1cmRSK1VmbmVzRFhmZkxrNjN5RUpLRFVyRWFlbERTUXFu?=
 =?utf-8?B?anIwVC9IRkp0MWNFTTQ2aXROWUxSMFpWN1ZtZmRIcEF6VHVGd3NTeDdiRlY4?=
 =?utf-8?B?UzZjZnp5blZNS1ZuVS9xVlZxQ0RjMmM0RlVGUTRIa3lpMis0Si9PWUtKM01N?=
 =?utf-8?B?Tk16UGwrMWVXU3l4VXdFMUl2M3ZLTzVHQmVEYlU3ZklnVGhXMG80SElOa1d1?=
 =?utf-8?B?S2FHcTcyTHMrcjZuUlpLYUVxRHFadFc5OFQ2bktrazNvakVjN253WGZsZW1L?=
 =?utf-8?B?SlRSQjhzc2pxaUNPaG5iRk5xL2RadUtueDlSVmdPSWx4Q28xN2kycmRncGdK?=
 =?utf-8?B?MGdLc3hIL05wVzFjekFVcEhRY2o1V3ZVY0xreHE4TS81M2orTkk3eWJYeW4w?=
 =?utf-8?B?U2VLZUxsVXRaaWtqcExHR3JrWGdwa1d0VS9XU2NhR3V5aVZBSTZIbXJxQnoz?=
 =?utf-8?B?b2RjcXExQy9Ecm9MOGhxOVk5QjhMekdMUkFXYjhtMnZxMkM1bCt2YXhCdE1x?=
 =?utf-8?B?MzRhaFlFVnlsWUFEUjZEanJZZGZUU0VVZ1F0VFJIVVlKL3JqRm5xQmpMT2ds?=
 =?utf-8?B?NFptcWNlcGpTN042NjZJOUxPWEJ5R1N1MEZxUjJYUytVU1Y4MjZsc0VvSmlY?=
 =?utf-8?B?U01VRkpuMmx6WW83dUZBb1JpQW41cDlJdW9xd3pybUxuYzV3azVoWVk5MWpI?=
 =?utf-8?B?L3JRNC9aRS9XM0dXMzNpU1BXMmdMdEFIbXppNVNRRWtTcTMva0EweG5aN1Zl?=
 =?utf-8?B?ZFhEWUxqdGVGWVRLY1hFUnRDRzNHVEY0MStuZW83MVRtd0xQQ0tQTHIvR0Z1?=
 =?utf-8?B?aHhrQUdkM2pMc0F4TXFwNjljY1Z5VE9Pc2FEZTFDdUJTUjFUYW5YVTZlNytI?=
 =?utf-8?B?dmFVTFJOWlJGUjMvbllIeVBUWmcremFnVVpkRGtlVzM4blREaHkwRFFTMFZa?=
 =?utf-8?B?cVpGWWU3dFpUTC9OVXdZMUlubXRKT0VQQWYwdExEc3BuUWNhK2ZBT2xiRHdT?=
 =?utf-8?B?MlhpczBWN0JLMmZydjNMK1l6bTkyV05OQ2FhckljS1lnbUx3a1pkK0tJNFgy?=
 =?utf-8?B?djZ6SS9hdnZidjBRckgrWXYwM3EyblpKUUdCalJadlF3SU1PRTc2L1hIZEZD?=
 =?utf-8?B?WkxNc0QzVDViQVQrZUlJQ1ZnK2pIRVdkcHlBSEhMeGRQOWZmTXVzeVJUY1pD?=
 =?utf-8?B?NERTa081UFNydGlnREk3UVdMbFJpWlB0VlZDVnZvS0I5ZStLblpINExXUXdV?=
 =?utf-8?B?TkJSOEFqNDdLOVFENHpBelZoc3krTXBBQ0Vla1AwRDZiWVArZm9LQ3RRcGJa?=
 =?utf-8?B?M1JCZ0tOeS9Fc05jQ0ZHd1VabUl2SFlWaEl1cUZYZExVVWc0RVIrT01jUmd2?=
 =?utf-8?B?cDV6WlVqUjg1YlBvSlJXU0tubzFWdnFLUmN1WDRHLzBUaTRxSnhmQS93RVpx?=
 =?utf-8?B?NElkQUtoVmNSdnhnQ0xEN0FLbDFqUVFJWXNlT2NvZ0xnWTZYY1RvbVFEbzVy?=
 =?utf-8?B?cEZScXFOMGsvSWx6RGZSRXI0YmVnR1A4VDdBVVJSYU5YNWJzQU5ib0dKUE9z?=
 =?utf-8?B?YktyeG5JaElacnlLODUxc09IRlVVbUxxeHNSTG1oOSsrZ2xBQ0FGRENXNjBD?=
 =?utf-8?B?angyTmR6QklKSmwva3pONlhwMkplamZhRVlua1RzRmJRaGNVVjBPdm5IUWcx?=
 =?utf-8?B?UEJ2U1hodDhNRXJ1MU9pRU9MM3luemJya0taMDhBdkh1TElvdG1DSHV2UzA0?=
 =?utf-8?B?czR5TmpsNUhycnFZQjRSVC9RRlpSWDFhTitIQ25DMHNENGpzTmgwcnFmdlFO?=
 =?utf-8?B?aHBrM3kvRkx3R3A0aTN1U21qbHVEYWE1Nzk2SGd1MzYrQmpveEFJOUMraE5T?=
 =?utf-8?Q?tI/ZY5XbaXz9h3XbE15Vsd4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6382b9-4262-42c9-7c3e-08d9b5a39628
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 14:54:05.5278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28BnVHyrr2f68hBeb83f+56XKkvFvKJ+Rsr0rVS3AfB1J36uSH7kRlvLrucqeP2VxSixzJZKcJDXI0UwhjgoLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5279
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
Cc: alexander.deucher@amd.com, contact@emersion.fr, Rodrigo.Siqueira@amd.com,
 xaver.hugl@gmail.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-12-02 7:52 a.m., Vlad Zahorodnii wrote:
> dm_check_crtc_cursor() doesn't take into account plane transforms when
> calculating plane scaling, this can result in false positives.
> 
> For example, if there's an output with resolution 3840x2160 and the
> output is rotated 90 degrees, CRTC_W and CRTC_H will be 3840 and 2160,
> respectively, but SRC_W and SRC_H will be 2160 and 3840, respectively.
> 
> Since the cursor plane usually has a square buffer attached to it, the
> dm_check_crtc_cursor() will think that there's a scale factor mismatch
> even though there isn't really.
> 
> This fixes an issue where kwin fails to use hardware plane transforms.
> 
> Changes since version 1:
> - s/orientated/oriented/g
> 
> Signed-off-by: Vlad Zahorodnii <vlad.zahorodnii@kde.org>

This looks correct to me. I guess it's also not modifying the actual 
programming position, just the check to ensure that the cursor is going 
to be unscaled in the correct orientation.

Would be good to have some IGT tests for these scaled cases to verify 
atomic check pass/fail assumptions, but for now:

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 35 ++++++++++++++-----
>   1 file changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a3c0f2e4f4c1..c009c668fbe2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10736,6 +10736,24 @@ static int dm_update_plane_state(struct dc *dc,
>   	return ret;
>   }
>   
> +static void dm_get_oriented_plane_size(struct drm_plane_state *plane_state,
> +				       int *src_w, int *src_h)
> +{
> +	switch (plane_state->rotation & DRM_MODE_ROTATE_MASK) {
> +	case DRM_MODE_ROTATE_90:
> +	case DRM_MODE_ROTATE_270:
> +		*src_w = plane_state->src_h >> 16;
> +		*src_h = plane_state->src_w >> 16;
> +		break;
> +	case DRM_MODE_ROTATE_0:
> +	case DRM_MODE_ROTATE_180:
> +	default:
> +		*src_w = plane_state->src_w >> 16;
> +		*src_h = plane_state->src_h >> 16;
> +		break;
> +	}
> +}
> +
>   static int dm_check_crtc_cursor(struct drm_atomic_state *state,
>   				struct drm_crtc *crtc,
>   				struct drm_crtc_state *new_crtc_state)
> @@ -10744,6 +10762,8 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
>   	struct drm_plane_state *new_cursor_state, *new_underlying_state;
>   	int i;
>   	int cursor_scale_w, cursor_scale_h, underlying_scale_w, underlying_scale_h;
> +	int cursor_src_w, cursor_src_h;
> +	int underlying_src_w, underlying_src_h;
>   
>   	/* On DCE and DCN there is no dedicated hardware cursor plane. We get a
>   	 * cursor per pipe but it's going to inherit the scaling and
> @@ -10755,10 +10775,9 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
>   		return 0;
>   	}
>   
> -	cursor_scale_w = new_cursor_state->crtc_w * 1000 /
> -			 (new_cursor_state->src_w >> 16);
> -	cursor_scale_h = new_cursor_state->crtc_h * 1000 /
> -			 (new_cursor_state->src_h >> 16);
> +	dm_get_oriented_plane_size(new_cursor_state, &cursor_src_w, &cursor_src_h);
> +	cursor_scale_w = new_cursor_state->crtc_w * 1000 / cursor_src_w;
> +	cursor_scale_h = new_cursor_state->crtc_h * 1000 / cursor_src_h;
>   
>   	for_each_new_plane_in_state_reverse(state, underlying, new_underlying_state, i) {
>   		/* Narrow down to non-cursor planes on the same CRTC as the cursor */
> @@ -10769,10 +10788,10 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
>   		if (!new_underlying_state->fb)
>   			continue;
>   
> -		underlying_scale_w = new_underlying_state->crtc_w * 1000 /
> -				     (new_underlying_state->src_w >> 16);
> -		underlying_scale_h = new_underlying_state->crtc_h * 1000 /
> -				     (new_underlying_state->src_h >> 16);
> +		dm_get_oriented_plane_size(new_underlying_state,
> +					   &underlying_src_w, &underlying_src_h);
> +		underlying_scale_w = new_underlying_state->crtc_w * 1000 / underlying_src_w;
> +		underlying_scale_h = new_underlying_state->crtc_h * 1000 / underlying_src_h;
>   
>   		if (cursor_scale_w != underlying_scale_w ||
>   		    cursor_scale_h != underlying_scale_h) {
> 

