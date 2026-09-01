Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CC3C61DD3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 13:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95DE910E40E;
	Tue,  1 Sep 2026 13:25:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TA3pyXg1";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1910410ECE6
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 13:25:53 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-396555b8c7cso652310a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Sep 2026 06:25:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788269152; cv=none;
 d=google.com; s=arc-20260327;
 b=nI+eLdt1bJTo2F+6VhUK2ptZLxdWiLrrYADx4c4aMs1Pk1o2e9d5mGHzLDQJ9TYvAZ
 3kPxN+qzp7BaqZ9f2E7W4iiklcVXybVHl4alz0VCrh9buvbcmD2XElw8vdDoPqYMkubo
 o4NGcPeqZFUe918u0woHHWUcjZxgaeCIezx2GI55hphX+p8okKTYdRFgD+uihjCiZSU1
 utuo81iIjPXrbq4ENdQdeLe5jZqa0A30409NvXllqdNFrPm5Y70eCbF7FISojz1ZZ6nj
 bBcNMdL5M5tpUwLY3qHVxBKcNEc3hzhpfghTY/jd3E0do8hr121IvZFcWQksPjECPy1m
 PN8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YWC5NnD2NQWmrLONTcoZgi4vy1DDC9I/SqW+WYO6SHI=;
 fh=NIPjG6fhTbNhxKkXjl6V0JgR+4Un45nuwGzQBbIZw90=;
 b=URKwnBfsO0IRzVnuBzalg70mNP3c2DjQFJxwBFtesZNY1FBM5Yj5fanSDkrGdN+PMB
 YXye1/RE+Zw6dVeOtWuTcKVBvIL+zzIyRuBXxeAI9rV7bNnBhrx7FjpTW7ClXqTyJs9O
 NmbZria/KsQzqp5NqK6gOEX+5+nlB6wIEdnefrsBkPAuYsvCX+ENWTIKtR5IZntNZ68y
 nHhw4op38qcm0gn0aN+zpG+W+9huw/YFol6tx1fiQJ4XStUkXt9Rm8GFzuEjM6cmNmIJ
 KeqhMNk8MeXFPbp0v02kZLh3XO3rJwHMBpUYTsUN57sUHk8+5rKusF+qL0gzYqc/BNyA
 T2WA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788269152; x=1788873952; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YWC5NnD2NQWmrLONTcoZgi4vy1DDC9I/SqW+WYO6SHI=;
 b=TA3pyXg1H5mt86BekY9KLz8GM2BEJu+22h67n4qt0Rq9tTKmW6u8P9BGv6YOEhEf5I
 qVhox/ya1qPYHNmeUmh9G4JqmptvfPPx2IbMxlO1k8jro3oxmu9FCd6ZwOvygtULwbDf
 UCvFblzxc0CF+fnDDVfGI/fTl5g71iXmMrjb4QS9XepSmuuQbqIOlIc9+pz4qLEfHJaS
 CstnPys44Ak9BWyntwhASXmCAAq52VL82rAB9rJYvhu1Yadmq3eYwRgclXBh5xWgfIwA
 01D/NZ41tSccVW33DBhJfVqH7YiuVWnqK0NCdfZ2r5ERUW2cyiDRjIapwVMUWEFrNKSc
 AHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788269152; x=1788873952;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YWC5NnD2NQWmrLONTcoZgi4vy1DDC9I/SqW+WYO6SHI=;
 b=lXdtQipOn/+gXPKiG3wCByY50Tca6A+EMDVMWPF49B7yenfOulMAyMbk+OtDqi//qR
 GmshTU7+aiE6we1QbIRehQFJhPigx7je1GyF+F6qk1uNC5A/mITHM5UflYKeUSYyYstH
 1cuptvClzRMHfkQwiEqMVhoizey+PIAwiA0vBoxvG7GE55LKUuCxP+UPiagqiV1o1NXV
 sc+Mq+AFeeTnmgde90QCNf1LFzfKHmNTEf8Z5jnukCBR8JPs2+nWIO8CuJQq7vzqbOxE
 HwepzZ9KRinqYS4r6M68Vtgruai3oaGdkk+08cYpq5owyQiQ7MSXWaEieGm/TlhpMGJc
 oxoQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmrf0E67S6ag0BrHtDAt2SzWStCZtvzZSvN6mM1yeoSk0P+j8fLKiUSYkqIN5ytQo5gKCQy4Jd@lists.freedesktop.org
