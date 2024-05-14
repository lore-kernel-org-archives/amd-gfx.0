Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7088EC04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 19:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE9FC10E0AE;
	Tue, 14 May 2024 19:23:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SPRAfTZ/";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4953510E0AE
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 19:23:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOalv5ujZBGYUaPJqq8VzaQvm487azYbS39lJFzzOv+vuJbzRteQ+PByv4MxmIC1PKlxsVwwwjh5juFh/AWeAw5NDOCLufReIv4bqGKoRk4ildRsSfWS5l3XPmEGKVkf4/hCZj/bWosM+ve6/tXlbsjZHz1pK6SrndgpefLxt1Lc1VRvapOz67jZ7DhXKgbvzBO8BAvg35TapupQoxT6Pd5/ak0qyyjxcnJzPZ7GyCCGBIw4AitXtMT3Tfke46tZzUUZxcsgAQBarsiVdy9GiR4a1dkX4lxU9BE6TxImN8EX73NDGSJQcPtsXxMYek75leXkklryXxHZiTMML3RS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8uA7t8JI1PE9EekYUzm9kJZecOS1eG7Mn66S41AHi0=;
 b=BOnfIPzjx+lRUfDLFCgJ710GJOK4d2H+ANFUiZfu9da3Y6BadD2ZZzFIh1MJc7XysauXPgS0Swz21GjlkNtRlxBJ3YW4OJS99eYYKvMPDTqlkctGIrstC0SVQTAmbVLfBBy+jJqkAPpQ5hUSIpqtCUOYh8Fq/YN7yPjAxADqxrEzzXVXJ9bbEXz9pc7XYCaVFHx+SP0FQafIKEovVexRLAnRWm/5d7wU6eU0m6pGqMko1AV8+ZjpMpMZbjaVAsCVBdvgUDvapuxZHzfqIeqSQ1k1RFuwijntKO6XoZnvjYq111AqRUuPX8m2Ur9uNoM8+Qlzt4xD5J1rDMAyTIwuGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8uA7t8JI1PE9EekYUzm9kJZecOS1eG7Mn66S41AHi0=;
 b=SPRAfTZ/fnFHxy0C+QWhffMceMOPvqM0L4wI2xG7TfuSRXC/WYpkQD//D7dPOPgP7+TwYjXdiFWrZHVc2wERCeSvY+PlbSq26hSGvU3EX7g8+tGh1ENwyh+SBZX4njkn+12Cj5o32aiD8z4ySy0AlhWB/2Ix7ZeBG3qbgcqijAI=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BY5PR12MB4162.namprd12.prod.outlook.com (2603:10b6:a03:201::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 19:23:13 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 19:23:13 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Nirujogi, Pratap" <Pratap.Nirujogi@amd.com>
