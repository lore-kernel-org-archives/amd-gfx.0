Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB4B606A789
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YyZt2Ap2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 496A210F661;
	Tue,  3 Nov 2026 15:22:35 +0000 (UTC)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDB2310F661
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 15:22:28 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-36a6b774d12so336961eec.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2026 07:22:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793719348; cv=none;
 d=google.com; s=arc-20260327;
 b=iQ2+h/WOTLxr95iw4v5dMk1jecXB7JOvz+4iYevgxMoZ5Bj9xXxBlcsBsehCstjGUu
 Bxm6AKXJ3J1MqmDPoQaMJxNxX/ITTASQymPvrUlVhhRz0DxDSmVqypOOSxe/x3hPTKuo
 WYRGxlrLn8W3OxuolzONZMya/F9duLqiYyGXdXo2R7rqLFsV/YQWHPXw06+CUdSbnJMF
 R1YMDHd39lEmqPPHRPPNvaAjSoNqBvYd9a9aPztci7XFbBglrP717S6dnkGuVnWjDbKb
 XA8adCcsf+LO3mEfi8Kl3hDi57HQm+PhqjSROSRCqnREVqR+IVsqeTpfBzTcRyfiOuEp
 LyGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kBUa3kTsWDUYgqSVx3OC4fJ1yILznBFaOURNx+7jjkA=;
 fh=24M557J+GUi2yneYFMhK5lvY7dW7n2XwEtWdP0WmM08=;
 b=aQjgo/PgKRZfKDD2snEsRSrfPGU2Jc6rHZhk9ik6Ih1RQNWnKQUtg2z9vpsblu9QKU
 e/Vq0mSJgNA1njiHYhi8vSKZwA8QWaQuSFVs+medhS90Bn9z/D3bpPHsuT3thzGJp9sc
 LlGPqraWQrk4CSCIQpevQaOYVDLo81CrX7LYvZK75SIYYjp3QDU/JSmxd0YongfbL38P
 4xK+s8jXdkevIgXuNjNMkigRAl3vOC1u/xZTY0yTEf0Xj1vn5jMmmn26i8+KrVrNIy9t
 r6Zr6eNYpzo91fgSB2qMbskcFG+HrlAtgeDtaSxQk7fth/hOCsOHlSne2qVhaERPJ0II
 99+Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793719348; x=1794324148; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kBUa3kTsWDUYgqSVx3OC4fJ1yILznBFaOURNx+7jjkA=;
 b=YyZt2Ap2jnzfXnBrm+Rkz/Ep+8qkFl8SEWt8fPlbHoXPgSI0y58ryjOiNB7OzEhCiH
 XFjXNJuqRhSTMcFCCw36H4+uPKYANtbuajk6rWhOHWL6KLQEnnACdBejsA9jVKKlBTIE
 GMGr5ZhUH+iQ+BPa9ngX/f0DznbarEfuTGiWAHlmYCXSM9JdXVRNR7IMVeJkKn1op/zX
 fMVeYsrTG+qF8COCU08TYqSVLp9kuTmcgCf/KOMC2vKiBdz0Ssy6v+duOKm+XbR5jblC
 0GgUGDQ8XMGj5WR+m36v3XDh7jwpI9Y5qqGIB0pdtQ27KyzBwV5UDLqOILER1OsFM+HT
 q4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793719348; x=1794324148;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kBUa3kTsWDUYgqSVx3OC4fJ1yILznBFaOURNx+7jjkA=;
 b=IN4LQoAM3LKI/o0dko4LWvNAjp4u9BFcP8AlDppqLuVKRcNXs7rrEj4Sw1UQoivPhO
 OPY3gY/Hy/F2GxzI+tX2+Jp66jKfM/huLB68jdeLEE6+Aaj+Y0HXf4dOu8jJdmuvhlCU
 K5regMNi3o6DiihzxpX5qEPlmtMcniHgWJtEHhqOhuSGrvyLWewdxd2kCnm+PoNYYsio
 7ZeS1Z+OsXaetEQrNqpq2gcyaWbKbiKgBn+Y1LEsnfWU5r6Y9j0DjEHEv9VidzPZr4/2
 DkxwvBqB0R3MknZqdunMD1ORJTo2ryQImETohTuOslmPr31bm+ksO6K0Pd69IIAoadtj
 o1/A==
X-Gm-Message-State: APuU4Z8TQodYOnnzgGTMDDnsDtGdr4cFTvWYa6j8VaPXSMZFEe4kajQ4
 WdMjjmlgtY8TUPzJoDKOn3nawhiqVMHVOjZy+2MNkGEr07umuu8tEK6kG9bvHAwMtDAEAaEk6AD
 SPzzN2vY+js8qbKjPc2jx29/BpbPVUQGJYQ==
X-Gm-Gg: AYBFou1U+kZqbcTfWlh4YhKvVfatt8eO5Gc5HQul2Tptd/8VYewVHjSdmtV60C4CRZL
 yxm5kHpNB1xH64AJ9O18ztQISq8tAIifAznbXAwwFMTMw8xGZsljNUwVH41CG6yC98PQVCR9fCM
 /tlYHhz9COcwPCLxGhP5M9lLVyhet6asfFmLPcn4V+VoGpZK+91uU9bvh8JDAjOBuZ3RIhkiahi
 cJiTTL6/H6Ce68B4rtE5f31CuGtkHmnMx2oiDMjryHBEh4ML8pcZR9k4xYrNrkJzNOLDezWyuFY
 7p3e9t1tL4X76NsozTPuGjh+dGN6OSowwg5tFCFIfniZ3rpewhkCIawmEriw3c4z41GyBpR9FfN
 m9rRg0wisRKzqxXjs6xPCYx1cMyWFf94xIQe5CTN57Dlre7KH8DsCzdRcxrWvT/HtdDR2e+DFeb
 bCMzi91QYIf09OM6GPQuIP10E=
