Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3ACC55178
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 12:47:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EF2820757
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 12:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDWugBv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF2820757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F5A66E040;
	Tue, 27 Oct 2020 12:47:12 +0000 (UTC)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2F7E6E040
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 12:47:10 +0000 (UTC)
Received: by mail-ej1-x644.google.com with SMTP id s15so2015658ejf.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 05:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RdprzV3TOI/3lSCWEurIu0dQ6clzIJaVjZ3UCn9ST/8=;
 b=hDWugBv4vvsekmKAxyGGn28uYVHKR7FFTsbhRe4QwFdR1+iBUz78E0zTFdlBB4IwG6
 H1tMwPJR6zrLiZK/U+us5Me7YM/k2yj5JB7JzLDFNzJXxfbgao/sdykozV4c3NWkl+kZ
 cwL//iCbxnWs/d421pplo/cEv0My+rwWMhX9ntctGylMxM0oPuqClKMaThdgYcywz8Gg
 Qto/KHayl0QtXGoRXpsg5KsnsYOYRcePR6O5Q5cK+cJcJBhCtCBFc/0JKPhCUoDXYPX1
 Tazrm2Ds1eIdL7GZQHPMudwjhsOmAOjZsUC6uIQnWeEza1ZcXHa4LmvzAhv9sQf5Naoy
 G3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RdprzV3TOI/3lSCWEurIu0dQ6clzIJaVjZ3UCn9ST/8=;
 b=ecoFX3XBShKAfiIaTbB8DWX03WAX9+0k6zchIliVzjxGeFZCoCpLRZzfV40tiAVWtw
 BFlBbWuQrqiyoS9c/WYRsLm8InN2+UqDLxlSFIlDzRTLDuvdJ7iJjPbaA5SMD1Sm/e5U
 PLWklnqrgqVDp4xu4pdipJt53EIeqnd2jaZeeZNgsikjWnuS2wV0DQgM/qeTCx3NfvDl
 awCb3IIKq4teKYW5DmN6K7nceL/r7glbed369Y72cOy4/1bmwuUmCFJADKpAFF+xi397
 7jFig0F4IE2tzVvvSoJUm1TBpcRCsKUhlWGNg531Fb3kXVt9iDIos7wBQraW8Wb6nxHU
 1r7Q==
X-Gm-Message-State: AOAM533ElrqUJwSuqYnC5YFOdTLhk8IvAXicmL8g0dWCklGjkE52PSAX
 G9iZLcDf1xIeaexKzQDOZOBD/h20LU2jqLeNGPLkjxeoZCU=
X-Google-Smtp-Source: ABdhPJxpid1zhY3+mdJv4JdSJeMc+3hYkMFz0os2qEwQ8eyUHTXIXpyZCeAKAbuZgy0qTsIVr8df6jcwUteMFcl/w2k=
X-Received: by 2002:a17:906:110b:: with SMTP id
 h11mr2373994eja.156.1603802829525; 
 Tue, 27 Oct 2020 05:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <BYAPR12MB47596DFC2AEA6E96159F990BBB160@BYAPR12MB4759.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB47596DFC2AEA6E96159F990BBB160@BYAPR12MB4759.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Date: Tue, 27 Oct 2020 13:46:58 +0100
Message-ID: <CAD=4a=UPL+3R2N0XGUWL3Rg9MWTN03hVJf06xpfq+AhSpi0S_g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Activate a more aggressive DPM policy while
 there's heavy load.
To: "Li, Xin (Justin)" <Xin2.Li@amd.com>
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
Cc: "Zhao, Jiange" <Jiange.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0250364282=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0250364282==
Content-Type: multipart/alternative; boundary="000000000000f19a0a05b2a671af"

--000000000000f19a0a05b2a671af
Content-Type: text/plain; charset="UTF-8"

Is this really a patch for kernel.org? Seems like a hack for Stadia or
something. (And the patch description is not very good...)

This should really be made into a generic solution.

Regards
//Ernst

Den tis 27 okt. 2020 kl 07:38 skrev Li, Xin (Justin) <Xin2.Li@amd.com>:

> [AMD Official Use Only - Internal Distribution Only]
>
> Fix performace drop while streaming Doom
>
> Signed-off-by: Li, Xin (Justin) <Xin2.Li@amd.com>
> Signed-off-by: Zhao, Jiange <Jiange.Zhao@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index eab9768029c1..5287ac4e8364 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -125,6 +125,20 @@ static int pp_hw_init(void *handle)
>
>          ret = hwmgr_hw_init(hwmgr);
>
> +       if (adev->pdev->device == 0x6860 && adev->pdev->revision == 0x07) {
> +               long param[5];
> +
> +               param[0] = 5;  // busy_set_point
> +               param[1] = 60; // FPS
> +               param[2] = 0;  // use_rlc_busy
> +               param[3] = 3;  // min_active_level
> +               param[4] = PP_SMC_POWER_PROFILE_CUSTOM;
> +
> +               mutex_lock(&hwmgr->smu_lock);
> +               ret = hwmgr->hwmgr_func->set_power_profile_mode(hwmgr,
> param, 4);
> +               mutex_unlock(&hwmgr->smu_lock);
> +       }
> +
>          if (ret)
>                  pr_err("powerplay hw init failed\n");
>
> --
> 2.24.3 (Apple Git-128)
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--000000000000f19a0a05b2a671af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:arial,helvetica,sans-serif">Is this really a patch for <a href=3D"=
http://kernel.org">kernel.org</a>? Seems like a hack for Stadia or somethin=
g. (And the patch description is not very good...)<br></div><div class=3D"g=
mail_default" style=3D"font-family:arial,helvetica,sans-serif"><br></div><d=
iv class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif"=
>This should really be made into a generic solution.<br></div><div class=3D=
"gmail_default" style=3D"font-family:arial,helvetica,sans-serif"><br></div>=
<div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-seri=
f">Regards</div><div class=3D"gmail_default" style=3D"font-family:arial,hel=
vetica,sans-serif">//Ernst<br></div></div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">Den tis 27 okt. 2020 kl 07:38 skrev Li,=
 Xin (Justin) &lt;<a href=3D"mailto:Xin2.Li@amd.com">Xin2.Li@amd.com</a>&gt=
;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">





<div style=3D"overflow-wrap: break-word;" lang=3D"EN-US">
<p style=3D"font-family:Arial;font-size:11pt;color:rgb(0,120,215);margin:5p=
t" align=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"gmail-m_-4730461119559906375WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;-webkit-standard&qu=
ot;,serif;color:black">Fix performace drop while streaming Doom<br>
<br>
Signed-off-by: Li, Xin (Justin) &lt;</span><a href=3D"mailto:Xin2.Li@amd.co=
m" target=3D"_blank"><span style=3D"font-family:&quot;-webkit-standard&quot=
;,serif;color:rgb(0,0,100)">Xin2.Li@amd.com</span></a><span style=3D"font-f=
amily:&quot;-webkit-standard&quot;,serif;color:black">&gt;<br>
Signed-off-by: Zhao, Jiange &lt;</span><a href=3D"mailto:Jiange.Zhao@amd.co=
m" target=3D"_blank"><span style=3D"font-family:&quot;-webkit-standard&quot=
;,serif;color:rgb(0,0,100)">Jiange.Zhao@amd.com</span></a><span style=3D"fo=
nt-family:&quot;-webkit-standard&quot;,serif;color:black">&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 14 ++++++++++++++<=
br>
=C2=A01 file changed, 14 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu=
/drm/amd/pm/powerplay/amd_powerplay.c<br>
index eab9768029c1..5287ac4e8364 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c<br>
@@ -125,6 +125,20 @@ static int pp_hw_init(void *handle)<br>
=C2=A0<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D hwmgr_hw_init(hwmg=
r);<br>
=C2=A0<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (adev-&gt;pdev-&gt;device =3D=3D 0=
x6860 &amp;&amp; adev-&gt;pdev-&gt;revision =3D=3D 0x07) {<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 long param[5];<br>
+<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 param[0] =3D 5;=C2=A0 // busy_set_point<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 param[1] =3D 60; // FPS<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 param[2] =3D 0;=C2=A0 // use_rlc_busy<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 param[3] =3D 3;=C2=A0 // min_active_level<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 param[4] =3D PP_SMC_POWER_PROFILE_CUSTOM;<br>
+<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 mutex_lock(&amp;hwmgr-&gt;smu_lock);<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ret =3D hwmgr-&gt;hwmgr_func-&gt;set_power_profile_mode(hwmgr,=
 param, 4);<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 mutex_unlock(&amp;hwmgr-&gt;smu_lock);<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
+<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 pr_err(&quot;powerplay hw init failed\n&quot;);<br>
=C2=A0<br>
--<span class=3D"gmail-m_-4730461119559906375apple-converted-space">=C2=A0<=
/span><br>
2.24.3 (Apple Git-128)</span><u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
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
</blockquote></div></div>

--000000000000f19a0a05b2a671af--

--===============0250364282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0250364282==--
