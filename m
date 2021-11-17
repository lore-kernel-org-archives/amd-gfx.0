Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7866EC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 06:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26D3761BFA
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 06:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 26D3761BFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D095E6E2C7;
	Wed, 17 Nov 2021 06:21:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4796C6E2C7
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 06:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bx54e+Fx5xWhl4fXX9+K9PugqLHHd/ViipgLOlrOyecAuVvNww/vbbHJnRQx4Myy14HQBcEqPxkTMc+ILP5eqSNmN4e1UVKVqNVZqHL7dL1AU6T2xTozjDHnk3x+w3bkgJRAsSHQ3JS/lO46Ah1YJlKkwODbek1vF3KXMWskB7E0V+JM3gFkYKvcB/52DR0XYQDfBINvj8tvA2n4qrVKjM2vJvWien8dXs2pkvp1rGxCQmUbQS22AIGJz4QtcYtK/zQE1aT805Os792yZrHdKILJIl/wgSvrV6EHLmArtoiP3quBpFL8SRvzLqa3xUh1x+Cj/tRmxcTiuGnyB/3Xmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rV9I6PAsD/cGADJjhIb+SjT9+Occl8de9xVRiXkcTOQ=;
 b=HkqJaCwh+ByWL9kIZ/uc3rDN6AZ1vNotzKVCbXd8KSIo6bpOL9KQqdghEWHnmJVPvuZTPAyPzCQJu8ssAqJa8enuarweNkEzhT+IEwrr8EqVSjRZoPXPvwUDJbAJbha/2fEdoBe9jsL3wN2ziUQjDs+uyQnZGQNtIPQaqcCyc8S0nRo7IlZcjUAanzwxDq1EKLIvHmYfC4DWhGb8oSxWZfZG+MN63FYH+VEnp+guGMOg+Q+pKzwIYMxe6nbDbFu1OozlJOgCmHGbs3EWMTdIMW1VFNE/TFPqt501adIGLSDrGcup84PN74yzx6cGKWAGCczFAZVAZTNd0dzx13JprA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rV9I6PAsD/cGADJjhIb+SjT9+Occl8de9xVRiXkcTOQ=;
 b=VZ/KPRmJdv0li3OJcQFR4uYkBbOpDUF+CFQ1KDwJ+zrMetUmS+njREg3l9fAbKrkqWcaDY8ooTkL2mbrLOcaVLd6PHXeG4c9dzhs3KG+s9x8Vf9GePb6RvvM9bXOrgo0e5ONZVg61kdiYBy4MiSlrQglgdvn6KbCl+8wfuQPghg=
