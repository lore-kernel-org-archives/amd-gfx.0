Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A2CC4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 00:10:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A288210E203;
	Fri,  9 Dec 2022 00:10:42 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C0DC10E207
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 00:10:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyJFLCqIHJnEPhSxiIqlx1AfEAn4IDcvTXY+knTMOZGPTPij6/RDTNKQ01dM6ysbcfgtwCo9GVWn6ywRhs+cEQKIr1zhYTtmly6d81aaOCiino9X7OfKH4n0pHbdeDhCqzqV2T1vmHPm4pjrfgjaD9lVbRN3/0w2l7lPEgBjpuzTrMEHU/nObYcalnOYHd2PqjCrVqWowXQEFtJ9i6RjGeAwfkj/n/QXosA248Z05gAhp4O7kSijBxoQ7i+5NFO91IX56hHYiVddCLSrSr8GcwF31TgsG5qnVU9YhHv1BTQnJ/gU0grUimQYF7vTeeGmRx8xyWeLMgBNDIYvJMeSwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5faGYGrT3rA0ECZ+qa1R+fJ2dkDcyEtwdkDpQNqfP8Y=;
 b=PoULzEkpAEM/vD11Rh/8ALXgd4dDgD/BFnMlgv1D6l0f7BDCf/DchgtM6y6FvCNexUhEIXokUXpXyYYCAluRnBJwwhAMdGjPEfvFN61T5a2TBjgc9o24g3AdNaadHwOq93w70577DEjEv9gU1ScX3hAspsSHmc0cuqz0CEFOmL0eCiSluE/mWC4bi7+XEnBaZIjdDAZFH18uWC7z06Dx3dC8FQLpoB+zWkmHhXU+LRxkhc6wbu8rNnrhSo1kBEtbWQDfJ25KhfktP9FbZgkfUg2O+aMzuHRNcV1zJEDXnJ0CqTu/flKBkRUt498Y/5h8iOV3QaIYXvGBnJDwzAe7Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5faGYGrT3rA0ECZ+qa1R+fJ2dkDcyEtwdkDpQNqfP8Y=;
 b=pJBbCHqp5jNAJ0rW88VMqJb8bVUw8Ytn0QdTET0foI5xxgte8wYjZDtIneWuG8Aou+T8cJgPTJD/PQDek2qCGuzSauqx061oUzLUSAL80/1uA+MJBnBn8Rap2zo9nUZCOEd7peD5EwesdOpYxva0XTpZXxUeD9LWs69lw0WYM9I=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 BL1PR12MB5287.namprd12.prod.outlook.com (2603:10b6:208:317::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 00:10:38 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::9440:1b9b:2878:832a]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::9440:1b9b:2878:832a%3]) with mapi id 15.20.5880.014; Fri, 9 Dec 2022
 00:10:37 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: handle polaris10/11 overlap asics (v2)
