Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C01FC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Dec 2021 13:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 744AA112474;
	Mon, 20 Dec 2021 13:13:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCC2111244A
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Dec 2021 13:13:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrXOWofjhnllOsZt34dlDlWUlJ1PXLHM7ZBMOIn2JzOsM69bj3NQ95+ir3XBZ0yzb7pDCttY3OaiRHJw8OnNV26ZQ4LSU7CWFdl9v4vG+DhhLuRm22ZsIom3tQ1GDPCOhdy9ykQ6Fq+Vjfx0YwgYBBRUIgf2YZGLV7ElC9sr/PeKLhneptwcNkawjqsA2dRH5qdJsXQE0O3ZFWS4Pbh4f2Wr73QvzDgQdVN62WBm7DcQw8Ihe0Y2rq+0SGA4SO5LWuTeb/21n2/UytZgaYgJcgJZRbeK1gaWbBiwxoM1qkU0JRuUQxfFG5QcVHZ9jfvxjo+aFJD8mP5QgLroD9/Few==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OE1VmfgR9RHyhlvpq34ZqZ8eJIij4H2n32ltQim5hCc=;
 b=Ctb1DGxQSTMJ3Sd5pOwirs7u2PtmB2FOuNXpPEeoEvAP1WloeUljsOdLrblWiYcX5ip59CyncTddUvpqoIifwHPbOVsmMH46wY9gXs/KRLxmsx2GCUcx2rT3MN4VkRyWx2vy6U1yXfEEjJRyITBv6OBHmDcOOLE0KkJuk7Xy6NJBb2B47E8yVJUm9f7Ax76oFt8tibr3xxambOgTrtMPWeINKMOBiJpveSVnVoh8B3j4rYsoR1K3D1rZX5hpuhHfIWRJhH1UXyfgVeo1aQVi/l4qW46QW9XQn8A98nTNJ7GGmIH2k42fbjjkyNLS89391gxsYE0wEom/QhMJr3L0Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE1VmfgR9RHyhlvpq34ZqZ8eJIij4H2n32ltQim5hCc=;
 b=L3MAmvoQ5knhh7pQgEfJL0emKKE5qK82FQ/yI1b4TJB4DcTsMBhdcXgOQiVV+JfTi8W38a+PxuhcjI87epLgfKzQg6jDhCWvH/2SspMPGYk5u3mBmrJG+EIQpopq+VIIF/QVLdkTCDLvGGs/RFWwMNEFZ3fKZhk2jjAGuU3M7JQ=
Received: from DM6PR12MB2858.namprd12.prod.outlook.com (2603:10b6:5:182::21)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Mon, 20 Dec
 2021 13:13:40 +0000
