Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEC8C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jan 2022 16:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C8031121C4;
	Fri,  7 Jan 2022 16:55:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAB031121C4
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jan 2022 16:55:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MS6Tdwv/UEzzL9IPh3XVGMzfGMVWWput8govfD1viKFM3AdblskViczQvKRbJMBjS9KVCm085E49zqNKO0NFcKmJOs1vT+/PE7t0ivP28ftDGbuT1TLpsPxSbBFZKA+AqSEYtzJ9PtZ6a6Yc1nH0wSUlVXSP2Zx22KULwjvUAcHZKQ83vRX3DkXwymHXXWt6S8uOh2GKn/6TXH9IlwKKbo3ie9NDap+Eo24ZzimHbHTFl2eIuU735Ae3+9ojwZvMciKXbzhj2hl4XhtwTDLeAF/BMx7WcAu0K2KR7f3LAW6IyPFTeodZyTJo/yGJ9QEJWBCnhkMr6w/Okn7E2sgvRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLtslZitmThsTma6/n4/4gRGbT0FntrkKNUFYUZxV+Q=;
 b=PCzLp2y+6upOjiC2/acFNABtr1Nnws0d0bhaw5qCGhhetJvuhDar/8QUnoyxMA/hziPDaDkXlVUNyu6z2zfiRvMtRlnl9Qj0SoSu97k3ycmWGZbADdrzVHO4vuNDvlS+xopmJY/pGTZCZ5FJMmDf5t+Ua+O+0p4/kl/wRBMaklfQajqHMW8lOVMRn/ohGlKsAqekwl3JFjhj6dbprsjOkyB8F47SPt0RMggRN9WWhljXJgPjskz5XMdvVGy+CP1fIc+D1XZI3wfzOQs2+VvPIrvBKsP9qMucsmsriOtGivZIfV5FNmdau+ISl/T+rqcEzSvksO7vgcHg78Q6u0olJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLtslZitmThsTma6/n4/4gRGbT0FntrkKNUFYUZxV+Q=;
 b=eYbaJiLvJ5QcVRWFmV/LzrzdqFV42f4itSdtdjrJgbyso9IvT0xACBq4E12OA7kQhw2as7vyQPp9N74jECv0pgjtgnQrJIZQHp6inp1RmcYVWndHhoHhlSFRRS+eW65VERrJagr0rz2+UfNRqqDXMgWUCz0ixfRA469dMQb6vUc=
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM4PR12MB5360.namprd12.prod.outlook.com (2603:10b6:5:39f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21; Fri, 7 Jan
 2022 16:55:48 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::98fd:4e9b:b4d6:64a3]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::98fd:4e9b:b4d6:64a3%7]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 16:55:48 +0000
From: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v5] drm/amd/display: Revert W/A for hard hangs on
 DCN20/DCN21
Thread-Topic: [PATCH v5] drm/amd/display: Revert W/A for hard hangs on
 DCN20/DCN21
