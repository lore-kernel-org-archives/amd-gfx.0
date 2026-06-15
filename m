Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF81CCD98CF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 14:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 095BA10E484;
	Mon, 15 Jun 2026 14:26:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EM8VLX8t";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012025.outbound.protection.outlook.com
 [40.93.195.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B17010E385
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 14:26:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eObaGG3gsEIPYUkEO/cud3pM1OmsdbNtXYDKgtw/2yHc9oG2tsxQi2lkCUIB1E5KRMKTyRuPc4TRkkfjtcs0o3JZqxhM8w7Sw2T7JLW0APhMH+LbChV062GSJdFFiflZe3LvFgbIEV5IDvPUL98vMVPUuhga3+KPXM83I5wAsdx+D9gIdzkSjS9FmrkRpCmK/8YTexeTrVSxU2EQ2DkbNAJ/MW0Wz0WhT7Iv2s9xoNx9iUsjcLx4j425V9qK5DTFH3p8QI5vhwMss9Pllv4tr4FkP2QbP5SmP2bMAXuiTZMbD1LZvgqxz2LGuO9U5+hBiJ6s+GdzbnEjXkemMAJOpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLWjZKX1EhT2YguiVMauWAEwkqlV6JjEtk6JsSJBrIY=;
 b=Ub9NHRORxqZo+S6E4nNJyQoCDJ8wFH3j3qdVhT6zwhGePK8awEAYq/zdMCCLdM62lKyMamM4rR+FTjaSYFP9qGfUKDNDPzEaH+8rE09ZA+OaJDTnBVfHjryQTs+uxKsJ9ifQKqFjMv2kZA493hcDAb5xcQE73Z5RBTwV702jsSOjARLLZflWWtRTcVVkqTteK6szBBYfvKROr/aFPtAZNorUv/EBoAIC7QB7K+TPjwenPQMJN22LZbsAoilH0nIkPX0PPfXZzbtm8+iVWsTHIS0Zo2fAp0tu37jKLa+hwH0Cs124vPB0/UacgDnhECVStmjdtWySsZbshFIC7aqa2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLWjZKX1EhT2YguiVMauWAEwkqlV6JjEtk6JsSJBrIY=;
 b=EM8VLX8t34+uqO48NN/ePC8VoIU/RqnIhJgJ3MMCBEVZFRW4eOUvSfeeedGlslRwR6LkDcNqy3k8yUXkGM+bpxvepKEaQTVVsud6TzynCsr4yD2tdYujcDBJCPMO+sDKVPLRXdwP4Kw9lOjkYGfyZBTgnuDkq9RvncGwp8FSBPo=
Received: from PH8PR20CA0004.namprd20.prod.outlook.com (2603:10b6:510:23c::12)
 by DS0PR12MB9447.namprd12.prod.outlook.com (2603:10b6:8:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 14:26:05 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::13) by PH8PR20CA0004.outlook.office365.com
 (2603:10b6:510:23c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 14:26:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 14:26:04 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 09:26:03 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 09:25:57 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Amber Lin <Amber.Lin@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdkfd: Disable queue reset on gfx11 SR-IOV VF
Date: Mon, 15 Jun 2026 22:25:34 +0800
Message-ID: <20260615142556.3662454-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|DS0PR12MB9447:EE_
X-MS-Office365-Filtering-Correlation-Id: ede43d66-8721-4440-f423-08decaea08b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: nsm7MLdsjw4HrZOEmn1MZQzzQqBpfkmfU5mHY6HTuURgEK7eK+8RL6ZotpV3CSd8goy6PhWqw07BWUNUJvOhSthU/FYwaFkAqlHLOsklm93CffGxsCW/7L8eJ9hiPreQMdM0tuIQx6I18fGy5DCkOlD3iJQHcCkLlvuNb8B85atrclwlLv1OmRA5XmkoK0bWBcQ6i0PrNfSNFbh572IQoT6a3qHWSCQ1i4sMTAzD0d5Z9O6rYhDIKBwvhBLrrE6waqGHR9nR+4Djg9Y7XhKMzos09mGskWD9TcIbVG5E6/OdGI+gysWlJoCsjfYmQ4KR10vcbiQGrP7Q5CEoxAa7VR0u36yKolSQ/1GVmbZ085k1YlmT6GXfG4sFGsTwWTas0FrW5/5tieytVcUtOVtzOzYdjEuw3Hd8bXgUNQLiMtOFyb0LGfxGP0KhS7xe0DfgwT1cxa+HC4hTTWnzkMBKu9KTqeWO+1MYyJa8/hTd57ehJM5NN7C4lfYMFO94ebbBuPWrFx3JGb3Wd7nBfVeSFBmFwX792nOFqXrKzCzVinXKzbT8MqJiO167QqNvcQhrRkkSt3NC8XsjLkf9veImKTeY0IY6H0hQXNAKeZQQ09TkIY6GQiAhvbnzmgxIB2IceBmL/F3OnHHCdJmnVPVTSI2kaxQVHtzzk8Iaks2X2XKwpl65pfihcicVwllgW/PXxmWq9yrEbPu78CWxXG7bzeoCBerEoDphtRqkuoLEfUI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ifi6PGRLSVhz/+qIrcpdKhR7K43pYaWcvVB6JFNbPWdFJAyo+WWTppoljb/QYQ9sv5J/1FxhhEBijqobvIhrizyw4cyl6Mv7Ga2QTuUjL/q1p5sDmgVIUbXCwFYD330+1iqsXZ4pZx7Ha9QwR7xI4npIDkD5qnaf9Mr8jrH+O6ycuNNWIvqMuWBAcqsPbXfKGhItPNYK1XZkkyQCy4fzmfnPf8bufv7BW4qfMj4zA9scSV4FoF4HvUmQ79idxaJFz7xUMofheh+zfDAAlS/xCg8N2c1iMHpOMsqSmeUmKmBL0UCzKXwZGoAUXJzJNv9tTV5JEBOkLlDSz+JcJ1HWaUu6CIZ1zC/fhS1XSNMSKj1w+M7klkcSx+4uIJkqDSIAqZkoTLLrCTUmcjZmDzS9eZDczUL/T0IQjWZSowQzKhN+PtQfFaSCLmSpqzQbkYvo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:26:04.9393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ede43d66-8721-4440-f423-08decaea08b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9447
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

Queue reset is not supported when running as an SR-IOV virtual
function on gfx11 dGPUs. Guard HSA_CAP_PER_QUEUE_RESET_SUPPORTED
with !amdgpu_sriov_vf() so the capability is not reported to user
space under SR-IOV, matching the gfx9/gfx10 path.

Fixes: afc0c16db999 ("drm/amdkfd: Add queue reset support on gfx11 dGPU")

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index a9879cf8539e..6a90a3ece9ed 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2020,9 +2020,10 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 		dev->node_props.debug_prop |= HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10 |
 					HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
 		/* gfx11 dGPU */
-		if (KFD_GC_VERSION(dev->gpu) == IP_VERSION(11, 0, 0) ||
-		    KFD_GC_VERSION(dev->gpu) == IP_VERSION(11, 0, 2) ||
-		    KFD_GC_VERSION(dev->gpu) == IP_VERSION(11, 0, 3))
+		if ((KFD_GC_VERSION(dev->gpu) == IP_VERSION(11, 0, 0) ||
+		     KFD_GC_VERSION(dev->gpu) == IP_VERSION(11, 0, 2) ||
+		     KFD_GC_VERSION(dev->gpu) == IP_VERSION(11, 0, 3)) &&
+		    !amdgpu_sriov_vf(dev->gpu->adev))
 			dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
 
 		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(12, 0, 0))
-- 
2.49.0

