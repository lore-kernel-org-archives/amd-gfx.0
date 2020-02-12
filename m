Return-Path: <SRS0=l6GN=4A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E856FC2BA83
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 16:05:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D3920873
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 16:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIJxmXgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D3920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 714E56E093;
	Wed, 12 Feb 2020 16:05:09 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2403B6E093
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2020 16:05:09 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id c9so3035006wrw.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2020 08:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3tiu2yzFwd6lLUhDm1VaOqaYsSHX0Bm+TyVbH/yBgwA=;
 b=UIJxmXggTHNtitbYpT3bIj2qUGunivh+TM7VTi58ldStH/nGTcn3TYHHzcDe8t/0nA
 X+lURLdc5HtRwsxgUWG637VZHwfJ5EIqZq+4BbPHOKHFKAebOouBz8jS54frgHxHvV+W
 gHxIHdLjXxkflxo+LHS9MIFtM4GXV1oIiV+/ZosjRfm315JRKS6twJ5OvC6tjVDyOCQ/
 0BgzASK/PFOiWb91zU4t7l9n0OykvzlamPirw2weoKUiZgGQ8HjTnLbmXP8U1JunFoNn
 Yoj06GB6hrQxXNQ38Pg73SCUui1Pv7mFDezLef2BMcv42MKDqF5U1NlJWsyZ+0ANZQVy
 McWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3tiu2yzFwd6lLUhDm1VaOqaYsSHX0Bm+TyVbH/yBgwA=;
 b=s9Kdpi8cCCmvwdh1YdQD2M6bP0V75etzEjt1kjFDm3Jgep+UxHnLXyH89Ub352vQ0S
 cNgOo01vbTJkEr8gI6TV5Gn1vl6jL+mZtoxI6ubGURaM13fH6Lo4X7OgAF3MAM4iapkw
 U7r6VCGmmqqs7qYEU8e3to9G1uPQ51MttpPkYG7VWfFmTa+ga3zNAPZ57oH8QWZCswgL
 HwLCtyegojuPCQ7S1PvFWqVe6Q581/Sn3p+IGvjy5RvpgchMsf4F1/OycmKgUvYujqxA
 vQlPYqYiuQy0wg6mH/8anL2ZbEBiezbtltNaZpbbnOJCX5G84OXT2YeAZ8wV7uoH/osD
 L1Ug==
X-Gm-Message-State: APjAAAVJK7bN8d15m5DbNR/KKIZ5CIgXA3IfUWMQYpvkcJYCHUH0SWma
 InAKkusmYvKP2k4RJlHIEEyTb+UztuRAHsYi/fk=
X-Google-Smtp-Source: APXvYqxML5gw6wO+18xZE3SqC7w9uX8y6mwA/SVRJGnrEPAcpmV2tXNiY4MbzL9UnqNMuuXZeHRByxO5dHwNiFTYsNM=
X-Received: by 2002:a05:6000:1183:: with SMTP id
 g3mr16237964wrx.374.1581523507804; 
 Wed, 12 Feb 2020 08:05:07 -0800 (PST)
MIME-Version: 1.0
References: <20200212043258.1123758-1-alexander.deucher@amd.com>
 <20200212043258.1123758-3-alexander.deucher@amd.com>
 <DM5PR1201MB2554165EB95580B5B5E20FDD9E1B0@DM5PR1201MB2554.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR1201MB2554165EB95580B5B5E20FDD9E1B0@DM5PR1201MB2554.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Feb 2020 11:04:56 -0500
Message-ID: <CADnq5_OuXJeX7mxm_6oCzApKs-K_6Z+eLYH4=d2h88hR77xqkw@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu/display move get_num_odm_splits() into
 dc_resource.c