Thread-Index: AQHYA+ae6sg+dIaBJUyRjV2fOt6qWqxXxhOA
Date: Fri, 7 Jan 2022 16:55:48 +0000
Message-ID: <DM4PR12MB51821C74C0F9C8254A8CE048EC4D9@DM4PR12MB5182.namprd12.prod.outlook.com>
References: <20220107164959.12511-1-mario.limonciello@amd.com>
In-Reply-To: <20220107164959.12511-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=840ffa62-39d5-4d2a-820b-33ceb3ffcdbd;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-07T16:52:21Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d99d0c5-ea3e-4780-0d1f-08d9d1fe8e28
x-ms-traffictypediagnostic: DM4PR12MB5360:EE_
x-microsoft-antispam-prvs: <DM4PR12MB53603B495529BF16D64EA78AEC4D9@DM4PR12MB5360.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:279;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zHJFM2fJGvFtzgZTXjXU5NQ6UDWJqlbhadyWXgm6Jx6lsep5IYsqYWQm/wxy9c5XVyL2XHLs3xIltPDidjZBYuIhjoZK/87l6UfW/O9Ano3+V8RynDNgBS0LnhOS+vab1Mf34NL2Y2Qc97brgu9NnH2vvrQ/iDoYJ8CIMB82jbJVA6e1q0v3H3E7hpuLyQZgnwDiAk/82wi34LHq05SAB819fo0W5TaObLOkx5SYz7mVMBSmpHmo/JTKhiCJ+aNYD7yZOVdXaoy1g7qAb48mDafFvX56gstNWir+I5xFaVdOI3HDquVaOPEHPzyQp1AGzQX3kw7UjZO1rncKk+mExuQOgdjRmVdAgPbNlgfJnGxutjG2RayRh4dZFLwnUlUahDfgWtuthiJCne6THFg/13hCEXFxLFfVq6m4qhl0lwYLSyHBsrWDxi0nIxKNMHBD3JZ7VHwf6R7QYLG1NKMMsN2XL2xI9R5pte4qBldAcS3ZP6ORIgPGB4P1vsybV07oev8J7REWBmGnix5PUQ64rxZF5XW3mq1vLi9SE/Q4MfRxAUoth99tR08L/ZIS1S01Rn2dtGZO/VmG7eg6SU/zh9F6iVjvS2Rb4Ey/UfYtFjSE8JGfAzHhPJuVFzCUzlgroZnHFxTDBQoRPfdRtw46WBh60qYDYKAA/W1EpTv+MxoRtkQy7pQCVfPvqN7nvb0k9w8fAYkKXQVSd1O9HXDe5PZ32F1NuRpNUs1Z7BNtEdNGks8NSH2607TAkYAQLL/ym5fkQzDSQzX6A4/pcwbaioDVH60PsExunyE+xOEKu/4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(38100700002)(66556008)(4326008)(66946007)(316002)(53546011)(6506007)(26005)(71200400001)(8676002)(64756008)(508600001)(66476007)(66446008)(5660300002)(2906002)(33656002)(83380400001)(8936002)(110136005)(55016003)(186003)(9686003)(52536014)(86362001)(966005)(122000001)(76116006)(38070700005)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mLFQGDaMFHKmdD+GOAgeugRaJpqvKL+2VeUPsNlPq/MOfGCIrTOgfAIJ9sXN?=
 =?us-ascii?Q?2S+ES/zuQuOpXcOkXWOQh/FVFpq3CXR3omEcZo3BUZ6BB454YZBgqXLJGj0h?=
 =?us-ascii?Q?js3F5G18Ir9deKTDIRfItVlEVCr8UAcUTS00qrJTVIljTNXKt1C13qHn1FCo?=
 =?us-ascii?Q?WWDrlWhZnvpUwgbXZx7nQfu7Buryqdcwq0sOKqerZmAwh0y8pSX6WnvLJhN5?=
 =?us-ascii?Q?flyRoNKkvRhu9KINUN36cGZBI8ReA9+EGHSTBk9PE1/8zEAhWzvW12z+lwbR?=
 =?us-ascii?Q?OTXVjfpSGTU+k85fD3DDBnC1WXTUCAQj6uAuYdartjcYIm55L9iE/JHVCaXa?=
 =?us-ascii?Q?OOUjuYuFl+ho7YdbV5ZhFpSh0XarcWE44dy8Su0JijD8VNSunrnzNZj3Bj93?=
 =?us-ascii?Q?ScuYj/M7OqIYi/AFEWiZCn4WF3cn4AhWs0w5ecNrwMgQfQ2Jjg4pkr1yCQFt?=
 =?us-ascii?Q?B25RwVylIp9ykKgCjC5+OHAaF41bXsDlEfDP6TcESDtk89cFytHJgo/LDHmQ?=
 =?us-ascii?Q?0/Dmhm8hfGqOL/sOkwUWiLavglAQHo8V/9175dkduaYYRC633B99zmcv0HOg?=
 =?us-ascii?Q?gUOhhM7rvqcKO7+QVHVqDdpDe3qtZ6bA//rQOk0SMGQO1hv+jiX13DLIjpVe?=
 =?us-ascii?Q?yYPM11ZsympDPWZRbOiszQD2uLrpRbBYN46T6YKgmCxOaci70jpqgrZ0rkAo?=
 =?us-ascii?Q?zf81d949GxTN9cDNEbbT2EM7QSZ94QsreGVflmiQ68qqPQ5YmMAxceWqiqrj?=
 =?us-ascii?Q?lmcBrJ1uQBExaCA2NsKLGVz071kzEHepodaIc0I4eK9Rap70O1ZbtLNGPoBL?=
 =?us-ascii?Q?/UObXBIG9R17sgC0422BdRQCcWBvSXNfHe5CuBT+5zSu3Pxze+RdxZPGkA8m?=
 =?us-ascii?Q?/Cl1dUpk9p4D+8Ne+p64FpDKC+FAFi/gg1oNcTlxZHrHb9/CQjjaWVRLOE3i?=
 =?us-ascii?Q?eO6yM3zCRwtAKb+MCeqgwcAUE7wTwZjARPNurvMkKBHB5BsMYG/6oUhykwiq?=
 =?us-ascii?Q?6cvjC0bdalTLs8s5Uc/4aRgWDY7+zRZ/HNvYgY11XttN0ZcPQrkEOKUndqBY?=
 =?us-ascii?Q?cvlCfFAtHnYNuvualrIrCEiNSJEIAqZQDIyZiUhCIC20uBGg2a3QU8U4GDyA?=
 =?us-ascii?Q?hOU86DXtw7tuJCd5lMB2ekCqc83h6en69ZjtQxFBE/uKIQw7TBki5SYQCp7m?=
 =?us-ascii?Q?RmhNGqiUJp/aah1lRocJsCqbhrjB/Xr/5gQM+OTV5h0x5A8DCRZcWuRimH5B?=
 =?us-ascii?Q?njk7erkH1CvFtp//o8SSnu2+4E8MjHHgRfD2PnjDpDU+J4k4lB5yJ/JKCUcl?=
 =?us-ascii?Q?0aMp0w+q88/crEuBWTZT3yB8841OxpnT9bE7MrikxS04tDdSO8h099ZC1EA6?=
 =?us-ascii?Q?cH7Jy5sSYZEF4wTbc1bSRpwmyq67b7kzxGQRxM7vMlzQXMX8LSleELwZfSA4?=
 =?us-ascii?Q?vQCR08e781LYvtc271Cg8cNO8HyVvEi7qmr2IPvrjkepS9T4sV7k9cm5VsLW?=
 =?us-ascii?Q?ZFb0rJxKPsujQ0C+ZgXXbTf4r81GXJUsbhX8f+HWI9NDVTMLz6ShCSu7aXCZ?=
 =?us-ascii?Q?gb8foAs1QCWlg2MrlZzs+QIspKi3oKcHSfhvXJrJg6BeXyQ2r7NOF85b7hC3?=
 =?us-ascii?Q?QWZxlxMm7BEuf31/18hBrJo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d99d0c5-ea3e-4780-0d1f-08d9d1fe8e28
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 16:55:48.4562 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lvgsW5q1cxoMsgFJaAxQyqFuvV8k8FGSZBzyWCGC9qGkycSqQJpk3LH48TtvB2DAxi2dxbqxOQAl/yW48WsBMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5360
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
Cc: "Zhuo, Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>,
 Scott Bruce <smbruce@gmail.com>, "spasswolf@web.de" <spasswolf@web.de>,
 Chris Hixon <linux-kernel-bugs@hixontech.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: January 7, 2022 11:50 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Kazlauskas, Nicholas
