Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFD3C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 22:03:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F2BB10E03E;
	Tue, 11 Oct 2022 22:03:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8D9D10E03E
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 22:03:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpzX+cfWWu0H5TA2jlEOtcI8PBjalkwTYVh13odawGq8WJidpjuF0HdxrRONpB0VscYxeC5Fu0j9pxoS/3IWIYxUtp4Quu15XSfnIi/s6voaxGtZTmT+skdxvds2fvKg4pWwgn5fM9aqL7vFwd/Vfuiyi62T37rIW8oig9b2AYdH2wO/Od8JBohyudj+cppUTocCuKyo0dZEPWvhMd6Uqx6h8HiwzDa65APCuc/5u4w1I3bDbenuK//GwDZa8zQhQKh8X6mYqRlailt9Qz9f/xVp1KdM/dpmIdCuTQDBb04KwR+J32RRkFlm8vAJMYkPr7FJ+hebSy9Vn+8vfT3Rsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkNSy8S25nsCvbiRVphoCyK+tSgA3/k49BHCkfsFt+g=;
 b=G/MLznbm706G8tMfrPBWLIvCxrHuVhHFaPOZ5Y4WeqFDLi/64527j6/WusDs5Fe69LZuIIS9kUozu+v8S57GtVR5uLQyjQ1LFEhD3K+o94T1+N/0wr3keYzPQLh2eZo1mDeJtnKyQ/2NRI98zazlsDe4QnLoIcRoPFs1raQvp/WQP6kRQEYJFjSWYMaLQ6dTKWKTVM1tgxACQy7pLI7d/5qmFziMPsR1sdiA25stmNPS3IEDISXWb7Bk/g7V9KEMGxbyvN2u5ol7thcm4o3ECgunZzsRddtK5IjVDl2JTrVxEmCemI+33DoLxCZMRvOoIkWT87mKczc+Za7S0c4p+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkNSy8S25nsCvbiRVphoCyK+tSgA3/k49BHCkfsFt+g=;
 b=tK+qW6uzqsv864j47qvr4+BfkUP6J2gKyfNtKiOQxrTs9ihjvuXpkixxfppvQEiNhjfrv9jMGtKUzZJd6WWgntd7mCw4wv4qyNIo5lhmKnTqYUG0GU7NAcgGgjKkriHJDAhG4DsEIUiXdzmKXv/L53sE0BLsAjD++zbR+xvYRKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 22:03:15 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aef3:6aae:b904:e395]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aef3:6aae:b904:e395%6]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 22:03:14 +0000
Message-ID: <28a3aa2b-3ffd-4b71-d358-3b18acccde9c@amd.com>
Date: Tue, 11 Oct 2022 18:03:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 3/3] drm/amd/display: Move dc_state copy in commit_tail
 after dc_commit_state
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221011181140.94595-1-Rodrigo.Siqueira@amd.com>
 <20221011181140.94595-4-Rodrigo.Siqueira@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20221011181140.94595-4-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0184.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::27) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|BL1PR12MB5128:EE_
