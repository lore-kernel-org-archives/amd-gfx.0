Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB7AC5B572
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 15:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92AE210E56F;
	Wed, 19 Aug 2026 15:05:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YNs63QdU";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012046.outbound.protection.outlook.com [40.107.209.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA1A010E56F
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 15:05:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/rXL/uIRUOeub+wZSgJ9CNOU2h6b2qgKD1cO4r6lJMrBUpawnkhIk25RGKaT5rhE4sRb+UyPp1Pimp0XN2UQzNTcizWS5TR+4QBA0UPPvc6rF0dL27erSD5+Vd4ZaX0bTHGTgXwwIf9IztmRz10e+eWGx3S08Izx8+0tFvQ6GjUiOw4JxnSpX2Uho/ZkO3S5woeUYk26SxMCFFI9G0kRtadxKNFTnExaEYV0mQFP2QhcXTEdshMdP+SRCnTVXJhYoWWrpVOTBjA5ogYwLswwvqsViaYnk0dQcaSKif3Qm/uhQKcfldijlAfFRRDqpTZTWhVq9v8gSXi6veXtX50Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GcJm++cwHDrfbbNdgInSiMFnmj19v+aN1HsoBziIQc=;
 b=SzTKAPzSQ9rnkcrykIAPmuh6f4sZJQB+yMVgvnkJEBlQHP8IAKfP9G7LygeKir1VlRfkhvZOZP7u21yov85iE1hpuQh7Vj2uis2Leo0mRgwfdTCM4yfN/lVZ1UDJGuMbPQJfOKv+XuFK6aTSHtL/5RD/vLPuPk318vrpZ2WqlN/hmogTXAjpIpOA757jrUrI74i+KnJ02PZoWNRh2uPJRG1CPJgIzuanqKQj8uN27dhMEckhnDs/Mmu1osXxa8JWTYHz9L1xvKIj9Vi2M3c1qU2nSFRQ8siVdHqeejSHmrq8ePf5b7o4z7o2ozYxWv7e1JNfwp6DiIIl6LlUn9B5sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GcJm++cwHDrfbbNdgInSiMFnmj19v+aN1HsoBziIQc=;
 b=YNs63QdUEGXen5ayNZ3+kkwZUKliY/7kO11bwb0CrRszvb5oTc/cTGl2JK++8A6Fq4VxCLfzs8s87xnoLPc5N3f7piLs/xIH9ww281ZnV31kMNNv3bOz7AQa8Wy6c+4TNUXHtxpOlpOdeHI6YUtvOJ+VjkrW5wIMyZeC3cv7QIE=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by CH0PR12MB8529.namprd12.prod.outlook.com (2603:10b6:610:18d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 15:05:43 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 15:05:43 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Qi, Tony" <Haoming.Qi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Qi, Tony"
 <Haoming.Qi@amd.com>
Subject: RE: [PATCH] drm/amd/ras: Remove unguarded asm/mce.h include
Thread-Topic: [PATCH] drm/amd/ras: Remove unguarded asm/mce.h include
Thread-Index: AQHdL+uxRF29LG4BwECD+KWz6eRozbaleGmQ
Date: Wed, 19 Aug 2026 15:05:43 +0000
Message-ID: <BN9PR12MB5146DF50BF07262460A04A5FF7A52@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260819150134.2115118-1-Haoming.Qi@amd.com>
In-Reply-To: <20260819150134.2115118-1-Haoming.Qi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-08-19T15:05:15.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|CH0PR12MB8529:EE_
x-ms-office365-filtering-correlation-id: 9aa1f053-fac7-4c82-7729-08defe035716
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|56012099006|10067099003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: +crq7wfLm+vtuwX6/9xGI4PSbczMaIHJBS5D7Oxn3a79L55vzqpr21wyNHYf9sZJIH5I4JcM4hLihS6xiaEkOIw3SRy8U/nc2IEn7S8ZQVSF84j9UQ0HXOfPM34xj2+MQ1/FIzoXLFRFVle450351f4/F1sffpm1lKXKdWKeT7MPtY6QghEtq+T0e1PAICWYsePstnAVsVb+rusQW1zj8KhrNnNGBK1L9MrA4xP+OotJUbKVHs1DElSDR6gQXr0P+MUmUnCueccf0QtnH4bRP1v+eYZLzSbVOAVd0dA7y8Kj8xzZl9g7k6ju5njari6fIGuJ0d58nuHDQiCfCbIiagzY4XE6bmLjAVQfaQ7cxS/HtJemCnc1EHZvWgRPQtxuwZXyK42vuULvlJAUG0ksmAaP8btEIRIu4/GqTJcgpNlojGyBUmqyjamzz2DpbGRMLWuWfBQNaLkWMAyyfSEUCawvlrVO+PYni3SadI7kmEqk1Px3kxmLXxuAkKkHc79aqGgC/2VrRWA/F54tMfShhNDGJ8ElF5idjvh8JJSt6+xILXwuXg+QEAhAsuDwm7jS0ely2vhRXctfhKDM9GjThArycwVHoPViQUkfljFPJ2a74dBLmQYnbnipJa/aVJvRHhLL5N/gqqVo0b3aRegHJ/byCt/C8wuI+5rVHtH9f8IXZm2Ufwi9kvTUg2SYrYAjJveGWOeBJoItOOHipZ/qua+ia0n1fjN+BOxbZjVh6Hg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mG6cfBjsf/3INBHepMK9fgASnPdxAK7KBJWdKGZAMRbx7eazOxwVEkzE4mrf?=
 =?us-ascii?Q?NDzxsbGKiRvwckROPqarT7/VUm5b3NycJ3ZuG47K8w1xWvwU3hUW4y13lyq8?=
 =?us-ascii?Q?m8/vN+tu75BCZ26DpNAErXufmbh/muLGPvWVqiw/X4JiuLhx056oRWDLDNwT?=
 =?us-ascii?Q?R8yZoQrnzfxrOXqwkyr+X/XOFvjUR7OT/nfpTcQMH7cqnXlvDnnXJw1Jtvr3?=
 =?us-ascii?Q?yyfSocHmEDpq5PEVS2dXKVXeOXIfbjkPUF8bPzbF7BT+w54BNIEd1TqPaSRq?=
 =?us-ascii?Q?oJmsGsM+0gc5Ef0PYKYnWkl/WL3RFTQMglWcyaZVzhh5T6KE4sDBP8CcgyR7?=
 =?us-ascii?Q?ZEjDoj2s3Ii1S8QF+2OmYQI2ndzCGEJ7fRqnV8ZpY2/+tKfthr00lJCA1inM?=
 =?us-ascii?Q?R+ljQAbXE7gV1OWpAmWneMEw3D8rhyRjB6enAGPx3MoYM/9Bo+jEieYQc6yO?=
 =?us-ascii?Q?v2vD1DBI+uztTRq4bDhjfBisz9+ovJUnJ6tkreztDdcxws8dXHZm/5G/QS4w?=
 =?us-ascii?Q?h+0Xn9Su4XjFL1tuvj6kl1xT1x+yyDpbx8Mp7zSEJpxJzX+FECsog2zPTt7+?=
 =?us-ascii?Q?v09R/OeueWxgTCpjU1SzIQU9gWgt0VYuQca9Ul0H1f5DqnLlYahv6f5uMGyL?=
 =?us-ascii?Q?wOoIehILD453NszsJ1pW8BtTyeIsAbWgb2W/QI31TR4AXH2mjrfFlynOMaz9?=
 =?us-ascii?Q?V406mCG/ZPkCKqjuiIJEgAqYjOVLhBzZuwjh3pZtagvJsSPn5E8HvQfQz/Xs?=
 =?us-ascii?Q?nctVq90b/niDJ6G4bZ+38EpUpWQVbtqB4Aunh4xlmhvTBJ8rUqH6nnigXwDL?=
 =?us-ascii?Q?t3ZQdVJDPVWGFQdFYUusd2+w/2Z88RtdwyUSPO64Uq8NTsyYgCgfgNARgy80?=
 =?us-ascii?Q?gT2lcgefh0FpRNED7RwcTCTK+Jc+G/TNCOy9f5dc+Lpon1FP0udwzQSXuxWe?=
 =?us-ascii?Q?YlW2wQF/iJPXaYnwsmUgNWmXA24/9FThSiLslirI057nslHIfbNDe4x7OC5k?=
 =?us-ascii?Q?CIRsNvW/KdKelMwGr+mIMpP9WetuLkEfeMRpLsA09AfUrmayo1EmRbDSeWfY?=
 =?us-ascii?Q?2LiB1UHuWsvM3OWuvBIoWGyNGnpq/lvcJbfPmaGzNq2q9q/6DCZCJZwM1jZI?=
 =?us-ascii?Q?ddKyuMDDNGH9AeksLuU2O8r+gHWATuwJztsjMvkk7dxmBk2x9aPg95LWFMhf?=
 =?us-ascii?Q?JrrJFsMbQp0WOALiqjDLaSgV2a1S8JJPM5QI7Mu4xaoHhwBJwG6FWy5UYLbk?=
 =?us-ascii?Q?VeYMWUp9Az88b+wHCl5DxWpj7E6PzNH5ngYgXfQ1XF3m7YbL2N4i0w8iGr5/?=
 =?us-ascii?Q?n6fM0fzxFNNyVuBpWFB/sYKPDJ/hK48T6KyIKu0vnIDi6QSjbbV2/iy0i1OV?=
 =?us-ascii?Q?BQeT2eANfZ3KlQVR7zsDbtrQbVMuORSzJ2G6skEQTJ77kXIYiYxqTFlsp2fm?=
 =?us-ascii?Q?OSHINZD4gXvWEdAMD1X3+w1rdfTfB0wL+R3UgubfGSjhiUF6poMV0JbmjAau?=
 =?us-ascii?Q?EX53zTey9M3auFCvQ0ezgv8Je5tN/TUNXGE1efbC065LRQSH/P9c3FmJlRRd?=
 =?us-ascii?Q?sZek11vD8kaDmWk08N4fpHij39UwNQj1puZb9LW3XmhfpMPlky35sizjSA46?=
 =?us-ascii?Q?lgRoUB1qPhFr09ndoGpI1tXcDdLQw5QHsGv87E10rsfd4uWC2eyR9Ymugyk4?=
 =?us-ascii?Q?EP0Csz8C0WjqqMsK8u3LJ3+wKfDAW+5TzT1qx+Tf5eZD+SaI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa1f053-fac7-4c82-7729-08defe035716
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 15:05:43.2076 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: foecgVkgXu74nbYZUEVQKAXBi+4Om6EKIlJEDwhjJqe2hpV1jJPNASHNeaKyvX4DiF0ekXOOgG6cb22KhMe2cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8529
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

Public

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Haoming.Qi@amd.com
> Sent: Wednesday, August 19, 2026 11:02 AM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Cc: LIPSKI, IVAN <IVAN.LIPSKI@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Qi,
> Tony <Haoming.Qi@amd.com>
> Subject: [PATCH] drm/amd/ras: Remove unguarded asm/mce.h include
>
> From: Tony Qi <Haoming.Qi@amd.com>
>
> asm/mce.h is x86-only, so the unconditional include broke non-x86 builds
> with "fatal error: asm/mce.h: No such file or directory". The header is a=
lready
> included under CONFIG_X86_MCE_AMD with the code that uses it, so remove
> the redundant unguarded copy.
>
> Fixes: 1c46b6971260 ("drm/amd/ras: Isolate ras mce handler with
> CONFIG_X86_MCE_AMD")
>
> Signed-off-by: Tony Qi <Haoming.Qi@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
> index ad978ed45843..0edb3dc06a69 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
> @@ -25,7 +25,6 @@
>  #include "amdgpu.h"
>  #include "amdgpu_ras_mgr.h"
>  #include "amdgpu_ras_mce.h"
> -#include <asm/mce.h>
>
>  #ifdef CONFIG_X86_MCE_AMD
>  #include <asm/mce.h>
> --
> 2.43.0

