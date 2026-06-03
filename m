Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43847CD6E55
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 20:39:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D29BD112368;
	Wed,  3 Jun 2026 20:39:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="USgtdRPS";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010035.outbound.protection.outlook.com [52.101.61.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF9CC112368
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 20:39:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPQ+zWNsF2VPltHBoDbLVNosiqw/x4f4ebS9M9nb9/ATri6PCkU2Cx73WQxP3sSxjH2BpfLYXujx6Thg3mqlB+rtSq22BfxMEvL1QNGWjZGyGeFuKB76jHMqLgXxs75NxREwd0KW/B1TXihH5USInCIp8DfEdyKu+DfUZH5ksCfcRGEKlqKJiaw/ihFvH0w4I4oIO9H58DKRALO1nPqXWSc9ASbLeNLvDITz1IgnXgSnnRBrb9jI5/U2CqOBJ+5T2yOY50uPHrfWsy7NCsk5dZKjXauiY/Mt5PzPUZEJ634aV88Rr4AE6eKupdf9xDQizqx+JTt6Rv5MuPzKugJsZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uin9r6bxRBnlrnqxLQPyZHoGK4c77ABArRz3RlJYGn8=;
 b=faOihUx4ILB7muaMCUGN/BJ0l87OUXneRsai/ggCiyPddQNx+7N3457lleJ88pRbqH8U7XotQKQSPHN43gXt41RK4P7gxX8wfYorLHIZHrKxkjHNCpFjwbBKHE7FLg/i4Yk/quUECiqhO+havHA3MzstMQmsJWVBmdMCDK1XuF4D5w1lpLt7faVPI0+JX5ENT0C5nz3zsGH6lN9H7v3BZghTu/kjLknPpBEAQeUA7brp3mvrat0VOtBYq+480kEskLkhXUJ4rtsLCUgb6r4ldjLwSAz9bsLg9lFCX9XMVhHeA9vRK9Dij//wCUkSR4ydF8FA1blYCegG/8IrCZ0Rkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uin9r6bxRBnlrnqxLQPyZHoGK4c77ABArRz3RlJYGn8=;
 b=USgtdRPSlba0MI52Wm3o+dAgqazCV+tay8mNwI38U7U2xc2ffZ8ThgX6Kv7y7+JL5P79W+rKwFAnlQn8fhNf0A04pyCvVf2fNn3d5OAnwDVuxdDzBH/7G9Td2RhE5tLtGyLYg6nog7Dgz/PsA/jz6rJpQWCd61q9wjeZUvcA8Xk=
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13)
 by LV2PR12MB5773.namprd12.prod.outlook.com (2603:10b6:408:17b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 20:39:43 +0000
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957]) by SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 20:39:43 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 1/2] drm/amdgpu: Add enum for PCIe BAR regions
Thread-Topic: [PATCH v2 1/2] drm/amdgpu: Add enum for PCIe BAR regions
Thread-Index: AQHc8gkVZvgzyT0jrk6Ms47mzfvQ77YqwYSAgAKLH3Y=
Date: Wed, 3 Jun 2026 20:39:43 +0000
Message-ID: <SJ2PR12MB86505425E2E6980C04EDE2D68C132@SJ2PR12MB8650.namprd12.prod.outlook.com>
References: <20260601205553.239933-1-Harish.Kasiviswanathan@amd.com>
 <c20304a7-4f5e-459c-8da2-b67baab9f6cd@amd.com>
