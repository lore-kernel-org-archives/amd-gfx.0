Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF21C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 14:49:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A05110E1F8;
	Fri, 31 May 2024 14:49:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NYfA0rzT";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80C1810E1F8
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 14:49:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Um+X5Oujlg/rgZgSZBIC6nXmAlcau8CTKoWWJpY4QghUOnZriAW+bE0woF/xEurQlg/3GMy+m579eAsC9ItuM6+VZ3+aMkc4G8aROBgkLDEIss8eBxrDxj0bV5zrE2VLQRpSsDIijV/X/WxSMsis29sjPOwKV1m3/pQIPfwxEg9epPOy7iQwsG7Frw42nh9Ryye/R51faxPzZgGpOv+TZAGfTsXPLZXZDTY5aKRbpWfEb74HuIObUSyTth/xK7uCrktTsGOBgX3rFhsB7OACOeIk+ZfKsSBUP0cA9fDG0fDRxmZUrg2nsChC697++2v3NA87DE0l2jf0EcmAYKHDSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqGzifZEPk8g8GztmyTRYVQQg2YUkhCkYU58EBVcctM=;
 b=WQJiXhjFTKFeIKDnlyl6UVyuyRaUmH4y0fu3YAAWOe53LYuKLI1wzUDjapjvoUPCKWmSDKoVomVGpexsCvqNfeIU2p+10p10R673KVs+tYFBEXZcdfPtJpICMoKT64jLSXXsmkZcKp6XOhGsWwIgl3Qb26jRpZV7SlV1C5B1zoeqSNlZJNmcSUB1Z1RZKYBqPW8mNTpUpqebG9NW9I2C9F4xtM53VrkG5xSZB5yYDyd4M0rAD+imXRHcEG7u+dbQ/S+b8aA/XbN1ZwvwzN+C9nXEVAM19rEYSzyy/of+2GK6YoRLZ+KqhT7FwNS1Cr+ViOUOOAB0VxTnwroR2p/ltA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqGzifZEPk8g8GztmyTRYVQQg2YUkhCkYU58EBVcctM=;
 b=NYfA0rzTW4OREwaAp+dWyoLOX8HL5uHbR1Lh9Klaay3/XNgRCdjRJFTPymTd5zcuZQ5HGWxVQB7Ligc17+ocoVaMYgTaGVv8HdChtB1ZV7VVlIH1hyu8fNTQh/+AgIO9RUJgB0tgLxdz7F2DP0O4zkJf+VEJfhzCOG/5P3l6L2A=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SJ2PR12MB7894.namprd12.prod.outlook.com (2603:10b6:a03:4c6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 14:49:38 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.7611.031; Fri, 31 May 2024
 14:49:37 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 04/18] drm/amdgpu: refine mes firmware loading
Thread-Topic: [PATCH 04/18] drm/amdgpu: refine mes firmware loading
Thread-Index: AQHasyc7QNet8qLcx0C+EuQfIYYJTrGxZiiAgAAG0XA=
Date: Fri, 31 May 2024 14:49:37 +0000
Message-ID: <PH7PR12MB5997E4F4E767C85195C01D7382FC2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240531065249.1746350-1-kevinyang.wang@amd.com>
 <20240531065249.1746350-4-kevinyang.wang@amd.com>
 <BL1PR12MB5144C45758A9BA797F55FCB9F7FC2@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144C45758A9BA797F55FCB9F7FC2@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=49a48d0f-1996-44f6-ae83-edb0735bd49d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-31T14:23:19Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SJ2PR12MB7894:EE_
