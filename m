Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A7AC2D0B1
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 07:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B790120726
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 07:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TbvynVud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B790120726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E3616FB96;
	Fri,  7 Feb 2020 07:36:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9989A6FB96
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 07:36:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVBw6VeQkM2UTdTGSXT0xFvPna054fS1zrvbFBrNasCv93J49utF3+fz+6jCMX4vc8Eu/FVGWH8+9r5ybexZUv17d4AQ3kBUsmITefdtOJLKmeRPK0gHMeLXjFawtrETSPyGf2faVs3BWS+4xCYJ+JGFE7buaf6AECcL5IDsXMHeU3TdXQHYQUcXjd7L1tmgSMkGXAXu0fLkoaIwln2XQP4isynaT1K6OH5JXxYz7SfY5GPhyuSNDE7RE7uLTkFuJ/6bLnEQ8Kf7RSfHD3lJMd1i7Or9n+x+ZaWMcUBYRZYQumwfPoFovhs347NpJwOiStgTkGGwoq/S6nK0b4V80w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77KTvqqVKWX52F+0fa5Fko1XV5BH2gUGJ8MtC6F+PVM=;
 b=FOIsPcnkph71az80hoW31iFZR5VCqYpfbsT9XCdi97YIYa4zWFLBFt5mVMRc6XW7chHk8YVWydHoLw2Ac1LKbVZ9QZVwI0Mejrjfnm6AUKm3UCP0189WKdqZppQWXAGIgmutFbVBIh52ftz3pbVvPoKZ/m2eeRYYDISLNUbXU3CvKyd89GfYzIgl/YnCQM/EZc1VyZDle2xz98C0IfLwh0jdTTA0cHkr3qFxhTWvPoGYRaXuB6R+6zj+l+mHEJcw6BeGBtG4p47AwD6O/QvgqPaGtlaKAg9tMi1Rcn85wfQAKviRDJLph4qK18YIAfiZsWvhXLO5Q6sQPTAd5WK2sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77KTvqqVKWX52F+0fa5Fko1XV5BH2gUGJ8MtC6F+PVM=;
 b=TbvynVudfIcUhmo0D3CHEZMwlo3dgv+l5je//8Fh+6A3/LKB4hMmBAcj7YZScO9xWsm/9sua6mei+21ExRfMY9K409gl45Gt7/vhYEFQlVpnW7i8Ka9tXCcd2eYUs2lI+mTdzBg6C8lSDxp5sLfZMRaw2TkyKEzhZil5H5EEJgU=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB2911.namprd12.prod.outlook.com (20.179.80.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Fri, 7 Feb 2020 07:36:50 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2707.023; Fri, 7 Feb 2020
 07:36:49 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: update smu_v11_0_pptable.h
