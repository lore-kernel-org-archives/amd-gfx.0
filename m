Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422FFC61DA4
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Mar 2023 06:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75B7C10E24D;
	Mon, 13 Mar 2023 06:14:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C777A10E24D
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Mar 2023 06:14:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAokUjxUAawVAjUlwYNr+hIJZQ3eGcYaCAtjdn/T5P6zCE54dSMGcTaCb8BiPJcBQckMoGxbe11NxB0l/hkknqRQbes4qK3Ed+leS28PFQAn7IDQsDk21IAB0+9d0N4wbnFYfxZB8CAOQb1B4DTPr4PgYFsuBqZSaoznNWWKZt5vnMFDRPfYaly/O80lboF+K6yQRg9qF3LZHI8czwYkyNg3B8zL/WLF+1tE5Ry17gEkUQzzKcqXvGMK/K6D248N7S7okew5lg4n9f8ZitxhGlTIPxxu7ja/mE/pR3zTzCqV1ygCBWFNjKfEO0KUWJptIuckZyzjMX0f/bqSNRUOLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vJmBR/3VEIoTTYVLas4OO/RHs1932GwSkn0qtDORuc=;
 b=MVNm0VTqKy8aDb1mGIkE7MieuQ3z5K5Mi7HjIjvfegMf25lP2cpeXlD4iA1VWl6WvuBT0d3klbOCLo7WG3tgQHBWeRGYs6t5SLB0leZdtOy0ZMg688kJU9dgJf7UlKbtE2e8eZogf2PmpglFeDvDSXQvuQYOlPHSNsEonZg5Tx2JIUJxQ7CIUHhv5s+A3G14NnC3bG8djTehN6BHZ8OwaHJ+Cl4ivBwrkq6PD0rmr/+1MEgcH1WCDXrfSZXmUDQjVBJZI1V7li+yjCSJH08i4d20xxbElL8sBMx/Z4HhYv8kzImgaHGaQMM+FNRBS96O9ODNY1uXhyd2NJQQKTRF9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vJmBR/3VEIoTTYVLas4OO/RHs1932GwSkn0qtDORuc=;
 b=U0nFy4k9mPnEYdglNgomZAnfUewDwWhvbPpNpxqV5V2IPmeu5BZ+cI9YdS1RV3vFBEWq1Dui/zEW5vYTCekTOdwSRbbKUVLmA1uPdPA4rIRpOj/pZPK5xtcDgJsbav8QKw8pljb6FevN/SQp57jPlru9A4634HyQ4I3w8NxVH44=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 06:14:32 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::ffe7:2ff1:c01d:6070]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::ffe7:2ff1:c01d:6070%7]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 06:14:32 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 09/10] drm/amdgpu: Rework pcie_bif ras sw_init
Thread-Topic: [PATCH 09/10] drm/amdgpu: Rework pcie_bif ras sw_init
Thread-Index: AQHZVU1qhg2Dgo53fU6kfp1XPyxb9a74OsEAgAAAZbA=
Date: Mon, 13 Mar 2023 06:14:31 +0000
Message-ID: <BN9PR12MB525766761DCC89792C3AF915FCB99@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230313014403.21903-1-Hawking.Zhang@amd.com>
 <20230313014403.21903-10-Hawking.Zhang@amd.com>
 <BL1PR12MB53349D47CB10CEA427273C989AB99@BL1PR12MB5334.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB53349D47CB10CEA427273C989AB99@BL1PR12MB5334.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-13T06:14:28Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2e40e987-7604-4d12-86b1-d7651daab8ce;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM6PR12MB4169:EE_
