Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954A8C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 05:46:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 279B3613CA
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 05:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279B3613CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9673B6E9BD;
	Tue, 11 May 2021 05:46:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A59E66E9BD
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 05:46:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1zuXRaP4xea67YtERvlhWkVm5P3Th9P3bxkpVVIwgPj73+NgF1zrmJZs4onPN2s9z5gfnM7xRTis0pZjztxoUVQRTM9rvF6T0nS6RrqNp+jNvBzluxpweXTVOaNhOxZNxx8MYtHbqYdMSTLkijjN3ci8DZleiDz217htdj31dqVKKKDEGNS2JPWqQ27+Igwu8EWQglXJlP2oIyvDbqaSxa0vQpudhUzIrmqpjJPwVEtxAZ9OIdElBMlEgnbQhwg9oDNFsVJQHJAmmxcQ0al5/NllrJNDndaH4NY2K6Yd/DpL6FSyX3HHGRSLw/WzVD/bUYJoZj0iTvOpWmgNdkQPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/K3hC1wJwiMvg9qXIl+dxvsKbOK4vY0d9Gg1BDUjkRA=;
 b=Y0t3s/S9TRsDhd9DU3icAQ9yG4fNTgETvjcBdHgbo+MEF8ynuhiqH2wEUNEAxR7AGcrPwPw6X7+sVAFToonUuTsQQ6Xhel85huB3O7JfmBAhLStDgj9o4Jz+Y65uq2I/wlm9M1zBrCldMsja9L3pPcDnCpJqEaec9Lae9eg3NuaNuMXI+r6819ZwokeS9MgbMQId72eMaUlWUX/x2R7GKXkqh+42ecOzFAp2WelL1Rf5MioUbw9JJBxL6Bmj3mw61LnxM91gD/HxcZSZEYWi11PYUIkaENAn22wxq7TpoV8utmI/X8UsXfyrSlDipI3XfLhFHZ3Qr9SmblZ6Tc9JSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/K3hC1wJwiMvg9qXIl+dxvsKbOK4vY0d9Gg1BDUjkRA=;
 b=3uCpsMxXIeX5G/B3eYPc4o+p/mc6t5lJS1Y5PEZ0jDEsvqFL45nHgIIq5wPbvlbZ1IYi+pej40sip6s2PyKlIRsRtDIyEaBxuroTKT9C0SVoWaLDXxXdf2K6CJRKJfPrtY45LU4SfJKUorZF/81dukYJzrfD04CkVfqEdv23ko8=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5076.namprd12.prod.outlook.com (2603:10b6:610:e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 11 May
 2021 05:46:50 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4108.032; Tue, 11 May 2021
 05:46:50 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Wang, 
 Kevin(Yang)" <Kevin1.Wang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: seperate the dependency between CGCG and CGLS
 when diable CGCG/CGLS
Thread-Topic: [PATCH] drm/amdgpu: seperate the dependency between CGCG and
 CGLS when diable CGCG/CGLS
Thread-Index: AQHXPL4zyFydLvOlVUegoEmpGm5Zo6rd154w
Date: Tue, 11 May 2021 05:46:50 +0000
Message-ID: <CH0PR12MB5348336B4B81DFA48346E04297539@CH0PR12MB5348.namprd12.prod.outlook.com>
References: <20210429060853.4144-1-changfeng.zhu@amd.com>
In-Reply-To: <20210429060853.4144-1-changfeng.zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-11T05:46:38Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=55b8329a-aa3d-4606-8c81-b81defc1c0d0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [117.206.36.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 991dc9c7-3356-470f-281b-08d914402c84
x-ms-traffictypediagnostic: CH0PR12MB5076:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB5076C8D113B309D4BBE22B6397539@CH0PR12MB5076.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R4gRwLHpXmgUe+QTeMXMFqdPmj0YOFuCdjWsciE+ckjBoctjtg5TdJ6dLb+dVbstM1h95ugUZimK7lIZSkFrr2yx3XIX3zRkC8cF0Jkv8VhEPurerRaw12NnidEGTuYrQPDSJn26xnN++Zasv6GZXTklk9OGUnL4nrgw0JHbYEuG9DYB5TAG45G8zferYpLbr0CRrkvLTT9w7l7e8aSVLXw+PYhvDbc6boYQCPecTKjIZSBnqd8v+dyE6ZHDIeflr7CnWYXR9GqgRQ0n/DuHrzTKu5xdfOcYfGKdva1ANSvcadd9VbksOI6aHN7Vue7t3ldSNoxz6v+6W02gHGuVFxK4CtiaJDA8ebRPporR6EeLHjUNo4cPuY6AUcH74OPQ5tt3cO27Ez1IYwhw/cXTOyg8DrGRRAVOoVOMcvWpTXBFM+oPRHkJ2uPiY32gYu1bleL38cAsU6Z7029D85ZYc5+KhpGz8Az4rxonSmvQRZaw0uLKBY394atxHZoXI4OaOLok+g4c+m0j8ijGdVI+HY4CcZR5/E3oxLw/BRar7GXQtyWh/U7iXybiEz3nUv1ihQ2IsGh20LYaVcZovEqQMITKWhUKogdUEfERJUrHqd3WZrBzhg+XL2y9tcoG/JkwHJKTlH1s70OjbR64JXjqqA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(346002)(376002)(366004)(396003)(136003)(38100700002)(966005)(33656002)(478600001)(45080400002)(5660300002)(55016002)(6636002)(53546011)(6506007)(86362001)(71200400001)(8936002)(110136005)(26005)(4326008)(8676002)(316002)(2906002)(122000001)(76116006)(66446008)(7696005)(186003)(66556008)(66946007)(66476007)(64756008)(9686003)(83380400001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?09pMIWw61iMkdTCeXSTu4+U1n+zByRpNWOM/dpu0Fh9/z9gu/Ha3kEkP+j70?=
 =?us-ascii?Q?WCXhjFrjGSvSkHrfpukj57OJs0lv7J6T/8VcLvpy/rneaRNjCQnI/9fQcTw4?=
 =?us-ascii?Q?YaJUjHu4uwEU1Kc0E42EknA20O9xx7so/YUT9OKu24yW64ykPNsVx8dnAQqC?=
 =?us-ascii?Q?qzfCcHa+ctsG+2O4/pbhzS5y7WIEbV+cpfliECIfPH59+FNHJ4yIa8O+vXER?=
 =?us-ascii?Q?T7BhfayQtbLcsQyWWLSNEZ2F61tYbtFOVSh1p46hCMG5Wv9BfzTVCblWNNu7?=
 =?us-ascii?Q?FeeR3PETZ2qq4KaiL976rI5CtVVXPj3tX+7wMNxe6Qrk2uIXx5OTSmgRE6pT?=
 =?us-ascii?Q?eKW61GfYNco0J40h+b0QicaTPYS06mqZ26LGsLi30AR3J2So9qa6C/BvpO70?=
 =?us-ascii?Q?0vq2xtDjW/MDj3ha4yd7XNyR6JNegQC1lmONvcXZWriXlNFzv//4Ds99w1wa?=
 =?us-ascii?Q?uoPRF7igSOnQkMfO3NPdZsQ2bmncsKtg5GFjptnzFwHEdkQnCAhc+wsMYwtZ?=
 =?us-ascii?Q?umzyEbDT/A8+TC4h18eBwfEPsu875O/Exar7oj13TYODqpXRgzX8jfYbD8hk?=
 =?us-ascii?Q?wRZrsQ8nE+i1nxDTgUDu0ERMn4nj20s/H7lCcdvkcVOvsq3BZbSPGtheb4+b?=
 =?us-ascii?Q?XTfQkHtcTlbzrOBeAvv2N5nLZVirpAmEHhAGxb8rbc4lcQIYci+z4xE+NWyM?=
 =?us-ascii?Q?rc5cJiuQLDfjyR4zM8px8AlIo32vYUd2CVfB8rDxm34NhUkCz1k1oLXMZw+i?=
 =?us-ascii?Q?5xaFVAMSuHlaVKjgN/URvs17uIl52PxMPtB6IIsN9P98HCpwP/wF6T1XVmYJ?=
 =?us-ascii?Q?UGjSMKW56XTykywuFR0Nc0DfQuBjVZ03e1j/BweGmJDhhOM4g+MjpM6zHMdR?=
 =?us-ascii?Q?G98wqZxFQkMa7xygGI07QxhragtEa3iBO7v7q4XXh1q7almEPKjUHyIv88dH?=
 =?us-ascii?Q?Jp30yYaBwk06oc1KivVo6fhxZyfnf3HvLxSLNVvwwcqrIZLg9hlErIkVSgoL?=
 =?us-ascii?Q?TIjs3ddvba57i+1gVow24KWNYtzK3hFIirUyBdZABFwJLWum78jM+iswCeqn?=
 =?us-ascii?Q?czw905EaCMSHChdAjp1ZOehuH3yGEdnaobJvHtRm4VqajrsvzG10EQb3nvS5?=
 =?us-ascii?Q?bNw7eNu1oysZGRalWnWai+394HSytvawJ8CAztzPSGubnXjL1HJc7QYoVGgi?=
 =?us-ascii?Q?L5mxa6rax6zKc6wgiBfy9eUWVldUvqzp8ISR7Q9D1WEfAPd2ZMv8bUGB9CWT?=
 =?us-ascii?Q?gbCpF/ovbxBCxUAxvIuAP5EPzjpJBrzzFWOlDT6W13905R5uS6bnEYPrf7Dz?=
 =?us-ascii?Q?KowBv2wDUGWDbeb3M7xUG0DI?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991dc9c7-3356-470f-281b-08d914402c84
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 05:46:50.5971 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6zghodEBCexxJ9ihKPTk+qRaIZHFxlH3ssZoQa75z0c76mm3ooQm2uSDzxajV5Nm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5076
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
Cc: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Changfeng.Zhu
Sent: Thursday, April 29, 2021 11:39 AM
To: amd-gfx@lists.freedesktop.org; Huang, Ray <Ray.Huang@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Cc: Zhu, Changfeng <Changfeng.Zhu@amd.com>
Subject: [PATCH] drm/amdgpu: seperate the dependency between CGCG and CGLS when diable CGCG/CGLS

From: changzhu <Changfeng.Zhu@amd.com>

From: Changfeng <Changfeng.Zhu@amd.com>

The disable process of CGLS is dependent on CGCG now. Align with windows code, seperate the dependency between CGCG and CGLS and it will reduce confusion when debug CGCG/CGLS related issue.

Change-Id: Ia91b8b16236bebd9224160672e500f6850dbc268
Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 24 ++++++++++++-------  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 33 ++++++++++++++++----------
 2 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 49fd10a15707..3f8aa2fb974d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7717,18 +7717,22 @@ static void gfx_v10_0_update_3d_clock_gating(struct amdgpu_device *adev,
 	uint32_t data, def;
 
 	/* Enable 3D CGCG/CGLS */
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)) {
+	if (enable) {


<> After entering the condition, you could just do an initial check here for if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG) and return if the device doesn't support it. Otherwise proceed with the rest of register reads and setting appropriate values. Same for gfx v9 also.

Thanks,
Lijo

 		/* write cmd to clear cgcg/cgls ov */
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
 		/* unset CGCG override */
-		data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_GFX3D_CG_OVERRIDE_MASK;
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)
+			data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_GFX3D_CG_OVERRIDE_MASK;
 		/* update CGCG and CGLS override bits */
 		if (def != data)
 			WREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE, data);
 		/* enable 3Dcgcg FSM(0x0000363f) */
 		def = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D);
