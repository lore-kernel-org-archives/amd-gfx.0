Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B772606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j0KD7pLO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2439A10E2DB;
	Wed, 21 Oct 2026 13:55:59 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 697E410E312
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 13:55:53 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-35ca5244753so77261eec.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:55:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792590953; cv=none;
 d=google.com; s=arc-20260327;
 b=DVP4bT52Tx5OGhIEzGDpk3AlZqidcWGhI/lMdsFJUFf+g1hOH40zrK2PJ1CTLGMCVr
 pn6/3RQrs7uV9Jt9Mtwqc0HYP0mCq/0vzNtivmV95bc0Pr7s31yinU5xZst6iKMuHYRm
 e4akFfjwe4/WL7ET0zW0t5YU/yilJwotjK4U4fJScwHjWL3VD50g2vcltDd5WqiHoFlu
 NgUgqoBsZRiEO+mYkuaAIC8Knm8BXRoDrdJHkUlb3F7NJ+wotXZBcG1vYPpxeXQ5EcDR
 wUq9XUISsjzeYeBfN1x+Vm6paE4zPsWPfZAEggnUslBvdOrCVm8oJ65mQoNTw+3DMuRB
 qEeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5FnNm4UIzvKOc10FAL7wfxfBN4PLxD36wKJfb/jCtec=;
 fh=RzvsqJZrMIxwCE4m3Bms5qsRdRHBhP8zMyvjas7oUzw=;
 b=MvYT+nyxFpXIfTPPWHeIsjGog0slO3I4E0Mf2eA4D1Iq/SW71Rv2Sl+VcjrXal8PWi
 EV02RltFmYPuKpyhV+4hqFle5JUzlufIJgp5d3F7GrrljwyCwhTq30yidTYX15Cv+tPn
 oFI1Su9IZYnRp1T4BTLISvNDxhjT2+MuFI7iG2Fkxcbh1wOx7R5eEMjphYYwoHmp5Iiv
 4HJagN1Zh/UTtZc6aq3XHSadZNIRc6rQD1iCcaMlJpjErr4Q963bE6Y57YzpS1QIq/lq
 i9kGUlZL6814tZSvptAH6ScQQ1tFBRLyRlyzqUhlCR5aRnybzhVTJWQBS9EAM41RyrSn
 /xjA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792590953; x=1793195753; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5FnNm4UIzvKOc10FAL7wfxfBN4PLxD36wKJfb/jCtec=;
 b=j0KD7pLOkExOWnldkd7vaocmBzfCA4FTl3vXassqBlImruziDV87HTX6ySv/baT3nr
 +nntRb6bWwPONbsICcnrBrl/sYUL6TiCpFDWf2esndetFQWzaDBNtzmqxqP0DIvNtZgl
 VR2VtCBLF4EjCAD22a6lPx9a+te9OPforlT21b2JrV4l8pPMZgheH/zug2d2v0xp57+N
 GdKi3CunmoDqk/xaNNii0825Qisk00ufQlKqkoytwVVknMU/krqAGuzcYmJNLlAHQzXx
 sq+W7WRa4Md5OoskIOQVAlT+cS08NZTpk4ZgfoErEMGE6m/kFVgHEH6sGcM9/39Sl4fm
 Pnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792590953; x=1793195753;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5FnNm4UIzvKOc10FAL7wfxfBN4PLxD36wKJfb/jCtec=;
 b=cQ9bW2+7AujLurw7bGBRUwscwBehyZ3Ggm3MCxVsQVntDuHNQ/DKD5Djx59NOtdRJ8
 aMwBGtTTbjYKbNKmAoopF6v/4fQlAcpxu5omhWZgw+lwGl83cjuFAX1KSU9bC/VOX/Mo
 AHJhbujax7eeOHnCREz82Kb/jKHHOGRCt+elSBwfj0ed8HwJlhalBNXdKRD6wLoin0Sv
 4CcbbhKLVf8QES+OD52YIjCQJdcRTnwgh/YOXVp03POGrJBfyhtDkRiz/yNWXshc9sFu
 dBVQnh6GxOg+cxEMKuKVnhR/ClCS7INr7kqStXromv3aMEgspFR3KQKcyhoG29ESk0lU
 1cRw==
