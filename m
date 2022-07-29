Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3843DC00144
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jul 2022 06:06:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F88010E265;
	Fri, 29 Jul 2022 06:06:10 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2043.outbound.protection.outlook.com [40.107.212.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B38F10E265
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jul 2022 06:05:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpSmNkJxrwD02DnJ7JISmkGY1vRYpFNhtugn3e5BTnPZijb4hP0N2gZvidclLVK6JbJ012HOGF5RQFvpe0RK4+L4XNswx+ruSzHqAx0l2QRMqwEJ9qOL3sASSZBz3u6y3SsiDeHiKH9ids+P8TUZncHU6Q4P5lzv7R/1/Fvb36tOjeWEc2J5UpgBByaDcDTailDWERwp09xca9bSrCP28QpzD6ZIe9KjtjEisaC06CAAkQ5u4d2m5XRTZWUNzOYUXco1mtI+vbAx6UwJNy0N/wPBrkdKc2quxw6GV8Gjio0a2BCr18ACO/9M5/beFf2EAj41Ag0YVJ54yQOE//vowA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GPIupsI7KoDKW7U71OKmjHAoMynzgHyV+yhhQW8e4I=;
 b=BJ+0BZt3e51+UoqwAq3dyO6o939TZ334ZmxCdM6UNFzBgtqJLW5jbiRdQZncwRN+2DgtsoJlUgAb9B/PsGFpeR/S9FZug1GKfXhQqI6fm1HWhNLQJvz2OD8TP2B0HZX15LCIbm6qLVZrkZlrrz20cxXjrh91UzhwpC7uV0fqvoxhqvDx/vlpcXnAP6pjyN34jK43o3t4F/YVeSnyWdCSxcScg3B6hB+C66DR5HqSoscB88Xr+Z90cGybxzlQcLV6skJbkY0nq60k2ysgGZpQr6bgyArm/GzypqkA7GZHC+8G+T/HbR9nJNJ8M98qdJIiZ+w2AJUlPq74kuIo2WKBgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GPIupsI7KoDKW7U71OKmjHAoMynzgHyV+yhhQW8e4I=;
 b=awLBcqXwzdFxT9YA6ogfopJaPRf4Wh0GLMnhkN1M1WOpJL9McWPJw4azX1nDeWDI1D2Z+sFMr4CNJfpdXPh/ecBRP0a0d/rmhb3Ky/OVLhV+6y3im6Tc6B0VYGca3PJNiPDRXssInGok5onrGmSDRsVS5xvwFgHnAyduu+Xz6ZA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 BN9PR12MB5337.namprd12.prod.outlook.com (2603:10b6:408:102::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.11; Fri, 29 Jul 2022 06:05:45 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::4c95:9b06:87e6:4382]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::4c95:9b06:87e6:4382%7]) with mapi id 15.20.5482.012; Fri, 29 Jul 2022
 06:05:45 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Zhao, Victor" <Victor.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 1/6] drm/amdgpu: add mode2 reset for sienna_cichlid