X-Gm-Message-State: AFuF++naNOvdCpGuSjzq/cwjOXA4fm1gjSNebXWlqjbkbzwKjJfd7muy
 vOs1yHdcYAub+HcSicGYEEV31r6tJPVScecD3Cs5r8k00YPEL44lUr6KE/O/RZulj32LzIKnH8G
 8TAenf7ZseR4IVqcP9qe3EYfeQhNM5uw=
X-Gm-Gg: AYBFou3FAr7bMaG5+fUqkIrldGsZDqr4ty8IkfTH/ao2DXopnAIJgKkJ/OIqP8c4jGf
 tC34XZNCGO9yLZoe3MZKQCMphBxprcTldNnAo62F4qX1va0ZaJJYadRoCCTs9Fe9xYAYizG3v+k
 oQYB/0WyI042Hxf4WB5pwhfhYWLBwUXxjYPHvdd+iCbQ7xYVrkkSEBH4c8WJDiQEwcP85SVUM6e
 EyWVBMTUzZW2os93aIOmoyPjqetNKVGMySYINIXxky2aw6B87VAj3C/L+RCDCgeIBV31lcXy2Wh
 EThy0pRqo62BoEEOHdU+I+TvDH0hMnQ47fDwc16ioVJ/WbI0i9/iUaMN1tBhMqmiS3oM+sGztpO
 U6w1M6Qeaz15U1eZVVoPFoNr0RsocYC8=
X-Received: by 2002:a17:90b:48c7:b0:398:bac7:72d0 with SMTP id
 98e67ed59e1d1-398bac79956mr20107575a91.5.1788269152383; Tue, 01 Sep 2026
 06:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260901113053.1836346-1-sunil.khatri@amd.com>
In-Reply-To: <20260901113053.1836346-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Sep 2026 09:25:40 -0400
X-Gm-Features: AcwNN1U9ZWqi-anzc8N-Pc9iE-EmOR4IJm2zX4yb5uPx4sSija8TrtdrksV3v5Y
Message-ID: <CADnq5_M5wnszVUXYYscpjhqJgxUN+oS8ptrdu-jihdG-8dDVwA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/userq: dont overwrite the error of subsequent
 map call
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Tue, Sep 1, 2026 at 7:31=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com> =
wrote:
>
> If a queue fails to map that we need to return the error code back
> to the caller and not overwrite with a success specifically.
>
> Accumulate the failure and return that.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index f16af852725a..9dc937c22b05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1562,7 +1562,7 @@ int amdgpu_userq_post_reset(struct amdgpu_device *a=
dev, bool vram_lost)
>         struct amdgpu_usermode_queue *queue;
>         const struct amdgpu_userq_funcs *userq_funcs;
>         unsigned long queue_id;
> -       int r =3D 0;
> +       int ret =3D 0, r;
>
>         xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
>                 if (queue->state =3D=3D AMDGPU_USERQ_STATE_HUNG && !vram_=
lost) {
> @@ -1573,6 +1573,7 @@ int amdgpu_userq_post_reset(struct amdgpu_device *a=
dev, bool vram_lost)
>                         r =3D userq_funcs->map(queue);
>                         if (r) {
>                                 dev_err(adev->dev, "Failed to remap queue=
 %ld\n", queue_id);
> +                               ret =3D r;
>                                 continue;
>                         }
>                         trace_amdgpu_userq_state_changed(queue, AMDGPU_US=
ERQ_STATE_MAPPED);
> @@ -1580,5 +1581,5 @@ int amdgpu_userq_post_reset(struct amdgpu_device *a=
dev, bool vram_lost)
>                 }
>         }
>
> -       return r;
> +       return ret;
>  }
> --
> 2.34.1
>
