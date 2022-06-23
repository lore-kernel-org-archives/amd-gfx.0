Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031F1C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jun 2022 16:48:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CB3510E3C0;
	Thu, 23 Jun 2022 16:48:37 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CBEF10E3B6
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jun 2022 16:48:36 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id ej4so25433443edb.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jun 2022 09:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zVKAZpQSR7IAMwOsY8NsCMfGiRCzTQjocy8dsYopt7o=;
 b=J0oHDmlaPgH2ooRtII7HfnmSfGalysmemVR7uAXQKxfCssZ50a46aXeDAAz90t3QwW
 Z5Vsf10LRmkIByf4I3JYtLXgrLbT0lVlCUttm+KEZXpeTLf0sFgA3PSx7yHe3veJZQ2D
 IYcBhjlU1q8dN+r4DnJs8JZ2HLKkfr3xRzZjK3EkHXzofZ7WgpPdOd+nRJmVrfJ59xfQ
 LvcL9FIs/leofl4LXepAsEhavJIB/SV2Xt6Ypmaewt5Zey1MG0FDUiOlOBz+nD1ZoF/t
 ViEqxQpfAg4fgoOZYvjSFOyeUeTqBcE2FJmEnvJt55QPoLirCUUKaL2l35TyJbKTV/yj
 lFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zVKAZpQSR7IAMwOsY8NsCMfGiRCzTQjocy8dsYopt7o=;
 b=Ga+wEU2z4h9UOesoePeTmNnHAZwIZ9mCZXRN/rRUmPZRn6OiY8OlRf9maVs8Okc/cD
 jKyKgLiKdwcWnDb688e7o5Q2nj5ZhdA8Nf9uJLJR6aForHl+CxVDrgBzqPtT0KEDjj8t
 k1ilfvXaN38x+YgF6s54ALqnjAkp3+J7ER6vu5DyTbbeZ4UesBywWMrPubXrkE94Bh+W
 0aqUc7epOOQ17/eVWLtjePphluyRiGgTnMi/UTUv7F0lUUayc0D2CXcVDeJrHeNgI3+L
 d9WYxVfSOjUXVIHun+TT7uPqKzE3k9ozVaT0YoWPy34U5vjet+VBlOGgeFJSy7eydmnr
 o4tw==
X-Gm-Message-State: AJIora/JXMbR6ewrh8msqf8L4zCxGL+VridqWzP3rbRleg0XWbhDt2x0
 fkdLPcnOpd1j6JMKuOKwQ1fgdqiBy3aJcus25ktqrYXt
X-Google-Smtp-Source: AGRyM1uYlX7DB36LP3GfUUUox0+IvI+VvnzRDpgOfKBoVyuWyUVd6pQ/EwiJjlfBRWq5gCD3GzQJUCbEBln6k4nU3JU=
X-Received: by 2002:a50:fe0c:0:b0:435:510a:9f1f with SMTP id
 f12-20020a50fe0c000000b00435510a9f1fmr11875554edt.297.1656002914992; Thu, 23
 Jun 2022 09:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220623073320.2632780-1-chandan.vurdigerenataraj@amd.com>
In-Reply-To: <20220623073320.2632780-1-chandan.vurdigerenataraj@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 Jun 2022 12:48:23 -0400
Message-ID: <CADnq5_P7DPv+HXrUUdC_KxG8LmAdRyKH-5vZZcL2GdRYZUzVfQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display : Log DP link training failure reason
To: Chandan Vurdigere Nataraj <chandan.vurdigerenataraj@amd.com>
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
Cc: Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 23, 2022 at 3:33 AM Chandan Vurdigere Nataraj
<chandan.vurdigerenataraj@amd.com> wrote:
>
> [Why]
> Existing logs doesn't print DP LT failure reason
>
> [How]
> Update the existing log with DP LT failure reason
>
> Signed-off-by: Chandan Vurdigere Nataraj <chandan.vurdigerenataraj@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 4027f439a5a4..c8355acd3672 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -2786,9 +2786,9 @@ bool perform_link_training_with_retries(
>                                 break;
>                 }
>
> -               DC_LOG_WARNING("%s: Link(%d) training attempt %u of %d failed @ rate(%d) x lane(%d)\n",
> +               DC_LOG_WARNING("%s: Link(%d) training attempt %u of %d failed @ rate(%d) x lane(%d) : fail reason:(%d)\n",
>                         __func__, link->link_index, (unsigned int)j + 1, attempts, cur_link_settings.link_rate,
> -                       cur_link_settings.lane_count);
> +                       cur_link_settings.lane_count, status);
>
>                 dp_disable_link_phy(link, &pipe_ctx->link_res, signal);
>
> --
> 2.25.1
>
