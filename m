Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E37EC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 06:37:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0516E6E97D;
	Wed,  8 Dec 2021 06:37:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 315756E956
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 06:37:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nr3239/mnVqnOerxNMZoxoLm+TfKeaANPFdHjsqTooRUutvEWEY7VMlTHfEDmF5uOPjAJonQahS0jYWd0LuSZTPD+eBOTXOe6e76+tdj8qAUfy3jlhIoMsrzrDjONKd0dOW43qcnw/w54L1IG/Pu2T5NIdFtWFcIH+V4LUmTXu2e2JR50qHZ5otXhzdqdOMZ+LPcE6ajhl1CwB5GgV0UBiBE6m/zI+oHjuY1Zco9LrY8lG0AtMSyiexU09Qcgf+oJTjwG2ONfXGyR+ye3qXKxKI7r7DWCRvrIyNMDn9AzZMBCiRx687VCaRPSzyzyISrthKZziCazEen2uD3bTk1ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2GyCOMhyaHqpbDaRpkkU79nkm9uJTiN+30vP6cASmc=;
 b=JtC8DaiJcWeUYYktmSo2f+WF0Qb7JPPCbYOSJS7FUDgZA28pHx4XbdcuJxMFiZ3/4uf+F9NTZrhobRVDDWv9IdmYmhuqlytlIMws3VRw2TIpOAFAorsQ0YwLjXoQ7F8w72BqijP6BuRggkEqFwsCY0hnObIqQwu/8Nh1llc70u7wfJTg7BeL8cR/EG9kF8vPK/DneDqY8qKrvU8dBYfCS+6TU1uYuVv1+E8uUUJ9KuEB6FVIDm/0pyb/wnEUUYaNHI/VZPRB+n0WsKr9JTqa83YvyZOJwqivYi47AaI50p+j7VoskXOAihkR32bULRyzYmhMktpJEvgRG2J3umSSew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2GyCOMhyaHqpbDaRpkkU79nkm9uJTiN+30vP6cASmc=;
 b=Q724xJe3wsZxaY9W3uLV1QUmjteCQrLCzXBTldKNntwQYKdjMXODrk7DQQnW2OhqDrUeGkmd7kmHc+SG4JbOpwPz3YtrisJ/wlCrMM34qt0my2ehWMFpjZ89+TqquXFWu3WXbSoJcnOqYzm+0Qhat7CllgVWaaOLG1DCSs9MVm0=
Received: from DM6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:5:174::20)
 by BL0PR12MB2564.namprd12.prod.outlook.com (2603:10b6:207:49::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 8 Dec
 2021 06:37:02 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::fa) by DM6PR21CA0010.outlook.office365.com
 (2603:10b6:5:174::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.4 via Frontend
 Transport; Wed, 8 Dec 2021 06:37:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 06:37:02 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 8 Dec 2021 00:37:00 -0600
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] amdgpu/pm: Add Error Handling to emit_clocks stack
Date: Wed, 8 Dec 2021 01:36:09 -0500
Message-ID: <20211208063609.5593-4-darren.powell@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211208063609.5593-1-darren.powell@amd.com>
References: <20211208063609.5593-1-darren.powell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 845ba244-c05d-4186-9faf-08d9ba1524dc
X-MS-TrafficTypeDiagnostic: BL0PR12MB2564:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB25640A0C4728D11A6CC01FC5F06F9@BL0PR12MB2564.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RkGAG5zXIi0Gx3KSgenRIWnnSFFoi7zleXM3D+FO96a7BQYleW/ADff3u2rq3SYTc6pHu3kHIZ2c98JGXt3oZbTHFH3uZ/fUb1qWSJ7s8nbM97T8wglzwotOiKt4AU/rj+35F5fGcxAf0ZH++7jqboZhWiYytTiRuEJG0xcZdKlkYepC6/wZK5k4kVDhCcp/KKm/tDvgtlk+zW3OwpwT8GRTEOOFKttDj7/gE1EaXTben8rF/BiW8rvmtkjuOBgPT83DeojVdu7dMx5S+7qmoOKnSaNPzOZX8PJ0yb2scGjGY9jOe4PRhZ1OLGtt0bmVdz0Itn4Q7WsPUZrx6JBUWlit9dZees0B019wxsQa3s5zaDBu31HnyyzraoczC7EWcn6m3CLl2HIyC6VxinofEQRiay++xUpjQF0LAQXKfFI78WL4tc8LP64uoiki5oMJOE9YVeZa9nXkSDR9e9koCq8zI5QqMo7cGEepImLZh8C4+3dmhRTydqt2Tv2uSDutSronNqEyCaTUBkgZLlror4WCFpShKIdNSTMQR9NoXSpOl5gwxIVZV6TdcOdfM9ZMS3XZyOZDfQVVDu/x+hVB9mbNEOyOPuROizkLX+YXdtqleaamzNcyaGI1IZnjD7BegS+1JQKsUExebpd+KPpQxNwFLih4JvfarpT1Mstm24//igmFG+FeBMasG+cUFRSf/zZCQRFfhM8k2la6dSDc5ovlFHMxZ73v4tZ5wdtLYUknI2iMxDIuRojCWeX7eiX/fK3U8X/+peIHFYc0n36rPnnVi9+FTB6ILnp6ht32P5I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(316002)(5660300002)(26005)(4326008)(8676002)(86362001)(356005)(7696005)(44832011)(2616005)(508600001)(82310400004)(36860700001)(83380400001)(81166007)(16526019)(186003)(70206006)(1076003)(8936002)(40460700001)(36756003)(336012)(47076005)(70586007)(426003)(6916009)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 06:37:02.4216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 845ba244-c05d-4186-9faf-08d9ba1524dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2564
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
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 19 ++++++++---------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       | 10 ++++++++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  9 ++++----
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 21 +++++++++----------
 4 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 04992a3bc1d2..741e991baaca 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -927,17 +927,16 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 		return ret;
 	}
 
