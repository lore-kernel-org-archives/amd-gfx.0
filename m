Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7170C021B8
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 14:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 448AC10E5EF;
	Tue,  4 Mar 2025 14:21:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5cgTViCu";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14F7B10E5EF
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 14:21:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hs0SVxSWYCebfYa8xMIqQm5gMj5LqVGEY7nEvL8kWbEaj1MLA5HI01gKAfvCnxXuLHaRUUj0BSRMHbw8lw/+P/RDD2hwFaVPl1YFaLt3R4Ts6jqkUUpgbx8Gp3wXk+MuJhQ9pEW5vajEHHZ+iIgNOAAXqCdVdnzsiAvjvV8wWWs99vanEjmr4GyszJWIn4lDfdvW5kaQWh8TEyYyNeP7YU+jwzqx4A4Ty+uMU7wpVEbkoQAhIs7kcbjbCUq2ZHC1WUOotY6/X+uKj4z5Y/cacenujOYoAm3QPaFbatL3SBrYP32PNdv2u04Il9HrrzlPxQkNJWr2eqQif3I3+LbXMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rstsgi+qC7xntrIFbKfkUb3rj3KS1WnU/PJMmd6jDq4=;
 b=tPL8kA5yZtSCQ85Z1+2poYLyLNWLIvrlmnRfhieuVs0ROxrqCzLShmmvG4P1yAiGM+2IpWA7fb0BSTdzuIqN0GZVim5UgZKrRJJ2SGrSDxITpqinFATbTpyZ/lOUquisymInxhoi0CSpzQIimB+ZODALPt/n0eSsDY8JoDSLJXUK5wyhn3QiUzTwwxdPPt1Kg5eAPupPEuUwjjbmu0wEflumgSkeF2NbFzoeCpzNdAlT0XixeMe4VyjnDupLxuCiSy73aJvKMf/GXr6JbuRmFFVzQIZYhAh/N9WHjxfL7Lde+tmhhTfX1iaL/aPRPacKS/4NvgD/mD810wVUAV67QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rstsgi+qC7xntrIFbKfkUb3rj3KS1WnU/PJMmd6jDq4=;
 b=5cgTViCuJwaMfwRC+7A7K9vUQ68mDjSekwmseyJ1V3LVTjJor4JPBYnJHEOEwq+qjblY20V56321lv/joNVNfcTw/LUosVwIjw45yE628hCtWGonUE0W2G09QduywN7BFIPVB7UJxWEorusY3PHWg3MB6GsfU1KrSlejdCVP04U=
