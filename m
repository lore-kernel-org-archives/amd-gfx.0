Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3693CC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92AD110F908;
	Mon, 29 Apr 2024 14:57:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HkpeZW84";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5082210F908
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:57:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObpzbrLs632n/yzRBrUYPRdkVpWAqFsTqQVpJZtsKLouBeculhyscBw1gkG8XoQE9y8o0/atjpqAf265Qtb6we3hqaEVJQTnWlmZe6HE3o4aMWSdc0F9xl7AxtX++Kr/8amSksZLu3+Mh/7hC2eyL/kimw252AEuB3GQ8BC/R7ZHbk78UQEDkXnIkDFyoIoIkDyXkUL/ndSu2PBuG+O6XBjh/nonMzSVfnVgZEkE4F4B8zABKxKfcm5K7ulgP4euCFfLcXlv2QQO9slBw5Tzxwdyj8VY2MZgx5k/GRkMBEKp79hH8UjKo9FJtXxoUmD+3cYykCswWuXaGIXv1inIQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4i0zjaU3j8YaSa2tzXXIV7x2T+9CsiwR3MqhIZacOP4=;
 b=oFYW3XwL5kGFcYS8VmA+S/qhkDAhZ66cG2yUUUCj7t4AOjSiEC3FoZsNj/XSg7ohnMZO+bMK4WD5y3Yhej8znMWuVB5bWLfV4/ylXw0XtE2UsabdW0wg0Fjd6Zsfsq3qQyx+gl5cnq+dFfMrypIhJQmyCdykw81cuoArG82NhFSvm2WFk2EomP78zIjQI2pHJPArhLzfBRU7Mi/GSiGtq7DlmzEJHNgYiAAvSRFdFj25/fVjcM4n3US5yptODNFSm61UsQ5yr9HjyK7IFjZFJKGQnNeAejxWynKoi0fgfUaQMNSDKrZslzaOD97xmdr1DYO75ciGDfYWYRMKZX71HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4i0zjaU3j8YaSa2tzXXIV7x2T+9CsiwR3MqhIZacOP4=;
 b=HkpeZW84DP1PSHod4VgASxKUT/qg4QKCOCrd8x1JBtJW19LJrc/hnAtYrtkqgiVNPMLAoOQOJhWOq69OgfD+572+3X7RHysTE1E7QsX5TV215mpty2Rlfm9fKt7WBcKdZbOpoJR+hP6sp8v78ABH7rqse2ccCFMmXK1/cKquxA8=
Received: from BY5PR13CA0032.namprd13.prod.outlook.com (2603:10b6:a03:180::45)
 by SJ0PR12MB6829.namprd12.prod.outlook.com (2603:10b6:a03:47b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 14:57:53 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::b2) by BY5PR13CA0032.outlook.office365.com
 (2603:10b6:a03:180::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.21 via Frontend
 Transport; Mon, 29 Apr 2024 14:57:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:57:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:57:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jonathan Kim <jonathan.kim@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 08/14] drm/amdkfd: always enable ttmp setup for gfx12
