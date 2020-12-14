Return-Path: <SRS0=8Fgq=FS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EBFC4361B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 22:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B4E224F9
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 22:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B4E224F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1E9389870;
	Mon, 14 Dec 2020 22:16:25 +0000 (UTC)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2604889870;
 Mon, 14 Dec 2020 22:16:25 +0000 (UTC)
Received: by mail-oi1-x241.google.com with SMTP id w124so17906964oia.6;
 Mon, 14 Dec 2020 14:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WM4JTaOWR+p/2SnX/T6Ubb1JtGVXnGdSAPZvQi9TwAs=;
 b=E33Wwcn2VZlheQPh/e2AI0PBVpVWKwQ9BHgyfc49y+9i8ENejnto2+VLazx1l9KNkA
 R2jvpc5ltga6Xtd+ZECTQA4Cdqq1Jor7hp13MCT+wIHGXGFOwDSgetSUpoJ+vJcfnF7P
 BIXfHbL1md+r+1mI+evD4waGAtfXeHJe+LTCz9mpD9SsWD1oLu91JXEAA5F3R8cZ0qtU
 gPq/R5S0ct/5EdaZLj/EpVm6TbujpIzWMMWMgnknQj0OEBgXVFAnpDdnWcrek5ldN4G0
 +BTV3Kaj8EXJxpqbkjcMgCzm/q9OH9+Z7wOrXXcBdtAJLobnkyVeHI0QJ3G7ivr/e+2L
 eWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WM4JTaOWR+p/2SnX/T6Ubb1JtGVXnGdSAPZvQi9TwAs=;
 b=IBqurbq3ci3580oh9Ewdl7yBhJhnAgIYYpTw0Fp+9OIRuGhEZ54EhqU1+kaLEzMGFB
 JyFw2vd8uRuCANaVzvr9AXg3/lsrfKqE+FFKspqDpAmqTFou0P32jP8oQ0qXO7Ul03o0
 llFYNNgo7iqDPSGytVf/oC1EZUMZMOJ2rP5krleJPhwzn6R23hk6Ycja1EknTrEX4Y5R
 QblnO0q62zwchcMtMNJDG3+sz6XO5TXn333k3YOElNOQF2ZrE6y+ERu6IHt7i2oOho0H
 07E2IbioMdmAZ3AGYPv+EUUEQIQY/GvxxsS0xiiNJXhlt3fpNXczezjzVyy250G2xjPE
 +S5A==
X-Gm-Message-State: AOAM532zrulefasQFIr+5AYIZKIveoXZouJhltGMqZdsKfZ/gCZctkWX
 nP+bYkmc8uwyzkctlba6ooHXTiAXr+/ljV3vCD57ByXf
X-Google-Smtp-Source: ABdhPJwDhRQBEWCxbUkc4j66mNxq6TvusqyXVQtfSF5vOjZHgnrozxpuBaTXPock8HQDKiWwRZYCgIhpyTaEg9YV1Wo=
X-Received: by 2002:a54:4608:: with SMTP id p8mr19033063oip.5.1607984184497;
 Mon, 14 Dec 2020 14:16:24 -0800 (PST)
MIME-Version: 1.0
References: <1607784984-4542-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1607784984-4542-1-git-send-email-jrdr.linux@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Dec 2020 17:16:13 -0500
Message-ID: <CADnq5_M4XT40efcLO=b2MKJumyu4e01+CPaUN5DwgrNvNAnD1g@mail.gmail.com>
Subject: Re: [PATCH linux-next] drm/amd/display: Adding prototype for
 dccg21_update_dpp_dto()
To: Souptick Joarder <jrdr.linux@gmail.com>
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
Cc: "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Dave Airlie <airlied@linux.ie>, Yongqiang Sun <yongqiang.sun@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 "Deucher, Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Mon, Dec 14, 2020 at 3:18 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Kernel test robot throws below warning ->
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_dccg.c:46:6:
> warning: no previous prototype for 'dccg21_update_dpp_dto'
> [-Wmissing-prototypes]
>
> Adding prototype for dccg21_update_dpp_dto().
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h
> index b7efa77..e44a374 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h
> @@ -32,5 +32,6 @@ struct dccg *dccg21_create(
>         const struct dccg_shift *dccg_shift,
>         const struct dccg_mask *dccg_mask);
>
> +void dccg21_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppclk);
>
>  #endif /* __DCN21_DCCG_H__ */
> --
> 1.9.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
