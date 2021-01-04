Return-Path: <SRS0=8zgd=GH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3756DC433E6
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 17:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9278224DF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 17:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9278224DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C08A89FF7;
	Mon,  4 Jan 2021 17:00:40 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAA7389FEC;
 Mon,  4 Jan 2021 17:00:38 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id r9so26587365otk.11;
 Mon, 04 Jan 2021 09:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mLJaDNIBiSp2oExEtnWCPvISc7T9R6s/K5ftE3MvkzI=;
 b=hY56ihJuziw/5YQ7KCQQBkSqw7AbisOyW+vph4s5wGL2khGhvtWA/hnjqO9Cp6dNcc
 TZbEAx4h/eQY6oF4RMRdzsQLpoKAvf71IMknElWFWIkU/C2Od8KXZ6ZYTU+IbrgpEGxp
 dbs4ZSD+AqtrIw8X54RmzwvGJJdMNh55vlgxJiVhLxNL3BlejfBbVtE5ZpurF7vuHVgX
 Z5WKcybXlSVGRPI2S9xeCBGW5bOO1gRWNHZdqinFGCU2ugfQSEExGf5gKDE7xMgmLdi0
 3Zhw4x9bmDpQxkqsNvEKsuZyhTNwuaP8Lmk0Yz3rmrUVjU+SZo61zXEU3uYBxkH+VPhH
 1iSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mLJaDNIBiSp2oExEtnWCPvISc7T9R6s/K5ftE3MvkzI=;
 b=aZltqyoCJ9QQOBri9Zfyil2+QRetlx+tUPW8qC5ShAoOkfdEHeb6nRnwLG0fCvpbCT
 MswgFf3N27tVwTkAfpPZhueHiz/qSyYrUE5F/hW7z6i64oswH08bcfzRYP2A+8AQ5E0Z
 N1vlKWrkuyznDjTACoTee7TifwS4ytUHSddVUSc9yZqmDVyUhyWaJtnX47fAwNuE0hbd
 WQdPV9I5r3teFqPl385377pjpCebMCaNSQMf/YKifI2T7LXrv2/vOEHp9bqXs4S4SXVz
 Z9lfpFw39YKLUkGdVsxUdn+31WaHct7DTcn4svqsPmacMJMhCXoOit95CNCZcXFR+Agr
 XC3g==
X-Gm-Message-State: AOAM533myGnKbx50uRhewMGZjHreN2n5u0Wgzlv3EJ7B7vIn1MQ/Lp07
 X0fswojaW7zTgHXakAWOyr+vN6KsSKFzVhUtKIg=
X-Google-Smtp-Source: ABdhPJwm7yJXYb0sKmhZ64e8rOh+obz10xknZR5Tj9FfQjOj0F2CBe+0kvbY+VEU7A/ESkv4gGGY6agIjBFEb7WawpY=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id
 d27mr54799967ote.132.1609779638100; 
 Mon, 04 Jan 2021 09:00:38 -0800 (PST)
MIME-Version: 1.0
References: <1609057469-3844200-1-git-send-email-bodefang@126.com>
In-Reply-To: <1609057469-3844200-1-git-send-email-bodefang@126.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Jan 2021 12:00:27 -0500
Message-ID: <CADnq5_NhD5WUft5BnBrSjMn4x=5tb5Pje1_BUJyu60FtiFpNpw@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon:avoid null pointer dereference when dev is not
 bound
To: Defang Bo <bodefang@126.com>
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
Cc: Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Dec 27, 2020 at 3:56 PM Defang Bo <bodefang@126.com> wrote:
>
> [Why]
> Similar to commit<0fa375e6>. If the set_state/can_switch code access the drm_device when dev is not bound,
> a null pointer dereference can happen.
>
> [How]
> Add sanity checks to prevent it.
>
> Signed-off-by: Defang Bo <bodefang@126.com>

Are you actually hitting this or is this just defensive?  I don't
think we can actually get into a state where this would be a problem.

Alex

> ---
>  drivers/gpu/drm/radeon/radeon_device.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
> index 266e3cb..50a1a60 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -1224,6 +1224,9 @@ static void radeon_switcheroo_set_state(struct pci_dev *pdev, enum vga_switchero
>  {
>         struct drm_device *dev = pci_get_drvdata(pdev);
>
> +       if (!dev)
> +               return;
> +
>         if (radeon_is_px(dev) && state == VGA_SWITCHEROO_OFF)
>                 return;
>
> @@ -1257,6 +1260,9 @@ static void radeon_switcheroo_set_state(struct pci_dev *pdev, enum vga_switchero
>  static bool radeon_switcheroo_can_switch(struct pci_dev *pdev)
>  {
>         struct drm_device *dev = pci_get_drvdata(pdev);
> +
> +       if (!dev)
> +               return false;
>
>         /*
>          * FIXME: open_count is protected by drm_global_mutex but that would lead to
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
