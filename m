Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2905D3748A
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 13:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7576110E822;
	Thu, 17 Oct 2024 13:21:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IrhiOJIZ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6669810E822
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 13:21:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPdEHTXc+t2xxTiCfMLfM4QBdcSR3kzAE2Lol8WKyA+XnT2wTu2rcT3m7y2SWOlc5PKElpbXD3jXPwkVyOA1q35dvmbuVX+Xd1/xjJRLr7hbUW87bSxQXEBx61sunSZF5IZu+Pba992uNxyB2v/yK0nhVwSE3hcnnZljJegMWC1fZjmxLeuD/Xa6YNOB6B3Nxmx81GaqX/xlH/+bsb6WPON+ExfSV9YIhEhZf8UMFINCEn5A9nGvFR71oKANWtOP/Q8HjZDXn2nNENdyWFSp3tgYKRjvlYlHoYCZTM5FyGhW8foqh5XwViOqyTZq9EZO44FFLSRMeFS15+xq1akYWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOJjsrfy4akpTBFSfy1W+jQjQTEB9rXzw4WkUIT4Hh0=;
 b=luZVHmSwdza4zhovUpROrgOdlE/XBDbjOFeArL4Bq6F/3Z7p2R4o/IVy4goJ1zovd+qnW4CY8NdicrzH/F8EF5KIsM/04EH1i1rVSy2WuOrfe1R7t/kwkvO174bkiUtN7URxr3H6cAPytzsG29y1IJb7NBge73u6qKsfQZGyQ3/rVyCXLYnXquhkr9RECIWzxaQIzw6NnN1nNW+xDEMehgz5b+aDPGpUGdZqtmoL0n8RU2vm+qVvgJ7Odl5Vw76oKhgNtUebe8911MzSc6jGSYc8Ko25066xzV6AJYRYCcvcE93Wyz46LMo3xNQdEVJuPQlQkkDBQboRbKoA2dGbZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOJjsrfy4akpTBFSfy1W+jQjQTEB9rXzw4WkUIT4Hh0=;
 b=IrhiOJIZ6A6NnUdaprIb0NiMCiVfEWBPtDjfHrrUHGk7tB8Cr+E0VNe8JdKT5c5+hg5PYqUNZvjVfDVq6jl26NOa9Za0VU9jNAJBKTfRqRlalJcuqBjHotplD8rYbQnoV9u3OLdTywp3attJ3XRNlxr3N9lTz6XTDeXBx3G7axc=
Received: from BN9PR03CA0475.namprd03.prod.outlook.com (2603:10b6:408:139::30)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 13:21:33 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::de) by BN9PR03CA0475.outlook.office365.com
 (2603:10b6:408:139::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 13:21:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 13:21:32 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 08:21:31 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 26/32] drm/amdgpu: setup_ucode for each vcn instance
Date: Thu, 17 Oct 2024 09:20:47 -0400
Message-ID: <20241017132053.53214-27-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017132053.53214-1-boyuan.zhang@amd.com>
References: <20241017132053.53214-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|PH7PR12MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c003fc5-b82b-425a-57e9-08dceeae9e41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g0561D9F+cQXD5jAMZlq3XSdIof5b6CTyASIB5XvQ6wa+gxZToQRRxsA9owD?=
 =?us-ascii?Q?Uj6ONaEtkunbzdPhndhCokwD3wB0hjXcNzID5t5kZMgFccp6q9WoZcxe/tEI?=
 =?us-ascii?Q?iEeW8nh4ESbGaBCHuV822HnGmQIF+ZRg6ShGRcU3Ynp08UFRSp2X4n2rYRD9?=
 =?us-ascii?Q?/WPHs5QtQVergb7FglXWssfVmM1g1ZiQv5QpXoLludhza1T/H6GZXPNv30W0?=
 =?us-ascii?Q?x6m1/1GrTqrQzImhOeYB60H6lSE1iwuDRcxXQ2Spt2CCj716Jg/wSgAoG0/F?=
 =?us-ascii?Q?0u8YKRnwkgASvjAKp6M0uXmYcdb75dQExMeVc2z+AT05f/M6F1aNp9CFPPGx?=
 =?us-ascii?Q?Z5lmfuuBGZEXZLNcsL9o3uJP9V5Srf/HMay4RZtkZ59f+ZZTgp1nNqFkTXKr?=
 =?us-ascii?Q?15FLR0Jzfh3XhE7gDtSrS1NyE5Zzmv4D5rcl1YvDn5I7pmyrViatzNVXRs0A?=
 =?us-ascii?Q?7sqyPF6M/0mnZwCcckGt+vLfF+sv4DLaV8oN2PQ9cckudtprdLn9jRzNVqC7?=
 =?us-ascii?Q?w3nX1eeJQwbsn+CTgSz8xyuhBPk7ClizDeRW3jCUXHfP5JW6RnjiPfMS4VOV?=
 =?us-ascii?Q?xol34gJ7t6dngn2juUUeuANAP56pFpmWHjyN6vZeg/5IzwcYHtYAN63ISD+2?=
 =?us-ascii?Q?WgzLlyJQCOoJKkBK1Za1ycWL/xyjIWpixeu8Dn/JDITJ3e2k5x3QGvgxMKiw?=
 =?us-ascii?Q?XS/6ejHc7Vi0jt02DEx3E4HX+8c4g/vlktTRlH0lTAuXQaUdyQGR6WQKnTea?=
 =?us-ascii?Q?5jPQ/5IGyyYgOqIuUCDoyZw+Ca/sRR9B0WtGgm12jaW6Zw3g7GAWb60qYlJv?=
 =?us-ascii?Q?cC5oI4FygM8dC5qHukMNbzFQKgCHt5iP9UNJB5gIYoIje9KGUnUhjQ8wb7rV?=
 =?us-ascii?Q?6H2m100dShYLJc3a90edfZlI10asnZpL0bBgtXuJGwVUInw9yl2TIp1oqrQM?=
 =?us-ascii?Q?JmQOtN9LKPHDwXWGMyp9laO26lTL+MalaQI5/f7tzaGv/cCEWN6QuYgpDH3j?=
 =?us-ascii?Q?N5aESwXFCqmqkURzyGgvcT5HIRc3vOJFR8RNEd/nUtAL2qsWMJ58v8CluG2o?=
 =?us-ascii?Q?M9oUPzyEFKQI0rIu/8w+gWRwRkTfVyJaixMyOmT6h4czJ/cKc25CNBF7kCYj?=
 =?us-ascii?Q?Ki9fJa6sy1tULMGL6iX5YWdYGoy2fLmPxCUpGTJFFJy3N6J7QOgmN+DpsYCQ?=
 =?us-ascii?Q?F5nDF5VgSNRCqBDKMeitknAPWPH5hIGu37g/ng2UqaKAXP3HcrnlMZdsxls9?=
 =?us-ascii?Q?yNZ28jGUy7Xe/FeJduHnzVv5oJRW2x0+YfvnYhOhQZilCtAQQULBqeog0CuK?=
 =?us-ascii?Q?VqbraiaiVniceUQw5VwKTFROPcJUg3uAgGWtnCO1HAnGcd1o6FNVZu3K9GBz?=
 =?us-ascii?Q?k/MdrrjzoLbHIlhr92wB9pw2zNZUl3CTnWWULIHzc0FNzy7WNg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 13:21:32.5945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c003fc5-b82b-425a-57e9-08dceeae9e41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Pass instance parameter to amdgpu_vcn_setup_ucode(), and perform