Thread-Topic: [PATCH 1/2] drm/amdgpu: update smu_v11_0_pptable.h
Thread-Index: AQHV3Sdk/Pm1OHQJPEqHpxy/QKxEqqgPV5ZA
Date: Fri, 7 Feb 2020 07:36:49 +0000
Message-ID: <MN2PR12MB3344E3BA0850A91ED80C55A0E41C0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200206195516.302101-1-alexander.deucher@amd.com>
In-Reply-To: <20200206195516.302101-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [27.196.83.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 53ff6fa8-dfc1-456f-a239-08d7aba07e5f
x-ms-traffictypediagnostic: MN2PR12MB2911:|MN2PR12MB2911:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2911F282177D654060F696F2E41C0@MN2PR12MB2911.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:519;
x-forefront-prvs: 0306EE2ED4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(189003)(199004)(2906002)(110136005)(26005)(186003)(8676002)(33656002)(8936002)(81156014)(316002)(6506007)(4326008)(81166006)(15650500001)(71200400001)(66476007)(66556008)(64756008)(76116006)(9686003)(66946007)(55016002)(66446008)(478600001)(5660300002)(45080400002)(7696005)(86362001)(52536014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2911;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pi4wSS43tkVeyJBKHkv3Y9iU9ii5PCVRiXZCLcUYq1ZlxH5H6oqhnP3L1Ek6kGxEBPBZPmevicW8eIwgRcHqp2vYZyDAYD2qh6mNXMWo9pb/xz3I/CUVgBJg8ui3pUuOd7BFtf5PF7Im+ngVLoZRAA1fT5inrMi7Evlk6FwHphTVmQ3bH9MWPs+wqAzJk5vGcMc1Qbd69+Xs567qDAM6JT27O8SQYjvaWP7I00XAEpTXhm3w3LaDkYO2HqWi3Pp10xKD9lNeOXqPub9Ljik/zc2fhQZD3+CUq6LWWjmUr0fBx05UG1ECRoRn3Idlu49w+p+GMK5qn4eUBJDEYG1DeD9NmkJ8T/HQmvVWiAapOOBULGw6pszRS3sQehEqx3skOKMVIg4C1egBQLBBk+kR2cV7+TbKmzIBy6cI1Tbw+N/XOIDgrQQqGg+bZ/tEADr+FXl4+zvsMUq48xAKTr2sD71vzJNZ4AEH9Z6gmwVOkl3FIitUnRwKF946WAjYfF1h2/ThKc+DwPiIXt4n/G6aGw==
x-ms-exchange-antispam-messagedata: /dJ8ehnHTvpvNByb+1jQyxGvtVwlkMuqBN0OPDBIGvCrLd124BWKHh56E40nd7udw1mAlxo/x3TW7Yfey1eWDr5nNpYZvIEKqiDFAJtwk9XJa2Ajg8SZyMLRPosbzOkykev4EKGneVV9rPpV93mEHA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ff6fa8-dfc1-456f-a239-08d7aba07e5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2020 07:36:49.7619 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SesTin9Vgmc858eU05od3YS70wT+ag1jUa5aVLAYV76MR5zlO4K8rPVoNcsQKXX5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2911
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

>     SMU_11_0_ODFEATURE_COUNT                = 14,
This seems a little weird. 
Maybe it should be "SMU_11_0_ODFEATURE_COUNT = 1 << SMU_11_0_ODCAP_COUNT, "
With above confirmed, the patch series is reviewed-by: Evan Quan <evan.quan@amd.com>

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
>Deucher
>Sent: Friday, February 7, 2020 3:55 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>Subject: [PATCH 1/2] drm/amdgpu: update smu_v11_0_pptable.h
>
>Update to the latest changes.
>
>Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>---
> .../drm/amd/powerplay/inc/smu_v11_0_pptable.h | 46 +++++++++++++-----
>-
> 1 file changed, 32 insertions(+), 14 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h
>b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h
>index b2f96a101124..7a63cf8e85ed 100644
>--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h
>+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h
>@@ -39,21 +39,39 @@
> #define SMU_11_0_PP_OVERDRIVE_VERSION                   0x0800
> #define SMU_11_0_PP_POWERSAVINGCLOCK_VERSION            0x0100
>
>+enum SMU_11_0_ODFEATURE_CAP {
>+    SMU_11_0_ODCAP_GFXCLK_LIMITS = 0,
>+    SMU_11_0_ODCAP_GFXCLK_CURVE,
>+    SMU_11_0_ODCAP_UCLK_MAX,
>+    SMU_11_0_ODCAP_POWER_LIMIT,
>+    SMU_11_0_ODCAP_FAN_ACOUSTIC_LIMIT,
>+    SMU_11_0_ODCAP_FAN_SPEED_MIN,
>+    SMU_11_0_ODCAP_TEMPERATURE_FAN,
>+    SMU_11_0_ODCAP_TEMPERATURE_SYSTEM,
>+    SMU_11_0_ODCAP_MEMORY_TIMING_TUNE,
>+    SMU_11_0_ODCAP_FAN_ZERO_RPM_CONTROL,
>+    SMU_11_0_ODCAP_AUTO_UV_ENGINE,
>+    SMU_11_0_ODCAP_AUTO_OC_ENGINE,
>+    SMU_11_0_ODCAP_AUTO_OC_MEMORY,
>+    SMU_11_0_ODCAP_FAN_CURVE,
>+    SMU_11_0_ODCAP_COUNT,
>+};
>+
> enum SMU_11_0_ODFEATURE_ID {
>-    SMU_11_0_ODFEATURE_GFXCLK_LIMITS        = 1 << 0,         //GFXCLK Limit
>feature
>-    SMU_11_0_ODFEATURE_GFXCLK_CURVE         = 1 << 1,         //GFXCLK Curve
>feature
>-    SMU_11_0_ODFEATURE_UCLK_MAX             = 1 << 2,         //UCLK Limit
>feature
>-    SMU_11_0_ODFEATURE_POWER_LIMIT          = 1 << 3,         //Power Limit
>feature
>-    SMU_11_0_ODFEATURE_FAN_ACOUSTIC_LIMIT   = 1 << 4,         //Fan
>Acoustic RPM feature
>-    SMU_11_0_ODFEATURE_FAN_SPEED_MIN        = 1 << 5,         //Minimum
>Fan Speed feature
>-    SMU_11_0_ODFEATURE_TEMPERATURE_FAN      = 1 << 6,         //Fan Target
>Temperature Limit feature
>-    SMU_11_0_ODFEATURE_TEMPERATURE_SYSTEM   = 1 << 7,
>//Operating Temperature Limit feature
>-    SMU_11_0_ODFEATURE_MEMORY_TIMING_TUNE   = 1 << 8,         //AC
>Timing Tuning feature
>-    SMU_11_0_ODFEATURE_FAN_ZERO_RPM_CONTROL = 1 << 9,         //Zero
>RPM feature
>-    SMU_11_0_ODFEATURE_AUTO_UV_ENGINE       = 1 << 10,        //Auto
>Under Volt GFXCLK feature
>-    SMU_11_0_ODFEATURE_AUTO_OC_ENGINE       = 1 << 11,        //Auto Over
>Clock GFXCLK feature
>-    SMU_11_0_ODFEATURE_AUTO_OC_MEMORY       = 1 << 12,        //Auto
>Over Clock MCLK feature
>-    SMU_11_0_ODFEATURE_FAN_CURVE            = 1 << 13,        //VICTOR TODO
>+    SMU_11_0_ODFEATURE_GFXCLK_LIMITS        = 1 <<
>SMU_11_0_ODCAP_GFXCLK_LIMITS,            //GFXCLK Limit feature
>+    SMU_11_0_ODFEATURE_GFXCLK_CURVE         = 1 <<
>SMU_11_0_ODCAP_GFXCLK_CURVE,             //GFXCLK Curve feature
>+    SMU_11_0_ODFEATURE_UCLK_MAX             = 1 <<
>SMU_11_0_ODCAP_UCLK_MAX,                 //UCLK Limit feature
>+    SMU_11_0_ODFEATURE_POWER_LIMIT          = 1 <<
>SMU_11_0_ODCAP_POWER_LIMIT,              //Power Limit feature
>+    SMU_11_0_ODFEATURE_FAN_ACOUSTIC_LIMIT   = 1 <<
>SMU_11_0_ODCAP_FAN_ACOUSTIC_LIMIT,       //Fan Acoustic RPM feature
>+    SMU_11_0_ODFEATURE_FAN_SPEED_MIN        = 1 <<
>SMU_11_0_ODCAP_FAN_SPEED_MIN,            //Minimum Fan Speed feature
>+    SMU_11_0_ODFEATURE_TEMPERATURE_FAN      = 1 <<
>SMU_11_0_ODCAP_TEMPERATURE_FAN,          //Fan Target Temperature
>Limit feature
>+    SMU_11_0_ODFEATURE_TEMPERATURE_SYSTEM   = 1 <<
>SMU_11_0_ODCAP_TEMPERATURE_SYSTEM,       //Operating Temperature
>Limit feature
>+    SMU_11_0_ODFEATURE_MEMORY_TIMING_TUNE   = 1 <<
>SMU_11_0_ODCAP_MEMORY_TIMING_TUNE,       //AC Timing Tuning feature
>+    SMU_11_0_ODFEATURE_FAN_ZERO_RPM_CONTROL = 1 <<
>SMU_11_0_ODCAP_FAN_ZERO_RPM_CONTROL,     //Zero RPM feature
>+    SMU_11_0_ODFEATURE_AUTO_UV_ENGINE       = 1 <<
>SMU_11_0_ODCAP_AUTO_UV_ENGINE,           //Auto Under Volt GFXCLK
>feature
>+    SMU_11_0_ODFEATURE_AUTO_OC_ENGINE       = 1 <<
>SMU_11_0_ODCAP_AUTO_OC_ENGINE,           //Auto Over Clock GFXCLK
>feature
>+    SMU_11_0_ODFEATURE_AUTO_OC_MEMORY       = 1 <<
>SMU_11_0_ODCAP_AUTO_OC_MEMORY,           //Auto Over Clock MCLK
>feature
>+    SMU_11_0_ODFEATURE_FAN_CURVE            = 1 <<
>SMU_11_0_ODCAP_FAN_CURVE,                //Fan Curve feature
>     SMU_11_0_ODFEATURE_COUNT                = 14,
> };
> #define SMU_11_0_MAX_ODFEATURE    32          //Maximum Number of OD
>Features
>--
>2.24.1
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
>reedesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C99774c3d5dfa4e98e6
>e408d7ab3e83c6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637
>166157332486214&amp;sdata=n8ey1rnXwX3JLecL%2BWnNSV6cNNGTagtn2lR
>ORmI%2Bb%2Bk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
