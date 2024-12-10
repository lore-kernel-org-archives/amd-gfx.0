Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A683CE77184
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51AC910E9E0;
	Tue, 10 Dec 2024 22:54:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uAQses8s";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D83610E9DB
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMmlQGFuRaPcrQD1kQ7ATU5yFSwu8cKHxHRiqumJs5mkLlGtxlXohNVhZYVdqbAQhgUbYQk3n+b2b3eOfBnQlK2ED9fs2iTyKkGzOpbwVBQAOZ8W3IqZb3CuJNpnZTkCQbvvp95FOMgoac+12uhlyTXRzk2rTClx+BV5BEzmDyoG5aKiQKH8kSWvzpwRxedjhIfAW8rH4RqqsIOPEWIkpWxt+hvNQUhxS6R7m+15PK8siK3TSTd8xUCV5YywkVGwsxABn8hAHB8QtAM2JYAuOk/6s283MI6C9gWNStqw3MNjljI4V+xbHm7/3ZAIqWOS7wihVbTS6szE2TjSR/xyVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjNCR0gxZpeUUvN4fxD6PYFrfNIBDzIkaQZFqjKE2tA=;
 b=FibzEHm2wdgqazeNFdjrnnjA+ygvl68RSYfzLbNgUbaBCpMXiRpb13udxJC0FD+1TUZb2DqHe+IlduIUWevuDMXV31/AtPIlmb9Iop30uSlFMFqVCe8db6mGUUc6TgtPq8LiNKm1Cb1/P8Aykw+Pcot0NFPVyL3h/M4Rrj2LGvOJ2aWptRAUtm//dhhGwjLaQV6srtJtYaOcF6uZlaQ7oFlVckztUP4RWninxoHkmjtBV4/Dwhcj9n+Stj0Lx/chi/B88AUNs8yIt2p+R0VJdyBKfydRnT86WNupF375pzzVSmO5oYR5od1hRHJAQmc2EH7iRuFLig78OMdq3a5mkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjNCR0gxZpeUUvN4fxD6PYFrfNIBDzIkaQZFqjKE2tA=;
 b=uAQses8sLd3aP6nXsGa6kSqJoIWwcW66KxrQwkTZ0ZNSpANnKMOsItoqLkHvyakR5vIU6CXGMlDYcvO+VNjdL99d67seX2Fi1bZD25+2ZrBJsgdqn36YyF+quDhAdWxQPZsqZQ9jPtqZZbsNZDdoACWMSguRuBwt/+ot7KFq32w=
Received: from BN9PR03CA0228.namprd03.prod.outlook.com (2603:10b6:408:f8::23)
 by SJ1PR12MB6243.namprd12.prod.outlook.com (2603:10b6:a03:456::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 22:54:00 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::79) by BN9PR03CA0228.outlook.office365.com
 (2603:10b6:408:f8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.11 via Frontend Transport; Tue,
 10 Dec 2024 22:53:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:53:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:53:57 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/48] drm/amdgpu/vcn: make powergating status per instance
