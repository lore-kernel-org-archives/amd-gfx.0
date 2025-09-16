Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0D0CAC598
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 06:15:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C850D10E659;
	Tue, 16 Sep 2025 06:15:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WwemcfOQ";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A4CF10E659
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 06:15:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIxXBX8Nr0xDe2GyHBwpzAkMj5dZHHzpG5/UkBWRu3oOL1/IYa9ngoNreYepIlMysP4otF7pJoE8FWFQ0dR0ZYJKq+SyID1LITfKvWuoUquXCJFjT7yJhdRkjI5ZETT8TCnA3lPogEFuSoTe/W9y+q9Q7uvjK69rch99+V20zkX1vmBOrFyNU6ISTP8N5CO1KBx5/bgVxS9BN8xoH3b1srdwqVgULz030gM2ncGwq60VhY0FUhq6Tn5R/nLZ4kRW4GgGv6+09TSYOqMyDrWmRtT68C1i6KNq86T/g0EDL9m2gX8TH1fm29wSsfT/q7Mt0bZQOG/XG3Cel1+c6qHU3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUul1pBvG5+jd1zIZ13DWZ/FxfzBAcquRB/ijU9tKSs=;
 b=Z2k1U61M/FStNYHmgLs30TGy7gto4P0sxCw4qUmq7CjQdRJr+dmMy8lOKqvvwjPOVyei2x9ip1sjs68sBignsf5G6rtr2Yludv60fkKN/2cuNIG60WMn5blJjQtB/BeVXmo7fq+Xi/mHeCwT9b34b5tigyWPVO18c1jhW1wEhtyTc4ZGazGajlYU26Roek2lXPNvjC9TRseG6q23FvDfccrenyo9ad34+npBHyu4n/+U0aVsW5kDf77R0+mfN/CcGf92eVoQfapXzU9r8nFnSJhguBmKoLAR2SXRhWEJyEsZozqgQU4zUoNaLsYv0pLIdAjJgYDtfJ81RDB29kERdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUul1pBvG5+jd1zIZ13DWZ/FxfzBAcquRB/ijU9tKSs=;
 b=WwemcfOQ8YxXmGgG97JbbUCv4Fx0MgWkwY9qn0wf76l47ylgcVHGz7QhOdjNhAhse2EVgpXnFXiKmOez6aIor3ru1fdyf5LByOjoww2VZCdWFpnMhF/Z37dfBazOtf4TSbJkp7G9cp8NTS50PGzvgwrM/x7DsT8rZPYgCid/Yr0=
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by SJ2PR12MB8979.namprd12.prod.outlook.com (2603:10b6:a03:548::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 06:15:04 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%5]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 06:15:04 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add fallback to pipe reset if KCQ ring reset
 fails
Thread-Topic: [PATCH] drm/amdgpu: Add fallback to pipe reset if KCQ ring reset
 fails
