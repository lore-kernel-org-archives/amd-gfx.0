Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534A5C388F9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 15:20:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3D462064B
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 15:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkyNL8y/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D462064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5349A6EB8E;
	Tue, 27 Oct 2020 15:20:19 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11C166EB8E
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 15:20:18 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id t9so2325493wrq.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 08:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0b1oMXkhZrvDvHFOES2sdDT4aEKy1/djDW6AlEXzGhw=;
 b=HkyNL8y/4efSzD9nSmFzGqKb1ZR1mE0CBDWp9PKnbIEhNnm7QfQWrN7U6kTZm5Dvxy
 wRr2urAQbyRQhaUx9Jrg9k2YSLjNYb7dvNhWY8AqVeYNvCbqzi9jJeMOJniMDeJqpWvf
 W44DQtyqLIgUHgELzDrJPdirOgCMPayFp1meMSd9LhF4U86SD9sCo1cg3Od6ADRTQH4W
 u5BJDIB8ZH/NqTUteUt9ezjGKh/85hLsic7DuTh0HVYvRWPuA7nO0Fq0F+bIr5E97s2k
 23Y9yPx3iuXow3GsbkZ10QVYt4ohdpIKwaqjElMcy3PrizqwbU5r7B967gSwSWDz7byE
 rqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0b1oMXkhZrvDvHFOES2sdDT4aEKy1/djDW6AlEXzGhw=;
 b=GSqOuaYF85cid/iFoj/2+Iw9U+bjcyZth568V62rcx6ymt4+GmON4CjWIUDOPHu0vc
 3HRJUlWx8A0Cf1KmwXindb0231D09ncC7ttSrdnwrj0kiprL3CtjWE0lqYollbXHY3Gu
 RXUH2xfw/sErHAlBgAGcjbD+Nzl/TQ/2+Cq7PhJvm6DF1ocy28/yUBDsGlOYFgigrjYK
 JqPW04Gc4ur+eaKHp5Vl8h/7v12AWglW+7p13Y8V0kgl+5zCVK1yIUYE/AH2anxoW9aB
 KMHbVgN7veHq5PcXNwBA9EdtDlOpj4CM4Dx28ZdDWYgaluJKLZ/UzSsNiJc0twUa3xRG
 hRFQ==
X-Gm-Message-State: AOAM530OKYr62Lk4dLCN1CBP9U/LWJaPh/NLIOKmNEODGuyI05IthaKE
 dPI6dYsNNC+abxLdYEVF3eFJlptUQyMrFni+guQMdLuw
X-Google-Smtp-Source: ABdhPJyjDXW5LmDaQwOP+Nf5eK+ZSOrZj1lIQbeK0xyc1TO1pr9Y5C0fVSxpxKQ6eOky2SAWiBfwJUpP6VWU1OOzESk=
X-Received: by 2002:adf:dd50:: with SMTP id u16mr3627922wrm.419.1603812016568; 
 Tue, 27 Oct 2020 08:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201026161436.978310-1-alexander.deucher@amd.com>
In-Reply-To: <20201026161436.978310-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Oct 2020 11:20:05 -0400
Message-ID: <CADnq5_Me2LV2Rp-gLhzqqc76y8ddXnmfuVu66BYZbo48L0ZREQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: re-add surface size calculation in
 dcn30_hwseq.c
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Mon, Oct 26, 2020 at 12:14 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> This is required for MALL.  Was accidently removed in PRS update.
>
> Fixes: 48e48e598478 ("drm/amd/display: Disable idle optimization when PSR is enabled")
> Fixes: 52f2e83e2fe5 ("drm/amdgpu/display: add MALL support (v2)")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> index f3ae208850b0..cc2eca8c9a62 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> @@ -715,6 +715,21 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
>                                         break;
>                         }
>
> +                       if (dc->current_state->stream_count == 1 // single display only
> +                           && dc->current_state->stream_status[0].plane_count == 1 // single surface only
> +                           && dc->current_state->stream_status[0].plane_states[0]->address.page_table_base.quad_part == 0 // no VM
> +                           // Only 8 and 16 bit formats
> +                           && dc->current_state->stream_status[0].plane_states[0]->format <= SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F
> +                           && dc->current_state->stream_status[0].plane_states[0]->format >= SURFACE_PIXEL_FORMAT_GRPH_ARGB8888) {
> +                               surface_size = dc->current_state->stream_status[0].plane_states[0]->plane_size.surface_pitch *
> +                                       dc->current_state->stream_status[0].plane_states[0]->plane_size.surface_size.height *
> +                                       (dc->current_state->stream_status[0].plane_states[0]->format >= SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616 ?
> +                                        8 : 4);
> +                       } else {
> +                               // TODO: remove hard code size
> +                               surface_size = 128 * 1024 * 1024;
> +                       }
> +
>                         // TODO: remove hard code size
>                         if (surface_size < 128 * 1024 * 1024) {
>                                 refresh_hz = div_u64((unsigned long long) dc->current_state->streams[0]->timing.pix_clk_100hz *
> --
> 2.25.4
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
