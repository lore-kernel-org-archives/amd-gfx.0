Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95541606A329
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Nov 2026 19:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hJ+c5smd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBC1B10E040;
	Sat, 14 Nov 2026 19:30:50 +0000 (UTC)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC37E10E27E
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 19:30:44 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-7f4dda21facso262858a34.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 11:30:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794684644; cv=none;
 d=google.com; s=arc-20260327;
 b=AFhezTMRN7EhtF4tdidndGKPTWRC+VX+1W9GbKCPfSfxia5l33c25sgNRdvF/bKdP/
 stYev6prQXI0SoZ2vvBdYHNqCUWdrVQkRw7MwB5dQN67wSlFc9qyv/NQHmtplhIgkryo
 9bxgJbi/O9zScO74EtQTqZ8C8Sxs469viu+x6OFKvdkxwZi1MOuRX+cq21uowUO++HQP
 NjOyBYNuNqOV60sONm+TsHIbHXOCayEIbkA6yp2FJIN/MRqhIgQOFULi5K3h8M8vrgZq
 3u/S1fKtWiM8HK2eP7nfxlTc0WsqGYisQ3mqS7bgi/nnIRS/SyhW4BIUlJiZx9chGUxe
 Qqjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ozUGgq3FlDQBKsPKBBbxJSLE1LvNcxvIXuIqXKlgpTk=;
 fh=Cm1/F7ESem6NxbFglEXRtZYC9eHozMEAds5QshQ4FU4=;
 b=GTlOupOF+SSlwkKC09v7u79tM12Hy3RoRAHnvh5+rogfV+JcrgQ40SrWueq2DFvKCK
 d3/+6AK2g4zkuzsMjCLwhgMkE6kkhdWfXxCe+RvjLR1+Sf5fBO8V32V1JYMCK6M7DZz6
 vF2HGV/7B8EDmF+j80xFskMi5ltOhGv30JjFg8O6EOKb8LfynWD+JB/EKxdfGIXl6W02
 84mgcA+sPm/58RM9j4w3dcQ6V+/6avoTTYHRVzYuMZxL8ZbSm7nDVT2eL6OHYRM6l3zZ
 YaAADNCnjA1c2NBrGrKE1nWY6FrjNL3gvvt9MRg+Bx7XQ5Ijdfmj/BEE4azC5y8GxUrp
 Nu5Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794684644; x=1795289444; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ozUGgq3FlDQBKsPKBBbxJSLE1LvNcxvIXuIqXKlgpTk=;
 b=hJ+c5smdMRtuTfdSHbXvfHE2M4dd9WQe60z0R1P7qh1lWQ1YFrqfzx/BRhWzNC1j6T
 i4P5Ea9YNpnb1XZyIWc4h5L9DB5aPalumfhneCjvvV2jWgWRG+bSi6F6vuXxDeE7NyR8
 9zT78g68FUjzDU8H1FUAx3tOZqT2S+0RUz+HWdS5oovHSYsIJ5pd9tX5FfLgyIRkz19u
 HJgfNDYnMix07cNqkttu+YlORsNbE+YGe7UZL6EUbC1PLimHuDr+bQMeRhzwnU54V4eg
 F44QADUXUdezjPwHn3gIStyPRcTbqoyDYRSHdLMiuHQ/7iHslS0DtzwtzYFbqAJLE4k3
 y04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794684644; x=1795289444;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ozUGgq3FlDQBKsPKBBbxJSLE1LvNcxvIXuIqXKlgpTk=;
 b=fvBbarrWELGeWGHDH0/58N1CreoXY9MCxUAarJviVZWDENojetFbTok6KnYmUHoFzU
 uCxDjwXbCDb8nF1bFxOM7vNMBfj4XuveJLc5wr9eP6hbvgmj+wVVa0VwGy7bQGylDA3X
 Ct682z6LSCoxVkw4ObZfGQrzOg3jGCjhwVR/d56PT01im4iHlr2Vv6KYQNYD/tUlFkeV
 OTL5AdK2X4PudtWRjPospJajCC04w1dtxjywqurn/sr2kp4lKBSWukssSrjUke1I9foK
 ZuahjLb2qQNDKJClSAH/c/e5o1FaXNEWwiJ+/86L+q6WGW+MiDHZ25W21Vlfyl5Zzojd
 E84g==
