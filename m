Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA3AC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 16 May 2022 18:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B59810E141;
	Mon, 16 May 2022 18:18:37 +0000 (UTC)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74BC910E141
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 18:18:35 +0000 (UTC)
Received: by mail-il1-x12d.google.com with SMTP id d3so11054733ilr.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 11:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2BOz78P58lFgexBi29ZvCN4oCkzbRpY3l8GKdQGVPms=;
 b=oJyUQWBGKuk4pjToSD6JTjB7uKnvqZLg3PSjIDAF0H5AT6qJ8tXPFdVH/hF9QFLrNI
 x05krNzAq8zF7fSsNfTidfkxO5u/vaDqjeWJ5zdi9kX5T8x6TY1W9caW6WNeH+pfQnKU
 uM1iweCyZzBF1wOfCNy625TDoot0ohcW2bkorvBEJ+K4RpR/DJWmn1HTZEF3jjrZQFFB
 xhYWUFBzDg6SZoYjqPpIXZzVpVtbF/W3kFA+K7aOs5a3+D80K7NAgxnY/meqgp7HmI7m
 g9lVh8qDVpW5Jd1qzokS1T3NB61lEE9MlYROODd+z4Yu8Ofu26CAblTWZgtLOJaqB1Bw
 okEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2BOz78P58lFgexBi29ZvCN4oCkzbRpY3l8GKdQGVPms=;
 b=OSEUcrBTdn7fBk4EVnT4koKkA7P50RtL3VxZTZyphUoO05GUQhoFdtmMbgQwdMsRTS
 M1wKnVsKg2vSqibfNfO7c/6jhx0/Q4zbEaUv/UjhTVg6R7BovlrNQYryX5KNCgWTxt4U
 Au2KzjSCQjBjlCXNuww2/xwel7DnvpTCCZK5d+aRlpLH9u5KXJPNHhteKbYqiwPw4xvc
 gz766k3bNgvi9UJluSZgqV7CvK0ZXxePJ/MrSRwuZje1Kve4TEqImpZQss5x1tWoCKR7
 86gl26rn30fTtxhq12PpQ11oBGN4B4xa8uhFQPxbWNcJUc4S5VqvBBXz/I/VSt2l+eVQ
 oldg==
X-Gm-Message-State: AOAM533nGmVcSKEnLUmG8MVWlkjGOd3W0PhMhm5zqFchUJYITGdMossf
 L+NowsqS9tg/ajLbU83P1yOLPrcX7uqM56+B4izD3HWj
X-Google-Smtp-Source: ABdhPJw0oWIqNbl+TBQxzodUXhCUiws75RY2s8buml8Q/2G3IxtTgIJ4Yg0jqEr9gpv0hJ3NA6eyWrDAguq69kn+jPI=
X-Received: by 2002:a05:6e02:1c82:b0:2cf:1836:2579 with SMTP id
 w2-20020a056e021c8200b002cf18362579mr9600258ill.237.1652725114815; Mon, 16
 May 2022 11:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAD=4a=VSEST+6oiPRrMNNd1ByQm0e+pG=vCLb--bTXDZT0LnoQ@mail.gmail.com>
 <CADnq5_Ng2sfX5h0OxOu1VU7qGxXbaAfJemFT59ouYgH6SJsiGA@mail.gmail.com>
 <CAD=4a=UT+P33BnKufwGvqYx50qR9SvzEXsPsVJ7Bf2iegMczbw@mail.gmail.com>
 <28edd55e-2e11-20b9-0ee9-3fd3f3a92409@gmail.com>
 <CADnq5_OZ4Nf24rKP19WL5oourZJuasz9J=2j5ivxF_HrBzGRKg@mail.gmail.com>
In-Reply-To: <CADnq5_OZ4Nf24rKP19WL5oourZJuasz9J=2j5ivxF_HrBzGRKg@mail.gmail.com>
From: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Date: Mon, 16 May 2022 20:18:23 +0200
Message-ID: <CAD=4a=WNGPPXdfpymCVVjb2CvH=QS7GshoriQ6QRHq6nKxCOCQ@mail.gmail.com>
Subject: Re: VCN_INFO_TABLE_MAX_NUM_INSTANCES vs AMDGPU_MAX_VCN_INSTANCES
To: Alex Deucher <alexdeucher@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000614ca005df250d50"
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000614ca005df250d50
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks good to me!

Den m=C3=A5n 16 maj 2022 kl 20:15 skrev Alex Deucher <alexdeucher@gmail.com=
>:

