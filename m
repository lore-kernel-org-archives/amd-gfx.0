Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F78EBFD18
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 08:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FE0B10E362;
	Mon, 13 Apr 2026 08:03:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b="Ms//1VAi";
	dkim-atps=neutral
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15FE710E05E
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 22:42:57 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-8cfc3ca1922so229952585a.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 15:42:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775860976; cv=none;
 d=google.com; s=arc-20240605;
 b=VODBeG1H9Zm6P9m4cfqcSjKArBucsYWXbsIy1v0Ex51UxrNmlXvadyDsZBvmbnwFac
 vllcQ0NXfZ6Hj0ozSLApyifEWmn3Gg4DJjSSv7PrIYhXXoWkWvNwTW549JB1LU/f1n65
 vrTBHRhv8/8uCT8RQfZ/dQ62NvqXPSTJSHSgsUNQw1fnj7IQ+joCyXcggZGwI3ce/MFw
 16TldF5kW9UWpm/2CZPLVEfdu6HBt270eWfX2lN8o+WzgbaUYh3BwKgNxSZo7CDpTSUV
 nrrscYaFITtbZhFZRmMrJPrXc2MAHJx/p/Q0LCkiLp85XRWKL1i0a/7BluLQA+Ka1eiR
 EYAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=O7Pin7WWTn+oH7SOo/TwOynh12TEmQRVK1iCtzYQ0cs=;
 fh=h0Bh614afur/ouCSIx8mrfoyGGeQlqQP1iIvuMbKQJg=;
 b=HcSSUqQC6v20lfw07tRf3jUbfsiz8itjhhsuMQgrjRSgVUFyoIcurvZIo9fpjYM3RX
 +wkFWleg5EnmiFuUcCJoWjwISjx8ImE2t90D/nE1OIbGlZ+NlX/8YNAWlDW1hMd2rGdh
 VDuPA8VISrvVK4r4bYoIdvG+7vrBV0zkNbSGi9aTKggQWcMEXsJ2TnNaomDf9DCuoaQ6
 48dmnwzaIl8ZVRyZ1EMorKT/0ovRAXC4Ga/BJAyDeSYxObqyi6nsRY4sFm0FASPKQD7u
 /5ORirq0xP8q45YDOatH0XvmV3luKOQHzDW32AAhrl6e7ocrxGiv965S0XKtC4HgJzAA
 3RTw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jqluv-com.20251104.gappssmtp.com; s=20251104; t=1775860976; x=1776465776;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O7Pin7WWTn+oH7SOo/TwOynh12TEmQRVK1iCtzYQ0cs=;
 b=Ms//1VAiU52pThx2rlLlkACQ+GfHOSQqHKlrN9g+l1Af+txGbxgqe/U7ymH35i8hW4
 0PJiYk6H+IYjvAfgSMCq7lKZkwgDbzGQnJD9ie/P5h0h+MP1aewS+LrJ1Oatt1Nk45pQ
 5sDrwsmaW3+DBlD8SsRnIlWltBS2COngzEHxL1jO6vE+qEYmaeChylyERvAwslRY10kG
 3Iz8dxaDuqD9IUqf8bl9Caf4L8Mb3W9eNMpGbn8XxbAGITMPwm8ZjTS9JfZ2Gsyu8xwu
 DWFVWt/oiNnIPOLIbZdGLUqB2SmbZh0xXrorsOnU6j3D1EqSVMTdE0xkNIdlehxTe426
 4puA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775860976; x=1776465776;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O7Pin7WWTn+oH7SOo/TwOynh12TEmQRVK1iCtzYQ0cs=;
 b=s4Gr175geUkC3TYh+WelnZfxukG192Re4uUFLeuJKY4OwKgIBppT4SumdCiOCYVghA
 PqU6nxDyAf39UIURy+Im7Ay1CrHqpRVE9M9GUaA8A/I2JjlMzr4/I3BwNkjW+TmaCiFm
 VByPQTVyYgw7AUy4A7HWC0ujNpD8W0NPTgA4syH3Y86+ZfACHFAYsgd3qd6jk+tu0Jds
 ekRJIILVBNYZ6Vi2BcUWvsf6yPEVrw3xWFbEl0DYOK7lC2QdaSVwNYfdlF6ycH4gh302
 L6nq7aeLFhYLt/OFlMpRg68vijEFzM+5b85FutmvuI8G6LrGreRB1g3Va0r4neyUjaAS
 CYaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkRDkNpg5X2/9DdiWo/o1D4d1Hpd+hPQ5jPv53i/d0bNaUCAaIM9cOtT0Kb2nsRTQWa343Y6Ug@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZqSR5viOM4KcDz78zE1ecjd557Xeat43m7IXnYEF+37f6qKAh
 WFGYKes1lfuRTzgsMoAU6YCLHb7iYSF5IwoJvNybd+9xK/a0FE4vJq1WvmFpOaxdiMI8rDgb6L7
 koMws46viIPbd0FGQ3CW65y+TPSGew9hhM5ZOf6gyxQ==
