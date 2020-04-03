Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBF1C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 03:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6692077D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 03:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GuL6Fei6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6692077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1C636E1B1;
	Fri,  3 Apr 2020 03:28:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45A216E1B1
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 03:28:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTvDdI5DyIF8gwvTDxNuYCCJ3Kfu3Fny+mmLcnYJqTkdq0x6ZxtT7SYw2W+KC56npY5OG/TAYHqoSi4i+KOkxBMog1pBHK6eH4nuaroT2Rehhndiuua+NUErGJVNqBFfwCtF8xRf5KRBChLG11/WQWNOxJavenKw9ks7bzoVOmD4yjZ2fIxloa4Z/9nhe08zqhjqxshKZakcclbW41QqAb2uSZZbVeRrstlGWA5zebpm8Lv8wpKPUIVnB7QrxaRLoILg313ntDuaLb/rNwSowckxN5jZsYWDnp/c1vctuptEoW28WL1rIkhSxsclzWNw1RJmrGTcm7GHW3jEJnHVZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdmP6JVtBrbNhdNOLfaSu9+FS70dwWQ7yySzlvaDFqM=;
 b=dycX71nnWQMnmyHjmFoV6wZDOCiELOTAe0hPTtcfM9M1mCY7krtQkG5H8Iw1UX/eVwSyc8uVJXBcESGVYWzLPkZe3CLy/v/dRpBdKAj43fBwlYCFnyr1R4QyfqcLpucQsT+fjYMCMcJ/VAM1njnrRv3jJBmoEWDWO//iMZOA3Fnv566QGec9ulznAtG0MV1JcfXbpjdXeSBNmNbFHYb9nptus58ghoWZC3nodFkOSnnhoZ4OTeGHABdZIjKmCFvBGDMhwHHg6SQ+LxNz+U0Af5OWbnezv1Nz7E8wzNCS9wqpcqe3IjPOyNgmU8WmEOvtiqlUqyfMwuspv1cGVhc+fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdmP6JVtBrbNhdNOLfaSu9+FS70dwWQ7yySzlvaDFqM=;
 b=GuL6Fei6ctFeKKYAYn9LdzJwnXQK5D+0d8qRByRXfvgNerQ86+qphRt9y7FiYDJGS4p5qr16SiDt2UoszvWHjTYazsSgYzofB3YEsQTAsoHw6Edty2ShYdGGxAplGJYH6aAfcvlliCJXQyFxNkaRyP2cMEdDlgJ17QGELTeCN7U=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 3 Apr
 2020 03:28:21 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2878.016; Fri, 3 Apr 2020
 03:28:21 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Zhou, Tiecheng" <Tiecheng.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: determine pm_en at amd_powerplay_create
Thread-Topic: [PATCH] drm/amd/powerplay: determine pm_en at
 amd_powerplay_create
Thread-Index: AQHWCLFad2t9L5r0q02KVayYQV8VDqhmvlcg
Date: Fri, 3 Apr 2020 03:28:20 +0000
Message-ID: <MN2PR12MB334405CF0A32D57048B3140DE4C70@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200402053934.28834-1-Tiecheng.Zhou@amd.com>
In-Reply-To: <20200402053934.28834-1-Tiecheng.Zhou@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=7a50001e-558a-430d-91fa-00006e52fb55;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-03T03:27:56Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9742b504-e190-4d55-59f4-08d7d77f0f60
x-ms-traffictypediagnostic: MN2PR12MB4223:|MN2PR12MB4223:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB42233D3A86FDB8B2A874B292E4C70@MN2PR12MB4223.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3344.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(6506007)(81166006)(45080400002)(33656002)(64756008)(4326008)(52536014)(76116006)(81156014)(9686003)(66446008)(71200400001)(66476007)(8936002)(966005)(66556008)(7696005)(66946007)(86362001)(55016002)(2906002)(53546011)(186003)(478600001)(8676002)(5660300002)(110136005)(316002)(26005);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WzDplrDTHsiw755VsJm8VGVqqzE40DoWMU9B2TFE7a+qOK2ulnITRaZJip/5MMZ2/YURvUmDg3WvK7eNJJG+AZFpKF9IbKE+S0aNhVzvVeC4cox++zCtQgfctiJ0QfJCFIV/1qrIilnox12BJozkRO4udjnRWppCg3ndNWCubQrV0dD0JhYs1gyRSlWzVEMxgOuX4vTbpgTdawSF2sfqSQkYbemi5eETX2GBpfIiZbUxeiCAiK5WPps6yQjQPGB+i+hsSGtRLtn5/EOBQq8rnYnCGEUVpBKwMBS/n7hrc35qP6kSgkvTZeOz6oULCEqnoPhVtNrdRlgZgylseh27NSlEx9TTUkDpbjz5QiYiWIg0L2cDQbCiXXZV1QTgjidhlbVjoQwS/BIGzFCwamNBjXAokOPtw6Z1qGanTC9Mj6Ualx2zy2Vs/BuADxdYjGUgAhZmlR/Q8KI4cjPSga7u0e1a6hRs1ts7wL/WyH4PTS8=
x-ms-exchange-antispam-messagedata: N3+y4ZOY/zLg/daUN5LT+bixMNJR8KPVNNHwFp3YZyH3YwxIgPIx/qnuliNZPSAHcd8Wh0li8t9FxoSL3pT2X+qD04V8URcXbqwmfLujxWpgFv4tWZJkKAxU8kbjHksmQaIGKodyBtd2Y1o7HApl0w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9742b504-e190-4d55-59f4-08d7d77f0f60
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 03:28:21.2876 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xR3zhrB4IMLURo8q4v+J9PRjGJ/qJd18p2XYn6lpLF2Y/R/tyC3gAL6lRX1/zsq6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
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
Cc: "Zhou, Tiecheng" <Tiecheng.Zhou@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tiecheng Zhou
Sent: Thursday, April 2, 2020 1:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou, Tiecheng <Tiecheng.Zhou@amd.com>
Subject: [PATCH] drm/amd/powerplay: determine pm_en at amd_powerplay_create

Need to determine pm_en at amd_powerplay_create of early_init stage.

Signed-off-by: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 3 +++
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c   | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index 71b843f542d8..a37dc37dfe49 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -48,6 +48,9 @@ static int amd_powerplay_create(struct amdgpu_device *adev)
 
 	hwmgr->adev = adev;
 	hwmgr->not_vf = !amdgpu_sriov_vf(adev);
+	hwmgr->pp_one_vf = amdgpu_sriov_is_pp_one_vf(adev);
+	hwmgr->pm_en = (amdgpu_dpm && (hwmgr->not_vf || hwmgr->pp_one_vf))
+				? true : false;
 	hwmgr->device = amdgpu_cgs_create_device(adev);
 	mutex_init(&hwmgr->smu_lock);
 	mutex_init(&hwmgr->msg_lock);
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
index f48fdc7f0382..7aee382fc1f9 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
@@ -221,9 +221,6 @@ int hwmgr_hw_init(struct pp_hwmgr *hwmgr)  {
 	int ret = 0;
 
-	hwmgr->pp_one_vf = amdgpu_sriov_is_pp_one_vf((struct amdgpu_device *)hwmgr->adev);
-	hwmgr->pm_en = (amdgpu_dpm && (hwmgr->not_vf || hwmgr->pp_one_vf))
-			? true : false;
 	if (!hwmgr->pm_en)
 		return 0;
 
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C879eafc288894347147c08d7d6c845b0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637214028875355960&amp;sdata=35oaGAN8RHzU4biNt7wWUZpskOehIQ0h%2Fao5HiVduBM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
