Return-Path: <SRS0=mrdw=6P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_KAM_HTML_FONT_INVALID,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A373C4724C
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2020 16:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55A2C208DB
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2020 16:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhuDD1Wb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A2C208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB6F46ECD1;
	Fri,  1 May 2020 16:03:29 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DA276ECD1
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 May 2020 16:03:29 +0000 (UTC)
Received: by mail-pg1-x536.google.com with SMTP id l20so4720025pgb.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 May 2020 09:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p0k8PcvcNDx7iwKhoZNIjffnigKAqLbPR61bF4A9z38=;
 b=PhuDD1Wbisgh9O8oMi5DEI8cCZAoB7gLFIMJ3jh9wfbVIkFXqVmc50RLK2PWLNE4zw
 mWeBG8A1dYj53/feJNydDob7vSwkvtpcrD93w0MnoEDl6koY+FPqxsQYSTFKGcGLVWsw
 3aWgD0FHE3E1v+DCnlIiEEsk0VYWw8k4QoseGumoHEK2s908/VCtbPuFh0gXryR98U85
 7zuPMgreKC8TXwc459B9+lsM6UMQ9KCkBTAScFKAWh8Qk8xmkEE3Xf+exKVOzCnzm3uR
 qABzRTvf/rTHb6w7Aa77Od49H+zx9E3PWnJdEheaK15xR+1h6TbCsX7MW7W4ZzX4kWkT
 LA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p0k8PcvcNDx7iwKhoZNIjffnigKAqLbPR61bF4A9z38=;
 b=flPrLmUrSw/F32B9Joo/UYk9ZX2qGNlfFboIb+ECAEddvzEpEad5LobyQ66CNvAD9C
 kyfl5be80+IefxnfQHB5TF+9D+2rhVI0yqxUbveW8nisJ1+VGb6Gb/w7nO9gVAtpuimL
 7eZsagL6mrEywl6QXzDualky3Vnoz2wkjZTf5kGf+G+YKqGkiikL/c4nVLDzvGCY1vhP
 /wH2Y7HpnrLcWpQ6r+fneGxi9eae8f/IGq1MuKOLRXTz+UDA/I+7lbSYxrrJrLXjYpj2
 Z39jg5bubG1EsA3JfJc7Hrh5xETjKLm/5i+M6bTsg15bcot5pA3zMfL2zuzxpzVBfveq
 fEEQ==
X-Gm-Message-State: AGi0PubXFMq96ZLOz0KN9auKEv5rHOStVD0+/xf7wW2BSaXA3OCn8h8C
 QAN139On3j/yhWUU83SHw8FhhMiNUXhtdhNf528=
X-Google-Smtp-Source: APiQypL3zvYps9lX0dFAiJ2D+fAEkd5kCCjZX4CQ9jLLLSzP9rg4dYW/DrK+4zgS+bcVIOKSmdx2zKUR9fcgBhMLEHg=
X-Received: by 2002:a63:da10:: with SMTP id c16mr4784334pgh.208.1588349008731; 
 Fri, 01 May 2020 09:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAAxE2A7M8Lcf5EG5TxyZXt+ogL0Zh=jL-foW3aVd2A++Y-RSVg@mail.gmail.com>
 <DM5PR12MB170843C25AC1D5342A0726BF84AD0@DM5PR12MB1708.namprd12.prod.outlook.com>
 <DM5PR12MB170863A130B7FFDBC2511CE584AD0@DM5PR12MB1708.namprd12.prod.outlook.com>
 <79a48794-e539-f67f-13b3-0fa678ef94e7@amd.com>
 <DM5PR12MB170826866E450B9772D1A9CC84AD0@DM5PR12MB1708.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB170826866E450B9772D1A9CC84AD0@DM5PR12MB1708.namprd12.prod.outlook.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Fri, 1 May 2020 12:02:52 -0400
Message-ID: <CAAxE2A4aB-9oxD7Wp_RTvbnbz79-vPP7myyvT6BR4MjTD6EYwg@mail.gmail.com>
Subject: Re: drm/amdgpu: invalidate L2 before SDMA IBs (on gfx10)
To: "Liu, Monk" <Monk.Liu@amd.com>
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1243171157=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1243171157==
Content-Type: multipart/related; boundary="00000000000072ae8005a498525b"

