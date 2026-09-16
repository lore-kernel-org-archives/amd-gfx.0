Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F34C88E75
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 02:33:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D72A410E069;
	Wed, 16 Sep 2026 02:33:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JXCSP7a0";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A980B10E069
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 02:33:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0LG36GaIzjH7u/6brtU2Fuwjvta+z1BEEZyzxkIR8u/B2ZqpHx97VxW4KjKSOpoNBJgoco0l1kCZMuOgcVhPIvtdwmOXeMF9i9r/8PNdje34CAxhpMhdwXJguKYSi4GCuQ3XUWVGN1fEMZeJajR2n9d2CG0YaKbAAegTWFEHMPX2WK5NAdfLFSk1hLlr7xwu3KjatxsMyKgkh+Ponpe/4hfibUjpSbs5EBbi1BRJWbUTDtzNrjYuKpXlVgllJ7NltQxYRrVjHN5aP++WiHg1Xv8fMFB/xyJaPqsC6ZUE/LUxsmQ5vLC2zyW1tL3utOgJiFAofHPWm7aef8D2HWirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3x0eSNw6CMBoQsnygVz1S9O2/gzebyDbDrJC0jGo+o=;
 b=OC1PDWAkzfuNKOln47WIIArFFCqUrbSrudxdKdBnH+ENKouI+rm65a/ghMABefscdRcEOrHBN9YRWER7dq+L1ep7TLEcga8HDdQnXnNT9KSCm+h3NPj0b4Vcuh6Rmu9yjze2/wXb8KSb5e2qvnxUVdOQcL0WnQZvfXN+myFDsr66hjffERdSLK/RVLmxtyYmn4J9Se1+F+vyNSI99IBLhmwkwk8LZIa9WG+Em2Lg8LX5y5DgufGw5e6vy1DrtBfdOBpPzPJeYE7OCq5N4HI/A3kAg6fXLeZK9GRhQhqowe1VWpieWEF+367gjHIKwwRoq4/NcGVEZMCkhrY5X1gGNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3x0eSNw6CMBoQsnygVz1S9O2/gzebyDbDrJC0jGo+o=;
 b=JXCSP7a0Culhndl/KlZNdGSYJMqc4u+jWLHMyNcBeiv3I8hRKasZPRdoICqytf4gxgs36tMllqg57rU8gs+mX/dvyrZi/VQedMtaVtDnScFRaMyyYltZCjZyYVq2homltKNh5DRdEBf0jK2PItxL0AWnI0lFvepxhjacXc+Kg1w=
Received: from CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5)
 by CY5PR12MB6576.namprd12.prod.outlook.com (2603:10b6:930:40::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 02:33:50 +0000
Received: from CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85]) by CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85%2]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 02:33:50 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip ras error reset in gpu reset only when
 uniras is enabled
Thread-Topic: [PATCH] drm/amdgpu: skip ras error reset in gpu reset only when
 uniras is enabled
