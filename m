Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C15BCD6E53
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D09EF10E596;
	Tue, 26 May 2026 07:53:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=spasswolf@web.de header.b="uEkMr9m4";
	dkim-atps=neutral
X-Greylist: delayed 323 seconds by postgrey-1.36 at gabe;
 Thu, 21 May 2026 10:27:28 UTC
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 053E010E463
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 10:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1779359246; x=1779964046; i=spasswolf@web.de;
 bh=4FoIHMcOrI635YiW+HyzjAWHWLQFgvtUGIwIwRoN2Fk=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=uEkMr9m4OEyNU3vxOyOmS8W59fkHyU8QoDcrVQvgPVrqNWkBfqqrIdy5KTZn1aw8
 c4hJotawYT/xAaJd81Mma8fR8kMV5DA5Dva5VjMclrIhCNt5Ybsn7vy8etHHFv1Q/
 UQLD8HIUo/EmfoYUCkqzcNaM02SGIZL46sT+o6RDQ+4xunUJ0oe5lqohgqKUUOZ2x
 ocfiAKnZlD4g4QNHvB7TQURSBsx+S/llL5rpSBLwuPRl56e+N1xsQA9MJtWcuBqip
 l0TcEP9vTqvToZwimyrMYCTlJnQ2vvpNazjceYiVnB8gyjPKhF0AGu3RAamk0hlhK
 QSgVLyX9iOCb29zRlw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MA4bO-1wW5M00zc2-002ew9; Thu, 21
 May 2026 12:21:54 +0200
Message-ID: <50e5e76bc13256e3f5b3301e92f159957c3d6762.camel@web.de>
Subject: Re: context switch within RCU read-side critical section in
 next-20260518+ with PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Thomas Gleixner <tglx@linutronix.de>, Mateusz Guzik <mjguzik@gmail.com>,
 Christian Brauner	 <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 adobriyan@gmail.com, jack@suse.cz, viro@zeniv.linux.org.uk, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, spasswolf@web.de, Alex Deucher
 <alexander.deucher@amd.com>, 	amd-gfx@lists.freedesktop.org
Date: Thu, 21 May 2026 12:21:52 +0200
In-Reply-To: <878q9dvzh0.ffs@tglx>
References: <20260520225245.2962-1-spasswolf@web.de>
 <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>
 <s7cu3dpioidx6mepmai6eyj2pxjs4skbw7v534zbzs6g2fwcis@cvokidcxy3xa>
 <4f548d61b2dd12e01f401ce4b8c865f238f7b23c.camel@web.de>
 <878q9dvzh0.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4iP9zOnKni3WV6YMmhQUFkbEWic3hGUhYQhXDwRDRWq2hYiJY0W
 eFPLypcpDfmDZuyJA+BbYai2x0AK8VP0xiYEfA5/+D70TIcVJUeh9AhafsOVb3FgUFxudsz
 4p9x2Ai8OVNMdG+3AJdfltptywJGyyun1KT2d1e1zUkHbE3KjNkB5uOAwPv3/QNg1l/wYVN
 6S6GhXbshw4V8jbL+vjLA==
UI-OutboundReport: notjunk:1;M01:P0:a7uPNT3ts/I=;dyfPiJ39jsBhZTNIOocpcQVYY8f
 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
 HPI06A==
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