--00000000000072ae8005a498525b
Content-Type: multipart/alternative; boundary="00000000000072ae7e05a498525a"

--00000000000072ae7e05a498525a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'll answer two questions asked:

1) SDMA doesn't need GCR at the end of IBs. It's because SDMA writes bypass
GL2 and at the same time they invalidate all cache lines they touch.

2)
> If we always insert a GL2C invalidate at every EOP of every IB from every
engine, why we need a GL2C invalidate before IB  execute ?

I just sent you a counterexample on a private thread that proves that
invalidation in RELEASE_MEM doesn't accomplish anything. The invalidation
flag is there because:
1) it was inherited from gfx9, which was inherited from gfx8, which was
inherited from gfx7, which doesn't have the WB flag, so INV has to be used
instead.
2) to hide bugs

Marek

On Wed, Apr 29, 2020 at 7:24 AM Liu, Monk <Monk.Liu@amd.com> wrote:

> >> Well from my understanding I think that a G2LC invalidation is still
> necessary before an IB executes.
>
> Agree, I think before an IB executes the only thing we need on GL2C is th=
e
> invalidation, not the flush .
>
>
> >> The problem is that the memory of the IB could also be cached because
> of some activity of the GFX or Compute rings.
>
> If we always insert a GL2C invalidate at every EOP of every IB from every
> engine, why we need a GL2C invalidate before IB  execute ?
>
> _____________________________________
>
> Monk Liu|GPU Virtualization Team |AMD
>
> [image: sig-cloud-gpu]
>
>
>
> *From:* Koenig, Christian <Christian.Koenig@amd.com>
> *Sent:* Wednesday, April 29, 2020 5:38 PM
> *To:* Liu, Monk <Monk.Liu@amd.com>; Marek Ol=C5=A1=C3=A1k <maraeo@gmail.c=
om>;
> amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
> *Subject:* Re: drm/amdgpu: invalidate L2 before SDMA IBs (on gfx10)
>
>
>
> Well from my understanding I think that a G2LC invalidation is still
> necessary before an IB executes.
>
> The problem is that the memory of the IB could also be cached because of
> some activity of the GFX or Compute rings.
>
> Regards,
> Christian.
>
> Am 29.04.20 um 11:35 schrieb Liu, Monk:
>
> Here is the reason we should always insert a =E2=80=9Csync mem=E2=80=9D p=
acket at the
> FENCE place of SDMA, not before IB emit.
>
>
>
> By always inserting =E2=80=9Csync mem=E2=80=9D in the FENCE place we can =
make sure:1
>
>    1. data is really flushed to system memory before CPU try to read it
>    2. all the G2LC is invalidated by =E2=80=9Csync mem=E2=80=9D, thus in =
the next round
>    SDMA IB, it won=E2=80=99t get staled data from G2LC cache
>
>
>
> by inserting =E2=80=9Csync mem=E2=80=9D in prior to IB could only achieve=
 :  Avoid get
> staled data in g2lc during IB execution
>
>
>
> for GFX/COMPUTE ring since they have release_mem packet so it is
> inherently doing the G2LC flush and invalidate upon a fence signaled
>
>
>
> _____________________________________
>
> Monk Liu|GPU Virtualization Team |AMD
>
> [image: sig-cloud-gpu]
>
>
>
> *From:* Liu, Monk
> *Sent:* Wednesday, April 29, 2020 5:06 PM
> *To:* 'Marek Ol=C5=A1=C3=A1k' <maraeo@gmail.com> <maraeo@gmail.com>; amd-=
gfx
> mailing list <amd-gfx@lists.freedesktop.org>
> <amd-gfx@lists.freedesktop.org>; Koenig, Christian
> <Christian.Koenig@amd.com> <Christian.Koenig@amd.com>
> *Subject:* RE: drm/amdgpu: invalidate L2 before SDMA IBs (on gfx10)
>
>
>
> Hi @Koenig, Christian <Christian.Koenig@amd.com> & Marek
>
>
>
> I still have some concerns regarding Marek=E2=80=99s patch, correct me if=
 I=E2=80=99m wrong
