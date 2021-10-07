Return-Path: <SRS0=WxFm=O3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18D7C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 10:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50BF46113E
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 10:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 50BF46113E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC6136F3DF;
	Thu,  7 Oct 2021 10:00:55 +0000 (UTC)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FF696F3E3
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Oct 2021 10:00:54 +0000 (UTC)
Received: by mail-qv1-xf36.google.com with SMTP id o13so3783360qvm.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Oct 2021 03:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XZLWA547OFTW6cOcZdRDvjK3t0IqE4h7hQEapz4LxG8=;
 b=dW4EvqMZXZL+2TIhrZixCGP8OlceaHGfQVemuCWj06n05WtL/RuDuo84Lv82dQMelh
 FAhyYt12krmYwC1UBVJ3e1TRAW/YFteW+Kzyy2QCOrGxTNwwJ5MuIcKUDnQMr+PUBO3W
 /wLUzcyZSFh87UlMQWUTf3uMFsHx9bPkBm5aA+1MxPIknAI7aW+GCo+iIaKp0Yam+dnk
 tRIZMi74H5enqzJnxuHhEEAcmj8TOtQaVaQJ4hI8L4TVg4azPa1LeX16OkkufHb0PYMf
 as9imx45km7fxzkj3jlIAfESE2ISE6hrlbgB6C4LsFPmqIlFqyI/GkbxJPlrBUaHICEB
 2QIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XZLWA547OFTW6cOcZdRDvjK3t0IqE4h7hQEapz4LxG8=;
 b=AIJM+kppozcrop1BmnctveaUuAtsWQtTXNGbxRTZszgscbk1wR+8FWqiEF/iVd3W10
 1NOWH7kRwusVnAAgMf6kd9d8pOubwZl3sqMkOb9vrXBTjHaa2u3SI02Mg4DNH6C2O3fZ
 9Sf15fA/g9cC982lK8lYpHaNkZWyd9CRKyva4umutPXL6YD6eTB44ayX7Hb7szJHB7l8
 MPEYbgIDkEIrVT6AuJtg2GVSnmVVfJRIy4C59ItPb+L0DQEtkhGzTLixobKe9/s16nU8
 PvJ2CJJ81qh7/+OGj/nNvowkiODRnGLsueM4D8Zecc3FEbg/pvEHDaOeOiu3YXH0g7wb
 sz6g==
X-Gm-Message-State: AOAM532A+GAi80Hy9JT/+uIpLV7y7OXuhgHhQG7nROnfURgokuXVcq5C
 /ZPd7AfPHWgz459xNlkpt4PprBUfv8Ykj8XOzVS6Bw==
X-Google-Smtp-Source: ABdhPJwOb2Op43gfGHNeNAzpLibO6XvNDoZH7dW4UwSDGJszWczcmN50D+0kfGHu3wKFFqFV5lzUGjHGBaDDmN9xfAQ=
X-Received: by 2002:ad4:5608:: with SMTP id ca8mr3111537qvb.0.1633600853197;
 Thu, 07 Oct 2021 03:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
 <20211005075205.3467938-12-Wayne.Lin@amd.com>
In-Reply-To: <20211005075205.3467938-12-Wayne.Lin@amd.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Thu, 7 Oct 2021 11:00:42 +0100
Message-ID: <CAHbf0-H3iJoQz5uy6G3s2AAyhH2EeGwPd423M4EUoT2qGrjwWA@mail.gmail.com>
Subject: Re: [PATCH v2 11/23] drm/amd/display: Implement DPIA clock recovery
 phase
To: Wayne Lin <Wayne.Lin@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, 
 Harry Wentland <Harry.Wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, 
 Rodrigo.Siqueira@amd.com, stylon.wang@amd.com, jude.shih@amd.com, 
 jimmy.kizito@amd.com, meenakshikumar.somasundaram@amd.com, 
 Jun Lei <Jun.Lei@amd.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi

