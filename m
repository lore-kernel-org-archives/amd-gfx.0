Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1ECBC7EE2E
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 00:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 093A210E2DE;
	Tue, 13 Jun 2023 00:54:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 332D210E2DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 00:54:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxEiD17kdwygWowI4kC2sDoJk3n8lWdSZbMmkhnndY2UmfpTPbGL4dlaZwkidLa3TUWPRgkl9/bw3wlOOEqtCPeukqM5lJ5HE54KC4M8xKF2bHBsdchC23M4XIF+K6vlrALLDhN5wQjSDca4CoqUECLShM78DN8dcScqecIOTEj07aqs7cu3OhX/T+siDMhOcRHQJaNmZeg5Ipu5QEPy26Po/Sj5krsbavMxBYYvAG2gwHlRQnd+C0f9jH3yeWSxzRE35UJ1c3vaJSewQQrXLBMY8D/o528TD9VqNsn99GUw4FVU0X5jGsCz511VQjZHuivm+zsFWFUH9vJBKtC1sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DP75cnRTsWpPsrigqosMHu/oeLqhzcoZHncbXuA01s8=;
 b=fvKjBc2utENFhwTljY4q0NyVQITuyEI6rmF2hiEuDBLaxz1oKX4nI2pepsE5NTl0rtMdx68FbD7C1gdIR4BVkgisyX4NnbrX3aIpCpT07CwklPZHuWzF432K4iWd7ggo3IsdzGmY3U9OfxT5LjmYaiVimeLct1dmlwgOMWggFtdscL0UQ3tiBpJzqjLPCMIZCn7ukjXqn6hiyu9ViIC7wwf+MhL48wauYN9uxfmXDCwhTgaR0K6gI89qghJ+3mSO9CjkaPCYXZTSC832bnKivw6MQ+y0igKY1TdQvJPkCAglZrsAMdqVk7A+Nx5/59ElJjg7bmkS0ia9BkCYaoJg3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DP75cnRTsWpPsrigqosMHu/oeLqhzcoZHncbXuA01s8=;
 b=SbwqQSsnQua5qPoq6qbgzf7C3eRhxf4xsxtBkr/OZKEllJa1T7UuYOS7SkhfP4o9/GjEGfi3pzGDyy3OS0i5gRWHdktWaW2GnZU+lp1yrX3b17j5yDrAsdq4G0cr6cbeY58UGw9ZrBpe7leABjOZ3no1NZDTq1eQIrusb5FZvjo=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 PH7PR12MB6442.namprd12.prod.outlook.com (2603:10b6:510:1fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 00:54:15 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::6d3a:17b5:6546:e9b4]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::6d3a:17b5:6546:e9b4%4]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 00:54:13 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: don't free stolen console memory during
 suspend
Thread-Topic: [PATCH] drm/amd/display: don't free stolen console memory during
 suspend