Date: Tue, 10 Dec 2024 17:52:58 -0500
Message-ID: <20241210225337.75394-10-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|SJ1PR12MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: 7991e7b1-c461-4b5b-b81e-08dd196d88d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?84YODCrmKqST8PSPVYaa4ZLiEOu5+PJr7+ps33oeJACUIacmTrawCgCgJdvi?=
 =?us-ascii?Q?eIyG8GpSB6eqUQlnRQ50mOq9UmUd4kbeVmgVRh9CJmdZizYbPgS/30MHstPi?=
 =?us-ascii?Q?YB28qHAT6qo1hIjk5FwBPXs+VE5zyZBJ5rOeRF/nqU3LTmqnePZyvZiNghRn?=
 =?us-ascii?Q?++0nd/lqenuE0PPi6Ys04DbTDEbRqOOuhOMN9V+u7gNCIDFtfE6Xzt4HprOJ?=
 =?us-ascii?Q?l6oGOUfL3/ydEaCGEgD5Jne0itmeotiek1ygKxSDuc6vF93jgIdmAwtmaJvM?=
 =?us-ascii?Q?u5dZtdtrzg7Lz7xyAuZ+L+sTl0uIrCk+gZSXWgS8y2IJOiUHmSwNqiGkW2R8?=
 =?us-ascii?Q?60UkQ8N8FVbnzLXnSvNaQkE420fC0NxpOk+y7Ukl5CJqdzWivfu3isG2Z0eI?=
 =?us-ascii?Q?ABJCfCfUrPqs2dMOOEESlzGziqiYYGrGKY4WB2L+b9SGxK+KDjdw7Hb4aF1k?=
 =?us-ascii?Q?Zr/oVoQGV35fnMvQS2LPWWP9pXSSw+ktRpP7XhR+9VbqW+UgXGKMHWI1/A6d?=
 =?us-ascii?Q?Hw7z2ahHhkJl8VsV/8CaWrBQoxPyk//l99/7R8rp5a1BNYc3p35BiyPIQ+VS?=
 =?us-ascii?Q?KZ7B+1HPPKfTSlJCyVBRqyVztiGn0a4fZTpJNWDplJHHcdm3Z78RJKVh0r81?=
 =?us-ascii?Q?dkVYEd1vXQMpqSoD58uvuCau6JDErMg4jGGcU9Oms2w2ibW5kqcu/gwaTGdS?=
 =?us-ascii?Q?25c+qTYsmv4F7ar8Lj1Led7thCkbTjQKOSAvT4gJtJQa0mqNginzuy3Kxlg8?=
 =?us-ascii?Q?6VOtX/zmSnOjwpg9UD8qfewdc5nFnBdo2wrmITBeJOQO3aVKVn0ly1BiV9Ep?=
 =?us-ascii?Q?YxTsvpwScJRNMi5TbD2GeAET8H5q8BAUQodJ+MZ6n18Tpc8uVZvSPQ/QFTlf?=
 =?us-ascii?Q?/IiVXrc6qttPuAfEIIiCE5gZYacqWA/RrTIf5DWgARm1ya2qDh3HoVEhOxSv?=
 =?us-ascii?Q?p5B0XxFnRm2JDUE6krUm5JxDcqVlY27POEdHUWZhiD6pqPCBKdtNq7fRCIuD?=
 =?us-ascii?Q?NXF3K8tMl7tvv30cGDyk0lMM1kRP+ocAep6fxfmrW+uAeJ/L4XqguOejPous?=
 =?us-ascii?Q?QnlnfW6yvM6ZtCE0r0MjkEfa9+IXNeANUk2Ddf3G4IGJh1PCyH+bC63AOsXR?=
 =?us-ascii?Q?5b/OKcPnNnebBEw4nMoM0e5DfmhOzuG4HcYeHyy4ftSoQjAQa6oEp4Od057Y?=
 =?us-ascii?Q?wgzO0B40ehityf4kpXx14XWbcaXeWl/lUzXQ8ZwU+a7Nn1uY/eY+cWWvgbCG?=
 =?us-ascii?Q?VxCB1FYGnQKcFHMBorrQN2u8ROKtt/fFJkNUpUtCAv1jzW1bVI9fBrO4OapT?=
 =?us-ascii?Q?0izzN+Au/aIahkwI8QCux1bc5TOABsO6Z1Y8/FhRQ7LIDXt8Bpqvgjjwn1zD?=
 =?us-ascii?Q?GCfQwjByIvZixkmYdIsinudsT2c1hxl5kRtg1qeLgDlq9jhyqQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:53:59.3403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7991e7b1-c461-4b5b-b81e-08dd196d88d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6243
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

Store it per instance so we can track it per instance.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c     |  6 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     | 11 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     | 43 +++++++++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     | 49 ++++++++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c     | 60 ++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c   | 63 ++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c   | 48 +++++++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c   | 48 +++++++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c   | 40 +++++++++-----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  8 +--
 11 files changed, 241 insertions(+), 137 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index d020e9044c595..b83136451d674 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -314,6 +314,7 @@ struct amdgpu_vcn_inst {
 	uint32_t		vcn_codec_disable_mask;
 	atomic_t		total_submission_cnt;
 	struct mutex		vcn_pg_lock;
+	enum amd_powergating_state cur_state;
 	struct delayed_work	idle_work;
 };
 
