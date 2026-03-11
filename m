Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE13FD88D6
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 02:07:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E747F10E05F;
	Wed, 11 Mar 2026 02:07:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nd7k/8xX";
	dkim-atps=neutral
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F26F10E253
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 02:07:34 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5a13d1c6f25so4703786e87.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 19:07:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773194852; cv=none;
 d=google.com; s=arc-20240605;
 b=DhnNAssbgD+EMW+pJBgLncCd3JsOZX6NiI+XxcFntvMKQbdsDD4SmFx/I09LgPJw7L
 7QXhdmrk51WVtElgK+vIjLF8qYIfv4x4t95PIXlNVqSjWaEkJhseK07IYOKN6CSpaiDl
 yTafQRUzt8/ptE1baIjXfZDFcuXcsavQL2iNsQfDiXWsyNP3tujE+IYmVovVq4cLlaHG
 JDNZApw2J3CdzixxTnQVHHVL03y5kePZD2MW4FQpM+nAROaUwgU8JnDZdfDyQV9UuQaA
 DA/qGpzsga8vag+nKUUI/UO7EV9/qVQs7yDwSfBdWrFQEHDbIdO7mxfhIPsEABn7BV58
 ZVxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+zLBLQzKjcztDlxJqoLP6w+B6xnZmfHibV4jlBQCebA=;
 fh=0frPmOrWCwZtrrHHapnMWcdP2CQyCoszswiMMLRzeQ8=;
 b=cQc2U9uCCX1mgP3tcjw8w5dx0Iy95oCv+E+5Dr7SBj9j/XW4vmsesVWxn1AbN+3oL8
 BAhIsEftNNDmJlVkozAyrU/kQ/x/vj7VpwlMARz4ddC+jUcC+Ufpd4/yNJ2peWUwy3pC
 xvP61bICJZIQWDDZ6guwZnC0gqF4uoiFpsfpEp8qBURW2jHRJcpKEBpxznGe9/oSf6ki
 U4yjF5/n9ezqpR3C8TT9LQ1B9Y4XTX/P2/4euy93h+OEi0OdmOkodXuB8KCvHtA8tm9m
 Y39CfpEEdTk3YmvfOAnUucMzje7r+K+EVEywmV/TltXKlFCX7MzVHpkNkyVf2cXRlnBw
 42ZA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773194852; x=1773799652;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+zLBLQzKjcztDlxJqoLP6w+B6xnZmfHibV4jlBQCebA=;
 b=nd7k/8xX4jYoots8KkbfkyPyDpGU+k9ydIKKC55qRoaqMjU864KI25IQNw1cw83xcU
 MN05V2yxwI7AV8sAHbEvs4phnlx1ZuezEZUNsu1KbKh+rjIuKOQPHccG7HkXkdCN/AzY
 Z/Y+1SmBbMXBBNVWAuu/jAClbL7mde3NiWUwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773194852; x=1773799652;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+zLBLQzKjcztDlxJqoLP6w+B6xnZmfHibV4jlBQCebA=;
 b=kupRucUy6gIb+6IIEeEqWdbfWUl+jDTXlNB99i8IPFd2xNTn/GfDOMaH88Og/7XONN
 jrQkiy6RxpD8HyrJVk7a70D9qJk7vmSSu+cau6rJsw9MZTHw9Mj3rwagZ0ammmAPI6eX
 kFmziT7xRCWjK+xYYg7+bko6Q9zD0RH7SCdV9lQBC6rpgWYMDigJkbfuLrqT3cCVJaRn
 46Xj2qtQmnBIwApoUC2wy4gtTRK/kegSzPcYNXx9u7r6kptNefx48ju9MDm/+cVoKXPV
 XRGSr+hvVzPSzdlqP+F+WvLu3aYO5PjmsrccjfBVMUA7DXc88OIS2MLu1shlV9nFg6Lo
 ZbCQ==
X-Gm-Message-State: AOJu0YyXrLnKo9JhR/M4oyCCzeNhQxiEGG3yV0pu/cP4+Ju7kroUBvb8
 GbRCiFS7Im/Xlr8CUxMtWCTxLLVuW4m+JqqJOQu+xhLUh3iqNNgc0JsibjTm5VXq9cleliu8LnA
 dA8TiQ992rP3R6fG30wPj2EU3ol3EmwX0+9wB5ZJN
