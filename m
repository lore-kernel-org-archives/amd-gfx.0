Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7E3C5DF81
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 21:23:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB93310E183;
	Mon, 24 Aug 2026 21:23:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KAyM4/xg";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CE1B10E183
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 21:23:50 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-38f57e312ecso523964a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 14:23:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787606630; cv=none;
 d=google.com; s=arc-20260327;
 b=smLxgiq7Qw+GYVggjeUJ+HcB8B3CcYRENqoBuxAKjsHuJzeQMUFbpKkngUpcr20w8W
 U51dMJf+xM5tu2c96L1i/2lwZmHQApA249eqKnRln5eHfaRASe5Gb11DqHaX34tapO9/
 ymrDotnM8FAs7leOxYWLvn0Orngj+iOT2tqhXDXNHIPW1TwwWWLchBGKd+Qzk5uXjWT0
 tWsxitKEJZYxXwmY4ucaRy66KhRv+KvxDZvh1Q9l5dGKYAEEIERLVRFEtDvqRMa9tQOW
 ki3fpSFCnmYG+WJhxQ5dtPnqgXo/VXXcZgmOjSXO5nIV+mEkPP08W6oxT7Ryz3f3sg7s
 Agig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GQPM3BcEbnbUyx1Kr07tnYaihHgFOnTV8eErtuLM0TU=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=PpkvNttKE3nr3QTy57GgUR0/u96B3zc5V9gvslvKiwwZM/l6lyvawRluBzwjXfnnzv
 y1OBDfbJAY8NAhhSDc0J1wNtausZFVJeIUpiEbScOO+Uiwc5eNdVB3XH7RNpmZwTwwnv
 m611CHp1DLQzmxT2ZUwEngCn8fRCoXzLBqRu1EekLy4Xfdfr7DzxJ3/9bE8Dz9vMY/by
 AAROxxQWfFdxLB+RjsGCGz3Roa2EiSvAyV0HJapnv5ZwMmVIF+8cDXW5ToNjtUzsKdw9
 Y7KHDh0Xad6Ln8mmfVJ7fNnGi0v3XyrSkXJ3Mwhim6LoLYtgF1nXrvqiMBrwzYTrLonf
 k77w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787606630; x=1788211430; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GQPM3BcEbnbUyx1Kr07tnYaihHgFOnTV8eErtuLM0TU=;
 b=KAyM4/xgMQdbtSrl1Km/GM2LZfrvb5Ne34ZukGn1Ocjhu9Q9xqu2NSNhcvXC8Xrvnj
 Qch98wQ64UJGcBJL5q7bcbGthLLbC+XAUExDLmjslUMFX0FqhbOgtOB7MYL0n0ZEo882
 jkmOB/F4P/a2zv/pp7PkPFXi6ILq3DVHuWqqmuZlCmHJsvMZVMqa6XPCFt35xEZGSeso
 AN1ByJAVZZO9/cVysW/B1R6Ye5iHE7dIA17WbwyVFub/h2qhDN7RvX9AAxLVoEAHDlia
 aTHMNKToyWb7IVDwq/9ZJJNzZUazEUZvusLJobXybSmzreMh3Txmh2ddMOLJqS1g17H/
 5vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787606630; x=1788211430;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GQPM3BcEbnbUyx1Kr07tnYaihHgFOnTV8eErtuLM0TU=;
 b=k3zqhoa+qCq4CPmiF1eYZmPz1BJlz76xJYvV4T1F60iVIDYXDbizfMtLj0p8Px22Wo
 qZpb9nm+bVRoNTKHaJzEET33slcP/dft0DanDQv9lyEzgeIf096TaWQ4uMulVAtu652C
 M/3+wkR2ceL5HuVM9De32A6CW7BKwEqTxhm41HHi9yeXDFhKM+3DZ00bgsHYX2A7iRZp
 fkoo+/tFcNtJKbdumsGbXaLY2pDOkyIppp7GmrbDO024+42Sd9bXEiWPZZd7QoW2kzow
 KiU3Vfy7fRAzB6Q7j7mCq23bFlVbQ8ev6DMKcdMhc7mgDUEK9QSuW2OPOLndH9ZXz/K9
 /d9Q==
X-Gm-Message-State: AFuF++k7qroCYiOf3gawZRbFflSL1ufCCTWJg3jiW0ywkw/Hzkvis2sV
 BTUVaPEqizGfB4TGC1QX6p85EhgyKIKNvw3EmPG4Qn3uPJWkgN2pEF6vSNqxdqclKLysB9thtVk
 K5+guDR9hbngY/KVcmX6Y7rf1ggTVXggPcw==
X-Gm-Gg: AR+sD10+i76grj4Aq0w/+bjeZTUvWcBE/DWFUdKWm/oN23xV8SHJgXQgTetBmqOqkDh
 CTW9RBmZERcmLQmuOKuy9li2j1CQLpYV2th0n5hbOVB+RTlfWzuHAXCv6hd1TuBq/z80ICpEGhz
 CK5fIXj8ZBgKDwalpdBAfyXHR0V1B66rF/gZmz+dBBVbsBqUhAJv7+IX76wtcCDVFzftHU0psCi
 OVD8vO3H8ostw4qil38hGrPfgozy41TI8i3RcVX0RdO+yJUQWUhYxCUHzRX26LhHVnZ9998BZQO
 bDtoMzCZTTDgU/mVMTcLvh7YetTYnQqNEHu/z+//mh1vh/9KupyZKpylCu4fYKjaXca+94W8c7V
 h91uqvc10xf+9R/4/7cDAz0Y7uDroqPA=
X-Received: by 2002:a17:90b:4c48:b0:36d:b30b:14ed with SMTP id
 98e67ed59e1d1-395c3514580mr24269968a91.2.1787606629943; Mon, 24 Aug 2026
 14:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260820140433.2875442-1-alexander.deucher@amd.com>
In-Reply-To: <20260820140433.2875442-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Aug 2026 17:23:38 -0400
X-Gm-Features: AcwNN1VO4qhrfg2wzbZXqKRT48yAcYtvQW7a8bFpHMWseBBPJxcJG_SgyCW0Wzw
Message-ID: <CADnq5_PoahpM1GB-fum5rYgzrS2sA=bfpdWjb3m=iutxtX9J3A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx8: only apply compute quantums to KCQs
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

Ping?

On Thu, Aug 20, 2026 at 10:10=E2=80=AFAM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> Don't apply to KIQ.  Seems to cause problems on KIQ
> on some ARM platforms.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5658
> Fixes: 91cf34bc5a55 ("drm/amdgpu/gfx8: align mqd settings with KFD")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index f7c2b149acd0a..4241453e0ec8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -4546,9 +4546,11 @@ static int gfx_v8_0_mqd_init(struct amdgpu_ring *r=
ing)
>         /* set static priority for a queue/ring */
>         gfx_v8_0_mqd_set_priority(ring, mqd);
>         tmp =3D RREG32(mmCP_HQD_QUANTUM);
> -       tmp =3D REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_EN, 1);
> -       tmp =3D REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
> -       tmp =3D REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 10);
> +       if (ring !=3D &adev->gfx.kiq[0].ring) {
> +               tmp =3D REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_EN, 1)=
;
> +               tmp =3D REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE,=
 1);
> +               tmp =3D REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATI=
ON, 10);
> +       }
>         mqd->cp_hqd_quantum =3D tmp;
>
>         /* map_queues packet doesn't need activate the queue,
> --
> 2.55.0
>
