Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6914AE7AD72
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 15:24:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AC5610E2AD;
	Tue,  3 Oct 2023 15:24:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F12E10E2AD
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 15:24:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxsjRdeccFXJ8vh1popACeXcv20ELxxjrPSsfpEotgIvjLlEoq/StJvdSd8hOjqdzDpTJQqg2tWdC7Qj6LIDKa4fjFa61CJiGtr0dvO9OFwU2DYcWKT+aJMTgVCZ2o2THJrA/28qjYG9cAyTMQ49I+v9BytVOeq4/crtWieFG5rVkKPli/1srSq3xOhaiiKxewVBblvO3rRn5MhHbFsDKja51LW8KItXSix6xdqTb/fX8NTd6NPNXc8ZcF43zXn6OuWWubN3kadQo+ptqSjSTZdIjYUDFzdcLcQiIjmqYkPt2rr8QGGzeH6dvb2lXXL+w+P2m3dUSzyyh93askywzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hslC8ueDFViNihkVY7lImqYmK6j2hk8c+PzqAMYahE8=;
 b=L4lZ3oTKF5WscHW6xCy/p6nqdG3UKzKkT5mYGu4ry4wCKLN+N44CVi5BPFfG8Rwfh+RtL8VLko7tS8jhnTW6V6ZLJ9pnFAl3YT5AzD9TxRTIrDPsd9zxP2skSAkwuzYDywFh9R4tCcBfdSWScEiLHNxd0WSmf0S/w5WvP9QXk8HZr/ypBQqIcupLwAyJlH4UK2+Az41nRP0eyU0y9l9KCsuRo9d/ci65ZPG2/4gF9RZuBR8JT9zGvyzmEKrpWeQ/H1CUBvgU8biMlIEyrddp0LFUsi3sXXgjeCtK9NQUmyRhlaIVOEiVJ0bF3I3Vnduqg+QortMI6ciMiBIBK09MIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hslC8ueDFViNihkVY7lImqYmK6j2hk8c+PzqAMYahE8=;
 b=QO7ZBDb57dklsjluypaz6H+ysQwEkdNcie1OiPb9spC1LjW7f1abgP2hFNqLUtS2rshbT5reOlhvYtjvu0390G33a70LId+zTTBeQFAuRxj6j7IqWyRxxKo8w/J46Hqmt/ECSxuhxmVDfUxtDp6/ospUbEJJbwLW2mBa9yzYq1I=
Received: from PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10)
 by CY5PR12MB9053.namprd12.prod.outlook.com (2603:10b6:930:37::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Tue, 3 Oct
 2023 15:23:54 +0000
Received: from PH8PR12MB7279.namprd12.prod.outlook.com
 ([fe80::4a17:b056:be46:6e58]) by PH8PR12MB7279.namprd12.prod.outlook.com
 ([fe80::4a17:b056:be46:6e58%4]) with mapi id 15.20.6838.029; Tue, 3 Oct 2023
 15:23:54 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "LIPSKI, IVAN"
 <IVAN.LIPSKI@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] Revert "drm/amd/display: Enable Replay for static
 screen use cases"
Thread-Topic: [PATCH v2] Revert "drm/amd/display: Enable Replay for static
 screen use cases"
Thread-Index: AQHZ9VihCmnTItEhi0W/ARmiJPwWwLA4LUKOgAACTICAAACuqA==
Date: Tue, 3 Oct 2023 15:23:54 +0000
Message-ID: <PH8PR12MB7279526F77BBC201BA660529F9C4A@PH8PR12MB7279.namprd12.prod.outlook.com>
References: <20231002174754.1596197-1-ivlipski@amd.com>
 <PH8PR12MB7279E1B7634AE630985E4E2EF9C4A@PH8PR12MB7279.namprd12.prod.outlook.com>
 <284d3f39-071c-4451-839e-8840aecfc2a7@amd.com>
