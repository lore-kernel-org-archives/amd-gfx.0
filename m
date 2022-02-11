Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3B2C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 04:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1533710E9E2;
	Fri, 11 Feb 2022 04:46:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 580FF10E9E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 04:46:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsvlo7MnDnjSxLwvwt/3i9yro900KtiEU1I+wDvGEemo6Vp9SmhMRRLzd7joiRVeO2R3mfJU3jugcLUtCUcYl17WqiwWb+5z1RrTa+s4M0REkMXr0bSWYHXyCJ5IYWSjr7A2dMjQSywenKzEPMyQBC5ejcewOWdvDT7UQUz9kQif7918AyXF8I04QolPrHhGNVLZZEO66kcSUf6hjlGxRGpG/M8gzMXKbCyyCvHIwXD3l9VjAN2xAVhGjkdRAXxiQeI8TJx2urQRMUOAfNQ1+2d80ZyspKAPWsTG5GSHeSG6SyXwSB8pyu9KHenyic67yiPd2jwmGBmrHy846oasYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bG5JUB5OrOGugv14AoiYe1r7t19cGP4ze6k3Pxp5wws=;
 b=ZrWdbpjI3DPUxZPo3d4dhzbNEMDUr4Qsm+Qk6YYBXLH84+GmBTgYWT36Igvl/FKzUlwEfw9Dn0LIZOISCc2rEgzCdVVSwCQv6cUx6Vdxkzl0dJjwCZaT/6SNvGF1QCMucjnTDmu0IbZFB1jHN5yKwVm7socbcxRdzS3cg5bH4sIKU1eVMV7yI2nPNIs9ASHO7JfIaCZf+KKBBxh3jJuNZRZMybTWdjfVtBrdJjGmLJWpIzR2DiHAaAJhoymIncGcAcFS0xgga/zcmgxB/ZoEVNOYrTEkAgIcrmLnkX3xag+5/nzYasy3Ay1NEAv7xK1gRGK6KQRyMcrmYYMOaskDSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bG5JUB5OrOGugv14AoiYe1r7t19cGP4ze6k3Pxp5wws=;
 b=2rTT7WlKg05Qryaub0eYBq2DPVJR3tmXifXgrTMI6h70xziEc5ZM+YTh8F29VNh7CTVBWgOrqB9hjndFR3WX8zQUg2OkxSSu0xoiJlHnUGESR72vzay5NCxmpjy46qXIdmZs3Q31l55qiADKUWl7eSWYIGMcqklWNfmk5aVT+xE=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 BN8PR12MB3492.namprd12.prod.outlook.com (2603:10b6:408:67::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11; Fri, 11 Feb 2022 04:46:28 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639%6]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 04:46:28 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add unique_id support for sienna cichlid
