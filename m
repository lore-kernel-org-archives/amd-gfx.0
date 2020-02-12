Return-Path: <SRS0=l6GN=4A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BD8C352A4
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 17:10:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7925920658
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 17:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ju5ndYFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7925920658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E0926F54C;
	Wed, 12 Feb 2020 17:10:19 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700045.outbound.protection.outlook.com [40.107.70.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE0716F54C
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2020 17:10:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNOFYp1lRllvDz8eXtRbF700m+FlPteuUjdSAMrtexHs1p45uw5Axois/4P15OsOZiKJTiTD6assBhwjMR4SHoYZqs87nN4IoTW+EO4Nzhjsrj+88NzlsiGNVM8og95HQkI63wU/FCcH8+gNxCh56i+1ueMGa1v2FSyA6ysnB/3VdkAPCuUg0ofm/0BjzySLHa+YJfUzDjDSlKu6xOIiDm2tnJKrlkMQ6mLfCOEeFSuRMIerpzhOCk8wspCKHU1njDfFGs37jo99v15Nr8pllgP2WiuRw8uAXfFRFvNXHQmu55P9Ewsx+Y54B6n5GrYnOa3G9NPmw0DpK4vB6YvFEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfKHzkMkrwPndp88BYRFyK/AhZ0dCZIC1CyTcGK8SPk=;
 b=OeqaJ2nQcQPII4bQWtvYpLIyqb5ysJph7GF9ttnhwSTlbcfk08uZGPbkP7/f/LFjOUBbQmNE+ICH6FusQj4upS8AsDodwI3bA8dO1BXE5xByKKKh5ze4SWIYf43uDz8732rjBjCrXCMRGGz3BMfc9/+W/SBDeypTOl8E+q9tt8aGPcgTLH+iTmeTz25HitomuybTyei9eexvItE80EjF5na1jbGYGJEF5+T5o4XTtsPf/mEZhx3v376Z+VNKIqNUZ5ALzIwCdMt9/MnU6aO/cX68+I+JK58hSMxIJy7SwFWC55wmvTgySVATGmzrBuGozK3XTiRGKgxr2rHP9xlYcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfKHzkMkrwPndp88BYRFyK/AhZ0dCZIC1CyTcGK8SPk=;
 b=ju5ndYFGAr1/Fg3BcZuGGrzorC0rQ6fMnaIbDbSx2qRPZxBrcwd3ZEL6o4R0pY895w5Qko9NBvULPWZTEq8TsLn0ew7mLKFm+Lrm1t+nwV4HRGiaKzckIr3RI0XpinSt6krU8E3B4fEtck1u7QbTNzDh4kF0sVBDPwK3CWjOxpw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2380.namprd12.prod.outlook.com (52.132.178.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Wed, 12 Feb 2020 17:10:16 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::c15:4b9f:526:4736]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::c15:4b9f:526:4736%7]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 17:10:16 +0000
Date: Wed, 12 Feb 2020 12:10:08 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu/display: extend DCN guards
Message-ID: <20200212171008.aotjcspebrtgi7gu@outlook.office365.com>
References: <20200212043258.1123758-1-alexander.deucher@amd.com>
 <20200212043258.1123758-2-alexander.deucher@amd.com>
In-Reply-To: <20200212043258.1123758-2-alexander.deucher@amd.com>
X-ClientProxiedBy: YTOPR0101CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::37) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from outlook.office365.com (165.204.55.250) by
 YTOPR0101CA0060.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23 via Frontend
 Transport; Wed, 12 Feb 2020 17:10:15 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f897e3d0-4cbf-4628-9c27-08d7afde6e14
