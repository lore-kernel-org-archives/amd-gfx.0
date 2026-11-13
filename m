Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4A8606A333
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PdMR4Vjf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E51E112587;
	Fri, 13 Nov 2026 14:05:29 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ACBF112587
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 14:05:23 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c2af2ae1258so19443466b.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 06:05:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794578722; cv=none;
 d=google.com; s=arc-20260327;
 b=cCNmvNv8rkcfU4EJHxnZ8ewaC6oE4EG7R5kL0ODSFK91ODVIEY3Wz9d+OuG6FoMPQk
 xGC5JR9tQIAosCJpYE0rBWOzDXoYHVFTRZAKotQlP29xqjhN4ybs2HrvLmlaELxWP7QF
 fJyUDm1Rdk+q+J1eLL+pB/zHrZ46uHsdEXkFEM7i3bdK/JzBKoIW3ytPT1+5h5uDd57l
 yj85aNeqWuXhu49Igo9GyIUV5WGzN2M/lRmWsBOmG0+j6NnkbMQkL04eKLq2mMgf0I/N
 PKuOAZGJx4n1LppSeGodnaaizyluoUV7DGfwzoS1WjQA4DDAJ+Wscxd+GLZFhHB6YC2q
 cNgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DNr5TSnyeXCioTMiWAjRgZq6UDA4HuekgOMRX+0ndmc=;
 fh=Cm1/F7ESem6NxbFglEXRtZYC9eHozMEAds5QshQ4FU4=;
 b=Gr+1HpWF7K+51QfSdUOiofs8OoOYP0TF5ZpRU3S18Wc2o2qihhaJnhDawaGlUFR871
 BRwJBXp55wOUCqe3HgWiaDXqtlLWON4SjctqgyqAFXnVwqfBahKfM8p6xgS9DTjzh6xs
 bWEv26c7Fs7toyCd5nN1HnRgrsn0eiQAHdkWsWUegTc8Z+rnd2z8rgJrPrry6O4w5kA1
 6sL3GyC0/4dKbM74bKxJNHrIhuSfKPOGme4nb02lKl5cLnK44/38P1P4pkR0nHID+tcm
 94FNA8+O//xSSIAgFDfrpTDHxVHfhyoiliIMis1iBrViU0mvfnuxcgWJjBYshGANMwEN
 H0kA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794578722; x=1795183522; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DNr5TSnyeXCioTMiWAjRgZq6UDA4HuekgOMRX+0ndmc=;
 b=PdMR4Vjfewm5KoR4MAi9q0oGjZymppiWkG2EjFhQNitr0kWfsvOhw2L/odSImK3Gma
 NeVzv4dKqDesR/CrXumvLNeVUnb8augd0zKVV5CD05BUmnBGFKiaeKP7BuamqU6qLdmG
 SyZB2LlfHvoEC+6OZZJJmxfJC9b08XgIldIw44SEzarCkCv0blYjOhDVPgrMAgKe4w3A
 VzDhg2KUpsqoeGbNsazjFB+je5Hqdx/avF+SWR2FX/FWRbfYtVwMSFg/3dU1PQJGW65M
 l0xR4+L2zzYL6KXrjKZ4HrjdXM5NNfLWJ9WIHp20Imp/I7N7qVU7b6IuHFNT0FpByzXr
 I3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794578722; x=1795183522;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DNr5TSnyeXCioTMiWAjRgZq6UDA4HuekgOMRX+0ndmc=;
 b=Y1wbrJq1bxeqpSlP46EIwuS+LSliONkFzT0PGfIG7E0Ebhc5ce7G5jjbsggfclkWbu
 Uh8OlnpxE4Hnb9k9yH6mk1Aeldq74y5ut+SkRy0STzp8gjjMVCzGi0V5q8OPpFf0gZzJ
 yLn/bRAGFjAJmflMcEpUGBIrCKYnT+l4Kw810DUDbr33QHS67BVQa2xyeHEfaOVvhDvA
 CTzSSFp7yLrHwcCriY57FHuKa+vcJeO1xgNhq1noMy5OiGN17SEA27R1PzCIwQ2or+N4
 FXYw76p6pD+CjguJbSUV1EgvKT9TuTkpyHh0K9kx3Qy3nZtFTKXtlNLHI7P05kFgfCt8
 TUOA==
