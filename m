Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9902DC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 15:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B80A10EB2F;
	Mon, 28 Mar 2022 15:09:38 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B47D10EB2D;
 Mon, 28 Mar 2022 15:09:37 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id v75so15922723oie.1;
 Mon, 28 Mar 2022 08:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hR1jRa2phyLv14hWOxaM9+j9CCvuPKpyIhWccqDJKiU=;
 b=q1gM3zTfmWHCf8RU3HwJ+H7QV2DOiLw1oZW8RtIgSzfBccBwuCoDKBY7C7NT6lfK2D
 rqokHdDdmod7qFO37x1EXvmQjBwhfOcvlfZd1pscXE7tzOBmgW5htBMVaGGaHJCxIeeC
 1CBkoqNPJChehR1D3sC156ACkHB1/fnVlgTZb0LGlJyAvY1aGUJDbYFtGzRa/Qdz/wNB
 RiThumDOlZVctTz9UQwkWw/6Pv2sAbTbVk/4vG9ZeL1Xqx++EAlDP2BmHNnNemH3C9QK
 1o6cDTpzG8xvoNJx15+jEpUtPtzy7IJpJVfguwKrR20wYhJ06ZC5QPYMtgijyjbtVhVv
 MrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hR1jRa2phyLv14hWOxaM9+j9CCvuPKpyIhWccqDJKiU=;
 b=ilYbjlbYCwlfeokPq4bKl8ZeKegUMCD60NK5kSyz3UIHm04XryJXGgPUYZ5A4rC35B
 8P9ksQaYudYanvH1qcC/gNUPg5ZTvgfC18Z8ECgIM11sDaOM++ENAptT9cdGpOgnvKfs
 hQqgSQyNWzJUIBva9wbWthAecnE092FqhPuMMUOYQkFDpAVUDjPVDfPVbaDmje6TZt9m
 wjr8jzPk/NTkmSw+H8NDkiFVpsJ/eujGC+RLe/N23NJ4vV6L/GZbb7mZ7bPdCUl900xG
 zcAfbgqWmuFaPeLRd7WFq05bl9FcqhllPJkhz9lzs0J3Kyh+LPHtk5F1Hvr7NVEMJPoe
 HOTA==
X-Gm-Message-State: AOAM530cy1qoxLWSYxbhJeIwvvThW3sC5WdHxlUC8M5hGH7s1SgYoKsg
 ppHe/l6oRFDhdZfNsPTVWxIg4nis8YjVTId+WIA=
X-Google-Smtp-Source: ABdhPJxXs81P8Av3G60zCVlTmece1KGzOmPai54eYxv81AImIsCyKHUBwW5lMB+xR1oBt7wsD0hEkM4fezshtDOT7GI=
X-Received: by 2002:a05:6808:df1:b0:2ec:b193:ad6c with SMTP id
 g49-20020a0568080df100b002ecb193ad6cmr15958905oic.200.1648480174953; Mon, 28
 Mar 2022 08:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220326233726.14712-1-rdunlap@infradead.org>
In-Reply-To: <20220326233726.14712-1-rdunlap@infradead.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Mar 2022 11:09:23 -0400
Message-ID: <CADnq5_Oed23CBfdsnOaacSZem=Kk8okJa06YHJHUkmTMp13ufw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: DCN3.1: don't mark as kernel-doc
To: Randy Dunlap <rdunlap@infradead.org>
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
Cc: Leo Li <sunpeng.li@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, patches@lists.linux.dev,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Sat, Mar 26, 2022 at 7:37 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> There is no need for this one static function to be marked as
> kernel-doc notation.
>
> Avoid this doc build warning:
>
> warning: This comment starts with '/**', but isn't a kernel-doc comment. =
Refer Documentation/doc-guide/kernel-doc.rst
>  * Enable CRTC
>
> Fixes: 110d3968fe95 ("drm/amd/display: Add DCN3.1 OPTC")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> --- linux-next-20220325.orig/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_o=
ptc.c
> +++ linux-next-20220325/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
> @@ -91,8 +91,7 @@ static void optc31_set_odm_combine(struc
>         optc1->opp_count =3D opp_cnt;
>  }
>
> -/**
> - * Enable CRTC
> +/*
>   * Enable CRTC - call ASIC Control Object to enable Timing generator.
>   */
>  static bool optc31_enable_crtc(struct timing_generator *optc)
