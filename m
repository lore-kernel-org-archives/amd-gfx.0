Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8D6C71136
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 06:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A3AE10E038;
	Mon, 16 Jun 2025 06:54:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ip/LPp2y";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5D6610E038
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 06:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vM0UMx9eF3ksSAfU9ChvuESzw0Rr0QAR5VhtbtmNMSjIVZM6L7/ugYnHss4CMiRl8f0JGQqzocjxorNS4wyFOMPKmpsiAIh9PZFjW9ffLsulchbofD2plogT+Sthyd/C8nzV6DsqOvNafPcnwa1szZf+j3mZDvY/McL5MhKzok3QzG9nWffTnGHuDWfnS0ANEftqyBSWHF3l2UfMIwD/aP9qNwNPIJ6REjAXRj+r3Kd6Dv8In1kT0Q8Rv595dObc3DKScniQCyfMOl15GVILorTjX6TsDb0e1q+EioWWqMViQZhkhPGTFqB3TZhkH3LxzkZUyaz1eMIOEsWiHfCo6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+lVob0Qgkpw7ze2wh4tgXE0jAzJD0yzAZB8aLsyvNs=;
 b=jqNgplh5tDThqVZ7XnHhO4a7w4O2C5wCg/90at6gNlCV5+584GDEwWEvJIqBdIDzV/mgrMsCNR30gLCl0S4xQelEeYJ1rdpHxIrZFkxND2/SsQVEnGXKXwUYDxcUctn70j6Gv4zaxaYE5W++BsnXTQZ6jN9xlj8/V3NpOlnRXOkfnmzb4tqhNuvRLuwbJD9GkTYXUbFsJpn2LVmuFyc1waTufrlR55R2ADdrVUwsB0hJPqOGappFJsGcEJ5ySyyDWkZOpFTDq6wBmNOhp7GOJQPOWLdSFn3VNLHbaEmHIrOZ4xzAvCVjRFtihnpynul5mBQ+/pJ1BcMI4VNigowTrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+lVob0Qgkpw7ze2wh4tgXE0jAzJD0yzAZB8aLsyvNs=;
 b=ip/LPp2yy3+a1BxRtWWPs0RqTFc72/AxLIfUI5q6KUV/N6a9XcX0yK9di+CAI9ZqQDITmatIus2g8/cN19ZGaaZRB1djJe2nrrupZPFUnd2mrVJYVdDCk46n+0oDF8xsVP4gYRmgDkwYkzvqKzA8ADDwn86NX3AESN/MDt5aqF8=
