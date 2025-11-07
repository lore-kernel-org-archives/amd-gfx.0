Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40F5CCFA05
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 07:13:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39C0710EA2F;
	Fri,  7 Nov 2025 07:13:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0B8vF1ai";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10EF110EA2F
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 07:13:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vklW6nfWKVzFnxnfjb5tFame05T8zpHo5e809PdORo61f3KdmhxCSH8s76Wwy5xeyMS4SekachXZIaiCNlNPS7Oalcw9m9nrF185aOu2ZhgdxigouIvVIQn8v9sOBBf6xDegZ8/veUQ6SAzzn4FSkY0Zr2qn6RkLoSfUhxss6Onqen9ruLsl9X/LYFr6U4isSvivVCLAqxIC8bVt5I2fQNHA+f0tJhdj7CVGCjvn/odgvE4fBfgSR6QAdDi7KuakVyjIypMmUVNnjDKn/zvaGFORDY2vmfyHBBByPefy9N0cgELnI9TQcHJ3ntcdkvHpTKapdvLqprO9FB2k80JMQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0eZc/OBIqiyTzN26JWyLjSPydsDeJkbYwzL60DTErs=;
 b=lAJHTzX/K3wI+0HQRV2Oki8NHJjHanSklrkSScKcDCnq3L8FdCcJgdPNzlSfiLKxClYiYYp0pu1qT5xrxbVF18wbjhIxf5mDxzLy7Jk4hegyRQBy1b/i2PSpJroT/tYQ8ERlcTGD1i91Lkk0AcHFlCfwpBKxsNefrwiyORLPgxc6qEuUPJvEHDQ19g/s7Ww0r0caWFwI2GUpqZPaNWWdZsYYzKLx+vdpOgal0uSnQoxlQ+RFp3SpONIDFZcs6HXW+bw0Ne2yWjRtmSzOBVrHu7MF2O5FrpvgPyAVttPTQ3rgFSw0w98aloo4+p7cmulfIwrEj8imhJhbKFzAibzEmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0eZc/OBIqiyTzN26JWyLjSPydsDeJkbYwzL60DTErs=;
 b=0B8vF1aixCGnMU1hJn4NptqQ3jHeY31mELo8wP4fZeG7aekE5vuZ3ylg902uaLCrWj1aw7lx8idR9hIhF6QqTxeT+7rdceUiptDzoMNaBr7L98DhTNPO9cvdLAYHFjmacLE8x7GVmAqgPclHRAjf7hpsryFMnSgTXBbfWfplfuk=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by BL1PR12MB5922.namprd12.prod.outlook.com (2603:10b6:208:399::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 07:12:57 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%5]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 07:12:57 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Li, Chong(Alan)" <Chong.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: reduce the full gpu access time in
 amdgpu_device_init.
Thread-Topic: [PATCH] drm/amdgpu: reduce the full gpu access time in
 amdgpu_device_init.
