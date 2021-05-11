Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B93C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 07:37:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 046FE61926
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 07:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046FE61926
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71D996E9DE;
	Tue, 11 May 2021 07:37:38 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F5C56E9DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 07:37:37 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id b21so8348116pft.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 00:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AO+wQkljj+IESOEKR/JsmJajzhZSlJwhfULAr0Fh6hc=;
 b=uL57zBekze3pPLjK5ZRPCmEy68OVQ87rAGNKW4+K9KXLaGF/MXNVc2r1VFR5EG8V2G
 8y6fIj/JsBVzz2ZvcA0wfY+y7onJz2kgSnhctV+kZH/4sSk3mt3/9n+itVycRgDLDwTK
 BmWaXHnFCxrlM6b2yAn+33wN9bPlUDM60MSsOmBFeWzZy7PceLUFURUpMKYZOhDbN1el
 tw1h3qDWUNDf7OF7lq/LBhtDwwx0sqEekc02SCa7DhbYOfxeD+yeYjYWgWsTAR9mxG1j
 xBHU6nQ61ZVrFS264KA0PFjfz0fwVhGroKUVVOBWAd/HO3A4JBGCb9N3se9NSd511URI
 1l0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AO+wQkljj+IESOEKR/JsmJajzhZSlJwhfULAr0Fh6hc=;
 b=Qtxg14cTh3/Ue/7VD7a5CEAAtQPjnKgpkhfT6Qx0b787EwCGTRElsK7jKzMrp5Q+l4
 bwH8r5Lyqt71hMohKQ+O5m2j1RMXIazAIRcmNn5xETc4Svo90+1yBF494seErZB5l62X
 ElhH8/k2iqDQmp5VQn4XuXe7JTR//C9yHmUED42n0+p5wuD+rtknfiIc582+x8cuOU1F
 L0+wq/XJp9WVxw7IBI8Cy/UoAEvbPda9+FwFzRB8bK19B1uwPC5FpY5lmwJ13RSe2ERX
 Q0dQn60KIfBNQnQvy6Z7W3G2dE4kId0eDZc8IgeaGPYjM/5Hs+T/IFLk9p7FdNu6rqMV
 yTIQ==
X-Gm-Message-State: AOAM532Yn+7XEgdsaI/5oSnK2kzdcz5Lz8ySdP3fg+/OdXCBHTBiDRM/
 3WbYPIUyFTxfGf71xpBnzDgY1g19gC/+fzTX1JN5+HZKbbs=
X-Google-Smtp-Source: ABdhPJy4g8jHAgiPSgp7CH27aYkqUFtnp/sLlFVpZLStuk19h894WbzpaHeQ42SQLMOLq8RPrOxpOYBl3y2iqn5sx0o=
X-Received: by 2002:a63:cf55:: with SMTP id b21mr30394888pgj.126.1620718656843; 
 Tue, 11 May 2021 00:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210511030342.19756-1-kenneth.feng@amd.com>
 <CH2PR12MB48909CB3D30954292658C080EA539@CH2PR12MB4890.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB48909CB3D30954292658C080EA539@CH2PR12MB4890.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Date: Tue, 11 May 2021 09:37:25 +0200
Message-ID: <CAD=4a=UY9C=NUHjaze04ZPHQ5LyE0BCQuxXy+1B1f80un-JNhw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: enable ASPM by default
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0634442768=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0634442768==
Content-Type: multipart/alternative; boundary="000000000000d2757e05c208f71c"

--000000000000d2757e05c208f71c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You could even write why it was disabled before and why you can enable it
now again in the commit message.

Regards
//Ernst

Den tis 11 maj 2021 kl 09:25 skrev Chen, Jiansong (Simon) <
Jiansong.Chen@amd.com>:

