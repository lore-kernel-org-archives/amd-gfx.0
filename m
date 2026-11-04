Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5172D606A33D
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NrAZImVu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6ACC10E7D2;
	Wed,  4 Nov 2026 14:07:41 +0000 (UTC)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11D6410FC23
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 14:07:35 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-14388db1a6bso20263c88.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Nov 2026 06:07:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793801254; cv=none;
 d=google.com; s=arc-20260327;
 b=U46grCQJ/Uld1O6ts6o6YmwufWByQ151nF1ApNlE5JdlmNaPgZm74FIkkkyaVm5kZi
 Veex3Fg60iE8LfiqTQRbOYyvFuTaDjPVvbuRijH+gAOFyWY5fes8a3py/kcacpJ3wRfE
 LoJ4Uxv8b0aWe/ncz8hm6WgVx2n91/xV734fXCLN9FTlvpDfxUZrq1Q14G66UXxk7erO
 VfzXuxCtYC4QFNs+UF4UB/0m0lwgFx819ReTu3pKdpbN+NiEIPHG8I1SWPUBkGHDRJXW
 mNovvwkDP8io5pWk887xdxmA2NbkW7bE0pLXnf9suNc1spQdcvZiwilGHoiADUX4VHae
 mXlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SaAZs9B+UXOHTaRDcZeWz12aXXxWAqfcjHVOwU/3B4c=;
 fh=rXEUCLqNoEx24E+YUUB+qks4zsucxzaUJYhnqHkIgRU=;
 b=n0+Fyp0mNs3J5hga+DAxUOQ9rLmPiTdVncvK+WVK2UE40V3g9bqEO4KRcYAEvf7Cch
 LKv3zUXRXcaIfg1chZtf7HDfVyQD56KRXTax11IOh/9M6xzq/El4GDXhADJVNyBqob7M
 LLTXRq2GMU4f0W/cM72ULSoLcaUwr5ZfLazrkNh8JQD32KhQLseCIxI9I7Lz+r5QgL7q
 OIZb8ZhkPIIlBLxz9BC916kzlfPWslZ+ahhWJS42qp05XHZuiyCUdsktlQLD7FZ6whV5
 sMO3OFJAQjvvsRTFnGwn5oI8tiDcR09SQw1Adsq9cYNUmWI0VRVIxMhZ50U90Sp62fie
 ohuA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793801254; x=1794406054; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SaAZs9B+UXOHTaRDcZeWz12aXXxWAqfcjHVOwU/3B4c=;
 b=NrAZImVu4kh3GlCXEVi4PPeYuNORQgNt/Oj2g3koDQaKVH848xL/0NuDNQ5mwzJiHR
 TgL1OVQJfBFlXCMFs02oyDkzqO8WjWSwV3iKJa0h3ZVkAyFRqu59LCYeBN/RlEYQRraN
 E/S29eeyI1R9pWhKGLMPEIp3ogZaorMp0aLMB6ZZ18oyDe8HGZ5znVSEdPDFFg1z67EA
 Nd09rfuJmRDChEl6lNIK3nAbyMS9uJ5sntsmsCT213CUI4Kg+Rb1ovkY6KAH1Ft9IYxM
 1JMlC+t1ytXspQ6m5zPDvYlbnyN7ZBrpJ3HwvU57tTGOfPgWFQoq06WYQIM0s8R94OZE
 OBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793801254; x=1794406054;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SaAZs9B+UXOHTaRDcZeWz12aXXxWAqfcjHVOwU/3B4c=;
 b=T5x9sRlpYjKfj8tUP8572bGKVjCXROfSquI+HKdgzfWLTu7tejgTgc0mZFsWOi/rQ9
 j37uKbNVoLE5Ws9/4kgNBv2IPp7SCjcHbb30h5RzMrCnrv1yeIwYC8t7KAgGXWmW+YxT
 Gb2vF9rq0XY065zjRCrbPAGV2PyxfpEuqYNulFsuUQVVi54ndrn2E3g8XI077JTv4dyC
 ljJBRpo9vKV43LUikkVcbR51nvRa1Yl6q9mVG6e4gACMyV3URmv4q4V0wl69L5vyINy1
 SxdiZK9lUBO8SR2e9y3TZVeL3cVgoagLskDXg7wSNVOhKp+XQfA7KwwRJstB03Kkh8/S
 8wYg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxeL2TD0mgtlnfOfPP+dZAqEbmTe8u8HdcDSeL4wQ9hxqtP0NG/fYGsrH5pI5gt2GkObMWTody5@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+haUx3IU3mj+2ejwCUb4pKhqj1XPf5VQgpJAC2lzxwcqYH8VK8
 bCzePTgd1VCqG/hmbRToXfF1AQEXetX3GSAEBkMaiwruVEw4siB63PLtARqpl9GG/V6MxkCFN6S
 O5Ev3+0AN1Fve9iA5VQwzpUie7tM/ep0=
