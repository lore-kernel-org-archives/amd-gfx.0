Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC87D2C552
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 13:38:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4A7989EAC;
	Tue, 22 Oct 2024 13:38:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kGSX1weV";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09F8510E19F
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 13:38:52 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2e2d83f15f3so757822a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 06:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729604331; x=1730209131; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D/6IAhCJfAQRIL8dZqGY70vY8Nad0yZmbMdXhOnuwjM=;
 b=kGSX1weVt3LSzKltLOXVh2iswOVOQojm8NGuvuUL+iHri9mNmDcyjwgQlXPNxdzRjy
 HZeD5Y9PC4d6RO82MRVXT3FzWwTxYmAnvNRGXFsXRtU9daW/vgkPsEi2ovFp/FD2Cf5p
 WAJlOtD6RhFS3fXN5f+6waViJnVQUFWcnAEXPIS4X4IsffvaM5t8WTxvg6Mx1dVD046B
 jTzh3czQ8VCZNQn0wU/V4M0ezgRJUIBGLBlBETs6FMNwb70K9C++pKf1h2ITKMVrSNMN
 T9WKWCsPoMjFxlpgVE1mCD3zh7W9MhNDVOCq3NhoUHWf4x59sweil165UBYALVBwirrk
 XxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729604331; x=1730209131;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D/6IAhCJfAQRIL8dZqGY70vY8Nad0yZmbMdXhOnuwjM=;
 b=TIKi0i3pLJUzcsGVfyhea0XYBRXqvs7T6jdWDIdVHz4wvJL/LNOE9Ebql0BTQ3fdQU
 SQFAK4p55WXej2m6m9zcqcYQdJexpRdv4IpLNepNyEpTVLRwiYGCEHsKaS9Asl4C+JI9
 pTojHXscU8FgFWL1Exz7SvXHb50wtSvhd3HSLpTNCOR83u13dIOek+t0dlG/hmGe2X5T
 VzbtSJGUL6l+TO1KDrCmcvBApyOQkmu97E60IJ02uFLc4yEJFFWwpidMVTn5ttwmjpca
 A4aCo6eyH1JPjwS+AOYaXpTRsGNpFDgdG/F+fu3gaJoXxDsYBsY8jrRI1fZFKRnghPbq
 YuFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULfDMp3PENwhpYtZtHInkgCRDVi8xtHfzsb+y4xhBg8+t9N3dsErgwEhJSoi0wo12b1tmOlawc@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyXjKYFUy5h4hJG5nSDuLthZdDb7iSP901I97w26kkG0UZf8Elx
 nIpz3avmhAywSfGXVJciQ0C9S4kOxUwJnf8WrmGbTNUj554J3EitPuyJCdW8TMCZBW7YUsva+7J
 hJ8ZQ/ohWvI16rsSfJZSBsVikm2k=
X-Google-Smtp-Source: AGHT+IHbwfhnlnFQq7H1hPiCZQzh0Hm5sPjnprh9DI2Fi8FwTfLJi3dTfmKMyaa2T5p3o6UJPEiQLHQHDATluqbLSQI=
X-Received: by 2002:a17:90b:a0f:b0:2e2:d1c0:758a with SMTP id
 98e67ed59e1d1-2e561a276admr7397473a91.8.1729604331518; Tue, 22 Oct 2024
 06:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <20241018192027.622300-1-alexander.deucher@amd.com>
 <BL1PR12MB514479BC04F9CE88390562A9F7432@BL1PR12MB5144.namprd12.prod.outlook.com>
 <DM4PR12MB516537577F16430D69C219BA8E4C2@DM4PR12MB5165.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB516537577F16430D69C219BA8E4C2@DM4PR12MB5165.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Oct 2024 09:38:39 -0400
Message-ID: <CADnq5_PJCOsM5+iCCdBf7iw=wwTLpjbEgBXcjsTXTH9MQi3GrQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: handle default profile on GC 9.4.1
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="000000000000c84200062510e3a1"
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

--000000000000c84200062510e3a1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please double check the COMPUTE profile set by KFD as well.

Thanks,

Alex

On Mon, Oct 21, 2024 at 9:18=E2=80=AFPM Feng, Kenneth <Kenneth.Feng@amd.com=
> wrote:

> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Alex,
>
> I have found another problem with the current code based on the default
> workload setting to 3D fullscreen.
>
> For example, the default workload is set to 3D fullscreen first, but in
> boot, it=E2=80=99s not applied yet.
>
> Then a vcn ring test comes in, sets the workload mask to vcn workload + 3=
D
> fullscreen. After the setting,
>
> Actually the workload mask is updated to vcn workload only. Then after th=
e
> vcn ring test, the workload doesn=E2=80=99t go
>
> to 3D fullscreen workload. It goes to bootup
> workload(PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT).
>
> Let me try to fix it by today and get back to you.
>
> For this patch itself, it=E2=80=99s ok.
>
> Reviewed-by: Kenneth Feng kenneth.feng@amd.com
>
>
>
>
>
>
>
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of *De=
ucher,
> Alexander
> *Sent:* Tuesday, October 22, 2024 4:35 AM
> *To:* amd-gfx@lists.freedesktop.org
> *Subject:* Re: [PATCH] drm/amdgpu: handle default profile on GC 9.4.1
>
>
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
>
> *Caution:* This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
>
> Ping?
> ------------------------------
>
> *From:* Deucher, Alexander <Alexander.Deucher@amd.com>
> *Sent:* Friday, October 18, 2024 3:20 PM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>
> *Subject:* [PATCH] drm/amdgpu: handle default profile on GC 9.4.1
>
>
>
> It does not support fullscreen 3D.
>
> Fixes: 336568de918e ("drm/amdgpu/swsmu: default to fullscreen 3D profile
> for dGPUs")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index accc96a03bd9..4b816c7e94fe 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1267,7 +1267,8 @@ static int smu_sw_init(struct amdgpu_ip_block
> *ip_block)
>          smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] =3D 5;
>          smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] =3D 6;
>
> -       if (smu->is_apu)
> +       if (smu->is_apu ||
> +           (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, =
1)))
>                  smu->workload_mask =3D 1 <<
> smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
>          else
>                  smu->workload_mask =3D 1 <<
> smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
> --
> 2.46.2
>

--000000000000c84200062510e3a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Please double check the COMPUTE profile set by KFD as=
 well.</div><div><br></div><div>Thanks,<br></div><div><br></div><div>Alex<b=
r></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Mon, Oct 21, 2024 at 9:18=E2=80=AFPM Feng, Kenneth &lt;<a href=3D"mail=
to:Kenneth.Feng@amd.com">Kenneth.Feng@amd.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex"><div class=3D"msg7546077300968=
544512">





