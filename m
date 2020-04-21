Return-Path: <SRS0=PX0W=6F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A020C2BA19
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 05:24:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D41C2076C
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 05:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uMkzQEw0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D41C2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD4846E887;
	Tue, 21 Apr 2020 05:24:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A01026E887
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 05:24:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9KVx/gH75+tykJm61PB6ofWRBVMGUtWWobm86f5UdEZduc54XLeKV4uIs1kUrbPkndvpO7bHPwtqfoQMx36MwIdJh4b82QYuDIxT1Jz3AWC4P3CzPaA5WkE0YCrdC3FEhxsqeomJesj+E9uVyk2a9dbpqFct6fgXr7t6rpIAkO6y2hurdt22IArbKMH2CjaoC09gWQBqXH/xGsxOCZPc3dvX/qUJ47T9HPyXJmHHfmO14mJ+Hs6bdS5gelUg/P/QyvXuAqPt3CNriufnUIcO+jFvGA+U3IbWKGBlIFfiY/Q2aAhOhvAcc49A+We1GxdIIkTP07DfD6Chce/751rcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkYEfGHKqLXVtzEprDe+H37oCX3eagtWK1b+Z+seFpI=;
 b=jeFNrBPyWN82jTBw6ocLqLXc8l0ZHkC4/L5hMdkWLanx27aQaHUD13W0XR4ttgN3htwsmJ8a3KyMC1PjkgrZU9KYli0e74JshY2rci9D8V8Dg0gkVNuLd3S2o4NkSV/bkXCOpMVxGQkANKZJJBj82dZdB0la48xJXYcPwloBZvFN3Io+ApU6VvF1D0vvB2x9odrG26lu5iayLLnNH+CarEKyUJN9qgHnYXl/GYkUEyHqKptWiRc/zJAn+vfZeabUXrjM6G36UBagtyKa1tXzSZk3beaBj8ZP1AL2Sv2LqK8z1rgUO36H7kNSpfnwCDWWz5Q1pbYhN/nJaN2M7xM8LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkYEfGHKqLXVtzEprDe+H37oCX3eagtWK1b+Z+seFpI=;
 b=uMkzQEw0tAdtr5yKy2g0oAID2h0s0J6SS6rVN720t87g+JIxSxE4Dt3kkH+gs8dg8JUWy1kX0FdcyS0aoG0xoE100bO9bTwEs0F0aW/BGyN5hosTODc/LnB6oGA+16fYzKNsIUj4ac4UjeT2ntyyWMVEWdE/fcUDHUloiZW87RI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3164.namprd12.prod.outlook.com (2603:10b6:5:188::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.29; Tue, 21 Apr 2020 05:24:45 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 05:24:45 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: optimize the gpu reset for XGMI setup V2
Date: Tue, 21 Apr 2020 13:23:41 +0800
Message-Id: <20200421052342.23037-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200421052342.23037-1-evan.quan@amd.com>
References: <20200421052342.23037-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR0302CA0006.apcprd03.prod.outlook.com
 (2603:1096:202::16) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR0302CA0006.apcprd03.prod.outlook.com (2603:1096:202::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.6 via Frontend Transport; Tue, 21 Apr 2020 05:24:43 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8472756f-6a97-4192-49ad-08d7e5b44d73
X-MS-TrafficTypeDiagnostic: DM6PR12MB3164:|DM6PR12MB3164:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3164E52BFAD4612E5CEAE888E4D50@DM6PR12MB3164.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(2906002)(2616005)(956004)(44832011)(6916009)(36756003)(8936002)(81156014)(8676002)(86362001)(7696005)(16526019)(5660300002)(186003)(26005)(316002)(4326008)(478600001)(66476007)(66556008)(52116002)(1076003)(66946007);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hJx/PYVzuJ9fbZXWV+G6kn+vi14vIBn4UWUyKmAVt4QBq+HFHD48IcYpxKpp64nKRv6fZs6RW4MY1i4l4A1ctAnQpiNiewZyMgVQXsOtdNYxsfrUr/U9EPmgqQopcqDJavrBqCC4oOwcKnyZeWLLFwC6FZbQXRU5oNjo0gup4baXyiJTy1cxgaMcgYiBEVbMweGdDsxvQf4IL4geF04QtnvqT97qX+0tdev9dcFwsGbLGqkAUEtYyWgjAgN15k2rrlP9Tx6yQgrb6JOIiq092WLUOpy7tkz2bH0M8wFIT6vyO01QUC1WkE/wy2h1DA+m35EfBBtFemAlPjKnuleZnx8VUvz9hPKA9NUHO89LQwb/0JJWHvDJUh70GlAyKY5WoqUqu8x4ESix/BDELcVcxJ8scuJOJPvW3/JURUyq/1l3tY1f44uKtx67fFrHwAX1
X-MS-Exchange-AntiSpam-MessageData: BjXdInSvfXnPorjF+tkeajFXzq/bwFOx+i04t0lZSnQkpKU1f7TCSdXijNep1szcj/5KvyX1hjsHDYPf9OEpsJPFL28CyMxR0QpJ0ho+MrcYwO3FsMTrbpEpfKtdBE6kDYG+WzCBPKXIDmHASGWGEQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8472756f-6a97-4192-49ad-08d7e5b44d73
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 05:24:45.5627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIpJfWZqGlayEuwuIlXs8KT6RyIUowe+RmHf5jCGq0zE4tnQ4NaOXjKdwgMq3/t7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3164
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
Cc: Alexander.Deucher@amd.com, Andrey.Grodzovsky@amd.com, Jonathan.Kim@amd.com,
 Evan Quan <evan.quan@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is basically just some code cosmetic. The current design
for XGMI setup gput reset is to operate on current device(adev)
first and then on other devices from the hive(by another 'for' loop).
But actually we can do some sort to the device list(to put current
device 1st position) and handle all the devices in a single 'for'
loop.

V2: added missing hive->hive_lock protection

Change-Id: I84dca425f1ae778c4b4b8bc3a0d2b9a3d1b50043
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 76 +++++++---------------
 1 file changed, 25 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c8fe867d6ee3..b415c1e5ea0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4182,16 +4182,11 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	}
 
 	need_full_reset = job_signaled = false;
-	INIT_LIST_HEAD(&device_list);
-
-	amdgpu_ras_set_error_query_ready(adev, false);
 
 	dev_info(adev->dev, "GPU %s begin!\n",
 		(in_ras_intr && !use_baco) ? "jobs stop":"reset");
 
-	cancel_delayed_work_sync(&adev->delayed_init_work);
-
-	hive = amdgpu_get_xgmi_hive(adev, false);
+	hive = amdgpu_get_xgmi_hive(adev, true);
 
 	/*
 	 * Here we trylock to avoid chain of resets executing from
@@ -4204,35 +4199,21 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	if (hive && !mutex_trylock(&hive->reset_lock)) {
 		DRM_INFO("Bailing on TDR for s_job:%llx, hive: %llx as another already in progress",
 			  job ? job->base.id : -1, hive->hive_id);
+		mutex_unlock(&hive->hive_lock);
 		return 0;
 	}
 
-	/* Start with adev pre asic reset first for soft reset check.*/
-	if (!amdgpu_device_lock_adev(adev, !hive)) {
-		DRM_INFO("Bailing on TDR for s_job:%llx, as another already in progress",
-			  job ? job->base.id : -1);
-		return 0;
-	}
-
-	/* Block kfd: SRIOV would do it separately */
-	if (!amdgpu_sriov_vf(adev))
-                amdgpu_amdkfd_pre_reset(adev);
-
-	/* Build list of devices to reset */
-	if  (adev->gmc.xgmi.num_physical_nodes > 1) {
-		if (!hive) {
-			/*unlock kfd: SRIOV would do it separately */
-			if (!amdgpu_sriov_vf(adev))
-		                amdgpu_amdkfd_post_reset(adev);
-			amdgpu_device_unlock_adev(adev);
+	/*
+	 * Build list of devices to reset.
+	 * In case we are in XGMI hive mode, resort the device list
+	 * to put adev in the 1st position.
+	 */
+	INIT_LIST_HEAD(&device_list);
+	if (adev->gmc.xgmi.num_physical_nodes > 1) {
+		if (!hive)
 			return -ENODEV;
-		}
-
-		/*
-		 * In case we are in XGMI hive mode device reset is done for all the
-		 * nodes in the hive to retrain all XGMI links and hence the reset
-		 * sequence is executed in loop on all nodes.
-		 */
+		if (!list_is_first(&adev->gmc.xgmi.head, &hive->device_list))
+			list_rotate_to_front(&adev->gmc.xgmi.head, &hive->device_list);
 		device_list_handle = &hive->device_list;
 	} else {
 		list_add_tail(&adev->gmc.xgmi.head, &device_list);
@@ -4241,15 +4222,20 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 	/* block all schedulers and reset given job's ring */
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
-		if (tmp_adev != adev) {
-			amdgpu_ras_set_error_query_ready(tmp_adev, false);
-			amdgpu_device_lock_adev(tmp_adev, false);
-			if (!amdgpu_sriov_vf(tmp_adev))
-			                amdgpu_amdkfd_pre_reset(tmp_adev);
+		if (!amdgpu_device_lock_adev(tmp_adev, !hive)) {
+			DRM_INFO("Bailing on TDR for s_job:%llx, as another already in progress",
+				  job ? job->base.id : -1);
+			mutex_unlock(&hive->hive_lock);
+			return 0;
 		}
 
+		amdgpu_ras_set_error_query_ready(tmp_adev, false);
+
 		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
 
+		if (!amdgpu_sriov_vf(tmp_adev))
+			amdgpu_amdkfd_pre_reset(tmp_adev);
+
 		/*
 		 * Mark these ASICs to be reseted as untracked first
 		 * And add them back after reset completed
@@ -4295,22 +4281,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		goto skip_hw_reset;
 	}
 
-
-	/* Guilty job will be freed after this*/
-	r = amdgpu_device_pre_asic_reset(adev, job, &need_full_reset);
-	if (r) {
-		/*TODO Should we stop ?*/
-		DRM_ERROR("GPU pre asic reset failed with err, %d for drm dev, %s ",
-			  r, adev->ddev->unique);
-		adev->asic_reset_res = r;
-	}
-
 retry:	/* Rest of adevs pre asic reset from XGMI hive. */
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
-
-		if (tmp_adev == adev)
-			continue;
-
 		r = amdgpu_device_pre_asic_reset(tmp_adev,
 						 NULL,
 						 &need_full_reset);
@@ -4375,8 +4347,10 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		amdgpu_device_unlock_adev(tmp_adev);
 	}
 
-	if (hive)
+	if (hive) {
 		mutex_unlock(&hive->reset_lock);
+		mutex_unlock(&hive->hive_lock);
+	}
 
 	if (r)
 		dev_info(adev->dev, "GPU reset end with ret = %d\n", r);
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
