Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A56C33C8C
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 16:51:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C77DF20678
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 16:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bt2qsoic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77DF20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B4A96E111;
	Tue,  7 Jan 2020 16:50:59 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FF5A6E111
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 16:50:58 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id p9so239007wmc.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jan 2020 08:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0dOvh9IKm13DDdzjSBTOfmp1VJkmTdPFhzXzNty3zuo=;
 b=bt2qsoic73qIaJHU1SdTBpVGpvFCtqTK23jCWpCp2XNdR8/yq100co6VsZWWDprmvp
 CHimIB+GgXxPydofXWji6boRqo/14Z1x41vBg42vn39GJ0lqQB90ITMLi3ydMplhoVSz
 sb4c7M3UWWLV7DCrlmk7f8JSVCagPPRH5K1Xv013wiG3Y2lz6r0NnJRh3pd6G4lVMyyY
 8+1O0S3N0ov2wF99aLMcZpURgX35+J94+Wrng5HzNQjIEqPPF7spvBgEWsQzW9HvcbSd
 vdBYTseya+2/B9ML1jfHBuGKnBPKgJBjbkOTMemrOzlmKEiHhLfkwvtMR8/bkSiW1j4m
 fGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0dOvh9IKm13DDdzjSBTOfmp1VJkmTdPFhzXzNty3zuo=;
 b=eCuUOMMy50C6NF8xgReZmO6GpGWvwSujuo6k5hJzSXFZ2+OQHoarwgoG/GbRn+XWax
 OXgWZHwm6gTA5HacYfyYZCD+EoogqUV6JEj6K17Coph40FyDhmi8ibwcvrlqQbuhBvRY
 ufS857G+nZbsbHJrDveO2luXe7rdCF8eWcjWKtoIaVUrFdPuHXuJ50n07yQ0R3T0Pt7+
 6ASWnkPi12iU1dwHzJlQAH63tPy7/F5Ew54NBAqvt59T5dEk4ahEdao+1SLdgOIcx4ru
 O0hB9hGheq/qf+EDgm/ZVak+Ur1k17EGwEj6M2yOCwr1zu/WsTiSPuMtDicUMUS8Vt2J
 JgGA==
X-Gm-Message-State: APjAAAUoL+3y876dgIFXO0XmDWg4iYS7Eoj5D91uQk7sPYimZg0ywTqH
 w34Oq8lAQznhu5L+FR6zj1tJ5MWWPuMLyW++4PoN/g==
X-Google-Smtp-Source: APXvYqwxOkaqdVqV/BrY9/3wE1Ow6AdMoYClpLLDkSrMjGmhLqMAXXcCl4kTyltWtQH8rQE/2qicO0Pe6ZUA0+qFGAA=
X-Received: by 2002:a1c:486:: with SMTP id 128mr42469523wme.163.1578415857100; 
 Tue, 07 Jan 2020 08:50:57 -0800 (PST)
