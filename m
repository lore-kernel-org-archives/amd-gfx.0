Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC984C61DD3
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 18:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B8D610F733;
	Thu,  3 Sep 2026 18:26:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ePvsf2kT";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF69410E173
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 18:26:00 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2d8f2ed7bdcso135075ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Sep 2026 11:26:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788459960; cv=none;
 d=google.com; s=arc-20260327;
 b=iqo5Tsgd9yHJC+V3CwxsMxUfSzK74tQzw76v3LYLSRLRJwM8mY75DzAKmH0AkS6nAK
 1PPxYqfC4F72FEWGhUBM4gQncKP+1/1xFeqO94UMzpPQhoBJZsrVK/aAMHRiClHZWEZ0
 uFuAwQx65+L5wbPmRVSme8vQV27m5txSQsZCUtjrb/QCvG1Xl0ConwloXP60vpvsobXu
 e7uBNV8rTIq0vN9ZU1cXpeKkbFgkRYkPnXGb8xGxe6qtbBLhaIfK6QjqWHQzNeZouopv
 fvqehXZ2jJPrKbbNnGZIpPV98eP7dZ4k6RgJKCct2aakpyfP4wzazBdYyMZbCB0W8kEK
 6REg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Hmlf8I8YEN0AlNaiaVx5sCTZRzyPtBS7pbXhSt7OH9w=;
 fh=pVXkSRI4iWxMX2nwzh6GHNF3uSMfA8RBUzqfkxIWt8U=;
 b=MuUQt7ZddnykDulb3PGvkbBdPX8G3ZO1tNueEC/FOUnBzvTlCJZNgYfhv+i9c0hMgj
 J1IgMl5/2kf3lec9HcbplZ8cq8d5XC0oJ5eZsldXK4P0S3wVDSeesmxETj1+el27g8nE
 /45NfzpzQKP4DntHsd6PuJricKuG30Fbi1nIbIB3wJhygBUvneMvNFf8eQERFAhiZ17U
 d0KtJFy83C6RMJSRxMn33TA2oqrbGpdW7muNaG+3zDluhZdWAFIQAswXjUI5NTsrgv7+
 rGH3NG4wu0mmNg0S1193ySbV99NAE0xp0FseqRiZwMM9V8JpIR7F6V2XmN7QDyqZ8iAP
 GEgg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788459960; x=1789064760; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Hmlf8I8YEN0AlNaiaVx5sCTZRzyPtBS7pbXhSt7OH9w=;
 b=ePvsf2kT4Z16zi12GSXtVie4rFrzL7llGsW6pRsrp3tCKmxj/s/xOokQFYHccMgf1g
 1JPE8DNXAGgvAfq4rgW4LSFadhm8hL2582ZlkE/BKfPMDEJt6zfM9W0KqRtWtF5U0AKh
 QWiBcuOwQCkbfuVuD4Le/A+kWbCDHtyqbLd+2IW4C9spCeV3hZO4QlW0Em5rQ1ZO6Jz1
 e/hyHZvluXjCXETe25mAc/iCXER47m4CiCoM8wXhmyXhfadRpSrrWeUna2keenxW1G/l
 qZfcWoCfMxUBu9lbHKpFHCOw1R9NYnjqJDZZidkcqoJhlGO6Vyd4zcXlpdGNdd+q+sFy
 f12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788459960; x=1789064760;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hmlf8I8YEN0AlNaiaVx5sCTZRzyPtBS7pbXhSt7OH9w=;
 b=FYaVod2mAkn2BeHhiKwfpZehyOn+w0z+EFYfgjqcxuRlZ+UY1p0wnlP14LCf2m14mC
 evpJkRHe42JXmi9Ub/zbpODSPlkqai7CUHHjNGY+NgDGXR15ZK4SwYtQBLs8EFu+fiyw
 Zx6z2d2KJAebx0B+PCCdn37CPThuGUnoTeXB7bychti8bw3hzSyHEZBK8MMq2CrQEE5h
 XquhlGHd4W8BPN3OMcuB7UkurUKdrTY3OjMHIJ+62nUYeAuKb/y8XW8NpvPv5gW6sieJ
 uQqgOMCLC445e8Sm/b8PwvO1a/vH/UuwVpF5KEdcAUujKJDZA5SmwieXNG+lXesZgOmT
 PqfA==
X-Gm-Message-State: AFuF++m7nQjUo8Ojdzp0RPcbF/12fNnHU4qtA2/S1fFngDidWD1qWfwd
 /QfaRmX7En1dFb9jPi7Fg+1YKEmYEEAyIn3noRxdc2bDCzIkvgG7KN2Vznc8NOnT5OmNqg7zNR9
 cpY1vG7KaVlbB+sj9ltvcPl6eftzLlUg=
