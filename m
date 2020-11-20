Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDB1C5519F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 15:04:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FAE1221F8
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 15:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UXl7cN20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FAE1221F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C74EE6E8CF;
	Fri, 20 Nov 2020 15:04:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 346956E8CF
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 15:04:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtNd94N97Iy3iVcUGbl9oqvTGlqY0tPmeB1JIUklp4nro0mOvqN3f4ZT0CdSf/DPDLIYAD+U9uLYRqVqHV3ZWQiUDcxw3t0lC2tbK1k1lDX2zKlZKpyyF6rbpeOEDpRKniRQYgwQ1NU0udMbp8xrVm5aKKAf1AaNQIrzJm5U48yJy4NcuAy39yeMGy+M1TX5ARiJifZyZX2KZc58Tz2oWN1/YMfO+pVctwYQDgfMr282LiTRF0TpzzSRZ8r/ewiVPbbwH5J5ETKZZLkOV/Ln73Gogtk4iNQbSiDJNdSpYrhRBhNtIuOE2mI8Kk+UqIkxu50XDsqIZ6em4yY/tB+uVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZu6z9tGLS/rzFniwyQHH+EDbo2syKNI52WR/Os26Bo=;
 b=ZLMBdh11nz40uxixhAJhMPoiQHSvlSJ8isC7Eg/pfiz++9p/uFFx0NZRPg7Aciy9SK2JbAYpNFT3JXeIxgfvR5YhXIGzzYxPbef8fmqLOfkzmXrPN6NX+3BtnKkqNe5c9YP62jSESQusrOa4UQ/2dKYaoVyMKkiChKi7n9OgiLM2tBjFf2E2pbzXA/paPo090QVoFwRbYtc2Q9mFXH2goslmQY7QGIWB1qumgWh4jyBAWgOpMclFXSV6AMUmfg5hQOHz6h8j0Hzv+54iX/13s1sUhwgq5Sncg72bq7NYG5LT179agJ6G/DiGAWQ4OkFEYrvViUSB5Ng5N76JYa9QPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZu6z9tGLS/rzFniwyQHH+EDbo2syKNI52WR/Os26Bo=;
 b=UXl7cN20agIYLwkNP+IxJkX1ArrsgdvtKr+hYaEMaV4hvjGmJ5Fj7OJsA6k48C+fIrnVExpqwzEerEBpPhxCKlV+MxvicHAdWbUaJS6I0N9hkkdVoNVlXQ0GUvXLTW8/lfLVXzz/7XOhT7whMShoeWC3ROEyqnpbb2G7uZ3p6+A=
