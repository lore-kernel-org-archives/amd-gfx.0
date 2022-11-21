Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3CDC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 17:22:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D15910E30E;
	Mon, 21 Nov 2022 17:22:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE3CF10E30E
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 17:22:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFxTVqBACS9MSvcFCzUjIO8cSeWIJl7xe+1M5LJPvknxD5mx712TvnFrSKa+Q2nFnPYAMMs+5Xx2nc5CjLnNBUN8faG85sjx8bG0/JxjQX/S8jfUl8OjQJcZVoOwALBCIJpNaJTtfRB/dl0X06Tx5q+Udl3OS/VCUb4GW8H0TbDtEhmFq+ivNNp4Qz2Si4qfWzhREEM0Ych9qRxkQqxWT1UHAOSLER+A/s6fGLNiEcTAjz8JuA8yUniZKjcldfwoIGoOWXy2oF0SQQrF1wtT+kn2F88R3LW/LX7g8FQHC/tdJoQAixQoIID0O1k9czBiQmURflYHgrC15PddgWkuKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JuPq/DoHp8mAGbJG72Bevf+XlwkJGdaKLlvBIYr7uU=;
 b=iJkNXhdq+LDLN9vYSzycuBq5FYHug0F6YAvUCtQp/q/MNfM2pf6kKiDFJx9uqfRVLsvSPHg8/0Dm7HPq2g5IxYZ4r8p3bBrD0pMJsBnvvCtpVPtgFp7x5EwRt6OqbnBFF6B2J7FS7fhzo5ejKwusjbOE4QuABkHfuVmxm2WgjbS9dTFoMDtdCPE8+I+G4/PeQuqlOdpTJgK6iRAZr7vLxkdizDnIJk0o5qC1L1Fj9I61HNrQO+bQQEXt7RIxyKeyR1PsfWsoF2n7duOE8q2HSg04ar3UwS/dkhZ1ifgXAyyg9bM4ic+wazl0T2X8qEoZxxQybulkUjrpKDvIeO2csg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JuPq/DoHp8mAGbJG72Bevf+XlwkJGdaKLlvBIYr7uU=;
 b=IkB3C+9KEwWHfTPvrDjZSfbIzhBBE5R45GyYxXcf8zLCF9QdFHpHALvOJA8IoTPHiWQGay8zbljzXuWj/5P9peDOLqaM7FVtZyX/arxOR/3T+G3wN/1/oVwN5R1FdQrVCTEQxiVvO26nFaRjnCObkxeOllHx3qAhYyOpPj9OozQ=
Received: from MW4PR03CA0042.namprd03.prod.outlook.com (2603:10b6:303:8e::17)
 by SA0PR12MB4494.namprd12.prod.outlook.com (2603:10b6:806:94::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 17:21:58 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::da) by MW4PR03CA0042.outlook.office365.com
 (2603:10b6:303:8e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Mon, 21 Nov 2022 17:21:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Mon, 21 Nov 2022 17:21:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 11:21:54 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add missing license to some files
Date: Mon, 21 Nov 2022 12:20:58 -0500
Message-ID: <20221121172058.694436-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT036:EE_|SA0PR12MB4494:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b6d381-2f87-4adf-7170-08dacbe4e49d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zTLp/j0vQRP7V7zJ+/TjDf8tl9ef/Txi9kWGEXARL2w4UqlO4o3TUykhgktadVLj818+rLPZcp9UzsuW429bdnJQUT3IJjH5Mh/p+HKXDI18X3adGolEkDFgY0O0LgTwOAn9H+/OXyHji3gcZ97EtNUWn7bksL5E11nw+DY6YNWwh4xKcxYyHz5Rb1bHAESRDNHYjPNRZpXRdoYpT1hKY5cstMAw3MQyl7YUKFMyoe72T0zmWhaEo+dYfCx7A8BIpmyYWDVyGmlw2T4nPnG3jqvE+XzLTYXc9EBXz+TkclqKr+ZeKDg/0fzx++LtShknq5KhOMinzDnRbS0fKvoq28EMaSiv2QUtxeCZs0MXJ+dy72fk1QvUMSMGROGxjecFk/ge5MAuAc0VDOMlX6OtTbqJiapWUYKkOx8L570+Z2Pw5J7ZdAwYr2XL1OD+0KpUjLyV42VosxIrRR1KbMTMK6BVhwXz5Cs+T+fmYTrCfngdI66hTVH0yG+iKuOAJ0PjygG1rjK5ckAl+t5AjIWuuGMs8E5KgXVLf3Pg5urHjCdBU2Zud8VUmbJSOv46bkaS+8c9/w9Q3nPyrkDtuhr4DZu+ggcSQphNIFxWc4aBhNfXXGaleBHNR2sIzs27+kqj03pJvgKG1qwVJfUIaGT1Q2Aa4CBLUwmOyGz7i8pYQA4kIFm7JhBi1JXsgwWXl0yN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199015)(36840700001)(40470700004)(46966006)(36756003)(86362001)(36860700001)(7696005)(40480700001)(40460700003)(5660300002)(2906002)(26005)(47076005)(16526019)(2616005)(426003)(1076003)(186003)(82740400003)(81166007)(336012)(356005)(6916009)(70586007)(966005)(82310400005)(8936002)(41300700001)(70206006)(316002)(478600001)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 17:21:57.3133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b6d381-2f87-4adf-7170-08dacbe4e49d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4494
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The driver is MIT, so add the licenses.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2265
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_smu11_driver_if.h | 1 +
 .../gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_smu13_driver_if.h | 1 +
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h      | 1 +
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h     | 1 +
 drivers/gpu/drm/amd/include/yellow_carp_offset.h                 | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_smu11_driver_if.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_smu11_driver_if.h
index 8ea8ee57b39f..61bb1d86182e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_smu11_driver_if.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_smu11_driver_if.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 // This is a stripped-down version of the smu11_driver_if.h file for the relevant DAL interfaces.
 
 #define SMU11_DRIVER_IF_VERSION 0x40
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_smu13_driver_if.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_smu13_driver_if.h
index d30fbbdd1792..d3d5a8caccf8 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_smu13_driver_if.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_smu13_driver_if.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 // This is a stripped-down version of the smu13_driver_if.h file for the relevant DAL interfaces.
 
 #define SMU13_DRIVER_IF_VERSION  0x18
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
index 483769fb1736..537aee0536d3 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 #ifndef _dcn_3_0_0_OFFSET_HEADER
 #define _dcn_3_0_0_OFFSET_HEADER
 
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
index b79be3a25a80..f9d90b098519 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 #ifndef _dcn_3_0_0_SH_MASK_HEADER
 #define _dcn_3_0_0_SH_MASK_HEADER
 
diff --git a/drivers/gpu/drm/amd/include/yellow_carp_offset.h b/drivers/gpu/drm/amd/include/yellow_carp_offset.h
index 28a56b56bcaf..0fea6a746611 100644
--- a/drivers/gpu/drm/amd/include/yellow_carp_offset.h
+++ b/drivers/gpu/drm/amd/include/yellow_carp_offset.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 #ifndef YELLOW_CARP_OFFSET_H
 #define YELLOW_CARP_OFFSET_H
 
-- 
2.38.1

