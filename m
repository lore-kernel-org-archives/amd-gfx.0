Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F39C5B552
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C7FD10E775;
	Thu, 29 May 2025 20:08:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ORKnsC4m";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7921810E755
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xg7Y7K0YAxb4cnJgCQ6duMYaNqgJBmloUXzG8mi+c8KW8o/2tZTWj129KlYNE+MKIpEZ8TvoRmNUhNf5VwKWtKYY8YCv4dRezcVd0JXUmrVEemrEKIMb+y8HC7tyfy2T659yEWg7Gwz6eIgOXwN2tmvI3PHUs7PmAoG4R0vOmL5/NajdT8/FJehYyMnJxJ4G8UivhvrfYKYVwsNnWPc5CaeepEK0qfcItEIp5FxF14ozvqz6Me8hcS4fasiGeCe0FavdP3I+tYdSUWTcx3ShYcvC/NBX90otNMslZVnkJJZsRXA02n+AxL3mpkFlK1Fu1orwIxAtQnlTHD1zCoVzPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zw/d2l+6UtjlkbH2k5Amjpl8kzbdslZchR05V+m6WSw=;
 b=kNGGAfPTAbUNtubs/XgoBXITfBPwb60OQS1gp4FDq1ZPDUO+DhPNY1U7ahiSsSti4v9wa2QBcap4vQEPwUf7srWyM5JtGjMQM7kf2ez+Era/R0Hctg6xZcuURjZyfhycH650Rwla6egmJ3mVAYeaPmVlc5xykVvWfH4X9z5F9WvB88jKEWvtvI7rJeyexfXUWzEPySGw07a5o7OSgOSws/H/Pubm9RjGuIr5dKSNvp4QaYbE8AcVPwzsO/DgA/X0KxAY0R6DQxGCtAuOLfCrZ/yc/RHZoA05jfbU9DlCdko6+9lzMhmPTpDcxlogBr5R1zQ//i3mL8EA6RGYAmPHKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zw/d2l+6UtjlkbH2k5Amjpl8kzbdslZchR05V+m6WSw=;
 b=ORKnsC4mst3Wt7Us1l4E0d5Ttqb6mCwlQQwprCN+TGYkV13tDbJ/iZgytnDOdof8LrKDEEm77Y21fGkus9mVWeO6UZEJL+eX4BbHTN+JPPXw+e9Ht428Qc8bSO4XiNuuGNYKWX0q/hsVL0RHCKgYrSn78dif1eThoWJh0y3Vhl8=
Received: from MW4P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::16)
 by SA1PR12MB6726.namprd12.prod.outlook.com (2603:10b6:806:255::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Thu, 29 May
 2025 20:08:34 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:303:115:cafe::c7) by MW4P220CA0011.outlook.office365.com
 (2603:10b6:303:115::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Thu,
 29 May 2025 20:08:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:08:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 15:08:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 24/28] drm/amdgpu/jpeg5.0.1: re-emit unprocessed state on ring
 reset
