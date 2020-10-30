Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CD6C4363A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 03:45:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C840321534
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 03:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfiTO9tO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C840321534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C303E6E94C;
	Fri, 30 Oct 2020 03:45:01 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 769136E94B;
 Fri, 30 Oct 2020 03:45:00 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id w14so4930482wrs.9;
 Thu, 29 Oct 2020 20:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CqRQo1k+LyBootWHIaIxWjANkP7ifh1D8uGLNtgxfI4=;
 b=NfiTO9tOxd9P308/HhlATOrmcqAD62BLyB79f+18OkTCEA10hoCvxR7zLfUXi5/+kp
 KldGo5NtKuI+jcxjVy8Gqr02bkHtRt9CHRs4hiiazCClbDwj+ENrxo4mvlry36WvX2XG
 Hfc9cuTHpbt6ectqZUDDpS0EPNxCUjTISiweYb4ETvTml0blH6j96nYm9au7/26Sndje
 sof5VpViWl/mpTMcsb0obaLPyri3JwFbPh21iSHQHUVLkIqCZXI2MuwteDJOD6YHS4Uh
 +rZtkkm6S0uUzkjSruu0NHg0Ac0fjVw5fIbTeTtUOzLHPGcjaMC4qA3CN6xaTp9fwL+9
 ZDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CqRQo1k+LyBootWHIaIxWjANkP7ifh1D8uGLNtgxfI4=;
 b=arhw7eWwCnNEMDekHK6hqsz5ONNUDZS5FswtwL/1sP6k40BEOgNTGqvXCEhCuSWXo5
 d7957bDspnSkqIi0hTXrryBb3jUruOMdx0seBjfjljw2CKFmvIzUxULHjeuTGEcCavPr
 WS/DiX6EEwwtaN9Gn+T2ly9tgjyLWAOKhTIbbZgX5NjcSQNtEAdSDKkuCbUApED7UTqL
 Br/TnbiuJuWqEGCyiSi50pO+rYwNC+ss4UqLP+M9sK4PkUhmcgpMLzOhe++8DErlFDCa
 aULMh3sKwf6KVR2jXNlyDpPGwG90b9xaYnJYPHvA+nOYQRjxdxYcRxN5qfupLPwdRsLL
 iOJg==
X-Gm-Message-State: AOAM530uBjEVyP2nuhs2qPdha9PEWaKG6Asrj7NMACWZ48useUHqTWwP
 kQynsA3UXB/HfZ8qCQ6/lcJQfJKI7vNsY4YeaEA=
X-Google-Smtp-Source: ABdhPJyZsaTRPa6cjCtyjtMW3tmQylPLGZh/UEBXCyh2htGgoNYKtpTOtToxkbQ8qz6xDinhIr5w6dbXejWAKDUGNhw=
X-Received: by 2002:adf:dd8f:: with SMTP id x15mr401458wrl.124.1604029499181; 
 Thu, 29 Oct 2020 20:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201026210039.3884312-1-arnd@kernel.org>
 <20201026210039.3884312-2-arnd@kernel.org>
In-Reply-To: <20201026210039.3884312-2-arnd@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Oct 2020 23:44:47 -0400
Message-ID: <CADnq5_OORogMPV6zrEPGNGJ-jEamkzymdGTyHetrF_9xvoVx_w@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/amdgpu: fix incorrect enum type
To: Arnd Bergmann <arnd@kernel.org>
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
Cc: jinlong zhang <jinlong.zhang@amd.com>,
 David Galiffi <david.galiffi@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Leo Li <sunpeng.li@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
 Hersen Wu <hersenxs.wu@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, abdoulaye berthe <abdoulaye.berthe@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Martin Tsai <martin.tsai@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Mon, Oct 26, 2020 at 5:01 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> core_link_write_dpcd() returns enum dc_status, not ddc_result:
>
> display/dc/core/dc_link_dp.c: In function 'dp_set_panel_mode':
> display/dc/core/dc_link_dp.c:4237:11: warning: implicit conversion from 'enum dc_status' to 'enum ddc_result'
> [-Wenum-conversion]
>
> Avoid the warning by using the correct enum in the caller.
>
> Fixes: 0b226322434c ("drm/amd/display: Synchronous DisplayPort Link Training")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index ff1e9963ec7a..98464886341f 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -4230,7 +4230,7 @@ void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode)
>
>                 if (edp_config_set.bits.PANEL_MODE_EDP
>                         != panel_mode_edp) {
> -                       enum ddc_result result = DDC_RESULT_UNKNOWN;
> +                       enum dc_status result = DC_ERROR_UNEXPECTED;
>
>                         edp_config_set.bits.PANEL_MODE_EDP =
>                         panel_mode_edp;
> @@ -4240,7 +4240,7 @@ void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode)
>                                 &edp_config_set.raw,
>                                 sizeof(edp_config_set.raw));
>
> -                       ASSERT(result == DDC_RESULT_SUCESSFULL);
> +                       ASSERT(result == DC_OK);
>                 }
>         }
>         DC_LOG_DETECTION_DP_CAPS("Link: %d eDP panel mode supported: %d "
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
