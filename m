Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E413EC61DA4
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Mar 2023 06:11:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68D4110E130;
	Mon, 13 Mar 2023 06:11:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E4BB10E130
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Mar 2023 06:11:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwP5ZzzMLXKisPaPWI/yQ4ZFO7vcLEtnxHQ6TBXw9EPuQr8GnLm+vnZEFRNb39QqnIh3BI10BshvQKau+6myB/eMq3rfS1qcHF+Ql8JLbOKS/TcmTeoplFnaL5WmA0C1zzx1dkmoUUTLW6BGal7bUF+c7LoDU/EsG2hCy7jcvo4Krar86l+Npt2D7dXLg7cljMgJVkHLG9AAgyaZr/VWq6B4VWnj3pKKzTV9RjYUnlNgKe3l/ujRl5dIhmBiNIENqXxjyGt6gCxOD+vuRoXQgkLWvCWKuhDKTENrTKgu37yI2bmGn5b69uZLHAE1ijMXt5LXrlfjKsPfzfyWfhtrIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrsCDX09WXKs9s0BuIBqKweMWTEtcri/n12pIBmwpnU=;
 b=M5v+TMiJ6YVwzdVGv9SnT/yM4Xbgb5ge6MQWJfJg22Z8Qx95ssXertj4y02ayMptIOPQ0SH0DQgC4u2yBEyhX7U1lbHihkF6v51bcg8XpryfVyxFpyK1CF8M27Ju7FO0wjw3HBsNgLylI04At2p0LxX46skkV6fHm6dQVuiTJNeq2UvbsfGHS27Adm4wc70NQifpAvsIWtY+japdVGPf/BPacrNomXStDNFl9BqRMZzyffyVNmxzN8spkOJZ84TmRenipFMC9NnjKshrXTHjLRSVNX4t49vrDw+u1xS5wcDYyWeWq10qUcpv7QbK2mBAykP8l7jW08+m73PkY/Lb4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrsCDX09WXKs9s0BuIBqKweMWTEtcri/n12pIBmwpnU=;
 b=BC/+CAAIHXcAGvOHZ6BvSs1yS2jbkNwKCRSjNfO8oyGWdjY0LMo3p13UO6oGH1mSMu3Q+Wto+/tAwzDlRIvPJK61gmU9yoZxXxZKyZ/odpvFGXWwc3o8Ylg7v5K5IAe4Vjf0OPlPI8d4H5jHSSxwZa90Vto2skquRANfDdaAabI=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by SJ0PR12MB8137.namprd12.prod.outlook.com (2603:10b6:a03:4e5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 06:11:42 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::f228:6619:2cd5:9bf8]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::f228:6619:2cd5:9bf8%7]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 06:11:42 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 09/10] drm/amdgpu: Rework pcie_bif ras sw_init
Thread-Topic: [PATCH 09/10] drm/amdgpu: Rework pcie_bif ras sw_init
Thread-Index: AQHZVU1qB8MMrR8ydUer9guesvRyQq74OTcQ
Date: Mon, 13 Mar 2023 06:11:42 +0000
Message-ID: <BL1PR12MB53349D47CB10CEA427273C989AB99@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20230313014403.21903-1-Hawking.Zhang@amd.com>
 <20230313014403.21903-10-Hawking.Zhang@amd.com>
