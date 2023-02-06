Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD7DC05027
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 03:00:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A16010E1CB;
	Tue,  7 Feb 2023 03:00:11 +0000 (UTC)
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A75110E138
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 22:48:14 +0000 (UTC)
Date: Mon, 06 Feb 2023 22:48:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1675723692; x=1675982892;
 bh=NNxsv7LNVkYVwuCc8YpJqi6KhqDnVHT3qMDNOdRv03E=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=wDvmpajKWydnZIvK07ypLArT//YhOC3ifyxg4m1uFQEtYGjYNqlgYztjnubcJAXmv
 Bw/Au4V1YBJKAX+x65DqHcpuR8Ob8n9g4yoKCmE1qxyWIzuJhy3ytxPynRVeS1Lijn
 oSywJ3pDBHpgoE+949k8u7ncHNT6dwaqDriG7aRFyxA/8s5GvPhqbX+UyKpj+4wNzV
 5eBqIR4qDbMcYNWpOOe6QcWA1AHaQRv0W/8o9RP/AFoACLFOgTAbP0HludhWs4/i0k
 KA6Vh43H/RdlacKcFiAckyF04Kani99cVGWdHj8vXf+fsUZegtS9108ipT8RVA5Cz7
 EqLTq+HpwcTJA==
To: Alex Deucher <alexdeucher@gmail.com>
From: sfrcorne <sfrcorne@protonmail.com>
Subject: Re: gpu_metrics does not provide 'current_gfxclk', 'current_uclk',
 'average_cpu_power' & 'temperature_core' on AMD Ryzen 7000 CPU
Message-ID: <IGhLMOrDFqjKG7Ct93T4NCqIKeGLdSNO9Q5p3CkgzBVK15kInfRfGdv4aFCRJO3TmR2shr_bqjxYmlAgI3BojoM0F9q24Jv82FLmm2fvpp0=@protonmail.com>
In-Reply-To: <CADnq5_O__w5jkOoUALv96hybKP8qJs-=wcQAhcxy5kbiBg_vCw@mail.gmail.com>
References: <rEMJPv8L9uDl7PSSJ_OtbkCcM9ABocJ_Mk8DuSUQpaB2fPEPNB6EBBo7XLlCKqsfF5bCz5jvr9CFt1pVzb37_KZBldUNBMcf2-2B3xDNVN0=@protonmail.com>
 <CADnq5_O__w5jkOoUALv96hybKP8qJs-=wcQAhcxy5kbiBg_vCw@mail.gmail.com>
Feedback-ID: 66916551:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 07 Feb 2023 03:00:08 +0000
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Alex,

First of all, thank you for your response. Personally, I use a Ryzen 5 7600=
X however people with a Ryzen 9 7900X are also reporting this issue. The re=
levant bug report in Mangohud can be found here: "https://github.com/flight=
lessmango/MangoHud/issues/868".

I looked around a bit in both the Mangohud source code and the Linux kernel=
 source code.

(Mangohud source): From what I understand, Mangohud looks for a file "/sys/=
class/drm/card*/device/gpu_metrics". If this file exists (and it does exist=
s on my machine), it tries to read this file and extract the relevant GPU d=
ata (and in case of an APU also the CPU data) from it (these are the values=
 I was talking about in my previous mail). When the file "/sys/class/drm/ca=
rd*/device/gpu_metrics" exists, it will not use the data provided by hwmon =
(/sys/class/hwmon/hwmon*/*).

(Linux kernel): The gpu_metrics file contains different data, depending on =
what version is used. All valid versions can be found in the source code: "=
https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/include/=
kgd_pp_interface.h#L725". For my CPU/APU the 'gpu_metrics_v2_1' structure i=
s used (I tested this by reading the gpu_metrics file myself). Furthermore,=
 I think that for my case, this structure is set by the function "https://e=
lixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/pm/swsmu/smu13/sm=
u_v13_0_5_ppt.c#L459" but I am not completely sure about this.

Lastly, I am not familiar with umr. I assume that you are referring to "htt=
ps://gitlab.freedesktop.org/tomstdenis/umr"? If I find some time this weeke=
nd, then I will look into this some more.

Kind regards,
sfrcorne

------- Original Message -------
On Monday, February 6th, 2023 at 22:22, Alex Deucher <alexdeucher@gmail.com=
> wrote:

> On Mon, Feb 6, 2023 at 9:22 AM sfrcorne sfrcorne@protonmail.com wrote:
>=20
> > Hello,
> >=20
> > I hope this is the correct place to ask my question. I was not sure if =
I should have opened a new issue on Gitlab or send an email here, since I d=
on't know know whether this is a bug or intended behaviour.
> >=20
> > The question is about the new AMD Ryzen 7000 CPU's. These new CPU's hav=
e an iGPU and consequently provide a gpu_metrics file for monitoring the GP=
U/CPU (APU?). This file is used by programs like Mangohud, that try to read=
 (among other values) the following 4 values:
> > - current_gfxclk
> > - current_uclk
> > - average_cpu_power
> > - temperature_core
> > However it appears that on AMD Ryzen 7000 CPU's these 4 values are not =
provided/updated in the gpu_metrics file. Other values like 'average_core_p=
ower', 'temperature_l3' and the other 'current_<x>clk' are also not provide=
d/updated but these are not used by Mangohud at the moment.
> >=20
> > Is this intentional or a bug? And will this be fix and/or will support =
for these 4 values be added in the future?
>=20
>=20
> What specific CPU/APU is this? I don't recall off hand how mangohud
> queries this stuff, but you can take a look at the hwmon interfaces
> exposed by the driver or if you want the whole metrics table, you can
> use umr to fetch and decode it via the kernel interface. That will
> allow you to verify that the firmware is producing the proper data.
>=20
> Alex
