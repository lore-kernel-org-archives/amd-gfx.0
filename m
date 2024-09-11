Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07689EE0211
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 07:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A1C110E9EA;
	Wed, 11 Sep 2024 07:06:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qJKkZwxk";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ADA210E9EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 07:06:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1OEaccqBzSHZKhZD8sWzZSehvWpgv86rGGbiESXZOAdMURD4/P4OCKVjchdqakl+rkWjVXNFFB8VOZM1OuYvW1HZuPvPAxdNU+WVv+zJxo2hdsey93DPLbiycXCSdP/0VXbEsa7ijeQPoeBDxrTfkxd60nxfQSoYd7PMm7/RAMMY68WDrN6aHqzq5XZ+0C3Y+UyHDPjdsoo9DUfr4wO6kymVS2C46HBi77KarvKpY3ECdQphR707L8uJild5Hd3+oG2VtaPOlNwU06RHV/R9KQRAZuHs8Q7mJVMY+1l7PrbjIPGJMDwY9XL8M81IyTUzrtap4ZTV5I6L2jhJzbNQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6epMwPCskK29/nDG9DJj5BtwcOVxEvLHmPkdY/kqYo8=;
 b=Z+Gs+XuzWM4HkrviZvfq+VOsdyLP7++WIoC5ir0tpgaNTf/a7ZII6q1Lbmd5TdDF2NVD9/xmKLzRwDbfPFUXp7wsEbT56BOvLLyGWikTPMR0A56cjC0/B7PH2+AtBOYO4fSsJopJcnnkSUiFcAV42t9u4QyK2xoe2byB4nRaXOB6Ccu1LZSnlrQY+2FztKQ8lETdHeHU/ZQ3pZLuxpcw4UP1vmoB/Q3jNDyHZrsocoKwaCWU0HgKTirEPCbQlcJtEA7/W9Sygzn5RQP2hQgm7etMO4i9OzT5brVEJjA3E5Pp5hJNFIAT4TgO6xMLs73fejDUuhSlS0FekXcmXtWu8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6epMwPCskK29/nDG9DJj5BtwcOVxEvLHmPkdY/kqYo8=;
 b=qJKkZwxkWmirb8nXZFyVWT5J7ywpce+qQL8TIJmhMBtDmEWkFy4wVXYVEHhj/ETy4VvpDIWbJv7Ulgtn0LTHsz+uf5jhsN14nfX+yPuGRy5KFcBw4Op9knzr4G2wVgrOjswQ5d6QmSyVFszvpa48hKh9dvOYg6JhNz31NpskRhc=
Received: from SJ0PR03CA0071.namprd03.prod.outlook.com (2603:10b6:a03:331::16)
 by CY5PR12MB6431.namprd12.prod.outlook.com (2603:10b6:930:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 07:06:11 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::77) by SJ0PR03CA0071.outlook.office365.com
 (2603:10b6:a03:331::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 07:06:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 07:06:10 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 02:02:25 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <feifxu@amd.com>, <rajneesh.bhardwaj@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v2 03/10] drm/amdgpu: Separate reinitialization after reset
