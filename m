Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968C0C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 23 May 2022 10:22:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ADC110E122;
	Mon, 23 May 2022 10:22:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11DF110E122
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 May 2022 10:22:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9FCeHtoM7o0x7N2oGb7RS8lKxEuU+m47fTdQfUOwhukleocmB/9OIwT1DSWbHZgKfJkhap+WJuBqmY3Qs3ePTjSaQF8Ofgw7r13qi9u5omY82qmc8OEntib/5LfO/BiGWvP1xwz/6qZ5NjaF1//i9jL1LzJQjJYxdedPjArlsqsussIdPs29tszfBz5P3d9v1xnl2xEYkhx05cKzwoKeYD24+86fQSjLqx/uAQ8KCO+1tvfAeRtr6pagg/Zg2cFiq34D2sG4cgzDMZ2LvSqdfg8oCMJEE3D/xF+tOrj4o+QfN2glaL2Zgx3lBjj5mp9NLBdWLXmnsremZIqMHH3zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V79P143htEOCh6O8AreslDp7kU73rI9ewYHey0227YY=;
 b=TqeFrjsq/PN0ICTmgYi9mpEo0k8VoYAimShNITJb6fZSkjOOZui7Lqkxn5kamgY2NztUjJh/77CfbaXPiY0E768sseFV2TKsbR3daH2zaa2OEGlSYq198QO5k6NWza1D7OHDxF7KiwzeSeHr6g6bkxSmWUTuJ3gqJPS3+gjGkjMns/A5gl/H67RIFbRirxDO/zfzEsktc1MWAYftMe+CznagTAGwVsFYkxPkDuit+7j22GuuuwxoiYlEH2TF1tinJa8n/IFxsO3Kk47PU68liiWpVoRnOVmYqIzqmq7wyUqRQ15PwLyRpLvriU/QZosqmtHQeUmkNuaAKEfrGLkrBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V79P143htEOCh6O8AreslDp7kU73rI9ewYHey0227YY=;
 b=ZYbtGrJANHBMl6Nh8OjNJE/wacyJoU9aoxEVoqJ8CvyUbH85JuMfjAVv53aTlqDMY0s+Sb40Oa1aNUM/oKJTiPkknODp1mnjLEmzbPmEJDFq112YQhcYQayLuNmhYX8IJnIF81sh3jDGQLUKL+7M3s8OHa9YlB6Um5FVA3J8eCE=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DM4PR12MB6472.namprd12.prod.outlook.com (2603:10b6:8:bc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.22; Mon, 23 May 2022 10:22:03 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::6191:648d:c4a:dff]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::6191:648d:c4a:dff%7]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 10:22:03 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH Review 2/2] drm/amdgpu: print umc correctable error address
Thread-Topic: [PATCH Review 2/2] drm/amdgpu: print umc correctable error
 address
Thread-Index: AQHYbn2FHhIcFVCCLEmFGRn5OBKA/K0sPxBw
Date: Mon, 23 May 2022 10:22:03 +0000
Message-ID: <DM5PR12MB1770C2DDFFE2A7442BEECAE1B0D49@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220523081701.32456-1-Stanley.Yang@amd.com>
 <20220523081701.32456-2-Stanley.Yang@amd.com>
