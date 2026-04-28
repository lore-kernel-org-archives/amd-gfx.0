Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB63FF8868
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 10:03:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAAE710EAEF;
	Tue, 28 Apr 2026 10:03:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SpwtdYf9";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E66610EAEF
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 10:03:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYntzVJsIRkitm/PvmOW5RSF3Vic4J4VulLVdIFHpktZ5GTFGJv8sAWJR/vvv+fsJdTNe0QaY+j4KaKASd+J9tbPJVtEalc/xDcx9uCHc+vFZixNefwUScGLSkJGh2Qb5HKWluhXAwMdrM9K3YrmKIgtb2L+kX+MXQgp0e8ymd/8xoqsqxnBfATK+pblGusTk+a+S4XB1gvEt+uhVvBuAUFB7gVlPI0RT6P7+pce/flr71wWrram93IwHv1Nsv7cyAM7oUHTDloQFBJ37a8VVOaFZCSbOlrjK9S74gvk89gIAZnBqPaDH03n7GFt030fDTqbcQdPwbon5YaUaRVdwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rROGEJYaJL0aNeD13YaciktmqkAz7mrTiIZ36h/dvZE=;
 b=klA902pCYA++HdsKhlpyr/12vsmIc4adq5lLaVE4AwUy7Cz6E1i6N5MLGUstU50jf/al/muGos57CWBb2xqt3kTJSzSD0BRSPw23QyfuSqRuPJWK2IJX0mfo72ukWq/qpuPUH3mJLeIwl4tA9WkCC2kSP98nv41aUrDE2zjAXpIYwYW67/SjmPyaadg00KuCJspzfomr7URkc7ltkSMUGLkBxwDj0QZnsYq5dcvdvwnXobSXgv7wlgg+X+ZeHkFfUs9zYOn2OAOAcBZzfr++EjTKOAH+7ESIMrguxGQAIQAxQjRtDXX5oGeM+g7omdtaXf3QiAB13E/NrtQG+NAZgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rROGEJYaJL0aNeD13YaciktmqkAz7mrTiIZ36h/dvZE=;
 b=SpwtdYf91YyOWVgXttYxKN74z8QmZSqtnID/67jYltslC1Kjc1OeDei2f8IhUzV5kBp0giAeBNApUIUuT4g1cqiwW16TfCeABV4XnZdz14eIXZeODd0LkidfP7KHEo5IcH3paMql3NTGrdKGmC6w+MMylKTmqAJ/s/fPJAynBKo=
Received: from BY3PR05CA0026.namprd05.prod.outlook.com (2603:10b6:a03:254::31)
 by MN2PR12MB4317.namprd12.prod.outlook.com (2603:10b6:208:1d0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 10:03:18 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:254:cafe::6) by BY3PR05CA0026.outlook.office365.com
 (2603:10b6:a03:254::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 10:03:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 10:03:17 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 05:03:14 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Apr 2026 05:03:02 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, "David (Ming Qiang) Wu"
 <David.Wu3@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v3 05/11] drm/amdgpu: add AMDGPU_INFO_USERQ_DOORBELL ioctl
