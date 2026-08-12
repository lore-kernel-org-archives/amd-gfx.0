Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F54C5B56A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 08:09:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B21010E3E4;
	Wed, 12 Aug 2026 08:09:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LyKIsNdO";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010041.outbound.protection.outlook.com
 [52.101.193.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24EFF10E3E4
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 08:09:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PO9tQQPOFLv0a44aiP1qANxWuAa82O6rEDmBSl+a9F+ZoV45bbqXg4LNz7ZgnFrOTAh36NvtA9BcJFCWuxL54e/8k+mTPqIJOw+gyh0ozM5XTrGRZQWV00N8T9ST43OVebdsPtVVEtSslTJjFwHiCmFjTB7nlcg4NlVoZ0JzQgumkw6UNU3T+ZLfhIQK4e7OkmBhqAiugvDc7m/ZZjSPUxuBly3k/OKIHgp9zs9bZXBZ8H/mgRBoj1KvNWXruPKaLdhPmoRwwPUPuTta1mq/2Z+6Z4O7CIopqASmK6OvBdKhtcu/XqgUppdmA+3QAZQmB1DOGzpR88ZuMgHVMItJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGiOInf4FtWvxw1Mevy4NhkhUm7ZM3qQtt6ScwYuXeA=;
 b=U6IclD5RT61wLU4sQl4ff289JjwS3Y20Tz8FoDGCjRtDvufL34arI6rHDlb7uNEaauO6h+BLAwUr93vgel8Y+6HrUYF+6p/86xhG+Xd8qNo89MBJEFd0VYAVQy+X34c4nDhYgPP3bnmkd41SkXIm9q8EchlI6+dGteHwCy3TdXnS0KNKMjyONdkhL4nLTUvR8Jv5DPR8Hlq/lkkKJzf1mrmB/ulgsgcKdiNgxYfdiF9Plig4sdsOTqN4S92fFdqH/nRTXiFdZJA6qkdywf0oJFhwUgocrJ+6+C1yPw/tZWNc3wbkEehggZJl3ehKmw87k6MDMQNCbeSrm+Os3unxoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGiOInf4FtWvxw1Mevy4NhkhUm7ZM3qQtt6ScwYuXeA=;
 b=LyKIsNdO9T8JcyMm8I6GRWqV6s2dPXtGghreHRB6tcgLnm+uSOGsB2xCKDbi4M3eWK3dFtYduwIEqEEVbJ0O7vHyt0ZX+X7bTFX+UaTsaHvRl0cPV774UbpC8D2uwJoNvrupuzEsEv6EXoxqhnXYk18VluHlfVWiBMjT2ArBdFo=
Received: from PH8PR07CA0012.namprd07.prod.outlook.com (2603:10b6:510:2cd::6)
 by DS7PR12MB6119.namprd12.prod.outlook.com (2603:10b6:8:99::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.13; Wed, 12 Aug 2026 08:08:56 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:2cd:cafe::58) by PH8PR07CA0012.outlook.office365.com
 (2603:10b6:510:2cd::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.13 via Frontend Transport; Wed,
 12 Aug 2026 08:08:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.0 via Frontend Transport; Wed, 12 Aug 2026 08:08:55 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 03:08:54 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>, <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: Disable runtime PM for externally attached dGPUs
Date: Wed, 12 Aug 2026 16:08:41 +0800
Message-ID: <20260812080841.2936007-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|DS7PR12MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: 867125e1-6e26-4b2b-6722-08def848f4ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: /5zCLQZYLIFZMmfFmBS1Gi72eu3OG6sk6rdOEd6q7+qw2cjoaxjXVwSccYLjjEU+lpfXe3G/b0J/+2+st/Q9EeEyGNPnJRSJb4lOiFp/CpsalXgh6r5/6SE+mtdCBdIemGZqwxTvagpCE7hITUYsuhfFWt3lH2PCObnjkTBQfiXAPj4Ey8lSu6fSKm/GtqaceclQWnlnpDbs9OYY9GTZs0du2dUS4zQoZCvTsg2VBeNmNOvSS3BS3kP28gyZdVoL2wGprpHFEhQ6/VFBpi0jxZYIhH6KB6SfLfS3rZNuOWXk/DAEJKCxAxdCGJNNvCBMZf1CZtBKH/A8ytgF8cpJ9evrNAzoJ9g94QYuOX8YjWZryGNjdO9++X6bz9PGM8I4N6kPUfpb1OtlRAMYrlTOAqZjeoSvmk+QXLQDoLno1CmhZ6tjNgMwhY1+XblekZ/fNmSvmJJfoHGUSnBoYYJJ9h+8GXsqROwh7MIPuuYCJ93EsB9ClfvPVkuWKEUAOortyHmM5zMIZQgz2wiixZPPF2NHMcjXyWpaDQZXKva962MxsmLbwl1oW77qfMKMGj0TITcaK5ogXFX2xPqA0Fqyu1DpWqB3eWQYprh/SFFqOeQBF9765orPaJqYvh+vqrlkQ9FxRwllmRvIXSqLPCwdFYPlnlqs8aCGIPLq4+YEd3FAbfzGQybFgj4LLiHcKZuh/DiAHvGLxevKI3tgT2JQ4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FIs7+qr7Lfb7URBNwMhLK7pz1IcBmUPbXEFSWSa1a3YxKqaB5LTxBC7wtBcg8BwXNxkzBnYAQe7/nDUe7NA9HxRR4tm5zSZzbVtkvEx1jYG8+gCPkLnCeFYymo6lq9PlOGUKoX068uIq0Wlk84lD0u0KM25ZM8IUTlde3BRo1FPMP4+yWJjr8igLt4PYLyxQetouYkPGhxccKphXaH63eOeA3G+phVmUZQw86YekVfP3C2eB9d0jS0gf6XCpQi28g1mw5wrPopHQCce6jkd/OZe1vNTE+L7j9z0SeGsH9arMIahAiqr1RdejK4Toe4JGsLzV6TZFV+woPHvL3+yP3q65f0FtZ3/kCIAMUqc3wdFVOfdCT9BEKf31jzwGUl5I7WT+M9e7h00itiPqSSpnJQI8V0HauNm4vXs2ttdTGoRP8lgAPu1J0yKvhoNZhIB+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 08:08:55.9273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 867125e1-6e26-4b2b-6722-08def848f4ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6119
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

pci_is_thunderbolt_attached() requires an upstream PCI bridge with
is_thunderbolt set from an Intel Thunderbolt VSEC. This does not cover
the affected ASM4242 USB4 PCI hierarchy:

  00:02.2
    \- 0f:00.0 [1b21:2421]
       +- 10:01.0 [1b21:2423] -> 45:00.0 -> 46:00.0
       |  -> 47:00.0 -> 48:00.0 -> 49:00.0 [1002:7590]
       \- 10:03.0 -> 76:00.0 [1b21:2425] USB4 Host Router

The host router is outside the GPU upstream bridge chain, leaving no
ancestor with is_thunderbolt set. PCI core propagates DEVICE_REMOVABLE
below the external-facing PCIe tunnel. Disable Runtime PM when either
pci_is_thunderbolt_attached() or dev_is_removable() is true.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8ebe24d59ab6..a4b4f9645c84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -609,6 +609,13 @@ void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev)
 	int bamaco_support;
 
 	adev->pm.rpm_mode = AMDGPU_RUNPM_NONE;
+	if (pci_is_thunderbolt_attached(adev->pdev) ||
+	    dev_is_removable(&adev->pdev->dev)) {
+		dev_info(adev->dev,
+			 "Runtime PM disabled for externally attached device\n");
+		return;
+	}
+
 	bamaco_support = amdgpu_device_supports_baco(adev);
 
 	switch (amdgpu_runtime_pm) {
-- 
2.54.0

