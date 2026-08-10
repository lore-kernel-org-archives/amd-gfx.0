Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70649C5CFC1
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 12:05:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F7CA10EB48;
	Tue, 11 Aug 2026 12:05:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=spasswolf@web.de header.b="O8tL8q4r";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 015DF10E246
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 18:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1786385313; x=1786990113; i=spasswolf@web.de;
 bh=QYc+eF6/YnZt2VFVNOIwgjAZT9Yt1fgTfonhQovMzs0=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=O8tL8q4ranKHXQGRBDkW2153uX6AtJyfQXv9rkEvRwUq53HDa6kMmofKM3HCkRSK
 +k4EB5yXOiZJgHHzDo0QkpyXuTVwruDm9gkTeRSAUbbYnpHN8g7l0GyUHRyqvss9O
 crQnNHDorFWQNvHMhLhOzmUEJcBLc7dGNpMDvOWldGfgWt0DfM8dfqNW1kPLpYdLw
 3JE0KppeKBNPwsCBlvo9lRxtNblvwWAdqDBmT6/4QWehLrD3Iwj4VBhRn9m/nLPR+
 HkfYa+NDijiPBOggG/4dLBMhdvnF6Z3shpp1p8+WItFCTIFCbY/cwE8od1dWKOu2Q
 DEfK40FATgDsmW183Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIL4K-1whPbJ2pUq-007NlK; Mon, 10
 Aug 2026 20:08:33 +0200
Message-ID: <014e423f0ef7c8e7c4c3f208ec6c632c796b80a1.camel@web.de>
Subject: Re: [Re] GPU reset when running the ROCm hsa runtime tests on gfx12
 and next-20260701
From: Bert Karwatzki <spasswolf@web.de>
To: Alex Deucher <alexdeucher@gmail.com>, "Zhang, Jesse(Jie)"
 <Jesse.Zhang@amd.com>, Shaoyun Liu <Shaoyun.Liu@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, linux-next@vger.kernel.org, Amber Lin
 <Amber.Lin@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
 spasswolf@web.de
Date: Mon, 10 Aug 2026 20:08:31 +0200
In-Reply-To: <5b571b7ce1c81d3757061a4378db0ced65a86b58.camel@web.de>
References: <20260705003504.31425-1-spasswolf@web.de>
 <e3b04980fd0bc7a6c3edfcd089e8fb4c559bbf38.camel@web.de>
 <b5f93060955a72a358bf82406eda866f2c5cde56.camel@web.de>
 <CADnq5_Onn1+x_amugN5nBGNHdjM0bKBYr8LLQ_fRWxTNPbaJWQ@mail.gmail.com>
 <5b571b7ce1c81d3757061a4378db0ced65a86b58.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10+b1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4yS5AfOhBBE95NhWAmoXoiJTQmCP/zycCxmWDWyBtX0PbBDLF6W
 3UR+j3KJy8p/QQkvVcnKJZXa9DS2eyKoFKJGdJHrmdt81vkuVUsmV0qQf6uGuzvTzBG+Xxb
 FP/TzceCVJh3tQuX8EF72jFykoGUOqr9qb8tnI9hPRgMafghBaqx31uwLFKBKQhAb4xNpkC
 SUMIMc9gXuJlqFOWi4+Kw==
UI-OutboundReport: notjunk:1;M01:P0:+HFxhJ6jx8M=;RAXKoxkXEL0ywXWY8KG5I9OR/IS
 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
X-Mailman-Approved-At: Tue, 11 Aug 2026 12:05:18 +0000
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

