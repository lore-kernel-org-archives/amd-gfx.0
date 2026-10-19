Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7D8606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G3OIy2Oe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6934310EFAA;
	Mon, 19 Oct 2026 18:02:20 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6C0A89238
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 18:02:13 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-3a47d4fb7feso306473a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 11:02:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792432933; cv=none;
 d=google.com; s=arc-20260327;
 b=mlAHQRdxPRc4bvEMhyd4oHvX26xNsF93CSvVBFYFV1aeUwMZK0WMBpSBDvm2SY5QLw
 V++4bxiI9pq6Q273AZlhIA4MfjGliOVydFvar7BbAVaQCHDo3Z4re02b4PZ0QPDjLiFl
 J1At1xrVdJE6meoP1i6jf+xZ7e/FTVu6tna/MfQdwqAxCSb7H2eUJQHeAzR19zj0F4AQ
 Y9MotU1xGD8eyY1sAPXBrCTv+UuuQLICuvm//NSHcS8cjh1aw64jmuxClPzC8ROHgzJR
 Sl7evN2zzYc8NWQfaPVQutik5NXDP/Y4ELUO8DiiFqmH1tit6UNDh87mN4+PMGT0okYL
 Lt0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=x875RJdjfXCxzZDJCUqQBTmV/vQ+aYgwGesNdJIJmZs=;
 fh=RzvsqJZrMIxwCE4m3Bms5qsRdRHBhP8zMyvjas7oUzw=;
 b=BuhHmGV3FLj+6sj7Qp2+4JlFL099BOxfR7nLU2TgUIinPista/jXVWg62WgN7qpNd6
 wS7glOkHnnIWe/uiWfLjte0P9CYy4qwYfHp3+kDq7QJtaJpApTEyRtKfQBnA5OPstrEp
 mv5RFUVmBaNlcpYLRszb47RFz6W1HWjCLsRzlWxgXJ37F4AVUZ3g56GChoowGzi/Vjhe
 KkbMNSTgdDCtRBDb579XgRQIuM5Fhl833vKK54Q2U8baD2N9bO3CXB8aRecfLc5DiepI
 5CnXt70uAh8uHJLdGkNMbTF0qG9JDjpacXYnGJODnNBlLQvVZ4zuNSf2IHpcgCrOIw60
 2liw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792432933; x=1793037733; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x875RJdjfXCxzZDJCUqQBTmV/vQ+aYgwGesNdJIJmZs=;
 b=G3OIy2OeYLfYo14P6I2pwXHoICc3uBrDiHxpipDFybHk3yijgZRkhgSEA2+KyElmmY
 i+DCOINURuGlyYxbWGgtPuaQsWjlv5IgH3C8e2W9XYvIP6whxGNY6yQnE1+0SQkk8ZP9
 Uewg7luLkPAaLAwNzvwir/pJR6AlcipMBd3B1J2ZfOqeegfDxp7OKtYb1kG1RH1nq1VN
 4uHg6Q7gIWngi6414AV7U/MXgSPKoSvsGil+BAaqk8tSKdfA3thB6r0/YqjTMSggzN9Y
 hy1uBnXqnRsDmEddJ8UpWCUmwWblWiiRl71gVB0mrwE884WcPW9bz/lzKjN/KyYi/UAA
 Gcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792432933; x=1793037733;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x875RJdjfXCxzZDJCUqQBTmV/vQ+aYgwGesNdJIJmZs=;
 b=EFx3jhiTpuw4ESGMMn6X0hd4r32oSMzQVUcRiGXkiNjD8bGaOqBQQ1H2CVoMLLv6m8
 4+gHVW3NEeobq5N41sqSaSiudMchSyxuR8tQG3R3pgz8U06tTQ5/Mehy1aTSgZsq47Gx
 c0ISilALULQ/0epX+nPlNbnimr0eI0GG9S1HeBuz7SavLf/Vc4arzGa6d944tmczZUgX
 hXsUbUxdKJaQYyiKwPdJYovio/HI9zle8AqXkfjaPIwqlBYRdkMaLGA8e1InsnSSmIOl
 zkA3JonwvLVFBScOdkxCxbvGWNyKLD1aIel0+4t7Pp3FiyWaDt3O56p0ze2RgxbCmoGx
 UAvw==
X-Gm-Message-State: AFq9FYKUq67HT+3lXpxSGfbgSxlKFIKq7tcmwBwM/+/CR6dYOCtmX7DO
 p3QwZmSCQfFYX5wMvIBoWkpHMAsElXtF0boBvqrBHENMO00CIVEicuuC2tmeRC5vMDf6fMKXlga
 U+Kl6ttzwxu5V9oGt5pxVBpJex0S3wbi7E5yt
