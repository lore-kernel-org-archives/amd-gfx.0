Return-Path: <SRS0=F4UR=MY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DD9C4338F
	for <amd-gfx@archiver.kernel.org>; Sun,  1 Aug 2021 11:57:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F319A610CE
	for <amd-gfx@archiver.kernel.org>; Sun,  1 Aug 2021 11:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F319A610CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E3186E11E;
	Sun,  1 Aug 2021 11:57:12 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C4226E11E
 for <amd-gfx@lists.freedesktop.org>; Sun,  1 Aug 2021 11:57:11 +0000 (UTC)
Received: by mail-qk1-x72f.google.com with SMTP id o13so14044833qkk.9
 for <amd-gfx@lists.freedesktop.org>; Sun, 01 Aug 2021 04:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bXFWPjGcya9hWSZnyFjxRqLYpp8UM9mJknfhYB1NjEo=;
 b=pcOAMcURXmElN1e892C8Tr2ITWjYXBBINoEq1P7fv4wdcl5XKzmfs0hoZgifO5RIzh
 lxwXm1CGaEFo6IEDnF9/bCvRQz/kbdifkfOMeR7O8sE8YdNtBdM6T2dJXDLtiS2PCjYb
 PFLg5x46DBkqmAcup8gcxb94c+5aVhguV1JqQhEALONMxaX7hIAO0AoB1vJ0UTnYJIuO
 dIH6MXX6DhmjUa0a9TCAo7Zw6xJzcS3nFMaviBaPF5/ZStFdAOi+p/wkiO3UD/ELM5k3
 92n7s2YJ6AmQALJg694D6SsMtnR0+Qdp0R4KthYNMHpwfagNmJ2osz85hfh68HRVIISw
 81Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bXFWPjGcya9hWSZnyFjxRqLYpp8UM9mJknfhYB1NjEo=;
 b=kW4M8nSJcKAFSxt3ZcHEEd7vN46JmkmlDLVNu/468N2/o0KcDdjxHo6np6tRaFGMjK
 eM8j/s2pHwZIBlsS7GA60D2OMkpJ4XVX76Yu/sVPnLOXS5MeEklkvfFbgXatYNqjcah6
 7zpRbSemMi6BkOHYtvFt1K95jSr6HDNELnGYz9/ATeWDFQIRjSe7X39gy4I0k7j3YLSG
 H8299xbH74MCNTiy5TAKynfEwRwPZeg9mU48TVm14lAeRt+D8+Kdts/IkrY+sO0+hTe+
 qzPnwWI0THs6Q2qTvePz0wxuR7WqHbS/r3wGGTAnLaWXBBv/tNAWeKkEBJL+0qDvJqrK
 rrAA==
X-Gm-Message-State: AOAM53216m9JxS/uhaIaBkgh1G6IpYfnU2gtqiwSPAqS1p+AOL3eb+7F
 XtXxzowh2/5UF4WfCGeKTX4HBPNnz+zQb7m/2jn9xg==
X-Google-Smtp-Source: ABdhPJzHXXYqiPgT0QAy72N0SJdxdh7al8XZTRNsCo+n87+N60A7+53XfQmS5BaotDU4mPNB314otG78IHH44yVAAV4=
X-Received: by 2002:a37:68c9:: with SMTP id
 d192mr10939940qkc.212.1627819030443; 
 Sun, 01 Aug 2021 04:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210728040741.2734771-1-likun.gao@amd.com>
In-Reply-To: <20210728040741.2734771-1-likun.gao@amd.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Sun, 1 Aug 2021 12:56:59 +0100
Message-ID: <CAHbf0-GmyiEdV_2r8EcvUjm78UTKxYi7-yURa6ZkqjpfmSj4TQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: adjust fence driver enable sequence
To: Likun Gao <likun.gao@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: multipart/alternative; boundary="000000000000118e5505c87e27c1"
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

--000000000000118e5505c87e27c1
Content-Type: text/plain; charset="UTF-8"

Hi

This patch is causing me issues on my Skylake/Tonga PRIME laptop, reverting
sorts it

More details here: https://gitlab.freedesktop.org/drm/amd/-/issues/1668

Cheers

Mike

On Wed, 28 Jul 2021 at 05:07, Likun Gao <likun.gao@amd.com> wrote:

> From: Likun Gao <Likun.Gao@amd.com>
>
> Fence driver was enabled per ring when sw init on per IP block before.
> Change to enable all the fence driver at the same time after
> amdgpu_device_ip_init finished.
> Rename some function related to fence to make it reasonable for read.
>
> Signed-off-by: Likun Gao <Likun.Gao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 15 ++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  4 ++--
>  3 files changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index d3a4299b1f30..77195a4e5c59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3675,6 +3675,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>                 goto release_ras_con;
>         }
>
> +       amdgpu_fence_driver_hw_init(adev);
> +
>         dev_info(adev->dev,
>                 "SE %d, SH per SE %d, CU per SH %d, active_cu_number %d\n",
>                         adev->gfx.config.max_shader_engines,
> @@ -3939,7 +3941,7 @@ int amdgpu_device_suspend(struct drm_device *dev,
> bool fbcon)
>         /* evict vram memory */
>         amdgpu_bo_evict_vram(adev);
>
> -       amdgpu_fence_driver_suspend(adev);
> +       amdgpu_fence_driver_hw_fini(adev);
>
>         amdgpu_device_ip_suspend_phase2(adev);
>         /* evict remaining vram memory
> @@ -3984,7 +3986,7 @@ int amdgpu_device_resume(struct drm_device *dev,
> bool fbcon)
>                 dev_err(adev->dev, "amdgpu_device_ip_resume failed
> (%d).\n", r);
>                 return r;
>         }
> -       amdgpu_fence_driver_resume(adev);
> +       amdgpu_fence_driver_hw_init(adev);
>
>
>         r = amdgpu_device_ip_late_init(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 72d9b92b1754..e2f606bca779 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -417,9 +417,6 @@ int amdgpu_fence_driver_start_ring(struct amdgpu_ring
> *ring,
>         }
>         amdgpu_fence_write(ring, atomic_read(&ring->fence_drv.last_seq));
>
> -       if (irq_src)
> -               amdgpu_irq_get(adev, irq_src, irq_type);
> -
>         ring->fence_drv.irq_src = irq_src;
>         ring->fence_drv.irq_type = irq_type;
>         ring->fence_drv.initialized = true;
> @@ -572,14 +569,14 @@ void amdgpu_fence_driver_fini_sw(struct
> amdgpu_device *adev)
>  }
>
>  /**
> - * amdgpu_fence_driver_suspend - suspend the fence driver
> + * amdgpu_fence_driver_hw_fini - disable the fence driver
>   * for all possible rings.
>   *
>   * @adev: amdgpu device pointer
>   *
> - * Suspend the fence driver for all possible rings (all asics).
> + * Disable the fence driver for all possible rings (all asics).
>   */
> -void amdgpu_fence_driver_suspend(struct amdgpu_device *adev)
> +void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
>  {
>         int i, r;
>
> @@ -603,18 +600,18 @@ void amdgpu_fence_driver_suspend(struct
> amdgpu_device *adev)
>  }
>
>  /**
> - * amdgpu_fence_driver_resume - resume the fence driver
> + * amdgpu_fence_driver_hw_init - enable the fence driver
>   * for all possible rings.
>   *
>   * @adev: amdgpu device pointer
>   *
> - * Resume the fence driver for all possible rings (all asics).
> + * Enable the fence driver for all possible rings (all asics).
>   * Not all asics have all rings, so each asic will only
>   * start the fence driver on the rings it has using
>   * amdgpu_fence_driver_start_ring().
>   * Returns 0 for success.
>   */
> -void amdgpu_fence_driver_resume(struct amdgpu_device *adev)
> +void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
>  {
>         int i;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index e7d3d0dbdd96..64471018f5e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -117,8 +117,8 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring
> *ring,
>  int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
>                                    struct amdgpu_irq_src *irq_src,
>                                    unsigned irq_type);
> -void amdgpu_fence_driver_suspend(struct amdgpu_device *adev);
> -void amdgpu_fence_driver_resume(struct amdgpu_device *adev);
> +void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
> +void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
>  int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fence,
>                       unsigned flags);
>  int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--000000000000118e5505c87e27c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<div><br></div><div>This patch is causing me issues on m=
y Skylake/Tonga PRIME laptop, reverting sorts it</div><div><br></div><div>M=
ore details here: <a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issue=
s/1668">https://gitlab.freedesktop.org/drm/amd/-/issues/1668</a><br></div><=
div><br></div><div>Cheers</div><div><br></div><div>Mike</div></div><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 28 Jul=
 2021 at 05:07, Likun Gao &lt;<a href=3D"mailto:likun.gao@amd.com">likun.ga=