Am Montag, dem 10.08.2026 um 18:24 +0200 schrieb Bert Karwatzki:
> Am Montag, dem 10.08.2026 um 10:15 -0400 schrieb Alex Deucher:
> > @Amber Lin
> > , @Zhang, Jesse(Jie), @Shaoyun Liu  Can you take a look at the firmwar=
e version?
> >=20
> > Alex
> >=20
>=20
> These are the firmware version reported in sysfs:
>=20
> # find /sys/class/drm/card0/device/fw_version/ -print -type f -exec cat =
{} \;
> /sys/class/drm/card0/device/fw_version/
> /sys/class/drm/card0/device/fw_version/pfp_fw_version
> 0x00000c12
> /sys/class/drm/card0/device/fw_version/vcn_fw_version
> 0x0910c01a
> /sys/class/drm/card0/device/fw_version/mec_fw_version
> 0x00000d0c
> /sys/class/drm/card0/device/fw_version/mes_fw_version
> 0x0000008b
> /sys/class/drm/card0/device/fw_version/dmcub_fw_version
> 0x0a000c00
> /sys/class/drm/card0/device/fw_version/me_fw_version
> 0x00000bc2
> /sys/class/drm/card0/device/fw_version/asd_fw_version
> 0x21000110
> /sys/class/drm/card0/device/fw_version/sdma2_fw_version
> 0x00798e96
> /sys/class/drm/card0/device/fw_version/sdma_fw_version
> 0x00798e96
> /sys/class/drm/card0/device/fw_version/smc_fw_version
> 0x00664600
> /sys/class/drm/card0/device/fw_version/sos_fw_version
> 0x003b0f0d
> /sys/class/drm/card0/device/fw_version/imu_fw_version
> 0x0c2c2500
> /sys/class/drm/card0/device/fw_version/rlc_fw_version
> 0x00bde160
> /sys/class/drm/card0/device/fw_version/mes_kiq_fw_version
> 0x0000008b
>=20
> In addition dmesg reports a problem with the mes version:
>=20
> [    4.353074] [    T489] amdgpu 0000:03:00.0: MES firmware reports inco=
rrect version in ucode binary (0x1 vs 0x8b)
>=20
> Both these result use the firmware package shipped by debian sid:
> ii  firmware-amd-graphics         20260622-1      all     Binary firmwar=
e for AMD/ATI graphics and NPU chips
>=20
> The earlier result of mes_sched =3D 0x76 is probably from the old firmwa=
re (debian stable version 20250410), but
> the gpu resets also occur with the new firmware from debian sid.
>=20
> Bert Karwatzki

I just tried the amdgpu firmware from the master branch of
https://gitlab.com/kernel-firmware/linux-firmware
and the result is the same (i.e. same firmware versions, same gpu reset).

At least the mes firmware binaries are identical:

bert@homer:/lib/firmware/amdgpu$ ls | grep gc_12 | grep mes | xargs md5sum
e50b66d9d8cae78ddf76ea27cca5a051  gc_12_0_0_mes1.bin
ed07c8a5a307bc882d42fe89441d1da9  gc_12_0_0_mes.bin
3284fd6f8269d020190d5e11075bbf6a  gc_12_0_0_uni_mes.bin
99c60afc75c11cb47007c40db29121d3  gc_12_0_1_mes1.bin
c1c9b01f5dd171906e7beefca32ebb9a  gc_12_0_1_mes.bin
3284fd6f8269d020190d5e11075bbf6a  gc_12_0_1_uni_mes.bin

This is the backed up firmware from  debian:
bert@homer:/lib/firmware/amdgpu.debian$ ls | grep gc_12 | grep mes | xargs=
 md5sum
e50b66d9d8cae78ddf76ea27cca5a051  gc_12_0_0_mes1.bin
ed07c8a5a307bc882d42fe89441d1da9  gc_12_0_0_mes.bin
3284fd6f8269d020190d5e11075bbf6a  gc_12_0_0_uni_mes.bin
99c60afc75c11cb47007c40db29121d3  gc_12_0_1_mes1.bin
c1c9b01f5dd171906e7beefca32ebb9a  gc_12_0_1_mes.bin
3284fd6f8269d020190d5e11075bbf6a  gc_12_0_1_uni_mes.bin


Bert Karwatzki
