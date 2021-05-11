Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF1CC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 08:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30B9761001
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 08:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B9761001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 991016E9F0;
	Tue, 11 May 2021 08:19:29 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BEFE6E9F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 08:19:28 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id b15so4280765plh.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 01:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4SopXtb2Qz8Fu5jW4W2geD3T7mPqZYFy+++JpTvtHDk=;
 b=obuCZ38+jx4PnjbPIgtFgipVusuQ682DWMi4yoC4G9tAC7e3hT94NaUUiWQdgskDFS
 2BV5H4Bm12xJOaY8MeWChnP/DpQsIwWDNgZBk3JE8HyZY3NXFNhMEdNzO412O5i1Kd3R
 MurUl3yWYbvoP4q7aBJDRQZ9TRR5tG0+QysRCbJoB5IqcW8nlQzDfxULW7IkCP4HqFB2
 2ZCLnoFnU9THQTjBjGofqj+cYAHVoVOPAhnzOKnSmoALlegrM2Tp1yuSsKq55Xo3PybT
 L9rtbIdAhRVJzJ0EXiZRv2jHDDJgZnVEfrv3xQPHh6PBB/GmGoc7JbDyXO91MU7ooKO+
 e2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4SopXtb2Qz8Fu5jW4W2geD3T7mPqZYFy+++JpTvtHDk=;
 b=Yf/fsr8jbDjFvultOF3yIGWFrFM/rzuDfuCITXedv0DclGmQUe+zjkhC5D3MsHSJqG
 rpnQp8/dFVxjPu/csQP+rZvLEadpJK1KaUN05erw3bAVldsejB0kxCXDQOUQJT+HIUeA
 XjtDFRpjOGP0qadRHZK6SRqfKItx9Ba3sUTQVC4tAuNxm1OQX6Y3qWHaIZ8nsfMjcW5c
 ye2o0vDE66BK9PzIFc7rYCJXEFMY2HJMMnP1Y05r246fJ1POdUv6fClVxRVTvG5GB/Pb
 b55mKkYJ0F++BtNdOXMt7qrMicSy5x1AvWXt4FVi0SdbniOEIDsJfNK5fpOJRJwlbIKq
 7zBg==
X-Gm-Message-State: AOAM531XK3owkZastZkMsx7vNo+xyVEp7WVK/kUgCGJe2B8EpNYlfpRI
 HCqVhs+eBJMTU0/z7u1DVB+7VE3SOdXikirDKfU=
X-Google-Smtp-Source: ABdhPJxm+IsNkg58OMsEDrPLhV/W4RBQadPNbvN+WWdTs+udr+YKU/EOUIpFFlQYaGL5xhnyQqoVYccWkz6cz13lBpM=
X-Received: by 2002:a17:90b:30b:: with SMTP id
 ay11mr3969367pjb.75.1620721168012; 
 Tue, 11 May 2021 01:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210508064740.7705-1-Jiawei.Gu@amd.com>
 <CADnq5_PEogZDyFV_NOzbsajJQ_0A1+Jui-Mx7N_xsyWR5wXb8Q@mail.gmail.com>
 <CH0PR12MB5156FA453692B69100C3ADE7F8549@CH0PR12MB5156.namprd12.prod.outlook.com>
 <D7E9BE46-8E25-4A62-BE91-947898903A04@amd.com>
 <CH0PR12MB5156AF69D9E04020FDA5354AF8549@CH0PR12MB5156.namprd12.prod.outlook.com>
 <BYAPR12MB2840BA4077C73311A671CCBEF4549@BYAPR12MB2840.namprd12.prod.outlook.com>
 <bbf8cdf1-00a7-3e2a-74b0-71e85f1c7697@gmail.com>
 <447046CE-6FB4-49D7-A74A-2188654F5D5C@amd.com>
 <88e868eb-347b-611b-8d88-ba8d9d61c23b@gmail.com>
In-Reply-To: <88e868eb-347b-611b-8d88-ba8d9d61c23b@gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Tue, 11 May 2021 04:18:51 -0400
Message-ID: <CAAxE2A73V5PLVgrcd+_KYYbK=n+POZajdVYMcMdj8A38KvTerA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Kees Cook <keescook@chromium.org>, "Gu,
 JiaWei \(Will\)" <JiaWei.Gu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deng,
 Emily" <Emily.Deng@amd.com>, Alex Deucher <alexdeucher@gmail.com>, "Nieto,
 David M" <David.Nieto@amd.com>
