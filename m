Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6671DC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 16 May 2022 17:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E50112BCA;
	Mon, 16 May 2022 17:50:09 +0000 (UTC)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7142A112BCA
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 17:50:09 +0000 (UTC)
Received: by mail-io1-xd2d.google.com with SMTP id h85so16760018iof.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 10:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UB0QYCg9fcQBFl/bS+bJFD5Hzc9uD7RMFlAAO09mxE4=;
 b=pfdUmRHoleOVY8PgbtE/n4SYxZPS+f+uJYwArUCqYq9r2u6mKZgDzJHBYnTmVDwuPJ
 TzLu6qdFy729LSfuUJAtx5+vaVLKwQuGVmcN0g2sYupHusU0KX6Ex9t/xV39k7iJhKaY
 x/QAQDXddWICOn7aBS2lGpWMwgDB56R+4mtXxnmz3omk3y/iwV/n+r5Y1pwE/avswnJ3
 w5w6w7/ACp/1dk0CLJL50Izxt3A+ZkxIGdRPJoRxKxYkiIFISTTPTToi96ZyJfSEtobt
 0njNIIZ1gg93N4EPAwKawd6sbCrNr60XBRtGhPoL1Rsj7MzeivBjce4JOrolGjpkPDbt
 tmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UB0QYCg9fcQBFl/bS+bJFD5Hzc9uD7RMFlAAO09mxE4=;
 b=15i9N+cTH+5rm9QJwkuRGVooYFnEwQcjLSeXdvBGiSLkkA6vb0nUm94I6N47wbZP7P
 xQlG4usej31zqEBkLiFw1e3hrMCQ6/NxNv8JoNubPlBttBIl0U6QMqMm5m0pnjxUHvk/
 0QBag9y3diF7qD6afQdH/33F2z07jaSuOuagkz+SPbinRJoc9NReT+lalWlMWBb/3nLJ
 fBacM5U+GLxn65pD0dshMROXKkvqpw6TqVc5T/pDHLA6t+a8Y2J5AysS6BWV9toVxnz+
 sNRShWNoexxpExw8+AZqrgC/NC5kVcLI4UAmEBd3iPw6uyDzBwaQ/BQBD1hGhsHwb42X
 51Jw==
X-Gm-Message-State: AOAM531J5ltOK4p+ImIJkvourIBOKUoueaNXHdEfoHe5oKMb5fPj0Pbq
 n0uwUAPwoZCPH+H+DdBpcMUlMjC9bz+mU69ahkaaREBFV0c=
X-Google-Smtp-Source: ABdhPJxtVtbLcshI6hooGaNOBVHnysO2/6Sdz/mU9p84XEE+9ABpCEVSSMhQIrX+a/c97acIYnG1HTOppJ7sCKkjNgA=
X-Received: by 2002:a05:6638:40a7:b0:32b:8f56:d126 with SMTP id
 m39-20020a05663840a700b0032b8f56d126mr9721933jam.107.1652723408719; Mon, 16
 May 2022 10:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAD=4a=VSEST+6oiPRrMNNd1ByQm0e+pG=vCLb--bTXDZT0LnoQ@mail.gmail.com>
 <CADnq5_Ng2sfX5h0OxOu1VU7qGxXbaAfJemFT59ouYgH6SJsiGA@mail.gmail.com>
In-Reply-To: <CADnq5_Ng2sfX5h0OxOu1VU7qGxXbaAfJemFT59ouYgH6SJsiGA@mail.gmail.com>
From: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Date: Mon, 16 May 2022 19:49:57 +0200
Message-ID: <CAD=4a=UT+P33BnKufwGvqYx50qR9SvzEXsPsVJ7Bf2iegMczbw@mail.gmail.com>
Subject: Re: VCN_INFO_TABLE_MAX_NUM_INSTANCES vs AMDGPU_MAX_VCN_INSTANCES
To: Alex Deucher <alexdeucher@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000b0560f05df24a748"
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000b0560f05df24a748
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Den m=C3=A5n 16 maj 2022 kl 17:13 skrev Alex Deucher <alexdeucher@gmail.com=
>:

> On Sun, May 15, 2022 at 11:46 AM Ernst Sj=C3=B6strand <ernstp@gmail.com> =
wrote:
> >
> > smatch found this problem on amd-staging-drm-next:
> >
> > drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1443
> amdgpu_discovery_get_vcn_info() error: buffer overflow
> 'adev->vcn.vcn_codec_disable_mask' 2 <=3D 3
> >
> > This is caused by:
> > #define AMDGPU_MAX_VCN_INSTANCES 2
> > #define VCN_INFO_TABLE_MAX_NUM_INSTANCES 4
> >
> > Can we just drop VCN_INFO_TABLE_MAX_NUM_INSTANCES completely and use
> AMDGPU_MAX_VCN_INSTANCES everywhere instead (and bump it to 4)?
>
> We should be able to bump AMDGPU_MAX_VCN_INSTANCES to 4 (although it
> would waste some memory in the places it is used at this point).
> VCN_INFO_TABLE_MAX_NUM_INSTANCES is part of a firmware structure so we
> can't change that without breaking the firmware structure.
>
> Alex
>

It would be nice to get rid of this pattern and make sure it doesn't happen
again when the VCN info table is raised to 5.
It's very similar to the HWIP_MAX_INSTANCE issue.

//E

--000000000000b0560f05df24a748
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div style=3D"font-family:arial,helvetica,sans-serif" clas=
s=3D"gmail_default"></div><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">Den m=C3=A5n 16 maj 2022 kl 17:13 skrev Alex Deucher &lt;<a=
 href=3D"mailto:alexdeucher@gmail.com" target=3D"_blank">alexdeucher@gmail.=
com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
Sun, May 15, 2022 at 11:46 AM Ernst Sj=C3=B6strand &lt;<a href=3D"mailto:er=
nstp@gmail.com" target=3D"_blank">ernstp@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; smatch found this problem on amd-staging-drm-next:<br>
&gt;<br>
&gt; drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1443 amdgpu_discovery_ge=
t_vcn_info() error: buffer overflow &#39;adev-&gt;vcn.vcn_codec_disable_mas=
k&#39; 2 &lt;=3D 3<br>
&gt;<br>
&gt; This is caused by:<br>
&gt; #define AMDGPU_MAX_VCN_INSTANCES 2<br>
&gt; #define VCN_INFO_TABLE_MAX_NUM_INSTANCES 4<br>
&gt;<br>
&gt; Can we just drop VCN_INFO_TABLE_MAX_NUM_INSTANCES completely and use A=
MDGPU_MAX_VCN_INSTANCES everywhere instead (and bump it to 4)?<br>
<br>
We should be able to bump AMDGPU_MAX_VCN_INSTANCES to 4 (although it<br>
would waste some memory in the places it is used at this point).<br>
VCN_INFO_TABLE_MAX_NUM_INSTANCES is part of a firmware structure so we<br>
can&#39;t change that without breaking the firmware structure.<br>
<br>
Alex<br></blockquote><div><br></div><div style=3D"font-family:arial,helveti=
ca,sans-serif" class=3D"gmail_default">It would be nice to get rid of this =
pattern and make sure it doesn&#39;t happen again when the VCN info table i=
s raised to 5.</div><div style=3D"font-family:arial,helvetica,sans-serif" c=
lass=3D"gmail_default">It&#39;s very similar to the HWIP_MAX_INSTANCE issue=
.</div><div style=3D"font-family:arial,helvetica,sans-serif" class=3D"gmail=
_default"><br></div><div style=3D"font-family:arial,helvetica,sans-serif" c=
lass=3D"gmail_default">//E<br></div><br></div></div>

--000000000000b0560f05df24a748--
