Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3FA10854D3
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 08:34:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA0A710E75B;
	Wed, 18 Mar 2026 08:34:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="brUwZJ5Q";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2870C8985A
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 20:41:01 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso55794325e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 13:41:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773780060; cv=none;
 d=google.com; s=arc-20240605;
 b=GFanOGW4XzocEWuWyQNZH69lhNMpEmCxZojejTZ4Ya/ddjf8UkdHZI8CgbGhLeUUYQ
 j6WkFWZ5iZ46Vptl3VJlRwmAx0AMwSJLDEz/p3bUopTSVAHXnd9Rca+anIzwCWMM2iQs
 yH4g0QoWoDQ1fhRvP1suG6es427bn7CjhN0J9mwRbIIZosqgLR5Lz7/BqURCMWhy45GY
 1/rI6M9+9pj3vxUB/1dLCg6QIhWqVEggGx854Z7UAZOIDtsUpsTU386NBjbt7C3cCmNf
 LNbm+LSdOAU181C6oXyYa3o+zFeRxX/BSSQAXiY6C1lRrE9dCX+at9pyCyIdvqvmfn+t
 MjcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rhv6AjfBMDAJLnR5ORgFiY/Hkt76XAnFcNgN33rpKMw=;
 fh=2SH6jEBmmW2m5BUr6cM8Ej8440MTBqF8ejZlF1b0u2c=;
 b=JPgK+oD9cGpPBr7A8SYAzeehjHq3T84guthkVsznsdMO/5NAPRb6ctONnAkRiJJwj1
 8VVDqHnBN8X5G5OwbWnLdFkzOOZnr8q9dcw+dHpJDcJAqKL2HFXttyhqS5qDzklGhn/K
 BQpz9BugYr7lxBe5HQWEL1zoekrwM/aUQPV5JP4ksSGt90a3PW7LgBxM54dJVwsZOQ47
 xjNVLxVAoaST1GTycO1OPSUAtdqAUD3qxZV+VriQZBw3eTQvVecSXCqyBv8+/kZoA+S/
 A8Ezd+g+N9bwBnCBV8DcboEBGKF5U15Kn7tHl2WQGT41osmi7f0xRb7xX+zWMAKeK9sf
 lIoA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773780060; x=1774384860; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rhv6AjfBMDAJLnR5ORgFiY/Hkt76XAnFcNgN33rpKMw=;
 b=brUwZJ5QCzmyA/qoyiI2fsl0+jbyss8G8mLtu5iekNr8Xg9FT/YW/RPxubG7SU1ZWZ
 Wl5EfL+IZZWq5KSs34x6P+9656iYD96mtXKpz8PxPLjQX6OGakBo2BxevpvOBRq/uELv
 DPT1APwXthFFoW8BNcVonaA8pA/JdMFTvXNk7ij3MraDdUAICemRAc9bJqQn93935hJI
 Qe6ccf2ZufPjNwf9vVayZXBj/mZy5fOeBJ5WK30xyq+QrXlFs56mJ89e/jy1prRq2o4B
 bQMulxkUbIsm+ZEaIkoP5wjAWGA7PCm3kiWFD/5oEdyfM57F3Hg6HND27wQ3Cs4EVSUR
 oHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773780060; x=1774384860;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rhv6AjfBMDAJLnR5ORgFiY/Hkt76XAnFcNgN33rpKMw=;
 b=cj8wXVq/3KSVoNSg/p+/GySz6PnDxqp7JYF3pY3aZU4b22VYe1vVMUVU+W79wYtMum
 UTXawkQmH8Ya2rNj5RTXDqlcdM8BDlKuXT/lLvfdGrKyonOsolQy90KBl4tVphITXHx6
 A+DyCrPsmTv3zJ9RiSKLSgDzCJINAoZk0Yl/X01VTlT/05XbNtxf8caFntqQG/EFHhDv
 7w9bDooKu/+rHhX7YpkBfhIWtfWCSKg/IJHCyXqfBJB1mgNk+irDiHXzkIPF2wyz6tWP
 QOzocLhENGZHrEovmQY3tklvAxg/0Xlg4G5osj2Zy45MxTyms8fvsE1PeHPip3DVLIb/
 6qKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnB49G0swKm/N6LN3qafQhM85vYvDlqTKwnbdlcFTcr7e766gVS7sd9FsdwLAzbGOOSLLX9Nps@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywh8aMRnV7r/9GhNaCZKurkNEOKLJgww6XVXXwVzzaJXwOKumR+
 wa/upm2zQo7cF0fHTlFbDp0ak7LNXD4FVhZpxHd4J+YSD+1UlO2Wf7NdZ6eQBGvJGDqCXDiXnuM
 o4jl+wLU1KRzB6Vvy636YgwPBj7yFGDZG+DZiMuA=
