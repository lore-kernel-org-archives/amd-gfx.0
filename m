Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84403D12D50
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Dec 2025 13:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24E0910E797;
	Wed,  3 Dec 2025 13:05:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="adwk4VVV";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013007.outbound.protection.outlook.com
 [40.93.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F7CF10E797
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Dec 2025 13:05:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4n3HnPuCTxYTyNvtCFLaRLJp6iGZEggPwa4NnBi2LKLFKTjlyva5ZbZwYoG/jpSCwdCP+XTZ6IJDo8bSakhK7CHbxNPAJCHGojuHOp4RGlQrw1IQinmRgZJVdAd/ph1F8dPBK9J1sOofv27jfDSyC3oedUm8IGeAYC+Vs8a3Ze9bhl1GYQGC8QfGrRAdFVt5+Wp1RAoDeK7I0vSYRlxn95s1aUhx6+/uwdLFlVVmp77p+kEZCoqF5OwGrYxgN+U+BqS0/cLXObYwGg35TF+puKYDf28lG8Aeh0lJalpO2jXh/Aepe6F4LRllKJ97rqmXF85EJTz0e+EhVBi9K6f+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqR8SyCWJ3SCfTxnCTzxFyEgKJ/i2l8nHoo0bkkqznk=;
 b=SILnaq3RZzdWufjCB9dSFB8vblmEZ3dnYyaI35h7e3YgBZAiOKocNclft7sKlUlRW7z3pL2YmNWb7GNWiDcD8CK7lI75CDZnQirVVlSbehLFpAPuY7GVPcEYMLgu5AEklgjUqgyMC208FqtMizGIx5qOCFLnwrr0WB5L0nKCqdYO9FzsD711oW+GOMAjVrRUEkQWV2wdSfq+sVCNRmBrCo6LHyh39KdNDWxlJMp9y/TCREQvcS5CLG3IcP5lIJCZ07SJDdKA0zgbB4WJ6uXgrT1zIim2OmDEA8G5naUzXqujFovWS5f7vilzWsPhe4am30ZWYPGmFM8U6pL37j0uVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqR8SyCWJ3SCfTxnCTzxFyEgKJ/i2l8nHoo0bkkqznk=;
 b=adwk4VVV7aosBo1jCUI/7pkRntbd2KEVC7ThVbLQ5qJkCG1UBtQ7EmucYgAoF7CGgXBU78QnZyLIDUBW1a4k41bNTdxsGn8zpxxeQt2kux+H9NciRMq+Qn2463En9IBlnG8ygsquSslQ6xT/cUXHNuzsp/j7yjrMiF4tT+OQPw0=
Received: from BN9PR03CA0726.namprd03.prod.outlook.com (2603:10b6:408:110::11)
 by CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 13:05:15 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:110:cafe::5d) by BN9PR03CA0726.outlook.office365.com
 (2603:10b6:408:110::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Wed,
 3 Dec 2025 13:05:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.0 via Frontend Transport; Wed, 3 Dec 2025 13:05:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 07:05:14 -0600
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 05:05:12 -0800
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Jesse.Zhang@amd.com>
Subject: [RFC PATCH v3 08/10] drm/amdgpu: Add ioctl to get cwsr details
Date: Wed, 3 Dec 2025 18:24:59 +0530
Message-ID: <20251203130436.745633-9-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251203130436.745633-1-lijo.lazar@amd.com>
References: <20251203130436.745633-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|CH3PR12MB9730:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc7fd6e-9fa5-47e4-9632-08de326c996e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JcQtnApK3HZcx0sNmu5gTt2SAhJVPnocyRyuKGLvkOAdH+2oSKutzUGGR7wf?=
 =?us-ascii?Q?ycIq6Hvb/7bJtwwgXS3O9/e9rP95mv3DY4OJ7lBe3kwcqABsflFnNxUUrPu2?=
 =?us-ascii?Q?6Y+rcb3ozEnO6jBBpsYZjCCbCnmencjA3QFOqUENHI8PVKBETyGAeWgtw769?=
 =?us-ascii?Q?+aRzjGNzs2ZldSGF6+Ac0bj1o7YkXMzkVf/jECrDunY4LBiXGhuRZ1Qgxp4C?=
 =?us-ascii?Q?EA3ZD+OJyGQBQdTQwEapRZsVBIcWp+MgafM2am/ZlWexeNnHCScDSZW/U1FS?=
 =?us-ascii?Q?QR5Nle+3xtH+XDN4YpAtvEQyW/HVUlVG/bDXHQFbYaU6R3mCFILw8OmauTxY?=
 =?us-ascii?Q?2rfkBgbSt3Nj9XflrHizpvIpwa/sSBTpe9Bb4ev15WVodo4l9WNqNABWUcFn?=
 =?us-ascii?Q?E9CrCghqc0lf4VEp3wV2Pm8m+YeQzwB/Ty4xsRXe8YOP/iUbtg+Ex7obF9sI?=
 =?us-ascii?Q?QCJ59gMZObRNp4wO+vLXMpFWFRiJYfPsY2TM+hLFvLERFNLgJis0A4myozDj?=
 =?us-ascii?Q?i2A0h1B95i+mzQW2IZCbtUgg8DYkcs1bpt0ULEmnDb1n26xeC1rl+ZbQFbka?=
 =?us-ascii?Q?Sa3f1GOxInh7O6p3r5ZkrFSran+F++t0ID2mJFV9V3pSXOcWs8g9DUCppnbR?=
 =?us-ascii?Q?MEQYxxzWiyaU8J5OyUQulW01VSQgRF0EbW9ygtq3mKfPJchiG5x1qp0BdolR?=
 =?us-ascii?Q?yslZIIB9B6rj5FeJ5TluS0CdE64OYTXRBHVI5sOxZGZpY2enQT4lXLogF98w?=
 =?us-ascii?Q?Jjvpi8NKA3xXhd3PxYCDCv/+b2P6RRIwWiylidbYRkXG7jy67pzF4+0gydIU?=
 =?us-ascii?Q?Upb9R4wEriH5TRgh1Dqg0omuqOvSyhz/wYX0LMlsg5FfgzIIuLBrtFdVYbqo?=
 =?us-ascii?Q?FGQeOHuGDRUDV32cRTDV4ViwEBqrdVFtV0znbStgd3gnsSbGgiZ+JDot++Ba?=
 =?us-ascii?Q?9VJDIhg6WcmqhMuH5xPpL+lF9lUErxBtfOK7ifJO5+A6qUafta7xX4xJd5Mf?=
 =?us-ascii?Q?Ec53XrgMJUEUYYkAmJsemXTC0liTKzoOdtBy6HJj3Str7eJnypNhQ2YhEDhz?=
 =?us-ascii?Q?q9PlL5FNfErTGojxWnXfLUGLAr0lxXnt419yVKz0TY0F+IdHzZAM8QCUWSeI?=
 =?us-ascii?Q?iUFF7qE+OvvIONzR30FXFXWMr4Vb0KXD1shSPqguv4Qegh4BhAG7YDUnVUk+?=
 =?us-ascii?Q?u/tdivmOdq2X8XwWUUQ+NpuILoHdz3kGOLSDeb8Qdvq7QwnP/JrIHjqYtPvO?=
 =?us-ascii?Q?FLCEZ0v43pWs6ecboVGM0fkIAzZeV9OS/aenbbGFMX1xBUQLgZZCcW0prdQC?=
 =?us-ascii?Q?9AfsZvPlsQX+Ialyo87V64r7Kq01rDQWBLGCHm5PjeFANUKw+GD0wAfCJmHe?=
 =?us-ascii?Q?h/Y+OMa64x5kRRK2acpn4VQwqKXIAAWlwzuEr5vin+VRcPM7ke4N5l9pAjQ2?=
 =?us-ascii?Q?ICObJDISVEnlvJeS05lpk0K8C+JcPGJjaSM0vz+WvchclgqyXahBKtoNLyhQ?=
 =?us-ascii?Q?sWcv8GDgT1b6xYtQFIsd0FCVaYbHhTXyFAyu+izrCXxcTfplm4Qauc4xc3q7?=
 =?us-ascii?Q?feAm+IvinGBrqUCmGDc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 13:05:14.4818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc7fd6e-9fa5-47e4-9632-08de326c996e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9730
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

Add an ioctl to return size information required for CWSR regions.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 21 +++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           | 16 ++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 398d6c8d343c..848405c37bd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1368,6 +1368,27 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
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
+			adev->cwsr_info->xcc_cwsr_sz * num_xcc;
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
index c1336ed4ff75..2bb9daafb560 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1273,6 +1273,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 #define AMDGPU_INFO_GPUVM_FAULT			0x23
 /* query FW object size and alignment */
 #define AMDGPU_INFO_UQ_FW_AREAS			0x24
+/* query CWSR size and alignment */
+#define AMDGPU_INFO_CWSR			0x25
 
 #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
 #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
@@ -1636,6 +1638,20 @@ struct drm_amdgpu_info_uq_metadata {
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
+	/* Minimu save area size required */
+	__u32 min_save_area_size;
+};
+
 /*
  * Supported GPU families
  */
-- 
2.49.0

