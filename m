Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA75C021A0
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 552F810E403;
	Fri, 31 Jan 2025 16:58:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="izv5/WWk";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C87EA10E3DC
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tehgmdF7nVQYTqV/XdK0HOA5/7xrj7lc1bcD/j21Bn3AgjmmghbHTjXi/mnlU0X/UYyXs9j99GG+9hCOrD6ZHQBz/rb04OomK4dUKnNpZsnSXpMlmPeG0seKoIc8DWQv822iHoyJYApneJekqjCv/MrjkeyNQamRnMD+63qUApKyG3Q6/rNpurUJx4xl4gYqzSVZy7UUNd6EhjwDxK2xbcEqsZ2UoIz6bgdFBqqwQ/MogX/RPzY/pnFbbe5O3y57/zKLGE7mbu76tOYteVtDXqEgosdwMPGwbhrMOAPc7R+mvS6Kz70Tkc7zHi9ez1JR7xJNb5n+QDVKWcf/KYHiZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uyO7nESNJM80E08K3mBOpxxwa4yS5/1zAk9vgnzv/g=;
 b=Ap6ovRSy93pcuj5fFas/jLOiSFSzWGfEElUwyoI2Jv5DTyokdnnfWIvnULSyRra2rWO62s60gtm7Qi0A3hdYThOKoWPkYZbHJ6LZuY43+sPcvr24l1yK7NmO2qOg/Jad45QAVJ9WJYjr1HWMRXzAkEqj8zQE9jyN2HgKYRMTNjPNulprNcDBMgLDdSd3JNe5ZnfvNJNJ9o1CCA0YzirtLqXhLVjv774k7b3TOoH2WJ+9qzPwVZ2VvvZiqi+eQj/qIg09zu+1DacH9IiF0jJcsBL8rHmt/K3/qZjrHK/wVC5tdbGEavhAmMbap8OVH2jjUXvbQ0IjOO8EZL7hmppZIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uyO7nESNJM80E08K3mBOpxxwa4yS5/1zAk9vgnzv/g=;
 b=izv5/WWkqxwoEM0cL9+Bouw6sqMVafSxxJvkGHclwM4FrhTWFSN1H9VS/Y9cLSiE4zNKU38JPqKZpbLhpEX2KNFGIXkMSEMueyLowCtIg+RhiLgEUUZFjefs2DozCD8aDHQSMT2R3MUpfLvu8OCm/rHYnwscEMAgeeKauJYdgqM=
Received: from CH5P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::9)
 by SA1PR12MB6704.namprd12.prod.outlook.com (2603:10b6:806:254::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 31 Jan
 2025 16:58:23 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::e0) by CH5P220CA0015.outlook.office365.com
 (2603:10b6:610:1ef::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.22 via Frontend Transport; Fri,
 31 Jan 2025 16:58:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:19 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 33/44] drm/amdgpu/vcn: add a generic helper for
 set_power_gating_state
