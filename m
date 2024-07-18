Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB43C3DA60
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 02:51:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 477A310E02B;
	Thu, 18 Jul 2024 02:51:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Syrule6V";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B396810E02B
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 02:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9gUzmt3G/9j3riGybNzZDQwh0o2ujgo3KzpEbokMBNdkGXlL2Lr2f39njOcIrxQ3Z89Z58b9XPnwcoxOWptJGDLS1dfVHjydwF3cDBuT335sXhFVTwXEvUEjCx0DedKy/APXu3BBTgZo1ncD3TYk96OBux7Yf8kl+JMKSkgzA6F7k4B0oCoIU0tV7Y6JEjMl1E5z2cX8VTH0pxIiJNRfJJDPJmcwk2xaGtqVDl2isAapeZCtSauv+bO1EUIDOczBPQtswMhldmFNhVSnd+/BhAF/xzDBnzs3E74RGlVOw7YmQauKvJ/IJuJwv95vVH24rssPQNFrsmqZtzzkRKYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpEDf1QeQQKRvz1WRWV5FZz/0/OJZgVd5F92iokphm0=;
 b=SpCyW6frb2kwYEaPVCOQQkwcSQ74rYvOOAUp39kglA9SGqQNu6JFqsixxu5PDFoYyU/AGR044ZFd94AZKQhl35FF4ytXCDUDggUPoa2hFDABObGqd/WQ7X4rr/rPIU7X3vEFWdcwFPnZJAB6LXA8MSaej1LdYsqTqKLYpuyABM1qyn6C0diPabqS0GPvcxHU3ItL9l9EcsiuytLPlOGgJdVOemw0b8vziSFvSgxRvmnUoyYN7lQr7CqJx4+7GIJ2b2to3EVoc+XvyarLQMcG7GgjhLa0k6ozSgT4XPW0qn6zipouSjeS8WQb+lbzIPXjw4gEKJNdoyAJ1ZaKTt4wjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpEDf1QeQQKRvz1WRWV5FZz/0/OJZgVd5F92iokphm0=;
 b=Syrule6Vswivp2PM00bVblZCE0t0FFnPPSzRzdFt86d9k3+A51Hr+mqeqS9FOjLvIi66tIseCDnG18smEucuA4LyeAP9a45K6wJOEJcAdWlD/YGoxfRtde48u6cAOZtuzSjuKOW8c83NVGXLdAO/XHkjMPKHUHX38tNo2SbUsCc=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CH0PR12MB8507.namprd12.prod.outlook.com (2603:10b6:610:189::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Thu, 18 Jul
 2024 02:51:09 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.7762.027; Thu, 18 Jul 2024
 02:51:09 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: optimize umc v12 address conversion
 function
Thread-Topic: [PATCH 1/3] drm/amdgpu: optimize umc v12 address conversion
 function
Thread-Index: AQHa2CGXpYyPaoI6Yk6zsEpqWx4CKrH7yKug
Date: Thu, 18 Jul 2024 02:51:09 +0000
Message-ID: <PH7PR12MB87962BBBFF9F1E1B476077A9B0AC2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240717081547.224193-1-YiPeng.Chai@amd.com>
In-Reply-To: <20240717081547.224193-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a0b65814-a6c0-4b21-bd07-b3d6f3d9d7a8;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-18T02:44:52Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CH0PR12MB8507:EE_
x-ms-office365-filtering-correlation-id: 3ab55802-7f60-419d-52bf-08dca6d47a42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1uAg2LCQGorL8HnIFaxI70V3K2aAcv5becyWYeIXHmPwKAuyUzo6rJzrW4KQ?=
 =?us-ascii?Q?W5w9NGNXL4eA9lIFogLK++ZoLqO6Y/SpdL05CX8q7hxEEt90NALTUwfjoH9x?=
 =?us-ascii?Q?hNd8i6rTcSbo80I84V62OGFXo8EJy8FqDBKE+AkfxCT+J2cAwotTlqgvRo/5?=
 =?us-ascii?Q?2CCOclr5noj0QTRzyUpD/hicHfW4kUUplKvt/1pIv5T700N/XWAc3HJCVC2J?=
 =?us-ascii?Q?BGd/cx0UyD9ux9UuR8z1Q0Fems3boRwT2EIerYu7oArbDir+l/oXDpjs7ghb?=
 =?us-ascii?Q?KpwmQYgyHfIcTasgP/3PdDts2Pk9SrkoOKXuRT140zxuWWsO9SHGf5X/LXF6?=
 =?us-ascii?Q?VCBjYTxGdj4YnnGfA7THPqDpH7Jw6htXnkgPyFzCtkG3gidRtv7YPNWwxGXy?=
 =?us-ascii?Q?oWRaaQFO3vFK7HmeA/ihAJFpB+XohZ2IcaTOjNMZKZQ57bqFKzfIs1J3OZ1s?=
 =?us-ascii?Q?cSK3Xwhy8oaarRqqQ0IN61tN6fxweynfDZrUrOk3wmjYfaivEZT3jmhkMBm6?=
 =?us-ascii?Q?OlMF1AFqX+Jr0qkggjWVa+E407JvtIKKfWBgQqhl7cCt/DlwpEwyAG/biRQY?=
 =?us-ascii?Q?xiuNi2A0m2YXvaA1fnoxi0m1b1lUCXrj3hIFFI7qarhZiuGVyIED5+2bzGZl?=
 =?us-ascii?Q?ssyGbEvmZJC00N1ft6tPmyYJoRnEGlNQEahCgzP7jJYyzjDA9YLfF576S7we?=
 =?us-ascii?Q?FnKWs4Fc2cRjiAZhSZgRibn2O3KbUITzHrLOsbHFEjXP5qK1zAtTpMY391XH?=
 =?us-ascii?Q?W7y9xh8JMmFPViqSr2R8HZv3jn4hZyXHHkPZE8yYdS5Gc3WcjJ1RLePWni0i?=
 =?us-ascii?Q?5zG7xFPXbk63mBKK6uNvElm+iL7XuyxDPQDKwQvS4uL/76Q/lNhTi/efWHo6?=
 =?us-ascii?Q?5Xvu06pqjhZBxolakfBzIuGrWwNC7KxfZubhKdIoZU8cxZk0BTDFAYlc+57Q?=
 =?us-ascii?Q?x/DVr8dDiPX1SaF4rxAHX9zYoWMKeDjPfbDmhw9UyBDLLYd3IuPD7pJ8JU6Q?=
 =?us-ascii?Q?mwuYfaK7sG5Clo75l+ajdSA6ViR1BCkpn2U3CA6ssLCu9W0ujddLviUUu9wN?=
 =?us-ascii?Q?hzAK+oD0hkZMKyeg4y1polLmAD0HbrIzIuwUnlHl5yPVoCqhDhxW9IVcEThM?=
 =?us-ascii?Q?9H3WV9f+izwQYq+wMoczZrGKgfRyPIbrmF8Vgz8d0xpM37OVnlFTqpIePE+M?=
 =?us-ascii?Q?mQsP1GQllzAPuGTFBQ2oB7fbUN8ucjVgqr1fiBlAyOaLndfpYajPHg0pC/Y+?=
 =?us-ascii?Q?fkI0cPae/UWb3L5EOrcno9VSQc2Wa+3qy5XOU4aVdyGsEuHkTutMMZWdOIJp?=
 =?us-ascii?Q?ACSLv8jttyPCX55LNTJVCguNC76EMdX0x4wcvL97ZYBL9KE6iWXa4CmYuUXC?=
 =?us-ascii?Q?uRz33bG7HqmOk3i+SnVN7JZ1nk3XHMElZaloItEHULjENkbzeQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4jK3HtLXeq0dsZSWTeLqkiQ15oanEcyYcoU5brLzOp5pbQXixviIbRskpdvt?=
 =?us-ascii?Q?6IJ/NssWrTPb/cCnvtcIrMYtEdW6h8OFDJmQthj4m7vlhnvSlFLUbXUcbRns?=
 =?us-ascii?Q?RFM23kHpdecIYjK3Fm51wPGJVWU8sJjUxaDt6/AsviCFxUUSb61DPHuHRv09?=
 =?us-ascii?Q?20Xd+w4ZXVjEEWgQ14cQ8jLFaDMasQJOF7eWs8BUzWNvEsVQVxzuXSCC6Kx0?=
 =?us-ascii?Q?Y7hqxQkTGASpbHPiZGxkUymm2YipQCxNB1mOfghuHcrnf8uYQE4P0et/eETN?=
 =?us-ascii?Q?uwwjAvwP3QrYayLVrhLrwyW1206Gax53opOrHyo0aMc+xAIGKFPjSZNwWzqH?=
 =?us-ascii?Q?V6JB6pL7erFcG9NJ0/rE84M/dSw5K35/wMdWyMeMsBBN6wIq9frJc9ioxbON?=
 =?us-ascii?Q?mnOwYLEFvhTwFx1ma1MVdJj1EaA2RnWjz5HpGsmqtdWB4Nh/4ovkxysVsCCg?=
 =?us-ascii?Q?iVS0jv+Paz4LM0vM0kuB3HyJF4GQxSKpDlluRjSeAPwtc/FtIugF8hz4ei5e?=
 =?us-ascii?Q?lvWZv+3z+wac8Vr7L/jXITTYhJioCy486QwYAZ5IHwH0t+Rbw9z6h4HwGfyl?=
 =?us-ascii?Q?otcK2I6rDUK8Pf4ykQ25In6HyNKyXBheeVy9OLDJlaaO1PgeEx8tG6H7bl1Q?=
 =?us-ascii?Q?5OWOaYO8BzjCCqDKSbpBIMkSq+Rg84OTIYbVaqV7+roRejl3oP6osgWtltxP?=
 =?us-ascii?Q?l/AYYE9tYxjMc1FpitKBB7GHwi5LBpgilhy7xe/8R1BE6dYMAdYtxw/AxenP?=
 =?us-ascii?Q?PesCv+WfLmEdnn6KRAyU9ylVBJ3+uExa2aJ5aPsJoTlRWIcsrV10dOWSA4NF?=
 =?us-ascii?Q?Pp5hvdOyoIt+uX6F8GKF0nNMpG8Ggeu2D9aqrIwlectiB3Un9NejHfUeFpVr?=
 =?us-ascii?Q?2IjstWAe1rMMYdlMmN8IuNUO3ePzsEw6l0nXMZ3DJ9TowvdaCdmwFjKu1LgC?=
 =?us-ascii?Q?mussfu5lF0zSFiABMLz6w6yIZnFcadgIzBQXdJBg/znlQI6je5a74KCVbViQ?=
 =?us-ascii?Q?SXDns46PzMcn0ltZtF2Ab1YgbmQOSvrwgOeyG86uUlBdO+FuveqMpJoPsB1i?=
 =?us-ascii?Q?RAB6smiljZPth5RM3AwrTSueX9QaAsqhDBPKB9oklu20hekALz4zSVqGh3Kg?=
 =?us-ascii?Q?6DmrPmLvKhkzQSWg0QVwEi7/DkHspx+jtLf80TWH/rwoJkre06/c1uRQa447?=
 =?us-ascii?Q?VXh6rO5hf9y2AiwogtGFcLgydH24r6SKuEmLDZnixxCvBriJ0o+M1z4rP4Ad?=
 =?us-ascii?Q?IW20tT5jK+fvu9hgZlvctl0Aoafz9/Y/BfKwhsV0QT+JOGiP68zuxTgM7q7v?=
 =?us-ascii?Q?8zbJNnA1oAaCuzOm8yJ8EKboobxyGF9p9Yrkb5Jp6/oUvWZuoxRQw1j4spqD?=
 =?us-ascii?Q?RRaMLrivocqDkp/9rtiXH2POUdfVJx9nLIX2oJq1X6YbsSzNP/BB/SaVSLef?=
 =?us-ascii?Q?nWmE4jfzHv78jTRkjmwUfgugTZk/Sta7gJzaiVvzWDtmD0XtFVAW2mRU3qMP?=
 =?us-ascii?Q?u34h4diDwhuWhUKgLyUX7dIWXNRZfJ3sou67GQZqsylbVA8HrkIA/IsFelZp?=
 =?us-ascii?Q?THcGyXD2lOt8QKU2He0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab55802-7f60-419d-52bf-08dca6d47a42
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 02:51:09.4110 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JgrUuPuc+25J4yOVqyqar3ljBCWMPsu5jmefam1ncYsb/mEjAB055DkUit0K1Tel
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8507
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

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, July 17, 2024 4:16 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 1/3] drm/amdgpu: optimize umc v12 address conversion func=
tion
>
> Split into 3 parts:
> 1. Convert soc physical address via ras ta.
> 2. Expand bad pages from soc physical address.
> 3. Dump bad address info.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 116 ++++++++++++++++---------
>  1 file changed, 77 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> index 9dbb13adb661..eca5ac6a0532 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> @@ -225,26 +225,16 @@ static void umc_v12_0_convert_error_address(struct
> amdgpu_device *adev,
>       }
>  }
>
> -static int umc_v12_0_convert_err_addr(struct amdgpu_device *adev,
> -                             struct ta_ras_query_address_input *addr_in,
> -                             uint64_t *pfns, int len)
> +static void umc_v12_0_dump_addr_info(struct amdgpu_device *adev,
> +                             struct ta_ras_query_address_output *addr_ou=
t,
> +                             uint64_t err_addr)
>  {
>       uint32_t col, row, row_xor, bank, channel_index;
> -     uint64_t soc_pa, retired_page, column, err_addr;
> -     struct ta_ras_query_address_output addr_out;
> -     uint32_t pos =3D 0;
> -
> -     err_addr =3D addr_in->ma.err_addr;
> -     addr_in->addr_type =3D TA_RAS_MCA_TO_PA;
> -     if (psp_ras_query_address(&adev->psp, addr_in, &addr_out)) {
> -             dev_warn(adev->dev, "Failed to query RAS physical address f=
or
> 0x%llx",
> -                     err_addr);
> -             return 0;
> -     }
> +     uint64_t soc_pa, retired_page, column;
>
> -     soc_pa =3D addr_out.pa.pa;
> -     bank =3D addr_out.pa.bank;
> -     channel_index =3D addr_out.pa.channel_idx;
> +     soc_pa =3D addr_out->pa.pa;
> +     bank =3D addr_out->pa.bank;
> +     channel_index =3D addr_out->pa.channel_idx;
>
>       col =3D (err_addr >> 1) & 0x1fULL;
>       row =3D (err_addr >> 10) & 0x3fffULL;
> @@ -258,11 +248,6 @@ static int umc_v12_0_convert_err_addr(struct
> amdgpu_device *adev,
>       for (column =3D 0; column < UMC_V12_0_NA_MAP_PA_NUM; column++) {
>               retired_page =3D soc_pa | ((column & 0x3) <<
> UMC_V12_0_PA_C2_BIT);
>               retired_page |=3D (((column & 0x4) >> 2) <<
> UMC_V12_0_PA_C4_BIT);
> -
> -             if (pos >=3D len)
> -                     return 0;
> -             pfns[pos++] =3D retired_page >> AMDGPU_GPU_PAGE_SHIFT;
> -
>               /* include column bit 0 and 1 */
>               col &=3D 0x3;
>               col |=3D (column << 2);
> @@ -270,6 +255,35 @@ static int umc_v12_0_convert_err_addr(struct
> amdgpu_device *adev,
>                       "Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x
> Bank:0x%x Channel:0x%x\n",
>                       retired_page, row, col, bank, channel_index);
>
> +             /* shift R13 bit */
> +             retired_page ^=3D (0x1ULL << UMC_V12_0_PA_R13_BIT);
> +             dev_info(adev->dev,
> +                     "Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x
> Bank:0x%x Channel:0x%x\n",
> +                     retired_page, row_xor, col, bank, channel_index);
> +     }
> +}
> +
> +static int umc_v12_0_expand_addr_to_bad_pages(struct amdgpu_device
> *adev,
> +                     uint64_t pa_addr, uint64_t *pfns, int len) {
> +     uint64_t soc_pa, retired_page, column;
> +     uint32_t pos =3D 0;
> +
> +     soc_pa =3D pa_addr;
> +     /* clear [C3 C2] in soc physical address */
> +     soc_pa &=3D ~(0x3ULL << UMC_V12_0_PA_C2_BIT);
> +     /* clear [C4] in soc physical address */
> +     soc_pa &=3D ~(0x1ULL << UMC_V12_0_PA_C4_BIT);

[Tao] these bits are already cleared via UMC_V12_ADDR_MASK_BAD_COLS in patc=
h #2, is the clear here redundant?

> +
> +     /* loop for all possibilities of [C4 C3 C2] */
> +     for (column =3D 0; column < UMC_V12_0_NA_MAP_PA_NUM; column++) {
> +             retired_page =3D soc_pa | ((column & 0x3) <<
> UMC_V12_0_PA_C2_BIT);
> +             retired_page |=3D (((column & 0x4) >> 2) <<
> UMC_V12_0_PA_C4_BIT);
> +
> +             if (pos >=3D len)
> +                     return 0;
> +             pfns[pos++] =3D retired_page >> AMDGPU_GPU_PAGE_SHIFT;
> +
>               /* shift R13 bit */
>               retired_page ^=3D (0x1ULL << UMC_V12_0_PA_R13_BIT);
>
> @@ -277,14 +291,40 @@ static int umc_v12_0_convert_err_addr(struct
> amdgpu_device *adev,
>                       return 0;
>               pfns[pos++] =3D retired_page >> AMDGPU_GPU_PAGE_SHIFT;
>
> -             dev_info(adev->dev,
> -                     "Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x
> Bank:0x%x Channel:0x%x\n",
> -                     retired_page, row_xor, col, bank, channel_index);
>       }
>
>       return pos;
>  }
>
> +static int umc_v12_0_convert_mca_to_addr(struct amdgpu_device *adev,
> +                     uint64_t err_addr, uint32_t ch, uint32_t umc,
> +                     uint32_t node, uint32_t socket,
> +                     uint64_t *addr, bool dump_addr)
> +{
> +     struct ta_ras_query_address_input addr_in;
> +     struct ta_ras_query_address_output addr_out;
> +
> +     memset(&addr_in, 0, sizeof(addr_in));
> +     addr_in.ma.err_addr =3D err_addr;
> +     addr_in.ma.ch_inst =3D ch;
> +     addr_in.ma.umc_inst =3D umc;
> +     addr_in.ma.node_inst =3D node;
> +     addr_in.ma.socket_id =3D socket;
> +     addr_in.addr_type =3D TA_RAS_MCA_TO_PA;
> +     if (psp_ras_query_address(&adev->psp, &addr_in, &addr_out)) {
> +             dev_warn(adev->dev, "Failed to query RAS physical address f=
or
> 0x%llx",
> +                     err_addr);
> +             return -EINVAL;
> +     }
> +
> +     if (dump_addr)
> +             umc_v12_0_dump_addr_info(adev, &addr_out, err_addr);
> +
> +     *addr =3D addr_out.pa.pa;
> +
> +     return 0;
> +}
> +
>  static int umc_v12_0_query_error_address(struct amdgpu_device *adev,
>                                       uint32_t node_inst, uint32_t umc_in=
st,
>                                       uint32_t ch_inst, void *data)
> @@ -483,12 +523,10 @@ static int umc_v12_0_update_ecc_status(struct
> amdgpu_device *adev,  {
>       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>       uint16_t hwid, mcatype;
> -     struct ta_ras_query_address_input addr_in;
>       uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
> -     uint64_t err_addr, hash_val =3D 0;
> +     uint64_t err_addr, hash_val =3D 0, pa_addr =3D 0;
>       struct ras_ecc_err *ecc_err;
> -     int count;
> -     int ret;
> +     int count, ret;
>
>       hwid =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
>       mcatype =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, McaType); @@ -514,17
> +552,17 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device
> *adev,
>               MCA_IPID_2_UMC_CH(ipid),
>               err_addr);
>
> -     memset(page_pfn, 0, sizeof(page_pfn));
> -
> -     memset(&addr_in, 0, sizeof(addr_in));
> -     addr_in.ma.err_addr =3D err_addr;
> -     addr_in.ma.ch_inst =3D MCA_IPID_2_UMC_CH(ipid);
> -     addr_in.ma.umc_inst =3D MCA_IPID_2_UMC_INST(ipid);
> -     addr_in.ma.node_inst =3D MCA_IPID_2_DIE_ID(ipid);
> -     addr_in.ma.socket_id =3D MCA_IPID_2_SOCKET_ID(ipid);
> +     ret =3D umc_v12_0_convert_mca_to_addr(adev,
> +                     err_addr, MCA_IPID_2_UMC_CH(ipid),
> +                     MCA_IPID_2_UMC_INST(ipid),
> MCA_IPID_2_DIE_ID(ipid),
> +                     MCA_IPID_2_SOCKET_ID(ipid), &pa_addr, true);

[Tao] I prefer to using addr_in as input parameter for convert_mca_to_addr =
to simplify the function, and it's also convenient to make the function as =
a common interface for all ASICs in the future.

> +     if (ret)
> +             return ret;
>
> -     count =3D umc_v12_0_convert_err_addr(adev,
> -                             &addr_in, page_pfn, ARRAY_SIZE(page_pfn));
> +     memset(page_pfn, 0, sizeof(page_pfn));
> +     count =3D umc_v12_0_expand_addr_to_bad_pages(adev,
> +                             pa_addr,
> +                             page_pfn, ARRAY_SIZE(page_pfn));
>       if (count <=3D 0) {
>               dev_warn(adev->dev, "Fail to convert error address!
> count:%d\n", count);
>               return 0;
> --
> 2.34.1