Date: Wed, 11 Sep 2024 12:28:51 +0530
Message-ID: <20240911065858.2224424-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240911065858.2224424-1-lijo.lazar@amd.com>
References: <20240911065858.2224424-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|CY5PR12MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: ed47aefa-5351-4e55-113e-08dcd2303743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TEvFn7TZG52/9W9VHx1g57KqdGXXYSsH6BViIriQ4IOKBIyXJNxMvmIYy797?=
 =?us-ascii?Q?EhzRXibATG2jP0r8W412YRQDyP4ild8u4kcLTOylMVIdaxiS6M1CId7d8QuL?=
 =?us-ascii?Q?zP9pnozUilWm5SIefTKyAoU1LoIINjnQHr7kV8UdqOtJbjae63ASjqe6jFB+?=
 =?us-ascii?Q?u36UNxkMhtjdYXU2IAlHUn0Lk4YiK9UzzVATz240EqciWB9sFet7z7HhhVE3?=
 =?us-ascii?Q?PTWg7FhhIFl6QGsRNxophfDo+bJR9J/c+fcBQf0YNAwrHvXwNhIZ9LBrLGvt?=
 =?us-ascii?Q?Fma3rSZvK6k3UK/Az0DqW8wtmtt5HvursxmsAbjm6Rqj6PGUkZwGLIGzZ3p0?=
 =?us-ascii?Q?zEYtThZhI72wdP3Aymn0ODMLREEyzf09Bu1BYxgdskSnECCtbk4XnVmVj9nZ?=
 =?us-ascii?Q?W/5XoUSqo5d46f4W/lSytZfueyfPyB4U9KzU9uSDBRe5NgmrmCaMSUhMgBCF?=
 =?us-ascii?Q?vWNY7FJdsL4E5XL1BX71kx3YB4xLTqwMHqMJHEE5eiJy1TF5GE+OI7fVMnCm?=
 =?us-ascii?Q?QJg/EroqHhXAgYlyKyPsxR2R3GbbNK2O+q8VPwH2ebbjmi49mSjOJx9BvwJp?=
 =?us-ascii?Q?HzYhXM80i+CEiviOGSoNl1AuC29ZGuElDko1kGHw7FWnyO13KwS2s6OOG0lO?=
 =?us-ascii?Q?/Jb7ArFssdbzFRMSXZr8qRISffGTSq1llBxQ/r4g6bl9p0ZUKOWDeZ/yf5ox?=
 =?us-ascii?Q?e72hNqQu/dY3wQaK0CxRadE+h9KkQOWZ0B/y5JgRrEW8eYXkJGR7tjQH+7Dt?=
 =?us-ascii?Q?Mop3CPsZP93r9lRRFp/IXy8H451nsZSFYnMKL30xKXPBAHD8StmYjYgZMgid?=
 =?us-ascii?Q?GQOzPWJSJ6CGI7sBlBpJjWSJtqAMZVeWm31K0uCjNSjdwpqrw5pyJ2o2JEvl?=
 =?us-ascii?Q?6W9II4JGwu7r0qiDuBXyLa+RNDSMDP33Y6OJG++2Cxrzvw9nNGF+P3t7r5gJ?=
 =?us-ascii?Q?By4YyHaKI33/Rau+m1fIqdWQFA2Ytg5amIM2uiXYIrr1YanEHv0fB3+XcZ49?=
 =?us-ascii?Q?ONmIjBg4bJbmGA5+jHOQic8OwrpQf1t8jwNLBuq5ZzvoZbow9HSjdfcVsquN?=
 =?us-ascii?Q?2SEvCOG725pFP0+wALU51hbrDlx5uihFBJaImr/8oxXRROoh2cGVdIgrO47U?=
 =?us-ascii?Q?3VIFZbGZjNORt9NvbesQemFRM5xo7C+IAmkdfrKWaGv2CEGYfXc7OpUMi2fU?=
 =?us-ascii?Q?dGW13wnzGUU1BGlw1JVRteZg0j3pkazhohmUCdht5VOAn9MGTgIMDDQAwYeO?=
 =?us-ascii?Q?VcHuYeiHpBML7ONaiqNSZK5j6nBUESdqo1Q/wOWNGm7Hmr1ICcsx/C7QFqQZ?=
 =?us-ascii?Q?oXXs/0ePNnUEMTHV3WEmvbZIrvqCMq77XYJ/k+8CVUQA9nkJyRVKt18iXAVf?=
 =?us-ascii?Q?UI70Mc/hyqDR97SuzEE2TPSIrgWB7M1B0HtTZsI15zApUO/lSB5eoVl0elb4?=
 =?us-ascii?Q?I/6c9ng7ne06wvlWCq/Hn69Ic62SAG6f?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 07:06:10.5454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed47aefa-5351-4e55-113e-08dcd2303743
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6431
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

Move the reinitialization part after a reset to another function. No
functional changes.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 150 ++++++++++++---------
 2 files changed, 89 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d8299383af11..bb89d2ac7abc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1284,6 +1284,8 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 			 struct amdgpu_reset_context *reset_context);
 
+int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context);
+
 int emu_soc_asic_init(struct amdgpu_device *adev);
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ca5ef1d87035..0caab1a4ae8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5453,75 +5453,25 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	return r;
 }
 
-int amdgpu_do_asic_reset(struct list_head *device_list_handle,
-			 struct amdgpu_reset_context *reset_context)
+int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 {
-	struct amdgpu_device *tmp_adev = NULL;
-	bool need_full_reset, skip_hw_reset, vram_lost = false;
-	int r = 0;
-
-	/* Try reset handler method first */
-	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
-				    reset_list);
-
-	reset_context->reset_device_list = device_list_handle;
-	r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
-	/* If reset handler not implemented, continue; otherwise return */
-	if (r == -EOPNOTSUPP)
-		r = 0;
-	else
-		return r;
-
-	/* Reset handler not implemented, use the default method */
-	need_full_reset =
-		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
-	skip_hw_reset = test_bit(AMDGPU_SKIP_HW_RESET, &reset_context->flags);
-
-	/*
-	 * ASIC reset has to be done on all XGMI hive nodes ASAP
-	 * to allow proper links negotiation in FW (within 1 sec)
-	 */
-	if (!skip_hw_reset && need_full_reset) {
-		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
-			/* For XGMI run all resets in parallel to speed up the process */
-			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
-				if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
-					r = -EALREADY;
-			} else
-				r = amdgpu_asic_reset(tmp_adev);
-
-			if (r) {
-				dev_err(tmp_adev->dev, "ASIC reset failed with error, %d for drm dev, %s",
-					 r, adev_to_drm(tmp_adev)->unique);
-				goto out;
-			}
-		}
+	struct list_head *device_list_handle;
+	bool full_reset, vram_lost = false;
+	struct amdgpu_device *tmp_adev;
+	int r;
 
