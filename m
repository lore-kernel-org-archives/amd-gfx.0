Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D361C61DA4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 06:27:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1AD110E0C3;
	Mon,  6 Mar 2023 06:27:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84F1A10E0C3
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 06:26:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyD0iQDeg4AfvpZYro5rx3bx+4Y6skX9ny5aPQQNRuuXGaJzD1NPMvU73IUQEK1+rnFHKkL1ihMoaxUGRnn4iZw06CZGcEq0i6xLTVVUxbzWRMbVf9dpT7A34ldZ/2RvcqV7t9bpY6H0xCHX9Wkjk+RUmyCxRotMwv5olbu+XfapNzdGsKFhgsQMCTB8xKEwkigXnCU+9XcLkoX5L3oDUVLCnSltnHnAjK7E0jYV3F/QbtnKB8zL9qGpxxJvK7qKUoquxRmWeVIwJT7BEFUhTQCkiEDQGelWW/k/SuXoVYZ3Sp2cqhyosZ5gh6qSCb7zvXBtzosqUTL9QwdSZcFtuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XJee1HgRmzCdrPy4t+lTEIr7Q3NLBiTNBzAtdPFgAk=;
 b=LBh0sriLWRGK0AqbxfXGsyb80TtnzI19Qy6ObCtFyM4DX89jmJoGex9K/fu52cKwEG4ioccrqOdX0+AqMywMmyzjVWCd+PBYqzYOH/iHB+3T2mIkpWxWkorZZJHtEeoHdkW64L9l3zzlXr1doq69JM/muyLK303dpTZLOi4U0bZmWUnqryoTHS77LNI2r8FYPfmwfKnuUoCIWxAZsAGGdoh73gXMjXIJZ7TQgYjz6gH1l9G5s961rYkiMgOuXCC+QqQhp7trA2wPVIrao56wWWQHDjodAMJ4Uoz8p+cN7605ZB6dHw4JmqJajni7oJtN1vcKZgrikqhLVGYeW412EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XJee1HgRmzCdrPy4t+lTEIr7Q3NLBiTNBzAtdPFgAk=;
 b=CXE/rNgXqMM0X7TCQvGM57UtYR/J9bsG6zSL4y3l7kg3SPG4pus3G4DULFQvVu+VXpk9HHhFETf3YjyYCtk5NiU+a7uriPo1aAOHCj79vVwpXaLBcOqcGedW5kWu14P7L/DAW8EB50i97TkxyaLctDf3hGgycEOXCbwkAwAOowo=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by SA1PR12MB6824.namprd12.prod.outlook.com (2603:10b6:806:25f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Mon, 6 Mar
 2023 06:26:55 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::e52b:f6b6:5b71:cd92]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::e52b:f6b6:5b71:cd92%9]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 06:26:54 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 01/11] drm/amdgpu: Move jpeg ras block init to ras sw_init
Thread-Topic: [PATCH 01/11] drm/amdgpu: Move jpeg ras block init to ras sw_init
Thread-Index: AQHZT9PsljOBYW3INke6vovFEJGOua7tSVHg
Date: Mon, 6 Mar 2023 06:26:54 +0000
Message-ID: <DM5PR12MB17708FA4608FCF29B650A50CB0B69@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20230306023200.29158-1-Hawking.Zhang@amd.com>
 <20230306023200.29158-2-Hawking.Zhang@amd.com>