In-Reply-To: <20220523081701.32456-2-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-23T10:22:02Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ef6b0da6-ecd6-4932-aa72-8f925770e0e2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cc28e6c-3fb3-4f12-1433-08da3ca61497
x-ms-traffictypediagnostic: DM4PR12MB6472:EE_
x-microsoft-antispam-prvs: <DM4PR12MB6472DA9EDF1C52E6FD62D9BEB0D49@DM4PR12MB6472.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g2ER2q/Kz4Vo+By1p0mzeYUnhzNpSZGpD0cMSNKKFB8nxkmr0GnLxxysrux43PjpMW4ue1wskplnduTuO0/Xa1nn99jC0kjfMyySf5jYXVzwqw81unkvpgCSo7MmIbPp2R7szWvDGopTwOwxxbtSs0xrxQqIGCJhCaEkGVSzxXBJwMLR+9ilErRSaIjXJEceE5niPr6ZM7fYWFdnleGXoIgUG9/uI6d2kef+CvZxJQAxTcbnAQiN8GpGyuu66turv2RMnbJxrBlpjPYstWml3TR9Zy8Qv5JF90ea0FUe/nH4+qVeqUThxro3FO1yklNy9ggXsk5lqux5UwDw5efbQShCDfvJ1V4wXFWjFnhe71YXCMOjI+Uyax5T+CXSFGjIqUoE6tuOmQ+QFwhR0w6USbUC2Chj1goeGBSqZSyDmWyeOhjK3tQ0D/YDq3GUYf2d5Sezl62UMXkDmQ1mBVYR3e3h0hpNpZ6K5uDzsx0xdP29LYsRlHaRKcxOTvd2y9qXJdlvANvU6l8IBLIMqSKZmHC2oUCrEVXQ0qDLGrWpV48uGhEdFhDy5ywe3xNfCy4wPZCNGxvyjqCCjcsvcCf6EtKHhGNWAKdEh7IXRR48msLxW1jdnn8y4Jdr3rEog+gyVh4rnCY9+jMCos8QFsVvwdSZnSVAA7dgY/j4VGkD59BHNSYeeT5CRWdjOHHigbUa9BUvF24lNbN6QMY3ofvdRw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(6636002)(83380400001)(508600001)(5660300002)(9686003)(55016003)(66556008)(26005)(66446008)(64756008)(76116006)(316002)(38100700002)(66946007)(186003)(66476007)(86362001)(53546011)(71200400001)(4326008)(8676002)(122000001)(33656002)(2906002)(8936002)(52536014)(38070700005)(6506007)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3vWwXtsgsB0hxYf6HnzNkIz4OBn87b3re4lImcRgqc8hxmM+Usekuye6yDed?=
 =?us-ascii?Q?FtJ1cT7Fc5mZY6fEd2mo8swuTmPUcUemAigMY5T4snYPimH2Yt2Oepfj/rAH?=
 =?us-ascii?Q?JkrPnIi2FH29DQvApSn8aEEgh29608SWg4llWvSgVFhaJviwKAxOS1DpWKTB?=
 =?us-ascii?Q?+Y16/7Ts+r2HNlmqh4g7VZsuB/3zL5DpLv9Mr+n4epLjOJz3d/iythbJGYX8?=
 =?us-ascii?Q?9bXy24z2doMxBJA6xl6kFnTrgEgYRkSgfZUxTm07YFFOnl5oqjimubfBewG4?=
 =?us-ascii?Q?gAdKK9Z+yLby0/fs8jK900PCBQNolPAa5vIaRol2RMCKaB5HDCNh6RNCHLdI?=
 =?us-ascii?Q?0iUmpn4SbEdE9ex0ZTelXyHAY+8UessL6p1xa69fU0diQU/2P7GMqfRnZfFT?=
 =?us-ascii?Q?cwi5WDWU70cAArV27V+lwttDJEFb0t10Z09G57I7wAzc0u2+GdttdijFGx8+?=
 =?us-ascii?Q?g49TTpB2uR+9qDGDviFZKLd4mrWXSvp+Tg9FbIe70fksP0bECf/HaF0sChEO?=
 =?us-ascii?Q?xsdOp1udDphYCjfJ+hXPd1y2fb53Au1Rpk6KWB+iLDUaoaicHGd/H4eUjjA/?=
 =?us-ascii?Q?kQTuczWmBCinh5BpJ0h434sc0N1jrGD7kdXqXXO4kNGuPlzuOGt/v0wt9gDc?=
 =?us-ascii?Q?G9Ap8YCSgrbkiSvJqYaMt3yvOOHAswyhAREVGY8U79TPA/nxW93KFqpXzk/q?=
 =?us-ascii?Q?Y7HnTG4HE+SpuE5td18LNhu30LMLz4uE5MdmEl9O/h96PhsKgdWl4dHl5/vi?=
 =?us-ascii?Q?h7NXchkVNN9FMKAP8aOSIILhAcciwLNVNEXeCX9KId2OYvsdC9PhPKqbdoHL?=
 =?us-ascii?Q?xJZtEVw11Bjt/yV2dnJXAIQVgSsZsUOkMd1zs97D2enDEuVjppU6iJNy+qNF?=
 =?us-ascii?Q?yh5zoP7JhY0jnYXookfghaHENAzHdjgiyPw/aMFnnkS4XfHoo2iGpr1xpeir?=
 =?us-ascii?Q?UONGDB8PD1CU+h9x7xzVyHtSrlrGGN/yGMtTrUP/cmokssSpglmf0RQGqN8l?=
 =?us-ascii?Q?Jizm0nHfv6AeM5t8+x0urt5v8c8Qf/T/1x4Obvs+NRWU8p7oVykjkO/eAu1u?=
 =?us-ascii?Q?ee5zxZ/+WMrnT0EXBxTi/SVgjhs7Daz1JLfe2Q2O+/2U7j/FRvECZjDnohG3?=
 =?us-ascii?Q?JOd9DnGqKDYI7YAJRhjZgQtbyXzaap2bF8WzRyMjcCSSaIREsjGIHoJyzsiw?=
 =?us-ascii?Q?FWix35zGpPLn7wUSeoz5fQl6sERLr3+EDiEi5wnt4ZpXJGLpyZe8r0JTpGAO?=
 =?us-ascii?Q?zrttLUN7RMJIHCvVsq2C2muWAMm4+Rt75e1MkCxd13EIuV/tdn85ljWgmN/7?=
 =?us-ascii?Q?YE0mMgabebemTFSDdCxm1kDyxIzUZDvJFOfnPGm7B0r8xVmf0e9N3peUvD7N?=
 =?us-ascii?Q?gtv07cfKeACFArD0wGmNpQgraPHo1CYEKBBwsBnvATY4z3x8VZEySpIPoa4A?=
 =?us-ascii?Q?aoqJ8FDVW25Vux8wdOtMIdO7gsTjGKKPJ00TbRcZmvXwTeuzYxM64OMSBLtb?=
 =?us-ascii?Q?zz4CwllOLeIoVLtJAhEwMlDmwqZvyBWUItUibgjt4U7dBs4kdFFmwqH7jdZn?=
 =?us-ascii?Q?9nFdrLYISbt/VRX1k9amF3MCLMMDkywj/NLSXj67IeFYVRFSrupfRNlS3lnQ?=
 =?us-ascii?Q?K1FVdIcfLr/3+I1dJuPiy8aPgcL8FIelhfhB6r9jIFQYv4qZw/+g9AcC3Esy?=
 =?us-ascii?Q?ClOnPFz2PqjKXdNXJUfDuziJ16wAKJecOAf25kg0pmTxn2GL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc28e6c-3fb3-4f12-1433-08da3ca61497
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 10:22:03.3873 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T0f4t9gC+JwQ3w1qsgkwB41K6o5CB/Q9AFgm6dFkihCh+Hle0QBRfDV5Ws0Cu4N+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6472
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Monday, May 23, 2022 4:17 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Quan,
> Evan <Evan.Quan@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 2/2] drm/amdgpu: print umc correctable error
> address
>=20
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  5 ++
>  drivers/gpu/drm/amd/amdgpu/umc_v6_7.c         | 55
> ++++++++++++++++++-
>  .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  2 +
>  3 files changed, 60 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 3f23f9ad3249..985b8cddb5a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1108,6 +1108,11 @@ struct amdgpu_device {
>=20
>  	bool                            scpm_enabled;
>  	uint32_t                        scpm_status;
> +
> +	/* Determine smu ecctable whether support
> +	 * record correctable error address
> +	 */
> +	int record_ce_addr_supported;
>  };
>=20
>  static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> index 606892dbea1c..47bd39e52e9b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> @@ -119,6 +119,27 @@ static void
> umc_v6_7_ecc_info_query_correctable_error_count(struct amdgpu_device
>  		*error_count +=3D 1;
>=20
>  		umc_v6_7_query_error_status_helper(adev,
> mc_umc_status, umc_reg_offset);
> +
> +		if (adev->record_ce_addr_supported)	{
> +			uint64_t err_addr, soc_pa;
> +			uint32_t channel_index =3D
> +				adev->umc.channel_idx_tbl[umc_inst *
> adev->umc.channel_inst_num +
> +ch_inst];
> +
> +			err_addr =3D ras-
> >umc_ecc.ecc[eccinfo_table_idx].mca_ceumc_addr;
> +			err_addr =3D REG_GET_FIELD(err_addr,
> MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
> +			/* translate umc channel address to soc pa, 3 parts
> are included */
> +			soc_pa =3D ADDR_OF_8KB_BLOCK(err_addr) |
> +
> 	ADDR_OF_256B_BLOCK(channel_index) |
> +					OFFSET_IN_256B_BLOCK(err_addr);
> +
> +			/* The umc channel bits are not original values, they
> are hashed */
> +			SET_CHANNEL_HASH(channel_index, soc_pa);
> +
> +			/* clear [C4 C3 C2] in soc physical address */
> +			soc_pa &=3D ~(0x7ULL << UMC_V6_7_PA_C2_BIT);

[Tao] this clear is the preparation for looping all column bits in same row=
, you only need physical address of one page, the code can be removed.

> +
> +			dev_info(adev->dev, "Error Address(PA): 0x%llx\n",
> soc_pa);
> +		}
>  	}
>  }
>=20
> @@ -251,7 +272,9 @@ static void
> umc_v6_7_ecc_info_query_ras_error_address(struct amdgpu_device *adev
>=20
>  static void umc_v6_7_query_correctable_error_count(struct
> amdgpu_device *adev,
>  						   uint32_t umc_reg_offset,
> -						   unsigned long
> *error_count)
> +						   unsigned long
> *error_count,
> +						   uint32_t ch_inst,
> +						   uint32_t umc_inst)
>  {
>  	uint32_t ecc_err_cnt_sel, ecc_err_cnt_sel_addr;
>  	uint32_t ecc_err_cnt, ecc_err_cnt_addr; @@ -295,6 +318,33 @@
> static void umc_v6_7_query_correctable_error_count(struct
> amdgpu_device *adev,
>  		*error_count +=3D 1;
>=20
>  		umc_v6_7_query_error_status_helper(adev,
> mc_umc_status, umc_reg_offset);
> +
> +		{
> +			uint64_t err_addr, soc_pa;
> +			uint32_t mc_umc_addrt0;
> +			uint32_t channel_index;
> +
> +			mc_umc_addrt0 =3D
> +				SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_ADDRT0);
> +
> +			channel_index =3D
> +				adev->umc.channel_idx_tbl[umc_inst *
> adev->umc.channel_inst_num +
> +ch_inst];
> +
> +			err_addr =3D RREG64_PCIE((mc_umc_addrt0 +
> umc_reg_offset) * 4);
> +			err_addr =3D REG_GET_FIELD(err_addr,
> MCA_UMC_UMC0_MCUMC_ADDRT0,
> +ErrorAddr);
> +
> +			/* translate umc channel address to soc pa, 3 parts
> are included */
> +			soc_pa =3D ADDR_OF_8KB_BLOCK(err_addr) |
> +
> 	ADDR_OF_256B_BLOCK(channel_index) |
> +					OFFSET_IN_256B_BLOCK(err_addr);
> +
> +			/* The umc channel bits are not original values, they
> are hashed */
> +			SET_CHANNEL_HASH(channel_index, soc_pa);
> +
> +			/* clear [C4 C3 C2] in soc physical address */
> +			soc_pa &=3D ~(0x7ULL << UMC_V6_7_PA_C2_BIT);
> +			dev_info(adev->dev, "Error Address(PA): 0x%llx\n",
> soc_pa);
> +		}
>  	}
>  }
>=20
> @@ -395,7 +445,8 @@ static void umc_v6_7_query_ras_error_count(struct
> amdgpu_device *adev,
>  							 ch_inst);
>  		umc_v6_7_query_correctable_error_count(adev,
>  						       umc_reg_offset,
> -						       &(err_data->ce_count));
> +						       &(err_data->ce_count),
> +						       ch_inst, umc_inst);
>  		umc_v6_7_querry_uncorrectable_error_count(adev,
>  							  umc_reg_offset,
>  							  &(err_data-
> >ue_count));
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index e58df9490cec..e182088b4ac8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1908,6 +1908,8 @@ static ssize_t aldebaran_get_ecc_info(struct
> smu_context *smu,
>  				ecc_table_v2->EccInfo[i].mca_umc_addr;
>  			ecc_info_per_channel->mca_ceumc_addr =3D
>  				ecc_table_v2->EccInfo[i].mca_ceumc_addr;
> +			if (!smu->adev->record_ce_addr_supported)

[Tao] it seems the check is unnecessary.

> +				smu->adev->record_ce_addr_supported =3D1;
>  		}
>  	}
>=20
> --
> 2.17.1