Received: from BL0PR12MB4707.namprd12.prod.outlook.com (2603:10b6:208:8a::31)
 by MN2PR12MB4992.namprd12.prod.outlook.com (2603:10b6:208:3c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Fri, 20 Nov
 2020 15:04:53 +0000
Received: from BL0PR12MB4707.namprd12.prod.outlook.com
 ([fe80::c9c3:9ac3:102c:226d]) by BL0PR12MB4707.namprd12.prod.outlook.com
 ([fe80::c9c3:9ac3:102c:226d%3]) with mapi id 15.20.3589.021; Fri, 20 Nov 2020
 15:04:53 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: only register VGA devices with the VGA arbiter
Thread-Topic: [PATCH] drm/amdgpu: only register VGA devices with the VGA
 arbiter
Thread-Index: AQHWv001qsW+RBLabk6noP02VmvvVqnRHl1g
Date: Fri, 20 Nov 2020 15:04:53 +0000
Message-ID: <BL0PR12MB4707B251571E1D43126A324CFEFF0@BL0PR12MB4707.namprd12.prod.outlook.com>
References: <20201120145526.305912-1-alexander.deucher@amd.com>
In-Reply-To: <20201120145526.305912-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=1788ddd5-82f1-4329-b062-4848a991ae38;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-20T15:04:46Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a15023f5-a9e3-47fe-2e07-08d88d65a2d9
x-ms-traffictypediagnostic: MN2PR12MB4992:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB49927D801EA5645E782F4923FEFF0@MN2PR12MB4992.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8kNkOaeC047Ju9pa2J3v7AQbZ9YBSs0XESh0cpL8W/UNHJfrtlniiBJJr4fs/LV9GPhss+Uhq38gmaSVmgn1SvOlNog+6eI/nO5v2/bQIIz0sgFqIutYh0+YtQRy6mYfcingtEUc9PY8KVMMPCntZxiEbu7Up25GUtOy6DoAACJMiA/7/sZH8OItYPEe+Y3NbP2kMCOvJWg7GjSj/k7X7cQuGm7d9LX9A9MKqAMbo6pScgNOaUqhGqoQNDBNSq5b0sM0fdyZbgehx+9XY4R0/PjkZKjveUbeB8KXeZqzFO42VVIsNTAml8dFHz8Wb+l2Yzyndk0alYRQlU2hUlcvQMSikp1t2ZzB1nszZRKMo8Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4707.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(316002)(6506007)(2906002)(52536014)(7696005)(26005)(53546011)(110136005)(83380400001)(186003)(71200400001)(9686003)(55016002)(76116006)(45080400002)(66556008)(86362001)(966005)(66446008)(64756008)(478600001)(66946007)(8936002)(8676002)(66476007)(4326008)(5660300002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: tu7PI2qaJ2Vff9IxuUDf0JdMiAaAy6DzOnMxugchSkcE6m98QcO4Kt9Wm6OPKpEYQO23okP3P0chrX2TtU1LziB8GjlS5a+eng7dre1My+g4TWTy/dkTBsUrwHRSOL2ebLpQEYoEAbBA77FDOXQzK1PVZyZH5uvxRT5jBpJ0vL3RuUYEd4Lnyku+ZOBwZVUsCD9xmDdO7LqmXD4XCDgaiQ9V+0eewwntGOOhRyVJ24jEf8DpIbGrFtUE1Wrpk/RzbKnwwvoQqv0vGiE1LYrQQZNVtmuqRCVHJVCY6wzmEtKMF82kOUcrqTEaTpkEyjWB9hyz13rsZmBDRTiwO3n7YPron7s+MRkNLn8UR8mgrWOxlpWVu8D1afDMjvWRWCtG29cBYQeFdkNpKRXgsq6xjl+ECop5EOqS1W1DUNJABT9gMPM52gcf+umLvPuxZHQJ+42lcSurAiCElNeS8T7gJXgi/kbUog9jokbisxNYhGUyO4Z9VKazzIQct93McnzLsLPxE7q/ELPr1Az1te3AzounX0NTcVYEhOixwWqdCwl7PICi/g4EtBC9kGiqR3Oqa5ihQKAErHIURfkOW0ibh/uUI2jYV72X9vfkKP2MjDMDKikY3Q7oUwKfirCJ8msqQyzSi7ws+X7Ouo0eiFjZ9YulrRMWIwcgKEHeJo1fgEwyTGh3fgubLcWkC4go6OSr2FJeC24TMUtX6Iq7IquQeyXYoQJ2QBvvuCphgT8gxxG+gJg3d0KF04IXQl3ifUZGbru28isj4K7VT5THjS9Lz+gWXASsBjmYdI9Gsm0wSgYBHwC4ny4ov3Xq396Unv9CxhX9SZhawBbEO1I+O6dv7mDyUu9DPnJ7fVDFvuwpyhAzowk6z8wS6HTzQycmB/UMluL/JmFgan8SFInFxzNgiQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4707.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15023f5-a9e3-47fe-2e07-08d88d65a2d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 15:04:53.5760 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IZho/jMzQLIiIeVFukz+Us6iCaFVbTzFBAz+tOv0Nn5p1gjz8t3oRun6OQSaK/56
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4992
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

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Friday, November 20, 2020 10:55 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: only register VGA devices with the VGA arbiter

We only need to arbitrate VGA access on VGA compatible devices.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2f60b7084f4d..2670fb113ba1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3346,7 +3346,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 /* if we have > 1 VGA cards, then disable the amdgpu VGA resources */
 /* this will fail for cards that aren't VGA class devices, just
  * ignore it */
-vga_client_register(adev->pdev, adev, NULL, amdgpu_device_vga_set_decode);
+if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
+vga_client_register(adev->pdev, adev, NULL, amdgpu_device_vga_set_decode);

 if (amdgpu_device_supports_boco(ddev))
 boco = true;
@@ -3605,7 +3606,8 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 vga_switcheroo_unregister_client(adev->pdev);
 if (amdgpu_device_supports_boco(adev_to_drm(adev)))
 vga_switcheroo_fini_domain_pm_ops(adev->dev);
-vga_client_register(adev->pdev, NULL, NULL, NULL);
+if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
+vga_client_register(adev->pdev, NULL, NULL, NULL);
 if (adev->rio_mem)
 pci_iounmap(adev->pdev, adev->rio_mem);
 adev->rio_mem = NULL;
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CFeifei.Xu%40amd.com%7C8eac65802c2841a4016408d88d645737%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637414809390017528%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=4YGYTXm%2FY8MAQiqs4QJ1MUIcy2%2F4waucDrIeob63ogk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
