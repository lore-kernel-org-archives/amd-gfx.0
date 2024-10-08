Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B811CF0423
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 21:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C03010E5CE;
	Tue,  8 Oct 2024 21:16:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SVB/yH7D";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA9AB10E5CD
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 21:16:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rm3TbPrzo9fVpSP4pJWrflTUCNtXaHR1TtKdHZabZ7nN9WqdoGaLFKVHJCbs04gc7GFKlzxkPODUiBsqZ8P+g+PnkYmsA/4JSajUs16WAeK9BeMYVNkgmOvQhHzI5YeyLUh9ftYAi30iYpPaCVOqPJHHyo+b8ZchgjBZJva4LsTs/MyKyLtcjJUb0Qw0yCxErTuL9BjoYaelYXglMQVAAWOcdO8Obp6YSO/IUG0ACaaiEqtxAazAJAeZd3T77Z8aSxAw9/3pGE7v5GUP7O6D14KPTLmyFqw3Iv3BjgtcpR/enqhQ7zCiex7e69Cz+Z7WtiRsZ+xC7vDsxrVc1ViQ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFGwixck59Pbe42gNRP7hcc+ag25QJaiuoOsUNA14wU=;
 b=Mr9IDOzR+45OG0L8MEWsxdZfenPC92l5YzBiDPO3FC0JE6YEaPign6MTb3ncTz07e/fw7JbQ5CFNBwT18xC0qXDC8iu5B2FO4A2/r9J/s3Fv6P8CLbLFgKrtWqs5kTObIWXhLIQ+OLwZyouT+HHXtXbstS6NDZxb7c7v9giwDi24zyGeR9XyzdgKA7st1lDSyEyW5okV5Bir7Lsu4Gc3tajJLxuF1iSSk7VrGCWTKG7nFR3XJnhWg9Sa0811KEi4HHiyuqzlRc8xzjNVKY8T+/MAElhYlxtK8RcsfQpAwOkTjiofNgi26J+2MXgbiFmJdEGKJf2k3sOoB1thh4CFMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFGwixck59Pbe42gNRP7hcc+ag25QJaiuoOsUNA14wU=;
 b=SVB/yH7DkdjiKMdNl51T+bBxEpFV3mIF/fkVRhs9D2uyfXf9dfGCl52qTpB9Ih8PBQznkN6+bC//tkw3tD+aNlxUV0n5iX3B/ZCb/d/uMGz60RRFTzkQRNYNRMnm89YbnQ2WGY32PbjJ10avjF7z0U4FCt7qnBg9Gqnu0PHE4BE=
Received: from CH0PR03CA0407.namprd03.prod.outlook.com (2603:10b6:610:11b::34)
 by IA0PR12MB8256.namprd12.prod.outlook.com (2603:10b6:208:407::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 21:16:24 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::b0) by CH0PR03CA0407.outlook.office365.com
 (2603:10b6:610:11b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 21:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 21:16:23 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 16:16:20 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 06/32] add inst to amdgpu_dpm_enable_vcn
