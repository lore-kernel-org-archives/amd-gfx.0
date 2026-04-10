Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD00EBFD1A
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 08:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C54C910E35A;
	Mon, 13 Apr 2026 08:03:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b="FfpJQ7Ur";
	dkim-atps=neutral
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68DEA10E9C4
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 19:18:08 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-50d876329bbso25386001cf.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 12:18:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775848687; cv=none;
 d=google.com; s=arc-20240605;
 b=AoCl7/e8qeP+GlHPIM/dIqrd94cABAfVAwyCIuj1jkpONeUsmnvzOzuMxzEDeXD1t0
 L4DYtDlUVsblQtPAQ8onwXOgpT2cFs/SVvpvwy8VyrnU7rxaOe0uyJ8STKJjUWANn6fO
 xZ+s+5rbxWXfj0yWWYoc0x+LsMBi9lCwjvMvRcM/aztk7jl4bktU1xlLS4Z+3wFgN5y3
 aVtVFRh5MHwTnA9gnXVdh5Oh+HQFhPv9uwUgS5RngvwsmDOToG+HPJ3dH5MuBZ+tbvu+
 5lDxibpOHSCbB+f83vyiFESag1rlzi+kJijA/YXI6QvH+325dLcDoEwL+KKp+TeepF7y
 kLEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=31FEqE2Yo5rPZanPlKgVYvrw+i09p9M5WGMB8Y1/hl4=;
 fh=/JHJBozUXm+pdtSjgn7bNtLzNBEJ+Sbb2nHfx1/yaCU=;
 b=WHTADC73C+OYpQqoTHqyL+1G2kBgR/D176el78wliW6LEMJhQv4JFlkyIo49ttB4Z2
 oNvf1M4ARHg92auWTRKU5Vo1l9pnrTBWpyv2rctB/bBypeX+J1X9qZe+BS7lqJiC6RF6
 bJfHSAdz7Dvrjlf7d212u5fOmhxzDWtrvW4FsiUnKdpB69EToyFx0TWp/iGtNBY52hBd
 fsoUhWIwvAEeJx8NQIRGkyUOVpFmAigZid3Uz+BbZ+2Nuu4esP3UHgdVu1RAD91C/ugp
 nkdKwBXaCqFhSld8eNHsLWEjIc1XyYRnxVwYS5OmnhrbbkOMHBnHKw1v+yR2zpXFQfp7
 3IPQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jqluv-com.20251104.gappssmtp.com; s=20251104; t=1775848687; x=1776453487;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=31FEqE2Yo5rPZanPlKgVYvrw+i09p9M5WGMB8Y1/hl4=;
 b=FfpJQ7UrsHimJ6V0UAz2sQ3XFbnIZ/vr7V01j8Mk/HiTcyTBBc8HzRdDFLrFStDZs8
 VlY8astffLr7v6nDlwRaqzxVh3zkBPk9BKKpW/5308Rl1p4Dr/xmHZW3e8W2ZYpCKH6Z
 6Pe0lu9w5IXE5MHIaVYQO1cJHtMpDmCZIBltCcQPPLafaS0uLHnylAsoOkeF9VxwqNmA
 i2lcLQH+q9XG0oFqCYG1Mj0fMTQ8Yv1OQ7GaTR7cR2clHW8kirSHwabPQY8NUQt0fMd3
 Llm0EYPOlvcifKAoCwugBprUW2J24AFtl312sYL0P5yr9FrM8Q10rVQUsp+9beKJH/Ez
 8oZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775848687; x=1776453487;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=31FEqE2Yo5rPZanPlKgVYvrw+i09p9M5WGMB8Y1/hl4=;
 b=ietURX3CJW89xmTbE2xFiERx2qZEX1LE87hatsnYBfZeGjLp09Ij2QCKlgL8Mt+pf/
 SvJZ4/QJV0Iyrhzc1rkkPmDCX00GnGREtS9su2eauPd0vTx7ITnsmX5Og+7pR5ei3LX3
 2+HqEb2dmf88uJFc3sTr4Q9vkY9oa9f4aF8ddI4SYJgp9kxK+LRCiPsr9sKej2oP8EdV
 qOM9BJse3++BMWuANT/l5gi3k1wCkzexIYAIuaqqdfV8Ouiop9e0hTf1yGuMQ0Kn8URX
 7bOyMjeQa/6HtdCh3sYVooQ7mpUOOi2bw6xwvGr5MbVn+4vRZlvfndPhn9XO8CLFAO3V
 Xnlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMHJaLpYjEJHJ++ehGizW5gzn6KTYA3U+0Ng62HLW3Vm18uj9cLaz4RuYl1HW4s8Jm03QKAyaE@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzb9eD9GrLkxlg1AWhsy8aFU6YBQPBOBOpCSgty06VQDkIDeLWR
 p0JzUPqSBjrIqay2BDX263nApomLjbt0aDL1DUEm917Aa/5Wlrl0mxvVdrlg7QqQq+qgqyE7WpS
 epC8w6fCK7+HyuCS/9USjdhzcu2dDGBT6iNbfbqYpkQ==
