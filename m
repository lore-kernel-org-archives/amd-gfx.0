Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F30C4706F
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 06:12:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3FC910E39A;
	Thu,  4 Jan 2024 06:12:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8163F10E39A
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 06:12:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwTSqghTOIA3AvbkrAOVS6xic54hPc8CcPqHhurNi2u+NkRda9qiV1u2bkTfDMisDdBRLO0ugxVSinbZ096B/1lc1WAKhOYNtf08BL7TMjpgL6Dj1efRqyFCpBNmpCHsXNhJPZzW17c0pLZGHZcUSLkQ39oTOumOwbScK48eHmj8QC2QvlapSiGVv30H7xK/nhJLw4dCllAQ0hfJg9a/U4suPumRfXpda0QObQNXksm5f9U8WgFaFWXzPoMTzPD+Qyv6gQbQnuie0Pqnu8IA51ZSbn0/SfnrzzV8hm2NojwthuHRWdIAVzPU8TBQiB9IXDL0KDu6Mgfz+NJ72MKxwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzyfNJb0PzgPVyiaU5IlhNAJKu09CoPRq2qT062pXMk=;
 b=MUVyq3ZXFT+uTsdfqJ0KVqIVnNe+l1JjQnYZzJifQyA31OaukCrzijQoK0A5i9P0WEAB7W4uhAYUkdGt21qsx2wQfl5/61X2P6DWZAcHD6s2r0ijM3rhoWJtNArzSSktx+qAjzaN2EjOK6YAWbUBHNIE/nnGz4pum64DG1m7TCIuKKZg1uy4LO9rnOcaPOMaePWSOEGOZhIdgn2giRqol7C6wBHz2T80B4oaUt+jA0IF2Qd3/bQdD6uHFnHaIm3pTmraTbNgJl0B7nS1IkWziAKu2F1orMUAEJWg5xtJyc+yUZSWAbtAuKLRIl23BHCzQHRj/OKamv7dX3W5HyqKzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzyfNJb0PzgPVyiaU5IlhNAJKu09CoPRq2qT062pXMk=;
 b=4eKBBVnnz2ydKdgXjtFb5aHiDYC9aZsfFjSF2KXeWMYReZVxrtteINCtStkJ6cVE6PThn5YApx+uCAI9hwIje8RYqOJ+GowcLpCvA2I/cwwvSY3qA4YPaItORHwxmCPM5TuNgN3ga8wD9OqfJ2Rt4t3wSCzgIcNpTJ9dWwKfAwo=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by PH0PR12MB7078.namprd12.prod.outlook.com (2603:10b6:510:21d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 06:12:37 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5866:efa0:7f40:cd66]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5866:efa0:7f40:cd66%3]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 06:12:37 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Drop unnecessary sentences about CE and
 deferred error.
Thread-Topic: [PATCH] drm/amdgpu: Drop unnecessary sentences about CE and
 deferred error.
