Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39431C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 16:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D41296196C
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 16:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41296196C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60A8D89DF9;
	Mon, 22 Mar 2021 16:54:59 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E53A89DF9
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 16:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1616432095;
 bh=Lvim8p6Xc/5yCZIBHiqQ9bcvPAbrXYmUmn5xCOxNW1Q=;
 h=X-UI-Sender-Class:Reply-To:Subject:To:References:From:Date:
 In-Reply-To;
 b=RVmao1/WcJ4nyohfHFf/mrIX/2LExfasXHKoqAXmLrGq8aKIjm5JEs1L7cUN4WzIm
 QHaNXBVQYZZw3qW/J8QT5TrHDnIp5Axa/1gBY92ziLPttIev94VxwK3Tmkh6hsU8WA
 SiB1ghbaqvnWv9dEgJUMiKz/Tt20b2KRbbHG3NPk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.1] ([178.27.134.71]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8XPt-1lkV5T13ar-014W03 for
 <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 17:54:54 +0100
Subject: Re: Amdgpu kernel oops and freezing on system suspend and hibernate
To: amd-gfx@lists.freedesktop.org
References: <9f9f69fa-4638-673f-6695-1171e927a80b@gmx.de>
 <MN2PR12MB4488704D527398352637AC61F76A9@MN2PR12MB4488.namprd12.prod.outlook.com>
 <a8ad9295-196c-77cf-ca63-161fb97632cb@gmx.de>
 <DM6PR12MB261918E31190A085F3802A6BE4689@DM6PR12MB2619.namprd12.prod.outlook.com>
 <6333f594-2228-c79c-aaad-1bc588bbf92d@gmx.de>
From: Harvey <harv@gmx.de>
Message-ID: <af90e204-6d66-c3e9-eec7-c34a925cec8c@gmx.de>
Date: Mon, 22 Mar 2021 17:52:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6333f594-2228-c79c-aaad-1bc588bbf92d@gmx.de>
X-Provags-ID: V03:K1:J7wdUzaoFfgmFltmBpHE9k1bNw+Cy14zEriJmw1Aja4HHjZ/+Eq
 B02M/Z42kTbpL66vHxKzuvBsir1Odkilg6nl8xKfsYDK/frMmcwjXX+90P8AiGOiQrNBDG2
 oiTOn0XD10j1yHt/2d2OENe2IyrRLJi1XEpzQSGsd/bvf6aghsQ64JkhZQFZuUZqVqUj/Bv
 E/NYw1OQwQVG0bILSiuPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QXR8Pvz68qk=:Gp4A9foRyNkej8ndWjg7Yc
 YFOufJ/zt+9HhxQFwrlmjxZfVxCHYpbhekYLSN+lTegsev/iiv59/ijYglx0e+bN213ctxEq1
 yOT0aVFRaXOPChd/hZ8mt7nmqQo//aId9svm+4OoEA5eV/jFB4FO7R4iGs/i/FHh2oNwP4iyi
 2+SvMYJJy0/+w53wEjZcMIEKEq918ooh1SX3jlYieY1DU0SXfIBqMTNVdYrdbIHOGjwgUzSsN
 DrVhyVmZn1yEAgCFQmRrVQtfDHYn2pdxuk1mR58hSHJtLkSpsNO1suNjK8gSq3sFtbKMdYLCB
 acMKfD0yKNeYTpCP+gT5Av7yq3I+SKHiXvZT4N7BlCPKrw9YohdfQwLFwoeJ0yCNLgYSk5/lh
 EvdSfebbvH+8HDbXx4fRsgh+075Z4efFpoMK3G4npXGZLWS368XHAqq5SoKT3OFYqIT0xBUvC
 aO59hSchaQSQodrN8CklkpZENhsZT9NFYXdK69yUqrh8JL56Q5QqM7Yy5UJayaThAXscTyCYT
 TvVd6UzFMwpb168sVhWZ003kN6gjJDlFQWb0modMwfCvYxgpVfeM5Ytdzv7KARMUJZrHBfPVR
 hHkuONCLBMPV3OigqEDsQXIH7RpJ0+CrgvZs/Ld35Oe8UwGoKGKRsdKu/4aMtajPWgF0Ja8lk
 6YWZsSXF9JLZgIs3kmR+NpWkJIPorpf4B8QR+biXBJu1/EtR7c5gtgCZPV10yW5XukiSPm9FX
 jRL6flcmPGbKKNS/IgVwsmjoCFfdjhk1DPB3QUc78Ccc98VH7Q009xaTae1gzS5iA8uzIYdnn
 VoMW3yRf/RH716A2kyc4uoMWftubcJHp5g7QMviu+H/etDU+S/cZRvugPRuvPgeH61dxxgSrL
 WuyfJKM+IasmEUzdjI387jzo/mf9KC2szNEpkl4GkbEy0+nkOF/jb99u6TobEjYAiuFePqopq
 n3x3RcCRLd7ncre94RsVv5mckcKcDHbzLokObfYXybRH8uBZ7sIyzIu8M1/tnAPRbnsyn6lEu
 JJrJ3Gjl3fR30uRJHB2T6q4D8W8H4z28CAh7hymp/b9S0WLHrTP66cI4VexsrA+6LCgsMamPv
 jCva46nHUtdVxoTC/YC/dl4ipt2PPSw36hDpPlqppLiZgVhFbG+UmEKfBupKsJdyYwZ4S4Yx4
 Q79lm78TQYSSCd5KRfd4Nr5krHU/C19koWFAr+bxgDEljQRYvTi66o5DweZhFvnupbV64=
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
Content-Type: multipart/mixed; boundary="===============1226550737=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1226550737==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4joGxQ7go4vOSxA75Bv9yQsqr3jfvEhkQ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4joGxQ7go4vOSxA75Bv9yQsqr3jfvEhkQ
Content-Type: multipart/mixed; boundary="yGH1vDJjpGlAUiP5nEErzVFBUQdya91Sf";
 protected-headers="v1"
From: Harvey <harv@gmx.de>
Reply-To: harv@gmx.de
To: amd-gfx@lists.freedesktop.org
Message-ID: <af90e204-6d66-c3e9-eec7-c34a925cec8c@gmx.de>
Subject: Re: Amdgpu kernel oops and freezing on system suspend and hibernate
References: <9f9f69fa-4638-673f-6695-1171e927a80b@gmx.de>
 <MN2PR12MB4488704D527398352637AC61F76A9@MN2PR12MB4488.namprd12.prod.outlook.com>
 <a8ad9295-196c-77cf-ca63-161fb97632cb@gmx.de>
 <DM6PR12MB261918E31190A085F3802A6BE4689@DM6PR12MB2619.namprd12.prod.outlook.com>
 <6333f594-2228-c79c-aaad-1bc588bbf92d@gmx.de>
In-Reply-To: <6333f594-2228-c79c-aaad-1bc588bbf92d@gmx.de>

--yGH1vDJjpGlAUiP5nEErzVFBUQdya91Sf
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Still freezing on 5.11.8 and 5.12-rc4.

Log on 5.12-rc4 looks a little different:


M=C3=A4r 22 17:40:26 obelix systemd[1]: Reached target Sleep.
M=C3=A4r 22 17:40:26 obelix systemd[1]: Starting Hibernate...
M=C3=A4r 22 17:40:26 obelix kernel: PM: hibernation: hibernation entry
M=C3=A4r 22 17:40:26 obelix systemd-sleep[2380]: Suspending system...
M=C3=A4r 22 17:40:46 obelix kernel: Filesystems sync: 0.012 seconds
M=C3=A4r 22 17:40:46 obelix kernel: Freezing user space processes ...
M=C3=A4r 22 17:40:46 obelix kernel: Freezing of tasks failed after 20.003=
=20
seconds (1 tasks refusing to freeze, wq_busy=3D0):
M=C3=A4r 22 17:40:46 obelix kernel: task:Xorg            state:D stack:  =
  0=20
pid: 1635 ppid:  1633 flags:0x00000004
M=C3=A4r 22 17:40:46 obelix kernel: Call Trace:
M=C3=A4r 22 17:40:46 obelix kernel:  __schedule+0x2fc/0x8b0
M=C3=A4r 22 17:40:46 obelix kernel:  schedule+0x5b/0xc0
M=C3=A4r 22 17:40:46 obelix kernel:  rpm_resume+0x18c/0x810
M=C3=A4r 22 17:40:46 obelix kernel:  ? wait_woken+0x80/0x80
M=C3=A4r 22 17:40:46 obelix kernel:  __pm_runtime_resume+0x4a/0x80
M=C3=A4r 22 17:40:46 obelix kernel:  amdgpu_drm_ioctl+0x33/0x80 [amdgpu]
M=C3=A4r 22 17:40:46 obelix kernel:  __x64_sys_ioctl+0x83/0xb0
M=C3=A4r 22 17:40:46 obelix kernel:  do_syscall_64+0x33/0x40
M=C3=A4r 22 17:40:46 obelix kernel:  entry_SYSCALL_64_after_hwframe+0x44/=
0xae
M=C3=A4r 22 17:40:46 obelix kernel: RIP: 0033:0x7f7647d4de6b
M=C3=A4r 22 17:40:46 obelix kernel: RSP: 002b:00007ffec3671e88 EFLAGS:=20
00000246 ORIG_RAX: 0000000000000010
M=C3=A4r 22 17:40:46 obelix kernel: RAX: ffffffffffffffda RBX:=20
00007ffec3671ec0 RCX: 00007f7647d4de6b
M=C3=A4r 22 17:40:46 obelix kernel: RDX: 00007ffec3671ec0 RSI:=20
00000000c06864a2 RDI: 000000000000000d
M=C3=A4r 22 17:40:46 obelix kernel: RBP: 00000000c06864a2 R08:=20
0000000000000000 R09: 0000000000000000
M=C3=A4r 22 17:40:46 obelix kernel: R10: 0000000000000000 R11:=20
0000000000000246 R12: 00005609594eedf0
M=C3=A4r 22 17:40:46 obelix kernel: R13: 000000000000000d R14:=20
0000000000000000 R15: 0000000000000000
M=C3=A4r 22 17:40:46 obelix kernel:
M=C3=A4r 22 17:40:46 obelix kernel: OOM killer enabled.
M=C3=A4r 22 17:40:46 obelix kernel: Restarting tasks ... done.
M=C3=A4r 22 17:40:46 obelix kernel: thermal thermal_zone1: failed to read=
 out=20
thermal zone (-61)
M=C3=A4r 22 17:40:46 obelix rtkit-daemon[1381]: The canary thread is=20
apparently starving. Taking action.
M=C3=A4r 22 17:40:46 obelix rtkit-daemon[1381]: Demoting known real-time =
threads.
M=C3=A4r 22 17:40:46 obelix rtkit-daemon[1381]: Successfully demoted thre=
ad=20
2346 of process 1780.
M=C3=A4r 22 17:40:46 obelix rtkit-daemon[1381]: Successfully demoted thre=
ad=20
1811 of process 1780.
M=C3=A4r 22 17:40:46 obelix rtkit-daemon[1381]: Successfully demoted thre=
ad=20
1810 of process 1780.
M=C3=A4r 22 17:40:46 obelix rtkit-daemon[1381]: Successfully demoted thre=
ad=20
1780 of process 1780.
M=C3=A4r 22 17:40:46 obelix rtkit-daemon[1381]: Demoted 4 threads.
M=C3=A4r 22 17:40:46 obelix systemd-sleep[2380]: Failed to suspend system=
=2E=20
System resumed again: Device or resource busy
M=C3=A4r 22 17:40:46 obelix systemd[1]: systemd-hibernate.service: Main=20
process exited, code=3Dexited, status=3D1/FAILURE
M=C3=A4r 22 17:40:46 obelix systemd[1]: systemd-hibernate.service: Failed=
=20
with result 'exit-code'.
M=C3=A4r 22 17:40:46 obelix systemd[1]: Failed to start Hibernate.
M=C3=A4r 22 17:40:46 obelix kernel: PM: hibernation: hibernation exit
M=C3=A4r 22 17:40:46 obelix systemd[1]: Dependency failed for Hibernate.
M=C3=A4r 22 17:40:46 obelix audit[1]: SERVICE_START pid=3D1 uid=3D0=20
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-hibernate=20
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?=20
terminal=3D? res=3Dfailed'
M=C3=A4r 22 17:40:46 obelix systemd[1]: hibernate.target: Job=20
hibernate.target/start failed with result 'dependency'.
M=C3=A4r 22 17:40:46 obelix systemd-logind[1091]: Operation 'sleep' finis=
hed.
M=C3=A4r 22 17:40:46 obelix systemd[1]: Stopped target Sleep.
M=C3=A4r 22 17:40:46 obelix NetworkManager[1089]: <info>  [1616431246.870=
6]=20
manager: sleep: wake requested (sleeping: yes  enabled: yes)
M=C3=A4r 22 17:40:46 obelix kernel: audit: type=3D1130=20
audit(1616431246.867:108): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D429496=
7295=20
msg=3D'unit=3Dsystemd-hibernate comm=3D"systemd"=20
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3D=
failed'
M=C3=A4r 22 17:40:46 obelix NetworkManager[1089]: <info>  [1616431246.870=
8]=20
device (wlp4s0): state change: unmanaged -> unavailable (reason=20
'managed', sys-iface-state: 'external')
M=C3=A4r 22 17:40:47 obelix NetworkManager[1089]: <info>  [1616431247.128=
8]=20
device (p2p-dev-wlp4s0): state change: unmanaged -> unavailable (reason=20
'managed', sys-iface-state: 'external')
M=C3=A4r 22 17:40:47 obelix NetworkManager[1089]: <info>  [1616431247.129=
6]=20
manager: NetworkManager state is now DISCONNECTED
M=C3=A4r 22 17:40:47 obelix NetworkManager[1089]: <info>  [1616431247.220=
8]=20
device (wlp4s0): supplicant interface state: internal-starting ->=20
disconnected
M=C3=A4r 22 17:40:47 obelix NetworkManager[1089]: <info>  [1616431247.220=
9]=20
device (p2p-dev-wlp4s0): state change: unavailable -> unmanaged (reason=20
'removed', sys-iface-state: 'removed')
M=C3=A4r 22 17:40:47 obelix NetworkManager[1089]: <info>  [1616431247.221=
6]=20
Wi-Fi P2P device controlled by interface wlp4s0 created
M=C3=A4r 22 17:40:47 obelix NetworkManager[1089]: <info>  [1616431247.222=
0]=20
manager: (p2p-dev-wlp4s0): new 802.11 Wi-Fi P2P device=20
(/org/freedesktop/NetworkManager/Devices/5)
M=C3=A4r 22 17:40:47 obelix NetworkManager[1089]: <info>  [1616431247.222=
3]=20
device (p2p-dev-wlp4s0): state change: unmanaged -> unavailable (reason=20
'managed', sys-iface-state: 'external')
M=C3=A4r 22 17:40:47 obelix NetworkManager[1089]: <info>  [1616431247.223=
2]=20
device (wlp4s0): state change: unavailable -> disconnected (reason=20
'supplicant-available', sys-iface-state: 'managed')
M=C3=A4r 22 17:40:47 obelix NetworkManager[1089]: <info>  [1616431247.224=
4]=20
device (p2p-dev-wlp4s0): state change: unavailable -> disconnected=20
(reason 'none', sys-iface-state: 'managed')
M=C3=A4r 22 17:40:47 obelix NetworkManager[1089]: <warn>  [1616431247.241=
4]=20
sup-iface[5e6c29d124d0d735,2,wlp4s0]: call-p2p-cancel: failed with P2P=20
cancel failed
M=C3=A4r 22 17:40:50 obelix wpa_supplicant[1197]: wlp4s0:=20
CTRL-EVENT-REGDOM-CHANGE init=3DDRIVER type=3DCOUNTRY alpha2=3DDE
M=C3=A4r 22 17:41:16 obelix systemd[1]: systemd-hostnamed.service:=20
Deactivated successfully.
M=C3=A4r 22 17:41:16 obelix audit[1]: SERVICE_STOP pid=3D1 uid=3D0=20
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-hostnamed=20
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?=20
terminal=3D? res=3Dsuccess'
M=C3=A4r 22 17:41:16 obelix kernel: audit: type=3D1131=20
audit(1616431276.781:109): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D429496=
7295=20
msg=3D'unit=3Dsystemd-hostnamed comm=3D"systemd"=20
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3D=
success'
M=C3=A4r 22 17:41:16 obelix audit: BPF prog-id=3D33 op=3DUNLOAD
M=C3=A4r 22 17:41:16 obelix audit: BPF prog-id=3D32 op=3DUNLOAD
M=C3=A4r 22 17:41:16 obelix audit: BPF prog-id=3D31 op=3DUNLOAD
M=C3=A4r 22 17:41:16 obelix kernel: audit: type=3D1334=20
audit(1616431276.941:110): prog-id=3D33 op=3DUNLOAD
M=C3=A4r 22 17:41:16 obelix kernel: audit: type=3D1334=20
audit(1616431276.941:111): prog-id=3D32 op=3DUNLOAD
M=C3=A4r 22 17:41:16 obelix kernel: audit: type=3D1334=20
audit(1616431276.941:112): prog-id=3D31 op=3DUNLOAD

Greetings
Harvey


Am 19.03.21 um 13:24 schrieb Harvey:
> Evan,
>=20
> this is a laptop with RENOIR hardware (Ryzen 4800H) and a discrete GPU =

> RX5500. There is an external monitor connected to the HDMI port (which =

> is attached to the iGPU afaict).
>=20
> I would be happy to test further and help in nailing this one ;)
>=20
> Greetings
> Harey
>=20
>=20
> Am 19.03.21 um 03:10 schrieb Quan, Evan:
>> [AMD Public Use]
>>
>> Hi Harvey,
>>
>> Resuming after mode1 reset failed according to the error logs below.
>> Also according to the lspci output of last email, it happened for a=20
>> Navi14 ASIC.
>> However, I cannot reproduce that on my desktop platform with 2 x=20
>> Navi14 ASICs.
>>
>> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:03:00.0: amdgpu: MODE1=
 reset
>> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:03:00.0: amdgpu: GPU p=
sp
>> mode1 reset
>> M=C3=A4r 18 13:00:43 obelix kernel: [drm] psp mode1 reset succeed
>> ....
>> ...
>> M=C3=A4r 18 13:00:43 obelix kernel: [drm:psp_v11_0_ring_create [amdgpu=
]]
>> *ERROR* Failed to wait for sOS ready for ring creation
>> M=C3=A4r 18 13:00:43 obelix kernel: [drm:psp_hw_start [amdgpu]] *ERROR=
* PSP
>> create ring failed!
>> M=C3=A4r 18 13:00:43 obelix kernel: [drm:psp_resume [amdgpu]] *ERROR* =
PSP
>> resume failed
>> M=C3=A4r 18 13:00:43 obelix kernel: [drm:amdgpu_device_fw_loading [amd=
gpu]]
>> *ERROR* resume of IP block <psp> failed -62
>> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:03:00.0: amdgpu:
>> amdgpu_device_ip_resume failed (-62).
>>
>>
>> Considering you seemed not running our latest driver according to the =

>> complaint blow. Maybe it's worth to try our latest driver(@Deucher,=20
>> Alexander where Harvey can get our latest code?).
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: smu d=
river
>> if version =3D 0x00000036, smu fw if version =3D 0x00000038, smu fw ve=
rsion
>> =3D 0x00352100 (53.33.0)
>>
>> BR
>> Evan
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Har=
vey
>> Sent: Thursday, March 18, 2021 8:17 PM
>> To: amd-gfx@lists.freedesktop.org
>> Subject: Re: Amdgpu kernel oops and freezing on system suspend and=20
>> hibernate
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
>>
>> When invoking 'systemctl hibernate' the system does not power off (I
>> waited for 5 minutes) and I have to hard reset it to start up again. I=
t
>> then tries to resume from the swap partition and comes back up with on=
ly
>> the external monitor connected to the HDMI port showing a picture and
>> the builtin screen of the laptop staying black. Nevertheless the syste=
m
>> is freezed and not responding, neither to mouse or keyboard. After
>> another hard reset I managed to get the following log from journalctl
>> (only cut the relevant part):
>>
>> M=C3=A4r 18 12:51:11 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
271.3466]
>> manager: sleep: sleep requested (sleeping: no=C2=A0 enabled: yes)
>> M=C3=A4r 18 12:51:11 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
271.3473]
>> device (wlp4s0): state change: disconnected -> unmanaged (reason
>> 'sleeping', sys-iface-state: 'managed')
>> M=C3=A4r 18 12:51:11 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
271.3508]
>> device (wlp4s0): set-hw-addr: reset MAC address to 14:F6:D8:18:8C:EC
>> (unmanage)
>> M=C3=A4r 18 12:51:11 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
271.3575]
>> device (p2p-dev-wlp4s0): state change: disconnected -> unmanaged (reas=
on
>> 'sleeping', sys-iface-state: 'managed')
>> M=C3=A4r 18 12:51:11 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
271.3580]
>> manager: NetworkManager state is now ASLEEP
>> M=C3=A4r 18 12:51:11 obelix wpa_supplicant[954]: nl80211: deinit
>> ifname=3Dp2p-dev-wlp4s0 disabled_11b_rates=3D0
>> M=C3=A4r 18 12:51:11 obelix wpa_supplicant[954]: nl80211: deinit
>> ifname=3Dwlp4s0 disabled_11b_rates=3D0
>> M=C3=A4r 18 12:51:12 obelix gsd-media-keys[1691]: Unable to get defaul=
t sink
>> M=C3=A4r 18 12:51:15 obelix gnome-shell[1496]:
>> ../glib/gobject/gsignal.c:2732: instance '0x560b86c67b50' has no handl=
er
>> with id '15070'
>> M=C3=A4r 18 12:51:16 obelix gsd-usb-protect[1724]: Error calling USBGu=
ard
>> DBus to change the protection after a screensaver event:
>> GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name
>> org.usbguard1 was not provided by any .service files
>> M=C3=A4r 18 12:51:16 obelix systemd[1]: Reached target Sleep.
>> M=C3=A4r 18 12:51:16 obelix systemd[1]: Starting Suspend...
>> M=C3=A4r 18 12:51:16 obelix systemd-sleep[2000]: Suspending system...
>> M=C3=A4r 18 12:51:16 obelix kernel: PM: suspend entry (deep)
>> M=C3=A4r 18 12:51:16 obelix kernel: Filesystems sync: 0.005 seconds
>> M=C3=A4r 18 12:51:36 obelix kernel: Freezing user space processes ...
>> (elapsed 0.002 seconds) done.
>> M=C3=A4r 18 12:51:36 obelix kernel: OOM killer disabled.
>> M=C3=A4r 18 12:51:36 obelix kernel: Freezing remaining freezable tasks=
 ...
