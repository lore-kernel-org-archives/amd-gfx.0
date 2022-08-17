Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934BDC25B0E
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Aug 2022 03:09:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06FA710E301;
	Wed, 17 Aug 2022 03:09:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE5EC10E327
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Aug 2022 03:09:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERjTgg7V4P3v/hOlQm1HupH/9hCzOossOAEHq08duC4iwvVMZWDfF6tGPEB4Odm0/LnMiRE2kbiFOsIfDxCgR/w/M4hJ8Y3R8U1SHnJGqBltQe7i5tCn8pwt0YDvUWAwQiBSxXDWfCfPGELhLWOmQjWcAeLFHUpEOwNzmydZq20xxLve9qEvFsxIDilhvObvF14uoSgB+6waWgHgf7qmkvpz81uTysVnaIJEwRVpdrkFcaJgJ1OB6qK07DWyN/zvXv1z5ujfD3FeL3zQfDv5U6PdayPsZmQmHkIngKIfWm9sraZMMAcgn/T48XQx9otnrqJg3HWijcRvk2vozcagXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8I3qzQ/TtDmueqQAqOuZVO1U3WNhKsOJbCxCib5jqzM=;
 b=FtSc0sT3b89BVEruy3sRkyoADgr0fgRtN+kY5t3Jbn1KzgDGdBN8PI07UMBqCI8PSNiUPOqxwAdVfAOfhqVpSTJBxnNvyqAQmWA0DyFbgYCBk063+ptH8hELJDM349skEkmBwReTPqseBkzfMwxobe+RkYP0nzrbYB9TBmF2qj+vfCVlqEVUn8/uJjT1Pf+PL/W8naXYzyQO72vK9+vEGyg/MUKdCfHILXajy8J8zZN5XORxvgtb7aHCJIHObz0HyjzqSPRAx+wLfujMjIT8dc85uNsusVfVuSuEQcpJez2Aj0l9z67W/Q61QrgFqQ/QRneUUqBlBSflcrI1aMNeQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8I3qzQ/TtDmueqQAqOuZVO1U3WNhKsOJbCxCib5jqzM=;
 b=UJt+/krUVMETk6gOdQ/bQbHB+0WcSozBqTWUy5ioN2BedJUkCovKsKAbK3GrRlgsNxx9pLkwGcegb1YQHiusytPQLnZaz4YLuJMv4CS6QJ9DU98nP61S0xP7EMNFHuFG+PIt9cchw5DF8LZRrZgMfewMCPLRfvolljkB+hG5P+k=
Received: from DM6PR06CA0072.namprd06.prod.outlook.com (2603:10b6:5:54::49) by
 DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.10; Wed, 17 Aug 2022 03:09:44 +0000
Received: from DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::31) by DM6PR06CA0072.outlook.office365.com
 (2603:10b6:5:54::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.16 via Frontend
 Transport; Wed, 17 Aug 2022 03:09:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT072.mail.protection.outlook.com (10.13.173.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Wed, 17 Aug 2022 03:09:44 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 16 Aug
 2022 22:09:42 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: add family_id property for kfd_node
Date: Wed, 17 Aug 2022 11:09:26 +0800
Message-ID: <20220817030926.80377-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75c02c5d-bb44-4e22-71c2-08da7ffdef48
X-MS-TrafficTypeDiagnostic: DS7PR12MB6142:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lv2otnjTCtH/w3pOelunHQOAu7pDhxMTgTC3W4BOcPpxvGlWrJZeIypK0e40Aw65ne+k1t2/Uy5XjT1Y7pvtB4Tf45Mk3NeHVoeFpDWXNZfAPxWPu0Qtqy6JgSJqOyDCSXzNa4gR3s25GhFVZypfDUx1KrDG7hFxnfhiooL7w6r9BvRG5YQstgNjQPwukxrcBrCOyOpj7cOhYSOrJ/8hePWXjSqPmi+dvDa7LLjAS6bKEd1TLIHeZTknLuRgm2UOG6+5+ozGaPAnIjfURZ+dqUE4v6MMgn9mArqdUMGT9LZmR8Oya2tEqNnh6wjup25cJKVd0Wb6k0GI5Hh8y4MsgldwVDLARsZY0grMl1I+XprdEnOVZdWN1m7Q5LJFQtIipT+SK8om8ZBK+/kKHKv7FWKvlOz8wSpl8mmxtwM1NvagPWcmMQeKAJNvgyWA4NKW/Lz4Xb1/atY8HNqjnAfLnVZX/dpKcvvkmTfsLF05knPsGUCgfsqPz3kNSN1jW33MWMsFgyZsAUqQYy8BUWgffB25FykKbyIpGeROBMhd4oPaoyNNplcyF7ErvWkjJrdp/Kwy9M+HStz9JPlzn0c5qtWUiIROIV6JWHfQOStzgXAf59Jb0zwG4vz0l6jeVyN46FYd2Ms9lgIyPnOLlSKndlflVlaefAS9bOhbAmQa2uA+5KNj921QOY5A/H1zsUAntbu6bMjRDtKudYUAMKsw0pgY/Qnru6O7TJ6myZ3Tzv1kn17ZdbUjBhZFkYkPdB6ZAbDNlOqQCQL7dJnpjzkVDRCc5DUJEUc954xq5QeD9vuRFEcEfG61fxUqyWJnMTphrQ9BrmFId9P87/u4bDGYvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966006)(36840700001)(40470700004)(4326008)(2906002)(8676002)(36860700001)(8936002)(5660300002)(70586007)(70206006)(36756003)(356005)(426003)(336012)(316002)(86362001)(186003)(82310400005)(478600001)(41300700001)(47076005)(1076003)(16526019)(2616005)(6916009)(40480700001)(7696005)(40460700003)(82740400003)(54906003)(6666004)(81166007)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 03:09:44.3364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c02c5d-bb44-4e22-71c2-08da7ffdef48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Then we can remove the burden of maintaining codes to
parse family_id from gfx version in rocr,
i.e., remove DevIDToAddrLibFamily().

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 3f0a4a415907..7e0331e853d5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -507,6 +507,8 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 			      dev->node_props.vendor_id);
 	sysfs_show_32bit_prop(buffer, offs, "device_id",
 			      dev->node_props.device_id);
+	sysfs_show_32bit_prop(buffer, offs, "family_id",
+			      dev->node_props.family_id);
 	sysfs_show_32bit_prop(buffer, offs, "location_id",
 			      dev->node_props.location_id);
 	sysfs_show_32bit_prop(buffer, offs, "domain",
@@ -1690,6 +1692,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	dev->node_props.gfx_target_version = gpu->device_info.gfx_target_version;
 	dev->node_props.vendor_id = gpu->pdev->vendor;
 	dev->node_props.device_id = gpu->pdev->device;
+	dev->node_props.family_id = gpu->adev->family;
 	dev->node_props.capability |=
 		((dev->gpu->adev->rev_id << HSA_CAP_ASIC_REVISION_SHIFT) &
 			HSA_CAP_ASIC_REVISION_MASK);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index 9f6c949186c1..4ff8dd2c9549 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -56,6 +56,7 @@ struct kfd_node_properties {
 	uint32_t gfx_target_version;
 	uint32_t vendor_id;
 	uint32_t device_id;
+	uint32_t family_id;
 	uint32_t location_id;
 	uint32_t domain;
 	uint32_t max_engine_clk_fcompute;
-- 
2.25.1

