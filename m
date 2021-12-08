Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E90AC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 06:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 233126E96B;
	Wed,  8 Dec 2021 06:37:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 517616E96B
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 06:37:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLahP2LwoR2AK0u2xEiCe3ND99pRrsbsdL52ycqQL8NAsGB1ZH9uSOhFmb7QTmmyQNcmaCw9fX8e+s0IgPX2nq44IUsJfQm4Zp7OSqW4J/Ai+YsFe06BedqzeQ3s65XEEUJgzoXyBlR7UPfrBsRCodi2cYYNuxQTEsgh3sUQNYl5qdQfDM52YN3FLWwwCx+h8e2dD3BxiBnscW9HmFvXDqmXjjQ4+AsxsPFkJb9ztZxZX2wJ4rcvjhfUJ3S75taTKNw4iiitrR4hYxvRlvrgk5J9F5dlUUO4vVusBQFww5v6CwN4UYAAjitN2dlp1pZuTowZq+Oa33EOdaAWx0UR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bj6ovnR1QKZbKPZBftvcp90Ll3lQy6Wv3snRh5wdT4c=;
 b=kNU23MQD3tq3pgiwDIaFu6D0BBSuXMbhw/6Z+zSR6RIjt/oRNXUgtL/pZm+r0sJg/oE882H1uTuEZyiDB3D3i2AAmxlCCL00VLV7AD68qZitMLL/kiTry11Dj6onwb6uFN/xRqDPTXNwjZkSBKtn50V7u7QBEaoG8c1yF5JPNrLt785xtExSalF48tXjf1ENztcxdTtoRfK51k6MrEwuQgeHBeu9eKUTggxqIMO6eE+tQyEOxNFTlT2dpr14fPYP9/TPfg5g4ncUQfOnEjJRPk5YEKBIH2jJjHV7BCOBttgmyl3tJBpOj/hmTZCFsPRNfy2NSwRdoYxQY7Mw7ek8/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bj6ovnR1QKZbKPZBftvcp90Ll3lQy6Wv3snRh5wdT4c=;
 b=u6urtdLswh1hjQ53S7oUlPjtvS9fG3KHFrSVCRv1emkcobgd2lGulOJl3KzXZTAdVa143p6KYN0b0TjzrexZ0b6Xwtue1GddUmA8M8yCg//tHqEHmgdvZ6gF7+bbbS8+0c+8SySv6jq1uzRIfzCTXvl9rjMARgm8Vc6baZILJX8=
Received: from DM6PR21CA0004.namprd21.prod.outlook.com (2603:10b6:5:174::14)
 by MW2PR12MB2412.namprd12.prod.outlook.com (2603:10b6:907:b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Wed, 8 Dec
 2021 06:37:01 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::1c) by DM6PR21CA0004.outlook.office365.com
 (2603:10b6:5:174::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.3 via Frontend
 Transport; Wed, 8 Dec 2021 06:37:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 06:37:00 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 8 Dec 2021 00:36:59 -0600
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] amdgpu/pm: Implement new API function "emit" that accepts
 buffer base and write offset
Date: Wed, 8 Dec 2021 01:36:07 -0500
Message-ID: <20211208063609.5593-2-darren.powell@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e8f4f100-901c-488c-5fb9-08d9ba1523f5
X-MS-TrafficTypeDiagnostic: MW2PR12MB2412:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB241261816BC3EFABF7B665C0F06F9@MW2PR12MB2412.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t7a+9dB5WA0PztoW3JbDkEOFQuvpEYEfwaobMUiMD/4WeeQUUlUqEpCyTEkbKmv5XQoJuRnEPC9Iu6UgZ4+6Gv3j34q+Slac7vyh8iuroldml8/C6KBvtGUKHdUuZsqo0LVYbGEoLFdGw3mBThj4tytUKxlqkXYknbJGm1rcOh135Gil3uz4b0QQCml1ggvDe3ByH+/CYALnm8FDI+D7T6J8uuZ1/pl9FG8I+hPfPc6MvZc3wOk0cy896ddDn2wQ7pq5pRVod0NbAiinfsO+W2mvHGZiHXxn0ejqEsQ4r2Pdumt9tOGXCCKzhwQSdQvs1DGE9oC9qljU4WU35y1hZwl/8vONtyke0lGOHpcqU5rVcimSexmHBxNK8Hp0f3701zV7aMVQB0Pf7OktHHNtFdelWH0C9NtVKzmaKCZcjbngtVWl/zCtSIaUcLs2xb6T6wDNSQKlpI//877k8yhLDKBFxoTwxLaxoADPNxOz/yiNnTisjyyx40wvkvhKv/EmlnSRzhrwE+dl/eUxoV55ydxPQFbL+UhXLqwosCX6N4Qt3OHHh73AktuNiPx300K7pR366rXipJuIuN2zi1SjT5T9ZfUZL26gHOpheCaG2oiz3yawTLjtjQpuF4vx7P/ekZ/yopmP7Y6xHjvDephXh6pxrMvny3IdTSK8WvfdQwEqKSiMegA68/yE8Mnr0m6ZkXeK9EUn4PdEKpyhiWRb8lAI1RkTTjiau08DRXw0uQy8tcbkanWUv998K5cwtSVKXBCqgdDQNJ7vLkqzf2HN1HRjq75riIWYcFw7GO+tdhU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(36860700001)(426003)(316002)(2906002)(7696005)(83380400001)(70586007)(6666004)(70206006)(336012)(81166007)(8676002)(1076003)(2616005)(508600001)(30864003)(5660300002)(4326008)(82310400004)(16526019)(8936002)(86362001)(44832011)(40460700001)(36756003)(6916009)(186003)(356005)(47076005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 06:37:00.9061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f4f100-901c-488c-5fb9-08d9ba1523f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2412
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
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  20 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   3 +
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  10 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  50 ++++-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 189 ++++++++++++++++++
 6 files changed, 262 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index bac15c466733..43f43a4f321b 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -310,6 +310,7 @@ struct amd_pm_funcs {
 	int (*get_fan_speed_pwm)(void *handle, u32 *speed);
 	int (*force_clock_level)(void *handle, enum pp_clock_type type, uint32_t mask);
 	int (*print_clock_levels)(void *handle, enum pp_clock_type type, char *buf);
+	int (*emit_clock_levels)(void *handle, enum pp_clock_type type, char *buf, int *offset);
 	int (*force_performance_level)(void *handle, enum amd_dpm_forced_level level);
 	int (*get_sclk_od)(void *handle);
 	int (*set_sclk_od)(void *handle, uint32_t value);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 49df4c20f09e..a1169a2397ca 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1056,8 +1056,8 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	ssize_t size;
-	int ret;
+	int size = 0;
+	int ret = 0;
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
@@ -1070,10 +1070,18 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
 		return ret;
 	}
 