Received: from BN0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:408:e6::16)
 by BN6PR12MB1524.namprd12.prod.outlook.com (2603:10b6:405:4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Wed, 17 Nov
 2021 06:21:39 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::7e) by BN0PR03CA0011.outlook.office365.com
 (2603:10b6:408:e6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Wed, 17 Nov 2021 06:21:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 17 Nov 2021 06:21:39 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 17 Nov 2021 00:21:35 -0600
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] amdgpu/pm: restructure reporting of clock values by smu
Date: Wed, 17 Nov 2021 01:20:44 -0500
Message-ID: <20211117062044.4752-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6cc38fa-385a-4ba2-f08c-08d9a99283e0
X-MS-TrafficTypeDiagnostic: BN6PR12MB1524:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1524753BE9FADF70C065A112F09A9@BN6PR12MB1524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:51;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cN1vlfku7Cj55X9YlOes52w40t/Hm0gEaVMwI6oozTolTG8CjbqCVaURkqKhOiOslJdif+Cxn35f1v90stn69uvr8mZlKybAFkzrfqX5fxDN4yOIfWOUPJbzkXeAzouuyDbBBkkETQp1rxefZwpZxP+Us1nFqr4AWm5PXpHynoXVIgPW1FedHtxYXIAv+GtOEr4yZ07FIRBLXAWnjVN2Hhs5NcAdDYQoBTai3AV5q5OOOxlLAfSoHChhERHCKxjzaVM1k0RLvFKOwETqkEZg+m+JA7iXtHfKx7cOtvaPcD4wAGREIBLxL+/F3RNC5yWSBuf5Q7OykS7Eu96Fe9GipVESnkOTxM87i7ROnIyy/hO8jFgSBlrnS/TEnbLNX3PT+VGd96okI+8SVoBvZdbJO+mxXR77CGL9G15D5Fcs0UKMg3tJa50Gua6ZShQ94bs2G1ilk6hCevoQ/lNA6VVbwQqWljTQT+3rdhFJOQoqQPYyhR86myK5yz6FTOhnCPxeMU5TcAVZPQKQ3/HrtWgGs8mnKn7FPSdXCVmx15jgXi5f6ivuAE7BgPyOS6MEEW34nWGoWrxafIZIv9Mhs0hbWX/T6Kzu7q4qSu8jhgxve9gfV4nMWAcjgt3+p5px1/iZQRoXPTm4jCTl2j/+tb9Cm1HZpW0OjlI8Hcmwrr+fKKXtSDFurDCT8IMDwtpXW5XXiyViDCY1hDj4sEH9aMnEaj8lsorfCT4S9Ovhr2PW89U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(1076003)(26005)(5660300002)(8676002)(356005)(86362001)(8936002)(47076005)(4326008)(186003)(16526019)(30864003)(6916009)(70206006)(70586007)(2616005)(44832011)(2906002)(36860700001)(81166007)(82310400003)(336012)(83380400001)(6666004)(36756003)(426003)(316002)(7696005)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 06:21:39.2082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6cc38fa-385a-4ba2-f08c-08d9a99283e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1524
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

 Use of sysfs_emit by each of the specific device implementations is problematic.
 To remove this back to a higher level, this patch adds a new function "get_clock_levels"
 to the power-management API (amd_pm_funcs) and smu powerplay API (pptable_funcs). The
 function returns an array of values to the power management module, which can then
 interpret the array and print the values at the top layer.
 This patch is only implemented for navi10 for some clocks to seek comment on the
 implementation before extending the implementation to other clock values and devices.

 == Changes ==
  - new power management function get_clock_levels implemented by smu_get_ppclk_levels()
  - new power management function amdgpu_dpm_print_clock_array to print most common clock
       list, which can be later extended to use different units (currently only MHz), or
       other functions added to handle more complex structure (eg pcie clocks)
  - new powerplay function get_clk_levels implemented by navi10_get_clk_levels()
  - new helper function smu_convert_to_smuclk called by smu_print_ppclk_levels and
       smu_get_ppclk_levels
  - new error return value -EOPNOTSUPP for clock levels not recognized, allowing fallback
       to print_clock_levels. (NOTE: If pm or dpm not enabled current implementation will
       try and fail with both methods)
  - new error return value -EINVAL for unsupported clock level
  - new error messages output for error conditions encountered at the device specific layer
       which can be removed if suggested

 == Test ==
 LOGFILE=sysfs_emit.test.log
 cd ~/workspace/linux
 cp ${LOGFILE}{,.old}

 AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
 AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{print $9}'`
 HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}

 lspci -nn | grep "VGA\|Display"  > $LOGFILE
 FILES="pp_dpm_sclk
 pp_dpm_pcie
 "

 for f in $FILES
 do
   echo === $f === >> $LOGFILE
   cat $HWMON_DIR/device/$f >> $LOGFILE
 done
 cat $LOGFILE

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 41 +++++++-
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  9 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 53 +++++++++-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 96 +++++++++++++++++++
 5 files changed, 192 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index bac15c466733..fbe045811e60 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -310,6 +310,8 @@ struct amd_pm_funcs {
 	int (*get_fan_speed_pwm)(void *handle, u32 *speed);
 	int (*force_clock_level)(void *handle, enum pp_clock_type type, uint32_t mask);
 	int (*print_clock_levels)(void *handle, enum pp_clock_type type, char *buf);
+	int (*get_clock_levels)(void *handle, enum pp_clock_type type,
+				uint32_t *clock_list, uint max_list_length);
 	int (*force_performance_level)(void *handle, enum amd_dpm_forced_level level);
 	int (*get_sclk_od)(void *handle);
 	int (*set_sclk_od)(void *handle, uint32_t value);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 41472ed99253..ca7a6779e59b 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1020,6 +1020,23 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
 	return size;
 }
 
