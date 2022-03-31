Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46905C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Mar 2022 03:33:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1BBB10F4E4;
	Thu, 31 Mar 2022 03:33:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEDDD10F4E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Mar 2022 03:33:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkrJRFOdOtx/29bRFujmYMVSYK5h2r5nCteA0BLDoI5z2l1CJObsTSrwcjHhVzdkA6zAaw2so3O/OkQHj2OyGZ6RJrFPq1jNpQ3GfIHni5M0Tuc7XhwkGgXiwoLXtZK8oDDimjjUsuE+IVErGQiqRqTgAhpbTbHVo8QEhAcxV0zWXl+ZFubYjzEdDkU99G0jCz0VYk9ll4tGVRSFwPJ/dZXQ1vdd1hbge9hBlPlt2OAWQhCN060wqMBtE5uXjM05UJyyBktOdj7L5fLQOKlUu/xYHPBhU7Ivee/x9pXM9JU0pY+5751HB+kFOkkoRDCnDTpK+XltlpxQ6eB9BDzDtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKAyFnINjyRVFCEpROgOhs6hrnGHII98sUiUxhXAmyY=;
 b=cdzEQsrHOmMeY2K1qPygQM+zomSgvXdI7PwROWc8cGDUnRRbNswFo0ZlDauTytKEzEpCprk9hL9y6PoR4SRHryXf2ir/3L3KUzx8pYTqSkVIzLwh5iwRDR5CQZhFMDvfC606b0nGxg9qcISlcaO8njHqVeRLFrruOZyO89olCaPbUsQl/kMqAUH9QImOjFxpyANFXb0khcjmg7ela9XtEzCo2SyfdxO9lNae6Ylf15l8kOj4MoSlodt7OQA9XMVV3YHkLuPsxQnbiXYAGpnPg+xq4OuSZm8DlHFqZf10xCdGTmAipbsmhW2+hcdI+BIHEbxSMN/InYwRh8Fgv4MqJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKAyFnINjyRVFCEpROgOhs6hrnGHII98sUiUxhXAmyY=;
 b=0SrKyTajmaEY8Fq7WhtFH9quR2pThFaRXCxYzKujPSyMjS4iJyE3Wp2HBYE7SdhGY0TKgzRFqJ9ik4L1SRjk2TnB3kVKwyH61KeNGYQkXW0AEKWConf3X6fA3qSLOFWKLfxEg6s/CPr46IcJEGzzomibS2zdcnS+2AVYRfE8d8E=