To: "Liu, Zhan" <Zhan.Liu@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 12, 2020 at 10:58 AM Liu, Zhan <Zhan.Liu@amd.com> wrote:
>
> Please find my reply inline.
>
> Thanks,
> Zhan
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> > Deucher
> > Sent: 2020/February/11, Tuesday 11:33 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: [PATCH 3/3] drm/amdgpu/display move get_num_odm_splits() into
> > dc_resource.c
> >
> > It's used by more than just DCN2.0.  Fixes missing symbol when amdgpu is
> > built without DCN support.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  .../gpu/drm/amd/display/dc/core/dc_resource.c    | 16 ++++++++++++++++
> >  .../drm/amd/display/dc/dcn20/dcn20_resource.c    | 16 ----------------
> >  .../drm/amd/display/dc/dcn20/dcn20_resource.h    |  1 -
> >  drivers/gpu/drm/amd/display/dc/inc/resource.h    |  3 +++
> >  4 files changed, 19 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > index c02e5994d32b..572ce3842535 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > @@ -532,6 +532,22 @@ static inline void get_vp_scan_direction(
> >               *flip_horz_scan_dir = !*flip_horz_scan_dir;  }
> >
> > +int get_num_odm_splits(struct pipe_ctx *pipe) {
> > +     int odm_split_count = 0;
> > +     struct pipe_ctx *next_pipe = pipe->next_odm_pipe;
> > +     while (next_pipe) {
> > +             odm_split_count++;
> > +             next_pipe = next_pipe->next_odm_pipe;
> > +     }
> > +     pipe = pipe->prev_odm_pipe;
> > +     while (pipe) {
> > +             odm_split_count++;
> > +             pipe = pipe->prev_odm_pipe;
> > +     }
> > +     return odm_split_count;
> > +}
> > +
> >  static void calculate_split_count_and_index(struct pipe_ctx *pipe_ctx, int
> > *split_count, int *split_idx)  {
> >       *split_count = get_num_odm_splits(pipe_ctx); diff --git
> > a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> > b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> > index 39026df56fa6..1061faccec9c 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> > @@ -1861,22 +1861,6 @@ void
> > dcn20_populate_dml_writeback_from_context(
> >
> >  }
> >
> > -int get_num_odm_splits(struct pipe_ctx *pipe) -{
> > -     int odm_split_count = 0;
> > -     struct pipe_ctx *next_pipe = pipe->next_odm_pipe;
> > -     while (next_pipe) {
> > -             odm_split_count++;
> > -             next_pipe = next_pipe->next_odm_pipe;
> > -     }
> > -     pipe = pipe->prev_odm_pipe;
> > -     while (pipe) {
> > -             odm_split_count++;
> > -             pipe = pipe->prev_odm_pipe;
> > -     }
> > -     return odm_split_count;
> > -}
> > -
> >  int dcn20_populate_dml_pipes_from_context(
> >               struct dc *dc, struct dc_state *context,
> > display_e2e_pipe_params_st *pipes)  { diff --git
> > a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
> > b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
> > index 5180088ab6bc..f5893840b79b 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
> > @@ -49,7 +49,6 @@ unsigned int dcn20_calc_max_scaled_time(
> >               unsigned int time_per_pixel,
> >               enum mmhubbub_wbif_mode mode,
> >               unsigned int urgent_watermark);
> > -int get_num_odm_splits(struct pipe_ctx *pipe);  int
>
> Seems like the "int" at the end of this line actually belongs to the next line.
> I am wondering is it a typo or a format-patch glitch?

Actual patch is correct:
https://cgit.freedesktop.org/~agd5f/linux/commit/?h=drm-next&id=c8d2c8eaa3bbcaf8e2bc20f3e3203ed444f90bcc

>
> > dcn20_populate_dml_pipes_from_context(
> >               struct dc *dc, struct dc_state *context,
> > display_e2e_pipe_params_st *pipes);  struct pipe_ctx
> > *dcn20_acquire_idle_pipe_for_layer(
> > diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h
> > b/drivers/gpu/drm/amd/display/dc/inc/resource.h
> > index 5ae8ada154ef..ca4c36c0c9bc 100644
> > --- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
> > +++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
> > @@ -179,4 +179,7 @@ unsigned int resource_pixel_format_to_bpp(enum
> > surface_pixel_format format);
> >
> >  void get_audio_check(struct audio_info *aud_modes,
> >       struct audio_check *aud_chk);
> > +
> > +int get_num_odm_splits(struct pipe_ctx *pipe);
> > +
> >  #endif /* DRIVERS_GPU_DRM_AMD_DC_DEV_DC_INC_RESOURCE_H_ */
> > --
> > 2.24.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
