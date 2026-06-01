Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C59CD6E65
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 20:36:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0E3410E2B1;
	Mon,  1 Jun 2026 20:36:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CinVC3vt";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011030.outbound.protection.outlook.com [40.107.208.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DE1510E2B1
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 20:36:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pekKVxaZPMaTvuJQIBvE40Ex1XGmSKNlk2oq3oytpWy5140D7zcq0ayD8b2o2lw5/o0m1LwPIqFqqTwqbX0/b5W1urfDGKT/NHDgTd0IkC3dDKnRQjbWA3kSJ+eANnu2Luh7DrKbsBdSnl+UpunTvIW24B9S5l2Xw+PEP6b/PmV4tOCa9N6ZtrVgim+CJ4LAHp7p4ZqQdp51oLfJODsDFZMz5E8iwoe5UN1dCEXIkTdPDmKBHHku7rd6+sMo7ZcyDD5u3Jy+yNjxs4C1fO1O3bY523783TItSYw/Cfo21NyoRGcKpR50vr32U20GVZi3mYawagSwxssanOWE4jLG3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1FuKTSs9snIWE2r/wXRf8s+j/kG4KHH33S36cajCf4=;
 b=HqdXeaz1+zjzjc+j/1uwD2PJwA90PIHIgKXYbk2Hzt70MCWpBuJw974cNiN1SZmQH/HIAy+e6/tOCSuTZUp1itCNxf+tAQXTr0mc3AP3bMBOeHR2Upo5NA117Y0mjcslGEmPqQJO4stGiYsOhmjgb94V7TEHZaolJhJFWQ5IHaFdzu6udCb3asFCh79XYOOVDyD/GJZOVhaV7E1f1GAZhUv/3kyYLhsV5WWCvZNWsLL0fbqbitK+Ckm2ptRayxd3Me/tByonIe//xwWPsOQp/OnkotZSh5ZTlKbcceQb0OOlTxfLhzWyOFbaV+ct8xOVjpp8b3QeeR38+EVW0WwFfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1FuKTSs9snIWE2r/wXRf8s+j/kG4KHH33S36cajCf4=;
 b=CinVC3vtPVN76NtkvjLN9O1NW4goanTXpUrnPe0ps8zIAgcY3AI3JsW55SIPwIrOe0EbAsDZHdcr2Mw4lVAQkKinFGMD21DO439C3dlxqQbwiM9TFKvN/xQlM4S6xFMGhEvDXPVEvG8Eo+rBHYdLr6NHA0WQ/66n9lrhOTxZHKg=
