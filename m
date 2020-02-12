Return-Path: <SRS0=l6GN=4A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C8EC2BA83
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 15:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D0CB206ED
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 15:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2XMtCdy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0CB206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 230576EACB;
	Wed, 12 Feb 2020 15:40:46 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760072.outbound.protection.outlook.com [40.107.76.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1DC06EACB
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2020 15:40:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hlz4e+azcnsmZALVfaCS01Za4lpmclW08RiQMd1TDBcLrQFE5LXKISv/D2qAXd1bckZvMkDncuMx4fcO0LfaBGwvj9zTCkTBcU4y6fvSjhuliUnIs5NAPdB0CZRiS4baP6/A+HWd3oay03dLF8/St3swIWg4f2bp7cKrFOyELncXvRe5neFnViTblBZtVnqIpSgttQtNo/uAkGzR20hO5yIoYZjdXvGUTQ7g3dmbjbZsQZzEAE4e+gFmjuKGX55MvafcCZgL+5+GQ7Qg7pTC+Whh9uBnt69we03LpRH7cAOKyPX6FlsWe5CoFh4qllGNdQyeXZdl/415dw1hMp5gcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RM1TLNe0YrF9BTIVLsIvEWUl4LlQ23DIHb4Nw6z+Yvw=;
 b=FQe/tGnxnEEeCh/GDZAkI/dGYj3YVycRxJN5RfVD5Pg+saY/XeUuS/j7uch2pb4kVGxA69kWWU05ulrimwxJKa94WQs2HuiNSgyOyTtv2QmUYKOmMZo3F/yP6Ay59VcoGpZNXJpDLbZeyZY+CYuHNlgyL5R7me9kHJh8aLYRQcXcWFCIM6IOcts0dY7M2NexLLuBECstiqTzdlwbPr2Ho94R64SFjazFeWE32UqXDElE8eKYCHKYuOQk7c4xzKw1OlsBB/S2mJSTlaQRNbZ0CWp+Om8LA083w8jt3fXenHQzRAxio9EJJ/4uj4F+9J9k4wQ+ljlZPIusLj6sM9o6WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RM1TLNe0YrF9BTIVLsIvEWUl4LlQ23DIHb4Nw6z+Yvw=;
 b=2XMtCdy7Cue600+o7di1P6FL755rWw04ayHqJKlKF5lkKX6d40yd24HISu+cIoAr+7q4bABGlkRBHrONBo7WD2LWsg6Sb7tFxzg8pHwghOHuJ/0IDXxHfYyF6gmyIIuinYliPJ6BZN2/brA/oOOYt3uLPEIcX5gMDGH5LGmV+oo=
Received: from DM5PR1201MB2554.namprd12.prod.outlook.com (10.172.92.14) by
 DM5PR1201MB0139.namprd12.prod.outlook.com (10.174.247.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Wed, 12 Feb 2020 15:40:43 +0000
Received: from DM5PR1201MB2554.namprd12.prod.outlook.com
 ([fe80::f4c6:42e8:77bb:d721]) by DM5PR1201MB2554.namprd12.prod.outlook.com
 ([fe80::f4c6:42e8:77bb:d721%6]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 15:40:43 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu/display: extend DCN guards
Thread-Topic: [PATCH 2/3] drm/amdgpu/display: extend DCN guards
Thread-Index: AQHV4V2XIECQY1cfC0yKZPAU6iaegKgXsjzw
Date: Wed, 12 Feb 2020 15:40:43 +0000
Message-ID: <DM5PR1201MB25549330C7C5F6289CB624B79E1B0@DM5PR1201MB2554.namprd12.prod.outlook.com>
References: <20200212043258.1123758-1-alexander.deucher@amd.com>
 <20200212043258.1123758-2-alexander.deucher@amd.com>
In-Reply-To: <20200212043258.1123758-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a7f513d6-2ffd-44e0-6143-08d7afd1ebd2
x-ms-traffictypediagnostic: DM5PR1201MB0139:|DM5PR1201MB0139:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0139FFD662A0E125D8ECBE329E1B0@DM5PR1201MB0139.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:431;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(199004)(189003)(8936002)(478600001)(71200400001)(86362001)(81166006)(4326008)(81156014)(8676002)(7696005)(316002)(110136005)(5660300002)(186003)(26005)(6506007)(52536014)(53546011)(9686003)(55016002)(33656002)(76116006)(66556008)(2906002)(66476007)(66446008)(66946007)(64756008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0139;
 H:DM5PR1201MB2554.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7BZIIeOjRCjZdNyg57koQ8iEIsGH78xvEsRBbdTMW9Y899rbVeMlLp3wJ5ZvaDs2udY8PN+D4p33+nEraFKvQiI1vytGq+1J4bBZH/mV8JsSp0vpzXokbPVmqPegWfqpPteRUrkHKfKazMuj2Kx6Ay2WkrLtoITuzgU2GmU7P/+I4JWxqprkJI4l7ZFxwyeJ8sXKwUGKrmgZmdUomLfCpEtCvId+NgArCjZ8mrCNFPfKkQQWjC9jfPs3FhiSZgl1CljNzioDk801Oukv8qryqW3E1CjC24DfRJXMFC00y1POJJ46SEXEd9P6p8NmW50RlKC373Zr1kDFzaBiOjtNXgoP5Qw1R/i5FM6mTGydVvU8H90awp/HHojCUQlAHdo77WmE0I825dPSIpODIVFASoyqN3uSETmYe5qZXi+UO8v84/0aqr2JOxdrJedZa4zL
x-ms-exchange-antispam-messagedata: LlLSJurArfYhfoV2/oeUzPw4XSg4DD+Hf26A++MYdgltkKAzO/UU1OsvYlcSTxdjqKaLJmTqikL6uth+jwQpCF55hgGABfIOkbCPpGfVUxuhE4pCOp6OZKzWKOOUZ+mN7obvyMKG8lO4OTt1HZOhbw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f513d6-2ffd-44e0-6143-08d7afd1ebd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 15:40:43.4174 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GljFn0kw85ZRFAQ9c69N12cO7HeLZawhxdDkWEIO6/PV3xz4tSv0symonI74vumR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0139
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: 2020/February/11, Tuesday 11:33 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 2/3] drm/amdgpu/display: extend DCN guards
> 
> to cover dcn2.x related headers.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

This patch is:
Reviewed-by: Zhan Liu <zhan.liu@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c  | 4 ++--
>  drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c   | 2 +-
>  drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index a65a1e7820d6..c02e5994d32b 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -46,12 +46,12 @@
>  #include "dce100/dce100_resource.h"
>  #include "dce110/dce110_resource.h"
>  #include "dce112/dce112_resource.h"
> +#include "dce120/dce120_resource.h"
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>  #include "dcn10/dcn10_resource.h"
> -#endif
>  #include "dcn20/dcn20_resource.h"
>  #include "dcn21/dcn21_resource.h"
> -#include "dce120/dce120_resource.h"
> +#endif
> 
>  #define DC_LOGGER_INIT(logger)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
> b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
> index d2d36d48caaa..f252af1947c3 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
> @@ -47,9 +47,9 @@
>  #include "dce120/hw_factory_dce120.h"
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>  #include "dcn10/hw_factory_dcn10.h"
> -#endif
>  #include "dcn20/hw_factory_dcn20.h"
>  #include "dcn21/hw_factory_dcn21.h"
> +#endif
> 
>  #include "diagnostics/hw_factory_diag.h"
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
> b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
> index 5d396657a1ee..04e2c0f74cb0 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
> @@ -45,9 +45,9 @@
>  #include "dce120/hw_translate_dce120.h"
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>  #include "dcn10/hw_translate_dcn10.h"
> -#endif
>  #include "dcn20/hw_translate_dcn20.h"
>  #include "dcn21/hw_translate_dcn21.h"
> +#endif
> 
>  #include "diagnostics/hw_translate_diag.h"
> 
> --
> 2.24.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