In-Reply-To: <20230306023200.29158-2-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1770:EE_|SA1PR12MB6824:EE_
x-ms-office365-filtering-correlation-id: 9b31ee09-e0f7-4ecd-018b-08db1e0bc7ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cm36IyFAfO6vUp2zxCaOQozIt6w15qNQWUFsTrjmvfF0EYo3jVISu3P8oNaQGgusyQ/1j9tzTO/LeKVXQOYjioiJHFY0ien1reo7fAtEkYGKphzq0xgiJDe3Z0UWlWN90OkA/PVNXyp56vk/nB7XN7vjVAXop7/jqavq3PsL5INWkTs/MdEOvuiIRxT0/vnomhBjjEIjPpRV1WjQI/E9rKPqxND4DFzddWEef04Sx/zVrvzX3FlmbwKUotNElJbMS2PHAwwYaXS2E6FM4fGlJfDiBv4yNDta9h0hphMDI/iiGw5uix2MN/z0qNN02lGP8Opsp/cp645UeLZm2Uzaqfo3wUBOJIydvcC4ou4jdn5XVnvu+BtvzvkTiGrYum4aunn7MDreM+YDT08/C+BpfuERD5knBmLuWCyx+xHBW6g8jpJpTdHLRkvjv7yy7RK5EhV9u5qCpjdySS4NLeeNksGoPbKmRug+gv6R6vo7w/7aUmpnEG6FEhAi00UwGQvsLSwTdLwoY5X0ZtDVKk8Wb9UOi2GtXMMWwYTsF5sZq1UpUH0BLmIlzFSLjRrp8LNpbaxxstXEvX8YLHT6JH+Afz+ajIINj3jnRQsIAG59XR22qQcVI9hOKyjL+pcRahpNxz+gdiEv1z3H82b1QEVSPxG/5uJGgpDlgGKZPJgIH5VGMtq5ceAlUJ67FEMd0xf42VVY9WiBLR12JpNwXCDCUbDh4z3/roHo5H3GjZ38jEM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199018)(8936002)(52536014)(5660300002)(66476007)(66446008)(41300700001)(76116006)(66556008)(66946007)(2906002)(8676002)(64756008)(110136005)(6636002)(316002)(478600001)(7696005)(71200400001)(26005)(6506007)(53546011)(186003)(86362001)(33656002)(122000001)(83380400001)(38070700005)(55016003)(38100700002)(9686003)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?es6a8AzRW/97O6USKpv7KLqLwz2ZbCWqqiEC/KrPOVm5QEh6c4DGNSsQypVU?=
 =?us-ascii?Q?X3SQlwk6V86fthS+9iUvnr9TDg/T0eAYk5gEkAAyh0qnvF/0kfxHosDoOgW4?=
 =?us-ascii?Q?mYPXkMloLT8bSplKk/laUzuQ+CO8yrLRScGZg9+FqJfQkeNjaTmXjGXr/Xs6?=
 =?us-ascii?Q?sSTP2zgj18wS4PlJ74UrLLD9nc9AceOwpBGeYpLA4uhaAKl7APmNZsR43cvN?=
 =?us-ascii?Q?2qKvvhjkzJlmgi+LnWCW305UxRp16reoiDRW0EAxsBrQ+zC5ZhZa2xL3Ke3u?=
 =?us-ascii?Q?PPp9G54fqTM8i6ReLKp0Ah9OkQdtwKqtPuT1a4O2nfkGRq8rIBLTesQ3YBxa?=
 =?us-ascii?Q?GwbGhY1Wal/EHygLZ/oUZk+bQ6fjUmmRmLWGL81xqXv8fNsNLLAkE96Gu2+K?=
 =?us-ascii?Q?mMPQjW3FXvQJxkPW2/BM0UPDW8hjIJYJJqIkOGl8S2CIN/zOl3tp47NWn7N4?=
 =?us-ascii?Q?iJkQn0DhGqvJpaz477pqRsZf/iWkTgDsOaGmGia0lroLaOUeK0x7RJBSF6jp?=
 =?us-ascii?Q?PX2lSSSXtwia5dhbDQhMuP9p2SDtlRdwKBdTgGaGs4ofzx0V8IE3X89i6RjJ?=
 =?us-ascii?Q?etifVU7VBTAl4uF/QQYw+NoEo4VwBNQLZZVberr7NCpJ2c46YLhhbljWxMtg?=
 =?us-ascii?Q?whJ4IdpF/IHGm0ew0WKThs+sfOoN2eGBdETbqVrYt1WyjXOo7obBo7rFDib+?=
 =?us-ascii?Q?FLFqluEwf3u4EMKxAQ6qUzLR+7zFwNryyBiBXKJzg2OdTTd7CXnmJwnVGm11?=
 =?us-ascii?Q?naoGw5o6vT/FeK6QS54SmV+qo4bQ3srlChOUbXYNugBGg9bC5ICjhime99Pg?=
 =?us-ascii?Q?+BwzYvs8CYR9gWXIkGzXmTdMkxNlejF5UmgK0tHCjWLxXIFCDau8/yO9S291?=
 =?us-ascii?Q?/gl5CdCmrhbE4NPbGFt2MTc2+j6Dfws8lThG7rZVe1hy2ttlMYhwUMiVl6so?=
 =?us-ascii?Q?UZdMfDSrFgG6PiMP0L3Urkd708BWNy8PCDVsAsjEh+nNpZSMxioV1zNP0ubA?=
 =?us-ascii?Q?E1OVj3+9cIR3JNWj8O9po/+D/Q8XEtN1HRTkLhumxB3i5AznnH0ZpIF8D7Er?=
 =?us-ascii?Q?8KiC6Yj2kBoBtnYmVN3vy7VLYx7CM+OEPeP+bxTYxEVLsG9tqoSYecF3isQj?=
 =?us-ascii?Q?lWLDp/EdxlzfibV7p4q1vB6rrsj1B75mhpZ4MaRoW1DLEmU14DIJH7xdLnwH?=
 =?us-ascii?Q?5Gmlcl4VCkodW86xpOC17roqyWgk9QuAWpyc8nrluo8tYPl2CQzPIXOpFLlp?=
 =?us-ascii?Q?BvHlYxHDkUMUQc/pfFv4WvzZjc1oYG+cN3/57QdXYEp91yHsz2z6iHZCQBos?=
 =?us-ascii?Q?sVro3+PMbD1jqINS4WB0L1FPhl1niL5lOr1PcSIz7QgRlW79sIs3pp+vLF2k?=
 =?us-ascii?Q?2hXKu+YiwibKALs7f6yRLa9LeCz/aevza7WJ/fUThha7gjNfOURNKkIqguFU?=
 =?us-ascii?Q?fvJC94XV/GD4p5w5HKoEARmlTgkzFmlalxUweIum2Q7VAJ3RLaoV8smFuLt6?=
 =?us-ascii?Q?H0gP0YaCmK3W43q34+pFqFyoc68ouT5jKBWVzycrVS3EVIPhqdccacOplZgh?=
 =?us-ascii?Q?Hz+A6oKfyiTIu0d4r+I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b31ee09-e0f7-4ecd-018b-08db1e0bc7ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 06:26:54.6222 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ugu8KxMBNgzDCmCCqJ+NxD+hdYqv6/IMci1z3bj66R3fo+INuAbL2NSqYupVCKgr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6824
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



> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Monday, March 6, 2023 10:32 AM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>; Li, Candice <Candice.Li@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH 01/11] drm/amdgpu: Move jpeg ras block init to ras sw_ini=
t
>=20
> Initialize jpeg ras block only when jpeg ip block supports ras features. =
Driver
> queries ras capabilities after early_init, ras block init needs to be mov=
ed to
> sw_int.
>=20
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 29 ++++++++++++++++--------
> drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   | 10 ++++++--
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   | 10 ++++++--
>  4 files changed, 36 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index 8f472517d181..74695161cf1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -235,19 +235,28 @@ int amdgpu_jpeg_process_poison_irq(struct
> amdgpu_device *adev,
>  	return 0;
>  }
>=20
> -void jpeg_set_ras_funcs(struct amdgpu_device *adev)
> +int amdgpu_jpeg_ras_sw_init(struct amdgpu_device *adev)
>  {
> +	int err;
> +	struct amdgpu_jpeg_ras *ras;
> +
>  	if (!adev->jpeg.ras)
> -		return;
> +		return 0;
>=20
> -	amdgpu_ras_register_ras_block(adev, &adev->jpeg.ras->ras_block);
> +	ras =3D adev->jpeg.ras;
> +	err =3D amdgpu_ras_register_ras_block(adev, &ras->ras_block);
> +	if (err) {
> +		dev_err(adev->dev, "Failed to register jpeg ras block!\n");
> +		return err;
> +	}
>=20
> -	strcpy(adev->jpeg.ras->ras_block.ras_comm.name, "jpeg");
> -	adev->jpeg.ras->ras_block.ras_comm.block =3D
> AMDGPU_RAS_BLOCK__JPEG;
> -	adev->jpeg.ras->ras_block.ras_comm.type =3D
> AMDGPU_RAS_ERROR__POISON;
> -	adev->jpeg.ras_if =3D &adev->jpeg.ras->ras_block.ras_comm;
> +	strcpy(ras->ras_block.ras_comm.name, "jpeg");
> +	ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__JPEG;
> +	ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__POISON;
> +	adev->jpeg.ras_if =3D &ras->ras_block.ras_comm;
>=20
> -	/* If don't define special ras_late_init function, use default ras_late=
_init
> */
> -	if (!adev->jpeg.ras->ras_block.ras_late_init)
> -		adev->jpeg.ras->ras_block.ras_late_init =3D
> amdgpu_ras_block_late_init;
> +	if (!ras->ras_block.ras_late_init)
> +		ras->ras_block.ras_late_init =3D amdgpu_ras_block_late_init;
> +
> +	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> index e8ca3e32ad52..0ca76f0f23e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> @@ -72,6 +72,6 @@ int amdgpu_jpeg_dec_ring_test_ib(struct amdgpu_ring
> *ring, long timeout);  int amdgpu_jpeg_process_poison_irq(struct
> amdgpu_device *adev,
>  				struct amdgpu_irq_src *source,
>  				struct amdgpu_iv_entry *entry);
> -void jpeg_set_ras_funcs(struct amdgpu_device *adev);
> +int amdgpu_jpeg_ras_sw_init(struct amdgpu_device *adev);
>=20
>  #endif /*__AMDGPU_JPEG_H__*/
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index f2b743a93915..7400ed1449e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -138,6 +138,14 @@ static int jpeg_v2_5_sw_init(void *handle)
>  		adev->jpeg.inst[i].external.jpeg_pitch =3D
> SOC15_REG_OFFSET(JPEG, i, mmUVD_JPEG_PITCH);
>  	}
>=20
> +	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG)) {

[Tao] can we move the check into xxx_ras_sw_init?

> +		r =3D amdgpu_jpeg_ras_sw_init(adev);
> +		if (r) {
> +			dev_err(adev->dev, "Failed to initialize jpeg ras
> block!\n");
> +			return r;
> +		}
> +	}
> +
>  	return 0;
>  }
>=20
> @@ -806,6 +814,4 @@ static void jpeg_v2_5_set_ras_funcs(struct
> amdgpu_device *adev)
>  	default:
>  		break;
>  	}
> -
> -	jpeg_set_ras_funcs(adev);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index 3beb731b2ce5..f9f682336b3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -113,6 +113,14 @@ static int jpeg_v4_0_sw_init(void *handle)
>  	adev->jpeg.internal.jpeg_pitch =3D
> regUVD_JPEG_PITCH_INTERNAL_OFFSET;
>  	adev->jpeg.inst->external.jpeg_pitch =3D SOC15_REG_OFFSET(JPEG, 0,
> regUVD_JPEG_PITCH);
>=20
> +	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG)) {
> +		r =3D amdgpu_jpeg_ras_sw_init(adev);
> +		if (r) {
> +			dev_err(adev->dev, "Failed to initialize jpeg ras
> block!\n");
> +			return r;
> +		}
> +	}
> +
>  	return 0;
>  }
>=20
> @@ -685,6 +693,4 @@ static void jpeg_v4_0_set_ras_funcs(struct
> amdgpu_device *adev)
>  	default:
>  		break;
>  	}
> -
> -	jpeg_set_ras_funcs(adev);
>  }
> --
> 2.17.1

