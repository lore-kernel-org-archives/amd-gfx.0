Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD06CD3B98B
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 17:39:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0195010E637;
	Tue,  9 Dec 2025 17:39:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I15GNeId";
	dkim-atps=neutral
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE38710E637
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 17:39:06 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-7baa5787440so522494b3a.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Dec 2025 09:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765301946; x=1765906746; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=scf5q+0s3wMyzUYRgD/IWOZ3a3fw8fKvdmukhDzBXTg=;
 b=I15GNeIdtEEZ/MeQLmfucrYSxOzbhNT8dlwOZFIKMu60aysnk6n1MFxMn+TnFrAjt3
 6j7vnB8g2MzcBpx2ci3rHEak1PdGjUlU1QL+ZZfOpUdT7YSQYUOfJyPCY4WGpHg7HJHI
 fTf3Lrrx4kukLlfmkH60859MOw3UC3jW11o+wJM/pl/JByuF2Ck0zpQydGzlq3593s3l
 T/ee6CQZQjEiZS/TbfyjbWVinXjA9HTV8PRA98aY0WJX2Xx3dhDOEl9td6k5ysZooSKV
 vGJhUQ1rhsH0AFf58mGQPVkbo2tGBlJfuKKAcWHmUDjKeT+q5+4ZNn/idC4SNgmtf+mE
 zAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765301946; x=1765906746;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=scf5q+0s3wMyzUYRgD/IWOZ3a3fw8fKvdmukhDzBXTg=;
 b=p4C3x9u5e0W78m3SChCAgIyjhiKCgW+JKBbVjGBD1wWX2vkzUJsWsVQ9S2wuK38K95
 dxLneRUynEf2/DiFVJouTJGTOonyMlxm+dbSudU75gT81weSBFd+QabYPtoZ42ZegY9p
 N65wnodhana/ovJXqyPBTFKMmloYEXzey3bl1t2wO1nXhdU6fpfT+my7j6dRGY/2Jv57
 IrfgzqjfdYXwVRjPFJivlX1Ai8sR6DB8YIupfgGf9SsRi/dh5lulS7vCsTW8zrIJg89q
 IXWBJYon+zQbU8FB6R5WrCn9KPPfyErqY7mVAwCDq+vmTAJue82sPTb8PTpOW+NqjfMj
 CkUw==
X-Gm-Message-State: AOJu0YxbpDDpT6g0JnqkTS6k5ChcY0WR+HxB4T2eS5vyRYpJDT6TMUc3
 eVju73Un7X69VzdRBGqvT8DT5MEGwrbNP13o+ZKSwwWGxBUSLQqr3Tid3fpjHyhp3hgbNzhNDl/
 28koCbezE2c9ggQGLycH0kkU06MDI/6I=
X-Gm-Gg: ASbGnct9ufVgNDpFnyHrf3c/9GkW+lFKz8WuTkBJr3UBzr3SzpCHYdwgdgdJaQGOp2k
 somP6yq2IEDpaV7PVoljGhevKjEsZj+E4l20UA68L5yRTZGOQdtCBb7qxx8qoO64Mk3yaD+/UfZ
 G2qUR8h0Dh8nRj1ZoIfZKSfPJSfZXKWjy3Gir3hkPk9cWc++KG5tSRvzd75tNUwvvWYbBuvaLFV
 24Wq3NROLPW3WvD3l4EYwLVJ5aCWKj+LMlPccpo7/UAQZBDt/OkNcueVHBblLNgBirgF5k=
X-Google-Smtp-Source: AGHT+IEIfMnZrDOZIAZizXLjusBYlysHvqTBGVTJ6O/RM4zJA3/NW94DtI1gvOTIrZxr7Y7e2YvUsJESl4t5jkmQCcQ=
X-Received: by 2002:a05:7022:323:b0:11b:65e:f33 with SMTP id
 a92af1059eb24-11e03168cb3mr4783691c88.1.1765301945900; Tue, 09 Dec 2025
 09:39:05 -0800 (PST)
