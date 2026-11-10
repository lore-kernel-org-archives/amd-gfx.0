Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D25606A325
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 19:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DGfzMV5g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DAFC10E1D7;
	Tue, 10 Nov 2026 19:59:31 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15B2D10E34D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 19:59:25 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3b083afebe4so243927a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 11:59:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794340764; cv=none;
 d=google.com; s=arc-20260327;
 b=lgrW8qdTY3bf3i/WKG0g0y2BJc38i9tpOTzoOUjRHIyvxlQi4WDaMW9+qB0wJGKeTY
 sQJDV6/8YKFbQH8aNLxPlDAWKVHeZkKtxJjjx5++Spp8pGepxllKxLRMdGzoxhM4I/w7
 oh/kkMoad9rUIQ8Gxatl20wIvrCZ7T9jf30JRMtOHWWbB1rU3LyYIqDdYR7qLTqui80V
 90/E9HLzuzMKSsFQ6Nk2rZYBCKubxRaR/q93wQGmShfW3QioaXVe6kwSEI79hhfzpGya
 09LlNQzNO6DYG4t1qWQdMWpg51YRQ0JlU0iu8OXPf+LrIYvB1DUbGZTWw24ZQZTri1kS
 lNuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5Nlz5a5EqJZ1B0jGIvjBXTPfp8CkOF6iXGCRont2Aco=;
 fh=Cm1/F7ESem6NxbFglEXRtZYC9eHozMEAds5QshQ4FU4=;
 b=IWhdNLjeKVpQNJUjD/Bbcu6JWycL9SP08KjgckC5/Kz5Ho2XCKFdYNaaDjf2cBlrcW
 gN/G8AP/lctBGmHZwEpn51vb35TXNPX3vPrT60LgRY2ig00RWN9CwTv37i6XpxgETkMP
 TeOCIlH1PZ5Lk8IDMENcw/GO1s19teJGbNc4iK039xg1JbnevSTowTdLrLm8sdUwhL5x
 4PUZ/0wLB75DbHzU1GQxZdS8Qzo8vYey94KR8a56cJClqF25RopRebhIggTSwkJL/pi3
 /qhAjzIkMX8lTR3xkoPahP/0uFCjXLwIF6A6Ss0j7lR3hJ6Kw/3AUiTDxXitQn+nxWT1
 M7bQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794340764; x=1794945564; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5Nlz5a5EqJZ1B0jGIvjBXTPfp8CkOF6iXGCRont2Aco=;
 b=DGfzMV5ggKl06O2ixBO9lzcHnc1yU/WdlarwJWMLu5GDbZJzkYqO/BPfMX0RRHn6AE
 jdWBHsDxATcnpaQowgOYAi3CpRMIoSnJRELeZ7wk8cUJK60eZwSm23JocV8fJuRcitgv
 yqYCTC0EvcugwMuYuItAMmpo9JTYTR2MYtTs8tdbD4M3LtgTSMCR0+geZoHGcf1YnnnZ
 uFYY41fgYHFrLUJYxb1vFKJdAQrS0bqOSUuEICoafw+74PY1F9cDa3To2LwnJhST6ezZ
 jg/X8kU44fVCWB3itGSopNEad8XNAS++CHG22GnYcWF9KnQI8uive5zMYVwTP29+1c4E
 /kpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794340764; x=1794945564;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5Nlz5a5EqJZ1B0jGIvjBXTPfp8CkOF6iXGCRont2Aco=;
 b=AwaygPsFhaxK9TgRH5iJ4gUutPD6QTQw42pzLjH1buHdPLNFajRzo06nwmWD6SQ2uT
 BvYSNplvJIRsAr4wgdHeeHUViswbpBxsyi6gC/KRYAzDIUBcS5RrrCNQLqZPL54ot9N9
 4TDdmx/Kgs5gzfLtqLKeSnnzajK08Alv3CAjo59iI4ayuoGfftSrYMDCtHrkPD4SL7Lk
 0OIOI8htDwSMiiMuc7kICCvX+ZiIRvFmcnoy9I1AUh3Pgfu/q6HfXeFFbJH/5HJIkEex
 FADrbbXGux+5IV0hzdrpGA/jNWdpp3oGawFN0lTDmG+FiPuD6xWzR6Uz1XV9a8e1UYQy
 Mhaw==