X-Gm-Gg: AeBDievx/r35qqri/8jv3rGbxgKg28XG4LhS+8zENuSDEemne8Gp0zyb/R7QQrjoVrE
 wkBi/XkXs/SYuVhgd5b/64OwX13uMKipTSWKZ/FZ+hX5oH/3PHJOF63vj1cCTa/PXWirtWRcyJQ
 NhbMXiZb9wTbGJn3hczEDBteUPAzD41P2TxnoqzrqMWf6sTHUS9d/Ziqhw+TNiTgtkvOYnoG5Ux
 k8cOGteHZSVafsL5VmpuEb9Yt23Hu7tHXHVYEHOMVL2TlsfACPM5EWnluY7YzUlRHkz47fIGzHm
 1+sz
X-Received: by 2002:a05:6214:da6:b0:8a8:e7a5:405b with SMTP id
 6a1803df08f44-8ac74585e0bmr140059116d6.15.1775860975776; Fri, 10 Apr 2026
 15:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAGpo2mebCaP4vFuTnn6jgu6OjjE_ssS7i8ENepuUjwwHXddCHA@mail.gmail.com>
 <243af06e-912b-4915-bc64-5aa16dad7db0@amd.com>
 <47306de6-cbf6-4b2d-847e-d1e5d933516d@amd.com>
 <053100e2-fe23-4b9b-9b20-be5f0a49c22d@amd.com>
 <CAGpo2mdhu3R73g6iEb66CODnwkcoDq3Wy4ReYBDvUgZcj7oLeA@mail.gmail.com>
In-Reply-To: <CAGpo2mdhu3R73g6iEb66CODnwkcoDq3Wy4ReYBDvUgZcj7oLeA@mail.gmail.com>
From: Geramy Loveless <gloveless@jqluv.com>
Date: Fri, 10 Apr 2026 15:42:43 -0700
X-Gm-Features: AQROBzCwVWd21rWIaRKUqaHQ4CPLx5w-rL7wvwBekzDarv2PaudLkoaG0lgSD-0
Message-ID: <CAGpo2me+PkAvjcVC8cGKVSqH1jrJ9GnFbBxXXC5EPf9MeRKkNQ@mail.gmail.com>
Subject: Re: [PATCH] amdgpu: recover Thunderbolt PCIe link after MODE1 GPU
 reset
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 Cristian Cocos <cristi@ieee.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 13 Apr 2026 08:02:59 +0000
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

I found something really interesting dev_is_removable is not working
on my Minisforum MS-S1 it replies with not removable for the gfx card
which should get the HotPlug+ from the thunderbolt but it doesnt I bet
if you add || pci_is_thunderbolt_attached also it could clear up a lot
of problems, just my two cents. :) I am running some tests now.

