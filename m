Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481CDC3F2C6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 11:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E05432083E
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 11:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ecYR10bz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E05432083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A14676E968;
	Tue,  3 Mar 2020 11:04:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21BF76E968
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 11:04:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j59tXUt1BfRgOdyqFngrNnYAn/30qdqbjMAh2Twb6kd1UJ2c5r9gOZnhd/1EUBPjqhdIY2jJdtKs+e0RcZ/rghTNrY5FynfCkKsZrQhYyc5kRQJ2KR1cfuZ6POV5OngZr7CayM7WmqRFW6lhnD6VlY29t0nmtWa5UAoYmnIjZoMkjUIE83XDrN0X0THNE/q4irZQqgBclWmQe5z+xdiVvn7RlUdIzS75san+DuMUmn02aVRdmweiklKqFAki1RUaCnDtRgZM/CWWWzzm781rtifmcySuA8n6UVd8QCO+UVxsRx9jt6cHBYacoL5NhPADwr0PhcHkBoBpkAe9uzY+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drLWyZfJ4yneSUnsWhOmZfNhE+5pl3DEjc8Ok8PXy/U=;
 b=VoVSowdKZ1dkT8uPu03v4f/tV6jOJ6JaZc/vw8FJBNOzONoNzWuvf5tUuO7WVqImFvHw7uJ6YSdhQfihFi4DEHW5/7aefZsdGAPNOTZ/rZwzVFy+TeqizFD6DbjIcv2DonU9PwcwMF5cJgrVaeHzSiL61MxXDi8nzGw7/OvCtjZGz6tNLU2jKXme65XopyB/imCtv/PWQ2zroXDjQq2xBMkTsOb4WKfmn6Sto+im4SdlQWVESA4Zx+NW6nPUfRERXLO1WKcx3P10VxI1W3m6dCeThNz4Tzk5cMGKraM765hKaBqQ0Yd5IdgBQXXwH/6X7esLMQEw+hB4YopqWpNulQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drLWyZfJ4yneSUnsWhOmZfNhE+5pl3DEjc8Ok8PXy/U=;
 b=ecYR10bzrE53rmWMK/zrMqYn05Ii86cWgEAqUZ73IQphx5vb3pwK0VvBAJ4ZzIkduNj6cBoI4IXy75W5mM3cmgDYgll51JjlQuwXBSlVTXte+tVWNnDjAkABmuNzJd4phKodyAj1zoy4OgLzTuqItpSZL463bGYqzdUX+5WDD0Y=
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Tue, 3 Mar
 2020 11:04:53 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::b561:99b7:1db5:fcef]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::b561:99b7:1db5:fcef%5]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 11:04:53 +0000
From: "Zhou, Tiecheng" <Tiecheng.Zhou@amd.com>
To: "Zhou, Tiecheng" <Tiecheng.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov: skip programing some regs with new L1
 policy
Thread-Topic: [PATCH] drm/amdgpu/sriov: skip programing some regs with new L1
 policy
Thread-Index: AQHV8GFjmYS0JFqT2kuGqqwaD7ietag2tklQ
Date: Tue, 3 Mar 2020 11:04:53 +0000
Message-ID: <MN2PR12MB3775109D1C2821EDA3B93880E4E40@MN2PR12MB3775.namprd12.prod.outlook.com>
References: <20200302070806.32034-1-Tiecheng.Zhou@amd.com>
In-Reply-To: <20200302070806.32034-1-Tiecheng.Zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-03T11:04:51Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=bcbf5c3e-2f5f-4959-8df0-0000dd045df0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-03T11:04:51Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 285ad260-6465-4258-a86f-000084e91cc9
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tiecheng.Zhou@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b5c565a-ec76-48e5-8493-08d7bf62b3af
x-ms-traffictypediagnostic: MN2PR12MB4336:|MN2PR12MB4336:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB43360E23AAA119EB97493159E4E40@MN2PR12MB4336.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(199004)(189003)(86362001)(71200400001)(33656002)(110136005)(52536014)(5660300002)(53546011)(9686003)(7696005)(316002)(6506007)(55016002)(8676002)(26005)(64756008)(66946007)(76116006)(8936002)(66476007)(66556008)(66446008)(186003)(478600001)(2906002)(81156014)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4336;
 H:MN2PR12MB3775.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I+kGaVyo0YO1vu+Iaf9herv08W0BPf6Xs98jFLu1QsWVq6D/kpgrwTnShkqv+cCCJOdvXP7S8lMWusCXk9qI/m++ylguRa6EjYdJxWs8vpAG/RDiikggWetNUeAhgIOJPvXylkpZHJiEs3FZjDKz0mQgKRapX/htqr7kOBsxWY5ecUwQrX0vRkiCOEE9ZH66yQ15QlDnUV+HfTvMnO61pEaK/Mhlt6zXSeVkrPwY0p7WLHBDkzc6RRANGOQXnrUD9L/OrGkEAQdxRMw+8Wu22SmB5TwJI2SYKP03ahbJISurJPCaxtAOLPO2JOuVC4uzY/U4UEpSZX7U/fbZm6HRyiGZbdmG7OkjZnh/9xmgotFQ4jQAveRrfFfWLRDz2FhKEuceRKwT0GNOJdsrUKih9He/wQ8Ljn0gNYMw+bvuSozbiKsxeZANxkgHjYsPOsC9
