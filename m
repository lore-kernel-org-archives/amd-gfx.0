Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC8BC432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 02:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 295B122419
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 02:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295B122419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1EF26E471;
	Wed, 20 Nov 2019 02:42:02 +0000 (UTC)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FF066E471
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 02:42:01 +0000 (UTC)
Received: by mail-pf1-x444.google.com with SMTP id x28so13436334pfo.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2019 18:42:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IHH2CSx2A+hLvcOPyytuvTrzA17g2pC7lUwaAxSNtac=;
 b=dvQmzTKsJBO+w7+6b1/gNj1qywIeMXEGRl8TeAVNezhbIgDXKZksoB4PepPIZje70R
 CaLyPHmFWtlbnn3jYp5ASoHm/4BTuTL2qsEi6ecvbNTcAlhi1JNvH1rwudaR8gQpFboi
 FgQ5519yng84hXq8j3qqhO3ichVH66cKgClvNuAJrdKFKoQT7hfS6FiV0J8VzZZPvXZ4
 4KauQW6fTYxiXmqFXYxfbMWtuMPdiAS+6t58d50qSO+EiGqS9MJUQ4M/oaaH3F/4TqUG
 khyAMHV2Ueq8eY0NI1bo1TzzyPCGO/RcH/1P21C/I2jOUEyWbFoljPBf9ZIGwrwtfgAK
 pyYg==
X-Gm-Message-State: APjAAAW8KnVg37qLMzE+OjDR6EgrYVxhJkE1kZixvIinpWuRVsfi/NaZ
 xq6ILXRMfaJwp8Ak4K1nKU04R4rr9JN/NTzfjtY=
X-Google-Smtp-Source: APXvYqxL3b5gdVZnrfbL28uUE9qilLUdDM2ld+AA7ex4bsLleyqIYru+EsOKncT7U8/V0pbhtsrhoD3nkQ6b/OYPcS0=
X-Received: by 2002:aa7:9f08:: with SMTP id g8mr1044703pfr.59.1574217720603;
 Tue, 19 Nov 2019 18:42:00 -0800 (PST)
MIME-Version: 1.0
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
 <6cba1e53-1c0d-d408-4d16-cae93ec9e62e@amd.com>
In-Reply-To: <6cba1e53-1c0d-d408-4d16-cae93ec9e62e@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Tue, 19 Nov 2019 21:41:24 -0500
Message-ID:
 <CAAxE2A6ZdjfV1vWh1KQmTR+gVFq0n098Gg8bWjprwdqvUQGQoQ@mail.gmail.com>
Subject: Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers
To: Luben Tuikov <luben.tuikov@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=IHH2CSx2A+hLvcOPyytuvTrzA17g2pC7lUwaAxSNtac=;
 b=PyLBdt3esjauPaAHQqvPW9sfLctG9t9/joVnSxkcOVCpLKQtjxu6lxEeciriKgK59m
 SIXGo0uRzs6wW55Qc2Guf/5Hcd1TvpIkWhbVLfKVxLWcjBPhHof/yfS1KkHarE2m3WoD
 1qtHPYyNbSIhIJXjYw6fjNXCC0AKn8//5zyKTMNkFKTZp+BYd3vlvWCZbS+3XXxhe5X3
 Z7qsaQSSfya3YUmFjkFrT4+CpKftTHwFcoAUKPiizbAQEYgTGLn+mYZZlr2uhL0W2y3C
 PeTzA14sh/EZsp1JwhXjUZAd6Izr5FnTAH+46yNNFSGSNuGKXmA5d++S8VLh/rVGa7nk
 d7Yg==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <Marek.Olsak@amd.com>,
 Aaron Liu <aaron.liu@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Huang Rui <Ray.Huang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Leo Liu <Leo.Liu@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig@amd.com>
Content-Type: multipart/mixed; boundary="===============1592762865=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120024124.EIDt_j-Ieie_7HUQRtLMLHhmZRrDf9vRVWN2DbVEJ6U@z>

--===============1592762865==
Content-Type: multipart/alternative; boundary="0000000000000929110597be2086"

--0000000000000929110597be2086
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 19, 2019 at 8:52 PM Luben Tuikov <luben.tuikov@amd.com> wrote:

> On 2019-11-14 10:34 p.m., Aaron Liu wrote:
> > From: Huang Rui <ray.huang@amd.com>
> >
> > To align the kernel uapi change from Alex:
> >
> > "Add a flag to the GEM_CREATE ioctl to create encrypted buffers. Buffers
> with
> > this flag set will be created with the TMZ bit set in the PTEs or engines
> > accessing them. This is required in order to properly access the data
> from the
> > engines."
> >
> > We will use GEM_CREATE_ENCRYPTED flag for secure buffer allocation.
> >
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  include/drm/amdgpu_drm.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h
> > index 5c28aa7..1a95e37 100644
> > --- a/include/drm/amdgpu_drm.h
> > +++ b/include/drm/amdgpu_drm.h
> > @@ -141,6 +141,11 @@ extern "C" {
> >   * releasing the memory
> >   */
> >  #define AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE       (1 << 9)
> > +/* Flag that BO will be encrypted and that the TMZ bit should be
> > + * set in the PTEs when mapping this buffer via GPUVM or
> > + * accessing it with various hw blocks
> > + */
> > +#define AMDGPU_GEM_CREATE_ENCRYPTED          (1 << 10)
>
> Style!
> TAB char?!
>
> You have a TAB char between ".._ENCRYPTED" and "(1 << 10)"
> Do NOT add/insert TAB chars instead of space to align colunmns!
> If when you press Tab key a tab is inserted, as opposed to the line
> indented, then DO NOT use this editor.
> The Tab key should "indent according to mode" by inserting TAB chars.
> If the line is already indented, as this one is, then it should do nothing.
>

I disagree with this 100%. Tabs or spaces don't matter here from my
perspective. I also disagree with your language. It's overly impolite.

Marek

--0000000000000929110597be2086
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Tue, Nov 19, 2019 at 8:52 PM Luben Tuikov &lt;<a href=3D"mailto:l=
uben.tuikov@amd.com" target=3D"_blank">luben.tuikov@amd.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 2019-11-14 10=
:34 p.m., Aaron Liu wrote:<br>
&gt; From: Huang Rui &lt;<a href=3D"mailto:ray.huang@amd.com" target=3D"_bl=
ank">ray.huang@amd.com</a>&gt;<br>
&gt; <br>
&gt; To align the kernel uapi change from Alex:<br>
&gt; <br>
&gt; &quot;Add a flag to the GEM_CREATE ioctl to create encrypted buffers. =
Buffers with<br>
&gt; this flag set will be created with the TMZ bit set in the PTEs or engi=
nes<br>
&gt; accessing them. This is required in order to properly access the data =
from the<br>
&gt; engines.&quot;<br>
&gt; <br>
&gt; We will use GEM_CREATE_ENCRYPTED flag for secure buffer allocation.<br=
>
&gt; <br>
&gt; Signed-off-by: Huang Rui &lt;<a href=3D"mailto:ray.huang@amd.com" targ=
et=3D"_blank">ray.huang@amd.com</a>&gt;<br>
&gt; Reviewed-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.=
com" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 include/drm/amdgpu_drm.h | 5 +++++<br>
&gt;=C2=A0 1 file changed, 5 insertions(+)<br>
&gt; <br>
&gt; diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h<br>
&gt; index 5c28aa7..1a95e37 100644<br>
&gt; --- a/include/drm/amdgpu_drm.h<br>
&gt; +++ b/include/drm/amdgpu_drm.h<br>
&gt; @@ -141,6 +141,11 @@ extern &quot;C&quot; {<br>
&gt;=C2=A0 =C2=A0* releasing the memory<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 #define AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE=C2=A0 =C2=A0 =C2=
=A0 =C2=A0(1 &lt;&lt; 9)<br>
&gt; +/* Flag that BO will be encrypted and that the TMZ bit should be<br>
&gt; + * set in the PTEs when mapping this buffer via GPUVM or<br>
&gt; + * accessing it with various hw blocks<br>
&gt; + */<br>
&gt; +#define AMDGPU_GEM_CREATE_ENCRYPTED=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (1 &lt;&lt; 10)<br>
<br>
Style!<br>
TAB char?!<br>
<br>
You have a TAB char between &quot;.._ENCRYPTED&quot; and &quot;(1 &lt;&lt; =
10)&quot;<br>
Do NOT add/insert TAB chars instead of space to align colunmns!<br>
If when you press Tab key a tab is inserted, as opposed to the line<br>
indented, then DO NOT use this editor.<br>
The Tab key should &quot;indent according to mode&quot; by inserting TAB ch=
ars.<br>
If the line is already indented, as this one is, then it should do nothing.=
<br></blockquote><div><br></div><div>I disagree with this 100%. Tabs or spa=
ces don&#39;t matter here from my perspective. I also disagree with your la=
nguage. It&#39;s overly impolite.<br></div><div><br></div><div>Marek</div><=
/div></div>

--0000000000000929110597be2086--

--===============1592762865==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1592762865==--