-	if (adev->powerplay.pp_funcs->print_clock_levels)
-		size = amdgpu_dpm_print_clock_levels(adev, type, buf);
-	else
-		size = sysfs_emit(buf, "\n");
+	ret = -EOPNOTSUPP;
+	if (adev->powerplay.pp_funcs->emit_clock_levels) {
+		ret = amdgpu_dpm_emit_clock_levels(adev, type, buf, &size);
+	}
+
+	if (ret < 0) {
+		if (adev->powerplay.pp_funcs->print_clock_levels) {
+			size = amdgpu_dpm_print_clock_levels(adev, type, buf);
+		}
+		else
+			size = sysfs_emit(buf, "\n");
+	}
 
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 16e3f72d31b9..95add7afcc86 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -310,6 +310,9 @@ enum amdgpu_pcie_gen {
 #define amdgpu_dpm_print_clock_levels(adev, type, buf) \
 		((adev)->powerplay.pp_funcs->print_clock_levels((adev)->powerplay.pp_handle, type, buf))
 
+#define amdgpu_dpm_emit_clock_levels(adev, type, buf, offset) \
+		((adev)->powerplay.pp_funcs->emit_clock_levels((adev)->powerplay.pp_handle, type, buf, offset))
+
 #define amdgpu_dpm_force_clock_level(adev, type, level) \
 		((adev)->powerplay.pp_funcs->force_clock_level((adev)->powerplay.pp_handle, type, level))
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index f738f7dc20c9..dc1325783c10 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -620,6 +620,16 @@ struct pptable_funcs {
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
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index e156add7b560..b0638d8308d2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2397,11 +2397,8 @@ static int smu_print_smuclk_levels(struct smu_context *smu, enum smu_clk_type cl
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
@@ -2434,12 +2431,54 @@ static int smu_print_ppclk_levels(void *handle,
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
+	mutex_lock(&smu->mutex);
+
+	if (smu->ppt_funcs->emit_clk_levels) {
+		ret = smu->ppt_funcs->emit_clk_levels(smu, clk_type, buf, offset);
+	}
+	else {
+		ret = -EOPNOTSUPP;
+	}
+
+	mutex_unlock(&smu->mutex);
+
+	return ret;
+
+}
+
 static int smu_od_edit_dpm_table(void *handle,
 				 enum PP_OD_DPM_TABLE_COMMAND type,
 				 long *input, uint32_t size)
@@ -3117,6 +3156,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.get_fan_speed_pwm   = smu_get_fan_speed_pwm,
 	.force_clock_level       = smu_force_ppclk_levels,
 	.print_clock_levels      = smu_print_ppclk_levels,
+	.emit_clock_levels       = smu_emit_ppclk_levels,
 	.force_performance_level = smu_force_performance_level,
 	.read_sensor             = smu_read_sensor,
 	.get_performance_level   = smu_get_performance_level,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 60a557068ea4..e43c7e950a55 100644
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
@@ -3245,6 +3433,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.i2c_init = navi10_i2c_control_init,
 	.i2c_fini = navi10_i2c_control_fini,
 	.print_clk_levels = navi10_print_clk_levels,
+	.emit_clk_levels = navi10_emit_clk_levels,
 	.force_clk_levels = navi10_force_clk_levels,
 	.populate_umd_state_clk = navi10_populate_umd_state_clk,
 	.get_clock_by_type_with_latency = navi10_get_clock_by_type_with_latency,
-- 
2.34.1

