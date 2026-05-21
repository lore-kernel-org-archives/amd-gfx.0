Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6331CD6E44
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B1B310E572;
	Tue, 26 May 2026 07:53:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZUYr4wL/";
	dkim-atps=neutral
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7166810E463
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 10:33:22 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-b936331786dso766034666b.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 03:33:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779359601; cv=none;
 d=google.com; s=arc-20240605;
 b=Mi25QMlgSEvv2Vc+dOpmrjwYQ62abb/JqNWsgP6dBYx5xQk7IWIxPj4JoEY0ggG1ni
 zqg8GiGbGwtETcZWi4hG2LLI0+VnSjhSL/ScOIgAO3fyPIjpj0n69eM+0DEbW3fZiQSm
 6THodKgpE83w2gIEL1f8Dix/4H1pxy3ax7z29fuaBnkosP3ieCqWIE85bbDTwxfzLnG5
 akFQn2ZtcO6h/8ZNMXq8vO663J8BpUSzE/B3R1DP+g93PvdJ3aokV7bClztgzG3d5uev
 wg2SKZFnD3rZSQTCzzNrPqvgzGXtxhdjwI9s/RlaxdImKc6D14w/fjm2HBK5aDUwXRCH
 hXxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IThpfbJj5lVx9bX19w2rDZ86dOF54I7D/VpHa207rl0=;
 fh=RxqLTf8TMniqfsNK/PDUt8EyIszaKkngpmxKDoAR9IQ=;
 b=HZ6mU9+Sd14ULLpbtNMtOo0/TanGY/cJ3imYBPpbUCUhHbY885nYumEkIEEeRANnzM
 AaGnTeCiT4yYrAfk8nb/rYBmz/FMCL9n8JTilY84FgaaeP+U/6/neDanA1ApRHcKZ48G
 91xsIrQV2A+hw95dxpI9jgMwEZXjV3HN3hIPhpr5EEfwU/RSJYTgg88cfOBAyHmfhmBg
 KirMglxWEGWnw6j9DNA2o1gGHTc1PjG/qZ6OmQAie0jFsCSC8xxr5VI0YS1bnBtY0KVL
 Rw0yxiBF6vYVbzJPKDwgeHmn4zjYiK6tZRs0y5iy70mi3iCTO+600T7xW+6UDuEsT82I
 tcGw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779359601; x=1779964401; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IThpfbJj5lVx9bX19w2rDZ86dOF54I7D/VpHa207rl0=;
 b=ZUYr4wL/PgdWCEAdRs0w5TteD02have3uM1xgSbLPIwFKouDDeZbAnaStPmd4p5Ep6
 yQ0VICNypaUkFfX0cK+DyUy3KLve0moKvQPQ+z0k0a/mw8PERXdBA2TmBVR3nzxgArBA
 OwzZWOTq1CV32wvDVoplaoH575vOh3WMr2sGNzyPwf8qbkS4f2KZllEpoKHGbZF7kG5w
 KBFZFnp6JGaNYPei6yB/bCyDJdyp1lpNyq/0MlfxQqw6MSepJbftWN1K1zkUnDSEgaKJ
 /guVzkqwRGh/L7IGn1Oq/wDoWHy7jlqmG6KApbIFjOq+KLb+yhG24AwokXmKFwXgDDco
 98UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779359601; x=1779964401;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IThpfbJj5lVx9bX19w2rDZ86dOF54I7D/VpHa207rl0=;
 b=kal3y8WXzKGNZ8KrG6dYA06c9N/uJDYmmKRrr/LdmfX5EQnPaJ3jeDyeninkz6OOq4
 svcsAiPyQooUQU8z5+vpaH23sdIkIzxsVTpd6aOG/yUIpaCC0AGv9tm8G1p39A/PujBe
 Cb56t3qX22SfXQ2sKIJue3islVM1mwT6aFsEdqROQf6xtzFHbjYtrMWsRwkyiMyvIT/4
 a5T4Tcwg77xA2pY7LWAfMucvHI/JC+8QDvj3TOuzCX+VD7QKgzFBtM+M39s1/W62KbUv
 NpfWHQQpYaDFcET6URisrCJrMG8NyM5Bzfe3uVS3cWY6D6o7RnNIV5sq7rU5Qj0XPkEd
 PA7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9LGbW2B22AafSIKLyy/bLQMNmiQ41bRa93t4UDzzvp01QYMb9rFpW4sXWdruh3tT6Xj3TejacF@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzOmfv/6F7hhVKA7aOH5C06JddvJWSnZ+ZRHcq/EG0WzXz5PGg4
 A3o46AuPtzW26T5V7uvoOc5PR5TCSc+wWGp4oLqp3ieBAprkQ5S1uofHrqsSNTzNswQDbJ2c7md
 mhT4zCl57PrLl7O3viJbJXo+m3Ku3rTs=
