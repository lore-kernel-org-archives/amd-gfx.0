Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1B3EA795C
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 03:34:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F9A510E1D7;
	Thu,  5 Feb 2026 03:34:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qqSWaSkD";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012024.outbound.protection.outlook.com
 [40.93.195.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FBF210E1D7
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 03:34:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ycyBf37q1FP52jrqxxMq1IhZryZsB0PAS44gDK3Fa5voZwgDlYOtcREdbDwi+yUUqFj5g5ClJLbcwMVWWm2gz49Ga1ss8Aj3YvKGCZtMAwIz67lPindQHWlPWbn2cCoS0O09tvkmV5v3KzFCWt+d9mHBlkodXuxM/6wVgC6RWyUeY5/Rw07QKYq1BKP/QGYmx8nAAD/JhutILJpfdyoXrLzf4ejDUQmQf5nM2hSozVXq19zYUOid+m+z/iGMW7kGYaKSET+Ksyue2V1BbE2GDkuEsKCtkETJr3JQmDEHW8T/JrrvnGUJSOWf7D4qCKsCHZQgbKs0L23Xu0pLELqgKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bt0dO3HIpuk1aCzRpvODJgP9/QMfO2Wvicg0RB6fnk=;
 b=o7kl9Gu8NRckSF5TWROB7chF/LwKtrOeHTSHMJfn/ajqjs+qW1JAuF+BdoXCd04GdPqs099XKZP5KknXBlaU/o/r9ue0lidu+c+McvYWYginlY7S1MV8N877SKsfRXVGsF8U1e+t06sH1rCb4KGvYjnyJxbLS3N8r59F8QWe9AL+DyxaXilgIBwJw+0CxHUD6KZlt/9P5jiRycpY1fXi3vKEPsu5jMg6fM6Ov7gtfrK5rImMuswHe6pNYE/A0GeGbiBCoEJmYD7J9X1vY/dfCA5tKOJxxPGsdlhR1m3V0TpqEjEIMGnbeQvjH+7ZA9zG8F8X9nQUySfpLav6WGGvkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bt0dO3HIpuk1aCzRpvODJgP9/QMfO2Wvicg0RB6fnk=;
 b=qqSWaSkDweiYGgZfYdkxwet+a+y5zM57TFNxRZRjRu1Xr/Z+BxzrV5A9/I2hLzHWu/rm9Hdx/gV9nCyPq7LpodbBQgK2itW2CM8QnemXFDsenT3MlL4pmkDg/6s6fE3GhcFFFUXJw73h7mL7lEJ5VHl2msZhHRfbrWwGHc+awUw=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 03:34:27 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%6]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 03:34:26 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Send applicable RMA CPERs at end of RAS init
