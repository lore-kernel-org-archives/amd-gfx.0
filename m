Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEB5606A31B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UJ6HPdNb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB79110FB6D;
	Wed,  4 Nov 2026 11:12:37 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0A2610F855
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 20:59:20 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so29859f8f.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2026 12:59:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793739559; cv=none;
 d=google.com; s=arc-20260327;
 b=BALvLtd/mbOu06EjGGCs+RvD8N1y+13zyqsu9sjIxniDTxcY21BON6m6CN5sgUGO2N
 sFMJHSlOkSosDhqbc6ih5oFVDNX5xBscn8z3hPpBFWdISA0NYlQ2k4hGzKTVpJkr8qtP
 l/P8+mN2D6uAJsyY9jh0Fdui2k4qbJKxKjG8Ru19T/3DvgQqBn32CRjkxg2l+j2v+UBy
 KnfpIKkh1gnISrfCnWELIeZNZcQYA8furWW0QkQFvTCaqRHhWcW3TdRJGlWOjkYuGm2U
 OLUGDjhqhtksdFpq9aRnuLBscNrwqC/QtBAps2+tvRQp6NEecq4Qhur7oDcvIWeRbLw5
 aniQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=N522AsLlTU0HGBzik0UilBrcnusjUUdJmnwssk6MniI=;
 fh=hoX8jkQYxnewEsTlA5OwlgYO0pV3JT5/SowlRjlME9w=;
 b=ns5zAC4pwQIMzxZYYWfMT8/b+lmUklOSVn0a2WIvrwSItVFiCM6hxouYOfEbIZKCDp
 375cBvWd/95zNrE3z8cgWrMCmwx5aSuSNmEYWOkgtCYBGF2aWf8aAcd3a+mQZpDwuD2w
 fzFTfP9xEGnO+XeBN28S7q8oH4Fl+0/DJ/lo77Q6bzsWIKcLh058ZYLdq4/inKtM/u/p
 3kLt0WfGLAFT/fD3U9NHeps6lzUXXJwygqg7XQnd1gA0F0WdktVLxxDkg74z0xijWe0X
 KeArpwhkM/B3lQnHDS+w1ygoo0B0VQaHdlWnpnTkW8WHFQMtVZBH+INq1BBcJmFk9KYj
 KKOQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793739559; x=1794344359; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N522AsLlTU0HGBzik0UilBrcnusjUUdJmnwssk6MniI=;
 b=UJ6HPdNbdwg0HQSq+lySKJr2HTV7+KOAAss2l7NgX8CG/sJBtkPnmUN4RkYHq9Sdzz
 6VQnJRH9aU7okO/Nze76Iomap2HkQHMu+b4d0iKs13bVUtz40MWh7YIUcxDE9ws97Pm7
 HVTFc3wbcOcIhPCOfNez47UbMAU81qbRWet2+mmnORyL+Ao0dpXWmHMhTMnx7MNz3KFD
 g3yR8Z3tOy4gMNHz9g3lgn8lQjghFsLz+bG+/1BW8/Ow9EkCFT15SAaK9E8saF2iZgu7
 cj78UjXKhr0INeoBXNvj08HcarAJC85xYMAG6/wfm8+622aq8sUQUz7pkJFbTV/JXGYc
 7ulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793739559; x=1794344359;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N522AsLlTU0HGBzik0UilBrcnusjUUdJmnwssk6MniI=;
 b=LVuH3R3CGpOqNMgcas7kyqqtK0b9LZ06fxoHPYnoEUhbj/EwFECw1dFhG1nMwjVY8G
 ZJZjf2xPQgdTHWbYA5RrNetluRmvbsdbVxTdC3IzdvmpUQE1hcEpc2hGYXbGwiKXKGPH
 2HQtGESd7Wf+kfP/iEco2L+nD0K8cscmHg+Q1NECeqdZfFN3/60D8ZW4XzJFKtR+az9S
 1U+dt4nmFqbj23SDo2whpFlTv8kppkkNnVwvel2EdtEePDII8lEsxoxboYTWjNR/YaiZ
 36sTwLKHUnZDB05lQO1kXalHWNP5aBQwFowhv712owllUldbsVZxt8fBKPLxavILVLJi
 ZBWA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGWYsJRJWU6kZgPdiDnxu5EFiHEchUWRDFEnmDv7wx3RhIDfa78lRLyM6pwNbczn5c8WIS/iU2@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+AmEDhG/V/m2+pthz2qgfntHPhr7j+a0Bs0ue4xsdcdNbGKJSz
 JerqZA+3+rte18YmlnTY+Wp3c2odtXCRbAcNybo05btklZQZJNR1TaVV6BFC/H1RQ9DNHgFfDvx
 Dg0AHLArpZgn1dMDBlZBoR9h7kREbjVM=
