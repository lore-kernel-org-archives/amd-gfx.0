Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E488EC32771
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 14:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0177110E40B;
	Wed, 21 Sep 2022 14:00:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE2A510E40B
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 14:00:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JI+qvNJCn8hYS0OczkxsBNNHrevVJIiKgxiA6Fcz1H7ludB5jRsAyZxnFybq5I2YCMyzhgAPIom36ph0AbNRtXTm1QQEnWRYe29uXGZQ28+/oJuhKg34qdP0r8C4QLeHuBggdnn/dsW5Hs0ZTKLDzjOSn2M+oh0QJLJFARNJIRYHjGG2vlCgGOGaEh3shCO7aZbOCCfkJZMDPCjCcUm4jOMyEQaibXhjRzTHdsrY2XSXk1ZLczwkSDb57FET3FbE5JSF4oSjNNXCza5/n5knOGF3rgTHGMB9caiFNTyAnkTFQ/7/9h+q68vTInPlWiZHZqc7PpYNOXuyxqgDL7JcVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbEt5LxVr4hgEvWXKJWkASkrDsbaBVqf905Yemqwb9g=;
 b=GHFtiX8N8HWqYXq2KEYng1lmdrNgxG0Wi5YL513QX+K28pEbq/2sGFxmrQx1U6pCspbs9FHIILr1UHeaxvvvMWu1P/Kk3GQGsCr+VbYKwDhjG7a+FiJmzhBSrpBHM306TDUcjZ7IKEZPdo6nvyyBG1MvWfBuRl6VLDnv8GmJvBO/iomx4kp0wDc2Vhl47wvFm8TuFt6K8/6yJFe9wEV8sCu1L3h7AtkBylLuPII4znQxAIduEDxRYLPe+cXf7giYLb6lFOZP43Anio2bH4qSdRRu8my5zIAixTUzbwpX2MMbr6frdzDEN8HUcyfhAC47dazY5Is+4y4SKPZiwLqmhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbEt5LxVr4hgEvWXKJWkASkrDsbaBVqf905Yemqwb9g=;
 b=zZMnR5rCQOAeQXPP7Wen4ZJT+QJwd7M5jsYavLOpm9L0HxBx4PcBWhP1T6caplfpyhTSAXRBbFuyqKQpi2TH4939pEDjvOlCreuw8Wt8tlkte66PuRAgktDmkdiXdD4JYXR72WAkAeb/IWXUDnpw0LA5Zft1nLdikwTBFG/oM8M=
Received: from BL0PR12MB2465.namprd12.prod.outlook.com (2603:10b6:207:45::18)
 by SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Wed, 21 Sep
 2022 14:00:42 +0000
Received: from BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::2cd2:a792:2917:8df6]) by BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::2cd2:a792:2917:8df6%7]) with mapi id 15.20.5654.017; Wed, 21 Sep 2022
 14:00:42 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Use simplified API for p2p dist calc
Thread-Topic: [PATCH 2/2] drm/amdgpu: Use simplified API for p2p dist calc
Thread-Index: AQHYzbYdmR6z01U7Hkum8EHdEWTs/q3p6Vyg
Date: Wed, 21 Sep 2022 14:00:42 +0000
Message-ID: <BL0PR12MB2465C8D211B939BC1733202FF14F9@BL0PR12MB2465.namprd12.prod.outlook.com>
References: <20220921123027.2866204-1-lijo.lazar@amd.com>
 <20220921123027.2866204-2-lijo.lazar@amd.com>