setup ucode ONLY for the given vcn instance, instead of for all
vcn instances. Modify each vcn generation accordingly.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 37 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  2 +-
 10 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 67081fb4e96d..e442430e7e72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1044,34 +1044,31 @@ enum amdgpu_ring_priority_level amdgpu_vcn_get_enc_ring_prio(int ring)
 	}
 }
 
-void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev)
+void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev, int inst)
 {
-	int i;
 	unsigned int idx;
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		const struct common_firmware_header *hdr;
 
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
+		if (adev->vcn.harvest_config & (1 << inst))
+			return;
 
-			hdr = (const struct common_firmware_header *)adev->vcn.inst[i].fw->data;
-			/* currently only support 2 FW instances */
-			if (i >= 2) {
-				dev_info(adev->dev, "More then 2 VCN FW instances!\n");
-				break;
-			}
-			idx = AMDGPU_UCODE_ID_VCN + i;
-			adev->firmware.ucode[idx].ucode_id = idx;
-			adev->firmware.ucode[idx].fw = adev->vcn.inst[i].fw;
-			adev->firmware.fw_size +=
-				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
-
-			if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
-			    IP_VERSION(4, 0, 3))
-				break;
+		hdr = (const struct common_firmware_header *)adev->vcn.inst[inst].fw->data;
+		/* currently only support 2 FW instances */
+		if (inst >= 2) {
+			dev_info(adev->dev, "More then 2 VCN FW instances!\n");
+			return;
 		}
+		idx = AMDGPU_UCODE_ID_VCN + inst;
+		adev->firmware.ucode[idx].ucode_id = idx;
+		adev->firmware.ucode[idx].fw = adev->vcn.inst[inst].fw;
+		adev->firmware.fw_size +=
+			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
+
+		if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
+			IP_VERSION(4, 0, 3))
+			return;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 72341b7027a2..88f46a7d02de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -505,7 +505,7 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout);
 
 enum amdgpu_ring_priority_level amdgpu_vcn_get_enc_ring_prio(int ring);
 
-void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev);
+void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev, int inst);
 
 void amdgpu_vcn_fwlog_init(struct amdgpu_vcn_inst *vcn);
 void amdgpu_debugfs_vcn_fwlog_init(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 11153ca0c3d9..ab06c4173b66 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -154,7 +154,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 	/* Override the work func */
 	adev->vcn.inst[0].idle_work.work.func = vcn_v1_0_idle_work_handler;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index d36ab4368a25..59c6458c99af 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -159,7 +159,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 963086b47b1d..d90aa2a9f94e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -189,7 +189,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 098a523073b8..3547798ec335 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -172,7 +172,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index bdc3f37fe44a..eec9d4a0a0b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -180,7 +180,7 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index c44adeb4494c..f78c006aec27 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -137,7 +137,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index dd392b787790..31f05f377ffe 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -142,7 +142,7 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index b9fdb91fa86c..c0746684eea4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -126,7 +126,7 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
-- 
2.34.1

