Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C52C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 08:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14F1610EA9B;
	Wed, 11 May 2022 08:48:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78B7210F91F
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 08:48:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8+kU76idR64AWkgGfZxzsLTJyh6NF1gMW1ckbyot8nPatEaeonJ7T3RsiEbBR557Nf06fsM4bMopI1y9qKE4OI+PnCvQWl4yfbxxi7zBoo3NgscdgtLqWgl9/muTwUuHO/L4t0apmVJXtXzYHp+nSnYjDxt3nID1rHT+O/zewwBrtA08FKlKtB0qhacELvgPTce2x4rAIwF026QXBESQzwl4pFJPIVaYIEmuK/kfVJyZC4tH0RgWuaKoTX9exJIMYga56l+nrE8XeoUpqZmY6uii4L32wAVS815b96+BWA1UB93YPrXRPElds/aUWA2OfR8CWov9nBFPr2Hf19TPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUTR9y54YF0F37Mkm6iRDpWJqUgFuTqMj3bBRrZrK7g=;
 b=H3rnu8O6hqUcL8BcV4/kUgxa//s2hlyUCBTSb+5EIcHj9lswJIbY8nU5RjZ+k/IrKBRtrclXnQs0FmnMJpu/zGHqSXtleWYExoFlGcbac5+MU28RYQkcgVVHnNUxZ4F7FqFVVOr0VeHLwIaFwrhVJpNMJ9jxdjZG+IueXu8tlS6lh2ocrTPdyj5tOBTiawzbM4tsM1+gIMiSdyR31bDdOq1ua/RHBCkAIQbxxpKceRzKNC0prqgI69GWibHQNX9EHHb9sxnMP6rNIs3CxmkrpAMHr3nWi/J69P9F0ehS25d0mnM6IxQ691VYjvvOFI4SqZQDabhPt/vImozJ5dmOqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUTR9y54YF0F37Mkm6iRDpWJqUgFuTqMj3bBRrZrK7g=;
 b=30x2JV4UHo1xM8Mf+/PrW+G6I9WaXelMBFqlHzq8mxdvnH4T4PyZ3uIDuqXlh2K4eB6QzcyCJo4IUJtv+DF4SXBSLDsxjES1/YjeeSWgDQHMJw7danL7YznDPYHTBsdleicgH7mfbMSASSW287cIbQGeL4PubqQq8uFz5CS3oe0=
Received: from BN8PR16CA0003.namprd16.prod.outlook.com (2603:10b6:408:4c::16)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 08:48:32 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::e6) by BN8PR16CA0003.outlook.office365.com
 (2603:10b6:408:4c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Wed, 11 May 2022 08:48:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 08:48:31 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 03:48:29 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: consistent approach for smartshift
Date: Wed, 11 May 2022 14:18:14 +0530
Message-ID: <20220511084814.2077848-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8561d46-9762-4b68-0a82-08da332b06dd
X-MS-TrafficTypeDiagnostic: CH2PR12MB4166:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB41662B86D622AF2985EFD12C9DC89@CH2PR12MB4166.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MIT8rO0lInqxlyzpYyMdrxVo0VayYgZ7XzYeEKmRmB38i6AgQVXsxoXm9/gsPIaJpAPf2BD+TPqFh3PJTPSJe/wWV6CYBhkZYlLHKxm8QXX4j6vHR8bbDZeWKkLsUu4e/AEV7WAbH6UBitkyXsKm9gg+A9eQZFv7PqkTZojnlLJtZFznN/uuugBrnLrYL8FwGHiLxV+2iLy7vEPih18eiBG0wpiBkbhhnI0Fmok42dkqYLLnPZaDlNqPQFCmtUxYplDM5kpENh5cDKXdXy84KJ+JgiMi7Psft8rA7VxjT0CCfw0yxM29iBcEhLyRVLZz5shgWNI5Zq5kNLB7Kyz1M/dC5JBsHnt9gXo7M9kDxfh4fgDzka24tfa+aRTu6Gc+Xi7bzTgoCRuKv8s9ZLXNVsPChxOHWaRoQW2ByI6lAA21JhhWahLWffni2oiHga2xAI51aWEG7BBdK1QREAnbyBIpglc6XKehmw/h94VBcl0GE7Z4b0VbW7mAWt8HvGoztWQGQGeM84zPuyRkNDvGBNQDl+qV8mIPj9O487kayYcN8cv006oS2HEsiTzaTtBZiAdqUP9q68wwuQDNVzg9B2jzLkgZ3M7Jm50fW0rdQ/rqcPruQhFoqCTGqcH2J17MP7ygZcpAL1spe9voNjN109K+NPBX0MYIjgdh3RB9GG7/hhNuWtbanLSJWID7qdNQzOav41mbHnBQVoXdteXU0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2616005)(1076003)(16526019)(5660300002)(336012)(186003)(426003)(47076005)(83380400001)(70206006)(316002)(4326008)(8676002)(30864003)(2906002)(70586007)(36756003)(8936002)(7696005)(356005)(86362001)(40460700003)(508600001)(26005)(6916009)(6666004)(36860700001)(81166007)(82310400005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 08:48:31.7325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8561d46-9762-4b68-0a82-08da332b06dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 Lazar Lijo <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

always create smartshift attributes from dgpu device even on SS1.0.
consider units of power in metrics table and convert if necessary.
powershift value is in percentage and values to range between 0-100.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 146 +++++++++++-------
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  54 +++++--
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  54 +++++--
 3 files changed, 166 insertions(+), 88 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d3228216b2da..c2406baeef93 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1734,22 +1734,11 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 	return size;
 }
 
