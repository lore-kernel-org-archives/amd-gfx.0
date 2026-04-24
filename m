Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4346FB44C4
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2026 08:20:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B1F210F41E;
	Fri, 24 Apr 2026 08:20:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h8qKHTmh";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013068.outbound.protection.outlook.com
 [40.93.196.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B79210F41E
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 08:20:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAzwKM5wYiiGn/6Tq8kg3dHElB28+6YwMn6A/SmIkGko8Ubf8ZuIYXpLdiegqIrrobMocdqaYpCRalkk5bJ/isBHXqSkiSV7wNV3Io/+6L3xy8zB+cxiUI70131LEemxtAGji07Cvv3+58lI/YBV2YvdzPz1BYcIQ7SOxCQk8zV5hl0e809a7kJwKSLegox1xpZ9hFPHxmAMpAF1/WPYzj/XvgjRUurZizyTv3UEPtUxylUqrLFz9W27q9/SiS/NRa1FRlcOfszEvwjADz+drTx74tX+tApD3Qyc/VWoIjl1A128oW5jlZTMP9WNI5MhmzToPKAxEmrqbKMM4PYdGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfVD4c3qBECJA4PsFbtsGbyblHMCkxZeXiaa9g24GTA=;
 b=lnDEx/xFE1JAr6o6Bl8q/c5sNVcm/5rAMa+kUPZ4DQOKGyAYPZBTSeFziijzJtXX21psMarpBPRbd1c8v0P7t+DwexQDJY/m7vAfIowcCZWQAvF5HBaecsT/+CNoNdRMraBMvs1BuTh/XNnpaj/pbGQkzFz9XfBDaJgS629OS16eFq1neeDBT4qq0Swr1P/9TNi0ky3CXM6r71pRqtRYmGKtGgkkcAYeiP2EH+RnrCEuKpLzxCRuGldo5VCQUf1JcR9p2yP//SyoQF3EbGdd4oDHvarISVF4jMX/5wUJ1NLjxnxUX30/1YMsMWQlF7iAdtovlXOVDGVDUfU93AnKOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfVD4c3qBECJA4PsFbtsGbyblHMCkxZeXiaa9g24GTA=;
 b=h8qKHTmhgxj1CVz41+6umhYWNaiL1zhGLzQgTz9IqtDIJnTQolZZdwBgv2Zxibuhe39d3N1skPsmlekvamEKru+K50R6wQMTHwoZgeP88NUbLrrIzaEiX4zWmmoOIFHQQBBJ0XCLzmRzJQTKKFpCNWSn7fYdBiCvYUjo3kJCZFE=
Received: from SJ2PR07CA0018.namprd07.prod.outlook.com (2603:10b6:a03:505::22)
 by CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 08:20:32 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::a) by SJ2PR07CA0018.outlook.office365.com
 (2603:10b6:a03:505::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 08:20:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 08:20:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 03:20:30 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 01:20:29 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 24 Apr 2026 03:20:23 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 05/10] drm/amdgpu: add AMDGPU_INFO_SDMA_USERQ_DOORBELL ioctl