Received: from CHXPR12MB999220.namprd12.prod.outlook.com
 (2603:10b6:610:2fd::7) by LV8PR12MB9111.namprd12.prod.outlook.com
 (2603:10b6:408:189::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 20:36:47 +0000
Received: from CHXPR12MB999220.namprd12.prod.outlook.com
 ([fe80::c13f:e49a:47dc:5c61]) by CHXPR12MB999220.namprd12.prod.outlook.com
 ([fe80::c13f:e49a:47dc:5c61%6]) with mapi id 15.21.0025.020; Mon, 1 Jun 2026
 20:36:46 +0000
From: "Zuo, Jerry" <Jerry.Zuo@amd.com>
To: "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Hung, Alex"
 <Alex.Hung@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "LIPSKI, IVAN"
 <IVAN.LIPSKI@amd.com>
Subject: RE: [PATCH] drm/amd/display: Rename hdmi_frl_borrow_mode
Thread-Topic: [PATCH] drm/amd/display: Rename hdmi_frl_borrow_mode
Thread-Index: AQHc8gWNDoK0gkes+0OtQWvhFb1FU7YqKIEQ
Date: Mon, 1 Jun 2026 20:36:46 +0000
Message-ID: <CHXPR12MB9992205064EC4A8227CBC1176BE5152@CHXPR12MB999220.namprd12.prod.outlook.com>
References: <20260601203041.3557768-1-IVAN.LIPSKI@amd.com>
In-Reply-To: <20260601203041.3557768-1-IVAN.LIPSKI@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-01T20:36:07.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CHXPR12MB999220:EE_|LV8PR12MB9111:EE_
x-ms-office365-filtering-correlation-id: 9d0a50c3-3b32-4a64-d5ee-08dec01d7fc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|22082099003|18002099003|56012099006|11063799006;
x-microsoft-antispam-message-info: rEw12uwzXa1UwlYSrdVcxe3I+QcAhEdcIkMbflZ2cuQgj+ix2wxuFD9skq8kR8jU7XCBtCWg7fxnOg6H/5KK08cwRcDDK1Dlf1znXtNR53ON5D9aiTeJAoqa5IIzzq+1EgvJnpALR4UUwBL70Iqvhf8f/Fkhg3r//7+GYfXYGl/XrYLvCirmyZ6DZlsoaA+m0q1TnjAeeouRM/8KUQol1ey/cVRP5gliYFIYQYjU3nxE09K1Kq65ifYxZMzDhmkvAy5TvR3l77c5Zd7OZBYcT5RGqMq9e6+au5z7HPACHdXXK71OInAhurad5524QidzxcQvy64hQPCvZn1Xy0uAI5NXnQQoRM2ONrwgEE9QHKjeERjzLuEzOHnD7DM5G98PUXlrPnoXMDYUKjT/Y2K7Bix5iJAaaTdsMs57qWqI3blcWrmkgj3j7LQgHlZhaWRy7xVwPGAKs3pWldGSXtHrOjQ+HdA8FBhqWwFu52fLqE1gOVB7maICvdmxUAum7ibvpGG296tFrHkVK39snzjsAuI/qZQeP2Z62aNnnXKWE1k5iOAdqmKVu7FdJzs7uSmhJPdE5gc+iBuFCVtzUj33YUwhbxC3pYFFSyMtybXUtnoP8RllBaGSuHzDaeW7K0WwUFLlM2pWtxzB45U8Z9AvHmrHxL/PxqPWIJSG4leqWk5DFP9heq2rf1zUPHrgYWR0GP6TMhZT+vzja+L5yuAyAkaM8fzY0xGdEroT7+KnPa+n4KLCdOujlvJ+JlaF4BDd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHXPR12MB999220.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m3EA9ED/cP9TwCm/sCQhTWnkmUJV8Wpsv/XuqeXyx2iqG3id1Jbx08U7s3z2?=
 =?us-ascii?Q?V2+JfTEZlSYJNTMgF1RuFoBygkMm3wAB7w1/+EWG2zoQj3FAn+DdGFdJyldP?=
 =?us-ascii?Q?ImBsFMea/dKyVjNCra7G7XPvECvyxnZSPUUdfbB/sVs+sw/Wko1vz0yunfa2?=
 =?us-ascii?Q?WTM1LUP+Mvsh+WEbJZIh5x1/YwRmsKl7vpdx6e1mwlz54Z4VOgUvOlfreb74?=
 =?us-ascii?Q?oXd9v3XYFI8/yEYZCxuDOo1KZHl5q5+YakDPIYCuuPh9u82JabUQZc97VXs/?=
 =?us-ascii?Q?8saq6JB6FtTgPnRwiz2r5j0fOV3vdvV+T8s7Zknqp0OMOHqe+f8aVrZj7x/H?=
 =?us-ascii?Q?Js+5SNY1V4lPzOzX6mlrLtRmHFX1NdmhogylBmLQoYiuDwkdD68mwaDx2aSY?=
 =?us-ascii?Q?9rl7TsGmmxvsk0u4wHzieqTRLRue4GxKOocOIq7ksy3gqGwOQLKFTRm0GwQG?=
 =?us-ascii?Q?zMI0s7qI0dk9tpfSxcpHBKCR6Cx8b9i/4V5IA1Xs04H5ny2fN6uaMkzs2mPN?=
 =?us-ascii?Q?hASpl4UsEupVz/NAoaR8dhf6EgVO9FjWeuCVoi8dobnJTHt/tGPLXZiu4+l3?=
 =?us-ascii?Q?cGhW5uWpKIK6XUbreeSM/MiPbFgn9Czyg2n95mok99rHCK27pr6oiRMLUxEB?=
 =?us-ascii?Q?hn1skgAvVF8UMA4il9BVTTRR5YvarH0/eu1xEMSTgbdhhqi3dHFyUpm/fFs8?=
 =?us-ascii?Q?s/4PR3KHPG2hy/QkmwXwW13o9iSPeGozml8tGlIgEBb1jTC9uaIp82d9sT8u?=
 =?us-ascii?Q?fFFpBfr4KKT+lr1dEol7wmvQ661pxIcXQhy/8S+jTtya8otuO1yHcZ338KrY?=
 =?us-ascii?Q?jTtdZM+jRa3hIc6wQrEbtbVvFiUpP1UHSOaVzbqdBBlesjXCyokyqsHWYFGF?=
 =?us-ascii?Q?0yv+pQFOCT5G0F5QpxVzPPqqvYZDsmTNFgpEGGW88cHAd4YGDu2Roqeu8odM?=
 =?us-ascii?Q?6sZOBpID5LxvjDm8o658EO5Fyg4Ovl3b29SU15G19p8Tf0wpobHaHB4p4mKM?=
 =?us-ascii?Q?s83gNrJKwDoMiW81jue2Q1brl9xoLVGOwETtELtOaTptxrwyy1xU3jOb1kZA?=
 =?us-ascii?Q?7kZydedbTXuDli1JldG1xgtQcSdR4CguzgL/GFaf/W0Q2gw17Bi7vVKrNPrz?=
 =?us-ascii?Q?RFxU93Lg/1fmTYcUdEXBRSEQ+g3MNdTjYQ5s/mrl/bUzaN+R1shpQ5kcmgad?=
 =?us-ascii?Q?TrCMzmIO+jEBItxZg38NysFrKmLAErS52saEAPxJ42c6/EULw4p5cEph7mz9?=
 =?us-ascii?Q?LBiMi6ej/T/AilGMeugIEoEmFIJKZFbEJpoVhrkGqQ1foi2PZHvVwYuvwhfS?=
 =?us-ascii?Q?nmO4byyvtRMjDfBUKilpAZTiSgLQ5bmhjvOeLrsjuoSTfgvI26Gj3jC1Bo7v?=
 =?us-ascii?Q?7K1/RIlAr9qGYJww1sRej8QAtKQp2A341NRHf0J/DZRIp96UoqCJiRIEKSHL?=
 =?us-ascii?Q?667vE1sKQxQg8xfYPoNOE361mk3SE5AM6CvlaMgTQZBuk8+HFW1s5/sZ4okM?=
 =?us-ascii?Q?R+64sI46nVUcybz88EwpKmvU0/fWG8EJJ6HtbAEN0qjj2VR/HJxiDVW0akMU?=
 =?us-ascii?Q?4yR+2pF0KauaVyE/6UwS+QPyc5do2wlvlOT1vAGAGR0MF0fL8tWM1OjzsFCC?=
 =?us-ascii?Q?s/jkx2KvA5sWbV/iTrpsaPGMsf6Z8bNCzcghi/86cVs9RuEuuMNZQ7pYLDK1?=
 =?us-ascii?Q?s6uZHoL9u3BrhzKL8EtPdHoWzoI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CHXPR12MB999220.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0a50c3-3b32-4a64-d5ee-08dec01d7fc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 20:36:46.3047 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o8d0ODOZ8KG08Njlxu0KY0C7HA0KG9INnp7RDVAY1MnX3P0jKIUxWU73EgA0mycS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9111
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

AMD General

Reviewed-by: Fangzhi Zuo <Jerry.Zuo@amd.com>

> -----Original Message-----
> From: IVAN.LIPSKI@amd.com <IVAN.LIPSKI@amd.com>
> Sent: Monday, June 1, 2026 16:31
> To: amd-gfx@lists.freedesktop.org
> Cc: Wentland, Harry <Harry.Wentland@amd.com>; Hung, Alex
> <Alex.Hung@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>;
> Zuo, Jerry <Jerry.Zuo@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
> Subject: [PATCH] drm/amd/display: Rename hdmi_frl_borrow_mode
>
> From: Ivan Lipski <ivan.lipski@amd.com>
>
> [Why&How]
> Remame enum hdmi_frl_borrow_mode to HDMI_FRL_BORROW_MODE_*
> since the same enum is already defined and used by dml2.
>
> This resolves DKMS compilation fail.
>
> Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
> b/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
> index 5923a5f112a9..0da03eb794aa 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
> @@ -225,9 +225,9 @@ union hdmi_scdc_test_config_Data {  };
>
>  enum hdmi_frl_borrow_mode {
> -     BORROW_MODE_NONE,
> -     BORROW_MODE_FROM_ACTIVE,
> -     BORROW_MODE_FROM_BLANK
> +     HDMI_FRL_BORROW_MODE_NONE,
> +     HDMI_FRL_BORROW_MODE_FROM_ACTIVE,
> +     HDMI_FRL_BORROW_MODE_FROM_BLANK
>  };
>
>  enum link_result {
> --
> 2.43.0

