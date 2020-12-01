Return-Path: <SRS0=mtj4=FF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C244DC63777
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 01:53:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E164207FF
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 01:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tTFALZJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E164207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CCC689E1D;
	Tue,  1 Dec 2020 01:53:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBF6889E1D
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Dec 2020 01:53:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfNYC55KUnrzqdwoJbgz1Sgbnmp2pOsyQeKZFaHwT91xQ0Uha6l5Npq3wuDfHa5A6qOYpKU9WWbyaeBGFV+OBMdeY36HnWs/000apltvmhXW+J27NbrrMk5JeovY+IUJsBtSDFVFeqXfSY1csuiIbMmU7QHHmck1lHtPYmzPkUAnEl619JtGX9Lphmn8pTwP1AaancSMddRkr4Tkhda+tHlEKV6Q3cTjm5FAzvqQPPRNwV9G5t+G26QfTubNnZGL0SSkVBCsxq0e0tsMdU49BgHVauvYhpRZD9D+zJMA+p6WzsI1GlJZojZVS21vuOEA1l5wEqOBjA1ojqbuzssHmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDakHQ+N1lwIOvhBYV/NW0GmBxAFBe2alRjIZaGqvus=;
 b=QBxL/j4da0CeY1PzwOVp0WMRm295PE+Xw+sznNWKgLOE0r4tcZfdVvtrmKPoL6KBNJVvvdr8JkHpFK+5M1sc0kYgc9GILW6thhKGJ2stzD9P0/Qrw7aQkYYOOaOdm1GnRUfsbu2/5TEbYz86iPnrY6TExqpIuIXLz3PI+/IRPaiW1tvzelXOOvq6THm578Hrs9AGoiGMuZ4jVhK5Cv9z06Mke0mpiC7RsUM/qAUjCArqCHUOQfHMhAvxKF54H2AxU0nAmZBiysm6RCox0llnQlGijoGy6HMpUOoRGPttGugzK/lH8eJwwVJgcui+OONSEuAQkFiW0nXns3F7ftTLqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDakHQ+N1lwIOvhBYV/NW0GmBxAFBe2alRjIZaGqvus=;
 b=tTFALZJtGNUxZ1nZfr+PDopwC+g70zHOb73VQvFXvTIm8qZtPuZBD8cp+YcwdU/lv++thpO2bU2acN37jrHs6dThiNBRFWg/HgbynLQKFeHOrnzGNygMEQB2neDKbgVkE1olvH5a1doZY7ICPunLTF4nNFGciNK1Qml1Cg0uoP0=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.25; Tue, 1 Dec 2020 01:53:50 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3589.030; Tue, 1 Dec 2020
 01:53:50 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable AGP aperture on gmc10.x
