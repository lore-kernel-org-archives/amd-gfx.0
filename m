Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D28CA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 17:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 949C810E993;
	Wed, 10 Sep 2025 17:38:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Mfs0XGga";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8159810E993
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 17:38:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5A8AB44C63
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 17:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1450CC19422
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 17:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1757525917;
 bh=/maRrN03GREpqejLxXVtvRXFXTXkAYd7s3DzF3MkSA0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Mfs0XGgaE4FfWKqeDbTYcU010yi1fQCKbvrt6OWWm9esUIZompP/ajtnwFgNohD76
 ShfgQvk+QyHq4rhJlVQpHSZ/Lu4H3v5bve+nj8tiZ5nWeLcBB9K5eHUCZNnN1tDtGS
 UmLvPPy6/fFE1Zzp8IJwA3oixl2kKT92E8INA4siuOSrPNTPmpR4RgzrjoDIn+Pbxl
 DojEs6RPprS4Sd+J38sTaCpFjDzxyPc5PyTz8GyKw3cjznQPwjzxzJm2EWsrKmAa4K
 bDHco9AtrUyeXEmmec9M9dRVy8ggwW4FFCUoe6QptZNNE+eCVH5vIRf95LamHJBpiE
 XcThL1V+bnmEA==
Received: by mail-oo1-f48.google.com with SMTP id
 006d021491bc7-61da7b78978so4459220eaf.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 10:38:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVRSe6TdBvbVXt12Nd/ntH4BbNQ/YaKdzpuXEyq4JkDzAwCdAhAxI/dNFYP1QHTiYpmL0spNAEz@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy8R4A5v/dKAPCsnv6YfYm5qGBFvJ+dW/+mEWYfMK0g1gCGW1V/
 lBiMbrHtnY6xw/TBvcJ+BY2jrSeVaNygweVaJNgMgTPXiU8JR+inMnLUJaIkeZoOW3oSqoh6ST9
 jW6sYcspHHcjOKbUQSY9AsiJ6Evpnvrw=
X-Google-Smtp-Source: AGHT+IGHCt4j1R4FaC3Lmj2Z0gXRtZrpcrYqlzpLE4lKDo55KW3cWbFI81cNR/IODEnBUt82RlGcoSR69Iy2e6L8enw=
X-Received: by 2002:a05:6820:221e:b0:61f:f777:8e61 with SMTP id
 006d021491bc7-62178aad31fmr6849169eaf.8.1757525916115; Wed, 10 Sep 2025
 10:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250910171132.GA1541776@bhelgaas>
 <0bb2cb92-0d31-4e42-b6ef-2cc3fdf0df40@kernel.org>
In-Reply-To: <0bb2cb92-0d31-4e42-b6ef-2cc3fdf0df40@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Sep 2025 19:38:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g5GPhRkQjo-Z6gmcP7f6dsFthbaO+DT2=SnsDawi_3HA@mail.gmail.com>
X-Gm-Features: Ac12FXz69VCkP7reTy_nIeLgfD-T8DfWoDH6oE-W2ZngcIbPfm1dm4_CpZRhoRs
Message-ID: <CAJZ5v0g5GPhRkQjo-Z6gmcP7f6dsFthbaO+DT2=SnsDawi_3HA@mail.gmail.com>
Subject: Re: [PATCH v7 05/12] PCI/PM: Disable device wakeups when halting or
 powering off system
To: Mario Limonciello <superm1@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Steven Rostedt <rostedt@goodmis.org>, 
 "open list:HIBERNATION (aka Software Suspend,
 aka swsusp)" <linux-pm@vger.kernel.org>, 
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
 "open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>, 
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>, 
 "open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
 AceLan Kao <acelan.kao@canonical.com>, 
 Kai-Heng Feng <kaihengf@nvidia.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
 =?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>, 
 Eric Naim <dnaim@cachyos.org>, "Guilherme G . Piccoli" <gpiccoli@igalia.com>
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

On Wed, Sep 10, 2025 at 7:24=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> On 9/10/25 12:11 PM, Bjorn Helgaas wrote:
> > On Wed, Sep 10, 2025 at 11:52:00AM -0500, Mario Limonciello wrote:
> >> On 9/10/25 10:06 AM, Bjorn Helgaas wrote:
> >>> On Tue, Sep 09, 2025 at 02:16:12PM -0500, Mario Limonciello (AMD) wro=
te:
> >>>> PCI devices can be configured as wakeup sources from low power state=
s.
> >>>> However, when the system is halting or powering off such wakeups are
> >>>> not expected and may lead to spurious behavior.
> >>>
> >>> I'm a little unclear on the nomenclature for these low power states,
> >>> so I think it would be helpful to connect to the user action, e.g.,
> >>> suspend/hibernate/etc, and the ACPI state, e.g.,
> >>>
> >>>     ... when the system is hibernating (e.g., transitioning to ACPI S=
4
> >>>     and halting) or powering off (e.g., transitioning to ACPI S5 soft
> >>>     off), such wakeups are not expected ...
> >>
> >> I will try to firm it up in the commit message.  But yes you're gettin=
g the
> >> intent, having a wakeup occur at S5 would be unexpected, and would lik=
ely
> >> change semantics of what people "think" powering off a machine means.
> >>
> >>> When I suspend or power off my laptop from the GUI user interface, I
> >>> want to know if keyboard or mouse activity will resume or if I need t=
o
> >>> press the power button.
> >>
> >> The way the kernel is set up today you get a single wakeup sysfs file =
for a
> >> device and that wakeup file means 3 things:
> >> * abort the process of entering a suspend state or hibernate
> >> * wake up the machine from a suspend state
> >> * wake up the machine from hibernate
> >>
> >>>> ACPI r6.5, section 16.1.5 notes:
> >>>>
> >>>>       "Hardware does allow a transition to S0 due to power button pr=
ess
> >>>>        or a Remote Start."
> >>>
> >>> Important to note here that sec 16.1.5 is specifically for "S5
> >>> Soft Off State".
> >>>
> >>> S4 is a sleeping state and presumably sec 16.1.6 ("Transitioning
> >>> from the Working to the Sleeping State") applies.  That section
> >>> mentions wakeup devices, so it's not obvious to me that PCI device
> >>> wakeup should be disabled for S4.
> >>
> >> It actually /shouldn't/ be disabled for S4 - it should only be
> >> disabled for S5.
> >>
> >> Are you implying a bug in the flow?  I didn't think there was one:
> >>
> >> During entering hibernate the poweroff() call will have system_state
> >> =3D SYSTEM_SUSPEND so wakeups would be enabled.
> >>
> >> For powering off the system using hibernate flows poweroff() call
> >> would have system_state =3D SYSTEM_HALT or SYSTEM_POWER_OFF.
> >
> > OK.  I assumed that since you check for two states (SYSTEM_HALT or
> > SYSTEM_POWER_OFF), one must be hibernate (ending up in S4?) and the
> > other a soft power off (ending up in S5?).
> >
> > But it sounds like there are two ways to power off.  I'm just confused
> > about the correspondence between hibernate, soft poweroff, S4, S5,
> > SYSTEM_HALT, and SYSTEM_POWER_OFF.
> >
> > *Do* both SYSTEM_HALT and SYSTEM_POWER_OFF lead to S5 on an ACPI
> > system?  If so, what's the difference between them?
>
> The two functions are kernel_halt() and kernel_power_off().
>
> And looking again, Ahhhh!  kernel_power_off() is the only thing that
> actually leads to machine_power_off().  Halt just stops the CPUs.
>
> I think we should only be using the hibernate flows for SYSTEM_POWER_OFF.

That's correct.
