Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9FCC3DA4A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Aug 2024 13:23:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C2B710E47A;
	Wed, 14 Aug 2024 13:23:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2rFfC3T+";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C53510E47A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Aug 2024 13:23:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RO9fJQsh8Ci331WMK5y9RqE3iPP0wLKMmIjWh1mbIAWa7CuqK6JB7z53ujB7BEk6iTRXkX92/hi86+WdOkoRTp5ZNBK/2D5jP2EmcSQ8FDGET6wmtSIsv7Dgb8QU5dmafqbdmOv1yRCJ2gxjkZm1luJbOOn3IWIyea64y7AUFRM1eWoPHYEnuKkEt15Eks8QcooWEti0iZTa8AL5Und+z2o1E3G4a1JATS4HIuJAbsL8yVrnl7+gWbgz8ynUnJaD/dlzySzwfI3hFEgexx/kMwJBAY3En9Sc1llrl4IMHDJzirdN+/qRDodqJPLMNxZomEeQGQDJXAyJs7gMZNAvlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jls1nO1wu3TID0ccKUI9/OkhZnPoJBVlMc/eZWkPAKI=;
 b=gtoT4+g8NQEx/gDyluY6/wzI6ikQtGRHV5EwpYFRBms3Cgi5/zTnwFuRJJ8ZVzNTo7mWyc2i61W6zrXANaS3ldaB8xKBsv1TJVXlYND0AaRlaTsUgpB8YIiG2xb/ciydTpL50VmUYe0wcuToOb2M+dw0sjv3NCGW+Nu2k1kZBgJy6LqpM6cQ/8cKKNVzaWrTOhen2sgUIjUpkHAws4ehq5HayyrzkdqTGPyqOGHGFJ/kS9wc8P40Me7w2d3mPb8ePYkRSED2XWOV47PqUG/z4Nops4de+DUln0ROF3AovOvA0n+H16VlBhsyNlJf3zqsU+e3YYubJc9LW2faz1IA9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jls1nO1wu3TID0ccKUI9/OkhZnPoJBVlMc/eZWkPAKI=;
 b=2rFfC3T+sR8strdkHfD5W/XaiWwO2LdpGFsiJq/DCW2sCvRlGmwbZOHTejk873BY3c5ZBa1uypNTafXbpI2szFAtEsxZpEKIJGvKUJqnkS6V6J9vMSaTz/joaafv8W/xC89mDcHHn+xJ/nwDKrzyw5H2lBEdvGbrIn3UwKBjv5A=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 PH8PR12MB6794.namprd12.prod.outlook.com (2603:10b6:510:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 13:23:24 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%5]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 13:23:24 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Khatri, 
 Sunil" <Sunil.Khatri@amd.com>