Thread-Topic: [PATCH] drm/amdgpu: enable AGP aperture on gmc10.x
Thread-Index: AQHWxzAe7dJAsD17GUOLGQgthAycranheoGw
Date: Tue, 1 Dec 2020 01:53:49 +0000
Message-ID: <DM6PR12MB26199C1B48F2CCBCDC43EA5BE4F40@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201130154714.82710-1-alexander.deucher@amd.com>
In-Reply-To: <20201130154714.82710-1-alexander.deucher@amd.com>
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
x-ms-office365-filtering-correlation-id: f9add978-0442-4188-008d-08d8959bf2ee
x-ms-traffictypediagnostic: DM6PR12MB4516:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB45166097A24513F403B6BD02E4F40@DM6PR12MB4516.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DocpI5Dxh6iGH8qHRtp8Cbsck1/ZCKVQv0H2/7pJNDatYoClGWFLEm8GgnzptlPud/kIBsfqkIoM9LTPoslDwieq1J9rHDpz1A0IFfWjw3mJIq+Xjbz2olel5d4ELfdNu2SuPeJv7FGHggrL+frDtVT61/xDRacAEaUmkuuMmqWy2/0nNj75BvxKfIT29a0F7eXRHidyqIO7NIpJqxHucdr1YYfeOOL6Y69uG4u+6Ndv7RQMieYyW6orcZbv8x/Hl2CrXw7XrtqfQ6dvVR+BInXL6MiY7vtMiJxaIpq8eRZ6KkL7M+WmCFFSix164GdIuTLUjmMG2fFhaiJux6avY3IBoR4a2Othw9IHR2f4qKI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(53546011)(66476007)(8676002)(110136005)(316002)(2906002)(7696005)(33656002)(26005)(6506007)(8936002)(55016002)(9686003)(4326008)(186003)(66946007)(5660300002)(52536014)(86362001)(478600001)(966005)(83380400001)(76116006)(45080400002)(71200400001)(66556008)(66446008)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IXZhJDxyTlkUmacDBZZxez7vc+BZF9fDqKerI81BJ259pfdmER3Bn1M2J45a?=
 =?us-ascii?Q?RMz4AF/5uQ1okRVwYevFOXzXNsv0Hp28BvUpk7gvdkmb91DT6Z0J26PSe+PS?=
 =?us-ascii?Q?AjWOgPjvcn9MVJFJnW5e4Y+8eB51IGkbEMoM52glmJq3EVUpiTrk7geuplUs?=
 =?us-ascii?Q?Z3fA1ACFL3Dt2YapBtlWwLHKA5E8pOY6mdUMgM7z07PIstu8t+G+hB5p+R9Z?=
 =?us-ascii?Q?VM49TL7Rcot0WWy+SBNQa+C1ohlXtxDLFLI4MNEwFFxK4c4nK2iqYaralhUF?=
 =?us-ascii?Q?ce/0bcnZ65t/W6mEP7PZOhPdE09D46CM8LnMhgNkWBLobvb1AcXStSpo0WkU?=
 =?us-ascii?Q?q4tgqoJZG8V0H1LYDWLRjaTob/MNkLqvozDLqTqcdubFwKcahApPrM14XhKg?=
 =?us-ascii?Q?YM7FrCxHZwgoT7q0WOknu+jbWWwfR6uhkZtlHAR5O2npVfLTjsCk6FxuqOGl?=
 =?us-ascii?Q?o7471dEYiXTTOldP2DuweojlF86+kDN2KcNvN50Ju9X8ab58QrBYALRzxrHl?=
 =?us-ascii?Q?DnolG7h0l/Zm+sKXJU7demNhtIlktKWCz/tNETiqBuOq6wj8n5b7B/grKxmG?=
 =?us-ascii?Q?PxFMB693hx3FpRWuMIdy/M7T3bayku2b/dtG7E73lO++3IZbLWKbZRrz43qa?=
 =?us-ascii?Q?hAwZGSNSrxQWJcqbk0SC9JZSxPTQUwS5pjLB2+bBcDJ6HPYZ/QfJNeizkgBH?=
 =?us-ascii?Q?CFYm7KzISTZO15Va20zdKNrCHWT9JH8XkGVn+uxf5VNVeR3D+sqA4pajXtXF?=
 =?us-ascii?Q?1KGJn9tcqqo9DiylNXAmwqc5qDPjR+Vb/vw5E4MzsJFiuBfmj2CXpdqeIVNu?=
 =?us-ascii?Q?Mv4581sm6P84KT/dypr3dmkRnpNb/j7rm3V9Yq3cn6uMEGNCAfNmUdkynhow?=
 =?us-ascii?Q?8djK73lDGp+PEP076oPeO40XQN9ZPav3TUHsZxP8jchSkDKg5F2U9rDtVzzp?=
 =?us-ascii?Q?7Gu3lvgoEmiLH9EGP4yFM8jXaAYWRSquIG9hxfXLIMk=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9add978-0442-4188-008d-08d8959bf2ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 01:53:49.9536 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y7wXg+B8purcMsnA+kSCo2weTAjS1aQRV6GtUYLmk4gyM5XFkqepK8aIU1y8use7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
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

Hi Alex,

The followings seem missing in programming mmMMMC_VM_SYSTEM_APERTURE_LOW/HIGH_ADDR.
min(adev->gmc.fb_start, adev->gmc.agp_start)
max(adev->gmc.fb_end, adev->gmc.agp_end)

BR
Evan
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Monday, November 30, 2020 11:47 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: enable AGP aperture on gmc10.x

Just a small optimization for accessing system pages directly.
Was missed for gmc v10 since the feature landed for older gmcs
while we were still on the emulator or gmc10 and we use the AGP
aperture for zfb on the emulator.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 6 +++---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c  | 4 ++--
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
@@ -152,10 +152,10 @@ static void gfxhub_v2_1_init_system_aperture_regs(struct amdgpu_device *adev)
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
 /* Program the system aperture low logical page number. */
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
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
