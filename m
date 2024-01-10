Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CBEC4725D
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 14:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F23D10E60D;
	Wed, 10 Jan 2024 14:58:30 +0000 (UTC)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85C5910E5A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 10:12:09 +0000 (UTC)
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5f254d1a6daso38026447b3.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 02:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yngvason.is; s=google; t=1704881528; x=1705486328; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=96G7DIyssciX4jnAzNrTPlryo3sWO8sgy39soI2lLIM=;
 b=aiBYE17WJRr4FhbVQVOqHd5sUD6rek/aCjpVDlxRv7qYTDi6HYYmZ9JPKOVOxNUrpH
 HmtNi8+3yhTG6e56XRvSkDoN/dFyNwHUKgYKYDFu7EVAVOvWHWyIj61P7NHEL5upkrQ/
 ef/5tDW+KQ8/Dqjqn2DDxCKJg45d8bM2xfLV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704881528; x=1705486328;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=96G7DIyssciX4jnAzNrTPlryo3sWO8sgy39soI2lLIM=;
 b=EKCjZyI5CoN47suuVzHffvVS9LMuPcTmWdHAZi70pDlE/7YaWgUK7RO8zyR87+bSBi
 vIvT0HSRycM1aosYY/QmvUSMiZ+/oeDocrKAaxx1HbmkxDAHST3f8pzpRkl8nSYSa3jY
 5GOuW82vBOgeXWXvM2JfVuK7vng1IbqfRyFWU6OlYdsWkUSaqoYhBjuAIiVjEvNJNpFx
 s6O02dFhFFVhyArRcbycat5Ujve9x7FK8OzuEOERUHKuL4IHXgQoAY4gP57hgugxlGcq
 HLYnYJ+s+1KbQSHS9RfyAxYwNz6/PH9mtpfMpShSc2UPJ8CuhtRVfZL7f0f3szukK2Fg
 uuZg==
X-Gm-Message-State: AOJu0YxWWIBmGmZUrGyzy8siNr1/Rqp2rC1OqHJtGc++PTTd4t3Pfm5O
 OU14TZvIgDVgS096fyv6uhCfqjhUluG/XRCEB7eRCZfQe7a64A==
X-Google-Smtp-Source: AGHT+IGS4RF/sw1vbqlkX/KGSnVK4rjCwYusB936/yIZemFr40lAz/v1ty4wbuIZQF+WlPwAE3a+cK+ILR852Vcqmd4=
X-Received: by 2002:a25:f822:0:b0:dbf:227a:a2c with SMTP id
 u34-20020a25f822000000b00dbf227a0a2cmr504361ybd.126.1704881528497; Wed, 10
 Jan 2024 02:12:08 -0800 (PST)
MIME-Version: 1.0
References: <20240109181104.1670304-1-andri@yngvason.is>
 <20240109181104.1670304-6-andri@yngvason.is>
 <qdwv7sagqs5nmmsy5lko5hypldanfodafyzamrs3loj3n7jzlr@n5bacxkknkj4>
In-Reply-To: <qdwv7sagqs5nmmsy5lko5hypldanfodafyzamrs3loj3n7jzlr@n5bacxkknkj4>
From: Andri Yngvason <andri@yngvason.is>
Date: Wed, 10 Jan 2024 10:11:32 +0000
Message-ID: <CAFNQBQzijyE4wR34AOLM45m+ryx128igVKO9zPJ5-M3afFQMxQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] drm/uAPI: Add "preferred color format" drm property
 as setting for userspace
To: Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 10 Jan 2024 14:58:28 +0000
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
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, intel-gfx@lists.freedesktop.org,
 Leo Li <sunpeng.li@amd.com>, David Airlie <airlied@gmail.com>,
 dri-devel@lists.freedesktop.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, linux-kernel@vger.kernel.org,
 Jani Nikula <jani.nikula@linux.intel.com>, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Werner Sembach <wse@tuxedocomputers.com>, Simon Ser <contact@emersion.fr>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

mi=C3=B0., 10. jan. 2024 kl. 09:27 skrifa=C3=B0i Maxime Ripard <mripard@ker=
nel.org>:
> On Tue, Jan 09, 2024 at 06:11:02PM +0000, Andri Yngvason wrote:
> > From: Werner Sembach <wse@tuxedocomputers.com>
> >
> > Add a new general drm property "preferred color format" which can be us=
ed
> > by userspace to tell the graphic drivers to which color format to use.
> >
> > Possible options are:
> >     - auto (default/current behaviour)
> >     - rgb
> >     - ycbcr444
> >     - ycbcr422 (not supported by both amdgpu and i915)
> >     - ycbcr420
> >
> > In theory the auto option should choose the best available option for t=
he
> > current setup, but because of bad internal conversion some monitors loo=
k
> > better with rgb and some with ycbcr444.
>
> I looked at the patch and I couldn't find what is supposed to happen if
> you set it to something else than auto, and the driver can't match that.
> Are we supposed to fallback to the "auto" behaviour, or are we suppose
> to reject the mode entirely?
>
> The combination with the active output format property suggests the
> former, but we should document it explicitly.

It is also my understanding that it should fall back to the "auto"
behaviour. I will add this to the documentation.

Thanks,
Andri
