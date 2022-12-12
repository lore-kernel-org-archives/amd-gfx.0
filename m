Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AACC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Dec 2022 17:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0CE610E238;
	Mon, 12 Dec 2022 17:46:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB67610E238
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Dec 2022 17:46:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIgSSLI2MnHSyHbLgaYg0Et35sV4svWvt/QmGVeQO2kd453LCTHrxVvBklkuaqML9BatCONQWe/Rse4wowpTEbyCjEoGnxft1LyNWco3xwv4c3hDCMQ0pcDjD7U7HS9zuDtdkdxlrmi7Rqn+kpgmO2uYSyx+4kBktpE91p0aR0Vx3JsOBRGmPAom/0+tfh96IL+qWK/F6yKxHIN05cMkiEd1npFH/J4tyAMKyOFMdEmZDdmrjKXPOGm0zMvLz+PRqwyzoAVeE4bltQ/wcfK/iazyy3bI7p1hn7bP0fBPKHwMftGR4+ECsdulCn3mmGhP9r1WJQe8u+l6y/StbtKb3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oQ8ePJ6Ya4PYCUJk5DqcvL5ZNuDeHHNOspBffzNLjE=;
 b=ge/VNVGIebgulBc6fhJsniCAqR5ePX4RREoir+6rhUx5isBld0p2tLatoHGZJwVT2lYEYyjr5HxS3/a9gjz0Is9ChIDW8OkrFKdvzxx2bGSfIDwb8F89dtl3P9lm+FsC2U7xkYqBE3OTm23awemQsw1cdJ2ostAMgGL8k8MTsbarks27XxuYdVy5bp1PWU85h1fE4d0ePY94Sd9ollBvMRwSCx5XVuY9YiXYFDCNTDRaopHF2k0hEFV3c9p6yFhkJ7oPmVAPG2MDd5yqIvQSQk58E4mVLkXcj5mBWuw6Onj4723TMp+KPxbnDII6UHcPiVdV4oFw2J5hSLQZXf3V3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oQ8ePJ6Ya4PYCUJk5DqcvL5ZNuDeHHNOspBffzNLjE=;
 b=NHlYI2jdp4cDBm5NopssqgDVhrXsEToEhmrfbxX5hrEvXbydHkZZKA1ZeOJIGuLiFI6goLVqemlf2/nGB2gDKSn093HYpoj9rfLzgQP5W6vc/aldmuFK50V7pvgVjgPln9C8t7LWQATBoBKjSEXrH514Eh2IzLxD+E7cEJI67gY=
Received: from DM5PR12MB1308.namprd12.prod.outlook.com (2603:10b6:3:76::7) by
 LV2PR12MB5727.namprd12.prod.outlook.com (2603:10b6:408:17d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.19; Mon, 12 Dec 2022 17:46:31 +0000
Received: from DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::7dae:c7a5:62f1:6d43]) by DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::7dae:c7a5:62f1:6d43%10]) with mapi id 15.20.5880.019; Mon, 12 Dec
 2022 17:46:31 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, AMD Graphics
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Check if fru_addr is not NULL (v2)
Thread-Topic: [PATCH] drm/amdgpu: Check if fru_addr is not NULL (v2)
Thread-Index: AQHZDk2tw6nAtT3wWUi/AndRnu7ysq5qhq3Q
Date: Mon, 12 Dec 2022 17:46:31 +0000
Message-ID: <DM5PR12MB1308AD73F5504A18011A9A7B85E29@DM5PR12MB1308.namprd12.prod.outlook.com>
References: <20221212171133.33982-1-luben.tuikov@amd.com>
 <20221212171733.34622-1-luben.tuikov@amd.com>
