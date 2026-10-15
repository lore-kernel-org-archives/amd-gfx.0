Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8AECCA464
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 08:55:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA69B11269D;
	Fri, 16 Oct 2026 08:55:45 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C8DC10E796
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 16:02:33 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2e95b3b52f2so5885795ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 09:02:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792080152; cv=none;
 d=google.com; s=arc-20260327;
 b=gO8s0kjnDlXefOvTY9sEKx8rmABYqCsjvuP/GFj1gZd2mQv7+1rxi4rz9arv3992Xa
 xirStGnTfGrt4v9b5gpEvY0Yc1LMpX/Hxy9QqZluURtEk46iNtKkubXCgrKn9njBt25o
 ar8l3Ipr4c0213q4FSzHpzxB6/kPoFIv+dfJFayqeqm12dZdogle7hQGSBv2asAjaVFS
 NqbGT8QjPixK44CPzOxb84yyMmNEjhKbM9JqLG06yTngQrdFEbLlVEeAdfCzfbKD5FjM
 zI5Wcc0cpID39WdfSN9d+gNU4SwGwlXBqJKfS5Hby5nsS6piWCFWYiE+0L9QVzhp20GK
 8Epg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Nx0swBpAa+Ux1DO7eK1igqEoiQ7zIPkVVmevsOLiZ3s=;
 fh=IyJcE84JKeKx+MWgapn5E1EkA42iluMMpDHpFxAEJdM=;
 b=Gxcl2wOoZAUh0QecnCYrRYcF1+odzoORJdk3mKoqxlJn7oXP2P4Rup/1njQREhw6R6
 YX4vBibdjEq6zFTXFr2NQ3pLi9hR0Ryn9U37Xjvu+tabgRLc1Rinn2eHvGJAcsSP8kzu
 4NlgzJ13h3D7JMMxoQaRxb0tkmjIz6qAg/nBIWswa/Yko/91wH81SHu/7b2F8xLCnr2l
 sKfUHp5cH2xOcZxqSnleJjMsSeJD2rWS2JhZroHpQD/D0CxsvuUK7xUgDtEP2oZOjT8J
 FPJNG32PGTajXro4LA14Rwj3JsB3ZZkBVoMFsX1uNzRtnp9GK2YwUYTTCuQXg37sS/X6
 GIiA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792080152; x=1792684952; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Nx0swBpAa+Ux1DO7eK1igqEoiQ7zIPkVVmevsOLiZ3s=;
 b=NMph0TzBH0RqmOd83H3+2n+Hesencqx/6KkZyvTXMa6VehfFzsBBZxeBcnWOSs5GCf
 CKCAPIEfj1HSDIgsQI5MbvGHLb8BpxAOIOi8wnUK1/q9AomJKLancK+njZJ3f8Ay4CTg
 8AVBpBudLDddTzvpSWXzMG38ZfNIVuOZ8G4BrJiZjIL58zXhcbM4KtV3XJOSrwAX6oEB
 2mmn0saMTuphPiQAK8EEOu/21VVc5w9e+S59k5oDvkNwIkzThi+8rR/iY1adC+qrep/0
 qiOUZezWUexx2O23cKoubmCuhak8lOY4kPFDnLmc6NLSS28C39JQeD5t/tn3eHtROYNz
 I/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792080152; x=1792684952;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Nx0swBpAa+Ux1DO7eK1igqEoiQ7zIPkVVmevsOLiZ3s=;
 b=ByO0bb34GjdTQfOoruyGeLbQ7lmLi5p/oECQv9fagVH1tSETkqI8K8gUjcIG8pv9sq
 ScU3IVA8FjD9z6pmc3B+rr4zw9tdL7OhQFN4371GDAfMl+8lfUNWUuaQENn6oz4hkCKr
 zSvWbUmNk/VqbZjsrR6R8LZs4wW6tSUgmWPxXeHnFjo9G5TwB2ctgXpyDNK2vlBs8Kr2
 1B9HdByZ7sMyYpm+MqzcEjUVbiEcczFUNaqosy9NRByjQK4qehwvi1HlBxdJ92AAhWRr
 Au0ycLwQDXn3hVn77I3ZB3fgL+/O+fBcaAtkKauszyn4korDba3gLag5i1J9dZQuPUSa
 ZPYw==