X-Gm-Message-State: AFq9FYL1tH9cphK+JjxKn7FpWTOJ7dzBHjXn2d8jOeFrEa8YhXfQTAvF
 Kjxm6pv7NM/pocpH9hJWzA3BAl3F4YY1SxT/i1clRj71+OIABlj8dfbQimoRxRinzVOnGXQgSaC
 s4GDaIXCogX9m27/MNvXWwufyPOjbHl3gaasT
X-Gm-Gg: AYBFou0oE+EL6mWJ/qURs29XgMUsfNDK3FG5ZsQmlugi7jbACOHOzopm4uZ4A24Ewuk
 dZlnmlh4YItJSf/tbSNNGUJ1cwlplgTPDWFVBs1w18OYhpa4ut8IhoD5eJwvPWKnD8OCw0w97KW
 fgtDkEd8X4FyHUK2J5HISAgln/XbNNMGhGZBZ34yaSQ+5ftx8VcN+9QZNFfaQvVs81q0Xxd6w5B
 8HN0DD903tAnoLZGZm5vAJ5ap//9odmwDJDynF15uOt7sSBGQuAn3vQqc7qIRImrsebkdVimQRg
 c+FWgKyBAP++JLTclZwXK7fblBJrjqeC9Rbapdv9zgpiHSK/ouu15UXd9R7yVzggI9tdn/93+0V
 YvWRDxTKJcPE6Q7sh8b3YUdl0zAXWltR6SH8wtQm5Sdz9m+XFlAFvxd69/LRq5KtkFf6C6CqBBN
 lgS8VsHkSXvUfxfQxzZJW76bQ=
X-Received: by 2002:a05:7023:a5c:10b0:183:d275:cf76 with SMTP id
 a92af1059eb24-190a370711dmr3874782c88.2.1792590952298; Wed, 21 Oct 2026
 06:55:52 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020193212.19760-1-leo.liu@amd.com>
 <20261021125444.27886-1-leo.liu@amd.com>
In-Reply-To: <20261021125444.27886-1-leo.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 Oct 2026 09:55:40 -0400
X-Gm-Features: AclHuK_zA362IJvERjz0zM7z5G1b1Wc0keW-WIwDM1q8U4r3hHcL2Ls8dDka5w4
Message-ID: <CADnq5_PC_i7DcpZX_yJOY4SujRUz-f_BggvO83Su-CRL9RE+pQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: cancel idle work in hw_init failure paths
 for vcn/uvd/vce/jpeg
