Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3980B606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 20:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OPW29ivd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBCBD10F151;
	Mon, 26 Oct 2026 20:48:53 +0000 (UTC)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79ED310F151
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 20:48:47 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-17e82de56ccso97236c88.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 13:48:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793047727; cv=none;
 d=google.com; s=arc-20260327;
 b=lrGgGukUGjGa/u6Os+eV38KgTDfHDatHdVH7yEcFVCvDmSsSRJluf1BRsaJpnq+xTo
 T6opVY97C1L1szmjBzcwxaNjhBi5PsQywO7fHURI7IgJVJPXGboKSWz2lw0EHtVQJyZB
 L4k5kzSq3iIOIrzKDM1qY3dA6jB8kITNB4vrHzhtg++xXEAiik8gRM3PX2DjUU2fpI6W
 K3ZEcmiBKZxP+pFg8NjjTa/0l5JjELI0Oj60eUTDbEU3P2osZ/6r41wgOmd3LGGT0aLS
 z35mZm6WUAHUm6z16j0Zy1UVtEkqNvJQwFeh65jlT4VbkotYdJoadmelUmEbOrdm2VUK
 bIYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=y/wCgy2VWo9slpP21cFp/RQ6NxLge8tnxAsZG/O27Uo=;
 fh=ChPQI4aGUtlS8NZjEKL3hGrYJ0j8jqcZa72sv9Is9Dc=;
 b=JzwHgcql96gATaircqCD4i5dunN2topPe/QvQhvIKbLGhfOYmq/IJ59UjId/i2G+Eu
 Pe+jJn0FPLAdli/6lwFhxvBCAyAeXHlHbx2blSGWzFBAZwIvxyPwlBZtHBUHW+zXO3oc
 DLCwdJ10E2iVUaf1fuBCsJvuUj3JsEWMoZblKhleRPt+0G1lxaa2AiW7C20R4S/v6Z09
 49hXl8d4pOzN5ZUcZRMThy89Nl7aoKW7UvQAa/R1oQIbtZ99wGaav+gJz+ulRGaYbDfn
 4pMohvARMZ6SForhcT+zVLts1+7MG0V/f1gSpxjCK8+e2lPwIqrNhgGEWDOl7nDwEs6C
 z2bg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793047727; x=1793652527; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=y/wCgy2VWo9slpP21cFp/RQ6NxLge8tnxAsZG/O27Uo=;
 b=OPW29ivdMXhHvfLsW8zo6jmGu9Nhw8oBHqfDPqZaLEMSWaCpBRvDZpm9v0Lv1S9BB8
 bZSrHFQZKWJHfRLY3++d2AoDv/vfDfmuc2S+nOI0sE3dUcEG8EfaFmXsc+6Y4eGJMw/E
 AzL5iA7JIHrOyuf+h045vigwbQekMFALj0qk45BeybXdx6C1OMCWvsI1JQE5QRR/0NtD
 UdEKvJH8ItiG2AOWphom0atsSqf02uETRw5opy3Ml3x64udIZSImY/zRzwbnOvWPJq0r
 ShXVTmnK5NDlWtmZwAuZ08nWnQ+wutUAol1RL5YWHs5E6qHOBbD/Ys5MFTKtFeYCaTx7
 p+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793047727; x=1793652527;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y/wCgy2VWo9slpP21cFp/RQ6NxLge8tnxAsZG/O27Uo=;
 b=pgKg4bl6H7VSEK82+IkH2mCRbdgZRSstggjKnllQgtNkdNF1JDbI5xdRqySJEZEZq1
 i8a5eC9NrH0j1MFbXm9sM0I0CVtFdFhkSn+zQjpfn45A33rE0E6MWn8r6nMW1luC1mob
 VggmctH98SsvjtSQM1z+R0T+MSTsMY1FZINcLeeM96b+TH/NCNPktWRN7dVqMG6ea4t8
 EvGQejOqv00khjdbxMNZJVeQY3ulCOHhKKEORuYdZ1BvBA/3NpOw6UtKCy8x2LHO/JjN
 1TXzGfDtJMB9KXPLzyYbaUHvm5uG8B7hiix2CwFoPZmhbseO8AB0CA64F/d64ySbU5tL
 2MKg==
