Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4710C43334
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 15:31:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A219112869;
	Mon,  6 Jun 2022 15:31:05 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FEF4112857
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 15:31:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/v4NBlP/ZI3JSgyJ7T+iMm5u4xJvWowokmXGvBMLIAAUGu6dNUZJWdnIUuOmaLG+oGfi0ZGimVCB4uT2IbWfG/gQbu3ItJZaTyseQa+rxchqXuQYBSRnVSw6TC3b3AwOGEMmGJAQZX9Y3YxoPXuPKibcz9feFkzg2bujOf40bR3wkPzHw8lwdS+kJuZQfJ7emhq9a7LSDkN+L3z/fefjgbhvU7KxKDil5Lh8tTQCWuoDumd5lQ4eQLHSIRiZujPcHgiLm16I0paRo+oFhGWZUpdeEayaEwD2Beypp/Jo87NccwmtrhcA0s9fjnvJmSuxxRxskAHz13uBienzwxbjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaWZmGRnKLnE6NBK59M5GMUY1YPmewohZW4iVWwwZYA=;
 b=XFdWXLaBDPngHHxtXBYRWIVe5/MhwlnJv12wOSMW8OA5BqAZK8hDwpLap94JGvmcs0CF+1NR3jb/Kz2SiITAZ7VhZOC4ZA9f+Hm+8QzFNg8l7VhDC7XXJQYTIP705ZCTuv8dncTYUJ/jGcZMR6wC9ZjEAXAenGm/hWl20jcXswm5JuZ9rFnBPNLc0g1IcV0U6/lPxtZDFXKNXbPiLKCus07Rgy6QNt7TQoPcFwCzovFCybXP8AK9/dpRCvR7dUWsmCQMD5+gjGTIWLVV0qI2TLlMDRuqFgzXDTV7cxtCEh00U2ANCppp7Zcc7t3kz2K2yw/fJnjL5CR1MOw1vxAssg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaWZmGRnKLnE6NBK59M5GMUY1YPmewohZW4iVWwwZYA=;
 b=CNSO400VCulC5anYjOFTcX5B2qmRiT953UY/CBQrIdWKXSjrDuap+LXh3E2Bl0POP3fWu9Mh3OlNT2XijtzxqicMn6VisyLhhI3YZw5KNE19aSx0/71l1v42LLmvQVxloLsLKvdwW5UzPW4osGdZSDxXrVz3fzVIo8/TLjaA6No=
Received: from DS7PR05CA0021.namprd05.prod.outlook.com (2603:10b6:5:3b9::26)
 by BY5PR12MB3972.namprd12.prod.outlook.com (2603:10b6:a03:1a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Mon, 6 Jun
 2022 15:31:02 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::72) by DS7PR05CA0021.outlook.office365.com
 (2603:10b6:5:3b9::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.8 via Frontend
 Transport; Mon, 6 Jun 2022 15:31:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 15:31:02 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 6 Jun
 2022 10:31:00 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: surface xgmi physical node id in the kfd topology
Date: Mon, 6 Jun 2022 11:30:50 -0400
Message-ID: <20220606153050.1442655-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e9f4fc6-55d8-44d3-b42f-08da47d1907f
X-MS-TrafficTypeDiagnostic: BY5PR12MB3972:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3972F0BCFF3A95643670A3E885A29@BY5PR12MB3972.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NllBey4Yuu0QtnXFOL00cuUxBxf7/ftqYHwm1bbvMt6yyG3c4lPp/mt18uL2gYMCrANjZEGcofxkNKT75cPoQ00lQaRWM/39MUTlgjfad3X+u3T/ndpschg5H+A41m7DIRCIDqZkR9rq5IWIwwEiLCktzY9f4ImzVPr8jLBNJdxHiIkkviGyhpy+tpjjiQxIX211HsSIoJlCfsdgy8jdBOmOKqbiPvZrpMjcByKAUfYsJ5Ynz5sW9awuKANbT9xDhMhfe4RNywkALTa2JVaDoJGPsZmpPgoeNCQSbO5fqhx3eZYXcj9PO/WbszyJi7iTYfcHclztL6R/+fDrjpvGv/jEbpqeKXSsi3mGJFCuUHqVQJhlrq/JpXlwSsku+5G7W3mnoAsmubZTZkaL1tnON3ISeNxWcqvjP32wjNJjiCYppu7c6puwL1s+PE5w7tr7i/yIbiAH7+pndrvTIK1WcKFQTJD67H/kHpuvDXbiSvqX+/0U57nhU0nRMq0bWvPFmxJL06apLv6tEgYI0dcl2NQRdf5sUTSg+7B97GP2CCbOrWiWbkGucCT8mW2QHC8BL2e+ZAI/m5siXj0GvVtrcgji1kbJIHQ9pa370c1nieInU3UduywbXkOuC39HIOqjamcU5t104qYmt00Y28od/Knd14iPZ9UqKZL4SN/VlczmtsJXWf105ZOQrGEK5dmN7joqRTXTYteje15M4xBZjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(40460700003)(356005)(86362001)(6666004)(54906003)(81166007)(6916009)(316002)(70586007)(2906002)(36756003)(8676002)(4326008)(70206006)(186003)(16526019)(44832011)(2616005)(336012)(47076005)(426003)(7696005)(26005)(82310400005)(508600001)(1076003)(83380400001)(5660300002)(8936002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 15:31:02.3434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9f4fc6-55d8-44d3-b42f-08da47d1907f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3972
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add the xgmi node's physical node id to the kfd topology node properties.

The physical node id is a 0-indexed, monotonically increasing id that is
statically assigned based on the node's frame buffer position within the
hive.

This is useful because the id is also used by the DF for xGMI peer to peer
routing purposes, giving more transparency to xGMI IO linkage.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 4 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 8d50d207cf66..615a4f586edb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -503,6 +503,8 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 			      dev->node_props.drm_render_minor);
 	sysfs_show_64bit_prop(buffer, offs, "hive_id",
 			      dev->node_props.hive_id);
+	sysfs_show_32bit_prop(buffer, offs, "hive_node_phy_id",
+			      dev->node_props.hive_node_phy_id);
 	sysfs_show_32bit_prop(buffer, offs, "num_sdma_engines",
 			      dev->node_props.num_sdma_engines);
 	sysfs_show_32bit_prop(buffer, offs, "num_sdma_xgmi_engines",
@@ -1398,6 +1400,8 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 		gpu->shared_resources.drm_render_minor;
 
 	dev->node_props.hive_id = gpu->hive_id;
+	dev->node_props.hive_node_phy_id = gpu->hive_id ?
+				gpu->adev->gmc.xgmi.physical_node_id : 0;
 	dev->node_props.num_sdma_engines = kfd_get_num_sdma_engines(gpu);
 	dev->node_props.num_sdma_xgmi_engines =
 					kfd_get_num_xgmi_sdma_engines(gpu);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index c838863f1fe8..a49267928b55 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -33,6 +33,7 @@
 
 struct kfd_node_properties {
 	uint64_t hive_id;
+	uint32_t hive_node_phy_id;
 	uint32_t cpu_cores_count;
 	uint32_t simd_count;
 	uint32_t mem_banks_count;
-- 
2.25.1

