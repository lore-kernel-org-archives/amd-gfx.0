Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D09BC36010
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 20:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5B9510E570;
	Mon,  7 Apr 2025 20:39:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="toye0gls";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3447C10E56F
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 20:39:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HP67/mECl6Y+/2b9hhMbCWIbUBgugZ0d2I7Cu9JrfTWYPcMLAFtIBSHGqZLvvBt1AyFzIett1AXPn02ccUrK3hnm5rrL46G4iRtOrxpVu4PdjnBDIvvIGTCnFXd9Urh+GEoZlS7uYoS46yyyz4Cc/QqeqGqogxCFlBS7SRs4yyPLxmZ2ufm3Hou/M+FhnMONvZcLR9ndThXgpZu8WSh/u3uSZuE9KzZcWx9MtGJkAz/CwbZRO+DLh/P2FobCTGJW267Kn87TfWw199SmrEh0bJn5Ay67jT8IeyzwIxWYQqjOEI2mQ9EKPDm4I/X3Ny9nbFDeaYKmXxu4h/7gsSEjFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OjFUsKXO/PEm4LdmFzAzSM29WtwMVgDLc1Kfqwbypk=;
 b=YbLTPR5PkquexdHsYG9iXY/JSn2+4eELpKn43oRdHEcpZHU6oqYFb/3PBot3J5U/KgTqQjkab7s8dNZiNDvfa9NK27wsnuJVz4agfjFSelcFEVIg+t+Xm1m7xbOkTKKtZSzDKnL1fkt5Mnh8UrlXafGxdSzL9FYAb0nHvsqYFuvOE+vFDNNhM8nah2Rr10JBabrojjMyvgsMAtsIOCDhyMQYPu3aoRBYnephC7M/PP1eZ3dwHX9LczhxjrEhE7kiJs+nXcwFzjIN47V9QkvzLs36QP5zyTh+YVD4l8XPrp0om0zNDsUh8y91aK/xP5l8/pwi4bSaAzbHoT2foFV55g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OjFUsKXO/PEm4LdmFzAzSM29WtwMVgDLc1Kfqwbypk=;
 b=toye0glsSONkIadTRRo3CWjldMmk9fz58prulWMS97Irgd5SwrY3xS9e5bYHOk4U0k1tS8XfAFvAiUjVM6Yz95R1TwmoANc306gT31Lb4qgmXINGqPse635jKyn3/oInAtpOqr4nHpR/0FKSPpa5pllVflePPTXOfstNt5vSEqs=
Received: from BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 by CH3PR12MB9121.namprd12.prod.outlook.com (2603:10b6:610:1a1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 20:39:12 +0000
Received: from BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::bb8a:785:463:43ec]) by BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::bb8a:785:463:43ec%3]) with mapi id 15.20.8606.028; Mon, 7 Apr 2025
 20:39:11 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhao, Victor"
 <Victor.Zhao@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Skvortsov, Victor"
 <Victor.Skvortsov@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Disable ACA on VFs
