Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7465560A382A
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=THZAj6Rs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17DC610E1DA;
	Fri, 20 Nov 2026 17:30:13 +0000 (UTC)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 805F210E1DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 17:30:07 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-8628519366eso157238a34.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 09:30:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795195806; cv=none;
 d=google.com; s=arc-20260327;
 b=OIQkiJtJv22Q1j4kp1/veOwYJmfikrFI/4dcwHBiMyrJxlkEvkjh3/Cb4b0dAexEuS
 0tOGvH4dFFpBmtdPu7eiXSzhjUWGpN9qha67zCdCweIs8IvYvxJkXYi2qa6cB6rYtbBH
 FhuWtF4jVHHO+9fe9y9IU3t7G/kCTy2hVs/O6AAl4B4qbQeOnvvt7J/bD/x9AL/2qO/S
 jWtiOQNmn6YYuj1s/Q+S5wjHMMkBz0Eq7fWR65vl0EL/qjyT8iL+BJcmq6DnymVh4uoc
 PcJu1HU3l0rQfx4xRM/exaqWhyUzm53/HPwHs+wD4NSQQRutaVf9BzPihZ4Zp49rqGkb
 6zgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0n8SftTJ57yw2hK7VbVhby6HENyYsAqbRV5OCtUN0cI=;
 fh=7VO2fknfSwF5aT+H68ye2HXE4kwHZgu3Lu+8fELN4Os=;
 b=hU5yPhzzuzu5D2pejUVPdLcVnYIjquQbeeXiNeDPV/1O8JlzQ7KYWSXzXIwGyZUQA1
 8xYJkT8RSZAGwaNNdkxPciM/gekOWYpUxSVAZZbsMG14XpDylHd2OaAvzXT0Js9N7x59
 JREDkwi9SJpRAM6qul+dO44I7gVKKgWGJ1zZWUbwd3ZiLvKW/Lt86QRl/BUq4CJ+bPVA
 Xx1Hz/hXRB0AOSrrcfyxDwRveBlYewm3logUqZkZCnofsjdjaJVZRTT/dFfjaCmOoYDS
 jLUhin7lypoi3cN+zNdLc+knkW67154wFFHeFxmtTnVSzhxqKSqy9WShBwpaSHiqPnDs
 BLsA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795195806; x=1795800606; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0n8SftTJ57yw2hK7VbVhby6HENyYsAqbRV5OCtUN0cI=;
 b=THZAj6RsQcYE5lcccOx2a8wFwj7vK+IWTS/FGcszeHDGUfKEL2OedkGcOHrd4LDfOE
 qDMEjnGa7uYKVmi3s5x7aB4MTUEO8SzuIEuV2o5msQE0RqgRuwp86Njdvl8uYNmQXZDU
 zqkxLuBqW7P4pOoPFoOLl/bg3oH1ASQm4e9xuqZ3Ji89t0tY2hfiB3KtnrqX3jgQt7xq
 F/rOlJ/i/7zezkkJElaKhT8FcZ0MsqHIf9esG0GfNhtNvcnc/MIZmgOMDALVsLVY4d23
 jyenD+D5USpqFhPxpUCTi/wY1HX0/D9pGCt9caZZeCuRQYii8WKq27kTwjmp+cNmUFzK
 KuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795195806; x=1795800606;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0n8SftTJ57yw2hK7VbVhby6HENyYsAqbRV5OCtUN0cI=;
 b=w/C+J6iiYQLIzAI5Y8IH7ye/8DDcBBqduhCvt8HDo/JKdtXti374rdYpYJZ4VHVZo0
 uVGMTxU6FSbXMMVKxA5f8icltIT/EZCCSAD0EJaJVN6NwRi6CHFuPKFZOBk4CQSLfnjF
 M83Uf/eKKciDkC/EF4rYagu4zu8Qh3f+SpG8Dnfw1Uy+HY8p9GuYkDQNDNpVAtkPjBsw
 3S1XbYbZGVwuMvSlv1lU7SEGC0mXMVzUtocY9HzHZB2nMVbIxF+KDNITtTyJ5lIsD1kI
 rF5F5uF7dKhs3QlpfZV+BX07RlsF682NSnwWhJ+gTtwopeRlkNom42T3KcPj5pO4/8S2
 /zfg==
X-Gm-Message-State: APuU4Z+lJbUSrw6HtzWieTOG8lVeaQsPSTf4fJcnX62TeBTobRtIYboS
 cU8FG5iJlmB8ne1PSg72ca0rxDtPFQxnGREduzJAXKopt96boA6MoPb6Oik6x3+PKPVxiY0ArKY
 VsVDH75+V0rh5Qg0jUwRolU7QGnURGXU=
X-Gm-Gg: AYBFou3J3ToTi/KieTnm02MV5BWDVMZVp2mcFsfcJiZUqt723IJe2kHRXNKirfHLW8A
 MR9soJN7fFl/QPl3zxQgIBgXOpO7a8EeSnGyftIYElYC7+USYWq5qekQi6NQwrxwgd1saRQBqgA
 iV6gTVSJuYUxHErEwpI8fii5m1QMDqnv4HWTY97CfPVK+ilLsb75eJtpPKYvQ2DaNLjM4Hn2tjX
 cH42zpRX17GiWeCJPtSwemms9c9hZ4k2/mus/b1G0mNhFceKv0sUbCLIQ9W/4xPjytCBP9U3aLF
 9MHVNdj/a8OrMbnr6KforCYC/DsKEp+Aezw850oi5TPpOFnFe7ugXHEP4a5YzAvfFrN6ABqvlX2
 anGetK3BL3q/QSE+3ebME9kZXwTYkIYIarIAdsQvQWJRirdZQ8mCIs0pOBsnVLNyDjw187Rix0o
 JEDm4MQhFJ8B/uB0SPhyKppQRt/5Ul5YzIDrltKY9UGmnD5aIIoSQ7pCxR3UsUykX+YbithVpYv
 gq3gjRL
