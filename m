Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9D3C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Apr 2022 07:00:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2464910F367;
	Thu, 21 Apr 2022 07:00:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFA3810F383
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Apr 2022 06:59:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIfTkmetwHY4yoIP6lT+1lHzMqJouRNaU0Bbpc3/TuCm8EKbynWH2nW+ujv+cZnuzl3ndklm8zADrMG+ZrpOs70ImikJshfhbKk28wWmfYpVnQ8t7m7rK/BIL28CCxDJtWMj6Xg/zKXkb392MmwagE3oiS3G/4NHAH50RVVWMOtC8ka57E8jquCny7xF0vaEH00q0dqCt2geGhdWkKx3RkfGIH3euhByeLRkRDxmx3LvTcjU+yJb7rwgl5s/7LX6d7ef6PmjmvPDaK92KTBmiNk9prHgrgwW7Lt4BYCEFyRbRplQgD7L6Q7GW/c341IyP5s8OU9s3Noxys8mIkF9rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InY0aUeAzAvS3E2bea5ofqxd+9o35WGu+wjFBN8hm+M=;
 b=RVJz6xOeNArRTKtLWJKxnGkaIxwost1Jcp+BHb8Gt3JMANnYGnFoau7u+tI4IZyTZ7RS35E/eO8vhPYLcRu6O/U/kMpzbogaAaeGeaKY76o5EWlVEASMRL6lE1AKUzN4Ou4AEEF4byxFR3nIzT44GV5ImN1IjGwkGlGfNo75B+q7khvo+kQJ3ibw2i696MpWYlc63m9UC7CRTSwl9OOKqtX7dJWrmBWZsQvBnPX2/aJKVLmTmil0xPD+MDvzomPHoYMs+gGmjyv0jCIrEMX2NXbmYDnu4F0eZF0wO8TysEGVlNguvVlvRHRxT76uhjNL+U4I5kUDeQ8XwC+//lx84g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InY0aUeAzAvS3E2bea5ofqxd+9o35WGu+wjFBN8hm+M=;
 b=RAt4+an1/Ugre+s/+q5tUH30uQthdpEd5u9j3VDdxFTFmDtupMklVCIGUgXIRGutr5/P/mCsXfqVrIErPN4eDIUvhTmHNVPx3S7TEpTMs1Z2rOoioI7ZTi1cZ7Bngjq/vGeXwWFF28dqjW5sRQQVNlth1ZK0KpSCVf5TozQP4z0=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DM6PR12MB4861.namprd12.prod.outlook.com (2603:10b6:5:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 06:59:56 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::6191:648d:c4a:dff]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::6191:648d:c4a:dff%7]) with mapi id 15.20.5164.026; Thu, 21 Apr 2022
 06:59:56 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 2/2] drm/amdgpu: Add debugfs TA load/unload/invoke
 support
Thread-Topic: [PATCH v2 2/2] drm/amdgpu: Add debugfs TA load/unload/invoke
 support
Thread-Index: AQHYVKfNzBDPxWfm3Ua4JVBiIMYniqz58Mjw
Date: Thu, 21 Apr 2022 06:59:55 +0000
Message-ID: <DM5PR12MB17706C49AC35D675D5B153DEB0F49@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220420111357.9488-1-candice.li@amd.com>
 <20220420111357.9488-2-candice.li@amd.com>
