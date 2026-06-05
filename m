Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A034DCD6E7C
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 20:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4F7811AB00;
	Fri,  5 Jun 2026 20:22:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZkfcnjXW";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6976011AB01
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 20:22:22 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-304f9bc869aso301611eec.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Jun 2026 13:22:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780690942; cv=none;
 d=google.com; s=arc-20240605;
 b=igIXOfwt6szoDPOVoEsjvbUChEmYu/5Kx3DpiTqQkKYuW2bbQlDpHOa4z0U08nOjLU
 XQ+l5twUZtMt4WdulGFcqQ32YbRubkKU3sFEGlp0M98TCkBd82/fO6mAlv0P0nutPfac
 W2QaSKkGVXbnmtf1k5noG/+phrvFVgrI3oGaRNRV61vhm4jzxvVp3vIoCNKVs5ySArn3
 4xNZRppYB+mi7b5xQ6pzpklWML1ZsABml3KCpQeiMs6HbgpGDfZIYfAzzCcgOkk8GTF4
 azTR3bJogHbwpm3UVgq3TnzuXhGEWxD/O4FrC1urusIW6lphxrBAA99QWxFYfoRSXZcD
 UvNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Jd8zZoj15MB4D27exy0vziD0YMpZOpqLLJrmgLP/VUs=;
 fh=AzrSD8AVmfL5pkg4s8PAslTgFVafn1ObjdsqUwm4D0E=;
 b=Ij6UiatKG9S2z3tYUlaFvneRx6kBkoIbWWZ8mokh+toZbQLrDYqVOkrdK0E5Jjywya
 HxCYF99epuD6I+N4Cs3MspgbYVXlMaDDut07HMijV3Dk+M5m0UsRJrU2rIf/EWSDF5Vh
 XniL2UiJ9PYyoSx6GgoYEUdbWDC/jivMBp6eoM1rUkFpSCz0Vdh1DJ0Th9XpC1dFGuSO
 Y4xRH7tgOoHIqD+jm4HS1eswba9cpx0r79AxviDbNWPw/GH/B4e4LAyx/ipOTXpJv1F9
 qXQVU1WU3aA7MFZIrvjgtYvM/BhZrgriqKXVe+UUKm8svRxyQUri2vJnAKFX521DVPfi
 RA5g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780690942; x=1781295742; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jd8zZoj15MB4D27exy0vziD0YMpZOpqLLJrmgLP/VUs=;
 b=ZkfcnjXWhq1W+43qmhldaecpiPuFfargFUkDBYuk248BoBl9dHq+UNSfObS/i5Pb9J
 +oUf5X9g8waZ8OWePnrLfB37gg7yx0eH9Khyb2uQqjz4TRphzXWn+UZqjYL5KfNirU6d
 Ye+Yk2e8QjDrQXkAjc1xqIR3sw484wIX+Z6NbJ9UdJTn5lnWiD3oTwF14jVy01HVMqDh
 dRkatdwic6VaQhx96q43mrSCGMGy9A7IxpLO3hH8d8lBXfjm+QCt+MXMAuNK2rZhZ5Eg
 /SGDTdsycszhHEWe3auTLEt3wXNjKsSlecIxCCl1pqbwhmVCtQnWPYGl9wuShkmaRVW0
 DQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780690942; x=1781295742;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jd8zZoj15MB4D27exy0vziD0YMpZOpqLLJrmgLP/VUs=;
 b=dVjCq0p9/X5MXI/mqLN0P3nwMp6DgtO1T/XDlgebSCyzuL8aHwhG4DR/rA2A/6pUoe
 6kyWlEH5btlUSs1NzSTMt6MYgkNjyexiF6L8eLDwo7YejNOSUHuMznJTsLc0Uz3hAoEn
 jhiiHozr8hEQDSFsA3U9gxMO2F4hS15k7rwcKawsjzyiFi1d6nj7tnpiMpBuIDNMxvag
 IlxAVJcnRukrLYwLWgIWqH38V7TwS4c4EdM1xAvDVBSGdMfXTHTx+oaiT1+4aZY8YsbD
 gQkxs2/InooNhC9jobdlFCaSwCLdE90ZUkiALVSrsNqj0w9QETcXNOwHaETr0J5rsW6L
 A18Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/1oRZ+1GKqOFtxszdq3UXfdBiFW1KKPUKrlMgmE5cOp2ivoys6PezihZG62200ZCBRGaRuaNJM@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzaCSITFJ46VnxX5XJN28N/Uysk4gU0Twgxu7FYUb1wC0FnIjmf
 Ur58O1Temyfun+3HN8X5zi5muVr54cecFzpvEGwFwdXiIjMjOxvCr9jAdhmwr8nhGqGthwh9Snw
 KVxSDJTVdaE1TEYAqj6hIhkddqLUKinc=
