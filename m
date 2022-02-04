Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C18C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 15:06:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0278010E845;
	Fri,  4 Feb 2022 15:06:44 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2044.outbound.protection.outlook.com [40.107.95.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C88C10E845
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 15:06:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2k+J7eDqnIAkaNLFCehw9h1Sq4vW7qTJNFGtJ+wz1qC7VRrn49JcLYhTeMRhBq80Av/sDyS9avjShNxpDZTDOv3W+GoAFbdwSdvRh7vr6cDSn/7hXnghV9D6CKdrWyYwDQyZIgdNp/l/XHyqVDBXYy/Gsf/iu5d6TOynB34Hm4e0Y3xB8EBoSpdLHbbzO6wACCHCYOv+NKmXslRRG8hUvYdHDSFozJoVy99Q6E8D8PiWr2eqJVImJH8tS9LzZ03F8qa9X8uvnvElDhjosIeX80mqek6FOr7OT6MsSfcjZktckEPT5IZIv0A/ywWz9U3cQ0q7WY/Ui65oFSVN0na/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnYVzj4sPDY/A6yBlwhhXzdQ95CMGwcNoifUQF2i7iE=;
 b=APOcxpUl2V7pJcvcifrVUZiJ/erfQU0wn5Tb2hPQ/DlIeiVivGUN0eMdWEqVHa4wkUD5qGBTFTYSR0z6yD68WXEeOje+N7N5run6Q/MHNzsx00U6e36T78NqPJqdSbwz5T5gzU9YbaOjsXCVQKiBZiJFGGBoOrYi/wnddmfjY+fDSnKaUPEr2iRE8KrD0DhLrlz6KCUcbb8zRTSNzUtohRAG8mCU8qL5gYkTe3WK7SvnzgFvqLn792eLYu3G9Q9rOT22++Bc1Q3Tl5rrNVufC3xva2qgqgDn0FGJv2NBEi1XS0W5syQskmsOxWyxyfOJsn3Etm9mb+Iyzs6dD9XapA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnYVzj4sPDY/A6yBlwhhXzdQ95CMGwcNoifUQF2i7iE=;
 b=GBeKNwtVBAxOfZOHaKs8ZZ5k4iU+K73CNUPC8TaCFPjWPeV4w+bW8Cl/HPt71nUKs7JLGhQPY9nl4BgCa5mxGf2G/CrrpsL0tbAij4jh1A+IWuNOavRyJch6zxHVCAPcli/hvXUI1hQp3Cht0aepzOzLETHCJ3gB3Q1BtKkmqJc=
Received: from CY4PR12MB1303.namprd12.prod.outlook.com (2603:10b6:903:40::12)
 by DM5PR1201MB2507.namprd12.prod.outlook.com (2603:10b6:3:e9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Fri, 4 Feb
 2022 15:06:41 +0000
Received: from CY4PR12MB1303.namprd12.prod.outlook.com
 ([fe80::996f:5c79:1e41:85c4]) by CY4PR12MB1303.namprd12.prod.outlook.com
 ([fe80::996f:5c79:1e41:85c4%9]) with mapi id 15.20.4951.017; Fri, 4 Feb 2022
 15:06:41 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v1 3/3] drm/amdgpu: Prevent random memory access in FRU
 code
Thread-Topic: [PATCH v1 3/3] drm/amdgpu: Prevent random memory access in FRU
 code
Thread-Index: AQHYGYfv4Am6JpdNOkKKcaVTQC1ihqyDfPgAgAABc9A=
Date: Fri, 4 Feb 2022 15:06:41 +0000
Message-ID: <CY4PR12MB1303B3C800898614A0D62BC185299@CY4PR12MB1303.namprd12.prod.outlook.com>
References: <20220204052724.469469-1-luben.tuikov@amd.com>
 <20220204052724.469469-4-luben.tuikov@amd.com>
 <DM5PR12MB13239926F9E7657CB310F50B8C299@DM5PR12MB1323.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB13239926F9E7657CB310F50B8C299@DM5PR12MB1323.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-04T15:00:58Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=11b8951a-27ca-4b28-b5bb-4798f1f71cb8;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54f06de9-b865-4c7a-229e-08d9e7eff335
x-ms-traffictypediagnostic: DM5PR1201MB2507:EE_
x-microsoft-antispam-prvs: <DM5PR1201MB250798B398AFBE26B74CA07485299@DM5PR1201MB2507.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aGdA/Tlejo8j7dMALv6byEuYoPZT+VxxYlD46zAWuwJ++eySB5tTOfRHs3sNZMQlxeqsZWBsa1A0QxsMzrzUkXswMRcnuqa/w+4TfmzFNbE+6BLBDmooe7+EQV7+bTvJnz/ceIjLpt/q4PnTAb77Po8buAF4UIFdIkSa09zNQM/2TdhrLgYc1ijkMLR7nrE7iFLOxer+jqTmoXaTa6QcX6IDLle4MjbyCVe/9UXm5L/Auxf3LEzTyZHJRyepqtY0Ho1AharOi8dE1rppC4siPxIdGdUwS0tiroO6cFEuJYb16orpJQ2Gkb6Lm+h9mMLzpahojrDmuW5sqZa5F0mzhaCpBMTYjtBFo/GoPkFfSgCcPUZf/YVXjjoN7Gf6RjS65Y/me3uot0l7bR1ZC4RoZBOz72ENsJp93YYMn7gyjmJl6UhuRoH3DIfQ60M9yIO4eOywxojLldgYjZ9OhH1fePqIcWLtLpJpW8cFmGlz9MXmAUhCl/HN0C7+fcZ4gBya1FgPi0hDoWVQ1wQGOJPb4iDEQc38CTGbf3DC3UoQWjYl1KDytg7MU+9dK8D52k6RE607r2XUspFoQKgujOp1lTo3CgH48VLEpiT5l1RODBQE4cgdBFCR/ya0qBOMdOUq5WlHZ6Odq2z3VfOeeZLAn3mraPhDsT3kNFHBnQVv3bgvKh9AK/d8v7Zk9ZQppHeE118foD4/SlPvEnH+4RUCdg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1303.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(33656002)(83380400001)(26005)(316002)(66476007)(110136005)(71200400001)(54906003)(9686003)(66556008)(6506007)(66446008)(7696005)(4326008)(8676002)(38070700005)(2906002)(186003)(64756008)(508600001)(8936002)(55016003)(53546011)(66946007)(76116006)(122000001)(38100700002)(52536014)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D/XvhJ3nrnsEyAR800gV5nkhg0mUln2/4pI08FqOhJqecIfWEOXTSFa85oLT?=
 =?us-ascii?Q?srTVR1WVZPCCtgVKi7s2RmW5RgD4CJkP2fYvT9vv1ioyc3pgS3v2xeSRMdM1?=
 =?us-ascii?Q?UDutUJikx56ZWUYAzyDQPm3AIlzmzP/YP95Zezf5vBIlK8eDRcUrTQJYf8UA?=
 =?us-ascii?Q?5wYwLlcGYHALuJIsoZAMbBqAsJ+e/LZZRcmnNyCg71KZKj94o1DGR7YViSn2?=
 =?us-ascii?Q?9Z68NxJKXCXO66cNFTSclaqIOHiE4v6knv/e8cp4/o+eCDg1sQdPweJSSao2?=
 =?us-ascii?Q?tL8j7yNL/sq9dmHGsv3AjiQyCApnxdMWSD7RGj/y3eaSHUUb2yPDGGigTMIs?=
 =?us-ascii?Q?uNT1f8ZgXrQy2bBIvzetWOEx6P/Tf+WQ+Z9dDXRZsHKYWbewXs/WQqryt1XB?=
 =?us-ascii?Q?RGOxKeyrY69mqVRRLilc5/ejmIfbPATMW2HCq/FTER+bysofbZPP88BBKeBo?=
 =?us-ascii?Q?isVhTfE7d77jMgMQokT91Y08UPaDXArXjXqJRV1WdMapHOV+uhZ2NU2HtByH?=
 =?us-ascii?Q?kG7ZJD2/KNSbNZv86fTvkucfGJ/M8G/UjSysd7KHm9VE0MUpugRphkeuoEGb?=
 =?us-ascii?Q?v3aExxKh/W+swsxFpup/K2RN9bRR+ACq+txD6l2Jrgg/FS0kY66byHBhL707?=
 =?us-ascii?Q?SID5o6yp2iYseBpGvIG9J5Qxf5BfcJEGbprQGLY1mIpaVbYu6ABZt+B1vmbH?=
 =?us-ascii?Q?FU1rYQe7eVFpLfAf7RjzuQI35l2aGLkqt4EvA3a/+aZ8z2jqgUnL5Re887hp?=
 =?us-ascii?Q?32r08zE2ummBN1oq97CWD4cpYc0Pek9gj2JW9grnPl2krfJMa884gCLT8EDk?=
 =?us-ascii?Q?JY48ZtuqueGn3p0tuu7a3rhDoPyyLG3+BL9Rphvh1UuZAzl156rso7U3+Sa3?=
 =?us-ascii?Q?6X+idVueyOVWaJIltjtl1oyhEDHQMFTAYakOxbOgtVYcI1VJ2vjL43YR3kGa?=
 =?us-ascii?Q?H6KXWtvjvA5oCGCm/kV92RTp7JC2PsUUxzxGgyyhpdZXJd5SG7+N0X1l97B1?=
 =?us-ascii?Q?zYgtjr2TX+5XAjYaK3LUBlFxGUqfTB6Jz7ImNhJ0KI8bBSQgqrUV61R09m7E?=
 =?us-ascii?Q?B8B/sNgHUAma9xjgaAUxbqU9nT+TxOcnpDdyEq1w/PwUPALFidpxCF1dutL4?=
 =?us-ascii?Q?6+N8NM1tN0887e+rpkAbayUH0cuhuU+NfplCFa7SnsRgKbP+/oTmcSdwKnw6?=
 =?us-ascii?Q?mBgKTkxcsbJ8z3oE06ogiNi/iIITSFIIut/Su57CesyoFuEZnNeYPtzkwiz4?=
 =?us-ascii?Q?8Nv8j9xTZ9h9/rkccJRWv64FDxE+HMUNH+Thtj887ecYC0Diym5x+jXUXKj4?=
 =?us-ascii?Q?ycCXkcMd3x1S48C51tAYObz0rTKBwajl0P3vsOk/6txxI747kVvA+FgJnmgb?=
 =?us-ascii?Q?HKu3/3ukqcjjxVV2nk/P2jcgVe8F07af8CqNq6JwHplfjLKqmXY5vFhKM80A?=
 =?us-ascii?Q?cIFaWkH7Fs6EefAXnhMzZ+t0COI6XaZe81ErRSG0GBZGUjNT6MxUREWCZIkv?=
 =?us-ascii?Q?H7N+0Meqq0a6Sd+lQiNrov/hR61uN/UmFSRFn+6QZbBLPy/Tg3rey/LT8SCe?=
 =?us-ascii?Q?ZqZd3nr/JQBalqJ3T3DcsV7JeLaOBaGDH94zq/u6TG76HpxQqF6jWiCjFFWv?=
 =?us-ascii?Q?1g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1303.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f06de9-b865-4c7a-229e-08d9e7eff335
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 15:06:41.1931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xvb6JIVBh3QI6AUyZy3mXO9t6d6C350Xq8TWY6LxKeRP5GTCF+850aYJq7ur7XZ9CEr1N7XyKAToWBNxeWY6rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2507
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
 Luben" <Luben.Tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

One tiny thing to fix before merging

> -----Original Message-----
> From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Sent: Friday, February 4, 2022 10:01 AM
> To: Tuikov, Luben <Luben.Tuikov@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Tuikov, Luben
> <Luben.Tuikov@amd.com>; Russell, Kent <Kent.Russell@amd.com>
> Subject: RE: [PATCH v1 3/3] drm/amdgpu: Prevent random memory access in F=
RU code
>=20
> [AMD Official Use Only]
>=20
> This series acked-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.=
com>
>=20
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Luben =
Tuikov
> Sent: Friday, February 4, 2022 12:27 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Tuikov, Luben
> <Luben.Tuikov@amd.com>; Russell, Kent <Kent.Russell@amd.com>
> Subject: [PATCH v1 3/3] drm/amdgpu: Prevent random memory access in FRU c=
ode
>=20
> Prevent random memory access in the FRU EEPROM code by passing the size o=
f
> the destination buffer to the reading routine, and reading no more than t=
he
> size of the buffer.
>=20
> Cc: Kent Russell <kent.russell@amd.com>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 21 +++++++++++--------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> index 61c4e71e399855..07e045fae83a9a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> @@ -77,9 +77,10 @@ static bool is_fru_eeprom_supported(struct amdgpu_devi=
ce *adev)
>  }
>=20
>  static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t a=
ddrptr,
> -				  unsigned char *buf)
> +				  unsigned char *buf, size_t buf_size)
>  {
> -	int ret, size;
> +	int ret;
> +	u8 size;
>=20
>  	ret =3D amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addrptr, buf, 1=
);
>  	if (ret < 1) {
> @@ -90,9 +91,11 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device=
 *adev,
> uint32_t addrptr,
>  	/* The size returned by the i2c requires subtraction of 0xC0 since the
>  	 * size apparently always reports as 0xC0+actual size.
>  	 */
> -	size =3D buf[0] - I2C_PRODUCT_INFO_OFFSET;


You can also remove this definition from the eeprom.h file, since it's no l=
onger needed.

 Kent
> +	size =3D buf[0] & 0x3F;
> +	size =3D min_t(size_t, size, buf_size);
>=20
> -	ret =3D amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addrptr + 1, bu=
f, size);
> +	ret =3D amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addrptr + 1,
> +				 buf, size);
>  	if (ret < 1) {
>  		DRM_WARN("FRU: Failed to get data field");
>  		return ret;
> @@ -129,7 +132,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device =
*adev)
>  	 * and the language field, so just start from 0xb, manufacturer size
>  	 */
>  	addrptr =3D FRU_EEPROM_MADDR + 0xb;
> -	size =3D amdgpu_fru_read_eeprom(adev, addrptr, buf);
> +	size =3D amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
>  	if (size < 1) {
>  		DRM_ERROR("Failed to read FRU Manufacturer, ret:%d", size);
>  		return -EINVAL;
> @@ -139,7 +142,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device =
*adev)
>  	 * size field being 1 byte. This pattern continues below.
>  	 */
>  	addrptr +=3D size + 1;
> -	size =3D amdgpu_fru_read_eeprom(adev, addrptr, buf);
> +	size =3D amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
>  	if (size < 1) {
>  		DRM_ERROR("Failed to read FRU product name, ret:%d", size);
>  		return -EINVAL;
> @@ -155,7 +158,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device =
*adev)
>  	adev->product_name[len] =3D '\0';
>=20
>  	addrptr +=3D size + 1;
> -	size =3D amdgpu_fru_read_eeprom(adev, addrptr, buf);
> +	size =3D amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
>  	if (size < 1) {
>  		DRM_ERROR("Failed to read FRU product number, ret:%d", size);
>  		return -EINVAL;
> @@ -173,7 +176,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device =
*adev)
>  	adev->product_number[len] =3D '\0';
>=20
>  	addrptr +=3D size + 1;
> -	size =3D amdgpu_fru_read_eeprom(adev, addrptr, buf);
> +	size =3D amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
>=20
>  	if (size < 1) {
>  		DRM_ERROR("Failed to read FRU product version, ret:%d", size);
> @@ -181,7 +184,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device =
*adev)
>  	}
>=20
>  	addrptr +=3D size + 1;
> -	size =3D amdgpu_fru_read_eeprom(adev, addrptr, buf);
> +	size =3D amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
>=20
>  	if (size < 1) {
>  		DRM_ERROR("Failed to read FRU serial number, ret:%d", size);
> --
> 2.35.0.3.gb23dac905b
