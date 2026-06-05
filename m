Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A487CD6E79
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 13:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8AAC10E62E;
	Fri,  5 Jun 2026 13:44:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vWqX6TGK";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010014.outbound.protection.outlook.com [52.101.46.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BDD410E642
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 13:44:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0C3nR16rtA/R9rhQNNBk0Sa15pGRhCTUHXCQoKgVlVTdQ/G+xh+LaTtWFaNcSZKDpO1hsbWZyupKnXNX7DohMZx/JsnBBOu1NLrpeOZ0d11J+HOZ9+IHbPS5Fs47MF7h0qiLimYEz3UffO9M75bLVV8evlrOv70TYD4igQWQvUJG7b+XvRdOOmFZfTRKDR14Llj/n7Klbov4pGjdBjMDi/k4FiPvZOSZIL+D24JjfGhsUtNcwgeWlHSI2dKMoNK6EIcRm1VaTLYHGIl0lxz3+zPtj/NxfXZ+x6i31M3E/WK7ZY9ql4K3gfcXHkKQ+whVG6UcqMjgaLGoagb7xE5Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5C+yWLXxkf362eroSqQ+WoM6jSa92bfm9mqsZMzB7XM=;
 b=bdjTBsrdvb3uZUUpU0zYw6hjE9sUbIdKKSQyzpczBUX+wFQhZ+2zsfclWSymN+ZefgNvSgraT3jlMzPiy3ZMVDh5EUVzMlDIFCXUeFdGwb7vcw/y6sr8XmG89PMCRg6M1HQhZSihquwDZmFbOFeBAtvFVRfT3dEdrminGMeypk7f+95L18gPr4THjtO91gjh4FX+45ivhccbt/bkReEjlihu8h1r4vnbFxyhK7nFbtE2t5indaKIurObmqbjbdqb75WN+BBzu60PSF9o78CUaYNIp9Ln7l85n9bP9oiHPxuqyjhtkldk2F6zrG5MhW8i6BeVsbQCR2KzUkteMvDC8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5C+yWLXxkf362eroSqQ+WoM6jSa92bfm9mqsZMzB7XM=;
 b=vWqX6TGK4tFrN2Fq3RTFfdUq8lwGGt9b9ih+8ETJVEELO/197M0XKRo2368UNzRGNx4vRryKXVaNcUf0LxFbRZL6kaS43Jhfq2S1s4T+DFiYJqNQWSfGsOa9PqGYDRyfR2T20ZziXC5xcs5ojJ7b6Hkx0OVrJNqAtW6CmRIg1Gw=
Received: from CH0P221CA0032.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::11)
 by PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 13:44:23 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::e) by CH0P221CA0032.outlook.office365.com
 (2603:10b6:610:11d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 13:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 13:44:23 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 08:44:16 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shahyan Soltani <shahyan.soltani@amd.com>
Subject: [PATCH 09/11] drm/amdgpu: move amdgpu_allowed_register_entry into
 amdgpu_reg_access.h
Date: Fri, 5 Jun 2026 09:43:21 -0400
Message-ID: <20260605134400.956791-10-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605134400.956791-1-shahyan.soltani@amd.com>
References: <20260605134400.956791-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|PH7PR12MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a1cbaec-61dd-400e-11ea-08dec3088d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|22082099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: Lgj0y/m+BOu6/e6oGrhy86QwbPSVMasiW43ZwwhAjn9CoGcOJ28je4/+BVBCfO0Q9eKF8aG+RdMP6i1608PcoAzbrWk4+c/2cWDpG6BU9pchJGct4j3Noq8OwWfZ1vodGoEJ2BRqPP3I+gh/lhxAcree7EZXkRraYKN1rdmlNo1PPMMrQdA7lM5L74gPbfBxsb3cJM5GiU/UUu4ydiFly72rWO0V+V41ls19zMO0y3UmKGEeTJ+AR6XrKbwmtE/eDDVvx20S9lajQwlYLZVaU3uoHGRTec4HVdfim0UkB6RInusYp0h13aOPUnUHiMeyEtAA3bZUzU92DW7Pld/KDEhxlY83euIxcEtDGkJIsRrUa9O/aVxvSboHGMvVqo/L1dPE1196Ay/KY+g3JO6xN1QlH3QZPR0+taQmaGYL+9gsYAxjO7FadexbL3cXrfIotFSvxDrhC3TpBVsdVgtHZiYH3Ujhi4mo6Ib25om4K4Fkg5Haq6ODw4LEJRqqPSaLyEhnJRmFm+Yrot7Xoo/19FxjkwOqnm6sPpBw5hGuwCE8oCdAsjURxD6szQXlgvaaEnT/xttCnA2i0mHmiYe40k1Icr7v/p27CogSATNwnn1pNYApBthn72lvOjxJ5au/dY/6yuXThKL6CUDnFtrb/ed7LsDDOMNkvc1A7KYbcALIqzaG1fMOaS6VBZE4nrGkngfcKYKF+apa1dWVHJaItJSNnIGrMKCFthpVU2weWuA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: v+QiDGuhpCNqGIf4ReRQxAsOMbQ6H/yTZXvtl3CkFNrp8AHKqkwmHi007mOAhYhJy9R/NkQPAlTYAJgOvOdWSc3N4InXeLyYLQMOpA3p6Jh0xfWRtDnZ2o52JNLcfj1z9A3BbH13xcR0oODPCnI6e1vmg30l+I4Tlf3cEYDzIOLkR6cuVFQpw1YaxnYC5dZQx9YFJg+ehl0nyZMFq/g/SXHMojCNUS+kXBAdVWxVGnUOmNq+vKciyhxMUqDoamfX+FSIQc2jmLZzbt4g8J187eS6Oq5g2nruo2zFWRR6ho/HynHs6ZXy9N5LF82c7AnuB13siGS6DkAZwp7X5tFGg8DfYpLTAxDJlZzd/D8cF2FgdhxfkNDMFxGYI4q5hf0FQkLELYGmohJE4PM96kt4YLouyNrJf4gWb6Z6u5zx3ItY7VwDgpoBVVUZjt03zTA/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 13:44:23.2397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1cbaec-61dd-400e-11ea-08dec3088d6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913
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

Move struct amdgpu_allowed_register_entry from monolithics amdgpu.h file into
existing amdgpu_reg_access.h file.

This is part of the ongoing effort to reduce the size of amdgpu.h into their own respective
separate headers.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h            | 8 --------
 drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 8a6b6f43a320..d2b84c27a6e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -415,14 +415,6 @@ int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
  */
 int amdgpu_benchmark(struct amdgpu_device *adev, int test_number);
 
-/*
- * ASIC specific register table accessible by UMD
- */
-struct amdgpu_allowed_register_entry {
-	uint32_t reg_offset;
-	bool grbm_indexed;
-};
-
 /*
  * ASIC specific functions.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
index a1011af6b52b..320c30ce4a62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
@@ -89,6 +89,14 @@ struct amdgpu_reg_access {
 	struct amdgpu_reg_smn_ext smn;
 };
 
+/*
+ * ASIC specific register table accessible by UMD
+ */
+struct amdgpu_allowed_register_entry {
+	uint32_t reg_offset;
+	bool grbm_indexed;
+};
+
 void amdgpu_reg_access_init(struct amdgpu_device *adev);
 uint32_t amdgpu_reg_smc_rd32(struct amdgpu_device *adev, uint32_t reg);
 void amdgpu_reg_smc_wr32(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
-- 
2.54.0