-		data = (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
-			RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
+		data = 0;
+
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)
+			data |= (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
+				RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
 		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGLS)
 			data |= (0x000F << RLC_CGCG_CGLS_CTRL_3D__CGLS_REP_COMPANSAT_DELAY__SHIFT) |
 				RLC_CGCG_CGLS_CTRL_3D__CGLS_EN_MASK;
@@ -7758,10 +7762,11 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade  {
 	uint32_t def, data;
 
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
+	if (enable) {
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
 		/* unset CGCG override */
-		data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGCG_OVERRIDE_MASK;
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)
+			data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGCG_OVERRIDE_MASK;
 		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGLS)
 			data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGLS_OVERRIDE_MASK;
 		else
@@ -7772,8 +7777,11 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
 
 		/* enable cgcg FSM(0x0000363F) */
 		def = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL);
-		data = (0x36 << RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
-			RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
+		data = 0;
+
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)
+			data |= (0x36 << RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
+				RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
 		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGLS)
 			data |= (0x000F << RLC_CGCG_CGLS_CTRL__CGLS_REP_COMPANSAT_DELAY__SHIFT) |
 				RLC_CGCG_CGLS_CTRL__CGLS_EN_MASK;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 16a3b279a9ef..f69129097f2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4946,20 +4946,23 @@ static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,
 	amdgpu_gfx_rlc_enter_safe_mode(adev);
 
 	/* Enable 3D CGCG/CGLS */
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)) {
+	if (enable) {
 		/* write cmd to clear cgcg/cgls ov */
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
 		/* unset CGCG override */
-		data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_GFX3D_CG_OVERRIDE_MASK;
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)
+			data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_GFX3D_CG_OVERRIDE_MASK;
 		/* update CGCG and CGLS override bits */
 		if (def != data)
 			WREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE, data);
 
 		/* enable 3Dcgcg FSM(0x0000363f) */
 		def = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D);
