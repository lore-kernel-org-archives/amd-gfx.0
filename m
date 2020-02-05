Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BD1C33CA1
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 09:20:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7468821741
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 09:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W6+dhWKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7468821741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DDC56F4E6;
	Wed,  5 Feb 2020 09:20:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::609])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3631F6F4E5
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2020 09:20:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amGTy3pKEtanO8oeVoOfGd62u8Cpr+ZGUJytvDOkbLx9/1XpZmuS8Rh9ataI0nnLP8/t2prBzFYyadLgKjXNRJyTzM1kfcP0dvyL+O09qNyBB7nzTViAz+VPbOXbd0GhPftDPo0idkiW2q+NdfXsuAwHoVMuYZtPFV1OOcjvd5gdrPTkAnLRImyT1As84ATSFW2/I7o+rxMa5QA7dG1chjdC1h1PeJ2H6cUmsb2D66VBzH6hiFbfWFxqOkjBGFHrYOIvsnyyUCcT68BKsZ96dNjU8KKPa+yV9PioUoumscvKi2OkUs9E4oZIiOIt9DHo8tRLnikFobfbuJwRHQfhLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWbC1obHm8x7IqUy1S2WO5y9/gcDWTtvF7U7GL/GkFw=;
 b=Oghd7retixcSL9x+pcFVUy3Knqug10HK3viRVP8n8AXSejIryPlt2zfmc36GapI3VZWaHqt2bFOuqHl9oUJfRxuAt0f2iPzcYwYdYqPm4wBI1cq2stDNVAY5dGB3oiwYQDHTJOUaGreAzPY8YoUj/JN3zG+phO4KQx0+Ix8/15GAvOwsg96pl+dvJx8XgIxNTPX9hVliHR9MMWAt+41opkF596vt6FzZ/UuJW1NY9+mhMauLKAwBNT+h0P/FUCOil+4aGl0fu7QO3e0P3SaKDVjk3piJnv28WPW/yy8d84RcraEv0idF2Z/qgVnszzhqMbDeQjYZ2XIZaXS02vnfWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWbC1obHm8x7IqUy1S2WO5y9/gcDWTtvF7U7GL/GkFw=;
 b=W6+dhWKRnQt36tKAbe6ssInIu+4K+fmI/vJckqHjUu5OOace2mU8CkqDYbr9WE3/NwELXIECbsLn3erEAr98mz2Bk5vOi/9PXkjqGo+t7qwF+vJ+0JENXZvUb4QwwoBxjaDz0eU30ohILRWAueSs0vMaJG5oVD6Ufv0ZT5sFxtc=
