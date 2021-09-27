Return-Path: <SRS0=K0ja=OR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67494C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 20:35:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26671611C0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 20:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 26671611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79D986E03D;
	Mon, 27 Sep 2021 20:35:06 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2063.outbound.protection.outlook.com [40.107.95.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BC506E03D
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Sep 2021 20:35:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcMgyOuX+L1Y46zdGu9n95Q/SlrsX6ZjvBVBWRQkfd6xj2Mp5WgC+Pvc85Ssl7hhdiCyl/S6su1UNst3ueX/DaMik4U3JDOrx3uByufsDBkmRcV0JoyoCZz9/YF8xbaJkqS32IJEocgltjcQyTLK/su4gU25aYU2yqSyzD/ebxonROIztPbgfdmnaHyT6HrVRf/CUHEUAhQIb21wwj/FeiQELPORXJaCzNybVch0PEmStIYI7K0/v0OA+Zelm092PfLMZxPDETztj5WdwcNRKdq4GJIa7DN9Wul8mL592P6yJvozvPvWYA03KbqUFzvY1dFQGPBGI3ir4Y0GzRQu4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=QsgZ8PyKYQKR3Zm0OSpzv3h04e6nXINKoe1iw1qP5KQ=;
 b=a9s/j1o5u2O1xTCSlPB586lj2uD+7adB8YtFG/httkf1IzeCuynKIkBQz3Ko4aOFxE/tktfMUEsGV9Bc4LwwUxmcrZyXncWFpx/+PDWueDET3IimQvTKkkaSndpkIQZFWGNn8cTvJBYJCYG8s2aoxj9SCgouWf2WuSG0AKyEn7AXLbcianTAOPXT97loDLzVHUERtYZfZCuh/Yt5P9RFYwZ1edhz0F2tUVvuQWn8IsQLw2bwLXhw59gBx8c4kkxVhx8PM0s0OKL57GWIKzNzmP9GEYM15jMUD8essubXj7mPcThmlylC8//8UbKK654nAAt/OpSFBBLbtzL8ibM4Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsgZ8PyKYQKR3Zm0OSpzv3h04e6nXINKoe1iw1qP5KQ=;
 b=jmhLt9X3m0Dar4finYq9lfx48Owux8+Oe1+q/3WeINlm4WdsQupDSFeeD/ElEVYXDctAiZYnzWCzCeJTJhdYUwEt/E57jaFfvyFM97kVywp0FI+f74tk6dUDk5F67po2e08UPnePxNl5Ej+tEyWTtwAnznYZ5qJ8sBX/cRTuPkk=
Received: from CH0PR12MB5201.namprd12.prod.outlook.com (2603:10b6:610:b8::21)
 by CH0PR12MB5140.namprd12.prod.outlook.com (2603:10b6:610:bf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Mon, 27 Sep
 2021 20:35:02 +0000
Received: from CH0PR12MB5201.namprd12.prod.outlook.com
 ([fe80::c09b:77fe:f749:15c6]) by CH0PR12MB5201.namprd12.prod.outlook.com
 ([fe80::c09b:77fe:f749:15c6%8]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 20:35:02 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Charlene" <Charlene.Liu@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Lei, Jun" <Jun.Lei@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
Subject: [PATCH 00/02] cyan skillfish display support
Thread-Topic: [PATCH 00/02] cyan skillfish display support
Thread-Index: Adez3xM1JvkPkaZJQ+egH3A9vRM5uw==
Date: Mon, 27 Sep 2021 20:35:02 +0000
Message-ID: <CH0PR12MB52019E1779335772DA47E2849EA79@CH0PR12MB5201.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d9504b12-4289-4dbf-a6ff-f9a9c1132636;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-09-27T20:29:43Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6761f5af-775f-4f0b-2977-08d981f64871
x-ms-traffictypediagnostic: CH0PR12MB5140:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB5140D9DD7E5150304C8037DB9EA79@CH0PR12MB5140.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +D7jUuEOarLKzzHaGu03eKLmnlcEMBBBlltX/z7tLV9woVRjpztiOYAsNzJfCc8aQx2OpTmv3jf9E9apsdHtVNGcG8xUx9Iag/oD0cV4YbmYfRicZy4UxpOO73+5CZZdG9bbJr8HZZqajq0F8byPMJSpi5/EwkmpEWzwz73hTqE3xUtaxQbiOkaUoNVnW3jvmN/0JInCwUlmkZ2YKlYlw+tIXLo2YmTd9ekruiSxalUnHyt6XR0UcbhBIqA1iRWWEc/dQKIFLGc58pbmvOyN1HbX/8YQu4SviDcaKb3CE9XD1madCLPWJqglgfM2+KnDyIKYDMu3P4VKz/y7brbENmLxve7c11nqqae8ewNY8QQtArQBQUJy6ixh3ROyY9b4zpWMU8JhP0YKx0rOvbdaURSqIguqwHUwi388Zh0EyGwp747r6ok9b+POw8JWpab5Qpc+UG1CWcNf/nSucMGHfiUDsHBwfShw88Et5VgFpB/149uDZLuB/SYU8HmjYew1LSC7en3z3LBpxde/5fpUyMTCaGjFG0sfalwYPyOARlyC7jBxgw+L1iVPeWP30KUFdfB3BAT2vTOoXw0G6TLZrDxDDKxTfrHtWL6iVq9fZtIwWdAjVdmJwlktEeSXq15Dl0oDf+R20D0K0V2Z0c2ZQoD0p7DmRhX0wWw6TyG0Va1wtCCZoNAy3wo0NZREsHtTjZMR83h+WJW8jPmTNEGw91qd1iwCrFPBe268WEMwo0k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(76116006)(8936002)(9686003)(26005)(2906002)(55016002)(66946007)(66476007)(64756008)(66556008)(33656002)(66446008)(71200400001)(186003)(52536014)(6506007)(921005)(6636002)(8676002)(38100700002)(5660300002)(122000001)(86362001)(316002)(7696005)(83380400001)(38070700005)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hk5RsQa2wGydToeVT26HFiywSrDM1+VlpE8scqyxf79hdrbBFaVd00TiwVL6?=
 =?us-ascii?Q?6YXL1gi3gIQne46FuwT1QWFD/3T5YGa1kpZHU89zSodWQpxhfCE81mvwe1KR?=
 =?us-ascii?Q?7B5eUxYlDmLj4iMaQ5uaGBUARPXVY138QglmetS/PFnCGsKUKYOS2Brlw2OU?=
 =?us-ascii?Q?/MfAtiiQwPhMyB31g+tBN0c00AOkmcVzLNclnbCziQdpV/NP7RlXf8yYkPWT?=
 =?us-ascii?Q?+4Oj9XhA0ikRPrHfFej1p+Iz6IPGx7V4Hf5jzmXT+AFCrNogqg/dP8QfBR24?=
 =?us-ascii?Q?09D3MYD6lrli2d7xOt6Yi6hiuaI9b/jUulbBWx6cA2AXTGXu1Xo+DDXniUc9?=
 =?us-ascii?Q?OusJc7u7zML4j7FkIzCSfeP8SSwGDSR0jhN5UM5KbDw4LMJRvDkuM4mRWSZF?=
 =?us-ascii?Q?obS/zvDeF0Ed9V7YzzAX9jZY/+wRIcqmFOOgqJiUVX2NQWCkXXVn8SxLk4Y9?=
 =?us-ascii?Q?KgoupTBPVxLJaAHN3ldkq9bdjkzOwB74AkMyVP4CoMX4ASr51i+FGPllvmwi?=
 =?us-ascii?Q?jzcKYR2ccq1aNP/GJiIyQfr+qm6zuLhZvsR+/WhKuJPpPPFBdbA+G2K4Y0vp?=
 =?us-ascii?Q?eX8kHoi+ximNHKCnZzTvXciXUqnxTC8+fEZN+gvdVa1P2vDpvy3rqPA5/4TN?=
 =?us-ascii?Q?/0qcwmYqdhHDtB6xFXDy4S8s0NSPWo+BA+cDb/i6xAHSuovyE4vJvd5kF/mF?=
 =?us-ascii?Q?HEakL32tNXeR5BBXvRBmttyLXEO7nE/Ic6Y5oJmm5INIGhdumCQx4grEQycS?=
 =?us-ascii?Q?9FTknt69iyn5PsCPzHn5+StfFsTCQ0Q+7ebgZXoEwqDlPMPvm4ggoL/pFwxm?=
 =?us-ascii?Q?AgUNLST8z/yPmC8D+KHk1qOLlHd7TQ8LZOdcvCnGWsAR/edACDo8wd6HhGpO?=
 =?us-ascii?Q?6BCKWivamW6G+iyEuxHl/hOFrBUsXJznYXKkfM0EfnJkqybWaOkdlHKPYq/p?=
 =?us-ascii?Q?NjnovbhAjz+S6bMYv/+zr3gilzJeztCQJttGXd+n3wqY4wKXEmC+nYpkYzGe?=
 =?us-ascii?Q?Y0J9t10Mt9P+H7xKf8iPCD9brzwr9i9UD5TQ+UWWpRIRm8LA/S5bSu5xNJ8a?=
 =?us-ascii?Q?vebFck/a14wapprJlpe0U3Tu8ErQLYoDmacXYbbVMtS9a/HcAxRi9AyHKsda?=
 =?us-ascii?Q?QZclya40ALteRowoxfU3yssZ1rq5E3joFLaQNNM2mGfjJxBDtpxMvjPmfRYJ?=
 =?us-ascii?Q?bDQt+I3FEmBxBqqsJ9Lk0do41MJcK9nJTkL0q1+6ap6sb755tvEpQbQmP5q/?=
 =?us-ascii?Q?Y093jklFNeVc4XvijWvlyuQpAU1NxCPbwKtFaR6eAYuwUzlbsXxP0pi/o9iv?=
 =?us-ascii?Q?ikaINBo81SkYVNtMETw7GuWs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6761f5af-775f-4f0b-2977-08d981f64871
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 20:35:02.4291 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X5swZSZqqVsRBogdVnFRcuFn7oKc8OZtCc83UEgv8CcdY6EksafiZDbjdNC6klOT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5140
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

This patch set brings cyan skillfish display support

Charlene Liu / Zhan Liu (2):
drm/amdgpu: add cyan_skillfish asic header files
drm/amd/display: add cyan_skillfish display support

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                     |     4 +
 drivers/gpu/drm/amd/amdgpu/nv.c                                |     2 +
 drivers/gpu/drm/amd/display/Kconfig                            |     9 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c              |    55 +-
 drivers/gpu/drm/amd/display/dc/Makefile                        |     3 +
 drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c    |     1 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile                |    11 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c               |     7 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c |   260 +++
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.h |    34 +
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c              |    10 +
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h          |     9 +
 drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h                 |    39 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_ipp.h               |    27 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c          |     3 +
 drivers/gpu/drm/amd/display/dc/dcn201/Makefile                 |    33 +
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dccg.c            |    84 +
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dccg.h            |    37 +
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c             |   316 +++
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.h             |    83 +
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubbub.c          |   107 +
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubbub.h          |    45 +
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubp.c            |   150 ++
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubp.h            |   132 ++
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c           |   630 +++=
+++
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.h           |    46 +
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c            |   131 ++
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.h            |    33 +
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_link_encoder.c    |   209 ++
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_link_encoder.h    |    59 +
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_mpc.c             |   125 ++
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_mpc.h             |    86 +
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_opp.c             |    72 +
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_opp.h             |    74 +
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_optc.c            |   203 ++
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_optc.h            |    74 +
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c        |  1307 +++=
+++++++++
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.h        |    50 +
 drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c          |     1 +
 drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h          |     1 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c               |     1 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c             |     1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h       |    13 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h                    |     4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h                    |     1 +
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h      |     4 +
 drivers/gpu/drm/amd/display/dc/irq/Makefile                    |    12 +
 drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c |   374 +++=
+
 drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.h |    34 +
 drivers/gpu/drm/amd/display/include/dal_asic_id.h              |     1 +
 drivers/gpu/drm/amd/display/include/dal_types.h                |     1 +
 drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_0_1_offset.h   |    32 +
 drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_0_1_sh_mask.h  |    37 +
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_offset.h    |  6193 +++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h   | 22091 +++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_2_0_3_offset.h  |   151 ++
 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_2_0_3_sh_mask.h |   952 +++=
++++++
 57 files changed, 34439 insertions(+), 25 deletions(-)

--
2.25.1