Thread-Index: AQHcT7VFvh6jVqeT6E+hkKbJt4zIurTmzEhQ
Date: Fri, 7 Nov 2025 07:12:56 +0000
Message-ID: <PH0PR12MB54175F5E052BF7297CD0F98A8FC3A@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20251107070747.1663874-1-chongli2@amd.com>
In-Reply-To: <20251107070747.1663874-1-chongli2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-07T07:12:16.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|BL1PR12MB5922:EE_
x-ms-office365-filtering-correlation-id: b73ba428-aa58-4742-2072-08de1dcd13c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?o2V5DIk8u+DMALkWiYwO5rEQvFcs2j/gounoPPdedUjc3sEHLl9KI3CAxbib?=
 =?us-ascii?Q?n2XoadqYeD6sFNkxvb2Cxz8IwIDS3ulA5ePYdvNNSg9lIuWFVnEKWwCvO2sC?=
 =?us-ascii?Q?t1HT2JSCXCn0qHNoTL1RenUQvTulpRmjVi7XZq+5MOhoFd0KCpijbrI15+JV?=
 =?us-ascii?Q?vlLXHKs6zab/cOe34oDQzkBVgSxjmQN6uz652zIDYK0yIItiYv/bRS8SvJp8?=
 =?us-ascii?Q?AmWup+ZFB9SV/wtI22at1fDKJAkT4hQP1JezH1iGW/QA7XwW9zPLobjL8aXC?=
 =?us-ascii?Q?Lkl5ms4tB+CLn3bz6A8DmX11oyWFrxTW9ruKSX2zkdYxDpqmNCIjwg28XfQ3?=
 =?us-ascii?Q?b7NQJYeVV9PXzN6/GZERf7R1nkPGaeTtz/KMHO7CZlrsLuhcEXEev4592qkZ?=
 =?us-ascii?Q?+C8p1RfaLo2Ai7Bfbq94v4arduC6WnwKiLX3FsWQfJtMy4325WefAUksfkk3?=
 =?us-ascii?Q?fHC3PtiLW/MzXARu2dEefSeTNQtvcq/lhnHfUCfhGxNJCilCrOx343e106aM?=
 =?us-ascii?Q?r/dqrqIVqgbmqfNZiyg1ru1KV5vXbnKnn+FAzp6Agnxe+SuXo1bVNnJsLoN1?=
 =?us-ascii?Q?g5bDYJpXc7bBJhTky9WNeEMTQF7wrGho60tABOZNrsLwxsTEdBOar/J386Xm?=
 =?us-ascii?Q?h5G6B3K3dJ6v3STLhDhfv8/m8xMFQFrU0Mph2JBQvQ7t61ko57J3YdzOEEmj?=
 =?us-ascii?Q?H9oDKQxM7zcQfGC+0wyXJPBGRVP+USVdTZKXPn9tO8Lg4D/c4FMsFoP/NYSX?=
 =?us-ascii?Q?1WgCK3FVglHMxsup6kAhKyFqrubl73/zi+J9FUs4rJErMy4EcFdxe5UpjlY+?=
 =?us-ascii?Q?jngVj660O0lAB8J56veD8AQE279f7Ilx4wiKQX855jShOme3qSeUPXSC7a/6?=
 =?us-ascii?Q?VNt3RGGPoIj9OkAougzKI5q7atj79Dl3R4H9Mm1P5cjkkcTq5CMTDRXcEcq8?=
 =?us-ascii?Q?qNCiHwhQ2Ey9LQ+PIiC+/GSNeQysctRnS8GI2xWZPo+TZJmvLNvqRC+So7Bt?=
 =?us-ascii?Q?+eRaIbcOoJ1VbPFDOBHeIeE43xphlmGspAXeqqjTwA5p//VJN5ugN7tgna9Y?=
 =?us-ascii?Q?7VWV8Rb0YaWt6VFn+5t/tqSOrl0Z1kM/WnCDY+UzTYCNOVNHsxN/ZRc70SDZ?=
 =?us-ascii?Q?YCHrsZXlAhk7sIy8ZJ6OyCIeUcf+WSUXlXkeb8g4/omlyHELuK2GxGyaEYVL?=
 =?us-ascii?Q?egWgppJdznWQmI0exPce4D1R2i2aX/BDLxb3XvjB4aSYKV7mPS7FyBhAnJ9W?=
 =?us-ascii?Q?QD6/oqds7KE6O/3asPtDf5ucgkK/cWV7q42G6rrsfirWNjNeR6/yBC7w0omT?=
 =?us-ascii?Q?AIbzPeEE5BsnJeBrqKCI5+w3MpoMSGPLxdNw31xjPpfbPg+mBbegybMIORhI?=
 =?us-ascii?Q?6ktewYi7JqJ+YvqdD7ZQBxA8VCT69PCxZzh1we2DWteeYmAyektFC0ekxsEW?=
 =?us-ascii?Q?4UzvmG3t358OW8qV1nHvud4ba6BwtC1EohEvjYVbR5mqzh5eMnuThG1HOisI?=
 =?us-ascii?Q?cf5jvICilVzrQssjncYZYv/oNAGQa0C5Vkbl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8AtxUR0oSYcTeR2wgH28mJ8S03mBUB+m/7EctIpFH1Gx6Csls+LWo576lF89?=
 =?us-ascii?Q?tf9k2bfiwOyVtnGgk5d26a4mUgVGj5Bdsi4iX5LqmMr4W6Dx6Q5mMohlfuAm?=
 =?us-ascii?Q?EMN16AC+H23Lr02whIJOtTr+3BaC49Pn5RdVhiU+m6/Opkt8EGRiZW4Rd65q?=
 =?us-ascii?Q?Ajf8gM6XlPRIn2DsVfX2vlg0dzH8nvU0B1twzjuvhxKGpI/jXvJshStyhO7/?=
 =?us-ascii?Q?twzM0QRFHvngX0MPwtBQi8cx4rb3EbinjxCRLtV14FCs/0AIclRZIzmVYNhV?=
 =?us-ascii?Q?ND0FaZYQBR5pyrMRqgMT68Okpm98wVjEbOuuUM/zlwNm6ucSKwhOJb3zFJlB?=
 =?us-ascii?Q?3ybHMHAz5OcM6uAjPB4bejo1un0+BUpHkjnZ9LEF2BGitWaCvMWdlLKxFift?=
 =?us-ascii?Q?786JH434ZzHSbf5fhXe2+cW/4hzpqR4MBC+qYvf6aetFCt2h8+TbGEUlzoPR?=
 =?us-ascii?Q?IQdDfxounWI3XYel0dVJ5JQDiXT4Bywszf/hqljojD0135flv9M9YHGfsuzQ?=
 =?us-ascii?Q?x+lRSp+PmDKhFD9fm8XvrTslf1RX+OcZDKyyH+SfJqxKIND7Qm7Y7NDQ+415?=
 =?us-ascii?Q?S1lv/VElcXCZE/PP21KWz4wnFB9+Pv5aI8R0octOFWwPuIA6RLZKHtbnd0Jk?=
 =?us-ascii?Q?N4vTrhVDk4bcly+EZetAMm8jceVFaB3+vULUdRmTQKZjWe7gXryEiPqM/Zci?=
 =?us-ascii?Q?c7lUnEsfumwqLtEoNzKnfqXDks2r9j/pKOtxwdWFJR+3aRdNAlq0QBGFT8Jg?=
 =?us-ascii?Q?bIDPG9X89YdW3BJPzNLhVq71uD6yd8OTKneMRfQggTUkdRsjmYoVraUPwUf/?=
 =?us-ascii?Q?EjSWIcSHJNvxgnpS//E5hMpDftr9B/G28bDlcqz9JZp4U+tRAjpjL3ALqHjO?=
 =?us-ascii?Q?Wz1BhGtMwBOWW9oMCkAiYFkrDtafpaFsT2qZ9ATSBvVXRszD6yAKx4b93AoT?=
 =?us-ascii?Q?zwl2VkK4QD+Qhn7HUnT4kIb5eYKAbhQvXFITKNGh7+/C9rDegRhrYlPbUxez?=
 =?us-ascii?Q?DmhVhOv/mF5fyzB4fMaanFDc5moFalcZGaV7qC2ShyCESsMQZIi74OEGWIBi?=
 =?us-ascii?Q?I1oCc1yIxv7e0ASTlgrbKvtMgtOhNdxb42g5ydWIcupJGMq0ANFmFHCaUJUH?=
 =?us-ascii?Q?fknhHGTDUCzGWL3KjD6lHL79EMnji5RGfxpbIjWYsTBaKe5YAjWC7PrHs5Ef?=
 =?us-ascii?Q?h/12D0RkAXzm5vdAR7vR5KA/KymE1xS3uojpFS7gTmvbFURPWgLpUEek2FEf?=
 =?us-ascii?Q?5qkmpUID3NifOcEuSwdWb5K6gOFyO3bmOhKOBxp2ejIq9FIeFJ1kP27EzED/?=
 =?us-ascii?Q?Wadhau6gE3EaV4TRzYEx+d+7PDB+1FUCZkK+oKeaUm2aQisyDAa3EwdhfVsh?=
 =?us-ascii?Q?gE4G4E2LC9gjYrkek/qW9iDB4MyJNtOzcbM3/g16WgHNrtLtkjuKLoCMduno?=
 =?us-ascii?Q?aczBlrmtzKO2lrIvFDx6jnUwx+BjcHTOMWGxWFoAlEx4Y15sgVBC/0IJJEmU?=
 =?us-ascii?Q?SOLWdj9yYGwGtzDut54OgNNMI3y0mU3PLCDY5jWrdWkVpPjIpd7TV5QatWE1?=
 =?us-ascii?Q?a3XtZE61Cm/2u6R7RGg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73ba428-aa58-4742-2072-08de1dcd13c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 07:12:57.0421 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OgU1WCxJHMbBu+ujaTc9lx0jHXHuibhvkTHzJDcfm4ySULWi4kAh3lK4Rsjvenq3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5922
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

