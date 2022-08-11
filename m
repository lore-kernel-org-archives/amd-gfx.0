Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7C8C19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 12:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31641A18C1;
	Thu, 11 Aug 2022 12:54:17 +0000 (UTC)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 624D8A729E
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 07:37:27 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 q9-20020a17090a2dc900b001f58bcaca95so4542540pjm.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 00:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc;
 bh=NcU2K7qPg3sebdA5bOJPql0+gvPYJdFf9wk35Xzco8A=;
 b=Ib49xUPIrpk9e6UG9jWofU3kC/kxSQoHt38NeZoIU6Xls6w/WfqXT72GEDI2qktT9O
 6Cz6L1K7tReUYbf9IQWF2JG9xkF8Ijs9xrzlVHoaHCKZxRAG3O8InS07wm8EtcM2Cns2
 +kueEfg+OqFbI9oykGmD14Aqd+F2UD6SdvGJOj+m4AILGQsz6M0mWKc94mBDLrwfFmWy
 CPoQkFaBPdO4jfYysPxjArV3CwveNzztKj9075sg2VM+FiKAkDdyCY5Yw7bemaoJrjP5
 CR4rCy0+mnIf+ZsBCbg093T7YyCwjp6MZuTCR4CJqDWttJIBRbuaqSfNigQxD1h78dOs
 SaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=NcU2K7qPg3sebdA5bOJPql0+gvPYJdFf9wk35Xzco8A=;
 b=S1B/9jRCHm8X8II57OiHoowpRGwvQBd1/rUHY/meJN6hJtJDJwJ8XEVYKH8C7kzYwb
 TSpni24EhOkiqsLePVDZaF2kJg5labj/66HXFC8AUUj+oK7FL0lJ6oe0IrPJuFU9pzFg
 7GzYsaZnRq01BMBkckhU29rtd2U4MQY5WrvWj397ffPVcCLJiUPeAvzfPZcld7aegrjc
 +MN1PQ3ABxhgJZMw3tlti4K2lEqALaVal9Un2w/QvIDrc2vQY/UmpFxoxLaagkXnVu/n
 cLVWYcsR+8K3RL5kgynSIi4VDMPdqTNjIaNlgBh8XNb+iPf9B3kaWiSFIjuLbRv4rJJR
 r2IA==
X-Gm-Message-State: ACgBeo00tbl7azpCn9VTe0rAA1TVwFDGD/MdLksqfUeOynaPgVsU9FeM
 tcHliJJeLmS1kX2mRVBv1hkbFevNZlQ4+71/W7IkOGTQBu8CPtby
X-Google-Smtp-Source: AA6agR7/kXSPnHePuTr8wDqinipw0OoNG9ImIpImU5EoTwDIJYfN53GJlFuyxNsyfWy0DJOMZdTR+MvNO/zIK0RKRsc=
X-Received: by 2002:a67:cb0c:0:b0:357:9897:32d4 with SMTP id
 b12-20020a67cb0c000000b00357989732d4mr13346386vsl.18.1660203435364; Thu, 11
 Aug 2022 00:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220811004010.61299-1-tales.aparecida@gmail.com>
 <20220811004010.61299-8-tales.aparecida@gmail.com>
In-Reply-To: <20220811004010.61299-8-tales.aparecida@gmail.com>
From: David Gow <davidgow@google.com>
Date: Thu, 11 Aug 2022 15:37:04 +0800
Message-ID: <CABVgOSmJm0W1OAk7Ja8zb_WMcj=kXx7-w9J747k5sRySi1Jyfw@mail.gmail.com>
Subject: Re: [PATCH 7/8] drm/amd/display: Introduce KUnit tests to dc_dmub_srv
 library
To: Tales Aparecida <tales.aparecida@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 11 Aug 2022 12:54:12 +0000
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
 David Airlie <airlied@linux.ie>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, mwen@igalia.com,
 Leo Li <sunpeng.li@amd.com>, Isabella Basso <isabbasso@riseup.net>,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, magalilemes00@gmail.com,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
 Trevor Woerner <twoerner@gmail.com>, Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 KUnit Development <kunit-dev@googlegroups.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Aug 11, 2022 at 8:41 AM Tales Aparecida
<tales.aparecida@gmail.com> wrote:
>
> From: Ma=C3=ADra Canal <mairacanal@riseup.net>
>
> Add unit test to the SubVP feature in order to avoid possible
> regressions and assure the code robustness.
>
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
> ---

FYI: This seems to have a dependency issue. See below.

Otherwise, I haven't had a chance to review it properly yet, but I'll
try to take a closer look over the next few days.

Cheers,
-- David

