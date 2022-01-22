Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5489C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Jan 2022 03:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B7B10E372;
	Sat, 22 Jan 2022 03:47:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AD8410E389
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Jan 2022 03:47:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYb1ndj0SyZ1AwskP6ukz6cpzmtsMpMTMZP0sTjyEeXLm9u3tt9FUCXf/+zNwZtvY33JiWrpbgvqI3BZmjdwFT8TRQIOsWG2PnsYYJeONQ4wHA/ZvHIi6e0+2lhGVA4XdzHdd9b/rxM5UlmAJDFDCVEpIY3pLSRkYuIKxAHGO5GajOSWs4EA/9oqhdUXbzdQBSeto6NjVw4dAsuyyuHpMTnWjlxIQKW+3Gqhf3/d/VA/hPxQ8k3waxl9+tcZ+lY0MmyKRYrF/7O8kEnwj1HlcTIs8f/wgspuAQ7tSKhH6XDAsGVwJxHghxKfXvW+8g8g47nq2vs6hB/xL4nCXqXpFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMxtN9Ks5Se1axgcG6HN4yhraHU0ZzqydBJH3vKmB4I=;
 b=h/DvVRvEjsTSGvqX8zaApIoja/LGQvIWroeDHLOIGXsIGa8AvWCtJmhZqvuOL0XkTfc3XnAuJdPpkok1pAx0cG3+Y7m1Pf2uJIhRMS2fVKI2iPN+SKZmP1cmsg+hoKn9mA+IM8qLGGqaU7cZVwDpB6E3iBA+m2546Pj+gkWYwcQS1vIDngJRqEUEl47NJor0BX//m7BFcJ6b+xhs4aEuEFvNbdnDS85dBZLQPZryT+M+ZuOq9Ev0ExGdM3cwGNlwp473cupwxaS11T7qPTtKgE6rQ8kY4lkDfE5SBnskHaFxyZnYzysWzyITtCF4lLCdEKXwnMAYaDX0y0ug8OHIhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMxtN9Ks5Se1axgcG6HN4yhraHU0ZzqydBJH3vKmB4I=;
 b=pLCoqjbWD275rhOHD0eami9scAH4pOYbZNVKeWyy+uE+OB5swFmNYIxmQw1NqRlfVa00Jgxkwg1zMwzQ9V+QJpr+jw4M7M+INIjmUj8co1c3ehFpco5cUOrJ6PTcQRRXNj85DoeR+U7J8yHjFpf+gzrq6tNTZx4p9lBE0t3I50E=