+static int amdgpu_dpm_print_clock_array(enum pp_clock_type type,
+					char *buf,
+					uint32_t *clock_list, uint list_length) {
+
+	uint i;
+	int size = 0;
+
+	for (i = 1; i < list_length; i++) {
+		size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, clock_list[i],
+				clock_list[i] == clock_list[0] ? "*" : "");
+	}
+
+
+	return size;
+}
+
+
 /**
  * DOC: pp_dpm_sclk pp_dpm_mclk pp_dpm_socclk pp_dpm_fclk pp_dpm_dcefclk pp_dpm_pcie
  *
@@ -1058,6 +1075,7 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	ssize_t size;
 	int ret;
+	uint32_t clock_list[8];
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
@@ -1070,10 +1088,24 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
 		return ret;
 	}
 
-	if (adev->powerplay.pp_funcs->print_clock_levels)
-		size = amdgpu_dpm_print_clock_levels(adev, type, buf);
-	else
-		size = sysfs_emit(buf, "\n");
+	if (adev->powerplay.pp_funcs->get_clock_levels) {
+		ret = adev->powerplay.pp_funcs->get_clock_levels(
+					adev->powerplay.pp_handle, type, clock_list, 8);
+
+		if (ret > 0)
+			size = amdgpu_dpm_print_clock_array(type, buf, clock_list, ret);
+	}
+	else {
+		ret = -EOPNOTSUPP;
+	}
+
+	if  (ret == -EOPNOTSUPP)  {
+		if (adev->powerplay.pp_funcs->print_clock_levels) {
+			size = amdgpu_dpm_print_clock_levels(adev, type, buf);
+		}
+		else
+			size = sysfs_emit(buf, "\n");
+	}
 
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
@@ -1159,6 +1191,7 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
+	dev_warn(dev, " %s ENTRY", __func__);
 	return amdgpu_get_pp_dpm_clock(dev, PP_SCLK, buf);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 3557f4e7fc30..d8c20a134475 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -610,6 +610,15 @@ struct pptable_funcs {
 	 */
 	int (*print_clk_levels)(struct smu_context *smu, enum smu_clk_type clk_type, char *buf);
 
