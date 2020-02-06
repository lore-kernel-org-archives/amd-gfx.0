Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E20EC2D0B1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 08:35:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD4B0206CC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 08:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2SVHd+mC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4B0206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74C8A89CF6;
	Thu,  6 Feb 2020 08:35:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B395D89CF6
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 08:35:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPEdBOVz/IH0TE83bwJVjCKvlP3fcgPno1In2sEgD4Bu9hVBGH/lOPNNNWz3MKVCZMWCpzaj4n5Imf9VFFHBMxDiyxnmlU7GijrMbIkMaXVy68fkfTqV9EeUU1QJLCrvKlmxnpSWtR05PMz6Do5M5pzk3bzc3kPDAb36gmEJf7jfEY5XLpkTCEeiOy0dC2SWkyotMRedln8gowJNNuhZXuGagZ6c8cz7+yCQ172wkUNjlT/tnMoaw5fQYESOynKHs45gdjaGWd5fqDLo51w+AWam7YaMYDxIdHZhxBZsPYqZOBnghG7N0Kj/RDv3owPtkfTYQqR+LcAlyUj7MyCi9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfKIalqlCJnqhxGM0F9j4Yk9/059Pma2TQAfc+VtuFU=;
 b=H2+OUo9XBwCpdxyOFhRmWSnWy9Eao8dPIAFFv6tH9yCh64clx3J0sxZjOmDz2EFBgoTuYRIueYWImrzpp+L5illzkanfIbaK8w6cQVUlcij9lyqiFDtKr2PHFgjNuey9TbAfEgeilieWAAftx+Tf/0WqlbvKP0dWSH31Oz1N1Fvcfw7TPH+cVx68AfaK6bnhDMlTbZxNbfQ3DafMldKcnJqo1zaEiOmJGjM8AclgTc6WS6DI+uBYQ3Jje4gaZGvzeUFdfMuzdng4AnSifsKJMMPiGT/J2pqzaSRWPWPL8wfJ+qIcMXtJ+/8S1IxMTzelnF8auFRAuY8dwL6lyg9cUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfKIalqlCJnqhxGM0F9j4Yk9/059Pma2TQAfc+VtuFU=;
 b=2SVHd+mCy8bvMCSZWInZN9zi+6JbRIIRCy+CtkIyXfAI22VQBHkAW6H5WPmvPkQ6p39G98a5Q4Uqr1mGxtjE2MXIVY0o05ndizyWiKXzPRdJXfUJCsqbzVZPdVmDqGueQDwuZdprl0TJzZsv7LTWyTwsuOY/SfrCiDkrHumuOYo=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1659.namprd12.prod.outlook.com (10.172.40.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 6 Feb 2020 08:35:02 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db%5]) with mapi id 15.20.2707.020; Thu, 6 Feb 2020
 08:35:02 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: handle features disablement for baco
 reset in SMU FW
Thread-Topic: [PATCH] drm/amd/powerplay: handle features disablement for baco
 reset in SMU FW
