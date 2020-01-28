Return-Path: <SRS0=HJvn=3R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F0FC2D0DB
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 20:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C27A206F0
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 20:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UwuGomw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C27A206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16EDC6F3D6;
	Tue, 28 Jan 2020 20:09:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B6266F3D6
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 20:09:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUhhMEBZcfZ4BBwyK2oEdFjQxpqPxG/ULz3e7XwmxeCtLFf41gyx9dk9JFeDKcoT1pF+/dMCmCXkCHmmWRzlLIymxEFsVLwOKnRnK6z9Ikqbqy92j8594D6tLNGREF0NEETwiCMp2g9JUfMX5/GQ+u+r9/YpKdWM51JRJS0OZptimaqcJh4Vt2SGGqMT24XNME2YRM6Mii1ZnTylinNr7IYAz0znWQZ08KR59KEzzBI5dOlEBvM7Nvox7FTdMqS8WCa+XcqXVqiTw+kgZfr58GPFdbLp1cVVxU/EB4rZsyDx+9PaYf54/JKa2o34b1/8/z63TpoOrKhl6UABXViiOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ff05AvUlZc5R2QceWP1/ygTbxVF3YVXJxLnqhri80vs=;
 b=YkN4v3ex+WHrEWRPvhVcbpmZ1O7Ef9S3tboVha4T2XXyW7W2yC21aGpgS5liWqgBXwiY84evuLM969BHntXqzGJn2SvBWGE1pZjDBp0H+cxEQbzdbl5JttRaIBMhE1tHRNqMvcYN0HNLgokpmQAv0d4akOW3Tmwx0XyFgtCL/TUC60xffZ1Z8SIlci/PIMt40LgBsGK+ftPY3QAesmr+LbthLEvtUZpfWT7pE6wabmMKyVIYHf6BZsnmU5oh5srSknJiXzksc2KO+/YGoi0514gSCSPnsKD4UJkGLMQMTZxytIlQTH4xzHv828yHWQf+z5OpbIHZulj8JY9HtKKB5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ff05AvUlZc5R2QceWP1/ygTbxVF3YVXJxLnqhri80vs=;
 b=UwuGomw5YH9XNFIOA8gy04FPAfwqySVZ0TSOiY7BGW7PRaji4GoY9pGFf+pCucexxgpP9DjDVBT35rE2C/vROsHAwV94ocY/FF3wqifNLhyBXiONiwE3PxUYFx+jBPjNSHw4QX9zNXuI+otpysPfM2ORqytKFT4D3H7zTrd7uWM=
Received: from BL0PR12MB2580.namprd12.prod.outlook.com (52.132.27.147) by
 BL0PR12MB2353.namprd12.prod.outlook.com (52.132.10.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Tue, 28 Jan 2020 20:09:44 +0000
Received: from BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::ecfa:6961:597:9676]) by BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::ecfa:6961:597:9676%3]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 20:09:44 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [Patch v1 5/5] drm/amdkfd: refactor runtime pm for baco
Thread-Topic: [Patch v1 5/5] drm/amdkfd: refactor runtime pm for baco
Thread-Index: AQHV1XqDmCOvFX8VnkSDrnZSCE1p7KgAeWIg
Date: Tue, 28 Jan 2020 20:09:43 +0000
Message-ID: <BL0PR12MB2580399D1AA3C66566D7C95F800A0@BL0PR12MB2580.namprd12.prod.outlook.com>
References: <20200128012923.25536-1-rajneesh.bhardwaj@amd.com>
 <20200128012923.25536-6-rajneesh.bhardwaj@amd.com>
