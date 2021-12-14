Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FD4C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 15:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5D7210E564;
	Tue, 14 Dec 2021 15:23:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B625F10E564
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 15:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtbK6N2Us3JEAWEMwY/UJjeGS29AzRv2fEObxEMb9SQvdbHGoS0c3WueK3Z0bsjZDRGnFnvtGa06FFNwtH3mo9CYiLuVmYF2OEJnt1i0C2RuAUpApUsmCgbOzRzRb+mkBbOQysnMkYr3RxQ1bc0D2Az790hX5b+lTNM3uA5Gwdeu+Fj8BxWDKC9dslZq32/fGu5Km4cQ1q4ZKKsCn5Fmtttn5hPVbJVL0Hq7F/kNThLHTnQ1EG0VPBG7QL4rzzrGUb9kXJOvVaGEOeCOCPreSBsU8+jr3dh4qx/dEzlIxd9U9LfcZub6TlQM1uo9QoLsDIHgqzsBTecTs424U98YJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TiH1uvGYoUYOVyrWpa9ds3CmuVAtbzO5ue4NGIAY4E=;
 b=mN7eUabnejdYwbkm42vf+6mGJJ83seWmO0GhqmoTzRlbWWCyc+zlrOnjCuDJiMFpA170rvpstA9D5MfR+qhGo6plKZjao6OsMsnxE1ATmHJN1O/o9kbUayKlnLJc/Lg1HerszFhLDZEEn3U2DEhrgPh2DttHNhQYjAHQEU3iRIOpEdlPDZAcsN+jmWdvJLyOhZy5O2cw4opNY2DhzVqcORRidicO/tKxQLqOXuI52aGFRDz0oSvw+rmbID8rZSI9WwhJZOI/IEluGQgTBw77CxRJ6ei2s4qiqcp79CAcQEMXCOPXCKupj5c4zRGp978JUlQdBLv+RelkKTJpQUk+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TiH1uvGYoUYOVyrWpa9ds3CmuVAtbzO5ue4NGIAY4E=;
 b=cHvw6NnmGFUwd6Em9Kk9bR0Cgzu7xCKXYWnPmE+qDCvZRV9QBN65JzJOmuIfOFCYUn7XfA+diyQikLhF8t47p5gIh/Giwsn7P/vMBTOJnTmXa2ulMlupY5AP/s/lscqzSO5uAVs5qDMROwPS1rhmIrbYs/BZ2mMirrz4sonHevQ=
Received: from DM6PR12MB2858.namprd12.prod.outlook.com (2603:10b6:5:182::21)
 by DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 15:23:52 +0000
Received: from DM6PR12MB2858.namprd12.prod.outlook.com
 ([fe80::74bb:cb46:f4ef:73e4]) by DM6PR12MB2858.namprd12.prod.outlook.com
 ([fe80::74bb:cb46:f4ef:73e4%3]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 15:23:52 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/4] drm/amdgpu: Increase potential product_name to 64
 characters
Thread-Topic: [PATCH 1/4] drm/amdgpu: Increase potential product_name to 64
 characters
Thread-Index: AQHX8FhpwWFszDKGIUKRAurWmFdAi6wxVcmAgADGpAA=
Date: Tue, 14 Dec 2021 15:23:52 +0000
Message-ID: <DM6PR12MB285830E57CC87D249239E9B485759@DM6PR12MB2858.namprd12.prod.outlook.com>
References: <20211213193402.96278-1-kent.russell@amd.com>
 <DM5PR12MB2469C2C6C65FCB39C7C10D97F1759@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469C2C6C65FCB39C7C10D97F1759@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-14T03:29:25Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=5713d6e2-2398-45aa-9ecc-5dbbe47aa19a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86618e51-6fda-4d65-7d3f-08d9bf15bc35
