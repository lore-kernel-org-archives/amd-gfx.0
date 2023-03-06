Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0321C678D4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 07:24:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D37210E073;
	Mon,  6 Mar 2023 07:24:58 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09EF610E073
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 07:24:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gq8OB1P9x9kZRAno/+0MbHzzrRfejsBuuyZ/02aseVd/CvLSuv3fjFAuqjvr44V1uKNZhMM156EdFuD64x1HlrNZsXtxcJ+pezacbHMOw2t09pW39T5y9v5WQ31TZRyd9XylPkZtq6V1QTOr0/pH76FAmsfF9/5N2yRouWrRuY1fAC8cZev5pwcfHC67fWPAoTic5c7kCydR6mlBSrsba4PISpBNTCu6y4z214gwGoFCEL5RAeA2eKkpG775uToDlyDuAZL2wlF+nARMmEn3Xp4C7gKgPBfnfOkcw/pUPVPB1GpjAFcnCX0kZ9lreBShD6hPp55U6QkePaKtRD1Faw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v531keWS/dA2EQm8TUtXVl3UvfWHz8SRsl2P0A1zGXo=;
 b=EZXjANlLcv68zp8zRQKm97wo5GTBka8TDbmiHmm9YKqpLfY/YwRCHSAM4Fl+rW3nwWXqC9pO3R/Mvv2uoM3ibuorjFWZOk8F64C390ME9NqTEA0ogvkRSt1wbLPhotCY9Yswdhg7ATwA8zN6amPk3pxgCbmD+dwLb2nPv1n5lOiJjENydog+pZTRKSNxkB4t18MaS5qyeXMh0cu76hPM41PJ2HYhRwMoepoFg+CzOcXdML02VvsAOoxZ9gzkVebRF0RQEbRb8KtlF/5mTgnjq/wP+o/eOn1y2dlqnTaBmFM96qmZFphd4zDm16N9Mft4ckIcOEW/oArjCSchmXL8fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v531keWS/dA2EQm8TUtXVl3UvfWHz8SRsl2P0A1zGXo=;
 b=RVOkUe2TPioSoF25/Itm+JUrYySHenI9mI7JNjdsByIxMuwL+YPq/eBQo2/cw/KF5p7/09e/2wTQKg4i8OfFtaTOWL+hrOaRzn1XnYE61PVn1nqLA9mIgsIo9OHybULzMkJAPZeS+n+AuM5Bi1Z000daZgmLJgvlEwYg+yQjP7A=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by SJ2PR12MB7798.namprd12.prod.outlook.com (2603:10b6:a03:4c0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Mon, 6 Mar
 2023 07:24:54 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::f228:6619:2cd5:9bf8]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::f228:6619:2cd5:9bf8%7]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 07:24:53 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 08/11] drm/amdgpu: Rework mca ras sw_init
Thread-Topic: [PATCH 08/11] drm/amdgpu: Rework mca ras sw_init
Thread-Index: AQHZT9QAScaVZQplOkWFoTMWwJbh3a7tWHng
Date: Mon, 6 Mar 2023 07:24:53 +0000
Message-ID: <BL1PR12MB5334175E9F624E899EF2FA289AB69@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20230306023200.29158-1-Hawking.Zhang@amd.com>
 <20230306023200.29158-9-Hawking.Zhang@amd.com>