Reviewed-by: Emily Deng <Emily.Deng@amd.com>

Emily Deng
Best Wishes



>-----Original Message-----
>From: Li, Chong(Alan) <Chong.Li@amd.com>
>Sent: Friday, November 7, 2025 3:08 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>; Li, Chong(Alan) <Chong.Li@amd.com>
>Subject: [PATCH] drm/amdgpu: reduce the full gpu access time in
>amdgpu_device_init.
>
>[Why]
>function "devm_memremap_pages" in function "kgd2kfd_init_zone_device",
>sometimes cost too much time.
>
>[How]
>move the function "kgd2kfd_init_zone_device" after release full gpu
>access(amdgpu_virt_release_full_gpu).
>
>Signed-off-by: chong li <chongli2@amd.com>
>Change-Id: I3eebd7272b8f0c85d08fec80acee67a2c9e59e52
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index 1e8725abcded..9aacf8fdb38a 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -3314,7 +3314,6 @@ static int amdgpu_device_ip_init(struct amdgpu_devic=
e
>*adev)
>
>       /* Don't init kfd if whole hive need to be reset during init */
>       if (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
>-              kgd2kfd_init_zone_device(adev);
>               amdgpu_amdkfd_device_init(adev);
>       }
>
>@@ -4929,6 +4928,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>
>       if (adev->init_lvl->level =3D=3D AMDGPU_INIT_LEVEL_MINIMAL_XGMI)
>               amdgpu_xgmi_reset_on_init(adev);
>+
>+    /* Don't init kfd if whole hive need to be reset during init */
>+    if (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL_XGMI)
>+              kgd2kfd_init_zone_device(adev);
>+
>       /*
>        * Place those sysfs registering after `late_init`. As some of thos=
e
>        * operations performed in `late_init` might affect the sysfs
>--
>2.48.1

