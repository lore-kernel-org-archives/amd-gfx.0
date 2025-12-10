Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBDED3B9BE
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 17:06:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E8A410E780;
	Wed, 10 Dec 2025 17:06:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uP7oDOLa";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 255BA10E780
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 17:06:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imNh4CY9jmAUbFWsN9CyA824qF9ZbM/cRl1yvroCGZpkZ8k1C/m0Kd3k1zIioHcnCKEV1VUhZ0/BZIiPB2ZAD6U194nJ+4IYBiWttk3aGlTYt9nEEP38cYLhdcVQaRm4mbCcDnuQXHc+ckAjHJSofcHM7Rh3uRlMkOTlZGD1NwQd6uS8TGkWVnsB/BpK/P51pOrAakvBV9XkxDA1ad1clKcWF9RP5FQOFz3HWQdKGzwH7GQTB+IklQ+gwbtF48MzPc50/zv4zUtQNlt3dkexIMiLLod72Ip2OmT68gm2XAedrK/3ROsjNHJIBrIbNgBskds4YzNYiPaOEm6v/01AeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BRZ+l8tFkGpaDvznQWU5p5wy/kDLo/Sw3+A4Sj/o1Y=;
 b=gwHJ2y9nQwbE8APMYVziXZH9Wc+LiJR0aXsUfKfnl/hFgzD61Czv6fdwvGSTaUHSQJfY1wPvn6E5XJmNgkJFqKhox9qQMLseU2Q3moRnmbPh6H/LS0KcW4xkf88tl02QWXA7xG1ya+kmLr3WugIgrhCuekH19hToDnpwb+bGGAuGttdEmaLyVT1yQHO3Of2Mrrwmfrv44dPlPjlCS+9N9lAX9hrP13nngR1ui0XiRIh8NWrT1aWKIqh68hO55sT/Txj+C4YXN4TEN6kEbVZS7oOWxVj7jAV32Mk4gCsK2Xbs6gFyfVfU6hA/wwX+tqg5tpql24Kar0JeedubjjqG3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BRZ+l8tFkGpaDvznQWU5p5wy/kDLo/Sw3+A4Sj/o1Y=;
 b=uP7oDOLa+c3zlALTeDX2RT682w7jd4a2nlPadqo1Xc0BS6oiXcwAr/jVZQPfhzQ022CUd5g76iEhNyI5lJlWIprpSVSwbLWeGgeOZ85T0QF4/riphij3ofBoNq6qAYIMNPf4aHXYHJn9D2fS7x9WV3SFj8hhU2k/oKXz3/4F4Rw=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by DS2PR12MB9661.namprd12.prod.outlook.com (2603:10b6:8:27b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 17:06:03 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 17:06:03 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] amdkfd: Only ignore -ENOENT for KFD init failuires
Thread-Topic: [PATCH 1/2] amdkfd: Only ignore -ENOENT for KFD init failuires
Thread-Index: AQHcZ4Jh9fAcAp3c7EuxIndDN98pL7UbH0og
Date: Wed, 10 Dec 2025 17:06:03 +0000
Message-ID: <BL1PR12MB5898D40CCAFD948D8C17B69D85A0A@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20251207140402.121338-1-superm1@kernel.org>
 <20251207140402.121338-2-superm1@kernel.org>