>> (elapsed 0.001 seconds) done.
>> M=C3=A4r 18 12:51:36 obelix kernel: printk: Suspending console(s) (use=

>> no_console_suspend to debug)
>> M=C3=A4r 18 12:51:36 obelix kernel: [drm] free PSP TMR buffer
>> M=C3=A4r 18 12:51:36 obelix kernel: [drm] free PSP TMR buffer
>> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: EC: interrupt blocked
>> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: Preparing to enter system sl=
eep
>> state S3
>> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: EC: event blocked
>> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: EC: EC stopped
>> M=C3=A4r 18 12:51:36 obelix kernel: PM: Saving platform NVS memory
>> M=C3=A4r 18 12:51:36 obelix kernel: Disabling non-boot CPUs ...
>> M=C3=A4r 18 12:51:36 obelix kernel: IRQ 86: no longer affine to CPU1
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 1 is now offline
>> M=C3=A4r 18 12:51:36 obelix kernel: IRQ 87: no longer affine to CPU2
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 2 is now offline
>> M=C3=A4r 18 12:51:36 obelix kernel: IRQ 88: no longer affine to CPU3
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 3 is now offline
>> M=C3=A4r 18 12:51:36 obelix kernel: IRQ 89: no longer affine to CPU4
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 4 is now offline
>> M=C3=A4r 18 12:51:36 obelix kernel: IRQ 90: no longer affine to CPU5
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 5 is now offline
>> M=C3=A4r 18 12:51:36 obelix kernel: IRQ 91: no longer affine to CPU6
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 6 is now offline
>> M=C3=A4r 18 12:51:36 obelix kernel: IRQ 92: no longer affine to CPU7
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 7 is now offline
>> M=C3=A4r 18 12:51:36 obelix kernel: IRQ 93: no longer affine to CPU8
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 8 is now offline
>> M=C3=A4r 18 12:51:36 obelix kernel: IRQ 94: no longer affine to CPU9
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 9 is now offline
>> M=C3=A4r 18 12:51:36 obelix kernel: IRQ 95: no longer affine to CPU10
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 10 is now offline
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 11 is now offline
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 12 is now offline
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 13 is now offline
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 14 is now offline
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 15 is now offline
>> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: Low-level resume complete
>> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: EC: EC started
>> M=C3=A4r 18 12:51:36 obelix kernel: PM: Restoring platform NVS memory
>> M=C3=A4r 18 12:51:36 obelix kernel: LVT offset 0 assigned for vector 0=
x400
>> M=C3=A4r 18 12:51:36 obelix kernel: Enabling non-boot CPUs ...
>> M=C3=A4r 18 12:51:36 obelix kernel: x86: Booting SMP configuration:
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor =
1=20
>> APIC 0x1
>> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU1: patch_level=3D0x0=
8600104
>> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P001: Found 3 idl=
e states
>> M=C3=A4r 18 12:51:36 obelix kernel: CPU1 is up
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor =
2=20
>> APIC 0x2
>> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU2: patch_level=3D0x0=
8600104
>> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P002: Found 3 idl=
e states
>> M=C3=A4r 18 12:51:36 obelix kernel: CPU2 is up
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor =
3=20
>> APIC 0x3
>> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU3: patch_level=3D0x0=
8600104
>> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P003: Found 3 idl=
e states
>> M=C3=A4r 18 12:51:36 obelix kernel: CPU3 is up
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor =
4=20
>> APIC 0x4
>> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU4: patch_level=3D0x0=
8600104
>> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P004: Found 3 idl=
e states
>> M=C3=A4r 18 12:51:36 obelix kernel: CPU4 is up
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor =
5=20
>> APIC 0x5
>> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU5: patch_level=3D0x0=
8600104
>> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P005: Found 3 idl=
e states
>> M=C3=A4r 18 12:51:36 obelix kernel: CPU5 is up
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor =
6=20
>> APIC 0x6
>> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU6: patch_level=3D0x0=
8600104
>> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P006: Found 3 idl=
e states
>> M=C3=A4r 18 12:51:36 obelix kernel: CPU6 is up
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor =
7=20
>> APIC 0x7
>> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU7: patch_level=3D0x0=
8600104
>> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P007: Found 3 idl=
e states
>> M=C3=A4r 18 12:51:36 obelix kernel: CPU7 is up
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor =
8=20
>> APIC 0x8
>> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU8: patch_level=3D0x0=
8600104
>> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P008: Found 3 idl=
e states
>> M=C3=A4r 18 12:51:36 obelix kernel: CPU8 is up
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor =
9=20
>> APIC 0x9
>> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU9: patch_level=3D0x0=
8600104
>> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P009: Found 3 idl=
e states
>> M=C3=A4r 18 12:51:36 obelix kernel: CPU9 is up
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor =
10=20
>> APIC 0xa
>> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU10: patch_level=3D0x=
08600104
>> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P00A: Found 3 idl=
e states
>> M=C3=A4r 18 12:51:36 obelix kernel: CPU10 is up
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor =
11=20
>> APIC 0xb
>> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU11: patch_level=3D0x=
08600104
>> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P00B: Found 3 idl=
e states
>> M=C3=A4r 18 12:51:36 obelix kernel: CPU11 is up
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor =
12=20
>> APIC 0xc
>> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU12: patch_level=3D0x=
08600104
>> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P00C: Found 3 idl=
e states
>> M=C3=A4r 18 12:51:36 obelix kernel: CPU12 is up
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor =
13=20
>> APIC 0xd
>> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU13: patch_level=3D0x=
08600104
>> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P00D: Found 3 idl=
e states
>> M=C3=A4r 18 12:51:36 obelix kernel: CPU13 is up
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor =
14=20
>> APIC 0xe
>> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU14: patch_level=3D0x=
08600104
>> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P00E: Found 3 idl=
e states
>> M=C3=A4r 18 12:51:36 obelix kernel: CPU14 is up
>> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor =
15=20
>> APIC 0xf
>> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU15: patch_level=3D0x=
08600104
>> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P00F: Found 3 idl=
e states
>> M=C3=A4r 18 12:51:36 obelix kernel: CPU15 is up
>> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: Waking up from system sleep =
state S3
>> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: EC: interrupt unblocked
>> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: EC: event unblocked
>> M=C3=A4r 18 12:51:36 obelix kernel: [drm] PCIE GART of 1024M enabled (=
table
>> at 0x000000F400900000).
>> M=C3=A4r 18 12:51:36 obelix kernel: [drm] PSP is resuming...
>> M=C3=A4r 18 12:51:36 obelix kernel: [drm] reserve 0x400000 from 0xf41f=
800000
>> for PSP TMR
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: RAS:
>> optional ras ta ucode is not available
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: RAP:
>> optional rap ta ucode is not available
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: SMU i=
s
>> resuming...
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: dpm h=
as been
>> disabled
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: SMU i=
s
>> resumed successfully!
>> M=C3=A4r 18 12:51:36 obelix kernel: [drm] kiq ring mec 2 pipe 1 q 0
>> M=C3=A4r 18 12:51:36 obelix kernel: nvme nvme0: Shutdown timeout set t=
o 8=20
>> seconds
>> M=C3=A4r 18 12:51:36 obelix kernel: [drm] DMUB hardware initialized:
>> version=3D0x01000000
>> M=C3=A4r 18 12:51:36 obelix kernel: usb 3-3: reset full-speed USB devi=
ce
>> number 3 using xhci_hcd
>> M=C3=A4r 18 12:51:36 obelix kernel: nvme nvme0: 16/0/0 default/read/po=
ll=20
>> queues
>> M=C3=A4r 18 12:51:36 obelix kernel: usb 1-4: reset high-speed USB devi=
ce
>> number 3 using xhci_hcd
>> M=C3=A4r 18 12:51:36 obelix kernel: ata2: SATA link down (SStatus 0=20
>> SControl 300)
>> M=C3=A4r 18 12:51:36 obelix kernel: [drm] VCN decode and encode initia=
lized
>> successfully(under DPG Mode).
>> M=C3=A4r 18 12:51:36 obelix kernel: ata1: SATA link down (SStatus 0=20
>> SControl 300)
>> M=C3=A4r 18 12:51:36 obelix kernel: [drm] JPEG decode initialized=20
>> successfully.
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring =
gfx
>> uses VM inv eng 0 on hub 0
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
>> comp_1.0.0 uses VM inv eng 1 on hub 0
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
>> comp_1.1.0 uses VM inv eng 4 on hub 0
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
>> comp_1.2.0 uses VM inv eng 5 on hub 0
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
>> comp_1.3.0 uses VM inv eng 6 on hub 0
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
>> comp_1.0.1 uses VM inv eng 7 on hub 0
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
>> comp_1.1.1 uses VM inv eng 8 on hub 0
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
>> comp_1.2.1 uses VM inv eng 9 on hub 0
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
>> comp_1.3.1 uses VM inv eng 10 on hub 0
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
>> kiq_2.1.0 uses VM inv eng 11 on hub 0
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring =
sdma0
>> uses VM inv eng 0 on hub 1
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring =
vcn_dec
>> uses VM inv eng 1 on hub 1
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
>> vcn_enc0 uses VM inv eng 4 on hub 1
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
>> vcn_enc1 uses VM inv eng 5 on hub 1
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
>> jpeg_dec uses VM inv eng 6 on hub 1
>> M=C3=A4r 18 12:51:36 obelix kernel: [drm] PCIE GART of 512M enabled (t=
able at
>> 0x0000008000000000).
>> M=C3=A4r 18 12:51:36 obelix kernel: [drm] PSP is resuming...
>> M=C3=A4r 18 12:51:36 obelix kernel: [drm] reserve 0x900000 from 0x800f=
400000
>> for PSP TMR
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: RAS:
>> optional ras ta ucode is not available
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: RAP:
>> optional rap ta ucode is not available
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: SMU i=
s
>> resuming...
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: smu d=
river
>> if version =3D 0x00000036, smu fw if version =3D 0x00000038, smu fw ve=
rsion
>> =3D 0x00352100 (53.33.0)
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: SMU d=
river
>> if version not matched
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: SMU i=
s
>> resumed successfully!
>> M=C3=A4r 18 12:51:36 obelix kernel: [drm] kiq ring mec 2 pipe 1 q 0
>> M=C3=A4r 18 12:51:36 obelix kernel: [drm] VCN decode and encode initia=
lized
>> successfully(under DPG Mode).
>> M=C3=A4r 18 12:51:36 obelix kernel: [drm] JPEG decode initialized=20
>> successfully.
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring
>> gfx_0.0.0 uses VM inv eng 0 on hub 0
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring
>> comp_1.0.0 uses VM inv eng 1 on hub 0
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring
>> comp_1.1.0 uses VM inv eng 4 on hub 0
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring
>> comp_1.2.0 uses VM inv eng 5 on hub 0
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring
>> comp_1.3.0 uses VM inv eng 6 on hub 0
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring
>> comp_1.0.1 uses VM inv eng 7 on hub 0
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring
>> comp_1.1.1 uses VM inv eng 8 on hub 0
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring
>> comp_1.2.1 uses VM inv eng 9 on hub 0
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring
>> comp_1.3.1 uses VM inv eng 10 on hub 0
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring
>> kiq_2.1.0 uses VM inv eng 11 on hub 0
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring =
sdma0
>> uses VM inv eng 12 on hub 0
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring =
sdma1
>> uses VM inv eng 13 on hub 0
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring =
vcn_dec
>> uses VM inv eng 0 on hub 1
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring
>> vcn_enc0 uses VM inv eng 1 on hub 1
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring
>> vcn_enc1 uses VM inv eng 4 on hub 1
>> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring
>> jpeg_dec uses VM inv eng 5 on hub 1
>> M=C3=A4r 18 12:51:36 obelix kernel: acpi LNXPOWER:06: Turning OFF
>> M=C3=A4r 18 12:51:36 obelix kernel: acpi LNXPOWER:04: Turning OFF
>> M=C3=A4r 18 12:51:36 obelix kernel: OOM killer enabled.
>> M=C3=A4r 18 12:51:36 obelix kernel: Restarting tasks ... done.
>> M=C3=A4r 18 12:51:36 obelix kernel: audit: type=3D1130
>> audit(1616068296.433:95): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
>> msg=3D'unit=3Dsystemd-rfkill comm=3D"systemd" exe=3D"/usr/lib/systemd/=
systemd"
>> hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
>> M=C3=A4r 18 12:51:36 obelix audit[1]: SERVICE_START pid=3D1 uid=3D0
>> auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-rfkill comm=3D=
"systemd"
>> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? re=
s=3Dsuccess'
>> M=C3=A4r 18 12:51:36 obelix bluetoothd[863]: Endpoint unregistered:
>> sender=3D:1.55 path=3D/MediaEndpoint/A2DPSink/sbc
>> M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) event7=C2=
=A0 -
>> Microsoft Microsoft=C2=AE 2.4GHz Transceiver v9.0 Mouse: SYN_DROPPED e=
vent -
>> some input events have been lost.
>> M=C3=A4r 18 12:51:36 obelix systemd[1]: Starting Load/Save RF Kill Swi=
tch
>> Status...
>> M=C3=A4r 18 12:51:36 obelix bluetoothd[863]: Endpoint unregistered:
>> sender=3D:1.55 path=3D/MediaEndpoint/A2DPSource/sbc
>> M=C3=A4r 18 12:51:36 obelix systemd[1]: Started Load/Save RF Kill Swit=
ch=20
>> Status.
>> M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(=
0):
>> EDID vendor "AUO", prod id 18333
>> M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(=
0):
>> Using hsync ranges from config file
>> M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(=
0):
>> Using vrefresh ranges from config file
>> M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(=
0):
>> Printing DDC gathered Modelines:
>> M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(=
0):
>> Modeline "1920x1080"x0.0=C2=A0 306.73=C2=A0 1920 1968 2000 2102=C2=A0 =
1080 1090 1095
>> 1216 -hsync -vsync (145.9 kHz eP)
>> M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(=
0):
>> Modeline "1920x1080"x0.0=C2=A0 122.70=C2=A0 1920 1968 2000 2102=C2=A0 =
1080 1090 1095
>> 1216 -hsync -vsync (58.4 kHz e)
>> M=C3=A4r 18 12:51:36 obelix upowerd[1150]: treating change event as ad=
d on
>> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-3
>> M=C3=A4r 18 12:51:36 obelix systemd[1]: Stopped target Bluetooth.
>> M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (--) AMDGPU(=
G0):
>> HDMI max TMDS frequency 300000KHz
>> M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(=
0):
>> EDID vendor "AUO", prod id 18333
>> M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(=
0):
>> Using hsync ranges from config file
>> M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(=
0):
>> Using vrefresh ranges from config file
>> M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(=
0):
>> Printing DDC gathered Modelines:
>> M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(=
0):
>> Modeline "1920x1080"x0.0=C2=A0 306.73=C2=A0 1920 1968 2000 2102=C2=A0 =
1080 1090 1095
>> 1216 -hsync -vsync (145.9 kHz eP)
>> M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(=
0):
>> Modeline "1920x1080"x0.0=C2=A0 122.70=C2=A0 1920 1968 2000 2102=C2=A0 =
1080 1090 1095
>> 1216 -hsync -vsync (58.4 kHz e)
>> M=C3=A4r 18 12:51:36 obelix upowerd[1150]: treating change event as ad=
d on
>> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-3
>> M=C3=A4r 18 12:51:36 obelix blueman.desktop[1725]: blueman-applet 12.5=
1.36
>> WARNING=C2=A0 DiscvManager:109 update_menuitems: warning: Adapter is N=
one
>> M=C3=A4r 18 12:51:36 obelix systemd-sleep[2000]: System resumed.
>> M=C3=A4r 18 12:51:36 obelix systemd[1]: systemd-suspend.service: Succe=
eded.
>> M=C3=A4r 18 12:51:36 obelix kernel: PM: suspend exit
>> M=C3=A4r 18 12:51:36 obelix systemd[1]: Finished Suspend.
>> M=C3=A4r 18 12:51:36 obelix audit[1]: SERVICE_START pid=3D1 uid=3D0
>> auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-suspend comm=3D=
"systemd"
>> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? re=
s=3Dsuccess'
>> M=C3=A4r 18 12:51:36 obelix audit[1]: SERVICE_STOP pid=3D1 uid=3D0
>> auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-suspend comm=3D=
"systemd"
>> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? re=
s=3Dsuccess'
>> M=C3=A4r 18 12:51:36 obelix systemd[1]: Stopped target Sleep.
>> M=C3=A4r 18 12:51:36 obelix systemd[1]: Reached target Suspend.
>> M=C3=A4r 18 12:51:36 obelix systemd[1]: Stopped target Suspend.
>> M=C3=A4r 18 12:51:36 obelix systemd-logind[868]: Operation 'sleep' fin=
ished.
>> M=C3=A4r 18 12:51:36 obelix kernel: audit: type=3D1130
>> audit(1616068296.540:96): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
>> msg=3D'unit=3Dsystemd-suspend comm=3D"systemd" exe=3D"/usr/lib/systemd=
/systemd"
>> hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
>> M=C3=A4r 18 12:51:36 obelix kernel: audit: type=3D1131
>> audit(1616068296.540:97): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
>> msg=3D'unit=3Dsystemd-suspend comm=3D"systemd" exe=3D"/usr/lib/systemd=
/systemd"
>> hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
>> M=C3=A4r 18 12:51:36 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
296.5437]
>> manager: sleep: wake requested (sleeping: yes=C2=A0 enabled: yes)
>> M=C3=A4r 18 12:51:36 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
296.5439]
>> device (enp5s0): state change: activated -> unmanaged (reason
>> 'sleeping', sys-iface-state: 'managed')
>> M=C3=A4r 18 12:51:36 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
296.5874]
>> dhcp4 (enp5s0): canceled DHCP transaction
>> M=C3=A4r 18 12:51:36 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
296.5875]
>> dhcp4 (enp5s0): state changed bound -> done
>> M=C3=A4r 18 12:51:36 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
296.6011]
>> manager: NetworkManager state is now CONNECTED_GLOBAL
>> M=C3=A4r 18 12:51:36 obelix kernel: Bluetooth: hci0: Bootloader revisi=
on 0.3
>> build 0 week 24 2017
>> M=C3=A4r 18 12:51:36 obelix systemd[1]: Reached target Bluetooth.
>> M=C3=A4r 18 12:51:36 obelix systemd[1335]: Reached target Bluetooth.
>> M=C3=A4r 18 12:51:36 obelix kernel: Bluetooth: hci0: Device revision i=
s 1
>> M=C3=A4r 18 12:51:36 obelix kernel: Bluetooth: hci0: Secure boot is en=
abled
>> M=C3=A4r 18 12:51:36 obelix kernel: Bluetooth: hci0: OTP lock is enabl=
ed
>> M=C3=A4r 18 12:51:36 obelix kernel: Bluetooth: hci0: API lock is enabl=
ed
>> M=C3=A4r 18 12:51:36 obelix kernel: Bluetooth: hci0: Debug lock is dis=
abled
>> M=C3=A4r 18 12:51:36 obelix kernel: Bluetooth: hci0: Minimum firmware =
build 1
>> week 10 2014
>> M=C3=A4r 18 12:51:36 obelix kernel: Bluetooth: hci0: Found device firm=
ware:
>> intel/ibt-20-1-3.sfi
>> M=C3=A4r 18 12:51:36 obelix rtkit-daemon[1157]: Supervising 3 threads =
of 1
>> processes of 1 users.
>> M=C3=A4r 18 12:51:36 obelix rtkit-daemon[1157]: Successfully made thre=
ad 2118
>> of process 1497 owned by '1000' RT at priority 5.
>> M=C3=A4r 18 12:51:36 obelix rtkit-daemon[1157]: Supervising 4 threads =
of 1
>> processes of 1 users.
>> M=C3=A4r 18 12:51:36 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
296.7372]
>> manager: NetworkManager state is now DISCONNECTED
>> M=C3=A4r 18 12:51:36 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
296.7385]
>> device (enp5s0): state change: unmanaged -> unavailable (reason
>> 'managed', sys-iface-state: 'external')
>> M=C3=A4r 18 12:51:36 obelix dbus-daemon[865]: [system] Activating via
>> systemd: service name=3D'org.freedesktop.nm_dispatcher'
>> unit=3D'dbus-org.freedesktop.nm-dispatcher.service' requested by ':1.2=
'
>> (uid=3D0 pid=3D866 comm=3D"/usr/bin/NetworkManager --no-daemon ")
>> M=C3=A4r 18 12:51:36 obelix systemd[1]: Starting Network Manager Scrip=
t
>> Dispatcher Service...
>> M=C3=A4r 18 12:51:36 obelix dbus-daemon[865]: [system] Successfully ac=
tivated
>> service 'org.freedesktop.nm_dispatcher'
>> M=C3=A4r 18 12:51:36 obelix systemd[1]: Started Network Manager Script=

