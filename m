Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892A6C5B549
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 07:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0725610E36B;
	Fri,  6 Jun 2025 07:12:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1QIP2DZ3";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04AAD10E36B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 07:12:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXTPXM2qtF3BuOszHjdwPhXHNJY5nJ1fw730rwKY3Nzu7ru1xL01jWw69+6i8Dr05KjUfK0Tg6/MTed4zA4gJuu+VGkmCssAOPbSWSMRoTRmI60YciwflqE0DTeM44FXOywkrNp0dFp8bxuc36eFBnNtSQkDxWd3mjKQ/Zs28Y1YbgJRF+TiaGfPRtarMzRGYFfmJS+Wxhf5sUI9b5HVlc8gcw72GAWLj5eoBiJzXr4Es8JnHBRBjaF6qRD41p4kd+ospDeixT2ukv+dkAu3mXTUrsS/2drH6Whe4sZTSJqVfJmSO+ccRHLOnT4/907swfdAHHjgcdGvCV5q3axIwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O17PiZm8GRKMSFuWEBYYfkWnNV/xaQUz9W42AWthnGU=;
 b=q16xzwIxwJRAue71m/XO3HdKpwDBhPQTXazuAPx2OwXKIXf9AHNXmMuna4iB84ocBhd29g60UZnU53z1LRpLjeRW0w8ASmtpck5zZBbr9w1glFwWD8tChIbFgz/kZmbKAL6qiJOEQl6u2KloWnC9rUfodEBlK9z3SKtyjGUqDGR77VoJd+ZEAlXCoX/n8L5WwD4EUfuNmIvVv9ByDC4lT0K8Dl2MbJg/j4rDdMjrgRkmVtDymQ/44HZADfYGXNxwCbXupc0ABa4KLVCTsCq5F3ShUd+KIDQUpp0RgLKqF/kmMrmx51RC4BsUl+qJpSnc7Y33WVu3Q9ITSLUt8fHLqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O17PiZm8GRKMSFuWEBYYfkWnNV/xaQUz9W42AWthnGU=;
 b=1QIP2DZ32QAzKOoiAtxKlOgKkI8QPpRMF9cTf0jMRmmkFLMrrYtPUrNjV5IH8okgAGIFCa+lBlh0wnN5HrIURdrEuBNsHwUGixTu9zmkeHaReaR5VvmWDVzCEZxJUgxorjf+7ENTeJ+RCqYI7YhzGKTi6dHPl7vYAdlj0sgS0ho=
