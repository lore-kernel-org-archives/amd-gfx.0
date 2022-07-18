Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA66C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 18:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6D8A10EAB9;
	Mon, 18 Jul 2022 18:54:38 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE1D710EB12
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 18:54:37 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id l23so22999192ejr.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 11:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=oGwjE6MIwO4ucRosF+8m5EnWnpdyb5yp48oQst1QNMs=;
 b=Hw/cn955r/+L1mdh7/c5e/DT+5UqIfu0y3ea6tKR6CyaJ9S5iNsdwx+JFPhDHvAMAi
 pBAtYPvKlwTL6EJKbCJontOplOeipTpHFNlHopuvVaRAwz9lSjChwOl/kcmP13Yf/wAF
 4Xf+Io0yb+Pn6H09XEqRRqTQXauDq88ix8d0WmnbxD30Lxh2Cn1dVUjLewfzlKy/ajKO
 /5xNRs+yZo33NRk400jh1IRcY1ijRv1opDzReGVUQxM3+aOWGEjTdYESbKBFrrHk5hMa
 0YqwT4Gg4qmh6iYJSXxFfbJZLpZOBUiWXCw9SipgMxMF6fRi0uoR679GUzZfYRA+/B64
 4IwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oGwjE6MIwO4ucRosF+8m5EnWnpdyb5yp48oQst1QNMs=;
 b=05cnKMTn0A3k1MfORX/1EKQtPabH7jbU+jZABnQavx+WdoZX6Soj2Qy9R61yU3UaZy
 aChN30wHzPFfvOSg9MpymBq3PUfzTp0qUfyr/REGMTbmtEiUpAgfmimDpt/d+4J8FCZc
 eiYDCfwKjxJPcGxP0t4t0H3Uey20N4pcA3pK5+mpykWtS/fmtYEpfkM8RlRL/dxOF8/u
 ly4+YhMQ3pPSi3BCPbYrWoeczMi5ZqYoKTVpH+qBgZCTyhmvkNoKhA9fMzrwA+dacd8s
 mKi1ZUuS8z+zi4HUht/sVrrCXSS34nNcP01FQC+YJ9TCPM4NCMYhJGn9hnT3TlRUoRX3
 DbBA==
X-Gm-Message-State: AJIora803H8//wWb6KdvYUnSB7y18CDWT6gWsB8AnJ/VqkC7VQnPNqU6
 Xc7s1Dc9qwXmjkNO8dsXRzVMFdCPLlyuQRzSc4U=
X-Google-Smtp-Source: AGRyM1tIqrsFMSjGxNxpvTlCjK1sMKGBOFkixBpGEmhMeK/QEH2R/OkK4amX3VBUABiVM3Ewf6/2CQZUDdUFIu/lTms=
X-Received: by 2002:a17:906:58d5:b0:72f:2b21:eb20 with SMTP id
 e21-20020a17090658d500b0072f2b21eb20mr6790627ejs.508.1658170476337; Mon, 18
 Jul 2022 11:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220714164507.561751-1-mairacanal@riseup.net>
 <20220714164507.561751-4-mairacanal@riseup.net>
In-Reply-To: <20220714164507.561751-4-mairacanal@riseup.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Jul 2022 14:54:24 -0400
Message-ID: <CADnq5_M5UjWbN2N=zr-BGRcha-2Q+jSC5MXScU+nt6LD=_fs8w@mail.gmail.com>
Subject: Re: [PATCH 04/12] drm/amd/display: Remove unused
 dml32_CalculatedoublePipeDPPCLKAndSCLThroughput function
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Magali Lemes <magalilemes00@gmail.com>, Leo Li <sunpeng.li@amd.com>,
 Tales Lelo da Aparecida <tales.aparecida@gmail.com>,
 xinhui pan <Xinhui.Pan@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Melissa Wen <mwen@igalia.com>, David Airlie <airlied@linux.ie>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net,
 Harry Wentland <harry.wentland@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Thu, Jul 14, 2022 at 12:45 PM Ma=C3=ADra Canal <mairacanal@riseup.net> w=
rote:
>
> Remove dml32_CalculatedoublePipeDPPCLKAndSCLThroughput function, which is=
 not used in
