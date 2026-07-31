Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93625C5516D
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 13:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3781010E231;
	Fri, 31 Jul 2026 13:39:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bkI8q2a6";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9248B10E231
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 13:39:41 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-38f57e312ecso42457a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 06:39:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785505181; cv=none;
 d=google.com; s=arc-20260327;
 b=Q7F46xu3rOTVp9kjdPg12PrC/tCuJmllhVOxJepgs89Jm5oX/Q+JJtZFQCLxh702yj
 e14SeSKubj9U0g/Sz8eAc77H07mmMFWbvXf8kR12X84OB5zLtYzzyW3jE5+N3IS6Wxn+
 JwRKKE7Umh6qoosuvgz7polB+KcYJL0JmUuhVcrW5MTgGJ2YJE01V4CoBUi8Z6i9wY7/
 q9Ha7bD5VSeTCFCJoneyZbXkgWLLRs+hBmwRC+QyyACIU7ddDpPuezbRnRYfmYi1nkCS
 +xHtDW9xTytNQ7tEhFnfIcg7cRy8TfZW9PCBD1Wqu8jWt+C1U6j0evYFxluuBqff3zED
 A4lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TE8h4vlxg7OnBh9xVOPP4e3C9QZP4TbijcEa3l1QY8Y=;
 fh=69op35mcA0SdNnKgF8pionUbLtHO6bYfQO5eW7XhsGI=;
 b=GIB10+Z7NgS/VNDP9o1Mlxj2DeQ0Tuh3eeLOcpBQhMJENDakqjxuzShZWeijgDgMFF
 nT8YstZaXqpEkr15b+6mk+C+OM41c21aSjmgeCZDxLpkPXcUWRWLOIG8+7KphmPXmMPC
 H1aVLaBz/3PJ+qZP6ffNCKTL4MlLMQv1w3+PYvWH0ilhkL7DmMVv5c72IvKPuUNoheX2
 CiMS0Iugeo17D/B+UKGYH6nAXa/Z1reDV3+vSrGkDHz2YYALX0segMKC162HMvWj/1pT
 CXgwIczRwjyz1/9rJbzyhHlhe/+cvPNsSFD2dOjERQBVK2R2q7f2obOC6m0KuQaWKsy/
 Qrdg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785505181; x=1786109981; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TE8h4vlxg7OnBh9xVOPP4e3C9QZP4TbijcEa3l1QY8Y=;
 b=bkI8q2a6VWSdowkB2s1fhcwfBpWNrPmyiMhu0zTLOzUjmMl28TjW6v3HMOOx6M1jai
 4UvmBgHgNcWDylRujCom28o4m6z/FMpsbVjKF4LxBBUskAOc++g+A5AA5S99lJKAO7CS
 9EMPrsDpmtcUQmmgwrEzJi+C7RDfsZa8aPtN1uv8+YaA6lsigp26v0RpDN3peagBN3j8
 FnSF7wfLvrUlsTxaTH/g9wTQTKIfes6qcDTGy4mFH7z5+7pDAEEo5Ku6YuV7gx/JkusB
 oeo7kHpDXUdhvRVfkNXVlfO8yHrKSn02n03meymNW6XXC7wARe6uXOMvkCDgcmFFLxjC
 xt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785505181; x=1786109981;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TE8h4vlxg7OnBh9xVOPP4e3C9QZP4TbijcEa3l1QY8Y=;
 b=gbpF+RUGm9gcCZacIn8lRKuHGlEYm/wgZLsh09diAO73ZybX7doVEqTttGKFs7u1mE
 2Iir+2+kvYqqKYLJzpmoRK8T0gzPCAavObNuIFfo3YjeMWsUZ1hagD4LlW+/1anRVFAm
 J6u07rDbfhJm154cXFTgKcF4cN+ygzA25J2vNpBipQB8XzA9wKi73manhYcUHfgqg/gL
 bhdfNVaB3PWSbRiIV6pMV7/4a/7/MkbPlyOGER6nzX3O8ckiJDaCSFTgKD2nJQQHu5Xg
 qUgRLvpB2nX/Mm+ybv9P7mNpKOl36NoxIGd3ym1T3N0b30suncLBt8OU5fEH0pgJAroJ
 CoJw==
X-Gm-Message-State: AOJu0Ywo/l9AuurNPXUeUEMY2+PCUEhgzYFdFyLvdQmkYSFWaU5iWDiP
 930KKhv2fcK3t35aK2BvhFh5072K1NaT5LnwaeCkv3l3ej0xHFDBsCrQDu8/2tdyqORED3eDwCY
 1Rjucljfh+dD7vwgi+XzFa/3tTBsq8WW6Pg==
X-Gm-Gg: AR+sD10SB8dYkEkehBGfGBSYrc2LnT6/j/xRkHNIE1e4rKl1pJ0cVd1WsU3k6DB8y0+
 dosuijSaVktQzwAa5sZAmzQ3z8IhvDcbGCdx/UB78CYiCSg5YAd0QgGFYMGllWa4qfz68kQ2P4/
 2d26yG0cn8OuKC3xH0H11EYCdQBxFXNuHwXbQO4b/pO5mxFOBM88H/MHeLV+gFCyt+oXS+B+pwR
 6wllHipz0ZMXZP3k5+akcm+p/XsvL8PUQJ+byCTOoIjbCx8WCZHWZlm0NVlm128VmZTbs5AzUBE
 EQYyGCAkCXNk+Ivm/hpHxHE5I6HNN9krDoRp3zqj3sDhMIgmmjjQQpW2nDMb7e6vuRx070b/u4B
 zjqvaTqOSasot7my9k0cT9eyWA3cqWWcelae4adSpfOc=
