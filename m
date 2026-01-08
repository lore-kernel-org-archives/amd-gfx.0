Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2B8D1D465
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6178310E75E;
	Thu,  8 Jan 2026 14:49:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A+qk9YLQ";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013054.outbound.protection.outlook.com
 [40.107.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46A4D10E75B
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/1lJSBPu0vAJ0RC11rz2mPALSq6+7cwEpraY7QcjNJvlan8UKM2wYtkoZWhB86xQJ6rLjJ6VTXuZaukakPi1uk43SyEPqvsENVqHeLnuKMttS43BEz5xJWfqqnsb1wsGK9UWWZCKPcsT5K+onAHTDngFIra4iTwP6qKfFYAPPcqNJZkIVw8D2EGhKvZzegP4b7KcO1gxSOfh6wfsrhUjqtkMsWz0toqmGIic5M8XWc9Peh1fI4NrwrcW9lH1LBPWryzUOsOvG5j3CglUR26BqrxcCaIw/NBFEBlBqgLPLU3TRZqALK0erQTz3iuSKpGBoFAKgS/NQMqYyzmb2ikSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3crgyggxxGRLB2ZFMXdvfarhIR/xs1Esnhx9K1aRqs=;
 b=EuE2TtrgdWxuM3xonMk/5GIgV6bfwUjuqGZ/9o7/j1XC8yBee4bldPIV4dqLqUxiF7s4GJsLqBq5WnNBLHghmu5oaFb3CWLeQcwkzBnJSEj/U28EL1UGyyUX3oXU09tHa3c5nvhzVAvD/0zNDg3OOTUVoin5yWuA2j13LrF7zLlUV1RIVqZD1+P7ekYGFZCs2hHybygV/axOX6yAhG+TJKVHjUyP/tz0nwkioeCxX9cuqaKjctmlqgzNDSda23WNqxuU8KHKdZPH656TMM0M198mc3vMWp/iwYE8ApVYHrYyHX3y8LHy0p61CNi6f0g7PXd1ZljM7GdVDMkp56sMUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3crgyggxxGRLB2ZFMXdvfarhIR/xs1Esnhx9K1aRqs=;
 b=A+qk9YLQRMg3OjpcFoCZAMmcpBl0b0YfhWD1sp2zm77MqGEl98SOpmVG5pl7xWWgTn9YI+X2HIG5TkdJBRF0TOmBxLQd1uhTcXoNbyRnKpYux0qyb2qBighGpOkIwQuDs334i7QrDnIUUzOP+1tTEHGRXbfND5GugpO9WxYb1pQ=
Received: from BL0PR02CA0135.namprd02.prod.outlook.com (2603:10b6:208:35::40)
 by CH2PR12MB4182.namprd12.prod.outlook.com (2603:10b6:610:ae::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 14:48:55 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::43) by BL0PR02CA0135.outlook.office365.com
 (2603:10b6:208:35::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 14:48:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:48:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:48:51 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:48:51 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/42] drm/amdgpu: add new job ids
Date: Thu, 8 Jan 2026 09:48:04 -0500
Message-ID: <20260108144843.493816-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|CH2PR12MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: 240960f1-0012-4125-5ee6-08de4ec50c30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dk8BBuA5jvTiZiiriG9kCzeQ7f0A+am2MQM1JHyN0O+U0/JRRuK7bqSSa6G7?=
 =?us-ascii?Q?lbNcAtlp+E2a8jNXWoayfl290QCzeXnn6BfFMTOpjj/5Fva1hAGBdTueorqw?=
 =?us-ascii?Q?6wwrGkHzWLaCQKJn06X4RM16FV2ti/FR9ITrlD+o4q4urmmZwmQl4FOeEUKT?=
 =?us-ascii?Q?05IyZEzEAc3MdoVXOQKKssioJmbucFVunWQ9lKfwwQ2RSMGPZF4ucaRt+i+U?=
 =?us-ascii?Q?AUQ988j9efFtDKNH2TfgEZo5ijKtDj7L3PxIe0AZIAG07QfjXHTxFDRQ6xtd?=
 =?us-ascii?Q?d60fnsMinU5V+bpkArPhXzTsGfj7fE1Rd7O97HY/1yIObUQnDXZDf0mdO3wQ?=
 =?us-ascii?Q?Ese64dkveC+TRpRE9NZWkO9CQ6tlHDdl9m3hK6Wfq+O9T/GaSD7gW4mZ8V0l?=
 =?us-ascii?Q?detBm4ig4mWs+bESWH+kJYfqUGcY+UAXpjS+bGVifWZ7J8/mAvmnkNmko/+7?=
 =?us-ascii?Q?POX+Ifz0L5UPyKnCNM4MDm3E2MVYrwNbi+7WB607/lUg38ucUjdkr8dE3TS3?=
 =?us-ascii?Q?Fd4Wm0ZXTdA7w1i1NSTq4lDdjEdhxasXG65kL6ZdtHJEbVPZBv1sRe+dcPkE?=
 =?us-ascii?Q?5394I3pIEe8U1E6QM8Ri4drdQj3P8arHEDF6DyyvkJ/azo03XkT5zlPS4/wJ?=
 =?us-ascii?Q?a3aMADvGUyn4/2notUqX5ZV765A9JdyDcvKgr3afGNmG33zRevJ1iBzJiE/e?=
 =?us-ascii?Q?mHsLuiYifFXNySLXHe+aO4ex6ZEqkmiTto4U8S6cT+7yOMoEVNy5yUCRZb3O?=
 =?us-ascii?Q?cqch50Mw0ch+VR3GePkjb8K3RfIDXmZskwoNGlW3cst8AmXWdWytGrpvHr3/?=
 =?us-ascii?Q?l4zrwEqmZYlZvCj2HXH8m6wFCbhbxuWuLPq2IO64anac5rY7ZZ47rIhx2rLH?=
 =?us-ascii?Q?Swm2iQxX1b8gHMFJgDsRFO0peL2C7NqX/UarqTD9uJPAUVAuiIkNA9uPCt1u?=
 =?us-ascii?Q?mMVMCpJx12u/Mi0LfgMFkp2HwoxacwtSKWcDXU9mIqhZefl3l1exXwBBtMoB?=
 =?us-ascii?Q?JmPEFhFRT/P/9IQG4dYi2PRDgHtGDBgtGuXSZpTJ9JZdaLUPW7kzxKeEoGnB?=
 =?us-ascii?Q?JwRVUiSgAPOHTpA9YW1ZK24ANfxEbXu3LxtjZpI9zw0wRzoq8v6OymufV7MW?=
 =?us-ascii?Q?13lIZWgsaNVlTVUx0swXdCuFgR2MZBDw312QAQ/c8/YxrEdCZynfevFly9Iw?=
 =?us-ascii?Q?kKv6fo6ONzaZEHzysDlZnZ79Ii1IuKuAu9um9ARyqA2VzEiVrsMO2+39CO+4?=
 =?us-ascii?Q?LxBxjxP+4Z/xp5xUMOPnUYE5n1Bw56IE38LX8jwf9/ZkNIwvP3nh7wCnxdtc?=
 =?us-ascii?Q?pLugDuccMQcnQcHRPuIh9XllpsJne0habD1Lp/9mrY8toOBH7mCC2bQwtc4Q?=
 =?us-ascii?Q?OJnsXCJy3jz908D1BNWAlYEzsFzTz16aiJTaB1c6bsBy/JkkLARrStDLUFUx?=
 =?us-ascii?Q?hnruRroIIC66EeTiDPtCKazz/t/7RqeAwk4bJ6GMMrKUVLCGakXQIQ99bUoa?=
 =?us-ascii?Q?f+R9zHwgRn/mrnFKS6AWZVYxIl5i8ctMdZ8KgzFK2guuMZpsvcJdQoLfKHmv?=
 =?us-ascii?Q?v5zz4UPB9nTxCEd/69s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:48:55.2767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 240960f1-0012-4125-5ee6-08de4ec50c30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4182
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

Use this for gfx, sdma, vpe IB tests and kernel shaders.
The end goal it to get rid of the direct IB submit without a
job structure.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 7abf069d17d42..56a88e14a0448 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -59,6 +59,10 @@ enum amdgpu_ib_pool_type;
 #define AMDGPU_KERNEL_JOB_ID_FLUSH_GPU_TLB          (18446744073709551604ULL)
 #define AMDGPU_KERNEL_JOB_ID_KFD_GART_MAP           (18446744073709551603ULL)
 #define AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST          (18446744073709551602ULL)
+#define AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST          (18446744073709551601ULL)
+#define AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST         (18446744073709551600ULL)
+#define AMDGPU_KERNEL_JOB_ID_VPE_RING_TEST          (18446744073709551599ULL)
+#define AMDGPU_KERNEL_JOB_ID_RUN_SHADER             (18446744073709551598ULL)
 
 struct amdgpu_job {
 	struct drm_sched_job    base;
-- 
2.52.0