>
>
>
> See that Marek put a SDMA_OP_GCR_REQ before emitting IB, to make sure SDM=
A
> won=E2=80=99t get stale cache data during the IB execution.
>
>
>
> But that =E2=80=9CSDMA_OP_GCR_REQ=E2=80=9D only invalidate/flush the GFXH=
UB=E2=80=99s G2LC cache
> right ?  what if the memory is changed by MM or CPU (out side of GFXHUB) =
?
>
>
>
> Can this =E2=80=9C SDMA_OP_GCR_REQ=E2=80=9D force MMHUB or even CPU to fl=
ush their
> operation result from their cache to memory ??
>
>
>
> Besides, with my understanding the =E2=80=9CEOP=E2=80=9D of gfx ring is d=
oing the thing of
> =E2=80=9Cinvalidate/flush=E2=80=9D L2 cache upon a fence signaled, so wha=
t we should do on
> SDMA5 is to insert this =E2=80=9CSDMA_OP_GCR_REQ=E2=80=9D
>
> Right before thee =E2=80=9Cemit_fence=E2=80=9D of SDMA  (this is what win=
dows KMD do)
>
>
>
> thanks
>
> _____________________________________
>
> Monk Liu|GPU Virtualization Team |AMD
>
> [image: sig-cloud-gpu]
>
>
>
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of *Ma=
rek
> Ol?=C3=A1k
> *Sent:* Saturday, April 25, 2020 4:52 PM
> *To:* amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
> *Subject:* drm/amdgpu: invalidate L2 before SDMA IBs (on gfx10)
>
>
>
> This should fix SDMA hangs on gfx10.
>
>
>
> Marek
>
>
>

--00000000000072ae7e05a498525a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I&#39;ll answer two questions asked:</div><div><br></=
div><div>1) SDMA doesn&#39;t need GCR at the end of IBs. It&#39;s because S=
DMA writes bypass GL2 and at the same time they invalidate all cache lines =
they touch.</div><div><br></div><div>2)</div><div>&gt; <span style=3D"color=
:windowtext">If we always insert a GL2C invalidate at=20
every EOP of every IB from every engine, why we need a GL2C invalidate=20
before IB=C2=A0 execute ?</span></div><div><span style=3D"color:windowtext"=
><br></span></div><div><span style=3D"color:windowtext">I just sent you a c=
ounterexample on a private thread that proves that invalidation in RELEASE_=
MEM doesn&#39;t accomplish anything. The invalidation flag is there because=
:</span></div><div><span style=3D"color:windowtext">1) it was inherited fro=
m gfx9, which was inherited from gfx8, which was inherited from gfx7, which=
 doesn&#39;t have the WB flag, so INV has to be used instead.</span></div><=
div><span style=3D"color:windowtext">2) to hide bugs<br></span></div><div><=
span style=3D"color:windowtext"><br></span></div><div><span style=3D"color:=
windowtext">Marek<br></span></div></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 29, 2020 at 7:24 AM Liu, Monk=
 &lt;<a href=3D"mailto:Monk.Liu@amd.com">Monk.Liu@amd.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">





<div bgcolor=3D"white" lang=3D"EN-US">
<div class=3D"gmail-m_-2967598555427486213WordSection1">
<p class=3D"MsoNormal"><span style=3D"color:windowtext">&gt;&gt;</span> Wel=
l from my understanding I think that a G2LC invalidation is still necessary=
 before an IB executes.<u></u><u></u></p>
<p class=3D"MsoNormal">Agree, I think before an IB executes the only thing =
we need on GL2C is the invalidation, not the flush .<u></u><u></u></p>
<p class=3D"MsoNormal"><br>
&gt;&gt; The problem is that the memory of the IB could also be cached beca=
use of some activity of the GFX or Compute rings.<u></u><u></u></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">If we always insert=
 a GL2C invalidate at every EOP of every IB from every engine, why we need =
