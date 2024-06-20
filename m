Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493C5C27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 06:52:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F2D10E57E;
	Thu, 20 Jun 2024 06:52:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kodQN2JH";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDDF410E57E
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 06:52:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCRgDT+NjF/Le/JaKVk6mcKFR6tUAAPzGhDjq/oPxMTXvCX6EYgiRqYEVgcyZi8uw3qLooVwn0B5gis0Mhsa6a9N6y90iNBDq4LO4aHgeKaqT1om+2NOL2LV3ET/R4WBsz2gd4Wq2TFQsURtLth1UW6K0Xp0H02+ws2Gk/486vxpz8+dEuViaJCZDDrOZSs2Pud9RilqXBIQGcfXgD60zPlrVm0bU51/kMpCQ6agAZsZfx8Tqzrvcjyl5QNOUHz0EIl2sNrLBZTyYXJoVRVVrn7jZZfVyjTuJeFiyGTAcd+YZLvjip+/kS3JZSlTGld6H3qkkB7AXWuM2MdJWLrYPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVhVz7OyzhgvtnzLImCh9qu7Mii9SKWNfEnqqsxjAj8=;
 b=hdcD9dUgu39AKpj8SpKv+xexlXwxAfHrwPYVaaYI5ooojQlIEKkhRjfsGlgF5qyHGCvDZjtBc3gaR6rEDghq2VXcqowPq7i+80m6bm0Piaqo8JT7NLWTJ3xXrPJrb/QX+gJ0xbBHRQNjwHd5i1MijF7uRE5zU8YYB68kYzyPjcJkLcZHaDm//g90aDDxmD3aGi6l5dSacHAVZj1lXSy4oPHfJoDRUSabwIsjl9XR+Tn9hf3q9bki/PGdnPq7lFtmQ9SgHv+iYI9/pFO6DKtJ3KdI9FI/CHACOx7vIYUIBNsLjzNyvDosWrKvsoPkTJQzsxDmEqEACv3Ofw8mfM3AyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVhVz7OyzhgvtnzLImCh9qu7Mii9SKWNfEnqqsxjAj8=;
 b=kodQN2JH9S0wwtFfnOtL9eqglC02ttRAEWVY2Qn3Jk5RJe/nQKWdGz48ULo8yzSMK5nbTBM49Q4WqyvQf5Ic+WGM7UdIUNFBMA/5XshHOg7yLRJwTIHHAMmm5Lg9sLaKtGIkMvmlC9gGwuJ4/C7NsAl0uqOUUEiuWi4R6RuuVXk=