X-Gm-Message-State: AFq9FYI3pTNWABHhDvfflFa0ccWF7dEaGmLboFnE4L9NsDy5ykRVTuQz
 loND6AYn5QX6IBMhJBp3XIRU1bivdxDZ2ykq8etnKUOlew6pAaD1Tx6Hs/QefDH3D3Azgbefd6h
 jcXeeSI5q5YAGixscvNpeu7LqhlekNic=
X-Gm-Gg: AYBFou1UPyQPJWQPqs4/aXwpegwGZaDo3QVSrNGVUdbDn71Rp4mXenWGrJ2ACT7k5q2
 WvfWJOF2zvBr1nTZkBeO2NUSfPqVP+GcbN4BaznuC6p3vjte8xK1xyc5+Y1eRsa2tL1TDpQW5ya
 ABKJ8S2PRZsn+Ebjglc4kv8LyiBgGvdC1JbveueOb3UoaR/AiUWmnvmhxd6KiKNSFmBsHsJQjg8
 nV+XXtncxkGxJLL4UgZ1SfUzVEYZW367hopH66kwQkj4WHndtscrSA7whrKafi0tn1IKT+N3YT7
 oIs5ppeEy23SZsjbIsLZKwftnRa8aXRssdw1QVqQOzrDScble2353mQ/mVq9I6pF/8772iFg8KH
 nMSUlAHNOCWyfEWE4JqGKOp6paQxyiWBh5eE=
X-Received: by 2002:a17:902:ebc3:b0:2e9:6352:6c61 with SMTP id
 d9443c01a7336-2e963526ccbmr23572655ad.19.1792080150858; Thu, 15 Oct 2026
 09:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20261014133356.3002808-1-luigi.lauro@gmail.com>
 <CADnq5_Mw0k8NLVyWMZWd-Oxg0Om=6ckVET7Wjdx4zU7c1NL2QA@mail.gmail.com>
In-Reply-To: <CADnq5_Mw0k8NLVyWMZWd-Oxg0Om=6ckVET7Wjdx4zU7c1NL2QA@mail.gmail.com>
From: Luigi Lauro <luigi.lauro@gmail.com>
Date: Thu, 15 Oct 2026 18:02:19 +0200
X-Gm-Features: AclHuK9h0NSjrddQNxkpJ99s1MKHp62idYPDsfQDx5zBObtThtcKiBBczNaoMbg
Message-ID: <CAGhTi--5qQijNdBtUm0uH7z0WxOmoWq_4SLzOn=MtTCQjzErEg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: require _PR3 for BOCO
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: multipart/alternative; boundary="000000000000cd0fd8065de32cd6"
X-Mailman-Approved-At: Fri, 16 Oct 2026 08:55:44 +0000
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

--000000000000cd0fd8065de32cd6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You are welcome and thanks for the prompt inclusion!

Luigi Lauro

Il giorno gio 15 ott 2026 alle 15:41 Alex Deucher <alexdeucher@gmail.com>
ha scritto:

> On Thu, Oct 15, 2026 at 4:31=E2=80=AFAM Luigi Lauro <luigi.lauro@gmail.co=
m> wrote:
> >
> > amdgpu_device_supports_boco() returns true for an AMD_IS_PX device on a
> > system with a hybrid ATPX method even when the device has no ACPI power
> > resource (_PR3). On an APU mini PC with a discrete GPU attached over
> > OCuLink, the iGPU's ATPX method reports hybrid graphics, the dGPU is
> > flagged AMD_IS_PX, and runtime PM in auto mode picks BOCO:
> >
> >   amdgpu: ATPX Hybrid Graphics
> >   amdgpu 0000:c6:00.0: Using BOCO for runtime pm
> >
> > In BOCO mode the driver leaves powering the device off to the PCI core,
> > which can only do it through _PR3 on the upstream bridge. No device on
> > this dGPU's path has _PR3, so when it runtime suspends the card stays
> > powered, with its fans at about 700 rpm.
> >
> > Require has_pr3 for BOCO, as the function's description ("dGPU with ACP=
I
> > power resources") says. The same card then picks BACO, which powers it
> > down:
> >
> >   amdgpu 0000:c6:00.0: Using BACO for runtime pm
> >
> > This only changes systems with a hybrid ATPX method and no _PR3 on the
> > dGPU's upstream bridge, where BOCO cannot cut the power today. Tested o=
n
> > one such system only, an RX 9070 XT (Navi 48) over OCuLink with a Ryzen
> > AI 9 HX 470, with the change backported to 7.2.9: the stock module logs
> > "Using BOCO", the patched one "Using BACO"; BACO runtime suspend powers
> > the card off and it resumes cleanly. Not tested on a hybrid laptop or a
> > Thunderbolt eGPU.
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5980
> > Assisted-by: Claude:claude-opus-5-5
> > Signed-off-by: Luigi Lauro <luigi.lauro@gmail.com>
>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
> and applied.  Thanks!
>
> > ---
> > Alex asked for this on the issue. Here is the full picture, so you can
> > judge which approach is best:
> >
> > Why _PR3: in amdgpu_pmops_runtime_suspend() the BOCO branch does nothin=
g
> > itself ("PCI core handles it for _PR3"), and has_pr3 checks exactly the
> > bridge the PCI core would power off (link_partner, past the dGPU's own
> > switch). On a hybrid ATPX, amdgpu_device_supports_px() is false, so the
> > ATPX power-control method is not used either.
> >
> > Who changes: only hybrid-ATPX systems without _PR3 on that bridge. Hybr=
id
> > laptops that have _PR3 there, which I understand is the usual design,
> > are unaffected.
> >
> > Risks I cannot rule out:
> > - BACO on older laptop chips that have never used it for runtime PM.
> > - A platform that cuts the power in a way has_pr3 does not see (_PR3
> >   somewhere else on the path).
> > - The other users of the function change too on such a system: the
> >   DPM_FLAG_SMART_SUSPEND | DPM_FLAG_MAY_SKIP_RESUME flags in
> >   amdgpu_pci_probe(), amdgpu_pmops_prepare() returning 1, and
> >   amdgpu_device_supports_smart_shift().
> >
> > Narrower alternative: leave amdgpu_device_supports_boco() alone and
> > require has_pr3 only where amdgpu_device_detect_runtime_pm_mode() picks
> > BOCO in the auto case, falling back to BACO. That fixes this system too
> > and keeps the other three users as they are, which is the same state as
> > booting it today with amdgpu.runpm=3D1.
> >
> > Please tell me which you prefer; I can send a v2 with the narrower form=
.
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index e001461..96cb4d3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -593,10 +593,8 @@ bool amdgpu_device_supports_boco(struct
> amdgpu_device *adev)
> >         if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> >                 return false;
> >
> > -       if (adev->has_pr3 ||
> > -           ((adev->flags & AMD_IS_PX) && amdgpu_is_atpx_hybrid()))
> > -               return true;
> > -       return false;
> > +       /* BOCO needs a platform power resource (_PR3) to cut the power
> */
> > +       return adev->has_pr3;
> >  }
> >
> >  /**
> > --
> > 2.56.0
> >
>

--000000000000cd0fd8065de32cd6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">You are welcome and thanks for the prompt inclusion!<br c=
lear=3D"all"><br clear=3D"all"><div><div dir=3D"ltr" class=3D"gmail_signatu=
re" data-smartmail=3D"gmail_signature">Luigi Lauro</div></div></div><div><b=
r><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">Il giorno gio 15 ott 2026 alle 15:41 Alex Deucher &lt;<a hr=
ef=3D"mailto:alexdeucher@gmail.com">alexdeucher@gmail.com</a>&gt; ha scritt=
o:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">On Thu, Oct 15, 2026 at 4:31=E2=
=80=AFAM Luigi Lauro &lt;<a href=3D"mailto:luigi.lauro@gmail.com" target=3D=
"_blank">luigi.lauro@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; amdgpu_device_supports_boco() returns true for an AMD_IS_PX device on =
a<br>
&gt; system with a hybrid ATPX method even when the device has no ACPI powe=
r<br>
&gt; resource (_PR3). On an APU mini PC with a discrete GPU attached over<b=
r>
&gt; OCuLink, the iGPU&#39;s ATPX method reports hybrid graphics, the dGPU =
is<br>
&gt; flagged AMD_IS_PX, and runtime PM in auto mode picks BOCO:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0amdgpu: ATPX Hybrid Graphics<br>
&gt;=C2=A0 =C2=A0amdgpu 0000:c6:00.0: Using BOCO for runtime pm<br>
&gt;<br>
&gt; In BOCO mode the driver leaves powering the device off to the PCI core=
,<br>
&gt; which can only do it through _PR3 on the upstream bridge. No device on=
<br>
&gt; this dGPU&#39;s path has _PR3, so when it runtime suspends the card st=
ays<br>
&gt; powered, with its fans at about 700 rpm.<br>
&gt;<br>
&gt; Require has_pr3 for BOCO, as the function&#39;s description (&quot;dGP=
U with ACPI<br>
&gt; power resources&quot;) says. The same card then picks BACO, which powe=
rs it<br>
&gt; down:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0amdgpu 0000:c6:00.0: Using BACO for runtime pm<br>
&gt;<br>
&gt; This only changes systems with a hybrid ATPX method and no _PR3 on the=
<br>
&gt; dGPU&#39;s upstream bridge, where BOCO cannot cut the power today. Tes=
ted on<br>
&gt; one such system only, an RX 9070 XT (Navi 48) over OCuLink with a Ryze=
n<br>
&gt; AI 9 HX 470, with the change backported to 7.2.9: the stock module log=
s<br>
&gt; &quot;Using BOCO&quot;, the patched one &quot;Using BACO&quot;; BACO r=
untime suspend powers<br>
&gt; the card off and it resumes cleanly. Not tested on a hybrid laptop or =
a<br>
&gt; Thunderbolt eGPU.<br>
&gt;<br>
&gt; Closes: <a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues/598=
0" rel=3D"noreferrer" target=3D"_blank">https://gitlab.freedesktop.org/drm/=
amd/-/issues/5980</a><br>
&gt; Assisted-by: Claude:claude-opus-5-5<br>
&gt; Signed-off-by: Luigi Lauro &lt;<a href=3D"mailto:luigi.lauro@gmail.com=
" target=3D"_blank">luigi.lauro@gmail.com</a>&gt;<br>
<br>
Reviewed-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com" =
target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
<br>
and applied.=C2=A0 Thanks!<br>
<br>
&gt; ---<br>
&gt; Alex asked for this on the issue. Here is the full picture, so you can=
<br>
&gt; judge which approach is best:<br>
&gt;<br>
&gt; Why _PR3: in amdgpu_pmops_runtime_suspend() the BOCO branch does nothi=
ng<br>
&gt; itself (&quot;PCI core handles it for _PR3&quot;), and has_pr3 checks =
exactly the<br>
&gt; bridge the PCI core would power off (link_partner, past the dGPU&#39;s=
 own<br>
&gt; switch). On a hybrid ATPX, amdgpu_device_supports_px() is false, so th=
e<br>
&gt; ATPX power-control method is not used either.<br>
&gt;<br>
&gt; Who changes: only hybrid-ATPX systems without _PR3 on that bridge. Hyb=
rid<br>
&gt; laptops that have _PR3 there, which I understand is the usual design,<=
br>
&gt; are unaffected.<br>
&gt;<br>
&gt; Risks I cannot rule out:<br>
&gt; - BACO on older laptop chips that have never used it for runtime PM.<b=
r>
&gt; - A platform that cuts the power in a way has_pr3 does not see (_PR3<b=
r>
&gt;=C2=A0 =C2=A0somewhere else on the path).<br>
&gt; - The other users of the function change too on such a system: the<br>
&gt;=C2=A0 =C2=A0DPM_FLAG_SMART_SUSPEND | DPM_FLAG_MAY_SKIP_RESUME flags in=
<br>
&gt;=C2=A0 =C2=A0amdgpu_pci_probe(), amdgpu_pmops_prepare() returning 1, an=
d<br>
&gt;=C2=A0 =C2=A0amdgpu_device_supports_smart_shift().<br>
&gt;<br>
&gt; Narrower alternative: leave amdgpu_device_supports_boco() alone and<br=
>
&gt; require has_pr3 only where amdgpu_device_detect_runtime_pm_mode() pick=
s<br>
&gt; BOCO in the auto case, falling back to BACO. That fixes this system to=
o<br>
&gt; and keeps the other three users as they are, which is the same state a=
s<br>
&gt; booting it today with amdgpu.runpm=3D1.<br>
&gt;<br>
&gt; Please tell me which you prefer; I can send a v2 with the narrower for=
m.<br>
&gt;<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++----<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index e001461..96cb4d3 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -593,10 +593,8 @@ bool amdgpu_device_supports_boco(struct amdgpu_de=
vice *adev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PC=
IE))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return fa=
lse;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;has_pr3 ||<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((adev-&gt;flags &amp; AMD_I=
S_PX) &amp;&amp; amdgpu_is_atpx_hybrid()))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* BOCO needs a platform power resource (_=
PR3) to cut the power */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return adev-&gt;has_pr3;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 /**<br>
&gt; --<br>
&gt; 2.56.0<br>
&gt;<br>
</blockquote></div></div>

--000000000000cd0fd8065de32cd6--
