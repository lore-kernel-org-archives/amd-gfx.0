Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DFBC0044D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 09:43:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C31B6205ED
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 09:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9Ep0j82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31B6205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 812986E3B2;
	Mon, 16 Mar 2020 09:43:57 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA08E6E3B2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 09:43:55 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id z12so8006779wmf.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 02:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lWuPLCvhKj9YgizRCsI8V86lyKIIkbUz+YyixAJ1cJc=;
 b=F9Ep0j82Ath/IRpitWLZ1SnKWcO2MUz7OO2mCOBgBVTnF6XEbgRHbbFFADranjVBi1
 L7BnMK7d0qaveRfMuoEcX0//kqnb2xJwdrjqSRll53wyhOYn93DHslsAbYY5vslJxmdg
 vfS/YFlcKr8Bu6bR2de0tty5QFRtj79/PDG2tZoA4JtUSqbJHKHs6zFQNoTgRzGrQ6fU
 r6GWu7EkAx+M+bXrGp6ghGPgZoA2pwvIeexOwMr8E23YUEMbP2P1Sk81O0Hy3/5lHkvA
 1USoLVYEqUS4+Mw9yT9hlaUAupi/lhBuZ0pdiT8si0/yxz09AWT5I/jiLgoI4kZgAC2Z
 5arg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lWuPLCvhKj9YgizRCsI8V86lyKIIkbUz+YyixAJ1cJc=;
 b=bT86MxHUIE85/viQpA/gPCCDCcVhxPyn8Ry6hjrnfJz79o5rF3BOX4LnJhcmrm39g6
 RjBeuUJliZ6n8aRY7wgjm9cNNaTdjMBocQV4n3a2K+RLbo6AgC/uU7v3SN8d4dp+ilJE
 kjpjN+P1WgdgCsp+N3yhkBzjfQzeJ1N3KhnGRfTLvHNirIZBjOynMcnoh51ACiW6/39o
 9ALHVLGcMH84YIXIf391sjdgQIXl5Ld/RVLR1q08kribPLVOU2sVDWcQdhlsbLJVOVRj
 bZfqWsuqHEx3VwbZb5TvyKwwI6LPA5ngK/hNIKrM8hnbXiqyFgGIMkJ0y9t72BbQ7u0n
 VmDQ==
X-Gm-Message-State: ANhLgQ3SrEbpTdgnQ21Nx+wtzbD940ONKr+p3jkAdPTkNb+AT7UmLUyX
 7f5pjbpf/K7/ULKz8qMg/fZe1gx5g0hh69EAXU4etxtt
X-Google-Smtp-Source: ADFU+vs2hwqJRmn0x+hWw6UAzovjB+8pbJOg1LaMTaDvVS7gQ39p+Z++PmcasFTtej+MsD+C7sOczx/DbFzjeGKoKK0=
X-Received: by 2002:a1c:9904:: with SMTP id b4mr26992050wme.34.1584351834112; 
 Mon, 16 Mar 2020 02:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAEQFVGa9tzYgZeGLs5UY6yHfSHNZ0+Uqo3rTUzPjO+d7E2o-bA@mail.gmail.com>
 <ab79188c-70fd-5f35-71f6-bf6bcf773c94@amd.com>
 <CAEQFVGbBq4oags-e8MTNB9vtDaX_5Ayr7w+wN0tLN1xEBVVjcQ@mail.gmail.com>
In-Reply-To: <CAEQFVGbBq4oags-e8MTNB9vtDaX_5Ayr7w+wN0tLN1xEBVVjcQ@mail.gmail.com>
From: Mauro Rossi <issor.oruam@gmail.com>
Date: Mon, 16 Mar 2020 10:42:15 +0100
Message-ID: <CAEQFVGZxc0uGkk3NtaC33bV7bckDw80tubzrM-_VsZ=4WyYpGA@mail.gmail.com>
Subject: Re: Raven: freeze at 'modprobe amdgpu' in early console with
 android-x86
To: Felix Kuehling <felix.kuehling@amd.com>, "Yu, Qiang" <Qiang.Yu@amd.com>
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
Cc: Chih-Wei Huang <cwhuang@android-x86.org>, amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0340658486=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0340658486==
Content-Type: multipart/alternative; boundary="0000000000004586d705a0f5a840"

--0000000000004586d705a0f5a840
Content-Type: text/plain; charset="UTF-8"

Hi, good news,

'modprobe amdgpu' is finally working with Athlon 200GE, on a motherboard
MSI B450M-A Pro Max,
with latest raven linux-firmware bundle for 19.50

Mauro

On Tue, Feb 11, 2020 at 7:20 PM Mauro Rossi <issor.oruam@gmail.com> wrote:

> Hi Felix,
>
> On Mon, Jan 27, 2020 at 10:34 AM Felix Kuehling <felix.kuehling@amd.com>
> wrote:
> >
> > I've seen hangs on a Raven AM4 system after the Ubuntu upgrade to kernel
> > 5.3. I am able to work around it by disabling stutter mode with the
> > module parameter amdgpu.ppfeaturemask=0xfffdbfff. If that doesn't help,
> > you could also try disabling GFXOFF with amdgpu.ppfeaturemask=0xfffd3fff.
> >
> > Regards,
> >    Felix
>
> I have tried with the grub kernel cmdline mentioned, but the freeze is
> still happening at 'modprobe amdgpu'
>
> Is there an explicit list of kernel module dependencies that I could
> check in our kernel defconfig?
>
> I have also added Qiang, in case he may have ever seen the issue in
> his former Android experience
> KR
>
> Mauro
>

--0000000000004586d705a0f5a840
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi, good news,</div><div><br></div><div>&#39;modprobe=
 amdgpu&#39; is finally working with Athlon 200GE, on a motherboard MSI B45=
0M-A Pro Max,=C2=A0</div><div>with latest raven linux-firmware bundle for 1=
9.50</div><div><br></div><div>Mauro</div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 11, 2020 at 7:20 PM Mauro Ro=
ssi &lt;<a href=3D"mailto:issor.oruam@gmail.com">issor.oruam@gmail.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Fe=
lix,<br>
<br>
On Mon, Jan 27, 2020 at 10:34 AM Felix Kuehling &lt;<a href=3D"mailto:felix=
.kuehling@amd.com" target=3D"_blank">felix.kuehling@amd.com</a>&gt; wrote:<=
br>
&gt;<br>
&gt; I&#39;ve seen hangs on a Raven AM4 system after the Ubuntu upgrade to =
kernel<br>
&gt; 5.3. I am able to work around it by disabling stutter mode with the<br=
>
&gt; module parameter amdgpu.ppfeaturemask=3D0xfffdbfff. If that doesn&#39;=
t help,<br>
&gt; you could also try disabling GFXOFF with amdgpu.ppfeaturemask=3D0xfffd=
3fff.<br>
&gt;<br>
&gt; Regards,<br>
&gt;=C2=A0 =C2=A0 Felix<br>
<br>
I have tried with the grub kernel cmdline mentioned, but the freeze is<br>
still happening at &#39;modprobe amdgpu&#39;<br>
<br>
Is there an explicit list of kernel module dependencies that I could<br>
check in our kernel defconfig?<br>
<br>
I have also added Qiang, in case he may have ever seen the issue in<br>
his former Android experience<br>
KR<br>
<br>
Mauro<br>
</blockquote></div></div>

--0000000000004586d705a0f5a840--

--===============0340658486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0340658486==--