X-Gm-Message-State: APuU4Z8mRNlz5IfHTxpqmiMdnkaSrPDpswzm/cRRU7ZxJieSU3frQ6Lr
 7uXSWk6RxfhxNL7oh02b4c6/4SRFfye+arUfWhVP/N3d2Xxp4mGbsaB+kw5Y/czbCppxusaU9UA
 hehdiuJutyHoib+qiRWhRNpH7GYxoksHLYDCb
X-Gm-Gg: AYBFou3DeQD4Mk4fXzKbgswSe6b/SogAiGOec3wCP+wUI3zUKPELt/a3Lr0lek2Fz7s
 bJlWutGANRBlAGq2//DiD6MYsML4QnSymsKJQeVp9Yle56lrIMWB3JTmLA2NmpVeL3U4fvmPK5w
 hsnfcaaGqgKf/3tCUB32sY1cA2ZiPq3MBLvWGPZiQC2FPEBn4NQF3cEYacNxdWO84Y+U5y/5AZM
 Oa6nhX7skk7ZsKY36LwYACdWMuEcMOXjwW28dqnLAenpbTMLTy6XZk5w1b8WNG4Cc0SwzY9ehUt
 EQhh817J8glcwwmVNg/YXpU19MbJjR2XR/D4on+hB0qTCffqzkZ2UHcNsOPxHGYrBFv7IFE/UAs
 cLLAM9IfAAcIO2N/D65e/Us8IJMp7esqpW/hKjY5X9WGCvnqvoAPOJkJMArFQRRPzfMweNHS/K9
 axd+CtkQAS0i8Nh+igXvnDgsbTnkD+B2BQlCfv8tUGXeJHOYGK7gZ3S8cEOsQ=
X-Received: by 2002:a17:90b:4b84:b0:3b0:9984:18c6 with SMTP id
 98e67ed59e1d1-3b182f14e41mr40487a91.3.1794340764427; Tue, 10 Nov 2026
 11:59:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <8eb61179-c5b8-41df-a466-8b5c388b6b41@gmail.com>
 <CADnq5_OrGuMJT4Tvt+wktPzTYEopdkCjyqq8sSdvJou40-HoKw@mail.gmail.com>
 <a6093dab-c38d-4dad-af3b-7173a6eaa78c@gmail.com>
In-Reply-To: <a6093dab-c38d-4dad-af3b-7173a6eaa78c@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Nov 2026 14:59:13 -0500
X-Gm-Features: AclHuK9OzrGAjIUTVR5CQZwX7f-zGWFe7vL5DtJpWEOYzcy9aOUsEMrpOSQAIqo
Message-ID: <CADnq5_MRA2bQG5x9xiGAT5ddh0jHMqg=u2OhCPvJxPr3ddTurA@mail.gmail.com>
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

