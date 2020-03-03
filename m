Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FBBC3F2C6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 21:42:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D87A20728
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 21:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hWE5dvmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D87A20728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 069AD6E0F5;
	Tue,  3 Mar 2020 21:42:12 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760088.outbound.protection.outlook.com [40.107.76.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C70D6E0F5
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 21:42:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0JTCncirDV173FYtX24Oz+Yw8I1/sK6Xaql6jIpjfthDbW1/omlOQ1LmOpV71CgO3/Ip1zOdTAznpGAejDcdhQtyCWwUs6o5sbEwhKwxlCFu2F5kQK77NYg4l/NEB1/z/Pp45uNHlu2yxs+aYM2HySQ7TaFwyrKdW5EOV+7UxEdpOhPic+vzBOi6uwECnQSaR1z5vHc64vGVGGFqI9AzafoRqtKi6UoVb6+QC2HdDJnKzISx0cJZJ9PQuFq8j54GqHiROAQ1sizRkd7lZMLDKVMbDqHwvHou/9mNSW5vwW2/Y/LqROMDp2UCjNFYKjxrAVko7Ruf5Y1+Nix2BMFSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsgeLvgqLo1vFQD5+T2f3B5U9H+O0+32GI0QAxI4t4I=;
 b=f7vd/LuxTrao/Mt4UoCN3dr1xynlVj9Tw3AYFTpX8QbdO3N1lIZYAkaN5Lx1BKV8/TxwM2hkDe0+0sQEwd1R8X1/I6Y2rjEHLtZzC0Uv9KSAfjoLZ6hrXZpgpI6quVs4QcmWH7UoS4vHQt86ydodfBcDEhnsI1q0623e2bkh5oudXnIb7bBYN5j2m69W/myCyUAM1/a07GDQEbX2SYHC4+nqFsVaIyzHDrjV4OTpdMLaPP3ooRMasye3j+PMpVBfmaHz01mMp8e7kjGstsVU6C3MlPe6CiMRnfjeDAkaW9heMKWnWQmxDTw++mgdhcbfy7zdReGeWE9lSKIgKINEEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsgeLvgqLo1vFQD5+T2f3B5U9H+O0+32GI0QAxI4t4I=;
 b=hWE5dvmCVJDWJkRBN3ya4NT2VrId2/z2P3l2AUcWt3GmueNU1mZMKSjJ34VDnvjTVLSQJgdGuYBXju9TnOt6NVaTdVO3w99WUEaUKV5YJE6sadB/jSIiaN9NnsmC69SnEXygRPEhdCUsOjv8peLORDiQEukQ+6YvKJUpfr8Vu+8=
Received: from CH2PR12MB3912.namprd12.prod.outlook.com (2603:10b6:610:2c::22)
 by CH2PR12MB4151.namprd12.prod.outlook.com (2603:10b6:610:78::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Tue, 3 Mar
 2020 21:42:07 +0000
Received: from CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167]) by CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167%5]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 21:42:07 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhou, Tiecheng" <Tiecheng.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/sriov: skip programing some regs with new L1
 policy
Thread-Topic: [PATCH] drm/amdgpu/sriov: skip programing some regs with new L1
 policy
Thread-Index: AQHV8GFk7EI+92JcAUuGYnoUhtA/QKg2tl6AgACx1fI=
Date: Tue, 3 Mar 2020 21:42:07 +0000
Message-ID: <CH2PR12MB39124EA3D88F2BF9F803BF7AF7E40@CH2PR12MB3912.namprd12.prod.outlook.com>
References: <20200302070806.32034-1-Tiecheng.Zhou@amd.com>,
 <MN2PR12MB3775109D1C2821EDA3B93880E4E40@MN2PR12MB3775.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3775109D1C2821EDA3B93880E4E40@MN2PR12MB3775.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-03T21:42:07.060Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.40.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f9a750c8-22a1-465b-bedc-08d7bfbbb8e2