X-Gm-Message-State: APuU4Z/jqtT83Mf7Bxh9F4e2NTE+wRJiC5ASfcA8hAxH8BPvWFuzZrdo
 hrXEcAO0mqtx46hW0yTyVKNsMoiuRJz4NudUogYPqJHyjE0kaeMlGU9uwpUFKYPsz4hBt8BEMEE
 b/EOhZAf4NyHhevBJTJuUQtdA9vokBPc=
X-Gm-Gg: AYBFou0sgLIpqZESSY4eJmx9IOIGVQHeXA6zxb7ND0BL2TxFG11C/2XK1vxmSSXBQPp
 JQxEWyZC1ZukofLStBt+jQ2RN6cHaslN+haInOBkd39WelNEL1IYuYxLxq7G83qGfwYmho6spq8
 UWQliqO6uFLFHk5SHVcCva2mw6gjQ58HJswVjS0cIvxPzytwLf1ENhvBCARyZpBZHkYDvMQhkWC
 +JW9XRfoRZPVzOVTn4HSYBip51KMvRgycEpQJE51ASPJqies8s/APGCpP/xR5Blf7ZF4pAVMNFM
 3cMvp0Ven9i5+AwsSnpaW2BVN5KBkXm/RT65O3qqLScn2fnzEV9XlUfzKOsroGBKcGdfgw7ztWB
 +uL5X68h0Rxq9aAL+CIJv4eRVVWftk5yVDb18fKhFCm81DCs44zkDEZyVbjMIcW9MQw4f2bDOKP
 Rpm8fIIKW/Mhf83XAPwGVoGsOIZucrCdnYoSFGRnL2yuiB9e3b0IN1KEl8/vKQ
X-Received: by 2002:a05:6808:3509:b0:55c:836:5992 with SMTP id
 5614622812f47-56e64df328emr7649759b6e.4.1794684643579; Sat, 14 Nov 2026
 11:30:43 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <8eb61179-c5b8-41df-a466-8b5c388b6b41@gmail.com>
 <CADnq5_OrGuMJT4Tvt+wktPzTYEopdkCjyqq8sSdvJou40-HoKw@mail.gmail.com>
 <a6093dab-c38d-4dad-af3b-7173a6eaa78c@gmail.com>
 <CADnq5_MRA2bQG5x9xiGAT5ddh0jHMqg=u2OhCPvJxPr3ddTurA@mail.gmail.com>
 <b9f69d90-73ef-4a22-a347-0d70f014a7de@gmail.com>
 <CADnq5_PZ3B863S238TkrGSubWa_VExySu9pkh5xDfrST11y5GQ@mail.gmail.com>
 <5c3aeee1-1436-4b77-b742-ba916376b479@gmail.com>
In-Reply-To: <5c3aeee1-1436-4b77-b742-ba916376b479@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sat, 14 Nov 2026 14:30:31 -0500
X-Gm-Features: AclHuK9Lt1BNNOh5THRY3gz36jwhtbUayWeg1u0J9Xol-AhZnO5UPrOXyZlFtp0
Message-ID: <CADnq5_NfuE_ck3VN7c6b0xgcKrYPonjPV9zdq50aMnVddm7Rxw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/amd/display: report synced displays to
 PowerPlay for MCLK switch