Date: Tue, 28 Apr 2026 17:58:46 +0800
Message-ID: <20260428100239.1609179-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260428100239.1609179-1-Jesse.Zhang@amd.com>
References: <20260428100239.1609179-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|MN2PR12MB4317:EE_
X-MS-Office365-Filtering-Correlation-Id: df491410-273a-47a5-f0e8-08dea50d5ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|56012099003|18096099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3CoM0hOTyARTLmwDmQjTd6f68kTCAclOK6XF+UCbj0ZYojoZM/cWqfGTP3ZArY4iuMJNd6NJHa1F2bJMEGIA4lELtFYzj2ngVnEva07V+IuWEHOcolAoFW718u7O7G1t06JX09n8upOiXUazp2w+Cuk1vzCq4JpbxXhgKpwherlazicS78MoRlIACOEyFjg1tkjoCMzcB8YMoopThfP215sBnEjv3Dp8/WGDjJRhUA0HYg2M4I+w/AGqR1fyzTTIvln+gtbgtEEPV/9MrHihwl32z6DRVp+WpnYZat4gai2i9L4RKu8r9wNgoj3qXMaZXQQzsqdwn1R5vvq0Yo8vdBXY/X3p1jNtmoNgM0ZGtxkua3Yw7R4lkhOdBb+8SGd9EhToy24qtANSvdwh1qg4qbwsoXVCAjlcjV1jiA8GHxU9z+zmYHcvRcKYlyZk0LPFR6Do64sn6LptIUrTQfHE8A63dwi6HgZoGceMIK7c5lPd439wHb219hm3ghHH43gwJ0qjb4khSeGS2MToIL4VOEEA4exgN/G4RCdhn0nf1uC8Q6ONVAm8vfmhPhISGmMdNCoB2FlqQl8GdPmxBWxxSAnuL06fPTSLr8m7fnL9lZQScLIvkxxtJbrZXQ1iy9/o1MNmWL64bEqs2Lt4gE8/2L00ysdqgaeiTpJKjUTyPM614iXK2bKZ2lEmoK+8XgGTs6wVWD1fzA5IJbXVHztauDqg4rOnW0dB6SCLnPPSzha3z81WOx1TqLBHTYiaIgpstXbDCOudIWL2s4K0vVa9TQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099003)(18096099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZWO31LgUkIDOo85f95LC89N3JR5ph54ywTF0AWaqMN0BzskDt+R+iC8pGuMGk57E3SzUkzaJtOdQSepF48JiLRN3ntbIQz9CPYEVDSRSNZsGdpZe8aLNuqRE8bMRuZJvBB9yL3aPAq/1uZwZV1eSo7rFcekT/myKu/iWTPJnCO5oA6XfL25juprLLx7tbg7JjIaI9LcfYHFseR6zUwSyW4KZQkdVPuhC+YTRH6L4EsHyMKzkMrvKMV5HNYCuLAmRbhuZ5N8wX3t2StK3C7AFqB5YUP5BOwN0zPenJN+8lqKITqiq4SIKVZi8sx5QtALQNL1blB3kj3yx0Pghvbu4VfYqZ9A7m2nDVSc/G75l7abCn5BC4+gzwdPwNAT4MzkECC/KRxzzn4NwC0wn8ctN5DNzZiADnkDhzMomaerRIzgt9tcMj61c94ZyrALs4n1r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 10:03:17.3233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df491410-273a-47a5-f0e8-08dea50d5ea9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4317
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

From: "Jesse.zhang" <Jesse.zhang@amd.com>

Per-IP doorbell layout query.  Input: info->query_hw_ip.type selects
the IP (AMDGPU_HW_IP_GFX / COMPUTE / DMA / VCN_ENC).  Output: the
doorbell-BAR dword range usable by usermode queues for that IP, the
aggregated doorbell offset (when MES owns one), and — for
AMDGPU_HW_IP_DMA only — a fixed mmap pgoff sentinel plus byte size of
the kernel-owned routable SDMA doorbell window.

For SDMA usermode queues the kernel hands out doorbell slots from the
per-device pool (the only BAR range whose writes are routed to the
SDMA back-end) instead of accepting user-allocated doorbell BOs.  The
returned mmap_offset is the AMDGPU_USERQ_DOORBELL_MMAP_OFFSET sentinel;
userspace mmap()s the drm fd at that offset (no GEM handle, no
drm_gem_object_lookup() consumer can ever reach this window) and the
per-queue qword-slot offset inside the mapping is reported in
drm_amdgpu_userq_out.sdma_doorbell_offset_bytes.

amdgpu_drm_mmap() (a thin wrapper installed in amdgpu_drv's
file_operations in place of drm_gem_mmap) dispatches on the pgoff:
sentinel hits go to amdgpu_sdma_userq_doorbell_mmap() which does
io_remap_pfn_range() straight into the SDMA decode window; everything
else falls through to drm_gem_mmap().

V2: Picks up David Wu's [PATCH 11/14] AMDGPU_INFO_DOORBELL design (struct
    shape + per-IP dispatch) and extends it with the SDMA-only mmap_offset/
    mmap_size fields.

Cc: David (Ming Qiang) Wu <David.Wu3@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 16 +++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 35 ++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           | 40 +++++++++++++++++++++++--
 3 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index c6546a858597..6e0acd761e94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3023,13 +3023,27 @@ static int amdgpu_flush(struct file *f, fl_owner_t id)
 	return timeout >= 0 ? 0 : timeout;
 }
 
+/*
+ * mmap dispatcher.  We override the standard drm_gem_mmap because the
+ * SDMA UMQ doorbell window is reached via a fixed sentinel pgoff
+ * (AMDGPU_USERQ_DOORBELL_MMAP_OFFSET) — it has no drm_gem_object so
+ * drm_gem_mmap()'s vma_offset_manager lookup would fail.  Same pattern
+ * as KFD's KFD_MMAP_TYPE_DOORBELL.
+ */
+static int amdgpu_drm_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	if (amdgpu_sdma_userq_doorbell_is_our_pgoff(vma->vm_pgoff))
+		return amdgpu_sdma_userq_doorbell_mmap(filp, vma);
+	return drm_gem_mmap(filp, vma);
+}
+
 static const struct file_operations amdgpu_driver_kms_fops = {
 	.owner = THIS_MODULE,
 	.open = drm_open,
 	.flush = amdgpu_flush,
 	.release = amdgpu_drm_release,
 	.unlocked_ioctl = amdgpu_drm_ioctl,
-	.mmap = drm_gem_mmap,
+	.mmap = amdgpu_drm_mmap,
 	.poll = drm_poll,
 	.read = drm_read,
 #ifdef CONFIG_COMPAT
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index d88e4994c8c1..63e387bb691a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1425,6 +1425,41 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			return -EINVAL;
 		}
 	}
