Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F585CAC5A7
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 10:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E65B10E272;
	Thu, 25 Sep 2025 10:33:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TMLX//Fd";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011011.outbound.protection.outlook.com
 [40.93.194.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 282AF10E29E
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 10:33:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJzCLD9YsbfBE0wgiEkNbyw3dcihYNul4bXWjPXK8pgn1qZx4qNowTze3AW4D8FNT+sTFJ4I8wKaTujV4s85b6tmryw5iar/3nldy4ls8JtEGiOSuPfbwJiRbhu6D75b85+zlRjNyH7WanbmRpiy896XjsuEgEPLRqUUeHSNgr/8KR20pX/7C83vbDKq9dS51Vick54xv8bMbocTVek6dC0w3jiALiU9gzXqFTcZDNC9W4+rY5hJTM4tkkztqbhJNxmNt3fTiF+kD+8C1wzGkeNIjLZCnwS8ETsYOrgYKOMOd7QDNz11cIdtIC0hsvjDerxmtiCLoiykdkI5+S8wPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IV3DHymtYm2LGqJqMVC0BGFpBucyn5kBNYnADcnWHCI=;
 b=EActRj8c9BJmxcrcxEYfgGt/2z5+v7WGpi36d/pKErIk+1FhCOQbXe/omku/MGETM7NqkaRzJc032IhR5jLjjbGwVzPF0/85lyaD1aisVcb52pIzlYafrVOX185vDP8g4FkjSlAUyIf03uoROSjd7fh8Ilv9Rv9163tnEJRQU9j49fDXsxf5JQQ9MhB+qMqds+W6s7vl2IA02WbgeafQtcLwkNJh4OOZxKvBAO9LgbzFi0XLYZCA3Va78f/ZM3QSTNLb6zUaPyb/eZgAHwBfMEQsHtDGnf6YNKFt1BQHreLxLMWG8lekrc+B+Db/dn5HqrYfCnY8bTPNEh4ixYERKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IV3DHymtYm2LGqJqMVC0BGFpBucyn5kBNYnADcnWHCI=;
 b=TMLX//FdIZ52zU61pd6s5ybEKOaVaIG7bUF1VGM7C/ujMLL5rnD4waUqOPdy9ILssH+xIMQx/eZtFPilUz9igtpcJfuDoe10kuP7CQXGgYm5N1uICEFVlDJW/D/B+bwYR60FFRYElg8XHmRnfqLUJ/HJwF58DmXDGdn96yr8Vpo=
Received: from MN2PR05CA0049.namprd05.prod.outlook.com (2603:10b6:208:236::18)
 by DS7PR12MB9528.namprd12.prod.outlook.com (2603:10b6:8:252::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 10:33:08 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::25) by MN2PR05CA0049.outlook.office365.com
 (2603:10b6:208:236::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.4 via Frontend Transport; Thu,
 25 Sep 2025 10:33:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 10:33:07 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 03:33:07 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 03:33:06 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 25 Sep 2025 03:33:05 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Merge amdgpu_vm_set_pasid into amdgpu_vm_init
Date: Thu, 25 Sep 2025 18:32:25 +0800
Message-ID: <20250925103305.2897509-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|DS7PR12MB9528:EE_
X-MS-Office365-Filtering-Correlation-Id: f33f671a-96be-4721-bf01-08ddfc1eeaf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1NVc0tkQkpUSE0zSURMSEVveGxENklIYk91a055ZXRJUUVnZGJiNEZFNDBE?=
 =?utf-8?B?b3kvYjBkdnFzMnZvaXJ3TGVmd3ZPQUZBZFI5SDViNEVDZUVZM1BzMHpmNU9K?=
 =?utf-8?B?emdIanp2Q2piTjJycEF6T3JMU2tnSlB5L2FzV3NkcDNUZEVwdGZFUTVsenNQ?=
 =?utf-8?B?MmNHNU9VZy9wTEtlcjhKY045a0FJRS9Gd0k1YktXSHFvSmhVaHIzeWJpRmJo?=
 =?utf-8?B?WWdpcEZ1K1Y5V0VaS2MxWUNGZGFzYVVtNXhNOEZKSUR1TlcwV3JySmxkM0FR?=
 =?utf-8?B?cFFFeFF5V0FJaFNoWlZHSG9JOCtVVjNkamkyT2RFZnZyY293eitPaEZKdno4?=
 =?utf-8?B?NDJ5cGxFajZvcnlNdUd5ZStJSUxoM2dKb2dkNFlBTkRxV0htbkk4bHprUzdW?=
 =?utf-8?B?WGdmNkJwZXFiTFhvRnpoV2t6YkhIbGxvYklzczFHRTN3WUljbTVhdGFGUlZR?=
 =?utf-8?B?RGFxOUVraHVkTFp6dFFTeHVkS0toVzlTWDR3cEYxQ1poL21MSWRJbGloZU9p?=
 =?utf-8?B?a3MrczJoNHNFbEkybGY2eFQ4cmE5eTE0WCsvNE5vWW8yVXVYU0NFclJIUmZi?=
 =?utf-8?B?WFZPYi9VUE9JS2h5ZGwyc3R5NmtVcUlNRVdyM01PeDgwYjNndkt4dTZacFIz?=
 =?utf-8?B?UFNKWFgxcFlXai94bVVNWG9uQkpIV3BqMjdIZ2d2Y2lTaTgySHFSblFIdVBT?=
 =?utf-8?B?UStva0VPYWJHeEpSczRIRkdLUG42ejZBb2x5ZjFrRWpkcmJXbW01d2JrcGps?=
 =?utf-8?B?a0l5VHBLYkk5UnprY050QTlrRzJzTGR4TklyTVE2Ynh2cGJ4NC9lYVYzMEhI?=
 =?utf-8?B?RlNVMUt1SE9MNy9YVDdyYXc2eFY4d2RMdzlYSTlmTEwvMjYzVzF6R1ZzSm1Z?=
 =?utf-8?B?dS8veitpNGpNdnpqWks3TjUzQVhVMHJhVVdVNUE2ekJmcjdYbEJWVjF2YnpG?=
 =?utf-8?B?VHkzb2hxV0VLNmRJYm1tR0xNL25UOU4xdStUenR0MlFnNFpSUzVPbGVqTXZV?=
 =?utf-8?B?czYwN3Q2YThndlhrMkpzWERlYjFHeGNZQXVPOHZ6c01lSmg2QXhYUFc0Myth?=
 =?utf-8?B?S2JqNFJac1VhZU5TR1hjbXVUMzhrcVpUZ2s4OGw3UjVPZ29JNzY1Und3TVJW?=
 =?utf-8?B?VGVCVko2UUdVb0xGeHQ4ckFoWWl1VStLYnJsSDQvblZDaTg1M3pjZXc0dHNs?=
 =?utf-8?B?MHR2L21RMXNHSW1HeCtRcXNieXZIU3F5SHMybnJtOEh6d0RjYjExODhEYThG?=
 =?utf-8?B?QlhzN0IvQlJYeTA1eWgzbkJnRUlOTVFHV2x1NFI5eTJkQU8wOEFvTjQ5cGdm?=
 =?utf-8?B?OE1FT0JKaU5jQ3JmaitLZUFZaGtzdnV2RnBSQ1lFV0pTYkdDanQ3dWlYTVU3?=
 =?utf-8?B?Qkk5OVlyNlZ2eC8yTExwamNHc0s1RFVpUnVNOVkzZXk5a1N3MXlkSGF1dlpT?=
 =?utf-8?B?UU1FOVU1NWlSSUVVcUViYmNSQmFacjZMNWhkV21CWEpqeFRvODJMSDRFQWdH?=
 =?utf-8?B?Z2w4eEdhSGtFYlRnSnpHaUtid2t4dmFVTDBueC81ZmIxQjR0YlpqNHJHTHFz?=
 =?utf-8?B?cDIwRUQxbVMvbGpxT012M2EvN0l3MzFDN1lsdmJ6c2Rlb1o0SlRVUy8waTVR?=
 =?utf-8?B?aXI4ZkI0eFl6VC93bzZZRFVDN2ZFeGVNVU85Lzg5Q1c3Z1dQU3pldlZTdTI3?=
 =?utf-8?B?ZlZ0Q1NWbCtkQnhSbno4ZlhTWVVKTUQ2N3hlNW82bUxqVFZzb2swMEVhZFZm?=
 =?utf-8?B?WE5EVGp0V2E4c2QxdHJVbmcrT1RPV01jemRNVDNYUnpDTEFiUVNRTlZwaVFB?=
 =?utf-8?B?N2JZdjYvbUVBOGJTSkswSkVXZlhqVjhOSjMvZk1QNm5WeDE1YWdBdFRsL0VS?=
 =?utf-8?B?VjUrVUVTUHhKdEJNUWduS3d6NlpBbk1yRkZnNjhEYVVHSCtUT0Y1TmVOVWo3?=
 =?utf-8?B?WG1nbUdmSGJwZmdCRGphODltSnhUSXRicUExdjJNbzV0M1FYRTl2ZzFmNXVC?=
 =?utf-8?B?T1orcEloRnAyQUdBaXZjVVNEOWhVS1hock1hYytyNzVydFI2Tk5qYkUxUHFN?=
 =?utf-8?Q?EgsHPo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 10:33:07.7306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f33f671a-96be-4721-bf01-08ddfc1eeaf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9528
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As KFD no longer uses a separate PASID, the global amdgpu_vm_set_pasid()function is no longer necessary.
Merge its functionality directly intoamdgpu_vm_init() to simplify code flow and eliminate redundant locking.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 10 ++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 30 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  5 +----
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 8676400834fc..a9327472c651 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1421,14 +1421,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	amdgpu_debugfs_vm_init(file_priv);
 
-	r = amdgpu_vm_init(adev, &fpriv->vm, fpriv->xcp_id);
+	r = amdgpu_vm_init(adev, &fpriv->vm, fpriv->xcp_id, pasid);
 	if (r)
 		goto error_pasid;
 
-	r = amdgpu_vm_set_pasid(adev, &fpriv->vm, pasid);
-	if (r)
-		goto error_vm;
-
 	fpriv->prt_va = amdgpu_vm_bo_add(adev, &fpriv->vm, NULL);
 	if (!fpriv->prt_va) {
 		r = -ENOMEM;
@@ -1468,10 +1464,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	amdgpu_vm_fini(adev, &fpriv->vm);
 
 error_pasid:
-	if (pasid) {
+	if (pasid)
 		amdgpu_pasid_free(pasid);
-		amdgpu_vm_set_pasid(adev, &fpriv->vm, 0);
-	}
 
 	kfree(fpriv);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 108d2a838ef0..6a4902c972cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -149,7 +149,7 @@ static void amdgpu_vm_assert_locked(struct amdgpu_vm *vm)
  * pasid by passing in zero.
  *
  */
-int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+static int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			u32 pasid)
 {
 	int r;
@@ -2552,6 +2552,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
  * @adev: amdgpu_device pointer
  * @vm: requested vm
  * @xcp_id: GPU partition selection id
+ * @pasid: the pasid the VM is using on this GPU
  *
  * Init @vm fields.
  *
@@ -2559,7 +2560,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
  * 0 for success, error for failure.
  */
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		   int32_t xcp_id)
+		   int32_t xcp_id, uint32_t pasid)
 {
 	struct amdgpu_bo *root_bo;
 	struct amdgpu_bo_vm *root;
@@ -2636,12 +2637,37 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		dev_dbg(adev->dev, "Failed to create task info for VM\n");
 
+	if (vm->pasid != pasid) {
+		/* Erase old PASID from XArray (if non-zero) */
+		if (vm->pasid != 0) {
+			r = xa_err(xa_erase_irq(&adev->vm_manager.pasids, vm->pasid));
+			if (r < 0)
+				goto error_free_root;
+
+			vm->pasid = 0;
+		}
+
+		/* Store new PASID in XArray (if non-zero) */
+		if (pasid != 0) {
+			r = xa_err(xa_store_irq(&adev->vm_manager.pasids, pasid, vm, GFP_KERNEL));
+			if (r < 0)
+				goto error_free_root;
+
+			vm->pasid = pasid;
+		}
+	}
+
 	amdgpu_bo_unreserve(vm->root.bo);
 	amdgpu_bo_unref(&root_bo);
 
 	return 0;
 
 error_free_root:
+	/* If PASID was partially set, erase it from XArray before failing */
+	if (vm->pasid != 0) {
+		xa_erase_irq(&adev->vm_manager.pasids, vm->pasid);
+		vm->pasid = 0;
+	}
 	amdgpu_vm_pt_free_root(adev, vm);
 	amdgpu_bo_unreserve(vm->root.bo);
 	amdgpu_bo_unref(&root_bo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 3b9d583358b0..556d0483c6bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -503,11 +503,8 @@ extern const struct amdgpu_vm_update_funcs amdgpu_vm_sdma_funcs;
 void amdgpu_vm_manager_init(struct amdgpu_device *adev);
 void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
 
-int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			u32 pasid);
-
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
-int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id);
+int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id, uint32_t pasid);
 int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
-- 
2.49.0

