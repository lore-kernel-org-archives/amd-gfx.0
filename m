Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A63C5B572
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 15:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1780110F3AE;
	Thu, 13 Aug 2026 15:34:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iuu9pigk";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E42710F3AE
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 15:34:32 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2ceeee8c46bso81375ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 08:34:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786635272; cv=none;
 d=google.com; s=arc-20260327;
 b=j0oTYj46GW3o9x7OHbwOKaPQvtbjB5P8hjI6S/Voi8dtFZX3EDo92dFyy63d3jD9a4
 d15P/E+O2Q8K1jz7gwngRrtycAN9gX6ru+KltsLGjmNL3+yQBJMRKVCqsvTtIKumj07i
 YWkhhv8jVvo7+dxdQOkLO17OfM9AgWrt5mDASJ483UF5yd2QgDCjKR9A6PEL6Bzn7NaM
 Gtut7szEsvcz/lyllzFD7H2j3QMKz2VKAeRcJRMAYff6H7dU6INpGyc9niI7DpablPpH
 U9QReFdAaf9czkgeXn12c/+xAOXylmNcxCzU+Bq7h96tiQdsvY2Boom2nLVMXIEj/Is5
 pN+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vAtk/ytW6d3beEr+fBua1dlHfWNL+npwZA+TVodN0RY=;
 fh=+eThy+SqkAKnFARuDzr1zv1dJvMsEMaVjoQ1eiAy49w=;
 b=GUQfWTou5GBbLx53otOAthoBHF8FR3bdUPwJDn4Ww/6NQQbNaUe0YXqGSQ3qqLQ2gl
 wv/0b/tEOjz6CcFpEl6/1LpDnU8Cj068qdJ5ovL9qAxhnWlNTgL+K16kNhCsvK6MqiRM
 4NmRasZKuXm8lQur9P+GnsHeebBHHUvslCg0AaM4BN00tkBQm/FsTURdT0HrBrryg9QG
 zcDC58HokSP5LJxa3OQrghdCaouuHl5QBQjiBsfRLdm/9Xf2TtlkTXJQvLLGBqIqwhcy
 94Cr6lwaqxu2NFGH03FrADbQrubV0dVhGfZ38KD1cGoG3TOh2lLcRI4RN26RWIHxEMB3
 Y2pg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786635272; x=1787240072; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vAtk/ytW6d3beEr+fBua1dlHfWNL+npwZA+TVodN0RY=;
 b=iuu9pigkb5tI6wMQ+T8DMyGi9kIXyERHJdb9TYJCaqdj7NO6Z2aVhHiegBZ+iM5rOP
 iq0jQtPAtdsXkBW09+35A+3ZvW329SNgtoVp+beWwjBNH8a9MxJ2oioe+QnjSokSKkDd
 /JQXVZ05qisNMkt/mCi1FREVNkKB2P8YZHqnd+G0wUtXYOvQrXkKu0bp86nL7mhhojpV
 DWxde2j2i3ySSGeN7t+dnWKBk2h7DW5ROjRyAOY8Zg6WMBqi6+oqjJaWRZ4IysvI5NS1
 szQinBWGPAXFD2Cp9OKCYLwfCyfZhd+uYoxr2bgoaSIFcimFOPd22moK0XlA02lKHBkp
 7Hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786635272; x=1787240072;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vAtk/ytW6d3beEr+fBua1dlHfWNL+npwZA+TVodN0RY=;
 b=jG8D4G/yAnHe3HXkkLE7G3lWKsVmWAT6q19xkAhlmssmqk82IjK7eTjbvz8W0J4nU0
 yDG7FJLl3fnPA0nugx8WA83MV3qli6Pbcc4WIeYu7cBLfMI3KrT3w0RKDtbv/VqxfASn
 AuwVRDCGlaZpqqjYhEjYzdg6Ztwg0Me81M0whGV5szrAxACPiqypxIqUggACCUAhMwGW
 H7FqEbuye2/FIHsfkKfA+9xCd0byvHaUHSvMh4D4zIVkBY8qsMiQZA5n2TBdZr0mHrEm
 9HQTt5Qr83a4KZoWZPumHLiCn1o4ikHcaz3/7ea9Pwx/h+SVIVIf62bP93QuRkmBP5Fr
 7Hbw==
X-Gm-Message-State: AOJu0YyEIbM5zTRtAuoooh/gihoaDmCNBBZTIL3jimE6l6CXgTh5GbIu
 SQa6995IsfxEa0NgvqJNgytt2K2mUZdz3b7+E1U0cQAQpdLzFvhXhqciqZUUVmlsqVTjpi4tsQB
 aN9fRd4AD6quMFT3V5uzcb/IBf/Cwmd8=