a GL2C invalidate before IB=C2=A0 execute ?<u></u><u></u></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">___________________=
__________________<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12pt;background:white none =
repeat scroll 0% 0%">Monk Liu|GPU Virtualization Team |</span><span style=
=3D"font-size:12pt;color:rgb(200,38,19);border:1pt none windowtext;padding:=
0in;background:white none repeat scroll 0% 0%">AMD<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext"><img style=3D"width=
: 0.8333in; height: 0.8333in;" id=3D"gmail-m_-2967598555427486213_x0000_i10=
27" src=3D"cid:171d0f0a62b4cff311" alt=3D"sig-cloud-gpu" width=3D"80" heigh=
t=3D"80"><u></u><u></u></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"color:windowtext"><u></u>=C2=A0<u></u=
></span></p>
<div>
<div style=3D"border-color:rgb(225,225,225) currentcolor currentcolor;borde=
r-style:solid none none;border-width:1pt medium medium;padding:3pt 0in 0in"=
>
<p class=3D"MsoNormal"><b><span style=3D"color:windowtext">From:</span></b>=
<span style=3D"color:windowtext"> Koenig, Christian &lt;<a href=3D"mailto:C=
hristian.Koenig@amd.com" target=3D"_blank">Christian.Koenig@amd.com</a>&gt;
<br>
<b>Sent:</b> Wednesday, April 29, 2020 5:38 PM<br>
<b>To:</b> Liu, Monk &lt;<a href=3D"mailto:Monk.Liu@amd.com" target=3D"_bla=
nk">Monk.Liu@amd.com</a>&gt;; Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:m=
araeo@gmail.com" target=3D"_blank">maraeo@gmail.com</a>&gt;; amd-gfx mailin=
g list &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blan=
k">amd-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Subject:</b> Re: drm/amdgpu: invalidate L2 before SDMA IBs (on gfx10)<u>=
</u><u></u></span></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<p class=3D"MsoNormal">Well from my understanding I think that a G2LC inval=
idation is still necessary before an IB executes.<br>
<br>
The problem is that the memory of the IB could also be cached because of so=
me activity of the GFX or Compute rings.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 29.04.20 um 11:35 schrieb Liu, Monk:<u></u><u></u></p>
</div>
<blockquote style=3D"margin-top:5pt;margin-bottom:5pt">
<p class=3D"MsoNormal">Here is the reason we should always insert a =E2=80=
=9Csync mem=E2=80=9D packet at the FENCE place of SDMA, not before IB emit.=
<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal">By always inserting =E2=80=9Csync mem=E2=80=9D in th=
e FENCE place we can make sure:1<u></u><u></u></p>
<ol style=3D"margin-top:0in" type=3D"1" start=3D"1">
<li class=3D"gmail-m_-2967598555427486213MsoListParagraph" style=3D"margin-=
left:0in">data is really flushed to system memory before CPU try to read it
<u></u><u></u></li><li class=3D"gmail-m_-2967598555427486213MsoListParagrap=
h" style=3D"margin-left:0in">all the G2LC is invalidated by =E2=80=9Csync m=
em=E2=80=9D, thus in the next round SDMA IB, it won=E2=80=99t get staled da=
ta from G2LC cache
<u></u><u></u></li></ol>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal">by inserting =E2=80=9Csync mem=E2=80=9D in prior to =
IB could only achieve :=C2=A0 Avoid get staled data in g2lc during IB execu=
tion
<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal">for GFX/COMPUTE ring since they have release_mem pac=
ket so it is inherently doing the G2LC flush and invalidate upon a fence si=
gnaled
<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<div>
<p class=3D"MsoNormal">_____________________________________<u></u><u></u><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:12pt;background:white none =
repeat scroll 0% 0%">Monk Liu|GPU Virtualization Team |</span><span style=
=3D"font-size:12pt;color:rgb(200,38,19);border:1pt none windowtext;padding:=
0in;background:white none repeat scroll 0% 0%">AMD</span><u></u><u></u></p>
<p class=3D"MsoNormal"><img style=3D"width: 0.8333in; height: 0.8333in;" id=
=3D"gmail-m_-2967598555427486213_x0000_i1025" src=3D"cid:171d0f0a62b4cff311=
" alt=3D"sig-cloud-gpu" width=3D"80" height=3D"80"><u></u><u></u></p>
</div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<div>
<div style=3D"border-color:rgb(225,225,225) currentcolor currentcolor;borde=
r-style:solid none none;border-width:1pt medium medium;padding:3pt 0in 0in"=
>
<p class=3D"MsoNormal"><b>From:</b> Liu, Monk <br>
<b>Sent:</b> Wednesday, April 29, 2020 5:06 PM<br>
<b>To:</b> &#39;Marek Ol=C5=A1=C3=A1k&#39; <a href=3D"mailto:maraeo@gmail.c=
om" target=3D"_blank">&lt;maraeo@gmail.com&gt;</a>; amd-gfx mailing list
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">&lt;amd-=
gfx@lists.freedesktop.org&gt;</a>; Koenig, Christian
<a href=3D"mailto:Christian.Koenig@amd.com" target=3D"_blank">&lt;Christian=
.Koenig@amd.com&gt;</a><br>
<b>Subject:</b> RE: drm/amdgpu: invalidate L2 before SDMA IBs (on gfx10)<u>=
</u><u></u></p>
</div>
</div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal">Hi <a id=3D"gmail-m_-2967598555427486213OWAAM709EE8E=
0E6054CD48698E878A98E9795" href=3D"mailto:Christian.Koenig@amd.com" target=
=3D"_blank">
<span style=3D"font-family:&quot;Calibri&quot;,sans-serif;text-decoration:n=
one">@Koenig, Christian</span></a> &amp; Marek<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal">I still have some concerns regarding Marek=E2=80=99s=
 patch, correct me if I=E2=80=99m wrong<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal">See that Marek put a SDMA_OP_GCR_REQ before emitting=
 IB, to make sure SDMA won=E2=80=99t get stale cache data during the IB exe=