To: Richard Lane <richardlanedev@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 14, 2026 at 9:18=E2=80=AFAM Richard Lane <richardlanedev@gmail.=
com> wrote:
>
> On 13/11/2026 14:05, Alex Deucher wrote:
> > On Thu, Nov 12, 2026 at 7:15=E2=80=AFPM Richard Lane <richardlanedev@gm=
ail.com> wrote:
> >>
> >> On 10/11/2026 19:59, Alex Deucher wrote:
> >>> On Tue, Nov 10, 2026 at 1:49=E2=80=AFPM Richard Lane <richardlanedev@=
gmail.com> wrote:
> >>>>
> >>>> On 09/11/2026 20:34, Alex Deucher wrote:
> >>>>> On Mon, Nov 2, 2026 at 3:31=E2=80=AFAM Richard Lane <richardlanedev=
@gmail.com> wrote:
> >>>>>>
> >>>>>> When driving multiple displays or tiled panels with identical timi=
ngs
> >>>>>> (such as the two 2560x2880 tiles of an Apple 5K iMac panel), Displ=
ay
> >>>>>> Core's program_timing_sync() aligns the CRTCs into a timing sync g=
roup
> >>>>>> in hardware during dc_commit_streams().
> >>>>>>
> >>>>>> However, on DCE < 12, Display Core leaves
> >>>>>> pp_display_cfg.all_displays_in_sync unset. Because PowerPlay is no=
t
> >>>>>> informed that the streams have synchronized vertical blanking inte=
rvals,
> >>>>>> SMU7 prevents MCLK switching at idle or causes modeset underflows.
> >>>>>>
> >>>>>> If all active streams belong to the same timing sync group
> >>>>>> (timing_sync_info.group_size =3D=3D params.stream_count), report
> >>>>>> all_displays_in_sync =3D true to PowerPlay after committing the st=
reams so
> >>>>>> SMU7 can safely downclock MCLK at idle.
> >>>>>>
> >>>>>
> >>>>> Looking at this a little deeper, the function bw_calcs() in
> >>>>> dce_calcs.c already calculates all_displays_in_sync using the helpe=
r
> >>>>> all_displays_in_sync().  Can you look into this and figure out why
> >>>>> that is not working as expected?  My concern with this patch is tha=
t
> >>>>> DCE and DCN have different logic for handling mclk switching so I'm
> >>>>> not sure it's safe to call dm_pp_apply_display_requirements() direc=
tly
> >>>>> from common code.
> >>>>>
> >>>>> Thanks,
> >>>>>
> >>>>> Alex
> >>>>
> >>>> Moving it to dce_clk_mgr.c and using resource_are_streams_timing_syn=
chronizable() also works. Is that a solution?
> >>>
> >>> I think that would be preferred, but in general, why doesn't the
> >>> current flow I described work?  The function bw_calcs() dce_calcs.c
> >>> already calculates the all_displays_in_sync flag using the helper
> >>> all_displays_in_sync().  Is all_displays_in_sync() not checking
> >>> something properly or is the overall call timing wrong such that
> >>> all_displays_in_sync() can't properly calculate whether all of the
> >>> displays are synced at the point that it gets called?
> >>>
> >>> Alex
> >>>
> >>
> >> I think this could be limited to DCE 6,8,10 rather than DCE < 12 as in=
 these
> >> cases DC uses dce100_validate_bandwdith() which doesn't call bw_calcs(=
) and
> >> dce_pplib_apply_display_requirements() in dce_clk_mgr.c so
> >> pp_display_cfg->all_displays_in_sync is unset.
> >
> > How about adding bw_calcs() to dce100_validate_bandwdith()?  Or if
> > there are issues there, just add the all_displays_in_sync() checks to
> > dce100_validate_bandwdith().
> >
> > Alex
> >
>
> bw_calcs() itself cannot be called in dce100_validate_bandwidth() because
> bw_calcs_init() only initializes dc->bw_dceip and dc->bw_vbios on DCE
> 11.0, 11.2, and 12.0.
>
> However, adding the all_displays_in_sync check directly to
> dce100_validate_bandwidth() (which is shared by DCE 6, 8, and 10) and
> copying context->bw_ctx.bw.dce.all_displays_in_sync to
> pp_display_cfg->all_displays_in_sync in
> dce_pplib_apply_display_requirements() works. Is this solution preferable=
?

Yes, this looks great.  Thanks for reworking it.

Alex