X-Gm-Gg: AR+sD12cKZnK3TL++KyPeK9K4ir8D6tcICZoPjdj61kCQc4fIsohzJVXael0Yw07fp3
 iA5ubXEWuTpD0FD2L83rLYy0okRV0up4h8dAHgHNfmhDKirkRQXr6Pthjl2B5xDYRMt5yyE13DS
 O3YOVlVnJw4tplmWMoNQOIhWDoT1jmS6sY0t5yFctg2aAkWidf9sYt6F8Rg1fgvEPRqazlITFdc
 2SVtx3iKs2q6bXSype5or0t7DgR4P/omeKannZ740AOZZIATTo58TUC09E2RRQ3ZAtCAe6gPX0x
 7q5xpljXEpYxblj9a2BAT7gmWHhC+IE7Hsg3m1BMeAAsPVjStHVWBx8D2NTw7oJh2w8Jy2rv76K
 pKNNKBHK8QvPDrnI6mdNZtu06Bn0/hmI=
X-Received: by 2002:a17:903:8c7:b0:2ca:d803:5c8f with SMTP id
 d9443c01a7336-2d38924be23mr51091655ad.1.1786635271850; Thu, 13 Aug 2026
 08:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260805212722.247508-1-jinhuieric.huang@amd.com>
In-Reply-To: <20260805212722.247508-1-jinhuieric.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Aug 2026 11:34:20 -0400
X-Gm-Features: AUfX_mwrHlJQaC_rCyDza3CmLcILwJPI2O6sd-tsNiX8hwVh2SjIYcNcOVE-pAs
Message-ID: <CADnq5_M4SvP3T8bLwyQZbFVK6XZnOetEkS6_LdOpqKYeL_R=pA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: add new mes misc api for gfx11
To: Eric Huang <jinhuieric.huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Tishko.Araz@amd.com
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

On Wed, Aug 5, 2026 at 6:23=E2=80=AFPM Eric Huang <jinhuieric.huang@amd.com=
> wrote:
>
> new api will be used to workaround a HW scheduler issue
> for 100% usage when gpu has no workload.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 23 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  5 ++++-
>  3 files changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index b96f94e5169f..421d937c1188 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1140,6 +1140,29 @@ void amdgpu_mes_free_gang_ctx_index(struct amdgpu_=
mes *mes,
>         amdgpu_mes_unlock(mes);
>  }
>
> +int amdgpu_mes_notify_unmap_queue(struct amdgpu_device *adev)
> +{
> +       struct mes_misc_op_input op_input =3D {0};
> +       int r;
> +
> +       op_input.op =3D MES_MISC_NOTIFY_WORK_ON_UNMAPPED_QUEUE;
> +
> +       if (!adev->mes.funcs->misc_op) {
> +               dev_err(adev->dev, "mes notify unmap queue is not support=
ed!\n");
> +               r =3D -EINVAL;
> +               goto error;
> +       }
> +
> +       amdgpu_mes_lock(&adev->mes);
> +       r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
> +       amdgpu_mes_unlock(&adev->mes);
> +       if (r)
> +               dev_err(adev->dev, "failed to notify unmap queue.\n");
> +
> +error:
> +       return r;
> +}
> +
>  #if defined(CONFIG_DEBUG_FS)
>
>  static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *u=
nused)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index 977c057dcce8..5230b1ba1a46 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -366,6 +366,7 @@ enum mes_misc_opcode {
>         MES_MISC_OP_WRM_REG_WR_WAIT,
>         MES_MISC_OP_SET_SHADER_DEBUGGER,
>         MES_MISC_OP_CHANGE_CONFIG,
> +       MES_MISC_NOTIFY_WORK_ON_UNMAPPED_QUEUE

What's the minimum fw version which supports this?  We need to check
so we only use it when supported.

Alex

>  };
>
>  struct mes_misc_op_input {
> @@ -643,4 +644,7 @@ int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes=
 *mes,
>                                     uint32_t *index);
>  void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,
>                                     uint32_t index);
> +
> +int amdgpu_mes_notify_unmap_queue(struct amdgpu_device *adev);
> +
>  #endif /* __AMDGPU_MES_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index a0b874c9ee7b..bc0ee6ccfca7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -957,7 +957,10 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
>                 misc_pkt.change_config.option.bits.limit_single_process =
=3D
>                                 input->change_config.option.limit_single_=
process;
>                 break;
> -
> +       case MES_MISC_NOTIFY_WORK_ON_UNMAPPED_QUEUE:
> +               misc_pkt.opcode =3D MESAPI_MISC__NOTIFY_WORK_ON_UNMAPPED_=
QUEUE;
> +               misc_pkt.queue_sch_level =3D AMD_PRIORITY_LEVEL_NORMAL;
> +               break;
>         default:
>                 drm_err(adev_to_drm(mes->adev), "unsupported misc op (%d)=
\n", input->op);
>                 return -EINVAL;
> --
> 2.34.1
>
