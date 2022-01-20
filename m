Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76026C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 03:39:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFD3510E21D;
	Thu, 20 Jan 2022 03:39:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA8EE10E261
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 03:39:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFb5jH301r/lv3zCFUlXBtzH90/Y4Co9jkcOUL+c1O+GbGO5vs5ddb76sRVStcJLnTRmGqSqqwjBDrGhzzknPu7ZWeeLysuf8pb+cdMdrlw2o920RW88S5JTy+5lMUOStYI2ao59jQ6yBAQJMZmqXPN5kpmK2Y8RsZZedG9omDC1Ov35Onh4IxYXffgL8gOkV+Hr382KDrzb5GY/xcXL+YdZGUVJ2FE0kMHgKay4hm7cO0rjZvmCwfmFdMOlDiXD8AWgZH3zGpaR3uML5I9dopwGFFCF44R+ip+AEnyumSmoIbywmQBiABFfGUhXzCSQtLyFFq2BH+YXiEbB1/vhEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVMxpeLfM8Ykgs+4dXB426FVS7SDB+DgIJnHmITaD00=;
 b=BufvORTZ9/foonaBTqG+Z85Sd8hj6jJWMX171wi2TkRyZFcVsFjHzKzbTvgYUiXKFa6j375COlPlDciUZ9CxEaY6QQ84fFGETQ2KIzXbhShsm5U6EGY9H6sR8o/4WPMpluZIuTeSqT26Pg7HHRUzSrwZ7lTxEgYmvoier0y0GmPnVzYq4Ufsk+bp6e7hnjcOtgScXeVsC5tNxYZM8lUsHB3jr9yLCO2ky9Vnc1A64ZcABZw/7r0GfPziSbfaQ9Heq2tkzfAB9bAqBXnEDWWqkXOYQM/qVU8NJ0kZzAoelaR4uiYmPACxLzYY4PhG4ItQ9Vlvh4Ls0wx9Zss3sGFFFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVMxpeLfM8Ykgs+4dXB426FVS7SDB+DgIJnHmITaD00=;
 b=wvdlJ19HB5HyWvLm+W3+WPGd8WaNqPNRiJUUC07/jPVHk5ag8jJ1HGBdqqJwkX1VS1w5QQXbbkXDBUW9IXIEfqd4z/ji94mABUR1irvDYukBa5Y8dmB/+zPt8w/e9864xFHM9k9pKCQ1bDkio2Adbpy2GE7OUZ9FSwfdKnH05uc=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DM6PR12MB3482.namprd12.prod.outlook.com (2603:10b6:5:3d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 20 Jan
 2022 03:39:54 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934%11]) with mapi id 15.20.4888.014; Thu, 20 Jan
 2022 03:39:54 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 1/2] drm/amdgpu: Move xgmi ras initialization from
 .late_init to .early_init
Thread-Topic: [PATCH V2 1/2] drm/amdgpu: Move xgmi ras initialization from
 .late_init to .early_init
