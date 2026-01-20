Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC175D2629C
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 20:33:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7231910E220;
	Tue, 20 Jan 2026 20:33:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DgGLs0Zp";
	dkim-atps=neutral
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB8B810E220
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 20:33:01 +0000 (UTC)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-1233be8d537so285240c88.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 12:33:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768941181; cv=none;
 d=google.com; s=arc-20240605;
 b=jEJimMKp3K01he4QuaD3CMr5xkdmAEncU2w5GbWw9Wafzq8r4uLpQT5ra6JxrQkG2D
 GiXd7QGOwbe/4cRItTCb3CBeUR1HADYnRQAYYLucI3mG21s70/Pg6I75UTtDV54Uk6Lg
 0rpxrGI1LbDiTiKDeXK4TKhWFFe3626opPvq1S3dljJmbbN+y3nXSLhDi1dPVrkE20Fy
 c0iI2runxMmfm22IP6f9O7EvAtYb4Hd1E5rCoEskeekgLBQ3zxqUoDiNnC5cftIHYTwJ
 u3NP95imHRAxLfKhkkevnMvnCpdMtBY8Yh+IymyfI3xdOwTaMDCbET7ve66GqU5Qze3f
 +xWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mx5L6RmiDhLEM8CtgXu51ebxKBcqBK9MOcPGef4xhMU=;
 fh=Wm+dBTpkeAockhU0HYFJG/ekgvRwVZhULKlXLvO6i1A=;
 b=fqExlKaqEF0V1aub1HsmhIzEcvMf5yyleisp/44AeOlEaVnVEuzmEYv3z4pqQ8lKuV
 thsc3yL8KBdBeRcyK2bAFTK/Eg9Q0FGiwxI2+cXVIlvy1XvpMHxfGdQOAblTaKz9FEO+
 GV3uB/S/QkCbLCpHrn5/sIyefocymkZOT+esgnTlIECklyXWBV2IwVCNmYPqK66gGEgC
 oXMW57Xf3uuD5Mnxi4a+hMrK4XRi6gn0bczRIrel82OtVySVbwnWJ+/XvsiuGIDOYw2A
 2s2PEEQx3nj2w5Co8pq3JiWaS0YXb9cBQI/U+DvEOOw2KKmrQsixJBiMxDv8yVVdVi+S
 U6Gg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768941181; x=1769545981; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mx5L6RmiDhLEM8CtgXu51ebxKBcqBK9MOcPGef4xhMU=;
 b=DgGLs0ZpExc6JWvql8KC9OeqL+UfOUmI7KlJTdzv9nk9e5GwUDcn1CYCBw2UjNRYjy
 8bUPFkob5qgqm8bbiaD8evTSTQ9wjxiORjfBxHoNd7bmOIe65lmsWYB26Xt7Sa57r6VU
 TKU79r29b4BekoWsmQJgDpVjw/o+UwVLeWku5h896LGNKOPVhCL1Z4hhIZtTKeICw7Ek
 ITct/qx/fZOD0Dpm/UeFImBhQGc0oLREmoR7/jOe434FP/lg6yUtsaiWoSf/eVrxdR1L
 k+Fe0bq6pIqWYc4CmsKYbk8uE12b2Iy6kzxSfqCB0+nM8qc5lrr6WRyG6TY8UoEKx5m7
 gIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768941181; x=1769545981;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mx5L6RmiDhLEM8CtgXu51ebxKBcqBK9MOcPGef4xhMU=;
 b=FAIHDXUttq1a53BdMa6G3+gFvwN8JCVSwLXcLD8qCaigmePJ7wVK79G/MBUVOZ1UCj
 K/ivYv1RK0VKp0PnVadqdCgJR2Nsw8mEC1n5MC5+hIg8Lf9vqHYRXR9C2342XL6aBJxD
 3px3bjj3PPsV8Gp6TP82ujgr0dBM3PUGIQaaKJCR6iDbMAhGegKWP1wcVhPYHOVnjUm5
 /Malle7I+oOUxBoIEeOSBUbN+xykcoYURrnh7MgIgPuQNpUYS6QVWtJR5EJSH1Xvj+R6
 fimDFN0RPyYjBmSAU+HbGQEdKBqQapHpm0VQXy8MQD6a8xspI/8RMigqN/kViA+ifzf0
 hcpQ==
X-Gm-Message-State: AOJu0Ywu+9jNd605ugEqO1rbruy2g4oTP0bXsbwlPn8z5qhkfG1hf8H7
 uNZkdJG5gPazOlLwmxMlVPGsKEXirmSRbGo93BJHofyP4QQpsaCn4am76sNC1cavLLfD5uH4Kxr
 IjftnpJnwFlZSVio73ggCWW+fBDSiIl4=
X-Gm-Gg: AY/fxX7cml3C2LOcdiAU6XvD8FX2enr66ei6IyACI65dij2Ck6JgQVjKyiNKm/Q/ZiS
 0a8VNxaVUyyFQgNdD8jmimo0jt+Y79AuSVS1JirjFo+iPnM8+w0FxdzlcyszAxHl4b3xX2x6p4B
 C2NLoJhPyaUGa08KOBU0RDLCOWi/6vcE3L4zuZFBglPAjc/hn6YzVhRaH7oC5O9+7MiPKZK+8n5
 +yRNIZP5m+Wi7+LklXmov8/6+90WmaY4WvqZnpgLIyBEUmBhem6VeeWqaqvXiGDHTupJ4Io
X-Received: by 2002:a05:7023:886:b0:123:2d38:929b with SMTP id
 a92af1059eb24-1244a80e7femr5434051c88.6.1768941180927; Tue, 20 Jan 2026
 12:33:00 -0800 (PST)
MIME-Version: 1.0
References: <20260119203626.16070-1-timur.kristof@gmail.com>
 <20260119203626.16070-6-timur.kristof@gmail.com>
In-Reply-To: <20260119203626.16070-6-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Jan 2026 15:32:48 -0500
X-Gm-Features: AZwV_Qizps6--jhR6oe-MCn2huAAdoVFNhqZu_IApgK-2VZWqOfYFB2UmPJ5B6o
Message-ID: <CADnq5_OE3eKhEP7ce-zk3qkMejzqwEu2LRwxWw768=nW=wAbmQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/amd/pm: Correct comment above power2_cap
 attributes
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com, Mario Limonciello <mario.limonciello@amd.com>, 
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, 
 Prike Liang <Prike.Liang@amd.com>
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

I'll pull them in today.

Thanks!

On Mon, Jan 19, 2026 at 3:36=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> Previously only Van Gogh supported this, but that is not true
> anymore since:
> commit f9005c8896f8 ("drm/amd/pm: Expose ppt1 limit for gc_v9_5_0")
>
> Update the comment to reflect that.
>
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index 4c152df3fdfa..1ea0f073706d 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3879,7 +3879,7 @@ static umode_t hwmon_attributes_visible(struct kobj=
ect *kobj,
>              attr =3D=3D &sensor_dev_attr_temp3_emergency.dev_attr.attr))
>                 return 0;
>
> -       /* only Vangogh has fast PPT limit and power labels */
> +       /* only a few GPUs have fast PPT limit and power labels */
>         if ((attr =3D=3D &sensor_dev_attr_power2_cap_max.dev_attr.attr ||
>              attr =3D=3D &sensor_dev_attr_power2_cap_min.dev_attr.attr ||
>              attr =3D=3D &sensor_dev_attr_power2_cap.dev_attr.attr ||
> --
> 2.52.0
>
