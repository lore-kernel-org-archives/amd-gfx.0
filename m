Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE5ECF0432
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 21:16:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59CA410E5CB;
	Tue,  8 Oct 2024 21:16:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T4w0xdDV";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E3A510E5DD
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 21:16:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdvHL1tDM18Z6mGqNQ8LhVqqvBGc/WsFfHtG4BjLD2mghTUIILM01xvRB92ei9pCJS6MsW3NNfc4vb8bPgZ7IWspS7s+J4hnqaJtczX1p+XPFumkH38ck95lbMHMU/GtpPz0UFC2b7fNjxzPkrgMGzOqMGk++8ildijM+iD1wMutT1ozGCv9khLkvi/kTR9WoFvQ9zOBnv0doHCbT8D3EcN5YjA3lWlKU+5bgyy05ssdMQe5nfgXJL6ccFztajLHZUWr0P5wEaJjFYv/Nvxo2wFWY7C+BTgHgPl6QBxk4aM5UR50SijkyR46UGQKGovv0b/veZzQ6j7PH14iT3jW0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBmhSpYavlUZsJ6eC54svzHT4Le9WQtEgD9v2qrVSM8=;
 b=PZCcTj76CzbWf3m7lkyiqPHlN0Uvwb5y0FQc2430LXOfDRSl3I520vNezKmndIPx2bTGu9UvH0mUGPEQbP2lBnd3+ZpV7bAlGKzn5h3VSKtRzrsblPVnaWzhOCWVpRNfFeG2Y1pEJmw2/uVK35WcdRBxKjnxPEgktPbnvhaU47wfW3vEAm77YWvTtS5im/XWdBZAIEWWJg4KAjmO1EyE0Iar/dLHI6QyvAmY+b4Qayih4vSvWCF9YCaHqEQsqtPaUOhScCBaU/1BIIsqEQg3sSVrHi0TDgRfwwVIRIajGtDeLPKRvqr17BxMe2rPdXbvf4PKVl7n3dBSnAmqk7PltQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBmhSpYavlUZsJ6eC54svzHT4Le9WQtEgD9v2qrVSM8=;
 b=T4w0xdDVIf75RR0lckI0IvVfAbiNoibnZ8L5+g3kOrqx56x0jgDX0NuNDs+PldAbRACTJBRTfYIuSOWFjmqb7AnUq3W2F02rcCybg/4MaD2U23/1kKwGbZb7k0ABG8FyRVVgfTJe/+hNXrpOVjEsTLdPW12lx4iR6LPLcT2lwY8=
Received: from CH2PR05CA0031.namprd05.prod.outlook.com (2603:10b6:610::44) by
 MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 21:16:30 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::7f) by CH2PR05CA0031.outlook.office365.com
 (2603:10b6:610::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16 via Frontend
 Transport; Tue, 8 Oct 2024 21:16:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 21:16:30 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 16:16:25 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 19/32] drm/amdgpu: set powergating state by vcn instance