o@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Likun Gao &lt;<a href=3D"mailto:Likun.Gao@amd.com" target=
=3D"_blank">Likun.Gao@amd.com</a>&gt;<br>
<br>
Fence driver was enabled per ring when sw init on per IP block before.<br>
Change to enable all the fence driver at the same time after<br>
amdgpu_device_ip_init finished.<br>
Rename some function related to fence to make it reasonable for read.<br>
<br>
Signed-off-by: Likun Gao &lt;<a href=3D"mailto:Likun.Gao@amd.com" target=3D=
"_blank">Likun.Gao@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |=C2=A0 6 ++++--<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c=C2=A0 | 15 ++++++---------<=
br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h=C2=A0 =C2=A0|=C2=A0 4 ++--<b=
r>
=C2=A03 files changed, 12 insertions(+), 13 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index d3a4299b1f30..77195a4e5c59 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -3675,6 +3675,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto release_ras_co=
n;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_fence_driver_hw_init(adev);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info(adev-&gt;dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;SE %d, SH per=
 SE %d, CU per SH %d, active_cu_number %d\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 adev-&gt;gfx.config.max_shader_engines,<br>
@@ -3939,7 +3941,7 @@ int amdgpu_device_suspend(struct drm_device *dev, boo=
l fbcon)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* evict vram memory */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_bo_evict_vram(adev);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_fence_driver_suspend(adev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_fence_driver_hw_fini(adev);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_device_ip_suspend_phase2(adev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* evict remaining vram memory<br>
@@ -3984,7 +3986,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool=
 fbcon)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(adev-&gt;de=
v, &quot;amdgpu_device_ip_resume failed (%d).\n&quot;, r);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_fence_driver_resume(adev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_fence_driver_hw_init(adev);<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D amdgpu_device_ip_late_init(adev);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_fence.c<br>
index 72d9b92b1754..e2f606bca779 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c<br>
@@ -417,9 +417,6 @@ int amdgpu_fence_driver_start_ring(struct amdgpu_ring *=
ring,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_fence_write(ring, atomic_read(&amp;ring-=
&gt;fence_drv.last_seq));<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (irq_src)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_irq_get(adev=
, irq_src, irq_type);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ring-&gt;fence_drv.irq_src =3D irq_src;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ring-&gt;fence_drv.irq_type =3D irq_type;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ring-&gt;fence_drv.initialized =3D true;<br>
@@ -572,14 +569,14 @@ void amdgpu_fence_driver_fini_sw(struct amdgpu_device=
 *adev)<br>
=C2=A0}<br>
<br>
=C2=A0/**<br>
- * amdgpu_fence_driver_suspend - suspend the fence driver<br>
+ * amdgpu_fence_driver_hw_fini - disable the fence driver<br>
=C2=A0 * for all possible rings.<br>
=C2=A0 *<br>
=C2=A0 * @adev: amdgpu device pointer<br>
=C2=A0 *<br>
- * Suspend the fence driver for all possible rings (all asics).<br>
+ * Disable the fence driver for all possible rings (all asics).<br>
=C2=A0 */<br>
-void amdgpu_fence_driver_suspend(struct amdgpu_device *adev)<br>
+void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i, r;<br>
<br>
@@ -603,18 +600,18 @@ void amdgpu_fence_driver_suspend(struct amdgpu_device=
 *adev)<br>
=C2=A0}<br>
<br>
=C2=A0/**<br>
- * amdgpu_fence_driver_resume - resume the fence driver<br>
+ * amdgpu_fence_driver_hw_init - enable the fence driver<br>
=C2=A0 * for all possible rings.<br>
=C2=A0 *<br>
=C2=A0 * @adev: amdgpu device pointer<br>
=C2=A0 *<br>
- * Resume the fence driver for all possible rings (all asics).<br>
+ * Enable the fence driver for all possible rings (all asics).<br>
=C2=A0 * Not all asics have all rings, so each asic will only<br>
=C2=A0 * start the fence driver on the rings it has using<br>
=C2=A0 * amdgpu_fence_driver_start_ring().<br>
=C2=A0 * Returns 0 for success.<br>
=C2=A0 */<br>
-void amdgpu_fence_driver_resume(struct amdgpu_device *adev)<br>
+void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.h<br>
index e7d3d0dbdd96..64471018f5e6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
@@ -117,8 +117,8 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *r=
ing,<br>
=C2=A0int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_irq_src *=
irq_src,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned irq_type);<br>
-void amdgpu_fence_driver_suspend(struct amdgpu_device *adev);<br>
-void amdgpu_fence_driver_resume(struct amdgpu_device *adev);<br>
+void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);<br>
+void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);<br>
=C2=A0int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fe=
nce,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 unsigned flags);<br>
=C2=A0int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,<=
br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>

--000000000000118e5505c87e27c1--