Received: from BN9PR03CA0900.namprd03.prod.outlook.com (2603:10b6:408:13c::35)
 by BN6PR12MB1843.namprd12.prod.outlook.com (2603:10b6:404:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Sat, 22 Jan
 2022 03:47:14 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::32) by BN9PR03CA0900.outlook.office365.com
 (2603:10b6:408:13c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12 via Frontend
 Transport; Sat, 22 Jan 2022 03:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sat, 22 Jan 2022 03:47:14 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 21 Jan 2022 21:47:13 -0600
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] amdgpu/pm: Add Error Handling to emit_clocks stack
Date: Fri, 21 Jan 2022 22:46:47 -0500
Message-ID: <20220122034647.67925-4-darren.powell@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f40f5fe8-4f3e-4154-4f71-08d9dd59e0f5
X-MS-TrafficTypeDiagnostic: BN6PR12MB1843:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1843DBDF2078E56D5F546497F05C9@BN6PR12MB1843.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3vj30nebkEbPcX40TtpENkgd4jBPwL85pjzS0WTXj1kEWp6wfolKRhI9iSKQYPs/d+h156hz+r0Xsv7xqQs8HljX7la63SzZVbYLJ2Pjn250qf1OEa9EwRwycGb9CaIVKNdQ6t/c2HilnmsDhidue3tV+j5RyS4yzTzuGMyAkbK2eqZOZuvz2PPJ7gGZDnSpsZ2dbV2IGGSCQj6iiksdfbw4hIBZ2XZV6RPAnu/htbwNSXQsHxqWRZyrXLiy09MEVulDbc1I4x+axxrdlZ41DsrNzcoYA7s7G1wjRnCjjwccu91J7E64ySczdoNPjWDG5s5FGiWUN5hgC/FelizVH1BqxYJ2PNV2O4296d2NPFdLGpcpPWyoVzH+AWPAnf9jyw7WsPmWgshDyZmF7YVWL0gGK+FQXHVrvyQa3pSXVGe9MJnSa02S6t08AaHZHdCC6eFr//FtUPm6wXilIG5KI0fRqJnjPhKkZigHkgaUeqpfLHSqiUJlyk3w6HIrY8R0zyQimPsvB2j0QE5PediOlHTyKexecR9OaXIjsh8arolqi1s08ThmZso7iqsUIUOSVrV96VFJBRAzcFFLnaH32YYgt45Vl9yM42kuM6ThFoRQRXTbPK7g4FfsLxK18Scss5SKs6U8vNkTSuYd1DU2FHhPeMBv5fNNx9Df7E3hzi0SABtsk3WXLEy+s8TdeTktQ2g+5LEWQc5JzoyLHLECZ+w6b+8z97iS16xyGcqR37sDb2o2KShVRDT2UqJAdgJXjhGXkAdbNxsGQH2HmSU1+sqbufDPa4aPeoVvT8pNykw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700004)(36840700001)(46966006)(70586007)(6666004)(47076005)(26005)(336012)(82310400004)(81166007)(40460700003)(5660300002)(356005)(86362001)(1076003)(36860700001)(44832011)(36756003)(4326008)(508600001)(6916009)(316002)(8676002)(426003)(2906002)(8936002)(70206006)(186003)(16526019)(83380400001)(7696005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2022 03:47:14.5167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f40f5fe8-4f3e-4154-4f71-08d9dd59e0f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1843
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

 Previous implementation of print_clocks required return of bytes written
 to calling function via return value. Passing this value in by reference
 allows us now to pass back error codes up the calling stack.

 (v1)
 - Errors from get_current_clk_freq, get_dpm_level_count & get_dpm_freq
      now passed back up the stack
 - Added -EOPNOTSUPP when encountering for OD clocks
      !od_enabled
      missing od_table or od_settings
 - OD_RANGE continues to print any subset of the ODCAP settings it can find
      without reporting error for any missing
 - smu_emit_ppclk returns ENOENT if emit_clk_levels is not supported by the
      device
 - modified calling logic so fallback to print_clock_levels is only attempted
      if emit_clk_levels is not (yet) supported by the device

 (v2)
 - change return from amdgpu_dpm_emit_clock_levels if emit_clock_levels not found
 - updated documentation of pptable_func members print_clk_levels, emit_clk_levels

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
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  2 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 13 ++++++------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  8 +++----
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  6 +++++-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 21 +++++++++----------
 5 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index e45578124928..03a690a3abb7 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -915,7 +915,7 @@ int amdgpu_dpm_emit_clock_levels(struct amdgpu_device *adev,
 	int ret = 0;
 
 	if (!pp_funcs->emit_clock_levels)
-		return 0;
+		return -ENOENT;
 
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->emit_clock_levels(adev->powerplay.pp_handle,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 97a8dcbe6eaf..a11def0ee761 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -855,13 +855,12 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 		return ret;
 	}
 
-	ret = amdgpu_dpm_emit_clock_levels(adev, od_clocks[0], buf, &size);
-	if (ret >= 0) {
-		/* Proceed with emit for other od clocks if the first call succeeds */
-		for(clk_index = 1 ; clk_index < 6 ; clk_index++)
-			amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, &size);
+	for(clk_index = 0 ; clk_index < 6 ; clk_index++) {
+		ret = amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, &size);
+		if (ret)
+			break;
 	}
