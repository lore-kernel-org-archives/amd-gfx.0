Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE00606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bdsp16G6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5039710E1BE;
	Thu, 22 Oct 2026 16:18:52 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 563541127A7
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 16:18:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oE0Px/4cAQTecfWUV6KJRPWIFVF1FNSSzwli9YlLpXH/TXeyW7HjuDgYGb+8+5obWl3b36RPRVSe6/m03eOfJlNfyt+y7OCFQ9dBIcSFjNRL6a3E3Am8FKOm9uO0Z3Xxp50bfo2ofuU5jDyw0erqcc8nWppIbMkm64pSqaXSrw9+s30GSKp+CP6TDTCoMUfSkkqic4M4OBpFbQ1ga7r5OzhXtPr0VhJmCbR0raCH4VunkrouyxPY2LF4aairSNKaGITAnln/C4a1hV3Oi+OWENttO97XiwrcdqIsLI+Nfe+/4tmUFS9f6XU1NgwRxmfru8htMaDo0W9CwfJx0OGVpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hl7iOg5uzB4qNYSFQYZ5jpNUtnsj9xG7McoONTZ+uAE=;
 b=O2sqgAXDzILIJ2d9BCWOxv41eREfGdQfvljefqFZE7rm+6u+v9GDfsadPNa0ukX5o6g+PV0Rpsc4lto/XkEJpDAxmgtKncD06sCrc/BDD0XY5VAtVQUdN8otuIIHA1ac0RSYRnlaaVg6GC9LMqDY0xQ5qVVKx05QDR/f39Utlb9/whLoCV6SoeA5wtbeyvqpBhAo9edOm89BhLAAB388wLWpFDHZUqCzqZPbfVlzSfGGlwyfTHMVQ+PhRouxiG9i8H01bf550AkivEl8RtGWMfWkoP7yT+spJsK1vnIolB/fSMF75h1dTnyDvguaVURa1xdv4var17NYx40eXhs0lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hl7iOg5uzB4qNYSFQYZ5jpNUtnsj9xG7McoONTZ+uAE=;
 b=bdsp16G63afPR9Ghwpvq1xH46uc8Cvk9JwBdyK2vmQF3aQK8q+RzHIqud/7IjUQ2wj78HgRq24iTTkq+8bmmZaQ+jR3GT94dYjg6zA6GGP52gLE/s+IgszJ6/S5eN+fmaOwMAEnR17pWUeD7Al/cetHHb7aKrjwgdWa+yAtuKZo=