Thread-Topic: [PATCH] drm/amdgpu: Disable ACA on VFs
Thread-Index: AQHbpBzi15upxyhEx0aUY3bdDjyHCrOYsdZQ
Date: Mon, 7 Apr 2025 20:39:11 +0000
Message-ID: <BL1PR12MB53173985892620FD810FE26BF1AA2@BL1PR12MB5317.namprd12.prod.outlook.com>
References: <20250402221544.110496-1-victor.skvortsov@amd.com>
In-Reply-To: <20250402221544.110496-1-victor.skvortsov@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=94bc43e5-74fe-4d80-902c-0a4390904db0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-07T20:38:34Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5317:EE_|CH3PR12MB9121:EE_
x-ms-office365-filtering-correlation-id: 9bc987e3-79eb-460e-5335-08dd761440d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?V/2lxLqLtk0YwAz6Q/IAeHjlGCEaB9zSeXbTD1zD5VGC3ox0E8p1Fyh139Lp?=
 =?us-ascii?Q?QlOwZPlARVXfveDXqvkNvuJFJrhe4Eo84xYYXwBI4DBlYUBOIXSVGD3DQjXv?=
 =?us-ascii?Q?qfJtrwichuxGIpiEaeDdjYY1DawsikRfM9PnFtwPnbaRif0DMKJPD1DbTDj2?=
 =?us-ascii?Q?E28qYFEy6ZCJjeJ9K+CEOYNwtaeviBJtRs8P00BSS3eg68nyQQQyJMqCaLYf?=
 =?us-ascii?Q?quFgKmlQu8yoMZRgrJEytcENETpITC3RiqkENNIrho/lMj9+9wI19N+rEy3s?=
 =?us-ascii?Q?B819mYxALkSqEkFkpM/6ItAHkA7Yg4UBQ4MmalfWF9hIoY3ZeDD66oztS7IA?=
 =?us-ascii?Q?aSpxHP49QwnPmsdWn3+ukGmpxnEpVYmYXv2euSykK5yy1AqkuETVQP0LO0/x?=
 =?us-ascii?Q?CzB4/0f2uTMdNrrJ+3eX0X+vRtO8QjR5iCgwAMWZGUf2IBgl+9NyR9Uf4QsT?=
 =?us-ascii?Q?UWMa03MTFmk3Q5MhZIKbRgyc1sZKgjbqufNUPp51whDsopXh6aILo8/wBs2V?=
 =?us-ascii?Q?9VsIFMi8uuHJL/8fOeXzOV6n1TKacmHMeb7tzz8DEEkDgAWKgSXqYSzIqaoW?=
 =?us-ascii?Q?PCDeAvDsZ4Yqz7DcKxBJsBp5+IrN4HfQwMETP/Un9CaAf3FK8fjbqb04rLa/?=
 =?us-ascii?Q?fBZ52vzUGP1cM1ZwXCmRe+gb2NI0Z7A+106mwSZPDSzFpRfdpK+3s3CVh6MZ?=
 =?us-ascii?Q?1DL61HneZ3uWZ9DV6z5BACMK85jOybbkdO+BHKH/ybi87N6ioinEPphAe/G5?=
 =?us-ascii?Q?HpEmRrxoqIM8hbMTt+FwiivW0wmMfcFQj108u22vv91ki+1lzEwmLM7UQvd2?=
 =?us-ascii?Q?NH7FODAdCzg3eUtz54sJUtDFP92D8z3kWbPnvj2Yd2crevHDM9W7ofUicmZG?=
 =?us-ascii?Q?V5+V1Ewp1TWSQutRMFaT+RuEF+40SU3smZI7NlS7ABYHcJ0UD7pZ9+MkjlzG?=
 =?us-ascii?Q?rYCiwUFNR9rDd9o8cGQBsey04ovfxVc4KkxX/OrlCmjFLFrq881Cji9FQ3oC?=
 =?us-ascii?Q?a178IcbLY1B7tJGrGXZoPgNuv2ty0tK50w51Fgtc/rDlak+bYSKYVXOBg/IK?=
 =?us-ascii?Q?1ShsTzn17h/NjC/XcTjeuYZ/QUhM7JtKfQoWu+JhAySxjGAZSo9vkNylln3i?=
 =?us-ascii?Q?vwj1SMtV4Bp2WqJVIgQKcQ/S9F5OWF0vXVB5mziw2PfzVpVUVOJzKJ9HDPGa?=
 =?us-ascii?Q?ayHep/t4IYNVTEWMXvUudXDodTA39gr3+HmQVC/6CWpW01bjhA7HFiju9a7l?=
 =?us-ascii?Q?Y/AMhvSy/penEUD21jaIAG5D/SjGwJ758A4OJQMYBw7flch6J+ZVmCdR8sBl?=
 =?us-ascii?Q?JAfGd9+hWUPLmnphftzIIfDnLEJ+ydlE5XI4maxdpwE065WLsq+4Uq5I3YNB?=
 =?us-ascii?Q?1BOsokMLyEHiGimdbzcUoTrdl9fTMdq+woy5FWKbo9SLqtWpmO4u6xiR9Lmd?=
 =?us-ascii?Q?tb0JSzLBAO3H30uvx03b8IdhghFCNLCFF5EhZa+so9JobJzuMj9hQ4TwmLLp?=
 =?us-ascii?Q?78Jtl6I331vmevM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5317.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bw7RirDb03oUhIlhLTYTqncblfredlGBhCvOma+VVksNjWcLw2bMDUApPTKZ?=
 =?us-ascii?Q?tkblTYVFvm8R/hwGOv79enH4kjzWoS2FGj9jVnm04pqYeuREie1vKKuLS+D7?=
 =?us-ascii?Q?Fv0Es3nWX7Lijv/4934Y3gEB1QxWP+uMYNlywwX/RmG4bz3p36k1+36EoszZ?=
 =?us-ascii?Q?wYpPTOxmtqW885x0jU7305qBrlJTpnFT3K48FwXovcdG8wFxMBZl4UIKc/qJ?=
 =?us-ascii?Q?yfqnuX04Buz+ke+lgfM8yQDy2j5gu1Q5iUODb0nt3v9I7oUBZHNzGn2Bdu/I?=
 =?us-ascii?Q?UiVyFDB8Qsw8XglyOarjju//hQvzdGATytC+QFYgHdCYh5e6c0jB0iVZ5CRg?=
 =?us-ascii?Q?YX3n8aArV3MS10CxbWC/mRhBreHHkcu429AQL8jHLrFZZUMic66AKlAzAdj3?=
 =?us-ascii?Q?gXkOSpBzYcHHlQ5REpxeLhQxywyeW+X7iKE3ztnE7CctPfIBFCieuvFqJ3qa?=
 =?us-ascii?Q?k7umwT2XtQ8cI45Gj1iHJFBYYINfamxnAqZsD33AjLxKpL3baPtbd+xLY1pN?=
 =?us-ascii?Q?19z/MhKwIoDXq0juFVOQCddmvNUvHhapeVIg2eaGEK6fffRd8VXsdNADzUPF?=
 =?us-ascii?Q?XZ/hh75uTsli9ieIJF07H4LaBmVJQqtIo94NAB7zAlQjR92VPMdvSt6nAoeQ?=
 =?us-ascii?Q?LqDV95WTX0EjkDmrm6nmqBuSFgjCUCocR4AsLvsX1GenKFsgDPBMfe02381+?=
 =?us-ascii?Q?nRm9jfhgV5VV011UXW7apDHrEi5YyNB/wHRH+/S1E+kfb24UUXem20G3DTXK?=
 =?us-ascii?Q?f/6p8dRiRH0QhUxEA/i4FATBcZkGfWY/1/HpUx7hhcuMx6j/qqjnr5qfSH15?=
 =?us-ascii?Q?mT21hoP4Xc8ujxJD2iQj4Vaf3hpfrHU7Alh47gQYuF9JF/pFBIOYw67blma8?=
 =?us-ascii?Q?nFHtZSunJP5BM17Zk0kt+uyRH7cEe2C48JCwBfFluOexcmYqakjKlVpsLy+S?=
 =?us-ascii?Q?9Y1QCMoKBkCcuOby+Zg2R1Fdod3ksMKEgXHP+pnf2Zx9aRmkV9/cAQq1n0DO?=
 =?us-ascii?Q?nZ+Dv0t+w9laLWi2bbbmMECPRTJyNhk/rC+ZcWOF5gcKX43muEt/t5huW3O3?=
 =?us-ascii?Q?7X/JscP911lAU+I/H8uy32U0IQwiudxsxvvfnilpN2e3BxwGMTf+kOzDUXOr?=
 =?us-ascii?Q?Pxgitw7n9UgT+73XXomkuUw/qBpv/lwxrDe4Tx8xn8evyk4tIrqn8wwizwT8?=
 =?us-ascii?Q?sTuF/2YkXuj0ufkpJn511r5lAKEi6bFJZsGoqukDoSGjXtptWgWhMr/5AifT?=
 =?us-ascii?Q?2emAOg/H9PBfJcLnB49mlpu/0kJvxkIta+P4WWHCzUvkfh1ZSvzQ2AxXqzoG?=
 =?us-ascii?Q?/Iux6EewSQy6wm7TFYyoSCYKSNEo+Db37QWmruGxjAg0UsbARCqkPb/jCmvR?=
 =?us-ascii?Q?V37aVEf6n4kQfRBzAJ0Y7lsS1ZnrUGUq1bmu6olIKv++WDXL8RD0zmevE+rC?=
 =?us-ascii?Q?LuMbi8RdbQdt3I7q/U0kCFpWUKvnrlnZOLFk1or2frg1d9Ifri1ca5tJHxLm?=
 =?us-ascii?Q?L/zfjesvKhtgs1d8e9wT7BuVY/pXUpOf8+6tYFPGkQRUCwqICHHgvhKclWKc?=
 =?us-ascii?Q?HY153C/n/rjWUHP+SWw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc987e3-79eb-460e-5335-08dd761440d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 20:39:11.5156 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FdPKEkqyWhmkad+zq1t5Zw9zqe6n0/uYbOUj8GYOUP3dT2mrdEp12uY5bl3eClsr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9121
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