Date: Fri, 24 Apr 2026 16:18:50 +0800
Message-ID: <20260424081955.873090-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260424081955.873090-1-Jesse.Zhang@amd.com>
References: <20260424081955.873090-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|CH3PR12MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 6770fc57-75bf-479f-159d-08dea1da59c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: Jz/KIe+/Yqwpze+QVvD6iJoffmod39bkSisonp+lV+oNx/+V6neY1JAA9GOiPScQlq9AzWxSZZVnBZ7D9qYJRCTDdgVDc6RS6DXSDQGjmPZrG5evhkhW423CCl4uMQUoqaDgnMhOMBwtxDx7L7MF1Lv2XsP2GEularWkW1hZiE3/lfGr3V5rMcS/Hwanmodc7FGfpZm+hla82t5opyDPkxScBhgF1v4PTMDaGE7XcCngQvdO0EPar1S1JSi5y2mv9eOvR6boggjeDM89fQ27kUHSwIXwopakWWNr7rIxDLHS695hB+RUpTrerMZ4RYZnWHTKp+kadLp/0vx81x5Ys4u+WUR2b+C6LruNbSsVttcFsnFDiM///SsXRjeSQOClcZz9BMqKRDp/dDmyLAFUdks6es6EfmjrJMbNPOZIjz1pPDkcxC44Akyq31pycstAY+OTj7iUcS35WKB3AzZHDpm723nVz5i5xQMtNuawbadW3xEQX0fcONWORpYktGhJlr1mTjZ8eCT2HgUGcY/8KVZgXi1Musuimnom9D52S9b5Li/4DGfoMarWxghkIqJ6pQG9gyfLLaxl9hpRjQ36QkjbunSjRF6n2fG70fqIDkrfspyM1YohRMCTlaru8PJq/mTTp3CLTSSfTGQJyHkaAabNF39jbvhqjrKUS1owR5ZHqR/hsXYEc09Xpi6SBoZyo3v8GEmg3WsTJkjtzrC+P/xodeeokArkaQrBC3Bxp2KC4IzS+6yHoW1ZN8jvob+Hskmt31cMh6swYe5jtC9Z3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iDNj5AI6GtD9G+BfLEDC6XT1g+LzIAa7TBD6hDIM67WDkc9PqnOnLjTnM9nLCRRvfZqgKKT3XweVuMkfhSPsEIVnp1rzY+by8NnMgHuRo9470Ha+ZeAo/ru9gN6FaFxKpVkpHl3p1iJHCg+KTrGkohhQQUJTzfifXcUpShfQiXpS2X+5BXv1DKjvIpvi9Acb3Nbs96EqTIQ/LNiE1kU4B08h7wOrqiVSWkZthRUx66btICSOznEDVC1Nni5kJKrB9Z16Hr5eo8xR3VfpckvFBF8440WAimuaXSGdoPznH5KrSCI9m6WlK0GgnPR837ud0r2fiJtDyn4YFBgW1UuNbMLlD3Ym0Dvb3yICkXjNDrFRh6xzlOQnSaHqbT/TbyVBwVgfG6dN/TT9yEWLYj12DUORji9Bg9KdTTaFybYGiQqBttGgd0k9VknC0ER2xFRe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 08:20:31.3076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6770fc57-75bf-479f-159d-08dea1da59c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8403
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

New AMDGPU_INFO query that returns a per-fpriv GEM handle for the
kernel-owned BO backing the SDMA UMQ doorbell window, plus its size.
Userspace mmap()s that handle through the standard
AMDGPU_GEM_OP_MMAP / mmap() flow to obtain a CPU pointer to the
routable doorbell BAR window; each created SDMA usermode queue's
qword-slot offset inside that mapping is reported in
drm_amdgpu_userq_out.sdma_doorbell_offset_bytes.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 13 +++++++++++++
 include/uapi/drm/amdgpu_drm.h           | 16 ++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index d88e4994c8c1..dbcfbe418e42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1425,6 +1425,19 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			return -EINVAL;
 		}
 	}
+	case AMDGPU_INFO_SDMA_USERQ_DOORBELL: {
+		struct drm_amdgpu_info_sdma_userq_doorbell db_info = {};
+		int r;
+
+		r = amdgpu_sdma_userq_doorbell_create_handle(adev, filp,
+							     &db_info.handle,
+							     &db_info.size_bytes);
+		if (r)
+			return r;
+		return copy_to_user(out, &db_info,
+				    min((size_t)size, sizeof(db_info)))
+			? -EFAULT : 0;
+	}
 	default:
 		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
 		return -EINVAL;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 79e8bbda046b..533be8ad8a7e 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1280,6 +1280,22 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 #define AMDGPU_INFO_GPUVM_FAULT			0x23
 /* query FW object size and alignment */
 #define AMDGPU_INFO_UQ_FW_AREAS			0x24
+/*
+ * SDMA usermode-queue doorbell window query.  Returns a per-fpriv GEM
+ * handle for a kernel-owned BO that backs the routable SDMA doorbell
+ * window, plus its byte size.  Userspace mmap()s the BO via the standard
+ * AMDGPU_GEM_OP_MMAP / mmap() flow to get a CPU pointer; each created
+ * SDMA usermode queue's slot offset inside that mapping is returned in
+ * drm_amdgpu_userq_out.sdma_doorbell_offset_bytes.
+ */
+#define AMDGPU_INFO_SDMA_USERQ_DOORBELL		0x25
+
+struct drm_amdgpu_info_sdma_userq_doorbell {
+	/* Per-fpriv GEM handle for the SDMA UMQ doorbell BO. */
+	__u32 handle;
+	/* Byte size of the BO (== mmappable window size). */
+	__u32 size_bytes;
+};
 
 #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
 #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
-- 
2.49.0

