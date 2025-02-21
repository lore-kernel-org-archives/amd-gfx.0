Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728EAC021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 10:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20BA110E1F8;
	Fri, 21 Feb 2025 10:19:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v/8hxz6y";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED53710E1F8
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 10:19:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0AOyxIH1YmU4gNq9oSpbW4OV73/v1NZrUQ7/8aM5w1uErK6aYAewFB6WoxMcJECA2a41+FdHPDYllBIyMnnzcsUlPe3hDMvW181GObb4zz89JCBrkp6Wp1LS/9ojSg0csrVZPAS3loqcjWjp+CAvxuTnotJwAPuJ8UdRJbTbQTqYrR3TRvK5XyInJ9feq2nLR/OV4bWCX7SooGxkKIpRoJE+4JNFOTa1R6ubfcOLQAohsGgQtPW5gcKTA/qElDmbEHIBJpnJXQ4b16h8YJ2aTr6KEXnm0WbwvVZgDfGc0bdlfcL7vVNtneeuzonxniB68tkU1+e5CWaWwH/mCjl4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SP+RLucHvK0ZWTvYktiHj2XtpV8NZczI5uOumugfNgQ=;
 b=ruJ6nM4vc7S1M4fxAVVfEKioPE5eY7gDfSg22Ota/e4LmL+jt06upHai9sJGJBWl4TCBATkLkEKUd50uuxnvFz9MSQiEngUpk1iMqpnFlZF1Bx5yMudpu8gsh9UqWrpUt5g+pxCE/d8IfclfTlV2sqJMObw2lYWbaULCIAOTy41KAK+kJ2j2cyfg4kTGzyl/jgMaDJhisdWa8CdCLYOpIdzgxoDzpZ/y0PSNmBafZ4lbHQe/do7THurDc9NLr2Rghl9k3RD/zYjezTWaZrqwcq7iQfI1yUXdXc+gKoHJ2F27cNHrDcXz2hEPc+aiCwJIIHHnrnRhi0cw2yJeSwJBiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SP+RLucHvK0ZWTvYktiHj2XtpV8NZczI5uOumugfNgQ=;
 b=v/8hxz6yjm+8RFAkEAfXLqFA9ZO2GhWvI7hSdyGWFUhxoUDfuR37s/rTON3aY3SVXp8YlTi2Mc4FCXKhbkZexmFxvz6fbISvxHEhDv1D8n2KhGW46h5T+k18MrqHlrCTkA+/pYmOuDcXlxtONw5uL5UrdBtArG0w/9QYSUlwYlM=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CY8PR12MB8068.namprd12.prod.outlook.com (2603:10b6:930:75::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 10:19:06 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 10:19:06 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: Change page/record number calculation
 based on nps
Thread-Topic: [PATCH 3/3] drm/amdgpu: Change page/record number calculation
 based on nps
Thread-Index: AQHbhA97rcyTCN64EEy3myhBOOfA0bNRi+mA
Date: Fri, 21 Feb 2025 10:19:06 +0000
Message-ID: <PH7PR12MB87966F385706CC62F0AC743FB0C72@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250221031913.1106015-1-ganglxie@amd.com>
In-Reply-To: <20250221031913.1106015-1-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3e6b6c55-70ef-44ba-b706-2ba27236350e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-21T10:18:56Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CY8PR12MB8068:EE_
x-ms-office365-filtering-correlation-id: 1420041d-5006-4a37-4bfe-08dd52612c60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?lrcWifRRusm2NYPqjFsgFVM0JYajLbrrkAeTgAseHkDHKRBpqjLTQAlGVCm0?=
 =?us-ascii?Q?r2difk8LK5okfRzGv2dZwpN3BTA9eigUf/V72kHPI1JfteAtbCXbvSA7rSs4?=
 =?us-ascii?Q?sc5Qib1/AL3Wo0eeBKvN9Hm3S3xDI6lL0m8oeppPN7mpB+dAYxgvdoQJRUML?=
 =?us-ascii?Q?CgZ62073Amg32hLDfeZiuPmcZB9rf9rxpKD3ISKZApaPq7puIsYiDr+B59m2?=
 =?us-ascii?Q?rhd7ky4xVp3qR8wPI1bN3nl4WXHAJfFBs8ojCfIVomkaJEMgLahDUkx8q1yk?=
 =?us-ascii?Q?6Eumgbor/rH0rl0kzduyAFH4G/yNMyi69XJHxCZxGWz8qO6FWqmAkMlSL/H6?=
 =?us-ascii?Q?YSTBjqzkIYq6cjbZqrPKviR4Ive1/meBHu9eWSL9QB8xnBnm4Uf/xrtiagB0?=
 =?us-ascii?Q?qT71p+PwRCtWWe+nlOySWfDWoSU+FCRiZv9uj4hsnNBygRX+MT9hz/Ei8rv5?=
 =?us-ascii?Q?smE8AKjkqlXUhRfjHJPiL+0UJqUhHF/l4aWDRG2TBSxpAmFTvEhue20J9RTO?=
 =?us-ascii?Q?MwAqOvNIE6DK12QzwoGD+/vVJNSzdMEeSJ7bsQuYI6+3WYVNFKpjOf30LPUq?=
 =?us-ascii?Q?wRA3GX1zAHJ+GTxBGXR0Bs3iFq31+b7mKQi0x3iR1nWHd3YvkJ7EE9uWD/zP?=
 =?us-ascii?Q?ZESl1d5IvK7cbp81UMfo5SqUMd1Wsv2qrr7mD6svjuP8dOAXk+cB6fBZ964q?=
 =?us-ascii?Q?JkbPoZ0nR920spKb9gTrshFf8O7gOYZCf+VZ40kTEgiOhfW+PcyXKOk3ZGD7?=
 =?us-ascii?Q?GX4Y9v9Rfydt2kQ0asxCC+vzdx0LhcYVc8wkpf/vlZ0yzscey/OMhdSWUN9C?=
 =?us-ascii?Q?/Lt2VZimSjDsAr6MvscRdlDZaTGuJ4by08/oAzyxAG1yU3kN+Vy4UhycsQQD?=
 =?us-ascii?Q?bjZJVtyoVp1/DeeHakmyDO/fp5ceehk8oObwH04WqAI8ByoV1HdIAtYbwNEp?=
 =?us-ascii?Q?Fep4uxVab1xkVsGQdL/PoZnJY5vrSkYTK8viShQ/JW/PMcOrl0k72RywuNwY?=
 =?us-ascii?Q?5xVEhdqSZLzz1nPNOsOJpa+oKkhlhUIfUnSmGPSuXQVVc/jUuWSvJAqZWIET?=
 =?us-ascii?Q?+JxQteVXwZVfwU0kaQy3X+tay5yO+f+6tFMZ6wGj2A7rWwgpsXgK32PONBs0?=
 =?us-ascii?Q?iclh4WFas68nPmEX1bCcLJJ8IT4uL8RHZf9obmQeSmpOgpf1DEOMz0Uh5QhX?=
 =?us-ascii?Q?2fOXdEz8Fw/g+6zX6hrY/p4wuUioW4zBMMaOTEyD2KmrIoooPNQNp/0OrHHx?=
 =?us-ascii?Q?NGrlW8UpSfSnzdwlAvC8mTZJvxK+E8xA73/2x1PVFhUD7EMODtvBMpoWtA9R?=
 =?us-ascii?Q?/vE4Rn2kOL/src2FHJ1YLVktq7qa6DSgfFuyHGVlTT3I8CSvrYYvMWLaAHqE?=
 =?us-ascii?Q?96Q8Vu3YgfSfZ644n6m+wAaczsP+lLAtsPwtyL3DY3FAKlZTsnYNEIc0t6fT?=
 =?us-ascii?Q?7qJt1cl8f6msGp9YpiBCQ6rGv0KJAI8j?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F8zNuI4VXwi7+Vca2559oERU0fwHpsF2tncyc/0Ua9S9lnl2p7gEruPk71ZA?=
 =?us-ascii?Q?I+142iJXLDl5VortVwMDuVg89Iv6KTdSQWv3WxSsifuNUBjha2sxOu8nLGw7?=
 =?us-ascii?Q?tv2BHAkAAtMs022Ltn8yrKFSMOUlPFHt/l1vvFrqEoLuERfQUnoY4nMdkB1R?=
 =?us-ascii?Q?4aVO0OzBGp8q+KS0bTHUbxWL88H9LAZBbjfUwYRyJdcSvG9nYHESu23PVl89?=
 =?us-ascii?Q?f0AOEM5q+ZZgahQhhS7rBzPZB2JLGZpRDbBW7f0LIWwO1d3Kn0L4tQnNBNSP?=
 =?us-ascii?Q?a22MjE5FBQgXwXlH8mBYOtiXw9jexQb97QmcP+Wt7eC7mGF3iORegpxR2xO5?=
 =?us-ascii?Q?gb0BRFtueXbvNsP+U9ft4pnC6F7dhpLTKm7g/cMjvH2+NOHZWI1NVayg+07W?=
 =?us-ascii?Q?1kNncym33Iu0UHQHJO8qWDHlKQLizRblGPmxEUWYLnsyqaeJHgyvwfK2NVwE?=
 =?us-ascii?Q?ciWGbW2wS0HyfHc6HtD5hXJZNscsl4QXkvjjT9d3QOowx1wuUU11H+9A5Cd3?=
 =?us-ascii?Q?+1ZmHNn+2wHldU8NEh1WjSZnrsLfzGMm478VgjCljYVYwbeIZbpplQLixcG7?=
 =?us-ascii?Q?Klbpx44vE3KB/CNNrSw5carWJRBY265+O8axzIBRR9YM4eNCdPsqRfw8lK3R?=
 =?us-ascii?Q?VpDHy1oeKxhvLcpbrzLW8Yq9AQo/f/mwKOa1twZCUgw2TILWCQ6VkgiNCX2i?=
 =?us-ascii?Q?dU++khfWrUH2Ac2BldF9vlgIfaYs5HjY2vhTiqsQCRWPJ3MZU/v9qJlc7cnO?=
 =?us-ascii?Q?nvDmKlWgsjiHEudBXGOGVVGsWSHZ7TI7gMl3FUp8Btwv7C++t/YHbt+vSGCn?=
 =?us-ascii?Q?SLjD/DLHaIbXRBFhWv24Q91Z/Qhq//z7e7jPZMCjwnqNJxW2TJZKqDD0K0yn?=
 =?us-ascii?Q?2Tak05esZ4MBVf1wc4DZXVupvnZj6DMcOm1q/CPTcq5/hkpOH79kYuGkZRFh?=
 =?us-ascii?Q?NG8uaNYjoiOaWOyS4N88hnY0YLID2KASQuL/HCDHCaRm0e/+Yh9hbJAK+JPk?=
 =?us-ascii?Q?JWFp8zw/9A75bX1lexx2G63VsIuyVZD8FQK18atgyF7/Aheb4uDxms+j+O9i?=
 =?us-ascii?Q?mbJAX6AliXMYppV7wnTz6CZREzFvD3c11ZrgA+NhPFz90QxymfSEquErPoBx?=
 =?us-ascii?Q?0wqFjAbD391/miMJ40H63w+POPX/t/WZEa1CLujwc5942iRGNErTL5gYMoqJ?=
 =?us-ascii?Q?vQvQ5GC7OezggRiCyICLLk6+ul4ibdCQYY3p79ilEe+wYXnIGiN2YhqCPYL5?=
 =?us-ascii?Q?LjBSujN69jJEwcpyhdVmaKl8uHGrXkg0luh0HBj53B0dXbyARx89dlWOqWYW?=
 =?us-ascii?Q?H6WNc/cGB4uJQmXSJzBXsxe18Y58PuKsWAhfAKlLzXLY5f3/qykeLHNvsGAd?=
 =?us-ascii?Q?SzXj1w/0WqfwQVcyN8Z6lc2GeTpqYC35lJM/Q62kPloH/cpyymGxG0aBvdxA?=
 =?us-ascii?Q?uskNskMkChuSLGVdKeNW8rm1V+wLJ8LXh/yDFM7nnMGJUZbskmYAVuZHGwO/?=
 =?us-ascii?Q?baYU7sfynf0lzx/otT6jMnNpzslF5fQx4GoUEx22Ae+ZbIfWLfFGlzGml+8a?=
 =?us-ascii?Q?4KNhL+wkoe2FaXZY0T4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1420041d-5006-4a37-4bfe-08dd52612c60
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 10:19:06.5869 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gqBXCz+TZ5rLb24dbP/70Ws4/g2x4KZ35/WkX/Qc87kwXT4FUVYzvAdCX12ujb/9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8068
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

[AMD Official Use Only - AMD Internal Distribution Only]

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Friday, February 21, 2025 11:19 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu: Change page/record number calculation ba=
sed
> on nps
>
> save only one record to save eeprom space,and bad_page_num =3D pa_rec_num=
 +
> mca_rec_num*16
>
> Signed-off-by: ganglxie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 49 +++++++++----------
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 17 +++----
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    | 20 +++-----
>  3 files changed, 35 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 439841a2d1c2..c0e3d73bdc7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2985,24 +2985,14 @@ int amdgpu_ras_save_bad_pages(struct
> amdgpu_device *adev,
>
>       /* only new entries are saved */
>       if (save_count > 0) {
> -             if (control->rec_type =3D=3D AMDGPU_RAS_EEPROM_REC_PA) {
> +             for (i =3D 0; i < unit_num; i++) {
>                       if (amdgpu_ras_eeprom_append(control,
> -                                                  &data->bps[control->ra=
s_num_recs],
> -                                                  save_count)) {
> +                                     &data->bps[bad_page_num + i * adev-
> >umc.retire_unit],
> +                                     1)) {
>                               dev_err(adev->dev, "Failed to save EEPROM t=
able
> data!");
>                               return -EIO;
>                       }
> -             } else {
> -                     for (i =3D 0; i < unit_num; i++) {
> -                             if (amdgpu_ras_eeprom_append(control,
> -                                             &data->bps[bad_page_num + i=
 * adev-
> >umc.retire_unit],
> -                                             1)) {
> -                                     dev_err(adev->dev, "Failed to save =
EEPROM
> table data!");
> -                                     return -EIO;
> -                             }
> -                     }
>               }
> -
>               dev_info(adev->dev, "Saved %d pages to EEPROM table.\n",
> save_count);
>       }
>
> @@ -3018,7 +3008,7 @@ static int amdgpu_ras_load_bad_pages(struct
> amdgpu_device *adev)
>       struct amdgpu_ras_eeprom_control *control =3D
>               &adev->psp.ras_context.ras->eeprom_control;
>       struct eeprom_table_record *bps;
> -     int ret;
> +     int ret, i =3D 0;
>
>       /* no bad page record, skip eeprom access */
>       if (control->ras_num_recs =3D=3D 0 || amdgpu_bad_page_threshold =3D=
=3D 0) @@ -
> 3032,13 +3022,23 @@ static int amdgpu_ras_load_bad_pages(struct
> amdgpu_device *adev)
>       if (ret) {
>               dev_err(adev->dev, "Failed to load EEPROM table records!");
>       } else {
> -             if (control->ras_num_recs > 1 &&
> -                 adev->umc.ras && adev->umc.ras->convert_ras_err_addr) {
> -                     if ((bps[0].address =3D=3D bps[1].address) &&
> -                         (bps[0].mem_channel =3D=3D bps[1].mem_channel))
> -                             control->rec_type =3D
> AMDGPU_RAS_EEPROM_REC_PA;
> -                     else
> -                             control->rec_type =3D
> AMDGPU_RAS_EEPROM_REC_MCA;
> +             if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr) {
> +                     for (i =3D 0; i < control->ras_num_recs; i++) {
> +                             if ((control->ras_num_recs - i) >=3D adev-
> >umc.retire_unit) {
> +                                     if ((bps[i].address =3D=3D bps[i + =
1].address) &&
> +                                             (bps[i].mem_channel =3D=3D =
bps[i +
> 1].mem_channel)) {
> +                                             control->ras_num_pa_recs +=
=3D adev-
> >umc.retire_unit;
> +                                             i +=3D (adev->umc.retire_un=
it - 1);
> +                                     } else {
> +                                             control->ras_num_mca_recs +=
=3D
> +                                                                     (co=
ntrol-
> >ras_num_recs - i);
> +                                             break;
> +                                     }
> +                             } else {
> +                                     control->ras_num_mca_recs +=3D (con=
trol-
> >ras_num_recs - i);
> +                                     break;
> +                             }
> +                     }
>               }
>
>               ret =3D amdgpu_ras_eeprom_check(control); @@ -3452,12 +3452=
,7
> @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
>               return ret;
>
>       if (!adev->umc.ras || !adev->umc.ras->convert_ras_err_addr)
> -             control->rec_type =3D AMDGPU_RAS_EEPROM_REC_PA;
> -
> -     /* default status is MCA storage */
> -     if (control->ras_num_recs <=3D 1 &&
> -         adev->umc.ras && adev->umc.ras->convert_ras_err_addr)
> -             control->rec_type =3D AMDGPU_RAS_EEPROM_REC_MCA;
> +             control->ras_num_pa_recs =3D control->ras_num_recs;
>
>       if (control->ras_num_recs) {
>               ret =3D amdgpu_ras_load_bad_pages(adev); diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 87fcdda3ec61..ab27cecb5519 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -727,11 +727,9 @@ amdgpu_ras_eeprom_append_table(struct
> amdgpu_ras_eeprom_control *control,
>                                    - control->ras_fri)
>               % control->ras_max_record_count;
>
> -     if (control->rec_type =3D=3D AMDGPU_RAS_EEPROM_REC_PA)
> -             control->ras_num_bad_pages =3D control->ras_num_recs;
> -     else
> -             control->ras_num_bad_pages =3D
> -                     control->ras_num_recs * adev->umc.retire_unit;
> +     control->ras_num_mca_recs +=3D num;
> +     control->ras_num_bad_pages +=3D num * adev->umc.retire_unit;
> +
>  Out:
>       kfree(buf);
>       return res;
> @@ -1396,6 +1394,8 @@ int amdgpu_ras_eeprom_init(struct
> amdgpu_ras_eeprom_control *control)
>       }
>       control->ras_fri =3D RAS_OFFSET_TO_INDEX(control, hdr->first_rec_of=
fset);
>
> +     control->ras_num_mca_recs =3D 0;
> +     control->ras_num_pa_recs =3D 0;
>       return 0;
>  }
>
> @@ -1416,11 +1416,8 @@ int amdgpu_ras_eeprom_check(struct
> amdgpu_ras_eeprom_control *control)
>       if (!__get_eeprom_i2c_addr(adev, control))
>               return -EINVAL;
>
> -     if (control->rec_type =3D=3D AMDGPU_RAS_EEPROM_REC_PA)
> -             control->ras_num_bad_pages =3D control->ras_num_recs;
> -     else
> -             control->ras_num_bad_pages =3D
> -                     control->ras_num_recs * adev->umc.retire_unit;
> +     control->ras_num_bad_pages =3D control->ras_num_pa_recs +
> +                     control->ras_num_mca_recs * adev->umc.retire_unit;
>
>       if (hdr->header =3D=3D RAS_TABLE_HDR_VAL) {
>               DRM_DEBUG_DRIVER("Found existing EEPROM table with %d
> records", diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> index 81d55cb7b397..13f7eda9a696 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> @@ -43,19 +43,6 @@ enum amdgpu_ras_eeprom_err_type {
>       AMDGPU_RAS_EEPROM_ERR_COUNT,
>  };
>
> -/*
> - * one UMC MCA address could map to multiply physical address (PA),
> - * such as 1:16, we use eeprom_table_record.address to store MCA
> - * address and use eeprom_table_record.retired_page to save PA.
> - *
> - * AMDGPU_RAS_EEPROM_REC_PA: one record store one PA
> - * AMDGPU_RAS_EEPROM_REC_MCA: one record store one MCA address
> - */
> -enum amdgpu_ras_eeprom_rec_type {
> -     AMDGPU_RAS_EEPROM_REC_PA,
> -     AMDGPU_RAS_EEPROM_REC_MCA,
> -};
> -
>  struct amdgpu_ras_eeprom_table_header {
>       uint32_t header;
>       uint32_t version;
> @@ -100,6 +87,12 @@ struct amdgpu_ras_eeprom_control {
>        */
>       u32 ras_num_bad_pages;
>
> +     /* Number of records store mca address */
> +     u32 ras_num_mca_recs;
> +
> +     /* Number of records store physical address */
> +     u32 ras_num_pa_recs;
> +
>       /* First record index to read, 0-based.
>        * Range is [0, num_recs-1]. This is
>        * an absolute index, starting right after @@ -120,7 +113,6 @@ stru=
ct
> amdgpu_ras_eeprom_control {
>       /* Record channel info which occurred bad pages
>        */
>       u32 bad_channel_bitmap;
> -     enum amdgpu_ras_eeprom_rec_type rec_type;
>  };
>
>  /*
> --
> 2.34.1

