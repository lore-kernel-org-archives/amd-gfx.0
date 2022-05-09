Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267A4C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 07:48:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A3C710F551;
	Mon,  9 May 2022 07:48:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3666310F4E4
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 07:48:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+P0WcXzPWuqkXFyMX9TYYAwvxZHHU7MLLqbFmqad5qKRjJG5T39Dv58Lc/E16SQTzeUhoA+b0bYbvlpiRDQSC0SlXf6u7cvzomZ43j9+fNx8FgERTR4osTViid0tmXirkAw1YWW+wCXzNA69Rz41tGFhZxudPjRyz7R3gB57URORJqKhnNjddchK3XDDIxIrGHN1UCvPYeJVZaUXNe7P7lHeq6EupJcYImbHdLNImDyomd7hO2zu7UXOM8Epdr1rgJC60xCrN7C2AkeBcW+ERDoJPOLKL91ARd1KKhzmQNuQ/sa2fmOu63BvMgPGUam2DTalETEULV++FHThM6TfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PV2XU0ErIDk7jgG6cM/OFoEQkOQTu6Wvmt/IAw1u6rE=;
 b=XDyYj8qAlS1UmKSCAFf7Np6+PKLzZD1/EmScK5RjML/jBchrV9K5NzU1boJwsQzgWAW5gBh0Jsl7zjzEGZ14sPDEoAN5hgk2u3mcUkxp09+c/56J0CgdY3DKvOUjohpWz7bEDORmNi2hwmEN+CTCsZErKyR+nzxEH6D65MEu1m3sP5UUqELYyNE4f1aLxE8erhUpu6IQqiX27LkdAj4+wLEPLNWv105KCMNwOHW7K/GsLWpsCeNRkM7JhdqStc4YCh0/LBQF/uNF1w8L0aaYfWKUjtqmZzh9cZrKDpX5iH5+QnzUDjkf0ALoitIKa6OptY6F0V1ogqgTFz0NCQwZKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PV2XU0ErIDk7jgG6cM/OFoEQkOQTu6Wvmt/IAw1u6rE=;
 b=YklWlrvwX7lTdZ11KU99nBkdvY7Ea87w73DNVlyo3MsKTODG+/X9UByyEL5Vs6riUqV319Z+ZPQgpNIaQbeuRTKFs6UlNOxFUXhXGcWDyeM8ftRB9bEOsUwTMKTu89UBGclYJZ5xhojHTL2p2SV9mIjkcZk1sgIWvU0pkw4W7q8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 07:48:50 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::fdba:2c6c:b9ab:38f]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::fdba:2c6c:b9ab:38f%4]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 07:48:50 +0000