>> Dispatcher Service.
>> M=C3=A4r 18 12:51:36 obelix audit[1]: SERVICE_START pid=3D1 uid=3D0
>> auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3DNetworkManager-dispat=
cher
>> comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D=
?
>> terminal=3D? res=3Dsuccess'
>> M=C3=A4r 18 12:51:36 obelix kernel: enp5s0: 0xffffb20a00665000,
>> 00:d8:61:e6:48:1c, IRQ 61
>> M=C3=A4r 18 12:51:36 obelix kernel: audit: type=3D1130
>> audit(1616068296.746:98): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
>> msg=3D'unit=3DNetworkManager-dispatcher comm=3D"systemd"
>> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? re=
s=3Dsuccess'
>> M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
297.0012]
>> device (wlp4s0): state change: unmanaged -> unavailable (reason
>> 'managed', sys-iface-state: 'external')
>> M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
297.0022]
>> device (p2p-dev-wlp4s0): state change: unmanaged -> unavailable (reaso=
n
>> 'managed', sys-iface-state: 'external')
>> M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
297.0867]
>> device (wlp4s0): supplicant interface state: internal-starting ->
>> disconnected
>> M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
297.0867]
>> device (p2p-dev-wlp4s0): state change: unavailable -> unmanaged (reaso=
n
>> 'removed', sys-iface-state: 'removed')
>> M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
297.0875]
>> Wi-Fi P2P device controlled by interface wlp4s0 created
>> M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
297.0881]
>> manager: (p2p-dev-wlp4s0): new 802.11 Wi-Fi P2P device
>> (/org/freedesktop/NetworkManager/Devices/5)
>> M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
297.0886]
>> device (p2p-dev-wlp4s0): state change: unmanaged -> unavailable (reaso=
n
>> 'managed', sys-iface-state: 'external')
>> M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
297.0896]
>> device (wlp4s0): state change: unavailable -> disconnected (reason
>> 'supplicant-available', sys-iface-state: 'managed')
>> M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
297.0908]
>> device (p2p-dev-wlp4s0): state change: unavailable -> disconnected
>> (reason 'none', sys-iface-state: 'managed')
>> M=C3=A4r 18 12:51:37 obelix gnome-shell[1496]: Removing a network devi=
ce that
>> was not added
>> M=C3=A4r 18 12:51:37 obelix gnome-shell[1496]: Removing a network devi=
ce that
>> was not added
>> M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <warn>=C2=A0 [1616068=
297.1007]
>> sup-iface[2b6336e7b4770113,1,wlp4s0]: call-p2p-cancel: failed with P2P=

>> cancel failed
>> M=C3=A4r 18 12:51:38 obelix kernel: Bluetooth: hci0: Waiting for firmw=
are
>> download to complete
>> M=C3=A4r 18 12:51:38 obelix kernel: Bluetooth: hci0: Firmware loaded i=
n
>> 1486688 usecs
>> M=C3=A4r 18 12:51:38 obelix kernel: Bluetooth: hci0: Waiting for devic=
e to=20
>> boot
>> M=C3=A4r 18 12:51:38 obelix kernel: Bluetooth: hci0: Device booted in =
15971=20
>> usecs
>> M=C3=A4r 18 12:51:38 obelix kernel: Bluetooth: hci0: Found Intel DDC
>> parameters: intel/ibt-20-1-3.ddc
>> M=C3=A4r 18 12:51:38 obelix kernel: Bluetooth: hci0: Applying Intel DD=
C
>> parameters completed
>> M=C3=A4r 18 12:51:38 obelix kernel: Bluetooth: hci0: Firmware revision=
 0.0
>> build 121 week 7 2021
>> M=C3=A4r 18 12:51:38 obelix bluetoothd[863]: Endpoint registered:
>> sender=3D:1.55 path=3D/MediaEndpoint/A2DPSink/sbc
>> M=C3=A4r 18 12:51:38 obelix bluetoothd[863]: Endpoint registered:
>> sender=3D:1.55 path=3D/MediaEndpoint/A2DPSource/sbc
>> M=C3=A4r 18 12:51:40 obelix kernel: r8168: enp5s0: link up
>> M=C3=A4r 18 12:51:40 obelix kernel: IPv6: ADDRCONF(NETDEV_CHANGE): enp=
5s0:
>> link becomes ready
>> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
300.0571]
>> device (enp5s0): carrier: link connected
>> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
300.0582]
>> device (enp5s0): state change: unavailable -> disconnected (reason
>> 'carrier-changed', sys-iface-state: 'managed')
>> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
300.0609]
>> policy: auto-activating connection 'Kabelgebundene Verbindung 1'
>> (c38c81cb-d88f-4897-9ece-659d13774b9a)
>> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
300.0620]
>> device (enp5s0): Activation: starting connection 'Kabelgebundene
>> Verbindung 1' (c38c81cb-d88f-4897-9ece-659d13774b9a)
>> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
300.0622]
>> device (enp5s0): state change: disconnected -> prepare (reason 'none',=

>> sys-iface-state: 'managed')
>> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
300.0628]
>> manager: NetworkManager state is now CONNECTING
>> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
300.0632]
>> device (enp5s0): state change: prepare -> config (reason 'none',
>> sys-iface-state: 'managed')
>> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
300.0645]
>> device (enp5s0): state change: config -> ip-config (reason 'none',
>> sys-iface-state: 'managed')
>> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
300.0650]
>> dhcp4 (enp5s0): activation: beginning transaction (timeout in 45 secon=
ds)
>> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
300.0953]
>> dhcp4 (enp5s0): state changed unknown -> bound, address=3D192.168.1.1
>> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
300.0973]
>> device (enp5s0): state change: ip-config -> ip-check (reason 'none',
>> sys-iface-state: 'managed')
>> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
300.0997]
>> device (enp5s0): state change: ip-check -> secondaries (reason 'none',=

>> sys-iface-state: 'managed')
>> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
300.1000]
>> device (enp5s0): state change: secondaries -> activated (reason 'none'=
,
>> sys-iface-state: 'managed')
>> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
300.1007]
>> manager: NetworkManager state is now CONNECTED_LOCAL
>> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
300.1023]
>> manager: NetworkManager state is now CONNECTED_SITE
>> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
300.1025]
>> policy: set 'Kabelgebundene Verbindung 1' (enp5s0) as default for IPv4=