Received: from SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7)
 by IA1PR12MB6044.namprd12.prod.outlook.com (2603:10b6:208:3d4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Thu, 20 Jun
 2024 06:52:07 +0000
Received: from SA1PR12MB5659.namprd12.prod.outlook.com
 ([fe80::e783:dfa3:88e4:d166]) by SA1PR12MB5659.namprd12.prod.outlook.com
 ([fe80::e783:dfa3:88e4:d166%5]) with mapi id 15.20.7677.033; Thu, 20 Jun 2024
 06:52:07 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Gao, Likun" <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: access ltr through pci cfg space
Thread-Topic: [PATCH] drm/amdgpu: access ltr through pci cfg space
Thread-Index: AQHawtUswDGG8EbwkUCB1oGxLTFsF7HQNsog
Date: Thu, 20 Jun 2024 06:52:07 +0000
Message-ID: <SA1PR12MB5659299BF8D06931F83065E1E9C82@SA1PR12MB5659.namprd12.prod.outlook.com>
References: <20240620054406.2662-1-Frank.Min@amd.com>
In-Reply-To: <20240620054406.2662-1-Frank.Min@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=28e05613-fb91-46a3-8559-6dc3bffd5400;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-20T06:51:08Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB5659:EE_|IA1PR12MB6044:EE_
x-ms-office365-filtering-correlation-id: a2edfd8d-88a9-42a7-6f83-08dc90f58034
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?8xtj6hir5hN70lqTkzl9HfOn9FHOr4/3ow7k6sDHpQqjZu8YqBhAz3p4t5mj?=
 =?us-ascii?Q?8vC6NhpRpuCeYkdLMKGZXdtx+/SbZT9E/1Ov5gQtS3RBzZaCMgtd44pKW8CW?=
 =?us-ascii?Q?Qf8NsyqQJtTI5Rkn1whD37paucPkChlfBVCgVYu2zE7uz+A5mxc0+pzzMb2r?=
 =?us-ascii?Q?wVa05jS005JL0rtGhnwwZpjg97GveE8StWc/ZdZ+r1L6KA1MOAfin2s8FNHS?=
 =?us-ascii?Q?yL5LkZwVIOsXdDH10wcB/nsI/bHW7/htlWBYRvrSIxLQrhfcSrqjSuzHaWBD?=
 =?us-ascii?Q?hahCG4a9p5aTvy3y+7z0XGKyVfSNioqBVQiGU8qP1nHDMpwNSK027jSV5shJ?=
 =?us-ascii?Q?Z0bA2aUMM5+OAbImPrbRMmOLdh4qddAlilHHKlsQ6eEPz1ItIw7ulatwjkbT?=
 =?us-ascii?Q?5nI9d0Ch1Bw+50uFRabhH21mbBedtoacrPFKnvSkCDWsO/t40IQVIoSNwNT6?=
 =?us-ascii?Q?8MRfVbNylIXJsg6/FMr6CnAKfzf9u2wsjuIHPTjd0jDfi0N8SVTcyF8U1Xqm?=
 =?us-ascii?Q?MLqu66IzjGl4QmaDk9D2AOFPD6hHoa/ySPmG69ZAo824dB5iwwA/AbzjKRpp?=
 =?us-ascii?Q?Pa4ANBRdQ4VqrDSXfOLSGH3MsOpBS+2bWbvE4LbA/Vc2AfAtpKlnqRfRwk+2?=
 =?us-ascii?Q?OURarArItl183TC534dIR/GP9P4L10m5VcxxrXRwj/XJlK3su0y184ChJsqW?=
 =?us-ascii?Q?oDKm/M6UVV+sv2FGBEGDhyDETiDHmHr8QJUUj8dMF3sBEdlkOZekKAUhyJzU?=
 =?us-ascii?Q?8MVF7aCWy1+0la5pbpFYhC5Uyd+cuXGldAhZIkk/JF9EjlzEu79ghCnIihSo?=
 =?us-ascii?Q?7dgi0fqd4h2aOO1Y7fnie6QQm8FY1OzRkS6P96kJeTM0N21S6QnP6FYsiNza?=
 =?us-ascii?Q?6KLtwzGGsXGG2ubd5hf9HxTo3Ji7scVYFefsmYHoulHO9VVzdfXDww49jSji?=
 =?us-ascii?Q?icX5yNL18DVxPt/VRE2qStjtUilwdWi8U6QT5tGgf7iWHDaB0tvtPlIJ6Zdv?=
 =?us-ascii?Q?je9ALDwUeKFXtae8McHKaNY086nViGEEFKJv62TBvotXtCSskH9BS0GNE/7F?=
 =?us-ascii?Q?E3W+aNgUURHffd3kJ185FPULTPz4D9OLsi/dmURF1577CHLPcvjpGDhilb2p?=
 =?us-ascii?Q?VcvdnGjth2Moi65RSKg2cfcNP9PFx4U0uNoHQD04AaYD6poYQ860FW3i7P6r?=
 =?us-ascii?Q?thceyrGh7tX/0zEjmIqcIiafHqJ4FlZ6BHMVQqhr0e7CnOQLdvSbIsNyc7xv?=
 =?us-ascii?Q?xKUiBB1wrm+zGoPj3wzH43IYqBLpJTTMvaFqqMYsbOVsEDU+Wan5LyARIkcG?=
 =?us-ascii?Q?mCGnT5iyUx54TXKvznCjFA9u3d/V1IINJ7y1ncdqyP4jwrpWWXiQ4jXosd8T?=
 =?us-ascii?Q?U/9+Fdk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB5659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(366013)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UdccTRZ3Rhw76PFy6q4BUNIeK8rcDhK2PzDfPIiu+y39z+LdvFH58dPTyQdD?=
 =?us-ascii?Q?JK8w6ckdseUOlUiG68ddDgVqTo1TeByaPawgYoznWWscFB6rh9ZQSx5wGD/4?=
 =?us-ascii?Q?OFiI1z3TuYnQPE0z5d77in+MfMZCm3bAKMQ19sZlXSuwYaG2VgNBn3tHxm/7?=
 =?us-ascii?Q?9En31QubOy1iynfatV4/GWGi4qYWYlYuvhv1WM0XmLT6YF7JflWh5qeQ34lt?=
 =?us-ascii?Q?zyDXmDkxce+2njXhEfS19UaLg4yGFg7yF2ZlOjpss7Hw4y4KpUkBrk3sZVsF?=
 =?us-ascii?Q?P6GGVXO1Y0AiZlOUS8CLnqhyxRhBBPzcNycjN+wg9RUfpm5/ZjgjiVZx1Asl?=
 =?us-ascii?Q?kWEDAG4V1eQTXk1/3Q6BjmD0g2EzVI6mRkk2j/FejQcahv0HuuP36mWA4qRF?=
 =?us-ascii?Q?8YBw4/vOPdRXpMbiT9qOBqkXAW9LhRvvA1SKpnTp3FLTBuQGYkH9AwhSv9fT?=
 =?us-ascii?Q?lR36UOokaGuJGfU+X1wt+yfMJOXwJbygsUSqG+hiXU7e4czRPI3lfkerOkRs?=
 =?us-ascii?Q?KRwJb58H6PzYcbrMu3shgjAkZtNl6pTJ3FOUrA3pIq+QmaT99peKVKTky9wE?=
 =?us-ascii?Q?BhfXkN7lzN0nblbWC7o0F38cWWxWE8U0avxptE2Om5nAjIruOJgOiSIrau2j?=
 =?us-ascii?Q?scUYrdbKbUM6MOxBJ8DvJCUwZod9laQZ3An6R7icO33grFtXRUb4JNkWlln/?=
 =?us-ascii?Q?wgOVlpETpadh9P0nYUlwwXr0QpePVMxFy/AsVzPImdZZ/87ZSXQv9mi6k6dn?=
 =?us-ascii?Q?4jC8ROx0TPCw5ypN11cqFBDmYFYREKFg8DPLTHNNkmPyASW8nmdtTYb7ij2K?=
 =?us-ascii?Q?PkTupPWU84+nfgetX1cPC6bajXOGzQJqq2AveNs+s+wQgsVKs+K+TjZF4ruZ?=
 =?us-ascii?Q?w5cfDlj7Y7PhVfn6kTBPiTST76NJUqV0/l1gMM+AEOH/3QXTac29jot+Uco8?=
 =?us-ascii?Q?yhWuzboEO4E7BP4mpPYKa8fwy6j/DLsywuDU43cmdNOBA7YGZlBdcnjd/Zpr?=
 =?us-ascii?Q?tFn9FIIXw1wDf++lvxwUsGEulq0pGfhhYzqN9+QRVU3barftJakD90KV6oPe?=
 =?us-ascii?Q?JYmyKyr9BxQtVZ0CthQK9yn0tFKTEYKxd0Hv8XGRLFEJ5givkUv8a5tmGl93?=
 =?us-ascii?Q?cUSwV5wwza2ycRp+R02i1wlse+BKckcrtfQFwiZE1BvKXkmYa/W0b2bxjILB?=
 =?us-ascii?Q?X7otwLXWUQN1GfZwHjc6Ia2lbI6jqh4AUlguYzNcSOsVpMcasnS+Lx+ach4g?=
 =?us-ascii?Q?K5L2q3+da0YYesVq9AmgWVvk9K4kAKHggZSkjcXfwmRUcoB4x7fIowyKsERw?=
 =?us-ascii?Q?cOldGJ1WqXy//4Zs4eks38Q48Mm+2M5WdpjtVReSLnjUeEMLRA41Oyjlq7wf?=
 =?us-ascii?Q?LSsP330iPMoLWdnT4kNBNlRhjnQ0BkeSzBqfULIXJcEL5f+yaPsyK6i2hla4?=
 =?us-ascii?Q?HaAVQOKjmXfykvg+YTU7jhVv3CcqS+lIfu//W+Pu4oA/cjxsi80ispJ72iOX?=
 =?us-ascii?Q?sgwM9zjlYnc5XTXzIuKAsPedwwTZgo5AUJWW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2edfd8d-88a9-42a7-6f83-08dc90f58034
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 06:52:07.2019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GmRpSLdhYuE1Aab7PHA4mRzY4GEYud+rxcdiVjXYg41vs92wXVV7aemmXu/bH6OW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6044
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

From: Frank Min <Frank.Min@amd.com>

Access ltr through pci cfg space instead of mmio while programing aspm on g=
fx12

Signed-off-by: Frank Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd=
/amdgpu/nbif_v6_3_1.c
index 5a20bb229788..39919e0892c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
@@ -345,6 +345,7 @@ static void nbif_v6_3_1_program_aspm(struct amdgpu_devi=
ce *adev)  {  #ifdef CONFIG_PCIEASPM
        uint32_t def, data;
+       u16 devctl2, ltr;

        def =3D data =3D RREG32_SOC15(PCIE, 0, regPCIE_LC_CNTL);
        data &=3D ~PCIE_LC_CNTL__LC_L1_INACTIVITY_MASK;
@@ -374,12 +375,17 @@ static void nbif_v6_3_1_program_aspm(struct amdgpu_de=
vice *adev)
        if (def !=3D data)
                WREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP5, data);

-       def =3D data =3D RREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_DEVICE_=
CNTL2);
-       data &=3D ~BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK;
+       pcie_capability_read_word(adev->pdev, PCI_EXP_DEVCTL2, &devctl2);
+       data =3D def =3D devctl2;
+       data &=3D ~PCI_EXP_DEVCTL2_LTR_EN;
        if (def !=3D data)
-               WREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_DEVICE_CNTL2, da=
ta);
+               pcie_capability_set_word(adev->pdev, PCI_EXP_DEVCTL2, (u16)=
data);
+
+       ltr =3D pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_LTR);

-       WREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_PCIE_LTR_CAP, 0x10011001=
);
+       if (ltr) {
+               pci_write_config_dword(adev->pdev, ltr + PCI_LTR_MAX_SNOOP_=
LAT, 0x10011001);
+       }

 #if 0
        /* regPSWUSP0_PCIE_LC_CNTL2 should be replace by PCIE_LC_CNTL2 or s=
omeone else ? */
--
2.34.1