<div lang=3D"EN-US" style=3D"overflow-wrap: break-word;">
<p style=3D"font-family:Calibri;font-size:10pt;color:rgb(0,0,255);margin:5p=
t;font-style:normal;font-weight:normal;text-decoration:none" align=3D"Left"=
>
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"m_7546077300968544512WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:&quot;Aria=
l&quot;,sans-serif">Hi Alex,<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:&quot;Aria=
l&quot;,sans-serif">I have found another problem with the current code base=
d on the default workload setting to 3D fullscreen.<u></u><u></u></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:&quot;Aria=
l&quot;,sans-serif">For example, the default workload is set to 3D fullscre=
en first, but in boot, it=E2=80=99s not applied yet.<u></u><u></u></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:&quot;Aria=
l&quot;,sans-serif">Then a vcn ring test comes in, sets the workload mask t=
o vcn workload + 3D fullscreen. After the setting,<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:&quot;Aria=
l&quot;,sans-serif">Actually the workload mask is updated to vcn workload o=
nly. Then after the vcn ring test, the workload doesn=E2=80=99t go<u></u><u=
></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:&quot;Aria=
l&quot;,sans-serif">to 3D fullscreen workload. It goes to bootup workload(P=
P_SMC_POWER_PROFILE_BOOTUP_DEFAULT).<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:&quot;Aria=
l&quot;,sans-serif">Let me try to fix it by today and get back to you.<u></=
u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:&quot;Aria=
l&quot;,sans-serif">For this patch itself, it=E2=80=99s ok.<u></u><u></u></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:&quot;Aria=
l&quot;,sans-serif">Reviewed-by: Kenneth Feng
<a href=3D"mailto:kenneth.feng@amd.com" target=3D"_blank">kenneth.feng@amd.=
com</a><u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:&quot;Aria=
l&quot;,sans-serif"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:&quot;Aria=
l&quot;,sans-serif"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:&quot;Aria=
l&quot;,sans-serif"><u></u>=C2=A0<u></u></span></p>
<div>
<div style=3D"border-width:1pt medium medium;border-style:solid none none;b=
order-color:rgb(225,225,225) currentcolor currentcolor;padding:3pt 0in 0in"=
>
<p class=3D"MsoNormal"><b><span style=3D"font-size:11pt;font-family:&quot;C=
alibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11pt;font=
-family:&quot;Calibri&quot;,sans-serif"> amd-gfx &lt;<a href=3D"mailto:amd-=
gfx-bounces@lists.freedesktop.org" target=3D"_blank">amd-gfx-bounces@lists.=
freedesktop.org</a>&gt;
<b>On Behalf Of </b>Deucher, Alexander<br>
<b>Sent:</b> Tuesday, October 22, 2024 4:35 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blan=
k">amd-gfx@lists.freedesktop.org</a><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: handle default profile on GC 9.4.1<=
u></u><u></u></span></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p style=3D"margin:5pt"><span style=3D"font-size:10pt;font-family:&quot;Cal=
ibri&quot;,sans-serif;color:blue">[AMD Official Use Only - AMD Internal Dis=
tribution Only]<u></u><u></u></span></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<table border=3D"0" cellspacing=3D"0" cellpadding=3D"0" align=3D"left" widt=
h=3D"100%" style=3D"width:100%">
<tbody>
<tr>
<td style=3D"background:rgb(255,185,0);padding:5pt 2pt"></td>
<td width=3D"100%" style=3D"width:100%;background:rgb(255,248,229);padding:=
5pt 4pt 5pt 12pt">
<div>
<p class=3D"MsoNormal">
<b><span style=3D"color:rgb(34,34,34)">Caution:</span></b><span style=3D"co=
lor:rgb(34,34,34)"> This message originated from an External Source. Use pr=
oper caution when opening attachments, clicking links, or responding.
<u></u><u></u></span></p>
</div>
</td>
</tr>
</tbody>
</table>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<p style=3D"margin:5pt"><span style=3D"font-size:10pt;font-family:&quot;Cal=
ibri&quot;,sans-serif;color:blue">[AMD Official Use Only - AMD Internal Dis=
tribution Only]<u></u><u></u></span></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Ping?<u></u><u></u></spa=
n></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"m_7546077300968544512divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11pt;font-family:&quot;C=
alibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-si=
ze:11pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Deucher, A=
lexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com" target=3D"_blank"=
>Alexander.Deucher@amd.com</a>&gt;<br>
<b>Sent:</b> Friday, October 18, 2024 3:20 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blan=
k">amd-gfx@lists.freedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.fr=
eedesktop.org" target=3D"_blank">amd-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om" target=3D"_blank">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: handle default profile on GC 9.4.1</spa=
n> <u></u>
<u></u></p>
<div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt"><span style=3D"font-siz=
e:11pt">It does not support fullscreen 3D.<br>
<br>
Fixes: 336568de918e (&quot;drm/amdgpu/swsmu: default to fullscreen 3D profi=
le for dGPUs&quot;)<br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com=
" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index accc96a03bd9..4b816c7e94fe 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -1267,7 +1267,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_blo=
ck)<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smu-&gt;workload_prority[P=
P_SMC_POWER_PROFILE_COMPUTE] =3D 5;<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smu-&gt;workload_prority[P=
P_SMC_POWER_PROFILE_CUSTOM] =3D 6;<br>
=C2=A0<br>
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (smu-&gt;is_apu)<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (smu-&gt;is_apu ||<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (amdgpu_ip_ve=
rsion(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 1)))<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 smu-&gt;workload_mask =3D 1 &lt;&lt; smu-&gt;workload=
_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 smu-&gt;workload_mask =3D 1 &lt;&lt; smu-&gt;workload=
_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];<br>
-- <br>
2.46.2<u></u><u></u></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>

</div></blockquote></div></div>

--000000000000c84200062510e3a1--