x-ms-traffictypediagnostic: CH2PR12MB4151:|CH2PR12MB4151:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4151BA6B20DD5358AB9DA47CF7E40@CH2PR12MB4151.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(199004)(189003)(8676002)(45080400002)(8936002)(19627405001)(478600001)(33656002)(316002)(110136005)(2906002)(81166006)(86362001)(966005)(81156014)(71200400001)(5660300002)(55016002)(9686003)(64756008)(76116006)(6506007)(66476007)(7696005)(66556008)(52536014)(53546011)(66446008)(186003)(66946007)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4151;
 H:CH2PR12MB3912.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IrVUqjhg9JzyTwBDpQhcZ2o+YN+rB6ar0cQlc1psNy10pXG8/Af4h23vKMnKlqyCeZViJLpZfvY8U37WUqs0yoCI2cKz93K/F7+XywehASJSXwaMF4Uz7OsR9hYH7wJsTVcDlHT/msB1mIqRUp5IpgK3K8nEGeCF3m5i9Knn6T7fdfdOhDHbzmeK4Rde/axgY4LdemPv0Wwzj8bYnIa1HbvR6jpcW1JyOXqgc1dyrTPflp/P+WDCdUIVZWgM8ax6rUCmWBzFJnoJAyjFcj7E0zNMcS+n8U26bT5PLoTd06HkfsYQrybrKa83VkVNKOIzj54Jg8GgmwY2p1Yr3t1HCFG8S65NZ0rOvDwkQjmK6BGTwnatetIchSTK9IY4i5QBm3lS8kvI2TI2XmgslAMCdMJwkdDGU7n9Gs/nN+1SmQ4c8VptRSyEDcTdCMw/1F+PtwnCdtIqGsnXVU8zs/5ztv8hA/McmAO6Qn6/0xhqEzo=
x-ms-exchange-antispam-messagedata: Pmws7tDpBRw3o4OD/SYeyu12M0KdoEGZ+mnMmgxLg6bq9XPLDSe2tq2C2xmTXHuUU+2AwcSBSs3Dlgkrm1dilRCOl9odTS3LiYmtPDilNLUkAUKTgUyLzMzb9VqssCI9yFwnJxFjX7SLMAzSmNqIiA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a750c8-22a1-465b-bedc-08d7bfbbb8e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 21:42:07.6282 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EqStrE2olObxjJ4Z3p1XvgyWkTidSMouWeaKp2UmiBzXy1qjeiZVEjsL1JNRi9IVhoNa4TDYhJK71bpwGtqsIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151
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
Content-Type: multipart/mixed; boundary="===============0729706554=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0729706554==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB39124EA3D88F2BF9F803BF7AF7E40CH2PR12MB3912namp_"

--_000_CH2PR12MB39124EA3D88F2BF9F803BF7AF7E40CH2PR12MB3912namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Acked-by: Alex Deucher <alexander.deucher@amd.com>

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Zhou, Ti=
echeng <Tiecheng.Zhou@amd.com>
Sent: Tuesday, March 3, 2020 6:04 AM
To: Zhou, Tiecheng <Tiecheng.Zhou@amd.com>; amd-gfx@lists.freedesktop.org <=
amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov: skip programing some regs with new L=
1 policy

[AMD Official Use Only - Internal Distribution Only]

Ping

-----Original Message-----
From: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
Sent: Monday, March 2, 2020 3:08 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou, Tiecheng <Tiecheng.Zhou@amd.com>
Subject: [PATCH] drm/amdgpu/sriov: skip programing some regs with new L1 po=
licy

With new L1 policy, some regs are blocked at guest and they are programed a=
t host side. So skip programing the regs under sriov.

the regs are:
GCMC_VM_FB_LOCATION_TOP
GCMC_VM_FB_LOCATION_BASE
MMMC_VM_FB_LOCATION_TOP
MMMC_VM_FB_LOCATION_BASE
GCMC_VM_SYSTEM_APERTURE_HIGH_ADDR
GCMC_VM_SYSTEM_APERTURE_LOW_ADDR
MMMC_VM_SYSTEM_APERTURE_HIGH_ADDR
MMMC_VM_SYSTEM_APERTURE_LOW_ADDR
HDP_NONSURFACE_BASE
HDP_NONSURFACE_BASE_HI
GCMC_VM_AGP_TOP
GCMC_VM_AGP_BOT
GCMC_VM_AGP_BASE