In-Reply-To: <20230313014403.21903-10-Hawking.Zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-13T06:11:39Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2e40e987-7604-4d12-86b1-d7651daab8ce;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-13T06:11:39Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: f4a9172d-e7d1-48b2-9840-025e9b07ba12
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5334:EE_|SJ0PR12MB8137:EE_
x-ms-office365-filtering-correlation-id: 9140df9a-a50e-4d56-bd2c-08db2389d0f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HZYolQC/lPOzPTt+vwG2N9DJLP+hsl3IRaiTJmxFUBe/oqSQd+QsX9+6xnXWSg7bcubV7hyBiFo3s+jbVxGADGufFFHZbajH90rRnoGQ9ooi22Uy9LvsoNrqUYILtMy5bR0IL4cZkF4IXMG7Y2J2y9/O4W/am4Zf34N+VhIsR8uwNr8dZKGE0n7KfxHukD+0uTxuEkcqoHsVb0uLtDDMqsac/mqFoUYo9KWaf9tHbzp+0PZKxLgF1jqElU5LqMeoPpFtKycfAEgwWBXYaKBlZy9z8vEw7nM/1jpY8Sn8ydJJGiGEtgv8GHk6GgMuS8rTbgGdL+FB4hGQRugwf82r0OHerCHrFZcBkwRjZVJsFGf/Vd4vsrR4b1y8JnMx3nHI3f2uksG9wMVL/dy3fScFMNJIA1cYgALyPyo8BHBFjcJUIGtPUB5X+nlZbGWJGvo3jCQaNV2VvRVxYINEjyytpYHLnh/eCFESClnh3+FYhMf5gXvq2typ5boVbt6rG0nn+ovm+yvFVirzPC5GbDMI1fdyefS71yLW41JjxOi5qPtCw4d/Pp10Y7lsrtPvt9Cb/pjnXsJQAl64PmYZ7mlpMFLhhYs8mDesq0tkB2HMhPgHTA7xaVHUNcQP0YI2TkvpP3OWZvi391nCaVx3SDOb0Qo5nzXzltJi6eBLLk9gMwDO8aQLeGgLKYU5RxmbeXOdKB953wZ9DE7t2UtGSuLKCA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199018)(86362001)(38070700005)(33656002)(38100700002)(122000001)(55016003)(66446008)(66946007)(76116006)(66556008)(66476007)(64756008)(52536014)(8676002)(41300700001)(110136005)(8936002)(6636002)(478600001)(316002)(5660300002)(2906002)(83380400001)(71200400001)(7696005)(9686003)(186003)(53546011)(26005)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3pDPMZz51QRW9/EmKJ0dbmOpmKZf9rabN+H5oO1Op2OniIhsvY/LpInA7m23?=
 =?us-ascii?Q?nFw1TzBqDOWmaLwnoUzE4++jpl+KCo8YAZIbtmZNXir063R75q1Tu+0HPwK9?=
 =?us-ascii?Q?MHDd7Di+a5KypoMBqZ8a8FrgH20ns8M0Bk42lvvXEed8GdvkSYEApqNkk+xq?=
 =?us-ascii?Q?QA3c6/X6i3Xqwgd62ZSA8t21Mc+tU5TRQsHMOdXhJzpRNFkSoTHGT6VH+WUS?=
 =?us-ascii?Q?taN4ceCm4zXX1Oje2h9wKV03JN+IMARnqbuYx5xpPJaeXVnPOSbk335m3NWz?=
 =?us-ascii?Q?+hXHfcN1YvcMTDpZ068Jx23wO60wOKV+d1eEjQN9rX1UBAW8H7fnqxd5gMhg?=
 =?us-ascii?Q?I2Xzzslddld3IHl/Td4MdRn1Ox4b1mP7JF0nFUGB5t/w46sb4GB8+KHnz5zs?=
 =?us-ascii?Q?kmvQMqVz0ZX+CqiG6De0mDEv0+c4RnG7Sls7fuyuWS9tRtbbV9bSBAME3OXF?=
 =?us-ascii?Q?xPuQx/LdfnxJ5DbVx2vXeUuL7mdvPDInuOsXVHkDUMqZLb4NPqc96U+uYyJf?=
 =?us-ascii?Q?cjdcWbMsXNQuz+PvZlMVnev+y3Yyp7TueVTy3NDK97IXYy2kWzEbNXjjpQ/S?=
 =?us-ascii?Q?qDTapDzpQN7CVkqkg2fQS3onPevmA96uJ5orajOh0Y4lStzniltlt7utcpTe?=
 =?us-ascii?Q?duhha9hONNMG1J7naj6k1UTelQPs72BJbsXbT/wLj3SUZ3HCgRdNWyubuWic?=
 =?us-ascii?Q?/pIc+aYWtd6NgOgrdhX2hv+rv7qpLch0tZY0yNIpEHRgZBSaPhlBR6aORCYB?=
 =?us-ascii?Q?TNlVvTJOPVpS1Qexjcan44ZNidhR7YjLh2Rg0HcBHA7KU9XgQKAz3Lqzu04+?=
 =?us-ascii?Q?2WRucrky9eO4RSG4Ul27aNrBqljp0dmADmu0IE+TdTKOSDceRLoN8ZKdfcOs?=
 =?us-ascii?Q?VjEeqqJa9MRNqCLAouHHb4Kal3b+k9tifMJveoTbHw0En6yJxCFQwULF0Cv8?=
 =?us-ascii?Q?EbGu1SDaZB4ExH6vEjvlp7iqxVpDFtKa/xWDMcYcVAeEtYis1mF0Ns5auCIE?=
 =?us-ascii?Q?rDoMB5nggGlRuC5VzsKQKh43ZWhBRTIcomCYj8ZUyfwnvy8rqA5P7IOqYlN/?=
 =?us-ascii?Q?cd2fkSiv8+AAeDpXb8/nRM/98BPTjT8U0oYEzz4MjaEmWi2uYE6NrJfl3heg?=
 =?us-ascii?Q?uBJYTm+mfBDwJk4XTvlQG8/A3fMoZdP/hEsRa/ApbCOcX4otYy4d4HSWARgi?=
 =?us-ascii?Q?NdIklaOmNY8w2P+krO9iMHFUqGxdBIWdUE0hB5sMdP18UpJLKtVbtSMkIkx5?=
 =?us-ascii?Q?AIlLgA8Kdc3HVTjuRFeICrHrM13qtG6TihilsQg4RZKBYRk9307chDMgT2TW?=
 =?us-ascii?Q?ywC52xnJ+n1ZxalL0Idd5LeUx5kY7IGgc1q/JO77YbJi6mmAVUlU/5s8yIJx?=
 =?us-ascii?Q?NzL6PZriRXCtCu57RuwodS17m/+4ONl8tWaRKMuozcF1AjAhK1HeyhF6Cbim?=
 =?us-ascii?Q?A0ntXidIB9iu7g90xczRX9d0KnQvtorYcKnOoCUX3kxQQ5U7aNZR2eCjL23F?=
 =?us-ascii?Q?K+GqbEKt1SHla9D6DJYTg14hTouX/OMKwwEyc0I6/LFtA7YAgyKCqyr+gzaX?=
 =?us-ascii?Q?EbiDHfuBeHoMGWgMaDe737l5tL9/aKJkDS7r31JX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9140df9a-a50e-4d56-bd2c-08db2389d0f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 06:11:42.5361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jwy1TloNmS5V0g8Lurj+gwYtr+bVSg2YolYetyCV38ggFfBiIXXp/5Ro+oCHbQohKCIY2mjQ5Fp8mAISeDeuYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8137
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

Without the inline comments, the series looks fine to me.

Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>

Regards,
Stanley
> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Monday, March 13, 2023 9:44 AM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>;
> Yang, Stanley <Stanley.Yang@amd.com>; Li, Candice <Candice.Li@amd.com>;
> Chai, Thomas <YiPeng.Chai@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH 09/10] drm/amdgpu: Rework pcie_bif ras sw_init
>=20
> pcie_bif ras blocks needs to be initialized as early as possible to handl=
e fatal
> error detected in hw_init phase. also align the pcie_bif ras sw_init with=
 other
> ras blocks
>=20
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c | 23
> +++++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  1 +
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
>  int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct
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
>  int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct
> ras_common_if *ras_block);  #endif diff --git
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