On Tue, Nov 10, 2026 at 1:49=E2=80=AFPM Richard Lane <richardlanedev@gmail.=
com> wrote:
>
> On 09/11/2026 20:34, Alex Deucher wrote:
> > On Mon, Nov 2, 2026 at 3:31=E2=80=AFAM Richard Lane <richardlanedev@gma=
il.com> wrote:
> >>
> >> When driving multiple displays or tiled panels with identical timings
> >> (such as the two 2560x2880 tiles of an Apple 5K iMac panel), Display
> >> Core's program_timing_sync() aligns the CRTCs into a timing sync group
> >> in hardware during dc_commit_streams().
> >>
> >> However, on DCE < 12, Display Core leaves
> >> pp_display_cfg.all_displays_in_sync unset. Because PowerPlay is not
> >> informed that the streams have synchronized vertical blanking interval=
s,
> >> SMU7 prevents MCLK switching at idle or causes modeset underflows.
> >>
> >> If all active streams belong to the same timing sync group
> >> (timing_sync_info.group_size =3D=3D params.stream_count), report
> >> all_displays_in_sync =3D true to PowerPlay after committing the stream=
s so
> >> SMU7 can safely downclock MCLK at idle.
> >>
> >
> > Looking at this a little deeper, the function bw_calcs() in
> > dce_calcs.c already calculates all_displays_in_sync using the helper
> > all_displays_in_sync().  Can you look into this and figure out why
> > that is not working as expected?  My concern with this patch is that
> > DCE and DCN have different logic for handling mclk switching so I'm
> > not sure it's safe to call dm_pp_apply_display_requirements() directly
> > from common code.
> >
> > Thanks,
> >
> > Alex
>
> Moving it to dce_clk_mgr.c and using resource_are_streams_timing_synchron=
izable() also works. Is that a solution?

I think that would be preferred, but in general, why doesn't the
current flow I described work?  The function bw_calcs() dce_calcs.c
already calculates the all_displays_in_sync flag using the helper
all_displays_in_sync().  Is all_displays_in_sync() not checking
something properly or is the overall call timing wrong such that
all_displays_in_sync() can't properly calculate whether all of the
displays are synced at the point that it gets called?

Alex

>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c =
b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> @@ -31,6 +31,7 @@
>  #include "dmcu.h"
>  #include "core_types.h"
>  #include "dal_asic_id.h"
> +#include "resource.h"
>
>  /*
>   * Currently the register shifts and masks in this file are used for dce=
100 and dce80
> @@ -319,8 +320,17 @@ static void dce_pplib_apply_display_requirements(
>         struct dc_state *context)
>  {
>         struct dm_pp_display_configuration *pp_display_cfg =3D &context->=
pp_display_cfg;
> +       int j;
>
>         dce110_fill_display_configs(context, pp_display_cfg);
> +       pp_display_cfg->all_displays_in_sync =3D pp_display_cfg->display_=
count > 1;
> +       for (j =3D 1; j < context->stream_count; j++) {
> +               if (!resource_are_streams_timing_synchronizable(
> +                           context->streams[0], context->streams[j])) {
> +                       pp_display_cfg->all_displays_in_sync =3D false;
> +                       break;
> +               }
> +       }
>
>         if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, si=
zeof(*pp_display_cfg)) !=3D  0)
>                 dm_pp_apply_display_requirements(dc->ctx, pp_display_cfg)=
;
>
> Richard
>
> >
> >> Signed-off-by: Richard Lane <richardlanedev@gmail.com>
> >> ---
> >>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> index 74cd88d8d580..b4531383437e 100644
> >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> @@ -4777,6 +4777,16 @@ static void amdgpu_dm_commit_streams(struct drm=
_atomic_commit *state,
> >>         dc_exit_ips_for_hw_access(dm->dc);
> >>         WARN_ON(!dc_commit_streams(dm->dc, &params));
> >>
> >> +       if (params.stream_count > 1 &&
> >> +           dm->dc->current_state->stream_status[0].timing_sync_info.g=
roup_size =3D=3D
> >> +           params.stream_count) {
> >> +               struct dm_pp_display_configuration *pp_cfg =3D
> >> +                       &dm->dc->current_state->pp_display_cfg;
> >> +
> >> +               pp_cfg->all_displays_in_sync =3D true;
> >> +               dm_pp_apply_display_requirements(dm->dc->ctx, pp_cfg);
> >> +       }
> >> +
> >>         bool frl_stream_found =3D false;
> >>
> >>         for (i =3D 0; i < params.stream_count; i++) {
> >> --
> >> 2.55.0
>