x-ms-traffictypediagnostic: DM5PR1201MB2491:EE_
x-microsoft-antispam-prvs: <DM5PR1201MB2491A19A6ADF5988012920FE85759@DM5PR1201MB2491.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PUVUDJu6YzfJd/2ujSbmtQf42NSVyHflUxn5rY/ns1kRBNL2bIcBhmdm7/sE+2plaDUz4HEHL7os/lBvFX8pZ5Gb8r3Y0liWiYrjXlfOmqtPx/9fv6hJJx/egvkW4YMaEFXxAGDQvIms7CGtZ5XNyFhr0wfgeNrdq841DYw8Xne21WZYMoP7sV3ZfUewIY+Ea5ynNBisWIIr2MUj2YIvHgAh7CPYVa+yP3vbHuzjQlky8eY7E9vRBo7WNSzOu7u6qI77N2pGkXzRtgfAlNcJBD1bmBFclPILhYE9OqJkry74sQNbrTpFEidiNLKMbB7/7POMS6mdJWd9EqXTWuWTvhD7v3Ou8mFuF186ZwplkaWvZwNyrIr8GBz3poAXR5ES2DSXRZYox5KMcsNyBfttRezmvceJ3MjZPfmRl7NmXTCtm9VUyxYteHM6MQUH7lCaz9mMQuPpTfGBppe0knw4IvyU9yygR3EOGbkxJDpX6RZb6p4uol1JDbtXJPgOouRcIiHFydo9y7iDL4TbNBM0X2P61MVT4IKP1x2HNrZYWvR4z8f7SMKw5F4yCGrA5fdT+Ngf3BfgI6GM5SXQTz8VRatzk7BGAnEyCkF55WLkWz3z+uDYPnZqHdrN9DkXXFQJJWh+/xyzfTUQAgwHcNUxPK9ofgJp2z4BXI9fVIMzkEJMlip6spirRwZ9DwMOQzL53pO258niCUyo8wScMAdGFQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2858.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(76116006)(66446008)(66946007)(53546011)(66556008)(55016003)(64756008)(33656002)(7696005)(122000001)(8936002)(9686003)(71200400001)(38100700002)(5660300002)(66476007)(83380400001)(6506007)(508600001)(26005)(38070700005)(52536014)(8676002)(86362001)(316002)(2906002)(186003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A+ZnoSNLelP3JqvWWDNBbVJ/f5FZn5ePoBP087KtpHVUeMw/B8W3UlJY6Pon?=
 =?us-ascii?Q?dStYG/HzcjzV+uhhwgHF/a9rcQbce4aHkau49Ys3G4ABm51E4SdAwYpokspl?=
 =?us-ascii?Q?ooxnHWiLkorb3VXpsge5qD77zrfzhz01yexnRUMNxZXY5eZ8AD3Gnkt05msi?=
 =?us-ascii?Q?kq4ZyvZ4kotcHhUL/8Brcz6DmQckA68jS6y0dkXdr4cW9Zzxv91g3biRTzYm?=
 =?us-ascii?Q?3B7j5GDsz0mI+rypHvLUwn4UoFf3OGki1auUtCzhPF8eVeTvabW1Tiv2IMgH?=
 =?us-ascii?Q?sg1w/uPzrZSbHLxolV9xZDyGv0yvT9JXqfeM9+zd6oVyF4HsOVosxzxvqB+1?=
 =?us-ascii?Q?1K+Lv+r7FDk5JlaH49b+iyTsw+RqLi9fFYPJrMWIhXsMaAhYactNgNdRBNCc?=
 =?us-ascii?Q?9DzgHzF3tSI1A9I8Xj7T3ZmDR6bsK2P0Ooolq5IPbdccbse52f/YAPKOwoni?=
 =?us-ascii?Q?Igp+JE8oY8ZxYM1ki7CWVIDOnHqrrMr7zIoaTRn/0VaONGi0ll35zLKA0sZW?=
 =?us-ascii?Q?hMTGxcYbZbP+q+VmIPaR3y4gFtAAcwApY4xwzJsc404fU37/W7eRdhDrfFv/?=
 =?us-ascii?Q?fUm7HITw/y/bSoLeUPpQUzNDmIF1Y/oBpugmwbm6GhY/fzvihxoaXT0kDDAr?=
 =?us-ascii?Q?qE1KJNpgd9YckcESYRftN+ZXwq9xqcFFi0KzuXltl3z57bEgj7WKp9qDy8ud?=
 =?us-ascii?Q?ijGUtVhVAKJrunjlbSavcl69dHM1ViXGfOutWVsO5Wrpsds7PJ7erem53jDe?=
 =?us-ascii?Q?3KbEV4ANXKBgWZ1YdcEegCDakU2DiFgb5JOXjiiwDxe689DJLstI6Fo3jvu4?=
 =?us-ascii?Q?S2lro3ueLAoA75NirPxTThXXzjrRROaVecIG3j7QBo/i/uh6h3E9cZwQhc+7?=
 =?us-ascii?Q?H5eAhehGcYwWk90xPE609e22Q6ufhk9bQb7wpc+td8ELy2h9/RknrbWlkmA5?=
 =?us-ascii?Q?30Rl6MotKFyAkrMpn86sVmbLdq3PgerMGecRhgIYXSQraNMBzVx/6Iy5lRZ3?=
 =?us-ascii?Q?jAkphYwe+9UCgOpbT/uO0pItlgqJ9BFxLdOhk/hQ4KZxjWKB0M3pwKNLTy8E?=
 =?us-ascii?Q?eXjxCphIjR42pwkB029oupU7wMsx1ljZkh9mK0CSoeElEmVPliyazaKeYn3W?=
 =?us-ascii?Q?iqydi9kaAeGXx8byvWQrU/gdxZ1dNNEYD7+cqd447YeFJaQPMV2MtQ/HT+N/?=
 =?us-ascii?Q?OATY0y4lSujKzWdrcgsXDQvFoslmo5yA8SEtbasfC4bU4iwZ/+3LdVTlLZyY?=
 =?us-ascii?Q?SvwzJmk1+DKs/vB+K1YfM0sdVFp3bHPZirz6fleqF+bYziK2idBErXCsUbNa?=
 =?us-ascii?Q?boU8Lrdc0lg5u21GupuFAlR42ZvMJP7GiwBOAj9leIILs78DJEZ9CMxd9Jvf?=
 =?us-ascii?Q?H7tz7ZxgWiGg9JuC3b/AB00WQ4Y4WxxpAlBx1S2QlhWwOBT3uej/T2DhCNBE?=
 =?us-ascii?Q?Llu3h+Mp+ebMwh967pls/VjFW04gWykz5eXuGZt4/mvVyHg7tCcg666XnT4N?=
 =?us-ascii?Q?V/+p1q10tuTOwVy8uKvg3qK9L2LAO+fyVBJpYS+JLsIsbWQ0xjZcZK5VL2EP?=
 =?us-ascii?Q?tKRS3B4K5VX29bmT1XONLaiR3dwKofQFMLvbB3Ko50Fx+onNJuIESp1Rn0Bo?=
 =?us-ascii?Q?AmffA0Epxso2ob5x4kogSpg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2858.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86618e51-6fda-4d65-7d3f-08d9bf15bc35
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 15:23:52.0467 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8urCbmzvx4PbNjTCF2W7LxiotM6ov2acDKW8Th1VZ2i2pWcly5A9lPbVGfto5jlaZchzgbSjnHKCZE7rrk77Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2491
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

Yeah that would make things a little clearer, and make it easier to change =
going forward. Thanks!

 Kent

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Monday, December 13, 2021 10:33 PM
> To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Russell, Kent <Kent.Russell@amd.com>
> Subject: RE: [PATCH 1/4] drm/amdgpu: Increase potential product_name to 6=
4 characters
>=20
> [Public]
>=20
> How about set a define like PRODUCT_NAME_LEN to be 64, and use it in FRU =
code? In this
> case, if it needs to bump string length of product name later on, it will=
 be simple.
>=20
> #define PRODUCT_NAME_LEN 64
>=20
> unsigned char buff[PRODUCT_NAME_LEN + 2];
>=20
> Regards,
> Guchun
>=20
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kent R=
ussell
> Sent: Tuesday, December 14, 2021 3:34 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Russell, Kent <Kent.Russell@amd.com>
> Subject: [PATCH 1/4] drm/amdgpu: Increase potential product_name to 64 ch=
aracters
>=20
> Having seen at least 1 42-character product_name, bump the number up to 6=
4.
>=20
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h            | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e701dedce344..1afb3066f6dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1083,7 +1083,7 @@ struct amdgpu_device {
>=20
>  	/* Chip product information */
>  	char				product_number[16];
> -	char				product_name[32];
> +	char				product_name[64];
>  	char				serial[20];
>=20
>  	atomic_t			throttling_logging_enabled;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> index 7709caeb233d..b3b951fe0861 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> @@ -88,7 +88,7 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device =
*adev,
> uint32_t addrptr,
>=20
>  int amdgpu_fru_get_product_info(struct amdgpu_device *adev)  {
> -	unsigned char buff[34];
> +	unsigned char buff[66];
>  	u32 addrptr;
>  	int size, len;
>=20
> @@ -131,11 +131,11 @@ int amdgpu_fru_get_product_info(struct amdgpu_devic=
e *adev)
>  	}
>=20
>  	len =3D size;
> -	/* Product name should only be 32 characters. Any more,
> -	 * and something could be wrong. Cap it at 32 to be safe
> +	/* Product name should logically be < 64 characters. Any more,
> +	 * and something could be wrong. Cap it at 64 to be safe
>  	 */
>  	if (len >=3D sizeof(adev->product_name)) {
> -		DRM_WARN("FRU Product Number is larger than 32 characters. This is lik=
ely
> a mistake");
> +		DRM_WARN("FRU Product Name is larger than 64 characters. This is
> +likely a mistake");
>  		len =3D sizeof(adev->product_name) - 1;
>  	}
>  	/* Start at 2 due to buff using fields 0 and 1 for the address */
> --
> 2.25.1
