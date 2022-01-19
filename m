Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B570FC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 06:10:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2020B10F01D;
	Wed, 19 Jan 2022 06:10:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C985910F01D
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 06:10:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhDXCU3UCF9CmFpzDQNY+n2HP3Lh+heIo3s8MBjdMqR26wrRdJ7G1Z05Rfav60x6l2N27byHOBnIYacPAtNe7791F/HJxIcP95CWha6e94+D/bqtWyFBuO7TucyhIEAF4vSmaYNxvZahX87pe9fDEodljKQTmafBgfZa30kHWIvDedUB8Fsx8jOvZoZYPeKASjTeUvsxPKHPMC5up3gOiO0y76R3zqSbTWTzxHsI+dJcDpWGTkzz47yAQRyOsVcm6EWgCq/b7rO+9idirPRaskKNIZEkmgk2DyUEjPYHStkxLPPmVc7erFvDsyitERgaOQah2PVUhj747DsX/ziJsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaovegPz0zyc1QlDaXtRumSByJDKeLmFAZmv9TmP9bY=;
 b=dViNbQwa7yqvbTrtD6ivbBUUBMupEaY5wrd7tr0pBzfeQaDVbFDoRuTj125JOKLDDXeX8N65rRBdmTzyUfiaf28riRM9/yr5VdTUTqDEabS5N6wkAMRCZbkFMRs3eRJMGQ43JfdlJPJ8JDnHDqny+xAARL0cua7q30Z/RHYaYqWNd1NyoJwM60e9WPX6Z95fm+7MkE4G3ytWsphqb/NEX6zIT7RS8YwugWhcVwozbhG3k9CJGec2dwbq6sh/4PRHAG7wm1CAcgrbGKTA2iJnx3hQblJd5OtZZRvjzm0SuKKfGz6Msp6jZO3OcXb+ZvcqFb5xmHMQZRBQjor4w4E1oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaovegPz0zyc1QlDaXtRumSByJDKeLmFAZmv9TmP9bY=;
 b=IdY2U1WMfO7K41AYIB5aQJpcNQTkXQD2EmwcKf9u6v41PqSVaoTRcogCYkvllotCKPk1kC0qIxNK/vALvVRfNedf+fsHtQEe+VoXTFpi86cj7apuBldL/MDBaKZSeypCrItsljGKnKDZ/PHJlQPkU9WTBLYJSxaRSiMTzttTxjg=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DM6PR12MB2745.namprd12.prod.outlook.com (2603:10b6:5:45::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 19 Jan
 2022 06:10:35 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934%11]) with mapi id 15.20.4888.014; Wed, 19 Jan
 2022 06:10:35 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu: Move xgmi ras initialization from
 .late_init to .early_init
Thread-Topic: [PATCH 2/3] drm/amdgpu: Move xgmi ras initialization from
 .late_init to .early_init
Thread-Index: AQHYDOA4At8LeRvUuEayeZiHFLrpCqxp2dGQ
Date: Wed, 19 Jan 2022 06:10:35 +0000
Message-ID: <DM5PR12MB17708F8E65D9C3C669B73F4EB0599@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220119025555.197467-1-YiPeng.Chai@amd.com>
 <20220119025555.197467-2-YiPeng.Chai@amd.com>