-/**
- * DOC: smartshift_apu_power
- *
- * The amdgpu driver provides a sysfs API for reporting APU power
- * share if it supports smartshift. The value is expressed as
- * the proportion of stapm limit where stapm limit is the total APU
- * power limit. The result is in percentage. If APU power is 130% of
- * STAPM, then APU is using 30% of the dGPU's headroom.
- */
-
-static ssize_t amdgpu_get_smartshift_apu_power(struct device *dev, struct device_attribute *attr,
-					       char *buf)
+static int amdgpu_read_powershift_percent(struct amdgpu_device *adev,
+						uint32_t *ss_power, bool dgpu_share)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	uint32_t ss_power, size;
+	struct drm_device *ddev = adev_to_drm(adev);
+	uint32_t size;
 	int r = 0;
 
 	if (amdgpu_in_reset(adev))
@@ -1763,28 +1752,64 @@ static ssize_t amdgpu_get_smartshift_apu_power(struct device *dev, struct device
 		return r;
 	}
 
-	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
-				   (void *)&ss_power, &size);
-	if (r)
-		goto out;
-
-	r = sysfs_emit(buf, "%u%%\n", ss_power);
+	if (dgpu_share)
+		r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
+				   (void *)ss_power, &size);
+	else
+		r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
+				   (void *)ss_power, &size);
 
-out:
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 	return r;
 }
+/**
+ * DOC: smartshift_apu_power
+ *
+ * The amdgpu driver provides a sysfs API for reporting APU power
+ * shift in percentage if platform supports smartshift. Value 0 means that
+ * there is no powershift and values between [1-100] means that the power
+ * is shifted to APU, the percentage of boost is with respect to APU power
+ * limit on the platform.
+ */
+
+static ssize_t amdgpu_get_smartshift_apu_power(struct device *dev, struct device_attribute *attr,
+					       char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	uint32_t ss_power = 0;
+	int r = 0, i;
+
+	r = amdgpu_read_powershift_percent(adev, &ss_power, false);
+	if (!r)
+		r = sysfs_emit(buf, "%u%%\n", ss_power);
+	else if (r == -EOPNOTSUPP) {
+		/* sensor not available on dGPU, try to read from APU */
+		adev = NULL;
+		mutex_lock(&mgpu_info.mutex);
+		for (i = 0; i < mgpu_info.num_gpu; i++) {
+			if (mgpu_info.gpu_ins[i].adev->flags & AMD_IS_APU) {
+				adev = mgpu_info.gpu_ins[i].adev;
+				break;
+			}
+		}
+		mutex_unlock(&mgpu_info.mutex);
+		if (adev && !amdgpu_read_powershift_percent(adev, &ss_power, false))
+			r = sysfs_emit(buf, "%u%%\n", ss_power);
+	}
+
+	return r;
+}
 
 /**
  * DOC: smartshift_dgpu_power
  *
- * The amdgpu driver provides a sysfs API for reporting the dGPU power
- * share if the device is in HG and supports smartshift. The value
- * is expressed as the proportion of stapm limit where stapm limit
- * is the total APU power limit. The value is in percentage. If dGPU
- * power is 20% higher than STAPM power(120%), it's using 20% of the
- * APU's power headroom.
+ * The amdgpu driver provides a sysfs API for reporting dGPU power
+ * shift in percentage if platform supports smartshift. Value 0 means that
+ * there is no powershift and values between [1-100] means that the power is
+ * shifted to dGPU, the percentage of boost is with respect to dGPU power
+ * limit on the platform.
  */
 
 static ssize_t amdgpu_get_smartshift_dgpu_power(struct device *dev, struct device_attribute *attr,
@@ -1792,31 +1817,27 @@ static ssize_t amdgpu_get_smartshift_dgpu_power(struct device *dev, struct devic
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	uint32_t ss_power, size;
-	int r = 0;
+	uint32_t ss_power = 0;
+	int r = 0, i;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	r = pm_runtime_get_sync(ddev->dev);
-	if (r < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return r;
+	r = amdgpu_read_powershift_percent(adev, &ss_power, true);
+	if (!r)
+		r = sysfs_emit(buf, "%u%%\n", ss_power);
+	else if (r == -EOPNOTSUPP) {
+		/* sensor not available on dGPU, try to read from APU */
+		adev = NULL;
+		mutex_lock(&mgpu_info.mutex);
+		for (i = 0; i < mgpu_info.num_gpu; i++) {
+			if (mgpu_info.gpu_ins[i].adev->flags & AMD_IS_APU) {
+				adev = mgpu_info.gpu_ins[i].adev;
+				break;
+			}
+		}
+		mutex_unlock(&mgpu_info.mutex);
+		if (adev && !amdgpu_read_powershift_percent(adev, &ss_power, true))
+			r = sysfs_emit(buf, "%u%%\n", ss_power);
 	}
 
-	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
-				   (void *)&ss_power, &size);
-
-	if (r)
-		goto out;
-
-	r = sysfs_emit(buf, "%u%%\n", ss_power);
-
-out:
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
 	return r;
 }
 
@@ -1884,18 +1905,23 @@ static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
 static int ss_power_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
 				uint32_t mask, enum amdgpu_device_attr_states *states)
 {
-	uint32_t ss_power, size;
+	struct pci_dev *pdev = NULL;
+	unsigned short devices = 0;
 
-	if (!amdgpu_acpi_is_power_shift_control_supported())
-		*states = ATTR_STATE_UNSUPPORTED;
-	else if ((adev->flags & AMD_IS_PX) &&
-		 !amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
-		*states = ATTR_STATE_UNSUPPORTED;
-	else if (amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
-		 (void *)&ss_power, &size))
+	if (!amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
 		*states = ATTR_STATE_UNSUPPORTED;
-	else if (amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
-		 (void *)&ss_power, &size))
+
+	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev)) != NULL) {
+		if (pdev->vendor == 0x1002)
+			devices++;
+	}
+	pdev = NULL;
+	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_OTHER << 8, pdev)) != NULL) {
+		if (pdev->vendor == 0x1002)
+			devices++;
+	}
+
+	if (devices < 2)
 		*states = ATTR_STATE_UNSUPPORTED;
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index fd6c44ece168..a781c63b10aa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1119,6 +1119,39 @@ static int renoir_get_power_profile_mode(struct smu_context *smu,
 	return size;
 }
 