In-Reply-To: <c20304a7-4f5e-459c-8da2-b67baab9f6cd@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-06-03T20:39:43.426Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=1;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8650:EE_|LV2PR12MB5773:EE_
x-ms-office365-filtering-correlation-id: 9dcbd456-375e-483d-89d5-08dec1b03e46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|8096899003|6133799003|18002099003|22082099003|56012099006|3023799007|5023799004|4143699003|11063799006;
x-microsoft-antispam-message-info: ipaXUYRwnkOzvxGyM9mt1KATJhDbSkA667MdPKPRyXeH07sxRRnV519Ncmk1ivi1IkVPgCOnV0x0dRmY+FScd6QZLl3fRIM2kJCmDrGZCa+1gsWZxYadNbFL2y3tu5+vvOjbj3+/H9dj5lAzGscHSmZ8pw2VetkLIjgNNLSO/ggE+lOPHf59eYscbFvD7FKDHqiJBDlrH+yMQKc9ny9o9RPazOYoRs+eDbadRrEtV2QaRBc+n1+Yk1gAoWHFDChE+yuWD8Hx5TGHpbZImqWXfbPb5Voq1/YbrKAUItdVyaPlu2lKAg34J+9Dcg8KhUnf2l8UmPU9Qn0o1FXBWZIYRgN+AsihbuNDfiwARbGWg+b/h6iHxLsms6SMynUHhJL/6c0jPPZEbcangfIWKxdgMbmoL7/aaWjGn/iFxsr89bz5IbZ3tqfR80fTon7/UZRHVhppxrv96zHfV2ftfbdbUwaKycW7DtWAhJDgaaHpKuwj0GM1hWN6bNee87rAy7Wu5yJgzIzf8CQvl51xTlTsdSfXiB2Rb7/EWT7DSwm67xMnhx6R5y90EJgfc2k59H/mjfvHTY1N/xvhnYyiTp6jrKM5hMB3/gSU7PCXJXykeP5SQ4k8Ac8oxT0dBVsnec/geY7vf5+hTWVGtvqRgWaIVzRpVNaK5qlm4pCS/Twq/VN1Rp3O9gZDNK3SGoYWFb+tVFA5rHNTbOCYuZNUcrJmgfB6biklFjTxnJovKhYhD6nq5KLGt29O+RutBlEjoeee
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(8096899003)(6133799003)(18002099003)(22082099003)(56012099006)(3023799007)(5023799004)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?g/yaIB6ouprSJV7q1yMZE4m1HTzkizsW+K1NjZYwY+mxknr77QAnf07RLg?=
 =?iso-8859-1?Q?2MHQ1vzTzgcl+BXQNdGyUHryKNfd94KQwEwggnkjDbhxaWiLFvytc9jH1K?=
 =?iso-8859-1?Q?Us5FSxm/9sKtbNkPfolcBMm6W4L0PAAGYs7FesDsg3D1NMhVkLBhSG6TDJ?=
 =?iso-8859-1?Q?/VouNU9tx1Vl6B0Ijt0fz23hI3/k32SupmabUafyU29wLpD3O8anfp8DD7?=
 =?iso-8859-1?Q?olG0MPkhn5lop+wgWjftDDBs81egwCWAMpVwxHFD6xILy1SWaTLyGkICau?=
 =?iso-8859-1?Q?uZW2wPs3TAw+ziQRadyJP5SX0aUSmJabWWFDek5t7/LZXJqr2KK6Umh8T3?=
 =?iso-8859-1?Q?u+lK/kag/cE/uY6+kcZ1S2+bvSexoS3UG3NDJBbSHiDrZlHyze7Fbxmybl?=
 =?iso-8859-1?Q?OLsHugnYIJ5RloEBayHj58Siha3aDRGE4C47Cjf56dTFFhpp3gT1tQY9jK?=
 =?iso-8859-1?Q?AUd3C9QXODGRSeLKJkQljV/ODfSlysDIz41e6azoO922bYgWEEAcYsdLzX?=
 =?iso-8859-1?Q?CioE34i8A5j51h9jxNn2Wv288MVY6ONoZc0N4ceZ50MU72GUhyiX99jDAw?=
 =?iso-8859-1?Q?GfvrOATXDZfzhgA6nEK7OGUoAjeO4zsqGaSb7nUtKukLBiYsUqc4YNM8jW?=
 =?iso-8859-1?Q?LSsyHVfiXIap/CbEpgkw6qRx6DG/eGWac5Gt7bFTZfNC0n5a+0jmV+DObW?=
 =?iso-8859-1?Q?u0Yy2x+BWDJumAFJlcGhJildLS3YgSOTp83wKvjI/NwPS9N2Fcjezwl1qf?=
 =?iso-8859-1?Q?CkrpasLLqina0o+qXQl3elb5e2hjwomxFMkks3Bv43hdM4UtA7/lJOjiVs?=
 =?iso-8859-1?Q?SGQHUZQYn/nPdm5zl2j35+MrET689mNEoUI2OYUcNHIpztZXn8fbSjIYlg?=
 =?iso-8859-1?Q?t0Brie9VkNiH3Z1HY0HUtBGX+eTvNiH04jqwdV1yhUuOOjfBeU3uBVP6oL?=
 =?iso-8859-1?Q?6y7ydTW7+fKvpw+H8LwjXAglMt/mvX6WIPpS+wKtWPPhbn5MBL5BumgyIz?=
 =?iso-8859-1?Q?Ykcx5K6u5hVh6h7+B2Qj/vN3+DQGobCGkHWTbSiKyo3F25EizHn06Aeg+p?=
 =?iso-8859-1?Q?AZESqasmyeHICSSwcjNP6/LmGlJFXpbBfXHKi4Wnp7aQWDdifWfLqcTi9f?=
 =?iso-8859-1?Q?B1laqWDO4r73aPEsqF99km/YJHf/l1BE5xAty5r5bi+vjBK5lBzlIEuGtZ?=
 =?iso-8859-1?Q?DULyQ27aBigcwQiyU+srUKqt1b96gxJnYP8gWTH+MM+/hsRlXwCWMVEHkL?=
 =?iso-8859-1?Q?rrsMYpiUpXUP5VkTe2k1X2bj5Jg8PpsFojmBHkMXLCgKParU9glXpydNKS?=
 =?iso-8859-1?Q?aHJLcP4MHbroevJzwrtvaapMQhtorjUBZ8sQ55OXLx3dwtOKusBSGITicz?=
 =?iso-8859-1?Q?G7xpetTJwkcwKbDWYGKpoFNdmFW+Xz2heAQrMMQZ30RkQJtDdDmAl9yEgu?=
 =?iso-8859-1?Q?JSsBf6h5FFKfd5tSUmjZ+/riwxPpw7myUPfnbBPD8a59FqpABcoHbJXlY0?=
 =?iso-8859-1?Q?3ji0DqHAyygs5AnDO5YK3mmavRq3unCA2NHZjEU9ZtOTKOwuNqDmoArh2o?=
 =?iso-8859-1?Q?0fvhYtFwcvkG8lep0AFtyxo2Dsg4wfd+P+vMVSayYZ4UtjAggfnkiweHUY?=
 =?iso-8859-1?Q?g5pN5e4BBQDQQBEQ0XryaVbIrGKtJEQdpKQlm6fjkd/B+K3FtsG/QxHfcz?=
 =?iso-8859-1?Q?b61UpQizrGsOL1svqhuo6TRhPI+BhRflWv/Q94Jr8s2sKx0XohZdj9S5Nt?=
 =?iso-8859-1?Q?e/32pmtQco1g/xzj06RJQ3eJOvt3qy9tLH4S3sWCvQ49VL?=
Content-Type: multipart/alternative;
 boundary="_000_SJ2PR12MB86505425E2E6980C04EDE2D68C132SJ2PR12MB8650namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dcbd456-375e-483d-89d5-08dec1b03e46
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 20:39:43.6150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Rk7qNgD4mLz8qI98Eh4flZS6DQEe14Ej/PtYIC3wEQrS8V80tyiHatOqrHvLA48ra42mitF5NAvbLhAjpoNYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5773
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

