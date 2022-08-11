Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245D8C19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 13:38:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AED4F14BF01;
	Thu, 11 Aug 2022 13:38:55 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86660B1321
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 13:38:40 +0000 (UTC)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4M3SZ72NdSzDqKr;
 Thu, 11 Aug 2022 13:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1660225119; bh=vq+Cbeu3UKOfkia5fURiOBo4nBY+jY+YmtYIcsnNRvQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=W41w/tX1hX1lcM+mFo6pnC1Trw7FU/0pbXnZkRtWq9Ungm/HWpbcx6dYof60YADow
 bUtoJpC8J3cOTZ4MBORQdqMxQwFfJzBx05oRcS9L72fZ5cyhQGK9BIhKN74QBDe4rL
 ozn1MYv4HeZsUz0kR9u9NRESQWjxq46twDuTbD5A=
X-Riseup-User-ID: 82FF68496D755400318D547C504BD5B1BED3723C02F86B38398B3325844870F0
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews2.riseup.net (Postfix) with ESMTPSA id 4M3SZ01NXwz1yWd;
 Thu, 11 Aug 2022 13:38:31 +0000 (UTC)
Message-ID: <1716b7b6-9fd0-214e-aeab-55220aa70a9d@riseup.net>
Date: Thu, 11 Aug 2022 10:38:29 -0300
MIME-Version: 1.0
Subject: Re: [PATCH 7/8] drm/amd/display: Introduce KUnit tests to dc_dmub_srv
 library
Content-Language: en-US
To: David Gow <davidgow@google.com>,
 Tales Aparecida <tales.aparecida@gmail.com>
References: <20220811004010.61299-1-tales.aparecida@gmail.com>
 <20220811004010.61299-8-tales.aparecida@gmail.com>
 <CABVgOSmJm0W1OAk7Ja8zb_WMcj=kXx7-w9J747k5sRySi1Jyfw@mail.gmail.com>
From: =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <CABVgOSmJm0W1OAk7Ja8zb_WMcj=kXx7-w9J747k5sRySi1Jyfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
 Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 magalilemes00@gmail.com, Isabella Basso <isabbasso@riseup.net>,
 Trevor Woerner <twoerner@gmail.com>, Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 KUnit Development <kunit-dev@googlegroups.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/11/22 04:37, David Gow wrote:
> On Thu, Aug 11, 2022 at 8:41 AM Tales Aparecida
> <tales.aparecida@gmail.com> wrote:
>>
>> From: Maíra Canal <mairacanal@riseup.net>
>>
>> Add unit test to the SubVP feature in order to avoid possible
>> regressions and assure the code robustness.
>>
>> Signed-off-by: Maíra Canal <mairacanal@riseup.net>
>> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
>> ---
> 
> FYI: This seems to have a dependency issue. See below.
> 
> Otherwise, I haven't had a chance to review it properly yet, but I'll
> try to take a closer look over the next few days.
> 
> Cheers,
> -- David
> 
>>   drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   4 +
>>   .../amd/display/tests/dc/dc_dmub_srv_test.c   | 285 ++++++++++++++++++
>>   2 files changed, 289 insertions(+)
>>   create mode 100644 drivers/gpu/drm/amd/display/tests/dc/dc_dmub_srv_test.c
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
>> index 2d61c2a91cee..f5dd1f69840e 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
>> @@ -809,3 +809,7 @@ void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv)
>>                  diag_data.is_cw0_enabled,
>>                  diag_data.is_cw6_enabled);
>>   }
>> +
>> +#if IS_ENABLED(CONFIG_AMD_DC_BASICS_KUNIT_TEST)
>> +#include "../tests/dc/dc_dmub_srv_test.c"
>> +#endif
>> diff --git a/drivers/gpu/drm/amd/display/tests/dc/dc_dmub_srv_test.c b/drivers/gpu/drm/amd/display/tests/dc/dc_dmub_srv_test.c
>> new file mode 100644
>> index 000000000000..051079cbf65e
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/display/tests/dc/dc_dmub_srv_test.c
>> @@ -0,0 +1,285 @@
>> +// SPDX-License-Identifier: MIT
>> +/*
>> + * KUnit tests for dc_dmub_srv.c
>> + *
>> + * Copyright (C) 2022, Maíra Canal <mairacanal@riseup.net>
>> + */
>> +
>> +#include <kunit/test.h>
>> +#include "dc_dmub_srv.h"
>> +
>> +struct populate_subvp_cmd_drr_info_test_case {
>> +       const char *desc;
>> +       struct dc *dc;
>> +       struct pipe_ctx *subvp_pipe;
>> +       struct pipe_ctx *vblank_pipe;
>> +       const u8 drr_in_use;
>> +       const u8 drr_window_size_ms;
>> +       const u16 min_vtotal_supported;
>> +       const u16 max_vtotal_supported;
>> +       const u8 use_ramping;
>> +};
>> +
>> +struct populate_subvp_cmd_drr_info_test_case populate_subvp_cmd_drr_info_cases[] = {
>> +       {
>> +               .desc = "Same Clock Frequency",
>> +               .dc = &(struct dc) {
>> +                       .caps = {
>> +                               .subvp_prefetch_end_to_mall_start_us = 0,
>> +                       }
>> +               },
>> +               .subvp_pipe = &(struct pipe_ctx) {
>> +                       .stream = &(struct dc_stream_state) {
>> +                               .timing = {
>> +                                       .h_total = 2784,
>> +                                       .v_addressable = 1080,
>> +                                       .pix_clk_100hz = 1855800,
>> +                               },
>> +                               .mall_stream_config = {
>> +                                       .paired_stream = &(struct dc_stream_state) {
>> +                                               .timing = {
>> +                                                       .h_total = 3600,
>> +                                                       .v_total = 1111,
>> +                                                       .v_addressable = 1080,
>> +                                                       .v_front_porch = 3,
>> +                                                       .pix_clk_100hz = 1855800,
>> +                                               },
>> +                                       },
>> +                               },
>> +                       },
>> +               },
>> +               .vblank_pipe = &(struct pipe_ctx) {
>> +                       .stream = &(struct dc_stream_state) {
>> +                               .timing = {
>> +                                       .h_total = 2784,
>> +                                       .v_total = 1111,
>> +                                       .v_addressable = 1080,
>> +                                       .pix_clk_100hz = 1855800,
>> +                               },
>> +                       },
>> +               },
>> +               .drr_in_use = true,
>> +               .use_ramping = false,
>> +               .drr_window_size_ms = 4,
>> +               .min_vtotal_supported = 2540,
>> +               .max_vtotal_supported = 2619,
>> +       },
>> +       {
>> +               .desc = "Same Clock Frequency with Prefetch End to Mall Start",
>> +               .dc = &(struct dc) {
>> +                       .caps = {
>> +                               .subvp_prefetch_end_to_mall_start_us = 500,
>> +                       }
>> +               },
>> +               .subvp_pipe = &(struct pipe_ctx) {
>> +                       .stream = &(struct dc_stream_state) {
>> +                               .timing = {
>> +                                       .h_total = 2784,
>> +                                       .v_addressable = 1080,
>> +                                       .pix_clk_100hz = 1855800,
>> +                               },
>> +                               .mall_stream_config = {
>> +                                       .paired_stream = &(struct dc_stream_state) {
>> +                                               .timing = {
>> +                                                       .h_total = 3600,
>> +                                                       .v_total = 1111,
>> +                                                       .v_addressable = 1080,
>> +                                                       .v_front_porch = 3,
>> +                                                       .pix_clk_100hz = 1855800,
>> +                                               },
>> +                                       },
>> +                               },
>> +                       },
>> +               },
>> +               .vblank_pipe = &(struct pipe_ctx) {
>> +                       .stream = &(struct dc_stream_state) {
>> +                               .timing = {
>> +                                       .h_total = 2784,
>> +                                       .v_total = 1111,
>> +                                       .v_addressable = 1080,
>> +                                       .pix_clk_100hz = 1855800,
>> +                               },
>> +                       },
>> +               },
>> +               .drr_in_use = true,
>> +               .use_ramping = false,
>> +               .drr_window_size_ms = 4,
>> +               .min_vtotal_supported = 2540,
>> +               .max_vtotal_supported = 2619,
>> +       },
>> +       {
>> +               .desc = "Same Clock Frequency Not Multiple of 2",
>> +               .dc = &(struct dc) {
>> +                       .caps = {
>> +                               .subvp_prefetch_end_to_mall_start_us = 0,
>> +                       }
>> +               },
>> +               .subvp_pipe = &(struct pipe_ctx) {
>> +                       .stream = &(struct dc_stream_state) {
>> +                               .timing = {
>> +                                       .h_total = 2784,
>> +                                       .v_addressable = 1080,
>> +                                       .pix_clk_100hz = 1866743,
>> +                               },
>> +                               .mall_stream_config = {
>> +                                       .paired_stream = &(struct dc_stream_state) {
>> +                                               .timing = {
>> +                                                       .h_total = 3600,
>> +                                                       .v_total = 2400,
>> +                                                       .v_addressable = 2360,
>> +                                                       .v_front_porch = 4,
>> +                                                       .pix_clk_100hz = 1866743,
>> +                                               },
>> +                                       },
>> +                               },
>> +                       },
>> +               },
>> +               .vblank_pipe = &(struct pipe_ctx) {
>> +                       .stream = &(struct dc_stream_state) {
>> +                               .timing = {
>> +                                       .h_total = 3600,
>> +                                       .v_total = 2400,
>> +                                       .v_addressable = 2360,
>> +                                       .pix_clk_100hz = 1866743,
>> +                               },
>> +                       },
>> +               },
>> +               .drr_in_use = true,
>> +               .use_ramping = false,
>> +               .drr_window_size_ms = 4,
>> +               .min_vtotal_supported = 1387,
>> +               .max_vtotal_supported = 2875,
>> +       },
>> +       {
>> +               .desc = "Different Clock Frequency for smaller h_total and v_total",
>> +               .dc = &(struct dc) {
>> +                       .caps = {
>> +                               .subvp_prefetch_end_to_mall_start_us = 300,
>> +                       }
>> +               },
>> +               .subvp_pipe = &(struct pipe_ctx) {
>> +                       .stream = &(struct dc_stream_state) {
>> +                               .timing = {
>> +                                       .h_total = 1280,
>> +                                       .v_addressable = 600,
>> +                                       .pix_clk_100hz = 1855800,
>> +                               },
>> +                               .mall_stream_config = {
>> +                                       .paired_stream = &(struct dc_stream_state) {
>> +                                               .timing = {
>> +                                                       .h_total = 1280,
>> +                                                       .v_total = 720,
>> +                                                       .v_addressable = 600,
>> +                                                       .v_front_porch = 4,
>> +                                                       .pix_clk_100hz = 1866743,
>> +                                               },
>> +                                       },
>> +                               },
>> +                       },
>> +               },
>> +               .vblank_pipe = &(struct pipe_ctx) {
>> +                       .stream = &(struct dc_stream_state) {
>> +                               .timing = {
>> +                                       .h_total = 1280,
>> +                                       .v_total = 720,
>> +                                       .v_addressable = 600,
>> +                                       .pix_clk_100hz = 2100800,
>> +                               },
>> +                       },
>> +               },
>> +               .drr_in_use = true,
>> +               .use_ramping = false,
>> +               .drr_window_size_ms = 4,
>> +               .min_vtotal_supported = 1477,
>> +               .max_vtotal_supported = 9954,
>> +       },
>> +       {
>> +               .desc = "Different Clock Frequency for approximately 1920x1080",
>> +               .dc = &(struct dc) {
>> +                       .caps = {
>> +                               .subvp_prefetch_end_to_mall_start_us = 0,
>> +                       }
>> +               },
>> +               .subvp_pipe = &(struct pipe_ctx) {
>> +                       .stream = &(struct dc_stream_state) {
>> +                               .timing = {
>> +                                       .h_total = 1920,
>> +                                       .v_addressable = 1000,
>> +                                       .pix_clk_100hz = 1855800,
>> +                               },
>> +                               .mall_stream_config = {
>> +                                       .paired_stream = &(struct dc_stream_state) {
>> +                                               .timing = {
>> +                                                       .h_total = 1911,
>> +                                                       .v_total = 1080,
>> +                                                       .v_addressable = 1000,
>> +                                                       .v_front_porch = 7,
>> +                                                       .pix_clk_100hz = 1866743,
>> +                                               },
>> +                                       },
>> +                               },
>> +                       },
>> +               },
>> +               .vblank_pipe = &(struct pipe_ctx) {
>> +                       .stream = &(struct dc_stream_state) {
>> +                               .timing = {
>> +                                       .h_total = 1280,
>> +                                       .v_total = 720,
>> +                                       .v_addressable = 600,
>> +                                       .pix_clk_100hz = 2100800,
>> +                               },
>> +                       },
>> +               },
>> +               .drr_in_use = true,
>> +               .use_ramping = false,
>> +               .drr_window_size_ms = 4,
>> +               .min_vtotal_supported = 2482,
>> +               .max_vtotal_supported = 8971,
>> +       },
>> +};
>> +
>> +static void populate_subvp_cmd_drr_info_test_to_desc(struct
>> +               populate_subvp_cmd_drr_info_test_case * t, char *desc)
>> +{
>> +       strcpy(desc, t->desc);
>> +}
>> +
>> +KUNIT_ARRAY_PARAM(populate_subvp_cmd_drr_info, populate_subvp_cmd_drr_info_cases,
>> +                 populate_subvp_cmd_drr_info_test_to_desc);
>> +
>> +static void populate_subvp_cmd_drr_info_test(struct kunit *test)
>> +{
>> +       const struct populate_subvp_cmd_drr_info_test_case *test_param =
>> +               test->param_value;
>> +       struct dmub_cmd_fw_assisted_mclk_switch_pipe_data_v2 *pipe_data;
>> +
>> +       pipe_data = kunit_kzalloc(test,
>> +                                 sizeof(struct dmub_cmd_fw_assisted_mclk_switch_pipe_data_v2),
>> +                                 GFP_KERNEL);
>> +
>> +       populate_subvp_cmd_drr_info(test_param->dc, test_param->subvp_pipe,
>> +                                   test_param->vblank_pipe, pipe_data);
> 
> Should this be hidden behind an #ifdef CONFIG_DRM_AMD_DC_DCN
> 
> Otherwise, there are build issues under UML:
> ../drivers/gpu/drm/amd/amdgpu/../display/dc/../tests/dc/dc_dmub_srv_test.c:
> In function ‘populate_subvp_cmd_drr_info_test’:
> ../drivers/gpu/drm/amd/amdgpu/../display/dc/../tests/dc/dc_dmub_srv_test.c:260:9:
> error: implicit declaration of function ‘populate_subvp_cmd_drr_info’;
> did you mean ‘populate_subvp_cmd_drr_info_test’? [-Werror
> =implicit-function-declaration]
>   260 |         populate_subvp_cmd_drr_info(test_param->dc,
> test_param->subvp_pipe,
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |         populate_subvp_cmd_drr_info_test
> cc1: some warnings being treated as errors
> make[5]: *** [../scripts/Makefile.build:249:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.o] Error 1
> 
> Making the test skip itself if this isn't enabled worked fine here.
> 
> 

Currently, we don't support UML as there are some build problems on 
AMDGPU. You can apply the patch that I sent previously to run the tests 
with UML, and this warning will not happen anymore, but for now, the 
tests will work properly only on x86_64.

Moreover, I don't know if it is worth adding an #ifdef 
CONFIG_DRM_AMD_DC_DCN on all the functions, as most of the functions 
that we are testing are built under CONFIG_DRM_AMD_DC_DCN.

Best Regards
- Maíra Canal

> 
> 
>> +
>> +       KUNIT_EXPECT_EQ(test, test_param->drr_in_use,
>> +                       pipe_data->pipe_config.vblank_data.drr_info.drr_in_use);
>> +       KUNIT_EXPECT_EQ(test, test_param->drr_window_size_ms,
>> +                       pipe_data->pipe_config.vblank_data.drr_info.drr_window_size_ms);
>> +       KUNIT_EXPECT_EQ(test, test_param->use_ramping,
>> +                       pipe_data->pipe_config.vblank_data.drr_info.use_ramping);
>> +       KUNIT_EXPECT_EQ(test, test_param->min_vtotal_supported,
>> +                       pipe_data->pipe_config.vblank_data.drr_info.min_vtotal_supported);
>> +       KUNIT_EXPECT_EQ(test, test_param->max_vtotal_supported,
>> +                       pipe_data->pipe_config.vblank_data.drr_info.max_vtotal_supported);
>> +}
>> +
>> +static struct kunit_case dc_dmub_srv_cases[] = {
>> +       KUNIT_CASE_PARAM(populate_subvp_cmd_drr_info_test, populate_subvp_cmd_drr_info_gen_params),
>> +       {  }
>> +};
>> +
>> +static struct kunit_suite dc_dmub_srv_suite = {
>> +       .name = "dc_dmub_srv",
>> +       .test_cases = dc_dmub_srv_cases,
>> +};
>> +
>> +kunit_test_suite(dc_dmub_srv_suite);
>> --
>> 2.37.0
>>
>> --
>> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20220811004010.61299-8-tales.aparecida%40gmail.com.