Thread-Index: AQHcJs4QN/bdn5nkOkazPL7V1qpGFrSVVKVw
Date: Tue, 16 Sep 2025 06:15:04 +0000
Message-ID: <PH7PR12MB7820CFF586A78A8E999616069714A@PH7PR12MB7820.namprd12.prod.outlook.com>
References: <20250916055212.911425-1-Jesse.Zhang@amd.com>
In-Reply-To: <20250916055212.911425-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-16T06:14:15.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7820:EE_|SJ2PR12MB8979:EE_
x-ms-office365-filtering-correlation-id: 4d6321ca-e3cd-4c04-d988-08ddf4e8606e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Wm++sUQIoHm2ZL8AICu07HQ6QZpk72IcFO88uBxLqqS1H0icp8EO08YpEGFI?=
 =?us-ascii?Q?5oKpx2zKd7pVqymi+ysVKLaCNAdKaS61m2BvdxBS4WIe/HTO9nLmFmx9hCLA?=
 =?us-ascii?Q?SkY5J1sjEjYonVdDwo2L56FrCE9sMTrDDQUAkaZtvtwXWOhfjjp/GqkmdQIg?=
 =?us-ascii?Q?2ge6qBKIKdOdn6+O/+h/gkqwtRYvu22D3Si4pzJvmfJLJ1Q1g7KL4JH3ahBN?=
 =?us-ascii?Q?rcpdHDQOJqumppZwT2rgU9vENxMkXAhDE51mkMOrw5s3f0Gxow4vJj6RQdem?=
 =?us-ascii?Q?oVIsJnLjdr2n6HG6Af66Hd0dYVFNmRSZ8UhqYnYViHRtyxKarDpkZAySc8tZ?=
 =?us-ascii?Q?qbf0jwYUp4KGB6ZWFSGK4qmO+InZaxMOjuq3lAa5oB+VmP0NaL3OVqb2YxGP?=
 =?us-ascii?Q?AU4T0oVoJfl8rLkCwcPE/lnflt/DXg7S9iuYwPmKA+JlqVnRJisEJyUAEftH?=
 =?us-ascii?Q?zBCOUkwxnRSAgsHlLe2TfC6SdQQPROYGaspwvY3lmOW04TYU6ZsEpoZlY3Xz?=
 =?us-ascii?Q?4qVyiyVPl7fOfTMnbZTJxQb/QF92krLS0XCCTjLy+c7QEIBXaZt5gt1O0F7O?=
 =?us-ascii?Q?ZEfN+EI0pfdUApHICotCPE60s84PfAFncnwIUk+ZUUtL9f0OknZSsrN9X+mW?=
 =?us-ascii?Q?VZbBoFJhxmXeDN6foeLh2vWwo/3qlhMgaLRZ18X/FqzF3pAfVE8QA4DwN442?=
 =?us-ascii?Q?9P94K1qnRQI9ccwKpG0wxzQ3kgtvKWA8AEdMRuKMCczdm3xxPGViCM4Oxfi8?=
 =?us-ascii?Q?uu1/fcp2Bnh6v4YOug8v6AY3Nfj7slek+rkGoC/fFtWxQMWmKnzqQ9GpEaOm?=
 =?us-ascii?Q?FqT3xwWKGq9XBrypyx223cmG/Q7LDbry18Rwci+jgU9wuOpx1VWxLGTR/eTI?=
 =?us-ascii?Q?L8pI0AXEEmPVJI9lf2fXXm2pXsf5FDADVV0XfkicNECJ5KsF0SX5J4Dtr1k1?=
 =?us-ascii?Q?v/TdVo2CvNoYuOmmlFC7diTjcZ3L64vqhDBusBi06N6xeXs7IUccP7ylxf8w?=
 =?us-ascii?Q?h5f9Od7FbeIroNdhrsEGhuWzd/dkOhRd19CKC9V47xBZUHONF2LRgqnO82oN?=
 =?us-ascii?Q?zpYpt3cxRWXhFnJTncd5SVh6kEBu5forgwFUr0bAIRagCPJk2uOO2ok1Vn+6?=
 =?us-ascii?Q?wIu+oIVVPUHdWfa5u+BkMsBZFn0b5+xO0ymbcbBFE/Liic2/UWHAhnv22fvt?=
 =?us-ascii?Q?IDF6196jytDGUb3Zbt3YlPqH4oBNyyoqw94kzSWbPgmnDvofdda4jqsMKeCy?=
 =?us-ascii?Q?GD2ovw9lDI0ygFG1ZsmzLzySzOYsfb8v2XrN7xTnF+WJbW2rpVXfN8tSjhcV?=
 =?us-ascii?Q?Lty5w2GqJmC6SUCr5MNtK+bJN04Po5I7nLzap6+ZpbgnrHpzovjPEGEPHbzl?=
 =?us-ascii?Q?Mc2XYFJZFqXwJ/Ci6NMiCcWkdoesJ+UIc6aUOmzYWZ9OnQ0ARWvUzrsNX+x1?=
 =?us-ascii?Q?Ds643QGPM1xq40buec5wIZC7D5SQIv0Y7XpDINku2o4VQoDaNXj5UaeD9ns5?=
 =?us-ascii?Q?ZNX2j1eBnvhDl0w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NgkKlfvCrhwgLmZ0d3kN53ZCs95IZM+0Q09oBaPLbwoLus2RAwg3B71ab+k0?=
 =?us-ascii?Q?guzyk5ArhXZGATER7CYmxfsP/rcwlk7y9fMj49uHu6Dnz0xgSTLN79T5h/j4?=
 =?us-ascii?Q?nP/7T3HuTS397+lV8q0TXVRgMOaAnAUix2ko2gOrFynz3LsG+sMoUIUKKm9J?=
 =?us-ascii?Q?xCoG6ZNJjKY9pwBUlMCI4fDr6rrHyQ715U6HaTKP5C01WpofMtOTKftdOiv9?=
 =?us-ascii?Q?BSXeZcSNXccv++50kfWY4Rekc2OxHIodLsKr3hCt0uS1IcMzox9t7eZHjUdO?=
 =?us-ascii?Q?PtVYkJq6nnr0PuhjaGdbeBUbruzR3tGR6NwN6exHzfb2Y8itsq7z8usrrTA8?=
 =?us-ascii?Q?QQ8c8UqRWhYJhf3PRonFAIhbkmqyiUIf7ccBSM//GsDGdhtig3UIwLg1aDay?=
 =?us-ascii?Q?7+cL1m9AGPh5UWKRuGS/dL4Zj90v3z4bupGJb0SgVZ7rcYRmo69X8Fuy/9dP?=
 =?us-ascii?Q?tLiZ6Ek5hJu9a9bKr7nNj/TZh6u+rZX8D0h4tHAAkPvn4Tt4Xnd3D7RWR1Af?=
 =?us-ascii?Q?78zpnxYODueI6LEzoWbT7GTOr41DAeMKHbz6TzDX7cg333IgEpTRfw7gy6Q+?=
 =?us-ascii?Q?BzmUjtTQFcIxifefstDsZzq+7Fz91GM0fKyVXa5kGJPqgFttEt/lt+PDlD9Y?=
 =?us-ascii?Q?szWcz6bKi6G545CKpcAiA3Zl6M6l55xOQSoNvrGVh4SyEbH1z1DKeQTz1scM?=
 =?us-ascii?Q?aGaRGoQLUGIDrfv9ktVVdRH/PhD+T3hVK1HJ8PGeG+kwczFZ7eV6rIIwN8gA?=
 =?us-ascii?Q?YEt9JjfOZSA1YeAeV/xMBpA9r099ZBRQwB7kEQ7RnwC2PjyzbseAOGm3xQtK?=
 =?us-ascii?Q?E7/htKZ1wRqStOeXLsRsQe/CBP7KTVx8V4OQl7HwLeGv3Mj+uYddCGNCLRUr?=
 =?us-ascii?Q?QJOtR06uiqkKJ3GTFYPlsbluzZ6Vj+T40FJ4qCjCxQ/rLsD7Jlfs5xn4Fpsm?=
 =?us-ascii?Q?3SaS3cDU7ZX1Rta1J/4obvY7MfoJbK7VuwhuS8LLVm0ye4Qpr2sJQz88bY3V?=
 =?us-ascii?Q?C7o4HNaSJfDe7K+lyQ3ya/t9lwmzwuxFTwRRx1zK9WhQe1F3slzbJh6k6PZS?=
 =?us-ascii?Q?jSEOF8wCFBwsLno3sW/m/CzOIGuqUPPv1Wy1r0RfZ2SOBQE2RPqq9GgvCc/t?=
 =?us-ascii?Q?dBQX+mBcXT/OpIbmc3z2aQwTiSq9GwpqyF/JCQ5pPqXcmnRWGK4wH5Cr3iVj?=
 =?us-ascii?Q?zsS+GfP+gPQcI3gPmcIXtKKKlCkpvgULzeXYR/dnqlydQbipprE7JPhGk9tE?=
 =?us-ascii?Q?aaTnyroaZaBiYNU9eS9MZi3fcPYeUTZrLzZzosJxTbdOviQwzlUrtuEr824U?=
 =?us-ascii?Q?01vVDkjYI+LS2OdI/KRtFBjcdztP/dp1GWoZkGsanEO0hBpOG9tpd4ml0TRX?=
 =?us-ascii?Q?An87EOIroODraptWgj+TfsCrzDyWIiiDn1qS8xeULSml5iF6EM4B+7Q35a3r?=
 =?us-ascii?Q?HbnOCWsvj7whR49n0JCE//XmZNo3RJKyMUX4F4aYa0dAy19DQgwTLJaiAQ4r?=
 =?us-ascii?Q?5Aeh7kzFg7F8msRQmoixZjMkolhdE96uwRLreXnMJRUjc23uty12Svvg3TZc?=
 =?us-ascii?Q?Zf1AlVLVzywDEP87nJY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6321ca-e3cd-4c04-d988-08ddf4e8606e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 06:15:04.3472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xTbuIzTPEcLJQVlt9CCywn1ra01ZrV9ZxwOSNFuqjOCV+zFpj+dma90Gm8ndORFt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8979
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