+static void renoir_get_ss_power_percent(SmuMetrics_t *metrics,
+					uint32_t *apu_percent, uint32_t *dgpu_percent)
+{
+	uint32_t apu_boost = 0;
+	uint32_t dgpu_boost = 0;
+	uint16_t apu_limit = 0;
+	uint16_t dgpu_limit = 0;
+	uint16_t apu_power = 0;
+	uint16_t dgpu_power = 0;
+
+	apu_power = metrics->ApuPower;
+	apu_limit = metrics->StapmOriginalLimit;
+	if (apu_power > apu_limit && apu_limit != 0)
+		apu_boost =  ((apu_power - apu_limit) * 100) / apu_limit;
+	apu_boost = (apu_boost > 100) ? 100 : apu_boost;
+
+	dgpu_power = metrics->dGpuPower;
+	if (metrics->StapmCurrentLimit > metrics->StapmOriginalLimit)
+		dgpu_limit = metrics->StapmCurrentLimit - metrics->StapmOriginalLimit;
+	if (dgpu_power > dgpu_limit && dgpu_limit != 0)
+		dgpu_boost = ((dgpu_power - dgpu_limit) * 100) / dgpu_limit;
+	dgpu_boost = (dgpu_boost > 100) ? 100 : dgpu_boost;
+
+	if (dgpu_boost >= apu_boost)
+		apu_boost = 0;
+	else
+		dgpu_boost = 0;
+
+	*apu_percent = apu_boost;
+	*dgpu_percent = dgpu_boost;
+}
+
+
 static int renoir_get_smu_metrics_data(struct smu_context *smu,
 				       MetricsMember_t member,
 				       uint32_t *value)
