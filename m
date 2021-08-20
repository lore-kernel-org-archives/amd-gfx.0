Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8ECC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 13:12:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E64A2610D2
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 13:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E64A2610D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92E536EA8B;
	Fri, 20 Aug 2021 13:12:32 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 746A86EA8B
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 13:12:31 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 61-20020a9d0d430000b02903eabfc221a9so13520033oti.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 06:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3OvzSQ2kOCP8VcpZal5ARqhHz3Wc/E5x2wqnj+5n2jc=;
 b=HR0S46j4oQ5balZlGYioD3RDx5DSa9cha6yk3r59sz/Bu7Qo47dV/CYiIIJ1RgBqk2
 P+GXyQtViB0CpINXuPSyIenuVLoAGnFjNLjkYFXWdyDjWJ1AO8OjR+1oRP8l0IBp+Ubl
 PzJOef6uoMEhe7BiX+JdxlzkEBRbIrQo0anTBzUugi5sQHE7VmpC8CQpr0y05LzOuP7m
 dXUptXPzAZWs+313EagrN7A8PqSYbe0LKcOLCo0hgTZhn1RxGZBH8cYW4REkQp8gOhRM
 9Bevg6FWnZW7e53gZN+XZ9UZcF4rBcB+VtGV06/FmElAXF+mJdYJ1RBhnt5Vjd2498IA
 QcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3OvzSQ2kOCP8VcpZal5ARqhHz3Wc/E5x2wqnj+5n2jc=;
 b=XOm0oYsPytsXo8BfyrORJhX1O/zD0TpplgDC83KZhfHHYttGb1L8OnjPSFjC1EBJTf
 frV39/eUQZFDuF5qivVn01JC9OgNpGMiftIt9sUf0i91neiD7eR5suxhpyln/jMZsZcE
 uDsHVmM2/wAYim3a3WZMMEiUljm7RmJyft0Ft0sRJcLQM4qJ0IYBeZXdInoiQi0u8KC/
 NijwiHkyjGgYY2y+QIprzpSjxdK+6G2h2E5p4wz9YUqxvpEVlCjO8jbGX/XuQPEqJSdF
 Z2o8tq3n8lzPVG/x8SJRjvxohBNVBbOwP9kdTXMgIAjKu5jYhpFLPQmQtCJSJ+0GH1DD
 5bLA==
X-Gm-Message-State: AOAM530Jdd4WcIsfHuF3v3YpR2ZX8MXCzAVlxhfbbIXvbqqfakmDag6M
 EZcnszEYUmcKBlLPczU3vwEZZvdKJTjg7s/yd60=
X-Google-Smtp-Source: ABdhPJxzo8jejYR7urLC+F/cNVqIg/S0zaVGLpnVU5Kp3lLQ5avIcvfpxPUgvehg3uF0H95wKF8rgFA6jHnEeEN/Ae8=
X-Received: by 2002:a9d:5a15:: with SMTP id v21mr17351477oth.132.1629465150774; 
 Fri, 20 Aug 2021 06:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <1d64e5d6-8981-3bc2-21dd-b8eaf7a9333e@amd.com>
 <b71ef8fd-55f7-068b-db64-1aa727cde211@amd.com>
 <DM4PR12MB5040EBA85361E825DC161023F2C19@DM4PR12MB5040.namprd12.prod.outlook.com>
 <d8a9db0d-f52e-de2d-f40f-bae5bf04e801@amd.com>
 <DM4PR12MB5040E81412F41845530E5DA4F2C19@DM4PR12MB5040.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5040E81412F41845530E5DA4F2C19@DM4PR12MB5040.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 20 Aug 2021 09:12:19 -0400
Message-ID: <CADnq5_N=9ghwvcNKPs8iKUTakhvzVGvBbrcG7HFL0jTgtdRdng@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu/OLAND: clip the ref divider max value
To: "Sharma, Shashank" <Shashank.Sharma@amd.com>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

It's SI.

Alex