X-Received: by 2002:a17:90b:388e:b0:36d:b30b:14ed with SMTP id
 98e67ed59e1d1-38fbb692438mr295395a91.2.1785505180916; Fri, 31 Jul 2026
 06:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <CALnZc=SfhdmF_YzAcG5A7=NfgTVUB6Mc2FFY-jkZ2sXWjPPj+g@mail.gmail.com>
In-Reply-To: <CALnZc=SfhdmF_YzAcG5A7=NfgTVUB6Mc2FFY-jkZ2sXWjPPj+g@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 31 Jul 2026 09:39:28 -0400
X-Gm-Features: AUfX_mz7oWrJB5xRxD-HNTVZEgygN2WN4AsNgYcsx9yp58JmzsuvMI-uvOkpp7I
Message-ID: <CADnq5_MPmP2DDEvxSSrgFhiHv2-hHbsudW7GVfsyhrWUkALhEQ@mail.gmail.com>
Subject: Re: AMD BC-250 (Cyan Skillfish, gfx1013): can the VCN 2.0.3 power
 domain be brought up?
To: Daniel Lima <danieldelimafrancisco5504@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Fri, Jul 31, 2026 at 8:58=E2=80=AFAM Daniel Lima
<danieldelimafrancisco5504@gmail.com> wrote:
>
> Subject: AMD BC-250 (Cyan Skillfish, gfx1013): can the VCN 2.0.3 power
> domain be brought up?
>
> Hi,
>
> I'm working with an AMD BC-250 (ASRock mining blade, PCI 1002:13FE, Cyan
> Skillfish / gfx1013, GC 10.1.3) on Fedora 44 with the stock 6.19.10 kerne=
l.
> Hardware video decode is unavailable, and I would like to ask whether tha=
t is a
> firmware limitation or just an untested configuration.
>
> The short version: in amdgpu_discovery_set_mm_ip_blocks(), UVD_HWIP
> IP_VERSION(2, 0, 3) has an explicitly empty case, so neither vcn_v2_0_ip_=
block
> nor jpeg_v2_0_ip_block is ever registered. Is that intentional because th=
e
> SMU 11.8 PMFW has no VCN power management, or is it simply that this ASIC=
 was
> never validated for video?
>
> What I measured, in case it is useful:
>
> - The IP discovery table does report the block.
>   /sys/class/drm/card1/device/ip_discovery/die/0/12/0/ gives
>   major.minor.rev =3D 2.0.3, harvest =3D 0x0, base_addr =3D 0x00007800. T=
he
>   HARVEST_INFO table in the discovery binary is empty.
>
> - The whole UVD register aperture is unreadable. Through debugfs amdgpu_r=
egs,
>   both segments return 0xFFFFFFFF: mmCC_UVD_HARVESTING, mmUVD_POWER_STATU=
S,
>   mmUVD_PGFSM_CONFIG, mmUVD_PGFSM_STATUS, mmUVD_STATUS, and the JPEG regi=
sters
>   in the 0x7800 segment. mmGRBM_STATUS through the same read path returns
>   0x00003028, so the access method itself is fine.
>
> - Writing the value that vcn_v2_0_disable_static_power_gating() would wri=
te
>   with pg_flags =3D=3D 0 (0x00055555 to mmUVD_PGFSM_CONFIG) is accepted b=
ut has no
>   effect; PGFSM_STATUS stays 0xFFFFFFFF. The PGFSM itself therefore appea=
rs to
>   sit inside the unpowered domain.
>
> - nv_common_early_init() sets cg_flags =3D 0 and pg_flags =3D 0 for GC 10=
.1.3, and
>   cyan_skillfish_ppt_funcs implements no .dpm_set_vcn_enable, so nothing =
ever
>   requests a VCN power-up. smu_v11_8_ppsmc.h has no VCN-related message, =
and
>   smu_v11_8_pmfw.h has no VCN feature bit; the clock level fields cover
>   LCLK / MP0CLK / FCLK / SOCCLK / DCEFCLK only.
>
> - From the platform firmware (AGESA!V9 RBNBDK-BL5 46.1.2.220426): the PMF=
W is
>   PSP directory entry type 0x08 / 0x12, version 0.58.7.1, and it contains=
 the
>   string "AMD BC-250", so it looks board-specific. I could not find any V=
CN,
>   UVD or JPEG reference anywhere in the UEFI image.
>
> My questions:
>
> 1. Is IP_VERSION(2, 0, 3) deliberately unhandled because the PMFW on this=
 SOC
>    cannot power up the VCN domain?
>
> 2. If a power-up path does exist -- an SMU message, or something the ABL =
/
>    AGESA is expected to do -- could you point at it? I am happy to test
>    patches.
>
> 3. Could the block be disabled in a way the harvest table would not refle=
ct?
>
> I am not asking for support on an unsupported product. A factual answer e=
ither
> way would help: the community documentation for this board currently attr=
ibutes
> the missing decode to a signed-firmware restriction, which does not match=
 what
> I see -- the VCN 2.x ucode is present in linux-firmware and this ASIC use=
s
> AMDGPU_FW_LOAD_DIRECT -- and I would rather correct that than let people =
keep
> chasing it.
>

VCN was not part of the product definition for BC-250.  While the die
may have the IP, it's possible there were manufacturing defects on it
on particular chips.  Some may work, some may not.  Beyond that, like
you said, I'm not sure any support was added to the PMFW or the vbios
for this part because it wasn't part of the product definition.
Without that, I don't think there is a way to power it up.
Additionally, even if it were valid on a particular chip, there is no
firmware for it.  BC-250 requires signed firmwares and uses the
standard PSP firmware loading mechanism.

Alex
