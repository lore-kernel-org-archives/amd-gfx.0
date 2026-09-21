Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00ED5C982E6
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 21:42:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E28210E1AF;
	Mon, 21 Sep 2026 21:42:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WgS4xfGT";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 736FC10E1AF
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 21:42:15 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39b1a806664so661059a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 14:42:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790026935; cv=none;
 d=google.com; s=arc-20260327;
 b=Jvs/S9GRT0fg+Ve/mKnom6DD276KAd9KGgLGhlQqg0N6ZR+v1py9ByXr8GEuEN3IFN
 BQYLZRw3+uOsYKHf1NSQCnDrKmaIZATmX7FMxV5bzXV23Pzd+PFo4lCvGpCZ14fJAfUn
 ka+N1x6RgxT7X/KuGANZS0DwsXlTbQq6GuhiOF9G+fDHYwsHIiKdnsGn89HbmbMYM9jQ
 SyY43oaB1nUqwwvj1Y16cKulXO0IKFKgxwIDE4RrJCd2VnFeSmJyNSh7SEeVOhKcICa7
 LeXHlxzKISEAjqLlub+LMOC/pa9sQZqCv9xIFQJHTZr4vDEMMWJXTf0pMZq+qX1l13q5
 wZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hwKTDxgYEr2sfNH65Pp+X8RtvLMxX4nyJRz50jiRshk=;
 fh=328T9GRFRZ0Ry2IYaUGQb2Y6Pxk1+sxW1A/L2dQeS2g=;
 b=njanAitAAsTlJxZK3/fLOhptwdMmkidJCdUAWE+k5hEXML3rQ20Pv+a/MKhdhuq3Pl
 VudoEePKfHBVt8zesLohjb+wUQcZVs30FuAOzrW+l2ZYmI3lxHY0+Snul1pGQ6GEiPIc
 vrpb/QUHm7KRfHg1G8XLAcMnakjBSMbNE5k/Hv8IZP/Tjj+16mLnXrd5Y+fdiWjE/O80
 BRD8Wi9nd0W7bhSQ3gFDRm6NS0QHXmi1mSzTZsDKhafNNiB8hS2r8d/GESS1bIDsptWO
 PzTTv6mSSF5usJICkV0pL8qvg474XkQhE5UJ05FG4m4N8UPqrdBFxgicwzJk7bhDHz3g
 YvAA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790026935; x=1790631735; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hwKTDxgYEr2sfNH65Pp+X8RtvLMxX4nyJRz50jiRshk=;
 b=WgS4xfGTrE1c7DY3y8WIS9Jg5x2EK+Yo6OeHH0v0r5fh+xGgrRGZEDdZTaRo45BhII
 rys0jex6elqiRn0sXwmLLSsiU7cbW6QgahxGYR37z8jTM8pLC9GwbnXZEye1rFf4vRJf
 rwONLzlR2HfB/0r8+ts6b50b83CMntcUfXgknfK4I8BI/5gmJjqIEKrqMC9xtysyupFU
 LTy4JgILI7pp4TRh7tB0xondMMlzNJT2XiPUYYs5+CQ/7SpNd7Bb7oPwmFLvcxb4If2w
 Sk1IymrlXTSBgl/DR1rAxOeD0ayT7k0w+7ZzjWN5Ij5jticZNssyT6TVZIsMobxnuvxL
 k/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790026935; x=1790631735;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hwKTDxgYEr2sfNH65Pp+X8RtvLMxX4nyJRz50jiRshk=;
 b=lK2VQpEZVn1DiO62Uzw+FQ9cz3zMy0L9CZgPKPHhHYvqfF5IZ6rwuTk9XRsT4CgwZs
 54pURhGnaqhuuYsERP2v6LbDl70s0qYO8kpakvTPRcuGfRGGJJGZZ/a+V7MpaJ9ZwcKb
 xTrDYUoHfhspcMdpjlYhdc9NDW8jFYN3XMZaPJaQHdflzRorS+1/oE0cg4c5TZgn/rsf
 80vaZDXp58xSYvisQMxBPPId+rfY4pgigAxg9uHtBkN0C5N4L9dWdeega1U3uDAWuFOK
 Qplmy4542XlR2hsLSLStA6QcbPnZtxwo39z2feibLfR+gWBqaMkTZ0KG90oMJIZ3EaRm
 XcMg==
