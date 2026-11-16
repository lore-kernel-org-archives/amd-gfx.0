Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C69E606A332
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 20:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vTI0ClFU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BFDB10F455;
	Mon, 16 Nov 2026 20:41:40 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010052.outbound.protection.outlook.com
 [52.101.193.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03DB410F474
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 20:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1wCwDsEtbrrFw1oJKWv+iTgcM5MBFvDeuTrrnRg8X2APdYjT9Ayq9SeaRJ9/HTNtXCpYfls/ian/JnvxawUc/H2UyhlmnpB7CzQx8lZ8bH0jVi51+U3mCrySUPscRPN13Oy3xwXB0T9ruJD90onnNM2Kl5medrBwgFn/UHN0qLzYSVrWuLlaZDuSx5p7nglQ3aUFcA5/lGgGVh6ueFbQyJBKMKqaLjcCembyl/9Zc/JvjYAmwAgebNdMzxc7UOH+aO7ax+z7Kaf8VGTMT5ZCQ+WchOHCTv0q1Fi/kSOl5mePMNzgLeBhRTXc/upJwDTx3ej+eoYX3G8laqkfWUCNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prb0+AGi8CNCBUEgXAHnn3m6+t2wtXCMX1Nr2QgPmdw=;
 b=Wcwt633RHHJ0YDLOPnL3Z/Ma6zCFlXBsV5vy7ErG8gKAqjr2eJ87XsiOOpPzeaGfIRa5pmib9QmryvQ/REjiRycmMlfZ0cfX9SUDCRrcOJZoSkN/eoqUNXbE6diYUBS8Ti7d6xq7cmtIo4qCa0ZGGGcmYcqfw0xEXx9Yc+TAL69YnxnPaN2N/kXe/OxLO3GsNJopGxoYPiS/FPt3eso57wkzO4bO/TZh6bDd8D03A2cdPGngTzmvQU24mLhSPSOFbh8DJSwG3d6kaNtweNrb1WvYNGF1ADpukI9TpuoktILSA+hIn85V5pTA8V2XB9jGPnreGyKqvoA13nyeNRPLAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prb0+AGi8CNCBUEgXAHnn3m6+t2wtXCMX1Nr2QgPmdw=;
 b=vTI0ClFUu3gjqSXqNPub3Nfy8n4hCkdiD+zQtW3tBG/c4nXpaVMRzXqCocPSo8DIQUha5SgD5R3mbCJ4hHZuGNRyliD+e1v97D1Tt9fScuB/3N4rrfFAW2d1jtipdtYimkUnl3OLW9tumxkoqNDe7tDuSfFV8IJQMBoIWTQEC0w=
Received: from MW4PR03CA0024.namprd03.prod.outlook.com (2603:10b6:303:8f::29)
 by DS0PR12MB503760.namprd12.prod.outlook.com (2603:10b6:8:4ec::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 20:40:30 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:303:8f:cafe::31) by MW4PR03CA0024.outlook.office365.com
 (2603:10b6:303:8f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 20:40:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 20:40:29 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 14:40:28 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Mon, 16 Nov 2026 14:40:22 -0600
Subject: [PATCH] drm/amdgpu: drain queued scheduler jobs before suspend
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261116-superm1-drain-submissions-v1-1-e3ffee977a28@amd.com>
X-B4-Tracking: v=1; b=H4sIADVq+2oC/yXM0QrCMAyF4VcZuV7BbGWiryK7aNeoEVpHoiKUv
 ftSvfzgnL+CkjApnLsKQh9WfhYD9h0s91Bu5DiZYTgMEyJOTt8rSUaXJHAxxczaTurwmLxHH+I
 YT2D/VejK31/7Mv9t8wctrxaEbdsBCfRf630AAAA=
X-Change-ID: 20261116-superm1-drain-submissions-17d4414ab3b9
To: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Logatharshan Thothiralingam
 <Logatharshan.Thothiralingam@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|DS0PR12MB503760:EE_
X-MS-Office365-Filtering-Correlation-Id: d2767cb6-8273-4423-d422-08df4421da77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|5023799004|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261022075727099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: o5foPiT877jjoGtWV/tzB/0UfFwZ6ShBDMQ7qYscgzshE+dVOI3+LeeHCQFAzZbR46PlF8U0OjluZLiWPgN24AjA3VWc+sdYiK0fwxkrcrzHprBCaFO8fmVDRGWWQxX9lYZneV7Z4pD/HPSRqIV1LI/Zl/f7ZwmdUCCSfCu4FxBy+fhjLYBI4ACAk/CGgofAKtNaBsIZzWz3EMZPoQ4o2trqjgbIOuE0fy+CzVVeHUrf2tPrysEY+c5xbboS3RicvYI78YSFX0o4CZN/UEgnOsr5CK9rvByF9sqsxvRNivrHdmRjl6vCJQbw0fuNuBeTkEiiC9nRIa/UJ0P/OHNP/6I5ISyT9nW1XTm/roroNfGheR71JEufI+ak+znJRGyyY51jRpRj6o853o+nZoXfLq85EysCBcgpNWoMW4AVLTwPsy48pg/8Eyb1Sb347Rhw6xFZFxameRl10LbV/JOXTy7zpPZkTqBlcnNtZXbAX9TDxL1dux1OH9v/GCRnp8hzZXvTIDQeRpLlGCCjwll6RAVpSK0JhBk/W9vTx2EmnQqlLSi6TQluX52nj20fjw3wG7PvAr/BxhpvMDQClxs2p29b1qbIDZw64tiVsI1zamyMY/SVajocU6ZGO7/VO9cxkfF5bE7MlLU55hXS/pqYUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(5023799004)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qJ+VCAQlYEkttkpjonPufZfgUr7c5leYdu2DzKUU1DJBRfeaZbWjGb2866KvqqcvtGAgPuj3AT22dgmnCNFQGaxqOWb7UuW0D+X7cLacuWm6GviN5Z1IInJXBtJpDMWvngtm04L66sC3TmKHYSQreZzBCf7UU+U+L7J0gAtjrkgI2k13HsWsjf66nKDnGYrQi4iakHnYEVm2DVP5+i3Qzr3Vij9piBNlvlOjL2YGGRJgsK1FRXi//gz6HU3XFv2qsw/DnQBczu/nS1nfMaQm11+kVbayHAQJALDpkD0X0wpkWxmxONUaJDviiZ/3MoFKnKabkIYe0Fd88IS7QUHMKfnIACLvYX8c5pUxBjNODS+AYCwfEUmcLvPKIiHMuD+eDj/7VOUScWtUFo5IW4Mul7N6ju7S2+7BXp5Z+U/G60d7NWRqyeamWdj+TIrKgcP5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 20:40:29.8463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2767cb6-8273-4423-d422-08df4421da77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB503760
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

At suspend, amdgpu_fence_driver_hw_fini() only waits for the last fence
emitted to each ring. Jobs still queued in a scheduler entity have not
reached run_job() yet and so have no hardware fence. Userspace is frozen
at this point, but such jobs can become runnable later, for example once
a dependency signals, and the scheduler then pushes them into the ring
after the hardware wait has finished and before the IP blocks are torn
down. On resume the ring write pointer is reset, those jobs never
signal and the GFX ring times out and hangs.

This was observed as a rare (about 2 in 400 cycles) GFX hang on S3 resume
on Picasso.

Flush the context and VM scheduler entities of every open file
before evicting resources, mirroring what amdgpu_flush() does on file
close. Like for any other dma_fence there is no timeout, the wait is
not bounded.

Reported-by: Logatharshan Thothiralingam <Logatharshan.Thothiralingam@amd.com>
Closes: https://lore.kernel.org/amd-gfx/SA1SPRMB0073292C113C6B98D9282092F87F2@SA1SPRMB0073.namprd12.prod.outlook.com/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 19a566187dfb5..d18348116d3f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4538,6 +4538,30 @@ void amdgpu_device_complete(struct drm_device *dev)
 	}
 }
 
