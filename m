Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E8AC369D9
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Apr 2025 10:13:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0697010E196;
	Sun, 27 Apr 2025 10:13:11 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 998B110E059
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Apr 2025 01:01:15 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so24354685e9.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Apr 2025 18:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745715674; x=1746320474; darn=lists.freedesktop.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T6UkyRbxP8ESomnbNFN5uOfQyin0z1bvnf+ArWTcFy0=;
 b=FdWtEzzzy4zgX4MfPiArV+VE8gU65/QYGwqVVav9Msyo+A9hzUz03alhG3j0NyycQ6
 q9efcIynIms4FkHvMUVJxFUTOzv+j+Z5Ackk4mmJYM548KZh3S1K6pziDQlTENbKADbV
 5ta1AdHOpnTvtEKzKhi5WSe7uVjd+7JwwNIT44+1xDW7onlCnwoLnih79HLz/FqlBt73
 sdjQRq+OCanET08oSW5ZG7xADpMNWlbBMWHC4Pw+BqntMv0FWAG9b6H6r4JXeNJWM55c
 tf4ZXqnRl6rxb1VI/fu1823OwHF2CA0TW+PxgXh7O8NbT/YXeDrhg80c2S4k9UPCxRlX
 qHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745715674; x=1746320474;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T6UkyRbxP8ESomnbNFN5uOfQyin0z1bvnf+ArWTcFy0=;
 b=Ta6W2I/IwrAo6G9ZgmPknhmsUswIzWhFB7Mk0pOIy00jfQyD7axihbtlHnlNEg7mSJ
 WPBi6u479GcIbl5UPC8QT8qroJiGuV1aA9gYpr3j1XXQHLHbD++2YmKW77tpWYdam4z9
 h+fSx9ICHdFWM4cPwnecxRxq1pSK/SYnzvzfPtzFuKExT5/EF1y6jRU9cJg69K2ZL5HP
 y/MDEttewpHNa/zOzdkJ8UrqXU7UaV0VlJXc3mO5q/mhDF4ZKaUc79Dxo/TYZIfAjX0Z
 RGWuP8tEGwF51IKxsAHaxZtnf+pUsd64D71QSoTvcJ/PWUBt0zk01oBtRZk8/DGgWoEO
 RQiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGVqqcos3UOtvbE0Rd5SDVOMQoxINqdHaJyky2hEb/8VHqGzO2OeARYBDNi1fwv/0p8663FxMr@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yynal/pQqDPbl0VbycIsfIfHqGuH0uDQ5yNCSxYI0sQW2jS3DpS
 lYiVOgv1JbDZncOzpocxBjIfs58QQUFKzqd1ejqgBxjWRWSXbJ43UBADmnkuGH0=
X-Gm-Gg: ASbGncuhDF1j61Io/RamUEENgCEl31sBes+9O0j6WpSGoN+X0FAImfGkDpu2hGpTSo8
 HWhUknlClBN9Iw+aYW7mfTCjZOow7x7tZOMjk8F6IjC6YAPtYjk4+MRGHOK9q9opuBzMMHt1BAV
 aRCx9QcfStdybVJYMtNxfRi8TFELta4Z8QQNHrjBYBw04LEkgSj3+s4dBawgOWzR/sRm3RpRC2G
 YJ5j/Gpkmw72HPsU73KrJTPv9R89j9SRC837yqgAtsQ6MtQ73vRqd+bBwKsZ1+x8ybz4CHCpLSn
 yep5mU7/nDJZ8my0xW9FbXbt/VqAXmG1gLFSYKvHjVY78B2T9KM=
X-Google-Smtp-Source: AGHT+IHf9gc9dcKtmqeJD0dwBlBU8miVmWDhkAOjdEMeWxb7uZT8j0R+/rt5A8omhvPaq3v87JXrJg==
X-Received: by 2002:a05:600c:3489:b0:43d:42b:e186 with SMTP id
 5b1f17b1804b1-440a65e81f1mr63131345e9.8.1745715674138; 
 Sat, 26 Apr 2025 18:01:14 -0700 (PDT)
