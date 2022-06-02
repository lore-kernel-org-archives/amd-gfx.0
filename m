Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2F9C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 06:26:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B3451134B9;
	Thu,  2 Jun 2022 06:26:18 +0000 (UTC)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A04531134B9
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 06:26:16 +0000 (UTC)
Received: by mail-il1-x130.google.com with SMTP id f7so2813893ilr.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jun 2022 23:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Sec2StwspJmVRskRjp96pRe9qwUjKWoqh50yLqXH9ug=;
 b=H4RaTyflgiBozDBBf2ayzDs8+j52LBlWi9aoUcMg5siJcfJBVBvWuN+dzI6IQ/UJVg
 iGc+hjOkFpq3TC9rHaC7G3oV/Qh4o9PqFJiPP1Qk85Dtp36vGsH7Hr3M02aNbL8wOiIR
 sv3sqaVS3TzVTUxXco0MuZnkIysMiuhyFj+y+KXrV5Pl9L/baUui8Bp4aRfEbE78Jkh2
 64ySgAhVkjkdY4v1vXgxcx1FDSFuH1fScP/55wDSV9cnD0x8FOH32X0GfZlOoiO4wCM4
 dQaF9oBtbQakKpNsyDI+pdVVX/5ddD24a6y/tikAV3yxdOJxpcxJ9E3prZmRC2D24xtT
 1Zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Sec2StwspJmVRskRjp96pRe9qwUjKWoqh50yLqXH9ug=;
 b=pEY3GKOEkx8IOtw/AP7k3nnaFFaXF66nghLnJ90/V38y6tTrUnNqwqSSul5hA8On+i
 nfAlWR8Qm5UggBZQGb/gQVSMTfzmnjujNIT/tnYz4C+WDQKrzYmwIndjs2PxtvpvuP4D
 EJ1Q6aoOmIV+ZvjmuoqVWBSgFXGWgUbEy5MgRsMjqhdSf1T0jovFIagLpe7YZ14LcfUJ
 rQQuG+jM4wETUQbRxtCLbM5zStQZ0svwnNvoHJ/dpEW7BQjGGQhvVtT69jeYx1be69eZ
 xjQ1OgdmsSP2k70dINFbLjw3hgxDCkWq7NUCCJzEPU/Iv4w0EYx1mOw9PVqXB5siBIh0
 CLVw==
X-Gm-Message-State: AOAM531uaF6Mr15lprHQennYY/bXUmmiGuCbc2Js9O3psLGMir7IMjYE
 35+BTTZT9RnqpyJs004pqj9Hv4Kaydz6S1aKh/ockhUCf/k=
X-Google-Smtp-Source: ABdhPJwteCAo4z7WTz3zezsmIL6ygOaKVn8nmz09vHEXtejcyPeZqBb2IshMxG8ZGqcxpUi/8mY+ocDswQ6XxUu8jC4=
X-Received: by 2002:a05:6e02:1b04:b0:2d1:af55:eb92 with SMTP id
 i4-20020a056e021b0400b002d1af55eb92mr2279884ilv.227.1654151175897; Wed, 01
 Jun 2022 23:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <202205271546.oV14N2r8-lkp@intel.com>
 <CADnq5_NOkqRsoqELkLayNU+xArXd-4RO=_banvJpXHtSW4-YdA@mail.gmail.com>
In-Reply-To: <CADnq5_NOkqRsoqELkLayNU+xArXd-4RO=_banvJpXHtSW4-YdA@mail.gmail.com>
From: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Date: Thu, 2 Jun 2022 08:26:03 +0200
Message-ID: <CAD=4a=WRbp8w4DA2c6hE7W5A2-woRyHLvtC-GPitFwQireCeNw@mail.gmail.com>
Subject: Re: [kbuild] drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1433
 amdgpu_discovery_get_vcn_info() error: buffer overflow
 'adev->vcn.vcn_codec_disable_mask' 2 <= 3