X-Gm-Gg: AeBDievT/h3AcCGX++SpaIvmipD4+PDGj5/gpfWG7gOxVsZq05rqlEi/LhDQsaT0Kd2
 Ks6jikysAVBgCHC7pjbr0qxSHDi5P9hRS57CO6dVc/5GKhd14AoVToJGO1g2N28xxfF8bB3f16i
 3SmjRKAWXpyH0DRBTsk43nvX/gUIU6hCPiSZeYZm13fgZDOgk4dy+awY3nhHYm28aTcdpZpJhyG
 0HeMS2TZjMggWE0LOWbzJD1sjzLm0UhucyoDpHV0SWj9IwJzlHxV0YHJvoBEa3UF8/dwuGgB5KY
 27D4
X-Received: by 2002:a05:622a:24c:b0:50b:4c64:4730 with SMTP id
 d75a77b69052e-50dd5abce85mr66831251cf.15.1775848687026; Fri, 10 Apr 2026
 12:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAGpo2mebCaP4vFuTnn6jgu6OjjE_ssS7i8ENepuUjwwHXddCHA@mail.gmail.com>
 <243af06e-912b-4915-bc64-5aa16dad7db0@amd.com>
 <47306de6-cbf6-4b2d-847e-d1e5d933516d@amd.com>
 <053100e2-fe23-4b9b-9b20-be5f0a49c22d@amd.com>
In-Reply-To: <053100e2-fe23-4b9b-9b20-be5f0a49c22d@amd.com>
From: Geramy Loveless <gloveless@jqluv.com>
Date: Fri, 10 Apr 2026 12:17:55 -0700
X-Gm-Features: AQROBzBUob0ErCRbW2Fob8jWHHOFRE468wGPn3kL3Q5v-ADCKqiRpgcKjisMmiU
Message-ID: <CAGpo2mdhu3R73g6iEb66CODnwkcoDq3Wy4ReYBDvUgZcj7oLeA@mail.gmail.com>
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

It seems there is another person having the same problems im having or
at least similar.
I am going to loop his logs in here and add him maybe we can tackle
this together and find the underlying problem easier or faster.
Its always better to have two logs from too different points sometimes
you get things in one you dont get in the other out of pure chance,
haha.

 https://pcforum.amd.com/s/question/0D5Pd00001S3Av9KAF/linux-9060xt-egpuove=
rthunderbolt-bugs-galore

Let me know if I can be of use, or if you need extra bandwidth for
making patches point my in the direction.

Thanks everyone!