X-Gm-Message-State: AFq9FYINh6TM6Z6SJwMANUNA3ht36nj49q2Yj6GA+lOjB6GV/leJVGax
 7yi59lC6PgBqsJS99ADiBsdy722kRIlWH+wekcSziCuyI9ayNkuPIpcyC7YKpVI77mSCu9eJX2i
 G6WLGIFOjoLIxKyaFWn3osA/zYI8NIS8=
X-Gm-Gg: AYBFou0gljM5LHxTGuAzhRICNqglwwheWZvPJfzXQFBpBZRrBQnynG7AucUQn1EH1Cr
 du3f+bfa6XsR3cm6d6lfidMq2dRwEY1cymWcMygc+NW/KBg92ujCUHI4mmr6vzbGe+0DYPGLCby
 bLarKMHfCNX2MuhtxbDj1Evs4bJYTPAlqb+N3JMGDV6nELRZTQALjaSCv7CXtMOcA26mSzVCQwf
 coFH1I7njwfh0NNnEg+3EFeRWJub5zXsFtD79OT+T4X4a/YjEcN5uOxte+iiUj1CIubab85ilel
 e2+QVpKFr+mbBbvl9STH03VOTAeh7bQjqcwPfZNdBTZD6TsFDeEHG5riIUaIgEYcIASogdaCtEc
 oGTjayhrXzvUIyWV/jDSNtOw4+7z6lqYR941UeGhARDuXROtJ+kEEG7tALJLt07OnHF/PhSeN+p
 cX3pPfua8NlUkaZkpKeypa2SqB62W0ecZS1BzAmfdRC0G/
X-Received: by 2002:a05:7022:f4a:b0:1a1:9106:cfff with SMTP id
 a92af1059eb24-1a19106d045mr5392345c88.2.1793047726404; Mon, 26 Oct 2026
 13:48:46 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261005212814.341475-1-darekm@google.com>
In-Reply-To: <20261005212814.341475-1-darekm@google.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Oct 2026 16:48:34 -0400
X-Gm-Features: AclHuK8wMZkPPHG3oIzSVEK9PhAiuerHhKjW1PppYCyYje7YtT0mi8rYRq3SmqM
Message-ID: <CADnq5_N3_3FwsXuqY_VT99EY2pNMkvm+fALdrfdeoHR07Dhp+w@mail.gmail.com>
Subject: Re: [RESEND PATCH] drm/amdgpu: check amdgpu_vm_ready() in dma-buf
 move notify
To: Dariusz Marcinkiewicz <darekm@google.com>
Cc: amd-gfx@lists.freedesktop.org
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 6, 2026 at 3:51=E2=80=AFAM Dariusz Marcinkiewicz <darekm@google=
.com> wrote:
>
> amdgpu_dma_buf_move_notify() touches the page tables without first
> calling amdgpu_vm_ready(). When a process is SIGKILLed, its VM entities
> are stopped. Teardown of an imported dma-buf then tries to clear PTEs by
> submitting to one of those stopped entities. That eventually hangs the
> task.
>
> Commit aa5fc4362fac ("drm/amdgpu: fix task hang from failed job
> submission during process kill") added the stopped entity check in
> amdgpu_vm_ready() and used it in amdgpu_cs_vm_handling(). That did not
> cover a call in amdgpu_dma_buf_move_notify(), what was already mentioned
> in:
> https://lists.freedesktop.org/archives/amd-gfx/2025-October/133076.html
>
> Tested by SIGKILLing a GPU workload holding imported dma-bufs. Without
> the patch "Trying to push to a killed entity" errors are logged, then a
> task hangs. With the patch there are no hung tasks. This was tested on a
> 6.18 kernel.
>
> Signed-off-by: Dariusz Marcinkiewicz <darekm@google.com>
> Assisted-by: LLM

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Looks good to me.  Applied!

Thanks,

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_dma_buf.c
> index 9c80eef79e32..ee473a888331 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -481,6 +481,11 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment=
 *attach)
>                                 continue;
>                 }
>
> +               if (!amdgpu_vm_ready(vm)) {
> +                       dma_resv_unlock(resv);
> +                       continue;
> +               }
> +
>                 /* Reserve fences for two SDMA page table updates */
>                 r =3D dma_resv_reserve_fences(resv, 2);
>                 if (!r)
> --
> 2.55.0.1082.g2b9226bbc0-goog
>
