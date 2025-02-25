Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE70C021B8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 17:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C274E10E1CB;
	Tue, 25 Feb 2025 17:46:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FdIUe66J";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15ADE10E1CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 17:46:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lh4mYk0CQxKbkzTVNmv6teTB5i/1+8GqbrvID59Xi7349XYnaI39HIyVZgVTheM1NBWd6GRnYZsrgzSw8kBKuv49Cwln0bXwL4TCx04uv+VgjOmzvdUd/6ByTAdk0+WvBv3trF3V1f7CHG1oV4DyIhFP1+LkVh43zfO1yBzHn2w17qwMqExD9Tg9di/dt6dt3OHIPfBm6pMMLzV15/eUCuiasZ+cNrjWOv10lvfBzZ6LciGMAT9zpMgPWWe0K1Noa2j6BQFJ6CYG08SC4JW30TeZe9WHb8jGe+hyfcPfF7yfaWFaSq5naDMXuZWVBOD/AhTJnI5uLKDGpmFmNhHxUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4vpBOp44LeshdZVaOLJluwzKpxqPc0ui9tubtF+InE=;
 b=xrfuBuQEhAJAhOKf1LBhvaWFB47CjcSKL/JpcX0JHpfQc/dnjINkiwNXJsbqhcesNzfrEdESWYLtJo4RKn4ppWy5Dr6Pd/bmLIeLqAdAwLrLTGGkTv4wCT9Cf/Hu3FhXO9wvXHzAxew4nNyrd+EqGLceJt5lDBvevEdUOKT7mBsTVenApOAu3zMT6NJy7bEJPyL/CRLkWnZXFKMQGDEKL1A1SJZHDOqaO6BhpqHno5RExkVimljf9y3yKBzJ6qZR7U/tA9seXGoa+797Zsy7AfaM2c2Jo59wdpfwuYTYCX0MTH+kayeEJ8G0tLWA2OTjatcVCaKrXAePlGYHq16p9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4vpBOp44LeshdZVaOLJluwzKpxqPc0ui9tubtF+InE=;
 b=FdIUe66JVqiVAesDN94WoF2nsagT9TlyNW29BxFGlNTWk10XzQvQYZfVx0LscX+DLLLAbNZJU1+/MLzPoGasq3KBPrS7AAXHbogN7hlubH2uh4T9IlIMRaYb65yPDd4VExJEFnXD8kC6B4JCpQbBFH23k6GSAl44rCGQRlYpQpo=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by SA1PR12MB8988.namprd12.prod.outlook.com (2603:10b6:806:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 17:46:47 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 17:46:47 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v3 4/4] drm/amdgpu: Calculate IP specific xgmi bandwidth
Thread-Topic: [PATCH v3 4/4] drm/amdgpu: Calculate IP specific xgmi bandwidth
Thread-Index: AQHbh1Dv8I4zv5viqEGlrzYeDJ5kw7NYS5gA
Date: Tue, 25 Feb 2025 17:46:47 +0000
Message-ID: <CY8PR12MB743513E2FB0EDBFD7917996D85C32@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250225064536.118278-1-lijo.lazar@amd.com>
 <20250225064536.118278-4-lijo.lazar@amd.com>
