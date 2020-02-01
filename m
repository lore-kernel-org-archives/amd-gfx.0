Return-Path: <SRS0=aySl=3V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C5EC33CB3
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Feb 2020 04:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92682206E6
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Feb 2020 04:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="o6olg6hb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92682206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CF9F6E2C0;
	Sat,  1 Feb 2020 04:21:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F2296E2C0
 for <amd-gfx@lists.freedesktop.org>; Sat,  1 Feb 2020 04:21:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuMYnzQQ3o78y41mVoZ/LI9U4tIZ8z4jP84de496ZQYRR1rZks/ZHmhM8qdI0BwyrQgDudm/F7RsrvyCmSL08zCc9n0IVYDdTfBxrabgjG4126VaDP8ZEF35ltvQqmQpnaskn/jZbmqfbrbaoARnNeI2l+ADROd7U1hSmjW7tlhOCha2qj3fe+sQTuO4YSoKxDc7lYbo8dTxONL+y6JcnHjog1TK7zyl2jGxRd3FYFrxAA3BXDIMe3501/33hBN+OqGHqpMrE+LRc+quFEbSSs+ELMl4zcReSF/8+zPUwakNB3oFfHUNCtUyvdWcqZY1oWWA0+7LIaLftAITfJMh+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkicoN+Eg69naSwO92p0Wo7ykBevSSIyhH13+ym3Rco=;
 b=mhpaSSbqHZllD5o+tyzpLOVijTyRt4yPnLhJkOWOR5jJWVXxN0H0bJvUtoydMkt4MLBSpf1c9XrLoV3tjHZRtic39s4RYEf+epi9Iiy3gnwqlSG5WY4PuRZm7iC4HbGP2rOVxxdpYl4yiDd9UzJ2RZn6zjX7/GUqbeXiRtUj4W00twky4of2b8nnqBX1zH72hzsH5qMqDfgvDJtzaEHSioOlUsti5++Tmo+kF5xAB01Xboa5DJFOJVj2jYUG3btugmPRd8Gonc9as1qLdADJGPo+eLOx/HQ81ppMUI/qaAA56eH0zcoqnio0LatjeHLhCqgTIsf1Sg7R20vvy30MTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkicoN+Eg69naSwO92p0Wo7ykBevSSIyhH13+ym3Rco=;
 b=o6olg6hbSFCZcYkdYNTPm6N9pWD88dlbPbmwirYqpgYjEW00/EVSt5tNo1+dbW9SQ/ppZoNvDXu+l4unnO/2LE8DXVa9tqbI4SBhoSHZ8RaLJFIqzMbdzGJ+XvMPislmB5jDjrhRdo7c9cScdreVpa1UtFNnzOLUUJgU9bfP2Vs=
Received: from BL0PR12MB2580.namprd12.prod.outlook.com (52.132.27.147) by
 BL0PR12MB2340.namprd12.prod.outlook.com (52.132.11.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Sat, 1 Feb 2020 04:21:23 +0000
Received: from BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::ecfa:6961:597:9676]) by BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::ecfa:6961:597:9676%3]) with mapi id 15.20.2665.027; Sat, 1 Feb 2020
 04:21:23 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [Patch v2 3/4] drm/amdkfd: refactor runtime pm for baco
Thread-Topic: [Patch v2 3/4] drm/amdkfd: refactor runtime pm for baco
Thread-Index: AQHV2LD1e5Wr66YpiE6ujK8uOzMeaqgFtvcA
Date: Sat, 1 Feb 2020 04:21:22 +0000
Message-ID: <BL0PR12MB2580A03910EE0EFAE1D6DE5F80060@BL0PR12MB2580.namprd12.prod.outlook.com>
References: <20200201033707.16351-1-rajneesh.bhardwaj@amd.com>
 <20200201033707.16351-4-rajneesh.bhardwaj@amd.com>
