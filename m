Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14351C19F2B
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Aug 2022 20:39:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A84D911B1FF;
	Wed,  3 Aug 2022 20:39:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3CE914ABC1
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Aug 2022 20:39:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzreDODEd3LGuXEc60M6u8hrUpIQEMkmUZ/QSx95qVdCmHX/K6YRf6S7sZPz5GQ+oiIvMq7rQeHIud3hsN0uR1N5rp3tg5eKMtXqFluCuV4tDVxZuC03MkArUvwDon4EjMl1onrXPzQKoal+DXaDYCQnXSOBiRPwrDIlLlIzYvb6PxuHUmHWtqqIBbyq//NyUJTSWcqr21YHbTaLTwQhzPFwCVQZ5a6r6sT/YmnmxLfaoWr8ZPDMq+aZhP3xAVDt7MpttlGLkr95e3fL6iZ9fV/8f8EIpCuo1SU/fKudwntSIgv52+LNa1RZVTI5xde0I0A73s4NDSIy5d8e8II0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7mPjhbSsNRp1w10eGbEqUNNiw7VqFsFPRR8lYEiuTM=;
 b=UhZ42NoFbT694BGuzuMPqaoiEagETTuZen+DRMULDE4WSF2fTnzFE415KQkWN75H+4Wc6UjQDV5zMHzNPbc+qOYtWQpMU2NQPJzbcl56+1HCLjdmpkErC+TV7SyXvZ4Fbffw7hDhQ/0faYqy7Of4UQGrFd/FfQVR4ccCIpRb5F5sjFIJ+0nrqGDofDeRV3jZNGKKVjNNK/rElmUMyJuG091LCKOVnOIeuSP9T8kFdwNOHJE5nhmJHECKJiyl+Q2srmoJRi/dnFEXTUrvS40qnbejcgKD8H8Mq0wt+6mq+jXVYVEzlwMRed+ubHAMaMMtS4MJBP5B8JFYk6nMkMuJGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7mPjhbSsNRp1w10eGbEqUNNiw7VqFsFPRR8lYEiuTM=;
 b=aOX1Zsd4eayrkDNI8bWIm6HDZdjLy0cnTewY5kEqS2pMUcbcXuP+1dlFJydD4hu11D7bHMQtNgWk2OGtPV842eTTSVWNe366DISoeZyNPBXwx3BsSobUrdmO1JF5TIu1kzc/hANaCqPTinC7+LYjEdjowM4kEzI+p34aQreFlzA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MN2PR12MB3631.namprd12.prod.outlook.com (2603:10b6:208:c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Wed, 3 Aug
 2022 20:39:10 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6999:13c9:d124:418a]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6999:13c9:d124:418a%8]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 20:39:09 +0000
Message-ID: <3c88b234-d949-d8d4-287a-af8c2036787e@amd.com>
Date: Wed, 3 Aug 2022 16:39:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] drm/amd/display: Fix vblank refcount in vrr transition
Content-Language: en-US
To: Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 Mario Kleiner <mario.kleiner.de@gmail.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
References: <20220728134934.11434-1-Yunxiang.Li@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220728134934.11434-1-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::42)
 To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fd7335e-747d-455b-2e71-08da75903779