Signed-off-by: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 55 +++++++++++-------------  dr=
ivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 29 ++++++-------
 2 files changed, 37 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v2_0.c
index e0654a216ab5..cc866c367939 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -81,24 +81,31 @@ static void gfxhub_v2_0_init_system_aperture_regs(struc=
t amdgpu_device *adev)  {
         uint64_t value;

-       /* Disable AGP. */
-       WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BASE, 0);
-       WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_TOP, 0);
-       WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BOT, 0x00FFFFFF);
-
-       /* Program the system aperture low logical page number. */
-       WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
-                    adev->gmc.vram_start >> 18);
-       WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-                    adev->gmc.vram_end >> 18);
-
-       /* Set default page address. */
-       value =3D adev->vram_scratch.gpu_addr - adev->gmc.vram_start
-               + adev->vm_manager.vram_base_offset;
-       WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
-                    (u32)(value >> 12));
-       WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
-                    (u32)(value >> 44));
+       if (!amdgpu_sriov_vf(adev)) {
+               /*
+                * the new L1 policy will block SRIOV guest from writing
+                * these regs, and they will be programed at host.
+                * so skip programing these regs.
+                */
+               /* Disable AGP. */
+               WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BASE, 0);
+               WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_TOP, 0);
+               WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BOT, 0x00FFFFFF);
+
+               /* Program the system aperture low logical page number. */
+               WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
+                            adev->gmc.vram_start >> 18);
+               WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
+                            adev->gmc.vram_end >> 18);
+
+               /* Set default page address. */
+               value =3D adev->vram_scratch.gpu_addr - adev->gmc.vram_star=
t
+                       + adev->vm_manager.vram_base_offset;
+               WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_=
LSB,
+                            (u32)(value >> 12));
+               WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_=
MSB,
+                            (u32)(value >> 44));
+       }

         /* Program "protection fault". */
         WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
@@ -260,18 +267,6 @@ static void gfxhub_v2_0_program_invalidation(struct am=
dgpu_device *adev)

 int gfxhub_v2_0_gart_enable(struct amdgpu_device *adev)  {
-       if (amdgpu_sriov_vf(adev)) {
-               /*
-                * GCMC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase the=
y are
-                * VF copy registers so vbios post doesn't program them, fo=
r
-                * SRIOV driver need to program them
-                */
-               WREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_BASE,
-                            adev->gmc.vram_start >> 24);
-               WREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_TOP,
-                            adev->gmc.vram_end >> 24);
-       }
-
         /* GART Enable. */
         gfxhub_v2_0_init_gart_aperture_regs(adev);
         gfxhub_v2_0_init_system_aperture_regs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v2_0.c
index bde189680521..fb3f228458e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -72,11 +72,18 @@ static void mmhub_v2_0_init_system_aperture_regs(struct=
 amdgpu_device *adev)
         WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_TOP, 0);
         WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_BOT, 0x00FFFFFF);

-       /* Program the system aperture low logical page number. */
-       WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
-                    adev->gmc.vram_start >> 18);
-       WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-                    adev->gmc.vram_end >> 18);
+       if (!amdgpu_sriov_vf(adev)) {
+               /*
+                * the new L1 policy will block SRIOV guest from writing
+                * these regs, and they will be programed at host.
+                * so skip programing these regs.
+                */
+               /* Program the system aperture low logical page number. */
+               WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
+                            adev->gmc.vram_start >> 18);
+               WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
+                            adev->gmc.vram_end >> 18);
+       }

         /* Set default page address. */
         value =3D adev->vram_scratch.gpu_addr - adev->gmc.vram_start + @@ =
