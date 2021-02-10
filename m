Return-Path: <SRS0=kdbD=HM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CACDC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 21:08:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E387664E38
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 21:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E387664E38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FF766ECDE;
	Wed, 10 Feb 2021 21:08:10 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ADD86ECDE
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Feb 2021 21:08:09 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id y8so4682579ede.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Feb 2021 13:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=92IqTu+2EncshmUr4dtayaUeoAhDJ7ItIlNqse3Poc8=;
 b=igiy7V+lVOV4FnE9iuPZNqpMBs/UUTa8kMzyH+FBvmWuMmnesFkZZNVSNUZ76TCSiP
 VBofe9uMjDFH9ANZlEN0yAHrBuOQi++DpcL8ACKxbFnBfhoQJr/1z43ALzjNLiNAC1mx
 IxDW5H6LQkCDDsMMfbTNmYoCr37mwg0Bf4bKSv9rJohQxXg9hUxmwNnTYxxwUVta6ibV
 d29FfkHkdyyyYYYo7GlOIZVlATiT7QsMamAz+nLpU3txsncVq0ArMWPqfR/uSo9zF2NM
 XlTUuR+vXlwuYaEk7EeVB6YWDG+arUMlTOeoEGymNPF7f2j9wyG0YKpn9qO5+OQtJPmm
 jNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=92IqTu+2EncshmUr4dtayaUeoAhDJ7ItIlNqse3Poc8=;
 b=Yzm37KzyyqQvMjGrI6kjnxO2FhLB56d06AJ9FLENA7uIEA872z5uuEh4gA90CX/A7Q
 F1jbFOaosqwyWeI6d9PzsDOJ5P4KuxsLz5EgaYPniyAFj6iTI0wKCx+GjL2e/QyK0CWk
 26kVobtJMaiQzVzMBPh9ExuJJtDU7bV+38GBAtdyWLTltYRfMfcVaJQJ9XtqWJD+1wE5
 eBHNXIBvQE2M+GeFox+g+r4m82YPsbiKzDtLizWkjAvhkOglaN19is8KVFW0/cEOhog6
 EtYI1KPydxQuYo1npVmq8xgzZLHaaGkvz37CY2Jx2/gPqPmhCxb0IaE2vOtgtVYzvy/Y
 HcYg==
X-Gm-Message-State: AOAM530IqG7+WQeFUkgQKtRi98PzsnQdNvFKZ6HOTxQ0oOVYDIN9B+++
 DyN9aDJtHbyOQwBszdQEscmWlgOWerhHh45lSxguayNc
X-Google-Smtp-Source: ABdhPJwBcleT7C6cNOTUxmSOi/qTDVmWV1ZWX0eWNkaCfzulrSo5kguFsJa3LX6Qsr8FLYDM9RpUomF/cXmupXm+l1g=
X-Received: by 2002:a50:d4d9:: with SMTP id e25mr5074990edj.183.1612991288100; 
 Wed, 10 Feb 2021 13:08:08 -0800 (PST)
MIME-Version: 1.0
References: <CAEsyxyj9ArbpxWQttLhBZzU1mR_Fz=hRt1p52yMuwdmToZwuGA@mail.gmail.com>
In-Reply-To: <CAEsyxyj9ArbpxWQttLhBZzU1mR_Fz=hRt1p52yMuwdmToZwuGA@mail.gmail.com>
From: Mario Kleiner <mario.kleiner.de@gmail.com>
Date: Wed, 10 Feb 2021 22:07:56 +0100
Message-ID: <CAEsyxyjPUmXGWpQDbr6E0Wccd0PvxATLPoZKE0zZ1gwPZSoLAQ@mail.gmail.com>
Subject: Re: Why no spatial dithering to 10 bit depth on DCE?
To: Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Content-Type: multipart/mixed; boundary="===============0736232681=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0736232681==
Content-Type: multipart/alternative; boundary="000000000000c0caea05bb01cc15"

--000000000000c0caea05bb01cc15
Content-Type: text/plain; charset="UTF-8"

Resending this one as well, in the hope of some clarification or background
information.

Thanks,
-mario

On Mon, Jan 25, 2021 at 3:56 AM Mario Kleiner <mario.kleiner.de@gmail.com>
wrote:

