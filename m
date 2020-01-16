Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6429FC33CB1
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 06:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EC672075B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 06:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ko03KNM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC672075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D60996EBEF;
	Thu, 16 Jan 2020 06:32:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FC816EBEF
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 06:32:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEMK0kTAlquE7IS89iaR9bEiOJFoLeOltBDXA/QivjlljrloNQQEk2Nky8UbigutUZj7dGn6LNsIJskuWcZHAVmwQBBjYCnFkKyICPmexYmjkEiBJuiC/iRmBAYw6bXA10TQuWyLxPVxlJp/P+sRNcsNR+R869oBf5gNJAq5vTbZ7iSeoAVuOpATQrMZovhj/OSYaEqAHaLzfXX14RtWWXSlNiYeurdyif0R6Z0vNgf4SOrILM773RIw5X7ctfFXtcTinQ+WgdGxVtJi/M2guGyxY9ukwDNJUSa3pz/aovoeSvk7da3tZWk74WGe8gKGpGgRzrA3JlKWFDOAN6Mb/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZfH+OM8phkxMVJnCKKCuk3X8E87ifCZSQT+se+BF+k=;
 b=QqV+KyAt//ZnirXta1JQGL7vfZBUgeoidwgVUwtBiBHVUx3vY0gKGwB20CUKinrumevrDpmKVAY9OwGC/3t7Q1TsYYc0pjDVIqUeQQVqgMrmGnvEVm/fZYtcLjf5Iw8HRmJ2aCCOMb8bI47DZTzo83cRZ1VlMTFKf92q9GSdhi/C+EA60yge2lX3iu0nMfxImPFfgmjLhuVGsiWf2o8g8bEOwUoheH/z94uyji0Hus5pVw5eeUDp0g42ycciGYAJt2H5ZY5LrHoDmD6gFUDe4fmL4rumhFDpk4c2v0+6COXU+e5WxgHrfaYPLGCQdxFx8f9ZudpuYUXhYja0IWOoLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZfH+OM8phkxMVJnCKKCuk3X8E87ifCZSQT+se+BF+k=;
 b=Ko03KNM+G+y5+mqtkqANE8XnWT7BZ45opcc32gT2wFljyEdgMoGn/e6bxF6bWsjsI44Xc0hbqE3sUgCLw47R2Vmb0pXJGLOSBOcRd998UU6LYShOoDJqDVCnAc5JND4fW68M1P1VCnc0O+WliC3KBrdvLtlk/BeTxeHFEUeG5TU=
Received: from CH2PR12MB3767.namprd12.prod.outlook.com (52.132.244.213) by
 CH2PR12MB3799.namprd12.prod.outlook.com (52.132.231.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 16 Jan 2020 06:32:08 +0000
Received: from CH2PR12MB3767.namprd12.prod.outlook.com
 ([fe80::703e:37ee:ddb1:d321]) by CH2PR12MB3767.namprd12.prod.outlook.com
 ([fe80::703e:37ee:ddb1:d321%3]) with mapi id 15.20.2644.015; Thu, 16 Jan 2020
 06:32:08 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add the lost mutex_init back
Thread-Topic: [PATCH] drm/amdgpu: add the lost mutex_init back
Thread-Index: AdXMM3R2ar8RTqN/RB+oGoIMPAFrEgAAzRqA
Date: Thu, 16 Jan 2020 06:32:08 +0000
Message-ID: <CH2PR12MB3767F4115CBAA3EFADDB7BDFFE360@CH2PR12MB3767.namprd12.prod.outlook.com>
References: <SN6PR12MB280058965C66589B199AC18C87360@SN6PR12MB2800.namprd12.prod.outlook.com>
In-Reply-To: <SN6PR12MB280058965C66589B199AC18C87360@SN6PR12MB2800.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=92bde98d-97ef-4e31-b1de-0000e258c821;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-16T06:08:40Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Feifei.Xu@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 820ad4d6-6af6-4112-a229-08d79a4dcfae
x-ms-traffictypediagnostic: CH2PR12MB3799:|CH2PR12MB3799:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB37998396903F20842C523C8CFE360@CH2PR12MB3799.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(189003)(199004)(33656002)(478600001)(45080400002)(966005)(4326008)(52536014)(5660300002)(316002)(110136005)(81166006)(81156014)(8676002)(8936002)(9686003)(71200400001)(26005)(53546011)(6506007)(186003)(86362001)(7696005)(64756008)(76116006)(66946007)(66476007)(55016002)(66556008)(66446008)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3799;
 H:CH2PR12MB3767.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DUhWwj5RC3PghM2vUHwXmkwQqI92oKkf1glIKCmaKIGx3+lNyvHE8sAPuN11oJWZykb8u1H5VIMYBeD2dWAfjJqN5SP/BguZFhcgFIJeOIXZ9ufiPqpTN0N9GWZMGUh9W2A27MRlEwHmK6VSdQiAbieUk0hpROpd7+y3bQGLTTiJklpEWbQLc/XKIz90LuvROLVtgdS9wIHhN6ehCoiBILEjek2fix4rdMfF7uDpoLaJN0enH8PMlGiMfPhQJLdHenWqDa3TtNjbQv2I6GZQgS4oiCM2sVHZ3LdrtGouDm5RVmm7orE/oUbnrwE4opJlw0GJ6iikBISLyb4ROw2lxpE/a3/fgdTi0in8lmG8tYQGUQfMTqU1pm9AdU/DqtK72d2f6aHUubqfHoCj9UvC1FL+sj79n5Kjj7poSgm+8nQPUjbh4ER3kVQ3FlW4qcW7gSx2OecxgUmsrhDnRaHA6sb3CNJWhJpGEryMvkjRPoI=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 820ad4d6-6af6-4112-a229-08d79a4dcfae
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 06:32:08.3202 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RZXsWo2UD1sNNdS4SzeCVzjpRoReq+Cet02Ost5xPZJZjWDYKz1qzEQ2nZanAt/q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3799
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


Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Pan, Xinhui
Sent: Thursday, January 16, 2020 2:10 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add the lost mutex_init back


Initialize notifier_lock.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2c64d2a83d61..c2453532fd95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2851,6 +2851,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	hash_init(adev->mn_hash);
 	mutex_init(&adev->lock_reset);
 	mutex_init(&adev->psp.mutex);
+	mutex_init(&adev->notifier_lock);
 
 	r = amdgpu_device_check_arguments(adev);
 	if (r)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CFeifei.Xu%40amd.com%7Cc9b343a7880547442b7108d79a4aafda%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637147517952107932&amp;sdata=42C3Wzh1ns23%2BhjFlX0sbqxEyYmGejLLzVUZ50b1lNw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
