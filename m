Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B56C2D0C2
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 10:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EED34206DB
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 10:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DTihaja0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED34206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DE3B6E1B1;
	Fri,  3 Jan 2020 10:07:29 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94AE36E1B1
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2020 10:07:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPqWwcTBhfFrVWR5Z/07nELIOpVSa2mNhD/eQWUl+bhMSJhz4eTEYHaJS+7tw0FvSmlfmXV6uZyTVaLF94U/hYP9zcehWfByTbUdkwWmhXvm42g4dTRg9z6cdY1AFLHRa6VD2vpRcdH9zfyZMcU4cyYXPgSZQrUAoizJa9/ocEED8L3A3EjRGO9rb78RhDQTWAvGp+1MN5r+pWn/h2OgLPd74K0e8fZZTAq2j5f6YUOVVAVBWLrnaEBn1eoN1P3mCYUC4YyDUw/7WjAH1+YlBzq3q16pqhE6YBVLel4pUc+PFP5Vylv85ecsVdqctt7i3Mqeuu5mGryA5VOj77unWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZDE4VUxCuFJ3enumgGjG8z9BLLAM9LbNwnvqsNTC5c=;
 b=kl5yhSpwvn1cwbtpLW2UHtF+l8YPL83N2e8FrGqQiTbVSdAI4laYVmvXPOnhp4vEcBMQQ8yFbwW63K8sZgi2N/gqSItjixAURqtsyWHNWKZuCKWsbsLnmX4Wu5GBDx96U3KDxZ0dP+8wZSOh0zi04WJBTp6qWuxI1KWbSaA56abswZNzgoKDo8V+P9O/OwboLe5st27E8qfSGWUP5oWJXojKQCDIb+NBBtYzReFdDlqRXpHLiAaiPFr+K9RdKnUYtqLt24ztK04tzqxgTo2xivZHqTdy3vVVwGo1ptXsBWN/zQZk34FykpLRTTBfHPYC1HwYO6zJc0xov3/FJ7cvFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZDE4VUxCuFJ3enumgGjG8z9BLLAM9LbNwnvqsNTC5c=;
 b=DTihaja0S3z16edKKWfYaB+CHx5emUes3CAMQlXzeoDTMxw9VLsS1hif0RsWfo4BpYynpeZM/GFGDD7GXLeZtbf8TYF0OjX0Q/POK5buOTjjKB9RI1cVoNi2ZhqKUlyfOmpluC/EoonZRgMnP9rnE8hxsi7m70jPFlryVgZ6VQQ=
Received: from MN2PR12MB2975.namprd12.prod.outlook.com (20.178.243.142) by
 MN2PR12MB3871.namprd12.prod.outlook.com (10.255.238.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Fri, 3 Jan 2020 10:07:26 +0000
Received: from MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::8d41:5fd9:6b89:c593]) by MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::8d41:5fd9:6b89:c593%3]) with mapi id 15.20.2602.012; Fri, 3 Jan 2020
 10:07:26 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Jian,JaneQiang)" <Jane.Jian@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Liu, Leo" <Leo.Liu@amd.com>
Subject: RE: [PATCH 5/5] drm/amd/amdgpu: L1 Policy(5/5) - removed IH_CHICKEN
 from VF
Thread-Topic: [PATCH 5/5] drm/amd/amdgpu: L1 Policy(5/5) - removed IH_CHICKEN
 from VF
Thread-Index: AQHVwhyTg4HlzPWGVkqhB0PvQQauyafYtsRA
Date: Fri, 3 Jan 2020 10:07:26 +0000
Message-ID: <MN2PR12MB297522D481556CE708F7B5988F230@MN2PR12MB2975.namprd12.prod.outlook.com>
References: <20200103095649.5068-1-Jane.Jian@amd.com>
 <20200103095649.5068-5-Jane.Jian@amd.com>