>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c =
b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> @@ -320,6 +320,9 @@ static void dce_pplib_apply_display_requirements(
>  {
>         struct dm_pp_display_configuration *pp_display_cfg =3D &context->=
pp_display_cfg;
>
> +       pp_display_cfg->all_displays_in_sync =3D
> +               context->bw_ctx.bw.dce.all_displays_in_sync;
> +
>         dce110_fill_display_configs(context, pp_display_cfg);
>
>         if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, si=
zeof(*pp_display_cfg)) !=3D  0)
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
> --- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
> @@ -692,6 +692,14 @@ enum dc_status dce100_validate_bandwidth(
>                 /* TODO implement when needed but for now hardcode max va=
lue*/
>                 context->bw_ctx.bw.dce.dispclk_khz =3D 681000;
>                 context->bw_ctx.bw.dce.yclk_khz =3D 250000 * MEMORY_TYPE_=
MULTIPLIER_CZ;
> +               context->bw_ctx.bw.dce.all_displays_in_sync =3D context->=
stream_count > 1;
> +               for (i =3D 1; i < context->stream_count; i++) {
> +                       if (!resource_are_streams_timing_synchronizable(
> +                                   context->streams[0], context->streams=
[i])) {
> +                               context->bw_ctx.bw.dce.all_displays_in_sy=
nc =3D false;
> +                               break;
> +                       }
> +               }
>         } else {
>                 /* On DCE 6.0 and 6.4 the PLL0 is both the display engine=
 clock and
>                  * the DP clock, and shouldn't be turned off. Just select=
 the display
> @@ -703,6 +711,7 @@ enum dc_status dce100_validate_bandwidth(
>                         context->bw_ctx.bw.dce.dispclk_khz =3D 0;
>
>                 context->bw_ctx.bw.dce.yclk_khz =3D 0;
> +               context->bw_ctx.bw.dce.all_displays_in_sync =3D false;
>         }
>
>         return DC_OK;
>
> Richard
>
> >>
> >> Richard
> >>
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_m=
gr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> >>>> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> >>>> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> >>>> @@ -31,6 +31,7 @@
> >>>>  #include "dmcu.h"
> >>>>  #include "core_types.h"
> >>>>  #include "dal_asic_id.h"
> >>>> +#include "resource.h"
> >>>>
> >>>>  /*
> >>>>   * Currently the register shifts and masks in this file are used fo=
r dce100 and dce80
> >>>> @@ -319,8 +320,17 @@ static void dce_pplib_apply_display_requirement=
s(
> >>>>         struct dc_state *context)
> >>>>  {
> >>>>         struct dm_pp_display_configuration *pp_display_cfg =3D &cont=
ext->pp_display_cfg;
> >>>> +       int j;
> >>>>
> >>>>         dce110_fill_display_configs(context, pp_display_cfg);
> >>>> +       pp_display_cfg->all_displays_in_sync =3D pp_display_cfg->dis=
play_count > 1;
> >>>> +       for (j =3D 1; j < context->stream_count; j++) {
> >>>> +               if (!resource_are_streams_timing_synchronizable(
> >>>> +                           context->streams[0], context->streams[j]=
)) {
> >>>> +                       pp_display_cfg->all_displays_in_sync =3D fal=
se;
> >>>> +                       break;
> >>>> +               }
> >>>> +       }
> >>>>
> >>>>         if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cf=
g, sizeof(*pp_display_cfg)) !=3D  0)
> >>>>                 dm_pp_apply_display_requirements(dc->ctx, pp_display=
_cfg);
> >>>>
> >>>> Richard
> >>>>
> >>>>>
> >>>>>> Signed-off-by: Richard Lane <richardlanedev@gmail.com>
> >>>>>> ---
> >>>>>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++++
> >>>>>>  1 file changed, 10 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>>>>> index 74cd88d8d580..b4531383437e 100644
> >>>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>>>>> @@ -4777,6 +4777,16 @@ static void amdgpu_dm_commit_streams(struct=
 drm_atomic_commit *state,
> >>>>>>         dc_exit_ips_for_hw_access(dm->dc);
> >>>>>>         WARN_ON(!dc_commit_streams(dm->dc, &params));
> >>>>>>
> >>>>>> +       if (params.stream_count > 1 &&
> >>>>>> +           dm->dc->current_state->stream_status[0].timing_sync_in=
fo.group_size =3D=3D
> >>>>>> +           params.stream_count) {
> >>>>>> +               struct dm_pp_display_configuration *pp_cfg =3D
> >>>>>> +                       &dm->dc->current_state->pp_display_cfg;
> >>>>>> +
> >>>>>> +               pp_cfg->all_displays_in_sync =3D true;
> >>>>>> +               dm_pp_apply_display_requirements(dm->dc->ctx, pp_c=
fg);
> >>>>>> +       }
> >>>>>> +
> >>>>>>         bool frl_stream_found =3D false;
> >>>>>>
> >>>>>>         for (i =3D 0; i < params.stream_count; i++) {
> >>>>>> --
> >>>>>> 2.55.0
> >>>>
> >>
>
