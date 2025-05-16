Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2B4C3ABC9
	for <amd-gfx@archiver.kernel.org>; Fri, 16 May 2025 19:53:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 177F210EB7B;
	Fri, 16 May 2025 19:53:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="icD9cTwT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7435210E023
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 19:53:25 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 44C8B4A270
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 19:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264B9C4CEF3
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 19:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747425197;
 bh=QQFP9I9xGbSP7aMAox64mdyWnEHDK01wUlBlFz+8IIk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=icD9cTwTL+4LP2EHR7A/ch2PUjUZvLjY/wOYIcNn9vp4OsfzaX5wObGoNwCEqCSp5
 7fL/YmY7QaXIDK7CEa6jzq+lli4bjCglBh0Ro9M05c22FfHIab/VC48Ubzi94YHRXi
 YxY1N4BR3EVS3/z5YZ099uPyOPmq21QPlbWI8ybRo0cyWff1wRFk58BeSbeLBMPkHF
 fdSZjOuhmSf1n+gfYRna2xDTLfLAqzfIZg14DkniXRcEeiE/sbKHYLungIokHPMWap
 YMY7SubZ1sfmZ6EpJ4t6P5QjLtMtcmfpAW3VzxJUzrkXsUnnjiVA0U5ant5zwnRXkE
 yMzfoDG/4tBZg==
Received: by mail-oa1-f47.google.com with SMTP id
 586e51a60fabf-2e3e58edab5so100684fac.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 12:53:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCU5RqTU5ojM3oWE5V4a5CTg8ram5CL2HcIBZaNdx+zfqa8Qzs+dKFUEP4P+CZTxGyuMeRFIZNnM@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxmvOGFf/+eN/43+SG7/RV75f3s0EOmiuq7ffwFUUTI+NWchujb
 VHIYjZbMt8QzJ+vjP4z9n/MQsF2c0de53BP+VsA3DA9OWiLBKRrM2qh6wFAgg5fJFwYK7gBWDsV
 iGSZFrgMfIpLr0Wu2OEgeF8TulfOhwSc=
X-Google-Smtp-Source: AGHT+IHVEU4gjatu/RMVom2ksKqHlYaJz0w2soN4yprttFQbRpMz2YGaP1tqoqkPACdW5qYoj1N9yc7K0LLBujvDxIE=
X-Received: by 2002:a05:6870:2a4c:b0:29f:97af:a1a0 with SMTP id
 586e51a60fabf-2e3c84d532amr2017577fac.24.1747425196436; Fri, 16 May 2025
 12:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250514193406.3998101-1-superm1@kernel.org>
 <20250514193406.3998101-2-superm1@kernel.org>
 <CAJZ5v0jifqTP_eZ33nBmKPCuLWrrVF_0jNGf5CpHU6nXuK8qBw@mail.gmail.com>
 <d77b51a6-24a0-4b24-b3f8-c6de8809b686@kernel.org>
In-Reply-To: <d77b51a6-24a0-4b24-b3f8-c6de8809b686@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 May 2025 21:53:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g_SRhQWrUYkKb6X3i1jKTeMoZvohZzq_Lpf0mM-UzUiA@mail.gmail.com>
X-Gm-Features: AX0GCFuB9LlaVI_p6ZZGmurTFqClTfA7X9euCJNdWFzYSpMo0mgCEYFiDin9G40
Message-ID: <CAJZ5v0g_SRhQWrUYkKb6X3i1jKTeMoZvohZzq_Lpf0mM-UzUiA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] PM: Use hibernate flows for system power off
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
 "open list:HIBERNATION (aka Software Suspend,
 aka swsusp)" <linux-pm@vger.kernel.org>, 
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, 
 Mario Limonciello <mario.limonciello@amd.com>,
 AceLan Kao <acelan.kao@canonical.com>, 
 Kai-Heng Feng <kaihengf@nvidia.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
 =?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>, 
 Denis Benato <benato.denis96@gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 16, 2025 at 9:33=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> On 5/16/2025 9:58 AM, Rafael J. Wysocki wrote:
> > On Wed, May 14, 2025 at 9:34=E2=80=AFPM Mario Limonciello <superm1@kern=
el.org> wrote:
> >>
> >> From: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> When the system is powered off the kernel will call device_shutdown()
> >> which will issue callbacks into PCI core to wake up a device and call
> >> it's shutdown() callback.  This will leave devices in ACPI D0 which ca=
n
> >> cause some devices to misbehave with spurious wakeups and also leave s=
ome
> >> devices on which will consume power needlessly.
> >>
> >> The issue won't happen if the device is in D3 before system shutdown, =
so
> >> putting device to low power state before shutdown solves the issue.
> >>
> >> ACPI Spec 6.5, "7.4.2.5 System \_S4 State" says "Devices states are
> >> compatible with the current Power Resource states. In other words, all
> >> devices are in the D3 state when the system state is S4."
> >>
> >> The following "7.4.2.6 System \_S5 State (Soft Off)" states "The S5
> >> state is similar to the S4 state except that OSPM does not save any
> >> context." so it's safe to assume devices should be at D3 for S5.
> >>
> >> To accomplish this, modify the PM core to call all the device hibernat=
e
> >> callbacks when turning off the system when the kernel is compiled with
> >> hibernate support. If compiled without hibernate support or hibernate =
fails
> >> fall back into the previous shutdown flow.
> >>
> >> Cc: AceLan Kao <acelan.kao@canonical.com>
> >> Cc: Kai-Heng Feng <kaihengf@nvidia.com>
> >> Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
> >> Cc: Merthan Karaka=C5=9F <m3rthn.k@gmail.com>
> >> Tested-by: Denis Benato <benato.denis96@gmail.com>
> >> Link: https://lore.kernel.org/linux-pci/20231213182656.6165-1-mario.li=
monciello@amd.com/
> >> Link: https://lore.kernel.org/linux-pci/20250506041934.1409302-1-super=
m1@kernel.org/
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >> v2:
> >>   * Handle failures to hibernate (fall back to shutdown)
> >>   * Don't use dedicated events
> >>   * Only allow under CONFIG_HIBERNATE_CALLBACKS
> >> ---
> >>   kernel/reboot.c | 12 ++++++++++++
> >>   1 file changed, 12 insertions(+)
> >>
> >> diff --git a/kernel/reboot.c b/kernel/reboot.c
> >> index ec087827c85cd..52f5e6e36a6f8 100644
> >> --- a/kernel/reboot.c
> >> +++ b/kernel/reboot.c
> >> @@ -13,6 +13,7 @@
> >>   #include <linux/kexec.h>
> >>   #include <linux/kmod.h>
> >>   #include <linux/kmsg_dump.h>
> >> +#include <linux/pm.h>
> >>   #include <linux/reboot.h>
> >>   #include <linux/suspend.h>
> >>   #include <linux/syscalls.h>
> >> @@ -305,6 +306,17 @@ static void kernel_shutdown_prepare(enum system_s=
tates state)
> >>                  (state =3D=3D SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF=
, NULL);
> >>          system_state =3D state;
> >>          usermodehelper_disable();
> >> +#ifdef CONFIG_HIBERNATE_CALLBACKS
> >> +       if (dpm_suspend_start(PMSG_HIBERNATE))
> >> +               goto resume_devices;
> >
> > A failure of one device may trigger a cascade of failures when trying
> > to resume devices and it is not even necessary to resume the ones that
> > have been powered off successfully.
>
> Right it "shouldn't" be necessary, but I wanted to make sure that we had
> a clean (expected) slate going into device_shutdown().
>
> Otherwise drivers might not have been prepared to go right from
> poweroff() to shutdown() callbacks.
>
> >
> > IMV this should just ignore errors during the processing of devices,
> > so maybe introduce PMSG_POWEROFF for it?
>
> Hmm - I guess it depends upon the failures that occurred.  I'll start
> plumbing a new message and see how it looks.
>
> I don't "think" we can safely call dpm_suspend_end() if
> dpm_suspend_start() failed though.

Nothing is safe at this point when dpm_suspend_start() fails, so why
not just continue.  Hopefully, it'll get to the point when power can
be turned off and then it won't matter too much anyway.
