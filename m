Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A256C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Oct 2022 19:12:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B3D910E47F;
	Mon,  3 Oct 2022 19:12:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5931A10E47F
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Oct 2022 19:12:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gITaTlptFK2hScvDC1nHz1cuCP9vk4UhomX2b4jGtnqZ6ObJVGbO6Xz2Cv8SBARse89lFXP/9Et3usLwZdzGc19Wa2o0Bgxm/pRnV3coMClKXH1OeQJeRz0+dSrK+PdYeRWys4ULYI+WSHfppFr0il3z7QfxM64yWJ43flHcHMGpt4mV2tvXLqVQ0V2JcoX79zcgSnnuOMEJx4dd8NXrqSahsx8CBPF6pl68dvzqGit0PGz/fZRCyYRsOmu6BTGyCdswWCPPbJ7tl6+4HJuMxdbwejmkOQ2+UiS4JtBFK63Fh+y1SucxwzVVkmw/oBSjd6LyIKO+wHDqQIJizDHeKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGpI4kRdPGNrEes6d/ALcoqkDA6yH+7cjwSyQqZd3WA=;
 b=ZrsIivua2Kj2zL+h4MMMbigm3Ij4FYL27H7RYMKg9eH0HG9Ot7GI3FubdneoU4PzKRv8X/65nK3QLe2xVyipljpMQNLYloJeJkfJ+eaRXpmWY/hhF9+ozjnVpyBH2veFevwgpuj8TeAeie0quRw0jDyljCHUAtUjF+t3CPMOctcuYRcrVgaFiCnU48fWyreiWIJuv8rbrlHKGe/FYhwT2YuOFDSUsM/1PiWhV+03zccOuEXAXDIat2wyXllR6szS43vN4QnPCy4tiseRY4/SAGuhHWVuUQNsXfM/Ec0iLZwH7bTDqjtj1Bo7HWebXNCzTl4YzZnnFBFKiG/bvZLMRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGpI4kRdPGNrEes6d/ALcoqkDA6yH+7cjwSyQqZd3WA=;
 b=ENuw3Q9LBJBVTAdjJIyeD1wDZ0cJVRekuOrVtJ1kogDTE8dHmGhfExdPaSGfjTnVuZdQp0GhyHe60v9i04IkD8uo4wlMZf+8X4eFBLHKbc8AP0SIw/eDr1iBQFzLd45wH5Pp2n10s59H9TEBZE0W4/DDAJQ257kGMkonIDT7Gv8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 3 Oct
 2022 19:12:02 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588c:ac12:d318:bfee]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588c:ac12:d318:bfee%7]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 19:12:02 +0000
