Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F953F436AF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 14:29:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E378510EA45;
	Fri, 17 Apr 2026 14:29:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J1tqW0Fk";
	dkim-atps=neutral
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C20A410EA45
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 14:29:28 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2bda3b4318dso99392eec.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 07:29:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776436168; cv=none;
 d=google.com; s=arc-20240605;
 b=faRn9NqHfCEbDqe3E+K+C5TU5PaAh6OcUUGRKSrVpLG8/1W7yEP/i0NSWqAyrjKMcr
 AqBpQ7ecNm0BIQlAYYfgv7H2eIF2s4ILiTWMdWnTh7Hdejp6+UCWU88Nz16PwxJ4Ctpv
 aKA/JakYcx8LVEQGISD9c9+L91w9CFbikMFuaYYbRheDfC4JWXKPZjcJqwUpipqCb06j
 Z2gwhG53q1tNvwQ01RnLMnJjD5lIODqI0PsgqAvcBZOM16laPWXoMIOLpBoKTfBDH6k2
 FMoQhz45cYFMJSYXpECtVKpfSd7yA8RxG/DVj8eWLtAtJD1TlCG51gxzoBvGtWTJQ6oa
 +B5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7U0qAFFPkGHTc+pBC8a4T4CGoeQZqx86T/1PPhsileI=;
 fh=ey/RHOY9hARdrKDYdcJkovMaVSc9t1Y8AQvC0Fown8g=;
 b=TmZBFTvro2sJyZrwn6WeruhJR+N6WPPaLeygmswIQ8TtFD0K7JbpZS2VPFMYjeuHsz
 Gl5dIHt3aIOfPJhISPAj4tkGBYX/nD8kJTj3Tc2u7i5ltxlWbPv9/ZN6ZBdHw6YdIYHz
 nHK0U1hXaFtG/Ll4AwhKWsyWvIik7juAKaZ2ckeihXEnqoKjXbBcQRsz99znmS4Xhhx2
 lH0Ay/BSlWgS7+jSetiEtNw+54PHxvfC4Tttdbo1iGnLIQ19wxj7CTDzh1rzt7GwnFps
 Dgb+Rd/N3CtrQyKH8Egb4I2bvW6aJ9JPHFk3ZZ+zUL7Zr0ySZtKdF/2vw4sJjs4+IxAw
 HoZA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776436168; x=1777040968; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7U0qAFFPkGHTc+pBC8a4T4CGoeQZqx86T/1PPhsileI=;
 b=J1tqW0FkYQUlYTCTZGkhzO8LvtiKvEk/7Yg1SFBF+O1CcxK5SalaLgrjOF8ellqm21
 s03hnJDBA//AGCqpqBLxJwPsyaoSJMJxurpGvt1CV4wJoC2/5n5IXnHiBXLgS/EyruTz
 oNGT2zZkDicLdUfuySJEfxlF/9tCHuDY1hKeuGjjtZ7J2BJZxymuSQqsyjcBQWbrPogV
 Cfa02ubkXlQRrU/gJJ0NEY4p6XZ6JoY5o8+koo3GDKMkI4o894GmQz1ioLhqsK+YRorL
 RXq0NEkKpEvzC4gyafIGVaAD+mOU+uGwv8yFturqiVvzkj2XjRoNKYNOQ7EVC0RVOI4j
 s9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776436168; x=1777040968;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7U0qAFFPkGHTc+pBC8a4T4CGoeQZqx86T/1PPhsileI=;
 b=JWCa0AVIzXUKrzuwf1HZ8E5j/rm7DbM13REdgbwhY8xTM2kRSisl57u6DjDf9p/4Ng
 ktbDdZhdLsOBmkBMJsj2jVb5/CoCt6gyklH1xHknA2yzBX15kENoqgkSFJOMdZh1HGzs
 Y1hPNwNQGNM4reZUl2VbZaljDPowUTcJTwxJwfKxIFsNRnKK8VpjrfhXc00DefU7itVH
 q6zMsxNwo5nbY02DBc2BUgof9F3SK9+qLMuu3nbotzK1lgdYb3pTD8YAlJTV4EyInKoG
 caXYyF+7jSZfPzeO+BcX2jLA/b1s8aGk6QKUKTygknZb6XmYJNcbIISdGerfYV97zn7C
 HmhQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9vH7xuF2E7lADc/z8qPHk4izN6M+1r0yquy4x7zuXdfz9v9lVkDGkYHrxqc95646LJ+jYoM5RU@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxPb8IsKn+ox6nkKfV88HDXINYAVDPQAAexVusURrelh/2rXNvC
 Y92F63VUM3+kXaQJrCm7A6SBPNAAa53hHjCiNQ6RaKRf00dqvxjeNnRm6vDo02oCvaxWNVXPKJc
 42YDA9GzkK2xqRKiVgHyqQX+8F0gss4M=