Date: Tue, 8 Oct 2024 17:15:40 -0400
Message-ID: <20241008211553.36264-20-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008211553.36264-1-boyuan.zhang@amd.com>
References: <20241008211553.36264-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|MN2PR12MB4408:EE_
X-MS-Office365-Filtering-Correlation-Id: c29b731b-4e96-4052-893a-08dce7de7a6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O7pcaMWdNQFDb/jfEtWGmVLsVa5GboVBjtADeDVECiOFfe+bVOfIBvZS/TYA?=
 =?us-ascii?Q?o5cLqnUviFmgrGBtB8IdQnICW5MOH55TkV0qq64jTKolPhQGnqxBskQ8Y4Iw?=
 =?us-ascii?Q?vDnJ8gUhyFBPij5DdhaUb34P+GvjI8bTmjaVcGpEY7/4FXmjBehDAma6IGLo?=
 =?us-ascii?Q?RYxjfKtBmdd/PhnuY4lf4AjdfVhlYXL+shfGlAEb5DHP5YTPD+haXuRDbGq+?=
 =?us-ascii?Q?8JoD9+kV/vPeKnSudl9QcpNxuBTQUqgWWZN0Gd91OZwCMuPDVbSNQz7jLTS8?=
 =?us-ascii?Q?7H39sP8YKiHUwRAv68VWjkbFHcFG4pOM3D15JQBFdEg7NpIWeDCDlcoEaKBv?=
 =?us-ascii?Q?Sx4qF3xvb18Pgruso45ZJQDT8yq7i80AHTUW4p725kjkNnZoAOFPUa5XkkoD?=
 =?us-ascii?Q?CAMla7AmNGKDObqrWElZ6xxJ6bjzT1VjQE3gOL4IV6dUloptoXA+ksYZnimM?=
 =?us-ascii?Q?uk3K3yIJba7FvfsnZeTfo7nyY6ANBrcf6fjt4tccgkrXSk4UWY53kotsoB5h?=
 =?us-ascii?Q?W9PSM175BWhwruloC8bh+fs81y32VYRGjefpkbBNXxHKhu4wQ4KDyldax0Z2?=
 =?us-ascii?Q?iQ2vm4a8qRIucSj855FMJ1Znh+LnnEWF0w2W4Qa7BfJyjm/NcIyi7FQ21U/Y?=
 =?us-ascii?Q?5sD19k7nmvYMnz/wMt43sWp/Xdt7vNjYa1IBWyFDiZ8ZY87db1KJYx54HbUn?=
 =?us-ascii?Q?GFrL2YtOrdDSlaHvrj5R9HqxdH4M285KmtTTVCGG+cVNlTKO/QpCs4pEUQQC?=
 =?us-ascii?Q?xmQtibsDHtdVgy725xZwF7TZgKoJxhA59zkZWTBh5Qfo9nr0fEK1StnXd94l?=
 =?us-ascii?Q?lEXFq5PZOqKpSr++pMiro9XcO5E/qih97stYCQP6XmVoHXdFnpoBcEks/mLB?=
 =?us-ascii?Q?YCFwvUhF6Q/klUgrrou9ZB4fkLQo44pu6PczchOtkEOJjF7KFTvUw4jJUqEY?=
 =?us-ascii?Q?TyB5+qB3y2CZ8Do4myjblGMQxnVAU2TBDOAQpMwuNfB620AG1uK04RZlVgRM?=
 =?us-ascii?Q?Mx4gGD7m9eEFDaASeUh3MnxiO7LrSBdtfhNdqlUDAlKmcvN1R3o+jMXs1xlD?=
 =?us-ascii?Q?j6ITvz4KFpYR9uqMqZyjCGkj7HeGS6CkAYlZFByRjsc5/QwJ/yunglgSJV3r?=
 =?us-ascii?Q?52NMHEzHMaKRbO26yMd5RlbiMXjuGkq1uZhg4a73QlMxXwYNKFWCZyiRXClH?=
 =?us-ascii?Q?89KHc4B48HoO3hZfQ3wQoNBilB7s7C2yhijqJq/VT1Vge93AFt2FdGsUqhEv?=
 =?us-ascii?Q?nhXvA6xboC580/jmeNPw1Cj12+tAy0tFpiknNJdGUd7GfiGdWm9k4lgikKOM?=
 =?us-ascii?Q?e/qTcN5GnBUAYn80xrIZcn/MceMObQEDOr5APvLsKOtDOaeoyjtPUSGqqyPL?=
 =?us-ascii?Q?Qbbg85k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 21:16:30.0294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c29b731b-4e96-4052-893a-08dce7de7a6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Set powergating state by vcn instance in idle_work_handler() and
ring_begin_use() functions for vcn with multiple instances.