@@ -1127,6 +1160,9 @@ static int renoir_get_smu_metrics_data(struct smu_context *smu,
 
 	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
 	int ret = 0;
+	uint32_t apu_percent = 0;
+	uint32_t dgpu_percent = 0;
+
 
 	ret = smu_cmn_get_metrics_table(smu,
 					NULL,
@@ -1172,25 +1208,15 @@ static int renoir_get_smu_metrics_data(struct smu_context *smu,
 		break;
 	case METRICS_SS_APU_SHARE:
 		/* return the percentage of APU power with respect to APU's power limit.
-		 * percentage is reported, this isn't boost value. Smartshift power
-		 * boost/shift is only when the percentage is more than 100.
 		 */
-		if (metrics->StapmOriginalLimit > 0)
-			*value =  (metrics->ApuPower * 100) / metrics->StapmOriginalLimit;
-		else
-			*value = 0;
+		renoir_get_ss_power_percent(metrics, &apu_percent, &dgpu_percent);
+		*value = apu_percent;
 		break;
 	case METRICS_SS_DGPU_SHARE:
 		/* return the percentage of dGPU power with respect to dGPU's power limit.
-		 * percentage is reported, this isn't boost value. Smartshift power
-		 * boost/shift is only when the percentage is more than 100.
 		 */
-		if ((metrics->dGpuPower > 0) &&
-		    (metrics->StapmCurrentLimit > metrics->StapmOriginalLimit))
-			*value = (metrics->dGpuPower * 100) /
-				  (metrics->StapmCurrentLimit - metrics->StapmOriginalLimit);
-		else
-			*value = 0;
+		renoir_get_ss_power_percent(metrics, &apu_percent, &dgpu_percent);
+		*value = dgpu_percent;
 		break;
 	default:
 		*value = UINT_MAX;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index e2d099409123..ac3d4b0863d0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -276,6 +276,40 @@ static int yellow_carp_mode2_reset(struct smu_context *smu)
 	return yellow_carp_mode_reset(smu, SMU_RESET_MODE_2);
 }
 
+
+static void yellow_carp_get_ss_power_percent(SmuMetrics_t *metrics,
+					uint32_t *apu_percent, uint32_t *dgpu_percent)
+{
+	uint32_t apu_boost = 0;
+	uint32_t dgpu_boost = 0;
+	uint16_t apu_limit = 0;
+	uint16_t dgpu_limit = 0;
+	uint16_t apu_power = 0;
+	uint16_t dgpu_power = 0;
+
+	apu_power = metrics->ApuPower/1000;
+	apu_limit = metrics->StapmOpnLimit;
+	if (apu_power > apu_limit && apu_limit != 0)
+		apu_boost =  ((apu_power - apu_limit) * 100) / apu_limit;
+	apu_boost = (apu_boost > 100) ? 100 : apu_boost;
+
+	dgpu_power = metrics->dGpuPower/1000;
+	if (metrics->StapmCurrentLimit > metrics->StapmOpnLimit)
+		dgpu_limit = metrics->StapmCurrentLimit - metrics->StapmOpnLimit;
+	if (dgpu_power > dgpu_limit && dgpu_limit != 0)
+		dgpu_boost = ((dgpu_power - dgpu_limit) * 100) / dgpu_limit;
+	dgpu_boost = (dgpu_boost > 100) ? 100 : dgpu_boost;
+
+	if (dgpu_boost >= apu_boost)
+		apu_boost = 0;
+	else
+		dgpu_boost = 0;
+
+	*apu_percent = apu_boost;
+	*dgpu_percent = dgpu_boost;
+
+}
+
 static int yellow_carp_get_smu_metrics_data(struct smu_context *smu,
 							MetricsMember_t member,
 							uint32_t *value)
@@ -284,6 +318,8 @@ static int yellow_carp_get_smu_metrics_data(struct smu_context *smu,
 
 	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
 	int ret = 0;
+	uint32_t apu_percent = 0;
+	uint32_t dgpu_percent = 0;
 
 	ret = smu_cmn_get_metrics_table(smu, NULL, false);
 	if (ret)
@@ -333,25 +369,15 @@ static int yellow_carp_get_smu_metrics_data(struct smu_context *smu,
 		break;
 	case METRICS_SS_APU_SHARE:
 		/* return the percentage of APU power with respect to APU's power limit.
-		 * percentage is reported, this isn't boost value. Smartshift power
-		 * boost/shift is only when the percentage is more than 100.
 		 */
-		if (metrics->StapmOpnLimit > 0)
-			*value =  (metrics->ApuPower * 100) / metrics->StapmOpnLimit;
-		else
-			*value = 0;
+		yellow_carp_get_ss_power_percent(metrics, &apu_percent, &dgpu_percent);
+		*value = apu_percent;
 		break;
 	case METRICS_SS_DGPU_SHARE:
 		/* return the percentage of dGPU power with respect to dGPU's power limit.
-		 * percentage is reported, this isn't boost value. Smartshift power
-		 * boost/shift is only when the percentage is more than 100.
 		 */
-		if ((metrics->dGpuPower > 0) &&
-		    (metrics->StapmCurrentLimit > metrics->StapmOpnLimit))
-			*value = (metrics->dGpuPower * 100) /
-				  (metrics->StapmCurrentLimit - metrics->StapmOpnLimit);
-		else
-			*value = 0;
+		yellow_carp_get_ss_power_percent(metrics, &apu_percent, &dgpu_percent);
+		*value = dgpu_percent;
 		break;
 	default:
 		*value = UINT_MAX;
-- 
2.25.1