X-Gm-Gg: AeBDieuxDVSp2n6EjdbLftoPcZDhzsKrpw4fZ0XOZR3tbnshrfCKs2ot5oIq+iSArnb
 K1r13sQg7Sggbu2avfn+4Ql/h0gM+3Ipa/62Zch/6VIdMzHLs/Az76fS4amuymP7LEt0w0lB3tS
 b/zdKV5K8qRIHRfRsnG7G7YTj4KkmwjBsIPKgTRsk9TdMKghpVGyUjb4ToMp/FtnFYvN5iOTn8R
 zYXX+L7PAsRxTvijgqPzPdrZOvwkjO0hK5bN+7zpIZyhTT+ltmTiTaXZ+OldkrJJ/gt3gp2bazG
 eAcElfORrxvk4B35tNaJ/g6pwZgyWpPWu3bvvoHP0o+sCrgH0STaipPBytUxbVmt13L8PFxeRqp
 seAM5
X-Received: by 2002:a05:7022:6889:b0:124:af80:9d0c with SMTP id
 a92af1059eb24-12c73d26cc4mr547799c88.0.1776436167906; Fri, 17 Apr 2026
 07:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260417140632.1476-1-christian.koenig@amd.com>
In-Reply-To: <20260417140632.1476-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Apr 2026 10:29:14 -0400
X-Gm-Features: AQROBzA0G9tj8a30Pomw_wBFVA8mUrcrPrPr7olqnRgnM3OAdagjammR0PIrsVw
Message-ID: <CADnq5_MPKbT-92RKJJFQhK26hhtVHt=i2_R2nV53wFZXEzDEOQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix AMDGPU_INFO_READ_MMR_REG
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: victor.skvortsov@amd.com, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com
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

