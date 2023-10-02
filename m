Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A65E784A4
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 07:40:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A41A210E222;
	Mon,  2 Oct 2023 07:40:16 +0000 (UTC)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D145410E057
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 00:00:36 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2788993edaaso5810735a91.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 01 Oct 2023 17:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696204836; x=1696809636; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KNWyNJP4lTLAfJKNYgIufw8zEVj0jVndMUsMvmUcLVQ=;
 b=D6PbAM+3+kTZHD6r7Yefu/kZq/31Z2zk5MVhVCHQPLEWW06KnUANb1YsfQtELBOlXE
 1r5xKUXBbD8bOc2/gXeqCyWCqIwb/LYYx84y4C3AqqLDiGQzRtM9H2QNNUU+Y35xe53k
 jM1fCqUtUHqTZ5A2KHY2YI7Ttw1FdCAOLfUUbgQP4aBugiaEDrv+zTQ97CO1/9wo7Y3Y
 DJ9tQhK4JU+YhMX8G6O2q8M5hN1U5qeAcEnf2s0x3rVVnMm3mCLSPbMY0mbP75EhxUfQ
 V0yAPRMEGBuXyiz2WtzRUX8ydNMo5ItkbYzVfeM3EJllIVSvRdqmYWWlyqAKJvql9n/6
 YdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696204836; x=1696809636;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KNWyNJP4lTLAfJKNYgIufw8zEVj0jVndMUsMvmUcLVQ=;
 b=X2UJtHw7OVALa4KY/juoeBVouJFLdU7VazOTcoekQ8VVmEpAe2rD+acKWkrhbXAVQ/
 TNGMNu7mtHDSpRPwvP6n9X1asERPLrIgyH1orvRh6Dqo5uF8hRew+dwUc/R/75ISuFEi
 vXvw3FUnJiQUhOheTqV0f+a2F+sCjJQqDCTEGBoXEBSx/wPXTxUsrcOvNm1yZCS7Hbnd
 9PZyXnndhBEpAMLrSAUsbqHxWt2qs5fsMKqPcF9xMONf3Lcq40kAPgsfw3YMOttE55sF
 kGiKUkGfcg6GuHkyZaGJ72mAWAAZYiM4ZjodHCnemc6gh9BU0UQC/la29VwAR5PC+DlE
 c+VQ==
X-Gm-Message-State: AOJu0YwKooK651SfUaYWBQDBkCI3pQMwyE9LOu53YrZjg97EKYwyMlcC
 RXJpabCMtnkxE+GggKIie6E=
X-Google-Smtp-Source: AGHT+IHhJd9AkvKhM23H1CfYxobZRIf+xF4/4a1sCcBfPqHy4X3rvVtS5Y2ftXhFmxdv3P+ACVewHw==
X-Received: by 2002:a17:90b:701:b0:274:6503:26d with SMTP id
 s1-20020a17090b070100b002746503026dmr7781874pjz.33.1696204836170; 
 Sun, 01 Oct 2023 17:00:36 -0700 (PDT)
Received: from debian.me ([103.131.18.64]) by smtp.gmail.com with ESMTPSA id
 l20-20020a17090ac59400b0026cecddfc58sm5110368pjt.42.2023.10.01.17.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 17:00:35 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
 id 61E0C8AE1552; Mon,  2 Oct 2023 07:00:28 +0700 (WIB)
Date: Mon, 2 Oct 2023 07:00:26 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Justin Piszcz <jpiszcz@lucidpixels.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux AMDGPU <amd-gfx@lists.freedesktop.org>
Subject: Re: 6.5.5: UBSAN: radeon_atombios.c: index 1 is out of range for
 type 'UCHAR [1]'