X-Gm-Message-State: AFuF++mhCIqWp00HAnafmJGmTlDhL0xJj3BT7vbUixvYXFqSWh/bU19s
 mu/tHacTDy8oTn06P1DIX9nGk5mdAsgOv8HwpJAqYVEh+co+DrpajtzPNEW2EjMm7r98GbQQdpf
 JAooszrVDamWyCXMoTEnWuSL3ViKAD3k=
X-Gm-Gg: AYBFou1s7ZpxjnwLBiwUf7LWVXIlF14GwiSqEio3K3rCkpL+p61x3ykJYNzywmqAHuO
 xiTAaeCgnC1g9GBbzh1pa3YBb2BoeqLbtGeuNaGjEWFbry9CDeZs66FoeTsDbxtcRRPCMDEAtnn
 wLRgrPReUoUpACo7V1llgo4VEU0ZaaxPsJHJnXEnOySOlkQNcbKOx4XfxQYpU5gLnZQg1EW+P6A
 JhyCJZCdZCOSUlCrZoDGVxy3LfcGzBpNLn7SXYM1v+w58WWIvM7kntjniaxGHJin6qzWhr8x9sW
 CgKzvOoT5krBLdV5yeXefZGQmojpyTk1RA30TB8PosNV9tKunKjinBsXBgn+YnUEjIkf6fMa4ny
 YI82rH+WrOuU9WQhst2VM8g4TKqyOMEGYI8uPAh/jhA==
X-Received: by 2002:a17:90b:50c6:b0:39d:e1f2:3400 with SMTP id
 98e67ed59e1d1-39e599ff59cmr21681662a91.5.1790026934918; Mon, 21 Sep 2026
 14:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260917185311.195635-1-jinhuieric.huang@amd.com>
In-Reply-To: <20260917185311.195635-1-jinhuieric.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Sep 2026 17:42:03 -0400
X-Gm-Features: AcwNN1Xc5mF4FAS52pp6XlHaab26Et7TGuHM_x73529HSpxp0vxAzLco-T22UBM
Message-ID: <CADnq5_NbW06k=LzhAYR_-CZgKsTXM4q7gd0Wh=egJTNQh7UwNA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: specify cwsr_enable usage doc
To: Eric Huang <jinhuieric.huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Thu, Sep 17, 2026 at 3:01=E2=80=AFPM Eric Huang <jinhuieric.huang@amd.co=
m> wrote:
>
> to prevent misunderstanding in cwsr off case.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 9c5e93cd3ee6..182142c9be8f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -762,11 +762,11 @@ MODULE_PARM_DESC(hws_max_conc_proc,
>   * DOC: cwsr_enable (int)
>   * CWSR(compute wave store and resume) allows the GPU to preempt shader =
execution in
>   * the middle of a compute wave. Default is 1 to enable this feature. Se=
tting 0
> - * disables it.
> + * disables it as only in non-HWS mode.
>   */
>  int cwsr_enable =3D 1;
>  module_param(cwsr_enable, int, 0444);
> -MODULE_PARM_DESC(cwsr_enable, "CWSR enable (0 =3D Off, 1 =3D On (Default=
))");
> +MODULE_PARM_DESC(cwsr_enable, "CWSR enable (0 =3D Off (debugging only), =
1 =3D On (Default))");
>
>  /**
>   * DOC: max_num_of_queues_per_device (int)
> --
> 2.43.0
>