In-Reply-To: <20220119025555.197467-2-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-19T06:00:02Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=fb83effd-d409-48ef-865e-4c8645f27631;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-19T06:10:31Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 36e88bea-4252-4e2c-b7db-985f12f7b261
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e56f0a2a-2d54-4aa7-e1e7-08d9db126835
x-ms-traffictypediagnostic: DM6PR12MB2745:EE_
x-microsoft-antispam-prvs: <DM6PR12MB2745A59942747D1B9CA46A8EB0599@DM6PR12MB2745.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FoGNugm2vt8LKx4XKkqtH4BOCH5Uov7NT4XyLg4q1+D2RjTSFvUYiuId1DQErVwyu52gObrysU4chfIoLRsIndTvfeSZ9WUOJW1+Ahnl6dyfMS35zLJ0sylxAeQA4rxoWBUg2j66kItRUqNvnsKjhZw1PMlUN3x+rwuscxzD7mbT8pYhAsZKwIUCaYQ7N7qWahAjxpsNO8uBAyiGiRnwCdqFF2NHtG3TWYf4LWNSVHT8rh+s2jegjVnBBWscSJuW/IfAfc/exDVnqX4uHNkwibuBPc9ZVnC8AbOkY4x6OT9gajDgDuxn0LBuMDrqOLViYAXMXHbF2PJXqL5XsiRu5AAVP9IQ3fmeAafOYm1Y5mi2DFZ/w84MK4J23GHoIrLmPM0utPBVcgPJ+p127B5fzw6aoBiK38nuhcVm22GQG+qpNmOgO3tckoUqeoGUv7X33iE4E+G3l9rttWfGldOcTkqDMO5Bw/XYaRnpXmLLOeOWp6c0HddzqwENTTYca6/6ULJh6zTsCKOvTrqdX9ejHUAtUzOtc5i9xDnghJOx9fdTm7SczhwcyIQ3mvgAs0xZm/V8B7o3YVIB6MN9SLXyIKzeunBHCt0s4y5iF8AzneoGj+sAi3VK92REBjFNwjQ3jOSZEMQo8DyaG/B8M9NNCFJgMECOgYm2Wsg/f2Vi7egZrL8yQZe8bqaD9l1lhgi6YTjshhvYA/LS0+dwdpduskLcmwGkhmxydRE+2Sjv+B4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(122000001)(5660300002)(38100700002)(52536014)(26005)(55016003)(33656002)(6506007)(53546011)(186003)(86362001)(4326008)(66946007)(83380400001)(110136005)(9686003)(316002)(7696005)(508600001)(2906002)(38070700005)(8936002)(66556008)(66476007)(66446008)(64756008)(71200400001)(76116006)(8676002)(142923001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pDdd/IjNrMSnTH9Rcj8ZbFcrjHnqzlD/xlhPfT+SlCSXGMcdW7/xgHEXrPsS?=
 =?us-ascii?Q?jg8BTDZ2M3wVO4kA4iQx6Fc8EaBMrBOsSt/og01RO3mgggieuxq6stMLSy3l?=
 =?us-ascii?Q?CiEj6XzFauoml6zITt4tfHjMSTMEzBCggwILQoBs1IC7dZ69zMRBfdZvR0Do?=
 =?us-ascii?Q?wUxMGWjaNKuYwmraJcHn/byBobpnCce5mSCRmkTpFgzMr/PtDDbazaB22uLB?=
 =?us-ascii?Q?tWwRLVEAfQLu2PdH86eu6d580LCttbgi0TOJyFnFHrHCrtdb3TPw8EWlboDJ?=
 =?us-ascii?Q?n1fyrknMAE2tj6d2CqIdJTBpJC0e1ttleKonyQ3QzpK+1cwbmcE93oTChYXQ?=
 =?us-ascii?Q?ooGMme7Uo6rg+3lIYTWI6n6bP8mP8cEdRlMZ6HtRqJbXW/6G/24AfZK364l/?=
 =?us-ascii?Q?ci2U/eBFVIU4Fch4n1pbInULQzyoUYCAk0J37pLihdeUtrp3mVLOjbNI/ws8?=
 =?us-ascii?Q?D8z2sUciJz/dZ6r257hIuPBtiGMx0+yDQmh7RyPJcas6ykDbUR7ofPYKGBTC?=
 =?us-ascii?Q?fOBehlwcY7fwIzcS0qUd1Dkp09/yCbzHNtXF3Kdhndut6IhNJpjUo8R8MnZu?=
 =?us-ascii?Q?GQl/mtZ8VojY/gg8d1dlEMBexqPfaPbDLefk117jlmPcwhm3gq5+YydRRCzA?=
 =?us-ascii?Q?1tmRyxjUjobkfUCErzFTWH2+As/nzDB0ZlnDBBm+5IDZOhuK2N8ZsUyZquME?=
 =?us-ascii?Q?63s0G8DM75D/1VTvnCTsABdFLowRjpMDy1ZckrOWoZD7DQ2u/howcS93dLsX?=
 =?us-ascii?Q?tc03xPb3D+zqCgo6LJ84c4eifm3j18TZgqDCVEUBFErez2na5PcPJQFrATfa?=
 =?us-ascii?Q?BisiGaQfGk9w2Z2DtXBydBQhbP7XB7ImRBDSqvTumTRElcNSHOrylIG33Cts?=
 =?us-ascii?Q?sKUllp4iKRjEPsQtzuWu8OKvPGiV6IgDNwJ/NiTJy31P1OQaRmKVlEdXtJWV?=
 =?us-ascii?Q?a6Zi1QVekBo9p55kQ7B3XJ3yf4gefIUh1V6qRoMFM9cq4iV/tQxRfCBqksKo?=
 =?us-ascii?Q?wpEC2XM+D38uF3iFAbhWEK4Ws/UzSFZiMIrOm7OoDEUyiRkTwdjuS/PTKTaJ?=
 =?us-ascii?Q?tUI/L8asVizr15emv3rgNt1IG/I7s7Bb7oj/EZqxTX52I62h2mv/hWEqDcf3?=
 =?us-ascii?Q?yBDAvEq3jqx84AKIoIh9JRlQh7ffAc2a91Ku3r4EHtfJXhoNlwFKpgUDHMvI?=
 =?us-ascii?Q?KSGiFo3qUhkfhN/kQ1UE+fVMeJjsHtDoUO21Tb8Xc7AyC0WDyR09y9AWB0xl?=
 =?us-ascii?Q?iGu0lrIkhbrdTOGX2Pzz3JaRDOs0GzLXif4DsXyYDhwAvKN0r+SZg8vviYlt?=
 =?us-ascii?Q?xBltOxv2EWDtTLe4Qec3T31gSKB9779acXPHkmqz4oc0u3y9w+oV0dRiskfL?=
 =?us-ascii?Q?JXKDZzW8fakE/dOkAqOylju5+d9FmUooU9pekUOB8T2ACIRKf5ZP2E/1Xa7d?=
 =?us-ascii?Q?jvZaG4fJmB82Mx4KaEo+czI/Va3aQjzhQhlgo8e8flGhJZnlFvjBagmVlsSX?=
 =?us-ascii?Q?2ExsJtiVrPZ3LUc//vIhUnUFs7u14FFINQIJR5xPcBo8na0ImenHhACd3KBS?=
 =?us-ascii?Q?aEEVGBmDANnmVJpvIK4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56f0a2a-2d54-4aa7-e1e7-08d9db126835
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 06:10:35.2641 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rzXVpav0ix/c33aqHahIhW3OPToXaxTmzTy0YB/q/h/LtjnHtjRCr8kahoa5ihQ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2745
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



> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, January 19, 2022 10:56 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 2/3] drm/amdgpu: Move xgmi ras initialization from .late_=
init
> to .early_init
>=20
> Move xgmi ras initialization from .late_init to .early_init, which let xg=
mi ras be
> initialized only once.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 5 -----
> drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 1 -
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 9 +++++++++
>  3 files changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 3483a82f5734..d83eee1984c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -452,11 +452,6 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 4f8d356f8432..5f9f82091000 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -716,7 +716,6 @@ static void gmc_v10_0_set_gfxhub_funcs(struct
> amdgpu_device *adev)
>  	}
>  }
>=20
> -
[Tao]: Please don't introduce irrelevant change.