-	ret = -EOPNOTSUPP;
+	ret = -ENOENT;
 	if (adev->powerplay.pp_funcs->emit_clock_levels) {
-		ret = amdgpu_dpm_emit_clock_levels(adev, od_clocks[0], buf, &size);
+		for(clk_index = 0 ; clk_index < 6 ; clk_index++) {
+			ret = amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, &size);
+			if (ret)
+				break;
+		}
 	}
 
-	if (ret > 0) {
-		/* Proceed with emit for other od clocks if the first call succeeds */
-		for(clk_index = 1 ; clk_index < 6 ; clk_index++)
-			amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, &size);
-	}
-	else {
+	if (ret == -ENOENT) {
 		if (adev->powerplay.pp_funcs->print_clock_levels) {
 			size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
 			size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK, buf+size);
@@ -1092,12 +1091,12 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
 		return ret;
 	}
 
-	ret = -EOPNOTSUPP;
+	ret = -ENOENT;
 	if (adev->powerplay.pp_funcs->emit_clock_levels) {
 		ret = amdgpu_dpm_emit_clock_levels(adev, type, buf, &size);
 	}
 
-	if (ret < 0) {
+	if (ret == -ENOENT) {
 		if (adev->powerplay.pp_funcs->print_clock_levels) {
 			size = amdgpu_dpm_print_clock_levels(adev, type, buf);
 		}
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index dc1325783c10..7db6bec158d9 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -617,6 +617,11 @@ struct pptable_funcs {
 	 *                    to buffer. Star current level.
 	 *
 	 * Used for sysfs interfaces.
+	 * Return: Number of characters written to the buffer
+	 *
+	 * On Success the function will return 0 or a positive value to
+	 * record the number of characters written to the buffer. A negative
+	 * value is returned on error.
 	 */
 	int (*print_clk_levels)(struct smu_context *smu, enum smu_clk_type clk_type, char *buf);
 
@@ -626,7 +631,10 @@ struct pptable_funcs {
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
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index b0638d8308d2..6dab167928b0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2464,16 +2464,15 @@ static int smu_emit_ppclk_levels(void *handle, enum pp_clock_type type, char *bu
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->emit_clk_levels) {
+		mutex_lock(&smu->mutex);
 		ret = smu->ppt_funcs->emit_clk_levels(smu, clk_type, buf, offset);
+		mutex_unlock(&smu->mutex);
 	}
-	else {
-		ret = -EOPNOTSUPP;
-	}
+	else
+		ret = -ENOENT;
 
-	mutex_unlock(&smu->mutex);
 
 	return ret;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index e43c7e950a55..a9ba1cb35ddf 100644
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