x-ms-office365-filtering-correlation-id: 0c2490b6-feab-427f-2b85-08dc8180e517
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?E3qR8BAF1+qtOnRxTu74lmtCJfzsmk6T390bPtvRLXfH2FlLhVH6RM7NO8wP?=
 =?us-ascii?Q?bCLZxeG0nC8wfBVL3UkLhngkqObVfJ/vySyxGpmI4Y13uD4ziArNc/cseyvl?=
 =?us-ascii?Q?wRMgdDCFt4ykZ6pjA0nwfiHlejA6hO7Y2+MVK37kVrNPT3GjSX5c1dfX/fcx?=
 =?us-ascii?Q?VGeaPbxPrTNSGOgbP7Le8nRnrUrVW3VFyQ1SANL9XFh+WuoL+x0dRzfizgxE?=
 =?us-ascii?Q?99cn7bE+sxriEAb2xEF5WqOJUg0Bw3X2jqqYntJO6/y1n+jBNxNiPdd0nfSz?=
 =?us-ascii?Q?xIu+/iJcCs1uk171v/cL6fHhvwBIZlQ+iavW0hf3kXGhLVY6NsfCU5/WowJU?=
 =?us-ascii?Q?lxoFlsUgRvA7idmoQaJF9ApokhFzgRIrLBi3oVlEkMNr+nC+PRtoJKpQU6TO?=
 =?us-ascii?Q?//ynYjnbiif0iEiCi9+yD6brJg1PNZllxaiRB31P7eN1yC5pyKLFDT5L8Ci2?=
 =?us-ascii?Q?525ek60O66Ia28vKBN9hMXyzn5t/RI+ECL7gxtAGj0uDA8QEr/DNUppEMtL2?=
 =?us-ascii?Q?znFJ7+/3Y6IwAJk06jYL1UEXjHWHTvbY4kRlWJZjArlab++KH9LRapQyFXPF?=
 =?us-ascii?Q?Hd6VZQNMz1wqqY4qZPGlebH3vEoOaJIF7Fbph7V0ka1c+k7TR6H5nPfSXGOX?=
 =?us-ascii?Q?fqJxasFsaJc98H7bQAmF0fwtf9DHcdw9VEL/8zIdR8BFXKdJPprk1gZ6W2C1?=
 =?us-ascii?Q?6+tsS4lk2VSWxqkoh7YpsddghSvYpz97twEFIdEqzX0I08P/5SQO7MLYAlok?=
 =?us-ascii?Q?2ZEQjIOGkRQKs9otqavJTYcL6ur73ByU1zBysApKVuVldwm+C8Wx+dBKOsWu?=
 =?us-ascii?Q?2N8L2Y/feshlDqtkd5kjxyH4WKiQykWzNScbP7bHycz2QvQimgISt7NKkCHW?=
 =?us-ascii?Q?nhSThHH6VL6ewXsaOQyJse7Y8HL2O7lNf1LBt2EGjtuwouNhix2dOzGytrtx?=
 =?us-ascii?Q?X1bF6serTFNQ/7Wz+XNC8PvgvKs0lDb/ZcbtHcDOS+Vntez592xb+EeDfic2?=
 =?us-ascii?Q?v5L4khcZZnIMtfjW3Cj2HIB+RQKRlhEtCBSp2A2lEc932LT5J1uh9t4i1HvC?=
 =?us-ascii?Q?7WSfFK4a6FRBAR6DBsHdZsNc/V4DBCY5/ObuFrzRWSd65LYoP3qh/1d+q4hH?=
 =?us-ascii?Q?JJOxaysEjvh8YgNK6xRqFJBA1qA1+HAtUhPsN4ovTSRz6hyrgdgN01TK4oNP?=
 =?us-ascii?Q?KP2mZHuXk/Om0eXI8Ge2mgVRPwkc6S+vV/3TI3632qdv2A4kyW1PQjyILQf1?=
 =?us-ascii?Q?uM+x+FAdNaYMWB0f37GqlDVYYdJ2wKJ5W/iHvf5bmYZKL5BGXfqGEoLt8gZZ?=
 =?us-ascii?Q?jER0RilXuu1fRHpzxTwslVYchW/9p46h+o7oySnpBLXDGQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JZ/6E4nKIStnad6t/dN0GmtQw8fnYE4Dz3s3ZX/KZFg1oJRvhqNVB4mX3n0r?=
 =?us-ascii?Q?zXF9TrI0RciTTR7TUabzSiNIeKh3KZ3FSYnWtvt7ivsIogAMVwRyftUI3fuK?=
 =?us-ascii?Q?yRTnNXkJI2l8BZDrr9dnplNVZ3Xi7A9MXF5dFmbrKvrmoB4lJR81K7n0yI6U?=
 =?us-ascii?Q?1BgsV9qz7nt7sxc9DDyEV5Ys3pcuTAA5MfUFOt5BZ9OAkBXjgFQ9LCjbvGJK?=
 =?us-ascii?Q?gTfEWHXhZFmWeX8thuKc3rgWYGUJHigiGZ+L+0jiAfIc++J8iQDoe56m4IJz?=
 =?us-ascii?Q?ehJtOMA6PLkn3Yi4KMd6QuSoQ+bK0SMokPfR16GA+RO0MeU8GPpZeYtU6uTg?=
 =?us-ascii?Q?B+ubGv+dPUoaGeutOXMwzEEgY1IpS6KL2vssY31bJN21qqzHgpMp4Y/oTLeZ?=
 =?us-ascii?Q?QWwin4GkC6mvaocWBYAMAdlM6liWH/np8jwdyHZkdCnF3j5jy+Wl44E49z0M?=
 =?us-ascii?Q?YmEXHquz7/kCDVeEixMZZm0lQNBAs8tzM5deJUZgLcW71U3228H/sMBBvjO7?=
 =?us-ascii?Q?tiha6/lz7ic1elsFIxvJkkVGq3w7xnsklHD5q2SN7XSvQqb2ICiZY1i5vajv?=
 =?us-ascii?Q?MZTTxf8KPyFSmFblx689qRFclX0/kwUUuRKy8cvSgHEsmdZw91PgL3/uNZgY?=
 =?us-ascii?Q?UA7Ou2VeomkyaQ9gQ0vS32+/6JctFQav3Mggsf2WNHiiGcYezNE5LFbfcRUc?=
 =?us-ascii?Q?UolI//54in9iJ4j1w0nJeoA6EVFCY1pDCddS7ioKd8lQxBENKAkS4nw0UX1T?=
 =?us-ascii?Q?UWV5BidQnszPy32mnxkFQxKl6F+g6JUC7xm3uXEOep0wOjwpLxHyBr02lbMC?=
 =?us-ascii?Q?8byGR2ax0N+LSHRydpLtrAjphOsxyn7GOwELV1dM8HUryB3n/CempbmNbxTf?=
 =?us-ascii?Q?skFf9DGHRO1fCYbu+FX3//RQWwR0fNgtb8M4iqFxuUCOMzl8oneWCzwRUFm5?=
 =?us-ascii?Q?+V4sz8WLuA37xj4+DAyCm65m4PKzx2Uo41veg+mH0MvUf9M6DyLpkEkm69X8?=
 =?us-ascii?Q?Lpr6q9i6C/rIJXrMQdyUwLWjaknCF0HTg3Ux4OCyapc+fmFipg6TT7u5BWkb?=
 =?us-ascii?Q?JKGcjhZadOC7aQNiyPQ62TyjbWTab/EPKFi47EjsJ/kid/SlhYBojmnKEZrl?=
 =?us-ascii?Q?aau45RpkjJN6DSJP4db8nEjx2ljfXsAocV0nDfNmGGGnBkGyXJLYLGLvONd/?=
 =?us-ascii?Q?Q5Hx9aoCsbVo99lDOqNByungPQ4umvpkVM5CGnBccScflLRgWDDo5/My0UDb?=
 =?us-ascii?Q?7ct2xGSiItkB9tI6uUymxpJrD5lijL1uZWBbjPbh4kYpU+gPk8QYnT/tpD0g?=
 =?us-ascii?Q?KrIP/Rtn9S9BPIVXkRBoWmsTBq9XSNOVQ2YVvMyaCwBgnfFdr39PVokQ4s+W?=
 =?us-ascii?Q?Quya/H/sWAfJ1IhjQivinVWRqKlBmxBvRPE4KaqDHrYmJst0SuKyL9pdoGDa?=
 =?us-ascii?Q?TK1u21eqpfcaM9IRw+VkzzLWjUtn6sBhYh20gvmG+a4yaD4yVftcBJYrbHer?=
 =?us-ascii?Q?bKQ/HoBxDhC75lGxfgEdSvJndakFVPOyBe+xlx9F3/C6f4sNOWt1UeNZLP4a?=
 =?us-ascii?Q?mjj5kEsTfEgQwnGZsGM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2490b6-feab-427f-2b85-08dc8180e517
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 14:49:37.8851 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NH2kZxUaVEH1BCiv5lvd8vudfAZ17qpThgatDw99xwVO31NIqWm3Owp7wC/JZ6u+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7894
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