MIME-Version: 1.0
References: <20251209171810.2514240-1-mario.limonciello@amd.com>
In-Reply-To: <20251209171810.2514240-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Dec 2025 12:38:54 -0500
X-Gm-Features: AQt7F2pipxZirUMos8ZVYZFNY1h1cynbTdEfFCmkqLomC9hSeF8U4RhYwDuXNHo
Message-ID: <CADnq5_NPH4NEnTKJLhA9jU8YLo=JdOsqNjCG4YZvut4j6BpFsw@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: Fix pbn to kbps Conversion"
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Jerry Zuo <jerry.zuo@amd.com>, 
 stable@vger.kernel.org, nat@nullable.se
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

On Tue, Dec 9, 2025 at 12:34=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Deeply daisy chained DP/MST displays are no longer able to light
> up. This reverts commit 1788ef30725da53face7e311cdf62ad65fababcd.
>
> Cc: Jerry Zuo <jerry.zuo@amd.com>
> Cc: stable@vger.kernel.org # 6.17+
> Reported-by: nat@nullable.se
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4756
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 59 +++++++++++--------
>  1 file changed, 36 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index dbd1da4d85d3..5e92eaa67aa3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -884,28 +884,26 @@ struct dsc_mst_fairness_params {
>  };
>
>  #if defined(CONFIG_DRM_AMD_DC_FP)
> -static uint64_t kbps_to_pbn(int kbps, bool is_peak_pbn)
> +static uint16_t get_fec_overhead_multiplier(struct dc_link *dc_link)
>  {
> -       uint64_t effective_kbps =3D (uint64_t)kbps;
> +       u8 link_coding_cap;
> +       uint16_t fec_overhead_multiplier_x1000 =3D PBN_FEC_OVERHEAD_MULTI=
PLIER_8B_10B;
>
> -       if (is_peak_pbn) {      // add 0.6% (1006/1000) overhead into eff=
ective kbps
> -               effective_kbps *=3D 1006;
> -               effective_kbps =3D div_u64(effective_kbps, 1000);
> -       }
> +       link_coding_cap =3D dc_link_dp_mst_decide_link_encoding_format(dc=
_link);
> +       if (link_coding_cap =3D=3D DP_128b_132b_ENCODING)
> +               fec_overhead_multiplier_x1000 =3D PBN_FEC_OVERHEAD_MULTIP=
LIER_128B_132B;
>
> -       return (uint64_t) DIV64_U64_ROUND_UP(effective_kbps * 64, (54 * 8=
 * 1000));
> +       return fec_overhead_multiplier_x1000;
>  }
>
> -static uint32_t pbn_to_kbps(unsigned int pbn, bool with_margin)
> +static int kbps_to_peak_pbn(int kbps, uint16_t fec_overhead_multiplier_x=
1000)
>  {
> -       uint64_t pbn_effective =3D (uint64_t)pbn;
> -
> -       if (with_margin)        // deduct 0.6% (994/1000) overhead from e=
ffective pbn
> -               pbn_effective *=3D (1000000 / PEAK_FACTOR_X1000);
> -       else
> -               pbn_effective *=3D 1000;
> +       u64 peak_kbps =3D kbps;
>
> -       return DIV_U64_ROUND_UP(pbn_effective * 8 * 54, 64);
> +       peak_kbps *=3D 1006;
> +       peak_kbps *=3D fec_overhead_multiplier_x1000;
> +       peak_kbps =3D div_u64(peak_kbps, 1000 * 1000);
> +       return (int) DIV64_U64_ROUND_UP(peak_kbps * 64, (54 * 8 * 1000));
>  }
>
>  static void set_dsc_configs_from_fairness_vars(struct dsc_mst_fairness_p=
arams *params,
> @@ -976,7 +974,7 @@ static int bpp_x16_from_pbn(struct dsc_mst_fairness_p=
arams param, int pbn)
>         dc_dsc_get_default_config_option(param.sink->ctx->dc, &dsc_option=
s);
>         dsc_options.max_target_bpp_limit_override_x16 =3D drm_connector->=
display_info.max_dsc_bpp * 16;
>
> -       kbps =3D pbn_to_kbps(pbn, false);
> +       kbps =3D div_u64((u64)pbn * 994 * 8 * 54, 64);
>         dc_dsc_compute_config(
>                         param.sink->ctx->dc->res_pool->dscs[0],
>                         &param.sink->dsc_caps.dsc_dec_caps,
> @@ -1005,11 +1003,12 @@ static int increase_dsc_bpp(struct drm_atomic_sta=
te *state,
>         int link_timeslots_used;
>         int fair_pbn_alloc;
>         int ret =3D 0;
> +       uint16_t fec_overhead_multiplier_x1000 =3D get_fec_overhead_multi=
plier(dc_link);
>
>         for (i =3D 0; i < count; i++) {
>                 if (vars[i + k].dsc_enabled) {
>                         initial_slack[i] =3D
> -                       kbps_to_pbn(params[i].bw_range.max_kbps, false) -=
 vars[i + k].pbn;
> +                       kbps_to_peak_pbn(params[i].bw_range.max_kbps, fec=
_overhead_multiplier_x1000) - vars[i + k].pbn;
>                         bpp_increased[i] =3D false;
>                         remaining_to_increase +=3D 1;
>                 } else {
> @@ -1105,6 +1104,7 @@ static int try_disable_dsc(struct drm_atomic_state =
*state,
>         int next_index;
>         int remaining_to_try =3D 0;
>         int ret;
> +       uint16_t fec_overhead_multiplier_x1000 =3D get_fec_overhead_multi=
plier(dc_link);
>         int var_pbn;
>
>         for (i =3D 0; i < count; i++) {
> @@ -1137,7 +1137,7 @@ static int try_disable_dsc(struct drm_atomic_state =
*state,
>
>                 DRM_DEBUG_DRIVER("MST_DSC index #%d, try no compression\n=
", next_index);
>                 var_pbn =3D vars[next_index].pbn;
> -               vars[next_index].pbn =3D kbps_to_pbn(params[next_index].b=
w_range.stream_kbps, true);
> +               vars[next_index].pbn =3D kbps_to_peak_pbn(params[next_ind=
ex].bw_range.stream_kbps, fec_overhead_multiplier_x1000);
>                 ret =3D drm_dp_atomic_find_time_slots(state,
>                                                     params[next_index].po=
rt->mgr,
>                                                     params[next_index].po=
rt,
> @@ -1197,6 +1197,7 @@ static int compute_mst_dsc_configs_for_link(struct =
drm_atomic_state *state,
>         int count =3D 0;
>         int i, k, ret;
>         bool debugfs_overwrite =3D false;
> +       uint16_t fec_overhead_multiplier_x1000 =3D get_fec_overhead_multi=
plier(dc_link);
>         struct drm_connector_state *new_conn_state;
>
>         memset(params, 0, sizeof(params));
> @@ -1277,7 +1278,7 @@ static int compute_mst_dsc_configs_for_link(struct =
drm_atomic_state *state,
>         DRM_DEBUG_DRIVER("MST_DSC Try no compression\n");
>         for (i =3D 0; i < count; i++) {
>                 vars[i + k].aconnector =3D params[i].aconnector;
> -               vars[i + k].pbn =3D kbps_to_pbn(params[i].bw_range.stream=
_kbps, false);
> +               vars[i + k].pbn =3D kbps_to_peak_pbn(params[i].bw_range.s=
tream_kbps, fec_overhead_multiplier_x1000);
>                 vars[i + k].dsc_enabled =3D false;
>                 vars[i + k].bpp_x16 =3D 0;
>                 ret =3D drm_dp_atomic_find_time_slots(state, params[i].po=
rt->mgr, params[i].port,
> @@ -1299,7 +1300,7 @@ static int compute_mst_dsc_configs_for_link(struct =
drm_atomic_state *state,
>         DRM_DEBUG_DRIVER("MST_DSC Try max compression\n");
>         for (i =3D 0; i < count; i++) {
>                 if (params[i].compression_possible && params[i].clock_for=
ce_enable !=3D DSC_CLK_FORCE_DISABLE) {
> -                       vars[i + k].pbn =3D kbps_to_pbn(params[i].bw_rang=
e.min_kbps, false);
> +                       vars[i + k].pbn =3D kbps_to_peak_pbn(params[i].bw=
_range.min_kbps, fec_overhead_multiplier_x1000);
>                         vars[i + k].dsc_enabled =3D true;
>                         vars[i + k].bpp_x16 =3D params[i].bw_range.min_ta=
rget_bpp_x16;
>                         ret =3D drm_dp_atomic_find_time_slots(state, para=
ms[i].port->mgr,
> @@ -1307,7 +1308,7 @@ static int compute_mst_dsc_configs_for_link(struct =
drm_atomic_state *state,
>                         if (ret < 0)
>                                 return ret;
>                 } else {
> -                       vars[i + k].pbn =3D kbps_to_pbn(params[i].bw_rang=
e.stream_kbps, false);
> +                       vars[i + k].pbn =3D kbps_to_peak_pbn(params[i].bw=
_range.stream_kbps, fec_overhead_multiplier_x1000);
>                         vars[i + k].dsc_enabled =3D false;
>                         vars[i + k].bpp_x16 =3D 0;
>                         ret =3D drm_dp_atomic_find_time_slots(state, para=
ms[i].port->mgr,
> @@ -1762,6 +1763,18 @@ int pre_validate_dsc(struct drm_atomic_state *stat=
e,
>         return ret;
>  }
>
> +static uint32_t kbps_from_pbn(unsigned int pbn)
> +{
> +       uint64_t kbps =3D (uint64_t)pbn;
> +
> +       kbps *=3D (1000000 / PEAK_FACTOR_X1000);
> +       kbps *=3D 8;
> +       kbps *=3D 54;
> +       kbps /=3D 64;
> +
> +       return (uint32_t)kbps;
> +}
> +
>  static bool is_dsc_common_config_possible(struct dc_stream_state *stream=
,
>                                           struct dc_dsc_bw_range *bw_rang=
e)
>  {
> @@ -1860,7 +1873,7 @@ enum dc_status dm_dp_mst_is_port_support_mode(
>                         dc_link_get_highest_encoding_format(stream->link)=
);
>         cur_link_settings =3D stream->link->verified_link_cap;
>         root_link_bw_in_kbps =3D dc_link_bandwidth_kbps(aconnector->dc_li=
nk, &cur_link_settings);
> -       virtual_channel_bw_in_kbps =3D pbn_to_kbps(aconnector->mst_output=
_port->full_pbn, true);
> +       virtual_channel_bw_in_kbps =3D kbps_from_pbn(aconnector->mst_outp=
ut_port->full_pbn);
>
>         /* pick the end to end bw bottleneck */
>         end_to_end_bw_in_kbps =3D min(root_link_bw_in_kbps, virtual_chann=
el_bw_in_kbps);
> @@ -1913,7 +1926,7 @@ enum dc_status dm_dp_mst_is_port_support_mode(
>                                 immediate_upstream_port =3D aconnector->m=
st_output_port->parent->port_parent;
>
>                         if (immediate_upstream_port) {
> -                               virtual_channel_bw_in_kbps =3D pbn_to_kbp=
s(immediate_upstream_port->full_pbn, true);
> +                               virtual_channel_bw_in_kbps =3D kbps_from_=
pbn(immediate_upstream_port->full_pbn);
>                                 virtual_channel_bw_in_kbps =3D min(root_l=
ink_bw_in_kbps, virtual_channel_bw_in_kbps);
>                         } else {
>                                 /* For topology LCT 1 case - only one mst=
b*/
> --
> 2.51.2
>