Received: from BL0PR0102CA0055.prod.exchangelabs.com (2603:10b6:208:25::32) by
 SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 07:12:46 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:25:cafe::5f) by BL0PR0102CA0055.outlook.office365.com
 (2603:10b6:208:25::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.29 via Frontend Transport; Fri,
 6 Jun 2025 07:12:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 07:12:45 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 02:12:43 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Tao.Zhou1@amd.com>, <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>,
 <lijo.lazar@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu: Release reset locks during failures
Date: Fri, 6 Jun 2025 15:12:34 +0800
Message-ID: <20250606071234.146175-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|SA3PR12MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 5861a63e-2caa-41b0-da60-08dda4c98998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o/6WVjAcXqRo8xtYJS4m60jgIhFWla1uw9fo7iQa48WhMs9HhtDWTdfOMYtL?=
 =?us-ascii?Q?ZuJGIQrEz+junof3gng+9QjcUqWoBNbiykT4DUBd4FwEeOFUNcpDl9k6hq4C?=
 =?us-ascii?Q?PdbyZZKrH0Jaic8aJnJ5ylKnazVX7BgI1830aXD2DeUFypFDcpEwdS6c2XVK?=
 =?us-ascii?Q?B2PXc20ANcb4rfSrI80T5E4V28NfXe9QNfPIIAxyOdjBOdZayXwlYI4kIJT+?=
 =?us-ascii?Q?m6qaWVZ7+xBDJ8k9jTtsKJ8+KeGiogh/J4tMrv+9wSUa1ouTWVdnocCVtRnj?=
 =?us-ascii?Q?X7jCV1ujh1HeZBgJJAe1B/KZUF1fFj3+1+hSINxo8AcJXj9NTjjRgL5wIROF?=
 =?us-ascii?Q?ePiwJJ8uxLJNo6soI0hD7DG1/ngH72OGy2M4r3ZVzspn3Jzayx0RxiV5PNav?=
 =?us-ascii?Q?zKSoqN6/KRe3cpmcWC2icNDp1/f7vNLUmMU5Qc1N8URMjpDA2QCDjFThUVTg?=
 =?us-ascii?Q?P2JEgRonia4hL6JBEY+JJU8uiDbWtKHuWYkxybG4NrV2nMnVYuPaU3RIOJJo?=
 =?us-ascii?Q?7kZaVV27NWZ8cL9Erxo/Uvi7RlcBkYHpoYJc8C/yWCVoYbYu5aZcnZabX2Xk?=
 =?us-ascii?Q?ZhTQPoqsvQWVnzBoKff2nXpfOAz8KaJuN+jcKrQpFfe5wHDkooa8mt05w2Ys?=
 =?us-ascii?Q?jnRGSkw693WBgz9tNs5oihyly1tuzvPyiZQbAmOh1Ibp94n4HXi1ovIuh0kb?=
 =?us-ascii?Q?pxP/Yup18iVO2yMPWHLsKKe+UzNNiBmKoULSk7mWZwR+87ixG+mcEsCvSOqn?=
 =?us-ascii?Q?e79/uE+X0zum84lE8Zun7qgj+SSoHIVgQsSRUcRS70iIUyzXJlpMaopp/M8E?=
 =?us-ascii?Q?zcM6zpmEIU2IilCPCEJlunLgkZNBGPbZgIE8YaacuKJwhhi2lZPpUL9TcRSu?=
 =?us-ascii?Q?Kl64bLlKkN3y8VGZGDp6RtpsBZyL3/EvndcWv4TWCQUgF0stzXBc+9DCxBSh?=
 =?us-ascii?Q?+U1qsPyp+zD74UZCGGPihgl0smzAXqGZqMAagm7GyGFgVsX3bgVAHMV1CofA?=
 =?us-ascii?Q?UMIIHvZ4WOjsCOBUB/05Ib5XgznSjMIowKCTfDEvZuTrqtQPqwNAytlucSU7?=
 =?us-ascii?Q?SfDvjLM4mX9840qmdNF82R44s2BKFsQcwXeVwHK+rLVR4uPHA6OimY/GloIV?=
 =?us-ascii?Q?7/Ks03D/Y70FO2tHc35ALCqg7TD80sz6He1DvelWZ0kOsaZKVZD8FHHDluyX?=
 =?us-ascii?Q?LtwqRpMfAyCdLU/CfaofyLoz0/SswmBv5yhmMOS7FVEcusnYXCd7lm60N/ZN?=
 =?us-ascii?Q?PrJGq2CUQvtgAfkv01iFM6iU4icK4CtHwtttCWwKbwJ40fFrtVCMo6wXnofV?=
 =?us-ascii?Q?JXXOywIJolfMVA6t4RYmdB9zbpsr8aosxoc0G9YT4s5OTdn92Zo7zalnhU2Q?=
 =?us-ascii?Q?yqVpz72GhsU2CCcvAAMiSfJPfYlGdn0LIsj06KvzNlaY48gAqcxteIlgOTAU?=
 =?us-ascii?Q?KpLRr47i9PY6CO9R1WOHrUGSbdYxBhedWyj4FT4B6NtGuiWYmnbRjtdabOXj?=
 =?us-ascii?Q?dLrs4jJwSDeogxcm3Hu2fyXH6QCiHi0IN+HY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 07:12:45.9924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5861a63e-2caa-41b0-da60-08dda4c98998
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783
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

From: Lijo Lazar <lijo.lazar@amd.com>

Make sure to release reset domain lock in case of failures.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Ce Sun <cesun102@amd.com>

Fixes: 0f936e23cf9d ("drm/amdgpu: refactor amdgpu_device_gpu_recover")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 80 +++++++++++++++-------
 1 file changed, 55 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2b84df8da61a..85509cd4cab8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6068,16 +6068,12 @@ static int amdgpu_device_health_check(struct list_head *device_list_handle)
 	return ret;
 }
 
-static int amdgpu_device_halt_activities(struct amdgpu_device *adev,
-			      struct amdgpu_job *job,
-			      struct amdgpu_reset_context *reset_context,
-			      struct list_head *device_list,
-			      struct amdgpu_hive_info *hive,
-			      bool need_emergency_restart)
+static int amdgpu_device_recovery_prepare(struct amdgpu_device *adev,
+					  struct list_head *device_list,
+					  struct amdgpu_hive_info *hive)
 {
-	struct list_head *device_list_handle =  NULL;
 	struct amdgpu_device *tmp_adev = NULL;
-	int i, r = 0;
+	int r;
 
 	/*
 	 * Build list of devices to reset.
@@ -6094,26 +6090,54 @@ static int amdgpu_device_halt_activities(struct amdgpu_device *adev,
 		}
 		if (!list_is_first(&adev->reset_list, device_list))
 			list_rotate_to_front(&adev->reset_list, device_list);
-		device_list_handle = device_list;
 	} else {
 		list_add_tail(&adev->reset_list, device_list);
-		device_list_handle = device_list;
 	}
 
 	if (!amdgpu_sriov_vf(adev) && (!adev->pcie_reset_ctx.occurs_dpc)) {
-		r = amdgpu_device_health_check(device_list_handle);
+		r = amdgpu_device_health_check(device_list);
 		if (r)
 			return r;
 	}
 
-	/* We need to lock reset domain only once both for XGMI and single device */
-	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
-				    reset_list);
+	return 0;
+}
+
+static void amdgpu_device_recovery_get_reset_lock(struct amdgpu_device *adev,
+						  struct list_head *device_list)
+{
+	struct amdgpu_device *tmp_adev = NULL;
+
+	if (list_empty(device_list))
+		return;
+	tmp_adev =
+		list_first_entry(device_list, struct amdgpu_device, reset_list);
 	amdgpu_device_lock_reset_domain(tmp_adev->reset_domain);
+}
 