X-Gm-Gg: Acq92OHKSRxOnsVGN5/kWYRTT3XeeZaP6RaUyr14fimZ4hLUPNMWYMQG6qoQ30nswdg
 cWO6oRN9QrpiuaMYwur6cdflw6ch1vFJy+BE0oEAJww7Vz1pA+VJB5JsKjYUoj4N2egltfaygBx
 nkSw6NRlHthX4rluXAmA/OLab6j5VaQdtBOwwKkCgCJDiyw5YW0fp4RgINSNPlJJhQlaxMilOTn
 4MHR8FCk2iYQNQ5DhBoGiJta/+5i4B1izotRi6jZ9jxTmoFHYMp6fn9Di14vZAG5ll7TxavS4ec
 9do+vC2HK4P1rrgX4T2B+XHcZM1gZuJI27dBUTbAlpfD504oYVixSPcZUN4YeJnG8D1nOSRssh/
 CB8aT
X-Received: by 2002:a05:7022:423:b0:137:fdce:fec2 with SMTP id
 a92af1059eb24-138067f0b96mr1031445c88.4.1780690941599; Fri, 05 Jun 2026
 13:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260605091803.6018-1-vulab@iscas.ac.cn>
In-Reply-To: <20260605091803.6018-1-vulab@iscas.ac.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 5 Jun 2026 16:22:09 -0400
X-Gm-Features: AVHnY4Itf_LGBLOFfworAGpTyhoHXZvSw8OTwPFhRJI4fD0sd3Y6MHVuNEzj0Ic
Message-ID: <CADnq5_PejRC_QGGYvph_0jAyGWX475LvxTVHZVo3qvH7ZVgv+A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix fence reference leak in
 amdgpu_gfx_run_cleaner_shader_job
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, lijo.lazar@amd.com, aurabindo.pillai@amd.com, 
 superm1@kernel.org, Hawking.Zhang@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
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

On Fri, Jun 5, 2026 at 5:24=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> wro=
te:
>
> In amdgpu_gfx_run_cleaner_shader_job(), amdgpu_job_submit() returns a
> dma_fence with an elevated reference count. The function correctly
> releases this reference on the success path after dma_fence_wait().
> However, if dma_fence_wait() fails (e.g., due to a signal interruption),
> the code jumps to the error label without calling dma_fence_put(),
> resulting in a reference leak.
>
> Fix the leak by adding dma_fence_put(f) before the goto err when
> dma_fence_wait() returns an error.
>
> Fixes: 559a285816af ("drm/amdgpu: Replace 'amdgpu_job_submit_direct' with=
 'drm_sched_entity' in cleaner shader")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index b8ca876694ff..88bec4e93712 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1686,8 +1686,10 @@ static int amdgpu_gfx_run_cleaner_shader_job(struc=
t amdgpu_ring *ring)
>         f =3D amdgpu_job_submit(job);
>
>         r =3D dma_fence_wait(f, false);
> -       if (r)
> +       if (r) {
> +               dma_fence_put(f);
>                 goto err;
> +       }

I think all of the clean up paths have issues.  How about something like th=
is:

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 321d7aa52f042..848846ac9391e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1701,7 +1701,7 @@ static int
amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
                                  &sched, 1, NULL);
        if (r) {
                dev_err(adev->dev, "Failed setting up GFX kernel entity.\n"=
);
-               goto err;
+               return r;
        }

        /*
@@ -1729,16 +1729,12 @@ static int
amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
        f =3D amdgpu_job_submit(job);

        r =3D dma_fence_wait(f, false);
-       if (r)
-               goto err;

        dma_fence_put(f);

+err:
        /* Clean up the scheduler entity */
        drm_sched_entity_destroy(&entity);
-       return 0;
-
-err:
        return r;
 }



>
>         dma_fence_put(f);
>
> --
> 2.34.1
>
