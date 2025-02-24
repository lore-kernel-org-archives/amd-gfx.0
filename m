Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D15C021A4
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 20:44:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0111110E51E;
	Mon, 24 Feb 2025 20:44:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="grboa84J";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B61E010E527
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 20:43:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msRH7E/DupLZjKwQ2vRfvsefA5MkAxebh414nzXuNJ3e5sdzI0uTH06qYZjyqg6SEdn6RWVj0KeXIe9g9J36o5Z5hKOpfurWCkFkz0upOHAt6wtUyZpr74zbhnnQHd2gO12qfE1qtGI7J5BpMfsv5MRkDjj5Xw1QRhQKVYLNN0zwv9XK1Shzqn1iMq6NrHVF66W/xgx8P2Y9AFjyDNt4uQMEMhXWfwwc1GA0QhHHg/9cuD90ucCAuj96FfYt+dWBJLLypttBGV3tAGZrqJpxuf4YZAuvq52BnDgrgahTDTj56rvR0HjEsdBMR9RL4V7AzoHwFiQBChjMoDuszpIliA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATu8FP9KYMSanbjP8Rx7nQ33/h2V4Lm6CGzpgynx4lQ=;
 b=X9Jn6rtO8/HBJfxr4YqbjEY/D6be2HQpSEkQscANc15zKOxDOV5guNBFqByfM07lFe9tKKM2a80zQ6++95seXFfKGZkV0TBp1heZ1FN9u4tG2Gamd1rUtzDe3obQ8235qqDDH1eLkuwrGnu+jG+quGjjYtDGYJT8miTLRqU2WtamFnw/SmRJZoTQO9Fn+5B9Y63kPA7+YLO6CIltP0VoMqGXfGiDOq5e+xnjIe4mSH0Ai0x630IZXRdu8ZWMsl0t5rLm3MtQAQRihUSi7p9h3gV/rRy4w1JfH+6OFxZLV9TrnaTZxslmf33Q/YTawq2dbCshDTrs4OLvknKAAa7Ovw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATu8FP9KYMSanbjP8Rx7nQ33/h2V4Lm6CGzpgynx4lQ=;
 b=grboa84JKhuJS2sWbpg97ZxkDeirFtCVD/mjXVHfs7CExy30dfB1x1Mt8cdJbxnMXdIskEBlVYev4wF5SOCCV7FH/WLcl4lPcRgX3Dze1BnXhod1VCtzRJV9f2KS+w8iTv436y04sBaZjvWjV+lodKNMPwR0eyg+Blm8CGi8wLM=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by CY5PR12MB6480.namprd12.prod.outlook.com (2603:10b6:930:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 20:43:48 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 20:43:48 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: enable cooperative launch on gfx12
Thread-Topic: [PATCH] drm/amdkfd: enable cooperative launch on gfx12
Thread-Index: AQHbhICQBz4val8CaUO2qMDthSaxCbNW3ggAgAASelA=
Date: Mon, 24 Feb 2025 20:43:48 +0000
Message-ID: <CY8PR12MB7099537A6C32949BEC89EC2C8CC02@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20250221164901.2731661-1-jonathan.kim@amd.com>
 <BL3PR12MB6425EDA1C0F692D744A1767AEEC02@BL3PR12MB6425.namprd12.prod.outlook.com>
In-Reply-To: <BL3PR12MB6425EDA1C0F692D744A1767AEEC02@BL3PR12MB6425.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=8139d3b1-621c-4b8a-b32c-77a4ca874073;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-24T19:36:54Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|CY5PR12MB6480:EE_
x-ms-office365-filtering-correlation-id: 9be50d82-bd80-45cb-ed63-08dd5513f054
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?r6ki9FJ9ekXa5Jf0keuYaAh04kB4v8b5YVzv9Cjqb930oUkFd3hyWrXwCeYZ?=
 =?us-ascii?Q?dVFslN2ITujri7eFAVnqXIMZJqQXrS+E9hhYWy89KfBWVbQPtDSnIQjLr4AZ?=
 =?us-ascii?Q?drlTjrfaCTh/w7/R88Y5KhD68LFdlFzVowAmO90KzESIAjSWn47b0nkcgI3K?=
 =?us-ascii?Q?qm6TeCJJXjYHLN6d9L/P3YhGqF+sp80cPu9JfdV/FLUB4uCrVzltogBlFCZ9?=
 =?us-ascii?Q?nZpqatCTD16YdIeCVGup93QJE2eM6ZOmQxL3LSSIJF8eaWMsPcGqa17qPP07?=
 =?us-ascii?Q?5A9hKWoL5sP6bZRzGU4I7XdxQmcTF6bmHKEQ3uHUe4sVkx6ZKt7HAZtbpTbs?=
 =?us-ascii?Q?R1h3eCyRPtnjvJHipTOEX8BvnqQz+oqQkezB5ILLC9b85/ft4XfZWuUnocRI?=
 =?us-ascii?Q?IXm+fE/09e2wmAKTmV4TdOdFXt+800904W6HTnfocr5R5mXCkSlo1Mk3/m5F?=
 =?us-ascii?Q?LDaq4xFUMDhgMvT4TNEcM2pVGvonx5XlHD3tmZ7WUMUslZn6v+B71NUFx7MS?=
 =?us-ascii?Q?z/VODJylXljEsHeoulzsRsv9xRRhhWIESgzLgphqeWFH/B0LzvhS8lVE8vJZ?=
 =?us-ascii?Q?fr3140Xr6xLla3PSb5R7EqVullhFM08Do+f/CelyvVOLFAPeVR8+OqwLEs0K?=
 =?us-ascii?Q?CrW/I5QuzKc3yjgjheJeet9+QMOUu+uaNj2c61tabsLNgz3cIti1bW7D3SXV?=
 =?us-ascii?Q?hZ37cStH6kP/DuHa6P+cfmbxYxaIezQzbkq0h1xghfWMN1inRvSdio56UIga?=
 =?us-ascii?Q?SGfY7SIxcBZBmTu3/kCdDB6JSlJOT33eAkCKSBzsiKniw5jGZbhJ0OPyjYs7?=
 =?us-ascii?Q?//fP9Ipd2ZgwPPzhp7uAGkFHZj5iNkLnkyExe8p945n16MK6VfwovG/3ZMse?=
 =?us-ascii?Q?ahbDO5AyAyXzVJSAx7iYS9YDpXOLHhox21+OHG0KglTtmgzQJjU/Vi1ZxDq9?=
 =?us-ascii?Q?g0v1ftK0pM/GnkxYg0gb9k0OZFSC7N76LlThICsHCxqxppv7bDeL6gHT7RJo?=
 =?us-ascii?Q?fLCoskAXsX32ilGNn3mScjF5dBqGcVINW61BRA0UvWjA+DkOuYl+zUz7+FCF?=
 =?us-ascii?Q?obiKI3gBsqCw8unyFyx0ofZx1oNHGCInX/CEznK1T0e0q446wCN9H4Roy3W/?=
 =?us-ascii?Q?MPLgFq5T4vqO+a/Kf25fmq3LHHUJVN9rQozT8bNoFhhzFw4qjD7fJ3nG7SaB?=
 =?us-ascii?Q?QYhxunyehr2xPzWxaT8jo/pB9NRp5qM3XZUzyGC+fbNtNwWv5lzLNgOnjY6l?=
 =?us-ascii?Q?ht+Mf/jHqON9GSAMQpgJkeQUmPCMRQScmD0ZHM7mGuq5RPXEIzC6loJDxUPH?=
 =?us-ascii?Q?Kofp2fXUtKyraGNa7Essy+ZYbtIkPU92111CL/vKBbrVzk9jLyqJAfFHEtMV?=
 =?us-ascii?Q?8Z04qVatt8LPooTKXwQUXG3spPa7XZ4hwRcqNxpqdGt3l0i4ZVca/zjmPHhD?=
 =?us-ascii?Q?L7LJhp+j6uQmZk0mRwGKNMP+vA/7527X?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KmwaN0EVnsPNbYGwlqvPyXYINV2fIlnBrBvdaTVLIhsj8lMFSmJQSK4Iahuz?=
 =?us-ascii?Q?oaSNXgWVu68AUaCV/VDzuORpgWO+TgGM+K1dJDgNaN9gmZ8HKyFIUD31ret1?=
 =?us-ascii?Q?YWgXruUwsTY0L7PmwmJCvi2axtEJ3YO1G615fB1MadmbNdJMCKV1svFl9xLV?=
 =?us-ascii?Q?IsTkhCE0Y8EeAsKWwaB9QhaBMglyPGHogovZ4QfzRSgVomoKwH5Ohs1Ewjqc?=
 =?us-ascii?Q?35n/OtAb3VWG0EMR91rrQlBlt4d/dVE2NVC98/TEOub8eYbGj3/UGyTDQDMD?=
 =?us-ascii?Q?OxFpUTE7lJ79D8t1RoVuDxBsbwZDDFleXmBwgNuKlb76VcQhfRT/9Nwkc1c4?=
 =?us-ascii?Q?HoJrqObN0bi5uIydlItFgDPbpYTZwzY5OsOINQfPFG5xAAttUNg+T2s8zfrw?=
 =?us-ascii?Q?CYXTbI1vL+Kxuw07Bj6XCQjzXJpHmzZhO4dpzkFhyXAMd+sT9XLLS7r5f3g8?=
 =?us-ascii?Q?hhpeFT2dZQtqjX6D0K6Gl0G72cOmuSwOENUzSO1rDxceyyh9YwHMd2YZmEOi?=
 =?us-ascii?Q?Wp8rkMTIEoS2O1XWkRS/lVTgUBhbnmtujQVY9n4HdBPCNTX+/Z8y50S5zaxP?=
 =?us-ascii?Q?Nj1uobLQ+2+ZxLe+nUGYvvpi4iD1FFA8Ty8NJVFzhYgyqBJrP6VCnkmtuVqF?=
 =?us-ascii?Q?GOoPesYBDFqB9CPvwFyMhbPF48jJnzpxESqipC0ezE44iuqaoiOlKDKz4K67?=
 =?us-ascii?Q?UGWkaO1HqH64+TKthgLMerI7jFr+851enQIHKUJIdCfWC5xu+qngC84LEXFv?=
 =?us-ascii?Q?Vb1eUYf/r+esmyZKuA+GhuG+msF3QzaTYlM3ScpUEYBa51TP1M3suX1IjVbN?=
 =?us-ascii?Q?a4OWPdvlKZB6bPlStnRGcu8RZGpcqEuDWxc/CUbm/sgJ7Rh0avKXsuiwIvrD?=
 =?us-ascii?Q?Y3FZlWUf9ZrXmeyD5SxF0yZ+tBruCvN/V3embGo+HieBK5TqP3ycD3f5Sgvw?=
 =?us-ascii?Q?Hl0mqoioL3kOQv1XdeKMELY6H3BbciXL5v3O6YY5Txd8bC+Nav6np/qvq2+e?=
 =?us-ascii?Q?KgLTUTHNhOH7XWgqQZDBtdEK+nGe2hvBs6qHTqlI5nVn47zpVf5945I3/T86?=
 =?us-ascii?Q?aL25NEKWCvXfhm8gdm8tdou4/tdWc7rGba7ioOTo+kE2yr/EGCM/QPUHjUbv?=
 =?us-ascii?Q?54Y2nMhRlg73L3EDxv3kY43AJoFV1RJwHSZVomSl4YPdyDI+aXJ/afoadSiS?=
 =?us-ascii?Q?M9wP0QIC1QAEMi2rjICfp1/mDGDZYy+CIj7PZRMU/L74ebUhvrxSLzDAB9d5?=
 =?us-ascii?Q?MiYQSBzrksdhAakqHkqn0sdmARDHyDn6Dq1aipZd3HJ9nU0WYP6yBGhEaYVD?=
 =?us-ascii?Q?n2flAh/eU7lbkkt/LMLNl10D1x5nhJFUh6ukKnpTNaHwLzgdOjd+FLwXqx1L?=
 =?us-ascii?Q?VPiLXvT3q2rzW9PuTdZ25N54A7pYIvbx6yNdOSNobgm2uWjmuOF+x9FVjigT?=
 =?us-ascii?Q?yItzHS+yMKw54zVP1h/c+KL3ds7rTja/9pta1EH8AZaU/zWccjti2nfMgWW5?=
 =?us-ascii?Q?WRDkzsOYWldi0g0tYn7BhGozd37wM0/UV49wr4G+e3y0SSlsmUKipstlNPsN?=
 =?us-ascii?Q?Yr5iybFmfOdHwGBtOQ0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be50d82-bd80-45cb-ed63-08dd5513f054
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 20:43:48.0841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cvAHK7qrC5nXF2cst7/H5IIDwZ7i7bFKV+KGP3jYtbdWKKb5gUXiVHRv/QLvKLgo9v40Pd351N5y/MPT4pujqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6480
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

[Public]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Joshi, M=
ukul
Sent: Monday, February 24, 2025 2:37 PM
To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amdkfd: enable cooperative launch on gfx12

[Public]

[Public]

Acked-by: Mukul Joshi <mukul.joshi@amd.com>

> -----Original Message-----
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Friday, February 21, 2025 11:49 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Joshi, Mukul <Mukul.Joshi@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>
> Subject: [PATCH] drm/amdkfd: enable cooperative launch on gfx12
>
> Even though GWS no longer exists, to maintain runtime usage for cooperati=
ve
> launch, SW set legacy GWS size.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 9d20e169ec4a..095e73790dc4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -590,9 +590,13 @@ static int kfd_gws_init(struct kfd_node *node)
>                       && kfd->mec2_fw_version >=3D 0x6b) ||
>               (KFD_GC_VERSION(node) >=3D IP_VERSION(11, 0, 0)
>                       && KFD_GC_VERSION(node) < IP_VERSION(12, 0, 0)
> -                     && mes_rev >=3D 68))))
> +                     && mes_rev >=3D 68) ||
> +             (KFD_GC_VERSION(node) >=3D IP_VERSION(12, 0, 0))))) {
> +             if (KFD_GC_VERSION(node) >=3D IP_VERSION(12, 0, 0))
> +                     node->adev->gds.gws_size =3D 64;
>               ret =3D amdgpu_amdkfd_alloc_gws(node->adev,
>                               node->adev->gds.gws_size, &node->gws);
> +     }
>
>       return ret;
>  }
> --
> 2.34.1

