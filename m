Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043C2CED24D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 09:17:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0C8F10E46C;
	Tue, 18 Nov 2025 09:17:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S+HE/7Cv";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010026.outbound.protection.outlook.com [52.101.46.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6FD010E466
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 09:17:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DulNLiI2OuGyQx34ZROqWz7Gev1efwZ17BNppjPAeiTOzvc9VcOCVB0ZOxDj+pOHs7s1rnkywXqxh+bmzkP+D3oWjaqipmVnJL095T2P3TgvBhwL4yOsOyQWQSjJbi0E88ZCaySfsKnJ2c1KFSuvvOoZTddtdTeXFwSSAvy8PRmlIn/VQLVqCpnDNvyvlP8PQ47WI3Ho+q7IXDPzJuqZyCQGBS1RUo2wNGTavKsz7IwqU2EfiaOVvFwUXA1dBLpPPeZVZFHZzOm74Wd4tQWqhBszXCHtwXV5mzxadzTL9HkyD8Vzb6SDfh0XwNbkUQZALf6GYE8jEaQrXBwt/6Lv+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rx/jJKhyacgoZRyup3B07cuNgACRMQzJjTRgqFC/G1w=;
 b=dedEFKO8NgSkcss+qWPwA2T/4eHFuqfFkGhMQb9EA1oHMHWsfhUFg82cCp3yOnc0r+/qMhGXpT6tMwacIICwtCfo0BKaXTGQKJrxHV5lKnQd++m9IJ0KHEbnugEcLSrMNaaYMS4UZwK8Vb3jD7HD73GFcEO6pImbkvqfwRWgU22e9/dJQKZgGKUVI74oX044aCyCi3nw0FxZmRDbtWCuk31F4/i3AiVPyifN7XZpbhbVNr4zd2dp6k87ViI5fRXE5BnT1KdUm56q0KgqtJTzGFhrdqcF2W3fHJ+0cWahAMcGYN6IUr/W+lnIVhwB978TJVji7CTnaKocGBitT0tZ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rx/jJKhyacgoZRyup3B07cuNgACRMQzJjTRgqFC/G1w=;
 b=S+HE/7CvOy5wSkxyB9GiM6OBaQB6iXJZ6RmujtZMLUKHQNXj+4iAjfNw7c18C2TJtYZslo0mkbvlJeqRmuWyOxj64GJKpsxIEPLTfvtfbhc5W/C5c3ilb6HGPY48JZKABfStXUITHLria5X+8DKracBFFTHPpFd9UR8rILBDzmI=
