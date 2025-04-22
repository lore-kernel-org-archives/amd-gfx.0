Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F81C369C2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 13:25:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24E0310E59A;
	Tue, 22 Apr 2025 13:25:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T3+JUvYz";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1FF610E59A
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 13:25:52 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b01d8d976faso317792a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 06:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745328352; x=1745933152; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MUzemUBnMpV3Ry3+nLDrwijz5rbusCoaSHWrRFUaRJ8=;
 b=T3+JUvYzS2oGug1PTOtJH6QdGxaUayidRWAeJzAVuJQm0XhLlaorvOBHoYEw2+ty+0
 Bd9Tf0vHsq9MjHUqRS6I0+H8ymXhMndhEJOEciwlLZdobW88z2IQKFBzjrJJXGKoPKIN
 3eFY9JiwLYPsVB4khuk4Xlzca1JPo+2iGJ06TWcOsu/m5EluczF5bAZnU5Ivg+NZrbWc
 bqp1s8Su83M39hT3Tcppex0HFW45kvzOXgkr9b2w/akjhRjNurhXSXn8LVoYU+srJPoa
 AhHtnz4V8G46VrFRIvUDLqPAgdvvL4MIIzjWcT/fIF34wg/HC/A39Edw3YM42ERAPU+L
 Krbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745328352; x=1745933152;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MUzemUBnMpV3Ry3+nLDrwijz5rbusCoaSHWrRFUaRJ8=;
 b=Vl0EMqZArp+82YZ/5IqIRfO49fIk29zV0DdCEraV6vrFksQYbhsgsIDHcp5i6Le9Wk
 LrcIB2XIGCV8ypBNt8HcrbA4PDMZKBh7h8rUUw60LMPocPMGTGuCBaAgzdIYVVcaNsN1
 IyuQ6Prdu/H+wslH5GpXH/939HJBdXhlW7Nq/yxevhzowkMXyoEik8m+GL5CYQ7iNA/V
 MST2G/IykENTIdUkrvgZ7JEmtJMPZea9mNpvceSoeBUpTcj6TgJn9KYq/g1Nl2rLhqWj
 cvCO6b9N4Tp9wMvHcI7htLrGX+zDqmkqbwPLlEVW+grTW322ROp4G+7on6wYvhGYs3Ub
 qIig==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3CleAxJGp2XeoSf8VKmSGuhV50AF/CxpNMgb8je62JTvexZXt37ajHr9vCDzMWOQy+fhWdu6V@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzrEJs6581qKVFqqC+S8YsV1HLEFIkKn8hL9b6XYhe6zDv/vl+D
 dNPen13WUsR7zkE4qusp+0F8qrmQlxluJ+kfnTS/9f9pyOV6x22gSJJYofm0lfmcHckNiASl+ap
 OFqUwiJarJPIF2BxLefPjEyMVYEE=
X-Gm-Gg: ASbGncu/Vg4svJXQlFN1rCMcyToWSRr5amQDs+R8Ht/iBXWULBoNbBnpaegkJ+4INJD
 F67PR6e5PCAFZ9OGQPTXsSOf5sg1wjEj1fzS89kP6kPvk7xHaJXywOL/zVAiVKEGijO0jFAq8ES
 aEQXqDAHHUSKmfI75YekMcMA==
X-Google-Smtp-Source: AGHT+IHPf+wCWEIf/EjWJgHv8KY58Mw7ruMIMvEqR2uS4aC++EvRu6YRopkpAfLID2uShGc3RuYfdX0uKcfbhbSPqx0=
X-Received: by 2002:a17:90b:3b8d:b0:2fe:b77a:2eba with SMTP id
 98e67ed59e1d1-3087bb426aemr9264593a91.1.1745328352106; Tue, 22 Apr 2025
 06:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250421222427.392362-1-siqueira@igalia.com>