Date: Tue, 8 Oct 2024 17:15:27 -0400
Message-ID: <20241008211553.36264-7-boyuan.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|IA0PR12MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: d664396d-f09a-4086-a94f-08dce7de76a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iLEI4cVxFX8S0PeKmO8soewxwQ6BC9w2MwS82nKT6scnlj3QhJcFT3hY9XGw?=
 =?us-ascii?Q?lJbJEN26Brg1kKnGuz3y2TbVj24Pbiq73JbXNs9Y5cpFbZd6mi1vXC232Ysu?=
 =?us-ascii?Q?DPpEYJvM3HLAOY6UKhCxFtRQ9rOjaWbfs0RAHofJemSG0D0RiJNCeHGxIR/a?=
 =?us-ascii?Q?C8shRuiv1KOAycK+urbH3lFwEqbjAoR/1UnSMEHYp1x3AFCpfwSy944tOnqR?=
 =?us-ascii?Q?FVeSTA9CQ4o50NZ9DmwchQY1KAwaZtP03YXAyFASFLQozSiM9/y8VDJVslS1?=
 =?us-ascii?Q?MiqRiaUF+N4JHcQALUwuiBaQ4fmygO5KKT54w95DEfI7YykoADyQORPCdtDm?=
 =?us-ascii?Q?B767z5UZfLQ8YH+9M8md4CprEiBkdl0Re2aY/q+H3rqDkeDn9bIi1l4ntoRg?=
 =?us-ascii?Q?8nrG0Ymmum1QuDpFcN7uCHDF6fPXj/6qEksKjVj6q+GftlHISQcp4Gk7hm6Y?=
 =?us-ascii?Q?rEmHpZ2a959czxHOCbqLWGp+pWrZ1tEFwjc+xo780vs96OEl2NCscplAGZUo?=
 =?us-ascii?Q?rRVxCjL9UuhvkbDs+e08e1NCQExQL4T3QuvPBz+3a4O2Ms4txPvCjq7wCmbg?=
 =?us-ascii?Q?VTO/JBv8rZr++XJSKk18xVhdEX6wNrhbjYitsrOEjn+ZGEjoDWA172Xuocbs?=
 =?us-ascii?Q?lO59dXAZ8rTZUEI2PTBvsFrmnQHVGd5CkoinaGAAI3u0iLxw4RodoxO2gzvn?=
 =?us-ascii?Q?briJ5N1kxW9b17IyWBuhWh7dPuJOmw+K99ZZMnHeitHs1/kCLbuu1olpYG52?=
 =?us-ascii?Q?Svpjc8RgCe/uY6PpGxgqVtv5Ia40mzZ44PaIqvzqad3B+sjT20MJHQZchjbv?=
 =?us-ascii?Q?KfDQuv0cIQmVmtNuNYC01wTBOOPLTWT3PnCZxlL60AaYAIFS6q5+DbYDGhnf?=
 =?us-ascii?Q?Dk4v6JSyoTd2TxqBVfQB6rgIOet4GBI8ruZ68l1Q8gou2BRLBoXM6eLo+eMG?=
 =?us-ascii?Q?Wjky9xTO6sVqSOFQ2q37KXka74ECQjv6VyKNBlq3G5+Vnb3GEiGVI0a89XPt?=
 =?us-ascii?Q?r7TtgiW+N1LZMjThnmhvPpabUR1IMzxvqtTsGjB8riia4Eb4QdsKD42H4dMp?=
 =?us-ascii?Q?5EFZ7qteYP3RdCH0kwPGAo6lLDx9YMBwN5TTjxhIhrdnjARLYq2XW/Di+tQl?=
 =?us-ascii?Q?cqUOw62VmAV4QLpuJyI5uScj/Q+OxsyWOIZMEeHlkuTra0W0rRpts8+yre+y?=
 =?us-ascii?Q?IZhbqG9r5oQBZuBsqfshlIiBzWzGPqcnplQBuUJE9IdosZmMKKDdYveH4lYm?=
 =?us-ascii?Q?fJwQCNHpcoDly4kuYTYczJQlDbtEZDJCMB8AygosyjW6fkX5Ab3bHhfPsP8B?=
 =?us-ascii?Q?cH6gq0TIdBSvGqAbKDZ4ROi+wujE9KZPy8iWtIuqcECVpGvJT7N5Xhc8bBfS?=
 =?us-ascii?Q?rb00G+U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 21:16:23.7020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d664396d-f09a-4086-a94f-08dce7de76a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8256
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

Add an instance parameter to amdgpu_dpm_enable_vcn() function, and change
all calls from vcn ip functions to add instance argument. vcn generations
with only one instance (v1.0, v2.0) always use 0 as instance number. vcn
generations with multiple instances (v2.5, v3.0, v4.0, v4.0.3, v4.0.5,
v5.0.0) use the actual instance number.

v2: remove for-loop in amdgpu_dpm_enable_vcn(), and temporarily move it
to vcn ip with multiple instances, in order to keep the exact same logic
as before, until further separation in next patch.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 12 ++++++++----
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c     | 12 +++++-------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h |  2 +-
 10 files changed, 59 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 746b3d282ca3..1d5b0f4e5b1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -303,7 +303,7 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
 	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.idle_work);
 	if (idle_work_unexecuted) {
 		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, false);