In-Reply-To: <20200201033707.16351-4-rajneesh.bhardwaj@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-01T04:21:21Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0367746d-dead-41ee-9788-00009ed6c180;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-01T04:21:21Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 78d9957f-d4ce-458f-ba3b-000055ad0bba
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Oak.Zeng@amd.com; 
x-originating-ip: [99.228.101.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dfeea88b-e345-41bb-a0da-08d7a6ce3220
x-ms-traffictypediagnostic: BL0PR12MB2340:|BL0PR12MB2340:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2340519C60257A174FC09B6080060@BL0PR12MB2340.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03008837BD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39850400004)(366004)(376002)(346002)(136003)(396003)(199004)(189003)(8936002)(4326008)(316002)(33656002)(45080400002)(81166006)(81156014)(86362001)(186003)(8676002)(110136005)(9686003)(5660300002)(478600001)(53546011)(6506007)(71200400001)(26005)(966005)(54906003)(66476007)(66556008)(64756008)(66446008)(66946007)(52536014)(7696005)(55016002)(76116006)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2340;
 H:BL0PR12MB2580.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: twVjTnK3ZLTXzTPOahBurcJIBiizwCFdz69xuLcieStM6hpZyZ2n6HxvXC7PUTolqdZMktJEB/CTaGpPadFBzoCa9yfdLxJAFf/aobmyiJKMx5ZbLNfWNO102n42x8z8LDuhkvOlluvrN4X5rIrsxeBd5gthXEkjDhI1ZUpkqHpsUU1NsHmIfeo56Llcwc0VGxvf1xtWbezlG0HJeFNQuidNfYYrXsn/uk7wDYWCC9rnRYMgjVhceFSb2PSOQyKJwOdzqZ3FLD6mRd+4Wycn3uEFGAyA9atSrgqWcCDymFu68PJX2eQe09NFT1hpA5AblWmJ6aw6QGtF8zJOF6mPB9GQ/g0y0O4fePrGgmuLfpTX+6OIGfvntSmKgxYyfSJbFlWdbDPeUi1WbYZwU7rFnz5SE87T6m+7I5oJfVd9LPZZB6a4uqLK6DMZLJFqokkSNtnJMMfDDSuQD558V861tIOUx/UbKSP2hcMD1YOZgSfqcaqojkLt9pRGNHLKMjgvkVDSpqTbVser9b0/9p5Z6w==
x-ms-exchange-antispam-messagedata: 03SkFjatU/l8JB2KXmY1Oi5aQPfh/thRIvR+h2h4Z0d4Obi6TlhBiCeK5kVHjmXasS5l4Yq8XZBPySMiZo65Mp6d4yhDSh/RQt5lslUxfOEDIRKYK+8FwDxlKfE7ym0Wy5jAxv7vXEyFUWMlRcM7XA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfeea88b-e345-41bb-a0da-08d7a6ce3220
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2020 04:21:22.9777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ux30leidUgBYmB1asUA7ISOvbD01g2McejkrxJyfRUcz8xFd0N3udhHb9STsQ0Nk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2340
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

Patch 1,2,3 work for me. See one comment inline, otherwise Reviewed-by: Oak Zeng <Oak.Zeng@amd.com>

Regards,
Oak

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Rajneesh Bhardwaj
Sent: Friday, January 31, 2020 10:37 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Bhardwaj, Rajneesh <Rajneesh.Bhardwaj@amd.com>
Subject: [Patch v2 3/4] drm/amdkfd: refactor runtime pm for baco

So far the kfd driver implemented same routines for runtime and system wide suspend and resume (s2idle or mem). During system wide suspend the kfd aquires an atomic lock that prevents any more user processes to create queues and interact with kfd driver and amd gpu. This mechanism created problem when amdgpu device is runtime suspended with BACO enabled. Any application that relies on kfd driver fails to load because the driver reports a locked kfd device since gpu is runtime suspended.

However, in an ideal case, when gpu is runtime  suspended the kfd driver should be able to:

 - auto resume amdgpu driver whenever a client requests compute service
 - prevent runtime suspend for amdgpu  while kfd is in use

This change refactors the amdgpu and amdkfd drivers to support BACO and runtime power management.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 12 +++---  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  8 ++--  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 29 +++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 43 ++++++++++++++++++++--
 6 files changed, 70 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 8609287620ea..314c4a2a0354 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -178,18 +178,18 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
 		kgd2kfd_interrupt(adev->kfd.dev, ih_ring_entry);  }
 
-void amdgpu_amdkfd_suspend(struct amdgpu_device *adev)
+void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm)
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
index 47b0f2957d1f..9e8db702d878 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -122,8 +122,8 @@ struct amdkfd_process_info {  int amdgpu_amdkfd_init(void);  void amdgpu_amdkfd_fini(void);
 
-void amdgpu_amdkfd_suspend(struct amdgpu_device *adev); -int amdgpu_amdkfd_resume(struct amdgpu_device *adev);
+void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm); 
+int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
 void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
 			const void *ih_ring_entry);
 void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev); @@ -249,8 +249,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 			 struct drm_device *ddev,
 			 const struct kgd2kfd_shared_resources *gpu_resources);  void kgd2kfd_device_exit(struct kfd_dev *kfd); -void kgd2kfd_suspend(struct kfd_dev *kfd); -int kgd2kfd_resume(struct kfd_dev *kfd);
+void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm); int 
+kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
 int kgd2kfd_pre_reset(struct kfd_dev *kfd);  int kgd2kfd_post_reset(struct kfd_dev *kfd);  void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5030a09babb8..43843e6c4bcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3311,7 +3311,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 		}
 	}
 
-	amdgpu_amdkfd_suspend(adev);
+	amdgpu_amdkfd_suspend(adev, !fbcon);
 
 	amdgpu_ras_suspend(adev);
 
@@ -3395,7 +3395,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 			}
 		}
 	}