X-Received: by 2002:a05:701b:2710:b0:146:ffa9:2117 with SMTP id
 a92af1059eb24-1ac58e573b8mr29146778c88.1.1793719346587; Tue, 03 Nov 2026
 07:22:26 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027075017.121456-1-amber.lin@amd.com>
 <20261027075017.121456-4-amber.lin@amd.com>
In-Reply-To: <20261027075017.121456-4-amber.lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Nov 2026 10:22:14 -0500
X-Gm-Features: AclHuK-z1ZrU4NNVwGIk61PqedYOMT4rK5fz1JiK1zT2uVxcyClZ0Bv_3M7CX-s
Message-ID: <CADnq5_NtVW5+nZGndQPDE6NBocyyvOrqY_fX=uzb0RCt2-2OLw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/amdgpu: Correct hung queue number for reset
To: Amber Lin <amber.lin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
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

On Tue, Oct 27, 2026 at 3:51=E2=80=AFAM Amber Lin <amber.lin@amd.com> wrote=
:
>
> In an ASIC supporting multi-compute partitions, the number of queues
> varies with the compute partition mode. We need to adjust the hqd_info
> offset to get the correct hung queues doorbell offset and hqd_info.
>
> Signed-off-by: Amber Lin <amber.lin@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 49 ++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index b58a9ffef4e4..d81e613081c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -108,6 +108,24 @@ static inline u32 amdgpu_mes_get_hqd_mask(u32 num_pi=
pe,
>
>  static void amdgpu_mes_userq_notify_unmap_work_handler(struct work_struc=
t *work);
>
> +static int get_num_queues_per_xcp(struct amdgpu_device *adev, int num_xc=
ps)
> +{
> +       int i, num_xcc =3D adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mas=
k) : 1;
> +       u32 num_queues =3D 0;
> +
> +       for (i =3D 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
> +               num_queues +=3D hweight32(adev->mes.gfx_hqd_mask[i]);
> +
> +       for (i =3D 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++)
> +               num_queues +=3D hweight32(adev->mes.compute_hqd_mask[i]);
> +
> +       num_xcc /=3D num_xcps;
> +       for (i =3D 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
> +               num_queues +=3D hweight32(adev->mes.sdma_hqd_mask[i]) * n=
um_xcc;
> +
> +       return num_queues;
> +}
> +
>  int amdgpu_mes_init(struct amdgpu_device *adev)
>  {
>         int i, r, num_pipes, num_queues =3D 0;
> @@ -222,21 +240,19 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>                 goto error_doorbell;
>
>         if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(11, 0, 0)=
) {
> -               /* When queue/pipe reset is done in MES instead of in the
> -                * driver, MES passes hung queues information to the driv=
er in
> -                * hung_queue_hqd_info. Calculate required space to store=
 this
> -                * information.
> +               /* When queue/pipe reset is handled by MES instead of by =
the
> +                * driver, driver provides the buffer for MES to store th=
e hung
> +                * queues information. Calculate required buffer size, wh=
ich is
> +                * the number of maximum queues. This number varies with =
compute
> +                * partition mode. We allocate the biggest size, which is=
 SPX,
> +                * num_xcps =3D 1.
>                  */
> -               for (i =3D 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
> -                       num_queues +=3D hweight32(adev->mes.gfx_hqd_mask[=
i]);
> -
> -               for (i =3D 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++)
> -                       num_queues +=3D hweight32(adev->mes.compute_hqd_m=
ask[i]);
> -
> -               for (i =3D 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
> -                       num_queues +=3D hweight32(adev->mes.sdma_hqd_mask=
[i]) * num_xcc;
> +               num_queues =3D get_num_queues_per_xcp(adev, 1);
>
>                 adev->mes.hung_queue_hqd_info_offset =3D num_queues;
> +               /* Double num_queues. The first half is to store doorbell=
 offset
> +                * and the second half is to store hqd_info.
> +                */
>                 adev->mes.hung_queue_db_array_size =3D num_queues * 2;
>         }
>
> @@ -526,7 +542,8 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct am=
dgpu_device *adev,
>  {
>         struct mes_detect_and_reset_queue_input input;
>         u32 *db_array =3D adev->mes.hung_queue_db_array_cpu_addr;
> -       int hqd_info_offset =3D adev->mes.hung_queue_hqd_info_offset, r, =
i;
> +       int hqd_info_offset, r, i;
> +       int num_xcps =3D 1;
>
>         if (!hung_db_num || !hung_db_array)
>                 return -EINVAL;
> @@ -551,9 +568,13 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct a=
mdgpu_device *adev,
>                 return r;
>         }
>
> +       if (adev->xcp_mgr)
> +               num_xcps =3D adev->xcp_mgr->num_xcps;
> +       hqd_info_offset =3D get_num_queues_per_xcp(adev, num_xcps);
> +
>         *hung_db_num =3D 0;
>         /* MES passes hung queues' doorbell to driver */
> -       for (i =3D 0; i < adev->mes.hung_queue_hqd_info_offset; i++) {
> +       for (i =3D 0; i < hqd_info_offset; i++) {
>                 /* Finding hung queues where db_array[i] is a valid doorb=
ell */
>                 if (db_array[i] !=3D AMDGPU_MES_INVALID_DB_OFFSET) {
>                         dev_dbg(adev->dev, "MES: hung queue doorbell 0x%x=
\n", db_array[i]);
> --
> 2.43.0
>