x-ms-office365-filtering-correlation-id: bac5fb79-13d6-479e-9216-08db238a35c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JUy+5PTQGvRtsUivlAiB4YT/0do21x2X4Rs6UIDL8k5JnGaGbfI1Cs8tCQXSQr9p1SPZgkbOWCU3ILIFeNJLe/eO2nkvQoJo8TMljOWlYx4MM/JyCMDqFoXo/nmHIV8MZ8U2luWzjSyTZZr2T5YOMLAyEbTr2KnR7NjvpNpYALHPEFt2k+jgFzUqajpV1J4TPjzT6FA7x270AwoKzAgNaZ7lyVcc78dS7vmsNFu6lo9dn+IfbcNYTm7nnSEclQfPXqIN2Uy36bJSxJzvtMy/DN4VxAfncMMP79Ot+n+Wji3/HcqBfSSIRx17ZqHlErNXTc9h99Jf/ZdJ2uBfU7ieUt1ZUiLDteauoDq5L4M0gH/fYDpkzWNelYzBHdSP3MGI6x3jw3o+RAntFPiT82SCfIrd0AgeAkDD/FXmC1F61MdIB/xPojNgbSKwUm+Dtbq8IaZ3x5GRa+sw9epm71cCZ35XAUjQIzyZZeTobi2mn8ekk4V6DP90F8yrLnhh6wSL58tGCgk4vLHfPvL3y+bUH53tjYETM6UGJxYAc7cCi0sTyKtOgLEo9OTZYF+f/zgs/obR+85otnd9f3R+X8O4QLzEvV09Ti1n9wIVH45aZTf8KFNAGot7hZ08+WHKGZjczWAVTFh3FElf5UJFnYP2T15A8hXRQUiqkrLVPOOGbypaeeUh36v8sR06PELQTof82z43J7aes04nQC2wDnvRdA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199018)(5660300002)(83380400001)(7696005)(478600001)(6506007)(26005)(71200400001)(53546011)(9686003)(186003)(66476007)(38070700005)(66556008)(66946007)(76116006)(66446008)(55016003)(8676002)(33656002)(64756008)(52536014)(8936002)(41300700001)(86362001)(6636002)(110136005)(316002)(38100700002)(122000001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9Ao+tpN9/+o8g77JfPu4yTnAKCkK/aovqKy4zGeAlDzaebhrphcwnlxQNeq2?=
 =?us-ascii?Q?SoYVhXTk2UH8OcL1WmmsV6MV9kwmx0Xo/+JYql/pe8dOmTIZgyPAqXyipqfD?=
 =?us-ascii?Q?3bSSfsDKk8eRWx9LaYvswiQfArL5xDrEtkSgNbAeA+Z+IPQTfVFR4miNjVrL?=
 =?us-ascii?Q?jDnhJEc49gVuZUaR2eTLkA2Uf1Q8DKNQQ6fu6STA4vwV0r3AHqtdcIite5ZH?=
 =?us-ascii?Q?RmGz8MMhNpL3lNVwEiLf458IWDBDLv5UYEoXXzQdjHyKBOSdJmuefskI8u5s?=
 =?us-ascii?Q?DWVBo4DVaXv20ML0L26BWtJRYC5skJPHk0GKS+tPbo8cFgkNHVQYNn9td/4z?=
 =?us-ascii?Q?ZNzNqmc0Q/qKgb6xh6Dr9DrqmZks9N+gqiWNwQY3E5kZIyi8jgANd7VPsk6M?=
 =?us-ascii?Q?TECwodB/GXfiFflHsZxvwuIhyg6aKXEzlHCSW2pRwtmuq607HRgTDA2csi9l?=
 =?us-ascii?Q?HIWk0DGrHwVMlu04/sKtLEITYR+Nv+TdUp1g3DScPl8vXjsbDqLkSSTd962O?=
 =?us-ascii?Q?xa9CzZfW99Y0+azA9y6dijkUqMDOD+nIDFwnyrrEli9NaI6bTrhvBXHvkRWR?=
 =?us-ascii?Q?jJn3HUxlPUm/ZgTs6u5MKfwyfb/XDxcEPNzH9OsC58MHDT2fuDTvAFkfVbv3?=
 =?us-ascii?Q?oM9JLTuYr96FCG37YOqIa56vu6k+QXtmvpoMfWTc8ncqqwh6RDFnrzn+/7sX?=
 =?us-ascii?Q?hTTphyw6KnjtLbVPw7QNWmQq7eceSr6YwX7uXXI0k+w1InjQerpb3uxlATwy?=
 =?us-ascii?Q?TOFg0sZXsXQsyRBpdsPWYrx7A+Fbpj3xcTLoYAxdc2ZIESMNcnACY1K2sC+S?=
 =?us-ascii?Q?7SQWh/7bAXROWts7Z8j+4aVjt7KRVCdqtNqe2f7Mr0jlhE1o2FZtAXPMjTLR?=
 =?us-ascii?Q?JQ0Rc4QOKgnLZVAMy7jeRsTCyG3oo6xPS0YLd/yzCHIVMFh2GzFDdOQDOsC2?=
 =?us-ascii?Q?Q7vNY2NJ56gB4rDidJVfxA+pkgMjZTbPj2jTdGl3jnnFizY3fJhJBm0ZuMh8?=
 =?us-ascii?Q?W8r3JtPAIKnlFf6wpb2ZAkAEY0u7YfwC8JAQZUrzC99fa93cn4AJsZBemsLM?=
 =?us-ascii?Q?clie8W/RFSChmcsVsFOOFvN+V4PrKrdoatPzmrtvKn4ja1yct+QMX7GCs/dS?=
 =?us-ascii?Q?yXadaCrmjnFzbL9BzGKGb6mQIIGRk9UIAO1xOcZr1t+UjwK8LEW0ElQGg5Cn?=
 =?us-ascii?Q?MNqfpjr+e/G/w6Jz8T9H5IWSHnNercQvQ9Ksed6QjNg5gJCVJtRveZq/7Oqz?=
 =?us-ascii?Q?KyMIaEE1r3ty/MT1qickHigc0/kJqIm836qZrZ4cz/9jFTngnRS5ZNb5+tcE?=
 =?us-ascii?Q?vE9HDem/VXKpI0bNXHibcml8DjKhf0TyRodpRBcZbHCDpxHrZuvRMc04E+3z?=
 =?us-ascii?Q?vG1sDg/4EUlEdJ0dgpBtCCpz3VhVD+Qbl/oMZROjARs7/MclYWPq7TXzLpHA?=
 =?us-ascii?Q?Yq+tC+7PKce35HrU1A+uB9BNxxiYq+XNrcfsOZLKvsBeVNOUnN/yf8QZpzF8?=
 =?us-ascii?Q?g+JFR7/51o7pOvCKGK6l20KNI1MpsD1M7Y7HmXgGEtGxj0Uf3fyI0h8FREy+?=
 =?us-ascii?Q?+IxcYwunEsx9LiOQUSXd1CQcjl6M12cdbOaF7+eZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac5fb79-13d6-479e-9216-08db238a35c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 06:14:31.7696 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JiloMGbEX8YVE/PiWSx/gfdGqLt4f3noyYxqkYAQYwVXRR0XoKdXcHblUijudGJ5Mwi2KW/JoBvJHi+TEFiwKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169
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

[AMD Official Use Only - General]

RE - The judgement condition should be changed to ip_versions[][].

Thanks for catching that. It was caused by code rebase. I'll fix it

Regards,
Hawking

-----Original Message-----
From: Yang, Stanley <Stanley.Yang@amd.com>=20
Sent: Monday, March 13, 2023 14:12
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; =
Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Chai, Tho=
mas <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 09/10] drm/amdgpu: Rework pcie_bif ras sw_init

