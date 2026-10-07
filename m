Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5F2CA5FFC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 11:05:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1361910F184;
	Wed,  7 Oct 2026 11:05:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v9jTutcw";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013070.outbound.protection.outlook.com
 [40.93.196.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DAF310EEF5
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 11:05:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2O3py5/mrGLnlKVBgA9UbmFfnKroG4W/BV+2DDI/80cWe2Tc9V0KDin/XbQX8AgLHpqLiPi9FI8VncWH3W53s+cgTj9W1DZSU+YDJNo4lww+lUYA4Dq/iwFnYZXVt7v4N6Mt5WWDAJ1e4Ov0hF7AS3Jb6E/ySZxuRXbNWAckhvmCywMLNq5rdIgdzLCs1Z4ER1csZHa4D6DYmmgq669pFXfjKTN/0yYkBwh3Am7u40sSqLOnyckW8EnGTk9KdxPJxe7dbDTY3WP+1ObxbMFbcETbS8oaGjCnHQ6BmAz3Dg8/KXXDeVSN7Id4nyHrZ1ysaAE6cvP1iL6+8GdjwHFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79LGrNdUw/MjKP/lVXidndn+8FusFdNjuhe+3CWOJb4=;
 b=OMMOAlEtRNf0FzjUMlk9d6czYudv4duAv9YteuzmfvoD5kng1m1rmxmq/ndjGT498fb57b3H6MSOB0lm7sVwHpbBovyZp8zTi+LuHii6w7C1vsu2xoo/iZOj6cqOUqiIv313ZtAFSuSfS0Dx1jmUf3RRtHEOcdOV72GCUCNA3URDHLI495jZsQGAAAIovSLUX4LwgE3cTv7/par3yRHTLDXsvKG28FI7wgb/LC8JeMRPtPyILL2Jn3286DtUGsYJzuzkK88jYhGfQNR+6qpMPufNTsfRx2AwS5/Mmi6kTkWsZmMCQ8sKDt5+aygT8GY8Xx1lBxjllvpaoSDAscsJqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79LGrNdUw/MjKP/lVXidndn+8FusFdNjuhe+3CWOJb4=;
 b=v9jTutcwShpf5OnU881GOG/ygzVzK/euZO4IuMyPFo3WW8hwxLJJpJuutUb7QSbGc7c7W0KCMkO9NRWMU4vsHxf8HQRafw3qXkfrROypGQDtkhLnhVZ1IULTO/W7/P8eD/HVDSqOC+qiWVP5troGZgNny7jGx1Snz9uxL0SbGyU=
Received: from MW4PR04CA0068.namprd04.prod.outlook.com (2603:10b6:303:6b::13)
 by SJ2PR12MB8979.namprd12.prod.outlook.com (2603:10b6:a03:548::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Wed, 7 Oct
 2026 11:05:33 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:303:6b:cafe::1d) by MW4PR04CA0068.outlook.office365.com
 (2603:10b6:303:6b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 11:05:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 11:05:32 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 06:05:30 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH 5/9] drm/amdgpu: Add ioctl to get cwsr details
Date: Wed, 7 Oct 2026 16:35:02 +0530
Message-ID: <20261007110506.1065076-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007110506.1065076-1-srinivasan.shanmugam@amd.com>
References: <20261007110506.1065076-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|SJ2PR12MB8979:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d4f25d-7431-4ffe-9ad2-08df2462e809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: RxkjZqbgCH3fOm2U1v+Hb/M7CMlPVOiI3w720fruMLm330JEqMooMD23ks+9wziffeuiYIkZ5q5L2UY18eaWw+newa9+NluRMm5JTbcHxNfSx2XvaZoobUHNWAOui/9TVRMshzbf+lhMx5dlHubkVD8I3XIzaF/vHQlC75yA2pFN6HjupSNlU+fE2KO7yAUCdVX750YLdwDpeETuKhYaJyDiR8/nRiiVG6nMXSl7W3335c48tpMeVS7PqHAn9s8a1lZVDed4NbLqyGljwULWGEAXmJbG7Pja/V/1K36s80FIF2yX/XhKqX6lOPDzky/m6L3B6XDuWiZfAGYTblzB5pS7tbG3S/6YFxyAEhFuTPgnV0aXczzFmdXeVJDOVJ7D8+1fyNv1/vcCy+Z7vct3W5v5/End9Vv7YB/DbQbr5nmuixAG6uuNaybzYhqieFuJATQtlkuCSzY3ItY7YQD3+u9t9kcNnaBIyqNQev7nub45vdduD9F8spathPBHIupcDO4tMVANicCFFZjeEX7LIWEFaOFH5pubOAVgZ0nDQ801j2DE4aPaCIiSLU7FMgD/oxfscBBEJP5k/WaZu1wVKX6BG6Jn31JgZdhDWJ/kfWp6ltRKEL1h2AV3sZIQKEFdOOl+rq+keYyIZcuzToGCbsxU9wefNg+GfuhoxzxaQr2elJweSBUYBrwm0dfHhIFzi6SA7Qe9nZgxTvlPSnWOsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +5fJL+VfDN/S7rYFAi/k1PWyKm6no0PLfq6wEYHNOAF4aDljxX6zFzHsb2xU51M1IbK+qgF7pWJW6a+NDW/927M2K/53ZlpYYUGyfueA7ukVxOUVbDBNuCkChaUpy+MKDJQ0+CuLGSlxf1EtsosxNsrZVjWRUQk1rnfHxYVUTaCewkhe9Ux6PzDEIV2L9Yxdmeb4hjuU0aLBHybmdXvHxYY2yVKVtR+s6QdHtULjTp8eO/HYsGFCb9+7mbz1L5TFseyJ420fKNWOySnILVkkxQs9YHHQ8zXwpy7SQF0oLacCaeg2y3a1II8CG7esFFBS9EsuLESOXBYeExThC5Z8Hbp2FYFl1wQAnCUWD5lXJMmoZ2lPPNfqoDyjh1Hx90dgNoogBjkS+kU5nK8g4aXznLYcDDCHCrykz0TaSugk+zq6+jCA6LIyA6pGoCESEDz1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 11:05:32.7197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d4f25d-7431-4ffe-9ad2-08df2462e809
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8979
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

Add an ioctl to return size information required for CWSR regions.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Change-Id: I50943895ae802ab08138566bf4f14542ad2ced07
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 21 +++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           | 16 ++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index f3945b3988d8..147c0bd02731 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1429,6 +1429,27 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			return -EINVAL;
 		}
 	}