Subject: RE: [PATCH v1 00/18] VCN patches with updated register list
Thread-Topic: [PATCH v1 00/18] VCN patches with updated register list
Thread-Index: AQHa7XQ/ppBWcWI460KsNj7rTbR3frImvzRA
Date: Wed, 14 Aug 2024 13:23:24 +0000
Message-ID: <DM8PR12MB539900F9C38E62300BBB1D56E5872@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20240813113034.768804-1-sunil.khatri@amd.com>
In-Reply-To: <20240813113034.768804-1-sunil.khatri@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=66d49429-1b96-40b1-adda-f567ef575a80;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-14T13:22:48Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|PH8PR12MB6794:EE_
x-ms-office365-filtering-correlation-id: 7bad1f18-3b3b-452b-50fb-08dcbc64464f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ulOn/Iemlu3TsFAsTViKOkqwUQa/To/ZGPL31ns51u38VRNWhbeve4qRhlVw?=
 =?us-ascii?Q?XL8Ceny4Xb4gLf78g/PbeBqr0wxVgqM8EemY0UuA1R9Qsu5CcZcn1/gOdm/L?=
 =?us-ascii?Q?4T0W5Lua2DKOFWnu3uUMP9xagAOWVfUBeJCaZkZOC41ejChjRljkDbgKLjMG?=
 =?us-ascii?Q?5E33EWUOdddWcHI0heRmHz0FRgZh6AqxWRYlvc0BCgraE8+0c5aLDqFwK1Bz?=
 =?us-ascii?Q?KjjnLdVl9cBNFrtboYUo4FliqLoVSjGZVha+0XHdI3/dI89LQ9ADLrGwQn5Y?=
 =?us-ascii?Q?fEUhhf4Qe0mW4rhsnRnaNzCYV6UyYqOdW1VVQQs7sIezELp09uWiI/UM9rGD?=
 =?us-ascii?Q?ONsvRqv+qiMRAJL3hjmU2bmDzHiB1tgY0Ub5UXjQmYLjHQci1aT0CnB/KY98?=
 =?us-ascii?Q?JavQ6uijDnxIzI9HsbWf6qFXghXLm6RWoHGRUoAtCS/oPp/UjgR+DM8BEJVK?=
 =?us-ascii?Q?GNfLdPpQTnpt6eXPsXwpFW1cq5AqY5Ib6MhWFq0E9ZXL6tY66dJE9PafC0z+?=
 =?us-ascii?Q?jAWz57MflW/F1cBZCAgxok4NyYoxH832mR7/JZOnx2XZSaHoRpqOmt+1wyn7?=
 =?us-ascii?Q?U6AchTbzJCaktknfhZA0gM07QC256m0z+aZZEdOur7IXd+r569Tu5KgVy+Ix?=
 =?us-ascii?Q?aYxgpMnERpyVcaPmJr8hEAlf3/oYlR9jZlLGcXq/6wC/dymyAQuujE3kpM4O?=
 =?us-ascii?Q?FBVzjH0c08PLwuFbjkU6v+sQFmSvaJ8PbvXhbR7xozUOG2j45GN2AOvXFgXm?=
 =?us-ascii?Q?+R9X+S51kJmzhUfJ5/fq2kZGu5U8661BzyswqS/kRJhtVdlSN7P9JbdFEli2?=
 =?us-ascii?Q?0+b7SI9M/9h5eCIrbhVOXRn6YVoJ5+oJSRCzitIyQxzAwM/q579LSCQWWnkq?=
 =?us-ascii?Q?dJt97Po7Nhx90kJ937jvYXazLOgcStR4swMkP9oaYyPYs5fL6MoSlGc3I3Bm?=
 =?us-ascii?Q?38BYL7XI+qSLDUp5VWw10nUsNE7wZkbYiIYNdvkkKNmQHIUUhHG+t3t0Xj/v?=
 =?us-ascii?Q?m91i0oo9RpBLEAC/d75JDEJi43nDh5dxn77HSg2aa/Us/TeCsSn4hHAHCLq+?=
 =?us-ascii?Q?mLLVriU8mgkePk8ejmu9VS12kWGcfWQfOvDQs3GBXJZa/m5reZba8ZDMoGPa?=
 =?us-ascii?Q?OGdr2vq94p35Y9Tx76Z1WpQF+dxqu+uuTU1w7wPrEhvyxbf33U7rsVqgdaAV?=
 =?us-ascii?Q?HOU5grLS5J/TszR/XVuNXuy7E3mNjuaV7HAD8WqUxuxyZE6BIMIzazwHxHrm?=
 =?us-ascii?Q?Ckujk3FMOOXlEamMTqeVE0LTOxlwSE7F1zxgN8dNS25iDxyJweNBiunYzDVP?=
 =?us-ascii?Q?Oo0DRapXp7ti8SDVVCll0hX2kMCWCH9Nu7nP5oOwHtrXP5tRDfgNeAdxCKQ9?=
 =?us-ascii?Q?n5geMLmPzRuw2TUC2bbtu3wRd6gb2f9WApnjXF7WJUjB3SDg+A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/YrrUZJ3+lYVYRiRWtb24jZn93rbrQNZnnaVrQql47u3NAlUktBBQsERhJDg?=
 =?us-ascii?Q?yzs0DkG6XHN3iKc3oMvh4tmCpF+U0q4MCofVbsbgniNyNrcHXEg6e7zXj9mr?=
 =?us-ascii?Q?iOak/WZCAJXG5CWXIuNczn30PIIf+Vx6C2T8+vBLC3uP72rYgVLTrk98AN/w?=
 =?us-ascii?Q?5NwzmeKwHeuRzBVef+Xrb7cPWpkV3R5yhA1goHp8ooDmac3XeUSKqbUqyuVP?=
 =?us-ascii?Q?+jvJShHfBcPyoCPOgBAyRGmfbVpcdo5t5iz4qIap2LDPVcqPkkc0tJpAZecG?=
 =?us-ascii?Q?HsSEAjiq40S6X/S4L5AdNah+XsXhQPeUKy/CPQ3Dgq9WxjJDe0U8Eos6+Zpj?=
 =?us-ascii?Q?0cZ2jzI8jV20kzhJdYbN054XyNMg/9p+QvVGv01oFE66K4rZwu4JOpw4NzXg?=
 =?us-ascii?Q?0p21pfvrx/dNQBdQPZAMTupKNCtHaoFaFTIxbsRttyJR9j0SkkfNMG2OoDt1?=
 =?us-ascii?Q?C6OBfe+pLnOUaXyOU9rOA6EeVv84JFQZHhX9OWTDXsYbujbx6DxYkK8h+cjL?=
 =?us-ascii?Q?exu2YH89x6oTytLwO2NiiapOV1ej6p11zIci7teuJ6JrAHaGsBbUdbfoItiW?=
 =?us-ascii?Q?gC34px0ivuTreIrhAgpvFDSnkyk9raPJCl39YRHXB/CocjLRDqq4sDdHQoI2?=
 =?us-ascii?Q?g/qbkvI8OkK58LR2myAVLXrWyrmzoV5QqtzzwAJT4FSmTmGTLSbLbriRG0lf?=
 =?us-ascii?Q?j7gILoMYt2VvCxxahwLSyD2QifB65L8PyQ2iBP5gKyvZ//GrrE882ekwF8Nq?=
 =?us-ascii?Q?zaFlpQWp5cWCR5DnO3nCjrjWaRC/vvmzXNEy2Q6M3j4KQy+ef8/y+t5+3Lo0?=
 =?us-ascii?Q?6avOI+89MvP5/uBXs0H+f42r69+f5yBAryUzqMn6rzRGKVt0Oy/6CgZvPkr1?=
 =?us-ascii?Q?Dsj/Lsjft48ShtsQGgobJWXBVXW06sIBo66b4aXQec1KeAmUgpptKSvgTvDG?=
 =?us-ascii?Q?52rGcr54kxPjXUwVOkPn9cpIDmxT35FmhSFPColellyXHBHGroR/y242+Jr7?=
 =?us-ascii?Q?gfwAm30BATRvLjm878QZM3Z/VuPS3kgrtKUdvpDsZ7vtSEWqxhehov8dJ13q?=
 =?us-ascii?Q?4MStbF1oGcQRNMCZocdj8zQ7vuqCUFe5B6iUXv5Nhhp5Gvuxfcu76/GBwB5j?=
 =?us-ascii?Q?V6iyJ9u019BYkYRfb0SpjytL4KUjg9TaSIx3rhJwF9MCxYJYC5hKu5NV2IBy?=
 =?us-ascii?Q?LmC6C3a48boPwfYAHfz82sNYXIHQ/LBBBC/EA5B/gL7iHhHMLChKCd8vmehK?=
 =?us-ascii?Q?Zafd3ZYvamUAmfH/VOiUMDtRmDnd6xWXK8pJiYMvbOlmTiJ3l/SsFu2b6KaA?=
 =?us-ascii?Q?jXVLlg8dxcX11UEnKhJYMjIjEGAJx7/BiakuzY9cVsao6DbKhw5VA25uhufz?=
 =?us-ascii?Q?PqVa3b62D6c6qjbdc7YVk0hidy+C4TCUmwrbgoJKfTWNdhzRyjfK78ym/UKW?=
 =?us-ascii?Q?c1TUaj0K0+anzpafaWDBmi7Lhx/qmNabtdt8OnbvIYlWhFUA3Na7m2NZwE9v?=
 =?us-ascii?Q?2UaaHlQKUlYtJHmDy+T7re8uyr+EYM+K82oyNu4wSXhkZG2oI7Z1B5Q5sKhR?=
 =?us-ascii?Q?3E9JR9bhuev6B914UEs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bad1f18-3b3b-452b-50fb-08dcbc64464f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 13:23:24.1576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hJvQ77eU3Qc6z8+ZHnN98do2QyOuBy/qXcEAfb8j56Yu1tR+9qx34fahVz1Bm+1M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6794
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
Acked-by: Leo Liu <leo.liu@amd.com>

