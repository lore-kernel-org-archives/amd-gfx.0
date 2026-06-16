Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45422CD98E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 12:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D48AB10EB8A;
	Tue, 16 Jun 2026 12:53:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="njaOuifu";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EE9B10EB8A
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 12:53:18 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-307b668e1f5so351626eec.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 05:53:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781614398; cv=none;
 d=google.com; s=arc-20240605;
 b=kJyEmVP+6bSUaO0bUzoi5yKSmj+/3LYNpkiOa5rlxjUjVrTn1rwFaUb2hb7q83XrTx
 WduwnpalNZBU0LAuqfHG1IdEhIRbnI7/8zYUEoauBt+ImKeqLZvvx9KuDPvcNpc9NvJD
 8ZXdUoZBrxS/RUhHMohyxxOng/EGRhaWqWQOVRhn2HmlXhjvjyRl7bP/x7pynWciVWFc
 2dtPpqdyfL8XFSWpR2gmQZSzaF2Vhzih5jptgb1rBumssVdd7g9lu9mAP0pULj2GNIB+
 cjDc9cqF+RH0e63uEZCmaxJdq5dzE4lLIGv38qGmUu795zES3tuwpTGynXUc/GDv3viB
 i6Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DgG30hfLxdPj3h4xHvfE9KWaPfBimim29sljpeweFao=;
 fh=hu6edWbrNIbeIZ0Tkzb9Dvke4+sCsh4tKagiLtEFVz0=;
 b=JkLAIMoce34PZEhbGrTgXKgq2RzGW4m4fQqb6ys9CkYHLvZS5tTTIoPM/qNhZdSkvK
 L6bNN9goB1UtGRN6i7hlVKnypCffoqplGJLYoDpqprE0HF25yc54XU1faV/pcYuHJygu
 MmOxmpz/NoN5Rhy3gpict6aCj300aYczyK3jnNY7LcziVDJW+FEo/YYgM26B97JzKLYB
 +ghTrHxi+YVZ4XTfUB7RstJP63QfHE65OSFD/azov02FFHNRH8wm1a/r0dCQgcpk+vh0
 XMA90In57FZsuecZ+AfDvZ3qa90rRQNO28+bLS4zAn6di5fKI8cmbuShHDK0t/OXl1jh
 +geA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781614398; x=1782219198; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DgG30hfLxdPj3h4xHvfE9KWaPfBimim29sljpeweFao=;
 b=njaOuifuREppzneuYrOQ9V4iKPdunerMNQY4ouCcBsMOu+TsmJTh/mUkC76Pl/6EYa
 ihppsZa8Z2TGj1WzXJPacf3DDWpepVCJrCbFs6HZgCNx4M9uOE+RAgqjRHjTzTQ3wMSz
 3C+KdpPYngyeFkpWD0AiI/jcaNTywPtBaBk8Yz1xHc5LlbIVm4npoC6h5CI/lCgGslBa
 oJhB0x6Y4oUpz8yP3wW+10sSrpOossZeqYu90XBOMiZ3daPmeRn1TFNkDIOEJKuxKFlT
 Lxjs0NDXKaby32Vzey3gdvMGyKP6ueQULxHIdQEJTNJzse2TuVs6OjmuOLSZaKVd2z5Z
 x7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781614398; x=1782219198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DgG30hfLxdPj3h4xHvfE9KWaPfBimim29sljpeweFao=;
 b=BASdyCfBBhPU1JKUUmC1IlBXAH4RNQ3qoKfiVXicoHyT3jci8/KtcDAgCD7c+oFr/O
 tGICScrthYbEIcaPqpJBLYRk26a6BsIkYiVMF0m1iww3spSeTTG34xBFoUX4uKtGwqXo
 +T8TP8BaAkn5Vp0p5h9LQYceVU4IqQxw1C0TkYuSEgN68bIgAKvbk7nnDqdxOCMeAnE+
 lBJaPJsZSJQWuwsP/nKXyc1pM6GIR9MlcODICSuPZW1ojOXJpH9bnWbJgyDAbOhQonF9
 EwcrYVSo6tHvbvG19an58MEvLemJJFxoJOxZpf7h+93YnO1cyZVQmM8GtNhW3UGfvucb
 siJQ==
X-Gm-Message-State: AOJu0YxIktQLIcrhTcD0N3YBY69GrdXDZ+LJ6ZIVhSQyM33UmUqClmbs
 dbev9QMCQvq8PtMtmYZA1MMli/SNBrsS0xdhHryL6teJz8doPjRxj1LI2JGWGDDYRpW/ii7dsE7
 VQ+S0Ll94siHqHEC8dRvQoYIHo4D46fM=
X-Gm-Gg: Acq92OGY6tbuaVBghw1qfB1Blf/yuJGrK9XUrLLM3XxSGRfyCo4bkC8ynDQLCcWa6SO
 zbmXd+UBBfeM2ayfA5K+EVow2VLq9lPob4BrQTB0bz5HAh1QDYnJdvvKMWkHJQ93bP2ac6ZNBDv
 TjaoMTeSkCmyCVePvlKrVlZzde+vBH6szu8/OlnuUi0fbwvJPsWP6xc18E8kOeNB8nrNZOjOGHL
 dKBg2NcpGq+fbO9rsLiEgtqa6+5iOiYOS1xiALfYDVtb4Xxsst+a7ayA9svIANjLX4MVpdyy6/+
 Al9j84/q3ui9X2eNnhbkzMrefrcF0BXhhx3QF43QKT8C0PxwdYNffkjMOs7SfvFArZ32gw==
