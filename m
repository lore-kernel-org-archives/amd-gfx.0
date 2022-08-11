Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B2EC19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 17:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E122118B0B9;
	Thu, 11 Aug 2022 17:54:42 +0000 (UTC)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B848714A95E
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 17:53:19 +0000 (UTC)
Received: by mail-ua1-x92a.google.com with SMTP id z14so7215360uaq.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 10:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc;
 bh=4eqqIkPfZArmnTbnGS6yRbiCSnrDlM1kjkH3YRCwXjI=;
 b=AELMy2VjIZGUFjl/RQJQbx21lQGuuUqkrFeqWQb0QaXZdfnAARuLynQGC4pJcNmKr8
 vENeNvC6H4FIVfo8zs9cTnYP0A4yI3TmO5S1ZdWvFdYlWwbtZSiKA+atIo8d3IoBk/JO
 JSVqtGIXnbdN8SBgQR9IIB0TGxVT+KK2BHp6xTBAMQ8r7yeAz2sThi1fJaVCYq2k+yTP
 /yPKu0wDYmwLwSPQyvppfrXWdWUeWYCbhqA2IpFkW/e9liiHm4oldcRtaINJ2/eeW5cU
 I5t9iczK3kUwgII6odHZLECjK2J3OgfdcY7uXfx/5f0mmsx9elwtm4WlaKF2JJzpZcoO
 PCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=4eqqIkPfZArmnTbnGS6yRbiCSnrDlM1kjkH3YRCwXjI=;
 b=ear6D6KvA2ERdmLYQEmItPmL6fRJzLgRterS47vJH7y4Al3CmvECGlgdOt8AJOKJeA
 69sYNw30VWNwuchAeEvxeNP1JfbSHifm6arrbScbktdsHxX78S81/3CAEnQ416DE8S6p
 QGy7aGJnK7InishYUmpQnJHmVKft8fcq8ZyehUqDiuHXwVKt+9wPVnqg3rjERaaI1CTw
 iVYLnRQzMQiQhZkTNbiNGEJyjtFfwgjRFMhUauU25sfdSc1btdZTukFVP8zSvIDNrC8E
 DbsA+pEw82dpG2+xVPyPWyu5ccyNZr5z7XE94iI9iDmK47xDVgZu9Kd9vmDuAgXyDM6N
 q5cg==
X-Gm-Message-State: ACgBeo09Nb9trKUuymqnX38em68pvyayaR7Kl04dMaXWHbnEAelQ0wnd
 tvIrJpd8wgSfGFY30ddcGv1+DBZQZU88tRJe9nFbsQ==
X-Google-Smtp-Source: AA6agR6IGERKC7F5XIjScrYMJWXun9TSnc/Z86zvodrEuTCpnxG9XISa6MOeqa6FG/ZnmdgeSDfv/sbIcpQ1+x09pxc=
X-Received: by 2002:ab0:2359:0:b0:387:2dff:87d5 with SMTP id
 h25-20020ab02359000000b003872dff87d5mr153463uao.104.1660240398549; Thu, 11
 Aug 2022 10:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220811004010.61299-1-tales.aparecida@gmail.com>
 <20220811004010.61299-8-tales.aparecida@gmail.com>
 <CABVgOSmJm0W1OAk7Ja8zb_WMcj=kXx7-w9J747k5sRySi1Jyfw@mail.gmail.com>
 <1716b7b6-9fd0-214e-aeab-55220aa70a9d@riseup.net>
In-Reply-To: <1716b7b6-9fd0-214e-aeab-55220aa70a9d@riseup.net>
From: David Gow <davidgow@google.com>
Date: Fri, 12 Aug 2022 01:53:07 +0800
Message-ID: <CABVgOSm9R38OY_0D=8zFDaFxkOCFaiAeikxZ-7TZXa9L4LmZZw@mail.gmail.com>
Subject: Re: [PATCH 7/8] drm/amd/display: Introduce KUnit tests to dc_dmub_srv
 library
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 11 Aug 2022 17:54:37 +0000
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
Cc: andrealmeid@riseup.net, Thomas Zimmermann <tzimmermann@suse.de>,
 siqueirajordao@riseup.net, Jonathan Corbet <corbet@lwn.net>,
 David Airlie <airlied@linux.ie>, Tales Aparecida <tales.aparecida@gmail.com>,
 Trevor Woerner <twoerner@gmail.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, mwen@igalia.com,
 Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 magalilemes00@gmail.com, Isabella Basso <isabbasso@riseup.net>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 KUnit Development <kunit-dev@googlegroups.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Aug 11, 2022 at 9:38 PM Ma=C3=ADra Canal <mairacanal@riseup.net> wr=
