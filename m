Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD83BC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 19 May 2022 14:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6788710E5E0;
	Thu, 19 May 2022 14:58:24 +0000 (UTC)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84F1910F0ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 14:52:24 +0000 (UTC)
Received: by mail-yb1-xb2c.google.com with SMTP id q135so9447296ybg.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 07:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X3MaARWJ+5KG00Wc5nTbIiJMgENCDmkYALjE5uIyz6c=;
 b=eZT3F2+MWMucw2Gp0mVJ2l/DTHLIC06PRZzaRe1OHJnbYryPlNCia7J9bsGwiyGmjn
 3g/e9iJQKkg6kFwzBx41R/X3Y+dtjKjGeVUL8kYhuCUKJ962BB/TyzWZV1C5rHslW3rk
 VZXl3RRQrtXU8a5gGzthh9h3BxjwgRBGBIetAW65TSyNxsgL1o2RI8KMe5lZluVW4etb
 iw787C+ujVB2UEeP/Ioc3tkGMwz9ZSiNpZnAZ2XYjcFXr6dwytffJGipzgr/FkDLSXIg
 5wPOhnHFuTODIFBCzMbTBNKEYkhOm3iMo5C6wo/jdKXC3dKDcuqSvfz4W793aNqABquW
 mlbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X3MaARWJ+5KG00Wc5nTbIiJMgENCDmkYALjE5uIyz6c=;
 b=rJv1s5wLAjBELbYKdJcZM8CRNG44F0TcVucCjRB454FTVwj6WTSoy/uzAzJAvzN2Nq
 zDw9WzuHUZSN3Uw0ttBEF6N4uf3bVMbfU2+ibDYkr7PxbbC00yC9jF+uy4rfKJbDGWy1
 9yeBGlTsqdN0oULH/9uhch940Ng+S0xk+VhpTbxspvaYZJhPMaxcTXF0/R3Wd4TJLB7O
 oD0usJweYTIqAeQkAm+aved3AM5gk8xyTkaSjj1BS4V5caCpRsizSVW6R89siGATp9RE
 5aFHIScMb+v+bbNgZvKJ0josFc7d68xO3aF0lupe2CDjU//6YJ9/9Ro9t/dpIDhIQRoD
 CWeg==
X-Gm-Message-State: AOAM530enYy7IoRjyqpy/C2KaPSR92rbfz50F1MFEYRVeh0DP/dEmPcg
 m7C2s7HGgthuCuRhe9RUp9sUR8Q4mtCOna93K9I=
X-Google-Smtp-Source: ABdhPJwzEdwbgzGdTY5qz3Fu1PA8aC1IL8edBVPBKEfLmiuQatdgFZs8VIsANTshc9yZJSPdjZ9rsu0kIsQLGnOjL/I=
X-Received: by 2002:a25:c7d0:0:b0:64d:a15e:7599 with SMTP id
 w199-20020a25c7d0000000b0064da15e7599mr4650204ybe.251.1652971943711; Thu, 19
 May 2022 07:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220519135642.83209-1-andrey.grodzovsky@amd.com>
In-Reply-To: <20220519135642.83209-1-andrey.grodzovsky@amd.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Thu, 19 May 2022 22:52:12 +0800
Message-ID: <CAJhGHyBQ60Lh3WZCa+2cE4T36t3vjNxYTBCxS7J0xhZr8Eb2wg@mail.gmail.com>
Subject: Re: [PATCH] Revert "workqueue: remove unused cancel_work()"
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 19 May 2022 14:58:22 +0000
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
Cc: Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 19, 2022 at 9:57 PM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> This reverts commit 6417250d3f894e66a68ba1cd93676143f2376a6f
> and exports the function.
>
> We need this funtion in amdgpu driver to fix a bug.

Hello,

Could you specify the reason why it is needed in amdgpu driver
rather than "fix a bug", please.

And there is a typo: "funtion".

And please avoid using "we" in the changelog.  For example, the
sentence can be changed to:

The amdgpu driver needs this function to cancel a work item
in blabla context/situation or for blabla reason.
(I'm not good at Engish, this is just an example of not
using "we".  No need to use the sentence.)

Thanks
Lai

>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  include/linux/workqueue.h | 1 +
>  kernel/workqueue.c        | 9 +++++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index 7fee9b6cfede..9e41e1226193 100644
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -453,6 +453,7 @@ extern int schedule_on_each_cpu(work_func_t func);
>  int execute_in_process_context(work_func_t fn, struct execute_work *);
>
>  extern bool flush_work(struct work_struct *work);
> +extern bool cancel_work(struct work_struct *work);
>  extern bool cancel_work_sync(struct work_struct *work);
>
>  extern bool flush_delayed_work(struct delayed_work *dwork);
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 613917bbc4e7..f94b596ebffd 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -3267,6 +3267,15 @@ static bool __cancel_work(struct work_struct *work, bool is_dwork)
>         return ret;
>  }
>
> +/*
> + * See cancel_delayed_work()
> + */
> +bool cancel_work(struct work_struct *work)
> +{
> +       return __cancel_work(work, false);
> +}
> +EXPORT_SYMBOL(cancel_work);
> +
>  /**
>   * cancel_delayed_work - cancel a delayed work
>   * @dwork: delayed_work to cancel
> --
> 2.25.1
>