On Fri, Apr 10, 2026 at 4:25=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 09-Apr-26 11:42 PM, Mario Limonciello wrote:
> >
> >
> > On 4/9/26 06:42, Christian K=C3=B6nig wrote:
> >> On 4/9/26 02:05, Geramy Loveless wrote:
> >>> When an AMD GPU behind a Thunderbolt PCIe tunnel undergoes a MODE1 on
> >>> Thunderbolt the TB driver receives no notification and the tunnel
> >>> stays up while the endpoint is unreachable.
> >>
> >> IIRC a MODE1 reset should keep the bus active and so the endpoint
> >> should still be reachable.
> >>
> >>> All subsequent PCIe
> >>> reads return 0xFFFFFFFF and MES firmware cannot reinitialize,
> >>> triggering an infinite reset loop that hangs the system.
> >>
> >> That sounds more like the MODE1 reset failed.
> >>
> >>> After MODE1 reset completes, check whether the PCIe endpoint is still
> >>> reachable using pci_device_is_present(). If the device is behind
> >>> Thunderbolt and the link is dead, walk up parent bridges calling
> >>> pci_bridge_secondary_bus_reset() to retrain the physical PCIe link
> >>> inside the dock.
> >>
> >> Well that is then a bus reset.
> >>
> >> I mean that is a reasonable mitigation when a MODE1 reset failed, but
> >> the question is rather why does the MODE1 reset fails in the first pla=
ce?
> >>
> >>> If recovery fails, return -ENODEV to prevent the
> >>> reset retry loop.
> >>>
> >>> This also causes the GPU fan to be at 100% and basically when it
> >>> happens and you are not there, you now have a GPU with fan at 100% an=
d
> >>> cant reset it.
> >>> I wanted to notate some other things I am finding sometimes before
> >>> this adventure of patches to the kernel and amdgpu driver.
> >>> Sometimes a crash could happen in the drive and then the GPU fan spee=
d
> >>> hits 100% and the air is hot coming out without any workload, other
> >>> times
> >>> I have seen it have barely any fan speed at all and heat up more than
> >>> it should at the fan level its curently operating at. These are thing=
s
> >>> I have seen with this gpu in a TB5 dock with the driver and
> >>> instability. I'm not sure exactly whats going on there but I figured
> >>> since im communicating with these patches I might as well bring you u=
p
> >>> to speed and supermario has been great help throughout me trying to
> >>> get the AMD AI R9700 Pro working on my MS-S1 Halo Strix with a TB5 /
> >>> USB4v2 dock!
> >>
> >> Adding Mario as well. That strongly sounds like you crashed the SMU
> >> which would also explain the failed MODE1 reset.
> >>
> >> But all of that are only symptoms. Question is what is actually going
> >> on here? e.g. what is the root cause?
> >
> > We don't spend a lot of time in recovery scenarios for when =F0=9F=92=
=A9 hits the
> > fan.  I think in addition to finding and fixing the real root cause
> > having a reproducible workload to cause the crash is a good opportunity
> > to try to put in place better recovery too.
> >
> > Generally speaking I like the idea of if a mode1 reset fails to do a
> > harder reset.  At least in the path that we have GPU recovery
> > (amdgpu.gpu_recovery module parameter) set, adding a fallback case to d=
o
> > a full device reset makes sense to me.
> >
> > I think the placement is wrong though.  amdgpu_device_mode1_reset() has
> > a bunch of callers, and if you end up with a mode1 reset doing a full
> > reset that might be a surprise to those callers.
> >
> > So I think a more logical place to put this would be explicitly in the
> > GPU recovery path (amdgpu_device_gpu_recover).  Maybe as part of the
> > mode1 reset failure you can:
> >
> > set_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
> >
> > And then the GPU recovery path can jump right into a full reset?  Not
> > sure if that jives with your stack trace though.
> >
> > Furthermore; even though you reproduced this on Thunderbolt; I have no
> > reason to believe it's specific to thunderbolt.  An SMU crash can happe=
n
> > in any hardware.  We may as well try full reset for recovery for any
> > hardware.
>
> FWIW, if SMU crashes then SBR also shouldn't work since SBR handling
> needs some firmware support as well.
>
> A kernel module triggering chain-reset by going one level up and
> resetting all devices under the bridge (in a while loop) also doesn't
> look like an acceptable solution.
>
> Thanks,
> Lijo
>
> >
> >>
> >>>
> >>> It seems to be finally working with bar resizing after my kernel
> >>> patch. Which allows you to safely release a empty switch bridge at th=
e
> >>> device end.
> >>> Then it rebuilds it afterwords with the increased bar. This was done
> >>> on Kernel 7.0-rc7 i believe it is and latest changes from pci/resourc=
e
> >>> branch with my patch here.
> >>>
> >>> https://lore.kernel.org/linux-pci/CAGpo2meKY6SXsESU-D0PGgbESLqdF8UBF-
> >>> tmThxOvk2XUDpEzw@mail.gmail.com/T/#u
> >>
> >> Where is the MMIO register BAR before and after the rebuild?
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Thank you!
> >>>
> >>> Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
> >>> ---
> >>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 40 +++++++++++++++++++++=
+
> >>> 1 file changed, 40 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> index 31a60173c..91d01d538 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> @@ -5770,6 +5770,46 @@ int amdgpu_device_mode1_reset(struct
> >>> amdgpu_device *adev)
> >>> /* ensure no_hw_access is updated before we access hw */
> >>> smp_mb();
> >>> + /*
> >>> + * On Thunderbolt-attached GPUs, MODE1 reset kills the PCIe
> >>> + * endpoint but the TB tunnel stays up unaware. Detect the
> >>> + * dead link and attempt recovery by resetting parent bridges
> >>> + * to retrain the physical PCIe link inside the dock.
> >>> + */
> >>> + if (!pci_device_is_present(adev->pdev) &&
> >>> + pci_is_thunderbolt_attached(adev->pdev)) {
> >>> + struct pci_dev *bridge;
> >>> + bool recovered =3D false;
> >>> +
> >>> + dev_info(adev->dev,
> >>> + "PCIe link lost after mode1 reset, attempting Thunderbolt
> >>> recovery\n");
> >>> +
> >>> + bridge =3D pci_upstream_bridge(adev->pdev);
> >>> + while (bridge && !pci_is_root_bus(bridge->bus)) {
> >>> + dev_info(adev->dev,
> >>> + "attempting link recovery via %s\n",
> >>> + pci_name(bridge));
> >>> + pci_bridge_secondary_bus_reset(bridge);
> >>> + msleep(100);
> >>> + if (pci_device_is_present(adev->pdev)) {
> >>> + recovered =3D true;
> >>> + break;
> >>> + }
> >>> + bridge =3D pci_upstream_bridge(bridge);
> >>> + }
> >>> +
> >>> + if (!recovered) {
> >>> + dev_err(adev->dev,
> >>> + "Thunderbolt PCIe link recovery failed\n");
> >>> + ret =3D -ENODEV;
> >>> + goto mode1_reset_failed;
> >>> + }
> >>> +
> >>> + dev_info(adev->dev,
> >>> + "Thunderbolt PCIe link recovered via %s\n",
> >>> + pci_name(bridge));
> >>> + }
> >>> +
> >>> amdgpu_device_load_pci_state(adev->pdev);
> >>> ret =3D amdgpu_psp_wait_for_bootloader(adev);
> >>> if (ret)
> >>> --
> >>> 2.51.0
> >>
> >
>