X-Received: by 2002:a05:7301:7c12:b0:2d5:9438:2a02 with SMTP id
 5a478bee46e88-3081ff33588mr4688011eec.1.1781614397277; Tue, 16 Jun 2026
 05:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260616052808.354123-1-lijo.lazar@amd.com>
In-Reply-To: <20260616052808.354123-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Jun 2026 08:53:04 -0400
X-Gm-Features: AVVi8CdtFAKW-dJLnB8xj4Z1RyUuoyPnsXkMo9zg3IbVLkFJUuHyKukKwbiBruk
Message-ID: <CADnq5_P=rn9BKCMUVUBxfnTh8JM4VKFLZdzd5gX9kgkKyxySGA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: bounds check ATOM IIO table parsing
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Asad.Kamal@amd.com, candice.li@amd.com
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

On Tue, Jun 16, 2026 at 1:28=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> atom_index_iio() parsed the IIO bytecode without bounds checks, allowing
> out-of-bounds reads on a malformed VBIOS. Pass the BIOS size into
> amdgpu_atom_parse() and bound the parse loops by it.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Assisted-by: Claude Code

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/atom.c            | 21 +++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/atom.h            |  3 ++-
>  3 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_atombios.c
> index ca65e6ebdb25..a0c740bce310 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> @@ -1923,7 +1923,7 @@ int amdgpu_atombios_init(struct amdgpu_device *adev=
)
>         atom_card_info->pll_read =3D cail_pll_read;
>         atom_card_info->pll_write =3D cail_pll_write;
>
> -       adev->mode_info.atom_context =3D amdgpu_atom_parse(atom_card_info=
, adev->bios);
> +       adev->mode_info.atom_context =3D amdgpu_atom_parse(atom_card_info=
, adev->bios, adev->bios_size);
>         if (!adev->mode_info.atom_context) {
>                 amdgpu_atombios_fini(adev);
>                 return -ENOMEM;
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdg=
pu/atom.c
> index a40ce7555f28..941941cc1759 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -1327,11 +1327,21 @@ static void atom_index_iio(struct atom_context *c=
tx, int base)
>         ctx->iio =3D kzalloc(2 * 256, GFP_KERNEL);
>         if (!ctx->iio)
>                 return;
> -       while (CU8(base) =3D=3D ATOM_IIO_START) {
> -               ctx->iio[CU8(base + 1)] =3D base + 2;
> +       while (base + 1 < ctx->bios_size && CU8(base) =3D=3D ATOM_IIO_STA=
RT) {
> +               uint8_t index =3D CU8(base + 1);
> +
> +               ctx->iio[index] =3D base + 2;
>                 base +=3D 2;
> -               while (CU8(base) !=3D ATOM_IIO_END)
> -                       base +=3D atom_iio_len[CU8(base)];
> +               while (base < ctx->bios_size && CU8(base) !=3D ATOM_IIO_E=
ND) {
> +                       uint8_t op =3D CU8(base);
> +
> +                       if (op >=3D ARRAY_SIZE(atom_iio_len)) {
> +                               /* Malformed table: mark method undefined=
 */
> +                               ctx->iio[index] =3D 0;
> +                               return;
> +                       }
> +                       base +=3D atom_iio_len[op];
> +               }
>                 base +=3D 3;
>         }
>  }
> @@ -1553,7 +1563,7 @@ static inline void atom_print_vbios_info(struct ato=
m_context *ctx)
>                 drm_info(ctx->card->dev, "ATOM BIOS: %s\n", vbios_info);
>  }
>
> -struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bio=
s)
> +struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bio=
s, uint32_t bios_size)
>  {
>         int base;
>         struct atom_context *ctx =3D
> @@ -1567,6 +1577,7 @@ struct atom_context *amdgpu_atom_parse(struct card_=
info *card, void *bios)
>
>         ctx->card =3D card;
>         ctx->bios =3D bios;
> +       ctx->bios_size =3D bios_size;
>
>         if (CU16(0) !=3D ATOM_BIOS_MAGIC) {
>                 pr_info("Invalid BIOS magic\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/amdg=
pu/atom.h
> index bb3d9eb7eb6b..4687c019cbe3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.h
> @@ -133,6 +133,7 @@ struct atom_context {
>         struct card_info *card;
>         struct mutex mutex;
>         void *bios;
> +       uint32_t bios_size;
>         uint32_t cmd_table, data_table;
>         uint16_t *iio;
>
> @@ -160,7 +161,7 @@ struct atom_context {
>
>  extern int amdgpu_atom_debug;
>
> -struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bio=
s);
> +struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bio=
s, uint32_t bios_size);
>  int amdgpu_atom_execute_table(struct atom_context *ctx, int index, uint3=
2_t *params, int params_size);
>  int amdgpu_atom_asic_init(struct atom_context *ctx);
>  void amdgpu_atom_destroy(struct atom_context *ctx);
> --
> 2.49.0
>
