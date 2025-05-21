Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7AEC54E65
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 09:50:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA9F410E6DF;
	Wed, 21 May 2025 09:50:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QhNT2VQa";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2A2110E6DF
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 09:50:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9yuYlmU7IjM/SSxEXvvHfaFkpaoRPczfMvbfgjCc6jvrq1eAEr1znQA6IapeX/lYvMiUVCD6CfzJ6P5eRP2UDXd/wNJwkLRwWTs9DQtIl6CyC3iVRfvaRuIluErwMQoXu8aG6bz5hO4xStjrg+SoDnFY2NmeyQBZjgVxy5VYi6wv/0lIJrJczeFq+IckJmwypg7Kr6fmv9q98k2e6JJulpecyqQipjGcvlXbnnL6e83KYfSR+WViieIjjMS5isjvzZMP+zvGQxKPVgZtcpPJUqjtlSmPBZF32XUdhU1z0xw+EPkBlhJcDz29Ncq6A/IaGycD9gaEO9D4HCZ01DdQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4z3Hgp7kzGX9n+sXsVbYJnnFHlSptUgLHZbTaCoifHA=;
 b=WM4r3ToJsG7029uRV5TSoQUrF6KIQOxMU2ZN2fy/XSGU2MmLmnvtjQ9tPnjYZwyFcmCsQUXzzE8X61TCgVEmsJmYtdTlq/o5MbceFHcc8jlQ3jcgUPxnotJoHI3SNpv6ZggJd9pL0xakk/BLB46IsBJ+SVveItJGSr8QH+TCnGJU4Myfck4JJUkEVU6e+xcPzzDXqMRvz81a3SO/g9w4AXU4OBpq5yxv0i1zf5DgsCtFsKuIqiFcdsV3BtaZZpRews/N2TojHqut2CAQ3u8N7ISsz/Siu/9+fQ2dFZp/c/GaRUW4+GPU3A1ASdNkSV4kzM2pKC/csaxNwpyVPEzVCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4z3Hgp7kzGX9n+sXsVbYJnnFHlSptUgLHZbTaCoifHA=;
 b=QhNT2VQaOUD0tb2A0D3m1RWRjQmJXi5T8OyyBUgwnLgkR5NvFJVieMhwpKsPrTRa0CXqaGouEkHxhX3v223/wzh1WBrmmwOE2bfmCoTtpAVsiGjtaeVWfLHE3nnLTfZAMKPEiu2YbIQeY25zMcx6xv/nPOt2+MSegHd3X01NaVw=
Received: from BN0PR04CA0015.namprd04.prod.outlook.com (2603:10b6:408:ee::20)
 by CYYPR12MB8656.namprd12.prod.outlook.com (2603:10b6:930:c3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 09:49:59 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:ee:cafe::3b) by BN0PR04CA0015.outlook.office365.com
 (2603:10b6:408:ee::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Wed,
 21 May 2025 09:49:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.4 via Frontend Transport; Wed, 21 May 2025 09:49:58 +0000
Received: from FRAPPELLOUX01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 04:49:57 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v1 2/7] drm/amdgpu: don't report stale vm_fault info in
 devcoredump