+	/**
+	 * @get_clk_levels: Get array DPM clock levels for a clock domain
+	 *                    to array clock_list. current level is first element.
+	 *
+	 * Used for sysfs interfaces.
+	 */
+	int (*get_clk_levels)(struct smu_context *smu, enum smu_clk_type clk_type,
+			      uint32_t *clock_list, uint max_list_length);
+
 	/**
 	 * @force_clk_levels: Set a range of allowed DPM levels for a clock
 	 *                    domain.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 01168b8955bf..2de566118422 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2395,11 +2395,8 @@ static int smu_print_smuclk_levels(struct smu_context *smu, enum smu_clk_type cl
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
@@ -2432,12 +2429,57 @@ static int smu_print_ppclk_levels(void *handle,
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
 
+static int smu_get_ppclk_levels(void *handle,
+				enum pp_clock_type type,
+				uint32_t *clock_list, uint max_list_length)
+{
+	struct smu_context *smu = handle;
+	enum smu_clk_type clk_type;
+	int ret = 0;
+
+	clk_type = smu_convert_to_smuclk(type);
+	if (clk_type == SMU_CLK_COUNT)
+		return -EINVAL;
+
+
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
+
+	if (smu->ppt_funcs->get_clk_levels) {
+
+		mutex_lock(&smu->mutex);
+		ret = smu->ppt_funcs->get_clk_levels(smu, clk_type, clock_list, max_list_length);
+		mutex_unlock(&smu->mutex);
+	}
+	else {
+		ret = -EOPNOTSUPP;
+	}
+
+
+	return ret;
+}
+
 static int smu_od_edit_dpm_table(void *handle,
 				 enum PP_OD_DPM_TABLE_COMMAND type,
 				 long *input, uint32_t size)
@@ -3100,6 +3142,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.set_fan_speed_pwm   = smu_set_fan_speed_pwm,
 	.get_fan_speed_pwm   = smu_get_fan_speed_pwm,
 	.force_clock_level       = smu_force_ppclk_levels,
+	.get_clock_levels        = smu_get_ppclk_levels,
 	.print_clock_levels      = smu_print_ppclk_levels,
 	.force_performance_level = smu_force_performance_level,
 	.read_sensor             = smu_read_sensor,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 71161f6b78fe..55e6880c2964 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1261,6 +1261,101 @@ static void navi10_od_setting_get_range(struct smu_11_0_overdrive_table *od_tabl
 		*max = od_table->max[setting];
 }
 
+static int navi10_get_clk_levels(struct smu_context *smu,
+				 enum smu_clk_type clk_type,
+				 uint32_t *clock_list, uint max_list_length)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int size = 0, ret = 0;
+	uint32_t cur_value = 0, value = 0, count = 0, i;
+	uint32_t freq_values[3] = {0};
+	uint32_t mark_index = 0;
+
+	switch (clk_type) {
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+	case SMU_SOCCLK:
+	case SMU_MCLK:
+	case SMU_UCLK:
+	case SMU_FCLK:
+	case SMU_VCLK:
+	case SMU_DCEFCLK:
+	case SMU_DCLK:
+		ret = navi10_get_current_clk_freq_by_table(smu, clk_type, &cur_value);
+		if (ret) {
+			dev_err(adev->dev, " %s Unable to retrieve clk freq : %u", __func__, clk_type);
+			return -EIO;
+		}
+
+		ret = smu_v11_0_get_dpm_level_count(smu, clk_type, &count);
+		if (ret) {
+			dev_err(adev->dev, " %s Unable to retrieve clk count : %u", __func__, clk_type);
+			return -EIO;
+		}
+
+		if (count > max_list_length-1) {
+			dev_err(adev->dev, " %s Too many clock values", __func__);
+			return -EPERM;
+		}
+
+
+		clock_list[0] = cur_value;
+		if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
+			for (i = 0; i < count; i++) {
+				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
+				if (ret) {
+					dev_err(adev->dev, " %s Unable to retrieve clk freq : %u", __func__, clk_type);
+					return -EIO;
+				}
+
+				clock_list[i+1] = value;
+			}
+			size = count+1;
+		} else {
+			// for fine-grained dpm, display cur_value as average of max and min
+			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_values[0]);
+			if (ret) {
+				dev_err(adev->dev, " %s Unable to retrieve clk freq : %u", __func__, clk_type);
+				return -EIO;
+			}
+			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_values[2]);
+			if (ret) {
+				dev_err(adev->dev, " %s Unable to retrieve clk freq : %u", __func__, clk_type);
+				return -EIO;
+			}
+
+			freq_values[1] = cur_value;
+			mark_index = cur_value == freq_values[0] ? 0 :
+				     cur_value == freq_values[2] ? 2 : 1;
+			if (mark_index != 1)
+				freq_values[1] = (freq_values[0] + freq_values[2]) / 2;
+
+			clock_list[0] = freq_values[1];
+			for (i = 0; i < 3; i++) {
+				clock_list[i+1] = freq_values[i];
+			}
+
+			size = 3+1;
+		}
+		break;
+	case SMU_PCIE:
+	case SMU_OD_SCLK:
+	case SMU_OD_MCLK:
+	case SMU_OD_VDDC_CURVE:
+	case SMU_OD_RANGE:
+		dev_warn(adev->dev, " %s Unhandled clk_type : %u", __func__, clk_type);
+		size = -EOPNOTSUPP;
+		break;
+
+	default:
+		dev_err(adev->dev, " %s Unknown clk_type : %u", __func__, clk_type);
+		size = -EINVAL;
+		break;
+	}
+
+	return size;
+}
+
 static int navi10_print_clk_levels(struct smu_context *smu,
 			enum smu_clk_type clk_type, char *buf)
 {
@@ -3241,6 +3336,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.dpm_set_jpeg_enable = navi10_dpm_set_jpeg_enable,
 	.i2c_init = navi10_i2c_control_init,
 	.i2c_fini = navi10_i2c_control_fini,
+	.get_clk_levels = navi10_get_clk_levels,
 	.print_clk_levels = navi10_print_clk_levels,
 	.force_clk_levels = navi10_force_clk_levels,
 	.populate_umd_state_clk = navi10_populate_umd_state_clk,

base-commit: eabeb4f20a0786188fba07a2dd1b0a614c4e15f6
-- 
2.33.1

