Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C392C4727C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 22:12:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2603D23A1B
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 22:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="paRkkH3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2603D23A1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98F006E59B;
	Mon, 21 Sep 2020 22:12:32 +0000 (UTC)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AE3D6E598
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 21:53:14 +0000 (UTC)
Received: by mail-ej1-x643.google.com with SMTP id z23so19847785ejr.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 14:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=PuGU+gh+f47Fni+roRL7yJLiSeJPX6p4NNMJOllUKNI=;
 b=paRkkH3aEfeygDthrn6A/F6P6zigyjQcKn1X6slZxJWA9eGNVQBYWTxNpvsT6ovEo+
 3h3QOdD8/KqmXztRsnwG42osKuKq05HFT/xhu5jF08I5KAh3ZXBrdmVbk7EiI8j3MG56
 eHTqHD0+uPfEs9d+F/o07TXPHhn6jM2guh0h3jUAhDXOXnUp1GUJ2WD22en9KODyK9Pz
 lLYt268J5I49d2juanvlAhUKmji93f86GNThMyanJY5EU2vIHazgZpa1gpDwfale7SA1
 w7BtH8VhNcyOIy9YpABFiTDVElXJBoyrYEB6lTR4tns3KLi51rkFAt+6YzVLWcFJZ1Sa
 KsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=PuGU+gh+f47Fni+roRL7yJLiSeJPX6p4NNMJOllUKNI=;
 b=WbmIow06bP8Av8IE49tugODZlv32chtt5nddq8N1kVxlqdIwWZDrHkhY7SyQ38+cK3
 KSnAn6ej4u+jxTsV7NcTxKHWz4H5T6NYKmNRco0oguYFZmp8ud4HhVcQDUbLR0X3YFwU
 tuomzFQUKyct11P3Yv7sJqMWBcd7IyJ8ZUxRryogd+M+c+xQLaVmC/jFc46G4m7RCciZ
 t5wiA6eLPm8Kvnv3Yd9LqDTubDxs0ClqhZ207VTZdVdqhhyiENw3SFiv9R/nrOc0Tem5
 0qI3YE1a07sWzTWvMfv201RsVICDyGmmPBSZ6r09aOi4PVecV3h7xeM+q7I6W+bR8qnC
 V5Ng==
X-Gm-Message-State: AOAM530qK2g71FHXBHNok1En/LHXMgrMCZ0WGoo0S4OzxBvMKXkMx0qO
 KElCGbyt/gRvgYJDXpq3dMR9pviIGudUArGO8N1cGCv0
X-Google-Smtp-Source: ABdhPJymxaoJgl3G60uiBkRLsT1/vMIlk7U2JTmsk3blxMYUqg/zt5j7Can3bEDr+4PD92Ld0a6dCDn3aJHUyPbrc7o=
X-Received: by 2002:a17:906:7fcb:: with SMTP id
 r11mr1493041ejs.519.1600725192837; 
 Mon, 21 Sep 2020 14:53:12 -0700 (PDT)
MIME-Version: 1.0
From: Anthony Benware <hyperkvmx86@gmail.com>
Date: Mon, 21 Sep 2020 17:53:00 -0400
Message-ID: <CADBwLwpTrsaBL_=U=4Oe5zDAEuc5qJV61rb3F-Zrr=Sn6G3uLw@mail.gmail.com>
Subject: [PATCH] drm/amd/display: Fix dcn30_optc.o unknown argument with clang
To: amd-gfx@lists.freedesktop.org
X-Mailman-Approved-At: Mon, 21 Sep 2020 22:12:30 +0000
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
Content-Type: multipart/mixed; boundary="===============2011557122=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2011557122==
Content-Type: multipart/alternative; boundary="000000000000808e7005afd9e0c2"

--000000000000808e7005afd9e0c2
Content-Type: text/plain; charset="UTF-8"

[Why]
Clang can't compile dcn30_optc.o with '-mpreferred-stack-boundary=4'

[How]
use '-mstack-alignment=4' if Clang is CC and '-mpreferred-stack-boundary=4'
if CC is not Clang

Signed-off-by: Anthony Benware <hyperkvmx86@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
index 025637a83c3b..fcded5498393 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
@@ -31,7 +31,11 @@ DCN30 = dcn30_init.o dcn30_hubbub.o dcn30_hubp.o
dcn30_dpp.o dcn30_optc.o \
        dcn30_dio_link_encoder.o dcn30_resource.o


+ifdef CONFIG_CC_IS_CLANG
+CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -msse
-mstack-alignment=4
+else
 CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -msse
-mpreferred-stack-boundary=4
+endif

 CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -mhard-float -msse
 ifdef CONFIG_CC_IS_GCC
--
2.28.0

--000000000000808e7005afd9e0c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>[Why]<br></div><div>Clang can&#39;t compile dcn30_opt=
c.o with &#39;-mpreferred-stack-boundary=3D4&#39;<br></div><div><br></div><=
div>[How]<br>use &#39;-mstack-alignment=3D4&#39; if Clang is CC and &#39;-m=
preferred-stack-boundary=3D4&#39; if CC is not Clang<br></div><div><br></di=
v><div>Signed-off-by: Anthony Benware &lt;<a href=3D"mailto:hyperkvmx86@gma=
il.com" target=3D"_blank">hyperkvmx86@gmail.com</a>&gt;</div><div>---<br>=
=C2=A0drivers/gpu/drm/amd/display/dc/dcn30/Makefile | 4 ++++<br>=C2=A01 fil=
e changed, 4 insertions(+)<br><br>diff --git a/drivers/gpu/drm/amd/display/=
dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile<br>index =
025637a83c3b..fcded5498393 100644<br>--- a/drivers/gpu/drm/amd/display/dc/d=
cn30/Makefile<br>+++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile<br>@@ =
-31,7 +31,11 @@ DCN30 =3D dcn30_init.o dcn30_hubbub.o dcn30_hubp.o dcn30_dp=
p.o dcn30_optc.o \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 dcn30_dio_link_encoder.o =
dcn30_resource.o<br><br><br>+ifdef CONFIG_CC_IS_CLANG<br>+CFLAGS_$(AMDDALPA=
TH)/dc/dcn30/dcn30_optc.o :=3D -mhard-float -msse -mstack-alignment=3D4<br>=
+else<br>=C2=A0CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o :=3D -mhard-float=
 -msse -mpreferred-stack-boundary=3D4<br>+endif<br><br>=C2=A0CFLAGS_$(AMDDA=
LPATH)/dc/dcn30/dcn30_resource.o :=3D -mhard-float -msse<br>=C2=A0ifdef CON=
FIG_CC_IS_GCC<br>--<br>2.28.0</div></div>

--000000000000808e7005afd9e0c2--

--===============2011557122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2011557122==--
