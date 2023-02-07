Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923F2C636CD
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 23:15:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF1D410E62F;
	Tue,  7 Feb 2023 23:15:16 +0000 (UTC)
X-Greylist: delayed 169084 seconds by postgrey-1.36 at gabe;
 Tue, 07 Feb 2023 23:11:51 UTC
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com
 [51.77.79.158])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C76410E61F
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 23:11:51 +0000 (UTC)
Date: Tue, 07 Feb 2023 23:11:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1675811505; x=1676070705;
 bh=+HbacWPFHmrwOnbl0xQufEMC03mf9Xkf0woiYfSB2yA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=WY/wGWoYH6YkFwJuoPXXgYzYnqV9o3MpAYE1ejGaW277bSTriRe9aUmuITpgvdcAM
 mH9BRPFEVZG1A43lrPToMziZ+K7bhMlPoY3097m7BenjQwh2l3u6eqfVoRiEArFNAj
 MPgqscs41F61twT0+rMFRWWk7nKfFkI10JDVxn1koavjM8vWj5rV2gWL43wClc7gaT
 O8LlKjKieAGTP2zh8s7mP6AFs3gUG5bL8XeCReIvI8YDHOrKeXyinwSSiF9/iEGuDt
 SnLWYhMVdWOSPhviTG+G2howpy3QiI2AvzFZojXdBwJgbaM5IkfeFzcNiIJbLiDzIg
 g9gWoOQx92tuQ==
To: Alex Deucher <alexdeucher@gmail.com>
From: sfrcorne <sfrcorne@protonmail.com>
Subject: Re: gpu_metrics does not provide 'current_gfxclk', 'current_uclk',
 'average_cpu_power' & 'temperature_core' on AMD Ryzen 7000 CPU
Message-ID: <T3dXX2ti9l895_q6SONxY1unYapI-VyHGYp4BC0JMGWkjJQWpZS6J-Ufzpv6BxzPJ5IiwEDBRanmre0zRnElpkAWrI0pD7RkPoezxpSDiPY=@protonmail.com>
In-Reply-To: <CADnq5_OUwsNzGJA1Hmj9okyhC3BkfTkEw==V88mv_uAApZgo3Q@mail.gmail.com>
References: <rEMJPv8L9uDl7PSSJ_OtbkCcM9ABocJ_Mk8DuSUQpaB2fPEPNB6EBBo7XLlCKqsfF5bCz5jvr9CFt1pVzb37_KZBldUNBMcf2-2B3xDNVN0=@protonmail.com>
 <CADnq5_O__w5jkOoUALv96hybKP8qJs-=wcQAhcxy5kbiBg_vCw@mail.gmail.com>
 <IGhLMOrDFqjKG7Ct93T4NCqIKeGLdSNO9Q5p3CkgzBVK15kInfRfGdv4aFCRJO3TmR2shr_bqjxYmlAgI3BojoM0F9q24Jv82FLmm2fvpp0=@protonmail.com>
 <CADnq5_OUwsNzGJA1Hmj9okyhC3BkfTkEw==V88mv_uAApZgo3Q@mail.gmail.com>
Feedback-ID: 66916551:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 07 Feb 2023 23:15:14 +0000
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

If current_gfxclk is not supported for my CPU, then using average_gfxclk_fr=
equency instead is indeed the best solution in my opinion. I will try to ge=
t a fix merged for my CPU in Mangohud.

On a side note: you mentioned that unsupported fields would be 0 but I don'=
t think this is correct. In the Linux kernel/driver there is a line of code=
 that first set all values to 0xFF by a memset() and then populates the sup=
ported fields.

see "https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/pm/=
swsmu/smu_cmn.c#L999": memset(header, 0xFF, structure_size);

The value of the unsupported uint16_t fields thus should be 0xFFFF (or 6553=
5 in decimal). This is also what I get when reading the gpu_metrics file. I=
 just wanted to mention this in case someone reads this in the Archive.

Anyway, thank you for your help!

Kind regards,
sfrcorne

------- Original Message -------
On Tuesday, February 7th, 2023 at 05:05, Alex Deucher <alexdeucher@gmail.co=
m> wrote:


> On Mon, Feb 6, 2023 at 5:48 PM sfrcorne sfrcorne@protonmail.com wrote:
>=20
> > Dear Alex,
> >=20
> > First of all, thank you for your response. Personally, I use a Ryzen 5 =
7600X however people with a Ryzen 9 7900X are also reporting this issue. Th=
e relevant bug report in Mangohud can be found here: "https://github.com/fl=
ightlessmango/MangoHud/issues/868".
> >=20
> > I looked around a bit in both the Mangohud source code and the Linux ke=
rnel source code.
> >=20
> > (Mangohud source): From what I understand, Mangohud looks for a file "/=
sys/class/drm/card*/device/gpu_metrics". If this file exists (and it does e=
xists on my machine), it tries to read this file and extract the relevant G=
PU data (and in case of an APU also the CPU data) from it (these are the va=
lues I was talking about in my previous mail). When the file "/sys/class/dr=
m/card*/device/gpu_metrics" exists, it will not use the data provided by hw=
mon (/sys/class/hwmon/hwmon*/*).
> >=20
> > (Linux kernel): The gpu_metrics file contains different data, depending=
 on what version is used. All valid versions can be found in the source cod=
e: "https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/incl=
ude/kgd_pp_interface.h#L725". For my CPU/APU the 'gpu_metrics_v2_1' structu=
re is used (I tested this by reading the gpu_metrics file myself). Furtherm=
ore, I think that for my case, this structure is set by the function "https=
://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/pm/swsmu/smu1=
3/smu_v13_0_5_ppt.c#L459" but I am not completely sure about this.
>=20
>=20
> The metrics provided by the SMU firmware varies from asic to asic.
> For things that are not supported by the metrics table for a
> particular asic, those fields would be 0. You can see what metrics
> are supported for your asic in smu_v13_0_5_get_gpu_metrics() as that
> function populates the supported fields from the firmware to the
> common structure. current_gfxclk is not supported in your asic, but
> average_gfxclk_frequency is. So you'd want to use whichever field is
> available for a particular asic in Mangohud.
>=20
> > Lastly, I am not familiar with umr. I assume that you are referring to =
"https://gitlab.freedesktop.org/tomstdenis/umr"? If I find some time this w=
eekend, then I will look into this some more.
>=20
>=20
> Yes, that is the right link. umr uses the same interface as mangohud,
> so you should see the same data.
>=20
> Alex
>=20
> > Kind regards,
> > sfrcorne
> >=20
> > ------- Original Message -------
> > On Monday, February 6th, 2023 at 22:22, Alex Deucher alexdeucher@gmail.=
com wrote:
> >=20
> > > On Mon, Feb 6, 2023 at 9:22 AM sfrcorne sfrcorne@protonmail.com wrote=
:
> > >=20
> > > > Hello,
> > > >=20
> > > > I hope this is the correct place to ask my question. I was not sure=
 if I should have opened a new issue on Gitlab or send an email here, since=
 I don't know know whether this is a bug or intended behaviour.
> > > >=20
> > > > The question is about the new AMD Ryzen 7000 CPU's. These new CPU's=
 have an iGPU and consequently provide a gpu_metrics file for monitoring th=
e GPU/CPU (APU?). This file is used by programs like Mangohud, that try to =
read (among other values) the following 4 values:
> > > > - current_gfxclk
> > > > - current_uclk
> > > > - average_cpu_power
> > > > - temperature_core
> > > > However it appears that on AMD Ryzen 7000 CPU's these 4 values are =
not provided/updated in the gpu_metrics file. Other values like 'average_co=
re_power', 'temperature_l3' and the other 'current_<x>clk' are also not pro=
vided/updated but these are not used by Mangohud at the moment.
> > > >=20
> > > > Is this intentional or a bug? And will this be fix and/or will supp=
ort for these 4 values be added in the future?
> > >=20
> > > What specific CPU/APU is this? I don't recall off hand how mangohud
> > > queries this stuff, but you can take a look at the hwmon interfaces
> > > exposed by the driver or if you want the whole metrics table, you can
> > > use umr to fetch and decode it via the kernel interface. That will
> > > allow you to verify that the firmware is producing the proper data.
> > >=20
> > > Alex
