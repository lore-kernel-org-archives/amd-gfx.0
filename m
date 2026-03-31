Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDA910F92E0
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 16:20:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B225410E712;
	Tue, 31 Mar 2026 16:20:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="loKpqCG7";
	dkim-atps=neutral
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46C5010E712
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 16:20:30 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2bd801b4078so338917eec.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 09:20:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774974029; cv=none;
 d=google.com; s=arc-20240605;
 b=PWjOKYt4phNQ9MC04S+twhhURolaEFfbYi6XjBSJhsN5BinLkytTx0tjiHfd8euhTX
 2a695O3ZtcWi0YsyJXyzYNkj39ri7WKXnPYYNIMb/iRh4mq9aDlCh5RG6uYuij1M3J0d
 k/P1B6dbxwk4URwN2Cg+muA4589gx75k18dS1bBEHEh3f2WD61SCBCCGUtnOAk0Ibvzl
 1dQzD3DyyavwZzuW5nmRGcJU8yLI0rBUCB7ammDABXRmftBz1CFeg2UH+Y0DyaA7KxK0
 TChZ/PT48NysnI/m9ULHa1/M763ZgtRsi+QYkqqwBLaVh7JTyvd89UURI4USj5kVQEaq
 PqNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hJr/JuiaXQ0CZ2jVJckdBtoZq5th9cS0BYwsTbX6X8E=;
 fh=5/FDHmCDSK8XEPPNaPWLb6eKx52Erxl9W0yrYZ/YtLE=;
 b=FjboOPF9aFFO9Ozcmnh6zy/Ac/agbq47Iqp1NalfwD72PSlYZbF3vuUOtYSX9QWCOC
 4UeY184Yy4tLLE+L/ucZlAx3+qAQipUR/m7dMGv3z3AR8qPzEWGMo3idTdKoXwPxN8tE
 LglfOJzBkRAIs8mUkZaqTa8IV44v2PqeRDf/VV1GdW8bCi4rMh0yLsguaRdUjbwLv56s
 1TjfgEZrc2kOOfeWrDmklVTmBDrlT1i1WCUQfC5IJryfPj7i7WP3nRPM4ccUnK4y2QxW
 c3sGaG4OnusgVVKtCX6Gfe24s7U+NS/bAQHANPOeTi2b4qEedTA6fFIdzhjh31iyLVxh
 gQ1g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774974029; x=1775578829; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hJr/JuiaXQ0CZ2jVJckdBtoZq5th9cS0BYwsTbX6X8E=;
 b=loKpqCG7ApqHa2xv/D47kVflQw9BvK6h8EFdbLD/HCPnrB8Ka0dQOxogKMhgsKCdYr
 bY1HSDMY1c6l5pQqbnys13CJCD8Rv2ZeZYde18r6Uf8qbhEO9Nbvp4qtJSiZ2nAdK/f0
 bWpLuPOgoKUsxmfmEC7zpj44FvfKMeD5sN0rv8R9N3tZ456CR1drN9RDFhahrit6M1Fi
 eniYPW75XL6E7UVPw2F1m0nTaIgHLdYZphgRkEFLPtbNYDQ8fRveWsD7Koyrgarb8/l3
 Jq81xZYS7ZhtcKY8BCmWhM5fiDP18ak00IIp+FvEeq+ufdXM4ajl+3vgxMcHYW5dyLnt
 9Q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774974029; x=1775578829;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hJr/JuiaXQ0CZ2jVJckdBtoZq5th9cS0BYwsTbX6X8E=;
 b=E2WXsOmP7GQiJpSV2mCYwVh7hFQlBAY5iXqSEIqATYULMSz86QKxtvzHnT+wmLoUBF
 rD2yQP7y55QgDXwfXFcLnQhMIFNI2UwLSpM7F1LNqTkBwh6b3O+gX0b7XK+EXsGqqWYY
 8a7rdDEJxRHXu33WWq6NUIRdBZEoeoJJ5IuEzPDOQeFpr//KYEtijk9jij7ROQp5oDuk
 DT9alGTSZ1kvLwZJToKFsO12jCXxyxBOzw23kBsSdiIklzOG3dg0h86HLriIpmoZaQGg
 ZtQJbhi4FrbgjiRDchXa/RkXmoQfiqsGviN6+jnp8QFX9E6GxAPskHsjDKY3Ggug7/Xy
 93/A==
X-Gm-Message-State: AOJu0YzQUo8naLKbwVhmwMNpcKT4AXTe+Zel8Ht8eLYw2iQbr7+qfr04
 zx2/YOg3C5MB8KN2kBv777b07g80Qtr95s2mv5Orf8z9DEC7+Dcvl9rfUPyLqth8BLTH8LkXYxG
 6Y9A77XGyhshw1QOM0d1KxaU/fOyeDyU=