Am Donnerstag, dem 21.05.2026 um 12:17 +0200 schrieb Thomas Gleixner:
> On Thu, May 21 2026 at 11:20, Bert Karwatzki wrote:
> > Am Donnerstag, dem 21.05.2026 um 11:09 +0200 schrieb Mateusz Guzik:
> >=20
> > with next-20260519 (no RT, no LOCKDEP) and got no crash so far (4 boot=
s only though (next-20260619
> > crashed in 2 out of 3 boots without RT)) but I get this warning on eve=
ry boot:
> >=20
> > [    2.793416] [    T331] ------------[ cut here ]------------
> > [    2.793433] [    T331] DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
> > [    2.793434] [    T331] WARNING: kernel/locking/mutex.c:625 at __mut=
ex_lock+0x586/0x10c0, CPU#17: (udev-worker)/331
>=20
> So either the mutex is corrupted or was never initialized.
>=20
> > [    2.793463] [    T331] Modules linked in: amdgpu(+) hid_generic usb=
hid drm_client_lib i2c_algo_bit drm_buddy hid drm_ttm_helper ttm drm_exec
> > drm_suballoc_helper mfd_core drm_panel_backlight_quirks gpu_sched amdx=
cp drm_display_helper drm_kms_helper ahci libahci xhci_pci libata xhci_hcd=
 drm nvme
> > scsi_mod igc usbcore nvme_core scsi_common video nvme_keyring i2c_piix=
4 cec nvme_auth usb_common crc16 i2c_smbus wmi gpio_amdpt gpio_generic
> > [    2.793518] [    T331] CPU: 17 UID: 0 PID: 331 Comm: (udev-worker) =
Not tainted 7.1.0-rc4-next-20260519-rcunortlockdep-dirty #465 PREEMPT=20
> > [    2.793534] [    T331] Hardware name: ASUS System Product Name/ROG =
STRIX B850-F GAMING WIFI, BIOS 1627 02/05/2026
> > [    2.793547] [    T331] RIP: 0010:__mutex_lock+0x58d/0x10c0
> > [    2.793555] [    T331] Code: 4c 8b 4d 88 85 c0 0f 84 f8 fa ff ff 44=
 8b 15 ca 9b 81 00 45 85 d2 0f 85 e8 fa ff ff 48 8d 3d 1a 57 82 00 48 c7 c=
