Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F27CCA47B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jun 2022 07:05:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D2A810E1D6;
	Mon, 13 Jun 2022 07:05:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81ACC10E294
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 07:05:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQfrNb0UzRVR6e0Ucte5nliiI2hctD+q6grumBi97e2YxgboX4dkEJEhdfSjfWbuLYVgMPZxll5bRg/1m+hv2X1agSz3O9/1Gk7Ws1cTZEZeCJ4OYXjI45i6VBbjhRHT8pMmexSUkKYgsfI/GG2c+rk7joL37KQDkyovImXx2GVejY7+f1rX+MlQY4RP0Pq+Fk1Dw6mA3PQkuzpwtrJAnnx+NRGMrmZfEmJqlczCzXyr1Dc8hK10q45UU59CKXO6Ts73VSg2HSr21ZyyRFrdY/pATSNI36YFWzTtKb2+GC71oA/ycvYL0vxTGMAMgsPSVi6KM2IP3HBtO/aUqdEpuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGU8RQEXO1P8nLX9UoUF/Hal16q94m8IRkMyA0NANm8=;
 b=gcgUpC/tmYqXHQoG6+Go+HLL+t3ICIxVsLGffIhEtfoGqubwyEEGMzMcifMehXlERHahpZTWMkBa/eABtHqmiRib7O/FHStZ5o2GzGLk4ZCLjBhErONXK70o+Pqzbpy8U7zhYYOfaR+K9XETAbwrE+KzX+RfWzfUHy9UlMOJiVlCBeMlwFswKOzvp5t1UAIIjSi5LFCGHv4DGxXsG8IVXN8t03+FKKpY7nrOw/aO0iMV1MqHbAAfuPcML3kx7zjMcswP34mNKyKePkHhDHrLbMU2svhRIMi1i3VB3hzL+PoGXr25mZWP/yzo+vtIdZng5Vt86AMwn5xA0/co7J3urQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGU8RQEXO1P8nLX9UoUF/Hal16q94m8IRkMyA0NANm8=;
 b=GZVQrruqbZ3d0JOH2co3GUwfJ3NXLbh3IBQNl41CY4vdRm8c4lJO8zUdi1b/nLgUKOLK+cOfOrquneJaVRg4zOvNxBcTCoOQ7vI3m+WKl3eCp5WKWDh5pcRhE02d+WjU598NBCFXoaj9tL96vYh3f+mqL41nqMBW4VIQueO/GIc=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BYAPR12MB2999.namprd12.prod.outlook.com (2603:10b6:a03:df::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Mon, 13 Jun
 2022 07:05:09 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4cb5:c559:c82d:94da]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4cb5:c559:c82d:94da%9]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 07:05:09 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gui, Jack" <Jack.Gui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] Revert "drm/amdgpu/gmc11: enable AGP aperture"