Thread-Index: AQHZnT30Rfcvkmx2qEOc4962cX70nK+H6IoA
Date: Tue, 13 Jun 2023 00:54:13 +0000
Message-ID: <DM5PR12MB246924E54178C61B586009DAF155A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230612145512.752279-1-alexander.deucher@amd.com>
In-Reply-To: <20230612145512.752279-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=fe8ab19d-5b70-49ba-a91b-58586941ec39;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-13T00:53:57Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|PH7PR12MB6442:EE_
x-ms-office365-filtering-correlation-id: d3bf8083-edf2-46d2-1928-08db6ba8b50d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9SGyT90d+i5WWUau6EMweMPY3AO9tloOjyF6/Wfjr0A0dNL/1j62mroPFJrnFHrkR0Kafg+zfnXA+cQhPZqCcCx5XaDQ30LAa0xnYcCDf3iU8rLhFbBxN/6o7kBQxao8rHkPD7HyiepKbyFYdLeJDDtj42ky4VltaMc+Ajq92gtDBsMNJqFFcPZpmuKQGq5tzLQqifI7T6eXtwp7jTNiOMYFceQ54REqeWfJFavJfKQ5KuRmuuBJWrN6LthwlGCI2jkVoRuyPc47mo3gL3gt0hP2CaTzNZieJIb6pCx7o8f/x43jnAghl6u9w13+9KBxouYHenNZ+Drr2tx1fU0iy+N0I+4eQL2CoCgNtvLVGY0LXkkpgiqneiyY+JgN7t2ou8jerTv5ujYLa/8Df0NNas1dB8dNA4ZYjxokg9vPqcJ1hwrENaHGtD+kzZCRiPONz0x/tHo+NO0dxa+UPk63OSY+5HfvxWnkEcM97+8xLu/xfAGvg/bdo9llJVZOZ+vw6uy/6FlP6oUW4oJf+eKHNCjXCC//+yfXHE9vGjf38PVhgetWs9MWJXU+IfyMzAeh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199021)(122000001)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(38100700002)(41300700001)(33656002)(7696005)(71200400001)(478600001)(186003)(83380400001)(2906002)(316002)(15650500001)(38070700005)(8676002)(8936002)(55016003)(9686003)(53546011)(4326008)(6506007)(26005)(86362001)(52536014)(966005)(110136005)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ptKxAA+K/Qxd12hSldmzlbPBkbrEh+2cekXI8IUwJbDfDqEYK7kciGu76VFx?=
 =?us-ascii?Q?Db4iNMoWuk3404sZifJxOVoyIghIS2ycJktyeQTmGyrXwwaRdAvATkvrvAfa?=
 =?us-ascii?Q?SPRh9IV0bejNVKYctJ7V2larQCTD7mw3eFxUrb27nUxCNcJpnRIYLHza1q76?=
 =?us-ascii?Q?7rmSzmUVOe3HMNnGZ7Ea3EmOIsPKlrx5oOpILpsByDpp9l6DMrBRQwb2qoGn?=
 =?us-ascii?Q?Pbf1sWFOz3R1w2+xWbe3gSWzTPN7ZjP2D6HhcQ67LrgsF6H43dt5dKKIvnfZ?=
 =?us-ascii?Q?Qh3mvQ2lI+D7NXRdhp6FoABx7kNq4AAAnoPY8ZpBXh6pFCf2PbjyhuOtLwwV?=
 =?us-ascii?Q?SYdlg1V38Sjrwhy2ncdHarS4ua2xLpf8PKmVRB8PdAPqj9kU8ubRnbW/4KqX?=
 =?us-ascii?Q?bsvQLcyA3+wNRStV9FeF/dK+Xvam1GGeU2IiZve17uHha8OIGIUmQxoW27x6?=
 =?us-ascii?Q?aRHP8neH84dEJNDZgiH6ULmW6eyHlKgO3gTctEfDLnqb2ZBeP0K9I//UYevG?=
 =?us-ascii?Q?/qSr2YXSDuMw9ewRESkGS+qi2nIMSECUIrJwfNu20dJJv1WEa8YUr3B0SM84?=
 =?us-ascii?Q?YYOOqL0TM/eCH58PYYNwysADEmZ/25tY9fc+pIZeZtMOhxN0m6oH833NmZ+d?=
 =?us-ascii?Q?4EZqTVi92JFypoyV2gBXfsb10+YFm1FaZp48EaB7JCraEZZwfXMu2w3spa8Q?=
 =?us-ascii?Q?w2QKqNRC8lzaDe7mnqiTU2PO6wF6Lq74ZOb5fG8vuVEm3Ag2LZrpy3ldymAp?=
 =?us-ascii?Q?QfaJecDO9a/WwpYxcpXqR/8h3rXk/4sRmzyC4S2u9at4RiNnky0XEg2+5OUJ?=
 =?us-ascii?Q?s2OX9frT5YCA6kLM9+qGRIR9sot6bQthxdSzuYelcZshvs+utSVVipczuns4?=
 =?us-ascii?Q?kVouxyNvrZZ2q5EeiIOk3MibcO8jUV9g1E7qdumZ5DEgV9KIfguM9ozP5E2F?=
 =?us-ascii?Q?ehZp2YDp0z+pUQVUMvaP19THvIvf3nZdgBmvE4/wv+zz8WtuDnM+zBNEWgjA?=
 =?us-ascii?Q?1+5iE7tqlTyXPNxlEA6kW4hrHa9HjeMlJGLj/37M9f0G1J/DgwA9MrM9yjqc?=
 =?us-ascii?Q?NX6ps8PLZmWmr3hlmXLKWW9I8FRiyqeeR/GfRJ6OV7cT4vxIohPJbCLpIVGt?=
 =?us-ascii?Q?MF3Knn0Lf3VrZHRi2dqxslOHtLHuMzdF0iE9ubXhsm6/5hvxH9PNfF0wrc70?=
 =?us-ascii?Q?zz8zsS+T6/WFbU6jqlULuHfzttxPFRD/O+g+eYinu1PjNJZtqAYx5L1/O7ck?=
 =?us-ascii?Q?4F5sYvJkXRPq+Mm5F/YYtC+K/xX0h0khjwyZhw0iOgxptnQxmjnjB3BXIPyh?=
 =?us-ascii?Q?RzKWzGvPFTTesSnHbgIoFYR/ceLg+v8HFpy/glR3W1Lq0Db5FPs80BC2R6UB?=
 =?us-ascii?Q?gMKwA9bgRjAAmtiL9l6ZT22pOqbo4GArZDglwQymewHhvobhSP7QJYm/QyLW?=
 =?us-ascii?Q?Z7kd1hvUHogo4gKXsARedFe9cVOnlkwwGelrb0nLcodpEG0wb2FbxSvvFORk?=
 =?us-ascii?Q?zcN2XeN9txqydUPkDJzReveE3Rrh1Sy6Lm0bluyoJMFQQfLYLHs49xpXArPn?=
 =?us-ascii?Q?8yXr0gF+5t9ATv/b+YE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3bf8083-edf2-46d2-1928-08db6ba8b50d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 00:54:13.9135 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t4oRGVD2FrLJOe3BmVEyDjeYGaV41AbyO4kU0kDOdtNbTkYOoZaeH4uvkGMe8mEWp05HgQI9/4CLA13v/hEt/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6442
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Monday, June 12, 2023 10:55 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amd/display: don't free stolen console memory during
> suspend
>
> Don't free the memory if we are hitting this as part of suspend.
> This way we don't free any memory during suspend; see
> amdgpu_bo_free_kernel().  The memory will be freed in the first non-
> suspend modeset or when the driver is torn down.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2568
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15
> +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 0454e94d5680..fc0dd31785cb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8963,10 +8963,17 @@ static void
> amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>
>       drm_atomic_helper_cleanup_planes(dev, state);
>
> -     /* return the stolen vga memory back to VRAM */
> -     if (!adev->mman.keep_stolen_vga_memory)
> -             amdgpu_bo_free_kernel(&adev->mman.stolen_vga_memory,
> NULL, NULL);
> -     amdgpu_bo_free_kernel(&adev->mman.stolen_extended_memory,
> NULL, NULL);
> +     /* Don't free the memory if we are hitting this as part of suspend.
> +      * This way we don't free any memory during suspend; see
> +      * amdgpu_bo_free_kernel().  The memory will be freed in the first
> +      * non-suspend modeset or when the driver is torn down.
> +      */
> +     if (!adev->in_suspend) {
> +             /* return the stolen vga memory back to VRAM */
> +             if (!adev->mman.keep_stolen_vga_memory)
> +                     amdgpu_bo_free_kernel(&adev-
> >mman.stolen_vga_memory, NULL, NULL);
> +             amdgpu_bo_free_kernel(&adev-
> >mman.stolen_extended_memory, NULL, NULL);
> +     }
>
>       /*
>        * Finally, drop a runtime PM reference for each newly disabled CRT=
C,
> --
> 2.40.1