In-Reply-To: <20250225064536.118278-4-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=ef4c34c4-afb7-48de-bb7f-6865218993ff;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-25T17:46:31Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|SA1PR12MB8988:EE_
x-ms-office365-filtering-correlation-id: 55f3ed83-79a8-4ef3-03b8-08dd55c46083
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?phUhBG/rayHMf8re0yH2IOQw0Hu8VMlBYn0EW/G3kJs0u0ukYsFj4KY74l7Y?=
 =?us-ascii?Q?YWgeY1blqyGovN7ulYHzkNDE0xIXmr4LtL2ZWPNazUlamB2ebbURCBxo2E0n?=
 =?us-ascii?Q?uDPTJKd4TS6w4nBzvKsFgOsul/J/jQISFdsw3GQeIa+005cA8Dm+y4e/IIVd?=
 =?us-ascii?Q?lztJy7ywY0e3xbfydwN4iHzg/Hd+/7B4pw9rhzT/dc6vV4Z16vGdCcKp8o2J?=
 =?us-ascii?Q?vFH8cnqRi9Q+T241OzIESPt8d661ghSuVTsZpseu497HoWH6LQQjr4XtL19U?=
 =?us-ascii?Q?cnuYShrWqcKcYSph/OP3mDqQRcne1jPlaD5NL35PojIUxSBgTs+qDkVihSj8?=
 =?us-ascii?Q?Qt0F7NhEIu9lDqebn9H8x08Fo6aFvDaeH2FvazgF3LI/BWZqurpELWaQVyVS?=
 =?us-ascii?Q?NzHsF2rAF8lC1i9Ga4rUzU2gytYsK4JiCljySv5ccHxMwzcna59GBvnArQ/B?=
 =?us-ascii?Q?66WSnXJ2zxC1InanlZRUdVCOLfGdembSkK863DTLSK6JjLbkkj9+XY0tl4eV?=
 =?us-ascii?Q?giheWukc7aPLVLQcKeW4uoP7yJyUTwsw+37JLB23Svn61sfmQ+h5nbfw1nsK?=
 =?us-ascii?Q?6SB4a8GBVam9CPh8sYK20GgZ9QNkvgRzj98Mf/edtshR42mFjaN9I3RGUtsw?=
 =?us-ascii?Q?CIMAJR8Yr/cHn5oM5rAsjgmdDMvnXtpSeNdtT6+uKm9f195np/MhVkwh+Wa4?=
 =?us-ascii?Q?JcTvWtqUfkCx08K/uyLuwSQi7JbcPxMdzQ22DesBbuSAyDCTd2ATWcRBJF8g?=
 =?us-ascii?Q?k5pIiyUf+7qxR50xAaiSKpF/efFt3ws16PJJVcFR9MBtrVQKZKnQ9ljQcQPP?=
 =?us-ascii?Q?BZiE+6ghkDAW2b2GIsU9RgWwCJQIXpLQmotLyy9w+WcM6nZte+fYKDfiUQLl?=
 =?us-ascii?Q?JZZF6bVXaz1qa+aa92J3hGO3IVuKpZNwxd1wZ4Kk4kB+ebypjxRklmoo1ro3?=
 =?us-ascii?Q?OvVGO2QdEfBC1/3cuX1nQkFCyUpRBk7+56Z2DGZDXSkmqkXttSZjOC1EE2ph?=
 =?us-ascii?Q?taGahgGqxZgP5wFu1kj5uzMheC4R8yEDV0ADIUDmBaWpbtCbWwSY2CioeIfR?=
 =?us-ascii?Q?xD4p8ZlgOtehOOw9qGnG0zbGVuiqZC7/qUufXF3eCN+Syf14hoFmI8K1UbBQ?=
 =?us-ascii?Q?rQZMI2HSXYVop2LI7qZ10lg4AnTBlzbRzrYM4RdSRZK9ItjalaB2WUjGGBEY?=
 =?us-ascii?Q?bU5seatKHblLJhorRbtWjqqlxyw7wBmbb1cFllQ66Kke/r4ojyCo6ByuNNgg?=
 =?us-ascii?Q?bw7YW1xjhhZBjJWtyCMu/8eiIW9dlHXPANPfhP1hr5ObADlp4A5BsKB7SQEZ?=
 =?us-ascii?Q?mzSdSEy2kDyl2g2AGl5YG2aPPg/7tQEHOX9M470iR14kb89qm3bHbpkCMjoj?=
 =?us-ascii?Q?S3EjzCcic9JCUId1H+aRd6mQwOfO+dZeejahlGH+GkKOBp59wLCpU1HLk9I9?=
 =?us-ascii?Q?7hlQwnMo8H8XNghKBekntaIgQ+GwrDlT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x4T795WuJHSrZxoiazJ2V4o0G/FI1tSegDR6eXDIeX16Nn2AwX0ERM/WrBqb?=
 =?us-ascii?Q?kTwFZKj9qkhWBLkmnVGHFnv7s4fD7TAnJE6lZ9SUtNpZgG2i/hXrak6WShog?=
 =?us-ascii?Q?w0iazjJXCONVLnnzjqdtCxyFqV5g4YPv3urMrJfg9SoqHAgYET1I4mTWhDgf?=
 =?us-ascii?Q?iVlxwzz996TuV4qAwKpH5JVKsPcDVtbPZCvp6yL1xzsJpWAs4zNMWr9sgbuD?=
 =?us-ascii?Q?U2AAyNZ+pXPlRSkeaZ2w1iQgGTIoxqBVeTsWGFDKXcbZGz5tpvIPSiAMaprz?=
 =?us-ascii?Q?GW8oPhAh2g+BTqDsAn1LiX3pyKJ5I7VCFmVa47tAJv7yiBJyJqZtya8t5XAs?=
 =?us-ascii?Q?Ht+3F4WoyY9u4pPaIBLFJsCIjV5aKnqM/biaRToWP5NDtKvxB7YRpDrUziH6?=
 =?us-ascii?Q?LiuuVNokxVQg9ogLRIxbSRezIRgp/FhKcvJKyp5aaWsioqhdU8CoeKne1azt?=
 =?us-ascii?Q?/2q+SogiACSp5X43omZ+umYtLzxA5QQybFq/EKHBih778jIbcfTbcN2wxuaE?=
 =?us-ascii?Q?ivZKT96sRLCFRk01gOXZ67CuulO3TxnbGCqoLZNggY1zOzh3Ej4YsFCATbox?=
 =?us-ascii?Q?cKIo3p1q0wItJuJ4TmxskmKzKlkS8oDjktTcnSslxPhpMoBd7lH9+AZuiFbE?=
 =?us-ascii?Q?FDXF5TrThpM6+ZbcjSHa7qUQQY92BiyXYVIl1u+h4/TpuN6qianFaTze/Djt?=
 =?us-ascii?Q?BOKsjoC/oq8mdRjfCYDdjDCrNxwg2/wkvv2/1sal9mzMJnlXJEc3gOgdPdfw?=
 =?us-ascii?Q?tyChQ4Cnr8dEamLCG+wtWp9lwajrU9oN8PiKp1bbN3W7wG6sOL793VwwU25c?=
 =?us-ascii?Q?WFJBUGOJtqfVHrz7DuT7x266V29JaTGTcPj4iyrIMbEQF3nMkwWurpJ/7dii?=
 =?us-ascii?Q?aPbow5Vrq1wiYY3bRYr1lrXQj/VT/mA+ZWDowmJNk7fnnBUPItTtiA3HLETy?=
 =?us-ascii?Q?2rGEIKUwo2oHGaBXSyLp6jRXxvev55vax6aPhD7Q8SChX33x1aU9WBPFXIK9?=
 =?us-ascii?Q?CJ5+EZDEMeW77DlT1h+iBWpuUdhsuBeEijs5q3MZ6eOR5xvHsVOM9Q8GKf8R?=
 =?us-ascii?Q?86boKCZtg4rsVAgZcA7YdNl8LF2ftgLB/NY82zFbdtyVQbuxRyv+nNVGGtso?=
 =?us-ascii?Q?W8nreSpOWvtfAJbX99KEm0QheFc2nJ+XSwoyosYBpLNy/3B4bGWMZMxS9EGw?=
 =?us-ascii?Q?V3DaUZ9BrjyR7SveN9Mvt0o4hbgLui7wDTHRofa0WgFG4m8WRPTpvefbIz3r?=
 =?us-ascii?Q?zLc514/LAjh0XvtXwe6HeH5e+wcNZRhu6iiFT/sDxDIRHyy1e1LDKYpG0o+u?=
 =?us-ascii?Q?2sYTWjcqV+BBn7aQYtlWICULeLFI4PurcVTOOwcG5Dn55HHUfR2TijntTAdp?=
 =?us-ascii?Q?9E2Qkzv3f9f5ofqyDpgZvXkP8aV2PRSk8UMTb/fHdeLuMdC8a9yNbKWPDxU8?=
 =?us-ascii?Q?xdB/PY4Bx9Od/gqDzerTUGoqLAFgqCUYSJ8hRwwE1SvoVIIKQPs9sijipJgz?=
 =?us-ascii?Q?JZLlgs6LEype69ROG1HJNenMDp/PPlXmXRR6P+Io9Y3+RZPwMmDD4g24PjBQ?=
 =?us-ascii?Q?X3c50gWMtmG/5m8Woyw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f3ed83-79a8-4ef3-03b8-08dd55c46083
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 17:46:47.6999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oN9y4zw3lBaapzVciFc2g22gWPladm2xR68Qv5kh0SLe8KeADLw0CAShgLd8+Wn1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8988
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

