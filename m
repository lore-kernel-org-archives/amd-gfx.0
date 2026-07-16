Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FCDC44511
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 16:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91F2610E369;
	Thu, 16 Jul 2026 16:24:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SOIaTg8o";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27D4810E369
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 16:24:30 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2cc827a68fbso17744905ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 09:24:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784219070; cv=none;
 d=google.com; s=arc-20260327;
 b=j2n1BN1JgntaGuj4b/mpSo+JKTau/qv1aWzbVHrZtQCng++W5JbZq+YCrmH7PJ0eVs
 oIdR1dnT+tvOMN+8ndojQ0YU5vZFKXln2FsU2pLfKJUp9PKkYzVgGRYOr+G8LxPO56kz
 U4we5POsMWUFXsUPUfYZtUxgoXVoadyWxaO401k4MfM/NgkOymEa3HLgRPAq+Fr0YyBy
 g9DOSEpT4NBBPqYzEhyopcpNNAf3JHyHsLO6VDa577LBCYJT+Dds/+/KEOETDMrX+QVm
 6mereX57JNc9VDIDxdz2hdAdvnwOBuO/rjT11rKxtCnnNS3dFpXstKdW+M/J3KvBrAru
 uOVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EjmgVbCGBDpFJgrFHfJWq33zFFq+XmTWz7OyzapjRAY=;
 fh=Q4HrxpLNZDQoehLIR3f+T3CXknXdZkISzjpjpCdWrkI=;
 b=du3tiSKVPsVfgc+Eql/y7r9VzafSfMjconYWaN5vAsmkBPf1DgOcdH9JelHeYlYgPK
 fmEupkvufSML1HRotBMBCleztY8V+24viHsytrYiUL83nijbGHLjEJiD7Jb6Kfuon6Vu
 pdXHz7kqbdgs3odOh+VV7SWf5LYmWd64cmPHk2VwhbY2fGBTsI8nt/bqfzoaeNmxSfdY
 0yl+UK6rEyKdCXZhKLNnxDbMUNsxoBixkEArOe5tR79S9vHGwX00lw4WHhImc1mU2aaf
 Ow5XuFCrsqlnfWhVZogBCFa42ZNWRaCM4WWGU/RW5A6dDngufaJNMiP3C2If1fjlDFja
 oReg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784219070; x=1784823870; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EjmgVbCGBDpFJgrFHfJWq33zFFq+XmTWz7OyzapjRAY=;
 b=SOIaTg8ou2kqeSAHoc/ChF0fhutD5+KFAgQ5vdjg/uRxRY8WiZuOATMMgH8CeaPubI
 ZvEuopPY+HAyRsJGfSjfSmKoXkPb28FpLXXHf5+2fTsvhfKmsc5dhIMPpXl6pBcLZOm6
 DUswZfloByeEBQbtPFZvuOaCXXsUNKRQ5GGNW5BEzAAigGU7MfKO7H9ZaL323wBBv27l
 f9GSoAMVfWBmUV33dHf2wJlW6V+TycooDxj+vTXI3SDtbaDmDjf3gXZTUQb/lOMsGCJI
 7o9od3S5DETBsA/WL7+5af8FC7Xl+HiQ4cJT9kr6O2JIf1AFXO8xOyNAy+LSLC35njRw
 YAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784219070; x=1784823870;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EjmgVbCGBDpFJgrFHfJWq33zFFq+XmTWz7OyzapjRAY=;
 b=m13WIDY6Vhdo7VD5yWT/HxdLH1QpsyKPhTC00C+Pi5W5TO8jvW6GPWFWK+ETV+aRMc
 dVyyLABT+vmFQ4BaXtYUBPjxK/bufQOXE2J4COZ32LKJdM7DE8M426kMk6XdAUb9Kpbe
 /eVWPixFiuXAsqbpw5DfsqSm/+ABK44Fk1y32AfXb0+EFDiozj5yuKvaYixogklA+G3e
 /eeD8y85DTlCzNghfOgedJDWPJ/0A1GApKj8A03vsBDdojbFMi9Tpkq4gaVVDrfdx630
 wRl0poLfa2zhJqebNFq+WfLlyf5ujSg8Hg1g3z7kzhwYPV16WrEAb3cs5DYQykcHk2l6
 GJAA==
