Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3BACCF2C1
	for <amd-gfx@archiver.kernel.org>; Sat, 17 Oct 2026 17:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5196A10E460;
	Sat, 17 Oct 2026 17:30:52 +0000 (UTC)
Received: from mail-pz2-f5.google.com (mail-pz2-f5.google.com [74.125.228.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C07B910E33C
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 17:37:46 +0000 (UTC)
Received: by mail-pz2-f5.google.com with SMTP id
 41be03b00d2f7-cc7c286026aso108624a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 10:37:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792172266; cv=none;
 d=google.com; s=arc-20260327;
 b=drntOO1W/dZCdKW1dyWKl5cfZlEF2549wB3mY9O1jOoLr4gsMo4mcaqCX73mC98Drm
 8Wi8gk7onEHcXjMbLkRtQW2mfQLz0u700GGn6h4ss/bJVZBjrepQtzLx3kRaqmSwNJeQ
 4Bl1DTw21CPf4naziIX5MHcdPCFSjuG+c0r7OccasN5qEpJ3S0z4J6Re21bO3QAq56Bi
 B2BTNdRwdai0cLLLZOxVWtApME1sw62oPNy2xVMRkgiGa/P75Izz/+6gDlbshOUJG7nu
 uimNwmNEi97jrsq9YosDsvQVIZVD0j9CDNHYgUR449WpUwq1xPKxgzSgG2l2VVTFW8A6
 xG3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:from
 :mime-version:dkim-signature;
 bh=cSBeL18Hzr+0k6iOggYBFAtCAyebrXp5vaXSKHdHnjg=;
 fh=CwG0OJN9/rd0I+VWK9rhGtT7eezr+XcLx894FPuRXBs=;
 b=Lc0QZjcN9dMCTLT/8mz6z4ymEhl5z+OlJW/bISkJlHBM668i9gsRI7oeXRbWeg3hPY
 t+P3AL1GOBcOms4/K8B1Jfj3bnomChx6fstnFxm+EQ2Q+EBsuKRlDiNpxkkugp48/cuU
 OY3rwOH4SttLDJU3EoeuhiK8n/CaTu1naozHzq2kft5vjfvGi3zcLTb8C8MIr7ZyTyv4
 CZ5lP/zrfIdrCsY8ZtY99nCK11x2JVSR4pPvLbpdxhhom7cZewSb/1yQ59H9m4c1+DaX
 P5mvy0+lGeY0uzskQO4DNDdeJndrtO+dd7D9yGdzb/VbmJXCexKPoJhVGMn3vI4AT8TX
 QC2w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792172266; x=1792777066; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cSBeL18Hzr+0k6iOggYBFAtCAyebrXp5vaXSKHdHnjg=;
 b=WJdX71RGp9XdlyeLeSjmij00ByHPiXOi9puWkveNeIOB+YTUZWA7bdHOYh47XQno1w
 h8hvJbeoN6nGn0a7a6B1MlHOGo5XzRd3fjKHOv5X8p3O2NrmgyNDpfJt1OGpOKE5luCY
 QFpbeCJDTPdpEui9P1CHactfoRj73UpPfk8BDwxeiB3es7ZY6gQgl1qMw7IDQ99EHTvt
 HaRk1H+NzZEfH9ikwwAPVHjOgpWhF8jBAUMOPwdl2aixeHsMJEaUEp/8qLKubkenx4t+
 iScOdX/HSmsuqp9YR+ANVYce87L9iqxkfh93MzkUwAzFgCJkpuZJoWvhs9Mxhg6vaRr+
 i56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792172266; x=1792777066;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cSBeL18Hzr+0k6iOggYBFAtCAyebrXp5vaXSKHdHnjg=;
 b=2VhmDzFk859vAXE3jo8AfcpXL0EoyYZDtXnJd1PL9WDbvLslzGJWoaWS+045rHsM78
 xeSqhGS/513i7lH8gCddU9BMLHPMU8cIgjQAdBBZd2RfiVTzbx//YLQwwR0aPWdQvvPZ
 ph3zDKoQ/KGtiYpvYKU13KjZA/7Dpy1s7ZzC5NRgY1Ul1Cp0IDYx83zVhqjmXv9wD2ys
 O5/Li3sSbBFHELa3Jpx82Vw9TRi9WEQ90krkZPexaxlLs7FL00kHNrQIlbST/JqgW3XL
 kplGkg+N8uATV5BtwW4WbdnN8W5wXbAGj9jwjIkjvcXPljZwtuxpKBwW96JSQTSrPzT5
 1bjw==
X-Gm-Message-State: AFq9FYLQMn8a62+7eSi9XlWcR76Tj3m9tneXMVh8nSopY/yeuPM7CK01
 3BMscmweijiHv1Dm7orK8Q+VgNFvi6H9OHb4opzuSwjWjPs2MfKoki1aZ3RhSUKOX87XKYZtXPz
 7mmXgrCOrm0uDVLUFquzz8bQn+qc33E0=
X-Gm-Gg: AYBFou36dKi8KEiw1xS7FkU7a+dphdthvnMwmsfm2wI5afy8MeDyflEY2u+WST6OQfY
 wiq7iArBuV6ODYxnMNYfyaTy6li7zb+Ax9JZyYLeDe88CqtLdSzkKXH688dErYhYbN1YHqdxzXi
 aG3L9CjVo7g0d82slVHvvnHqM/Hb7AVymCj7txwx4HRE4zykXygC3CljMv93B5AOmCttHuDBdOm
 lYKc5aIA33KX4jjE5L6XOtMKDVEbdI9/1TfnZRdKjWni7ET88ndHJneWqQck3smwLAxqx1kCSVy
 FR2T9d3w+KfyPXsHKzdr7FK0ywJjs/+jfvHx9GliWCB/fwSuphkpCA==
X-Received: by 2002:a05:6a00:3008:b0:89e:fc47:2c17 with SMTP id
 d2e1a72fcca58-8a04be6a27bmr262049b3a.19.1792172266196; Fri, 16 Oct 2026
 10:37:46 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Fri, 16 Oct 2026 10:37:44 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Fri, 16 Oct 2026 10:37:44 -0700
MIME-Version: 1.0
From: Yibiao Li <biaobiao2233@gmail.com>
In-Reply-To: <f4dcee55-8cc6-4287-a25a-1ace385f092b@amd.com>
References: <CAG1agfwtnjmb8RVLmZvY9W-zrR1onhK6urJA3Lqai82tAXn2Cg@mail.gmail.com>
 <f4dcee55-8cc6-4287-a25a-1ace385f092b@amd.com>
Date: Fri, 16 Oct 2026 10:37:44 -0700
X-Gm-Features: AclHuK_NcSTXBwBpql1smct-MaIzZ_7A3iNYOrIiqYl5afbkmOt6bPkRbY4aer8
Message-ID: <CAG1agfwZF0j71YofDWVqrxX5v-gtSYbM2OQiw+Kbd1zGPTaT3g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Use separate iterator for preferred mode
 lookup
To: Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 17 Oct 2026 17:30:48 +0000
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

On Fri, Oct 16, 2026 at 09:50:44AM -0600, Alex Hung wrote:
> Reviewed-by: Alex Hung <alex.hung@amd.com>

Thanks for the review, Alex!

Best regards,
Yibiao


On Fri, 16 Oct 2026 09:50:44 -0600, Alex Hung <alex.hung@amd.com> wrote:
> Reviewed-by: Alex Hung <alex.hung@amd.com>
>
> On 10/7/26 23:17, Yibiao Li wrote:
> > [Some people who received this message don't often get email from biaobiao2233@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > From: Yibiao Li <biaobiao2233@gmail.com>
> >
> > create_stream_for_sink() uses preferred_mode both as the list iterator
> > and as the selected mode. This triggers a false positive from
> > scripts/coccinelle/iterators/use_after_iter.cocci: native_mode_found
> > already ensures that an exhausted iterator is replaced before use.
> >
> > Use a separate iterator and assign preferred_mode only when a preferred
> > entry is found. This keeps the selected mode separate from the iterator
> > state and makes native_mode_found unnecessary. Preserve the fallback to
> > the first entry, or NULL when the list is empty.
> >
> > No functional change intended.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Link: https://lore.kernel.org/oe-kbuild-all/202609190901.yKTzhsGz-lkp@intel.com/
> > Assisted-by: LLM coccinelle
> > Signed-off-by: Yibiao Li <biaobiao2233@gmail.com>
> > ---
> >   .../drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> > index d386bb1475..ceea8fe481 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> > @@ -1453,12 +1453,12 @@ create_stream_for_sink(struct drm_connector *connector,
> >          struct drm_device *dev = connector->dev;
> >          struct amdgpu_dm_connector *aconnector = NULL;
> >          struct drm_display_mode *preferred_mode = NULL;
> > +       struct drm_display_mode *connector_mode;
> >          const struct drm_connector_state *con_state = &dm_state->base;
> >          struct dc_stream_state *stream = NULL;
> >          struct drm_display_mode mode;
> >          struct drm_display_mode saved_mode;
> >          struct drm_display_mode *freesync_mode = NULL;
> > -       bool native_mode_found = false;
> >          bool recalculate_timing = false;
> >          bool scale = dm_state->scaling != RMX_OFF;
> >          int mode_refresh;
> > @@ -1509,14 +1509,14 @@ create_stream_for_sink(struct drm_connector *connector,
> >          stream->timing.flags.LTE_340MCSC_SCRAMBLE =
> >                  connector->display_info.hdmi.scdc.scrambling.low_rates;
> >
> > -       list_for_each_entry(preferred_mode, &connector->modes, head) {
> > +       list_for_each_entry(connector_mode, &connector->modes, head) {
> >                  /* Search for preferred mode */
> > -               if (preferred_mode->type & DRM_MODE_TYPE_PREFERRED) {
> > -                       native_mode_found = true;
> > +               if (connector_mode->type & DRM_MODE_TYPE_PREFERRED) {
> > +                       preferred_mode = connector_mode;
> >                          break;
> >                  }
> >          }
> > -       if (!native_mode_found)
> > +       if (!preferred_mode)
> >                  preferred_mode = list_first_entry_or_null(
> >                                  &connector->modes,
> >                                  struct drm_display_mode,
> > --
> > 2.43.0
