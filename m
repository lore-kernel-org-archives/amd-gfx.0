Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840ECC55178
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Aug 2026 07:58:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E082010E2D4;
	Sat,  1 Aug 2026 07:58:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=honeycomb.io header.i=@honeycomb.io header.b="OSHbqfcq";
	dkim-atps=neutral
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AF6110F365
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 17:15:17 +0000 (UTC)
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-81e86df8987so17655027b3.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 10:15:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785518116; cv=none;
 d=google.com; s=arc-20260327;
 b=Xoz40tGAoEszfdyqrudjWwslL3+aHqv1yvxCujHv5gjGzhq6C6j9AC2cLPl2ShxOPU
 aktLA5JKAgSJAi02F1bz5Ong16TO8i0i0gR1M+S7y+Qu8KSDtJBIHLN384CINQf1fWSZ
 EX5psYVZ/E7BEJq1chYRJjjds9cbKffImJBmn99UtrFiaBe6MQSsU3/pxEoCtz0NTHu9
 E6A4Hz5Sj9OxWSBlfo23O9OzMx7w+dGSDjjKHSU82ZrywEatRKmXVkezus5pnvNyATOy
 OI7i1O3eBahnF/5tz+2dXsoscqNlVoblJ8wsxqnQ/cvr7sKspaqktQZ34sgVa2N+xXCM
 0NCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Aake1qi/bZ5WIaHH6w2ZSfnBLuGhxW6qZvF7nCkmXUI=;
 fh=SXM6ArW+O8k1KSPHuygJDgpKKeku3XSxUyFL94mXfdc=;
 b=E/BB5BojyeS54Zx30Kk8J32pL3DfMIQFPzTOApMcbQuKohlvNppJWlHzMWNjsnzG+L
 +CRUri7FFHit7azlbYLJyysvK+KuTpOZRwMtvRrNbyeYq7g8cLbyKXoPcAkgZ7s9X/VV
 Mn+zH6HmAIi/Io7LwJ+9a+rVwE2vrmpyakee2/jJQu9qSlNQ/ZAzkn32uLdpiozJUerH
 J6Ipd5WMA9dtptSMbaSBIlhM4is0GMIkcLZR9BiMhyhvF3V6D688BS5ygjFgZy39fNyc
 bmojY3uk2lfQ0iSlxkotV3eXH3Lc4qt+NDkSyo+l1Hilg2nj4gQX3iTaQR7/HtAF/IcL
 v6uA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=honeycomb.io; s=google; t=1785518116; x=1786122916;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Aake1qi/bZ5WIaHH6w2ZSfnBLuGhxW6qZvF7nCkmXUI=;
 b=OSHbqfcq73NxvgFFfUYLUBQJ8pAFCtoBCLZ5F2W68fsWp3vsvoJiOSQkUG/hHc5Ed2
 jZ7O1k4IS5q9k4NPUwy1d9onVkeChTBamBOLVhuVLURLwtG+Ipdspg43twQjBkKo5qCG
 WN9MK8ur57iS72tXaoaTE63Bd3sMkBWPYajAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785518116; x=1786122916;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Aake1qi/bZ5WIaHH6w2ZSfnBLuGhxW6qZvF7nCkmXUI=;
 b=X3NgiFLNEAKFcC9egmC6SMR3taodVeTMews2xZyQhIo8uv3xINWKpeoGpE+RlVwGxq
 tCQc6V//zP/CsP5iF/wY9G1CbSrwitCRcK8RimfbvHxVxXAOs6YWWA/+HJ5bZKeSWTkx
 Hv9j362hBVodAeRsLARoaAEv4I+BDXO20ZilmQqGIzskdNveTOB2ll6vaeGMkQHvfoAD
 z0dFuB4b7xpim/Dwn5TnkYF1TWAZ6x+xgNIqPfKycYW/rcQm+asW6Yp+LJ3s+/BZ9GSW
 LaDW5lfV4JM/Im6/NFC/tzC2ro44y7I0BcUgn8THZTM1GypxdgxEhlMdwVQWQDCMoLU6
 +Ofw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq/o3zTo0JDs+Cnc9hC9P7EciO/g2rjFDZPLyecBKeg8isZ+OzsCPEv6qcosyIDAd0op8DlIL6Y@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy2CpSHgvgL+VgjZfqNEXBWeiHSCyz35GLmGhbu35eANVtCujNr
 Gm8F8BxVnkNnV6QYWC9UBG1xNy91khh998RgUH+2iuBedm/F57agxeaGCivSbdLZLmFP0Ho2d8j
 0ncNm/NJ+jkyIuFf3EesxvhUqGyzePefGgQ++ETzf+Q==