ote:
>
>
>
> On 8/11/22 04:37, David Gow wrote:
> > On Thu, Aug 11, 2022 at 8:41 AM Tales Aparecida
> > <tales.aparecida@gmail.com> wrote:
> >>
> >> From: Ma=C3=ADra Canal <mairacanal@riseup.net>
> >>
> >> Add unit test to the SubVP feature in order to avoid possible
> >> regressions and assure the code robustness.
> >>
> >> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> >> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
> >> ---
> >
> > FYI: This seems to have a dependency issue. See below.
> >
> > Otherwise, I haven't had a chance to review it properly yet, but I'll
> > try to take a closer look over the next few days.
> >
> > Cheers,
> > -- David
> >
> >>   drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   4 +
> >>   .../amd/display/tests/dc/dc_dmub_srv_test.c   | 285 ++++++++++++++++=
++
> >>   2 files changed, 289 insertions(+)
> >>   create mode 100644 drivers/gpu/drm/amd/display/tests/dc/dc_dmub_srv_=
test.c
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gp=
u/drm/amd/display/dc/dc_dmub_srv.c
> >> index 2d61c2a91cee..f5dd1f69840e 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> >> @@ -809,3 +809,7 @@ void dc_dmub_srv_log_diagnostic_data(struct dc_dmu=
b_srv *dc_dmub_srv)
> >>                  diag_data.is_cw0_enabled,
> >>                  diag_data.is_cw6_enabled);
> >>   }
> >> +
> >> +#if IS_ENABLED(CONFIG_AMD_DC_BASICS_KUNIT_TEST)
> >> +#include "../tests/dc/dc_dmub_srv_test.c"
> >> +#endif
> >> diff --git a/drivers/gpu/drm/amd/display/tests/dc/dc_dmub_srv_test.c b=
/drivers/gpu/drm/amd/display/tests/dc/dc_dmub_srv_test.c
> >> new file mode 100644
> >> index 000000000000..051079cbf65e
> >> --- /dev/null
> >> +++ b/drivers/gpu/drm/amd/display/tests/dc/dc_dmub_srv_test.c
> >> @@ -0,0 +1,285 @@
> >> +// SPDX-License-Identifier: MIT
> >> +/*
> >> + * KUnit tests for dc_dmub_srv.c
> >> + *
> >> + * Copyright (C) 2022, Ma=C3=ADra Canal <mairacanal@riseup.net>
> >> + */
> >> +
> >> +#include <kunit/test.h>
> >> +#include "dc_dmub_srv.h"
> >> +
> >> +struct populate_subvp_cmd_drr_info_test_case {
> >> +       const char *desc;
> >> +       struct dc *dc;
> >> +       struct pipe_ctx *subvp_pipe;
> >> +       struct pipe_ctx *vblank_pipe;
> >> +       const u8 drr_in_use;
> >> +       const u8 drr_window_size_ms;
> >> +       const u16 min_vtotal_supported;
> >> +       const u16 max_vtotal_supported;
> >> +       const u8 use_ramping;
> >> +};
> >> +
> >> +struct populate_subvp_cmd_drr_info_test_case populate_subvp_cmd_drr_i=
nfo_cases[] =3D {
> >> +       {
> >> +               .desc =3D "Same Clock Frequency",
> >> +               .dc =3D &(struct dc) {
> >> +                       .caps =3D {
> >> +                               .subvp_prefetch_end_to_mall_start_us =
=3D 0,
> >> +                       }
> >> +               },
> >> +               .subvp_pipe =3D &(struct pipe_ctx) {
> >> +                       .stream =3D &(struct dc_stream_state) {
> >> +                               .timing =3D {
> >> +                                       .h_total =3D 2784,
> >> +                                       .v_addressable =3D 1080,
> >> +                                       .pix_clk_100hz =3D 1855800,
> >> +                               },
> >> +                               .mall_stream_config =3D {
> >> +                                       .paired_stream =3D &(struct dc=
_stream_state) {
> >> +                                               .timing =3D {
> >> +                                                       .h_total =3D 3=
600,
> >> +                                                       .v_total =3D 1=
111,
> >> +                                                       .v_addressable=
 =3D 1080,
> >> +                                                       .v_front_porch=
 =3D 3,
> >> +                                                       .pix_clk_100hz=
 =3D 1855800,
> >> +                                               },
> >> +                                       },
> >> +                               },
> >> +                       },
> >> +               },
> >> +               .vblank_pipe =3D &(struct pipe_ctx) {
> >> +                       .stream =3D &(struct dc_stream_state) {
> >> +                               .timing =3D {
> >> +                                       .h_total =3D 2784,
> >> +                                       .v_total =3D 1111,
> >> +                                       .v_addressable =3D 1080,
> >> +                                       .pix_clk_100hz =3D 1855800,
> >> +                               },
> >> +                       },
> >> +               },
> >> +               .drr_in_use =3D true,
> >> +               .use_ramping =3D false,
> >> +               .drr_window_size_ms =3D 4,
> >> +               .min_vtotal_supported =3D 2540,
> >> +               .max_vtotal_supported =3D 2619,
> >> +       },
> >> +       {
> >> +               .desc =3D "Same Clock Frequency with Prefetch End to M=
all Start",
> >> +               .dc =3D &(struct dc) {
> >> +                       .caps =3D {
> >> +                               .subvp_prefetch_end_to_mall_start_us =
=3D 500,
> >> +                       }
> >> +               },
> >> +               .subvp_pipe =3D &(struct pipe_ctx) {
> >> +                       .stream =3D &(struct dc_stream_state) {
> >> +                               .timing =3D {
> >> +                                       .h_total =3D 2784,
> >> +                                       .v_addressable =3D 1080,
> >> +                                       .pix_clk_100hz =3D 1855800,
> >> +                               },
> >> +                               .mall_stream_config =3D {
> >> +                                       .paired_stream =3D &(struct dc=
_stream_state) {
> >> +                                               .timing =3D {
> >> +                                                       .h_total =3D 3=
600,
> >> +                                                       .v_total =3D 1=
111,
> >> +                                                       .v_addressable=
 =3D 1080,
> >> +                                                       .v_front_porch=
 =3D 3,
> >> +                                                       .pix_clk_100hz=
 =3D 1855800,
> >> +                                               },
> >> +                                       },
> >> +                               },
> >> +                       },
> >> +               },
> >> +               .vblank_pipe =3D &(struct pipe_ctx) {
> >> +                       .stream =3D &(struct dc_stream_state) {
> >> +                               .timing =3D {
> >> +                                       .h_total =3D 2784,
> >> +                                       .v_total =3D 1111,
> >> +                                       .v_addressable =3D 1080,
> >> +                                       .pix_clk_100hz =3D 1855800,
> >> +                               },
> >> +                       },
> >> +               },
> >> +               .drr_in_use =3D true,
> >> +               .use_ramping =3D false,
> >> +               .drr_window_size_ms =3D 4,
> >> +               .min_vtotal_supported =3D 2540,
> >> +               .max_vtotal_supported =3D 2619,
> >> +       },
> >> +       {
> >> +               .desc =3D "Same Clock Frequency Not Multiple of 2",
> >> +               .dc =3D &(struct dc) {
> >> +                       .caps =3D {
> >> +                               .subvp_prefetch_end_to_mall_start_us =
=3D 0,
> >> +                       }
> >> +               },
> >> +               .subvp_pipe =3D &(struct pipe_ctx) {
> >> +                       .stream =3D &(struct dc_stream_state) {
> >> +                               .timing =3D {
> >> +                                       .h_total =3D 2784,
> >> +                                       .v_addressable =3D 1080,
> >> +                                       .pix_clk_100hz =3D 1866743,
> >> +                               },
> >> +                               .mall_stream_config =3D {
> >> +                                       .paired_stream =3D &(struct dc=
_stream_state) {
> >> +                                               .timing =3D {
> >> +                                                       .h_total =3D 3=
600,
> >> +                                                       .v_total =3D 2=
400,
> >> +                                                       .v_addressable=
 =3D 2360,
> >> +                                                       .v_front_porch=
 =3D 4,
> >> +                                                       .pix_clk_100hz=
 =3D 1866743,
> >> +                                               },
> >> +                                       },
> >> +                               },
> >> +                       },
> >> +               },
> >> +               .vblank_pipe =3D &(struct pipe_ctx) {
> >> +                       .stream =3D &(struct dc_stream_state) {
> >> +                               .timing =3D {
> >> +                                       .h_total =3D 3600,
> >> +                                       .v_total =3D 2400,
> >> +                                       .v_addressable =3D 2360,
> >> +                                       .pix_clk_100hz =3D 1866743,
> >> +                               },
> >> +                       },
> >> +               },
> >> +               .drr_in_use =3D true,
> >> +               .use_ramping =3D false,
> >> +               .drr_window_size_ms =3D 4,
> >> +               .min_vtotal_supported =3D 1387,
> >> +               .max_vtotal_supported =3D 2875,
> >> +       },
> >> +       {
> >> +               .desc =3D "Different Clock Frequency for smaller h_tot=
al and v_total",
> >> +               .dc =3D &(struct dc) {
> >> +                       .caps =3D {
> >> +                               .subvp_prefetch_end_to_mall_start_us =
=3D 300,
> >> +                       }
> >> +               },
> >> +               .subvp_pipe =3D &(struct pipe_ctx) {
> >> +                       .stream =3D &(struct dc_stream_state) {
> >> +                               .timing =3D {
> >> +                                       .h_total =3D 1280,
> >> +                                       .v_addressable =3D 600,
> >> +                                       .pix_clk_100hz =3D 1855800,
> >> +                               },
> >> +                               .mall_stream_config =3D {
> >> +                                       .paired_stream =3D &(struct dc=
_stream_state) {
> >> +                                               .timing =3D {
> >> +                                                       .h_total =3D 1=
280,
> >> +                                                       .v_total =3D 7=
20,
> >> +                                                       .v_addressable=
 =3D 600,
> >> +                                                       .v_front_porch=
 =3D 4,
> >> +                                                       .pix_clk_100hz=
 =3D 1866743,
> >> +                                               },
> >> +                                       },
> >> +                               },
> >> +                       },
> >> +               },
> >> +               .vblank_pipe =3D &(struct pipe_ctx) {
> >> +                       .stream =3D &(struct dc_stream_state) {
> >> +                               .timing =3D {
> >> +                                       .h_total =3D 1280,
> >> +                                       .v_total =3D 720,
> >> +                                       .v_addressable =3D 600,
> >> +                                       .pix_clk_100hz =3D 2100800,
> >> +                               },
> >> +                       },
> >> +               },
> >> +               .drr_in_use =3D true,
> >> +               .use_ramping =3D false,
> >> +               .drr_window_size_ms =3D 4,
> >> +               .min_vtotal_supported =3D 1477,
> >> +               .max_vtotal_supported =3D 9954,
> >> +       },
> >> +       {
> >> +               .desc =3D "Different Clock Frequency for approximately=
 1920x1080",
> >> +               .dc =3D &(struct dc) {
> >> +                       .caps =3D {
> >> +                               .subvp_prefetch_end_to_mall_start_us =
=3D 0,
> >> +                       }
> >> +               },
> >> +               .subvp_pipe =3D &(struct pipe_ctx) {
> >> +                       .stream =3D &(struct dc_stream_state) {
> >> +                               .timing =3D {
> >> +                                       .h_total =3D 1920,
> >> +                                       .v_addressable =3D 1000,
> >> +                                       .pix_clk_100hz =3D 1855800,
> >> +                               },
> >> +                               .mall_stream_config =3D {
> >> +                                       .paired_stream =3D &(struct dc=
_stream_state) {
> >> +                                               .timing =3D {
> >> +                                                       .h_total =3D 1=
911,
> >> +                                                       .v_total =3D 1=
080,
> >> +                                                       .v_addressable=
 =3D 1000,
> >> +                                                       .v_front_porch=
 =3D 7,
> >> +                                                       .pix_clk_100hz=
 =3D 1866743,
> >> +                                               },
> >> +                                       },
> >> +                               },
> >> +                       },
> >> +               },
> >> +               .vblank_pipe =3D &(struct pipe_ctx) {
> >> +                       .stream =3D &(struct dc_stream_state) {
> >> +                               .timing =3D {
> >> +                                       .h_total =3D 1280,
> >> +                                       .v_total =3D 720,
> >> +                                       .v_addressable =3D 600,
> >> +                                       .pix_clk_100hz =3D 2100800,
> >> +                               },
> >> +                       },
> >> +               },
> >> +               .drr_in_use =3D true,
> >> +               .use_ramping =3D false,
> >> +               .drr_window_size_ms =3D 4,
> >> +               .min_vtotal_supported =3D 2482,
> >> +               .max_vtotal_supported =3D 8971,
> >> +       },
> >> +};
> >> +
> >> +static void populate_subvp_cmd_drr_info_test_to_desc(struct
> >> +               populate_subvp_cmd_drr_info_test_case * t, char *desc)
> >> +{
> >> +       strcpy(desc, t->desc);
> >> +}
> >> +
> >> +KUNIT_ARRAY_PARAM(populate_subvp_cmd_drr_info, populate_subvp_cmd_drr=
_info_cases,
> >> +                 populate_subvp_cmd_drr_info_test_to_desc);
> >> +
> >> +static void populate_subvp_cmd_drr_info_test(struct kunit *test)
> >> +{
> >> +       const struct populate_subvp_cmd_drr_info_test_case *test_param=
 =3D
> >> +               test->param_value;
> >> +       struct dmub_cmd_fw_assisted_mclk_switch_pipe_data_v2 *pipe_dat=
a;
> >> +
> >> +       pipe_data =3D kunit_kzalloc(test,
> >> +                                 sizeof(struct dmub_cmd_fw_assisted_m=
clk_switch_pipe_data_v2),
> >> +                                 GFP_KERNEL);
> >> +
> >> +       populate_subvp_cmd_drr_info(test_param->dc, test_param->subvp_=
pipe,
> >> +                                   test_param->vblank_pipe, pipe_data=
);
> >
> > Should this be hidden behind an #ifdef CONFIG_DRM_AMD_DC_DCN
> >
> > Otherwise, there are build issues under UML:
> > ../drivers/gpu/drm/amd/amdgpu/../display/dc/../tests/dc/dc_dmub_srv_tes=
t.c:
> > In function =E2=80=98populate_subvp_cmd_drr_info_test=E2=80=99:
> > ../drivers/gpu/drm/amd/amdgpu/../display/dc/../tests/dc/dc_dmub_srv_tes=
t.c:260:9:
> > error: implicit declaration of function =E2=80=98populate_subvp_cmd_drr=
_info=E2=80=99;
> > did you mean =E2=80=98populate_subvp_cmd_drr_info_test=E2=80=99? [-Werr=
or
> > =3Dimplicit-function-declaration]
> >   260 |         populate_subvp_cmd_drr_info(test_param->dc,
> > test_param->subvp_pipe,
> >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >       |         populate_subvp_cmd_drr_info_test
> > cc1: some warnings being treated as errors
> > make[5]: *** [../scripts/Makefile.build:249:
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.o] Error 1
> >
> > Making the test skip itself if this isn't enabled worked fine here.
> >
> >
>
> Currently, we don't support UML as there are some build problems on
> AMDGPU. You can apply the patch that I sent previously to run the tests
> with UML, and this warning will not happen anymore, but for now, the
> tests will work properly only on x86_64.
>

Fair enough: I definitely don't expect these all to work perfectly on
UML (particularly in v1).

> Moreover, I don't know if it is worth adding an #ifdef
> CONFIG_DRM_AMD_DC_DCN on all the functions, as most of the functions
> that we are testing are built under CONFIG_DRM_AMD_DC_DCN.
>

Even if it's not worth explicitly #ifdef-ing around individual tests
which use this, it's definitely important to make sure this test code
is behind some sort of dependency on CONFIG_DRM_AMD_DC_DCN. It
shouldn't be possible to create a valid .config which will cause a
compile error here. (It breaks, for example, randconfig builds.)

Could we at least have a "depends on" in the Kconfig, so that it's not
possible to create a broken config?

Cheers,
-- David
