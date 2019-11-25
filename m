Return-Path: <SRS0=lTJr=ZR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C14C432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 16:34:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F222220740
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 16:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F222220740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B810C6E150;
	Mon, 25 Nov 2019 16:34:22 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03F766E150
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2019 16:34:21 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id t26so293308wmi.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2019 08:34:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cUrX3hz04o/n/ssnLfJTErjO8qx7Cz+yLkwWLg3bwPw=;
 b=LWXrhg7KAhJrXcNk3mNV5DvtW3xJT6gMZ9U3qcLNtQx4Ya0+/GhEc+2c7N65i7VRUC
 jQUqHTxw6swEYaJbcJY765w1pId6eihlTb1MsxCnUPHwI0cMDTQqi3D57jFXjLnz+cs3
 NUP4mLZ5u6mftTdANNVf8i3hj+64pR/GimAiTmAJ1qDSXaWk6C+8TrY70PC/52qMwNgb
 smHecb4zwHVdjIEr9p6cHhblETy9IVGBoPnHzcHJw4N8itpj2Vt5ON2B/SmKOb+FM2e2
 eSrr72DM/HJLGBYonVfoCjSPZIn4nSOGPfPuEgBXgFhJ7ykfepwQh5PqKtVRMDR/boVh
 DxCA==
X-Gm-Message-State: APjAAAWpliesxJjs//kEWmul8JnwB6IrqDeo1mp9Q9195q7kloTqXhBj
 S8rH5q5J6SgcMB1agqxnllwMbysuyAttbhHgIao=
X-Google-Smtp-Source: APXvYqxma4LftYmg09Mz27LavdjfWi0I8AlTmDdfuD/wtGYv0gSzsuoy1hcOqb/M3fWRnkXLLncsKHRR4/kRKpcuSlY=
X-Received: by 2002:a1c:2846:: with SMTP id o67mr29963298wmo.7.1574699659524; 
 Mon, 25 Nov 2019 08:34:19 -0800 (PST)
MIME-Version: 1.0
References: <CAGzVRjyWG8mJKfn04=_KMPxB=YXnaSVC6yUwWy-0E0ndarJs0g@mail.gmail.com>
 <CADnq5_NEDJ18daPK-1sF5jHF8mD45W0RcGMzEDGSCnxH_qXbbQ@mail.gmail.com>
In-Reply-To: <CADnq5_NEDJ18daPK-1sF5jHF8mD45W0RcGMzEDGSCnxH_qXbbQ@mail.gmail.com>
From: =?UTF-8?Q?Yusuf_Alt=C4=B1parmak?= <yusufalti1997@gmail.com>
Date: Mon, 25 Nov 2019 19:34:08 +0300
Message-ID:
 <CAGzVRjyJi6HTbjDUGco7a-M=9tL4m+Q_xPuBbK2or9=rdox9Jg@mail.gmail.com>
Subject: Re: [Error] amdgpu for powerpc64 on kernel version 4.19.26
To: Alex Deucher <alexdeucher@gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=cUrX3hz04o/n/ssnLfJTErjO8qx7Cz+yLkwWLg3bwPw=;
 b=sXf78+vYi4vknCTPdoHo7PiUXi5fU7guvpoetN0/lcyUhXBFos2trRP7/riKKVPpcE
 aSngZbvnczNutQ8AWZh3lVSULPCVwsJKT5bEF+m4L/RCCNT/N3IQBv6HP2SE3hfm2XnL
 21lukfFvCmJvr5daSh7croK6M5ZZZGEmlGLXPd/RH2Q74ngmBqAlFUHFMz8gIdwuKdT/
 aUocta+U9ytKUwjc01o3C5LrkVJl9pVanNP+kvRKSpvfKoN7+ieaB4/k6LfGYZpfmyjj
 5RrxSdS8vnTBSNskoCdvwF6IvP7VijUlAvQutNZJEzEqCUz6GVt2likGrVGnvBWkTbeS
 m0Nw==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============1882230614=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191125163408.sKBa_KMjRxbZBW9olAbhaVPNRb5QF8-icwqZKyxOLiU@z>

--===============1882230614==
Content-Type: multipart/alternative; boundary="000000000000d5943105982e55dc"

--000000000000d5943105982e55dc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

25 Kas 2019 Pzt 17:44 tarihinde Alex Deucher <alexdeucher@gmail.com> =C5=9F=
unu
yazd=C4=B1:

> On Mon, Nov 25, 2019 at 8:55 AM Yusuf Alt=C4=B1parmak
> <yusufalti1997@gmail.com> wrote:
> >
> > Hello,
> >
> > I am trying to use AMD E9171 with T1042D4RDB-64B(
> https://www.nxp.com/products/processors-and-microcontrollers/power-archit=
ecture/qoriq-communication-processors/t-series/qoriq-t1042-and-t1022-multic=
ore-communications-processors:T1042
> ).
> > Software documentation is here (
> https://www.nxp.com/docs/en/supporting-information/QORIQ-SDK-2.0-IC-REV0.=
pdf
> ).
> >
> >
> > I tried to compile 'amdgpu' in linux kernel.
> >
> > I successfully compiled linux kernel for powerpc e5500 architecture. I
> enabled amdgpu and its prerequisites in menuconfig. All drivers compiled
> successfully.
> >
> > But when I try to install 'amdgpu.ko' module, it's not initializing gpu
> hardware. Console messages from 'dmesg' and U-boot is below. Hardware is
> connected to board via PCI and connected to monitor via HDMI-DVI converte=
r.
> I am using HDMI port on monitor.
> >
> > Any suggestion/solutions for this situation?
>
> The driver needs access to the PCI BARs for the device to initialize
> it.  It looks like they are not getting allocated.  Maybe your
> platform has limited MMIO space?  You need to fix that first.
>
> Alex
>
>
> >
> > Regards.
>
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx


Okay, thank you Alex. I'll see what I can do.
Regards

--000000000000d5943105982e55dc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"auto"><div><br><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">25 Kas 2019 Pzt 17:44 tarihinde Alex =
Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com" target=3D"_blank">alex=
deucher@gmail.com</a>&gt; =C5=9Funu yazd=C4=B1:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On Mon, Nov 25, 2019 at 8:55 AM Yusuf Alt=C4=B1parmak<br>
&lt;<a href=3D"mailto:yusufalti1997@gmail.com" rel=3D"noreferrer" target=3D=
"_blank">yusufalti1997@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hello,<br>
&gt;<br>
&gt; I am trying to use AMD E9171 with T1042D4RDB-64B(<a href=3D"https://ww=
w.nxp.com/products/processors-and-microcontrollers/power-architecture/qoriq=
-communication-processors/t-series/qoriq-t1042-and-t1022-multicore-communic=
ations-processors:T1042" rel=3D"noreferrer noreferrer" target=3D"_blank">ht=
tps://www.nxp.com/products/processors-and-microcontrollers/power-architectu=
re/qoriq-communication-processors/t-series/qoriq-t1042-and-t1022-multicore-=
communications-processors:T1042</a>).<br>
&gt; Software documentation is here (<a href=3D"https://www.nxp.com/docs/en=
/supporting-information/QORIQ-SDK-2.0-IC-REV0.pdf" rel=3D"noreferrer norefe=
rrer" target=3D"_blank">https://www.nxp.com/docs/en/supporting-information/=
QORIQ-SDK-2.0-IC-REV0.pdf</a>).<br>
&gt;<br>
&gt;<br>
&gt; I tried to compile &#39;amdgpu&#39; in linux kernel.<br>
&gt;<br>
&gt; I successfully compiled linux kernel for powerpc e5500 architecture. I=
 enabled amdgpu and its prerequisites in menuconfig. All drivers compiled s=
uccessfully.<br>
&gt;<br>
&gt; But when I try to install &#39;amdgpu.ko&#39; module, it&#39;s not ini=
tializing gpu hardware. Console messages from &#39;dmesg&#39; and U-boot is=
 below. Hardware is connected to board via PCI and connected to monitor via=
 HDMI-DVI converter. I am using HDMI port on monitor.<br>
&gt;<br>
&gt; Any suggestion/solutions for this situation?<br>
<br>
The driver needs access to the PCI BARs for the device to initialize<br>
it.=C2=A0 It looks like they are not getting allocated.=C2=A0 Maybe your<br=
>
platform has limited MMIO space?=C2=A0 You need to fix that first.<br>
<br>
Alex<br>
<br><br>
&gt;<br>
&gt; Regards.<br><br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org" rel=3D"noreferrer" ta=
rget=3D"_blank">amd-gfx@lists.freedesktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://lists.freedesktop.org/=
mailman/listinfo/amd-gfx</a></blockquote><div><br></div><div>Okay, thank yo=
u Alex. I&#39;ll see what I can do.=C2=A0</div><div>Regards=C2=A0</div></di=
v></div></div>
</div>

--000000000000d5943105982e55dc--

--===============1882230614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1882230614==--