Date: Wed, 21 May 2025 11:49:04 +0200
Message-ID: <20250521094912.6714-2-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521094912.6714-1-pierre-eric.pelloux-prayer@amd.com>
References: <20250521094912.6714-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|CYYPR12MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd5de1d-97fc-4fc7-b324-08dd984cd91c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jex05e1pH9Tx2Fo68B+MdgUxZNa+tyjgTR63zCP3s+6c3Ip+zJwPlKZxemix?=
 =?us-ascii?Q?itJFEVN8h6rVstc7mP5gv/9wI8x1PgfhEYiTxOyeQmbwgt0mYbT42wlSDzLJ?=
 =?us-ascii?Q?MT4yTuhugUXDFsPuXkcPsppJAKVYtKPvabcxxLou5qum5Uk6syF3dweA185u?=
 =?us-ascii?Q?CgPtOJwGTfBbsRBfDnWoXKou2CjKtFslP+Yq0/JOPiXGwODGaQ33c8cnoIYu?=
 =?us-ascii?Q?UItFjpp9wkVykHzbPF2I4NwAu6TI8hWBTzyUaIjtAHDUr1+NE2ou010Vx+lc?=
 =?us-ascii?Q?Ul4PD/xL9Xi2MokDEKF83960uSvWxiiksmECk9moiRR6ZjLjwvuVwLuFaFpK?=
 =?us-ascii?Q?MBb86kG8SM30H+VQ1qUQRgsG/MXDzC2tn7DD0NDoAR4oy3ftWaQQkJHexF7o?=
 =?us-ascii?Q?XpPW7ws7/ckmsY1srpTxHvPkK2wDK0Rq0VWo3LG5M+BYB6ehVfBbV9BThgon?=
 =?us-ascii?Q?BLRXjcLNjuQ2ImSZKYECdbviLTx3I10wy6lLtcaRdITSiVNirPGsCzheZVue?=
 =?us-ascii?Q?Ty+QKCc6BN67oPZN/AdpFJ7VNnarlMJZJTfSTWxin2XR4GdH8i3g94PyGPNN?=
 =?us-ascii?Q?sVVdFQK0jsREdG7ebwGL0bEETXUVFtMqU+NrQdMmElc/CsJOLq94RWabot5C?=
 =?us-ascii?Q?5WqCm2Xv2U/AC39y5wjpFWF1QCU12WC2Y+HLyk67CNJCyMQv+rMGu3vBSb16?=
 =?us-ascii?Q?2My3iVILdoT7ermoYR502WKWouc//+9ZV9tVFMfBMilRRWtfZKyUCo0NdVl8?=
 =?us-ascii?Q?GJE6eP2fq/e0THASHjPoV5dF5TJtiTUUEmrpwBq3d0HQp5lh27I+d9gglS+n?=
 =?us-ascii?Q?hneu6W+F4NkJ4RlivYW7p0VEUB6QxhKFz9l4Nl0HUVfO2oTx9QcyeNcx8iDI?=
 =?us-ascii?Q?STljZsJHwTLVKRN/ch66xiMN0CyvcqGfOlMrxVmXGLdl7gM+HdvfasnqgZSG?=
 =?us-ascii?Q?qlpdRj9N28KG3n6Ir4KRdDS/ZIUY4XVnzFtqHAYi04xjE3ORqipwbS11UI5e?=
 =?us-ascii?Q?9Zl3wIcjRT+/HVPAPOyXk4R/geHfvobLME/ME1s4bK8V4kmB4TjDYkT6LiN4?=
 =?us-ascii?Q?BYg+4sHRZNLN1P5dhn5h/HDXWiLW+yX6bw6Ighta3sv4wNmGSrsaYNZCNHxc?=
 =?us-ascii?Q?wZq9SHwcLegZ5Z4WhZrQqhwyhDhJ3VWZNnA5MdiqBA7c0+PH+gEYDOHHmZqv?=
 =?us-ascii?Q?86HwVzOMaTPs0Wg8B54HKs7LwM5cOQ+R2XYXoBmAqz04wu61GQ56pJzrnT2a?=
 =?us-ascii?Q?EymIpJz4IiaQ/ZVQlPwkxt4EMDfurNgPosJ7owG94rNiHlZv2Rc/GE3/t6mt?=
 =?us-ascii?Q?7QbrUl2knKP9jn33uHPU8OQyW1+snUtbJZjx50fiHf15635Az/FIf0uRxGjW?=
 =?us-ascii?Q?QZOJm0AWfBimSpzf8aD7Pcu09ktoPkfKc4IHYAnJV/lU6Wd2dViaGyhBy3i3?=
 =?us-ascii?Q?SeuCSGjEOjkIgORWYeQO8otT9Zx2fhQY1a8zpFu7u1Wyo31SWyJRiVz1Ja0U?=
 =?us-ascii?Q?+SczWMzfznT4BVyy4qVgmwBI8TDdeX+rWb6d?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 09:49:58.3494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd5de1d-97fc-4fc7-b324-08dd984cd91c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8656
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

The coredump needs to contain accurate data and reporting a page
fault from a previous issue is incorrect.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 13 ++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c          |  5 +++++
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index de70747a099d..6fa53e070b50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -273,11 +273,13 @@ __amdgpu_devcoredump_read(char *buffer, size_t count, struct amdgpu_coredump_inf
 	}
 
 	/* Add page fault information */
-	fault_info = &coredump->adev->vm_manager.fault_info;
-	drm_printf(&p, "\n[%s] Page fault observed\n",
-		   fault_info->vmhub ? "mmhub" : "gfxhub");
-	drm_printf(&p, "Faulty page starting at address: 0x%016llx\n", fault_info->addr);
-	drm_printf(&p, "Protection fault status register: 0x%x\n\n", fault_info->status);
+	fault_info = &coredump->fault_info;
+	if (fault_info->status != 0) {
+		drm_printf(&p, "\n[%s] Page fault observed\n",
+			   fault_info->vmhub ? "mmhub" : "gfxhub");
+		drm_printf(&p, "Faulty page starting at address: 0x%016llx\n", fault_info->addr);
+		drm_printf(&p, "Protection fault status register: 0x%x\n\n", fault_info->status);
+	}
 
 	/* dump the ip state for each ip */
 	drm_printf(&p, "IP Dump\n");
@@ -377,6 +379,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 
 	coredump->skip_vram_check = skip_vram_check;
 	coredump->reset_vram_lost = vram_lost;
+	coredump->fault_info = adev->vm_manager.fault_info;
 
 	if (job && job->pasid) {
 		struct amdgpu_task_info *ti;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
index 33f2f6fdfcf7..38ccdd3d6213 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
@@ -37,6 +37,7 @@ struct amdgpu_coredump_info {
 	struct timespec64               reset_time;
 	bool                            skip_vram_check;
 	bool                            reset_vram_lost;
+	struct amdgpu_vm_fault_info	fault_info;
 	struct amdgpu_ring              *ring;
 	/* Readable form of coredevdump, generate once to speed up
 	 * reading it (see drm_coredump_printer's documentation).
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index acb21fc8b3ce..5ee9d2cd74e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -199,6 +199,11 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 
 exit:
 	drm_dev_exit(idx);
+
+	/* Clear fault info to avoid reporting the same fault. */
+	adev->vm_manager.fault_info.status = 0;
+	adev->vm_manager.fault_info.addr = 0;
+
 	return DRM_GPU_SCHED_STAT_NOMINAL;
 }
 
-- 
2.43.0