> On Mon, May 16, 2022 at 2:10 PM Christian K=C3=B6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
> >
> > Am 16.05.22 um 19:49 schrieb Ernst Sj=C3=B6strand:
> >
> > Den m=C3=A5n 16 maj 2022 kl 17:13 skrev Alex Deucher <alexdeucher@gmail=
.com>:
> >>
> >> On Sun, May 15, 2022 at 11:46 AM Ernst Sj=C3=B6strand <ernstp@gmail.co=
m>
> wrote:
> >> >
> >> > smatch found this problem on amd-staging-drm-next:
> >> >
> >> > drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1443
> amdgpu_discovery_get_vcn_info() error: buffer overflow
> 'adev->vcn.vcn_codec_disable_mask' 2 <=3D 3
> >> >
> >> > This is caused by:
> >> > #define AMDGPU_MAX_VCN_INSTANCES 2
> >> > #define VCN_INFO_TABLE_MAX_NUM_INSTANCES 4
> >> >
> >> > Can we just drop VCN_INFO_TABLE_MAX_NUM_INSTANCES completely and use
> AMDGPU_MAX_VCN_INSTANCES everywhere instead (and bump it to 4)?
> >>
> >> We should be able to bump AMDGPU_MAX_VCN_INSTANCES to 4 (although it
> >> would waste some memory in the places it is used at this point).
> >> VCN_INFO_TABLE_MAX_NUM_INSTANCES is part of a firmware structure so we
> >> can't change that without breaking the firmware structure.
> >>
> >> Alex
> >
> >
> > It would be nice to get rid of this pattern and make sure it doesn't
> happen again when the VCN info table is raised to 5.
> > It's very similar to the HWIP_MAX_INSTANCE issue.
> >
> >
> > No, as Alex explained that distinction is intentional.
> >
> > The firmware definition is 4 for future extensions, that doesn't mean
> that this is currently used.
> >
> > There is currently simply no need to set AMDGPU_MAX_VCN_INSTANCES to
> more than 2.
>
> Right.  The attached patch should protect against the scenario you are
> envisioning.
>
> Alex
>
> >
> > Regards,
> > Christian.
> >
> >
> > //E
> >
> >
>

--000000000000614ca005df250d50
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">Looks good to me!<br></div></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">Den m=C3=A5n 16 maj 2022 kl =
20:15 skrev Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexd=
eucher@gmail.com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Mon, May 16, 2022 at 2:10 PM Christian K=C3=B6nig<br>
&lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com" target=3D"_blank">c=
koenig.leichtzumerken@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Am 16.05.22 um 19:49 schrieb Ernst Sj=C3=B6strand:<br>
&gt;<br>
&gt; Den m=C3=A5n 16 maj 2022 kl 17:13 skrev Alex Deucher &lt;<a href=3D"ma=
ilto:alexdeucher@gmail.com" target=3D"_blank">alexdeucher@gmail.com</a>&gt;=
:<br>
&gt;&gt;<br>
&gt;&gt; On Sun, May 15, 2022 at 11:46 AM Ernst Sj=C3=B6strand &lt;<a href=
=3D"mailto:ernstp@gmail.com" target=3D"_blank">ernstp@gmail.com</a>&gt; wro=
te:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; smatch found this problem on amd-staging-drm-next:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1443 amdgpu_dis=
covery_get_vcn_info() error: buffer overflow &#39;adev-&gt;vcn.vcn_codec_di=
sable_mask&#39; 2 &lt;=3D 3<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; This is caused by:<br>
&gt;&gt; &gt; #define AMDGPU_MAX_VCN_INSTANCES 2<br>
&gt;&gt; &gt; #define VCN_INFO_TABLE_MAX_NUM_INSTANCES 4<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Can we just drop VCN_INFO_TABLE_MAX_NUM_INSTANCES completely =
and use AMDGPU_MAX_VCN_INSTANCES everywhere instead (and bump it to 4)?<br>
&gt;&gt;<br>
&gt;&gt; We should be able to bump AMDGPU_MAX_VCN_INSTANCES to 4 (although =
it<br>
&gt;&gt; would waste some memory in the places it is used at this point).<b=
r>
&gt;&gt; VCN_INFO_TABLE_MAX_NUM_INSTANCES is part of a firmware structure s=
o we<br>
&gt;&gt; can&#39;t change that without breaking the firmware structure.<br>
&gt;&gt;<br>
&gt;&gt; Alex<br>
&gt;<br>
&gt;<br>
&gt; It would be nice to get rid of this pattern and make sure it doesn&#39=
;t happen again when the VCN info table is raised to 5.<br>
&gt; It&#39;s very similar to the HWIP_MAX_INSTANCE issue.<br>
&gt;<br>
&gt;<br>
&gt; No, as Alex explained that distinction is intentional.<br>
&gt;<br>
&gt; The firmware definition is 4 for future extensions, that doesn&#39;t m=
ean that this is currently used.<br>
&gt;<br>
&gt; There is currently simply no need to set AMDGPU_MAX_VCN_INSTANCES to m=
ore than 2.<br>
<br>
Right.=C2=A0 The attached patch should protect against the scenario you are=
<br>
envisioning.<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt; Regards,<br>
&gt; Christian.<br>
&gt;<br>
&gt;<br>
&gt; //E<br>
&gt;<br>
&gt;<br>
</blockquote></div>

--000000000000614ca005df250d50--