Thread-Index: AQHV3MYxRgfgUiWKT06q8E0WgOsN2qgN1ESg
Date: Thu, 6 Feb 2020 08:35:01 +0000
Message-ID: <DM5PR12MB14183A77E405BAEA934023CAFC1D0@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20200206081920.18766-1-evan.quan@amd.com>
In-Reply-To: <20200206081920.18766-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-06T08:34:54Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=381e3854-18d7-4ed3-8dc6-000087e9d6a9;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-06T08:34:54Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 499d28d6-a80d-4d43-ad30-00007ba5f678
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8330bd2f-7f42-4868-e928-08d7aadf7581
x-ms-traffictypediagnostic: DM5PR12MB1659:|DM5PR12MB1659:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1659540714C672697AEB2415FC1D0@DM5PR12MB1659.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(189003)(199004)(64756008)(110136005)(66446008)(76116006)(66946007)(66556008)(66476007)(316002)(71200400001)(86362001)(5660300002)(55016002)(53546011)(6506007)(52536014)(9686003)(478600001)(7696005)(26005)(186003)(33656002)(8936002)(2906002)(81156014)(8676002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1659;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zSHyZzhAhpGOGqL+2186nRYCsiyWHT1WhBuLXPSwpTTUc0MFNBIfedT4QD8Oa3WKcG+nDt11UO9FvooAsuN7ivB4XeQUI17ASRthEppk5D+E/+GTbxIEY9OQPzcWEqxrx/bvVxiMTUKyvd7AmI/CwDCmJWc1IocyiX830HYKlQ5XaBIvE6fQ7NUIws/EkkqyHHTf6SSMFa/j9wvQh+zzH01uJMTWkdFyD/SnI5EMQX50np7IRtNdpi9RrAFmkaMw1EW2fLbHOLb/ZeeNfYKElg9e+bQ53hOagppVJ2RCs0MyjsQIFCcNQCLU1jNKptSJtLJ32zNVJqbmB1xENdBtWbxe/phlznWURwmCpCyBd27F1m4TPeU6oYMXgbj37jfZbeWcdbsH9Zupos7wzTYitJvsCQvlKULBL3hHOYefDlmWvTrZDsakB0XvyURVbEIj
x-ms-exchange-antispam-messagedata: mBwf0zd+z8cp1IxyO7Wt1RXXjWA/TUDbAX5IExJqTS8URHSQtZO1cZQ6gv4jz4w18QJ7gO044dX+j7EG7iO0WMKnLgvsVAGhL9OOvYHQnbrbfQKGPCgOvue/OoLn9/fqiXGQSwI4ULIylgAEfEbl1g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8330bd2f-7f42-4868-e928-08d7aadf7581
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 08:35:01.9722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TCTtjbu0Y0tMpKg3V5FdmPArL4DKQE+mgEcK6gsdKqPkCSw/V9O2vCCXh2Qx2Hij1gklHQO89N+8ibnslUv5oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1659
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Thursday, February 6, 2020 16:19
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/powerplay: handle features disablement for baco reset in SMU FW

SMU FW will handle the features disablement for baco reset on Arcturus.

Change-Id: Ifd87a09de2fca0c67c041afbd5e711973769119a
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 53 +++++++++++++++++-----
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 9d1075823681..efd10e6fa9ef 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1467,24 +1467,39 @@ void smu_late_fini(void *handle)
 	smu_send_smc_msg(smu, SMU_MSG_PrepareMp1ForShutdown);  }
 
-static int smu_suspend(void *handle)
+static int smu_disabled_dpms(struct smu_context *smu)
 {
-	int ret;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	struct smu_context *smu = &adev->smu;
-	bool baco_feature_is_enabled = false;
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t smu_version;
+	int ret = 0;
 
-	if (!smu->pm_enabled)
-		return 0;
+	ret = smu_get_smc_version(smu, NULL, &smu_version);
+	if (ret) {
+		pr_err("Failed to get smu version.\n");
+		return ret;
+	}
 
-	if(!smu->is_apu)
-		baco_feature_is_enabled = smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT);
+	/*
+	 * For baco reset on Arcturus, this operation
+	 * (disable all smu feature) will be handled by SMU FW.
+	 */
+	if (adev->in_gpu_reset &&
+	    (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) &&
+	    (adev->asic_type == CHIP_ARCTURUS && smu_version > 0x360e00))
+		return 0;
 
+	/* Disable all enabled SMU features */
 	ret = smu_system_features_control(smu, false);
-	if (ret)
+	if (ret) {
+		pr_err("Failed to disable smu features.\n");
 		return ret;
+	}
 
-	if (baco_feature_is_enabled) {
+	/* For baco reset, need to leave BACO feature enabled */
+	if (adev->in_gpu_reset &&
+	    (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) &&
+	    !smu->is_apu &&
+	    smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)) {
 		ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
 		if (ret) {
 			pr_warn("set BACO feature enabled failed, return %d\n", ret); @@ -1492,6 +1507,22 @@ static int smu_suspend(void *handle)
 		}
 	}
 
+	return ret;
+}
+
+static int smu_suspend(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct smu_context *smu = &adev->smu;
+	int ret;
+
+	if (!smu->pm_enabled)
+		return 0;
+
+	ret = smu_disabled_dpms(smu);
+	if (ret)
+		return ret;
+
 	smu->watermarks_bitmap &= ~(WATERMARKS_LOADED);
 
 	if (adev->asic_type >= CHIP_NAVI10 &&
--
2.25.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
