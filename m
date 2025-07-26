Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB63C87FCA
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Jul 2025 03:11:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1289410E10A;
	Sat, 26 Jul 2025 03:11:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FOBxRcp1";
	dkim-atps=neutral
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com
 [209.85.167.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EF3D10E10A
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Jul 2025 03:11:02 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id
 5614622812f47-42a56f2e953so1184321b6e.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 20:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753499461; x=1754104261; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kz44EAQ15KBxRn2EbZ4Fz4JmtbbP5KYen+NBmHJCkTU=;
 b=FOBxRcp1RESd1oDJOiPkprnCXbfa3SErxaYrlCZ0JH75xhirlEv6zwjIh/JqRWE0kp
 yBnDCL0CsRpQfy8M3+Ov+AOsa6IvhniFQ5qstozlEDbdz1dTX39IFE3+NmCFCDmsIwwd
 pcjnQ7Vgmd/vvORYu7yIDKMl8mE5RljqG0aSpcUewmMw2HPWdxA/5kb6LWPxp2jUfmGz
 YxcFq9Cs7w+Xr7+KuJssSxtpSW6epcI29pQeAXK3DGtGN36n6/dWOzebGRjDGLnddkpl
 PnH6DmO7wy0hHagp3jwFC/kZ/a8U8Tbv3gdyMF3IIFGJaszBHC28tq1d/oNzOEQzyI9d
 OtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753499461; x=1754104261;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kz44EAQ15KBxRn2EbZ4Fz4JmtbbP5KYen+NBmHJCkTU=;
 b=jtyiE5/7CVt5ielcIXvoiG4t/DstVmON2EgO9gisdlnwTuons719Hi390LQXcOfZfh
 Jl36kY6jBhTtBN7ZPNMxBBPm+3Ils+dmFmEe7zVmL1Vw8pXk/ORscuseSHZ0mzpkqGNB
 J8P3VUCAqy4QqFESdaGyZqDLqX8RHOedmPVLtdukSm8qCVdTwzj/cFYqThoEkN8IpVj2
 HqQlvA15PU90t5OueZ4o6IpeakPwrL5QcRGm9Q59YTL3Xun4zhvSSHGl5VCnkC2yJcZ6
 gEEsJx2Vcdvz5iC1j+EFnOK8gan+UVf2gBJZiAGiq5EM5QERsJj+xTogClDfBS2gBOuV
 sDAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWpfouIY7BFqZzkDLnNpC0k8xb5vuBQ7ayqzECCEI/aF5mas6scKJJ2rphy9Ukq5+YkRlOAsKr@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyKD7qABQhxdySkxkKfTWAoOEUmtAoTlPq94VX7hW6QdAHq2w33
 p+cfuaYAJDVm0ZAQZAvDDKf3nKqGug2cUHHbekYP3V/t1ZMrhEDikTCJUnD2451KWBqS9PZ9Rfw
 ZxZT3gmkiijJyjFbF3XYy7gFpQy+idC4=
X-Gm-Gg: ASbGncun0o59smoTeq++2Vshw7lCR/ltS6weFWTGPZ65AkhISrZQbkKH4x/YM+hwVnB
 e52KPNmy6plK7H1PTGj1oNRUSIWwoxQOEDTDDz98PKbiFp9xduIjqrmiC1VKAb9+ElBxEEgfR60
 5f/Gr69sC9CNjfWZmPHtJ4ruJx9dMKbHFsH+ww7UQqEyBeg9bstwbT2zBSovc6zrZ3aisOJydSn
 SAi
X-Google-Smtp-Source: AGHT+IFJW6sMUUBEbmO6WlFynNM0dam05g3g9AQEmxiY9rktSc+k172MwND6Krog5PTYm6oLRmyqgyp6is1/Chkr2BA=
X-Received: by 2002:a05:6808:21a1:b0:406:67b7:8b62 with SMTP id
 5614622812f47-42bb9ff4a2dmr2491218b6e.38.1753499461428; Fri, 25 Jul 2025
 20:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250722155830.67401-1-timur.kristof@gmail.com>
 <20250722155830.67401-2-timur.kristof@gmail.com>
 <kzydigo7sq2odubrh5cci54lw2htowj56g3ihg6hn5pynnnq6u@oof6cdqts3h3>
 <017ac59e-1945-4951-bc86-9357a1f868f4@amd.com>
In-Reply-To: <017ac59e-1945-4951-bc86-9357a1f868f4@amd.com>
From: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Date: Sat, 26 Jul 2025 05:10:49 +0200
X-Gm-Features: Ac12FXwX9-q_IoZdpn3zsoAKiUycaukEVyTJuJEdpmVqkmRx2I0b4YNc1Epx8vE
Message-ID: <CAFF-SiUVt_MyfQwWtgx24PpzGhgZOHPG_DRQcp0aMFXSTqD=uw@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amd/display: Fix refactored DSC cap calculation
To: Alex Hung <alex.hung@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 Dillon Varone <dillon.varone@amd.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="000000000000832b89063acc68be"
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

--000000000000832b89063acc68be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Alex Hung <alex.hung@amd.com> ezt =C3=ADrta (id=C5=91pont: 2025. j=C3=BAl. =
25., P=C3=A9n 22:26):

> This patch may be related and conflict to
> https://www.mail-archive.com/amd-gfx@lists.freedesktop.org/msg125873.html
>
> amd-staging-drm-next should include the above patch but it is not
> updated for 2 weeks, so let's wait for ASDN to be updated.
>

Yes, it indeed looks like that patch addresses the same problem.



>
> On 7/24/25 16:32, Rodrigo Siqueira wrote:
> > On 010/22, Timur Krist=C3=B3f wrote:
> >> After refactoring the DSC capability calculation, the
> >> get_min_slice_count_for_odm could crash on some GPUs due to a
> >> division by zero when max_total_throughput_mps was zero.
> >> As a result, DC was broken when connecting a GPU that doesn't
> >> support DSC to a monitor that supports DSC.
> >> Tested on Oland (DCE 6) and Fiji (DCE 10).
> >>
> >> This commit fixes it by returning zero instead.
> >>
> >> Fixes: 4909b8b3846c ("drm/amd/display: Refactor DSC cap calculations")
> >> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >> ---
> >>   drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c | 17 +++++++++--------
> >>   1 file changed, 9 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
> b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
> >> index a454d16e6586..4169ece9c535 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
> >> @@ -642,14 +642,15 @@ static unsigned int get_min_slice_count_for_odm(
> >>      unsigned int max_dispclk_khz;
> >>
> >>      /* get max pixel rate and combine caps */
> >> -    max_dispclk_khz =3D dsc_enc_caps->max_total_throughput_mps * 1000=
;
> >> -    if (dsc && dsc->ctx->dc) {
> >> -            if (dsc->ctx->dc->clk_mgr &&
> >> -                    dsc->ctx->dc->clk_mgr->funcs->get_max_clock_khz) =
{
> >> -                    /* dispclk is available */
> >> -                    max_dispclk_khz =3D
> dsc->ctx->dc->clk_mgr->funcs->get_max_clock_khz(dsc->ctx->dc->clk_mgr,
> CLK_TYPE_DISPCLK);
> >> -            }
> >> -    }
> >> +    if (dsc && dsc->ctx->dc && dsc->ctx->dc->clk_mgr &&
> >> +            dsc->ctx->dc->clk_mgr->funcs->get_max_clock_khz)
> >> +            max_dispclk_khz =3D
> >> +                    dsc->ctx->dc->clk_mgr->funcs->get_max_clock_khz(
> >> +                            dsc->ctx->dc->clk_mgr, CLK_TYPE_DISPCLK);
> >> +    else if (dsc_enc_caps->max_total_throughput_mps)
> >> +            max_dispclk_khz =3D dsc_enc_caps->max_total_throughput_mp=
s *
> 1000;
> >> +    else
> >> +            return 0;
> >>
> >>      /* consider minimum odm slices required due to
> >>       * 1) display pipe throughput (dispclk)
> >> --
> >> 2.50.1
> >>
> >
> > This patch lgtm.
> >
> > Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
> >
> > I added other display folks to this patch.
> >
> > I'm not sure if the original modification (4909b8b3846c) is already in
> > the stable kernel; if so, it could be a good idea to send this fix to
> > the stable kernel as well.
> >
> > Thanks
> >
>
>

--000000000000832b89063acc68be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi,<br><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">Alex Hung &lt;<a href=3D"mail=
to:alex.hung@amd.com">alex.hung@amd.com</a>&gt; ezt =C3=ADrta (id=C5=91pont=
: 2025. j=C3=BAl. 25., P=C3=A9n 22:26):<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">This patch may be related and conflict to <br>
<a href=3D"https://www.mail-archive.com/amd-gfx@lists.freedesktop.org/msg12=
5873.html" rel=3D"noreferrer noreferrer" target=3D"_blank">https://www.mail=
-archive.com/amd-gfx@lists.freedesktop.org/msg125873.html</a><br>
<br>
amd-staging-drm-next should include the above patch but it is not <br>
updated for 2 weeks, so let&#39;s wait for ASDN to be updated.<br></blockqu=
ote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes, it indee=
d looks like that patch addresses the same problem.</div><div dir=3D"auto">=
<br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail=
_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
<br>
On 7/24/25 16:32, Rodrigo Siqueira wrote:<br>
&gt; On 010/22, Timur Krist=C3=B3f wrote:<br>
&gt;&gt; After refactoring the DSC capability calculation, the<br>
&gt;&gt; get_min_slice_count_for_odm could crash on some GPUs due to a<br>
&gt;&gt; division by zero when max_total_throughput_mps was zero.<br>
&gt;&gt; As a result, DC was broken when connecting a GPU that doesn&#39;t<=
br>
&gt;&gt; support DSC to a monitor that supports DSC.<br>
&gt;&gt; Tested on Oland (DCE 6) and Fiji (DCE 10).<br>
&gt;&gt;<br>
&gt;&gt; This commit fixes it by returning zero instead.<br>
&gt;&gt;<br>
&gt;&gt; Fixes: 4909b8b3846c (&quot;drm/amd/display: Refactor DSC cap calcu=
lations&quot;)<br>
&gt;&gt; Signed-off-by: Timur Krist=C3=B3f &lt;<a href=3D"mailto:timur.kris=
tof@gmail.com" target=3D"_blank" rel=3D"noreferrer">timur.kristof@gmail.com=
</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c | 17 +++++=
++++--------<br>
&gt;&gt;=C2=A0 =C2=A01 file changed, 9 insertions(+), 8 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers=
/gpu/drm/amd/display/dc/dsc/dc_dsc.c<br>
&gt;&gt; index a454d16e6586..4169ece9c535 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c<br>
&gt;&gt; @@ -642,14 +642,15 @@ static unsigned int get_min_slice_count_for_=
odm(<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 unsigned int max_dispclk_khz;<br>
&gt;&gt;=C2=A0 =C2=A0<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 /* get max pixel rate and combine caps */<br>
&gt;&gt; -=C2=A0 =C2=A0 max_dispclk_khz =3D dsc_enc_caps-&gt;max_total_thro=
ughput_mps * 1000;<br>
&gt;&gt; -=C2=A0 =C2=A0 if (dsc &amp;&amp; dsc-&gt;ctx-&gt;dc) {<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dsc-&gt;ctx-&gt;dc-=
&gt;clk_mgr &amp;&amp;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 dsc-&gt;ctx-&gt;dc-&gt;clk_mgr-&gt;funcs-&gt;get_max_clock_khz) {<br=
>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* dispclk is available */<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 max_dispclk_khz =3D dsc-&gt;ctx-&gt;dc-&gt;clk_mgr-&gt;funcs-&gt;get=
_max_clock_khz(dsc-&gt;ctx-&gt;dc-&gt;clk_mgr, CLK_TYPE_DISPCLK);<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; -=C2=A0 =C2=A0 }<br>
&gt;&gt; +=C2=A0 =C2=A0 if (dsc &amp;&amp; dsc-&gt;ctx-&gt;dc &amp;&amp; ds=
c-&gt;ctx-&gt;dc-&gt;clk_mgr &amp;&amp;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dsc-&gt;ctx-&gt;dc-&gt;=
clk_mgr-&gt;funcs-&gt;get_max_clock_khz)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 max_dispclk_khz =3D<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 dsc-&gt;ctx-&gt;dc-&gt;clk_mgr-&gt;funcs-&gt;get_max_clock_khz(<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dsc-&gt;ctx-&gt;dc-&gt;clk_mgr, CLK_TYPE=
_DISPCLK);<br>
&gt;&gt; +=C2=A0 =C2=A0 else if (dsc_enc_caps-&gt;max_total_throughput_mps)=
<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 max_dispclk_khz =3D dsc=
_enc_caps-&gt;max_total_throughput_mps * 1000;<br>
&gt;&gt; +=C2=A0 =C2=A0 else<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;&gt;=C2=A0 =C2=A0<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 /* consider minimum odm slices required due to=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* 1) display pipe throughput (dispclk)<b=
r>
&gt;&gt; -- <br>
&gt;&gt; 2.50.1<br>
&gt;&gt;<br>
&gt; <br>
&gt; This patch lgtm.<br>
&gt; <br>
&gt; Reviewed-by: Rodrigo Siqueira &lt;<a href=3D"mailto:siqueira@igalia.co=
m" target=3D"_blank" rel=3D"noreferrer">siqueira@igalia.com</a>&gt;<br>
&gt; <br>
&gt; I added other display folks to this patch.<br>
&gt; <br>
&gt; I&#39;m not sure if the original modification (4909b8b3846c) is alread=
y in<br>
&gt; the stable kernel; if so, it could be a good idea to send this fix to<=
br>
&gt; the stable kernel as well.<br>
&gt; <br>
&gt; Thanks<br>
&gt; <br>
<br>
</blockquote></div></div></div>

--000000000000832b89063acc68be--
