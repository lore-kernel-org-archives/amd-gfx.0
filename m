Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82702C33C9E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 02:14:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5124F2467A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 02:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lto4gKFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5124F2467A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F098A6E825;
	Wed, 15 Jan 2020 02:14:55 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690072.outbound.protection.outlook.com [40.107.69.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DC526E825
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 02:14:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbLRIJEnkvlFPGwp5aPsC+LEq5K0vYLkm82srjVkgbfx0feIkBajohOU1/IvIHDIaJYeApMjmA7J2F0Itjo2mSI1fTgCMXch74DyHxHuKsgXE2tSxWgg2+1qfKW0IlBsGp9njuNSWlFPAbOi5+2O/PcIb/UcujKO1G2zy74gJEkTkbs65BdZXOGPQuH+Gh+P/UZCIGx+oAmTjsWrwsezXnT5YsBKfyPlF8SHAsa0fRUa56uONw71OMWesg02yiRIKzUk/IcDM715uLr8ZYh14E9j9/Yt5/17YWXMbDw0QueGyJWP3Q/u6BKnIeelrVMKRfbvPoxr0IUfyDxteTzdpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnfgMnJNyUNHLiLtXWF4vGMGj2eKomSC07jmDOskNbo=;
 b=DCJkRACmV7/HGyZHl9JNo1/+xTVt+2Jk9pv/3NQ5G1lya7b+NMB7kaRYy1Te8A3rR9Vyu95DxtXXA3ua0vze8gME28r35CbX6KPd+ctjtz6gujHj+MVcAX0SckLuKUDBYbgr4mYRSXMrUGv8iP27nZB72FuvdSBF7OuHfPFou+cKlVc0+xLepslkeXyCWd1VkQJi9W6ykbMki7Tn5mJMW4nQ5nd4staXDrwGorGWZKLQVYuXmdUbNwxqsQ2reRjCRTGAsOia63WgcPwP4MN8PyIBtsg9sjRY8GWyNg4lPhZM58ZFWDbOf63lOvHpj40okF0mrPk2tzhHt5AwPiAH9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnfgMnJNyUNHLiLtXWF4vGMGj2eKomSC07jmDOskNbo=;
 b=lto4gKFkf0K67tnFQqaP3PmKZSC6Z5uw0g+8w3m8DIEk6AMNKZSG98zyqpyTwoo5VYlPkJii5p/OKHeAe/E9nV5XZEmV4MwnOZ3DN7NsWi3jlZ/f2KmH+qrC8nhsh6edj91oeYYFxaaoYQQ/q0hCvt3J31BhP/u/L/Xu/+mfPoI=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB4096.namprd12.prod.outlook.com (52.135.50.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 15 Jan 2020 02:14:52 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2644.015; Wed, 15 Jan 2020
 02:14:52 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/pm: clean up return types
Thread-Topic: [PATCH] drm/amdgpu/pm: clean up return types
Thread-Index: AQHVywBoLZ5kAhMRYUWhEH9ryP1YE6fq/QYQ
Date: Wed, 15 Jan 2020 02:14:51 +0000
Message-ID: <MN2PR12MB3344737A1330F55A8D3ABA03E4370@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200114172544.1042534-1-alexander.deucher@amd.com>
In-Reply-To: <20200114172544.1042534-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=2d653a07-a4f0-473c-a3c6-0000b1cf09ce;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-15T02:14:29Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f97f9c65-fdc7-4517-4f8b-08d79960b47b
x-ms-traffictypediagnostic: MN2PR12MB4096:|MN2PR12MB4096:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB40960019B326ADE7629B334BE4370@MN2PR12MB4096.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:167;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(189003)(199004)(86362001)(55016002)(966005)(478600001)(8936002)(316002)(66476007)(66946007)(66556008)(76116006)(66446008)(64756008)(71200400001)(9686003)(26005)(52536014)(186003)(53546011)(2906002)(110136005)(81156014)(81166006)(4326008)(7696005)(5660300002)(6506007)(45080400002)(8676002)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4096;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a+AijxsfTZMdlTCamew5ynvTTNqprwGrauLCx7mDa2nHfZu+2t5rBE9wYPC20aL+k3QMLwh68jaLmO03mTgTHk/y6fa6ZWJB+M/lytbmWz83Sgr/4/wBn6b1KXqbiV/V7RhWVgJe/IBLhOV6JVSNKlhJdtCq5JILw1cpUikOrLoMNEEVqX/jOitc9Vun+Bur+lkm6m41utJLi/pC1kzUDf145Ztpc3yZ/tqcu1LSqZwagi7YOz+9eVYEJEFt2Hn1bBJh2TURpHbP1AEEmyQ++RAm3Fr6mxzecEJOUvdvMDyD8+6iMBUecrHdeQ4qQ4TIqtIrdDVY+xJh2Q3N0IUNgdqFelp7QMz1RBJ96cuaqmJ+SLKxHOCHea24wc1YsJHN9dB7n2sgdhW9HOD1HZHNq84m4VHsJ0LawdqrF9VnRN/+/VtsRPYiam9XDq2JVAjFh0ulw2XflWmgVQ3I1x0u2XsMKICPF2Brb/31mH6eHdI=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97f9c65-fdc7-4517-4f8b-08d79960b47b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 02:14:51.8215 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NPLDDy1zMUGTCi7wHtIb6szz9KpFik6eq4mgKzcbjgfYwFFCLvq3rrkQb8Fyl8Sq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4096
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

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, January 15, 2020 1:26 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/pm: clean up return types

count is size_t so don't use negative values.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 39 ++++++++++++++++----------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 806e731c1ff4..b03b1eb7ba04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -206,10 +206,8 @@ static ssize_t amdgpu_set_dpm_state(struct device *dev,
 		state = POWER_STATE_TYPE_BALANCED;
 	else if (strncmp("performance", buf, strlen("performance")) == 0)
 		state = POWER_STATE_TYPE_PERFORMANCE;
-	else {
-		count = -EINVAL;
-		goto fail;
-	}
+	else
+		return -EINVAL;
 
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
@@ -231,8 +229,6 @@ static ssize_t amdgpu_set_dpm_state(struct device *dev,
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
-
-fail:
 	return count;
 }
 
@@ -399,8 +395,11 @@ static ssize_t amdgpu_set_dpm_forced_performance_level(struct device *dev,
 
 	if (is_support_sw_smu(adev)) {
 		ret = smu_force_performance_level(&adev->smu, level);
-		if (ret)
-			count = -EINVAL;
+		if (ret) {
+			pm_runtime_mark_last_busy(ddev->dev);
+			pm_runtime_put_autosuspend(ddev->dev);
+			return -EINVAL;
+		}
 	} else if (adev->powerplay.pp_funcs->force_performance_level) {
 		mutex_lock(&adev->pm.mutex);
 		if (adev->pm.dpm.thermal_active) {
@@ -410,10 +409,14 @@ static ssize_t amdgpu_set_dpm_forced_performance_level(struct device *dev,
 			return -EINVAL;
 		}
 		ret = amdgpu_dpm_force_performance_level(adev, level);
-		if (ret)
-			count = -EINVAL;
-		else
+		if (ret) {
+			mutex_unlock(&adev->pm.mutex);
+			pm_runtime_mark_last_busy(ddev->dev);
+			pm_runtime_put_autosuspend(ddev->dev);
+			return -EINVAL;
+		} else {
 			adev->pm.dpm.forced_level = level;
+		}
 		mutex_unlock(&adev->pm.mutex);
 	}
 	pm_runtime_mark_last_busy(ddev->dev);
@@ -890,12 +893,18 @@ static ssize_t amdgpu_set_pp_feature_status(struct device *dev,
 
 	if (is_support_sw_smu(adev)) {
 		ret = smu_sys_set_pp_feature_mask(&adev->smu, featuremask);
-		if (ret)
-			count = -EINVAL;
+		if (ret) {
+			pm_runtime_mark_last_busy(ddev->dev);
+			pm_runtime_put_autosuspend(ddev->dev);
+			return -EINVAL;
+		}
 	} else if (adev->powerplay.pp_funcs->set_ppfeature_status) {
 		ret = amdgpu_dpm_set_ppfeature_status(adev, featuremask);
-		if (ret)
-			count = -EINVAL;
+		if (ret) {
+			pm_runtime_mark_last_busy(ddev->dev);
+			pm_runtime_put_autosuspend(ddev->dev);
+			return -EINVAL;
+		}
 	}
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C12c6ca8a852b47cca09508d79916d8b8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637146198690587933&amp;sdata=PO6RhoxMpnV30pVXSjpJayrhdahx59oSAWGmoeD48SU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