+		data = 0;
 
-		data = (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
-			RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)
+			data |= (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
+				RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
 		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGLS)
 			data |= (0x000F << RLC_CGCG_CGLS_CTRL_3D__CGLS_REP_COMPANSAT_DELAY__SHIFT) |
 				RLC_CGCG_CGLS_CTRL_3D__CGLS_EN_MASK;
@@ -4993,10 +4996,12 @@ static void gfx_v9_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev
 
 	amdgpu_gfx_rlc_enter_safe_mode(adev);
 
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
+	if (enable) {
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
 		/* unset CGCG override */
-		data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGCG_OVERRIDE_MASK;
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)
+			data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGCG_OVERRIDE_MASK;
+
 		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGLS)
 			data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGLS_OVERRIDE_MASK;
 		else
@@ -5007,13 +5012,17 @@ static void gfx_v9_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev
 
 		/* enable cgcg FSM(0x0000363F) */
 		def = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL);
+		data = 0;
+
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG) {
+			if (adev->asic_type == CHIP_ARCTURUS)
+				data |= (0x2000 << RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
+					RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
+			else
+				data |= (0x36 << RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
+					RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
+		}
 
-		if (adev->asic_type == CHIP_ARCTURUS)
-			data = (0x2000 << RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
-				RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
-		else
-			data = (0x36 << RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
-				RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
 		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGLS)
 			data |= (0x000F << RLC_CGCG_CGLS_CTRL__CGLS_REP_COMPANSAT_DELAY__SHIFT) |
 				RLC_CGCG_CGLS_CTRL__CGLS_EN_MASK;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C0d0e57085ff44a4914bb08d90ad55422%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637552733630465511%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=BnixrZvT2gl96b0fkNX%2FXkgU1bWoWSTHXQgI2BMs%2FUk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