6 a6 51 9e 83
> > <67> 48 0f b9 3a 4c 8b 4d 88 e9 cc fa ff ff 48 8b bd 78 ff ff ff e8
> > [    2.793579] [    T331] RSP: 0018:ffffa497016c3510 EFLAGS: 00010246
> > [    2.793588] [    T331] RAX: 0000000000000001 RBX: ffff88c33a4c2ad8 =
RCX: 0000000000000000
> > [    2.793598] [    T331] RDX: 0000000000000001 RSI: ffffffff839e51a6 =
RDI: ffffffff83de3c00
> > [    2.793609] [    T331] RBP: ffffa497016c35c0 R08: ffffffffc0a55d92 =
R09: 0000000000000000
> > [    2.793619] [    T331] R10: 0000000000000000 R11: 0000000000000000 =
R12: 0000000000000000
> > [    2.793629] [    T331] R13: 0000000000000002 R14: ffffa497016c3550 =
R15: 0000000000268000
> > [    2.793641] [    T331] FS:  00007f1f32e5b9c0(0000) GS:ffff88d23b2ca=
000(0000) knlGS:0000000000000000
> > [    2.793653] [    T331] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
> > [    2.793662] [    T331] CR2: 000055cdfa28f588 CR3: 0000000112e73000 =
CR4: 0000000000f50ef0
> > [    2.793673] [    T331] PKRU: 55555554
> > [    2.793678] [    T331] Call Trace:
> > [    2.793683] [    T331]  <TASK>
> > [    2.793687] [    T331]  ? lock_acquire+0xbe/0x2d0
> > [    2.793696] [    T331]  ? init_mqd+0x122/0x190 [amdgpu]
> > [    2.793809] [    T331]  ? lock_release+0xc6/0x2a0
> > [    2.793816] [    T331]  ? init_mqd+0x122/0x190 [amdgpu]
> > [    2.793902] [    T331]  init_mqd+0x122/0x190 [amdgpu]
> > [    2.793961] [    T331]  init_mqd_hiq+0xd/0x20 [amdgpu]
> > [    2.794015] [    T331]  kq_initialize.constprop.0+0x2b8/0x370 [amdg=
pu]
> > [    2.794071] [    T331]  kernel_queue_init+0x3f/0x60 [amdgpu]
> > [    2.794125] [    T331]  pm_init+0x6b/0x100 [amdgpu]
> > [    2.794178] [    T331]  start_cpsch+0x1d6/0x270 [amdgpu]
> > [    2.794234] [    T331]  kgd2kfd_device_init.cold+0x7b9/0xa1a [amdgp=
u]
> > [    2.794365] [    T331]  amdgpu_amdkfd_device_init+0x190/0x260 [amdg=
pu]
>=20
> amdgpu_amdkfd_device_init()
>   kgd2kfd_device_init() {
>       ....
>         init_mqd()
>           mutex_lock(... profiler_lock); <- FAIL
>=20
>       mutex_init(...profiler_lock);
>   }
>=20
> Seems the famous graphics CI failed to catch this...
>=20
> Thanks,
>=20
>         tglx
> ---
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -744,6 +744,9 @@ bool kgd2kfd_device_init(struct kfd_dev
>  			KGD_ENGINE_SDMA1);
>  	kfd->shared_resources =3D *gpu_resources;
> =20
> +	kfd->profiler_process =3D NULL;
> +	mutex_init(&kfd->profiler_lock);
> +
>  	kfd->num_nodes =3D amdgpu_xcp_get_num_xcp(kfd->adev->xcp_mgr);
> =20
>  	if (kfd->num_nodes =3D=3D 0) {
> @@ -936,9 +939,6 @@ bool kgd2kfd_device_init(struct kfd_dev
> =20
>  	svm_range_set_max_pages(kfd->adev);
> =20
> -	kfd->profiler_process =3D NULL;
> -	mutex_init(&kfd->profiler_lock);
> -
>  	kfd->init_complete =3D true;
>  	dev_info(kfd_device, "added device %x:%x\n", kfd->adev->pdev->vendor,
>  		 kfd->adev->pdev->device);

Actually, when I test next-20260519 with the improved fix, I do not see
the warning from amdgpu.

diff --git a/fs/filesystems.c b/fs/filesystems.c
index 771fc31a69b8..712316a1e3e0 100644
=2D-- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -269,7 +269,7 @@ static __cold noinline int regen_filesystems_string(vo=
id)
 	hlist_for_each_entry_rcu(p, &file_systems, list) {
 		if (!(p->fs_flags & FS_REQUIRES_DEV))
 			newlen +=3D strlen("nodev");
-		newlen +=3D strlen("\t") + strlen(p->name) +  strlen("\n");
+		newlen +=3D strlen("\t") + strlen(p->name) + strlen("\n");
 	}
 	spin_unlock(&file_systems_lock);
=20
@@ -289,6 +289,7 @@ static __cold noinline int regen_filesystems_string(vo=
id)
 	 * Did someone beat us to it?
 	 */
 	if (old && old->gen =3D=3D file_systems_gen) {
+		spin_unlock(&file_systems_lock);
 		kfree(new);
 		return 0;
 	}
@@ -297,6 +298,7 @@ static __cold noinline int regen_filesystems_string(vo=
id)
 	 * Did the list change in the meantime?
 	 */
 	if (gen !=3D file_systems_gen) {
+		spin_unlock(&file_systems_lock);
 		kfree(new);
 		goto retry;
 	}
@@ -321,13 +323,12 @@ static __cold noinline int regen_filesystems_string(=
void)
 		 * generation above and messes it up.
 		 */
 		spin_unlock(&file_systems_lock);
-		if (old)
-			kfree_rcu(old, rcu);
+		kfree(new);
 		return -EINVAL;
 	}
=20
 	/*
-	 * Paired with consume fence in READ_ONCE() in filesystems_proc_show()
+	 * Paired with consume fence in rcu_dereference() in filesystems_proc_sh=
ow()
 	 */
 	smp_store_release(&file_systems_string, new);
 	spin_unlock(&file_systems_lock);

Bert Karwatzki
