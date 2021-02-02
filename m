Return-Path: <SRS0=dhbh=HE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CACAC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 16:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4731564F54
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 16:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4731564F54
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAD956E94D;
	Tue,  2 Feb 2021 16:39:01 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EDED6E94D
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Feb 2021 16:39:00 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id t25so10303952otc.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Feb 2021 08:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gEB6YhLiShPxcpG0N7ia5oN52NnO6sE8qIUDaGWPBqA=;
 b=H/dmYbhX8sl+0ST7w5MlKdD/viYei2HClPFduE5wjMtX0MTvQ+FFssg71dRZuHNgzJ
 iJWHq/aO5YwpXS+D6hXPkHrjRA5X7QXN+OIF/CzTxRfQESJxI+gpwYrbdY1ERM604qrQ
 iXVL7sUj7738Mq//8BiZavNoWWDDFYOAP4TXBcWFyTyH9twY4JOd90yTEuJttZGcDp7A
 Hy5uhVN1BfEo2PLEQvJHGj00eq5aiPJwurj+52SRd8ZnQGX1S1FjssM3O7V4ThrrhA+6
 ExWR+kLq/PjzCKP02j/F20TaLHXW5yh5br8M8DlrtNgzgA6Ej12SMjymNxAzor92P75l
 bg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gEB6YhLiShPxcpG0N7ia5oN52NnO6sE8qIUDaGWPBqA=;
 b=qVhBBHs143VU6N3x2Bu3t0qqfH+/vxNS67sEFo0Ao7nm+MhoPHszJ7Rs4xpcJpcqB+
 fDjIhvvGLfznxpu2n2BtRjyPSRA7arc2BZsjiddTQ9MoQTeKbMpirPnXGZJT3bPUVsZZ
 Z269jz4MiYYsF2WgmPkHtymhTSSA1D6P3pzOQxVetsm35zGq/tJhLYtUEv390nl7XnDj
 EB3Z4cFuGiu0Ftpkbkng+WFQ+XAJXWDD80dDwKyDzADI3EMh7ur4zS175LEn21mIknXg
 aQaGX07kxgykbUajpbQFXo9BhO57Pjz0BSOUuJZgJDm3zZCIG4axr4Qmu1eb/OLaryuQ
 NDQA==
X-Gm-Message-State: AOAM5338X4m2YZ6hMYg1x/Tj0hTDjy9CXHXBUkMZa6g2dph1oDJa2eDg
 1h+2chdKCZpGl5pxaRQUdyhZ0+XhbzFjD/OHk6U=
X-Google-Smtp-Source: ABdhPJzQZdEDqjoPyL5u/GjncG3C5HgSbpUNlogxNxADbL5hCcP/xjRntfr0srln2kwPoWRfUuARVrNICr8iVQb3zZ8=
X-Received: by 2002:a9d:ec7:: with SMTP id 65mr11172551otj.311.1612283939430; 
 Tue, 02 Feb 2021 08:38:59 -0800 (PST)
MIME-Version: 1.0
References: <YBjplLOof9J1E2o5@mwanda>
In-Reply-To: <YBjplLOof9J1E2o5@mwanda>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Feb 2021 11:38:48 -0500
Message-ID: <CADnq5_Mw+wjzRLhNaGUC7VFS92=GeZ0UwvrhiHMjnXpF1=nMHw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Prevent shift wrapping in amdgpu_read_mask()
To: Dan Carpenter <dan.carpenter@oracle.com>
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
Cc: Xiaojian Du <Xiaojian.Du@amd.com>, David Airlie <airlied@linux.ie>,
 Kevin Wang <kevin1.wang@amd.com>, kernel-janitors@vger.kernel.org,
 Nirmoy Das <nirmoy.das@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Eric Huang <JinHuiEric.Huang@amd.com>, Huang Rui <ray.huang@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 2, 2021 at 12:57 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> If the user passes a "level" value which is higher than 31 then that
> leads to shift wrapping.  The undefined behavior will lead to a
> syzkaller stack dump.
>
> Fixes: 5632708f4452 ("drm/amd/powerplay: add dpm force multiple levels on cz/tonga/fiji/polaris (v2)")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index e9b569b76716..1a4010fcf561 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1094,7 +1094,7 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
>  static ssize_t amdgpu_read_mask(const char *buf, size_t count, uint32_t *mask)
>  {
>         int ret;
> -       long level;
> +       unsigned long level;
>         char *sub_str = NULL;
>         char *tmp;
>         char buf_cpy[AMDGPU_MASK_BUF_MAX + 1];
> @@ -1109,9 +1109,9 @@ static ssize_t amdgpu_read_mask(const char *buf, size_t count, uint32_t *mask)
>         tmp = buf_cpy;
>         while (tmp[0]) {
>                 sub_str = strsep(&tmp, delimiter);
> -               if (strlen(sub_str)) {
> -                       ret = kstrtol(sub_str, 0, &level);
> -                       if (ret)
> +               if (sub_str[0]) {
> +                       ret = kstrtoul(sub_str, 0, &level);
> +                       if (ret || level > 31)
>                                 return -EINVAL;
>                         *mask |= 1 << level;
>                 } else
> --
> 2.29.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