In-Reply-To: <20220921123027.2866204-2-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB2465:EE_|SJ1PR12MB6169:EE_
x-ms-office365-filtering-correlation-id: 8e8c9107-6df4-4fdf-c8d3-08da9bd9abed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: du00osw56tB3UHGS/s1yD9CB59uxWsXlCX4udkchgnmnj+FLaFhj0/i5A0yJF5DxFtUSrbfZvOtibN0kC4Y0zoI5K3MdMW7OLxMfrIDd6pxiIxuuFZTjcfOlQQfVQWPtgCzTvC/I5PrQHgLWj4EmquojEh6FVBKzIU3i0gYGIS3t3L849fxwNKX6124UQ7UQPaSJ5Ro9zZ1EF9f7GJNPTEWOtmVl2fyWvu79LCPRSkum/hHiGImiyQKQtCFuSam4fKUwl/Q24qjH5DHC9uXkftyHjzc54JuHVAh9v4d42p5UQZmXVonJ6/Fhu1EzoMWdOzOfjYy+lO1pUwzSfZXGGxLtVUkJfHo/pcuD/RqKgHDQvG0vbkOUPqOERBWcpvzp0nGtOnEMjkiX60d6BiTY95F6fkXFWG3qQhded4dL8XgQUM00PIT74mC5Pv5rMEF4euTYdc2jehV0Uj/aFEUgL4jDq/JeeDuP/EXlaR+ErcXYdTvxSQjKMRtGGLjmTE6AbR8HJlBGYbdUduszEupY/Dz4ssG26LQsno1pawAEaYObTgJXdGa0x5vaHTd7KcUonFIGaVb6h0rbSdR/V+8YH30GXopkyIUvS4yNSKZ6qiwsy8ZhgWPIEnL9VJWZANjHqbo+9nQlQrqUAkUIYs4yLC7iZf2T1JUla84IebnGa5zlOwFDehIzVygKIroQ470fNw749tIhc+vof/stZWGEcaL1MGCgb85C55GWOcZyRvhF+kafxJt15HnIt/UCqtZS71QFTihsJB8AWvgv1bOCWQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2465.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199015)(55016003)(71200400001)(52536014)(5660300002)(8936002)(478600001)(2906002)(86362001)(41300700001)(4326008)(53546011)(8676002)(38070700005)(7696005)(64756008)(66446008)(66476007)(66556008)(66946007)(83380400001)(6506007)(122000001)(26005)(76116006)(9686003)(38100700002)(316002)(54906003)(110136005)(186003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8whFLRl/4mLqpXnwDJik03b5o8hd53XPXGpxO6Gy3CC4eTx9Up9zrKEw6/DU?=
 =?us-ascii?Q?CeB+JvAKRvbl72QNuCTZV1gAx1SSFrfl0BluXoZ80BsTt92F1vSXJDUn62rT?=
 =?us-ascii?Q?NHYBNJqq3P2oX8SiaF2dSr2yUAyfCcexERGMwiCXDzFCWB1S4vRD8BkALPdi?=
 =?us-ascii?Q?PdgK/PPQPOy44tnwK6RutD/1Qp97FXLF32c5RLOJ1aN63GGrOR4iDoGlX+Xf?=
 =?us-ascii?Q?1jPJKdWvhYrHek6XgeelHka40JqcnqFJ3pu581+OgodlxT0MsLwxReMJP8lz?=
 =?us-ascii?Q?oIny5pRBzZetT2oYwwwH8EFhyOOxMC4F85/qtcDZ0ix5r11HEWHt6kZM1to6?=
 =?us-ascii?Q?PdaLuhQ0v3cJh+rTBPtK7loXDU+6tDEStwN1I278p1gin2SqIazWKC6t7x+p?=
 =?us-ascii?Q?DaRCPTyvQESe66795e+w6bzt4OCJ7L0Iin00ZJRXwZxOKQnX2Rs1aFCZfji2?=
 =?us-ascii?Q?KHGfLd8ebbpJfTOj5uyECWsXxRoKxpc9nvMgiTfJ3siP7SHMJAf4qiUdk/ET?=
 =?us-ascii?Q?8Kd3mMLGAzLelOsQE1JEIE/Lau8GIrzrIkVXm7Bg9PI/tH73CbHmnXF3vYvD?=
 =?us-ascii?Q?sOmGbNYOmUbmUS1z6ubCcLq75Xpke1ICdnfhxDARpGJGAVXmggJfyGEJdtUc?=
 =?us-ascii?Q?VKXDIKahn1O/B2gROPJgc1tMYX/NCEimmoBloY3YQ9/6vdWmpAQ7K08sCT4D?=
 =?us-ascii?Q?mJBMrE/FvsYyp8FF9VSB131jt8BLhxYrxtQZodDPq8mQ7TC5cVc7xVoK7+2v?=
 =?us-ascii?Q?AJUAoo/u3QQJtA6T4kB/8DIw35CpvHl0GhV8SkMHWEPG7FJhiFGHDUXhXN9/?=
 =?us-ascii?Q?d9gJptSx82yERflhf0/RhOb39x0qHm/E4qGA+7NfX5WpqWOiWahZU25upKFc?=
 =?us-ascii?Q?Q2rQVAHz3cwaUYxu/WwCkN7uDNRnoknJDw/9Jg2wLEDLFpC0EiU0nzf76BvN?=
 =?us-ascii?Q?dTz/aKKxtJKtYJSnuad7iWxxGQb34m12HjbBHWm43PByTEllARYZTYhIYogH?=
 =?us-ascii?Q?9xUO7J0wiWKyQjXOnkaaGwz4BGxG6/3DXEN34pcqnFeQcFUJ/R84AQsea0Ws?=
 =?us-ascii?Q?/Z0MrQ99v3Gbyq+QAtWzFKMOQrb10nZcXJkazLjOLpDVJwRWdbkcJgufGN9Z?=
 =?us-ascii?Q?OmGrib6uu0cDNtA3YKClG5TEeC6BwgMfavBgQW8yBmo2rB5fR58fol1zD3WB?=
 =?us-ascii?Q?pvZV+ziPjlCDRhMpwEVwifYQzVZmKpMAwC/XjIq+MfLoH35x2K/ysqD5N4RF?=
 =?us-ascii?Q?tu0MNnZ3I2tR/8jTb/AkC2mze+W9GAcaFUOFA4XJ3KotxCf9TV94YUPwgVOz?=
 =?us-ascii?Q?GsnIqE1lZOMEjYWcReAcM3md/dPxaYZuJAK2bzfkaDbTLwEDigF0n7XZaDHc?=
 =?us-ascii?Q?T24t2cxlQDnUDjpk1ux5vqFjtYbiCuuQ71JBhYZ5/t+xJ+Dr/ucn1SYC/JJ/?=
 =?us-ascii?Q?ACDwfSit6iHmOezk/89YkUwFrcV6QddXZd/GuB1O6OnJ/r3Q3rNGN/kpRhvL?=
 =?us-ascii?Q?5N5/Ft0r9LqOr0GKRTrOtlyH3lNhMCdkRVpkwq4iZ7WNBTAtcYCQVuLyW5q9?=
 =?us-ascii?Q?p/45IMMFG2dWPXJmcxDyJxxnZFIiYukrLIQ6QabA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2465.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8c9107-6df4-4fdf-c8d3-08da9bd9abed
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 14:00:42.0729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kPofeK/QnI+TvnvhMuf2dFePOybNbbwLT0wdTdE25CVO+iLfK3I9TPmxw3j1ZEIW+qCDWAj0xqlgbtq22hsuLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Bai,
 Zoy \(zoybai\)" <Zoy.Bai@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>=20
Sent: Wednesday, September 21, 2022 8:30 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Chen, Guchun=
 <Guchun.Chen@amd.com>; Bai, Zoy (zoybai) <Zoy.Bai@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Use simplified API for p2p dist calc

Use the simpified API that calculates distance between two devices.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 6 +++---  drivers/gpu/drm/am=
d/amdgpu/amdgpu_dma_buf.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index f600f3a3fe50..ec1023e7b0cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5576,9 +5576,9 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_d=
evice *adev,
 		~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
 	resource_size_t aper_limit =3D
 		adev->gmc.aper_base + adev->gmc.aper_size - 1;
-	bool p2p_access =3D !adev->gmc.xgmi.connected_to_cpu &&
-			  !(pci_p2pdma_distance_many(adev->pdev,
-					&peer_adev->dev, 1, false) < 0);
+	bool p2p_access =3D
+		!adev->gmc.xgmi.connected_to_cpu &&
+		!(pci_p2pdma_distance(adev->pdev, peer_adev->dev, false) < 0);
=20
 	return pcie_p2p && p2p_access && (adev->gmc.visible_vram_size &&
 		adev->gmc.real_vram_size =3D=3D adev->gmc.visible_vram_size && diff --gi=
t a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgp=
u/amdgpu_dma_buf.c
index 9e2a4c552a4a..7bd8e33b14be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -58,7 +58,7 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
 	struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
 	int r;
=20
-	if (pci_p2pdma_distance_many(adev->pdev, &attach->dev, 1, false) < 0)
+	if (pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
 		attach->peer2peer =3D false;
=20
 	r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
--
2.25.1