> <Nicholas.Kazlauskas@amd.com>; Zhuo, Qingqing (Lillian)
> <Qingqing.Zhuo@amd.com>; Scott Bruce <smbruce@gmail.com>; Chris
> Hixon <linux-kernel-bugs@hixontech.com>; spasswolf@web.de
> Subject: [PATCH v5] drm/amd/display: Revert W/A for hard hangs on
> DCN20/DCN21
> Importance: High
>
> The WA from commit 2a50edbf10c8 ("drm/amd/display: Apply w/a for hard
> hang
> on HPD") and commit 1bd3bc745e7f ("drm/amd/display: Extend w/a for hard
> hang on HPD to dcn20") causes a regression in s0ix where the system will
> fail to resume properly on many laptops.  Pull the workarounds out to
> avoid that s0ix regression in the common case.  This HPD hang happens wit=
h
> an external device and a new W/A will need to be developed for this in th=
e
> future.
>
> Cc: Kazlauskas Nicholas <Nicholas.Kazlauskas@amd.com>
> Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
> Reported-by: Scott Bruce <smbruce@gmail.com>
> Reported-by: Chris Hixon <linux-kernel-bugs@hixontech.com>
> Reported-by: spasswolf@web.de
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215436
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1821
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1852
> Fixes: 2a50edbf10c8 ("drm/amd/display: Apply w/a for hard hang on HPD")
> Fixes: 1bd3bc745e7f ("drm/amd/display: Extend w/a for hard hang on HPD to
> dcn20")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

I think the revert is fine once we figure out where we're missing calls to:

        .optimize_pwr_state =3D dcn21_optimize_pwr_state,
        .exit_optimized_pwr_state =3D dcn21_exit_optimized_pwr_state,

These are already part of dc_link_detect, so I suspect there's another inte=
rface in DC that should be using these.

I think the best way to debug this is to revert the patch locally and add a=
 stack dump when DMCUB hangs our times out.

That way you can know where the PHY was trying to be accessed without the r=
efclk being on.

We had a similar issue in DCN31 which didn't require a W/A like DCN21.

I'd like to hold off on merging this until that hang is verified as gone.

Regards,
Nicholas Kazlauskas

> ---
>  .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  | 11 +-------
>  .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 11 +-------
>  .../display/dc/irq/dcn20/irq_service_dcn20.c  | 25 -------------------
>  .../display/dc/irq/dcn20/irq_service_dcn20.h  |  2 --
>  .../display/dc/irq/dcn21/irq_service_dcn21.c  | 25 -------------------
>  .../display/dc/irq/dcn21/irq_service_dcn21.h  |  2 --
>  .../gpu/drm/amd/display/dc/irq/irq_service.c  |  2 +-
>  .../gpu/drm/amd/display/dc/irq/irq_service.h  |  4 ---
>  8 files changed, 3 insertions(+), 79 deletions(-)
>
> diff --git
> a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
> b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
> index 9f35f2e8f971..cac80ba69072 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
> @@ -38,7 +38,6 @@
>  #include "clk/clk_11_0_0_offset.h"
>  #include "clk/clk_11_0_0_sh_mask.h"
>
> -#include "irq/dcn20/irq_service_dcn20.h"
>
>  #undef FN
>  #define FN(reg_name, field_name) \
> @@ -223,8 +222,6 @@ void dcn2_update_clocks(struct clk_mgr
> *clk_mgr_base,
>       bool force_reset =3D false;
>       bool p_state_change_support;
>       int total_plane_count;
> -     int irq_src;
> -     uint32_t hpd_state;
>
>       if (dc->work_arounds.skip_clock_update)
>               return;
> @@ -242,13 +239,7 @@ void dcn2_update_clocks(struct clk_mgr
> *clk_mgr_base,
>       if (dc->res_pool->pp_smu)
>               pp_smu =3D &dc->res_pool->pp_smu->nv_funcs;
>
> -     for (irq_src =3D DC_IRQ_SOURCE_HPD1; irq_src <=3D
> DC_IRQ_SOURCE_HPD6; irq_src++) {
> -             hpd_state =3D dc_get_hpd_state_dcn20(dc->res_pool->irqs,
> irq_src);
> -             if (hpd_state)
> -                     break;
> -     }
> -
> -     if (display_count =3D=3D 0 && !hpd_state)
> +     if (display_count =3D=3D 0)
>               enter_display_off =3D true;
>
>       if (enter_display_off =3D=3D safe_to_lower) {
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
> b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
> index fbda42313bfe..f4dee0e48a67 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
> @@ -42,7 +42,6 @@
>  #include "clk/clk_10_0_2_sh_mask.h"
>  #include "renoir_ip_offset.h"
>
> -#include "irq/dcn21/irq_service_dcn21.h"
>
>  /* Constants */
>
> @@ -129,11 +128,9 @@ static void rn_update_clocks(struct clk_mgr
> *clk_mgr_base,
>       struct dc_clocks *new_clocks =3D &context->bw_ctx.bw.dcn.clk;
>       struct dc *dc =3D clk_mgr_base->ctx->dc;
>       int display_count;
> -     int irq_src;
>       bool update_dppclk =3D false;
>       bool update_dispclk =3D false;
>       bool dpp_clock_lowered =3D false;
> -     uint32_t hpd_state;
>
>       struct dmcu *dmcu =3D clk_mgr_base->ctx->dc->res_pool->dmcu;
>
> @@ -150,14 +147,8 @@ static void rn_update_clocks(struct clk_mgr
> *clk_mgr_base,
>
>                       display_count =3D rn_get_active_display_cnt_wa(dc,
> context);
>
> -                     for (irq_src =3D DC_IRQ_SOURCE_HPD1; irq_src <=3D
> DC_IRQ_SOURCE_HPD5; irq_src++) {
> -                             hpd_state =3D dc_get_hpd_state_dcn21(dc-
> >res_pool->irqs, irq_src);
> -                             if (hpd_state)
> -                                     break;
> -                     }
> -
>                       /* if we can go lower, go lower */
> -                     if (display_count =3D=3D 0 && !hpd_state) {
> +                     if (display_count =3D=3D 0) {
>
>       rn_vbios_smu_set_dcn_low_power_state(clk_mgr,
> DCN_PWR_STATE_LOW_POWER);
>                               /* update power state */
>                               clk_mgr_base->clks.pwr_state =3D
> DCN_PWR_STATE_LOW_POWER;
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
> b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
> index 9ccafe007b23..c4b067d01895 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
> @@ -132,31 +132,6 @@ enum dc_irq_source to_dal_irq_source_dcn20(
>       }
>  }
>
> -uint32_t dc_get_hpd_state_dcn20(struct irq_service *irq_service, enum
> dc_irq_source source)
> -{
> -     const struct irq_source_info *info;
> -     uint32_t addr;
> -     uint32_t value;
> -     uint32_t current_status;
> -
> -     info =3D find_irq_source_info(irq_service, source);
> -     if (!info)
> -             return 0;
> -
> -     addr =3D info->status_reg;
> -     if (!addr)
> -             return 0;
> -
> -     value =3D dm_read_reg(irq_service->ctx, addr);
> -     current_status =3D
> -             get_reg_field_value(
> -                     value,
> -                     HPD0_DC_HPD_INT_STATUS,
> -                     DC_HPD_SENSE);
> -
> -     return current_status;
> -}
> -
>  static bool hpd_ack(
>       struct irq_service *irq_service,
>       const struct irq_source_info *info)
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.h
> b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.h
> index 4d69ab24ca25..aee4b37999f1 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.h
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.h
> @@ -31,6 +31,4 @@
>  struct irq_service *dal_irq_service_dcn20_create(
>       struct irq_service_init_data *init_data);
>
> -uint32_t dc_get_hpd_state_dcn20(struct irq_service *irq_service, enum
> dc_irq_source source);
> -
>  #endif
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
> b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
> index 235294534c43..0f15bcada4e9 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
> @@ -134,31 +134,6 @@ static enum dc_irq_source
> to_dal_irq_source_dcn21(struct irq_service *irq_servic
>       return DC_IRQ_SOURCE_INVALID;
>  }
>
> -uint32_t dc_get_hpd_state_dcn21(struct irq_service *irq_service, enum
> dc_irq_source source)
> -{
> -     const struct irq_source_info *info;
> -     uint32_t addr;
> -     uint32_t value;
> -     uint32_t current_status;
> -
> -     info =3D find_irq_source_info(irq_service, source);
> -     if (!info)
> -             return 0;
> -
> -     addr =3D info->status_reg;
> -     if (!addr)
> -             return 0;
> -
> -     value =3D dm_read_reg(irq_service->ctx, addr);
> -     current_status =3D
> -             get_reg_field_value(
> -                     value,
> -                     HPD0_DC_HPD_INT_STATUS,
> -                     DC_HPD_SENSE);
> -
> -     return current_status;
> -}
> -
>  static bool hpd_ack(
>       struct irq_service *irq_service,
>       const struct irq_source_info *info)
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.h
> b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.h
> index 616470e32380..da2bd0e93d7a 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.h
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.h
> @@ -31,6 +31,4 @@
>  struct irq_service *dal_irq_service_dcn21_create(
>       struct irq_service_init_data *init_data);
>
> -uint32_t dc_get_hpd_state_dcn21(struct irq_service *irq_service, enum
> dc_irq_source source);
> -
>  #endif
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
> b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
> index 4db1133e4466..a2a4fbeb83f8 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
> @@ -79,7 +79,7 @@ void dal_irq_service_destroy(struct irq_service
> **irq_service)
>       *irq_service =3D NULL;
>  }
>
> -const struct irq_source_info *find_irq_source_info(
> +static const struct irq_source_info *find_irq_source_info(
>       struct irq_service *irq_service,
>       enum dc_irq_source source)
>  {
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/irq_service.h
> b/drivers/gpu/drm/amd/display/dc/irq/irq_service.h
> index e60b82480093..dbfcb096eedd 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/irq_service.h
> +++ b/drivers/gpu/drm/amd/display/dc/irq/irq_service.h
> @@ -69,10 +69,6 @@ struct irq_service {
>       const struct irq_service_funcs *funcs;
>  };
>
> -const struct irq_source_info *find_irq_source_info(
> -     struct irq_service *irq_service,
> -     enum dc_irq_source source);
> -
>  void dal_irq_service_construct(
>       struct irq_service *irq_service,
>       struct irq_service_init_data *init_data);
> --
> 2.25.1

