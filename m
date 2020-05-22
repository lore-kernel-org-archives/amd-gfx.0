Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D297C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 06:12:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330202073B
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 06:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Dj2xNWZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330202073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B7746E313;
	Fri, 22 May 2020 06:12:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5EA36E2F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 06:12:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y944DVmEkv8OfAqHAPC8cyFPBXGbyqtPp+ZbC6ZDDPpXf9IQJEMC2M9XDCgLVk9cXUGBpBA9gsJPq6UUoMGgkrgCJ72n7qJuvxsQx/+4ivV51l29dRmt8wr/yu85XveXhHDEUzB2e4LhP2FsFm95uAFQx5BE0P1fFylPHQyb4rTFX7Nnf4zmsZpw/yUbLt7MkOdynaX1OiwtqfFwva0EptcOwERCQHllpURzYqtNlLP6KmP3g+JeKl/f+ctDpzIfCsQYPyN0rGtI74WAvOx59gws1ZqNnNINsE8FQGPLlRsuYgyQgAIDm7rWSZKx2OuomGSIoR64SU7ndgI12p/7GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6y3rj40VzXHNRhoIQQtt34FdFSEklb+ggx/Fc/+y6w=;
 b=l+i8zg+0nyi7m0a6m9UZr0BR+Nfv49mn6U4eueq6WP6QW5dWw2Y5gEvrQHsUmJMLWH6Y3GF0YtSPF5GRGuz94JR4tzce31Y+v9nn0lEyJutJ3hGWvihfEhq5o8nyvRFaRzsaSNOmqBpDFtoXS1Lyh2Whko7a0LDrM2uMpfcp2RvqXSksyvTmN5foTF16gDbAhNJBuRb9h3vNLtq2F6VuVnT+4IJpqmy4RD5FIZ93VdBlDpYugoWTEsSHWd2JiyctdkUYkGxwyY6Z5ZigyFAihcnoZFIOZG2rKSsR4w0w9sfRUKxWBm8sp1EJstQYVN0AhkCudqRN7MSe8T3ngNhNMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6y3rj40VzXHNRhoIQQtt34FdFSEklb+ggx/Fc/+y6w=;
 b=Dj2xNWZ3V7ZDRCRb50Mu+p4IBtGOat72XWdJTucze9SyOHACxXY12KLxzRVP5yV7Y3HPCX5sEROdOD/2N6D12ZYhjUdcygs9RN3Utwx97JB/uOfrNLmsjhU+gaaMBjINzWlBGlbbC9ExPrVfvtkFRBDxU4CF8s0SLZgdeuG5bDw=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB1627.namprd12.prod.outlook.com (2603:10b6:4:10::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Fri, 22 May
 2020 06:12:20 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::1833:ccab:8c0f:4570]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::1833:ccab:8c0f:4570%5]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 06:12:20 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, 
 "Chen, Guchun" <Guchun.Chen@amd.com>, "Wan, Gavin" <Gavin.Wan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for
 SRIOV.
Thread-Topic: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for
 SRIOV.
Thread-Index: AQHWL6l+4Ytr41evJ0yEh2yg17cX8Kizd/CAgAAW8QCAAAvYoIAABUSw
Date: Fri, 22 May 2020 06:12:19 +0000
Message-ID: <DM5PR12MB1708FA8F3EA7F11D2E2ABEC684B40@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20200521195306.261777-1-Gavin.Wan@amd.com>
 <CY4PR12MB1287CCDE92924A2C5BC25FC5F1B40@CY4PR12MB1287.namprd12.prod.outlook.com>
 <DM6PR12MB407522AD24A74063B1771BFDFCB40@DM6PR12MB4075.namprd12.prod.outlook.com>
 <DM5PR12MB1708563850356414C1427EFF84B40@DM5PR12MB1708.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1708563850356414C1427EFF84B40@DM5PR12MB1708.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-05-22T03:42:35Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=56b9b592-8362-45e3-af5a-0000edae5c03;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3893b340-5e34-48ea-30ce-08d7fe1715e5
