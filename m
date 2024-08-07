Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6055C52D71
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 15:12:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83E8C10E564;
	Wed,  7 Aug 2024 15:12:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="GzVZxc/I";
	dkim-atps=neutral
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84C0910E564
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 15:12:23 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-7a1e23baecbso162685a.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Aug 2024 08:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1723043542; x=1723648342;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f9S20irupVyaix7A85syhnvSAWrgj4NiX5bTpfwMXBI=;
 b=GzVZxc/ItoJG3LztJCI6tVNPQH+o4HA0Jq5w+XXEE+1eEKhAcfsL7k/leAGaIOqrGt
 UGfifB/fPP8qga8GtU/C12dTvoQi2P8V5VU7NN3fLuVPpBvxmWvXHQs8YBaHO3n3C1yg
 fL3bBSiA5UovF7uX+YFpEZKGNoeWbfv4A6Y9w3D5rOtiXWnnnOQYyWDa6wtlkT4X6QQP
 ljVrE4+oOSjjMlQ0AxUybKZGcE2T5+Fh3p8KFbbKM2FEHTz9DvIrbKf195L/92FaXHEv
 4pYtDfjZ3Vp+evmKN5liKhE4tU46Y43iLJ29/fRIc7duD6PdmpJsAUn7C3av44FX2IWc
 BTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723043542; x=1723648342;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f9S20irupVyaix7A85syhnvSAWrgj4NiX5bTpfwMXBI=;
 b=fPFVIY1gdBPGlBo5pZXnD8oenYWlR5mw4nq9iqXT2G55413g9n3UryLEJ/rvVTqLgT
 /Tg0/yC09rzqvOP4LTzr5DAPlVhejGsgn+oSl+VQAF7whMrVGU5ODaO/RtWb/JqVf2ja
 Fb7X4hk+vTb14z5aWRuTnwcw2vfrFBakwtOlgmbXNRwgl1ribGdZ8QHURHMxaz+Uo1Yc
 Mp6peYfYQG5ZrouHOwauerg7EkidnTTkSYTC/r4Gz+eLtBSgEPUKma6PAg9OczUgQ0xu
 ZAaATK4RacsCLcgeXdwjPvnwFeuUrmzQD6DhuLG9aON7q8iJ1EOQuid9+w/DPWSEUmUG
 JdEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7MlmIIuwW9E5+7X32MY7cZ62Lz+xgBO5mZ3WJGepaxNyNaktB6A6+aHK4kdjGeGkabA9OP1GjFlxvWSGRcM10LZyLpVaIOjKX658ITA==
X-Gm-Message-State: AOJu0YwpYAFW83s6NUHrb72PxPi5ntn7lDfogkHSOD/mF2qFoHvLzXAm
 v4GunVGoswwn+fFD43HTva9h74RxdwiYiRc8YlkZQF3oGFwoslw9nWVxwcgHLI1bYW/9FcTeLgA
 wtoSI7Bwdl7v5snP3cHtsyLQ79Q2IXR1XREbz9g==
X-Google-Smtp-Source: AGHT+IFdCteEJOOx60EP2thKH9JNKVb47F4NSb9LldqFVqZXsaeYy00dPyLFivz+m2+MogQ0c5dmm24XGmEWSVYmBaQ=
X-Received: by 2002:a05:620a:4494:b0:79f:b3c:8fc3 with SMTP id
 af79cd13be357-7a34efc4f66mr1375105985a.6.1723043542426; Wed, 07 Aug 2024
 08:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240806202732.783604-1-bas@basnieuwenhuizen.nl>
 <63b3fedc-e793-4e87-82a6-5448adb2e544@mailbox.org>
In-Reply-To: <63b3fedc-e793-4e87-82a6-5448adb2e544@mailbox.org>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Wed, 7 Aug 2024 17:12:10 +0200
Message-ID: <CAP+8YyG4arrfE+RuogNHZxhZ=_mTNN0KnADYp7=9SsPKu6cjEQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Actually check flags for all context ops.
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="0000000000004782b4061f1956b2"
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

--0000000000004782b4061f1956b2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yeah, I also found that one. Will send it out this evening if you don't get
to it.

On Wed, Aug 7, 2024, 5:03=E2=80=AFPM Michel D=C3=A4nzer <michel.daenzer@mai=
lbox.org>
wrote:

> On 2024-08-06 22:27, Bas Nieuwenhuizen wrote:
> > Missing validation ...
> >
> > Checked libdrm and it clears all the structs, so we should be
> > safe to just check everything.
>
> Thanks for fixing this.
>
> FWIW, amdgpu_cs_ioctl has the same issue AFAICT. Haven't checked any
> others, there might be more.
>
>
> --
> Earthling Michel D=C3=A4nzer       \        GNOME / Xwayland / Mesa devel=
oper
> https://redhat.com             \               Libre software enthusiast
>
>

--0000000000004782b4061f1956b2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Yeah, I also found that one. Will send it out this evenin=
g if you don&#39;t get to it.</div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Aug 7, 2024, 5:03=E2=80=AFPM Michel D=
=C3=A4nzer &lt;<a href=3D"mailto:michel.daenzer@mailbox.org">michel.daenzer=
@mailbox.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 2024=
-08-06 22:27, Bas Nieuwenhuizen wrote:<br>
&gt; Missing validation ...<br>
&gt; <br>
&gt; Checked libdrm and it clears all the structs, so we should be<br>
&gt; safe to just check everything.<br>
<br>
Thanks for fixing this.<br>
<br>
FWIW, amdgpu_cs_ioctl has the same issue AFAICT. Haven&#39;t checked any ot=
hers, there might be more.<br>
<br>
<br>
-- <br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0\=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 GNOME / Xwayland / Mesa developer<br>
<a href=3D"https://redhat.com" rel=3D"noreferrer noreferrer" target=3D"_bla=
nk">https://redhat.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Libre software enthu=
siast<br>
<br>
</blockquote></div>

--0000000000004782b4061f1956b2--
