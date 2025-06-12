Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8973BC71136
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 16:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A42810EA2C;
	Fri, 13 Jun 2025 16:05:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="crHW6Biq";
	dkim-atps=neutral
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com
 [209.85.166.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A40010E7DB
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jun 2025 11:39:19 +0000 (UTC)
Received: by mail-il1-f172.google.com with SMTP id
 e9e14a558f8ab-3da73df6c4eso7597355ab.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jun 2025 04:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749728359; x=1750333159; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PCOz4PfRNVidWG0sb2TX8rQEoecZym1UbMZof1PogXY=;
 b=crHW6BiqRbloz7Qqwgua6Kk88ZLyIu67g+8MqSUwgnM1RwGBTrth/jvRMYUoUC1EAn
 we7rFIHfvSIuFIQMKDQgmWXRfRZNvY4gaZWUxKY0vFiixpBnSa+OAlpX2lgUZTd3gRwK
 nvetNhyI5Op17FsLz08692kPhY1UMRcECCLwbvPEKeL9XsiChsQAuLnr8HY3jp2bHT0A
 iGVSS4iZYEtuFbMg/uq80lvbs+UO6njzS6r9XbrPV83+DMqDGEZYUSY3ckcaXy+RFE+7
 +4nTDXOq5p/5JWAx8V4TmVUOJu+z5Srf7H2YPPbr4kTpR3ueeMPQY+/dYV0PI8hrP4ac
 Yqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749728359; x=1750333159;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PCOz4PfRNVidWG0sb2TX8rQEoecZym1UbMZof1PogXY=;
 b=KRrihaS8nDIHJZ4NIgBr7FTUJYLVENDbQfuyESSD32vEDhHHKhUHSV7h2zwjedIPfC
 1nAbVAG4116ptPzDvMf4d/1zLFckpowAikk2PLk5J/UBzTqlIGZY2Dp5p80HuPIPjMlj
 aVmICL19s3Sc0+oGqgJAqQMI5o4IMdXUW31AO7haT6+LMYpEF1n06uuZlNFUPr3Vf8Ir
 Fi4Kb8tcD+IJaVd1scdMw7vSd6Tqpv/w9tu/4xf/S/FlVtmok4t7eAD10Zu7c25iyyNF
 idvBoAmfrUiPuUfO5B21xBKKy/K67qmwBzWysqvbQa8pV6LQqOc/7mM4g4mQoJcLA1Gg
 bbww==
X-Gm-Message-State: AOJu0Yx/pUbUIejgAkb425klcAC1meFz5HhcLLRXHlc3KNXlS6TAaXwg
 MqS3WqPSAES5bYsiRILzcoL9Vek4dC7S4DWPqpzEyAY8x4R2hCgIyo6W0cS8q2S/E2oPIbfG0Dl
 uk5MP4oGth4tsMi6URHn+VKu0OtjpL4+CCA==
X-Gm-Gg: ASbGncv/BWxX0gOcl1prsx0XwBZqdHhwKTFkyIoXcJmWvzSEM1XsyETIO5FjvF0uqRv
 nrnH9m03YhcuIBDp6FZMw7QG41GxbBpsLIglScU6qihwu4eATNw0oLwNUQa1ChB4mLvbzx79WKx
 iGnpUWw3Xtp9BE1Eln0V0uZQp/aT9FVr60fyXGGBIhcg==
X-Google-Smtp-Source: AGHT+IHBKTMeZsDdPYi7Uddixo8364nYgdkyC8Ma2FDPjv2OZyck+9CuW5HbqpIz6hxQdTDDWvZ53GGV4avk3pj7nJU=
X-Received: by 2002:a05:6e02:1525:b0:3dc:87c7:a5b5 with SMTP id
 e9e14a558f8ab-3ddf42261cbmr80833225ab.3.1749728358766; Thu, 12 Jun 2025
 04:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <CABH-8xf3sg1CiHWM9nN0a3eSRTF9Lc_vkcZDzbvWZAH0f+Gf2g@mail.gmail.com>
 <CADnq5_MYFt1fS4m3gn-TDSbAot2DpXDZtt0f3DFWJKoPXr3-zg@mail.gmail.com>
 <CABH-8xcnpQ65SZDJJxPmqWP1g_2miQ=1R=OUyJXpO-NKkc7JUw@mail.gmail.com>
In-Reply-To: <CABH-8xcnpQ65SZDJJxPmqWP1g_2miQ=1R=OUyJXpO-NKkc7JUw@mail.gmail.com>
From: =?UTF-8?Q?Durmu=C5=9F?= <dozaltay@gmail.com>
Date: Thu, 12 Jun 2025 14:39:08 +0300
X-Gm-Features: AX0GCFsueeIe4WV6nA2EwbX6mj27FDVXlBRbVEXRfDIcDCrbGrXvnchA0VgsRKI
Message-ID: <CABH-8xcryfAu+Lkf9bYjE4Vw6ToDN+-A4MRqM6pn+a5kHtGn7g@mail.gmail.com>
Subject: Re: Regression: RX 470 fails to boot with amdgpu.dpm=1 on kernel 6.7+
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000471ed306375e6116"
X-Mailman-Approved-At: Fri, 13 Jun 2025 16:05:52 +0000
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

--000000000000471ed306375e6116
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

i hope you can see the image, i cant on fhe phone. i tried to install arch
with archinstall script and tried latest zen kernel but result is same. it
stuck [drm] VCE enabled in VM mode. i tried  to add grub:
amdgpu.dc=3D0 amdgpu.si_support=3D1 radeon.si_support=3D0 amdgpu.dpm=3D1
amdgpu.vm_fragment_size=3D9 amd_iommu=3Doff but didn't work

On Thu, Jun 12, 2025, 14:29 Durmu=C5=9F <dozaltay@gmail.com> wrote:

>
> i added debug option and this is where to stuck
>
> On Fri, May 30, 2025, 23:29 Alex Deucher <alexdeucher@gmail.com> wrote:
>
>> On Thu, May 22, 2025 at 11:10=E2=80=AFAM Durmu=C5=9F <dozaltay@gmail.com=
> wrote:
>> >
>> > Hello,
>> >
>> > I'm experiencing a critical issue on my system with an AMD RX 470 GPU.
>> > When booting with recent kernel versions (6.7.x or newer), the system
>> > fails to boot properly unless I explicitly disable Dynamic Power
>> > Management (DPM) via the `amdgpu.dpm=3D0` kernel parameter.
>> >
>> > When DPM is enabled (`amdgpu.dpm=3D1` or omitted, since it's the
>> > default), the system either freezes during early boot or fails to
>> > initialize the display. However, using the LTS kernel (6.6.x),
>> > everything works as expected with DPM enabled.
>>
>> Are you still having an issue with newer kernels?  E.g., 6.14 or 6.15?
>>  I haven't seen any problems with polaris boards here.  If 6.6.x
>> works, but 6.7 does not, can you bisect?
>>
>> Alex
>>
>> >
>> > This seems to be a regression introduced in kernel 6.7 or later, and
>> > it specifically affects older GCN4 (Polaris) GPUs like the RX 470.
>> > Disabling DPM allows the system to boot, but significantly reduces GPU
>> > performance.
>> >
>> > Things I=E2=80=99ve tried:
>> > - Confirmed that the latest `linux-firmware` is installed.
>> > - Verified correct firmware files exist under `/lib/firmware/amdgpu/`.
>> > - Tested multiple kernels (mainline and LTS).
>> > - Using Mesa with ACO (Radeon open driver stack).
>> > - System boots fine with LTS kernel (6.6.x) + DPM enabled.
>> >
>> > System info:
>> > - GPU: AMD RX 470 (GCN 4 / Polaris)
>> > - Distro: Arch Linux
>> > - Kernel (working): linux-lts 6.6.x
>> > - Kernel (broken): 6.7.x and newer (currently tested on 6.14.6)
>> >
>> > Thanks in advance,
>> > Durmus Ozaltay
>>
>

--000000000000471ed306375e6116
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">i hope you can see the image, i cant on fhe phone. i tried t=
o install arch with archinstall script and tried latest zen kernel but resu=
lt is same. it stuck [drm] VCE enabled in VM mode. i tried=C2=A0 to add gru=
b:<br>
amdgpu.dc=3D0 amdgpu.si_support=3D1 radeon.si_support=3D0 amdgpu.dpm=3D1 am=
dgpu.vm_fragment_size=3D9 amd_iommu=3Doff but didn&#39;t work<br>
</p>
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Jun 12, 2025, 14:29 Durmu=C5=9F &lt;<a href=3D"mail=
to:dozaltay@gmail.com">dozaltay@gmail.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex"><div dir=3D"auto"><img style=3D"max-width:100%;height=
:auto"><br>i added debug option and this is where to stuck</div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 30, 2=
025, 23:29 Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com" target=
=3D"_blank" rel=3D"noreferrer">alexdeucher@gmail.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, May 22, 2025 at=
 11:10=E2=80=AFAM Durmu=C5=9F &lt;<a href=3D"mailto:dozaltay@gmail.com" rel=
=3D"noreferrer noreferrer" target=3D"_blank">dozaltay@gmail.com</a>&gt; wro=
te:<br>
&gt;<br>
&gt; Hello,<br>
&gt;<br>
&gt; I&#39;m experiencing a critical issue on my system with an AMD RX 470 =
GPU.<br>
&gt; When booting with recent kernel versions (6.7.x or newer), the system<=
br>
&gt; fails to boot properly unless I explicitly disable Dynamic Power<br>
&gt; Management (DPM) via the `amdgpu.dpm=3D0` kernel parameter.<br>
&gt;<br>
&gt; When DPM is enabled (`amdgpu.dpm=3D1` or omitted, since it&#39;s the<b=
r>
&gt; default), the system either freezes during early boot or fails to<br>
&gt; initialize the display. However, using the LTS kernel (6.6.x),<br>
&gt; everything works as expected with DPM enabled.<br>
<br>
Are you still having an issue with newer kernels?=C2=A0 E.g., 6.14 or 6.15?=
<br>
=C2=A0I haven&#39;t seen any problems with polaris boards here.=C2=A0 If 6.=
6.x<br>
works, but 6.7 does not, can you bisect?<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt; This seems to be a regression introduced in kernel 6.7 or later, and<b=
r>
&gt; it specifically affects older GCN4 (Polaris) GPUs like the RX 470.<br>
&gt; Disabling DPM allows the system to boot, but significantly reduces GPU=
<br>
&gt; performance.<br>
&gt;<br>
&gt; Things I=E2=80=99ve tried:<br>
&gt; - Confirmed that the latest `linux-firmware` is installed.<br>
&gt; - Verified correct firmware files exist under `/lib/firmware/amdgpu/`.=
<br>
&gt; - Tested multiple kernels (mainline and LTS).<br>
&gt; - Using Mesa with ACO (Radeon open driver stack).<br>
&gt; - System boots fine with LTS kernel (6.6.x) + DPM enabled.<br>
&gt;<br>
&gt; System info:<br>
&gt; - GPU: AMD RX 470 (GCN 4 / Polaris)<br>
&gt; - Distro: Arch Linux<br>
&gt; - Kernel (working): linux-lts 6.6.x<br>
&gt; - Kernel (broken): 6.7.x and newer (currently tested on 6.14.6)<br>
&gt;<br>
&gt; Thanks in advance,<br>
&gt; Durmus Ozaltay<br>
</blockquote></div>
</blockquote></div>

--000000000000471ed306375e6116--