Received: from BLAPR05CA0006.namprd05.prod.outlook.com (2603:10b6:208:36e::9)
 by CY3PR12MB9703.namprd12.prod.outlook.com (2603:10b6:930:102::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 09:17:08 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::22) by BLAPR05CA0006.outlook.office365.com
 (2603:10b6:208:36e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 09:17:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 09:17:08 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 01:17:05 -0800
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 6/7] drm/amd/ras: Compatible with legacy sriov host
Date: Tue, 18 Nov 2025 17:15:58 +0800
Message-ID: <20251118091559.959683-6-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118091559.959683-1-YiPeng.Chai@amd.com>
References: <20251118091559.959683-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|CY3PR12MB9703:EE_
X-MS-Office365-Filtering-Correlation-Id: bf7e90f9-cae2-43cb-e72c-08de26833f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JX1xPyy2E2ik94vW7PmLViNXfVkt6uYnKt/9gCAHSl4xh4CcnHSIjwWuJgCX?=
 =?us-ascii?Q?HGAY06H9r2Qz+rxfau4AW2eLFj4yW5zUVcnAQ6L1eq6bd1H05Ij5v4W4j/0g?=
 =?us-ascii?Q?yHbhmKg+2Y+71mJstmJ6vs5sPKfgnzQjoV2AfGvqdWEZp6IULbhmye6ADlDV?=
 =?us-ascii?Q?Hyc6r48CtbTFi9vIoO/fYla+kAUPGWaMfAMRFHuBGjRx6Fvacpqv/KvBicY5?=
 =?us-ascii?Q?qJgXmUTQxiZrflY8FGlQS/w7eU4FNvkCQiwKH8VCM20gBXWAQZtxqOJGvea4?=
 =?us-ascii?Q?ymDNC1QCzpw/E/g4Al59MKYaN3uPgz6UT9r5GSXHvaFmtjcfZE6/75mGwfEi?=
 =?us-ascii?Q?oP+A7LOLXPYmLQ/pEDizeof1uT2Hoi5FzAfKWZYzv5kCLtsR+4+NJM5bKGg8?=
 =?us-ascii?Q?pwicvJgaYxBAzQ4F8BK1rlrespEeUJ0wKBDXaMBmSNBxl1IpxxXYmAIe0aXu?=
 =?us-ascii?Q?9jVCBV0aZBlLDrXvYYF9N4mShJeKzjkdGIRQG6Y6Iu54kDNhzS5rzKkaUbzs?=
 =?us-ascii?Q?EYfh+cAO+cR+0cTd9r42D20vpX6I46X2ktvY74tXBljgoh1OJ9NdPEjYJ5AE?=
 =?us-ascii?Q?B6iN8iYyIU6pHBeggZVW6Y813nwTNmAQHvtbinKCo2mv+9V7UUKxtESDzrDK?=
 =?us-ascii?Q?NZZ/9DyvSUsCOizyMZJLSh/hqiSx9wiEEdAihM8VYWpD691CBoWKkfzIhP07?=
 =?us-ascii?Q?f6/LK2R6M+mWplYipvVZZ9dH6qCIZNBnRrooxheYYFQ1wrNAe/X1WmnE3WPb?=
 =?us-ascii?Q?Ka7jsMa0DVgLt9eDFQL4VYUe19CP/1wxwAQMBNFFtONPTGphgVVAQJZ3/PJl?=
 =?us-ascii?Q?4Ym3ezjYx+K8ExWfvAfJplxo/Vy7zWXVEQh64zhox4MrhD7bh8kUWbrNs/C6?=
 =?us-ascii?Q?V/X/Aqmbrjnf9mMxA6mfF80FMrGsGCw40BlE6eomg+xDh/vqI+2c+ge9V30v?=
 =?us-ascii?Q?V7WNXkvtTAkXVL3Hhto7iOPpBQIgeivrha8OyuMCdwXO4MMo9igIhk27BCGF?=
 =?us-ascii?Q?Y4iASvrnISdkgNyXDQMvGxXR/nwmthWLbjtnjG2h9CRLLd3kEmYmsx+0X5di?=
 =?us-ascii?Q?EJ2MRA3HNkCqLcgaWRMa4oGlceVPu2mUJdD4mRogrE4eem4JbWnZ5npNuqZA?=
 =?us-ascii?Q?ZwM3zi22UoJeXc5+OsfYv9LOMzs4QTztu/qXtTDx9l5b1ZdekezO7az0YS0V?=
 =?us-ascii?Q?ZHN0xk4EaU9h9VfE/92MGbyXNm/9HQE0FZxILak7Ejw4aAs0uuMr0LwoehD/?=
 =?us-ascii?Q?6KzhKz5ozoTE6ERs2Ard48Gxoa2rhB2WN4usgrrX4DbBzhRd3Iu9MtsxgR+L?=
 =?us-ascii?Q?BIUXIv0DnyiTYJGRzxbLN1jko4tcWukuMvBq2EssB80OI2q7X+LnF0eNx30K?=
 =?us-ascii?Q?n+7gmEeNhRV2VxvrTG9+4aaPC107ErYT/C6cC8WZHsaDUeCU76UuQYc4pmqQ?=
 =?us-ascii?Q?Rt3oIjODfmgD6+gVfJiVOtf/703s5QQ0AknWY+L2FZyVWtregNlAEGuM4//f?=
 =?us-ascii?Q?mLT2OrHrEox7YBY04oA0AUz39SryOkrgOov5rkNmtnvYOTZKs1NXMlT8grHF?=
 =?us-ascii?Q?dhhQqdPoWcPLuQPSLz8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 09:17:08.1657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7e90f9-cae2-43cb-e72c-08de26833f8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9703
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

If sriov host is legacy, the guest uniras will
be disabled.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  4 +++
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h   |  3 +-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |  3 ++
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 30 +++++++++++++++++++
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h |  3 ++
 5 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 2d48818773c0..759f3c642331 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -37,6 +37,7 @@
 #include "vi.h"
 #include "soc15.h"
 #include "nv.h"