@@ -324,7 +325,6 @@ struct amdgpu_vcn_ras {
 struct amdgpu_vcn {
 	unsigned		fw_version;
 	unsigned		num_enc_rings;
-	enum amd_powergating_state cur_state;
 	bool			indirect_sram;
 
 	uint8_t	num_vcn_inst;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 9ca964e115409..406886f13566a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -280,7 +280,7 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-		(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
+		(adev->vcn.inst->cur_state != AMD_PG_STATE_GATE &&
 		 RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
 		vcn_v1_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 	}
@@ -1813,7 +1813,7 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	int ret;
 	struct amdgpu_device *adev = ip_block->adev;
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst->cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1822,7 +1822,7 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v1_0_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst->cur_state = state;
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 115f33c3ab68b..f445ae4013598 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -316,8 +316,8 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-	    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-	      RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
+	    (adev->vcn.inst->cur_state != AMD_PG_STATE_GATE &&
+	     RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
 		vcn_v2_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 
 	return 0;
@@ -1810,11 +1810,11 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		adev->vcn.inst->cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst->cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1823,7 +1823,8 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v2_0_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst->cur_state = state;
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 6fb08ed093101..1d3780a2d8513 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -95,8 +95,11 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_2_5[] = {
 static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+					       enum amd_powergating_state state,
+					       int i);
 static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
-				enum amd_powergating_state state);
+					  enum amd_powergating_state state);
 static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 				int inst_idx, struct dpg_pause_state *new_state);
 static int vcn_v2_5_sriov_start(struct amdgpu_device *adev);
@@ -397,9 +400,9 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
 		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
 
 		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-		    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
+		    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
 		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
-			vcn_v2_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+			vcn_v2_5_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
 
 		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
 			amdgpu_irq_put(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
@@ -1805,27 +1808,39 @@ static int vcn_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
+static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+					       enum amd_powergating_state state,
+					       int i)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int ret = 0, i;
+	int ret;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[i].cur_state)
 		return 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (state == AMD_PG_STATE_GATE)
-			ret |= vcn_v2_5_stop(adev, i);
-		else
-			ret |= vcn_v2_5_start(adev, i);
-	}
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v2_5_stop(adev, i);
+	else
+		ret = vcn_v2_5_start(adev, i);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst[i].cur_state = state;
+
+	return ret;
+}
+
+static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 0, i;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		ret |= vcn_v2_5_set_powergating_state_inst(ip_block,
+							   state, i);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 70a1b85a4efae..13b9ed96cccda 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -105,8 +105,11 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev);
 static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+					       enum amd_powergating_state state,
+					       int i);
 static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-			enum amd_powergating_state state);
+					  enum amd_powergating_state state);
 static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 			int inst_idx, struct dpg_pause_state *new_state);
 
@@ -430,9 +433,11 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-				 RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
-				vcn_v3_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+			    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
+			     RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
+				vcn_v3_0_set_powergating_state_inst(ip_block,
+								    AMD_PG_STATE_GATE,
+								    i);
 			}
 		}
 	}
@@ -2147,33 +2152,45 @@ static int vcn_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
+static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+					       enum amd_powergating_state state,
+					       int i)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int ret = 0, i;
+	int ret = 0;
 
 	/* for SRIOV, guest should not control VCN Power-gating
 	 * MMSCH FW should control Power-gating and clock-gating
 	 * guest should avoid touching CGC and PG
 	 */
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		adev->vcn.inst[i].cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[i].cur_state)
 		return 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (state == AMD_PG_STATE_GATE)
-			ret |= vcn_v3_0_stop(adev, i);
-		else
-			ret |= vcn_v3_0_start(adev, i);
-	}
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v3_0_stop(adev, i);
+	else
+		ret = vcn_v3_0_start(adev, i);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst[i].cur_state = state;
+
+	return ret;
+}
+
+static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 0, i;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		ret |= vcn_v3_0_set_powergating_state_inst(ip_block,
+							   state, i);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 4a846c9a2b039..dbbeeffc90726 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -96,8 +96,11 @@ static int amdgpu_ih_clientid_vcns[] = {
 static int vcn_v4_0_start_sriov(struct amdgpu_device *adev);
 static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+					       enum amd_powergating_state state,
+					       int i);
 static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-        enum amd_powergating_state state);
+					  enum amd_powergating_state state);
 static int vcn_v4_0_pause_dpg_mode(struct amdgpu_device *adev,
         int inst_idx, struct dpg_pause_state *new_state);
 static void vcn_v4_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
@@ -367,9 +370,9 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
+				(adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
 				 RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-				vcn_v4_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+				vcn_v4_0_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
 			}
 		}
 		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
