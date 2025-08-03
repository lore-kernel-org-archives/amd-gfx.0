Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B17C87FCA
	for <amd-gfx@archiver.kernel.org>; Sun,  3 Aug 2025 16:10:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B19310E1F5;
	Sun,  3 Aug 2025 16:10:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GaCOK9gF";
	dkim-atps=neutral
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com
 [209.85.167.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E20610E1F2
 for <amd-gfx@lists.freedesktop.org>; Sun,  3 Aug 2025 16:10:22 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id
 5614622812f47-433f984817dso751375b6e.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 03 Aug 2025 09:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754237422; x=1754842222; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dwdECRrE9QKVnbOWRUKjOMxVgus4id+EjrMd+8SG4OQ=;
 b=GaCOK9gF1aMY9fi+uyFBb9HUPm0FkMetLPgeOkjqObfAAZb5IGQ5ioHrErJOwIJ4Rt
 ++jGdMXjjbXAymxljV8WN9CvJJpdNx2NLDWuQb+xw4bCAg2H863iDURS9ys+TxgvGIKn
 gOYorOS9T500qAyN+gib/mLgS4iT3VFftAhkVY17E1kpNKn08gAXtu2mesx2B/VAlRRm
 jFwUMtVpnyKpjxF8vaUEL/9jX2yU3NGAVUA3ypb6oYIG+cer93JYvpuhxY2ZK2zzomou
 mHlcuwsO5NV2v8XdsgnPZMGT2MFggI/qtA8iRkco7sQ6TKPU3xOLQS1OReDCOyg7YaWV
 VXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754237422; x=1754842222;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dwdECRrE9QKVnbOWRUKjOMxVgus4id+EjrMd+8SG4OQ=;
 b=nrm8Uk0tNIF0B9wUzM3kQR7N/OhiGjzoVpKLjuJGoSHquSvkan0I4jJqn6e7nDGRxg
 ILb0rOHjmySX5zT0xbVOyHVfu+DnzuS7RCEX4GA4fBBg28rFO3bWlOdpR8UUrIlEjEgz
 c/1gMNQBHn1kWi9E/pIHKLEhPni/8A2qL/OzOU8jT0iQUMUcDFNLJDFqbYMp6HuF7LIJ
 /exQFfKLLO3W/g1cXcODlaSlATEzTvXkdHiY13gh5K46MGzl/EdYFF555TSq+mW6dusE
 xIAjFpveD2ANK9ZaF7XnZPkaPHkQevFwQzjVCGzj2ouWMg2wXAo6Qw4pJELr5aNBZV+U
 Vo2Q==
X-Gm-Message-State: AOJu0YyNXzCSCxz08juHat0ocNiTHhGacEh87su3MRbW0EN/Qway39vZ
 b02APjBJ90ppIj+JDORzEDIbojTLCuA/mZyZL98snqtlIH6ho7qjta9oFqJGBpWFgnLhSSPQ2Ox
 uxsE7/NLEt/4wPwwj+mM6T0YqPOEsqB4=
X-Gm-Gg: ASbGncsThFcIK0kuYLwK8JIgBEFCd4z2m4AhnseRtgxBB6nP5F/VaAmQNkF4occqsyq
 Z+tuxSkc45sqzbcbyNmwEFp26vqVFpJWZTkTOBayhi7ath/BGKzR9hD5+q+zyoPNB3Qpc2SRxA5
 LnOeJiUkh6tW79eRVMHKB6LPNgSMbM7f5OGcSQ1/fbNefPRykCC1VO8/PLCKLoS+uknY5VZeBp5
 dymnfNOFsE5QpMGzJc=
X-Google-Smtp-Source: AGHT+IHjRMMJQK02Eil3Q/qI3qvTodeCtFsY49/TQoVSebrDQ2Av+ZOArw1NCBFwJOMoL+W/pD4Cdka0mwSo6fZ+Txk=
X-Received: by 2002:a05:6808:6909:b0:434:914:e185 with SMTP id
 5614622812f47-4340914eaeamr485001b6e.25.1754237421601; Sun, 03 Aug 2025
 09:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250723155813.9101-11-timur.kristof@gmail.com>
 <a90cee9d-4be0-431e-abf7-e55da92c42d5@gmail.com>
 <CAFF-SiUrWyz68xPd4+mRB1SSr0F-MO8v_s32E-gw7zkKPS7D1w@mail.gmail.com>
In-Reply-To: <CAFF-SiUrWyz68xPd4+mRB1SSr0F-MO8v_s32E-gw7zkKPS7D1w@mail.gmail.com>
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Sun, 3 Aug 2025 12:10:10 -0400
X-Gm-Features: Ac12FXxHUtjIwZMo20Fxl0Y07DCdR4U82aFwzJCWWYctW01fG7MI3CKpL9K8wrg
Message-ID: <CAPEhTTEYcD4WmweMwBWHkawxxZzNCZgJPAF3enL9-_nJxh2HCg@mail.gmail.com>
Subject: Re: [PATCH 10/20] drm/amd/display: Implement DCE analog stream
 encoders
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="0000000000005dc6e5063b783a63"
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

--0000000000005dc6e5063b783a63
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Timur,

I agree with you about the coding style (the prefix), it was more of a
general comment since the style is inconsistent with some other parts in
the DC code.

If the code applies to any DCE version (even though it is unclear if any >
DCE 10 is in the field with a DAC), then it's good for me. My only
remaining concern would be about encountering one of those special GPU
cards hardly testable. But this seems unlikely.

Alexandre

On Fri, Aug 1, 2025 at 5:29=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@gm=
ail.com>
wrote:

>
> 2025. augusztus 1., p=C3=A9ntek d=C3=A1tummal Alexandre Demers <
> alexandre.f.demers@gmail.com> ezt =C3=ADrta:
> >> Add stream encoders for DCE6-10 only, because there are definitely
> >> graphics cards with analog connectors out there with these DCE
> >> versions. I am not aware of newer ones.
> >
> >> Considering that all stream encoder functions currently have to do
> >> with digital streams, there is nothing for an analog stream
> >> encoder to do, making them basically a no-op.
> >> That being said, we still need some kind of stream encoder to
> >> represent an analog stream, and it is beneficial to split them from
> >> digital stream encoders in the code to make sure they don't
> >> accidentally write any DIG* registers.
> >>
> >> Signed-off-by: Timur Krist=C3=B3f <timur.kristof at gmail.com>
> >> ---
> >> .../drm/amd/display/dc/dce/dce_stream_encoder.c | 14 ++++++++++++++
> >> .../drm/amd/display/dc/dce/dce_stream_encoder.h | 5 +++++
> >> .../display/dc/resource/dce100/dce100_resource.c | 6 ++++++
> >> .../amd/display/dc/resource/dce60/dce60_resource.c | 8 ++++++++
> >> .../amd/display/dc/resource/dce80/dce80_resource.c | 8 ++++++++
> >> 5 files changed, 41 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> >> index 1130d7619b26..f8996ee2856b 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> >> @@ -1567,3 +1567,17 @@ void dce110_stream_encoder_construct(
> >> enc110->se_shift =3D se_shift;
> >> enc110->se_mask =3D se_mask;
> >> }
> >> +
> >> +static const struct stream_encoder_funcs dce110_an_str_enc_funcs =3D =
{0};
> >> +
> >> +void dce110_analog_stream_encoder_construct(
> >> + struct dce110_stream_encoder *enc110,
> >> + struct dc_context *ctx,
> >> + struct dc_bios *bp,
> >> + enum engine_id eng_id)
> >> +{
> >> + enc110->base.funcs =3D &dce110_an_str_enc_funcs;
> >> + enc110->base.ctx =3D ctx;
> >> + enc110->base.id =3D eng_id;
> >> + enc110->base.bp =3D bp;
> >> +}
> >
> > Since we are adding analog stream encoder support only up to DCE10,
> wouldn't it be better if the prefix "dce100_" was used instead? I know
> there are a few functions in there that use "dce110_" as prefix and are
> replaced by functions specific to the DCE versions that behave differentl=
y
> (we even have dce60_ and dce80_ in the current patch), but this seems off
> otherwise.
> >
> > IMO, if thie DCE code should be revisited, "dce_" should be the general
> prefix instead of "dce110_", with "dceXY_" being specific (as it is right
> now).
> > Alexandre
>
> Hi Alexandre,
>
> Two reasons:
>
> 1. As best as I can tell, all DCE versions use dce110_stream_encoder
> regardless of its name. I agree that this is somewhat counter-intuitive b=
ut
> I wanted to follow the conventions in the rest of this file.
>
> 2. It is unclear which DCE versions actually have a DAC. On one hand ther=
e
> is some conversation on this ML that suggests that Hawaii and newer don't
> have a DAC, which is apparently wrong. Looking at the register headers, a=
ll
> DCE including the latest one have the DAC registers. Theoretically, if
> there were newer GPUs with DAC, this code would work fine on them too.
>
> If you are not happy with the code style, I respect that but I would like
> if we tackled that separarely.
>
> With these series, I want to just focus on fixing things and getting DC t=
o
> work on SI and CIK with the least possible risk of breaking things.
>
> Best regards,
> Timur

--0000000000005dc6e5063b783a63
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Timur,</div><div><br></div><div>I agree with you a=
bout the coding style (the prefix), it was more of a general comment since =
the style is inconsistent with some other parts in the DC code.</div><div><=
br></div><div>If the code applies to any DCE version (even though it is unc=
lear if any &gt; DCE 10 is in the field with a DAC), then it&#39;s good for=
 me. My only remaining concern would be about encountering one of those spe=
cial GPU cards hardly testable. But this seems unlikely.</div><div><br></di=
v><div>Alexandre</div></div><br><div class=3D"gmail_quote gmail_quote_conta=
iner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 1, 2025 at 5:29=E2=
=80=AFPM Timur Krist=C3=B3f &lt;<a href=3D"mailto:timur.kristof@gmail.com">=
timur.kristof@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><br>2025. augusztus 1., p=C3=A9ntek d=C3=A1tummal Al=
exandre Demers &lt;<a href=3D"mailto:alexandre.f.demers@gmail.com" target=
=3D"_blank">alexandre.f.demers@gmail.com</a>&gt; ezt =C3=ADrta:<br>&gt;&gt;=
 Add stream encoders for DCE6-10 only, because there are definitely<br>&gt;=
&gt; graphics cards with analog connectors out there with these DCE<br>&gt;=
&gt; versions. I am not aware of newer ones.<br>&gt;<br>&gt;&gt; Considerin=
g that all stream encoder functions currently have to do<br>&gt;&gt; with d=
igital streams, there is nothing for an analog stream<br>&gt;&gt; encoder t=
o do, making them basically a no-op.<br>&gt;&gt; That being said, we still =
need some kind of stream encoder to<br>&gt;&gt; represent an analog stream,=
 and it is beneficial to split them from<br>&gt;&gt; digital stream encoder=
s in the code to make sure they don&#39;t<br>&gt;&gt; accidentally write an=
y DIG* registers.<br>&gt;&gt;<br>&gt;&gt; Signed-off-by: Timur Krist=C3=B3f=
 &lt;timur.kristof at <a href=3D"http://gmail.com" target=3D"_blank">gmail.=
com</a>&gt;<br>&gt;&gt; ---<br>&gt;&gt; .../drm/amd/display/dc/dce/dce_stre=
am_encoder.c | 14 ++++++++++++++<br>&gt;&gt; .../drm/amd/display/dc/dce/dce=
_stream_encoder.h | 5 +++++<br>&gt;&gt; .../display/dc/resource/dce100/dce1=
00_resource.c | 6 ++++++<br>&gt;&gt; .../amd/display/dc/resource/dce60/dce6=
0_resource.c | 8 ++++++++<br>&gt;&gt; .../amd/display/dc/resource/dce80/dce=
80_resource.c | 8 ++++++++<br>&gt;&gt; 5 files changed, 41 insertions(+)<br=
>&gt;&gt;<br>&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_s=
tream_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c<b=
r>&gt;&gt; index 1130d7619b26..f8996ee2856b 100644<br>&gt;&gt; --- a/driver=
s/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c<br>&gt;&gt; +++ b/drivers=
/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c<br>&gt;&gt; @@ -1567,3 +15=
67,17 @@ void dce110_stream_encoder_construct(<br>&gt;&gt; enc110-&gt;se_sh=
ift =3D se_shift;<br>&gt;&gt; enc110-&gt;se_mask =3D se_mask;<br>&gt;&gt; }=
<br>&gt;&gt; +<br>&gt;&gt; +static const struct stream_encoder_funcs dce110=
_an_str_enc_funcs =3D {0};<br>&gt;&gt; +<br>&gt;&gt; +void dce110_analog_st=
ream_encoder_construct(<br>&gt;&gt; + struct dce110_stream_encoder *enc110,=
<br>&gt;&gt; + struct dc_context *ctx,<br>&gt;&gt; + struct dc_bios *bp,<br=
>&gt;&gt; + enum engine_id eng_id)<br>&gt;&gt; +{<br>&gt;&gt; + enc110-&gt;=
base.funcs =3D &amp;dce110_an_str_enc_funcs;<br>&gt;&gt; + enc110-&gt;base.=
ctx =3D ctx;<br>&gt;&gt; + enc110-&gt;<a href=3D"http://base.id" target=3D"=
_blank">base.id</a> =3D eng_id;<br>&gt;&gt; + enc110-&gt;base.bp =3D bp;<br=
>&gt;&gt; +}<br>&gt;<br>&gt; Since we are adding analog stream encoder supp=
ort only up to DCE10, wouldn&#39;t it be better if the prefix &quot;dce100_=
&quot; was used instead? I know there are a few functions in there that use=
 &quot;dce110_&quot; as prefix and are replaced by functions specific to th=
e DCE versions that behave differently (we even have dce60_ and dce80_ in t=
he current patch), but this seems off otherwise.<br>&gt;<br>&gt; IMO, if th=
ie DCE code should be revisited, &quot;dce_&quot; should be the general pre=
fix instead of &quot;dce110_&quot;, with &quot;dceXY_&quot; being specific =
(as it is right now).<br>&gt; Alexandre<br><br>Hi Alexandre,<br><br>Two rea=
sons:<br><br>1. As best as I can tell, all DCE versions use dce110_stream_e=
ncoder regardless of its name. I agree that this is somewhat counter-intuit=
ive but I wanted to follow the conventions in the rest of this file.<br><br=
>2. It is unclear which DCE versions actually have a DAC. On one hand there=
 is some conversation on this ML that suggests that Hawaii and newer don&#3=
9;t have a DAC, which is apparently wrong. Looking at the register headers,=
 all DCE including the latest one have the DAC registers. Theoretically, if=
 there were newer GPUs with DAC, this code would work fine on them too.<br>=
<br>If you are not happy with the code style, I respect that but I would li=
ke if we tackled that separarely.<br><br>With these series, I want to just =
focus on fixing things and getting DC to work on SI and CIK with the least =
possible risk of breaking things.<br><br>Best regards,<br>Timur
</blockquote></div>

--0000000000005dc6e5063b783a63--
