Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4DBC7EE43
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 21:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1AF910E012;
	Mon, 12 Jun 2023 21:47:52 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7D2B10E012
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 21:47:50 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-392116ae103so2815997b6e.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 14:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686606469; x=1689198469;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dng0rKyaj5P2/lXbJTiUkg7nyJ3egT6Hv27UnyXa0x4=;
 b=CSyuVHGS4x4kVug+kkgSHKff8263wYRG8tUW/PMj+mSgM2PCPX2iR0zxSvvJmsM1hl
 PVuQdGlRIRzZJ5gNB6hNa+MXkb3qZGvvCArON+bmgNwu44i5/TTR6aS0EzD5ofocTUhq
 APdGVKv+TEGsWaZdA7/vMPTD8o+xxRKbwFRW8M00f4E1oQO6GqIlPCSdsP3LBuy21ntv
 5ooAgczB5ytgapEKSfcku7SRZKR6r9twRDvjKhw/okw8wwXfIBhcY0/Mle0WNk8KQDQO
 9CvqJpViDb+xAbLr8HocqQeaiSM3TQ1NbHt2w/odUvvUl/B8exFnCjvYTubDub0IwW7H
 qo0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686606469; x=1689198469;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dng0rKyaj5P2/lXbJTiUkg7nyJ3egT6Hv27UnyXa0x4=;
 b=WY5kJYp/jKcjzCU357IvakNQniFUQdf7gq/CD+hGtVQyNXdznMhbMOXYOswsYgWJpy
 Zc8ZIF3phyGWVZcKJGbI+gzWhEwN9Zt5RZ1jDVXUeGKMUPJE4o+lUOvkuKusLU1CRqK6
 Cr/3H0CCn6x8xXIPmbdCzxPrQEYqrMm1VlEN5JGs1wjRZZsWKYV9m6r23yI64n8kuWAM
 DFgG7/6TKeEMYo7IZUhDh+vefVASKo+0wDX6AOuBHtz5uIPEtAGuxQMbv3zvdLywo17p
 wL26JdoKsKbn/zpu+Nfu+NW7MXKVMsEj3U2VfE/izp+VWPQd6jgns9OGdM54CJkcpItN
 PAUQ==
X-Gm-Message-State: AC+VfDzCXDEDWPDlu1rin6sAl1Shn6ZPpEg0hVVf+K9rmDOisbAgyQYN
 pLGLF0DflOKadioI96GqFbg63+hgzjdfJHD/z+A=
X-Google-Smtp-Source: ACHHUZ6Wi+doawVqAZDjA8XExE5dLcEnU0BLZA0ZXUxiWYGw1b9b+bo0wHq75u0zqX0HTzT6NkRqF0bVxTx3wGGrCJs=
X-Received: by 2002:a05:6808:1a17:b0:39a:c1a0:7cbe with SMTP id
 bk23-20020a0568081a1700b0039ac1a07cbemr6347061oib.12.1686606469569; Mon, 12
 Jun 2023 14:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230607163136.958994-1-alexander.deucher@amd.com>
In-Reply-To: <20230607163136.958994-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 12 Jun 2023 17:47:38 -0400
Message-ID: <CADnq5_P6e7kYFYaZ9S8yRGhyWrLbUqBEPtGjTPHJ5a1DVWsepQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/sdma4: set align mask to 255
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ping?

On Wed, Jun 7, 2023 at 12:31=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> The wptr needs to be incremented at at least 64 dword intervals,
> use 256 to align with windows.  This should fix potential hangs
> with unaligned updates.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_0.c
> index 1f83eebfc8a7..cd37f45e01a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2312,7 +2312,7 @@ const struct amd_ip_funcs sdma_v4_0_ip_funcs =3D {
>
>  static const struct amdgpu_ring_funcs sdma_v4_0_ring_funcs =3D {
>         .type =3D AMDGPU_RING_TYPE_SDMA,
> -       .align_mask =3D 0xf,
> +       .align_mask =3D 0xff,
>         .nop =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
>         .support_64bit_ptrs =3D true,
>         .secure_submission_supported =3D true,
> @@ -2344,7 +2344,7 @@ static const struct amdgpu_ring_funcs sdma_v4_0_rin=
g_funcs =3D {
>
>  static const struct amdgpu_ring_funcs sdma_v4_0_page_ring_funcs =3D {
>         .type =3D AMDGPU_RING_TYPE_SDMA,
> -       .align_mask =3D 0xf,
> +       .align_mask =3D 0xff,
>         .nop =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
>         .support_64bit_ptrs =3D true,
>         .secure_submission_supported =3D true,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v4_4_2.c
> index 8eebf9c2bbcd..05bb0691ee0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1823,7 +1823,7 @@ const struct amd_ip_funcs sdma_v4_4_2_ip_funcs =3D =
{
>
>  static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs =3D {
>         .type =3D AMDGPU_RING_TYPE_SDMA,
> -       .align_mask =3D 0xf,
> +       .align_mask =3D 0xff,
>         .nop =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
>         .support_64bit_ptrs =3D true,
>         .get_rptr =3D sdma_v4_4_2_ring_get_rptr,
> @@ -1854,7 +1854,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_r=
ing_funcs =3D {
>
>  static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs =3D {
>         .type =3D AMDGPU_RING_TYPE_SDMA,
> -       .align_mask =3D 0xf,
> +       .align_mask =3D 0xff,
>         .nop =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
>         .support_64bit_ptrs =3D true,
>         .get_rptr =3D sdma_v4_4_2_ring_get_rptr,
> --
> 2.40.1
>
