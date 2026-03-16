Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D841BF53D82
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 17:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E45210E31D;
	Mon, 16 Mar 2026 17:58:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dnc5nmC8";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 011D710E2CB
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 17:58:05 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-124713e4244so315544c88.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 10:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773683885; cv=none;
 d=google.com; s=arc-20240605;
 b=YRMOZ3hjaNnGkUOJncC2QObkdDi9hJ6s2yx7YdRSK9xf8f93JIlKe7fwFI/Eg9Od9f
 b5P5n+ohEg0oyL5QPO+ItWtTynKgUbanUJrez5Rj+SBeH9DtxXEdwS1zchpKdmWJwMrT
 jfRVhr+SGVTpBLc0TXm+mPaGuEyhCk253VRuBIdQjOusQlyQoyLXEgdwfoRTp+Fca85w
 s4BYCZcz0GZ0MTlx2WaPE0plKxr9WmMas72mm6MndmPlZHXi1GL4ffYoXnIDOSwdODY5
 s3Vfskhr6zByLGt6mpxbnizrRk4Ng1RWpSVFcq1ovbeVKYu7ewPOQSPwZmocVPHg2RiF
 THCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QnX/rbnq/WMXiijeU6G6GjMRX+rxxEgeT+5NRknO5R8=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=ZPtnYUSIAK8urXp4a6s+JUtkOQQfcFzLnwncQD2XrxSPu6z5uqBYICp7lvNmyRV0cf
 hb3pG86Y3+rThxTvR0ILKQrax3MGdJCZv3UOANhAEBfCaDiJSnMKnuRNLYPAG9SWpdQt
 GSAPToaNxvez3LBkgBqvRQpitXB+pZuFhfSu94035pPEqb7p59d6OKcMFU+zblvYUZJ+
 wDKo58k2g0vQlCwKw3HFzilT8kYk3RjXqwddn6A0bwlhQIKOHaFB49fA8n9QEp78tnOa
 s3Rdwfe27w0dr+4HNss0Vmwq7elu9RD/PRDXp1apxsHc0hOw7GdS+BqLtMh5rjfrCYoR
 uYyA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773683885; x=1774288685; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QnX/rbnq/WMXiijeU6G6GjMRX+rxxEgeT+5NRknO5R8=;
 b=dnc5nmC8GB+Q17ZwUZ8dcdX3WBIdVwwbMGQ3DMSO0++jDZcGOne9GxPA+sbpBs/nC6
 N2/I6LrpoHWXzXXk8WqJg7F9lOV5CDUDny/qr1zgwXO4h+2c7pNMr7tIOHEe6WLmAlkZ
 xf3Fa5OeFRF2OGG0q3dZaui3wA1QCCIuY08o8nBqy2va4rCg0ZTVZnePm7595LT96PT6
 ruF2KlsUPoD5Vq6TVolo8Y+L3u7rdDc5zkCAiLvsrK+VPWbdQH0yKnUQUIuEaN3ZPAu9
 1FvnKayr938dD4Q4Hlnz6k6vbf8UFOATno//ed7s4YJACu7eNu+mm90sQ7latfEcI83Y
 1H5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773683885; x=1774288685;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QnX/rbnq/WMXiijeU6G6GjMRX+rxxEgeT+5NRknO5R8=;
 b=gE6Tz0eMFtoALdju+liIudIjKa77BreH5fl1jqttrekw/EnRpGrU7oquSB68MiG25F
 jvfTNw48OqqFG6OJE8nYoEq268BjaJoTR90GgOOGF972mAhj5qGVOYRU7s2vsI/6CDgH
 DGu0VY9+d7UUBpeVDf2sZK+a7lANJBVKxLJbG9eQi9+b/9by0oUQRYHJIyvF6x8sCRiG
 hUymPB0TxYCg7ASOschB251KK70P3BUJr1yA7oT+el9XfDi1nPIblwJP0XyHrtnOG9vz
 E40vYL96q1wlXpYb10rIYbdFMztcNJz1OZC88l6tyNoKICrFTgrZbxw3rJrlnyVAZCbn
 obQA==
X-Gm-Message-State: AOJu0YwepjySuCI9R+IYYIfqbT8xBqm3Rz6VBpXGDSBAH3gXQt5PTCWw
 SpoeFKMtO4Rmk4u70/w0vqVIxlSAxzzvpWU8tb0d7zCnL4fDDlrsTwsqyzswkSdXwdKQy0nKrrv
 YLzk2eyU2lJ2OoWeo6HguZxWrSL85Nv6TPw==
X-Gm-Gg: ATEYQzyt+J++VratnKTKts24zID1cLJcLpFKDK1Ga/85ARG6QJhnfmvVklWF9GvfOZ8
 0Capn4C5fXZAsHTfVkWgvcIDjLYvKqdv0ZMZcRGN2RFKcoOUb019vkvzfV4cU6sFsJgTZQijJ8p
 WkUsJtSWZaxNwyH3dbdNmu+nHsd5lEfjMW6NJYmjpEhwSMvsOrJH8u0XJqeg792xwK7otV/5hP/
 N3vepbJsdKm36aBwvtNzNfhVMW+q9x+rp9ElR9M3qx3qSQMcG13xVlUgcvLkFhHC6BaydiG4JQE
 1NlXUj1Qbj7R8ziHzhgafIvPuCoSTmJJGVacENhKGuoOUHeN2JDxsFPXP/BPdJTLzE3GSw==
X-Received: by 2002:a05:7022:78f:b0:119:e56b:c3f3 with SMTP id
 a92af1059eb24-128f3dd3a3emr2941481c88.3.1773683885159; Mon, 16 Mar 2026
 10:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260306172417.325169-1-alexander.deucher@amd.com>
In-Reply-To: <20260306172417.325169-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Mar 2026 13:57:53 -0400
X-Gm-Features: AaiRm53EIy7jMXnVjdjlUtvjIzz5GoSoC99nSCEsNkZhPqwmYehDrvTeS9dzHos
Message-ID: <CADnq5_MdknQBiNsEDuc0HLOCS7i8qnf0jhWxidq_LNqVZxf=Kg@mail.gmail.com>
Subject: Re: [PATCH 1/9] drm/amdgpu/si_dma: set SEM_WAIT_FAIL_TIMER_CNTL to a
 non-0 value
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

Ping on this series.

Alex

On Fri, Mar 6, 2026 at 12:34=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> 0 waits forever.  We don't actually use the HW semaphore anymore,
> but if someone uses the packet, set a time out value so we
> eventually time out and avoid a potential queue or GPU reset.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/si_dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/am=
dgpu/si_dma.c
> index 3e58feb2d5e4f..7cf9dfbf11196 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> @@ -149,7 +149,7 @@ static int si_dma_start(struct amdgpu_device *adev)
>                 ring =3D &adev->sdma.instance[i].ring;
>
>                 WREG32(mmDMA_SEM_INCOMPLETE_TIMER_CNTL + sdma_offsets[i],=
 0);
> -               WREG32(mmDMA_SEM_WAIT_FAIL_TIMER_CNTL + sdma_offsets[i], =
0);
> +               WREG32(mmDMA_SEM_WAIT_FAIL_TIMER_CNTL + sdma_offsets[i], =
10);
>
>                 /* Set ring buffer size in dwords */
>                 rb_bufsz =3D order_base_2(ring->ring_size / 4);
> --
> 2.53.0
>