X-Gm-Gg: AYBFou2e+EZbFsWkmJbJJdaO2VQrh83MKDcLmP7OWgCoEiq4gryNSWB6Ac+d3/te/if
 kpbcCTbg7fOm812ZF8W+mcwEGYX3OOuNod4ezfl+9f/imyjwZwSxiktS1+qz1f28aevUo+FFcSP
 craUo8BK4bRGB3T8qXmo4fIVGJjnEAf/y3SXQaCHelvwtUBXZwLJjhVyKsXMes3S+I7NWmPq4EI
 X4O2BG06cc/TalIpROW3cknqv+XZldIUrWA6I75P5r/8m3lVuSZmy8v+gXNs4llBbW0UNeg59xh
 MLpnWu8ZUm3EDx+X3rh53a6Llj3/6O6NlzSALENn/YAOUTO1D59pFjfKphlf7gsDWhhscBX7AL+
 9oVXopA0EcvIFdXH9iD4/VWmZxxvALWs=
X-Received: by 2002:a17:90b:3b8c:b0:398:bad2:c0f with SMTP id
 98e67ed59e1d1-39b262ce785mr263165a91.5.1788459960151; Thu, 03 Sep 2026
 11:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260903094438.3880682-1-Jesse.Zhang@amd.com>
 <20260903094438.3880682-4-Jesse.Zhang@amd.com>
In-Reply-To: <20260903094438.3880682-4-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 3 Sep 2026 14:25:47 -0400
X-Gm-Features: AcwNN1VJ6F2HAYQDOJoeVwf4GeslU3Zg2Z8n3jRBCOCCu5LRrLDOwgfV5YC4V0I
Message-ID: <CADnq5_O9TP0H0hM83oDC9j+yfmHVyvUPv2_74WTx7iGNKPVwEQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amdgpu/userq: reset a hung SDMA user queue over
 MMIO
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Thu, Sep 3, 2026 at 6:20=E2=80=AFAM Jesse Zhang <Jesse.Zhang@amd.com> wr=
ote:
>
> A hung SDMA user queue wedges MES, so the MES packet reset times out and
> falls back to a full MODE1 reset - once per in-flight job, a reset storm.
>
> The queue is still on its HW slot at the first hang-detect, so use
> detect_hung_queue to recover its slot from the doorbell and reset it over
> MMIO, which does not need MES. Mark it HUNG (not UNMAPPED) so the restore
> worker does not re-map and re-run the guilty job, and short-circuit the
> per-fence hang-detect re-entry once the queue is already reset.

I thought newer versions of MES firmware handled this.  Maybe we need
a firmware version check?  For now, the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 48 ++++++++++++++++++----
>  1 file changed, 39 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 46ebc002548d..2ce94cd04fd5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -213,26 +213,56 @@ int mes_userq_reset(struct amdgpu_usermode_queue *q=
ueue)
>         struct mes_reset_queue_input queue_input;
>         int r;
>
> -       /* XXX: add a FW version check for SDMA per queue reset */
> +       /* already reset by an earlier job's hang-detect; just signal and=
 bail */
> +       if (queue->state =3D=3D AMDGPU_USERQ_STATE_HUNG) {
> +               amdgpu_userq_fence_driver_force_completion(queue);
> +               return 0;
> +       }
> +
>         memset(&queue_input, 0x0, sizeof(struct mes_reset_queue_input));
>         queue_input.doorbell_offset =3D queue->doorbell_index;
>         queue_input.queue_type =3D queue->queue_type;
>
> +       /*
> +        * The MES packet reset fails once the hung queue wedges MES. For=
 SDMA the
> +        * queue is still on its HW slot, so reset it over MMIO instead: =
recover
> +        * the (instance, queue_id) slot from the doorbell.
> +        */
> +       if (queue->queue_type =3D=3D AMDGPU_HW_IP_DMA &&
> +           adev->sdma.instance[0].funcs &&
> +           adev->sdma.instance[0].funcs->detect_hung_queue) {
> +               u32 instance, hw_queue_id;
> +
> +               if (adev->sdma.instance[0].funcs->detect_hung_queue(adev,
> +                               queue->doorbell_index, &instance, &hw_que=
ue_id)) {
> +                       queue_input.use_mmio =3D true;
> +                       queue_input.me_id =3D instance;
> +                       queue_input.queue_id =3D hw_queue_id;
> +               } else {
> +                       dev_warn(adev->dev,
> +                                "SDMA userq (doorbell %llu) not on any H=
W slot; falling back to MES reset\n",
> +                                queue->doorbell_index);
> +               }
> +       }
> +
> +       /* HUNG, not UNMAPPED: the guilty job is still in the ring, so th=
e
> +        * restore worker must not re-map and re-run it.
> +        */
> +       queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> +
>         amdgpu_mes_lock(&adev->mes);
>         r =3D adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
>         amdgpu_mes_unlock(&adev->mes);
>         if (r)
>                 return r;
>
> -       /* mes_userq_unmap() does not update queue->state; mark it UNMAPP=
ED so the
> -        * destroy path does not issue a second REMOVE_QUEUE for the remo=
ved queue.
> -        */
> +       /* drop the queue from MES and force-complete its fences */
>         r =3D mes_userq_unmap(queue);
> -       if (!r) {
> -               trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STAT=
E_UNMAPPED);
> -               queue->state =3D AMDGPU_USERQ_STATE_UNMAPPED;
> -       }
> -       return r;
> +       if (r)
> +               return r;
> +
> +       amdgpu_userq_fence_driver_force_completion(queue);
> +       return 0;
>  }
>
>  int mes_userq_reset_queue(struct amdgpu_device *adev,
> --
> 2.49.0
>