v2: Add instance parameter to amdgpu_device_ip_set_powergating_state(),
instead of creating new function.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c              |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c              |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c              | 10 ++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c              |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c                |  4 ++--
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                  |  6 ++++--
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c           |  8 ++++----
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c |  6 ++++--
 .../amd/pm/powerplay/hwmgr/smu7_clockpowergating.c   | 12 ++++++++----
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c  | 12 ++++++++----
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c    |  6 ++++--
 22 files changed, 65 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3442564fe174..53b7b7c0291c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -357,7 +357,8 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
 					   enum amd_clockgating_state state);
 int amdgpu_device_ip_set_powergating_state(void *dev,
 					   enum amd_ip_block_type block_type,
-					   enum amd_powergating_state state);
+					   enum amd_powergating_state state,
+					   int inst);
 void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
 					    u64 *flags);
 int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 426beab725b2..5ccfe7394e15 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2141,7 +2141,8 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
  */
 int amdgpu_device_ip_set_powergating_state(void *dev,
 					   enum amd_ip_block_type block_type,
-					   enum amd_powergating_state state)
+					   enum amd_powergating_state state,
+					   int inst)
 {
 	struct amdgpu_device *adev = dev;
 	int i, r = 0;
@@ -2151,6 +2152,9 @@ int amdgpu_device_ip_set_powergating_state(void *dev,
 			continue;
 		if (adev->ip_blocks[i].version->type != block_type)
 			continue;
+		if (block_type == AMD_IP_BLOCK_TYPE_VCN &&
+				adev->ip_blocks[i].instance != inst)
+			continue;
 		if (!adev->ip_blocks[i].version->funcs->set_powergating_state)
 			continue;
 		r = adev->ip_blocks[i].version->funcs->set_powergating_state(
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 95e2796919fc..78fd1ff28a57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -119,7 +119,7 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
 
 	if (!fences && !atomic_read(&adev->jpeg.total_submission_cnt))
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 	else
 		schedule_delayed_work(&adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);
 }
@@ -133,7 +133,7 @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
 
 	mutex_lock(&adev->jpeg.jpeg_pg_lock);
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
-						       AMD_PG_STATE_UNGATE);
+						       AMD_PG_STATE_UNGATE, 0);
 	mutex_unlock(&adev->jpeg.jpeg_pg_lock);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 31fd30dcd593..09844953a1fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1277,7 +1277,7 @@ static void amdgpu_uvd_idle_work_handler(struct work_struct *work)
 			amdgpu_asic_set_uvd_clocks(adev, 0, 0);
 			/* shutdown the UVD block */
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-							       AMD_PG_STATE_GATE);
+							       AMD_PG_STATE_GATE, 0);
 			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 							       AMD_CG_STATE_GATE);
 		}
@@ -1303,7 +1303,7 @@ void amdgpu_uvd_ring_begin_use(struct amdgpu_ring *ring)
 			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 							       AMD_CG_STATE_UNGATE);
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-							       AMD_PG_STATE_UNGATE);
+							       AMD_PG_STATE_UNGATE, 0);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 74fdbf71d95b..a061fb8a2fcf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -344,7 +344,7 @@ static void amdgpu_vce_idle_work_handler(struct work_struct *work)
 		} else {
 			amdgpu_asic_set_vce_clocks(adev, 0, 0);
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-							       AMD_PG_STATE_GATE);
+							       AMD_PG_STATE_GATE, 0);
 			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
 							       AMD_CG_STATE_GATE);
 		}
@@ -378,7 +378,7 @@ void amdgpu_vce_ring_begin_use(struct amdgpu_ring *ring)
 			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
 							       AMD_CG_STATE_UNGATE);
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-							       AMD_PG_STATE_UNGATE);
+							       AMD_PG_STATE_UNGATE, 0);
 
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 4838a4ca44f8..e93d3ef2fdd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -410,8 +410,9 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	fence += amdgpu_fence_count_emitted(&adev->vcn.inst[inst].ring_dec);
 
 	if (!fence && !atomic_read(&adev->vcn.total_submission_cnt)) {
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-		       AMD_PG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(adev,
+			AMD_IP_BLOCK_TYPE_VCN, AMD_PG_STATE_GATE, inst);
+
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 											false);
 		if (r)
@@ -436,8 +437,9 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	}
 
 	mutex_lock(&adev->vcn.vcn_pg_lock);
-	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-	       AMD_PG_STATE_UNGATE);
+
+	amdgpu_device_ip_set_powergating_state(adev,
+		AMD_IP_BLOCK_TYPE_VCN, AMD_PG_STATE_UNGATE, ring->me);
 
 	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 416d1a073173..6b2afcc3fb21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -330,7 +330,7 @@ static void vpe_idle_work_handler(struct work_struct *work)
 	fences += amdgpu_fence_count_emitted(&adev->vpe.ring);
 
 	if (fences == 0)
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE, 0);
 	else
 		schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
 }
@@ -406,7 +406,7 @@ static int vpe_hw_init(struct amdgpu_ip_block *ip_block)
 
 	/* Power on VPE */
 	ret = amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE,
-						     AMD_PG_STATE_UNGATE);
+						     AMD_PG_STATE_UNGATE, 0);
 	if (ret)
 		return ret;
 
@@ -429,7 +429,7 @@ static int vpe_hw_fini(struct amdgpu_ip_block *ip_block)
 	vpe_ring_stop(vpe);
 
 	/* Power off VPE */
-	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
+	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE, 0);
 
 	return 0;
 }
