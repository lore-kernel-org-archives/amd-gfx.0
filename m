Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB0AC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 18:50:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DD6211A72B;
	Fri, 26 Apr 2024 18:50:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lrGHnuBJ";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C890511A711
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 18:50:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nn1yVko5YDms/QWISGHmH6Vlv5byRvIKDsbvUYQ1BwN6wfTbq79qwu47wajqpcIqOYWKRoioGO6yIcb559CBX7ywEOfSGaBhgOsNm5sI3IDTVALa6iiqkdH1YqrKVRUifkpzPgZ5m08NNExHODaux0dPV2c8VyVyfJIclFjrN3hwMHkXc00ELOSgRLIUzzDDARbb/BXMpajCTnJzOqKASvp1O0lCt49rwoo4eY9S8zthtnrdeBK6fevk/PNCqpkPp0PBn/gMxoflofbYLoT+kSd/+82OGhAA5/Xd1W7Jd5wejvtoDsRZQfYSJo2iyeoVUfXIJbOk3QkMsXT3ZZXSNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPiwfW6iiEl94VTXn998ero9hdhIT2NkkbNFVnE1afY=;
 b=KP932f1rGjxmFM7jd1dbqm8kjDOZbcWI5+rk5Umb8vXvVtt52yaJ0sNrkNLtdIibCLASSAKNH9yrKkYwFV9MJxihYfNSZLd0+mO55qwrLghxlZ48O/QvKYkbQrCCJlK7vuLdnpr/daOY3ty3y6/ONaYTtgwYmK1OLtWXAfdfpTNrWBC9eO6UsWUzFwGtOfHAFFw+1tiBpL7ws+2C+NUhIYCyNn/XDV/DZKw1hp632lDZRNSWYJkDIw4FRLiz0cZ2sX8HUmvrxXUsz8/lsLUHx4eXMqw6o0JrZ0vUkG88Qu7k5yox93zCR+5NzajgDoowhgTL6jTeArvrBf/0QF8dCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPiwfW6iiEl94VTXn998ero9hdhIT2NkkbNFVnE1afY=;
 b=lrGHnuBJPQIIMREcvLUNtkvqgSRoSFhCkqJuJedPnPPK9+PgwzcTUzKMFx32gkspfMSh604QmADcRsi/BlfygviipYR1+YkSQp5mw3H+2+XYalsn7NcNxndk8mVKP3+otYe82fGCPU78QndR3VUHqHXEFnEYrOIjvx4wbY4/a7k=
Received: from MW4PR03CA0054.namprd03.prod.outlook.com (2603:10b6:303:8e::29)
 by DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Fri, 26 Apr
 2024 18:50:35 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::5d) by MW4PR03CA0054.outlook.office365.com
 (2603:10b6:303:8e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24 via Frontend
 Transport; Fri, 26 Apr 2024 18:50:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 18:50:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 13:50:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/7] drm/amdgpu: Add sdma fw v3 structure