-	r = amdgpu_amdkfd_resume(adev);
+	r = amdgpu_amdkfd_resume(adev, !fbcon);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 798ad1c8f799..42ee9ea5c45a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -732,7 +732,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,  void kgd2kfd_device_exit(struct kfd_dev *kfd)  {
 	if (kfd->init_complete) {
-		kgd2kfd_suspend(kfd);
+		kgd2kfd_suspend(kfd, false);
 		device_queue_manager_uninit(kfd->dqm);
 		kfd_interrupt_exit(kfd);
 		kfd_topology_remove_device(kfd);
@@ -753,7 +753,7 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
 
 	kfd->dqm->ops.pre_reset(kfd->dqm);
 
-	kgd2kfd_suspend(kfd);
+	kgd2kfd_suspend(kfd, false);
 
 	kfd_signal_reset_event(kfd);
 	return 0;
@@ -787,21 +787,23 @@ bool kfd_is_locked(void)
 	return  (atomic_read(&kfd_locked) > 0);  }
 
-void kgd2kfd_suspend(struct kfd_dev *kfd)
+void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
[Oak] I think parameter run_pm is better to called: call_from_pm_runtime. Or you can add some comments to the parameter of this function to say when run_pm==true it is called from pm_runtime.

 {
 	if (!kfd->init_complete)
 		return;
 
-	/* For first KFD device suspend all the KFD processes */
-	if (atomic_inc_return(&kfd_locked) == 1)
-		kfd_suspend_all_processes();
+	/* for runtime suspend, skip locking kfd */
+	if (!run_pm) {
+		/* For first KFD device suspend all the KFD processes */
+		if (atomic_inc_return(&kfd_locked) == 1)
+			kfd_suspend_all_processes();
+	}
 
 	kfd->dqm->ops.stop(kfd->dqm);
-
 	kfd_iommu_suspend(kfd);
 }
 
-int kgd2kfd_resume(struct kfd_dev *kfd)
+int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 {
 	int ret, count;
 
@@ -812,10 +814,13 @@ int kgd2kfd_resume(struct kfd_dev *kfd)
 	if (ret)
 		return ret;
 
-	count = atomic_dec_return(&kfd_locked);
-	WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
-	if (count == 0)
-		ret = kfd_resume_all_processes();
+	/* for runtime resume, skip unlocking kfd */
+	if (!run_pm) {
+		count = atomic_dec_return(&kfd_locked);
+		WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
+		if (count == 0)
+			ret = kfd_resume_all_processes();
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index c0b0defc8f7a..20dd4747250d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -647,6 +647,7 @@ struct kfd_process_device {
 	 * function.
 	 */
 	bool already_dequeued;
+	bool runtime_inuse;
 
 	/* Is this process/pasid bound to this device? (amd_iommu_bind_pasid) */
 	enum kfd_pdd_bound bound;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 25b90f70aecd..6907a5a2cbc8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -31,6 +31,7 @@
 #include <linux/compat.h>
 #include <linux/mman.h>
 #include <linux/file.h>
+#include <linux/pm_runtime.h>
 #include "amdgpu_amdkfd.h"
 #include "amdgpu.h"
 
@@ -440,6 +441,16 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 		kfree(pdd->qpd.doorbell_bitmap);
 		idr_destroy(&pdd->alloc_idr);
 
+		/*
+		 * before destroying pdd, make sure to report availability
+		 * for auto suspend
+		 */
+		if (pdd->runtime_inuse) {
+			pm_runtime_mark_last_busy(pdd->dev->ddev->dev);
+			pm_runtime_put_autosuspend(pdd->dev->ddev->dev);
+			pdd->runtime_inuse = false;
+		}
+
 		kfree(pdd);
 	}
 }
@@ -754,6 +765,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
 	pdd->process = p;
 	pdd->bound = PDD_UNBOUND;
 	pdd->already_dequeued = false;
+	pdd->runtime_inuse = false;
 	list_add(&pdd->per_device_list, &p->per_device_data);
 
 	/* Init idr used for memory handle translation */ @@ -843,15 +855,40 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
 		return ERR_PTR(-ENOMEM);
 	}
 
+	/*
+	 * signal runtime-pm system to auto resume and prevent
+	 * further runtime suspend once device pdd is created until
+	 * pdd is destroyed.
+	 */
+	if (!pdd->runtime_inuse) {
+		err = pm_runtime_get_sync(dev->ddev->dev);
+		if (err < 0)
+			return ERR_PTR(err);
+	}
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
+	if (!err) {
+		/*
+		 * make sure that runtime_usage counter is incremented
+		 * just once per pdd
+		 */
+		if (!pdd->runtime_inuse)
+			pdd->runtime_inuse = true;
+
+		return pdd;
+	}
+out:
+	/* balance runpm reference count and exit with error */
+	pm_runtime_mark_last_busy(dev->ddev->dev);
+	pm_runtime_put_autosuspend(dev->ddev->dev);
+	return ERR_PTR(err);
 }
 
 struct kfd_process_device *kfd_get_first_process_device_data(
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Coak.zeng%40amd.com%7C922e0392f4b949e4b6ae08d7a6c813a4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637161250615739404&amp;sdata=nb9Lmc5sGR3C5zXDSAjib28tnxP%2F%2FTAljdO3%2BIgHB78%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
