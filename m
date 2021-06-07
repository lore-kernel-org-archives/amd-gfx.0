Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E9AC47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 20:54:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C03346100B
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 20:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03346100B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76DDB6E094;
	Mon,  7 Jun 2021 20:54:16 +0000 (UTC)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE266E094
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 20:54:15 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 b15-20020a17090a550fb029015dad75163dso864040pji.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Jun 2021 13:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qTxj3UxM00MQf6XW/anwb8AdTUQyR+s/mLFds/uV2v0=;
 b=Mb9ip2ncMSAmJuZfdSCRWtEP6CGVmPb4fvV4stUlaNVUDLmhxXC2uY8F1W3RpFIMhJ
 RnjPxE0rmnWuG7nnd34aEEtYA34/XvTbNKICAjfyAD40fzegoUhcux0RmYYEc3kHwzID
 uHeoug4pmGBGkDKhwQqN5O5wQzEKncvWch0YtpftT7uLo1wqH3Ky1S94ETcBeXCKc5ms
 4xqiMb6pPsB0QDstdbgw5/ZX9WT9sI9gKq5OFfLnvHCJwA0Z/DrTSR6UEWO27ToQbtr8
 UO1rtuFdyk+F2Bup4I7xNn5lk66vCSfHETP3qX3OpG7ayj6CymZ9U8f0AcmEWOprt0bC
 yX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qTxj3UxM00MQf6XW/anwb8AdTUQyR+s/mLFds/uV2v0=;
 b=qrjAarLElMjMgNgdP0E9mdbfRgdena6ORn3f2BBr23o+W6Af9ZVDdLpCzxK2OEpDRY
 EycSBc0imcED1rwo8JVkpNuKdKR19vkCBVGYMugYKqbnlm8udjxe3MHzDH94KN3wkA2a
 9fV2fbYPd11pTrtqXlQq0IDpf/6QgqfMlxn2dBeNeOfc39ztEIwWe3YuS22NQAIgqWA0
 2GKh3BSUF3+mE4+UJaKC+kV/UHmCd9lqm+0rf9f+Grsh//x+tvCJ+O8kgPkiefN4tpgV
 HrUnSDKIsTSx4xMF1YmjoeRscdAweXKrhw8H+emklxPAM413AFQCbU+OaA3V2PLWo5Ef
 Izpw==
X-Gm-Message-State: AOAM530QPAYNg7hBSIh115QEHWxaV4PoNq3apKVHmL28x2XCeYAdVLXB
 YfvWnByexY24sxksEaw72Kg3SdZdSzGXFado2BS1RO9Qa+hkAg==
X-Google-Smtp-Source: ABdhPJyqKmDV6pD6V9Dqux1C9fffQMdgtCcQyyvQ/a8160iwZgkrw7GsczF6CruYyfcjugf0m2+M1Xkf2sRSIsmBfQo=
X-Received: by 2002:a17:90a:4503:: with SMTP id
 u3mr458324pjg.210.1623099255543; 
 Mon, 07 Jun 2021 13:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210607202841.2120465-1-alexander.deucher@amd.com>
In-Reply-To: <20210607202841.2120465-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Date: Mon, 7 Jun 2021 22:54:04 +0200
Message-ID: <CAD=4a=Vgy4-i07wd3LLD4YUUgtKrZKz6Jw4trvOSZX6D12_T4w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: drop gfxoff control for VCN2+
To: Alex Deucher <alexander.deucher@amd.com>
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
Content-Type: multipart/mixed; boundary="===============0131709719=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0131709719==
Content-Type: multipart/alternative; boundary="0000000000008fd9ab05c4333e17"

--0000000000008fd9ab05c4333e17
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

doesn't this patch apply the change to VCN1.0 also, which has that bug you
mentioned?

Regards
//Ernst

Den m=C3=A5n 7 juni 2021 kl 22:29 skrev Alex Deucher <alexander.deucher@amd=
.com>:

> Drop disabling of gfxoff during VCN use.  This allows gfxoff
> to kick in and potentially save power if the user is not using
> gfx for color space conversion or scaling.
>
> VCN1.0 had a bug which prevented it from working properly with
> gfxoff, so we disabled it while using VCN.  That said, most apps
> today use gfx for scaling and color space conversion rather than
> overlay planes so it was generally in use anyway. This was fixed
> on VCN2+, but since we mostly use gfx for color space conversion
> and scaling and rapidly powering up/down gfx can negate the
> advantages of gfxoff, we left gfxoff disabled. As more
> applications use overlay planes for color space conversion
> and scaling, this starts to be a win, so go ahead and leave
> gfxoff enabled.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 1dc11dbd62b7..647d2c31e8bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -393,7 +393,6 @@ static void amdgpu_vcn_idle_work_handler(struct
> work_struct *work)
>         }
>
>         if (!fences && !atomic_read(&adev->vcn.total_submission_cnt)) {
> -               amdgpu_gfx_off_ctrl(adev, true);
>                 amdgpu_device_ip_set_powergating_state(adev,
> AMD_IP_BLOCK_TYPE_VCN,
>                        AMD_PG_STATE_GATE);
>                 r =3D amdgpu_dpm_switch_power_profile(adev,
> PP_SMC_POWER_PROFILE_VIDEO,
> @@ -413,7 +412,6 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring
> *ring)
>         atomic_inc(&adev->vcn.total_submission_cnt);
>
>         if (!cancel_delayed_work_sync(&adev->vcn.idle_work)) {
> -               amdgpu_gfx_off_ctrl(adev, false);
>                 r =3D amdgpu_dpm_switch_power_profile(adev,
> PP_SMC_POWER_PROFILE_VIDEO,
>                                 true);
>                 if (r)
> --
> 2.31.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--0000000000008fd9ab05c4333e17
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">Hi,</div><div class=3D"gmail_default" style=3D"font-fam=
ily:arial,helvetica,sans-serif"><br></div><div class=3D"gmail_default" styl=
e=3D"font-family:arial,helvetica,sans-serif">doesn&#39;t this patch apply t=
he change to VCN1.0 also, which has that bug you mentioned?</div><div class=
=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif"><br></d=
iv><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-s=
erif">Regards</div><div class=3D"gmail_default" style=3D"font-family:arial,=
helvetica,sans-serif">//Ernst<br></div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">Den m=C3=A5n 7 juni 2021 kl 22:29 sk=
rev Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com">alexander=
.deucher@amd.com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Drop disabling of gfxoff during VCN use.=C2=A0 This allows gfxof=
f<br>
to kick in and potentially save power if the user is not using<br>
gfx for color space conversion or scaling.<br>
<br>
VCN1.0 had a bug which prevented it from working properly with<br>
gfxoff, so we disabled it while using VCN.=C2=A0 That said, most apps<br>
today use gfx for scaling and color space conversion rather than<br>
overlay planes so it was generally in use anyway. This was fixed<br>
on VCN2+, but since we mostly use gfx for color space conversion<br>
and scaling and rapidly powering up/down gfx can negate the<br>
advantages of gfxoff, we left gfxoff disabled. As more<br>
applications use overlay planes for color space conversion<br>
and scaling, this starts to be a win, so go ahead and leave<br>
gfxoff enabled.<br>
<br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com=
" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 --<br>
=C2=A01 file changed, 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c<br>
index 1dc11dbd62b7..647d2c31e8bd 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
@@ -393,7 +393,6 @@ static void amdgpu_vcn_idle_work_handler(struct work_st=
ruct *work)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!fences &amp;&amp; !atomic_read(&amp;adev-&=
gt;vcn.total_submission_cnt)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_gfx_off_ctrl=
(adev, true);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_device_ip_se=
t_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0AMD_PG_STATE_GATE);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D amdgpu_dpm_sw=
itch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,<br>
@@ -413,7 +412,6 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 atomic_inc(&amp;adev-&gt;vcn.total_submission_c=
nt);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cancel_delayed_work_sync(&amp;adev-&gt;vcn=
.idle_work)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_gfx_off_ctrl=
(adev, false);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D amdgpu_dpm_sw=
itch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 true);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r)<br>
-- <br>
2.31.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>

--0000000000008fd9ab05c4333e17--

--===============0131709719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0131709719==--
