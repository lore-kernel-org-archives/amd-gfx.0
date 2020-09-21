Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098D5C35257
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 19:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B435720757
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 19:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3oWnFxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B435720757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B468891C0;
	Mon, 21 Sep 2020 19:25:30 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 434B9891C0;
 Mon, 21 Sep 2020 19:25:29 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id e16so14032354wrm.2;
 Mon, 21 Sep 2020 12:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dLMkI8ryKHY4AVg+9eBO/sbeSRFdzsZAIvzUi2Ima0c=;
 b=a3oWnFxre3X3EVrZqmHZncc2RbsmD3HNqLY6FtIBHhlhC3U8K5EEvFrmduxbZ/Z41s
 c/pQQrYsJ0o9ENHX7JIv9W4y9xay/bu318Uv+ipTX/7m3VJbYzsUWZYGPyQ3v/omDhzk
 8ts/EFNS0wHmlCMbApVOHYms9P3LEmKqAjlkgVj7s5YbToruI88PNYDX0RsXvq8WQYzy
 iJsbHJIHKENAKjKAKj/dCZNOmlMV46Gu/77E57vJZ2U2aKq0kgbG+B7HKfFvjL5touo9
 yuidF0Su6CbUevMGuxwXr8IhnNDs/43X1JawX5TlRvZQCjjrWc14vANuOByHDSpkt10g
 OUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dLMkI8ryKHY4AVg+9eBO/sbeSRFdzsZAIvzUi2Ima0c=;
 b=erqwLxRWz3JuotR2cvgJEoF4apwJRQvAFv5cdXpWu8WMOC89tNJr5XsMvwtnMd+hvU
 5JMJplYBQ9nXW1NNLZiMW0/Jon7nFW3ACtX2pfDqImmPnDES8HbqftbPwhd879q4cG59
 F0FsMZ9+O7IKH/f0sLCqX5PASE708KaEVFGjgIIVVEcc5Sarb2IeLK/gRMTHIcQ5eHnq
 KDeG6new/6nf471nObHu60A4o9c4TFGPH56bJ8Nma3jLz0CNkcTZkf6TFJKqByCANLk9
 zWBUIn2HPRBJjcJCyeseqidMFCjCriNyUE6kbSggyD02M5UiyHDbcztgbrYNtKtwJIDE
 z84Q==
X-Gm-Message-State: AOAM531ItdcKmtlVZMSGYEg6DaNegIl5i+9UmlNBxy6nWLGd9CXYYBES
 2o50WUgPZZw4Z/QfEEtXCeFagZLGCdxnu59K3wE=
X-Google-Smtp-Source: ABdhPJw0SPwIJWrXygk92hq9BwqUmYd3YQsJNKHUGhEESLuDkxc0IXIJLsN3bgK8SQ811bAsX0tGJLEoqwySs35R478=
X-Received: by 2002:a5d:6886:: with SMTP id h6mr1369776wru.374.1600716327871; 
 Mon, 21 Sep 2020 12:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200921131011.91281-1-miaoqinglang@huawei.com>
In-Reply-To: <20200921131011.91281-1-miaoqinglang@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Sep 2020 15:25:16 -0400
Message-ID: <CADnq5_PkRAsFEUtVCP5f5Z9BKfLD9404MrprGv34gSaKMMxO6w@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu/mes: simplify the return expression of
 mes_v10_1_ring_init
To: Qinglang Miao <miaoqinglang@huawei.com>
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
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Mon, Sep 21, 2020 at 9:14 AM Qinglang Miao <miaoqinglang@huawei.com> wrote:
>
> Simplify the return expression.
>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> index 4b746584a..1c22d8393 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> @@ -832,7 +832,6 @@ static int mes_v10_1_queue_init(struct amdgpu_device *adev)
>  static int mes_v10_1_ring_init(struct amdgpu_device *adev)
>  {
>         struct amdgpu_ring *ring;
> -       int r;
>
>         ring = &adev->mes.ring;
>
> @@ -849,11 +848,7 @@ static int mes_v10_1_ring_init(struct amdgpu_device *adev)
>         ring->no_scheduler = true;
>         sprintf(ring->name, "mes_%d.%d.%d", ring->me, ring->pipe, ring->queue);
>
> -       r = amdgpu_ring_init(adev, ring, 1024, NULL, 0, AMDGPU_RING_PRIO_DEFAULT);
> -       if (r)
> -               return r;
> -
> -       return 0;
> +       return amdgpu_ring_init(adev, ring, 1024, NULL, 0, AMDGPU_RING_PRIO_DEFAULT);
>  }
>
>  static int mes_v10_1_mqd_sw_init(struct amdgpu_device *adev)
> --
> 2.23.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
