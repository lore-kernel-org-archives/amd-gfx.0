Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3499AFA3741
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 16:25:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3032A10E2F0;
	Mon, 31 Oct 2022 16:25:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1DD210E2F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 16:24:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8oPd/ZNBAIw+l5lr3l4+jQqc5+47roRZktDYx7ADKSZbq7l7rOaJD2IHmIf38qdGBb47VQOUVIVAK4lAoJt+l9o4RRzjw9BZe7uC6KP1wWEbdO+tKgieJHxpKocaBw6YE5sFpZnt38su0jOma9wvlvFsNjNixcUHljyigDmdPE9wJcWpFAGEtNHW9mnrrqe1NAPBQSaA2FTTmromKZxfN64uzshUbuAFZnj+XQMWOJ/KCAA3Z3Q1pod4FznYtq21YnKlWtuMmwPPU9QsJI2UN6xEgX+cN9FEOvRGO+UnEnuDoq9tlZdZOUWi7rVxRQYAAHJhngLd+7/7Kk8zORYdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsAC3vVpr7poSm+HX0peNtoiGPJouRd0gzvGuDHa9iY=;
 b=MkaBTwyCE2EyQh6N9HyBt1N8uO2aXTNraH488WJjVcD9tX165iOzC51gOo1OEABEwZoM7Oqd/ZPAPnKZNjEjs7mrE0/rNAngeHDmJjbesn8vPrLVm89dGqlUPrtbKGHekKM7FE5bdTAiteOlIdByYQC1S3FzF8WhE590BXsMb5eiJHjkFgbNd6f36ABkenimwQcjzCX0ve+LJdEug0SM013BuOz8ephPOqNohKQntRX54QaSje8CYAv3Q2npvmnzTiPlwxNqaDaYMrR6lP7Fc78vidXeCpjZXN0vObonZPaVD8c0B3cL6psLTRQGh+sTcrVVxNU/HtJmicL2lR82xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsAC3vVpr7poSm+HX0peNtoiGPJouRd0gzvGuDHa9iY=;
 b=b+0HkuS4Y6Zf1BjS3pxppy5vNqG71IiUa+kbm7PsPz0vCnvv2fVTGjuzfU/Jv44clowVl6gkjUVAhThRl3DlveVsPI6DyOgg0Np65Vegvm7eAsfjW21mLk1xD+7GwfbEaFBw7shyHsAGwVhvuaCy8SOJbdZx/CT3bXUh+ZJ1gMQ=
Received: from MW4PR03CA0231.namprd03.prod.outlook.com (2603:10b6:303:b9::26)
 by PH8PR12MB7232.namprd12.prod.outlook.com (2603:10b6:510:224::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Mon, 31 Oct
 2022 16:24:35 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::e8) by MW4PR03CA0231.outlook.office365.com
 (2603:10b6:303:b9::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Mon, 31 Oct 2022 16:24:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Mon, 31 Oct 2022 16:24:34 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 11:24:31 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/29] drm/amdkfd: add debug device snapshot operation
Date: Mon, 31 Oct 2022 12:23:58 -0400
Message-ID: <20221031162359.445805-28-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031162359.445805-1-jonathan.kim@amd.com>
References: <20221031162359.445805-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT004:EE_|PH8PR12MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 6734ac89-052d-4c83-4853-08dabb5c65e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x9/RZ2vv7l2p6gBN1BiAbBtE9/hNVdJe3F3VSnL7HUSV95chbGQ0k1RvgyhVSenWHzpjNuK4BRnWLpvLUPNsyvXhpnShNg6h/2ewQxxO8snjKJZoURmLI34ZVBuCBAJ9qHIjW+kpCWGP/NU4OrdrKW+Aemc3zwdx2D1U4jd+d0p3Z78espXCnZ7pJTxNB14vwujg+tajhc4VUGXLUIlw7lq06KB9aPHm8CEEmINhk9X1MYMqCvzVsRBkq9nk5dWbyW5+ET5n3JmgjQxiemKhmkyYOuJSURgqTIsZK1R9iUt+2KkoANLDP0stmeEL0LecQboO52uA8MPHyuQZhsoFK1Z89MTLSSOJM+262FBpSaRaKtw5NtrixTTedoONF1LZ/GdZLXcl17d1QxDC9aJP91pdYiXDSemTw2eR1L6T0a2/Y6TYJl3hUDrl6HFogAy/8t/oEqgGoaHrNGJSD/oUel3mIRxG1c4SnYeae6vr02r8E0AlcyN1vEJVUhu3j31RfAMlAIO7tNFakmkb7xuhAZwmdQWw9hByDD2wlCXlUUseeaHmS0/l4z5zgJOQcinEUrzXqmXgVCTMrziwwPrNqqMIuc5LMKw1kYLA22cgWBtfNJ/sXR1XVZTRKc7jGLEwGCAb6VKBy84ZAzRS+PZJCVo2//7YHvCrBYQA28AYq0ZxREAk7sm4QD6wW5JUe+JxX519NgsPRtIhy621HnDh0Zczq71b2WNgOotMAAuU8pHaoobRduslnkYduSKDYfOf5qGxu/V8BqyBfl3d1c0cvEC+6/Q8yZyimPzaTD2P1PI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199015)(40470700004)(36840700001)(46966006)(40460700003)(36756003)(82740400003)(186003)(36860700001)(16526019)(8936002)(2906002)(44832011)(86362001)(4326008)(5660300002)(81166007)(26005)(83380400001)(47076005)(426003)(336012)(356005)(8676002)(2616005)(478600001)(40480700001)(41300700001)(316002)(1076003)(7696005)(70586007)(82310400005)(6916009)(6666004)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 16:24:34.5432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6734ac89-052d-4c83-4853-08dabb5c65e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7232
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Similar to queue snapshot, return an array of device information using
an entry_size check and return.
Unlike queue snapshots, the debugger needs to pass to correct number of
devices that exist.  If it fails to do so, the KFD will return the
number of actual devices so that the debugger can make a subsequent
successful call.