Thread-Topic: [PATCH] Revert "drm/amdgpu/gmc11: enable AGP aperture"
Thread-Index: AQHYfvM+VAM0+5km402zXmHTwTMt3q1M6dhg
Date: Mon, 13 Jun 2022 07:05:09 +0000
Message-ID: <BN9PR12MB5257FB6CA192626D5D108C2DFCAB9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220613065957.13761-1-Jack.Gui@amd.com>
In-Reply-To: <20220613065957.13761-1-Jack.Gui@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ce4fda11-5b21-410b-90fe-0e2d6ede9e98;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-13T07:04:49Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dafde930-27f0-4482-a92f-08da4d0b0d61
x-ms-traffictypediagnostic: BYAPR12MB2999:EE_
x-microsoft-antispam-prvs: <BYAPR12MB299966BF437A670FC25BF9D9FCAB9@BYAPR12MB2999.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hZhMmBoSyuzPmj9X4Wb/ofZ88k0wcfC+YdzSm14bIATy88UsG6pW6wOPNOJgg/XeVC83RruVDVXBMvwJCphFMei99sFUPMPPulrkquMLpdZzcAVtz2MZ93MtrfnQHsGDpI3tP6N4tGTfKwns7ZIfEBf9QO/AOR97Zsr9wUq9z2UCzHn+wJ9apQhH5tReCprceSB/sEYnQ1ASdVTjOEjpWpM6tjPbJ/VdRo7yuwA3nt1jeiebDzeGNepVV2iM4dQp7HEd63tdLoQv6i/iV7whNGjrFXxBRc4jXG7h9YLzX7YtFOGhYUnHx4GcZsKEk90hzMDxlyflUhrfn1awfo5ZlPQJChML0jxRINsLVo2fiM7G9eJXb81lZyUo89+cVVJFhay1Lb+1DTUx2er4ZqbXiEeE9be0x8pQ2WvE2Lp6v3hK3fTrVHgqLbpNu+R5H0QGsJ/x0Gcm9HPi9zaFBsW7lN5LJ6oJ/gjVTdb3rYxR1I9klZ7oF92adWvzY6nJHALduxpVuMwhBdgUrVjLoyftObAzgugenH060Z89ULfKjBfl9CShXqNl6iZk3MBvrqzDVcZ8997Dv+eegLgUc9tC/2Gkn00LBhPhqH24UdyPBoIXXgCqTTnqpvmH7FAZ40fYn3ZM8cacahFVOoiyGInJijP5i63d0k0V6E3N2I5ecgJNyn+i8wQ8MY8DGcsyYKfMGnM6BrmTSywPY1pHNjvsGw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(110136005)(6636002)(38100700002)(8936002)(55016003)(508600001)(53546011)(5660300002)(86362001)(316002)(2906002)(122000001)(52536014)(71200400001)(38070700005)(7696005)(6506007)(83380400001)(4326008)(66946007)(66556008)(66446008)(64756008)(66476007)(9686003)(8676002)(186003)(33656002)(76116006)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MOhSVXymt27MzljjSTC5h/FvSug8eyFoVmeZ+bBznEohsuNyOJ2EeLjOl/so?=
 =?us-ascii?Q?UW21iO06cTNgl9TupjWH+VUPC5qFy7XfiDVnsoThVESyUi7kP8MBpi+RQ/+G?=
 =?us-ascii?Q?7vwNHKKbPl3q9V2Taz4YtWukPlQHT0zVMNwWmO3L749detJ1djxBrq50FXUO?=
 =?us-ascii?Q?nFfpd1pVhfTlnKXCss+WR7iGAhz478lEsVR44zlCX6foMKTLGeK501FPrVvZ?=
 =?us-ascii?Q?LiPy4uEDpg3BtM59b2u8zx/eUuIewN83lztIdnKG2c0fIHXJuqF8MjHS+AbE?=
 =?us-ascii?Q?fhJeOKGauqUv9Jq6NQU4vs0ZOqTkHs1C/w1oWZUVga6Tq9/PNhiImT7iHexX?=
 =?us-ascii?Q?ueb7Tb9zP3LYF+hUrCkTW1YonOJTHwDCaioiGo3Ms0JWfhF+VOEEXj/CYr1L?=
 =?us-ascii?Q?sO5ViwhgDqzCYnBEs0rEpDUWdQb2aJ4Rpk22TbT9UjkZvchvkaV8QCV8Sy/h?=
 =?us-ascii?Q?vSVUD/vN6dSuy8U0mRlaMX4j5KZRrf0nvDU0hbE6TpV/cYV4h91x4FyJQ0uc?=
 =?us-ascii?Q?aOnxUXpAr9sQDypkuR3/2g7eDY73i7UoNE1GwMTrxcQM7h9o0DRbjVrEaXUi?=
 =?us-ascii?Q?j7indKJ74q+ITgXufki7IQ+0RiWqP/m32hN1zf4DGLaU27aHp1d2dgQ/ygDz?=
 =?us-ascii?Q?8bkk7uC4741PgI3MvX9UO5nuNLuuZixBHOlJxO64zy/luhMkWFQs+Ou9Y6hy?=
 =?us-ascii?Q?F7U3M4xevLbi/lB1OR+rvsxv9NS4NKUL6Jja9reVWoDJdfk6pCERWTCDP46d?=
 =?us-ascii?Q?sytnSBIjiopRFeppq5RYI4IWd+3umhy/NEerbK9cYoMJ4FOpcLJMn6Ry+nlb?=
 =?us-ascii?Q?n428JlwZXst2w9qLM84YuEyj6/KVR4Elu/0VGMvjPW/0Lv+UiIethKzI8UEy?=
 =?us-ascii?Q?9czfB+U8QerDXamVMIjM2sQQeNHtXtuXe+pES3u3Qk13SNUKbN535ToTboE5?=
 =?us-ascii?Q?5PbE0rf/dHsCLmcw8by+Vkg9O24dkIwWuDtBRF9EhDNqW0UPK0bZtBcfDNvg?=
 =?us-ascii?Q?TysVlZfj+B0lfTnDcyK1W4YPoZ/580wC7+AGu7kn+4HGLkAe6VZLaFtrX6UD?=
 =?us-ascii?Q?QB3CH+CMMjF0nLQr5gZN/WLM4QAW/aQn2IXzkottyne3q/STqxxfd7Em80fn?=
 =?us-ascii?Q?jQjYalRpI7mIHmr7C1jhP6oE8Q6gxPSetLPRfvJeS+5bCHb8aXX6NiO8ANNb?=
 =?us-ascii?Q?4HwJU5yGgwoQ/ZInHNvAouQoVhnoxBdhIYzzTMBsvVmQaoan/472TpFrzBDg?=
 =?us-ascii?Q?lZg2MWoFZ6DHvAbkfM7l6Xyjp00p0//8ghSxdtiYxVrnTXplqEjGObUJFKvv?=
 =?us-ascii?Q?/G4o5COI0cfYhYvTPphzzDHGJshwNqSyP2tlK8qV9EY6ZESrDTANiL4E5X5P?=
 =?us-ascii?Q?WEmWKwXXObQc3Yw8/EMBagbvP1AyhNXK4XeVCsEvD1ELljqe32tTp8EXwJ7Q?=
 =?us-ascii?Q?R3LfOm/KT1uibpbCeh1bo8jiKTOkeX7X52m0JFYKZ6yBsZiEIGRsr1SrOItg?=
 =?us-ascii?Q?a1QIXpqlrLJxe8+Xq36JIXUv3JvsQDMERlYzx+R8W2kzBYG/6eLVNr6EaCbP?=
 =?us-ascii?Q?vwID58tnxdsYhjjri0BkiWhATzkGWilkg/9iyzkfWdNVjXOl+kQCF1TYQGI0?=
 =?us-ascii?Q?j5lbh4j90b2bsrgTRsn6N285W1bGD83zRUU/CiCqt7amYmRojMDWZX5/65UN?=
 =?us-ascii?Q?7TUc90gfEW9BURQ4DtNlhX9OGGVi2a8PUC0XhOuoE648e6LXup2ZFZm/r81a?=
 =?us-ascii?Q?dAfbCqM3uw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dafde930-27f0-4482-a92f-08da4d0b0d61
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 07:05:09.0360 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vd+/nBOyeNlXkD0lzlz/A0z/6FZX1KCZWVH54vXBlF4dRZqBgePx6WS2BG6pQHEF7nCW3ujeCCx7iig8IdSc+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2999
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
Cc: "Gui, Jack" <Jack.Gui@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chengming Gui <Jack.Gui@amd.com>
Sent: Monday, June 13, 2022 15:00
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Gui, Jack <Jack.Gui@amd.com>
Subject: [PATCH] Revert "drm/amdgpu/gmc11: enable AGP aperture"