Thread-Topic: [PATCH] drm/amdgpu: Send applicable RMA CPERs at end of RAS init
Thread-Index: AQHclf75t5xMwMd4lEO6MLbcU58/wbVzc/+A
Date: Thu, 5 Feb 2026 03:34:26 +0000
Message-ID: <PH7PR12MB8796EB4380000027BC6226E4B099A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260204175151.536589-1-kent.russell@amd.com>
In-Reply-To: <20260204175151.536589-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-05T03:32:03.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SA1PR12MB7343:EE_
x-ms-office365-filtering-correlation-id: 07cc704d-e7c1-43f3-1e1c-08de646776ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?t5FViSAWawSz6m30S07g4GRNozj0enAcb23jVpS9aGLT9lCjYS6ns40xy7ar?=
 =?us-ascii?Q?AP6NtIxghO4fcfT+94sO0ciEILq5DqtO1eaaOT7cZ2OeZUjE3nw+GNwk+NiP?=
 =?us-ascii?Q?RWbe56L2hD4lyK3igwFg2Kb3aBJLb2zn0BjSK9sjv0rqKAroT9FGgwGkOL9K?=
 =?us-ascii?Q?/jAqiaEb5i/KYROJaESBQOa0FhkMe7Ofic8ZQcFDG0X/tXjOGHEcCONcCCQc?=
 =?us-ascii?Q?JWge0k2zW+Fh1m9OWVIzzXrBV7U+zYCZ1s4OYp1vmvX3477s7nCKlFsHukej?=
 =?us-ascii?Q?WPAGYpsQ00vf1NBVbScb+QuzRf4tJkZfbj8cj/Wgv3cuzX0Udq6Vug2+iYiW?=
 =?us-ascii?Q?46A2F6jHudKa2ILgUWTM3b+UIeHF5pepWy9TfecTr9NNWRYapUyAaWhFhJew?=
 =?us-ascii?Q?kEAg8jLQrVroNom2d8wsH400IUrQk4i9ZYKkMD7pBM34kSU0S5f9iyYeKuyw?=
 =?us-ascii?Q?P9ss/q52FnRE91HtUPzPl8/S/T8jV0kfahS1GunFTdlvSG2V7HxYqOSjKwgR?=
 =?us-ascii?Q?vs7zUibOeIOWziJKxAxnt2D972IupwkzU6CMvD44CTNtegmqyK9y+e6PGNHp?=
 =?us-ascii?Q?U80mDOEsTQbkGVma3mjwj+760RtpQuDmLKqDaU17WFuzVCEqU9PqOwhJxZOy?=
 =?us-ascii?Q?FKv93Ox6F9oxhN0qzYLpHYNvg+SNWfUw2DUkkniUgwhq8v4gL9IR3yVcN/bf?=
 =?us-ascii?Q?vXCE8z4tdWPKOigjNvRCqXNhB+sKqW9t3/w9xMbe2UacQZlnrSZjQMNxjmny?=
 =?us-ascii?Q?e01vCKluxYvK7aFCn2jdszYJhNd42bAEWXbZsqyDrjFx4YqrD7EnxYDz0SrY?=
 =?us-ascii?Q?W3hXmZTGIygBZKrQMvUKkfWGHJNF8Sh5pRs0ZCeEb6ZPn0IbqrOI2sdEBinl?=
 =?us-ascii?Q?eZsi2MwZrnVZ0KuUf0JmkavSHMk5EqhVTm4cDMVr3f4F1honbrtdbHHL6MiN?=
 =?us-ascii?Q?liKR6t1xl79nz5VzZq1eKjxzXH2VDus7kcoIIrXHUv8oK7OXWgXthb3DILrz?=
 =?us-ascii?Q?lU4VZ1cbT6yCX9rNNmPs9UCxi4lGttXDLRCeWn3rdD3ygcbLXNJw180vzAMH?=
 =?us-ascii?Q?FCbNcoTERV2BupAYU/wQqFfvMTl1lrB4tvHRbGbO9djws7lZ/ISodA4B1OBj?=
 =?us-ascii?Q?SzjXYao8yDsQIzeVgpTWLZeock3nIw/6z4YbW9NbKn6RSQD8a60YYN7pvIpV?=
 =?us-ascii?Q?zZns8fZ2QipPmXUIeBZ4zNqCVkFnwE2qBWMCnr9npKZq1s9HSfiF1UrhZJ8I?=
 =?us-ascii?Q?kFRd9J0QtzUeETHQhbM2Rcf6bKiFdOxzIMXOew6nCb/cRtDSqyFExlFWjGp3?=
 =?us-ascii?Q?wxXQfymeah35g92IhS09LDVpcFfSluVT3dwYxEGKo1NftxK37aGkGGNl6KmT?=
 =?us-ascii?Q?WKommbxDhqjLq2LW0NcmrD0QroOl8TiQ7O95BS4DSg502+p39hXlvGpJiEZH?=
 =?us-ascii?Q?4pctYsHrwKS/oOkPTjxFHIZj0uvcLWsb3x6DHUOSxCBb8laD1rmjz38k2olB?=
 =?us-ascii?Q?1d3266qnAvwvgJ2yxK1vNYvu7sfHUKSs6OtjJ73bOLX4xCjaMjd6h8N+7KR6?=
 =?us-ascii?Q?u0DcPbRUq4K33LaHWK5TIQ4vabVnYZAT/ko9a/XGOOmgH+1LVrbua11SStIW?=
 =?us-ascii?Q?JZ1DtzTqzNgRROZm32p96EQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B/JWdIN6kPtsn9dyh+63/OgbADKB9Vo4BjvQNi/VBLCSb2Hyl8yncKqoZWo+?=
 =?us-ascii?Q?PbpbuWbXMFidgYnx+RZZxVVcC0rLgNcAIQydVX+gUHSPjnjCyAG5NUhNU0u+?=
 =?us-ascii?Q?QXCdgf611PwM45ijMd4mPddAlA+TlX/YuZWt6w/5AKjHKCwLS8rSGmAlJAHV?=
 =?us-ascii?Q?atILD3O+dT0fmrH0xT36Bmp/Gz4pavkFrStNoxW3d9PFLMU4SuNLHvNjrrmT?=
 =?us-ascii?Q?EiD1feVI1RvRMuaZ81OyZTfDJzGFZCbx9OcHiGRC+OhrQ/WbbUisbteirBm7?=
 =?us-ascii?Q?+00U4brQ2mXj/W86qcXAZVbqpoYscY5GiuvQqnRiO4R5ulNPHhrBw6UQMyoA?=
 =?us-ascii?Q?Tc5agdAUXyVnB8Qj1X2qq213iY5o7OwHu0Ax/+xJmFlLnzF9k+ygqFw/mdev?=
 =?us-ascii?Q?8lPpPQWtMZK3sde+tLb+kRFUe0rUzjJXkumx0wcAnn5752zAl+l7m43rBmOH?=
 =?us-ascii?Q?uhAaywEnlIL/EU4cyQGUQsOE+6X4voN1oWhCLqNUu7y9mCJCtkj4Nnrx+7CM?=
 =?us-ascii?Q?R4iacGit1WeO0wFGfZ+ym4k/eHcmonxuhtRws3uCCSbrTcniwDKzJ9DFEhc3?=
 =?us-ascii?Q?XES7qwPDCqG6tI2dhF7Hu6U87Jlqi+6pd4n7tCpoqLhT8xH0kipCaWRZMY9I?=
 =?us-ascii?Q?DFnDvFzHx751zNYVMcPyuRrcyd2Vwdrqz0vXMatqt5gmKVbdABK1AW6jjkhp?=
 =?us-ascii?Q?1LoAZEzZg6Qg31VOgd7qbs8ZKuyYIJBLbqX8TEH66VzUWDpXWqL/RtzvdzIf?=
 =?us-ascii?Q?Olf8+gz+nuklDq9b96z9N00HlCqeGv9xNRISxjsYdf+9OoWWGI1E/AdMCuiA?=
 =?us-ascii?Q?m6WPj4GzwRGMwIu/x4n3xnWDGgmQFbgRPitB5rsbCStqOHQ9Bygzzge+uhrW?=
 =?us-ascii?Q?NxqIT00F7xaV6KNdYLgFyMKP7mj1SArOoeM7cav3qDpstVdQ9WqECYRlPYmP?=
 =?us-ascii?Q?RPNI5SO3cYLNnXunGNBwe57az3ctrNRmcRK2HlkY0HE8+eqbeWZG27Qc0Ry1?=
 =?us-ascii?Q?S7x9xZ+8286uKpVANYLvmCR1b3VDDgj5LpcLQNY+PtblK/aCnnll7Mr6NSnp?=
 =?us-ascii?Q?nxfID9//kTF10T58vW52Qh3o6tumf+lZeISuKXDn/V6QPYbVcPpZaD1nQbg0?=
 =?us-ascii?Q?kjhn1WnHPPxU0y28+aElkouf1Q/EalFo9hafOlwZ93Vd2cAeV4PeYcIKvnWS?=
 =?us-ascii?Q?SpfVaOZoXrgZjMPbRtu5Clb5h6aMhbDVEgn+guHjnR2ErEWU7vu1zw/huyWJ?=
 =?us-ascii?Q?4KBkc9jW3agWES/2ZWevRvGKQTxNXOm70B1Qt1EJuF6lgymm6D6asVCjcqHn?=
 =?us-ascii?Q?8YMtUotnuFtntOtLVs783PqijZJ3syxAOJWWrKaeHGWekKhsenBDISfb0LEF?=
 =?us-ascii?Q?BqdwuNBI+4kWD1bSPUT6bfW0tvK2olP9wK/LVTz+aXqCJLBO6BAZesuUFmdQ?=
 =?us-ascii?Q?itYiMKwrz8WNwPjMn7UWvEgSfU1K4DEnMtWXjTgCynz5gl2qBG/QIjW0FiCy?=
 =?us-ascii?Q?iQbX+roVFOGzDjFPWj6EFzsOegLtI6qCbzGPODU4pNWX/kP+3U3xgpoTG2IR?=
 =?us-ascii?Q?HyhXqA2X8vvq2dq+qCDaul/rXkdhEvsLWUSwhp9gG8KKFlfK2mqMZaullx2M?=
 =?us-ascii?Q?EiZbrcDibtSTGyRUkPrYH9BhcoO8TOKc5d8E21cs/G2P1rtumJWz9jANQHD3?=
 =?us-ascii?Q?RnRsvbc1bjAqldf4M66+Zum5Z42OtI+F9/vTZQs7lve1GwSD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cc704d-e7c1-43f3-1e1c-08de646776ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 03:34:26.8454 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VE0oY9uAGr54Y2xIpSm+eyjrnFP6HssFsdlpfs4kSfBvXNEk6OawQar7tBTeLVTx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7343
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

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Russell, Kent <Kent.Russell@amd.com>
> Sent: Thursday, February 5, 2026 1:52 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Liu, Xiang(Dean) <Xiang.Liu@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;
> Russell, Kent <Kent.Russell@amd.com>
> Subject: [PATCH] drm/amdgpu: Send applicable RMA CPERs at end of RAS init
>
> Firmware and monitoring tools may not be ready to receive a CPER when we =
read
> the bad pages, so send the CPERs at the end of RAs initialization to ensu=
re that the

