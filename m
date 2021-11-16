Return-Path: <SRS0=wnxc=QD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3232BC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 02:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E07FF61BB3
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 02:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E07FF61BB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A55E16E1BB;
	Tue, 16 Nov 2021 02:36:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E1F46E1BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Nov 2021 02:36:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyiftXJBKTr4GGp+/H9jugURlFX2a9KBFWNZEGytO4T3EXwCsm/y0DlOLW0/jQ1bmsM2vo71bshyEAcTA91bV4KMtvtCAZRjgfKPRR7KpCMzuQOCSo8Ozzq/8pMCuVSeGQNF+PvSraFo8evOfBKschLfO7IF7YBZsPUMJ1txYJ/T06MdimyUPAiK2Xmj+1TLTUfrFXazSX8WnTpjuzpJyDjhonQ8KMMOd58HizmYLB3CFNkssV0Pp4YBeI/G+BFWD6nGxtrsghFivN7zpP5zrTxRpo+4ulLEUjoIldybCI9D4uf4wW+f2QgSiI4YQ3Hp8gvpkh4CcFdDI2RHHFYszw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XskCLB7ISO076V02V9wkFlveDJTDch7CGxz31vruhI=;
 b=mHqPvbYggoApcUR2Dwn4XlVTPyS0ORp4Asgn/eHClb/qQWROYCcoMcCY/enuFS08FDF+9fN+sIpcMdVnLCbP0UiHX852FT79yunB6p0+P0fEsF2yFkCTMOAKuX+cMqR21UxlOe8XRiLYIMgnLHs/UCMaDm9KknmX/BcL21nT6uGrKHch7gufdWAzEtSahqtXAA6SFeK5sv4NNjjI1oFc36bPlN5C0vLbDLM+ym4kJgDeFEiyyrye3JtqO7HUQgdhpNJBdQ0El+eH1xjadHAweWb+qb3znj/aVtk4SncvVvLDipQBJQ7+nCul1CceutO4vsNVc3FYWd2pHMYXplCp1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XskCLB7ISO076V02V9wkFlveDJTDch7CGxz31vruhI=;
 b=ga7K9uR3DIizHriL9v0tkSsDcwA4qlm46RuWl5poqTrOwi9LrOZ1/TVwY+b+lI9ThucJpduMB1TXBZz4WkYHuSzzDXA1oagnWObJX2rGz3KU0E27PdhUmrTlhJwxLRq4N2W7i7piqkvjbKgAHCtCVihhsZQDIV8nBAonzfSyK9I=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4958.namprd12.prod.outlook.com (2603:10b6:5:20a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.20; Tue, 16 Nov 2021 02:36:25 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 02:36:18 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: always reset the asic in suspend (v2)
Thread-Topic: [PATCH] drm/amdgpu: always reset the asic in suspend (v2)
Thread-Index: AQHX1+H2KU7aSPg0SEiO5/fYMeEwSawFdWpw
Date: Tue, 16 Nov 2021 02:36:17 +0000
Message-ID: <DM6PR12MB26195F8E099407B4B6966FEBE4999@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211112162530.149709-1-alexander.deucher@amd.com>
In-Reply-To: <20211112162530.149709-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-16T02:36:15Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=6a5804fe-480e-497a-8311-1f3134e0e3ff;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4803ebfe-f1d3-4db4-a3c2-08d9a8a9de33
x-ms-traffictypediagnostic: DM6PR12MB4958:
x-microsoft-antispam-prvs: <DM6PR12MB4958B1A8C404AC12C2425388E4999@DM6PR12MB4958.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 48ph20eQkX/HqdwEb/4nJ0URH5dTwy+W95UzryggOkl2DAqcmBDV3WdblETeRYiwD15OZ9S+Lv1TmDoZZFOTOMJOs3zxa7YpFDa7+fXwgPma44BQotLVY4YzEMD9/Ztd3JuArwd3KukfIFh661dP0NRmeMYtOASHHJgSHT4IfH6Zy+2AuTrCZ/Gf9WTzuIJuewlDa4mFmc11SXgYobSCFZN94QvnktgEImvpCoTYPaSvkwC1cUnTfwwN/FLDypZtMmkycN4/KFPOVLT7zadcFfS8rQzXV+O9hsIaNHAu0rTmWUBnZ3QXhH20t2TxabZnIVhro+b7NtBXt8xP5RDsM5OLNMC8wR8mFPn4rlrNvzmUn77FR3WPbSZNRrW3UcO6NvgifW8D3U78FMCUbLhNM/FlMXzUdI2asMPdjUZjgySaks39aqMG3dUvl0fitUT323EY3yTvclxx+oKXnrkjpJ+sqNU0vOoOZS1zNvJeyDc4WmHLum4MmKRIiahUBrRpUzUeNtEAGFbzORtsiH1bxZu+Y8Omf8Tj0TMeYaPcIeM9EM+6dlFqNXaWHwdQNOD6uT+Ygd8McbjcAX/9acb+4/c7HAB7PWuZ3u0F2IH8sd1piZF7f6TWevEEO9CZn/kLI4NsWs9PTAvt8wpLlKxCqJt0IhzHaYQEztvqz4q/ezSbSdM/szFxVAxj/H9o9KTJMum3ZE63qg5ceuBSsiFoaQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(38070700005)(5660300002)(55016002)(110136005)(316002)(71200400001)(122000001)(9686003)(66946007)(86362001)(66556008)(76116006)(38100700002)(66476007)(64756008)(66446008)(15650500001)(52536014)(33656002)(26005)(4326008)(83380400001)(7696005)(8936002)(6506007)(508600001)(8676002)(186003)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DYi2Kkt9nfG4ITsJf3A76BBKE0ztZyNWcJHCMTETNjC72/wA5mPqTtTsGuje?=
 =?us-ascii?Q?ckKZFq6E63OJ0zo1voqRDJDGTmIL4gaaaHul+6QJaAUzEBWNWKbdTF1LR2F1?=
 =?us-ascii?Q?abozKcEwq19Uoxr6Kxm12BtjuQ2QwpquGUpzoOh0brHCROspVVThVrfKgZy+?=
 =?us-ascii?Q?Awp4X9qTA+v9LnPVnh6lpnXRnWLfHf9vP32Uagv87UYO3BK/zaLsNoqHNnnf?=
 =?us-ascii?Q?vkJFB/SfC4AWxtPbb1hl6zyCBmpLqV+05c2PQqozauOkZVgQxchdm8LM3AAb?=
 =?us-ascii?Q?Vbjp7S0xLsh6WlboRnN9jMAxfdV34lgs7NKPrI9k6XRc4BXTWTW8XY40tOJM?=
 =?us-ascii?Q?Co3g2LKqH/bmw1LXLElIM/b7vvfnGqqINqL+878ZxGDBF8NWD9fS30ZTXKym?=
 =?us-ascii?Q?UiqpYBbwCUayu/dGBFsGdO4sf9aPmIXDHTLqIwcbtUD0GK7++6ZlG5A+P8uP?=
 =?us-ascii?Q?4aJfYwnwdeY726hJtpSO0gqRnLYidsXyRWGzjPjcPLcz4CKy1/TW5ITNMHOO?=
 =?us-ascii?Q?gQTiy9r70IENVv5Q/Pgg3jra6g/PfCnsmHYu7GAxNuIfx9IIejAlXUq2meus?=
 =?us-ascii?Q?vZZoPEFb+8+1A6BMfAMGo7TUB3r4XmgEANd9E6EUtT7syI2Ini/CKotzfZrN?=
 =?us-ascii?Q?1BAJoX3ULMhPkI9xk7BEvCFoMB+ItrfB9wcv9QI7PZNxLLYEozA1SbI35LgV?=
 =?us-ascii?Q?flv+wT1eMukFyMvWX4JSC5UsnIYNFZGl5afFAjpYLTfCW4I8uZX7D3slN489?=
 =?us-ascii?Q?i7zHfPuUSVleO+WCg5J479xY5Am8rG7ut41M57KEHddxOtuuWODBVvAa3mz/?=
 =?us-ascii?Q?Kwwhi6vjdCGZcJYOh7wUN41EEX94tCibEJdZD1JCN00WdLXilx754M4VBdFd?=
 =?us-ascii?Q?1sSK+vb3sJHfBRf/alRvgRvmAnxsbeQhlLaLm+0ohcTDBMTlLtiaxLIHtBvH?=
 =?us-ascii?Q?ZxKBbZ62ZpwhHo6eaywc0pTInvYi1VbX62s5Y6wSoPHlcSg+7fBGHHtKgtxo?=
 =?us-ascii?Q?ciY1X5oLts/9LT98P/oBBByl+3nnxxGmxKkhOB/6wBsoQ8jK6b0NWMnksa+T?=
 =?us-ascii?Q?Buzp0O1gxuOQHrQnAujqtEqaehkD3nWv/SrHAVkn5sFo7Lum6yJiRkdYFS4t?=
 =?us-ascii?Q?yaRATy7O9lHR1Zd7xmCbka3KeTnsw9R25GtYSpN815n6OLsYWFKschirk5Il?=
 =?us-ascii?Q?ozrXi+xXTfr/Puyod82v2tGUiYyaj6+cARIAlzyWyQGYg9Zv7OOhACZnPVKz?=
 =?us-ascii?Q?2drilJa1dTOAeqYHf7Zc3uyxVNNRg5/Ou6eo8TKUFfhQim9xojroCo8m7nxr?=
 =?us-ascii?Q?XyO8RDjb0upFFnmj/CaZg27nRQnruvA5T4TJhWxww+hHSPPppI1/l25Vpjk/?=
 =?us-ascii?Q?h4cl1ZoWNKcbrKhHnmCHWO0zPJaUOcdrEYkqh9I0cwyW5TCaGLwtljIlMdCI?=
 =?us-ascii?Q?72TmJngbZb+z9vby+v+wbWi2j4N7VHDA1Hk5A7lXafrv60Uyl9v5zEjESdHG?=
 =?us-ascii?Q?tWNzq3PkbkI23W0H4lv4OTWK+/bVroBB4AracxXE8vBiRJ5r/U1iUpgmeiCQ?=
 =?us-ascii?Q?Grsug0gHKCMLCPXsD7k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4803ebfe-f1d3-4db4-a3c2-08d9a8a9de33
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 02:36:17.8942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ZpScJ2+uySWmxzfcIr6Q/R6oKglshsrOxz7sqvOwSLmoZ20UpzkTGDUQLl25KW+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4958
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

[AMD Official Use Only]

Acked-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Saturday, November 13, 2021 12:26 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: always reset the asic in suspend (v2)
>=20
> If the platform suspend happens to fail and the power rail
> is not turned off, the GPU will be in an unknown state on
> resume, so reset the asic so that it will be in a known
> good state on resume even if the platform suspend failed.
>=20
> v2: handle s0ix
>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 1db76429a673..b4591f6e82dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2165,7 +2165,10 @@ static int amdgpu_pmops_suspend(struct device
> *dev)
>  	adev->in_s3 =3D true;
>  	r =3D amdgpu_device_suspend(drm_dev, true);
>  	adev->in_s3 =3D false;
> -
> +	if (r)
> +		return r;
> +	if (!adev->in_s0ix)
> +		r =3D amdgpu_asic_reset(adev);
>  	return r;
>  }
>=20
> --
> 2.31.1