X-MS-TrafficTypeDiagnostic: MW2PR12MB2380:|MW2PR12MB2380:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2380BB4628E9F32CC8C846F0981B0@MW2PR12MB2380.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(189003)(199004)(7696005)(81156014)(86362001)(81166006)(8676002)(66476007)(8936002)(66556008)(21480400003)(316002)(2906002)(186003)(6506007)(6666004)(66946007)(6916009)(4326008)(1076003)(956004)(16526019)(26005)(55016002)(478600001)(9686003)(44144004)(52116002)(966005)(45080400002)(5660300002)(2700100001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2380;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N2CxrPmDNLC7b1PYarYmJ6eEPnzVn4JOPNKHG9UDuOtcnzrRbg6bmMN/vNAcgnwUsC6MHVbTgKoxp3SgIbYOFCIMzuCqr45czDJ3kNWjFtS1YC3JBj7rT6x7/6CBoekqcLfUlUPewm1zi2DrBMf5qzoTdLidR5ND4m+EtPtB/IbVlhqcb2Fra9hN7wT4pIqc3OOzC/ECvKQJ9147Blp8ZEV5l8GYY7UGGEyPNN/t6djAZUTRVoXbXF51NVjSdxkOaz4Tg+MfY7IG9EW6zrd0mxkIUzb/0H2T4NHsFsOXee86OClJPF7slANmMFo6y5OPJ4uWZp3kjlFH9OmllISFLP3xYeuPGs/OO62UrBM5B61Kw0/jBw0jIGCtoXovozPY6MLEhHlTKq7D1G/DMll33HQwwqz0JC411q2n2QZvvVjrpUq3vww4vs1+BYxOHXEu97CgZKtY/DtkZJlfJIOYMyxzgbeXNFTqhhG704gQDCl1fKcW3/ykm7di0Sv+ix/JCofNuLbNPbjLYqoetinJnWpWNVe7VPUpo/dz7IgYtUQe1U13Uti4zSvArR6nuJ5CEmBUMUbQHdL0fLXpoxYPCU5ZUjxeofmtRwNLYnO2I9XjYqmusVBC3YI7SQheyOXa6wzuVxXWQnLUHyxVDczG7Q==
X-MS-Exchange-AntiSpam-MessageData: XwsfuLwRpbE1Ch+nFceUs68NImudEq596WJkURK5jX5XSz0Jr+XQhIn4nKIz5Y2+SQ4hneS0YBE78Z6/PHHGOlUaJ9FVzXuq2hXvjgAYjGy7w0ouZpzccbsU/k920wef9Gbcq422AIDOjnTrsUdbHQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f897e3d0-4cbf-4628-9c27-08d7afde6e14
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 17:10:16.2318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y96Pf6Xes5bf56YKJegqK96jULRjeAqie7VRS4hVLGyNTh6tiGXEIr0f7C4CvbMzbGLL0ihePsj6jPAEzLGpqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2380
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0190385492=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0190385492==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5mh6ixkjwrynyssb"
Content-Disposition: inline

--5mh6ixkjwrynyssb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Tested-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
On 02/11, Alex Deucher wrote:
> to cover dcn2.x related headers.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c  | 4 ++--
>  drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c   | 2 +-
>  drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/=
gpu/drm/amd/display/dc/core/dc_resource.c
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
> =20
>  #define DC_LOGGER_INIT(logger)
> =20
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c b/drivers/g=
pu/drm/amd/display/dc/gpio/hw_factory.c
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
> =20
>  #include "diagnostics/hw_factory_diag.h"
> =20
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c b/drivers=
/gpu/drm/amd/display/dc/gpio/hw_translate.c
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
> =20
>  #include "diagnostics/hw_translate_diag.h"
> =20
> --=20
> 2.24.1
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
=2Efreedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CRodr=
igo.Siqueira%40amd.com%7C912d22aa09094b1fb87a08d7af74b20a%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637170788079229843&amp;sdata=3D45YxJwNoUm5ViV3o=
uldnO2eCqeD4C3S%2FLyfLY4VRvs0%3D&amp;reserved=3D0

--=20
Rodrigo Siqueira
Software Engineer, Advanced Micro Devices (AMD)
https://siqueira.tech

--5mh6ixkjwrynyssb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl5EMXAACgkQWJzP/com
vP9UXxAAkHEPFz6eimkF5bd3bSgvIijRPCGMvGUZoMsaqSY2/dIj4xLoUZBvG1ow
e/M/ewLf9ovhZLPaPIUjLtqtjnurtif33pGc7VpNYBM5U7o7MVuCkNkDc+adOgGv
Ehe13moY8RAqBHqOkyg8nb884u7WWVBKvv15y/nAlHZrzrC8mhjaoub6lkSC3iZs
oVsEH9gtp++2Eni5OvEyyJ285KUVwBbqlrspGmf+R7TATNPcvBE1x3H9lCyNCnYs
LcmTOBFt6e1sRVe/P2+vtu23IzFPcesKPEUpduWGrzEtk9+WOTYnPRkU94+Tmz2i
MTrN7Tgrtn/NoxBnevlj3PxQhqTasSk9hxhlh4illJ4+Lxqv8AE1fXHZTyR5st+f
Kd49gyV5fKHqMMfOJ5rqCaXfrguk4HSkJTw9/1qZwjAizf8ZrOL8T+XIez0tJNOA
QgSyKKHbnjOGla8YPAr2NI328a2U90RHA9GNBfrwlG1BUxh0Z2sgXw8TNt5PhqG2
78GzBdrT9P8S3a9s3w4FpYipyeJwmPCNy+AYDGm8O1QhB+TOzZmL8q5vLdRdYo5U
oNiny3k++3J3WoW3momiY4g8MTR0sItbDZJEYk/z4MVmR3zbrbEhu75zOdTjs0vc
Ikyolo6lvEM8IAzCL+CrzDKJnx5I2M2cCq8EKA83iPFH+XhGHN0=
=5c3p
-----END PGP SIGNATURE-----

--5mh6ixkjwrynyssb--

--===============0190385492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0190385492==--