> [AMD Official Use Only - Internal Distribution Only]
>
> Better to make the commit msg more specific, eg. Change predicate
> accordingly since aspm is enabled by default.
> Either way,  Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>
>
> Regards,
> Jiansong
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Kenneth Feng
> Sent: Tuesday, May 11, 2021 11:04 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
> Subject: [PATCH] drm/amd/pm: enable ASPM by default
>
> enable ASPM by default
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c                         | 2 +-
>  drivers/gpu/drm/amd/amdgpu/soc15.c                      | 2 +-
>  drivers/gpu/drm/amd/amdgpu/vi.c                         | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
> b/drivers/gpu/drm/amd/amdgpu/nv.c index 82a380be8368..2fcfd893edc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -598,7 +598,7 @@ static void nv_pcie_gen3_enable(struct amdgpu_device
> *adev)
>
>  static void nv_program_aspm(struct amdgpu_device *adev)  {
> -       if (amdgpu_aspm !=3D 1)
> +       if (!amdgpu_aspm)
>                 return;
>
>         if (!(adev->flags & AMD_IS_APU) &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 49ece2a7f9f0..4b660b2d1c22 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -817,7 +817,7 @@ static void soc15_pcie_gen3_enable(struct
> amdgpu_device *adev)
>
>  static void soc15_program_aspm(struct amdgpu_device *adev)  {
> -       if (amdgpu_aspm !=3D 1)
> +       if (!amdgpu_aspm)
>                 return;
>
>         if (!(adev->flags & AMD_IS_APU) &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c
> b/drivers/gpu/drm/amd/amdgpu/vi.c index 735ebbd1148f..3d21c0799037 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -1136,7 +1136,7 @@ static void vi_program_aspm(struct amdgpu_device
> *adev)
>         bool bL1SS =3D false;
>         bool bClkReqSupport =3D true;
>
> -       if (amdgpu_aspm !=3D 1)
> +       if (!amdgpu_aspm)
>                 return;
>
>         if (adev->flags & AMD_IS_APU ||
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index d2fd44b903ca..270b2b0b8e8a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -302,7 +302,7 @@ sienna_cichlid_get_allowed_feature_mask(struct
> smu_context *smu,
>         if (smu->dc_controlled_by_gpio)
>         *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_ACDC_BIT);
>
> -       if (amdgpu_aspm =3D=3D 1)
> +       if (amdgpu_aspm)
>                 *(uint64_t *)feature_mask |=3D
> FEATURE_MASK(FEATURE_DS_LCLK_BIT);
>
>         return 0;
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
>
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CJianso=
ng.Chen%40amd.com%7C414e894d646e4161c7ab08d914296d92%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637562990432397285%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM=
C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3DTvVZdWM32y8rOn154m%2B0pLvHxk9fEuOaiBqiIxXSxiE%3D&amp;reserved=3D0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--000000000000d2757e05c208f71c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">You could even write why it was disabled before and why=
 you can enable it now again in the commit message.</div><div class=3D"gmai=
l_default" style=3D"font-family:arial,helvetica,sans-serif"><br></div><div =
class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">Re=
gards</div><div class=3D"gmail_default" style=3D"font-family:arial,helvetic=
a,sans-serif">//Ernst<br></div></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">Den tis 11 maj 2021 kl 09:25 skrev Chen, Jia=
nsong (Simon) &lt;<a href=3D"mailto:Jiansong.Chen@amd.com">Jiansong.Chen@am=
d.com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">[=
AMD Official Use Only - Internal Distribution Only]<br>
<br>
Better to make the commit msg more specific, eg. Change predicate according=
ly since aspm is enabled by default.<br>
Either way,=C2=A0 Reviewed-by: Jiansong Chen &lt;<a href=3D"mailto:Jiansong=
.Chen@amd.com" target=3D"_blank">Jiansong.Chen@amd.com</a>&gt;<br>
<br>
Regards,<br>
Jiansong<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org" =
target=3D"_blank">amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf O=
f Kenneth Feng<br>
Sent: Tuesday, May 11, 2021 11:04 AM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-=
gfx@lists.freedesktop.org</a><br>
Cc: Feng, Kenneth &lt;<a href=3D"mailto:Kenneth.Feng@amd.com" target=3D"_bl=
ank">Kenneth.Feng@amd.com</a>&gt;<br>
Subject: [PATCH] drm/amd/pm: enable ASPM by default<br>
<br>
enable ASPM by default<br>
<br>
Signed-off-by: Kenneth Feng &lt;<a href=3D"mailto:kenneth.feng@amd.com" tar=
get=3D"_blank">kenneth.feng@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/nv.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/soc15.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/vi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A0drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-<br>
=C2=A04 files changed, 4 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c index 82a380be8368..2fcfd893edc5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -598,7 +598,7 @@ static void nv_pcie_gen3_enable(struct amdgpu_device *a=
dev)<br>
<br>
=C2=A0static void nv_program_aspm(struct amdgpu_device *adev)=C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_aspm !=3D 1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!amdgpu_aspm)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(adev-&gt;flags &amp; AMD_IS_APU) &amp;&am=
p;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c<br>
index 49ece2a7f9f0..4b660b2d1c22 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
@@ -817,7 +817,7 @@ static void soc15_pcie_gen3_enable(struct amdgpu_device=
 *adev)<br>
<br>
=C2=A0static void soc15_program_aspm(struct amdgpu_device *adev)=C2=A0 {<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_aspm !=3D 1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!amdgpu_aspm)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(adev-&gt;flags &amp; AMD_IS_APU) &amp;&am=
p;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/v=
i.c index 735ebbd1148f..3d21c0799037 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vi.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c<br>
@@ -1136,7 +1136,7 @@ static void vi_program_aspm(struct amdgpu_device *ade=
v)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool bL1SS =3D false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool bClkReqSupport =3D true;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_aspm !=3D 1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!amdgpu_aspm)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (adev-&gt;flags &amp; AMD_IS_APU ||<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
index d2fd44b903ca..270b2b0b8e8a 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
@@ -302,7 +302,7 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_cont=
ext *smu,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (smu-&gt;dc_controlled_by_gpio)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEA=
TURE_ACDC_BIT);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_aspm =3D=3D 1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_aspm)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *(uint64_t *)featur=
e_mask |=3D FEATURE_MASK(FEATURE_DS_LCLK_BIT);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
--<br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7CJiansong.Chen%40amd.com%7C414e894d646e4161c7ab08d914296d92%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637562990432397285%7CUnknown%7CTWFpbGZs=
b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C10=
00&amp;amp;sdata=3DTvVZdWM32y8rOn154m%2B0pLvHxk9fEuOaiBqiIxXSxiE%3D&amp;amp=
;reserved=3D0" rel=3D"noreferrer" target=3D"_blank">https://nam11.safelinks=
.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailma=
n%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C01%7CJiansong.Chen%40amd.com%7C4=
14e894d646e4161c7ab08d914296d92%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%=
7C637562990432397285%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2=
luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3DTvVZdWM32y8rOn1=
54m%2B0pLvHxk9fEuOaiBqiIxXSxiE%3D&amp;amp;reserved=3D0</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>

--000000000000d2757e05c208f71c--

--===============0634442768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0634442768==--