X-Gm-Gg: AR+sD129M+BQxWKCAL16r67ftnZU1VqB1IbPil62whlMAWV+XUCTAGxXIiuVVDdxt1i
 Bfk4uR7YHkmTG7NtETlO9O+Um3Sew6zoSgj3oJRrClNgen5yoRLKikSLJ4K/dAlyOr13fH8WVoQ
 q1OwT2sVgU1/sxhc8shs3eQAbKfV2ul/na36kNWWfReOmNW26NUilVOEmq86CmyQmDA3Zinr0jD
 aLEMR9U5Dthqs5arSOeIOQlWHn7XvcfGjNSOkvnF0+FYusmBbsrd+dpd+ib5vnLvDjnyBFQ1FBe
 UlcW5q9mdjJr0LIkCFpy7K6NL10q5lJrW/UXyH2f++dCEGSRTrXSWDx7YfeAbfwz/I5ycWxjYrU
 6W3qu89NEkWSH1KppUgb4LLWo0BBCxhXIiQr85rwuKJcgoog1d3V57M/a7EkxYvQ5NfAPjXpIPD
 NmDlUSWOIxb9o781k+NFA=
X-Received: by 2002:a05:690c:6d0a:b0:7d1:dd7b:b71f with SMTP id
 00721157ae682-81fd4bc10f8mr8771407b3.29.1785518115791; Fri, 31 Jul 2026
 10:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260712-pci-rebar-root-bus-v2-1-a1b9107a82dc@honeycomb.io>
 <20260731162424.GA1571989@bhelgaas>
In-Reply-To: <20260731162424.GA1571989@bhelgaas>
From: Liz Fong-Jones <lizf@honeycomb.io>
Date: Fri, 31 Jul 2026 10:15:04 -0700
X-Gm-Features: AUfX_mwL8h0dOFHBQ7ifqDGY32Df8ndWfkpFsKv8FxpZdkkti4vzPoYPyfrKVVk
Message-ID: <CAC0H+B-p5MT4M03MMkbxr_dLjsuThkxPv3--Ciant0i2MvvqDw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Fix BAR resize for devices on a root bus
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
 amd-gfx@lists.freedesktop.org, Jon Nettleton <jon@solid-run.com>, 
 Jon Nettleton <jon.nettleton@gmail.com>, stable@vger.kernel.org
Content-Type: multipart/alternative; boundary="00000000000008377a0657eb5512"
X-Mailman-Approved-At: Sat, 01 Aug 2026 07:58:44 +0000
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

--00000000000008377a0657eb5512
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Maybe this is a tangent, but I'm curious about this topology.  Is this
> running as a virtualized guest?  At the hardware level, a PCIe
> endpoint must have a Root Port somewhere, even if it isn't visible to
> the OS (as is often the case in virtualized guests).
>
Defer to Jon on what the actual hardware configuration is, but this is
physical hardware, no virtualisation, running as the UEFI rather than U-Boo=
t
(devicetree) variant. See:
https://dev.solid-run.com/nxp/lx2160a/com-som/lx2160a
-com-hardware-user-manual#block-diagram