-----Original Message-----
From: Jesse.Zhang <Jesse.Zhang@amd.com>
Sent: Tuesday, September 16, 2025 11:22 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Jesse(Jie) =
<Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Add fallback to pipe reset if KCQ ring reset f=
ails

From: Lijo Lazar <lijo.lazar@amd.com>

Add a fallback mechanism to attempt pipe reset when KCQ reset fails to reco=
ver the ring. After performing the KCQ reset and queue remapping, test the =
ring functionality. If the ring test fails, initiate a pipe reset as an add=
itional recovery step.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 8ba66d4dfe86..981324c55701 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3560,6 +3560,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *r=
ing,
        struct amdgpu_device *adev =3D ring->adev;
        struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[ring->xcc_id];
        struct amdgpu_ring *kiq_ring =3D &kiq->ring;
+       int reset_mode =3D AMDGPU_RESET_TYPE_PER_QUEUE;
        unsigned long flags;
        int r;

@@ -3597,6 +3598,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *r=
ing,
                if (!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE=
_PER_PIPE))
                        return -EOPNOTSUPP;
                r =3D gfx_v9_4_3_reset_hw_pipe(ring);
+               reset_mdoe =3D AMDGPU_RESET_TYPE_PER_PIPE;
[lijo]
        Looks like a typo here.

Thanks,
Lijo
                dev_info(adev->dev, "ring: %s pipe reset :%s\n", ring->name=
,
                                r ? "failed" : "successfully");
                if (r)
@@ -3623,6 +3625,13 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *=
ring,
                return r;
        }

+       if (reset_mode =3D=3D AMDGPU_RESET_TYPE_PER_QUEUE) {
+               r =3D amdgpu_ring_test_ring(ring))
+               if (r)
+                       goto pipe_reset;
+       }
+
+
        return amdgpu_ring_reset_helper_end(ring, timedout_fence);  }

--
2.49.0