X-Gm-Gg: AYBFou3zfonJeFLClAloM6L3dBIGOfZwFz4bf4qkj8mulqteDgAYlByCXEYyDGMt271
 v+KVziFQVSmR5LrOSq+kVE64i3R68YFz7kS/Iu3b1TyHWNzDCv2Q89EenIJ+N4yFe4W6I4qSjmK
 roHZMkn9tPCdpA5Sc9P2nRf3ZzIIc80GymzIN00wJ/9pVz98YX7q1MyZ1s4zPjasqjxx6MxqHf9
 qjgo/Qzm70u18jsZs79M0m4dU/Gw+5hBjti7CJB4ELxlcPLLMZk8OkWzGfaMXUoXErG68QRaXAZ
 PORxqg+1FbMLezDqW0f8TQDwkUYDzV5wpdOSEXFv6lB0Aiy+FG5LZPTt6dO0BIvD7jcE+vkTJYd
 537ibPb8vUH0BUgsqATgyJ7bzCxAe4dEfUlFFrZc=
X-Received: by 2002:a05:6000:1449:b0:48d:ff71:dd9d with SMTP id
 ffacd0b85a97d-48e6e2ef786mr30220280f8f.23.1793739558923; Tue, 03 Nov 2026
 12:59:18 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAGxFSwnBDM93ouN6Aq2ppm5zF1h19XE6NJ92NT2UEhMP1P4xEg@mail.gmail.com>
 <CADnq5_PyctWJK2k4-CutYFNPkuMprmZE98d2JjodBQkTLGJhDA@mail.gmail.com>
In-Reply-To: <CADnq5_PyctWJK2k4-CutYFNPkuMprmZE98d2JjodBQkTLGJhDA@mail.gmail.com>
From: Arnaud BERTRAND <arnaud078@gmail.com>
Date: Tue, 3 Nov 2026 21:59:06 +0100
X-Gm-Features: AclHuK9LGpsbyCsaaCaEXiY3-KA_CdLHeIgy5ZFJMBas5Xa9tgkDNg4pPpu0HGs
Message-ID: <CAGxFSw=PgG+hewz5eNcDDma57+oJE2qd25mZByyJ+4dFhsGpYw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: add firmware file fallback for APU VBIOS
 discovery
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Oz Tiram <oz@shift-computing.de>, airlied@gmail.com,
 alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 simona@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 04 Nov 2026 11:12:26 +0000
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> On Mon. Nov  2. 2026 at 14:58, Alex Deucher <alexdeucher@gmail.com> wrote=
 :
>
> >On Mon, Nov 2, 2026 at 3:07=E2=80=AFAM Arnaud BERTRAND <arnaud078@gmail.=
com> wrote:
> >
> > Hello,
> >
> > I have two dGPUs : a Radeon RX 6800
> > XT and a Radeon RX 6800. They both report the same PCI identity
> > 1002:73bf and each has a different VBIOS.
> > I hit the same VFCT bus-number mismatch on 7.2.10, but with a different
> > outcome: on my machine the device-identity fallback actively breaks the=
 second
> > dGPU.
> > I patched my kernel to remove the fallback, but I would like to have a
> > better solution for my use case.
> > Would it be possible to apply the patch only to APUs ? That would keep
> > Oz's APU case working but a dGPU with a stale bus number would fall
> > through to its own ROM, which is the source that is
> > guaranteed to match the card in the slot.
> > I can provide more details if needed, I am out of my depth here.
>
> Should be fixed with this patch series:
> https://patchwork.freedesktop.org/series/176969/
This patch series applied on top of kernel 7.3.0 indeed fixed the
issue for me. Thanks Alex and Mario for the swift answers.
>
> Alex
>
> > Thanks
> > Arnaud
