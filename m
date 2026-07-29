Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D99C54F51
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 14:54:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEED010E055;
	Wed, 29 Jul 2026 14:54:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fYX5LdEb";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF85310E055
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 14:54:06 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-37f9e2642deso101190a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 07:54:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785336846; cv=none;
 d=google.com; s=arc-20260327;
 b=Izye7VJkndb7QN4ZLfbgYkvswYelSfIFPUtpgTBdHDhq/bwzhP6bkzXxKfDl1Xn0lt
 CX5GItA5PHwmhmHU3G97z9r62SqGihE7maPstjIw8GSMO1PaHDQ9zzgc00r8co1ofiHb
 Y6PkxB7dOR2I13vayItnNNBAdfj10PaCpVvkysT4bTWQWbgeVGZrpyE5qJn/D/9ZwwK9
 +IJw1xlb3wY3aDhBDqQ5oOngaR8dUdLCtDuZck8REFNMLw4mxT/4T305KcoblZbtZGJt
 LZJyCcN8p544XycwogKItGLwaZU/FSFI16hUUFnj6SDp9WQk1vnfljCAOxo0ngw8qYhh
 /h7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fa1Gj9IMVJwVqo1cLmchGTydmM9Qw/N4C4pLh0tagvc=;
 fh=12s9AzFoaj930220DjdvRKd8z3uNwmxHeDx0M05wOo0=;
 b=S/cmDmcEEI4EtWExs/dPLTIuAzH+NkA/F48Cg2dkAcsgtfax6jFUdd9mK5hb50sf1m
 c88lwvd1jmn2UJB94N+WJWGBtB0AfEbB30CxokG/tbwe3Zlko4H1HYbhg9LKOZxRWQuw
 ykLxiN3+AWY/R2SDFrsvRPBvGKlDoCM+CT1PCwHo7gFAoPn2N1hKUBsUozp9zR7sxOF7
 Mi897YGQi58LcQfFaS01lNvelSrVsWNDnSK8KXnanN15k69JGT1AUkpoSVhCfR6jqYMl
 kEd80cl0rQoArw8hd58F9MYs99IPGCn47ef2t4eplBEMf3tJ5B9JUDmTkR4McIfMcIx2
 FDJA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785336846; x=1785941646; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fa1Gj9IMVJwVqo1cLmchGTydmM9Qw/N4C4pLh0tagvc=;
 b=fYX5LdEbuR4/93iDjVkkAavlGfUTD+1T2d2ZexqeFgvX91hnlF5rViSxOUV9gPSMRv
 HNSSPy27w4he/k3f7kmuai1v2tKGkqU1r22nFMdcGBykIjZickMgJ39mGNP74pqdTVRj
 h6/kh9Kgpui1kAkrxZycdDuSAvjoxX0smj+K/Ka6UKETPrlaGHvwcxA8tXzMLU/pcyCA
 8ndVjsQ9hi7XoElWNzIfgdKcrmtFiVeepxf6CckFzAO1dHKTcfL3v/x0r/mDbk8HKRlz
 YxVesnAzraKquQorkX5kvvd+N9+lua2vTKAWn1LvnMyDc70VbUwH2Z9OflpO+skqg5e5
 1WbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785336846; x=1785941646;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fa1Gj9IMVJwVqo1cLmchGTydmM9Qw/N4C4pLh0tagvc=;
 b=sBvpIDdNQMfkOmiTwzGYD8k4SLxOvQeM9WkkmJQo0ZiOyhZgf2jTpKdYjm6w/Qp6df
 A6BIRVRUBbmxjNovoxCvgqeKp+odzlpcA8yzGkBwDOjtZdOOKbxDLd24dil2ULbnkvrU
 4dnH1hjelM6ln3lYpe/P8I955s1UFjbYWxKcjr+PIq55cKgWq58P888tEtXqhAT3s6hq
 7HcjTvHq7OPrrpZAbLKuwgRoMTjUpuKjIcJo+yH5wKRV25wNOlFxRPbkbSihFJP463dq
 3L6A5V5HzBFZYMvkHxzRI1X3C7X9YxG5sgVR55FjkFAHZoJkAojKyl7Qfs4mGmw9ph+Z
 u4kQ==