Received: from DM6PR12MB2858.namprd12.prod.outlook.com
 ([fe80::a589:5d7a:f504:aa69]) by DM6PR12MB2858.namprd12.prod.outlook.com
 ([fe80::a589:5d7a:f504:aa69%4]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 13:13:40 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdgpu: Access the FRU on Aldebaran
Thread-Topic: [PATCH 4/4] drm/amdgpu: Access the FRU on Aldebaran
Thread-Index: AQHX81s4tvLj7BXe7Uir5NQM/pXNf6w3jNsAgAPS84A=
Date: Mon, 20 Dec 2021 13:13:40 +0000
Message-ID: <DM6PR12MB2858D5D1A7B022A4B9F66FBC857B9@DM6PR12MB2858.namprd12.prod.outlook.com>
References: <20211217153131.321226-1-kent.russell@amd.com>
 <20211217153131.321226-4-kent.russell@amd.com>
 <DM5PR12MB2469E515EFA5CD21D91C4C96F1799@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469E515EFA5CD21D91C4C96F1799@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-18T02:47:41Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9364864c-9d0f-4250-8ba3-66697997a24a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c183e253-2a47-462d-d7ea-08d9c3ba8a70
x-ms-traffictypediagnostic: DM6PR12MB4137:EE_
x-microsoft-antispam-prvs: <DM6PR12MB41378ACE07A29892C5D200C3857B9@DM6PR12MB4137.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4YLkYBGAo0gfCh1frrqLayld3Co142jsGQwEl7Uh+TUsiRh7JTYbdwvR9qU02z3799cHJWZ+M1NNNbQy8XyAfNw9+S5uLvrWC6SVkFHcHy2LNM9DIyY12h2ljvWUHL6k2Ao4kemVcZBRQiF7jA/HVehMfpWcgBZRy6cwypcGBmt8iYTDgAPpimsvSXjhB6e84FF4h6Z0QzvWYOMLkMMNRJqL615f2/HOQof2xAw6HrkMg0pzMz4cXn2H6sTDwwYzs3Cce2Iv6UtIMS0E0WxPQz6VsqgCIt0FTYIzW+TbQIn/Ou/yaV+IZhSl9Ab4yt8pUSZDp8SwoZ9ZnrbqCoHGzwcH3+l6YLnfbO+O7IhREMcWp4q4S17MA53JxNKrwqAaysDtaVM7T9a9lm8m9R+auXwp9CXlIz5vj/Hui7mkRG8znlUefhMEqZLSzHm3sytD8H+v6NdqvhU+aq3Q0vazxmy4iSYwpGtOOZchXWaaBlg75jPIy/poePSaaXvID+XOvLzLLE6xAN+2dCep8biUgbRjELkm/TihdySJwwh0MzqhfEtmTR81sQVxH7fznyUooZNMSTdAZfdu/PRikZ6B7T1/cM5YAb8mqA0NytxesyZdWGh1Y/N0mBEHDxFKZxOPW0Ni9VUwhPIpLcmoMnmiyVG9AswBySkPzQW2PsrJmI2B1KN9H4yxVhOE38Dcnzqwyuo7NKEkc5oWd38IbC6/FA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2858.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(76116006)(55016003)(508600001)(186003)(66556008)(64756008)(66946007)(66476007)(9686003)(8936002)(8676002)(6506007)(53546011)(71200400001)(26005)(7696005)(66446008)(33656002)(110136005)(316002)(38070700005)(5660300002)(38100700002)(122000001)(52536014)(2906002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qdIeIXvGiGo5dt3HQtcrXnPmMoONPC5u8UsToSIyGSdR/C4WTvSbiRsDNxGt?=
 =?us-ascii?Q?b1QiI8nKEjjM01n7qDP374Q76jcDM/JLJI9U8QCqBnceU6G95sDbBtcKTe7i?=
 =?us-ascii?Q?b1DdYJiRaIqSsoY0aoiTXR2zh1unmAnUqBGC/s87oSU7x+B7PWHNqgo7h+sU?=
 =?us-ascii?Q?xUCWVxmwPBM6H4dj5+qwU2aJ6WqXjCw1Pzh2qw6FO8MhIXPb48Ev7XZs7Mjc?=
 =?us-ascii?Q?FSmvzrY8LihMWs4Dooc+MBR9XivCKhzWC6fFvGqvoHYcXoVwhnIj+bOb+uiw?=
 =?us-ascii?Q?+D/9T+oy5TBi23jN5BwrXE4jDs8KbHeTeXfkC7ktIqrB78GEgD2B2/ul80g/?=
 =?us-ascii?Q?Q958IgX3st6GHVZukup6YTi8rMEpUVTlBl1ZpeTt8rWxOTWQcajR1Zmk9Zve?=
 =?us-ascii?Q?BSG81UhEQ8inF9nbWPwnfdvitpAzCMqh9WHED1fK5XBQpGOwmCBMKlQoHdWZ?=
 =?us-ascii?Q?P9nm5+Wf/4cxjjF4jSRX4H9d0v7QzDx66hU25eU0+2pIVJaNkYpTjR9mjgER?=
 =?us-ascii?Q?2MEqjJh5mdaMyjTtKFUTG+MzAjMC916CSqsGYtJhKBef4T7ECnHjdTLIPzij?=
 =?us-ascii?Q?D58Zcpx/ah6ktgKvj7eVbRY3zjvRfmQnrp5CMJ2JiJpTCk4VuO9Uwgo51zgp?=
 =?us-ascii?Q?U/zHwtJWkH+akIHanukzaLsM9ztZsuZUh23LadIfdhX4ONPZic1roisW2ykK?=
 =?us-ascii?Q?/3Hpi9de1YVuH/qg2kBp5AWE5qfGIjt32djONnRA9QgE5oR4IOuOXcXHHLAU?=
 =?us-ascii?Q?cKMvidPM1PNmOo2a2qtKmI9gXM36RNy7Kg23sB/1c95godmX0cSjlVP4LS21?=
 =?us-ascii?Q?LMg8LWExi1cJDnn/yovHbfdgbvw5scnb+dBhmDDHdXJhwpvBRKKP3kSyYWb/?=
 =?us-ascii?Q?Gesk/l3i86mUwVpeLwLIedEmLjapxxPP6WH5lHLD9I7ET+KN8JyLLMaclW1E?=
 =?us-ascii?Q?6y9pfiAx1O8V64q4SwOn9y4n/XBGEC+UxkbcZjL4wJF7PLPbS9V8UH/6YXR5?=
 =?us-ascii?Q?CxkJF/5IlWnsXnXBDHEwHPs5CcQwP/HRwpJ1Oyl1WNsaFxd+/M3RCnuAN/40?=
 =?us-ascii?Q?kcMUOxdQnn9jUUZ8Fo2I7zbxjywITK8cJ/yN/ucHXxQBRsc6P/hiyFUdBvz9?=
 =?us-ascii?Q?2yJlWBSNpFQ51Glvg/j0tkGNcMzh9tomnkOgunvAB3J7zfGcxCQhvoT8T05/?=
 =?us-ascii?Q?GjlTtXh/pFSSNzNiSAu56F0y95C/0n15fZkaVkRgmVmJ0EPsrMNcXQw6Wnh6?=
 =?us-ascii?Q?zIUzki2QuGBDzR4MpyL8feIisJJ0ZJa/f0JdHi7gp+d5fQ+lUw0iYhMEFt6y?=
 =?us-ascii?Q?1kbuGRxoV91MJZexzuTIftOzCFUrAtc4bwpgzBomCoaVyU6/4GkeCFOwyPO+?=
 =?us-ascii?Q?lWYRfFtAV+vRoMwXhu+FT8svl2W4YIysWjpyfwgPCfUixYKTDGHNErHkaGNX?=
 =?us-ascii?Q?YcAO1YnAlWhKwiuo3gMSDjikHPTjFg/NJcx3J4k3IEhlrW6CrteuIQ9tmXtw?=
 =?us-ascii?Q?XcE6teMGEAFDP5Csbiytp5KweeEvm+OYOqi+NnkeyiqOqdLAgkZtyrzMicoR?=
 =?us-ascii?Q?93BlHuYHNf6lHo0I/c1KG8Z9W+FXLXIdvF5r9vZcgPTHmqjeW1cNtQXxAQBg?=
 =?us-ascii?Q?JdY9QGwewaoUO0jaIQzruS0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2858.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c183e253-2a47-462d-d7ea-08d9c3ba8a70
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 13:13:40.2057 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HWgtFGeDwr4HfpCyXBmu8jw/PxwdIyCKKwh/wnpZ87TRma9tU0wfnUQW1BGWJl714vEBdyomRRtDK4u0jkf5Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
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

That's fine, I can do that change and submit the series per Alex's RB.

 Kent

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Friday, December 17, 2021 9:49 PM
> To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Russell, Kent <Kent.Russell@amd.com>
> Subject: RE: [PATCH 4/4] drm/amdgpu: Access the FRU on Aldebaran
>=20
> [Public]
>=20
> Hi Kent,
>=20
> +
> +	if (adev->asic_type =3D=3D CHIP_ALDEBARAN)
> +		offset =3D 0;
>=20
>  	if (!is_fru_eeprom_supported(adev))
>=20
> I prefer to put 'adev->asic_type =3D=3D CHIP_ALDEBARAN' after calling
> is_fru_eeprom_supported to make code logic cleaner. Without FRU support, =
we should do
> nothing.
>=20
> Regards,
> Guchun
>=20
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kent R=
ussell
> Sent: Friday, December 17, 2021 11:32 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Russell, Kent <Kent.Russell@amd.com>
> Subject: [PATCH 4/4] drm/amdgpu: Access the FRU on Aldebaran
>=20
> This is supported, although the offset is different from VG20, so fix tha=
t with a variable and
> enable getting the product name and serial number from the FRU. Do this f=
or all SKUs since
> all SKUs have the FRU
>=20
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> index 5ed24701f9cf..80f43e69e659 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> @@ -56,6 +56,9 @@ static bool is_fru_eeprom_supported(struct amdgpu_devic=
e *adev)
>  			return true;
>  		else
>  			return false;
> +	case CHIP_ALDEBARAN:
> +		/* All Aldebaran SKUs have the FRU */
> +		return true;
>  	default:
>  		return false;
>  	}
> @@ -91,6 +94,10 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *=
adev)
>  	unsigned char buff[PRODUCT_NAME_LEN+2];
>  	u32 addrptr;
>  	int size, len;
> +	int offset =3D 2;
> +
> +	if (adev->asic_type =3D=3D CHIP_ALDEBARAN)
> +		offset =3D 0;
>=20
>  	if (!is_fru_eeprom_supported(adev))
>  		return 0;
> @@ -137,7 +144,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device =
*adev)
>  		len =3D PRODUCT_NAME_LEN - 1;
>  	}
>  	/* Start at 2 due to buff using fields 0 and 1 for the address */
> -	memcpy(adev->product_name, &buff[2], len);
> +	memcpy(adev->product_name, &buff[offset], len);
>  	adev->product_name[len] =3D '\0';
>=20
>  	addrptr +=3D size + 1;
> @@ -155,7 +162,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device =
*adev)
>  		DRM_WARN("FRU Product Number is larger than 16 characters. This is lik=
ely
> a mistake");
>  		len =3D sizeof(adev->product_number) - 1;
>  	}
> -	memcpy(adev->product_number, &buff[2], len);
> +	memcpy(adev->product_number, &buff[offset], len);
>  	adev->product_number[len] =3D '\0';
>=20
>  	addrptr +=3D size + 1;
> @@ -182,7 +189,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device =
*adev)
>  		DRM_WARN("FRU Serial Number is larger than 16 characters. This is like=
ly a
> mistake");
>  		len =3D sizeof(adev->serial) - 1;
>  	}
> -	memcpy(adev->serial, &buff[2], len);
> +	memcpy(adev->serial, &buff[offset], len);
>  	adev->serial[len] =3D '\0';
>=20
>  	return 0;
> --
> 2.25.1
