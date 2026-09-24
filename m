Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFADC98318
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 21:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A83110F7C0;
	Thu, 24 Sep 2026 21:52:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YBaKl6/x";
	dkim-atps=neutral
Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com
 [74.125.229.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7D2310F7C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 21:52:46 +0000 (UTC)
Received: by mail-dy2-f43.google.com with SMTP id
 5a478bee46e88-33c14c9c8ccso32773eec.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 14:52:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790286766; cv=none;
 d=google.com; s=arc-20260327;
 b=jqNWz3ZAp0dIso+nolGl/3GRjI0qxG8/2qf2oGULiHJ1aWG8ulpJ8f3fKVNaTxXzF6
 t3Cfgnw7JCZYlSHQfn+PCnr/aETqNwqISo1o5YmzRnd2QH4GC4bcTguK2gvcfV4bmd1R
 yRX2bmmxdVJz+O0peIyUH/9nyfLTfiJ3iIXaNA+sY9OzqTZ+NewFlCq7zuR8jXY38Cu9
 PAlOu/+4xnHaDgw/sElZUrCUn47mO+R+GDJPpcxv7tJFEOWo1G06sjRMATZBxM8scXy6
 wt1n9BaPYWY5jCSSuh5GXJQBd28ijKkig/tVa1fALocdgFFtVfeqFPKV1JE17OBiS+r/
 yabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8lhG9wb5QlfLqgt5UEaJmUthOlH8IOrrPdU2sMoER/4=;
 fh=2fTJE2NcyLNGM6FL+kBiBpTeUon3ddBePR8FPCGbbGM=;
 b=NekgadAx2bqZJjwoTq+7pBP0tbHEfCNzOAJ/xO7JQXEQgsTbCiC0xXSTUb8nGDDKqh
 HKrDToSY4ldEMNggfvwmT1Tn6MspnkxrME8oh6w1YGp0mXlbsAX67EHeN7isFq/YwEjH
 z1ibJRvlSHWj5qyCn4cV2043vq00OLdK9rESm9dvZaRAI5xuQqnXZcQCyYtv78PHb6GR
 QPowg0t3FLWDVFscEu14dxKY6n+Go0AfXIGnS6TlFYoSM2nq0zs7tJDffjJ+WFy7dOYg
 fSyUTu9r1tCI9xF9MMSURiL+OnSFmDxpuOLfBrpIAsiu34vty/8tzZN+xZxQxYdRYZ9G
 /6yA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790286766; x=1790891566; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8lhG9wb5QlfLqgt5UEaJmUthOlH8IOrrPdU2sMoER/4=;
 b=YBaKl6/x+RRgl93mQn9yz8h1zO0A0wfTIMO0atBiKKxNQuLfEDg0RECrq5F0TySBJt
 t0FqI2dqslLFlTR9vnAxg4OFEkJj9Y20lpxoxQqIEys8pv/eJgXcmnizYNa4r1Nm7yV7
 XuW3TNW7zC/TJ/s0n52iBEXMRrWU+WXbMZABy2U6zR0dhrqvwyKqUX5sfkPB6z0TNOJ3
 yqOmYtKaxpXW+plXCCFZIpCAME0wndtom6IwPnKcbW7IXQwggsCpvSuxZ6ZSGR1nguqz
 AYe0eV+7jXdKkUAJIueW67f6MfYrErqS52gp2kjM1wpNuBwDFp74lgh6OhxFn+RmnMFq
 7wZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790286766; x=1790891566;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8lhG9wb5QlfLqgt5UEaJmUthOlH8IOrrPdU2sMoER/4=;
 b=GmsWGEFqiS+3pDCEM6QHPpPod3RXdj2/0j5j7x00bvs0eexF15oMocjuK2AMVRmRR5
 PmSThOYHyy9+GDl5ZnLaW92zB4c4V+6j2E1tfCDUx4VdyxKFjNGZ/exh9+BHF+7RH2Bn
 zqX1c0S+NzZkVAkva53yRk0HUBc+SU3KCg0k8NNApVVniwSR5xM5xm0/nHNXDZK8AONC
 Gvb/NQAs5ddaExT6Okdq0oJKp2XK4Keh/jm6g/HZTMiD1wByVwLI3A7ePUk+K05ebZLF
 Ry73QwUkA74M5Cy+2UcHab/O0TiBE+Hx95SyypsHwC6sW+0GRif9XyKXy0oXr7+qClXo
 aQ4w==
X-Forwarded-Encrypted: i=1;
 AKwUvByO/drAukDzyjDNRAISDpqZ5qFOAFZ6MtRgOynaiKTFfPCVH8wvOVZHTeEr3OIuCAFf8mWkqB/C@lists.freedesktop.org
X-Gm-Message-State: AFuF++kLfAGfqEghFEKYRcBoaQ21mkJOtXtXmOXte07TIhCt50jBxRr0
 KKIvCtVkEE1Q0aF2e3SKMjZ1DaaF1AcM91ZiDt6ZS7V8+oeowjiFTW9nIU6VXsczZxfyBM3IPo1
 fPbnwXvBL4FAp35e9yKESMI0HbFi2jq0=
X-Gm-Gg: AYBFou38qPNhiwQ8wZNXQZPB76+9G89M+AQmXhe/Cxpy1nw2vP2CTqtAQiDrSSwNSBc
 Z6CEkPSP2JtHJdR/rjdiWo3t5EAP+RG0Gu23szSMc1A6Ry3a1uzgR10c/DbVyxgMOXbXmZu5frX
 BSOMpVJjZPhpZgrPejZIXSaNQzGutF2MWXeOVR39V/lPD/+IPY4UIeJMeeyA1BfL0n+xzVj3mg7
 NnDohbNkpBdSjEi2ZPQ4e4uv+NzBEc7ggDwyEn6bWss7KZMSDQVd3yyZuz7QzX1PWKDL/10m9+R
 8MR+C7X4we/cVf6WoJBdYO4ayeoMJODjRgfKuS4XRD+YT1bUXlb9I6obYZVPvzXUQoebA14HwOR
 5L2pOE4DUb/x4+/bzboc5+YE/1Jjyvb8vFy/34cVL4g==
X-Received: by 2002:a05:701b:450c:20b0:144:ff51:2d73 with SMTP id
 a92af1059eb24-14503f1814fmr4390022c88.2.1790286766083; Thu, 24 Sep 2026
 14:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260923152912.1296884-1-qwe.aldo@gmail.com>
 <20260923154357.1319689-1-qwe.aldo@gmail.com>
In-Reply-To: <20260923154357.1319689-1-qwe.aldo@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 24 Sep 2026 17:52:34 -0400
X-Gm-Features: AclHuK8_S3kMABiU0QTNjcDgoAqPTQebAhSNKvPGJWpzU2O6hEoWY7qZTP4di-8
Message-ID: <CADnq5_PuveD6MFtdLFkkHk24jVCQqgyC1R6pUy7ri_RyWVSZXw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: prevent parameter-space underflow in
 nested ATOM table calls
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
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

On Wed, Sep 23, 2026 at 11:44=E2=80=AFAM Aldo Ariel Panzardo <qwe.aldo@gmai=
l.com> wrote:
>
> atom_op_calltable() invokes a child ATOM table, forwarding the
> parent's parameter space with an offset:
>
>     amdgpu_atom_execute_table_locked(ctx->ctx, idx,
>         ctx->ps + ctx->ps_shift,
>         ctx->ps_size - ctx->ps_shift);
>
> ctx->ps_shift is in dwords (set to ps / 4 in
> amdgpu_atom_execute_table_locked()), while ctx->ps_size is the
> remaining capacity in bytes. The subtraction therefore mixes units:
> a child table requesting 60 bytes (ps_shift =3D 15 dwords) with only
> 16 bytes remaining would compute 16 - 15 =3D 1 instead of the correct
> 16 - 60 =3D underflow.
>
> Convert ps_shift to bytes (ps_shift * 4) in both the guard and the
> subtraction so the units are consistent. Abort the interpreter when
> the request exceeds the available space so the parent table does not
> continue with stale or uninitialized data.
>
> Fixes: d38ceaf99ed0 ("drm/amdgpu: add coordinate ATOMBIOS table support")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
> v3: abort the interpreter (ctx->abort =3D true + return) when the
>     child table's parameter space exceeds the parent's remaining
>     capacity, instead of silently skipping execution (found by
>     Sashiko AI review on v2).
> v2: convert ps_shift to bytes (ps_shift * 4) before comparing with
>     ps_size, fixing the unit mismatch (found by Sashiko AI review).
>
>  drivers/gpu/drm/amd/amdgpu/atom.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdg=
pu/atom.c
> index e0e585f..af283cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -646,8 +646,13 @@ static void atom_op_calltable(atom_exec_context *ctx=
, int *ptr, int arg)
>                 SDEBUG("   table: %d (%s)\n", idx, atom_table_names[idx])=
;
>         else
>                 SDEBUG("   table: %d\n", idx);
> -       if (U16(ctx->ctx->cmd_table + 4 + 2 * idx))
> -               r =3D amdgpu_atom_execute_table_locked(ctx->ctx, idx, ctx=
->ps + ctx->ps_shift, ctx->ps_size - ctx->ps_shift);
> +       if (U16(ctx->ctx->cmd_table + 4 + 2 * idx)) {
> +               if (ctx->ps_shift * 4 > ctx->ps_size) {
> +                       ctx->abort =3D true;
> +                       return;
> +               }
> +               r =3D amdgpu_atom_execute_table_locked(ctx->ctx, idx, ctx=
->ps + ctx->ps_shift, ctx->ps_size - ctx->ps_shift * 4);
> +       }
>         if (r) {
>                 ctx->abort =3D true;
>         }
> --
> 2.43.0
