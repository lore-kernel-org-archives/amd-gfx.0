Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768D3D1D478
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 18:08:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AEB510E7B3;
	Thu,  8 Jan 2026 18:08:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DPqSFWpZ";
	dkim-atps=neutral
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79FA410E7AE
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 18:08:24 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2b1161400afso147313eec.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Jan 2026 10:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767895704; x=1768500504; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DXUS0sW8xDHB4c+xLKoLwXG7WUF7jqTtXhEgI5LQ8k4=;
 b=DPqSFWpZEspCoM8jVvoJFfZ4JTbF5Zm0xerIDf6DjXZGcM/mIDMQsOhPRmScRtHC39
 cVriBw6k2woP8te1CNHniOy4YdBgUNPL4BMVXN+7FrX82WTaqBtaXKF3n1LBFvrDuYYG
 5lbcPZzhHLiBNypHxda9dUG1vEi2eEEsySy+tLDwt/PVJoQE7iQkj01pVI/UcmANlyJt
 kWEKSB8TEEBT9Dtd2EX2rwteoF/dJtiKvcv4kovMw9h2qHzkUeq9AptTLwAD8wNhQHGI
 58FGH6PaD59+M8ACDDoasYfDj8gGWu/v6chUkhVmK7C2zdmAkan010OoctGRcQt9csHm
 FZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767895704; x=1768500504;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DXUS0sW8xDHB4c+xLKoLwXG7WUF7jqTtXhEgI5LQ8k4=;
 b=WAWMVJ8umo0IlxtzkyGU1qTyfiKTJsBAwhHLAzg1LlNpHUw4mhvZ1BheVrt1+wgBd7
 2UG2B3fLqGRbreZhDwRmnupEuTtTEIbotwcoelo2jMzoqp+Q68TQW0RG39G0SVrFz7tC
 cb4V7HD7mlXz0WQDE7FIhX2P6KJ+9m7uz77QMuhE0MRbzqV/2zDBh34ZYgES5ay44x1f
 9/K9KqPe06IE+DDknj8IGORJ36zua8j0HyK4sKYVbDUlaaP0wOu8VNo4rzms6nU4neIa
 FY6VAU7YCMoaig0mDX2dd8kK0WTYjQYTr0H71Kukz30ahSozIf/usUAUWxX0APrVo6ck
 o2HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRXCkHKrQgttPJ8PkJHBvPKgevWKVMCJpPWncVrl+F0V4vDK/gl1Cdda+Yz0iQK3T9KAwGloXw@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwpmUrGGywgnDNuYHANnvvXuoWq+roOqpzOmn0QnZmDWa8ll/UI
 MoWkzDn3mjXy7fWS9CbvxH5gsHjA8KOW9z0ot69v4OuJw0eEXez40cj4Ss+TyJp/5ONGh382OLY
 6FsmC88E13sQWzvBgto2pKUk4UsDQSGE=
X-Gm-Gg: AY/fxX5eTdRGmSOmp7E2AMmsrToeOF9u1yAiIU60OEexwFZ4eySFcb8r4G9/GKYp5Nl
 RaAMEPUgfw5oG2GR8yULxeCNHEqi1nkjEEwabrbmzGQzDbFOyrcpR0uO8AhukUqQpgK7YfmhpR3
 QpdDBcJRnr7i7oVA9wksitqo1ZFJ6VHVg3ewMvvok/3JTa2t6xhD4bdYNpm5S1YUpRJBuFM/afK
 +0+BSZfJOXhIk5/JA98eqLgtEL9VDI7y+haFfRQc3aI8sLLC/Rp2oXIUVdk6c0E6V/Zm6p/
X-Google-Smtp-Source: AGHT+IEMxYW5olsKhaFfSHEchb/xPWvGCY1hA4pzxMkgokTlS6YbyEil5FB2/wbNWl91n/7QB6Jp9tN/G6GmQ66/ivs=
X-Received: by 2002:a05:7022:6723:b0:11a:2020:ac85 with SMTP id
 a92af1059eb24-121f8b7d702mr3293866c88.4.1767895703446; Thu, 08 Jan 2026
 10:08:23 -0800 (PST)
MIME-Version: 1.0
References: <66adb62e93993ac0a70fdbe174908c36a560b98d.1766330018.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <66adb62e93993ac0a70fdbe174908c36a560b98d.1766330018.git.christophe.jaillet@wanadoo.fr>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 Jan 2026 13:08:12 -0500
X-Gm-Features: AQt7F2qpeJJDtMGtlgzzhVlKAJGrFRpZjPdprLstNhcJ3aZVDrytkh8Vd6C19_4
Message-ID: <CADnq5_N3JiRShWTa7N+C+b_-cBxOiyAo_XiDSn0W-J3LaUfqgA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Slightly simplify base_addr_show()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

On Sun, Dec 21, 2025 at 10:31=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> sysfs_emit_at() never returns a negative error code. It returns 0 or the
> number of characters written in the buffer.
>
> Remove the useless tests. This simplifies the logic and saves a few lines
> of code.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 20d05a3e4516..b44f0710b00e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -888,22 +888,19 @@ static ssize_t num_base_addresses_show(struct ip_hw=
_instance *ip_hw_instance, ch
>
>  static ssize_t base_addr_show(struct ip_hw_instance *ip_hw_instance, cha=
r *buf)
>  {
> -       ssize_t res, at;
> +       ssize_t at;
>         int ii;
>
> -       for (res =3D at =3D ii =3D 0; ii < ip_hw_instance->num_base_addre=
sses; ii++) {
> +       for (at =3D ii =3D 0; ii < ip_hw_instance->num_base_addresses; ii=
++) {
>                 /* Here we satisfy the condition that, at + size <=3D PAG=
E_SIZE.
>                  */
>                 if (at + 12 > PAGE_SIZE)
>                         break;
> -               res =3D sysfs_emit_at(buf, at, "0x%08X\n",
> +               at +=3D sysfs_emit_at(buf, at, "0x%08X\n",
>                                     ip_hw_instance->base_addr[ii]);
> -               if (res <=3D 0)
> -                       break;
> -               at +=3D res;
>         }
>
> -       return res < 0 ? res : at;
> +       return at;
>  }
>
>  static struct ip_hw_instance_attr ip_hw_attr[] =3D {
> --
> 2.52.0
>