Reviewed by: Zhigang Luo <Zhigang.luo@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Victor
> Skvortsov
> Sent: Wednesday, April 2, 2025 6:16 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhao, Victor
> <Victor.Zhao@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Skvortsov, Victor
> <Victor.Skvortsov@amd.com>
> Subject: [PATCH] drm/amdgpu: Disable ACA on VFs
>
> VFs query RAS error counts directly from host with
> AMDGPU_RAS_VIRT_ERROR_COUNT_QUERY. When ACA is enabled, an
> unusable aca_sysfs is created rather than amdgpu_ras_sysfs_create()
>
> Likewise, VFs depend on host support to query CPERs, rather than ACA
> component.
>
> Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c |  4 ++--
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 10 ++++++----
>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> index 360e07a5c7c1..5a234eadae8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> @@ -549,7 +549,7 @@ int amdgpu_cper_init(struct amdgpu_device *adev)  {
>       int r;
>
> -     if (!amdgpu_aca_is_enabled(adev))
> +     if (!amdgpu_aca_is_enabled(adev) && !amdgpu_sriov_ras_cper_en(adev)=
)
>               return 0;
>
>       r =3D amdgpu_cper_ring_init(adev);
> @@ -568,7 +568,7 @@ int amdgpu_cper_init(struct amdgpu_device *adev)
>
>  int amdgpu_cper_fini(struct amdgpu_device *adev)  {
> -     if (!amdgpu_aca_is_enabled(adev))
> +     if (!amdgpu_aca_is_enabled(adev) && !amdgpu_sriov_ras_cper_en(adev)=
)
>               return 0;
>
>       adev->cper.enabled =3D false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index ebf1f63d0442..5bb7673fd28e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3794,10 +3794,12 @@ static void amdgpu_ras_check_supported(struct
> amdgpu_device *adev)
>               adev->ras_hw_enabled & amdgpu_ras_mask;
>
>       /* aca is disabled by default except for psp v13_0_6/v13_0_12/v13_0=
_14 */
> -     adev->aca.is_enabled =3D
> -             (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13,=
 0, 6)
> ||
> -              amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13,=
 0,
> 12) ||
> -              amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13,=
 0,
> 14));
> +     if (!amdgpu_sriov_vf(adev)) {
> +             adev->aca.is_enabled =3D
> +                     (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D
> IP_VERSION(13, 0, 6) ||
> +                     amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D
> IP_VERSION(13, 0, 12) ||
> +                     amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D
> IP_VERSION(13, 0, 14));
> +     }
>
>       /* bad page feature is not applicable to specific app platform */
>       if (adev->gmc.is_app_apu &&
> --
> 2.34.1

