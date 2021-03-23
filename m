Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DEFC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 15:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48DDA6191A
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 15:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48DDA6191A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D91316E96E;
	Tue, 23 Mar 2021 15:28:51 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AC546EA7A
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 15:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1616513327;
 bh=XoYQgxkZ7UzcuBJ6V8EAU9HMx8R2VBaq04QF8534fyA=;
 h=X-UI-Sender-Class:Reply-To:Subject:To:References:From:Date:
 In-Reply-To;
 b=R9BnLpopJ/jmU7eJP1EQesmJtqQSaPTgZPNsRvEZMkhOq2fKKV+KJ77oTyxTmJiSr
 L3y9H5GBM8ErZ3CwH/cQPDdSy47A4a0nSoKXZB3DqMZBKarMyVoVmk82oG2QGIfjzb
 KvJBMza8kweZS80o6Qfo+DSRDiXIMFxCcPp9xIns=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.1] ([178.27.134.71]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3bSj-1lp5dE1i55-010dfv for
 <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 16:28:47 +0100
Subject: Re: Amdgpu kernel oops and freezing on system suspend and hibernate
To: amd-gfx@lists.freedesktop.org
References: <9f9f69fa-4638-673f-6695-1171e927a80b@gmx.de>
 <MN2PR12MB4488704D527398352637AC61F76A9@MN2PR12MB4488.namprd12.prod.outlook.com>
 <a8ad9295-196c-77cf-ca63-161fb97632cb@gmx.de>
 <CADnq5_Oe6PHz5rQ9u5T2M3ZKhWE+fuj5CD2ngvXRiZFeZprS=Q@mail.gmail.com>
From: Harvey <harv@gmx.de>
Message-ID: <ef1b7ff1-b926-8651-3ff6-9c05bd8b234f@gmx.de>
Date: Tue, 23 Mar 2021 16:26:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CADnq5_Oe6PHz5rQ9u5T2M3ZKhWE+fuj5CD2ngvXRiZFeZprS=Q@mail.gmail.com>
X-Provags-ID: V03:K1:BsZ9jhU8UakYWQDaa2FeHrcHEtEXGn4T5gsnn3xaXM94hPyRTG7
 5EyWwUcs7jyQLcob6AUsbEi3IyCUagNvCyYB43t4qSDwh6jIH1XCDzL4FhsJmlIU0llDIhL
 nzHbyQvzJge6J+Vu6bN75QFPhWTVaO3Vqz26AsZcxbnJhFEZPAs+0VYJmQ4anrLw5jx7Ynm
 lqyCvitflfhYSmy9CqhYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lVAbDe735GE=:3FrODUrJhO9GPo7CsRC1j6
 NDxmQWwnI2dpfdES4kKgRI0tgYVlIOhDxUKR++HbX8ajoHx/yDkxhUWMsramMxpWYFxKMKUqO
 zugyICW2zdX4+cdptvW0iTPL7vuv3AHFZesIJiYInvFfFSYPKKaM/OJS1UzX42JjAbI61T2lm
 GbsOs/1XHyGsM0jFcrrmGmfkALRME5gJqtF+TXX+0nun+YPAYqjLjRozLCYu0iZWvPUQ+RWC/
 ukHS8d8geFZVEXUilJT8xIAS1jDO5rZB3R7p/3qKc44rmKcHacCwEeV2T8F4tgFIKXj0x0dA7
 P6jSHZquCwryPW2/uRSgqyRC6hhki5xQymTZlD8LcbhzkNS5x5tRAQ/NNN5w1nonx2PVSZKz6
 WRHEsIVBZ+nAf5Qi+kyPx418yo4sSNZUQWbwfdFNr+ig5v/FGRvypW9oxiIzoimNfOj7uuyJY
 UDEgfEc05jmr9cmLPLbx1F8ZBfrLRk85/6xot4aZ/9IJc3cTnEqWewYsxfNWEmFXcYQQdzQM1
 V0a/Wwq8gv6sN1g+bJDk0qA4L6eZvt+EEICREWRNTQyBEgp6qgzHde6LSW3vB4/0nMk5RnyX7
 quYzvLxgckMrFYFzB3KaZn1QOhUjD/hmcJ+RQ//9c6uu3YiBaQbnTNT0zZtX+7+UdDV+sfTUM
 LUqyeCBOTMVEqnWUB0kV3EHn3Px7SyZ0lCgVwLKVo6mcf5eRS8ITQbZE/6Ip2O9B7HVfBTdNv
 24KJs4qDYbyZJIn+9fnnD14diAVqlvG/gCV72LAaOdmgAgPBM3kHmHohHtlE6PDQQYI243gfl
 NEu+9TT3NB5DlRGuuXOzjXzS8eJUq2WIs7vDmjmC72mhl76ojauggkx3j5IfpMfYVlk58n54r
 C9X8eCMXkiMBDVyI3LPQ==
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
Reply-To: harv@gmx.de
Content-Type: multipart/mixed; boundary="===============1509580420=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1509580420==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zLZGM7OOWeRpcu8S0zaQgfOlkoT6YsycL"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zLZGM7OOWeRpcu8S0zaQgfOlkoT6YsycL
Content-Type: multipart/mixed; boundary="BfJKeOMIH72m25XEBJN1VmhuKvkEcAkDp";
 protected-headers="v1"
From: Harvey <harv@gmx.de>
Reply-To: harv@gmx.de
To: amd-gfx@lists.freedesktop.org
Message-ID: <ef1b7ff1-b926-8651-3ff6-9c05bd8b234f@gmx.de>
Subject: Re: Amdgpu kernel oops and freezing on system suspend and hibernate
References: <9f9f69fa-4638-673f-6695-1171e927a80b@gmx.de>
 <MN2PR12MB4488704D527398352637AC61F76A9@MN2PR12MB4488.namprd12.prod.outlook.com>
 <a8ad9295-196c-77cf-ca63-161fb97632cb@gmx.de>
 <CADnq5_Oe6PHz5rQ9u5T2M3ZKhWE+fuj5CD2ngvXRiZFeZprS=Q@mail.gmail.com>
In-Reply-To: <CADnq5_Oe6PHz5rQ9u5T2M3ZKhWE+fuj5CD2ngvXRiZFeZprS=Q@mail.gmail.com>

--BfJKeOMIH72m25XEBJN1VmhuKvkEcAkDp
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Alex,

thanks for the hint, but...

Is this patch intended for kernel 5.11.8?

I applied the patch against 5.11.8 and it is freezing again:


M=C3=A4r 23 16:18:51 obelix kernel: [drm:amdgpu_dm_atomic_commit_tail=20
[amdgpu]] *ERROR* Waiting for fences timed out!
M=C3=A4r 23 16:18:51 obelix kernel: [drm:amdgpu_dm_atomic_commit_tail=20
[amdgpu]] *ERROR* Waiting for fences timed out!
M=C3=A4r 23 16:18:51 obelix kernel: [drm:amdgpu_job_timedout [amdgpu]]=20
*ERROR* ring sdma0 timeout, signaled seq=3D615, emitted seq=3D617
M=C3=A4r 23 16:18:51 obelix kernel: [drm:amdgpu_job_timedout [amdgpu]]=20
*ERROR* Process information: process  pid 0 thread  pid 0
M=C3=A4r 23 16:18:51 obelix kernel: amdgpu 0000:03:00.0: amdgpu: GPU rese=
t begin!
M=C3=A4r 23 16:18:51 obelix kernel: BUG: kernel NULL pointer dereference,=
=20
address: 0000000000000029
M=C3=A4r 23 16:18:51 obelix kernel: #PF: supervisor read access in kernel=
 mode
M=C3=A4r 23 16:18:51 obelix kernel: #PF: error_code(0x0000) - not-present=
 page
M=C3=A4r 23 16:18:51 obelix kernel: PGD 0 P4D 0
M=C3=A4r 23 16:18:51 obelix kernel: Oops: 0000 [#1] PREEMPT SMP NOPTI
M=C3=A4r 23 16:18:51 obelix kernel: CPU: 12 PID: 178 Comm: kworker/12:1 N=
ot=20
tainted 5.11.8-arch1-1-custom #1
M=C3=A4r 23 16:18:51 obelix kernel: Hardware name: Micro-Star Internation=
al=20
Co., Ltd. Bravo 17 A4DDR/MS-17FK, BIOS E17FKAMS.117 10/29/2020
M=C3=A4r 23 16:18:51 obelix kernel: Workqueue: events drm_sched_job_timed=
out=20
[gpu_sched]
M=C3=A4r 23 16:18:51 obelix kernel: RIP: 0010:kernel_queue_uninit+0xd/0xf=
0=20
[amdgpu]
M=C3=A4r 23 16:18:51 obelix kernel: Code: ee 48 89 c7 e8 a4 f9 ff ff 84 c=
0 0f=20
84 e3 d3 1f 00 4c 89 e0 5d 41 5c 41 5d c3 0f 1f 00 0f 1f 44 00 00 55 48=20
8b 47 10 48 89 fd <8b> 50 28 83 fa 02 74 78 83 fa 03 0f 84 b1 00 00 00=20
48 8b 7f 08 4c
M=C3=A4r 23 16:18:51 obelix kernel: RSP: 0018:ffffa35d806dfd40 EFLAGS: 00=
010246
M=C3=A4r 23 16:18:51 obelix kernel: RAX: 0000000000000001 RBX:=20
ffff8b044c5ee000 RCX: 000000000080005b
M=C3=A4r 23 16:18:51 obelix kernel: RDX: 000000000080005c RSI:=20
0000000000000001 RDI: ffff8b044a877bc0
M=C3=A4r 23 16:18:51 obelix kernel: RBP: ffff8b044a877bc0 R08:=20
0000000000000001 R09: 0000000000000000
M=C3=A4r 23 16:18:51 obelix kernel: R10: 0000000000000000 R11:=20
ffffffffafccba00 R12: ffff8b044c5ee0d0
M=C3=A4r 23 16:18:51 obelix kernel: R13: ffff8b044bf60000 R14:=20
ffff8b04414a1000 R15: ffff8b04414a10c8
M=C3=A4r 23 16:18:51 obelix kernel: FS:  0000000000000000(0000)=20
GS:ffff8b075f900000(0000) knlGS:0000000000000000
M=C3=A4r 23 16:18:51 obelix kernel: CS:  0010 DS: 0000 ES: 0000 CR0:=20
0000000080050033
M=C3=A4r 23 16:18:51 obelix kernel: CR2: 0000000000000029 CR3:=20
00000001ab010000 CR4: 0000000000350ee0
M=C3=A4r 23 16:18:51 obelix kernel: Call Trace:
M=C3=A4r 23 16:18:51 obelix kernel:  stop_cpsch+0xa0/0xc0 [amdgpu]
M=C3=A4r 23 16:18:51 obelix kernel:  kgd2kfd_suspend.part.0+0x2f/0x40 [am=
dgpu]
M=C3=A4r 23 16:18:51 obelix kernel:  kgd2kfd_pre_reset+0x3f/0x50 [amdgpu]=

M=C3=A4r 23 16:18:51 obelix kernel:=20
amdgpu_device_gpu_recover.cold+0x36e/0x95d [amdgpu]
M=C3=A4r 23 16:18:51 obelix kernel:  amdgpu_job_timedout+0x121/0x140 [amd=
gpu]
M=C3=A4r 23 16:18:51 obelix kernel:  drm_sched_job_timedout+0x64/0xe0 [gp=
u_sched]
M=C3=A4r 23 16:18:51 obelix kernel:  process_one_work+0x214/0x3e0
M=C3=A4r 23 16:18:51 obelix kernel:  worker_thread+0x4d/0x3d0
M=C3=A4r 23 16:18:51 obelix kernel:  ? rescuer_thread+0x3c0/0x3c0
M=C3=A4r 23 16:18:51 obelix kernel:  kthread+0x133/0x150
M=C3=A4r 23 16:18:51 obelix kernel:  ? __kthread_bind_mask+0x60/0x60
M=C3=A4r 23 16:18:51 obelix kernel:  ret_from_fork+0x22/0x30
M=C3=A4r 23 16:18:51 obelix kernel: Modules linked in: rfcomm=20
snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio=20
snd_hda_codec_hdmi cmac algif_hash snd_hda_intel algif_skcipher=20
snd_intel_dspcfg soundwire_intel af_alg soundwire_ge>
M=C3=A4r 23 16:18:51 obelix kernel:  sr_mod cdrom uas usb_storage dm_cryp=
t=20
cbc encrypted_keys dm_mod trusted tpm crct10dif_pclmul crc32_pclmul=20
crc32c_intel ghash_clmulni_intel aesni_intel crypto_simd cryptd=20
glue_helper serio_raw ccp xhc>
M=C3=A4r 23 16:18:51 obelix kernel: CR2: 0000000000000029
M=C3=A4r 23 16:18:51 obelix kernel: ---[ end trace 8a72c5e07cbe6b63 ]---
M=C3=A4r 23 16:18:51 obelix kernel: RIP: 0010:kernel_queue_uninit+0xd/0xf=
0=20
[amdgpu]
M=C3=A4r 23 16:18:51 obelix kernel: Code: ee 48 89 c7 e8 a4 f9 ff ff 84 c=
0 0f=20
84 e3 d3 1f 00 4c 89 e0 5d 41 5c 41 5d c3 0f 1f 00 0f 1f 44 00 00 55 48=20
8b 47 10 48 89 fd <8b> 50 28 83 fa 02 74 78 83 fa 03 0f 84 b1 00 00 00=20
48 8b 7f 08 4c
M=C3=A4r 23 16:18:51 obelix kernel: RSP: 0018:ffffa35d806dfd40 EFLAGS: 00=
010246
M=C3=A4r 23 16:18:51 obelix kernel: RAX: 0000000000000001 RBX:=20
ffff8b044c5ee000 RCX: 000000000080005b
M=C3=A4r 23 16:18:51 obelix kernel: RDX: 000000000080005c RSI:=20
0000000000000001 RDI: ffff8b044a877bc0
M=C3=A4r 23 16:18:51 obelix kernel: RBP: ffff8b044a877bc0 R08:=20
0000000000000001 R09: 0000000000000000
M=C3=A4r 23 16:18:51 obelix kernel: R10: 0000000000000000 R11:=20
ffffffffafccba00 R12: ffff8b044c5ee0d0
M=C3=A4r 23 16:18:51 obelix kernel: R13: ffff8b044bf60000 R14:=20
ffff8b04414a1000 R15: ffff8b04414a10c8
M=C3=A4r 23 16:18:51 obelix kernel: FS:  0000000000000000(0000)=20
GS:ffff8b075f900000(0000) knlGS:0000000000000000
M=C3=A4r 23 16:18:51 obelix kernel: CS:  0010 DS: 0000 ES: 0000 CR0:=20
0000000080050033
M=C3=A4r 23 16:18:51 obelix kernel: CR2: 0000000000000029 CR3:=20
0000000105594000 CR4: 0000000000350ee0
M=C3=A4r 23 16:19:10 obelix systemd[1]: systemd-hostnamed.service:=20
Deactivated successfully.
M=C3=A4r 23 16:19:10 obelix audit[1]: SERVICE_STOP pid=3D1 uid=3D0=20
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-hostnamed=20
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?=20
terminal=3D? res=3Dsuccess'
M=C3=A4r 23 16:19:10 obelix kernel: [drm:amdgpu_dm_atomic_commit_tail=20
[amdgpu]] *ERROR* Waiting for fences timed out!

Greetings
Harvey

Am 22.03.21 um 20:22 schrieb Alex Deucher:
> On Thu, Mar 18, 2021 at 8:19 AM Harvey <harv@gmx.de> wrote:
>>
>> Alex,
>>
>> I waited for kernel 5.11.7 to hit our repos yesterday evening and test=
ed
>> again:
>>
>> 1. The suspend issue is gone - suspend and resume now work as expected=
=2E
>>
>> 2. System hibernation seems to be a different beast - still freezing
>=20
> You need this patch:
> https://gitlab.freedesktop.org/agd5f/linux/-/commit/711c13547aad08f2cfe=
996e0cddc3d56f1233081
>=20
> Alex
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>=20

--=20
I am root. If you see me laughing, you'd better have a backup!


--BfJKeOMIH72m25XEBJN1VmhuKvkEcAkDp--

--zLZGM7OOWeRpcu8S0zaQgfOlkoT6YsycL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wmMEABEIACMWIQRSRNvmxYqoNs6vm0SLlqqYsFRKCQUCYFoIugUDAAAAAAAKCRCLlqqYsFRKCT0m
AJ0d1lQ71Mu83wQsiGMjfErXcRK37wCeIlrjUY5d3EihkvOWWstuHYYAJI8=
=nB29
-----END PGP SIGNATURE-----

--zLZGM7OOWeRpcu8S0zaQgfOlkoT6YsycL--

--===============1509580420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1509580420==--
