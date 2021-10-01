Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA38DC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 15:41:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A479961A10
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 15:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A479961A10
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E0D56E52A;
	Fri,  1 Oct 2021 15:41:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B88D86E52A
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 15:41:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjAMxyHXvwp+RQuiIJujfRrAzPbK7O4pmCdskt66XOHMp22qj643YnlQTKn6TgGSG2hfIOAXZ5j5d7mtspsMQwIs/KXR+nqd1e3HwaZr2NM0tTbJpKHc8XmnB4xmI9ugsLcVS5uE1LwycU+R2ip/69kanQxta4xB140IjV73MzxQEfAn8bYn66f5VaHQoxhotyGl6vy/c/GLLp07PIAdPxPH4tpHWeqHc3JVwuSx+AhIUAl3KmTiFtGLcxDJyb0DiaKqESwJRAYn91S40Ag5OZlAwQcX9TsP4cWsYs0gYsHQozSjixxp1v7ymiFNCGnQZ3qphZOSNdL0f507yI6NOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1e7oGutbVtBqWCx74FtlBznLeSB2r7IQHLXVyqsiDs=;
 b=FYA+RUdjbtpIpDjvwEDCYwBymI0a7ARoh9P96Rt4tKbLGPN+xkxuXAh8PTtx1BB0kLkaxG/uh9Cl4NLkr/Z8pSS7+2nGNnMLZZP+/7RcdQgdnM+6h4n0RBKUh1d3gfJt5cyDjuHxt/keRb6hGsRg8c13SHVeaRXifOzy1yLuyFA9tBtA2Ozoczs1mFQ4YSBzz5OMRVQpRnvwSRUKMOiailnoeUJvSbCsAVp0xiEg34K4cSgISDY30YC5UzK0PBno/lO8WKZQWrYrhmPNPYasy7anlpAcYazgo0t+wMzGV1fSitPeE45NuMWU6lt6tsIpwP+WTmMmPNmEYZnGAF20Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1e7oGutbVtBqWCx74FtlBznLeSB2r7IQHLXVyqsiDs=;
 b=vFXCI2xxeZUOsVSEHw9Z0Q4V0Btr3WRFVG4PNrddb1vN+3HyTSyDNTmt1NuphvdthDozyKDKs8kNBQSdMUg7P7XtTUbYBcmsixUulle9QsrN/3ih769aqzIHij7lnJfUP+UODhBTcZxRSQoCICR5x0+Tn9XZa7Y5AqutqfzzDKg=
Received: from DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22)
 by DM8PR12MB5479.namprd12.prod.outlook.com (2603:10b6:8:38::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Fri, 1 Oct
 2021 15:41:04 +0000
Received: from DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::44d6:27c6:bd31:5b68]) by DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::44d6:27c6:bd31:5b68%9]) with mapi id 15.20.4544.025; Fri, 1 Oct 2021
 15:41:04 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/display: fold DRM_AMD_DC_DCN201 into
 DRM_AMD_DC_DCN
Thread-Topic: [PATCH] drm/amdgpu/display: fold DRM_AMD_DC_DCN201 into
 DRM_AMD_DC_DCN
