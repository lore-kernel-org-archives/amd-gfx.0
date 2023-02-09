Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C58EC636CC
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Feb 2023 02:52:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8162110E8E6;
	Thu,  9 Feb 2023 02:52:49 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C160D10E8D8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Feb 2023 02:52:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDRANoPyRkDX8lj8zsNOERdo1LiD1ad8XK3MrqTedWIvb8uBnvVNnQ8s9V/XPllnyGLQ85XpcbipNfITvlYU0uxtD85TGtUju4wNqlDExIZX+iIgrMR4IPABxgNW6SdKsNOmUMpXwixGr10I2c/PTQU/5YGz4J8kMgPFrnzUy5A11AIounOqduOPaOap2wkH4JIjMAchqjGhKLTzGGwQyRyC6Oekc1PRTtlU5nnDVGnvrK1ePhV+n9IhkPNdessAGh2SbUUujEzN8j5LDnkbC/0fU/mhICj6JdWfYkinbfJzThkKTE/pbqq89YSl6K2/rUPJc0dQRCnlVeJAEyJ5YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPUxRcQLfyl4kGeH+bHiDMA7dTuhtchNrgDd7tFNDiU=;
 b=JtoijH3N98rBf7FEaqU89vwHCpq8NJEEYiyAE11/rPLy5LsVZaVmBs5WwlIkXZnC4ZbEb+mYdz9etTPpJ0blIRHPRodC1SN5csvyd8l5hSNJuEx2/OGMT9JPJ2h8a4LFd8Z8PtDdo1l/mWfFqrPXG2KBgyHHGTgrXwZMgCFcvLc3ynNIXCdVxIxaUA+al4o7ZcsQAGNHB6ofHnGzTEy4Np9MNgGgVc4R3V+ta36c6h1hF93LF3KpfGXRg3TxVLh7v+1pauaxyweSTaSA2vX5krbhz+rbCUqsASEPetlSZOe57peDEQuqwsoVDl04VV27JhM7YdoK5zslMddxYstVZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPUxRcQLfyl4kGeH+bHiDMA7dTuhtchNrgDd7tFNDiU=;
 b=QSfEwubMUj3R/YG34dbGxQj6TFlXSzodeTMtVKEaBRBuC32CCSX/Jx1YmC/gRaXbVZsQ8T1tE5/7QwqVqM2Cq2CX/ucbUITajzQeDxqYCBKkIIdmI/DDVoSta0QTn5uuUQ4YSHdx2UqNUpg1+w3QO7mwrjMOxnH6N9a7ilrDL84=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA0PR12MB7074.namprd12.prod.outlook.com (2603:10b6:806:2d5::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 02:52:44 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::27cd:5a5c:4713:83f5]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::27cd:5a5c:4713:83f5%4]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 02:52:44 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/gmc11: disable AGP aperture again