--_000_SJ2PR12MB86505425E2E6980C04EDE2D68C132SJ2PR12MB8650namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Public




________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, June 2, 2026 1:43 AM
To: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; amd-gfx@lists=
.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 1/2] drm/amdgpu: Add enum for PCIe BAR regions



On 02-Jun-26 2:25 AM, Harish Kasiviswanathan wrote:
> Use enum instead of hard coded values. There is no functional change.
>
> v2:
> - Add amdgpu_get_bar_idx() to map BAR roles to PCI BAR indices
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 17 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      |  6 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 56 ++++++++++++++-----
>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  |  9 ++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  6 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  6 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |  6 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |  6 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  6 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  6 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  9 ++-
>   11 files changed, 100 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 5d7bfa59424a..1944d1bece86 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1405,6 +1405,23 @@ bool amdgpu_device_supports_boco(struct amdgpu_dev=
ice *adev);
>   bool amdgpu_device_supports_smart_shift(struct amdgpu_device *adev);
>   int amdgpu_device_supports_baco(struct amdgpu_device *adev);
>   void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev);
> +
> +/**
> + * enum amdgpu_pcie_bar - PCIe BAR role identifiers
> + * @AMDGPU_PCIE_BAR_VRAM: VRAM aperture
> + * @AMDGPU_PCIE_BAR_DOORBELL: Doorbell aperture (Bonaire+)
> + * @AMDGPU_PCIE_BAR_MMIO: MMIO register aperture
> + *
> + * Use amdgpu_get_bar_idx() to map a role to the PCI BAR index on a give=
n ASIC.
> + */
> +enum amdgpu_pcie_bar {
> +     AMDGPU_PCIE_BAR_VRAM =3D 0,
> +     AMDGPU_PCIE_BAR_DOORBELL =3D 2,
> +     AMDGPU_PCIE_BAR_MMIO =3D 5,
> +};

This may just be treated as an enum, it's not required to designate
numbers for BAR index.

[HK]: Makes sense. I will make the change.