To: Alex Deucher <alexdeucher@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000003e8b7705e0711583"
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
Cc: kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>,
 kbuild@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--0000000000003e8b7705e0711583
Content-Type: text/plain; charset="UTF-8"

Dan: I also ran Smatch which resulted in the following discussion:

https://lists.freedesktop.org/archives/amd-gfx/2022-May/079228.html

Regards

Den ons 1 juni 2022 kl 20:44 skrev Alex Deucher <alexdeucher@gmail.com>:

> On Fri, May 27, 2022 at 3:46 AM Dan Carpenter <dan.carpenter@oracle.com>
> wrote:
> >
> > [ kbuild bot sent this warning on May 4 but I never heard back and it's
> >   May 27 now so sending a duplicate warning is probably for the best.
> -dan]
> >
> > tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
> > head:   7e284070abe53d448517b80493863595af4ab5f0
> > commit: 622469c87fc3e6c90a980be3e2287d82bd55c977 drm/amdgpu/discovery:
> add a function to parse the vcn info table
> > config: arc-randconfig-m031-20220524 (
> https://download.01.org/0day-ci/archive/20220527/202205271546.oV14N2r8-lkp@intel.com/config
> )
> > compiler: arceb-elf-gcc (GCC) 11.3.0
> >
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > smatch warnings:
> > drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1433
> amdgpu_discovery_get_vcn_info() error: buffer overflow
> 'adev->vcn.vcn_codec_disable_mask' 2 <= 3
> >
> > vim +1433 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> >
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1403  int
> amdgpu_discovery_get_vcn_info(struct amdgpu_device *adev)
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1404  {
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1405    struct binary_header
> *bhdr;
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1406    union vcn_info *vcn_info;
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1407    u16 offset;
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1408    int v;
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1409
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1410    if
> (!adev->mman.discovery_bin) {
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1411            DRM_ERROR("ip
> discovery uninitialized\n");
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1412            return -EINVAL;
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1413    }
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1414
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1415    if
> (adev->vcn.num_vcn_inst > VCN_INFO_TABLE_MAX_NUM_INSTANCES) {
> >
> > Capped to 4
> >
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1416
> dev_err(adev->dev, "invalid vcn instances\n");
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1417            return -EINVAL;
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1418    }
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1419
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1420    bhdr = (struct
> binary_header *)adev->mman.discovery_bin;
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1421    offset =
> le16_to_cpu(bhdr->table_list[VCN_INFO].offset);
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1422
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1423    if (!offset) {
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1424
> dev_err(adev->dev, "invalid vcn table offset\n");
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1425            return -EINVAL;
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1426    }
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1427
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1428    vcn_info = (union
> vcn_info *)(adev->mman.discovery_bin + offset);
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1429
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1430    switch
> (le16_to_cpu(vcn_info->v1.header.version_major)) {
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1431    case 1:
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1432            for (v = 0; v <
> adev->vcn.num_vcn_inst; v++) {
> > 622469c87fc3e6 Alex Deucher 2022-03-30 @1433
> adev->vcn.vcn_codec_disable_mask[v] =
> >
> > But this array doesn't have 4 elements
>
> Correct, but num_vcn_inst can't be larger than
> AMDGPU_MAX_VCN_INSTANCES (2) at the moment thanks to:
> https://patchwork.freedesktop.org/patch/486289/
>
> Alex
>
> >
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1434
> le32_to_cpu(vcn_info->v1.instance_info[v].fuse_data.all_bits);
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1435            }
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1436            break;
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1437    default:
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1438
> dev_err(adev->dev,
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1439
> "Unhandled VCN info table %d.%d\n",
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1440
> le16_to_cpu(vcn_info->v1.header.version_major),
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1441
> le16_to_cpu(vcn_info->v1.header.version_minor));
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1442            return -EINVAL;
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1443    }
> > 622469c87fc3e6 Alex Deucher 2022-03-30  1444    return 0;
> > f39f5bb1c9d68d Xiaojie Yuan 2019-06-20  1445  }
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://01.org/lkp
> > _______________________________________________
> > kbuild mailing list -- kbuild@lists.01.org
> > To unsubscribe send an email to kbuild-leave@lists.01.org
> >
>

--0000000000003e8b7705e0711583
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">Dan: I also ran Smatch which resulted in the following =
discussion:</div><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-fa=
mily:arial,helvetica,sans-serif"><a href=3D"https://lists.freedesktop.org/a=
rchives/amd-gfx/2022-May/079228.html">https://lists.freedesktop.org/archive=
s/amd-gfx/2022-May/079228.html</a></div><div class=3D"gmail_default" style=
=3D"font-family:arial,helvetica,sans-serif"><br></div><div class=3D"gmail_d=
efault" style=3D"font-family:arial,helvetica,sans-serif">Regards<br></div><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">D=
en ons 1 juni 2022 kl 20:44 skrev Alex Deucher &lt;<a href=3D"mailto:alexde=
ucher@gmail.com">alexdeucher@gmail.com</a>&gt;:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Fri, May 27, 2022 at 3:46 AM Dan Carpen=
ter &lt;<a href=3D"mailto:dan.carpenter@oracle.com" target=3D"_blank">dan.c=
arpenter@oracle.com</a>&gt; wrote:<br>
&gt;<br>
&gt; [ kbuild bot sent this warning on May 4 but I never heard back and it&=
#39;s<br>
&gt;=C2=A0 =C2=A0May 27 now so sending a duplicate warning is probably for =
the best. -dan]<br>
&gt;<br>
&gt; tree:=C2=A0 =C2=A0<a href=3D"https://git.kernel.org/pub/scm/linux/kern=
el/git/torvalds/linux.git" rel=3D"noreferrer" target=3D"_blank">https://git=
.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git</a>=C2=A0 master<br=
>
&gt; head:=C2=A0 =C2=A07e284070abe53d448517b80493863595af4ab5f0<br>
&gt; commit: 622469c87fc3e6c90a980be3e2287d82bd55c977 drm/amdgpu/discovery:=
 add a function to parse the vcn info table<br>
&gt; config: arc-randconfig-m031-20220524 (<a href=3D"https://download.01.o=
rg/0day-ci/archive/20220527/202205271546.oV14N2r8-lkp@intel.com/config" rel=
=3D"noreferrer" target=3D"_blank">https://download.01.org/0day-ci/archive/2=
0220527/202205271546.oV14N2r8-lkp@intel.com/config</a> )<br>
&gt; compiler: arceb-elf-gcc (GCC) 11.3.0<br>
&gt;<br>
&gt; If you fix the issue, kindly add following tag where applicable<br>
&gt; Reported-by: kernel test robot &lt;<a href=3D"mailto:lkp@intel.com" ta=
rget=3D"_blank">lkp@intel.com</a>&gt;<br>
&gt; Reported-by: Dan Carpenter &lt;<a href=3D"mailto:dan.carpenter@oracle.=
com" target=3D"_blank">dan.carpenter@oracle.com</a>&gt;<br>
&gt;<br>
&gt; smatch warnings:<br>
&gt; drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1433 amdgpu_discovery_ge=
t_vcn_info() error: buffer overflow &#39;adev-&gt;vcn.vcn_codec_disable_mas=
k&#39; 2 &lt;=3D 3<br>
&gt;<br>
&gt; vim +1433 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt;<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1403=C2=A0 int amdgpu_dis=
covery_get_vcn_info(struct amdgpu_device *adev)<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1404=C2=A0 {<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1405=C2=A0 =C2=A0 struct =
binary_header *bhdr;<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1406=C2=A0 =C2=A0 union v=
cn_info *vcn_info;<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1407=C2=A0 =C2=A0 u16 off=
set;<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1408=C2=A0 =C2=A0 int v;<=
br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1409<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1410=C2=A0 =C2=A0 if (!ad=
ev-&gt;mman.discovery_bin) {<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1411=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 DRM_ERROR(&quot;ip discovery uninitialized\n&quot;);<b=
r>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1412=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1413=C2=A0 =C2=A0 }<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1414<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1415=C2=A0 =C2=A0 if (ade=
v-&gt;vcn.num_vcn_inst &gt; VCN_INFO_TABLE_MAX_NUM_INSTANCES) {<br>
&gt;<br>
&gt; Capped to 4<br>
&gt;<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1416=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 dev_err(adev-&gt;dev, &quot;invalid vcn instances\n&qu=
ot;);<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1417=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1418=C2=A0 =C2=A0 }<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1419<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1420=C2=A0 =C2=A0 bhdr =
=3D (struct binary_header *)adev-&gt;mman.discovery_bin;<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1421=C2=A0 =C2=A0 offset =
=3D le16_to_cpu(bhdr-&gt;table_list[VCN_INFO].offset);<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1422<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1423=C2=A0 =C2=A0 if (!of=
fset) {<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1424=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 dev_err(adev-&gt;dev, &quot;invalid vcn table offset\n=
&quot;);<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1425=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1426=C2=A0 =C2=A0 }<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1427<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1428=C2=A0 =C2=A0 vcn_inf=
o =3D (union vcn_info *)(adev-&gt;mman.discovery_bin + offset);<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1429<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1430=C2=A0 =C2=A0 switch =
(le16_to_cpu(vcn_info-&gt;v1.header.version_major)) {<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1431=C2=A0 =C2=A0 case 1:=
<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1432=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 for (v =3D 0; v &lt; adev-&gt;vcn.num_vcn_inst; v++) {=
<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30 @1433=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;vcn.vcn_codec_disabl=
e_mask[v] =3D<br>
&gt;<br>
&gt; But this array doesn&#39;t have 4 elements<br>
<br>
Correct, but num_vcn_inst can&#39;t be larger than<br>
AMDGPU_MAX_VCN_INSTANCES (2) at the moment thanks to:<br>
<a href=3D"https://patchwork.freedesktop.org/patch/486289/" rel=3D"noreferr=
er" target=3D"_blank">https://patchwork.freedesktop.org/patch/486289/</a><b=
r>
<br>
Alex<br>
<br>
&gt;<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1434=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 le32_to_cpu(vcn_info-&gt;v1.instance_info[v].fuse_data.all_bits);<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1435=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1436=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1437=C2=A0 =C2=A0 default=
:<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1438=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 dev_err(adev-&gt;dev,<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1439=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Unhandled VCN info t=
able %d.%d\n&quot;,<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1440=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 le16_to_cpu(vcn_info-&gt;v=
1.header.version_major),<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1441=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 le16_to_cpu(vcn_info-&gt;v=
1.header.version_minor));<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1442=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1443=C2=A0 =C2=A0 }<br>
&gt; 622469c87fc3e6 Alex Deucher 2022-03-30=C2=A0 1444=C2=A0 =C2=A0 return =
0;<br>
&gt; f39f5bb1c9d68d Xiaojie Yuan 2019-06-20=C2=A0 1445=C2=A0 }<br>
&gt;<br>
&gt; --<br>
&gt; 0-DAY CI Kernel Test Service<br>
&gt; <a href=3D"https://01.org/lkp" rel=3D"noreferrer" target=3D"_blank">ht=
tps://01.org/lkp</a><br>
&gt; _______________________________________________<br>
&gt; kbuild mailing list -- <a href=3D"mailto:kbuild@lists.01.org" target=
=3D"_blank">kbuild@lists.01.org</a><br>
&gt; To unsubscribe send an email to <a href=3D"mailto:kbuild-leave@lists.0=
1.org" target=3D"_blank">kbuild-leave@lists.01.org</a><br>
&gt;<br>
</blockquote></div>

--0000000000003e8b7705e0711583--