-247,18 +254,6 @@ static void mmhub_v2_0_program_invalidation(struct amdgpu=
_device *adev)

 int mmhub_v2_0_gart_enable(struct amdgpu_device *adev)  {
-       if (amdgpu_sriov_vf(adev)) {
-               /*
-                * MMMC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase the=
y are
-                * VF copy registers so vbios post doesn't program them, fo=
r
-                * SRIOV driver need to program them
-                */
-               WREG32_SOC15(MMHUB, 0, mmMMMC_VM_FB_LOCATION_BASE,
-                            adev->gmc.vram_start >> 24);
-               WREG32_SOC15(MMHUB, 0, mmMMMC_VM_FB_LOCATION_TOP,
-                            adev->gmc.vram_end >> 24);
-       }
-
         /* GART Enable. */
         mmhub_v2_0_init_gart_aperture_regs(adev);
         mmhub_v2_0_init_system_aperture_regs(adev);
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C5c67ab87ec474567746608d7bf62b5ce%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637188303458046365&amp;sdata=3DxQ%2Fx7i5LhvDFFZ%2B=
OJzhJYPr0TbHLpUW4NrbBxvcvyaE%3D&amp;reserved=3D0

--_000_CH2PR12MB39124EA3D88F2BF9F803BF7AF7E40CH2PR12MB3912namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Zhou, Tiecheng &lt;Tiecheng=
.Zhou@amd.com&gt;<br>
<b>Sent:</b> Tuesday, March 3, 2020 6:04 AM<br>
<b>To:</b> Zhou, Tiecheng &lt;Tiecheng.Zhou@amd.com&gt;; amd-gfx@lists.free=
desktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu/sriov: skip programing some regs wit=
h new L1 policy</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">[AMD Official Use Only - Internal Distribution Onl=
y]<br>
<br>
Ping<br>
<br>
-----Original Message-----<br>
From: Tiecheng Zhou &lt;Tiecheng.Zhou@amd.com&gt; <br>
Sent: Monday, March 2, 2020 3:08 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhou, Tiecheng &lt;Tiecheng.Zhou@amd.com&gt;<br>
Subject: [PATCH] drm/amdgpu/sriov: skip programing some regs with new L1 po=
licy<br>
<br>
With new L1 policy, some regs are blocked at guest and they are programed a=
t host side. So skip programing the regs under sriov.<br>
<br>
the regs are:<br>
GCMC_VM_FB_LOCATION_TOP<br>
GCMC_VM_FB_LOCATION_BASE<br>
MMMC_VM_FB_LOCATION_TOP<br>
MMMC_VM_FB_LOCATION_BASE<br>
GCMC_VM_SYSTEM_APERTURE_HIGH_ADDR<br>
GCMC_VM_SYSTEM_APERTURE_LOW_ADDR<br>
MMMC_VM_SYSTEM_APERTURE_HIGH_ADDR<br>
MMMC_VM_SYSTEM_APERTURE_LOW_ADDR<br>
HDP_NONSURFACE_BASE<br>
HDP_NONSURFACE_BASE_HI<br>
GCMC_VM_AGP_TOP<br>
GCMC_VM_AGP_BOT<br>
GCMC_VM_AGP_BASE<br>
<br>
Signed-off-by: Tiecheng Zhou &lt;Tiecheng.Zhou@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 55 &#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;-------------&nbsp; drivers/gpu/drm/amd/amd=
gpu/mmhub_v2_0.c&nbsp; | 29 &#43;&#43;&#43;&#43;&#43;&#43;-------<br>
&nbsp;2 files changed, 37 insertions(&#43;), 47 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v2_0.c<br>
index e0654a216ab5..cc866c367939 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c<br>
@@ -81,24 &#43;81,31 @@ static void gfxhub_v2_0_init_system_aperture_regs(s=
truct amdgpu_device *adev)&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t value;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Disable AGP. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BAS=
E, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_TOP=
, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BOT=
, 0x00FFFFFF);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Program the system aperture low lo=
gical page number. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_=
APERTURE_LOW_ADDR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_start &gt;&gt; 1=
8);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_=
APERTURE_HIGH_ADDR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_end &gt;&gt; 18)=
;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set default page address. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D adev-&gt;vram_scratch.gpu_a=
ddr - adev-&gt;gmc.vram_start<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &#43; adev-&gt;vm_manager.vram_base_offset;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_=
APERTURE_DEFAULT_ADDR_LSB,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (u32)(value &gt;&gt; 12));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_=
APERTURE_DEFAULT_ADDR_MSB,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (u32)(value &gt;&gt; 44));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /*<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * the new L1 policy will block SRIOV guest from writin=
g<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * these regs, and they will be programed at host.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * so skip programing these regs.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* Disable AGP. */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BASE, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_TOP, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BOT, 0x00FFFFFF);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* Program the system aperture low logical page number. */<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_start &gt;&gt; 18);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_end &gt;&gt; 18);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* Set default page address. */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; value =3D adev-&gt;vram_scratch.gpu_addr - adev-&gt;gmc.vram=
_start<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &#43; adev-&=
gt;vm_manager.vram_base_offset;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_L=
SB,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; (u32)(value &gt;&gt; 12));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_M=
SB,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; (u32)(value &gt;&gt; 44));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Program &quot;protectio=
n fault&quot;. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGCVM=
_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,<br>
@@ -260,18 &#43;267,6 @@ static void gfxhub_v2_0_program_invalidation(struc=
t amdgpu_device *adev)<br>
&nbsp;<br>
&nbsp;int gfxhub_v2_0_gart_enable(struct amdgpu_device *adev)&nbsp; {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /*<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * GCMC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase the=
y are<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * VF copy registers so vbios post doesn't program them, fo=
r<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * SRIOV driver need to program them<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_BASE,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;gmc.vram_start &gt;&gt; 24);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_TOP,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;gmc.vram_end &gt;&gt; 24);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GART Enable. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfxhub_v2_0_init_gart_aper=
ture_regs(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfxhub_v2_0_init_system_ap=
erture_regs(adev);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v2_0.c<br>
index bde189680521..fb3f228458e5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c<br>
@@ -72,11 &#43;72,18 @@ static void mmhub_v2_0_init_system_aperture_regs(st=
ruct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, mmM=
MMC_VM_AGP_TOP, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, mmM=
MMC_VM_AGP_BOT, 0x00FFFFFF);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Program the system aperture low lo=
gical page number. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYST=
EM_APERTURE_LOW_ADDR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_start &gt;&gt; 1=
8);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYST=
EM_APERTURE_HIGH_ADDR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_end &gt;&gt; 18)=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /*<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * the new L1 policy will block SRIOV guest from writin=
g<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * these regs, and they will be programed at host.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * so skip programing these regs.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* Program the system aperture low logical page number. */<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_start &gt;&gt; 18);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_end &gt;&gt; 18);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set default page addres=
s. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D adev-&gt;vram_sc=
ratch.gpu_addr - adev-&gt;gmc.vram_start &#43; @@ -247,18 &#43;254,6 @@ sta=
tic void mmhub_v2_0_program_invalidation(struct amdgpu_device *adev)<br>
&nbsp;<br>
&nbsp;int mmhub_v2_0_gart_enable(struct amdgpu_device *adev)&nbsp; {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /*<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * MMMC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase the=
y are<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * VF copy registers so vbios post doesn't program them, fo=
r<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * SRIOV driver need to program them<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(MMHUB, 0, mmMMMC_VM_FB_LOCATION_BASE,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;gmc.vram_start &gt;&gt; 24);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(MMHUB, 0, mmMMMC_VM_FB_LOCATION_TOP,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;gmc.vram_end &gt;&gt; 24);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GART Enable. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmhub_v2_0_init_gart_apert=
ure_regs(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmhub_v2_0_init_system_ape=
rture_regs(adev);<br>
--<br>
2.17.1<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C5c67ab87ec474567746608d7bf62b5ce%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637188303458046365&amp;amp;sdata=3D=
xQ%2Fx7i5LhvDFFZ%2BOJzhJYPr0TbHLpUW4NrbBxvcvyaE%3D&amp;amp;reserved=3D0">ht=
tps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.fre=
edesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexan=
der.deucher%40amd.com%7C5c67ab87ec474567746608d7bf62b5ce%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637188303458046365&amp;amp;sdata=3DxQ%2Fx7i5LhvD=
FFZ%2BOJzhJYPr0TbHLpUW4NrbBxvcvyaE%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH2PR12MB39124EA3D88F2BF9F803BF7AF7E40CH2PR12MB3912namp_--

--===============0729706554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0729706554==--