>> routing and DNS
>> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
300.1099]
>> device (enp5s0): Activation: successful, device activated.
>> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
300.2198]
>> manager: NetworkManager state is now CONNECTED_GLOBAL
>> M=C3=A4r 18 12:51:40 obelix wpa_supplicant[954]: wlp4s0:
>> CTRL-EVENT-REGDOM-CHANGE init=3DDRIVER type=3DCOUNTRY alpha2=3DDE
>> M=C3=A4r 18 12:51:41 obelix systemd[1]: systemd-rfkill.service: Succee=
ded.
>> M=C3=A4r 18 12:51:41 obelix audit[1]: SERVICE_STOP pid=3D1 uid=3D0
>> auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-rfkill comm=3D=
"systemd"
>> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? re=
s=3Dsuccess'
>> M=C3=A4r 18 12:51:41 obelix kernel: audit: type=3D1131
>> audit(1616068301.630:99): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
>> msg=3D'unit=3Dsystemd-rfkill comm=3D"systemd" exe=3D"/usr/lib/systemd/=
systemd"
>> hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
>> M=C3=A4r 18 12:51:44 obelix gdm-password][2147]: gkr-pam: unlocked log=
in=20
>> keyring
>> M=C3=A4r 18 12:51:44 obelix kernel: audit: type=3D1100
>> audit(1616068304.670:100): pid=3D2147 uid=3D0 auid=3D1000 ses=3D3
>> msg=3D'op=3DPAM:authentication
>> grantors=3Dpam_shells,pam_faillock,pam_permit,pam_faillock,pam_gnome_k=
eyring=20
>>
>> acct=3D"harvey" exe=3D"/usr/lib/gdm-session-worker" hostname=3Dobelix =
addr=3D?
>> terminal=3D/dev/tty1 res=3Dsuccess'
>> M=C3=A4r 18 12:51:44 obelix audit[2147]: USER_AUTH pid=3D2147 uid=3D0 =
auid=3D1000
>> ses=3D3 msg=3D'op=3DPAM:authentication
>> grantors=3Dpam_shells,pam_faillock,pam_permit,pam_faillock,pam_gnome_k=
eyring=20
>>
>> acct=3D"harvey" exe=3D"/usr/lib/gdm-session-worker" hostname=3Dobelix =
addr=3D?
>> terminal=3D/dev/tty1 res=3Dsuccess'
>> M=C3=A4r 18 12:51:44 obelix dbus-daemon[865]: [system] Activating via
>> systemd: service name=3D'org.freedesktop.home1'
>> unit=3D'dbus-org.freedesktop.home1.service' requested by ':1.87' (uid=3D=
0
>> pid=3D2147 comm=3D"gdm-session-worker [pam/gdm-password] ")
>> M=C3=A4r 18 12:51:44 obelix dbus-daemon[865]: [system] Activation via =
systemd
>> failed for unit 'dbus-org.freedesktop.home1.service': Unit
>> dbus-org.freedesktop.home1.service not found.
>> M=C3=A4r 18 12:51:44 obelix gdm-password][2147]:
>> pam_systemd_home(gdm-password:account): systemd-homed is not available=
:
>> Unit dbus-org.freedesktop.home1.service not found.
>> M=C3=A4r 18 12:51:44 obelix audit[2147]: USER_ACCT pid=3D2147 uid=3D0 =
auid=3D1000
>> ses=3D3 msg=3D'op=3DPAM:accounting
>> grantors=3Dpam_access,pam_unix,pam_permit,pam_time acct=3D"harvey"
>> exe=3D"/usr/lib/gdm-session-worker" hostname=3Dobelix addr=3D?
>> terminal=3D/dev/tty1 res=3Dsuccess'
>> M=C3=A4r 18 12:51:44 obelix kernel: audit: type=3D1101
>> audit(1616068304.673:101): pid=3D2147 uid=3D0 auid=3D1000 ses=3D3
>> msg=3D'op=3DPAM:accounting grantors=3Dpam_access,pam_unix,pam_permit,p=
am_time
>> acct=3D"harvey" exe=3D"/usr/lib/gdm-session-worker" hostname=3Dobelix =
addr=3D?
>> terminal=3D/dev/tty1 res=3Dsuccess'
>> M=C3=A4r 18 12:51:44 obelix audit[2147]: CRED_REFR pid=3D2147 uid=3D0 =
auid=3D1000
>> ses=3D3 msg=3D'op=3DPAM:setcred
>> grantors=3Dpam_shells,pam_faillock,pam_permit,pam_faillock,pam_gnome_k=
eyring=20
>>
>> acct=3D"harvey" exe=3D"/usr/lib/gdm-session-worker" hostname=3Dobelix =
addr=3D?
>> terminal=3D/dev/tty1 res=3Dsuccess'
>> M=C3=A4r 18 12:51:44 obelix kernel: audit: type=3D1110
>> audit(1616068304.676:102): pid=3D2147 uid=3D0 auid=3D1000 ses=3D3
>> msg=3D'op=3DPAM:setcred
>> grantors=3Dpam_shells,pam_faillock,pam_permit,pam_faillock,pam_gnome_k=
eyring=20
>>
>> acct=3D"harvey" exe=3D"/usr/lib/gdm-session-worker" hostname=3Dobelix =
addr=3D?
>> terminal=3D/dev/tty1 res=3Dsuccess'
>> M=C3=A4r 18 12:51:44 obelix gnome-shell[1496]: loading default theme (=
Adwaita)
>> M=C3=A4r 18 12:51:45 obelix dbus-daemon[865]: [system] Activating via
>> systemd: service name=3D'org.freedesktop.hostname1'
>> unit=3D'dbus-org.freedesktop.hostname1.service' requested by ':1.51'
>> (uid=3D1000 pid=3D1496 comm=3D"/usr/bin/gnome-shell ")
>> M=C3=A4r 18 12:51:45 obelix audit: BPF prog-id=3D25 op=3DLOAD
>> M=C3=A4r 18 12:51:45 obelix audit: BPF prog-id=3D26 op=3DLOAD
>> M=C3=A4r 18 12:51:45 obelix systemd[1]: Starting Hostname Service...
>> M=C3=A4r 18 12:51:45 obelix kernel: audit: type=3D1334
>> audit(1616068305.143:103): prog-id=3D25 op=3DLOAD
>> M=C3=A4r 18 12:51:45 obelix kernel: audit: type=3D1334
>> audit(1616068305.143:104): prog-id=3D26 op=3DLOAD
>> M=C3=A4r 18 12:51:45 obelix dbus-daemon[865]: [system] Successfully ac=
tivated
>> service 'org.freedesktop.hostname1'
>> M=C3=A4r 18 12:51:45 obelix systemd[1]: Started Hostname Service.
>> M=C3=A4r 18 12:51:45 obelix audit[1]: SERVICE_START pid=3D1 uid=3D0
>> auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-hostnamed
>> comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D=
?
>> terminal=3D? res=3Dsuccess'
>> M=C3=A4r 18 12:51:45 obelix kernel: audit: type=3D1130
>> audit(1616068305.213:105): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D429=
4967295
>> msg=3D'unit=3Dsystemd-hostnamed comm=3D"systemd"
>> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? re=
s=3Dsuccess'
>> M=C3=A4r 18 12:51:45 obelix gnome-shell[1496]: Usage of object.actor i=
s
>> deprecated for ClipboardIndicator
>> get@resource:///org/gnome/shell/ui/environment.js:317:29
>> _init@/home/harvey/.local/share/gnome-shell/extensions/clipboard-indic=
ator@tudmotu.com/extension.js:93:9=20
>>
>> wrapper@resource:///org/gnome/gjs/modules/script/_legacy.js:82:27
>> enable@/home/harvey/.local/share/gnome-shell/extensions/clipboard-indi=
cator@tudmotu.com/extension.js:877:26=20
>>
>> _callExtensionEnable@resource:///org/gnome/shell/ui/extensionSystem.js=
:167:32=20
>>
>> _enableAllExtensions/<@resource:///org/gnome/shell/ui/extensionSystem.=
js:601:22=20
>>
>> _enableAllExtensions@resource:///org/gnome/shell/ui/extensionSystem.js=
:600:37=20
>>
>> _sessionUpdated@resource:///org/gnome/shell/ui/extensionSystem.js:628:=
18
>> _emit@resource:///org/gnome/gjs/modules/core/_signals.js:133:47
>> _sync@resource:///org/gnome/shell/ui/sessionMode.js:195:14
>> popMode@resource:///org/gnome/shell/ui/sessionMode.js:163:14
>> _continueDeactivate@resource:///org/gnome/shell/ui/screenShield.js:510=
:30
>> deactivate/<@resource:///org/gnome/shell/ui/screenShield.js:501:44
>> finish@resource:///org/gnome/shell/gdm/authPrompt.js:528:13
>> finish@resource:///org/gnome/shell/ui/unlockDialog.js:870:26
>> deactivate@resource:///org/gnome/shell/ui/screenShield.js:501:26
>> ScreenShield/</<@resource:///org/gnome/shell/ui/screenShield.js:109:57=

>> _emit@resource:///org/gnome/gjs/modules/core/_signals.js:133:47
>> _convertToNativeSignal@resource:///org/gnome/gjs/modules/core/override=
s/Gio.js:169:19=20
>>
>> M=C3=A4r 18 12:51:45 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
305.3268]
>> agent-manager:
>> agent[a9dc596cf875417d,:1.51/org.gnome.Shell.NetworkAgent/1000]: agent=

>> registered
>> M=C3=A4r 18 12:51:45 obelix gnome-shell[1496]: Can't update stage view=
s actor
>> StWidget is on because it needs an allocation.
>> M=C3=A4r 18 12:51:45 obelix gnome-shell[1496]: Can't update stage view=
s actor
>> StWidget is on because it needs an allocation.
>> M=C3=A4r 18 12:51:45 obelix gsd-usb-protect[1724]: Error calling USBGu=
ard
>> DBus to change the protection after a screensaver event:
>> GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name
>> org.usbguard1 was not provided by any .service files
>> M=C3=A4r 18 12:51:50 obelix systemd[1]: NetworkManager-dispatcher.serv=
ice:
>> Succeeded.
>> M=C3=A4r 18 12:51:50 obelix audit[1]: SERVICE_STOP pid=3D1 uid=3D0
>> auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3DNetworkManager-dispat=
cher
>> comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D=
?
>> terminal=3D? res=3Dsuccess'
>> M=C3=A4r 18 12:51:50 obelix kernel: audit: type=3D1131
>> audit(1616068310.133:106): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D429=
4967295
>> msg=3D'unit=3DNetworkManager-dispatcher comm=3D"systemd"
>> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? re=
s=3Dsuccess'
>> M=C3=A4r 18 12:52:15 obelix systemd[1]: systemd-hostnamed.service: Suc=
ceeded.
>> M=C3=A4r 18 12:52:15 obelix audit[1]: SERVICE_STOP pid=3D1 uid=3D0
>> auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-hostnamed
>> comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D=
?
>> terminal=3D? res=3Dsuccess'
>> M=C3=A4r 18 12:52:15 obelix kernel: audit: type=3D1131
>> audit(1616068335.350:107): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D429=
4967295
>> msg=3D'unit=3Dsystemd-hostnamed comm=3D"systemd"
>> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? re=
s=3Dsuccess'
>> M=C3=A4r 18 12:52:15 obelix audit: BPF prog-id=3D26 op=3DUNLOAD
>> M=C3=A4r 18 12:52:15 obelix audit: BPF prog-id=3D25 op=3DUNLOAD
>> M=C3=A4r 18 12:52:15 obelix kernel: audit: type=3D1334
>> audit(1616068335.470:108): prog-id=3D26 op=3DUNLOAD
>> M=C3=A4r 18 12:52:15 obelix kernel: audit: type=3D1334
>> audit(1616068335.470:109): prog-id=3D25 op=3DUNLOAD
>> M=C3=A4r 18 12:52:35 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
355.6125]
>> manager: sleep: sleep requested (sleeping: no=C2=A0 enabled: yes)
>> M=C3=A4r 18 12:52:35 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
355.6130]
>> device (wlp4s0): state change: disconnected -> unmanaged (reason
>> 'sleeping', sys-iface-state: 'managed')
>> M=C3=A4r 18 12:52:35 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
355.6174]
>> device (p2p-dev-wlp4s0): state change: disconnected -> unmanaged (reas=
on
>> 'sleeping', sys-iface-state: 'managed')
>> M=C3=A4r 18 12:52:35 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
355.6176]
>> manager: NetworkManager state is now ASLEEP
>> M=C3=A4r 18 12:52:35 obelix wpa_supplicant[954]: nl80211: deinit
>> ifname=3Dp2p-dev-wlp4s0 disabled_11b_rates=3D0
>> M=C3=A4r 18 12:52:35 obelix wpa_supplicant[954]: nl80211: deinit
>> ifname=3Dwlp4s0 disabled_11b_rates=3D0
>> M=C3=A4r 18 12:52:36 obelix gnome-shell[1496]:
>> ../glib/gobject/gsignal.c:2732: instance '0x560b86fddb50' has no handl=
er
>> with id '16906'
>> M=C3=A4r 18 12:52:36 obelix gsd-media-keys[1691]: Unable to get defaul=
t sink
>> M=C3=A4r 18 12:52:36 obelix gnome-shell[1496]:
>> ../glib/gobject/gsignal.c:2732: instance '0x560b861ca0d0' has no handl=
er
>> with id '128700'
>> M=C3=A4r 18 12:52:40 obelix gsd-usb-protect[1724]: Error calling USBGu=
ard
>> DBus to change the protection after a screensaver event:
>> GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name
>> org.usbguard1 was not provided by any .service files
>> M=C3=A4r 18 12:52:40 obelix systemd[1]: Reached target Sleep.
>> M=C3=A4r 18 12:52:40 obelix systemd[1]: Starting Hibernate...
>> M=C3=A4r 18 12:52:40 obelix systemd-sleep[2193]: Suspending system...
>> M=C3=A4r 18 12:52:40 obelix kernel: PM: hibernation: hibernation entry=

>> M=C3=A4r 18 13:00:43 obelix kernel: Filesystems sync: 0.020 seconds
>> M=C3=A4r 18 13:00:43 obelix kernel: Freezing user space processes ...
>> (elapsed 0.001 seconds) done.
>> M=C3=A4r 18 13:00:43 obelix kernel: OOM killer disabled.
>> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Marking nosave pa=
ges:
>> [mem 0x00000000-0x00000fff]
>> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Marking nosave pa=
ges:
>> [mem 0x000a0000-0x000fffff]
>> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Marking nosave pa=
ges:
>> [mem 0x09bff000-0x09ffffff]
>> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Marking nosave pa=
ges:
>> [mem 0x0a200000-0x0a20cfff]
>> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Marking nosave pa=
ges:
>> [mem 0xa5fb2000-0xa60a5fff]
>> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Marking nosave pa=
ges:
>> [mem 0xa84ad000-0xa84adfff]
>> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Marking nosave pa=
ges:
>> [mem 0xa9ee7000-0xad5fefff]
>> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Marking nosave pa=
ges:
>> [mem 0xae000000-0xffffffff]
>> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Basic memory bitm=
aps=20
>> created
>> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Preallocating ima=
ge=20
>> memory
>> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Allocated 500589 =
pages
>> for snapshot
>> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Allocated 2002356=
 kbytes
>> in 0.47 seconds (4260.33 MB/s)
>> M=C3=A4r 18 13:00:43 obelix kernel: Freezing remaining freezable tasks=
 ...
>> (elapsed 0.022 seconds) done.
>> M=C3=A4r 18 13:00:43 obelix kernel: printk: Suspending console(s) (use=

>> no_console_suspend to debug)
>> M=C3=A4r 18 13:00:43 obelix kernel: [drm] free PSP TMR buffer
>> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: MODE2=
 reset
>> M=C3=A4r 18 13:00:43 obelix kernel: [drm] free PSP TMR buffer
>> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:03:00.0: amdgpu: MODE1=
 reset
>> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:03:00.0: amdgpu: GPU p=
sp
>> mode1 reset
>> M=C3=A4r 18 13:00:43 obelix kernel: [drm] psp mode1 reset succeed
>> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: EC: interrupt blocked
>> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: Preparing to enter system sl=
eep
>> state S4
>> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: EC: event blocked
>> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: EC: EC stopped
>> M=C3=A4r 18 13:00:43 obelix kernel: PM: Saving platform NVS memory
>> M=C3=A4r 18 13:00:43 obelix kernel: Disabling non-boot CPUs ...
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 1 is now offline
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 2 is now offline
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 3 is now offline
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 4 is now offline
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 5 is now offline
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 6 is now offline
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 7 is now offline
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 8 is now offline
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 9 is now offline
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 10 is now offline
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 11 is now offline
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 12 is now offline
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 13 is now offline
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 14 is now offline
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 15 is now offline
>> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Creating image:
>> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Need to copy 4984=
14 pages
>> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Normal pages need=
ed:
>> 498414 + 1024, available pages: 3537589
>> M=C3=A4r 18 13:00:43 obelix kernel: PM: Restoring platform NVS memory
>> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: EC: EC started
>> M=C3=A4r 18 13:00:43 obelix kernel: LVT offset 0 assigned for vector 0=
x400
>> M=C3=A4r 18 13:00:43 obelix kernel: Enabling non-boot CPUs ...
>> M=C3=A4r 18 13:00:43 obelix kernel: x86: Booting SMP configuration:
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor =
1=20
>> APIC 0x1
>> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU1: patch_level=3D0x0=
8600104
>> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P001: Found 3 idl=
e states
>> M=C3=A4r 18 13:00:43 obelix kernel: CPU1 is up
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor =
2=20
>> APIC 0x2
>> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU2: patch_level=3D0x0=
8600104
>> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P002: Found 3 idl=
e states
>> M=C3=A4r 18 13:00:43 obelix kernel: CPU2 is up
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor =
3=20
>> APIC 0x3
>> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU3: patch_level=3D0x0=
8600104
>> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P003: Found 3 idl=
e states
>> M=C3=A4r 18 13:00:43 obelix kernel: CPU3 is up
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor =
4=20
>> APIC 0x4
>> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU4: patch_level=3D0x0=
8600104
>> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P004: Found 3 idl=
e states
>> M=C3=A4r 18 13:00:43 obelix kernel: CPU4 is up
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor =
5=20
>> APIC 0x5
>> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU5: patch_level=3D0x0=
8600104
>> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P005: Found 3 idl=
e states
>> M=C3=A4r 18 13:00:43 obelix kernel: CPU5 is up
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor =
6=20
>> APIC 0x6
>> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU6: patch_level=3D0x0=
8600104
>> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P006: Found 3 idl=
e states
>> M=C3=A4r 18 13:00:43 obelix kernel: CPU6 is up
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor =
7=20
>> APIC 0x7
>> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU7: patch_level=3D0x0=
8600104
>> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P007: Found 3 idl=
e states
>> M=C3=A4r 18 13:00:43 obelix kernel: CPU7 is up
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor =
8=20
>> APIC 0x8
>> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU8: patch_level=3D0x0=
8600104
>> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P008: Found 3 idl=
e states
>> M=C3=A4r 18 13:00:43 obelix kernel: CPU8 is up
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor =
9=20
>> APIC 0x9
>> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU9: patch_level=3D0x0=
8600104
>> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P009: Found 3 idl=
e states
>> M=C3=A4r 18 13:00:43 obelix kernel: CPU9 is up
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor =
10=20
>> APIC 0xa
>> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU10: patch_level=3D0x=
08600104
>> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P00A: Found 3 idl=
e states
>> M=C3=A4r 18 13:00:43 obelix kernel: CPU10 is up
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor =
11=20
>> APIC 0xb
>> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU11: patch_level=3D0x=
08600104
>> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P00B: Found 3 idl=
e states
>> M=C3=A4r 18 13:00:43 obelix kernel: CPU11 is up
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor =
12=20
>> APIC 0xc
>> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU12: patch_level=3D0x=
08600104
>> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P00C: Found 3 idl=
e states
>> M=C3=A4r 18 13:00:43 obelix kernel: CPU12 is up
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor =
13=20
>> APIC 0xd
>> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU13: patch_level=3D0x=
08600104
>> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P00D: Found 3 idl=
e states
>> M=C3=A4r 18 13:00:43 obelix kernel: CPU13 is up
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor =
14=20
>> APIC 0xe
>> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU14: patch_level=3D0x=
08600104
>> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P00E: Found 3 idl=
e states
>> M=C3=A4r 18 13:00:43 obelix kernel: CPU14 is up
>> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor =
15=20
>> APIC 0xf
>> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU15: patch_level=3D0x=
08600104
>> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P00F: Found 3 idl=
e states
>> M=C3=A4r 18 13:00:43 obelix kernel: CPU15 is up
>> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: Waking up from system sleep =
state S4
>> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: EC: interrupt unblocked
>> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: EC: event unblocked
>> M=C3=A4r 18 13:00:43 obelix kernel: pci 0000:00:00.2: can't derive rou=
ting
>> for PCI INT A
>> M=C3=A4r 18 13:00:43 obelix kernel: pci 0000:00:00.2: PCI INT A: no GS=
I
>> M=C3=A4r 18 13:00:43 obelix kernel: usb usb1: root hub lost power or w=
as reset
>> M=C3=A4r 18 13:00:43 obelix kernel: usb usb2: root hub lost power or w=
as reset
>> M=C3=A4r 18 13:00:43 obelix kernel: usb usb3: root hub lost power or w=
as reset
>> M=C3=A4r 18 13:00:43 obelix kernel: usb usb4: root hub lost power or w=
as reset
>> M=C3=A4r 18 13:00:43 obelix kernel: [drm] PCIE GART of 512M enabled (t=
able at
>> 0x0000008000000000).
>> M=C3=A4r 18 13:00:43 obelix kernel: [drm] PSP is resuming...
>> M=C3=A4r 18 13:00:43 obelix kernel: [drm] PCIE GART of 1024M enabled (=
table
>> at 0x000000F400900000).
>> M=C3=A4r 18 13:00:43 obelix kernel: [drm] PSP is resuming...
>> M=C3=A4r 18 13:00:43 obelix kernel: [drm] reserve 0x400000 from 0xf41f=
800000
>> for PSP TMR
>> M=C3=A4r 18 13:00:43 obelix kernel: nvme nvme0: Shutdown timeout set t=
o 8=20
>> seconds
>> M=C3=A4r 18 13:00:43 obelix kernel: nvme nvme0: 16/0/0 default/read/po=
ll=20
>> queues
>> M=C3=A4r 18 13:00:43 obelix kernel: [drm:psp_v11_0_ring_create [amdgpu=
]]
>> *ERROR* Failed to wait for sOS ready for ring creation
>> M=C3=A4r 18 13:00:43 obelix kernel: [drm:psp_hw_start [amdgpu]] *ERROR=
* PSP
>> create ring failed!
>> M=C3=A4r 18 13:00:43 obelix kernel: [drm:psp_resume [amdgpu]] *ERROR* =
PSP
>> resume failed
>> M=C3=A4r 18 13:00:43 obelix kernel: [drm:amdgpu_device_fw_loading [amd=
gpu]]
>> *ERROR* resume of IP block <psp> failed -62
>> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:03:00.0: amdgpu:
>> amdgpu_device_ip_resume failed (-62).
>> M=C3=A4r 18 13:00:43 obelix kernel: PM: dpm_run_callback():
>> pci_pm_restore+0x0/0xe0 returns -62
>> M=C3=A4r 18 13:00:43 obelix kernel: PM: Device 0000:03:00.0 failed to =
restore
>> async: error -62
>> M=C3=A4r 18 13:00:43 obelix kernel: ata2: SATA link down (SStatus 0=20
>> SControl 300)
>> M=C3=A4r 18 13:00:43 obelix kernel: ata1: SATA link down (SStatus 0=20
>> SControl 300)
>> M=C3=A4r 18 13:00:43 obelix kernel: usb 4-1: reset SuperSpeed Gen 1 US=
B
>> device number 2 using xhci_hcd
>> M=C3=A4r 18 13:00:43 obelix kernel: usb 1-1: reset high-speed USB devi=
ce
>> number 2 using xhci_hcd
>> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: RAS:
>> optional ras ta ucode is not available
>> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: RAP:
>> optional rap ta ucode is not available
>> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: SMU i=
s
>> resuming...
>> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: dpm h=
as been
>> disabled
>> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: SMU i=
s
>> resumed successfully!
>> M=C3=A4r 18 13:00:43 obelix kernel: usb 3-3: reset full-speed USB devi=
ce
>> number 3 using xhci_hcd
>> M=C3=A4r 18 13:00:43 obelix kernel: [drm] kiq ring mec 2 pipe 1 q 0
>> M=C3=A4r 18 13:00:43 obelix kernel: [drm] DMUB hardware initialized:
>> version=3D0x01000000
>> M=C3=A4r 18 13:00:43 obelix kernel: usb 1-4: reset high-speed USB devi=
ce
>> number 3 using xhci_hcd
>> M=C3=A4r 18 13:00:43 obelix kernel: [drm] VCN decode and encode initia=
lized
>> successfully(under DPG Mode).
>> M=C3=A4r 18 13:00:43 obelix kernel: [drm] JPEG decode initialized=20
>> successfully.
>> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring =
gfx
>> uses VM inv eng 0 on hub 0
>> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
>> comp_1.0.0 uses VM inv eng 1 on hub 0
>> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
>> comp_1.1.0 uses VM inv eng 4 on hub 0
>> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
>> comp_1.2.0 uses VM inv eng 5 on hub 0
>> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
>> comp_1.3.0 uses VM inv eng 6 on hub 0
>> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
>> comp_1.0.1 uses VM inv eng 7 on hub 0
>> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
>> comp_1.1.1 uses VM inv eng 8 on hub 0
>> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
>> comp_1.2.1 uses VM inv eng 9 on hub 0
>> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
>> comp_1.3.1 uses VM inv eng 10 on hub 0
>> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
>> kiq_2.1.0 uses VM inv eng 11 on hub 0
>> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring =
sdma0
>> uses VM inv eng 0 on hub 1
>> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring =
vcn_dec
>> uses VM inv eng 1 on hub 1
>> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
>> vcn_enc0 uses VM inv eng 4 on hub 1
>> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
>> vcn_enc1 uses VM inv eng 5 on hub 1
>> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
>> jpeg_dec uses VM inv eng 6 on hub 1
>> M=C3=A4r 18 13:00:43 obelix kernel: usb 3-1: reset high-speed USB devi=
ce
>> number 2 using xhci_hcd
>> M=C3=A4r 18 13:00:43 obelix kernel: usb 1-1.2: reset high-speed USB de=
vice
>> number 4 using xhci_hcd
>> M=C3=A4r 18 13:00:43 obelix kernel: usb 1-1.3: reset high-speed USB de=
vice
>> number 5 using xhci_hcd
>> M=C3=A4r 18 13:00:43 obelix kernel: usb 4-1.4: reset SuperSpeed Gen 1 =
USB
>> device number 3 using xhci_hcd
>> M=C3=A4r 18 13:00:43 obelix kernel: usb 3-1.2: reset full-speed USB de=
vice
>> number 4 using xhci_hcd
>> M=C3=A4r 18 13:00:43 obelix kernel: usb 3-1.3: reset full-speed USB de=
vice
>> number 5 using xhci_hcd
>> M=C3=A4r 18 13:00:43 obelix kernel: usb 3-1.4: reset high-speed USB de=
vice
>> number 6 using xhci_hcd
>> M=C3=A4r 18 13:00:43 obelix kernel: usb 3-1.4.1: reset full-speed USB =
device
>> number 7 using xhci_hcd
>> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Basic memory bitm=
aps=20
>> freed
>> M=C3=A4r 18 13:00:43 obelix kernel: OOM killer enabled.
>> M=C3=A4r 18 13:00:43 obelix kernel: Restarting tasks ... done.
>> M=C3=A4r 18 13:00:43 obelix kernel: thermal thermal_zone1: failed to r=
ead out
>> thermal zone (-61)
>> M=C3=A4r 18 13:00:43 obelix kernel: audit: type=3D1130
>> audit(1616068843.306:110): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D429=
4967295
>> msg=3D'unit=3Dsystemd-rfkill comm=3D"systemd" exe=3D"/usr/lib/systemd/=
systemd"
>> hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
>> M=C3=A4r 18 13:00:43 obelix audit[1]: SERVICE_START pid=3D1 uid=3D0
>> auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-rfkill comm=3D=
"systemd"
>> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? re=
s=3Dsuccess'
>> M=C3=A4r 18 13:00:43 obelix bluetoothd[863]: Endpoint unregistered:
>> sender=3D:1.55 path=3D/MediaEndpoint/A2DPSink/sbc
>> M=C3=A4r 18 13:00:43 obelix systemd[1]: Starting Load/Save RF Kill Swi=
tch
>> Status...
>> M=C3=A4r 18 13:00:43 obelix blueman.desktop[1725]: blueman-applet 13.0=
0.43
>> WARNING=C2=A0 DiscvManager:75 on_adapter_removed: Warning: adapter is =
None
>> M=C3=A4r 18 13:00:43 obelix bluetoothd[863]: Endpoint unregistered:
>> sender=3D:1.55 path=3D/MediaEndpoint/A2DPSource/sbc
>> M=C3=A4r 18 13:00:43 obelix systemd[1]: Started Load/Save RF Kill Swit=
ch=20
>> Status.
>> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as ad=
d on
>> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb4/4-1
>> M=C3=A4r 18 13:00:43 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(=
0):
>> EDID vendor "AUO", prod id 18333
>> M=C3=A4r 18 13:00:43 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(=
0):
>> Using hsync ranges from config file
>> M=C3=A4r 18 13:00:43 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(=
0):
>> Using vrefresh ranges from config file
>> M=C3=A4r 18 13:00:43 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(=
0):
>> Printing DDC gathered Modelines:
>> M=C3=A4r 18 13:00:43 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(=
0):
>> Modeline "1920x1080"x0.0=C2=A0 306.73=C2=A0 1920 1968 2000 2102=C2=A0 =
1080 1090 1095
>> 1216 -hsync -vsync (145.9 kHz eP)
>> M=C3=A4r 18 13:00:43 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(=
0):
>> Modeline "1920x1080"x0.0=C2=A0 122.70=C2=A0 1920 1968 2000 2102=C2=A0 =
1080 1090 1095
>> 1216 -hsync -vsync (58.4 kHz e)
>> M=C3=A4r 18 13:00:43 obelix /usr/lib/gdm-x-session[1352]: (--) AMDGPU(=
G0):
>> HDMI max TMDS frequency 300000KHz
>> M=C3=A4r 18 13:00:43 obelix systemd[1335]: Stopped target Bluetooth.
>> M=C3=A4r 18 13:00:43 obelix systemd[1]: Stopped target Bluetooth.
>> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as ad=
d on
>> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-1
>> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as ad=
d on
>> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.3/usb1/1-1
>> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as ad=
d on
>> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-3
>> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as ad=
d on
>> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb4/4-1
>> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as ad=
d on
>> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-1
>> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as ad=
d on
>> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.3/usb1/1-1
>> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as ad=
d on
>> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-3
>> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as ad=
d on
>> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-1/3-1.2
>> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as ad=
d on
>> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-1/3-1.4
>> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as ad=
d on
>> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb4/4-1/4-1.4
>> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as ad=
d on
>> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-1/3-1.2
>> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as ad=
d on
>> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-1/3-1.4
>> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as ad=
d on
>> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb4/4-1/4-1.4
>> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as ad=
d on
>> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-1/3-1.4/3-1.4=
=2E1
>> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as ad=
d on
>> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-1/3-1.4/3-1.4=
=2E1
>> M=C3=A4r 18 13:00:43 obelix systemd-sleep[2193]: System resumed.
>> M=C3=A4r 18 13:00:43 obelix systemd[1]: systemd-hibernate.service: Suc=
ceeded.
>> M=C3=A4r 18 13:00:43 obelix systemd[1]: Finished Hibernate.
>> M=C3=A4r 18 13:00:43 obelix audit[1]: SERVICE_START pid=3D1 uid=3D0
>> auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-hibernate
>> comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D=
?
>> terminal=3D? res=3Dsuccess'
>> M=C3=A4r 18 13:00:43 obelix audit[1]: SERVICE_STOP pid=3D1 uid=3D0
>> auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-hibernate
>> comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D=
?
>> terminal=3D? res=3Dsuccess'
>> M=C3=A4r 18 13:00:43 obelix systemd[1]: Reached target Hibernate.
>> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: hibernation exit
>> M=C3=A4r 18 13:00:43 obelix kernel: audit: type=3D1130
>> audit(1616068843.413:111): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D429=
4967295
>> msg=3D'unit=3Dsystemd-hibernate comm=3D"systemd"
>> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? re=
s=3Dsuccess'
>> M=C3=A4r 18 13:00:43 obelix kernel: audit: type=3D1131
>> audit(1616068843.413:112): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D429=
4967295
>> msg=3D'unit=3Dsystemd-hibernate comm=3D"systemd"
>> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? re=
s=3Dsuccess'
>> M=C3=A4r 18 13:00:43 obelix systemd[1]: Stopped target Sleep.
>> M=C3=A4r 18 13:00:43 obelix systemd[1]: Stopped target Hibernate.
>> M=C3=A4r 18 13:00:43 obelix systemd-logind[868]: Operation 'sleep' fin=
ished.
>> M=C3=A4r 18 13:00:43 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
843.4204]
>> manager: sleep: wake requested (sleeping: yes=C2=A0 enabled: yes)
>> M=C3=A4r 18 13:00:43 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
843.4205]
>> device (enp5s0): state change: activated -> unmanaged (reason
>> 'sleeping', sys-iface-state: 'managed')
>> M=C3=A4r 18 13:00:43 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
843.4357]
>> dhcp4 (enp5s0): canceled DHCP transaction
>> M=C3=A4r 18 13:00:43 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
843.4358]
>> dhcp4 (enp5s0): state changed bound -> done
>> M=C3=A4r 18 13:00:43 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
843.4476]
>> manager: NetworkManager state is now CONNECTED_GLOBAL
>> M=C3=A4r 18 13:00:43 obelix systemd[1]: Reached target Bluetooth.
>> M=C3=A4r 18 13:00:43 obelix kernel: Bluetooth: hci0: Bootloader revisi=
on 0.3
>> build 0 week 24 2017
>> M=C3=A4r 18 13:00:43 obelix systemd[1335]: Reached target Bluetooth.
>> M=C3=A4r 18 13:00:43 obelix kernel: Bluetooth: hci0: Device revision i=
s 1
>> M=C3=A4r 18 13:00:43 obelix kernel: Bluetooth: hci0: Secure boot is en=
abled
>> M=C3=A4r 18 13:00:43 obelix kernel: Bluetooth: hci0: OTP lock is enabl=
ed
>> M=C3=A4r 18 13:00:43 obelix kernel: Bluetooth: hci0: API lock is enabl=
ed
>> M=C3=A4r 18 13:00:43 obelix kernel: Bluetooth: hci0: Debug lock is dis=
abled
>> M=C3=A4r 18 13:00:43 obelix kernel: Bluetooth: hci0: Minimum firmware =
build 1
>> week 10 2014
>> M=C3=A4r 18 13:00:43 obelix kernel: Bluetooth: hci0: Found device firm=
ware:
>> intel/ibt-20-1-3.sfi
>> M=C3=A4r 18 13:00:43 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
843.6012]
>> manager: NetworkManager state is now DISCONNECTED
>> M=C3=A4r 18 13:00:43 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
843.6027]
>> device (enp5s0): state change: unmanaged -> unavailable (reason
>> 'managed', sys-iface-state: 'external')
>> M=C3=A4r 18 13:00:43 obelix dbus-daemon[865]: [system] Activating via
>> systemd: service name=3D'org.freedesktop.nm_dispatcher'
>> unit=3D'dbus-org.freedesktop.nm-dispatcher.service' requested by ':1.2=
'
>> (uid=3D0 pid=3D866 comm=3D"/usr/bin/NetworkManager --no-daemon ")
>> M=C3=A4r 18 13:00:43 obelix systemd[1]: Starting Network Manager Scrip=
t
>> Dispatcher Service...
>> M=C3=A4r 18 13:00:43 obelix dbus-daemon[865]: [system] Successfully ac=
tivated
>> service 'org.freedesktop.nm_dispatcher'
>> M=C3=A4r 18 13:00:43 obelix systemd[1]: Started Network Manager Script=