In-Reply-To: <20251207140402.121338-2-superm1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-10T17:05:16.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|DS2PR12MB9661:EE_
x-ms-office365-filtering-correlation-id: 3a773a48-324c-4e07-d3f1-08de380e66b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?LyyIWzCwlkKdqEdegt71ODTwUZBcOACu/OZ6XLh5eo4VcyB/OshgOJ6OUqiX?=
 =?us-ascii?Q?/TcGIyxNr/1Vq+ilDrC3MD53z5OAp9kokp0JEp4kO6FlkwJtcPqPEK7/F+lS?=
 =?us-ascii?Q?ekxMktXKxFwkKslZA0r8BIvtIyNjtavECOyEBJ83NMExpvj5AEh5E0xsrjyS?=
 =?us-ascii?Q?dFKYQxc0yjlZKNNL5jDvrNqQa0ucRlALIWPzm7XrtHoYudirQyel5cPBcHqS?=
 =?us-ascii?Q?Eo3qaxeXtNVonYk2zPEh3j1uBpyLVA5UubFlxOAXsfbtT2V1XF/gUYbHjfFh?=
 =?us-ascii?Q?joJWHGtM5k3l1NTa+mQgOwyICxfoMIB9RPcOrH26vj9oFk1FWqQMRLZ4Pm7r?=
 =?us-ascii?Q?qjkFc/lS2jJMl58jBJQHfjoOKXoc3e1rCkvLNtTc2gUcN8t0d+Anuaa5igVJ?=
 =?us-ascii?Q?bfGiT1l7Afq2IJWh2FV9BquYUfzrOQ+qG3UWl9r349x8PsTWNLdGUlFE7f4G?=
 =?us-ascii?Q?UgRE3ZPPPj+iO5SuHPYrhXYhE61Rq42AWtL2fpmkMehyJBIoqa3zEqyCG+hG?=
 =?us-ascii?Q?HGxsNSKPt3OFeqdwyZgFxTVm265CRAeYbG7yQFk1j1P+QvkVZaLkQLcvK3w1?=
 =?us-ascii?Q?/fwqV6fTh8txI8c7/3FDxMc86WGy7/BCVNrATUteN2cSgLgvkTgrwdbKBLfK?=
 =?us-ascii?Q?3IMlVDQJa9pFiu5vs0aLZXXkRBXG4fxSW9SzXNdeGD47oBZ3+FNQm99UiT3g?=
 =?us-ascii?Q?EWPDBb7BT80BrB1+5QJpB5hLNy0fYYYWn5AZC+2Fbhy4F7rD7je+XzC+D8GQ?=
 =?us-ascii?Q?mjGqmPy2ke3RPXW7ThUMoTCmJp5xUmC+GhzWMSAZz5p05XIJX1hHcdYIPxU4?=
 =?us-ascii?Q?J27WJVupgvBtF2StY//jBO5DzUPW7ua+IRCM5Wifc4x1I5wqK49NF2j6NCbl?=
 =?us-ascii?Q?MemZWOHUBDVlDucu9v1gv+gjDmuhP4EL/i9LaYRKqFawV4QVhrpcKSUwD0y6?=
 =?us-ascii?Q?yZzBICdmYktlfiuo6h96O2IPKUcKZvFoiiXLtAX5BzgvxagV4cpBJ1KLhp6I?=
 =?us-ascii?Q?wryogCRx+3c5TBFT/fz4QFiqWV0kRYBNMZ1vHtWplnO1UrhaTByk+pqOvOxV?=
 =?us-ascii?Q?jvc+p1IxlnxVOx94ZRu8To28GY4llAiHlrekr6LSOfdO69XjmTR13xpnK/u6?=
 =?us-ascii?Q?edelVoVvYo4N68A2OcKDGH2+Kt9lqGb26kUKkToWN/pBTsltgC7VKWxSLK8G?=
 =?us-ascii?Q?rZIPpx/bx/L//rfJIBBRhnQtH5Y69klGbYRVNBEEHMB1Q8KNT1yyFmTQANf2?=
 =?us-ascii?Q?Mw3hzblksIcrKhmacjQxPCBEmO+l4g6JDILf7IfYu3qr0kFub/zq3KY8E8UQ?=
 =?us-ascii?Q?Dcbm98SEvfZUaho2NpvfNMRVxIN5mMxijp+rie2gUqPMafPSl7fT0dQ1JxBk?=
 =?us-ascii?Q?CXO8gly3bvWidS07guXb7ZNdYG/RGgFRyuaF2OQ7qGKYYys371AlUHlypdta?=
 =?us-ascii?Q?eNJPFRnf1MIqtmIRWzMxxScqx2QW13lmbFFXIfItAcV8SRhWLw67eD0UCYdS?=
 =?us-ascii?Q?+KfPsgsnIIJSlrLnFFbENWjRCQplCwqX/UoG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?drmfTqMKWbPJ0Z3FA1TBQyCAMm4nIFFN87LdSb6KhmG2BVad0pla8L9bYTG9?=
 =?us-ascii?Q?xIJbzTy9bafhmDo69VpnGrMUql4DFeA0sX2DpOKK9xQGXp+WR7kAWK2TUIhJ?=
 =?us-ascii?Q?EMCgVpCNAdd2XrUk/bT3QXt5myD4ZK6uym4cvfAkWvNrq5Wd2icznjVEFgv0?=
 =?us-ascii?Q?YIgFge5sCb2Tfr4Tb4Cf80Ljm50wtl3uRGAiuwL6wuNkjMsCve6JzM1YKKw0?=
 =?us-ascii?Q?VuGVP+eBbPPuU/2K8CJXap7PFV9OcPeHKkVa3kx4qpr+C2RHr9jkdShtWjqC?=
 =?us-ascii?Q?8QCJ2j+v70Ru8pXfbKItKRunnf8Szb/UdLZXJI0/VzfJCqJNyX4K6SBt/0CV?=
 =?us-ascii?Q?mpzWfViEz4nC05JKT5PUOWfhq4oXxTVwSV7/xSNmLKkIHnhXh7UoHgGtFGHH?=
 =?us-ascii?Q?i88+rdFyxgIoK6lCENkJm/wGkEuUvxjm03e0ccreY+bxNRAlGmy7umaxoHX2?=
 =?us-ascii?Q?YXwku7k40A5vs4Vv948GtfylwqYC66YHpFqrPNzIGKm8zI+CwmhwCvb3n5Hp?=
 =?us-ascii?Q?fwqmr48dZgkZFC7hXX0mz7ygKC8FsrXexAXoIkHlxCni+pzGJ6mewO1jk+gc?=
 =?us-ascii?Q?nua2H0TnPrvfdhnsTxwvQKW7nalO5dtuHSgwAn0TXDkF8XHvVCyQcmnNdfrB?=
 =?us-ascii?Q?Y4wGqEH1p1A8xjflPXavEe9YNJWVDKeOJfP7fbfkWqSQAwoeVMZQx1098aNA?=
 =?us-ascii?Q?/d+O3SV604iZ74jIMO6qg7uzBWcbUHlp+RQ+REoPfHFrXh+uDLj1hwOcfz69?=
 =?us-ascii?Q?L3VQ2nL86sY7P11oBIyzG5MBak1H8Br6DlsoahhdsQuOJ5O335KGjKj+DvAC?=
 =?us-ascii?Q?7Sz7HYFQWnETfjotU7l2iY65RdtxJEq0a7I8wkwXHhDp9Ac0jgCNzdjzuW04?=
 =?us-ascii?Q?XAjxjUrNZsUWyDPD0h9USAfoP+l9cF+1h6KGLzheDAEPWL1TJMP8xUeXze5x?=
 =?us-ascii?Q?NbVnx/oYi/nU0O5twgR7Z3wpH9DeyTR94RKQ9FGUEmpmRGCr4BjrtU+3g7UQ?=
 =?us-ascii?Q?VNfIZmzCWur1g91ewyb/78VLa2nWDkb9dmN7ufLRBmOKP+f3tWhymg9p99cE?=
 =?us-ascii?Q?uZ5kIjUb8G34qM3D5oAZw5ln+cz9ck7xaXHrNEho0wmyS0R5pzCSlzO1zFoI?=
 =?us-ascii?Q?I4Tn5Lsnk1Zs7/guxLGPDYLV9YTdI9Dg37nts3aMZVkoX5VFeZCeZNNpzZl9?=
 =?us-ascii?Q?Okw/rxf2Lhij4RhmmyQuIVM72w23HsSvpmIlK1zw4FyUBFOURxujMgqNX/Ll?=
 =?us-ascii?Q?JyhmmjGRi+boTlHZN+djmmSy+IkADUezWAunJ1L2tA7ONG0Jtt3XVSB4MT59?=
 =?us-ascii?Q?zKnnsQKKR1OODfHBL8P0VW7MPboDQTJXBdWlTUYIz3lkjiFAEy7uPF/mElBg?=
 =?us-ascii?Q?BShyOpzkJSjUkPiwyW4m1L9Af+VHXzmzlBHgerFP6zvP2HL/pbq9JY4bddS9?=
 =?us-ascii?Q?hLAsBI2533rcGpwVvAbA7utI4j+AGQ2/HahfdQjvwqSqMX+hnbv2xQ2Y7VCR?=
 =?us-ascii?Q?00+RCpNaeuMDQgRBur+JQDN3CFyOy6UoldChXNKX56HTE2KPa1uHDP2RWmBG?=
 =?us-ascii?Q?rU1Z9n5b/x3UIeWXZaE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a773a48-324c-4e07-d3f1-08de380e66b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 17:06:03.6325 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hatYh8KAM/yKJSCHIf8p4WKIAo7owYnYSvtfeRFIT+fBwp0h5A+ZCQ6ulxrKdQEQaDgyu9hSG+HmcLiQWznORg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9661
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

Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
> Limonciello (AMD)
> Sent: Sunday, December 7, 2025 9:04 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Mario Limonciello (AMD) <superm1@kernel.org>
> Subject: [PATCH 1/2] amdkfd: Only ignore -ENOENT for KFD init failuires
>
> When compiled without CONFIG_HSA_AMD KFD will return -ENOENT.
> As other errors will cause KFD functionality issues this is the
> only error code that should be ignored at init.
>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 16adeba4d7e68..e804461e5f272 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3169,8 +3169,10 @@ static int __init amdgpu_init(void)
>       amdgpu_register_atpx_handler();
>       amdgpu_acpi_detect();
>
> -     /* Ignore KFD init failures. Normal when CONFIG_HSA_AMD is not set.=
 */
> -     amdgpu_amdkfd_init();
> +     /* Ignore KFD init failures when CONFIG_HSA_AMD is not set. */
> +     r =3D amdgpu_amdkfd_init();
> +     if (r && r !=3D -ENOENT)
> +             goto error_fence;
>
>       if (amdgpu_pp_feature_mask & PP_OVERDRIVE_MASK) {
>               add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
> --
> 2.43.0

