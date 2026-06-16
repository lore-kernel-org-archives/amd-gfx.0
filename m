Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE164CD98DA
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 09:02:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E03C10E931;
	Tue, 16 Jun 2026 09:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rJccULTR";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010034.outbound.protection.outlook.com [52.101.85.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F401D10E931
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 09:02:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVzn6dWQrnoqM5bq40Zor2M4+2PiLcEHpK5XVzdMM33EG/k/QmRTC4PEdPWd+36W4AMImNuwCmPi/tm3E6YQdo0JhaJx+tnofNrdhkcIS0AHumvx/GE1ZcqxA4o8z3EZ1VyT6YMEmnC4Zor1X1f0zF66aSaW4hxqZ23zTEhobSw+W6iVuwZwqJNDqDowOI+QmiVs/xlGP2Gt8sRPb3PRrINqxKedNNQhdWqAWQusttgjTu8VjciDRj1EVvwhYDNRA2sG9rhCTw1F4qNMkvxEeSlfw0vYM0QGLJKjHGWU6fq0Hg+s6SexU126omfLbSPWK1kTO+3pizDGEz5JWBs77A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfiW5aQ0oNCSi/a9uFuf1i5i5YuZvJS4MJfEF31Br8c=;
 b=SCl28+wPRQ8wowIMNC9NGK6hr/a/lsj12AXSNsegkLzL7mm1uRW7ldjczn9y+0qfJ5dWLLyx1FHev+lUq9/g8Jl/IZxsf0wVDsQXdxtnIj7a0Z/6fSffACV67d9lSAEcGR3wp/noQvXrtG2Oh+hyaX8O+6KqAtgXLYDbbdMwowL0SKDzpaWxTtMBRI26uPpT9zjLG/yZxS/INc6DoVCOkN/5k4DbCFoNOjcBQs0ruUAVK0TiGbWO91Lrde9s5emi6HfvQmd7yibgIo/9QjmGLSaJWbBvWnOj2SGWTzjZEl5Uu1R1dy3Mw0xsmXYXHyOeJa7ww/myuUfs2lGGhVN9Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfiW5aQ0oNCSi/a9uFuf1i5i5YuZvJS4MJfEF31Br8c=;
 b=rJccULTRqxn+V6tuiJBHvy4ENofBdsIL2gdlGodj194bSDMwdkVrB3zIP8fMGlNwWkioN9J3Mha4hP/cCOa96ohdVrxJDbWn4nKOdhP1t/iGzLlOTp9Bda+HIwiXKi7hnfZscLPnChN4OVvsVq+hRJPLrw18PyS5kA/4GaDhh+k=
Received: from BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 09:02:14 +0000
Received: from BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d]) by BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d%2]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 09:02:13 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: add bounds check to prevent array overflow
Thread-Topic: [PATCH 1/2] drm/amdgpu: add bounds check to prevent array
 overflow
Thread-Index: AQHc/WxOyu4ROoktUECq9dNngUz5crZA4ZqAgAABKcA=
Date: Tue, 16 Jun 2026 09:02:13 +0000
Message-ID: <BN9PR12MB5306D5EE41DC9B2D2F314BF0FCE52@BN9PR12MB5306.namprd12.prod.outlook.com>
References: <20260616084340.4128985-1-YiPeng.Chai@amd.com>
 <SJ2PR12MB880715FF183CBB3B61F66E78B0E52@SJ2PR12MB8807.namprd12.prod.outlook.com>