In-Reply-To: <284d3f39-071c-4451-839e-8840aecfc2a7@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-03T15:23:53.507Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7279:EE_|CY5PR12MB9053:EE_
x-ms-office365-filtering-correlation-id: d7eddd58-24df-42a9-5e51-08dbc424c189
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qvumLwtC586VDFASqG7houdPyBTJdYeM9TiRD3vgFrrZjCj/FGCWnt1DVXnNjXhlP11iDJxpX58W+rCLJIzdjXu+4gWvscAisGKEkuz1YgChRO1PvKFOb0DlYTtxYFfFmsu6j678qJueqzMQugH52P0O4/YQ3LMqXN7UkRCyPqDfJFBzy+5T8TYSweczZqAB3SS6koZOkTM9qlkWGY90v+jUudsLi9aTqlAs/x5OmtMlw3C9EhnFU8boFq4sQDNq7doD4xQVrs7YBbNi8ZINAAWQAfs9kKCzwxNfL9UCcBtV6pXTb/ZQwi0Auw7F5x9bOpYyU6m1Eq/ySIb3qUK6RyHNYSWZExZWMlKjLwnarRfctJL3njQ1mqDvhh+dJnnQ3r8At7TO8CXPu44XkBwCmGLl5/iqJvmXjNXQQVKXHg+yNWjYVgnFFB8vRWQdPLcnsvQDjjYxsS3lMlRY+kNCifbR3UCyoxBLz5zPH1MjhL6Ox3XQA1lj8G1xR+WsYW36HgKKyBEcGSaSYsEu99SQl2uKSFdfnVx/rDVHL9fqT3vSUwvBBk1auq1hzkWpdQA8h/T+n1kvluMWsydTyAMae8JtN0A1Q0B06bteS5SFQRtfKxbb37VkTZ0/SeCr6Amf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7279.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(316002)(52536014)(2906002)(41300700001)(66446008)(54906003)(64756008)(66476007)(86362001)(4326008)(91956017)(5660300002)(76116006)(110136005)(8936002)(8676002)(66946007)(66556008)(83380400001)(19627405001)(33656002)(9686003)(26005)(478600001)(38100700002)(71200400001)(38070700005)(53546011)(7696005)(55016003)(6506007)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9tnHeUJzCUc9vWNg1PI2wguF2RvyBEhjwxKTAJwgVMWA6lSsnJKcQDy/npXU?=
 =?us-ascii?Q?dt1QRurUFr4yf5XsZYYtfstiNNxQgWqEoHZ9wy2CuNLRyOUCoRXCuSrIUHaw?=
 =?us-ascii?Q?gm6tAwnFZimRwngcU7NSa+4onqz3D1SzJSMs4ekpgAqAaU3nQ96C2pyYukOn?=
 =?us-ascii?Q?dI0B734GzsteX945DGnF2NBPhQ4XIkTuWKOSSa8HRu7uRVaHd5R1jdY2p/7z?=
 =?us-ascii?Q?9F9Q3RaS1iycGxJ42dHkhs2NlxbgRbMFZSeNh2488QHlHMLBqVu4RJQRanQ0?=
 =?us-ascii?Q?ErjOJm1Rv88LL0LylQiUL9u2mGaVVqx2z83l6dbtkGwrVfxpNkThzAFHLOAE?=
 =?us-ascii?Q?HHxxcfZewUU91vo5p2wXnSVT1VIxNXw8vkDtS4Fzig6UBSthcSrU0soWD5/a?=
 =?us-ascii?Q?Jsga87gnSbMBvHWJ7SiuXl6QkmE1x5gBLjWaMfuD+S+IqWsul38cPKPEleDq?=
 =?us-ascii?Q?XGcgxSqG9QXr33wvwU38Hz4mz4x7LgGT9hbXwF6+ygRxAKdHSYRdvp42+Tup?=
 =?us-ascii?Q?g5/K4ulqvefi5mbzYs+dvhrqK2NWyek1VhqCPpbk/ll9Y6MEwC8HYMvlhWXx?=
 =?us-ascii?Q?eig1SsXfnDXH/Leue78ojYsuSH4ipU9Y+H2LqsqkbvL6aJg9rEN+FXHKcjVe?=
 =?us-ascii?Q?Y1gLWkQ7y4xF6zWZjcfkftY6IJ37ZSjkGv829NhkubB4wZSmJQeRofCA0jb+?=
 =?us-ascii?Q?t8WReVm76+aowLd3S1ljphO1e+5uQKHcw0BtXX3WzJlXB3cxILbqWlAfBhMg?=
 =?us-ascii?Q?DPaWUk7w1VJHSS5VmrSMYPj5lBI1+B6LzrnfSyjX0XuC9V7W/8vWMxwe8+uN?=
 =?us-ascii?Q?N+qRVeYaMKOXeeyMSo4Z+zVaI8qG+2u7PoNnfTCE0jdLXeQQmFuS5EDtywqi?=
 =?us-ascii?Q?6HtVTVUCFUeJ+LY96Igt1tliyVXovK/qkZKPy/n3aDYB9wewuxwZSeGhjV89?=
 =?us-ascii?Q?LqV0MAi9Xb6arfoZ/3n19w7Zs37IbCrRxJPMgMbE5lFETqufKBard7Zs1DJv?=
 =?us-ascii?Q?/p9QXZ2vEPh6FFZtNRZ88DN/AaboApbcbnCRcb/B1bfPhJoGcKWeDeJmnBeF?=
 =?us-ascii?Q?y0rz7GS3+zZ5z3+MYXhiX6Yo5tiUgoxGehY1q8G5QvZXGKvIRk5Ozdlg0Tvl?=
 =?us-ascii?Q?v07OSfYggxGYMwCffO2JpVhnldjPKO1TRKewScFAxoemoN5XuNAAGDo8e7Rb?=
 =?us-ascii?Q?6ql26NN3Uu62xkSpDsHZEPiDkvZzMpXOz5/GdOubrq3BrR9adasrtSM2h5mJ?=
 =?us-ascii?Q?TUrl4hHZFx4RVE0QsZVffvYO6xlqeQeVs1N3yUykynWf/mrZnMsUNerZAZpV?=
 =?us-ascii?Q?3OU+kCuzSYh2zED39v6Aen3gfnwDrs9des1tIFJvXuCFXQlulAbILP44CxQs?=
 =?us-ascii?Q?5ASy5r3RpOD54RcAXPlWGl7b+xj3uAS5On/LupgtqC72EIYS3txfwgrbgmHm?=
 =?us-ascii?Q?yEUBjlduXHBFWavyh0k7PNiKORyh4HKVU1RB/7FmOoQ32Si5mqyjIsRKuhLa?=
 =?us-ascii?Q?1iCGrZznOIXjR/De0ihhhJ1mIdFfOa00OPC04iMJu/KLH7mrJmJiFSaBke/P?=
 =?us-ascii?Q?gIF2xv412OhGSJVq3og=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH8PR12MB7279526F77BBC201BA660529F9C4APH8PR12MB7279namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7279.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7eddd58-24df-42a9-5e51-08dbc424c189
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 15:23:54.7368 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gIYGhn9s2k2t5e2YKyrwaQCQQg/23GrxEEsgrNbV3E2dl11n+MOwl6rgAS93UAIB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9053
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
 "Chung, ChiaHsuan \(Tom\)" <ChiaHsuan.Chung@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_PH8PR12MB7279526F77BBC201BA660529F9C4APH8PR12MB7279namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Why not just set replay_feature_enabled =3D true; to false?