> Hi Harry and Nicholas,
>
> I'm still on an extended quest to squeeze as much HDR out of Linux + your
> hw as possible, although the paid contract with Vesa has officially ended
> by now, and stumbled over this little conundrum:
>
> DC's set_spatial_dither() function (see link below) has this particular
> comment:
> "/* no 10bpc on DCE11*/" followed by code that skips dithering setup if
> the target output depth is 10 bpc:
>
>
> https://elixir.bootlin.com/linux/v5.11-rc4/source/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c#L219
>
> I couldn't find any hint in the commit messages towards the reason, so why
> is that?
>
> This gets in the way if one has a HDR-10 monitor with 10 bit native output
> depth connected and wants to output a fp16 framebuffer and retain some of
> the > 10 bit linear precision by use of spatial dithering down to 10 bit.
> One only gets the same precision as a 10 bpc unorm fb. Also the routine is
> called for all DCE's, not only DCE11, so it affects all of them.
>
> The same restrictions don't exist in the old kms code for amdgpu-kms and
> radeon-kms. I added a mmio hack to Psychtoolbox to go behind the drivers
> back and hack the FMT_BIT_DEPTH_CONTROL register to use spatial dithering
> down to 10 bpc anyway to circumvent this limitation. My photometer
> measurements on fp16 framebuffers feeding into 10 bit output show that I
> get a nice looking response consistent with dithering to 10 bpc properly
> working on DCE. Also i don't see any visual artifacts in displayed
> pictures, so the hw seems to be just fine. This on DCE-11.2, and more
> lightly tested on DCE-8.3.
>
> So i wonder if this is some leftover from some hw bringup, or if there is
> a good reason for it being there? Maybe it could be removed or made more
> specific to some problematic asic?
>
> Thanks for any insights you could provide. Stay safe,
> -mario
>
>

--000000000000c0caea05bb01cc15
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Resending this one as well, in the hope of some clarificat=
ion or background information.<div><br></div><div>Thanks,</div><div>-mario<=
/div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_a=
ttr">On Mon, Jan 25, 2021 at 3:56 AM Mario Kleiner &lt;<a href=3D"mailto:ma=
rio.kleiner.de@gmail.com">mario.kleiner.de@gmail.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>H=
i Harry and Nicholas,</div><div><br></div><div>I&#39;m still on an extended=
 quest to squeeze as much HDR out of Linux + your hw as possible, although =
the paid contract with Vesa has officially ended by now, and stumbled over =
this little conundrum:</div><div><br></div><div>DC&#39;s set_spatial_dither=
() function (see link below) has this particular comment:</div><div>&quot;<=
span>/* no 10bpc on DCE11*/</span>&quot; followed by code that skips dither=
ing setup if the target output depth is 10 bpc:<br></div><div><br></div><di=
v><a href=3D"https://elixir.bootlin.com/linux/v5.11-rc4/source/drivers/gpu/=
drm/amd/display/dc/dce/dce_opp.c#L219" target=3D"_blank">https://elixir.boo=
tlin.com/linux/v5.11-rc4/source/drivers/gpu/drm/amd/display/dc/dce/dce_opp.=
c#L219</a></div><div><br></div><div>I couldn&#39;t find any hint in the com=
mit messages towards the reason, so why is that?</div><div><br></div><div>T=
his gets in the way if one has a HDR-10 monitor with 10 bit native output d=
epth connected and wants to output a fp16 framebuffer and retain some of th=
e &gt; 10 bit linear precision by use of spatial dithering down to 10 bit. =
One only gets the same precision as a 10 bpc unorm fb. Also the routine is =
called for all DCE&#39;s, not only DCE11, so it affects all of them.</div><=
div><br></div><div>The same restrictions don&#39;t exist in the old kms cod=
e for amdgpu-kms and radeon-kms. I added a mmio hack to Psychtoolbox to go =
behind the drivers back and hack the FMT_BIT_DEPTH_CONTROL register to use =
spatial dithering down to 10 bpc anyway to circumvent this limitation. My p=
hotometer measurements on fp16 framebuffers feeding into 10 bit output show=
 that I get a nice looking response consistent with dithering to 10 bpc pro=
perly working on DCE. Also i don&#39;t see any visual artifacts in displaye=
d pictures, so the hw seems to be just fine. This on DCE-11.2, and more lig=
htly tested on DCE-8.3.<br></div><div><br></div><div>So i wonder if this is=
 some leftover from some hw bringup, or if there is a good reason for it be=
ing there? Maybe it could be removed or made more specific to some problema=
tic asic?<br></div><div><br></div><div>Thanks for any insights you could pr=
ovide. Stay safe,<br></div><div>-mario</div><div><br></div></div>
</blockquote></div>

--000000000000c0caea05bb01cc15--

--===============0736232681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0736232681==--
