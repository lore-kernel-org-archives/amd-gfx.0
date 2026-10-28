Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1789606A31D
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bz3+WK9v
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D2DC10FC60;
	Wed, 28 Oct 2026 13:00:39 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA5A110FAF2
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 09:50:20 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-6b1f31c63ebso3106059a12.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 02:50:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793181019; cv=none;
 d=google.com; s=arc-20260327;
 b=dZBcxDNbGApptEmLhe0mbYTPL08WG+t2UHF4B6f2iBcCSWlMQ6e90G5hhE3UYVYQRQ
 +Bo9Lj5QRs4AEChYwG0v9S9iBbMgRo/supzY/sQI5VliFmLRafMT6OEvlB6mMK9EjIEJ
 CzQO9ke4735Rvwqs6SimJ/u8BRXz3uZUiNwnksDHz6i/DafF8PCJKqN/nUyl8P5/dowb
 44q9qO8SQzJqT+UMQ9FnMJ8m8sThTAcD7ebWl4ZiRQbwbOjGfSPzKVUAPkpPi3g9gAao
 lSLaeEMAxo5yj0sBS21g/24pt8sYaJQEM7qETfSQBFPoiBlJa/Nk6R6zD5EEmNZH1g14
 lEkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
 fh=r/2jh314yZLc8PkfFaEc9wFtcF6pB2QmYRTlECe8Jho=;
 b=KvcsaVFQvTicNXfUzfihcwoocX+RXqsoGnrTzH0HUCbM0LJTN4ixj+bjz7aNqJSROG
 wg3PvF/0g9YSpz5vojuNPPAs5GvAgjGWef/9jCVTs3S2k21UnrGNzP3gEz/cQoYCwKk7
 MQCRdR641w3i18802ziEYMB5Xfcuyx6eN3zVFp30luv4ZQJSIWjMM4z88ILQGevFCNZ7
 z0WvwduQZHvZ2socZg2QYnjUd50EBlbzYdhzn+MMENar1sGaWac1fWYBxpRPq8kBzyPF
 nAN0HEFCGNIfNHIgnGMr2K3BpdWvfXJ1doqJdqwvxiHWGXMrv9vIv68peSEzmk2tLz/+
 aqvw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793181019; x=1793785819; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
 b=Bz3+WK9vyGesa2exLO8XAnKJYqg8SZ6CJqaz8X6SDlrZvknyX+EoJESBClkEru2QRC
 cd9exExnGWZrfCmoGeN6vTRLEQe7gCpimIiaNs8nw2965xqqgBIfIr+luxXR9pXwtV/w
 kR5bRqgIEBMZwOqvfS8oY1g+XDyKYq3diHi4QWifoU+dhiZjEGIGpaX1ra37qYWrCVhl
 SpxA61OOphs1MIvEu6a6K8a02bM0mQhC0iRGYyG9OvABuv4ZB/Y0CGcRdcR7peSvYOwQ
 CO5mjIDZOq/Adp7OBTFX3dhfCyh0SwXF3kBSiRDl21E5VlWywYZC75SakzozEmw6fbin
 BU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793181019; x=1793785819;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
 b=IONW9QOwHEg7WEwv62hEVvFH17u8Fqo8/4XkvpZppZEQM++ZJvxLcoPAlAUHUP1WJ+
 03z4iyq/Q7ZVA2DlcXx52Np5fQdbUxj5Rlsqes1u1m1zx0tTb18wvnK5ueXjdX6D4sXI
 BJjickj96rlS/Bv2h3AL5N2w8Tbm+Ygwrg4h3ub2Zu4CbYeBBVkmgIgvCXlNDEIjsrFO
 vTOaDy9vSrWcUgXtxbReWwh5l733gPz6Co5HjsAOVIu1SQNY9kpObrf4QVuF0NPKvsPo
 ZrrGcQ7r8rtnTY3k8Ngd/t5JAjRIwa8nkJgKWvBhYuqn3k0cEAWwsvNUUPSVJ7zQNsUk
 LBHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5QCWscEkVvVZEgxpCY1YGTDbjXhRNemcW0aqvGUYiFMw8dNlZeDuZAucadOpZUY2yzOelf3Tg@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIwhQAayS/+MQ/1QJGhfDHFlhaOAcDaxDExD/kbSbnfDfXl+BRi
 wEiOH3Zpu5DaFFmFq0fh6I5LSABLm2HH0Kxk1JO+5cxHgPbnQFU0yh6+M+aWuBaMzMuocEUDsTJ
 RO8EhWI5sw9dqBtuDsx5Neffko8EBl6w=
X-Gm-Gg: AYBFou3IxTijBlXVVMnylVx5fkfTVlrS76UXz47pYJ5MVyuIIQiR0g8tZNAM6e7CE1/
 l/Hg8P8fCGX6kDamHtvxZpDXNjKvWkVnieqt52D50c8a9dLoRroKxBq+ixMv1FMUU4wPZ6bMG12
 Yl9vgj/EBj3eHidiRU0B/pqBDG36lOPUz9Zr1AU7GOL6AWIlkVrzEJ3Rv9tO40sbHN0QTGCFlkp
 oE50jOuBHI4kKrmEELYWesKJcKYtlvMFjbfuT8408GTevReX6wa55FSqHXWpBQjAvDS0B1en/5l
 I4L+gfEPXQVNNAjxLVVmeZ/XeT1UGjTCtd0EkSLW5RNrjXTVFd6zbbZlhEQ3obMEyd4Gk8eTr37
 xRuGBV1X+seHJUKCVnYXQUgIseJ/oOKC9bIDK1yGMY7ApGNzaMwQnNnVJRg3QkCLJYAriV4sSLm
 Qo5Z7fNP5eGIWNpVu/0x7h3pI+4rG9lCMUTFVqFdE2OCHKmY4MwSISmR8ajKylOZcmTLVv+KauT
 OGxj050mKa2C4ijgsY/62dxz0EFtJWuLYLGbjlUrzGXF8M=
X-Received: by 2002:a17:907:86a9:b0:c48:a838:c17e with SMTP id
 a640c23a62f3a-c49a739f8dfmr484567766b.14.1793181019107; Wed, 28 Oct 2026
 02:50:19 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1793027261.git.d@ilvokhin.com>
 <33ec8080594f9f4ef1d50e36497339c9a6897393.1793027261.git.d@ilvokhin.com>
In-Reply-To: <33ec8080594f9f4ef1d50e36497339c9a6897393.1793027261.git.d@ilvokhin.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Oct 2026 11:49:43 +0200
X-Gm-Features: AclHuK92we6zl1A1tCfKfYVeuXltUG4Bsfa-fRzr4orRkDVhJuYkTUAxt0MOtcM
Message-ID: <CAHp75VfR2i_PPZwSG2UPaxShU5L=FsSdEAT+0iUMDKAfugbRsQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] drm/i915: switch to __nonnull_args() macro
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, 
 Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>,
 Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-hardening@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 28 Oct 2026 12:59:51 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 10:20=E2=80=AFAM Dmitry Ilvokhin <d@ilvokhin.com> w=
rote:
>
> Commit 22302af28d3f ("cleanup: Annotate guard constructors with
> nonnull") added the macro __nonnull_args() to wrap raw compiler
> attribute.
>
> Replace __attribute__((nonnull)) with __nonnull_args() to standardize
> nonnull attribute usage across the tree and keep the attribute's quirks
> in one place rather than open-coded at every call site.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