In-Reply-To: <20200128012923.25536-6-rajneesh.bhardwaj@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-28T20:09:41Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=356ae1d6-b3ae-4e26-83ba-00002e9a19c9;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-28T20:09:41Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 6f463223-f749-4ec5-9fdb-0000c8849df6
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Oak.Zeng@amd.com; 
x-originating-ip: [99.228.101.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ca4a2d5-b2be-4bef-71a2-08d7a42e0421
x-ms-traffictypediagnostic: BL0PR12MB2353:|BL0PR12MB2353:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2353471A2494448BECE8EF2D800A0@BL0PR12MB2353.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(199004)(189003)(8936002)(55016002)(9686003)(8676002)(81166006)(81156014)(7696005)(45080400002)(2906002)(86362001)(966005)(478600001)(4326008)(110136005)(33656002)(66946007)(6506007)(66556008)(66446008)(66476007)(64756008)(53546011)(76116006)(54906003)(5660300002)(71200400001)(316002)(26005)(186003)(52536014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2353;
 H:BL0PR12MB2580.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SxRJi/kFbUumJq8ntc76aKzR8H3uhZgXhDDhtebk91ecpv5oxPz9FU1W4bcMrs5OnaGBRZdEDJstzC7MIIW9IbdR+lfliTcBtxcOFEnjGiPnwREaGUy/iTqWa5olDVEf2AiDC+/BnekR5+NE6ilAclPwauVv12r3qROr9AIFEeRIoD2aSh/xB/hGcGI5v2+S0LwuwOmZBkBy4k8vEPwvLTOErIThIKXvdW6vfL2Hhp0jW6dGtRSHa9zm+bLRCLetY99pJM1Fiz9qpKTGn5L7RAVG+oRW47mIRi4tFsxRT9KZTV+M775KYSjvOViW8a0v+NzEnNtlWWcd8Rc988ksVuOB9TUbrIFoN0Z7xYNR6MCuKlpgf5xO8Eq+9r0AkcPf9juHUsjY3vCNvK39SiLM6vyWuY0MJt1JEjap/XP2rSx7ob5l6K3faiUiw0PzZFBE81foU7kPPKbtHqp9Gwqo8q2GPvJukFg9i+fqO9+0JrgOCIdfkC6fVLbZuqNZz0Xiq/GOazagJDiNm/bW66fpBg==
x-ms-exchange-antispam-messagedata: USAMiec1BgEGpG55I+kaYCtVOjKFpLVzmXFQ3Paepfwpa7bQ+S2i0+o4sjQb1vB/ezTf1plDQkmKVIX7sFT7gvJL9szOy5TxSAxi308ZvTXL9yhq8JOOdhqaasysJUMwzqm1acRtyNtfXdG4hkM5uw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca4a2d5-b2be-4bef-71a2-08d7a42e0421
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 20:09:43.8087 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pwrb8DRmLmZVMC/btmzcCVMz7rlHm5Vzn811kP58lViLUulty1YRJiyBdOEZXdAL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2353
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Bhardwaj,
 Rajneesh" <Rajneesh.Bhardwaj@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]



Regards,
Oak

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Rajneesh Bhardwaj
Sent: Monday, January 27, 2020 8:29 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Bhardwaj, Rajneesh <Rajneesh.Bhardwaj@amd.com>
Subject: [Patch v1 5/5] drm/amdkfd: refactor runtime pm for baco

So far the kfd driver implemented same routines for runtime and system wide suspend and resume (s2idle or mem). During system wide suspend the kfd aquires an atomic lock that prevents any more user processes to create queues and interact with kfd driver and amd gpu. This mechanism created problem when amdgpu device is runtime suspended with BACO enabled. Any application that relies on kfd driver fails to load because the driver reports a locked kfd device since gpu is runtime suspended.

However, in an ideal case, when gpu is runtime  suspended the kfd driver should be able to:

 - auto resume amdgpu driver whenever a client requests compute service
 - prevent runtime suspend for amdgpu  while kfd is in use

This change refactors the amdgpu and amdkfd drivers to support BACO and runtime runtime power management.
[Oak] two runtime above

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 12 ++++-----  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  8 +++---  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 31 +++++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c     |  5 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 19 ++++++++++---
 6 files changed, 51 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 8609287620ea..314c4a2a0354 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -178,18 +178,18 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
 		kgd2kfd_interrupt(adev->kfd.dev, ih_ring_entry);  }
 
-void amdgpu_amdkfd_suspend(struct amdgpu_device *adev)
+void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm)
[Oak] then name run_pm is a little bit confusing. Maybe system_wide_pm or none_runtime_pm?
 {
 	if (adev->kfd.dev)
-		kgd2kfd_suspend(adev->kfd.dev);
+		kgd2kfd_suspend(adev->kfd.dev, run_pm);
 }
 
