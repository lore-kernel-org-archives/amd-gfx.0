Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77BEC282CD
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 12:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 669BD10E11C;
	Mon,  3 Mar 2025 12:44:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hlZ2nWvr";
	dkim-atps=neutral
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74E3C10E11C
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 12:44:41 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id
 46e09a7af769-72726a5db1aso518900a34.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Mar 2025 04:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741005880; x=1741610680; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WiGAAXPvIqLweUz9J/8LdSF7oRq4bg8QGNegw72sT0A=;
 b=hlZ2nWvrqbZgLlhhBVq//an0cYNWxFOJhNKOvk9KWDAHOE6c5F9wkIYqC1KN7+Y5WS
 xUPqXWbXeX9mX00BSg31evRL5oHBQDkwsHN6rzhsI1IfFkX7QebdeE5e9oaBeDAEn//h
 LZJTWAcn9FwSyD7pIdEr1omQJbLo12s3e5gMV5yWtN5zwoiDrLmdcVauinU2aegsP6sT
 Y4lRkml+A/awWq8JDuTAKzvm6pG/HFPeRtTU8CB1zLZnh1WoqKAnHimCdqnB88KwwZJN
 x9MWkXJfJNDZkywvvMRiqOvzg/CknmHE448FgkZDuSWF8zDLKvLHq8029oFDZ1OEFBmP
 RV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741005880; x=1741610680;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WiGAAXPvIqLweUz9J/8LdSF7oRq4bg8QGNegw72sT0A=;
 b=u3TVyNqcmcjDVBut7juEJhWoB3F8f167eeV/BpR8ls8EZg+W2MUylvde6VXAalYNKv
 ePpyx9mOw2rq1DQYt06iDB1+iHzpRqtBlbOu+OTGZ9vTdKOmffFcFFjKuu58DdgPnIm7
 BZ2uERYvGeGO6zzGtYsnb9ecT5+SIOJYn/8LUU0ajhShWSjROtoKOEap9eunM62arwPc
 PE7p52+TJJFeb04uBABD77jEiLhvDIL4lTgx5u4CDSbkxXxBuaVHG7iBbhtF0MACjk+L
 7xMg0A8NfZepvJrUZZVqAeDXku4Eba1V/4CNJhsyxYEfxUdXXK3rk/837fYdRF8tq6+0
 8+oA==
X-Gm-Message-State: AOJu0Ywo0QoUj/VGAzPRnN+ccV0gEQx73+ot8SmUeAgP5c0zd8St0h28
 ofch4dC1et1M+ARtgqAMhqbxHPlqRYviMk7pwl0/k8IvJk7XbQp1AVPofwAom07L3mNKRUYXAKQ
 BvizUN3T+tNQr7TK8VEZ2u0qjTRw=
X-Gm-Gg: ASbGncsDaifAL+E6sTe5PX2Um1dnsf4i8Ndm2aWDejGKi/cxXkvVWmP1s/+vBQKRBFM
 QuKLN3bId+/QfHyzLk9w1ZDrS36O3hv6XAdyEwUPhNVWapzYv55VwBUfveIeSpggPIYF8Sfv9dH
 Z3gjaLmh2BeDgwUVeAqhAZFQcPrfs=
X-Google-Smtp-Source: AGHT+IHuXsD8NE6y48db+s2VP56XpTUEZkvYExSE2d3e/W8yGvkUhGQNKOLYX/E8xIY+Ox4sOjKKav25c+wj/e4Ypnk=
X-Received: by 2002:a05:6830:d08:b0:727:25d0:7f3a with SMTP id
 46e09a7af769-728b818a16amr3157368a34.0.1741005880373; Mon, 03 Mar 2025
 04:44:40 -0800 (PST)