Received: from PH8P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::10)
 by CH8PR12MB666014.namprd12.prod.outlook.com (2603:10b6:610:32d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 16:18:41 +0000
Received: from CO1PEPF00012E83.namprd03.prod.outlook.com
 (2603:10b6:510:2db:cafe::1f) by PH8P223CA0007.outlook.office365.com
 (2603:10b6:510:2db::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17 via Frontend Transport; Thu,
 22 Oct 2026 16:18:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E83.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 16:18:39 +0000
Received: from siweihe2-Desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 11:18:39 -0500
From: Siwei He <siwei.he@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <harish.kasiviswanathan@amd.com>,
 <mukul.joshi@amd.com>, Siwei He <siwei.he@amd.com>
Subject: [PATCH] drm/amdgpu: add AMDGPU_INFO_CU_BITMAP query for per-XCC CU
 masks
Date: Thu, 22 Oct 2026 12:18:22 -0400
Message-ID: <20261022161822.758057-1-siwei.he@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E83:EE_|CH8PR12MB666014:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b07bcc-3551-4ac4-e9d5-08df30582254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|18002099003|11063799006|261009223027099003|261021121427099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: ekhvq+ggDq1nqTrjSOJ4unhDv5arN+HwTJhtZzwoOFrs8aZuE+16SyVAglAa/017YGwMye2OSUT8zVX/sH+st1EkXtO/JbU4kD2LpQXIqm98dBUDN/UtADhWZY0qbjmIjcchQ3iON13NBxf1Ui0YVK27LhqloXLWfgTVSyW/M0sMwxFLSktUAcZYsCj9mBHP/j91Spv1an5nPaywdcsEIavKkEMpS0ydkH+i6kua9gICkxq+Vs0qyRRN0IXNjvmqYR+BvTGjdImZfo5BeZOcjuEb6NDi1wlJGLDHxscNii2vZJi8xZW7KU7QxgBzWtiYdY/j+ZRpuQ8feRJcMiCdOoOcMQ5KjYD/NS+mUIabrJLTlO7voGHi6927q/+2IhrGS7aTLObb+4Bflim3RqdNsh1T4eiEAmSnGVWbvK3MpcPUIbbDIj2nu/F8ZZvjX8fTNbfsIgPU5b9iJGNSqoVaI6p9as4TnHP8K4ydyYMWnFW4cWk/YKxtDMjenwdixJShkGuB3zamaTeuoUT/SjwlVLGMXlQRSaOKdPw4t0SdE4z6qAx5ja+HXNHCmLDCHO2M8LQq8YL0Tn3E+ou4B9qcwrdeqTHC7lghkTQqnehH7W1F39VdBOGUj8UZHVNTnyc6k/6eD6OW7nS9RC1YMjGY8YcdWqQMfvTrX/M7BiGXEf1Z8axTzjbsrl9O1DOFsIhNpFIyLVV/Xzemh9BFlzOmfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(18002099003)(11063799006)(261009223027099003)(261021121427099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: k1OKo5jHqA8zd7GQX52mMpCmk87JC+JPyz1mUpzz9x+eSK3KUWQvHbjt5BFX7RVns6e4RItz+D9QkkZEPDW54LfhLoj+71WQ9MjTNO2MFeNk3/UNvae/teUHOA3mhlBV62B5cgTyJO72iyn0/3EMwMPLQj53me9H5KoJ4mVj8F6MLOnTYIud+emLdqRTb0It1PPX2il8tSYYWaO2xqFUiCJ0Die3C5cUkaO38gNHDe/LO8Lna3kjnoR6CfLcD+KBJpSAdavNzMecXMlRndZCOwZsvelJmElWLX6082wnRC5hfdnb+WdXFv1Wf4EeIo+oxIhHZZ3hSIzEqcYUnSkUwEsa2sJVc7jhakh/oWQ7n7AkZstuHi3Oq9li0hs0PRYDxWZMYWECrhG4McsT+Qso9olBvmLsf4xgJIg5gIvyv0skVUtLGH7J2KUzhpQLoV0D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 16:18:39.9794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b07bcc-3551-4ac4-e9d5-08df30582254
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E83.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB666014
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

Add AMDGPU_INFO_CU_BITMAP, returning struct drm_amdgpu_info_cu_bitmap:
a header carrying num_xcc, num_se, num_sa and xcc_mask, followed by a
flexible array of num_xcc * num_se * num_sa active CU masks in un-folded
[xcc][se][sa] order, indexed bitmap[(xcc * num_se + se) * num_sa + sa].

Signed-off-by: Siwei He <siwei.he@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 69 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 50 ++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           | 32 ++++++++++++
 4 files changed, 153 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 0ae6e990c310..7a0a1d5542ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2050,6 +2050,75 @@ static ssize_t amdgpu_gfx_get_gfx_reset_mask(struct device *dev,
 	return amdgpu_show_reset_mask(buf, adev->gfx.gfx_supported_reset);
 }
 
+/**
+ * amdgpu_gfx_get_cu_bitmap - un-fold the active CU bitmap for a set of XCCs
+ *
+ * @adev: amdgpu_device pointer
+ * @inst_mask: mask of logical GC (XCC) instances to report
+ * @out: destination, filled in [xcc][se][sa] row-major order
+ * @max_entries: capacity of @out, in u32 entries
+ *
+ * XCCs are written in ascending set-bit order of @inst_mask, densely packed,
+ * so entry (xcc * num_se + se) * num_sa + sa holds shader array @sa of
+ * shader engine @se on the @xcc'th set bit of @inst_mask.
+ *
+ * Returns the number of XCCs written, or a negative error code.
+ */
+int amdgpu_gfx_get_cu_bitmap(struct amdgpu_device *adev, u32 inst_mask,
+			     u32 *out, u32 max_entries)
+{
+	struct amdgpu_gfx_config *config = &adev->gfx.config;
+	u32 gc_version = amdgpu_ip_version(adev, GC_HWIP, 0);
+	u32 num_se, num_sa, sh_mul, se, sa, n = 0;
+	int xcc;
+
+	/* cu_info.bitmap[] only has AMDGPU_MAX_GC_INSTANCES slots */
+	inst_mask &= GENMASK(AMDGPU_MAX_GC_INSTANCES - 1, 0);
+	if (!inst_mask)
+		return -ENODEV;
+
+	num_se = config->max_shader_engines;
+	num_sa = config->max_sh_per_se;
+	if (!num_se || !num_sa)
+		return -ENODEV;
+
+	if (hweight32(inst_mask) * num_se * num_sa > max_entries)
+		return -EINVAL;
+
+	/* gfx11/gfx12_0 fold SE4-7 into shader array columns 2 and 3 */
+	sh_mul = (gc_version >= IP_VERSION(11, 0, 0) &&
+		  gc_version < IP_VERSION(13, 0, 0)) ? 2 : 1;
+
+	/*
+	 * cu_info.bitmap[] stores a [4][4] tile per XCC, and the IP backend
+	 * packed (se, sa) into it with the fold above. The row index se % 4 is
+	 * in range by construction; the column must both stay inside the tile
+	 * and not alias another shader engine's slot. Shader engines 4 apart
+	 * share a row and are separated by sh_mul columns, so num_sa > sh_mul
+	 * overlaps them. A topology failing either test lost data when the
+	 * backend wrote the tile, and un-folding cannot recover it -- fail
+	 * rather than report some other slot's mask as this shader array's.
+	 */
+	if ((num_se > 4 && num_sa > sh_mul) ||
+	    (num_sa - 1) + ((num_se - 1) / 4) * sh_mul > 3) {
+		dev_warn_once(adev->dev,
+			      "unsupported CU bitmap topology %u SE x %u SA\n",
+			      num_se, num_sa);
+		return -EOPNOTSUPP;
+	}
+
+	for_each_inst(xcc, inst_mask) {
+		for (se = 0; se < num_se; se++)
+			for (sa = 0; sa < num_sa; sa++)
+				out[(n * num_se + se) * num_sa + sa] =
+					adev->gfx.cu_info.bitmap[xcc]
+						[se % 4][sa + (se / 4) * sh_mul];
+		n++;
+	}
+
+	return n;
+}
+
 static ssize_t amdgpu_gfx_get_compute_reset_mask(struct device *dev,
 						struct device_attribute *attr,
 						char *buf)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 5939e1fb3b24..bd2617dd4c56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -663,6 +663,8 @@ int amdgpu_gfx_poison_consumption_handler(struct amdgpu_device *adev,
 bool amdgpu_gfx_is_master_xcc(struct amdgpu_device *adev, int xcc_id);
 int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev);
+int amdgpu_gfx_get_cu_bitmap(struct amdgpu_device *adev, u32 inst_mask,
+			     u32 *out, u32 max_entries);
 int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 				 struct amdgpu_ring *ring,
 				 struct amdgpu_fence *guilty_fence,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 14a72a406d37..a8ebc85c9b88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1453,6 +1453,56 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			return -EINVAL;
 		}
 	}
+	case AMDGPU_INFO_CU_BITMAP: {
+		struct drm_amdgpu_info_cu_bitmap *cu_bitmap;
+		u32 num_xcc, num_se, num_sa, nent;
+		size_t sz;
+
+		fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
+
+		/* scope the reply to the partition this fd was opened against */
+		if (adev->xcp_mgr && adev->xcp_mgr->num_xcps > 0 &&
+		    fpriv->xcp_id < adev->xcp_mgr->num_xcps) {
+			xcp = &adev->xcp_mgr->xcp[fpriv->xcp_id];
+			ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX,
+							  &inst_mask);
+			if (ret)
+				return ret;
+		} else {
+			inst_mask = adev->gfx.xcc_mask ? adev->gfx.xcc_mask : 1;
+		}
+
+		inst_mask &= GENMASK(AMDGPU_MAX_GC_INSTANCES - 1, 0);
+		num_xcc = hweight32(inst_mask);
+		num_se = adev->gfx.config.max_shader_engines;
+		num_sa = adev->gfx.config.max_sh_per_se;
+		if (!num_xcc || !num_se || !num_sa)
+			return -ENODEV;
+
+		nent = num_xcc * num_se * num_sa;
+		sz = struct_size(cu_bitmap, bitmap, nent);
+
+		cu_bitmap = kzalloc(sz, GFP_KERNEL);
+		if (!cu_bitmap)
+			return -ENOMEM;
+
+		ret = amdgpu_gfx_get_cu_bitmap(adev, inst_mask,
+					       cu_bitmap->bitmap, nent);
+		if (ret < 0) {
+			kfree(cu_bitmap);
+			return ret;
+		}
+
+		cu_bitmap->num_xcc = ret;
+		cu_bitmap->num_se = num_se;
+		cu_bitmap->num_sa = num_sa;
+		cu_bitmap->xcc_mask = inst_mask;
+
+		ret = copy_to_user(out, cu_bitmap, min_t(size_t, size, sz)) ?
+			      -EFAULT : 0;
+		kfree(cu_bitmap);
+		return ret;
+	}
 	default:
 		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
 		return -EINVAL;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 29009f6aabde..b726dc511491 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1289,6 +1289,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 #define AMDGPU_INFO_GPUVM_FAULT			0x23
 /* query FW object size and alignment */
 #define AMDGPU_INFO_UQ_FW_AREAS			0x24