@@ -2032,41 +2035,52 @@ static int vcn_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-/**
- * vcn_v4_0_set_powergating_state - set VCN block powergating state
- *
- * @ip_block: amdgpu_ip_block pointer
- * @state: power gating state
- *
- * Set VCN block powergating state
- */
-static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
+static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+					       enum amd_powergating_state state,
+					       int i)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int ret = 0, i;
+	int ret = 0;
 
 	/* for SRIOV, guest should not control VCN Power-gating
 	 * MMSCH FW should control Power-gating and clock-gating
 	 * guest should avoid touching CGC and PG
 	 */
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		adev->vcn.inst[i].cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[i].cur_state)
 		return 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (state == AMD_PG_STATE_GATE)
-			ret |= vcn_v4_0_stop(adev, i);
-		else
-			ret |= vcn_v4_0_start(adev, i);
-	}
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v4_0_stop(adev, i);
+	else
+		ret = vcn_v4_0_start(adev, i);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst[i].cur_state = state;
+
+	return ret;
+}
+
+/**
+ * vcn_v4_0_set_powergating_state - set VCN block powergating state
+ *
+ * @ip_block: amdgpu_ip_block pointer
+ * @state: power gating state
+ *
+ * Set VCN block powergating state
+ */
+static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 0, i;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		ret |= vcn_v4_0_set_powergating_state_inst(ip_block, state, i);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index fb454c4687db7..1a939fdcc8fea 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -87,8 +87,11 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] = {
 static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
 static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i);
 static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
-		enum amd_powergating_state state);
+					    enum amd_powergating_state state);
 static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_device *adev,
 		int inst_idx, struct dpg_pause_state *new_state);
 static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring);
@@ -347,11 +350,12 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
 
-	if (adev->vcn.cur_state != AMD_PG_STATE_GATE)
-		vcn_v4_0_3_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+		if (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE)
+			vcn_v4_0_3_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
+	}
 
 	return 0;
 }
@@ -1640,41 +1644,52 @@ static int vcn_v4_0_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-/**
- * vcn_v4_0_3_set_powergating_state - set VCN block powergating state
- *
- * @ip_block: amdgpu_ip_block pointer
- * @state: power gating state
- *
- * Set VCN block powergating state
- */
-static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
+static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int ret = 0, i;
+	int ret = 0;
 
 	/* for SRIOV, guest should not control VCN Power-gating
 	 * MMSCH FW should control Power-gating and clock-gating
 	 * guest should avoid touching CGC and PG
 	 */
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		adev->vcn.inst[i].cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[i].cur_state)
 		return 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (state == AMD_PG_STATE_GATE)
-			ret |= vcn_v4_0_3_stop(adev, i);
-		else
-			ret |= vcn_v4_0_3_start(adev, i);
-	}
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v4_0_3_stop(adev, i);
+	else
+		ret = vcn_v4_0_3_start(adev, i);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst[i].cur_state = state;
+
+	return ret;
+}
+
+/**
+ * vcn_v4_0_3_set_powergating_state - set VCN block powergating state
+ *
+ * @ip_block: amdgpu_ip_block pointer
+ * @state: power gating state
+ *
+ * Set VCN block powergating state
+ */
+static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					    enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 0, i;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		vcn_v4_0_3_set_powergating_state_inst(ip_block, state, i);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index e784f1457ee0a..f6b347fcdb7ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -95,8 +95,11 @@ static int amdgpu_ih_clientid_vcns[] = {
 
 static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v4_0_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i);
 static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
-		enum amd_powergating_state state);
+					    enum amd_powergating_state state);
 static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_device *adev,
 		int inst_idx, struct dpg_pause_state *new_state);
 static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring);
@@ -308,9 +311,9 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-				vcn_v4_0_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+			    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
+			     RREG32_SOC15(VCN, i, regUVD_STATUS))) {
+				vcn_v4_0_5_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
 			}
 		}
 	}
@@ -1517,6 +1520,27 @@ static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
+static int vcn_v4_0_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 0;
+
+	if (state == adev->vcn.inst[i].cur_state)
+		return 0;
+
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v4_0_5_stop(adev, i);
+	else
+		ret = vcn_v4_0_5_start(adev, i);
+
+	if (!ret)
+		adev->vcn.inst[i].cur_state = state;
+
+	return ret;
+}
+
 /**
  * vcn_v4_0_5_set_powergating_state - set VCN block powergating state
  *
@@ -1526,23 +1550,13 @@ static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
  * Set VCN block powergating state
  */
 static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