Thread-Index: AQHaPs51XnP5ub9zxUiFXwluuSd6TbDJLFTw
Date: Thu, 4 Jan 2024 06:12:37 +0000
Message-ID: <PH7PR12MB879674103F5F50A005F7153FB067A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240104052509.3771116-1-candice.li@amd.com>
In-Reply-To: <20240104052509.3771116-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ddb9b541-f9cc-496a-9b58-325da8156f25;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-04T06:12:18Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|PH0PR12MB7078:EE_
x-ms-office365-filtering-correlation-id: fabb03e2-752a-4fbf-aa96-08dc0cec2686
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vRlEfAXyKH/LApWMpxbgRKkeN3Hht5SDtChZHx297X2lOgQP9ATM/wYbXlo4301Jh0NNEw9iPUZfJXS8YGQhchXtwKbg+xV9bPTb6ET6DrDNCJyQ2/uY7s58TYNN1SsjljvypWRyaSWwWLDdI7+GEV3ckwlrX7018PEoTS3Av9v2+y6felNouTWM+i8w1PamwOG1wG2/jLDXF03lxnXEkvF5bQPEu4pmOJwDpklOlja8osA0/08XfmtTPYbwELJZPRuAA0AwzFBgA565QDOCLcZXdHlrlMmBM1Ji1ZtyCYHV1Ve1Fd4p1ddjxV8SRdCrflrPijBpqYFEDbWCkgR7w+3Abuga8tlDNuIGxeFR3qECJ3HJRtC32R5BXwl+D4dkTRbfUvfbV6R9F6XQ7MMrx8026ZWCI3JjuR1mzLBLdc4QOuiJ885/hnfzKgau61UvAwKN4bvyPBLNkvqcjAB/jMyZqH24NAM8CTqmDBmXVoT5DaSUTKk0k3zo7mpa3TL/j/LlBguPrZsPj2uz6ucj9Rl9dAZjTIKBlG6Ll2iiirTaB24e47T6QeSz9bqEHIUInGxaSYd0VdT10uUjrP94q/RSxUfPHnuDATeHpWSWnobWenknqrwv8d5Sg1rMKjmN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6506007)(9686003)(7696005)(86362001)(55016003)(71200400001)(38070700009)(53546011)(478600001)(26005)(64756008)(66946007)(83380400001)(76116006)(66446008)(110136005)(66476007)(66556008)(316002)(4326008)(52536014)(8936002)(8676002)(33656002)(2906002)(38100700002)(41300700001)(5660300002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fBKn/J7o7zUF11nCoJbvuFyd+ViarCssclrWb7JKltTc1RVh+ClB5VjgO/NX?=
 =?us-ascii?Q?RaYibKzQmgvNZr3Q02DTxMKGSkyqACs9fvehVG5sUnJtrpiGRQXiYk12Jd2i?=
 =?us-ascii?Q?G7JqCeC+m4UUqkUrtbRuygObUyfa85DVzzNWLbpdGEn7Ln8rzUTL1C4dp/EG?=
 =?us-ascii?Q?ulz3+UazM1hmAN7nuQ5aAYLNTqXG1LA0MI3GIMoYYJEZqJYJv4g6mKh+QRdb?=
 =?us-ascii?Q?Q5Umy79AAUlnJqbkeyUCULTlSLW91zONdCy1Mkf9eHRzzjPV6rKH8vxzyZBt?=
 =?us-ascii?Q?XzDy10DmLl0ExB94eKy4P1buoKGZ1XrRvN1TW/oykJPVU1ClXTTK85J6Ro1t?=
 =?us-ascii?Q?n3jIePal6WnP8tztV010aJ39DQ+Ctr1oXvYxnXwz6ZU3y1oL4FVW0qriU++9?=
 =?us-ascii?Q?VBLz8VvFnLAjKpEFOyWNw/vGYPeBDnxTked0NMkaLmbX9kep7hvUF4x3d9/W?=
 =?us-ascii?Q?xDSq5+TWwcjbUKeyI+p0HDV0WYI4PcBTB94ZE8d/s5H1rpuY083+5HqBNRlz?=
 =?us-ascii?Q?8SWS0Gpj5ryzzjIVhnjObnIMpeQsnppwyAsE3nVWQ4COJzFR778WzSpDOl18?=
 =?us-ascii?Q?Vw8RVvm8vo4zi0NyvKyKTLy2oa1ze28dwfLYOop4cWasHRxIOQ4rrqEcb5A/?=
 =?us-ascii?Q?W5LTghUhOxBKUGiB3JQTuKD3v6NBv+x6rkIJkwPfd5b6Zap9foiuJwCJu8sX?=
 =?us-ascii?Q?qefMTpgfDphr5SBfie1SwxVLZNGwL8g63cIGEH3XR9T/USjPRhzhmZxSQPQL?=
 =?us-ascii?Q?u9k0+rcxHuUur0hLTQnpsngFYNecVgc06xh8U7Ch+3l4bFxVGDw+z2AGZEQV?=
 =?us-ascii?Q?Nt2sFI708WrqxZpMYSsobLwg/bi1mr499+OEze70b1URg12DYejyJL9jbugT?=
 =?us-ascii?Q?kRYNGoSmW61ApxFp7zCL3K3eKP3WbYmcxsSQ7/9N6XuHGAM4MrBpLmokSbXH?=
 =?us-ascii?Q?UgL8bUAxMd7X9Ds0Q/Nu6ECiwv2AA/LsX2OsQdYAzhWA9ZbqPKHC4SZ5JyRN?=
 =?us-ascii?Q?5rWG8EGJjIm7TVDazm3X03sXqdOmKFhHK9t8ZOTFESMB2CpdikQnHPvFZN3j?=
 =?us-ascii?Q?hMDIPdOX/3wZkcZEMDTRaFCW3i+NllQvG/la/n9CYNuuuKwvQpLPCTvD2xph?=
 =?us-ascii?Q?6GNdAq6DWKsaLeGIkd0om3O649vQRWk5zjGZz+979k9FO0fvO3U0QatjUD1f?=
 =?us-ascii?Q?EcM9xKiFU8VPObZIEHTxXRaXjK052XA040XxUgKKfifqjimzfgtUXPVEzIIr?=
 =?us-ascii?Q?Hd6ARrnXdwnPFkaaY1fQG0hA6Yxu5xkUq0godNieBUmc02Ote9QYRCL7rxmX?=
 =?us-ascii?Q?6+X9WyvnZ/GUVP0TpcU1Bvlv0XFHpiUo5S2zfTMNO50a7A+oYG+xrw/YpXsN?=
 =?us-ascii?Q?fh/jsk5Yhocs2FlpRJan/Go6XHGW6TMJGIXIVGgaIxSjeSGKrdAI9WQaGmk3?=
 =?us-ascii?Q?7DFr2TsyiJuic7+xOXGtVzeG0GMmDfXQ9bhgTO0x7BjWEwvx8p1tDAv8+JIJ?=
 =?us-ascii?Q?WpasCeFYGVJZixYc959T+ylRf/NLo6e4prFI+iR2WglHTYDT1eOOGu5NO9UB?=
 =?us-ascii?Q?Nt31YEsIMOPGyEtrR/M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fabb03e2-752a-4fbf-aa96-08dc0cec2686
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 06:12:37.7701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JtZUhcJ8ifGeWniXgf6iUAkQTDU9oyrTlEp+DaAShHazTkjTAPsEdK5SwLk9858H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7078
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candic=
e Li
> Sent: Thursday, January 4, 2024 1:25 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Li, Candice <Candice.Li@amd.com>
> Subject: [PATCH] drm/amdgpu: Drop unnecessary sentences about CE and
> deferred error.
>
> Remove "no user action is needed" for correctable and deferred error to a=
void
> confusion.
>
> Signed-off-by: Candice Li <candice.li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 14 +++++---------
> drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c  |  3 +--
> drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c  |  3 +--
>  drivers/gpu/drm/amd/amdgpu/umc_v6_7.c   |  2 +-
>  4 files changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index b21eadd7c975df..caf00df669bf7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1069,8 +1069,7 @@ static void amdgpu_ras_error_print_error_data(struc=
t
> amdgpu_device *adev,
>                       mcm_info =3D &err_info->mcm_info;
>                       if (err_info->ce_count) {
>                               dev_info(adev->dev, "socket: %d, die: %d, "
> -                                      "%lld new correctable hardware err=
ors
> detected in %s block, "
> -                                      "no user action is needed\n",
> +                                      "%lld new correctable hardware err=
ors
> detected in %s block\n",
>                                        mcm_info->socket_id,
>                                        mcm_info->die_id,
>                                        err_info->ce_count,
> @@ -1082,8 +1081,7 @@ static void amdgpu_ras_error_print_error_data(struc=
t
> amdgpu_device *adev,
>                       err_info =3D &err_node->err_info;
>                       mcm_info =3D &err_info->mcm_info;
>                       dev_info(adev->dev, "socket: %d, die: %d, "
> -                              "%lld correctable hardware errors detected=
 in
> total in %s block, "
> -                              "no user action is needed\n",
> +                              "%lld correctable hardware errors detected=
 in
> total in %s
> +block\n",
>                                mcm_info->socket_id, mcm_info->die_id,
> err_info->ce_count, blk_name);
>               }
>               break;
> @@ -1139,16 +1137,14 @@ static void
> amdgpu_ras_error_generate_report(struct amdgpu_device *adev,
>                          adev->smuio.funcs->get_die_id) {
>                       dev_info(adev->dev, "socket: %d, die: %d "
>                                "%ld correctable hardware errors "
> -                              "detected in %s block, no user "
> -                              "action is needed.\n",
> +                              "detected in %s block\n",
>                                adev->smuio.funcs->get_socket_id(adev),
>                                adev->smuio.funcs->get_die_id(adev),
>                                ras_mgr->err_data.ce_count,
>                                blk_name);
>               } else {
>                       dev_info(adev->dev, "%ld correctable hardware error=
s "
> -                              "detected in %s block, no user "
> -                              "action is needed.\n",
> +                              "detected in %s block\n",
>                                ras_mgr->err_data.ce_count,
>                                blk_name);
>               }
> @@ -1978,7 +1974,7 @@ static void
> amdgpu_ras_interrupt_poison_creation_handler(struct ras_manager *obj
>                               struct amdgpu_iv_entry *entry)
>  {
>       dev_info(obj->adev->dev,
> -             "Poison is created, no user action is needed.\n");
> +             "Poison is created\n");
>  }
>
>  static void amdgpu_ras_interrupt_umc_handler(struct ras_manager *obj, di=
ff --
> git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> index 6d24c84924cb5d..19986ff6a48d7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> @@ -401,8 +401,7 @@ static void
> nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
>
>                       if (err_data.ce_count)
>                               dev_info(adev->dev, "%ld correctable hardwa=
re
> "
> -                                             "errors detected in %s bloc=
k, "
> -                                             "no user action is needed.\=
n",
> +                                             "errors detected in %s
> block\n",
>                                               obj->err_data.ce_count,
>                                               get_ras_block_str(adev-
> >nbio.ras_if));
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> index 25a3da83e0fb97..e90f3378080345 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> @@ -597,8 +597,7 @@ static void
> nbio_v7_9_handle_ras_controller_intr_no_bifring(struct amdgpu_device
>
>                       if (err_data.ce_count)
>                               dev_info(adev->dev, "%ld correctable hardwa=
re
> "
> -                                             "errors detected in %s bloc=
k, "
> -                                             "no user action is needed.\=
n",
> +                                             "errors detected in %s
> block\n",
>                                               obj->err_data.ce_count,
>                                               get_ras_block_str(adev-
> >nbio.ras_if));
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> index 530549314ce46c..a3ee3c4c650feb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> @@ -64,7 +64,7 @@ static void umc_v6_7_query_error_status_helper(struct
> amdgpu_device *adev,
>       uint64_t reg_value;
>
>       if (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) =3D=3D 1)
> -             dev_info(adev->dev, "Deferred error, no user action is
> needed.\n");
> +             dev_info(adev->dev, "Deferred error\n");
>
>       if (mc_umc_status)
>               dev_info(adev->dev, "MCA STATUS 0x%llx, umc_reg_offset
> 0x%x\n", mc_umc_status, umc_reg_offset);
> --
> 2.25.1

