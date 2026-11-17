Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73514606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 19:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=biqu7Uc/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBC9C10F8B2;
	Tue, 17 Nov 2026 19:23:33 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5E0910F8B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 19:23:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEVcU6b2ZjRwYtbeneFvJPlXO+ccHo2aytBN/NtJA13zkEjEEADOBzhP4gXoPe6zwM9gdjejQq3TXDZsq+MTSjH0sqeFUfp8AQs4IhD5mUH1rslAiRHW0wbp7CGMFIjO+OI+I8YzoDybEu1pvV8RSSpG4SiLurmIz6I4RRsB9q38aWnEEDDnIsqg8ujNw+LKqVmhrEBjGXKLTjMPFA/5c+wOcEDKHwtJm8J2+CbhroTWJxrbWanm8nIK3mTT5doHXQ6E1+ze+Tad+d16JEooXf4TcvoaWy2qHX6yH2sIXxpWZW6sMth4PxmQEywU4i8agVkNEO8axHz6NeyJQWBeCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9lMrvJT95d3NIiHAOUUP3GxZ+QELDw5C+p1IL2Hecg=;
 b=XdW80Dtn6MgZmAAz4uN3a3tRE+oR8SqixiCW8E7oal5cwU/8vYrH5aUkUP8pBsLlIBRYVoGLJcftj6Z7wUZSHSWZsMSF7hioAArcS15DtN1IysW/B6T9H9OHegHxPyAMGrd6buc6UTH12ZeshqTbJx9G8x9W22KfXZQRdMJJA3KypRj6yPFMUJVUnxCMDpviFkrHo2KUCcoJ6e281A8CHiUO6Np5IHxvCq2Zp8g/oFt+H4yu9+tqBLkiN5UqfQ/9j824eZzGs2B9oBerc5rzCriH8JtAZJx+Tg7QgYBunjnEM+FtSgrsxYvJ5NleFMl9pbtovf32tCFD61oYAl+M9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9lMrvJT95d3NIiHAOUUP3GxZ+QELDw5C+p1IL2Hecg=;
 b=biqu7Uc/g4Pbn/1YHE7EeFQJhpLvFlfD4zfG39wz/ZkdMvW8FqGn/c1JJI6+0UhLHJ9+AUhgXdkk4aNjLUuSRlKz/ag2k3uAy4ZRvR8KrqlOtbbutdWuPtPu3lkPcnyPng04dGHCEeTm/c1B7JMPhz40ZGjg2fuHLY8dx2YqJxo=