> @@ -2415,13 +2417,24 @@ int pci_do_resource_release_and_resize(struct
> pci_dev *pdev, int resno, int size
> >
> >       pci_resize_resource_set_size(pdev, resno, size);
> >
> > -     if (!bus->self)
> > -             goto out;
> > +     if (bus->self) {
>
> I think pci_upstream_bridge() would be better here.  Not that this
> device will be a VF (where pci_upstream_bridge() makes a difference),
> but just to be a little more generic.
>
I'll have a look at this and publish a v3 if appropriate.


Liz
---
=F0=9F=90=9D=F0=9F=8D=AF=F0=9F=90=9D Liz Fong-Jones, MACS (Snr) CP, Technic=
al Fellow =F0=9F=8D=AF=F0=9F=90=9D=F0=9F=8D=AF
honeycomb.io - The observability platform for teams who manage software
that matters.
lizthegrey.com // linkedin.com/in/efong // bsky.app/profile/lizthegrey.com

--00000000000008377a0657eb5512
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Maybe this is a tangent, but I&#39;m cu=
rious about this topology.=C2=A0 Is this<br>
running as a virtualized guest?=C2=A0 At the hardware level, a PCIe<br>
endpoint must have a Root Port somewhere, even if it isn&#39;t visible to<b=
r>
the OS (as is often the case in virtualized guests).<br></blockquote><div>D=
efer to Jon on what the actual hardware configuration is, but this is</div>=
<div>physical hardware, no virtualisation, running as the UEFI rather than =
U-Boot</div><div><span style=3D"background-color:transparent">(de</span><sp=
an style=3D"background-color:transparent">vicetree) variant. See:</span></d=
iv><div><span style=3D"background-color:transparent"><a href=3D"https://dev=
.solid-run.com/nxp/lx2160a/com-som/lx2160a">https://dev.solid-run.com/nxp/l=
x2160a/com-som/lx2160a</a></span><span style=3D"background-color:transparen=
t">-com-hardware-user-manual#block-diagram</span></div><div><br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">&gt; @@ -2415,13 +2417,24 @@ i=
nt pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int =
size<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pci_resize_resource_set_size(pdev, resno, si=
ze);<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (!bus-&gt;self)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (bus-&gt;self) {<br>
<br>
I think pci_upstream_bridge() would be better here.=C2=A0 Not that this<br>
device will be a VF (where pci_upstream_bridge() makes a difference),<br>
but just to be a little more generic.<br></blockquote><div>I&#39;ll have a =
look at this and publish a v3 if appropriate.</div><div><br></div><div><br>=
</div><div>Liz<br>---</div><div>=F0=9F=90=9D=F0=9F=8D=AF=F0=9F=90=9D=C2=A0L=
iz Fong-Jones, MACS (Snr) CP, Technical Fellow=C2=A0=F0=9F=8D=AF=F0=9F=90=
=9D=F0=9F=8D=AF</div><div><a href=3D"http://honeycomb.io/" target=3D"_blank=
">honeycomb.io</a>=C2=A0- The observability platform for teams who manage s=
oftware that matters.<br></div><div><a href=3D"http://lizthegrey.com/" styl=
e=3D"background-color:transparent" target=3D"_blank">lizthegrey.com</a><spa=
n style=3D"background-color:transparent">=C2=A0</span><span style=3D"backgr=
ound-color:transparent">//</span><span style=3D"background-color:transparen=
t">=C2=A0</span><a href=3D"http://linkedin.com/in/efong" style=3D"backgroun=
d-color:transparent" target=3D"_blank">linkedin.com/in/efong</a><span style=
=3D"background-color:transparent">=C2=A0//</span><span style=3D"background-=
color:transparent">=C2=A0</span><a href=3D"http://bsky.app/profile/lizthegr=
ey.com" style=3D"background-color:transparent" target=3D"_blank">bsky.app/p=
rofile/lizthegrey.com</a></div></div></div>
</div>

--00000000000008377a0657eb5512--