In-Reply-To: <20230306023200.29158-9-Hawking.Zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5334:EE_|SJ2PR12MB7798:EE_
x-ms-office365-filtering-correlation-id: 92278c4d-5737-4a0c-a73e-08db1e13e16d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n/LHgQ9sCmGbHO5RbT0KTgiRIDL3BC8WnxMvmrrkQMe+xHIOiH/pBnoBb6K8PPIeUM4gRs08NgxNlr5AgHi8PSKrE7sb65ogys6BQAToECDpCudFatTq00/zZbvDLils7Z+jv5Ece1VSH3+rP30s2GniWvkK2HaAgtBct7QlUz6SMN4Z1DKDNrMpkOaCR2nitB0Ll6CLQv3NN6dtvSw7J14exwD7lZ6SeaLwk8H8IbDm1vQxs7WMkapEy6Gru3oWvPAbinRFt2RNILojzMn/VtpGwrcSh15dKs0jtQkskY7PjYp2Vdh0YHsfquofA4phodQ1PwRONmwMg4YXnXnDxscIMP/D13aA8TNpjzRWGzGn6vUUlUrOhPXsStERD6FEf2HMHUGJQczVStRRXEpBTUGTwxgSQGRIfwM8dUCSCV1vED0lZky9hLf+2CnqxA0KdrGhzpSRoJ2U+fx/NdgRuBxTm+DtltovspJoYqZ7KDfelVRKeIvz9ZuPyZwnOrcv6V3FZY/s+dBcwLbysbr6u7sQCzdSrq3mpPJiq7dsSZaxZGUBAOGSmUQRPUZyrGnqRhPAsRIJWwzKc+NVqfXI8LACJZVK8xrnIe+YU7ZCBQS/hBnVLLpHdZ72nq8UQwrPJDFoHa7TJ+FVVHirik6leYeTdlY44z1sMarDI9XlRVlhqBestDvHXv5qVFAwD2QolSjyEC553LKHcgwESQPc8A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199018)(478600001)(7696005)(83380400001)(33656002)(316002)(55016003)(110136005)(38100700002)(6636002)(38070700005)(122000001)(9686003)(186003)(6506007)(26005)(53546011)(5660300002)(86362001)(30864003)(8936002)(71200400001)(64756008)(52536014)(66556008)(76116006)(66446008)(41300700001)(2906002)(66946007)(8676002)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QMbIFhvrPNnZlGy1L+br084G7pzzobZW0+k938yZctqhpPcSjqg0mdbVTkwV?=
 =?us-ascii?Q?dKmLbDW3xALZrVEnMBkK0xRCzN40ZpjhL9ne0n8qUqatCG3agceXzq5Kq0rH?=
 =?us-ascii?Q?XZVKwB6YYQQKkJvrQM//1eK+vHy65qe4WuYZoejpFj96MVbDxvCZF/HUOJ5q?=
 =?us-ascii?Q?N5GZadP1wMFRye6GVm4mJKHSGJpuz7wAw7Rkpnpo5h3zoezbCnMx7lni3BAp?=
 =?us-ascii?Q?h+Lqf6wFlUnm0iNOU0epUY2e37tUFqINeM4OMFSJ1hFyRsKH38WcYKbprX7U?=
 =?us-ascii?Q?Z+gU3whFiN70LGWXI6kVB5/CNoJfWfTIAVp3368Oy8Ko2Ebngbk9e1lVZFEQ?=
 =?us-ascii?Q?cN22CTVT7F5LS7CVpz0cdPhDRuQdOwg2xricUYWSv+z0ZrbSum5iAdlceH55?=
 =?us-ascii?Q?vUE0nNURy9yagcqSddnPgmtN/mnZZxvWjs/KCYc18R4iJ1Kz96RhDJi+SA6D?=
 =?us-ascii?Q?xYRkMKx3V3S73pjNO3HzqC2UYQzqrSW5waD3vRYTk2ZRfYzqZ/SysDQydCDK?=
 =?us-ascii?Q?c2IQLRbmCsrjzFViIGBXyhUvsm+yTHNyvdzqN7bp/CZJZ/bkWXBYhsdSpY4/?=
 =?us-ascii?Q?T6c7YUV+dDBhvrQi0evZrMZ4u/bxv3lF78/MXgK9Gh1D3kwzZafXFSWEv5hI?=
 =?us-ascii?Q?Ji+bAHsjzzqmw0RTJgmt8j0E4xRTgRQKzdCatfRK0ZoTkmoKEhENMaedi0bY?=
 =?us-ascii?Q?ZGAjAP2cfV9v5RlbzZw4Fuz8XNZYiIjdhi1Ohbtb86Ee1Pto7yYZOwETPH88?=
 =?us-ascii?Q?+XFrEe6n5Elsmwt+TJlt+CGXgU0B0yXd+vwfcKDkJQfgSfoW2keHiQAMaHu+?=
 =?us-ascii?Q?5KuccpRWNdNf/Yy+lm0QmmHQJMMJSks5dXK5OcKrdE9MTmdG8Ij2rbOAEjnx?=
 =?us-ascii?Q?C4UN9V4eAIKGCNhiX6fMK2xp3WLyCkH3s2Lrv8UZ4cvhQOU+OJft6MIfJEXw?=
 =?us-ascii?Q?2zC8zljBp4v2tF4RZny5vT+ZUjHJAjtWocG5teyWN9Gf0QHvYQ82gaNLcyCW?=
 =?us-ascii?Q?DlGYvXl12SIA0jsb3bMEAZeQf/jIZahgIruEJu2bClGZJ+ojAzRR7PwOaPnx?=
 =?us-ascii?Q?lxKKHJtFlSFfl+DkKE0WVCC0rTstllzpHLlFjosZCFCO7A6EdduqVPtmdrY7?=
 =?us-ascii?Q?Sz+ESHeXRYXZPjlxyMb9VyaBHvTjPnV6i8TGx0FFJl1NLp1lUM/kNqSy9QPk?=
 =?us-ascii?Q?xSpipWC4I/ZZsfzihh56cp8EuMCN4/8sWomdxWsPLJENgaqIpz3tC5te1s2w?=
 =?us-ascii?Q?SrPO/xEHBrVKCEF5YwAWb0JD7Vy4wpg/NS2po0Xuixm/qZmDsR7f+CruKmfE?=
 =?us-ascii?Q?alm+BpLsayBv589+OuzaX0SSdSqSgzSx03eHqF08aHaFhRDC15M9+HFdS2jg?=
 =?us-ascii?Q?SVEs/LtxR5l/GAdA3prpAW8oxM3p8He7/duOduEYWLZO2QBIalaLH4AyxT1p?=
 =?us-ascii?Q?Ma9H0Bs+qprTlFYAexNIs3u77dfmej163B+b4qo0RPQzPryNIhfjsr2WS2xC?=
 =?us-ascii?Q?1uEiz2Yh2eMjGRud7WoVDZw13LpWMHdpWsn/GPL9fLNxPnuHctOUjDklhuvv?=
 =?us-ascii?Q?qgC8vZsamnHa8LXeHKI3dHfeZB15ETvwFVsmHWZB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92278c4d-5737-4a0c-a73e-08db1e13e16d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 07:24:53.8172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DLxGe1K3XXAltWHdJ8bcpadXbrNIgbNQ88rg1nDwIcIHe/84RanJvEohSl0N3V6ChM1rt1+GR4vfndxZmiwYbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7798
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
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>;
> Yang, Stanley <Stanley.Yang@amd.com>; Li, Candice <Candice.Li@amd.com>;
> Chai, Thomas <YiPeng.Chai@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH 08/11] drm/amdgpu: Rework mca ras sw_init
>=20
> To align with other IP blocks
>=20
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 21 ++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 72
> +++++++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h |  9 ++--
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 15 +++---
>  drivers/gpu/drm/amd/amdgpu/mca_v3_0.c   | 44 ++-------------
>  drivers/gpu/drm/amd/amdgpu/mca_v3_0.h   |  4 +-
>  6 files changed, 111 insertions(+), 54 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 087a75374610..524e2c9b3012 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -477,6 +477,27 @@ int amdgpu_gmc_ras_sw_init(struct amdgpu_device
> *adev)
>  		}
>  	}
>=20
> +	/* mca.x ras block */
> +	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MCA))
> {
> +		r =3D amdgpu_mca_mp0_ras_sw_init(adev);
> +		if (r) {
> +			dev_err(adev->dev, "Failed to initialize mca.mp0 ras
> block!\n");
> +			return r;
> +		}
> +
> +		r =3D amdgpu_mca_mp1_ras_sw_init(adev);
> +		if (r) {
> +			dev_err(adev->dev, "Failed to initialize mca.mp1 ras
> block!\n");
> +			return r;
> +		}
> +
> +		r =3D amdgpu_mca_mpio_ras_sw_init(adev);
> +		if (r) {
> +			dev_err(adev->dev, "Failed to initialize mca.mpio ras
> block!\n");
> +			return r;
> +		}
> +	}
> +
>  	/* xgmi ras block */
>  	if (amdgpu_ras_is_supported(adev,
> AMDGPU_RAS_BLOCK__XGMI_WAFL)) {
>  		adev->gmc.xgmi.ras =3D &xgmi_ras;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> index 51c2a82e2fa4..0b545bdcd636 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> @@ -70,3 +70,75 @@ void amdgpu_mca_query_ras_error_count(struct
> amdgpu_device *adev,
>=20
>  	amdgpu_mca_reset_error_count(adev, mc_status_addr);  }
> +
> +int amdgpu_mca_mp0_ras_sw_init(struct amdgpu_device *adev) {
> +	int err;
> +	struct amdgpu_mca_ras_block *ras;
> +
> +	if (!adev->mca.mp0.ras)
> +		return 0;
> +
> +	ras =3D adev->mca.mp0.ras;
> +
> +	err =3D amdgpu_ras_register_ras_block(adev, &ras->ras_block);
> +	if (err) {
> +		dev_err(adev->dev, "Failed to register mca.mp0 ras
> block!\n");
> +		return err;
> +	}
> +
> +	strcpy(ras->ras_block.ras_comm.name, "mca.mp0");
> +	ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
> +	ras->ras_block.ras_comm.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
> +	adev->mca.mp0.ras_if =3D &ras->ras_block.ras_comm;
> +
> +	return 0;
> +}
> +
> +int amdgpu_mca_mp1_ras_sw_init(struct amdgpu_device *adev) {
> +        int err;
> +        struct amdgpu_mca_ras_block *ras;
> +
> +        if (!adev->mca.mp1.ras)
> +                return 0;
> +
> +        ras =3D adev->mca.mp1.ras;
> +
> +        err =3D amdgpu_ras_register_ras_block(adev, &ras->ras_block);
> +        if (err) {
> +                dev_err(adev->dev, "Failed to register mca.mp1 ras block=
!\n");
> +                return err;
> +        }
> +
> +        strcpy(ras->ras_block.ras_comm.name, "mca.mp1");
> +        ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
> +        ras->ras_block.ras_comm.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
> +        adev->mca.mp1.ras_if =3D &ras->ras_block.ras_comm;
> +
> +        return 0;
> +}
> +
> +int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_device *adev) {
> +        int err;
> +        struct amdgpu_mca_ras_block *ras;
> +
> +        if (!adev->mca.mpio.ras)
> +                return 0;
> +
> +        ras =3D adev->mca.mpio.ras;
> +
> +        err =3D amdgpu_ras_register_ras_block(adev, &ras->ras_block);
> +        if (err) {
> +                dev_err(adev->dev, "Failed to register mca.mpio ras bloc=
k!\n");
> +                return err;
> +        }
> +
> +        strcpy(ras->ras_block.ras_comm.name, "mca.mpio");
> +        ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
> +        ras->ras_block.ras_comm.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
> +        adev->mca.mpio.ras_if =3D &ras->ras_block.ras_comm;
> +
> +        return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
> index 7ce16d16e34b..997a073e2409 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
> @@ -30,12 +30,7 @@ struct amdgpu_mca_ras {
>  	struct amdgpu_mca_ras_block *ras;
>  };
>=20
> -struct amdgpu_mca_funcs {
> -	void (*init)(struct amdgpu_device *adev);
> -};
> -
>  struct amdgpu_mca {
> -	const struct amdgpu_mca_funcs *funcs;
>  	struct amdgpu_mca_ras mp0;
>  	struct amdgpu_mca_ras mp1;
>  	struct amdgpu_mca_ras mpio;
> @@ -55,5 +50,7 @@ void amdgpu_mca_reset_error_count(struct
> amdgpu_device *adev,  void amdgpu_mca_query_ras_error_count(struct
> amdgpu_device *adev,
>  				      uint64_t mc_status_addr,
>  				      void *ras_error_status);
> -
> +int amdgpu_mca_mp0_ras_sw_init(struct amdgpu_device *adev); int
> +amdgpu_mca_mp1_ras_sw_init(struct amdgpu_device *adev); int
> +amdgpu_mca_mpio_ras_sw_init(struct amdgpu_device *adev);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 9a333f9744bf..67c2a5186b8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1363,13 +1363,18 @@ static void gmc_v9_0_set_hdp_ras_funcs(struct
> amdgpu_device *adev)
>  	adev->hdp.ras =3D &hdp_v4_0_ras;
>  }
>=20
> -static void gmc_v9_0_set_mca_funcs(struct amdgpu_device *adev)
> +static void gmc_v9_0_set_mca_ras_funcs(struct amdgpu_device *adev)
>  {
> +	struct amdgpu_mca *mca =3D &adev->mca;
> +
>  	/* is UMC the right IP to check for MCA?  Maybe DF? */
>  	switch (adev->ip_versions[UMC_HWIP][0]) {
>  	case IP_VERSION(6, 7, 0):
> -		if (!adev->gmc.xgmi.connected_to_cpu)
> -			adev->mca.funcs =3D &mca_v3_0_funcs;
> +		if (!adev->gmc.xgmi.connected_to_cpu) {

[Stanley]: Can we use if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__M=
CA)) instead of if (!adev->gmc.xgmi.connected_to_cpu)
	    to keep the ip ras judgment uniform.

Regards,
Stanley
> +			mca->mp0.ras =3D &mca_v3_0_mp0_ras;
> +			mca->mp1.ras =3D &mca_v3_0_mp1_ras;
> +			mca->mpio.ras =3D &mca_v3_0_mpio_ras;
> +		}
>  		break;
>  	default:
>  		break;
> @@ -1398,7 +1403,7 @@ static int gmc_v9_0_early_init(void *handle)
>  	gmc_v9_0_set_mmhub_ras_funcs(adev);
>  	gmc_v9_0_set_gfxhub_funcs(adev);
>  	gmc_v9_0_set_hdp_ras_funcs(adev);
> -	gmc_v9_0_set_mca_funcs(adev);
> +	gmc_v9_0_set_mca_ras_funcs(adev);
>=20
>  	adev->gmc.shared_aperture_start =3D 0x2000000000000000ULL;
>  	adev->gmc.shared_aperture_end =3D
> @@ -1611,8 +1616,6 @@ static int gmc_v9_0_sw_init(void *handle)
>  	adev->gfxhub.funcs->init(adev);
>=20
>  	adev->mmhub.funcs->init(adev);
> -	if (adev->mca.funcs)
> -		adev->mca.funcs->init(adev);
>=20
>  	spin_lock_init(&adev->gmc.invalidate_lock);
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> index d4bd7d1d2649..6dae4a2e2767 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> @@ -51,19 +51,13 @@ static int mca_v3_0_ras_block_match(struct
> amdgpu_ras_block_object *block_obj,
>  	return -EINVAL;
>  }
>=20
> -const struct amdgpu_ras_block_hw_ops mca_v3_0_mp0_hw_ops =3D {
> +static const struct amdgpu_ras_block_hw_ops mca_v3_0_mp0_hw_ops =3D {
>  	.query_ras_error_count =3D mca_v3_0_mp0_query_ras_error_count,
>  	.query_ras_error_address =3D NULL,
>  };
>=20
>  struct amdgpu_mca_ras_block mca_v3_0_mp0_ras =3D {
>  	.ras_block =3D {
> -		.ras_comm =3D {
> -			.block =3D AMDGPU_RAS_BLOCK__MCA,
> -			.sub_block_index =3D
> AMDGPU_RAS_MCA_BLOCK__MP0,
> -			.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
> -			.name =3D "mp0",
> -		},
>  		.hw_ops =3D &mca_v3_0_mp0_hw_ops,
>  		.ras_block_match =3D mca_v3_0_ras_block_match,
>  	},
> @@ -77,19 +71,13 @@ static void
> mca_v3_0_mp1_query_ras_error_count(struct amdgpu_device *adev,
>  				         ras_error_status);
>  }
>=20
> -const struct amdgpu_ras_block_hw_ops mca_v3_0_mp1_hw_ops =3D {
> +static const struct amdgpu_ras_block_hw_ops mca_v3_0_mp1_hw_ops =3D {
>  	.query_ras_error_count =3D mca_v3_0_mp1_query_ras_error_count,
>  	.query_ras_error_address =3D NULL,
>  };
>=20
>  struct amdgpu_mca_ras_block mca_v3_0_mp1_ras =3D {
>  	.ras_block =3D {
> -		.ras_comm =3D {
> -			.block =3D AMDGPU_RAS_BLOCK__MCA,
> -			.sub_block_index =3D
> AMDGPU_RAS_MCA_BLOCK__MP1,
> -			.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
> -			.name =3D "mp1",
> -		},
>  		.hw_ops =3D &mca_v3_0_mp1_hw_ops,
>  		.ras_block_match =3D mca_v3_0_ras_block_match,
>  	},
> @@ -103,40 +91,14 @@ static void
> mca_v3_0_mpio_query_ras_error_count(struct amdgpu_device *adev,
>  				         ras_error_status);
>  }
>=20
> -const struct amdgpu_ras_block_hw_ops mca_v3_0_mpio_hw_ops =3D {
> +static const struct amdgpu_ras_block_hw_ops mca_v3_0_mpio_hw_ops =3D {
>  	.query_ras_error_count =3D mca_v3_0_mpio_query_ras_error_count,
>  	.query_ras_error_address =3D NULL,
>  };
>=20
>  struct amdgpu_mca_ras_block mca_v3_0_mpio_ras =3D {
>  	.ras_block =3D {
> -		.ras_comm =3D {
> -			.block =3D AMDGPU_RAS_BLOCK__MCA,
> -			.sub_block_index =3D
> AMDGPU_RAS_MCA_BLOCK__MPIO,
> -			.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
> -			.name =3D "mpio",
> -		},
>  		.hw_ops =3D &mca_v3_0_mpio_hw_ops,
>  		.ras_block_match =3D mca_v3_0_ras_block_match,
>  	},
>  };
> -
> -
> -static void mca_v3_0_init(struct amdgpu_device *adev) -{
> -	struct amdgpu_mca *mca =3D &adev->mca;
> -
> -	mca->mp0.ras =3D &mca_v3_0_mp0_ras;
> -	mca->mp1.ras =3D &mca_v3_0_mp1_ras;
> -	mca->mpio.ras =3D &mca_v3_0_mpio_ras;
> -	amdgpu_ras_register_ras_block(adev, &mca->mp0.ras->ras_block);
> -	amdgpu_ras_register_ras_block(adev, &mca->mp1.ras->ras_block);
> -	amdgpu_ras_register_ras_block(adev, &mca->mpio.ras->ras_block);
> -	mca->mp0.ras_if =3D &mca->mp0.ras->ras_block.ras_comm;
> -	mca->mp1.ras_if =3D &mca->mp1.ras->ras_block.ras_comm;
> -	mca->mpio.ras_if =3D &mca->mpio.ras->ras_block.ras_comm;
> -}
> -
> -const struct amdgpu_mca_funcs mca_v3_0_funcs =3D {
> -	.init =3D mca_v3_0_init,
> -};
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.h
> b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.h
> index b899b86194c2..d3eaef0d7f2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.h
> @@ -21,6 +21,8 @@
>  #ifndef __MCA_V3_0_H__
>  #define __MCA_V3_0_H__
>=20
> -extern const struct amdgpu_mca_funcs mca_v3_0_funcs;
> +extern struct amdgpu_mca_ras_block mca_v3_0_mp0_ras; extern struct
> +amdgpu_mca_ras_block mca_v3_0_mp1_ras; extern struct
> +amdgpu_mca_ras_block mca_v3_0_mpio_ras;
>=20
>  #endif
> --
> 2.17.1