On Fri, Apr 10, 2026 at 12:17=E2=80=AFPM Geramy Loveless <gloveless@jqluv.c=
om> wrote:
>
> It seems there is another person having the same problems im having or
> at least similar.
> I am going to loop his logs in here and add him maybe we can tackle
> this together and find the underlying problem easier or faster.
> Its always better to have two logs from too different points sometimes
> you get things in one you dont get in the other out of pure chance,
> haha.
>
>  https://pcforum.amd.com/s/question/0D5Pd00001S3Av9KAF/linux-9060xt-egpuo=
verthunderbolt-bugs-galore
>
> Let me know if I can be of use, or if you need extra bandwidth for
> making patches point my in the direction.
>
> Thanks everyone!
>
> On Fri, Apr 10, 2026 at 4:25=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> =
wrote:
> >
> >
> >
> > On 09-Apr-26 11:42 PM, Mario Limonciello wrote:
> > >
> > >
> > > On 4/9/26 06:42, Christian K=C3=B6nig wrote:
> > >> On 4/9/26 02:05, Geramy Loveless wrote:
> > >>> When an AMD GPU behind a Thunderbolt PCIe tunnel undergoes a MODE1 =
on
> > >>> Thunderbolt the TB driver receives no notification and the tunnel
> > >>> stays up while the endpoint is unreachable.
> > >>
> > >> IIRC a MODE1 reset should keep the bus active and so the endpoint
> > >> should still be reachable.
> > >>
> > >>> All subsequent PCIe
> > >>> reads return 0xFFFFFFFF and MES firmware cannot reinitialize,
> > >>> triggering an infinite reset loop that hangs the system.
> > >>
> > >> That sounds more like the MODE1 reset failed.
> > >>
> > >>> After MODE1 reset completes, check whether the PCIe endpoint is sti=
ll
> > >>> reachable using pci_device_is_present(). If the device is behind
> > >>> Thunderbolt and the link is dead, walk up parent bridges calling
> > >>> pci_bridge_secondary_bus_reset() to retrain the physical PCIe link
> > >>> inside the dock.
> > >>
> > >> Well that is then a bus reset.
> > >>
> > >> I mean that is a reasonable mitigation when a MODE1 reset failed, bu=
t
> > >> the question is rather why does the MODE1 reset fails in the first p=
lace?
> > >>
> > >>> If recovery fails, return -ENODEV to prevent the
> > >>> reset retry loop.
> > >>>
> > >>> This also causes the GPU fan to be at 100% and basically when it
> > >>> happens and you are not there, you now have a GPU with fan at 100% =
and
> > >>> cant reset it.
> > >>> I wanted to notate some other things I am finding sometimes before
> > >>> this adventure of patches to the kernel and amdgpu driver.
> > >>> Sometimes a crash could happen in the drive and then the GPU fan sp=
eed
> > >>> hits 100% and the air is hot coming out without any workload, other
> > >>> times
> > >>> I have seen it have barely any fan speed at all and heat up more th=
an
> > >>> it should at the fan level its curently operating at. These are thi=
ngs
> > >>> I have seen with this gpu in a TB5 dock with the driver and
> > >>> instability. I'm not sure exactly whats going on there but I figure=
d
> > >>> since im communicating with these patches I might as well bring you=
 up
> > >>> to speed and supermario has been great help throughout me trying to
> > >>> get the AMD AI R9700 Pro working on my MS-S1 Halo Strix with a TB5 =
/
> > >>> USB4v2 dock!
> > >>
> > >> Adding Mario as well. That strongly sounds like you crashed the SMU
> > >> which would also explain the failed MODE1 reset.
> > >>
> > >> But all of that are only symptoms. Question is what is actually goin=
g
> > >> on here? e.g. what is the root cause?
> > >
> > > We don't spend a lot of time in recovery scenarios for when =F0=9F=92=
=A9 hits the
> > > fan.  I think in addition to finding and fixing the real root cause
> > > having a reproducible workload to cause the crash is a good opportuni=
ty
> > > to try to put in place better recovery too.
> > >
> > > Generally speaking I like the idea of if a mode1 reset fails to do a
> > > harder reset.  At least in the path that we have GPU recovery
> > > (amdgpu.gpu_recovery module parameter) set, adding a fallback case to=
 do
