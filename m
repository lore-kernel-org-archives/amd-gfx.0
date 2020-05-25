Return-Path: <SRS0=Ro4j=7H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848CAC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 13:31:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52C69207C3
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 13:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFJ7PWnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C69207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF28689AF3;
	Mon, 25 May 2020 13:31:34 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5AF389AF3;
 Mon, 25 May 2020 13:31:33 +0000 (UTC)
Received: by mail-qv1-xf2c.google.com with SMTP id l3so8020147qvo.7;
 Mon, 25 May 2020 06:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=6660ungMw0MtF7oce4azAMwPvJj83mN97aRwiDtPJM0=;
 b=hFJ7PWnmoUK+jIjaftgcjdYSSIgZZpG6aD0UAP3iq3E/c7AAAX8vgBEsTrN2nu/nCK
 TV3N/gk2lR74oz2Htg8l1qg16ZvC441qNnbK6X7Fk8gMcF5Q2/mafw3BShltR70MT2cN
 dp+xRLds5qQDnXBLOvIsNcM6BhKRzQ2JbO+T1P0HDWjkdC2KoMN39AC9/PRjR526/12G
 aSso1OaELezBQ6qXu7QT/FMVVcY5CmJsbb0z1zpL+ML89KDIcOW5osc6YE+Oi3IlwEL0
 CX3lAg7ev3oUbR2g8877tHHF8HD9OJ5GnJwDF5a4ekVjzIhFXv04LA4cipaclUMKz6us
 mYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=6660ungMw0MtF7oce4azAMwPvJj83mN97aRwiDtPJM0=;
 b=nIcxZ1I9LTY/oawuzOdRiOgu/CHcL3no9NcKw38s9XCPjsS91TXAAkQFY8fJo6ptde
 epESVKjJpl7UK/OCwSlN9dL1ymk3x0l3o97UbxygHcRpjgy7RM2QiygL+bSQZ4Ynn99W
 T6ECzsFt/YQNkpQxbgm4slBGqQPND4Pc+a7SMRnJh6A+tylmZ8b6tQrOwclgIssW3TLe
 tUGubpHp9FEYGqv5VKXfIabe7KGNdSI3KdWqywQx/jFqyFolnZHj6xSXF8uf0qosAXI9
 6t5smS4BacKiyHiXT2UmZ1EK6BxihHmqEX1RfEn/kIHDhMAIu6PT81EzyzaltEGM7HVm
 ig9Q==
X-Gm-Message-State: AOAM530QLiGp5zkjlMErcXEId1Dlp+gUey5zAU+b+rsUk+fnlzCUAK7P
 VIHYnm3lnuh8X2gQEgSElBUr0/QTITrDsvygpNLUJu+M
X-Google-Smtp-Source: ABdhPJx602B8+1Xts6T1reOKzhUH70/nHAesgoqnsnmhuwwUSS+7AsKhs1whm4aS9Sc4WfFmKDfR5YSHuSr4eyFgX+I=
X-Received: by 2002:a0c:a5c5:: with SMTP id z63mr15720810qvz.50.1590413492402; 
 Mon, 25 May 2020 06:31:32 -0700 (PDT)
MIME-Version: 1.0
From: uday kiran pichika <udaykiran.pichika@gmail.com>
Date: Mon, 25 May 2020 19:01:21 +0530
Message-ID: <CAGcx_0Yu4D6F2BiPp5CnJhMyrupGsnFnzEH0-Gv=8rFuVtDi+w@mail.gmail.com>
Subject: Adaptive Sync enabling in Xorg Modesetting driver
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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
Content-Type: multipart/mixed; boundary="===============0328574330=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0328574330==
Content-Type: multipart/alternative; boundary="00000000000042bfd405a678ff3d"

--00000000000042bfd405a678ff3d
Content-Type: text/plain; charset="UTF-8"

Hello,

Am working on enabling the Adaptive sync feature as part of the
Xorg/Modesetting DDX driver by taking the reference of AMD DDX Driver
(xf86-video-amdgpu). Below is the commit which i submitted.
https://gitlab.freedesktop.org/pichika/xserver/-/commit/682565a645bda7371cc3731ee805cc4a0ace80db


I have made the below changes to enable this feature
1. Enable Adaptive sync in Graphics Driver
2. Added Xorg.conf file with VariableRefresh property which is read in the
Modesetting driver --> This is working fine.

After taking the above changes, am observing that Adaptive sync is not
working.

Below are my observations.
1. loader_dri3_helper.c  --> Adaptive sync property is being set once the
system is booted successfully on one Window. Once
set_adaptive_sync_property() method gets called, adaptive_sync_active flag
is setting to true. From the next time, when fullscreen applications are
loaded, this property never gets set on any window.
2. Once this property is being set, received a notification in modesetting
ddx driver and read the property from the Stuff->window.
3. But when the fullscreen application(Either DOTA or Xonotic), not
observing that this propety is not being set on any app window.

Can any one please help me why this property is not being set in the
application windows ?

Thanks
Uday Kiran

--00000000000042bfd405a678ff3d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>Am working on enabling the Adapt=
ive sync feature as part of the Xorg/Modesetting DDX driver by taking the r=
eference of AMD DDX Driver (xf86-video-amdgpu). Below is the commit which i=
 submitted.</div><div><a href=3D"https://gitlab.freedesktop.org/pichika/xse=
rver/-/commit/682565a645bda7371cc3731ee805cc4a0ace80db">https://gitlab.free=
desktop.org/pichika/xserver/-/commit/682565a645bda7371cc3731ee805cc4a0ace80=
db</a>=C2=A0=C2=A0<br></div><div><br></div><div>I have made the below chang=
es to enable this feature</div><div>1. Enable Adaptive sync in Graphics Dri=
ver</div><div>2. Added Xorg.conf file with VariableRefresh property which i=
s read in the Modesetting driver --&gt; This is working fine.</div><div><br=
></div><div>After taking the above changes, am observing that Adaptive sync=
 is not working.</div><div><br></div><div>Below are my observations.</div><=
div>1. loader_dri3_helper.c=C2=A0 --&gt; Adaptive sync property=C2=A0is bei=
ng set once the system is booted successfully on one Window. Once set_adapt=
ive_sync_property() method gets called, adaptive_sync_active flag is settin=
g to true. From the next time, when fullscreen applications are loaded, thi=
s property never gets set on any window.=C2=A0</div><div>2. Once this prope=
rty is being set, received a notification in modesetting ddx driver and rea=
d the property from the Stuff-&gt;window.=C2=A0</div><div>3. But when the f=
ullscreen application(Either DOTA or Xonotic), not observing that this prop=
ety=C2=A0is not being set on any app window.=C2=A0</div><div><br></div><div=
>Can any one please help me why this property is not being set in the appli=
cation windows ?=C2=A0</div><div><br></div><div>Thanks=C2=A0</div><div>Uday=
 Kiran</div><div><br></div><div><br></div><div><br></div><div><br></div></d=
iv>

--00000000000042bfd405a678ff3d--

--===============0328574330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0328574330==--
