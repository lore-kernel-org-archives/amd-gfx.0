Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3826CA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 13:06:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AC4710E997;
	Thu, 28 Aug 2025 13:06:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q3MBQlz6";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3069710E997
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 13:06:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qonNAPXM7D7dyXYKlqurtfJf68LNgUbqsyIV4CmAVuh34MDDqfH/KbA9Cg4EEX7cb4nUcRKuAZ70RUFAu6FoUGd6MfKHWYEEPaUYoQwVUgnPnMWBQs5g26LGdqszrvryJ9myjNL1sr/VGh0UpQra3xkOUe1dOP54fmh7WvuNyqhASXkV6lTIE1QJDtLKWbxK+J65PQu+s4bYOf6bHytvOEW367xCzV8qZum9aXf95lQl9EBR92G+SxHLOGQYpI81D5/RBOa+KxYJ0dE+F9KqxR/9RW1TasnhxCQY5jOQOvm0X95TqwhSBa7KINgYqDpSIBsqurEnr6DLAo4wrBnRsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPKqTbBvrxPaGl2lv/1C84nc2M/LyTayrpfiOy187fk=;
 b=j5pZNIdtC+SG40hH6zAySp52/ke/0susFlPR9qkxRxSq+VqGiu+OUtPFimY/5X/Oz9Yojna7PWnThoiyxPfJxsGa07UcEmo1JeNG5LnHN0gG0ZOonr9ZvsiaiOBLHL5565nPCV69uJEWjNRwVVW+H4b1aSDaMJtXWnrO/DDIRLTpYGifWVE4+50Ovbon2tTL/mHlXpqEiS5ne4hkxdq+NabXcIMhQP3mAc5uT27iL0QJQ6/XHJJ3tW1x54gelHobjuEqWJ06YU6B8gNFRTHBiGekH8S7icA9j+J1c/qqRrj3QCDf+A2Dgo1tmIe+9hJiBUK+9LA32Nn5Mwc2us6q2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPKqTbBvrxPaGl2lv/1C84nc2M/LyTayrpfiOy187fk=;
 b=q3MBQlz6ojVuXlZIUcSjjUvLEu8AUDhqUTXZLzWrAfQB2xAqkCOdBp8Z7HFJZFCP0F5j2Q3pJQRos+dZZwm4XJA3gSjuAeinbYY3oJ4V94JUarhYY73cf7Xvf17F9g3PZdQKrdt0YIYpbbxUzGdZST0BhhoZJGj6zVT78OJ+Qy4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN0PR12MB6150.namprd12.prod.outlook.com (2603:10b6:208:3c6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.19; Thu, 28 Aug
 2025 13:06:38 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.9009.018; Thu, 28 Aug 2025
 13:06:37 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "McRae, Geoffrey" <Geoffrey.McRae@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amd/display: remove oem i2c adapter on finish
Thread-Topic: [PATCH 1/1] drm/amd/display: remove oem i2c adapter on finish
Thread-Index: AQHcGBqieE0R+BAjgUORr9JbaELoxrR4CM2g
Date: Thu, 28 Aug 2025 13:06:37 +0000
Message-ID: <BL1PR12MB51445224CD2AE0B5AE627C1DF73BA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250828125222.382529-1-geoffrey.mcrae@amd.com>
In-Reply-To: <20250828125222.382529-1-geoffrey.mcrae@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-28T13:06:01.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MN0PR12MB6150:EE_
x-ms-office365-filtering-correlation-id: 0466afad-9462-48fa-fa30-08dde633b910
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?nvXWW3S80b/UnlGGoXym16lCuOudZR4OljHU2+KDjAnKqh9w1C5eSkNfDALH?=
 =?us-ascii?Q?zTV1HP6Uq6ILYxgLQxKnvYCc06CGEA2AvdutLQdxHdfGcq/3vqGHY8aXcErm?=
 =?us-ascii?Q?g2czIaw5L82SvYD1RbmN8//E2i+A3PM2xxrJHu0p7nQC/CZRMC4JgEtawGi8?=
 =?us-ascii?Q?z+7qPMyNVxE7mxDZ+/1lrJhiH/AgEh9IMgKTFuGfoYnOsjmCXdUJ36TQy7IR?=
 =?us-ascii?Q?gWABwxNdMDbSok167136NU7YyoM1LI+LRC1EryV5huYEibzx1DYBt2tobwDl?=
 =?us-ascii?Q?4GmL/4eaN38EHa03HHl5efDSEysV0BnlJT3MlTxW52szGoRs2tetEcNKHfPg?=
 =?us-ascii?Q?zxcnN/mBhu/zT+WW3eMs0SWSnRKTN88UJtIiBgdm4M/OngCCrkdbJ1L6MyUb?=
 =?us-ascii?Q?jkfcsnGNAyBiiJHocd1PHCe96Jxr1XJkbfXpzgX9Tph/YJQCpdO0YvZ+wnom?=
 =?us-ascii?Q?w3Q8TJaAvsFKCZUnwSwjo5XoHFeic6erQKYTcMSPc+VhWfzuzRORBEZVT6Y3?=
 =?us-ascii?Q?1JYCRnlDxnx2zpwiaMpFc8WwdutqpxEkNvFj6PJL6Qe8MVfVzn/UysWCaWZR?=
 =?us-ascii?Q?W2QVHiABmgER46fJ1/DqF75jcA78LIy5dg7icBBk4GZ++hZ0ounqRNDgMUOI?=
 =?us-ascii?Q?6UhnBUVPJ5U3Y44Zk+ZcdT+R1BcraDNP9br7aUlg0GU44UgnqwG/K0gS2rH+?=
 =?us-ascii?Q?Hghot/8I3auvbHaTMr621Ds+eC/YcGb+Wp2ivFtL8Q9DVPluT1kpR+TGeqo9?=
 =?us-ascii?Q?qM84GTI9FlV+0WM9jj6h6k+XcWhJzm8cfdiNWOcJdZUVhSutVC9S7uMTlKct?=
 =?us-ascii?Q?bhTrAg1NwP2ICMqUpv3FgrVSfa8pIvMW4fPY1LmVKSs98NtKPSOwoBj9jwQy?=
 =?us-ascii?Q?TTTKJURsbkq0jGChPtSwzXRyH2R/25Ot52MdoturL7okYMBGF/eTHmY8wwMc?=
 =?us-ascii?Q?r9PhKbb1ZrLhJGFWhPGJGsVdTUjgs1VEJP8l78YyHOisHtpc/9oIYKxX137k?=
 =?us-ascii?Q?KYf1Q4dDJot8Lquo5e3FIsVIKUcNukWcvLTX+CiX/6xUCLFzj7f4sb7WHa8/?=
 =?us-ascii?Q?JW+IYNw+OFv6UaX/kkweUoT4aJXGYAW7d8hLisUT5Su3jM/jAHun0tr+tbK9?=
 =?us-ascii?Q?jp6qRUia/2wHuaoOEBzknXTwvUxVcqcPjt0PGib4N85cwel+s19ypOpenmnk?=
 =?us-ascii?Q?T2nXdIX81SfJG6g6UNv7fwWsOdrAIHnYsrKvA0sbfuXKKlOPsu0KtJFaTQmf?=
 =?us-ascii?Q?fW21bsf+F78ExKNxp1+OGy8IpUoxJpIiYdmQ09a4sBd8WKg6xI86wJGbIZGr?=
 =?us-ascii?Q?ZqROF6YZqyFZlHLhp+dhABrmFTVeX16xg33kNbZkOWdqgwo66e4k1gJpOY0k?=
 =?us-ascii?Q?GMU9KOb2J8ph1slAeYk/be97KmIOq2+YOc+qxnf8XcEjanaMIn9NY56NbK+s?=
 =?us-ascii?Q?pqATTWDBxo1JcLSi227pEu8PdmdYpcGrmBQNs5lHKV6EFiaI+4WVBSI/py98?=
 =?us-ascii?Q?QbzRUGR2YQGINnI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3W+yvRxZfAH6ioKF7G/vr9qEGCVf5fJLwoK4XKhUmywXbBZP3NRbR3pkEFZv?=
 =?us-ascii?Q?zohkQCGamjz17kAFpCVmWpFd6XStrg6ZfDkFjEgazNvOj1urp4DMxBbpXt1w?=
 =?us-ascii?Q?BtYlk5pApexwHFrKPuFtXDi96AZrXS3s2ooJDT//FSF677LRodF8T14ozZ8G?=
 =?us-ascii?Q?gl9UBJUj63GZie+cidSI7qUNKOuR0y84vKjo1xJoXJXZQPrcJm5NydWICiie?=
 =?us-ascii?Q?Sa5p/eeN40ACFV+GsZmoTZel2ZHcGiTTp/4/Hk8MU54AMI3Um248eqvJDw66?=
 =?us-ascii?Q?VNNiqIaIuOBNiDX0dyo25j5jLvH1Mgr0AXEoue0Z3XH73Q/cP3VK1nm7BvNF?=
 =?us-ascii?Q?SH2tiiQcHVXgOODq0KA3xM4mPSHS+xD53Rp+jsz34B5iG9DBP/RyNhEdhnq8?=
 =?us-ascii?Q?cAwEvWKfwvXi3PMQJGxOx8NNvlPfZqgFO4olLtt2t2lmn2R3qySgri9mRyhV?=
 =?us-ascii?Q?1fQcb/21N9s1yINEZEWlNSG0dUAtffBVrfNLcE81Hp8KB6HVzOSA4HXpt8a9?=
 =?us-ascii?Q?xcF8XeiXnSZY2ddMMr3kNra8Ru0KYQnHPZcrkV421bIydf7PVUz/sN6HCeB0?=
 =?us-ascii?Q?Jih0bOPvdZpgd2WURLa4DmRXpi6zOxrOJfrzJ66+/SawH+2tbLTIpxot8K7I?=
 =?us-ascii?Q?2KHQHmzZMlaLfNG2ADywBbFpQ89f/5NpxlQx6FKFFX+q4YpW4skHKOulIIfb?=
 =?us-ascii?Q?vP5IX5j2aMOnLuotYzFIN1tmERTeQj8VePjOeYnEjPGGx+N340TMPUiQFvbW?=
 =?us-ascii?Q?a5/Q9pk/LHmol7Y0xLVEXX6Fv8hQ1Prf5Zn5S32T8jfmbBgsLo1ptRhcn4ks?=
 =?us-ascii?Q?YetzsuKAjHnyIOAvS1ADW7okMk0cMUIGVmN2elV377uHidlXl7V5s7UIHdEZ?=
 =?us-ascii?Q?QYbdid6qo2De5P6O2HrA0MWxt3bCv74O/MXW+YSYTLGM+ax2S2YRU9cT0YN4?=
 =?us-ascii?Q?M7KFQxGGx6yUsZbpEM2fUwNcN6ECfvmfguNPZM9O9sKJ5gp9thi3o61ZRFWx?=
 =?us-ascii?Q?P9Fpi3dr1rxvH8PYnp9qGv8CCygYqxwG7MsXsir8Z45odGTthTrYsiQ6077r?=
 =?us-ascii?Q?x23y3NK7yXbhNF38HEDZTwNumEcd7mXic3domjaRWhkVUKF7TYImO9gFXlKn?=
 =?us-ascii?Q?jGc01q/TUB9IGcUZiN918MrJVUe/lHu322G4M1/jmXNMHHu7qy3Ndc3sR2MT?=
 =?us-ascii?Q?+E6VaC1tt+5tYuL5jX9iYsv3BF0/EhMhGhNTDFP3xqTdaozPvqVQBpSBDMEM?=
 =?us-ascii?Q?z0n4akpnVGux+iPme8NJ4hFzyAPF8kHgJTryE5asJKPB+T69FJMDoeug3DAI?=
 =?us-ascii?Q?nTDsrTb3T4Wefeu2seDdyO8+tHIlJhoP8qMX369Zpyia6rIxKD0ijmu1WhG9?=
 =?us-ascii?Q?yHhR/2+7yWpYRYSHBYjhPMf6ZAfdNl6JrI5680QenTjnNZ4f30InG6JGCDxh?=
 =?us-ascii?Q?0Uc26gkLgGct0HFKv0VU6zrIaaAok2WSG9qqQUg5lpw31WsIWwHO1o5vYdHv?=
 =?us-ascii?Q?YUQqcoY6RBlQg395VwUuEfA4gCjd9nOYWXBYMFs65ygBSd4fcr1H3ql5RROB?=
 =?us-ascii?Q?Y6zLu2Ri+iBLjq1tu50=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0466afad-9462-48fa-fa30-08dde633b910
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 13:06:37.8607 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ov7sMu76jkuqrkTihX1nnlDbS9g0SxnpO/gkygnWmyFaE4suOcv/XRFO3hToYiFpfNNQv9B3FxYmPyM48VNPzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6150
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

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: McRae, Geoffrey <Geoffrey.McRae@amd.com>
> Sent: Thursday, August 28, 2025 8:52 AM
> To: Wentland, Harry <Harry.Wentland@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> gfx@lists.freedesktop.org; McRae, Geoffrey <Geoffrey.McRae@amd.com>
> Subject: [PATCH 1/1] drm/amd/display: remove oem i2c adapter on finish
>
> Fixes a bug where unbinding of the GPU would leave the oem i2c adapter
> registered resuling in a null pointer dereference when applications try t=
o access the
> invalid device.
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>

Can you add a Fixes: tag?  With that added,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> Change-Id: I9466b489859c3963653976e54818254596b5a13b
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b944abea306d..ef7b59fe6f4d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2957,6 +2957,16 @@ static int dm_oem_i2c_hw_init(struct amdgpu_device
> *adev)
>       return 0;
>  }
>
> +static void dm_oem_i2c_hw_fini(struct amdgpu_device *adev) {
> +     struct amdgpu_display_manager *dm =3D &adev->dm;
> +     if (dm->oem_i2c) {
> +             i2c_del_adapter(&dm->oem_i2c->base);
> +             kfree(dm->oem_i2c);
> +             dm->oem_i2c =3D NULL;
> +     }
> +}
> +
>  /**
>   * dm_hw_init() - Initialize DC device
>   * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
> @@ -3007,7 +3017,7 @@ static int dm_hw_fini(struct amdgpu_ip_block *ip_bl=
ock)
> {
>       struct amdgpu_device *adev =3D ip_block->adev;
>
> -     kfree(adev->dm.oem_i2c);
> +     dm_oem_i2c_hw_fini(adev);
>
>       amdgpu_dm_hpd_fini(adev);
>
> --
> 2.43.0