Thread-Topic: [PATCH] drm/amdgpu: Add unique_id support for sienna cichlid
Thread-Index: AQHYHpTmhYLOyxbL/UCVnIXUOATA0qyNxkmw
Date: Fri, 11 Feb 2022 04:46:28 +0000
Message-ID: <DM6PR12MB26191EB91053235076F876B0E4309@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220210154247.742942-1-kent.russell@amd.com>
In-Reply-To: <20220210154247.742942-1-kent.russell@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-11T04:46:25Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=3005ca88-d790-4123-80bd-8e0245f5a1de;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ba4816b-f17e-4256-4965-08d9ed197791
x-ms-traffictypediagnostic: BN8PR12MB3492:EE_
x-microsoft-antispam-prvs: <BN8PR12MB34925FC5F81BE8E08D3660A2E4309@BN8PR12MB3492.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:586;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CdBaQgY03i8PDy1NcCyaZtynmFN1mN4iTYqOpu7B/hpDgNuiBg24buumWLsAqcIklKWnCRczWGjk7nG27pzPkhMvWxkfunKfVTTN/+bmuPud/agEo168+MGaXzGI/l159JgI9Ii6+R2fCc+soOXihfVIEEbhv1S9s3rl0sJvP0x+Zwj0lQAeAHy3YaE+RMw/1bQCCy6NzDo4DxhJGAtbJ2YlrRUdKDo/MPKqIUI0S4HFoA4VlJG1jXZm9YsSxsUBK3S+iC6MZkwPRS94iO6thx5NOzxFZaxHvsO0a7aKDUCWGMcCazgtZBhUtLTKur4BKY9uynl3iegsLSJ7iBbhAbp3nqa5+BSqjnOwSBoILVFdtqrY6rz8XlMDsJv/+bRa8OU165XE/YKCVrspqsP+CFV3Ox3UmjUmPZ2DW+wjly1DEQPD2jKyaL8anhUI8i61z20IQdjKpWro6UpmxnIqcoU9BM5N2BVIVj+jiU+A0ghRk0uMaMLFrNLxaBwJmnDPJu1C4IIOCq7jntylZgjPNNKdDEybs94dYhYGt4O7gr7vk3j4tPRjnxNtCmjoqullFVhtzAKfuZKUVw6SaohupqBhzDAqWVLtr2T4Ng5Zh+Q++IpjXUCL9MhOUXeZ0LFd1JH0IFjPzuCz1JJH86dmsuWhuUOu57xffqU8N/ijQe+otOuCIAwVzE5nfRlgK5g3I2DmWRPtQwOyhHtKrYXTmg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(64756008)(8676002)(66476007)(122000001)(66446008)(4326008)(76116006)(5660300002)(38070700005)(66556008)(7696005)(86362001)(2906002)(316002)(66946007)(38100700002)(8936002)(52536014)(55016003)(6506007)(9686003)(33656002)(110136005)(26005)(186003)(53546011)(83380400001)(71200400001)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MSh2zR++bVwXPk3hdx2wdbPZmeFXsJhDbN3OR0X+HA3xaVT+B25k950kLv4f?=
 =?us-ascii?Q?/mOn8DOml5rYV/IDUqIdGyiBxm7gKfiJl51yeuijGL6OZ/yU6Rhey7mUQCUl?=
 =?us-ascii?Q?hV8LPOwGVCOm1ZFvlH0rVpcgChO08dKBuo4Uvf2kRfq9msl1tzwlyNl7dzEK?=
 =?us-ascii?Q?5JFZTYRf3zjVxzpRHgM87Q0obEbqnm+ZIP+viC7Way9lHoDeESaMmonJxO+S?=
 =?us-ascii?Q?JYthFQYLx25Ds/iQ02GOE9Ir22Vc0WUrQISY4ro+1Pgnog4THE3xmV0uSdpd?=
 =?us-ascii?Q?wG/w0CM6G/KozEhGT5JBTh3Y0Llq3O67WLNJnTruMBqHcF5la9e58LJ5VOnA?=
 =?us-ascii?Q?4eZyS8U4kDGn1uFRcKhvVnbrDS3NBB/kgHcceJyW4S7Q6t5HEwFyejbt+6EY?=
 =?us-ascii?Q?mFnGS1pxhrUnINZBtvd9mBSfu0OTPAJaQEivNWGQQn9jRbF/KKQmcb80hOCu?=
 =?us-ascii?Q?qlZ1wa3q0T1SOpmGnXmF99oufc3VTPSBmAtUV+QACuuEPYbBzbudz3G06z1S?=
 =?us-ascii?Q?fRiep6MYOxV74mHayMzH0uIZmIIhcbvN+wnVBjXE8paiESPRmcmNZldvMQ8j?=
 =?us-ascii?Q?L5uBgS6L3I6KBC1cGdV7rGiYO5UKIFq2PspIjKcdfy+iY2h1AfD5qD5edrqE?=
 =?us-ascii?Q?w2GnUmlkTJ4f5vJKUWXuhkFvTNyh5xLs2uPwEZA0rQS6yc0rAyrJxLOx12RE?=
 =?us-ascii?Q?qlAIO2hBoq6eEK8QhboZg4EZVJS2o6+3/gYq3ZHDwJX9okeDwmuLMlHWDWGv?=
 =?us-ascii?Q?1xARzdUW5ZZrMVRc30E6l5k0kVL2cBzcC9q4JEG/km3lz6BxxKflGCZ+VC4h?=
 =?us-ascii?Q?TuhhZR2tMdBJ6+5cP2uYEojaXmW7me9OhsCFDw68eIShYznirRsIdMVxGEeQ?=
 =?us-ascii?Q?B/buFey5nB6zQWl6zfNecBAKnxVOiEgjo5G1qkDOaC7QDmEB2vGWDC5pKhis?=
 =?us-ascii?Q?Kup+/tmGoqlnxg2MY26bxPIkdd2dQfOApUpYDwZk0FhdwYCN+jCycvhRG/Hx?=
 =?us-ascii?Q?CnxdYbZ0tTLfDm6CBUyTNBTrbO7sT6yUBDdhDXc8lzQbA11saLqQtKDwkw6t?=
 =?us-ascii?Q?eC40JNUXSqp8lYnAPhL8+OX/3OLYqSVMvO0njw9n3lHG4kU0Q0QgkPW1ROt9?=
 =?us-ascii?Q?7RiHy2Vzzbh/acgyvkQPv87QR1cOPWtcxIyINQsvdhh4dYIr2gPMx8UNAqQA?=
 =?us-ascii?Q?aVohFRVMy5huFEcQyLu3HLQ84xAmToW6/lpCW6BkpuYReq0FKtSiDObf22Ja?=
 =?us-ascii?Q?L42CAD5OfEODCS8n7trXZ82/HBcokBDATIWbd4wl0MD7XmWJW7MtgDtITMyu?=
 =?us-ascii?Q?Sd8b2jX2DDcjlYJEtQoehrdCuIB/m/IHMKe9rZQC8+Ao0gMbbzJe10TvPZA9?=
 =?us-ascii?Q?6gNMV/xbdKJ178nsh2AOcfS17O0lOtYSWhqFyhUpfNQC8K78WHV01Eampgbq?=
 =?us-ascii?Q?d8FCgMbE0toFmKYGI1oOSLWXCvY4Em3TV4LKwu1EehXgFG8B7aYc7yoLPbiC?=
 =?us-ascii?Q?T9zo691KivoRRzlAShJvSjKSWCelg7VhFnQQRPJPiqMEkHBgpS/mvlDrHpv4?=
 =?us-ascii?Q?hh4g9ufY36PB18Hi5fw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba4816b-f17e-4256-4965-08d9ed197791
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 04:46:28.4205 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LuozoeJrlvq8pIs9t2olba0yYbyF5aW97tUPcusUSktLAOlGkBe+J9lOb9g1uFkD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3492
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
Cc: "Russell, Kent" <Kent.Russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

