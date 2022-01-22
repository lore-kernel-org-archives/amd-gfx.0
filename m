Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFEEC433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Jan 2022 03:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B556810E503;
	Sat, 22 Jan 2022 03:47:20 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE0310E372
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Jan 2022 03:47:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCmfoB4HiKVx4723t0RjjV7mQcrst/F2RD5G12OdDZe4y6bVyTVhNndgdspJOcfNpojvrQIXde1zByVXdyZglENiHF/KlGtUKcgdSY1IbqqxHtmYCBJDTgGqGrNbro9LScVJIjTcvMBhrmlSu4kTvIiaQE5+o4YIXDqrQQupcLgUG+0gzV4Gzv0BiKNEUs+HLQeyzFHzqP6kC7/EQcm9OHlJ+tHhM5bDQwcUA0NX2L9irAKRZ32bqEfkyslw3dmgieujOcyisPYQsVRO0Tr/UFCUcowEy1g/i+UIfFkGpdmiJAh/rbEIUjkCrEoSQe9a9d3J0+7YP0QB0dbkNt88ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnGWc0n5rV1yD1qsWlQgP6gCxaomNQlOR5HGQHKGH84=;
 b=JoFOqoviwhUXBIZllTWyHzKlNYeHDm1Wp934zFWZRCPyYUI/kVYmj8tGDDP+kDJZ+hez7llQj6FuNkKVsFOf7biMT/O243xoOAdJdCJBZ+GY3XqUUkfB+l3jZvoAjtOcw1jllfny5XxAJG3hOkLTRc4VyXPuogrKkOHTHC1zKQzg6FNg6pnIRqy2lA96pnRuDloLKIP6Z6l/OHorpNn89HXXHrjLus/YzuJPlknCI2x0c/TNx2XNuFOqX1b28Je5HkeSv2/L60a2zfJJuN6vFVa7P0Nu7+9dNMQRb4QsqR7bnn3Y6HWPVuVRjyDHS62108CzeXJN5CAHMpL7tcWjqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnGWc0n5rV1yD1qsWlQgP6gCxaomNQlOR5HGQHKGH84=;
 b=ILLlPuRCFltmwhIrqN8XD8Vx6T7Y/SeKNbs38TWe+crS/DXVNBJ3F/FDUzoIFFKmIGKu8UQwZj4L2uujpXIAx3OfIBl1WKhNJHnqwZQLrQpSDCXtTyamBjdLH0KL5FEqF/h81d4CwTZAlF2FKrb4/IuRjFzfoB3SmoMGxr9pcPY=
Received: from BN9PR03CA0889.namprd03.prod.outlook.com (2603:10b6:408:13c::24)
 by SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.13; Sat, 22 Jan
 2022 03:47:13 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::2) by BN9PR03CA0889.outlook.office365.com
 (2603:10b6:408:13c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13 via Frontend
 Transport; Sat, 22 Jan 2022 03:47:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sat, 22 Jan 2022 03:47:13 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 21 Jan 2022 21:47:12 -0600
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] amdgpu/pm: Implement new API function "emit" that accepts
 buffer base and write offset