+#include "amdgpu_virt_ras_cmd.h"
 
 #define POPULATE_UCODE_INFO(vf2pf_info, ucode, ver) \
 	do { \
@@ -1533,6 +1534,9 @@ bool amdgpu_virt_get_ras_capability(struct amdgpu_device *adev)
 	if (adev->virt.ras_en_caps.bits.poison_propogation_mode)
 		con->poison_supported = true; /* Poison is handled by host */
 
+	if (adev->virt.ras_en_caps.bits.uniras_supported)
+		amdgpu_virt_ras_set_remote_uniras(adev, true);
+
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 3cdb1e0eca37..cffb2f805de2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -201,7 +201,8 @@ union amd_sriov_ras_caps {
 		uint64_t block_mpio			: 1;
 		uint64_t block_mmsch			: 1;
 		uint64_t poison_propogation_mode	: 1;
-		uint64_t reserved			: 43;
+		uint64_t uniras_supported		: 1;
+		uint64_t reserved			: 42;
 	} bits;
 	uint64_t all;
 };
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index cb7fbc791c3c..923bddd0af3a 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -452,6 +452,9 @@ bool amdgpu_uniras_enabled(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
 
+	if (amdgpu_sriov_vf(adev))
+		return amdgpu_virt_ras_remote_uniras_enabled(adev);
+
 	if (!ras_mgr || !ras_mgr->ras_core)
 		return false;
 
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index 609ac1a2cd7a..b10450e3bfa0 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -380,6 +380,8 @@ int amdgpu_virt_ras_hw_init(struct amdgpu_device *adev)
 			(struct amdgpu_virt_ras_cmd *)ras_mgr->virt_ras_cmd;
 	struct vram_blocks_ecc *blks_ecc = &virt_ras->blocks_ecc;
 
+	amdgpu_virt_get_ras_capability(adev);
+
 	memset(blks_ecc, 0, sizeof(*blks_ecc));
 	blks_ecc->size = PAGE_SIZE;
 	if (amdgpu_bo_create_kernel(adev, blks_ecc->size,
@@ -428,3 +430,31 @@ int amdgpu_virt_ras_post_reset(struct amdgpu_device *adev)
 {
 	return 0;
 }
+
+void amdgpu_virt_ras_set_remote_uniras(struct amdgpu_device *adev, bool en)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	struct amdgpu_virt_ras_cmd *virt_ras;
+
+	if (!ras_mgr || !ras_mgr->virt_ras_cmd)
+		return;
+
+	virt_ras = (struct amdgpu_virt_ras_cmd *)ras_mgr->virt_ras_cmd;
+	virt_ras->remote_uniras_supported = en;
+}
+
+bool amdgpu_virt_ras_remote_uniras_enabled(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	struct amdgpu_virt_ras_cmd *virt_ras;
+
+	if (amdgpu_in_reset(adev))
+		return false;
+
+	if (!ras_mgr || !ras_mgr->virt_ras_cmd)
+		return false;
+
+	virt_ras = (struct amdgpu_virt_ras_cmd *)ras_mgr->virt_ras_cmd;
+
+	return virt_ras->remote_uniras_supported;
+}
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h
index 03c3cf8363ca..53b0f3f60103 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h
@@ -39,6 +39,7 @@ struct vram_blocks_ecc {
 };
 
 struct amdgpu_virt_ras_cmd {
+	bool remote_uniras_supported;
 	struct remote_batch_trace_mgr batch_mgr;
 	struct vram_blocks_ecc blocks_ecc;
 };
@@ -51,4 +52,6 @@ int amdgpu_virt_ras_handle_cmd(struct ras_core_context *ras_core,
 		struct ras_cmd_ctx *cmd);
 int amdgpu_virt_ras_pre_reset(struct amdgpu_device *adev);
 int amdgpu_virt_ras_post_reset(struct amdgpu_device *adev);
+void amdgpu_virt_ras_set_remote_uniras(struct amdgpu_device *adev, bool en);
+bool amdgpu_virt_ras_remote_uniras_enabled(struct amdgpu_device *adev);
 #endif
-- 
2.34.1