This reverts commit 1b9e86109b7a569c2bc0c985b19dd482df31236b.
Enable AGP aperture cause SDMA page fault for gfx11.0.2, so temp disable AG=
P aperture until SDMA FW resolved this.

Change-Id: I93a5dce2f72d28717ee547a8f3649f50b1b02bcd
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c  | 7 +++----
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c    | 1 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c   | 6 +++---
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c | 6 +++---
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v3_0.c
index f99d7641bb21..5eccaa2c7ca0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -154,11 +154,10 @@ static void gfxhub_v3_0_init_system_aperture_regs(str=
uct amdgpu_device *adev)  {
        uint64_t value;

-       /* Program the AGP BAR */
+       /* Disable AGP. */
        WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
-       WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
-       WREG32_SOC15(GC, 0, regGCMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
-
+       WREG32_SOC15(GC, 0, regGCMC_VM_AGP_TOP, 0);
+       WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BOT, 0x00FFFFFF);

        /* Program the system aperture low logical page number. */
        WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c
index 454a25cc0046..9c225553f5b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -611,7 +611,6 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_d=
evice *adev,

        amdgpu_gmc_vram_location(adev, &adev->gmc, base);
        amdgpu_gmc_gart_location(adev, mc);
-       amdgpu_gmc_agp_location(adev, mc);

        /* base offset of vram pages */
        adev->vm_manager.vram_base_offset =3D adev->mmhub.funcs->get_mc_fb_=
offset(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v3_0.c
index 4926fa82c1c4..bc11b2de37ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -169,10 +169,10 @@ static void mmhub_v3_0_init_system_aperture_regs(stru=
ct amdgpu_device *adev)
        uint64_t value;
        uint32_t tmp;

-       /* Program the AGP BAR */
+       /* Disable AGP. */
        WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE, 0);
-       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 2=
4);
-       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24)=
;
+       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, 0);
+       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, 0x00FFFFFF);

        if (!amdgpu_sriov_vf(adev)) {
                /*
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/am=
d/amdgpu/mmhub_v3_0_2.c
index 5e5b884d8357..770be0a8f7ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
@@ -162,10 +162,10 @@ static void mmhub_v3_0_2_init_system_aperture_regs(st=
ruct amdgpu_device *adev)
        uint64_t value;
        uint32_t tmp;

-       /* Program the AGP BAR */
+       /* Disable AGP. */
        WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE, 0);
-       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 2=
4);
-       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24)=
;
+       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, 0);
+       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, 0x00FFFFFF);

        if (!amdgpu_sriov_vf(adev)) {
                /*
--
2.17.1

