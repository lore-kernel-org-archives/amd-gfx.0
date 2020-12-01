Return-Path: <SRS0=mtj4=FF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC783C63777
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 01:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39542207FF
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 01:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aCubV/8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39542207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0B3E89E52;
	Tue,  1 Dec 2020 01:58:08 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750073.outbound.protection.outlook.com [40.107.75.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F18CE89E52
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Dec 2020 01:58:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQKK/pHcXIASROQflgn3oUq2K4Bn0/b/62tykb9dKHjyEW1/1U+LydcDGdR3E3s8LtwcwFamQ2vbjKobJa8JE38IthP0guyRrC/mLifVaNBWXJEljJ+ehrw6fxGCfTqxesCZzUj3yO83LW2ILw0+w4hK8zH2F4gaLSxR/e8esm0MBQp8rA+Sujo2Abjp5QSli3IysRXrlSkpWq7HO5nR6OXWEhHHrQdUlmUVrDd/NltwOWOavvmK1ZFonzbDpK5wl9atm7zGmWCI0DMxxrL3qdqDP0UuDL9xaPZW82Z7XeJ5im1BjduXdBdb0UMidzhk+qU9LnSVh6k1WmkQCDi0jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnwmede1Ebd9J5wQvpf0pJ3mZKVUHoJFR7f1Vos0vE4=;
 b=BTiLORSLw6qtSXU31/YS2+o6Houe59sNVf+DZXxWAKVfXHbCmBvPn0xit6ax3mr+/dtvdDlIlLeUtpoS0HsF99wgcE2w4qgfh7g23k5oySZ5/EEGcJYE+buCA4wud3VkndOBMt/Ds5gsF1YaY0TKIxuMSgCQd56HFJYvV2rKyCfzcRgtrfcV2zRjQPmFnXdL8ntPRwiF6HonRptbVpmE3ZOWnAP0dfdNiTWCQcS66G4kkpwkB1SSg/u8Q5r347jEgNO5zrouH1seSmewyilg3YNwItsYiA6xIKaLKjXFB69cNP/SE6C8fIaO4j12foA55GZGhtspi37KgV6vP4VL5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnwmede1Ebd9J5wQvpf0pJ3mZKVUHoJFR7f1Vos0vE4=;
 b=aCubV/8yRTrg5+SY8TjR77I0zgamBPlKDz+G85lYwnQal/LOzMnYvHViZVpQ1ZLTv1w+c0LITJJu3GZad6fnCrfYZUeFE7ubkZ03moWBMMXXuqNlkE2YokZnmvCPdG/MnMLDf1CPQYyUEl7gsRHKay0gEJSER3zsrCrffaHISTU=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3466.namprd12.prod.outlook.com (2603:10b6:5:3b::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.31; Tue, 1 Dec 2020 01:58:05 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3589.030; Tue, 1 Dec 2020
 01:58:05 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable AGP aperture on gmc10.x
Thread-Topic: [PATCH] drm/amdgpu: enable AGP aperture on gmc10.x
Thread-Index: AQHWxzAe7dJAsD17GUOLGQgthAycranheoGwgAABxbA=
Date: Tue, 1 Dec 2020 01:58:05 +0000
Message-ID: <DM6PR12MB2619CDA9C016E09773DF9CFEE4F40@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201130154714.82710-1-alexander.deucher@amd.com>
 <DM6PR12MB26199C1B48F2CCBCDC43EA5BE4F40@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26199C1B48F2CCBCDC43EA5BE4F40@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=606a1ec7-3176-4a72-b613-86c96987a6bd;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-01T01:51:10Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1a668c5a-5296-4ea9-29e5-08d8959c8b27
x-ms-traffictypediagnostic: DM6PR12MB3466:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3466E0E07F2BB1DA142ADC54E4F40@DM6PR12MB3466.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ofp7bteDgxEQQ7Itp+QF2aKR0YF0J0X5Ha/UdwRjD5J/U6dRdkE7/Axz3InacnF7jj9qB+/knUfVR9dCERiVQKPGSV/y+CtIdEkpV6/jyHFEv4hRfk/k1GsHlAVA6Sp7vv7Ex1SR9I8YOT8bCRzr7/ZNXhf5+jQzRW6Qo89tmYwNpUBkVIHlO23Z4H6Bhjz6OahuSO1QyZ577P0oFlUKTJ5GX8yEZH6Zg3x+DmWs5MrUFlSnEulZrj6FgkT2Az2wPZ6SdWgex6sXLq/mQ4Phy5+k4kURYIkqWwuyR62hSgLmNpZFpjzBwY6vIzbWRcbMcSC1c6030vz3HEIEPk7+y3ZwlWPjUrN9H6ZpTCS4d9M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(316002)(478600001)(110136005)(45080400002)(4326008)(55016002)(9686003)(71200400001)(83380400001)(33656002)(6506007)(66446008)(8936002)(186003)(66476007)(7696005)(26005)(64756008)(66946007)(66556008)(76116006)(86362001)(2906002)(2940100002)(8676002)(5660300002)(52536014)(966005)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mY1Uh7vTvRIvSPIuk1X5L+SwBB83B5z7AcyWomUpd9Zd+TYyqrSCLF1G28Vc?=
 =?us-ascii?Q?boNo8PbOP70h0/CHwsTZo0gVu6Oeu8/v+OVdjBEj+MiBg9G2RsnR32uRYV+R?=
 =?us-ascii?Q?IVKJlF6l9pIsWZXmZTOrJu2wBBZAphEV3FcA4Xm6F1MzNSM8HPhgIw6KmG4y?=
 =?us-ascii?Q?HSOKCyKMDkppbENYDBndCk1mxXmwcbXHOtfVShr9z51I6vhl6BdrBGaAmvIS?=
 =?us-ascii?Q?o6dQ8swOj9/CX7DOj5ZdtEyVW2VHABLCFzj5IL9GI2iNWZ1MoYcb1/iKu9ri?=
 =?us-ascii?Q?xhpXFaGCoBGZO/6/CFNXVHyHUYJKAfQcGjaefJgGyEthjp6ohToHeZT+ATTp?=
 =?us-ascii?Q?Ggy3cTBDrjQ6HllWlX8TpcmAFFnb/wnRn0drfnwHqTygGxA8uzrJvvF8xN5D?=
 =?us-ascii?Q?ZwDnqhfIA2/54VUoT7Ujh1dieAVe8G8rWTrgZ0dqb95bd/oIg1Ilj48cyFni?=
 =?us-ascii?Q?obEumIwY3GD4y8BxXg8GW5q94CIDls52r3Xsoq4rf8Cjco+FfhjsaIx6YmB3?=
 =?us-ascii?Q?6MyU8xx7Zp/PwlFQI2xjIsGDUtTbM5iqUvMxj4N0nrODPQ9cSGPYgJI3lFEk?=
 =?us-ascii?Q?AWzQqG18dX4tDE616a8RNVaANeVVuQgE3A367bfMLl2QJK+2iw8Dk2L74SUh?=
 =?us-ascii?Q?K0fFn1yhi99xqc7NmcBVcc9KQJY+ie4Ig2qwJwmbKWz5Lc3DTkPZU/+psR2r?=
 =?us-ascii?Q?70yJYvwpRu6il2up1Jtl3JCM/NYwHIvd1Br9DoyrLcrqy/C/fuxmbFWOgHnE?=
 =?us-ascii?Q?rOM1f5tpY8nM6mDZbGF7FztFv7FtkT2imLJ9rmIJAENJNA8OyWOOkYWr6EPY?=
 =?us-ascii?Q?N+tNOMMubBS8Jppr+Y4G79JLTyYaRXXHbnj13zNapR8wdMhurxiohcAoOBuI?=
 =?us-ascii?Q?oMrALYl9pRRBpVSfrE7q1/2PSHNGxsu5HOlc5D3f3uqfG7PfGDuGLd5fIfpr?=
 =?us-ascii?Q?bSmG0qgfG9z6SS147hfJKeZFAAhF0Q3YOgaV0nuq3Pw=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a668c5a-5296-4ea9-29e5-08d8959c8b27
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 01:58:05.4023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aGg8al6fxEZjOjLyS7av+6jd1xIU1p6RWVe1vUEaUkxtPCYj087hkgkpdQ7oqVJ4
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

Never mind. I just saw you fixed this in V2.

-----Original Message-----
From: Quan, Evan
Sent: Tuesday, December 1, 2020 9:54 AM
To: 'Alex Deucher' <alexdeucher@gmail.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: enable AGP aperture on gmc10.x

Hi Alex,

The followings seem missing in programming mmMMMC_VM_SYSTEM_APERTURE_LOW/HIGH_ADDR.
min(adev->gmc.fb_start, adev->gmc.agp_start) max(adev->gmc.fb_end, adev->gmc.agp_end)

BR
Evan
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Monday, November 30, 2020 11:47 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: enable AGP aperture on gmc10.x

Just a small optimization for accessing system pages directly.
Was missed for gmc v10 since the feature landed for older gmcs while we were still on the emulator or gmc10 and we use the AGP aperture for zfb on the emulator.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 6 +++---  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 6 +++---  drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c  | 4 ++--
 5 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 456360bf58fa..51606d2c346c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -153,10 +153,10 @@ static void gfxhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
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
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 724bb29e9bb4..95a50fadbd54 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -152,10 +152,10 @@ static void gfxhub_v2_1_init_system_aperture_regs(struct amdgpu_device *adev)  {
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
index 4ac8ac0c56c8..c539685948de 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -195,10 +195,10 @@ static void mmhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
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
 /* Program the system aperture low logical page number. */ diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index 3a248c8cd0b9..5372704889cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -152,8 +152,8 @@ static void mmhub_v2_3_init_system_aperture_regs(struct amdgpu_device *adev)

 /* Disable AGP. */
 WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_BASE, 0);
-WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_TOP, 0);
-WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_BOT, 0x00FFFFFF);
+WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);

 /* Program the system aperture low logical page number. */
 WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C7f0f5596ad8a48bfa60908d895473f9e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637423480528407402%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=9I6SUwJnzu7nVwSLszuP9kUV7mYKtzEgePzINgUmVEQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
