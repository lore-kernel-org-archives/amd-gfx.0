Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF36C55ABA
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 13:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0253C10EE76;
	Wed,  5 Aug 2026 13:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kT0h4V56";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86C2810EE76
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 13:53:16 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3856d4015e0so124086a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Aug 2026 06:53:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785937996; cv=none;
 d=google.com; s=arc-20260327;
 b=ntMOv45jSWN1djZ1HcRkV7HGOkJrgQgmI/5Qp4LJsrtnG2qKD1v0SguF1KdwTIqmFN
 8r/buDolOVm5VLScI9B2uecF0WX8pmbQlEaw7/j+owVHrKLt2Y7uCwc0k65q1k+zxxHU
 L71g976vKz3AZ1MsBblOfjjV+7ChviqtJvnJejUTB+ax+8o/K14xtOst6Lf+l1lVF7hy
 Q62g9CO79kc2wxylMCx+4qZDe0JcuA+Am1Xm8RZaD9egvFegttvlObUQRBZVV1Wvqo8e
 Qb2+FFoeMFHLhf03TN9SWumuTFFYaKtRJx5d2E+gR3y5XWALAXBEDQy3YUgiqGduFwPF
 jH9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xKeEQ4sSvAbPuFKg5pxuUpqaDd+tNZrB5zhY1H5pkG0=;
 fh=r7JgPt6nnHppQG6VSLMMH1eQwH6kHmUeYriI7nSVMqw=;
 b=EUQaZsN0F4C+DsHwBy1C72fqkS1TcwbJ915eCLnYULeKohP9vOyXAqh4zu8GLkmNHo
 eZXG3z0mVIjV0Tl9eJY0wgyOEzQi3I14hEyXDoxV5bFPEMbK/D0awsWq9CGwulAVTDYP
 9llzf61aMoj5Paqf6pdae6fi8/cCZVvSu/MxTO/orI0CcoZfZA5jXTcaK1wppN3DSN7a
 AOMg1NjAEBIBJWunnL2gMzFikhNkrjNrbJ5VxAucBPThHf8ht+ZikSPlRl72ec+rpxZz
 YypS7qQJOEVVppCrTd19ixm12RPQ/8W8d+38QBroNefCp/z3HfmIw8Re1X5qg2EF/nJi
 5jUg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785937996; x=1786542796; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xKeEQ4sSvAbPuFKg5pxuUpqaDd+tNZrB5zhY1H5pkG0=;
 b=kT0h4V567a8UzgRjSx5CF9gTfpjiR0Pmc9O7C4OYt0Ny4DiTkmV5l9koMvqjcNiXd2
 9invKQkflOuyoN2BX3DOTpY3Myth/J3Oypl7hk44T/US44nUQmMmOFUiNm/X5y7F6S38
 GIx0hq+VcBvOmownhEfE0Eg+uOIGO6lP2i0FxQOx2Pt+y/VtgicualNIcmKPeWe3DOyM
 43V2Vt95Qhy96pYXnS0hbOz5RyqJAOCtOHOmVOWQLZesNDmkBuNnF2N0m+Tgso8VYQo1
 SinHh8AwNSUQlN/zhZOphZNrfVXKeQU5ylaTH6sAOfDkjSUkmHjGANNTw4jseD2fi7cq
 42Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785937996; x=1786542796;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xKeEQ4sSvAbPuFKg5pxuUpqaDd+tNZrB5zhY1H5pkG0=;
 b=gsorz/yDkMlza5Q6CCIn/pvNLddCIapO+7YKuTVPiwFcAg5aqiLazQz0Wk3ODFKy10
 YwFVB8O9Ei3Z37deBAxKCqsJ/F1jF+1Zf5U+r3nZRes91SBgFfI6ZfHoBDVrGFdUOwMF
 mD5R3t2nxCzOECLeIU5qi7R1wR/E3Kxq9BXk2p+YZndPlVyqytK8n0/0Zc1nNWUGOd+v
 lFYADUsh36SWp5ReDzrWZOKoXfmAHWj2fryPTVCfD1bD5TIFl17Uqn3FMh+nTsoaqqdA
 t1gWEsF+X7oXDMG2tcma3Y/NiKzqltpOmD2nkinR/q/cjzL8fdd1oQ63GpsrQSrw1U+3
 VoEA==