>> Dispatcher Service.
>> M=C3=A4r 18 13:00:43 obelix audit[1]: SERVICE_START pid=3D1 uid=3D0
>> auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3DNetworkManager-dispat=
cher
>> comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D=
?
>> terminal=3D? res=3Dsuccess'
>> M=C3=A4r 18 13:00:43 obelix kernel: enp5s0: 0xffffb20a00665000,
>> 00:d8:61:e6:48:1c, IRQ 61
>> M=C3=A4r 18 13:00:43 obelix kernel: audit: type=3D1130
>> audit(1616068843.610:113): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D429=
4967295
>> msg=3D'unit=3DNetworkManager-dispatcher comm=3D"systemd"
>> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? re=
s=3Dsuccess'
>> M=C3=A4r 18 13:00:43 obelix rtkit-daemon[1157]: Supervising 3 threads =
of 1
>> processes of 1 users.
>> M=C3=A4r 18 13:00:43 obelix rtkit-daemon[1157]: Successfully made thre=
ad 2283
>> of process 1497 owned by '1000' RT at priority 5.
>> M=C3=A4r 18 13:00:43 obelix rtkit-daemon[1157]: Supervising 4 threads =
of 1
>> processes of 1 users.
>> M=C3=A4r 18 13:00:43 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
843.8678]
>> device (wlp4s0): state change: unmanaged -> unavailable (reason
>> 'managed', sys-iface-state: 'external')
>> M=C3=A4r 18 13:00:44 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
844.1282]
>> device (wlp4s0): set-hw-addr: set MAC address to 8E:7C:CA:62:5B:A4
>> (scanning)
>> M=C3=A4r 18 13:00:44 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
844.3776]
>> device (p2p-dev-wlp4s0): state change: unmanaged -> unavailable (reaso=
n
>> 'managed', sys-iface-state: 'external')
>> M=C3=A4r 18 13:00:45 obelix kernel: [drm] Failed to add display topolo=
gy, DTM
>> TA is not initialized.
>> M=C3=A4r 18 13:00:45 obelix kernel: Bluetooth: hci0: Waiting for firmw=
are
>> download to complete
>> M=C3=A4r 18 13:00:45 obelix kernel: Bluetooth: hci0: Firmware loaded i=
n
>> 1607510 usecs
>> M=C3=A4r 18 13:00:45 obelix kernel: Bluetooth: hci0: Waiting for devic=
e to=20
>> boot
>> M=C3=A4r 18 13:00:45 obelix kernel: Bluetooth: hci0: Device booted in =
15915=20
>> usecs
>> M=C3=A4r 18 13:00:45 obelix kernel: Bluetooth: hci0: Found Intel DDC
>> parameters: intel/ibt-20-1-3.ddc
>> M=C3=A4r 18 13:00:45 obelix kernel: Bluetooth: hci0: Applying Intel DD=
C
>> parameters completed
>> M=C3=A4r 18 13:00:45 obelix kernel: Bluetooth: hci0: Firmware revision=
 0.0
>> build 121 week 7 2021
>> M=C3=A4r 18 13:00:45 obelix bluetoothd[863]: Endpoint registered:
>> sender=3D:1.55 path=3D/MediaEndpoint/A2DPSink/sbc
>> M=C3=A4r 18 13:00:45 obelix bluetoothd[863]: Endpoint registered:
>> sender=3D:1.55 path=3D/MediaEndpoint/A2DPSource/sbc
>> M=C3=A4r 18 13:00:46 obelix kernel: r8168: enp5s0: link up
>> M=C3=A4r 18 13:00:46 obelix kernel: IPv6: ADDRCONF(NETDEV_CHANGE): enp=
5s0:
>> link becomes ready
>> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
848.3109]
>> device (enp5s0): carrier: link connected
>> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
848.3120]
>> device (enp5s0): state change: unavailable -> disconnected (reason
>> 'carrier-changed', sys-iface-state: 'managed')
>> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
848.3160]
>> device (wlp4s0): supplicant interface state: internal-starting ->
>> disconnected
>> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
848.3160]
>> device (p2p-dev-wlp4s0): state change: unavailable -> unmanaged (reaso=
n
>> 'removed', sys-iface-state: 'removed')
>> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
848.3171]
>> Wi-Fi P2P device controlled by interface wlp4s0 created
>> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
848.3177]
>> manager: (p2p-dev-wlp4s0): new 802.11 Wi-Fi P2P device
>> (/org/freedesktop/NetworkManager/Devices/6)
>> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
848.3182]
>> device (p2p-dev-wlp4s0): state change: unmanaged -> unavailable (reaso=
n
>> 'managed', sys-iface-state: 'external')
>> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
848.3194]
>> policy: auto-activating connection 'Kabelgebundene Verbindung 1'
>> (c38c81cb-d88f-4897-9ece-659d13774b9a)
>> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
848.3201]
>> device (enp5s0): Activation: starting connection 'Kabelgebundene
>> Verbindung 1' (c38c81cb-d88f-4897-9ece-659d13774b9a)
>> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
848.3201]
>> device (wlp4s0): state change: unavailable -> disconnected (reason
>> 'supplicant-available', sys-iface-state: 'managed')
>> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
848.3209]
>> device (p2p-dev-wlp4s0): state change: unavailable -> disconnected
>> (reason 'none', sys-iface-state: 'managed')
>> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
848.3214]
>> device (enp5s0): state change: disconnected -> prepare (reason 'none',=

>> sys-iface-state: 'managed')
>> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
848.3220]
>> manager: NetworkManager state is now CONNECTING
>> M=C3=A4r 18 13:00:48 obelix gnome-shell[1496]: Removing a network devi=
ce that
>> was not added
>> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
848.3222]
>> device (enp5s0): state change: prepare -> config (reason 'none',
>> sys-iface-state: 'managed')
>> M=C3=A4r 18 13:00:48 obelix gnome-shell[1496]: Removing a network devi=
ce that
>> was not added
>> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
848.3233]
>> device (enp5s0): state change: config -> ip-config (reason 'none',
>> sys-iface-state: 'managed')
>> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
848.3236]
>> dhcp4 (enp5s0): activation: beginning transaction (timeout in 45 secon=
ds)
>> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
848.3549]
>> dhcp4 (enp5s0): state changed unknown -> bound, address=3D192.168.1.1
>> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <warn>=C2=A0 [1616068=
848.3554]
>> sup-iface[11828c54025c5ecd,2,wlp4s0]: call-p2p-cancel: failed with P2P=

>> cancel failed
>> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
848.3570]
>> device (enp5s0): state change: ip-config -> ip-check (reason 'none',
>> sys-iface-state: 'managed')
>> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
848.3606]
>> device (enp5s0): state change: ip-check -> secondaries (reason 'none',=

>> sys-iface-state: 'managed')
>> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
848.3609]
>> device (enp5s0): state change: secondaries -> activated (reason 'none'=
,
>> sys-iface-state: 'managed')
>> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
848.3616]
>> manager: NetworkManager state is now CONNECTED_LOCAL
>> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
848.3629]
>> manager: NetworkManager state is now CONNECTED_SITE
>> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
848.3631]
>> policy: set 'Kabelgebundene Verbindung 1' (enp5s0) as default for IPv4=