Received: from CH2PR03CA0015.namprd03.prod.outlook.com (2603:10b6:610:59::25)
 by CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 14:20:57 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::c3) by CH2PR03CA0015.outlook.office365.com
 (2603:10b6:610:59::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Tue,
 4 Mar 2025 14:20:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 14:20:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 08:20:55 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: fix idle work handler for VCN 2.5
Date: Tue, 4 Mar 2025 09:20:40 -0500
Message-ID: <20250304142040.3946594-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|CY5PR12MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f3e143-ff3a-4974-ef58-08dd5b27c7c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x82WNJX0BbWwQ5K+ftstTVe/A8ktv6Wh7ApMCF3qr3K0+xmUI2F7tCZf3YEa?=
 =?us-ascii?Q?JLRYdSiyKumhCZPGkLpB+9x2zgsMlsHHdD6tM78EhhrTvVl7WfdSmPrYlC2G?=
 =?us-ascii?Q?njuGDvFi0C/O9poPf1jVoW73CHoCSlVCXqGtQbvKy9v310nUMRjuDnNHhL8y?=
 =?us-ascii?Q?pgDEaejiihfL/WUHkg8EwMG1qOiCGm+wNKmjWnSvtdXYjc7q1k6GC5BvDNCP?=
 =?us-ascii?Q?UZqa/WT67hTkxQpocV3dcYpD+78DHcO0H1SovQHIjejzsbhCiNMwYP5pOayn?=
 =?us-ascii?Q?fpyk2hILhID7D/H4JyaRodAbuSKX7/oP6ZE9msbragbu2vRzdnvrACCWoLfY?=
 =?us-ascii?Q?CBi2k3U8qTNexj85x4o9lKU0idKLqoUKg8TAZ+fpOpzZcYibPTKLQp8zawuo?=
 =?us-ascii?Q?sc9XBrDDRst29yXHacq/WpO33MMobyr9E5ZokPse16oB6ZfplRnTxY/iDchR?=
 =?us-ascii?Q?R2PJfEgIXBrkJB09UgIrHM3kmkt8+0rgBN2TzaVc98W/d3JyjsMpuBvpaWpj?=
 =?us-ascii?Q?RRTI53gbKZicyKfltByZmnPhCj9hEJI+B3wL9wiBGHCbANW1DXKMox+4hqYl?=
 =?us-ascii?Q?JGjMYMjHPK61CjXdedA96i60aXvWVVEpXrZqu83aYDoBj3c30i7xcVYlu3t4?=
 =?us-ascii?Q?qvgGyYzT0BtKD3C13PuY2K/WUHriCQyuV0up0Q6CoxEXOng0nqsRe6wCpdnz?=
 =?us-ascii?Q?ctSQ2RmVMXjROV3dWiouhkyGpHuAxSYmIdjaqChOQQRyXZJSTwA8IVWgvAbq?=
 =?us-ascii?Q?6bJjLVDHCNrIJTPKS8m/hCnMzWhaI5i6/JCpKEb3RALdHCeZ7CIlsaoqqwbv?=
 =?us-ascii?Q?kF7qg+QXndgmN+HNTzo30Un0649RvD3VAoC/IsqbZr5HwuOPL5LBjtE0m0Ld?=
 =?us-ascii?Q?sc6tCj7AH2z7Afe3qDAChgfhAHDBdLS00q8Iezds7IyFvnIIm5MVMNClQfzD?=
 =?us-ascii?Q?LPAytRhF+GzHilMgPki2zVskKAqQetYrGawwGXFiULSkry7hxkkiV6kyscQk?=
 =?us-ascii?Q?h4mo1pge+25awESUF38sJsRRvpdhsvQ0u/VNk2K0mQu9hCU53BooNYXI6rHm?=
 =?us-ascii?Q?IQAeXWHHSRCQhno6Zzd/OzMMBGT8aNqU1NxSArePpWrXyY8cWngZgBIvi6Ym?=
 =?us-ascii?Q?+KnfVwRXJV8H+ANwGjQZt7tA+AwbJB+5o00WjjamIzwreD62Fc8y4yJAkUm/?=
 =?us-ascii?Q?6CS3IiiwzyjhA+/ZiF4V3kNuHkuVqeenpzvCcsWIxH/0vz2HLTyiMn+4Y0u4?=
 =?us-ascii?Q?drrpA+Ix2OYHp1Bn8cEgPEZ5xB9cBEUpamYTX4mO/+82U/k8XuTYzokNBryK?=
 =?us-ascii?Q?cXQUPeJSjjJWX2sLKiycnBWbcX36E7St+s0L4q5olCkj7/UwteLFZSiETgdc?=
 =?us-ascii?Q?OXbvyhoueE3GU62fYfdtaXxjV2j+rtoYyJrBQZGtJlTxUyjo2reQfYuUh8YU?=
 =?us-ascii?Q?5UJoDSjBMXchZi/dx7JnjOqSDdJ6UOj1DmRh+jPdkQWaEZZyLSfEhA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 14:20:56.9212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f3e143-ff3a-4974-ef58-08dd5b27c7c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057
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

VCN 2.5 uses the PG callback to enable VCN DPM which is
a global state.  As such, we need to make sure all instances
are in the same state.  Use amdgpu_device_ip_set_powergating_state()
rather than the per instance set_pg_state() callback.

Fixes: 4ce4fe27205c ("drm/amdgpu/vcn: use per instance callbacks for idle work handler")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 8d8b39e6d197a..b93102e9fb43e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -437,7 +437,14 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	fences += fence[i];
 
 	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
-		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
+		/* VCN 2.5 PG is actually DPM enablement which is global so
+		 * update all instances
+		 */
+		if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(2, 5, 0))
+			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
+							       AMD_PG_STATE_GATE);
+		else
+			vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 						    false);
 		if (r)
@@ -463,7 +470,14 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	}
 
 	mutex_lock(&vcn_inst->vcn_pg_lock);
-	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
+	/* VCN 2.5 PG is actually DPM enablement which is global so
+	 * update all instances
+	 */
+	if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(2, 5, 0))
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
+						       AMD_PG_STATE_UNGATE);
+	else
+		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
 
 	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
-- 
2.48.1