MIME-Version: 1.0
References: <20200107164112.6481-1-mikita.lipski@amd.com>
In-Reply-To: <20200107164112.6481-1-mikita.lipski@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Jan 2020 11:50:45 -0500
Message-ID: <CADnq5_NQqHP67pkCU-FF=zT8BD1mXQ8AV50Lp1bW1gpj=t4XzA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Check return value of drm helper
To: "Lipski, Mikita" <mikita.lipski@amd.com>
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 7, 2020 at 11:41 AM <mikita.lipski@amd.com> wrote:
>
> From: Mikita Lipski <mikita.lipski@amd.com>
>
> If driver fails to update update VCPI allocation during
> compute_mst_dsc_configs_for_state - fail the function
> by early return.
>
> Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 99 ++++++++++---------
>  1 file changed, 54 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 35c8b1469f4c..7911c5dac424 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -621,37 +621,41 @@ static void increase_dsc_bpp(struct drm_atomic_state *state,
>
>                 if (initial_slack[next_index] > fair_pbn_alloc) {
>                         vars[next_index].pbn += fair_pbn_alloc;
> -                       drm_dp_atomic_find_vcpi_slots(state,
> -                                                     params[next_index].port->mgr,
> -                                                     params[next_index].port,
> -                                                     vars[next_index].pbn,
> -                                                     dm_mst_get_pbn_divider(dc_link));
> +                       if (drm_dp_atomic_find_vcpi_slots(state,
> +                                                         params[next_index].port->mgr,
> +                                                         params[next_index].port,
> +                                                         vars[next_index].pbn,\
> +                                                         dm_mst_get_pbn_divider(dc_link)) < 0)
> +                               return;
>                         if (!drm_dp_mst_atomic_check(state)) {
>                                 vars[next_index].bpp_x16 = bpp_x16_from_pbn(params[next_index], vars[next_index].pbn);
>                         } else {
>                                 vars[next_index].pbn -= fair_pbn_alloc;
> -                               drm_dp_atomic_find_vcpi_slots(state,
> -                                                     params[next_index].port->mgr,
> -                                                     params[next_index].port,
> -                                                     vars[next_index].pbn,
> -                                                     dm_mst_get_pbn_divider(dc_link));
> +                               if (drm_dp_atomic_find_vcpi_slots(state,
> +                                                                 params[next_index].port->mgr,
> +                                                                 params[next_index].port,
> +                                                                 vars[next_index].pbn,
> +                                                                 dm_mst_get_pbn_divider(dc_link)) < 0)
> +                                       return;
>                         }
>                 } else {
>                         vars[next_index].pbn += initial_slack[next_index];
> -                       drm_dp_atomic_find_vcpi_slots(state,
> -                                                     params[next_index].port->mgr,
> -                                                     params[next_index].port,
> -                                                     vars[next_index].pbn,
> -                                                     dm_mst_get_pbn_divider(dc_link));
> +                       if (drm_dp_atomic_find_vcpi_slots(state,
> +                                                         params[next_index].port->mgr,
> +                                                         params[next_index].port,
> +                                                         vars[next_index].pbn,
> +                                                         dm_mst_get_pbn_divider(dc_link)) < 0)
> +                               return;
>                         if (!drm_dp_mst_atomic_check(state)) {
>                                 vars[next_index].bpp_x16 = params[next_index].bw_range.max_target_bpp_x16;
>                         } else {
>                                 vars[next_index].pbn -= initial_slack[next_index];
> -                               drm_dp_atomic_find_vcpi_slots(state,
> -                                                     params[next_index].port->mgr,
> -                                                     params[next_index].port,
> -                                                     vars[next_index].pbn,
> -                                                     dm_mst_get_pbn_divider(dc_link));
> +                               if (drm_dp_atomic_find_vcpi_slots(state,
> +                                                                 params[next_index].port->mgr,
> +                                                                 params[next_index].port,
> +                                                                 vars[next_index].pbn,
> +                                                                 dm_mst_get_pbn_divider(dc_link)) < 0)
> +                                       return;
>                         }
>                 }
>
> @@ -700,22 +704,24 @@ static void try_disable_dsc(struct drm_atomic_state *state,
>                         break;
>
>                 vars[next_index].pbn = kbps_to_peak_pbn(params[next_index].bw_range.stream_kbps);
> -               drm_dp_atomic_find_vcpi_slots(state,
> -                                             params[next_index].port->mgr,
> -                                             params[next_index].port,
> -                                             vars[next_index].pbn,
> -                                             0);
> +               if (drm_dp_atomic_find_vcpi_slots(state,
> +                                                 params[next_index].port->mgr,
> +                                                 params[next_index].port,
> +                                                 vars[next_index].pbn,
> +                                                 0) < 0)
> +                       return;
>
>                 if (!drm_dp_mst_atomic_check(state)) {
>                         vars[next_index].dsc_enabled = false;
>                         vars[next_index].bpp_x16 = 0;
>                 } else {
>                         vars[next_index].pbn = kbps_to_peak_pbn(params[next_index].bw_range.max_kbps);
> -                       drm_dp_atomic_find_vcpi_slots(state,
> -                                             params[next_index].port->mgr,
> -                                             params[next_index].port,
> -                                             vars[next_index].pbn,
> -                                             dm_mst_get_pbn_divider(dc_link));
> +                       if (drm_dp_atomic_find_vcpi_slots(state,
> +                                                         params[next_index].port->mgr,
> +                                                         params[next_index].port,
> +                                                         vars[next_index].pbn,
> +                                                         dm_mst_get_pbn_divider(dc_link)) < 0)
> +                               return;
>                 }
>
>                 tried[next_index] = true;
> @@ -769,11 +775,12 @@ static bool compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
>                 vars[i].pbn = kbps_to_peak_pbn(params[i].bw_range.stream_kbps);
>                 vars[i].dsc_enabled = false;
>                 vars[i].bpp_x16 = 0;
> -               drm_dp_atomic_find_vcpi_slots(state,
> -                                             params[i].port->mgr,
> -                                             params[i].port,
> -                                             vars[i].pbn,
> -                                             0);
> +               if (drm_dp_atomic_find_vcpi_slots(state,
> +                                                params[i].port->mgr,
> +                                                params[i].port,
> +                                                vars[i].pbn,
> +                                                0) < 0)
> +                       return false;
>         }
>         if (!drm_dp_mst_atomic_check(state)) {
>                 set_dsc_configs_from_fairness_vars(params, vars, count);
> @@ -786,20 +793,22 @@ static bool compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
>                         vars[i].pbn = kbps_to_peak_pbn(params[i].bw_range.min_kbps);
>                         vars[i].dsc_enabled = true;
>                         vars[i].bpp_x16 = params[i].bw_range.min_target_bpp_x16;
> -                       drm_dp_atomic_find_vcpi_slots(state,
> -                                             params[i].port->mgr,
> -                                             params[i].port,
> -                                             vars[i].pbn,
> -                                             dm_mst_get_pbn_divider(dc_link));
> +                       if (drm_dp_atomic_find_vcpi_slots(state,
> +                                                         params[i].port->mgr,
> +                                                         params[i].port,
> +                                                         vars[i].pbn,
> +                                                         dm_mst_get_pbn_divider(dc_link)) < 0)
> +                               return false;
>                 } else {
>                         vars[i].pbn = kbps_to_peak_pbn(params[i].bw_range.stream_kbps);
>                         vars[i].dsc_enabled = false;
>                         vars[i].bpp_x16 = 0;
> -                       drm_dp_atomic_find_vcpi_slots(state,
> -                                             params[i].port->mgr,
> -                                             params[i].port,
> -                                             vars[i].pbn,
> -                                             0);
> +                       if (drm_dp_atomic_find_vcpi_slots(state,
> +                                                         params[i].port->mgr,
> +                                                         params[i].port,
> +                                                         vars[i].pbn,
> +                                                         0) < 0)
> +                               return false;
>                 }
>         }
>         if (drm_dp_mst_atomic_check(state))
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