>> routing and DNS
>> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
848.3701]
>> device (enp5s0): Activation: successful, device activated.
>> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>=C2=A0 [1616068=
848.4835]
>> manager: NetworkManager state is now CONNECTED_GLOBAL
>> M=C3=A4r 18 13:00:48 obelix systemd[1]: systemd-rfkill.service: Succee=
ded.
>> M=C3=A4r 18 13:00:48 obelix audit[1]: SERVICE_STOP pid=3D1 uid=3D0
>> auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-rfkill comm=3D=
"systemd"
>> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? re=
s=3Dsuccess'
>> M=C3=A4r 18 13:00:48 obelix kernel: audit: type=3D1131
>> audit(1616068848.603:114): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D429=
4967295
>> msg=3D'unit=3Dsystemd-rfkill comm=3D"systemd" exe=3D"/usr/lib/systemd/=
systemd"
>> hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
>> M=C3=A4r 18 13:00:51 obelix wpa_supplicant[954]: wlp4s0:
>> CTRL-EVENT-REGDOM-CHANGE init=3DDRIVER type=3DCOUNTRY alpha2=3DDE
>> M=C3=A4r 18 13:00:54 obelix kernel: [drm:amdgpu_dm_atomic_commit_tail
>> [amdgpu]] *ERROR* Waiting for fences timed out!
>> M=C3=A4r 18 13:00:54 obelix kernel: [drm:amdgpu_job_timedout [amdgpu]]=

>> *ERROR* ring sdma0 timeout, signaled seq=3D552, emitted seq=3D554
>> M=C3=A4r 18 13:00:54 obelix kernel: [drm:amdgpu_job_timedout [amdgpu]]=

>> *ERROR* Process information: process=C2=A0 pid 0 thread=C2=A0 pid 0
>> M=C3=A4r 18 13:00:54 obelix kernel: amdgpu 0000:03:00.0: amdgpu: GPU r=
eset=20
>> begin!
>> M=C3=A4r 18 13:00:54 obelix kernel: BUG: kernel NULL pointer dereferen=
ce,
>> address: 0000000000000029
>> M=C3=A4r 18 13:00:54 obelix kernel: #PF: supervisor read access in ker=
nel mode
>> M=C3=A4r 18 13:00:54 obelix kernel: #PF: error_code(0x0000) - not-pres=
ent page
>> M=C3=A4r 18 13:00:54 obelix kernel: PGD 0 P4D 0
>> M=C3=A4r 18 13:00:54 obelix kernel: Oops: 0000 [#1] PREEMPT SMP NOPTI
>> M=C3=A4r 18 13:00:54 obelix kernel: CPU: 9 PID: 1327 Comm: kworker/9:3=

>> Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 OE=C2=A0=C2=A0=C2=A0=C2=A0 5.11.7-arch1-1 #1
>> M=C3=A4r 18 13:00:54 obelix kernel: Hardware name: Micro-Star Internat=
ional
>> Co., Ltd. Bravo 17 A4DDR/MS-17FK, BIOS E17FKAMS.117 10/29/2020
>> M=C3=A4r 18 13:00:54 obelix kernel: Workqueue: events drm_sched_job_ti=
medout
>> [gpu_sched]
>> M=C3=A4r 18 13:00:54 obelix kernel: RIP: 0010:kernel_queue_uninit+0xd/=
0xf0
>> [amdgpu]
>> M=C3=A4r 18 13:00:54 obelix kernel: Code: ee 48 89 c7 e8 a4 f9 ff ff 8=
4 c0 0f
>> 84 e3 d3 1f 00 4c 89 e0 5d 41 5c 41 5d c3 0f 1f 00 0f 1f 44 00 00 55 4=
8
>> 8b 47 10 48 89 fd <8b> 50 28 83 fa 02 74 78 83 fa 03 0f 84 b1 00 00 00=

>> 48 8b 7f 08 4c
>> M=C3=A4r 18 13:00:54 obelix kernel: RSP: 0018:ffffb20a04a27d40 EFLAGS:=
=20
>> 00010246
>> M=C3=A4r 18 13:00:54 obelix kernel: RAX: 0000000000000001 RBX:
>> ffff9e0c825c4000 RCX: 000000008080007c
>> M=C3=A4r 18 13:00:54 obelix kernel: RDX: 000000008080007d RSI:
>> 0000000000000001 RDI: ffff9e0c8a97f2c0
>> M=C3=A4r 18 13:00:54 obelix kernel: RBP: ffff9e0c8a97f2c0 R08:
>> 0000000000000001 R09: 0000000000000000
>> M=C3=A4r 18 13:00:54 obelix kernel: R10: 0000000000000001 R11:
>> ffffffffb54cba00 R12: ffff9e0c825c40d0
>> M=C3=A4r 18 13:00:54 obelix kernel: R13: ffff9e0c8cf80000 R14:
>> ffff9e0c81489000 R15: ffff9e0c814890c8
>> M=C3=A4r 18 13:00:54 obelix kernel: FS:=C2=A0 0000000000000000(0000)
>> GS:ffff9e0f9f840000(0000) knlGS:0000000000000000
>> M=C3=A4r 18 13:00:54 obelix kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 C=
R0:
>> 0000000080050033
>> M=C3=A4r 18 13:00:54 obelix kernel: CR2: 0000000000000029 CR3:
>> 0000000228210000 CR4: 0000000000350ee0
>> M=C3=A4r 18 13:00:54 obelix kernel: Call Trace:
>> M=C3=A4r 18 13:00:54 obelix kernel:=C2=A0 stop_cpsch+0xa0/0xc0 [amdgpu=
]
>> M=C3=A4r 18 13:00:54 obelix kernel:=C2=A0 kgd2kfd_suspend.part.0+0x2f/=
0x40 [amdgpu]
>> M=C3=A4r 18 13:00:54 obelix kernel:=C2=A0 kgd2kfd_pre_reset+0x3f/0x50 =
[amdgpu]
>> M=C3=A4r 18 13:00:54 obelix kernel:
>> amdgpu_device_gpu_recover.cold+0x36e/0x95d [amdgpu]
>> M=C3=A4r 18 13:00:54 obelix kernel:=C2=A0 amdgpu_job_timedout+0x121/0x=
140 [amdgpu]
>> M=C3=A4r 18 13:00:54 obelix kernel:=C2=A0 drm_sched_job_timedout+0x64/=
0xe0=20
>> [gpu_sched]
>> M=C3=A4r 18 13:00:54 obelix kernel:=C2=A0 process_one_work+0x214/0x3e0=

>> M=C3=A4r 18 13:00:54 obelix kernel:=C2=A0 worker_thread+0x4d/0x3d0
>> M=C3=A4r 18 13:00:54 obelix kernel:=C2=A0 ? rescuer_thread+0x3c0/0x3c0=

>> M=C3=A4r 18 13:00:54 obelix kernel:=C2=A0 kthread+0x133/0x150
>> M=C3=A4r 18 13:00:54 obelix kernel:=C2=A0 ? __kthread_bind_mask+0x60/0=
x60
>> M=C3=A4r 18 13:00:54 obelix kernel:=C2=A0 ret_from_fork+0x22/0x30
>> M=C3=A4r 18 13:00:54 obelix kernel: Modules linked in: rfcomm
>> snd_hda_codec_realtek snd_hda_codec_hdmi snd_hda_codec_generic
>> ledtrig_audio cmac algif_hash algif_skcipher af_alg snd_hda_intel
>> snd_intel_dspcfg soundwire_intel soundwire_generic_allocation bnep
>> soundwire_cadence snd_hda_codec iwlmvm snd_hda_core nls_iso8859_1
>> snd_hwdep vfat intel_rapl_msr intel_rapl_common soundwire_bus fat
>> hid_multitouch gpio_keys snd_soc_core btusb mac80211 edac_mce_amd
>> kvm_amd libarc4 uvcvideo snd_compress btrtl ac97_bus btbcm iwlwifi
>> pktcdvd snd_pcm_dmaengine videobuf2_vmalloc kvm btintel videobuf2_memo=
ps
>> snd_pcm videobuf2_v4l2 bluetooth videobuf2_common videodev joydev
>> snd_timer mousedev irqbypass ecdh_generic msi_wmi mc ecc cfg80211 rapl=

>> psmouse pcspkr sparse_keymap snd k10temp i2c_piix4 snd_rn_pci_acp3x
>> snd_pci_acp3x soundcore rfkill i2c_hid tpm_crb acpi_cpufreq tpm_tis
>> mac_hid soc_button_array pinctrl_amd tpm_tis_core vboxnetflt(OE)
>> vboxnetadp(OE) vboxdrv(OE) usbip_host usbip_core sg fuse crypto_user
>> bpf_preload ip_tables
>> M=C3=A4r 18 13:00:54 obelix kernel:=C2=A0 x_tables ext4 crc32c_generic=
 crc16
>> mbcache jbd2 sr_mod cdrom uas usb_storage dm_crypt cbc encrypted_keys
>> dm_mod trusted tpm crct10dif_pclmul crc32_pclmul crc32c_intel
>> ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper ccp
>> serio_raw xhci_pci rng_core xhci_pci_renesas wmi video usbhid r8168(OE=
)
>> amdgpu drm_ttm_helper ttm gpu_sched i2c_algo_bit drm_kms_helper
>> syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm agpgart
>> M=C3=A4r 18 13:00:54 obelix kernel: CR2: 0000000000000029
>> M=C3=A4r 18 13:00:54 obelix kernel: ---[ end trace ff2438cc3b9cd967 ]-=
--
>> M=C3=A4r 18 13:00:54 obelix kernel: RIP: 0010:kernel_queue_uninit+0xd/=
0xf0
>> [amdgpu]
>> M=C3=A4r 18 13:00:54 obelix kernel: Code: ee 48 89 c7 e8 a4 f9 ff ff 8=
4 c0 0f
>> 84 e3 d3 1f 00 4c 89 e0 5d 41 5c 41 5d c3 0f 1f 00 0f 1f 44 00 00 55 4=
8
>> 8b 47 10 48 89 fd <8b> 50 28 83 fa 02 74 78 83 fa 03 0f 84 b1 00 00 00=

>> 48 8b 7f 08 4c
>> M=C3=A4r 18 13:00:54 obelix kernel: RSP: 0018:ffffb20a04a27d40 EFLAGS:=
=20
>> 00010246
>> M=C3=A4r 18 13:00:54 obelix kernel: RAX: 0000000000000001 RBX:
>> ffff9e0c825c4000 RCX: 000000008080007c
>> M=C3=A4r 18 13:00:54 obelix kernel: RDX: 000000008080007d RSI:
>> 0000000000000001 RDI: ffff9e0c8a97f2c0
>> M=C3=A4r 18 13:00:54 obelix kernel: RBP: ffff9e0c8a97f2c0 R08:
>> 0000000000000001 R09: 0000000000000000
>> M=C3=A4r 18 13:00:54 obelix kernel: R10: 0000000000000001 R11:
>> ffffffffb54cba00 R12: ffff9e0c825c40d0
>> M=C3=A4r 18 13:00:54 obelix kernel: R13: ffff9e0c8cf80000 R14:
>> ffff9e0c81489000 R15: ffff9e0c814890c8
>> M=C3=A4r 18 13:00:54 obelix kernel: FS:=C2=A0 0000000000000000(0000)
>> GS:ffff9e0f9f840000(0000) knlGS:0000000000000000
>> M=C3=A4r 18 13:00:54 obelix kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 C=
R0:
>> 0000000080050033
>> M=C3=A4r 18 13:00:54 obelix kernel: CR2: 0000000000000029 CR3:
>> 00000001083b8000 CR4: 0000000000350ee0
>> M=C3=A4r 18 13:00:54 obelix /usr/lib/gdm-x-session[1352]: (II) event7=C2=
=A0 -
>> Microsoft Microsoft=C2=AE 2.4GHz Transceiver v9.0 Mouse: SYN_DROPPED e=
vent -
>> some input events have been lost.
>> M=C3=A4r 18 13:00:58 obelix systemd[1]: NetworkManager-dispatcher.serv=
ice:
>> Succeeded.
>> M=C3=A4r 18 13:00:58 obelix audit[1]: SERVICE_STOP pid=3D1 uid=3D0
>> auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3DNetworkManager-dispat=
cher
>> comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D=
?
>> terminal=3D? res=3Dsuccess'
>> M=C3=A4r 18 13:00:58 obelix kernel: [drm:amdgpu_dm_atomic_commit_tail
>> [amdgpu]] *ERROR* Waiting for fences timed out!
>> M=C3=A4r 18 13:00:58 obelix kernel: audit: type=3D1131
>> audit(1616068858.453:115): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D429=
4967295
>> msg=3D'unit=3DNetworkManager-dispatcher comm=3D"systemd"
>> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? re=
s=3Dsuccess'
>>
>> Do I still have to apply the patches you mentioned against a vanilla
>> kernel and, if so, to which - 5.7.11 or 5.12-rc3?
>>
>> Greetings
>> Harvey
>>
>=20
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>=20

--=20
I am root. If you see me laughing, you'd better have a backup!


--yGH1vDJjpGlAUiP5nEErzVFBUQdya91Sf--

--4joGxQ7go4vOSxA75Bv9yQsqr3jfvEhkQ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wmMEABEIACMWIQRSRNvmxYqoNs6vm0SLlqqYsFRKCQUCYFjLawUDAAAAAAAKCRCLlqqYsFRKCTp9
AJ4sR3z5uzwaCbdaX7qSap53KEi75ACfS2u9Bd69fQqR2FB3ysRtffg3V8Q=
=NkNu
-----END PGP SIGNATURE-----

--4joGxQ7go4vOSxA75Bv9yQsqr3jfvEhkQ--

--===============1226550737==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1226550737==--