@@ -845,7 +845,7 @@ static void vpe_ring_begin_use(struct amdgpu_ring *ring)
 		uint32_t context_notify;
 
 		/* Power on VPE */
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_UNGATE);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_UNGATE, 0);
 
 		/* Indicates that a job from a new context has been submitted. */
 		context_notify = RREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.context_indicator));
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index d5a5a5189ac6..a3b8bccf3c9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -735,7 +735,7 @@ static int uvd_v3_1_suspend(struct amdgpu_ip_block *ip_block)
 		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
 		/* shutdown the UVD block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index 9e3ac12d0127..7dced60403ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -249,7 +249,7 @@ static int uvd_v4_2_suspend(struct amdgpu_ip_block *ip_block)
 		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
 		/* shutdown the UVD block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index a16c99d0b85d..f883cf8d2d2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -247,7 +247,7 @@ static int uvd_v5_0_suspend(struct amdgpu_ip_block *ip_block)
 		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
 		/* shutdown the UVD block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 5da51118a184..9cb78358e355 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -571,7 +571,7 @@ static int uvd_v6_0_suspend(struct amdgpu_ip_block *ip_block)
 		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
 		/* shutdown the UVD block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 591db2da8067..92f369d08fec 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -639,7 +639,7 @@ static int uvd_v7_0_suspend(struct amdgpu_ip_block *ip_block)
 		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
 		/* shutdown the UVD block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index f4bd28af41e1..72e01a0352ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -512,7 +512,7 @@ static int vce_v2_0_suspend(struct amdgpu_ip_block *ip_block)
 	} else {
 		amdgpu_asic_set_vce_clocks(adev, 0, 0);
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 679033481616..4ee0d479b0fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -523,7 +523,7 @@ static int vce_v3_0_suspend(struct amdgpu_ip_block *ip_block)
 	} else {
 		amdgpu_asic_set_vce_clocks(adev, 0, 0);
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index adcbf61411b5..d9c36d7213de 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -589,7 +589,7 @@ static int vce_v4_0_suspend(struct amdgpu_ip_block *ip_block)
 	} else {
 		amdgpu_asic_set_vce_clocks(adev, 0, 0);
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index f6886cf2a686..f093d66df1a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1861,7 +1861,7 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 			amdgpu_dpm_enable_vcn(adev, false, 0);
 		else
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-			       AMD_PG_STATE_GATE);
+			       AMD_PG_STATE_GATE, 0);
 	} else {
 		schedule_delayed_work(&adev->vcn.inst[0].idle_work, VCN_IDLE_TIMEOUT);
 	}
@@ -1891,7 +1891,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
 			amdgpu_dpm_enable_vcn(adev, true, 0);
 		else
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-			       AMD_PG_STATE_UNGATE);
+			       AMD_PG_STATE_UNGATE, 0);
 	}
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 5a9006bfc3cd..d4c264814b61 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1026,7 +1026,8 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 		/* enter UMD Pstate */
 		amdgpu_device_ip_set_powergating_state(adev,
 						       AMD_IP_BLOCK_TYPE_GFX,
-						       AMD_PG_STATE_UNGATE);
+						       AMD_PG_STATE_UNGATE,
+						       0);
 		amdgpu_device_ip_set_clockgating_state(adev,
 						       AMD_IP_BLOCK_TYPE_GFX,
 						       AMD_CG_STATE_UNGATE);
@@ -1038,7 +1039,8 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 						       AMD_CG_STATE_GATE);
 		amdgpu_device_ip_set_powergating_state(adev,
 						       AMD_IP_BLOCK_TYPE_GFX,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE,
+						       0);
 	}
 
 	mutex_lock(&adev->pm.mutex);
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 3cafc9493e88..b0443f20fe2a 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -1675,7 +1675,7 @@ static void kv_dpm_powergate_uvd(void *handle, bool gate)
 	if (gate) {
 		/* stop the UVD block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		kv_update_uvd_dpm(adev, gate);
 		if (pi->caps_uvd_pg)
 			/* power off the UVD block */
@@ -1688,7 +1688,7 @@ static void kv_dpm_powergate_uvd(void *handle, bool gate)
 		kv_update_uvd_dpm(adev, gate);
 
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_UNGATE);
+						       AMD_PG_STATE_UNGATE, 0);
 	}
 }
 
