Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12DCC7618E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 06:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4361310E8AA;
	Wed, 26 Apr 2023 06:07:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8173D10E8AA
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 06:07:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMhf80/Ont+z1dIoEb+X7wr7gs279vbBhlRfxAJEOvoVb5lteR6GZ06/qUp2SQhbGRHZ2DHfbRGYnKj9uK7ovbTvKijPkmvUVQcCMZY4Kejl+XFUMby9OZcAE89xPC8XewqLduGWHDVCw4N7J9yghc1HGiEZmY9dXG6Q0DzsY1m90omDIQCrp7s+6njysRzl8koUCCxb04435B9uenajpIABed3Uqst3Kyqao4q7TztmOWDO1PBUkmw2076eeEXCHeiOULdpZJb+FloXMq//x7yet1MsMhAcuK0Ozo6tONGjISxI4xrtwLiSgmx/5OUek2VtrXbjtuELV09nMEi/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OH/0p6vPo5JXcPx144c3zVryh7c2hW7dm9MjI2L4qec=;
 b=DnE+/Ju80/M++5JaKeyZ1QGCpH+izP7iM9ODyJJg8w6w07nB4b2IgkPeyDtNt6kvJOHAzGYp3b0T61b5kKUIgNaqQbJ4hyFkzolbMlZLosGtWRMma9pGggHvrGPPuTmSGCP217ypqAsU+DufiW2+vL0EzbKES/NpM92L2UyFHlbDLSpXZYgLE1SekMy5IIr9jKkbefnrUuLY7sGrHGZ0eneXSE9b9cMWKv2qBf1U1b1t4VX1MQtqpancMgLlHrFeJkfNABJpjKDn7SrHhs4yOiO+MO7L3hrxVWMWe/UhbCdy+zr0yTOXCzPM7pyy06aACXCuenoofF3nCmgfsND89w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OH/0p6vPo5JXcPx144c3zVryh7c2hW7dm9MjI2L4qec=;
 b=Cboj+05xdzJGy4ccSRViQ6qrJmdSWK1CsUwWJ+L84JcDofn1uCh4WEBfv8GIrAfMjnsb6PORWpcyP4gcHjSzhYWVGgfYxcS7keoCJe2MTBrzvucT9XlTLt4qtWZKWjWlPNtw+iojDILa0k3P4i+ZhsjaBnImWAq5zjaWAtleNeA=
Received: from PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 by PH7PR12MB5687.namprd12.prod.outlook.com (2603:10b6:510:13e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.31; Wed, 26 Apr
 2023 06:07:03 +0000
Received: from PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::f381:5d55:55af:cff0]) by PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::f381:5d55:55af:cff0%7]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 06:07:03 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: check correct allocated mqd_backup object
 after alloc
Thread-Topic: [PATCH] drm/amdgpu: check correct allocated mqd_backup object
 after alloc
