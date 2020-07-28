Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23FDC433E4
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:03:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9448020786
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NUbUZqeJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9448020786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64F6E6E19C;
	Tue, 28 Jul 2020 07:03:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62C076E19C
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 07:03:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYhOR1geE/dpjj2GhZ/ui+khat+RpE63FPSo/+oOxcM3j/zVXa1hfgK5yqGaYukRtcCDnp6wKtHHi0inzw6UHDvxdbvP1YL2jYu4JIp5xNB9REsTXvD+MezW0HlO/NMFdVyKv8RTFlmagubC8MV2ueP6xUA5VChJYCsbb1ALjP6IwlEe1Bf0JKP/Vixz2NebVbk9n5ENuH2qpTRoNAk7TzqV1mYFK0YEGp33XxrecDk5JWGF1DKxcKTTKGHSkEadHXnwW6jwE5r3hKQ0rhY/8HYrlAnsoN+XgDawWrAM6VClPWebrzOk8jRZUGo/t72sGNFw5/VoaYekZRQcGb990A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwC6zA+g2AdZBHDLsOMSZ5Zaw9I1RsT/YGtIGOXOT3g=;
 b=HpNm2iSkgzxumhnnizV63/uRuGme8vX/fkitb8X3jeNrVhX+9dlYIqbVxM1qHn+k6WpZFBV/iFn0SQGK7THNXwEghVpoQJ9QlH+YeZJETQlrU+61k0Fp9sEGDcLaRSmk5vXNRZZFj+GjPCJc19lNnHzz8ji6Hf5GAJnRLEOiymX4tpEXWP0FBGUE580Ml+b7VmhAz6VlgI9kRDC2mv7uXaMArEGfKc6A+PSbHWx3sqWUSi6p3IjLKCQwYe65FtatKl/0FpsHSRV/YR4hdkIxUYA4PprSRzAYJlsYHwhQFarui/jHHYPKlsaPAHfUHFfn6xXCI1j46otJrKgmF8F+RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwC6zA+g2AdZBHDLsOMSZ5Zaw9I1RsT/YGtIGOXOT3g=;
 b=NUbUZqeJ8lMTHv3KOaAnxAvTw2Tq1pFxTRHc69PDIozh1dcFbpsAl6AVlOF20doDW0TEZc0WPeVW7Dt4wBhLzEv8R35C6xsTTAtU6U+Q8UCkj3j69cAjTGzQdEhebSr9nzLr/bWxwRTU4nqMrQx8lRgpxLEzSSF1NcMWkJrx4v4=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1909.namprd12.prod.outlook.com (2603:10b6:903:124::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 07:03:03 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Tue, 28 Jul
 2020 07:03:03 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings on Navi1x
 after GFXOFF exit
Thread-Topic: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings on
 Navi1x after GFXOFF exit
Thread-Index: AQHWZJ/OP5aeB+Pms0mXhJwSvYPLFKkchkIAgAAGr4CAAANWwA==
Date: Tue, 28 Jul 2020 07:03:03 +0000
Message-ID: <CY4PR12MB1287C4473AF1A0C85284ECB6F1730@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200728052717.21071-1-tianci.yin@amd.com>
 <20200728052717.21071-2-tianci.yin@amd.com>
 <CY4PR12MB1287B8C26F31BEDF70130C35F1730@CY4PR12MB1287.namprd12.prod.outlook.com>
 <BY5PR12MB3777F1A866D54C2569A8EA0E95730@BY5PR12MB3777.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB3777F1A866D54C2569A8EA0E95730@BY5PR12MB3777.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-28T06:24:34Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=83d23519-abd0-4b2d-993d-000020fd5e75;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-28T07:03:01Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: f3e18154-2f47-42bc-b79e-000038fc0e27
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ed227074-dc26-4d65-7d7b-08d832c44570
x-ms-traffictypediagnostic: CY4PR12MB1909:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1909895E802B8CF3105F9D39F1730@CY4PR12MB1909.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zZSRpAktoMIP1dPsJAU06wfKif9CDjpRzFpAebDJwprfjnw5FOca7bmkBuFyBUWHwtwfp3J7agBh5iYLG3qZgddDRRghF3mCWuQnpYjlGXR9VWw+T7Jvhdfu9l1YmknaLXudGq6v5e5TY7PyiMhr5hAWo1lqQ09hNDPe4WwtSIqbrVrQvb6qj6IAYsH/7LO2Je8tmjISjQvQ5S9+CMkkCj+KB7/FPbwqSlKMQ+Ci/2AO9zGo3AmaboUHnVjMa/Zv3Jxz3X5TkGuVJ6Y+0Wbt17pWNBt8R5436AaDJ/IN11r5bPDW21dnUQ2c70IoFCTcYLXXHinu0UP1AIyPi8ODwv46MO40Uk4eDb23Rxl4u3yxaveNbXbKoxHZWCGwG3MDBvhnMxeMzK9rPHS6u74ZjEQ/TD64KXv77gBxBDOxuwk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(478600001)(5660300002)(4326008)(8936002)(66556008)(8676002)(66476007)(66946007)(64756008)(66446008)(186003)(7696005)(2906002)(76116006)(45080400002)(33656002)(26005)(6506007)(54906003)(53546011)(55016002)(316002)(9686003)(52536014)(110136005)(966005)(86362001)(71200400001)(83380400001)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: XaD1eShKx70MhA4/hZXG1Xo9zEktgca9gTNmWlS3qUL6GiP63sa5R3wbaTzIYhAUG9kpMk2EOpGjSnOSql54x0Xe955IH+U5ztaRBXToIaV+WGV7yqe3rHP64R0oAFGvbPams2ccgyOGuqzlTwKb7wFw9lqE8wNuqkQBewytWRg5JhCrS94O9fuuxLJ4E14ZDitUvIHSGZhYjq6a1feiV6f4FY09WZghKQxJ43yTS7cp98DWoBoxiZSA+dQt2XWfzdquoywybXHp6abH2q4g43QdoA2oBGj2AB3UpR+b7s6uPPvHuyczeq90O0iMCso7uIp2cDb2dHMRu7Z05Pf9/3qrrCOUVQaHvVBbWxIHJLkBIoSmzYcS0lhf8AkJlUDv9LLjH68KfAkH7xBEorAqB7fab0qIYp3l7xzC1a9xyvEOkuNEDSdaFcThRuB9IhfIE5jlski/biO1YL6x5pA5SCv8zEJZ95itzI8cWaGbndq3zqKvdbIC+xe0gCpI4A19
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed227074-dc26-4d65-7d7b-08d832c44570
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 07:03:03.1274 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6XX2JAwfuv7Ix4Anl6PSsUgMyvBqqCX8/V5z/x4JxHUzjo/dO02ILeCtyH8KiUOLqmdPiOLLmgA5+wvBoy+Q8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1909
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Hesik, Christopher" <Christopher.Hesik@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Swamy,
 Manjunatha" <Manjunatha.Swamy@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi Tianci,

My point is, as in the new patch, one new local adev variable is introduced, then in the same function, for others where smu->adev is used should be replace by the new local adev as well.
Otherwise, it looks not perfect from coding style's perspective.

Regards,
Guchun

-----Original Message-----
From: Yin, Tianci (Rico) <Tianci.Yin@amd.com> 
Sent: Tuesday, July 28, 2020 2:48 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Hesik, Christopher <Christopher.Hesik@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Swamy, Manjunatha <Manjunatha.Swamy@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings on Navi1x after GFXOFF exit

Hi Guchun,

Since the adev variable invoked a few times, local adev make the code more concise.

Thanks!
Rico

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Tuesday, July 28, 2020 2:26 PM
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Hesik, Christopher <Christopher.Hesik@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Swamy, Manjunatha <Manjunatha.Swamy@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings on Navi1x after GFXOFF exit

[AMD Public Use]

One minor comment.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tianci Yin
Sent: Tuesday, July 28, 2020 1:27 PM
To: amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Hesik, Christopher <Christopher.Hesik@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Swamy, Manjunatha <Manjunatha.Swamy@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings on Navi1x after GFXOFF exit

From: "Tianci.Yin" <tianci.yin@amd.com>

On Navi1x, the SPM golden settings will be lost after GFXOFF enter/exit, reconfigure the golden settings after GFXOFF exit.

Change-Id: I9358ba9c65f241c36f8a35916170b19535148ee9
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 55463e7a11e2..5da0436d41e0 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1309,6 +1309,7 @@ static int smu_enable_umd_pstate(void *handle,
 
 	struct smu_context *smu = (struct smu_context*)(handle);
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
+	struct amdgpu_device *adev = smu->adev;

 	if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
 		return -EINVAL;
@@ -1324,6 +1325,16 @@ static int smu_enable_umd_pstate(void *handle,
 			amdgpu_device_ip_set_clockgating_state(smu->adev,
[Guchun]Use the local adev instead of smu->adev?

 							       AMD_IP_BLOCK_TYPE_GFX,
 							       AMD_CG_STATE_UNGATE);

+
+			if (adev->asic_type >= CHIP_NAVI10 &&
+			    adev->asic_type <= CHIP_NAVI12 &&
+			    (adev->pm.pp_feature & PP_GFXOFF_MASK)) {
+				if (adev->gfx.funcs->init_spm_golden) {
+					dev_dbg(adev->dev,"GFXOFF exited, re-init SPM golden settings\n");
+					amdgpu_gfx_init_spm_golden(adev);
+				} else
+					dev_warn(adev->dev,"Callback init_spm_golden is NULL\n");
+			}
 		}
 	} else {
 		/* exit umd pstate, restore level, enable gfx cg*/
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cguchun.chen%40amd.com%7Ce6176c766fe747a6fe1a08d832b6ee3c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637315108573876551&amp;sdata=43GHkX%2FCRLsfMmNxurLMIZy4l4ElUB2tnslPyfT7NJg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
