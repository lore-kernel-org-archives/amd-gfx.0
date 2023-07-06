Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08CEC001B0
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 18:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B47E10E49A;
	Thu,  6 Jul 2023 18:19:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C5A610E497
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 18:19:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2/EE5075FOGWc81xr1mPRvXCpz+CU3F6fQVfgS7laJplwh69FTxIY+QYxw4y0vxhwlAjvnV0hnRnCUckN4GZ1NlUU9yLdFyQx20HW60ujL6sqRVzlXba8UJJR0ml++livzAGmFKIXtAW7anCgmoXrFQDQp9S5djWWVrHSr9YxbzFQV70Uzv9SfNWKXYGV5tUi/dlzgF+15R2qUJJR5ZBORvjP6LdXxT5HrB05Qx1gucAYVeEDGzyEwwBxmmhxYFMusNdrKhZaDuvHDQaI8gUzu0yeYmYYb+nP+2UtiqbwhY9dtRSrxdyZn+4NfVC6DRa5y/Lok2dIoKch7b2cbvpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YOphsP3mla6+ylwKwDmAAlvGoUmg0t16YLlV2OynWw=;
 b=Z92Ufe7h2IltVN68fD/Lxd+aMbTgmPeFVsFPAZXO1O5c5eTphj1woLly5qBCfkwOpENBoSvtNVMzqMgRwZD9ZWnysQktDWgC3iMEO697D0UOEL3OOVnywwp2XtTi7AWL9vIOxO5ShZiqpEuCTl9aR+AS0nmRNoIubnUuYh8T6M1E/53bwQGwnXD+3N/Ci8ZBX+s5po+iHShFM7c14dPQ95BlGjMBGTx/bBIqxK98vHKrvGStXbwbyQ+eL7aUEI2l1aA2dDN4sHIui/OlqR4WblNEeOp5Au+kRyB9phs7Qv8L9aZOENhfAaPD3/Z/dBaSVMfYPmMG2sbCFC+zW2RwPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YOphsP3mla6+ylwKwDmAAlvGoUmg0t16YLlV2OynWw=;
 b=Tsij1xRqumk38p90WkOgZbpsICIjtQ6CNTC0zs6xnPMS7CapYQkknBUFdkWMkfWlK1+fuJpaZdfwbRENKLAUtnkPsJSZfgJXmbf+ZkY7JGCWJt0vU/XqO4aDgSdK6Gkjv1u2ruhWsCanfQnQLMfaVxq7VwzvOStQdF+iuyHXf/U=
Received: from MW4PR04CA0043.namprd04.prod.outlook.com (2603:10b6:303:6a::18)
 by DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 18:19:37 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::cb) by MW4PR04CA0043.outlook.office365.com
 (2603:10b6:303:6a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Thu, 6 Jul 2023 18:19:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 18:19:36 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 6 Jul 2023 13:19:34 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/6] drm/amdkfd: restore debugger additional info for gfx
 v9_4_3