Date: Thu, 29 May 2025 16:07:54 -0400
Message-ID: <20250529200758.6326-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529200758.6326-1-alexander.deucher@amd.com>
References: <20250529200758.6326-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|SA1PR12MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: caee44ef-a520-488e-b200-08dd9eec9739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?26qlwDQ4sIVqyLlviGVTJS0PjNFz5JBP1WjuDRyvHaozyXKRyXO9WHycjmuH?=
 =?us-ascii?Q?bnY9JE6mBwxGOX4FHquGeKO8up2uIZrILAutaXH7j4oeNRXzahRcTAwmdmHs?=
 =?us-ascii?Q?7AoXQGAwCFClWRbNg1T9sZ8bk3aKqe4jCNV7RPh5tkO3TSw0G8e6L7q1FWQs?=
 =?us-ascii?Q?7dhwGWOIatgzd2a4sc8NULixpo7D0hwQiEv075Mnx5AMeic8yCNVDIaWfQII?=
 =?us-ascii?Q?CUz2BWqxv9ibX+lxi9vYJpN3n+8/5tqfvDYSviUN1/NdVx8Xf2z0ROF38m6W?=
 =?us-ascii?Q?VxKe93kht2rd5Ju0JHavNA8zx6w0qC5O6JgdmKrjHdXDQ1zGOsSK2odb4g6G?=
 =?us-ascii?Q?3qHRkm32e44OYgCjnuRqtnOkloxo/J7+/NQ+fPl9Izrh33wDWhixgcF2e8+n?=
 =?us-ascii?Q?u/WkL0G4YXtRYLnpdgXYSasVo2+/xX3cH2F5inR/qlo8iZzmr0Jzz/3fm1x5?=
 =?us-ascii?Q?9TNRs6UeFk01FolDHkuchYDibQqm3AHgwbiLB1s5Ry3tzOdBGKtgvROuJhXp?=
 =?us-ascii?Q?iA+d5ck/0YULbL8yRler4IuCrC6PpYaj7/XYZqBl8cKmJj67nzZVLRn2IQbp?=
 =?us-ascii?Q?t4U1mOKry647KbNS0o1VznAe9nv2iETDWxO0WUo2q2v4Z2ZbFNl4/xrg5c+F?=
 =?us-ascii?Q?9U4uWLMxwpFLbZrcnBvwCAoX3GWySNcyCv+nLQgW6ooo7SdGpxWD3YZQGUBS?=
 =?us-ascii?Q?/WKGPMLAKoa3L4xiUQ0LUGF1kT0lF3dFee8OnMlLKh5SS8Eg19WY1RX68hwj?=
 =?us-ascii?Q?jy+StxSsPpeQ4gbo86hMVGdZwJP50LWU1FtJC/ppe1CCfzDZCXiVNc1ASheb?=
 =?us-ascii?Q?TrFcgHzC1pCPA7eQXbpy0GUcZXsuDQBQ6VIv2yidWGLBxaJQX2UTMQtE3zSr?=
 =?us-ascii?Q?BbqILQ43Wny1VseQmhJVYVA+tbE44zWdO/3DN8Kz5MLQcPHoBbruHvN+dw4R?=
 =?us-ascii?Q?+Ye1XNlaYSgcvWa3a8UPAai9SCA6jXSnvoQWZstFmBpjNiwVgXAI7vZT1vNH?=
 =?us-ascii?Q?yfJgJkarxE2gn63qdv6jUErsGxppLDsfNZI4nheM4mCZxgT813ve99/3audF?=
 =?us-ascii?Q?ms3tm/8EsFNqgEzUjNgneGmFh+PHVUgvXcaOutn+x7Wm2Avp0PSox4Q04Cph?=
 =?us-ascii?Q?8kaIe2t6TKuK5hPzhdZ1wmB6+Lwi1MvRHKggr5n+7i22ntoQ8WZHeU95BhUl?=
 =?us-ascii?Q?bAnX+Qa7um98hsPf/DumR6/IlHa6FR1KA3jRJdTkgx7kVFXvdqUpyeJYZlUE?=
 =?us-ascii?Q?Kg4vv18BfYe1UErkIpPC7ohAVul2FCMKCMbjrzBWAGkoj/YD1NdKWZ29146s?=
 =?us-ascii?Q?wuXFBmUH3VciGaUrETqNJP++lIvElSvYcIwp6YL3fNZIJJItpBzA48HyT709?=
 =?us-ascii?Q?XdojN8OUa0Ob9Q31dzpUfMagXzAB4Chylu+UKRLABmOCtycpXwBPeqA+DRb3?=
 =?us-ascii?Q?Mw578i2q97YFcVqSeg0JH+hPozSLKKVmO71ZKJnrasuDkYAF43bCeYjFJvwA?=
 =?us-ascii?Q?cYgDdE7lw38wtvklrYHbU0cZx53X/H2mipXC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:34.1794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caee44ef-a520-488e-b200-08dd9eec9739
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6726
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 858b930d1dd54..56112a319c375 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -841,8 +841,8 @@ static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 
 	jpeg_v5_0_1_core_stall_reset(ring);
 	jpeg_v5_0_1_init_jrbc(ring);
-	amdgpu_fence_driver_force_completion(ring);
-	return amdgpu_ring_test_helper(ring);
+
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
-- 
2.49.0

