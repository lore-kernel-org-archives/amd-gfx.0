Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AB7C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Oct 2022 20:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3823310E1E7;
	Mon, 10 Oct 2022 20:57:17 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA95910E1E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Oct 2022 20:57:13 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 i25-20020a4a8d99000000b0047fa712fc6dso7579533ook.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Oct 2022 13:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ScOfmmraf6k4B2HF1MblWcT1g+Ofd8fQZSVShQM1/cI=;
 b=k0k6HlXOBHo7A51TuBNHZVU4PyOhYJ0wEBGFReTT7/O5uht/H6c1Z1c2lOKlEfM5oU
 XtWRJ0Aw4Mz9aTn/hwOgFNbV0mWx1bbfcZcAy9AwhToxtMPoca/abhsSgWcyRpFOMq9n
 O+L3p7NVwZe4vfl+atZ4tZKdmMWpPOTfb3+IKqmY/jPs1QmTMqdrdRsDQs8e81ISTnYd
 YV3FHcvCIgvQPIHZh/vnxlw7lgOHJnv2RyK1s8hQkWhjx4HbcZioucmmx5Yr87T2Jqxg
 dtL/L5GVccPD+VJSw+ouKAbzuODpul5ALJnj61YeHlqgDxViTA03VrczsK3sPfQE49+D
 W5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ScOfmmraf6k4B2HF1MblWcT1g+Ofd8fQZSVShQM1/cI=;
 b=1dC2BYmcH4BFQ4BFr0OYK27FG0aOM5lJ3beTdJ1TG5nUKyEhuHwieCAvlclkbZVDUm
 LrIx2Vfs+Y/uN1nH/fkpiL1SMrnbNXqiWGFZGyPEZNL/JfHNgKcQnfb+qoe7gUjq5QUb
 aOxdYt6rUh1PwYoGlcpEAEf4eci8zw0Fgj0OvYZsAFBz0zSC26XSedPhXbFgB9oCXtm3
 r+Pt13RYDEt9SZGH0VTLUDWrBYxKhpLqMikeK3v3X+pVe4FPPSPobHSgPBq30rIXdchQ
 K20Nm8Qrhi+27F/oeneQn5nVzhyHiScI0Qo+QkwxSGhqFZKphMVlO2CqcocRseIaMviF
 TWhw==
X-Gm-Message-State: ACrzQf3PnL7aHZpkK7BK5Yxcb+HZJRBXN7a99T1H0LP4MN3FkSgjFGnD
 lVEaODpeevvfqSTJeiDVl2Txj7HP4ev9eB1bLR0=
X-Google-Smtp-Source: AMsMyM50Sunp5cTTHedA2ClszNsQISr2AmZXgxIzAeVHH/iuNgVd9OdVJUHm4AsjTZ3cyDHSo36WrrtHpDdi4lqQlNg=
X-Received: by 2002:a05:6830:3708:b0:661:330:5837 with SMTP id
 bl8-20020a056830370800b0066103305837mr9006041otb.233.1665435432878; Mon, 10
 Oct 2022 13:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220919164334.1579973-1-alexander.deucher@amd.com>
In-Reply-To: <20220919164334.1579973-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Oct 2022 16:57:01 -0400
Message-ID: <CADnq5_M90oOE4ttEiSGRnKQ=nKFdjyAso-qBufW8LqGPLrtBww@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix transfer function passed to
 build_coefficients()
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>, Zeng Heng <zengheng4@huawei.com>,
 amd-gfx@lists.freedesktop.org, Jaehyun Chung <jaehyun.chung@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

Alex

On Mon, Sep 19, 2022 at 12:44 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> The default argument should be enum TRANSFER_FUNCTION_SRGB rather than
> the current boolean value which improperly maps to
> TRANSFER_FUNCTION_BT709.
>
> Commit 9b3d76527f6e ("drm/amd/display: Revert adding degamma coefficients")
> looks to have improperly reverted
> commit d02097095916 ("drm/amd/display: Add regamma/degamma coefficients and set sRGB when TF is BT709")
> replacing the enum value with a boolean value.
>
> Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
> Cc: Jaehyun Chung <jaehyun.chung@amd.com>
> Cc: Zeng Heng <zengheng4@huawei.com>
> Fixes: 9b3d76527f6e ("drm/amd/display: Revert adding degamma coefficients")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
> index 04f7656906ca..447a0ec9cbe2 100644
> --- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
> +++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
> @@ -1692,7 +1692,7 @@ static void apply_degamma_for_user_regamma(struct pwl_float_data_ex *rgb_regamma
>         struct pwl_float_data_ex *rgb = rgb_regamma;
>         const struct hw_x_point *coord_x = coordinates_x;
>
> -       build_coefficients(&coeff, true);
> +       build_coefficients(&coeff, TRANSFER_FUNCTION_SRGB);
>
>         i = 0;
>         while (i != hw_points_num + 1) {
> --
> 2.37.3
>
