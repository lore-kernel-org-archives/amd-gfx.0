Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CAE8C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Nov 2022 15:24:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BA9210E486;
	Tue,  8 Nov 2022 15:24:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DDA810E483
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Nov 2022 15:24:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GP3H7GmV6CMOUVW5dH/CD5iLKM7kcNXki/YBd5fSC1Zqy7+0NfWMb75ZO46nm7i9DMSjNSKDIZc/HPWS6sN+ZAhuG0f8jRSooot9CJ5HBTiGIG/ri2+A6s9rsPYlWMDO5uBNibsJeOt66oeHpTBpDdeghjK7vkCjhrur0zrPUt35J3HUkaNst3gKN34Sx5rYo2v+fMASc6lSLhEosFzGmiKJKE+oItXGEw6lG4Dwgz4bsASkTPv740zENLxfG1QE9ejxTx9mmlSK4XIDfrfcwn3FHZcZdcQZYUH4IeLNyCVdUccPJcPMWN2Z/PgoV9VIK1fkUto9GFlLlyhSDjhI6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbM1P3b8rgRwKQA6Jr91azVH3I0hMvbEYCHGRvWUIUc=;
 b=WXZKZK3cstBhRTmUeQ39ZqDpv5LdVArb5F4v2pK2ucd4tK0He84ryQ6xkKQJqDhC3YtDsXGpRo5vndQVaK9qhyHe+AkdegSsnOpYuOTf9Rq35H1u54KIJKSVXkFT/WGaXSWAhWY1L97kdsEu9MhdkSbwlk9WzI54ttylTcDRXqzdPa28QZ3DY+RSEnph0NpXaexs0+L9eSAUkckOVOv5cRG4zkYsz1MZUwiMK5ZR/rRF5RFCumfn4/Y/nIkdTmmaD0LAChTxSrx/DI2VbeFf+lvyz15tPKuq2V60LxZC/qUJ5EfBBu0hGbeFhpV9kxS3T4c3T5A0fGTxmLQkNQFBkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbM1P3b8rgRwKQA6Jr91azVH3I0hMvbEYCHGRvWUIUc=;
 b=jxHXrku0t4lQdFuUatO4oc4jiF34nuWbJtpqRrX/HycdSg4oSvDMkANK5yPyna0PMsP1QVHu3PgFczyzFitPUPPztWzia54PflW3WwSBSQHB144m/oP2j46Z2+BENMut1aQUBCNp6qAze+EpN8rIPbpGb+V00+5reXQAIkJI9H8=
