Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1204C282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 14:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76AD610E416;
	Mon, 17 Mar 2025 14:47:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PouNvy1t";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2BF410E415
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 14:47:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4+VRNyPDMtsZr4ttCdqyRQc7lmUwU3vhc6CXUZYftF10cI+asnOLfMITLC37KDPs0D3PkScHlDMV27X/O7Ux7jLqWJnsgSnoP8Si+FhHuHjK5dbAtqPSg38QSqJZAbkHKKWnbOwiQ0CqL0s+u9OIjOvVKsepJ/tRSbtbU2v9dPcncFmEjnZfrGG1N5bZj6H7+rg/VMUqBQMzg31fuhRLYiM7AhPH//YtC0mvIGPTjRYuIXxjXksgHgwlrAifk+P3a7mNjDwp+33Pb069s1jYbeFfHfKGNqUw3+/L2/+QiVFac8+4zD7GPwmwDInDlBfSuMYvhFXAcEiTFg8WE+zmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJc9hdTz5iWm17JV08E5akUz2PtEQCWdBeEv8h8cWU0=;
 b=K4wUHBG26rDtU+U7eXhs0MT6Qeqx2T8ljshGRArlg1jKN9V5xhghq+/sDSy7Hm+cToDDG4w991a+lF0R1gvrrxO1MMXrdm8rZOiHOl0aDHrkgF7Fy9Z4xkeS9w/oMvIYS383nCnT9bIaNJcf6B4hCwwP5aoejoN6uc+uWhiJPTbDA7ieZHnXEDb2ndMFewHeds2hNqqPz3M2L4kU6uJidJYEYen931iVQDRIWGRikn0kv8Dnjvxy6kXb9EI+xHaYNdgykKspb/ROO9FysfXjRW4gSbZ+Pede9RmTGQRuvoGbYMUf4KHx4Cr/xUrCGK8qBUwnBZ0XOZ4KJH7J6ISWcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJc9hdTz5iWm17JV08E5akUz2PtEQCWdBeEv8h8cWU0=;
 b=PouNvy1tcE/iXynihUThUNw+iXtc+F2D9ZO647FLs/58yIu1GdIp4fTv1Fde9e1US6Mi3VcmCYs6+kHwvBMH9yzjQgXaQHgRvah3f8viOd1dv0pEhvLIZ429pT6D89FnX+5K17unDzdZG6/EpaAr8pKgOMhNSSSsLC3Q7VCJXZI=
