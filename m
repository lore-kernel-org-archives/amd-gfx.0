Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980CAC197A0
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Nov 2023 19:00:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BFB810E66C;
	Thu, 16 Nov 2023 19:00:06 +0000 (UTC)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8AFE10E66C
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 19:00:02 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1f4bbf525c7so558031fac.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 11:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700161202; x=1700766002; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6aoOsL8mFGT67qIVovQRB0RH/ANJLn13qJpuf8gq24U=;
 b=cAvsYK0Py55jUyB3SuKOfzhUT9cQGPmWgg6zwsqASSxtSRopaYc+SsQOcJJCNFe32n
 M88M6Zcew0sSLxq4FqeberCIQ9IA00JKeQEUA3HZRld4KrhUycM9LiXCecUq5EacPrQ/
 YWis6oFuDbYl2RSSWMO81ZKad3zWzbps/Yiic2saCJ/6Hn7CaBboG9VRvC09Qmz/xNkN
 /4pbjmumV3kovx+NqqFLA7t2laetAALVVUSoWf3Z1uv7cJBmsK3igsZ8opucYl86OXpT
 TMYlDCcaENh9R0bdSMoFZ/pENPU5jhKVkgLlG5fomuuABaBqsc9oSYZx0Gov0IYEBJEu
 Z8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700161202; x=1700766002;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6aoOsL8mFGT67qIVovQRB0RH/ANJLn13qJpuf8gq24U=;
 b=OWssdlbf/8vzsNu6YlxG4I+5LkVibvu1YxUeemXIiOmbm8ZBMuKoW01esVcHeA8417
 Vofob/deK2DduEhLs/UvGI4ez3JEVUKGSudle7njvJTQDz4KyLPyclCdHha8mWIjBTQa
 QGHSre+3x9lOAxMbYKVS49nB39WSdg5rmpyMnIC4qygNUdkY7C6guJ/30tqbiy6SyTj7
 Ei+mYFVU5ivnv821KPXpPVKqgqaZvwtYqEzty0khQOnCgejkbg2aESICwEU5V41usuLh
 /nCFMxMm1XC8Lx9Elu2HsaiYQhZAAsWWs4S61pXO+0vL4b+U1+OCRJFkbYU9HyLnFUxT
 NpTw==
X-Gm-Message-State: AOJu0YxXY6IsM/csMeGpjK3nBlGOLRdipDh5E40tByMXWsvFPMCjyMIH
 vz3o1INnf28qwxd28X+1z7AX/dyatahpOzFQDpKBRzSmPps=
X-Google-Smtp-Source: AGHT+IGIQD7WX57XH52ItISAN3u8K+UACXtlhkB1wrAj4mpFToyIJNCKhJFogLxmqGRzeA6yhaEWqb/P9G6uvCNGnF8=
X-Received: by 2002:a05:6870:5b97:b0:1ef:b0b6:7e14 with SMTP id
 em23-20020a0568705b9700b001efb0b67e14mr1409651oab.10.1700161201894; Thu, 16
 Nov 2023 11:00:01 -0800 (PST)
MIME-Version: 1.0
References: <ZVQ1n0DdLNvQHa3H@desktop>
In-Reply-To: <ZVQ1n0DdLNvQHa3H@desktop>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Nov 2023 13:59:51 -0500
Message-ID: <CADnq5_PKvuVJEy9Uq0z7eoo3RJwX2947wU5et_E=PQG7S-EoPg@mail.gmail.com>
Subject: Re: drm/amdgpu: dmesg errors on 6.7.0-rc1 with latest firmware
To: Jan Hendrik Farr <kernel@jfarr.cc>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 15, 2023 at 4:15=E2=80=AFAM Jan Hendrik Farr <kernel@jfarr.cc> =
wrote:
>
> Hi all,
>
> just took out 6.7.0-rc1 for a spin (including latest upstream linux-firmw=
are).
> GPU is an RX 7800 XT. I'm getting a constant flood of errors in dmesg.
>
> Otherwise I don't observe any out of place behavior on linux. However, wh=
en I
> reboot into Windows I get a low resolution display (I'm assuming the norm=
al
> AMD driver on Windows does not get loaded). Completely unplugging the PC
> from the wall fixes that issue until the next time I boot using 6.7.0-rc1
> and latest firmware.
>
> Haven't tested other scenarios yet (like latest firmware on kernel 6.6).

This patch should address the issue:
https://patchwork.freedesktop.org/patch/567101/
If you still see issues, you may also need this series:
https://patchwork.freedesktop.org/series/126220/

Alex