Received: from CH2PR12MB3672.namprd12.prod.outlook.com (52.132.246.139) by
 CH2PR12MB3832.namprd12.prod.outlook.com (52.132.244.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Wed, 5 Feb 2020 09:20:13 +0000
Received: from CH2PR12MB3672.namprd12.prod.outlook.com
 ([fe80::31df:679e:d23f:3c2b]) by CH2PR12MB3672.namprd12.prod.outlook.com
 ([fe80::31df:679e:d23f:3c2b%4]) with mapi id 15.20.2686.031; Wed, 5 Feb 2020
 09:20:13 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Tao, Yintian" <Yintian.Tao@amd.com>, "Deng, 
 Emily" <Emily.Deng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amdgpu/sriov Don't send msg when smu suspend
Thread-Topic: [PATCH] drm/amdgpu/sriov Don't send msg when smu suspend
Thread-Index: AQHV3AU6lzJSH6GMY0C+NPPBJIHsHqgMUn8w
Date: Wed, 5 Feb 2020 09:20:12 +0000
Message-ID: <CH2PR12MB3672CAE3242A33E38EC5B3A3BB020@CH2PR12MB3672.namprd12.prod.outlook.com>
References: <1580894294-3573-1-git-send-email-Jack.Zhang1@amd.com>
In-Reply-To: <1580894294-3573-1-git-send-email-Jack.Zhang1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jack.Zhang1@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2d8e092e-e568-4840-62ba-08d7aa1c9af3
x-ms-traffictypediagnostic: CH2PR12MB3832:|CH2PR12MB3832:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3832B031B444FA80C0FD2703BB020@CH2PR12MB3832.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0304E36CA3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(199004)(189003)(4326008)(2906002)(26005)(8676002)(15650500001)(8936002)(86362001)(81156014)(9686003)(81166006)(6636002)(33656002)(55016002)(76116006)(52536014)(66946007)(66556008)(66476007)(66446008)(478600001)(64756008)(71200400001)(5660300002)(7696005)(110136005)(53546011)(316002)(6506007)(186003)(966005)(45080400002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3832;
 H:CH2PR12MB3672.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tTpKbEAigHXmcvPuh1RK7KXlF52+ery53hmKiYyMi4e75s4kq7v1rk67wjugtJZTY7sYlHA1hFEcximWod+14kGzW5nlNStrsYjA5XBem1tIN7DmW3c1IyeCGBDwmcyjQdnbCEDQCzFN2A4f2jJ2OZ0F9PWPIu1x7jN42hRD4vW2ASM2XA01g9U9Edfx1MU0A0I9XYuuEd4tIxDkAXbm8z1rC1rP45o9Cxcj+ux4NGsaGukZ398xG+4y9IhUb/ewIQSrZw/o+O8Q8+KAu+ng48AJe+4o9UqPtpF33B0RHutTF+6a/lchwgCuFkBbsuk1D4QWagz/S3nnJOUUew7Rsd2gMvD+EcgntjOy6SIyowQa6dRFh3HLXG1McjFpahOZl+Y7qYV0KWyejnQPew48z9xHWRuiz1wN6McdoPqWj8wWQ4mDGD22yienQyVrcEBSw/8dUXRgskuK/Zs07lRVkpUUBT5CiB/7+W+EWh9D06VcV/0awrCOzfdQJrHI8lPBzQuyJ7KFsYvwsQgU6w92p8djA9ClARr/LKHzcm+0EMD/4O0Nj6EvQ94vqKOo8GLyPFhr+LqcvCQ3vB6mEkw+jA==
x-ms-exchange-antispam-messagedata: 2pQmHUKoM87uqm7gyvbO9VdiJrY35z2gKSxVasi0uU5aB4JA6rIVbE8PtWZsK+F66WgfR9cJMwhZAEWUWqCWTgHzI8uD6/X1NwDg5SaVyLeL1q+QtLDZqW1Heu8Jy/62D0eyGoqjJeBhYesW34S9fg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8e092e-e568-4840-62ba-08d7aa1c9af3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2020 09:20:12.9413 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cjx+s1UOtqanRAazy+FPaCVH3bXZojO9N+CXfNaQv5l9+vX8+1N99l9rZmR7Fs8P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3832
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
Cc: "Zhang, Jack \(Jian\)" <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi, Team,

Would you please help to take a look at this patch?

Regards,
Jack

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jack Zhang
Sent: Wednesday, February 5, 2020 5:18 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
Subject: [PATCH] drm/amdgpu/sriov Don't send msg when smu suspend

For sriov and pp_onevf_mode, do not send message to set smu status, becasue smu doesn't support these messages under VF.

Besides, it should skip smu_suspend when pp_onevf_mode is disabled.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 ++++++++-------  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 21 +++++++++++++--------
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4ff7ce3..2d1f8d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2353,15 +2353,16 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 		}
 		adev->ip_blocks[i].status.hw = false;
 		/* handle putting the SMC in the appropriate state */
-		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
-			r = amdgpu_dpm_set_mp1_state(adev, adev->mp1_state);
-			if (r) {
-				DRM_ERROR("SMC failed to set mp1 state %d, %d\n",
-					  adev->mp1_state, r);
-				return r;
+		if(!amdgpu_sriov_vf(adev)){
+			if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
+				r = amdgpu_dpm_set_mp1_state(adev, adev->mp1_state);
+				if (r) {
+					DRM_ERROR("SMC failed to set mp1 state %d, %d\n",
+							adev->mp1_state, r);
+					return r;
+				}
 			}
 		}
-
 		adev->ip_blocks[i].status.hw = false;
 	}
 
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 99ad4dd..a6d7b5f 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1461,21 +1461,26 @@ static int smu_suspend(void *handle)
 	struct smu_context *smu = &adev->smu;
 	bool baco_feature_is_enabled = false;
 
+	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
+		return 0;
+
 	if (!smu->pm_enabled)
 		return 0;
 
 	if(!smu->is_apu)
 		baco_feature_is_enabled = smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT);
 
-	ret = smu_system_features_control(smu, false);
-	if (ret)
-		return ret;
-
-	if (baco_feature_is_enabled) {
-		ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
-		if (ret) {
-			pr_warn("set BACO feature enabled failed, return %d\n", ret);
+	if(!amdgpu_sriov_vf(adev)) {
+		ret = smu_system_features_control(smu, false);
+		if (ret)
 			return ret;
+
+		if (baco_feature_is_enabled) {
+			ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
+			if (ret) {
+				pr_warn("set BACO feature enabled failed, return %d\n", ret);
+				return ret;
+			}
 		}
 	}
 
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CJack.Zhang1%40amd.com%7Ceb00cb04455340909ef908d7aa1c5ab5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637164911088955698&amp;sdata=AtqrYF%2Br53lO9oQLu6Q%2BPeco5KKDGKODjCvOWQmO9hw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
