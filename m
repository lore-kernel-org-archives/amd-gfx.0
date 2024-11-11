Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E46D3ABD0
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2024 16:42:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E2F510E212;
	Mon, 11 Nov 2024 16:42:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CEWcehml";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D9BD10E2EC
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 16:42:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqIap5IRCX20TLN2HWWn+t7aCO/mduSw9UqChY/XyYa+YzLjwVQWDZz/b5qdXT3c8pVrLxB3uKcJzsQWju3+SRkrIddgRgue9uUxvRjm7OIosk18MeX4tyT1Haz1VOe86EQWwf/4/uJisH643ZP+R0KU4hvXNH7Q4ygn3kBgKrrdQ8eox0qVhvu44Ln+YwHcz8lD9ZMIm0U8l0/Qx0vmd2s2w7/KESIycgpeT30Uh0QsN9jQNeeR8iE0YGfd3cjNzMB2QjFQSNHCQAXwMg6h5XITdMWK2knthLpiJil4M1aCQeMpQFuk1KL8hRVA3vp/Cewj0jUFPgFUU9tiVSn8Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qI6OqTzUCsenM15c7dpyta5zdtwSx7v1f4o2VBRWxoM=;
 b=EDOzvrk7XoDsaN7+6vWXIaVExz+cac2v6b3SMxHO/dzypb21WMBvBbRI3Zg+Rv0+vlOfWuNpHY+D+7fIbkXWnJsDDRFuXoTq6eIwbz6TjNByBjpE2IOmIKTWU8FTgHyzi+tE5SlModF7yvHUl2BuKXnQ+hY5LqDbkaI7eYa/n00xt+KOfGXcNF8+FWhHuse5av0Fxt0F5TO5y3d5Jlo2XTNFuOXw6thMwIQsot0KPqqURXTvxtjjrNg6NJEJXNTmjQuBBc/sbM85B8Cu7CBA1ySm/k3AczdkrfiPIxo2GxOFraeuHJNsnA5etOHxvcgzrA1k2+LTxvP/nZi+UtHkIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qI6OqTzUCsenM15c7dpyta5zdtwSx7v1f4o2VBRWxoM=;
 b=CEWcehmlor1X2+OLQ/ajdk92M0FVIB7hm1WGUp8IUQg1v7DbKGBqmU9sBmfGfl57DQBaclJFDYkzRNzx4xgG9DEMzlfduquhggIU7O0Ib0OC0CxqjlsOZ06ZyqsW3qPKYwHy9jNKV3J87ha2b6XDKBlrxP1gVVH80gSvAb6pRpg=
