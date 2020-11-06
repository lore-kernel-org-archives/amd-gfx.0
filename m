Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C356AC55179
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 11:33:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CC8620728
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 11:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKGEV0yb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC8620728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A4046E847;
	Fri,  6 Nov 2020 11:33:49 +0000 (UTC)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC08A6E847
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 11:33:48 +0000 (UTC)
Received: by mail-ua1-x934.google.com with SMTP id r23so294394uak.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Nov 2020 03:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RwV5+1I9+aGYAhq0GkYYfjOth+qzMYBFn/JvKwkoIBo=;
 b=tKGEV0ybX8vk8Qqfrxn+A1+0XrSbWLF/1gf6XBePvNY0tZmpu6ZJQlLPMEezAEb/bN
 7EEoBmuSX94kFiVVf9vMKuHLhydrDvoZO/n9iEoa/h0Eo6zrgHDkOSRitosU7wwcWqaF
 +2l4TFXsZTNLP75TiwoSInbo/ejY85VOK2EfBt9w4XREhVHYJLY7GGqJJuFW7uwvYBMr
 3JFg7mqEyauStu3hws6sjf8cijTLyG6F40BVYTXzn9c2fD/Hj/Dteal7pV9U0nrnC3++
 dYAokJOPqp/mc0eROxrmyfZ6yhfnXOq7upKpF/JXqIcFbytJOJQuvB/xR1cix4C7oPGv
 IseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RwV5+1I9+aGYAhq0GkYYfjOth+qzMYBFn/JvKwkoIBo=;
 b=A5v8JC6SII/+SvJVdld5O6J6jVtLenP+EjawPh357q/l++QxbAgKkj1/iffXHwdHDa
 J8/ktyGO5iXYmVNG1QnOGnUZOM21KSshyf6/PWwl3iEEasqwRw90sGOeXDbLywRXJiDJ
 2WWx0EvzdzK9rm/Mcc77IX62jJRDEIyMWySlYg1TtOfB0Ouj4g9tXlLJ8Q9LmlzXQ6Fc
 K2pHvq3X8w6SVKOZ05A69pvA6s2XQPPiibl6MzqHzoY/Ql4uYwf0e/MrKSBHvPBi1NsP
 nk2Nq8+rAz2cAtHyQtBwwJJklOw6pC9wtAR4TMGaHy1W+w0MrdxD8ux5c3C0sSfEImD1
 UTZw==
X-Gm-Message-State: AOAM530cL/n2/tSMKrCqqpH4Stei1q7nHSJWhjfXdTPtQILrGiZ0dtNY
 Sv2gUYD6gw/4RrXfqxFr937Q2opR8iUDakkMMeQ=
X-Google-Smtp-Source: ABdhPJw7i4zanI38Zx5KyJpECvnCAqZl77m+Dee6je4mZNqO9Zq1rXse4D9asBAu+QRPDlzi5tLWel7/q5op6MoS8Qk=
X-Received: by 2002:ab0:4d42:: with SMTP id k2mr532174uag.10.1604662428025;
 Fri, 06 Nov 2020 03:33:48 -0800 (PST)
MIME-Version: 1.0
References: <f843846.2b92.1755368c82e.Coremail.raykwok1150@163.com>
 <DM6PR12MB2619D9C7A99E30FA46363C5AE4160@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619D9C7A99E30FA46363C5AE4160@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Tom St Denis <tstdenis82@gmail.com>
Date: Fri, 6 Nov 2020 06:33:36 -0500
Message-ID: <CAAzXoRJKZL1FDejksMFkCpHDsOKFL31T-fJY9E=Xc8rf3GOypQ@mail.gmail.com>
Subject: Re: [PATCH] Fix bug to get average GPU power
To: "Quan, Evan" <Evan.Quan@amd.com>
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Lei Guo <raykwok1150@163.com>
Content-Type: multipart/mixed; boundary="===============1146830639=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1146830639==
Content-Type: multipart/alternative; boundary="00000000000001c70405b36e96a7"

--00000000000001c70405b36e96a7
Content-Type: text/plain; charset="UTF-8"

For whatever reason when I download this message and try to add it with
"git am" it says the patch is empty.

Can you attach the patch as an attachment please?

Thanks,
Tom

On Mon, Oct 26, 2020 at 11:29 PM Quan, Evan <Evan.Quan@amd.com> wrote:

> [AMD Official Use Only - Internal Distribution Only]
>
> Reviewed-by: Evan Quan <evan.quan@amd.com>
>
>
>
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of *Lei
> Guo
> *Sent:* Friday, October 23, 2020 11:03 AM
> *To:* amd-gfx@lists.freedesktop.org
> *Subject:* [PATCH] Fix bug to get average GPU power
>
>
>
> From 0277318fc1799d17878d9f407254773fc2bb964c Mon Sep 17 00:00:00 2001
>
> From: Guo Lei <raykwok1150@163.com>
>
> Date: Fri, 16 Oct 2020 17:03:44 +0800
>
> Subject: [PATCH] Fix bug to get average GPU power
>
>
>
> Synchronize emu amd_pp_sensors with kgd_pp_interface.h
>
>
>
> Signed-off-by: Guo Lei <raykwok1150@163.com>
>
> Change-Id: I531fa006ecdd1d42e589bbfe79a7d6699ae5b2b6
>
> ---
>
>  src/umr.h | 3 +++
>
>  1 file changed, 3 insertions(+)
>
>
>
> diff --git a/src/umr.h b/src/umr.h
>
> index c928fad..8c45f12 100644
>
> --- a/src/umr.h
>
> +++ b/src/umr.h
>
> @@ -79,6 +79,9 @@ enum amd_pp_sensors {
>
>           AMDGPU_PP_SENSOR_MEM_LOAD,
>
>           AMDGPU_PP_SENSOR_GFX_MCLK,
>
>           AMDGPU_PP_SENSOR_GPU_TEMP,
>
> +        AMDGPU_PP_SENSOR_EDGE_TEMP = AMDGPU_PP_SENSOR_GPU_TEMP,
>
> +        AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
>
> +        AMDGPU_PP_SENSOR_MEM_TEMP,
>
>           AMDGPU_PP_SENSOR_VCE_POWER,
>
>           AMDGPU_PP_SENSOR_UVD_POWER,
>
>           AMDGPU_PP_SENSOR_GPU_POWER,
>
> --
>
> 2.17.1
>
>
>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--00000000000001c70405b36e96a7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">For whatever reason when I download this message and try t=
o add it with &quot;git am&quot; it says the patch is empty.<br><br>Can you=
 attach the patch as an attachment please?<div><br></div><div>Thanks,</div>=
<div>Tom</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Mon, Oct 26, 2020 at 11:29 PM Quan, Evan &lt;<a href=3D"=
mailto:Evan.Quan@amd.com">Evan.Quan@amd.com</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">





<div lang=3D"EN-US" style=3D"overflow-wrap: break-word;">
<p style=3D"font-family:Arial;font-size:11pt;color:rgb(0,120,215);margin:5p=
t" align=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif">Reviewed-by: Evan Quan &lt;<a href=3D"mailto:evan.quan@amd.com" t=
arget=3D"_blank">evan.quan@amd.com</a>&gt;<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif"><u></u>=C2=A0<u></u></span></p>
<div style=3D"border-top:none;border-right:none;border-bottom:none;border-l=
eft:1.5pt solid blue;padding:0in 0in 0in 4pt">
<div>
<div style=3D"border-right:none;border-bottom:none;border-left:none;border-=
top:1pt solid rgb(225,225,225);padding:3pt 0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11pt;font-family:Calibri=
,sans-serif">From:</span></b><span style=3D"font-size:11pt;font-family:Cali=
bri,sans-serif"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freede=
sktop.org" target=3D"_blank">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
<b>On Behalf Of </b>Lei Guo<br>
<b>Sent:</b> Friday, October 23, 2020 11:03 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blan=
k">amd-gfx@lists.freedesktop.org</a><br>
<b>Subject:</b> [PATCH] Fix bug to get average GPU power<u></u><u></u></spa=
n></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black">From 0277318fc1799d17878d9f407254773fc2bb964c Mon Se=
p 17 00:00:00 2001<u></u><u></u></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black">From: Guo Lei &lt;<a href=3D"mailto:raykwok1150@163.=
com" target=3D"_blank">raykwok1150@163.com</a>&gt;<u></u><u></u></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black">Date: Fri, 16 Oct 2020 17:03:44 +0800<u></u><u></u><=
/span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black">Subject: [PATCH] Fix bug to get average GPU power<u>=
</u><u></u></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black"><u></u>=C2=A0<u></u></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black">Synchronize emu amd_pp_sensors with kgd_pp_interface=
.h<u></u><u></u></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black"><u></u>=C2=A0<u></u></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black">Signed-off-by: Guo Lei &lt;<a href=3D"mailto:raykwok=
1150@163.com" target=3D"_blank">raykwok1150@163.com</a>&gt;<u></u><u></u></=
span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black">Change-Id: I531fa006ecdd1d42e589bbfe79a7d6699ae5b2b6=
<u></u><u></u></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black">---<u></u><u></u></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black">=C2=A0src/umr.h | 3 +++<u></u><u></u></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black">=C2=A01 file changed, 3 insertions(+)<u></u><u></u><=
/span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black"><u></u>=C2=A0<u></u></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black">diff --git a/src/umr.h b/src/umr.h<u></u><u></u></sp=
an></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black">index c928fad..8c45f12 100644<u></u><u></u></span></=
p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black">--- a/src/umr.h<u></u><u></u></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black">+++ b/src/umr.h<u></u><u></u></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black">@@ -79,6 +79,9 @@ enum amd_pp_sensors {<u></u><u></u=
></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 AMDGPU_PP_SENSOR_MEM_LOAD,<u></u><u></u></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 AMDGPU_PP_SENSOR_GFX_MCLK,<u></u><u></u></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 AMDGPU_PP_SENSOR_GPU_TEMP,<u></u><u></u></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black">+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AMDGPU_P=
P_SENSOR_EDGE_TEMP =3D AMDGPU_PP_SENSOR_GPU_TEMP,<u></u><u></u></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black">+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AMDGPU_P=
P_SENSOR_HOTSPOT_TEMP,<u></u><u></u></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black">+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AMDGPU_P=
P_SENSOR_MEM_TEMP,<u></u><u></u></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 AMDGPU_PP_SENSOR_VCE_POWER,<u></u><u></u></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 AMDGPU_PP_SENSOR_UVD_POWER,<u></u><u></u></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 AMDGPU_PP_SENSOR_GPU_POWER,<u></u><u></u></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black">--=C2=A0<u></u><u></u></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:Arial,s=
ans-serif;color:black">2.17.1<u></u><u></u></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:Arial,sa=
ns-serif;color:black"><u></u>=C2=A0<u></u></span></p>
</div>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt"><u></u>=C2=A0<u></u></p=
>
<p>=C2=A0<u></u><u></u></p>
</div>
</div>
</div>
</div>

_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>

--00000000000001c70405b36e96a7--

--===============1146830639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1146830639==--