x-ms-exchange-antispam-messagedata: /SlSFg/52kr4ho2fDxaFJwbr+EwwgWX+KK30OtL8+JiEIsLfzxMl3d2Z4YFhby2PaupdmP9acaCHrfAXGcnpWKIMUQFR8T7S+wtUtz11toWt3rpcWDLXUqfq9LP2pMe5V0JErxEmJvDtYY/EeLCZ3Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5c565a-ec76-48e5-8493-08d7bf62b3af
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 11:04:53.6820 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bTEND9ycVj6Up6staMKAeAhVA5jGLOTMtNR2RgdWUTUoyCQRk0bMTGFxJYQrOhVv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Ping

-----Original Message-----
From: Tiecheng Zhou <Tiecheng.Zhou@amd.com> 
Sent: Monday, March 2, 2020 3:08 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou, Tiecheng <Tiecheng.Zhou@amd.com>
Subject: [PATCH] drm/amdgpu/sriov: skip programing some regs with new L1 policy

With new L1 policy, some regs are blocked at guest and they are programed at host side. So skip programing the regs under sriov.

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
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 55 +++++++++++-------------  drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 29 ++++++-------
 2 files changed, 37 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index e0654a216ab5..cc866c367939 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -81,24 +81,31 @@ static void gfxhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)  {
 	uint64_t value;
 
-	/* Disable AGP. */
-	WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BASE, 0);
-	WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_TOP, 0);
-	WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BOT, 0x00FFFFFF);
-
-	/* Program the system aperture low logical page number. */
-	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
-		     adev->gmc.vram_start >> 18);
-	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-		     adev->gmc.vram_end >> 18);
-
-	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start
-		+ adev->vm_manager.vram_base_offset;
-	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
-		     (u32)(value >> 12));
-	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
-		     (u32)(value >> 44));
+	if (!amdgpu_sriov_vf(adev)) {
+		/*
+		 * the new L1 policy will block SRIOV guest from writing
+		 * these regs, and they will be programed at host.
+		 * so skip programing these regs.
+		 */
+		/* Disable AGP. */
+		WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BASE, 0);
+		WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_TOP, 0);
+		WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BOT, 0x00FFFFFF);
+
+		/* Program the system aperture low logical page number. */
+		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
+			     adev->gmc.vram_start >> 18);
+		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
+			     adev->gmc.vram_end >> 18);
+
+		/* Set default page address. */
+		value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start
+			+ adev->vm_manager.vram_base_offset;
+		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
+			     (u32)(value >> 12));
+		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
+			     (u32)(value >> 44));
+	}
 
 	/* Program "protection fault". */
 	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
@@ -260,18 +267,6 @@ static void gfxhub_v2_0_program_invalidation(struct amdgpu_device *adev)
 
 int gfxhub_v2_0_gart_enable(struct amdgpu_device *adev)  {
-	if (amdgpu_sriov_vf(adev)) {
-		/*
-		 * GCMC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
-		 * VF copy registers so vbios post doesn't program them, for
-		 * SRIOV driver need to program them
-		 */
-		WREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_BASE,
-			     adev->gmc.vram_start >> 24);
-		WREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_TOP,
-			     adev->gmc.vram_end >> 24);
-	}
-
 	/* GART Enable. */
 	gfxhub_v2_0_init_gart_aperture_regs(adev);
 	gfxhub_v2_0_init_system_aperture_regs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index bde189680521..fb3f228458e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -72,11 +72,18 @@ static void mmhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_TOP, 0);
 	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_BOT, 0x00FFFFFF);
 
-	/* Program the system aperture low logical page number. */
-	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
-		     adev->gmc.vram_start >> 18);
-	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-		     adev->gmc.vram_end >> 18);
+	if (!amdgpu_sriov_vf(adev)) {
+		/*
+		 * the new L1 policy will block SRIOV guest from writing
+		 * these regs, and they will be programed at host.
+		 * so skip programing these regs.
+		 */
+		/* Program the system aperture low logical page number. */
+		WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
+			     adev->gmc.vram_start >> 18);
+		WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
+			     adev->gmc.vram_end >> 18);
+	}
 
 	/* Set default page address. */
 	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start + @@ -247,18 +254,6 @@ static void mmhub_v2_0_program_invalidation(struct amdgpu_device *adev)
 
 int mmhub_v2_0_gart_enable(struct amdgpu_device *adev)  {
-	if (amdgpu_sriov_vf(adev)) {
-		/*
-		 * MMMC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
-		 * VF copy registers so vbios post doesn't program them, for
-		 * SRIOV driver need to program them
-		 */
-		WREG32_SOC15(MMHUB, 0, mmMMMC_VM_FB_LOCATION_BASE,
-			     adev->gmc.vram_start >> 24);
-		WREG32_SOC15(MMHUB, 0, mmMMMC_VM_FB_LOCATION_TOP,
-			     adev->gmc.vram_end >> 24);
-	}
-
 	/* GART Enable. */
 	mmhub_v2_0_init_gart_aperture_regs(adev);
 	mmhub_v2_0_init_system_aperture_regs(adev);
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