X-Gm-Message-State: AOJu0YzZ6iLJ/DvRAJpksvADrvHf/gn27yNvgTFfucgXMtlrtfEgW1Y4
 rCkE+JfgY0dnp4Jq+SMvfnO6/xwH/7gvTpV5B/xjbW8qFe4sP5nLf0S8XcfOnTUTEwqLvu31mpQ
 +Zx5qLfovlsR0t7sWpDY60d7XfQldu7o=
X-Gm-Gg: AR+sD11Ay+2H9zI08D8GebgjfzUecpFgFOXYnz9o0kkIBSGJe3vcu5P5Z0b9I72PggF
 OSUTs352RTWYUm8dnCnf2BCrUAcRl25Gu5xhEJ9pJkBx8ztjJfwZdVftGTM78whjNBO9PaFTBiu
 y3NBpwSHnzrA+JTJtYMOzYfgYgMEvvLK/rgDtpTl/ARWQeETOiN/vzIDXcygFGq4iC2+0gamJB0
 9khtYIW2P3gx+172aFc44hktcmpCkfm2bKHh+5ujcDX+cyU5BzDXAe+r03TENfQPXB5XmYyVnuY
 pADEv5x1cAYQ5pk3UTFwXKwTEME4gtie5hBQ+Wf2n3JeFYh6AO9yc6DJu1E2rL9hJhyFVGzSEHY
 /l1AH3nuv0JX1BOL/Rz8Xho+4hWwl8As=
X-Received: by 2002:a17:90b:17cb:b0:38e:55ec:e436 with SMTP id
 98e67ed59e1d1-38f6a0b11f1mr6620683a91.0.1785336846088; Wed, 29 Jul 2026
 07:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260722032152.2904563-1-Jesse.Zhang@amd.com>
 <20260722032152.2904563-2-Jesse.Zhang@amd.com>
In-Reply-To: <20260722032152.2904563-2-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Jul 2026 10:53:54 -0400
X-Gm-Features: AUfX_myqwt7oA1DTS2G_a9AS_sNvXOuRdS6hEP7fKWISV4gEtcDassgA5ZU4o-w
Message-ID: <CADnq5_PSNGpn35Fv_tVxD0XxMg1Lu887cbFMHqPG-E+z2Gn7+Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] drm/amdgpu/gfx11: recover gfx user queues on
 priv-fault
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>,
 Mario Sopena-Novales <Mario.Novales@amd.com>
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

On Tue, Jul 21, 2026 at 11:39=E2=80=AFPM Jesse Zhang <Jesse.Zhang@amd.com> =
wrote:
>
> If a priv/bad-op fault does not match a kernel queue slot, it belongs to
> a MES-scheduled user queue. Compute IVs carry the doorbell and use the
> existing path; gfx IVs do not, so record the faulted slot and let a
> worker read the doorbell back from the HQD (regCP_RB_DOORBELL_CONTROL),
> look up the user queue and reset it.
>
> Suggested-by: Mario Sopena-Novales <Mario.Novales@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 60 +++++++++++++++++++++++---
>  1 file changed, 55 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 0cbbdc3694f4..a802b0ac1544 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1601,6 +1601,8 @@ static void gfx_v11_0_alloc_ip_dump(struct amdgpu_d=
evice *adev)
>         }
>  }
>
> +static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work);
> +
>  static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>         int i, j, k, r, ring_id;
> @@ -1931,6 +1933,8 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>
>         mutex_init(&adev->gfx.mec.reset_mutex);
>
> +       INIT_WORK(&adev->gfx.userq_priv_fault_work, gfx_v11_0_userq_priv_=
fault_work);
> +
>         return 0;
>  }
>
> @@ -1968,6 +1972,8 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block=
 *ip_block)
