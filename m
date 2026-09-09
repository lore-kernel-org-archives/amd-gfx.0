Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A56FC79FB6
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 16:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E302510E1E0;
	Wed,  9 Sep 2026 16:07:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZPlinXQO";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3921410F1E4
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 16:07:36 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-8523cc41f3dso352672b3a.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Sep 2026 09:07:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788970056; cv=none;
 d=google.com; s=arc-20260327;
 b=oMVIW/teQ7eVfer2OwbY1SIDBc84r1BbtIF7u+5qFt6CubY460wSBWdib74lsV31K9
 C8ei6SCD+OkcMsBiLREtHyz6oRTeyDxccBD4VpCicFtdAdHBj08ME2/gbNgQWxoDdBvh
 vDUDOFAGnyjDxc48rTScZltoXIdyak4DiDhOFytGGDbMfw2prLD8JAZIVS1jh86TqgEn
 dp9wvv3n4ED8vVawVw3tU1I0LdWuZNeosGjAHMhUoOzBLs3TWXs57DlWK22yVcpG7/bE
 QKUujAD8bIIwfXIy2FDq32UNQvjc78yidpRbTxqaoN7Wde5to4n/51TuFVJNBp++6TVH
 2rDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jdoulqW/dybJZI4GeBlXySvh7R4n/US2mSH2P60zwMg=;
 fh=Lf8rybJr3uW9bGe7Y+IuU06S7UOjVKAYrNpazBI/piU=;
 b=fRkmza96R27rFgLNidmlB5rEWkH7wGHqMapBmJep1fPJXia2BqCVsPFDrOgi2+lmUl
 lPZTSkWWO/9Yx1fgwCiLCY+MBTeEfe8KKxZITV68ohK9xBbs88V6CEdN14qMDHCYBqn8
 l3wOsjW0Mm7FhcfQJYKjLSCo7DkF2IDkk+kVdxYV9/Q3zOpccYL3WEZiGpscwJ5A6noT
 v8FUEPmU9q7MOKWOl6OZJgEcLom6ags2AmRS4oQdZVsNLaYkGdpOeJyz4eJQMz/nVn6a
 y2SzBNvIOJ5wqLIuyF4dSAYUHvt9LV5araRpTrcZtY66LvDc2bLXBTH8GV2DE2bgDrcp
 6/vA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788970056; x=1789574856; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jdoulqW/dybJZI4GeBlXySvh7R4n/US2mSH2P60zwMg=;
 b=ZPlinXQOq8nS1V+DDzOC0Ro2mZkgtpWrJw7PZUdpplrq59+Z9JCfkr2CWPQP9lgloj
 +7on2d7VRxs2vEUC/fF8YdPONog4QN4JBIm+5rQlPKJaQmKRda+g52EuwL7OsSmzw3bl
 CBvB/OYaDEGy2bOO4TDUk7W6FLCokAIdZbzZUkYCKL2/qCGupLXE1oY92NKjzaaVcrSk
 /VwZnpOBcbFfmkQ0wOXuRZvQnW01/WXjtCK76WV9lboF1k//MLwhUwc8mSLfgJw0qmOC
 gCqoUL2GVixz4fqD0KSkAj/x0S6XsIAy5AiI8gJi9avjROLA0gKLeYbBrwguiGca43Pt
 g2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788970056; x=1789574856;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jdoulqW/dybJZI4GeBlXySvh7R4n/US2mSH2P60zwMg=;
 b=Rw4sfVByRneU9N7WR2+tWSm+ZVtpEYzuda50MikgeIKaZnwbbEgKfpZ2qCPb7l/yYW
 6PSO+ZnJJqSqpI+Zl5rEtWo+FZF2x95BC/+eTFR2UxSXtwL5YrJHijenYkiGDX6M++dV
 mdTUCvhR/CrV92ZW+WB4Oier5cNw/6httF0jSUAcZwTMMDGU073F0glTdeQU7xPFzF8/
 dKmXWruHhsxW4T1F15Qk4tSsG/5bqpAdDdPhv9fcPJnxQ0vB2aw0Sklsw73BdOIo50Es
 HMIbyT+cacOuYdF3rjMD5IxB61dXBM16bC1kiRP/qB+QRK7Nlcm5nySylA772PL2aW0Q
 JlZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxX8nWZpI1VPXaPYL7YDaTm9mCxn4SDuCGC1zX1zKd9c1fGWKeehAY+XhOhk4E5gQy+3LL6HQN1@lists.freedesktop.org