X-Gm-Gg: Acq92OGwvGQvN+buFqCVUEbHKiI+OBh01uanNtnF8cQr990hrjiWPSheWi4S4b++ogN
 an/j07nG3PfuhigyWkoPZuccLOzEOrKX3dR//l1p6Rhf1dMPP6MiiO3OasPoTQzk8guipnMKaNt
 nrYazonnBIbkitWW0JhcH21xy+V29Y2QTQNgKyyGKSX3KWXKwnC9xTy47mu9RoftulZ4JUgq07j
 zYocZ2gEifMr5q8+oQzk2blrnP+ml7CEYxjYFRPMe1B0wtC3h1UUXbrG7nAo/fiorIu8nqw7NYJ
 laEry3b7Q8jQSUrGjAhaNxpNeTvPfXKMJWVJ4Ds=
X-Received: by 2002:a17:907:c389:b0:bcc:9130:69ee with SMTP id
 a640c23a62f3a-bdc1407e248mr135759066b.32.1779359600593; Thu, 21 May 2026
 03:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260520225245.2962-1-spasswolf@web.de>
 <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>
 <s7cu3dpioidx6mepmai6eyj2pxjs4skbw7v534zbzs6g2fwcis@cvokidcxy3xa>
 <4f548d61b2dd12e01f401ce4b8c865f238f7b23c.camel@web.de> <878q9dvzh0.ffs@tglx>
 <50e5e76bc13256e3f5b3301e92f159957c3d6762.camel@web.de>
In-Reply-To: <50e5e76bc13256e3f5b3301e92f159957c3d6762.camel@web.de>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 21 May 2026 12:33:08 +0200
X-Gm-Features: AVHnY4Jje4HjIBnLpcbAm9vbr6lITbDpMmmHM3YkFG9Qov4_XQBMx4ast0LHC-8
Message-ID: <CAGudoHGk1CP3gRQLCV85AFHKx6vBEyKySOn4J+AZVAP2FkrN3g@mail.gmail.com>
Subject: Re: context switch within RCU read-side critical section in
 next-20260518+ with PREEMPT_RT
To: Bert Karwatzki <spasswolf@web.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, adobriyan@gmail.com, jack@suse.cz, 
 viro@zeniv.linux.org.uk, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 26 May 2026 07:53:08 +0000
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

On Thu, May 21, 2026 at 12:22=E2=80=AFPM Bert Karwatzki <spasswolf@web.de> =
wrote:
>
> Am Donnerstag, dem 21.05.2026 um 12:17 +0200 schrieb Thomas Gleixner:
> > On Thu, May 21 2026 at 11:20, Bert Karwatzki wrote:
> > > Am Donnerstag, dem 21.05.2026 um 11:09 +0200 schrieb Mateusz Guzik:
> > >
> > > with next-20260519 (no RT, no LOCKDEP) and got no crash so far (4 boo=
ts only though (next-20260619
> > > crashed in 2 out of 3 boots without RT)) but I get this warning on ev=
ery boot:
> > >
> > > [    2.793416] [    T331] ------------[ cut here ]------------
> > > [    2.793433] [    T331] DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
> > > [    2.793434] [    T331] WARNING: kernel/locking/mutex.c:625 at __mu=
tex_lock+0x586/0x10c0, CPU#17: (udev-worker)/331
> >
> > So either the mutex is corrupted or was never initialized.
> >
> > > [    2.793463] [    T331] Modules linked in: amdgpu(+) hid_generic us=
bhid drm_client_lib i2c_algo_bit drm_buddy hid drm_ttm_helper ttm drm_exec
> > > drm_suballoc_helper mfd_core drm_panel_backlight_quirks gpu_sched amd=
xcp drm_display_helper drm_kms_helper ahci libahci xhci_pci libata xhci_hcd=
 drm nvme
> > > scsi_mod igc usbcore nvme_core scsi_common video nvme_keyring i2c_pii=
x4 cec nvme_auth usb_common crc16 i2c_smbus wmi gpio_amdpt gpio_generic
> > > [    2.793518] [    T331] CPU: 17 UID: 0 PID: 331 Comm: (udev-worker)=
 Not tainted 7.1.0-rc4-next-20260519-rcunortlockdep-dirty #465 PREEMPT
> > > [    2.793534] [    T331] Hardware name: ASUS System Product Name/ROG=
 STRIX B850-F GAMING WIFI, BIOS 1627 02/05/2026
> > > [    2.793547] [    T331] RIP: 0010:__mutex_lock+0x58d/0x10c0
> > > [    2.793555] [    T331] Code: 4c 8b 4d 88 85 c0 0f 84 f8 fa ff ff 4=
4 8b 15 ca 9b 81 00 45 85 d2 0f 85 e8 fa ff ff 48 8d 3d 1a 57 82 00 48 c7 c=
6 a6 51 9e 83
> > > <67> 48 0f b9 3a 4c 8b 4d 88 e9 cc fa ff ff 48 8b bd 78 ff ff ff e8
> > > [    2.793579] [    T331] RSP: 0018:ffffa497016c3510 EFLAGS: 00010246
> > > [    2.793588] [    T331] RAX: 0000000000000001 RBX: ffff88c33a4c2ad8=
 RCX: 0000000000000000