X-Gm-Message-State: APuU4Z9Y1PH5AcskkF44eEGV3IQVtSClk1/1wSigIWfTOPxC10Afp7Sy
 4U4BZbvcXxZnSdjjZ5K9dyuFIscB6vZtLFj2jFf+iI5FOlDwEvF7x2gAusS/z84RKriFu4o8BX/
 93wvxi5cEqLX+2ursb+y1UOps0hR5zKA=
X-Gm-Gg: AYBFou2pXRgBIhVFIUFra9PKvPU5tE4OxvKyDgmXPqjhdkHNTJcReWWC5k2JqX2nn1p
 nmc4lr0DpJTQ4Qjmp6khtgikGPLzZOTs/7u0mfTQJQp5ppiXG/YVr+WDq+zXo08edqxoggUBqR0
 rdQ+qREezRboJTJSNokcG9hqB6GBRYHwqEXiguJmcPnaaRyQx1qreSW0l5JbPtiYMFrGReTl9Sg
 AUVqf/0MRSBRAaZ2NYbuKlBFjy6q2mr0FpzhgDQ6RzLTjfLeZYzjD1jMxsdSazWIbqjV6CAdOOy
 FgitSQK168m1AjXq2KVS8iANnGfpnRyT3Hbhp8QjDKqndc7CF0an8j89YFstEnRWNy4hs/yni5I
 iUjqa6X7QE9SpXn1ryMNJ6lBByqReOJPXe9r7TvqcWrSA/QjJRCa/iMBM2ESCEs1nrVylPspfof
 hQLrO9joSZZj19wHb+S4IpNLfSCeNP6hLOelWnpmL5RH+wOpu+vM88Z6uS9YA=
X-Received: by 2002:a17:906:f183:b0:c2e:3698:dbba with SMTP id
 a640c23a62f3a-c509642ceeamr231259866b.4.1794578721566; Fri, 13 Nov 2026
 06:05:21 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <8eb61179-c5b8-41df-a466-8b5c388b6b41@gmail.com>
 <CADnq5_OrGuMJT4Tvt+wktPzTYEopdkCjyqq8sSdvJou40-HoKw@mail.gmail.com>
 <a6093dab-c38d-4dad-af3b-7173a6eaa78c@gmail.com>
 <CADnq5_MRA2bQG5x9xiGAT5ddh0jHMqg=u2OhCPvJxPr3ddTurA@mail.gmail.com>
 <b9f69d90-73ef-4a22-a347-0d70f014a7de@gmail.com>
In-Reply-To: <b9f69d90-73ef-4a22-a347-0d70f014a7de@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Nov 2026 09:05:03 -0500
X-Gm-Features: AclHuK-JbGhOW0X8f8QmVd6MttZ4a5YiYIvDhIqm2gvUw0T3yQw5z9xjNDXU7XI
Message-ID: <CADnq5_PZ3B863S238TkrGSubWa_VExySu9pkh5xDfrST11y5GQ@mail.gmail.com>
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

On Thu, Nov 12, 2026 at 7:15=E2=80=AFPM Richard Lane <richardlanedev@gmail.=
com> wrote:
>
> On 10/11/2026 19:59, Alex Deucher wrote:
> > On Tue, Nov 10, 2026 at 1:49=E2=80=AFPM Richard Lane <richardlanedev@gm=
ail.com> wrote:
> >>
> >> On 09/11/2026 20:34, Alex Deucher wrote:
> >>> On Mon, Nov 2, 2026 at 3:31=E2=80=AFAM Richard Lane <richardlanedev@g=
mail.com> wrote:
> >>>>
> >>>> When driving multiple displays or tiled panels with identical timing=
s
> >>>> (such as the two 2560x2880 tiles of an Apple 5K iMac panel), Display
> >>>> Core's program_timing_sync() aligns the CRTCs into a timing sync gro=
up
> >>>> in hardware during dc_commit_streams().
> >>>>
> >>>> However, on DCE < 12, Display Core leaves
> >>>> pp_display_cfg.all_displays_in_sync unset. Because PowerPlay is not
> >>>> informed that the streams have synchronized vertical blanking interv=
als,
> >>>> SMU7 prevents MCLK switching at idle or causes modeset underflows.
> >>>>
> >>>> If all active streams belong to the same timing sync group
> >>>> (timing_sync_info.group_size =3D=3D params.stream_count), report
> >>>> all_displays_in_sync =3D true to PowerPlay after committing the stre=
ams so
> >>>> SMU7 can safely downclock MCLK at idle.
> >>>>
> >>>
> >>> Looking at this a little deeper, the function bw_calcs() in
> >>> dce_calcs.c already calculates all_displays_in_sync using the helper
> >>> all_displays_in_sync().  Can you look into this and figure out why
> >>> that is not working as expected?  My concern with this patch is that
> >>> DCE and DCN have different logic for handling mclk switching so I'm
> >>> not sure it's safe to call dm_pp_apply_display_requirements() directl=
y
> >>> from common code.
> >>>
> >>> Thanks,
> >>>
> >>> Alex
> >>
> >> Moving it to dce_clk_mgr.c and using resource_are_streams_timing_synch=
ronizable() also works. Is that a solution?
> >
> > I think that would be preferred, but in general, why doesn't the
> > current flow I described work?  The function bw_calcs() dce_calcs.c
> > already calculates the all_displays_in_sync flag using the helper
> > all_displays_in_sync().  Is all_displays_in_sync() not checking
> > something properly or is the overall call timing wrong such that
> > all_displays_in_sync() can't properly calculate whether all of the
> > displays are synced at the point that it gets called?
> >
> > Alex
> >
>
> I think this could be limited to DCE 6,8,10 rather than DCE < 12 as in th=
ese
> cases DC uses dce100_validate_bandwdith() which doesn't call bw_calcs() a=
nd
> dce_pplib_apply_display_requirements() in dce_clk_mgr.c so
> pp_display_cfg->all_displays_in_sync is unset.

