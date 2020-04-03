Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07D0C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 07:20:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B401B206F8
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 07:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Jcuef6FA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B401B206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 570626EB14;
	Fri,  3 Apr 2020 07:20:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B0F16EB14
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 07:20:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbAYiEIinh9SzDu4836kjcwBYarzNxbffNeZ7MTHspxTQCSptGIMkx/5OBjumREeHXlneJr+jTyuFepdmBImV1lxYGaTMAVysx+fGbcCS/NhB6JXS7v6B8OaX0pNjICcCC4buxV9CUFeSI1UR1pnOj6vmtAtkYaLVKXJ6koT4ngQn2aGdUyTdZRnH9iaJA8uHZ7A/ayEHxcVQB+LbrgXDy9hb+DLIYxIyLMOErEplRL1RA1JAgvLsNn99GAcV2EXO+8W9PmrX7gQj5oBt+LsWPnb7u8jaAAswWfAOhweQp5buaHBtRtavfoGTaqu7yK4C3441O61j+aicGkvqE5bbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSh10nu6rzkx0GcZlwOfSlSbvT3TXPfZjM41jBStCHc=;
 b=VpMPFV2tQoPCdxgc2IwVZBh3BwBkr6hCkmuw8CUN/1j610IAtmw6OgwUsondYom9F92rAKx0yO3pVs7u6yJuIHICKs/GFLTJvqJ9VxhxVNzuH3ILx0lvfDBIb6af7hQ6mJzNO+gIttEyNdt6jLeQDIB1IKLV/tiX3e3dRO72sm5+xyJzM2lkas57kItDPaVwn0mxRp5PPwDrn3TRkYg6eyqWPoKFGPHINiJkdCxWvsQsqHqBKnfjmdNebBqeTZiUWn7AdzDyGJ5zoZSURH3BmNcBnCBIgAz5/MRxJqOneu6edAr6SlRgS51gTFeQ9Jq9NwNzFo/Nfsi+uK/7s8tpEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSh10nu6rzkx0GcZlwOfSlSbvT3TXPfZjM41jBStCHc=;
 b=Jcuef6FAF3E9Tj6d3Sx78ivqN/00Gc+DiHEGUwHolkALTHTJ6dH229ZzwlNZMGlSo6AuUDHNeIBg31NtTVgjf4BwIVSVF6O664uzrj9eij/O/H0eW+7daf4QxdR52Wmwlghbb+PULDa/mho8oAv9c+8c2HzK9cy4QiyIfQOgjVg=
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (2603:10b6:208:d1::20)
 by MN2PR12MB3678.namprd12.prod.outlook.com (2603:10b6:208:158::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Fri, 3 Apr
 2020 07:20:15 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::5178:7eda:e982:2871]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::5178:7eda:e982:2871%5]) with mapi id 15.20.2878.014; Fri, 3 Apr 2020
 07:20:15 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Gui, Jack" <Jack.Gui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: Correct gfx10's CG sequence
Thread-Topic: [PATCH] drm/amd/amdgpu: Correct gfx10's CG sequence
Thread-Index: AQHWCYeR6SkKdAbSxkqVoHPSVKvLZ6hm/Tww
Date: Fri, 3 Apr 2020 07:20:14 +0000
Message-ID: <MN2PR12MB35984014787D8B64C29B16CE8EC70@MN2PR12MB3598.namprd12.prod.outlook.com>
References: <1585898013-7972-1-git-send-email-Jack.Gui@amd.com>
In-Reply-To: <1585898013-7972-1-git-send-email-Jack.Gui@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-03T07:20:11Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=4eea402e-906f-49e0-98dd-0000f90bb4a3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-03T07:20:11Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 2bc82780-768c-4322-b219-0000aea7ea5c
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kenneth.Feng@amd.com; 
x-originating-ip: [240e:e0:8f58:a400:a1cd:9901:63bd:358]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ce1bc2a2-1055-434a-d8f1-08d7d79f747a
x-ms-traffictypediagnostic: MN2PR12MB3678:|MN2PR12MB3678:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB36789E8E4F9542932645F0498EC70@MN2PR12MB3678.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3598.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(110136005)(7696005)(54906003)(86362001)(66946007)(6506007)(66476007)(2906002)(5660300002)(4326008)(66446008)(53546011)(64756008)(66556008)(76116006)(52536014)(8936002)(9686003)(316002)(55016002)(71200400001)(81156014)(33656002)(81166006)(186003)(478600001)(8676002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BCLpSW7JjjiygXdn1dBTuROhhbdhtpEC83NJXM3B6MyDyVCIFTPgZdoWXUqNmco+v4wQ4sSLOkFKuhaAZ5Vnbg3NgDL2QqR/44WMRO5IT4xSQGfU4xcyl4/2fluWTbqIFPZtAps18O9yT+11uhPXx9kUhM3nvZJ5MR6bl5Aag7DIgRIeRIQj5+a1KeYdfWqE+TOu8BdU7oMN6HlZTpDfpNbodwuntDenST86KXDF50lgbr//QOJi0D9ebCnviQWjMUA1oAhHD4DHQ5svbuxm8y15d0A0zXvlB/8SYdBq1GvMm/eEJdS9E0Zbc4uoSDFYFRbtPy5592LflPR3RYPPkVfPKWUsDkA+9LCX0NqEmh/xQEAbQvFbbIPbKFJKpsV69g5S+pU7nl/Bv1vz3zeUhTJty08HWXffs3WK94ULUQydKRt8vm5RxZWj77Ak+Ngq
x-ms-exchange-antispam-messagedata: qhaIR5577pqmRKqFgU8pO/xV62rlDMS2lJTD/K37Rku7OWOYxEHpWnDqYP9Lo3JbJpCl0VtiCZ+uqLdwKlbRYBW24UDbSyEfMcjdXu8mOpsC0ms1pG7Bn7j8mS9VTlpXie52hiP0aVMIR8fZEmPpxyuqhJg571FLHwo67ZJuq2C75TwcMGBb61DNMLZQn09mN91FwT6V+PLwf59rhblszw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1bc2a2-1055-434a-d8f1-08d7d79f747a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 07:20:14.8095 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +93rTzT6bxFskWUbbdavFwZgrWmj18XmpclVCmX+0Z/Wc4rP6rjzl/Ll1VeWhYbS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3678
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Gui,
 Jack" <Jack.Gui@amd.com>, "Yin, Tianci \(Rico\)" <Tianci.Yin@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

This sequence is confirmed in the design document.
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Chengming Gui <Jack.Gui@amd.com> 
Sent: Friday, April 3, 2020 3:14 PM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Gui, Jack <Jack.Gui@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Correct gfx10's CG sequence

Incorrect CG sequence will cause gfx timedout, if we keep switching power profile mode (enter profile mod such as PEAK will disable CG, exit profile mode EXIT will enable CG) when run Vulkan test case(case used for test: vkexample).

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
 		data &= ~(RLC_CGTT_MGCG_OVERRIDE__GRBM_CGTT_SCLK_OVERRIDE_MASK | @@ -4136,19 +4142,20 @@ static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *ade
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
