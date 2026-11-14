Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48AD606A323
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Nov 2026 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fO9Rx40X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7114110E1E4;
	Sat, 14 Nov 2026 16:32:35 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CAFC10E1E4
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 16:32:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6B860618B0
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 16:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FB61F000C4;
 Sat, 14 Nov 2026 16:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794673948;
 bh=sS2wCbjgziA7ey9CHSmSNyPZb6LylElB/Sa8GvQ4gQ0=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=fO9Rx40XYEG2eRs8UM9X7JgD0TDhAUouGIMxldSJpElXv0yvcAGlbynW7dCW6yS6Y
 PUwKcZmyNeph1l/vqZHxV7CgplfQ2K3jXJTf2jpBuXv+JDRntdaEucRh2py59J2WrQ
 MxDJPnQxdvHj5g0mpamK/8/rhQx8L6vQR/iRd5lBQDzT4YwQO/cXD2gMY+CeMnRmZ/
 R/ETWTx1Vsx5E4oVY1KE8/q2i2kwYu4eHtLUiUbqk0s5b888ILoYGWee7boXN3OBiN
 qM9kF18wodG46c8Np83QoAw98do/EhcBZYa2pql1Ypk4cIJZRJllMGuXRyBR4YWyvs
 3iQchR6lWYbpw==
Message-ID: <sashiko-outbox-214753@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] drm/amd: Select the firmware signing scheme the PSP
 reports
To: =?utf-8?b?TWFyaW8gTGltb25jaWVsbG8gKEFNRCk=?= <superm1@kernel.org>,
 amd-gfx@lists.freedesktop.org
In-Reply-To: <20261114160925.390350-1-superm1@kernel.org>
References: <20261114160925.390350-1-superm1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:32:27 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/amd: commit message and comment mismatch on
  AMDGPU_FW_SIGN_UNKNOWN
--

commit 1e462a80e1c59a04ecf750861d9cb9ad5ced28ac
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/amd: Select the firmware signing scheme the PSP reports

This commit reads C2PMSG_63 on MP0 15.0.0 and 15.0.9 to determine the
PSP firmware signing scheme and preproduction status, and appends the
corresponding "_l" or "_p" suffix when requesting firmware.

>     Add amdgpu_psp_init_fw_variant() which reads those bits through amdgp=
u's
>     own MMIO, and keep the result in adev->firmware.sign_type next to
>     load_type, where preproduction is a type of its own. It is initialized
>     once, after IP discovery has populated the register bases and only wh=
en
>     firmware is loaded through the front door (the PSP). Only MP0 15.0.0
>     reports it. For all other ASICs, SR-IOV VFs and an inaccessible regis=
ter
>     (all ones) the defaults are kept: AMDGPU_FW_SIGN_DEFAULT. A preproduc=
tion
>     part that also reports the alternative scheme is not expected, so warn
>     about it and use the default firmware.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index c0ed3e24b6840..a995d948284cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -403,6 +403,26 @@ static uint64_t psp_get_runtime_db_header_pos(struct=
 amdgpu_device *adev)
>  	return pos;
>  }
> =20
> +/*
> + * Which firmware the platform needs, as reported by the PSP in C2PMSG_6=
3: the
> + * signing scheme and whether this is a preproduction part. The defaults=
 are kept if
> + * the ASIC doesn't report it or it can't be read.
> + */
> +void amdgpu_psp_init_fw_variant(struct amdgpu_device *adev)
> +{
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
> +	switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
> +	case IP_VERSION(15, 0, 0):
> +	case IP_VERSION(15, 0, 9):
> +		psp_v15_0_0_get_fw_variant(adev);
> +		break;
> +	default:
> +		break;
> +	}
> +}

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ucode.c
> index d2ce526dd95cc..1632eda91acd9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1527,6 +1527,37 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_=
device *adev, int block_type,
>  	snprintf(ucode_prefix, len, "%s_%d_%d_%d", ip_name, maj, min, rev);
>  }
> =20
> +/* Add the suffix of the firmware variant before the extension: foo.bin =
-> foo_l.bin */
> +static int amdgpu_ucode_set_suffix(struct amdgpu_device *adev, char *fna=
me)
> +{
> +	const char *suffix;
> +	size_t base;
> +
> +	switch (adev->firmware.sign_type) {
> +	case AMDGPU_FW_SIGN_PREPROD:
> +		suffix =3D "_p.bin";
> +		break;
> +	case AMDGPU_FW_SIGN_ALT:
> +		suffix =3D "_l.bin";
> +		break;
> +	case AMDGPU_FW_SIGN_UNKNOWN:
> +		drm_warn(adev_to_drm(adev), "Unknown firmware signing\n");
> +		return -EINVAL;
> +	default:
> +		/* Default variant: the name is unchanged */
> +		return 0;
> +	}

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ucode.h
> index 7c809692807fc..15e789718dede 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> @@ -571,6 +571,14 @@ enum amdgpu_firmware_load_type {
>  	AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO,
>  };
> =20
> +enum amdgpu_firmware_sign_type {
> +	AMDGPU_FW_SIGN_DEFAULT =3D 0,
> +	AMDGPU_FW_SIGN_ALT,
> +	AMDGPU_FW_SIGN_PREPROD,
> +	/* Unexpected combination of signing bits, default firmware may not wor=
k */
> +	AMDGPU_FW_SIGN_UNKNOWN,
> +};

[Severity: Low]
This isn't a bug, but the commit message and the comment above
AMDGPU_FW_SIGN_UNKNOWN do not match the code.

When both alt and preprod bits are set, psp_v15_0_0_get_fw_variant() sets
AMDGPU_FW_SIGN_UNKNOWN and returns early without logging C2PMSG_63, and
amdgpu_ucode_set_suffix() returns -EINVAL rather than falling back to the
default firmware.  Also, the commit message says only MP0 15.0.0 reports
this, whereas amdgpu_psp_init_fw_variant() queries both 15.0.0 and
15.0.9.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114160925.3903=
50-1-superm1@kernel.org?part=3D1