+/**
+ * amdgpu_device_flush_file_entities - drain scheduler entities of open files
+ * @adev: amdgpu device object
+ *
+ * Wait for the scheduler entities owned by all open files (the context
+ * entities used for command submission and the VM entities used for page
+ * table updates) to run out of queued jobs, so that nothing can slip into
+ * the rings after the hardware fences were waited on at suspend time.
+ */
+static void amdgpu_device_flush_file_entities(struct amdgpu_device *adev)
+{
+	struct drm_device *ddev = adev_to_drm(adev);
+	struct drm_file *file;
+
+	guard(mutex)(&ddev->filelist_mutex);
+	list_for_each_entry(file, &ddev->filelist, lhead) {
+		struct amdgpu_fpriv *fpriv = file->driver_priv;
+
+		amdgpu_ctx_mgr_entity_flush(&fpriv->ctx_mgr,
+					    MAX_SCHEDULE_TIMEOUT);
+		amdgpu_vm_wait_idle(&fpriv->vm, MAX_SCHEDULE_TIMEOUT);
+	}
+}
+
 /**
  * amdgpu_device_suspend - initiate device suspend
  *
@@ -4587,6 +4611,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	if (r)
 		goto unwind_ip_phase1;
 
+	amdgpu_device_flush_file_entities(adev);
+
 	r = amdgpu_device_evict_resources(adev);
 	if (r)
 		goto unwind_userq;

---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261116-superm1-drain-submissions-17d4414ab3b9

Best regards,
--  
Mario Limonciello <mario.limonciello@amd.com>

