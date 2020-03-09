Return-Path: <SRS0=uBoY=42=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E58C10F27
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 13:12:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1722E22525
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 13:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9qUGeDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1722E22525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D42DC6E43A;
	Mon,  9 Mar 2020 13:12:30 +0000 (UTC)
Received: from mail-yw1-xc42.google.com (mail-yw1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47CD26E43A
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2020 13:07:08 +0000 (UTC)
Received: by mail-yw1-xc42.google.com with SMTP id p69so9992798ywh.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Mar 2020 06:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=Bu0k3p+MnHIahsik/erYZtegvsmSPs6jpQGwPnWGlsU=;
 b=X9qUGeDCmjIk4YcwW1OYMZz3domSRBg5eb31CjGUX0mTTVN9j1+xaqI67rNguEKTte
 e5NxVxZEmWVsY+u9IbTzGB2frbSl6N6D5jLqvpPMvn0gCVG8QQXN+u9Izv9b4Ab+iZZh
 zwDItR9NpP1lX4WDiUdiw4Lr7GITDWBjqJPlEzHRlf35VOgh7Qjn2xJC+zwYRXWxgKlq
 P1mVnoeRC82ipBK/BICCCaklyiGs90XwpWVi0kjl3WGJLRWPkog+kvlZGfPLKlKQoACR
 xD0iY4POqrOLYoACVRLYVR5baR2EdjrCbqCl7brRFLm4ZZOqPAMT4FKraEIhZPI5P11u
 y2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=Bu0k3p+MnHIahsik/erYZtegvsmSPs6jpQGwPnWGlsU=;
 b=BEtcOL48cud204DW/VVy2N4tgL6lwnEX/M+LTngjBpByTTJNONnIKhngh3LChRmuYN
 k217WI2f3Yy3FJZyPugkxdniPistxzkhld5u1QTUxg6ZWqXEP7ywB+IxScnirR3GaFrF
 3T7qsqK16a5eSHP5CV6JlKPkj+Ly3yU60CcAN9ydsrFb1XIUOwSTYqG7fuuCb0fLC2N5
 RFZecZxnnr1u4FiTYGdaFycRDRo3M5rfQ1bC8lwQWwWqWpu0nGH+ylYTP9otY9/V6lvG
 vcSrFW/+KU1lbzlEmQ43vTDqbwYIe7QCO/vbPodo79YTOH5wtUJu+etu99xm59foF0b3
 /UCA==
X-Gm-Message-State: ANhLgQ2TByxlXd+bFh8lyUHMQIXzE/6r2ngOya8n4JnREI1h1WYJxBVB
 TS+RywWvU7gRNM+k+PqF+bGOOHg/iAyVI4eAWMd+zCMF
X-Google-Smtp-Source: ADFU+vs+Tc+UzrJQAZEH/gWNL3KOZDcXAxijDGKtn6hwNb06R5K8GO4My0Ht9bQhRoto97dfcydIRCGFfdClzTFSATc=
X-Received: by 2002:a81:3057:: with SMTP id w84mr1464531yww.2.1583759227081;
 Mon, 09 Mar 2020 06:07:07 -0700 (PDT)
MIME-Version: 1.0
From: Justin Noor <justinnoor.io@gmail.com>
Date: Mon, 9 Mar 2020 06:06:56 -0700
Message-ID: <CA+EaAqYEg6H-ON=Z1N27JzgihKPeg5W8Nm+KRJfpRGsByrbFNw@mail.gmail.com>
Subject: OpenBSD amdgpu RX550 stub messages in dmesg
To: amd-gfx@lists.freedesktop.org
X-Mailman-Approved-At: Mon, 09 Mar 2020 13:12:30 +0000
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
Content-Type: multipart/mixed; boundary="===============0045847239=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0045847239==
Content-Type: multipart/alternative; boundary="00000000000023d74205a06bae5c"

--00000000000023d74205a06bae5c
Content-Type: text/plain; charset="UTF-8"

Hello community,

I've been experiencing some random and inconsistent crashes related to
amdgpu0 on OpenBSD 6.6 current. I noticed the following in my dmesg:

 amdgpu_irq_add_domain: stub
 amdgpu_device_resize_fb_bar: stub
 amdgpu: [powerplay] Failed to retrieve minimum
 clocks

Someone mentioned that the driver could be hitting some unsupported
features and I was wondering if anyone else was experiencing these issues,
and looking for any suggestions on how to resolve them.

--00000000000023d74205a06bae5c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello community,</div><div><br></div><div>I&#39;ve be=
en experiencing some random and inconsistent crashes related to amdgpu0 on =
OpenBSD 6.6 current. I noticed the following in my dmesg:</div><div><br></d=
iv><div><div><div dir=3D"auto">=C2=A0amdgpu_irq_add_domain: stub<br>=C2=A0a=
mdgpu_device_resize_fb_bar: stub<br>=C2=A0amdgpu: [powerplay] Failed to ret=
rieve minimum</div><div dir=3D"auto">=C2=A0clocks</div><div dir=3D"auto"><b=
r></div><div>Someone mentioned that the driver could be hitting some unsupp=
orted features and I was wondering if anyone else was experiencing these is=
sues, and looking for any suggestions on how to resolve them.<br></div></di=
v></div></div>

--00000000000023d74205a06bae5c--

--===============0045847239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0045847239==--