Message-ID: <c4109fa8-18df-866b-948c-d598c5fea905@amd.com>
Date: Mon, 9 May 2022 09:48:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: switch DM to atomic fence helpers v2
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
References: <20220509074712.163899-1-christian.koenig@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220509074712.163899-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P192CA0096.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::37) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0f125be-82cd-4cb6-4f15-08da31905b30
X-MS-TrafficTypeDiagnostic: BY5PR12MB4902:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4902E5A1046B123BEDDEA79283C69@BY5PR12MB4902.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bzzScvJpKeCLJfI5BYY3Rodr1VSfYyWvasV0xc5XWfmsDy6KiqVNptYLrEVFiakdYP2f+UIwXh1jmw2/2m2oVYTETkD9zBGpfvaoZp4I9QN6QwhrtOpPQMuXFom60DYcOxF4dOnoCidE66VBWvU1OlQUk1lHjPBARcbf2InKk1YIymZmtwFNP03kZ4p1043ry+1tQOyGNp40D5My/ufWzOPRM77+8t3ENe6GaJK+Tr2bLxBxGawzdsxX1QkxirUvrhrdXm9q9ISd0I8cGOy58YbFr49j63egVNmnAtoT7R0ARB0kgxKP6sGkUK2wT60tqe1NmOI9q3DGYaoFz4Gi0rqcsMjvRISA2inCvEKA/JsBQA/pmEc4p1wJv4TElFuIwp3TbrLOm9AB4NqLgWrCYuUCscpu4e3JUB1C2EpRhbkcilBEVVjLUNRKgfmYoa6Ehp6bRoVAGNUXrGUvD0Ask5sjE+CAR6oDE+AbNgqbERwB7tw8hhodHMcGyr9L6Pk3Zq9+6RpzJQHsBmuocohIMh9f+pHzv19m0MiGomdVpeXe49QyuUpSaifMF3NSVNCbjBjqe004fAFNII7hwQfsUAzmWfX+v1W+xKqvc4+PbPjnYOyooekGQOsL5luZ6OMe5ifRxFeQtyVqpeW7S77PwHTBGz51JJY8H+jsug1g8nwavaY1iwqDNKLfJBvWmgLkjXoGEt6MRjM+olumqtveifaKNm2aX+mUDEFZlg6n1v+5w75ZAAiOSc0iVwSs2YQC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(2906002)(8936002)(31686004)(31696002)(38100700002)(5660300002)(508600001)(66574015)(4326008)(186003)(83380400001)(66476007)(66946007)(2616005)(8676002)(66556008)(54906003)(316002)(110136005)(6636002)(6506007)(6512007)(6486002)(86362001)(6666004)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFhPQ2FKMTlDcExyU3NMSmdCdFdmR21EQ2x2Wm9wUWVFMGR3VHVoUUVEaEVi?=
 =?utf-8?B?ejFFbmI1Q2Z2aG1ZUjZPU21iSnhwZmM1eXI0SE01L2lpeFZOUVo4MmNrd08z?=
 =?utf-8?B?OTN5YlRDbTBEZlRmblJ5MmVvOUlMZC9LZHJHVE54WUVrOXpPdG1FWThUL25X?=
 =?utf-8?B?VHlXU09sWmpmcVdGKzFiYzZ4RDNOQ1lpQTNldUt2dFlLWXVLWkI3U3Ztdzls?=
 =?utf-8?B?UVZqUkF0UlpkK04zTGlPT2NNckZVY1diZjF2M3dYd2cvTFpWK3p4dFVDUStH?=
 =?utf-8?B?YllTUS9rREJUdHB0c2dSaXpaUVE0RHU0Z1lSQmdVbG1WdXgvbXE0dTc3YnR1?=
 =?utf-8?B?UkNMTTdCcGxaTEN3RXdnVXg3RVFYSVFVOWowTWZOR0Ztbi9VWmlja013bVNr?=
 =?utf-8?B?T3RtVUc1TkQ5WnAvVkVpK1plRlQzOG8rZDhiZHpPTnhTZUpLR05KZXQzRDJX?=
 =?utf-8?B?RHozeUJucS9lUnNwajhKN3Y0S2hQODZOOUJvRmYwcUVadmFpaDQvVkZVcXNG?=
 =?utf-8?B?cWNsMktKb2dmRWNQVzZRcjNCdGd3Rlcxa21UVWVTRlgzUjVmL3VFSU1MU20x?=
 =?utf-8?B?QnVVUVJXK2lFV3Brd3FUaFZzK1N1SFpwVlRJdlpNOU1GT2c2RGFCd05BSUhT?=
 =?utf-8?B?WEtLMmUybW8rMTUyYWdMY21aYUxjTFpRaDNYUStHbmlJYkYyUFFRUzUwbU9s?=
 =?utf-8?B?TG9VWmJNWWh6L2wzbmNKaHdnMlF0WUNpaU5ueW5DODBscms1T1d4RVYxaHlG?=
 =?utf-8?B?UUQwRlBMaGtyQXlXVVF2elRzUXhYa2ZpQ21jMjBGM0htMkZ4UXVvenNPU01X?=
 =?utf-8?B?empTS21ibDV6ZGUwVktSbFdVektzNnE2ejNpb0NUMUpIREtQSU5VakZ5ek1P?=
 =?utf-8?B?NjZ0VUpRYm84bTZTVUFseXYwZlRYK2dmaDdBVmd4S0VBeTJZWExxbjhNMXhy?=
 =?utf-8?B?WldVdWxUSGQ0T1YwMlU4Q21uTERVN09GMVJwSGVsazJ0SFRSMjZGWStQRGR3?=
 =?utf-8?B?YzdOMGdUWXhmNWxFMUFZdVh6ZXBZM1V6bGVnYW5pa1FTSlZHRlhpY2UzYzFD?=
 =?utf-8?B?V2pxaDVoaXRCTnljYm5pREdBVzE1cjFaQTlUd0EvVmRWYkpwa0diZFJsaGZD?=
 =?utf-8?B?UXBrbmdyNVNDNmF6a1FmZU9jQ0pWNUExYWdKbFRrazF2TGdJcEUyN3VhNGJ2?=
 =?utf-8?B?NGxhdTFvOTB2a0JZOGdRTmpwaG1uNXZabmJQalcxU3lpRUYwQlFqQlo5TENB?=
 =?utf-8?B?azU3WHN6RmhWbUh0Lys5NzlNTVlKRHZQMURVbFBtemdJdlVpc2FBaVdESGEz?=
 =?utf-8?B?bXo2K3dwdXI2Z1BrSTNKelpSZkFlampsbW9JSnkyMmhJTG9KSm93WFBKWHYy?=
 =?utf-8?B?MXR2TzBYUzdha3g2eVNyOEJWaHdrTUhJdmZhNDlKQ292NUFZMHhiRXg5VlZ6?=
 =?utf-8?B?ZThaUEE3ZnNmYlFXaUdCbi9oZU5ZZ25qNTJYSUpjdElBWURlQy9yaDBYQUlH?=
 =?utf-8?B?ZUNraksxaVhGdEwxREkwakxyWWZqQVZuQTVzSmF5S0RxdzJtWHBCU2lXdUMv?=
 =?utf-8?B?TUd2MFJGWU5TOHBrWW00V3pWWlBDQis5ci9XeWRJSkozK050ZGU3NDV4cThF?=
 =?utf-8?B?V09FOXdKUWRFYjVzMnFsMW41bkplMC9iSUJvRVJFaTlqd2hSV216NzJXQkEy?=
 =?utf-8?B?VUpYQzFEWktWNlQ5cTJGOVlPSzlWWjcxSFIweGFPWFdjcGVCb212V2Q0OHI1?=
 =?utf-8?B?NG5SSHRCdnZlTUJHaldXUU4xZjc0bjdpb3FwMmdnZ2llR2JzTVVNK2FPMmdQ?=
 =?utf-8?B?bzFyUkpBcXJNK1l0Y1BRdDZKUlRzd2NwUmZsclpWRG1CZGYrYXJ6OFZJbmxM?=
 =?utf-8?B?NWdURTBJZHNCQjBoT0xjM2JPYk5qQWd1OGU3Nk8yWmF5VjdQYWpwNldNdTVm?=
 =?utf-8?B?WkVkbi9rMnVqSFpmR2lLdjZUeUZqdlp5WTUxOUdYbGxUZWpvZGpFUXVlanA5?=
 =?utf-8?B?T291c0c2SXVqdGU0MWR6ZUJhSVVST3ZuNzJvL1BPc1hYZG1YQWFpV1JJeDAz?=
 =?utf-8?B?ZlNWRDF6eXRHN0F4SDlVdFAwclVHUHJLRDdHQmdDcjRQVTNaY3VXN0tPSkN5?=
 =?utf-8?B?NStnMDhSTVF1c0swNjMvWFo5U1hMSkh1YU9nZ0s5OWtjb2xyQW90bG1YbVNM?=
 =?utf-8?B?ZVE5MFlGdFJ4N2JwQXFBemV5cTdkbC8vRnVKV3pKZ0Q5WWZLZXRoMnFSNWh5?=
 =?utf-8?B?cnhYRXVKMDY5RnNyTlRab084dk5EYkVsU2RWbm0xRi9QVm4xdGtvQkVEWC82?=
 =?utf-8?B?WVZjV09wNnF4RmFZMWlsTmlPcm1uakk2TFRtZFIwc29UMnAwdDZWUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f125be-82cd-4cb6-4f15-08da31905b30
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 07:48:50.3321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRtsoNwcC7BgWNJcozJZ+zYISEEka0I7hwFxhVSO3sWqJM6m6GfqUrKyKWmQEQLj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4902
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
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Roman Li <Roman.Li@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Jude Shih <shenshih@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Harry, Nicholas once more a gentle ping on this.

