Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11A9C5DF81
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 12:34:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 114E710E1CF;
	Thu, 20 Aug 2026 12:34:00 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C05010ED94
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 09:47:21 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-80cebd41372so13859467b3.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 02:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787132840; x=1787737640;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dIMgKn9ssmwMdJVgg9MfbDylpozJGdyvq0xNOf3CW1Q=;
 b=DGYpN8EtAdbGm6JgNDhE2jkX0Tg4lXEwqRpYUJ1f3v9+mBMbojRFm6KxBYW82jZ4f0
 tE4OtWB51qTF/yZCrhuIRJ3qXNh7M1XAc5O0vGn1su4wqgLoh5AX1tIuGFdby8lKctc5
 6uAJxJHHDfej3UnzrzybizX8WoNx+jmF+SiEiaZrb99bhVHBS6oMjHc+Rwr7moaWNRUm
 JLDgrN8KwjIwlWZDCZcggetfguvMDDBYtghkXenkOL2AUz3BLgQraVnULZSO7c3Atf7E
 FkgDwP1Mf13w5uF+q1DfF4JxjYAwhEFf5jtoXPOMSUxxRhRv20025TJMNVj0VEZ4OFt+
 4H7A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrH7506TQqUHNfRwuEdgDWxDwDOyugjDnkf9K409JwvMb7qb0f0FQqiNDYuak1nQUNRFe0dsNf+@lists.freedesktop.org
X-Gm-Message-State: AFuF++m5VnH5IAuOQIxQAqqSMIn1jEqdNw4zDzAceBaV/LRh3HIgJsVz
 dTluXAoaXbYN7DiAK9V7pR63Ykjbt0hvHVMVlgmz4RSKTTEhUG2WqzxOfwRLr7mvPiY=
X-Gm-Gg: AR+sD13lI4qwG8Qzu2YB+X0he6U0X04D+DemXsnhlJf32IaqD7YzVlENr75iOwqD1PN
 c1SizU69LPqeGR2h5usCfzBIQSCsgXFSZKHcB1A03w1mG2B+h6usdzAtIxhqiirehmSSz683U5u
 PnpOj+YZjj/GcAPSfT9K4UdazVsY2GsKJr7OdbXMQJraSypJO0MgbrnD2opOP4/L2Dih2M45pvx
 bBff+FUrPAOuPDB7eD0mskYVyJ+HVHV4uSCoTrOtZn/iyUmmtxzA4+Zv0NxrCIVA9P9Wq7jIlvF
 ZiZROD38ya5YU3XUgofGvJeFCo4onM/xnVTKQFRrzsUw0OzgnLa8fSNP0n0i/WXMOVoW0PGiyFg
 gtjIqDTE6BdajQV068Xbuiwcmmw8WDo4HF0IBXSynVh/WbxcUIIHdNB/INSn+Dj85v4RnRMhGjG
 GaKrOxq4AGs1ZQgdNtRMi9X8qXQR87dVrREoZ4ENZIgRH0aplqMOUoUpl5PlQ1KTjPL8w/9dzOd
 TGGCtQfaCbg0LpcELp5qWdITnWv6Q==
X-Received: by 2002:a53:cbd0:0:b0:66c:c6b3:b1f with SMTP id
 956f58d0204a3-66ccb621feemr958819d50.14.1787132840241; 
 Wed, 19 Aug 2026 02:47:20 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com.
 [209.85.128.170]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66ccafcfe96sm713963d50.4.2026.08.19.02.47.19
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 02:47:19 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-836ce5d6e85so14295887b3.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 02:47:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RoddLqaT9+3To4zlrJbQyj7WLuEnx81hbti4cnRpLYJMw84qPrwxATVvaXrUhJnrG2YkvZtVTrg@lists.freedesktop.org
X-Received: by 2002:a67:e04e:0:b0:777:ffe0:a10b with SMTP id
 ada2fe7eead31-777ffe0a6b7mr539021137.4.1787132346344; Wed, 19 Aug 2026
 02:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260818125012.468092-1-tzimmermann@suse.de>
 <20260818125012.468092-2-tzimmermann@suse.de>
In-Reply-To: <20260818125012.468092-2-tzimmermann@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Aug 2026 11:38:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWYVjvGM2pOzWoDq8LUSrkFtzOQwdmosHYQuBLnSn3D-Q@mail.gmail.com>
X-Gm-Features: AcwNN1Uwr-MWNK1wEAyEr8Z9JNVhxk4jrnSNE7dazUpWIvLo30uHHQJP967oerw
Message-ID: <CAMuHMdWYVjvGM2pOzWoDq8LUSrkFtzOQwdmosHYQuBLnSn3D-Q@mail.gmail.com>
Subject: Re: [PATCH 01/12] drm/panic: Allocate QR-code buffers statically
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: jfalempe@redhat.com, javierm@redhat.com, airlied@gmail.com, 
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, nouveau@lists.freedesktop.org, 
 linux-renesas-soc@vger.kernel.org, virtualization@lists.linux.dev, 
 sashiko-reviews@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 20 Aug 2026 12:33:59 +0000
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

Hi Thomas,

On Tue, 18 Aug 2026 at 15:00, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Declare qrbuf1 and qrbuf2 as static arrays so that the module loader
> allocates them for us. Avoids the kmalloc later on. Also allows for
> using sizeof() to get the number of bytes in each array. Access the
> arrays once with memset, so that the physical pages are available on
> a panic.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for your patch!

> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -628,24 +628,23 @@ MODULE_PARM_DESC(panic_qr_version, "maximum version (size) of the QR code");
>  #define WINDOW_BITS 12
>  #define MEM_LEVEL 4
>
> -static char *qrbuf1;
> -static char *qrbuf2;
> +static u8 qrbuf1[QR_BUFFER1_SIZE];
> +static u8 qrbuf2[QR_BUFFER2_SIZE];

I am not a big fan of increasing kernel size like this.
You may run (faster) into boot loader limitations.

>  static struct z_stream_s stream;
>
>  static void __init drm_panic_qr_init(void)
>  {
> -       qrbuf1 = kmalloc(QR_BUFFER1_SIZE, GFP_KERNEL);
> -       qrbuf2 = kmalloc(QR_BUFFER2_SIZE, GFP_KERNEL);
> +       /* best-effort allocation; can be NULL */
>         stream.workspace = kmalloc(zlib_deflate_workspacesize(WINDOW_BITS, MEM_LEVEL),
>                                    GFP_KERNEL);

<ironic>Why not use a static array for this, too?</ironic>

> +
> +       /* touch memory so that pages are there in the case of a panic */
> +       memset(qrbuf1, 0, sizeof(qrbuf1));
> +       memset(qrbuf2, 0, sizeof(qrbuf2));

Please clarify "there"?
In cache? Not all systems have sufficient data cache, so it may be
evicted at any time.
In RAM? AFAIK kernel and module memory is not demand-paged.
In TLB? Like cache, it may be evicted at any time.

So IMHO this is futile.

>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