Date: Thu, 6 Jul 2023 14:19:14 -0400
Message-ID: <20230706181918.189722-3-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706181918.189722-1-jinhuieric.huang@amd.com>
References: <20230706181918.189722-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT049:EE_|DM6PR12MB4877:EE_
X-MS-Office365-Filtering-Correlation-Id: bea27d1c-0e1e-492f-890f-08db7e4d8e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xR5C2+i96AilxyO138FGTaeUp9ITKg+Fjl0/t1YzoV/bxF4CyQxHhHbwoX8aQcqy0BetFRz8IkV54X3XQ5ixs2e+CHOMs0Gwk4/1kNqzJowQ3d9juRWg6khM8fvdrkAlca/+U99VcU+VCvd/iErt66RM55hiDFEhA4ozzbVZKgLs/roRMN0qXAsK22ltZs5qq0LcBYbQf0xM9V3eVG+95PK2oNAWIIfE3fkPTEKFwPc2e34SHMm0cG0KpOrOxQVSe36KILVf13bK2k0xmDFtXX8Zpfl3DmqPETRjnia7+TRhyUAoGxFOg2iTK7b03Ew51fYIKPeYO0Ygc2YXaNd5PL3ZNBWgQdD65L22CckgieOpdcsxRyH73bKB3EjW34wc3UxSJFpCVbYLFnBvMHwvdPhlCwz0K6zNlbbxfMozWwTJAkaXhGPFNjldsY66b3yMCm2m73qqAmRuryc9EAsoG17I4fBQamj1W8RnBQu6TxO++i+nCeKKGHiZryRUvhe5fQDg7ikSfoQ+S0YJLcDAMo3O5HFCF0O9Hw4zIQfJJo77CMwS1LgYdUTjQh5lY8fMadtwlja3NYqRj6Rlu3jtVGurbrDsayZz3tKO2fF/xoIL+nqn4OqKauhH4SvZnC28LRbFuE+F5N2pnQnhaSP4R9Jzi7bo4rg45+UzXxprcxWLnMIuqI6rgSN5pECJ+pfO9y6lqhIyeC01gfLYGAcXbsi4PXajRfZhCbwsBxzpbqENFB3ra0AcfzXNSh5n35KnPgBKuiQsbVb0MXyQDEs4Qg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(46966006)(36840700001)(40470700004)(7696005)(6666004)(478600001)(70206006)(54906003)(70586007)(83380400001)(47076005)(426003)(2616005)(86362001)(40480700001)(82740400003)(36756003)(2906002)(82310400005)(40460700003)(36860700001)(186003)(336012)(16526019)(26005)(1076003)(81166007)(356005)(8936002)(316002)(4326008)(41300700001)(6916009)(8676002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 18:19:36.7308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bea27d1c-0e1e-492f-890f-08db7e4d8e59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4877
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
Cc: Amber Lin <amber.lin@amd.com>, Eric Huang <jinhuieric.huang@amd.com>,
 Jonathan Kim <jonathan.kim@amd.com>, Harish
 Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jonathan Kim <jonathan.kim@amd.com>

The additional information that the KFD reports to the debugger was
destroyed when the following commit was merged:
"drm/amdkfd: convert switches to IP version checking"

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Acked-by: Amber Lin <amber.lin@amd.com>
Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 10 ++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  3 +++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 61fc62f3e003..1a4cdee86759 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1932,8 +1932,14 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 			HSA_CAP_TRAP_DEBUG_WAVE_LAUNCH_MODE_SUPPORTED;
 
 	if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(10, 0, 0)) {
-		dev->node_props.debug_prop |= HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9 |
-						HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
+		if (KFD_GC_VERSION(dev->gpu) == IP_VERSION(9, 4, 3))
+			dev->node_props.debug_prop |=
+				HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9_4_3 |
+				HSA_DBG_WATCH_ADDR_MASK_HI_BIT_GFX9_4_3;
+		else
+			dev->node_props.debug_prop |=
+				HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9 |
+				HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
 
 		if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(9, 4, 2))
 			dev->node_props.debug_prop |=
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index cba2cd5ed9d1..dea32a9e5506 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -32,9 +32,12 @@
 #define KFD_TOPOLOGY_PUBLIC_NAME_SIZE 32
 
 #define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9	6
+#define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9_4_3 7
 #define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10	7
 #define HSA_DBG_WATCH_ADDR_MASK_HI_BIT  \
 			(29 << HSA_DBG_WATCH_ADDR_MASK_HI_BIT_SHIFT)
+#define HSA_DBG_WATCH_ADDR_MASK_HI_BIT_GFX9_4_3 \
+			(30 << HSA_DBG_WATCH_ADDR_MASK_HI_BIT_SHIFT)
 
 struct kfd_node_properties {
 	uint64_t hive_id;
-- 
2.34.1