________________________________
From: Li, Sun peng (Leo) <Sunpeng.Li@amd.com>
Sent: October 3, 2023 11:20 AM
To: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; LIPSKI, IVAN <IVAN.LIPS=
KI@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza <Hamza.Mah=
fooz@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Deucher, Alexander=
 <Alexander.Deucher@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.c=
om>
Subject: Re: [PATCH v2] Revert "drm/amd/display: Enable Replay for static s=
creen use cases"



On 2023-10-03 11:13, Lakha, Bhawanpreet wrote:
> [AMD Official Use Only - General]
>
>
> Any reason for reverting this instead of looking into
> "amdgpu_dm_setup_replay()" and "replay_feature_enabled" to see why reply
> is being enabled?

It causes a regression in amd_psr. Unless there's a quick fix, we should
revert for now. It sounds like this can break existing support for
PSR/PSR SU.

Acked-by: Leo Li <sunpeng.li@amd.com>

- Leo

>
> Bhawan
> ------------------------------------------------------------------------
> *From:* LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
> *Sent:* October 2, 2023 1:47 PM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza
> <Hamza.Mahfooz@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>;
> Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>;
> Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; LIPSKI, IVAN
> <IVAN.LIPSKI@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
> *Subject:* [PATCH v2] Revert "drm/amd/display: Enable Replay for static
> screen use cases"
> From: Ivan Lipski <ivlipski@amd.com>
>
> This reverts commit a92da5bc33ea99a861f6c422192af6072c145d2d.
>
> V2: Reword commit message
>
> [WHY]
> This commit caused regression in which eDP's with PSR support,
> but no Replay support (Sink support <=3D 0x03), failed enabling PSR
> and all IGT amd_psr tests.
>
> [HOW]
> Reverted the patch.
>
> Signed-off-by: Ivan Lipski <ivlipskI@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 -------------------
>   .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  9 +-------
>   drivers/gpu/drm/amd/include/amd_shared.h      |  2 --
>   3 files changed, 1 insertion(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 32156609fbcf..f69b2e9ecd98 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -66,7 +66,6 @@
>   #include "amdgpu_dm_debugfs.h"
>   #endif
>   #include "amdgpu_dm_psr.h"
> -#include "amdgpu_dm_replay.h"
>
>   #include "ivsrcid/ivsrcid_vislands30.h"
>
> @@ -4423,7 +4422,6 @@ static int amdgpu_dm_initialize_drm_device(struct
> amdgpu_device *adev)
>           enum dc_connection_type new_connection_type =3D dc_connection_n=
one;
>           const struct dc_plane_cap *plane;
>           bool psr_feature_enabled =3D false;
> -       bool replay_feature_enabled =3D false;
>           int max_overlay =3D dm->dc->caps.max_slave_planes;
>
>           dm->display_indexes_num =3D dm->dc->caps.max_streams;
> @@ -4535,21 +4533,6 @@ static int amdgpu_dm_initialize_drm_device(struct
> amdgpu_device *adev)
>                   }
>           }
>
> -       if (!(amdgpu_dc_debug_mask & DC_DISABLE_REPLAY)) {
> -               switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
> -               case IP_VERSION(3, 1, 4):
> -               case IP_VERSION(3, 1, 5):
> -               case IP_VERSION(3, 1, 6):
> -               case IP_VERSION(3, 2, 0):
> -               case IP_VERSION(3, 2, 1):
> -               case IP_VERSION(3, 5, 0):
> -                       replay_feature_enabled =3D true;
> -                       break;
> -               default:
> -                       replay_feature_enabled =3D amdgpu_dc_feature_mask
> & DC_REPLAY_MASK;
> -                       break;
> -               }
> -       }
>           /* loops over all connectors on the board */
>           for (i =3D 0; i < link_cnt; i++) {
>                   struct dc_link *link =3D NULL;
> @@ -4618,12 +4601,6 @@ static int amdgpu_dm_initialize_drm_device(struct
> amdgpu_device *adev)
>
> amdgpu_dm_update_connector_after_detect(aconnector);
>                                   setup_backlight_device(dm, aconnector);
>
> -                               /*
> -                                * Disable psr if replay can be enabled
> -                                */
> -                               if (replay_feature_enabled &&
> amdgpu_dm_setup_replay(link, aconnector))
> -                                       psr_feature_enabled =3D false;
> -
>                                   if (psr_feature_enabled)
>                                           amdgpu_dm_set_psr_caps(link);
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index fb51ec4f8d31..440fc0869a34 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -29,7 +29,6 @@
>   #include "dc.h"
>   #include "amdgpu.h"
>   #include "amdgpu_dm_psr.h"
> -#include "amdgpu_dm_replay.h"
>   #include "amdgpu_dm_crtc.h"
>   #include "amdgpu_dm_plane.h"
>   #include "amdgpu_dm_trace.h"
> @@ -124,12 +123,7 @@ static void vblank_control_worker(struct
> work_struct *work)
>            * fill_dc_dirty_rects().
>            */
>           if (vblank_work->stream && vblank_work->stream->link) {
> -               /*
> -                * Prioritize replay, instead of psr
> -                */
> -               if
> (vblank_work->stream->link->replay_settings.replay_feature_enabled)
> -                       amdgpu_dm_replay_enable(vblank_work->stream, fals=
e);
> -               else if (vblank_work->enable) {
> +               if (vblank_work->enable) {
>                           if
> (vblank_work->stream->link->psr_settings.psr_version <
> DC_PSR_VERSION_SU_1 &&
>
> vblank_work->stream->link->psr_settings.psr_allow_active)
>
> amdgpu_dm_psr_disable(vblank_work->stream);
> @@ -138,7 +132,6 @@ static void vblank_control_worker(struct work_struct
> *work)
>   #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
>
> !amdgpu_dm_crc_window_is_activated(&vblank_work->acrtc->base) &&
>   #endif
> -
> vblank_work->stream->link->panel_config.psr.disallow_replay &&
>
> vblank_work->acrtc->dm_irq_params.allow_psr_entry) {
>                           amdgpu_dm_psr_enable(vblank_work->stream);
>                   }
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h
> b/drivers/gpu/drm/amd/include/amd_shared.h
> index 314fd44ec018..ce75351204bb 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -244,7 +244,6 @@ enum DC_FEATURE_MASK {
>           DC_DISABLE_LTTPR_DP2_0 =3D (1 << 6), //0x40, disabled by defaul=
t
>           DC_PSR_ALLOW_SMU_OPT =3D (1 << 7), //0x80, disabled by default
>           DC_PSR_ALLOW_MULTI_DISP_OPT =3D (1 << 8), //0x100, disabled by
> default
> -       DC_REPLAY_MASK =3D (1 << 9), //0x200, disabled by default for dcn
> < 3.1.4
>   };
>
>   enum DC_DEBUG_MASK {
> @@ -255,7 +254,6 @@ enum DC_DEBUG_MASK {
>           DC_DISABLE_PSR =3D 0x10,
>           DC_FORCE_SUBVP_MCLK_SWITCH =3D 0x20,
>           DC_DISABLE_MPO =3D 0x40,
> -       DC_DISABLE_REPLAY =3D 0x50,
>           DC_ENABLE_DPIA_TRACE =3D 0x80,
>   };
>
> --
> 2.34.1
>

--_000_PH8PR12MB7279526F77BBC201BA660529F9C4APH8PR12MB7279namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Why not just set <font size=3D"2"><span style=3D"font-size:11pt" class=3D"C=
ontentPasted0">replay_feature_enabled =3D true;</span></font> to false?<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Li, Sun peng (Leo) &l=
t;Sunpeng.Li@amd.com&gt;<br>
<b>Sent:</b> October 3, 2023 11:20 AM<br>
<b>To:</b> Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; LIPSKI, IV=
AN &lt;IVAN.LIPSKI@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@l=
ists.freedesktop.org&gt;<br>
<b>Cc:</b> Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Mahfooz, Ham=
za &lt;Hamza.Mahfooz@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.co=
m&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chung, ChiaHsu=
an (Tom) &lt;ChiaHsuan.Chung@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2] Revert &quot;drm/amd/display: Enable Replay =
for static screen use cases&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
On 2023-10-03 11:13, Lakha, Bhawanpreet wrote:<br>
&gt; [AMD Official Use Only - General]<br>
&gt; <br>
&gt; <br>
&gt; Any reason for reverting this instead of looking into <br>
&gt; &quot;amdgpu_dm_setup_replay()&quot; and &quot;replay_feature_enabled&=
quot; to see why reply <br>
&gt; is being enabled?<br>
<br>
It causes a regression in amd_psr. Unless there's a quick fix, we should<br=
>
revert for now. It sounds like this can break existing support for<br>
PSR/PSR SU.<br>
<br>
Acked-by: Leo Li &lt;sunpeng.li@amd.com&gt;<br>
<br>
- Leo<br>
<br>
&gt; <br>
&gt; Bhawan<br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *From:* LIPSKI, IVAN &lt;IVAN.LIPSKI@amd.com&gt;<br>
&gt; *Sent:* October 2, 2023 1:47 PM<br>
&gt; *To:* amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
&gt; *Cc:* Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Mahfooz, Ham=
za <br>
&gt; &lt;Hamza.Mahfooz@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.=
com&gt;; <br>
&gt; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; Deucher, Alexand=
er <br>
&gt; &lt;Alexander.Deucher@amd.com&gt;; Li, Sun peng (Leo) &lt;Sunpeng.Li@a=
md.com&gt;; <br>
&gt; Chung, ChiaHsuan (Tom) &lt;ChiaHsuan.Chung@amd.com&gt;; LIPSKI, IVAN <=
br>
&gt; &lt;IVAN.LIPSKI@amd.com&gt;; LIPSKI, IVAN &lt;IVAN.LIPSKI@amd.com&gt;<=
br>
&gt; *Subject:* [PATCH v2] Revert &quot;drm/amd/display: Enable Replay for =
static <br>
&gt; screen use cases&quot;<br>
&gt; From: Ivan Lipski &lt;ivlipski@amd.com&gt;<br>
&gt; <br>
&gt; This reverts commit a92da5bc33ea99a861f6c422192af6072c145d2d.<br>
&gt; <br>
&gt; V2: Reword commit message<br>
&gt; <br>
&gt; [WHY]<br>
&gt; This commit caused regression in which eDP's with PSR support,<br>
&gt; but no Replay support (Sink support &lt;=3D 0x03), failed enabling PSR=
<br>
&gt; and all IGT amd_psr tests.<br>
&gt; <br>
&gt; [HOW]<br>
&gt; Reverted the patch.<br>
&gt; <br>
&gt; Signed-off-by: Ivan Lipski &lt;ivlipskI@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; &nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 -------=
------------<br>
&gt;&nbsp; &nbsp;.../amd/display/amdgpu_dm/amdgpu_dm_crtc.c&nbsp;&nbsp;&nbs=
p; |&nbsp; 9 +-------<br>
&gt;&nbsp; &nbsp;drivers/gpu/drm/amd/include/amd_shared.h&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; |&nbsp; 2 --<br>
&gt;&nbsp; &nbsp;3 files changed, 1 insertion(+), 33 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c <br>
&gt; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index 32156609fbcf..f69b2e9ecd98 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; @@ -66,7 +66,6 @@<br>
&gt;&nbsp; &nbsp;#include &quot;amdgpu_dm_debugfs.h&quot;<br>
&gt;&nbsp; &nbsp;#endif<br>
&gt;&nbsp; &nbsp;#include &quot;amdgpu_dm_psr.h&quot;<br>
&gt; -#include &quot;amdgpu_dm_replay.h&quot;<br>
&gt; <br>
&gt;&nbsp; &nbsp;#include &quot;ivsrcid/ivsrcid_vislands30.h&quot;<br>
&gt; <br>
&gt; @@ -4423,7 +4422,6 @@ static int amdgpu_dm_initialize_drm_device(struc=
t <br>
&gt; amdgpu_device *adev)<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum dc_connect=
ion_type new_connection_type =3D dc_connection_none;<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dc=
_plane_cap *plane;<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool psr_featur=
e_enabled =3D false;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool replay_feature_enabled =3D =
false;<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int max_overlay=
 =3D dm-&gt;dc-&gt;caps.max_slave_planes;<br>
&gt; <br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm-&gt;display_=
indexes_num =3D dm-&gt;dc-&gt;caps.max_streams;<br>
&gt; @@ -4535,21 +4533,6 @@ static int amdgpu_dm_initialize_drm_device(stru=
ct <br>
&gt; amdgpu_device *adev)<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(amdgpu_dc_debug_mask &amp;=
 DC_DISABLE_REPLAY)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; case IP_VERSION(3, 1, 4):<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; case IP_VERSION(3, 1, 5):<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; case IP_VERSION(3, 1, 6):<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; case IP_VERSION(3, 2, 0):<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; case IP_VERSION(3, 2, 1):<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; case IP_VERSION(3, 5, 0):<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; replay_feat=
ure_enabled =3D true;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; default:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; replay_feat=
ure_enabled =3D amdgpu_dc_feature_mask <br>
&gt; &amp; DC_REPLAY_MASK;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* loops over a=
ll connectors on the board */<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i=
 &lt; link_cnt; i++) {<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_link *link =3D NULL;<br>
&gt; @@ -4618,12 +4601,6 @@ static int amdgpu_dm_initialize_drm_device(stru=
ct <br>
&gt; amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt; amdgpu_dm_update_connector_after_detect(aconnector);<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; setup_backlight_devic=
e(dm, aconnector);<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Disable psr if replay can be e=
nabled<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (replay_feature_enabled &amp;&amp; =
<br>
&gt; amdgpu_dm_setup_replay(link, aconnector))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; psr_feature_enabled =3D false;<br>
&gt; -<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psr_feature_enabl=
ed)<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dm_set_psr_caps(link);<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c <b=
r>
&gt; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c<br>
&gt; index fb51ec4f8d31..440fc0869a34 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c<br>
&gt; @@ -29,7 +29,6 @@<br>
&gt;&nbsp; &nbsp;#include &quot;dc.h&quot;<br>
&gt;&nbsp; &nbsp;#include &quot;amdgpu.h&quot;<br>
&gt;&nbsp; &nbsp;#include &quot;amdgpu_dm_psr.h&quot;<br>
&gt; -#include &quot;amdgpu_dm_replay.h&quot;<br>
&gt;&nbsp; &nbsp;#include &quot;amdgpu_dm_crtc.h&quot;<br>
&gt;&nbsp; &nbsp;#include &quot;amdgpu_dm_plane.h&quot;<br>
&gt;&nbsp; &nbsp;#include &quot;amdgpu_dm_trace.h&quot;<br>
&gt; @@ -124,12 +123,7 @@ static void vblank_control_worker(struct <br>
&gt; work_struct *work)<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * fill_dc=
_dirty_rects().<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vblank_work=
-&gt;stream &amp;&amp; vblank_work-&gt;stream-&gt;link) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /*<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; * Prioritize replay, instead of psr<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if <br>
&gt; (vblank_work-&gt;stream-&gt;link-&gt;replay_settings.replay_feature_en=
abled)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dm_r=
eplay_enable(vblank_work-&gt;stream, false);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; else if (vblank_work-&gt;enable) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (vblank_work-&gt;enable) {<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if <br>
&gt; (vblank_work-&gt;stream-&gt;link-&gt;psr_settings.psr_version &lt; <br=
>
&gt; DC_PSR_VERSION_SU_1 &amp;&amp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt; vblank_work-&gt;stream-&gt;link-&gt;psr_settings.psr_allow_active)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt; amdgpu_dm_psr_disable(vblank_work-&gt;stream);<br>
&gt; @@ -138,7 +132,6 @@ static void vblank_control_worker(struct work_stru=
ct <br>
&gt; *work)<br>
&gt;&nbsp; &nbsp;#ifdef CONFIG_DRM_AMD_SECURE_DISPLAY<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt; !amdgpu_dm_crc_window_is_activated(&amp;vblank_work-&gt;acrtc-&gt;base=
) &amp;&amp;<br>
&gt;&nbsp; &nbsp;#endif<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; <br>
&gt; vblank_work-&gt;stream-&gt;link-&gt;panel_config.psr.disallow_replay &=
amp;&amp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt; vblank_work-&gt;acrtc-&gt;dm_irq_params.allow_psr_entry) {<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; amdgpu_dm_psr_enable(vblank_work-&gt;stream);<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/include/amd_shared.h <br>
&gt; b/drivers/gpu/drm/amd/include/amd_shared.h<br>
&gt; index 314fd44ec018..ce75351204bb 100644<br>
&gt; --- a/drivers/gpu/drm/amd/include/amd_shared.h<br>
&gt; +++ b/drivers/gpu/drm/amd/include/amd_shared.h<br>
&gt; @@ -244,7 +244,6 @@ enum DC_FEATURE_MASK {<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_DISABLE_LTTP=
R_DP2_0 =3D (1 &lt;&lt; 6), //0x40, disabled by default<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_PSR_ALLOW_SM=
U_OPT =3D (1 &lt;&lt; 7), //0x80, disabled by default<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_PSR_ALLOW_MU=
LTI_DISP_OPT =3D (1 &lt;&lt; 8), //0x100, disabled by <br>
&gt; default<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_REPLAY_MASK =3D (1 &lt;&lt; 9=
), //0x200, disabled by default for dcn <br>
&gt; &lt; 3.1.4<br>
&gt;&nbsp; &nbsp;};<br>
&gt; <br>
&gt;&nbsp; &nbsp;enum DC_DEBUG_MASK {<br>
&gt; @@ -255,7 +254,6 @@ enum DC_DEBUG_MASK {<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_DISABLE_PSR =
=3D 0x10,<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_FORCE_SUBVP_=
MCLK_SWITCH =3D 0x20,<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_DISABLE_MPO =
=3D 0x40,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_DISABLE_REPLAY =3D 0x50,<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_ENABLE_DPIA_=
TRACE =3D 0x80,<br>
&gt;&nbsp; &nbsp;};<br>
&gt; <br>
&gt; -- <br>
&gt; 2.34.1<br>
&gt; <br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_PH8PR12MB7279526F77BBC201BA660529F9C4APH8PR12MB7279namp_--