>  static int gmc_v10_0_early_init(void *handle)  {
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle; diff --g=
it
> a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index c76ffd1a70cd..8d1b11368a7b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1303,6 +1303,14 @@ static void gmc_v9_0_set_hdp_ras_funcs(struct
> amdgpu_device *adev)
>  	amdgpu_ras_register_ras_block(adev, &adev->hdp.ras->ras_block);  }
>=20
> +static void gmc_v9_0_set_xgmi_ras_funcs(struct amdgpu_device *adev) {
> +	if (!adev->gmc.xgmi.connected_to_cpu) {
> +		adev->gmc.xgmi.ras =3D &xgmi_ras;
> +		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras-
> >ras_block);
> +	}
> +}
[Tao]: Since the initialization of xgmi.ras is common for all versions of I=
P, I recommend to create a generic ras_early_init func for it.
BTW, I think we can remove the check for block_obj's existence in register_=
ras_block now.

> +
>  static void gmc_v9_0_set_mca_funcs(struct amdgpu_device *adev)  {
>  	/* is UMC the right IP to check for MCA?  Maybe DF? */ @@ -1339,6
> +1347,7 @@ static int gmc_v9_0_early_init(void *handle)
>  	gmc_v9_0_set_gfxhub_funcs(adev);
>  	gmc_v9_0_set_hdp_ras_funcs(adev);
>  	gmc_v9_0_set_mca_funcs(adev);
> +	gmc_v9_0_set_xgmi_ras_funcs(adev);
>=20
>  	adev->gmc.shared_aperture_start =3D 0x2000000000000000ULL;
>  	adev->gmc.shared_aperture_end =3D
> --
> 2.25.1
