Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C196AE81BD3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 17:10:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 604FE10E366;
	Mon,  9 Feb 2026 17:10:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LKPst7Uu";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D67710E43D
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 17:10:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmvfA6pCQbdNiUMupSIoP4EKUefnqTSEHZQc8UXj4wBIMkIIBuc4/wPpxzWOgVpKSI6aCzFQEpgjruW8PJVN+f+zppBFa+8dk+fnEdFP986oCYZ3YKQ7OEKuUOSNxejHKNPsGqQvQwWDvh17MxaSOoNCFK2MpjjK0EskIpdG4YKBD7S3SiITYlOZUubRa1++LJyrFc2T/m06yLc0itpEN40wknaXfnJDlDzxV4EN24n8B9ENZA/feHjvT+ZaJUxA9VqFZls9p3xrEs43tMzMn7skX52jmkVUt3KmFAUgXZnKmpVZePaBQmuxmi7skMFQJ7ZZ3LW9c6EEowllXTUWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DToaUNnwFwd1SfcxsMlFlOdZO7O1Fve4qDtXZwnw9xg=;
 b=wRHKXOcbbnDuCko2i0lDsJwvyzf3XCcgPwkPeXYGDxuHZqjSIeyUYq5GSW+cifCZROETVbS96u/mE8CjRc87JRs4Pt8JCWZomQ2jvhIq5Py2MDok+38XALOgaac7lL2blkeCrPmDwXJXSDpN6haLnkiNIo1fcFKv/6l6FzWO5vPwUW2G2jR/K+hAg2AJd5ZBai1sXF8s1kT9s5YgXNPk9ohlvX44TEXIKsSsIPEr2kUjSyn8yuVPkejmtHxy+0HN6L62lbvHZyIIxAD+Zk2fXlVzNLm1pd8Z37cWbgQvi155PTcTZ0EFGSEvazAQSjzll0ZtOYQVJgoa/kqqnZgRpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DToaUNnwFwd1SfcxsMlFlOdZO7O1Fve4qDtXZwnw9xg=;
 b=LKPst7UuPzUyMLfghINyM65G48Vb7CeKuNeMvYbFrFWzLdEsUMu5J74OFbRcf7qMpYE9C9IEZrDFD4oSfkcGiYSbW2Z+PSMSEfr21N42h/icquu09y7hsJlzLd2dJrZ+ZwmXs5DzpPFI7XpOw6HFKcf20itlAYTs8kfvWRyLeys=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by SA1PR12MB8841.namprd12.prod.outlook.com (2603:10b6:806:376::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 17:10:16 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 17:10:16 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove some retired module parameters
Thread-Topic: [PATCH] drm/amdgpu: remove some retired module parameters
Thread-Index: AQHcmeakEk0WLnlPc0KMNg5up9mkB7V6mhTA
Date: Mon, 9 Feb 2026 17:10:16 +0000
Message-ID: <BL1PR12MB5898835912F30DFEEF8FF07F8565A@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260209170736.556398-1-alexander.deucher@amd.com>
In-Reply-To: <20260209170736.556398-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-09T17:10:07.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|SA1PR12MB8841:EE_
x-ms-office365-filtering-correlation-id: 7f3a244b-17a1-47a0-3467-08de67fe185b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?mfbH830MNm9RSvrFgxA6Jo7T/pF7p58K0eijKACzWICP2SydmjB0+ruk4vHD?=
 =?us-ascii?Q?CC8GPMxA93KRzg7fdFiG6hP/c+q0KR3dgCE3npxg82E8shtCQO5FW5dLi5dd?=
 =?us-ascii?Q?X/01w8EJj4puYcVp0bKbQQr1F4oiJnYjBGo3/uAIOeiz8zv4TXfxqEjnzL78?=
 =?us-ascii?Q?kvflnI+wrNXrnOdEGZQmdAJZs0jEkplaYFiyNL33BHybZnTSx3xwrLgTKEEa?=
 =?us-ascii?Q?AfYRmRE+NvbgTA7hZJB6SDRV0wyuFJ6YSI3iY4CVDckkVEguyIS/3eeWAJRZ?=
 =?us-ascii?Q?SE3bLv4KDm9WfnP6C7WeXVE7a2vG/OnVi9KAFegbC5MBgnZ67RrkO78iPte7?=
 =?us-ascii?Q?tTWmeAfVpbeWxIparxvPhwaE+PedFwjkD2le4UuNsMvbdeLwWOIedvD6JdR8?=
 =?us-ascii?Q?aWHrX9rKlfRfgSbPLH+BEwRItHNbeeJCHls3xxq0l0DHSOUjIdTNQ3OSRXmH?=
 =?us-ascii?Q?a5qO0eGiXGld21qEDjeLE34X8pyuG1ZU3rPNYeVHtVlBb3PIcTUOIK7M5iLf?=
 =?us-ascii?Q?nXgHC8P+TM8VeQl3h3tMgnLOh03Zyo5ONtQbEpnJX/d5sYhvMnn7CGjghdSe?=
 =?us-ascii?Q?ly4RO+YgWyKRPfuKzhO7toE0DOgzIQKJKlzUDHPzQi8qiYV9u9spyBp4ZIEb?=
 =?us-ascii?Q?+BvfJvwgZ3jUEgP9GyBwO06jI7x+13WUbDgJTTfJKEiUyIQD6t51QA9VVAby?=
 =?us-ascii?Q?JupIl9v3mqMuhSwtSVqNpKV9I77jm3Z8fx0d4BZhoeD7vLCkgmEtf5bJhdp+?=
 =?us-ascii?Q?DuDO4VO4smakGeLmMQ+aHZvT0grZff63zWCJhkZsVV0IudkEtNiZ+sUwPP26?=
 =?us-ascii?Q?+2j3S63p2LbzGib/rGJY3bJ6kYLHfhFNCIbLx6tv00s9NMH+dYqtsEMfjnLz?=
 =?us-ascii?Q?u8ntjJkxM+c8j+WQ3FL/jWBv73UEppGZ44alF5QNXgbOwY3eYuHLJhU46cxb?=
 =?us-ascii?Q?hBY+c4dHrNZ5iX/8QSbA+mjvkDGW8g+jR9kxA4jBjjmAM8HEJG7Sk5GOIk0A?=
 =?us-ascii?Q?aQ9oufZmeZH/Shhyiti/07WwmQUeeP3LG7NwAPlG3MSGLPbbe9emLFeqj1/v?=
 =?us-ascii?Q?TLbmq0GxRqNzAHn7r81ydzcn1NaVE0Ughx7kZ5kNseX8Q2saqv/lxgV5dLZA?=
 =?us-ascii?Q?LNZM03L3fmn/ugyTQOSXjzL088nYPYBWGag7WuzxE/a0bHbaOkGY7IvUBlsd?=
 =?us-ascii?Q?WBPbeUIP2hyOZ18HxHp5s4nbQIPTzIoClcNcnpbp1dBIv6MSASu0SnJ3KUuK?=
 =?us-ascii?Q?7QpeXFjJe7U8Cjef6vDYztoHYaX6UPXYtU6bTP2hpOiPaybcl9tRmVj7yQsv?=
 =?us-ascii?Q?H/GRDbK4VDzbB1nFjoxozmVrtIodbDm/nkiJIGF5PEbzCRFepd15VnGyqutz?=
 =?us-ascii?Q?0CzmCLWur3hmXU2kIzmDLiTLGidKWX8ie18noGZivfSgryt59/XrcTieSBh1?=
 =?us-ascii?Q?T88f0drPF43V0gErb6KIytllTn5RxY0QkTxjB4VFvaq3OXogMbrDpyNdOn4m?=
 =?us-ascii?Q?OMiMxjANXhcuha8obfp7bJIOBeY8Sw2/vgL8QHdJC0INP6UEmK/Z8oHDWVL5?=
 =?us-ascii?Q?VQ2QpKgIfhplG78jWM688GCKTkSej6YhK7bgJ7PMgfzVoLawc++GqMEbJ51O?=
 =?us-ascii?Q?0yr+dC208s2TIs/C+bWROY8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WTo8WFKC7HYXY/xrqos2ueqWWAaJxbOyxsUDfVvuTbmpAe5bBjn8Q6vRiTmq?=
 =?us-ascii?Q?Bp5SOM4EXBGbQeVxKXYpOZkM9/Ovmar+dyvF/WJM8kWvC/zNGHLTpcMwVwN5?=
 =?us-ascii?Q?FHfp/3mmZOUHX8l+GTnmqaS1+0f/RBpQRnIPR58SVRUjbSRwcNzBN7/8BaT3?=
 =?us-ascii?Q?TKqdZON3c+Lt/BlpMsX6ja6HOO5FkYRvfWxwgXJwZDeLks2HV5bXdd05yuIY?=
 =?us-ascii?Q?zejNspFGVum5VHsrdWUQ7IJYQ4iAojzAZcRW4nduDSGpsLn1GtwkxUIpJdfk?=
 =?us-ascii?Q?g4W3Q/BFxJ5Mgc0mGgFX6CgtLP3LMer5xfU2LBVu1AvNQSf2dxgCGHDaLHC/?=
 =?us-ascii?Q?/mQnLApPRtgOg2l44YUw0vzDr22x1RykUPIKeWKVrO4d9TffqavrTalHQRha?=
 =?us-ascii?Q?uMFrNt3+JG4ezu9kEmENnP0XtHEA+5/L3houl1fT1gU36vZcvaCKKsoQ3RmC?=
 =?us-ascii?Q?C3x7jZi8pI+81Z09xBMxJIfN6SzhE20XRZeGDAt1M59am+xpj5AN64B6HtMW?=
 =?us-ascii?Q?MYwvpBLksul39X/johkY5XIrL2dgIS+AoaQHHPbxGTckwOWjChr+pbw1yjK/?=
 =?us-ascii?Q?JgkPqyHGopftwRkAiNjepoOrNTVSf36QYgwvwdwBHHMq9kQK4EqQq1hbR2p9?=
 =?us-ascii?Q?PS/UnMrg88RNRiZPz/jFwsmbTATt2DRJ4UNg6/2102edSEH4UzA0zSY3eEJc?=
 =?us-ascii?Q?reDrKKbudWxAAvxPqkIqRrhd5am9ajRfI1HBboX/kb51+7Pyy4+DotUWcDcR?=
 =?us-ascii?Q?Ke3Zbm7WWM+IW/lk0QjilLwEWDKVYAVZcjM5/MKmyhNlvJewIQu8iw5LEYGX?=
 =?us-ascii?Q?Bmi6GEIm8nxNt5uasHVgTShOLJeYGmXWkJi/sEYtpgbn1UbK6npQZnw4TskF?=
 =?us-ascii?Q?evbEoI1EQi3lfDS4cSq2webgTYupAGgwQa+u2F3FL5so7NWMVDr2VbXYo4fR?=
 =?us-ascii?Q?42Wh2ScDucdyAp/XYLNUnJ+Prb153dyWTBxWNM+4bm/DC3p+u+XFZTalxQZn?=
 =?us-ascii?Q?trMsORBdtbnixMsZzyC2GgAePSwOR7W0HLNXGre1LbIFc6KEJ7GrzFubmyK6?=
 =?us-ascii?Q?T9FRMbO7fxU0XtlD5Wg+olvknMNJzneOS7FklQI6U9/NK0kHzvcmu8O5/ASX?=
 =?us-ascii?Q?ARihlsfKQb6mfDteOPSPWqHOEN+KafKIFhY/SrOYTHXNteWBpVKhHEqSt7x8?=
 =?us-ascii?Q?x4y8Wbjz+0KDym7ro4EYXEiZJ1TWZmgeF5SiGcxZ5oEAVkfbEsYEVMzECKYh?=
 =?us-ascii?Q?avJHmsipdekzDWK92WcIwAbwtNT4jKLVnvIRn/PWyPODerjhHp38szVwiQxB?=
 =?us-ascii?Q?0ABo9B31h8kDsSuAcAi4nnPVKGbxk4aU9pN1XsSx0Ve3+0ZQ3BQkkpPwCV0k?=
 =?us-ascii?Q?je+eapYfJka+Iw/YD+zycTdRjCkPyFWIizmNTOy++JRmTx0PhZZjCegnFT5r?=
 =?us-ascii?Q?my3G93w+Cc/WrFHdVsMek6gXanLW6vCyIjvB8+dTC/YoPigU/X6LEkj0Ih4t?=
 =?us-ascii?Q?mcl6A0SkvTdrZbPslFrr3QaUw40ACkJAG1x0flnupR+GCNAY1+1QC18k9wTW?=
 =?us-ascii?Q?3hg6gml/FMVe71MrHhCNFIdYJkYFgYlLUpDhLUGQ9CXqappzlSpgbLGY/h/p?=
 =?us-ascii?Q?a9xHE/VTBnp0o7yB30afQlmjg6EJYKycULwiUB5PsV3GdGtFOvAR9GyXXz8v?=
 =?us-ascii?Q?SFTwvQCC+JuO/wkBoqvkFzLe/SqI7Zz1CiT2QhaXjl/7FVfq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3a244b-17a1-47a0-3467-08de67fe185b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 17:10:16.0546 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S6DeF9BMBeBMsSI3DBiokdNpafFO+8QYoQp/XLD9a78zZLCLgGyhClzvvm+d2Ien4BEoZDII50msMrKxz2Capw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8841
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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Monday, February 9, 2026 12:08 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: remove some retired module parameters
>
> The mes and mes_kiq parameters we originally added for
> mes bring up.  However, mes is required for operation
> on gfx11 and newer so these parameters aren't actually
> used by the driver anymore. Remove them.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  2 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 20 --------------------
>  2 files changed, 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 1f5d15110e43b..0f6e9cdbe7d84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -217,9 +217,7 @@ extern struct amdgpu_watchdog_timer
> amdgpu_watchdog_timer;
>  extern int amdgpu_async_gfx_ring;
>  extern int amdgpu_mcbp;
>  extern int amdgpu_discovery;
> -extern int amdgpu_mes;
>  extern int amdgpu_mes_log_enable;
> -extern int amdgpu_mes_kiq;
>  extern int amdgpu_uni_mes;
>  extern int amdgpu_noretry;
>  extern int amdgpu_force_asic_type;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 5e04b5c0cb70e..3a6a482983383 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -223,9 +223,7 @@ uint amdgpu_dc_visual_confirm;
>  int amdgpu_async_gfx_ring =3D 1;
>  int amdgpu_mcbp =3D -1;
>  int amdgpu_discovery =3D -1;
> -int amdgpu_mes;
>  int amdgpu_mes_log_enable =3D 0;
> -int amdgpu_mes_kiq;
>  int amdgpu_uni_mes =3D 1;
>  int amdgpu_noretry =3D -1;
>  int amdgpu_force_asic_type =3D -1;
> @@ -690,15 +688,6 @@ MODULE_PARM_DESC(discovery,
>       "Allow driver to discover hardware IPs from IP Discovery table at t=
he top of
> VRAM");
>  module_param_named(discovery, amdgpu_discovery, int, 0444);
>
> -/**
> - * DOC: mes (int)
> - * Enable Micro Engine Scheduler. This is a new hw scheduling engine for=
 gfx,
> sdma, and compute.
> - * (0 =3D disabled (default), 1 =3D enabled)
> - */
> -MODULE_PARM_DESC(mes,
> -     "Enable Micro Engine Scheduler (0 =3D disabled (default), 1 =3D ena=
bled)");
> -module_param_named(mes, amdgpu_mes, int, 0444);
> -
>  /**
>   * DOC: mes_log_enable (int)
>   * Enable Micro Engine Scheduler log. This is used to enable/disable MES=
 internal
> log.
> @@ -708,15 +697,6 @@ MODULE_PARM_DESC(mes_log_enable,
>       "Enable Micro Engine Scheduler log (0 =3D disabled (default), 1 =3D=
 enabled)");
>  module_param_named(mes_log_enable, amdgpu_mes_log_enable, int, 0444);
>
> -/**
> - * DOC: mes_kiq (int)
> - * Enable Micro Engine Scheduler KIQ. This is a new engine pipe for kiq.
> - * (0 =3D disabled (default), 1 =3D enabled)
> - */
> -MODULE_PARM_DESC(mes_kiq,
> -     "Enable Micro Engine Scheduler KIQ (0 =3D disabled (default), 1 =3D=
 enabled)");
> -module_param_named(mes_kiq, amdgpu_mes_kiq, int, 0444);
> -
>  /**
>   * DOC: uni_mes (int)
>   * Enable Unified Micro Engine Scheduler. This is a new engine pipe for =
unified
> scheduler.
> --
> 2.53.0