Received: from BY3PR10CA0003.namprd10.prod.outlook.com (2603:10b6:a03:255::8)
 by CY8PR12MB7218.namprd12.prod.outlook.com (2603:10b6:930:5a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 16:42:26 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::34) by BY3PR10CA0003.outlook.office365.com
 (2603:10b6:a03:255::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Mon, 11 Nov 2024 16:42:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 16:42:26 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 11 Nov 2024 10:42:22 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add amdgpu_vcn_sched_mask debugfs
Date: Mon, 11 Nov 2024 22:11:26 +0530
Message-ID: <20241111164126.2195380-2-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241111164126.2195380-1-sathishkumar.sundararaju@amd.com>
References: <20241111164126.2195380-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|CY8PR12MB7218:EE_
X-MS-Office365-Filtering-Correlation-Id: 195c2196-595c-44da-53de-08dd026fd31d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnFaK1pFMWhBMUhzL0ttTzVNakQ2T1ZNL1lNWnVoMTBIb3I5aVZhNWRUS0Zk?=
 =?utf-8?B?d0xYOGl5WUxDUFg0eTJTdVNXNEN1QnJzUXJtSFh6R1NDVWlBQm01MzdqTWNz?=
 =?utf-8?B?WVNLOFdPQUdDc1VieTVTZ0xEcGJ5YllSWXp3U3N2K09oU05obHZ5aExQcjNm?=
 =?utf-8?B?RTA5R3RXazR4OUZQRkZvNnpna0doOE9xbnp4OEFnZGxFcGNMSnFnV0gwWFd0?=
 =?utf-8?B?SWkzeDZBekpRTjFNQU52VWh3cTExRzhPelBVQThodGpZMXJPMEtLc0VSRmQ2?=
 =?utf-8?B?ZGhod0xtZWpkTE9LU2MvYThLM0p3R1BnNkVZS3ZYTzdkZ0dXMlhSY2Q4Y3VY?=
 =?utf-8?B?dFFCN1BMbGxScmtmWUt0akFsRG9pbDhET3hycWczTHVWQm5ycnMyczdUb2Qw?=
 =?utf-8?B?UmUxMDhnNkFtOHdwaGUxWFhQdnorUHhJbi84Mk56YndiZXNEY3JoTk5FNHJ1?=
 =?utf-8?B?TjQ1a3lzQ3dyZjZjNmQxSVQ2S2d6YjlmN3BUMTRLVzFjdU1yRGxYTm5VQUIr?=
 =?utf-8?B?dnhTa2U3WFYxQ3ZlVEVRaGlBWStVMDVjWHlaUGZ5TUtwbi80ZlNYVFB4NENH?=
 =?utf-8?B?aHNBWlBUQm5wbVJCai9ucXhscE15ZzZPTHFxaVRZNEVHeDd1Qkdwc3pLbVdG?=
 =?utf-8?B?R2dhdEZ4NWFRQkNJb0NhZ3JaVjFpamdwY2xmVFpWcEc1UTd6L1BXelpCVFBH?=
 =?utf-8?B?bjVRQkM4MDN0VDU0ZEplUXo5MVJkUDZ3QWRUMURKdHBONVhLZlpmYW5TcHMv?=
 =?utf-8?B?OU0xQnRZQzdUV01pOEdFMmhQaVl4SjRhRjQ2cXNBbUo0SDhRd0FrNWlDTW5o?=
 =?utf-8?B?c3VXVXpoTTJ1Nld2UUFNSTF5UkR6UEx2REpJUXZQUU9XWFZtWUdJK1Q0UlZE?=
 =?utf-8?B?ZHJCc3lFK3Nxalg1NUt1WjIyaUdqbTc3amZVR2s0cGN6T1o1NHlUakR5cVAr?=
 =?utf-8?B?RmJBRFA0OXJhVzlRR2hnTDhUZWVIVGtmTXAwVDVIaWlQeTVLSmFYVFpWNklC?=
 =?utf-8?B?aWg5LzI2NzZZVmcxNHV1ZmdRT2U3MFloQWhrOSt0dCtZeFF5ZFAzQllKNUtE?=
 =?utf-8?B?MGNUbTRNU3pOcngyWEU1Ui9tdFI3TVFFQUM1bTRNOXcxazQyeTBKSTRwd1R0?=
 =?utf-8?B?aFVsMXU0Nm5XelJWS09WVmhzN1dGNko0QlljZjBRUmRrci94VThDYUZUR0tY?=
 =?utf-8?B?TldReVZVczQxM0hVc3VBMVNPbkJaY0dES1BpY3RTZ3J5K3hNVElZZ2JZUnht?=
 =?utf-8?B?anNBNDJDOFgyNWZsbER2dVU0MTJjWisrSnRnNUtNaW53SnhHd2xldE1Odm5p?=
 =?utf-8?B?MGpuc3BwajJhMVZPZ3BJMEt6K203czh2RmhUWUJQeG9rcXRyMTZvdzZPNFhG?=
 =?utf-8?B?YitvN3ZQWlRHODEwbW5hbHhlcklxYUFuaWQ2a2F5NVZ4TzROcDZqOWhUeHY1?=
 =?utf-8?B?WDBvelRrOHJvN3hEY2hqeW1BRHVLOHgzRThvZmNGN3htV1dad05yMDZRaVR3?=
 =?utf-8?B?MG0ySlJhN0F5TjIrUHdWN3BwaVhFM0JUMDNFRFNUYzBPc2VUTHl6OVhWdFRT?=
 =?utf-8?B?VTdXUFZ2d2tvUCtLbCtIckNyUGFDYWI4VGVSTlVYNHNLOXFFb3JVelJLMS9w?=
 =?utf-8?B?L1lSVmNVV3hTd2tJRTVTUTF4Qm96VDdPOHRGS0U0QVMyak9VbE51TUlpVmtY?=
 =?utf-8?B?L2VaT1NzdDUrS3puUThOYU80TDBOTDVoTTZDNllCTjNGKzRWc3djdE9qS2Rm?=
 =?utf-8?B?aWtCUzRuak93d1RaWFVRV3YrV2VFeXQxbC9zYXJiSUwvQjRZeHZIZzdiUWhH?=
 =?utf-8?B?VW9KcXl3ZHN2UTBWTkpCcXNTYzYzVDJLa3Z4L2RGYm5VUnFnRUNDM2xQVExr?=
 =?utf-8?B?YVpYbVgrVkVFR29PWWFDdXVKK0s3dEZQeENXcHpUZFBFS3c9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 16:42:26.1299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 195c2196-595c-44da-53de-08dd026fd31d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7218
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

Add debugfs entry to enable or disable job submission to
specific vcn instances. The entry is created only when
there is more than an instance and is unified queue type.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     | 68 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h     |  1 +
 3 files changed, 70 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index a68338cb7b4a..49ca8c814455 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2095,6 +2095,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	if (amdgpu_umsch_mm & amdgpu_umsch_mm_fwlog)
 		amdgpu_debugfs_umsch_fwlog_init(adev, &adev->umsch_mm);
 
+	amdgpu_debugfs_vcn_sched_mask_init(adev);
 	amdgpu_debugfs_jpeg_sched_mask_init(adev);
 	amdgpu_debugfs_gfx_sched_mask_init(adev);
 	amdgpu_debugfs_compute_sched_mask_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 25f490ad3a85..9671dc8bbe9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1318,3 +1318,71 @@ void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 		drm_dev_exit(idx);
 	}
 }
