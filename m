Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B19DC43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 07:32:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D752206E9
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 07:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Xzphowlx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D752206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C0976EB17;
	Fri,  3 Apr 2020 07:32:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D7926EB17
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 07:32:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+uajwgKgHndjduKzLQx/+qQFg7Rx/7wQXlAiDHDcVXsB7oRlH0WWe0AJ3ndkNS4eIhaz+PCvT38Y024ghaT2+aaryV2KfPjF8RumFEqA699iWRNTqj0IrvuKWRc3yH7CevXjnUrVsDPCIcBQEH+hiirLMLNCYxsxkBR5tyzhKJ8kbGyrPSINWso968S4GIUXX+jO/iJFqWys900JBTtj4504ycotzu13dMzNdJVPyuBVyiDbl1CBzFD3C5YsbL00o5tFHIIwj7n8nyV6aDO1VXvFovRzdkos0OICt3uZgk+Q6sJ8B1D4+Am3G2meH5n6x2qG8vZA0J1mv/YCbvA6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awmL/ZLRHRNVvgsCqWL+CAlzgZFWmPez/SZhcL92rw4=;
 b=GXJpF/d3e2X0j9e9aVFRMnoTLEKdoRe9NQSvpi3C1nZq4xNiI2MMP+kcRktnYsUzX+dp7Qv66E+Lo6tNdeAmWd7Yoea4+pvFJ1Fetz80FHEdRb/dBVMlt/0FYDjeMFRd+Mgdx3vAyyOgbYKqX4kDLwrx8IuohoHz1LTlLHjWp6wSbRGzehTDruOjdj7yt9y47o8llWvsVwhhf9+GaD9ZcMWU5MVQWp0CrGyjnmfTleP8XyRX+ituIZk8N0eLYFk7iekJ9L6ixe5yHZKyZuh7TyGXDUQjc/iXMW8xkx5xSztHHx7412nNcPtsxXpkOkX42Kvojf9UUWo/lCv6aSuRlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awmL/ZLRHRNVvgsCqWL+CAlzgZFWmPez/SZhcL92rw4=;
 b=XzphowlxcYe6pifVXNgazHsybC4+8KRbYaUQJbR0XhO0sAVL9QeHGYMdXUbsupgcPoo2AwIhvU2MdpSOa1j8/HVAYc7laBSeSMLrXsh8pF+AMeyFdJpmVBWKmtZy1u2jcAgclDtgqJYJ5gBcGtIrZVSVfa6L8fjy8UPPhCTjimk=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 3 Apr
 2020 07:32:51 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2878.016; Fri, 3 Apr 2020
 07:32:51 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Gui, Jack" <Jack.Gui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: Correct gfx10's CG sequence
Thread-Topic: [PATCH] drm/amd/amdgpu: Correct gfx10's CG sequence
Thread-Index: AQHWCYeRFAUaZK6mtUisSDP40g6Aa6hnAQHA
Date: Fri, 3 Apr 2020 07:32:51 +0000
Message-ID: <MN2PR12MB334481AD5BA7E42A0F1A61F3E4C70@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <1585898013-7972-1-git-send-email-Jack.Gui@amd.com>
In-Reply-To: <1585898013-7972-1-git-send-email-Jack.Gui@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=1cab8ab0-18f7-42e7-b0d4-00006a907c95;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-03T07:32:31Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d546c4f4-8a7f-42bf-2095-08d7d7a13757
x-ms-traffictypediagnostic: MN2PR12MB4341:|MN2PR12MB4341:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB434121F2568E4D857B6578B0E4C70@MN2PR12MB4341.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3344.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(66446008)(54906003)(71200400001)(33656002)(26005)(316002)(55016002)(478600001)(4326008)(186003)(9686003)(6506007)(2906002)(53546011)(5660300002)(66556008)(8676002)(7696005)(86362001)(110136005)(64756008)(8936002)(81166006)(52536014)(81156014)(66946007)(66476007)(76116006);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LMNWh/kCxQTyNUBq7Xl12XnS74QJEmb2HnLQQVqCoWBM8fuMGmyy5C5qLEyvwUuNOYI65tKo36uCiTpQeue9iTP3Fu+nGxdA9EXKiSKB/v6xOUDERIimrExw4IBvRWVVg26VJAmQ3z7FskxCjBP5zTpx8lMUuv8yY+o8g8f3pmcnqUfye54rc5vEJtypnfcwkZ8295QZukZVk8FhPuqOthSuHEbL2K40vzdi5bgpmUpGjcAts+lp692Sr7/YwZ30XfX7NJrQbOfZ59tKrDEjIz9ejm52Z88uxr73dBeL2KzgF0wHIu70ZBo2zgk3g1+ZYHG/XgL65lJlizy3jo/Pcyi+iW1ozCgarmo73zdtxDhcvu2MD3iuH/3IqZsQXrH6yuOzXACz1QkOmjKe92w+PZaDqKuezKDcQ7CcxJltYad2Mst93GiUbieIYHI+l66t
x-ms-exchange-antispam-messagedata: auwLGgySYrh3rkWVIdpKKy9ET0GamU5ujW+LV4NkJdxAL+8rORJIGksDRxpECWiir6t0LbMR4SFw07zZtqMe/w1tkc91/YqjHi4uaTUe0V5utEcibdKJFpVPuo5Aie3ojligm97OcbYVJlP1CD//uw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d546c4f4-8a7f-42bf-2095-08d7d7a13757
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 07:32:51.3468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WjMGGzDyGkph2f1yGm8DfMTNQGL5FaFQcwQUgEHDK4fE0h/p41Jcfif7iZPbajs2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Yin,
 Tianci \(Rico\)" <Tianci.Yin@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Gui, Jack" <Jack.Gui@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Chengming Gui <Jack.Gui@amd.com> 