In-Reply-To: <20200103095649.5068-5-Jane.Jian@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-03T10:07:23Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=456a7f04-d3e3-4b47-b028-0000e04e01d8;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-03T10:07:23Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 76111659-4d67-4be2-8caf-0000bee3b05f
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Emily.Deng@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a4776455-dc8e-42b3-d536-08d79034bc1f
x-ms-traffictypediagnostic: MN2PR12MB3871:|MN2PR12MB3871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3871AE25B6C205644E5AF5EA8F230@MN2PR12MB3871.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-forefront-prvs: 0271483E06
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(189003)(199004)(13464003)(66476007)(66556008)(33656002)(71200400001)(478600001)(66946007)(6636002)(86362001)(76116006)(26005)(7696005)(64756008)(66446008)(6506007)(4326008)(8936002)(81156014)(81166006)(55016002)(8676002)(52536014)(316002)(5660300002)(54906003)(9686003)(110136005)(2906002)(186003)(309714004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3871;
 H:MN2PR12MB2975.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o/1nHOEBomAAQPSM+S6GQZEw6mlZtDVDt8Oijh19MKkduLH9cP4L4G0ct8oEHswoMKC1cjmpAySv/EYNu2bJfS5Qam3AjtiwWOw5k22O6imsCSJD/ucHMi2sBN6Q1PGPB4QbD/B5OQNILeRSSIUMI1xDPah6zhYo8HzeLfWvPVeqdA3NhutAr7eAYQJY4AyA1SnzEMNY3jvzUCHBtVZRoHO0GHhjAGy9shfaAvmqu3rzrESYWmcoxWRKrjbVLmQeHoN2vzpEwPgncChWb/9DdZatZ/r4h8qCUpWWXtuqyIaPfmGmHvR2hQYbFFBT+rv31/n9s7ZSkLhfy2hJTSVcieL7/vKzVwPXqxABh4nM80rsVySYfSIvPIzkiwNKaLexrT/+TwhrHoIcz4OOZndmZgfFh+PG+QPxSpAFUNVoLF5Syj6ODuDrHHfeESqI91Y+FBZw273Dzdt8vrB98Mh+WlzShSIBB5tNeeNprsNYZSMdHCSC2/RtBdBgqHKj0nKyIWXI+rmw51zJOyP6xP62Ow==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4776455-dc8e-42b3-d536-08d79034bc1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2020 10:07:26.3967 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IWyS1EnIN4aj/jiCC64UPhagTD9fx5CrGRYVpMPP6OMFziLqdde1D9I40Xh1k8mI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3871
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
Cc: "Luo, Zhigang" <Zhigang.Luo@amd.com>, "Jian,
 JaneQiang\)" <Jane.Jian@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Series are Reviewed-by: Emily Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: Jane Jian <Jane.Jian@amd.com>
>Sent: Friday, January 3, 2020 5:57 PM
>To: amd-gfx@lists.freedesktop.org; Deng, Emily <Emily.Deng@amd.com>; Liu, Leo
><Leo.Liu@amd.com>
>Cc: Jian,JaneQiang) <Jane.Jian@amd.com>; Luo, Zhigang
><Zhigang.Luo@amd.com>; Jian,JaneQiang) <Jane.Jian@amd.com>
>Subject: [PATCH 5/5] drm/amd/amdgpu: L1 Policy(5/5) - removed IH_CHICKEN
>from VF
>
>From: Zhigang Luo <zhigang.luo@amd.com>
>
>Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
>Signed-off-by: Jane Jian <jane.jian@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 22 ++++++++++++----------
> 1 file changed, 12 insertions(+), 10 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>index 5cb7e231de5f..d9e331084ea0 100644
>--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>@@ -234,16 +234,9 @@ static int vega10_ih_irq_init(struct amdgpu_device
>*adev)
> 	WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_HI, (ih->gpu_addr >> 40) &
>0xff);
>
> 	ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL);
>-	ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN);
> 	ih_rb_cntl = vega10_ih_rb_cntl(ih, ih_rb_cntl);
>-	if (adev->irq.ih.use_bus_addr) {
>-		ih_chicken = REG_SET_FIELD(ih_chicken, IH_CHICKEN,
>MC_SPACE_GPA_ENABLE, 1);
>-	} else {
>-		ih_chicken = REG_SET_FIELD(ih_chicken, IH_CHICKEN,
>MC_SPACE_FBPA_ENABLE, 1);
>-	}
> 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RPTR_REARM,
> 				   !!adev->irq.msi_enabled);
>-
> 	if (amdgpu_sriov_vf(adev)) {
> 		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL,
>ih_rb_cntl)) {
> 			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
>@@ -253,10 +246,19 @@ static int vega10_ih_irq_init(struct amdgpu_device
>*adev)
> 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
> 	}
>
>-	if ((adev->asic_type == CHIP_ARCTURUS
>-		&& adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT)
>-		|| adev->asic_type == CHIP_RENOIR)
>+	if ((adev->asic_type == CHIP_ARCTURUS &&
>+	     adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) ||
>+	    adev->asic_type == CHIP_RENOIR) {
>+		ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN);
>+		if (adev->irq.ih.use_bus_addr) {
>+			ih_chicken = REG_SET_FIELD(ih_chicken, IH_CHICKEN,
>+						   MC_SPACE_GPA_ENABLE, 1);
>+		} else {
>+			ih_chicken = REG_SET_FIELD(ih_chicken, IH_CHICKEN,
>+						   MC_SPACE_FBPA_ENABLE, 1);
>+		}
> 		WREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN, ih_chicken);
>+	}
>
> 	/* set the writeback address whether it's enabled or not */
> 	WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_ADDR_LO,
>--
>2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
