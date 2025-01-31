Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAE8C0219B
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C160A10E3B7;
	Fri, 31 Jan 2025 16:58:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mQoP+i0l";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D89B10E3C2
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ta1nMpkbsL0RX1SqocUSv+6K0TK4iudu1XkIkzSpz9J+zjcwPYpyg6dHZOwMFZ0XLx/L2CkJFe2H1JR0AyrUOR35qzwPLgyUECCzkJOJz/ygkV4293cxC+Jyl/WvE/l9w09hrCd+BupMwC0b64qbKfwahEzhFJELqeJHQOLESll/7f72LTON9VuyB9cpeGsKTDLHRbB9rTL/E31nCC3O2UINm0st8ZFj7qraiIXTPRY8FtUM1XDWY/6Fmm16UTqIN6kcPrxJo3w3d8dX2fxA5QnKR1KG+eGjUptvdP3Dtgsn8PEffwCou5xyCA6SnqyCi0hsMBE+cvq6iCdvPh+qKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAcHrQvbBhkAP9TRZrr6+xQ6EVUOjkejKNHnlHr3GHA=;
 b=MRdE0uBiFWcSFoTa6KdhXKzFzr/CvUhKmZmxYXIT12GPBKfSMxHOG/HiDgkpBMA0Z/ENSQ2g2WSjWzmED8LLtozkMhZrHEykmqjgjUwaK+WqmLb3vYJTOo9BeCWFzkhNsdNRj6e+7wC8OaRce+W+dYlu0i15MgkZdO3g4x+ZDp/o5xLmgJXq8rnNQEQL6m+BdDWIRIKsP3u0JXw4ogr/6b9DUi8RwGpj8sSFKjmXNdS+vdAMf+GvwaUYINBmd6hTMHN+Z6bLg0nVGuGpUoJOgftjVwaP9zNizGF3TRlT4hV0zqNfkLkgmcMAlHyDV6OaxhVRXk9jxVMHIs/ozLxNhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAcHrQvbBhkAP9TRZrr6+xQ6EVUOjkejKNHnlHr3GHA=;
 b=mQoP+i0lVoqsYgektbU0K0CoKt3cDQJsqg5STEUYxtFEOvH8fZKjL/E/FXbToRD89+au4XfVs1M43vfEwAwiQ7EYcXzTUdOqk8robezWVMmzVZeYpXkknP2ttnJ7wAXLWgSQgj58BJXHP4D4//gAgCFmTCcB9NYjr9ZJ0XYwPfM=
Received: from DM6PR07CA0081.namprd07.prod.outlook.com (2603:10b6:5:337::14)
 by DM4PR12MB7624.namprd12.prod.outlook.com (2603:10b6:8:107::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Fri, 31 Jan
 2025 16:58:19 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:337:cafe::f7) by DM6PR07CA0081.outlook.office365.com
 (2603:10b6:5:337::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:16 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 28/44] drm/amdgpu/vcn4.0.3: add set_pg_state callback