Thread-Index: AQHXttEF6NszK10Ae0SkcJmxF5R0Gau+R6Ww
Date: Fri, 1 Oct 2021 15:41:04 +0000
Message-ID: <DM4PR12MB5214EC7D4E3403CFA692DFD19EAB9@DM4PR12MB5214.namprd12.prod.outlook.com>
References: <20211001143105.558588-1-alexander.deucher@amd.com>
In-Reply-To: <20211001143105.558588-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=dee10488-be83-4371-9d3a-ea5b4431c320;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-01T15:40:50Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 778539b0-ba33-48f1-9733-08d984f1e107
x-ms-traffictypediagnostic: DM8PR12MB5479:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR12MB5479D3BB40D9F130DFF57DD69EAB9@DM8PR12MB5479.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:167;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CMSCjzI8AyNk2n+aLsQAgGwzsbn2aAiOyiKM/raPHVoDt2O0IA0QgWxRb19nzuhv7G9LkzmsYOw4vUgX/r/0m2YatUhTFnmZxsqlbMZ+I/QQqgN8Q/5i8Fd/E7OYHxc2EzsNql4rCIwQq/dXS58KcZRPbTlwtLdC57LhjoE6qBPfwCTdkp1Rl0/Qgpqdzu/0JZ005S+gNb/0teP6qJTU7SHOxzWnI3Erz41PUdwUiyY8GNiyvDm4nR/gnkMiKl4wgctavmjZ3lnh3kKoRtWOTAlQ+0kA1CS/zGGR+KyFhqpTyaygC+VqDxpbLHDtLKYHOXVgwGCy3Gh4xV6tmhSiui9J/yrDubErlgXjr+JSlOK792JvzargDKYqhT6JQSitvrlsT8QLS4hhqP7d/WRc5gZb20roJ6miGdn7QNUwO1T9ht3gQy2kliUs4vDU3W5h5B5cSUAj3/+gq1wuTkBc2Sbyo/X338POaRcwhCT/yHe6ou/08K6lgvHj1KMTN1oi2yrhfWfiKRqx5/o8WkPD+MnMfnRGcfywRR7DXqnOIULRsjBjR4Oo2gV6eHi7QtX5UsDDlWrJdu68hOxPI574PQpmDO52yXCLszi3B7BV/Ftq2rVlfkDXw4kmMmfBVVu6bXB+6tj5KFMoiz/0QUNMvdQZj7quiRDvusC0xzbNcYNb//e6Yv/K0D8P5FU0rlsqT60KsDBuwMTXri/ql0sBwA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5214.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(38100700002)(5660300002)(122000001)(110136005)(316002)(508600001)(52536014)(38070700005)(33656002)(86362001)(76116006)(53546011)(6506007)(8936002)(83380400001)(9686003)(7696005)(66446008)(66556008)(64756008)(66476007)(66946007)(26005)(4326008)(71200400001)(186003)(8676002)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F8qE/16khVl354+ZZ8EzR1RSQQomh831+obMLVv+wF4Q3ZdnwOdYnq6H8CNv?=
 =?us-ascii?Q?qtrrs97+RvtW3gMj/7ruA3g94ljj00sp3A+SlnHCVakCK5T7GY4eEwnFIhAt?=
 =?us-ascii?Q?xUgEws88QOhAMU23H+8sl2cPGXhB+0Duoc3TPcu0LubUCQWUOUnnHef04yn2?=
 =?us-ascii?Q?6GjVUjDRXm0TjjQch8mmWIRA/L6DHdFC6LtwnEidsnC3Xvg+6ANAH/F3blBz?=
 =?us-ascii?Q?or4b0yKJ30ywzNhIej3ZpCkFz9N8WzRM4dsRSDHE97NTSY9aKHgZYa7c73hx?=
 =?us-ascii?Q?ZISnD+uBbSJ7PtkBvUP5tFhDrPK0t7m1RNDK+I7MF2KHvBk8hh9o0Uk2ryO+?=
 =?us-ascii?Q?D8Le3zTrdE6e5AwBGY6x6PH9Zok00E7GfAiN+MerMq7Md0NgFRUNJGrSpaS0?=
 =?us-ascii?Q?9JqC1c2Em7FEldhm+IRYArrwK7B8M5DoIrlMEaR5SHPOKRFh2gcXG8FlRdmd?=
 =?us-ascii?Q?IH1BKWjcC10mp+HejTEmng3zhDKdoc1rCQalOZ8kiMQGl/SEFQ4bwfeNXpCP?=
 =?us-ascii?Q?lE4TXV49iwjJ+ncpUBtuMA/1RE/FVTsiVSM9PZ+vXrw7akRLgVEOTMIVXQNm?=
 =?us-ascii?Q?j7GrB3YKFbrGuFDdRESp9iMHEiudbGvXpmHjgaOY3rTiCHSDL1FABhEeXUlm?=
 =?us-ascii?Q?b8e8k8NRHzdEAtvUYU9iBfTsn7092VCu6UgtP0S8H5wuRj90YRRWfHI9WW8k?=
 =?us-ascii?Q?tQP7Udc04g7xBtnhEnOckXokrDAX5BSQsvibCQ8IexV2XecbUYWAxdhM+0sm?=
 =?us-ascii?Q?W7XjUDjBzYlVPjfaXZ4j06M5MDAXC/iYJ1KaABZcR+A7zS5BUpsQ+atS64Ol?=
 =?us-ascii?Q?1sXnTb6uqd95ebaVIw3JoLUQ6MrQ1LLYJlj+k87ld2pMJBXHMmyH2JdRH1xL?=
 =?us-ascii?Q?DHpLRAJjgLbUtHEXSYADJk7iWGixDXzY0NHwKGSvG3tpjmpm56/YuyIvAjwa?=
 =?us-ascii?Q?qGIolaXvwrQvj+Dav0+t7C1Zx3BMWw4p/yBY/goWa9pRL43r2dGt00ECliLP?=
 =?us-ascii?Q?BX7KTNDWRwrrPBrMBTf2StGZmTYzKxzMgaTZFRw8WY9HmEX0FqTE+InM/8Zs?=
 =?us-ascii?Q?WwpEzRLP6SIACzGRB+D8zpFyRDWC2HeopNqsmd9Z3w3bC7i074OmSzOwn6Tx?=
 =?us-ascii?Q?axbJooUjHJczeiEC1cHhp5quQmUQzzzuzrmzVEtHECIqbHQcIhSnrNOUkJ1f?=
 =?us-ascii?Q?szqyAovdBUz0pXgqAWbWKxBYZ6kR2+sZQ/Xdlomtcj5CVCbXU4nIL2ocNSvw?=
 =?us-ascii?Q?Qq7PiUuj65ZTQBI/FXdzaZY9KI/BxPcMVPMRKGqH73jUTRszy49Hco05bhX1?=
 =?us-ascii?Q?Vkb8QLWq87eV84kw+N+5DQ/W?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 778539b0-ba33-48f1-9733-08d984f1e107
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 15:41:04.5866 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4O58keQQtmL3kQuHw3mE8XNhersWSJ6zdXcC0xs/QKuGB7PDatpqZpRs9qACIBCy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5479
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

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: 2021/October/01, Friday 10:31 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/display: fold DRM_AMD_DC_DCN201 into
> DRM_AMD_DC_DCN
>
> No need for a separate kconfig option at this point.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Zhan Liu <zhan.liu@amd.com>

