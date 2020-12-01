Return-Path: <SRS0=mtj4=FF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C36C63777
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 01:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A545C20715
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 01:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SxvBIENZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A545C20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1269D89E52;
	Tue,  1 Dec 2020 01:56:58 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750058.outbound.protection.outlook.com [40.107.75.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D211B89E52
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Dec 2020 01:56:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hna1U82iVtaxyq90H+1k3G+9rlM4Gbg+EaVpXM4F3iIV1l9RHD/IZqIkI50ey7a1CUtIKDBueXlpYG5K+48bFPow8soe424RZQzwFFXb74DS7T0g9xqJmJVwqBl+Det8seyVUGGfSk5dCMeFE2i06dw1l8IJa3D957hjhzBmezTDhkOrQb2StRSVSH+60XBEypJIfZnzXhaGOuZnBEya35QryxJUrtuDN2omSkcxRaunXmdXmup9HvjUKPR+ZgiSJi771fRzKMQIFafW631nr86i9x7sObMssIU9ckt47SJKzlq6JYuBkrP5ef6alZszSAzKpN/1iMfYQ8E7rbudfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyeJuIToHcVovdOvuUVjT4a1kkGSU9kxeqnu3KCahso=;
 b=SUZJUWQ4bGxsAUeeIA2OxopfYNzvYTlaSR+9kPGwPihbjTm4qwKuLxyLt2sniTGNyFcnErB90gdFMIu/NNteVwZcJLgyzgtN436NH8bECG2sZxZh9nlPAi7Nx5SdWpE6rtdR6COpVMG5mgEVTG7MN1sa6lwKv081iF6T0oc2WO4LVB4Abp+R+5gOR5kmVjHb4d4uWnxpm4bgvu63DqIID1etKOp755gIEwpqYFfhl7ZrUqoMix+95lgqCNciRZ86lMNHAxVdVJS0vIX4t/qyQtF/66930LW27MtlySvhbqV3opWEEe6i2jjgSwdGjt3D27tUAawTNNg7uKEsCQu+PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyeJuIToHcVovdOvuUVjT4a1kkGSU9kxeqnu3KCahso=;
 b=SxvBIENZ76BCLPfGXNpjQrpescx13G9nokySGCKKe3Cjz0D0Mu/W/W+2VEz0Di9g1y1VWxzgRwEEiEkmN76yR/hrgo3KWgrweDcFYV4MiGhFdAHWf6TgKVvq2aCnbf+t9W8Lt8O1JHPaNMJ28JbxUhRozKnArcDVAnqBvoTPGFU=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3466.namprd12.prod.outlook.com (2603:10b6:5:3b::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.31; Tue, 1 Dec 2020 01:56:53 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3589.030; Tue, 1 Dec 2020
 01:56:53 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable AGP aperture on gmc10.x (v2)
Thread-Topic: [PATCH] drm/amdgpu: enable AGP aperture on gmc10.x (v2)
Thread-Index: AQHWx2KutguzIAgag0CPLq2TICrQh6nhe3nQ
Date: Tue, 1 Dec 2020 01:56:52 +0000
Message-ID: <DM6PR12MB2619948B81D872E65F346428E4F40@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201130214916.3621-1-alexander.deucher@amd.com>
In-Reply-To: <20201130214916.3621-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a6bd672e-e95f-41e6-a382-03a3afdf1795;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-01T01:56:03Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 369d3480-9344-4252-5682-08d8959c6006
x-ms-traffictypediagnostic: DM6PR12MB3466:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB34666F95B937758BF73858F0E4F40@DM6PR12MB3466.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jzFv2CWzGSK+e33DslK+UhcsmKYK6tqUaOKGhL8R8Sib3kPIdUsXOSwiUg81hO5ZRoiw4THrUTJ20zpPNY8ZAsa9/4MYRvmlagNJeZ0AVbDkYxiL5Dp+2f6n820MN8HqSm/l00Cb9BHeC/c6PT/oxpo+1F+bo7K4tIzLETsDwnO2h8Kb84IJGwrIKmVRYtfQN7kMyDhhl1sV2PiLqyfvNLINXoXbpPqo++EPCekVqZrtyBcIMuyxg7NqsVuxBWPW6kKh539n3rKg9q1IzSlozkTR5dFYWHxV2CPiYgCbcZS8h8t+bDz4gu6H+8h3GimtbhpndyujShMyrH3RU4HkYjXMx7Nup8eRPJ0qXb+XoX0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(316002)(478600001)(110136005)(45080400002)(4326008)(55016002)(9686003)(71200400001)(83380400001)(33656002)(6506007)(66446008)(8936002)(186003)(66476007)(7696005)(26005)(64756008)(66946007)(66556008)(76116006)(86362001)(2906002)(8676002)(5660300002)(52536014)(966005)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gibYcyoqa/lBJdXlCGbkBg63Nx5t7+Kf5KaHrTaqO+zth98ySaQpmmkPNMUB?=
 =?us-ascii?Q?Zk7LuEZcEg5YiokaS5lFnuFsBisMdtWAwyEj2RixQZjCGdbRcxpKnIi3aXNf?=
 =?us-ascii?Q?ZPoj8RyHK9A2agKsCtRZoaL0q5co1PLf1ZXwp8dxKv29w0q9I/7qE5KHPvbZ?=
 =?us-ascii?Q?KR+wwIT0nzn3PRzrcyfY2sltTBZ1rR8QHvgvJBTWHlrjbZT9LO6dt5dJIKg+?=
 =?us-ascii?Q?N3hSDqVRM2+iJrNMxtpUGJOVX9WDRFh5q0r8lKj1PtmwLa04kikhkVE9OpoV?=
 =?us-ascii?Q?hushlMt84IqpibGY9YJ/kQM9ysAEqfGDtIU0uwi5AxuSBMhXATiIbsNIw1Sz?=
 =?us-ascii?Q?Dzp148XkzrqM84qVnSsB4x6YrI7qjeOEV+cFutzlyxfPh/sdUVZMNplruX40?=
 =?us-ascii?Q?scGXZq828qgkQVkLjkkZWWc9kE3egd5/TOOljzvTWvax9FdZjbT6xFTThW0p?=
 =?us-ascii?Q?/43p5KBHFTRtSZDI6eF60lBhS7GtKXb7FWKfn5ufb2RmNmWh+Uz2PZCCTFEE?=
 =?us-ascii?Q?EBFsUX1GBW2HYi5CLGz9H15d4vzJliuBAMrkzPgQ9dOgcyeGYj916faI4Euw?=
 =?us-ascii?Q?B0GwFdwmWXLxc65fyTxGu+NAk3rcVz4WR3z6Y1zSxwxzf3nQM9Nq+PodqhKd?=
 =?us-ascii?Q?yt/KjqbBiyJhnTF1+3VJVWzO9D6oGKZREK3jOsTtyqP/1KLX72WyfZy9M3AH?=
 =?us-ascii?Q?af7eO437tlYoVfFljD9zBrjrTTSYwFhtBF+ZBdahyQ3aG37YDTLrn4sFykwI?=
 =?us-ascii?Q?KVnJ1JhBO1/Xa7ljXfO9gmnrDZj4eIWu89BC4311+LrY9AbVR6D02ImWDxWs?=
 =?us-ascii?Q?dVgBpOjnB9drJpyplQvdX2Z9oJE+2L/W2wYy30gBCruMUSafWK0NXNhhXmQ7?=
 =?us-ascii?Q?EYu3pZkk10FUTgRCqRIw8cfTvycSKri3RtG01DMUGYtPBBnrnS1wcUCjoBka?=
 =?us-ascii?Q?1YuznZH9LT27MbpadjqKJxzLdXQFymtKffspVazTv9s=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 369d3480-9344-4252-5682-08d8959c6006
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 01:56:52.9867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZxKhzHn+VDTuuumTqRDdmGdWcyCCXbyDgSgOsnbX5fnC8CNESvH4Bbn3Ni6U/y4L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3466
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-and-tested-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Tuesday, December 1, 2020 5:49 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: enable AGP aperture on gmc10.x (v2)

Just a small optimization for accessing system pages directly.
Was missed for gmc v10 since the feature landed for older gmcs
while we were still on the emulator or gmc10 and we use the AGP
aperture for zfb on the emulator.

v2: fix up the system aperture as well

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c  |  8 ++++----
 5 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 456360bf58fa..2aecc6a243e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -153,16 +153,16 @@ static void gfxhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 uint64_t value;

 if (!amdgpu_sriov_vf(adev)) {
-/* Disable AGP. */
+/* Program the AGP BAR */
 WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BASE, 0);
-WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_TOP, 0);
-WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BOT, 0x00FFFFFF);
+WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);

 /* Program the system aperture low logical page number. */
 WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