Thread-Index: AQHZd++fGNcSSfpHQ0O0x202LrVQ1q89GFxQ
Date: Wed, 26 Apr 2023 06:07:03 +0000
Message-ID: <PH0PR12MB540461437A5959511B010CC1F6659@PH0PR12MB5404.namprd12.prod.outlook.com>
References: <20230426033121.154649-1-guchun.chen@amd.com>
In-Reply-To: <20230426033121.154649-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f782fbe6-bdfd-42c4-8c1c-2c13f29bef7e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-26T05:58:26Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5404:EE_|PH7PR12MB5687:EE_
x-ms-office365-filtering-correlation-id: d71a86ba-5054-4035-ada5-08db461c74e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N9uh3ElHU+Hv78wRe0uqtdw0N0xFrPfKwtQs1LgaJYYckxtq99zFlCB+iREAYjGVbKy6TqiYJu1gbohNmjNwnUlqo5g0t2quQ5e60yFkbBrW+fEBK+OkE9TFIwI3JM/nb4n7fpRkVTxeEZsXtRRJvRN6+Y/tupEM7YEN96RRnLtGG0glLKDJmb7BeXn5dWIefvvCgrlUHibINfuwRci/f5YlMBllqn717RuJx1g6FrrhNQUSfSm9o0TpMiL679eZUwip8iF8jpBowF8Q99K2kdzkSLZdCwjWsoyBl17QtttwiY+YuDU702GTUhYt5s3lt9K1Bn43Y83+PBc/tKj7NaFNmQgclDL/4qCoSCZs1HCRDBTeSJD5F+pGitRj3yj//G4TvW6QsKnYNQ5Mbe2ZArjW30RNrv/PGr4LQH99M+lCXru4TOtVYWzWyxyt6lvDBE+dawWAgwiGpfFV5+8x6zrQvGv6mCXqZLGRGg9XCeMo6660XsTsmF/bIN1igaYsiHCxSPNgnZHW429yHyqlJWw7a2RJ/Pd4F1xeXawfvUjqVX9fbAzfDwLvIB6SHA9XEY0DZXFLUMtUwrdl0szWYVSYHXSSnPutCs93QhC/1Cg5ocT+cfZSSwZm8QK8bSNr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5404.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(451199021)(71200400001)(33656002)(110136005)(64756008)(6636002)(66446008)(66556008)(66476007)(66946007)(186003)(2906002)(316002)(7696005)(53546011)(52536014)(41300700001)(5660300002)(478600001)(55016003)(122000001)(8676002)(8936002)(86362001)(83380400001)(9686003)(6506007)(76116006)(26005)(38070700005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8NL3MTtdQ2m1+fooaB/C23Cr9l3xfN+7l2PQALDrm2ShQpBipz/KpB77lIgZ?=
 =?us-ascii?Q?85onhc6F98q+YeaRv+yWV8u6Bzo2qpeWcKbWU+c5tn8eANgzWW7GeK/0GCFJ?=
 =?us-ascii?Q?BsHsJSAVDRpsqjjABPwSddfD8Kx5d0B3GWEsiCopVxHmYCKQbJ4NycO6Cxu6?=
 =?us-ascii?Q?/U062t3dHhUE3AgGDwLWBaZSuvOxnICGOXo7iFdhh01WlgPZnPX/EL1Em0tI?=
 =?us-ascii?Q?ixWJps2n8kd/XUjLm9IOYTjv9JN0gyOJfLwneOaJaQHdXTZmC8+nWDtNlW2q?=
 =?us-ascii?Q?1ds1phhCuMEnQ4y1XDsoMRz2gd2xed8983k+CZiBUsl0btYVGPiJ9jFY/azs?=
 =?us-ascii?Q?cREkC6kqu6lozlJSwK1jUtyUuuj8U8PO22Uo0nTBnBW0bhFj1sM2KsGZZH9G?=
 =?us-ascii?Q?mjZCedr62lU7FGlzjtk1XiZJQU00mMYWcFp9mOYSjk20LvdElzVZKiKenBXy?=
 =?us-ascii?Q?Uv+0fmAuQ/xUjFEeVoa/8hY14Gbe2JZbyJC+ZUdoKlJjFveGKrou3VgU7ZqS?=
 =?us-ascii?Q?usQCoewbLLtxt0kiXO/4Luw18zXPj1LllW1rfXtwzeUpq0A7oidFBe5zaTPw?=
 =?us-ascii?Q?4XDvegUc3tBSUyQ+/k4iUm1YKGsCkJXZePcbjwvZnoX2dErPHPROJWgZjKdi?=
 =?us-ascii?Q?DUxJwrF/Op1AJ3B5TFVqy59vOaAmTEXeHgvlcuja2wsN47mahYAzfOIveVmD?=
 =?us-ascii?Q?FOX/RnFghT1MIgxKTbJYyiv0ZueoXiIYcxz1Mjb3GsC5kap8fl2tGyTv8Xkr?=
 =?us-ascii?Q?QqVOrmE15isEwG1VRCDHGnVUHm6avcG4oIMK/NLoBhiU2SPmTWIs4/lR9Kxa?=
 =?us-ascii?Q?AhlyxNZINiFhxsk49kEbItJBYniL3r7lYSjVFJJPa43qpr5VJPq8XBUkn0sl?=
 =?us-ascii?Q?uz+Lhm3Km2VQ0UM6UZ2yHGtPn4Tmmg+eJCG96TvsyDVwwtT6kIsPe2RI9OeM?=
 =?us-ascii?Q?WlB21rNGYmJxWvP8IyRpUtjZDDR/id+BrEb0LDUVihin4g2xxGmte+8zM7Wb?=
 =?us-ascii?Q?NS6yIEAKMvF27Onm/VIaKnxQgxDKPKvQm5tqBXIqAczMk32iOJXexcOXkAm+?=
 =?us-ascii?Q?sO6GiUttSOkJg9QGkgTgvlw1qvpfXxGmhcIfzdhO3LLE6jChGantMyXXiYsj?=
 =?us-ascii?Q?urcF74gRr9wp3X6rdYgivljoDm3FtxbZeuMvlkUkb3dG9vrPS8a4h/rK4LIL?=
 =?us-ascii?Q?PSK0ASlBSy5VqkK9l4KorVvoOKoRa2XV6e6ws7M0WLNJjS8rXG1giCjTMY6V?=
 =?us-ascii?Q?dIno1zV9sXFFphLf7K6G+8SUVTC9AQLXL7q2NifYGtvPV2x/eAoIeAycNLOv?=
 =?us-ascii?Q?f6cmaOskx8gF0Jo0WectSn0FsNWNsc06zQJn6vkiM9I0LvPTHFxGqTWjaylv?=
 =?us-ascii?Q?Q6acL2kggQ907pgQQc/teP+v2oKzcqaEsfOjPJX2uN0BMwVFkAJmAFEy5LyW?=
 =?us-ascii?Q?jNaYH55OZkaZkQNel0PBKQDhVod+DEZKPJC35HA2Hmmggnj8ihbhJqkaRcKW?=
 =?us-ascii?Q?Vl6SBBwJK/Hj+5zM62+YAVk1653Yn+FpTbPcXLUOSxt6QQUxUvGV6tADazew?=
 =?us-ascii?Q?4eovn9bmPzKBxySSP1Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71a86ba-5054-4035-ada5-08db461c74e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 06:07:03.6658 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gNHsuNt2jCKDZN1IKftXE32ggm34A2Kg2ZsdzB18ls5JtNLb3zMMZB8yA+AmKaAv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5687
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

