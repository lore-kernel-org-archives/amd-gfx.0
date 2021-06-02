Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA361C4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 14:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91D09613B4
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 14:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D09613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A54D6ECDB;
	Wed,  2 Jun 2021 14:56:31 +0000 (UTC)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9E566E08A
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 14:44:16 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 pi6-20020a17090b1e46b029015cec51d7cdso1900067pjb.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Jun 2021 07:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RG2zZn2GOlfCVSw5PRtCW7f9Pz6B5okQOcIcUuwh154=;
 b=o6bLv8nxQ20Pi7HOFWzh/I7upnZhc/C0vEWIQIFSORmJPHD8nRVwSM1aBL828EKrFW
 iqCxMPOs1e4o7SeeY79ISktweOgvd1j11X5hoiyVtHS848JSp6818VqM/rU5AU6CWIRo
 23GddM2nFZ9ouretmU8VPgpVB4jcW4VqF3ikGSn+/Cv/K0le9jtGJdQOMKvByuUykuDm
 H+JiPMd9cesNxEMuSUpeh67D7fkpxDT+vBQttexhqJ2TBZ0u7cL88nJWz5OzmF/zgciu
 oPywS3F6STcvMOBZzfRFvtzconnnjlcMdbjDMnsF9NaXNtwFQc24ZqY6NX6xIYfMmIv0
 vv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RG2zZn2GOlfCVSw5PRtCW7f9Pz6B5okQOcIcUuwh154=;
 b=BTH+f3PkbAZSps0GRn1D1DJp7TBlDSgtxJcMV7QTbN1noLCI7XwMj+osnuESzu5gC5
 XduCZH1woT0N1S5YG5Pl33aTHN9BgVo94KcGncLJrYq5m6ejvn2b5K9iMMgaZ0d05quG
 PBD3ssst2lUl+F3M/96LLJqrXRBGbbAEx2j+raDBxNGXfyIPA7sKVr0LGjDhNuP1QLWi
 cHIo7kvPRPrSIpg+vwBlu2oF8Qbg3D2L2GfYXDSdD+p6+3f0/lWmzPlnUGF9bGUW1POC
 RZ+zJX2ozEhJNp6cO2AzsZlpVVwMEp5RurboBa36MnojKidHdk0p6eOerYCDITgTaMjY
 70Lg==
X-Gm-Message-State: AOAM531BtmeTnUB2JRJ7eSvJmf23PckgaDwSYmpzoCbExC2rq/WU2cWU
 pDQskuL1OFEhqu/72MnqV0Y23r7BBop4izLmfmrU2A==
X-Google-Smtp-Source: ABdhPJzq11CklmKMThzPHd6RqGhvgqHosjR7bEPBSCM/WoFWb0CgEKzUgPDlxP8Dpvmer/PcjwAgdvHgLLg9XjN8Xrw=
X-Received: by 2002:a17:902:e54d:b029:104:cac:903 with SMTP id
 n13-20020a170902e54db02901040cac0903mr17726009plf.35.1622645055192; Wed, 02
 Jun 2021 07:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210602095305.41936-1-michel@daenzer.net>
 <1cb79c0b-63f4-777d-29f3-552987aeb790@gmail.com>
In-Reply-To: <1cb79c0b-63f4-777d-29f3-552987aeb790@gmail.com>
From: Mark Yacoub <markyacoub@google.com>
Date: Wed, 2 Jun 2021 10:44:04 -0400
Message-ID: <CAC0gqY4iO3kXq_6zafWnfQehXCgzPLhzmuJ3qSnC-nSnw0MGHQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Use drm_dbg_kms for reporting failure to get
 a GEM FB
To: Mark Yacoub <markyacoub@chromium.org>
X-Mailman-Approved-At: Wed, 02 Jun 2021 14:56:30 +0000
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
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0420236584=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0420236584==
Content-Type: multipart/alternative; boundary="0000000000001ce41605c3c97ec8"

--0000000000001ce41605c3c97ec8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 2, 2021 at 5:56 AM Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com> wrote:

>
>
> Am 02.06.21 um 11:53 schrieb Michel D=C3=A4nzer:
> > From: Michel D=C3=A4nzer <mdaenzer@redhat.com>
> >
> > drm_err meant broken user space could spam dmesg.
> >
> > Fixes: f258907fdd835e "drm/amdgpu: Verify bo size can fit framebuffer
> >                         size on init."
> > Signed-off-by: Michel D=C3=A4nzer <mdaenzer@redhat.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > index 8170e24ce37d..2a4cd7d377bf 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > @@ -1058,7 +1058,7 @@ int amdgpu_display_gem_fb_init(struct drm_device
> *dev,
> >
> >       return 0;
> >   err:
> > -     drm_err(dev, "Failed to init gem fb: %d\n", ret);
> > +     drm_dbg_kms(dev, "Failed to init gem fb: %d\n", ret);
> >       rfb->base.obj[0] =3D NULL;
> >       return ret;
> >   }
> > @@ -1096,7 +1096,7 @@ int amdgpu_display_gem_fb_verify_and_init(
> >
> >       return 0;
> >   err:
> > -     drm_err(dev, "Failed to verify and init gem fb: %d\n", ret);
> > +     drm_dbg_kms(dev, "Failed to verify and init gem fb: %d\n", ret);
> >       rfb->base.obj[0] =3D NULL;
> >       return ret;
> >   }
>
>

--0000000000001ce41605c3c97ec8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Jun 2, 2021 at 5:56 AM Christian K=C3=B6nig &l=
t;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com">ckoenig.leichtzumerke=
n@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><br>
<br>
Am 02.06.21 um 11:53 schrieb Michel D=C3=A4nzer:<br>
&gt; From: Michel D=C3=A4nzer &lt;<a href=3D"mailto:mdaenzer@redhat.com" ta=
rget=3D"_blank">mdaenzer@redhat.com</a>&gt;<br>
&gt;<br>
&gt; drm_err meant broken user space could spam dmesg.<br>
&gt;<br>
&gt; Fixes: f258907fdd835e &quot;drm/amdgpu: Verify bo size can fit framebu=
ffer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0size on init.&quot;<br>
&gt; Signed-off-by: Michel D=C3=A4nzer &lt;<a href=3D"mailto:mdaenzer@redha=
t.com" target=3D"_blank">mdaenzer@redhat.com</a>&gt;<br>
<br>
Reviewed-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@am=
d.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;<br>
<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 4 ++--<br>
&gt;=C2=A0 =C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_display.c<br>
&gt; index 8170e24ce37d..2a4cd7d377bf 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
&gt; @@ -1058,7 +1058,7 @@ int amdgpu_display_gem_fb_init(struct drm_device=
 *dev,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0err:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0drm_err(dev, &quot;Failed to init gem fb: %d\n&qu=
ot;, ret);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0drm_dbg_kms(dev, &quot;Failed to init gem fb: %d\=
n&quot;, ret);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rfb-&gt;base.obj[0] =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; @@ -1096,7 +1096,7 @@ int amdgpu_display_gem_fb_verify_and_init(<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0err:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0drm_err(dev, &quot;Failed to verify and init gem =
fb: %d\n&quot;, ret);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0drm_dbg_kms(dev, &quot;Failed to verify and init =
gem fb: %d\n&quot;, ret);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rfb-&gt;base.obj[0] =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 =C2=A0}<br>
<br>
</blockquote></div>

--0000000000001ce41605c3c97ec8--

--===============0420236584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0420236584==--
