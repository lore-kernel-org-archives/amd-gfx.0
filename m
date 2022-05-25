Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4116C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 03:28:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E9491120A7;
	Wed, 25 May 2022 03:28:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E38B01120A7
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 03:28:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBKuPsx1y/I60A4os90Zk+mgG1jDWPweejUGOcYrZ98dSaQPfAHPy/UCfmMEycKbGyA7nVzVXoDyvPLPD33EiyaJ/y67rxFYk7s10x3UkyWv9MsBemx8Y85C2SmdfpwPIi8vkOoKQhGfeUNxG4s82MUwbWxgVcugZdxSj113/VyvTDB1jxfx6nH7fndxlNACpFMhQ0bm5LJERTWMcI3ijc7t/mO7viK6s4WwIa622qvGvgOAjgYlqwjP7+ewHZmBImS7yJsMKMZjizT+MQvD7qAwbbfIHKhRQ+ifzNCuiF6tNeQwvM9YOwJKSUieQBGd3ZUVjd6AH9QRIHJvATNaLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Z0y3gtZJikK2zvxJPspG/IzzQpqhviG5N7FbrtVncU=;
 b=ZwDSODsh9Mkd1eRIWCsdr1JR57qZH/fmkZ8HPjMa7BrgAwIsJo/ZyDW0nEpQEpnrvep7OTBEpalXCVvkCaPxM/d5DAOHA/RyGXWnAd0zUvnK4sR735yzijqeL8osFdFMN9n7jejtGX5QCrDtkISzjm7a8gD4DWTXYRTcuHPpUjoHmes+RBtYg8WxLgT855sv5yfTD1Zia6yiM6A/rDerLWyBtc2dUN0niRr7GxwpyauNj9NA20DugG8msrM1Cx6tuyBmo3uYmk7X52LvgiRpNFZjlV7XGaVCCNfXHSxNAnAaueukW4demWK0jDG9ltJHSNtfcA2kIOtCMIwdCD6MqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z0y3gtZJikK2zvxJPspG/IzzQpqhviG5N7FbrtVncU=;
 b=oMgQM0J3NoB6gWvAIxxsWRPYmVpb0mG5YrPG/cERqTHSd3eMUIkq3rrdXnEHXG/eKnKrrPsMxE/xS6XsthUy/scY2fPCWmMWTP+Fwm49lS0qARZXD1T5ZoFYOAl5xxTTL820O9Jr8ccBh7amWBGoRIDdtyKFqe64bRRLO16GLO8=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DM5PR12MB2487.namprd12.prod.outlook.com (2603:10b6:4:af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Wed, 25 May
 2022 03:28:17 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::6191:648d:c4a:dff]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::6191:648d:c4a:dff%7]) with mapi id 15.20.5273.023; Wed, 25 May 2022
 03:28:17 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH Review v2 2/2] drm/amdgpu: print umc correctable error
 address
Thread-Topic: [PATCH Review v2 2/2] drm/amdgpu: print umc correctable error
 address
Thread-Index: AQHYb3rnwiB/ibLZ0kGauhjrbypbxq0u78Pw
Date: Wed, 25 May 2022 03:28:16 +0000
Message-ID: <DM5PR12MB17701838A04D2C7098A4D240B0D69@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220524143055.11723-1-Stanley.Yang@amd.com>
 <20220524143055.11723-2-Stanley.Yang@amd.com>
