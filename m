Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980EBC83F1D
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 10:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 458B710E57D;
	Tue, 15 Jul 2025 10:03:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2hzXSqBF";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FFFC10E57D
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 10:03:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1MPfARgOZunwJB/UUIUMXChTg5G1ETqiYJaEzdbPcT2NErnHIv+aIm9vJOYuWk/HStqqgH0XVk4cwVkuVA6vGuQP3MplsKnyKWSDyyYdEJhSh7LGoVjAkbAuOI5UCTjQhM6aHrXJXNCf8EI6pa2f4nBXKJXWX6mrNqckwtpf6NaYiHokFyjo6kn6vuHa0x3YlnGsQ4ygTPaemzdUoBLQlopXkhAt288DtoAEvxJtI5cL76dby8n7oYQg65oxmbE78F+hIEKIY8xCJjYV7/0hHwdJUU4bNl3fE6zdNG32sAeqX1y9tptXxRj2OsCP/CxkGdGkC1z8Dgm8pLYkOHBPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6ss8QEMEkkm0eTCH8V7ldjaY3buMhLlZLTRTWkDT3E=;
 b=jOOMgKh500Vuoj5XUqYFcC+7YWZRJ4ltZouGuXMEDy26xznnCsIyLlRUYrkiKHSACOUUgwMxKWAFsTFBqitpiT0elb0XKMI+cfM5wOb7182SU2Kld60NkRimbPtQGP14MZkb26EXoiSni7XIHNDk7ySR/fv6VlY6/mikulr32GATgxOlzeW6Cm7Neki2bx42ulkTqKSkTMInvuf41tw6L8WOuE4BJBwxm06MyVLvNh/pCghQ1DdQr+1HAyjFuwG51HhwSwI5keQbaGuH0OsPfQ3k/fzbaXXu2PSIYWBDqEZzfuLSup0dfbfWn+OunDIrV0o+eQVfHgGiJEHGpp4coA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6ss8QEMEkkm0eTCH8V7ldjaY3buMhLlZLTRTWkDT3E=;
 b=2hzXSqBFQi+GG3IYSodXbXpf9M50GDH5GOCl/YiXNmjhPLPNtNLfOTI5HIrkEPqEBp+R359NMQBQ7g7b9vPCCXQpr79gwO7vps/2G9Qq0ULkXPiAYK6aAw3UoN8j4kEu9O9I8l4NQz0yREIrT8yIQRtEKeF/SgtzZVtjVQOeWIM=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 10:03:00 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 10:02:59 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: add range check for RAS bad page address
