Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DECC25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 05:47:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5BED10E3C5;
	Tue, 21 May 2024 05:47:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jZaMuDNW";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83B9510E3C5
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 05:47:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqO3GefOcIbnXwV0nt1G05EtJtpB/ORyglRg4Jyioy5OpYv40ZG82X1+f34+XWuXO5Pn11z6yyOQ7LuxxnaGhIX2pGQsci+rIFDeH8bsNJpdgBfbHuRwVvPoSfp5dDai/SzGWp7qvDdDUG78h7Pi4YNbTWJM6pVjBp7pDkn3dLd5ymc4NkW7ArHhO7fWNc+mhZ42ZFWAwA1lL9hWjCFDBcmJLm4/KOSHOZu7COGY6XNMlPYao2omCfHmb2nThlhbLFvOUjDrag/aM6CG4Gyex2bchBTtvCMghU0lXuE2NvB5j862e/rRkVP9slolda/chjcCmTJufE4YAj4GkCVk5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HamUvn2TWWQSD2xRK5r9A2T+le4op0UWmWnhyLYjngU=;
 b=SgzmA0GcMU2deyI2XfPierFZBLuMdsMMKF9O1Jkm3fypzNxpYl/4WQwx0QNNn4SV2W6WDqhSl/ZxyFZuxRsDl5mvOeo4gkd8+T/Z/oWwwWTe2/X8I3iOnJkTlQ7StcriGYqysFPV/UZIRm4cU+M9WQEyww+t9MfpAFSMNARLado/sLdMv8Gk2/sq6luK1Zb6P9/uv5+JNQm6Bno/DSpQF8hHfxlA7CvnZ6q4TFCPUtnh/lipWb675ktZFDN0EreMkR1ctOizfjD0nH9H5jXJYhEHObSYdagLk/EokGYbVR/DVgrDYmasuS+FU9BunTn9d2uWtP7xTGIZsecpj02kfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HamUvn2TWWQSD2xRK5r9A2T+le4op0UWmWnhyLYjngU=;
 b=jZaMuDNWwIYcFeSMACAgbaSfvshDZs7NTDfADKbY1FI49QlO5Zs4cFbisfJ1J/RkA+p7I3NlZbBYtjvw5Hufd3h+deK9H1hJ7xOU6Y8qeMDZvWtPw7X1XrDmGt7MGEdAdDhb4b5XlimTj6uglH6A1JkTabQl6doTFd4EkU5dnfo=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 05:47:48 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%5]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 05:47:48 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Min, Frank" <Frank.Min@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>
Subject: RE: [PATCH] drm/amdgpu: program device_cntl2 through pci cfg space
Thread-Topic: [PATCH] drm/amdgpu: program device_cntl2 through pci cfg space
Thread-Index: AQHaqz7TLPbkKJ28lk6jMq5ZVhobcrGhJ5AggAAGoSA=
Date: Tue, 21 May 2024 05:47:48 +0000
Message-ID: <DM4PR12MB5165BC1592DD8ABE7AC3174B8EEA2@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20240521052004.17905-1-Frank.Min@amd.com>
 <SA1PR12MB5659DAB6257465D37B5DA89DE9EA2@SA1PR12MB5659.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB5659DAB6257465D37B5DA89DE9EA2@SA1PR12MB5659.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ea865aff-74e2-459d-90d2-ca4121ca5c4e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-21T05:23:35Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|PH7PR12MB6717:EE_
