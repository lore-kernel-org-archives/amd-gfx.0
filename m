Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351F6C19F2A
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Aug 2022 14:39:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 932E999359;
	Thu,  4 Aug 2022 14:38:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3528698986
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Aug 2022 14:38:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKoejo8Z8UUVCQXCl+yMgu4fBxawHGCSjSzuVny8gr63voA15++XMqjJuOct/rMWd8EhgEfevEFtfxwo2rgGpjX3XgthlpHUWVXumIYLpgaR7KPg6zl2wm1bUQq9QKy9MncsaDd0Q4O9SE7jo/WSG2wK6qYrTV2rWfRBiWCgT0UMXRZgPHaAwOWnJ+u3UhnIaBXLD+llNONe1VobADJURPWizn90wqoAkM0CEBc/rR4UBTXvT0VfTs/X0WwZZ+4av7hq3BQIDAQtcsT2rZJFihVqwYuWS2HaB9cBvatLP0Hk4NsooTrAk4twYMDp9VNL/vjpA4G4Jc5UudJ/Aj60DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVuqeCcw7YuQ7CqU+z7RfiHXB5P0x8T0vQv+lGpKYc4=;
 b=Vrc+iu5sbtMfFLqk+5KJM/F1hS7fg/or6iwSQt60yMHqOqdcIjAFVs/42MfcvJppaIPuZ+K9d3VCxrgnc/V5nPTaNd0+vr1L0kC6ypxdJC4qZ9vcF6OK1GXPE/G74cdkT6hjpPX2oGjFdub59l3Qd5TCMBx94Ba6KkI2rOvh8YLaOFyZMHHHBCBjtTdlKnSsufRijLV1oXbu7CXYkZIQqe/YuJtctzwkQTyAXIQP8NlsOz9hyx1aD5xZ6LYj7FUqnG/nOCLiv5pHgdoSCL7+w2xYa0lbmKxau/0JXn0pNLxJ6jPfHgFu/1HGOuKrWNk2XKj8W9fHc6u7lAY4PaQMDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVuqeCcw7YuQ7CqU+z7RfiHXB5P0x8T0vQv+lGpKYc4=;
 b=tq/JbAsWN7FDlwF43XRXJJdwZ9gLGnqgaLx7T7EI/Sfhw1ZVhuPtOGJOCoOEVr4hE2UP6x6XeDGu7bb6l0DnTftKtFchdRNosvy72bvJrC0IiY/UID5N2B+JcLrWGsVoszrhj0ifn7Gil78Ls+ZD3LdC9aCXtwx2SdMuaD4rzuk=