Thread-Topic: [PATCH 1/2] drm/amdgpu: add range check for RAS bad page address
Thread-Index: AQHb8kMQvRd0oe3lSEy8XW8Wb01GybQy2kKA
Date: Tue, 15 Jul 2025 10:02:59 +0000
Message-ID: <PH7PR12MB879635CB6FAE3BF3A7AD7C33B057A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250711090604.9809-1-tao.zhou1@amd.com>
In-Reply-To: <20250711090604.9809-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-15T08:06:38.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|PH8PR12MB6674:EE_
x-ms-office365-filtering-correlation-id: f0a446b9-eb99-4fe7-f0d5-08ddc386c791
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?YLh/iV9u26kiScEZLNDYUwmeLaBz1m83jK7mN95xBOizQEa5I9sIwBGf1CZa?=
 =?us-ascii?Q?IpZPSSvWRDuldjILx5B/NSLMI77dAf1l/zmOD6evymeQKanc/XMGO5qF0pxc?=
 =?us-ascii?Q?zsm4EJFsvFv1+w0yLlUvRW3e1DybFala+Vuv/0UuKRZjKzfXlLXO3QT24b0v?=
 =?us-ascii?Q?htf08rj+Ynll4TQoggAzHmX1EwUtVPnEAXvO0rGiRHvwhlEkpOc14DIYlNaW?=
 =?us-ascii?Q?dvhVTuketbWjJLbupZAMTjMGnsUk6Ma4wKeL3YXiuVOYVGtg7rx8irrVlPaq?=
 =?us-ascii?Q?GSqFr6B5bNVPOTv0GRJyuzlxtbhl5O1CuEQvWJbpofWYkDoU03ezixdG88et?=
 =?us-ascii?Q?m3mQ0s1fXCAxPzFoJxaxqOHd6Doa5OBBJn472H4IL3cRywRWe2aCcaMiZFFe?=
 =?us-ascii?Q?ss3iCMviWNu1/kUrVHoSa6Tq9Xd5Q1TBiNxI3r9f1lYqKtUGbSB2zIAjvFdR?=
 =?us-ascii?Q?06A6yiaIww+Vr1IZg6LW/aaFZPXl3WbqhFZC74qxmShwTeaIx9Wg6qiWZAyK?=
 =?us-ascii?Q?uwImOsKDgq6wGv+l3VIe6UoKsiVNpmdYRxGDcvgmafliKiLCFsH/wMHXK+ZQ?=
 =?us-ascii?Q?SK/MKFiIluX8j0hX4CZsGAy6dcD5e59GqkzslYx6cHcKBfyHyOPGVvdmiPAl?=
 =?us-ascii?Q?Vgo3TAAHvCcBJG4rZCJq5NKrIP4ecBPLT/eqBkkJRjSe2J6fu5hVTrUIvyrz?=
 =?us-ascii?Q?Ay1mle7jn8ARUlYeCV7a4KD+R2OCScwIpQr7WNo+3jxaUAcXIYRTMVa6U/6C?=
 =?us-ascii?Q?fJNBYVRLhmf1XLcDMX4mhpkRtALFJ30AFA3yGQphe/QfLUctZwo6NHjQ8xow?=
 =?us-ascii?Q?SvKTefPifppG7qsZzaiKwoNxNHnbtmxKlU0j+5/NhU+C6lBbGdVAewDgNg6Z?=
 =?us-ascii?Q?DAPIPWdvkbLPhhSX/kwAjOyrXYHi42j9DWMBSI639TRLmIMhBaPIIqOLefhY?=
 =?us-ascii?Q?0CbMYNUfTgvqeHpKWXXQArxx5hY8iS1WNd6Jvrxq1BbuW0ZvafaKmV0o/IUN?=
 =?us-ascii?Q?5Aa4AK0DdrQBkgQbBhrv56JZAsIF03W9jtJEhhnNzBzs4LQ0GCXB0agZmNjQ?=
 =?us-ascii?Q?qEqZ1jr5POYbqg2+ICe/LBTs6eDsjFzrWPXoyabMAZjL9IOAkjfepN4SOc9I?=
 =?us-ascii?Q?8IdDAvAcBeC+WHX3Sjcbw2km4pkIX3vXZjeuZQtmHRnsAf9NMKf7q1WEGXpd?=
 =?us-ascii?Q?fCRW3Qp2A9Vki8boysQyWgVZ8tEMOnPPUR3nK3WNYczQAtgOucCUcDc7gBMg?=
 =?us-ascii?Q?/FpR3yh4dUCRbAdUtwrjOUFiRqbm6G96JnCCFfwgGGQTFKJ2n8QjCXypbQCw?=
 =?us-ascii?Q?E6ir77WTnlcjJjWtdrweQ/jkwETV1pGdRAkOOCr5M+7rdXFV21OfByfWkG2d?=
 =?us-ascii?Q?HlSH40CXVG6bHG3PBrbmAcK4l+ek6ztMGV78YdLy15v+gvxaYXq9czzJOQob?=
 =?us-ascii?Q?9LwVLPBdoWr451+BAmbKbYZ9BK9dibQe9kfp/Hb/ZCkniFRfFkE3qw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?acJZ3zJCfetMdRVbGjIFMs6g5rRDrOLZVuGGbBOoeMvadj2pRx1x82xFKAKh?=
 =?us-ascii?Q?H3CGjGwdsm8Sw4m5EUeVCTcXnu8fjpVQa8FqCIuV7ju5nMdY5d+wZ2EUrCtf?=
 =?us-ascii?Q?p5FVQ36ysvTjqnkOmWqIDozSQfrL1lhj8MaTQEoYCDTeNMA1mnNIyiMjw5f2?=
 =?us-ascii?Q?Q0VuxtoTTVdxzn60+JKVI23tauJ2sta85E4WIcNEEnfsSikv02LpJqdF6R3S?=
 =?us-ascii?Q?Tfae4uWcmYlizr04wkbWM0LqXF6aBe+TwhZ4GpGdPWPy00D7wtyggwuvu6TR?=
 =?us-ascii?Q?aA5Nh0hKOAXNXD3cl1v9kwE9S+C5loaxh/LqkI1KMTwDVG30b9gJJcv7JZm1?=
 =?us-ascii?Q?kAciVQYdSlsiII0T8YwhxGUPeU+JF2Uj0T/AtfWhlbJ44WV9bPOXqUDaox6w?=
 =?us-ascii?Q?mY6sYn9vW2euwGVptvtqUIAIg7H7FuOe49jtTq7wdDzQCCcoPbc5dmPRSYQK?=
 =?us-ascii?Q?IpeMzwirtC/4FNpQKJBknoK40Ucsubix7pw8GgaBD5zN7c7Szh9obXICqGmW?=
 =?us-ascii?Q?9IkzqE1Qu65zm8f+4vC/YnzoK6BmxltvgcUv8NQioK3otw0KIV1oKMsj/QJH?=
 =?us-ascii?Q?NYugHANHAbWhG9N87a8TfpN9mxKl2vLhiFKxT7kzdG/uzVAy/O6Yna7JHJXF?=
 =?us-ascii?Q?OD7Q9yK2BwcCxnkhlnNo2uUgbLkHWQodkeUfKKbfJWrZS8X2O1Nfj9JtA8cH?=
 =?us-ascii?Q?hALt8PAFB2qXAirqsVc0qym5+oL5WFMBICJoX7l6p+bMvag0wvw/SL4S0VL8?=
 =?us-ascii?Q?G2oJCFfnukyXffRs2osqZYuPpA9T5S7uIaTlsjstNz0OvjNbvy9aVfMFbxt8?=
 =?us-ascii?Q?thFFZa4tYsfFl3ioT8iGFuWEVSxP3iGmNxDsY4dNplwg1wmMmVPWZ0ylvTJq?=
 =?us-ascii?Q?/xSC+kv4Z+dezhw/CqJND3wQZh/lpXKtbq2gATW9/QA5gip2d5e8GcqL9640?=
 =?us-ascii?Q?ibm8BE9EJPIFIpXEa/TaO14wk2klzHwtnwSY8Hh+ii9IMQI+4bofbUoEMlwd?=
 =?us-ascii?Q?65NojnG24mTjxPu3/NvjiapPEp5io5WI9P8HcqEsAIIn2+xPYs8zj6mCXqdK?=
 =?us-ascii?Q?MsTfp3qAQtQctO+L72bnAuy9pSd0u6TCU/hOs+5cdLCx20VGCabTlT0ame+F?=
 =?us-ascii?Q?IZRW9g+5do0ErR1TZ7eJGtcU7Q+kDsbWzik8MjSs8sY/40Bv3eQnlMnVEAb+?=
 =?us-ascii?Q?eLp9p2KJQpwXUbgAfBCoG/fQKrB8Y/gZN39UVaNyEI7GzPzAIl4vZ8YbNfqB?=
 =?us-ascii?Q?0nVj87DGXpkqsIzuLYnrTVjYVipP9JiQyM31hWjGrhGDiYwfcgJXqOzwZ21G?=
 =?us-ascii?Q?CqP2PQ+WVtKdpkrTLW1EYW8TLxh2ofinxKrSaUIFJ44eZEYaNgAH5QnNEs57?=
 =?us-ascii?Q?xbN6IP5nEdnBh6ri4r6B5C00YeWmfGQf2Hz4scYXWSjEc0hjOPWt573alff5?=
 =?us-ascii?Q?ZJRxxmynz+FyFYxH5x8+QdiXJ2UmXX9L9fMIjZwAE997IDKKkZOkwYtfFOux?=
 =?us-ascii?Q?QXAXq4kMCldifKhaYA0ixdSc4rWooM48J59Z40uCqIeO+iHbekrMfphxXpFR?=
 =?us-ascii?Q?FOq5Pyz5L5QRWV3ob4A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a446b9-eb99-4fe7-f0d5-08ddc386c791
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 10:02:59.7394 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vh3wvymwb9P2hFQ0BxxsyAeqCuy24v6gxqgELO/3wixOHpBtaZdUd6DxJyVXcBwt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6674
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