> the codebase.
>
> This was pointed by clang with the following warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_=
32.c:393:6:
> warning: no previous prototype for function
> 'dml32_CalculatedoublePipeDPPCLKAndSCLThroughput' [-Wmissing-prototypes]
> void dml32_CalculatedoublePipeDPPCLKAndSCLThroughput(
>      ^
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_=
32.c:393:1:
> note: declare 'static' if the function is not intended to be used outside=
 of
> this translation unit
> void dml32_CalculatedoublePipeDPPCLKAndSCLThroughput(
> ^
> static
> 1 warning generated.
>
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> ---
>  .../dc/dml/dcn32/display_mode_vba_util_32.c   | 54 -------------------
>  1 file changed, 54 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_ut=
il_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32=
.c
> index 5a701d9df0f7..4d62ab0c1a78 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> @@ -390,60 +390,6 @@ void dml32_CalculateBytePerPixelAndBlockSizes(
>  #endif
>  } // CalculateBytePerPixelAndBlockSizes
>
> -void dml32_CalculatedoublePipeDPPCLKAndSCLThroughput(
> -               double HRatio,
> -               double HRatioChroma,
> -               double VRatio,
> -               double VRatioChroma,
> -               double MaxDCHUBToPSCLThroughput,
> -               double MaxPSCLToLBThroughput,
> -               double PixelClock,
> -               enum source_format_class SourcePixelFormat,
> -               unsigned int HTaps,
> -               unsigned int HTapsChroma,
> -               unsigned int VTaps,
> -               unsigned int VTapsChroma,
> -
> -               /* output */
> -               double *PSCL_THROUGHPUT,
> -               double *PSCL_THROUGHPUT_CHROMA,
> -               double *DPPCLKUsingdoubleDPP)
> -{
> -       double DPPCLKUsingdoubleDPPLuma;
> -       double DPPCLKUsingdoubleDPPChroma;
> -
> -       if (HRatio > 1) {
> -               *PSCL_THROUGHPUT =3D dml_min(MaxDCHUBToPSCLThroughput, Ma=
xPSCLToLBThroughput * HRatio /
> -                               dml_ceil((double) HTaps / 6.0, 1.0));
> -       } else {
> -               *PSCL_THROUGHPUT =3D dml_min(MaxDCHUBToPSCLThroughput, Ma=
xPSCLToLBThroughput);
> -       }
> -
> -       DPPCLKUsingdoubleDPPLuma =3D PixelClock * dml_max3(VTaps / 6 * dm=
l_min(1, HRatio), HRatio * VRatio /
> -                       *PSCL_THROUGHPUT, 1);
> -
> -       if ((HTaps > 6 || VTaps > 6) && DPPCLKUsingdoubleDPPLuma < 2 * Pi=
xelClock)
> -               DPPCLKUsingdoubleDPPLuma =3D 2 * PixelClock;
> -
> -       if ((SourcePixelFormat !=3D dm_420_8 && SourcePixelFormat !=3D dm=
_420_10 && SourcePixelFormat !=3D dm_420_12 &&
> -                       SourcePixelFormat !=3D dm_rgbe_alpha)) {
> -               *PSCL_THROUGHPUT_CHROMA =3D 0;
> -               *DPPCLKUsingdoubleDPP =3D DPPCLKUsingdoubleDPPLuma;
> -       } else {
> -               if (HRatioChroma > 1) {
> -                       *PSCL_THROUGHPUT_CHROMA =3D dml_min(MaxDCHUBToPSC=
LThroughput, MaxPSCLToLBThroughput *
> -                                       HRatioChroma / dml_ceil((double) =
HTapsChroma / 6.0, 1.0));
> -               } else {
> -                       *PSCL_THROUGHPUT_CHROMA =3D dml_min(MaxDCHUBToPSC=
LThroughput, MaxPSCLToLBThroughput);
> -               }
> -               DPPCLKUsingdoubleDPPChroma =3D PixelClock * dml_max3(VTap=
sChroma / 6 * dml_min(1, HRatioChroma),
> -                               HRatioChroma * VRatioChroma / *PSCL_THROU=
GHPUT_CHROMA, 1);
> -               if ((HTapsChroma > 6 || VTapsChroma > 6) && DPPCLKUsingdo=
ubleDPPChroma < 2 * PixelClock)
> -                       DPPCLKUsingdoubleDPPChroma =3D 2 * PixelClock;
> -               *DPPCLKUsingdoubleDPP =3D dml_max(DPPCLKUsingdoubleDPPLum=
a, DPPCLKUsingdoubleDPPChroma);
> -       }
> -}
> -
>  void dml32_CalculateSwathAndDETConfiguration(
>                 unsigned int DETSizeOverride[],
>                 enum dm_use_mall_for_pstate_change_mode UseMALLForPStateC=
hange[],
> --
> 2.36.1
>