>  drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   4 +
>  .../amd/display/tests/dc/dc_dmub_srv_test.c   | 285 ++++++++++++++++++
>  2 files changed, 289 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/display/tests/dc/dc_dmub_srv_test=
.c
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/d=
rm/amd/display/dc/dc_dmub_srv.c
> index 2d61c2a91cee..f5dd1f69840e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> @@ -809,3 +809,7 @@ void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_s=
rv *dc_dmub_srv)
>                 diag_data.is_cw0_enabled,
>                 diag_data.is_cw6_enabled);
>  }
> +
> +#if IS_ENABLED(CONFIG_AMD_DC_BASICS_KUNIT_TEST)
> +#include "../tests/dc/dc_dmub_srv_test.c"
> +#endif
> diff --git a/drivers/gpu/drm/amd/display/tests/dc/dc_dmub_srv_test.c b/dr=
ivers/gpu/drm/amd/display/tests/dc/dc_dmub_srv_test.c
> new file mode 100644
> index 000000000000..051079cbf65e
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/tests/dc/dc_dmub_srv_test.c
> @@ -0,0 +1,285 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * KUnit tests for dc_dmub_srv.c
> + *
> + * Copyright (C) 2022, Ma=C3=ADra Canal <mairacanal@riseup.net>
> + */
> +
> +#include <kunit/test.h>
> +#include "dc_dmub_srv.h"
> +
> +struct populate_subvp_cmd_drr_info_test_case {
> +       const char *desc;
> +       struct dc *dc;
> +       struct pipe_ctx *subvp_pipe;
> +       struct pipe_ctx *vblank_pipe;
> +       const u8 drr_in_use;
> +       const u8 drr_window_size_ms;
> +       const u16 min_vtotal_supported;
> +       const u16 max_vtotal_supported;
> +       const u8 use_ramping;
> +};
> +
> +struct populate_subvp_cmd_drr_info_test_case populate_subvp_cmd_drr_info=
_cases[] =3D {
> +       {
> +               .desc =3D "Same Clock Frequency",
> +               .dc =3D &(struct dc) {
> +                       .caps =3D {
> +                               .subvp_prefetch_end_to_mall_start_us =3D =
0,
> +                       }
> +               },
> +               .subvp_pipe =3D &(struct pipe_ctx) {
> +                       .stream =3D &(struct dc_stream_state) {
> +                               .timing =3D {
> +                                       .h_total =3D 2784,
> +                                       .v_addressable =3D 1080,
> +                                       .pix_clk_100hz =3D 1855800,
> +                               },
> +                               .mall_stream_config =3D {
> +                                       .paired_stream =3D &(struct dc_st=
ream_state) {
> +                                               .timing =3D {
> +                                                       .h_total =3D 3600=
,
> +                                                       .v_total =3D 1111=
,
> +                                                       .v_addressable =
=3D 1080,
> +                                                       .v_front_porch =
=3D 3,
> +                                                       .pix_clk_100hz =
=3D 1855800,
> +                                               },
> +                                       },
> +                               },
> +                       },
> +               },
> +               .vblank_pipe =3D &(struct pipe_ctx) {
> +                       .stream =3D &(struct dc_stream_state) {
> +                               .timing =3D {
> +                                       .h_total =3D 2784,
> +                                       .v_total =3D 1111,
> +                                       .v_addressable =3D 1080,
> +                                       .pix_clk_100hz =3D 1855800,
> +                               },
> +                       },
> +               },
> +               .drr_in_use =3D true,
> +               .use_ramping =3D false,
> +               .drr_window_size_ms =3D 4,
> +               .min_vtotal_supported =3D 2540,
> +               .max_vtotal_supported =3D 2619,
> +       },
> +       {
> +               .desc =3D "Same Clock Frequency with Prefetch End to Mall=
 Start",
> +               .dc =3D &(struct dc) {
> +                       .caps =3D {
> +                               .subvp_prefetch_end_to_mall_start_us =3D =
500,
> +                       }
> +               },
> +               .subvp_pipe =3D &(struct pipe_ctx) {
> +                       .stream =3D &(struct dc_stream_state) {
> +                               .timing =3D {
> +                                       .h_total =3D 2784,
> +                                       .v_addressable =3D 1080,
> +                                       .pix_clk_100hz =3D 1855800,
> +                               },
> +                               .mall_stream_config =3D {
> +                                       .paired_stream =3D &(struct dc_st=
ream_state) {
> +                                               .timing =3D {
> +                                                       .h_total =3D 3600=
,
> +                                                       .v_total =3D 1111=
,
> +                                                       .v_addressable =
=3D 1080,
> +                                                       .v_front_porch =
=3D 3,
> +                                                       .pix_clk_100hz =
=3D 1855800,
> +                                               },
> +                                       },
> +                               },
> +                       },
> +               },
> +               .vblank_pipe =3D &(struct pipe_ctx) {
> +                       .stream =3D &(struct dc_stream_state) {
> +                               .timing =3D {
> +                                       .h_total =3D 2784,
> +                                       .v_total =3D 1111,
> +                                       .v_addressable =3D 1080,
> +                                       .pix_clk_100hz =3D 1855800,
> +                               },
> +                       },
> +               },
> +               .drr_in_use =3D true,
> +               .use_ramping =3D false,
> +               .drr_window_size_ms =3D 4,
> +               .min_vtotal_supported =3D 2540,
> +               .max_vtotal_supported =3D 2619,
> +       },
> +       {
> +               .desc =3D "Same Clock Frequency Not Multiple of 2",
> +               .dc =3D &(struct dc) {
> +                       .caps =3D {
> +                               .subvp_prefetch_end_to_mall_start_us =3D =
0,
> +                       }
> +               },
> +               .subvp_pipe =3D &(struct pipe_ctx) {
> +                       .stream =3D &(struct dc_stream_state) {
> +                               .timing =3D {
> +                                       .h_total =3D 2784,
> +                                       .v_addressable =3D 1080,
> +                                       .pix_clk_100hz =3D 1866743,
> +                               },
> +                               .mall_stream_config =3D {
> +                                       .paired_stream =3D &(struct dc_st=
ream_state) {
> +                                               .timing =3D {
> +                                                       .h_total =3D 3600=
,
> +                                                       .v_total =3D 2400=
,
> +                                                       .v_addressable =
=3D 2360,
> +                                                       .v_front_porch =
=3D 4,
> +                                                       .pix_clk_100hz =
=3D 1866743,
> +                                               },
> +                                       },
> +                               },
> +                       },
> +               },
> +               .vblank_pipe =3D &(struct pipe_ctx) {
> +                       .stream =3D &(struct dc_stream_state) {
> +                               .timing =3D {
> +                                       .h_total =3D 3600,
> +                                       .v_total =3D 2400,
> +                                       .v_addressable =3D 2360,
> +                                       .pix_clk_100hz =3D 1866743,
> +                               },
> +                       },
> +               },
> +               .drr_in_use =3D true,
> +               .use_ramping =3D false,
> +               .drr_window_size_ms =3D 4,
> +               .min_vtotal_supported =3D 1387,
> +               .max_vtotal_supported =3D 2875,
> +       },
> +       {
> +               .desc =3D "Different Clock Frequency for smaller h_total =
and v_total",
> +               .dc =3D &(struct dc) {
> +                       .caps =3D {
> +                               .subvp_prefetch_end_to_mall_start_us =3D =
300,
> +                       }
> +               },
> +               .subvp_pipe =3D &(struct pipe_ctx) {
> +                       .stream =3D &(struct dc_stream_state) {
> +                               .timing =3D {
> +                                       .h_total =3D 1280,
> +                                       .v_addressable =3D 600,
> +                                       .pix_clk_100hz =3D 1855800,
> +                               },
> +                               .mall_stream_config =3D {
> +                                       .paired_stream =3D &(struct dc_st=
ream_state) {
> +                                               .timing =3D {
> +                                                       .h_total =3D 1280=
,
> +                                                       .v_total =3D 720,
> +                                                       .v_addressable =
=3D 600,
> +                                                       .v_front_porch =
=3D 4,
> +                                                       .pix_clk_100hz =
=3D 1866743,
> +                                               },
> +                                       },
> +                               },
> +                       },
> +               },
> +               .vblank_pipe =3D &(struct pipe_ctx) {
> +                       .stream =3D &(struct dc_stream_state) {
> +                               .timing =3D {
> +                                       .h_total =3D 1280,
> +                                       .v_total =3D 720,
> +                                       .v_addressable =3D 600,
> +                                       .pix_clk_100hz =3D 2100800,
> +                               },
> +                       },
> +               },
> +               .drr_in_use =3D true,
> +               .use_ramping =3D false,
> +               .drr_window_size_ms =3D 4,
> +               .min_vtotal_supported =3D 1477,
> +               .max_vtotal_supported =3D 9954,
> +       },
> +       {
> +               .desc =3D "Different Clock Frequency for approximately 19=
20x1080",
> +               .dc =3D &(struct dc) {
> +                       .caps =3D {
> +                               .subvp_prefetch_end_to_mall_start_us =3D =
0,
> +                       }
> +               },
> +               .subvp_pipe =3D &(struct pipe_ctx) {
> +                       .stream =3D &(struct dc_stream_state) {
> +                               .timing =3D {
> +                                       .h_total =3D 1920,
> +                                       .v_addressable =3D 1000,
> +                                       .pix_clk_100hz =3D 1855800,
> +                               },
> +                               .mall_stream_config =3D {
> +                                       .paired_stream =3D &(struct dc_st=
ream_state) {
> +                                               .timing =3D {
> +                                                       .h_total =3D 1911=
,
> +                                                       .v_total =3D 1080=
,
> +                                                       .v_addressable =
=3D 1000,
> +                                                       .v_front_porch =
=3D 7,
> +                                                       .pix_clk_100hz =
=3D 1866743,
> +                                               },
> +                                       },
> +                               },
> +                       },
> +               },
> +               .vblank_pipe =3D &(struct pipe_ctx) {
> +                       .stream =3D &(struct dc_stream_state) {
> +                               .timing =3D {
> +                                       .h_total =3D 1280,
> +                                       .v_total =3D 720,
> +                                       .v_addressable =3D 600,
> +                                       .pix_clk_100hz =3D 2100800,
> +                               },
> +                       },
> +               },
> +               .drr_in_use =3D true,
> +               .use_ramping =3D false,
> +               .drr_window_size_ms =3D 4,
> +               .min_vtotal_supported =3D 2482,
> +               .max_vtotal_supported =3D 8971,
> +       },
> +};
> +
> +static void populate_subvp_cmd_drr_info_test_to_desc(struct
> +               populate_subvp_cmd_drr_info_test_case * t, char *desc)
> +{
> +       strcpy(desc, t->desc);
> +}
> +
> +KUNIT_ARRAY_PARAM(populate_subvp_cmd_drr_info, populate_subvp_cmd_drr_in=
fo_cases,
> +                 populate_subvp_cmd_drr_info_test_to_desc);
> +
> +static void populate_subvp_cmd_drr_info_test(struct kunit *test)
> +{
> +       const struct populate_subvp_cmd_drr_info_test_case *test_param =
=3D
> +               test->param_value;
> +       struct dmub_cmd_fw_assisted_mclk_switch_pipe_data_v2 *pipe_data;
> +
> +       pipe_data =3D kunit_kzalloc(test,
> +                                 sizeof(struct dmub_cmd_fw_assisted_mclk=
_switch_pipe_data_v2),
> +                                 GFP_KERNEL);
> +
> +       populate_subvp_cmd_drr_info(test_param->dc, test_param->subvp_pip=
e,
> +                                   test_param->vblank_pipe, pipe_data);

Should this be hidden behind an #ifdef CONFIG_DRM_AMD_DC_DCN

Otherwise, there are build issues under UML:
../drivers/gpu/drm/amd/amdgpu/../display/dc/../tests/dc/dc_dmub_srv_test.c:
In function =E2=80=98populate_subvp_cmd_drr_info_test=E2=80=99:
../drivers/gpu/drm/amd/amdgpu/../display/dc/../tests/dc/dc_dmub_srv_test.c:=
260:9:
error: implicit declaration of function =E2=80=98populate_subvp_cmd_drr_inf=
o=E2=80=99;
did you mean =E2=80=98populate_subvp_cmd_drr_info_test=E2=80=99? [-Werror
=3Dimplicit-function-declaration]
 260 |         populate_subvp_cmd_drr_info(test_param->dc,
test_param->subvp_pipe,
     |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
     |         populate_subvp_cmd_drr_info_test
cc1: some warnings being treated as errors
make[5]: *** [../scripts/Makefile.build:249:
drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.o] Error 1

Making the test skip itself if this isn't enabled worked fine here.




> +
> +       KUNIT_EXPECT_EQ(test, test_param->drr_in_use,
> +                       pipe_data->pipe_config.vblank_data.drr_info.drr_i=
n_use);
> +       KUNIT_EXPECT_EQ(test, test_param->drr_window_size_ms,
> +                       pipe_data->pipe_config.vblank_data.drr_info.drr_w=
indow_size_ms);
> +       KUNIT_EXPECT_EQ(test, test_param->use_ramping,
> +                       pipe_data->pipe_config.vblank_data.drr_info.use_r=
amping);
> +       KUNIT_EXPECT_EQ(test, test_param->min_vtotal_supported,
> +                       pipe_data->pipe_config.vblank_data.drr_info.min_v=
total_supported);
> +       KUNIT_EXPECT_EQ(test, test_param->max_vtotal_supported,
> +                       pipe_data->pipe_config.vblank_data.drr_info.max_v=
total_supported);
> +}
> +
> +static struct kunit_case dc_dmub_srv_cases[] =3D {
> +       KUNIT_CASE_PARAM(populate_subvp_cmd_drr_info_test, populate_subvp=
_cmd_drr_info_gen_params),
> +       {  }
> +};
> +
> +static struct kunit_suite dc_dmub_srv_suite =3D {
> +       .name =3D "dc_dmub_srv",
> +       .test_cases =3D dc_dmub_srv_cases,
> +};
> +
> +kunit_test_suite(dc_dmub_srv_suite);
> --
> 2.37.0
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20220811004010.61299-8-tales.aparecida%40gmail.com.