X-Gm-Message-State: AOJu0YwGRf8uXlZakk8tuDd0755nClqjAEB5U4jk/HqG+lq0DyPgdgCJ
 srA4Zna80Mj+yYEcIcn1MOM7bvBtvpycJAZKeE9cFZ248W/iwJEXVeII+WGaU82S7llx0nAyYyp
 fcLhYpQzdcUMTN3wfRFvVUOTJPrsT5DQ=
X-Gm-Gg: AfdE7cn7g7tkz+ZrqWS5sLwks86h73nQGPhfuWAex96sP6WVyTmfSqaLpDOotPVo9Uo
 w+rCOx0zqql3xszW4ApIFZQS73btxn18m5BPU7fIVbL8Te8tZD2ehxu/EnW2kCyrKFl3c2DrNPD
 R/si7QpFbredj9caaaoJnXcmiXhbMlmXUxVMx5UzIq4Dc8j5J0Ixdegbb6kK5av0/bjz3vD29GG
 ev9VT9NVRgM81dxocLpH/g5SMys78n7nTKmoJv+uDZMgnD50pjtP9hVUdCu2vaUKqS8tRpld9k2
 VYAuAufhA6WI1v+NbeIKFfjawiSj9k7PZEKpsb04HV3Wfd58
X-Received: by 2002:a17:902:fc86:b0:2ca:d803:5c8f with SMTP id
 d9443c01a7336-2ce9e59ed95mr186184305ad.1.1784219069331; Thu, 16 Jul 2026
 09:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260715164836.3879564-1-dmitrii.galantsev@amd.com>
In-Reply-To: <20260715164836.3879564-1-dmitrii.galantsev@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Jul 2026 12:24:15 -0400
X-Gm-Features: AUfX_myZHu3cc3gYnGYJB6iOw3t3xYCZh-XVdSVktL1S5wSQ4tck5yHUL4nkWq0
Message-ID: <CADnq5_NYHK6h3dac9M4MKkoY-cW4LiUz_WGfki9GLYAchX-wBw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add Component Unified ID (CUID) sysfs
 interface
To: "Galantsev, Dmitrii" <dmitrii.galantsev@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 paul.blinzer@amd.com
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