Date: Fri, 21 Jan 2022 22:46:45 -0500
Message-ID: <20220122034647.67925-2-darren.powell@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220122034647.67925-1-darren.powell@amd.com>
References: <20220122034647.67925-1-darren.powell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aea818d1-242d-463e-a94a-08d9dd59e049
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5676:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5676F7CD21F34B4BD166F912F05C9@SJ0PR12MB5676.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:226;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I6EF0JuY7wIUbP+mxV8EHQTe2Jgb5cc2FzFGoLmvjUe+pguuX/RAnk60/79AzyeU8KXtOKLr38oArA9SEYz3GqHGmySf/cfTOvtzkwjMnl1QVhh3HB/UcGh9P2/WaimUHv/U163pT8XDgAmKW7VfbgWVAvUeeXcZ+Ac9Yp5cEFTZJ6mw2qOXPFBUugQhKdadcUtH6TMygrmE6JG6z2XGT8zcptx56Y6W0mnif4ImAFc3m6f9v/Hj3PF7a27KAJd8remf0QzO153ViLeWqREq5pYAYvEAULccPD+R4jQ+VJ55FmBeS0rU28ceqDLKh2cirqpt7TRKZcFeQVlN3Mxe0LkKPX9XJX29oUPRT78pIDDXrXxNgzy4T4QW2HxuOCmiAAe72JWrGKnE7dM8Wjv31IwRlopiQys6sPYxx5HA8huV/unC05c8SLoMCimVtpuatifZPbPHtZm9fz696xKhOmpGiZEXnjJc8rYhQH93o/8RX098x80+sjkXAejwOZd/L74nN6VN3u8LP6rHuPJ2w+4Gb3NeATZkpIjPFQOIklAHhOStJyzZTWgfvcm5YdUfKgQM9xMMvnqh8KHtCYjX2Lo1mCR4+sMqx/yWFANE7bGFOLQaXP/wxx1KYSFapYBbVOIZtq43PTJlN6KYyClKgibwiC6jKyRW+i2PjM7hsb5ctbKc31GZZ6Mmk8+xF1S/3964C9Nw62BgzfCFmU2bxk8xLe7KUg81f4cr4rrmE7m6W182EScYJ8FsZrntf3alX5sclC8id/q4ucDkkHNdmCo3SHOHmVZa2r83sc7uwHo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700004)(46966006)(36840700001)(36756003)(5660300002)(36860700001)(2616005)(16526019)(508600001)(186003)(70586007)(26005)(40460700003)(86362001)(426003)(7696005)(4326008)(2906002)(1076003)(316002)(83380400001)(336012)(6916009)(82310400004)(8936002)(81166007)(30864003)(6666004)(8676002)(356005)(70206006)(47076005)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2022 03:47:13.3762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aea818d1-242d-463e-a94a-08d9dd59e049
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5676
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
Cc: Darren Powell <darren.powell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

   (v1)
 - new power management function emit_clk_levels implemented by navi10_emit_clk_levels()
       This function currently duplicates the functionality of navi10_print_clk_levels, where
       snprintf is used write to the sysfs buffer. The first implementation to use sysfs_emit
       was unsuccessful due to requirement that buf must be aligned to a specific memory
       boundary. This solution passes the buffer base and write offset down the stack.
 - new power management function emit_clock_levels implemented by smu_emit_ppclk_levels()
       This function combines implementation of smu_print_ppclk_levels and
       smu_print_smuclk_levels and calls emit_clk_levels
 - new helper function smu_convert_to_smuclk called by smu_print_ppclk_levels and
       smu_emit_ppclk_levels
 - emit_clock_levels currently returns the length of the string written to the buffer,
       maintaining the behaviour of print_clock_levels, but will be upgraded to return
       error values in a subsequent patch
 - failure of the emit_clock_levels at the top level (amdgpu_get_pp_dpm_clock) triggers a
       fallback to the print_clock_levels, which can be removed after emit_clock_levels is
       implemented across all platforms.

   (v2)
      Update to apply on commit 801771de03
      adjust printing of empty carriage return only if size == 0

 == Test ==
 LOGFILE=pp_clk.test.log
 AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
 AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{print $9}'`
 HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}

 lspci -nn | grep "VGA\|Display"  > $LOGFILE
 FILES="pp_od_clk_voltage
 pp_dpm_sclk
 pp_dpm_mclk
 pp_dpm_pcie
 pp_dpm_socclk
 pp_dpm_fclk
 pp_dpm_dcefclk
 pp_dpm_vclk
 pp_dpm_dclk "

 for f in $FILES
 do
   echo === $f === >> $LOGFILE
   cat $HWMON_DIR/device/$f >> $LOGFILE
 done
 cat $LOGFILE

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |   1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  21 ++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  11 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   4 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  46 ++++-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  10 +
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 189 ++++++++++++++++++
 7 files changed, 273 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index a8eec91c0995..8a8eb9411cdf 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -321,6 +321,7 @@ struct amd_pm_funcs {
 	int (*get_fan_speed_pwm)(void *handle, u32 *speed);
 	int (*force_clock_level)(void *handle, enum pp_clock_type type, uint32_t mask);
 	int (*print_clock_levels)(void *handle, enum pp_clock_type type, char *buf);
+	int (*emit_clock_levels)(void *handle, enum pp_clock_type type, char *buf, int *offset);
 	int (*force_performance_level)(void *handle, enum amd_dpm_forced_level level);
 	int (*get_sclk_od)(void *handle);
 	int (*set_sclk_od)(void *handle, uint32_t value);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 728b6e10f302..e45578124928 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -906,6 +906,27 @@ int amdgpu_dpm_print_clock_levels(struct amdgpu_device *adev,
 	return ret;
 }
 
+int amdgpu_dpm_emit_clock_levels(struct amdgpu_device *adev,
+				  enum pp_clock_type type,
+				  char *buf,
+				  int *offset)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
+
+	if (!pp_funcs->emit_clock_levels)
+		return 0;
+
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->emit_clock_levels(adev->powerplay.pp_handle,
+					   type,
+					   buf,
+					   offset);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
+}
+
 int amdgpu_dpm_set_ppfeature_status(struct amdgpu_device *adev,
 				    uint64_t ppfeature_masks)
 {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d2823aaeca09..ec2729b3930e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -980,8 +980,8 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	ssize_t size;
-	int ret;
+	int size = 0;
+	int ret = 0;
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
@@ -994,8 +994,11 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
 		return ret;
 	}
 