In-Reply-To: <SJ2PR12MB880715FF183CBB3B61F66E78B0E52@SJ2PR12MB8807.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-16T08:57:29.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5306:EE_|DS0PR12MB7655:EE_
x-ms-office365-filtering-correlation-id: 098c3bc6-6759-4f20-936b-08decb85f543
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: R3j2FLrf+fqAt5ktXthJqPkZnjGqMdZ7/8998xPVJdz4ILYvsOXaH/6ryedqIxnItgNfznPfZwo5daXIwEUjNs0KaIXKQQ+P7yJ6Bt18UmjMqvF/yVQhXa6Sgfw1Zs9HCBy9Kb8VuORbhvI0bPKut7lAZRVxQpZm8/JYkuldE7mPh/uTllyzmKft6Cee+nSZQqoGz08yf0hqcpiuqIIZha1JZlNuZY+myaUaZd8aCrmXlZwhBVeuC+2rAl4tb/cJb0V3WNWRTdYePYFyXdTWJCbkj/hwS6TpWr0G1mCmIbvZ3om8C0GcmIC8xV/ulhr7HbR2BQXBqZx5YOQ/rUbK7o6CZTLkaiO1REFpx+kSbXAsD6iAn6iMA+DdueVLhCOdrzakLTa61VvxftA/xzCqq/exjGRAyDwyyC4GspYXHoKwnHuVf3Vy9BgCi3XrYXLctCDOsjd0JcdZTngcVzJ4QiMkdickDcv++Vi/gGX7jJMY7QItEesYqqCGDXDkTIgmteiZwi2vdSwjyrcsoSk9IfT3t+veueQqGrLZNSvfJzbzGRPkgGC+kq958Faxwwi+2n5tUEXEvJjukcKvJyYTuntUFIpOe4twUTqWOu7HtOxr34UR5xBQwXcPaoYsYXBuXOncwMf5839Yo3Lkpz5OsiKz145AZsZPtBU/xi1sqJPKh6s0KirxHY5vpR1uW1w0tFmKoDXlye/hdaGnZSG2tAECRuY+jITZwv+inwQdMJmZNFtBxPb2+bs2Uw1vBwjP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5306.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(38070700021)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k0YD5y7Yc9sxXYNC1bRYawcDHLjLWBYyk2gJzVSgPwv9xpxo0XbGo2zzXEBg?=
 =?us-ascii?Q?owshVRF/vWrA4E6BLPJrlIrzNhBSVp9iXAFDpMOTt03Gz2Aq1H6LH7hf9nP5?=
 =?us-ascii?Q?p7tSexg6YcHRJTo/EwCjWA65EJI1h5ZwmbmhXMiwUHS92ZElVFlsmMmKYE+r?=
 =?us-ascii?Q?rrT0Ljg9IGodyYk8KZXRHL5UCdGZyadCqzXiceYwL5soLEqood1zrV/16EER?=
 =?us-ascii?Q?ZUkGHXsCUzPKhAYb9NzGormE5qBMO/yGOBqYVtnZlbLVutho565bxO4IXZ1L?=
 =?us-ascii?Q?9em2e/erud59bZGkL4coc3GPwZjqV3wsiANQ/zcGSP5b5VyqNQY0qjwwj3ME?=
 =?us-ascii?Q?ONyF5SpS2MAvKdWs5+g+s34L9KuxUo7PFNh9uyw6tBdddwj6oO5wEcKvRI/H?=
 =?us-ascii?Q?Qbs3HjxfpCEc5X8mHqwKT5ztYDk0LaRP1iQoLy+VdKMulfLsLH4xEZW1m2uZ?=
 =?us-ascii?Q?8dOCxgn+0RTfFKqjNpdXqLM20dwW0BJIVHIEvc+DZk085Z4s/s0bhu8znJi0?=
 =?us-ascii?Q?JLLhFxBoiGllH5Bq7REbYNQP10zgXwU2OeebasFUtY8VdRdjiL1WhfWAmqom?=
 =?us-ascii?Q?jBd5TX1pmTDiBew0JXIeOOq3rkfzivJ9HkU85J1mA1fdCFL4BFGHkfRcUd2y?=
 =?us-ascii?Q?NnfNP90grpS9HwMa5D0zNNNOJUg7XPQ1NKUM5xjMmTKvPydHGMx/Aou37csW?=
 =?us-ascii?Q?L6Q76IW4gwzqMsSvIwqchMpo/iAzIZ4XqZSFraKNuXQWJFo9cuavYLCB6C97?=
 =?us-ascii?Q?xc8xZ6He9SXa6tAR/GoIecZODVwm6G6ML/Lf/2q/ktoEJ6jXYK9XPWWd1vI3?=
 =?us-ascii?Q?qXquQQIn+PNAKtpkBZvWweo9r8kceZ5HSvO047bq28PNK+3HdOoCgpTQxmtY?=
 =?us-ascii?Q?QCcCSzcfCCKkzWK9h2zswYjD+ocYhWujIbuDjNTl/k70BceLl7kJhjCag1D+?=
 =?us-ascii?Q?8NzLAJo3SNrEL72LgK87at78OWktjX2Cjnw6yAjq8fbfMz+mWui01rFkJMkj?=
 =?us-ascii?Q?M31B01DSQvg+XRYFofzwOJD0C+6SFS7irc4RqbUR6THzJyqpgJ5wveTBRt0q?=
 =?us-ascii?Q?633aAZVn02d7qXTaOI50j2XuM3AocfzVRWdlSuUsDAZJNbKolhOPQ8Ju2kp9?=
 =?us-ascii?Q?0sNCVK4PkftjKEB2AThbUQh/SMDmpFPV4s9gvcHU5vpb7X52JUyuCo0UZ4Al?=
 =?us-ascii?Q?Kw6Q+XCkj1My9lRay629iZdTYFPrQsRywMacgYcZjLy0plwXd16UVc6/Vavx?=
 =?us-ascii?Q?/Womv4yFaUaQeMtPQ5zjojJOZdaJXvLUV3/4Bvu0FwLG48KL08JSkG6eQWM0?=
 =?us-ascii?Q?3cFNbsKxVqCO7EXSVT30eZuaXvPmPq7psEgnY36DoK9fU+x+gMu55Livyd2h?=
 =?us-ascii?Q?x/txkgdYFkRUAh6cp4GMsycG9h56JmCxone5tVdoJHOtzv1w+NjDQXQ8YA43?=
 =?us-ascii?Q?7wBSM/8P9lPx41ivgjxTRmALEhVQB/cFDoOJ7Y5ebKlxrX4/V7aYQQPN1LAw?=
 =?us-ascii?Q?DrXlfNYqSM6fOyCtgGSGglTt/LrdZaSqgURcq/4eY07468vVOnIMVS8LK4Gq?=
 =?us-ascii?Q?bD3mprGNo4ptMp+OGLJ6G1t+kfvwvfI1H5iyMjwDFe5wYwxdsjPMtvwLP/lw?=
 =?us-ascii?Q?KbS4P5AX/bYACI1MHW/SPRevpBKwHDFuum2UCJ8a1ghV+n0No3098E0vqkh7?=
 =?us-ascii?Q?1mqEMou6Ou3Pa6fU7q73D82ZN0cEf+SYQ7gNZhFrW5n05cuF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5306.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098c3bc6-6759-4f20-936b-08decb85f543
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 09:02:13.9071 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1oXanJXwe7kgyx80EXmJQTzBj1Ui5kcrMzG2d6J/01xR/KwM8FGflc96TF7AqNdlipFL7/BNI4PDC5HczNpdYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655
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

OK

Best Regards,
Thomas
-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Tuesday, June 16, 2026 4:58 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com=
>
Subject: RE: [PATCH 1/2] drm/amdgpu: add bounds check to prevent array over=
flow

AMD General

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Tuesday, June 16, 2026 4:44 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: add bounds check to prevent array
> overflow
>
> Add bounds check to prevent array overflow.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 94ddb8b98abf..0a2136668b68 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -5064,6 +5064,9 @@ static void
> amdgpu_register_bad_pages_mca_notifier(struct amdgpu_device *adev)
>        * Use this list instead of mgpu_info to find the amdgpu
>        * device on which the UMC error was reported.
>        */
> +     if (mce_adev_list.num_gpu >=3D MAX_GPU_INSTANCE)

[Tao] do we need to add warning message for it?

> +             return;
> +
>       mce_adev_list.devs[mce_adev_list.num_gpu++] =3D adev;
>
>       /*
> --
> 2.43.0