On Fri, Apr 17, 2026 at 10:24=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> There were multiple issues in that code.
>
> First of all the order between the reset semaphore and the mm_lock was
> wrong (e.g. copy_to_user) was called while holding the lock.
>
> Then we allocated memory while holding the reset semaphore which is also
> a pretty big bug and can deadlock.
>
> Then we used down_read_trylock() instead of waiting for the reset to
> finish.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Fixes: 9e823f307074 ("drm/amdgpu: Block MMR_READ IOCTL in reset")

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 57 +++++++++++--------------
>  1 file changed, 24 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index d88e4994c8c1..24526e92f9b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -873,68 +873,59 @@ int amdgpu_info_ioctl(struct drm_device *dev, void =
*data, struct drm_file *filp)
>                                     ? -EFAULT : 0;
>         }
>         case AMDGPU_INFO_READ_MMR_REG: {
> -               int ret =3D 0;
> -               unsigned int n, alloc_size;
> -               uint32_t *regs;
>                 unsigned int se_num =3D (info->read_mmr_reg.instance >>
>                                    AMDGPU_INFO_MMR_SE_INDEX_SHIFT) &
>                                   AMDGPU_INFO_MMR_SE_INDEX_MASK;
>                 unsigned int sh_num =3D (info->read_mmr_reg.instance >>
>                                    AMDGPU_INFO_MMR_SH_INDEX_SHIFT) &
>                                   AMDGPU_INFO_MMR_SH_INDEX_MASK;
> -
> -               if (!down_read_trylock(&adev->reset_domain->sem))
> -                       return -ENOENT;
> +               unsigned int alloc_size;
> +               uint32_t *regs;
> +               int ret;
>
>                 /* set full masks if the userspace set all bits
>                  * in the bitfields
>                  */
> -               if (se_num =3D=3D AMDGPU_INFO_MMR_SE_INDEX_MASK) {
> +               if (se_num =3D=3D AMDGPU_INFO_MMR_SE_INDEX_MASK)
>                         se_num =3D 0xffffffff;
> -               } else if (se_num >=3D AMDGPU_GFX_MAX_SE) {
> -                       ret =3D -EINVAL;
> -                       goto out;
> -               }
> +               else if (se_num >=3D AMDGPU_GFX_MAX_SE)
> +                       return -EINVAL;
>
> -               if (sh_num =3D=3D AMDGPU_INFO_MMR_SH_INDEX_MASK) {
> +               if (sh_num =3D=3D AMDGPU_INFO_MMR_SH_INDEX_MASK)
>                         sh_num =3D 0xffffffff;
> -               } else if (sh_num >=3D AMDGPU_GFX_MAX_SH_PER_SE) {
> -                       ret =3D -EINVAL;
> -                       goto out;
> -               }
> +               else if (sh_num >=3D AMDGPU_GFX_MAX_SH_PER_SE)
> +                       return -EINVAL;
>
> -               if (info->read_mmr_reg.count > 128) {
> -                       ret =3D -EINVAL;
> -                       goto out;
> -               }
> +               if (info->read_mmr_reg.count > 128)
> +                       return -EINVAL;
>
> -               regs =3D kmalloc_array(info->read_mmr_reg.count, sizeof(*=
regs), GFP_KERNEL);
> -               if (!regs) {
> -                       ret =3D -ENOMEM;
> -                       goto out;
> -               }
> +               regs =3D kmalloc_array(info->read_mmr_reg.count, sizeof(*=
regs),
> +                                    GFP_KERNEL);
> +               if (!regs)
> +                       return -ENOMEM;
>
> +               down_read(&adev->reset_domain->sem);
>                 alloc_size =3D info->read_mmr_reg.count * sizeof(*regs);
> -
>                 amdgpu_gfx_off_ctrl(adev, false);
> +               ret =3D 0;
>                 for (i =3D 0; i < info->read_mmr_reg.count; i++) {
>                         if (amdgpu_asic_read_register(adev, se_num, sh_nu=
m,
>                                                       info->read_mmr_reg.=
dword_offset + i,
>                                                       &regs[i])) {
>                                 DRM_DEBUG_KMS("unallowed offset %#x\n",
>                                               info->read_mmr_reg.dword_of=
fset + i);
> -                               kfree(regs);
> -                               amdgpu_gfx_off_ctrl(adev, true);
>                                 ret =3D -EFAULT;
> -                               goto out;
> +                               break;
>                         }
>                 }
>                 amdgpu_gfx_off_ctrl(adev, true);
> -               n =3D copy_to_user(out, regs, min(size, alloc_size));
> -               kfree(regs);
> -               ret =3D (n ? -EFAULT : 0);
> -out:
>                 up_read(&adev->reset_domain->sem);
> +
> +               if (!ret) {
> +                       ret =3D copy_to_user(out, regs, min(size, alloc_s=
ize))
> +                               ? -EFAULT : 0;
> +               }
> +               kfree(regs);
>                 return ret;
>         }
>         case AMDGPU_INFO_DEV_INFO: {
> --
> 2.43.0
>