Thread-Topic: [PATCH] drm/amdgpu/gmc11: disable AGP aperture again
Thread-Index: AQHZPAO7oxSgDFZ7OkuJZb9PNebX7q7F6wag
Date: Thu, 9 Feb 2023 02:52:44 +0000
Message-ID: <BN9PR12MB5257E2BFD7F039156ECC1F55FCD99@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230208212404.2656017-1-alexander.deucher@amd.com>
In-Reply-To: <20230208212404.2656017-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3a4e3663-4d69-4dc5-a26b-a56253d62ecf;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-09T02:52:20Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA0PR12MB7074:EE_
x-ms-office365-filtering-correlation-id: 3cae99e6-7013-4af1-70fe-08db0a48b7cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S++53SoP1mErCmtmCkMqMouO7oEqeCNrd3it2IwRGibtvHzTH7/umN+FhC8uoeH2VfiXPty+Y5iVDLg564GvDsfPwOXBUbR7gKzU3gh8+GBYnL5S6RklxmMF4vo6yn/bGzW12L0VO6+8V3eS8i/x+6DXbGZ0l9WQnT8LLbcRspUPnVSSuqzzhN59o5gXGrCpp5zhYcp0KyU7XIlNGuTwF3mC1VqxjihUipIkFljVf9U+dWZyHyuzcfxM2/x7txjdzoJ2LDXl6TUOcZrzJaYXv9NNUChBuWjUIL+btQEdfHoiVFONeQpD5aU6CEnzKgD2YgItjUO1CFofdxdaKf7cbbBs5rCbL1CVZ3PocyTG1HGCbFesFju3Zg1YEhPvdLw5din+j+JO+B6GqsYNEbfApVEvG66rkoHyjEs5SHZBCynhXd0BPaTT9OxxsyZceou39AndUW/7paddbb9MwIuEHpNciM6+TpyHP8CLtQtSLcTpk7Z/PmRyWuIYaLcoaMY9Tl10t/WUUBBUZajAsc/CzenKmy6wX4PIrhS72evNX8rG1iDx2cFe9VUH0YG9+IZnuax4IVRAAc4c/YpzTAnbqJbWcl7v6UN7pr5eUCFbaxDaqvPAwcZovpMXe06f7Uof7XkAWMRjSsqQa431MJ8YkQtArVdZmM1qysc9EJ0Q73gejDqShuLKrGk5cE4ZbxIb+CZPCq1E+Ss4SKOiHZR51w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199018)(26005)(9686003)(52536014)(186003)(38100700002)(2906002)(316002)(53546011)(8936002)(110136005)(122000001)(5660300002)(6506007)(83380400001)(86362001)(66476007)(76116006)(478600001)(4326008)(66946007)(38070700005)(66446008)(66556008)(33656002)(7696005)(71200400001)(55016003)(41300700001)(8676002)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+yrcUW+G7V2Jdbex4BVD4QC7Q9kblVlorFSR48O4CF0OzzbieL/azEvw9QVm?=
 =?us-ascii?Q?FIl0YrD8zQSR2o+YarNXTQBRbcLKN4q7t3U9z50yacLtlcZclN9D6oy2slKo?=
 =?us-ascii?Q?ouYfrCVwE6Ai3QhDU0D4vBPPtCsppI48K2O0WrD5o1eyPPeA4bMqOhSoP4/E?=
 =?us-ascii?Q?+h2wN0lb+NNDVy+qO3fEcIzYfkRxaO0EQH9GjgXkYD1XvPSqeLNf2XlfO6oq?=
 =?us-ascii?Q?DLa1XdTzxOIdPQebFR0d/gE/f/HGlsR7m5WlSRLsPFFwATw991fN1vDCfSY2?=
 =?us-ascii?Q?F9dns0BeRS/5IZEpSMRbY8bgEJpF5nb+81l0SofAK8BB3vWcUJROyttUMU90?=
 =?us-ascii?Q?wTKU6zQfeheymSGTTY1IRxnfnlvPMUtKvjt/iosQcRjC8RDX74F6qWFKuSEv?=
 =?us-ascii?Q?bamMUuGEfvhO1EsGWaGIAB2PPymIm/BoAq00Vs7ZD2rj/lT+PW/a2an4Q6M2?=
 =?us-ascii?Q?L5cUMkK9PkkhIRMs3/v+HQoUiPHxFtRMcHBqXn1rLJTCOGbLtTlKUHJfBhAA?=
 =?us-ascii?Q?TLxV0NoauvjiVM1LGm5XvMtR6/a+d3RSY5fvTEjVyl9wmSnBTGd9WvxnNcv7?=
 =?us-ascii?Q?A5MsAfFBy5VUT71cRnh5Dc6yZ8OQEJA7VGow5YtGrbA8Y4oY5Y1LuzGAQaLO?=
 =?us-ascii?Q?2sMBu3eOS71DNmwAUCgXBAbOfvHIXzBCpaRp1y3MABv9YZIRJ83Q11Cz9vb6?=
 =?us-ascii?Q?1h+qyEPr9Sm2a1Di6CldLScIPHOeDw+cBtFtDSkVH3Y1hPsTTB8kkFRht6lT?=
 =?us-ascii?Q?JdrJ62AWrKTZmQUFEdRL5SeLk/YoCDZ755NpBYqJH0rBGa6PEoReT9/MiBgw?=
 =?us-ascii?Q?1WP+63V4hrnhfuEVtaJw8E+6rMMrWTDfTn08NvSh6LhyxitoHwRLs13BmxYD?=
 =?us-ascii?Q?dwYAbONcGOJ6TiYTJIF3kVvYcgJplKelJiEGjtBeSVFPKU+zrNuP0MBHASVL?=
 =?us-ascii?Q?HrLxthtmZMHQUE53TSzI4b4RF0+OINLcJkd3kTmuT3l6K0cuCsIVMjN4BOeY?=
 =?us-ascii?Q?rnLoIqW/mFirZc6AnSLIbEwZg/siNxLk39DReCqC3loewD5347csSAbAOKQh?=
 =?us-ascii?Q?PSyIT22TiRZxQVJncmVVx9BB/MrK36JMfrLD3SJrxVm4RjNsflxLwv46eGO8?=
 =?us-ascii?Q?G5Be58pPKgirvjogE6tYmZ+Q0tqq4PYZBes6ygLYEdOJSzQla+i0fMSfsem7?=
 =?us-ascii?Q?z9rNm5IYNYYF/OnqVFGlLWqfHyb27bMI48ziA5wXukHEUEROCCO1YesNMzuX?=
 =?us-ascii?Q?CaZSjfn27fyqcV6XXYczrDGFgDM6leAuq/QXBIHyE8duZiRLLc1eghLjPX5w?=
 =?us-ascii?Q?tmckgykY+Py+3cTUFmJJ3A4I04nEfSdIQoIodsla228LoinFd0Y23Us/UyRI?=
 =?us-ascii?Q?8tM4GihxbY/7t1oR/Nv5xH+QBChehpPJakxr5PglWR7NRVo1JlgWCwSXQxJB?=
 =?us-ascii?Q?vFkeSe0d7o6PcBEG0YzeFbkB4J/uZYO94kBdyN3QnO9jmeoiu6ot2zdF15eX?=
 =?us-ascii?Q?YQioFntRmDUy8A4Ty6jvJPA+UjM4Ylza+jjeyocEUnC4x0xSTFaF6qDolgTu?=
 =?us-ascii?Q?6q7U99Xkae8BDjwNGTznbZCNIk/NuDJJzZupz/my?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cae99e6-7013-4af1-70fe-08db0a48b7cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 02:52:44.0296 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 28DxB21D3QhNNYwZD8zw49ihzYVGW7xzoqIxK+UCzFS46fdaHQlOK+WbSvctqdDL2Ep9V+fTFtnpsa8IHvBqKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7074
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Thursday, February 9, 2023 05:24
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gmc11: disable AGP aperture again