Thread-Topic: [PATCH] drm/amdgpu: handle polaris10/11 overlap asics (v2)
Thread-Index: AQHZCl5QN6wOS2KsWkOhc4aN8VM8Z65ksI2Q
Date: Fri, 9 Dec 2022 00:10:37 +0000
Message-ID: <DM6PR12MB2619192A3B54918A99309EF2E41C9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20221207170629.3291883-1-alexander.deucher@amd.com>
In-Reply-To: <20221207170629.3291883-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-09T00:10:35Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f6b39394-cc01-4b10-995a-c699642126bb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|BL1PR12MB5287:EE_
x-ms-office365-filtering-correlation-id: 28a01945-85ec-48f2-c721-08dad979ccf1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JhBwwf/2Iuxd1sZlyU8PDpNUxgMhMLur6/m04s2LQJINhrBifL0PT+W2t/IneVzto+QIhc4L2kMQWAGc/dvo21B8LBAlsb4DuXkxQbaJTxaY38N7kUhNzw1ezFt31M8PHuhaUCxVDSIVxEVMt9eIzg+IXAWrIQkpD4FfDjozsMk4AZ78Jc8F1XYjIfa8Qyg1P7rMH47ltmaKNAgoNTubI7Lw8u0gc0nzcG3nqB9MfUOYGwKzawF8jpvLORW9qYfJSrEvZVvhXt4L0sBKSjry424RHOrYpJAQXQBoU68eFKl7PB40rpsfPy4aE6fZAlUyJPg6p6UfSREoMnmwPAb4XRsYOeY7cslOPzlG2PQJ1JFys2FkR5bo1QuACAPYUTqv2oi9AVeQExCpDbHUfkmuxrromlbn9mR4Vi7dcBDH/XUfsXoFoksZ530175Iw7Qt6KcJXCVqoCC2Z7hjx8sZSEEVnH5igKqojtSUYzAvjqjvDVnF4PnmCD7lZaO7jCfQnZQDr45GP66xEokHbpSzRu+GSB1bqwBHfb83hy6djlCotpg8jLbLz2cpf+qtKJAdOS3ZVV5DptBpA/yZs2GzydhTZGh3M7Ehpi/DaSpJccxn8Xpkf+yGv9hdfTGSvNQkfVjUNjgVKck1+Ukc3Mr9Q+DOhfhVRbmToVp2k9HhladOO60rhof+OE4kgkqK4roPl06W9rqQKrhuWTI5cxMPJJw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199015)(186003)(53546011)(71200400001)(7696005)(9686003)(26005)(2906002)(478600001)(38100700002)(55016003)(122000001)(86362001)(38070700005)(33656002)(83380400001)(6506007)(8936002)(4326008)(5660300002)(66556008)(66946007)(66446008)(8676002)(66476007)(41300700001)(76116006)(52536014)(64756008)(110136005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZLh5fnt0o0rTlyIVRn2bezmtxsq2S2tnAxhqdvsNVcjmujkI3vCww9CmwuNx?=
 =?us-ascii?Q?AuxqsuS3/+72d3YU/lr/g18hgbVOB3sJ3D9j8ouCYOIi3v2JxI7T/apJ6UYo?=
 =?us-ascii?Q?1k8OvdFuGDlEEO4/zHjADC2BczaZhySuOGzUAJKUIYceYCkXJK/FT0FjRm5i?=
 =?us-ascii?Q?BnLD6+2kTRcb8S1J9C8Wpi4TK2/g/to+WUX+T2LjbPvs7ZOA8MbwUeZE0Hx7?=
 =?us-ascii?Q?2aiLOhkGg+GO//97VcbJQNDLLBPOiuHB4Ae5wL1xJ3j5tRVR7DJ5bo+GosUx?=
 =?us-ascii?Q?9kaUzDahHHVHn5vAsI0pOy6E1sHYxqbrAZegQ4JwwcH93ah0nS0dqRnWXqFz?=
 =?us-ascii?Q?xwDTmsBpF6Qfw9IJgKqnky+QZs+xs/lKOfuz6g3CVGeuNZAUnXjOE30VYidr?=
 =?us-ascii?Q?OJTHAW1lNzWWwaNbTQs4t9URAwi1IzZaU/K43HEsaGf7n7T6pxhDDZVmPHZl?=
 =?us-ascii?Q?rXvsmQJAYbt9vq6hBZCrwbcNZejPmKpRSiFJZv5iiV28sqq2HY3/Rs4YAM6C?=
 =?us-ascii?Q?Zl6abyMT0qMQQThytkp1WdaQ/5pAktW9Od/7Npz7iRwRg0+SG8QvbSSwAayK?=
 =?us-ascii?Q?cPYWhKFXhSeruqHuh1aWIAzoTsiMr76xEOQKTxqPnpOx286/p6233P6qboS3?=
 =?us-ascii?Q?hRswVXN68HwfQV3LSLktupi7gN4kNZt0D8VCHeBeHwTkdZUEOlCV93PHVstb?=
 =?us-ascii?Q?AQHM9p7WHlzvyRErhiLoEv565NCsveLNdymdTextRvPPswnQ7zehfU70LbWM?=
 =?us-ascii?Q?yqH6wpA3Zc1+AdAaAIi5yu08onVJxmVK20XqxjsjFqaw9lDZWohuEIal6Rin?=
 =?us-ascii?Q?ZJt5Cq9L/enR5kZLg+QLk8dAms6mQ4S0ePt9SgZvIE4St8QjpBgsMB24jpOr?=
 =?us-ascii?Q?/nbHe6dpmysrUXkpaJSMxpIeWBDwD2w5k4nHbosSE1o3qDaOnGtKE7jBqbU/?=
 =?us-ascii?Q?o5rHkZbHWH6zrY9fHmCL/9zKUoPT8+m9yTEd/ILiI25Eoch3Md+ix5mJ0qR9?=
 =?us-ascii?Q?e9yuaBxVyzWy+zqI308McD8Xy6moRZbPO8fz5GgeeV02Z+e+HCYshPsNR/2Y?=
 =?us-ascii?Q?/0z3/An6od2TvE1sHE/CbVtaRJJrYOGJJR2NRX7Bvxs30tvreXXDpZFXxbPv?=
 =?us-ascii?Q?3+JQDm4cZA0Dd4o2z/wRADUVYS2n0x4J28kxnix5/JKNdYCfWhgQYmZhV3zN?=
 =?us-ascii?Q?X0jqH+oQgzxrAKFnvM4EGJ7O6NNINpQsw1GU8iOlaOxLnHS7ED2ZDh4yO87X?=
 =?us-ascii?Q?IjkT0CR8+qqw4W2xERukeigzoE7uESQ8PxlmhXernkdtvaonAbnN5NNCEDb5?=
 =?us-ascii?Q?BXPCW5oKjzt/4mne8xf1mmTd9uvOIOIc3k/87Fw/p8iprLQVmZuO2D+khQRo?=
 =?us-ascii?Q?Ry4K8L7czI2zRRp8YK1CiJ+g2qPGlUieKoQrlR2MJNjXSwb8GZZ+PQbw2V0p?=
 =?us-ascii?Q?whEqk9Ecf++FIAI9axjHPeCSW1FF6RzKi+s1CHrvVNfGk0BIXqmD36SX3rk8?=
 =?us-ascii?Q?OI3btJb3XvPYfPROVvFxk2MTT5+zrySGq+pmm7qv7PsnB7oV5gH7nt7I4IPW?=
 =?us-ascii?Q?f+B6FtmJbE4y8BwpFbY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a01945-85ec-48f2-c721-08dad979ccf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2022 00:10:37.8701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2LSAOt9xZOluu0ebPoBWTRjclItlVgzt5II4IsnW01P1WpM0WDWsmq1yPv+bHlhN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5287
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, December 8, 2022 1:06 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: handle polaris10/11 overlap asics (v2)
>=20
> Some special polaris 10 chips overlap with the polaris11
> DID range.  Handle this properly in the driver.
>=20
> v2: use local flags for other function calls.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 7383272c6a3a..b4f2d61ea0d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2039,6 +2039,15 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>  			 "See modparam exp_hw_support\n");
>  		return -ENODEV;
>  	}
> +	/* differentiate between P10 and P11 asics with the same DID */
> +	if (pdev->device =3D=3D 0x67FF &&
> +	    (pdev->revision =3D=3D 0xE3 ||
> +	     pdev->revision =3D=3D 0xE7 ||
> +	     pdev->revision =3D=3D 0xF3 ||
> +	     pdev->revision =3D=3D 0xF7)) {
> +		flags &=3D ~AMD_ASIC_MASK;
> +		flags |=3D CHIP_POLARIS10;
> +	}
>=20
>  	/* Due to hardware bugs, S/G Display on raven requires a 1:1
> IOMMU mapping,
>  	 * however, SME requires an indirect IOMMU mapping because the
> encryption
> @@ -2108,12 +2117,12 @@ static int amdgpu_pci_probe(struct pci_dev
> *pdev,
>=20
>  	pci_set_drvdata(pdev, ddev);
>=20
> -	ret =3D amdgpu_driver_load_kms(adev, ent->driver_data);
> +	ret =3D amdgpu_driver_load_kms(adev, flags);
>  	if (ret)
>  		goto err_pci;
>=20
>  retry_init:
> -	ret =3D drm_dev_register(ddev, ent->driver_data);
> +	ret =3D drm_dev_register(ddev, flags);
>  	if (ret =3D=3D -EAGAIN && ++retry <=3D 3) {
>  		DRM_INFO("retry init %d\n", retry);
>  		/* Don't request EX mode too frequently which is attacking
> */
> --
> 2.38.1