-		/* For XGMI wait for all resets to complete before proceed */
-		if (!r) {
-			list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
-				if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
-					flush_work(&tmp_adev->xgmi_reset_work);
-					r = tmp_adev->asic_reset_res;
-					if (r)
-						break;
-				}
-			}
-		}
-	}
+	device_list_handle = reset_context->reset_device_list;
 
-	if (!r && amdgpu_ras_intr_triggered()) {
-		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
-			amdgpu_ras_reset_error_count(tmp_adev, AMDGPU_RAS_BLOCK__MMHUB);
-		}
+	if (!device_list_handle)
+		return -EINVAL;
 
-		amdgpu_ras_intr_cleared();
-	}
+	full_reset = test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
 
+	r = 0;
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 		/* After reset, it's default init level */
 		amdgpu_set_init_level(tmp_adev, AMDGPU_INIT_LEVEL_DEFAULT);
-		if (need_full_reset) {
+		if (full_reset) {
 			/* post card */
 			amdgpu_ras_set_fed(tmp_adev, false);
 			r = amdgpu_device_asic_init(tmp_adev);
@@ -5611,7 +5561,6 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 			r = amdgpu_ib_ring_tests(tmp_adev);
 			if (r) {
 				dev_err(tmp_adev->dev, "ib ring test failed (%d).\n", r);
-				need_full_reset = true;
 				r = -EAGAIN;
 				goto end;
 			}
@@ -5624,10 +5573,85 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 	}
 
 end:
-	if (need_full_reset)
+	return r;
+}
+
+int amdgpu_do_asic_reset(struct list_head *device_list_handle,
+			 struct amdgpu_reset_context *reset_context)
+{
+	struct amdgpu_device *tmp_adev = NULL;
+	bool need_full_reset, skip_hw_reset;
+	int r = 0;
+
+	/* Try reset handler method first */
+	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
+				    reset_list);
+
+	reset_context->reset_device_list = device_list_handle;
+	r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
+	/* If reset handler not implemented, continue; otherwise return */
+	if (r == -EOPNOTSUPP)
+		r = 0;
+	else
+		return r;
+
+	/* Reset handler not implemented, use the default method */
+	need_full_reset =
+		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
+	skip_hw_reset = test_bit(AMDGPU_SKIP_HW_RESET, &reset_context->flags);
+
+	/*
+	 * ASIC reset has to be done on all XGMI hive nodes ASAP
+	 * to allow proper links negotiation in FW (within 1 sec)
+	 */
+	if (!skip_hw_reset && need_full_reset) {
+		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
+			/* For XGMI run all resets in parallel to speed up the process */
+			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
+				if (!queue_work(system_unbound_wq,
+						&tmp_adev->xgmi_reset_work))
+					r = -EALREADY;
+			} else
+				r = amdgpu_asic_reset(tmp_adev);
+
+			if (r) {
+				dev_err(tmp_adev->dev,
+					"ASIC reset failed with error, %d for drm dev, %s",
+					r, adev_to_drm(tmp_adev)->unique);
+				goto out;
+			}
+		}
+
+		/* For XGMI wait for all resets to complete before proceed */
+		if (!r) {
+			list_for_each_entry(tmp_adev, device_list_handle,
+					    reset_list) {
+				if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
+					flush_work(&tmp_adev->xgmi_reset_work);
+					r = tmp_adev->asic_reset_res;
+					if (r)
+						break;
+				}
+			}
+		}
+	}
+
+	if (!r && amdgpu_ras_intr_triggered()) {
+		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
+			amdgpu_ras_reset_error_count(tmp_adev,
+						     AMDGPU_RAS_BLOCK__MMHUB);
+		}
+
+		amdgpu_ras_intr_cleared();
+	}
+
+	r = amdgpu_device_reinit_after_reset(reset_context);
+	if (r == -EAGAIN)
 		set_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
 	else
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
+
+out:
 	return r;
 }
 
-- 
2.25.1