Received: from DM5PR12MB1308.namprd12.prod.outlook.com (2603:10b6:3:76::7) by
 MW4PR12MB7286.namprd12.prod.outlook.com (2603:10b6:303:22f::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.27; Tue, 8 Nov 2022 15:24:16 +0000
Received: from DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::d0c4:1f77:4dbd:811e]) by DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::d0c4:1f77:4dbd:811e%10]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 15:24:16 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, AMD Graphics
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Decouple RAS EEPROM addresses from chips
Thread-Topic: [PATCH] drm/amdgpu: Decouple RAS EEPROM addresses from chips
Thread-Index: AQHY8tCxonaNXfQLVUCZSDIcXuSkqq41JplQ
Date: Tue, 8 Nov 2022 15:24:15 +0000
Message-ID: <DM5PR12MB130841CD83BCB65DFE911937853F9@DM5PR12MB1308.namprd12.prod.outlook.com>
References: <20221107174411.168459-1-luben.tuikov@amd.com>
In-Reply-To: <20221107174411.168459-1-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-08T15:24:14Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7683f982-1271-4421-8b84-ce8e7707eef5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1308:EE_|MW4PR12MB7286:EE_
x-ms-office365-filtering-correlation-id: 6fee0c08-3994-45aa-263d-08dac19d4c4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QipUYT9qi67U3nRxx43dnt8VdQVIbPm0RQuvdz+UFJi272349CGniBRNGAcERMTClU3HALnL/SdhY8EcEj2jjVfV/Vzj7F9c+SgxN96mb3ptEKGIBWT6sekp7ZC8tk0sAxPd5TQW59Nkc8OtzhSiUSPJLKZD+RaONQTdFIK2QBfnyI26AVQz+qpPfIcTe9ptQ5uB16mb8KzG/aze01RMbvBw7PYBYFaMQi+F9c7kHfkTB4dWBFsZipT3wA8TUY/xqv5e0NKn09OwBPQbhkZS9aSC0Llt+gI7L37SG+j96PLwlKqcPfaayt3YZyzH0UwEiMHiraeMfFIbyqfLa1gGWKN6ydgxEw5qO/jLmvepbo86IxBQ1HymrOtJu3gMcZlwJDZu4vhUJ/7VTZHwF1HcM/6TPQla9kPtuYvA4GntfAtaw1jP11+71jxb743VemrCK/r3hG32mr2gtYorVyDBQTpI0s/gOnrcJdo0iapc047o9hP05uLXXqf4BtIZYB8u0B4Tebe+yHOWRb2+w9v1DU3Yqid3COJykOi4EatO90D8sFO+KG6A2n+a3vNzV2Ew4Wbdrxy8QVPpxQgdxgU2wkizbFxDK/9P7pDsV/xQVXxx32YPwN8IEnoL2RSz/K6PCrlHpiuDZ78jQExOtH+jyANuKQIuo1y7M7XiJoxW5E7Sy2u9Yk9ZnQBW/5+1W45Bhu6DKkNz/4CgGlR6dTc8SOHjwIG8afhZKcXVAR7ssAa59IoSm0zkPVRxVSpedgPzi1BCrGcL2+gOugu1KDGZrw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199015)(71200400001)(478600001)(5660300002)(8936002)(53546011)(7696005)(6506007)(316002)(66446008)(64756008)(8676002)(4326008)(26005)(9686003)(41300700001)(52536014)(186003)(66476007)(76116006)(66556008)(66946007)(38100700002)(38070700005)(86362001)(55016003)(2906002)(122000001)(33656002)(83380400001)(54906003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XwrpeKvOsLwYBJs88oyEmxucgp+MKWGHtwJqXmsM5h3Ods1YqBuE+rQIHFC8?=
 =?us-ascii?Q?MPk7ZMHAeN3UCTdqjChS6QWt0ZpYa6TgZQiEvUGGwiIao2XE/onZ8DGTELsL?=
 =?us-ascii?Q?GVR+orEENhEF2+wp3kgCHYuYXVRsktL+FKgmHPv7DD+44ATDtUEiAA8GZeRv?=
 =?us-ascii?Q?YB18GCzUG27YbTHIh13ncA46WB3QFrFpSoKUelmsqSafLY8DFJChrEK+NpVO?=
 =?us-ascii?Q?Yp6+NnILvZN1IzHKAc71EfyfPmYYaAnIm6iBvy8gFc9IpFBRx7SRUQbKP2gX?=
 =?us-ascii?Q?xMA0aTrZ3bAkzBJqCxJ80mV/zdI3L+kH2aYpNKMkR7mDUqdDypx5lJcPGX9F?=
 =?us-ascii?Q?wzA+J54EbgwXapATB/u08R0a1qs8dhwZwiz7VGFxjkWLq1kEVl+bDgWqVjgP?=
 =?us-ascii?Q?XstJwKI9XUA3yPDWH82nm8/kHrMvFzvbyHy2s3PMs3MVpdK7Nt0XTGLtS9lN?=
 =?us-ascii?Q?S4A9YsM9E4dkGRPsq2s2FhHNbe2OQiNbHic/fISJlU4pKtz3UlKOFjQWZT7S?=
 =?us-ascii?Q?jeIVfp/1V4g94A0XsoZQpH7INxJyRuNUuBVsBhpS9yzwDeBkgpotpQ247U/X?=
 =?us-ascii?Q?lIKv0VKQU6cMYyLbnDDtPOlghCGnQq5GOwRcODOTMGYYTvGvnmlrXcUAl6YE?=
 =?us-ascii?Q?8j/nVcncnDix0MAtjT4siYGeslHebd47+N2CYDUw+uMnDTyFvntxUmy6b+2n?=
 =?us-ascii?Q?5AVXTybeFG6COO3SotShZZJJszlWy4q33lGBKw4598MBx11JMtalfq5hDhas?=
 =?us-ascii?Q?LDFpz3zRf96qIOXMZhrCQiogL1s+IidiWMoj4I3lePuB073LxRZzJRKiF4XN?=
 =?us-ascii?Q?jA4xTOrTxXZFhYhZkZ5GeQWqYSLvaDDPHJ0OOFYfLUwnm2HVjphtwqItjGX5?=
 =?us-ascii?Q?1+kos/LBYpptjbyAVQvc5SGMil9poCE4qtbFbiqKqAaq3LSs4eXbHGV0nSwJ?=
 =?us-ascii?Q?CHm+TJpzbroOxE5YsklwOJu5yNQRuam5SBN7rQducIMF+I6c9om4EbDIY1u+?=
 =?us-ascii?Q?oW0Kpuza9nRRfas7pS7mYn+hy53C1N0xP8+JES7ugUrzXP88QcHzi61EmZZx?=
 =?us-ascii?Q?r/lXj0i7yONr9VuMgQG1MCmOWnlKV1ToBIlcxxF+iHu+NFIXnrYKxBm7w1q2?=
 =?us-ascii?Q?E29LRVgjI4JUDqG0RtF9jvH8popwkwFeOmrEkXyOkyWKReCXVD6c4P783+3x?=
 =?us-ascii?Q?ARTB6An67wHtubKUNkyP3F3G7Y6YIuo62dtDwB09PTqHM/wfimpwLJ8mwm9m?=
 =?us-ascii?Q?UT1J0ZdNgXZdX+dL8YpwdJW0pllGjDLqrjz0TAPH0jnnNtbhaB1QyhwVDshB?=
 =?us-ascii?Q?RCszFLC3CNYrRokaAZKj6m958F0Dnt5IU+B75ox5b8Tka7uIRZyeaKApPvkj?=
 =?us-ascii?Q?mf+suLZPy50YjGwE0u5DyiB9Ksql8hvEj+dR3H+7AiPn27NN2jFK5+NsR4Qx?=
 =?us-ascii?Q?7soMWaXAl1cEIs/f+PW8LPjmoojReRca4tiOKsTfrfYU7D6wfzKNCm88qBjU?=
 =?us-ascii?Q?xokEag4DyCgjPh+04U0WLlVs0JPm1beY57FtK8lEIDWkTjukvmEAJ6Bvnmk+?=
 =?us-ascii?Q?jXPuhEZihJJkurk/g9o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fee0c08-3994-45aa-263d-08dac19d4c4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 15:24:16.0119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DjZ7W9ek+hv6/GL2DsWxPysalZGtMsRftJN9CNAZcvBeJdS94gnu0Os49+ShaNJQLBoAkMvGe/i3hyqe4JIDYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7286
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
 Luben" <Luben.Tuikov@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, 
 Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Luben
> Tuikov
> Sent: Monday, November 7, 2022 12:44 PM
> To: AMD Graphics <amd-gfx@lists.freedesktop.org>
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Li,
> Candice <Candice.Li@amd.com>
> Subject: [PATCH] drm/amdgpu: Decouple RAS EEPROM addresses from chips
>=20
> Abstract RAS I2C EEPROM addresses from chip names, and set their macro
> definition names to the address they set, not the chip they attach
> to. Since most chips either use I2C EEPROM address 0 or 40000h for the RA=
S
> table start offset, this leaves with only two macro definitions as oppose=
d
> to five, and removes the redundancy of four.
>=20
> Cc: Candice Li <candice.li@amd.com>
> Cc: Tao Zhou <tao.zhou1@amd.com>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 23 +++++++++----------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 1bb92a64f24afc..f63bd31e199c8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -51,12 +51,11 @@
>   * Depending on the size of the I2C EEPROM device(s), bits 18:16 may
>   * address memory in a device or a device on the I2C bus, depending on
>   * the status of pins 1-3. See top of amdgpu_eeprom.c.
> + *
> + * The RAS table lives either at address 0 or address 40000h of EEPROM.
>   */
> -#define EEPROM_I2C_MADDR_VEGA20         0x0
> -#define EEPROM_I2C_MADDR_ARCTURUS       0x40000
> -#define EEPROM_I2C_MADDR_ARCTURUS_D342  0x0
> -#define EEPROM_I2C_MADDR_SIENNA_CICHLID 0x0
> -#define EEPROM_I2C_MADDR_ALDEBARAN      0x0
> +#define EEPROM_I2C_MADDR_0      0x0
> +#define EEPROM_I2C_MADDR_4      0x40000
>=20
>  /*
>   * The 2 macros bellow represent the actual size in bytes that
> @@ -135,9 +134,9 @@ static bool __get_eeprom_i2c_addr_arct(struct
> amdgpu_device *adev,
>  	if (strnstr(atom_ctx->vbios_version,
>  	            "D342",
>  		    sizeof(atom_ctx->vbios_version)))
> -		control->i2c_address =3D
> EEPROM_I2C_MADDR_ARCTURUS_D342;
> +		control->i2c_address =3D EEPROM_I2C_MADDR_0;
>  	else
> -		control->i2c_address =3D EEPROM_I2C_MADDR_ARCTURUS;
> +		control->i2c_address =3D EEPROM_I2C_MADDR_4;
>=20
>  	return true;
>  }
> @@ -148,7 +147,7 @@ static bool __get_eeprom_i2c_addr_ip_discovery(struct
> amdgpu_device *adev,
>  	switch (adev->ip_versions[MP1_HWIP][0]) {
>  	case IP_VERSION(13, 0, 0):
>  	case IP_VERSION(13, 0, 10):
> -		control->i2c_address =3D EEPROM_I2C_MADDR_ARCTURUS;
> +		control->i2c_address =3D EEPROM_I2C_MADDR_4;
>  		return true;
>  	default:
>  		return false;
> @@ -180,18 +179,18 @@ static bool __get_eeprom_i2c_addr(struct
> amdgpu_device *adev,
>=20
>  	switch (adev->asic_type) {
>  	case CHIP_VEGA20:
> -		control->i2c_address =3D EEPROM_I2C_MADDR_VEGA20;
> +		control->i2c_address =3D EEPROM_I2C_MADDR_0;
>  		break;
>=20
>  	case CHIP_ARCTURUS:
>  		return __get_eeprom_i2c_addr_arct(adev, control);
>=20
>  	case CHIP_SIENNA_CICHLID:
> -		control->i2c_address =3D
> EEPROM_I2C_MADDR_SIENNA_CICHLID;
> +		control->i2c_address =3D EEPROM_I2C_MADDR_0;
>  		break;
>=20
>  	case CHIP_ALDEBARAN:
> -		control->i2c_address =3D EEPROM_I2C_MADDR_ALDEBARAN;
> +		control->i2c_address =3D EEPROM_I2C_MADDR_0;
>  		break;
>=20
>  	case CHIP_IP_DISCOVERY:
> @@ -203,7 +202,7 @@ static bool __get_eeprom_i2c_addr(struct
> amdgpu_device *adev,
>=20
>  	switch (adev->ip_versions[MP1_HWIP][0]) {
>  	case IP_VERSION(13, 0, 0):
> -		control->i2c_address =3D EEPROM_I2C_MADDR_ARCTURUS;
> +		control->i2c_address =3D EEPROM_I2C_MADDR_4;
>  		break;
>=20
>  	default:
>=20
> base-commit: 03b61a92efbaf17ac3d9f82ae81aa4cf8ed40608
> prerequisite-patch-id: 6ba70460570b30bf3176058b399934e5e79b229e
> --
> 2.38.1
