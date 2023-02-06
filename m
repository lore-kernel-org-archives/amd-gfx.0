Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A31C05027
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 13:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FC5C10E3C7;
	Mon,  6 Feb 2023 13:18:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8AE210E3C7
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 13:18:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSqmaaRKxAamDaJwki1oKfeQXZ9LqrByx1iEpJBaarC5L9dAVUIzNzCKvGmM0mE8b0gmrKhuuNuMRq2Sau8JjHJr38TtZtQC4zWOxDinQdvWC4uq1lf/R5qFPlmCJgi82zMwSqnTx5OZ69nXgUT46EF/ecL5xIqYFjX8miyvgB7b9wK6Ov2KYpv0cdI6GPCeZSjfGtwQ6Eg0Omc/nB2qe5zZGVcsnyiL8Kz2oAMnxExwDIqEMDFbXkIhaHIauZY64/TRMGIV9UU/XovFEOYRIhM0lIRkqPT4KYWCehiw0q/MWHesPmFAt/rJXC6KoyjyiIOG1jYcq4e3TrZIdP0nfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0G/W1mromugAceqZP0rUMhq5jjZ8KASac2U3eZxDEF8=;
 b=n3B54wK6qUhEHzxla6v9p8r/9C+UjKnxrkkWbe5fzS/35emjc8allf0XS8lEIE7Gh9clDwIa1i5ahzxbvZntX7xdsOKu5Yn/3wPkBhCrUT0G7YqOqkvBlOIfYfgJ+pziMqAAzZp1eXPhW9zzBaWlKgg4bAxVgugKtEeu1ov4WsmiSMLL/X8bG7J0ofEzp8GRGZGCnWtCEGsWzp6QkCiNJ4CJF4G7zOIGV6UCbRfaKNqij3ndfcYkaDfnrgKjKU58hrErlRk3YaalxZIttH+ZHX1Mn0SO9laNYoFepKqojVQiNuoP27R5T7iRiQFSkBC9Bu7onlj1oHGR9Yh/3okk3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0G/W1mromugAceqZP0rUMhq5jjZ8KASac2U3eZxDEF8=;
 b=R6ba4pzpEVKrs99FSiVnbx5DobcFbLI2z8K0l2axHMvKr+sjJ5mBvtCNECTamZtrxl4B6Uh/Do55Av3Naim6r9jRcdAeT/FnQ7EXYwUGWjTW0q89jaDpbItk22tTwNWHfRvXL+fPCWHGim09Jwi4OXaeyc4QGLZzrT20VfI1GxI=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by BL0PR12MB4945.namprd12.prod.outlook.com (2603:10b6:208:1c4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 13:18:06 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::956e:e4cf:6a8d:3f13]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::956e:e4cf:6a8d:3f13%7]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 13:18:06 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Ji, Ruili" <Ruili.Ji@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: To fix sdma page fault issue for GC 11.x