+
+/*
+ * debugfs to enable/disable vcn job submission to specific core or
+ * instance. It is created only if the queue type is unified.
+ */
+#if defined(CONFIG_DEBUG_FS)
+static int amdgpu_debugfs_vcn_sched_mask_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)data;
+	u32 i;
+	u64 mask;
+	struct amdgpu_ring *ring;
+
+	if (!adev)
+		return -ENODEV;
+
+	mask = (1ULL << adev->vcn.num_vcn_inst) - 1;
+	if ((val & mask) == 0)
+		return -EINVAL;
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		ring = &adev->vcn.inst[i].ring_enc[0];
+		if (val & (1ULL << i))
+			ring->sched.ready = true;
+		else
+			ring->sched.ready = false;
+	}
+	/* publish sched.ready flag update effective immediately across smp */
+	smp_rmb();
+	return 0;
+}
+
+static int amdgpu_debugfs_vcn_sched_mask_get(void *data, u64 *val)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)data;
+	u32 i;
+	u64 mask = 0;
+	struct amdgpu_ring *ring;
+
+	if (!adev)
+		return -ENODEV;
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		ring = &adev->vcn.inst[i].ring_enc[0];
+		if (ring->sched.ready)
+			mask |= 1ULL << i;
+		}
+	*val = mask;
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_vcn_sched_mask_fops,
+			 amdgpu_debugfs_vcn_sched_mask_get,
+			 amdgpu_debugfs_vcn_sched_mask_set, "%llx\n");
+#endif
+
+void amdgpu_debugfs_vcn_sched_mask_init(struct amdgpu_device *adev)
+{
+#if defined(CONFIG_DEBUG_FS)
+	struct drm_minor *minor = adev_to_drm(adev)->primary;
+	struct dentry *root = minor->debugfs_root;
+	char name[32];
+
+	if (adev->vcn.num_vcn_inst <= 1 || !adev->vcn.using_unified_queue)
+		return;
+	sprintf(name, "amdgpu_vcn_sched_mask");
+	debugfs_create_file(name, 0600, root, adev,
+			    &amdgpu_debugfs_vcn_sched_mask_fops);
+#endif
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 273a94a5472e..7ad944cea861 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -525,5 +525,6 @@ int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
 int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev);
 void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev);
+void amdgpu_debugfs_vcn_sched_mask_init(struct amdgpu_device *adev);
 
 #endif
-- 
2.25.1