Thread-Topic: [PATCH v2 1/6] drm/amdgpu: add mode2 reset for sienna_cichlid
Thread-Index: AQHYom0dkWw0n/ib+ECzo+0OXmkV+a2U3LQg
Date: Fri, 29 Jul 2022 06:05:44 +0000
Message-ID: <DM6PR12MB26192D26D9AD1756ED5FC27BE4999@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220728103027.27255-1-Victor.Zhao@amd.com>
In-Reply-To: <20220728103027.27255-1-Victor.Zhao@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-29T06:05:40Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9c3ffb05-c29c-4384-a23f-dd25f52f7785;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0257b723-6691-4afc-2783-08da7128601b
x-ms-traffictypediagnostic: BN9PR12MB5337:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RCebeC/kSIgsnSaKM0fxa5rhkQi0rHQc0NpA1FS3tTbAstDYFc9uQdfF5vzmmdOklMrtIuF6kvtSWSWX6LJCM63bPawlsHoTwhOYapB5KEW1LplyJYuPEmVUX3539V9CqRjnGzjVYu0ZSgvd8MNI4FRTKDE9D+9GDAawDVp2OmC7e7K7Ir+eejEt5Qc+gnB+R1yrY0f4Vtgce2Fq/rnGw2AvBhk7qslwSF4u3PiMl3H/5f1nQWhbgiEKYwIj1FzuxQUB+QR3OzG5SFW3avWBEPAGL90QWfR3Pe8PirtGCELpjdK9/Eni9E38MYSpP2aaByvrA50xGxCR/226jpR+31G9CKwZKXd4icEcl5XrgG22215d4bR4Baf/Wbx7KX0HQSdjuds88ySDWNNwsqBZDw/GFfR+rAeFZ+TiSizt0fOrEPCMC7XJXip7X5hmuM3b4E6xhgUfNQ7zPtZP2fdE2+HtFyO9N5ywigRWvRmhEbo/esEOjfMFSjiJ2iCaijDGqn7i5I20SqlMMS11Fim9bXuay8vVkaOrusst2AnvGokJigMX9PzjAA9Kpst7m+yMj5vu6VPv8siPyu54NcOTL/RriLc6GICg/F6lSyZYtBSyp7nBTBoX/6L/1R5oORJ3vJon1kSOWS6ww36MsIQ618JQbGPwlLTmL455YuJzJI5cGc2IhsANVIuYXrlK1bi9qDK7RvZSFcNV+OJ99s7y9kgs6Z3eN3CkGAfHjJ/Ji2pGhAfkS68pj5PYgEkq8gxdaRuIKZudQmzkCb4TQMV2X7aE7Jl0l4jigmQkqu+1HEo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(26005)(186003)(83380400001)(110136005)(66446008)(64756008)(8676002)(66556008)(66476007)(76116006)(71200400001)(54906003)(66946007)(52536014)(9686003)(2906002)(7696005)(53546011)(6506007)(41300700001)(38070700005)(122000001)(38100700002)(86362001)(55016003)(316002)(33656002)(19627235002)(5660300002)(8936002)(4326008)(478600001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5VhMcAsVHrg33q5RBPwdk/UxtdA69S2KE//8h6EYExHuzz/5dh5B1EH1+lFG?=
 =?us-ascii?Q?tbsfoBV59Uci7o+aSQ+dcHSu5ay/WpANeNfXXn74rEC+GEHBiAnahOECeI3J?=
 =?us-ascii?Q?KSIt5KN78Kckqu01D59rRxTFm5egUSCvHhlPrQJBPRzfmQPMaIzGzB2KlO6S?=
 =?us-ascii?Q?XeJXaQYox8s0YV6MPFeBi+pRYvghXUETdHcMsRFReGpodQftu0THyfrZcPIm?=
 =?us-ascii?Q?AJrTgRCHQkNvMZBI0JRdNPhFV3tJsFWOsV0sI2dhXz5KMLWbKAkOW8o8L6N4?=
 =?us-ascii?Q?HvII/tfIZj3FCPfDu71hKgIfHveG8NG4i+Xp4j4rTc3q2Gjsf8a/Kf/+RO/G?=
 =?us-ascii?Q?rVo30t3kdvR9ZmeK0erPzvRaTlTfa53QTqRAJQYK+xxxgzlb31CmmVIy5Xrn?=
 =?us-ascii?Q?30UYPhbTrgb9s0Qkh7BiAry/f9mbRemhG4Oh/dN5xJnn0JNeEgf58IIQp6ld?=
 =?us-ascii?Q?wRFFiAOiUBeUCZZUR9LTGWLAFHkLVrld0aZeaeTOjoO9rAFTcjwWwbGSLyD8?=
 =?us-ascii?Q?GW1GrlPW62kWMA+jnSCn/scgJADXFtkulTpuDwtZxYsv2iM4RAP+I9jY0ka/?=
 =?us-ascii?Q?+vDPVbNBFuZhRgvGfCtqIeWoDcYniHCQvGrIvBJr6z2BaNDe5WD+zG73R2kQ?=
 =?us-ascii?Q?qOOIWFnaMftxLt3hWol9dMmrU6Uf8mwVAnTrAcfUzpyVwv238MmtVApi++ix?=
 =?us-ascii?Q?Ym+QPpBnHReyg60oxp4DCElvo+LkkTlD5t6hbFn4aTz81b4oyj7qRF4uci3+?=
 =?us-ascii?Q?m8opv2oPrtwfIA1bPMdyhStxYFd9rlkLQ6JWCuBy2hCMKAnbkt55S7apVxRw?=
 =?us-ascii?Q?qpEyHj5UQ8IHLHWGI5+oZZYchnuYKicQJgB/WhYtRD9qWT2FMCA3zVAeQTO3?=
 =?us-ascii?Q?sH0KroJgDhcN5bdzlfwLkaq5QID79Gli0T/dgY+JFCfDrxoPHM9KN+AM5QFp?=
 =?us-ascii?Q?KslKNUzWJYAZ9NMB240oX7u0FOwr8SUgNuxiOszLoIecPDIXdByBKKq4EL9U?=
 =?us-ascii?Q?VruO3OEMES2sUihh9a2PUnQCj5uQKJgSKKbZgtLX6guuBDg0WJhgPZ0sqM2F?=
 =?us-ascii?Q?dXIydthwoj2klJyXzQJ1jx4CjFP2IL/KIRce9iHhqdTprzbXoQzQ7KzqB0yg?=
 =?us-ascii?Q?ZflDxV/xba3/phSXufpZCiQwNXZ7eXAK2u9Ov1FFQVk2lyQA2ceOKOjuMt96?=
 =?us-ascii?Q?61cyLkpssUK2+gygEWu00wJgSwz/ZiDQELG2R+FaWJJu19uAJCOSuMHJ8Mve?=
 =?us-ascii?Q?z52uJOq4Sm5tV+3wC73cEbXRTjPu3WLJHXh6s8HEny6Axph0wqz5J7bEADYy?=
 =?us-ascii?Q?bPPiZQr+Y8LKGSj0pv82Q9M1RLDsrbt8Brew9UuthxAPJc4wSchI1bYxHLnc?=
 =?us-ascii?Q?O8HzgY9j0TtJzzPbaq73r9ttEvaht7L/Qt8jCGXt4UfQsbN+Py0L2Eyf3Zi4?=
 =?us-ascii?Q?CABaPWiXnCRtbCA+DNzUOgQCjL6oOnLks0fkLfuIWicHjy3y231fw+xii/Id?=
 =?us-ascii?Q?L0cAI6cyibeGjcx9Uvu+yFGZgB91xrqOqTV8TFM8/pRYdI6w2UOgfpulh3XI?=
 =?us-ascii?Q?YYZVvcrOSI14fv7LT8g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0257b723-6691-4afc-2783-08da7128601b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 06:05:45.0744 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MdWFOLJpaYEwU2VZ3owuDwihZ7gTbViSZ91ImQW3gZWilAhGc7Fg2cSSeN1xrtzT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5337
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>, "Zhao, Victor" <Victor.Zhao@amd.com>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Victor Zhao
> Sent: Thursday, July 28, 2022 6:30 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deng, Emily <Emily.Deng@amd.com>; Zhao, Victor
> <Victor.Zhao@amd.com>; Grodzovsky, Andrey
> <Andrey.Grodzovsky@amd.com>
> Subject: [PATCH v2 1/6] drm/amdgpu: add mode2 reset for sienna_cichlid
>=20
> To meet the requirement for multi container usecase which needs
> a quicker reset and not causing VRAM lost, adding the Mode2
> reset handler for sienna_cichlid.
>=20
> v2: move skip mode2 flag part separately
>=20
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |   7 +
>  drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c   | 297
> ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/sienna_cichlid.h   |  32 ++
>  .../pm/swsmu/inc/pmfw_if/smu_v11_0_7_ppsmc.h  |   4 +-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +-
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  54 ++++
>  7 files changed, 395 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.h
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
> b/drivers/gpu/drm/amd/amdgpu/Makefile
> index c7d0cd15b5ef..7030ac2d7d2c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -75,7 +75,7 @@ amdgpu-y +=3D \
>  	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o
> nbio_v7_0.o vega10_reg_init.o \
>  	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o arct_reg_init.o
> mxgpu_nv.o \
>  	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o
> aldebaran.o soc21.o \
> -	nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o
> +	sienna_cichlid.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o
> lsdma_v6_0.o
>=20
>  # add DF block
>  amdgpu-y +=3D \
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index 32c86a0b145c..f778466bb9db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -23,6 +23,7 @@
>=20
>  #include "amdgpu_reset.h"
>  #include "aldebaran.h"
> +#include "sienna_cichlid.h"
>=20
>  int amdgpu_reset_add_handler(struct amdgpu_reset_control *reset_ctl,
>  			     struct amdgpu_reset_handler *handler)
> @@ -40,6 +41,9 @@ int amdgpu_reset_init(struct amdgpu_device *adev)
>  	case IP_VERSION(13, 0, 2):
>  		ret =3D aldebaran_reset_init(adev);
>  		break;
> +	case IP_VERSION(11, 0, 7):
> +		ret =3D sienna_cichlid_reset_init(adev);
> +		break;
>  	default:
>  		break;
>  	}
> @@ -55,6 +59,9 @@ int amdgpu_reset_fini(struct amdgpu_device *adev)
>  	case IP_VERSION(13, 0, 2):
>  		ret =3D aldebaran_reset_fini(adev);
>  		break;
> +	case IP_VERSION(11, 0, 7):
> +		ret =3D sienna_cichlid_reset_fini(adev);
> +		break;
>  	default:
>  		break;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> new file mode 100644
> index 000000000000..0512960bed23
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> @@ -0,0 +1,297 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the
> "Software"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
> THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include "sienna_cichlid.h"
> +#include "amdgpu_reset.h"
> +#include "amdgpu_amdkfd.h"
> +#include "amdgpu_dpm.h"
> +#include "amdgpu_job.h"
> +#include "amdgpu_ring.h"
> +#include "amdgpu_ras.h"
> +#include "amdgpu_psp.h"
> +#include "amdgpu_xgmi.h"
> +
> +static struct amdgpu_reset_handler *
> +sienna_cichlid_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
> +			    struct amdgpu_reset_context *reset_context)
> +{
> +	struct amdgpu_reset_handler *handler;
> +	struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl-
> >handle;
> +
> +	if (reset_context->method !=3D AMD_RESET_METHOD_NONE) {
> +		list_for_each_entry(handler, &reset_ctl->reset_handlers,
> +				     handler_list) {
> +			if (handler->reset_method =3D=3D reset_context-
> >method)
> +				return handler;
> +		}
> +	} else {
> +		list_for_each_entry(handler, &reset_ctl->reset_handlers,
> +				     handler_list) {
> +			if (handler->reset_method =3D=3D
> AMD_RESET_METHOD_MODE2 &&
> +			    adev->pm.fw_version >=3D 0x3a5500 &&
> +			    !amdgpu_sriov_vf(adev)) {
> +				reset_context->method =3D
> AMD_RESET_METHOD_MODE2;
> +				return handler;
> +			}
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static int sienna_cichlid_mode2_suspend_ip(struct amdgpu_device *adev)
> +{
> +	int r, i;
> +
> +	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> +	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> +
> +	for (i =3D adev->num_ip_blocks - 1; i >=3D 0; i--) {
> +		if (!(adev->ip_blocks[i].version->type =3D=3D
> +			      AMD_IP_BLOCK_TYPE_GFX ||
> +		      adev->ip_blocks[i].version->type =3D=3D
> +			      AMD_IP_BLOCK_TYPE_SDMA))
> +			continue;
> +
> +		r =3D adev->ip_blocks[i].version->funcs->suspend(adev);
> +
> +		if (r) {
> +			dev_err(adev->dev,
> +				"suspend of IP block <%s> failed %d\n",
> +				adev->ip_blocks[i].version->funcs->name, r);
> +			return r;
> +		}
> +		adev->ip_blocks[i].status.hw =3D false;
> +	}
> +
> +	return r;
> +}
> +
> +static int
> +sienna_cichlid_mode2_prepare_hwcontext(struct amdgpu_reset_control
> *reset_ctl,
> +				  struct amdgpu_reset_context
> *reset_context)
> +{
> +	int r =3D 0;
> +	struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl-
> >handle;
> +
> +	if (!amdgpu_sriov_vf(adev))
> +		r =3D sienna_cichlid_mode2_suspend_ip(adev);
> +
> +	return r;
> +}
> +
> +static void sienna_cichlid_async_reset(struct work_struct *work)
> +{
> +	struct amdgpu_reset_handler *handler;
> +	struct amdgpu_reset_control *reset_ctl =3D
> +		container_of(work, struct amdgpu_reset_control,
> reset_work);
> +	struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl-
> >handle;
> +
> +	list_for_each_entry(handler, &reset_ctl->reset_handlers,
> +			     handler_list) {
> +		if (handler->reset_method =3D=3D reset_ctl->active_reset) {
> +			dev_dbg(adev->dev, "Resetting device\n");
> +			handler->do_reset(adev);
> +			break;
> +		}
> +	}
> +}
> +
> +static int sienna_cichlid_mode2_reset(struct amdgpu_device *adev)
> +{
> +	/* disable BM */
> +	pci_clear_master(adev->pdev);
> +	adev->asic_reset_res =3D amdgpu_dpm_mode2_reset(adev);
> +	return adev->asic_reset_res;
> +}
> +
> +static int
> +sienna_cichlid_mode2_perform_reset(struct amdgpu_reset_control
> *reset_ctl,
> +			      struct amdgpu_reset_context *reset_context)
> +{
> +	struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl-
> >handle;
> +	int r;
> +
> +	r =3D sienna_cichlid_mode2_reset(adev);
> +	if (r) {
> +		dev_err(adev->dev,
> +			"ASIC reset failed with error, %d ", r);
> +	}
> +	return r;
> +}
> +
> +static int sienna_cichlid_mode2_restore_ip(struct amdgpu_device *adev)
> +{
> +	int i, r;
> +	struct psp_context *psp =3D &adev->psp;
> +
> +	r =3D psp_rlc_autoload_start(psp);
> +	if (r) {
> +		dev_err(adev->dev, "Failed to start rlc autoload\n");
> +		return r;
> +	}
> +
> +	/* Reinit GFXHUB */
> +	adev->gfxhub.funcs->init(adev);
> +	r =3D adev->gfxhub.funcs->gart_enable(adev);
> +	if (r) {
> +		dev_err(adev->dev, "GFXHUB gart reenable failed after
> reset\n");
> +		return r;
> +	}
> +
> +	for (i =3D 0; i < adev->num_ip_blocks; i++) {
> +		if (adev->ip_blocks[i].version->type =3D=3D
> AMD_IP_BLOCK_TYPE_IH)
> +			r =3D adev->ip_blocks[i].version->funcs-
> >resume(adev);
> +		if (r) {
> +			dev_err(adev->dev,
> +				"resume of IP block <%s> failed %d\n",
> +				adev->ip_blocks[i].version->funcs->name, r);
> +			return r;
> +		}
> +
> +		adev->ip_blocks[i].status.hw =3D true;
[Quan, Evan] It seems above operation will set the hw.status to true for al=
l IPs. Although actually the resuming only performed on IH.
That seems an issue.

BR
Evan
> +	}
> +
> +	for (i =3D 0; i < adev->num_ip_blocks; i++) {
> +		if (!(adev->ip_blocks[i].version->type =3D=3D
> +			      AMD_IP_BLOCK_TYPE_GFX ||
> +		      adev->ip_blocks[i].version->type =3D=3D
> +			      AMD_IP_BLOCK_TYPE_SDMA))
> +			continue;
> +		r =3D adev->ip_blocks[i].version->funcs->resume(adev);
> +		if (r) {
> +			dev_err(adev->dev,
> +				"resume of IP block <%s> failed %d\n",
> +				adev->ip_blocks[i].version->funcs->name, r);
> +			return r;
> +		}
> +
> +		adev->ip_blocks[i].status.hw =3D true;
> +	}
> +
> +	for (i =3D 0; i < adev->num_ip_blocks; i++) {
> +		if (!(adev->ip_blocks[i].version->type =3D=3D
> +			      AMD_IP_BLOCK_TYPE_GFX ||
> +		      adev->ip_blocks[i].version->type =3D=3D
> +			      AMD_IP_BLOCK_TYPE_SDMA))
> +			continue;
> +
> +		if (adev->ip_blocks[i].version->funcs->late_init) {
> +			r =3D adev->ip_blocks[i].version->funcs->late_init(
> +				(void *)adev);
> +			if (r) {
> +				dev_err(adev->dev,
> +					"late_init of IP block <%s> failed %d
> after reset\n",
> +					adev->ip_blocks[i].version->funcs-
> >name,
> +					r);
> +				return r;
> +			}
> +		}
> +		adev->ip_blocks[i].status.late_initialized =3D true;
> +	}
> +
> +	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
> +	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
> +
> +	return r;
> +}
> +
> +static int
> +sienna_cichlid_mode2_restore_hwcontext(struct amdgpu_reset_control
> *reset_ctl,
> +				  struct amdgpu_reset_context
> *reset_context)
> +{
> +	int r;
> +	struct amdgpu_device *tmp_adev =3D (struct amdgpu_device
> *)reset_ctl->handle;
> +
> +	dev_info(tmp_adev->dev,
> +			"GPU reset succeeded, trying to resume\n");
> +	r =3D sienna_cichlid_mode2_restore_ip(tmp_adev);
> +	if (r)
> +		goto end;
> +
> +	/*
> +	* Add this ASIC as tracked as reset was already
> +	* complete successfully.
> +	*/
> +	amdgpu_register_gpu_instance(tmp_adev);
> +
> +	/* Resume RAS */
> +	amdgpu_ras_resume(tmp_adev);
> +
> +	amdgpu_irq_gpu_reset_resume_helper(tmp_adev);
> +
> +	r =3D amdgpu_ib_ring_tests(tmp_adev);
> +	if (r) {
> +		dev_err(tmp_adev->dev,
> +			"ib ring test failed (%d).\n", r);
> +		r =3D -EAGAIN;
> +		tmp_adev->asic_reset_res =3D r;
> +		goto end;
> +	}
> +
> +end:
> +	if (r)
> +		return -EAGAIN;
> +	else
> +		return r;
> +}
> +
> +static struct amdgpu_reset_handler sienna_cichlid_mode2_handler =3D {
> +	.reset_method		=3D AMD_RESET_METHOD_MODE2,
> +	.prepare_env		=3D NULL,
> +	.prepare_hwcontext	=3D sienna_cichlid_mode2_prepare_hwcontext,
> +	.perform_reset		=3D
> sienna_cichlid_mode2_perform_reset,
> +	.restore_hwcontext	=3D sienna_cichlid_mode2_restore_hwcontext,
> +	.restore_env		=3D NULL,
> +	.do_reset		=3D sienna_cichlid_mode2_reset,
> +};
> +
> +int sienna_cichlid_reset_init(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_reset_control *reset_ctl;
> +
> +	reset_ctl =3D kzalloc(sizeof(*reset_ctl), GFP_KERNEL);
> +	if (!reset_ctl)
> +		return -ENOMEM;
> +
> +	reset_ctl->handle =3D adev;
> +	reset_ctl->async_reset =3D sienna_cichlid_async_reset;
> +	reset_ctl->active_reset =3D AMD_RESET_METHOD_NONE;
> +	reset_ctl->get_reset_handler =3D sienna_cichlid_get_reset_handler;
> +
> +	INIT_LIST_HEAD(&reset_ctl->reset_handlers);
> +	INIT_WORK(&reset_ctl->reset_work, reset_ctl->async_reset);
> +	/* Only mode2 is handled through reset control now */
> +	amdgpu_reset_add_handler(reset_ctl,
> &sienna_cichlid_mode2_handler);
> +
> +	adev->reset_cntl =3D reset_ctl;
> +
> +	return 0;
> +}
> +
> +int sienna_cichlid_reset_fini(struct amdgpu_device *adev)
> +{
> +	kfree(adev->reset_cntl);
> +	adev->reset_cntl =3D NULL;
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.h
> b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.h
> new file mode 100644
> index 000000000000..5213b162dacd
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.h
> @@ -0,0 +1,32 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the
> "Software"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
> THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __SIENNA_CICHLID_H__
> +#define __SIENNA_CICHLID_H__
> +
> +#include "amdgpu.h"
> +
> +int sienna_cichlid_reset_init(struct amdgpu_device *adev);
> +int sienna_cichlid_reset_fini(struct amdgpu_device *adev);
> +
> +#endif
> diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_0_7_ppsmc.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_0_7_ppsmc.h
> index d2e10a724560..82cf9e563065 100644
> ---
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_0_7_ppsmc.h
> +++
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_0_7_ppsmc.h
> @@ -137,7 +137,7 @@
>  #define PPSMC_MSG_DisallowGpo                    0x56
>=20
>  #define PPSMC_MSG_Enable2ndUSB20Port             0x57
> -
> -#define PPSMC_Message_Count                      0x58
> +#define PPSMC_MSG_DriverMode2Reset               0x5D
> +#define PPSMC_Message_Count                      0x5E
>=20
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index 19084a4fcb2b..28f6a1eb6945 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -235,7 +235,8 @@
>  	__SMU_DUMMY_MAP(UnforceGfxVid),           \
>  	__SMU_DUMMY_MAP(HeavySBR),			\
>  	__SMU_DUMMY_MAP(SetBadHBMPagesRetiredFlagsPerChannel), \
> -	__SMU_DUMMY_MAP(EnableGfxImu),
> +	__SMU_DUMMY_MAP(EnableGfxImu), \
> +	__SMU_DUMMY_MAP(DriverMode2Reset),
>=20
>  #undef __SMU_DUMMY_MAP
>  #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index fa520d79ef67..a73d241bb64f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -154,6 +154,7 @@ static struct cmn2asic_msg_mapping
> sienna_cichlid_message_map[SMU_MSG_MAX_COUNT]
>  	MSG_MAP(SetGpoFeaturePMask,
> 	PPSMC_MSG_SetGpoFeaturePMask,          0),
>  	MSG_MAP(DisallowGpo,
> 	PPSMC_MSG_DisallowGpo,                 0),
>  	MSG_MAP(Enable2ndUSB20Port,
> 	PPSMC_MSG_Enable2ndUSB20Port,          0),
> +	MSG_MAP(DriverMode2Reset,
> 	PPSMC_MSG_DriverMode2Reset,	       0),
>  };
>=20
>  static struct cmn2asic_mapping sienna_cichlid_clk_map[SMU_CLK_COUNT]
> =3D {
> @@ -4254,6 +4255,57 @@ static int
> sienna_cichlid_stb_get_data_direct(struct smu_context *smu,
>  	return 0;
>  }
>=20
> +static bool sienna_cichlid_is_mode2_reset_supported(struct smu_context
> *smu)
> +{
> +	return true;
> +}
> +
> +static int sienna_cichlid_mode2_reset(struct smu_context *smu)
> +{
> +	u32 smu_version;
> +	int ret =3D 0, index;
> +	struct amdgpu_device *adev =3D smu->adev;
> +	int timeout =3D 100;
> +
> +	smu_cmn_get_smc_version(smu, NULL, &smu_version);
> +
> +	index =3D smu_cmn_to_asic_specific_index(smu,
> CMN2ASIC_MAPPING_MSG,
> +
> 	SMU_MSG_DriverMode2Reset);
> +
> +	mutex_lock(&smu->message_lock);
> +
> +	ret =3D smu_cmn_send_msg_without_waiting(smu, (uint16_t)index,
> +					       SMU_RESET_MODE_2);
> +
> +	ret =3D smu_cmn_wait_for_response(smu);
> +	while (ret !=3D 0 && timeout) {
> +		ret =3D smu_cmn_wait_for_response(smu);
> +		/* Wait a bit more time for getting ACK */
> +		if (ret !=3D 0) {
> +			--timeout;
> +			usleep_range(500, 1000);
> +			continue;
> +		} else {
> +			break;
> +		}
> +	}
> +
> +	if (!timeout) {
> +		dev_err(adev->dev,
> +			"failed to send mode2 message \tparam: 0x%08x
> response %#x\n",
> +			SMU_RESET_MODE_2, ret);
> +		goto out;
> +	}
> +
> +	dev_info(smu->adev->dev, "restore config space...\n");
> +	/* Restore the config space saved during init */
> +	amdgpu_device_load_pci_state(adev->pdev);
> +out:
> +	mutex_unlock(&smu->message_lock);
> +
> +	return ret;
> +}
> +
>  static const struct pptable_funcs sienna_cichlid_ppt_funcs =3D {
>  	.get_allowed_feature_mask =3D
> sienna_cichlid_get_allowed_feature_mask,
>  	.set_default_dpm_table =3D sienna_cichlid_set_default_dpm_table,
> @@ -4348,6 +4400,8 @@ static const struct pptable_funcs
> sienna_cichlid_ppt_funcs =3D {
>  	.get_default_config_table_settings =3D
> sienna_cichlid_get_default_config_table_settings,
>  	.set_config_table =3D sienna_cichlid_set_config_table,
>  	.get_unique_id =3D sienna_cichlid_get_unique_id,
> +	.mode2_reset_is_support =3D
> sienna_cichlid_is_mode2_reset_supported,
> +	.mode2_reset =3D sienna_cichlid_mode2_reset,
>  };
>=20
>  void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
> --
> 2.25.1