On Thu, Jul 16, 2026 at 1:49=E2=80=AFAM Galantsev, Dmitrii
<dmitrii.galantsev@amd.com> wrote:
>
> From: Dmitrii Galantsev <dmitrii.galantsev@amd.com>
>
> Expose a stable, per-GPU identifier so fleet and inventory tooling can na=
me
> a device without reading the raw serial number.
>
> A 122-bit primary payload (serial, PCI vendor/device/revision, unit and
> component type) is packed LSB-first and rendered as an RFC 9562 UUIDv8.
> Three sysfs attributes sit beside unique_id:
>
>   - cuid_primary (0400): raw identity; root-only as it embeds the serial.
>   - cuid_secondary (0444): HMAC-SHA256(seed, primary), world-readable as =
it
>     leaks neither the serial nor the seed. A public default seed is used
>     until a secret is provisioned via cuid_seed.
>   - cuid_seed (0600): the secret seed, raw bytes (at most 32).
>
> Derivation uses the synchronous library HMAC-SHA256 (crypto/sha2.h) on th=
e
> read path; the only persistent state is the seed, guarded by a mutex. CUI=
D
> init is best-effort and does not fail device attribute init.
>
> Signed-off-by: Dmitrii Galantsev <dmitrii.galantsev@amd.com>
> ---
>  Documentation/gpu/amdgpu/driver-misc.rst   |  21 ++
>  drivers/gpu/drm/amd/amdgpu/Kconfig         |   2 +
>  drivers/gpu/drm/amd/amdgpu/Makefile        |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   5 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cuid.c   | 278 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cuid.h   |  45 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  13 +-
>  7 files changed, 364 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cuid.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cuid.h
>
> diff --git a/Documentation/gpu/amdgpu/driver-misc.rst b/Documentation/gpu=
/amdgpu/driver-misc.rst
> index e1a964c3add2..983358ab4c4c 100644
> --- a/Documentation/gpu/amdgpu/driver-misc.rst
> +++ b/Documentation/gpu/amdgpu/driver-misc.rst
> @@ -154,3 +154,24 @@ uma/carveout
>
>  .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     :doc: uma/carveout
> +
> +Component Unified ID (CUID) Information
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +cuid_primary
> +------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_cuid.c
> +   :doc: cuid_primary
> +
> +cuid_secondary
> +--------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_cuid.c
> +   :doc: cuid_secondary
> +
> +cuid_seed
> +---------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_cuid.c
> +   :doc: cuid_seed
> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amd=
gpu/Kconfig
> index 12e4a41bf1f0..1430096412ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> @@ -26,6 +26,8 @@ config DRM_AMDGPU
>         select DRM_SUBALLOC_HELPER
>         select DRM_EXEC
>         select DRM_PANEL_BACKLIGHT_QUIRKS
> +       # CUID derives its secondary ID with library HMAC-SHA256
> +       select CRYPTO_LIB_SHA256
>         # amdgpu depends on ACPI_VIDEO when ACPI is enabled, for select t=
o work
>         # ACPI_VIDEO's dependencies must also be selected.
>         select INPUT if ACPI
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/am=
dgpu/Makefile
> index 105b9dcc19a2..66f4476966cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -52,6 +52,7 @@ amdgpu-y :=3D amdgpu_drv.o
>
>  # add KMS driver
>  amdgpu-y +=3D amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o =
amdgpu_kms.o \
> +       amdgpu_cuid.o \
>         amdgpu_atombios.o atombios_crtc.o amdgpu_connectors.o \
>         atom.o amdgpu_fence.o amdgpu_ttm.o amdgpu_object.o amdgpu_gart.o =
\
>         amdgpu_encoders.o amdgpu_display.o amdgpu_i2c.o \
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index f5d65bd0ac25..90abbdfcec5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -872,6 +872,11 @@ struct amdgpu_device {
>
>         uint64_t                        unique_id;
>         uint8_t                         unitid;
> +
> +       /* CUID: secret seed for HMAC-derived secondary CUID */
> +       struct mutex                    cuid_seed_lock;
> +       u8                              cuid_seed[32];
> +       unsigned int                    cuid_seed_len;

I'd move this into its own struct defined in cuid.h and then include
that here.  I think you probably want to store the cached primary and
secondary ids as well.

>         uint64_t        df_perfmon_config_assign_mask[AMDGPU_MAX_DF_PERFM=
ONS];
>
>         /* enable runtime pm on the device */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cuid.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cuid.c
> new file mode 100644
> index 000000000000..a365f8ab4591
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cuid.c
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: GPL-2.0

Please use MIT instead.

> +/*
> + * CUID (Canonical Unique ID) support for amdgpu.
> + *
> + * Builds a primary identifier from the GPU identity (vendor/device/revi=
sion and
> + * the serial in adev->unique_id) and exposes it, plus an HMAC-derived s=
econdary
> + * value, as UUIDv8 sysfs files beside unique_id.
> + *
> + * The packing, UUIDv8 framing and HMAC derivation form a frozen ABI: th=
e
> + * payload is packed LSB-first into 16 little-endian bytes, framed as an
> + * RFC 9562 UUIDv8, and derived as HMAC-SHA256(key, primary). Derivation=
 uses
> + * the synchronous library HMAC-SHA256 (crypto/sha2.h), so it cannot fai=
l and is
> + * callable from the sysfs read path. The only persistent state is the s=
ecret
> + * seed (adev->cuid_seed*, guarded by adev->cuid_seed_lock).
> + */
> +#include <linux/device.h>
> +#include <linux/sysfs.h>
> +#include <linux/capability.h>
> +#include <linux/pci.h>
> +#include <linux/string.h>
> +#include <linux/uuid.h>
> +#include <linux/mutex.h>
> +#include <linux/unaligned.h>
> +#include <crypto/sha2.h>
> +
> +#include <drm/drm_drv.h>
> +
> +#include "amdgpu.h"
> +#include "amdgpu_cuid.h"
> +
> +/* Public default seed for cuid_secondary until a secret is provisioned.=
 */
> +static const u8 CUID_DEFAULT_SEED[] =3D "AMD-CUID-DEFAULT-SEED-v1";

Check with Tony.  I think he had proposed a default seed value.

> +
> +/* Pack the 122-bit primary payload into 16 little-endian bytes. */
> +static void cuid_pack(const struct cuid_primary *p, u8 raw[16])
> +{
> +       put_unaligned_le64(p->dsn, raw);        /* 0:63 DSN */
> +
> +       raw[8]  =3D p->unit_id & 0xFF;            /* 64:71 UnitID lo */
> +       raw[9]  =3D p->revision_id;               /* 72:79 revision */
> +       put_unaligned_le16(p->device_id, &raw[10]);     /* 80:95 device *=
/
> +       put_unaligned_le16(p->vendor_id, &raw[12]);     /* 96:111 vendor =
*/
> +
> +       /* 112:116 UnitID hi | 117 aux | 118:121 component type */
> +       raw[14] =3D ((p->unit_id >> 8) & 0x1F) |
> +                 ((p->aux & 0x1) << 5) |
> +                 ((p->component_type & 0x03) << 6);
> +       raw[15] =3D (p->component_type >> 2) & 0x03;
> +}
> +
> +/* UUIDv8 framing bits: version nibble (76:79), variant bits (62:63). */
> +static bool cuid_is_framing_bit(int pos)
> +{
> +       return pos =3D=3D 62 || pos =3D=3D 63 || (pos >=3D 76 && pos <=3D=
 79);
> +}
> +
> +/* Insert RFC 9562 UUIDv8 version(8)/variant(10b) framing losslessly. */
> +static void cuid_to_uuidv8(const u8 raw[16], u8 uuid[16])
> +{
> +       int src =3D 0, pos;
> +
> +       memset(uuid, 0, 16);
> +       for (pos =3D 0; pos < 128; pos++) {
> +               if (cuid_is_framing_bit(pos))
> +                       continue;
> +               if ((raw[src >> 3] >> (src & 7)) & 1)
> +                       uuid[15 - (pos >> 3)] |=3D 1u << (pos & 7);
> +               src++;
> +       }
> +       uuid[6] =3D (uuid[6] & 0x0F) | 0x80;      /* version 8 */
> +       uuid[8] =3D (uuid[8] & 0x3F) | 0x80;      /* variant 10b */
> +}
> +
> +/*
> + * Derive the secondary payload from HMAC-SHA256(key, raw_primary):
> + *   0:63    =3D hash[0:63]
> + *   72:116  =3D hash[64:108]    (45 bits)
> + *   117     =3D aux (from primary); all other bits zero.
> + */
> +static void cuid_derive(const u8 *key, unsigned int keylen,
> +                       const u8 raw_primary[16], u8 derived_raw[16])
> +{
> +       u8 digest[SHA256_DIGEST_SIZE];
> +       int i;
> +
> +       hmac_sha256_usingrawkey(key, keylen, raw_primary, 16, digest);
> +
> +       memset(derived_raw, 0, 16);
> +
> +       /* hash[0:63] -> derived[0:63] */
> +       memcpy(derived_raw, digest, 8);
> +
> +       /* hash[64:108] -> derived[72:116] */
> +       for (i =3D 0; i < 45; i++) {
> +               int hb =3D 64 + i, db =3D 72 + i;
> +               u8 bit =3D (digest[hb >> 3] >> (hb & 7)) & 1;
> +
> +               derived_raw[db >> 3] |=3D bit << (db & 7);
> +       }
> +
> +       /* aux (bit 117) copied from primary; same position in both buffe=
rs */
> +       derived_raw[14] |=3D raw_primary[14] & BIT(5);
> +
> +       memzero_explicit(digest, sizeof(digest));
> +}
> +
> +static void amdgpu_cuid_build_primary(struct amdgpu_device *adev,
> +                                     struct cuid_primary *p)
> +{
> +       u64 dsn =3D 0;
> +
> +       memset(p, 0, sizeof(*p));
> +
> +       if (adev->pdev) {
> +               p->vendor_id =3D adev->pdev->vendor;
> +               p->device_id =3D adev->pdev->device;
> +               p->revision_id =3D adev->pdev->revision;
> +
> +               /* Prefer the PCIe DSN capability, else the SMU serial. *=
/
> +               dsn =3D pci_get_dsn(adev->pdev);
> +       }
> +       if (!dsn)
> +               dsn =3D adev->unique_id;
> +
> +       p->dsn =3D dsn;
> +       /* aux (bit 117): set when no genuine serial was found (dsn =3D=
=3D 0). */
> +       p->aux =3D (dsn =3D=3D 0);
> +       p->component_type =3D CUID_COMPONENT_GPU;
> +}

I'd like to try and keep the amdgpu details out of the cuid library.
Ideally this library could be made into a standalone module eventually
that could be used by other drivers that want to implement cuid.  For
example, make the function take an optional serial number as a
parameter which will get used if the caller specifies it, otherwise,
it will use the DSN.

I'd also suggest caching the primary and secondary CUIDs and only
regenerating them on driver load or if the seed changes.  For storing
the seed value, I think we had talked about using
efi.get_variable()/efi.set_variable()

> +
> +/*
> + * DOC: cuid_primary
> + *
> + * Primary CUID as a UUIDv8. Embeds the raw serial, so it is root-only (=
0400).
> + */
> +static ssize_t cuid_primary_show(struct device *dev,
> +                                struct device_attribute *attr, char *buf=
)
> +{
> +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> +       struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +       struct cuid_primary primary;
> +       u8 raw[16], uuid[16];
> +
> +       if (!capable(CAP_SYS_ADMIN))
> +               return -EPERM;
> +
> +       amdgpu_cuid_build_primary(adev, &primary);
> +       cuid_pack(&primary, raw);
> +       cuid_to_uuidv8(raw, uuid);
> +
> +       return sysfs_emit(buf, "%pUb\n", uuid);
> +}
> +
> +static DEVICE_ATTR(cuid_primary, 0400, cuid_primary_show, NULL);
> +
> +/*
> + * DOC: cuid_secondary
> + *
> + * HMAC-SHA256(seed, primary) as a UUIDv8. Leaks neither the serial nor =
the
> + * seed, so it is world-readable (0444). Without a provisioned seed a pu=
blic
> + * default is used: stable but not fleet-unique, so treat it as a placeh=
older.
> + */
> +static ssize_t cuid_secondary_show(struct device *dev,
> +                                  struct device_attribute *attr, char *b=
uf)
> +{
> +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> +       struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +       struct cuid_primary primary;
> +       u8 raw[16], derived[16], uuid[16];
> +       u8 seed[32];
> +       unsigned int seedlen;
> +
> +       amdgpu_cuid_build_primary(adev, &primary);
> +       cuid_pack(&primary, raw);
> +
> +       mutex_lock(&adev->cuid_seed_lock);
> +       if (adev->cuid_seed_len) {
> +               seedlen =3D adev->cuid_seed_len;
> +               memcpy(seed, adev->cuid_seed, sizeof(seed));
> +       } else {
> +               /* default seed, excluding the string's NUL terminator */
> +               seedlen =3D sizeof(CUID_DEFAULT_SEED) - 1;
> +               memcpy(seed, CUID_DEFAULT_SEED, seedlen);
> +       }
> +       mutex_unlock(&adev->cuid_seed_lock);
> +
> +       cuid_derive(seed, seedlen, raw, derived);
> +       memzero_explicit(seed, sizeof(seed));
> +
> +       cuid_to_uuidv8(derived, uuid);
> +       return sysfs_emit(buf, "%pUb\n", uuid);
> +}
> +
> +static DEVICE_ATTR_RO(cuid_secondary);
> +
> +/*
> + * DOC: cuid_seed
> + *
> + * Root-only (0600) secret seed for cuid_secondary, as raw bytes (at mos=
t 32).
> + * Reading returns the seed in use (the provisioned secret, or the defau=
lt);
> + * read and write use the same encoding, so the value round-trips.
> + */
> +static ssize_t cuid_seed_show(struct device *dev,
> +                             struct device_attribute *attr, char *buf)
> +{
> +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> +       struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +       unsigned int seedlen;
> +
> +       if (!capable(CAP_SYS_ADMIN))
> +               return -EPERM;
> +
> +       mutex_lock(&adev->cuid_seed_lock);
> +       if (adev->cuid_seed_len) {
> +               seedlen =3D adev->cuid_seed_len;
> +               memcpy(buf, adev->cuid_seed, seedlen);
> +       } else {
> +               /* default seed, excluding the string's NUL terminator */
> +               seedlen =3D sizeof(CUID_DEFAULT_SEED) - 1;
> +               memcpy(buf, CUID_DEFAULT_SEED, seedlen);
> +       }
> +       mutex_unlock(&adev->cuid_seed_lock);
> +
> +       /* Raw bytes so the value round-trips through a write. */
> +       return seedlen;
> +}
> +
> +static ssize_t cuid_seed_store(struct device *dev,
> +                              struct device_attribute *attr,
> +                              const char *buf, size_t count)
> +{
> +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> +       struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +
> +       if (!capable(CAP_SYS_ADMIN))
> +               return -EPERM;
> +       if (count > sizeof(adev->cuid_seed))
> +               return -EINVAL;
> +
> +       mutex_lock(&adev->cuid_seed_lock);
> +       memset(adev->cuid_seed, 0, sizeof(adev->cuid_seed));
> +       memcpy(adev->cuid_seed, buf, count);
> +       adev->cuid_seed_len =3D count;
> +       mutex_unlock(&adev->cuid_seed_lock);
> +
> +       return count;
> +}
> +
> +static DEVICE_ATTR(cuid_seed, 0600, cuid_seed_show, cuid_seed_store);
> +
> +static struct attribute *amdgpu_cuid_attrs[] =3D {
> +       &dev_attr_cuid_primary.attr,
> +       &dev_attr_cuid_secondary.attr,
> +       &dev_attr_cuid_seed.attr,
> +       NULL,
> +};
> +
> +static const struct attribute_group amdgpu_cuid_group =3D {
> +       .attrs =3D amdgpu_cuid_attrs,
> +};
> +
> +int amdgpu_cuid_sysfs_init(struct amdgpu_device *adev)
> +{
> +       mutex_init(&adev->cuid_seed_lock);
> +       adev->cuid_seed_len =3D 0;
> +
> +       /* On failure the lock is torn down by amdgpu_cuid_sysfs_fini(). =
*/
> +       return sysfs_create_group(&adev->dev->kobj, &amdgpu_cuid_group);
> +}
> +
> +void amdgpu_cuid_sysfs_fini(struct amdgpu_device *adev)
> +{
> +       sysfs_remove_group(&adev->dev->kobj, &amdgpu_cuid_group);
> +
> +       memzero_explicit(adev->cuid_seed, sizeof(adev->cuid_seed));
> +       adev->cuid_seed_len =3D 0;
> +       mutex_destroy(&adev->cuid_seed_lock);
> +}

Make these amdgpu independent.  Then any device can call them.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cuid.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cuid.h
> new file mode 100644
> index 000000000000..473ba3a4ab8f
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cuid.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

MIT please.

Thanks,

Alex

> +/*
> + * CUID (Canonical Unique ID) support for amdgpu.
> + *
> + * Builds a 122-bit primary identifier from the per-GPU hardware identit=
y and
> + * exposes it as a UUIDv8, together with an HMAC-derived secondary CUID.
> + */
> +#ifndef __AMDGPU_CUID_H__
> +#define __AMDGPU_CUID_H__
> +
> +#include <linux/types.h>
> +
> +struct amdgpu_device;
> +
> +/*
> + * 122-bit primary CUID layout (frozen ABI):
> + *
> + *   0:63     Device Serial Number (amdgpu: adev->unique_id)
> + *   64:71    UnitID low 8 bits
> + *   72:79    RevisionID
> + *   80:95    DeviceID
> + *   96:111   VendorID
> + *   112:116  UnitID high 5 bits
> + *   117      Auxiliary Indicator
> + *   118:121  Component Type
> + *
> + * Packed with explicit shift/mask (not C bitfields) for a stable ABI.
> + */
> +struct cuid_primary {
> +       u64 dsn;
> +       u16 vendor_id;
> +       u16 device_id;
> +       u16 unit_id;            /* 13 bits */
> +       u8 revision_id;
> +       u8 component_type;      /* 4 bits */
> +       u8 aux;                 /* bit 117 */
> +} __packed;
> +
> +/* Component Type values (bits 118:121). */
> +#define CUID_COMPONENT_GPU     0x2
> +
> +int amdgpu_cuid_sysfs_init(struct amdgpu_device *adev);
> +void amdgpu_cuid_sysfs_fini(struct amdgpu_device *adev);
> +
> +#endif /* __AMDGPU_CUID_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 472e96ae884e..760103641592 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -48,6 +48,7 @@
>  #include <linux/vga_switcheroo.h>
>  #include <linux/efi.h>
>  #include "amdgpu.h"
> +#include "amdgpu_cuid.h"
>  #include "amdgpu_trace.h"
>  #include "amdgpu_i2c.h"
>  #include "atom.h"
> @@ -246,8 +247,16 @@ static int amdgpu_device_attr_sysfs_init(struct amdg=
pu_device *adev)
>         if (amdgpu_nbio_is_replay_cnt_supported(adev))
>                 ret =3D sysfs_create_file(&adev->dev->kobj,
>                                         &dev_attr_pcie_replay_count.attr)=
;
> +       if (ret)
> +               return ret;
>
> -       return ret;
> +       /* CUID is informational; a failure here should not fail device i=
nit. */
> +       ret =3D amdgpu_cuid_sysfs_init(adev);
> +       if (ret)
> +               dev_warn(adev->dev, "failed to create CUID sysfs attribut=
es: %d\n",
> +                        ret);
> +
> +       return 0;
>  }
>
>  static void amdgpu_device_attr_sysfs_fini(struct amdgpu_device *adev)
> @@ -255,6 +264,8 @@ static void amdgpu_device_attr_sysfs_fini(struct amdg=
pu_device *adev)
>         if (amdgpu_nbio_is_replay_cnt_supported(adev))
>                 sysfs_remove_file(&adev->dev->kobj,
>                                   &dev_attr_pcie_replay_count.attr);
> +
> +       amdgpu_cuid_sysfs_fini(adev);
>  }
>
>  static ssize_t amdgpu_sysfs_reg_state_get(struct file *f, struct kobject=
 *kobj,
> --
> 2.54.0
>