CC: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: RE: [PATCH] drm/amdgpu: Add documentation for AMD_IP_BLOCK_TYPE_ISP
Thread-Topic: [PATCH] drm/amdgpu: Add documentation for AMD_IP_BLOCK_TYPE_ISP
Thread-Index: AQHaphFfNUncczYWmkCUT9hh+O2fJrGXG2ZA
Date: Tue, 14 May 2024 19:23:13 +0000
Message-ID: <BL1PR12MB5144B3AEF3E9B27068E0D14DF7E32@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240514151353.1072181-1-alexander.deucher@amd.com>
In-Reply-To: <20240514151353.1072181-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=9207ba2d-ee8d-48f7-b5c0-ed131d4ca7ac;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-05-14T19:20:33Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|BY5PR12MB4162:EE_
x-ms-office365-filtering-correlation-id: 03e60fe0-d662-4b68-2bec-08dc744b4c8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?lAK1r36l0ffKsXboZaCPFGULKqm5M7DH3fAg72CpoQ0w2ZuwzRBhU/a+qrhd?=
 =?us-ascii?Q?fHoWf4zhGj2zCJDhP2vk8BN1dC+J21OvXCgYXqdyblCuT2Tc+l8b5xyescG/?=
 =?us-ascii?Q?na21ZH86/KG4mdEiFtnzaFLK+zAnILw4PQjiHTqGy4gOeDExTH2bo80fhynP?=
 =?us-ascii?Q?CRnRO2Ow7Ebj11LyEYkRDZlWkw+MNiPBwyC/euJWhjRmCwbLv1pc9FR2hBHA?=
 =?us-ascii?Q?mEEF1NcLbZKZlS1FwO17CWDPfTdE/fp5PZW2xiABl5jdKUaSSpeEa5KqLZvW?=
 =?us-ascii?Q?ts6dqNHw/t6Lsu7Udkx4QBwaNqYQubpSMjPChmUzxVjXIVMhiNdeDW+vhVEX?=
 =?us-ascii?Q?KMbJ2bKEPStkZ8bE6OUYkjKSfufivKYchKtHQCIADu+b/cDlYluXIbvppni1?=
 =?us-ascii?Q?+rsjyN0yHJcQ3VaatT7XDkQ/mgUrlt6/QHiCR9PzxtdJYZf1dZ35TJnECZsg?=
 =?us-ascii?Q?hS/JIYdz47NOAaQq01diuPdLw+h4hpWK8AiZzo5iGAE02RM23W4od/S5S3/8?=
 =?us-ascii?Q?rNm1x1nif8cJ4c3o2yF68c0H5Z6PjXLLUgIMWC6vvYLMRMDOIpojIAcUZu3y?=
 =?us-ascii?Q?1M8POaxwT1gRlQBkt6HMNO3ojAdi3jU6Sio1Qr2pOQYCs2FhkwqnzYbMKi2t?=
 =?us-ascii?Q?0ldLyMNs3zuD8Qv9TYmCnkhUM7XM9a3QNfwSMXR8CmuE3AsD1FdwgwCil/nu?=
 =?us-ascii?Q?fWxH1VVqvKZefCzmvR6vHfx43u/Ok7c6xiuKSLy0FB2JxvoofPyeqjQUIYBn?=
 =?us-ascii?Q?4i7slLpPVvUOYRP4FxUa15Gh+7VaWGazke1q7RnpsaKh7rwJ4lyE+vVLMiIn?=
 =?us-ascii?Q?PAD71VDgAT4PAjX23O/HwI3E7Bpdq3+Z0FFQz1mxJgGjiVAyKjHXN3cF5Nrk?=
 =?us-ascii?Q?G5iwKdZFLZ4DR7R5ikZkCgreDnLUt15YsH9oOk6CVjxHBPfLLdRRchtqUzKh?=
 =?us-ascii?Q?LF6dZZj5j1CigZiYO1KhEXVrEvQ0yQYm7H53E3kTZ+MTkDZwaaAgrJ5O3ckx?=
 =?us-ascii?Q?y/x88u+BrlfrzvER26WNGvW17Ft9CudDakxeUMsGPNVW8aG5j7MJ35s0pa80?=
 =?us-ascii?Q?N3qUDmmuwFPgGQiocb8g9Jym4+Qdans3oI6JqjEo7Wm4bS5AZ60gEB4ED3nw?=
 =?us-ascii?Q?Zu4Wot5bA2F1nkEkqjLyTPXhQPfMAUIMrkCw36wqRYhY42cZGyewiNeQeWKU?=
 =?us-ascii?Q?uqOJRKXjKIb451LIqvPAk/QxFfa6uFz+XBTig5ZWwB3HsC7lm7if7O1UwHZx?=
 =?us-ascii?Q?wWXPfuTaBOUu545yGYPF8uCI5OzhcG4JTbDN3+/hWF64uahx/JjLmzettyR7?=
 =?us-ascii?Q?wpk/hf55qaa5i0I2hXwXnho+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NkYQujehNJZTS+ysvYssfTYYipP+mQOV4ZRQOB/spRtGrme7jQ2hCnBwRlTS?=
 =?us-ascii?Q?zc/s6/VNNBOzJDEoxI1FNpL55YixvjtkQ77pZAPLccu5qRPtmttBrG7rTzRP?=
 =?us-ascii?Q?NmKZdK8amYmCd+aT/qKokruc0IsNZtsrGgpH5poD+xrgf6MuiVwZfq0D2Xxj?=
 =?us-ascii?Q?is81MMKHvG16jIq/x9lUSoZ5wHGLWz42oGv70mClZMBXa+Zk2uiCJwpBPU3/?=
 =?us-ascii?Q?LKjuHx+pq+T5qiSmQQrmHt2FbcMuTOaREsumIkkU+NgIfShShjCVqyfXiotC?=
 =?us-ascii?Q?eai96hnOY+6eF/6MVbhzHJL01i02pFy57zQLgyv5fLDaBIIQQYU5oTrXbKqo?=
 =?us-ascii?Q?o7JX26qcEGLHJPKLsMnt+6qASGsCg78e9Y3eduXcCEIIIsA/91b0v2Q8MID+?=
 =?us-ascii?Q?mcUeiXce1OqEPFNALx3MgMXwT1LoeI6a4doCPK7OUdP1G7UFHoWx6zbMhNLX?=
 =?us-ascii?Q?93ggIpxHcqiKObvvMckFTQVB/J+PlxmY+dYyHchFtiNc876++ax0WKK1TMJQ?=
 =?us-ascii?Q?bu9vAIafkajHfbV8IDb6mBHtMkDG+7NxPCXjRS90pSUS2Bdx98oUxOEwRJ8U?=
 =?us-ascii?Q?tjrK3sP7C6kHJXwoX/xsXK2AUCANvqPS8T4okHQGBAAxqPo5l9M5DVmQT6KH?=
 =?us-ascii?Q?uloRGuLB8SdXMX+uzLR8tpKbs3YDbWz4pjX3tqZyqBfefJftsnRoQPGJDeLX?=
 =?us-ascii?Q?8tGoQkJIgmjGp6dPOciR4mOt1BB3kbIrA0xLfWcNVqYMmZaNGybMSND4GlNp?=
 =?us-ascii?Q?ah4bRINiSJCH8ViFvj8/SQuhlueeUEYkolDpIebw+TCsNhLIXeSKvBAeUIWh?=
 =?us-ascii?Q?13aRg6Sa69QGZCzOdpUwtfGaf4oSEOrj++LzsBepRr1EQaaF7Tf4ktZaeLv7?=
 =?us-ascii?Q?zvP48UwxdbXEEDLZ+YEgunn0GcvPaMj61tc7OXuyhY1c1HH/eTo8s0oYHSWm?=
 =?us-ascii?Q?jTGhWN60iqlz+m1+NCdobPDO9GAmQO8Ryi2NqV9w6hAr4276zw2sTZfLd3wu?=
 =?us-ascii?Q?BhzJTACsW/95qGbu5DwMJh+IlDg4Lwxtj0dSqAcga/R9WYoG/gCLKdMVbRCK?=
 =?us-ascii?Q?bAsdNN7Racy1oWAPZDiaCPKMox0uhe5oqbhjt2Gb92w3TQRp/MD4DtL9jbMx?=
 =?us-ascii?Q?hxRuaPMhE1klc9CIWTRHTrYB++y4M+qY3Tiq0hOBcqfprAzc48C1dsOa/iOo?=
 =?us-ascii?Q?Cua1jGfQrNBA2pw8BKv8AhQ5d99+/5R0pOi0OGKl+o8Dha2LPxGaF/QYzDX/?=
 =?us-ascii?Q?A2sUTao1DsJo66QnPSp+rCIWIy54IhdU/HkLoFgXLMNdz+gPLjULsboy9+Pz?=
 =?us-ascii?Q?MqCu389fGYVc8IpCa6z4KuqtrLFpunYqYOOPKO12u5tpbz83FQA1rWeSHpjF?=
 =?us-ascii?Q?lglt1ldoI9pEx5huf6PuLtgL/KrjsUApeCRUQZIItOIZXRZgb9IG9ht693cT?=
 =?us-ascii?Q?4HbEkOBPA7TmRmTiL78RStxMh2CEKywNMWyZpGH4lYK+Dvhsq6ivRhMOOTV/?=
 =?us-ascii?Q?KZgpuoX4G0gLBSD/SLyBAz5me6XxwGVfjjJR+q+KOwAY5abKcdeIHO3Jt5D8?=
 =?us-ascii?Q?ZyPaDsUhqKiTe4ZeZ0I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e60fe0-d662-4b68-2bec-08dc744b4c8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 19:23:13.4917 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E6PxzEO/e1hbs4jTPwN4kXcBiWZJYokkcaV1++v74rEfI1KftBP0lWJmJobK9FoaGtgeKPefSCGCzRzg1WpfSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4162
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

+ Pratap

> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Tuesday, May 14, 2024 11:14 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Stephen Rothwell
> <sfr@canb.auug.org.au>
> Subject: [PATCH] drm/amdgpu: Add documentation for
> AMD_IP_BLOCK_TYPE_ISP
>
> Add missing documentation for the IP block.
>
> Fixes: a83048bfa402 ("drm/amd/amdgpu: Add ISP support to
> amdgpu_discovery")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/include/amd_shared.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h
> b/drivers/gpu/drm/amd/include/amd_shared.h
> index 8bc2134cdd6b8..f5b725f10a7ce 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -86,6 +86,7 @@ enum amd_apu_flags {
>  * @AMD_IP_BLOCK_TYPE_JPEG: JPEG Engine
>  * @AMD_IP_BLOCK_TYPE_VPE: Video Processing Engine
>  * @AMD_IP_BLOCK_TYPE_UMSCH_MM: User Mode Schduler for Multimedia
> +* @AMD_IP_BLOCK_TYPE_ISP: Image Signal Processor
>  * @AMD_IP_BLOCK_TYPE_NUM: Total number of IP block types  */  enum
> amd_ip_block_type {
> --
> 2.45.0