X-Gm-Message-State: AFuF++k/xYwuiV1lqacx0Ng2sZpuindnp1ahv6rOyMpFgNeTgaraSc2g
 99TbUIQ3ZBoNQonDF4Paj5D/ldEVPYceZQZHqlTmhRCOF+qROfO1Z/4kgTd05fMZBJBB/x/MKoK
 3qCJvn+P3aIeScuLWu2yFtL19NkXYlwI=
X-Gm-Gg: AYBFou1vLEQ/qGwHxurQYoOJKk4CIsg5E8Jk69PMv3ozrFrT5yFT2QnKKO703PtRNIP
 fwpTxawTx6JMwIXRkv35imLPK8CoWnELBcYwQdd+O5k7xLqIBV1fgqgn2H+Dtsu+RraOBco4VlT
 R/2r+DINirPtTd5O2Z915xU/TjQ/sA7K2oXQZeP4Sh8p3xyv+DBlIF2QZxezNuOy2aWgYtmBUYJ
 e/r5q0Rq+mx0fmuKtadDAoxtrkOthRu1wPeySmrnV9sgC9IyPlg7cTfPONyRcHIZu4miOc5Jcne
 mppE99m7uyzDcl7ukNPYxdu6jC6x/Z028aurnBrnFY1s8Tqg9dJ6nJR7w1OSFhOeMgZzn27ptFb
 x+ombqbiI2Nd1bKKp2vRecOx1Ijfx/aaFU7oKAREP3w==
X-Received: by 2002:a17:90b:3bcf:b0:396:d27c:8696 with SMTP id
 98e67ed59e1d1-39b2693597emr36809891a91.4.1788970055249; Wed, 09 Sep 2026
 09:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260909093728.642473-1-yijiangshan@kylinos.cn>
In-Reply-To: <20260909093728.642473-1-yijiangshan@kylinos.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 9 Sep 2026 12:07:23 -0400
X-Gm-Features: AcwNN1Wg-EmmRELnPbnQlQ9xJ4UlYGkSyIL0bUzk_gGw4JWn23xrtxMYlOmL-yk
Message-ID: <CADnq5_PPJHOpgVo-+r-g6X1Z3r2wRJPkE-Dkp2gpt12Q5EGUvg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove redundant NULL check in
 amdgpu_cs_vm_handling
To: Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, tvrtko.ursulin@igalia.com, sunil.khatri@amd.com, 
 vitaly.prosyak@amd.com, pierre-eric.pelloux-prayer@amd.com, 
 moonafterrain@outlook.com, candice.li@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 13667453960@163.com
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

On Wed, Sep 9, 2026 at 9:05=E2=80=AFAM Jiangshan Yi <yijiangshan@kylinos.cn=
> wrote:
>
> bo_va is assigned from fpriv->csa_va, which is already verified to be
> non-NULL by the surrounding if statement. The inner NULL check can
> therefore never trigger and is dead code, so remove it.
>
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index 03b41f803520..c978f042ae1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1146,8 +1146,6 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_p=
arser *p)
>
>         if (fpriv->csa_va) {
>                 bo_va =3D fpriv->csa_va;
> -               if (!bo_va)
> -                       return -ENOMEM;
>                 r =3D amdgpu_vm_bo_update(adev, bo_va, false);
>                 if (r)
>                         return r;
> --
> 2.25.1
>