Thanks for catching these. Double checked the two places are good in topic =
branch. The patch is Reviewed-by: Le Ma <le.ma@amd.com>

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Wednesday, April 26, 2023 11:31 AM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;
> Ma, Le <Le.Ma@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH] drm/amdgpu: check correct allocated mqd_backup object
> after alloc
>
> Instead of the default one, check the right mqd_backup object.
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> Cc: Le Ma <le.ma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 2cf1f88fde48..66b9740ec376 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -379,7 +379,7 @@ int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
> int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
>                          unsigned mqd_size, int xcc_id)
>  {
> -     int r, i;
> +     int r, i, j;
>       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[xcc_id];
>       struct amdgpu_ring *ring =3D &kiq->ring;
>
> @@ -431,7 +431,8 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device
> *adev,
>
>       /* create MQD for each KCQ */
>       for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> -             ring =3D &adev->gfx.compute_ring[i + xcc_id * adev-
> >gfx.num_compute_rings];
> +             j =3D i + xcc_id * adev->gfx.num_compute_rings;
> +             ring =3D &adev->gfx.compute_ring[j];
>               if (!ring->mqd_obj) {
>                       r =3D amdgpu_bo_create_kernel(adev, mqd_size,
> PAGE_SIZE,
>
> AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj, @@ -443,8 +444,8 @@ int
> amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
>
>                       ring->mqd_size =3D mqd_size;
>                       /* prepare MQD backup */
> -                     adev->gfx.mec.mqd_backup[i + xcc_id * adev-
> >gfx.num_compute_rings] =3D kmalloc(mqd_size, GFP_KERNEL);
> -                     if (!adev->gfx.mec.mqd_backup[i])
> +                     adev->gfx.mec.mqd_backup[j] =3D kmalloc(mqd_size,
> GFP_KERNEL);
> +                     if (!adev->gfx.mec.mqd_backup[j])
>                               dev_warn(adev->dev, "no memory to create
> MQD backup for ring %s\n", ring->name);
>               }
>       }
> --
> 2.25.1