This patch is giving me a build error with Werror when building with Clang-13

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dpia.c:195:2:
error: variable 'ts' is used uninitialized whenever switch default is
taken [-Werror,-Wsometimes-uninitialized]

        default:

        ^~~~~~~

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dpia.c:200:9:
note: uninitialized use occurs here

        return ts;

               ^~

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dpia.c:180:2:
note: variable 'ts' is declared here

        enum dpia_set_config_ts ts;

        ^

1 error generated.

Cheers

Mike


On Tue, 5 Oct 2021 at 08:57, Wayne Lin <Wayne.Lin@amd.com> wrote:
>
> From: Jimmy Kizito <Jimmy.Kizito@amd.com>
>
> [Why]
> Clock recovery is the mandatory first phase of DP link training.
>
> [How]
> - Implement clock recovery phase in DPIA training module.
> - Add helper functions for building SET_CONFIG messages.
>
> Reviewed-by: Jun Lei <Jun.Lei@amd.com>
> Acked-by: Wayne Lin <Wayne.Lin@amd.com>
> Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
> ---
>  .../drm/amd/display/dc/core/dc_link_dpia.c    | 420 +++++++++++++++++-
>  .../gpu/drm/amd/display/dc/inc/dc_link_dpia.h |  40 ++
>  2 files changed, 453 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
> index 5ffaf6ca372b..9608fd345936 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
> @@ -28,6 +28,9 @@
>  #include "inc/core_status.h"
>  #include "dc_link.h"
>  #include "dc_link_dp.h"
> +#include "dpcd_defs.h"
> +#include "link_hwss.h"
> +#include "inc/link_dpcd.h"
>
>  #define DC_LOGGER \
>         link->ctx->logger
> @@ -87,17 +90,385 @@ static enum link_training_result dpia_configure_link(struct dc_link *link,
>         return LINK_TRAINING_SUCCESS;
>  }
>
> +static enum dc_status core_link_send_set_config(struct dc_link *link,
> +               uint8_t msg_type, uint8_t msg_data)
> +{
> +       /** @todo Implement */
> +       return DC_OK;
> +}
> +
> +/* Build SET_CONFIG message data payload for specified message type. */
> +static uint8_t dpia_build_set_config_data(enum dpia_set_config_type type,
> +               struct dc_link *link,
> +               struct link_training_settings *lt_settings)
> +{
> +       union dpia_set_config_data data;
> +
> +       data.raw = 0;
> +
> +       switch (type) {
> +       case DPIA_SET_CFG_SET_LINK:
> +               data.set_link.mode = link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT ? 1 : 0;
> +               break;
> +       case DPIA_SET_CFG_SET_PHY_TEST_MODE:
> +               break;
> +       case DPIA_SET_CFG_SET_VSPE:
> +               /* Assume all lanes have same drive settings. */
> +               data.set_vspe.swing = lt_settings->lane_settings[0].VOLTAGE_SWING;
> +               data.set_vspe.pre_emph = lt_settings->lane_settings[0].PRE_EMPHASIS;
> +               data.set_vspe.max_swing_reached =
> +                       lt_settings->lane_settings[0].VOLTAGE_SWING == VOLTAGE_SWING_MAX_LEVEL ? 1 : 0;
> +               data.set_vspe.max_pre_emph_reached =
> +                       lt_settings->lane_settings[0].PRE_EMPHASIS == PRE_EMPHASIS_MAX_LEVEL ? 1 : 0;
> +               break;
> +       default:
> +               ASSERT(false); /* Message type not supported by helper function. */
> +               break;
> +       }
> +
> +       return data.raw;
> +}
> +
> +/* Convert DC training pattern to DPIA training stage. */
> +static enum dpia_set_config_ts convert_trng_ptn_to_trng_stg(enum dc_dp_training_pattern tps)
> +{
> +       enum dpia_set_config_ts ts;
> +
> +       switch (tps) {
> +       case DP_TRAINING_PATTERN_SEQUENCE_1:
> +               ts = DPIA_TS_TPS1;
> +               break;
> +       case DP_TRAINING_PATTERN_SEQUENCE_2:
> +               ts = DPIA_TS_TPS2;
> +               break;
> +       case DP_TRAINING_PATTERN_SEQUENCE_3:
> +               ts = DPIA_TS_TPS3;
> +               break;
> +       case DP_TRAINING_PATTERN_SEQUENCE_4:
> +               ts = DPIA_TS_TPS4;
> +               break;
> +       default:
> +               ASSERT(false); /* TPS not supported by helper function. */
> +               break;
> +       }
> +
> +       return ts;
> +}
> +
> +/* Write training pattern to DPCD. */
> +static enum dc_status dpcd_set_lt_pattern(struct dc_link *link,
> +       enum dc_dp_training_pattern pattern,
> +       uint32_t hop)
> +{
> +       union dpcd_training_pattern dpcd_pattern = { {0} };
> +       uint32_t dpcd_tps_offset = DP_TRAINING_PATTERN_SET;
> +       enum dc_status status;
> +
> +       if (hop != DPRX)
> +               dpcd_tps_offset = DP_TRAINING_PATTERN_SET_PHY_REPEATER1 +
> +                       ((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (hop - 1));
> +
> +       /* DpcdAddress_TrainingPatternSet */
> +       dpcd_pattern.v1_4.TRAINING_PATTERN_SET =
> +               dc_dp_training_pattern_to_dpcd_training_pattern(link, pattern);
> +
> +       dpcd_pattern.v1_4.SCRAMBLING_DISABLE =
> +               dc_dp_initialize_scrambling_data_symbols(link, pattern);
> +
> +       if (hop != DPRX) {
> +               DC_LOG_HW_LINK_TRAINING("%s\n LTTPR Repeater ID: %d\n 0x%X pattern = %x\n",
> +                                       __func__,
> +                                       hop,
> +                                       dpcd_tps_offset,
> +                                       dpcd_pattern.v1_4.TRAINING_PATTERN_SET);
> +       } else {
> +               DC_LOG_HW_LINK_TRAINING("%s\n 0x%X pattern = %x\n",
> +                                       __func__,
> +                                       dpcd_tps_offset,
> +                                       dpcd_pattern.v1_4.TRAINING_PATTERN_SET);
> +       }
> +
> +       status = core_link_write_dpcd(link,
> +                                     DP_TRAINING_PATTERN_SET,
> +                                     &dpcd_pattern.raw,
> +                                     sizeof(dpcd_pattern.raw));
> +
> +       return status;
> +}
> +
> +/* Execute clock recovery phase of link training for specified hop in display
> + * path.in non-transparent mode:
> + * - Driver issues both DPCD and SET_CONFIG transactions.
> + * - TPS1 is transmitted for any hops downstream of DPOA.
> + * - Drive (VS/PE) only transmitted for the hop immediately downstream of DPOA.
> + * - CR for the first hop (DPTX-to-DPIA) is assumed to be successful.
> + *
> + * @param link DPIA link being trained.
> + * @param lt_settings link_setting and drive settings (voltage swing and pre-emphasis).
> + * @param hop Hop in display path. DPRX = 0.
> + */
> +static enum link_training_result dpia_training_cr_non_transparent(struct dc_link *link,
> +               struct link_training_settings *lt_settings,
> +               uint32_t hop)
> +{
> +       enum link_training_result result = LINK_TRAINING_CR_FAIL_LANE0;
> +       uint8_t repeater_cnt = 0; /* Number of hops/repeaters in display path. */
> +       enum dc_status status;
> +       uint32_t retries_cr = 0; /* Number of consecutive attempts with same VS or PE. */
> +       uint32_t retry_count = 0;
> +       /* From DP spec, CR read interval is always 100us. */
> +       uint32_t wait_time_microsec = TRAINING_AUX_RD_INTERVAL;
> +       struct link_training_settings req_settings;
> +       enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
> +       union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = { { {0} } };
> +       union lane_align_status_updated dpcd_lane_status_updated = { {0} };
> +       uint8_t set_cfg_data;
> +       enum dpia_set_config_ts ts;
> +
> +       repeater_cnt = dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
> +
> +       /* Cap of LINK_TRAINING_MAX_CR_RETRY attempts at clock recovery.
> +        * Fix inherited from perform_clock_recovery_sequence() -
> +        * the DP equivalent of this function:
> +        * Required for Synaptics MST hub which can put the LT in
> +        * infinite loop by switching the VS between level 0 and level 1
> +        * continuously.
> +        */
> +       while ((retries_cr < LINK_TRAINING_MAX_RETRY_COUNT) &&
> +              (retry_count < LINK_TRAINING_MAX_CR_RETRY)) {
> +               /* DPTX-to-DPIA */
> +               if (hop == repeater_cnt) {
> +                       /* Send SET_CONFIG(SET_LINK:LC,LR,LTTPR) to notify DPOA that
> +                        * non-transparent link training has started.
> +                        * This also enables the transmission of clk_sync packets.
> +                        */
> +                       set_cfg_data = dpia_build_set_config_data(DPIA_SET_CFG_SET_LINK,
> +                                       link,
> +                                       lt_settings);
> +                       status = core_link_send_set_config(link,
> +                                       DPIA_SET_CFG_SET_LINK,
> +                                       set_cfg_data);
> +                       /* CR for this hop is considered successful as long as
> +                        * SET_CONFIG message is acknowledged by DPOA.
> +                        */
> +                       if (status == DC_OK)
> +                               result = LINK_TRAINING_SUCCESS;
> +                       else
> +                               result = LINK_TRAINING_ABORT;
> +                       break;
> +               }
> +
> +               /* DPOA-to-x */
> +               /* Instruct DPOA to transmit TPS1 then update DPCD. */
> +               if (retry_count == 0) {
> +                       ts = convert_trng_ptn_to_trng_stg(lt_settings->pattern_for_cr);
> +                       status = core_link_send_set_config(link,
> +                                       DPIA_SET_CFG_SET_TRAINING,
> +                                       ts);
> +                       if (status != DC_OK) {
> +                               result = LINK_TRAINING_ABORT;
> +                               break;
> +                       }
> +                       status = dpcd_set_lt_pattern(link, lt_settings->pattern_for_cr, hop);
> +                       if (status != DC_OK) {
> +                               result = LINK_TRAINING_ABORT;
> +                               break;
> +                       }
> +               }
> +
> +               /* Update DPOA drive settings then DPCD. DPOA does only adjusts
> +                * drive settings for hops immediately downstream.
> +                */
> +               if (hop == repeater_cnt - 1) {
> +                       set_cfg_data = dpia_build_set_config_data(DPIA_SET_CFG_SET_VSPE,
> +                                       link,
> +                                       lt_settings);
> +                       status = core_link_send_set_config(link,
> +                                       DPIA_SET_CFG_SET_VSPE,
> +                                       set_cfg_data);
> +                       if (status != DC_OK) {
> +                               result = LINK_TRAINING_ABORT;
> +                               break;
> +                       }
> +               }
> +               status = dpcd_set_lane_settings(link, lt_settings, hop);
> +               if (status != DC_OK) {
> +                       result = LINK_TRAINING_ABORT;
> +                       break;
> +               }
> +
> +               dp_wait_for_training_aux_rd_interval(link, wait_time_microsec);
> +
> +               /* Read status and adjustment requests from DPCD. */
> +               status = dp_get_lane_status_and_drive_settings(link,
> +                               lt_settings,
> +                               dpcd_lane_status,
> +                               &dpcd_lane_status_updated,
> +                               &req_settings,
> +                               hop);
> +               if (status != DC_OK) {
> +                       result = LINK_TRAINING_ABORT;
> +                       break;
> +               }
> +
> +               /* Check if clock recovery successful. */
> +               if (dp_is_cr_done(lane_count, dpcd_lane_status)) {
> +                       result = LINK_TRAINING_SUCCESS;
> +                       break;
> +               }
> +
> +               result = dp_get_cr_failure(lane_count, dpcd_lane_status);
> +
> +               if (dp_is_max_vs_reached(lt_settings))
> +                       break;
> +
> +               /* Count number of attempts with same drive settings.
> +                * Note: settings are the same for all lanes,
> +                * so comparing first lane is sufficient.
> +                */
> +               if (lt_settings->lane_settings[0].VOLTAGE_SWING ==
> +                       req_settings.lane_settings[0].VOLTAGE_SWING &&
> +                       lt_settings->lane_settings[0].PRE_EMPHASIS ==
> +                       req_settings.lane_settings[0].PRE_EMPHASIS)
> +                       retries_cr++;
> +               else
> +                       retries_cr = 0;
> +
> +               /* Update VS/PE. */
> +               dp_update_drive_settings(lt_settings, req_settings);
> +               retry_count++;
> +       }
> +
> +       /* Abort link training if clock recovery failed due to HPD unplug. */
> +       if (!link->hpd_status)
> +               result = LINK_TRAINING_ABORT;
> +
> +       DC_LOG_HW_LINK_TRAINING("%s\n DPIA(%d) clock recovery\n -hop(%d)\n - result(%d)\n - retries(%d)\n",
> +                               __func__,
> +                               link->link_id.enum_id - ENUM_ID_1,
> +                               hop,
> +                               result,
> +                               retry_count);
> +
> +       return result;
> +}
> +
> +/* Execute clock recovery phase of link training in transparent LTTPR mode:
> + * - Driver only issues DPCD transactions and leaves USB4 tunneling (SET_CONFIG) messages to DPIA.
> + * - Driver writes TPS1 to DPCD to kick off training.
> + * - Clock recovery (CR) for link is handled by DPOA, which reports result to DPIA on completion.
> + * - DPIA communicates result to driver by updating CR status when driver reads DPCD.
> + *
> + * @param link DPIA link being trained.
> + * @param lt_settings link_setting and drive settings (voltage swing and pre-emphasis).
> + */
> +static enum link_training_result dpia_training_cr_transparent(struct dc_link *link,
> +               struct link_training_settings *lt_settings)
> +{
> +       enum link_training_result result = LINK_TRAINING_CR_FAIL_LANE0;
> +       enum dc_status status;
> +       uint32_t retries_cr = 0; /* Number of consecutive attempts with same VS or PE. */
> +       uint32_t retry_count = 0;
> +       uint32_t wait_time_microsec = lt_settings->cr_pattern_time;
> +       struct link_training_settings req_settings;
> +       enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
> +       union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = { { {0} } };
> +       union lane_align_status_updated dpcd_lane_status_updated = { {0} };
> +
> +       /* Cap of LINK_TRAINING_MAX_CR_RETRY attempts at clock recovery.
> +        * Fix inherited from perform_clock_recovery_sequence() -
> +        * the DP equivalent of this function:
> +        * Required for Synaptics MST hub which can put the LT in
> +        * infinite loop by switching the VS between level 0 and level 1
> +        * continuously.
> +        */
> +       while ((retries_cr < LINK_TRAINING_MAX_RETRY_COUNT) &&
> +              (retry_count < LINK_TRAINING_MAX_CR_RETRY)) {
> +               /* Write TPS1 (not VS or PE) to DPCD to start CR phase.
> +                * DPIA sends SET_CONFIG(SET_LINK) to notify DPOA to
> +                * start link training.
> +                */
> +               if (retry_count == 0) {
> +                       status = dpcd_set_lt_pattern(link, lt_settings->pattern_for_cr, DPRX);
> +                       if (status != DC_OK) {
> +                               result = LINK_TRAINING_ABORT;
> +                               break;
> +                       }
> +               }
> +
> +               dp_wait_for_training_aux_rd_interval(link, wait_time_microsec);
> +
> +               /* Read status and adjustment requests from DPCD. */
> +               status = dp_get_lane_status_and_drive_settings(link,
> +                               lt_settings,
> +                               dpcd_lane_status,
> +                               &dpcd_lane_status_updated,
> +                               &req_settings,
> +                               DPRX);
> +               if (status != DC_OK) {
> +                       result = LINK_TRAINING_ABORT;
> +                       break;
> +               }
> +
> +               /* Check if clock recovery successful. */
> +               if (dp_is_cr_done(lane_count, dpcd_lane_status)) {
> +                       result = LINK_TRAINING_SUCCESS;
> +                       break;
> +               }
> +
> +               result = dp_get_cr_failure(lane_count, dpcd_lane_status);
> +
> +               if (dp_is_max_vs_reached(lt_settings))
> +                       break;
> +
> +               /* Count number of attempts with same drive settings.
> +                * Note: settings are the same for all lanes,
> +                * so comparing first lane is sufficient.
> +                */
> +               if (lt_settings->lane_settings[0].VOLTAGE_SWING ==
> +                       req_settings.lane_settings[0].VOLTAGE_SWING &&
> +                       lt_settings->lane_settings[0].PRE_EMPHASIS ==
> +                       req_settings.lane_settings[0].PRE_EMPHASIS)
> +                       retries_cr++;
> +               else
> +                       retries_cr = 0;
> +
> +               /* Update VS/PE. */
> +               dp_update_drive_settings(lt_settings, req_settings);
> +               retry_count++;
> +       }
> +
> +       /* Abort link training if clock recovery failed due to HPD unplug. */
> +       if (!link->hpd_status)
> +               result = LINK_TRAINING_ABORT;
> +
> +       DC_LOG_HW_LINK_TRAINING("%s\n DPIA(%d) clock recovery\n -hop(%d)\n - result(%d)\n - retries(%d)\n",
> +                               __func__,
> +                               link->link_id.enum_id - ENUM_ID_1,
> +                               DPRX,
> +                               result,
> +                               retry_count);
> +
> +       return result;
> +}
> +
>  /* Execute clock recovery phase of link training for specified hop in display
>   * path.
> + *
> + * @param link DPIA link being trained.
> + * @param lt_settings link_setting and drive settings (voltage swing and pre-emphasis).
> + * @param hop Hop in display path. DPRX = 0.
>   */
>  static enum link_training_result dpia_training_cr_phase(struct dc_link *link,
>                 struct link_training_settings *lt_settings,
>                 uint32_t hop)
>  {
> -       enum link_training_result result;
> +       enum link_training_result result = LINK_TRAINING_CR_FAIL_LANE0;
>
> -       /** @todo Fail until implemented. */
> -       result = LINK_TRAINING_ABORT;
> +       if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT)
> +               result = dpia_training_cr_non_transparent(link, lt_settings, hop);
> +       else
> +               result = dpia_training_cr_transparent(link, lt_settings);
>
>         return result;
>  }
> @@ -129,6 +500,38 @@ static enum link_training_result dpia_training_end(struct dc_link *link,
>         return result;
>  }
>
> +/* When aborting training of specified hop in display path, clean up by:
> + * - Attempting to clear DPCD TRAINING_PATTERN_SET, LINK_BW_SET and LANE_COUNT_SET.
> + * - Sending SET_CONFIG(SET_LINK) with lane count and link rate set to 0.
> + *
> + * @param link DPIA link being trained.
> + * @param hop Hop in display path. DPRX = 0.
> + */
> +static void dpia_training_abort(struct dc_link *link, uint32_t hop)
> +{
> +       uint8_t data = 0;
> +       uint32_t dpcd_tps_offset = DP_TRAINING_PATTERN_SET;
> +
> +       DC_LOG_HW_LINK_TRAINING("%s\n DPIA(%d) aborting\n - LTTPR mode(%d)\n - HPD(%d)\n",
> +                               __func__,
> +                               link->link_id.enum_id - ENUM_ID_1,
> +                               link->lttpr_mode,
> +                               link->hpd_status);
> +
> +       /* Abandon clean-up if sink unplugged. */
> +       if (!link->hpd_status)
> +               return;
> +
> +       if (hop != DPRX)
> +               dpcd_tps_offset = DP_TRAINING_PATTERN_SET_PHY_REPEATER1 +
> +                       ((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (hop - 1));
> +
> +       core_link_write_dpcd(link, dpcd_tps_offset, &data, 1);
> +       core_link_write_dpcd(link, DP_LINK_BW_SET, &data, 1);
> +       core_link_write_dpcd(link, DP_LANE_COUNT_SET, &data, 1);
> +       core_link_send_set_config(link, DPIA_SET_CFG_SET_LINK, data);
> +}
> +
>  enum link_training_result dc_link_dpia_perform_link_training(struct dc_link *link,
>         const struct dc_link_settings *link_setting,
>         bool skip_video_pattern)
> @@ -166,14 +569,17 @@ enum link_training_result dc_link_dpia_perform_link_training(struct dc_link *lin
>                         break;
>         }
>
> -       /* Double-check link status if training successful; gracefully stop
> -        * training of current hop if training failed for any reason other than
> -        * sink unplug.
> +       /* Double-check link status if training successful; gracefully abort
> +        * training of current hop if training failed due to message tunneling
> +        * failure; end training of hop if training ended conventionally and
> +        * falling back to lower bandwidth settings possible.
>          */
>         if (result == LINK_TRAINING_SUCCESS) {
>                 msleep(5);
>                 result = dp_check_link_loss_status(link, &lt_settings);
> -       } else if (result != LINK_TRAINING_ABORT) {
> +       } else if (result == LINK_TRAINING_ABORT) {
> +               dpia_training_abort(link, repeater_id);
> +       } else {
>                 dpia_training_end(link, repeater_id);
>         }
>         return result;
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
> index 1392eb689d1e..76b6b1e23575 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
> @@ -31,6 +31,46 @@
>  struct dc_link;
>  struct dc_link_settings;
>
> +/* The approximate time (us) it takes to transmit 9 USB4 DP clock sync packets. */
> +#define DPIA_CLK_SYNC_DELAY 16000
> +
> +/* SET_CONFIG message types sent by driver. */
> +enum dpia_set_config_type {
> +       DPIA_SET_CFG_SET_LINK = 0x01,
> +       DPIA_SET_CFG_SET_PHY_TEST_MODE = 0x05,
> +       DPIA_SET_CFG_SET_TRAINING = 0x18,
> +       DPIA_SET_CFG_SET_VSPE = 0x19
> +};
> +
> +/* Training stages (TS) in SET_CONFIG(SET_TRAINING) message. */
> +enum dpia_set_config_ts {
> +       DPIA_TS_DPRX_DONE = 0x00, /* Done training DPRX. */
> +       DPIA_TS_TPS1 = 0x01,
> +       DPIA_TS_TPS2 = 0x02,
> +       DPIA_TS_TPS3 = 0x03,
> +       DPIA_TS_TPS4 = 0x07,
> +       DPIA_TS_UFP_DONE = 0xff /* Done training DPTX-to-DPIA hop. */
> +};
> +
> +/* SET_CONFIG message data associated with messages sent by driver. */
> +union dpia_set_config_data {
> +       struct {
> +               uint8_t mode : 1;
> +               uint8_t reserved : 7;
> +       } set_link;
> +       struct {
> +               uint8_t stage;
> +       } set_training;
> +       struct {
> +               uint8_t swing : 2;
> +               uint8_t max_swing_reached : 1;
> +               uint8_t pre_emph : 2;
> +               uint8_t max_pre_emph_reached : 1;
> +               uint8_t reserved : 2;
> +       } set_vspe;
> +       uint8_t raw;
> +};
> +
>  /* Read tunneling device capability from DPCD and update link capability
>   * accordingly.
>   */
> --
> 2.25.1
>