-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Friday, May 31, 2024 10:24 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 04/18] drm/amdgpu: refine mes firmware loading

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Friday, May 31, 2024 2:53 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Subject: [PATCH 04/18] drm/amdgpu: refine mes firmware loading
>
> refine mes firmware loading
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 62edf6328566..9194a53b7c14 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1528,11 +1528,9 @@ int amdgpu_mes_init_microcode(struct
> amdgpu_device *adev, int pipe)
>
>       r =3D amdgpu_ucode_request(adev, &adev->mes.fw[pipe], fw_name);
>       if (r && need_retry && pipe =3D=3D AMDGPU_MES_SCHED_PIPE) {
> -             snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes.bin",
> -                      ucode_prefix);
> -             DRM_INFO("try to fall back to %s\n", fw_name);
> +             DRM_INFO("try to fall back to %s_mes.bin\n",
> + ucode_prefix);

While you are here, can you convert the DRM_INFO() macros to dev_info() ins=
tead so we can get better output on multi-GPU systems?

Alex

[Kevin]:

Sure, and I will update in next version.

Best Regards,
Kevin

>               r =3D amdgpu_ucode_request(adev, &adev->mes.fw[pipe],
> -                                      fw_name);
> +                                      "amdgpu/%s_mes.bin",
> ucode_prefix);
>       }
>
>       if (r)
> --
> 2.34.1


