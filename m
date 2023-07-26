Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13017C001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 13:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88C6B10E475;
	Wed, 26 Jul 2023 13:03:48 +0000 (UTC)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D98310E475
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 13:03:47 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-56584266c41so4089968eaf.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 06:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690376626; x=1690981426;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qil2uhPhZihxHAq85GncbW1TuyXdjotK8uhL+2VQQN8=;
 b=XQhnO9jXs6nSY9ZnrB22+9Q5YgGyFgCylmMa6jS5JvFkVI78+iy1bQ+CHMkJ8IcEJK
 OzDdd/wbHI02ZoG+Sp3JjnzrSPkOIu/lE3krXYGY4psPFhX6meauIiRRhrCaEXleo5p4
 swjKMbSJo3R8Vjuf7HLHmwbHT10u9W+t29c4drAhP0KCbM2ZmEOvu5fbIFRsiSB6hqED
 EBl/M+Q2PT7mQF+o5RpbAkBs5F7UIxgunKETlzQgHgGF8GskrZ2zNUgvLUK/eHokDpsR
 RXEvnmv++1LosmrjDra+jCjo3bGP1zsCTzKRohQ2OkZBYVVLPuoi5MPvAo+WN7Fvvp95
 Kukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690376626; x=1690981426;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qil2uhPhZihxHAq85GncbW1TuyXdjotK8uhL+2VQQN8=;
 b=eCJqLedEwWbugEH5sIN8r10FlT0rt2GQgFRlRi3JUReOmp1Gtm9gKSSy7RaE9URTG2
 69nTlssgxiXELFXdNsKb77LpQQQPYaX99Hvb8M48/rCx5rHti4uqJiMaWhJwitxbdzvU
 HSB4hMwpnTV26AxNUpI3A89eBHwvPl3gjMSnkdnPoAsudV1gYAX0Y4D+bKbC8eqZWgf0
 b0+tytwILbfQOH9zqBrfOsEusUE9lBzPFxmEMPNUChjKMNlg1oehOcH2vvKcVhSmbyhh
 cCik7hubvC/YM17Bn1RF7zgP1iIxDhZafiPrn95njKCGRDs5N8EIuWeSZAVMqrzE+Ci4
 qlIA==
X-Gm-Message-State: ABy/qLbSiEPheK/tAd0o1L5B6S+G2E5K20CXu7Ir1xGODlkAUqONK3m8
 Axh2bpUlDTzQvakaKeCUQcDRNimmzcgnI/ugcUs=
X-Google-Smtp-Source: APBJJlExnvegeUTQcKvL5yazb6JuPrPLIgCEi7Oj5XpjV/NqcrSXhlb5oUGp9shWAFlGJ3ZbpphizZ7yOAsoje3rIdg=
X-Received: by 2002:a4a:344a:0:b0:566:f763:8fb7 with SMTP id
 n10-20020a4a344a000000b00566f7638fb7mr1437144oof.2.1690376626319; Wed, 26 Jul
 2023 06:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230726082411.3861012-1-jiadong.zhu@amd.com>
In-Reply-To: <20230726082411.3861012-1-jiadong.zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Jul 2023 09:03:35 -0400
Message-ID: <CADnq5_Peb5a-jiDXfPSFFSE45wam_qagBq_bphYBsiVH42kcmQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: set completion status as preempted for the
 resubmission
To: jiadong.zhu@amd.com
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

On Wed, Jul 26, 2023 at 4:24=E2=80=AFAM <jiadong.zhu@amd.com> wrote:
>
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
>
> The driver's CSA buffer is shared by all the ibs. When the high priority =
ib
> is submitted after the preempted ib, CP overrides the ib_completion_statu=
s
> as completed in the csa buffer. After that the preempted ib is resubmitte=
d,
> CP would clear some locals stored for ib resume when reading the complete=
d
> status, which causes gpu hang in some cases.
>
> Always set status as preempted for those resubmitted ib instead of readin=
g
> everything from the CSA buffer.
>
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h | 9 +++++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c        | 4 +++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ring_mux.h
> index b22d4fb2a847..d3186b570b82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> @@ -56,6 +56,15 @@ enum amdgpu_ring_mux_offset_type {
>         AMDGPU_MUX_OFFSET_TYPE_CE,
>  };
>
> +enum ib_complete_status {
> +       /* IB not started/reset value, default value. */
> +       IB_COMPLETION_STATUS_DEFAULT =3D 0,
> +       /* IB preempted, started but not completed. */
> +       IB_COMPLETION_STATUS_PREEMPTED =3D 1,
> +       /* IB completed. */
> +       IB_COMPLETION_STATUS_COMPLETED =3D 2,
> +};
> +
>  struct amdgpu_ring_mux {
>         struct amdgpu_ring      *real_ring;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index fc179e5f8dc1..272f206042bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5169,7 +5169,6 @@ static void gfx_v9_0_ring_patch_cntl(struct amdgpu_=
ring *ring,
>                                      unsigned offset)
>  {
>         u32 control =3D ring->ring[offset];
> -
>         control |=3D INDIRECT_BUFFER_PRE_RESUME(1);
>         ring->ring[offset] =3D control;
>  }
> @@ -5226,6 +5225,9 @@ static void gfx_v9_0_ring_patch_de_meta(struct amdg=
pu_ring *ring,
>                 de_payload_cpu_addr =3D adev->virt.csa_cpu_addr + payload=
_offset;
>         }
>
> +       ((struct v9_de_ib_state *)de_payload_cpu_addr)->ib_completion_sta=
tus =3D
> +               IB_COMPLETION_STATUS_PREEMPTED;
> +
>         if (offset + (payload_size >> 2) <=3D ring->buf_mask + 1) {
>                 memcpy((void *)&ring->ring[offset], de_payload_cpu_addr, =
payload_size);
>         } else {
> --
> 2.25.1
>
