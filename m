Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21633C28D13
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Aug 2022 13:26:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A11818BC8E;
	Mon, 22 Aug 2022 13:26:19 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DFF28BC48
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 13:26:10 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 r1-20020a056830418100b0063938f634feso468212otu.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 06:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc;
 bh=Ym2QzmSxSPQA0jLV20ijGnKp3r/sDU7UD8wRIA7GeIA=;
 b=RtPv6N22xaI/d9dzhRIhNw3YeXorMNe5GzyfPOhEGzaaF2dAYTkjHpFltNhFp0RSqd
 q9rYzexLxugyIsO2x53ODz38+TOp/3tDqnaP0H5hxOu/Asg5ZLK50kWJmB24mVEtllJm
 2CfYV9ZH/3lUVJLRBUsoAutxWJLorv0kKEe2I0O3Rkjui34Bv6aiZCxBseO6UpygB2Ve
 nCpWOjJF/SQVPMC4Y7UbQFn6RuScxKpPzR4oKYCPfnEhDNtCLWqfpmeeKftCJMyLNiC0
 krY63V0p5OuHCZyrdsBEcS2VZnovOpZzyXPmrDMPhmK/Sr+YfHVDrPlPTNHdEkXQu3JU
 ooow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=Ym2QzmSxSPQA0jLV20ijGnKp3r/sDU7UD8wRIA7GeIA=;
 b=NQpHG9JcbPj688spQn+eMtpItDCx/mHmsYTyJYKUwQr/LJp0srDlUwfZ966+6DqK+y
 Tx9wvbMx6QLDrKaRTUx+dIaUQJtta4bwKiXTiorDXVQjpeBAj0RLGVBSmOozgV4wGm6x
 CBKIvonSWCv4uUh2kOXZxSh6fqzKORT77SyTeSb+Olcm4EIAH77DpNBV9PXYePIxsLZ4
 nyTDutOagtIPU99FwtDL0ZWZ84MHq83ye/wKkGglwcQJ4EYuvaXKEoRWg/qrQWozf2Aj
 iaKd6LYxE/I2OTW+dQLboiA6eu5X+WkogdNuwgN9b8PsdrawmW/yP0S8rBZjJrgfcEL4
 AxIw==
X-Gm-Message-State: ACgBeo3gneNb+OGdPh/DnqnZ7+EM5IG+03wX6tyBADe5rqTnQ4+CYx9q
 SrZq5aqekvydeePX6A4uj39iazep13LnGnUfwRQ=
X-Google-Smtp-Source: AA6agR6fIwYQLQA0UEzaoTlFtW4K1uUElNhZBbe2qtBiw6a7KmwOhl3QnGK9LpKBChlrOkGgXiwhGgymIDuXQNEzjso=
X-Received: by 2002:a9d:c64:0:b0:636:df4c:e766 with SMTP id
 91-20020a9d0c64000000b00636df4ce766mr7865469otr.12.1661174769791; Mon, 22 Aug
 2022 06:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAA6RncSwQL5A1Ox3a088Kpp4=-bHPzAGcJa_fEFkiE801tAJjw@mail.gmail.com>
In-Reply-To: <CAA6RncSwQL5A1Ox3a088Kpp4=-bHPzAGcJa_fEFkiE801tAJjw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 Aug 2022 09:25:58 -0400
Message-ID: <CADnq5_OtoCCCEEgdVnJEZYHYsJUHi=9yCUTdHr5EA13aDsk3mA@mail.gmail.com>
Subject: Re: No Audio from AMDGPU HDMI on 5.19.2
To: =?UTF-8?B?6I+c5Y+2?= <ye.jingchen@gmail.com>, 
 Martin Leung <Martin.Leung@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org, regressions@lists.linux.dev,
 stable@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

+ Martin, Rodrigo

On Mon, Aug 22, 2022 at 3:18 AM =E8=8F=9C=E5=8F=B6 <ye.jingchen@gmail.com> =
wrote:
>
> Hello,
>
> I experienced this issue on Arch Linux 5.19.2-arch1-1 kernel on an HP
> laptop with AMD Ryzen 6850HS CPU (detailed spec below), that the audio
> is completely silent on the HDMI connected monitor. KDE audio settings
> says everything works normally, HDMI audio shows up and can be
> selected as the default output, just no sound from it.
>
> It worked fine on Arch kernel v5.19.1-arch2. Laptop speakers always
> work, and the monitor works when connected to another Windows laptop
> over HDMI, so the monitor isn't the culprit I assume.
>
> Kernel log from the journal didn't seem to contain something relevant,
> but it may be me not knowing what to look for.
>
> This is discovered on Arch Linux kernel 5.19.2-arch1-1, but also
> reproducible on vanilla v5.19.2 tag.
>
> Bisecting between tag v5.19.1 and v5.19.2 in the stable tree gives:
> 308d0d5d98c294b1185d6d7da60b268e0fe30193 is the first bad commit
> commit 308d0d5d98c294b1185d6d7da60b268e0fe30193
> Author: Leung, Martin <Martin.Leung@amd.com>
> Date:   Fri May 13 17:40:42 2022 -0400
>
>    drm/amdgpu/display: Prepare for new interfaces
>
>    [ Upstream commit a820190204aef0739aa3a067d00273d117f9367c ]
>
> Anything else I can do to investigate?
>
> My hardware spec:
> Laptop: HP EliteBook 845 14 inch G9 Notebook PC
> CPU: AMD Ryzen 7 PRO 6850HS with Radeon Graphics
> GPU: VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
> Rembrandt [Radeon 680M]
>
> % lspci | grep -i audio
> 63:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Rembrandt
> Radeon High Definition Audio Controller
> 63:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD]
> ACP/ACP3X/ACP6x Audio Coprocessor (rev 60)
> 63:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family
> 17h/19h HD Audio Controller
>
> Software:
> plasma-desktop 5.25.4-1
> plasma-pa 5.25.4-1
> pipewire 1:0.3.56-1
> pipewire-pulse 1:0.3.56-1
> wireplumber 0.4.11-4
> alsa-card-profiles 1:0.3.56-1
> linux-firmware 20220708.be7798e-1
> sof-firmware 2.2-1