x-ms-office365-filtering-correlation-id: ef300522-c03c-4c56-085d-08dc79598b99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?slEt0XtTuP0yrj6qxFf7EPcNARBrqZz4Nvblq9gqLtvsDYK6RcVXGayHdXJR?=
 =?us-ascii?Q?+NqMtpj2yjjodVlc3AyNRo/QzrDbxwrv4XzY3M4JTYAjKc4OL18ikjJmFhkX?=
 =?us-ascii?Q?+Ds58e7FPt7OU/mGJmlT5UKBo0aMV4dGvzG6y3zNdjeO394JtNq69hQY1V/J?=
 =?us-ascii?Q?XGKb1MKc7OhpBKSgeU+wIw6jCPX/jw7+6D+wgRjHN99EdhDwjwPjMncj8012?=
 =?us-ascii?Q?DJMAC8ot8G/PbVovLCpICS1FYIqDjc1mlwM0st1h6DLlE6Y65PHODLAZND7Q?=
 =?us-ascii?Q?tE5AtSG8ac+JMbv8nO/oBQmSPo3ZiPYp4Ad5KC2MAKqjHnFgiaJgESCzdWZS?=
 =?us-ascii?Q?BRwVBcUxGHL9XTbessLh1Q0R+C79AY19ZvfDfwGUZIDxj3anfVAFtKgWwSxx?=
 =?us-ascii?Q?5jAYpa08YrFEBc/I4vxrmDkeQdJjIiO1xP5d3tUS4iYilwKojq++dOh/rNRD?=
 =?us-ascii?Q?qyISrkPLcxpo89T2cmXyyBgJig+CejuPpngXb0pEpAQAXYcS+LVBbeznNUSR?=
 =?us-ascii?Q?+RLwilZI/P8WiK4QOfwZlHvPmPMz+hkp0uY6X30Kjc5e+kpccUENNedd+z+Z?=
 =?us-ascii?Q?GfV6vHqZhH/LVnVt2tK27v9QAw3M7j9vcfP2kbdqXehHRZFBnHvQr1l6PKT6?=
 =?us-ascii?Q?4elE58flhGIO+bFGUxT/+dmCzKuyyBvRQq0KFGF0ohmtNvHrrqzseUatwVAn?=
 =?us-ascii?Q?rYk1TWb+yngyLRlOQCJylKQS/X5MiNLUwVnDPxpMU7XgPOJ/uascR+fCybL9?=
 =?us-ascii?Q?nSmfQxjx9xAQKpG9lJ6teMMdf/3i9VOyT6cCfJtfHqNAYE85BexbV75k09qj?=
 =?us-ascii?Q?pSNnvJeyYYDLAF/eEqGYuQBO/QtC8gObSM2v/+ZF5AJRj4XbseJGuvdRTmH9?=
 =?us-ascii?Q?mjlxsThkKyJpXiNyy9pN7DlE1RCZ2FiE6sVORcrEilg7dZJmRuLSaatUrFyH?=
 =?us-ascii?Q?kZTRt607SEJPlGnHtf22sclizfe8lRVhhl1k5umiw4X/UdQfRyu7uujNlGjV?=
 =?us-ascii?Q?1VGx3NLiWUtI8l67qDXkcRx15DvEEyuYk37laF/hpInazsv36v/72P+dI1Hs?=
 =?us-ascii?Q?i7zF+KClrzXrI7xvwmmQJgLAV4oF/xXcEptoDl/c2djASSrNLDPXNyFoTBRr?=
 =?us-ascii?Q?tmouXabBt1CEpxsY9yPPdGFku6Fw8rSFylKdEdl7MrgGh9TDV7bikj3HLEp+?=
 =?us-ascii?Q?afneNkdAO3/loAYcUho8AZI5FR6K61MePeqgLq1nN/IILHzRawztljEMxx2h?=
 =?us-ascii?Q?MvwIjp/vUgVK1QbTKvNWFBX4+C6Um5z40iWMac2pPNF5OHvUS1iVY+Pqb8wB?=
 =?us-ascii?Q?s0GCT6yn39sKrk+NQhBzxnSU07VEbIw37bM5A1h8lt48lA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?khi5nI0BD6q6wO2a/QlnG1H2vom2kuEIVp+WKw0VD+jQDv8qYufyB3B/sbUQ?=
 =?us-ascii?Q?IJBmWhm538NEkkHIBmYwO0WgEbcAAbFD5FoBoaMROjkSHyDJOSbs/8YRZfdl?=
 =?us-ascii?Q?G6yVTyzRxNlgtQSvQws6ZTv6JFiQmEr8RZpxqo14SfdiMGrU1OwP0eycg2NU?=
 =?us-ascii?Q?6i8r4j7KnZa57F1zdWTFCs/MosRZCcpda7JdkEFnqgVEjRSwOxpSdbdnhiRI?=
 =?us-ascii?Q?ARyEX8q4Yjm6UkU3NnwesJn0rBf131XFTwOoUSSpEOAXdzntQhcge73ITFzv?=
 =?us-ascii?Q?+S6XpA96w2RXtN7ZXv5Tvpq/gBiVG+vHdeQjxYLHNtXdYtOrLEnSK3oTagmX?=
 =?us-ascii?Q?ypkYcZ91LVWx7YAhm7h1vShkmG1NKTopeDGvldmRgouALVCfLdyRwZ+OCDwD?=
 =?us-ascii?Q?V4LH9VZso1O1YvVCm2XD/1m1nqAVtm1nUejAahDyDcwwrmJX0XOtVKt/DIXm?=
 =?us-ascii?Q?dPc0tRNnTJwW9czig2p+TRZ/YIQU3oWpKRHbYwRG1uFbY0bvg63Je2nKjGbh?=
 =?us-ascii?Q?0g5Xk6kS+82MgzYWYQ+H7pGRDX+m6YAD3jE3oFOLFJrYQRYgVj5m58x9LQ8q?=
 =?us-ascii?Q?rJ1/Ei7hdWsE9fibUDFOThTKQVt4tyucvFsXmMVoa9SKlMuw0knfujre9FFB?=
 =?us-ascii?Q?Uo9uQE59xZi/rI1xUhjF5OBTTUIPebatpX+3+R7rrsjpSTAIKmtC7GdLFLsw?=
 =?us-ascii?Q?5G8sjo4vq17+rQ8x5VenpHMw1BceKH3HbL5eljdNleJIjEkUgP16nTBC5doM?=
 =?us-ascii?Q?5vEArz85Y42giLjPaGgq7f+pct8q0Ca8arXYthFlnhnIusTGuqz2THZZHFml?=
 =?us-ascii?Q?IqfWPq4gG6EP8mqJWJybaHZCgPp8DbOg6OB4ivbQQa/yyCej/JCcxFXyUb6R?=
 =?us-ascii?Q?udd9PYh5B3PziO/5LjXjXG6sY+NeNlRSmM3371JeqU7ddymQmWIQ2Gk5z6Ci?=
 =?us-ascii?Q?Ihw6h3dfGTRF6klmg0s1csT+zy1JlQvVrI8qX6TFaFRK/zIoLD+KdULMfV8O?=
 =?us-ascii?Q?xOq1ChgbdDQQO2J29pidCdOxuwprmwq/oOUNy9aVkVluRjD0x6mXu8D+jAJE?=
 =?us-ascii?Q?WlV+GNX0z3xvSXY+snxbVz+Tju7WYxQpSqwA5GObSYw698mEp8FwoEDpIqWv?=
 =?us-ascii?Q?RBzQzChI0lipYzq21a2p3M1Dx2C+aYlvVQfvFajq+f9aOosD51wIMwi6yh1i?=
 =?us-ascii?Q?Ru8vcVUJ7kosxScDX6W7N+G0nEZrAeaeXdoL2GW9Vxi+bOIiO8QE5RvR/Fyt?=
 =?us-ascii?Q?IXyJVkBaXntCTDl6ImP7QYmm6OgshW2IebZwly9HGE810SBkbWTcdGyI2+f2?=
 =?us-ascii?Q?tEl2FXQNLCUyKOwuUR64It1+pzWch/iRGSAoS55H0MDjFM8ULRhWw+Eq8zWx?=
 =?us-ascii?Q?JKo/q04x+XdysXAWkECuwzmWOXhaqxSJz9qELTcy5izoTEdDslIHLxkx1D0e?=
 =?us-ascii?Q?s6XLVGwnOf4Rxfv53lL1Rqk5IkdUWJd1i5DnFrHD6NV2Rqai/oTiJyEMFbyZ?=
 =?us-ascii?Q?FJHZntW3EO8cEIJKI2Q7+n4OlhhcBhw1ZLPcSPud2GOHkKvXBEz8QPzuVhMk?=
 =?us-ascii?Q?KNJt8l4qDQQBLkGa/X8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef300522-c03c-4c56-085d-08dc79598b99
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 05:47:48.0603 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K3sNd9BgsnFjhUeC8BMnux1i/SoHiB/geDbLN1vsO3xbzSoy31YUNAnyrsLjDlG7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717
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

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Min, Frank <Frank.Min@amd.com>
Sent: Tuesday, May 21, 2024 1:24 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>;=
 Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: FW: [PATCH] drm/amdgpu: program device_cntl2 through pci cfg space