-int amdgpu_amdkfd_resume(struct amdgpu_device *adev)
+int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)
 {
 	int r = 0;
 
 	if (adev->kfd.dev)
-		r = kgd2kfd_resume(adev->kfd.dev);
+		r = kgd2kfd_resume(adev->kfd.dev, run_pm);
 
 	return r;
 }
@@ -713,11 +713,11 @@ void kgd2kfd_exit(void)  {  }
 
-void kgd2kfd_suspend(struct kfd_dev *kfd)
+void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
 {
 }
 
-int kgd2kfd_resume(struct kfd_dev *kfd)
+int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 0fa898d30207..3dce4a51e522 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -123,8 +123,8 @@ struct amdkfd_process_info {  int amdgpu_amdkfd_init(void);  void amdgpu_amdkfd_fini(void);
 
-void amdgpu_amdkfd_suspend(struct amdgpu_device *adev); -int amdgpu_amdkfd_resume(struct amdgpu_device *adev);
+void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm); 
+int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
 void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
 			const void *ih_ring_entry);
 void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev); @@ -250,8 +250,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 			 struct drm_device *ddev,
 			 const struct kgd2kfd_shared_resources *gpu_resources);  void kgd2kfd_device_exit(struct kfd_dev *kfd); -void kgd2kfd_suspend(struct kfd_dev *kfd); -int kgd2kfd_resume(struct kfd_dev *kfd);
+void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm); int 
+kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
 int kgd2kfd_pre_reset(struct kfd_dev *kfd);  int kgd2kfd_post_reset(struct kfd_dev *kfd);  void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d9e5eac182d3..787d49e9f4de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3314,7 +3314,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 		}
 	}
 
-	amdgpu_amdkfd_suspend(adev);
+	amdgpu_amdkfd_suspend(adev, fbcon);
 
 	amdgpu_ras_suspend(adev);
 
@@ -3398,7 +3398,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 			}
 		}
 	}
-	r = amdgpu_amdkfd_resume(adev);
+	r = amdgpu_amdkfd_resume(adev, fbcon);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 2a9e40131735..e9f00c3a067a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -23,6 +23,7 @@
 #include <linux/bsearch.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 #include "kfd_priv.h"
 #include "kfd_device_queue_manager.h"
 #include "kfd_pm4_headers_vi.h"