MIME-Version: 1.0
References: <20190617214627.2768-1-u9vata@gmail.com>
In-Reply-To: <20190617214627.2768-1-u9vata@gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 3 Mar 2025 07:44:04 -0500
X-Gm-Features: AQ5f1JoHULXah27YB090jCv9VkbMFWGbSnPsaE9D-Rkkwaocd_DCuGYe10yBIyg
Message-ID: <CAAxE2A5h44-iFE=zW3MfWJoCe83ZtiV5m0dCZBg_-5ZkxE4s1w@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Fix rs400_gpu_init for ATI mobility radeon
 Xpress 200M
To: Richard Thier <u9vata@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="0000000000000d3b2b062f6f8549"
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

--0000000000000d3b2b062f6f8549
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>

On Tue, Jun 18, 2019 at 3:19=E2=80=AFAM Richard Thier <u9vata@gmail.com> wr=
ote:

> num_gb_pipes was set to a wrong value using r420_pipe_config
>
> This have lead to HyperZ glitches on fast Z clearing.
>
> See: https://bugs.freedesktop.org/show_bug.cgi?id=3D110897
>
> Signed-off-by: Richard Thier <u9vata@gmail.com>
> ---
>  drivers/gpu/drm/radeon/r300.c  |  3 ++-
>  drivers/gpu/drm/radeon/rs400.c | 21 +++++++++++++++++++--
>  2 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/r300.c b/drivers/gpu/drm/radeon/r300.=
c
> index 652126f..6724c15 100644
> --- a/drivers/gpu/drm/radeon/r300.c
> +++ b/drivers/gpu/drm/radeon/r300.c
> @@ -355,7 +355,8 @@ int r300_mc_wait_for_idle(struct radeon_device *rdev)
>         return -1;
>  }
>
> -static void r300_gpu_init(struct radeon_device *rdev)
> +/* rs400_gpu_init also calls this! */
> +void r300_gpu_init(struct radeon_device *rdev)
>  {
>         uint32_t gb_tile_config, tmp;
>
> diff --git a/drivers/gpu/drm/radeon/rs400.c
> b/drivers/gpu/drm/radeon/rs400.c
> index 4121209..4117572 100644
> --- a/drivers/gpu/drm/radeon/rs400.c
> +++ b/drivers/gpu/drm/radeon/rs400.c
> @@ -32,6 +32,9 @@
>  #include "radeon_asic.h"
>  #include "rs400d.h"
>
> +/* Needed for rs400_gpu_init that forwards to the r300 one */
> +void r300_gpu_init(struct radeon_device *rdev);
> +
>  /* This files gather functions specifics to : rs400,rs480 */
>  static int rs400_debugfs_pcie_gart_info_init(struct radeon_device *rdev)=
;
>
> @@ -252,8 +255,22 @@ int rs400_mc_wait_for_idle(struct radeon_device *rde=
v)
>
>  static void rs400_gpu_init(struct radeon_device *rdev)
>  {
> -       /* FIXME: is this correct ? */
> -       r420_pipes_init(rdev);
> +       /* Earlier code was calling r420_pipes_init and then
> +        * rs400_mc_wait_for_idle(rdev). The problem is that
> +        * at least on my Mobility Radeon Xpress 200M RC410 card
> +        * that ends up in this code path ends up num_gb_pipes =3D=3D 3
> +        * while the card seems to have only one pipe. With the
> +        * r420 pipe initialization method.
> +        *
> +        * Problems shown up as HyperZ glitches, see:
> +        * https://bugs.freedesktop.org/show_bug.cgi?id=3D110897
> +        *
> +        * Delegating initialization to r300 code seems to work
> +        * and results in proper pipe numbers. The rs400 cards
> +        * are said to be not r400, but r300 kind of cards.
> +        */
> +       r300_gpu_init(rdev);
> +
>         if (rs400_mc_wait_for_idle(rdev)) {
>                 pr_warn("rs400: Failed to wait MC idle while programming
> pipes. Bad things might happen. %08x\n",
>                         RREG32(RADEON_MC_STATUS));
> --
> 2.21.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--0000000000000d3b2b062f6f8549
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:m=
arek.olsak@amd.com">marek.olsak@amd.com</a>&gt;</div><br><div class=3D"gmai=
l_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue=
, Jun 18, 2019 at 3:19=E2=80=AFAM Richard Thier &lt;<a href=3D"mailto:u9vat=
a@gmail.com">u9vata@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">num_gb_pipes was set to a wrong value using r4=
20_pipe_config<br>
<br>
This have lead to HyperZ glitches on fast Z clearing.<br>
<br>
See: <a href=3D"https://bugs.freedesktop.org/show_bug.cgi?id=3D110897" rel=
=3D"noreferrer" target=3D"_blank">https://bugs.freedesktop.org/show_bug.cgi=
?id=3D110897</a><br>
<br>
Signed-off-by: Richard Thier &lt;<a href=3D"mailto:u9vata@gmail.com" target=
=3D"_blank">u9vata@gmail.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/radeon/r300.c=C2=A0 |=C2=A0 3 ++-<br>
=C2=A0drivers/gpu/drm/radeon/rs400.c | 21 +++++++++++++++++++--<br>
=C2=A02 files changed, 21 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/radeon/r300.c b/drivers/gpu/drm/radeon/r300.c<=
br>
index 652126f..6724c15 100644<br>
--- a/drivers/gpu/drm/radeon/r300.c<br>
+++ b/drivers/gpu/drm/radeon/r300.c<br>
@@ -355,7 +355,8 @@ int r300_mc_wait_for_idle(struct radeon_device *rdev)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
=C2=A0}<br>
<br>
-static void r300_gpu_init(struct radeon_device *rdev)<br>
+/* rs400_gpu_init also calls this! */<br>
+void r300_gpu_init(struct radeon_device *rdev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t gb_tile_config, tmp;<br>
<br>
diff --git a/drivers/gpu/drm/radeon/rs400.c b/drivers/gpu/drm/radeon/rs400.=
c<br>
index 4121209..4117572 100644<br>
--- a/drivers/gpu/drm/radeon/rs400.c<br>
+++ b/drivers/gpu/drm/radeon/rs400.c<br>
@@ -32,6 +32,9 @@<br>
=C2=A0#include &quot;radeon_asic.h&quot;<br>
=C2=A0#include &quot;rs400d.h&quot;<br>
<br>
+/* Needed for rs400_gpu_init that forwards to the r300 one */<br>
+void r300_gpu_init(struct radeon_device *rdev);<br>
+<br>
=C2=A0/* This files gather functions specifics to : rs400,rs480 */<br>
=C2=A0static int rs400_debugfs_pcie_gart_info_init(struct radeon_device *rd=
ev);<br>
<br>
@@ -252,8 +255,22 @@ int rs400_mc_wait_for_idle(struct radeon_device *rdev)=
<br>
<br>
=C2=A0static void rs400_gpu_init(struct radeon_device *rdev)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* FIXME: is this correct ? */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0r420_pipes_init(rdev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Earlier code was calling r420_pipes_init and=
 then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * rs400_mc_wait_for_idle(rdev). The problem is=
 that <br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * at least on my Mobility Radeon Xpress 200M R=
C410 card<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * that ends up in this code path ends up num_g=
b_pipes =3D=3D 3<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * while the card seems to have only one pipe. =
With the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * r420 pipe initialization method.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Problems shown up as HyperZ glitches, see:<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * <a href=3D"https://bugs.freedesktop.org/show=
_bug.cgi?id=3D110897" rel=3D"noreferrer" target=3D"_blank">https://bugs.fre=
edesktop.org/show_bug.cgi?id=3D110897</a><br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Delegating initialization to r300 code seems=
 to work<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * and results in proper pipe numbers. The rs40=
0 cards <br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * are said to be not r400, but r300 kind of ca=
rds.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0r300_gpu_init(rdev);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rs400_mc_wait_for_idle(rdev)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_warn(&quot;rs400=
: Failed to wait MC idle while programming pipes. Bad things might happen. =
%08x\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 RREG32(RADEON_MC_STATUS));<br>
-- <br>
2.21.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a></blockquote></div>

--0000000000000d3b2b062f6f8549--
