Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45527C44501
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 13:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7C5710F2E9;
	Thu, 16 Jul 2026 13:04:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="P55KqEWE";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B0F210E781
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 12:41:09 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-493c733f15aso58069595e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 05:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784205667; x=1784810467;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=alTOohZu0SQ4UV4FE/HpOJ6Cn3gvl66dzSpGTMFo5iA=;
 b=P55KqEWE3JzKW6pHWPfLaLn3brefvArgBlwT9QIzMxW4be+ySDLQGAesyks6W02gqN
 mUhQdNwp2IUdP6gf3rA/vsihIB08b3CD81j+SS8mN6CJgVY+hUgdPQsJIMFgrNT3WfZF
 GP+DeMgbAs1xTEpQv+/yy9NmExeMgrbVdx72ZfGNGByVe6OJZz4NlEyS1UV06vqlfg2Z
 k06iCsmpfjENYEst416HUHacudPnq34T+08q3rCXnTNRS2eZpx/XhZF19LoQaea5wBQI
 cwzlaQ/NhFOQ/d8MzqM3G9KFePK5mbEm/TrQ2janC+yLUiZgzvGmfu6tUgjD5sepsLrK
 l6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784205667; x=1784810467;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=alTOohZu0SQ4UV4FE/HpOJ6Cn3gvl66dzSpGTMFo5iA=;
 b=rh7klAxS9YXVmW74mHn97u4XSmU9cmiWeQYCIn2K2dHCTUgCBooaqvLJK2F2ZRrT8R
 26eDPEAJ2H2hZimLfqi/DCuY5uHc7ZIYeROoD2iItftikLGHuu1fOdliPSwjnlK9Pywh
 R4WkYmk28WBOmp2MQj8tTrocq/jk0cuz4Dfpn6xO1shd2Caog/3L0AwVAb6U3XOR+ttR
 McMDeegQ1YI/f9KPgx1oKyCVK/a65pwECDPjcTj+JlosjKOI4bCjTHgnDW8PpvZXEcri
 wmaa/rPUVwtub1lpW8R88hzGGhz+yEo/uLCqW546wCVrDZjKi+ZiMD7wFyA6vHVEyjJ0
 0YGA==
X-Gm-Message-State: AOJu0YwYMlck8kGf01tORn9tg7aX8HeLVPhvoqfrWK/jDE2kl1XPIR7I
 jsuSauGLKjYXFXPO36huafAhindR1JCJ/+stE3EwuzDIKyVYF4elkZ15wujpk4TlmkgHaQ1HPJS
 tJZi0
X-Gm-Gg: AfdE7cn5DLkN8BN5RrZT+CoDq1PFSMc3ymQT+hW+66oUKq9tRJG3naZY9IheHGVGzPu
 CwIqNn0rjfazUsVWnn/Y/lByHrIqWCR/nEobCuGhgZZP2fMH0aJz8djfh1uW76p6dBuagiUiHOp
 6zci+FXYNPbWkm+QLZb41tu+4tXcE2Fxc9kNCiBBf71xHt2OTykN+XmSEMPiytj9buTUONK6Glp
 OZ6aufXklh5Z4Gipp14wJ+ElL0J26FOWZVJ+g9NM7+VPZqI7stwSQpXqB9u/lwC5kzH1U9rVX55
 27z42fmxgYU8mL9dAaicdNlc9Ry9NlIZhcQNMXnTFl23HbjDrhG3NH20Qmy1KcpXuhZT0JYzQNq
 RcIqw3Uf0UxL5QBx7HGmyX/kSG3Y+a1ncaZVMlOlHAU9eXLOHAoCjtXhxauTUa0yhp8tXNoWj0E
 bOvez5rmtc0c9lhwLuWcc6m64ziHB3jx/UDFgbMcB42cOe6gxB9/VjTHzakVgss4k0o0rAE7phu
 IdV
X-Received: by 2002:a05:600d:84ca:20b0:493:c984:db9c with SMTP id
 5b1f17b1804b1-495389ce041mr83222515e9.2.1784205667244; 
 Thu, 16 Jul 2026 05:41:07 -0700 (PDT)
Received: from localhost
 (p200300f65f47db046a548a0537ec1e67.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:6a54:8a05:37ec:1e67])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4953c704bfasm128424605e9.2.2026.07.16.05.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 05:41:06 -0700 (PDT)
Date: Thu, 16 Jul 2026 14:41:05 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Oz Tiram <oz@shift-computing.de>
Subject: Re: [PATCH 1/5] drm/amdgpu: Fix VFCT bus number matching with soft
 filter
Message-ID: <aljQlgDxiRrtMJti@monoceros>
References: <20260708193518.702584-1-mario.limonciello@amd.com>
 <20260708193518.702584-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rk4xtif35m6utk5c"
Content-Disposition: inline
In-Reply-To: <20260708193518.702584-2-mario.limonciello@amd.com>
X-Mailman-Approved-At: Thu, 16 Jul 2026 13:04:52 +0000
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


--rk4xtif35m6utk5c
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/5] drm/amdgpu: Fix VFCT bus number matching with soft
 filter
MIME-Version: 1.0

Hello,

