Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F14C2D0CD
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 09:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF91510E702;
	Wed, 21 May 2025 09:51:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hSa5r2K5";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AE3C10E6E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 09:51:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5rqitlmR2hPzKdpxXRJOE2cwKiaXFoJtlI9uuEqOnrGd+Qnv2dYQnPWvXgucBYuDkCKbzBt9Ce97HCU0ELTAicWNxMFGFnPL8Dbsnjl0XrWuFA8B/UJz2ZOvTxRkByQSWlJ9BtWsW/7H9pzQ8l7Ay3A07FyGNz9UsjLpJK4+HuPasI/Hwm5V3VM2H8Ubjc2SyLGKVFIbqqITQRtZpImQz+FAFhg++4aS0Wp7oFEGphc4t4HRj3VINiDGpfMIhCODYOHFcmmN9k75y5eeGkk+Lqtctqi0si4uiLJkoC2OL5JBwNUo1kNa3X7JeXTdQ/K5SuiWCQgzQdZeF81lmoh5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhXlEHR4xg2Fxj/zNnfK6RNghHZjx/NzuSGC/4UkbTo=;
 b=j6TcPyVH4NadFOdanj00ZSCF0q83b0fJ5ohGAPoL8EhMzKv01A5yaq7p0WFaSVDNs5EPPNZkEQ5hbDqKDgTeMA4U04CZUN9EkcY1KV9l6EpQLHLN0OW72H/ZlfxKtQplPdJA9ewFsNZwSky+4XYRTAUr+D5j/vQmZsvPdYfHbuqSpVTEhUvb+HqYo4hjVYGLfB/rSDcnXcDCYarbM1lylKyFgPqQwPWEjueMGal+VPNNs4wqNSbFK+4odeitggBfCdT+Ja36rqfU1SCHEMa4nHNQ0KTk6CuaKDCd5igazxIY/FlRTeFHsjzQfyjDliIqzBsMXYg4eH0LcvjIytaDfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhXlEHR4xg2Fxj/zNnfK6RNghHZjx/NzuSGC/4UkbTo=;
 b=hSa5r2K5L9x6i0TK+14Mg4wXgu9JtkUfLfhGN9bGEnRm4/xO/isPuumhQDtF6IXDTuDLODR3f1denKLoZXp2dJI2fBRcbLr+MZOGwuOK4ZWXuwlRouFCsh2IRVjoXvx6UQOVMvjmwGBbBNbGTNZkkFaH1lNVe/Kusk50u/53qaA=
Received: from BL0PR0102CA0052.prod.exchangelabs.com (2603:10b6:208:25::29) by
 MW4PR12MB5628.namprd12.prod.outlook.com (2603:10b6:303:185::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.32; Wed, 21 May 2025 09:51:09 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:25:cafe::c9) by BL0PR0102CA0052.outlook.office365.com
 (2603:10b6:208:25::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Wed,
 21 May 2025 09:51:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 09:51:09 +0000
Received: from FRAPPELLOUX01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 04:51:08 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v1 7/7] drm/amdgpu: include BO dump into coredump
Date: Wed, 21 May 2025 11:49:09 +0200
Message-ID: <20250521094912.6714-7-pierre-eric.pelloux-prayer@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|MW4PR12MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: a87cc6eb-6125-4be2-4b60-08dd984d03a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sjuUlzauTS9i530VrrB18dZGAMJQY2B+kPL72PJi9WVC/MP0Mon3HheibfPH?=
 =?us-ascii?Q?jGj57A6goXIdgKLVzsDbHCBGGpR5ev/TPbjB/sdio8ORqnBc96lXmC13PWY6?=
 =?us-ascii?Q?YMX+L2U5IKqfhiGdJieIE43EboG0aBTUcjtRBqgwHfmhZjelffsJFvdbsn5f?=
 =?us-ascii?Q?bHzxigQmMI/VeSd6VFzEvVKLy227QHO7nRl9Vbn/QKB9eNFMXNzxGSLEOfws?=
 =?us-ascii?Q?CoRqK/dolb3p7jZTRBBQE/luq/DlsIsbI/1d/VnUVgvRXix4+mGXH7lkqlUd?=
 =?us-ascii?Q?CYF2z8q+tjluNShj0YdoxkmzPZjw7C29tGnF/v7WdXLi/AxtRzB6DuDjNMN1?=
 =?us-ascii?Q?HJlivWMqIUc7S3lertK4RtKREQ1i3bGQuhs9j8api/3P7d5V2wnaMH/I5QC9?=
 =?us-ascii?Q?0o0RTieTyiuotPMjlU98l+ZTNPh3TphvHiq0NiBTTI/gcN3371dxUj5VlubB?=
 =?us-ascii?Q?MTwIPTWNFySoll2BZE5krj7oASAs3jbvgqeK5EOUSorW6zAbLox/VTZtWVhH?=
 =?us-ascii?Q?GsoOkQvAGtgcKfX+fWv76KbmYO6fhBCAMEsGhvEdKhbN3okM7ErB29vfiTd4?=
 =?us-ascii?Q?Gcv3cECaLIzFP5pR1BVn2Anhy/Fvo6psoTHJjP9T2N7PuahoBAkHqMDAcedE?=
 =?us-ascii?Q?aqhCVTrRFAJoTf1CIfedO9Qf9fadNmtNSKrlJeET/yUNwtmWOVd875lAsHpB?=
 =?us-ascii?Q?flUs8iBtoaBXX961Bil7rEpR2fJQ6PIQzORwmRfK3x7aTT01YSqexq0bOSQ+?=
 =?us-ascii?Q?gkGZ3nnwSKFkA7nunCeMqSHiPoSL9ZX5/G+KiEnc9PaQEqZwV1Q26CUa1vwH?=
 =?us-ascii?Q?K1vphBKnFQXe9BglfpmWnXqgy5YU9vKTaQXLRjlbCjD0v/XxGdvLt6/NhSUN?=
 =?us-ascii?Q?5KOyr1nVEljfBsvo7iSTDjrOlbKkl4+u9bQgxybcMoTIInoeQWmkA5OSsHNv?=
 =?us-ascii?Q?UsXPTzyuhEO7Dx2e4DbhHUi2A2bb55EWZRf7E+4khjD28HTQkKYCwxotX5Lb?=
 =?us-ascii?Q?NVhjdellbLjfkS+TSSvVTVpLCyBpEiqxsUMwEfSm5qTB1bZd1cgTgXUCzplV?=
 =?us-ascii?Q?e1gqHZpbcPW9MtX2t8zLFgTnEXtxnysVjkkRZNpFWYdW9hpqZgrVTm0nGxlL?=
 =?us-ascii?Q?iqRhIXW/18/mS+W9ZN3d4dKwT0TJ2bDWOAGEwXwiLT/bF4Fu3+Iz/FKW6JoM?=
 =?us-ascii?Q?fAniwCQfK/2d9AtggPdELk43n/Dfg5Jv7UEyW1cRbbmFMQ7SOn4DS7x2dxg6?=
 =?us-ascii?Q?rj/kJwkPVCkczIrxZNAdLW+yI9P6o0dGi2dnmZM5IiDOfcf5Z/hB4nbVKK77?=
 =?us-ascii?Q?kght4NDkXDQu/jw7/aJYCzc/K9RuRfdfC7rHFL0qEzVZiUtkX3mzvdlJ+9gS?=
 =?us-ascii?Q?YGMTcGYFzBLUEJ982JIXg71FIQyvvEYvp6ZOlTqMeDZ5zN7F7pFXXUqPtJ+E?=
 =?us-ascii?Q?KKyXIfpX87Au6S6kcbTPzWBY/bqE2XXnwn+SL/KRz07RIXD5V10eo826b7Oa?=
 =?us-ascii?Q?Urm56nOdD57wHj8tlJvUGUmhL4BFZPiFt3bE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 09:51:09.6779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a87cc6eb-6125-4be2-4b60-08dd984d03a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5628
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