Received: from SA1P222CA0108.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::29)
 by IA0PR12MB8837.namprd12.prod.outlook.com (2603:10b6:208:491::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 06:54:18 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::b0) by SA1P222CA0108.outlook.office365.com
 (2603:10b6:806:3c5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Mon,
 16 Jun 2025 06:54:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 06:54:18 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 01:54:15 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Deprecate xgmi_link_speed enum
Date: Mon, 16 Jun 2025 12:23:57 +0530
Message-ID: <20250616065400.868818-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|IA0PR12MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: 16673113-e4e2-4f93-7b0d-08ddaca29d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GgE2P+/vbtqcbJ8UqnQQT+837TkLLSm2QfnRb3g6OSHznktNoF8s9TZntu3f?=
 =?us-ascii?Q?5jyq5jHIIkJn8ZyL6uYfilNGWaamIUJ+/Kav0OxZoUfb/ifPlfqy9/X87+AG?=
 =?us-ascii?Q?z2nbqDZkL+DtLpS/kE9izGeNyoR2rUc66NkBKNTr3QWInj7kdzoyRsWp2Vqx?=
 =?us-ascii?Q?MCLriBk42hqmHF3Pi1gtXU1yb+nSPlqVkAWKtpdSamoTCvCFMTg6O1yIjSb8?=
 =?us-ascii?Q?yOtCQiH+0ynUp0sbF94hr2vkw7tnayAatrx8a/vxB6fuZNxnzDORBn2aNezt?=
 =?us-ascii?Q?Wow5GCQRhW///KOeuXVftlt3tJVs457JZ6Scd0r8k08dZwJkyNZRJWc6/hyp?=
 =?us-ascii?Q?MZKnvwWXLycCHzRxBRkKsuwBy0U3bO9R6uINCztk1O4Y4NEfqNI7CjWzrMJR?=
 =?us-ascii?Q?QfpFGxzQtwwstloK06UrtuTSddHayFnECvEk2l834yTeoXKhNYTWUWo40qDF?=
 =?us-ascii?Q?URx5hGDPl2QWZ2FIqsaoEDQTRcrpSmIBq3P5nmQoTUUOHn6iM036CPIgMW7r?=
 =?us-ascii?Q?2DbkAfRmu9/133NQOe39Tx0VwydWaFurG14hbFQ8D938HAPE4zCafAB1SMFj?=
 =?us-ascii?Q?NC56WfBOMZrWEm3tNrZbQdqBjHvf+YzI2hOcyciTZTsRVXC5D1P1XxGuWLPB?=
 =?us-ascii?Q?Ipk7O7QewvPjeDsAPgBQhAtsoKPQkTM5bb1PeM40h9wGovqpg76fRw3dE8az?=
 =?us-ascii?Q?nxOSP64rFUbtymmUY6MGOGVVjNYV/uTUcTq0KpqBtepwb/T8wz2k+Gn58c/g?=
 =?us-ascii?Q?o60fVl53PdaabMfQuMJTxSKSD6oegsCxsWYrVNMFnuCs+3c+EiNqMUTkS86h?=
 =?us-ascii?Q?qQ1iOMl5iipwlCMAj9RTdPUd1psGjcz5r7QTt3id/RdC8g2Q3wOjkeSNZNC5?=
 =?us-ascii?Q?Bxx8axGN4eW46mjHN/jMa2/RR69IXcNtvjjTN8uby/wWQzy7itzPJlmhJ79P?=
 =?us-ascii?Q?9tvNSlfp7MLQa25E72eMNMTsyoqtrAbktf6cTZXfH9fi6XU7ceqoinqUzIPl?=
 =?us-ascii?Q?bHC3QZ/nf+5TwU08dR9YOafzrmoOs2MAV/lFd4J6sAGTLwaI96ejLtJqAbJA?=
 =?us-ascii?Q?FIcMNF8dPSiP+pVn5ge4+hPQAOTvLbzsmefk2rdymi/oVw/SRfszggOrixAm?=
 =?us-ascii?Q?Ae7ONfa0+ceSVlm/hQ/4LEmQ03Yf91vawxnjKt7XhXo/fe8FtH++/5lUCUtc?=
 =?us-ascii?Q?J+e9/e0r+XdsCEzc8fAnQFileQPtWUjbbVZgjVqXQUUunF9j3tIx7lMnjw7S?=
 =?us-ascii?Q?/uLUx8sSpznAFJVKKlCJ9A8Pcjqemx7yTI1aRvWdVxquRDGjtdMNLjix/CUa?=
 =?us-ascii?Q?CZKluFzFC1BfSw9OqIwKz5nkWYn2XYjVMY6PJN9SAAd7eeL0I7xbPrMT26gD?=
 =?us-ascii?Q?6T+Xb9RhbZiVHVX+4Cn/jSP9qQCqFzcgQbseaoYtBNZdsGIL7nPkaBwJ9C+w?=
 =?us-ascii?Q?TccjtyaMfx0iFhn0G2ThH7J6tO7xj9KJ8dCy9GFS69/fn6NzRcP7bE0I7vAO?=
 =?us-ascii?Q?Yase4ykzwRkbJsV+WIdEnrIsUwmq6Vt22Qm+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 06:54:18.2683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16673113-e4e2-4f93-7b0d-08ddaca29d7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8837
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

xgmi doesn't have discrete max speeds defined. Speed numbers can be
arbitrary based on SOC. Deprecate the enum.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h | 8 +-------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index d9ad37711c3e..6f9997198518 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1771,13 +1771,15 @@ void amdgpu_xgmi_early_init(struct amdgpu_device *adev)
 	case IP_VERSION(9, 4, 0):
 	case IP_VERSION(9, 4, 1):
 	case IP_VERSION(9, 4, 2):
-		adev->gmc.xgmi.max_speed = XGMI_SPEED_25GT;
+		/* 25 GT/s */
+		adev->gmc.xgmi.max_speed = 25;
 		adev->gmc.xgmi.max_width = 16;
 		break;
 	case IP_VERSION(9, 4, 3):
 	case IP_VERSION(9, 4, 4):
 	case IP_VERSION(9, 5, 0):
-		adev->gmc.xgmi.max_speed = XGMI_SPEED_32GT;
+		/* 32 GT/s */
+		adev->gmc.xgmi.max_speed = 32;
 		adev->gmc.xgmi.max_width = 16;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index f994be985f42..433d94f52ac3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -25,12 +25,6 @@
 #include <drm/task_barrier.h>
 #include "amdgpu_ras.h"
 
-enum amdgpu_xgmi_link_speed {
-	XGMI_SPEED_16GT = 16,
-	XGMI_SPEED_25GT = 25,
-	XGMI_SPEED_32GT = 32
-};
-
 struct amdgpu_hive_info {
 	struct kobject kobj;
 	uint64_t hive_id;
@@ -97,7 +91,7 @@ struct amdgpu_xgmi {
 	struct ras_common_if *ras_if;
 	bool connected_to_cpu;
 	struct amdgpu_xgmi_ras *ras;
-	enum amdgpu_xgmi_link_speed max_speed;
+	uint16_t max_speed;
 	uint8_t max_width;
 };
 
-- 
2.25.1