> +
> +int amdgpu_get_bar_idx(struct amdgpu_device *adev, enum amdgpu_pcie_bar =
bar);
> +
>   bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
>                                      struct amdgpu_device *peer_adev);
>   int amdgpu_device_baco_enter(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_bios.c
> index aa039e148a5e..7e253bb35434 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -111,11 +111,13 @@ static bool amdgpu_read_bios_from_vram(struct amdgp=
u_device *adev)
>                        return false;
>
>        /* FB BAR not enabled */
> -     if (pci_resource_len(adev->pdev, 0) =3D=3D 0)
> +     if (pci_resource_len(adev->pdev,
> +                            amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRA=
M)) =3D=3D 0)
>                return false;
>
>        adev->bios =3D NULL;
> -     vram_base =3D pci_resource_start(adev->pdev, 0);
> +     vram_base =3D pci_resource_start(adev->pdev,
> +                                    amdgpu_get_bar_idx(adev, AMDGPU_PCIE=
_BAR_VRAM));
>
>        adev->bios =3D kmalloc(size, GFP_KERNEL);
>        if (!adev->bios)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 5ff224163bab..2e1e5791f123 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1103,6 +1103,34 @@ void amdgpu_device_wb_free(struct amdgpu_device *a=
dev, u32 wb)
>        spin_unlock_irqrestore(&adev->wb.lock, flags);
>   }
>
> +/**
> + * amdgpu_get_bar_idx - map a BAR role to the PCI BAR index
> + * @adev: amdgpu_device pointer
> + * @bar: BAR role to look up
> + *
> + * Return the PCI BAR index for @bar on @adev.
> + *
> + * VRAM is always BAR 0. Doorbells were introduced at Bonaire (CIK): pre=
-Bonaire
> + * ASICs have no dedicated doorbell BAR, and BAR 2 is used for MMIO regi=
sters.
> + * Bonaire and newer expose a doorbell aperture at BAR 2 and MMIO at BAR=
 5.
> + */
> +int amdgpu_get_bar_idx(struct amdgpu_device *adev, enum amdgpu_pcie_bar =
bar)
> +{
> +     switch (bar) {
> +     case AMDGPU_PCIE_BAR_VRAM:
> +             return AMDGPU_PCIE_BAR_VRAM;
> +     case AMDGPU_PCIE_BAR_DOORBELL:
> +             return AMDGPU_PCIE_BAR_DOORBELL;
> +     case AMDGPU_PCIE_BAR_MMIO:
> +             if (adev->asic_type >=3D CHIP_BONAIRE)
> +                     return AMDGPU_PCIE_BAR_MMIO;
> +             return AMDGPU_PCIE_BAR_DOORBELL;

Was not expecting this function to return the enum itself. Input is enum
and output is a hardcoded index like 0, 2, 5.

[HK]: Yes, this sort of follows up from previous comment.

> +     default:
> +             WARN_ON(1);

pci_resource_len() expects a valid bar number.
pci_resource_len(adev->pdev, amdgpu_get_bar_idx()) usage may invoke some
static code analyzer warnings.

Thinking again, a one-time assignment of below ones somewhere in early
init amdgpu_init_pci_bars() may be simpler to deal with.

gmc.aper_bar_idx
rmmio_bar_idx
doorbell.bar_idx

[HK]: Don't know about this. This sort of scatters the initialization unles=
s we add a new structure. Something like u8 pcie_bar_idx[PCIE_BAR__COUNT] t=
o amdgpu_device.



Thanks,
Lijo
> +             return -EINVAL;
> +     }
> +}
> +
>   /**
>    * amdgpu_device_resize_fb_bar - try to resize FB BAR
>    *
> @@ -1146,7 +1174,8 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_devic=
e *adev)
>
>        /* skip if the bios has already enabled large BAR */
>        if (adev->gmc.real_vram_size &&
> -         (pci_resource_len(adev->pdev, 0) >=3D adev->gmc.real_vram_size)=
)
> +         (pci_resource_len(adev->pdev,
> +                           amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM=
)) >=3D adev->gmc.real_vram_size))
>                return 0;
>
>        /* Check if the root BUS has 64bit memory resources */
> @@ -1165,7 +1194,8 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_devic=
e *adev)
>                return 0;
>
>        /* Limit the BAR size to what is available */
> -     max_size =3D pci_rebar_get_max_size(adev->pdev, 0);
> +     max_size =3D pci_rebar_get_max_size(adev->pdev,
> +                                       amdgpu_get_bar_idx(adev, AMDGPU_P=
CIE_BAR_VRAM));
>        if (max_size < 0)
>                return 0;
>        rbar_size =3D min(max_size, rbar_size);
> @@ -1178,9 +1208,11 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_devi=
ce *adev)
>        /* Tear down doorbell as resizing will release BARs */
>        amdgpu_doorbell_fini(adev);
>
> -     r =3D pci_resize_resource(adev->pdev, 0, rbar_size,
> -                             (adev->asic_type >=3D CHIP_BONAIRE) ? 1 << =
5
> -                                                               : 1 << 2)=
;
> +     /* Resize the VRAM BAR. Exclude the MMIO BAR from being released. *=
/
> +     r =3D pci_resize_resource(adev->pdev,
> +                             amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VR=
AM),
> +                             rbar_size,
> +                             BIT(amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BA=
R_MMIO)));
>        if (r =3D=3D -ENOSPC)
>                dev_info(adev->dev,
>                         "Not enough PCI address space for a large BAR.");
> @@ -1191,7 +1223,8 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_devic=
e *adev)
>         * using the device.
>         */
>        r =3D amdgpu_doorbell_init(adev);
> -     if (r || (pci_resource_flags(adev->pdev, 0) & IORESOURCE_UNSET))
> +     if (r || (pci_resource_flags(adev->pdev,
> +                                    amdgpu_get_bar_idx(adev, AMDGPU_PCIE=
_BAR_VRAM)) & IORESOURCE_UNSET))
>                return -ENODEV;
>
>        pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
> @@ -3825,13 +3858,10 @@ int amdgpu_device_init(struct amdgpu_device *adev=
,
>
>        /* Registers mapping */
>        /* TODO: block userspace mapping of io register */
> -     if (adev->asic_type >=3D CHIP_BONAIRE) {
> -             adev->rmmio_base =3D pci_resource_start(adev->pdev, 5);
> -             adev->rmmio_size =3D pci_resource_len(adev->pdev, 5);
> -     } else {
> -             adev->rmmio_base =3D pci_resource_start(adev->pdev, 2);
> -             adev->rmmio_size =3D pci_resource_len(adev->pdev, 2);
> -     }
> +     adev->rmmio_base =3D pci_resource_start(adev->pdev,
> +                                           amdgpu_get_bar_idx(adev, AMDG=
PU_PCIE_BAR_MMIO));
> +     adev->rmmio_size =3D pci_resource_len(adev->pdev,
> +                                         amdgpu_get_bar_idx(adev, AMDGPU=
_PCIE_BAR_MMIO));
>
>        for (i =3D 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
>                atomic_set(&adev->pm.pwr_state[i], POWER_STATE_UNKNOWN);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> index bc7858567321..826b80481908 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> @@ -201,14 +201,17 @@ int amdgpu_doorbell_init(struct amdgpu_device *adev=
)
>                return 0;
>        }
>
> -     if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
> +     if (pci_resource_flags(adev->pdev,
> +                            amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_DOO=
RBELL)) & IORESOURCE_UNSET)
>                return -EINVAL;
>
>        amdgpu_asic_init_doorbell_index(adev);
>
>        /* doorbell bar mapping */
> -     adev->doorbell.base =3D pci_resource_start(adev->pdev, 2);
> -     adev->doorbell.size =3D pci_resource_len(adev->pdev, 2);
> +     adev->doorbell.base =3D pci_resource_start(adev->pdev,
> +                                              amdgpu_get_bar_idx(adev, A=
MDGPU_PCIE_BAR_DOORBELL));
> +     adev->doorbell.size =3D pci_resource_len(adev->pdev,
> +                                            amdgpu_get_bar_idx(adev, AMD=
GPU_PCIE_BAR_DOORBELL));
>
>        adev->doorbell.num_kernel_doorbells =3D
>                min_t(u32, adev->doorbell.size / sizeof(u32),
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v10_0.c
> index 8523833a74fb..728d93e96ea1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -694,8 +694,10 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *a=
dev)
>                if (r)
>                        return r;
>        }
> -     adev->gmc.aper_base =3D pci_resource_start(adev->pdev, 0);
> -     adev->gmc.aper_size =3D pci_resource_len(adev->pdev, 0);
> +     adev->gmc.aper_base =3D pci_resource_start(adev->pdev,
> +                                            amdgpu_get_bar_idx(adev, AMD=
GPU_PCIE_BAR_VRAM));
> +     adev->gmc.aper_size =3D pci_resource_len(adev->pdev,
> +                                            amdgpu_get_bar_idx(adev, AMD=
GPU_PCIE_BAR_VRAM));
>
>   #ifdef CONFIG_X86_64
>        if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v11_0.c
> index 16388e3caea3..a16e681b4de0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -694,8 +694,10 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *a=
dev)
>                if (r)
>                        return r;
>        }
> -     adev->gmc.aper_base =3D pci_resource_start(adev->pdev, 0);
> -     adev->gmc.aper_size =3D pci_resource_len(adev->pdev, 0);
> +     adev->gmc.aper_base =3D pci_resource_start(adev->pdev,
> +                                            amdgpu_get_bar_idx(adev, AMD=
GPU_PCIE_BAR_VRAM));
> +     adev->gmc.aper_size =3D pci_resource_len(adev->pdev,
> +                                            amdgpu_get_bar_idx(adev, AMD=
GPU_PCIE_BAR_VRAM));
>
>   #ifdef CONFIG_X86_64
>        if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v12_0.c
> index 586703ec0dfa..5c2b4d2f3f16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -746,8 +746,10 @@ static int gmc_v12_0_mc_init(struct amdgpu_device *a=
dev)
>                        return r;
>        }
>
> -     adev->gmc.aper_base =3D pci_resource_start(adev->pdev, 0);
> -     adev->gmc.aper_size =3D pci_resource_len(adev->pdev, 0);
> +     adev->gmc.aper_base =3D pci_resource_start(adev->pdev,
> +                                            amdgpu_get_bar_idx(adev, AMD=
GPU_PCIE_BAR_VRAM));
> +     adev->gmc.aper_size =3D pci_resource_len(adev->pdev,
> +                                            amdgpu_get_bar_idx(adev, AMD=
GPU_PCIE_BAR_VRAM));
>
>   #ifdef CONFIG_X86_64
>        if (((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v6_0.c
> index af6944d2d330..5bdcc276244c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -323,8 +323,10 @@ static int gmc_v6_0_mc_init(struct amdgpu_device *ad=
ev)
>                if (r)
>                        return r;
>        }
> -     adev->gmc.aper_base =3D pci_resource_start(adev->pdev, 0);
> -     adev->gmc.aper_size =3D pci_resource_len(adev->pdev, 0);
> +     adev->gmc.aper_base =3D pci_resource_start(adev->pdev,
> +                                            amdgpu_get_bar_idx(adev, AMD=
GPU_PCIE_BAR_VRAM));
> +     adev->gmc.aper_size =3D pci_resource_len(adev->pdev,
> +                                            amdgpu_get_bar_idx(adev, AMD=
GPU_PCIE_BAR_VRAM));
>        adev->gmc.visible_vram_size =3D adev->gmc.aper_size;
>
>        /* set the gart size */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v7_0.c
> index 93cf283191fa..d8b81d8ec954 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -379,8 +379,10 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *ad=
ev)
>                if (r)
>                        return r;
>        }
> -     adev->gmc.aper_base =3D pci_resource_start(adev->pdev, 0);
> -     adev->gmc.aper_size =3D pci_resource_len(adev->pdev, 0);
> +     adev->gmc.aper_base =3D pci_resource_start(adev->pdev,
> +                                            amdgpu_get_bar_idx(adev, AMD=
GPU_PCIE_BAR_VRAM));
> +     adev->gmc.aper_size =3D pci_resource_len(adev->pdev,
> +                                            amdgpu_get_bar_idx(adev, AMD=
GPU_PCIE_BAR_VRAM));
>
>   #ifdef CONFIG_X86_64
>        if ((adev->flags & AMD_IS_APU) &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v8_0.c
> index 1d3ddffd5a11..99bfd4e42977 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -572,8 +572,10 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *ad=
ev)
>                if (r)
>                        return r;
>        }
> -     adev->gmc.aper_base =3D pci_resource_start(adev->pdev, 0);
> -     adev->gmc.aper_size =3D pci_resource_len(adev->pdev, 0);
> +     adev->gmc.aper_base =3D pci_resource_start(adev->pdev,
> +                                            amdgpu_get_bar_idx(adev, AMD=
GPU_PCIE_BAR_VRAM));
> +     adev->gmc.aper_size =3D pci_resource_len(adev->pdev,
> +                                            amdgpu_get_bar_idx(adev, AMD=
GPU_PCIE_BAR_VRAM));
>
>   #ifdef CONFIG_X86_64
>        if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index ced0f3941863..774e93590389 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1588,7 +1588,8 @@ static int gmc_v9_0_early_init(struct amdgpu_ip_blo=
ck *ip_block)
>                 * mode.
>                 */
>                adev->gmc.is_app_apu =3D (pkg_type =3D=3D AMDGPU_PKG_TYPE_=
APU &&
> -                                     !pci_resource_len(adev->pdev, 0));
> +                                     !pci_resource_len(adev->pdev,
> +                                                       amdgpu_get_bar_id=
x(adev, AMDGPU_PCIE_BAR_VRAM)));
>        }
>
>        gmc_v9_0_set_gmc_funcs(adev);
> @@ -1700,8 +1701,10 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *=
adev)
>                if (r)
>                        return r;
>        }
> -     adev->gmc.aper_base =3D pci_resource_start(adev->pdev, 0);
> -     adev->gmc.aper_size =3D pci_resource_len(adev->pdev, 0);
> +     adev->gmc.aper_base =3D pci_resource_start(adev->pdev,
> +                                            amdgpu_get_bar_idx(adev, AMD=
GPU_PCIE_BAR_VRAM));
> +     adev->gmc.aper_size =3D pci_resource_len(adev->pdev,
> +                                            amdgpu_get_bar_idx(adev, AMD=
GPU_PCIE_BAR_VRAM));
>
>   #ifdef CONFIG_X86_64
>        /*


--_000_SJ2PR12MB86505425E2E6980C04EDE2D68C132SJ2PR12MB8650namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
Public</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Tuesday, June 2, 2026 1:43 AM<br>
<b>To:</b>&nbsp;Kasiviswanathan, Harish &lt;Harish.Kasiviswanathan@amd.com&=
gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br=
>
<b>Subject:</b>&nbsp;Re: [PATCH v2 1/2] drm/amdgpu: Add enum for PCIe BAR r=
egions </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;"><br>
<br>
On 02-Jun-26 2:25 AM, Harish Kasiviswanathan wrote:<br>
&gt; Use enum instead of hard coded values. There is no functional change.<=
br>
&gt;<br>
&gt; v2:<br>
&gt; - Add amdgpu_get_bar_idx() to map BAR roles to PCI BAR indices<br>
&gt;<br>
&gt; Signed-off-by: Harish Kasiviswanathan &lt;Harish.Kasiviswanathan@amd.c=
om&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 17 ++++++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; |&nbsp; 6 +-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbs=
p; | 56 ++++++++++++++-----<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c&nbsp; |&nbsp;=
 9 ++-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; |&nbsp; 6 +-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; |&nbsp; 6 +-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; |&nbsp; 6 +-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 6 +-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 6 +-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 6 +-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 9 ++-<br>
&gt;&nbsp;&nbsp; 11 files changed, 100 insertions(+), 33 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index 5d7bfa59424a..1944d1bece86 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -1405,6 +1405,23 @@ bool amdgpu_device_supports_boco(struct amdgpu_=
device *adev);<br>
&gt;&nbsp;&nbsp; bool amdgpu_device_supports_smart_shift(struct amdgpu_devi=
ce *adev);<br>
&gt;&nbsp;&nbsp; int amdgpu_device_supports_baco(struct amdgpu_device *adev=
);<br>
&gt;&nbsp;&nbsp; void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_de=
vice *adev);<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * enum amdgpu_pcie_bar - PCIe BAR role identifiers<br>
&gt; + * @AMDGPU_PCIE_BAR_VRAM: VRAM aperture<br>
&gt; + * @AMDGPU_PCIE_BAR_DOORBELL: Doorbell aperture (Bonaire+)<br>
&gt; + * @AMDGPU_PCIE_BAR_MMIO: MMIO register aperture<br>
&gt; + *<br>
&gt; + * Use amdgpu_get_bar_idx() to map a role to the PCI BAR index on a g=
iven ASIC.<br>
&gt; + */<br>
&gt; +enum amdgpu_pcie_bar {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PCIE_BAR_VRAM =3D 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PCIE_BAR_DOORBELL =3D 2,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PCIE_BAR_MMIO =3D 5,<br>
&gt; +};<br>
<br>
This may just be treated as an enum, it's not required to designate<br>
numbers for BAR index.<br>
</div>
<div style=3D"font-size: 11pt;"><br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
[HK]: Makes sense. I will make the change.</div>
<div style=3D"font-size: 11pt;"><br>
&gt; +<br>
&gt; +int amdgpu_get_bar_idx(struct amdgpu_device *adev, enum amdgpu_pcie_b=
ar bar);<br>
&gt; +<br>
&gt;&nbsp;&nbsp; bool amdgpu_device_is_peer_accessible(struct amdgpu_device=
 *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; struct amdgpu_device *peer_adev);<br>