X-MS-Office365-Filtering-Correlation-Id: f7847f13-93b4-4cc2-757e-08daabd46523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PdDRyeO4a9+OnBaNB7nnqIETwD1eWy5VYXjmsQxoA74C0EjYTkHLAJNvxI4WWTE9zDWMfa0wA7eVPcHzjKBN4WvkAmTcuXj2D6hOHTGBqI7yoQbL07hyKAU0aLAnE96AwzNJDW2i+U2T8fRej4mG0tWLCX5R2mEkUxJm923pFCFZOmgbhpUW5Y7zpSagxzvOUMR06EJ8+rqt0d4ERqtAQWhAbiigPQL378FGTN71VrPRSbhR8905puJxN02kfi4lxs6pHTzJAeoXyV10tv3suNvS1BW5LtLb6ld8EfjU/hBL7lnCNSI/RaCz9YF3tQjRV/O8bge0kMDJKAJw3MJhfbMDx5m6PwkWf0Sgh4Cjwnsp4916n21OLlzBlb7gq3ClAc3bJkLc4YKw4mJQsKPwMzEnIrKlJnhZbOeIAE5hnsnnK7q/vc8Udj7W1ijphE53AKLjunvn/Jya9Bz7/cFgG+g1Xt8WwY8jg6TZXSsn+IO+o2XtGsC6JvZMyGHmS/m3jBOYrEd2BK03SrjrG0SAhEqPyD2QBAx+IcWZIAoyawlBDaLOMNrPeGu22UxwfcHif0otgBDufSHkYmKvVvNXEqo89JDhHF2dnl/3Xxi7P3XFmNMk03kVrbmUfzYYC4zqt5vr0TcGpjSVasEJnuw+B05akShJi+A2cKsjCDP/U3M+jhwBascWIFa9bIoCWLsHIxgKHEyo0qxHhth7HyLlVaTrhAesZ3IwTKRhqbq16CyNE3JPXv9MM6zm32gRsACfKez05VfhZKo3KLbFyqZJds4Gv/l6nnuI4sVu4DNLPk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199015)(31696002)(31686004)(38100700002)(36756003)(86362001)(2906002)(186003)(83380400001)(5660300002)(44832011)(2616005)(6512007)(66556008)(26005)(53546011)(6666004)(6506007)(8676002)(66946007)(66476007)(4326008)(54906003)(4001150100001)(41300700001)(316002)(478600001)(8936002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzhhQ1NSdmxDR1pKZGdBcFZlLzY5N3dNSDlJb2JSWHJoVityMSttQ1N4Wm9K?=
 =?utf-8?B?Qk1HWm1JbmpQV2tIbWsyN1lkRGZGNGgreDc1NkYrZ29nVC9yRjF3ZnZHMUFu?=
 =?utf-8?B?ZnNGVTdBWk1FcFhtZ0t5QUtjeExBczdpTXlXbEM3eFl0dG9MWWEySE9iUE0w?=
 =?utf-8?B?K0xjSzFBdk8yaTkyRmo4Nk1vME1ZNzlMWDFvZHVwY0V1VWhaRFVoTW5XT0ox?=
 =?utf-8?B?ZE42NlhTWnV4dCtvM2VuUHBqN0tsR3dCWDM2NVB0YUp0Y1h2UXp2STFzSnJz?=
 =?utf-8?B?Q1Q3NTlyOTF6MFd4ajZoTGNuU3g0cjRmenVQWVlKZlBiYTJLd3ErNkxaZklO?=
 =?utf-8?B?RzZNdTUxYlVJd2wwR2pYemRNaktSNG8vZElFUFBlcGdwd3RQOVZRK21zOVVV?=
 =?utf-8?B?a1ZCVUF5R0lMWGxjZ2Jna2ZkczFveWJ4emcxRWxBUEFkaVhoZ0llOHd2ZUty?=
 =?utf-8?B?R2czdXdFQnNXK080WGJsS2xiU2FhTHRmMWd1dkpLV3hEMUxYWlJHS25pWEFP?=
 =?utf-8?B?d1kzZU5YaExROFFzTGJiTGxtaG9kUzVKYjE0ZkRoMzIxQ1BjNXFOeUpQVmQ5?=
 =?utf-8?B?Rko0WHR1bitKZk5UQ1VKTVUwYWp6Q2FYS29TRE5KUit4M080N29FTHRGaHUx?=
 =?utf-8?B?Y2dvWW9relpJb3NSazdONGNWZmNFN1g5QVlOclh5d0RxM3d1SVFYdXNBZ1Y1?=
 =?utf-8?B?clRPVDllSFBjQUxYWDhjaGlPb1FkaEZSU0FKSDMzSGJxaVBCQms3ZWhTWldp?=
 =?utf-8?B?SkkrTWtYS1lpdG9iNTZkUlAyaVNzTkFNais3MUVCVnhCMDhzRzJYODFwVlk0?=
 =?utf-8?B?ZFc1S2VkbGVFYkNGNC9HUllERDFwZlhSNlpvaGhPa1Q1K0c1dyt6b3czYkd5?=
 =?utf-8?B?SFdQbXZMZUVwakRKZVJEVmJ2cG5TWTRHOE5xY0lTWDFUUFo1VDQ0T2UzVHhY?=
 =?utf-8?B?YzRSVWVxelRGS0VLS01vWlE1Q05tV1NtVzMrNWJ3bURNV09JUnBqbGN1NnZW?=
 =?utf-8?B?ZGRkVnM2ajU2eWZkNklJOThJaHhZeU5Rc2laZmYySjZvMWZPODR4WEN0ZXRy?=
 =?utf-8?B?NkZUY0JWR3oybWY3RE9lN2k2ZkhZc2VtZnVkemR2LzFVRUVpR00wcXVEa1Rs?=
 =?utf-8?B?Nm9XNUZGa2c1UUZWRlRPNG5GSnVrbXlVeDR5a3FpTDJnLzB6R3JmNGRrS2VD?=
 =?utf-8?B?bkdUcEp2Wkk0cFZDWWE0TDE5LytTT25qeWw5VXcwdE8vYkRzUldJN09CcWVS?=
 =?utf-8?B?bXM2bWJta3psa1lDWkl5aTVLZDRPcEQ5V3dJTkp6RHBjZU5DYTRNODdwNm9M?=
 =?utf-8?B?MEpRMjE2TDJidHV4aHpIZG0xd2lJd1Bhc3FJVVRGalRWR0tCSG1Tc2wwNDg0?=
 =?utf-8?B?Zy8wOEtSREhNem52c2pPY3J5a2xVenRrbDJYUlZxZ0NDMWZkUVVCbklxQVAr?=
 =?utf-8?B?ZlYxTVp1dEtnWmNUQ3ArS21IUU9jMlg3TjBxaDZrbXRibTRURis4OTRMOUpp?=
 =?utf-8?B?L0tDSTlYcTJPbXVPUDdsTHhpYUN1dzk0MTBNK1BRNWE5RkJaVDdIRmZVL0w5?=
 =?utf-8?B?R1l6c05sc3h4VFRsam8ySkRiRC9ZKzRjdjNadVI5UVBlZHdIT2hScHBQVzBZ?=
 =?utf-8?B?K2tpWkhpcnY5Wld6M2hRdFFsaUdlRUxldzRuQ2ducDUyWk5tRkkxVFpsYzlB?=
 =?utf-8?B?emZIdDZCNWRSTlBnWjA1UEFOQU5aMXFzYk5ZTCs3dG16SXVPTkwyblljSDJi?=
 =?utf-8?B?eitRQU9JSFZFNVVlRXJWWlU2MTk0SmsyeEwwQlU1K0psZnBkNE9zK3g1UzR4?=
 =?utf-8?B?eHRPWjlTUEl0STAyTXU0eEN4WXUveGJtUzNJNHI1bTlPaTBIZUtKTHZnMmd0?=
 =?utf-8?B?dUl6Q0dFRDArV1JXcWNkR0lZZi85djF2YjJaeDhaY1BKV253TWxzUmk0UWZF?=
 =?utf-8?B?N2xmSG9VU0Y4dllINmVQWk5zVzl0endsNG5zZHNqQkkyN1JNQy9iS2JDZUNV?=
 =?utf-8?B?ZFhmTTZaZGMwZldUV0RJK3RucnRHVXdweUJYUWZVL0NGcUNrUVdKQ0w0aTZn?=
 =?utf-8?B?YmU4S09GT0Fwc2xRaEs1ZlRndmlNemNLYWxwR3BJWnR6aGJFelVaQnJzU1Vs?=
 =?utf-8?Q?z5uvJsv6W1d8m3fHc1r1NyvVi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7847f13-93b4-4cc2-757e-08daabd46523
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 22:03:14.7241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvcsOodVyhknlMgmqGvOtwG64u6+U49L8/A9hdAkAorVfNUJSbCPCeBitbyIKIMMBGln6tcNUJ3iUZOgorYyqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-10-11 14:11, Rodrigo Siqueira wrote:
> From: Aurabindo Pillai <aurabindo.pillai@amd.com>
> 
> [Why&How]
> With the new commit sequence, we do not want the state to be copied before
> the call to dc_commit_state() since this leaks the phantom streams into
> new state.
> 

What are phantom streams? Why are they needed? Please elaborate.

> Fix this by doing the dc state copy right after the dc_commit_state()
> call.
> 
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 63f076a46260..17a9108f8186 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7999,15 +7999,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>  	drm_atomic_helper_update_legacy_modeset_state(dev, state);
>  
>  	dm_state = dm_atomic_get_new_state(state);
> -	if (dm_state && dm_state->context) {
> +	if (dm_state && dm_state->context)
>  		dc_state = dm_state->context;
> -	} else {
> -		/* No state changes, retain current state. */
> -		dc_state_temp = dc_create_state(dm->dc);
> -		ASSERT(dc_state_temp);
> -		dc_state = dc_state_temp;
> -		dc_resource_state_copy_construct_current(dm->dc, dc_state);
> -	}

If I understand this right this change means that when we do a
"fast" update we'll simply modify the existing dc_state directly,
instead of operating on a copy. Is this safe? Keep in mind that
calls in amdgpu_dm can be multi-threaded, unlike calls on other
OSes that use our driver.

In particular, it looks like dm_enable_per_frame_crtc_master_sync
is called on dc_state before the dc_lock is taken. Could this
lead to issues similar to the ones outlined by Nick in his commit
when he wrote this code: 
eb3dc8978596 ("drm/amd/display: Use private obj helpers for dm_atomic_state")

>  
>  	for_each_oldnew_crtc_in_state (state, crtc, old_crtc_state,
>  				       new_crtc_state, i) {
> @@ -8127,6 +8120,14 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>  		mutex_unlock(&dm->dc_lock);
>  	}
>  
> +	if (dc_state == NULL) {
> +		/* No state changes, retain current state. */
> +		dc_state_temp = dc_create_state(dm->dc);
> +		ASSERT(dc_state_temp);
> +		dc_state = dc_state_temp;
> +		dc_resource_state_copy_construct_current(dm->dc, dc_state);
> +	}
> +

Does moving this down serve a purpose other than the one to preserve
this code?

Moving this means that dc_commit_state (now delegating to
dc_commit_streams on some ASICs) is operating on dc->current_state
whereas dc_commit_updates_for_stream (now delegating to
dc_update_planes_and_stream on some ASICs) is operating on
the state copy, i.e. the local dc_state.

Is this really the intention? Will this make our lives easier or
harder? This code is already hard to parse. I fail to see how this
will improve that situation.

Harry

>  	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
>  		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
>  

