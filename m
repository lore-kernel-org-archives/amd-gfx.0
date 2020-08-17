Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8D5C433E3
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 19:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D59B20716
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 19:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RS/bh55p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D59B20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2F0289F07;
	Mon, 17 Aug 2020 19:50:08 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5732F89F07
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 19:50:07 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id r15so6201951wrp.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 12:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zTCV/KN5HEsDeY1BDOh+TsZf7ToDlqJvscxbcdxbc/8=;
 b=RS/bh55ppPJyixo0pv5YlwfKWOji6I8RXbUukRaJ6654knim/1VapAw70C8ZpoXrq7
 v57NsXGaojJaTii3JBam8mkECkKLGB4lnnZ/PubZSsWr0Xx1rZg4gB3Mm8zwtLVeEOCm
 YJyUxiY9RwQNAgzHIc0PqrC63sQ0l8Fol4qHpPGK6+eObl7w/bhKPJCcxvwXZbkwQboD
 Y5ZS7mk+4auNVKMH42eak7RJe6Pi/2aTnByW7WEItUh2QKx19E4NUWUxv0miRaemN1BD
 1zM600K3dYaTZ+GOGuh+n7TTOuXJCF8ejtwn6HFGwNfsrzJDCtwjZKaUh35m/1QGvfZm
 ZYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zTCV/KN5HEsDeY1BDOh+TsZf7ToDlqJvscxbcdxbc/8=;
 b=G4Ta6Oyy0KlvVpIHdEOVR4n8zHb3mMPdXuPnr9insPeBMMWdgScw4GN5i72GRFIXvj
 Edwlm7/pGsbOb05rrF/7lrCFoAsxx5NaC99UlOCRzeeSOJ5/fkf+iPg18FVp/JuKklMl
 4i2oSMtL2Uv09Xz+kYuewCKH2DQzZzMg87pGjOUPbLmFfpaJJiT/z2C2P43GPsd8JaZu
 BRaxRRgcwRgh2qQJMnHAU3WznIe7BKtqgdiDlBLYCzrx8Q0OMkOugiqtDt63baYj+1xT
 KxzVox5OZ/OBIBUPm7ff0ShQEgDt1vbGVI8atkwJxo7hqahfFzYj6iwFAfU9Wu6DX/yq
 wzXQ==
X-Gm-Message-State: AOAM532TBAFjQSGohElRYuyr5wCbJNRv/x6NY4vGyqXxeySOa1eTmef4
 fuV6R6u4iN95IMetUuPIQa/yiHy9dJCUCdKqS4w=
X-Google-Smtp-Source: ABdhPJzdVAqh3auXorCtq9+spTCragojWgJEu4Di1usuruCSG+ffyG5JMxUAQ84zg54sEIXqa8QqIhuclhIvf5+3ElI=
X-Received: by 2002:a5d:6348:: with SMTP id b8mr16625715wrw.362.1597693805852; 
 Mon, 17 Aug 2020 12:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200817193253.24385-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20200817193253.24385-1-Bhawanpreet.Lakha@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Aug 2020 15:49:54 -0400
Message-ID: <CADnq5_Mh4FpE1bNtakzVP7PXT=LhfcGJH=uWRwdApyAN2c2TdA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Add dsc_to_stream_resource for dcn3
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "Lipski,
 Mikita" <mikita.lipski@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Aug 17, 2020 at 3:33 PM Bhawanpreet Lakha
<Bhawanpreet.Lakha@amd.com> wrote:
>
> Without this, enabling dsc will cause a nullptr
>
> Reviewed-by: Mikita Lipski <Mikita.Lipski@amd.com>
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> index 1ee9087eec76..957fc37b971e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> @@ -2424,6 +2424,7 @@ static const struct resource_funcs dcn30_res_pool_funcs = {
>         .populate_dml_pipes = dcn30_populate_dml_pipes_from_context,
>         .acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
>         .add_stream_to_ctx = dcn30_add_stream_to_ctx,
> +       .add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
>         .remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
>         .populate_dml_writeback_from_context = dcn30_populate_dml_writeback_from_context,
>         .set_mcif_arb_params = dcn30_set_mcif_arb_params,
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