X-Gm-Gg: ATEYQzx48eVSRbxFCcL7sYxS9dbZVqr5UdyifQJZekup09CqvwxWs+D1Op9OWgY+XDH
 br1gW/Af9Bks9mOMNB1W6J9dplyp0969pcej1dh3ECEzxBgs/nWNKp8hnODOB4f60dt8PfhhGHf
 SevwnNq8UxAJXqJbVhI73I/SYjI1puUwLlL1g5KLn2O2rXRybEN3agp2fGAZpTPxk6hX7qaXX4w
 yMi8nE7+5LPRtapkaFP3SYQqyjoAvBSqhgvIDXBT88NQZXvPL11cnAFUBYXDvBfXKnrHVw66NEW
 SHGqSYMieg==
X-Received: by 2002:ac2:4427:0:b0:5a1:3134:9bac with SMTP id
 2adb3069b0e04-5a156cbd1bbmr169453e87.28.1773194852284; Tue, 10 Mar 2026
 19:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 11 Mar 2026 11:07:21 +0900
X-Gm-Features: AaiRm5028PWt8n-JnveiRgn8oYMksdR_-_nk4JOkvxMfplWs-GDr7RRk-OxICyw
Message-ID: <CAGXv+5FQAVaJjqhv+Xq-ysOc4SHQn2mCNTgCAp8XocmWBWGGoA@mail.gmail.com>
Subject: Re: [PATCH 56/61] clk: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
 samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
 target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
 v9fs@lists.linux.dev, Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 10, 2026 at 9:57=E2=80=AFPM Philipp Hahn <phahn-oss@avm.de> wro=
te:
>
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Semantich change: Previously the code only printed the warning on error,
> but not when the pointer was NULL. Now the warning is printed in both
> cases!
>
> Change found with coccinelle.
>
> To: Michael Turquette <mturquette@baylibre.com>
> To: Stephen Boyd <sboyd@kernel.org>
> To: Daniel Lezcano <daniel.lezcano@kernel.org>
> To: Thomas Gleixner <tglx@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  drivers/clk/clk.c               | 4 ++--
>  drivers/clocksource/timer-pxa.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 47093cda9df32223c1120c3710261296027c4cd3..35146e3869a7dd93741d10b72=
23d4488a9216ed1 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -4558,7 +4558,7 @@ void clk_unregister(struct clk *clk)
>         unsigned long flags;
>         const struct clk_ops *ops;
>
> -       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
> +       if (WARN_ON_ONCE(IS_ERR_OR_NULL(clk)))
>                 return;
>
>         clk_debug_unregister(clk->core);
> @@ -4744,7 +4744,7 @@ void __clk_put(struct clk *clk)
>  {
>         struct module *owner;
>
> -       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
> +       if (WARN_ON_ONCE(IS_ERR_OR_NULL(clk)))

clk_get_optional() returns NULL if the clk isn't present.

Drivers would just pass this to clk_put(). Your change here would cause
this pattern to emit a very big warning.

I don't think this change should be landed.


ChenYu

>                 return;
>
>         clk_prepare_lock();
> diff --git a/drivers/clocksource/timer-pxa.c b/drivers/clocksource/timer-=
pxa.c
> index 7ad0e5adb2ffac4125c34710fc67f4b45f30331d..f65fb0b7fc318b766227e5e7a=
4c0fb08ba11c8f9 100644
> --- a/drivers/clocksource/timer-pxa.c
> +++ b/drivers/clocksource/timer-pxa.c
> @@ -218,7 +218,7 @@ void __init pxa_timer_nodt_init(int irq, void __iomem=
 *base)
>
>         timer_base =3D base;
>         clk =3D clk_get(NULL, "OSTIMER0");
> -       if (clk && !IS_ERR(clk)) {
> +       if (!IS_ERR_OR_NULL(clk)) {
>                 clk_prepare_enable(clk);
>                 pxa_timer_common_init(irq, clk_get_rate(clk));
>         } else {
>
> --
> 2.43.0
>
>
