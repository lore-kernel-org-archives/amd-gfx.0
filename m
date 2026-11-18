Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9181460A5BCA
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=i4JbncqX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D101411209E;
	Wed, 18 Nov 2026 22:37:43 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92BB91120A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 22:37:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2wHEzq6aOuTj9bGGlymlT6ZHUNG7LwSR9JTFLjtsBZ1+4SJZJwVdCPbDMHvVvL25FGyzwU7v4heQfcJXNVeWqdZdj580hU+ceF1spOSOuImNZYgRUKNrkMSQ4ibOOqIcCTMY05aKtxNfaApbBGnoGGX0nSYojh1L/ONT3S5mGyMOBJ2Ydw0b2YSNRNgObobUewnUzS/VcZxyA9l3XYxayCCea+etAE/E7UR406VwnnnExlSdAE6EY/WxR+5yriTQL5ualP2RSrapberHnHqGCnAfE3kGOngXw2+rDi9mxcip2mDlM2DwLlBIVIR4OpliUfPwcwTL5O/sIJXmRqQsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rao0q3X9e/crcljXU51wLmJZwXZU0BjzyaGsp1OiAPs=;
 b=eCp+ots4zaijEubAYSG2kPq4nrkUeWr2ZIRVegPdDOcjUepTsSVuc+C23uxpwxStQOJIoTj5SPgEIhBOWymqgPrbyxLP8+Q6dDhsQkwIQ8LPgZHtUpvdYqTtTel3x4+dIlXfqMnD2Qbs/ZZbWAFcz2nFmypVJw/Rwi/Ll2FM9emwG6s0MnNhpCajaABVLWH4og1ui6LY+tVmDt7gW2M8beuf+2aWoJkkbIJ39JjRZtk3EJGU84gtUV8i9sAbvCc4mj3S4Hy9Zim2IccJrr0kd3ZtlrmEAqehFwTJguwfFxo4imv4P11hWNNmon2AR+MuFsYfAlj9I4K58Qq7AhoMiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rao0q3X9e/crcljXU51wLmJZwXZU0BjzyaGsp1OiAPs=;
 b=i4JbncqX0QX6bUFCh2gTIU1hreVL26ZM1a6kNXeVbiedQLKLbqBdYpphHgFv9zms39UZORQyH04a8vyghJSREVASsCaC9f941JCFu2YdBFWyJkw2IdKT2hONXOR32CJKIQjMyFtx6Rb6TJmltUWVDMLF9onqJURB/qFEqzLjr0Y=
Received: from BY5PR03CA0015.namprd03.prod.outlook.com (2603:10b6:a03:1e0::25)
 by DM4PR12MB7743.namprd12.prod.outlook.com (2603:10b6:8:101::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 22:37:25 +0000
Received: from EA8PEPF00000006.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::70) by BY5PR03CA0015.outlook.office365.com
 (2603:10b6:a03:1e0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 22:37:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 EA8PEPF00000006.mail.protection.outlook.com (10.167.249.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 22:37:25 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 16:37:24 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 16:37:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yogesh Mohan Marimuthu
 <yogesh.mohanmarimuthu@amd.com>
Subject: [PATCH 01/11] drm/amdgpu/userq: Add INFO IOCTL query for doorbell
 ranges
Date: Wed, 18 Nov 2026 17:37:02 -0500
Message-ID: <20261118223712.2518580-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000006:EE_|DM4PR12MB7743:EE_
X-MS-Office365-Filtering-Correlation-Id: a8340765-3fe7-4c4c-73bc-08df45c484d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|10067099003|11063799006|56012099006|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: cuOQ/PnaS2rnVfl29r4+t7RzcyFnpgZ9mBsUijZRP6i7ocYQ6GKwGCMho5kHw/ISEI2gsNuik83q4yoObexprhRFAY8E9c8qbrA6tF4cxjGV70lKNVBuVAo9YIfDZzUylJQqcn4R4+XCyDZYCHGfk5CkX1uQXAte+j//9CDdQcjPN4xS8TM9e674iTige2HygJu2li9wE41s5EAjOXuBibvbgJ9yxmOCoIzJqeZzayUdYKL4tMD8XA9zGtPZbZymngbaay7K+lMYJsUzwa2hFNQK0rSl2VjwusR8wi6U4RJISfXNVZDn0XkLRTIIERE73MRFZ0Iivz6szhdQH0MrLN1WqT9vabeZoZrKEe5+2YpDVWxLXOYSSycmCfGqgIjlmk7sx8NpO7Mje7XGx+Gs7Dje+hBo1EbIw87MGNBllJKwpcLKMEPSm0aHQQ8HRbwLH++DwPvGkbhJd7DxuZ+gD4s99GjyZ4H8rL+S/nMfEfdniKDoFYapNJyeymjdX6f88yvhZEOMNOSaDZZTmEhF3Mb6bjy8CQdSflh7EkVKUuWxWYuTMOYEb8lS+0z9R6bQSgvk1vpl2EunPmWrWqkUJAVVJZXPZvEVK7/coo+5jpQfTK0OY5Ry4UAktbqAu9xde4M73PXJyC7FXojtp8EdLiTK7v9esWmgnCj38rNYLa7qvd4nteFa2/YHw5TrPY5Na8vOgZXgnMp4PpdoR4Cn2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(10067099003)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WAi1PnoplmJiro/f8h2UG0CrLhp4UTs1/06i6S5o6eUKIJO85gQzDLWwTsHA1N51VbJG8favMibcSuEXhOej8eUgI+ZiKM0OlZePF5eSFuW6VHCxTOhbI5GVkPykQ901DaC1e8JLsPNrNJieZrdAp9G/suTmVxIbZtwp07Hme4cbVC5s9fCQVuP9yJkY07Dz6Uj1HNqn1cvamZxTROgoiBDfhfOAeZmPNf2OLv3wW3D9XriFyGkpVxFaJpwoEM/I8bdbrhRJWThw3dBmubgTHGbFWCWTERDHuLc7BVkjvk5lVpqR9IzF6HIZPQdyFVqKgJiMp1phNB1hqgXWqnQ9BIbt+L/+o2gBz6sb9TFqr6NiOSfvuA4xPWcqkAR1PDjzhaYY1HqYS9QMStiGuCgTnMcY5qapmw/+5qwb7vfXeg3RpmgtvVpFk3C6UQBFkxm/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 22:37:25.3149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8340765-3fe7-4c4c-73bc-08df45c484d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF00000006.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7743
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

v2: fix unit conversion

Cc: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 20 ++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           |  6 ++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index d7872acb4d790..0d157c18b7aaa 100644
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
+			db_range.offset_bytes = adev->doorbell_index.kiq << 3;
+			db_range.size_bytes = (adev->doorbell_index.sdma_engine[0] -
+					       adev->doorbell_index.kiq) << 3;
+			return copy_to_user(out, &db_range,
+					    min((size_t)size, sizeof(db_range))) ? -EFAULT : 0;
+		case AMDGPU_HW_IP_DMA:
+			db_range.offset_bytes = adev->doorbell_index.sdma_engine[0] << 3;
+			db_range.size_bytes = adev->doorbell_index.sdma_doorbell_range * adev->sdma.num_instances * 4;
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