> > > a full device reset makes sense to me.
> > >
> > > I think the placement is wrong though.  amdgpu_device_mode1_reset() h=
as
> > > a bunch of callers, and if you end up with a mode1 reset doing a full
> > > reset that might be a surprise to those callers.
> > >
> > > So I think a more logical place to put this would be explicitly in th=
e
> > > GPU recovery path (amdgpu_device_gpu_recover).  Maybe as part of the
> > > mode1 reset failure you can:
> > >
> > > set_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
> > >
> > > And then the GPU recovery path can jump right into a full reset?  Not
> > > sure if that jives with your stack trace though.
> > >
> > > Furthermore; even though you reproduced this on Thunderbolt; I have n=
o
> > > reason to believe it's specific to thunderbolt.  An SMU crash can hap=
pen
> > > in any hardware.  We may as well try full reset for recovery for any
> > > hardware.
> >
> > FWIW, if SMU crashes then SBR also shouldn't work since SBR handling
> > needs some firmware support as well.
> >
> > A kernel module triggering chain-reset by going one level up and
> > resetting all devices under the bridge (in a while loop) also doesn't
> > look like an acceptable solution.
> >
> > Thanks,
> > Lijo
> >
> > >
> > >>
> > >>>
> > >>> It seems to be finally working with bar resizing after my kernel
> > >>> patch. Which allows you to safely release a empty switch bridge at =
the
> > >>> device end.
> > >>> Then it rebuilds it afterwords with the increased bar. This was don=
e
> > >>> on Kernel 7.0-rc7 i believe it is and latest changes from pci/resou=
rce
> > >>> branch with my patch here.
> > >>>
> > >>> https://lore.kernel.org/linux-pci/CAGpo2meKY6SXsESU-D0PGgbESLqdF8UB=
F-
> > >>> tmThxOvk2XUDpEzw@mail.gmail.com/T/#u
> > >>
> > >> Where is the MMIO register BAR before and after the rebuild?
> > >>
> > >> Regards,
> > >> Christian.
> > >>
> > >>>
> > >>> Thank you!
> > >>>
> > >>> Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
> > >>> ---
> > >>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 40 +++++++++++++++++++=
+++
> > >>> 1 file changed, 40 insertions(+)
> > >>>
> > >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > >>> index 31a60173c..91d01d538 100644
> > >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > >>> @@ -5770,6 +5770,46 @@ int amdgpu_device_mode1_reset(struct
> > >>> amdgpu_device *adev)
> > >>> /* ensure no_hw_access is updated before we access hw */
> > >>> smp_mb();
> > >>> + /*
> > >>> + * On Thunderbolt-attached GPUs, MODE1 reset kills the PCIe
> > >>> + * endpoint but the TB tunnel stays up unaware. Detect the
> > >>> + * dead link and attempt recovery by resetting parent bridges
> > >>> + * to retrain the physical PCIe link inside the dock.
> > >>> + */
> > >>> + if (!pci_device_is_present(adev->pdev) &&
> > >>> + pci_is_thunderbolt_attached(adev->pdev)) {
> > >>> + struct pci_dev *bridge;
> > >>> + bool recovered =3D false;
> > >>> +
> > >>> + dev_info(adev->dev,
> > >>> + "PCIe link lost after mode1 reset, attempting Thunderbolt
> > >>> recovery\n");
> > >>> +
> > >>> + bridge =3D pci_upstream_bridge(adev->pdev);
> > >>> + while (bridge && !pci_is_root_bus(bridge->bus)) {
> > >>> + dev_info(adev->dev,
> > >>> + "attempting link recovery via %s\n",
> > >>> + pci_name(bridge));
> > >>> + pci_bridge_secondary_bus_reset(bridge);
> > >>> + msleep(100);
> > >>> + if (pci_device_is_present(adev->pdev)) {
> > >>> + recovered =3D true;
> > >>> + break;
> > >>> + }
> > >>> + bridge =3D pci_upstream_bridge(bridge);
> > >>> + }
> > >>> +
> > >>> + if (!recovered) {
> > >>> + dev_err(adev->dev,
> > >>> + "Thunderbolt PCIe link recovery failed\n");
> > >>> + ret =3D -ENODEV;
> > >>> + goto mode1_reset_failed;
> > >>> + }
> > >>> +
> > >>> + dev_info(adev->dev,
> > >>> + "Thunderbolt PCIe link recovered via %s\n",
> > >>> + pci_name(bridge));
> > >>> + }
> > >>> +
> > >>> amdgpu_device_load_pci_state(adev->pdev);
> > >>> ret =3D amdgpu_psp_wait_for_bootloader(adev);
> > >>> if (ret)
> > >>> --
> > >>> 2.51.0
> > >>
> > >
> >