X-Gm-Gg: AYBFou1fHRfGXUMDSr0OiESOig9F+oipmAhnnWHebP9ghnaljWwKJTQX6xeNmTRrw0D
 y0lxTDOQLuedGdMCK0AAGAOWxisoiI5k8Nhcp/AhUQvlPDVV6wjyCBPyb0VtUAY8/I/y06rE+Dw
 uUxyp/X1kfHY5RtJOV34a4ieAuRVxHaXqOOKz3ANXylpUoJa/w8jmQuPx2svu0vq0va1JI5UWHR
 108gCgD+Oh4elh6GqYu3/Cy0KvsgT30WuOxlkQCTf+9MmmyvqQ+XldzuriAylWkq0zcFK7aDAVb
 mhNPya1JoS+95oJ75M+Rc9tdN5z2wIvj1u0VF+avV95O4KX6GxDXw/jVwSnPodBwVCAMbLcGfIq
 Px1gKGbWGL2yQCBpnrnbzoILufcZbiDqPADjf5gDIug==
X-Received: by 2002:a17:90b:1d4f:b0:3ab:be66:ddc5 with SMTP id
 98e67ed59e1d1-3acef4fda1dmr12483438a91.6.1792432933217; Mon, 19 Oct 2026
 11:02:13 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019153942.4067-1-leo.liu@amd.com>
In-Reply-To: <20261019153942.4067-1-leo.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 19 Oct 2026 14:02:01 -0400
X-Gm-Features: AclHuK-Hr_TiHi7B9j25lZ-SyOtwCmY1t6K0AhTjKN3tb5gC86EVsG2kNO6g25c
Message-ID: <CADnq5_PZBhnJXza6Y7KRTGaM-p1iGOMmV_ST70T+wuxf6rj+vQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: call hw_fini for IP blocks whose hw_init
 failed
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
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 12:06=E2=80=AFPM Leo Liu <leo.liu@amd.com> wrote:
>
> When an IP block's hw_init() fails, amdgpu_device_ip_fini_early() skips
> its hw_fini() because status.hw was never set.  For VCN, UVD, VCE, and
> JPEG this leaves their idle work queued after sw_fini() frees the adev
> state the handler touches, causing a use-after-free.
>
> The bug was reported on MI355X after unloading GIM then loading amdgpu.
> GIM's teardown resets the GPU, leaving VCN unresponsive.
> amdgpu_vcn_enc_ring_test_ring() calls amdgpu_ring_commit() =E2=80=94 whic=
h
> schedules the idle work =E2=80=94 before polling rptr.  The poll times ou=
t
> (-ETIMEDOUT), hw_init() fails, hw_fini() is skipped, and the idle work
> handler fires after sw_fini() against freed state.

I think it would be better if hw_init() cleaned up the idle work
handler in its failure path.  Can you cancel the worker in the vcn
ring test helpers if they fail?

Alex

>
> The ticket (Link below) suggests cancelling the idle work on all
> failed-probe/sw_fini paths.  This patch takes a different approach: the
> idle work cancel belongs in hw_fini(), which is already the correct
> counterpart to hw_init() for hardware-domain cleanup.  Rather than
> scattering cancel calls across sw_fini() or every IP's hw_init() error
> path, we ensure hw_fini() is invoked for any block whose hw_init() was
> attempted but failed.
>
> Add status.hw_init_attempted, set it in amdgpu_device_ip_hw_init_phase2()
> on hw_init() failure, and check it alongside status.hw in
> amdgpu_device_ip_fini_early().  This causes fini_early() to call hw_fini(=
)
> for the failed block in its correct reverse-order position =E2=80=94 a si=
ngle
> change in one file that covers all IP types without touching any per-IP
> code.
>
> Link: https://github.com/ROCm/amdgpu/issues/234
> Fixes: 416e1fab4752 ("drm/amdgpu: drop redundant cancel_delayed_work_sync=
 call")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:Claude-Sonnet-4.6
> Signed-off-by: Leo Liu <leo.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h     | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index b74f9136aa2e..e267fb3774c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2233,6 +2233,7 @@ static int amdgpu_device_ip_hw_init_phase2(struct a=
mdgpu_device *adev)
>                         dev_err(adev->dev,
>                                 "hw_init of IP block <%s> failed %d\n",
>                                 adev->ip_blocks[i].version->funcs->name, =
r);
> +                       adev->ip_blocks[i].status.hw_init_attempted =3D t=
rue;
>                         return r;
>                 }
>                 adev->ip_blocks[i].status.hw =3D true;
> @@ -2902,7 +2903,8 @@ static int amdgpu_device_ip_fini_early(struct amdgp=
u_device *adev)
>         amdgpu_device_smu_fini_early(adev);
>
>         for (i =3D adev->num_ip_blocks - 1; i >=3D 0; i--) {
> -               if (!adev->ip_blocks[i].status.hw)
> +               if (!adev->ip_blocks[i].status.hw &&
> +                   !adev->ip_blocks[i].status.hw_init_attempted)
>                         continue;
>
>                 amdgpu_ip_block_hw_fini(&adev->ip_blocks[i]);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ip.h
> index 5dd6273982c4..bfa27ca05dbe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
> @@ -99,6 +99,7 @@ struct amdgpu_ip_block_status {
>         bool valid;
>         bool sw;
>         bool hw;
> +       bool hw_init_attempted;
>         bool late_initialized;
>         bool hang;
>  };
> --
> 2.43.0
>
