Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FA2C54E71
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Mar 2024 16:50:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47621112615;
	Fri, 22 Mar 2024 16:50:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K6tVEhle";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6018112615
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Mar 2024 16:50:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9GmpgHzVWrFTAJPwQVFi1/YynW9ubTrqyl8IxgqwOle/QdDYPnwCKWvdNg8MKyCPJCfqxQMrEvYxNoZI1e7qPBZ4W3b51w0OKng4b+JSDt8gFq89imdKLknc5V55U8ORlzM/s3wcwn2yaORW9LB1caoN5R8flJ6sg1wrDUF1+yUcze++PT3kCFEapEcZjVMmKIbltIhuAlmKwhXh0JMtds40RQeI4z0Fb5zvP9b9UDQF2jn9Ba3VCQ3SX+RXgfPSz/04OrLIbiNQXfI1Ig6azS2s65EEdwQ1aR8aTC1+UraqPOwStD9iy2tRwGotowa9Dd+bwpfdUd1RaqKvj9A0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nyyP37dDRNXB+o/joQdadh3sEEDAsKZ96Qwrrz8pZc=;
 b=CBpHo4EWwqXQ79GOuSX9502M1P0DRcuUiqmjaL8PTdVrFJj+a8DIcGpi2JtgCmlbvtzPPxqHWEO+NS8MtDA/IJRA/gTlMdbhXqgLU3Sso+fKo/Xx6ehmQfFcK8BKY03lMGJW9UM6XwxsM3osJvS7I2S26UUepjevsoZIiJeMt1hLZ+WU8ysK5hzsB+ck+6ZfZMJjg1o1rn45/1nmhqDCi5fUmlPdpH9z/4fR1z0/EEOkgAlj/Ffoxh7/ZTtXNwPtzGNAc1yj3cLbj0QRgpiyTgL5hQzrW5J07PyYy9W9reO6bMBPSUj4R9g+QSSKcdIPWUiD6RDSlhNtrePou8JUzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nyyP37dDRNXB+o/joQdadh3sEEDAsKZ96Qwrrz8pZc=;
 b=K6tVEhleG1U+UFOzKqMpQFE7nqbo2G1r3p3q5GgkWDQ8BjQr5JlvvQiWecNex4PfJaY54I26w1TIts8RXle1zoIly6FxB3122Cz278sGDnZtLFVFqbRqrG6plk1hN7Z57Is+pN2zVoTFXWX/Bq6cgrzhUvg+m/ffsGle3/QmE3U=
Received: from BY5PR17CA0057.namprd17.prod.outlook.com (2603:10b6:a03:167::34)
 by CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.29; Fri, 22 Mar
 2024 16:50:11 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:a03:167:cafe::5c) by BY5PR17CA0057.outlook.office365.com
 (2603:10b6:a03:167::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Fri, 22 Mar 2024 16:50:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 16:50:10 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 22 Mar
 2024 11:50:07 -0500
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: shaoyunl <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amdgpu : Increase the mes log buffer size as per new MES
 FW version
Date: Fri, 22 Mar 2024 12:49:56 -0400
Message-ID: <20240322164956.167498-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|CH2PR12MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: f7978a55-c7a6-4e6e-3787-08dc4a90235d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vQhVCL12zAnDk8wMDgy6HhuKXnXrtwUpM2W3/U+Cs5aRyu1z63/TYM3VXgj01+CSMEN9bv9PHVGEGbSRzdn14zQb2vyQTeDyejkGcFI/7Cvya1Lz4YtnmUDd5+ztbagKwVa3mX3VD4u4DDM3daiY5w/DXZ2HTrqAJXqDsvmRSnFcIGi42pDcTtoxjHzvqVWx5F8d5tIsISlGkF3tREo5K64gJR2QfoJmbGPqIA89apz9l09/MdW8LEh3+urbLtT11Kavw24RIi12e6cFcT8fnH+Qun4dVbfQLnxkUzajLNbDRMgmHdWmyHXwj7gRHNpu93qWIKZxNqJyxW0HQZrS+AzbayWnL42fXNpkqAHmXBbzJBkPMdeGF0vQltlTicRa8mpNliIbwltfzm0+E7mS2I3iJHGYMu4U1BKVrynJoBj8CBpjYT4I5wp8xEgd7f0Xq0CKrqvZ8SUbvjAnYdbn7MFyyrxJ5I9pUqauVXsZJIcP3BrAc9epd7SXezWSjqvaG/hpUqebwVlvExzoUKIgzoanTG/jTKaFp4cNI9YcjnfwGjJJF2gkLwXTt0MRlxG4Rtzj6i5aVVeEEmkt1dIdNm4W33dLPmTySO4zGRnY73uhhTI1V0x2vPECtp6cwe+Vg8oC2HUeaAFMbUPHM2qGwfesDtJNVhuRjGr2skJAVkSRnnzotvRnV/9YeBvptbRJFLLYlZVwG7CKhijJDhy+ZqSDsHgt86cTNbnKZsEEBkKwgQu/nNH2IX96dT99FjYaxnRgFCW0w5QZzrLT2UM82A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004)(43062008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 16:50:10.7887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7978a55-c7a6-4e6e-3787-08dc4a90235d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134
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

From MES version 0x54, the log entry increased and require the log buffer
size to be increased. The 16k is maximum size agreed

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 5 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 9ace848e174c..78e4f88f5134 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -103,7 +103,7 @@ static int amdgpu_mes_event_log_init(struct amdgpu_device *adev)
 	if (!amdgpu_mes_log_enable)
 		return 0;
 
-	r = amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
+	r = amdgpu_bo_create_kernel(adev, AMDGPU_MES_LOG_BUFFER_SIZE, PAGE_SIZE,
 				    AMDGPU_GEM_DOMAIN_GTT,
 				    &adev->mes.event_log_gpu_obj,
 				    &adev->mes.event_log_gpu_addr,
@@ -1548,12 +1548,11 @@ static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
 	uint32_t *mem = (uint32_t *)(adev->mes.event_log_cpu_addr);
 
 	seq_hex_dump(m, "", DUMP_PREFIX_OFFSET, 32, 4,
-		     mem, PAGE_SIZE, false);
+		     mem, AMDGPU_MES_LOG_BUFFER_SIZE, false);
 
 	return 0;
 }
 
-
 DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_mes_event_log);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 7d4f93fea937..4c8fc3117ef8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -52,6 +52,7 @@ enum amdgpu_mes_priority_level {
 
 #define AMDGPU_MES_PROC_CTX_SIZE 0x1000 /* one page area */
 #define AMDGPU_MES_GANG_CTX_SIZE 0x1000 /* one page area */
+#define AMDGPU_MES_LOG_BUFFER_SIZE 0x4000 /* Maximu log buffer size for MES */
 
 struct amdgpu_mes_funcs;
 
-- 
2.34.1