v2: change buf_size are to num_devices for more clarity.
expand device entry new members on copy.
fix minimum entry size calculation for queue and device snapshot.
change device snapshot implementation to match queue snapshot
implementation.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  7 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 67 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h   |  5 ++
 3 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index cea393350980..115a80686f7a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2968,8 +2968,11 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 				&args->queue_snapshot.entry_size);
 		break;
 	case KFD_IOC_DBG_TRAP_GET_DEVICE_SNAPSHOT:
-		pr_warn("Debug op %i not supported yet\n", args->op);
-		r = -EACCES;
+		r = kfd_dbg_trap_device_snapshot(target,
+				args->device_snapshot.exception_mask,
+				(void __user *)args->device_snapshot.snapshot_buf_ptr,
+				&args->device_snapshot.num_devices,
+				&args->device_snapshot.entry_size);
 		break;
 	default:
 		pr_err("Invalid option: %i\n", args->op);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index a05fe32eac0e..8d22a27cc062 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -22,6 +22,7 @@
 
 #include "kfd_debug.h"
 #include "kfd_device_queue_manager.h"
+#include "kfd_topology.h"
 #include <linux/file.h>
 #include <uapi/linux/kfd_ioctl.h>
 
@@ -888,6 +889,72 @@ int kfd_dbg_trap_query_exception_info(struct kfd_process *target,
 	return r;
 }
 
+int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
+		uint64_t exception_clear_mask,
+		void __user *user_info,
+		uint32_t *number_of_device_infos,
+		uint32_t *entry_size)
+{
+	struct kfd_dbg_device_info_entry device_info = {0};
+	uint32_t tmp_entry_size = *entry_size, tmp_num_devices;
+	int i, r = 0;
+
+	if (!(target && user_info && number_of_device_infos && entry_size))
+		return -EINVAL;
+
+	tmp_num_devices = min_t(size_t, *number_of_device_infos, target->n_pdds);
+	*number_of_device_infos = target->n_pdds;
+	*entry_size = min_t(size_t, *entry_size, sizeof(device_info));
+
+	if (!tmp_num_devices)
+		return 0;
+
+	mutex_lock(&target->event_mutex);
+
+	/* Run over all pdd of the process */
+	for (i = 0; i < tmp_num_devices; i++) {
+		struct kfd_process_device *pdd = target->pdds[i];
+		struct kfd_topology_device *topo_dev = kfd_topology_device_by_id(pdd->dev->id);
+
+		device_info.gpu_id = pdd->dev->id;
+		device_info.exception_status = pdd->exception_status;
+		device_info.lds_base = pdd->lds_base;
+		device_info.lds_limit = pdd->lds_limit;
+		device_info.scratch_base = pdd->scratch_base;
+		device_info.scratch_limit = pdd->scratch_limit;
+		device_info.gpuvm_base = pdd->gpuvm_base;
+		device_info.gpuvm_limit = pdd->gpuvm_limit;
+		device_info.location_id = topo_dev->node_props.location_id;
+		device_info.vendor_id = topo_dev->node_props.vendor_id;
+		device_info.device_id = topo_dev->node_props.device_id;
+		device_info.fw_version = pdd->dev->mec_fw_version;
+		device_info.gfx_target_version =
+			topo_dev->node_props.gfx_target_version;
+		device_info.simd_count = topo_dev->node_props.simd_count;
+		device_info.max_waves_per_simd =
+			topo_dev->node_props.max_waves_per_simd;
+		device_info.array_count = topo_dev->node_props.array_count;
+		device_info.simd_arrays_per_engine =
+			topo_dev->node_props.simd_arrays_per_engine;
+		device_info.capability = topo_dev->node_props.capability;
+		device_info.debug_prop = topo_dev->node_props.debug_prop;
+
+		if (exception_clear_mask)
+			pdd->exception_status &= ~exception_clear_mask;
+
+		if (copy_to_user(user_info, &device_info, *entry_size)) {
+			r = -EFAULT;
+			break;
+		}
+
+		user_info += tmp_entry_size;
+	}
+
+	mutex_unlock(&target->event_mutex);
+
+	return r;
+}
+
 void kfd_dbg_set_enabled_debug_exception_mask(struct kfd_process *target,
 					uint64_t exception_set_mask)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index 58a5f14d1258..d8c0c54fffa3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -80,6 +80,11 @@ static inline bool kfd_dbg_is_per_vmid_supported(struct kfd_dev *dev)
 }
 
 void debug_event_write_work_handler(struct work_struct *work);
+int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
+		uint64_t exception_clear_mask,
+		void __user *user_info,
+		uint32_t *number_of_device_infos,
+		uint32_t *entry_size);
 
 void kfd_dbg_set_enabled_debug_exception_mask(struct kfd_process *target,
 					uint64_t exception_set_mask);
-- 
2.25.1