Received: from MW4P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::19)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Mon, 17 Mar
 2025 14:47:49 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:303:80:cafe::71) by MW4P223CA0014.outlook.office365.com
 (2603:10b6:303:80::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.32 via Frontend Transport; Mon,
 17 Mar 2025 14:47:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 14:47:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 09:47:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: adjust workload profile handling
Date: Mon, 17 Mar 2025 10:47:34 -0400
Message-ID: <20250317144734.810595-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|DM6PR12MB4057:EE_
X-MS-Office365-Filtering-Correlation-Id: e279a8b5-31a2-402a-f138-08dd6562b012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mUY2IIr2ADQ5w+ISx0nd83donxdTizUUJ0baskqKytqipp3zPGWo17rGqdZB?=
 =?us-ascii?Q?O19KrSgxCOs9RS4H9mLIwWAtft/yW7AEuPX+Vg68j8dbw904ja9bo7Dn41PJ?=
 =?us-ascii?Q?0dqc3K9aq0lyqZUxd4coyzi7BgtFExWF/vZug520dDnNL0Y+y9P+JIIQm1JY?=
 =?us-ascii?Q?gWBCT1VwMKlvjI8nnkgB6aJp2Ymvl6/aoSgmYUvaqgX0oQzi7FgyuzSbmhMp?=
 =?us-ascii?Q?H1jSVw7I2dHQkZuAJ2DwlCWN8ZdRXD5VxxxznUD2yLtDxg/dEdFr2OoJ2k+y?=
 =?us-ascii?Q?BnMZXJdZlpWkYtPuXBlvV9STMhbIu7uewUiK75aGU5zx6iGRc849X3+zZ3ja?=
 =?us-ascii?Q?5cQx19cZBgvd12kxMwvSDBkNpgmsG5J1ijuXHpk5IeGVIoNN6VHqv7vYHtq8?=
 =?us-ascii?Q?Ocpg6riZpzmlKSD3fLC1K76CFk9IpGFLPlUuh4g90qPrOn2AacLkf3gtxdyl?=
 =?us-ascii?Q?JYNhOf+gbEPi9qNH/T+vxmGs7HbrCbiVP+LS9Vd6L86DOjHbpxn1fr7BZS0j?=
 =?us-ascii?Q?s85tL/KYHlBadoyC0VcJ1m8LyONRcN1vvCAHwQZKsXTU9CmZ3HbaKkKtuXtw?=
 =?us-ascii?Q?Gl+alvv72iyim6PNAjC8+7k3p/lBmlN+mkbg1w0LvYHyj+pCV1zMO2bEDnb7?=
 =?us-ascii?Q?3Zuq5dljMLI/6lMgIPBD/cVEHZ5dUDYlI10OUoScFYe2ZzWTdwmcsKUfaPvr?=
 =?us-ascii?Q?z3oxn7ngcsIekO3o3xU437eNoAVEZXDjq4FRfCZ1yJGd7aSViKkVzIRW5uMl?=
 =?us-ascii?Q?pyMFbd1LHjxhXnuHfmy8HrEEDfpp6RqpHGhjKRosE27rdTVVMgcmcF85Cv/n?=
 =?us-ascii?Q?+8K+IP4skYn9eIqXWi6ilUztYFfIvnBjPEHq9MpOGNmE56KjCa9ksGEY0Jsy?=
 =?us-ascii?Q?Xa2UtNY0nKEk1srVAFEl3de7VbnwZ8Mx0C8czYFW9QE+vLD5LoxIyqGLRJpy?=
 =?us-ascii?Q?JxmLQI3DFk52N3Yfj7Ql+LaXdCAMv8zQgIZCEgKT7p7sHGc0Ha7BFyDeddU0?=
 =?us-ascii?Q?3GCtniynq+S4Dy46Ntuf0Yn4vKKnGtqfGp0vDtKhRo1UXkIAF1niiFPk5M9d?=
 =?us-ascii?Q?08E5iuKZUkqJbSdeM/LZBVpoOD/yHPPWWnoEp/BaPVhWfMTAHLZ3cPQlL9IX?=
 =?us-ascii?Q?j0UPviWkSQA1Bc1U5VYjOGJfm1XDX437jQK5xx+vEXNg8uGY+1bMYzheBLX7?=
 =?us-ascii?Q?N6RE8InFoOVXKaWaX8pblZMkVOGtu1auqMWyz40GPbckLu67hz3NKlMwlBNo?=
 =?us-ascii?Q?WrWNS8vpGPC0m1JttElqc5iTPOeao+hj1BnzKYybmoQf9SKaNf/00x5XWoO9?=
 =?us-ascii?Q?PVzSMngizcy3nd1DUt1pXIrsr5Tqw/7CbZlCJsfJP4Q/eR4wJHNyLxSs6msw?=
 =?us-ascii?Q?PnlRCFdQUeWH3r/oXTyjQO99TgxuDktEK+BaNhS5BLwrZS9QR5jBRTw1844Y?=
 =?us-ascii?Q?gu8D2bNTACo1fox3Bxae+O6AbqX9twL3yPzOai9v8hqE6ccE/B0nbw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 14:47:49.0304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e279a8b5-31a2-402a-f138-08dd6562b012
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
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

No need to make the workload profile setup dependent
on the results of cancelling the delayed work thread.
We have all of the necessary checking in place for the
workload profile reference counting, so separate the
two.  As it is now, we can theoretically end up with
the call from begin_use happening while the worker
thread is executing which would result in the profile
not getting set for that submission.  It should not
affect the reference counting.

v2: bail early if the the profile is already active (Lijo)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 28 ++++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 28 ++++++++++++++++---------
 2 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 6b410e601bb65..1991dd3d1056a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -460,18 +460,26 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 	atomic_inc(&vcn_inst->total_submission_cnt);
 
-	if (!cancel_delayed_work_sync(&vcn_inst->idle_work)) {
-		mutex_lock(&adev->vcn.workload_profile_mutex);
-		if (!adev->vcn.workload_profile_active) {
-			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
-							    true);
-			if (r)
-				dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
-			adev->vcn.workload_profile_active = true;
-		}
-		mutex_unlock(&adev->vcn.workload_profile_mutex);
+	cancel_delayed_work_sync(&vcn_inst->idle_work);
+
+	/* We can safely return early here because we've cancelled the
+	 * the delayed work so there is no one else to set it to false
+	 * and we don't care if someone else sets it to true.
+	 */
+	if (adev->vcn.workload_profile_active)
+		goto pg_lock;
+
+	mutex_lock(&adev->vcn.workload_profile_mutex);
+	if (!adev->vcn.workload_profile_active) {
+		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
+						    true);
+		if (r)
+			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
+		adev->vcn.workload_profile_active = true;
 	}
+	mutex_unlock(&adev->vcn.workload_profile_mutex);
 
+pg_lock:
 	mutex_lock(&vcn_inst->vcn_pg_lock);
 	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index b4b8091980ad5..d716510b8dd68 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -169,18 +169,26 @@ static void vcn_v2_5_ring_begin_use(struct amdgpu_ring *ring)
 
 	atomic_inc(&adev->vcn.inst[0].total_submission_cnt);
 
-	if (!cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work)) {
-		mutex_lock(&adev->vcn.workload_profile_mutex);
-		if (!adev->vcn.workload_profile_active) {
-			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
-							    true);
-			if (r)
-				dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
-			adev->vcn.workload_profile_active = true;
-		}
-		mutex_unlock(&adev->vcn.workload_profile_mutex);
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
+
+	/* We can safely return early here because we've cancelled the
+	 * the delayed work so there is no one else to set it to false
+	 * and we don't care if someone else sets it to true.
+	 */
+	if (adev->vcn.workload_profile_active)
+		goto pg_lock;
+
+	mutex_lock(&adev->vcn.workload_profile_mutex);
+	if (!adev->vcn.workload_profile_active) {
+		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
+						    true);
+		if (r)
+			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
+		adev->vcn.workload_profile_active = true;
 	}
+	mutex_unlock(&adev->vcn.workload_profile_mutex);
 
+pg_lock:
 	mutex_lock(&adev->vcn.inst[0].vcn_pg_lock);
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 					       AMD_PG_STATE_UNGATE);
-- 
2.48.1

