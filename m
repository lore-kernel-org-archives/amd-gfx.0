Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79501C33CB1
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 15:15:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432FA20730
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 15:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vStNgSmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432FA20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1C3F6ED83;
	Thu, 16 Jan 2020 15:15:04 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A57816ED83
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 15:15:03 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id p17so4228700wmb.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 07:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Dcl4UWfwgHtLs/lgK4pT0D4Mt03++vm5tf12mbGu0xs=;
 b=vStNgSmrMLGS7lullHFZJ4mszFBlfG9oRk3sJBx4adfSwy4pLS1/ZH+eGZxRuZTC3u
 mOAHizA2D3yxxFamFt2q2AtZ0uYLsEjYYlmU0W7E6FyIIKHHeG6RJj+2rOLXggaZ2S/A
 fr/d0Xcy6H3352EwsFFCMXuXFw9PG5kPq/j+YAe5TKGDyc0NtQG/1l8ML0lL3vB5RSPR
 O6/HJ827LVcDvMAaRJc+KiP46QDqCr1s3JyIs17mEF07MLG71+3gT/9WZ09AEPFrQeEV
 pcG85pYqAzyfPBnJh6L5dea/h+Mv0eTSJxYf/aYb7mAoh8RQP+6O9HnO2tqs07HJCj87
 LxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Dcl4UWfwgHtLs/lgK4pT0D4Mt03++vm5tf12mbGu0xs=;
 b=C9J9A3GY5qvh30FxPqr1YYolcptjKlxHnSXHdoqJ4wEZrnivc8lghEw8l5MIGRrcQU
 S9BWuI0LXUoD0uJyF7xz25z8ljiXzI8ukLTTAYy98F/Hw3yDUgv5Oxqd/SUXDbybFh2A
 D9Ct2EH3pdWOQD4LoGBW4bsbprl0dBPf9/wUjozmdtrd3z/OgMLn1W4d/MwHd39x2GXy
 x4/PifL7lXchWySct3kLmSi9HbjCMobXoAjxOT9ZJexnLYjhy53D0IeSSQsIoC0FWVwV
 V42ur8mW0Pt3KaKHoQUN6w+YzcRi8IlOnV+1qrhzT5BKIy3je43Vd827VJzD65WjS0sg
 ckzQ==
X-Gm-Message-State: APjAAAU5dC52vrbbArZFV8vNue1BN9Uq8zP5IMxzCmrAc+E3mcBVuke7
 LGHikrqrld7E38Sxb5yzSwgSFix2u6gfC8HifVv2pA==
X-Google-Smtp-Source: APXvYqydd32jTkNrJfMblX4hCLRewlE2tvVwHRRjYQWceAfkd/fp+hJmsjVJhSxR+0SPsMsEfv1v+dWTcLBDSuFvu1A=
X-Received: by 2002:a7b:ca4b:: with SMTP id m11mr6734923wml.164.1579187702280; 
 Thu, 16 Jan 2020 07:15:02 -0800 (PST)
MIME-Version: 1.0
References: <20191015065002.18701-1-drake@endlessm.com>
 <CADnq5_M4Leu0raYS6M72MqTm1+PLg9BjHCHLAYuB2-dEVP56_A@mail.gmail.com>
 <CAD8Lp443ZhPEo0PJRxbTSB9DY9x92OvWBeH29m9Ehpyhg+2n5A@mail.gmail.com>
 <CADnq5_OaATVESAY9E2mtd7PoV2VjG=WLS56LCHVpieSHDTas0A@mail.gmail.com>
 <CAD8Lp46f9LR_VJ26BGfOGvj8sTjKZowkbjLNv6R4CsVMfRZQ=Q@mail.gmail.com>
 <CAD8Lp46+Te+AUQKLkLEcGf34izw=JzkU5w=CsZRf_UKJQ_k7qg@mail.gmail.com>
 <CADnq5_OObnKTP7-tBmPz75R5qXs8ubRxgfX-qkBnzqcox0TZyQ@mail.gmail.com>
 <CAD8Lp44FKuEsmdK+zDX_-ZYQEnqjQM-z6nnfE-CJ62mutd+scA@mail.gmail.com>