Thread-Index: AQHYDayJmyofGP61T0OJDUUhmCsiaqxrQ1tw
Date: Thu, 20 Jan 2022 03:39:53 +0000
Message-ID: <DM5PR12MB177078C15FFA2C1123B2F612B05A9@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220120031850.350206-1-YiPeng.Chai@amd.com>
In-Reply-To: <20220120031850.350206-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-20T03:39:51Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=3b645c70-ca0a-4d1b-bfde-e08ad2eae3d1;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-20T03:39:51Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: dca31926-c554-4b40-8bfd-fa101fbd4cf6
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5717615-8c94-4164-b2a4-08d9dbc68590
x-ms-traffictypediagnostic: DM6PR12MB3482:EE_
x-microsoft-antispam-prvs: <DM6PR12MB34824C3A224144A489E5BEAAB05A9@DM6PR12MB3482.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PezzW/31IvwnOVmqIGnE3Lx3PmSOYSA4fJVmXNOVGt5Ja0fVqBVd36i65q8Zup4QZ069ARLDD0KlDnEnsgMUeGvxF7B2pHn5TR5dEJjvUgzfiH4Ki0CVsDMcxNoEimrrZBhJmUrh2yGTgAf2Gqz8iDOHrbtcNw6lmvRJOCrpG6onCX+Ok6bgO5kvLe3pr7fva8/wDP/x3+GZAm4POMGIjlMrC1kgigQsHb+b9loHdFjXKDXEUCLtsGvVvmHzX9oiJjVl8zvr/CC7hNvz6vrOws1TbKOupFvcBoKCDcHQr+Z8AkeiASl3ulTUczNYoJVATQL+cu9oXrdq8E3m5c9sFgvwMbYR2hlUcva9xUaH1gz5IsOMN/y+MwLW1kvmVvaC8QeTV9ONZUz44haCO0IHWtkZ2lucrWv0qJve0NAkSiH/IhzN3QMY4Yqp+0Ahw8BKR82mLGU8U5nlpH0Jem3t2MbfDAN60wLD7DEgfleug/E3j6GiTxhYii4xABd+2Y0KsfqfQAMCk+pRpslng8oM5Kv6wuYGfGgSMgd87Kaeu0CTO+3pFNW53sLAptCSl5I7VR/SIoJxhOFPP3/FZewsIg96FtIGK6Lf3DGg+6DvBttvJWnOHsuw0MIpAA7BfcF3dbu12vaKPGPvMojVrHzA6iFLUF9gM43u8NvN6ATI8wKomLxslgOzluZoLANdgwezmSmYpW5E8T5JS3L1sv7NN6GGzwgomKCs0MVCiRzAx5w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(38100700002)(110136005)(76116006)(8676002)(508600001)(8936002)(5660300002)(9686003)(33656002)(52536014)(54906003)(26005)(316002)(186003)(71200400001)(38070700005)(4326008)(64756008)(66946007)(2906002)(122000001)(66476007)(66556008)(55016003)(7696005)(66446008)(6506007)(83380400001)(86362001)(142923001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?edWbzE6TYJg2sGj/mo1vJESJQx3sY197hZI4UZ/BRuN1vwTmVWooZ4daMtMt?=
 =?us-ascii?Q?KnFSQVLoT1EOQbpuaKpchF4HWhIjg/mXG+8hfXxsRBu3oJnJ42hQi+yeRHyM?=
 =?us-ascii?Q?jVKhus2888s57Vv1iZkY5KV1z4vUiLUkUX5lNcp0mI+397TCFvN7Qij5yQc+?=
 =?us-ascii?Q?yOzC6Q2V4p3gTOGXfdzrhsdFaWLWKyzlzeDMBrgILNmpGhUbVdSM6KVi3Uyq?=
 =?us-ascii?Q?uYp1vrKtYLxGtiUMZ5Cvg2sVck78qNS9jkDbPzs+ckNdazUEZbQffRFenpBK?=
 =?us-ascii?Q?jUkSkJ6qqmp9y8GKJIcuouYNEfZMnxnvFknQ6mDU1ti2ePDRzEqK0kiYkMj6?=
 =?us-ascii?Q?NDdxm1u2uMLzS1YryonX8pWbcFzV4ovgNOkxeomvCMxTVyVvhi5zyEcZXAf3?=
 =?us-ascii?Q?hto5s6Llt+eGFQcJMu1fci8t+LUZQP7ByEkR91oCqGJ5nNNFKRXuItoGkAKP?=
 =?us-ascii?Q?VD+hr/0jA5D8i241kCti9giWLMov99fiav8ng4Gb/x8ba9aFNNSW/9+rJjg2?=
 =?us-ascii?Q?tzr1sCdt3f1Lr4a3MifFYm1zTo/LpQrTr7in5+EQ+fuvFWUpcUBTSSqVdD6z?=
 =?us-ascii?Q?aJRZqOi1Dmdx0F6ed7pi4Y0hgLGWakWxoU8RxzOdilYwfTMtdsWKb8vXJsr5?=
 =?us-ascii?Q?bjjBlq2NN8aQF/QLvbfF78+jMY/Eq6Sepl7RN4PzaxP/b6geXlrd5dAARn9s?=
 =?us-ascii?Q?ZTTJhmSzYkzbgwIdKQlImUaF+5mjYsA9UoVbW9zcJDoEsRK2Yr/8wOmbSLr6?=
 =?us-ascii?Q?3v8cw0Zq7OqYHxY9Q1QhrH8a8PuuAKn9Qg/aPWK/sCWEn+IAAcDgqnlNFG2N?=
 =?us-ascii?Q?y6HbTLS5x4ovGrufVoVSzxnvi3o8m7wVoq5Qrki+1/IENR0yQHrXCiCcNMo9?=
 =?us-ascii?Q?W0MQWqs6FRt/faDNVblqua0P5VagzPOlscrPsNrmk/D0xDrOhoxe5v3qVw43?=
 =?us-ascii?Q?wdTt4iDumJC0HI9EQNMyOxphWmgS2CwQHBbuBHPrMeGCZ59MVbC1vpxSwufL?=
 =?us-ascii?Q?pir3WU1phHxtt4NXb5H7ekhNOtpjLtekCbRFc/8g9kFoQAYlHQ0Dl/FQjqfr?=
 =?us-ascii?Q?YBjvLnVDNIct089Qz15YwK88A6m5sR3QyKJwJ2t11Znk/tdZmVJVmkm3rQok?=
 =?us-ascii?Q?/E208U/uUG9TyXHQcuhXv6TEkKBKwd3mEHN4g34M/zJqwR7WBZA5ZcCykD3A?=
 =?us-ascii?Q?ponrG/fc9bs/imT1wdMNXZkNsi4Mjyfx/ROXzMgayiqanrz05UXG5K5H2huP?=
 =?us-ascii?Q?Qtm9SuTnkjMSgJwAsJ4rxHOvaHYW+FeaS7Ian/RRlAU5FmUQthVTxW4BEI8I?=
 =?us-ascii?Q?mwDNkDzAgDXl3wu6VF12H7/4XMHFdC4t8tixmVdvazlehXbox4YHbLhOdZZf?=
 =?us-ascii?Q?hL5UF83jhjqYl8+q8MXvc3iR4dQfQmFtZJMLfxLTfEH0S4XSMWO1HsjiZ05f?=
 =?us-ascii?Q?Iw2EHSV3yHNx0g2lARhlZsGb6KZqkyE4Yy6+861zSLaPvt50q0RQSCQ2mYG9?=
 =?us-ascii?Q?2vGCRj/QywJDCSJiiIaKJEUOqUTwnqUH8Ln0h5n5ztb7Aqo/3qBlP0QCPo0f?=
 =?us-ascii?Q?2f4CqI/TBu1KpQyclAg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5717615-8c94-4164-b2a4-08d9dbc68590
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 03:39:53.9089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vgjciYw6mgIABBYJev61l35K9TLsikujDgDpPUTPEcrABHHa/Ils2AeSfSKfI1e6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3482
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Thursday, January 20, 2022 11:19 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH V2 1/2] drm/amdgpu: Move xgmi ras initialization
> from .late_init to .early_init
>=20
> Move xgmi ras initialization from .late_init to .early_init, which let xg=
mi ras can
> be initialized only once.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 15 ++++++++++-----
> drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 +
> drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  5 +++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  5 +++++
>  4 files changed, 21 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 3483a82f5734..788c0257832d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -436,6 +436,16 @@ void amdgpu_gmc_filter_faults_remove(struct
> amdgpu_device *adev, uint64_t addr,
>  	} while (fault->timestamp < tmp);
>  }
>=20
> +int amdgpu_gmc_ras_early_init(struct amdgpu_device *adev) {
> +	if (!adev->gmc.xgmi.connected_to_cpu) {
> +		adev->gmc.xgmi.ras =3D &xgmi_ras;
> +		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras-
> >ras_block);
> +	}
> +
> +	return 0;
> +}
> +
>  int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)  {
>  	int r;
> @@ -452,11 +462,6 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device
> *adev)
>  			return r;
>  	}
>=20
> -	if (!adev->gmc.xgmi.connected_to_cpu) {
> -		adev->gmc.xgmi.ras =3D &xgmi_ras;
> -		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras-
> >ras_block);
> -	}
> -
>  	if (adev->gmc.xgmi.ras && adev->gmc.xgmi.ras->ras_block.ras_late_init)
> {
>  		r =3D adev->gmc.xgmi.ras->ras_block.ras_late_init(adev, NULL);
>  		if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 0001631cfedb..ac4c0e50b45c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -318,6 +318,7 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device
> *adev,
>  			      uint16_t pasid, uint64_t timestamp);  void
> amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr=
,
>  				     uint16_t pasid);
> +int amdgpu_gmc_ras_early_init(struct amdgpu_device *adev);
>  int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev);  void
> amdgpu_gmc_ras_fini(struct amdgpu_device *adev);  int
> amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev); diff --git
> a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 4f8d356f8432..7a6ad5d467b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -719,6 +719,7 @@ static void gmc_v10_0_set_gfxhub_funcs(struct
> amdgpu_device *adev)
>=20
>  static int gmc_v10_0_early_init(void *handle)  {
> +	int r;
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>=20
>  	gmc_v10_0_set_mmhub_funcs(adev);
> @@ -734,6 +735,10 @@ static int gmc_v10_0_early_init(void *handle)
>  	adev->gmc.private_aperture_end =3D
>  		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
>=20
> +	r =3D amdgpu_gmc_ras_early_init(adev);
> +	if (r)
> +		return r;
> +
>  	return 0;
>  }
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index c76ffd1a70cd..3cdd3d459d51 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1318,6 +1318,7 @@ static void gmc_v9_0_set_mca_funcs(struct
> amdgpu_device *adev)
>=20
>  static int gmc_v9_0_early_init(void *handle)  {
> +	int r;
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>=20
>  	/* ARCT and VEGA20 don't have XGMI defined in their IP discovery
> tables */ @@ -1347,6 +1348,10 @@ static int gmc_v9_0_early_init(void
> *handle)
>  	adev->gmc.private_aperture_end =3D
>  		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
>=20
> +	r =3D amdgpu_gmc_ras_early_init(adev);
> +	if (r)
> +		return r;
> +
>  	return 0;
>  }
>=20
> --
> 2.25.1