Date: Fri, 26 Apr 2024 14:50:12 -0400
Message-ID: <20240426185017.660146-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426185017.660146-1-alexander.deucher@amd.com>
References: <20240426185017.660146-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|DM4PR12MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: cb8d8ad3-1940-4a33-e904-08dc6621c1db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400014|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qUNbLv+eNDZz+VD35YsQ61PC4qmp+gQaEwKX8EEwFoeZAEVWJzF8wVfuA96V?=
 =?us-ascii?Q?2ZP4pp4ZYa6cQy8khHbMmwoP8YOwn6YWOx0snQ+qEsU2DCdL3BpoUq6Q4f5o?=
 =?us-ascii?Q?E9WgLYob2urAEr6Gg2/C78mEZV2qESsxU84aajTeZB8eic+xzqNKTXXjgB/T?=
 =?us-ascii?Q?EvI3EHzhWM+kO8U1CqOG2HFsHlwX6E7AiJH1BlUtaSLa3jAGpkICZz1ZHXC/?=
 =?us-ascii?Q?95U1CHT+297DPMJExac/FD03flKB1DbWxdLs3NuHM9d/LKDkDdYQcs+j2wIn?=
 =?us-ascii?Q?EXERWrKC0LSnYnn/dYYPlVOYEtGQidVV6Gp+tE5COC+O0Cgw1IJwDRSbaLal?=
 =?us-ascii?Q?AD4RaMid/VVV1+oXHp//NqNzAcRVfuJ7SQSdkfP05Mh2GI2shjCEbIEQMSqF?=
 =?us-ascii?Q?dPd1N8El3L2gMKRrHmc+dCXEdbmI4SCByhDwmlsbEAfKKjpIp45+EPCqWPjC?=
 =?us-ascii?Q?afsWnyXsScjljuPpwU0rBFLHaFNE2JMlgnAhd04pY+EFVdPEVQcGPyVQQnO1?=
 =?us-ascii?Q?+QGFhsQwrxHldiLK2b+fsofIlAjbHWiIPoSo71N2kk5mcA8NV4bdLzCggzYG?=
 =?us-ascii?Q?VgOZsYY/tnGpoxsLLqb+/mMR5y+VeRK2Q6BJ1ZCgZGtYgrlLIm1ny2FH89zX?=
 =?us-ascii?Q?oxTcLE+j9+cvKP1p/6nTW8ZkB1fOexS9vC49f98Gy8FrmGXwQ5iQeOwssuBj?=
 =?us-ascii?Q?5wSlIyY9ppJfuWXH9RWaaYsTBJXxD1Zy+svT6TYjcw6oPzKvWD9vZv8gOCgk?=
 =?us-ascii?Q?Axj+BPdG3I5cj4ENEfs7GC7JPjI4xp4swnZd7MkmwHlcUwRywnGuizuE28Fx?=
 =?us-ascii?Q?aW56sIlxE+dPZ8MoLX1TXPR+18bnKU4IOk5AOOMy/ZLwX3pVSqw/WgkpSrgf?=
 =?us-ascii?Q?FXEb7q3DHLwo2xXeo6V/08lC2HAKipzheJyz6RsVLfWQZHCui7OoIFKXDIlZ?=
 =?us-ascii?Q?9cNhRFGKKDqs1Dw1NgGb3YmRVPXtE/ABCCbpAO6Ckv6XNvBGvNQT1tmtuumn?=
 =?us-ascii?Q?/yArgbp83janAY1OvBqTpry2ClxfQO6es0IaA2WKS8K/etpCZtAeq4NFIgDd?=
 =?us-ascii?Q?S+YNAgaN2bDTegKQDQz0yK98Dks4SjPR3Kmct697O4AWGZ/6cv8pMQn6ACym?=
 =?us-ascii?Q?1uE3oSzOJsfGFvpZyQ2P1knHa9SagZA6gp2mixd3kZegd2YAEkAtZQl2/uJD?=
 =?us-ascii?Q?EtScGrC8RolSLVDQNhaEn1BDdXHtwpksNdT0vT8ZV7gugkzaOqVCfW/c0/en?=
 =?us-ascii?Q?lK6/KzEFWDo+aS87LUKYrUfJrxXANBdNmUcFpJdvX5BsjyQbPotJM+5+dliL?=
 =?us-ascii?Q?Or9bdGcghDqIUC0W5pdJ61OMiDr+prplUQZ6Vy9Q/Mad3G8/nD/oCc3e3W9N?=
 =?us-ascii?Q?OloDQD0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 18:50:34.9948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8d8ad3-1940-4a33-e904-08dc6621c1db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664
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

From: Likun Gao <Likun.Gao@amd.com>

Add sdma firmware struct version 3 to support
sdma v7_0 firmware.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 0867fd9e15ba..42794b1bbe5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -323,6 +323,12 @@ void amdgpu_ucode_print_sdma_hdr(const struct common_firmware_header *hdr)
 		DRM_DEBUG("ctl_ucode_offset: %u\n", le32_to_cpu(sdma_hdr->ctl_ucode_offset));
 		DRM_DEBUG("ctl_jt_offset: %u\n", le32_to_cpu(sdma_hdr->ctl_jt_offset));
 		DRM_DEBUG("ctl_jt_size: %u\n", le32_to_cpu(sdma_hdr->ctl_jt_size));
+	} else if (version_major == 3) {
+		const struct sdma_firmware_header_v3_0 *sdma_hdr =
+			container_of(hdr, struct sdma_firmware_header_v3_0, header);
+
+		DRM_DEBUG("ucode_reversion: %u\n",
+			  le32_to_cpu(sdma_hdr->ucode_feature_version));
 	} else {
 		DRM_ERROR("Unknown SDMA ucode version: %u.%u\n",
 			  version_major, version_minor);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 105d4de0613a..9a061c7b86ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -346,6 +346,14 @@ struct umsch_mm_firmware_header_v1_0 {
 	uint32_t umsch_mm_data_start_addr_hi;
 };
 
+/* version_major=3, version_minor=0 */
+struct sdma_firmware_header_v3_0 {
+    struct common_firmware_header header;
+    uint32_t ucode_feature_version;
+    uint32_t ucode_offset_bytes;
+    uint32_t ucode_size_bytes;
+};
+
 /* gpu info payload */
 struct gpu_info_firmware_v1_0 {
 	uint32_t gc_num_se;
@@ -431,6 +439,7 @@ union amdgpu_firmware_header {
 	struct sdma_firmware_header_v1_0 sdma;
 	struct sdma_firmware_header_v1_1 sdma_v1_1;
 	struct sdma_firmware_header_v2_0 sdma_v2_0;
+	struct sdma_firmware_header_v3_0 sdma_v3_0;
 	struct gpu_info_firmware_header_v1_0 gpu_info;
 	struct dmcu_firmware_header_v1_0 dmcu;
 	struct dmcub_firmware_header_v1_0 dmcub;
-- 
2.44.0