Message-ID: <ZRoIGhMesKtmNkAM@debian.me>
References: <CAO9zADy4b1XkD_ZaEF+XkDCXePJLD4Lev3g7HAEGYsCHgeM+KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9Cj4cS5T/fTBOaXp"
Content-Disposition: inline
In-Reply-To: <CAO9zADy4b1XkD_ZaEF+XkDCXePJLD4Lev3g7HAEGYsCHgeM+KQ@mail.gmail.com>
X-Mailman-Approved-At: Mon, 02 Oct 2023 07:39:51 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--9Cj4cS5T/fTBOaXp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 01, 2023 at 07:05:11PM -0400, Justin Piszcz wrote:
> Hello,
>=20
> Kernel: 6.5.5
> Arch: x86_64
> Distribution: Debian testing
>=20
> Recently, I enabled UBSAN and noticed the following at boot time with
> an older AMD graphics card, is this considered normal when using the
> AMD firmware-linux-nonfree package?
>=20
> [ .. ]
> [Sun Oct  1 15:59:04 2023] ACPI: bus type drm_connector registered
> [Sun Oct  1 15:59:04 2023] [drm] radeon kernel modesetting enabled.
> [Sun Oct  1 15:59:04 2023] [drm] initializing kernel modesetting
> (CEDAR 0x1002:0x68E1 0x1787:0x3000 0x00).
> [Sun Oct  1 15:59:04 2023] ATOM BIOS: PARK
> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: VRAM: 1024M
> 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: GTT: 1024M
> 0x0000000040000000 - 0x000000007FFFFFFF
> [Sun Oct  1 15:59:04 2023] [drm] Detected VRAM RAM=3D1024M, BAR=3D256M
> [Sun Oct  1 15:59:04 2023] [drm] RAM width 64bits DDR
> [Sun Oct  1 15:59:04 2023] [drm] radeon: 1024M of VRAM memory ready
> [Sun Oct  1 15:59:04 2023] [drm] radeon: 1024M of GTT memory ready.
> [Sun Oct  1 15:59:04 2023] [drm] Loading CEDAR Microcode
> [Sun Oct  1 15:59:04 2023] [drm] Internal thermal controller with fan con=
trol
> [Sun Oct  1 15:59:04 2023]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> [Sun Oct  1 15:59:04 2023] UBSAN: array-index-out-of-bounds in
> drivers/gpu/drm/radeon/radeon_atombios.c:2620:43
> [Sun Oct  1 15:59:04 2023] index 1 is out of range for type 'UCHAR [1]'
> [Sun Oct  1 15:59:04 2023] CPU: 5 PID: 1 Comm: swapper/0 Tainted: G
>             T  6.5.5 #13 55df8de52754ef95effc50a55e9206abdea304ac
> [Sun Oct  1 15:59:04 2023] Hardware name: Supermicro X9SRL-F/X9SRL-F,
> BIOS 3.3 11/13/2018
> [Sun Oct  1 15:59:04 2023] Call Trace:
> [Sun Oct  1 15:59:04 2023]  <TASK>
> [Sun Oct  1 15:59:04 2023]  dump_stack_lvl+0x36/0x50
> [Sun Oct  1 15:59:04 2023]  __ubsan_handle_out_of_bounds+0xc7/0x110
> [Sun Oct  1 15:59:04 2023]  radeon_atombios_get_power_modes+0x87a/0x8f0
> [Sun Oct  1 15:59:04 2023]  radeon_pm_init+0x13a/0x7e0
> [Sun Oct  1 15:59:04 2023]  evergreen_init+0x13d/0x3d0
> [Sun Oct  1 15:59:04 2023]  radeon_device_init+0x60a/0xbf0
> [Sun Oct  1 15:59:04 2023]  radeon_driver_load_kms+0xb1/0x250
> [Sun Oct  1 15:59:04 2023]  drm_dev_register+0xfc/0x250
> [Sun Oct  1 15:59:04 2023]  radeon_pci_probe+0xd0/0x150
> [Sun Oct  1 15:59:04 2023]  pci_device_probe+0x97/0x130
> [Sun Oct  1 15:59:04 2023]  really_probe+0xbe/0x2f0
> [Sun Oct  1 15:59:04 2023]  ? __pfx___driver_attach+0x10/0x10
> [Sun Oct  1 15:59:04 2023]  __driver_probe_device+0x6e/0x120
> [Sun Oct  1 15:59:04 2023]  driver_probe_device+0x1a/0x90
> [Sun Oct  1 15:59:04 2023]  __driver_attach+0xd4/0x170
> [Sun Oct  1 15:59:04 2023]  bus_for_each_dev+0x87/0xe0
> [Sun Oct  1 15:59:04 2023]  bus_add_driver+0xf3/0x1f0
> [Sun Oct  1 15:59:04 2023]  driver_register+0x58/0x120
> [Sun Oct  1 15:59:04 2023]  ? __pfx_radeon_module_init+0x10/0x10
> [Sun Oct  1 15:59:04 2023]  do_one_initcall+0x93/0x4a0
> [Sun Oct  1 15:59:04 2023]  kernel_init_freeable+0x301/0x580
> [Sun Oct  1 15:59:04 2023]  ? __pfx_kernel_init+0x10/0x10
> [Sun Oct  1 15:59:04 2023]  kernel_init+0x15/0x1b0
> [Sun Oct  1 15:59:04 2023]  ret_from_fork+0x2f/0x50
> [Sun Oct  1 15:59:04 2023]  ? __pfx_kernel_init+0x10/0x10
> [Sun Oct  1 15:59:04 2023]  ret_from_fork_asm+0x1b/0x30
> [Sun Oct  1 15:59:04 2023]  </TASK>
> [Sun Oct  1 15:59:04 2023]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> [Sun Oct  1 15:59:04 2023] [drm] radeon: dpm initialized
> [Sun Oct  1 15:59:04 2023] [drm] GART: num cpu pages 262144, num gpu
> pages 262144
> [Sun Oct  1 15:59:04 2023] [drm] enabling PCIE gen 2 link speeds,
> disable with radeon.pcie_gen2=3D0
> [Sun Oct  1 15:59:04 2023] [drm] PCIE GART of 1024M enabled (table at
> 0x000000000014C000).
> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: WB enabled
> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: fence driver on ring 0
> use gpu addr 0x0000000040000c00
> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: fence driver on ring 3
> use gpu addr 0x0000000040000c0c
> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: fence driver on ring 5
> use gpu addr 0x000000000005c418
> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: radeon: MSI limited to 32=
-bit
> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: radeon: using MSI.
> [Sun Oct  1 15:59:04 2023] [drm] radeon: irq initialized.
>=20

Please also open an issue on freedesktop tracker [1].

Thanks.

[1]: https://gitlab.freedesktop.org/drm/amd/-/issues

--=20
An old man doll... just what I always wanted! - Clara

--9Cj4cS5T/fTBOaXp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZRoIGgAKCRD2uYlJVVFO
o6noAP9HuoiP1/nHj4nq21Ci3xQjxNOjpnmdsHZA9nK1n88oSgEAwg++QOZd3SMo
pAPIydICrjcT3dJuOws5y2O5NcBXng4=
=1sWu
-----END PGP SIGNATURE-----

--9Cj4cS5T/fTBOaXp--