>         int i;
>         struct amdgpu_device *adev =3D ip_block->adev;
>
> +       cancel_work_sync(&adev->gfx.userq_priv_fault_work);
> +
>         for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
>                 amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
>         for (i =3D 0; i < adev->gfx.num_compute_rings; i++)
> @@ -6707,10 +6713,47 @@ static int gfx_v11_0_set_priv_inst_fault_state(st=
ruct amdgpu_device *adev,
>         return 0;
>  }
>
> +/*
> + * A gfx exception IV carries no doorbell. For each faulted slot, read t=
he
> + * doorbell back from the HQD (left in place by the fatal fault), look u=
p the
> + * user queue and kick its per-queue reset.
> + */
> +static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work)
> +{
> +       struct amdgpu_device *adev =3D
> +               container_of(work, struct amdgpu_device, gfx.userq_priv_f=
ault_work);
> +       unsigned long slots =3D xchg(&adev->gfx.userq_priv_fault_slots, 0=
);
> +       unsigned int id;
> +
> +       for_each_set_bit(id, &slots, BITS_PER_LONG) {
> +               u8 pipe =3D id & 0x3;
> +               u8 queue =3D (id >> 2) & 0x7;
> +               struct amdgpu_usermode_queue *q;
> +               u32 db_ctrl, doorbell;
> +
> +               amdgpu_gfx_off_ctrl(adev, false);
> +               mutex_lock(&adev->srbm_mutex);
> +               soc21_grbm_select(adev, 0, pipe, queue, 0);
> +               db_ctrl =3D RREG32_SOC15(GC, 0, regCP_RB_DOORBELL_CONTROL=
);
> +               soc21_grbm_select(adev, 0, 0, 0, 0);
> +               mutex_unlock(&adev->srbm_mutex);
> +               amdgpu_gfx_off_ctrl(adev, true);
> +
> +               doorbell =3D (db_ctrl & CP_RB_DOORBELL_CONTROL__DOORBELL_=
OFFSET_MASK) >>
> +                          CP_RB_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT=
;
> +               q =3D xa_load(&adev->userq_doorbell_xa, doorbell);
> +               if (q)
> +                       amdgpu_userq_start_hang_detect_work(q);
> +       }
> +}
> +
>  static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
>                                         struct amdgpu_iv_entry *entry)
>  {
>         u32 doorbell_offset =3D entry->src_data[0] & AMDGPU_CTXID0_DOORBE=
LL_ID_MASK;
> +       u8 me_id =3D (entry->ring_id & 0x0c) >> 2;
> +       u8 pipe_id =3D (entry->ring_id & 0x03) >> 0;
> +       u8 queue_id =3D (entry->ring_id & 0x70) >> 4;
>
>         /*
>          * Try KQ first by ring_id (HW slot is authoritative). The
> @@ -6718,9 +6761,6 @@ static void gfx_v11_0_handle_priv_fault(struct amdg=
pu_device *adev,
>          * never share a HW slot.
>          */
>         if (!adev->gfx.disable_kq) {
> -               u8 me_id =3D (entry->ring_id & 0x0c) >> 2;
> -               u8 pipe_id =3D (entry->ring_id & 0x03) >> 0;
> -               u8 queue_id =3D (entry->ring_id & 0x70) >> 4;
>                 struct amdgpu_ring *ring;
>                 int i;
>
> @@ -6752,10 +6792,20 @@ static void gfx_v11_0_handle_priv_fault(struct am=
dgpu_device *adev,
>                 }
>         }
>
> -       /* No KQ matched: HW slot is a MES-scheduled user queue. */
> -       if (adev->enable_mes && doorbell_offset)
> +       /* No KQ matched: the faulting slot belongs to a user queue. */
> +       if (!adev->enable_mes)

I think this should be:

if (adev->gfx.disable_uq)
    return;

Same comment for patch 3.

> +               return;
> +
> +       if (doorbell_offset) {
>                 amdgpu_userq_process_reset_irq(adev, entry->pasid,
>                                                doorbell_offset);

If the doorbell offset is not provided, do we need to keep this code?
Same comment for patch 3.

Alex

> +       } else {
> +               /* GFX IVs lack the doorbell; record the slot and let the
> +                * worker read it back from the HQD.
> +                */
> +               set_bit(pipe_id | (queue_id << 2), &adev->gfx.userq_priv_=
fault_slots);
> +               schedule_work(&adev->gfx.userq_priv_fault_work);
> +       }
>  }
>
>  static int gfx_v11_0_priv_reg_irq(struct amdgpu_device *adev,
> --
> 2.49.0
>