+/* query the full per-XCC active CU bitmap */
+#define AMDGPU_INFO_CU_BITMAP			0x25
 
 #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
 #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
@@ -1363,6 +1365,36 @@ struct drm_amdgpu_info {
 	};
 };
 
+/*
+ * Reply to AMDGPU_INFO_CU_BITMAP.
+ *
+ * Reports every XCC visible to the file descriptor in
+ * un-folded [xcc][se][sa] order.
+ *
+ * On a partitioned device the reply covers only the XCCs belonging to the
+ * partition the file descriptor was opened against.
+ *
+ * The reply is variable length and carries no fixed topology limits. Query it
+ * twice: first with return_size = sizeof(struct drm_amdgpu_info_cu_bitmap) to
+ * read the counts, then with return_size large enough for the trailing array.
+ */
+struct drm_amdgpu_info_cu_bitmap {
+	/** number of XCC slices described by bitmap[] */
+	__u32 num_xcc;
+	/** number of shader engines per XCC */
+	__u32 num_se;
+	/** number of shader arrays per shader engine */
+	__u32 num_sa;
+	/** mask of logical XCC instances this reply describes */
+	__u32 xcc_mask;
+	/**
+	 * active CU mask per shader array, num_xcc * num_se * num_sa entries
+	 * in [xcc][se][sa] row-major order. Index as
+	 * bitmap[(xcc * num_se + se) * num_sa + sa].
+	 */
+	__u32 bitmap[];
+};
+
 struct drm_amdgpu_info_gds {
 	/** GDS GFX partition size */
 	__u32 gds_gfx_partition_size;
-- 
2.43.0