X-Gm-Message-State: AOJu0Ywm/l3WVoRqUxCLyQZLL6Hvb0/FMh9Bon8VBFpgndxbWy3bWeU9
 rpJ2jJczq8s2umJ20zIADllfZAT3coO2DpCabrN/rtis9R2b7iaR9IEoi3es5Vrtu6viTCKubzE
 7Iq3BGaNbIbQN+cnHQXa3pBSNtjgVYfs=
X-Gm-Gg: AR+sD11PpEIb3dGgqajVE6XiLE14mKs372B8t9rUTcucHQNiN7fObphR57Xf5F7HLVS
 0Kr0HPyqnXu5dYo5OXaLPEP5S/msi1Mjfb8LjtvTgKwvvJT9zojdPfYkwiIpwBGbH8n/FIXc3Nv
 oV2OSrfGfvoKNtThCZAspuN/0I5dCJqjd+rFRc/Gxte83OLRIQar/bHGDIMW5Wu9aqDQE9EtPBT
 Va/mSn+MHJjUUA3F0ovDmefJFRNgRM1MUT4uWzCK7k8nImkqslBJNzQ860M1vjiZO020OjR/qjG
 1yeZsfgtTtVodjB/CXHdkr2oOxiLMcP1OHdJ1p26RccsUunQu9XynQ4vZp4svaGOF7PVBJs/c3d
 jDkugcqRkPZH43hzpskEB2uamNsCj+jw=
X-Received: by 2002:a17:90b:5448:b0:390:3936:8760 with SMTP id
 98e67ed59e1d1-3903bb0cf4amr5779623a91.0.1785937995959; Wed, 05 Aug 2026
 06:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260803124121.16912-1-timur.kristof@gmail.com>
In-Reply-To: <20260803124121.16912-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 Aug 2026 09:53:04 -0400
X-Gm-Features: AUfX_mziJSbH9nawGrHQaPFPQzj4kozN-HN1bAZ4PRGw9PJhzxEqi2hcVVJN6TU
Message-ID: <CADnq5_Pud8guD5CGOK5d7cS3nPTfAaJhFGWezmuw6PpACVM_Qw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix crash in
 hwss_set_output_transfer_func()
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <nat@pixelcluster.dev>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>, 
 Ray Wu <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Alex Hung <alex.hung@amd.com>, 
 Tomasz Siemek <tomasz.siemek@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
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

Applied.  Thanks!

On Mon, Aug 3, 2026 at 8:58=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@gm=
ail.com> wrote:
>
> The pipe_ctx->plane_res.hubp pointer is NULL on all DCE
> hardware, which causes a kernel NULL pointer dereference
> on all Vega and older GPUs.
>
> Let's add a simple NULL check.
>
> Fixes: f879f53407f0 ("drm/amd/display: Refactor DPP_SET_OUTPUT_TRANSFER_F=
UNC to drop pipe_ctx")
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Cc: Tomasz Siemek <tomasz.siemek@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/driv=
ers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> index 11411fa94665..5495e493b2eb 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> @@ -1900,7 +1900,8 @@ void hwss_set_output_transfer_func(struct dc *dc, s=
truct pipe_ctx *pipe_ctx)
>                                 .xfm =3D pipe_ctx->plane_res.xfm,
>                                 .dpp =3D pipe_ctx->plane_res.dpp,
>                                 .mpc =3D dc->res_pool->mpc,
> -                               .mpcc_id =3D pipe_ctx->plane_res.hubp->in=
st,
> +                               .mpcc_id =3D pipe_ctx->plane_res.hubp ?
> +                                               pipe_ctx->plane_res.hubp-=
>inst : 0,
>                                 .is_top_pipe =3D resource_is_pipe_type(pi=
pe_ctx, OPP_HEAD),
>                                 .stream =3D pipe_ctx->stream,
>                         }
> --
> 2.55.0
>