-	/* block all schedulers and reset given job's ring */
-	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
+static void amdgpu_device_recovery_put_reset_lock(struct amdgpu_device *adev,
+						  struct list_head *device_list)
+{
+	struct amdgpu_device *tmp_adev = NULL;
 
+	if (list_empty(device_list))
+		return;
+	tmp_adev =
+		list_first_entry(device_list, struct amdgpu_device, reset_list);
+	amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
+}
+
+static int amdgpu_device_halt_activities(
+	struct amdgpu_device *adev, struct amdgpu_job *job,
+	struct amdgpu_reset_context *reset_context,
+	struct list_head *device_list, struct amdgpu_hive_info *hive,
+	bool need_emergency_restart)
+{
+	struct amdgpu_device *tmp_adev = NULL;
+	int i, r = 0;
+
+	/* block all schedulers and reset given job's ring */
+	list_for_each_entry(tmp_adev, device_list, reset_list) {
 		amdgpu_device_set_mp1_state(tmp_adev);
 
 		/*
@@ -6301,11 +6325,6 @@ static void amdgpu_device_gpu_resume(struct amdgpu_device *adev,
 		amdgpu_ras_set_error_query_ready(tmp_adev, true);
 
 	}
-
-	tmp_adev = list_first_entry(device_list, struct amdgpu_device,
-					    reset_list);
-	amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
-
 }
 
 
@@ -6376,10 +6395,16 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	reset_context->hive = hive;
 	INIT_LIST_HEAD(&device_list);
 
+	if (amdgpu_device_recovery_prepare(adev, &device_list, hive))
+		goto end_reset;
+
+	/* We need to lock reset domain only once both for XGMI and single device */
+	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
+
 	r = amdgpu_device_halt_activities(adev, job, reset_context, &device_list,
 					 hive, need_emergency_restart);
 	if (r)
-		goto end_reset;
+		goto reset_unlock;
 
 	if (need_emergency_restart)
 		goto skip_sched_resume;
@@ -6397,13 +6422,15 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 	r = amdgpu_device_asic_reset(adev, &device_list, reset_context);
 	if (r)
-		goto end_reset;
+		goto reset_unlock;
 skip_hw_reset:
 	r = amdgpu_device_sched_resume(&device_list, reset_context, job_signaled);
 	if (r)
-		goto end_reset;
+		goto reset_unlock;
 skip_sched_resume:
 	amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart);
+reset_unlock:
+	amdgpu_device_recovery_put_reset_lock(adev, &device_list);
 end_reset:
 	if (hive) {
 		mutex_unlock(&hive->hive_lock);
@@ -6821,6 +6848,8 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 		memset(&reset_context, 0, sizeof(reset_context));
 		INIT_LIST_HEAD(&device_list);
 
+		amdgpu_device_recovery_prepare(adev, &device_list, hive);
+		amdgpu_device_recovery_get_reset_lock(adev, &device_list);
 		r = amdgpu_device_halt_activities(adev, NULL, &reset_context, &device_list,
 					 hive, false);
 		if (hive) {
@@ -6938,8 +6967,8 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 		if (hive) {
 			list_for_each_entry(tmp_adev, &device_list, reset_list)
 				amdgpu_device_unset_mp1_state(tmp_adev);
-			amdgpu_device_unlock_reset_domain(adev->reset_domain);
 		}
+		amdgpu_device_recovery_put_reset_lock(adev, &device_list);
 	}
 
 	if (hive) {
@@ -6985,6 +7014,7 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
 
 	amdgpu_device_sched_resume(&device_list, NULL, NULL);
 	amdgpu_device_gpu_resume(adev, &device_list, false);
+	amdgpu_device_recovery_put_reset_lock(adev, &device_list);
 	adev->pcie_reset_ctx.occurs_dpc = false;
 
 	if (hive) {
-- 
2.34.1