Content-Type: multipart/mixed; boundary="===============0337145535=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0337145535==
Content-Type: multipart/alternative; boundary="0000000000007fdb3205c2098d6f"

--0000000000007fdb3205c2098d6f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mesa doesn't use sysfs.

Note that this is a uapi, meaning that once it's in the kernel, it can't be
changed like that.

What's the use case for this new interface? Isn't it partially redundant
with the current device info structure, which seems to have the equivalent
of dev_id and rev_id?

Marek

On Tue, May 11, 2021 at 3:51 AM Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com> wrote:

> Marek and other userspace folks need to decide that.
>
> Basic question here is if Mesa is already accessing sysfs nodes for OpenG=
L
> or RADV. If that is the case then we should probably expose the informati=
on
> there as well.
>
> If that isn't the case (which I think it is) then we should implement it
> as IOCTL.
>
> Regards,
> Christian.
>
> Am 10.05.21 um 22:19 schrieb Nieto, David M:
>
> One of the primary usecases is to add this information to the renderer
> string, I am not sure if there are other cases of UMD drivers accessing
> sysfs nodes, but I think if we think permissions, if a client is
> authenticated and opens the render device then it can use the IOCTL, it i=
s
> unclear to me we can make a such an assumption for sysfs nodes=E2=80=A6
>
>
>
> I think there is value in having both tbh.
>
>
>
> Regards,
>
> David
>
>
>
> *From: *Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
> <ckoenig.leichtzumerken@gmail.com>
> *Date: *Monday, May 10, 2021 at 6:48 AM
> *To: *"Nieto, David M" <David.Nieto@amd.com> <David.Nieto@amd.com>, "Gu,
> JiaWei (Will)" <JiaWei.Gu@amd.com> <JiaWei.Gu@amd.com>
> *Cc: *Alex Deucher <alexdeucher@gmail.com> <alexdeucher@gmail.com>,
> "Deng, Emily" <Emily.Deng@amd.com> <Emily.Deng@amd.com>, Kees Cook
> <keescook@chromium.org> <keescook@chromium.org>, amd-gfx list
> <amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.org>
> *Subject: *Re: [PATCH] drm/amdgpu: Align serial size in
> drm_amdgpu_info_vbios
>
>
>
> Well we could add both as sysfs file(s).
>
> Question here is rather what is the primary use case of this and if the
> application has the necessary access permissions to the sysfs files?
>
> Regards,
> Christian.
>
> Am 10.05.21 um 15:42 schrieb Nieto, David M:
>
> Then the application would need to issue the ioctl and then open a sysfs
> file to get all the information it needs. It makes little sense from a
> programming perspective to add an incomplete interface in my opinion
>
>
> ------------------------------
>
> *From:* Gu, JiaWei (Will) <JiaWei.Gu@amd.com> <JiaWei.Gu@amd.com>
> *Sent:* Monday, May 10, 2021 12:13:07 AM
> *To:* Nieto, David M <David.Nieto@amd.com> <David.Nieto@amd.com>
> *Cc:* Alex Deucher <alexdeucher@gmail.com> <alexdeucher@gmail.com>;
> amd-gfx list <amd-gfx@lists.freedesktop.org>
> <amd-gfx@lists.freedesktop.org>; Kees Cook <keescook@chromium.org>
> <keescook@chromium.org>; Deng, Emily <Emily.Deng@amd.com>
> <Emily.Deng@amd.com>
> *Subject:* RE: [PATCH] drm/amdgpu: Align serial size in
> drm_amdgpu_info_vbios
>
>
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi David,
>
> What I meant is to ONLY delete the serial[16] from drm_amdgpu_info_vbios,
> not the whole struct.
>
> struct drm_amdgpu_info_vbios {
>         __u8 name[64];
>         __u32 dbdf;
>         __u8 vbios_pn[64];
>         __u32 version;
>         __u8 date[32];
>         __u8 serial[16]; // jiawei: shall we delete this
>         __u32 dev_id;
>         __u32 rev_id;
>         __u32 sub_dev_id;
>         __u32 sub_ved_id;
> };
>
> serial[16] in drm_amdgpu_info_vbios  copied from adev->serial, but there'=
s
> already a sysfs named serial_number, which exposes it already.
>
> static ssize_t amdgpu_device_get_serial_number(struct device *dev,
>                 struct device_attribute *attr, char *buf)
> {
>         struct drm_device *ddev =3D dev_get_drvdata(dev);
>         struct amdgpu_device *adev =3D ddev->dev_private;
>
>         return snprintf(buf, PAGE_SIZE, "%s\n", adev->serial);
> }
>
> Thanks,
> Jiawei
>
>
> -----Original Message-----
> From: Nieto, David M <David.Nieto@amd.com> <David.Nieto@amd.com>
> Sent: Monday, May 10, 2021 2:53 PM
> To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com> <JiaWei.Gu@amd.com>
> Cc: Alex Deucher <alexdeucher@gmail.com> <alexdeucher@gmail.com>; amd-gfx
> list <amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.org>;
> Kees Cook <keescook@chromium.org> <keescook@chromium.org>; Deng, Emily
> <Emily.Deng@amd.com> <Emily.Deng@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbi=
os
>
> No, this structure contains all the details of the vbios: date, serial
> number, name, etc.
>
> The sysfs node only contains the vbios name string
>
> > On May 9, 2021, at 23:33, Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
> <JiaWei.Gu@amd.com> wrote:
> >
> > [AMD Official Use Only - Internal Distribution Only]
> >
> > With a second thought,
> > __u8 serial[16] in drm_amdgpu_info_vbios is a bit redundant, sysfs
> serial_number already exposes it.
> >
> > Is it fine to abandon it from drm_amdgpu_info_vbios struct? @Alex
> > Deucher @Nieto, David M
> >
> > Best regards,
> > Jiawei
> >
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com> <alexdeucher@gmail.com>
> > Sent: Sunday, May 9, 2021 11:59 PM
> > To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com> <JiaWei.Gu@amd.com>
> > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> <amd-gfx@lists.freedesktop.org>; Kees Cook
> > <keescook@chromium.org> <keescook@chromium.org>
> > Subject: Re: [PATCH] drm/amdgpu: Align serial size in
> > drm_amdgpu_info_vbios
> >
> >> On Sat, May 8, 2021 at 2:48 AM Jiawei Gu <Jiawei.Gu@amd.com>
> <Jiawei.Gu@amd.com> wrote:
> >>
> >> 20 should be serial char size now instead of 16.
> >>
> >> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com> <Jiawei.Gu@amd.com>
> >
> > Please make sure this keeps proper 64 bit alignment in the structure.
> >
> > Alex
> >
> >
> >> ---
> >> include/uapi/drm/amdgpu_drm.h | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/include/uapi/drm/amdgpu_drm.h
> >> b/include/uapi/drm/amdgpu_drm.h index 2b487a8d2727..1c20721f90da
> >> 100644
> >> --- a/include/uapi/drm/amdgpu_drm.h
> >> +++ b/include/uapi/drm/amdgpu_drm.h
> >> @@ -957,7 +957,7 @@ struct drm_amdgpu_info_vbios {
> >>        __u8 vbios_pn[64];
> >>        __u32 version;
> >>        __u8 date[32];
> >> -       __u8 serial[16];
> >> +       __u8 serial[20];
> >>        __u32 dev_id;
> >>        __u32 rev_id;
> >>        __u32 sub_dev_id;
> >> --
> >> 2.17.1
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx@lists.freedesktop.org
> >> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fli=
s
> >> t
> >> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7C=
J
> >> i
> >> awei.Gu%40amd.com%7Ccea31833184c41e8574508d9130360cc%7C3dd8961fe4884e
> >> 6
> >> 08e11a82d994e183d%7C0%7C0%7C637561727523880356%7CUnknown%7CTWFpbGZsb3
> >> d
> >> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> >> C
> >> 1000&amp;sdata=3DkAJiC6WoJUTeExwk6ftrLfMoY2OTAwg9X7mGgJT3kLk%3D&amp;re=
s
> >> e
> >> rved=3D0
>
>
>
> _______________________________________________
>
> amd-gfx mailing list
>
> amd-gfx@lists.freedesktop.org
>
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx <https://nam11.saf=
elinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2F=
mailman%2Flistinfo%2Famd-gfx&data=3D04%7C01%7CDavid.Nieto%40amd.com%7C3c007=
1a8a2a74127027408d913ba53e4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63=
7562513264718308%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz=
IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3Dg11aunC78b48N19Q%2FFXJBK%2B=
2Z0PZBWdqp%2FzhsPiqQ8Q%3D&reserved=3D0>
>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--0000000000007fdb3205c2098d6f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Mesa doesn&#39;t use sysfs.</div><div><br></div><div>=
Note that this is a uapi, meaning that once it&#39;s in the kernel, it can&=
#39;t be changed like that.<br></div><div><br></div><div>What&#39;s the use=
 case for this new interface? Isn&#39;t it partially redundant with the cur=
rent device info structure, which seems to have the equivalent of dev_id an=
d rev_id?<br></div><div><br></div><div>Marek<br></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 11, 2021=
 at 3:51 AM Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerk=
en@gmail.com" target=3D"_blank">ckoenig.leichtzumerken@gmail.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
 =20
   =20
 =20
  <div>
    Marek and other userspace folks need to decide that.<br>
    <br>
    Basic question here is if Mesa is already accessing sysfs nodes for
    OpenGL or RADV. If that is the case then we should probably expose
    the information there as well.<br>
    <br>
    If that isn&#39;t the case (which I think it is) then we should
    implement it as IOCTL.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div>Am 10.05.21 um 22:19 schrieb Nieto,
      David M:<br>
    </div>
    <blockquote type=3D"cite">
     =20
     =20
     =20
     =20
      <div>
        <p class=3D"MsoNormal">One of the primary usecases is to add this
          information to the renderer string, I am not sure if there are
          other cases of UMD drivers accessing sysfs nodes, but I think
          if we think permissions, if a client is authenticated and
          opens the render device then it can use the IOCTL, it is
          unclear to me we can make a such an assumption for sysfs
          nodes=E2=80=A6<u></u><u></u></p>
        <p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
        <p class=3D"MsoNormal">I think there is value in having both tbh.<u=
></u><u></u></p>
        <p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
        <p class=3D"MsoNormal">Regards,<u></u><u></u></p>
        <p class=3D"MsoNormal">David<u></u><u></u></p>
        <p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
        <div style=3D"border-color:rgb(181,196,223) currentcolor currentcol=
or;border-style:solid none none;border-width:1pt medium medium;padding:3pt =
0in 0in">
          <p class=3D"MsoNormal"><b><span style=3D"font-size:12pt;color:bla=
ck">From: </span></b><span style=3D"font-size:12pt;color:black">Christian K=
=C3=B6nig
              <a href=3D"mailto:ckoenig.leichtzumerken@gmail.com" target=3D=
"_blank">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
              <b>Date: </b>Monday, May 10, 2021 at 6:48 AM<br>
              <b>To: </b>&quot;Nieto, David M&quot; <a href=3D"mailto:David=
.Nieto@amd.com" target=3D"_blank">&lt;David.Nieto@amd.com&gt;</a>,
              &quot;Gu, JiaWei (Will)&quot; <a href=3D"mailto:JiaWei.Gu@amd=
.com" target=3D"_blank">&lt;JiaWei.Gu@amd.com&gt;</a><br>
              <b>Cc: </b>Alex Deucher <a href=3D"mailto:alexdeucher@gmail.c=
om" target=3D"_blank">&lt;alexdeucher@gmail.com&gt;</a>,
              &quot;Deng, Emily&quot; <a href=3D"mailto:Emily.Deng@amd.com"=
 target=3D"_blank">&lt;Emily.Deng@amd.com&gt;</a>, Kees Cook
              <a href=3D"mailto:keescook@chromium.org" target=3D"_blank">&l=
t;keescook@chromium.org&gt;</a>, amd-gfx list
              <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_b=
lank">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
              <b>Subject: </b>Re: [PATCH] drm/amdgpu: Align serial size
              in drm_amdgpu_info_vbios<u></u><u></u></span></p>
        </div>
        <div>
          <p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
        </div>
        <p class=3D"MsoNormal" style=3D"margin-bottom:12pt">Well we could
          add both as sysfs file(s).<br>
          <br>
          Question here is rather what is the primary use case of this
          and if the application has the necessary access permissions to
          the sysfs files?<br>
          <br>
          Regards,<br>
          Christian.<u></u><u></u></p>
        <div>
          <p class=3D"MsoNormal">Am 10.05.21 um 15:42 schrieb Nieto, David
            M:<u></u><u></u></p>
        </div>
        <blockquote style=3D"margin-top:5pt;margin-bottom:5pt">
          <div>
            <div>
              <div>
                <p class=3D"MsoNormal" style=3D"background:white none repea=
t scroll 0% 0%"><span style=3D"color:black">Then the application would need
                    to issue the ioctl and then open a sysfs file to get
                    all the information it needs. It makes little sense
                    from a programming perspective to add an incomplete
                    interface in my opinion=C2=A0<u></u><u></u></span></p>
              </div>
            </div>
            <div>
              <p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
            </div>
          </div>
          <div class=3D"MsoNormal" style=3D"text-align:center" align=3D"cen=
ter">
            <hr width=3D"100%" size=3D"0" align=3D"center">
          </div>
          <div id=3D"gmail-m_782079725653541167gmail-m_3184748164637597930g=
mail-m_-3452308432024396062divRplyFwdMsg">
            <p class=3D"MsoNormal"><b><span style=3D"color:black">From:</sp=
an></b><span style=3D"color:black"> Gu, JiaWei (Will)
                <a href=3D"mailto:JiaWei.Gu@amd.com" target=3D"_blank">&lt;=
JiaWei.Gu@amd.com&gt;</a><br>
                <b>Sent:</b> Monday, May 10, 2021 12:13:07 AM<br>
                <b>To:</b> Nieto, David M <a href=3D"mailto:David.Nieto@amd=
.com" target=3D"_blank">&lt;David.Nieto@amd.com&gt;</a><br>
                <b>Cc:</b> Alex Deucher <a href=3D"mailto:alexdeucher@gmail=
.com" target=3D"_blank">&lt;alexdeucher@gmail.com&gt;</a>;
                amd-gfx list
                <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"=
_blank">&lt;amd-gfx@lists.freedesktop.org&gt;</a>;
                Kees Cook
                <a href=3D"mailto:keescook@chromium.org" target=3D"_blank">=
&lt;keescook@chromium.org&gt;</a>;
                Deng, Emily <a href=3D"mailto:Emily.Deng@amd.com" target=3D=
"_blank">
                  &lt;Emily.Deng@amd.com&gt;</a><br>
                <b>Subject:</b> RE: [PATCH] drm/amdgpu: Align serial
                size in drm_amdgpu_info_vbios</span>
              <u></u><u></u></p>
            <div>
              <p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
            </div>
          </div>
          <div>
            <div>
              <p class=3D"MsoNormal">[AMD Official Use Only - Internal
                Distribution Only]<br>
                <br>
                Hi David,<br>
                <br>
                What I meant is to ONLY delete the serial[16] from
                drm_amdgpu_info_vbios, not the whole struct.<br>
                <br>
                struct drm_amdgpu_info_vbios {<br>
                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8 name[64];<b=
r>
                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 dbdf;<br>
                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8 vbios_pn[64=
];<br>
                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 version;<b=
r>
                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8 date[32];<b=
r>
                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8 serial[16];=
 // jiawei: shall we delete this<br>
                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 dev_id;<br=
>
                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 rev_id;<br=
>
                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 sub_dev_id=
;<br>
                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 sub_ved_id=
;<br>
                };<br>
                <br>
                serial[16] in drm_amdgpu_info_vbios=C2=A0 copied from
                adev-&gt;serial, but there&#39;s already a sysfs named
                serial_number, which exposes it already.<br>
                <br>
                static ssize_t amdgpu_device_get_serial_number(struct
                device *dev,<br>
                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_attribute *attr, char
                *buf)<br>
                {<br>
                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_devic=
e *ddev =3D dev_get_drvdata(dev);<br>
                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_de=
vice *adev =3D
                ddev-&gt;dev_private;<br>
                <br>
                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return snprintf(=
buf, PAGE_SIZE, &quot;%s\n&quot;,
                adev-&gt;serial);<br>
                }<br>
                <br>
                Thanks,<br>
                Jiawei<br>
                <br>
                <br>
                -----Original Message-----<br>
                From: Nieto, David M <a href=3D"mailto:David.Nieto@amd.com"=
 target=3D"_blank">&lt;David.Nieto@amd.com&gt;</a>
                <br>
                Sent: Monday, May 10, 2021 2:53 PM<br>
                To: Gu, JiaWei (Will) <a href=3D"mailto:JiaWei.Gu@amd.com" =
target=3D"_blank">&lt;JiaWei.Gu@amd.com&gt;</a><br>
                Cc: Alex Deucher <a href=3D"mailto:alexdeucher@gmail.com" t=
arget=3D"_blank">&lt;alexdeucher@gmail.com&gt;</a>;
                amd-gfx list
                <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"=
_blank">&lt;amd-gfx@lists.freedesktop.org&gt;</a>;
                Kees Cook
                <a href=3D"mailto:keescook@chromium.org" target=3D"_blank">=
&lt;keescook@chromium.org&gt;</a>;
                Deng, Emily <a href=3D"mailto:Emily.Deng@amd.com" target=3D=
"_blank">
                  &lt;Emily.Deng@amd.com&gt;</a><br>
                Subject: Re: [PATCH] drm/amdgpu: Align serial size in
                drm_amdgpu_info_vbios<br>
                <br>
                No, this structure contains all the details of the
                vbios: date, serial number, name, etc.<br>
                <br>
                The sysfs node only contains the vbios name string<br>
                <br>
                &gt; On May 9, 2021, at 23:33, Gu, JiaWei (Will) <a href=3D=
"mailto:JiaWei.Gu@amd.com" target=3D"_blank">
                  &lt;JiaWei.Gu@amd.com&gt;</a> wrote:<br>
                &gt; <br>
                &gt; [AMD Official Use Only - Internal Distribution
                Only]<br>
                &gt; <br>
                &gt; With a second thought,<br>
                &gt; __u8 serial[16] in drm_amdgpu_info_vbios is a bit
                redundant, sysfs serial_number already exposes it.<br>
                &gt; <br>
                &gt; Is it fine to abandon it from drm_amdgpu_info_vbios
                struct? @Alex <br>
                &gt; Deucher @Nieto, David M<br>
                &gt; <br>
                &gt; Best regards,<br>
                &gt; Jiawei<br>
                &gt; <br>
                &gt; -----Original Message-----<br>
                &gt; From: Alex Deucher <a href=3D"mailto:alexdeucher@gmail=
.com" target=3D"_blank">&lt;alexdeucher@gmail.com&gt;</a><br>
                &gt; Sent: Sunday, May 9, 2021 11:59 PM<br>
                &gt; To: Gu, JiaWei (Will) <a href=3D"mailto:JiaWei.Gu@amd.=
com" target=3D"_blank">&lt;JiaWei.Gu@amd.com&gt;</a><br>
                &gt; Cc: amd-gfx list <a href=3D"mailto:amd-gfx@lists.freed=
esktop.org" target=3D"_blank">&lt;amd-gfx@lists.freedesktop.org&gt;</a>;
                Kees Cook
                <br>
                &gt; <a href=3D"mailto:keescook@chromium.org" target=3D"_bl=
ank">&lt;keescook@chromium.org&gt;</a><br>
                &gt; Subject: Re: [PATCH] drm/amdgpu: Align serial size
                in <br>
                &gt; drm_amdgpu_info_vbios<br>
                &gt; <br>
                &gt;&gt; On Sat, May 8, 2021 at 2:48 AM Jiawei Gu <a href=
=3D"mailto:Jiawei.Gu@amd.com" target=3D"_blank">&lt;Jiawei.Gu@amd.com&gt;</=
a>
                wrote:<br>
                &gt;&gt; <br>
                &gt;&gt; 20 should be serial char size now instead of
                16.<br>
                &gt;&gt; <br>
                &gt;&gt; Signed-off-by: Jiawei Gu <a href=3D"mailto:Jiawei.=
Gu@amd.com" target=3D"_blank">&lt;Jiawei.Gu@amd.com&gt;</a><br>
                &gt; <br>
                &gt; Please make sure this keeps proper 64 bit alignment
                in the structure.<br>
                &gt; <br>
                &gt; Alex<br>
                &gt; <br>
                &gt; <br>
                &gt;&gt; ---<br>
                &gt;&gt; include/uapi/drm/amdgpu_drm.h | 2 +-<br>
                &gt;&gt; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
                &gt;&gt; <br>
                &gt;&gt; diff --git a/include/uapi/drm/amdgpu_drm.h <br>
                &gt;&gt; b/include/uapi/drm/amdgpu_drm.h index
                2b487a8d2727..1c20721f90da<br>
                &gt;&gt; 100644<br>
                &gt;&gt; --- a/include/uapi/drm/amdgpu_drm.h<br>
                &gt;&gt; +++ b/include/uapi/drm/amdgpu_drm.h<br>
                &gt;&gt; @@ -957,7 +957,7 @@ struct
                drm_amdgpu_info_vbios {<br>
                &gt;&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8 vbi=
os_pn[64];<br>
                &gt;&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 ve=
rsion;<br>
                &gt;&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8 dat=
e[32];<br>
                &gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8 serial[=
16];<br>
                &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8 serial[=
20];<br>
                &gt;&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 de=
v_id;<br>
                &gt;&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 re=
v_id;<br>
                &gt;&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 su=
b_dev_id;<br>
                &gt;&gt; --<br>
                &gt;&gt; 2.17.1<br>
                &gt;&gt; <br>
                &gt;&gt; _______________________________________________<br=
>
                &gt;&gt; amd-gfx mailing list<br>
                &gt;&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org" t=
arget=3D"_blank">amd-gfx@lists.freedesktop.org</a><br>
                &gt;&gt; <a href=3D"https://nam11.safelinks.protection.outl=
ook.com/?url=3Dhttps%3A%2F%2Flis" target=3D"_blank">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis</a>=
<br>
                &gt;&gt; t <br>
                &gt;&gt;
<a href=3D"http://s.freedesktop.org" target=3D"_blank">s.freedesktop.org</a=
>%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C01%7CJ<br>
                &gt;&gt; i<br>
                &gt;&gt;
                awei.Gu%<a href=3D"http://40amd.com" target=3D"_blank">40am=
d.com</a>%7Ccea31833184c41e8574508d9130360cc%7C3dd8961fe4884e<br>
                &gt;&gt; 6 <br>
                &gt;&gt;
                08e11a82d994e183d%7C0%7C0%7C637561727523880356%7CUnknown%7C=
TWFpbGZsb3<br>
                &gt;&gt; d <br>
                &gt;&gt;
                8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC=
I6Mn0%3D%7<br>
                &gt;&gt; C <br>
                &gt;&gt;
1000&amp;amp;sdata=3DkAJiC6WoJUTeExwk6ftrLfMoY2OTAwg9X7mGgJT3kLk%3D&amp;amp=
;res<br>
                &gt;&gt; e<br>
                &gt;&gt; rved=3D0<u></u><u></u></p>
            </div>
          </div>
          <p class=3D"MsoNormal"><br>
            <br>
            <u></u><u></u></p>
          <pre>_______________________________________________<u></u><u></u=
></pre>
          <pre>amd-gfx mailing list<u></u><u></u></pre>
          <pre><a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_=
blank">amd-gfx@lists.freedesktop.org</a><u></u><u></u></pre>
          <pre><a href=3D"https://nam11.safelinks.protection.outlook.com/?u=
rl=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp=
;data=3D04%7C01%7CDavid.Nieto%40amd.com%7C3c0071a8a2a74127027408d913ba53e4%=
7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637562513264718308%7CUnknown%7=
CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn=
0%3D%7C1000&amp;sdata=3Dg11aunC78b48N19Q%2FFXJBK%2B2Z0PZBWdqp%2FzhsPiqQ8Q%3=
D&amp;reserved=3D0" target=3D"_blank">https://lists.freedesktop.org/mailman=
/listinfo/amd-gfx</a><u></u><u></u></pre>
        </blockquote>
        <p class=3D"MsoNormal"><br>
          <br>
          <u></u><u></u></p>
      </div>
    </blockquote>
    <br>
  </div>

_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>

--0000000000007fdb3205c2098d6f--

--===============0337145535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0337145535==--
