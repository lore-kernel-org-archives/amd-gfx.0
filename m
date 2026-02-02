Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F59E83063
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 08:16:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 686C710E584;
	Tue,  3 Feb 2026 08:16:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=spasswolf@web.de header.b="a/t9msPn";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A22E310E523
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 16:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770050612; x=1770655412; i=spasswolf@web.de;
 bh=ENTp8VHg33h9pNxYKf9XDLYo/AKVopqbK/7amWnv09E=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=a/t9msPn0wIFGjtxq2NMNAllmfRR94uPYSZV4SQVi9tdt7B/D0TQJV7tT2tDLIE5
 lLOf7s8bXASw9KiFAkdqkY6iqK04D4njQcXirw8LLPAksRdeQ5SgacYIjoOImhAgY
 khQ9i9hGEmf7rW4pUHPERFr53Bbhh2iaw7AcYtUCBhXP42j5c5xJ8d85VOYfOEINu
 JNYi/ofYMnAmOWNgE2jxnjeayUI2tgWG7+IHc5+Ggbf3Eh8rh42tntsVKplsyc4LJ
 BDBNLsoOmhlJPn8Wder1dSr6XhVsrlgh2fPKL5TlQ0zv2FZIUURc0VklX5hwkyno5
 W3LFs7qgVcISFOiPTw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3m59-1vnmMx1MRf-00FDjO; Mon, 02
 Feb 2026 17:43:32 +0100
Message-ID: <15517fd926161aee77b4df2ffa8bab4bd08eab9a.camel@web.de>
Subject: Re: [PATCH] Revert "drm/amd: Check if ASPM is enabled from PCIe
 subsystem"
From: Bert Karwatzki <spasswolf@web.de>
To: Mario Limonciello <superm1@kernel.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, amd-gfx@lists.freedesktop.org, Alex Deucher
 <alexander.deucher@amd.com>, spasswolf@web.de
Date: Mon, 02 Feb 2026 17:43:31 +0100
In-Reply-To: <2a3a3d4f-efa2-46e5-8fee-f51cf12812a9@kernel.org>
References: <20260201002446.1293486-1-spasswolf@web.de>
 <02fe7f9e-f25b-4b6b-8420-57de982147bd@kernel.org>
 <b978d83d-3bd2-4ef0-8a2c-eb756a880fa4@amd.com>
 <2a3a3d4f-efa2-46e5-8fee-f51cf12812a9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ELMzLWC9PMm6/EueKpEGN48lvtDj/NLre9vVu8514K8ptzZiRpL
 v8zgQQBVHrgJbLzzoqPEgjK8MS5zDGJqmBqpzh29K/rusd+XJoNzdNvCJ7AESoablcYGnGI
 CwE26zqFmL0UAzN2OhnoECbjd2nHygwnGilYkIf1EtBL63T4aYnwy2d+dRraav21Q02E49W
 E9mCiXg96S8L2amo1jSkw==
UI-OutboundReport: notjunk:1;M01:P0:FIhk1fMje0M=;TvPDCBVTL7haW7pbmotNX14LQ5K
 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
X-Mailman-Approved-At: Tue, 03 Feb 2026 08:16:06 +0000
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

Am Montag, dem 02.02.2026 um 10:11 -0600 schrieb Mario Limonciello:
> On 2/2/26 8:35 AM, Christian K=C3=B6nig wrote:
> > On 2/2/26 15:25, Mario Limonciello wrote:
> > > On 1/31/26 6:24 PM, Bert Karwatzki wrote:
> > > > This reverts commit 7294863a6f01248d72b61d38478978d638641bee.
> > > >=20
> > > > This commit was erroneously applied again after commit 0ab5d711ec7=
4
> > > > ("drm/amd: Refactor `amdgpu_aspm` to be evaluated per device")
> > > > removed it, leading to very hard to debug crashes, when used with =
a system with two
> > > > AMD GPUs of which only one supports ASPM.
> > > >=20
> > > > Link: https://lore.kernel.org/linux-acpi/20251006120944.7880-1-spa=
sswolf@web.de/
> > > > Link: https://github.com/acpica/acpica/issues/1060
> > > > Fixes: 0ab5d711ec74 ("drm/amd: Refactor `amdgpu_aspm` to be evalua=
ted per device")
> > > >=20
> > > > Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> > > > ---
> > >=20
> > > Amazing detective work, thanks so much.
> > >=20
> > > This added the code initially:
> > > cba07cce39ace drm/amd: Check if ASPM is enabled from PCIe subsystem
> > >=20
> > > This effectively removed it:
> > > 0ab5d711ec74d drm/amd: Refactor `amdgpu_aspm` to be evaluated per de=
vice
> > >=20
> > > This was the accidental re-apply:
> > > 7294863a6f012 drm/amd: Check if ASPM is enabled from PCIe subsystem
> > >=20
> > > It looks like this as right on the edge of the 5.17-rc6 and 5.18-rc1=
.
> > > I think drm-fixes-2022-02-25 and amd-drm-next-5.18-2022-02-25 ended =
up with different content.
> > >=20
> > > Nonethless this is the correct change and I've applied it to amd-sta=
ging-drm-next.
> > >=20
> > > Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> >=20
> > Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >=20
> > There is just one major question left: Why is disabling ASPM causing p=
roblems?
> >=20
>=20
> My theory is that it's a mismatch of PCIe core and AMDGPU.  IE if the=20
> PCIe core thinks it's enabled but amdgpu thinks it is disabled can hit=
=20
> some corner scenarios.

That's also my theory. In my case the discrete GPU is probed first

[    1.652505] [    T194] amdgpu 0000:03:00.0: enabling device (0000 -> 00=
02)
[    1.658662] [    T194] amdgpu 0000:03:00.0: amdgpu: initializing kernel=
 modesetting (DIMGREY_CAVEFISH 0x1002:0x73FF 0x1462:0x1313 0xC3).
[    1.665045] [    T194] amdgpu 0000:03:00.0: amdgpu: register mmio base:=
 0xFCA00000
[    1.671399] [    T194] amdgpu 0000:03:00.0: amdgpu: register mmio size:=
 1048576
[    1.681596] [    T194] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 0 <common_v1_0_0> (nv_common)

then the built-in GPU is probed and set amdgpu_aspm =3D 0.

[    4.883191] [    T194] amdgpu 0000:08:00.0: enabling device (0006 -> 00=
07)
[    4.890078] [    T194] amdgpu 0000:08:00.0: amdgpu: initializing kernel=
 modesetting (RENOIR 0x1002:0x1638 0x1462:0x1313 0xC5).
[    4.895907] [    T194] amdgpu 0000:08:00.0: amdgpu: register mmio base:=
 0xFC900000
[    4.901640] [    T194] amdgpu 0000:08:00.0: amdgpu: register mmio size:=
 524288
[    4.909833] [    T194] amdgpu 0000:08:00.0: amdgpu: detected ip block n=
umber 0 <common_v2_0_0> (soc15_common)

I'm going to monitor calls to amdgpu_device_should_use_aspm() to check if =
it's called during
the suspend/resumes cycle giving the wrong answer (i.e. false when ASPM is=
 actually enabled)

Bert Karwatzki