In-Reply-To: <CAD8Lp44FKuEsmdK+zDX_-ZYQEnqjQM-z6nnfE-CJ62mutd+scA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Jan 2020 10:14:49 -0500
Message-ID: <CADnq5_PNGr4=MqpBeKbhxJ-gpniSCj7L0wO5_V6mjuwpKoaCAg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: always reset asic when going into suspend
To: Daniel Drake <drake@endlessm.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Chunming Zhou <David1.Zhou@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 15, 2020 at 2:44 AM Daniel Drake <drake@endlessm.com> wrote:
>
> On Thu, Dec 19, 2019 at 10:08 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> > I think there may be some AMD specific handling needed in
> > drivers/acpi/sleep.c.  My understanding from reading the modern
> > standby documents from MS is that each vendor needs to provide a
> > platform specific PEP driver.  I'm not sure how much of that current
> > code is Intel specific or not.
>
> I don't think there is anything Intel-specific in drivers/acpi/sleep.c.
>
> Reading more about PEP, I see that Linux supports PEP devices with
> ACPI ID INT33A1 or PNP0D80. Indeed the Intel platforms we work with
> have INT33A1 devices in their ACPI tables.
>
> This product has a \_SB.PEP ACPI device with _HID AMD0004 and _CID
> PNP0D80. Full acpidump:
> https://gist.github.com/dsd/ff3dfc0f63cdd9eba4a0fbd9e776e8be (see
> ssdt7)
>
> This PEP device responds to a _DSM with UUID argument
> "e3f32452-febc-43ce-9039-932122d37721", which is not the one
> documented at https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf
>
> Nevertheless, there is some data about the GPU:
>                     Package (0x04)
>                     {
>                         One,
>                         "\\_SB.PCI0.GP17.VGA",
>                         Zero,
>                         0x03
>                     },
>
> However since this data is identical to many other devices that
> suspend and resume just fine, I wonder if it is really important.
>
> The one supported method does offer two calls which may mirror the
> Display Off/On Notifications in the above spec:
>                         Case (0x02)
>                         {
>                             \_SB.PCI0.SBRG.EC0.CSEE (0xB7)
>                             Return (Zero)
>                         }
>                         Case (0x03)
>                         {
>                             \_SB.PCI0.SBRG.EC0.CSEE (0xB8)
>                             Notify (\_SB.PCI0.SBRG.EC0.LID, 0x80) //
> Status Change
>                             Return (Zero)
>                         }
>
> but I tried executing this code after suspending amdgpu, and the
> problem still stands, amdgpu cannot wakeup correctly.
>
> There's nothing else really interesting in the PEP device as far as I can see.
>
> PEP things aside, I am still quite suspicious about the fact that
> calling amdgpu_device_suspend() then amdgpu_device_resume() on
> multiple products (not just this one) fails. It seems that this code
> flow is relying on the BIOS doing something in the S3 suspend/resume
> path in order to make the device resumable by amdgpu_device_resume(),
> which is why we have only encountered this issue for the first time on
> our first AMD platform that does not support S3 suspend.
>

It makes sense.  This is an SOC, not a collection of individual
devices.  There are more devices than power rails so the sbios (via
ACPI) has to handle the power rail.  All of the devices using that
power rail have to suspend and tell the sbios before the platform
microcontroller can turn off the power rail.  Presumably there is
something missing that prevents the microcontroller for powering down
the rail.  If the power rail is kept on, the device is never powered
off and still retains its current state.

> With that in mind, and lacking any better info, wouldn't it make sense
> for amdgpu_device_resume() to always call reset? Maybe it's not
> necessary in the S3 case, but it shouldn't harm anything. Or perhaps
> it could check if the device is alive and reset it if it's not?

It's just papering over the problem.  It would be better from a power
perspective for the driver to just not suspend and keep running like
normal.  When the driver is not suspended runtime things like clock
and power gating are active which keep the GPU power at a minimum.

>
> Alternatively do you have any other contacts within AMD that could
> help us figure out the underlying question of how to correctly suspend
> and resume these devices? Happy to ship an affected product sample
> your way.
>

I talked to our sbios team and they seem to think our S0ix
implementation works pretty differently from Intel's.  I'm not really
an expert on this area however.  We have a new team ramping on up this
for Linux however.

Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