> -----Original Message-----
> From: Sunil Khatri <sunil.khatri@amd.com>
> Sent: Tuesday, August 13, 2024 7:30 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
> <Lijo.Lazar@amd.com>; Liu, Leo <Leo.Liu@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Khatri, Sunil <Sunil.Khatri@amd.com>
> Subject: [PATCH v1 00/18] VCN patches with updated register list
>
> *** BLURB HERE ***
>
> Sunil Khatri (18):
>   drm/amdgpu: add vcn ip dump ptr in vcn global struct
>   drm/amdgpu: add vcn_v3_0 ip dump support
>   drm/amdgpu: add print support for vcn_v3_0 ip dump
>   drm/amdgpu: add vcn_v5_0 ip dump support
>   drm/amdgpu: add print support for vcn_v5_0 ip dump
>   drm/amdgpu: add vcn_v4_0 ip dump support
>   drm/amdgpu: add print support for vcn_v4_0 ip dump
>   drm/amdgpu: add vcn_v4_0_3 ip dump support
>   drm/amdgpu: add print support for vcn_v4_0_3 ip dump
>   drm/amdgpu: add vcn_v4_0_5 ip dump support
>   drm/amdgpu: add print support for vcn_v4_0_5 ip dump
>   drm/amdgpu: add vcn_v1_0 ip dump support
>   drm/amdgpu: add print support for vcn_v1_0 ip dump
>   drm/amdgpu: add vcn_v2_0 ip dump support
>   drm/amdgpu: add print support for vcn_v2_0 ip dump
>   drm/amdgpu: add vcn_v2_5 ip dump support
>   drm/amdgpu: add print support for vcn_v2_5 ip dump
>   drm/amdgpu: add vcn ip dump support for vcn_v2_6
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |   3 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 112 +++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 113
> ++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 118
> +++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 113
> ++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 114
> ++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 115
> ++++++++++++++++++++++-  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |
> 113 ++++++++++++++++++++++-  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> | 110 +++++++++++++++++++++-
>  9 files changed, 893 insertions(+), 18 deletions(-)
>
> --
> 2.34.1