Received: from MW3PR05CA0025.namprd05.prod.outlook.com (2603:10b6:303:2b::30)
 by DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Thu, 31 Mar
 2022 03:33:51 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::de) by MW3PR05CA0025.outlook.office365.com
 (2603:10b6:303:2b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Thu, 31 Mar 2022 03:33:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Thu, 31 Mar 2022 03:33:49 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 30 Mar
 2022 22:33:45 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: expand cg_flags from u32 to u64
Date: Thu, 31 Mar 2022 11:33:03 +0800
Message-ID: <20220331033303.2843762-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e36f9433-6f80-4bfd-500c-08da12c7459c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4188:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB418855310DBE8089FD659367E4E19@DM6PR12MB4188.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J/PkTwcGuOBb5WmBWExM8W5Pi22dh+pw3bU7gR8AD8Xl+kksZ+K8/W+DSV/wVOiSaIsKITRoAXA8/FHJC3XuR0k3KN4alzGKVeLGI9evT+S95ZrRuPtevpfblWS92M6C9H6Qe+4chHk7A+CG+y5OZup1zbejRyCMHNIuWfF89A+g3jnS4j4dT2mhI1vtP7SnXO4yQDNqFUs4k4lTe3kXkU6hzNi7D+w/pn5R3Oj3QpvPql1PJ5Ca4RCxpo2e69dxsBBYa52dkh6VHZpMArsRbWpD1hEg7qvmu3PuqwF0sBnvrjAWk+/uFMCLWfdPUj+gQT40cOlivhXpXabDP2otEGcUFNFLSXnMx+Qjy/dSUG/Cw6YnEcCgrV/NA9Rq/pMHXLcFSYcnI1xYaXb/+xhTayG+/dND30wflo12ZajZKQe3smirF1lYwVMHjNoHpaNZKD3aaclAc/LZTJWuWPJ72eneNQa0yNKiiozSmejYFHJj/IAdAm45OZLaR4FL/mJWcCHA6IJB6lH+BwKD6a8warfmRrsFrq+DmYfoCCcdtnYkbZM92L28oHk+hBTy3eRJz3zbpy170XYGi2+a/h3UZda1yHhTgjSsOwPx3F+br4s+JSETzYnN8MuEy/oO1jWdvYCcRVvLDdI3q2SPlL7/NOHRMNIz8TqeD8cuJjzpN6LisJ7nqM4RSw/evn0j5Lsio6vZtpbpZWFTAL3z1P+dKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(4326008)(316002)(54906003)(6916009)(8936002)(82310400004)(44832011)(47076005)(70206006)(8676002)(36860700001)(356005)(30864003)(5660300002)(86362001)(70586007)(81166007)(426003)(40460700003)(2616005)(336012)(186003)(1076003)(2906002)(7696005)(26005)(508600001)(16526019)(83380400001)(36756003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 03:33:49.9979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e36f9433-6f80-4bfd-500c-08da12c7459c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4188
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tom.StDenis@amd.com,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With this, we can support more CG flags.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Change-Id: Iccf13c2f9c570ca6a4654291fc4876556125c3b8
--
v1->v2:
  - amdgpu_debugfs_gca_config_read: add a new rev to
    support CG flag upper 32 bits(Alex)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_df.h      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  8 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/athub_v1_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/athub_v1_0.h     |  2 +-
 drivers/gpu/drm/amd/amdgpu/athub_v2_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/athub_v2_0.h     |  2 +-
 drivers/gpu/drm/amd/amdgpu/athub_v2_1.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/athub_v2_1.h     |  2 +-
 drivers/gpu/drm/amd/amdgpu/df_v1_7.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/nv.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/smuio_v11_0_6.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/vi.c             |  2 +-
 drivers/gpu/drm/amd/include/amd_shared.h    | 66 ++++++++++-----------
 drivers/gpu/drm/amd/pm/amdgpu_pm.c          |  4 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h      |  2 +-
 53 files changed, 94 insertions(+), 91 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 22eeddd01014..dfc5b46c6a11 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -179,7 +179,7 @@ extern int amdgpu_sched_jobs;
 extern int amdgpu_sched_hw_submission;
 extern uint amdgpu_pcie_gen_cap;
 extern uint amdgpu_pcie_lane_cap;
-extern uint amdgpu_cg_mask;
+extern u64 amdgpu_cg_mask;
 extern uint amdgpu_pg_mask;
 extern uint amdgpu_sdma_phase_quantum;
 extern char *amdgpu_disable_cu;
@@ -322,7 +322,7 @@ int amdgpu_device_ip_set_powergating_state(void *dev,
 					   enum amd_ip_block_type block_type,
 					   enum amd_powergating_state state);
 void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
-					    u32 *flags);
+					    u64 *flags);
 int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
 				   enum amd_ip_block_type block_type);
 bool amdgpu_device_ip_is_idle(struct amdgpu_device *adev,
@@ -860,7 +860,7 @@ struct amdgpu_device {
 	/* powerplay */
 	struct amd_powerplay		powerplay;
 	struct amdgpu_pm		pm;
-	u32				cg_flags;
+	u64				cg_flags;
 	u32				pg_flags;
 
 	/* nbio */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 5d04d24a0d5f..1db48dc58ae9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -758,7 +758,7 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct file *f, char __user *buf,
 	/* rev==1 */
 	config[no_regs++] = adev->rev_id;
 	config[no_regs++] = adev->pg_flags;
-	config[no_regs++] = adev->cg_flags;
+	config[no_regs++] = lower_32_bits(adev->cg_flags);
 
 	/* rev==2 */
 	config[no_regs++] = adev->family;
@@ -773,6 +773,9 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct file *f, char __user *buf,
 	/* rev==4 APU flag */
 	config[no_regs++] = adev->flags & AMD_IS_APU ? 1 : 0;
 
+	/* rev==5 CG flag upper 32bit */
+	config[no_regs++] = upper_32_bits(adev->cg_flags);
+
 	while (size && (*pos < no_regs * 4)) {
 		uint32_t value;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fa4a9f13c922..6f47726f1765 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1703,7 +1703,7 @@ int amdgpu_device_ip_set_powergating_state(void *dev,
  * clockgating is enabled.
  */
 void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
-					    u32 *flags)
+					    u64 *flags)
 {
 	int i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
index 6b25837955c4..1538b2dbfff1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
@@ -40,7 +40,7 @@ struct amdgpu_df_funcs {
 	void (*update_medium_grain_clock_gating)(struct amdgpu_device *adev,
 						 bool enable);
 	void (*get_clockgating_state)(struct amdgpu_device *adev,
-				      u32 *flags);
+				      u64 *flags);
 	void (*enable_ecc_force_par_wr_rmw)(struct amdgpu_device *adev,
 					    bool enable);
 	int (*pmc_start)(struct amdgpu_device *adev, uint64_t config,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index bda1b5132ee8..e98820465109 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -136,7 +136,7 @@ int amdgpu_sched_jobs = 32;
 int amdgpu_sched_hw_submission = 2;
 uint amdgpu_pcie_gen_cap;
 uint amdgpu_pcie_lane_cap;
-uint amdgpu_cg_mask = 0xffffffff;
+u64 amdgpu_cg_mask = 0xffffffffffffffff;
 uint amdgpu_pg_mask = 0xffffffff;
 uint amdgpu_sdma_phase_quantum = 32;
 char *amdgpu_disable_cu = NULL;
@@ -454,12 +454,12 @@ MODULE_PARM_DESC(pcie_lane_cap, "PCIE Lane Caps (0: autodetect (default))");
 module_param_named(pcie_lane_cap, amdgpu_pcie_lane_cap, uint, 0444);
 
 /**
- * DOC: cg_mask (uint)
+ * DOC: cg_mask (ullong)
  * Override Clockgating features enabled on GPU (0 = disable clock gating). See the AMD_CG_SUPPORT flags in
- * drivers/gpu/drm/amd/include/amd_shared.h. The default is 0xffffffff (all enabled).
+ * drivers/gpu/drm/amd/include/amd_shared.h. The default is 0xffffffffffffffff (all enabled).
  */
 MODULE_PARM_DESC(cg_mask, "Clockgating flags mask (0 = disable clock gating)");
-module_param_named(cg_mask, amdgpu_cg_mask, uint, 0444);
+module_param_named(cg_mask, amdgpu_cg_mask, ullong, 0444);
 
 /**
  * DOC: pg_mask (uint)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
index 9181c7bef7c6..ac5c61d3de2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -33,7 +33,7 @@ struct amdgpu_hdp_funcs {
 	void (*invalidate_hdp)(struct amdgpu_device *adev,
 			       struct amdgpu_ring *ring);
 	void (*update_clock_gating)(struct amdgpu_device *adev, bool enable);
-	void (*get_clock_gating_state)(struct amdgpu_device *adev, u32 *flags);
+	void (*get_clock_gating_state)(struct amdgpu_device *adev, u64 *flags);
 	void (*init_registers)(struct amdgpu_device *adev);
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
index 9f1540f0ebf9..f939395c5914 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
@@ -34,7 +34,7 @@ struct amdgpu_mmhub_funcs {
 	void (*gart_disable)(struct amdgpu_device *adev);
 	int (*set_clockgating)(struct amdgpu_device *adev,
 			       enum amd_clockgating_state state);
-	void (*get_clockgating)(struct amdgpu_device *adev, u32 *flags);
+	void (*get_clockgating)(struct amdgpu_device *adev, u64 *flags);
 	void (*setup_vm_pt_regs)(struct amdgpu_device *adev, uint32_t vmid,
 				uint64_t page_table_base);
 	void (*update_power_gating)(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 3d13e601fc35..03439083182a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -83,7 +83,7 @@ struct amdgpu_nbio_funcs {
 	void (*update_medium_grain_light_sleep)(struct amdgpu_device *adev,
 						bool enable);
 	void (*get_clockgating_state)(struct amdgpu_device *adev,
-				      u32 *flags);
+				      u64 *flags);
 	void (*ih_control)(struct amdgpu_device *adev);
 	void (*init_registers)(struct amdgpu_device *adev);
 	void (*remap_hdp_registers)(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
index 484bb3dcec47..c7a823f3f2c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
@@ -27,7 +27,7 @@ struct amdgpu_smuio_funcs {
 	u32 (*get_rom_index_offset)(struct amdgpu_device *adev);
 	u32 (*get_rom_data_offset)(struct amdgpu_device *adev);
 	void (*update_rom_clock_gating)(struct amdgpu_device *adev, bool enable);
-	void (*get_clock_gating_state)(struct amdgpu_device *adev, u32 *flags);
+	void (*get_clock_gating_state)(struct amdgpu_device *adev, u64 *flags);
 	u32 (*get_die_id)(struct amdgpu_device *adev);
 	u32 (*get_socket_id)(struct amdgpu_device *adev);
 	bool (*is_host_gpu_xgmi_supported)(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c
index 88642e7ecdf4..a13c443ea10f 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c
@@ -87,7 +87,7 @@ int athub_v1_0_set_clockgating(struct amdgpu_device *adev,
 	return 0;
 }
 
-void athub_v1_0_get_clockgating(struct amdgpu_device *adev, u32 *flags)
+void athub_v1_0_get_clockgating(struct amdgpu_device *adev, u64 *flags)
 {
 	int data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v1_0.h b/drivers/gpu/drm/amd/amdgpu/athub_v1_0.h
index b279af59e34f..6be0a6704ea7 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v1_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v1_0.h
@@ -25,6 +25,6 @@
 
 int athub_v1_0_set_clockgating(struct amdgpu_device *adev,
 			       enum amd_clockgating_state state);
-void athub_v1_0_get_clockgating(struct amdgpu_device *adev, u32 *flags);
+void athub_v1_0_get_clockgating(struct amdgpu_device *adev, u64 *flags);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
index a720436857b4..a9521c98e7f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
@@ -93,7 +93,7 @@ int athub_v2_0_set_clockgating(struct amdgpu_device *adev,
 	return 0;
 }
 
-void athub_v2_0_get_clockgating(struct amdgpu_device *adev, u32 *flags)
+void athub_v2_0_get_clockgating(struct amdgpu_device *adev, u64 *flags)
 {
 	int data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_0.h b/drivers/gpu/drm/amd/amdgpu/athub_v2_0.h
index 02932c1c8bab..8b763f6dfd81 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v2_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_0.h
@@ -25,6 +25,6 @@
 
 int athub_v2_0_set_clockgating(struct amdgpu_device *adev,
 			       enum amd_clockgating_state state);
-void athub_v2_0_get_clockgating(struct amdgpu_device *adev, u32 *flags);
+void athub_v2_0_get_clockgating(struct amdgpu_device *adev, u64 *flags);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
index ad8e87d3d2cb..78508ae6a670 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
@@ -85,7 +85,7 @@ int athub_v2_1_set_clockgating(struct amdgpu_device *adev,
 	return 0;
 }
 
-void athub_v2_1_get_clockgating(struct amdgpu_device *adev, u32 *flags)
+void athub_v2_1_get_clockgating(struct amdgpu_device *adev, u64 *flags)
 {
 	int data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.h b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.h
index 5e6824c0f591..b799f14bce03 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.h
@@ -25,6 +25,6 @@
 
 int athub_v2_1_set_clockgating(struct amdgpu_device *adev,
 			       enum amd_clockgating_state state);
-void athub_v2_1_get_clockgating(struct amdgpu_device *adev, u32 *flags);
+void athub_v2_1_get_clockgating(struct amdgpu_device *adev, u64 *flags);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
index 2d01ac0d4c11..b991609f46c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
@@ -99,7 +99,7 @@ static void df_v1_7_update_medium_grain_clock_gating(struct amdgpu_device *adev,
 }
 
 static void df_v1_7_get_clockgating_state(struct amdgpu_device *adev,
-					  u32 *flags)
+					  u64 *flags)
 {
 	u32 tmp;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index f4dfca013ec5..483a441b46aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -332,7 +332,7 @@ static void df_v3_6_update_medium_grain_clock_gating(struct amdgpu_device *adev,
 }
 
 static void df_v3_6_get_clockgating_state(struct amdgpu_device *adev,
-					  u32 *flags)
+					  u64 *flags)
 {
 	u32 tmp;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index a98b78e0b507..de1bbbd4238c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8451,7 +8451,7 @@ static int gfx_v10_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static void gfx_v10_0_get_clockgating_state(void *handle, u32 *flags)
+static void gfx_v10_0_get_clockgating_state(void *handle, u64 *flags)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int data;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 5f112efda634..46d436be74eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5475,7 +5475,7 @@ static int gfx_v8_0_set_powergating_state(void *handle,
 	return 0;
 }
 
-static void gfx_v8_0_get_clockgating_state(void *handle, u32 *flags)
+static void gfx_v8_0_get_clockgating_state(void *handle, u64 *flags)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int data;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 46d4bf27ebbb..f9709d7a1391 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5231,7 +5231,7 @@ static int gfx_v9_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static void gfx_v9_0_get_clockgating_state(void *handle, u32 *flags)
+static void gfx_v9_0_get_clockgating_state(void *handle, u64 *flags)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int data;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 5228421b0f72..a455e59f41f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1161,7 +1161,7 @@ static int gmc_v10_0_set_clockgating_state(void *handle,
 		return athub_v2_0_set_clockgating(adev, state);
 }
 
-static void gmc_v10_0_get_clockgating_state(void *handle, u32 *flags)
+static void gmc_v10_0_get_clockgating_state(void *handle, u64 *flags)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 1932a3e4af7e..382dde1ce74c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1690,7 +1690,7 @@ static int gmc_v8_0_set_powergating_state(void *handle,
 	return 0;
 }
 
-static void gmc_v8_0_get_clockgating_state(void *handle, u32 *flags)
+static void gmc_v8_0_get_clockgating_state(void *handle, u64 *flags)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int data;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 6009fbfdcc19..22761a3bb818 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1948,7 +1948,7 @@ static int gmc_v9_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static void gmc_v9_0_get_clockgating_state(void *handle, u32 *flags)
+static void gmc_v9_0_get_clockgating_state(void *handle, u64 *flags)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index 046216635262..adf89680f53e 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -124,7 +124,7 @@ static void hdp_v4_0_update_clock_gating(struct amdgpu_device *adev,
 }
 
 static void hdp_v4_0_get_clockgating_state(struct amdgpu_device *adev,
-					    u32 *flags)
+					    u64 *flags)
 {
 	int data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
index 5793977953cc..a9ea23fa0def 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
@@ -181,7 +181,7 @@ static void hdp_v5_0_update_clock_gating(struct amdgpu_device *adev,
 }
 
 static void hdp_v5_0_get_clockgating_state(struct amdgpu_device *adev,
-					    u32 *flags)
+					    u64 *flags)
 {
 	uint32_t tmp;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 4c9f0c0f3116..3f44a099c52a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -546,7 +546,7 @@ static int mmhub_v1_0_set_clockgating(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void mmhub_v1_0_get_clockgating(struct amdgpu_device *adev, u32 *flags)
+static void mmhub_v1_0_get_clockgating(struct amdgpu_device *adev, u64 *flags)
 {
 	int data, data1;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 3b901f941627..6fa7090bc6cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -542,7 +542,7 @@ static int mmhub_v1_7_set_clockgating(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void mmhub_v1_7_get_clockgating(struct amdgpu_device *adev, u32 *flags)
+static void mmhub_v1_7_get_clockgating(struct amdgpu_device *adev, u64 *flags)
 {
 	int data, data1;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 3718ff610ab2..636abd855686 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -682,7 +682,7 @@ static int mmhub_v2_0_set_clockgating(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void mmhub_v2_0_get_clockgating(struct amdgpu_device *adev, u32 *flags)
+static void mmhub_v2_0_get_clockgating(struct amdgpu_device *adev, u64 *flags)
 {
 	int data, data1;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index 1957fb098c4d..ff44c5364a8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -577,7 +577,7 @@ static int mmhub_v2_3_set_clockgating(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void mmhub_v2_3_get_clockgating(struct amdgpu_device *adev, u32 *flags)
+static void mmhub_v2_3_get_clockgating(struct amdgpu_device *adev, u64 *flags)
 {
 	int data, data1, data2, data3;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index 619106f7d23d..6e0145b2b408 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -647,7 +647,7 @@ static int mmhub_v9_4_set_clockgating(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void mmhub_v9_4_get_clockgating(struct amdgpu_device *adev, u32 *flags)
+static void mmhub_v9_4_get_clockgating(struct amdgpu_device *adev, u64 *flags)
 {
 	int data, data1;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 8ce5b8ca1fd7..97201ab0965e 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -685,7 +685,7 @@ static int navi10_ih_set_powergating_state(void *handle,
 	return 0;
 }
 
-static void navi10_ih_get_clockgating_state(void *handle, u32 *flags)
+static void navi10_ih_get_clockgating_state(void *handle, u64 *flags)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index ee7cab37dfd5..6cd1fb2eb913 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -278,7 +278,7 @@ static void nbio_v2_3_update_medium_grain_light_sleep(struct amdgpu_device *adev
 }
 
 static void nbio_v2_3_get_clockgating_state(struct amdgpu_device *adev,
-					    u32 *flags)
+					    u64 *flags)
 {
 	int data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
index 4bbacf1be25a..f7f6ddebd3e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
@@ -210,7 +210,7 @@ static void nbio_v6_1_update_medium_grain_light_sleep(struct amdgpu_device *adev
 }
 
 static void nbio_v6_1_get_clockgating_state(struct amdgpu_device *adev,
-					    u32 *flags)
+					    u64 *flags)
 {
 	int data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
index 37a4039fdfc5..aa0326d00c72 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
@@ -205,7 +205,7 @@ static void nbio_v7_0_update_medium_grain_light_sleep(struct amdgpu_device *adev
 }
 
 static void nbio_v7_0_get_clockgating_state(struct amdgpu_device *adev,
-					    u32 *flags)
+					    u64 *flags)
 {
 	int data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
index 6f81de6f3cc4..31776b12e4c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
@@ -306,7 +306,7 @@ static void nbio_v7_2_update_medium_grain_light_sleep(struct amdgpu_device *adev
 }
 
 static void nbio_v7_2_get_clockgating_state(struct amdgpu_device *adev,
-					    u32 *flags)
+					    u64 *flags)
 {
 	int data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index c2357e83a8c4..4531761dcf77 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -273,7 +273,7 @@ static void nbio_v7_4_update_medium_grain_light_sleep(struct amdgpu_device *adev
 }
 
 static void nbio_v7_4_get_clockgating_state(struct amdgpu_device *adev,
-					    u32 *flags)
+					    u64 *flags)
 {
 	int data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index e19f14c3ef59..0a7946c59a42 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1115,7 +1115,7 @@ static int nv_common_set_powergating_state(void *handle,
 	return 0;
 }
 
-static void nv_common_get_clockgating_state(void *handle, u32 *flags)
+static void nv_common_get_clockgating_state(void *handle, u64 *flags)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 4ef4feff5649..3695374896ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1535,7 +1535,7 @@ static int sdma_v3_0_set_powergating_state(void *handle,
 	return 0;
 }
 
-static void sdma_v3_0_get_clockgating_state(void *handle, u32 *flags)
+static void sdma_v3_0_get_clockgating_state(void *handle, u64 *flags)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int data;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index d7e8f7232364..8589ab1c9800 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2372,7 +2372,7 @@ static int sdma_v4_0_set_powergating_state(void *handle,
 	return 0;
 }
 
-static void sdma_v4_0_get_clockgating_state(void *handle, u32 *flags)
+static void sdma_v4_0_get_clockgating_state(void *handle, u64 *flags)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int data;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index a8d49c005f73..775aabde1ae2 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1648,7 +1648,7 @@ static int sdma_v5_0_set_powergating_state(void *handle,
 	return 0;
 }
 
-static void sdma_v5_0_get_clockgating_state(void *handle, u32 *flags)
+static void sdma_v5_0_get_clockgating_state(void *handle, u64 *flags)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int data;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 824eace69884..ca50857b982d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1645,7 +1645,7 @@ static int sdma_v5_2_set_powergating_state(void *handle,
 	return 0;
 }
 
-static void sdma_v5_2_get_clockgating_state(void *handle, u32 *flags)
+static void sdma_v5_2_get_clockgating_state(void *handle, u64 *flags)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int data;
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c b/drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c
index b6f1322f908c..acdc40f99ab3 100644
--- a/drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c
@@ -59,7 +59,7 @@ static void smuio_v11_0_update_rom_clock_gating(struct amdgpu_device *adev, bool
 		WREG32_SOC15(SMUIO, 0, mmCGTT_ROM_CLK_CTRL0, data);
 }
 
-static void smuio_v11_0_get_clock_gating_state(struct amdgpu_device *adev, u32 *flags)
+static void smuio_v11_0_get_clock_gating_state(struct amdgpu_device *adev, u64 *flags)
 {
 	u32 data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v11_0_6.c b/drivers/gpu/drm/amd/amdgpu/smuio_v11_0_6.c
index 3a18dbb55c32..2afeb8b37f62 100644
--- a/drivers/gpu/drm/amd/amdgpu/smuio_v11_0_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v11_0_6.c
@@ -56,7 +56,7 @@ static void smuio_v11_0_6_update_rom_clock_gating(struct amdgpu_device *adev, bo
 		WREG32_SOC15(SMUIO, 0, mmCGTT_ROM_CLK_CTRL0, data);
 }
 
-static void smuio_v11_0_6_get_clock_gating_state(struct amdgpu_device *adev, u32 *flags)
+static void smuio_v11_0_6_get_clock_gating_state(struct amdgpu_device *adev, u64 *flags)
 {
 	u32 data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c
index 39b7c206770f..13e905c22592 100644
--- a/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c
@@ -58,7 +58,7 @@ static void smuio_v13_0_update_rom_clock_gating(struct amdgpu_device *adev, bool
 		WREG32_SOC15(SMUIO, 0, regCGTT_ROM_CLK_CTRL0, data);
 }
 
-static void smuio_v13_0_get_clock_gating_state(struct amdgpu_device *adev, u32 *flags)
+static void smuio_v13_0_get_clock_gating_state(struct amdgpu_device *adev, u64 *flags)
 {
 	u32 data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c b/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c
index 8417890af227..e4e30b9d481b 100644
--- a/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c
@@ -56,7 +56,7 @@ static void smuio_v9_0_update_rom_clock_gating(struct amdgpu_device *adev, bool
 		WREG32_SOC15(SMUIO, 0, mmCGTT_ROM_CLK_CTRL0, data);
 }
 
-static void smuio_v9_0_get_clock_gating_state(struct amdgpu_device *adev, u32 *flags)
+static void smuio_v9_0_get_clock_gating_state(struct amdgpu_device *adev, u64 *flags)
 {
 	u32 data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 3d0251ef8d79..3ee7322081d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1419,7 +1419,7 @@ static int soc15_common_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static void soc15_common_get_clockgating_state(void *handle, u32 *flags)
+static void soc15_common_get_clockgating_state(void *handle, u64 *flags)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int data;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index 563493d1f830..d7e31e48a2b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -833,7 +833,7 @@ static int uvd_v5_0_set_powergating_state(void *handle,
 	return ret;
 }
 
-static void uvd_v5_0_get_clockgating_state(void *handle, u32 *flags)
+static void uvd_v5_0_get_clockgating_state(void *handle, u64 *flags)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int data;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 2d558c2f417d..375c440957dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -1494,7 +1494,7 @@ static int uvd_v6_0_set_powergating_state(void *handle,
 	return ret;
 }
 
-static void uvd_v6_0_get_clockgating_state(void *handle, u32 *flags)
+static void uvd_v6_0_get_clockgating_state(void *handle, u64 *flags)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int data;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 142e291983b4..8def62c83ffd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -831,7 +831,7 @@ static int vce_v3_0_set_powergating_state(void *handle,
 	return ret;
 }
 
-static void vce_v3_0_get_clockgating_state(void *handle, u32 *flags)
+static void vce_v3_0_get_clockgating_state(void *handle, u64 *flags)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int data;
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 039b90cdc3bc..c5b88d15a6df 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -2033,7 +2033,7 @@ static int vi_common_set_powergating_state(void *handle,
 	return 0;
 }
 
-static void vi_common_get_clockgating_state(void *handle, u32 *flags)
+static void vi_common_get_clockgating_state(void *handle, u64 *flags)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int data;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index fe4e585781bb..741dae17562a 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -116,38 +116,38 @@ enum amd_powergating_state {
 
 
 /* CG flags */
-#define AMD_CG_SUPPORT_GFX_MGCG			(1 << 0)
-#define AMD_CG_SUPPORT_GFX_MGLS			(1 << 1)
-#define AMD_CG_SUPPORT_GFX_CGCG			(1 << 2)
-#define AMD_CG_SUPPORT_GFX_CGLS			(1 << 3)
-#define AMD_CG_SUPPORT_GFX_CGTS			(1 << 4)
-#define AMD_CG_SUPPORT_GFX_CGTS_LS		(1 << 5)
-#define AMD_CG_SUPPORT_GFX_CP_LS		(1 << 6)
-#define AMD_CG_SUPPORT_GFX_RLC_LS		(1 << 7)
-#define AMD_CG_SUPPORT_MC_LS			(1 << 8)
-#define AMD_CG_SUPPORT_MC_MGCG			(1 << 9)
-#define AMD_CG_SUPPORT_SDMA_LS			(1 << 10)
-#define AMD_CG_SUPPORT_SDMA_MGCG		(1 << 11)
-#define AMD_CG_SUPPORT_BIF_LS			(1 << 12)
-#define AMD_CG_SUPPORT_UVD_MGCG			(1 << 13)
-#define AMD_CG_SUPPORT_VCE_MGCG			(1 << 14)
-#define AMD_CG_SUPPORT_HDP_LS			(1 << 15)
-#define AMD_CG_SUPPORT_HDP_MGCG			(1 << 16)
-#define AMD_CG_SUPPORT_ROM_MGCG			(1 << 17)
-#define AMD_CG_SUPPORT_DRM_LS			(1 << 18)
-#define AMD_CG_SUPPORT_BIF_MGCG			(1 << 19)
-#define AMD_CG_SUPPORT_GFX_3D_CGCG		(1 << 20)
-#define AMD_CG_SUPPORT_GFX_3D_CGLS		(1 << 21)
-#define AMD_CG_SUPPORT_DRM_MGCG			(1 << 22)
-#define AMD_CG_SUPPORT_DF_MGCG			(1 << 23)
-#define AMD_CG_SUPPORT_VCN_MGCG			(1 << 24)
-#define AMD_CG_SUPPORT_HDP_DS			(1 << 25)
-#define AMD_CG_SUPPORT_HDP_SD			(1 << 26)
-#define AMD_CG_SUPPORT_IH_CG			(1 << 27)
-#define AMD_CG_SUPPORT_ATHUB_LS			(1 << 28)
-#define AMD_CG_SUPPORT_ATHUB_MGCG		(1 << 29)
-#define AMD_CG_SUPPORT_JPEG_MGCG		(1 << 30)
-#define AMD_CG_SUPPORT_GFX_FGCG			(1 << 31)
+#define AMD_CG_SUPPORT_GFX_MGCG			(1ULL << 0)
+#define AMD_CG_SUPPORT_GFX_MGLS			(1ULL << 1)
+#define AMD_CG_SUPPORT_GFX_CGCG			(1ULL << 2)
+#define AMD_CG_SUPPORT_GFX_CGLS			(1ULL << 3)
+#define AMD_CG_SUPPORT_GFX_CGTS			(1ULL << 4)
+#define AMD_CG_SUPPORT_GFX_CGTS_LS		(1ULL << 5)
+#define AMD_CG_SUPPORT_GFX_CP_LS		(1ULL << 6)
+#define AMD_CG_SUPPORT_GFX_RLC_LS		(1ULL << 7)
+#define AMD_CG_SUPPORT_MC_LS			(1ULL << 8)
+#define AMD_CG_SUPPORT_MC_MGCG			(1ULL << 9)
+#define AMD_CG_SUPPORT_SDMA_LS			(1ULL << 10)
+#define AMD_CG_SUPPORT_SDMA_MGCG		(1ULL << 11)
+#define AMD_CG_SUPPORT_BIF_LS			(1ULL << 12)
+#define AMD_CG_SUPPORT_UVD_MGCG			(1ULL << 13)
+#define AMD_CG_SUPPORT_VCE_MGCG			(1ULL << 14)
+#define AMD_CG_SUPPORT_HDP_LS			(1ULL << 15)
+#define AMD_CG_SUPPORT_HDP_MGCG			(1ULL << 16)
+#define AMD_CG_SUPPORT_ROM_MGCG			(1ULL << 17)
+#define AMD_CG_SUPPORT_DRM_LS			(1ULL << 18)
+#define AMD_CG_SUPPORT_BIF_MGCG			(1ULL << 19)
+#define AMD_CG_SUPPORT_GFX_3D_CGCG		(1ULL << 20)
+#define AMD_CG_SUPPORT_GFX_3D_CGLS		(1ULL << 21)
+#define AMD_CG_SUPPORT_DRM_MGCG			(1ULL << 22)
+#define AMD_CG_SUPPORT_DF_MGCG			(1ULL << 23)
+#define AMD_CG_SUPPORT_VCN_MGCG			(1ULL << 24)
+#define AMD_CG_SUPPORT_HDP_DS			(1ULL << 25)
+#define AMD_CG_SUPPORT_HDP_SD			(1ULL << 26)
+#define AMD_CG_SUPPORT_IH_CG			(1ULL << 27)
+#define AMD_CG_SUPPORT_ATHUB_LS			(1ULL << 28)
+#define AMD_CG_SUPPORT_ATHUB_MGCG		(1ULL << 29)
+#define AMD_CG_SUPPORT_JPEG_MGCG		(1ULL << 30)
+#define AMD_CG_SUPPORT_GFX_FGCG			(1ULL << 31)
 /* PG flags */
 #define AMD_PG_SUPPORT_GFX_PG			(1 << 0)
 #define AMD_PG_SUPPORT_GFX_SMG			(1 << 1)
@@ -298,7 +298,7 @@ struct amd_ip_funcs {
 				     enum amd_clockgating_state state);
 	int (*set_powergating_state)(void *handle,
 				     enum amd_powergating_state state);
-	void (*get_clockgating_state)(void *handle, u32 *flags);
+	void (*get_clockgating_state)(void *handle, u64 *flags);
 };
 
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 4a9aabc16fbc..027b0df013c6 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3524,7 +3524,7 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgpu_device *a
 	return 0;
 }
 
-static void amdgpu_parse_cg_state(struct seq_file *m, u32 flags)
+static void amdgpu_parse_cg_state(struct seq_file *m, u64 flags)
 {
 	int i;
 
@@ -3537,7 +3537,7 @@ static int amdgpu_debugfs_pm_info_show(struct seq_file *m, void *unused)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
 	struct drm_device *dev = adev_to_drm(adev);
-	u32 flags = 0;
+	u64 flags = 0;
 	int r;
 
 	if (amdgpu_in_reset(adev))
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
index a920515e2274..52045ad59bed 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
@@ -26,7 +26,7 @@
 
 struct cg_flag_name
 {
-	u32 flag;
+	u64 flag;
 	const char *name;
 };
 
-- 
2.29.0

