Return-Path: <SRS0=HyUd=OX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC73C433EF
	for <amd-gfx@archiver.kernel.org>; Sun,  3 Oct 2021 05:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9059F61205
	for <amd-gfx@archiver.kernel.org>; Sun,  3 Oct 2021 05:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9059F61205
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA5006E0B7;
	Sun,  3 Oct 2021 05:31:13 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 854856E0B7
 for <amd-gfx@lists.freedesktop.org>; Sun,  3 Oct 2021 05:31:12 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id bb10so1526459plb.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 02 Oct 2021 22:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rHq4dQU8bgDhhfMAGK5QrFDk1OnVr+AX7mDwFbwO1eU=;
 b=OYNkJmTa88j0mxlAtMQ5C4cSzPT8Bvkz8s3j40NZMiqF+ZB/3mJH4sjWQUJDwqhjwA
 aNmxfENzaZw7n8KGBHez5wyp6CvunXPw12IxzmdlAbs/eHcXoc9Txpv4SpklJRXF/zRE
 Qqb5CzBhLP3qEsuzIQ1J9PlRT++J2hmMJdJ4CzKFMcPJyK0BBI7z59uJxD8Po7E1iq05
 6dysqtxBHubWgKabi2Pyvp4YK7voszzuTOIiQJajEjSvy/ECsiC6b77wiWtjQeNuLTx7
 E5pznl8ZRAfAOxlPdv4NCsCIQjT/ec34iTSmECDlOuBAzKPXnJpmq/SAGcxMquUIexNC
 M+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rHq4dQU8bgDhhfMAGK5QrFDk1OnVr+AX7mDwFbwO1eU=;
 b=ySBL0SqlQIrRAJrG7q7YZcMPt5yeXBe9aYOMNkwkEzTft4UmxTh3h+XkbON1/Llece
 3CPfBEdB3NlPZyeBaQBNQozKQz/mWVonlgxCPCa+7llYm9kz2Dc5ytKH+NjLn8FWwpKf
 VwO4Aw0G7bePEFXyYCsqHYrRIw9oN9y9d8CpermPOmK38KRnhbzhe20osEnE4GrXJUpu
 owRmcFoOQxHNbFGAcj3YErdYDnpsYxUT6cKiDba2wMlxTinJ/vEg9A+zw26Nxht0saUF
 YWioUHPpLomov35oK/7yyE4WLUxslb9gFE1QMKpA7IvqeGK9Blj3m5IcbjnVR1+BsGOK
 qy7w==
X-Gm-Message-State: AOAM533hCqiHYhcr3cbwBqQrUkQMsPYqX9mSwPRJJzVE+dOxEmB7ec83
 LyuBGVj+KU0WZkz/wuKEojpwh0nX1WDcoEECEvQyed6n
X-Google-Smtp-Source: ABdhPJyOzwiKdF+ZqCqmMuFiCLgaGkDcpDAJK46HH5yyMFGkhrqcWIGdcx40PVc6cO6eal0kUeVi2WZSEqF2X1tY/Zc=
X-Received: by 2002:a17:90a:4a17:: with SMTP id
 e23mr23072491pjh.76.1633239072136; 
 Sat, 02 Oct 2021 22:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211003044658.29238-1-darren.powell@amd.com>
 <20211003044658.29238-3-darren.powell@amd.com>
In-Reply-To: <20211003044658.29238-3-darren.powell@amd.com>
From: =?UTF-8?Q?Nils_Wallm=C3=A9nius?= <nils.wallmenius@gmail.com>
Date: Sun, 3 Oct 2021 07:31:01 +0200
Message-ID: <CA+nq7DtKPwnQNEMy+jacOtN4JqwQnKb7LFb-XODuN5exxA3fhQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amd/pm: Fix incorrect power limit readback in
 smu11 if POWER_SOURCE_DC
To: Darren Powell <darren.powell@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000ba60ac05cd6c1a72"
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

--000000000000ba60ac05cd6c1a72
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, sorry for the drive-by comment but

limit_param |=3D 0 << 24;

Doesn't do anything.

Best regards
Nils

Den s=C3=B6n 3 okt. 2021 06:47Darren Powell <darren.powell@amd.com> skrev:

>  when smu->adev->pm.ac_power =3D=3D 0, message parameter with bit 16 set =
is
> saved
>  to smu->current_power_limit.
>
>  Fixes: 0cb4c62125a9 ("drm/amd/pm: correct power limit setting for SMU
> V11)"
>
> Signed-off-by: Darren Powell <darren.powell@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index aedaa4bb15c2..9bb6da99d5b5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -984,6 +984,7 @@ int smu_v11_0_set_power_limit(struct smu_context *smu=
,
>  {
>         int power_src;
>         int ret =3D 0;
> +       uint32_t limit_param;
>
>         if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
>                 dev_err(smu->adev->dev, "Setting new power limit is not
> supported!\n");
> @@ -1003,10 +1004,10 @@ int smu_v11_0_set_power_limit(struct smu_context
> *smu,
>          * BIT 16-23: PowerSource
>          * BIT 0-15: PowerLimit
>          */
> -       limit &=3D 0xFFFF;
> -       limit |=3D 0 << 24;
> -       limit |=3D (power_src) << 16;
> -       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetPptLimit,
> limit, NULL);
> +       limit_param  =3D (limit & 0xFFFF);
> +       limit_param |=3D 0 << 24;
> +       limit_param |=3D (power_src) << 16;
> +       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetPptLimit,
> limit_param, NULL);
>         if (ret) {
>                 dev_err(smu->adev->dev, "[%s] Set power limit Failed!\n",
> __func__);
>                 return ret;
> --
> 2.33.0
>
>

--000000000000ba60ac05cd6c1a72
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi, sorry for the drive-by comment but=C2=A0</div><d=
iv dir=3D"auto"><span style=3D"font-family:sans-serif"><br></span></div><di=
v dir=3D"auto"><span style=3D"font-family:sans-serif">limit_param |=3D 0 &l=
t;&lt; 24;</span></div><div dir=3D"auto"><font face=3D"sans-serif"><br></fo=
nt></div><div dir=3D"auto"><font face=3D"sans-serif">Doesn&#39;t do anythin=
g.</font></div><div dir=3D"auto"><font face=3D"sans-serif"><br></font></div=
><div dir=3D"auto"><font face=3D"sans-serif">Best regards</font></div><div =
dir=3D"auto"><font face=3D"sans-serif">Nils<br></font><br><div class=3D"gma=
il_quote" dir=3D"auto"><div dir=3D"ltr" class=3D"gmail_attr">Den s=C3=B6n 3=
 okt. 2021 06:47Darren Powell &lt;<a href=3D"mailto:darren.powell@amd.com">=
darren.powell@amd.com</a>&gt; skrev:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">=C2=A0when smu-&gt;adev-&gt;pm.ac_power =3D=3D 0, message parameter with =
bit 16 set is saved<br>
=C2=A0to smu-&gt;current_power_limit.<br>
<br>
=C2=A0Fixes: 0cb4c62125a9 (&quot;drm/amd/pm: correct power limit setting fo=
r SMU V11)&quot;<br>
<br>
Signed-off-by: Darren Powell &lt;<a href=3D"mailto:darren.powell@amd.com" t=
arget=3D"_blank" rel=3D"noreferrer">darren.powell@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 9 +++++----<br>
=C2=A01 file changed, 5 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
index aedaa4bb15c2..9bb6da99d5b5 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
@@ -984,6 +984,7 @@ int smu_v11_0_set_power_limit(struct smu_context *smu,<=
br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int power_src;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t limit_param;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!smu_cmn_feature_is_enabled(smu, SMU_FEATUR=
E_PPT_BIT)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(smu-&gt;ade=
v-&gt;dev, &quot;Setting new power limit is not supported!\n&quot;);<br>
@@ -1003,10 +1004,10 @@ int smu_v11_0_set_power_limit(struct smu_context *s=
mu,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* BIT 16-23: PowerSource<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* BIT 0-15: PowerLimit<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0limit &amp;=3D 0xFFFF;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0limit |=3D 0 &lt;&lt; 24;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0limit |=3D (power_src) &lt;&lt; 16;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_cmn_send_smc_msg_with_param(smu, SM=
U_MSG_SetPptLimit, limit, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0limit_param=C2=A0 =3D (limit &amp; 0xFFFF);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0limit_param |=3D 0 &lt;&lt; 24;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0limit_param |=3D (power_src) &lt;&lt; 16;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_cmn_send_smc_msg_with_param(smu, SM=
U_MSG_SetPptLimit, limit_param, NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(smu-&gt;ade=
v-&gt;dev, &quot;[%s] Set power limit Failed!\n&quot;, __func__);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
-- <br>
2.33.0<br>
<br>
</blockquote></div></div></div>

--000000000000ba60ac05cd6c1a72--