Thread-Index: AQHdRPbfdRO7zAAcJEqr4bDOgvkzpbbQfQOg
Date: Wed, 16 Sep 2026 02:33:49 +0000
Message-ID: <CYYPR12MB872970CBB6BAF4A5875D28AAB0B92@CYYPR12MB8729.namprd12.prod.outlook.com>
References: <20260915094442.108755-1-cesun102@amd.com>
In-Reply-To: <20260915094442.108755-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-16T02:31:25.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8729:EE_|CY5PR12MB6576:EE_
x-ms-office365-filtering-correlation-id: f70ced9a-eccf-44da-5f05-08df139af113
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|38070700021|56012099006|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: aNx41x4m/fAL3WiIUJKYRqz4aQhpxiSKUEOF56rwD+5DKki/6OqyTYQa9iefiYPAMC427HDec1C7oLo7sOiJ0rBvQwTWKEMLfk3yXuo5xB/8QGVBooT7zBTZ5ELIvKM3U+9mNe4ZArG37PMkVO3ujsW/tmZSlH5SXNAtxavP2FVqkE+advWZzXinGtA/YGCvTK+UqUcK7/vttDoYYoCLyH5zxrdnFaa8lEhJY+OReHh1WXIIGX3KE4UCnEejkVy0DT529l10wQ7cDyhMinaziieP4841Hj/V9LqwmAkW2K3xSlcBSHmxkfe9I8nhOJANBMXwlMOpsfgJtLr4QhuswPwsgjBp0UN5y4Zd6tqrujardBZ28y2ekx0EHoumJa3wlFTzIZjOsvQl1aKDUnR/1KkMwBb+jk4nqhcUmme1urf/5/0+FePwSRBzkmEmLHkq4NX6/i0PKtp4YnFQXtRFIBYrVI7deLgpAqWcgMWgvxqc4Helao8FWP6k4C+WoPMVfUvKQaqjh6k6Yzrs2hnyIAOBz1uNqg/QGtAwzXhMdCwDLnzYO9bY+TykcLrW/KE4l6Z7BeYXSbrVav4rdsRiZ7kWjcP3O+o4Izb3Ci/B4dsL0zs0GFfoSzvARWFucXQeGJcwbIszIjtAIVQ/UcnPdlvx7+HWRJ/vGsReOdOuHljfg+jNH5CK4YUJa5QWm2ST7QRu17pjn1UxUmPC4C4tuZdYlpIoB7AowcOBS8fWc1Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8729.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sLmKrlhqzSamEssozSygcG8jJcoYv1Hr6397eQNv4aanpGemCdRPWXl7ip6Z?=
 =?us-ascii?Q?RejmJfcJBnXLW2QvvoZ5oeFLCesskHyx2wJgz4VyBw6NiPFL5lF/LcwXyOwt?=
 =?us-ascii?Q?bm/heDV9+1Q58rumd1FJub4MmhkzvEbzIfzaVumDQs8EoSlmn6QK6E+2nvTR?=
 =?us-ascii?Q?egUPeqY3/ODzyiSxIP9j1jgUqPkVeeMXU70enhLdgmNKlkdwuRx4nyD/QBsz?=
 =?us-ascii?Q?W/RZxlEWWBwJwAgvxNBAPglCsrhoWy0yB7XTyoHVv06SIIVFAyT+el0x2kO3?=
 =?us-ascii?Q?PXqujM/2ZbbAfYz7Ox+/2Y1F5FyhhQksDjr4MxO4q0OIiR50sxoGe6odZn4S?=
 =?us-ascii?Q?kEHVSkF22kTiSdFDuVvHRFmH9PLM5d8cHS45P8dLgPmMaxxfXEe+M3FSMNsL?=
 =?us-ascii?Q?8g98jDTLrwGzoXRvedvQNrKzNFf70tqPLFrnK+Qk0seJU+uLtcZyQuywilQT?=
 =?us-ascii?Q?hcrvqIP5rsyBJi7M0wVEZ+ybuv06vTTfv8HnmK0uXBbBj+JhZZjnVUtc0GBv?=
 =?us-ascii?Q?u9mSnlRHOXiZliI5kOCsSHE6k49foGtS1qq7f+EBF27qwP4m+NLNg9NzIdbb?=
 =?us-ascii?Q?Nk3W3MFrHAAF6SFbfPHJL4LWrzRT4G/QikTq23XvCoyKPEyLXgDYYY6mcsUI?=
 =?us-ascii?Q?ib00D2v7SP2JTBjRT5IHSqaUjRTHmiZPa027q41Qjr9D3VpwQFmO3uN7n5ck?=
 =?us-ascii?Q?cFOB+u8hwaylE+5VpCMF5lqU0tjRMBMXLUmU/3owy2uwdYpQ7Uoa9024DsPa?=
 =?us-ascii?Q?3SeTAXZddbjjopoFhfmVSxrfcWHBuS/MQUHqBFTN6DkxU6TyQvVusMOYd2YN?=
 =?us-ascii?Q?N2QlgtG2Jzexq5kxtDgKZalm1a3LKsJ8Kcsq1M9ZC23d2YY2jdg01EbBg6L3?=
 =?us-ascii?Q?xGVGVyHTK6bHwxz059uU9Yis92Lo9wkArCJCh5kJ/BJcMlnOt6tcUjX6dtls?=
 =?us-ascii?Q?qJq5xFpyVhV7gTAqXLmpNCw9YVXMbO0Tj3Htl2+gwTvxTAzYxL4cQF9uyw60?=
 =?us-ascii?Q?39/Zkc259KkAYlpQblX0cX/h6F6tZ5EYv1u49Gw3PiqUr+qvBXLziehojtP+?=
 =?us-ascii?Q?kQisRiBr4eiC+b1mWGEyTRQvUiZy0BHgPbXmfX55NXg0pDV5J0tcyCvnRFl2?=
 =?us-ascii?Q?NCAnfUG7TCc6+WJWMNNhD5r12bSc8DmYIMP+W9l/T9hCouR20fVMDgEU3GGL?=
 =?us-ascii?Q?MHjchdftM5pxfXGO/xRJutLULdJaky4zpeprjd3qEUEdaC7KMck3Qgqh1SbW?=
 =?us-ascii?Q?aSvcHbqdFi5zgwN5NEjah/erpJXLvpt2MyAmRi2qavZQrETn3dv4wsaJ1HJk?=
 =?us-ascii?Q?HtuJfH/mpagb/nxV/G35u9b4I9DI0KqI1klPtKE6RbqqvbufpaWqueOfKv3V?=
 =?us-ascii?Q?odWhbV5oeRXnQqC1rLbAemod01S5wjRBdGEfhtuZqW7OaFLyYShyeTGS0648?=
 =?us-ascii?Q?f9mOzdekcsapi2QSlstfmkGqnyyTEo+NTVAMoujEmgYeBMZX6OknTOaecsU2?=
 =?us-ascii?Q?W9dVKFFa0eT7YZ0i7GXHvI7+wt8CSHJEudM2Z3UYr5BsnNAdxDxaPGAw+x7Y?=
 =?us-ascii?Q?Wf9vcse7qHrsiX3Y1XLNsNoaTB33owvYSTAqbE5nszd0OYRmQ3AHBq9gZmo3?=
 =?us-ascii?Q?sEDSlWL1oU5lbUOcYE45x8jEuzQRPlI8fRo5KLmOsquly8xm8alyUCdtiKjW?=
 =?us-ascii?Q?XsmX+ly/Q887kLtc1/YPs3/V25mALh8dM293Luy5PhVLugj5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8729.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70ced9a-eccf-44da-5f05-08df139af113
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 02:33:50.0082 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SR5ep6BVr2QiAScBTKsp5f5J0qokFUIr7zSvKCqtRLUZJJ423V6NnBh8JDNfoafa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6576
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

It's better to explain why unias can skip the operation and ASICs without u=
niras needs it.

Regards,
Tao

> -----Original Message-----
> From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Sent: Tuesday, September 15, 2026 5:45 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Subject: [PATCH] drm/amdgpu: skip ras error reset in gpu reset only when =
uniras is
> enabled
>
> The original logic skips RAS error reset whenever GPU is in reset or RAS =
recovery.
> This change adds amdgpu_uniras_enabled() condition, so we only skip the r=
eset
> when uniras is enabled. For ASICs without uniras, we still perform RAS er=
ror reset
> during GPU reset.
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 6b2b8acdbf9b..c65916d84683 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1513,7 +1513,8 @@ int amdgpu_ras_reset_error_count(struct amdgpu_devi=
ce
> *adev,
>               return -EOPNOTSUPP;
>
>       /* skip ras error reset in gpu reset */
> -     if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev))
> +     if ((amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) &&
> +          amdgpu_uniras_enabled(adev))
>               return -EOPNOTSUPP;
>
>       if (block_obj->hw_ops->reset_ras_error_count)
> --
> 2.34.1