It seems not all of the issues with SDMA firmware have been resolved leadin=
g to spurious GPU page faults on some variants.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c  | 7 +++----
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c    | 1 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c   | 7 +++----
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c | 5 +++--  drivers/gpu/drm/amd/a=
mdgpu/mmhub_v3_0_2.c | 6 +++---
 5 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v3_0.c
index 7c069010ca9a..fa42d1907dfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -151,11 +151,10 @@ static void gfxhub_v3_0_init_system_aperture_regs(str=
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
index 0a31a341aa43..5e0018fe7e7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -673,7 +673,6 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_d=
evice *adev,

        amdgpu_gmc_vram_location(adev, &adev->gmc, base);
        amdgpu_gmc_gart_location(adev, mc);
-       amdgpu_gmc_agp_location(adev, mc);

        /* base offset of vram pages */
        if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v3_0.c
index 923fc09bc8fc..ae9cd1a4cfee 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -177,11 +177,10 @@ static void mmhub_v3_0_init_system_aperture_regs(stru=
ct amdgpu_device *adev)
         * these regs, and they will be programed at host.
         * so skip programing these regs.
         */
-       /* Program the AGP BAR */
+       /* Disable AGP. */
        WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE, 0);
-       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 2=
4);
-       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24)=
;
-
+       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, 0);
+       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, 0x00FFFFFF);
        /* Program the system aperture low logical page number. */
        WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
                     adev->gmc.vram_start >> 18);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/am=
d/amdgpu/mmhub_v3_0_1.c
index c8d478f2afdc..fb2f0eb72f69 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
@@ -173,8 +173,9 @@ static void mmhub_v3_0_1_init_system_aperture_regs(stru=
ct amdgpu_device *adev)

        /* Program the AGP BAR */
        WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE, 0);
-       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 2=
4);
-       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24)=
;
+       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, 0);
+       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, 0x00FFFFFF);
+

        /*
         * the new L1 policy will block SRIOV guest from writing diff --git=
 a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/m=
mhub_v3_0_2.c
index 51580302ec42..c30e40e52fb2 100644
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
2.39.1

