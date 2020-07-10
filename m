Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D73C433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 21:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07E82206C3
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 21:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xj0O+fpp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E82206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5B656ED13;
	Fri, 10 Jul 2020 21:01:33 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B59D16ED16;
 Fri, 10 Jul 2020 21:01:32 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id z2so7229208wrp.2;
 Fri, 10 Jul 2020 14:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6+r5bXWhv/RQ5xFOE17P6y/DtE6DdUph31T/6lnjgyI=;
 b=Xj0O+fppYfdFYtGXu/8QJhYwJ7qRKnFTirnizTXoFo5bZj6n94L2JJj0BdRzJwzAb5
 xZRyrEv3g4yyg5OvsM4snf2LCqod8codoTvAxrPCUxbIvksvMH1AU8WPvenGlYrpxSQf
 6BjZ3/b3VUh3+MkQZawapsKpjwcb2Ex6HXUZFheK4SJDgNSlkTZm5VxobjBO1AQ5WX5K
 aaZGH6qaz17M8SlXpxudD5NTY4oJewCMG4Q6skZFj/xPz2y1jeXWQLe2zCpIrQxxh940
 SMoOyMYtdW1UeDYAgsdG/e20KOUC8x8x3GL5LKFyb7Zb02f8D42khsD14r13TK76VWQc
 2R5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6+r5bXWhv/RQ5xFOE17P6y/DtE6DdUph31T/6lnjgyI=;
 b=ph5EAdZpjVgFVVi26W+2FvoMfByMePQTsXlKdMIcRfOZtf4zyWH6ZQjPQKpJW9V4/9
 uF+kjIZsa0C1AqAzKba2YepGgn602/rrcEt/O4M7sCxR/TyV33BE00r4pI4AgHdYkdlF
 9z+xel58fZOxThxK92Qq0HS5tQSk3Rzy+qRr25OkTHlimvR7QpGcJCtybWbN7kw+MAbX
 G414nNWXbYfuyIS1VkrAqKwbhBBJz1Sh8bqorVKmJndVeVf4V5VnCYO/buOPOOl8qP/Z
 BFlFIs1URE3mAkcy9bqjPy/qdfFYJ4LZzL4FK05zdTJKJMu9moOBzi+DFH6K0ja/KTNo
 IqJQ==
X-Gm-Message-State: AOAM532Mzr4637I+N1IBQnAibZote3whOLY0uSpUxBWXe6flfuXKkkoH
 MX0gDJUotnurgkO8nhkhSIiVECGI2mF8smgXtBY=
X-Google-Smtp-Source: ABdhPJypPwO8Bo/INW0FnA8A7BrNDcU34sqKrdYu805RwMp6HxYo7wINlncuUBXunFISVe1eQrqua5IIzU9mGV+XpdY=
X-Received: by 2002:adf:dd8d:: with SMTP id x13mr68186470wrl.362.1594414891375; 
 Fri, 10 Jul 2020 14:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200710083758.3304139-1-colin.king@canonical.com>
In-Reply-To: <20200710083758.3304139-1-colin.king@canonical.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Jul 2020 17:01:19 -0400
Message-ID: <CADnq5_MWvu0JDbBMR1_wDqozxMahX6uAJBppTLKwPLOmdtTGSQ@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: fix spelling mistake "Falied" ->
 "Failed"
To: Colin King <colin.king@canonical.com>
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
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jul 10, 2020 at 4:38 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a DRM_ERROR error message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index e20695b44dbe..40706334f7a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1984,7 +1984,7 @@ static int psp_suspend(void *handle)
>
>         ret = psp_tmr_terminate(psp);
>         if (ret) {
> -               DRM_ERROR("Falied to terminate tmr\n");
> +               DRM_ERROR("Failed to terminate tmr\n");
>                 return ret;
>         }
>
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