It can be useful when getting a page fault.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 36 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h  |  1 +
 2 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 1dfc5473d2ab..9fa7189bf852 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -319,6 +319,11 @@ __amdgpu_devcoredump_read(char *buffer, size_t count, struct amdgpu_coredump_inf
 	else if (coredump->reset_vram_lost)
 		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
 
+	if (coredump->vm_dump) {
+		drm_puts(&p, "\nVM Dump\n");
+		drm_puts(&p, coredump->vm_dump);
+	}
+
 	return count - iter.remain;
 }
 
@@ -360,6 +365,7 @@ static void amdgpu_devcoredump_free(void *data)
 	struct amdgpu_coredump_info *coredump = data;
 
 	kvfree(coredump->read.buffer);
+	kvfree(coredump->vm_dump);
 	kfree(data);
 }
 
@@ -383,12 +389,42 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 
 	if (job && job->pasid) {
 		struct amdgpu_task_info *ti;
+		struct amdgpu_vm *vm;
+		unsigned long flags;
 
 		ti = amdgpu_vm_get_task_info_pasid(adev, job->pasid);
 		if (ti) {
 			coredump->reset_task_info = *ti;
 			amdgpu_vm_put_task_info(ti);
 		}
+
+		xa_lock_irqsave(&adev->vm_manager.pasids, flags);
+		vm = xa_load(&adev->vm_manager.pasids, job->pasid);
+		xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
+
+		if (vm && amdgpu_bo_reserve(vm->root.bo, true) == 0) {
+			struct drm_printer p;
+			struct drm_print_iterator iter;
+			ssize_t vm_dump_size;
+
+			iter.data = NULL;
+			iter.offset = 0;
+			iter.remain = AMDGPU_CORE_DUMP_SIZE_MAX;
+
+			p = drm_coredump_printer(&iter);
+			amdgpu_debugfs_vm_bo_info(vm, &p);
+
+			vm_dump_size = AMDGPU_CORE_DUMP_SIZE_MAX - iter.remain;
+			coredump->vm_dump = kvmalloc(vm_dump_size, GFP_USER);
+			if (coredump->vm_dump) {
+				iter.remain = vm_dump_size;
+				iter.data = coredump->vm_dump;
+				p = drm_coredump_printer(&iter);
+				amdgpu_debugfs_vm_bo_info(vm, &p);
+			}
+
+			amdgpu_bo_unreserve(vm->root.bo);
+		}
 	}
 
 	if (job) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
index 38ccdd3d6213..bc8d71219bc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
@@ -39,6 +39,7 @@ struct amdgpu_coredump_info {
 	bool                            reset_vram_lost;
 	struct amdgpu_vm_fault_info	fault_info;
 	struct amdgpu_ring              *ring;
+	char *vm_dump;
 	/* Readable form of coredevdump, generate once to speed up
 	 * reading it (see drm_coredump_printer's documentation).
 	 */
-- 
2.43.0