+	case AMDGPU_INFO_USERQ_DOORBELL: {
+		struct drm_amdgpu_info_userq_doorbell db_info = {};
+		u32 agdb = adev->enable_mes ?
+			adev->mes.aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_NORMAL] : 0;
+		int r;
+
+		switch (info->query_hw_ip.type) {
+		case AMDGPU_HW_IP_DMA:
+			if (!adev->sdma.userq_db)
+				return -ENODEV;
+			db_info.index_start =
+				adev->doorbell_index.sdma_engine[0] << 1;
+			db_info.index_end = db_info.index_start +
+				adev->doorbell_index.sdma_doorbell_range *
+				adev->sdma.num_instances - 1;
+			if (agdb) {
+				db_info.agdb_enable = 1;
+				db_info.agdb_offset = agdb;
+			}
+			r = amdgpu_sdma_userq_doorbell_get_mmap(adev,
+					&db_info.mmap_offset,
+					&db_info.mmap_size);
+			if (r)
+				return r;
+			break;
+		case AMDGPU_HW_IP_VCN_ENC:
+		case AMDGPU_HW_IP_GFX:
+		case AMDGPU_HW_IP_COMPUTE:
+		default:
+			return -EINVAL;
+		}
+		return copy_to_user(out, &db_info,
+				    min((size_t)size, sizeof(db_info)))
+			? -EFAULT : 0;
+	}
 	default:
 		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
 		return -EINVAL;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 79e8bbda046b..458219a42da3 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -423,9 +423,10 @@ struct drm_amdgpu_userq_out {
 	__u32 _pad;
 	/**
 	 * For SDMA usermode queues whose doorbell was assigned by the
-	 * kernel from the per-device pool (see AMDGPU_INFO_SDMA_USERQ_DOORBELL),
-	 * this field carries the byte offset of the assigned slot inside
-	 * the routable doorbell window so userspace can write there.
+	 * kernel from the per-device pool (see AMDGPU_INFO_USERQ_DOORBELL with
+	 * AMDGPU_HW_IP_DMA), this field carries the byte offset of the
+	 * assigned slot inside the routable doorbell window so userspace
+	 * can write there.
 	 * 0 means the kernel did not override the user's doorbell.
 	 */
 	__u64	sdma_doorbell_offset_bytes;
@@ -1280,6 +1281,39 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 #define AMDGPU_INFO_GPUVM_FAULT			0x23
 /* query FW object size and alignment */
 #define AMDGPU_INFO_UQ_FW_AREAS			0x24
+/*
+ * Per-IP doorbell layout query.  Input: info->query_hw_ip.type selects
+ * the IP (AMDGPU_HW_IP_GFX / COMPUTE / DMA / VCN_ENC).  Output:
+ * doorbell-BAR dword range usable by usermode queues for that IP, the
+ * aggregated doorbell offset (when MES/UMSCH owns one for the IP), and
+ * — for AMDGPU_HW_IP_DMA only — a per-fpriv GEM handle for a
+ * kernel-owned BO that backs the routable SDMA doorbell window so
+ * userspace can mmap() its assigned slot.
+ */
+#define AMDGPU_INFO_USERQ_DOORBELL			0x25
+
+struct drm_amdgpu_info_userq_doorbell {
+	/* BAR dword index of the start of the per-IP doorbell range. */
+	__u32 index_start;
+	/* BAR dword index of the last doorbell in the range (inclusive). */
+	__u32 index_end;
+	/* 1 if an aggregated doorbell exists for this IP. */
+	__u32 agdb_enable;
+	/* If agdb_enable, BAR dword index of the aggregated doorbell. */
+	__u32 agdb_offset;
+	/*
+	 * AMDGPU_HW_IP_DMA only: per-fpriv GEM handle for the kernel-owned
+	 * BO backing the routable SDMA doorbell window.  Userspace mmap()s
+	 * it through the standard AMDGPU_GEM_OP_MMAP / mmap() flow to get
+	 * a CPU pointer; each created SDMA usermode queue's qword-slot
+	 * offset inside that mapping is reported in
+	 * drm_amdgpu_userq_out.sdma_doorbell_offset_bytes.  0 for IPs that
+	 * do not need a kernel-managed doorbell BO.
+	 */
+	__u64 mmap_offset;
+	/* Byte size of the mmap region; 0 when mmap_offset is 0. */
+	__u64 mmap_size;
+};
 
 #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
 #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
-- 
2.49.0