@@ -1702,7 +1702,7 @@ static void kv_dpm_powergate_vce(void *handle, bool gate)
 	if (gate) {
 		/* stop the VCE block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		kv_enable_vce_dpm(adev, false);
 		if (pi->caps_vce_pg) /* power off the VCE block */
 			amdgpu_kv_notify_message_to_smu(adev, PPSMC_MSG_VCEPowerOFF);
@@ -1712,7 +1712,7 @@ static void kv_dpm_powergate_vce(void *handle, bool gate)
 		kv_enable_vce_dpm(adev, true);
 		/* re-init the VCE block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-						       AMD_PG_STATE_UNGATE);
+						       AMD_PG_STATE_UNGATE, 0);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index a8c732e07006..41dbf043f59b 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1407,7 +1407,8 @@ static void smu10_powergate_vcn(struct pp_hwmgr *hwmgr, bool bgate)
 	if (bgate) {
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_VCN,
-						AMD_PG_STATE_GATE);
+						AMD_PG_STATE_GATE,
+						0);
 		smum_send_msg_to_smc_with_parameter(hwmgr,
 					PPSMC_MSG_PowerDownVcn, 0, NULL);
 		smu10_data->vcn_power_gated = true;
@@ -1416,7 +1417,8 @@ static void smu10_powergate_vcn(struct pp_hwmgr *hwmgr, bool bgate)
 						PPSMC_MSG_PowerUpVcn, 0, NULL);
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_VCN,
-						AMD_PG_STATE_UNGATE);
+						AMD_PG_STATE_UNGATE,
+						0);
 		smu10_data->vcn_power_gated = false;
 	}
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
index f2bda3bcbbde..b496b77153e9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
@@ -120,7 +120,8 @@ void smu7_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
 	if (bgate) {
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_UVD,
-						AMD_PG_STATE_GATE);
+						AMD_PG_STATE_GATE,
+						0);
 		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
 				AMD_IP_BLOCK_TYPE_UVD,
 				AMD_CG_STATE_GATE);
@@ -133,7 +134,8 @@ void smu7_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
 				AMD_CG_STATE_UNGATE);
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_UVD,
-						AMD_PG_STATE_UNGATE);
+						AMD_PG_STATE_UNGATE,
+						0);
 		smu7_update_uvd_dpm(hwmgr, false);
 	}
 
@@ -148,7 +150,8 @@ void smu7_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
 	if (bgate) {
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_VCE,
-						AMD_PG_STATE_GATE);
+						AMD_PG_STATE_GATE,
+						0);
 		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
 				AMD_IP_BLOCK_TYPE_VCE,
 				AMD_CG_STATE_GATE);
@@ -161,7 +164,8 @@ void smu7_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
 				AMD_CG_STATE_UNGATE);
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_VCE,
-						AMD_PG_STATE_UNGATE);
+						AMD_PG_STATE_UNGATE,
+						0);
 		smu7_update_vce_dpm(hwmgr, false);
 	}
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index 7e1197420873..2ccce2bc3b4a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -1985,7 +1985,8 @@ static void smu8_dpm_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
 	if (bgate) {
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_UVD,
-						AMD_PG_STATE_GATE);
+						AMD_PG_STATE_GATE,
+						0);
 		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_UVD,
 						AMD_CG_STATE_GATE);
@@ -1998,7 +1999,8 @@ static void smu8_dpm_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
 						AMD_CG_STATE_UNGATE);
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_UVD,
-						AMD_PG_STATE_UNGATE);
+						AMD_PG_STATE_UNGATE,
+						0);
 		smu8_dpm_update_uvd_dpm(hwmgr, false);
 	}
 
@@ -2017,7 +2019,8 @@ static void smu8_dpm_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
 	if (bgate) {
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 					AMD_IP_BLOCK_TYPE_VCE,
-					AMD_PG_STATE_GATE);
+					AMD_PG_STATE_GATE,
+					0);
 		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
 					AMD_IP_BLOCK_TYPE_VCE,
 					AMD_CG_STATE_GATE);
@@ -2032,7 +2035,8 @@ static void smu8_dpm_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
 					AMD_CG_STATE_UNGATE);
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 					AMD_IP_BLOCK_TYPE_VCE,
-					AMD_PG_STATE_UNGATE);
+					AMD_PG_STATE_UNGATE,
+					0);
 		smu8_dpm_update_vce_dpm(hwmgr);
 		smu8_enable_disable_vce_dpm(hwmgr, true);
 	}
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index baf251fe5d82..64ef8c8398ff 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -3715,11 +3715,13 @@ static void vega20_power_gate_vce(struct pp_hwmgr *hwmgr, bool bgate)
 		vega20_enable_disable_vce_dpm(hwmgr, !bgate);
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_VCE,
-						AMD_PG_STATE_GATE);
+						AMD_PG_STATE_GATE,
+						0);
 	} else {
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_VCE,
-						AMD_PG_STATE_UNGATE);
+						AMD_PG_STATE_UNGATE,
+						0);
 		vega20_enable_disable_vce_dpm(hwmgr, !bgate);
 	}
 
-- 
2.34.1