-     adev->gmc.vram_start >> 18);
+     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
 WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-     adev->gmc.vram_end >> 18);
+     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);

 /* Set default page address. */
 value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 724bb29e9bb4..410fd3a1a388 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -152,16 +152,16 @@ static void gfxhub_v2_1_init_system_aperture_regs(struct amdgpu_device *adev)
 {
 uint64_t value;

-/* Disable AGP. */
+/* Program the AGP BAR */
 WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BASE, 0);
-WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_TOP, 0);
-WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BOT, 0x00FFFFFF);
+WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);

 /* Program the system aperture low logical page number. */
 WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
-     adev->gmc.vram_start >> 18);
+     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
 WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-     adev->gmc.vram_end >> 18);
+     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);

 /* Set default page address. */
 value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 4f6e44e21691..518233d71e6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -738,6 +738,7 @@ static void gmc_v10_0_vram_gtt_location(struct amdgpu_device *adev,

 amdgpu_gmc_vram_location(adev, &adev->gmc, base);
 amdgpu_gmc_gart_location(adev, mc);
+amdgpu_gmc_agp_location(adev, mc);

 /* base offset of vram pages */
 adev->vm_manager.vram_base_offset = adev->gfxhub.funcs->get_mc_fb_offset(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 4ac8ac0c56c8..57d5f8ffb764 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -195,17 +195,17 @@ static void mmhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 uint64_t value;
 uint32_t tmp;

-/* Disable AGP. */
+/* Program the AGP BAR */
 WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_BASE, 0);
-WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_TOP, 0);
-WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_BOT, 0x00FFFFFF);
+WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);

 if (!amdgpu_sriov_vf(adev)) {
 /* Program the system aperture low logical page number. */
 WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
-     adev->gmc.vram_start >> 18);
+     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
 WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-     adev->gmc.vram_end >> 18);
+     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 }

 /* Set default page address. */
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index 3a248c8cd0b9..fa77eae6cf47 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -152,14 +152,14 @@ static void mmhub_v2_3_init_system_aperture_regs(struct amdgpu_device *adev)

 /* Disable AGP. */
 WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_BASE, 0);
-WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_TOP, 0);
-WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_BOT, 0x00FFFFFF);
+WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);

 /* Program the system aperture low logical page number. */
 WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
-     adev->gmc.vram_start >> 18);
+     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
 WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-     adev->gmc.vram_end >> 18);
+     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);

 /* Set default page address. */
 value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C6ee0433d41a14f53272c08d89579cf69%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637423697692471563%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=M04SDfOaV8f7kKkm5RLjAV64JtC0WZATVDbI1KaDUvk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