>
> Best Regards
> Jan
>
> Here is an excerpt from the errors (grepped dmesg for "amdgpu"):
>
> Nov 14 20:16:14 desktop kernel: [drm] amdgpu kernel modesetting enabled.
> Nov 14 20:16:14 desktop kernel: amdgpu: Virtual CRAT table created for CP=
U
> Nov 14 20:16:14 desktop kernel: amdgpu: Topology: Add CPU node
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: enabling device (000=
6 -> 0007)
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: Fetched VBIO=
S from VFCT
> Nov 14 20:16:14 desktop kernel: amdgpu: ATOM BIOS: 113-APM6767CL-100
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: CP RS64 enab=
le
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: [drm:jpeg_v4_0_early=
_init [amdgpu]] JPEG decode is enabled in VM mode
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: vgaarb: deactivate v=
ga console
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: Trusted Memo=
ry Zone (TMZ) feature not supported
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: MEM ECC is n=
ot presented.
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: SRAM ECC is =
not presented.
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: VRAM: 16368M=
 0x0000008000000000 - 0x00000083FEFFFFFF (16368M used)
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GART: 512M 0=
x00007FFF00000000 - 0x00007FFF1FFFFFFF
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: AGP: 1336606=
72M 0x0000008400000000 - 0x00007FFBFFFFFFFF
> Nov 14 20:16:14 desktop kernel: [drm] amdgpu: 16368M of VRAM memory ready
> Nov 14 20:16:14 desktop kernel: [drm] amdgpu: 32021M of GTT memory ready.
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: Will use PSP=
 to load VCN firmware
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: RAP: optiona=
l rap ta ucode is not available
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: SECUREDISPLA=
Y: securedisplay ta ucode is not available
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: smu driver i=
f version =3D 0x0000003d, smu fw if version =3D 0x0000003f, smu fw program =
=3D 0, smu fw version =3D 0x00503b00 (80.59.0)
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: SMU driver i=
f version not matched
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: SMU is initi=
alized successfully!
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: [drm:jpeg_v4_0_hw_in=
it [amdgpu]] JPEG decode initialized successfully.
> Nov 14 20:16:14 desktop kernel: amdgpu: HMM registered 16368MB device mem=
ory
> Nov 14 20:16:14 desktop kernel: kfd kfd: amdgpu: Allocated 3969056 bytes =
on gart
> Nov 14 20:16:14 desktop kernel: kfd kfd: amdgpu: Total number of KFD node=
s to be created: 1
> Nov 14 20:16:14 desktop kernel: amdgpu: Virtual CRAT table created for GP=
U
> Nov 14 20:16:14 desktop kernel: amdgpu: Topology: Add dGPU node [0x747e:0=
x1002]
> Nov 14 20:16:14 desktop kernel: kfd kfd: amdgpu: added device 1002:747e
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: SE 3, SH per=
 SE 2, CU per SH 10, active_cu_number 60
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0=
.0 uses VM inv eng 0 on hub 0
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.=
0.0 uses VM inv eng 1 on hub 0
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.=
1.0 uses VM inv eng 4 on hub 0
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.=
2.0 uses VM inv eng 6 on hub 0
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.=
3.0 uses VM inv eng 7 on hub 0
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.=
0.1 uses VM inv eng 8 on hub 0
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.=
1.1 uses VM inv eng 9 on hub 0
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.=
2.1 uses VM inv eng 10 on hub 0
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.=
3.1 uses VM inv eng 11 on hub 0
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring sdma0 u=
ses VM inv eng 12 on hub 0
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring sdma1 u=
ses VM inv eng 13 on hub 0
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring vcn_uni=
fied_0 uses VM inv eng 0 on hub 8
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring vcn_uni=
fied_1 uses VM inv eng 1 on hub 8
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring jpeg_de=
c uses VM inv eng 4 on hub 8
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: ring mes_kiq=
_3.1.0 uses VM inv eng 14 on hub 0
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: Using BACO f=
or runtime pm
> Nov 14 20:16:14 desktop kernel: [drm] Initialized amdgpu 3.56.0 20150101 =
for 0000:03:00.0 on minor 1
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] pag=
e fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0=
)
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page st=
arting at address 0x000080840f902000 from client 10
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROT=
ECTION_FAULT_STATUS:0x00041B52
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Fau=
lty UTCL2 client ID: SDMA0 (0xd)
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MOR=
E_FAULTS: 0x0
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WAL=
KER_ERROR: 0x1
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PER=
MISSION_FAULTS: 0x5
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAP=
PING_ERROR: 0x1
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW:=
 0x1
