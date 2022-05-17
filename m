Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9B9C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 20:59:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB429113224;
	Tue, 17 May 2022 20:59:14 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B49CD113224
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 20:59:13 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 p12-20020a9d4e0c000000b00606b40860a3so13010943otf.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 13:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5IZfdhz/4VvGttsXS64BLdybZC2nkRyX3oSeFQAvEqE=;
 b=fw5hJjp+KGPyBKgMxbOcgYXPvsf8UB9TzTy7q1B3qynre/0rHaTvPr3GzR3F3loFYV
 4eLHycI74A0UrG26lUcGCr2JzAWvIkG6qmwEPihr9HrgaHa0Q9bzkD2iSfWk436X83gK
 HjALCUQe6H+56pR4hF4+y5UjMjPePBcWkxunftiQKwezsKqe0HYrFQuJrwPV7TlM/msD
 A29WUeZxGBFn0MUmEBstcjZDlv+G0h7JpN9KmpcVTmaetzkd9+x1aW5i0F+VNqTbyi2f
 bH1EjjLtegof37NIfRaBoIrPVBCteS+tUyHJBegyhPoQH5Sh40YHExE1FIy4mQx8PKrP
 ENcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5IZfdhz/4VvGttsXS64BLdybZC2nkRyX3oSeFQAvEqE=;
 b=ildUtw0eTX6I0lLgGjcjH5EprqvY/tuOSTYcneKuKE/x8M0IDbBLN9C8kFUBGUnuHe
 lAzyM9Q+tQgBnoJLqME9tiOFjQOvmD4DlJOvsK9OOn0/K+VjCk/LNOOWEEHCZlLPj9RT
 xrUMpPEkI5c8X3WEc8rzHzShD7995Oztaj+nwI7CKf0J4f8AqLCfOu4NmmaUdYee22Vs
 rsShHUFH58mm5cP0aYsdUi4CUmE+9OSDlyj4rSY0qvhkSG9GO31a0DN+eZnCldjf8JU9
 JFaFUoBdXhF2FDQAMwSxgqbUrGgbupSc/PdD2cILD6wiMMpu36EyAEpqjMfLqg7KRlIs
 xbBQ==
X-Gm-Message-State: AOAM531Imk2vMKAneVwwmNTVmNd7USxmIjTCViboOS2ChBBM/RcAxM+d
 /ZemimQvUf4+kfUvQwE7A53wvzMxy5CI9zJ38JNXycNw
X-Google-Smtp-Source: ABdhPJyg8WIx9Scy+M2Egp8B0zOo6dMp14vz6q9K/YKrL6H1TYLT5p6KN7sboSyPvKENA0dXMuRTkbvouCrhqPa50Xw=
X-Received: by 2002:a9d:6543:0:b0:605:e789:271e with SMTP id
 q3-20020a9d6543000000b00605e789271emr9054097otl.200.1652821152948; Tue, 17
 May 2022 13:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220517095746.7537-1-ruc_gongyuanjun@163.com>
In-Reply-To: <20220517095746.7537-1-ruc_gongyuanjun@163.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 May 2022 16:59:01 -0400
Message-ID: <CADnq5_NxRBKeTe0QMVGD6oA2=rrksKKjSDPXyYwJ+1SPsGriHg@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amd/pm: fix a potential gpu_metrics_table memory
 leak
To: Yuanjun Gong <ruc_gongyuanjun@163.com>
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
Cc: Evan Quan <evan.quan@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Tue, May 17, 2022 at 9:13 AM Yuanjun Gong <ruc_gongyuanjun@163.com> wrote:
>
> From: Gong Yuanjun <ruc_gongyuanjun@163.com>
>
> gpu_metrics_table is allocated in yellow_carp_init_smc_tables() but
> not freed in yellow_carp_fini_smc_tables().
>
> Signed-off-by: Gong Yuanjun <ruc_gongyuanjun@163.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index e2d099409123..c66c39ccf19c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -190,6 +190,9 @@ static int yellow_carp_fini_smc_tables(struct smu_context *smu)
>         kfree(smu_table->watermarks_table);
>         smu_table->watermarks_table = NULL;
>
> +       kfree(smu_table->gpu_metrics_table);
> +       smu_table->gpu_metrics_table = NULL;
> +
>         return 0;
>  }
>
> --
> 2.17.1
>