[AMD Official Use Only - General]

Without the inline comments, the series looks fine to me.

Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>

Regards,
Stanley
> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Monday, March 13, 2023 9:44 AM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>;=20
> Yang, Stanley <Stanley.Yang@amd.com>; Li, Candice=20
> <Candice.Li@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH 09/10] drm/amdgpu: Rework pcie_bif ras sw_init
>=20
> pcie_bif ras blocks needs to be initialized as early as possible to=20
> handle fatal error detected in hw_init phase. also align the pcie_bif=20
> ras sw_init with other ras blocks
>=20
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c | 23
> +++++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  1 +=20
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 17 ++++++++++-------
>  3 files changed, 34 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> index 37d779b8e4a6..a3bc00577a7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> @@ -22,6 +22,29 @@
>  #include "amdgpu.h"
>  #include "amdgpu_ras.h"
>=20
> +int amdgpu_nbio_ras_sw_init(struct amdgpu_device *adev) {
> +	int err;
> +	struct amdgpu_nbio_ras *ras;
> +
> +	if (!adev->nbio.ras)
> +		return 0;
> +
> +	ras =3D adev->nbio.ras;
> +	err =3D amdgpu_ras_register_ras_block(adev, &ras->ras_block);
> +	if (err) {
> +		dev_err(adev->dev, "Failed to register pcie_bif ras block!\n");
> +		return err;
> +	}
> +
> +	strcpy(ras->ras_block.ras_comm.name, "pcie_bif");
> +	ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__PCIE_BIF;
> +	ras->ras_block.ras_comm.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
> +	adev->nbio.ras_if =3D &ras->ras_block.ras_comm;
> +
> +	return 0;
> +}
> +
>  int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct=20
> ras_common_if *ras_block)  {
>  	int r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> index a240336bbc6b..c686ff4bcc39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> @@ -106,5 +106,6 @@ struct amdgpu_nbio {
>  	struct amdgpu_nbio_ras  *ras;
>  };
>=20
> +int amdgpu_nbio_ras_sw_init(struct amdgpu_device *adev);
>  int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct=20
> ras_common_if *ras_block);  #endif diff --git=20
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 63dfcc98152d..834092099bff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2555,20 +2555,23 @@ int amdgpu_ras_init(struct amdgpu_device
> *adev)
>  	 * ras functions so hardware fatal error interrupt
>  	 * can be enabled as early as possible */
>  	switch (adev->asic_type) {

[Stanley]: The judgement condition should be changed to ip_versions[][].

> -	case CHIP_VEGA20:
> -	case CHIP_ARCTURUS:
> -	case CHIP_ALDEBARAN:
> -		if (!adev->gmc.xgmi.connected_to_cpu) {
> +	case IP_VERSION(7, 4, 0):
> +	case IP_VERSION(7, 4, 1):
> +	case IP_VERSION(7, 4, 4):
> +		if (!adev->gmc.xgmi.connected_to_cpu)
>  			adev->nbio.ras =3D &nbio_v7_4_ras;
> -			amdgpu_ras_register_ras_block(adev, &adev-
> >nbio.ras->ras_block);
> -			adev->nbio.ras_if =3D &adev->nbio.ras-
> >ras_block.ras_comm;
> -		}
>  		break;
>  	default:
>  		/* nbio ras is not available */
>  		break;
>  	}
>=20
> +	/* nbio ras block needs to be enabled ahead of other ras blocks
> +	 * to handle fatal error */
> +	r =3D amdgpu_nbio_ras_sw_init(adev);
> +	if (r)
> +		return r;
> +
>  	if (adev->nbio.ras &&
>  	    adev->nbio.ras->init_ras_controller_interrupt) {
>  		r =3D adev->nbio.ras->init_ras_controller_interrupt(adev);
> --
> 2.17.1