Received: from BN6PR1201MB0084.namprd12.prod.outlook.com
 (2603:10b6:405:57::22) by SJ1PR12MB6052.namprd12.prod.outlook.com
 (2603:10b6:a03:489::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Thu, 4 Aug
 2022 14:38:33 +0000
Received: from BN6PR1201MB0084.namprd12.prod.outlook.com
 ([fe80::2457:2c3a:39ae:6976]) by BN6PR1201MB0084.namprd12.prod.outlook.com
 ([fe80::2457:2c3a:39ae:6976%4]) with mapi id 15.20.5482.016; Thu, 4 Aug 2022
 14:38:32 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: change family id name for DCN314
Thread-Topic: [PATCH] drm/amd/display: change family id name for DCN314
Thread-Index: AQHYp+AeCdcal88uokaYbjHUdmWdrq2ez29g
Date: Thu, 4 Aug 2022 14:38:32 +0000
Message-ID: <BN6PR1201MB008433DE581DE713C386A754899F9@BN6PR1201MB0084.namprd12.prod.outlook.com>
References: <20220804084915.3734321-1-yifan1.zhang@amd.com>
In-Reply-To: <20220804084915.3734321-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f5e469ca-0e55-425f-b9a0-cf2f634b25a8;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-04T14:36:33Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e0bc9d5-974e-4572-ad43-08da7627017f
x-ms-traffictypediagnostic: SJ1PR12MB6052:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9BeyGQYAc4b9RPq5ugonOGE6L122zuZOUx9WYeQLvzTBoopm/9K/iV2MrSVMb5BRNQ9cIbFUkjUb8lZpEWVaR8YFGC4sfE+XXK/G8fYRzC+FECLEM071FFdxa1/DCCc9yRiYzbKDwF4eb9ASiUIaOnO9fRDx/ccya+hhlqG1qqK+jBgnWyPRO+xBJDpQKVT0iV/CcZCyuxp2v/bpV5eThxkZ6p/QuyoJdthNMc4YJyh29to0LfF/kjZmSHK8UuKxp6zEWlF4LpmGUyyrUz8qYFfOX8ltUcrIRj1lFpeo/yTK8pxbRWx9ibnaKzx8uuR9VFHftkFfW/URvEcjcIlg2f+T7urlNUGYBvofK2BV5QokfCksaW2Mj0ngDVLY7rcSB1t7jFXbeE7pETwtPDND0DymSqfbqXpvR6cdHCKGu8ZPG45GtLGG2kvUHe3cB9Oc0ctyrkNanzZQaLbUFWCDqjcEm7ldwYnb7jylBg0VPiXjmb1ODxLn9/gjPlfudUk7F612q7IazWtshtEtXR2eVvtZEFqIgeoD8wuZiQyEoSOxrolp6zi62/BpvAnCVRSLUGb+3iCPVXml6bvPIwG969kglQPKWAEM4DtY4jV/K0i95c1gXLmQ4mdL5Nq6n+WbzndGh2RR8rQ0XDB7SYJrEnc7UwxlkuG+A67Fpeb9G+QmFVoSk/gKDZNtiY/gCQPcESfPFX/wh+sWokxnCxcNRwjMl5eDHi9FNPSyRRHUVRm5mYIusiIZ95g5rghyCWAaa2uRFEI5zaYWIwfu9cgy9OGxgnMRrD6qn1QEGuAV9tyeqVdJjzCfQ5TgS1Xq0aJx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0084.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(86362001)(52536014)(55016003)(33656002)(76116006)(38070700005)(8676002)(4326008)(64756008)(66476007)(66556008)(66946007)(66446008)(316002)(5660300002)(9686003)(7696005)(6506007)(26005)(186003)(38100700002)(54906003)(110136005)(53546011)(478600001)(122000001)(83380400001)(8936002)(2906002)(41300700001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kxt50TnWWN90GW0aStmehp+Jj93598CJB8Wz1X6HE3zk1DNNSE1/seKBWR9s?=
 =?us-ascii?Q?Qdv3u8nPGOHvXz8tFOUdkl2Zh5++vzaoD8LKv17wQPXzGzyASm/qpSSIK+z1?=
 =?us-ascii?Q?Tc+/+/J/xWX1HpQVLKvKZ0RRUvPnjJYWzqp7i0lYhmhjsO9pfOVOn27lVMe4?=
 =?us-ascii?Q?Hid7e6AEktpCw38T6q+enRjjOoI9VdnqAeCGAyyXNGum7g2nmamT0fzzm+7m?=
 =?us-ascii?Q?Av0k/ua8rx8Q97E7V/U3LQ9hvh/xyoKwHTiI9ss+9T7oQS6tAc8aslIVarpH?=
 =?us-ascii?Q?/QU2wXgZbcaWE2t0suax19CVdQF56wCv6qvknsJLrD+yuV6G83KLg/yS9BMl?=
 =?us-ascii?Q?US+hRmc+PHGRUbVboH21PK/SslmZ0kGZ+wtrnQ5kagxmV7TzMBi4kmarMPxJ?=
 =?us-ascii?Q?Rdn4FDnM7oWDz7JI2Ujv7UYUfJNSHTutNpImyCaTWmcfhyMLbEOfmFhwM18B?=
 =?us-ascii?Q?UhC3coIaKNFOn4nIDnT5OaXdFo4eL6NDRXdwYwHeeVQQRJkLrOSr1bWSIWm7?=
 =?us-ascii?Q?xLalgYwjzhR0rpxqa5UPzTGVkE8p8PRCsHB3pYy+Mh931XjOsygAjS6Wvv2b?=
 =?us-ascii?Q?BrMVb/pndOJwQQjQO8tTa5p9fbMt8rb/5y6lFVcKVUl74zjrV1HKCqHNzqN3?=
 =?us-ascii?Q?sMvBxmCYufiRqGe4tULvOY83dHVPftzMHCB2RmCWtdU5CNa5f/XlFD7Xgmmp?=
 =?us-ascii?Q?W9ZqhfMjMm1OLd43I1Cw25vBgyREh1A5dcV9SRtGUO481sd4nu4UfSu1Gd2G?=
 =?us-ascii?Q?QeacSS8wyVCcQyg6+rcul0G+QyRdqDSW0SVtvVfbfCCO/ERh/FzMSQWTz7qv?=
 =?us-ascii?Q?x+fBJe4TVPyHAfBbytPIAWBxqTHvG2vY7PCIvq/tg2aIDJZ8z9KNZsHZK2zU?=
 =?us-ascii?Q?KKIKvWzjLHd4hYLHrm6hIghGhcFGNDo8lb1zmHg4RcvCjXZn2uUJNIW8yNan?=
 =?us-ascii?Q?5K/pf0zpZWY/a+aev7uWzncP6PLRVnJFcM7x2r52d4CKz6QsBb1tFgkbrcrb?=
 =?us-ascii?Q?/eMsovOyTEqSrpuWEXsTuWOms0kpkXmniRjvAQeLbGpXDU76GMQoYLrIUJhE?=
 =?us-ascii?Q?PkBj349q3kAVC2VE0ftPrJfOrb57zdUsH1bODQPwtW7ARtZ+Z8qc36WsIm2Z?=
 =?us-ascii?Q?o3Ct4aNeVbcT5IjLT7f2CAZI5V3rQ8HEkqgVTbxWDMXn5oHoKj9KEgiF9GcQ?=
 =?us-ascii?Q?G91fB5pUtW1SDsiHQqUgAm+VW+ay6Im5fo9s8aiORbrQYF6yfla8o9xepnFK?=
 =?us-ascii?Q?rWhlcHf9Bzegrq1t+xiHA40JOoD9pyreZhAyE3pIp3OPCCxmtwFSuZNKlIE6?=
 =?us-ascii?Q?a3ASWrJ/SvFugFx69PV/LLdqf3HxHuyZqqEz59GLbG0Fi3bzhFAhxgyzEovd?=
 =?us-ascii?Q?P9Goijm+bGkHAf7i3svUYxkS1lU1piJPavrctMiLFCwiZnbDg5aaGDPZJ+g4?=
 =?us-ascii?Q?kVuUFNJTKgW8qDLYklLMwVpqZYpPQ0blXbA7hVBH/h87Zxy3oajG0MjT5/Wo?=
 =?us-ascii?Q?R6VdlaFvUe2TNaAFiOxlYUR9yhDTXF688RIrZCf7z/o6Lbc4FcYDift6JnLW?=
 =?us-ascii?Q?3uK50r7Jqi5bw2cQrS8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0084.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0bc9d5-974e-4572-ad43-08da7627017f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2022 14:38:32.6980 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZcLdxPGQ0Nw0n3QvwvSvd2QZ0aGIUIvrsUxuN7xYk0lJFdlKaLTMNBCs3VRcyYIG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6052
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Tim" <Tim.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Roman Li <Roman.Li@amd.com>

> -----Original Message-----
> From: Zhang, Yifan <Yifan1.Zhang@amd.com>
> Sent: Thursday, August 4, 2022 4:49 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Li, Roman <Roman.Li@amd.com>; Huang, Tim <Tim.Huang@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
> Subject: [PATCH] drm/amd/display: change family id name for DCN314
>
> GC version is 11.0.1 rather than 11.0.2
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 4 ++--
>  drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c        | 4 ++--
>  drivers/gpu/drm/amd/display/dc/core/dc.c                | 2 +-
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c           | 2 +-
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c       | 2 +-
>  drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c   | 2 +-
>  drivers/gpu/drm/amd/display/include/dal_asic_id.h       | 2 +-
>  7 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 516739bc0a96..3b4bf131bab1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -660,7 +660,7 @@ static int get_plane_modifiers(struct amdgpu_device
> *adev, unsigned int plane_ty
>                       add_gfx10_1_modifiers(adev, mods, &size,
> &capacity);
>               break;
>       case AMDGPU_FAMILY_GC_11_0_0:
> -     case AMDGPU_FAMILY_GC_11_0_2:
> +     case AMDGPU_FAMILY_GC_11_0_1:
>               add_gfx11_modifiers(adev, mods, &size, &capacity);
>               break;
>       }
> @@ -1408,7 +1408,7 @@ static bool
> dm_plane_format_mod_supported(struct drm_plane *plane,
>               }
>               break;
>       case AMDGPU_FAMILY_GC_11_0_0:
> -     case AMDGPU_FAMILY_GC_11_0_2:
> +     case AMDGPU_FAMILY_GC_11_0_1:
>               switch (AMD_FMT_MOD_GET(TILE, modifier)) {
>               case AMD_FMT_MOD_TILE_GFX11_256K_R_X:
>               case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> index 4c76091fd1f2..f276abb63bcd 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> @@ -337,7 +337,7 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context
> *ctx, struct pp_smu_funcs *p
>           break;
>       }
>
> -     case AMDGPU_FAMILY_GC_11_0_2: {
> +     case AMDGPU_FAMILY_GC_11_0_1: {
>               struct clk_mgr_dcn314 *clk_mgr =3D kzalloc(sizeof(*clk_mgr)=
,
> GFP_KERNEL);
>
>               if (clk_mgr =3D=3D NULL) {
> @@ -397,7 +397,7 @@ void dc_destroy_clk_mgr(struct clk_mgr
> *clk_mgr_base)
>               dcn32_clk_mgr_destroy(clk_mgr);
>               break;
>
> -     case AMDGPU_FAMILY_GC_11_0_2:
> +     case AMDGPU_FAMILY_GC_11_0_1:
>               dcn314_clk_mgr_destroy(clk_mgr);
>               break;
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c
> b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index e42f44fc1c08..5d84adb6ea52 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -4292,7 +4292,7 @@ bool dc_is_dmub_outbox_supported(struct dc
> *dc)
>           !dc->debug.dpia_debug.bits.disable_dpia)
>               return true;
>
> -     if (dc->ctx->asic_id.chip_family =3D=3D AMDGPU_FAMILY_GC_11_0_2
> &&
> +     if (dc->ctx->asic_id.chip_family =3D=3D AMDGPU_FAMILY_GC_11_0_1
> &&
>           !dc->debug.dpia_debug.bits.disable_dpia)
>               return true;
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index 9e51338441d0..66d2ae7aacf5 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -3372,7 +3372,7 @@ bool dc_link_setup_psr(struct dc_link *link,
>               switch(link->ctx->asic_id.chip_family) {
>               case FAMILY_YELLOW_CARP:
>               case AMDGPU_FAMILY_GC_10_3_6:
> -             case AMDGPU_FAMILY_GC_11_0_2:
> +             case AMDGPU_FAMILY_GC_11_0_1:
>                       if(!dc->debug.disable_z10)
>                               psr_context-
> >psr_level.bits.SKIP_CRTC_DISABLE =3D false;
>                       break;
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index ffc0f1c0ea93..7dbab15bfa68 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -169,7 +169,7 @@ enum dce_version resource_parse_asic_id(struct
> hw_asic_id asic_id)
>               if (ASICREV_IS_GC_11_0_2(asic_id.hw_internal_rev))
>                       dc_version =3D DCN_VERSION_3_21;
>               break;
> -     case AMDGPU_FAMILY_GC_11_0_2:
> +     case AMDGPU_FAMILY_GC_11_0_1:
>               dc_version =3D DCN_VERSION_3_14;
>               break;
>       default:
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> index 468a893ff785..aedff18aff56 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> @@ -2153,7 +2153,7 @@ static bool dcn31_resource_construct(
>               pool->base.usb4_dpia_count =3D 4;
>       }
>
> -     if (dc->ctx->asic_id.chip_family =3D=3D AMDGPU_FAMILY_GC_11_0_2)
> +     if (dc->ctx->asic_id.chip_family =3D=3D AMDGPU_FAMILY_GC_11_0_1)
>               pool->base.usb4_dpia_count =3D 4;
>
>       /* Audio, Stream Encoders including HPO and virtual, MPC 3D LUTs */
> diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> index ab06c7fc7452..e054f3494087 100644
> --- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> +++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> @@ -244,7 +244,7 @@ enum {
>  #define ASICREV_IS_GC_10_3_7(eChipRev) ((eChipRev >=3D GC_10_3_7_A0)
> && (eChipRev < GC_10_3_7_UNKNOWN))
>
>  #define AMDGPU_FAMILY_GC_11_0_0 145
> -#define AMDGPU_FAMILY_GC_11_0_2 148
> +#define AMDGPU_FAMILY_GC_11_0_1 148
>  #define GC_11_0_0_A0 0x1
>  #define GC_11_0_2_A0 0x10
>  #define GC_11_UNKNOWN 0xFF
> --
> 2.37.1

