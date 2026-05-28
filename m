Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D694CD5BD1
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 04:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3692A10EBE0;
	Thu, 28 May 2026 04:34:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CBtuQKPQ";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013022.outbound.protection.outlook.com
 [40.93.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BECC410EBE0
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 04:34:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5x438jO+JXcUQU8cdNL7NtSuIurG2aC9uTqRg8gG/lgd9wjmsmgMA2r6yggPqndfVwSTVebHGDHuoF/uP1fYRkdk5FQ6PcQcBr2cyWcjygfJbHeVytzwFgu8MmCDINdx8mtky+fiRIBNNy+IQUugoHoTa9/Ctj6A0ldSaY/IkGzJmoDQnEfzkH/SkaqSoFuPNP5sIh0uHevFPBMMRwWJ05XuVLGXcQpUY9hn9V58uWy8XPo4RdEp1hMqw3WJyYC+YRWVbWmOqkJUcHUeKf5pyJ0uvCZ19JFV4IkYtjniBeZp9UhdQb66U3b0paeltxFMiu986grM+UfqaVRHOqvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3k3TMwyDyra23liWEQwFYHCdXwPTx9P6rRV0qpGa+A4=;
 b=mLqaVY5YLfkX8xXQOPd3/fFCBiDSFXT/X3d58D7xblOYPtBBI9niPFFRexPMGRIhwfcqz3pkn79F6wKOz4O//dAhZdT8/jN7FAZTH1ghQuRhE0nPfoad6F7x/fHOz1GntFi0iTMeXqsXr7cDqlulTlB/wrqCoCkTW9NHqW+yKfYjjaTeI/vH+YgYrg4ICh5RDq8gqiCVF/DDh9mXF6YI/CK/IweUPONtlT+w84xdALBGpRWMaQXBEHcPYGNmaE12RS55nCTAY7yh7OYQ3410sKs1FUEuYVogSFX62ZNhwfAl0usXnbttUy3OYyYwG4BoM9TLVydzNWgUqoblnZ8LcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3k3TMwyDyra23liWEQwFYHCdXwPTx9P6rRV0qpGa+A4=;
 b=CBtuQKPQyRXzb05jmJ2Sw0dAjAAi6DWD2atO+ZI/ayhUvelAEiEJA/vPEEq47VAnqehsFMo0ddPFXJOsBXLnqcKo7oBl6jSeH7HfsG8q1b7PFfEapMTvMLQxSwJJYg2uND8Ap6zcjdtmZ2CYw1n7PKQgJCBgrJZNg6ugjc3PZ2k=
Received: from SJ0PR05CA0153.namprd05.prod.outlook.com (2603:10b6:a03:339::8)
 by PH0PR12MB999090.namprd12.prod.outlook.com (2603:10b6:510:38c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Thu, 28 May
 2026 04:34:45 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::35) by SJ0PR05CA0153.outlook.office365.com
 (2603:10b6:a03:339::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Thu, 28
 May 2026 04:34:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 04:34:45 +0000
Received: from canli-build.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 23:34:43 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Stanley Yang <stanley.yang@amd.com>, Thomas Chai <yipeng.chai@amd.com>,
 Candice Li <candice.li@amd.com>
Subject: [PATCH 5/8] drm/amdgpu: NUL-terminate securedisplay debugfs input
 from userspace
Date: Thu, 28 May 2026 12:34:05 +0800
Message-ID: <20260528043408.237209-5-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260528043408.237209-1-candice.li@amd.com>
References: <20260528043408.237209-1-candice.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|PH0PR12MB999090:EE_
X-MS-Office365-Filtering-Correlation-Id: 760b5a9e-dc56-4ec7-5442-08debc7271c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: stdiHViEdhKONqLTepNxhU9VL2d9GgWbBc4zLHw83iLOphTM9cHzQ08S7tx7hrN/yyV/k5Azd0rHlQuO8ek9QPCutWSWRF41/3xu/0aNsk4YMfEcF4qBsMFkCQDcMtG3D7Bp6hFJGZ4CwvPqEx8EwJpjyK0i89zZhPPisBMfdSqCQ4tSCa+poTdkC9R4oBD43xaS4Gt5rodgPmzzQGRbGKxysIQ5f2DM22WWR8eM9LMOC3LRlTTBahUBowEuCuDuk+3Wf1fno28pdoWTiEmqe7FZIqKKf3ohOVJ8xuBz46jLbb9bi6D79lddQ1An18jvMkteeHP+KcYcw6FTopp7JSUsoVTEHzpvh3PZ0vQZpU/R5QfsiMa2v6QvhUOAFFUIOwE7g3ePZa/6H+SCmWfOJ/TMUFxtKkCMmRE654bmO5nurSs0LZ4FpPeQu3p8AqpKULQJq190/1MHj8LuaxdKK48/Q3L4QaIz1yPgHVAYs9CPGSpKuzo9ahgUqf6xjQVjBs595uYv0NaHKBdMedlt2+8wGwCuMn8WwdsR4KTOlJboKP0RLNAKqip79O2Bz9xlnC1cg0IV3fEhhGnMzpyoeCJVhGOnoSvTzrAtJvkHGu5pE7avnM2pqq7lKQCY+zc4WuVFWX7q+gZ6heQnES9z0xiqNC2dc0Or6Fdg4Si81V/za6pGwc0yImVuKXG6RzipsScvJNTsag6ENZuu7qB6R9JcejxKczdccN+stvltd3I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZeYFfxOFYKqUieLYUtwXzPxgreVFYGPlMc6fxOzPzyJxT2aIK/xNJFuSRTg1wg8yr30sIb74YG8KgmWd4byes4D2FAGqhMtVfdRrsrq0XkvBaV0hV3uOwSirxPJ4FEvSdSunD3DeZUfVh1YH1h1qbkYTZf7H674msbAXsZ2QfaQLKGmA8vv3QMhhDq2MHB1cLFfOzyCFa7b8Kh0mUIqmc4IxDfRPkszCYUcCb9zVtXQBRSWAS/arpeBidQLAHFYfpYACmbFoGg5KvvlSMjeO2gDrzR+sXTTrHIoRNR+z0G+dyTT/JRwvNynDU7kou1B7COSqAF8pnoAE9RJgOcnJRuxMg1vqvCecNn4RWDtcBE/JR4jNonMYdHAmNnOwZuclZyb0/HZDxB+/Lc7//WsmrTCHk6AMk+inmnMeVwODSO5wF3vD++YU9dYymw9sFmpk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 04:34:45.3199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 760b5a9e-dc56-4ec7-5442-08debc7271c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999090
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

Use strncpy_from_user() instead of copy_from_user() before sscanf() in
the securedisplay_test debugfs write handler so a full-length write
cannot leave the stack buffer without a terminator.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 25 ++++++++++++-------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
index 3739be1b71e0d3..6c6d73804e34e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
@@ -98,15 +98,17 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
 	uint32_t phy_id;
 	uint32_t op;
 	char str[64];
-	int ret;
+	long len;
+	int ret, nargs;
 
-	if (*pos || size > sizeof(str) - 1)
+	if (*pos)
 		return -EINVAL;
 
-	memset(str,  0, sizeof(str));
-	ret = copy_from_user(str, buf, size);
-	if (ret)
+	len = strncpy_from_user(str, buf, sizeof(str));
+	if (len < 0)
 		return -EFAULT;
+	if (len == 0 || len >= sizeof(str))
+		return -EINVAL;
 
 	ret = pm_runtime_get_sync(dev->dev);
 	if (ret < 0) {
@@ -114,10 +116,14 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
 		return ret;
 	}
 
-	if (size < 3)
-		sscanf(str, "%u ", &op);
+	if (len < 3)
+		nargs = sscanf(str, "%u", &op);
 	else
-		sscanf(str, "%u %u", &op, &phy_id);
+		nargs = sscanf(str, "%u %u", &op, &phy_id);
+	if (nargs < 1) {
+		pm_runtime_put_autosuspend(dev->dev);
+		return -EINVAL;
+	}
 
 	switch (op) {
 	case 1:
@@ -135,8 +141,9 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
 		mutex_unlock(&psp->securedisplay_context.mutex);
 		break;
 	case 2:
-		if (size < 3 || phy_id >= TA_SECUREDISPLAY_MAX_PHY) {
+		if (len < 3 || nargs < 2 || phy_id >= TA_SECUREDISPLAY_MAX_PHY) {
 			dev_err(adev->dev, "Invalid input: %s\n", str);
+			pm_runtime_put_autosuspend(dev->dev);
 			return -EINVAL;
 		}
 		mutex_lock(&psp->securedisplay_context.mutex);
-- 
2.25.1