X-Gm-Gg: AYBFou0iARb717HkDYfcD4iivQxl6mz5WL74/zTR87mrvGtqr2mDFE180a2aG5gDxoS
 oORnL3fMrAojTCyIm+zanpyHqR97vxs/SyhIkwTJizduxVCWGqo9aATq8zMoNdI4BXlnRT3hsx0
 wwi4HDNwhsKnjVnIpD5k3LW1ZJwFt4MlFFAEmKF3ksKCO3dL5D0pusVJ08vcoPSj8cgGra1gt7e
 R4H4QvSCS0xpC9BNIrFyi3YkO5YA56pjaM8pU6R6Ek767yIFwkiHUTjdjaDK59yCo2wZ8xJQAxH
 qLJhsGLQGSS5H18tVU0ex15T9KDOWHqoJau3Y+72W9MxvR/J7hUZ2uvJHZCgG+cAXvtelDNgkGZ
 AKtkJ2jTMhnuLx+o9BeCapHh3cQhsg9fkCgO9e1mH7UpQoUenIdA/vjMxyiuvhP+QgaQPaAhz+x
 /ie/gzjdGwTIG2ud+2nRBFeSA=
X-Received: by 2002:a05:7022:7e0c:b0:165:be2f:c56e with SMTP id
 a92af1059eb24-1ac5b7dcb2bmr39911852c88.2.1793801253717; Wed, 04 Nov 2026
 06:07:33 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CADnq5_NCB6ur05ZvP0fe9hsgLHM0=y_Wx31G4vkpKH+F7yZ74g@mail.gmail.com>
 <20261103150057.1227-1-atharvatiwarilinuxdev@gmail.com>
 <CADnq5_N-sobVK3qitqABjqMv2HMyGNdxX0XMXa4TZzVnMv8MLA@mail.gmail.com>
 <20261104125241.39209-1-ed@charmerstraining.com>
In-Reply-To: <20261104125241.39209-1-ed@charmerstraining.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Nov 2026 09:07:22 -0500
X-Gm-Features: AclHuK_mWOgAzCBAJQN1CbtCJxv3h38jD-baiSMS3zvcmQeJZG5v5X7OZiVyOK0
Message-ID: <CADnq5_N0RFH=n05T_zKSApGB+3o29Nx5rNMOZt5kWzZWxpgsrA@mail.gmail.com>
Subject: Re: [PATCH v4] drm/amd/pm: defer UCLK DPM on selected Apple Navi GPUs
To: Ed Schofield <ed@charmerstraining.com>
Cc: atharvatiwarilinuxdev@gmail.com, dev@deq.rocks, aditya.garg@linux.dev, 
 alexander.deucher@amd.com, kenneth.feng@amd.com, christian.koenig@amd.com, 
 airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 4, 2026 at 7:52=E2=80=AFAM Ed Schofield <ed@charmerstraining.co=
m> wrote:
>
> Hi Alex, hi Atharva, hi all,
>
> Alex, I'd like to withdraw my September v4 submission. I also don't suppo=
rt
> applying v5 as posted or the simplified patch you attached later in this
> thread. Please remove my Co-developed-by and Signed-off-by tags from both
> versions. I no longer think deferring UCLK is the right approach for the =
iMacs.
>
> I also excluded the MacBookPro16,1 (020f) from v4 deliberately because a =
tester
> found that with deferred UCLK it still hung after login, as it does witho=
ut the
> patch [1], which seems to fit Andr=C3=A9's PPTable diagnosis.
>
> Since then, I've been working with Atharva to get his native-5K iMac supp=
ort
> upstream. His patch initializes the display before the SMU, which has als=
o
> prevented the boot failures without deferring UCLK. On my iMac20,1 (0218)=
, 13
> of 20 warm boots failed with the upstream order; with display first, all =
40
> boots passed [4]. Another tester reported one warm and one cold boot, bot=
h
> successful, on a 0219 [2]. On an iMac20,2 (021a), changing only the
> initialization order improved warm boot success from 11 out of 20 to 100 =
out of
> 100 [3]. His patch only applies to the iMac20,1 and iMac20,2, so it doesn=
't fix
> the 16,1 either.
>
> I don't think the iMacs and the MacBookPro16,1 have the same problem. The
> iMacs fail while amdgpu is loading: the SMU stops responding to
> EnableAllSmuFeatures (message 6), and the probe fails with -62. With the
> display initialized first, the same message succeeds with UCLK included,
> and the iMac boots normally. The 16,1 loads amdgpu without errors and han=
gs
> later, after login, with or without deferred UCLK [1]. So deferring UCLK
> seems to help the iMacs only because it moves the enable after display
> init, and it doesn't help the MacBookPro16,1.
>
> I have prepared a draft patch with Atharva as author and me as co-develop=
er,
> incorporating his review feedback. It combines display-first initializati=
on and
> native 5120x2880 support through two tiled connectors with suspend/resume=
 and
> display power-management changes. The current draft is here:
>
> https://github.com/edschofield/linux-t2-patches/blob/7273823e425200e9f371=
e9272e02ebf9abb6f1c2/7003-amdgpu-add-support-for-5K.patch
>
> This has passed some initial automated testing on my iMac20,1 but I need =
to do
> more testing and get Atharva's final review and sign-off.

There are already patches on the list to support the 5K Macs:
https://lists.freedesktop.org/archives/dri-devel/2026-November/610011.html

Alex

>
> Alex, thanks for following up on the boot issue and checking with the Win=
dows
> team.
>
> Best regards,
> Ed
>
> [1] https://github.com/t2linux/linux-t2-patches/pull/61#issuecomment-5646=
139127
> [2] https://github.com/t2linux/wiki/issues/743#issuecomment-6083265811
> [3] https://github.com/t2linux/wiki/issues/743#issuecomment-6131809640
> [4] https://github.com/t2linux/wiki/issues/743#issuecomment-6163146905