&gt;&nbsp;&nbsp; int amdgpu_device_baco_enter(struct amdgpu_device *adev);<=
br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_bios.c<br>
&gt; index aa039e148a5e..7e253bb35434 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c<br>
&gt; @@ -111,11 +111,13 @@ static bool amdgpu_read_bios_from_vram(struct am=
dgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
false;<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* FB BAR not enabled */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (pci_resource_len(adev-&gt;pdev, 0) =3D=
=3D 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (pci_resource_len(adev-&gt;pdev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM)) =3D=3D 0=
)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return false;<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;bios =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; vram_base =3D pci_resource_start(adev-&gt;pd=
ev, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; vram_base =3D pci_resource_start(adev-&gt;pd=
ev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_g=
et_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;bios =3D kmalloc(si=
ze, GFP_KERNEL);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;bios)<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index 5ff224163bab..2e1e5791f123 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -1103,6 +1103,34 @@ void amdgpu_device_wb_free(struct amdgpu_device=
 *adev, u32 wb)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock_irqrestore(&amp;=
adev-&gt;wb.lock, flags);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;<br>
&gt; +/**<br>
&gt; + * amdgpu_get_bar_idx - map a BAR role to the PCI BAR index<br>
&gt; + * @adev: amdgpu_device pointer<br>
&gt; + * @bar: BAR role to look up<br>
&gt; + *<br>
&gt; + * Return the PCI BAR index for @bar on @adev.<br>
&gt; + *<br>
&gt; + * VRAM is always BAR 0. Doorbells were introduced at Bonaire (CIK): =
pre-Bonaire<br>
&gt; + * ASICs have no dedicated doorbell BAR, and BAR 2 is used for MMIO r=
egisters.<br>
&gt; + * Bonaire and newer expose a doorbell aperture at BAR 2 and MMIO at =
BAR 5.<br>
&gt; + */<br>
&gt; +int amdgpu_get_bar_idx(struct amdgpu_device *adev, enum amdgpu_pcie_b=
ar bar)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; switch (bar) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PCIE_BAR_VRAM:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return AMDGPU_PCIE_BAR_VRAM;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PCIE_BAR_DOORBELL:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return AMDGPU_PCIE_BAR_DOORBELL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PCIE_BAR_MMIO:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;asic_type &gt;=3D CHIP_BONAIRE)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return AMDGPU_PCIE_BAR_=
MMIO;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return AMDGPU_PCIE_BAR_DOORBELL;<br>
<br>
Was not expecting this function to return the enum itself. Input is enum<br=
>
and output is a hardcoded index like 0, 2, 5.</div>
<div style=3D"font-size: 11pt;"><br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
[HK]: Yes, this sort of follows up from previous comment.</div>
<div style=3D"font-size: 11pt;"><br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WARN_ON(1);<br>
<br>
pci_resource_len() expects a valid bar number.<br>
pci_resource_len(adev-&gt;pdev, amdgpu_get_bar_idx()) usage may invoke some=
<br>
static code analyzer warnings.<br>
<br>
Thinking again, a one-time assignment of below ones somewhere in early<br>
init amdgpu_init_pci_bars() may be simpler to deal with.<br>
<br>
gmc.aper_bar_idx<br>
rmmio_bar_idx<br>
doorbell.bar_idx</div>
<div style=3D"font-size: 11pt;"><br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
[HK]: Don't know about this. This sort of scatters the initialization unles=
s we add a new structure. Something like u8 pcie_bar_idx[PCIE_BAR__COUNT] t=
o amdgpu_device.&nbsp;</div>
<div style=3D"font-size: 11pt;"><br>
</div>
<div style=3D"font-size: 11pt;"><br>
<br>
Thanks,<br>
Lijo<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * amdgpu_device_resize_fb_bar - try to resize FB BAR=
<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt; @@ -1146,7 +1174,8 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_de=
vice *adev)<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* skip if the bios has alre=
ady enabled large BAR */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.real_vram_s=
ize &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (pci_resource_len(ad=
ev-&gt;pdev, 0) &gt;=3D adev-&gt;gmc.real_vram_size))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (pci_resource_len(ad=
ev-&gt;pdev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM)) &gt;=3D adev-&=
gt;gmc.real_vram_size))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Check if the root BUS has=
 64bit memory resources */<br>
