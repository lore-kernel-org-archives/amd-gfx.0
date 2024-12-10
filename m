Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73E6E7718B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71F4D10E9F2;
	Tue, 10 Dec 2024 22:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oKXCsIHk";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3111610E9F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfcFuT73T/1nq2+G6t+esVas9eWOPMCa092Y/HugNunKzbL6omdW8Pywr3aAikPHEkEJ3PF/wIOCR6zUXLFxifubKS4nlj8dCJ6EcA/0c+wGlOc+POxq9EXa+PqxVmrjZKFURMQFT3D58Z/4xpUVL7ftm5BiIUP+Y1h8Vbnl1xcoPifuTAJqvUWw7TBfrlssroMrWsD4e9YAGZ4ZSXCJCsU8RYo4RN93gj8dNN7C6Bh169PpRX1d40XWBEoPoM4b5QV7ABHz3KUWERGrz0ohPSa0wDXIjUjI4f7/Z8xQ4QNncBqc+M2kpbxyNPdCjKEgVxjCvLU/PMTSBwtsEaK2cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+EsEgGR7EFG0yOBxJyJQ5og9b0hgnxjY96yVKpz+fE=;
 b=lunAYCxVQWgDdTiihHlUdKSRzbcyqX2DMec2/F7EC9x3iOeM1wdcLTD0T+MP7r97u6QsYicOFAM2BYdoaOq4HSQ+SJixU2VoaBxrbPrFGDeh3nNrgnqbjgK0lfz4aPZwBYFvF+r3gQsvxUF0izCE1bVyFErXRSE480uYYnR7nv1Pl5K69wfjnFUdoj9Tkmpye4Wp+zDVC45FN8of5qCq4uJGG7CyHUlyXlNNwwoZwTo/WfbAiwpb1NkJNjm39XF19MOn2xHSWfdD0wOjA6Qc3yRNMPV1yYBI0DIx7ue31Vsd49bTQs2xOskoxD2qYe9axIlz9sIBmTtIO6R6sPfLTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+EsEgGR7EFG0yOBxJyJQ5og9b0hgnxjY96yVKpz+fE=;
 b=oKXCsIHkCFXdezDPfJY6szgRyfWsWLGqBPmv3/I+g9/Wp4FZNyC/IaBvPk29paWscPsvp3Bip6Esg4bbNk7WpkttoFIwR2tPziU48/ZIZrRMxG3YUhHAL4VmTfHbfXM/R5whccinC0AXokeF+9HnsIR8+ZB9pjGa0Yr04TFFhi4=
Received: from MN2PR01CA0011.prod.exchangelabs.com (2603:10b6:208:10c::24) by
 IA0PR12MB9011.namprd12.prod.outlook.com (2603:10b6:208:488::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.14; Tue, 10 Dec 2024 22:54:18 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:10c:cafe::f2) by MN2PR01CA0011.outlook.office365.com
 (2603:10b6:208:10c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.21 via Frontend Transport; Tue,
 10 Dec 2024 22:54:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:14 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 43/48] drm/amdgpu: add a helper to get the number of instances