+			amdgpu_dpm_enable_vcn(adev, false, 0);
 	}
 
 	r = vcn_v1_0_hw_fini(ip_block);
@@ -1856,7 +1856,7 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 	if (fences == 0) {
 		amdgpu_gfx_off_ctrl(adev, true);
 		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, false);
+			amdgpu_dpm_enable_vcn(adev, false, 0);
 		else
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 			       AMD_PG_STATE_GATE);
@@ -1886,7 +1886,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
 	if (set_clocks) {
 		amdgpu_gfx_off_ctrl(adev, false);
 		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, true);
+			amdgpu_dpm_enable_vcn(adev, true, 0);
 		else
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 			       AMD_PG_STATE_UNGATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index d0c3895dcf6b..d87e5505cf51 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -978,7 +978,7 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
 	int i, j, r;
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+		amdgpu_dpm_enable_vcn(adev, true, 0);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		return vcn_v2_0_start_dpg_mode(adev, adev->vcn.indirect_sram);
@@ -1235,7 +1235,7 @@ static int vcn_v2_0_stop(struct amdgpu_device *adev)
 
 power_off:
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+		amdgpu_dpm_enable_vcn(adev, false, 0);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index d4c062983bfe..ad0922eb16c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1012,8 +1012,10 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
 	uint32_t rb_bufsz, tmp;
 	int i, j, k, r;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1485,8 +1487,10 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev)
 			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 	}
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 1da9a7dfb667..19c7f9cd4c15 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1141,8 +1141,10 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 	uint32_t rb_bufsz, tmp;
 	int i, j, k, r;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1632,8 +1634,10 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev)
 		vcn_v3_0_enable_static_power_gating(adev, i);
 	}
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index a04a64442809..e97d7f4ae371 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1088,8 +1088,10 @@ static int vcn_v4_0_start(struct amdgpu_device *adev)
 	uint32_t tmp;
 	int i, j, k, r;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1614,8 +1616,10 @@ static int vcn_v4_0_stop(struct amdgpu_device *adev)
 		vcn_v4_0_enable_static_power_gating(adev, i);
 	}
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index d433d2703995..ba22913398ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1091,8 +1091,10 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev)
 	int i, j, k, r, vcn_inst;
 	uint32_t tmp;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
@@ -1365,8 +1367,10 @@ static int vcn_v4_0_3_stop(struct amdgpu_device *adev)
 		vcn_v4_0_3_enable_clock_gating(adev, i);
 	}
 Done:
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 133ebb3c14db..873672f64778 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1000,8 +1000,10 @@ static int vcn_v4_0_5_start(struct amdgpu_device *adev)
 	uint32_t tmp;
 	int i, j, k, r;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1277,8 +1279,10 @@ static int vcn_v4_0_5_stop(struct amdgpu_device *adev)
 		vcn_v4_0_5_enable_static_power_gating(adev, i);
 	}
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index c57894f1734a..893e66c2b9a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -761,8 +761,10 @@ static int vcn_v5_0_0_start(struct amdgpu_device *adev)
 	uint32_t tmp;
 	int i, j, k, r;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1008,8 +1010,10 @@ static int vcn_v5_0_0_stop(struct amdgpu_device *adev)
 		vcn_v5_0_0_enable_static_power_gating(adev, i);
 	}
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 8531e0993b17..5a9006bfc3cd 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -581,7 +581,7 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
 			  enable ? "enable" : "disable", ret);
 }
 
-void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable)
+void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable, int inst)
 {
 	int ret = 0;
 
@@ -599,12 +599,10 @@ void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable)
 		return;
 	}
 
-	for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCN, !enable, i);
-		if (ret)
-			DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
-				  enable ? "enable" : "disable", ret);
-	}
+	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCN, !enable, inst);
+	if (ret)
+		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
+			  enable ? "enable" : "disable", ret);
 }
 
 void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index e7c84d4a431a..251b389dcf6e 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -442,7 +442,7 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev);
 
 void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev);
 void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable);
-void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable);
+void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable, int inst);
 void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable);
 void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable);
 void amdgpu_dpm_enable_vpe(struct amdgpu_device *adev, bool enable);
-- 
2.34.1

