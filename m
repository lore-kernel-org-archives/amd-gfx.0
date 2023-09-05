Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0621FC83F2C
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 03:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3604F10E160;
	Tue,  5 Sep 2023 03:20:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0F2310E160
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 03:20:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3eUMdJ5EwqsScbBZ5kWbLluLnwJK+YJ0148Gl80STIGojFQRNT9IyYbYVUISeemcwapgf30qdfhuHTY3FJ62ZERfTBMeU+0U/sVVOAiTLrUCVt3YWhDWSSswnT7sVNTiic9UFypYoqStlD3m6rt6IIVN9rs1FzRS1ahar2u+wmrTBwxoykrVUDIc04sWXnriHkHZ+jkqEOM1TXkXcYi8GZSG1oLjdqYUAcJDmoXFtgTZgZ8tY/8StxJnF+Pxj+yzC8agOkPeKYFLAKXbPsc9rlOFLIOzIL9W1Lt987aYqyxlFyTAWl4knsWJd0Hq4leSCVKsxIcF3FvYkLOwC/eEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkjF5HmbDpjBiN0X34gPww4EAlhJkotUFUR/PUuOx+k=;
 b=dEgxXu5+74R9pqTPVHr1BTatDPGBTriS2ueZAIWzkUSZiTnmHoRB2mLmNRPZ4Rni3sUOX88mapsaKMoEplsV/n8pvpiygphFN86YxLhwtAqxbOLA12GCuX5MdXSd9gt1dLsOHlnhlS2650GYy7gYO7WoQLhg6jUYDP2buV0yiObST9scQpEV3wfE4wyEOhaSgjhv36DykpZip4pqiF1EHFJ6On5kXLQ1JK29sHokIWIfVp0cGUgAkcVFTjRQSE/tLonIH5BLSRVfzMmv2yWsP+dzG62UMmahy2MVwsQCX3a9LvPJ1ezu2s9fkSynJfTSzYxCOTJNPQLUV/Wv6ZCong==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkjF5HmbDpjBiN0X34gPww4EAlhJkotUFUR/PUuOx+k=;
 b=1NgZTVI+eqVKPOE30Xa8IBTvHdywRcw1M/YNlGZGoBzLI1K5unE62gPd7x9j+dNBZx3XgzcEEVmHaXoykOvlF4vEpKsEJnB3mL5OoGVsV1mfItdplvHtHt+yT6czlx4K55u/UzesJxr2DIsI8yDhV6uD6IkyAH9zmrkwgY0fDbY=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by MW3PR12MB4556.namprd12.prod.outlook.com (2603:10b6:303:52::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 03:20:47 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5906:d279:3bd3:1100]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5906:d279:3bd3:1100%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 03:20:47 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu: Add umc v12_0 ras functions
