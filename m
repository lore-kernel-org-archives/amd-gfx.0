Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0B2C98302
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 15:12:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFD3210E568;
	Wed, 23 Sep 2026 15:12:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LAR8/CSG";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011062.outbound.protection.outlook.com [52.101.52.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3815E10E50A
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 15:12:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXv7nVnL95OJ0EeD6Bqkkvivvrb33i8TKfTfft3hFQz3K1rOzD9OExBZ1ixS0GrFP+ewRvH612X6yv3TnZ4jxEvJhs2wsD8ggOczhp80z/v00wNeEQavagTmQRay6A77CVP9FF5F6g/7khBlEOPC8zsQibVMaUu9oPa4ultKeaLKac62OH78KkKamBHdV7ic/z+RMc3fHz8boiot38K0mbxhDd1icYwEhWJSgphqD5kJrVD2KUbNyT30xDPZsmEHcjjsW+X7y+arZJfWNS7tHhr+rWI+poTeZmXDAFaLKP7Pq+P5FKJCHXAQKYU05vlR1Eomry9uTYzeY25UhQi8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEiJO6EI42kC6iNjA7jA3GiNrwr5PvI8YxQJQxCb0Vw=;
 b=EEyidQJ9b4hQxt1QboiDPOge8RdphxOp/uh1n/7fwyd0eRxMXPoOyxz3ZgqWd4kiZuT8T8rS4LW8IBSgmfV/87VjShTRGZvewt2iN3tEB46gr6tSWhvN9t+Ko6snpcyYsXNI1p8655Xu/+jgnwktLud/MkzBccIp/M2UbSZXO77cLr8UZ6lHssnp4j2M2NkbpD249bxDIkaTuWXCzxZgC83K0aTg1vsEC/Weu9TsIoSJ8xtaYDF+PNO93dP2Fdz0UZD6+frNwubX4XZc3DmjZetTN7Kjg5ge3g0KRdBoQt+yNlxnlTY+qgFLIB6kNkZ/i7xDM8JFNrYvs8APWvKrJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEiJO6EI42kC6iNjA7jA3GiNrwr5PvI8YxQJQxCb0Vw=;
 b=LAR8/CSGx2jV/Y4Bjmh/KwuSOQHd7DNniv91m6YjDbN8gQQ+uv7OM9p7DICCoevzZ7EgjTwnD0vgbyuJObMqn0ODhsq/4f+wPA3oB9U31O+Zo/MRVDnbeJnWL6HBetWLQ6SuHV9s/cIbGPY/90RBBH8ZCXtc44HKTLHI9OKY4Z8=
Received: from SJ0PR05CA0166.namprd05.prod.outlook.com (2603:10b6:a03:339::21)
 by IA1PR12MB6651.namprd12.prod.outlook.com (2603:10b6:208:3a0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Wed, 23 Sep
 2026 15:12:42 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::4e) by SJ0PR05CA0166.outlook.office365.com
 (2603:10b6:a03:339::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.6 via Frontend Transport; Wed, 23
 Sep 2026 15:12:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:12:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:12:39 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:12:39 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 10:12:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yang Wang <kevinyang.wang@amd.com>, Frank Min <Frank.Min@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 08/12] drm/amdgpu: support MP5 in firmware info queries