-		enum amd_powergating_state state)
+					    enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0, i;
 
-	if (state == adev->vcn.cur_state)
-		return 0;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (state == AMD_PG_STATE_GATE)
-			ret |= vcn_v4_0_5_stop(adev, i);
-		else
-			ret |= vcn_v4_0_5_start(adev, i);
-	}
-
-	if (!ret)
-		adev->vcn.cur_state = state;
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		vcn_v4_0_5_set_powergating_state_inst(ip_block, state, i);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 03c7252e28ba9..c5d59edf3a482 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -78,8 +78,11 @@ static int amdgpu_ih_clientid_vcns[] = {
 
 static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v5_0_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i);
 static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-		enum amd_powergating_state state);
+					    enum amd_powergating_state state);
 static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_device *adev,
 		int inst_idx, struct dpg_pause_state *new_state);
 static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
@@ -288,9 +291,9 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-				vcn_v5_0_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+			    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
+			     RREG32_SOC15(VCN, i, regUVD_STATUS))) {
+				vcn_v5_0_0_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
 			}
 		}
 	}
@@ -1260,6 +1263,27 @@ static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
+static int vcn_v5_0_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 0;
+
+	if (state == adev->vcn.inst[i].cur_state)
+		return 0;
+
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v5_0_0_stop(adev, i);
+	else
+		ret = vcn_v5_0_0_start(adev, i);
+
+	if (!ret)
+		adev->vcn.inst[i].cur_state = state;
+
+	return ret;
+}
+
 /**
  * vcn_v5_0_0_set_powergating_state - set VCN block powergating state
  *
@@ -1269,23 +1293,13 @@ static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
  * Set VCN block powergating state
  */
 static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-		enum amd_powergating_state state)
+					    enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0, i;
 
-	if (state == adev->vcn.cur_state)
-		return 0;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (state == AMD_PG_STATE_GATE)
-			ret |= vcn_v5_0_0_stop(adev, i);
-		else
-			ret |= vcn_v5_0_0_start(adev, i);
-	}
-
-	if (!ret)
-		adev->vcn.cur_state = state;
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		vcn_v5_0_0_set_powergating_state_inst(ip_block, state, i);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 582e1383fe634..259f2fdef8aaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -40,8 +40,11 @@
 
 static void vcn_v5_0_1_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v5_0_1_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v5_0_1_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i);
 static int vcn_v5_0_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
-		enum amd_powergating_state state);
+					    enum amd_powergating_state state);
 static void vcn_v5_0_1_unified_ring_set_wptr(struct amdgpu_ring *ring);
 
 /**
@@ -998,6 +1001,27 @@ static int vcn_v5_0_1_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
+static int vcn_v5_0_1_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 0;
+
+	if (state == adev->vcn.inst[i].cur_state)
+		return 0;
+
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v5_0_1_stop(adev, i);
+	else
+		ret = vcn_v5_0_1_start(adev, i);
+
+	if (!ret)
+		adev->vcn.inst[i].cur_state = state;
+
+	return ret;
+}
+
 /**
  * vcn_v5_0_1_set_powergating_state - set VCN block powergating state
  *
@@ -1012,18 +1036,8 @@ static int vcn_v5_0_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0, i;
 
-	if (state == adev->vcn.cur_state)
-		return 0;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (state == AMD_PG_STATE_GATE)
-			ret = vcn_v5_0_1_stop(adev, i);
-		else
-			ret = vcn_v5_0_1_start(adev, i);
-	}
-
-	if (!ret)
-		adev->vcn.cur_state = state;
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		vcn_v5_0_1_set_powergating_state_inst(ip_block, state, i);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8ca793c222ff2..e5dd0bb31c386 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2051,15 +2051,15 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
 		return 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 		smu_dpm_set_vcn_enable(smu, false, i);
+		adev->vcn.inst[i].cur_state = AMD_PG_STATE_GATE;
+	}
 	smu_dpm_set_jpeg_enable(smu, false);
+	adev->jpeg.cur_state = AMD_PG_STATE_GATE;
 	smu_dpm_set_vpe_enable(smu, false);
 	smu_dpm_set_umsch_mm_enable(smu, false);
 
-	adev->vcn.cur_state = AMD_PG_STATE_GATE;
-	adev->jpeg.cur_state = AMD_PG_STATE_GATE;
-
 	if (!smu->pm_enabled)
 		return 0;
 
-- 
2.47.1