Date: Fri, 31 Jan 2025 11:57:29 -0500
Message-ID: <20250131165741.1798488-34-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131165741.1798488-1-alexander.deucher@amd.com>
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|SA1PR12MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e7dea2e-f018-43e8-3b1d-08dd42187928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nq/9D6bJGrIc3fctySLbgAa2KxMmMAtdUJSu55XOXun425dktbvxH8qGAWW7?=
 =?us-ascii?Q?ypAdGO28b19yYaJBqhBQrK9DyznjCmUy1JxZbH0DGVfiC/Sx4FivfzTzIx2a?=
 =?us-ascii?Q?P6AR1AecMf7qFho+Z5kJ49yXEiPDYJRGx0uB/J5AUuthqV1CvreGGzXPaTxM?=
 =?us-ascii?Q?YBDEiL/CYW72WqkOg+3gNK3JQYl7COYZyotvc5UWpLERF2XLU3nEmnhvspeP?=
 =?us-ascii?Q?AHBuq7ezpk7Mm3xvlETFl4H2EHeETOOoN92FqMDVpkSGy7m/d/Zj1d7agIIT?=
 =?us-ascii?Q?66bYbXXDAj7JMyRim+2VFrgGwBDhp4leWIFjTWJPn8lzKVEDdfofYbm2vw18?=
 =?us-ascii?Q?OrwtMAuyNojhM6ymkvJ7j9gvuFF9ALOofcHnebeWo2Oym7AJIWODwaplzJk2?=
 =?us-ascii?Q?ofhJ06QqLciCIkJ/dwRbaUhzxrioGEbAOndRJrGlRR4MYnNFgLj16+Mp1Q5p?=
 =?us-ascii?Q?iWImi7YYK+7XJBnu68MqjTNUtKmEEEi8XaoA/5DtozHKEFxoxxwfGrZBH6MI?=
 =?us-ascii?Q?j4j/ssonOiFODYvnnqtiNf3I+O4n+tuvcxJhdg1ETGLqOAjZZ3yfXH/MbhAe?=
 =?us-ascii?Q?9cWtjWl2r+RH+QzqxphEPCwjC+swUIUZ44ETVfleUlqMLyYYSQZss2KItIzQ?=
 =?us-ascii?Q?Y+zFIcR/PQF/Wnqrb65a2TaOZZN+A57LthwGOim059uGhHB3CIzxi62uRj0d?=
 =?us-ascii?Q?MYWTom0SaNEMqlseCMNfBat2fyTCHgSsMT8uOMOqLWNMW0HqlwiNpUSqQ2KL?=
 =?us-ascii?Q?ag+JEazWIflwV9dPtpvornBnW7nvVKeqb5AJB6t0YLFLae9CGbJRIBtVaVh5?=
 =?us-ascii?Q?omRzaBxFxPdkHanCwJusu/ASsxC9KLx4OJRw9S8oL4YObc6Z2Sri4oHqB3It?=
 =?us-ascii?Q?2NPh+08PNrrAaWIxqVOBvSXENOpG/Z3BhrsJSxbTnjTV5TH6CaHKn1BatBeT?=
 =?us-ascii?Q?DajZl9u2mcvannPn8QPFQdx353mnGXuF2UZc/UR57jFW5EeYWPB62ZMsaXZ7?=
 =?us-ascii?Q?EZbkPGEcU+yLFmW1WpTVjvZu1+VhUNURCzbjSi/dRr7tbuP4lc4fS6OXIUmL?=
 =?us-ascii?Q?7UYfqHNiCSWD7HivkU/4Xw3kNzO/olhcjkLXVSUasPEh9mX/rCB1bKCpxw6H?=
 =?us-ascii?Q?iX/iC38aTPLNz+aZN5h+9f46tYd9JbX6ZJVbjLhgaszpGxJjHZTWOmTUIENn?=
 =?us-ascii?Q?xovrcJChtmts9xokZpMCuE5ukQ9CN1fqA5bGyavIkk5hwCxv27QcGuhcLoMP?=
 =?us-ascii?Q?mRYGejiWF0kQAVaIZsBnJMztzl0d87rRjvz7hcD/7vbIbqioMfU4/YLj8qVL?=
 =?us-ascii?Q?FtJXFJMeo3XNMGmrxMKp8MY0vYqTqqeapHyuP9WyLe8qk+b/iQ4RqGhrGuGi?=
 =?us-ascii?Q?AkC0UfU3RGCSrk6L7SLkvt9Zo0A9op7Zx/D2cYV49QJpAkuBpjMPTc+NT1z/?=
 =?us-ascii?Q?zBkvuqfeDcO/drCvwh4+vX57c/xPmmjUPqi79o5wGkKTyC7K6AJM7g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:23.4869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7dea2e-f018-43e8-3b1d-08dd42187928
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6704
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

It's common for all VCN variants.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +++
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 81bfd8a9d8268..e4ef0fb970b29 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1397,3 +1397,26 @@ void amdgpu_debugfs_vcn_sched_mask_init(struct amdgpu_device *adev)
 			    &amdgpu_debugfs_vcn_sched_mask_fops);
 #endif
 }
+
+/**
+ * vcn_set_powergating_state - set VCN block powergating state
+ *
+ * @ip_block: amdgpu_ip_block pointer
+ * @state: power gating state
+ *
+ * Set VCN block powergating state
+ */
+int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
+			      enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 0, i;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
+		ret |= vinst->set_pg_state(vinst, state);
+	}
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 508fa022df78c..a023f46ec904a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -546,4 +546,7 @@ int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev);
 void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev);
 void amdgpu_debugfs_vcn_sched_mask_init(struct amdgpu_device *adev);
 
+int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
+			      enum amd_powergating_state state);
+
 #endif
-- 
2.48.1