Date: Wed, 23 Sep 2026 11:12:22 -0400
Message-ID: <20260923151226.2778589-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923151226.2778589-1-alexander.deucher@amd.com>
References: <20260923151226.2778589-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|IA1PR12MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: ac80f95e-3263-48b3-8fdd-08df19851d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|3023799007|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3xb+TobMkwhudXW25yGbzu6TV23DNyvpeJSi+i7YbxEzWIFeQhx/M1AJt5e9fXt22pGeK8uiWW0TnQbth0oZuLFwcGwxUHwH3sXtQdJYg1U1Po+v4+rdMyLPu895t4oTyR7gwT96Aenuu7dnkb3Q2mTTnxYCsjCOy4m7IlmOJukwU3Woy5hFv22o1kePZEYS7AmERv/BofixJP9U4bnhHScas9F1/bfbcPyAAJ0UUcT/9+VKeJ10c/gzqOkXT+jSSp8uBxd5/xmme3Z1SsNc1ntNaUJUHnye7aen+gbSwpQBjj0TNpsJkJUb+oQN+iPvtaO0iPCt/w0wBh8wNClUQ6jSJFY1LOeOF+3+RnZwDZ+eUkBbsuMa5Ws8V6bTQ8q7qmKjnmMcO4n7eJYMkGDfhPdKxHK8k5PkNmyhCLk0pc6pOXakkR66yQdaADDvmtsUsYG9kA2D0cRWXFvW+4QquJzZfTnZsT1Bd7JdmJIhpqtVnpdPEgIerxebp1bbGWD3/mJLPYV22Ulagt3+6Wj6mj+gNKuaPw9/XcCVp7fVoKTRK4oXig+B4xY8p8PEejR5yhyu41sHx12io2TbnhEroLzjOT4wvaGkXXtHyr8N4g+Hvtjq7C/8Mm2FTHXtQ2p69ZkxfwDvtDPciVkojgxKkIstzTDv/fPwJr45NAIyfd+1FY7T8o3Nq4PFLgCHqgynrt7uiEevjhE0VaxiXM0wiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(3023799007)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /nhsvXh35QaygLecugijhZnCBITgJoccdu/skqqj8Qe6xkP5KZ38bfYU9eF57tbpk5cVmiY4teJqusQXT61g4UQ9Em2VDUR1tgPbhqzqX3NVDUZokiFEBaeQVXmyVma0eFb8oyIn+6HdP/xegjHGuK6bkDKM+IbgtNS70B//gacI7r30IDcR8TWSP0X610bcClNVKoRT7rhfqg9fdwWmFBzZHbZLsXgJNK252aBNtp7L5VhDxh/9BIclc8BYCGpiHIfEMXZxi5kXQk1zwkSBTGvYGMqClgrQSLtlYWWk7dprW1S30N5yX44NdTJVfNfQCHd1FJ5LhH2840QX/G68CxcgMpEVDNmkgsvz8RtUpW0J7LSyT9RgSGq7NSWqgXNRscwqycO/vjdvPViIAnz66knUrpZjO9EEbXgQwnUMNkJEO3CjR2gesP6KvL/vPhTa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:12:41.9936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac80f95e-3263-48b3-8fdd-08df19851d35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6651
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

From: Yang Wang <kevinyang.wang@amd.com>

Handle AMDGPU_INFO_FW_MP5 in the firmware query path and report the MP5
firmware version in the debugfs firmware_info output.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-By: Frank Min<Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 12 ++++++++++++
 include/uapi/drm/amdgpu_drm.h           |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index f2f179421c4da..bac072d73e16a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -285,6 +285,10 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
 		fw_info->ver = adev->pm.fw_version;
 		fw_info->feature = 0;
 		break;
+	case AMDGPU_INFO_FW_MP5:
+		fw_info->ver = adev->pm.mp5_fw_version;
+		fw_info->feature = 0;
+		break;
 	case AMDGPU_INFO_FW_TA:
 		switch (query_fw->index) {
 		case TA_FW_TYPE_PSP_XGMI:
@@ -1937,6 +1941,14 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 	seq_printf(m, "SMC feature version: %u, program: %d, firmware version: 0x%08x (%d.%d.%d)\n",
 		   fw_info.feature, smu_program, fw_info.ver, smu_major, smu_minor, smu_debug);
 
+	/* MP5 */
+	query_fw.fw_type = AMDGPU_INFO_FW_MP5;
+	ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
+	if (ret)
+		return ret;
+	seq_printf(m, "MP5 feature version: %u, firmware version: 0x%08x\n",
+		   fw_info.feature, fw_info.ver);
+
 	/* SDMA */
 	query_fw.fw_type = AMDGPU_INFO_FW_SDMA;
 	for (i = 0; i < adev->sdma.num_instances; i++) {
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index cd1b8034a2fb4..29009f6aabde9 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1183,6 +1183,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 	#define AMDGPU_INFO_FW_IMU		0x1b
 	/* Subquery id: Query VPE firmware version */
 	#define AMDGPU_INFO_FW_VPE		0x1c
+	/* Subquery id: Query MP5 firmware version */
+	#define AMDGPU_INFO_FW_MP5		0x1d
 
 /* number of bytes moved for TTM migration */
 #define AMDGPU_INFO_NUM_BYTES_MOVED		0x0f
-- 
2.55.0