On Wed, Jul 08, 2026 at 02:35:14PM -0500, Mario Limonciello wrote:
> On systems where PCI bus renumbering occurs (e.g. pci=3Drealloc,
> resource conflicts), the runtime bus number may differ from the
> BIOS POST bus number recorded in the VFCT table. This causes
> amdgpu_acpi_vfct_bios() to fail finding the VBIOS even though
> the correct device entry exists.
>=20
> Introduce amdgpu_acpi_vfct_match() which treats the bus number
> as a soft filter: vendor/device/function identity is the hard
> requirement, while exact bus match is the preferred path. When
> bus numbers disagree but device identity matches, accept the
> VFCT entry and log a dev_notice for diagnostics.
>=20
> Reported-by: Oz Tiram <oz@shift-computing.de>
> Closes: https://lore.kernel.org/amd-gfx/20260621173211.28443-1-oz@shift-c=
omputing.de/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 45 +++++++++++++++++++++---
>  1 file changed, 40 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_bios.c
> index 3ebdd792feec1..d8fd047295d9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -377,6 +377,45 @@ static bool amdgpu_read_disabled_bios(struct amdgpu_=
device *adev)
>  		false : amdgpu_asic_read_disabled_bios(adev);
>  }
> =20
> +/**
> + * amdgpu_acpi_vfct_match() - Check if a VFCT entry matches the device
> + * @adev: AMDGPU device
> + * @vhdr: VFCT image header to check
> + *
> + * VFCT entries contain the PCI bus number as recorded during BIOS POST.
> + * On systems where the kernel renumbers PCI buses (e.g. pci=3Drealloc or
> + * resource conflicts), the runtime bus number may differ from the POST
> + * value.  Match by device identity (vendor + device + function) and use
> + * the bus number as a preference: exact bus match is preferred, but when
> + * the bus numbers disagree we accept the entry if the device identity
> + * matches.
> + *
> + * Returns: 0 on match, -ENODEV on no match
> + */
> +static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
> +				  VFCT_IMAGE_HEADER *vhdr)
> +{
> +	/* Vendor and device IDs must always match */
> +	if (vhdr->VendorID !=3D adev->pdev->vendor ||
> +	    vhdr->DeviceID !=3D adev->pdev->device)
> +		return -ENODEV;
> +
> +	if (vhdr->PCIDevice !=3D PCI_SLOT(adev->pdev->devfn) ||
> +	    vhdr->PCIFunction !=3D PCI_FUNC(adev->pdev->devfn))
> +		return -ENODEV;
> +
> +	/* Exact bus number match - preferred */
> +	if (vhdr->PCIBus =3D=3D adev->pdev->bus->number)
> +		return 0;
> +
> +	/* Bus mismatch but device identity matches (PCI renumbering case) */
> +	dev_notice(adev->dev,
> +		   "VFCT bus number mismatch: table %u !=3D runtime %u, matching by de=
vice identity (vendor 0x%04x device 0x%04x)\n",
> +		   vhdr->PCIBus, adev->pdev->bus->number,
> +		   adev->pdev->vendor, adev->pdev->device);
> +	return 0;
> +}
> +
>  #ifdef CONFIG_ACPI
>  static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
>  {
> @@ -413,11 +452,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_devi=
ce *adev)
>  		}
> =20
>  		if (vhdr->ImageLength &&
> -		    vhdr->PCIBus =3D=3D adev->pdev->bus->number &&
> -		    vhdr->PCIDevice =3D=3D PCI_SLOT(adev->pdev->devfn) &&
> -		    vhdr->PCIFunction =3D=3D PCI_FUNC(adev->pdev->devfn) &&
> -		    vhdr->VendorID =3D=3D adev->pdev->vendor &&
> -		    vhdr->DeviceID =3D=3D adev->pdev->device) {
> +		    !amdgpu_acpi_vfct_match(adev, vhdr)) {
>  			adev->bios =3D kmemdup(&vbios->VbiosContent,
>  					     vhdr->ImageLength,
>  					     GFP_KERNEL);

For the record to hopefully make it easier for others to find the fix:

This patch became 33a18ecd2fbf in

	https://gitlab.freedesktop.org/agd5f/linux.git drm-next

and thus next and it introduces a build failure for !CONFIG_ACPI builds:

	drivers/gpu/drm/radeon/radeon_bios.c:614:12: error: =E2=80=98radeon_acpi_v=
fct_match=E2=80=99 defined but not used [-Werror=3Dunused-function]
	  614 | static int radeon_acpi_vfct_match(struct radeon_device *rdev,
	      |            ^~~~~~~~~~~~~~~~~~~~~~

Patch available at https://lore.kernel.org/all/20260716123646.1933293-2-u.k=
leine-koenig@baylibre.com/

Best regards
Uwe

--rk4xtif35m6utk5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpY0V4ACgkQj4D7WH0S
/k6cOgf/XgiNVtpaZIlKqWpfX0MtDsO8E8fMRaDz9O5WKx55nFUCS1EmKsiAHQa1
xuBCRev05rnIBdK/OYZZ2LZyxjiSpZzp1BbkmeKJZFiy0HMoOUAI16+1gcWXE3Wj
i1HCdznX6EAGM5dBxKmZdxMQx1XavUl71OAEbzP8TZOXKiIOEpVBLfv7dOJy2SCd
WTyBikKQg7iDQjRJS3tatApdE98q38uEae6izZhBybJryEKuEP8tiREVdw5Km6WC
Hibs267u1KFJoNCNvi8iSS1gN97/XUIPCxijhQNr9viuwLr2VR0Wm6xNqxwC5qY+
DNeQAOyJBOGYk6xcuYmFX5GgGrlx7A==
=x2IP
-----END PGP SIGNATURE-----

--rk4xtif35m6utk5c--