[Tao] RAs -> RAS

> FW is ready to receive and process the CPER. This removes the previous CP=
ER
> submission that was added during bad page load, and sends both in-band an=
d out-
> of-band at the same time.
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  2 ++
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 27 ++++++++++++++++---
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 ++
>  3 files changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index b28fcf932f7e..856b1bf83533 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -4650,6 +4650,8 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev=
)
>                       amdgpu_ras_block_late_init_default(adev, &obj->ras_=
comm);
>       }
>
> +     amdgpu_ras_check_bad_page_status(adev);
> +
>       return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 469d04a39d7d..91de4085a66d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1712,10 +1712,6 @@ int amdgpu_ras_eeprom_check(struct
> amdgpu_ras_eeprom_control *control)
>                       dev_warn(adev->dev, "RAS records:%u exceeds 90%% of
> threshold:%d",
>                                       control->ras_num_bad_pages,
>                                       ras->bad_page_cnt_threshold);
> -             if (amdgpu_bad_page_threshold !=3D 0 &&
> -                     control->ras_num_bad_pages >=3D ras-
> >bad_page_cnt_threshold)
> -                     amdgpu_dpm_send_rma_reason(adev);
> -
>       } else if (hdr->header =3D=3D RAS_TABLE_HDR_BAD &&
>                  amdgpu_bad_page_threshold !=3D 0) {
>               if (hdr->version >=3D RAS_TABLE_VER_V2_1) { @@ -1932,3
> +1928,26 @@ int amdgpu_ras_smu_erase_ras_table(struct amdgpu_device *adev=
,
>                                                                          =
result);
>       return -EOPNOTSUPP;
>  }
> +
> +void amdgpu_ras_check_bad_page_status(struct amdgpu_device *adev) {
> +     struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> +     struct amdgpu_ras_eeprom_control *control =3D ras ? &ras->eeprom_co=
ntrol
> +: NULL;
> +
> +     if (!control || amdgpu_bad_page_threshold =3D=3D 0)
> +             return;
> +
> +     if (control->ras_num_bad_pages >=3D ras->bad_page_cnt_threshold) {
> +             if (amdgpu_dpm_send_rma_reason(adev))
> +                     dev_warn(adev->dev, "Unable to send in-band RMA CPE=
R");

[Tao] this is oob cper and the following one is ib cper.

With my concerns fixed, the patch is:  Reviewed-by: Tao Zhou <tao.zhou1@amd=
.com>

> +             else
> +                     dev_dbg(adev->dev, "Sent in-band RMA CPER");
> +
> +             if (adev->cper.enabled && !amdgpu_uniras_enabled(adev)) {
> +                     if (amdgpu_cper_generate_bp_threshold_record(adev))
> +                             dev_warn(adev->dev, "Unable to send out-of-=
band
> RMA CPER");
> +                     else
> +                             dev_dbg(adev->dev, "Sent out-of-band RMA CP=
ER");
> +             }
> +     }
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> index 2e5d63957e71..a62114800a92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> @@ -193,6 +193,8 @@ int amdgpu_ras_eeprom_read_idx(struct
> amdgpu_ras_eeprom_control *control,
>
>  int amdgpu_ras_eeprom_update_record_num(struct amdgpu_ras_eeprom_control
> *control);
>
> +void amdgpu_ras_check_bad_page_status(struct amdgpu_device *adev);
> +
>  extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
>  extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
>
> --
> 2.43.0