Thread-Topic: [PATCH 3/3] drm/amdgpu: Add umc v12_0 ras functions
Thread-Index: AQHZ3wBqm41HlG3rKU++I1GVTaZdGLALkd7Q
Date: Tue, 5 Sep 2023 03:20:46 +0000
Message-ID: <PH7PR12MB8796EC672354FEB7401FFB6DB0E8A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20230904072021.59152-1-candice.li@amd.com>
In-Reply-To: <20230904072021.59152-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2b07db7d-cccf-4229-b294-29c4b7c77717;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-05T03:20:35Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|MW3PR12MB4556:EE_
x-ms-office365-filtering-correlation-id: 1b9ca738-e1e5-42a7-01f1-08dbadbf18c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l60PQkbcXnNhudtCqF6C+ztAa2BH1CBUsI8vV057YE9lsuoKBGZ5Hm8trxmc/qNF865Ya5Tzupd81g2/Z6wrUsgZUnr1hki9TfH8kR9pR1bE0+ykL+EwxSgsiFeGLmCN1ECPn+tp2FbevHuSpBy2S8vBWRtY/GEva4rwtNUq41Zn1YZkldb97uMGG/A4IVepq1Tz/NdYH8Ftit6PUrw6LdFNAMaXWlNFcMet329VH9kefOLSLUCdkoilchcf0IcGSf50yUaIPEDNrhyYyHBUWaPvKhJE8iyaVhT5tBZFCQeoXuRSC0nQdFxc+/znriTjG/kmUIvJfAgKDddFfnleSpFhRhA/bCv5YfBX95dzH0GFmqO4neQS4b5aAfVw/UvIBy8v5jDIjkDxg/h/kiwkzTqCDfv/HJ9kstaQtiJxvAtlkUekCnykUBJWqc6xbq6cERGRw2Y1Xi5cWf9RY5sK+meD12z3BDK37GNMASbuy2pJtHW1924DU50FPSW2vzP0F5/Fg+p+N1Uu/rPgaZh3xQ2NTujkd7XZv9PK8/5nKnoXu5e2gs10X16vKtSY+zfhJliTXDD4A/Fbp2cw3p8qZR1JuzKxbWotppsVCkHQ906G88QHW4Y5xEQOUqtAF+u2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(1800799009)(186009)(451199024)(55016003)(71200400001)(66899024)(2906002)(83380400001)(30864003)(66476007)(110136005)(6506007)(64756008)(7696005)(53546011)(316002)(66446008)(66556008)(76116006)(66946007)(478600001)(5660300002)(26005)(52536014)(122000001)(41300700001)(9686003)(8936002)(8676002)(33656002)(38100700002)(86362001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tvRSlaV1Cr482+mZab2zgSnjA7DEB7gg1spBNDt7fAYC4puPGJccDTuNvuVe?=
 =?us-ascii?Q?5OpfAtZKqWpwbg55WGDxmjpPYFNP3KnbY1wtKig8gHRh0lKiy9VCXaU+itSW?=
 =?us-ascii?Q?wKd4qV34T7IVeUK43Ni5P7Vs2wXKouNip0Z4EX7nim9mgXH2lPSJjlbSyzy6?=
 =?us-ascii?Q?0zmB+Lkr8lmaSNme1yeEPzAsQYUmmDzAlfn1DPoyYr95An1GnXj/HKjTfD8t?=
 =?us-ascii?Q?17T4ph6qZ2/3Ns42OdaNRNSY7EXjof3gMIDWug7qsGClnTq6bDlfha+/eznI?=
 =?us-ascii?Q?BI5qIttVilnL1PcCUw8NbzUP41Tvf6KLlYMEkUnLaIoSulYsXYUOEsBKjfZG?=
 =?us-ascii?Q?EkNCg8dw8NmH4MoYUNYHQfRBH41TT2iWIGyOPdaHNFWsGq13awl8CzQPNT2k?=
 =?us-ascii?Q?pS5Ak8v+tHABsN3oVzmLCLg5O/CQ3/JMxlR2aAiF6GqTJkE2mQ+JmsJ33+UI?=
 =?us-ascii?Q?S8TMRab3hWk4WSkiy3GmaeEE8+OQzhxdOoGVB6NGYZr+69WTKj4ZoHa2SybV?=
 =?us-ascii?Q?ppJMWkGUvHZ+YxAbtuIYJQJVIbqqv0+GSNDxW8mHMTDLclz1Kfrq1nzmUcr4?=
 =?us-ascii?Q?kfLykC1KlCytH575NFfbtwZyLsV+5E5Sph0a4osFGRxliduQ1OT9K2Mu/nCy?=
 =?us-ascii?Q?uR6YPW8zMkZUamhaN4s4pJNClxKAP82TkrC8Sns9aN46efve21o4CotFsw9r?=
 =?us-ascii?Q?cKmEt8iUL1r1I2GFO0QU1SaTiLN9dCbYSRL9/hzCVdjsEQ/fE9GoOUPbTMqP?=
 =?us-ascii?Q?o3poNOPl9gcK8+DFc8NbTpIp9o08xUHDi4p3dSiG7Gz05kN0KiRQxvYMvylg?=
 =?us-ascii?Q?NDuTQBPv3+NY1K3A1ERwUkhP2WgtMCpV4p+wdPpEwcHSrQ4i5hUkhrqR2UZa?=
 =?us-ascii?Q?x390G/QWNblxZl9j6gNW6ds8uFkT4a2ekJbS1ZvubLR973rQ6iTRmU7idYtq?=
 =?us-ascii?Q?wskJgJcxPNCbcV1BNN17aZjQlolQeroV9WZG7mtQAhXPcdhLoLqCEdrdacdJ?=
 =?us-ascii?Q?3Zdlvl8vobvQPTY2iurc+qRk7AU7g1yPexiLFc9lhtD5+ATNLTYQi6RtMeAi?=
 =?us-ascii?Q?w4yycgw9uHSf1NYikpM2qt5U11LY0Z8LNk5h/mc+BqcfV78FQwINFAHVA6R/?=
 =?us-ascii?Q?FWqOTVpxVyBSlVx3nBmNsK6OiMMMk3/pLcNVDzbkoShtDw7j+A1pfQ3wDISk?=
 =?us-ascii?Q?3G+/0WdOtdNOZRkgqfiDh+WlRQJVy7Wx3upp53qitbgq6+MMlnJsBN2tlfJL?=
 =?us-ascii?Q?aQlntf8MFnxfOV76xaTodtI2kec63dm8yXE5/SIAt+Bhfl6NwHvMepJaFJ2R?=
 =?us-ascii?Q?xzdMJXacF3rdvdnhq/XNXfqNNuXW8j+Llw3mLNnSRUfcNcYdOzLCdpJo6rqI?=
 =?us-ascii?Q?7VY+gbpTcLjxluuAPtAj5ibnj7RLrePoYU8K+yocVh/0F10VbTKE7Ncd4Vwm?=
 =?us-ascii?Q?RFnxPVy1pIO7pUF9W1KdKJ0uBxp0DyYDRqAXGc1qRMP5E5X4s7xooJvR7Sgu?=
 =?us-ascii?Q?niYk6+kRXYAG0y2BGR5hxw+pvu+yNAz0VCwB2ZtVSJwj8w3CuuG3lHieQ96p?=
 =?us-ascii?Q?zvQ2aH4FJSwlr6Dfgkc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9ca738-e1e5-42a7-01f1-08dbadbf18c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 03:20:46.8898 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: soE7nRbBlFao63EnkMInePpBf0dUsfdUnn0ToIj5PKm4pSrPPN33sm5LeJSZ277Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4556
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

[AMD Official Use Only - General]

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Li, Candice <Candice.Li@amd.com>
> Sent: Monday, September 4, 2023 3:20 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Li, Candice <Candice.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu: Add umc v12_0 ras functions
>
> Add umc v12_0 ras error querying.
>
> Signed-off-by: Candice Li <candice.li@amd.com>
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile    |   2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |  16 +-
> drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 256
> +++++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/umc_v12_0.h |
> 56 ++++++
>  4 files changed, 327 insertions(+), 3 deletions(-)  create mode 100644
> drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
> b/drivers/gpu/drm/amd/amdgpu/Makefile
> index ce0188b329cdeb..adf5470aa81020 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -121,7 +121,7 @@ amdgpu-y +=3D \
>
>  # add UMC block
>  amdgpu-y +=3D \
> -     umc_v6_0.o umc_v6_1.o umc_v6_7.o umc_v8_7.o umc_v8_10.o
> +     umc_v6_0.o umc_v6_1.o umc_v6_7.o umc_v8_7.o umc_v8_10.o
> umc_v12_0.o
>
>  # add IH block
>  amdgpu-y +=3D \
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 8447fcada8bb92..41e1759b5f1eaa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -56,6 +56,7 @@
>  #include "umc_v6_1.h"
>  #include "umc_v6_0.h"
>  #include "umc_v6_7.h"
> +#include "umc_v12_0.h"
>  #include "hdp_v4_0.h"
>  #include "mca_v3_0.h"
>
> @@ -737,7 +738,8 @@ static void gmc_v9_0_set_irq_funcs(struct
> amdgpu_device *adev)
>       adev->gmc.vm_fault.funcs =3D &gmc_v9_0_irq_funcs;
>
>       if (!amdgpu_sriov_vf(adev) &&
> -         !adev->gmc.xgmi.connected_to_cpu) {
> +         !adev->gmc.xgmi.connected_to_cpu &&
> +         !adev->gmc.is_app_apu) {
>               adev->gmc.ecc_irq.num_types =3D 1;
>               adev->gmc.ecc_irq.funcs =3D &gmc_v9_0_ecc_funcs;
>       }
> @@ -1487,6 +1489,15 @@ static void gmc_v9_0_set_umc_funcs(struct
> amdgpu_device *adev)
>               else
>                       adev->umc.channel_idx_tbl =3D
> &umc_v6_7_channel_idx_tbl_second[0][0];
>               break;
> +     case IP_VERSION(12, 0, 0):
> +             adev->umc.max_ras_err_cnt_per_query =3D
> UMC_V12_0_TOTAL_CHANNEL_NUM(adev);
> +             adev->umc.channel_inst_num =3D
> UMC_V12_0_CHANNEL_INSTANCE_NUM;
> +             adev->umc.umc_inst_num =3D
> UMC_V12_0_UMC_INSTANCE_NUM;
> +             adev->umc.node_inst_num /=3D
> UMC_V12_0_UMC_INSTANCE_NUM;
> +             adev->umc.channel_offs =3D
> UMC_V12_0_PER_CHANNEL_OFFSET;
> +             adev->umc.active_mask =3D adev->aid_mask;
> +             if (!adev->gmc.xgmi.connected_to_cpu && !adev-
> >gmc.is_app_apu)
> +                     adev->umc.ras =3D &umc_v12_0_ras;
>       default:
>               break;
>       }
> @@ -2131,7 +2142,8 @@ static int gmc_v9_0_sw_init(void *handle)
>               return r;
>
>       if (!amdgpu_sriov_vf(adev) &&
> -         !adev->gmc.xgmi.connected_to_cpu) {
> +         !adev->gmc.xgmi.connected_to_cpu &&
> +         !adev->gmc.is_app_apu) {
>               /* interrupt sent to DF. */
>               r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DF, 0,
>                                     &adev->gmc.ecc_irq);
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> new file mode 100644
> index 00000000000000..b3d6db14b351f1
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> @@ -0,0 +1,256 @@
> +/*
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person
> +obtaining a
> + * copy of this software and associated documentation files (the
> +"Software"),
> + * to deal in the Software without restriction, including without
> +limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> +sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom
> +the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> +included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> +EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> +MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT
> +SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> +DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> +OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> USE
> +OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#include "umc_v12_0.h"
> +#include "amdgpu_ras.h"
> +#include "amdgpu_umc.h"
> +#include "amdgpu.h"
> +#include "umc/umc_12_0_0_offset.h"
> +#include "umc/umc_12_0_0_sh_mask.h"
> +
> +static inline uint64_t get_umc_v12_0_reg_offset(struct amdgpu_device *ad=
ev,
> +                                         uint32_t node_inst,
> +                                         uint32_t umc_inst,
> +                                         uint32_t ch_inst)
> +{
> +     uint32_t index =3D umc_inst * adev->umc.channel_inst_num + ch_inst;
> +     uint64_t cross_node_offset =3D (node_inst =3D=3D 0) ? 0 :
> +UMC_V12_0_CROSS_NODE_OFFSET;
> +
> +     umc_inst =3D index / 4;
> +     ch_inst =3D index % 4;
> +
> +     return adev->umc.channel_offs * ch_inst + UMC_V12_0_INST_DIST *
> umc_inst +
> +             UMC_V12_0_NODE_DIST * node_inst + cross_node_offset; }
> +
> +static int umc_v12_0_reset_error_count_per_channel(struct amdgpu_device
> *adev,
> +                                     uint32_t node_inst, uint32_t umc_in=
st,
> +                                     uint32_t ch_inst, void *data)
> +{
> +     uint64_t odecc_err_cnt_addr;
> +     uint64_t umc_reg_offset =3D
> +             get_umc_v12_0_reg_offset(adev, node_inst, umc_inst, ch_inst=
);
> +
> +     odecc_err_cnt_addr =3D
> +             SOC15_REG_OFFSET(UMC, 0, regUMCCH0_OdEccErrCnt);
> +
> +     /* clear error count */
> +     WREG32_PCIE_EXT((odecc_err_cnt_addr + umc_reg_offset) * 4,
> +                     UMC_V12_0_CE_CNT_INIT);
> +
> +     return 0;
> +}
> +
> +static void umc_v12_0_reset_error_count(struct amdgpu_device *adev) {
> +     amdgpu_umc_loop_channels(adev,
> +             umc_v12_0_reset_error_count_per_channel, NULL); }
> +
> +static void umc_v12_0_query_correctable_error_count(struct amdgpu_device
> *adev,
> +                                                uint64_t umc_reg_offset,
> +                                                unsigned long *error_cou=
nt)
> +{
> +     uint64_t mc_umc_status;
> +     uint64_t mc_umc_status_addr;
> +
> +     mc_umc_status_addr =3D
> +             SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_STATUST0);
> +
> +     /* Rely on MCUMC_STATUS for correctable error counter
> +      * MCUMC_STATUS is a 64 bit register
> +      */
> +     mc_umc_status =3D
> +             RREG64_PCIE_EXT((mc_umc_status_addr + umc_reg_offset) *
> 4);
> +
> +     if (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1 &&
> +         REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, CECC) =3D=3D 1)
> +             *error_count +=3D 1;
> +}
> +
> +static void umc_v12_0_query_uncorrectable_error_count(struct amdgpu_devi=
ce
> *adev,
> +                                                   uint64_t umc_reg_offs=
et,
> +                                                   unsigned long *error_=
count)
> {
> +     uint64_t mc_umc_status;
> +     uint64_t mc_umc_status_addr;
> +
> +     mc_umc_status_addr =3D
> +             SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_STATUST0);
> +
> +     /* Check the MCUMC_STATUS. */
> +     mc_umc_status =3D
> +             RREG64_PCIE_EXT((mc_umc_status_addr + umc_reg_offset) *
> 4);
> +
> +     if ((REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1) &&
> +         (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) =3D=3D 1 ||
> +         REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, UECC) =3D=3D 1 ||
> +         REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, PCC) =3D=3D 1 ||
> +         REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, UC) =3D=3D 1 ||
> +         REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, TCC) =3D=3D 1))
> +             *error_count +=3D 1;
> +}
> +
> +static int umc_v12_0_query_error_count(struct amdgpu_device *adev,
> +                                     uint32_t node_inst, uint32_t umc_in=
st,
> +                                     uint32_t ch_inst, void *data)
> +{
> +     struct ras_err_data *err_data =3D (struct ras_err_data *)data;
> +     uint64_t umc_reg_offset =3D
> +             get_umc_v12_0_reg_offset(adev, node_inst, umc_inst, ch_inst=
);
> +
> +     umc_v12_0_query_correctable_error_count(adev,
> +                                     umc_reg_offset,
> +                                     &(err_data->ce_count));
> +     umc_v12_0_query_uncorrectable_error_count(adev,
> +                                     umc_reg_offset,
> +                                     &(err_data->ue_count));
> +
> +     return 0;
> +}
> +
> +static void umc_v12_0_query_ras_error_count(struct amdgpu_device *adev,
> +                                        void *ras_error_status)
> +{
> +     amdgpu_umc_loop_channels(adev,
> +             umc_v12_0_query_error_count, ras_error_status);
> +
> +     umc_v12_0_reset_error_count(adev);
> +}
> +
> +static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
> +                                         struct ras_err_data *err_data,
> uint64_t err_addr,
> +                                         uint32_t ch_inst, uint32_t umc_=
inst,
> +                                         uint32_t node_inst, uint64_t
> mc_umc_status) {
> +
> +}
> +
> +static int umc_v12_0_query_error_address(struct amdgpu_device *adev,
> +                                     uint32_t node_inst, uint32_t umc_in=
st,
> +                                     uint32_t ch_inst, void *data)
> +{
> +     uint64_t mc_umc_status_addr;
> +     uint64_t mc_umc_status, err_addr;
> +     uint64_t mc_umc_addrt0;
> +     struct ras_err_data *err_data =3D (struct ras_err_data *)data;
> +     uint64_t umc_reg_offset =3D
> +             get_umc_v12_0_reg_offset(adev, node_inst, umc_inst, ch_inst=
);
> +
> +     mc_umc_status_addr =3D
> +             SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_STATUST0);
> +
> +     mc_umc_status =3D RREG64_PCIE_EXT((mc_umc_status_addr +
> umc_reg_offset)
> +* 4);
> +
> +     if (mc_umc_status =3D=3D 0)
> +             return 0;
> +
> +     if (!err_data->err_addr) {
> +             /* clear umc status */
> +             WREG64_PCIE_EXT((mc_umc_status_addr + umc_reg_offset) *
> 4, 0x0ULL);
> +
> +             return 0;
> +     }
> +
> +     /* calculate error address if ue error is detected */
> +     if (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1 &&
> +         REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, AddrV) =3D=3D 1 &&
> +         REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, UECC) =3D=3D
> +1) {
> +
> +             mc_umc_addrt0 =3D
> +                     SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_ADDRT0);
> +
> +             err_addr =3D RREG64_PCIE_EXT((mc_umc_addrt0 +
> umc_reg_offset) * 4);
> +
> +             err_addr =3D REG_GET_FIELD(err_addr,
> MCA_UMC_UMC0_MCUMC_ADDRT0,
> +ErrorAddr);
> +
> +             umc_v12_0_convert_error_address(adev, err_data, err_addr,
> +                                     ch_inst, umc_inst, node_inst);
> +     }
> +
> +     /* clear umc status */
> +     WREG64_PCIE_EXT((mc_umc_status_addr + umc_reg_offset) * 4,
> 0x0ULL);
> +
> +     return 0;
> +}
> +
> +static void umc_v12_0_query_ras_error_address(struct amdgpu_device *adev=
,
> +                                          void *ras_error_status)
> +{
> +     amdgpu_umc_loop_channels(adev,
> +             umc_v12_0_query_error_address, ras_error_status); }
> +
> +static int umc_v12_0_err_cnt_init_per_channel(struct amdgpu_device *adev=
,
> +                                     uint32_t node_inst, uint32_t umc_in=
st,
> +                                     uint32_t ch_inst, void *data)
> +{
> +     uint32_t odecc_cnt_sel;
> +     uint64_t odecc_cnt_sel_addr, odecc_err_cnt_addr;
> +     uint64_t umc_reg_offset =3D
> +             get_umc_v12_0_reg_offset(adev, node_inst, umc_inst, ch_inst=
);
> +
> +     odecc_cnt_sel_addr =3D
> +             SOC15_REG_OFFSET(UMC, 0, regUMCCH0_OdEccCntSel);
> +     odecc_err_cnt_addr =3D
> +             SOC15_REG_OFFSET(UMC, 0, regUMCCH0_OdEccErrCnt);
> +
> +     odecc_cnt_sel =3D RREG32_PCIE_EXT((odecc_cnt_sel_addr +
> umc_reg_offset)
> +* 4);
> +
> +     /* set ce error interrupt type to APIC based interrupt */
> +     odecc_cnt_sel =3D REG_SET_FIELD(odecc_cnt_sel, UMCCH0_OdEccCntSel,
> +                                     OdEccErrInt, 0x1);
> +     WREG32_PCIE_EXT((odecc_cnt_sel_addr + umc_reg_offset) * 4,
> +odecc_cnt_sel);
> +
> +     /* set error count to initial value */
> +     WREG32_PCIE_EXT((odecc_err_cnt_addr + umc_reg_offset) * 4,
> +UMC_V12_0_CE_CNT_INIT);
> +
> +     return 0;
> +}
> +
> +static void umc_v12_0_err_cnt_init(struct amdgpu_device *adev) {
> +     amdgpu_umc_loop_channels(adev,
> +             umc_v12_0_err_cnt_init_per_channel, NULL); }
> +
> +static bool umc_v12_0_query_ras_poison_mode(struct amdgpu_device *adev)
> +{
> +     /*
> +      * Force return true, because regUMCCH0_EccCtrl
> +      * is not accessible from host side
> +      */
> +     return true;
> +}
> +
> +const struct amdgpu_ras_block_hw_ops umc_v12_0_ras_hw_ops =3D {
> +     .query_ras_error_count =3D umc_v12_0_query_ras_error_count,
> +     .query_ras_error_address =3D umc_v12_0_query_ras_error_address,
> +};
> +
> +struct amdgpu_umc_ras umc_v12_0_ras =3D {
> +     .ras_block =3D {
> +             .hw_ops =3D &umc_v12_0_ras_hw_ops,
> +     },
> +     .err_cnt_init =3D umc_v12_0_err_cnt_init,
> +     .query_ras_poison_mode =3D umc_v12_0_query_ras_poison_mode, };
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
> b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
> new file mode 100644
> index 00000000000000..2e63cc30766bc3
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
> @@ -0,0 +1,56 @@
> +/*
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person
> +obtaining a
> + * copy of this software and associated documentation files (the
> +"Software"),
> + * to deal in the Software without restriction, including without
> +limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> +sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom
> +the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> +included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> +EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> +MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT
> +SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> +DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> +OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> USE
> +OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#ifndef __UMC_V12_0_H__
> +#define __UMC_V12_0_H__
> +
> +#include "soc15_common.h"
> +#include "amdgpu.h"
> +
> +#define UMC_V12_0_NODE_DIST          0x40000000
> +#define UMC_V12_0_INST_DIST          0x40000
> +
> +/* UMC register per channel offset */
> +#define UMC_V12_0_PER_CHANNEL_OFFSET 0x400
> +
> +/* UMC cross node offset */
> +#define UMC_V12_0_CROSS_NODE_OFFSET          0x100000000
> +
> +/* OdEccErrCnt max value */
> +#define UMC_V12_0_CE_CNT_MAX         0xffff
> +/* umc ce interrupt threshold */
> +#define UMC_V12_0_CE_INT_THRESHOLD   0xffff
> +/* umc ce count initial value */
> +#define UMC_V12_0_CE_CNT_INIT        (UMC_V12_0_CE_CNT_MAX -
> UMC_V12_0_CE_INT_THRESHOLD)
> +
> +/* number of umc channel instance with memory map register access */
> +#define UMC_V12_0_CHANNEL_INSTANCE_NUM               8
> +/* number of umc instance with memory map register access */
> +#define UMC_V12_0_UMC_INSTANCE_NUM           4
> +
> +/* Total channel instances for all available umc nodes */ #define
> +UMC_V12_0_TOTAL_CHANNEL_NUM(adev) \
> +     (UMC_V12_0_CHANNEL_INSTANCE_NUM * (adev)->gmc.num_umc)
> +
> +extern struct amdgpu_umc_ras umc_v12_0_ras;
> +
> +#endif
> --
> 2.25.1