Message-ID: <46bebe17-a5b9-41f1-9d3b-9cd5fd39694c@amd.com>
Date: Mon, 3 Oct 2022 15:12:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v5] drm/amd/display: Fix vblank refcount in vrr transition
Content-Language: en-US
To: Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 Harry.Wentland@amd.com, mario.kleiner.de@gmail.com, alexdeucher@gmail.com
References: <20220921212019.9496-1-Yunxiang.Li@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220921212019.9496-1-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0068.namprd04.prod.outlook.com
 (2603:10b6:610:74::13) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|CY5PR12MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e9c39b-45f5-4ca0-d48c-08daa573274d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y0PgICzJK/PBbkmaUivOS+zawF8LwcJWeCn2XzqAdkySe5s7gYfHIK0DruuUVPsR+lQZgPHBFgLPT21TaRQTfVsDeVW9hdt3lgP1qtTnSiAskOCiuH4HWmZIUeSXkH+J0GZuATq7SoEdSbN4YPSK4nXtIY1mrJ9lMBC9quAXbQdz/LAmxNuO+QB66ukXL86R1bwgCYX/IMWD1TtB6aPuXh5nc3IeTRo+TXx8YkybZ5eIRDQcCbvrPPGNAn5J5squgW/Rst8ATBqG/ZwOb9sg7Z7fyEDj8SqFSXx6IGZ8WhHosCaCNLe6z16qDvPXsyPdwrA+6ZRDDO6Li8/FTjGwWy9ignuGT4y70DBEbNkrHOZU5YNZ21m5qoC1Y1RwPw3bJIH+bzm66KcxMKmzHXSypWwDOiEFgWny0N5RkP0g14Yus/ypOk213uVvw4IML/YFGvKVb1K2fxl1cBVG431lVF3wX/PIAQM/HRSgw/GTNJ2DKce7pFa21aW7ZQPUVcOhKfNHTPtJiteHNI3iG+67WyhvO+/JPc6JORHB71k25FqdFv/6OnH3D8ORsKA72DLsMR8HF9edREu7b9iE+qSOIZx3193dl9r8DeNQ6clQlYDxTxFK9GXf6DiNqKs0Its/rGLVIT1UIvRWm1+Ia4DPCD/yHBO+mDBMaPPr27NQYeQxnHvVELhFuEm6aLYTioLSmTYTkM0XQ02UK68SVif2OYDMfHubQ/4szG63pOlGJuSa0LzpvFPWgwvfN882S2IX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199015)(31686004)(86362001)(26005)(2616005)(53546011)(6506007)(83380400001)(478600001)(6486002)(186003)(36756003)(966005)(31696002)(2906002)(41300700001)(5660300002)(316002)(8936002)(6512007)(38100700002)(66946007)(66556008)(8676002)(66476007)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2VtRE0yQUUxTWtkWXArbUFqY3Z5QXN0YmdwaC9ZVmtRSnFWaG96L3NlcjhS?=
 =?utf-8?B?Mm94dFg4SHA1a1FEeElCMTdTUExva1h6TjNMZklkdHRueVZWK21ONGdHVGti?=
 =?utf-8?B?RWNHb2QxWlEvS3ZCNkpKZlJkaGRaclVUN3dZbUNXc1NoRUd3TTIwMlgzMDAv?=
 =?utf-8?B?eTgzSS9ORzJXK0lpb3FEam83TUcrOCs4TDlCY09wOUVIUzNUcVMxZTcwbUxo?=
 =?utf-8?B?STJKbEFPa2xRS3R1M0gvSzdVcmZCcjRiQjd1V1d6MDBmdDUrTGZTa0RUcFZm?=
 =?utf-8?B?VUh1UG9CYmVMV1hIVmVsVUhyTDFsZ0Z6ZThrcjR2blc5anFiQ3prNTU4bk9p?=
 =?utf-8?B?TkY3S1VmU1lTaGVKendaMjVlRWwrRmF5R1kxWmRKTWFvallBR1k1R2JnTEVY?=
 =?utf-8?B?cTdHWlVjZVZrdUVoVS94M1hXM3VQbGt6MHlxQ3JOd3lFUVZEbUFxNHI2VjVD?=
 =?utf-8?B?UGJRMDEyN29Ka0RpaFpINGVuQWVzM3lKUTk1RlMzUWFkN1krYWUydTdQZGp0?=
 =?utf-8?B?SERlQUJrblVUb1p4Mkl6UVJya2VpU2xWNmdyL2Q0VStrOVNxbEZnNVdoNTlp?=
 =?utf-8?B?ZXBWci9yU3BSTUFzUXRoMTUrZkZzVnJja2hiaWpGd3ZhU0tsZlJXc2dDZklS?=
 =?utf-8?B?ckxzWW9ROERnSFYvODhZaG8vcTIySHJZYWIvOGtLQU82K0pxYm05TUdvTkJM?=
 =?utf-8?B?VHlYT3AzVVp4VlIveDdNV1EyRU90SkFJNlpzSkZRQWFYUk00VmNUeUNxV2Iw?=
 =?utf-8?B?NTA1VHgralNnZ0MyYk92V01rR3c0MkhCelVzcENsMHNRQzlSTWFHbWpEYUdP?=
 =?utf-8?B?MUVDY1djL2M0UmxJcDJOSmpDTDVCM21NdW43N09oV3dZeEd6QTdQOFMweTAw?=
 =?utf-8?B?V0NjYkVJOTVVUHVIR3QvRVFMNXdHeDVDK2k4akNTbU02cys1dDIyTVFuUlBs?=
 =?utf-8?B?WlZmTXoyU3E5aGtXNTMrM1JqejZodmFhRnVLQ2FmOUo5bEhmSks1VTQ2Yllo?=
 =?utf-8?B?dXlLdEVMU2VWWFdlYkZlWksrTmxmUU5KWUdHaUwyRWRxSjdXQkgzMVFGWk1j?=
 =?utf-8?B?Qk9jb0VPZW84UWJqcGlKbVJqOHYxc01HN1pFamo2Nk9ycjYvT3hpVjRmSmxL?=
 =?utf-8?B?MmFGbHAzNlArMTNHdHRzTUd2cGNGbFRpL2RLT29DZ2hTN2R3eGJiUFVza2pW?=
 =?utf-8?B?UHFYZzYzMCtSRy9RVXlpUGhQN3BEaGQ1Rno1cUUwckNtMWY5R0ltMUtQRzA1?=
 =?utf-8?B?T0RZbVkwN3ZjeDJxUUhuZWVDVk5uUVBzTm1JOXVKNng5NHlabVZGVjl1V1NU?=
 =?utf-8?B?UEtlR1hRaURpc2tnSzBpUitnbTQ1WXV3bzlzM2NnUkRsVWFZakxuSnRrdmVh?=
 =?utf-8?B?cGkybXVsek9iWlRMN0VFVmdJV0dSaS9GNmVOLzFMSjVzUzNoelJtOEF1aHBj?=
 =?utf-8?B?WjlNQ1gwRnorRGtpZTFGczNmcURMRytzb3hReUlmT045TnBQcHpDNkhWRWxB?=
 =?utf-8?B?T3lyOFdFbUEvd1ZDdU1xMVlISTVyOEJEcFBjRUF5VWtxdWl4c0xzWm5uVSs4?=
 =?utf-8?B?eFRKT2ttSTgxUzRKK0gwV2RpZEhTRTA5dGtLZEZjT2s5RWpFMXdUKytCTXky?=
 =?utf-8?B?RFdjVlBpVHNsTndRem1CTEw0Rll0c05QSWFzTXhjbFBxZVRENUFKUGJmK3dL?=
 =?utf-8?B?V29YNUtucnk2MWZtUEs4NnZDTnNQUjhKSEFXRjJ5YTBFK1ZwMWpBRVkzdXd2?=
 =?utf-8?B?MDlYMERDSDN4OEg5WEFxdmpJRDQ5VytQUndNVFBPRlFFYWtsRThjUElzQVBp?=
 =?utf-8?B?Q3VWU1FHdkNTK0twRGJrMG55RjV3TUVaNW5EZUxBYWNoSk81QmdwbklXMVJw?=
 =?utf-8?B?TWZuQW9mNW8vVmV2RFU1MTdGQVFqL3FXRXk5ZGEyYTFVUEhnV1h3a3JuYkxE?=
 =?utf-8?B?Tmp5ZU9oWmJJend1ZGxBZlpkZmQvN3grbkFSY3FFd1U3VDJwOVJPOFhJb0k3?=
 =?utf-8?B?WTczRnVrQnJhdGZlMmRoTmNid0NEaytnNUtnY1FxRXlpUTNKdHNTbHdwOGZD?=
 =?utf-8?B?OGVnQk5rSnM5VUJrWStodjE0cXUrREZsajQydC9yMXI3b0VUQ2d2VTExVHVG?=
 =?utf-8?Q?Ugg+nyeJ6AoSKwzsbyGLJhM7R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e9c39b-45f5-4ca0-d48c-08daa573274d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 19:12:02.8080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAub2TxV/s68xCKSbfI7XzMS5N4hRMU8g6zi8jU7FlGYAksYKL5U3V/gxGzZly3i3HcE06BMwZuWWT52VTHHZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6405
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
Cc: Daniel Wheeler <daniel.wheeler@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-09-21 17:20, Yunxiang Li wrote:
> manage_dm_interrupts disable/enable vblank using drm_crtc_vblank_off/on
> which causes drm_crtc_vblank_get in vrr_transition to fail, and later
> when drm_crtc_vblank_put is called the refcount on vblank will be messed
> up. Therefore move the call to after manage_dm_interrupts.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1247
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1380
> 
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
> ---
> v2: check the return code for calls that might fail and warn on them
> v3/v4: make the sequence closer to the original and remove redundant local variables
> v5: add bug tracking info
> 
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 55 +++++++++----------
>   1 file changed, 26 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index ece2003a74cc..97cc8ceaeea0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7484,15 +7484,15 @@ static void amdgpu_dm_handle_vrr_transition(struct dm_crtc_state *old_state,
>   		 * We also need vupdate irq for the actual core vblank handling
>   		 * at end of vblank.
>   		 */
> -		dm_set_vupdate_irq(new_state->base.crtc, true);
> -		drm_crtc_vblank_get(new_state->base.crtc);
> +		WARN_ON(dm_set_vupdate_irq(new_state->base.crtc, true) != 0);
> +		WARN_ON(drm_crtc_vblank_get(new_state->base.crtc) != 0);
>   		DRM_DEBUG_DRIVER("%s: crtc=%u VRR off->on: Get vblank ref\n",
>   				 __func__, new_state->base.crtc->base.id);
>   	} else if (old_vrr_active && !new_vrr_active) {
>   		/* Transition VRR active -> inactive:
>   		 * Allow vblank irq disable again for fixed refresh rate.
>   		 */
> -		dm_set_vupdate_irq(new_state->base.crtc, false);
> +		WARN_ON(dm_set_vupdate_irq(new_state->base.crtc, false) != 0);
>   		drm_crtc_vblank_put(new_state->base.crtc);
>   		DRM_DEBUG_DRIVER("%s: crtc=%u VRR on->off: Drop vblank ref\n",
>   				 __func__, new_state->base.crtc->base.id);
> @@ -8257,23 +8257,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   		mutex_unlock(&dm->dc_lock);
>   	}
>   
> -	/* Count number of newly disabled CRTCs for dropping PM refs later. */
> -	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
> -				      new_crtc_state, i) {
> -		if (old_crtc_state->active && !new_crtc_state->active)
> -			crtc_disable_count++;
> -
> -		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
> -		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
> -
> -		/* For freesync config update on crtc state and params for irq */
> -		update_stream_irq_parameters(dm, dm_new_crtc_state);
> -
> -		/* Handle vrr on->off / off->on transitions */
> -		amdgpu_dm_handle_vrr_transition(dm_old_crtc_state,
> -						dm_new_crtc_state);
> -	}
> -
>   	/**
>   	 * Enable interrupts for CRTCs that are newly enabled or went through
>   	 * a modeset. It was intentionally deferred until after the front end
> @@ -8283,16 +8266,29 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
>   		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
>   #ifdef CONFIG_DEBUG_FS
> -		bool configure_crc = false;
>   		enum amdgpu_dm_pipe_crc_source cur_crc_src;
>   #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
> -		struct crc_rd_work *crc_rd_wrk = dm->crc_rd_wrk;
> +		struct crc_rd_work *crc_rd_wrk;
> +#endif
> +#endif
> +		/* Count number of newly disabled CRTCs for dropping PM refs later. */
> +		if (old_crtc_state->active && !new_crtc_state->active)
> +			crtc_disable_count++;
> +
> +		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
> +		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
> +
> +		/* For freesync config update on crtc state and params for irq */
> +		update_stream_irq_parameters(dm, dm_new_crtc_state);
> +
> +#ifdef CONFIG_DEBUG_FS
> +#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
> +		crc_rd_wrk = dm->crc_rd_wrk;
>   #endif
>   		spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
>   		cur_crc_src = acrtc->dm_irq_params.crc_src;
>   		spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
>   #endif
> -		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
>   
>   		if (new_crtc_state->active &&
>   		    (!old_crtc_state->active ||
> @@ -8300,16 +8296,19 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   			dc_stream_retain(dm_new_crtc_state->stream);
>   			acrtc->dm_irq_params.stream = dm_new_crtc_state->stream;
>   			manage_dm_interrupts(adev, acrtc, true);
> +		}
> +		/* Handle vrr on->off / off->on transitions */
> +		amdgpu_dm_handle_vrr_transition(dm_old_crtc_state, dm_new_crtc_state);
>   
>   #ifdef CONFIG_DEBUG_FS
> +		if (new_crtc_state->active &&
> +		    (!old_crtc_state->active ||
> +		     drm_atomic_crtc_needs_modeset(new_crtc_state))) {
>   			/**
>   			 * Frontend may have changed so reapply the CRC capture
>   			 * settings for the stream.
>   			 */
> -			dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
> -
>   			if (amdgpu_dm_is_valid_crc_source(cur_crc_src)) {
> -				configure_crc = true;
>   #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
>   				if (amdgpu_dm_crc_window_is_activated(crtc)) {
>   					spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
> @@ -8321,12 +8320,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   					spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
>   				}
>   #endif
> -			}
> -
> -			if (configure_crc)
>   				if (amdgpu_dm_crtc_configure_crc_source(
>   					crtc, dm_new_crtc_state, cur_crc_src))
>   					DRM_DEBUG_DRIVER("Failed to configure crc source");
> +			}
>   #endif
>   		}
>   	}

Hi Yunxiang,

This patch lgtm:

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Daniel also tested it a few days ago in multiple ASICs and with IGT.

I already applied this change to amd-staging-drm-next.

Thanks.
Siqueira