X-Gm-Gg: ATEYQzx2enYqApiXXa3wGPcU+y4iZMUZuiUSRS+UIJN2ZAgpg+ttkcwEmqxIptK7qwG
 +Lhf5D1Ym4WcUtf/pwtkjDFFxdKY7VvRxCLf27wJX94Va0AQwIvwgrFbNyIJoiylTURdoZKoloo
 lwcj6VuwVB8g59D+mbEx+yJ6GocZCLbnE4ojE/cMEQF9qxFQLoMNb71YBGRT7YPoiPEobWnUK2i
 3ljE6mrW5ftz5szz49xyyc75ad+JAD+GuiYGysCq6K83tYTpRZ+hnF+V4QpeE6cwvXh48THpv8s
 pY92
X-Received: by 2002:a05:600c:4e49:b0:485:4136:99a8 with SMTP id
 5b1f17b1804b1-486f4441072mr13816905e9.22.1773780059448; Tue, 17 Mar 2026
 13:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260316214041.6275-1-litaliano00.contact@gmail.com>
 <CADnq5_MN=TTOHc86oxEuApUMCc9R57MxQvF82uyYh_fsMou1Ew@mail.gmail.com>
In-Reply-To: <CADnq5_MN=TTOHc86oxEuApUMCc9R57MxQvF82uyYh_fsMou1Ew@mail.gmail.com>
From: litaliano00 <litaliano00.contact@gmail.com>
Date: Tue, 17 Mar 2026 21:40:48 +0100
X-Gm-Features: AaiRm511McaT5L26PgfiAIy6cGRWWS4_GhW3qkw-VwVBl3KFCHyeF3n_pSZARdk
Message-ID: <CAK-CEVM19BtYmExUq8sedSZGfO81HZrZae-q1EhP6C=ZUjqqBg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: clean up typecasts and ordering in
 dcn4_calcs
To: Alex Deucher <alexdeucher@gmail.com>
Cc: austin.zheng@amd.com, jun.lei@amd.com, harry.wentland@amd.com, 
 sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000005a6851064d3e5a31"
X-Mailman-Approved-At: Wed, 18 Mar 2026 08:34:37 +0000
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

--0000000000005a6851064d3e5a31
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

Thank you for the feedback. I apologize for the oversight in the previous
submission=E2=80=94I managed to catch the 8U and 1U constants this time and
corrected the unsigned int ordering throughout the file.

I have just submitted a [PATCH v2] with these cleanups.

Best regards,
Adriano

On Tue, Mar 17, 2026 at 8:26=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:

> On Tue, Mar 17, 2026 at 4:18=E2=80=AFAM Adriano Vero
> <litaliano00.contact@gmail.com> wrote:
> >
> > Signed-off-by: Adriano Vero <litaliano00.contact@gmail.com>
> > ---
> >  .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c      | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git
> a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn=
4_calcs.c
> b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn=
4_calcs.c
> > index ca5ac3c0d..3e63320fd 100644
> > ---
> a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn=
4_calcs.c
> > +++
> b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn=
4_calcs.c
> > @@ -12670,7 +12670,7 @@ static void rq_dlg_get_dlg_reg(
> >                         disp_dlg_regs->refcyc_per_vm_req_flip =3D
> (unsigned int)(math_pow(2, 23) - 1);
> >
> >
> > -               DML_ASSERT(disp_dlg_regs->dst_y_after_scaler < (unsigne=
d
> int)8);
> > +               DML_ASSERT(disp_dlg_regs->dst_y_after_scaler < (int
> unsigned)8);
>
> Isn't this just doing what you are claiming to fix?
>
> >                 DML_ASSERT(disp_dlg_regs->refcyc_x_after_scaler <
> (unsigned int)math_pow(2, 13));
> >
> >                 if (disp_dlg_regs->dst_y_per_pte_row_nom_l >=3D (unsign=
ed
> int)math_pow(2, 17)) {
> > @@ -13226,7 +13226,7 @@ void dml2_core_calcs_get_informative(const
> struct dml2_core_internal_display_mod
> >
> >         out->informative.misc.cstate_max_cap_mode =3D
> dml_get_cstate_max_cap_mode(mode_lib);
> >
> > -       out->min_clocks.dcn4x.dpprefclk_khz =3D (int
> unsigned)dml_get_global_dppclk_khz(mode_lib);
> > +       out->min_clocks.dcn4x.dpprefclk_khz =3D (unsigned
> int)dml_get_global_dppclk_khz(mode_lib);
> >
> >         out->informative.qos.max_active_fclk_change_latency_supported =
=3D
> dml_get_fclk_change_latency(mode_lib);
> >
> > --
> > 2.47.3
> >
>

--0000000000005a6851064d3e5a31
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Alex,<br><br>Thank you for the feedback. I apologize fo=
r the oversight in the previous<br>submission=E2=80=94I managed to catch th=
e 8U and 1U constants this time and<br>corrected the unsigned int ordering =
throughout the file.<br><br>I have just submitted a [PATCH v2] with these c=
leanups.<br><br>Best regards,<br>Adriano</div><br><div class=3D"gmail_quote=
 gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 1=
7, 2026 at 8:26=E2=80=AFPM Alex Deucher &lt;<a href=3D"mailto:alexdeucher@g=
mail.com">alexdeucher@gmail.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Tue, Mar 17, 2026 at 4:18=E2=80=AFAM Ad=
riano Vero<br>
&lt;<a href=3D"mailto:litaliano00.contact@gmail.com" target=3D"_blank">lita=
liano00.contact@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Signed-off-by: Adriano Vero &lt;<a href=3D"mailto:litaliano00.contact@=
gmail.com" target=3D"_blank">litaliano00.contact@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c=C2=A0 =
=C2=A0 =C2=A0 | 4 ++--<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core=
/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/d=
ml2_core/dml2_core_dcn4_calcs.c<br>
&gt; index ca5ac3c0d..3e63320fd 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_c=
ore_dcn4_calcs.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_c=
ore_dcn4_calcs.c<br>
&gt; @@ -12670,7 +12670,7 @@ static void rq_dlg_get_dlg_reg(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0disp_dlg_regs-&gt;refcyc_per_vm_req_flip =3D (unsigned =
int)(math_pow(2, 23) - 1);<br>
&gt;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DML_ASSERT(dis=
p_dlg_regs-&gt;dst_y_after_scaler &lt; (unsigned int)8);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DML_ASSERT(dis=
p_dlg_regs-&gt;dst_y_after_scaler &lt; (int unsigned)8);<br>
<br>
Isn&#39;t this just doing what you are claiming to fix?<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DML_ASSER=
T(disp_dlg_regs-&gt;refcyc_x_after_scaler &lt; (unsigned int)math_pow(2, 13=
));<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (disp_=
dlg_regs-&gt;dst_y_per_pte_row_nom_l &gt;=3D (unsigned int)math_pow(2, 17))=
 {<br>
&gt; @@ -13226,7 +13226,7 @@ void dml2_core_calcs_get_informative(const str=
uct dml2_core_internal_display_mod<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0out-&gt;informative.misc.cstate_max_c=
ap_mode =3D dml_get_cstate_max_cap_mode(mode_lib);<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0out-&gt;min_clocks.dcn4x.dpprefclk_khz =3D=
 (int unsigned)dml_get_global_dppclk_khz(mode_lib);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0out-&gt;min_clocks.dcn4x.dpprefclk_khz =3D=
 (unsigned int)dml_get_global_dppclk_khz(mode_lib);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0out-&gt;informative.qos.max_active_fc=
lk_change_latency_supported =3D dml_get_fclk_change_latency(mode_lib);<br>
&gt;<br>
&gt; --<br>
&gt; 2.47.3<br>
&gt;<br>
</blockquote></div>

--0000000000005a6851064d3e5a31--