-	else {
+	if (ret == -ENOENT) {
 		size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
 		if (size > 0) {
 			size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK, buf+size);
@@ -1014,7 +1013,7 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
 	}
 
 	ret = amdgpu_dpm_emit_clock_levels(adev, type, buf, &size);
-	if (ret < 0)
+	if (ret == -ENOENT)
 		size = amdgpu_dpm_print_clock_levels(adev, type, buf);
 
 	if (size == 0)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index d82ea7ee223f..29c101a93dc4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2454,12 +2454,10 @@ static int smu_emit_ppclk_levels(void *handle, enum pp_clock_type type, char *bu
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	if (smu->ppt_funcs->emit_clk_levels) {
+	if (smu->ppt_funcs->emit_clk_levels)
 		ret = smu->ppt_funcs->emit_clk_levels(smu, clk_type, buf, offset);
-	}
-	else {
-		ret = -EOPNOTSUPP;
-	}
+	else
+		ret = -ENOENT;
 
 	return ret;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 224b869eda70..1429581dca9c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -612,6 +612,7 @@ struct pptable_funcs {
 	 *                    to buffer. Star current level.
 	 *
 	 * Used for sysfs interfaces.
+	 * Return: Number of characters written to the buffer
 	 */
 	int (*print_clk_levels)(struct smu_context *smu, enum smu_clk_type clk_type, char *buf);
 
@@ -621,7 +622,10 @@ struct pptable_funcs {
 	 *
 	 * Used for sysfs interfaces.
 	 * &buf: sysfs buffer
-	 * &offset: offset within buffer to start printing
+	 * &offset: offset within buffer to start printing, which is updated by the
+	 * function.
+	 *
+	 * Return: 0 on Success or Negative to indicate an error occurred.
 	 */
 	int (*emit_clk_levels)(struct smu_context *smu, enum smu_clk_type clk_type, char *buf, int *offset);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 50022de5337f..4bcef7d1a0d6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1278,7 +1278,6 @@ static int navi10_emit_clk_levels(struct smu_context *smu,
 		(OverDriveTable_t *)table_context->overdrive_table;
 	struct smu_11_0_overdrive_table *od_settings = smu->od_settings;
 	uint32_t min_value, max_value;
-	int save_offset = *offset;
 
 	switch (clk_type) {
 	case SMU_GFXCLK:
@@ -1292,17 +1291,17 @@ static int navi10_emit_clk_levels(struct smu_context *smu,
 	case SMU_DCEFCLK:
 		ret = navi10_get_current_clk_freq_by_table(smu, clk_type, &cur_value);
 		if (ret)
-			return 0;
+			return ret;
 
 		ret = smu_v11_0_get_dpm_level_count(smu, clk_type, &count);
 		if (ret)
-			return 0;
+			return ret;
 
 		if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
 			for (i = 0; i < count; i++) {
 				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
 				if (ret)
-					return (*offset - save_offset);
+					return ret;
 
 				*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n", i, value,
 						cur_value == value ? "*" : "");
@@ -1311,10 +1310,10 @@ static int navi10_emit_clk_levels(struct smu_context *smu,
 		} else {
 			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_values[0]);
 			if (ret)
-				return 0;
+				return ret;
 			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_values[2]);
 			if (ret)
-				return 0;
+				return ret;
 
 			freq_values[1] = cur_value;
 			mark_index = cur_value == freq_values[0] ? 0 :
@@ -1355,7 +1354,7 @@ static int navi10_emit_clk_levels(struct smu_context *smu,
 		break;
 	case SMU_OD_SCLK:
 		if (!smu->od_enabled || !od_table || !od_settings)
-			break;
+			return -EOPNOTSUPP;
 		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_LIMITS))
 			break;
 		*offset += sysfs_emit_at(buf, *offset, "OD_SCLK:\n0: %uMhz\n1: %uMhz\n",
@@ -1363,14 +1362,14 @@ static int navi10_emit_clk_levels(struct smu_context *smu,
 		break;
 	case SMU_OD_MCLK:
 		if (!smu->od_enabled || !od_table || !od_settings)
-			break;
+			return -EOPNOTSUPP;
 		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_UCLK_MAX))
 			break;
 		*offset += sysfs_emit_at(buf, *offset, "OD_MCLK:\n1: %uMHz\n", od_table->UclkFmax);
 		break;
 	case SMU_OD_VDDC_CURVE:
 		if (!smu->od_enabled || !od_table || !od_settings)
-			break;
+			return -EOPNOTSUPP;
 		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_CURVE))
 			break;
 		*offset += sysfs_emit_at(buf, *offset, "OD_VDDC_CURVE:\n");
@@ -1395,7 +1394,7 @@ static int navi10_emit_clk_levels(struct smu_context *smu,
 		break;
 	case SMU_OD_RANGE:
 		if (!smu->od_enabled || !od_table || !od_settings)
-			break;
+			return -EOPNOTSUPP;
 		*offset += sysfs_emit_at(buf, *offset, "%s:\n", "OD_RANGE");
 
 		if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_LIMITS)) {
@@ -1446,7 +1445,7 @@ static int navi10_emit_clk_levels(struct smu_context *smu,
 		break;
 	}
 
-	return (*offset - save_offset);
+	return 0;
 }
 
 static int navi10_print_clk_levels(struct smu_context *smu,
-- 
2.34.1