Date: Fri, 31 Jan 2025 11:57:24 -0500
Message-ID: <20250131165741.1798488-29-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|DM4PR12MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: 52defd6d-d1d1-4b01-ca7c-08dd4218765e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aM5KrigXTRciGnVepZFUD87kd/IyIlzmD7443uecnfUA+YDFgo2nnBFSi/P4?=
 =?us-ascii?Q?NwVk/vCVSJJuHgNGy1Qzo/Q5eTxypNXQlf9Ol7WYsmW+xLrgJyBCsbzwq2c7?=
 =?us-ascii?Q?jG+jXPXyQlQlSwJdooc91Fhd5P0K/fD4Z7GdnWtcINOI2MtrnPW8qVCfOlYh?=
 =?us-ascii?Q?+AOte6ioTj5nRoCiHTQ34xSyjiVPzWU+SW69c0MExfSNx0UBYHLTZtpYSYcT?=
 =?us-ascii?Q?heOwFyUkOQKDt0vPKKtqLfEO9R9ACJ6BQ/lOFACbY1Mv6F39JXMB54B+wkgU?=
 =?us-ascii?Q?K6yHaNm0ORzeA8AX/17ttijY+Jkej92EJDNjAKCgkV1JxRv9cp2TqLzEz3Cu?=
 =?us-ascii?Q?ScNcQCpgcUJKZ4adLOqiy01or1vbKQk4RZ7cU0MT8nyWgnbf0ahYbesixWWj?=
 =?us-ascii?Q?xyhhWiCFPivbFI/1q/ZvwB1oI0cIHF68sw0Uel+eaCaqBMOpwt3xmRObP4G6?=
 =?us-ascii?Q?J6yUysgoawkvswDrI8T/p3DMx2iaNtHLUH2G6HB5V9yx1qZWF23KGYh8HaEY?=
 =?us-ascii?Q?LC5b8JUlgcn/P3L32NH7mCSQVdTscGg3A8Xm4tsZhsV1IkTdzfDW2QnHvc3f?=
 =?us-ascii?Q?u0I7FYNq8Q8qaQZMG0J9QgR9WdyJZhZJuRVxpmFHhlhUMRpbFPwfB9Lha7Pm?=
 =?us-ascii?Q?MX478z63K7YwBL68RGkkAQTH6FnCK+IRF4dPIcngXM613ZXjC/IxSQcUFNt2?=
 =?us-ascii?Q?iSAb624MymWed3pWniE5LJNL1JIEQA8NflHwjQEQ3+qRiF3Lebb3EkfGFexq?=
 =?us-ascii?Q?KzD/2pQTFT3l4Xe1vMTDr7ribmmlA9tkkkrdbdPcuVsDrh+B88vdv48cRDE9?=
 =?us-ascii?Q?hJQPXQzAhJI3XoOYSCaYYRr6/Oyk47oAFajuz2jIcolWwfA790fGvtPAT2JW?=
 =?us-ascii?Q?h5Bnrk6axe15gss/oaUnSdYnJDAvUEMzUa8kJdKcjJZ1Aodc4uE2Ig6I4v1o?=
 =?us-ascii?Q?oIIAiug3U8iL70pEMQU9sFYftyDmnT8aKkqWto2JVSinA4rlxWRkU0cvkc8x?=
 =?us-ascii?Q?8aPHFHXNa29cWEHe79vEdNknSXVWbvxg+A0mUPUyyixu7D9bJtx4MYi449Rn?=
 =?us-ascii?Q?ozO4F0KFWcL/alsLEiydwCebatb4/KdrGakCKO7/FGnT7yXUPLaOPeIA4IDE?=
 =?us-ascii?Q?oEVL8Xkhmr6MVxQ8eOy9ZKh2BOsYPj5q6YX6DxohsFfYL4dDRVotYEwwz7RU?=
 =?us-ascii?Q?aNS4MH40fawaWeeMGnQomOtFt9Vv+kJ/3sTivMnZB2zC7lSt2vO1vwXVGfqP?=
 =?us-ascii?Q?Shg4nkZ8gT+ynRYH4LTGe+m6XRxucUxdLO8U8wol47xaqOKvSvbUrXc9e8i2?=
 =?us-ascii?Q?5XH5p+YbXtsQJqAaDAjuoQH0OOx9QzqqkeY5gGjB8eEI2ZCWP8lH9i/N4iuA?=
 =?us-ascii?Q?u7B8kZ/u1hljVtjWVjXtgqd/yF+YCuCFQ0zRJYVjck+ype78RwctPn3MmAcw?=
 =?us-ascii?Q?41wKBS9mZK4tsFWdbcmEHdPxfQ63qgBv7ud12TXAhgVdCzZkbZHDhQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:18.7957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52defd6d-d1d1-4b01-ca7c-08dd4218765e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7624
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

Rework the code as a vcn instance callback.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 36 ++++++++++++++-----------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index ae7733c0d032e..219e95c1e35ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -87,9 +87,8 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] = {
 static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
 static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
-						 enum amd_powergating_state state,
-						 int i);
+static int vcn_v4_0_3_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				   enum amd_powergating_state state);
 static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_powergating_state state);
 static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
@@ -125,6 +124,8 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v4_0_3_set_ras_funcs(adev);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		adev->vcn.inst[i].set_pg_state = vcn_v4_0_3_set_pg_state;
+
 		r = amdgpu_vcn_early_init(adev, i);
 		if (r)
 			return r;
@@ -371,10 +372,12 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 	int i;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
+		cancel_delayed_work_sync(&vinst->idle_work);
 
-		if (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE)
-			vcn_v4_0_3_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
+		if (vinst->cur_state != AMD_PG_STATE_GATE)
+			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 	}
 
 	return 0;
@@ -1687,12 +1690,10 @@ static int vcn_v4_0_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
-						 enum amd_powergating_state state,
-						 int i)
+static int vcn_v4_0_3_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				   enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = ip_block->adev;
-	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+	struct amdgpu_device *adev = vinst->adev;
 	int ret = 0;
 
 	/* for SRIOV, guest should not control VCN Power-gating
@@ -1700,11 +1701,11 @@ static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
 	 * guest should avoid touching CGC and PG
 	 */
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.inst[i].cur_state = AMD_PG_STATE_UNGATE;
+		vinst->cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.inst[i].cur_state)
+	if (state == vinst->cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1713,7 +1714,7 @@ static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
 		ret = vcn_v4_0_3_start(vinst);
 
 	if (!ret)
-		adev->vcn.inst[i].cur_state = state;
+		vinst->cur_state = state;
 
 	return ret;
 }
@@ -1732,8 +1733,11 @@ static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0, i;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
-		vcn_v4_0_3_set_powergating_state_inst(ip_block, state, i);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
+		ret |= vinst->set_pg_state(vinst, state);
+	}
 
 	return ret;
 }
-- 
2.48.1

