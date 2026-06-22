Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A865CDB475
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 19:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B4FE10E854;
	Mon, 22 Jun 2026 19:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WiJ41KlN";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012060.outbound.protection.outlook.com [40.107.209.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A70A10E842
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 19:57:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFBWOF9Bf4UVCybteHLybL8k4uQTuPSTGmzDtHTDKXrVNy4+tMurt+19krDeVH9LVWsBkvVYhybMHySsXbdkrVku2zXBx0H16/lU1KiOrgyxfpkFs15BL3m/zKs7H7VHYdUhIGZz6XwbiarbDKBCH9t1QXbnOeARuOS7fz2L0GAvmv8rCY5Vh28QCj6mafjpAUR9N7s+FUdck1NBGPJ3cKNc75p1mEjmwjhSh7Mv6RfuuqaXwdny3BxbqYEwAxHQsZosjz/GDtENhlQ31kc4z303q//Q/ZPPepVJS5yTZi27gqi2MsWEHQQNmTPbgIwKrAvan12WROUuSnmxfbVtEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvpTT8aoDCAK0LUhdxqPur/UOyQF6yftjPwAYcA+QbI=;
 b=SA+jovJ/AbPO6b1ur/mQbyBgOI1uhXnvfuBy3K1WJHSUetJ1gI/X2p/sAeSEQIYA/zd6g+ttU1EC+pX668ZCsKZL/yc3fm5Tdct+E6xVAC+hnj0RlJxoXg+Ynkw2V3K9km3HfyWfbNnftudTqk0gvBoyqFoOhy3LME8MvLatixIR0sOeLmCKQwwB9GjZeh+aBZJf9UHbcJJIgKq98t1Ny/MLEG2fnyBiabUrOH73qJcwRqi8nlNfnSk/aB52FiRI1xU1y56UnQzEBaeEWiQNWIG7DOap5Eo54XdTgChYm/hvc8RfPmgF1TQB6cHkRvE1PQq3SCA5w90x6EJhDgHPUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvpTT8aoDCAK0LUhdxqPur/UOyQF6yftjPwAYcA+QbI=;
 b=WiJ41KlNKJCu+2JeSj/ZjgM2NQN6AZThHerzEQWOQqexIgNf5LgC65NgiH0MZg6N0D3tibrpTIVNItfa1vWzp4JIWVJfb4Aa7CdEldiC09b4iB3pglus1tVMA8ewKUE6AOywWxEzucBfH/+K1ib4/N+ufc/chJUMWRlPm6IYwwY=
Received: from PH1PEPF000132EA.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::2e)
 by SJ2PR12MB8928.namprd12.prod.outlook.com (2603:10b6:a03:53e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 19:57:48 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2a01:111:f403:f910::1) by PH1PEPF000132EA.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Mon,
 22 Jun 2026 19:57:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 22 Jun 2026 19:57:48 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 14:57:44 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v3 6/8] drm/amdgpu: move amdgpu_allowed_register_entry into
 amdgpu_reg_access.h
Date: Mon, 22 Jun 2026 15:57:27 -0400
Message-ID: <20260622195729.181216-7-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622195729.181216-1-shahyan.soltani@amd.com>
References: <20260622195729.181216-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SJ2PR12MB8928:EE_
X-MS-Office365-Filtering-Correlation-Id: cea8aa37-b485-4840-b6de-08ded09888e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|56012099006|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: nTrLiP0OPQXFvo34aXRfLLUbtPqKx3BsN7+PcEYj/g+mVVo7B5usZCU6PV2+6XCWsZF+awlLWw3lxxablGX11+dTKZ6cMYfWfQR1glONa9STlB3iTZoTCiWCCrEKJ1OhqFtIoaWXdSWIeQmw2j6Yg69gtEGZmbV/H+tyzpqnAeyy6p87qG97EkgOogY1+XB7drcBIRBhNk83RxYX0Wmevs++kMg86ejUsVI+/ApojOLtCYQ9mtQVgJ06cycWxGVE1kVx6E7OS4ZRUh32eNDGwe2ldb1uSYW+xld1eBc+x+gqKiEwmLO4oZlSdQOHt9EsOCaMafi5d9Fua2hkFtMBm6h6VAI2MNtNXz8aLIYktrzC+wXGA8L+iALyDbemUS+nUSOuylL8s8KYvzO/up9C2p8NqKXmdZWq3wpvcCgNCZcVU6Sb3+0tnVxRFMCLKLSl+PUD2spfjDH2Aa6enAHHvY3XmMDy/1Mt4OamopQ3lyUMvkdRYF9EiUgcmPNbqSbeN2MOmxVPt/xhvMQeWd0vinP7tve4DH36JnSP3ejypjGJBmPnA0Xk5H6+FTSHkiZNjpWXmMcnOoHneLs+2Ldpdhl7DjZtBn2W6JAVnFWBopgNHox2fuk5yLFu0NWn4RZF232oNngpZ8HUPHRDDLFKiwis1oeUJkw1JBjvHBG3cnWKgAJ7f0RRK1FNYrCpxXmnqUoXxxTAD6MTIxJ4lDO7Rg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QrD/9pI+v4fUwD2DYyXEVbCaPOj9iSKpVe968PIozqK3xQWz3d0lE8V6fH5L48uT1Im9XUd5JNxwbXysrqI4NFWIS26HhM0QjTb8ttRVoWf57FfJncFV0MUF5YfB7STJqF5nCvCVxQOVwDTxbowWcYZHV1UD64JmMZl1WRmWLFoqIgcNwtLLk1UBwJaVElySFe1PZ+B8En8y1yvO9MDsXjiSd1CNFUA3fT5fYkHiJHbqeq/dQrEpgHzFXWe4z1jGTVPOdPuoBd/+kdox6b6W0e5Z5/shmRsEQKEqnIfHZ1jCUzlv6Ls+HtSnRVoQ1S3I4n62vksuFBArA4+a+ZyeR19TS7JqM/rCtUm18H4w/ZGvECH6E6d3x5/bponjTei5Tix5nYd6NSKJQQFtotxxP64iEayzzu4eJn1/2llsmMRAjHnIoRfKGIKKeGFs+/mR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 19:57:48.2414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cea8aa37-b485-4840-b6de-08ded09888e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8928
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
Reviewed-by: Christian König <christian.koenig@amd.com>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h            | 8 --------
 drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 24c6a21efd67..fff532bdc6ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -431,14 +431,6 @@ int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
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