Sent: Friday, April 3, 2020 3:14 PM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Gui, Jack <Jack.Gui@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Correct gfx10's CG sequence

Incorrect CG sequence will cause gfx timedout,
if we keep switching power profile mode
(enter profile mod such as PEAK will disable CG,
exit profile mode EXIT will enable CG)
when run Vulkan test case(case used for test: vkexample).

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 51be7aa..1439dd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4097,6 +4097,12 @@ static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *ade
 
 	/* It is disabled by HW by default */
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
+		/* 0 - Disable some blocks' MGCG */
+		WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, 0xe0000000);
+		WREG32_SOC15(GC, 0, mmCGTT_WD_CLK_CTRL, 0xff000000);
+		WREG32_SOC15(GC, 0, mmCGTT_VGT_CLK_CTRL, 0xff000000);
+		WREG32_SOC15(GC, 0, mmCGTT_IA_CLK_CTRL, 0xff000000);
+
 		/* 1 - RLC_CGTT_MGCG_OVERRIDE */
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
 		data &= ~(RLC_CGTT_MGCG_OVERRIDE__GRBM_CGTT_SCLK_OVERRIDE_MASK |
@@ -4136,19 +4142,20 @@ static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *ade
 		if (def != data)
 			WREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE, data);
 
-		/* 2 - disable MGLS in RLC */
+		/* 2 - disable MGLS in CP */
+		data = RREG32_SOC15(GC, 0, mmCP_MEM_SLP_CNTL);
+		if (data & CP_MEM_SLP_CNTL__CP_MEM_LS_EN_MASK) {
+			data &= ~CP_MEM_SLP_CNTL__CP_MEM_LS_EN_MASK;
+			WREG32_SOC15(GC, 0, mmCP_MEM_SLP_CNTL, data);
+		}
+
+		/* 3 - disable MGLS in RLC */
 		data = RREG32_SOC15(GC, 0, mmRLC_MEM_SLP_CNTL);
 		if (data & RLC_MEM_SLP_CNTL__RLC_MEM_LS_EN_MASK) {
 			data &= ~RLC_MEM_SLP_CNTL__RLC_MEM_LS_EN_MASK;
 			WREG32_SOC15(GC, 0, mmRLC_MEM_SLP_CNTL, data);
 		}
 
-		/* 3 - disable MGLS in CP */
-		data = RREG32_SOC15(GC, 0, mmCP_MEM_SLP_CNTL);
-		if (data & CP_MEM_SLP_CNTL__CP_MEM_LS_EN_MASK) {
-			data &= ~CP_MEM_SLP_CNTL__CP_MEM_LS_EN_MASK;
-			WREG32_SOC15(GC, 0, mmCP_MEM_SLP_CNTL, data);
-		}
 	}
 }
 
@@ -4259,7 +4266,7 @@ static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 		/* ===  CGCG /CGLS for GFX 3D Only === */
 		gfx_v10_0_update_3d_clock_gating(adev, enable);
 		/* ===  MGCG + MGLS === */
-		gfx_v10_0_update_medium_grain_clock_gating(adev, enable);
+		/* gfx_v10_0_update_medium_grain_clock_gating(adev, enable); */
 	}
 
 	if (adev->cg_flags &
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
