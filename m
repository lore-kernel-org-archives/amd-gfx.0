Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81937CEDD9B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 13:32:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1127410E70B;
	Wed,  9 Oct 2024 13:32:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NRYiLHUC";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B84810E5BA
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 20:38:06 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-a9932aa108cso590533166b.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Oct 2024 13:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728419885; x=1729024685;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jBKc56vBxPYaOUWcC+VFZKlnp8sdizUoPysD1KL2n2Y=;
 b=NRYiLHUCQ7TImUks4fAatmLv/c5uDIiISlrDWnTFQR02uom9zRcW+Uyi630EwtrLOS
 rpn+clus4PoEaoSKGREcBZOO2TeBK8i5QT71Yh24xUCMM4+QelwwhGX8uPf306b+WpN6
 h3Ibpnr5FCh7DfMRkj0zKWnT4q92PmClirZcHgUJjwk2Y67XZ2JnngcsUIxzaQPEZFAk
 lse2Gk04nm8/j/zP2JcnXCFg7oXyNfhHisd2bbh8Fo0IPEJ9uLkhBf3DWnCN4R5kk/va
 AdIQfqmNlleVyM7MvWnO7ARvwiYVRvMi9vgLzbzWZbWEfUvXyryK0A7KH3BUim9hkKEm
 7zzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728419885; x=1729024685;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jBKc56vBxPYaOUWcC+VFZKlnp8sdizUoPysD1KL2n2Y=;
 b=OmPxFg4gTw+cFm0LJVpvXeOoar7VG1Ffa/ELZ2e81apX5lC0jo/rcrKyErkbCdVuc7
 51LDoR2Vu3ATd3CvKPS13OnPFCOfyg5fk5pAAIIFGKEbiLQDrU1LrUyyurkbBSgxhu2z
 QF53NGt1l7L2bbOOzN6czUuYQQ6dTLcUo7ND4Nt82xaCoe5YYqamgAms3sU4da9C4lUm
 KoN9S9CPiCk74kOsRtkq9Tr1OEN1B+tUWLXqGn+Fb5Aaq2fca+/9jfaT/8CM9HwE9yLK
 vEZB7epJmsITF3CuXplHqzIFreMV60poMuH+7eeTThCg3VhrhSvwhQVCAaZhLHbhRnLM
 iUZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURyaqzqXuxkOUHrO4oq4l7L4oqUEnGsox2DCGGbxwu/NqAP3tNtZkNz6yZkTAC8VBlVMY2pBwn@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywsh9X+yN+RmSzyY9XIk+V4QMFkklXXj1pbe5YG9i7SDGjTvv2Y
 YJ1A1RcmB2wD1ovlOaikQ9h1XLZgWxfj6Lt9lhzFkEDwDfirjKmwp+G213K8AMyReyhIhmwV7y9
 E
X-Google-Smtp-Source: AGHT+IFQsuFQDnMORn6KRqls83kXMRALTmz1xji/Zv3nzyXsaV17OwyYMIY5gtZ7u9n9SjQRNHRlFg==
X-Received: by 2002:a17:907:94d4:b0:a8d:250a:52b2 with SMTP id
 a640c23a62f3a-a998d114bbemr3268366b.6.1728419884897; 
 Tue, 08 Oct 2024 13:38:04 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:c420:a9b6:c5e1:5b65])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a996274deeesm196971266b.103.2024.10.08.13.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 13:38:04 -0700 (PDT)
Date: Tue, 8 Oct 2024 22:38:02 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-crypto@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-i3c@lists.infradead.org, 
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 patches@opensource.cirrus.com, 
 iommu@lists.linux.dev, imx@lists.linux.dev, linux-mediatek@lists.infradead.org,
 linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, 
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-pci@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-staging@lists.linux.dev, 
 linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
 greybus-dev@lists.linaro.org, asahi@lists.linux.dev, rafael@kernel.org,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 00/51] treewide: Switch to __pm_runtime_put_autosuspend()