In-Reply-To: <20220524143055.11723-2-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e423df6f-310f-46c3-bbb7-08da3dfe9bb2
x-ms-traffictypediagnostic: DM5PR12MB2487:EE_
x-microsoft-antispam-prvs: <DM5PR12MB2487C671F7737B665800C777B0D69@DM5PR12MB2487.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +eEZcw4vNtOWSXjjGYfgCy1sFY7icbJxUOe+EZF3lkMWmKugkKoMxJzi6/S2awj5zA0K66y6X952B/mGBmrgdJ5+RIl6W5rezB6AK+Dm0moWI+qCetJ4GNp1kL72ow+Zc2+65qpl2Uv0KlHp2rHtg4d26QrZjIK4zt1/qttv69TQ6X+/EiavBrxW0xq3aczwY1Dr8lg/nwYyB2ht8BT/KDcMdmQE+ZNDkpPsxt7BWLoFl7nYGHQpgIZubjoZfKxk2jykCeMpxNXG+enMGmUgkzeZSqxnLiXJ7m3c5eYz60NhW84oggJ6Cz2WdcHvmDzO6+weBsJ1OVEGkCRSpkggcJp5iewc/48RyKATLBlMFsS9n/t2qzWL4So/3d5oGp+A6mLHGca4BthB1BfuGj60rKRqzlEXORwRJeN0MPmWTpcyh+dW5huP+NBiV2mbwqoxJ/Wmu1zMA4WKZ3LT/z2eKu+o+iQqpKmhUD+BGY0pI1UdVU9RB2W0xEMW2WKpBUFMlgai5lRLk9+b9KrAcmGEJtrS2qrq/+xkC4CbLeN6h4027+umprLV6LAM8ka+sv2+O13IMs0yl2x/iS+U2UBUDxbccNQQ7VsKvGpj5fJu3rKaHBqOjVoLwgiMnyUA+AXpGCCWb4czHfZqTImDl/39ciu5tnVdFQf5ICnRkwqpQ/lYbGzFiXKy/3HqbmzbdHJUzuO+NMy+ZdDbZ8gbOwfTFQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(71200400001)(33656002)(8936002)(110136005)(66476007)(2906002)(5660300002)(52536014)(316002)(66946007)(83380400001)(4326008)(8676002)(66556008)(64756008)(76116006)(66446008)(86362001)(38070700005)(9686003)(26005)(38100700002)(53546011)(6506007)(6636002)(7696005)(122000001)(55016003)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P3okGdk0TSed7PMQEK63Jh4nx6T0j5S4dseJerPm58gH9g1pb8qWkHhoPgNy?=
 =?us-ascii?Q?fROMoRBpjSHY8wKINNKoTIuHR1iU1cNxZ6NsRCiJ7LzPWoJjwiMJXkGcpbIg?=
 =?us-ascii?Q?WN65aGXEpFmmhC8eaaI+6oOXS4yMXHLp5QtVWsDbWHntbzTN9NMZwDwqi2yO?=
 =?us-ascii?Q?ITUKZhCieeP+1dnyMGn5t1tVa3lE72DRNzs9nKoOp2MLvYPGXxmY3E34wZDq?=
 =?us-ascii?Q?xZSwWC6eVwzyWcFnh3YL1kZI2Naj3sEBDi4jUVmXoCcezO6rpcTmL69aMBZJ?=
 =?us-ascii?Q?qyd2Y9uaZsSOgi7gb8YIs6+9HcTxnQ7wIPLNBNOItgam/snmOxzaLdhKDxOm?=
 =?us-ascii?Q?5fR+3dbCyO+R/4vprr1nW92J0aG0N5sLjRwcxr4YtUOfhDmAOftteZ4V92us?=
 =?us-ascii?Q?M1CJt6KkQS8/Yb0aLAoc8fYpKrdn2P3EUjVfBTLbVMGctEFBw9tStrcdBLwt?=
 =?us-ascii?Q?WYtlBua8wrUEZnjhYzRGAkxdBjnSaI22ZtgOMl78cZFh9EVkCqgnswAE6Y43?=
 =?us-ascii?Q?On5vn83YnH4dB/cVhivcjtVudRhMkWTXprS7G1MeYs1grCV20fgChTQ18HFc?=
 =?us-ascii?Q?pOHVi6P4EKRibyK9drF46CYcF3ERMkcH1uFpJiUd1AGDd9uNw5BcKEm0BBh8?=
 =?us-ascii?Q?vLM7HlMD6Vfy44FTn3/t2xMmzfYLx5CrKiN1KDxuLlwKljB9mftrPYMGh76T?=
 =?us-ascii?Q?puN0y1WQQWNotPQOAOnc3mtJL1BRY8k4T4A3xUtfzkKmoYvZS0faFQ2NRvV+?=
 =?us-ascii?Q?ViQVom8BzKG+4Hl9vRrvop2x47IzN38BqEH0RMlhL63xGHjByWSojH7wIJc2?=
 =?us-ascii?Q?9soTieAqoURuafs+MDoVbtlCe6vdnamWMWKM+eQHnb4YlhkIi1BPTZjbEsh0?=
 =?us-ascii?Q?hIOKylsh3Qa5TIJ6TVO5uDg4SfvVp1jqT2qT7ElqpOHCDNZ9OJTN+dVXOsbB?=
 =?us-ascii?Q?WQz6pBwcx7AvBckZXf8Gjxamn2CBQ01Au3KffVls9hzw2dF4Whwmp9n+T0dY?=
 =?us-ascii?Q?lzh5C3Bwka5/NDOrc9GBjBrOGn6Yt2zrj/cTr2tCP8ZEzq0UtDi0+zjYpZ8F?=
 =?us-ascii?Q?vsDRYdEgL+5JcqZtOle1FIG2qjbcAbXWopssFeLhJN7Ptt2GaSZyEJSHUxyH?=
 =?us-ascii?Q?tBVpPoVgVM+K++pDg2K419bb6B1LwQGPOsekil5L7sw3lopZ0QqsFIfUnwu/?=
 =?us-ascii?Q?jo+JtCOyfwdmw3P29pQcpA7e/7MYwD+THVAqVi49fKsojqCJ92JxE1xGHEew?=
 =?us-ascii?Q?njVrGzBPFcTZwsPuXBt1uIekox2j5I0mY5wKNfkf2vQGT1/O4MFNddHfyQ/U?=
 =?us-ascii?Q?98GyPSCSeZL1A2N6Fu3QSb9sogCGPxW4Fwdnl5AIsCCAbjW2Dxvz9d3rU7jq?=
 =?us-ascii?Q?hds5SjKnEZ/JsLYtKGWJZKMSWXoy3tPDgc5rnki6BSL/lDTsO3u3sx3RvDas?=
 =?us-ascii?Q?7QwvdkHubO4x0uQfXHwxga/if6886bRQGOw7y4MqZocwUk2JvsK1XxIGjtsR?=
 =?us-ascii?Q?zVkkfT5xkvW2RolzUfzXXlzpU7xIZbZGOO3ENTi0HkQkEY5G/ynmBtui77rC?=
 =?us-ascii?Q?EGq/McUJJS5ygCLjxzFYmZEDD/tjf4HB1jVC3oC3jcGGRZgc/NsinJg6RPiG?=
 =?us-ascii?Q?pOOyd2aDElJ+Y+oav20+DM5S+4IrFxN5LYoQl5QyCclL7G3Ua+WBgaN4gZdS?=
 =?us-ascii?Q?LMPLbqgQMD9OG2x6rkR5wXDVRRRquFG2aDht9izFY/yTrP8HjmCoJeDlXIvb?=
 =?us-ascii?Q?ITiKwRnWlg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e423df6f-310f-46c3-bbb7-08da3dfe9bb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 03:28:16.9203 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mY2Y/PO99EWFvKp8pECs79l6qtKl03t6fERS9X0HnQ3zMCpHouMRD0FXbSwTmNZM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2487
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



> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Tuesday, May 24, 2022 10:31 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review v2 2/2] drm/amdgpu: print umc correctable error
> address
>=20
> Changed from V1:
> 	remove unnecessary same row physical address calculation
>=20
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  5 ++
>  drivers/gpu/drm/amd/amdgpu/umc_v6_7.c         | 52 ++++++++++++++++++-
>  .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  1 +
>  3 files changed, 56 insertions(+), 2 deletions(-)
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
>  static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)=
 diff
> --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> index 606892dbea1c..91bdc5e048c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> @@ -119,6 +119,24 @@ static void
> umc_v6_7_ecc_info_query_correctable_error_count(struct amdgpu_device
>  		*error_count +=3D 1;
>=20
>  		umc_v6_7_query_error_status_helper(adev, mc_umc_status,
> umc_reg_offset);
> +
> +		if (adev->record_ce_addr_supported)	{
> +			uint64_t err_addr, soc_pa;
> +			uint32_t channel_index =3D
> +				adev->umc.channel_idx_tbl[umc_inst * adev-
> >umc.channel_inst_num +
> +ch_inst];
> +
> +			err_addr =3D ras-
> >umc_ecc.ecc[eccinfo_table_idx].mca_ceumc_addr;
> +			err_addr =3D REG_GET_FIELD(err_addr,
> MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
> +			/* translate umc channel address to soc pa, 3 parts are
> included */
> +			soc_pa =3D ADDR_OF_8KB_BLOCK(err_addr) |
> +					ADDR_OF_256B_BLOCK(channel_index)
> |
> +					OFFSET_IN_256B_BLOCK(err_addr);
> +
> +			/* The umc channel bits are not original values, they are
> hashed */
> +			SET_CHANNEL_HASH(channel_index, soc_pa);
> +
> +			dev_info(adev->dev, "Error Address(PA): 0x%llx\n",
> soc_pa);
> +		}
>  	}
>  }
>=20
> @@ -251,7 +269,9 @@ static void
> umc_v6_7_ecc_info_query_ras_error_address(struct amdgpu_device *adev
>=20
>  static void umc_v6_7_query_correctable_error_count(struct amdgpu_device
> *adev,
>  						   uint32_t umc_reg_offset,
> -						   unsigned long *error_count)
> +						   unsigned long *error_count,
> +						   uint32_t ch_inst,
> +						   uint32_t umc_inst)
>  {
>  	uint32_t ecc_err_cnt_sel, ecc_err_cnt_sel_addr;
>  	uint32_t ecc_err_cnt, ecc_err_cnt_addr; @@ -295,6 +315,33 @@ static
> void umc_v6_7_query_correctable_error_count(struct amdgpu_device *adev,
>  		*error_count +=3D 1;
>=20
>  		umc_v6_7_query_error_status_helper(adev, mc_umc_status,
> umc_reg_offset);
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
> +				adev->umc.channel_idx_tbl[umc_inst * adev-
> >umc.channel_inst_num +
> +ch_inst];
> +
> +			err_addr =3D RREG64_PCIE((mc_umc_addrt0 +
> umc_reg_offset) * 4);
> +			err_addr =3D REG_GET_FIELD(err_addr,
> MCA_UMC_UMC0_MCUMC_ADDRT0,
> +ErrorAddr);
> +
> +			/* translate umc channel address to soc pa, 3 parts are
> included */
> +			soc_pa =3D ADDR_OF_8KB_BLOCK(err_addr) |
> +					ADDR_OF_256B_BLOCK(channel_index)
> |
> +					OFFSET_IN_256B_BLOCK(err_addr);
> +
> +			/* The umc channel bits are not original values, they are
> hashed */
> +			SET_CHANNEL_HASH(channel_index, soc_pa);
> +
> +			/* clear [C4 C3 C2] in soc physical address */
> +			soc_pa &=3D ~(0x7ULL << UMC_V6_7_PA_C2_BIT);

[Tao] this clear needs to be dropped as well.

> +			dev_info(adev->dev, "Error Address(PA): 0x%llx\n",
> soc_pa);
> +		}
>  	}
>  }
>=20
> @@ -395,7 +442,8 @@ static void umc_v6_7_query_ras_error_count(struct
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
> index 9cdfeea58085..e41a5b6fc64b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1882,6 +1882,7 @@ static ssize_t aldebaran_get_ecc_info(struct
> smu_context *smu,
>  				ecc_table->EccInfo_V2[i].mca_umc_addr;
>  			ecc_info_per_channel->mca_ceumc_addr =3D
>  				ecc_table->EccInfo_V2[i].mca_ceumc_addr;
> +			smu->adev->record_ce_addr_supported =3D1;
>  		}
>  	}
>=20
> --
> 2.17.1