Date: Tue, 10 Dec 2024 17:53:32 -0500
Message-ID: <20241210225337.75394-44-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210225337.75394-1-alexander.deucher@amd.com>
References: <20241210225337.75394-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|IA0PR12MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c4a57cf-a956-4194-17df-08dd196d93ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HYNLE7YgJG1l7RHJEX3on1R+GWAEWuuSW0h2KznJ2AA2/KA2EhmFeo1etfAa?=
 =?us-ascii?Q?cTy0Qsi88AP7ggbi27GECaJtoaIMW7+HkFQzhd0oMI4RYQHNYVr7xYdxAE57?=
 =?us-ascii?Q?pupa0rOXBVze8KEzzkavoysGCStGtS7Z5nKAHJ06x3k6SCFBrSl+p58ii8hU?=
 =?us-ascii?Q?l67jjPIPMI833IqTha42vUrZjMnwZ3DLmglWLbtgLDyqQ0hHy9JauWcP3xMB?=
 =?us-ascii?Q?TrXZxMv/FSRUZPZmFQeEoV6O3CIccFZnqV93ABEIZ1vKPPZX2eNnRz7MdL3f?=
 =?us-ascii?Q?i5TNmCiZGlkIBwiVR/GGOufpr0H1Tf8aFaNlIkWxwjZI/oWDSwUY2tmbly8s?=
 =?us-ascii?Q?8S9XiHE9NbBC3Kem8ePg5scC/o6+h8xy0wqTt5RCzqsus6lFA2ZdGMuWQERj?=
 =?us-ascii?Q?25qOopK0MQBF2t5yCFN/DS0VLBns/UOZmpCFb3KEwC3e/5aSLH0eS/62I4Sw?=
 =?us-ascii?Q?iVpmoo4iaFgxfPxKEIiKOTxHKNtD2tRr1IAf0FlOukLTjb+05CaN8L74ltDQ?=
 =?us-ascii?Q?xNTmnLr8XVY7QtT5LparxEP3GcOr90bjEvKmRWm6CO7Rf+5Db3e53VVz+Pzd?=
 =?us-ascii?Q?FxX9vM+HhesQ4f3gRjcLskbDKu7Y8zByO01lfwy2qulK1mmUJkzzYlopuXJq?=
 =?us-ascii?Q?LsMCRZCXexYcIkQEqbCIohR2b+XGdFAawDctqgHtof9qOlM/5Atok/tk/xtl?=
 =?us-ascii?Q?i+OE3tJqfWinlElaqJE1/rozMoquRGJor5jut9S4J7ekhHQGwyu+gymvLpy1?=
 =?us-ascii?Q?4v0kRj9i82S8W6RmcLPAMeSwtpSeb89upeXyJVF+hFJ9nsXS0Z8G7biM2kcC?=
 =?us-ascii?Q?VF9jrG1FiU4SU6wmflHSsltyGPi1lJuutriTR3yKnSj7GsFG88ZSWnPgKhVC?=
 =?us-ascii?Q?+k4qvzPd5omOX3uj3IAJ3tXTlMrhtwbWUKxp+9+Smlkqu2O973rIm1/a1nvY?=
 =?us-ascii?Q?BXLOsdCq052oWAgr2/sjPEJFd+B0Bg89oTHvzKaTKo8SShEJq3iYRUR0TphB?=
 =?us-ascii?Q?run935MxJl8Gt8cYjTfJxQNWnT8C4HxpzoYUP7+fHMTidHFTh+4NdFBqlc47?=
 =?us-ascii?Q?b5x3+gN6Pe2ubKdkOxHuxPqrbCStiRL/ERUZEr8Mo5dZgudlkkwtFzcDhZbI?=
 =?us-ascii?Q?7RXEzopbx/YEbx1d4QbzQO694Uzvf5ClNKbELG3+eAPWTPZNI9SR/0uFjy7u?=
 =?us-ascii?Q?Ai1uejcj+kma4P44eO66G7h9S35C9g1wTER1JXe2lUFNVkAlcQQR3GMYdXkl?=
 =?us-ascii?Q?kUOWlKZfyt46VSC1Riwr3SDOFZVmpqsubttzxi4vlnd8kSl5YiOufH3A3QBd?=
 =?us-ascii?Q?/wLPIO44fYAbHdfWik+xhsluHY8QV/HB0Svf7C2JkCALNROAV//iAKiBO832?=
 =?us-ascii?Q?+6QMmo2I6u1A5OWzQ92sOavvMN5/6i1ebkJNHiTcY6V5YDrYsw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:18.0951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4a57cf-a956-4194-17df-08dd196d93ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9011
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

Add a helper to get the number of instances of an IP type.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 0ef598aac05c9..c3be17835f103 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -410,6 +410,9 @@ amdgpu_device_ip_get_ip_block(struct amdgpu_device *adev,
 int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
 			       const struct amdgpu_ip_block_version *ip_block_version);
 
+int amdgpu_device_ip_get_num_inst(struct amdgpu_device *adev,
+				  enum amd_ip_block_type block_type);
+
 /*
  * BIOS.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b5208a16d7d41..fcd8a1e8ae351 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2371,6 +2371,43 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
 	return 0;
 }
 
+/**
+ * amdgpu_device_ip_get_num_inst - get number of instances
+ *
+ * @adev: amdgpu_device pointer
+ * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
+ *
+ * Returns the number of instances of the IP block type.
+ */
+int amdgpu_device_ip_get_num_inst(struct amdgpu_device *adev,
+				  enum amd_ip_block_type block_type)
+{
+	int i;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!adev->ip_blocks[i].status.valid)
+			continue;
+		if (adev->ip_blocks[i].version->type == block_type) {
+			switch (block_type) {
+			case AMD_IP_BLOCK_TYPE_UVD:
+				return adev->uvd.num_uvd_inst;
+			case AMD_IP_BLOCK_TYPE_VCN:
+				return adev->vcn.num_vcn_inst;
+			case AMD_IP_BLOCK_TYPE_SDMA:
+				return adev->sdma.num_instances;
+			case AMD_IP_BLOCK_TYPE_JPEG:
+				return adev->jpeg.num_jpeg_inst;
+			case AMD_IP_BLOCK_TYPE_VPE:
+				return adev->vpe.num_instances;
+			default:
+				return 1;
+			}
+		}
+	}
+
+	return 0;
+}
+
 /**
  * amdgpu_device_enable_virtual_display - enable virtual display feature
  *
-- 
2.47.1