Message-ID: <ttmnzgsdyng5vab63pvj7csrotbsmwnultjelvdotrvyg2snac@iv7afgect5f3>
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
 <CAPDyKFp0N6UJhnHS164Tdf=xkWB0jzq65L9TdvYazeBQ-6WjeQ@mail.gmail.com>
 <20241007184924.GH14766@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2ocqjla6tcmukjn3"
Content-Disposition: inline
In-Reply-To: <20241007184924.GH14766@pendragon.ideasonboard.com>
X-Mailman-Approved-At: Wed, 09 Oct 2024 13:32:04 +0000
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


--2ocqjla6tcmukjn3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Oct 07, 2024 at 09:49:24PM +0300, Laurent Pinchart wrote:
> On Fri, Oct 04, 2024 at 04:38:36PM +0200, Ulf Hansson wrote:
> > On Fri, 4 Oct 2024 at 11:41, Sakari Ailus <sakari.ailus@linux.intel.com=
> wrote:
> > >
> > > Hello everyone,
> > >
> > > This set will switch the users of pm_runtime_put_autosuspend() to
> > > __pm_runtime_put_autosuspend() while the former will soon be re-purpo=
sed
> > > to include a call to pm_runtime_mark_last_busy(). The two are almost
> > > always used together, apart from bugs which are likely common. Going
> > > forward, most new users should be using pm_runtime_put_autosuspend().
> > >
> > > Once this conversion is done and pm_runtime_put_autosuspend() re-purp=
osed,
> > > I'll post another set to merge the calls to __pm_runtime_put_autosusp=
end()
> > > and pm_runtime_mark_last_busy().
> >=20
> > That sounds like it could cause a lot of churns.
> >=20
> > Why not add a new helper function that does the
> > pm_runtime_put_autosuspend() and the pm_runtime_mark_last_busy()
> > things? Then we can start moving users over to this new interface,
> > rather than having this intermediate step?
>=20
> I think the API would be nicer if we used the shortest and simplest
> function names for the most common use cases. Following
> pm_runtime_put_autosuspend() with pm_runtime_mark_last_busy() is that
> most common use case. That's why I like Sakari's approach of repurposing
> pm_runtime_put_autosuspend(), and introducing
> __pm_runtime_put_autosuspend() for the odd cases where
> pm_runtime_mark_last_busy() shouldn't be called.

That's ok for me. However this patch series isn't the optimal path to
there because most drivers (i.e. those that already today do
pm_runtime_mark_last_busy() in combination with
pm_runtime_put_autosuspend()) have to be patched twice.

The saner route is: Only convert the drivers with a sole
pm_runtime_put_autosuspend() (i.e. without pm_runtime_mark_last_busy())
to __pm_runtime_put_autosuspend(). Then add the mark_last_busy() bits to
pm_runtime_put_autosuspend() and then drop the explicit calls to
pm_runtime_mark_last_busy() before pm_runtime_put_autosuspend().

(Note this doesn't take into account Rafael's position that
pm_runtime_put() might be the saner option. My argument applies for that
conversion analogously.)

Best regards
Uwe

--2ocqjla6tcmukjn3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcFmCEACgkQj4D7WH0S
/k6xnwf/QOZhbtT562rFFa3JIiBatDxTcqyEXoXClrP7jSyQFY/VFzq2S2jRHOFt
wM6zQUX1bTUqDtC4HozJIbQDjLxd3qFgc5RoTRLV8VhRJbcq9cOo5Nf1h4KJ5Ip9
nhpzoHwUHoEjEHj1f9UvEWfnFAVCSLFxgb14ZDHZyb2pQue3G5OYI2f2cJYT8YVB
xQktDFp7rUu4xWDTzoIxNKvR1Ipy5fGxdf9R2/+IQhW64sWuDG2ZH6tAmfn6mEb8
ecspbesJx+NMbZ06Zl7wqBvyj/DpQGgPaCnWUQ5cI0Of/kOzqxh4+65JK68CLLs0
/Goin2zz55IZITGC5zHuAA07bW/c7Q==
=7Wup
-----END PGP SIGNATURE-----

--2ocqjla6tcmukjn3--
