Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBBD4C54754
	for <amd-gfx@archiver.kernel.org>; Fri, 16 May 2025 14:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93CA710EAF7;
	Fri, 16 May 2025 14:58:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V6xMM9Jw";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DF0810EAFA
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 14:58:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 8B18CA4E876
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 14:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C037C4CEE4
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 14:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747407525;
 bh=hDbT6l8Ra4g1YkirifZKoYMzeq+3uNXkWZ7n3nMfPI8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=V6xMM9JwEfvlz1axejebsqy7HHf6Fip3sstL6Sgp+uQ/M+5YQpvGbMSj7tWa7P4Kh
 gPzHqZct2qk6Jj2jZ3KWGdr9FkAioGUV5xb8O3uhHJ7Ij1OnApX9wR1FaMjGQIx4nQ
 YXgkij3UEeE8qCfCiEhDzy/O//cmoJT9Bd7Ngfw6xJERTATXOmM8i0ku9jAcgUwWVz
 vqdk6Bpuf4mnYOm84fkg3qtzwA7+IFO250Y6zuFhXuYq+2M+cxA0HCqPlXwMGYIuJg
 pM4ZuFeofvURRluv165gKSjhz128QC86DfzOofsfFarLShF7HQr7wX4ybN/17+3L3n
 Rwgq3d2ir+MNg==
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so2383050b3a.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 07:58:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCU9sK0cZWy/pj5DOxM4sq+ehvE0hxIbO7/xFM4OzkSG8Oj43LMww40YgHUuhQ1AEvUu/rZs0BaB@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxubqNUzVCAA2M+zH61jvs57sMszSL21TZUErIpk+TSuiGSjINg
 RV96MquYi22zysV+b4atiG0pOSQModmfW4nJL5wrpw/B8C2P/bXQL4EV3iNNXJRqXdP0WHDO+4h
 WLRAOZTtarUIQTTq7n3/JitayZCjQVpY=
X-Google-Smtp-Source: AGHT+IF5oHQ3XiAHYu26SgYpqkEnmMVmix54PXMDrlWr+tTbxJJdHTghAEF9U7opguKYaqW8+b2I34wPBroq6Ou90Xg=
X-Received: by 2002:a05:6820:1792:b0:608:3f1d:bbdb with SMTP id
 006d021491bc7-609f37ac4d0mr1916015eaf.8.1747407513779; Fri, 16 May 2025
 07:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250514193406.3998101-1-superm1@kernel.org>
 <20250514193406.3998101-2-superm1@kernel.org>
In-Reply-To: <20250514193406.3998101-2-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 May 2025 16:58:22 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jifqTP_eZ33nBmKPCuLWrrVF_0jNGf5CpHU6nXuK8qBw@mail.gmail.com>
X-Gm-Features: AX0GCFvRVOcB0kGKWz9Xrc6Hm7LoXkhsAklO5VHQqK_W1PeYhcRLJ3-5UfSo-D0
Message-ID: <CAJZ5v0jifqTP_eZ33nBmKPCuLWrrVF_0jNGf5CpHU6nXuK8qBw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] PM: Use hibernate flows for system power off
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
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

On Wed, May 14, 2025 at 9:34=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> When the system is powered off the kernel will call device_shutdown()
> which will issue callbacks into PCI core to wake up a device and call
> it's shutdown() callback.  This will leave devices in ACPI D0 which can
> cause some devices to misbehave with spurious wakeups and also leave some
> devices on which will consume power needlessly.
>
> The issue won't happen if the device is in D3 before system shutdown, so
> putting device to low power state before shutdown solves the issue.
>
> ACPI Spec 6.5, "7.4.2.5 System \_S4 State" says "Devices states are
> compatible with the current Power Resource states. In other words, all
> devices are in the D3 state when the system state is S4."
>
> The following "7.4.2.6 System \_S5 State (Soft Off)" states "The S5
> state is similar to the S4 state except that OSPM does not save any
> context." so it's safe to assume devices should be at D3 for S5.
>
> To accomplish this, modify the PM core to call all the device hibernate
> callbacks when turning off the system when the kernel is compiled with
> hibernate support. If compiled without hibernate support or hibernate fai=
ls
> fall back into the previous shutdown flow.
>
> Cc: AceLan Kao <acelan.kao@canonical.com>
> Cc: Kai-Heng Feng <kaihengf@nvidia.com>
> Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
> Cc: Merthan Karaka=C5=9F <m3rthn.k@gmail.com>
> Tested-by: Denis Benato <benato.denis96@gmail.com>
> Link: https://lore.kernel.org/linux-pci/20231213182656.6165-1-mario.limon=
ciello@amd.com/
> Link: https://lore.kernel.org/linux-pci/20250506041934.1409302-1-superm1@=
kernel.org/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>  * Handle failures to hibernate (fall back to shutdown)
>  * Don't use dedicated events
>  * Only allow under CONFIG_HIBERNATE_CALLBACKS
> ---
>  kernel/reboot.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index ec087827c85cd..52f5e6e36a6f8 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -13,6 +13,7 @@
>  #include <linux/kexec.h>
>  #include <linux/kmod.h>
>  #include <linux/kmsg_dump.h>
> +#include <linux/pm.h>
>  #include <linux/reboot.h>
>  #include <linux/suspend.h>
>  #include <linux/syscalls.h>
> @@ -305,6 +306,17 @@ static void kernel_shutdown_prepare(enum system_stat=
es state)
>                 (state =3D=3D SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF, NU=
LL);
>         system_state =3D state;
>         usermodehelper_disable();
> +#ifdef CONFIG_HIBERNATE_CALLBACKS
> +       if (dpm_suspend_start(PMSG_HIBERNATE))
> +               goto resume_devices;

A failure of one device may trigger a cascade of failures when trying
to resume devices and it is not even necessary to resume the ones that
have been powered off successfully.

IMV this should just ignore errors during the processing of devices,
so maybe introduce PMSG_POWEROFF for it?

It should also ignore wakeup events that occur while devices are powered of=
f.

> +       if (dpm_suspend_end(PMSG_HIBERNATE))
> +               goto resume_devices;
> +       return;
> +
> +resume_devices:
> +       pr_emerg("Failed to power off devices, using shutdown instead.\n"=
);
> +       dpm_resume_end(PMSG_RESTORE);

Unfortunately, PMSG_RESTORE is not the right resume action for
PMSG_HIBERNATE because it may not power-up things (some drivers assume
that the restore kernel will power-up devices and so they don't do it
in "restore" callbacks).

I do realize that hibernation uses it to reverse PMSG_HIBERNATE, but
it should not do that either.  That may be fixed later, though.

> +#endif
>         device_shutdown();
>  }
>  /**
> --

I'd prefer to get back to this series after the 6.16 merge window
starts.  It is sort of last minute for 6.16 and it is far from ready
IMV.

Thanks!
