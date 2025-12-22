Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCBAE677EA
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Dec 2025 15:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60F8110E6D2;
	Mon, 22 Dec 2025 15:36:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LsIVR0+6";
	dkim-atps=neutral
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com
 [209.85.160.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFCA910E6D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 15:36:12 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-3f4f9ea26aaso2898935fac.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 07:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766417772; x=1767022572; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bUW9kyl0lWn9jWiKI9kR2IeOQGIc/YBytYjJ9fOXHYs=;
 b=LsIVR0+6wbc89xaRjmCZgucSZm5FS6sA9J2/cIn958w+s+7geAN/nodQDvm4pSgdo/
 DSB1ojoEcdhSQFK1b9l1t6EPqwKkLDQX5HuiwKfd73+HqooOgMpMzWGwZMLzZIkvHgnC
 qN6b6wE1D5/tbY5foSYri61AFZlv/V1ymcPIbGpOI4TkxjcsXs/iNR5dXm0cEUdErL0r
 Dg1XYkHcaXh1Nenj/fG5oI8QSrHt/jJMSGeAXH3Qr0+EMN2H1r/2G5fsYxb0hcIjBCz7
 yje7PMZ0T3JnP7Fpnt2vwiNK1zujC9ZXiAxpLefg0cuRbu5x6RvU006hE84vzUj8itSy
 ZGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766417772; x=1767022572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bUW9kyl0lWn9jWiKI9kR2IeOQGIc/YBytYjJ9fOXHYs=;
 b=Q8CdzV7HaJO22mTy67+OIU3jpsQlsSHEs61mfj+Qpy9mOImGfRRBHvDOc5j7VBw+jt
 kpaVw/+bwBvh5VbyBKjWpcsGMnBrdBMvrTrgMcUwKclU9JcafubpE7ExyUoZrBPUQtj8
 3Ld4QfpREVW6OQoI1yHmGSRbCiEWDA2FTy7HAkEbSFv3Ag2T+xFoaD/pvThvv3Kgnaq9
 nPuTa6Nv/RdZEcciiwyBYyWu4FDg6kcRIBNvs85u3xEfC55EEn3tOSzYBZ0+M1QfpKfy
 nXRNCJY8v+SCUdgeDYW/EbS1lCi1FV/nRZnH54EQDeLvSXS2eY45R2Cv/0WWIQ5SQsv7
 Ae1A==
X-Gm-Message-State: AOJu0YyPq60/wAZOl7lBW/uXQ++4fGp2fbVyD2wI7B9/C6EKXOriclfC
 CftMV752SuyMu3UfJ9U3qV0H+Pm87SEvbXA4+QHRnDBNSAeOlxmtK71wcOHtervacEc=
X-Gm-Gg: AY/fxX4DQygQY/KynPPLFDx6JyTd2C2m65w0w2RLf7kv/qS6Dh8DhfH+Cd9qZYfX+g3
 Zz19TAOoY/tZHXeBAa2o29onwbYiw0gPvZDTdwZpsUzjqcKJJTiA3tkpGZKbuNWhbM/1e9Hz44A
 3pZk8c1mT0sDGNGhJuy0JO6Js5/jzt65J0gzvDQzun6pBgUFs0govXgr5cZ//GcIbWz+3ImJaQl
 dxpwy7ZRslMHJ255lU1DqCSwFvPIdwrgaAUrH9K0ZpqFomN1JkAInUQIpUeOh90XFjf8fWByyKU
 GKjxQTOfumF4r83G+IzNxjLaurr8rR8DEyUVyWjTb3TACDCWl9XvzMmR7QiTQ5ejUB2Gr0ljZi+
 pxyJQCFEg00eXE++7rXfcPSX1R3ui7xsbWD6PfyzZ8VbKFOz39s+4C+fsa0gCIPGlOK/aPPRudo
 ipozWmZZCQny3Flhs4KP9QOVxI47s=
X-Google-Smtp-Source: AGHT+IGPKjteZ7rF82xcyK+pXZ0EoAE6+Kf9ddYMSS9SZfLnZeq8ECpjXMeP2FavbT2o/fZYxKrQnQ==
X-Received: by 2002:a05:6871:2b28:b0:3ec:57f7:fa5a with SMTP id
 586e51a60fabf-3fda570982bmr5947301fac.50.1766417771555; 
 Mon, 22 Dec 2025 07:36:11 -0800 (PST)
Received: from timur-max.localnet ([189.171.135.243])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa8d3585sm6929993fac.2.2025.12.22.07.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 07:36:11 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: amdgpu: [drm] AMDGPU device coredump file has been created
Date: Mon, 22 Dec 2025 09:36:09 -0600
Message-ID: <2575679.XAFRqVoOGU@timur-max>
In-Reply-To: <aUjiv4TnoVJ9LysI@glanzmann.de>
References: <aUjiv4TnoVJ9LysI@glanzmann.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2025. december 22., h=C3=A9tf=C5=91 0:18:39 Thomas Glanzmann wrote:
> Hello,
> I have a PC which worked fine for many years that I did not use for half
> a year. Yesterday I want to use it, but sway appears to be crashing
> amdgpu in DRM. The components are:
>=20
> - ASUS System Product Name/TUF GAMING B650M-PLUS
> - AMD Ryzen 9 7950X 16-Core Processor
> - Debian trixie

Hi Thomas,

Which GPU do you have? Are you using the iGPU from the 7950X?
Also for these kind of issues it would be nice to mention details such as:
=2D Kernel version, Mesa version, amdgpu firmware version
=2D Does the crash still happen on a recent kernel?

I suggest to open an issue in the drm/amd bug tracker with all those detail=
s:
https://gitlab.freedesktop.org/drm/amd/-/issues

>=20
> I already tried the following:
>=20
>         - Upgrading to Debian forky
>         - Debian trixie live cd
>         - Installing the latested amd gpu firmware
> 	- Updating the Bios to the latest.
>=20
> In order to reproduce the issue, I boot linux, start sway and open an
> alacritty terminal with a tmux inside. amdgpu crashes immediatly. Find
> here a video and the full dmesg.

Unfortunately, the dmesg log is not actionable. It shows that there was a G=
PU=20
hang, but there is no indication of what was happening. It does show that=20
there was a successful GPU recovery though. Does your system stay usable=20
afterwards? The devcoredump is also not actionable because it has no detail=
s=20
about what was happening on the GPU as it was crashing.

If you know that the system used to work well beforehand, the best would be=
 to=20
tell us which kernel version used to work, which is the first version that=
=20
broke and bisect from there.

>=20
> https://tg.st/u/dmesg_9f62587406fb808dc4d91d41029ccf88ceeadf13e1f91d65c27=
b57
> 536f375550.txt
> https://tg.st/u/amdgpu_device_coredump_data_a25f2060c56260bb46ac95ee31239=
69
> d5127bf31b29ea3adfe3feeac67bf4edc.zst
> https://tg.st/u/VID_20251222_071051104.mp4
>=20
> [   57.342777] amdgpu 0000:0b:00.0: amdgpu: Dumping IP State
> [   57.343822] amdgpu 0000:0b:00.0: amdgpu: Dumping IP State Completed
> [   57.343869] amdgpu 0000:0b:00.0: amdgpu: [drm] AMDGPU device coredump
> file has been created [   57.343871] amdgpu 0000:0b:00.0: amdgpu: [drm]
> Check your /sys/class/drm/card0/device/devcoredump/data [   57.343872]
> amdgpu 0000:0b:00.0: amdgpu: ring gfx_0.0.0 timeout, signaled seq=3D106,
> emitted seq=3D108 [   57.343873] amdgpu 0000:0b:00.0: amdgpu:  Process sw=
ay
> pid 2021 thread sway:cs0 pid 2317 [   57.343875] amdgpu 0000:0b:00.0:
> amdgpu: Starting gfx_0.0.0 ring reset [   57.485168] amdgpu 0000:0b:00.0:
> amdgpu: Ring gfx_0.0.0 reset failed [   57.485170] amdgpu 0000:0b:00.0:
> amdgpu: GPU reset begin!
> [   57.609921] amdgpu 0000:0b:00.0: amdgpu: MODE2 reset
> [   57.616920] amdgpu 0000:0b:00.0: amdgpu: GPU reset succeeded, trying to
> resume [   57.617008] [drm] PCIE GART of 1024M enabled (table at
> 0x000000F41FC00000). [   57.617024] amdgpu 0000:0b:00.0: amdgpu: PSP is
> resuming...
> [   57.638326] amdgpu 0000:0b:00.0: amdgpu: reserve 0xa00000 from
> 0xf41e000000 for PSP TMR [   57.832236] amdgpu 0000:0b:00.0: amdgpu: RAS:
> optional ras ta ucode is not available [   57.837959] amdgpu 0000:0b:00.0:
> amdgpu: RAP: optional rap ta ucode is not available [   57.837961] amdgpu
> 0000:0b:00.0: amdgpu: SECUREDISPLAY: optional securedisplay ta ucode is n=
ot
> available [   57.837963] amdgpu 0000:0b:00.0: amdgpu: SMU is resuming...
> [   57.838869] amdgpu 0000:0b:00.0: amdgpu: SMU is resumed successfully!
> [   57.839132] amdgpu 0000:0b:00.0: amdgpu: kiq ring mec 2 pipe 1 q 0
> [   57.842333] amdgpu 0000:0b:00.0: amdgpu: [drm] DMUB hardware initializ=
ed:
> version=3D0x05002C00 [   57.944932] amdgpu 0000:0b:00.0: amdgpu: ring
> gfx_0.0.0 uses VM inv eng 0 on hub 0 [   57.944935] amdgpu 0000:0b:00.0:
> amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on hub 0 [   57.944936] amdgpu
> 0000:0b:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 4 on hub 0 [ =20
> 57.944937] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 5
> on hub 0 [   57.944938] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.2.0 uses
> VM inv eng 6 on hub 0 [   57.944938] amdgpu 0000:0b:00.0: amdgpu: ring
> comp_1.3.0 uses VM inv eng 7 on hub 0 [   57.944939] amdgpu 0000:0b:00.0:
> amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0 [   57.944939] amdgpu
> 0000:0b:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0 [ =20
> 57.944940] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10
> on hub 0 [   57.944940] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.3.1 uses
> VM inv eng 11 on hub 0 [   57.944941] amdgpu 0000:0b:00.0: amdgpu: ring
> kiq_0.2.1.0 uses VM inv eng 12 on hub 0 [   57.944941] amdgpu 0000:0b:00.=
0:
> amdgpu: ring sdma0 uses VM inv eng 13 on hub 0 [   57.944942] amdgpu
> 0000:0b:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on hub 8 [ =20
> 57.944943] amdgpu 0000:0b:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1
> on hub 8 [   57.944943] amdgpu 0000:0b:00.0: amdgpu: ring vcn_enc_0.1 uses
> VM inv eng 4 on hub 8 [   57.944944] amdgpu 0000:0b:00.0: amdgpu: ring
> jpeg_dec uses VM inv eng 5 on hub 8 [   57.948092] amdgpu 0000:0b:00.0:
> amdgpu: GPU reset(1) succeeded! [   57.948107] amdgpu 0000:0b:00.0: [drm]
> device wedged, but recovered through reset [   57.961832]
> [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
>=20
> I'm grateful for any pointers that resolve the issue and available for
> debugging.
>=20
> Cheers,
>         Thomas