+	case AMDGPU_INFO_CWSR: {
+		struct drm_amdgpu_info_cwsr cwsr_info;
+		int num_xcc, r;
+
+		fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
+		if (!amdgpu_cwsr_is_enabled(adev) || !fpriv->cwsr_trap)
+			return -EOPNOTSUPP;
+		num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
+		cwsr_info.ctl_stack_size =
+			adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
+		cwsr_info.dbg_mem_size =
+			adev->cwsr_info->xcc_dbg_mem_sz * num_xcc;
+		cwsr_info.min_save_area_size =
+			amdgpu_cwsr_size_needed(adev, num_xcc);
+		r = copy_to_user(out, &cwsr_info,
+				 min((size_t)size, sizeof(cwsr_info))) ?
+			    -EFAULT :
+			    0;
+		return r;
+	}
+
 	default:
 		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
 		return -EINVAL;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 29009f6aabde..527199e4de9b 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1289,6 +1289,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 #define AMDGPU_INFO_GPUVM_FAULT			0x23
 /* query FW object size and alignment */
 #define AMDGPU_INFO_UQ_FW_AREAS			0x24
+/* query CWSR size and alignment */
+#define AMDGPU_INFO_CWSR			0x25
 
 #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
 #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
@@ -1668,6 +1670,20 @@ struct drm_amdgpu_info_uq_metadata {
 	};
 };
 
+/**
+ * struct drm_amdgpu_info_cwsr - cwsr information
+ *
+ * Gives cwsr related size details. User needs to allocate buffer based on this.
+ */
+struct drm_amdgpu_info_cwsr {
+	/* Control stack size */
+	__u32 ctl_stack_size;
+	/* Debug memory area size */
+	__u32 dbg_mem_size;
+	/* Minimum save area size required */
+	__u32 min_save_area_size;
+};
+
 /*
  * Supported GPU families
  */
-- 
2.34.1