[AMD Official Use Only - AMD Internal Distribution Only]

From: Frank Min <Frank.Min@amd.com>

device_cntl2 is accessible from pci config space, so program it through pci=
 cfg space instead of mmio.

Signed-off-by: Frank Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd=
/amdgpu/nbif_v6_3_1.c
index fe64c04ee20b..5a20bb229788 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
@@ -315,6 +315,7 @@ static u32 nbif_v6_3_1_get_rom_offset(struct amdgpu_dev=
ice *adev)  static void nbif_v6_3_1_program_ltr(struct amdgpu_device *adev)=
  {
        uint32_t def, data;
+       u16 devctl2;

        def =3D RREG32_SOC15(NBIO, 0, regRCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL)=
;
        data =3D 0x35EB;
@@ -328,13 +329,15 @@ static void nbif_v6_3_1_program_ltr(struct amdgpu_dev=
ice *adev)
        if (def !=3D data)
                WREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP2, data);

-       def =3D data =3D RREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_DEVICE_=
CNTL2);
+       pcie_capability_read_word(adev->pdev, PCI_EXP_DEVCTL2,
+ &devctl2);
+
+       if (adev->pdev->ltr_path =3D=3D (devctl2 & PCI_EXP_DEVCTL2_LTR_EN))
+               return;
+
        if (adev->pdev->ltr_path)
-               data |=3D BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK;
+               pcie_capability_set_word(adev->pdev, PCI_EXP_DEVCTL2,
+PCI_EXP_DEVCTL2_LTR_EN);
        else
-               data &=3D ~BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK;
-       if (def !=3D data)
-               WREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_DEVICE_CNTL2, da=
ta);
+               pcie_capability_clear_word(adev->pdev, PCI_EXP_DEVCTL2,
+PCI_EXP_DEVCTL2_LTR_EN);
 }
 #endif

--
2.34.1