If this is only available with the latest pmfw, you might need to add some =
version guard there.
Otherwise, garbage data might be got with latest driver + old pmfw.

Also, the "metrics_lock" was already dropped from latest drm-next. So, it s=
eems you worked with an outdated kernel.

BR
Evan
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kent
> Russell
> Sent: Thursday, February 10, 2022 11:43 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Russell, Kent <Kent.Russell@amd.com>
> Subject: [PATCH] drm/amdgpu: Add unique_id support for sienna cichlid
>=20
> This is being added to SMU Metrics, so add the required tie-ins in the ke=
rnel.
> Also create the corresponding unique_id sysfs file.
>=20
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  3 +-
>  .../pmfw_if/smu11_driver_if_sienna_cichlid.h  | 12 +++++--
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 33
> +++++++++++++++++++
>  3 files changed, 45 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index ad5da252228b..f638bcfc3faa 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1969,7 +1969,8 @@ static int default_attr_update(struct
> amdgpu_device *adev, struct amdgpu_device_
>  		if (asic_type !=3D CHIP_VEGA10 &&
>  		    asic_type !=3D CHIP_VEGA20 &&
>  		    asic_type !=3D CHIP_ARCTURUS &&
> -		    asic_type !=3D CHIP_ALDEBARAN)
> +		    asic_type !=3D CHIP_ALDEBARAN &&
> +		    asic_type !=3D CHIP_SIENNA_CICHLID)
>  			*states =3D ATTR_STATE_UNSUPPORTED;
>  	} else if (DEVICE_ATTR_IS(pp_features)) {
>  		if (adev->flags & AMD_IS_APU || asic_type < CHIP_VEGA10)
> diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_
> cichlid.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_
> cichlid.h
> index b253be602cc2..c09dec2c4e1e 100644
> ---
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_
> cichlid.h
> +++
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_
> ci
> +++ chlid.h
> @@ -1419,8 +1419,12 @@ typedef struct {
>    uint8_t  PcieRate               ;
>    uint8_t  PcieWidth              ;
>    uint16_t AverageGfxclkFrequencyTarget;
> -  uint16_t Padding16_2;
>=20
> +  //PMFW-8711
> +  uint32_t PublicSerialNumLower32;
> +  uint32_t PublicSerialNumUpper32;
> +
> +  uint16_t Padding16_2;
>  } SmuMetrics_t;
>=20
>  typedef struct {
> @@ -1476,8 +1480,12 @@ typedef struct {
>    uint8_t  PcieRate               ;
>    uint8_t  PcieWidth              ;
>    uint16_t AverageGfxclkFrequencyTarget;
> -  uint16_t Padding16_2;
>=20
> +  //PMFW-8711
> +  uint32_t PublicSerialNumLower32;
> +  uint32_t PublicSerialNumUpper32;
> +
> +  uint16_t Padding16_2;
>  } SmuMetrics_V2_t;
>=20
>  typedef struct {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 2a7da2bad96a..048014f05b35 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -451,6 +451,38 @@ static int sienna_cichlid_setup_pptable(struct
> smu_context *smu)
>  	return ret;
>  }
>=20
> +static void sienna_cichlid_get_unique_id(struct smu_context *smu) {
> +	struct amdgpu_device *adev =3D smu->adev;
> +	struct smu_table_context *smu_table =3D &smu->smu_table;
> +	SmuMetrics_t *metrics =3D
> +		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))-
> >SmuMetrics);
> +	SmuMetrics_V2_t *metrics_v2 =3D
> +		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))-
> >SmuMetrics_V2);
> +	uint32_t upper32 =3D 0, lower32 =3D 0;
> +	int ret;
> +
> +	mutex_lock(&smu->metrics_lock);
> +	ret =3D smu_cmn_get_metrics_table_locked(smu, NULL, false);
> +	if (ret)
> +		goto out_unlock;
> +
> +	bool use_metrics_v2 =3D ((smu->adev->ip_versions[MP1_HWIP][0] =3D=3D
> IP_VERSION(11, 0, 7)) &&
> +		(smu->smc_fw_version >=3D 0x3A4300)) ? true : false;
> +
> +	upper32 =3D use_metrics_v2 ? metrics_v2->PublicSerialNumUpper32 :
> +				   metrics->PublicSerialNumUpper32;
> +	lower32 =3D use_metrics_v2 ? metrics_v2->PublicSerialNumLower32 :
> +				   metrics->PublicSerialNumLower32;
> +
> +out_unlock:
> +	mutex_unlock(&smu->metrics_lock);
> +
> +	adev->unique_id =3D ((uint64_t)upper32 << 32) | lower32;
> +	if (adev->serial[0] =3D=3D '\0')
> +		sprintf(adev->serial, "%016llx", adev->unique_id); }
> +
>  static int sienna_cichlid_tables_init(struct smu_context *smu)  {
>  	struct smu_table_context *smu_table =3D &smu->smu_table; @@ -
> 4012,6 +4044,7 @@ static const struct pptable_funcs
> sienna_cichlid_ppt_funcs =3D {
>  	.set_mp1_state =3D sienna_cichlid_set_mp1_state,
>  	.stb_collect_info =3D sienna_cichlid_stb_get_data_direct,
>  	.get_ecc_info =3D sienna_cichlid_get_ecc_info,
> +	.get_unique_id =3D sienna_cichlid_get_unique_id,
>  };
>=20
>  void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
> --
> 2.25.1
