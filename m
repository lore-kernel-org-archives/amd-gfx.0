Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AAAC4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 04:50:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 483BC6127B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 04:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 483BC6127B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3EB989E50;
	Mon, 23 Aug 2021 04:50:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 411DD89E50
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 04:50:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+4cuOWYSIWiWYUf6IfhyXCmvLBht+mNHwu67wdzLcZOu+hpouRgRVjW/9QvdELJI4ZxpRqfDfZdcostYQV8jlSKO3zVCoIxIelcJx+gEfHA3T9oifLhHClEXjdmBLJsO0a4ZTV15bh+xouEWziPA1gsRF9rZZ1QGSZncyIP9w2Dl1pzlT8tEXFpISmcdArHECHsNZVc6p3Rj/4Fe3EvqQuXpF6YGjw8zKCjNh5H703UWrZ0uc2piMtEhl7HIkBWHbcgejpPz5V66TvSgNFl6AWA7Bqe4OfZR6uVHQXdcSOtcjUzu+ytK9cl+Elw4uKlRpHgvju5EryAJj0OriEMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYf+dztY7AntXfFtvqh8IqLGxSwe5BMLsQUIt8sKxp8=;
 b=lAuoyAog8qJ3wfOSigw12dsNuxndsYEPuhfuaS0zMZnjDDLcoctDQgtJ2LvnbWMkxTGBhotHk3p4oG2HLcJ6DTXWKIxgwzAHbkvHuPcRfrHJEv93m3lguVmPy/wWHEDQl0QtNlauIpd6kGKrvvORl7gaZdi9/pIaP+92n8OYdVDixmUYX6uDv+L7+7u67EBq7N9m3pXiAulUgbrx1IYCu+U6v93+S/3NSHGCfsgkyqAjslFc9fDAxOT7TSVNCCu0uG0s8rCb5dR0JJPStBQtwx0D1pbdRcagf+acMgTzAso499rDsJDOxMxAQ/g6BZkGQjPCd14Q+gLv8oeKVnD0Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYf+dztY7AntXfFtvqh8IqLGxSwe5BMLsQUIt8sKxp8=;
 b=TMpLUMwKgKeMIO2cby3crAvQX0TSi+yoSGiTsoftlI8QfZVQDDN+Lvmg3vNQLg0C7MySKHO90pmPAOyXUdKkxFh1DIa86hBhTn72toubnDi8CFaKn4XNlm6ubQ9zPC0kV7pSWfo7nM4kHRjoktjh9T/RIT1NED1aO+Cl5yb58Rk=
