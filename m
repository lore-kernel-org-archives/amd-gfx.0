Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BF6D6D220
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 13:38:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFE2910E750;
	Thu, 18 Dec 2025 13:38:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="2+R/q6I8";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BA9910ED92
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 11:05:43 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-42b3b0d76fcso284928f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 03:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1766055942; x=1766660742;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h3ZC/RuhXgR3ZPLee6QKXin6sxuebHRmcV4+nyImDTA=;
 b=2+R/q6I87/sO2+nMfxtXaY1tHPPrP9mRRrg72PtEmuXDzQC3TND9K/iYANsDMcE2+c
 ppOoya8ruIHtWjUkGxpQMB9fVOOe7zfJwwJNAbBJMQ9XHCT7hF9WB4AeP6Uz3pNgBvMc
 HxttmXpfX3NbpY1dtt08kFR1rd1KZtVxMNPDqmWiPmj2LO8RUDbH0qgAr7OxFFSYsm2c
 dkokGVGMe5at4OKMID/whAlRfF8xWb5c1uI0kLvZe9BTD5ixqQncd6p9tAwL1WtvB2X/
 5pmzQ0MYEhBUrYzj9Jw5f85xn1SEWYeI1ujsqw8HGfLgovOK9sXxVGqg6TzazlKLmugR
 +9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766055942; x=1766660742;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h3ZC/RuhXgR3ZPLee6QKXin6sxuebHRmcV4+nyImDTA=;
 b=VMKQlWWB2OYmLr+YOxK3eDjpMiYfxRgoj/CKvIdp75jeCP2Vsqn4G4ZyRpCACHBwNz
 cQ2nIlZrsSnxbmym0MNEcqVlE2Cc/jF2b0Ebs/H97EmDaDq00SH5oAFv4MK3KAEpwyM9
 MvtLRKyiMGDg14GknblX9AVNgZqElrPPF+hOfjaR0o4VgAe1GjWJUjmgofPv/oBxzUwj
 HcXSkNZlCdMGLY1GFUzJflM2Z7FPdH0wQf97IG1e2gnbZkLtP2cEnja5XlRJXiEKzpBt
 HRNb8yEZSTTx+v2AiCiYy4XYp1vcdep5Eb/B2xEbCvMBH6GIbdzuGtdw6Mz1MPkJtjsk
 FQTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAmyPYlj0t9Oy22COG6uf2QaZDsTjsQgxT2TTI2KxecC3T742A6HQVN9vLnLsUMa5+U8kq4IJ1@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+tLZaOpGLHeesvamJpOILEatgJA90HRivg5XWuUImaZxKhdZq
 ZvF/RRGzbS7PPDq05n5JDtenWbLCK2Otq/DCWXGP2pSglmdxTk6EwzNQv8kfE7iqe3b9Cedlzi1
 RDWOR3+DMeaWJKvh+opfJ14vu9j065T/ofacXvzec
X-Gm-Gg: AY/fxX6bAohOIY9dNCXvNHfuym0YMvOHBlQRlvsy4ScTG2vNE44ASKDNcUeQxtk0xt1
 h6HSI18kkiOhYt6Pd+CwSiNMlcXrtZiHSyKi1dX+V2O8AN7jtVTz4YHOOh8vaFstx0TdfJjhu07
 O/CYbuwD4SFZlqiyYBslZ83ef1xr2U79AJAiysaAq2NECDbGR9oa39junA82Kc+FKbGz3zlMptK
 tzNP2z7MHW0e7PJ3Fd+uiXEB6rwMf0A1XF3FBi+BICd1ePKT4lKrz5HX5aMICMrImets/qnhGaY
 4EQEDqLD5tuFB257ur7s89LpGA==
X-Google-Smtp-Source: AGHT+IGXVDKrZjp+NvvA5/qC7WPXryh3eP96No0VLbAfD0dfrQ2PK6CbEoMBAf1PoLDqcVLWFCtzxrT0EkYfUfCTixI=
X-Received: by 2002:a05:6000:4009:b0:430:f5dc:d34d with SMTP id
 ffacd0b85a97d-430f5dcd49dmr17076013f8f.52.1766055941437; Thu, 18 Dec 2025
 03:05:41 -0800 (PST)
MIME-Version: 1.0
References: <aTV1KYdcDGvjXHos@redhat.com> <aTV1dc-I5vAw6i0n@redhat.com>
In-Reply-To: <aTV1dc-I5vAw6i0n@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 18 Dec 2025 12:05:29 +0100
X-Gm-Features: AQt7F2onwZDT6I3RNp-8EABXxVlAZANhhJ-GMV1t61Vpqe-l1BJnOF3T8fFh0Lw
Message-ID: <CAH5fLgjWQ2+eG=DV-m-1ybfs_Mu1UM2Zj0z8LvU4BbE0m9NXvA@mail.gmail.com>
Subject: Re: [PATCH 2/7] android/binder: use same_thread_group(proc->tsk,
 current) in binder_mmap()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>,
 Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Boris Brezillon <boris.brezillon@collabora.com>, Rob Herring <robh@kernel.org>,
 Steven Price <steven.price@arm.com>,
 =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Liviu Dudau <liviu.dudau@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
 netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 18 Dec 2025 13:38:39 +0000
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

On Sun, Dec 7, 2025 at 1:40=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> With or without this change the checked condition can be falsely true
> if proc->tsk execs, but this is fine: binder_alloc_mmap_handler() checks
> vma->vm_mm =3D=3D alloc->mm.
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
