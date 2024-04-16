Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5DCC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 08:52:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79A8F112B04;
	Tue, 16 Apr 2024 08:52:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1lyJdUn/";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89AA6112B04
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 08:52:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxuJm3RS+uaLVcJEtigQgyu0SC6WULZvlf7f1ztGGo5NTHcpJE8J5z3WTq03U+8HSuqYz7qhV/DEtP/CysKX/XAPQsB2cNMrZub7nj6oe4FcpfL81Qgy7BA6owbNI89Ly9OhSbYui/XvLWJ3ztjqcVWtUUJl1jJC3mhp5YULnBA6PBzhvH0ZHPBmsIX64bdL52JomqEQpIxI2AXC7NAzfvwso/UY+sjOa4Lbtyjk3Vxbi+nP2HRgikGTCFtUjAtIl/iumqpqBY0pP6n8TfAoX1dYD6iRsckYzioyj4i+mjPJdCnwekKbunE1Et0PlzKNRPYrdzRt2DS3NBR9mSOwqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdJejFSg3Vpw9r6Tht8C3jnh7wjcswLmGA206F3lD5E=;
 b=jMBTldOG1vCo7Iz5Rf6+gwiPdipsQ7K5xQovE+RjmtWjTfOLQRupl9XdMTx49Uuo81qYCp70q+UNKobYdJ6vQapF1M2IDB6/kP2dU2HIEpYT9+Z/SVYUG3JJ9EvjQFOvh48BFugBF+aZxb5nxpOmQOcdTh9njy9EpgIOzwwgggvlthjX0CksiHFg7kKk6yav1zzR/tIdNbK71aZxZtz1fnn+ohg6km5qQ6URJkbROmLji8dgZybyyRI6fmBv7iZh9qszO87e7LPRX08U4mNN4v78PN2rLznAPKREQEpkal4CHrKsa/wZIYnOgDoRkJwcY9UfSDywLF5iSno+01wgLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdJejFSg3Vpw9r6Tht8C3jnh7wjcswLmGA206F3lD5E=;
 b=1lyJdUn/jZ3x/LFNltUnvRdSa6cgKRwiB4Ewi+gjO1BgysmqR9NbFmVptK4dMxVzknlCxULKmGtOU0LesVYKpdBXGNOBpRhZi6VVyS+6dc14ossk21otjdHCdvA0wh06dIcjDymD4j7wfz3NJCARxzfTX891ZaIZTYd2y5voXug=
Received: from CH0PR03CA0433.namprd03.prod.outlook.com (2603:10b6:610:10e::18)
 by DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 08:52:04 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::42) by CH0PR03CA0433.outlook.office365.com
 (2603:10b6:610:10e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Tue, 16 Apr 2024 08:52:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 08:52:04 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Apr
 2024 03:52:02 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: add firmware info to benchmark metrics
Date: Tue, 16 Apr 2024 16:51:49 +0800
Message-ID: <20240416085150.2459820-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416085150.2459820-1-Prike.Liang@amd.com>
References: <20240416085150.2459820-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|DS0PR12MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: a1b10937-6587-40e3-7905-08dc5df27d82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o+D4cqw54Tfx2laIHoPTbDWS69y3GHwxcfOSLxYRw2zAhtG9RO3PaNZ4I0GfQNfCSlHZYAm/Tb3+VvuZxRoLiUTAWWXspgwyERebcTCsQzXapZAjy21oxdHP5VLuD+9bD50yJNl59kNpy4QpTApaqM36T8V3SPOEJwPii2pc3PovklUHCJJo+eGnoT62kcnLq5zsdeRtEYt/ZZ/RIe0FUvceBLddMQDW/DUMpXwEIf9ly4zX2Ig8jtf236P3JGVxo3hzdPGskG7+TV4y1hud4XtaExTOMq5pZRnUAXKQCxxyoOHin3UNyZrdKSq6qYxO4dgdreovbUw5ESNEeVHu8ug442islQXs6F5SIOSX+tBEDm4yeu5b2Fv4Lms4/j2yBiwLi/iWm0iDx6+2wb6O/ZY0ONf5ZSKNA1PNdSM0QMJXMBtFM9wSosIZv9ysarje/waT3FIhFkBmHG+5t6yDU9ZY47Dg9cvXv6Y9odgi3YvLWGF0z+fl4VcmPXoNaqaSB0FeVnfAdyujNEkkhyqfbmnMy7pAlh72dXEVfzGHunMK3Iv5ZofuXzyq/h0TK45TDAdmCIAhVa1DcaGKAFHp62a21sAUv8xlXYiaS8bGmpuU4DKpKPDY62AneBGpf3y1Y4zfRAP6oBPJ6vcyHOUgBQy9ZyNwPS9yWq3Fe2VpgKRNfTk82oEw1c9k/FCQ3iRkbMIncTFjlqrMDO2NflnzGI6hQqEK8Nt6Nvi7YmMeiuM4KLDIvsmI17UBskqRpOFL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 08:52:04.8314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b10937-6587-40e3-7905-08dc5df27d82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8503
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

Export the firmware info in the benchmark metrics.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       | 5 +++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
index 20784c407e0b..f6848b574dea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
@@ -502,6 +502,10 @@ static void amdgpu_benchmark_driver_config_dump(struct amdgpu_device *adev, stru
 
 	seq_printf(m, "\tvbios: %s\n", adev->mode_info.atom_context->vbios_pn);
 
+	seq_puts(m, "-----------------firmware info:----------------- \n");
+	amdgpu_debugfs_firmware_info_export(m);
+	seq_puts(m, "-----------------firmware info:----------------- \n");
+
 	seq_printf(m, "\n");
 
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
index 0425432d8659..9f802cad828e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
@@ -33,4 +33,4 @@ void amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_mes_event_log_init(struct amdgpu_device *adev);
-
+void amdgpu_debugfs_firmware_info_export(struct seq_file *m);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 5d1b084eb631..a7d878846907 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1869,6 +1869,11 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_firmware_info);
 
+void amdgpu_debugfs_firmware_info_export(struct seq_file *m)
+{
+	amdgpu_debugfs_firmware_info_show(m, NULL);
+}
+
 #endif
 
 void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev)
-- 
2.34.1