Ping for the series...

> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Friday, July 11, 2025 5:06 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: add range check for RAS bad page address
>
> Exclude invalid bad pages.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 58 ++++++++++++-------------
>  1 file changed, 28 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index a6f512293b5c..1d6d4625abb3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -136,9 +136,9 @@ enum amdgpu_ras_retire_page_reservation {
>
>  atomic_t amdgpu_ras_in_intr =3D ATOMIC_INIT(0);
>
> -static bool amdgpu_ras_check_bad_page_unlock(struct amdgpu_ras *con,
> +static int amdgpu_ras_check_bad_page_unlock(struct amdgpu_ras *con,
>                               uint64_t addr);
> -static bool amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
> +static int amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
>                               uint64_t addr);
>  #ifdef CONFIG_X86_MCE_AMD
>  static void amdgpu_register_bad_pages_mca_notifier(struct amdgpu_device =
*adev);
> @@ -169,18 +169,16 @@ static int amdgpu_reserve_page_direct(struct
> amdgpu_device *adev, uint64_t addre
>       struct eeprom_table_record err_rec;
>       int ret;
>
> -     if ((address >=3D adev->gmc.mc_vram_size) ||
> -         (address >=3D RAS_UMC_INJECT_ADDR_LIMIT)) {
> +     ret =3D amdgpu_ras_check_bad_page(adev, address);
> +     if (ret =3D=3D -EINVAL) {
>               dev_warn(adev->dev,
> -                      "RAS WARN: input address 0x%llx is invalid.\n",
> -                      address);
> +                     "RAS WARN: input address 0x%llx is invalid.\n",
> +                     address);
>               return -EINVAL;
> -     }
> -
> -     if (amdgpu_ras_check_bad_page(adev, address)) {
> +     } else if (ret =3D=3D 1) {
>               dev_warn(adev->dev,
> -                      "RAS WARN: 0x%llx has already been marked as bad
> page!\n",
> -                      address);
> +                     "RAS WARN: 0x%llx has already been marked as bad
> page!\n",
> +                     address);
>               return 0;
>       }
>
> @@ -513,22 +511,16 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct=
 file
> *f,
>               ret =3D amdgpu_ras_feature_enable(adev, &data.head, 1);
>               break;
>       case 2:
> -             if ((data.inject.address >=3D adev->gmc.mc_vram_size &&
> -                 adev->gmc.mc_vram_size) ||
> -                 (data.inject.address >=3D RAS_UMC_INJECT_ADDR_LIMIT)) {
> -                     dev_warn(adev->dev, "RAS WARN: input address "
> -                                     "0x%llx is invalid.",
> +             /* umc ce/ue error injection for a bad page is not allowed =
*/
> +             if (data.head.block =3D=3D AMDGPU_RAS_BLOCK__UMC)
> +                     ret =3D amdgpu_ras_check_bad_page(adev,
> data.inject.address);
> +             if (ret =3D=3D -EINVAL) {
> +                     dev_warn(adev->dev, "RAS WARN: input address 0x%llx=
 is
> invalid.",
>                                       data.inject.address);
> -                     ret =3D -EINVAL;
>                       break;
> -             }
> -
> -             /* umc ce/ue error injection for a bad page is not allowed =
*/
> -             if ((data.head.block =3D=3D AMDGPU_RAS_BLOCK__UMC) &&
> -                 amdgpu_ras_check_bad_page(adev, data.inject.address)) {
> -                     dev_warn(adev->dev, "RAS WARN: inject: 0x%llx has "
> -                              "already been marked as bad!\n",
> -                              data.inject.address);
> +             } else if (ret =3D=3D 1) {
> +                     dev_warn(adev->dev, "RAS WARN: inject: 0x%llx has a=
lready
> been marked as bad!\n",
> +                                     data.inject.address);
>                       break;
>               }
>
> @@ -3122,18 +3114,24 @@ static int amdgpu_ras_load_bad_pages(struct
> amdgpu_device *adev)
>       return ret;
>  }
>
> -static bool amdgpu_ras_check_bad_page_unlock(struct amdgpu_ras *con,
> +static int amdgpu_ras_check_bad_page_unlock(struct amdgpu_ras *con,
>                               uint64_t addr)
>  {
>       struct ras_err_handler_data *data =3D con->eh_data;
> +     struct amdgpu_device *adev =3D con->adev;
>       int i;
>
> +     if ((addr >=3D adev->gmc.mc_vram_size &&
> +         adev->gmc.mc_vram_size) ||
> +         (addr >=3D RAS_UMC_INJECT_ADDR_LIMIT))
> +             return -EINVAL;
> +
>       addr >>=3D AMDGPU_GPU_PAGE_SHIFT;
>       for (i =3D 0; i < data->count; i++)
>               if (addr =3D=3D data->bps[i].retired_page)
> -                     return true;
> +                     return 1;
>
> -     return false;
> +     return 0;
>  }
>
>  /*
> @@ -3141,11 +3139,11 @@ static bool
> amdgpu_ras_check_bad_page_unlock(struct amdgpu_ras *con,
>   *
>   * Note: this check is only for umc block
>   */
> -static bool amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
> +static int amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
>                               uint64_t addr)
>  {
>       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> -     bool ret =3D false;
> +     int ret =3D 0;
>
>       if (!con || !con->eh_data)
>               return ret;
> --
> 2.34.1

