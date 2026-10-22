Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CEB606A328
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bGkzQW16
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C08D11279A;
	Thu, 22 Oct 2026 15:54:01 +0000 (UTC)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com
 [209.85.217.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BAE411279A
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 15:53:54 +0000 (UTC)
Received: by mail-vs1-f53.google.com with SMTP id
 ada2fe7eead31-7cc228078a1so61721137.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:53:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792684433; cv=none;
 d=google.com; s=arc-20260327;
 b=UD4zScCAXS/jyy+dogghQzyAa0uAsDSVRVzDkv2AO72B5T6kI84AsL+/AzMtZm+5Wt
 ftu5AtuOFda+XYnLpLNQ+tnu+bkgylpoyG3I2KLcTi0Fc73lPkxnvgY6XW0UKzkROJEW
 A1jtaJqSC62jUqvwfPzb/YPbQCXap50TN9wAsRfEqaXWDfIaiUyueZVp/AoV907bls/h
 rNiraL7239JOQJduVbvvfaHbgMfiz5hJtCGIeQc/jsQwytddvcXfZaL0WBcJmxZ5So87
 14s5S+t8S9M1mbYt6UHg+B3PiztCxK7Zjqu9PYbwGyoqTiKBgwXjXIxKa5Luat0RGDz1
 ZcJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RcUu4DVxRWMupITw2FCqqjgBYc8DKYegf3oDVgYiJWc=;
 fh=gumS4ncRmU4qH3AXNbe3LANH0azf8Ff9FlVIrW6S5Es=;
 b=mAIij157zCFCtP59qFFYnA3H1A0sAzjAqTAfcC6wQUtN/bEHvVohq1bs6SzrHo0jjc
 CEMSrRY9JMJyPSotger3QavUe6/poV85K6nxhyFmOKqLasnAfesvdCMDhu+8QjsayAml
 akPT8baTI3I7lMHiSSH3oq7RFgT5evCCwe70cV+x6+p5ECFbCDKvFlHKjNvazfaLr7FW
 ISG1yNxMBQuRqBhPiTszOUgpNwrBou4+NocvUnVeVDvf4vDR8U4XqICY5NA+v/1sVUKj
 nQd/HeVQA8zXtx73kkjgJMMFmtY7KAOdVKKAF/CpujwMkHLfsB1pPkFXpeUJu0PQjBr/
 qusQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792684433; x=1793289233; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RcUu4DVxRWMupITw2FCqqjgBYc8DKYegf3oDVgYiJWc=;
 b=bGkzQW16UABPfCZIoTevJHMCVfmaSpMQ8n92FSPtbro/6jP5xSnlGzm5kUg0GGYhiP
 MPWwYq7xjg7Mv1gn/h3M6lwCokcrNYmodYzwKAa5q4+rxzm4IbDWdA21DqmbVBhlyhgc
 rTU+f6VZ2/jLvrCpls8LANT0sODtrVbBLhub63yMyrIQWW3B7E+sYw7AeO4MIZoNZIlj
 3I5lH5lvOvMx8jt4gyfgg+LgTD20vb79sZ5naNBkxRpaSCLMJ26fsB0pqjjlGDWvGL4M
 0rOR4YaInzMnnt+jxJJG8QbvyGjHITPMWhu6CgwvL1m+Quy8oVMF384XiyYRzoFRYJ+/
 jdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792684433; x=1793289233;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RcUu4DVxRWMupITw2FCqqjgBYc8DKYegf3oDVgYiJWc=;
 b=NvZJxT5aQQrucEqD9NZj1lSodHYZJD6TmLUgAR2B43GDPpGZCjgGh1jTm2wLFSRf5r
 kMqdbo224qLhQ072YTnE0B8yFbPqy8/Dx15mtIJbgFJJktgiRtAyU7hlkLwssdo6puJ4
 sQKQC4h16GZ513By6j6GLhaZXDmmuBtB8DtW9s7Y3G92V5I39c4m3o1M3bZzHD45Tf+r
 B2UEY51T/i34KTqyldtyrpfyPZAG4vNtf+rFwd9XEkVAXAA8tBTsYk719BS1Gberz3YC
 8BCfl4RfrJMDwmUbmQ7TWcMRoq64K5Mwgo3EYCFLh69htR0HDn8mfQWjZ2JWz7cZAPio
 cXew==
X-Gm-Message-State: AFq9FYKN5CrS4c49pFRyxQs9Jf4EpsUTGSQcFy7j0ICcnrQCNAgYkV2B
 gq6/LpoNhLrx5Nvb35REt9YYRAjtxYvu5r8RogKV0zzzEoc7PkGQZmtV9FPwVJPt+6GgTwfkBg3
 8UOrkLNpfGD2fCLRKbzWUGVw0lfzGa7g=
X-Gm-Gg: AYBFou3ZAoX+OlGHXJ4nBj3yRggaluwLJkidhHyBPFRzf+3Ihn/NskH76cjLJIo4cF7
 dB8r+fzx/Le6aAAfNsm/jxzMCvIz7vK3sZErlOeUcDXWtSh9dR4CX460pvDPh8MHbF5Xb+3uEPb
 UJGuCoLsUdGCVOAbUz/gaLJvALCqt7uYt0KR1Ybf+VcIDOpM6rUYy5F6vSo+7upxF6jWqJWpUKO
 msUJMLntY5TX2Xhz1HN5rmYRn8zP6Ztn2DMmSn/xn2ZD+9ioTgE/9zygRDu52nYIOemOEzwvxn0
 1eR8G0kmQJFMdV9mHQmFi81OBVrbAQi783nfnbTRAD8YM404cIR8VbXJg25XjvurJ0D9vPZ2YWe
 r8/jIF3RQtq1UAtRS8RvobwP9mD/573uOpgAQDVzUPzs3D9BLeCR7ANhDkLqEwiwxhi0WGzO4aR
 v9CQXxoiZij0frCKyfDvpDIOE=
X-Received: by 2002:ac5:c4f8:0:b0:5ea:d67f:fd39 with SMTP id
 71dfb90a1353d-5eaebe76faamr1785426e0c.5.1792684433373; Thu, 22 Oct 2026
 08:53:53 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022003058.1723817-1-bas@basnieuwenhuizen.nl>
 <20261022003058.1723817-2-bas@basnieuwenhuizen.nl>
In-Reply-To: <20261022003058.1723817-2-bas@basnieuwenhuizen.nl>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Oct 2026 11:53:39 -0400
X-Gm-Features: AclHuK9goIMM32nAxMzkGLdI9wTGQjVy-TyiXmSxr0kXjkOJVh-5UxTyd_fvFVs
Message-ID: <CADnq5_Oh5b_XVZu5oUBEsotGmwa6mJUevUZ7Fsqf7_9ZKnGs6w@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/amdgpu: Check cs flags.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
 samuel.pitoiset@gmail.com, natalie.vock@gmx.de
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
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 9:26=E2=80=AFPM Bas Nieuwenhuizen
<bas@basnieuwenhuizen.nl> wrote:
>
> Had no validation before. libdrm_amdgpu memsets this, even
> for the raw/raw2 functions.
>
> We have a lot of functions touching the ioctl struct, no
> strong opinion on where this is placed, but I thought
> early would be good.
>
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Reviewed-by: Faith Ekstrand <faith.ekstrand@collabora.com>

Patch 1 is arguably a bug fix, so applying it now.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index 1745e500fd80..63fd16009bf8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -188,6 +188,9 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p=
,
>         int ret;
>         int i;
>
> +       if (cs->in.flags)
> +               return -EINVAL;
> +
>         chunk_array =3D memdup_array_user(u64_to_user_ptr(cs->in.chunks),
>                                         cs->in.num_chunks,
>                                         sizeof(uint64_t));
> --
> 2.56.0
>