> Nov 14 20:16:14 desktop kernel: fbcon: amdgpudrmfb (fb0) is primary devic=
e
> Nov 14 20:16:14 desktop kernel: amdgpu 0000:03:00.0: [drm] fb0: amdgpudrm=
fb frame buffer device
> Nov 14 20:16:15 desktop kernel: snd_hda_intel 0000:03:00.1: bound 0000:03=
:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] pag=
e fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0=
)
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page st=
arting at address 0x0000808448f4c000 from client 10
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROT=
ECTION_FAULT_STATUS:0x00041D52
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Fau=
lty UTCL2 client ID: SDMA1 (0xe)
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MOR=
E_FAULTS: 0x0
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WAL=
KER_ERROR: 0x1
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PER=
MISSION_FAULTS: 0x5
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAP=
PING_ERROR: 0x1
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW:=
 0x1
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] pag=
e fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0=
)
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page st=
arting at address 0x0000808459afd000 from client 10
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROT=
ECTION_FAULT_STATUS:0x00041D52
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Fau=
lty UTCL2 client ID: SDMA1 (0xe)
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MOR=
E_FAULTS: 0x0
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WAL=
KER_ERROR: 0x1
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PER=
MISSION_FAULTS: 0x5
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAP=
PING_ERROR: 0x1
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW:=
 0x1
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] pag=
e fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0=
)
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page st=
arting at address 0x0000808459afb000 from client 10
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROT=
ECTION_FAULT_STATUS:0x00041D52
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Fau=
lty UTCL2 client ID: SDMA1 (0xe)
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MOR=
E_FAULTS: 0x0
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WAL=
KER_ERROR: 0x1
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PER=
MISSION_FAULTS: 0x5
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAP=
PING_ERROR: 0x1
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW:=
 0x1
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] pag=
e fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0=
)
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page st=
arting at address 0x0000808459afa000 from client 10
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROT=
ECTION_FAULT_STATUS:0x00041D53
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Fau=
lty UTCL2 client ID: SDMA1 (0xe)
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MOR=
E_FAULTS: 0x1
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WAL=
KER_ERROR: 0x1
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PER=
MISSION_FAULTS: 0x5
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAP=
PING_ERROR: 0x1
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW:=
 0x1
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] pag=
e fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0=
)
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page st=
arting at address 0x0000808459afb000 from client 10
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROT=
ECTION_FAULT_STATUS:0x00041D53
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Fau=
lty UTCL2 client ID: SDMA1 (0xe)
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MOR=
E_FAULTS: 0x1
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WAL=
KER_ERROR: 0x1
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PER=
MISSION_FAULTS: 0x5
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAP=
PING_ERROR: 0x1
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW:=
 0x1
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] pag=
e fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0=
)
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page st=
arting at address 0x0000808459afa000 from client 10
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROT=
ECTION_FAULT_STATUS:0x00041D53
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Fau=
lty UTCL2 client ID: SDMA1 (0xe)
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MOR=
E_FAULTS: 0x1
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WAL=
KER_ERROR: 0x1
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PER=
MISSION_FAULTS: 0x5
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAP=
PING_ERROR: 0x1
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW:=
 0x1
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] pag=
e fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0=
)
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page st=
arting at address 0x0000808459afb000 from client 10
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROT=
ECTION_FAULT_STATUS:0x00000000
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Fau=
lty UTCL2 client ID: CB/DB (0x0)
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MOR=
E_FAULTS: 0x0
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WAL=
KER_ERROR: 0x0
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PER=
MISSION_FAULTS: 0x0
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAP=
PING_ERROR: 0x0
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW:=
 0x0
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] pag=
e fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0=
)
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page st=
arting at address 0x0000808459afd000 from client 10
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROT=
ECTION_FAULT_STATUS:0x00041D53
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Fau=
lty UTCL2 client ID: SDMA1 (0xe)
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MOR=
E_FAULTS: 0x1
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WAL=
KER_ERROR: 0x1
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PER=
MISSION_FAULTS: 0x5
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAP=
PING_ERROR: 0x1
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW:=
 0x1
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] pag=
e fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0=
)
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page st=
arting at address 0x0000808448f4c000 from client 10
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROT=
ECTION_FAULT_STATUS:0x00000000
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Fau=
lty UTCL2 client ID: CB/DB (0x0)
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MOR=
E_FAULTS: 0x0
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WAL=
KER_ERROR: 0x0
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PER=
MISSION_FAULTS: 0x0
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAP=
PING_ERROR: 0x0
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW:=
 0x0
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] pag=
e fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0=
)
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page st=
arting at address 0x0000808459afb000 from client 10
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROT=
ECTION_FAULT_STATUS:0x00000000
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Fau=
lty UTCL2 client ID: CB/DB (0x0)
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MOR=
E_FAULTS: 0x0
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WAL=
KER_ERROR: 0x0
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PER=
MISSION_FAULTS: 0x0
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAP=
PING_ERROR: 0x0
> Nov 14 20:16:20 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW:=
 0x0
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] pag=
e fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0=
)
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page st=
arting at address 0x0000808459e53000 from client 10
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROT=
ECTION_FAULT_STATUS:0x00041B52
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Fau=
lty UTCL2 client ID: SDMA0 (0xd)
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MOR=
E_FAULTS: 0x0
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WAL=
KER_ERROR: 0x1
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PER=
MISSION_FAULTS: 0x5
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAP=
PING_ERROR: 0x1
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW:=
 0x1
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] pag=
e fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0=
)
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page st=
arting at address 0x0000808459e46000 from client 10
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROT=
ECTION_FAULT_STATUS:0x00041B52
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Fau=
lty UTCL2 client ID: SDMA0 (0xd)
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MOR=
E_FAULTS: 0x0
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WAL=
KER_ERROR: 0x1
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PER=
MISSION_FAULTS: 0x5
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAP=
PING_ERROR: 0x1
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW:=
 0x1
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] pag=
e fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0=
)
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page st=
arting at address 0x0000808459e52000 from client 10
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROT=
ECTION_FAULT_STATUS:0x00041B52
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Fau=
lty UTCL2 client ID: SDMA0 (0xd)
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MOR=
E_FAULTS: 0x0
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WAL=
KER_ERROR: 0x1
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PER=
MISSION_FAULTS: 0x5
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAP=
PING_ERROR: 0x1
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW:=
 0x1
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] pag=
e fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0=
)
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page st=
arting at address 0x0000808459e46000 from client 10
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROT=
ECTION_FAULT_STATUS:0x00041B53
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Fau=
lty UTCL2 client ID: SDMA0 (0xd)
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MOR=
E_FAULTS: 0x1
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WAL=
KER_ERROR: 0x1
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PER=
MISSION_FAULTS: 0x5
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAP=
PING_ERROR: 0x1
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW:=
 0x1
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] pag=
e fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0=
)
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page st=
arting at address 0x0000808459e52000 from client 10
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROT=
ECTION_FAULT_STATUS:0x00000000
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Fau=
lty UTCL2 client ID: CB/DB (0x0)
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MOR=
E_FAULTS: 0x0
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WAL=
KER_ERROR: 0x0
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PER=
MISSION_FAULTS: 0x0
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAP=
PING_ERROR: 0x0
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW:=
 0x0
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] pag=
e fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0=
)
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page st=
arting at address 0x0000808459e46000 from client 10
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROT=
ECTION_FAULT_STATUS:0x00041B53
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Fau=
lty UTCL2 client ID: SDMA0 (0xd)
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MOR=
E_FAULTS: 0x1
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WAL=
KER_ERROR: 0x1
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PER=
MISSION_FAULTS: 0x5
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAP=
PING_ERROR: 0x1
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW:=
 0x1
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] pag=
e fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0=
)
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page st=
arting at address 0x0000808459e53000 from client 10
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROT=
ECTION_FAULT_STATUS:0x00000000
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Fau=
lty UTCL2 client ID: CB/DB (0x0)
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MOR=
E_FAULTS: 0x0
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WAL=
KER_ERROR: 0x0
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PER=
MISSION_FAULTS: 0x0
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAP=
PING_ERROR: 0x0
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW:=
 0x0
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] pag=
e fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0=
)
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page st=
arting at address 0x0000808459852000 from client 10
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROT=
ECTION_FAULT_STATUS:0x00000000
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Fau=
lty UTCL2 client ID: CB/DB (0x0)
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MOR=
E_FAULTS: 0x0
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WAL=
KER_ERROR: 0x0
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PER=
MISSION_FAULTS: 0x0
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAP=
PING_ERROR: 0x0
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW:=
 0x0
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] pag=
e fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0=
)
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page st=
arting at address 0x0000808459e46000 from client 10
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROT=
ECTION_FAULT_STATUS:0x00000000
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Fau=
lty UTCL2 client ID: CB/DB (0x0)
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MOR=
E_FAULTS: 0x0
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WAL=
KER_ERROR: 0x0
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PER=
MISSION_FAULTS: 0x0
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAP=
PING_ERROR: 0x0
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW:=
 0x0
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: [gfxhub] pag=
e fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0=
)
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:   in page st=
arting at address 0x0000808459e51000 from client 10
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROT=
ECTION_FAULT_STATUS:0x00041B52
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          Fau=
lty UTCL2 client ID: SDMA0 (0xd)
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MOR=
E_FAULTS: 0x0
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          WAL=
KER_ERROR: 0x1
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          PER=
MISSION_FAULTS: 0x5
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          MAP=
PING_ERROR: 0x1
> Nov 14 20:16:25 desktop kernel: amdgpu 0000:03:00.0: amdgpu:          RW:=
 0x1
>
>
> [...]
>
>