X-MS-TrafficTypeDiagnostic: MN2PR12MB3631:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EKcZTVKJpI65AK6LoGEWkbdaOrIxgwFfrI9ZgDuBBq3DTnKWXHtKK8JAXzWj9cTXsPV3FlgwUnPxK4VrOzq1mu++FHbFt3HB8xbnNHabeuJOUMjqNQWq04dFOPGh6K981+2+T7QNPoJjDwcx5JuzqBk5XxxR1H2XAYH5y2juxt0yULz66NnaW2yjMQjDJcDaobCExtK9BQFVYSkIM2ZaViVtlPhHNHraeJI7gpVWdvbposJFklaytcm9rQ8Nx/aDCXJcAvv0CnaeHTvxPHV1nYPK5zZXZRZJNfYJQT5PV3e+ePx9EWyTSSfT1C1eAEAQKDJTey97nR/qSqeGK/Jjp0OT+5iC/e/3pjO88Jbtlmz82fj8zgTC33nbuqJKV5IX8BqAgdWPGQLl8baDZW5Exn9b8AU1SfecJu6S4yXEA5r29Da64Zoawk2vF4+5V1gRM/pUFE8E/befy2Zrh/D4ik11pCTbGuw5OkknjiKb7sPp7qMEOtuOdCGtgAdpWfbDHW4MLhz2iWPHuaFMAWBQRt5ccAy+FXfN4Y2ek6u4agQOg3L5YybQ2m4uiwmdUChiYRqbmf9QpvIz3nj0CHWaohLH0wQIFexX5UwwMLRe/8GjdUOR9Erql2LpakEMTTz1l9nEkuck9w8/mMRgoiW0tirapoPxouFx8wiM7ymx8fnYyGhWgLGrwYPm2jOAZ7C+k39jv5cshmN0OOeSdF0y8c+cbZbKBl3iIxQ3LQ/Pdcf8EoSlZSj8VXb+vwPpcDlCxqFjMlI0QT2f6Csll6hqy2NU8FfLVEHylpezc0BsNkk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(6506007)(2906002)(8936002)(44832011)(31696002)(6512007)(53546011)(41300700001)(5660300002)(66556008)(316002)(66946007)(38100700002)(66476007)(6666004)(8676002)(478600001)(6636002)(83380400001)(36756003)(186003)(31686004)(26005)(110136005)(6486002)(966005)(2616005)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2p4VUlJOVpqSWZackZHZUo1bVBUN2ZSOGRCOW9aRysybDNHd1pTTFBMSjA5?=
 =?utf-8?B?WVV5U0tOVVpoTm1HRjBnK3lGSWxZMjZUUFMxK0ZhRWJkV25TZzZPY1pOeXYz?=
 =?utf-8?B?L0JieEFTMjNRUW4ycnBEUkM4N3BkSk5qdkp0RGFENXkvM3JnTW1RU2FXd0VB?=
 =?utf-8?B?ZlpnN1FJd1Y3b3R5V1hJMlpucHNTUDZVWXJ1eXVySzJZY1JsZkJrUkkwM1Zn?=
 =?utf-8?B?Y2JXRk1XSCtsOS9PZG55ZE1qcE94T0R2S1BKNFJpRitLNFF6VlFIS1dQZVVl?=
 =?utf-8?B?c2Npd2FQb0lLejdlTXBQclFZZE9uSCtZVzh2U3FiN0FPQithRkdqM0Q1Q3lw?=
 =?utf-8?B?QTU5SitzTUY0Y244K2JBWXFTdElZQ2tQQnZJck1VMjFJNnNyajg2emo3ay9G?=
 =?utf-8?B?eWgvVzNRSUJ6QWtCS0VJelpZM2loWTZxdXVweWpoTTVwWU1FMC9uSVNJNnht?=
 =?utf-8?B?WU9vSUV4L005eTA4TlNOekdEUmNhZWV5cXNmeXI2bUtBVVdRUzl1MzlJcVU2?=
 =?utf-8?B?VGNCTzF2eXU3R3pPMnE0L25lSHZ4SWFSSVh1NjVBMVpxTGl1Y3JsYnFGTFNm?=
 =?utf-8?B?YWNyc3NybUlPUWJVTzRhc3NTT0NSamZ2bjdFYXQ1WXpvUDdTVUpsYXczRnE1?=
 =?utf-8?B?ZHNhMlpIU002SG9NeTRzVkEzbWRVckFacGxTTVVYTTBDNkJnTHFmSGFmNDgy?=
 =?utf-8?B?NFdVVHpJY0padVFpbVVKWlNFKzdPaU5kdExpdU5Qak9pSDl1U2hxaDZjOVRh?=
 =?utf-8?B?cVpYMWZJdXV5Nk4rWHZEVytxYnoxa1Bnd2VOUFZZUTBPZnNDcWVjbEZEaHJV?=
 =?utf-8?B?a3c0M0NqZzRpY0Z0bDN2cWJXV0F0YlVYWUZFNnBnb3NITkllOUFlc0J0d1JG?=
 =?utf-8?B?ZU56Vmw0R0pQSWFRWFlleUxFOFVMQVJWakdWYVMxWXNtSXNpa1RtMUYrNGNh?=
 =?utf-8?B?TGd2Z0tubzB0c2ZzWC9UU2g5cjk1eXlNN3FHOTk2ZWNaSTI1YnVXTTErQ013?=
 =?utf-8?B?TzFXd2FMUnY3eVp6VXVucWJRSkl2aE8vMG0yVndMWjNEYUNKLzQyNXpPdkdi?=
 =?utf-8?B?ckVaNElGMmRhN3hWSWpOeEVOb1dXQ0dLczVtMTVVTml3Y0FWSjFkd0I5Z095?=
 =?utf-8?B?bVZ6NzNEbFhRUXNKWXV4aFdKck9xRlJYTk5VZ01YNzJLRGVUTHhFZ256SkZ5?=
 =?utf-8?B?T3B4SFBQUjUrVWFreWR3YWk0YWtzcHBHQzQveW45aVBXZmVESU9wdGRqMUY0?=
 =?utf-8?B?YjA0Q2hlUWxwNXNFWmxNNUlqdGhMYlBmUUxtWEdWMUVxUzhpY1I4S0hNeUN2?=
 =?utf-8?B?VEo0TmFGeGwzNXNiQzlrWHRVdXFzSkt0YklxcHRuNCs0bEVzbkFuWmFEWS9Z?=
 =?utf-8?B?UjFlRGRDSlF4bmRDYzkzZzU2MEpERDMvNks1TmxtU0RqRWcvcmdsYzJ3L2hS?=
 =?utf-8?B?ak0yNDZpVnV6blg1WVhwbll1cUNMcEpxL2xpeGtHWTZ6L1A2Rm83SDZaa2l3?=
 =?utf-8?B?aGhaOFVPQ1ZxcFlBWDlja1I3ZGtXeW9NcjBlVUk1NnE3UkU1V1pocXBiZ2ZP?=
 =?utf-8?B?MEREcGttREpCSXd6ajI2amRmdnN5UnoxaWJwQTJzYm9iS3dOUjFkam1wNDdm?=
 =?utf-8?B?NTV0WEZpOHRJdHJubVEwdFhNTXhyVFIvZ1FmOUZGNnpLa2cxVmxjZUxkbnNn?=
 =?utf-8?B?Skx2eXpESVgyMmFTUGdvaHpUVnoyYnZVdDVzTUFCTm5PdW1sMkdqTmU3ZVRt?=
 =?utf-8?B?UWlod1JqTW0xT0FGclg5WFUwTzI2anpubmQ2RlVIZy8zVEhPeTR2NGlVY2ti?=
 =?utf-8?B?dGhKbFdjMUNZdU9wRGc0T3RLQXlhUnpqR24zcVpzSXhYbVVMMWZsdmNBamJQ?=
 =?utf-8?B?OUliOEdTaU9hRkNza3NvSCtXVk1FbEc4NFMrSFEvdFZHRVlUanpFOXgyZmx4?=
 =?utf-8?B?NWZKb2VSM0pTdkZqbjFKSEloZ2kwU0tmcXZWMGdYVFlXU3kyaGRXcTVIdngw?=
 =?utf-8?B?d1J6aUlrK21oZnhVcWNXUm5uRUg3ZERGdkRkSUVGYnhJNHVwQzZTV2t2dmNQ?=
 =?utf-8?B?SS91eXpQTXpPb3ZyaXdmcW9Jb1VCaXJFWTB3dWhoUThnaVN6REtwMFZNY0tt?=
 =?utf-8?Q?fgAoH2dmbNSvwQJJMFbWTV8ZW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd7335e-747d-455b-2e71-08da75903779
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 20:39:09.4963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsI6h/Wt+pLNUXX2CPFndjSra7OqF0StEa5qRbZvPDNlef8iEO03TDesdecqQqiUpkFSDaneiPGRrLLI9a8XFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3631
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