X-Received: by 2002:a05:6808:5198:b0:573:2541:180b with SMTP id
 5614622812f47-57a058e8466mr6308001b6e.1.1795195806389; Fri, 20 Nov 2026
 09:30:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261120033850.387702-1-ruijing.dong@amd.com>
In-Reply-To: <20261120033850.387702-1-ruijing.dong@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 20 Nov 2026 12:29:53 -0500
X-Gm-Features: Aa3M54oYI3qLglMTwE_2dtcTyuB5Y5cKdCiQ21ysRHyTJX4JcTrp33M17p8ikZg
Message-ID: <CADnq5_PmxEO-A_ybON4LjD-eJHi6HZ_==Pq=Vs810_4OE6TBsA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: keep the commit padding when re-emitting
 submissions
To: Ruijing Dong <ruijing.dong@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com, 
 alexander.deucher@amd.com, leo.liu@amd.com, Boyuan.Zhang@amd.com
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 10:46=E2=80=AFPM Ruijing Dong <ruijing.dong@amd.com=
> wrote:
>
> Re-emitted submissions are written back to back without the padding
> amdgpu_ring_commit() added. Pad each one again, as commit did, since
> some IPs like VCN require every submission to keep that alignment.
>
> Fixes: a17ef941212b ("drm/amdgpu: rework ring reset backup and reemit v9"=
)
> Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>

Another alternative would be something like this:

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index ae028eeacaed7..7a687d1add45b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -318,10 +318,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring,
struct amdgpu_job *job,

        amdgpu_ring_ib_end(ring);

-       af->ib_dw_size =3D amdgpu_ring_get_dw_distance(ring,
af->ib_wptr, ring->wptr);
-
        amdgpu_ring_commit(ring);

+       af->ib_dw_size =3D amdgpu_ring_get_dw_distance(ring,
af->ib_wptr, ring->wptr);
+
        return 0;
 }

I kind of went back and forth with that when I wrote the original code.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c |  7 ++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 25 +++++++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  1 +
>  3 files changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_fence.c
> index c3f56253d3b8..faeaa65355ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -745,7 +745,8 @@ void amdgpu_ring_set_fence_errors_and_reemit(struct a=
mdgpu_ring *ring,
>                 return;
>         }
>         ring->reemit =3D true;
> -       amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy);
> +       amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy +
> +                         (seq - last_seq) * ring->funcs->align_mask);
>         spin_lock_irqsave(&ring->fence_drv.lock, flags);
>         do {
>                 last_seq++;
> @@ -778,6 +779,10 @@ void amdgpu_ring_set_fence_errors_and_reemit(struct =
amdgpu_ring *ring,
>                                         amdgpu_ring_write(ring,
>                                                           ring->ring_back=
up[fence->backup_idx + i]);
>                         }
> +
> +                       /* A job fence ends a submission, pad it like com=
mit did */
> +                       if (fence->skip_ib_dw_end_offset)
> +                               amdgpu_ring_pad_to_align(ring);
>                 }
>                 rcu_read_unlock();
>         } while (last_seq !=3D seq);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.c
> index 7b67e8cecca2..411c74802d20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -142,6 +142,22 @@ void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *=
ring, struct amdgpu_ib *ib)
>         }
>  }
>
> +/**
> + * amdgpu_ring_pad_to_align - pad the ring to the fetch alignment
> + * @ring: amdgpu_ring structure holding ring information
> + */
> +void amdgpu_ring_pad_to_align(struct amdgpu_ring *ring)
> +{
> +       u32 count;
> +
> +       count =3D ring->funcs->align_mask + 1 -
> +               (ring->wptr & ring->funcs->align_mask);
> +       count &=3D ring->funcs->align_mask;
> +
> +       if (count !=3D 0)
> +               ring->funcs->insert_nop(ring, count);
> +}
> +
>  /**
>   * amdgpu_ring_commit - tell the GPU to execute the new
>   * commands on the ring buffer
> @@ -153,18 +169,11 @@ void amdgpu_ring_generic_pad_ib(struct amdgpu_ring =
*ring, struct amdgpu_ib *ib)
>   */
>  void amdgpu_ring_commit(struct amdgpu_ring *ring)
>  {
> -       uint32_t count;
> -
>         if (ring->count_dw < 0)
>                 drm_err(adev_to_drm(ring->adev), "writing more dwords to =
the ring than expected!\n");
>
>         /* We pad to match fetch size */
> -       count =3D ring->funcs->align_mask + 1 -
> -               (ring->wptr & ring->funcs->align_mask);
> -       count &=3D ring->funcs->align_mask;
> -
> -       if (count !=3D 0)
> -               ring->funcs->insert_nop(ring, count);
> +       amdgpu_ring_pad_to_align(ring);
>
>         mb();
>         amdgpu_ring_set_wptr(ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.h
> index b2040f80b7f2..6224a9f94826 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -464,6 +464,7 @@ void amdgpu_ring_ib_on_emit_de(struct amdgpu_ring *ri=
ng);
>
>  void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
>  void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_=
ib *ib);
> +void amdgpu_ring_pad_to_align(struct amdgpu_ring *ring);
>  void amdgpu_ring_commit(struct amdgpu_ring *ring);
>  void amdgpu_ring_undo(struct amdgpu_ring *ring);
>  int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *rin=
g,
> --
> 2.55.0.193.g27ea71069a
>