x-ms-traffictypediagnostic: DM5PR12MB1627:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB16276BC677A74467022D9C0384B40@DM5PR12MB1627.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bm963DrdeL1kjJ1kDLwanLlEuTBngSQWp9NclR52Ca/z4QJ+GlCRamzq65fe15zvkAGeJgX25cEHbL/KGtzIetbhfrBNUl0NQH5epXX6pdeljxceB1jf1VjT/7dUoDq+OOSUKST68N5TZK27NCJovKFB8vZZvCIakVv3ZEDVC/iHkLH8C8gEfcYV/ffcC65EjGo/Ig2fI2J/berwyZ5xUzakr5KGq4bR6yEAh6CtMC8jtaiTxkuqpuwElWCM9RLXAcyOdX8ii9GOjeTuA9s5Bqo8RqNUpbSMqKZdj4XPvcisC243SYXW+1ARrZ1A/kCtC2GrUwAdWidgnp080X3gYrqmjrwCpLhwv7H7wchOtRY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(66476007)(66446008)(66946007)(64756008)(52536014)(76116006)(186003)(5660300002)(966005)(478600001)(8676002)(316002)(8936002)(110136005)(66556008)(55016002)(26005)(45080400002)(9686003)(6506007)(2906002)(71200400001)(33656002)(2940100002)(53546011)(4326008)(7696005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ZhNUNmREricPGkPEfGXv6aIqRGUAaQUDV+JOSzZChd8o3WGz8R1KCnwnc5TsNW3fJL+xFa/fA0jscIrH2JCj5/TtUmflKapztp+nD0tlPU0T6ctPOaSnxOG5V/GcabBPqDpRRFJqT5SbZJWmlZckP+eRmIuRYPu2g/89NWIVynXYDO5vLpBGUZrmJazLXpdstqVVI+PeLGN8ApFTa3GtNp01XzOSJFowknBvV+MJxENP8UdERIMRNEcUgLHyCPxdRTe9ct2WNmt9OGV5zGQRML4TnrDq8dOcWJl2urw8kR+xIPD/vjGIEXlqnMi/AAdEtbfozalbhcC1F6n3IjuYO8BdfUUx6QY+MUU9eapyxmUFMgj+hT93V/Hi3R/5Bjh/RxIL+tMLgNqiKToTMBaeOl8qf8TFadCbnOYy2+fBiVM1R9B920csXveJYac85De2ZYmKljyvDdzj2Orp6C52ZnJ2aPy1Jh+zmUWJP6NweuE9mSrQf3Wf92HGdhe6nDVV
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3893b340-5e34-48ea-30ce-08d7fe1715e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 06:12:20.0089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4XXLih8tjkjacnHKQ2ClMBdDvpNIi5EdUT5FsYUixafeIFNcHmMR2rDq9Se4CdId
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1627
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
Cc: "Wan, Gavin" <Gavin.Wan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Gavin

Looks the only place you need to change is the part of avoid touching "CP_INT_CNTL_RING0" which is handled by GIM now 

Others looks not needed at all

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liu, Monk
Sent: Friday, May 22, 2020 1:52 PM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Wan, Gavin <Gavin.Wan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Wan, Gavin <Gavin.Wan@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for SRIOV.

Sounds a good idea

@Wan, Gavin can you try hawking's advice ?

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, Hawking
Sent: Friday, May 22, 2020 1:09 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; Wan, Gavin <Gavin.Wan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Wan, Gavin <Gavin.Wan@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for SRIOV.

[AMD Public Use]

Can we leverage existing CG flags to control this rather than add amdgpu_sriov_vf(adev) check everywhere?

If GC CG feature is programmed by host. We can just mask out the following flags for guest driver case (amdgpu_sriov_vf(adev)).

AMD_CG_SUPPORT_GFX_MGCG |
	     AMD_CG_SUPPORT_GFX_CGLS |
	     AMD_CG_SUPPORT_GFX_CGCG |
	     AMD_CG_SUPPORT_GFX_CGLS |
	     AMD_CG_SUPPORT_GFX_3D_CGCG |
	     AMD_CG_SUPPORT_GFX_3D_CGLS

There are too many amdgpu_sriov_vf(adev) Check in amdgpu driver, which actually add unnecessary sustaining effort.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Chen, Guchun
Sent: Friday, May 22, 2020 11:47
To: Wan, Gavin <Gavin.Wan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Wan, Gavin <Gavin.Wan@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for SRIOV.

[AMD Public Use]

Please see one comment below.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Gavin Wan
Sent: Friday, May 22, 2020 3:53 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wan, Gavin <Gavin.Wan@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for SRIOV.

For SRIOV, since the CGCG is set on host side. The Guest should not program CGCG again.

The patch ignores setting CGCG for SRIOV.

Change-Id: Ic336fab3b23b8371c9e9e192182a3ba14a8db8e1
Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index bd5dd4f64311..52b6e4759cf3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4558,6 +4558,9 @@ static void gfx_v10_0_constants_init(struct amdgpu_device *adev)  static void gfx_v10_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
 					       bool enable)
 {
+	if (amdgpu_sriov_vf(adev))
+		return;
+
[Guchun]This coding style is not correct. You should put the check after the declare of 'u32 tmp'.
Maybe it's better to split below line to declare and execution parts respectively.

 	u32 tmp = RREG32_SOC15(GC, 0, mmCP_INT_CNTL_RING0);
 
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE, @@ -6842,6 +6845,9 @@ static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *ade  {
 	uint32_t data, def;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* It is disabled by HW by default */
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
 		/* 0 - Disable some blocks' MGCG */
@@ -6911,6 +6917,9 @@ static void gfx_v10_0_update_3d_clock_gating(struct amdgpu_device *adev,  {
 	uint32_t data, def;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* Enable 3D CGCG/CGLS */
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)) {
 		/* write cmd to clear cgcg/cgls ov */ @@ -6953,6 +6962,9 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade  {
 	uint32_t def, data;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
 		/* unset CGCG override */
@@ -6994,6 +7006,9 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade  static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 					    bool enable)
 {
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	amdgpu_gfx_rlc_enter_safe_mode(adev);
 
 	if (enable) {
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C0bb2f0a4f21948486b3708d7fe14366a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637257235100002661&amp;sdata=YG2D5uV7kD1mqPj3Bq8UicMrExQzyUaGIVJDxCryncE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C0bb2f0a4f21948486b3708d7fe14366a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637257235100002661&amp;sdata=YG2D5uV7kD1mqPj3Bq8UicMrExQzyUaGIVJDxCryncE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C0bb2f0a4f21948486b3708d7fe14366a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637257235100012654&amp;sdata=E7p%2Fkc5qh%2BxIvjGM5dxJs5VuqGHvVIb%2FeNeDemis07Y%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C0bb2f0a4f21948486b3708d7fe14366a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637257235100012654&amp;sdata=E7p%2Fkc5qh%2BxIvjGM5dxJs5VuqGHvVIb%2FeNeDemis07Y%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
