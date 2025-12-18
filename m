Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40D6D6D222
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 13:38:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7E2110E56F;
	Thu, 18 Dec 2025 13:38:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="kGC6N5Nj";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96FCB10EE62
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 11:06:30 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so3397485e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 03:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1766055989; x=1766660789;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YdmSp98VOpb4w/1T9TrcnGT6vsEQNrGtK2z/qAxMy0I=;
 b=kGC6N5NjuC79ag+Se67nwyJPwl9hM426ltjpUow7XFJysle1ql8fIZ6U3aNUoLw6Bt
 db1PkYnxPEwwhBBVjawt/Mt2kbDGyy43cez3VhFb4H9CMQoGIiTamH0I4W8HB6qg2Wox
 8PMS0VOu77kB0r2Vplr/UAJPU/LiLrbJLCHPoZe4j5D62JZjhh/xPWQ7j+On2AhahV6O
 RqchS5FwfpVjFaAs7/OlM6r5f/ED06L0L2LUB5D8KWXcSZ/zXwkBHARXrw3U5tWhAmu9
 hGDZBDQoPX9kEn7mArWeXOJeUCswXLOMDGJgntdneMcsvUcBY34DPq35QIxO0KKRZKi0
 nAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766055989; x=1766660789;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YdmSp98VOpb4w/1T9TrcnGT6vsEQNrGtK2z/qAxMy0I=;
 b=bAAdJk6Jv/cvtZyLXpL6XlZFsDWhWIr//OGZ+T3/+Spq0PHB6BMyoJctmW4bbIQrFN
 puOKwzkfs6mt7tTqFzrhJCesKkTbqHPSRiOuPVwF81W/ctYR4eVCuX5OafcmgNDHQr3N
 wp1DBn27teh/vJ+WvQTSpLi/Lp7OLllcEoAzAeIMAiIE/1ZEW0nvzp6QrADYODx0ozU+
 1tTX1r2R4kQeZH3Vb51ZzS3p719lAK+xJRJ302XbCyF8Da6dADSo3FBFhmgxGo8frbJv
 RQ/JftVwnN6NSG3fooQ3wPoI4NaDaMxeGAUzGKZycCQpB2dlFwytnoLWq5fZmsy2iJfj
 dwiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5gPbBcp+oKRAT2hXrPaPqU2CLm05d5B/ouDECsAIbNwIpayfhn4KP2J3NkvwW6lyMJ9XYIfTh@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5Hm8OTsz2So1k8u3ab1H9bOWAwHvdgYhOS1KKVklQbh/lMU7/
 DrguTM/JtCTmdRuh9TsgV5Fe3M9vKnjF9vrLGckf2zW2gsaXavrEhU8sfgdJlsj13Ou2kB/U/He
 WjiBmxZvCLQKoH3a5Q5T1yDxoR15KYfjH9x2lgwIT
X-Gm-Gg: AY/fxX7UpDncuUG03i/jo9etlIwNbQoTA2+ve0oF1FCdaJAroVyNwePKXt4+0xeiTn4
 LmmoUM6gdnrU+wgoWoc+zzgDJV9P2NW+YwIprlWcV5+4UbB3YHx5FshQ5hrCtNwXKm9alwAkVbh
 12cMXduNz1t4u4yxwrrFZuXOWOo5F1ufCY352ABNibjayn78WIbvdnLEuK0pq8TenRurPXl+B6J
 8/aWPXy7aTv9U6UdnZi/dkmQR1IGdzYuhFC8/hRUFT1L/JpZfsYxjL2y9MoxOYB0pixR3pjmcEe
 KY7odVBE+lbZiMR8uw2UGkYjVA==
X-Google-Smtp-Source: AGHT+IHUVbI/1P7zakDM7Wi5UCm2XC9PsUzzgUmoBdz1wcDrZw0JyEjKaERyGFb8Dk6P9ewUvmrPIJy5bf6RJ2inAko=
X-Received: by 2002:a05:6000:2311:b0:431:266:d150 with SMTP id
 ffacd0b85a97d-4310266d59dmr10262959f8f.44.1766055988640; Thu, 18 Dec 2025
 03:06:28 -0800 (PST)
MIME-Version: 1.0
References: <aTV1KYdcDGvjXHos@redhat.com> <aTV1aJVZ8B8_n2LE@redhat.com>
In-Reply-To: <aTV1aJVZ8B8_n2LE@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 18 Dec 2025 12:06:16 +0100
X-Gm-Features: AQt7F2oOZgjISObSjjmOs0kcLH0arkernyhqWoUniY0Q3NRwv2tC-Isq-vwEzQQ
Message-ID: <CAH5fLgiYyfrwvmPyVGYD=sbsyY_2G5Z3mbfNRDa4uC2PS6iQTQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] android/binder: don't abuse current->group_leader
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

On Sun, Dec 7, 2025 at 1:39=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> Cleanup and preparation to simplify the next changes.
>
> - Use current->tgid instead of current->group_leader->pid
>
> - Use the value returned by get_task_struct() to initialize proc->tsk
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