&gt; @@ -1165,7 +1194,8 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_de=
vice *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Limit the BAR size to wha=
t is available */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; max_size =3D pci_rebar_get_max_size(adev-&gt=
;pdev, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; max_size =3D pci_rebar_get_max_size(adev-&gt=
;pdev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (max_size &lt; 0)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rbar_size =3D min(max_size, =
rbar_size);<br>
&gt; @@ -1178,9 +1208,11 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_d=
evice *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Tear down doorbell as res=
izing will release BARs */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_doorbell_fini(adev);<=
br>
&gt;&nbsp;&nbsp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; r =3D pci_resize_resource(adev-&gt;pdev, 0, =
rbar_size,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type &gt;=3D CHIP_BONAIRE) ? 1 &lt;=
&lt; 5<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; : 1 &lt;&lt; 2);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Resize the VRAM BAR. Exclude the MMIO BAR=
 from being released. */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D pci_resize_resource(adev-&gt;pdev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM),<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; rbar_size,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; BIT(amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_MMIO)=
));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r =3D=3D -ENOSPC)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
quot;Not enough PCI address space for a large BAR.&quot;);<br>
&gt; @@ -1191,7 +1223,8 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_de=
vice *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * using the device.<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_doorbell_init(a=
dev);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (r || (pci_resource_flags(adev-&gt;pdev, =
0) &amp; IORESOURCE_UNSET))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (r || (pci_resource_flags(adev-&gt;pdev,<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_g=
et_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM)) &amp; IORESOURCE_UNSET))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -ENODEV;<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_write_config_word(adev-&=
gt;pdev, PCI_COMMAND, cmd);<br>
&gt; @@ -3825,13 +3858,10 @@ int amdgpu_device_init(struct amdgpu_device *a=
dev,<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Registers mapping */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO: block userspace map=
ping of io register */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &gt;=3D CHIP_BONAIRE)=
 {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;rmmio_base =3D pci_resource_start(adev-&gt;pdev, 5);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;rmmio_size =3D pci_resource_len(adev-&gt;pdev, 5);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;rmmio_base =3D pci_resource_start(adev-&gt;pdev, 2);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;rmmio_size =3D pci_resource_len(adev-&gt;pdev, 2);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;rmmio_base =3D pci_resource_start(a=
dev-&gt;pdev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_=
MMIO));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;rmmio_size =3D pci_resource_len(ade=
v-&gt;pdev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_MMIO));<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMD_IP_=
BLOCK_TYPE_NUM; i++)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; atomic_set(&amp;adev-&gt;pm.pwr_state[i], POWER_STATE_U=
NKNOWN);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c<br>
&gt; index bc7858567321..826b80481908 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c<br>
&gt; @@ -201,14 +201,17 @@ int amdgpu_doorbell_init(struct amdgpu_device *a=
dev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (pci_resource_flags(adev-&gt;pdev, 2) &am=
p; IORESOURCE_UNSET)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (pci_resource_flags(adev-&gt;pdev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_DOORBELL)) &amp=
; IORESOURCE_UNSET)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_init_doorbell_in=
dex(adev);<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* doorbell bar mapping */<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell.base =3D pci_resource_star=
t(adev-&gt;pdev, 2);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell.size =3D pci_resource_len(=
adev-&gt;pdev, 2);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell.base =3D pci_resource_star=
t(adev-&gt;pdev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_bar_idx(adev=
, AMDGPU_PCIE_BAR_DOORBELL));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell.size =3D pci_resource_len(=
adev-&gt;pdev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_bar_idx(adev, AMDGPU_PCI=
E_BAR_DOORBELL));<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell.num_kernel=
_doorbells =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; min_t(u32, adev-&gt;doorbell.size / sizeof(u32),<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/=
amd/amdgpu/gmc_v10_0.c<br>
&gt; index 8523833a74fb..728d93e96ea1 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
&gt; @@ -694,8 +694,10 @@ static int gmc_v10_0_mc_init(struct amdgpu_device=
 *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
r;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_base =3D pci_resource_star=
t(adev-&gt;pdev, 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_size =3D pci_resource_len(=
adev-&gt;pdev, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_base =3D pci_resource_star=
t(adev-&gt;pdev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_bar_idx(adev, AMDGPU_PCI=
E_BAR_VRAM));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_size =3D pci_resource_len(=
adev-&gt;pdev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_bar_idx(adev, AMDGPU_PCI=
E_BAR_VRAM));<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp; #ifdef CONFIG_X86_64<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;flags &amp; AM=
D_IS_APU) &amp;&amp; !amdgpu_passthrough(adev)) {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/=
amd/amdgpu/gmc_v11_0.c<br>
&gt; index 16388e3caea3..a16e681b4de0 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c<br>
&gt; @@ -694,8 +694,10 @@ static int gmc_v11_0_mc_init(struct amdgpu_device=
 *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
r;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_base =3D pci_resource_star=
t(adev-&gt;pdev, 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_size =3D pci_resource_len(=
adev-&gt;pdev, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_base =3D pci_resource_star=
t(adev-&gt;pdev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_bar_idx(adev, AMDGPU_PCI=
E_BAR_VRAM));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_size =3D pci_resource_len(=
adev-&gt;pdev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_bar_idx(adev, AMDGPU_PCI=
E_BAR_VRAM));<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp; #ifdef CONFIG_X86_64<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;flags &amp; AM=
D_IS_APU) &amp;&amp; !amdgpu_passthrough(adev)) {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/=
amd/amdgpu/gmc_v12_0.c<br>
&gt; index 586703ec0dfa..5c2b4d2f3f16 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c<br>
&gt; @@ -746,8 +746,10 @@ static int gmc_v12_0_mc_init(struct amdgpu_device=
 *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
r;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_base =3D pci_resource_star=
t(adev-&gt;pdev, 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_size =3D pci_resource_len(=
adev-&gt;pdev, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_base =3D pci_resource_star=
t(adev-&gt;pdev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_bar_idx(adev, AMDGPU_PCI=
E_BAR_VRAM));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_size =3D pci_resource_len(=
adev-&gt;pdev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_bar_idx(adev, AMDGPU_PCI=
E_BAR_VRAM));<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp; #ifdef CONFIG_X86_64<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (((adev-&gt;flags &amp; A=
MD_IS_APU) &amp;&amp; !amdgpu_passthrough(adev)) ||<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v6_0.c<br>
&gt; index af6944d2d330..5bdcc276244c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c<br>
&gt; @@ -323,8 +323,10 @@ static int gmc_v6_0_mc_init(struct amdgpu_device =
*adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
r;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_base =3D pci_resource_star=
t(adev-&gt;pdev, 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_size =3D pci_resource_len(=
adev-&gt;pdev, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_base =3D pci_resource_star=
t(adev-&gt;pdev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_bar_idx(adev, AMDGPU_PCI=
E_BAR_VRAM));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_size =3D pci_resource_len(=
adev-&gt;pdev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_bar_idx(adev, AMDGPU_PCI=
E_BAR_VRAM));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.visible_vram_si=
ze =3D adev-&gt;gmc.aper_size;<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set the gart size */<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v7_0.c<br>
&gt; index 93cf283191fa..d8b81d8ec954 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c<br>
&gt; @@ -379,8 +379,10 @@ static int gmc_v7_0_mc_init(struct amdgpu_device =
*adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
r;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_base =3D pci_resource_star=
t(adev-&gt;pdev, 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_size =3D pci_resource_len(=
adev-&gt;pdev, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_base =3D pci_resource_star=
t(adev-&gt;pdev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_bar_idx(adev, AMDGPU_PCI=
E_BAR_VRAM));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_size =3D pci_resource_len(=
adev-&gt;pdev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_bar_idx(adev, AMDGPU_PCI=
E_BAR_VRAM));<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp; #ifdef CONFIG_X86_64<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;flags &amp; AM=
D_IS_APU) &amp;&amp;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v8_0.c<br>
&gt; index 1d3ddffd5a11..99bfd4e42977 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c<br>
&gt; @@ -572,8 +572,10 @@ static int gmc_v8_0_mc_init(struct amdgpu_device =
*adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
r;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_base =3D pci_resource_star=
t(adev-&gt;pdev, 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_size =3D pci_resource_len(=
adev-&gt;pdev, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_base =3D pci_resource_star=
t(adev-&gt;pdev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_bar_idx(adev, AMDGPU_PCI=
E_BAR_VRAM));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_size =3D pci_resource_len(=
adev-&gt;pdev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_bar_idx(adev, AMDGPU_PCI=
E_BAR_VRAM));<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp; #ifdef CONFIG_X86_64<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;flags &amp; AM=
D_IS_APU) &amp;&amp; !amdgpu_passthrough(adev)) {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v9_0.c<br>
&gt; index ced0f3941863..774e93590389 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt; @@ -1588,7 +1588,8 @@ static int gmc_v9_0_early_init(struct amdgpu_ip_=
block *ip_block)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * mode.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.is_app_apu =3D (pkg_type =3D=3D AMDGPU_PKG=
_TYPE_APU &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !p=
ci_resource_len(adev-&gt;pdev, 0));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !p=
ci_resource_len(adev-&gt;pdev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRA=
M)));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gmc_v9_0_set_gmc_funcs(adev)=
;<br>
&gt; @@ -1700,8 +1701,10 @@ static int gmc_v9_0_mc_init(struct amdgpu_devic=
e *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
r;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_base =3D pci_resource_star=
t(adev-&gt;pdev, 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_size =3D pci_resource_len(=
adev-&gt;pdev, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_base =3D pci_resource_star=
t(adev-&gt;pdev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_bar_idx(adev, AMDGPU_PCI=
E_BAR_VRAM));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_size =3D pci_resource_len(=
adev-&gt;pdev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_bar_idx(adev, AMDGPU_PCI=
E_BAR_VRAM));<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp; #ifdef CONFIG_X86_64<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
<br>
</div>
</body>
</html>

--_000_SJ2PR12MB86505425E2E6980C04EDE2D68C132SJ2PR12MB8650namp_--