Any objections/comments? Otherwise I'm going to push this through 
drm-misc-next.

Thanks,
Christian.

Am 09.05.22 um 09:47 schrieb Christian König:
> This gives us the standard atomic implicit and explicit fencing rules.
>
> v2: move the wait to amdgpu_dm_atomic_commit_tail
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Cc: Roman Li <Roman.Li@amd.com>
> Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
> Cc: Jude Shih <shenshih@amd.com>
> Cc: Wayne Lin <Wayne.Lin@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 ++++++++-----------
>   1 file changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a6880dd9c0bb..f9ce8cb45e6d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -83,6 +83,7 @@
>   #include <drm/drm_edid.h>
>   #include <drm/drm_vblank.h>
>   #include <drm/drm_audio_component.h>
> +#include <drm/drm_gem_atomic_helper.h>
>   
>   #if defined(CONFIG_DRM_AMD_DC_DCN)
>   #include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
> @@ -7627,6 +7628,10 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
>   		goto error_unpin;
>   	}
>   
> +	r = drm_gem_plane_helper_prepare_fb(plane, new_state);
> +	if (unlikely(r != 0))
> +		goto error_unpin;
> +
>   	amdgpu_bo_unreserve(rbo);
>   
>   	afb->address = amdgpu_bo_gpu_offset(rbo);
> @@ -9160,7 +9165,6 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>   	struct dm_crtc_state *dm_old_crtc_state =
>   			to_dm_crtc_state(drm_atomic_get_old_crtc_state(state, pcrtc));
>   	int planes_count = 0, vpos, hpos;
> -	long r;
>   	unsigned long flags;
>   	struct amdgpu_bo *abo;
>   	uint32_t target_vblank, last_flip_vblank;
> @@ -9235,18 +9239,6 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>   		}
>   
>   		abo = gem_to_amdgpu_bo(fb->obj[0]);
> -
> -		/*
> -		 * Wait for all fences on this FB. Do limited wait to avoid
> -		 * deadlock during GPU reset when this fence will not signal
> -		 * but we hold reservation lock for the BO.
> -		 */
> -		r = dma_resv_wait_timeout(abo->tbo.base.resv,
> -					  DMA_RESV_USAGE_WRITE, false,
> -					  msecs_to_jiffies(5000));
> -		if (unlikely(r <= 0))
> -			DRM_ERROR("Waiting for fences timed out!");
> -
>   		fill_dc_plane_info_and_addr(
>   			dm->adev, new_plane_state,
>   			afb->tiling_flags,
> @@ -9591,9 +9583,14 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
>   	int crtc_disable_count = 0;
>   	bool mode_set_reset_required = false;
> +	int r;
>   
>   	trace_amdgpu_dm_atomic_commit_tail_begin(state);
>   
> +	r = drm_atomic_helper_wait_for_fences(dev, state, false);
> +	if (unlikely(r))
> +		DRM_ERROR("Waiting for fences timed out!");
> +
>   	drm_atomic_helper_update_legacy_modeset_state(dev, state);
>   
>   	dm_state = dm_atomic_get_new_state(state);

