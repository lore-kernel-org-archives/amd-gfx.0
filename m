Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962FDC88E77
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 09:30:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F025B10E38C;
	Wed, 16 Sep 2026 09:30:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Fs7uoYbK";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60BC410E8F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 09:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789550999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pLJ3zniryXoIXYXj2kORk+UpoeKS9R6ImYDJyVbdKgw=;
 b=Fs7uoYbKDKY066K9mEP3HRx+ID0WQ/kgm9TcfeRaV/m2a/zUOl35CscWm0lj0D1cQaem/v
 8GDTETseFv5XUW4Waf59eLU87zvZeHYcQwD8ZJjWXk95nZSpTwms9w85ZC5lolaTKIUgQt
 SfSDULybjPURnR4f4dhCzrAI3hDsPnU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-78XU7aQGPVqbpIq-vvfSEg-1; Wed, 16 Sep 2026 05:29:56 -0400
X-MC-Unique: 78XU7aQGPVqbpIq-vvfSEg-1
X-Mimecast-MFC-AGG-ID: 78XU7aQGPVqbpIq-vvfSEg_1789550995
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2dd7d0751efso20290455ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 02:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789550995; x=1790155795;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pLJ3zniryXoIXYXj2kORk+UpoeKS9R6ImYDJyVbdKgw=;
 b=25umRTWQ1fWgbYHS/qtAPna8KB6v9I7/cCq9zw7oC7YhNMHDgXCFJpkGMvHVmpiUkX
 j9Ef13RXZ7vU0GER2/IWze6IJNtAq1aZ6JW2hHEB/ievUJmkxI1VoCApiOpKqB5VKbrv
 2d1M4AqKCExKR/VssAdfhRq/wx0A/vUTTg7PucPjN12glNTacJrV+hLnsdq08t/7mJ9D
 bVlr1SGD3EblN/FeqpfoJyVqGwGmPrZbZLIIWd48srg4lV/SeGiD2SeW4pA99x2AkjMv
 5FyBJYfpadX2Y+JmMStoXmSY2NFsD5+YUZ1UOzcFUxU0NezIsvHon4J5hb7LD7QlpLbz
 xP4g==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8d2d0qO2JVBdDcOPDdchIsm7TxqhHe9p8gmnZGIgGQEQcLrfIHaFxrRmhXpQW+rcznlBKTS1b@lists.freedesktop.org
X-Gm-Message-State: AFuF++nI3It4OQ2WTo3YKtMx1EpKjVmYmeBx2Ue3EukoUlXUhf1Zz0Ay
 YuhC/YouUrnCjhIudUlAF65UOAKBC5vorOP/pgiF6M2N4PCzU1AbPvu33+bApJU13kn54wrUfMM
 ijtiJJ2diNtJ9iO65ajQGjCohudOG9xxUDASDg+Arab8d3ohL0SFIGEkr+S2NC1vD0WBlMzPw8I
 5Q8+1Xat3m457BENwrFyH2ycWxOTjXaADOn+QqFTRPjw==
X-Gm-Gg: AYBFou1+iiIE8TvJAQ9kLK5OuWuXRcrhZiDLFpbnwjgOkfZOstzG/pa6Vwtu9B1jHbe
 HFzMJkewjzrUcPzjW6Rf4PHkXWK8q1o9in4z6XVqiIsrj41d0jshRRdnRzu3fzqd5vWtAgr7DQ8
 oVF3le2I17oV32TWydcZYSMX28GQcb3Mehy8MZS5amSRJJXldyy7YuKElH
X-Received: by 2002:a17:903:3b8f:b0:2d7:4bc8:41a4 with SMTP id
 d9443c01a7336-2dd8ea1cd1dmr23798675ad.10.1789550995062; 
 Wed, 16 Sep 2026 02:29:55 -0700 (PDT)
X-Received: by 2002:a17:903:3b8f:b0:2d7:4bc8:41a4 with SMTP id
 d9443c01a7336-2dd8ea1cd1dmr23798155ad.10.1789550994573; Wed, 16 Sep 2026
 02:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260911124540.279841-1-tzimmermann@suse.de>
 <20260911124540.279841-3-tzimmermann@suse.de>
In-Reply-To: <20260911124540.279841-3-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
Date: Wed, 16 Sep 2026 11:29:42 +0200
X-Gm-Features: AcwNN1VjQRR608PaSU5v9yXg9eP7o3aE9lu55JInhqrDujLUhvS3kxSMIUXF4N0
Message-ID: <CAFOAJEfWX09ZvnQvn1+SBeW4_MaSRO2JNLfoJRGYS4jXGr-09w@mail.gmail.com>
Subject: Re: [PATCH v5 02/14] drm/panic: Test address from kmap op for NULL
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: jfalempe@redhat.com, airlied@gmail.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, geert@linux-m68k.org, rdunlap@infradead.org, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, nouveau@lists.freedesktop.org, 
 linux-renesas-soc@vger.kernel.org, virtualization@lists.linux.dev, 
 sashiko-reviews@lists.linux.dev, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U-BRbIfCsbi791Ky-9KPrM9rcCitax9vEh16SERCjmM_1789550995
X-Mimecast-Originator: redhat.com
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

Hello Thomas,

On Fri, Sep 11, 2026 at 2:46=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Do nothing if kmap_local_page_try_from_panic() returns NULL. This is
> not likely to hapen, as the previous page from the same memory area
> has been mapped successfully.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 23437509a694 ("drm/panic: Fix 24bit pixel crossing page boundaries=
")
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Jocelyn Falempe <jfalempe@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.18+
> ---
>  drivers/gpu/drm/drm_panic.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index ba21df4be338..d28ce8878e05 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -178,6 +178,8 @@ static void drm_panic_write_pixel24_xpage(void *vaddr=
, struct page *next_page,
>         u8 *p =3D vaddr + offset;
>
>         vaddr2 =3D kmap_local_page_try_from_panic(next_page);
> +       if (!vaddr2)
> +               return;
>
>         *p++ =3D color & 0xff;
>         color >>=3D 8;
> --
> 2.55.0
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