To: Leo Liu <leo.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 9:31=E2=80=AFAM Leo Liu <leo.liu@amd.com> wrote:
>
> From: "Liu, Leo" <Leo.Liu@amd.com>
>
> When hw_init() fails, amdgpu_device_ip_fini_early() skips hw_fini()
> because status.hw was never set.  For VCN, UVD (including UVD ENC), VCE,
> and JPEG, hw_fini() is where cancel_delayed_work_sync() is called.  Any
> idle work queued during the partial hw_init() is therefore left pending
> after sw_fini() frees the adev state the handler touches.
>
> Cancel the idle work in each hw_init() error path, immediately before
> returning the error, so that hw_fini() remains the sole cancel site on
> the normal teardown path with no duplication.
>
> Link: https://github.com/ROCm/amdgpu/issues/234
> Fixes: 416e1fab4752 ("drm/amdgpu: drop redundant cancel_delayed_work_sync=
 call")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:Claude-Sonnet-4.6
> Signed-off-by: Leo Liu <leo.liu@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c    |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c    |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c    |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c    |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/vce_v1_0.c    |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/vce_v2_0.c    |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c    |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/vce_v4_0.c    |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    | 11 +++++++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  8 ++++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    | 12 ++++++++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    | 12 ++++++++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    | 10 +++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 10 +++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  | 10 +++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  | 10 +++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  | 10 +++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  | 10 +++++++++-
>  29 files changed, 174 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v2_0.c
> index 72069b77f6f1..7ce3396b1431 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -159,11 +159,15 @@ static int jpeg_v2_0_hw_init(struct amdgpu_ip_block=
 *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>         struct amdgpu_ring *ring =3D adev->jpeg.inst->ring_dec;
> +       int r;
>
>         adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
>                 (adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
>
> -       return amdgpu_ring_test_helper(ring);
> +       r =3D amdgpu_ring_test_helper(ring);
> +       if (r)
> +               cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v2_5.c
> index 2968256d4cd7..46293664fd28 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -221,10 +221,14 @@ static int jpeg_v2_5_hw_init(struct amdgpu_ip_block=
 *ip_block)
>
>                 r =3D amdgpu_ring_test_helper(ring);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v3_0.c
> index 564e40899df2..361d0f4b4bc7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -174,11 +174,15 @@ static int jpeg_v3_0_hw_init(struct amdgpu_ip_block=
 *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>         struct amdgpu_ring *ring =3D adev->jpeg.inst->ring_dec;
> +       int r;
>
>         adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
>                 (adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
>
> -       return amdgpu_ring_test_helper(ring);
> +       r =3D amdgpu_ring_test_helper(ring);
> +       if (r)
> +               cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v4_0.c
> index b29ca3a49939..4e8eed2b62db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -204,10 +204,14 @@ static int jpeg_v4_0_hw_init(struct amdgpu_ip_block=
 *ip_block)
>
>                 r =3D amdgpu_ring_test_helper(ring);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v4_0_3.c
> index 0343a64595f2..1925d3092d02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -435,12 +435,16 @@ static int jpeg_v4_0_3_hw_init(struct amdgpu_ip_blo=
ck *ip_block)
>                                                         VCN_JPEG_DB_CTRL_=
_EN_MASK);
>                                 r =3D amdgpu_ring_test_helper(ring);
>                                 if (r)
> -                                       return r;
> +                                       goto error;
>                         }
>                 }
>         }
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v4_0_5.c
> index 4da3f9c995c1..a1496412810c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> @@ -232,10 +232,14 @@ static int jpeg_v4_0_5_hw_init(struct amdgpu_ip_blo=
ck *ip_block)
>                 ring =3D adev->jpeg.inst[i].ring_dec;
>                 r =3D amdgpu_ring_test_helper(ring);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_0_0.c
> index dcdb089b4308..1a4594d5d952 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -173,9 +173,13 @@ static int jpeg_v5_0_0_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>
>         r =3D amdgpu_ring_test_helper(ring);
>         if (r)
> -               return r;
> +               goto error;
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_0_1.c
> index f2debf6b6bd0..efdc537ec81e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -307,11 +307,15 @@ static int jpeg_v5_0_1_hw_init(struct amdgpu_ip_blo=
ck *ip_block)
>                                                     VCN_JPEG_DB_CTRL__EN_=
MASK);
>                         r =3D amdgpu_ring_test_helper(ring);
>                         if (r)
> -                               return r;
> +                               goto error;
>                 }
>         }
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_0_2.c
> index dd0abce73687..eb3dc9558e0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> @@ -280,11 +280,15 @@ static int jpeg_v5_0_2_hw_init(struct amdgpu_ip_blo=
ck *ip_block)
>                                                     VCN_JPEG_DB_CTRL__EN_=
MASK);
>                         r =3D amdgpu_ring_test_helper(ring);
>                         if (r)
> -                               return r;
> +                               goto error;
>                 }
>         }
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_3_0.c
> index 8ddd12740a04..0cbb2b8a7e78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> @@ -156,9 +156,13 @@ static int jpeg_v5_3_0_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>
>         r =3D amdgpu_ring_test_helper(ring);
>         if (r)
> -               return r;
> +               goto error;
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v3_1.c
> index ff7128a11cad..97c265daa2bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> @@ -710,7 +710,9 @@ static int uvd_v3_1_hw_init(struct amdgpu_ip_block *i=
p_block)
>         amdgpu_ring_commit(ring);
>
>  done:
> -       if (!r)
> +       if (r)
> +               cancel_delayed_work_sync(&adev->uvd.idle_work);
> +       else
>                 drm_info(adev_to_drm(adev), "UVD initialized successfully=
.\n");
>
>         return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v4_2.c
> index cf304b489d87..90b57a08d6dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> @@ -198,7 +198,9 @@ static int uvd_v4_2_hw_init(struct amdgpu_ip_block *i=
p_block)
>         amdgpu_ring_commit(ring);
>
>  done:
> -       if (!r)
> +       if (r)
> +               cancel_delayed_work_sync(&adev->uvd.idle_work);
> +       else
>                 drm_info(adev_to_drm(adev), "UVD initialized successfully=
.\n");
>
>         return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v5_0.c
> index 564d8fb58905..aa75b2691d57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> @@ -190,7 +190,9 @@ static int uvd_v5_0_hw_init(struct amdgpu_ip_block *i=
p_block)
>         amdgpu_ring_commit(ring);
>
>  done:
> -       if (!r)
> +       if (r)
> +               cancel_delayed_work_sync(&adev->uvd.idle_work);
> +       else
>                 drm_info(adev_to_drm(adev), "UVD initialized successfully=
.\n");
>
>         return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v6_0.c
> index dcb8487e22b1..3016227cf0ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -515,7 +515,9 @@ static int uvd_v6_0_hw_init(struct amdgpu_ip_block *i=
p_block)
>         }
>
>  done:
> -       if (!r) {
> +       if (r) {
> +               cancel_delayed_work_sync(&adev->uvd.idle_work);
> +       } else {
>                 if (uvd_v6_0_enc_support(adev))
>                         drm_info(adev_to_drm(adev), "UVD and UVD ENC init=
ialized successfully.\n");
>                 else
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v7_0.c
> index 46222fc30be6..48eac56f758e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -583,7 +583,9 @@ static int uvd_v7_0_hw_init(struct amdgpu_ip_block *i=
p_block)
>                 }
>         }
>  done:
> -       if (!r)
> +       if (r)
> +               cancel_delayed_work_sync(&adev->uvd.idle_work);
> +       else
>                 drm_info(adev_to_drm(adev), "UVD and UVD ENC initialized =
successfully.\n");
>
>         return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vce_v1_0.c
> index b1428f5bbc81..0ba9bab7c921 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> @@ -651,12 +651,16 @@ static int vce_v1_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>         for (i =3D 0; i < adev->vce.num_rings; i++) {
>                 r =3D amdgpu_ring_test_helper(&adev->vce.ring[i]);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         dev_info(adev->dev, "VCE initialized successfully.\n");
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->vce.idle_work);
> +       return r;
>  }
>
>  static int vce_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/vce_v2_0.c
> index dd870ecac2a4..20a4cb6d17fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -483,12 +483,16 @@ static int vce_v2_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>         for (i =3D 0; i < adev->vce.num_rings; i++) {
>                 r =3D amdgpu_ring_test_helper(&adev->vce.ring[i]);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->vce.idle_work);
> +       return r;
>  }
>
>  static int vce_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vce_v3_0.c
> index d5adccd3e689..7637305df7e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -482,12 +482,16 @@ static int vce_v3_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>         for (i =3D 0; i < adev->vce.num_rings; i++) {
>                 r =3D amdgpu_ring_test_helper(&adev->vce.ring[i]);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->vce.idle_work);
> +       return r;
>  }
>
>  static int vce_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vce_v4_0.c
> index ee445d8abe47..4e1fbc7b50f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> @@ -533,12 +533,16 @@ static int vce_v4_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>         for (i =3D 0; i < adev->vce.num_rings; i++) {
>                 r =3D amdgpu_ring_test_helper(&adev->vce.ring[i]);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->vce.idle_work);
> +       return r;
>  }
>
>  static int vce_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v1_0.c
> index 76793a5caa70..b3e63d6e79a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -252,18 +252,25 @@ static int vcn_v1_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>
>         r =3D amdgpu_ring_test_helper(ring);
>         if (r)
> -               return r;
> +               goto error_vcn;
>
>         for (i =3D 0; i < adev->vcn.inst[0].num_enc_rings; ++i) {
>                 ring =3D &adev->vcn.inst->ring_enc[i];
>                 r =3D amdgpu_ring_test_helper(ring);
>                 if (r)
> -                       return r;
> +                       goto error_vcn;
>         }
>
>         ring =3D adev->jpeg.inst->ring_dec;
>         r =3D amdgpu_ring_test_helper(ring);
> +       if (r)
> +               goto error_both;
> +       return 0;
>
> +error_both:
> +       cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +error_vcn:
> +       cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>         return r;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_0.c
> index 7d2b9e4b913a..12ac20484396 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -294,7 +294,7 @@ static int vcn_v2_0_hw_init(struct amdgpu_ip_block *i=
p_block)
>
>         r =3D amdgpu_ring_test_helper(ring);
>         if (r)
> -               return r;
> +               goto error;
>
>         //Disable vcn decode for sriov
>         if (amdgpu_sriov_vf(adev))
> @@ -304,10 +304,14 @@ static int vcn_v2_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>                 ring =3D &adev->vcn.inst->ring_enc[i];
>                 r =3D amdgpu_ring_test_helper(ring);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_5.c
> index 10ef5616b2f5..2b2abe689508 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -481,18 +481,26 @@ static int vcn_v2_5_hw_init(struct amdgpu_ip_block =
*ip_block)
>
>                         r =3D amdgpu_ring_test_helper(ring);
>                         if (r)
> -                               return r;
> +                               goto error;
>
>                         for (i =3D 0; i < adev->vcn.inst[j].num_enc_rings=
; ++i) {
>                                 ring =3D &adev->vcn.inst[j].ring_enc[i];
>                                 r =3D amdgpu_ring_test_helper(ring);
>                                 if (r)
> -                                       return r;
> +                                       goto error;
>                         }
>                 }
>         }
>
>         return r;
> +
> +error:
> +       for (i =3D 0; i <=3D j; i++) {
> +               if (adev->vcn.harvest_config & (1 << i))
> +                       continue;
> +               cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +       }
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index 0f4f4d66e2e4..6543f21daa1e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -417,18 +417,26 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>
>                         r =3D amdgpu_ring_test_helper(ring);
>                         if (r)
> -                               return r;
> +                               goto error;
>
>                         for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings=
; ++j) {
>                                 ring =3D &adev->vcn.inst[i].ring_enc[j];
>                                 r =3D amdgpu_ring_test_helper(ring);
>                                 if (r)
> -                                       return r;
> +                                       goto error;
>                         }
>                 }
>         }
>
>         return 0;
> +
> +error:
> +       while (i >=3D 0) {
> +               if (!(adev->vcn.harvest_config & (1 << i)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_=
work);
> +               i--;
> +       }
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index 4b7f7bbe18da..8b5646297c2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -349,11 +349,19 @@ static int vcn_v4_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>
>                         r =3D amdgpu_ring_test_helper(ring);
>                         if (r)
> -                               return r;
> +                               goto error;
>                 }
>         }
>
>         return 0;
> +
> +error:
> +       while (i >=3D 0) {
> +               if (!(adev->vcn.harvest_config & (1 << i)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_=
work);
> +               i--;
> +       }
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index 3f39aa83c319..0c58ca25d7b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -395,11 +395,19 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>
>                         r =3D amdgpu_ring_test_helper(ring);
>                         if (r)
> -                               return r;
> +                               goto error;
>                 }
>         }
>
>         return r;
> +
> +error:
> +       while (i >=3D 0) {
> +               if (!(adev->vcn.harvest_config & (1 << i)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_=
work);
> +               i--;
> +       }
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index f30f80c1b07f..a6eaa57ec2ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -303,10 +303,18 @@ static int vcn_v4_0_5_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>
>                 r =3D amdgpu_ring_test_helper(ring);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         return 0;
> +
> +error:
> +       while (i >=3D 0) {
> +               if (!(adev->vcn.harvest_config & (1 << i)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_=
work);
> +               i--;
> +       }
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index 7b7c3bc9f046..055729a42094 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -267,10 +267,18 @@ static int vcn_v5_0_0_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>
>                 r =3D amdgpu_ring_test_helper(ring);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         return 0;
> +
> +error:
> +       while (i >=3D 0) {
> +               if (!(adev->vcn.harvest_config & (1 << i)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_=
work);
> +               i--;
> +       }
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_1.c
> index c9e990ab297d..55a4b2f9463f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -342,11 +342,19 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>
>                         r =3D amdgpu_ring_test_helper(ring);
>                         if (r)
> -                               return r;
> +                               goto error;
>                 }
>         }
>
>         return 0;
> +
> +error:
> +       while (i >=3D 0) {
> +               if (!(adev->vcn.harvest_config & (1 << i)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_=
work);
> +               i--;
> +       }
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_2.c
> index ed47ddd5b08c..ea6cdbcb6352 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> @@ -257,11 +257,19 @@ static int vcn_v5_0_2_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>
>                         r =3D amdgpu_ring_test_helper(ring);
>                         if (r)
> -                               return r;
> +                               goto error;
>                 }
>         }
>
>         return 0;
> +
> +error:
> +       while (i >=3D 0) {
> +               if (!(adev->vcn.harvest_config & (1 << i)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_=
work);
> +               i--;
> +       }
> +       return r;
>  }
>
>  /**
> --
> 2.43.0
>