In-Reply-To: <20221212171733.34622-1-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-12T17:46:29Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a6d5f3a5-8269-4d94-9994-3d15f13eaf20;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1308:EE_|LV2PR12MB5727:EE_
x-ms-office365-filtering-correlation-id: 4104ce58-35da-4b17-c070-08dadc68cd9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1RCk3iKoA02IiFYwcS+vjMKOmhpk6lULRnbuquYojOpwUG95h84XAJWdtqbqSzuu9qUfwE4UH4FftWuG1GmAD3oGqIR9bQnY4H95lM5w+QzGkd+ThnnuI/ssiCOOLYipZrkBxv0H6jm6wuHK3jBOE15SxXrZJC2K92rCBCyvE6/Akt5ETSFEmINhRjowvW/+NCHdDc26WGGqHV70hBBDOVAJTLSlCfxco3YAY9Qqd78cwyBDh55AxIiLgGSebLedjSwndAdplI+Rb/cJYUxCXm6E3c9CzqTxyIrPm9vuDpPqAqMkltwLV+w55BUX4Zlov22gmXHmW/gnQYwQMLSLHrR3PvfSSX0KimE+bJDeKQFv0EoV4dINmRHogXwWoZuDs8v2tDeR65tJEGww5vqelbei+Vo4d/Q7SefgSQVx0l3FdhuAzrbhbyeMASaN5ieBEMLVhPs+2c8w+T9pBSF1KNeN7dQeiWUuzjt2gDJR5rNq8mE40lPvZJ6uULmq1ZOk8ryudTQ6++edHcCKa5vCh8/VQdfOljnRM2+2PGfs6hFE7vfL+U9NCtZLCt5vJOcdL4CFPa8MsO2Xu/oOO66m46Hr+RqQa+Q60Dd64FOnuqndGSIf/T5BwXd6wXkDM/dRad+ksYMewsGHfPmFmsFS7TIC731BluV+LMW7pqz0Bm8id1spFR4Qkh0O1Cq5MyUYYuhOS05iXUOOdMnbGdDAag==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(451199015)(122000001)(26005)(478600001)(9686003)(186003)(6506007)(53546011)(7696005)(71200400001)(83380400001)(38100700002)(66476007)(66446008)(64756008)(55016003)(66556008)(8676002)(54906003)(110136005)(41300700001)(76116006)(4326008)(52536014)(316002)(2906002)(5660300002)(66946007)(8936002)(86362001)(38070700005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MbMiOj98o2XXgHEClWH8xKDxh+VRnBthQjajCFuHdmDOeZCKt668LT6tPV6q?=
 =?us-ascii?Q?DiOdG8tFydmEB3eyeN0xU4U7moG7VLJvmGVTX3C5aQqWuTHisug5HTyhEjiS?=
 =?us-ascii?Q?9HWYGyVgJF0mmZmqhpBuM5Po0zBvnE3mSCfkLYfR9jS+GRjnt951sFJdIxah?=
 =?us-ascii?Q?Y2wOguQKVzqtdZp0mj0fvsjvQT1OMFuHLvPVoV7IR2JiaJzlwvtupdBnxfmW?=
 =?us-ascii?Q?YKdLVxmdeQ4R/N28l8nC5hKdWY2NhpK8bArnmJ8KrKSL0DFmKdXMuA22HtnH?=
 =?us-ascii?Q?zKeJqhpCH5R88WU/4y73fOv5Rv+cH5l1QvOiCPe9TP3d863ElJO1i1h70WHB?=
 =?us-ascii?Q?CGLdRlAAso/NgG/M+2miRZKJU3lgY/j+JZIpTAlSjnUFHoX4VVdv2Pw5hHMV?=
 =?us-ascii?Q?KGOFvaczCdkL66Z9j8FXOWsYyg1bCIYnmg88rXknDu9GSgQpJ+XadpSDfEwi?=
 =?us-ascii?Q?cPvuhTQZgCMNEPSEGsPirNljbN0wA/vZs44vc9DmEGKw6RJzIbzXG+xtRpCM?=
 =?us-ascii?Q?Fg2+byrn9v2arohHkSS2NpVKtBCe8yQ0PWVwvC260vzI2egdWNiANV584j+t?=
 =?us-ascii?Q?BViHtR3iQ339rCJLjw3z469J5RizLhyAk5T8+4SXl5/5EM02SptQY/lE/VsV?=
 =?us-ascii?Q?CtdE0H43LEoqnwCKKBaHEyjKIRxakdmmgjahXstbFDaYhFqbdc7YwEjjWugj?=
 =?us-ascii?Q?djxJpeetJulcUdSvHCj+P3EjhhYHjRZybFJ5eSNKMLW/DiBmco83BTyo09TF?=
 =?us-ascii?Q?7d9zWvzOdSqsrwBp9vU2xwhZ3beyq4VZPI1SBqga9kJwMXnE1TcwVD++8DVS?=
 =?us-ascii?Q?WTh5iIetvY8m+lJkVHaP1a+MmcpwvmWNSJVP/CAS8JvGki2VzGCh4wrIUN1L?=
 =?us-ascii?Q?d7lkNWgxwM7BGOw5XXaPvHzpSSXq2wUslAK+t8tNxgO5420DeWLhHVZwEhRs?=
 =?us-ascii?Q?hE7fu2gB3PdVius8C5o1TCUa6ssC5FaQgIKNiE9ZWyIzqmndJHwWWIfEgDS3?=
 =?us-ascii?Q?tHTL/P6tHnZaJq5nkcahoBop36v8YQbzdYvTRgkkvsqp55/FqWl4SmWOKvBk?=
 =?us-ascii?Q?J4ANyV3VXCiIINYDh1LNgqoouCrRDeVuup1FGy6OrRkc7ozmXD6E5tluYUxs?=
 =?us-ascii?Q?NlKrFquiaUN2IHHhk3Xr/jc4fYuP3yO72Jd+Ueb0HwWH9JptqBIM3h8mImOX?=
 =?us-ascii?Q?P3SG/FRbndViQxFGfPOg9TIxA06WduoZuBgxqhVf40VMCNWlbzl+tfZ92ZdX?=
 =?us-ascii?Q?FESUL8+bDg4g8JpeqvqX/ZPB72VTsFH0PjRbvzEXHR7VJws1uxqvSf1nfA9J?=
 =?us-ascii?Q?nMhovwN9QdRhUe4a+bOQ82/4H75iTqGkQsdvFcpjI8xPD0qmrpNlAF56nXf1?=
 =?us-ascii?Q?pzIMle8jwexxSyS8+MGIsyGzT4ncwU8xdBAYP5H0/ugTUUcdN4YF8TJyn3gO?=
 =?us-ascii?Q?+nWVYh29Xb8gBGfsXEib99cgpNKVJaErIEEJjHww8d4T6o35HRhZ0oa0PpeN?=
 =?us-ascii?Q?akGnzkJSqgIBs3yQrwDq3FamxM5Emk/7bvgWrTg1F5Kpg0z4VI55NLXDB4pK?=
 =?us-ascii?Q?X0/HiqTjhR6gMSgQgMY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4104ce58-35da-4b17-c070-08dadc68cd9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 17:46:31.0320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cK5zVvNsIBpmVp+FbGxcsS3XghHSd4TtvTJXqrKUDdnL70CYr+5a76Xm4OPfbPQ0uhSy2GN0AgqtXKCKp9lD8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5727
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, Dan Carpenter <error27@gmail.com>,
 kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Luben
> Tuikov
> Sent: Monday, December 12, 2022 12:18 PM
> To: AMD Graphics <amd-gfx@lists.freedesktop.org>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Tuikov, Luben
> <Luben.Tuikov@amd.com>; Dan Carpenter <error27@gmail.com>; kernel test
> robot <lkp@intel.com>
> Subject: [PATCH] drm/amdgpu: Check if fru_addr is not NULL (v2)
>=20
> Always check if fru_addr is not NULL. This commit also fixes a "smatch"
> warning.
>=20
> v2: Add a Fixes tag.
>=20
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Dan Carpenter <error27@gmail.com>
> Cc: kernel test robot <lkp@intel.com>
> Cc: AMD Graphics <amd-gfx@lists.freedesktop.org>
> Fixes: afbe5d1e4bd7c7 ("drm/amdgpu: Bug-fix: Reading I2C FRU data on newe=
r
> ASICs")
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> index 2c38ac7bc643d5..4620c4712ce32a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> @@ -64,7 +64,8 @@ static bool is_fru_eeprom_supported(struct
> amdgpu_device *adev, u32 *fru_addr)
>  			    sizeof(atom_ctx->vbios_version)) ||
>  		    strnstr(atom_ctx->vbios_version, "D163",
>  			    sizeof(atom_ctx->vbios_version))) {
> -			*fru_addr =3D FRU_EEPROM_MADDR_6;
> +			if (fru_addr)
> +				*fru_addr =3D FRU_EEPROM_MADDR_6;
>  			return true;
>  		} else {
>  			return false;
> @@ -83,7 +84,8 @@ static bool is_fru_eeprom_supported(struct
> amdgpu_device *adev, u32 *fru_addr)
>  				    sizeof(atom_ctx->vbios_version))) {
>  				return false;
>  			} else {
> -				*fru_addr =3D FRU_EEPROM_MADDR_6;
> +				if (fru_addr)
> +					*fru_addr =3D FRU_EEPROM_MADDR_6;
>  				return true;
>  			}
>  		} else {
>=20
> base-commit: 20e03e7f6e8efd42168db6d3fe044b804e0ede8f
> --
> 2.39.0.rc2
