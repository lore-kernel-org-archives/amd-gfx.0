Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F579C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Nov 2022 16:04:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FC6A10E4AD;
	Tue,  8 Nov 2022 16:04:15 +0000 (UTC)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90EC510E4AD
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Nov 2022 16:04:12 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1322d768ba7so16721542fac.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Nov 2022 08:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V9WW/Du0LmflcuOKD72qp9hdgPApATYBjvbbNnooJNM=;
 b=pvW3ul5TA2U+eZJ2wXA2kdXoN89zJU48kYrRmknFgRokK0CzXywAVNV2Hxfj2PCFxN
 0rlLlWF6j/zEF9vfJdObccLk+GeRboCIP0gxau8ghbh6+zBR1GcYQWLzQelP9sEjjRxV
 2h9juXWNHAlGyabhFRGdTFYjXDL94RLaAtQfNemCBmfJU7e2xGs+Fatm5KgkLu6max91
 0gSL21e5n5Xci4zcn3DdLNJ+wtZlOTtBBA1z31+OpDcXSkIPCE1tnglr04qEHqONbbBw
 +gi3ivWbEb0ezhYncRCP/P5sG8GubGDBP/RsJJsC+nhYDKeh7e7pqf8y7d1yQoqiux/g
 QqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V9WW/Du0LmflcuOKD72qp9hdgPApATYBjvbbNnooJNM=;
 b=zhsPIS5UysmygFzE3jQJyi25m7gl9XGnFT+oOBAAPh7nqtcSrmkxqmRN/DZ7rL0bMs
 Bcbj7egstch8Ff8XPhd56r8wi1uAZlO3EgUxtWtLUWrPcgYKC6MRmq5tNCTcOHY6kNuj
 Oq/xC6qPs3Oif74ELOm/kS/qhlD+qbtmV6rQxJXtImZ4GFJFzScv95oz4gNNl/+vUKFM
 4LhjktRc9KZr8Rl+yLpYK5ogwmBQ4fxR7QDZzsEZ9XAV5cua2oUrRMvzkO2yfM3XRzgz
 2ocd2oHeyYCwPdgqqcvYX4bfm/ikbgy1Egw1Oa/KbyUaTRZ1AWdPzlMoI9ZunuV/9Jdj
 kIsA==
X-Gm-Message-State: ACrzQf2VXEFBvT+/7ElCVQ6feupTIS0n0yN+c6pXnnDuKt3K48qsRUM5
 u1EYruAWrF42ceACnFQuVStz7erYZdy7QFqckNI=
X-Google-Smtp-Source: AMsMyM6BjPUKTgkeMdt975a7Gbd69NCGhbEeA3cnlPUJ5xqBsVxxF7ICZN+CcqXY0kaFQ3uibC2Wj5qVLNIBu6aorwQ=
X-Received: by 2002:a05:6870:a7a4:b0:136:7c39:979e with SMTP id
 x36-20020a056870a7a400b001367c39979emr33934235oao.96.1667923451842; Tue, 08
 Nov 2022 08:04:11 -0800 (PST)
MIME-Version: 1.0
References: <20221104092931.20226-1-tanglongjun@kylinos.cn>
In-Reply-To: <20221104092931.20226-1-tanglongjun@kylinos.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Nov 2022 11:03:59 -0500
Message-ID: <CADnq5_Pxh8G=xguW=wa9x2W_c67RD+5EGJXcTC99_sbUqsVLBA@mail.gmail.com>
Subject: Re: [PATCH v1] drm/amd/display: Have risk for memory exhaustion
To: LongJun Tang <tanglongjun@kylinos.cn>
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
Cc: Rodrigo.Siqueira@amd.com, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, lange_tang@163.com, aurabindo.pillai@amd.com,
 alexander.deucher@amd.com, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Nov 4, 2022 at 10:06 AM LongJun Tang <tanglongjun@kylinos.cn> wrote:
>
> In dcn*_clock_source_create when dcn*_clk_src_construct fails allocated
> clk_src needs release. A local attack could use this to cause memory
> exhaustion.
>
> Signed-off-by: LongJun Tang <tanglongjun@kylinos.cn>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c   | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 1 +
>  8 files changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> index 020f512e9690..9b7e786bd4a2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> @@ -1323,6 +1323,7 @@ static struct clock_source *dcn30_clock_source_create(
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> index f04595b750ab..7c1225046544 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> @@ -1288,6 +1288,7 @@ static struct clock_source *dcn301_clock_source_create(
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> index b925b6ddde5a..73ae1146dad5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> @@ -458,6 +458,7 @@ static struct clock_source *dcn302_clock_source_create(struct dc_context *ctx, s
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
> index 527d5c902878..0ea97eeec5a6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
> @@ -425,6 +425,7 @@ static struct clock_source *dcn303_clock_source_create(struct dc_context *ctx, s
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> index fddc21a5a04c..b02aa8874efb 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> @@ -1625,6 +1625,7 @@ static struct clock_source *dcn31_clock_source_create(
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
> index 58746c437554..b2ff29e5f93c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
> @@ -1623,6 +1623,7 @@ static struct clock_source *dcn31_clock_source_create(
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> index a88dd7b3d1c1..71730b6666b0 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> @@ -829,6 +829,7 @@ static struct clock_source *dcn32_clock_source_create(
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
> index 61087f2385a9..d3980fc243c9 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
> @@ -828,6 +828,7 @@ static struct clock_source *dcn321_clock_source_create(
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> --
> 2.17.1
>
>
> No virus found
>                 Checked by Hillstone Network AntiVirus