Date: Mon, 29 Apr 2024 10:57:20 -0400
Message-ID: <20240429145726.3459450-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429145726.3459450-1-alexander.deucher@amd.com>
References: <20240429145726.3459450-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|SJ0PR12MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: 28bbba12-3252-4419-b925-08dc685cbf73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|376005|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hs/XiSddBWpfR/1ld73BwD/aEQ19aK7ciKLTcHeABNhsRkdrD6AE6bp/VgWm?=
 =?us-ascii?Q?QTPBIX2RjkYdvLmk7DSDL4lHhR4WhBDssowL2YzFfQUqQt+xrHp+Jv7u3AX9?=
 =?us-ascii?Q?G9jOqZKMWsx+xxUeWPImzXGN8IORPeSRSILHFrl2Kuez+DYlktn1l8u8elHa?=
 =?us-ascii?Q?efJJALeAmwjdK+qLQwE6IK3x3UfeHVLFvWnBIgks1hzRnJeK+A0TtgLGXeVU?=
 =?us-ascii?Q?f/oyS8Wj2OrNp+4FKTQugyJ6fqJaJ5Fbzy9/KJCRiQbFxTiPxe25LR3qfrVn?=
 =?us-ascii?Q?GwLt0obSYTnHvQkbTCL7E67krRBPVbEtcGDPiarc1ZusH+LrcWLGXRMzJ40H?=
 =?us-ascii?Q?VHWjWvUokj6giI1FrA522yTVdLDW8UtK3vmNrJFzsDLpeOmjMNSa+ILSiWpR?=
 =?us-ascii?Q?wdZify+l3CxuCuAYlcecG7AayYSTAoOKUrmpRRFdoktAKXDrx5DmAVO7yGNN?=
 =?us-ascii?Q?9x822gGhxWzyg6q74GxcS3qIxXlxaNRR7PLrHIj8UENxLOrajHEDN4JtLIHF?=
 =?us-ascii?Q?XjrAB0y/Y4CzJ7BJH4Z5ZgBc4cfmFDHKjaSDaKsCH10onMYCW/Nz9pU9nHwQ?=
 =?us-ascii?Q?oOWZXgDYC1FP3Ck6GTMQ3Yrz8uFkG9YW5W7cneJB7FiLjhceyh1+WnG6ubnN?=
 =?us-ascii?Q?2gvzQX8qExPBhTIaP5rz7k05yHFGFEuGQKskAr6qthb0uJDFqI/KT4vetwX1?=
 =?us-ascii?Q?DROo/ISvsU6IAOCGSVoJVpqkaE9aUx6yJEjwp9uSLxbKkhaJn9MOqbCMb0bQ?=
 =?us-ascii?Q?qB9LKsLOz7WZChd+FPO4JK5chyDxkIXk6D6F8GCgl9H0+Hba96AqV33bnfNU?=
 =?us-ascii?Q?Wu/OvnQTFyFvAKp2Ml9od+DJrdHVpFrl7QlmOA2P9MCU/gN486rNusFxys1J?=
 =?us-ascii?Q?899vJ/wSjPCzurJv/rzC2yPe13qB4M0U3bJ2SQdT8v0vV6z/vn4nEWV6WtJ+?=
 =?us-ascii?Q?z2s1j4VU9LI2hPLLoOsO7v7plo0pcvgycLs3Um0D2CfYmXI/R7VflbF4X7jv?=
 =?us-ascii?Q?ENKt8yXrSBAElnsdl8nAdTUPxrk9U1aC9SlUfmlKvi4bvZAAJiE93tSO1kq+?=
 =?us-ascii?Q?yovOr+ULi/2LA1ivflyQ8AbNhR4n7lp8eh0tJxy+yffOWnnT4HQMaQ62I0kz?=
 =?us-ascii?Q?/n4qW9M020ToDS1VzfjiW9b3GiXR6AtYaiaz41epBvkM+tQKR70y1ns1ahC+?=
 =?us-ascii?Q?M4fx7B0eLTP7bHu6V58PqPShOCNT236ig0K3g0So3DKclt0FrTOWMjDrF0mV?=
 =?us-ascii?Q?2P4IG6XHtNH2eGQFYxPrkamzqE7TXbTB4d4ZcMCLp/B+hJR8Ryax0TLo69qn?=
 =?us-ascii?Q?vjQWPgEoW7ysWZm4AjBzrruU9FDH26arplXvB7HaHlLWfaAfOFSUzaqaAkVn?=
 =?us-ascii?Q?os01kMQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:57:53.6361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28bbba12-3252-4419-b925-08dc685cbf73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6829
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

From: Jonathan Kim <jonathan.kim@amd.com>

Similar to GFX11, always enable the setup of trap temporaries on GFX12.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h             | 3 ++-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
index 5aa2fd147d99d..efb4bed2d900a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
@@ -205,7 +205,7 @@ static uint32_t kgd_gfx_v12_disable_debug_trap(struct amdgpu_device *adev,
 {
 	uint32_t data = 0;
 
-	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, keep_trap_enabled);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
 	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, 0);
 	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_REPLACE, 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index c94ed3b929cb4..51955a4e47d59 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1446,6 +1446,7 @@ static void gfx_v12_0_init_compute_vmid(struct amdgpu_device *adev)
 		/* Enable trap for each kfd vmid. */
 		data = RREG32_SOC15(GC, 0, regSPI_GDBG_PER_VMID_CNTL);
 		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
+		WREG32_SOC15(GC, 0, regSPI_GDBG_PER_VMID_CNTL, data);
 	}
 	soc24_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index fd0ff64d4184a..da9a3cb329f13 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -134,6 +134,7 @@ static inline bool kfd_dbg_has_ttmps_always_setup(struct kfd_node *dev)
 			KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 2)) ||
 	       (KFD_GC_VERSION(dev) >= IP_VERSION(11, 0, 0) &&
 			KFD_GC_VERSION(dev) < IP_VERSION(12, 0, 0) &&
-			(dev->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 70);
+			(dev->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 70) ||
+	       (KFD_GC_VERSION(dev) >= IP_VERSION(12, 0, 0));
 }
 #endif
-- 
2.44.0