cution.<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal">But that =E2=80=9CSDMA_OP_GCR_REQ=E2=80=9D only inva=
lidate/flush the GFXHUB=E2=80=99s G2LC cache right ? =C2=A0what if the memo=
ry is changed by MM or CPU (out side of GFXHUB) ?<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal">Can this =E2=80=9C SDMA_OP_GCR_REQ=E2=80=9D force MM=
HUB or even CPU to flush their operation result from their cache to memory =
??<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal">Besides, with my understanding the =E2=80=9CEOP=E2=
=80=9D of gfx ring is doing the thing of =E2=80=9Cinvalidate/flush=E2=80=9D=
 L2 cache upon a fence signaled, so what we should do on SDMA5 is to insert=
 this =E2=80=9CSDMA_OP_GCR_REQ=E2=80=9D<u></u><u></u></p>
<p class=3D"MsoNormal">Right before thee =E2=80=9Cemit_fence=E2=80=9D of SD=
MA =C2=A0(this is what windows KMD do)<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal">thanks <u></u><u></u></p>
<p class=3D"MsoNormal">_____________________________________<u></u><u></u><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:12pt;background:white none =
repeat scroll 0% 0%">Monk Liu|GPU Virtualization Team |</span><span style=
=3D"font-size:12pt;color:rgb(200,38,19);border:1pt none windowtext;padding:=
0in;background:white none repeat scroll 0% 0%">AMD</span><u></u><u></u></p>
<p class=3D"MsoNormal"><img style=3D"width: 0.8333in; height: 0.8333in;" id=
=3D"gmail-m_-2967598555427486213Picture_x0020_1" src=3D"cid:171d0f0a62b4cff=
311" alt=3D"sig-cloud-gpu" width=3D"80" height=3D"80" border=3D"0"><u></u><=
u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-b=
ounces@lists.freedesktop.org" target=3D"_blank">amd-gfx-bounces@lists.freed=
esktop.org</a>&gt;
<b>On Behalf Of </b>Marek Ol?=C3=A1k<br>
<b>Sent:</b> Saturday, April 25, 2020 4:52 PM<br>
<b>To:</b> amd-gfx mailing list &lt;<a href=3D"mailto:amd-gfx@lists.freedes=
ktop.org" target=3D"_blank">amd-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Subject:</b> drm/amdgpu: invalidate L2 before SDMA IBs (on gfx10)<u></u>=
<u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<div>
<div>
<p class=3D"MsoNormal">This should fix SDMA hangs on gfx10.<u></u><u></u></=
p>
</div>
<div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Marek<u></u><u></u></p>
</div>
</div>
</blockquote>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
</div>

</blockquote></div>

--00000000000072ae7e05a498525a--

--00000000000072ae8005a498525b
Content-Type: image/png; name="image001.png"
Content-Disposition: inline; filename="image001.png"
Content-Transfer-Encoding: base64
Content-ID: <171d0f0a62b4cff311>
X-Attachment-Id: 171d0f0a62b4cff311

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
--00000000000072ae8005a498525b--

--===============1243171157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1243171157==--