In-Reply-To: <20220420111357.9488-2-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7418c4e5-2b46-48eb-4aa4-08da23648af4
x-ms-traffictypediagnostic: DM6PR12MB4861:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4861852ED58C1C454019239AB0F49@DM6PR12MB4861.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wQyTHg3NyF8ax4x8DmBUlv2K04O5bjJ+nNr7FeSQ859amQpGuKQvsO51o5K7P9r/jYwfW9xNMvlq5BMoUvU9kO+KF3Kzm9nfSzP6GoiECtkWOvPjmR+0IDDmkB3z7SSM76A3AD+JyE9V2EBk42w2t+59COoPRDCf4AXCNYDrUrYtwrIVnhbXIyiWU13RB55iqWSUXlAB35eDFCWz+NXHigvza05UsMmrLksQX3tZCJBE9dZ7ZgVQGoQ0c50MmPdmbExt7UVtK4xyyioAMHieeYvLukI1NrYkjtIPf3XaroloVKjBwxSqaRmpHKHDuTJPzh0SFT0eeZjrNSGaqk+MY4sA+OJtcFLDJRTvLgo3CBujTthYa3CdlqGg8iigrAY2OAsnHOThU8ZDbesCVK60EAzQ3M1Hm4xd0pjtB8vF5YGfwyBoZbRnI3SWCAGHXRdhNJ7H7KAbAIUhV0hKukbDdsTlWKTM7Zn7Uvhy4hVNlMLHWzsGAp8YIjvj7dn+SyrY4gZrByIdISSCy3vTYkJyPu3wGFgk94UyJnona6e22pLY9EI1ARhD9esY6JsQCP9mNAFHvz9LpU+2OeqVmtwuB5xrMRIGR7iJKqYKilL5lxdKWUmUSBWnuS4xpHSNrgiVS73C/RgNwEIeRNOf4zj45gXTzqDQ926DEeF150iQG9JsV7KB2DXbI9gRPUNkQ4umZda7pVzWyng50vRbunLmZ1L2N7Cwi+FeTzArc1H5Cho=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(186003)(38070700005)(316002)(83380400001)(53546011)(6506007)(86362001)(7696005)(9686003)(54906003)(110136005)(66446008)(4326008)(76116006)(64756008)(8676002)(66476007)(66946007)(66556008)(5660300002)(71200400001)(38100700002)(8936002)(122000001)(52536014)(2906002)(30864003)(33656002)(55016003)(508600001)(461764006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/6SIBbKEpNQMFWs51eBNDHzYsl75/Jl+rCQ1vxQqnSFSjqeWa7j7l7FewNeL?=
 =?us-ascii?Q?sjwFSJwzNkA1h8LTbHTSnggLx6xH2JA9JZmqo3HxSV8g+OTxL5NMRV9jCXYG?=
 =?us-ascii?Q?z80uREZM4Uf71HxyDz4drTgJcbGxeH/gKtUSkhaCkdQmS4ba/yCWiwZWzOWQ?=
 =?us-ascii?Q?XaN3isku+iPX8FUbDExFxOvTpQuH1Fh2NkE9DYrqC334okqUFiBLEMH353ps?=
 =?us-ascii?Q?GJTV8hggWqRHmtAgH3qKfeS4c2YfOBn7g5tWpsnU57nzWzWk2dLfedNBl1+G?=
 =?us-ascii?Q?hHE+He1o6QdPwXKmNMj9Ltg9hM5ZGVj+s4jmBKyKUna9fAyZqywGYInIrNhl?=
 =?us-ascii?Q?MI6CVukYYU9t09HtW2fKbB9kFNJ847Oo3At00N5Hxaak4EijqL+dGmqNKBC7?=
 =?us-ascii?Q?aw0vX80emeZon4LiD1S0Znq1zM/HYYipx3P8QZRxNy670YRGOlJhruXD7Ac3?=
 =?us-ascii?Q?Gzz2CcnX36Ck5J6q5kYaszmyShCk7M8zdUaA9XqbGQapek01x6KysDx6Y1fb?=
 =?us-ascii?Q?d1ffz1tguq831h9L2MKdMRuVV2R5HG5L5Wd2IJZl2bWqURxSBwS7q856UXDV?=
 =?us-ascii?Q?xwy2Dr9/aQ0jVRGsj6veVpjXN3pVycovvmN+2VdVNv7eE43+farAK29pEVDz?=
 =?us-ascii?Q?jBHrkewrYlK9VuOvz9uQx0m2uHYT1oCNzbNe0D7nDv234lKn+Zc8/ejgg2qH?=
 =?us-ascii?Q?4HCDCfHn9VW82hmfnBRwnKBL42OoFTNmwt3G90Y4IHYswpIYYlYWPLHQ8rPL?=
 =?us-ascii?Q?xCx6wejtxbgIbsdQfXcW5TkKm1v9jUUlvxNP/LinLN8n+C9DXgsMe8vHWQ4Q?=
 =?us-ascii?Q?9PnZoV/uVNJSxF/oSoGtBVEwMjkkw0EslpDqnLcpN0aXIFUQ4wvbRTkzENIY?=
 =?us-ascii?Q?gMt+HkeX8LYphNAmccWAGccb/GAGNgl9XBrY0nv7Nq/P7tIykMNCeijdyHbN?=
 =?us-ascii?Q?HQOMhdpmuHg59pQnXee5t9Z5a0V5sW1HGY5KIWPt3P8cnchqKd/+RhUDZG1V?=
 =?us-ascii?Q?9W9uMtDRNQVCBgIeCM5SZQlR54xJcsFBk87OlWKsD7EIxIXAAohmL9BX/puK?=
 =?us-ascii?Q?2wha8AgxZnl3ZhaWrWCgAXmgx7Cpa9zTRPPOrI0w4YgbVLAPOJ4nPLCdR2zq?=
 =?us-ascii?Q?KpmIzDZpX7aZoWakXP64rfFi2CBSe0v2BbWFVadiyedliRwUY1tYWlO9IdGS?=
 =?us-ascii?Q?pSljazTRgpvaKK8F/Bs/eOBqzldlpjTkucNC5QfxKnCft6FWcT2bf1yZiGjG?=
 =?us-ascii?Q?HPGh8YX5/de7MV/ewgbYaiyd2VBqp4H4Cqb2b7chmLMK8+xyiwChfZVlIZlQ?=
 =?us-ascii?Q?u6L6+06KFOvonxgKxzbMNQg6dAnVAuDdbi2oePWaj/DlPaJ6IciW40dRRk4s?=
 =?us-ascii?Q?hmcl24Q1jV62a5DKW8ine/mrAGUTl+9zGaHeI1KgnZwaxBpvXOyKVkL2Kn01?=
 =?us-ascii?Q?A08RtSqklBuaDh5OE0OiqCI6EijivCge08vxMnua5LWDgZrLL7uATq3tgcCx?=
 =?us-ascii?Q?i+S3AcP+4eW0f6skrqQ068MwR5Jhi7P4sMSoCi4aLaJ6L0cWkhPqbmyuupyu?=
 =?us-ascii?Q?p/AFJb/G0uhAbId7iMpQv9FX4DuDwOOBda7casu+RvnoPeTGwL00mazdQbfH?=
 =?us-ascii?Q?ImgOzfMtznSTF8QJijebBcoJ2zh9pPXYNlI8lSjo+72PjHeF2KInXq2e3Nne?=
 =?us-ascii?Q?SCV67JrWXSiyWKozEH+VDM2irVHX3XpcDh9b8DViiHVjSmux?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7418c4e5-2b46-48eb-4aa4-08da23648af4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 06:59:55.3502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dVcsE1MkCg3QC/1rM0XoIQ+X3So0Z8S/91A/vUIzHiCy2ngDyqYmycSKkyxolgQS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4861
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
Cc: "Li, Candice" <Candice.Li@amd.com>, "Clements,
 John" <John.Clements@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

Make sure the series is checked by checkpatch.pl.

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candic=
e
> Li
> Sent: Wednesday, April 20, 2022 7:14 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Li, Candice <Candice.Li@amd.com>; Clements, John
> <John.Clements@amd.com>
> Subject: [PATCH v2 2/2] drm/amdgpu: Add debugfs TA load/unload/invoke
> support
>=20
> v1:
> Add debugfs support to load/unload/invoke TA in runtime.
>=20
> v2:
> 1. Update some variables to static.
> 2. Use PAGE_ALIGN to calculate shared buf size directly.
> 3. Remove fp check.
> 4. Update debugfs from read to write.
>=20
> Signed-off-by: John Clements <john.clements@amd.com>
> Signed-off-by: Candice Li <candice.li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c  | 308
> ++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h  |
> 30 ++
>  4 files changed, 341 insertions(+), 1 deletion(-)  create mode 100644
> drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
> b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 7d7af43a258f83..b525f9be9326f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -58,7 +58,7 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_kms.o \
>  	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o
> amdgpu_nbio.o \
>  	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o
> amdgpu_rap.o \
>  	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
> -	amdgpu_eeprom.o amdgpu_mca.o
> +	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o
>=20
>  amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 13e4d8f9b87449..eedb12f6b8a32d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -38,6 +38,7 @@
>  #include "amdgpu_umr.h"
>=20
>  #include "amdgpu_reset.h"
> +#include "amdgpu_psp_ta.h"
>=20
>  #if defined(CONFIG_DEBUG_FS)
>=20
> @@ -1767,6 +1768,7 @@ int amdgpu_debugfs_init(struct amdgpu_device
> *adev)
>  		DRM_ERROR("registering register debugfs failed (%d).\n", r);
>=20
>  	amdgpu_debugfs_firmware_init(adev);
> +	amdgpu_ta_if_debugfs_init(adev);
>=20
>  #if defined(CONFIG_DRM_AMD_DC)
>  	if (amdgpu_device_has_dc_support(adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> new file mode 100644
> index 00000000000000..247a476e63544c
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> @@ -0,0 +1,308 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person
> +obtaining a
> + * copy of this software and associated documentation files (the
> +"Software"),
> + * to deal in the Software without restriction, including without
> +limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> +sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom
> +the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> +included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> +EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> +MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT
> +SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> +DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> +OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> USE
> +OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include "amdgpu.h"
> +#include "amdgpu_psp_ta.h"
> +
> +static const char *TA_IF_FS_NAME =3D "ta_if";
> +
> +struct dentry *dir;
> +static struct dentry *ta_load_debugfs_dentry; static struct dentry
> +*ta_unload_debugfs_dentry; static struct dentry
> +*ta_invoke_debugfs_dentry;
> +
> +static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf=
,
> +					    size_t len, loff_t *off);
> +static ssize_t ta_if_unload_debugfs_write(struct file *fp, const char *b=
uf,
> +					    size_t len, loff_t *off);
> +static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *b=
uf,
> +					    size_t len, loff_t *off);
> +
> +
> +static uint32_t get_bin_version(const uint8_t *bin) {
> +	const struct common_firmware_header *hdr =3D
> +			     (const struct common_firmware_header *)bin;
> +
> +	return hdr->ucode_version;
> +}
> +
> +static void prep_ta_mem_context(struct psp_context *psp,
> +					     struct ta_context *context,
> +					     uint8_t *shared_buf,
> +					     uint32_t shared_buf_len)
> +{
> +	context->mem_context.shared_mem_size =3D
> PAGE_ALIGN(shared_buf_len);
> +	psp_ta_init_shared_buf(psp, &context->mem_context);
> +
> +	memcpy((void *)context->mem_context.shared_buf, shared_buf,
> +shared_buf_len); }
> +
> +static bool is_ta_type_valid(enum ta_type_id ta_type) {
> +	bool ret =3D false;
> +
> +	switch (ta_type) {
> +	case TA_TYPE_RAS:
> +		ret =3D true;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct file_operations ta_load_debugfs_fops =3D {
> +	.write   =3D ta_if_load_debugfs_write,
> +	.llseek =3D default_llseek,
> +	.owner  =3D THIS_MODULE
> +};
> +
> +static const struct file_operations ta_unload_debugfs_fops =3D {
> +	.write   =3D ta_if_unload_debugfs_write,
> +	.llseek =3D default_llseek,
> +	.owner  =3D THIS_MODULE
> +};
> +
> +static const struct file_operations ta_invoke_debugfs_fops =3D {
> +	.write   =3D ta_if_invoke_debugfs_write,
> +	.llseek =3D default_llseek,
> +	.owner  =3D THIS_MODULE
> +};
> +
> +
> +/**
> + * DOC: AMDGPU TA debugfs interfaces
> + *
> + * Three debugfs interfaces can be opened by a program to
> + * load/invoke/unload TA,
> + *
> + * - /sys/kernel/debug/dri/<N>/ta_if/ta_load
> + * - /sys/kernel/debug/dri/<N>/ta_if/ta_invoke
> + * - /sys/kernel/debug/dri/<N>/ta_if/ta_unload
> + *
> + * How to use the interfaces in a program?
> + *
> + * A program needs to provide transmit buffer to the interfaces
> + * and will receive buffer from the interfaces below,
> + *
> + * - For TA load debugfs interface:
> + *   Transmit buffer:
> + *    - TA type (4bytes)
> + *    - TA bin length (4bytes)
> + *    - TA bin
> + *   Receive buffer:
> + *    - TA ID (4bytes)
> + *
> + * - For TA invoke debugfs interface:
> + *   Transmit buffer:
> + *    - TA ID (4bytes)
> + *    - TA CMD ID (4bytes)
> + *    - TA shard buf length (4bytes)
> + *    - TA shared buf
> + *   Receive buffer:
> + *    - TA shared buf
> + *
> + * - For TA unload debugfs interface:
> + *   Transmit buffer:
> + *    - TA ID (4bytes)
> + */
> +
> +static ssize_t ta_if_load_debugfs_write(struct file *fp, const char
> +*buf, size_t len, loff_t *off) {
> +	uint32_t ta_type    =3D 0;
> +	uint32_t ta_bin_len =3D 0;
> +	uint8_t  *ta_bin    =3D NULL;
> +	uint32_t copy_pos   =3D 0;
> +	int      ret        =3D 0;
> +
> +	struct amdgpu_device *adev   =3D (struct amdgpu_device *)file_inode(fp)=
-
> >i_private;
> +	struct psp_context   *psp    =3D &adev->psp;
> +	struct ta_context    context =3D {0};
> +
> +	if (!buf)
> +		return -EINVAL;
> +
> +	ret =3D copy_from_user((void *)&ta_type, &buf[copy_pos],
> sizeof(uint32_t));
> +	if (ret || (!is_ta_type_valid(ta_type)))
> +		return -EINVAL;
> +
> +	copy_pos +=3D sizeof(uint32_t);
> +
> +	ret =3D copy_from_user((void *)&ta_bin_len, &buf[copy_pos],
> sizeof(uint32_t));
> +	if (ret)
> +		return -EINVAL;
> +
> +	copy_pos +=3D sizeof(uint32_t);
> +
> +	ta_bin =3D kzalloc(ta_bin_len, GFP_KERNEL);
> +	if (!ta_bin)
> +		ret =3D -ENOMEM;
> +	ret =3D copy_from_user((void *)ta_bin, &buf[copy_pos], ta_bin_len);
> +	if (ret)
> +		goto err_free_bin;
> +
> +	ret =3D psp_ras_terminate(psp);
> +	if (ret) {
> +		dev_err(adev->dev, "Failed to unload embedded RAS TA\n");
> +		goto err_free_bin;
> +	}
> +
> +	context.ta_type             =3D ta_type;
> +	context.ta_load_type        =3D GFX_CMD_ID_LOAD_TA;
> +	context.bin_desc.fw_version =3D get_bin_version(ta_bin);
> +	context.bin_desc.size_bytes =3D ta_bin_len;
> +	context.bin_desc.start_addr =3D ta_bin;
> +
> +	ret =3D psp_ta_load(psp, &context);
> +
> +	if (ret || context.resp_status) {
> +		dev_err(adev->dev, "TA load via debugfs failed (%d)
> status %d\n",
> +			 ret, context.resp_status);
> +		goto err_free_bin;
> +	}
> +
> +	context.initialized =3D true;
> +	ret =3D copy_to_user((char *)buf, (void *)&context.session_id,
> +sizeof(uint32_t));
> +
> +err_free_bin:
> +	kfree(ta_bin);
> +
> +	return ret;
> +}
> +
> +static ssize_t ta_if_unload_debugfs_write(struct file *fp, const char
> +*buf, size_t len, loff_t *off) {
> +	uint32_t ta_id  =3D 0;
> +	int      ret    =3D 0;
> +
> +	struct amdgpu_device *adev   =3D (struct amdgpu_device *)file_inode(fp)=
-
> >i_private;
> +	struct psp_context   *psp    =3D &adev->psp;
> +	struct ta_context    context =3D {0};
> +
> +	if (!buf)
> +		return -EINVAL;
> +
> +	ret =3D copy_from_user((void *)&ta_id, buf, sizeof(uint32_t));
> +	if (ret)
> +		return -EINVAL;
> +
> +	context.session_id =3D ta_id;
> +
> +	ret =3D psp_ta_unload(psp, &context);
> +	if (!ret)
> +		context.initialized =3D false;
> +
> +	return ret;
> +}
> +
> +static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char
> +*buf, size_t len, loff_t *off) {
> +	uint32_t ta_id          =3D 0;
> +	uint32_t cmd_id         =3D 0;
> +	uint32_t shared_buf_len =3D 0;
> +	uint8_t	 *shared_buf    =3D NULL;
> +	uint32_t copy_pos       =3D 0;
> +	int      ret            =3D 0;
> +
> +	struct amdgpu_device *adev   =3D (struct amdgpu_device *)file_inode(fp)=
-
> >i_private;
> +	struct psp_context   *psp    =3D &adev->psp;
> +	struct ta_context    context =3D {0};
> +
> +	if (!buf)
> +		return -EINVAL;
> +
> +	ret =3D copy_from_user((void *)&ta_id, &buf[copy_pos], sizeof(uint32_t)=
);
> +	if (ret)
> +		return -EINVAL;
> +	copy_pos +=3D sizeof(uint32_t);
> +
> +	ret =3D copy_from_user((void *)&cmd_id, &buf[copy_pos],
> sizeof(uint32_t));
> +	if (ret)
> +		return -EINVAL;
> +	copy_pos +=3D sizeof(uint32_t);
> +
> +	ret =3D copy_from_user((void *)&shared_buf_len, &buf[copy_pos],
> sizeof(uint32_t));
> +	if (ret)
> +		return -EINVAL;
> +	copy_pos +=3D sizeof(uint32_t);
> +
> +	shared_buf =3D kzalloc(shared_buf_len, GFP_KERNEL);
> +	if (!shared_buf)
> +		ret =3D -ENOMEM;
> +	ret =3D copy_from_user((void *)shared_buf, &buf[copy_pos],
> shared_buf_len);
> +	if (ret)
> +		goto err_free_shared_buf;
> +
> +	context.session_id =3D ta_id;
> +
> +	prep_ta_mem_context(psp, &context, shared_buf, shared_buf_len);
> +
> +	ret =3D psp_ta_invoke_indirect(psp, cmd_id, &context);
> +
> +	if (ret || context.resp_status) {
> +		dev_err(adev->dev, "TA invoke via debugfs failed (%d)
> status %d\n",
> +			 ret, context.resp_status);
> +		goto err_free_ta_shared_buf;
> +	}
> +
> +	ret =3D copy_to_user((char *)buf, context.mem_context.shared_buf,
> +shared_buf_len);
> +
> +err_free_ta_shared_buf:
> +	psp_ta_free_shared_buf(&context.mem_context);
> +
> +err_free_shared_buf:
> +	kfree(shared_buf);
> +
> +	return ret;
> +}
> +
> +static struct dentry *amdgpu_ta_if_debugfs_create(struct amdgpu_device
> +*adev) {
> +	struct drm_minor *minor =3D adev_to_drm(adev)->primary;
> +
> +	dir =3D debugfs_create_dir(TA_IF_FS_NAME, minor->debugfs_root);
> +
> +	ta_load_debugfs_dentry =3D debugfs_create_file("ta_load", 0200, dir,
> adev,
> +						     &ta_load_debugfs_fops);
> +
> +	ta_unload_debugfs_dentry =3D debugfs_create_file("ta_unload", 0200, dir=
,
> +						     adev,
> &ta_unload_debugfs_fops);
> +
> +	ta_invoke_debugfs_dentry =3D debugfs_create_file("ta_invoke", 0200, dir=
,
> +						     adev,
> &ta_invoke_debugfs_fops);
> +	return dir;
> +}
> +
> +void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev) { #if
> +defined(CONFIG_DEBUG_FS)
> +	dir =3D amdgpu_ta_if_debugfs_create(adev);
> +#endif
> +}
> +
> +void amdgpu_ta_if_debugfs_remove(void)
> +{
> +	debugfs_remove_recursive(dir);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h
> new file mode 100644
> index 00000000000000..883f89d57616d0
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h
> @@ -0,0 +1,30 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person
> +obtaining a
> + * copy of this software and associated documentation files (the
> +"Software"),
> + * to deal in the Software without restriction, including without
> +limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> +sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom
> +the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> +included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> +EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> +MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT
> +SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> +DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> +OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> USE
> +OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __AMDGPU_PSP_TA_H__
> +#define __AMDGPU_PSP_TA_H__
> +
> +void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev); void
> +amdgpu_ta_if_debugfs_remove(void);
> +
> +#endif
> --
> 2.17.1