How about adding bw_calcs() to dce100_validate_bandwdith()?  Or if
there are issues there, just add the all_displays_in_sync() checks to
dce100_validate_bandwdith().

Alex

>
> Richard
>
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr=
.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> >> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> >> @@ -31,6 +31,7 @@
> >>  #include "dmcu.h"
> >>  #include "core_types.h"
> >>  #include "dal_asic_id.h"
> >> +#include "resource.h"
> >>
> >>  /*
> >>   * Currently the register shifts and masks in this file are used for =
dce100 and dce80
> >> @@ -319,8 +320,17 @@ static void dce_pplib_apply_display_requirements(
> >>         struct dc_state *context)
> >>  {
> >>         struct dm_pp_display_configuration *pp_display_cfg =3D &contex=
t->pp_display_cfg;
> >> +       int j;
> >>
> >>         dce110_fill_display_configs(context, pp_display_cfg);
> >> +       pp_display_cfg->all_displays_in_sync =3D pp_display_cfg->displ=
ay_count > 1;
> >> +       for (j =3D 1; j < context->stream_count; j++) {
> >> +               if (!resource_are_streams_timing_synchronizable(
> >> +                           context->streams[0], context->streams[j]))=
 {
> >> +                       pp_display_cfg->all_displays_in_sync =3D false=
;
> >> +                       break;
> >> +               }
> >> +       }
> >>
> >>         if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg,=
 sizeof(*pp_display_cfg)) !=3D  0)
> >>                 dm_pp_apply_display_requirements(dc->ctx, pp_display_c=
fg);
> >>
> >> Richard
> >>
> >>>
> >>>> Signed-off-by: Richard Lane <richardlanedev@gmail.com>
> >>>> ---
> >>>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++++
> >>>>  1 file changed, 10 insertions(+)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>>> index 74cd88d8d580..b4531383437e 100644
> >>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>>> @@ -4777,6 +4777,16 @@ static void amdgpu_dm_commit_streams(struct d=
rm_atomic_commit *state,
> >>>>         dc_exit_ips_for_hw_access(dm->dc);
> >>>>         WARN_ON(!dc_commit_streams(dm->dc, &params));
> >>>>
> >>>> +       if (params.stream_count > 1 &&
> >>>> +           dm->dc->current_state->stream_status[0].timing_sync_info=
.group_size =3D=3D
> >>>> +           params.stream_count) {
> >>>> +               struct dm_pp_display_configuration *pp_cfg =3D
> >>>> +                       &dm->dc->current_state->pp_display_cfg;
> >>>> +
> >>>> +               pp_cfg->all_displays_in_sync =3D true;
> >>>> +               dm_pp_apply_display_requirements(dm->dc->ctx, pp_cfg=
);
> >>>> +       }
> >>>> +
> >>>>         bool frl_stream_found =3D false;
> >>>>
> >>>>         for (i =3D 0; i < params.stream_count; i++) {
> >>>> --
> >>>> 2.55.0
> >>
>
