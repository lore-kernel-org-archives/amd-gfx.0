Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8198CD5BD1
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 05:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E432A10EC3D;
	Thu, 28 May 2026 05:33:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xjSTuBzn";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011014.outbound.protection.outlook.com [52.101.52.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D343110EC3D
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 05:33:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDH3eeSEfcJ1VtFH54dJNL5a1MC3Vy24ex959xHwNUsMZWnXx8k4/0piPzSzgdhOas7j6we7En9dxWQNvtpdwCM7HdJ1kTIksjDAfs2GgUIzYxO6tpPBfRzbN8rzV2A1AQ+EpfymsB/rp3GfiCmjpguH6UtbDyM7pPJ/bCNtnz20WqEVHzfC4aKGqGdzr9PP9g1yKFWZlunBEmh+KuGhb5Rl/hi5zAbsODw9ry4rSm/YsaNkFyVrlCiG7Xa04Q/GCGkyISdjzPZ2vnm2Isf0k3xZp+zkdD2mZHdC+m19rg8PeSPueZJeGBRVwKFZ8w2wk+15qu1lGmF/FjaBYkj5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tW9bVpXvEnTOnhaWHexMTQfm06O4TXG4YsHI3C5DHdo=;
 b=Bgq9+KrhrcmXPr6Ag1FuRnZmvWkeycUwBGgvon4HgsNLzP6M8A9GMGsXE9zGuYK3nCLgri/qhczt+Cwk9ZDtzvCKzPhOacRowTExlNCIAgLsdoHhEDJyBM967oy0xSpmKelTqzyUT5Uao6cgIQdclTWnK3KdIiMpsTDtQmi0Bkp1lA3AZN+0Dn3RGW6+adJNi0KWKYHI1DsRfWbN8YMUtNx0jQPfqINXJNCOc4WObDywjaNvzoyuopdYuuaKu5PdV2fZp0ZBfNrr4L7xwKtmpMDCPLyR21Nivia+nZViMzvc/+l0Rk52Roysj/InPnpE+vZrrB6vbZuH5AKmJXQBEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tW9bVpXvEnTOnhaWHexMTQfm06O4TXG4YsHI3C5DHdo=;
 b=xjSTuBzn6PIdJyxOvTvU7MQ7x3c+JpifGYgcdux/Fayx4hdwTveeF1ppGixRYRWGSkhngJu75mMv43b04XubySmH5OE16K9vSQmVNM8fsDfYVndNWwr1hvl/Z0vsuiLF0ce2vkv2jpWyp07a7ZU8AjDeJHUkzes9SvalYNOeIrM=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS4PR12MB9772.namprd12.prod.outlook.com (2603:10b6:8:2a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 05:33:39 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 05:33:39 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, 
 "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 8/8] drm/amd/amdxcp: assert XCP platform device names
Thread-Topic: [PATCH 8/8] drm/amd/amdxcp: assert XCP platform device names
Thread-Index: AQHc7ltYCGO7hBK/kUaQNW9MXj2AprYi6kdA
Date: Thu, 28 May 2026 05:33:39 +0000
Message-ID: <BN9PR12MB52571FDE067514DAE763B4AAFC092@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260528043408.237209-1-candice.li@amd.com>
 <20260528043408.237209-8-candice.li@amd.com>
In-Reply-To: <20260528043408.237209-8-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-28T05:33:21.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS4PR12MB9772:EE_
x-ms-office365-filtering-correlation-id: f7cdd7d0-1a47-4ca6-2f34-08debc7aac13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099006|38070700021|3023799007|22082099003|11063799006|4143699003|18002099003;
x-microsoft-antispam-message-info: 6xtdMYeHXSnugAHV/mFekVuFwowq6N+Uc4YebMrQLklhaDHZerIcD7DcaYK64dMYN73PuAeD2pekzp0ffJkLXmvBKfhsJya0LDZBzGCp+50S9H9yV26VLtSZhaT2VwgVrCLRuKsyXMFeAVz3u2vnnozm3OWXau7IOoGMjd14eK/BngLGsmU5dtqUMYz0zw22QzNIdxD2lrm9SmS2+eqqMqVL8TfWoBND/JTwVn1CTiNvYhByuxO3lkMzDHfNF+Gvn8VXc7uZ/k5yWpjaoagMlAftee7Qgj9vM8Sm0nftmshHEuQRZdieBlS4cDMIJYCdlQ2XKlgN2O43mtAM0FV4P/i4XVSW1UiGbIdxFrE847GDu9NGVK7qnVwlEQSZgfJrH4chYB+WmapgZ779xePh6W4+2ptqE8bKvZJN35KetcAkTas6vEu6k+t/TyZpgK2kf4y7LsllzmxyBGUuz9kVTNGVZhtKICbcNXrJ8e86UZKgf/VYOcQNbgauzzCIQlIeLm0wS98G4bn/THmp2mtj4ZfBTqio0hAZxbst4yDek5AFzwODZrSMtePMlYiUXN8SlZ3z6stjst7rEGZNH/fxKQv3exAXCov2mxz4kjXscBlwL8hVNsKJivQzQs1JL8i2qLWuzE5Rn8ViaItzRrycUnyuiUCpWCSd4mrIopFkeyupL2e7/BCnuQ6rVkGkeC1gd2HSnV/iW1vCpMhF9+vd/N3+AKduwDO9ouCQRZfy/uWVfVnA9guwSWxvHXGP09e+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(38070700021)(3023799007)(22082099003)(11063799006)(4143699003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XU1BxQUfC76FNGisx5XM+CcOQIGVOFK1ycCl5Hu3RthhiU5T2WF87D7gn1KQ?=
 =?us-ascii?Q?57OyvQ5fGJKsMH2lKKjXV/xas0gaoRFxH74d89xdwJKkxHcbgp/zcvxMc75T?=
 =?us-ascii?Q?7UcvlUAw2Vkt5D+l+zg2TiSQNiPYwYRyKpxy8KXM/z8edWF8bEmMV9D36P9Y?=
 =?us-ascii?Q?QXrRF4Zo+1QFTyRPiMbjzHiXl/vW501tK+NNINx4FGrb6SF9toN8cc1cBTjo?=
 =?us-ascii?Q?E/qBMBIyI7u186g3tgbFqtwYUH4Au9PDALeN3IRSANKxBplyt0hq7X5V8Ot1?=
 =?us-ascii?Q?0IEl4ojjHFvqiqncR50OEGHDrIuYNVGoO8SRc56swJsfqoCt0NAy1FmZCAcF?=
 =?us-ascii?Q?gLpR1ubfl9oN6yTcd4PFAFGYRePTyLQgLL5tO3ZAq8Btdj6JZQO6ITqoq+ta?=
 =?us-ascii?Q?Xxf1S/Tdet+i2Ywyyg0+OIwkvPa0rzjdV1caljhK33WJgEke+Bh3STaTavqe?=
 =?us-ascii?Q?vc8P9G8a7D8V1Q+EXLR94JaO3408edHWT9zVUfhEqcq9b2Rs9AYeibvKZsHC?=
 =?us-ascii?Q?L3eRbvIh+YFYzk5LILHdwhWgc2Kx4D7HsGwNQech4HOQ44/qJ1445Yc4A72o?=
 =?us-ascii?Q?QerUcYZu499WijxrU/gxxNHeor82zSEtfrnSTqzLg+YtV+zgc8fVKFm8VuGd?=
 =?us-ascii?Q?fXFIklWreINCe4uiOnI6vFCS/K5m7Mnanb1i3NSBA3BQZX31wtZ0jYeB0wxf?=
 =?us-ascii?Q?SPAI7TMUr4ekFf7LS/SCOLxN+ypcPYxQ6ICyaSZKp5hQuHd6NNnfvUy1Y2Ir?=
 =?us-ascii?Q?g3IOFaRZaVPHbC0fj5FAxXCZFRfjkD60J9d61eZdMeEPDkuagm61Ixk5i9o7?=
 =?us-ascii?Q?0XN7OxBTzuRbJr/mq8thrbBwRPlCyehnE8ymPIzK3BYYI5cFyt282Z0kOoD2?=
 =?us-ascii?Q?+RetEbhj90YZNi/pKIEwg413jvJZUr5asQw6ygYKgHdr6EB5YaTeMZLy53X4?=
 =?us-ascii?Q?pPs5aZj9T6Qk89SV93G/nlip0vWWAc41HVjSLosb4B9+UuNJ3Ciwa/OGxso0?=
 =?us-ascii?Q?I/Uvk6QSWfV9fEn5fM3LoHEvPIhKVJSZX1AsebU6os29QZXhq12SEnIHWURZ?=
 =?us-ascii?Q?qnPgHsfkscY0+a8nfLPv3lLgAInG+wWQC58kp8wbSxAKTQec779fH0v/LvNj?=
 =?us-ascii?Q?CY+zelTdgobPYYgRXtNnzrH4PY/vH7r41Ysb8YbBkjByIdoiNOkD2opyhY+C?=
 =?us-ascii?Q?bW4dSmqKefMQkpO2uuTa7yDY2GIQMuz5KcOg3bT+amAkVgw/o9N2UGfGVpaX?=
 =?us-ascii?Q?bAlTkT5Kta+4XxSvvCNLZMqDGpPgxgoIBR6mgixsEJ09z9xc6SG47m0s/qqm?=
 =?us-ascii?Q?vSxQrqKYQDI1GteBLC5GoxzL8qDzMQxMz5bor4n7K6ASqySyY3TtPsWY3baO?=
 =?us-ascii?Q?XkQuAVMr/pLv9PQbYUXwjx13daJsnP5nc0h3bjPVN86Sy/EkZ2yPlT/ji54w?=
 =?us-ascii?Q?uOdGVWtmDEsPUCc8kwOh8Aa+ka3onQwxWkHGLWtaXyOJUTqMd2cwvZKGfIxo?=
 =?us-ascii?Q?E4AhiMvrGKMLNAE/R+WrKVAAAK2RnIwS5YwAn+qSgEIjP9+E8YETB16COIh9?=
 =?us-ascii?Q?ZOLhdWbXC6tByWfmqRg/CeX2CRxbawirnNCiShC/sxLrYFdiaCh40HV7aGqX?=
 =?us-ascii?Q?JIkQ8ng8TaQvDwSfb7ji2uWmHfvo8GJ1psb1wUGJ1T0jMJiz2u2pIs7aS36n?=
 =?us-ascii?Q?y9c6TV7L8VLEkia/tOi2t/S74P/zecQwuDBddrhCNc/vueSV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7cdd7d0-1a47-4ca6-2f34-08debc7aac13
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 05:33:39.1608 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IIr4WVcmjb6XRYqG983iNH5TGf4FrhZq0pfUfbNlFChd5SoXxxCtmrWkWl+KN9jH93nsrZmT3c3y70OHasfpgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9772
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

AMD General

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Li, Candice <Candice.Li@amd.com>
Sent: Thursday, May 28, 2026 12:34 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; =
Li, Candice <Candice.Li@amd.com>
Subject: [PATCH 8/8] drm/amd/amdxcp: assert XCP platform device names

Replace the fixed stack buffer and static_assert with kasprintf() so platfo=
rm device names are always fully formatted.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/=
amd/amdxcp/amdgpu_xcp_drv.c
index 44009aa8216ed0..995cae6be144a0 100644
--- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
@@ -25,6 +25,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>

 #include <drm/drm_drv.h>

@@ -52,7 +53,7 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)  {
        struct platform_device *pdev;
        struct xcp_device *pxcp_dev;
-       char dev_name[20];
+       char *dev_name;
        int ret, i;

        guard(mutex)(&xcp_mutex);
@@ -68,8 +69,12 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
        if (i >=3D MAX_XCP_PLATFORM_DEVICE)
                return -ENODEV;

-       snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", i);
+       dev_name =3D kasprintf(GFP_KERNEL, "amdgpu_xcp_%d", i);
+       if (!dev_name)
+               return -ENOMEM;
+
        pdev =3D platform_device_register_simple(dev_name, -1, NULL, 0);
+       kfree(dev_name);
        if (IS_ERR(pdev))
                return PTR_ERR(pdev);

--
2.25.1