On 2022-07-28 09:49, Yunxiang Li wrote:
> manage_dm_interrupts disable/enable vblank using drm_crtc_vblank_off/on
> which causes drm_crtc_vblank_get in vrr_transition to fail, and later
> when drm_crtc_vblank_put is called the refcount on vblank will be messed
> up. Therefore move the call to after manage_dm_interrupts.
> 
> Unchecked calls to drm_crtc_vblank_get seems to be common in other
> drivers as well so it may make sense to let get always succeed during
> modset, see
> https://lists.freedesktop.org/archives/dri-devel/2022-July/365589.html
> 

Thanks for this patch.

This change makes sense to me but I would love Mario and/or Nick to take
a look as well, if possible. Would prefer if we hold off on the merge and
give them a chance to chime in.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
> ---
> v2: check the return code for calls that might fail and warn on them	
> 
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 34 ++++++++-----------
>  1 file changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 92470a0e0262..9f3fdb92e7a4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7480,15 +7480,15 @@ static void amdgpu_dm_handle_vrr_transition(struct dm_crtc_state *old_state,
>  		 * We also need vupdate irq for the actual core vblank handling
>  		 * at end of vblank.
>  		 */
> -		dm_set_vupdate_irq(new_state->base.crtc, true);
> -		drm_crtc_vblank_get(new_state->base.crtc);
> +		WARN_ON(dm_set_vupdate_irq(new_state->base.crtc, true) != 0);
> +		WARN_ON(drm_crtc_vblank_get(new_state->base.crtc) != 0);
>  		DRM_DEBUG_DRIVER("%s: crtc=%u VRR off->on: Get vblank ref\n",
>  				 __func__, new_state->base.crtc->base.id);
>  	} else if (old_vrr_active && !new_vrr_active) {
>  		/* Transition VRR active -> inactive:
>  		 * Allow vblank irq disable again for fixed refresh rate.
>  		 */
> -		dm_set_vupdate_irq(new_state->base.crtc, false);
> +		WARN_ON(dm_set_vupdate_irq(new_state->base.crtc, false) != 0);
>  		drm_crtc_vblank_put(new_state->base.crtc);
>  		DRM_DEBUG_DRIVER("%s: crtc=%u VRR on->off: Drop vblank ref\n",
>  				 __func__, new_state->base.crtc->base.id);
> @@ -8252,23 +8252,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>  		mutex_unlock(&dm->dc_lock);
>  	}
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
>  	/**
>  	 * Enable interrupts for CRTCs that are newly enabled or went through
>  	 * a modeset. It was intentionally deferred until after the front end
> @@ -8287,7 +8270,15 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>  		cur_crc_src = acrtc->dm_irq_params.crc_src;
>  		spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
>  #endif
> +		/* Count number of newly disabled CRTCs for dropping PM refs later. */
> +		if (old_crtc_state->active && !new_crtc_state->active)
> +			crtc_disable_count++;
> +
>  		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
> +		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
> +
> +		/* For freesync config update on crtc state and params for irq */
> +		update_stream_irq_parameters(dm, dm_new_crtc_state);
>  
>  		if (new_crtc_state->active &&
>  		    (!old_crtc_state->active ||
> @@ -8324,6 +8315,9 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>  					DRM_DEBUG_DRIVER("Failed to configure crc source");
>  #endif
>  		}
> +
> +		/* Handle vrr on->off / off->on transitions */
> +		amdgpu_dm_handle_vrr_transition(dm_old_crtc_state, dm_new_crtc_state);
>  	}
>  
>  	for_each_new_crtc_in_state(state, crtc, new_crtc_state, j)

