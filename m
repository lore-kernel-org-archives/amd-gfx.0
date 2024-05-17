Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAEEC04FFE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 May 2024 11:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09B8610EE81;
	Fri, 17 May 2024 11:28:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fBbY6hSl";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA61410EE81
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 May 2024 11:28:26 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-6f4603237e0so42982b3a.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 May 2024 04:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715945306; x=1716550106; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QK6DydqePA+uagCcAUFF8RH+e36PxKyMLmA8X08UdxM=;
 b=fBbY6hSlet68hkYLM/L/R1wqXtAuMQjSm1OymgXkAedpX/+BC9g7thxFQFJFoHFgvk
 eAUisVk16qEzPsSe5qLqEPAPOU+xCl/dv9uFEoS+MBSfCKwMMvYWuYYlGvHbms5x1hZv
 RG1LO6i41/1uoyROg99VVyaQ6jMO+4zKbW0dPqnPg1JR7c9VPOZczWy2qs2aRITnveUU
 ejU6fLERULYEI7vlyYv4ppTGI7qLHKgDJDS9ESCt9yY9oEs5a0bkbfExLBa06gkQ+azz
 OuCVqETybxzNRydPUyclvxi5a35NkdT5dpBsxw/HeqmPauBglWste0iq7Huxv3Krx70G
 VqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715945306; x=1716550106;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QK6DydqePA+uagCcAUFF8RH+e36PxKyMLmA8X08UdxM=;
 b=OtAGJclOR6N+98M3+PuO901kc6Yy0iDDLtXjGSatmM5TVctCpJeRL6yRM8E5y7Nd89
 eCT9240KaT1lTyWr5tT712qrwaovwZvFeA4zV1r2wy092TKbRaWsdQ0nuReldMB+It5V
 ZKiVqetdsR2DVi5eRQEVyGBGwEaYmFGLRd1wLlEjN1vWey0rK2R7K7XOHGh/BDKhNAJY
 sxc1n7B8UT432K3HSglb6Rzk6N1gM5K4jTn3EnfcT/4koZkCWtTOq4Rq093rbaiPZs7H
 Mc/MWKBLpt4gwEWtpqz1J0WFiL/bGd3ntveWyxalc1RBWqf+F7IPsXJjF5bcLzSbTjUJ
 OPug==
X-Gm-Message-State: AOJu0YxRaKGk/amUnE6GVqnp61buyw7E4qvvQ/Fr3sZ4Axamh229zMnO
 bEufr7476rrJdlw7kWFgpDTOxdbAWEtWJLQo0gGt6IkVE+SKHQ9RRAp5FDziP1r2fQKqOUMkXuw
 yXbgB4aSjtNSxdnQO4U+mZ//c429zaL4D
X-Google-Smtp-Source: AGHT+IHs9C/vFAkH6Hs5B0AgV8V2+9KQf6v9hOt9wq/Bxt5e/fsl65wlJk/p2kAdIIhCOnKyCqqfCiNgvn/CDAmJffM=
X-Received: by 2002:a05:6a20:9697:b0:1a7:48de:b2a4 with SMTP id
 adf61e73a8af0-1afde07d88amr25712930637.6.1715945305782; Fri, 17 May 2024
 04:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAEQFVGbaEx8mOWKy9bcq8FLFfq8Q+xE_hwk4dq5weKjNROcOGg@mail.gmail.com>
In-Reply-To: <CAEQFVGbaEx8mOWKy9bcq8FLFfq8Q+xE_hwk4dq5weKjNROcOGg@mail.gmail.com>
From: Mauro Rossi <issor.oruam@gmail.com>
Date: Fri, 17 May 2024 13:28:13 +0200
Message-ID: <CAEQFVGb3Xwx+TLf8QM2VBZ9EXy4rvpUs4wX=zNUQeyuy-=33yA@mail.gmail.com>
Subject: Re: Request for Information on the current drm radeon Atomic Mode
 Settings
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Cc: Alexander <alexander.deucher@amd.com>, lee@kernel.org, 
 Michael Goffioul <michael.goffioul@gmail.com>,
 Jon West <electrikjesus@gmail.com>, youling 257 <youling257@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000067c3130618a4a67c"
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

--00000000000067c3130618a4a67c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Cc: correct email address of Lee Jones, just For Your Information

Updated [2] link URL because HWC3 in Celadon was moved to project Celadon
drm-hwcomposer local branch on yesterday

The request for information on drm radeon atomic modesettings is confirmed

Mauro

On Fri, May 17, 2024 at 8:31=E2=80=AFAM Mauro Rossi <issor.oruam@gmail.com>=
 wrote:

> Hi all,
>
> with Android 14 QPR2 there were substantial changes in graphic stack's
> Android HAL (Hardware Abstraction Layer),
> essentially it became mandatory that hwcomposer HAL module supports AIDL
> Android Interface Definition Language,
>
> at the moment drm_hwcomposer does not support AIDL [1]
>
> Project Celadon has an HWC3 AIDL implemented [2], as a patch on top of
> hardware/interface AOSP project, there is an opportunity to use it also f=
or
> non Intel GPUs.
>
> drm amdpu in kernel already supports ADF Atomic Display Framework, I woul=
d
> like to ask the current status of Atomic Display Framework in drm radeon,
> because Atomic Mode Settings seems partially implemented since 2010-2012,
> but ADF capabilities are not exposed to user space.
>
> Please, I also need some basic (high level) information about the
> outstanding changes that would be required to support it, in order to be
> able to use HWC3 -> drm_hwcomposer with r600, r300 chipsets.
>
> Thanks for your informations
>
> Mauro
> android-x86 team/Bliss-OS community
>
> [1]
> https://gitlab.freedesktop.org/drm-hwcomposer/drm-hwcomposer/-/issues/80
> [2]
> https://github.com/projectceladon/vendor-intel-utils/blob/master/aosp_dif=
f/preliminary/hardware/interfaces/11_0001-Enable-graphics.composer3-AIDL-HA=
L-service.patch
>

[2]
https://github.com/projectceladon/drm-hwcomposer/commit/1160cdfb53daebf59f3=
704ec9586c66385e63747

--00000000000067c3130618a4a67c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Cc: correct email address of Lee Jones, just For Your=
 Information</div><div><br></div><div>Updated [2] link URL because=C2=A0HWC=
3 in Celadon was moved to project Celadon drm-hwcomposer local branch on ye=
sterday</div><div><br></div><div>The request for information on drm radeon =
atomic modesettings=C2=A0is confirmed</div><div><br></div><div>Mauro</div><=
br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri,=
 May 17, 2024 at 8:31=E2=80=AFAM Mauro Rossi &lt;<a href=3D"mailto:issor.or=
uam@gmail.com">issor.oruam@gmail.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Hi all,<div><br></div>=
<div>with Android 14 QPR2 there were substantial changes in graphic stack&#=
39;s Android HAL (Hardware Abstraction Layer),</div><div>essentially it bec=
ame mandatory that hwcomposer HAL module supports AIDL Android Interface De=
finition Language,</div><div><br></div><div>at the moment drm_hwcomposer do=
es not support AIDL [1]</div><div><br></div><div>Project Celadon has an HWC=
3 AIDL implemented [2], <strike>as a patch on top of hardware/interface AOS=
P project, there is an opportunity to use it also for non Intel GPUs.</stri=
ke><br></div><div><br></div><div>drm amdpu=C2=A0in kernel already supports =
ADF Atomic Display Framework, I would like to ask the current status of Ato=
mic Display Framework in drm radeon, because Atomic Mode Settings seems par=
tially implemented since 2010-2012, but ADF capabilities are not exposed to=
 user=C2=A0space.=C2=A0</div><div><br></div><div>Please, I also need some b=
asic (high level) information about the outstanding changes that would be r=
equired to support it, in order to be able to use HWC3 -&gt; drm_hwcomposer=
 with r600, r300 chipsets.</div><div><br></div><div>Thanks for your informa=
tions</div><div><br></div><div>Mauro</div><div>android-x86 team/Bliss-OS co=
mmunity</div><div><br></div><div>[1] <a href=3D"https://gitlab.freedesktop.=
org/drm-hwcomposer/drm-hwcomposer/-/issues/80" target=3D"_blank">https://gi=
tlab.freedesktop.org/drm-hwcomposer/drm-hwcomposer/-/issues/80</a></div><di=
v><strike>[2]=C2=A0<a href=3D"https://github.com/projectceladon/vendor-inte=
l-utils/blob/master/aosp_diff/preliminary/hardware/interfaces/11_0001-Enabl=
e-graphics.composer3-AIDL-HAL-service.patch" target=3D"_blank">https://gith=
ub.com/projectceladon/vendor-intel-utils/blob/master/aosp_diff/preliminary/=
hardware/interfaces/11_0001-Enable-graphics.composer3-AIDL-HAL-service.patc=
h</a></strike></div></div></blockquote><div><br></div><div>[2]=C2=A0<a href=
=3D"https://github.com/projectceladon/drm-hwcomposer/commit/1160cdfb53daebf=
59f3704ec9586c66385e63747">https://github.com/projectceladon/drm-hwcomposer=
/commit/1160cdfb53daebf59f3704ec9586c66385e63747</a></div></div></div>

--00000000000067c3130618a4a67c--