> ---
>  drivers/gpu/drm/amd/display/Kconfig               | 9 ---------
>  drivers/gpu/drm/amd/display/dc/Makefile           | 2 --
>  drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile   | 2 --
>  drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  | 2 --
> drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 --
>  drivers/gpu/drm/amd/display/dc/irq/Makefile       | 2 --
>  6 files changed, 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/Kconfig
> b/drivers/gpu/drm/amd/display/Kconfig
> index fb074a6067b2..7dffc04a557e 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -17,15 +17,6 @@ config DRM_AMD_DC_DCN
>       help
>         Raven, Navi, and newer family support for display engine
>
> -config DRM_AMD_DC_DCN201
> -     bool "Enable DCN201 support in DC"
> -     default y
> -     depends on DRM_AMD_DC && X86
> -     depends on DRM_AMD_DC_DCN
> -     help
> -       Choose this option if you want to have
> -       201 support for display engine
> -
>  config DRM_AMD_DC_HDCP
>       bool "Enable HDCP support in DC"
>       depends on DRM_AMD_DC
> diff --git a/drivers/gpu/drm/amd/display/dc/Makefile
> b/drivers/gpu/drm/amd/display/dc/Makefile
> index 520f58538364..b5482980e995 100644
> --- a/drivers/gpu/drm/amd/display/dc/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/Makefile
> @@ -30,9 +30,7 @@ DC_LIBS +=3D dcn20
>  DC_LIBS +=3D dsc
>  DC_LIBS +=3D dcn10 dml
>  DC_LIBS +=3D dcn21
> -ifdef CONFIG_DRM_AMD_DC_DCN201
>  DC_LIBS +=3D dcn201
> -endif
>  DC_LIBS +=3D dcn30
>  DC_LIBS +=3D dcn301
>  DC_LIBS +=3D dcn302
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> index 7f70985b7a1b..6bd73e49a6d2 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> @@ -93,7 +93,6 @@ AMD_DAL_CLK_MGR_DCN20 =3D $(addprefix
> $(AMDDALPATH)/dc/clk_mgr/dcn20/,$(CLK_MGR_DC
>
>  AMD_DISPLAY_FILES +=3D $(AMD_DAL_CLK_MGR_DCN20)
>
> -ifdef CONFIG_DRM_AMD_DC_DCN201
>
> #################################################################
> ##############
>  # DCN201
>
> #################################################################
> ##############
> @@ -102,7 +101,6 @@ CLK_MGR_DCN201 =3D dcn201_clk_mgr.o
>  AMD_DAL_CLK_MGR_DCN201 =3D $(addprefix
> $(AMDDALPATH)/dc/clk_mgr/dcn201/,$(CLK_MGR_DCN201))
>
>  AMD_DISPLAY_FILES +=3D $(AMD_DAL_CLK_MGR_DCN201) -endif
>
>
> #################################################################
> ##############
>  # DCN21
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> index 421f5135b701..1548b2a3fe03 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> @@ -257,12 +257,10 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context
> *ctx, struct pp_smu_funcs *p
>                       dcn3_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
>                       return &clk_mgr->base;
>               }
> -#if defined(CONFIG_DRM_AMD_DC_DCN201)
>               if (asic_id.chip_id =3D=3D DEVICE_ID_NV_13FE) {
>                       dcn201_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg=
);
>                       return &clk_mgr->base;
>               }
> -#endif
>               dcn20_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
>               return &clk_mgr->base;
>       }
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index fc490b77f47d..561c10a92bb5 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -224,11 +224,9 @@ struct resource_pool
> *dc_create_resource_pool(struct dc  *dc,
>       case DCN_VERSION_2_1:
>               res_pool =3D dcn21_create_resource_pool(init_data, dc);
>               break;
> -#if defined(CONFIG_DRM_AMD_DC_DCN201)
>       case DCN_VERSION_2_01:
>               res_pool =3D dcn201_create_resource_pool(init_data, dc);
>               break;
> -#endif
>       case DCN_VERSION_3_0:
>               res_pool =3D dcn30_create_resource_pool(init_data, dc);
>               break;
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/Makefile
> b/drivers/gpu/drm/amd/display/dc/irq/Makefile
> index 8a182772eed2..fd739aecf104 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/irq/Makefile
> @@ -94,7 +94,6 @@ AMD_DAL_IRQ_DCN21=3D $(addprefix
> $(AMDDALPATH)/dc/irq/dcn21/,$(IRQ_DCN21))
>
>  AMD_DISPLAY_FILES +=3D $(AMD_DAL_IRQ_DCN21)
>
> -ifdef CONFIG_DRM_AMD_DC_DCN201
>
> #################################################################
> ##############
>  # DCN 201
>
> #################################################################
> ##############
> @@ -103,7 +102,6 @@ IRQ_DCN201 =3D irq_service_dcn201.o
>  AMD_DAL_IRQ_DCN201 =3D $(addprefix
> $(AMDDALPATH)/dc/irq/dcn201/,$(IRQ_DCN201))
>
>  AMD_DISPLAY_FILES +=3D $(AMD_DAL_IRQ_DCN201) -endif
>
>
> #################################################################
> ##############
>  # DCN 30
> --
> 2.31.1