-	size = amdgpu_dpm_print_clock_levels(adev, type, buf);
-	if (size <= 0)
+	ret = amdgpu_dpm_emit_clock_levels(adev, type, buf, &size);
+	if (ret < 0)
+		size = amdgpu_dpm_print_clock_levels(adev, type, buf);
+
+	if (size == 0)
 		size = sysfs_emit(buf, "\n");
 
 	pm_runtime_mark_last_busy(ddev->dev);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index ba857ca75392..a33dd7069258 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -428,6 +428,10 @@ int amdgpu_dpm_odn_edit_dpm_table(struct amdgpu_device *adev,
 int amdgpu_dpm_print_clock_levels(struct amdgpu_device *adev,
 				  enum pp_clock_type type,
 				  char *buf);
+int amdgpu_dpm_emit_clock_levels(struct amdgpu_device *adev,
+				  enum pp_clock_type type,
+				  char *buf,
+				  int *offset);
 int amdgpu_dpm_set_ppfeature_status(struct amdgpu_device *adev,
 				    uint64_t ppfeature_masks);
 int amdgpu_dpm_get_ppfeature_status(struct amdgpu_device *adev, char *buf);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c374c3067496..d82ea7ee223f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2387,11 +2387,8 @@ static int smu_print_smuclk_levels(struct smu_context *smu, enum smu_clk_type cl
 	return ret;
 }
 
-static int smu_print_ppclk_levels(void *handle,
-				  enum pp_clock_type type,
-				  char *buf)
+static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
 {
-	struct smu_context *smu = handle;
 	enum smu_clk_type clk_type;
 
 	switch (type) {
@@ -2424,12 +2421,50 @@ static int smu_print_ppclk_levels(void *handle,
 	case OD_CCLK:
 		clk_type = SMU_OD_CCLK; break;
 	default:
-		return -EINVAL;
+		clk_type = SMU_CLK_COUNT; break;
 	}
 
+	return clk_type;
+}
+
+static int smu_print_ppclk_levels(void *handle,
+				  enum pp_clock_type type,
+				  char *buf)
+{
+	struct smu_context *smu = handle;
+	enum smu_clk_type clk_type;
+
+	clk_type = smu_convert_to_smuclk(type);
+	if (clk_type == SMU_CLK_COUNT)
+		return -EINVAL;
+
 	return smu_print_smuclk_levels(smu, clk_type, buf);
 }
 
+static int smu_emit_ppclk_levels(void *handle, enum pp_clock_type type, char *buf, int *offset)
+{
+	struct smu_context *smu = handle;
+	enum smu_clk_type clk_type;
+	int ret = 0;
+
+	clk_type = smu_convert_to_smuclk(type);
+	if (clk_type == SMU_CLK_COUNT)
+		return -EINVAL;
+
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
+	if (smu->ppt_funcs->emit_clk_levels) {
+		ret = smu->ppt_funcs->emit_clk_levels(smu, clk_type, buf, offset);
+	}
+	else {
+		ret = -EOPNOTSUPP;
+	}
+
+	return ret;
+
+}
+
 static int smu_od_edit_dpm_table(void *handle,
 				 enum PP_OD_DPM_TABLE_COMMAND type,
 				 long *input, uint32_t size)
@@ -3107,6 +3142,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.get_fan_speed_pwm   = smu_get_fan_speed_pwm,
 	.force_clock_level       = smu_force_ppclk_levels,
 	.print_clock_levels      = smu_print_ppclk_levels,
+	.emit_clock_levels       = smu_emit_ppclk_levels,
 	.force_performance_level = smu_force_performance_level,
 	.read_sensor             = smu_read_sensor,
 	.get_performance_level   = smu_get_performance_level,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 3fdab6a44901..224b869eda70 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -615,6 +615,16 @@ struct pptable_funcs {
 	 */
 	int (*print_clk_levels)(struct smu_context *smu, enum smu_clk_type clk_type, char *buf);
 
+	/**
+	 * @emit_clk_levels: Print DPM clock levels for a clock domain
+	 *                    to buffer using sysfs_emit_at. Star current level.
+	 *
+	 * Used for sysfs interfaces.
+	 * &buf: sysfs buffer
+	 * &offset: offset within buffer to start printing
+	 */
+	int (*emit_clk_levels)(struct smu_context *smu, enum smu_clk_type clk_type, char *buf, int *offset);
+
 	/**
 	 * @force_clk_levels: Set a range of allowed DPM levels for a clock
 	 *                    domain.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 37e11716e919..50022de5337f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1261,6 +1261,194 @@ static void navi10_od_setting_get_range(struct smu_11_0_overdrive_table *od_tabl
 		*max = od_table->max[setting];
 }
 
+static int navi10_emit_clk_levels(struct smu_context *smu,
+			enum smu_clk_type clk_type, char *buf, int *offset)
+{
+	uint16_t *curve_settings;
+	int ret = 0;
+	uint32_t cur_value = 0, value = 0;
+	uint32_t freq_values[3] = {0};
+	uint32_t i, levels, mark_index = 0, count = 0;
+	struct smu_table_context *table_context = &smu->smu_table;
+	uint32_t gen_speed, lane_width;
+	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+	struct smu_11_0_dpm_context *dpm_context = smu_dpm->dpm_context;
+	PPTable_t *pptable = (PPTable_t *)table_context->driver_pptable;
+	OverDriveTable_t *od_table =
+		(OverDriveTable_t *)table_context->overdrive_table;
+	struct smu_11_0_overdrive_table *od_settings = smu->od_settings;
+	uint32_t min_value, max_value;
+	int save_offset = *offset;
+
+	switch (clk_type) {
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+	case SMU_SOCCLK:
+	case SMU_MCLK:
+	case SMU_UCLK:
+	case SMU_FCLK:
+	case SMU_VCLK:
+	case SMU_DCLK:
+	case SMU_DCEFCLK:
+		ret = navi10_get_current_clk_freq_by_table(smu, clk_type, &cur_value);
+		if (ret)
+			return 0;
+
+		ret = smu_v11_0_get_dpm_level_count(smu, clk_type, &count);
+		if (ret)
+			return 0;
+
+		if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
+			for (i = 0; i < count; i++) {
+				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
+				if (ret)
+					return (*offset - save_offset);
+
+				*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n", i, value,
+						cur_value == value ? "*" : "");
+
+			}
+		} else {
+			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_values[0]);
+			if (ret)
+				return 0;
+			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_values[2]);
+			if (ret)
+				return 0;
+
+			freq_values[1] = cur_value;
+			mark_index = cur_value == freq_values[0] ? 0 :
+				     cur_value == freq_values[2] ? 2 : 1;
+
+			levels = 3;
+			if (mark_index != 1) {
+				levels = 2;
+				freq_values[1] = freq_values[2];
+			}
+
+			for (i = 0; i < levels; i++) {
+				*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n", i, freq_values[i],
+						i == mark_index ? "*" : "");
+			}
+		}
+		break;
+	case SMU_PCIE:
+		gen_speed = smu_v11_0_get_current_pcie_link_speed_level(smu);
+		lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
+		for (i = 0; i < NUM_LINK_LEVELS; i++) {
+			*offset += sysfs_emit_at(buf, *offset, "%d: %s %s %dMhz %s\n", i,
+					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 0) ? "2.5GT/s," :
+					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 1) ? "5.0GT/s," :
+					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 2) ? "8.0GT/s," :
+					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 3) ? "16.0GT/s," : "",
+					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 1) ? "x1" :
+					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 2) ? "x2" :
+					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 3) ? "x4" :
+					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 4) ? "x8" :
+					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 5) ? "x12" :
+					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 6) ? "x16" : "",
+					pptable->LclkFreq[i],
+					(gen_speed == dpm_context->dpm_tables.pcie_table.pcie_gen[i]) &&
+					(lane_width == dpm_context->dpm_tables.pcie_table.pcie_lane[i]) ?
+					"*" : "");
+		}
+		break;
+	case SMU_OD_SCLK:
+		if (!smu->od_enabled || !od_table || !od_settings)
+			break;
+		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_LIMITS))
+			break;
+		*offset += sysfs_emit_at(buf, *offset, "OD_SCLK:\n0: %uMhz\n1: %uMhz\n",
+					  od_table->GfxclkFmin, od_table->GfxclkFmax);
+		break;
+	case SMU_OD_MCLK:
+		if (!smu->od_enabled || !od_table || !od_settings)
+			break;
+		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_UCLK_MAX))
+			break;
+		*offset += sysfs_emit_at(buf, *offset, "OD_MCLK:\n1: %uMHz\n", od_table->UclkFmax);
+		break;
+	case SMU_OD_VDDC_CURVE:
+		if (!smu->od_enabled || !od_table || !od_settings)
+			break;
+		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_CURVE))
+			break;
+		*offset += sysfs_emit_at(buf, *offset, "OD_VDDC_CURVE:\n");
+		for (i = 0; i < 3; i++) {
+			switch (i) {
+			case 0:
+				curve_settings = &od_table->GfxclkFreq1;
+				break;
+			case 1:
+				curve_settings = &od_table->GfxclkFreq2;
+				break;
+			case 2:
+				curve_settings = &od_table->GfxclkFreq3;
+				break;
+			default:
+				break;
+			}
+			*offset += sysfs_emit_at(buf, *offset, "%d: %uMHz %umV\n",
+						  i, curve_settings[0],
+					curve_settings[1] / NAVI10_VOLTAGE_SCALE);
+		}
+		break;
+	case SMU_OD_RANGE:
+		if (!smu->od_enabled || !od_table || !od_settings)
+			break;
+		*offset += sysfs_emit_at(buf, *offset, "%s:\n", "OD_RANGE");
+
+		if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_LIMITS)) {
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_GFXCLKFMIN,
+						    &min_value, NULL);
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_GFXCLKFMAX,
+						    NULL, &max_value);
+			*offset+= sysfs_emit_at(buf, *offset, "SCLK: %7uMhz %10uMhz\n",
+					min_value, max_value);
+		}
+
+		if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_UCLK_MAX)) {
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_UCLKFMAX,
+						    &min_value, &max_value);
+			*offset+= sysfs_emit_at(buf, *offset, "MCLK: %7uMhz %10uMhz\n",
+					min_value, max_value);
+		}
+
+		if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_CURVE)) {
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P1,
+						    &min_value, &max_value);
+			*offset += sysfs_emit_at(buf, *offset, "VDDC_CURVE_SCLK[0]: %7uMhz %10uMhz\n",
+					      min_value, max_value);
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P1,
+						    &min_value, &max_value);
+			*offset += sysfs_emit_at(buf, *offset, "VDDC_CURVE_VOLT[0]: %7dmV %11dmV\n",
+					      min_value, max_value);
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P2,
+						    &min_value, &max_value);
+			*offset += sysfs_emit_at(buf, *offset, "VDDC_CURVE_SCLK[1]: %7uMhz %10uMhz\n",
+					      min_value, max_value);
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P2,
+						    &min_value, &max_value);
+			*offset += sysfs_emit_at(buf, *offset, "VDDC_CURVE_VOLT[1]: %7dmV %11dmV\n",
+					      min_value, max_value);
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P3,
+						    &min_value, &max_value);
+			*offset += sysfs_emit_at(buf, *offset, "VDDC_CURVE_SCLK[2]: %7uMhz %10uMhz\n",
+					      min_value, max_value);
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P3,
+						    &min_value, &max_value);
+			*offset += sysfs_emit_at(buf, *offset, "VDDC_CURVE_VOLT[2]: %7dmV %11dmV\n",
+					      min_value, max_value);
+		}
+
+		break;
+	default:
+		break;
+	}
+
+	return (*offset - save_offset);
+}
+
 static int navi10_print_clk_levels(struct smu_context *smu,
 			enum smu_clk_type clk_type, char *buf)
 {
@@ -3238,6 +3426,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.i2c_init = navi10_i2c_control_init,
 	.i2c_fini = navi10_i2c_control_fini,
 	.print_clk_levels = navi10_print_clk_levels,
+	.emit_clk_levels = navi10_emit_clk_levels,
 	.force_clk_levels = navi10_force_clk_levels,
 	.populate_umd_state_clk = navi10_populate_umd_state_clk,
 	.get_clock_by_type_with_latency = navi10_get_clock_by_type_with_latency,
-- 
2.34.1