Received: from localhost ([2.216.7.124]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2ac26dsm109469095e9.21.2025.04.26.18.01.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Apr 2025 18:01:13 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 27 Apr 2025 02:01:12 +0100
Message-Id: <D9H0K4EW3XTV.1XO4KO44J1YRE@linaro.org>
Subject: =?utf-8?q?Re:_=E5=9B=9E=E5=A4=8D:_[REGRESSION]_amdgpu:_async_system_error?=
 =?utf-8?q?_exception_from_hdp=5Fv5=5F0=5Fflush=5Fhdp()?=
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Alex Deucher" <alexdeucher@gmail.com>
Cc: "Fugang Duan" <fugang.duan@cixtech.com>, "alexander.deucher@amd.com"
 <alexander.deucher@amd.com>, "frank.min@amd.com" <frank.min@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, "david.belanger@amd.com"
 <david.belanger@amd.com>, "christian.koenig@amd.com"
 <christian.koenig@amd.com>, "Peter Chen" <peter.chen@cixtech.com>,
 "cix-kernel-upstream" <cix-kernel-upstream@cixtech.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
X-Mailer: aerc 0.20.0
References: <D97FB92117J2.PXTNFKCIRWAS@linaro.org>
 <SI2PR06MB5041FB15F8DBB44916FB6430F1BD2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <D980Y4WDV662.L4S7QAU72GN2@linaro.org>
 <CADnq5_NT0syV8wB=MZZRDONsTNSYwNXhGhNg9LOFmn=MJP7d9Q@mail.gmail.com>
 <SI2PR06MB504138A5BEA1E1B3772E8527F1BC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <CADnq5_M=YiMVvMpGaFhn2T3jRWGY2FrsUwCVPG6HupmTzZCYug@mail.gmail.com>
 <D9CT4HS7F067.J0GJHAGHI9G9@linaro.org>
 <CADnq5_ML25QA7xD+bLqNprO3zzTxJYLkiVw-KmeP-N6TqNHRYA@mail.gmail.com>
 <D9DAIUZXIWH3.1L7CV6GEX4C9M@linaro.org>
 <CADnq5_NE2M19JdrULtJH-OXwycDpu0hrFHy42YiJA3nMYoP=+w@mail.gmail.com>
In-Reply-To: <CADnq5_NE2M19JdrULtJH-OXwycDpu0hrFHy42YiJA3nMYoP=+w@mail.gmail.com>
X-Mailman-Approved-At: Sun, 27 Apr 2025 10:13:10 +0000
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

On Thu Apr 24, 2025 at 4:44 PM BST, Alex Deucher wrote:
> On Tue, Apr 22, 2025 at 11:59=E2=80=AFAM Alexey Klimov <alexey.klimov@lin=
aro.org> wrote:
>>
>> On Tue Apr 22, 2025 at 2:00 PM BST, Alex Deucher wrote:
>> > On Mon, Apr 21, 2025 at 10:21=E2=80=AFPM Alexey Klimov <alexey.klimov@=
linaro.org> wrote:
>> >>
>> >> On Thu Apr 17, 2025 at 2:08 PM BST, Alex Deucher wrote:
>> >> > On Wed, Apr 16, 2025 at 8:43=E2=80=AFPM Fugang Duan <fugang.duan@ci=
xtech.com> wrote:
>> >> >>
>> >> >> =E5=8F=91=E4=BB=B6=E4=BA=BA: Alex Deucher <alexdeucher@gmail.com> =
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B44=E6=9C=8816=E6=97=A5 22=
:49
>> >> >> >=E6=94=B6=E4=BB=B6=E4=BA=BA: Alexey Klimov <alexey.klimov@linaro.=
org>
>> >> >> >On Wed, Apr 16, 2025 at 9:48=E2=80=AFAM Alexey Klimov <alexey.kli=
mov@linaro.org> wrote:
>> >> >> >>
>> >> >> >> On Wed Apr 16, 2025 at 4:12 AM BST, Fugang Duan wrote:
>> >> >> >> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Alexey Klimov <alexey.klimov@lin=
aro.org> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B44=E6=9C=8816
>> >> >> >=E6=97=A5 2:28
>> >> >> >> >>#regzbot introduced: v6.12..v6.13
>> >> >> >> >>The only change related to hdp_v5_0_flush_hdp() was
>> >> >> >> >>cf424020e040 drm/amdgpu/hdp5.0: do a posting read when flushi=
ng HDP
>> >> >> >> >>
>> >> >> >> >>Reverting that commit ^^ did help and resolved that problem. =
Before
>>
>> [..]
>>
>> >> > OK.  that patch won't change anything then.  Can you try this patch=
 instead?
>> >>
>> >> Config I am using is basically defconfig wrt memory parameters, yeah,=
 i use 4k.
>> >>
>> >> So I tested that patch, thank you, and some other different configura=
tions --
>> >> nothing helped. Exactly the same behaviour with the same backtrace.
>> >
>> > Did you test the first (4k check) or the second (don't remap on ARM) p=
atch?
>>
>> The second one. I think you mentioned that first one won't help for 4k p=
ages.
>>
>>
>> >> So it seems that it is firmware problem after all?
>> >
>> > There is no GPU firmware involved in this operation.  It's just a
>> > posted write.  E.g., we write to a register to flush the HDP write
>> > queue and then read the register back to make sure the write posted.
>> > If the second patch didn't help, then perhaps there is some issue with
>> > MMIO access on your platform?
>>
>> I didn't mean GPU firmware at all. I only had uefi/EL3 firmwares in mind=
.
>>
>> Completely out of the blue, based on nothing, do you think that
>> adding delay/some mem barrier between write and read might help?
>> I wonder if host data path code should be executed during common desktop
>> usage as a common user then why it doesn't break later. But yeah, I also
>> think this is this motherboard problem. Thank you.
>
> I think I found the problem.  The previous patch wasn't doing what I
> expected.  Please try this patch instead.

This one works!

[    4.483750] [drm] amdgpu kernel modesetting enabled.
[    4.491985] amdgpu: IO link not available for non x86 platforms
[    4.497189] amdgpu: Virtual CRAT table created for CPU
[    4.497559] amdgpu: Topology: Add CPU node
[    4.509623] amdgpu 0000:c3:00.0: amdgpu: detected ip block number 0 <nv_=
common>
[    4.512905] amdgpu 0000:c3:00.0: amdgpu: detected ip block number 1 <gmc=
_v10_0>
[    4.513254] amdgpu 0000:c3:00.0: amdgpu: detected ip block number 2 <nav=
i10_ih>
[    4.513595] amdgpu 0000:c3:00.0: amdgpu: detected ip block number 3 <psp=
>
[    4.513932] amdgpu 0000:c3:00.0: amdgpu: detected ip block number 4 <smu=
>
[    4.514278] amdgpu 0000:c3:00.0: amdgpu: detected ip block number 5 <dm>
[    4.514625] amdgpu 0000:c3:00.0: amdgpu: detected ip block number 6 <gfx=
_v10_0>
[    4.514980] amdgpu 0000:c3:00.0: amdgpu: detected ip block number 7 <sdm=
a_v5_2>
[    4.515334] amdgpu 0000:c3:00.0: amdgpu: detected ip block number 8 <vcn=
_v3_0>
[    4.515699] amdgpu 0000:c3:00.0: amdgpu: detected ip block number 9 <jpe=
g_v3_0>
[    4.516087] amdgpu 0000:c3:00.0: amdgpu: Fetched VBIOS from VFCT
[    4.516466] amdgpu: ATOM BIOS: 113-V502MECH-0OC
[    4.749748] amdgpu 0000:c3:00.0: amdgpu: Trusted Memory Zone (TMZ) featu=
re disabled as experimental (default)
[    4.777435] amdgpu 0000:c3:00.0: BAR 2 [mem 0x1810000000-0x18101fffff 64=
bit pref]: releasing
[    4.793256] amdgpu 0000:c3:00.0: BAR 0 [mem 0x1800000000-0x180fffffff 64=
bit pref]: releasing
[    4.844639] amdgpu 0000:c3:00.0: BAR 0 [mem 0x1800000000-0x19ffffffff 64=
bit pref]: assigned
[    4.849774] amdgpu 0000:c3:00.0: BAR 2 [mem 0x1a00000000-0x1a001fffff 64=
bit pref]: assigned
[    4.957411] amdgpu 0000:c3:00.0: amdgpu: VRAM: 8176M 0x0000008000000000 =
- 0x00000081FEFFFFFF (8176M used)
[    4.967618] amdgpu 0000:c3:00.0: amdgpu: GART: 512M 0x0000000000000000 -=
 0x000000001FFFFFFF
[    4.992963] [drm] amdgpu: 8176M of VRAM memory ready
[    5.004032] [drm] amdgpu: 7888M of GTT memory ready.
[    6.224159] amdgpu 0000:c3:00.0: amdgpu: STB initialized to 2048 entries
[    6.284328] amdgpu 0000:c3:00.0: amdgpu: Found VCN firmware Version ENC:=
 1.33 DEC: 4 VEP: 0 Revision: 3
[    6.361142] amdgpu 0000:c3:00.0: amdgpu: reserve 0xa00000 from 0x81fd000=
000 for PSP TMR
[    6.471231] amdgpu 0000:c3:00.0: amdgpu: RAS: optional ras ta ucode is n=
ot available
[    6.492967] amdgpu 0000:c3:00.0: amdgpu: SECUREDISPLAY: securedisplay ta=
 ucode is not available
[    6.492993] amdgpu 0000:c3:00.0: amdgpu: smu driver if version =3D 0x000=
0000f, smu fw if version =3D 0x00000013, smu fw program =3D 0, version =3D =
0x003b3100 (59.49.0)
[    6.513659] amdgpu 0000:c3:00.0: amdgpu: SMU driver if version not match=
ed
[    6.513699] amdgpu 0000:c3:00.0: amdgpu: use vbios provided pptable
[    6.588418] amdgpu 0000:c3:00.0: amdgpu: SMU is initialized successfully=
!
[    6.800975] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    6.806709] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[    6.813516] amdgpu: Virtual CRAT table created for GPU
[    6.819229] amdgpu: Topology: Add dGPU node [0x73ff:0x1002]
[    6.824865] kfd kfd: amdgpu: added device 1002:73ff
[    6.829821] amdgpu 0000:c3:00.0: amdgpu: SE 2, SH per SE 2, CU per SH 8,=
 active_cu_number 28
[    6.838355] amdgpu 0000:c3:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng =
0 on hub 0
[    6.846007] amdgpu 0000:c3:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng =
1 on hub 0
[    6.853658] amdgpu 0000:c3:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng=
 4 on hub 0
[    6.861398] amdgpu 0000:c3:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng=
 5 on hub 0
[    6.869137] amdgpu 0000:c3:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng=
 6 on hub 0
[    6.876877] amdgpu 0000:c3:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng=
 7 on hub 0
[    6.884615] amdgpu 0000:c3:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng=
 8 on hub 0
[    6.892356] amdgpu 0000:c3:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng=
 9 on hub 0
[    6.900094] amdgpu 0000:c3:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng=
 10 on hub 0
[    6.907921] amdgpu 0000:c3:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng=
 11 on hub 0
[    6.915748] amdgpu 0000:c3:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv en=
g 12 on hub 0
[    6.923663] amdgpu 0000:c3:00.0: amdgpu: ring sdma0 uses VM inv eng 13 o=
n hub 0
[    6.931050] amdgpu 0000:c3:00.0: amdgpu: ring sdma1 uses VM inv eng 14 o=
n hub 0
[    6.938439] amdgpu 0000:c3:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng =
0 on hub 8
[    6.946089] amdgpu 0000:c3:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv en=
g 1 on hub 8
[    6.953916] amdgpu 0000:c3:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv en=
g 4 on hub 8
[    6.961742] amdgpu 0000:c3:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5=
 on hub 8
[    6.970485] amdgpu 0000:c3:00.0: amdgpu: Using BACO for runtime pm
[    6.977167] [drm] Initialized amdgpu 3.63.0 for 0000:c3:00.0 on minor 0
[    7.234638] amdgpu 0000:c3:00.0: [drm] fb0: amdgpudrmfb frame buffer dev=
ice
root@orion:~ # uname -a
Linux orion 6.15.0-rc3test6+ #1 SMP Sun Apr 27 01:12:10 BST 2025 aarch64 GN=
U/Linux

Thank you for taking a look into this.

Best regards,
Alexey