> > > [    2.793598] [    T331] RDX: 0000000000000001 RSI: ffffffff839e51a6=
 RDI: ffffffff83de3c00
> > > [    2.793609] [    T331] RBP: ffffa497016c35c0 R08: ffffffffc0a55d92=
 R09: 0000000000000000
> > > [    2.793619] [    T331] R10: 0000000000000000 R11: 0000000000000000=
 R12: 0000000000000000
> > > [    2.793629] [    T331] R13: 0000000000000002 R14: ffffa497016c3550=
 R15: 0000000000268000
> > > [    2.793641] [    T331] FS:  00007f1f32e5b9c0(0000) GS:ffff88d23b2c=
a000(0000) knlGS:0000000000000000
> > > [    2.793653] [    T331] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080=
050033
> > > [    2.793662] [    T331] CR2: 000055cdfa28f588 CR3: 0000000112e73000=
 CR4: 0000000000f50ef0
> > > [    2.793673] [    T331] PKRU: 55555554
> > > [    2.793678] [    T331] Call Trace:
> > > [    2.793683] [    T331]  <TASK>
> > > [    2.793687] [    T331]  ? lock_acquire+0xbe/0x2d0
> > > [    2.793696] [    T331]  ? init_mqd+0x122/0x190 [amdgpu]
> > > [    2.793809] [    T331]  ? lock_release+0xc6/0x2a0
> > > [    2.793816] [    T331]  ? init_mqd+0x122/0x190 [amdgpu]
> > > [    2.793902] [    T331]  init_mqd+0x122/0x190 [amdgpu]
> > > [    2.793961] [    T331]  init_mqd_hiq+0xd/0x20 [amdgpu]
> > > [    2.794015] [    T331]  kq_initialize.constprop.0+0x2b8/0x370 [amd=
gpu]
> > > [    2.794071] [    T331]  kernel_queue_init+0x3f/0x60 [amdgpu]
> > > [    2.794125] [    T331]  pm_init+0x6b/0x100 [amdgpu]
> > > [    2.794178] [    T331]  start_cpsch+0x1d6/0x270 [amdgpu]
> > > [    2.794234] [    T331]  kgd2kfd_device_init.cold+0x7b9/0xa1a [amdg=
pu]
> > > [    2.794365] [    T331]  amdgpu_amdkfd_device_init+0x190/0x260 [amd=
gpu]
> >
> > amdgpu_amdkfd_device_init()
> >   kgd2kfd_device_init() {
> >       ....
> >         init_mqd()
> >           mutex_lock(... profiler_lock); <- FAIL
> >
> >       mutex_init(...profiler_lock);
> >   }
> >
> > Seems the famous graphics CI failed to catch this...
> >
> > Thanks,
> >
> >         tglx
> > ---
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > @@ -744,6 +744,9 @@ bool kgd2kfd_device_init(struct kfd_dev
> >                       KGD_ENGINE_SDMA1);
> >       kfd->shared_resources =3D *gpu_resources;
> >
> > +     kfd->profiler_process =3D NULL;
> > +     mutex_init(&kfd->profiler_lock);
> > +
> >       kfd->num_nodes =3D amdgpu_xcp_get_num_xcp(kfd->adev->xcp_mgr);
> >
> >       if (kfd->num_nodes =3D=3D 0) {
> > @@ -936,9 +939,6 @@ bool kgd2kfd_device_init(struct kfd_dev
> >
> >       svm_range_set_max_pages(kfd->adev);
> >
> > -     kfd->profiler_process =3D NULL;
> > -     mutex_init(&kfd->profiler_lock);
> > -
> >       kfd->init_complete =3D true;
> >       dev_info(kfd_device, "added device %x:%x\n", kfd->adev->pdev->ven=
dor,
> >                kfd->adev->pdev->device);
>
> Actually, when I test next-20260519 with the improved fix, I do not see
> the warning from amdgpu.
>

Can you please do the following:
1. go back to the known crashing-tag, add my fix, verify you still get
the amd splat and then try out the fix provided by Thomas
2. regardless if the above helps, can you boot a kernel built with
CONFIG_KASAN=3Dy

fwiw I verified my patch works fine with KASAN, including by
intentionally miscalculating the size of the target buffer and seeing
a nice splat from it so I'm confident I'm not corrupting anything.
However, as there are new mallocs + free flying around at early boot,
it is *plausible* amd was getting zeroed memory without asking for it
and it worked by accident.