[Public]

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Tuesday, February 25, 2025 1:46 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>
> Subject: [PATCH v3 4/4] drm/amdgpu: Calculate IP specific xgmi bandwidth
>
> Use IP version specific xgmi speed/width for bandwidth calculation.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

This patch is:
Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

> ---
> v2:
>       Move XGMI info init to early init phase (Jon)
> v3:
>       Rebase on top of drm/amdgpu: simplify xgmi peer info calls
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 4 +++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b2e9e116be44..df7cb692d8c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2757,6 +2757,9 @@ static int amdgpu_device_ip_early_init(struct
> amdgpu_device *adev)
>       if (!total)
>               return -ENODEV;
>
> +     if (adev->gmc.xgmi.supported)
> +             amdgpu_xgmi_early_init(adev);
> +
>       ip_block =3D amdgpu_device_ip_get_ip_block(adev,
> AMD_IP_BLOCK_TYPE_GFX);
>       if (ip_block->status.valid !=3D false)
>               amdgpu_amdkfd_device_probe(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 45566c320615..0cc42a43408e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -843,7 +843,9 @@ int amdgpu_xgmi_get_bandwidth(struct amdgpu_device
> *adev, struct amdgpu_device *
>  {
>       bool peer_mode =3D bw_mode =3D=3D AMDGPU_XGMI_BW_MODE_PER_PEER;
>       int unit_scale =3D bw_unit =3D=3D AMDGPU_XGMI_BW_UNIT_MBYTES ? 1000=
 :
> 1;
> -     int speed =3D 25, num_lanes =3D 16, num_links =3D !peer_mode ? 1 : =
-1;
> +     int num_lanes =3D adev->gmc.xgmi.max_width;
> +     int speed =3D adev->gmc.xgmi.max_speed;
> +     int num_links =3D !peer_mode ? 1 : -1;
>
>       if (!(min_bw && max_bw))
>               return -EINVAL;
> --
> 2.25.1