Thread-Topic: [PATCH] drm/amdkfd: To fix sdma page fault issue for GC 11.x
Thread-Index: AQHZOirDhedgJlnXFk+OM3OdAj8Xlq7B5mmg
Date: Mon, 6 Feb 2023 13:18:06 +0000
Message-ID: <BL1PR12MB5237A840809C15EE4391BFE3F0DA9@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20230206125812.1554992-1-ruili.ji@amd.com>
In-Reply-To: <20230206125812.1554992-1-ruili.ji@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=15b218ea-9e44-435e-b418-56bec82f01a9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-06T13:17:33Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5237:EE_|BL0PR12MB4945:EE_
x-ms-office365-filtering-correlation-id: 07e6bfde-5f65-418c-11b8-08db084495db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3PxE7m2pByIOn+mKGSA9OrAq9jBOL9cjdzEVW9obp7TMULneHiJM7SEwIk3/fV7+w/jzjbc+BL6aJhxy0WsyKWFz9hM9F3XfaYcxUqOqg8bc2ZZJtJgK4UCwo0hPWKFFRpwte31FW+4jK+9pDcLllh/mTjUlnR8WtDz7avIzbQN6uPK0cBWpir2TLxm7rYOYaLtBEwhR0RxDShVSp5FgOwiCwt2JNXTZFb2jZOUEJyZS8adpsdtD6GdZD6X9iCcbmIEIvyxO+owW5i7yCYsE+ZHm9BjaJ+4oO/R3FfjXuq7SVPdqsx/eOjqB6PR4gv7TQDwXmgOtLCu1Odcv33nJQyZnTfCjgplO4+0gr+d+pvDvdzPy0oOXx17AtVKEYQy2RJY1xqFWeDHqH6Cq0t9MwH1lH0c8iwuNNIO1fdL3kLICosKD4AVyd90yN4ZStEARvM8Icy8GxX189aYE4tPiSIhUkPy1soqBYBbb7570Uk9+/1adtCG9xbH529jwNCD9h8kPxU8f8lxDhIqvqzzhvh3xC6ZX7pUAHY8AjX8dU3h+F2HqaLXUL7CPWiynxZcZyCckvqmepUGa3GBIwwjUl2/ytgqcrUPswyJ5F/+RrsJz2upvh+pMs3S4LWssi09LwFtzb9xdqc1vby7H/oWWYS3wSyGU3FshhqFwshH76pErFjpdfeVFQdMhoww8GMfY/5OIKeyJLAJChFXKGzRR9Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199018)(316002)(33656002)(54906003)(110136005)(86362001)(55016003)(71200400001)(7696005)(186003)(2906002)(64756008)(66556008)(9686003)(8936002)(66446008)(5660300002)(4326008)(8676002)(41300700001)(53546011)(38100700002)(6506007)(478600001)(76116006)(66476007)(83380400001)(38070700005)(66946007)(122000001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y79eJQjTHqEBS6VWCjeF81Ba7r2zn6FPmVKJwjYH7kmLsQsf4JKvBIZF9HUU?=
 =?us-ascii?Q?y2K07TXF1CNxUVq0R+lFd1xPC7FqbFWvs/IO+puD0zePEMRfKuEyHWd/Cq/R?=
 =?us-ascii?Q?N5qGnnKp889ZHX208AEYXWAqNidyOMWs8wCdrE9ZSLAOjYmSWVAQoXIyrfdS?=
 =?us-ascii?Q?MPaCu7cia9WhGF/AmGH3oeF/bAa6Uv8rExZWPah2SJoX0TbITKCHIBNHulvk?=
 =?us-ascii?Q?y3MaPPnJuZ7ckcKQdPIWvYz85EaOq4DlTwwQA4/e5Mril3ZP2760+YQBZvWy?=
 =?us-ascii?Q?q7G5+ph/qaGQnogIDhZbXA3xScfEjz26IQuhRcO00m93PaUg7z/Ad7M6XqUJ?=
 =?us-ascii?Q?zgN1cdM94uZxEnjhBF5QiZgSx1ppXWsZgcdzP5WR4Xt7YKqoXoBcK3eixrsH?=
 =?us-ascii?Q?1Yh8dnrPyBkZGF6/uxFqWKJjwb94zpKGfQSeUyBsrVNntQAGhMPQWTBLfLZJ?=
 =?us-ascii?Q?KgGS7ArhvenPfhphBlWkfCOz7O+ivHUYU4Ij9+cH9hgLKZDPww7bla5HNYI+?=
 =?us-ascii?Q?/OTgToOzohhmY3lt1ZzQzZasf085mdLurVlpXIjEwjOtxWW75TboyasuxAy7?=
 =?us-ascii?Q?DHtio9KN5GCkJx6vutPw42JfeKRHQm/OHiFFuzot478436OFsZGMTPtrIyOC?=
 =?us-ascii?Q?P2+TT8p8ankhuqB21dJU7LH99rtf8VT9BUA9FRWWka/PMpvImbgza7Cg9Rq8?=
 =?us-ascii?Q?6k5hDsDIUeaSlGhbWs+R/PMBTVz50+DDJTUivc0Ihg5+NwWwe4kXEzqKfn0i?=
 =?us-ascii?Q?6ofkU/2NnKGmNr2BFKBH+1z7poZW8if0exVzcgqaZPmNKsE+Y9eOlDcxRJmQ?=
 =?us-ascii?Q?E3xTa5j4E/R4zo0/CltvHrtuKRqBBis3ZRD2bm8AWvAVTPAWXz51CYXg8lFQ?=
 =?us-ascii?Q?I02M6lxoaXmT8VNfZyksSeNxGWJX5RcN9Nv7kJWodYrEk+o3VRHapqNVWXlD?=
 =?us-ascii?Q?PCeiK6k3l+kZ1FazBzJJf/xnvJLI2fcAvIxQDfmX4WXv0Qh/Ssgt+arsyHa/?=
 =?us-ascii?Q?8S/suQGZpm9eKvrbtxMYOJHUHyFygzyX4El3hrSyyfjKjZFql+U3ZwiBlg/A?=
 =?us-ascii?Q?qSteOxcguFpy7sw5PMcSOn9oi2rlgrKilKck7jeOljUEeGlwc6+6FlX3HUQh?=
 =?us-ascii?Q?und79smJNU1bHXfTeyBqGd2AeZ80fK1MAYEAj/t8t1CmtGvrRWgDRi45tkJr?=
 =?us-ascii?Q?Zxsieap0XmGznyd2EotMjYn4oaQBIFobwae2wcoCcIB97/5fTAxxTDMxOGno?=
 =?us-ascii?Q?Kc/j3VveM1zeGKXnHojovqpwzkV/tKu/zQFJOPQip7TomYeYY976Av7wgFaO?=
 =?us-ascii?Q?LS0fj/D5we/vGj+2qpcJafM/mzNJDTu+O76tPSFpW0lKPzoS/Xn1Mn/oM8Hn?=
 =?us-ascii?Q?qYXQh4XYRnetvoX4K9W6xU4F8iUwsRUgin5xe+hVW3XU5wJwBwD+1DVCZix2?=
 =?us-ascii?Q?F+9A7RAvCtUWTRh1S37XGnmu22azRbeC4Grs4ogFFEDzkENHthWERSENbj05?=
 =?us-ascii?Q?n3m+/c2R/jgu2jTI8QSBGCOJd1lJbFzEG//vFwNhv5oVu8yNMAow/FX1dQ?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e6bfde-5f65-418c-11b8-08db084495db
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 13:18:06.7705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7IWlwAihMLSPqGPPHi7M8cb8piT50JgsJHa9jcr0+GckUVOkRg27w6oeajJrtAuS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4945
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Aaron Liu <aaron.liu@amd.com>

> -----Original Message-----
> From: Ji, Ruili <Ruili.Ji@amd.com>
> Sent: Monday, February 6, 2023 8:58 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>; Ji, Ruili <Ruili.Ji@amd.com>
> Subject: [PATCH] drm/amdkfd: To fix sdma page fault issue for GC 11.x
>
> From: Ruili Ji <ruiliji2@amd.com>
>
> For the MQD memory, KMD would always allocate 4K memory, and mes
> scheduler would write to the end of MQD for unmap flag.
>
> Signed-off-by: Ruili Ji <ruiliji2@amd.com>
> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 20
> +++++++++++++++----  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> | 12 +++++++++--
>  2 files changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index c06ada0844ba..d682e6921438 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2244,10 +2244,22 @@ static int allocate_hiq_sdma_mqd(struct
> device_queue_manager *dqm)
>       int retval;
>       struct kfd_dev *dev =3D dqm->dev;
>       struct kfd_mem_obj *mem_obj =3D &dqm->hiq_sdma_mqd;
> -     uint32_t size =3D dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA]-
> >mqd_size *
> -             get_num_all_sdma_engines(dqm) *
> -             dev->device_info.num_sdma_queues_per_engine +
> -             dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size;
> +     uint32_t size;
> +     /*
> +      * MES write to areas beyond MQD size. So allocate
> +      * 1 PAGE_SIZE memory for MQD is MES is enabled.
> +      */
> +     if (dev->shared_resources.enable_mes) {
> +             size =3D PAGE_SIZE *
> +                     get_num_all_sdma_engines(dqm) *
> +                     dev->device_info.num_sdma_queues_per_engine +
> +                     dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size;
> +     } else {
> +             size =3D dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA]->mqd_size
> *
> +                     get_num_all_sdma_engines(dqm) *
> +                     dev->device_info.num_sdma_queues_per_engine +
> +                     dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size;
> +     }
>
>       retval =3D amdgpu_amdkfd_alloc_gtt_mem(dev->adev, size,
>               &(mem_obj->gtt_mem), &(mem_obj->gpu_addr), diff --git
> a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> index 623ccd227b7d..ea176a515898 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> @@ -66,15 +66,23 @@ struct kfd_mem_obj *allocate_sdma_mqd(struct
> kfd_dev *dev,  {
>       struct kfd_mem_obj *mqd_mem_obj =3D NULL;
>       uint64_t offset;
> +     uint32_t size;
>
>       mqd_mem_obj =3D kzalloc(sizeof(struct kfd_mem_obj), GFP_KERNEL);
>       if (!mqd_mem_obj)
>               return NULL;
> +     /*
> +      * MES write to areas beyond MQD size. So allocate
> +      * 1 PAGE_SIZE memory for MQD is MES is enabled.
> +      */
> +     if (dev->shared_resources.enable_mes)
> +             size =3D PAGE_SIZE;
> +     else
> +             size =3D dev->dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA]-
> >mqd_size;
>
>       offset =3D (q->sdma_engine_id *
>               dev->device_info.num_sdma_queues_per_engine +
> -             q->sdma_queue_id) *
> -             dev->dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA]->mqd_size;
> +             q->sdma_queue_id) * size;
>
>       offset +=3D dev->dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size;
>
> --
> 2.25.1