In-Reply-To: <20250421222427.392362-1-siqueira@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Apr 2025 09:25:39 -0400
X-Gm-Features: ATxdqUE6rNTfHapuLu7M87n7acvJCuGWaFFkxdPuCYY3_VFlYTJfzdZKENrJU8g
Message-ID: <CADnq5_NUzggmAmf3nSpOp0r3gnSLWiDM0rc6Cy2Y5yXFvkSXuw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Add documentation to some parts of the
 AMDGPU ring and wb
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, amd-gfx@lists.freedesktop.org, 
 kernel-dev@igalia.com
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

On Mon, Apr 21, 2025 at 6:24=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> Add some random documentation associated with the ring buffer
> manipulations and writeback.

I think this will result in documentation warnings if not all of the
elements in the structure are documented?  If so, maybe it would be
better to make then as regular comments rather than kerneldoc.

Alex

>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 28 +++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 37 ++++++++++++++++++++++++
>  2 files changed, 64 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index cc26cf1bd843..6d2ae8d027e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -522,9 +522,35 @@ int amdgpu_file_to_fpriv(struct file *filp, struct a=
mdgpu_fpriv **fpriv);
>
>  struct amdgpu_wb {
>         struct amdgpu_bo        *wb_obj;
> +
> +       /**
> +        * @wb:
> +        *
> +        * Pointer to the first writeback slot. In terms of CPU address
> +        * this value can be accessed directly by using the offset as an =
index.
> +        * For the GPU address, it is necessary to use gpu_addr and the o=
ffset.
> +        */
>         volatile uint32_t       *wb;
> +
> +       /**
> +        * @gpu_addr:
> +        *
> +        * Writeback base address in the GPU.
> +        */
>         uint64_t                gpu_addr;
> -       u32                     num_wb; /* Number of wb slots actually re=
served for amdgpu. */
> +
> +       /**
> +        * @num_wb:
> +        *
> +        * Number of writeback slots reserved for amdgpu.
> +        */
> +       u32                     num_wb;
> +
> +       /**
> +        * @used:
> +        *
> +        * Track the writeback slot already used.
> +        */
>         unsigned long           used[DIV_ROUND_UP(AMDGPU_MAX_WB, BITS_PER=
_LONG)];
>         spinlock_t              lock;
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.h
> index ec4de8df34e7..20805dacd66c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -241,6 +241,9 @@ struct amdgpu_ring_funcs {
>         bool (*is_guilty)(struct amdgpu_ring *ring);
>  };
>
> +/**
> + * amdgpu_ring - Holds ring information
> + */
>  struct amdgpu_ring {
>         struct amdgpu_device            *adev;
>         const struct amdgpu_ring_funcs  *funcs;
> @@ -255,10 +258,44 @@ struct amdgpu_ring {
>         u64                     wptr;
>         u64                     wptr_old;
>         unsigned                ring_size;
> +
> +       /**
> +        * @max_dw:
> +        *
> +        * Maximum number of DWords for ring allocation. This information=
 is
> +        * provided at the ring initialization time, and each IP block ca=
n
> +        * specify a specific value.
> +        */
>         unsigned                max_dw;
> +
> +       /**
> +        * @count_dw:
> +        *
> +        * Count DWords: this value starts with the maximum amount of DWo=
rds
> +        * supported by the ring. This value is updated based on the ring
> +        * manipulation.
> +        */
>         int                     count_dw;
>         uint64_t                gpu_addr;
> +
> +       /**
> +        * @ptr_mask:
> +        *
> +        * Some IPs provide support for 64-bit pointers and others for 32=
-bit
> +        * only; this behavior is component-specific and defined by the f=
ield
> +        * support_64bit_ptr. If the IP block supports 64-bits, the mask
> +        * 0xffffffffffffffff is set; otherwise, this value assumes buf_m=
ask.
> +        * Notice that this field is used to keep wptr under a valid rang=
e.
> +        */
>         uint64_t                ptr_mask;
> +
> +       /**
> +        * @buf_mask:
> +        *
> +        * Buffer mask is a value used to keep wptr count under its
> +        * thresholding. Buffer mask initialized during the ring buffer
> +        * initialization time, and it is defined as (ring_size / 4) -1.
> +        */
>         uint32_t                buf_mask;
>         u32                     idx;
>         u32                     xcc_id;
> --
> 2.49.0
>