On Fri, Aug 20, 2021 at 4:08 AM Sharma, Shashank
<Shashank.Sharma@amd.com> wrote:
>
> [AMD Official Use Only]
>
> No problem, let me dig for this information.
>
> Regards
> Shashank
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Friday, August 20, 2021 1:36 PM
> To: Sharma, Shashank <Shashank.Sharma@amd.com>; amd-gfx@lists.freedesktop=
.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH v2] drm/amdgpu/OLAND: clip the ref divider max value
>
> Uff, I think that was SI but could be CIK as well.
>
> We have a table for this somewhere, but I don't have it at hand.
>
> Regards,
> Christian.
>
> Am 20.08.21 um 09:43 schrieb Sharma, Shashank:
> > [AMD Official Use Only]
> >
> > Agree, on the similar note, which Gen is OLAND BTW =F0=9F=98=8A ?
> >
> > Regards
> > Shashank
> > -----Original Message-----
> > From: Koenig, Christian <Christian.Koenig@amd.com>
> > Sent: Friday, August 20, 2021 12:08 PM
> > To: Sharma, Shashank <Shashank.Sharma@amd.com>;
> > amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: Re: [PATCH v2] drm/amdgpu/OLAND: clip the ref divider max
> > value
> >
> > Sounds like a good idea to me, but I would limit this generally or at l=
east for the whole generation and not just one particular chipset.
> >
> > Regards,
> > Christian.
> >
> > Am 20.08.21 um 08:05 schrieb Sharma, Shashank:
> >>  From 4841e5ba60e33ff798bde6cb69fbd7e137b6db9c Mon Sep 17 00:00:00
> >> 2001
> >> From: Shashank Sharma <shashank.sharma@amd.com>
> >> Date: Fri, 20 Aug 2021 10:20:02 +0530
> >> Subject: [PATCH v2] drm/amdgpu/OLAND: clip the ref divider max value
> >> MIME-Version: 1.0
> >> Content-Type: text/plain; charset=3DUTF-8
> >> Content-Transfer-Encoding: 8bit
> >>
> >> This patch limits the ref_div_max value to 100, during the
> >> calculation of PLL feedback reference divider. With current value
> >> (128), the produced fb_ref_div value generates unstable output at
> >> particular frequencies. Radeon driver limits this value at 100.
> >>
> >> On Oland, when we try to setup mode 2048x1280@60 (a bit weird, I
> >> know), it demands a clock of 221270 Khz. It's been observed that the
> >> PLL calculations using values 128 and 100 are vastly different, and
> >> look like this:
> >>
> >> +------------------------------------------+
> >> |Parameter    |AMDGPU        |Radeon       |
> >> |             |              |             |
> >> +-------------+----------------------------+
> >> |Clock feedback              |             | divider max  |  128
> >> ||   100       | cap value    |              |             |
> >> |             |              |             |
> >> |             |              |             |
> >> +------------------------------------------+
> >> |ref_div_max  |              |             |
> >> |             |  42          |  20         |
> >> |             |              |             |
> >> |             |              |             |
> >> +------------------------------------------+
> >> |ref_div      |  42          |  20         |
> >> |             |              |             |
> >> +------------------------------------------+
> >> |fb_div       |  10326       |  8195       |
> >> +------------------------------------------+
> >> |fb_div       |  1024        |  163        |
> >> +------------------------------------------+
> >> |fb_dev_p     |  4           |  9          | frac fb_de^_p|
> >> ||             |
> >> +----------------------------+-------------+
> >>
> >> With ref_div_max value clipped at 100, AMDGPU driver can also drive
> >> videmode 2048x1280@60 (221Mhz) and produce proper output without any
> >> blanking and distortion on the screen.
> >>
> >> PS: This value was changed from 128 to 100 in Radeon driver also, here=
:
> >> https://github.com/freedesktop/drm-tip/commit/4b21ce1b4b5d262e7d4656b
> >> 8
> >> ececc891fc3cb806
> >>
> >>
> >> V1:
> >> Got acks from:
> >> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> >> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>
> >> V2:
> >> - Restricting the changes only for OLAND, just to avoid any
> >> regression
> >>    for other cards.
> >> - Changed unsigned -> unsigned int to make checkpatch quiet.
> >>
> >> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> >> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> >> Cc: Eddy Qin <Eddy.Qin@amd.com>
> >> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c    | 20
> >> +++++++++++++-------
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h    |  3 ++-
> >>   drivers/gpu/drm/amd/amdgpu/atombios_crtc.c |  2 +-
> >>   3 files changed, 16 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
> >> index f2e20666c9c1..6d04c1d25bfb 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
> >> @@ -80,12 +80,17 @@ static void amdgpu_pll_reduce_ratio(unsigned
> >> *nom, unsigned *den,
> >>    * Calculate feedback and reference divider for a given post divider=
.
> >> Makes
> >>    * sure we stay within the limits.
> >>    */
> >> -static void amdgpu_pll_get_fb_ref_div(unsigned nom, unsigned den,
> >> unsigned post_div,
> >> -                      unsigned fb_div_max, unsigned ref_div_max,
> >> -                      unsigned *fb_div, unsigned *ref_div)
> >> +static void amdgpu_pll_get_fb_ref_div(struct amdgpu_device *adev,
> >> unsigned int nom,
> >> +                      unsigned int den, unsigned int post_div,
> >> +                      unsigned int fb_div_max, unsigned int
> >> +ref_div_max,
> >> +                      unsigned int *fb_div, unsigned int *ref_div)
> >>   {
> >> +
> >>       /* limit reference * post divider to a maximum */
> >> -    ref_div_max =3D min(128 / post_div, ref_div_max);
> >> +    if (adev->asic_type =3D=3D CHIP_OLAND)
> >> +        ref_div_max =3D min(100 / post_div, ref_div_max);
> >> +    else
> >> +        ref_div_max =3D min(128 / post_div, ref_div_max);
> >>
> >>       /* get matching reference and feedback divider */
> >>       *ref_div =3D min(max(DIV_ROUND_CLOSEST(den, post_div), 1u),
> >> ref_div_max); @@ -112,7 +117,8 @@ static void
> >> amdgpu_pll_get_fb_ref_div(unsigned
> >> nom, unsigned den, unsigned post_
> >>    * Try to calculate the PLL parameters to generate the given frequen=
cy:
> >>    * dot_clock =3D (ref_freq * feedback_div) / (ref_div * post_div)
> >>    */
> >> -void amdgpu_pll_compute(struct amdgpu_pll *pll,
> >> +void amdgpu_pll_compute(struct amdgpu_device *adev,
> >> +            struct amdgpu_pll *pll,
> >>               u32 freq,
> >>               u32 *dot_clock_p,
> >>               u32 *fb_div_p,
> >> @@ -199,7 +205,7 @@ void amdgpu_pll_compute(struct amdgpu_pll *pll,
> >>
> >>       for (post_div =3D post_div_min; post_div <=3D post_div_max;
> >> ++post_div) {
> >>           unsigned diff;
> >> -        amdgpu_pll_get_fb_ref_div(nom, den, post_div, fb_div_max,
> >> +        amdgpu_pll_get_fb_ref_div(adev, nom, den, post_div,
> >> +fb_div_max,
> >>                         ref_div_max, &fb_div, &ref_div);
> >>           diff =3D abs(target_clock - (pll->reference_freq * fb_div) /
> >>               (ref_div * post_div));
> >> @@ -214,7 +220,7 @@ void amdgpu_pll_compute(struct amdgpu_pll *pll,
> >>       post_div =3D post_div_best;
> >>
> >>       /* get the feedback and reference divider for the optimal value
> >> */
> >> -    amdgpu_pll_get_fb_ref_div(nom, den, post_div, fb_div_max,
> >> ref_div_max,
> >> +    amdgpu_pll_get_fb_ref_div(adev, nom, den, post_div, fb_div_max,
> >> ref_div_max,
> >>                     &fb_div, &ref_div);
> >>
> >>       /* reduce the numbers to a simpler ratio once more */ diff
> >> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h
> >> index db6136f68b82..44a583d6c9b4 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h
> >> @@ -24,7 +24,8 @@
> >>   #ifndef __AMDGPU_PLL_H__
> >>   #define __AMDGPU_PLL_H__
> >>
> >> -void amdgpu_pll_compute(struct amdgpu_pll *pll,
> >> +void amdgpu_pll_compute(struct amdgpu_device *adev,
> >> +             struct amdgpu_pll *pll,
> >>                u32 freq,
> >>                u32 *dot_clock_p,
> >>                u32 *fb_div_p,
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
> >> b/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
> >> index 159a2a4385a1..afad094f84c2 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
> >> @@ -851,7 +851,7 @@ void amdgpu_atombios_crtc_set_pll(struct drm_crtc
> >> *crtc, struct drm_display_mode
> >>       pll->reference_div =3D amdgpu_crtc->pll_reference_div;
> >>       pll->post_div =3D amdgpu_crtc->pll_post_div;
> >>
> >> -    amdgpu_pll_compute(pll, amdgpu_crtc->adjusted_clock, &pll_clock,
> >> +    amdgpu_pll_compute(adev, pll, amdgpu_crtc->adjusted_clock,
> >> &pll_clock,
> >>                   &fb_div, &frac_fb_div, &ref_div, &post_div);
> >>
> >>       amdgpu_atombios_crtc_program_ss(adev, ATOM_DISABLE,
> >> amdgpu_crtc->pll_id,