@@ -710,7 +711,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,  void kgd2kfd_device_exit(struct kfd_dev *kfd)  {
 	if (kfd->init_complete) {
-		kgd2kfd_suspend(kfd);
+		kgd2kfd_suspend(kfd, true);
 		device_queue_manager_uninit(kfd->dqm);
 		kfd_interrupt_exit(kfd);
 		kfd_topology_remove_device(kfd);
@@ -731,7 +732,7 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
 
 	kfd->dqm->ops.pre_reset(kfd->dqm);
 
-	kgd2kfd_suspend(kfd);
+	kgd2kfd_suspend(kfd, true);
 
 	kfd_signal_reset_event(kfd);
 	return 0;
@@ -765,21 +766,24 @@ bool kfd_is_locked(void)
 	return  (atomic_read(&kfd_locked) > 0);  }
 
-void kgd2kfd_suspend(struct kfd_dev *kfd)
+void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
 {
 	if (!kfd->init_complete)
 		return;
 
-	/* For first KFD device suspend all the KFD processes */
-	if (atomic_inc_return(&kfd_locked) == 1)
-		kfd_suspend_all_processes();
+	/* for runtime suspend, skip locking kfd */
+	if (run_pm) {
+		/* For first KFD device suspend all the KFD processes */
+		if (atomic_inc_return(&kfd_locked) == 1)
+			kfd_suspend_all_processes();
+	}
 
+	pm_runtime_set_autosuspend_delay(kfd->ddev->dev, 5000);
[Oak]: why this is necessary? This timeout value has already been set in driver load. See amdgpu_driver_load_kms
 	kfd->dqm->ops.stop(kfd->dqm);
-
 	kfd_iommu_suspend(kfd);
 }
 
-int kgd2kfd_resume(struct kfd_dev *kfd)
+int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 {
 	int ret, count;
 
@@ -790,10 +794,13 @@ int kgd2kfd_resume(struct kfd_dev *kfd)
 	if (ret)
 		return ret;
 
-	count = atomic_dec_return(&kfd_locked);
-	WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
-	if (count == 0)
-		ret = kfd_resume_all_processes();
+	/* for runtime resume, skip unlocking kfd */
+	if (run_pm) {
+		count = atomic_dec_return(&kfd_locked);
+		WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
+		if (count == 0)
+			ret = kfd_resume_all_processes();
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
index 8d871514671e..6301d77ed3d6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/amd-iommu.h>
+#include <linux/pm_runtime.h>
 #include "kfd_priv.h"
 #include "kfd_dbgmgr.h"
 #include "kfd_topology.h"
@@ -134,8 +135,10 @@ void kfd_iommu_unbind_process(struct kfd_process *p)
 	struct kfd_process_device *pdd;
 
 	list_for_each_entry(pdd, &p->per_device_data, per_device_list)
-		if (pdd->bound == PDD_BOUND)
+		if (pdd->bound == PDD_BOUND) {
 			amd_iommu_unbind_pasid(pdd->dev->pdev, p->pasid);
+			pm_runtime_set_autosuspend_delay(pdd->dev->ddev->dev, 5000);
[Oak] This only set the timeout. The correction function to call is pm_runtime_put_autosuspend?
I think it is better to call it at the end of kfd_process_wq_release directly and call pm_runtime_mark_last_busy first.
+		}
 }
 
 /* Callback for process shutdown invoked by the IOMMU driver */ diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 25b90f70aecd..d19d5e97405c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -31,6 +31,7 @@
 #include <linux/compat.h>
 #include <linux/mman.h>
 #include <linux/file.h>
+#include <linux/pm_runtime.h>
 #include "amdgpu_amdkfd.h"
 #include "amdgpu.h"
 
@@ -843,15 +844,27 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
 		return ERR_PTR(-ENOMEM);
 	}
 
+	err = pm_runtime_get_sync(dev->ddev->dev);
+	pm_runtime_set_autosuspend_delay(dev->ddev->dev, 60000);
[Oak]: The second call is not necessary
+	if (err < 0)
+		return ERR_PTR(err);
+
 	err = kfd_iommu_bind_process_to_device(pdd);
 	if (err)
-		return ERR_PTR(err);
+		goto out;
 
 	err = kfd_process_device_init_vm(pdd, NULL);
 	if (err)
-		return ERR_PTR(err);
+		goto out;
 
-	return pdd;
+out:
+	pm_runtime_mark_last_busy(dev->ddev->dev);
+	pm_runtime_put_autosuspend(dev->ddev->dev);
+
+	if (!err)
+		return pdd;
+	else
+		return ERR_PTR(err);
 }
 
 struct kfd_process_device *kfd_get_first_process_device_data(
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Coak.zeng%40amd.com%7Ce57e1eeb5fd74b5d8dea08d7a391a089%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637157718236258423&amp;sdata=zqM5YTz7qofPZjG3PmWKbHQ4sMMZjol1IlzaNTwQtcw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