Received: from BN9PR03CA0451.namprd03.prod.outlook.com (2603:10b6:408:139::6)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:23:21 +0000
Received: from BN7PEPF00000092.namprd03.prod.outlook.com
 (2603:10b6:408:139:cafe::8c) by BN9PR03CA0451.outlook.office365.com
 (2603:10b6:408:139::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 19:23:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000092.mail.protection.outlook.com (10.167.245.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 19:23:20 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 13:23:19 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 13:23:19 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yogesh Mohan Marimuthu
 <yogesh.mohanmarimuthu@amd.com>
Subject: [PATCH] drm/amdgpu/userq: Add INFO IOCTL query for doorbell ranges
Date: Tue, 17 Nov 2026 14:23:04 -0500
Message-ID: <20261117192304.809813-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000092:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: 464d7f46-7852-4f77-6558-08df44e03d4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|261009223027099003|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|56012099006|11063799006|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: xt/XuQLdx34bqmcki6C3IBqWY8z5OfqwpKfPmF4QExZa/6kjkH8TuZL/zIWyJFjBH8MFVNd+Bum3Bb1wQYnCasnCUf1Zs5Cv4WWvr9Us7VBtYTgMJngxmOIq91XMTfM82RangO6ciXifWXSXgEuYjHYsv0pjlNpfHDGe89bcKxgU5ZoSmvnvWJ0iSdyvEy9koe5QTdueFrKLwQjwGkBu/Gj/P1Y4mW6289GiIF3zO0fAYTFHENR5Le10F2DiRpX8oYwVYWxcoWpVVQamxjgP7uJ8n7SomstVYNY4O8X/cCTax9RYxtoMYZ9aEFe5osGPI5YbzI7N6dtBGwtGYHfq8p1fmMqzkf5u0B3SXHal2zUOA6veeCHeFVgQsZv7cbDTmOdsTw2obtdSZaco0du172UwoGQa4eWaVJWUUGR8LCytxciz0d1Xt6cQkXG2Oi/p9I/s0F+bXlon1TnWu2C9Bbc0x8OcFKKpRnt1uV49IumbXulrFP8Fe9jm50mENYEdo7Z70a9lnyHAYDJ2wnU1WXhl1Kw8RM7F/NQgtigT5uKIWmSs+FhmO+/IoXZuLQ2pux6pMFUz0W0JjHauyOoTXIfOdARfrpl3Qhgh2urR5YtoV4zqFGc6vULbbiFBMBkRQO3ipAtQe0I4SXzwM3poULTjIMWbguao9jajo7u4gcW09GMiJZD0Aj7WkpdbLnzvVbbHMtP3g56B++rpj8iMBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(261009223027099003)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(56012099006)(11063799006)(10067099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 50RYg+nm9SltCAQca7lpUgYYTo5xSeD7p6ieNz8SN7LR8bE5JMebL3q+/47a8Q0q5t423aWYuUB6i0W9Y3QSQhHL5m6HMpx5Kp0U9YGNBi1kXxFbALg2Il5MO0sVcuUWPfctHCaOIndaHH2f+s2gqTQ+8clJ06LDsPI9OKnXguwfxvOBecqEQlbFDmAx41JWL+NvyqOaxPeLVdc+Y+wwNVYvWGd4VkvjBbB3CE3Ja/n/kEAy5oRTHRNSaY7rSjRD2nPa+hDu+W74f3HvXa+oJDmFMAT7o8abRqM4+V3kEKo99cZ1alnMP5dDGjsfzHGhhbyofMLhxZ/BuH3dkqGnG1XQoqkkWgvnXu6KIh8A8yQI2FNDStrzA8vDLLhurkhqO5pNOP7AdVWiAfy+T4gWcOUVBCbw5B3B5DsMn+3KiG+FH6WzIVG/m3TMpl0mIUkG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:23:20.1236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 464d7f46-7852-4f77-6558-08df44e03d4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168
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

Each IP gets a subset of each doorbell page.  Add a query
so userspace can query the ranges.

Cc: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 20 ++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           |  6 ++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index d7872acb4d790..42109f7706294 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1453,6 +1453,26 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			return -EINVAL;
 		}
 	}
+	case AMDGPU_INFO_UQ_DOORBELL_RANGE: {
+		struct drm_amdgpu_info_doorbell_range db_range = {};
+
+		switch (info->query_hw_ip.type) {
+		case AMDGPU_HW_IP_GFX:
+		case AMDGPU_HW_IP_COMPUTE:
+			db_range.offset_bytes = adev->doorbell_index.kiq * 4;
+			db_range.size_bytes = (adev->doorbell_index.sdma_engine[0] -
+					       adev->doorbell_index.kiq) * 4;
+			return copy_to_user(out, &db_range,
+					    min((size_t)size, sizeof(db_range))) ? -EFAULT : 0;
+		case AMDGPU_HW_IP_DMA:
+			db_range.offset_bytes = adev->doorbell_index.sdma_engine[0] * 4;
+			db_range.size_bytes = adev->doorbell_index.sdma_doorbell_range * adev->sdma.num_instances;
+			return copy_to_user(out, &db_range,
+					    min((size_t)size, sizeof(db_range))) ? -EFAULT : 0;
+		default:
+			return -EINVAL;
+		}
+	}
 	default:
 		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
 		return -EINVAL;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 29009f6aabde9..86d42a5d683c0 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1289,6 +1289,7 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 #define AMDGPU_INFO_GPUVM_FAULT			0x23
 /* query FW object size and alignment */
 #define AMDGPU_INFO_UQ_FW_AREAS			0x24
+#define AMDGPU_INFO_UQ_DOORBELL_RANGE		0x25
 
 #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
 #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
@@ -1668,6 +1669,11 @@ struct drm_amdgpu_info_uq_metadata {
 	};
 };
 
+struct drm_amdgpu_info_doorbell_range {
+	__u32 offset_bytes;
+	__u32 size_bytes;
+};
+
 /*
  * Supported GPU families
  */
-- 
2.56.1