X-Gm-Gg: ATEYQzw7nVbIgt2sNvly5Or/RrFPigJt3GPcWYXhta4IAKbUskZDLS88wL6nLX+Jf5B
 PAlQFUfbrudrg1EkcrHV+fbgE6lzUDr+IlbMlEXpAW5CTKdAqoQffZlFJQODA04jMTLNLinx6mH
 yIV3Ocl5X9QDTsaUe7+UFfmqbVvVNCRsdWFIi9uhKB+aqK/a2jB7wBpnL2a1gPbKv42XyavCsRN
 6I3dwXL9zlTrlTnCoiDhyiWM1xODrTJSgRUEsY19fjhv7BlFhbCg22n1oup+kEIaqkEMbsufP5K
 8XWxhgjpr+4vbe5lTMSP9WdsS/sd7I38h61WBKpbo70yXHO6InNfL0VnUE9GKvxr5u3juA==
X-Received: by 2002:a05:7022:e1e:b0:128:d7b3:6c52 with SMTP id
 a92af1059eb24-12be64c327fmr34737c88.4.1774974029233; Tue, 31 Mar 2026
 09:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260327203152.1578828-1-Amber.Lin@amd.com>
In-Reply-To: <20260327203152.1578828-1-Amber.Lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 Mar 2026 12:20:18 -0400
X-Gm-Features: AQROBzBtDmJ2nvSimpVv6Jz312vDRRiRZJ2R4UqJd2jq_zgCzoKwl1447ZLhk9Q
Message-ID: <CADnq5_Pm1ArB7odhzTo7Ssc+BX7z0wn+AyjotWcbjmxevE8UDA@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] drm/amdgpu: Create hqd info structure
To: Amber Lin <Amber.Lin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Jonathan Kim <jonathan.kim@amd.com>
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

On Fri, Mar 27, 2026 at 4:33=E2=80=AFPM Amber Lin <Amber.Lin@amd.com> wrote=
:
>
> Create hung_queue_hqd_info structure and fill in hung queses information
> passed by MES, including queue type, pipe id, and queue id.
>
> Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 17 +++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 13 +++++++++++++
>  2 files changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index f1f8bbfc31e0..436a46ba1dfa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -447,7 +447,7 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct am=
dgpu_device *adev,
>  {
>         struct mes_detect_and_reset_queue_input input;
>         u32 *db_array =3D adev->mes.hung_queue_db_array_cpu_addr[xcc_id];
> -       int r, i;
> +       int hqd_info_offset =3D adev->mes.hung_queue_hqd_info_offset, r, =
i;
>
>         if (!hung_db_num || !hung_db_array)
>                 return -EINVAL;
> @@ -471,6 +471,12 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct a=
mdgpu_device *adev,
>                 return r;
>         }
>
> +       if (r && (queue_type !=3D AMDGPU_RING_TYPE_COMPUTE)) {
> +               dev_err(adev->dev, "MES resetting queue type %d is not su=
pported\n",
> +                               queue_type);
> +               return r;
> +       }

I think the message here is a bit confusing.  The MES can reset other
queue types, this is just the fall back case for when MES queue reset
has failed.  Also, does MES populate the doorbell array for all queue
types regardless of whether the reset was successful or not?  If so,
shouldn't we bail for non-compute queues after the doorbells are
populated?

Alex

> +
>         *hung_db_num =3D 0;
>         /* MES passes hung queues' doorbell to driver */
>         for (i =3D 0; i < adev->mes.hung_queue_hqd_info_offset; i++) {
> @@ -486,13 +492,8 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct a=
mdgpu_device *adev,
>                 return r;
>         }
>
> -       /*
> -        * TODO: return HQD info for MES scheduled user compute queue res=
et cases
> -        * stored in hung_db_array hqd info offset to full array size
> -        */
> -
> -       if (r)
> -               dev_err(adev->dev, "failed to reset\n");
> +       for (i =3D hqd_info_offset; i < hqd_info_offset + *hung_db_num; i=
++)
> +               hung_db_array[i] =3D db_array[i];
>
>         return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index f80e3aca9c78..2e6ae9f84db0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -170,6 +170,19 @@ struct amdgpu_mes {
>         uint64_t            shared_cmd_buf_gpu_addr[AMDGPU_MAX_MES_INST_P=
IPES];
>  };
>
> +struct amdgpu_mes_hung_queue_hqd_info {
> +       union {
> +               struct {
> +                       uint32_t queue_type: 3; // queue type
> +                       uint32_t pipe_index: 4; // pipe index
> +                       uint32_t queue_index: 8; // queue index
> +                       uint32_t reserved: 17;
> +               };
> +
> +               uint32_t bit0_31;
> +       };
> +};
> +
>  struct amdgpu_mes_gang {
>         int                             gang_id;
>         int                             priority;
> --
> 2.43.0
>