Received: from BN9PR03CA0979.namprd03.prod.outlook.com (2603:10b6:408:109::24)
 by BN8PR12MB4980.namprd12.prod.outlook.com (2603:10b6:408:a8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 04:18:04 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::27) by BN9PR03CA0979.outlook.office365.com
 (2603:10b6:408:109::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Mon, 23 Aug 2021 04:18:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 04:18:03 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Sun, 22 Aug
 2021 23:18:00 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Guchun.Chen@amd.com>, <Lijo.Lazar@amd.com>, 
 <James.Zhu@amd.com>, <Leo.Liu@amd.com>, Evan Quan <evan.quan@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: add missing cleanups for more ASICs on
 UVD/VCE suspend
Date: Mon, 23 Aug 2021 12:17:36 +0800
Message-ID: <20210823041737.48921-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210823041737.48921-1-evan.quan@amd.com>
References: <20210823041737.48921-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2b259ac-81ed-46fe-a4e9-08d965ed0034
X-MS-TrafficTypeDiagnostic: BN8PR12MB4980:
X-Microsoft-Antispam-PRVS: <BN8PR12MB4980264CAB9DA525E0348430E4C49@BN8PR12MB4980.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:76;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nkBxiOtA5cJp2ALcVqrixeCPlt0e00AyIMzWK/tTEqki7D2BCYiUmxFLSlnT1XmcznMTSdOIi/AevSAWNMLgyEl3ol9HdeSqkmnNfCDHuMVJfc0RW5VRnmXAT2N83FV/vxhhlP4HmAjaKEHqtdamry0AFboa5KimGTG5+Mstu5rrTK/LlJCDeEEs+Uxgj7QI71cf6C9r4owDuc7mWaRc8+1U1W1vEH0Chrhye/kp0SfORi6msgVNVsVvXmKto+xXX8XDkJ2q/piwCYcMmNcwbClOt0TTRcRLkaUK7CVKmH4zKjhpPzRtBocJhaWjtCKXXMj8QxbjL355ZAFJMuFmiN5F4DZGwq51PZfQQ2N1xSngtkNf3Q42iedfHqxb8vMx9c1VbIVY/WAqKp5h0ZPHHyLMYkkLfx/QHD9dOO1ZeR55bM0afgzKqQGyvOnZ5E/Xuze6SzASPHiuUc/nAu8dBP5Cxy7+lp+tA8joCAMhkwRKqMlQL6X/5xPWLDGltFbH3wca3iknQDNp0zYS9dH5e5JogGZRp9qcdR62a/8LYs2w48OJw3kN7QMBr8RusRVDl2AAyKlj5v3x3NPCrBIAmzb5bT04LbcIqzFl+i2fxIW0fM+D03HIfd83/iv4XgHaHTi13v6Lmy6mzs+6DN3gkYAr54klseqqgNxPOtVxRpwWqU1f/bjR6Nj7wbOhulKQtKQycr/+cMn5lh5duTMWDL27sK7DYWqL96j3Nt0zmnn0xniej8ypKugt8iASvwoR3Ny0pCYpiJ1FEVye/vChoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(46966006)(36840700001)(82310400003)(336012)(34020700004)(2616005)(426003)(5660300002)(70206006)(54906003)(70586007)(1076003)(478600001)(8676002)(2906002)(4326008)(36756003)(47076005)(82740400003)(8936002)(26005)(15650500001)(16526019)(6916009)(316002)(7696005)(36860700001)(6666004)(44832011)(356005)(81166007)(83380400001)(186003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 04:18:03.4310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b259ac-81ed-46fe-a4e9-08d965ed0034
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4980
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

This is a supplement for commit below:
"drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE on suspend".

Change-Id: I7ff5692fd0c3e880ec8e55a7329469a67e5a1363
Signed-off-by: Evan Quan <evan.quan@amd.com>
--
v1->v2:
  - correct the sequence for clock/power gating (Lijo Lazar)
---
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c | 25 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c | 23 +++++++++++++++++++++++
 6 files changed, 144 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index 3c725de9df95..64ab28d1163b 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -698,6 +698,30 @@ static int uvd_v3_1_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	/*
+	 * Proper cleanups before halting the HW engine:
+	 *   - cancel the delayed idle work
+	 *   - enable powergating
+	 *   - enable clockgating
+	 *   - disable dpm
+	 *
+	 * TODO: to align with the VCN implementation, move the
+	 * jobs for clockgating/powergating/dpm setting to
+	 * ->set_powergating_state().
+	 */
+	cancel_delayed_work_sync(&adev->uvd.idle_work);
+
+	if (adev->pm.dpm_enabled) {
+		amdgpu_dpm_enable_uvd(adev, false);
+	} else {
+		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
+		/* shutdown the UVD block */
+		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+						       AMD_CG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+						       AMD_PG_STATE_GATE);
+	}
+
 	if (RREG32(mmUVD_STATUS) != 0)
 		uvd_v3_1_stop(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index a70d2a0de316..4a3f80d3589a 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -212,6 +212,30 @@ static int uvd_v4_2_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	/*
+	 * Proper cleanups before halting the HW engine:
+	 *   - cancel the delayed idle work
+	 *   - enable powergating
+	 *   - enable clockgating
+	 *   - disable dpm
+	 *
+	 * TODO: to align with the VCN implementation, move the
+	 * jobs for clockgating/powergating/dpm setting to
+	 * ->set_powergating_state().
+	 */
+	cancel_delayed_work_sync(&adev->uvd.idle_work);
+
+	if (adev->pm.dpm_enabled) {
+		amdgpu_dpm_enable_uvd(adev, false);
+	} else {
+		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
+		/* shutdown the UVD block */
+		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+						       AMD_CG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+						       AMD_PG_STATE_GATE);
+	}
+
 	if (RREG32(mmUVD_STATUS) != 0)
 		uvd_v4_2_stop(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index f3b0a927101b..715a5687b2b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -210,6 +210,30 @@ static int uvd_v5_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	/*
+	 * Proper cleanups before halting the HW engine:
+	 *   - cancel the delayed idle work
+	 *   - enable powergating
+	 *   - enable clockgating
+	 *   - disable dpm
+	 *
+	 * TODO: to align with the VCN implementation, move the
+	 * jobs for clockgating/powergating/dpm setting to
+	 * ->set_powergating_state().
+	 */
+	cancel_delayed_work_sync(&adev->uvd.idle_work);
+
+	if (adev->pm.dpm_enabled) {
+		amdgpu_dpm_enable_uvd(adev, false);
+	} else {
+		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
+		/* shutdown the UVD block */
+		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+						       AMD_CG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+						       AMD_PG_STATE_GATE);
+	}
+
 	if (RREG32(mmUVD_STATUS) != 0)
 		uvd_v5_0_stop(adev);
 
@@ -224,7 +248,6 @@ static int uvd_v5_0_suspend(void *handle)
 	r = uvd_v5_0_hw_fini(adev);
 	if (r)
 		return r;
-	uvd_v5_0_set_clockgating_state(adev, AMD_CG_STATE_GATE);
 
 	return amdgpu_uvd_suspend(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 7cd67cb2ac5f..0b5225a32234 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -605,6 +605,30 @@ static int uvd_v7_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	/*
+	 * Proper cleanups before halting the HW engine:
+	 *   - cancel the delayed idle work
+	 *   - enable powergating
+	 *   - enable clockgating
+	 *   - disable dpm
+	 *
+	 * TODO: to align with the VCN implementation, move the
+	 * jobs for clockgating/powergating/dpm setting to
+	 * ->set_powergating_state().
+	 */
+	cancel_delayed_work_sync(&adev->uvd.idle_work);
+
+	if (adev->pm.dpm_enabled) {
+		amdgpu_dpm_enable_uvd(adev, false);
+	} else {
+		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
+		/* shutdown the UVD block */
+		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+						       AMD_CG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+						       AMD_PG_STATE_GATE);
+	}
+
 	if (!amdgpu_sriov_vf(adev))
 		uvd_v7_0_stop(adev);
 	else {
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index 0e2945baf0f1..ac5d6a2bd1af 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -478,6 +478,31 @@ static int vce_v2_0_hw_init(void *handle)
 
 static int vce_v2_0_hw_fini(void *handle)
 {
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	/*
+	 * Proper cleanups before halting the HW engine:
+	 *   - cancel the delayed idle work
+	 *   - enable powergating
+	 *   - enable clockgating
+	 *   - disable dpm
+	 *
+	 * TODO: to align with the VCN implementation, move the
+	 * jobs for clockgating/powergating/dpm setting to
+	 * ->set_powergating_state().
+	 */
+	cancel_delayed_work_sync(&adev->vce.idle_work);
+
+	if (adev->pm.dpm_enabled) {
+		amdgpu_dpm_enable_vce(adev, false);
+	} else {
+		amdgpu_asic_set_vce_clocks(adev, 0, 0);
+		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
+						       AMD_CG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
+						       AMD_PG_STATE_GATE);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 37fa163393fd..feda5524f18c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -541,6 +541,29 @@ static int vce_v4_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	/*
+	 * Proper cleanups before halting the HW engine:
+	 *   - cancel the delayed idle work
+	 *   - enable powergating
+	 *   - enable clockgating
+	 *   - disable dpm
+	 *
+	 * TODO: to align with the VCN implementation, move the
+	 * jobs for clockgating/powergating/dpm setting to
+	 * ->set_powergating_state().
+	 */
+	cancel_delayed_work_sync(&adev->vce.idle_work);
+
+	if (adev->pm.dpm_enabled) {
+		amdgpu_dpm_enable_vce(adev, false);
+	} else {
+		amdgpu_asic_set_vce_clocks(adev, 0, 0);
+		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
+						       AMD_CG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
+						       AMD_PG_STATE_GATE);
+	}
+
 	if (!amdgpu_sriov_vf(adev)) {
 		/* vce_v4_0_wait_for_idle(handle); */
 		vce_v4_0_stop(adev);
-- 
2.29.0

